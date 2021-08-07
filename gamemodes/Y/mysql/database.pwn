
#include <YSI_Coding\y_hooks> 

stock MySQL:MySQL_GetHandle()
{
	return dbCon;
}

hook OnGameModeInit() {

    //‡ª‘¥‚À¡¥ DEBUG 
    mysql_log(ERROR | WARNING);

	dbCon = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);

	if (mysql_errno(dbCon)) {
		print("[SQL] Connection failed! Please check the connection settings...\a");
		SendRconCommand("exit");
		return 1;
	}
	else 
	{
		mysql_set_charset(MYSQL_CHARSET, dbCon);
		print("[SQL] Connection passed!");
	}
	return 1;
}

hook OnGameModeExit() {
    if(dbCon)
    mysql_close(dbCon);
	return 1;
}

//==================== [ MySQL Function ] ==========================

#define MYSQL_MAX_STRING			64
#define MYSQL_TYPE_SINGLE			0
#define MYSQL_TYPE_THREAD			1

#define MYSQL_QUERY(%0,%1)              			\
    if(gUpdateThreadType) { mysql_query(%0, %1); }		\
	else mysql_tquery(%0, %1)

static 
	gUpdateTableName[MYSQL_MAX_STRING],
	gUpdateColumnName[MYSQL_MAX_STRING],
	gUpdateRowID,
	gUpdateThreadType;

stock mysql_init(const table_name[], const column_name[], row_id, type = MYSQL_TYPE_SINGLE) {
	format(gUpdateTableName, MYSQL_MAX_STRING, table_name);
	format(gUpdateColumnName, MYSQL_MAX_STRING, column_name);
	gUpdateRowID = row_id;
	gUpdateThreadType = type;
}

static stock mysql_build(query[]) 
{
	new queryLen = strlen(query), whereclause[MYSQL_MAX_STRING], queryMax = MAX_STRING;
	if (queryLen < 1) format(query, queryMax, "UPDATE `%s` SET ", gUpdateTableName);
	else if (queryMax-queryLen < 80)
	{
		format(whereclause, MYSQL_MAX_STRING, " WHERE `%s`=%d", gUpdateColumnName, gUpdateRowID);
		strcat(query, whereclause, queryMax);

		MYSQL_QUERY(dbCon, query);

		format(query, queryMax, "UPDATE `%s` SET ", gUpdateTableName);
	}
	else if (strfind(query, "=", true) != -1) strcat(query, ",", MAX_STRING);
	return 1;
}

stock mysql_finish(query[]) 
{
	new whereclause[MYSQL_MAX_STRING];
	format(whereclause, MYSQL_MAX_STRING, "WHERE `%s`=", gUpdateColumnName);
	if (strcmp(query, whereclause, false) == 0) {
		MYSQL_QUERY(dbCon, query);
	}
	else
	{
		format(whereclause, MYSQL_MAX_STRING, " WHERE `%s`=%d", gUpdateColumnName, gUpdateRowID);
		strcat(query, whereclause, MAX_STRING);

		MYSQL_QUERY(dbCon, query);

		gUpdateTableName[0] = '\0';
		gUpdateColumnName[0] = '\0';
		gUpdateRowID = 0;
		gUpdateThreadType = MYSQL_TYPE_SINGLE;
	}
	return 1;
}

stock mysql_int(query[], const sqlvalname[], sqlupdateint) 
{
	mysql_build(query);
	strcat(query, sprintf("`%s`=%d", sqlvalname, sqlupdateint), MAX_STRING);
	return 1;
}

stock mysql_bool(query[], const sqlvalname[], bool:sqlupdatebool) 
{
	mysql_build(query);
	strcat(query, sprintf("`%s`=%d", sqlvalname, sqlupdatebool), MAX_STRING);
	return 1;
}

stock mysql_flo(query[], const sqlvalname[], Float:sqlupdateflo) 
{
	mysql_build(query);
	strcat(query, sprintf("`%s`=%f", sqlvalname, sqlupdateflo), MAX_STRING);
	return 1;
}

stock mysql_str(query[], const sqlvalname[], const sqlupdatestr[]) 
{
	mysql_build(query);
	new updval[128];
	mysql_format(dbCon, updval, sizeof(updval), "`%s`='%e'", sqlvalname, sqlupdatestr);
	strcat(query, updval, MAX_STRING);
	return 1;
}
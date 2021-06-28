#include <YSI_Coding\y_hooks>

static
    loginAttempt[MAX_PLAYERS], 
    g_MysqlRaceCheck[MAX_PLAYERS];

hook OnPlayerDisconnect(playerid, reason) {
	loginAttempt[playerid]=0;
	g_MysqlRaceCheck[playerid]++;
    return 1;
}

forward OnPlayerJoin(playerid);
public OnPlayerJoin(playerid)
{
	new rows;
	cache_get_value_index_int(0, 0, rows);
	if(rows) Auth_Login(playerid);
	else Auth_Register(playerid);
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW2, "ขอบคุณสำหรับการลงทะเบียน! คุณสามารถเข้าสู่ระบบได้แล้ว");
    Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "เข้าสู่ระบบ", "ขอบคุณสำหรับการลงทะเบียน, %s\n\nป้อนรหัสผ่านด้านล่างนี้เพื่อเข้าใช้งาน:", "เข้าสู่ระบบ", "ออก", ReturnPlayerName(playerid));
	return 1;
}

forward OnPlayerLogin(playerid, race_check);
public OnPlayerLogin(playerid, race_check)
{
	if (race_check != g_MysqlRaceCheck[playerid]) 
		return Kick(playerid);

	new pPass[129], unhashed_pass[129];
	GetPVarString(playerid, "Unhashed_Pass",unhashed_pass, 129);
	if(cache_num_rows())
	{
		cache_get_value_index(0, 0, pPass, 129);
		cache_get_value_index_int(0, 1, e_pAccountData[playerid][mDBID]);
        cache_get_value_index(0, 2, e_pAccountData[playerid][mAccName], 60);
		cache_get_value_index(0, 3, e_pAccountData[playerid][mForumName], 60);
		
        if (strequal(unhashed_pass, pPass, true)) {
            DeletePVar(playerid, "Unhashed_Pass");

            cache_get_value_name_int(0, "admin", PlayerInfo[playerid][pAdmin]);
            ShowCharacterSelection(playerid);

        }
        else {

			if(loginAttempt[playerid] == DEFAULT_PLAYER_LOGIN_ATTEMPT) {
				SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: "EMBED_WHITE"คุณกรอกรหัสผ่านผิดมากเกินไป");
				KickEx(playerid);
				return 1;
			}
			loginAttempt[playerid]++;
			
			Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "เข้าสู่ระบบ",""EMBED_RED"ERROR:"EMBED_DIALOG" รหัสผ่านไม่ถูกต้อง\n\n"EMBED_DIALOG"โปรดกรอกรหัสผ่านของคุณด้านล่างนี้เพื่อเข้าสู่ระบบ:\n\n"EMBED_RED"ความล้มเหลวในการเข้าสู่ระบบ (%d/%d)","เข้าสู่ระบบ","ออก", DEFAULT_PLAYER_LOGIN_ATTEMPT - loginAttempt[playerid], DEFAULT_PLAYER_LOGIN_ATTEMPT);
		}
	}
    else {
        printf("ERROR: %s can't log-in", ReturnPlayerName(playerid));
    }
	return 1;
}

Auth_Login(playerid) {
    Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "เข้าสู่ระบบ", "สวัสดี, %s\n\nป้อนรหัสผ่านด้านล่างนี้เพื่อเข้าใช้งาน:", "เข้าสู่ระบบ", "ออก", ReturnPlayerName(playerid));
    return 1;
}

Auth_Register(playerid) {

	#if defined IN_GAME_REGISTER

    	Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "สมัครสมาชิก", "บัญชีนี้ยังไม่มีอยู่ในฐานข้อมูล โปรดลงทะเบียนด้วยการกรอกรหัสผ่านด้านล่างนี้", "ลงทะเบียน", "ออก");

	#else

		SendClientMessageEx(playerid, COLOR_LIGHTRED, "ERROR: "EMBED_WHITE"ไม่พบบัญชีผู้ใช้ชื่อ %s", ReturnPlayerName(playerid));
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] "EMBED_WHITE"ตรวจสอบให้แน่ใจว่าคุณใช้ชื่อบัญชี(หลัก)ของคุณ ไม่ใช่ชื่อตัวละคร!");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] "EMBED_WHITE"ถ้าต้องการสร้างบัญชีผู้ใช้โปรดไปที่ http://yoursite.com/");
		KickEx(playerid);

	#endif

    return 1;
}

timer ShowLoginCamera[400](playerid)
{
	if(IsPlayerConnected(playerid) && BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED)) {
		SetPlayerVirtualWorld(playerid, playerid + 8000);
		SetPlayerCameraPos(playerid, 2559.6138,-1719.2664,37.2296);
		SetPlayerCameraLookAt(playerid, 2488.2173,-1665.3325,13.3438, CAMERA_CUT);
	}
}

Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[])
{
    if (!response)
        Kick(playerid);

    new query[128], buf[129];

    WP_Hash(buf, sizeof (buf), inputtext);
    SetPVarString(playerid, "Unhashed_Pass",buf);

	g_MysqlRaceCheck[playerid]++;
    mysql_format(dbCon, query, sizeof(query), "SELECT acc_pass, acc_dbid, acc_name, forum_name ,admin from `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
    mysql_tquery(dbCon, query, "OnPlayerLogin", "id", playerid, g_MysqlRaceCheck[playerid]);

    return 1;
}

Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[])
{
    if (!response)
        Kick(playerid);

    new
        buf[129];

    WP_Hash(buf, sizeof (buf), inputtext);

    new query[256];
    mysql_format(dbCon, query, sizeof(query), "INSERT INTO `masters` (acc_name, acc_pass) VALUES('%e', '%e')", ReturnPlayerName(playerid), buf);
	mysql_tquery(dbCon, query, "OnPlayerRegister", "d", playerid);

    return 1;
}

Dialog:DIALOG_SET_USERNAME(playerid, response, listitem, inputtext[])
{
	if (!response)
        Kick(playerid);
	
	if(strlen(inputtext) < 1 || strlen(inputtext) > 90)
		return Dialog_Show(playerid, DIALOG_SET_USERNAME, DIALOG_STYLE_INPUT, "ใส่ชื่อ Username ที่คุณต้องการ", "คุณใส่ชื่อ Usenrame ห้ามน้อยกว่า 1 หรือมากกว่า 90 ตัวอักษร โปรดใส่ใหม่:", "ยืนยน", "ยกเลิก");

	new maxusername = strlen(inputtext);

	for(new i=0; i<maxusername; i++)
	{
		if(inputtext[i] == '_')
		{
			return Dialog_Show(playerid, DIALOG_SET_USERNAME, DIALOG_STYLE_INPUT, "ใส่ชื่อ Username ที่คุณต้องการ", "ห้าม!ใส่เครื่องหมาย _ ลงไปในชื่อ Username ของคุณ:", "ยืนยน", "ยกเลิก");
		}
	}
	SetPlayerName(playerid, inputtext);

	new existCheck[129];
	
	mysql_format(dbCon, existCheck, sizeof(existCheck), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
	mysql_tquery(dbCon, existCheck, "OnPlayerJoin", "d", playerid);
	return 1;
}
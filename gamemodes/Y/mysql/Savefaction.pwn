stock SaveFactions()
{
	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(FactionInfo[i][eFactionDBID])
		{
			SaveFaction(i);
		}
	}
	return 1;
}

stock SaveFaction(id, thread = MYSQL_TYPE_THREAD)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new query[MAX_STRING];

	mysql_init("factions", "DBID", FactionInfo[id][eFactionDBID], thread);

	mysql_str(query, "FactionName",FactionInfo[id][eFactionName]);
	mysql_str(query, "FactionAbbrev",FactionInfo[id][eFactionAbbrev]);
	mysql_int(query, "FactionJoinRank",FactionInfo[id][eFactionJoinRank]);
	mysql_int(query, "FactionAlterRank",FactionInfo[id][eFactionAlterRank]);
	mysql_int(query, "FactionChatRank",FactionInfo[id][eFactionChatRank]);
	mysql_int(query, "FactionTowRank",FactionInfo[id][eFactionTowRank]);

	mysql_int(query, "FactionType",FactionInfo[id][eFactionType]);
	mysql_int(query, "FactionJob",FactionInfo[id][eFactionJob]);

	mysql_int(query, "FactionChatColor",FactionInfo[id][eFactionChatColor]);


	mysql_flo(query, "FactionSpawnX",FactionInfo[id][eFactionSpawn][0]);
	mysql_flo(query, "FactionSpawnY",FactionInfo[id][eFactionSpawn][1]);
	mysql_flo(query, "FactionSpawnZ",FactionInfo[id][eFactionSpawn][2]);
	mysql_int(query, "FactionWorld",FactionInfo[id][eFactionSpawnWorld]);
	mysql_int(query, "FactionInterior",FactionInfo[id][eFactionSpawnInt]);
	mysql_finish(query);
	return 1;
}

stock SaveFactionRanks(id, thread = MYSQL_TYPE_THREAD)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new query[250], str[10];

	mysql_init("faction_ranks", "factionid", FactionInfo[id][eFactionDBID], thread);

	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		format(str, sizeof(str), "FactionRank%d",i);
		mysql_str(query, str,FactionRanks[id][i]);
	}
	
	mysql_finish(query);
	return 1;
}
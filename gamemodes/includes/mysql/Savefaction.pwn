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

stock SaveFaction(id)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new threadSave[256];
	
	mysql_format(dbCon, threadSave, sizeof(threadSave), "UPDATE factions SET FactionName = '%e', FactionAbbrev = '%e', FactionJoinRank = %i, FactionAlterRank = %i, FactionChatRank = %i, FactionTowRank = %i, FactionType = %i, FactionChatColor = %i WHERE DBID = %i",
		FactionInfo[id][eFactionName],
		FactionInfo[id][eFactionAbbrev],
		FactionInfo[id][eFactionJoinRank],
		FactionInfo[id][eFactionAlterRank],
		FactionInfo[id][eFactionChatRank],
		FactionInfo[id][eFactionTowRank],
		FactionInfo[id][eFactionType],
		FactionInfo[id][eFactionChatColor],
		FactionInfo[id][eFactionDBID]);
	mysql_tquery(dbCon, threadSave);
	
	mysql_format(dbCon, threadSave, sizeof(threadSave), "UPDATE factions SET FactionSpawnX = %f, FactionSpawnY = %f, FactionSpawnZ = %f, FactionInterior = %i, FactionWorld = %i WHERE DBID = %i",
		FactionInfo[id][eFactionSpawn][0],
		FactionInfo[id][eFactionSpawn][1],
		FactionInfo[id][eFactionSpawn][2],
		FactionInfo[id][eFactionSpawnInt],
		FactionInfo[id][eFactionSpawnWorld],
		FactionInfo[id][eFactionDBID]);
	mysql_tquery(dbCon, threadSave);
	return 1;
}

stock SaveFactionRanks(id)
{
	if(!FactionInfo[id][eFactionDBID])
		return 0;
		
	new threadSave[256];
	
	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		mysql_format(dbCon, threadSave, sizeof(threadSave), "UPDATE faction_ranks SET FactionRank%i = '%e' WHERE factionid = %i", i, FactionRanks[id][i], FactionInfo[id][eFactionDBID]); 
		mysql_tquery(dbCon, threadSave);
	}
	
	return 1;
}
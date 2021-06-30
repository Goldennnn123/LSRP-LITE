
#define GANG (1)
#define GOVERMENT (2)

#define POLICE (1)
#define MEDIC (2)
#define SHERIFF (3)
#define SADCR (4)
#define GOV (5)

forward Query_InsertFaction(playerid, varName, varAbbrev, idx);
public Query_InsertFaction(playerid, varName, varAbbrev, idx)
{
	new insertRanks[90], str[128];
		
	mysql_format(dbCon, insertRanks, sizeof(insertRanks), "INSERT INTO faction_ranks (`factionid`) VALUES(%i)", cache_insert_id()); 
	mysql_tquery(dbCon, insertRanks); 
	
	FactionInfo[idx][eFactionDBID] = cache_insert_id();
		
	format(FactionInfo[idx][eFactionName], 90, "%s", varName);
	format(FactionInfo[idx][eFactionAbbrev], 30, "%s", varAbbrev); 
		
	format(str, sizeof(str), "%s ได้สร้างเฟคชั่น ไอดี:%d ขึ้นมา", ReturnName(playerid), cache_insert_id());
	SendAdminMessage(4, str);
	
	SendServerMessage(playerid, "สร้างเฟคชั่นสำเร็จโปรดพิมพ์ \"/factions\".เพื่อทำการแก้ไข (%d)",cache_insert_id()); 
	return 1;
}

forward Query_LoadFactions();
public Query_LoadFactions()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No factions were loaded from \"%s\" database...", MYSQL_DB);
		
	new newThread[128], rows; cache_get_row_count(rows);
	
	for (new i = 0; i < rows && i < MAX_FACTIONS; i ++)
	{
        cache_get_value_name_int(i,"DBID",FactionInfo[i+1][eFactionDBID]);
		
        cache_get_value_name(i,"FactionName",FactionInfo[i+1][eFactionName], 90);
		cache_get_value_name(i,"FactionAbbrev",FactionInfo[i+1][eFactionAbbrev], 90);
		
        cache_get_value_name_float(i,"FactionSpawnX",FactionInfo[i+1][eFactionSpawn][0]);
        cache_get_value_name_float(i,"FactionSpawnY",FactionInfo[i+1][eFactionSpawn][1]);
        cache_get_value_name_float(i,"FactionSpawnZ",FactionInfo[i+1][eFactionSpawn][2]);
		
        cache_get_value_name_int(i,"FactionInterior",FactionInfo[i+1][eFactionSpawnInt]);
        cache_get_value_name_int(i,"FactionWorld",FactionInfo[i+1][eFactionSpawnWorld]);
		
        cache_get_value_name_int(i,"FactionJoinRank",FactionInfo[i+1][eFactionJoinRank]);
        cache_get_value_name_int(i,"FactionAlterRank",FactionInfo[i+1][eFactionAlterRank]);
        cache_get_value_name_int(i,"FactionChatRank",FactionInfo[i+1][eFactionChatRank]);
        cache_get_value_name_int(i,"FactionTowRank",FactionInfo[i+1][eFactionTowRank]);
		
        cache_get_value_name_int(i,"FactionChatColor",FactionInfo[i+1][eFactionChatColor]);
		
        cache_get_value_name_int(i,"FactionType",FactionInfo[i+1][eFactionType]);
        cache_get_value_name_int(i,"FactionJob",FactionInfo[i+1][eFactionJob]);
		
		mysql_format(dbCon, newThread, sizeof(newThread), "SELECT * FROM faction_ranks WHERE factionid = %i", i+1); 
		mysql_tquery(dbCon, newThread, "Query_LoadFactionRanks", "i", i+1);
	}
	printf("[SERVER]: %i factions were loaded from \"%s\" database...", rows, MYSQL_DB);
	return 1;
}

forward OnPlayerEnterFaction(playerid, id);
public OnPlayerEnterFaction(playerid, id)
{
	SetPlayerPos(playerid, FactionInfo[id][eFactionSpawn][0], FactionInfo[id][eFactionSpawn][1], FactionInfo[id][eFactionSpawn][2]);
            
    SetPlayerVirtualWorld(playerid, FactionInfo[id][eFactionSpawnWorld]);
    SetPlayerInterior(playerid, FactionInfo[id][eFactionSpawnInt]);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

forward Query_LoadFactionRanks(factionid);
public Query_LoadFactionRanks(factionid)
{
	new str[128];
	
	new rows; cache_get_row_count(rows);
	
	for (new i = 0; i < rows; i++)
	{
		for (new j = 1; j < MAX_FACTION_RANKS; j++)
		{
			format(str, sizeof(str), "FactionRank%i", j); 
            cache_get_value_name(i,str,FactionRanks[factionid][j],60);
		}
	}
	return 1;
}

stock ReturnTotalMembers(factionid)
{
	if(factionid == 0 || !FactionInfo[factionid][eFactionDBID])
		return 0; 
		
	new threadCheck[128], counter;
	
	mysql_format(dbCon, threadCheck, sizeof(threadCheck), "SELECT COUNT(*) FROM characters WHERE pFaction = %i", factionid);
	mysql_query(dbCon, threadCheck); 
	
	cache_get_value_index_int(0, 0,counter);
	return counter;
}

stock ReturnOnlineMembers(factionid)
{
	new counter;
		
	foreach(new i : Player)
	{
		if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
			continue;
		
		if(PlayerInfo[i][pFaction] == factionid)
		{
			counter++;
		}
	}
	return counter;
}

stock ReturnFactionName(playerid)
{
	new factionName[90];
	
	if(!PlayerInfo[playerid][pFaction])
		factionName = "ไม่มีกลุ่มแก็ง";
		
	else
		format(factionName, sizeof(factionName), "%s", FactionInfo[PlayerInfo[playerid][pFaction]][eFactionName]);
		
	return factionName;
}

stock ReturnFactionNameEx(factionid)
{
	new factionName[90];
	
	format(factionName, sizeof(factionName), "%s", FactionInfo[factionid][eFactionName]);
	return factionName;
}

stock ReturnFactionAbbrev(factionid)
{		
	 new facAbbrev[90];
	 
	 format(facAbbrev, sizeof(facAbbrev), "%s", FactionInfo[factionid][eFactionAbbrev]);
	 return facAbbrev; 
}

stock ReturnFactionRank(playerid)
{
	new rankStr[90]; 
	
	if(!PlayerInfo[playerid][pFaction])
	{
		if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
		{
			switch(PlayerInfo[playerid][pJobRank])
			{
				case 1: rankStr = "ช่างฝึกหัด";
				case 2: rankStr = "ช่างประจำอู่";
				case 3: rankStr = "หัวหน้างานช่าง";
			}
		}
		rankStr = "ไม่มีต่ำแหน่ง";
	}
	else
	{
		new 
			factionid = PlayerInfo[playerid][pFaction],
			rank = PlayerInfo[playerid][pFactionRank];
			
		format(rankStr, sizeof(rankStr), "%s", FactionRanks[factionid][rank]);
	}
	return rankStr;
}

stock ReturnFactionType(playerid)
{
	if(!PlayerInfo[playerid][pFaction])
		return 0;
	
	return FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType];
}

stock ReturnFactionJob(playerid)
{
	if(!PlayerInfo[playerid][pFaction])
		return 0;
	
	return FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob];
}

stock ShowFactionConfig(playerid)
{
	new rankCount, infoString[128], showString[256];
	
	format(infoString, sizeof(infoString), "ชื่อ: %s\n", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
	strcat(showString, infoString); 
	
	format(infoString, sizeof(infoString), "ชื่อย่อ: %s\n", ReturnFactionAbbrev(PlayerSelectFac[playerid]));
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "ยศต่ำแหน่งที่ควบคุม: %d\n", FactionInfo[PlayerSelectFac[playerid]][eFactionAlterRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "ตำแหน่งเริ่มต้น: %d\n", FactionInfo[PlayerSelectFac[playerid]][eFactionJoinRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "ต่ำแหน่งที่สามารถคุยได้: %d\n", FactionInfo[PlayerSelectFac[playerid]][eFactionChatRank]);
	strcat(showString, infoString);
	
	format(infoString, sizeof(infoString), "สีของแชท\n", FactionInfo[PlayerSelectFac[playerid]][eFactionChatColor]);
	strcat(showString, infoString);
	
	for(new i = 1; i < MAX_FACTION_RANKS; i++)
	{
		if(!strcmp(FactionRanks[PlayerSelectFac[playerid]][i], "NotSet"))
			continue;
			
		rankCount++;
	}
	
	format(infoString, sizeof(infoString), "ยศ/ต่ำแหน่ง (%i)\n", rankCount);
	strcat(showString, infoString);
	
	strcat(showString, "จุดเกิดเฟคชั่น\n"); 
	
	format(infoString, sizeof(infoString), "ต่ำแหน่งที่สามารถรีรถ: %d\n", FactionInfo[PlayerSelectFac[playerid]][eFactionTowRank]);
	strcat(showString, infoString);


    if(!FactionInfo[PlayerSelectFac[playerid]][eFactionType])
    {
        format(infoString, sizeof(infoString), "ประภทเฟคชั่น: ไม่ได้ตั้งค่า\n");
        strcat(showString, infoString);
    }
    if(FactionInfo[PlayerSelectFac[playerid]][eFactionType] == 1)
    {
        format(infoString, sizeof(infoString), "ประภทเฟคชั่น: แก๊ง\n");
        strcat(showString, infoString);
    }
    if(FactionInfo[PlayerSelectFac[playerid]][eFactionType] == 2)
    {
        format(infoString, sizeof(infoString), "ประภทเฟคชั่น: รัฐบาล\n");
        strcat(showString, infoString);
    }

    if(!FactionInfo[PlayerSelectFac[playerid]][eFactionJob])
    {
        format(infoString, sizeof(infoString), "อาชีพ: ไม่ได้ตั้งค่า\n");
        strcat(showString, infoString);
    }
    if(FactionInfo[PlayerSelectFac[playerid]][eFactionJob])
    {
        if(FactionInfo[PlayerSelectFac[playerid]][eFactionJob] == 1)
        {
            format(infoString, sizeof(infoString), "อาชีพ: ตำรวจ\n");
        }
        if(FactionInfo[PlayerSelectFac[playerid]][eFactionJob] == 2)
        {
            format(infoString, sizeof(infoString), "อาชีพ: แพทย์\n");
        }
        if(FactionInfo[PlayerSelectFac[playerid]][eFactionJob] == 3)
        {
            format(infoString, sizeof(infoString), "อาชีพ: นายอำเภอ\n");
        }
        if(FactionInfo[PlayerSelectFac[playerid]][eFactionJob] == 4)
        {
            format(infoString, sizeof(infoString), "อาชีพ: กรมราชทัณฑ์\n");
        }
        strcat(showString, infoString);
    }
	
	Dialog_Show(playerid, DIALOG_FACTION_CONFIG, DIALOG_STYLE_LIST, "{ADC3E7}Faction Configuration", showString, "Select", "<<");
	return 1;
}

Dialog:DIALOG_EDITFACTION(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    PlayerSelectFac[playerid] = listitem+1;

    ShowFactionConfig(playerid);
    return 1;
}
Dialog:DIALOG_FACTION_CONFIG(playerid, response, listitem, inputtext[])
{
    if(response)
	{
	    switch(listitem)
        {
            case 0: return Dialog_Show(playerid, DIALOG_FACTION_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่ชื่อเฟคชั่นของคุณ:", "Select", "<<"); 
            case 1: return Dialog_Show(playerid, DIALOG_FACTION_ABBREV, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่ชื่อย่อเฟคชั่นของคุณ:", "Select", "<<");
            case 2: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จะให้สามารถแก้ไขได้:", "ตกลง", "<<");      
			case 3: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จะให้เป็นยนเริ่มต้น:", "ตกลง", "<<");
			case 4: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จให้พิมพ์แชทกลุ่มได้", "ตกลง", "<<");
			case 5: return Dialog_Show(playerid, DIALOG_FACTION_CHATCOLOR, DIALOG_STYLE_MSGBOX, "Faction Configuration", "{FF0033}ยังไม่อณุญาติให้ใช้คำสั่งนี้โปรดเข้าใจ", "ตกลง", "<<");
			case 6: return Dialog_Show(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่ง ที่คุณต้องการแก้ไข(1-20)", "ตกลง", "<<");
			case 7:
			{		
				new factionid = PlayerSelectFac[playerid];
					
				GetPlayerPos(playerid, FactionInfo[factionid][eFactionSpawn][0], FactionInfo[factionid][eFactionSpawn][1], FactionInfo[factionid][eFactionSpawn][2]);
		
				FactionInfo[factionid][eFactionSpawnInt] = GetPlayerInterior(playerid);
					
				if(GetPlayerVirtualWorld(playerid) == 0)
					FactionInfo[factionid][eFactionSpawnWorld] = random(99999); 
							
				else FactionInfo[factionid][eFactionSpawnWorld] = GetPlayerVirtualWorld(playerid);
				
				SaveFaction(PlayerSelectFac[playerid]);
				SendServerMessage(playerid, "เปลี่ยนจุดเกิดเฟคชั่นแล้ว"); 
				return ShowFactionConfig(playerid);
			}
			case 8: return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่ง ที่คุณต้องการให้รียานพาหนะได้:", "ตกลง", "<<");
			case 9: 
			{
				new str[MAX_STRING];
				format(str, sizeof(str), "{D35400}[{FFEB3B} ! {D35400}]{FF5722} แก๊ง\n\
										  {D35400}[{FFEB3B} ! {D35400}]{1976D2} รัฐบาล");
				return Dialog_Show(playerid, DIALOG_FACTION_TYPE, DIALOG_STYLE_LIST, "Faction Configuration", str, "ตกลง", "<<");
			}
			case 10: 
			{
				if(FactionInfo[PlayerSelectFac[playerid]][eFactionType] != 2)
				{
					SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} เฟคชั่น {FFEE58}%s {FFFFFF}ไม่ได้เป็นเฟคชั่นรัฐบาล",FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
					return ShowFactionConfig(playerid);
				}
				new str[MAX_STRING];
				format(str, sizeof(str), "{D35400}[{FFEB3B} ! {D35400}]{FFFFFF} ตำรวจ\n\
										  {D35400}[{FFEB3B} ! {D35400}]{FFFFFF} หมอ\n\
										  {D35400}[{FFEB3B} ! {D35400}]{FFFFFF} นายอำเภอ\n\
										  {D35400}[{FFEB3B} ! {D35400}]{FFFFFF} กรมราชทัณฑ์\n\
										  {D35400}[{FFEB3B} ! {D35400}]{FFFFFF} รัฐบาล\n");
				return Dialog_Show(playerid, DIALOG_FACTION_JOB, DIALOG_STYLE_LIST, "Faction Configuration", str, "ตกลง", "<<");
			}
        }
    }
    return 1;
}

Dialog:DIALOG_FACTION_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        ShowFactionConfig(playerid);

    if(response)
    {
        if(strlen(inputtext) > 90 || strlen(inputtext) < 3)
            return Dialog_Show(playerid, DIALOG_FACTION_NAME, DIALOG_STYLE_INPUT, "Faction Configuration", "ชื่อเฟคชั่นของคุณควรไม่เกิน 90 ตัวอักษร\n\nใส่ชื่อเฟคชั่นของคุณ:", "ตกลง", "<<");
        
        format(FactionInfo[PlayerSelectFac[playerid]][eFactionName], 90, "%s", inputtext);
        SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} ชื่อเฟคชั่นของคุณ: \"%s\".", inputtext);
        SaveFaction(PlayerSelectFac[playerid]);
        ShowFactionConfig(playerid);
        return 1;
    }
    return 1;
}

Dialog:DIALOG_FACTION_ABBREV(playerid, response, listitem, inputtext[])
{
    if(!response)
		return ShowFactionConfig(playerid);

    if(response)
    {
        if(strlen(inputtext) > 30 || strlen(inputtext) < 1)
            return Dialog_Show(playerid, DIALOG_FACTION_ABBREV, DIALOG_STYLE_INPUT, "Faction Configuration", "ชื่อย่อเฟคชั่นของคุณควรไม่เกิน 30 ตัวอักษร\n\nใส่ชื่อย่อเฟคชั่นของคุณ:", "ตกลง", "<<"); 
                    
        format(FactionInfo[PlayerSelectFac[playerid]][eFactionAbbrev], 30, "%s", inputtext);
        SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} ชื่อย่อเฟคชั่นใหม่ของคุณ: \"%s\".", inputtext);
        SaveFaction(PlayerSelectFac[playerid]);
                
        return ShowFactionConfig(playerid);
    }
    return 1;
}

Dialog:DIALOG_FACTION_ALTER_R(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);

	if(response)
	{	
		if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จะให้สามารถแก้ไขได้:", "ตกลง", "<<"); 

		new rankid = strval(inputtext); 
				
		if(rankid > 20 || rankid < 1)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_R, DIALOG_STYLE_INPUT, "Faction Configuration", "เลขยศ/ตำแหน่ง ต้องไม่เกิน 1-20\n\nใส่เลขยศ/ต่ำแหน่งที่จะให้สามารถแก้ไขได้", "ตกลง", "<<"); 
				
		FactionInfo[PlayerSelectFac[playerid]][eFactionAlterRank] = rankid;
		SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} เลขยศ/ต่ำแหน่งที่จะให้สามารถแก้ไขได้: %i.", rankid);
		SaveFaction(PlayerSelectFac[playerid]);
				
		return ShowFactionConfig(playerid);
	}
	return 1;
}

Dialog:DIALOG_FACTION_ALTER_J(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);

	if(response)
	{		
		if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จะให้เป็นยนเริ่มต้น:", "Select", "<<");

		new rankid = strval(inputtext); 
				
		if(rankid > 20 || rankid < 1)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_J, DIALOG_STYLE_INPUT, "Faction Configuration", "เลขยศ/ต่ำแหน่งต้องไม่เกิน 1-20.\n\nใส่เลขยศ/ต่ำแหน่งที่จะให้เป็นยนเริ่มต้น:", "ตกลง", "<<"); 
				
		FactionInfo[PlayerSelectFac[playerid]][eFactionJoinRank] = rankid;
		SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} เลขยศ/ต่ำแหน่งที่จะให้เป็นยนเริ่มต้น: %i.", rankid);
		SaveFaction(PlayerSelectFac[playerid]);
				
		return ShowFactionConfig(playerid);
	}

	return 1;
}

Dialog:DIALOG_FACTION_ALTER_C(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จให้พิมพ์แชทกลุ่มได้:", "Select", "<<"); 

		new rankid = strval(inputtext); 
			
		if(rankid > 20 || rankid < 1)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_C, DIALOG_STYLE_INPUT, "Faction Configuration", "เลขยศ/ต่ำแหน่งต้องไม่เกิน 1-20.\n\nใส่เลขยศ/ต่ำแหน่งที่จให้พิมพ์แชทกลุ่มได้:", "ตกลง", "<<"); 
			
		FactionInfo[PlayerSelectFac[playerid]][eFactionChatRank] = rankid;
		SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} คุณได้เปลี่ยนให้ตั้งแต่ยศ: %i ขึ้นไปสามารถพิมพ์ระบบแชทกลุ่มได้(/f)", rankid);
		SaveFaction(PlayerSelectFac[playerid]);
			
		return ShowFactionConfig(playerid);
	}
	return 1;
}

Dialog:DIALOG_FACTION_CHATCOLOR(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		return ShowFactionConfig(playerid);
	}
	return 1;
}

Dialog:DIALOG_FACTION_RANKS(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		new rankid = strval(inputtext), str[128];
				
		if(rankid > 20 || rankid < 1)
			return Dialog_Show(playerid, DIALOG_FACTION_RANKS, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่ง ที่จะแก้ไขชื่อ ยศ/ต่ำแหน่ง", "ตกลง", "<<");
					
		playerEditingRank[playerid] = rankid;
				
		format(str, sizeof(str), "คุณกำลังแก้ไขยศ/ต่ำแหน่ง %i ('%s').\n\n{F81414}หากจะลบชื่อยศใหตั้งเป็น \"NotSet\". ", rankid, FactionRanks[PlayerSelectFac[playerid]][rankid]);
		return Dialog_Show(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "ตกลง", "<<");
	}
	return 1;
}

Dialog:DIALOG_FACTION_RANKEDIT(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		new str[128];
				
		if(strlen(inputtext) > 60 || strlen(inputtext) < 1)
		{
			format(str, sizeof(str), "คุณควรตั้งชื่อยศไม่เกิน 60 ตัวอักษร\n\nคุณกำลังแก้ไขยศ/ต่ำแหน่ง %i ('%s').\n{F81414}หากจะลบชื่อยศใหตั้งเป็น \"NotSet\".", FactionRanks[PlayerInfo[playerid][pFaction]][playerEditingRank[playerid]], playerEditingRank[playerid]);
			return Dialog_Show(playerid, DIALOG_FACTION_RANKEDIT, DIALOG_STYLE_INPUT, "Faction Configuration", str, "ตกลง", "<<"); 
		}
			
		SendServerMessage(playerid, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} คุณได้แก้ไขชือยศ %i (%s) เป็น: \"%s\". ", playerEditingRank[playerid], FactionRanks[PlayerSelectFac[playerid]][playerEditingRank[playerid]], inputtext);
		format(FactionRanks[PlayerSelectFac[playerid]][playerEditingRank[playerid]], 60, "%s", inputtext);
		
		SaveFactionRanks(PlayerSelectFac[playerid]);

		return ShowFactionConfig(playerid);
	}
	return 1;
}
Dialog:DIALOG_FACTION_ALTER_T(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);

	if(response)
	{
		if(strlen(inputtext) < 1 || strlen(inputtext) > 2)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "ใส่เลขยศ/ต่ำแหน่งที่จะสามารถ รียานพาหนะได้:", "ตกลง", "<<"); 
					
		new rankid = strval(inputtext); 
				
		if(rankid > 20 || rankid < 1)
			return Dialog_Show(playerid, DIALOG_FACTION_ALTER_T, DIALOG_STYLE_INPUT, "Faction Configuration", "เลขยศ/ต่ำแหน่งต้องไม่เกิน 1-20.\n\nใส่เลขยศ/ต่ำแหน่งที่จะสามารถ รียานพาหนะได้:", "ตกลง", "<<");

		FactionInfo[PlayerSelectFac[playerid]][eFactionTowRank] = rankid;
		SaveFaction(PlayerSelectFac[playerid]);
		SendServerMessage(playerid, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} เลขยศ/ต่ำแหน่งที่จะสามารถ รียานพาหนะได้: %i.", rankid);
		return ShowFactionConfig(playerid);
	}
	return 1;
}

Dialog:DIALOG_FACTION_TYPE(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionType] = 1;
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 0;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'แก๊ง' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
			case 1:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionType] = 2;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'รัฐบาล' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
		}
	}
	return ShowFactionConfig(playerid);
}

Dialog:DIALOG_FACTION_JOB(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowFactionConfig(playerid);
	
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 1;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทอาชีพเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'ตำรวจ' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
			case 1:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 2;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทอาชีพเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'หมอ' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
			case 2:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 3;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทอาชีพเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'นายอำเภอ' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
			case 3:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 4;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทอาชีพเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'กรมราชทัณฑ์' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
			case 4:
			{
				FactionInfo[PlayerSelectFac[playerid]][eFactionJob] = 5;
				SendClientMessageEx(playerid, -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}คุณได้เปลี่ยนประเภทอาชีพเฟคชั่น ของ {FFEB3B}%s {FFFFFF}เป็น 'รัฐบาล' แล้วตอนนี้", FactionInfo[PlayerSelectFac[playerid]][eFactionName]);
				SaveFaction(PlayerSelectFac[playerid]);
			}
		}
	}
	return ShowFactionConfig(playerid);
}


new PlayerMakeleader[MAX_PLAYERS], PLayerMakeleaderFacID[MAX_PLAYERS];
Dialog:DIALOG_COM_FAC_INV(playerid, response, listitem, inputtext[])
{
	new factionid = PLayerMakeleaderFacID[playerid], str[MAX_STRING];

	if(!response)
	{
		SendClientMessageEx(PlayerMakeleader[playerid], -1, "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF}%s ปฏิเสธการให้เป็นหัวหน้าเฟคชั่น",ReturnRealName(playerid,0));
		return 1;
	}
	else
	{
		PlayerInfo[playerid][pFaction] = factionid;
		PlayerInfo[playerid][pFactionRank] = 1;

		if(FactionInfo[factionid][eFactionType] == GOVERMENT)
		{
			PlayerInfo[playerid][pBadge] = random(99999);
		}

		foreach (new i : Player)
		{
			if(PlayerInfo[i][pFaction] != factionid)
				continue;
			
			SendClientMessageEx(i, -1, "{2ECC71}**((%s: ได้เข้าสู่เฟคชั่นของพวกคุณแล้ว))**", ReturnRealName(playerid,0));
		}
		SendClientMessageEx(PlayerMakeleader[playerid], -1,"{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} คุณได้ให้ให้ %s เป็นหัวหน้าเฟคชั่น ของ %s",ReturnRealName(playerid,0),FactionInfo[factionid][eFactionName]);

		format(str, sizeof(str), "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} %s ตั้งค่าให้ %s เป็นหัวหน้ากลุ่มเฟคชั่น %s", ReturnRealName(PlayerMakeleader[playerid],0), ReturnRealName(playerid,0), FactionInfo[factionid][eFactionName]);
		SendAdminMessage(4, str);

		CharacterSave(playerid);
	}
	return 1;
}


forward SpawnFaction(playerid,id);
public SpawnFaction(playerid,id)
{
    SetPlayerPos(playerid, FactionInfo[id][eFactionSpawn][0], FactionInfo[id][eFactionSpawn][1], FactionInfo[id][eFactionSpawn][2]);        
    SetPlayerVirtualWorld(playerid, FactionInfo[id][eFactionSpawnWorld]);
    SetPlayerInterior(playerid, FactionInfo[id][eFactionSpawnInt]);
    TogglePlayerControllable(playerid, 1);
	return 1;
}
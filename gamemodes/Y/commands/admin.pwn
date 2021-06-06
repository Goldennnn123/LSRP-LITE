#include <YSI_Coding\y_hooks>

CMD:acmds(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /aduty, /forumname, /goto, /gethere, /a (achat), /showmain, /kick"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /unjail, /setint, /setworld, /setskin, /health, /reports, /ar (accept), /dr (disregard),"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /slap, /mute, /freeze, /unfreeze, /spec, /specoff, /stats (id), /gotols, /respawncar,"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /gotocar, /getcar, /listmasks, /dropinfo, /aooc, /revice, /towcars (aduty), /listweapons");
	}
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /setarmour, /clearreports, /givegun, /clearpguns, /gotohouse, /gotofaction, /gotopoint,");
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /gotobusiness, /noooc, /backup, /repair.");
	}
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 3:{FFFFFF} /spawncar, /despawncar, /pcar, /setstats, /givemoney, /setcar.");
	}
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 4:{FFFFFF} /factions");
	}
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 5:{FFFFFF} /makeleader, /makehouse, /viewhouse");
	}
	if(PlayerInfo[playerid][pAdmin] >= 1336)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1336:{FFFFFF} /makebusiness, /viewbusiness");
	}
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1337:{FFFFFF} /maketester");
	}
	if(PlayerInfo[playerid][pAdmin] >= 1338)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1338:{FFFFFF} /restart");
	}
	if(PlayerInfo[playerid][pAdmin] >= 1339)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1339:{FFFFFF} /makefaction, /makeadmin");
	}
    return 1;
}

CMD:aduty(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new str[128];
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		PlayerInfo[playerid][pAdminDuty] = false;
		
		format(str, sizeof(str), "{FF5722}%s {43A047}���͡�ҡ��û�Ժѵ�˹�ҷ���繼������к�����㹢�й��", ReturnRealName(playerid)); 
		SendAdminMessage(1, str);
		
		if(!PlayerInfo[playerid][pPoliceDuty])
			SetPlayerColor(playerid, COLOR_WHITE); 
			
		else
			SetPlayerColor(playerid, COLOR_COP);
			
		SetPlayerHealth(playerid, 100); 
	}
	else
	{
		PlayerInfo[playerid][pAdminDuty] = true;
		
		format(str, sizeof(str), "{FF5722}%s {43A047}���������Ժѵ�˹�ҷ���繼������к�����㹢�й��", ReturnRealName(playerid)); 
		SendAdminMessage(1, str);
		
		SetPlayerColor(playerid, 0x587B95FF);
		SetPlayerHealth(playerid, 250);
	}
	
	return 1; 
}

CMD:a(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(isnull(params)) return SendUsageMessage(playerid, "/a (�ʹ�Թ᪷) [��ͤ���]"); 
	
	if(strlen(params) > 89)
	{
		SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): %.89s", ReturnRealName(playerid), e_pAccountData[playerid][mForumName], params);
		SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): ... %s", ReturnRealName(playerid), e_pAccountData[playerid][mForumName], params[89]);
	}
	else SendAdminMessageEx(COLOR_YELLOWEX, 1, "** %s (%s): %s", ReturnRealName(playerid), e_pAccountData[playerid][mForumName], params);
	return 1;
}

CMD:forumname(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/forumname [���Ϳ�����]");
		
	if(strlen(params) > 60)
		return SendErrorMessage(playerid, "���Ϳ������ͧ�س����������Թ 60 ����ѡ��");
	
	format(e_pAccountData[playerid][mForumName], 60, "%s", params);
	SendServerMessage(playerid, "�س���駪��Ϳ������ͧ�س��: %s", params);  
	
	CharacterSave(playerid);
    return 1;
}

CMD:goto(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/goto [���ͺҧ��ǹ/�ʹ�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	GetPlayerPos(playerb, PlayerInfo[playerb][pLastPosX], PlayerInfo[playerb][pLastPosY], PlayerInfo[playerb][pLastPosZ]);
	//Using the player variable to avoid making other variables; 
	
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerid), PlayerInfo[playerb][pLastPosX], PlayerInfo[playerb][pLastPosY], PlayerInfo[playerb][pLastPosZ]);
	
	else
		SetPlayerPos(playerid, PlayerInfo[playerb][pLastPosX], PlayerInfo[playerb][pLastPosY], PlayerInfo[playerb][pLastPosZ]);
		
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
	
	if(GetPlayerInterior(playerb) != 0)
		SetPlayerInterior(playerid, GetPlayerInterior(playerb)); 
		
	SendTeleportMessage(playerid);	
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/goto [���ͺҧ��ǹ/�ʹ�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
	//Using the player variable to avoid making other variables; 
	
	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerb), PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY] -1, PlayerInfo[playerid][pLastPosZ]);
		
	else
		SetPlayerPos(playerb, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY] -1, PlayerInfo[playerid][pLastPosZ]);
		
	SetPlayerVirtualWorld(playerb, GetPlayerVirtualWorld(playerid));
	
	if(GetPlayerInterior(playerid) != 0)
		SetPlayerInterior(playerb, GetPlayerInterior(playerid)); 
		
	SendTeleportMessage(playerb);
	SendServerMessage(playerb, "�س�١����͹�����¼������к�  %s", ReturnRealName(playerb));
	
	return 1;
}

CMD:showmain(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/showmain [���ͺҧ��ǹ/�ʹ�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
	
	SendServerMessage(playerid, "%s' UCP \"%s\" (DBID: %i).", ReturnRealName(playerb), e_pAccountData[playerb][mAccName], e_pAccountData[playerb][mDBID]);	
	return 1;
}

CMD:kick(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/kick [���ͺҧ��ǹ/�ʹ�] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "�س���������ö�� �������к�����յ���˹��٧���Ҥس��", ReturnRealName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s �١���͡�ҡ�׿������� %s ���˵�: %.56s", ReturnRealName(playerb), ReturnRealName(playerid), reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s �١���͡�ҡ�׿������� %s ���˵�: %s", ReturnRealName(playerb), ReturnRealName(playerid), reason);
	
	new insertLog[256];
	
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
	{
		SendServerMessage(playerid, "������ (%s) �١���͡�ҡ�׿����좳��������к�", ReturnRealName(playerb));
	}
	
	mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO kick_logs (`KickedDBID`, `KickedName`, `Reason`, `KickedBy`, `Date`) VALUES(%i, '%e', '%e', '%e', '%e')",
		PlayerInfo[playerid][pDBID], ReturnName(playerb), reason, ReturnName(playerid), ReturnDate()); 
		
	mysql_tquery(dbCon, insertLog); 

	KickEx(playerb);
	return 1;
}

CMD:ban(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/ban [���ͺҧ��ǹ/�ʹ�] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You can't ban %s.", ReturnName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ��١ẹ�͡�ҡ�׿������� %s ���˵�: %.56s", ReturnName(playerb), ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ��١ẹ�͡�ҡ�׿������� %s ���˵�: %s", ReturnName(playerb), ReturnName(playerid), reason);
	
	new insertLog[256];
	
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
	{
		SendServerMessage(playerid, "������ (%s) ��١ẹ�͡�ҡ�׿����좳��������к�", ReturnName(playerb));
		return 1;
	}
	
	mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO bannedlist (`CharacterDBID`, `MasterDBID`, `CharacterName`, `Reason`, `Date`, `BannedBy`, `IpAddress`) VALUES(%i, %i, '%e', '%e', '%e', '%e', '%e')",
		PlayerInfo[playerb][pDBID], e_pAccountData[playerid][mDBID], ReturnName(playerb), reason, ReturnDate(), ReturnName(playerid), ReturnIP(playerb));
	
	mysql_tquery(dbCon, insertLog); 
	
	mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ban_logs (`CharacterDBID`, `MasterDBID`, `CharacterName`, `Reason`, `BannedBy`, `Date`) VALUES(%i, %i, '%e', '%e', '%e', '%e')",
		PlayerInfo[playerb][pDBID], e_pAccountData[playerid][mDBID], ReturnName(playerb), reason, ReturnName(playerid), ReturnDate());
		
	mysql_tquery(dbCon, insertLog); 
	
	KickEx(playerb);
	return 1;
}

CMD:ajail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, length, reason[120];
	
	if (sscanf(params, "uds[120]", playerb, length, reason)) 
		return SendUsageMessage(playerid, "/ajail [���ͺҧ��ǹ/�ʹ�] [����] [���˵�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(length < 1)
		return SendErrorMessage(playerid, "�س��ͧ�������㹡�âѧ����ӡ��� 1 �ҷ�"); 
		
	if(strlen(reason) > 45)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ��١��ʧ�ء�ʹ�Թ ������ %d �ҷ� �� %s ���˵�: %.56s", ReturnName(playerb), length, ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ��١��ʧ�ء�ʹ�Թ ������ %d �ҷ� �� %s ���˵�: %s",ReturnName(playerb), length, ReturnName(playerid), reason);
	
	ClearAnimations(playerb); 
	
	SetPlayerPos(playerb, 2687.3630, 2705.2537, 22.9472);
	SetPlayerInterior(playerb, 0); SetPlayerVirtualWorld(playerb, 1338);
	
	PlayerInfo[playerb][pAdminjailed] = true;
	PlayerInfo[playerb][pAdminjailTime] = length * 60; 
		
	CharacterSave(playerb);
	
	new insertLog[250];
	
	mysql_format(dbCon, insertLog, sizeof(insertLog), "INSERT INTO ajail_logs (`JailedDBID`, `JailedName`, `Reason`, `Date`, `JailedBy`, `Time`) VALUES(%i, '%e', '%e', '%e', '%e', %i)",
		PlayerInfo[playerb][pDBID], ReturnName(playerb), reason, ReturnDate(), ReturnName(playerid), length);
		
	mysql_tquery(dbCon, insertLog);
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/unjail [���ͺҧ��ǹ/�ʹ�]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
	
	if(PlayerInfo[playerb][pAdminjailed] == false)
		return SendErrorMessage(playerid, "�����������١�觤ء�ʹ�Թ"); 
		
	SpawnPlayer(playerb);
	
	PlayerInfo[playerb][pAdminjailed] = false;
	PlayerInfo[playerb][pAdminjailTime] = 0;
	
	CharacterSave(playerb);
	SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ��١���͡�ҡ�ء�ʹ�Թ�� %s", ReturnName(playerb), ReturnName(playerid));
	return 1;
}

CMD:setint(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, int, str[128];
	
	if (sscanf(params, "ud", playerb, int)) 
		return SendUsageMessage(playerid, "/setint [���ͺҧ��ǹ/�ʹ�] [interior]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
	
	SetPlayerInterior(playerb, int);
	
	format(str, sizeof(str), "%s ��� 'Interior' ��� %s 价�� 'Interior' %d.", ReturnName(playerid), ReturnName(playerb), int);
	SendAdminMessage(1, str);
	return 1;
}

CMD:setworld(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, world, str[128];
	
	if (sscanf(params, "ud", playerb, world)) 
		return SendUsageMessage(playerid, "/setworld [���ͺҧ��ǹ/�ʹ�] [world]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
	
	SetPlayerVirtualWorld(playerb, world);
	
	format(str, sizeof(str), "%s ��� 'World' ��� %s 价�� 'World' %d.", ReturnName(playerid), ReturnName(playerb), world);
	SendAdminMessage(1, str);
	return 1;
}


CMD:setskin(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, skinid, str[128];
	
	if (sscanf(params, "ud", playerb, skinid)) 
		return SendUsageMessage(playerid, "/setskin [���ͺҧ��ǹ/�ʹ�] [skinid]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	PlayerInfo[playerb][pLastSkin] = skinid; SetPlayerSkin(playerb, skinid);
	
	format(str, sizeof(str), "%s ��� 'Skin' ��� %s �� %d.", ReturnName(playerid), ReturnName(playerb), skinid);
	SendAdminMessage(1, str);
	CharacterSave(playerb);
	
	return 1;
}

CMD:sethp(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, health, str[128];
	
	if (sscanf(params, "ud", playerb, health)) 
		return SendUsageMessage(playerid, "/sethp [���ͺҧ��ǹ/�ʹ�] [health]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(health > 200)
		return SendErrorMessage(playerid, "�س�������ö�����ʹ���Թ 200"); 
		
	SetPlayerHealth(playerb, health);
	
	format(str, sizeof(str), "%s �����ʹ��� %s �� %d", ReturnName(playerid), ReturnName(playerb), health);
	SendAdminMessage(1, str);
	return 1;
}

CMD:setarmour(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, armour, str[128];
	
	if (sscanf(params, "ud", playerb, armour)) 
		return SendUsageMessage(playerid, "/setarmour [���ͺҧ��ǹ/�ʹ�] [health]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(armour > 200)
		return SendErrorMessage(playerid, "�س�������ö���������Թ 200"); 
		
	SetPlayerArmour(playerb, armour);
	
	format(str, sizeof(str), "%s ��������� %s �� %d", ReturnName(playerid), ReturnName(playerb), armour);
	SendAdminMessage(1, str);
	return 1;
}

CMD:reports(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	SendClientMessage(playerid, COLOR_DARKGREEN, "____________________REPORTS____________________");
		
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][rReportExists] == true)
		{
			if(strlen(ReportInfo[i][rReportDetails]) > 65)
			{
				SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | ��§ҹ: %.65s", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails]);
				SendClientMessageEx(playerid, COLOR_REPORT, "...%s | ������ͧ����: %d �Թҷ�", ReportInfo[i][rReportDetails][65], gettime() - ReportInfo[i][rReportTime]);
			}
			else SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | ��§ҹ: %s | ������ͧ����: %d �Թҷ�", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails], gettime() - ReportInfo[i][rReportTime]);
		}
	}
	return 1;
}

CMD:ar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	new reportid;
	
	if (sscanf(params, "d", reportid))
		return SendUsageMessage(playerid, "/acceptreport [��§ҹ �ʹ�]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "������ʹ���§ҹ����ͧ���"); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[��§ҹ] �������к� %s �Ѻ��§ҹ�ʹ� %d", ReturnName(playerid), reportid);
	SendClientMessageEx(playerid, COLOR_YELLOW, "�س�Ѻ��§ҹ %s [��§ҹ����ͧ: %s]", ReturnName(ReportInfo[reportid][rReportBy]), ReportInfo[reportid][rReportDetails]);
	
	ReportInfo[reportid][rReportExists] = false;
	ReportInfo[reportid][rReportBy] = INVALID_PLAYER_ID; 
	
	//You can include a message to the reporter if you would like;
	return 1; 
}

CMD:dr(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return 0;
		
	new reportid;
	
	if (sscanf(params, "d", reportid))
		return SendUsageMessage(playerid, "/disregardreport [��§ҹ �ʹ�]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "�������§ҹ����ҹ��ͧ���"); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[��§ҹ] �������к� %s ź��§ҹ�ʹ� %d", ReturnName(playerid), reportid);
	
	ReportInfo[reportid][rReportExists] = false;
	ReportInfo[reportid][rReportBy] = INVALID_PLAYER_ID; 
	
	//You can include a message to the reporter if you would like;
	return 1; 
}


CMD:slap(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/slap [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	GetPlayerPos(playerb, PlayerInfo[playerb][pLastPosX], PlayerInfo[playerb][pLastPosY], PlayerInfo[playerb][pLastPosZ]);
	//Using the player variable to avoid making other variables; 
	
	SetPlayerPos(playerb, PlayerInfo[playerb][pLastPosX], PlayerInfo[playerb][pLastPosY], PlayerInfo[playerb][pLastPosZ] + 5); 
	PlayNearbySound(playerb, 1130); //Slap sound;
	
	SendServerMessage(playerid, "%s slapped %s", ReturnName(playerid), ReturnName(playerb));
	if(playerb != playerid) SendServerMessage(playerb, "%s slapped %s", ReturnName(playerid), ReturnName(playerb));
	return 1;
}


CMD:freeze(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb, str[128];
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/freeze [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	TogglePlayerControllable(playerb, 0);
	
	format(str, sizeof(str), "%s ���秼����� %s.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb, str[128];
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/unfreeze [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	TogglePlayerControllable(playerb, 1);
	
	format(str, sizeof(str), "%s ¡��ԡ������� %s", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}


CMD:spec(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/spec [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	/*if(PlayerInfo[playerb][pSpectating] != INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "�س���ѧ��ͧ�����蹤��������"); */
		
	//if(playerb == playerid) return SendErrorMessage(playerid, "You can't spectate yourself.");

	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerb);

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			SendServerMessage(playerid,"X:%f Y:%f Z:%f", PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			SendServerMessage(playerid, "�͹���س���ѧ��ͧ������ %s  /specoff ������ش��ͧ", ReturnName(playerb));
		}
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectateVehicle(playerid, vehicleid);
			
		PlayerInfo[playerid][pSpectating] = playerb; 
		return 1;
	}
	else
	{	
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			SendServerMessage(playerid,"X:%f Y:%f Z:%f", PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			SendServerMessage(playerid, "�͹���س���ѧ��ͧ������ %s  /specoff ������ش��ͧ", ReturnName(playerb));
		}
		
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectatePlayer(playerid, playerb);
			
		PlayerInfo[playerid][pSpectating] = playerb; 
		return 1;
	}
}


CMD:specoff(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		return SendErrorMessage(playerid, "�س�����ӡ����ͧ��������"); 
		
	SendServerMessage(playerid, "�س¡��ԡ�����ͧ %s", ReturnName(PlayerInfo[playerid][pSpectating]));
	
	TogglePlayerSpectating(playerid, false); 
	//ReturnPlayerGuns(playerid);
	return 1;
}

CMD:gotols(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 1514.1836, -1677.8027, 14.0469);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendTeleportMessage(playerid);
	return 1;
}

CMD:respawncar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/respawncar [�ʹ� ö]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "������ʹ�ö����ͧ���");
		
	SetVehicleToRespawn(vehicleid);
	
	foreach(new i : Player)
	{
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "ö�١�������к� %s �觡�Ѻ�ش�Դö����", ReturnName(playerid));
		}
	}
	
	format(str, sizeof(str), "%s ����ö �ʹ�:%d ��Ѻ�ش�Դ����", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotocar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid;
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/gotocar [�ʹ� ö]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "������ʹշ���ͧ���");
		
	new Float: fetchPos[3];
	GetVehiclePos(vehicleid, fetchPos[0], fetchPos[1], fetchPos[2]);
	
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerid), fetchPos[0], fetchPos[1], fetchPos[2] + 2);
	
	else
		SetPlayerPos(playerid, fetchPos[0], fetchPos[1], fetchPos[2]);
		
	SendTeleportMessage(playerid);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	return 1;
}

CMD:getcar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new 
		vehicleid,
		Float:x,
		Float:y,
		Float:z,
		str[128]
	;
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/gotocar [�ʹ� ö]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "������ʹ�ö����ҹ��ͧ���");
	
	GetPlayerPos(playerid, x, y, z);
	
	SetVehiclePos(vehicleid, x, y, z);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid)); 
	
	format(str, sizeof(str), "%s �֧ö %i ���ҵ��", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str); 
	
	foreach(new i : Player)
	{
		if(!IsPlayerInAnyVehicle(i))
			continue;
			
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "ö �ʹ�:%d �١����͹�����¼������к�", vehicleid); 
		}
	}
	return 1;
}

CMD:listmasks(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
	foreach(new i : Player)
	{
		if(!PlayerInfo[i][pMasked])
			continue;
			
		SendClientMessageEx(playerid, COLOR_RED, "%s ID: %i %s", ReturnName(i), i, ReturnName(i, 0));
		return 1;
	}
	
	SendServerMessage(playerid, "��������������˹�ҡҡ");
	return 1;
}

CMD:dropinfo(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue;
	
		if(IsPlayerInRangeOfPoint(playerid, 5.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				SendServerMessage(playerid, "㹾�鹷��ç��� �����ظ %s ��С���ع %d �١����� %s", ReturnWeaponName(WeaponDropInfo[i][eWeaponWepID]), WeaponDropInfo[i][eWeaponWepAmmo], ReturnDBIDName(WeaponDropInfo[i][eWeaponDroppedBy]));
			}
		}
		return 1;
	}
	SendServerMessage(playerid, "���������㹵ç���");
	return 1;
}

CMD:aooc(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(isnull(params)) return SendUsageMessage(playerid, "/aooc [��ͤ���]"); 
	
	/*if(strcmp(e_pAccountData[playerid][mForumName], "Null"))
		SendClientMessageToAllEx(COLOR_RED, "[AOOC] �������к� %s (%s): %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params);
		
	else SendClientMessageToAllEx(COLOR_RED, "[AOOC] �������к� %s: %s", ReturnName(playerid), params);*/
	SendClientMessageToAllEx(COLOR_RED, "{C2185B}[AOOC] �������к� %s: %s", ReturnName(playerid), params);
	return 1;
}

CMD:revice(playerid, params[])
{
	new 
		playerb,
		str[128]
	;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/revive [���ͺҧ��ǹ/�ʹ�]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(GetPlayerTeam(playerb) == PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "������������Ѻ�Ҵ��");
	
	format(str, sizeof(str), "%s ����� %s ��鹨ҡ��úҴ��", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str); 
	
	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(playerb, 100); 
	
	TogglePlayerControllable(playerb, 1); 
	SetPlayerWeather(playerb, globalWeather);  
	
	SetPlayerChatBubble(playerb, "(( �Դ ))", COLOR_WHITE, 21.0, 3000); 
	GameTextForPlayer(playerb, "~b~You were revived", 3000, 4);
	
	ClearDamages(playerb);
	return 1;
}

CMD:listweapons(playerid, params[])
{
	new
		playerb,
		weapon_id[2][13]
	;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/listweapons [���ͺҧ��ǹ/�ʹ�]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
	
	
	SendClientMessageEx(playerid, COLOR_RED, "________** %s's Weapons **________", ReturnName(playerb));
	
	for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerb, i, weapon_id[0][i], weapon_id[1][i]); 
		
		if(!weapon_id[0][i])
			continue;
			
		SendClientMessageEx(playerid, COLOR_GRAD1, "%s [Ammo: %d]", ReturnWeaponName(weapon_id[0][i]), weapon_id[1][i]); 
	}
		
	return 1;
}

CMD:setplayerspawn(playerid, params[])
{
    if(!PlayerInfo[playerid][pAdmin])
    return SendUnauthMessage(playerid);

	new
		playerb,
		str[128]
	;

	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/setplayerspawn [���ͺҧ��ǹ/�ʹռ�����]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "�����������������Կ");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ �������к�");

	format(str, sizeof(str), "%s ���� %s. �����Դ���ش�Դ�ͧ������", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);

	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE);
	SetPlayerHealth(playerb, 100);
	//ClearDamages(playerb);

	SpawnPlayer(playerb);
	return 1;
}
/// Admin Level: 1;



// Admin Level: 2:
CMD:clearreports(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return 0;
		
	new reportCount = 0;
	
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][rReportExists] == true)
		{
			reportCount++;
		}
	}
	if(reportCount)
	{		
		Dialog_Show(playerid, DIALOG_CLEARREPORT, DIALOG_STYLE_MSGBOX, "{FFFFFF}�س�ѹ���׻��Ƿ���ź�����§ҹ������?", "����§ҹ������ {FF6347}%d{FFFFFF}", "�׹�ѹ", "¡��ԡ",reportCount);

	}
	else return SendServerMessage(playerid, "����ա����§ҹ");
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, weaponid, ammo, idx, str[128];
	
	if(sscanf(params, "uii", playerb, weaponid, ammo))
	{
		SendUsageMessage(playerid, "/givegun [���ͺҧ��ǹ/�ʹ�] [�ʹ����ظ] [����ع]");
		SendServerMessage(playerid, "���ظ���س�ʡ���ж١૿���㹵�Ǽ�����"); 
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "�����������ӡ���������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "���ظ��ǡ���Ƕ١Ẻ�͡�ҡ�׿�����");
		
	if(ammo < 1)return SendErrorMessage(playerid, "����ع��ͧ�ҡ���� 1 �ش");
	
	idx = ReturnWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerb][pWeapons][idx])
		SendServerMessage(playerid, "%s ��ź���ظ %s ��С���ع %d �͡", ReturnName(playerb), ReturnWeaponName(PlayerInfo[playerb][pWeapons][idx]), PlayerInfo[playerb][pWeaponsAmmo][idx]);
	
	GivePlayerWeapon(playerb, weaponid, ammo); 
	
	PlayerInfo[playerb][pWeapons][idx] = weaponid;
	PlayerInfo[playerb][pWeaponsAmmo][idx] = ammo; 
	
	format(str, sizeof(str), "%s �ʡ���ظ���Ѻ %s ��� %s ������Ѻ����ع %d �ش", ReturnName(playerid), ReturnName(playerb), ReturnWeaponName(weaponid), ammo);
	SendAdminMessage(2, str);
	
	SendServerMessage(playerb, "�س���ͺ���ظ %s ��С���ع %d �ش", ReturnWeaponName(weaponid), ammo);
	return 1;
}

CMD:clearpguns(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, displayString[128], str[128]; 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/clearpguns [���ͺҧ��ǹ/�ʹ�]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
		
	for(new i = 0; i < 13; i ++)
	{
		if(PlayerInfo[playerb][pWeaponsAmmo][i] > 0)
		{
			format(displayString, sizeof(displayString), "%s%s - %d Ammo\n", displayString, ReturnWeaponName(PlayerInfo[playerb][pWeapons][i]), PlayerInfo[playerb][pWeaponsAmmo][i]);
			
			PlayerInfo[playerb][pWeapons][i] = 0;
			PlayerInfo[playerb][pWeaponsAmmo][i] = 0;
		}
	}
	
	Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Weapons Cleared:", displayString, "<<", ""); 
	TakePlayerGuns(playerb); 
	
	format(str, sizeof(str), "%s ź���ظ�ͧ %s �����������㹵��", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new id;
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotohouse [�ʹ�-��ҹ]");

	if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
		return SendErrorMessage(playerid, "����պ�ҹ����ͧ���");
	
	SetPlayerPos(playerid, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2]);
	SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
	SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);

	if(PlayerInfo[playerid][pInsideBusiness] || PlayerInfo[playerid][pInsideProperty])
	{
		PlayerInfo[playerid][pInsideBusiness] = 0;
		PlayerInfo[playerid][pInsideProperty] = 0;
	}
	return 1;
}
CMD:gotobusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new id;
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotobusiness [�ʹ�-�Ԩ���]");

	if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "����աԨ��÷���ͧ���");
	
	SetPlayerPos(playerid, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2]);
	SetPlayerVirtualWorld(playerid, BusinessInfo[id][BusinessEntranceWorld]);
	SetPlayerInterior(playerid, BusinessInfo[id][BusinessEntranceInterior]);

	if(PlayerInfo[playerid][pInsideBusiness] || PlayerInfo[playerid][pInsideProperty])
	{
		PlayerInfo[playerid][pInsideBusiness] = 0;
		PlayerInfo[playerid][pInsideProperty] = 0;
	}
	return 1;
}

CMD:gotofaction(playerid, params[])
{

	return 1;
}

CMD:gotopoint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new
		Float:x,
		Float:y,
		Float:z,
		interior,
		World
	; 
	
	if(sscanf(params, "fffii", x, y, z, interior, World))
		return SendUsageMessage(playerid, "/gotopoint [x] [y] [z] [interior id] [World-id]");

	
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid, interior);
	SetPlayerVirtualWorld(playerid, World);

	SendTeleportMessage(playerid);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}

	return 1;
}

CMD:noooc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new
		str[128]
	;
		
	if(!oocEnabled)
	{
		format(str, sizeof(str), "%s �Դ�к�᪷ OOC", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "�к�᪷ OOC �١�Դ�¼������к�"); 
		oocEnabled = true;
	}
	else
	{
		format(str, sizeof(str), "%s �Դ�к�᪷ OOC", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "�к�᪷ OOC �١�Դ�¼������к�"); 
		oocEnabled = false;
	}
	return 1;
}


CMD:backup(playerid, params[])
{
	foreach(new i : Player)
	{
		CharacterSave(i);
	}
	return 1;
}

CMD:repair(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new veh = GetPlayerVehicleID(playerid);
	    new	str[128], Float:angle;
	

		if(PlayerInfo[playerid][pAdmin] < 2)
		return 0;


		format(str, sizeof(str), "%s repaired vehicle ID %i.", ReturnName(playerid), veh);
		SendAdminMessage(1, str);

		RepairVehicle(veh);
		SetVehicleHealth(veh, 900);

		GetVehicleZAngle(veh, angle);
		SetVehicleZAngle(veh, angle);
		return 1;

	}
	
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new 
		str[128],
		vehicleid,
		Float:angle
	;
	
	if(sscanf(params, "i", vehicleid))
		return SendUsageMessage(playerid, "/repair [�ʹ�ö]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "�����ö�ʹչ��");
		
	format(str, sizeof(str), "%s repaired vehicle ID %i.", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	
	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 900); 
	
	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return 1; 
}
// Admin Level: 2;

// Admin Level: 3:

CMD:spawncar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);

	new vehicleid = INVALID_VEHICLE_ID, modelid, color1, color2, siren, str[128], Float:a;
	new Float:X,Float:Y,Float:Z;
	
	if(sscanf(params, "iI(0)I(0)I(0)", modelid, color1, color2, siren))
	{
		SendUsageMessage(playerid, "/spawncar [���ö] [�շ�� 1] [�շ�� 2] [�к���ù]");
		SendServerMessage(playerid, "�繡�����ҧö�������੾�м������к���ҹ�鹷�������ö��ҹ��"); 
		return 1;
	}

	if(!color1)
		color1 = random(255);

	if(!color2)
		color2 = random(255);

	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "������ʹ�ö���س��ͧ���");
		
	if(color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "�ô��������١����");

	GetPlayerFacingAngle(playerid, a);
	GetPlayerPos(playerid, X, Y, Z);

	vehicleid = CreateVehicle(modelid, X, Y, Z, a, color1, color2, -1, siren);
	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleAdminSpawn] = true;
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		
		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
		VehicleInfo[vehicleid][eVehicleFuel] = 50;
	}
	
	PutPlayerInVehicle(playerid, vehicleid, 0);
	SetVehicleHp(vehicleid);
	format(str, sizeof(str), "%s ���ʡö �ʹ�Թ %s �͡��", ReturnName(playerid), ReturnVehicleName(vehicleid));
	SendAdminMessage(3, str);
	return 1;
}

CMD:despawncar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new veh = GetPlayerVehicleID(playerid);
	    new str[320];
	    
		if(PlayerInfo[playerid][pAdmin] < 3)
		return 0;
		
		
		if(VehicleInfo[veh][eVehicleAdminSpawn] == false)
		return SendErrorMessage(playerid, "�س�������öźö��������ö �ʹ�Թ ��");

		format(str, sizeof(str), "%s despawned %s (%d).", ReturnName(playerid), ReturnVehicleName(veh), veh);
		SendAdminMessage(3, str);

		ResetVehicleVars(veh); DestroyVehicle(veh);
		return 1;
		
	}
		
	if(PlayerInfo[playerid][pAdmin] < 3)
		return 0;
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/despawncar [�ʹ�ö]");
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "������ʹ�ö���س��ͧ���");
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn] == false)
		return SendErrorMessage(playerid, "�س�������öźö��������ö�ʡ��"); 
	
	format(str, sizeof(str), "%s źö�ʡ %s (%d).", ReturnName(playerid), ReturnVehicleName(vehicleid), vehicleid);
	SendAdminMessage(3, str);
		
	ResetVehicleVars(vehicleid); DestroyVehicle(vehicleid);
	return 1;
}

CMD:despawncars(playerid, params[])
{
	new str[128];

	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);

	for(new v = 1; v < MAX_VEHICLES; v++)
	{
		if(VehicleInfo[v][eVehicleAdminSpawn] == false)
			continue;

		ResetVehicleVars(v); DestroyVehicle(v);
	}
	format(str, sizeof(str), "%s źö�ʡ������", ReturnRealName(playerid, 0));
	SendAdminMessage(3, str);
	return 1;
}

CMD:pcar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	new playerb, modelid, color1, color2;
	
	if(sscanf(params, "uiii", playerb, modelid, color1, color2))
	{
		SendUsageMessage(playerid, "/pcar [����/�ʹ�] [����-�ʹ�] [�շ�� 1] [�շ�� 2]");
		SendServerMessage(playerid, "�����蹨����Ѻö���س�ʹ�");
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "��������������������׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
	
	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "������ʹ�ö����ͧ���");
		
	if(color1 < 0 || color2 < 0 || color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "�ô���͡�����١��ͧ"); 
		
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(!PlayerInfo[playerb][pOwnedVehicles][i])
		{
			playerInsertID[playerb] = i;
			break;
		}
	}
	if(!playerInsertID[playerb])
	{
		SendErrorMessage(playerid, "%s ö㹵�Ǣͧ�س��� ���͵����", ReturnName(playerb));
	}
	else
	{
		new insertQuery[256];
		
		mysql_format(dbCon, insertQuery, sizeof(insertQuery), "INSERT INTO vehicles (`VehicleOwnerDBID`, `VehicleModel`, `VehicleColor1`, `VehicleColor2`, `VehicleParkPosX`, `VehicleParkPosY`, `VehicleParkPosZ`, `VehicleParkPosA`) VALUES(%i, %i, %i, %i, 1705.4175, -1485.9148, 13.3828, 87.5097)",
			PlayerInfo[playerb][pDBID], modelid, color1, color2);
		mysql_tquery(dbCon, insertQuery, "Query_AddPlayerVehicle", "ii", playerid, playerb); 
	}
	
	return 1;
}
CMD:setstats(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
	
	new 
		playerb, 
		statid, 
		value,
		str[128]
	;
	
	if(sscanf(params, "uiI(-1)", playerb, statid, value))
	{
		SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] [stat code] [value]"); 
		SendClientMessage(playerid, COLOR_WHITE, "1. Faction Rank, 2. Mask, 3. Radio, 4. Bank Money, 5. Level,");
		SendClientMessage(playerid, COLOR_WHITE, "6. EXP, 7. Paycheck");
		return 1;
	}


	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 

	switch(statid)
	{
		case 1: 
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] 1 [value required]"); 
		
			if(value < 1 && value != -1 || value > 20)
				return SendErrorMessage(playerid, "��/����˹�����§�� (1-20)");
				
			PlayerInfo[playerb][pFactionRank] = value;
			CharacterSave(playerb); 
			
			format(str, sizeof(str), "%s ��駤�� %s ����ç��/����˹��ʹ�  %i", ReturnName(playerid), ReturnName(playerb), value); 
			SendAdminMessage(3, str); 
		}
		case 2:
		{
			if(!PlayerInfo[playerb][pHasMask])
				PlayerInfo[playerb][pHasMask] = true;
				
			else PlayerInfo[playerb][pHasMask] = false;
			
			format(str, sizeof(str), "%s %s %s's Mask.", ReturnName(playerid), (PlayerInfo[playerb][pHasMask] != true) ? ("took") : ("set"), ReturnName(playerb));
			SendAdminMessage(3, str); 
		}
		case 3:
		{
			if(!PlayerInfo[playerb][pHasRadio])
				PlayerInfo[playerb][pHasRadio] = true;
				
			else PlayerInfo[playerb][pHasRadio] = false;
			
			format(str, sizeof(str), "%s %s %s's Radio.", ReturnName(playerid), (PlayerInfo[playerb][pHasRadio] != true) ? ("took") : ("set"), ReturnName(playerb));
			SendAdminMessage(3, str);
		}
		case 4:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] 4 [value required]"); 
		
			format(str, sizeof(str), "%s ��駤�� %s ������Թ㹸�Ҥ��: $%s (�ҡ��� $%s)", ReturnName(playerid), ReturnName(playerb), MoneyFormat(value), MoneyFormat(PlayerInfo[playerb][pBank])); 
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pBank] = value;
			CharacterSave(playerb);
		}
		case 5:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] 5 [value required]"); 
		
			if(value < 1 && value != -1)
				return SendErrorMessage(playerid, "����Ť�õ�������������Ѻ����컡��");

			format(str, sizeof(str), "%s ��駤�� %s ����������: %i (�ҡ��� %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pLevel]);
			SendAdminMessage(3, str); 
			
			PlayerInfo[playerb][pLevel] = value; SetPlayerScore(playerb, value);
			CharacterSave(playerb);
		}
		case 6:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] 6 [value required]"); 
		
			format(str, sizeof(str), "%s ��駤�� %s ����һ��ʺ��ó���: %i (�ҡ��� %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pExp]);
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pExp] = value;
			CharacterSave(playerb);
		}
		case 7:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [���ͺҧ��ǹ/�ʹ�] 7 [value required]");
				
			format(str, sizeof(str), "%s ��駤�� %s's ����Ҩ�ҧ��ª������: %i (�ҡ��� %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pPaycheck]);
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pPaycheck] = value; 
			CharacterSave(playerb);
		}
	}
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	new playerb, value, str[128];
	
	if(sscanf(params, "ui", playerb, value))
		return SendUsageMessage(playerid, "/givemoney [���ͺҧ��ǹ/�ʹ�] [�ӹǹ]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	GiveMoney(playerb, value);
	SendServerMessage(playerb, "�س���Ѻ�Թ�ӹǹ $%s �ҡ �������к� %s", MoneyFormat(value), ReturnName(playerid));

	format(str, sizeof(str), "%s �ʡ�Թ�ӹǹ $%s ���Ѻ %s", ReturnName(playerid), MoneyFormat(value), ReturnName(playerb));
	SendAdminMessage(3, str);
	return 1;
}

CMD:setcar(playerid, params[])
{
	new	vehicleid, a_str[60], b_str[60];
	new str[128], value, Float:life; 
	
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);
		
	if(sscanf(params, "is[60]S()[60]", vehicleid, a_str, b_str))
	{
		SendUsageMessage(playerid, "/setcar [�ʹ�ö] [params]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} locklvl, alarmlvl, immoblvl, timesdestroyed,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} enginelife, batterylife, color1, color2, paintjob, plates."); 
		return 1;
	}
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "������ʹ�ö����ͧ���"); 
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendErrorMessage(playerid, "�������ö�����觹��Ѻö��ǹ�ؤ��(ö�ʡ)��");
		
	if(!strcmp(a_str, "locklvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid locklvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ����:1-4");
		
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к���ͤ�� %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleLockLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "alarmlvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid alarmlvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ����:1-4");
		
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i �к� 'Alarm' ���дѺ %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "immoblvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid immoblvl [1-5]"); 
			
		if(value > 5 || value < 1)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ����:1-5");
		
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'immobiliser' ���дѺ %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleImmobLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "timesdestroyed"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid timesdestroyed [value]");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'time destroyed' ��ѧ�дѺ %i (�ҡ��� %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleTimesDestroyed]); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "enginelife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid enginelife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ���� (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'engine life' ��ѧ�дѺ %.2f. (�ҡ��� %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleEngine]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleEngine] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "batterylife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid batterylife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ���� (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'battery life' ��ѧ�дѺ %.2f. (�ҡ��� %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleBattery]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleBattery] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color1"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color1 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ���� (0-255)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'color1' ��ѧ�дѺ %i (�ҡ��� %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor1]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "�ô��ö�������������¡�͡������");
		
		VehicleInfo[vehicleid][eVehicleColor1] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color2"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color2 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ���� (0-255)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'color2' ��ѧ�дѺ %i (�ҡ��� %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor2]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "�ô��ö�������������¡�͡������");
		
		VehicleInfo[vehicleid][eVehicleColor2] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "paintjob"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid paintjob [0-2, 3 to remove]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "��ҵ�ͧ�������������Թ���� (0-255)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'paintjob' ��ѧ�дѺ %i. (�ҡ��� %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehiclePaintjob]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "�ô��ö�������������¡�͡������");
		
		VehicleInfo[vehicleid][eVehiclePaintjob] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "plates"))
	{
		new
			plates[32]; 
			
		if(sscanf(b_str, "s[32]", plates))
			return SendUsageMessage(playerid, "/setcar vehicleid plates [plates]"); 
			
		if(strlen(plates) > 6 || strlen(plates) < 6)
			return SendErrorMessage(playerid, "���·���¹��ͧ���ҡ���� 6 ����ѡ�� (����͵�����ҧ���·���¹�ͧ ����� ���ʿ����: Q123Q1)");
			
		format(str, sizeof(str), "%s ��駤��ö�ʹ� %i ����к� 'plates' ��ѧ�дѺ \"%s\". (�ҡ��� %s)", ReturnName(playerid), vehicleid, plates, VehicleInfo[vehicleid][eVehiclePlates]);
		SendAdminMessage(3, str);
		
		format(VehicleInfo[vehicleid][eVehiclePlates], 32, "%s", plates); 
		SaveVehicle(vehicleid);
	}
	return 1;
}
// Admin Level: 3;

// Admin Level: 4:
CMD:factions(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid);
	new str[182], longstr[556]; 

	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(!FactionInfo[i][eFactionDBID])
			continue;
			
		format(str, sizeof(str), "{ADC3E7}%d \t %s \t [%d out of %d]\n", i, FactionInfo[i][eFactionName], ReturnOnlineMembers(i), ReturnTotalMembers(i));
		strcat(longstr, str);

	}
	
	Dialog_Show(playerid, DIALOG_EDITFACTION, DIALOG_STYLE_LIST, "Factions:", longstr, "<<", "");
	return 1;
}
// Admin Level: 4;

// Admin Level: 5:
CMD:makeleader(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new playerb, factionid, str[MAX_STRING];
	
	if(sscanf(params, "ud", playerb, factionid))
		return SendUsageMessage(playerid, "/makeleader [���ͺҧ��ǹ/�ʹ�] [faction id]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

	if(!FactionInfo[factionid][eFactionDBID]) return SendErrorMessage(playerid, "�����࿤��蹷��س�к�");

	if(PlayerInfo[playerb][pFaction] != 0)
	{
		PlayerMakeleader[playerb] = playerid;
		PLayerMakeleaderFacID[playerb] = factionid;
		Dialog_Show(playerb, DIALOG_COM_FAC_INV, DIALOG_STYLE_MSGBOX, "�س���?", "�س��࿤����������� �س�������������������¹࿤������ %s", "�Թ�ѹ", "¡��ԡ",FactionInfo[factionid][eFactionName]);
		return 1;
	}

	PlayerInfo[playerb][pFaction] = factionid;
	PlayerInfo[playerb][pFactionRank] = 1;

	if(FactionInfo[factionid][eFactionType] == GOVERMENT)
	{
		PlayerInfo[playerb][pBadge] = random(99999);
	}
	foreach (new i : Player)
	{
		if(PlayerInfo[i][pFaction] != factionid)
			continue;
		
		SendClientMessageEx(i, -1, "{2ECC71}**((%s: ��������࿤��蹢ͧ�ǡ�س����))**", ReturnName(playerid));
	}
	SendClientMessageEx(playerid, -1,"{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} �س�������� %s �����˹��࿤��� �ͧ %s",ReturnRealName(playerb,0),FactionInfo[factionid][eFactionName]);

	format(str, sizeof(str), "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} %s ��駤����� %s �����˹�ҡ����࿤��� %s", ReturnRealName(playerid,0), ReturnRealName(playerb,0), FactionInfo[factionid][eFactionName]);
	SendAdminMessage(4, str);

	CharacterSave(playerb);
	return 1;
}


CMD:makehouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);
	
	new price,level,str[MAX_STRING], name[90];

	if(sscanf(params, "s[90]dd", name, price, level))
		return SendUsageMessage(playerid, "/makehouse [���ͺ�ҹ(�������ҹ�Ţ���)] [�Ҥ�-��ҹ] [�����-��ҹ]");

	if(strlen(name) > 90)
	{
		SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}�س�������ö��駪��ͺ�ҹ�Թ 90 ����ѡ����");
		return SendUsageMessage(playerid, "/makehouse [���ͺ�ҹ(�������ҹ�Ţ���)] [�Ҥ�-��ҹ] [�����-��ҹ]");
	}
	if(price < 1 || price > 90000000)
	{
		SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}�س�������ö����Ҥ� $%s �����ͧ�ҡ���Ҥ��Թ����˹�/���֧����˹� 1 < || > 90,000,000",MoneyFormat(price));
		return SendUsageMessage(playerid, "/makehouse [���ͺ�ҹ(�������ҹ�Ţ���)] [�Ҥ�-��ҹ] [�����-��ҹ]");
	}
	if(level < 1 || level > 90000000)
	{
		SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}�س�������ö�������� %i �����ͧ�ҡ��������Թ����˹�/���֧����˹� 1 < || > 90000000",level);
		return SendUsageMessage(playerid, "/makehouse [���ͺ�ҹ(�������ҹ�Ţ���)] [�Ҥ�-��ҹ] [�����-��ҹ]");
	}
	
	format(name, sizeof(name),name);
	format(str, sizeof(str), "�س���ѧ�����ҧ��ҹ: %s\n\
							  �Ҥ�: $%s\n\
							  ����: %i", name,MoneyFormat(price),level);

	PlayerCreHouse[playerid] = name;
	PlayerCreHousePrice[playerid] = price;
    PlayerCreHouseLevel[playerid] = level;

	Dialog_Show(playerid, DIALOG_CRE_HOUSE, DIALOG_STYLE_MSGBOX, "�س�ѹ�?", str, "�׹�ѹ", "¡��ԡ");

	return 1;
}

CMD:viewhouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);
	
	new str[182], longstr[556], str_h[MAX_STRING];
	new Houseid; 
	for (new i = 1; i < MAX_HOUSE; i ++)
	{
		if(!HouseInfo[i][HouseDBID])
			continue;
			
		format(str, sizeof(str), "{ADC3E7}%d \t %s \t\n", i, HouseInfo[i][HouseName]);
		strcat(longstr, str);

		format(str_h, sizeof(str_h), "%d",Houseid);
		SetPVarInt(playerid, str_h, i);

		Houseid++;
		
	}
	
	Dialog_Show(playerid, DIALOG_VIEWHOUSE, DIALOG_STYLE_LIST, "HOUSE:", longstr, "���͡", "�͡");
	return 1;
}

CMD:makeentrance(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new idx = 0;
	
    for (new i = 1; i < MAX_ENTRANCE; i ++)
    {
        if(!EntranceInfo[i][EntranceDBID])
        {
            idx = i; 
            break;
        }
	}
    if(idx == 0)
    {
        return SendServerMessage(playerid, "���ҧ entrance �Թ���ҹ����������� (30)");
    }

	new iconid;

	if(sscanf(params, "d", iconid))
		return SendUsageMessage(playerid, "/makeentrance [�ͤ͹-�ʹ�]");

	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	
	new World = GetPlayerVirtualWorld(playerid);
	new Interior = GetPlayerInterior(playerid);

	new query[MAX_STRING];

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO entrance (`EntranceIconID`,`EntranceLocX`,`EntranceLocY`,`EntranceLocZ`,`EntranceLocWorld`,`EntranceLocInID`) VALUES(%d,%f,%f,%f,%d,%d)",iconid,x,y,z,World,Interior); 
	mysql_tquery(dbCon, query, "Query_InsertEntrance", "dddfffdd", playerid, idx, iconid,x,y,z,World,Interior); 
	return 1;
}

alias:editentrance("editenter")
CMD:editentrance(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new id, str[MAX_STRING], longstr[MAX_STRING];

	if(sscanf(params, "d", id))
		return SendUsageMessage(playerid, "/edit(entr)ance [�ͤ͹-�ʹ�]");


	if(!EntranceInfo[id][EntranceDBID])
		return SendErrorMessage(playerid, "����� �ʹշ�� ��ͧ���");

	PlayerSeleteEnter[playerid] = id;

	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}����¹ �ͤ͹\n");
	strcat(longstr, str);
	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}����¹�ش��ҹ˹��\n");
	strcat(longstr, str);
	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}����¹�ش����\n");
	strcat(longstr, str);

	Dialog_Show(playerid, EDIT_ENTRANCE, DIALOG_STYLE_LIST, "Entrance Editer", longstr, "�׹�ѹ", "¡��ԡ");
	return 1;
}
// Admin Level: 5;


// Admin Level: 1336:
CMD:makebusiness(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new idx = 0;
	
    for (new i = 1; i < MAX_BUSINESS; i ++)
    {
        if(!BusinessInfo[i][BusinessDBID])
        {
            idx = i; 
            break;
        }
	}
    if(idx == 0)
    {
        return SendServerMessage(playerid, "���ҧ�Ԩ����Թ���ҹ����������� (30)"); 
    }


	new name[90],type;

	if(sscanf(params, "d", type))
	{
		SendUsageMessage(playerid, "/makebusiness [������]");
		SendUsageMessage(playerid, "Type: 1.��ҹ���(24/7) 2.��ҹ���᷹��˹���ö 3.��ҹ�׹");
		SendUsageMessage(playerid, "Type: 4.��ҹ����� 5.��Ҥ��");
		return 1;
	}

	if(strlen(name) > 90)
	{	
		SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0000} �س�������ö��駪��͡Ԩ����Թ 90 ����ѡ��");
		SendUsageMessage(playerid, "/makebusiness [������]");
		SendUsageMessage(playerid, "Type: 1.��ҹ���(24/7) 2.��ҹ���᷹��˹���ö 3.��ҹ�׹");
		SendUsageMessage(playerid, "Type: 4.��ҹ����� 5.��Ҥ��");
		return 1;
	}
	if(type < 1 || type > 6)
	{	
		SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0000} �ô����͡�������Ԩ������١");
		SendUsageMessage(playerid, "/makebusiness [������]");
		SendUsageMessage(playerid, "Type: 1.��ҹ���(24/7) 2.��ҹ���᷹��˹���ö 3.��ҹ�׹");
		SendUsageMessage(playerid, "Type: 4.��ҹ����� 5.��Ҥ��");
		return 1;
	}

	format(name, sizeof(name),name);
	new query[MAX_STRING];

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO business (`BusinessType`,`BusinessName`) VALUES(%i,'%e')", type,"BusinessName"); 
	mysql_tquery(dbCon, query, "Query_InsertBusiness", "iii", playerid, idx, type); 
	return 1;
}

CMD:viewbusiness(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);
	

	ShowViewBusiness(playerid);
	return 1;
}

alias:deletebusiness("delbusiness")
CMD:deletebusiness(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

    new id;
	if(sscanf(params, "d", id))
	{
		SendUsageMessage(playerid,"/del(ete)business [�ʹ�-�Ԩ���]");
		return 1;
	}

	if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "����� �ʹ� �Ԩ��÷��س��ͧ���");

	if(!BusinessInfo[id][BusinessOwnerDBID])
	{	
		RemoveBusiness(playerid,id);
		return 1;
	}

	if(BusinessInfo[id][BusinessOwnerDBID])
	{
		new OwnerBusiness = BusinessInfo[id][BusinessOwnerDBID];
		new AddMoney[MAX_STRING];
		
		foreach(new i : Player)
		{
			
			if(PlayerInfo[i][pDBID] != OwnerBusiness)
			{
				mysql_format(dbCon, AddMoney, sizeof(AddMoney), "UPDATE characters SET pBank = %d WHERE char_dbid = %i",	
					BusinessInfo[id][BusinessPrice] + BusinessInfo[id][BusinessCash],
					OwnerBusiness);
				mysql_tquery(dbCon, AddMoney);
			}
			else
			{	
				GivePlayerMoney(i, BusinessInfo[id][BusinessPrice]);

				if(BusinessInfo[id][BusinessCash])
					GivePlayerMoney(i, BusinessInfo[id][BusinessCash]);
				
				SendClientMessage(playerid, -1, "{33FF66}BUSINESS {F57C00}SYSTEM:{FF0000} ������㹤������ʴǡ���ͧ�ҡ�ա��ź�Ԩ��âͧ��ҹ�͡�ҡ�׿���������� �¼������к��֧����");
				SendClientMessageEx(playerid, -1, "{FF0000}...�е�ͧ�ͻ�зҹ���´��¶���ҡ�������к����������͹��ҹ��ǧ˹���ҡ�բ��ʧ�������ö�ͺ���������������� /report [�ͺ����Ԩ���]");
				CharacterSave(i);
			}
		}

		RemoveBusiness(playerid,id);
		return 1;
	}
	return 1;
}

alias:deletehouse("delhouse")
CMD:deletehouse(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

    new id;
	if(sscanf(params, "d", id))
	{
		SendUsageMessage(playerid,"/del(ete)house [�ʹ�-��ҹ]");
		return 1;
	}

	if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
		return SendErrorMessage(playerid, "����� �ʹ� ��ҹ���س��ͧ���");

	if(!HouseInfo[id][HouseOwnerDBID])
	{	
		RemoveHouse(playerid,id);
		return 1;
	}

	if(HouseInfo[id][HouseOwnerDBID])
	{
		new OwnerHouse = HouseInfo[id][HouseOwnerDBID];
		new AddMoney[MAX_STRING];
		
		foreach(new i : Player)
		{
			
			if(PlayerInfo[i][pDBID] != OwnerHouse)
			{
				mysql_format(dbCon, AddMoney, sizeof(AddMoney), "UPDATE characters SET pBank = %d WHERE char_dbid = %i",	
					HouseInfo[id][HousePrice],
					OwnerHouse);
				mysql_tquery(dbCon, AddMoney);
			}
			else
			{	
				GivePlayerMoney(i, HouseInfo[id][HousePrice]);
				
				SendClientMessage(i, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ������㹤������ʴǡ���ͧ�ҡ�ա��ź��ҹ�ͧ��ҹ�͡�ҡ�׿���������� �¼������к��֧����");
				SendClientMessageEx(i, -1, "{FF0000}...�е�ͧ�ͻ�зҹ���´��¶���ҡ�������к����������͹��ҹ��ǧ˹���ҡ�բ��ʧ�������ö�ͺ���������������� /report [�ͺ�����ҹ]");
				CharacterSave(i);
			}
		}

		RemoveHouse(playerid,id);
		return 1;
	}
	return 1;
}

alias:createvehicle("createveh","makevehicle")
CMD:createvehicle(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1336)
	    return SendErrorMessage(playerid, "�س�����������к�");

	new factionid, modelid, color1, color2;

	if(sscanf(params, "dddd", factionid,modelid,color1,color2))
		return SendUsageMessage(playerid,"/(createveh)icle [࿤���-�ʹ�] [����ö] [�շ��1] [�շ��2]");

	if(!FactionInfo[factionid][eFactionDBID])
		return SendErrorMessage(playerid, "�����࿤����ʹշ���ͧ���");

	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "������ʹ�ö���س��ͧ���");
		
	if(color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "�ô��������١����");

	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid, x,y,z);
	GetPlayerFacingAngle(playerid, a);
	new World = GetPlayerVirtualWorld(playerid);

	new thread[MAX_STRING]; 

	mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles ORDER BY VehicleDBID");
	mysql_tquery(dbCon, thread, "CountVehicle", "dddddffffd", playerid,factionid,modelid,color1,color2,x,y,z,a,World);
	return 1;
}
// Admin Level: 1336;

// Admin Level: 1337:
// Admin Level: 1337;

// Admin Level: 1338:
CMD:restart(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338)
	    return SendErrorMessage(playerid, "�س�����������к�");
	    
	foreach (new i : Player)
	{
		CharacterSave(i);
		SetPlayerName(i, e_pAccountData[i][mAccName]);
	}

	//Saving systems:
	/*SaveFactions();
	SaveProperties();
	SaveBusinesses();*/

	//Closing database:
	mysql_close(dbCon);
	SendRconCommand("gmx");
	return 1;
	
}

// Admin Level: 1338;

// Admin Level: 1339:
CMD:callpaycheck(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1339)
		return 0;
		
	Dialog_Show(playerid,  DIALOG_CALLPAYCHECK, DIALOG_STYLE_MSGBOX,"Confirmation", "�س������������зӡ�ê��¤����ª���������ҹ��?\n\n��á�зӢͧ�س�Ҩ�мԴ���ͧ�������к���", "�׹�ѹ", "¡��ԡ"); 
	return 1;
}

CMD:makefaction(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1339)
		return SendUnauthMessage(playerid);
		
	new varAbbrev[30], varName[90]; 
	
	if(sscanf(params, "s[30]s[90]", varAbbrev, varName))
	{
		SendUsageMessage(playerid, "/makefaction [�������࿤���] [����࿤���]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} ���繵�ͧ������࿤��蹴���");
		return 1; 
	}
	
	if(strlen(varName) > 90)
		return SendErrorMessage(playerid, "�������࿤��蹤�ù��¡��� 90 ����ѡ��"); 
		
	new idx = 0;
	
	for (new i = 1; i < MAX_FACTIONS; i ++)
	{
		if(!FactionInfo[i][eFactionDBID])
		{
			idx = i; 
			break;
		}
	}
	if(idx == 0)
	{
		return SendServerMessage(playerid, "������ҧ࿤��蹶֧�մ�ӡѴ����"); 
	}

	SendServerMessage(playerid, "���ѧ���ҧ࿵���......");
	
	new thread[128]; 
	
	mysql_format(dbCon, thread, sizeof(thread), "INSERT INTO factions (`FactionName`, `FactionAbbrev`) VALUES('%e', '%e')", varName, varAbbrev);
	mysql_tquery(dbCon, thread, "Query_InsertFaction", "issi", playerid, varAbbrev, varName, idx);
	
	return 1;
}
CMD:makeadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1339)
		return SendUnauthMessage(playerid);

	new playerb, level;
	if(sscanf(params,"ui",playerb,level))
	{
		SendUsageMessage(playerid, "/makeadmin [���ͺҧ��ǹ/�ʹ�] [�����]");
		return 1;
	}

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");

	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

	/*if(!PlayerInfo[playerb][pAdmin])
		return SendErrorMessage(playerid, "�����蹤����������繼������к���������");*/
	
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "�س�������ö��Ѻ����˹觼������к�����٧���Ҥس��");
	
	if(level == 0)
	{
		PlayerInfo[playerb][pAdmin] = 0;
		SendClientMessageEx(playerb, -1, "{FF5722}ADMIN SYSTEM:{FFFFFF}�س��١ź�ҡ����繼������к����� �ͺ�س���������ǹ�֧㹵��˹觹��");
		CharacterSave(playerb);
		return 1;
	}
	if(level > 1339)
		return SendErrorMessage(playerid, "�س�������ö������˹觼������к�����ҡ���� (1339) ��");

	PlayerInfo[playerb][pAdmin] = level;
	SendClientMessageEx(playerb, -1, "{FF5722}ADMIN SYSTEM:{FFFFFF}�س���Ѻ����˹觼������к� (%d)",level);
	new str[MAX_STRING];
	format(str, sizeof(str), "%s ����������˹觼������к� %d ���Ѻ %s",ReturnRealName(playerid,0),level,ReturnRealName(playerb,0));
	SendAdminMessage(4,str);


    return 1;
}

CMD:randomphone(playerid, params[])
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pPhone])
			continue;

		PlayerInfo[i][pPhone] = random(99999);
		CharacterSave(i);
	}
	return 1;
}
// Admin Level: 1339;

stock SendAdminMessage(level, const str[])
{
	new 
		newString[128]
	;
	
	format(newString, sizeof(newString), "AdmWarn(%i): %s", level, str);
	
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pAdminDuty] == true)
		{
			SendClientMessage(i, COLOR_YELLOWEX, newString);
		}
	}
	return 1;
}

stock SendAdminMessageEx(color, level, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerInfo[i][pAdmin] >= level) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] >= level) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendUnauthMessage(playerid)
{
    new str[MAX_STRING];

    if(PlayerInfo[playerid][pAdmin])
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�����������к�");
    
    format(str, sizeof(str), "{F44336}%s {FFEB3B}�ա����ҹ�����觢ͧ�������к�(�������ö��ҹ��)", ReturnRealName(playerid)); 
	SendAdminMessage(99, str);

	return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�����������к�");
}

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(!PlayerInfo[playerid][pAdmin])
		return 1;

	new playerb = clickedplayerid;

	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerb);

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			SendServerMessage(playerid,"X:%f Y:%f Z:%f", PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			SendServerMessage(playerid, "�͹���س���ѧ��ͧ������ %s  /specoff ������ش��ͧ", ReturnName(playerb));
		}

		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectateVehicle(playerid, vehicleid);
			
		PlayerInfo[playerid][pSpectating] = playerb;

		return 1;
	}
	else
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			SendServerMessage(playerid,"X:%f Y:%f Z:%f", PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			SendServerMessage(playerid, "�͹���س���ѧ��ͧ������ %s  /specoff ������ش��ͧ", ReturnName(playerb));
		}

		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectatePlayer(playerid, playerb);
			
		PlayerInfo[playerid][pSpectating] = playerb;
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(RELEASED(KEY_WALK))
	{
		if(!PlayerInfo[playerid][pAdmin])
			return 1;

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
			return 1;

		
		TogglePlayerSpectating(playerid, false);
		return 1;
	}
	return 1;
}

Dialog:DIALOG_CALLPAYCHECK(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;
	
	CallPaycheck();
	return 1;
}
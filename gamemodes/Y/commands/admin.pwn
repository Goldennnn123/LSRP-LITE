#include <YSI_Coding\y_hooks>

CMD:acmds(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /aduty, /forumname, /goto, /gethere, /a (achat), /showmain, /kick /checkucp"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /unjail, /setint, /setworld, /setskin, /health, /reports, /ar (accept), /dr (disregard),"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /slap, /mute, /freeze, /unfreeze, /spec, /specoff, /stats (id), /gotols, /respawncar,"); 
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 1:{FFFFFF} /gotocar, /getcar, /listmasks, /dropinfo, /aooc, /revice, /towcars (aduty), /listweapons");
	}
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /setarmour, /clearreports, /givegun, /clearpguns, /gotohouse, /gotofaction, /gotopoint,");
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /gotobusiness, /noooc, /backup, /repair.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 2:{FFFFFF} /acceptwhitelist");
	}
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "LEVEL 3:{FFFFFF} /spawncar, /despawncar, /pcar, /setstats, /GiveMoney, /setcar.");
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
		
		format(str, sizeof(str), "{FF5722}%s {43A047}ได้ออกจากการปฏิบัตรหน้าที่เป็นผู้ดูแลระบบแล้วในขณะนี้", ReturnRealName(playerid)); 
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
		
		format(str, sizeof(str), "{FF5722}%s {43A047}ได้เริ่มปฏิบัตรหน้าที่เป็นผู้ดูแลระบบแล้วในขณะนี้", ReturnRealName(playerid)); 
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
		
	if(isnull(params)) return SendUsageMessage(playerid, "/a (แอดมินแชท) [ข้อความ]"); 
	
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
    if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return SendUnauthMessage(playerid);
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/forumname [ชื่อฟอรั่ม]");
		
	if(strlen(params) > 60)
		return SendErrorMessage(playerid, "ชื่อฟอรั่มของคุณควรยาวไม่เกิน 60 ตัวอักษร");
	
	format(e_pAccountData[playerid][mForumName], 60, "%s", params);
	SendServerMessage(playerid, "คุณได้ตั้งชื่อฟอรั่มของคุณเป็น: %s", params);  
	
	CharacterSave(playerid);
    return 1;
}

CMD:goto(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/goto [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
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


CMD:gotojob(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 

	new jobid;

	if(sscanf(params, "d", jobid))
	{
		SendClientMessage(playerid, -1, "[JOB:] 1.ชาวไร่ 2.พนักงานส่งของ 3.ช่างยนต์ 4.นักขุดเหมือง");
		return 1;
	}

	switch(jobid)
	{
		case 1:
		{
			SetPlayerPos(playerid, -382.5893, -1426.3422, 26.2217);
			SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
			if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
			{
				PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
			}
			SendClientMessage(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ งาน ชาวไร่");
			return 1;
		}
		case 2:
		{
			SetPlayerPos(playerid, -242.5856,-235.4501,2.4297);
			SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
			if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
			{
				PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
			}
			SendClientMessage(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ งาน ส่งของ");
			return 1;
		}
		case 3:
		{
			SetPlayerPos(playerid, 88.1169,-164.9625,2.5938);
			SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
			if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
			{
				PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
			}
			SendClientMessage(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ งาน ช่างยนต์");
			return 1;
		}
		case 4:
		{
			SetPlayerPos(playerid, 586.4755,872.6391,-42.4973);
			SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
			if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
			{
				PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
			}
			SendClientMessage(playerid, -1, "คุณได้เคลื่อนย้ายไปที่ งาน นักขุดเหมือง");
			return 1;
		}
		default : SendErrorMessage(playerid, "ไม่มี อาชีพที่ต้องการ");
	}
	return 1;
}

CMD:gethere(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/gethere [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
	
	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER)
		SetVehiclePos(GetPlayerVehicleID(playerb), PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY] -1, PlayerInfo[playerid][pLastPosZ]);
		
	else
		SetPlayerPos(playerb, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY] -1, PlayerInfo[playerid][pLastPosZ]);
		
	SetPlayerVirtualWorld(playerb, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(playerb, GetPlayerInterior(playerid)); 
	PlayerInfo[playerb][pInsideProperty] = PlayerInfo[playerid][pInsideProperty];
	PlayerInfo[playerb][pInsideBusiness] = PlayerInfo[playerid][pInsideBusiness];
		
	SendTeleportMessage(playerb);
	SendServerMessage(playerb, "คุณถูกเคลื่อนย้ายโดยผู้ดูแลระบบ  %s", ReturnRealName(playerb));
	
	return 1;
}

CMD:showmain(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/showmain [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
	
	SendServerMessage(playerid, "%s' UCP \"%s\" (DBID: %i).", ReturnRealName(playerb), e_pAccountData[playerb][mAccName], e_pAccountData[playerb][mDBID]);	
	return 1;
}

CMD:kick(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin] && PlayerInfo[playerid][pTester] < 2)
		return SendUnauthMessage(playerid); 


	if(!e_pAccountData[playerid][mForumName])
		return SendErrorMessage(playerid, "กรุณาตั้งชื่อฟอรั่มของคุณก่อน");
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/kick [ชื่อบางส่วน/ไอดี] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่ได้สามารถเตะ ผู้ดูแลระบบที่มีต่ำแหน่งสูงกว่าคุณได้", ReturnRealName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ถูกเตะออกจากเซืฟเวอร์โดย %s สาเหตุ: %.56s", ReturnRealName(playerb), e_pAccountData[playerid][mForumName], reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ถูกเตะออกจากเซืฟเวอร์โดย %s สาเหตุ: %s", ReturnRealName(playerb), e_pAccountData[playerid][mForumName], reason);
	
	new insertLog[256];
	
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
	{
		SendServerMessage(playerid, "ผู้เล่น (%s) ถูกเตะออกจากเซืฟเวอร์ขณะเข้าสู่ระบบ", ReturnRealName(playerb));
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

	if(!e_pAccountData[playerid][mForumName])
		return SendErrorMessage(playerid, "กรุณาตั้งชื่อฟอรั่มของคุณก่อน");
		
	new playerb, reason[120];
	
	if (sscanf(params, "us[120]", playerb, reason)) 
		return SendUsageMessage(playerid, "/ban [ชื่อบางส่วน/ไอดี] [reason]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "You can't ban %s.", ReturnName(playerb)); 
		
	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ได้ถูกแบนออกจากเซืฟเวอร์โดย %s สาเหตุ: %.56s", ReturnName(playerb), e_pAccountData[playerid][mForumName], reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ได้ถูกแบนออกจากเซืฟเวอร์โดย %s สาเหตุ: %s", ReturnName(playerb), e_pAccountData[playerid][mForumName], reason);
	
	new insertLog[256];
	
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
	{
		SendServerMessage(playerid, "ผู้เล่น (%s) ได้ถูกแบนออกจากเซืฟเวอร์ขณะเข้าสู่ระบบ", ReturnName(playerb));
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

CMD:checkucp(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
	
	foreach(new i : Player)
	{
		if(e_pAccountData[playerid][mDBID] != e_pAccountData[i][mDBID])
			continue;
		
		if(playerid == i)
			continue;

		SendAdminMessageEx(COLOR_LIGHTRED, 1, "มีการใช้ UCP เดียวกันในการเข้าสองตัวละครในเวลาเดียวกัน (%d) %s กับ (%d) %s",playerid, ReturnName(playerid,0), i, ReturnName(i,0));
	}
	return 1;
}
CMD:ajail(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin] && PlayerInfo[playerid][pTester] < 3)
		return SendUnauthMessage(playerid); 
	
	if(!e_pAccountData[playerid][mForumName])
		return SendErrorMessage(playerid, "กรุณาตั้งชื่อฟอรั่มของคุณก่อน");
		
	new playerb, length, reason[120];
	
	if (sscanf(params, "uds[120]", playerb, length, reason)) 
		return SendUsageMessage(playerid, "/ajail [ชื่อบางส่วน/ไอดี] [เวลา] [สาเหตุ]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(length < 1)
		return SendErrorMessage(playerid, "คุณต้องใส่เวลาในการขังไม่ต่ำกว่า 1 นาที"); 
		
	if(strlen(reason) > 45)
	{
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ได้ถูกนำสงคุกแอดมิน เป็นเวลา %d นาที โดย %s สาเหตุ: %.56s", ReturnName(playerb), length, e_pAccountData[playerid][mForumName], reason);
		SendClientMessageToAllEx(COLOR_RED, "AdmCmd: ...%s", reason[56]); 
	}
	else SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ได้ถูกนำสงคุกแอดมิน เป็นเวลา %d นาที โดย %s สาเหตุ: %s",ReturnName(playerb), length, e_pAccountData[playerid][mForumName], reason);
	
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
	if(!PlayerInfo[playerid][pAdmin] && PlayerInfo[playerid][pTester] < 3)
		return SendUnauthMessage(playerid); 

	if(!e_pAccountData[playerid][mForumName])
		return SendErrorMessage(playerid, "กรุณาตั้งชื่อฟอรั่มของคุณก่อน");
		
	new playerb;
	
	if (sscanf(params, "u", playerb)) 
		return SendUsageMessage(playerid, "/unjail [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
	
	if(PlayerInfo[playerb][pAdminjailed] == false)
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ถูกส่งคุกแอดมิน"); 
		
	SpawnPlayer(playerb);
	
	PlayerInfo[playerb][pAdminjailed] = false;
	PlayerInfo[playerb][pAdminjailTime] = 0;
	
	CharacterSave(playerb);
	SendClientMessageToAllEx(COLOR_RED, "AdmCmd: %s ได้ถูกนำออกจากคุกแอดมินโดย %s", ReturnName(playerb), e_pAccountData[playerid][mForumName]);
	return 1;
}

CMD:setint(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, int, str[128];
	
	if (sscanf(params, "ud", playerb, int)) 
		return SendUsageMessage(playerid, "/setint [ชื่อบางส่วน/ไอดี] [interior]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
	
	SetPlayerInterior(playerb, int);
	
	format(str, sizeof(str), "%s ตั้ง 'Interior' ให้ %s ไปที่ 'Interior' %d.", ReturnName(playerid), ReturnName(playerb), int);
	SendAdminMessage(1, str);
	return 1;
}

CMD:setworld(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, world, str[128];
	
	if (sscanf(params, "ud", playerb, world)) 
		return SendUsageMessage(playerid, "/setworld [ชื่อบางส่วน/ไอดี] [world]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
	
	SetPlayerVirtualWorld(playerb, world);
	
	format(str, sizeof(str), "%s ตั้ง 'World' ให้ %s ไปที่ 'World' %d.", ReturnName(playerid), ReturnName(playerb), world);
	SendAdminMessage(1, str);
	return 1;
}


CMD:setskin(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, skinid, str[128];
	
	if (sscanf(params, "ud", playerb, skinid)) 
		return SendUsageMessage(playerid, "/setskin [ชื่อบางส่วน/ไอดี] [skinid]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	PlayerInfo[playerb][pLastSkin] = skinid; SetPlayerSkin(playerb, skinid);
	
	format(str, sizeof(str), "%s ตั้ง 'Skin' ให้ %s เป็น %d.", ReturnName(playerid), ReturnName(playerb), skinid);
	SendAdminMessage(1, str);
	//CharacterSave(playerb);
	new query[60], thread = MYSQL_TYPE_THREAD;
	mysql_init("characters", "char_dbid", PlayerInfo[playerid][pDBID], thread);
	mysql_int(query, "pLastSkin",skinid);
	mysql_finish(query);
	
	return 1;
}

CMD:sethp(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, health, str[128];
	
	if (sscanf(params, "ud", playerb, health)) 
		return SendUsageMessage(playerid, "/sethp [ชื่อบางส่วน/ไอดี] [health]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(health > 200)
		return SendErrorMessage(playerid, "คุณไม่สามารถเซ็ตเลือดได้เกิน 200"); 
		
	SetPlayerHealth(playerb, health);
	
	format(str, sizeof(str), "%s เซ็ตเลือดให้ %s เป็น %d", ReturnName(playerid), ReturnName(playerb), health);
	SendAdminMessage(1, str);
	return 1;
}

CMD:setarmour(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid); 
		
	new playerb, armour, str[128];
	
	if (sscanf(params, "ud", playerb, armour)) 
		return SendUsageMessage(playerid, "/setarmour [ชื่อบางส่วน/ไอดี] [health]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(armour > 200)
		return SendErrorMessage(playerid, "คุณไม่สามารถเซ็ตเกราะได้เกิน 200"); 
		
	SetPlayerArmour(playerb, armour);
	
	format(str, sizeof(str), "%s เซ็ตเกราะให้ %s เป็น %d", ReturnName(playerid), ReturnName(playerb), armour);
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
				SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | รายงาน: %.65s", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails]);
				SendClientMessageEx(playerid, COLOR_REPORT, "...%s | ส่งเรื่องมาได้: %d วินาที", ReportInfo[i][rReportDetails][65], gettime() - ReportInfo[i][rReportTime]);
			}
			else SendClientMessageEx(playerid, COLOR_REPORT, "%s (ID: %d) | RID: %d | รายงาน: %s | ส่งเรื่องมาได้: %d วินาที", ReturnName(ReportInfo[i][rReportBy]), ReportInfo[i][rReportBy], i, ReportInfo[i][rReportDetails], gettime() - ReportInfo[i][rReportTime]);
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
		return SendUsageMessage(playerid, "/acceptreport [รายงาน ไอดี]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "ไม่มีไอดีรายงานที่ต้องการ"); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[รายงาน] ผู้ดูแลระบบ %s รับรายงานไอดี %d", ReturnName(playerid), reportid);
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณรับรายงาน %s [รายงานเรื่อง: %s]", ReturnName(ReportInfo[reportid][rReportBy]), ReportInfo[reportid][rReportDetails]);
	
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
		return SendUsageMessage(playerid, "/disregardreport [รายงาน ไอดี]"); 
	
	if(ReportInfo[reportid][rReportExists] == false)
		return SendErrorMessage(playerid, "ไม่มีรายงานที่ท่านต้องการ"); 
		
	SendAdminMessageEx(COLOR_RED, 1, "[รายงาน] ผู้ดูแลระบบ %s ลบรายงานไอดี %d", ReturnName(playerid), reportid);
	
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
		return SendUsageMessage(playerid, "/slap [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
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
		return SendUsageMessage(playerid, "/freeze [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	TogglePlayerControllable(playerb, 0);
	
	format(str, sizeof(str), "%s แช่แข็งผู้เล่น %s.", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb, str[128];
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/unfreeze [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	TogglePlayerControllable(playerb, 1);
	
	format(str, sizeof(str), "%s ยกเลิกการแช่แข็ง %s", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}


CMD:spec(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new playerb;
	
	if (sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/spec [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 

	PlayerSpec(playerid, playerb);
	return 1;
}


CMD:specoff(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		return SendErrorMessage(playerid, "คุณไม่ได้ทำการส่องอยู่แล้ว"); 
		
	SendServerMessage(playerid, "คุณยกเลิกการส่อง %s", ReturnName(PlayerInfo[playerid][pSpectating]));
	
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
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to Los Santos!");
	return 1;
}

CMD:gotosf(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, -1973.3322,138.0420,27.6875);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to San Fierro!");
	return 1;
}

CMD:gotodl(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 648.6277,-562.6075,16.2414);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to San Delemore!");
	return 1;
}

CMD:gotolv(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 2035.1591,1338.1174,10.8203);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to LV!");
	return 1;
}

CMD:gotobu(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 228.1954,-125.4321,1.4297);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to LV!");
	return 1;
}

CMD:gotomo(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 1284.4788,176.8740,20.2887);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to LV!");
	return 1;
}

CMD:gotopo(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	SetPlayerPos(playerid, 2387.0598,37.9286,26.4844);
	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 0);
	
	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
	{
		PlayerInfo[playerid][pInsideProperty] = 0; PlayerInfo[playerid][pInsideBusiness] = 0;
	}
	
	SendClientMessage(playerid, COLOR_GRAD1, "You have moved to PO!");
	return 1;
}



CMD:respawncar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/respawncar [ไอดี รถ]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ต้องการ");
		
	SetVehicleToRespawn(vehicleid);
	SetVehicleHp(vehicleid);
	
	foreach(new i : Player)
	{
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "รถถูกผู้ดูแลระบบ %s ส่งกลับจุดเกิดรถแล้ว", ReturnName(playerid));
		}
	}
	
	format(str, sizeof(str), "%s ได้ส่งรถ ไอดี:%d กลับจุดเกิดแล้ว", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotocar(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);
		
	new vehicleid;
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/gotocar [ไอดี รถ]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีที่ต้องการ");
		
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
		return SendUsageMessage(playerid, "/gotocar [ไอดี รถ]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ท่านต้องการ");
	
	GetPlayerPos(playerid, x, y, z);
	
	SetVehiclePos(vehicleid, x, y, z);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid)); 
	
	format(str, sizeof(str), "%s ดึงรถ %i มาหาตัว", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str); 
	
	foreach(new i : Player)
	{
		if(!IsPlayerInAnyVehicle(i))
			continue;
			
		if(GetPlayerVehicleID(i) == vehicleid)
		{
			SendServerMessage(i, "รถ ไอดี:%d ถูกเคลื่อนย้ายโดยผู้ดูแลระบบ", vehicleid); 
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
	
	SendServerMessage(playerid, "ผู้เล่นไม่ได้ใส่หน้ากาก");
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
				SendServerMessage(playerid, "ในพื้นที่ตรงนี้ มีอาวุธ %s และกระสุน %d ถูกทิ้งโดย %s", ReturnWeaponName(WeaponDropInfo[i][eWeaponWepID]), WeaponDropInfo[i][eWeaponWepAmmo], ReturnDBIDName(WeaponDropInfo[i][eWeaponDroppedBy]));
			}
		}
		return 1;
	}
	SendServerMessage(playerid, "ไม่มีอะไรในตรงนี้");
	return 1;
}

CMD:aooc(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);

	if(!e_pAccountData[playerid][mForumName])
		return SendErrorMessage(playerid, "คุณต้องตั้งชื่อฟอรั่มก่อน");
		
	if(isnull(params)) return SendUsageMessage(playerid, "/aooc [ข้อความ]"); 
	
	/*if(strcmp(e_pAccountData[playerid][mForumName], "Null"))
		SendClientMessageToAllEx(COLOR_RED, "[AOOC] ผู้ดูแลระบบ %s (%s): %s", ReturnName(playerid), e_pAccountData[playerid][mForumName], params);
		
	else SendClientMessageToAllEx(COLOR_RED, "[AOOC] ผู้ดูแลระบบ %s: %s", ReturnName(playerid), params);*/
	SendClientMessageToAllEx(COLOR_RED, "{C2185B}[ANNOUNCEMENTS] ผู้ดูแลระบบ %s: %s", e_pAccountData[playerid][mForumName], params);
	return 1;
}


CMD:revice(playerid, params[])
{
	new 
		playerb,
		str[128]
	;

	if(!PlayerInfo[playerid][pAdmin] && PlayerInfo[playerid][pTester] < 2)
		return SendUnauthMessage(playerid);
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/revive [ชื่อบางส่วน/ไอดี]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(GetPlayerTeam(playerb) == PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้รับบาดเจ็บ");
	
	format(str, sizeof(str), "%s ทำให้ %s ฝื้นจากการบาดเจ็บ", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str); 
	
	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(playerb, 100); 
	
	TogglePlayerControllable(playerb, 1); 
	SetPlayerWeather(playerb, globalWeather);  
	
	SetPlayerChatBubble(playerb, "(( เกิด ))", COLOR_WHITE, 21.0, 3000); 
	GameTextForPlayer(playerb, "~b~You were revived", 3000, 4);
	
	ClearDamages(playerb);
	return 1;
}

CMD:forcerespawn(playerid, params[])
{
	new 
		playerb,
		str[65]
	;

	
	if(!PlayerInfo[playerid][pAdmin] && PlayerInfo[playerid][pTester] < 2)
		return SendUnauthMessage(playerid);
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/forcerespawn [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(playerb, 100); 
	
	TogglePlayerControllable(playerb, 1); 
	SetPlayerWeather(playerb, globalWeather);
	
	ClearDamages(playerb);
	SpawnPlayer(playerb);

	format(str, sizeof(str), "%s ส่ง %s กลับไปยังจุดเกิด", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str); 
	SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ส่ง %s กลับไปยังจุดเกิด", ReturnName(playerb));
	return 1;
}

CMD:listweapons(playerid, params[])
{
	new
		playerb,
		weapon_id[2][13]
	;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/listweapons [ชื่อบางส่วน/ไอดี]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
	
	
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
		return SendUsageMessage(playerid, "/setplayerspawn [ชื่อบางส่วน/ไอดีผู้เล่น]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ในเซิฟ");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลัง เข้าสู่ระบบ");

	format(str, sizeof(str), "%s ได้ส่ง %s. ให้ไปเกิดที่จุดเกิดของเขาแล้ว", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);

	SetPlayerTeam(playerb, PLAYER_STATE_ALIVE);
	SetPlayerHealth(playerb, 100);
	//ClearDamages(playerb);

	SpawnPlayer(playerb);
	return 1;
}

CMD:clearchat(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid);

	for(new i = 0; i < 100; ++i)
	{
		SendClientMessageToAll(COLOR_WHITE, " ");
	}
	return 1;
}

alias:randdomphone("rddp")
CMD:randdomphone(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid);

	foreach (new i : Player)
	{
		if(PlayerInfo[i][pPhone])
			continue;

		PlayerInfo[i][pPhone] = random(99999);
		SendClientMessageEx(i, COLOR_GREY, "คุณได้รับเบอร์โทรศัพท์ใหม่: %d",PlayerInfo[i][pPhone]);
	}
	SendClientMessage(playerid, -1, "คุณได้สุ่มเบอร์โทรศัพท์ให้กับคนที่ไม่มีเบอร์โทรศัพท์แล้ว");
	return 1;
}


CMD:makegps(playerid, params[])
{
	new name[32];
	
	if(sscanf(params, "s[32]", name))
		return SendUsageMessage(playerid, "/makegps <ชื่อ GPS>");

	if(PlayerInfo[playerid][pInsideProperty] && PlayerInfo[playerid][pInsideBusiness])
		return SendErrorMessage(playerid, "คุณต้องไม่อยู่ภายในบ้าน หรือ กิจการ");



	new idx = 0, Float:x, Float:y, Float:z;
	for(new i = 1; i < MAX_GPS; i++)
	{
		if(!GpsInfo[i][GPSDBID])
		{
			idx = i;
			break;
		}
	}
	if(idx == 0) return SendErrorMessage(playerid, "คุณไม่สามารถสร้าง GPS ได้แล้ว");

	GetPlayerPos(playerid, x, y, z);
	new query[255];
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `gps` (`GPSOwner`, `GPSName`, `GPSPosX`, `GPSPosY`, `GPSPosZ`) VALUES('%d', '%e', '%f', '%f', '%f')",
	PlayerInfo[playerid][pDBID],
	name,
	x,
	y,
	z);
	mysql_tquery(dbCon, query, "InsertGps","ddsfff",idx,playerid, name, x, y, z);
	return 1;
}

CMD:editgps(playerid, params[])
{
	new editgps, option;
	
	if(sscanf(params, "dd", editgps, option))
	{
		SendUsageMessage(playerid, "/editgps <ไอดี> <option>");
		SendClientMessage(playerid, COLOR_GREEN, "OPTION: 1.ชื่อ 2.จุด 3.ลบ 4.ปรับสาธารณะ");
		return 1;
	}

	if(PlayerInfo[playerid][pInsideProperty] || PlayerInfo[playerid][pInsideBusiness])
		return SendErrorMessage(playerid, "คุณต้องไม่อยู่ภายในบ้าน หรือ กิจการ");

	if(!GpsInfo[editgps][GPSDBID])
		return SendErrorMessage(playerid, "ไม่มีไอดีที่ท่านต้องการ");

	if(GpsInfo[editgps][GPSGobal] && GpsInfo[editgps][GPSOwner] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่สามารถแก้ไข GPS ที่เป็น สาธาระณะได้");

	switch(option)
	{
		case 1:
		{
			PlayerEditGps[playerid] = editgps;
			Dialog_Show(playerid, D_GPS_CHANG_NAME, DIALOG_STYLE_INPUT, "GPS SYSTEM:", "ใส่ชื่อ GPS ใหม่", "ยืนยัน", "ยกเลิก");
		}
		case 2:
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y,z);
			GpsInfo[editgps][GPSPos][0] = x;
			GpsInfo[editgps][GPSPos][1] = y;
			GpsInfo[editgps][GPSPos][2] = z;
			SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้เปลี่ยน จุด GPS %s ของคุณแล้ว",GpsInfo[editgps][GPSName]);
			SaveGps(editgps);
			return 1;
		}
		case 3:
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณได้ลบ GPS %s ของคุณออกแล้ว", GpsInfo[editgps][GPSName]);

			new query[150];
			mysql_format(dbCon, query, sizeof(query), "DELETE FROM `gps` WHERE `GPSDBID` = '%d'",GpsInfo[editgps][GPSDBID]);
			mysql_tquery(dbCon, query);

			GpsInfo[editgps][GPSDBID] = 0;
			GpsInfo[editgps][GPSOwner] = 0;
			format(GpsInfo[editgps][GPSName], 20, "");
			GpsInfo[editgps][GPSGobal] = 0;
			GpsInfo[editgps][GPSPos][0] = 0.0;
			GpsInfo[editgps][GPSPos][1] = 0.0;
			GpsInfo[editgps][GPSPos][2] = 0.0;
			SaveGps(editgps);
			return 1;
		}
		case 4:
		{
			if(!PlayerInfo[playerid][pAdmin])
				return SendUnauthMessage(playerid);

			if(GpsInfo[editgps][GPSGobal])
			{
				GpsInfo[editgps][GPSGobal] = 0;
				SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้ปรับให้ %s ไม่เป็นสาธารณะ", GpsInfo[editgps][GPSName]);
				SaveGps(editgps);
				return 1;
			}
			else
			{
				GpsInfo[editgps][GPSGobal] = 1;
				SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้ปรับให้ %s เป็นสาธารณะ", GpsInfo[editgps][GPSName]);
				SaveGps(editgps);
				return 1;
			}
		}
	}
	return 1;
}

CMD:setbit(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);

	new price;

	if(sscanf(params, "d", price))
		return SendUsageMessage(playerid,  "/setbit <ราคา  BITSMAP>");

	GlobalInfo[G_BITSAMP] = price;
	SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนราคาตลาด BITSAMP: %s", MoneyFormat(price));
	SendClientMessageToAll(COLOR_YELLOWEX, "มีการเปลี่ยนแปลงทางราคาตลาด");
	new query[150], thread = MYSQL_TYPE_THREAD;
	mysql_init("global", "ID",1, thread);
	mysql_int(query, "G_BITSAMP",GlobalInfo[G_BITSAMP]);
	mysql_finish(query);
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
		Dialog_Show(playerid, DIALOG_CLEARREPORT, DIALOG_STYLE_MSGBOX, "{FFFFFF}คุณมันใจหรืป่าวที่จะลบการรายงานทั้งหมด?", "มีรายงานทั้งหมด {FF6347}%d{FFFFFF}", "ยืนยัน", "ยกเลิก",reportCount);

	}
	else return SendServerMessage(playerid, "ไม่มีการรายงาน");
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, weaponid, ammo, idx, str[128];
	
	if(sscanf(params, "uii", playerb, weaponid, ammo))
	{
		SendUsageMessage(playerid, "/givegun [ชื่อบางส่วน/ไอดี] [ไอดีอาวุธ] [กระสุน]");
		SendServerMessage(playerid, "อาวุธที่คุณเสกให้จะถูกเซฟไว้ในตัวผู้เล่น"); 
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "อาวุธดัวกล่าวถูกแบบออกจากเซืฟเวอร์");
		
	if(ammo < 1)return SendErrorMessage(playerid, "กระสุนต้องมากกว่า 1 ชุด");
	
	idx = ReturnWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerb][pWeapons][idx])
		SendServerMessage(playerid, "%s ได้ลบอาวุธ %s และกระสุน %d ออก", ReturnName(playerb), ReturnWeaponName(PlayerInfo[playerb][pWeapons][idx]), PlayerInfo[playerb][pWeaponsAmmo][idx]);
	
	GivePlayerWeapon(playerb, weaponid, ammo); 
	
	PlayerInfo[playerb][pWeapons][idx] = weaponid;
	PlayerInfo[playerb][pWeaponsAmmo][idx] = ammo; 
	
	format(str, sizeof(str), "%s เสกอาวุธให้กับ %s คือ %s พร้อมกับกระสุน %d ชุด", ReturnName(playerid), ReturnName(playerb), ReturnWeaponName(weaponid), ammo);
	SendAdminMessage(2, str);
	
	SendServerMessage(playerb, "คุณได้มอบอาวุธ %s และกระสุน %d ชุด", ReturnWeaponName(weaponid), ammo);
	return 1;
}

CMD:clearallgun(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);
		
	new playerb, displayString[128], str[128]; 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/clearpguns [ชื่อบางส่วน/ไอดี]");
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
		
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
	
	format(str, sizeof(str), "%s ลบอาวุธของ %s ทั้งหมดที่มีในตัว", ReturnName(playerid), ReturnName(playerb));
	SendAdminMessage(1, str);
	return 1;
}

CMD:gotohouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new id;
	
	if(sscanf(params, "i", id))
		return SendUsageMessage(playerid, "/gotohouse [ไอดี-บ้าน]");

	if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
		return SendErrorMessage(playerid, "ไม่มีบ้านที่ต้องการ");
	
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
		return SendUsageMessage(playerid, "/gotobusiness [ไอดี-กิจการ]");

	if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "ไม่มีกิจการที่ต้องการ");
	
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
	new id;
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	if(sscanf(params, "d", id))
		return SendUsageMessage(playerid, "/gotofaction <แฟคชั่นไอดี>");

	if(!FactionInfo[id][eFactionDBID])
		return SendErrorMessage(playerid, "ไม่มีแฟคชั่นที่คุณต้องการ");

	if(!FactionInfo[id][eFactionSpawn][0] || !FactionInfo[id][eFactionSpawn][1] || !FactionInfo[id][eFactionSpawn][2])
		return SendErrorMessage(playerid, "แฟคชั่นยังไม่มีจุดเกิด");

	SetPlayerPos(playerid, FactionInfo[id][eFactionSpawn][0],FactionInfo[id][eFactionSpawn][1],FactionInfo[id][eFactionSpawn][2]);
	SetPlayerVirtualWorld(playerid, FactionInfo[id][eFactionSpawnWorld]);
	SetPlayerInterior(playerid, FactionInfo[id][eFactionSpawnInt]);
	SendClientMessageEx(playerid, -1, "คุณได้เคลื่อนย้าย ไปยังแฟคชั่น %s",FactionInfo[id][eFactionName]);
	return 1;
}

CMD:gotopos(playerid, params[])
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
		return SendUsageMessage(playerid, "/gotopos [x] [y] [z] [interior id] [World-id]");

	
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
		format(str, sizeof(str), "%s เปิดระบบแชท OOC", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "ระบบแชท OOC ถูกเปิดโดยผู้ดูแลระบบ"); 
		oocEnabled = true;
	}
	else
	{
		format(str, sizeof(str), "%s ปิดระบบแชท OOC", ReturnName(playerid));
		SendAdminMessage(1, str); 
		
		SendClientMessageToAll(COLOR_GREY, "ระบบแชท OOC ถูกปิดโดยผู้ดูแลระบบ"); 
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
		return SendUsageMessage(playerid, "/repair [ไอดีรถ]");
		
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีรถไอดีนี้");
		
	format(str, sizeof(str), "%s repaired vehicle ID %i.", ReturnName(playerid), vehicleid);
	SendAdminMessage(1, str);
	
	RepairVehicle(vehicleid);
	SetVehicleHealth(vehicleid, 900); 
	
	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return 1; 
}

alias:acceptwhitelist("acceptwl", "acwl")
CMD:acceptwhitelist(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid);

	new id;
	if(sscanf(params, "d", id))
		return SendUsageMessage(playerid, "/acceptwhitelist <ID: ตัวละคร>");

	new query[255];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE char_dbid = '%d'",id);
	mysql_tquery(dbCon, query, "CheckChar", "dd",playerid, id);
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
		SendUsageMessage(playerid, "/spawncar [โทเดลรถ] [สีที่ 1] [สีที่ 2] [ระบบไซเรน]");
		SendServerMessage(playerid, "เป็นการสร้างรถที่มีแค่เฉพาะผู้ดูแลระบบเท่านั้นที่จะสามารถใช้งานได้"); 
		return 1;
	}

	if(!color1)
		color1 = random(255);

	if(!color2)
		color2 = random(255);

	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่คุณต้องการ");
		
	if(color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "โปรดใส่สีให้ถูกด้วย");

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
		VehicleInfo[vehicleid][eVehicleEngine] = 50.0;
	}
	
	PutPlayerInVehicle(playerid, vehicleid, 0);
	SetVehicleHp(vehicleid);
	format(str, sizeof(str), "%s ได้เสกรถ แอดมิน %s ออกมา", ReturnName(playerid), ReturnVehicleName(vehicleid));
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
		return SendErrorMessage(playerid, "คุณไม่สามารถลบรถที่ไม่ใช่รถ แอดมิน ได้");

		format(str, sizeof(str), "%s despawned %s (%d).", ReturnName(playerid), ReturnVehicleName(veh), veh);
		SendAdminMessage(3, str);

		ResetVehicleVars(veh); DestroyVehicle(veh);
		return 1;
		
	}
		
	if(PlayerInfo[playerid][pAdmin] < 3)
		return 0;
		
	new vehicleid, str[128];
	
	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/despawncar [ไอดีรถ]");
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่คุณต้องการ");
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn] == false)
		return SendErrorMessage(playerid, "คุณไม่สามารถลบรถที่ไม่ใช่รถเสกได้"); 
	
	format(str, sizeof(str), "%s ลบรถเสก %s (%d).", ReturnName(playerid), ReturnVehicleName(vehicleid), vehicleid);
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
	format(str, sizeof(str), "%s ลบรถเสกทั้งหมด", ReturnRealName(playerid, 0));
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
		SendUsageMessage(playerid, "/pcar [ชื่อ/ไอดี] [โมเดล-ไอดี] [สีที่ 1] [สีที่ 2]");
		SendServerMessage(playerid, "ผู้เล่นจะได้รับรถที่คุณแอดไป");
		return 1;
	}
	
	if (!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
	
	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ต้องการ");
		
	if(color1 < 0 || color2 < 0 || color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "โปรดเลือกสีให้ถูกต้อง"); 
		
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
		SendErrorMessage(playerid, "%s รถในตัวของคุณเต็ม สล็อตแล้ว", ReturnName(playerb));
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
		SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] [stat code] [value]"); 
		SendClientMessage(playerid, COLOR_WHITE, "1. Faction Rank, 2. Mask, 3. Radio, 4. Bank Money, 5. Level,");
		SendClientMessage(playerid, COLOR_WHITE, "6. EXP, 7. Paycheck");
		return 1;
	}


	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 

	switch(statid)
	{
		case 1: 
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] 1 [value required]"); 
		
			if(value < 1 && value != -1 || value > 20)
				return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งมีเพียงแต่ (1-20)");
				
			PlayerInfo[playerb][pFactionRank] = value;
			CharacterSave(playerb); 
			
			format(str, sizeof(str), "%s ตั้งค่า %s ให้ดำรงยศ/ต่ำแหน่งไอดี  %i", ReturnName(playerid), ReturnName(playerb), value); 
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
				return SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] 4 [value required]"); 
		
			format(str, sizeof(str), "%s ตั้งค่า %s ให้มีเงินในธนาคาร: $%s (จากเดิม $%s)", ReturnName(playerid), ReturnName(playerb), MoneyFormat(value), MoneyFormat(PlayerInfo[playerb][pBank])); 
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pBank] = value;
			CharacterSave(playerb);
		}
		case 5:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] 5 [value required]"); 
		
			if(value < 1 && value != -1)
				return SendErrorMessage(playerid, "เลเวลควรตั้งให้เหมาะสมกับในเกมส์ปกติ");

			format(str, sizeof(str), "%s ตั้งค่า %s ให้เลเวลเป็น: %i (จากเดิม %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pLevel]);
			SendAdminMessage(3, str); 
			
			PlayerInfo[playerb][pLevel] = value; SetPlayerScore(playerb, value);
			CharacterSave(playerb);
		}
		case 6:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] 6 [value required]"); 
		
			format(str, sizeof(str), "%s ตั้งค่า %s ให้ค่าประสบการณ์เป็น: %i (จากเดิม %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pExp]);
			SendAdminMessage(3, str);
			
			PlayerInfo[playerb][pExp] = value;
			CharacterSave(playerb);
		}
		case 7:
		{
			if(value == -1)
				return SendUsageMessage(playerid, "/setstats [ชื่อบางส่วน/ไอดี] 7 [value required]");
				
			format(str, sizeof(str), "%s ตั้งค่า %s's ให่ค่าจ้างรายชั่วโมง: %i (จากเดิม %i)", ReturnName(playerid), ReturnName(playerb), value, PlayerInfo[playerb][pPaycheck]);
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
		return SendUsageMessage(playerid, "/givemoney [ชื่อบางส่วน/ไอดี] [จำนวน]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	GiveMoney(playerb, value);
	SendServerMessage(playerb, "คุณได้รับเงินจำนวน $%s จาก ผู้ดูแลระบบ %s", MoneyFormat(value), ReturnName(playerid));

	format(str, sizeof(str), "%s เสกเงินจำนวน $%s ให้กับ %s", ReturnName(playerid), MoneyFormat(value), ReturnName(playerb));
	SendAdminMessage(3, str);
	return 1;
}

CMD:setmoney(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid);

	new playerb, value, str[128];
	
	if(sscanf(params, "ui", playerb, value))
		return SendUsageMessage(playerid, "/setmoney < ชื่อบางส่วน/ไอดี > < จำนวน >");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	ResetPlayerMoney(playerb);
	PlayerInfo[playerb][pCash] = 0;

	GiveMoney(playerb, value);
	SendServerMessage(playerb, "คุณได้รับเงินจำนวน $%s จาก ผู้ดูแลระบบ %s", MoneyFormat(value), ReturnName(playerid));

	format(str, sizeof(str), "%s เซ็ตเงินจำนวน $%s ให้กับ %s", ReturnName(playerid), MoneyFormat(value), ReturnName(playerb));
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
		SendUsageMessage(playerid, "/setcar [ไอดีรถ] [params]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} locklvl, alarmlvl, immoblvl, timesdestroyed,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} enginelife, batterylife, color1, color2, paintjob, plates."); 
		return 1;
	}
	
	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่ต้องการ"); 
		
	if(VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendErrorMessage(playerid, "ไม่สามารถใช้คำสั่งนี้กับรถส่วนบุคคล(รถเสก)ได้");
		
	if(!strcmp(a_str, "locklvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid locklvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า:1-4");
		
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบล็อคเป็น %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleLockLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "alarmlvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid alarmlvl [1-4]"); 
			
		if(value > 4 || value < 1)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า:1-4");
		
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ระบบ 'Alarm' เป็นระดับ %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleAlarmLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "immoblvl"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid immoblvl [1-5]"); 
			
		if(value > 5 || value < 1)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า:1-5");
		
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'immobiliser' ไปในระดับ %i.", ReturnName(playerid), vehicleid, value); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleImmobLevel] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "timesdestroyed"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid timesdestroyed [value]");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'time destroyed' ไปยังระดับ %i (จากเดิม %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleTimesDestroyed]); 
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleTimesDestroyed] = value; 
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "enginelife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid enginelife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'engine life' ไปยังระดับ %.2f. (จากเดิม %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleEngine]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleEngine] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "batterylife"))
	{
		if(sscanf(b_str, "f", life))
			return SendUsageMessage(playerid, "/setcar vehicleid batterylife [float]");
			
		if(life > 100.00 || life < 0.00)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0.00 - 100.00)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'battery life' ไปยังระดับ %.2f. (จากเดิม %.2f)", ReturnName(playerid), vehicleid, life, VehicleInfo[vehicleid][eVehicleBattery]);
		SendAdminMessage(3, str); 
		
		VehicleInfo[vehicleid][eVehicleBattery] = life;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color1"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color1 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0-255)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'color1' ไปยังระดับ %i (จากเดิม %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor1]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "โปรดนำรถเข้าไปเก็บแล้วเรียกออกมาใหม่");
		
		VehicleInfo[vehicleid][eVehicleColor1] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "color2"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid color2 [value]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0-255)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'color2' ไปยังระดับ %i (จากเดิม %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehicleColor2]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "โปรดนำรถเข้าไปเก็บแล้วเรียกออกมาใหม่");
		
		VehicleInfo[vehicleid][eVehicleColor2] = value;
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(a_str, "paintjob"))
	{
		if(sscanf(b_str, "i", value))
			return SendUsageMessage(playerid, "/setcar vehicleid paintjob [0-2, 3 to remove]");
			
		if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0-255)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'paintjob' ไปยังระดับ %i. (จากเดิม %i)", ReturnName(playerid), vehicleid, value, VehicleInfo[vehicleid][eVehiclePaintjob]);
		SendAdminMessage(3, str);
		
		SendClientMessage(playerid, COLOR_WHITE, "โปรดนำรถเข้าไปเก็บแล้วเรียกออกมาใหม่");
		
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
			return SendErrorMessage(playerid, "ป้ายทะเบียนต้องมีมากกว่า 6 ตัวอักษร (นี่คือตัวอย่างป้ายทะเบียนของ ประเทศ แคริสฟอเนีย: Q123Q1)");
			
		format(str, sizeof(str), "%s ตั้งค่ารถไอดี %i ให้ระบบ 'plates' ไปยังระดับ \"%s\". (จากเดิม %s)", ReturnName(playerid), vehicleid, plates, VehicleInfo[vehicleid][eVehiclePlates]);
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
		return SendUsageMessage(playerid, "/makeleader [ชื่อบางส่วน/ไอดี] [faction id]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	if(!FactionInfo[factionid][eFactionDBID]) return SendErrorMessage(playerid, "ไม่มีเฟคชั่นที่คุณระบุ");

	if(PlayerInfo[playerb][pFaction] != 0)
	{
		PlayerMakeleader[playerb] = playerid;
		PLayerMakeleaderFacID[playerb] = factionid;
		Dialog_Show(playerb, DIALOG_COM_FAC_INV, DIALOG_STYLE_MSGBOX, "คุณแน่ใจ?", "คุณมีเฟคชั่นอยู่แล้ว คุณมั่นใช่หรือไม่ที่จะเปลี่ยนเฟคชั่นไปเป็น %s", "ยินยัน", "ยกเลิก",FactionInfo[factionid][eFactionName]);
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
		
		SendClientMessageEx(i, -1, "{2ECC71}**((%s: ได้เข้าสู่เฟคชั่นของพวกคุณแล้ว))**", ReturnName(playerid));
	}
	SendClientMessageEx(playerid, -1,"{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} คุณได้ให้ให้ %s เป็นหัวหน้าเฟคชั่น ของ %s",ReturnRealName(playerb,0),FactionInfo[factionid][eFactionName]);

	format(str, sizeof(str), "{2196F3}FACTION {FF9800}SYSTEM:{FFFFFF} %s ตั้งค่าให้ %s เป็นหัวหน้ากลุ่มเฟคชั่น %s", ReturnRealName(playerid,0), ReturnRealName(playerb,0), FactionInfo[factionid][eFactionName]);
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
		return SendUsageMessage(playerid, "/makehouse [ชื่อบ้าน(ควรใส่บ้านเลขที่)] [ราคา-บ้าน] [เลเวล-บ้าน]");

	if(strlen(name) > 90)
	{
		SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}คุณไม่สามารถตั้งชื่อบ้านเกิน 90 ตัวอักษรได้");
		return SendUsageMessage(playerid, "/makehouse [ชื่อบ้าน(ควรใส่บ้านเลขที่)] [ราคา-บ้าน] [เลเวล-บ้าน]");
	}
	if(price < 1 || price > 90000000)
	{
		SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}คุณไม่สามารถตั้งราคา $%s ได้เนื่องจากมีราคาเกินที่กำหนด/ไม่ถึงที่กำหนด 1 < || > 90,000,000",MoneyFormat(price));
		return SendUsageMessage(playerid, "/makehouse [ชื่อบ้าน(ควรใส่บ้านเลขที่)] [ราคา-บ้าน] [เลเวล-บ้าน]");
	}
	if(level < 1 || level > 90000000)
	{
		SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FFFFFF}คุณไม่สามารถตั้งเลเวล %i ได้เนื่องจากมีเลเวลเกินที่กำหนด/ไม่ถึงที่กำหนด 1 < || > 90000000",level);
		return SendUsageMessage(playerid, "/makehouse [ชื่อบ้าน(ควรใส่บ้านเลขที่)] [ราคา-บ้าน] [เลเวล-บ้าน]");
	}
	
	format(name, sizeof(name),name);
	format(str, sizeof(str), "คุณกำลังจะสร้างบ้าน: %s\n\
							  ราคา: $%s\n\
							  เลวล: %i", name,MoneyFormat(price),level);

	PlayerCreHouse[playerid] = name;
	PlayerCreHousePrice[playerid] = price;
    PlayerCreHouseLevel[playerid] = level;

	Dialog_Show(playerid, DIALOG_CRE_HOUSE, DIALOG_STYLE_MSGBOX, "คุณมันใจ?", str, "ยืนยัน", "ยกเลิก");

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
	
	Dialog_Show(playerid, DIALOG_VIEWHOUSE, DIALOG_STYLE_LIST, "HOUSE:", longstr, "เลือก", "ออก");
	return 1;
}

CMD:edithouse(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new id, option[32],secstr[32];
	if(sscanf(params, "ds[32]S()[32]", id, option, secstr))
		return SendUsageMessage(playerid, "/edithouse <ไอดี> <option>");

	if(!HouseInfo[id][HouseDBID])
		return SendErrorMessage(playerid, "ไม่มีบ้านไอดีนี้");

	if(!strcmp(option, "name"))
	{
		new NewName[32];
		if(sscanf(secstr, "s[32]", NewName))
			return SendUsageMessage(playerid, "/edithouse %d name <enter_name>", id);

		if(strlen(NewName) < 3 || strlen(NewName) > 32)
			return SendErrorMessage(playerid, "ใส่ชื่อที่ถูกต้อง");

		format(HouseInfo[id][HouseName], 32, "%s", NewName);

		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เปลี่ยนชื่อ บ้าน %d เป็น %s",id, HouseInfo[id][HouseName]);
		Savehouse(id);
		return 1;
	}
	else if(!strcmp(option, "price"))
	{
		new price;
		if(sscanf(secstr, "d", price))
			return SendUsageMessage(playerid, "/edithouse %d price <ราคาบ้าน>", id);


		if(price < 1 || price > 10000000)
			return SendErrorMessage(playerid, "กรุณาใส่ราคาบ้านให้ถูกต้องด้วย");

		HouseInfo[playerid][HousePrice] = price;
		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เปลี่ยนราคาบ้าน %d เป็น %s",id, MoneyFormat(price));
		Savehouse(id);
		return 1;
	}
	else if(!strcmp(option, "level"))
	{
		new level;
		if(sscanf(secstr, "d", level))
			return SendUsageMessage(playerid, "/edithouse %d level <เลเวล>", id);


		if(level < 1 || level > 99999)
			return SendErrorMessage(playerid, "กรุณาใส่ราคาบ้านให้ถูกต้องด้วย");

		HouseInfo[playerid][HouseLevel] = level;
		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เปลี่ยนเลเวลบ้าน %d เป็น %s",id, MoneyFormat(level));
		Savehouse(id);
		return 1;
	}
	else if(!strcmp(option, "enterpos"))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		HouseInfo[id][HouseEntrance][0] = x;
		HouseInfo[id][HouseEntrance][1] = y;
		HouseInfo[id][HouseEntrance][2] = z;
		HouseInfo[id][HouseEntranceInterior] = GetPlayerInterior(playerid);
		HouseInfo[id][HouseInteriorWorld] = GetPlayerVirtualWorld(playerid);
		Savehouse(id);
		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เปลี่ยนจุดทางเข้าบ้าน %d แล้ว",id);
		return 1;
	}
	else if(!strcmp(option, "interiorpos"))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		HouseInfo[id][HouseInterior][0] = x;
		HouseInfo[id][HouseInterior][1] = y;
		HouseInfo[id][HouseInterior][2] = z;

		HouseInfo[id][HouseInteriorID] = GetPlayerInterior(playerid);

		if(GetPlayerVirtualWorld(playerid) == 0)
		{
			HouseInfo[id][HouseInteriorWorld] = random(99999);
		}
		else HouseInfo[id][HouseInteriorWorld] = GetPlayerVirtualWorld(playerid);

		Savehouse(id);
		SendClientMessageEx(playerid, COLOR_GREEN, "คุณได้เปลี่ยนจุดภายในบ้านแล้ว %d แล้ว",id);
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pInsideProperty] == id)
			{
				SetPlayerPos(playerid,x, y,z);
				SetPlayerInterior(playerid, GetPlayerInterior(playerid));
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
				SendServerMessage(playerid, "ขออถัยในความไม่สวดเนื่องจากมีการเปลี่ยนแปลง ภายในบ้านหลังนี้จากผู้ดูแล เราจึงนำท่าเคลื่อนย้ายมาที่นี่");
			}
		}
		PlayerInfo[playerid][pInsideProperty] = id;
		return 1;
	}
	else SendErrorMessage(playerid, "กรุณาใส่ให้ถูกต้อง");
	return 1;
}

CMD:makemcgarage(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new idx = 0;
	
    for (new i = 1; i < MAX_MCGARAGE; i ++)
    {
        if(!McGarageInfo[i][Mc_GarageDBID])
        {
            idx = i; 
            break;
        }
	}
    if(idx == 0)
    {
        return SendServerMessage(playerid, "สร้าง อู่ซ่อมรถ เกินกว่านี้ไม่ได้แล้ว (100)");
    }

	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	
	new World = GetPlayerVirtualWorld(playerid);
	new Interior = GetPlayerInterior(playerid);

	new query[MAX_STRING];

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO mc_garage (`Mc_GaragePosX`,`Mc_GaragePosY`,`Mc_GaragePosZ`,`Mc_GarageWorld`,`Mc_GarageInterior`) VALUES(%f,%f,%f,%d,%d)",x,y,z,World,Interior); 
	mysql_tquery(dbCon, query, "Query_InsertMcGarage", "ddfffdd", playerid, idx,x,y,z,World,Interior);
	return 1;
}


CMD:editmcgarage(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 5)
		return SendUnauthMessage(playerid);

	new id, option[60], Float:x, Float:y, Float:z;

	if(sscanf(params, "ds[60]", id, option))
	{
		SendUsageMessage(playerid, "/editmcgarage <ไอดี> <ฟังชั่น>");
		SendUsageMessage(playerid, "pos(แก้ไขจุด) delete(ลบ)");
		return 1;
	}

	if(!McGarageInfo[id][Mc_GarageDBID])
		return SendErrorMessage(playerid, "ไม่มี ID นี้");

	if(!strcmp(option, "pos",true))
	{
		GetPlayerPos(playerid, x, y, z);
		McGarageInfo[id][Mc_GaragePos][0] = x;
		McGarageInfo[id][Mc_GaragePos][1] = y;
		McGarageInfo[id][Mc_GaragePos][2] = z;
		McGarageInfo[id][Mc_GarageWorld] = GetPlayerVirtualWorld(playerid);
		McGarageInfo[id][Mc_GarageInterior] = GetPlayerInterior(playerid);

		if(IsValidDynamicPickup(McGarageInfo[id][Mc_GarageIcon]))
			DestroyDynamicPickup(McGarageInfo[id][Mc_GarageIcon]);
		
		SaveMc_Garage(id);

		McGarageInfo[id][Mc_GarageIcon] = CreateDynamicPickup(1239, 2, 
		McGarageInfo[id][Mc_GaragePos][0],
		McGarageInfo[id][Mc_GaragePos][1],
		McGarageInfo[id][Mc_GaragePos][2],
		McGarageInfo[id][Mc_GarageWorld],
		McGarageInfo[id][Mc_GarageInterior],
		-1);

		SendClientMessageEx(playerid, -1, "คุณได้แก้ไข อู่แต่งรถ %d", id);
		return 1;
	}
	else if(!strcmp(option, "delete",true))
	{
		SendClientMessageEx(playerid, -1, "คุณได้ลบ อู่แต่งรถ ID "EMBED_RED"%d", id);
		DeleteMcGarage(id);
		return 1;
	}
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
        return SendServerMessage(playerid, "สร้าง entrance เกินกว่านี้ไม่ได้แล้ว (30)");
    }

	new iconid;

	if(sscanf(params, "d", iconid))
		return SendUsageMessage(playerid, "/makeentrance [ไอคอน-ไอดี]");

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
		return SendUsageMessage(playerid, "/edit(entr)ance [ไอคอน-ไอดี]");


	if(!EntranceInfo[id][EntranceDBID])
		return SendErrorMessage(playerid, "ไม่มี ไอดีที่ ต้องการ");

	PlayerSeleteEnter[playerid] = id;

	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}เปลี่ยน ไอคอน\n");
	strcat(longstr, str);
	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}เปลี่ยนจุดด้านหน้า\n");
	strcat(longstr, str);
	format(str, sizeof(str), "{43A047}[ {FF0000}! {43A047}] {FFFFFF}เปลี่ยนจุดภายใน\n");
	strcat(longstr, str);

	Dialog_Show(playerid, EDIT_ENTRANCE, DIALOG_STYLE_LIST, "Entrance Editer", longstr, "ยืนยัน", "ยกเลิก");
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
        return SendServerMessage(playerid, "สร้างกิจการเกินกว่านี้ไม่ได้แล้ว (30)"); 
    }


	new name[90],type;

	if(sscanf(params, "d", type))
	{
		SendUsageMessage(playerid, "/makebusiness [ประเภท]");
		SendUsageMessage(playerid, "Type: 1.ร้านค้า(24/7) 2.ร้านตัวแทนจำหน่ายรถ 3.ร้านปืน");
		SendUsageMessage(playerid, "Type: 4.ร้านอาหาร 5.ธนาคาร  6.คลับ 7.ร้านขายเสื้อผ้า");
		return 1;
	}

	if(strlen(name) > 90)
	{	
		SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0000} คุณไม่สามารถตั้งชื่อกิจการเกิน 90 ตัวอักษร");
		SendUsageMessage(playerid, "/makebusiness [ประเภท]");
		SendUsageMessage(playerid, "Type: 1.ร้านค้า(24/7) 2.ร้านตัวแทนจำหน่ายรถ 3.ร้านปืน");
		SendUsageMessage(playerid, "Type: 4.ร้านอาหาร 5.ธนาคาร  6.คลับ 7.ร้านขายเสื้อผ้า ");
		return 1;
	}
	if(type < 1 || type > 7)
	{	
		SendClientMessageEx(playerid,-1,"{0D47A1}BUSINESS {F57C00}SYSTEM:{FF0000} โปรดเลื่อกประเภทกิจการให้ถูก");
		SendUsageMessage(playerid, "/makebusiness [ประเภท]");
		SendUsageMessage(playerid, "Type: 1.ร้านค้า(24/7) 2.ร้านตัวแทนจำหน่ายรถ 3.ร้านปืน");
		SendUsageMessage(playerid, "Type: 4.ร้านอาหาร 5.ธนาคาร 6.คลับ 7.ร้านขายเสื้อผ้า");
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
		SendUsageMessage(playerid,"/del(ete)business [ไอดี-กิจการ]");
		return 1;
	}

	if(!BusinessInfo[id][BusinessDBID] || id > MAX_BUSINESS)
		return SendErrorMessage(playerid, "ไม่มี ไอดี กิจการที่คุณต้องการ");

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
				GiveMoney(i, BusinessInfo[id][BusinessPrice]);

				if(BusinessInfo[id][BusinessCash])
					GiveMoney(i, BusinessInfo[id][BusinessCash]);
				
				SendClientMessage(playerid, -1, "{33FF66}BUSINESS {F57C00}SYSTEM:{FF0000} ขออภัยในความไม่สดวกเนื่องจากมีการลบกิจการของท่านออกจากเซืฟเวอร์ไปแล้ว โดยผู้ดูแลระบบจึงจำเป็น");
				SendClientMessageEx(playerid, -1, "{FF0000}...จะต้องขอประทานทภัยด้วยถ้าหากผู้ดูแลระบบไม่ได้แจ้งเตือนท่านล่วงหน้าหากมีข้อสงสัยสามารถสอบถามได้ที่ฟอรั่มหรือ /report [สอบถามกิจการ]");
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
		SendUsageMessage(playerid,"/del(ete)house [ไอดี-บ้าน]");
		return 1;
	}

	if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
		return SendErrorMessage(playerid, "ไม่มี ไอดี บเานที่คุณต้องการ");

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
				GiveMoney(i, HouseInfo[id][HousePrice]);
				
				SendClientMessage(i, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ขออภัยในความไม่สดวกเนื่องจากมีการลบบ้านของท่านออกจากเซืฟเวอร์ไปแล้ว โดยผู้ดูแลระบบจึงจำเป็น");
				SendClientMessageEx(i, -1, "{FF0000}...จะต้องขอประทานทภัยด้วยถ้าหากผู้ดูแลระบบไม่ได้แจ้งเตือนท่านล่วงหน้าหากมีข้อสงสัยสามารถสอบถามได้ที่ฟอรั่มหรือ /report [สอบถามบ้าน]");
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
	    return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");

	new factionid, modelid, color1, color2;

	if(sscanf(params, "dddd", factionid,modelid,color1,color2))
		return SendUsageMessage(playerid,"/(createveh)icle [เฟคชั่น-ไอดี] [โมเดลรถ] [สีที่1] [สีที่2]");

	if(!FactionInfo[factionid][eFactionDBID])
		return SendErrorMessage(playerid, "ไม่มีเฟคชั่นไอดีที่ต้องการ");

	if(modelid < 400 || modelid > 611)
		return SendErrorMessage(playerid, "ไม่มีไอดีรถที่คุณต้องการ");
		
	if(color1 > 255 || color2 > 255)
		return SendErrorMessage(playerid, "โปรดใส่สีให้ถูกด้วย");

	new idx = 0;

	for(new i = 1; i < MAX_FACTION_VEHICLE; i++)
	{
		if(!VehFacInfo[i][VehFacDBID])
		{
			idx = i;
			break;
		}
	}
	if(idx == 0) return SendErrorMessage(playerid, "รถแฟคชั่นเต็มแล้ว");

	new Float:x,Float:y,Float:z,Float:a;
	GetPlayerPos(playerid, x,y,z);
	GetPlayerFacingAngle(playerid, a);
	new World = GetPlayerVirtualWorld(playerid);

	new thread[MAX_STRING]; 

	mysql_format(dbCon, thread, sizeof(thread), "INSERT INTO vehicle_faction (`VehicleModel`, `VehicleFaction`,`VehicleColor1`,`VehicleColor2`,`VehicleParkPosX`,`VehicleParkPosY`,`VehicleParkPosZ`,`VehicleParkPosA`,`VehicleParkWorld`) VALUES(%d,%d,%d,%d,%f,%f,%f,%f,%d)",
		modelid,
		factionid,
		color1,
		color2,
		x,
		y,
		z,
		a,
		World);
	mysql_tquery(dbCon, thread, "InsertVehicleFaction", "dddddd", playerid,idx, modelid, factionid, color1, color2);
	return 1;
}

alias:deletevehicle("delveh","removeveh")
CMD:deletevehicle(playerid, params[])
{	
	if(PlayerInfo[playerid][pAdmin] < 1336)
	    return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");

	new vehicleid;

	if(sscanf(params, "d", vehicleid))
		return SendUsageMessage(playerid, "/deletevehicle <ไอดีรถ>");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ไม่มี ID ยานพาหนะที่ต้องการ");

	if(!VehFacInfo[vehicleid][VehFacFaction])
		return SendErrorMessage(playerid, "ยานพาหนะคันนี้ไม่มีอยู่ในแฟคชั่น");


	SendClientMessageEx(playerid, -1, "คุณได้ลบยานพาหนะของแฟคชั่น %s ไอดี %d",ReturnFactionNameEx(VehFacInfo[vehicleid][VehFacFaction]), vehicleid);
	new thread[MAX_STRING]; 

	mysql_format(dbCon, thread, sizeof(thread), "DELETE FROM `vehicle_faction` WHERE `VehicleDBID` = '%d'", VehFacInfo[vehicleid][VehFacDBID]);
	mysql_tquery(dbCon, thread);

	VehFacInfo[vehicleid][VehFacDBID] = 0;
	VehFacInfo[vehicleid][VehFacModel] = 0;
	VehFacInfo[vehicleid][VehFacFaction] = 0;

	VehFacInfo[vehicleid][VehFacColor][0] = 0;
	VehFacInfo[vehicleid][VehFacColor][1] = 0;
	VehicleInfo[vehicleid][eVehicleFuel] = 0;
	DestroyVehicle(vehicleid);
	ResetVehicleVars(vehicleid);
	return 1;
}
// Admin Level: 1336;

// Admin Level: 1337:
CMD:maketester(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337)
		return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");

	new tagetid, level;
	if(sscanf(params, "ud", tagetid, level))
		return SendUsageMessage(playerid, "/maketester <ชื่อบางส่วน/ไอดี> <เลเวล>");

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

	if(IsPlayerLogin(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นยังไม่ได้เข้าสู่ระบบ");


	if(level > 3)
		return SendErrorMessage(playerid, "โปรดใส่ เลวลให้ถูกต้อง (ห้ามมากกว่า 3)");

	if(PlayerInfo[tagetid][pAdmin])
		return SendErrorMessage(playerid, "ผู้เล่นเป็นผู้ดูแลระบบอยู่");

	if(PlayerInfo[tagetid][pTester] > level)
	{
		if(level == 0)
		{
			PlayerInfo[tagetid][pTester] = 0;
			SendClientMessage(tagetid, COLOR_LIGHTRED, "คุณได้ถูกปลดออกจากตำแหน่ง Tester แล้วขอบคุณที่เข้ามาเป็นส่วนนึงของทีมงาน");
			CharacterSave(tagetid);
			return 1;
		}

		SendClientMessageEx(tagetid, COLOR_YELLOWEX, "คุณถูกปรับให้ลดต่ำแหน่ง Tester จาก %d เป็น %d",  PlayerInfo[tagetid][pTester], level);
		PlayerInfo[tagetid][pTester] = level;
		CharacterSave(tagetid);
		return 1;
	}
	else
	{
		SendClientMessageEx(tagetid, COLOR_PMS, "คุณได้ถูกเพิ่มต่ำแหน่งจาก Tester จาก %d เป็น %d",  PlayerInfo[tagetid][pTester], level);
		PlayerInfo[tagetid][pTester] = level;
		CharacterSave(tagetid);
		return 1;
	}
}
// Admin Level: 1337;

// Admin Level: 1338:
CMD:restart(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1338)
	    return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");
	
	foreach (new i : Player)
	{
		
		PlayerInfo[i][pVehicleSpawned] = false;
		PlayerInfo[i][pVehicleSpawnedID] = INVALID_VEHICLE_ID;

		CharacterSave(i);
		SetPlayerName(i, e_pAccountData[i][mAccName]);
	}

	new query[150];
	for (new i = 1; i < 100; i++)
	{
        mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pVehicleSpawned` = '0', `pVehicleSpawnedID` = '0', `RentCarKey` = '0' WHERE `char_dbid` = '%d' ",i);
        mysql_tquery(dbCon, query);
	}

	//Saving systems:
	/*SaveFactions();
	SaveProperties();
	SaveBusinesses();*/

	//Closing database:
	
	SendRconCommand("gmx");
	return 1;
	
}

// Admin Level: 1338;

// Admin Level: 1339:
CMD:callpaycheck(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1339)
		return 0;
		
	Dialog_Show(playerid,  DIALOG_CALLPAYCHECK, DIALOG_STYLE_MSGBOX,"Confirmation", "คุณมั่นใจใช่ไหมที่จะทำการชดเชยค่ารายชัวโมงในเวลานี้?\n\nการกระทำของคุณอาจจะผิดกฏของผู้ดูแลระบบได้", "ยืนยัน", "ยกเลิก"); 
	return 1;
}

CMD:makefaction(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1339)
		return SendUnauthMessage(playerid);
		
	new varAbbrev[30], varName[90]; 
	
	if(sscanf(params, "s[30]s[90]", varAbbrev, varName))
	{
		SendUsageMessage(playerid, "/makefaction [ชื่อย่อเฟคชั่น] [ชื่อเฟคชั่น]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} จำเป็นต้องใส่ชื่อเฟคชั่นด้วย");
		return 1; 
	}
	
	if(strlen(varName) > 90)
		return SendErrorMessage(playerid, "ชื่อย่อเฟคชั่นควรน้อยกว่า 90 ตัวอักษร"); 
		
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
		return SendServerMessage(playerid, "การสร้างเฟคชั่นถึงขีดจำกัดแล้ว"); 
	}

	SendServerMessage(playerid, "กำลังสร้างเฟตชั่น......");
	
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
		SendUsageMessage(playerid, "/makeadmin [ชื่อบางส่วน/ไอดี] [เลเวล]");
		return 1;
	}

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");

	if(IsPlayerLogin(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	/*if(!PlayerInfo[playerb][pAdmin])
		return SendErrorMessage(playerid, "ผู้เล่นคนนี้ไม่ได้เป็นผู้ดูแลระบบอยู่แล้ว");*/
	
	if(PlayerInfo[playerb][pAdmin] > PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่สามารถปรับต่ำแหน่งผู้ดูแลระบบที่สูงกว่าคุณได้");
	
	if(level == 0)
	{
		PlayerInfo[playerb][pAdmin] = 0;
		SendClientMessageEx(playerb, -1, "{FF5722}ADMIN SYSTEM:{FFFFFF}คุณได้ถูกลบจากการเป็นผู้ดูแลระบบแล้ว ขอบคุณที่เคยเป็นส่วนนึงในตำแหน่งนี้");
		CharacterSave(playerb);
		return 1;
	}
	if(level > 1339)
		return SendErrorMessage(playerid, "คุณไม่สามารถให้ต่ำแหน่งผู้ดูแลระบบที่มากกว่า (1339) ได้");

	PlayerInfo[playerb][pAdmin] = level;
	SendClientMessageEx(playerb, -1, "{FF5722}ADMIN SYSTEM:{FFFFFF}คุณได้รับต่ำแหน่งผู้ดูแลระบบ (%d)",level);
	new str[MAX_STRING];
	format(str, sizeof(str), "%s ได้เพื่มต่ำแหน่งผู้ดูแลระบบ %d ให้กับ %s",ReturnRealName(playerid,0),level,ReturnRealName(playerb,0));
	SendAdminMessage(4,str);


    return 1;
}

hook OnRconLoginAttempt(ip[], password[], success)
{
	new ip2 = IPToInt(ip);

	if (success) {
		defer RetrieveRconPlayer(ip2);
	}
	else
	{
		//SendClientMessageToAllEx(COLOR_LIGHTRED, "%s ถูกแตะออกจากเซิร์ฟเวอร์เนื่องจากมีการใช้คำสั่งต้องห้ามของเซิร์ฟเวอร์",ReturnName(playerid,0));
		return 1;
	}

	return 1;
}

hook OnPlayerRconLogin(playerid)
{
	PlayerInfo[playerid][pAdmin] = 1339;
	SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ทำการเข้าสู่ระบบ เป็นผู้ดูแลระบบผ่าน rcon login แล้วตอนนี้คุณเป็นผู้ดูแลระดับ 1339 หรือ Management Server");
	return 1;
}

timer RetrieveRconPlayer[1000](ip)
{
    new
        playerIP[16 + 1];

	foreach(new i : Player) {
        GetPlayerIp(i, playerIP, sizeof(playerIP));
		if (IPToInt(playerIP) == ip && IsPlayerAdmin(i)) {
			CallRemoteFunction("OnPlayerRconLogin", "i", i);
			return 1;
		}
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
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ผู้ดูแลระบบ");
    
    format(str, sizeof(str), "{F44336}%s {FFEB3B}มีการใช้งานค่ำสั่งของผู้ดูแลระบบ(ไม่สามารถใช้งานได้)", ReturnRealName(playerid)); 
	SendAdminMessage(99, str);

	return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ผู้ดูแลระบบ");
}

hook OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return 1;

	new playerb = clickedplayerid;

	PlayerSpec(playerid, playerb);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(RELEASED(KEY_WALK))
	{
		if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
			return 1;

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
			return 1;

		
		TogglePlayerSpectating(playerid, false);
		return 1;
	}
	return 1;
}

forward CheckChar(playerid, id);
public CheckChar(playerid, id)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มี ID Character ที่คุณค้นหา");

	
	new query[255];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE `char_dbid` = '%d' AND `pWhitelist` = '0'",id);
	mysql_tquery(dbCon, query, "CheckWhiteList","dd",playerid, id);
	return 1;
}

forward CheckWhiteList(playerid, id);
public CheckWhiteList(playerid, id)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ID Character ได้ถูกยอมรับแล้ว");

	
	new query[255];
	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pWhitelist` = '1' WHERE `char_dbid` = '%d'",id);
	mysql_tquery(dbCon, query);

	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "คุณได้ยืนยันให้ตัวละครไอดี #%d สามารถเข้ามาเล่นภายในเซิร์ฟเวอรได้แล้ว",id);
	SendAdminMessageEx(COLOR_PMS, 2, "[ADMIN: %d] %s ได้ยืนยันให้ตัวละครไอดี #%d สามารถเข้ามาเล่นภายในเซิร์ฟเวอรได้แล้ว",PlayerInfo[playerid][pAdmin], ReturnName(playerid,0), id);
	return 1;
}

Dialog:DIALOG_CALLPAYCHECK(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;
	
	CallPaycheck();
	return 1;
}


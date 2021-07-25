#include <YSI_Coding\y_hooks>




new 
	playerWeaponsSave[MAX_PLAYERS][4], 
	playerWeaponsAmmoSave[MAX_PLAYERS][4]; 

alias:factionhelp("fhelp")
CMD:factionhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_RED, "[FACTION]:{FFFFFF} /f, /togfam, /nofam, /factionhelp"); 

    if(!PlayerInfo[playerid][pFaction])
		return 1;
    
    if(ReturnFactionType(playerid) == GOVERMENT)
    {
        SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /duty, /cuff, /uncuff, /showbadge, /m(egaphone), /(dep)artment,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /carsign, /remove_carsign, /tazer, /take, /givelicense, /impound, /mdc");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /siren, /siren2, /siren3, /headquarter /setbadge");
		
		if(PlayerInfo[playerid][pFactionRank] <= FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank])
			SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /towcars");

        return 1;
    }
    return 1;
}


alias:headquarter("hq", "headhq")
CMD:headquarter(playerid, params[])
{
    if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 

    if(isnull(params)) return SendUsageMessage(playerid, "/headquarter <ข้อความ>");
	
	if(strlen(params) > 100)
	{
		SendFactionMessage(playerid, 0x8D8DFFFF, "HQ: %s: %.100s", ReturnName(playerid, 0), params);
		SendFactionMessage(playerid, 0x8D8DFFFF, "....%s", ReturnName(playerid, 0), params[100]);
	}
	else SendFactionMessage(playerid, 0x8D8DFFFF, "HQ: %s: %s", ReturnName(playerid, 0), params);
    return 1;
}

CMD:f(playerid, params[])
{
    if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

    
    if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "คุณได้ปิดการมองเห็นระบบแชทกลุ่มอยู่ พิมพ์ \"/togfam\" เพื่อเปิด");

    if(isnull(params)) return SendUsageMessage(playerid, "/f [ข้อความ]");

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{			
		if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
			return SendErrorMessage(playerid, "ระบบแชทกลุ่มถูกปิดการใช้งานอยู้ในขณะนี้");  
			
		if(strlen(params) > 79)
		{
			SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params); 
			SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params[79]); 
		}
		else SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params); 
		return 1;
	}
	
	if(strlen(params) > 79)
	{
		SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params); 
		SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params[79]); 
	}
	else SendFactionMessage(playerid, COLOR_FACTIONCHAT, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid, 0), params);
    return 1;
}

CMD:nofam(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s เปิดระบบแชทกลุ่ม", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = false;
	}
	else
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s ปิดระบบแชทกลุ่ม", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = true;
	}	
	return 1;
}

CMD:togfam(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
	
	if(PlayerInfo[playerid][pFactionChat] == true)
	{
		SendServerMessage(playerid, "คุณได้เปิดการมองเห็นระบบแชทกลุ่ม");
		PlayerInfo[playerid][pFactionChat] = false;
	}
	else
	{
		SendServerMessage(playerid, "คุณได้ปิดการมองเห็นระบบแชทกลุ่ม");
		PlayerInfo[playerid][pFactionChat] = true;
	}
	return 1;
}

CMD:invite(playerid, params[])
{
	new playerb;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้"); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/invite [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(PlayerInfo[playerb][pFaction])
		return SendErrorMessage(playerid, "ผู้เล่นคนนี้มีเฟคชั่นอยู่แล้ว"); 
		
	PlayerInfo[playerb][pFactionInvite] = PlayerInfo[playerid][pFaction];	
	PlayerInfo[playerb][pFactionInvitedBy] = playerid;
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "%s ได้เชิญคุณเจ้าเฟคชั่น %s พิมพ์ /accept เพื่อเข้าร่วม", ReturnName(playerid), ReturnFactionName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้เชิญ %s เข้าสู่เฟคชั่น %s", ReturnName(playerb), ReturnFactionName(playerid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณมีเฟคชั่นอยู่แล้ว");

	if(!PlayerInfo[playerid][pFactionInvite])
		return SendErrorMessage(playerid, "ไม่ได้มีการเชิญคุณเข้าร่วมเฟคชั่นในตอนนี้");

	if(FactionInfo[PlayerInfo[playerid][pFactionInvite]][eFactionType] == GOVERMENT)
	{
		PlayerInfo[playerid][pBadge] = random(99999);
	}
			
	SendClientMessageEx(PlayerInfo[playerid][pFactionInvitedBy], COLOR_YELLOW, "%s ได้รับกาคำเชิญของคุณในการเข้าร่วมเฟคชั่น", ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้เข้าร่วมเฟคชั่น %s เรียบร้อยแล้ว", ReturnFactionNameEx(PlayerInfo[playerid][pFactionInvite]));
	
	PlayerInfo[playerid][pFaction] = PlayerInfo[playerid][pFactionInvite]; 
	PlayerInfo[playerid][pFactionRank] = FactionInfo[PlayerInfo[playerid][pFactionInvite]][eFactionJoinRank];
	
	PlayerInfo[playerid][pFactionInvite] = 0;
	PlayerInfo[playerid][pFactionInvitedBy] = INVALID_PLAYER_ID;
	
	CharacterSave(playerid);
	return 1;
}

CMD:uninvite(playerid, params[])
{
	new playerb;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้"); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uninvite [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "ผู้เล่นคนนี้ไม่ได้อยู่ในเฟคชั่นของคุณ");
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "เฟคชั่น %s ได้นำคุณออกจากเฟคชั่นโดย %s", ReturnFactionNameEx(PlayerInfo[playerid][pFaction]), ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้เตะ %s ออกจากเฟคชั่น", ReturnName(playerb));
	
	PlayerInfo[playerb][pFaction] = 0;
	PlayerInfo[playerb][pFactionRank] = 0;
	
	SetPlayerSkin(playerb, 264); PlayerInfo[playerb][pLastSkin] = 264;
	CharacterSave(playerb);
	return 1;
}

CMD:giverank(playerid, params[])
{
    new playerb, rank;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

    if(sscanf(params, "ui", playerb, rank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
				continue;
				
			SendClientMessageEx(playerid, COLOR_HELPME, "-> Rank %i: %s", i, FactionRanks[PlayerInfo[playerid][pFaction]][i]); 
		}
	
		SendUsageMessage(playerid, "/giverank [ชื่อบางส่วน/ไอดี] [ต่ำแหน่ง/ยศ]");
		return 1;
	}

    if(rank < 1 || rank > 20)
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่ง มี 1-20 เท่านั้น"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");

    if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
        return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "ผู้เล่นคนนี้ไม่ได้อยู่ในเฟคชั่นของคุณ");
		
	if(PlayerInfo[playerb][pFactionRank] < PlayerInfo[playerid][pFactionRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่สามารถปรับหรือแก้ไข ยศ/ต่ำแหน่ง ของ %s", ReturnName(playerb));

    if(rank > PlayerInfo[playerb][pFactionRank])
    {
        SendClientMessageEx(playerb, COLOR_HELPME, "คุณถูกลดต่ำแหน่งของคุณ เป็น %s โดย %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ลดต่ำแหน่งของ %s จาก %s เป็น %s", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
        PlayerInfo[playerb][pFactionRank] = rank; 
        CharacterSave(playerb);
    }
    else
    {
        SendClientMessageEx(playerb, COLOR_HELPME, "คุณได้ถูกเพื่มต่ำแหน่งของคุณ เป็น %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้อัปเกรด ยศ/ต่ำแหน่งของ %s จาก %s เป็น %s", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
        PlayerInfo[playerb][pFactionRank] = rank; 
        CharacterSave(playerb);
    }
    return 1;
}

CMD:factionon(playerid, params[])
{
	new factionid;
	
	if(sscanf(params, "I(-1)", factionid))
		return SendUsageMessage(playerid, "/factionon [เฟคชั่นไอดี]");
		
	if(factionid == -1)
	{
		if(!PlayerInfo[playerid][pFaction])
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
			
		SendClientMessageEx(playerid, COLOR_GREY, "สมาชิก %s ออนไลน์:", ReturnFactionName(playerid)); 
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pFaction] != PlayerInfo[playerid][pFaction])
				continue;
				
			if(PlayerInfo[i][pAdminDuty])
				SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) {FF9900}%s %s", i, ReturnFactionRank(i), ReturnName(i));
				
			else
				SendClientMessageEx(playerid, COLOR_GREY, "(ID: %i) %s %s", i, ReturnFactionRank(i), ReturnName(i));
		}
		
		return 1;
	}

	if(!FactionInfo[factionid][eFactionDBID])
		return SendErrorMessage(playerid, "ไม่มีเฟคชั่นที่คุณระบุ");
		
	SendClientMessageEx(playerid, COLOR_RED, "[ ! ]{FFFFFF} %s มี %i ออกจาก %i สมาชิก ออนไลน์",  ReturnFactionNameEx(factionid), ReturnOnlineMembers(factionid), ReturnTotalMembers(factionid));
	return 1;
}

CMD:duty(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
	
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 

	
	if(ReturnFactionJob(playerid) == POLICE)
	{
		if(!PlayerInfo[playerid][pPoliceDuty])
		{
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดล็อกเกอร์");

			if(GetPlayerVirtualWorld(playerid) != FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawnWorld])
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดล็อกเกอร์");

			PlayerInfo[playerid][pPoliceDuty] = true;

			for(new i = 0; i < 4; i++)
			{
				playerWeaponsSave[playerid][i] = PlayerInfo[playerid][pWeapons][i];
				playerWeaponsAmmoSave[playerid][i] = PlayerInfo[playerid][pWeaponsAmmo][i];
			}

			SendPoliceMessage(0x8D8DFFFF, "HQ: %s %s has gone on duty", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			SendClientMessage(playerid, COLOR_WHITE, "สิ่งที่คุณจะได้รับ: Spraycan, Nitestick, Desert Eagle (60), Health(100)");

			new str[128];
			format(str, sizeof(str), "ได้หยิบตราประจำตัวออกมาจากตู้ล็อกเกอร์");
			callcmd::me(playerid, str);

			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);

			TakePlayerGuns(playerid);

			GivePlayerWeapon(playerid, 24, 100);
			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 41, 350);

			if(!PlayerInfo[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_COP);
			return 1;
		}
		else
		{
			PlayerInfo[playerid][pPoliceDuty] = false;

			ResetPlayerWeapons(playerid);

			for(new i = 0; i < 4; i++)
			{
				PlayerInfo[playerid][pWeapons][i] = 0; PlayerInfo[playerid][pWeaponsAmmo][i] = 0;

				if(playerWeaponsSave[playerid][i])
					GivePlayerGun(playerid, playerWeaponsSave[playerid][i], playerWeaponsAmmoSave[playerid][i]);
			}

			SendPoliceMessage(0x8D8DFFFF, " HQ: %s %s has gone off duty", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			new str[128];
			format(str, sizeof(str), "วางตราประจำตัวไว้ที่ล็อคเกอร์");
			callcmd::me(playerid, str);

			SetPlayerArmour(playerid, 0);
			SetPlayerHealth(playerid, 100);

			if(!PlayerInfo[playerid][pAdminDuty])
			SetPlayerColor(playerid, COLOR_WHITE);

			if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pLastSkin])
			SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);
			return 1;
		}
	}
	if(ReturnFactionJob(playerid) == SHERIFF)
	{
        if(!PlayerInfo[playerid][pSheriffDuty])
        {
            if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดล็อกเกอร์");
 
            PlayerInfo[playerid][pSheriffDuty] = true;
 
            for(new i = 0; i < 4; i++)
            {
                playerWeaponsSave[playerid][i] = PlayerInfo[playerid][pWeapons][i];
                playerWeaponsAmmoSave[playerid][i] = PlayerInfo[playerid][pWeaponsAmmo][i];
            }
 
            SendSheriffMessage(0x8D8DFFFF, "HQ: %s %s ได้เริ่มปฏิบัตหน้าที่แล้วตอนนี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
            SendClientMessage(playerid, COLOR_WHITE, "สิ่งที่คุณจะได้รับ: Spraycan, Nitestick, Desert Eagle (60), Health(100)");
 
            new str[128];
			format(str, sizeof(str), "ได้หยิบตราประจำตัวออกมาจากตู้ล็อกเกอร์");
			callcmd::me(playerid, str);
 
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 100);
 
            TakePlayerGuns(playerid);
 
            GivePlayerWeapon(playerid, 24, 100);
            GivePlayerWeapon(playerid, 3, 1);
            GivePlayerWeapon(playerid, 41, 350);
 
            if(!PlayerInfo[playerid][pAdminDuty])
                SetPlayerColor(playerid, COLOR_COP);
 
            return 1;
        }
 
        if(PlayerInfo[playerid][pSheriffDuty])
        {
            PlayerInfo[playerid][pSheriffDuty] = false;
 
            ResetPlayerWeapons(playerid);
 
            for(new i = 0; i < 4; i++)
            {
                PlayerInfo[playerid][pWeapons][i] = 0; PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
 
                if(playerWeaponsSave[playerid][i])
                    GivePlayerGun(playerid, playerWeaponsSave[playerid][i], playerWeaponsAmmoSave[playerid][i]);
            }
 
            SendPoliceMessage(0x8D8DFFFF, " HQ: %s %s ได้ออกจากการปติบัตหน้าที่ในเวลานี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
           	new str[128];
			format(str, sizeof(str), "วางตราประจำตัวไว้ที่ล็อคเกอร์");
			callcmd::me(playerid, str);
 
            SetPlayerArmour(playerid, 0);
            SetPlayerHealth(playerid, 100);
 
            if(!PlayerInfo[playerid][pAdminDuty])
            SetPlayerColor(playerid, COLOR_WHITE);
 
            if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pLastSkin])
            SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);
 
            return 1;
        }
    }
	if(ReturnFactionJob(playerid) == MEDIC)
	{
	    if(!PlayerInfo[playerid][pMedicDuty])
		{
	    	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดล็อกเกอร์");

			PlayerInfo[playerid][pMedicDuty] = true;

			for(new i = 0; i < 4; i++)
			{
				playerWeaponsSave[playerid][i] = PlayerInfo[playerid][pWeapons][i];
				playerWeaponsAmmoSave[playerid][i] = PlayerInfo[playerid][pWeaponsAmmo][i];
			}

			SendMedicMessage(0xFF8282FF, "HQ: %s %s ได้เริ่มปฏิบัตหน้าที่แล้วตอนนี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			SendClientMessage(playerid, COLOR_WHITE, "สิ่งที่คุณจะได้รับ: ถังดับเพลิง");

			new str[128];
			format(str, sizeof(str), "ได้หยิบตราประจำตัวออกมาจากตู้ล็อกเกอร์");
			callcmd::me(playerid, str);

    		SetPlayerColor(playerid, 0xFF8282FF);
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);

			TakePlayerGuns(playerid);

			GivePlayerWeapon(playerid, 42, 500);

			if(!PlayerInfo[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_PINK);

            return 1;
		}

		if(PlayerInfo[playerid][pMedicDuty])
		{
		    PlayerInfo[playerid][pMedicDuty] = false;

			ResetPlayerWeapons(playerid);

			for(new i = 0; i < 4; i++)
			{
				PlayerInfo[playerid][pWeapons][i] = 0; PlayerInfo[playerid][pWeaponsAmmo][i] = 0;

				if(playerWeaponsSave[playerid][i])
					GivePlayerGun(playerid, playerWeaponsSave[playerid][i], playerWeaponsAmmoSave[playerid][i]);
			}

			SendMedicMessage(0xFF8282FF, " HQ: %s %s ได้ออกจากการปติบัตหน้าที่ในเวลานี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			new str[128];
			format(str, sizeof(str), "วางตราประจำตัวไว้ที่ล็อคเกอร์");
			callcmd::me(playerid, str);

			SetPlayerArmour(playerid, 0);
			SetPlayerHealth(playerid, 100);

			if(!PlayerInfo[playerid][pAdminDuty])
			SetPlayerColor(playerid, COLOR_WHITE);

			if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pLastSkin])
			SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);

			return 1;
		}
	}
	if(ReturnFactionJob(playerid) == SADCR)
	{
	    if(!PlayerInfo[playerid][pSADCRDuty])
		{
	    	if(!IsPlayerInRangeOfPoint(playerid, 5.0, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][0], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][1], FactionInfo[PlayerInfo[playerid][pFaction]][eFactionSpawn][2]))
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดล็อกเกอร์");

			PlayerInfo[playerid][pSADCRDuty] = true;

			for(new i = 0; i < 4; i++)
			{
				playerWeaponsSave[playerid][i] = PlayerInfo[playerid][pWeapons][i];
				playerWeaponsAmmoSave[playerid][i] = PlayerInfo[playerid][pWeaponsAmmo][i];
			}

			SendDOCMessage(0xFF8282FF, "HQ: %s %s ได้เริ่มปฏิบัตหน้าที่แล้วตอนนี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			SendClientMessage(playerid, COLOR_WHITE, "สิ่งที่คุณจะได้รับ: ถังดับเพลิง");

			new str[128];
			format(str, sizeof(str), "ได้หยิบตราประจำตัวออกมาจากตู้ล็อกเกอร์");
			callcmd::me(playerid, str);

    		SetPlayerColor(playerid, 0xFF8282FF);
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);

			TakePlayerGuns(playerid);

			GivePlayerWeapon(playerid, 25, 150);
			GivePlayerWeapon(playerid, 24, 150);
			GivePlayerWeapon(playerid, 3, 1);
			GivePlayerWeapon(playerid, 41, 350);

			if(!PlayerInfo[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_PINK);

            return 1;
		}

		if(PlayerInfo[playerid][pSADCRDuty])
		{
		    PlayerInfo[playerid][pSADCRDuty] = false;

			ResetPlayerWeapons(playerid);

			for(new i = 0; i < 4; i++)
			{
				PlayerInfo[playerid][pWeapons][i] = 0; PlayerInfo[playerid][pWeaponsAmmo][i] = 0;

				if(playerWeaponsSave[playerid][i])
					GivePlayerGun(playerid, playerWeaponsSave[playerid][i], playerWeaponsAmmoSave[playerid][i]);
			}

			SendDOCMessage(0xFF8282FF, " HQ: %s %s ได้ออกจากการปติบัตหน้าที่ในเวลานี้", ReturnFactionRank(playerid), ReturnName(playerid, 0));
			new str[128];
			format(str, sizeof(str), "วางตราประจำตัวไว้ที่ล็อคเกอร์");
			callcmd::me(playerid, str);

			SetPlayerArmour(playerid, 0);
			SetPlayerHealth(playerid, 100);

			if(!PlayerInfo[playerid][pAdminDuty])
			SetPlayerColor(playerid, COLOR_WHITE);

			if(GetPlayerSkin(playerid) != PlayerInfo[playerid][pLastSkin])
			SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);

			return 1;
		}
	}
	else return SendErrorMessage(playerid, "มีข้อผิดพลาดเกิดขึ้น");
    return 1;
}

CMD:showbadge(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 
		
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/showbadge [ชื่อบางส่วน/ไอดี]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");
		
	if(playerb == playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบตราประจำตัวขึ้นมาดู", ReturnName(playerid, 0));
	
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบตราประจำตัวขึ้นมาและยื่นให้กับ %s ดู", ReturnName(playerid, 0), ReturnName(playerb, 0));
	
	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	
	SendClientMessageEx(playerb, COLOR_GRAD2, "  ชื่อ: %s", ReturnNameLetter(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  เลขตรา: %d", PlayerInfo[playerid][pBadge]);
	SendClientMessageEx(playerb, COLOR_GRAD2, "  ยศ/ต่ำแหน่ง: %s", ReturnFactionRank(playerid));
	SendClientMessageEx(playerb, COLOR_GRAD2, "  สำนักงาน: %s", ReturnFactionName(playerid));
	
	SendClientMessage(playerb, COLOR_COP, "______________________________________");
	return 1;
}

alias:megaphone("m")
CMD:megaphone(playerid, params[])
{
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/(m)egaphone [ข้อความ]"); 
		
	SendNearbyMessage(playerid, 70.0, COLOR_YELLOWEX, "[%s:o< %s ]", ReturnRealName(playerid, 0), params);
    return 1;
}

alias:department("d","dep")
CMD:department(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/(d)epartment [ข้อความ]");

	foreach(new i : Player)
	{
		new
			factionid;
			
		factionid = PlayerInfo[i][pFaction];
			
		if(FactionInfo[factionid][eFactionType] == GOVERMENT)
		{
			SendClientMessageEx(i, COLOR_DEPT, "** [%s] %s %s: %s", FactionInfo[factionid][eFactionAbbrev], ReturnFactionRank(i), ReturnName(playerid, 0), params); 
		}
	}

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
 		if(i == playerid)
   			continue;

		else if(IsPlayerInRangeOfPoint(i, 20.0, posx,posy,posz))
		{
  			SendClientMessageEx(i, COLOR_GRAD1, "%s พูดว่า (วิทยุ): %s", ReturnName(playerid, 0), params);
 		}
	}
	return 1;
}

CMD:carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
		
	new
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/carsign [ข้อความ]"); 
		
	if(strlen(params) < 2 || strlen(params) >= 50)
		return SendErrorMessage(playerid, "คุณไม่สามารถตั้ง นามขาล ได้ต่ำกว่า 2 ตัวอักษรและไม่เกิน 50 ตัวอักษร");
		
	if(VehicleInfo[vehicleid][eVehicleHasCarsign])
		Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleCarsign], COLOR_WHITE, params);
	
	else
	{
		SendServerMessage(playerid, "หากใช้เส็ดแล้วโปรดพิมพ์ /remove_carsign  ด้วย"); 
		
		VehicleInfo[vehicleid][eVehicleCarsign] = Create3DTextLabel(params, COLOR_WHITE, 0.0, 0.0, 0.0, 25.0, GetPlayerVirtualWorld(playerid), 0); 
		Attach3DTextLabelToVehicle(VehicleInfo[vehicleid][eVehicleCarsign], vehicleid, -0.7, -1.9, -0.3); 
		
		VehicleInfo[vehicleid][eVehicleHasCarsign] = true;
	}
	return 1;
}

CMD:remove_carsign(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
		
	new
		vehicleid = GetPlayerVehicleID(playerid);
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 
		
	if(!VehicleInfo[vehicleid][eVehicleHasCarsign])
		return SendErrorMessage(playerid, "รถคันนี้ไม่ได้มี นามขาลอยู่แล้ว"); 
	
	Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleCarsign]); 
	VehicleInfo[vehicleid][eVehicleHasCarsign] = false;

	SendServerMessage(playerid, "คุณได้ลบ นามขาล ของรถตันนนี้เรียบร้อยแล้ว"); 
	return 1;
}

CMD:park(playerid ,params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่มีเฟคชั่น");

	new factionid = PlayerInfo[playerid][pFaction];
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");

	if(VehFacInfo[vehicleid][VehFacFaction] != factionid)
		return SendErrorMessage(playerid, "รถคันนี้ไม่ใช่รถเฟคชั่นของคุณ");

	GetVehiclePos(vehicleid, VehFacInfo[vehicleid][VehFacPos][0], VehFacInfo[vehicleid][VehFacPos][1], VehFacInfo[vehicleid][VehFacPos][2]);
	GetVehicleZAngle(vehicleid, VehFacInfo[vehicleid][VehFacPos][3]);
	VehFacInfo[vehicleid][VehFacPosWorld] = GetPlayerVirtualWorld(playerid); 

	SendFactionMessage(playerid, COLOR_FACTION, "**(( %s ได้เปลี่ยนจุดยานพาหนะ ไอดี %d ))**",ReturnRealName(playerid, 0), VehFacInfo[vehicleid][VehFacDBID]);

	SaveFacVehicle(vehicleid);

	DestroyVehicle(vehicleid);

	vehicleid = CreateVehicle(VehFacInfo[vehicleid][VehFacModel], VehFacInfo[vehicleid][VehFacPos][0], VehFacInfo[vehicleid][VehFacPos][1], VehFacInfo[vehicleid][VehFacPos][2], VehFacInfo[vehicleid][VehFacPos][3], VehFacInfo[vehicleid][VehFacColor][0], VehFacInfo[vehicleid][VehFacColor][1], -1, 0);
	ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	PutPlayerInVehicle(playerid, vehicleid, 0);
	return 1;
}

CMD:towcars(playerid, params[])
{
	new id = PlayerInfo[playerid][pFaction];

	if(FactionInfo[id][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[id][eFactionAlterRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	for(new v = 1; v< MAX_FACTION_VEHICLE; v++)
	{
		if(!VehFacInfo[v][VehFacFaction])
			continue;

		if(VehFacInfo[v][VehFacFaction] != id)
			continue;

		if(IsVehicleOccupied(v))
			continue;

		Delete3DTextLabel(VehicleInfo[v][eVehicleCarsign]); 
		VehicleInfo[v][eVehicleHasCarsign] = false;

		SetVehicleToRespawn(v);
		SetVehicleVirtualWorld(v, VehFacInfo[v][VehFacPosWorld]);
		SetVehicleNumberPlate(v, FactionInfo[id][eFactionAbbrev]);
		SetVehicleHp(v);

		if(IsValidDynamicObject(VehicleSiren[v]))
		{
			DestroyDynamicObject(VehicleSiren[v]);
			VehicleSiren[v] = INVALID_OBJECT_ID;
		}
	}

	SendFactionMessageEx(playerid, COLOR_FACTION, "**(( %s ได้ส่งยานพาหนะที่ไม่มีคนนั่งของกลุ่มกลับจุดเกิดทั้งหมด ))**", ReturnName(playerid, 0));
	return 1;
}

alias:checkgovcash("checkgc")
CMD:checkgovcash(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในแฟคชั่น รัฐบาล");

	new factionid = PlayerInfo[playerid][pFaction];

	if(FactionInfo[factionid][eFactionJob] != GOV)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในแฟคชั่นที่เกี่ยวกับการบริหารงบประมาณของรัฐบาล");

	SendClientMessageEx(playerid, COLOR_HELPME, "เงินในกรมการคลังของรัฐ San Andreas: $%s",MoneyFormat(GlobalInfo[G_GovCash]));
	return 1;
}

CMD:siren(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);
	new modelid = GetVehicleModel(vehicleid);

	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะนี้ได้");

	/*if(!HasSiren(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะนี้ได้ (จำเป็นต้องเป็นยานพาหนะที่ได้รับอนุญาตเท่านั้น)");*/

	if(!IsValidDynamicObject(VehicleSiren[vehicleid]))
	{
		if(modelid != 560 && modelid != 541 && modelid != 525 && modelid != 426 && modelid != 579) return SendClientMessage(playerid, COLOR_GREY, "ไซเรนรองรับเฉพาะยานพาหนะรุ่น Sultan/Bullet/Towtruck/Premier/Huntley");

		if(modelid == 560)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.225000,0.750000,0.449999, 0.000000, 0.000000, 0.000000);
		}
		if(modelid == 541)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.375000,0.524999,0.375000, 0.000000, 0.000000, 0.000000);
		}
		if(modelid == 426)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.524999,0.749999, 0.375000, 0.000000, 0.000000, 0.000000);
		}
		if(modelid == 525)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(19419, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.0, -0.485, 1.36, 0.000000, 0.000000, 180.0);
		}
		if(modelid == 579)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid,  0.679999, 0.479999, 0.734999, 0.000000, 0.000000, 0.000000);
		}
        SendClientMessage(playerid, COLOR_LIGHTGREEN, "คุณติดไซเรน");
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "คุณถอดไซเรนออก");
		DestroyDynamicObject(VehicleSiren[vehicleid]);
	}
	return 1;
}

CMD:siren2(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);
	new modelid = GetVehicleModel(vehicleid);

	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะนี้ได้");

	if(!IsValidDynamicObject(VehicleSiren[vehicleid]))
	{
		if(modelid != 560 && modelid != 426) return SendClientMessage(playerid, COLOR_GREY, "ไซเรนรองรับเฉพาะยานพาหนะรุ่น Sultan/Premier");

		if(modelid == 560)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(19419, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.000000, -1.289999, 0.394999, 0.000000, 0.000000, 0.000000);
			return 1;
		}
		if(modelid == 426)
		{
			VehicleSiren[vehicleid] = CreateDynamicObject(19419, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, 0.000000, -1.669998, 0.349999, 0.000000, 0.000000, 0.000000);
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "คุณถอดไซเรนออก");
		DestroyDynamicObject(VehicleSiren[vehicleid]);
		
	}
	return 1;
}

CMD:siren3(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

	new vehicleid = GetPlayerVehicleID(playerid);
	//new modelid = GetVehicleModel(vehicleid);
	new type[8];

	if(HasNoEngine(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะนี้ได้");

	if(sscanf(params, "s[8]", type))
	{
		SendClientMessage(playerid, COLOR_WHITE, "[Usage]: /siren [ตำแหน่ง]");
		SendClientMessage(playerid, COLOR_WHITE, "ตำแหน่ง: ภายใน | หลังคา | ปิด");
		return 1;
	}

	if(!strcmp(type, "ภายใน"))
	{
		if(VehicleSiren[vehicleid] != INVALID_OBJECT_ID) return SendClientMessage(playerid, COLOR_GREY, "พาหนะคันนี้ติดไซเรนแล้ว");
        VehicleSiren[vehicleid] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
        AttachDynamicObjectToVehicle(VehicleSiren[vehicleid],vehicleid, 0.0, 0.75, 0.275, 0.0, 0.1, 0.0);
        return 1;
	}
	else if(!strcmp(type, "หลังคา"))
	{
	    if(VehicleSiren[vehicleid] != INVALID_OBJECT_ID) return SendClientMessage(playerid, COLOR_GREY, "พาหนะคันนี้ติดไซเรนแล้ว");
        VehicleSiren[vehicleid] = CreateDynamicObject(18646, 10.0, 10.0, 10.0, 0, 0, 0);
        AttachDynamicObjectToVehicle(VehicleSiren[vehicleid], vehicleid, -0.43, 0.0, 0.785, 0.0, 0.1, 0.0);
        return 1;
	}
	else if(!strcmp(type, "ปิด"))
	{
	    if(VehicleSiren[vehicleid] != INVALID_OBJECT_ID) return SendClientMessage(playerid, COLOR_GREY, "พาหนะคันนี้ยังไม่ได้ติดไซเรน");
		DestroyDynamicObject(VehicleSiren[vehicleid]);
		VehicleSiren[vehicleid] = INVALID_OBJECT_ID;
		return 1;
	}
	return 1;
}

CMD:setbadge(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล");

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	new tagetid, badgenumber;

	if(sscanf(params, "ud", tagetid, badgenumber))
		return SendUsageMessage(playerid, "/setbadge <ชื่อบางส่วน/ไอดี> <เลขตรา>");
	
	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
	
	if(PlayerInfo[playerid][pFaction] != PlayerInfo[tagetid][pFaction])
		return SendErrorMessage(playerid, "แฟคชั่นของผู้เล่นไม่ได้อยู่กับคุณ");

	
	PlayerInfo[tagetid][pBadge] = badgenumber;
	
	CharacterSave(playerid);
	CharacterSave(tagetid);

	SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้เปลี่ยนเลขตราให้กับ %s เป็น %d",ReturnName(tagetid,0), badgenumber);
	SendClientMessageEx(tagetid, COLOR_HELPME, "%s ได้เปลี่ยนได้เลขตราให้คุณเป็น %d",ReturnName(playerid,0), badgenumber);
	return 1;
}

CMD:customskin(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

	new skinid, factionid = PlayerInfo[playerid][pFaction];
	if(sscanf(params, "d", skinid))
	{
		new skincuount;
		for(new i = 1; i < 31; i++)
		{
			if(!CustomskinFacInfo[factionid][FactionSkin][i])
				continue;
			
			skincuount = i;
		}

		SendUsageMessage(playerid, "/customskin <1-%d>", skincuount);
		return 1;
	}

	if(skinid < 1 || skinid > 30)
		return SendErrorMessage(playerid, "คุณใส่ สกินไม่ถูกต้อง");

	if(!CustomskinFacInfo[factionid][FactionSkin][skinid])
		return SendErrorMessage(playerid, "คุณใส่ สกินไม่ถูกต้อง");
	
	SetPlayerSkin(playerid, CustomskinFacInfo[factionid][FactionSkin][skinid]);
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    foreach(new i : Player)
	{
		if(PlayerInfo[i][pFactionInvitedBy] == playerid)
		{
			PlayerInfo[i][pFactionInvite] = 0;
			PlayerInfo[i][pFactionInvitedBy] = INVALID_PLAYER_ID;
			SendClientMessage(i, COLOR_YELLOW, "คำเชิญเข้าร่วมของคุณถูกเพิกเฉย ผู้เชิญของคุณถูกยกเลิกการเชื่อมต่อ");
		}
	}
    return 1;
}

stock ReturnNameLetter(playerid)
{
	new 
		playersName[MAX_PLAYER_NAME]
	; 
	
	GetPlayerName(playerid, playersName, sizeof(playersName));
	
	format(playersName, sizeof(playersName), "%c. %s", playersName[0], playersName[strfind(playersName, "_") + 1]);
	return playersName;
}


stock SendFactionMessage(playerid, color, const str[], {Float,_}:...)
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
			if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
				if(PlayerInfo[i][pFactionChat] == false)
  				{ 
					SendClientMessage(i, color, string);
				}
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
			if(PlayerInfo[i][pFactionChat] == false)
  			{ 
				SendClientMessage(i, color, str);
			}
		}
	}
	return 1;
}

stock SendFactionMessageEx(playerid, color, const str[], {Float,_}:...)
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
			if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pFaction] == PlayerInfo[playerid][pFaction]) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendPoliceMessage(color, const str[], {Float,_}:...)
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
			if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == POLICE) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == POLICE) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendSheriffMessage(color, const str[], {Float,_}:...)
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
			if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == SHERIFF) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == SHERIFF) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendMedicMessage(color, const str[], {Float,_}:...)
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
			if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == MEDIC) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == MEDIC) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock SendDOCMessage(color, const str[], {Float,_}:...)
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
			if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == SADCR) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (FactionInfo[PlayerInfo[i][pFaction]][eFactionJob] == SADCR) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}


stock HasSiren(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 581, 521, 522, 461, 468, 523, 416, 427, 490,
			 528, 407, 544, 470, 596, 598, 599, 597, 607, 
			 428, 560: return 1;
	}
	return 0;
}

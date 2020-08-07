#include <YSI_Coding\y_hooks>


alias:factionhelp("fhelp")
CMD:factionhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_RED, "[FACTION]:{FFFFFF} /f, /togfam, /nofam, /factionhelp"); 

    if(!PlayerInfo[playerid][pFaction])
		return 1;
    
    if(ReturnFactionType(playerid) == GOVERMENT)
    {
        SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /duty, /cuff, /uncuff, /showbadge, /m(egaphone), /(dep)artment,");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /carsign, /remove_carsign, /tazer, /take, /givelicense, /impound, /mdc, /wanted");
		
		if(PlayerInfo[playerid][pFactionRank] <= FactionInfo[PlayerInfo[playerid][pFaction]][eFactionTowRank])
			SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} /towcars");

        return 1;
    }
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
			SendFactionMessage(playerid, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
			SendFactionMessage(playerid, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params[79]); 
		}
		else SendFactionMessage(playerid, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
		return 1;
	}
	
	if(strlen(params) > 79)
	{
		SendFactionMessage(playerid, "**(( %s %s: %.79s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params); 
		SendFactionMessage(playerid, "**(( %s %s: ...%s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params[79]); 
	}
	else SendFactionMessage(playerid, "**(( %s %s: %s ))**", ReturnFactionRank(playerid), ReturnName(playerid), params);
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
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
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
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
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
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

    if(sscanf(params, "ui", playerb, rank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
				continue;
				
			SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> Rank %i: %s", i, FactionRanks[PlayerInfo[playerid][pFaction]][i]); 
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
		
	if(PlayerInfo[playerb][pFactionRank] < PlayerInfo[playerid][pFactionRank])
		return SendErrorMessage(playerid, "คุณไม่สามารถปรับหรือแก้ไข ยศ/ต่ำแหน่ง ของ %s", ReturnName(playerb));

    if(rank > PlayerInfo[playerb][pFactionRank])
    {
        SendClientMessageEx(playerb, COLOR_YELLOW, "คุณถูกลดต่ำแหน่งของคุณ เป็น %s โดย %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ลดต่ำแหน่งของ %s จาก %s เป็น %s!", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
        PlayerInfo[playerb][pFactionRank] = rank; 
        CharacterSave(playerb);
    }
    else
    {
        SendClientMessageEx(playerb, COLOR_YELLOW, "คุณได้ถูกเพื่มต่ำแหน่งของคุณ เป็น %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้อัปเกรด ยศ/ต่ำแหน่งของ %s จาก %s เป็น %s!", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
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


stock SendFactionMessage(playerid, const str[], {Float,_}:...)
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
					SendClientMessage(i, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor], string);
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
				SendClientMessage(i, FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatColor], str);
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
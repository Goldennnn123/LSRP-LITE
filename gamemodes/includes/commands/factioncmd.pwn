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
		return SendErrorMessage(playerid, "�س����������࿤���");

    
    if(PlayerInfo[playerid][pFactionChat] == true)
		return SendErrorMessage(playerid, "�س��Դ����ͧ����к�᪷��������� ����� \"/togfam\" �����Դ");

    if(isnull(params)) return SendUsageMessage(playerid, "/f [��ͤ���]");

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{
		if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
			return SendErrorMessage(playerid, "�к�᪷������١�Դ�����ҹ����㹢�й��");  
			
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
		return SendErrorMessage(playerid, "�س����������࿤���");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "��/����˹觢ͧ�س ������Ѻ͹حҵ���������觹��");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] == true)
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s �Դ�к�᪷�����", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = false;
	}
	else
	{
		SendFactionMessageEx(playerid, COLOR_RED, "%s �Դ�к�᪷�����", ReturnName(playerid));
		FactionInfo[PlayerInfo[playerid][pFaction]][eFactionChatStatus] = true;
	}	
	return 1;
}

CMD:togfam(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�س����������࿤���");
	
	if(PlayerInfo[playerid][pFactionChat] == true)
	{
		SendServerMessage(playerid, "�س���Դ����ͧ����к�᪷�����");
		PlayerInfo[playerid][pFactionChat] = false;
	}
	else
	{
		SendServerMessage(playerid, "�س��Դ����ͧ����к�᪷�����");
		PlayerInfo[playerid][pFactionChat] = true;
	}
	return 1;
}

CMD:invite(playerid, params[])
{
	new playerb;
	
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�س����������࿤���");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "��/����˹觢ͧ�س ������Ѻ͹حҵ���������觹��"); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/invite [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	if(PlayerInfo[playerb][pFaction])
		return SendErrorMessage(playerid, "�����蹤������࿤�����������"); 
		
	PlayerInfo[playerb][pFactionInvite] = PlayerInfo[playerid][pFaction];	
	PlayerInfo[playerb][pFactionInvitedBy] = playerid;
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "%s ���ԭ�س���࿤��� %s ����� /accept �����������", ReturnName(playerid), ReturnFactionName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "�س���ԭ %s ������࿤��� %s", ReturnName(playerb), ReturnFactionName(playerid));
	return 1;
}

CMD:accept(playerid, params[])
{
	if(PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�س��࿤�����������");

	if(!PlayerInfo[playerid][pFactionInvite])
		return SendErrorMessage(playerid, "������ա���ԭ�س�������࿤���㹵͹���");
			
	SendClientMessageEx(PlayerInfo[playerid][pFactionInvitedBy], COLOR_YELLOW, "%s ���Ѻ�Ҥ��ԭ�ͧ�س㹡���������࿤���", ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "�س���������࿤��� %s ���º��������", ReturnFactionNameEx(PlayerInfo[playerid][pFactionInvite]));
	
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
		return SendErrorMessage(playerid, "�س����������࿤���");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "��/����˹觢ͧ�س ������Ѻ͹حҵ���������觹��"); 
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uninvite [���ͺҧ��ǹ/�ʹ�]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
		
	if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�����蹤��������������࿤��蹢ͧ�س");
	
	SendClientMessageEx(playerb, COLOR_YELLOW, "࿤��� %s ��Ӥس�͡�ҡ࿤����� %s", ReturnFactionNameEx(PlayerInfo[playerid][pFaction]), ReturnName(playerid));
	SendClientMessageEx(playerid, COLOR_YELLOW, "�س���� %s �͡�ҡ࿤���", ReturnName(playerb));
	
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
		return SendErrorMessage(playerid, "�س����������࿤���");
		
	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "��/����˹觢ͧ�س ������Ѻ͹حҵ���������觹��");

    if(sscanf(params, "ui", playerb, rank))
	{
		for(new i = 1; i < MAX_FACTION_RANKS; i++)
		{
			if(!strcmp(FactionRanks[PlayerInfo[playerid][pFaction]][i], "NotSet"))
				continue;
				
			SendClientMessageEx(playerid, COLOR_YELLOWEX, "-> Rank %i: %s", i, FactionRanks[PlayerInfo[playerid][pFaction]][i]); 
		}
	
		SendUsageMessage(playerid, "/giverank [���ͺҧ��ǹ/�ʹ�] [����˹�/��]");
		return 1;
	}

    if(rank < 1 || rank > 20)
		return SendErrorMessage(playerid, "��/����˹� �� 1-20 ��ҹ��"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");

    if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
        return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

    if(PlayerInfo[playerb][pFaction] != PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�����蹤��������������࿤��蹢ͧ�س");
		
	if(PlayerInfo[playerb][pFactionRank] < PlayerInfo[playerid][pFactionRank])
		return SendErrorMessage(playerid, "�س�������ö��Ѻ������� ��/����˹� �ͧ %s", ReturnName(playerb));

    if(rank > PlayerInfo[playerb][pFactionRank])
    {
        SendClientMessageEx(playerb, COLOR_YELLOW, "�س�١Ŵ����˹觢ͧ�س �� %s �� %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "�س��Ŵ����˹觢ͧ %s �ҡ %s �� %s!", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
        PlayerInfo[playerb][pFactionRank] = rank; 
        CharacterSave(playerb);
    }
    else
    {
        SendClientMessageEx(playerb, COLOR_YELLOW, "�س��١��������˹觢ͧ�س �� %s", FactionRanks[PlayerInfo[playerb][pFaction]][rank], ReturnRealName(playerid, 0)); 
        SendClientMessageEx(playerid, COLOR_YELLOW, "�س���ѻ�ô ��/����˹觢ͧ %s �ҡ %s �� %s!", ReturnRealName(playerb, 0), FactionRanks[PlayerInfo[playerb][pFaction]][PlayerInfo[playerb][pFactionRank]], FactionRanks[PlayerInfo[playerb][pFaction]][rank]);
            
        PlayerInfo[playerb][pFactionRank] = rank; 
        CharacterSave(playerb);
    }
    return 1;
}

CMD:factionon(playerid, params[])
{
	new factionid;
	
	if(sscanf(params, "I(-1)", factionid))
		return SendUsageMessage(playerid, "/factionon [࿤����ʹ�]");
		
	if(factionid == -1)
	{
		if(!PlayerInfo[playerid][pFaction])
			return SendErrorMessage(playerid, "�س����������࿤���");
			
		SendClientMessageEx(playerid, COLOR_GREY, "��Ҫԡ %s �͹�Ź�:", ReturnFactionName(playerid)); 
		
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
		return SendErrorMessage(playerid, "�����࿤��蹷��س�к�");
		
	SendClientMessageEx(playerid, COLOR_RED, "[ ! ]{FFFFFF} %s �� %i �͡�ҡ %i ��Ҫԡ �͹�Ź�",  ReturnFactionNameEx(factionid), ReturnOnlineMembers(factionid), ReturnTotalMembers(factionid));
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
			SendClientMessage(i, COLOR_YELLOW, "���ԭ��������ͧ�س�١�ԡ�� ����ԭ�ͧ�س�١¡��ԡ�����������");
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
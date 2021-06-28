alias:testerchat("t")
CMD:testerchat(playerid, params[])
{
    if(!PlayerInfo[playerid][pTester] && !PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);

    if(!e_pAccountData[playerid][mForumName])
        return SendErrorMessage(playerid, "ไปตั้งชื่อ Forumname ให้เรียบร้อยก่อน /forumname");
		
	if(isnull(params)) return SendUsageMessage(playerid, "/t (Tester Chat) <ข้อความ>"); 
	
	if(strlen(params) > 89)
	{
		SendTesterMessageEx(COLOR_YELLOW2, "{F5B041}*%s[%d] %s: %.89s ...", PlayerInfo[playerid][pTester] == 0 ? ("Admin") : ("Tester"), PlayerInfo[playerid][pTester] == 0 ? PlayerInfo[playerid][pAdmin] : PlayerInfo[playerid][pTester], e_pAccountData[playerid][mForumName], params);
		SendTesterMessageEx(COLOR_YELLOW2, "{F5B041}*%s[%d] %s: ... %s", PlayerInfo[playerid][pTester] == 0 ? ("Admin") : ("Tester"), PlayerInfo[playerid][pTester] == 0 ? PlayerInfo[playerid][pAdmin] : PlayerInfo[playerid][pTester], e_pAccountData[playerid][mForumName], params[89]);
	}
	else SendTesterMessageEx(COLOR_YELLOW2, "{F5B041}*%s[%d] %s: %s", PlayerInfo[playerid][pTester] == 0 ? ("Admin") : ("Tester"), PlayerInfo[playerid][pTester] == 0 ? PlayerInfo[playerid][pAdmin] : PlayerInfo[playerid][pTester], e_pAccountData[playerid][mForumName], params);
    return 1;
}


CMD:tduty(playerid, params[])
{
	if(!PlayerInfo[playerid][pTester])
		return SendUnauthMessage(playerid);
		
	new str[128];
		
	if(PlayerInfo[playerid][pTesterDuty])
	{
		PlayerInfo[playerid][pTesterDuty] = false;
		
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
		PlayerInfo[playerid][pTesterDuty] = true;
		
		format(str, sizeof(str), "{FF5722}%s {43A047}ได้เริ่มปฏิบัตรหน้าที่เป็นผู้ดูแลระบบแล้วในขณะนี้", ReturnRealName(playerid)); 
		SendAdminMessage(1, str);
		
		SetPlayerColor(playerid, 0x66000000);
	}
	
	return 1; 
}


CMD:tcmds(playerid, params[])
{
    if(!PlayerInfo[playerid][pTester] && !PlayerInfo[playerid][pAdmin])
	    return SendClientMessage(playerid, COLOR_GRAD1, "คุณไม่ใช่ Tester");

    if(PlayerInfo[playerid][pTester] >= 1 || PlayerInfo[playerid][pAdmin])
	{
	    SendClientMessage(playerid, COLOR_GREEN, "___________________________Tester COMMANDS___________________________");

		SendClientMessage(playerid, COLOR_GRAD1, "[Level 1]: /tduty (/t)ester(c)hat /helpmes /checkafk");
	}
	if (PlayerInfo[playerid][pTester] >= 2 || PlayerInfo[playerid][pAdmin])
	{
		SendClientMessage(playerid, COLOR_GRAD1, "[Level 2]: /kick /forcerespawn");
	}
	if (PlayerInfo[playerid][pTester] >= 3 || PlayerInfo[playerid][pAdmin])
	{
		SendClientMessage(playerid, COLOR_GRAD1, "[Level 3]: /ajail, /aunjail");
	}
    return 1;
}

CMD:checkafk(playerid, params[])
{
	if(!PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
        return SendErrorMessage(playerid, "คุณไม่ใช่ผู้ดูแลระบบ");

	new bool:success;

	SendClientMessage(playerid, COLOR_GREEN, "___________________________[AFK SYSTEM]___________________________");

	new str[60];
	foreach(new i : Player)
	{
		if(IsAfk{i}) {
			format(str, sizeof(str), "[ID:%d] %s %d วินาที", i, ReturnRealName(i), AFKCount[i]);
			SendClientMessage(playerid, COLOR_LIGHTRED, str);
			success = true;
		}
	}
	if(!success) SendClientMessage(playerid, COLOR_LIGHTRED, "ไม่พบข้อมูลผู้เล่นที่ AFK");
	return 1;

}


CMD:helpmes(playerid, params[])
{
   	if(!PlayerInfo[playerid][pTester] && !PlayerInfo[playerid][pAdmin])
		return SendUnauthMessage(playerid);

    new tool[21];

    if(sscanf(params, "s[21] ", tool))
	{
		SendUsageMessage(playerid, "/helpmes <tool>");
		SendClientMessage(playerid, COLOR_GREY, "Tools: List, Accept, Disregard");
	}
    else
    {
        if(strcmp(tool, "list", true) == 0 || strcmp(tool, "l", true) == 0)
        {
            new Helpmecout;
            SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");
            SendClientMessage(playerid, -1, "");
            for(new i = 1; i < sizeof(HelpmeData); i++)
            {
                if(HelpmeData[i][hHelpmeExit] == true)
                {
                    SendClientMessageEx(playerid, -1, "[ACTIVE] (%d) %s: รายงานเรื่อง: %s",HelpmeData[i][hHelpmeDBID], ReturnRealName(HelpmeData[i][hHelpmeBy]), HelpmeData[i][hHelpmeDetel]);
                    Helpmecout++;
                }
            }
            SendClientMessage(playerid, -1, "");
            SendClientMessageEx(playerid, -1, "ACTIVE HELPMES: %d (ใช้ /helpmes accept เพื่อยืนยัน)", Helpmecout);
            SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");
            return 1;
        }
        else if(strcmp(tool, "accept", true) == 0 || strcmp(tool, "a", true) == 0)
        {
            new helpmeid;

            if(sscanf(params, "s[21]d", tool, helpmeid))
		       return SendUsageMessage(playerid, "/helpmes accept <helpmeid>");

            if(HelpmeData[helpmeid][hHelpmeExit] == false)
                return SendErrorMessage(playerid, "helpmeid not fond.");
            
            SendClientMessageEx(playerid, -1, "คุณได้ยืนยัน report id %d",helpmeid);
            SendClientMessage(HelpmeData[helpmeid][hHelpmeBy], -1, "{DC7633}ขอบคุณที่ส่งรายงานมาให้เรา ได้มีผู้ดูแลรับเรื่องของคุณแล้ว! กรุณารอผู้ดูแลตอบกลับคุณมาอีกที");
            SendTesterMessageEx(COLOR_YELLOWEX, "[%s: %d] %s: ได้รับการขอความช่วยเหลือของ %s", PlayerInfo[playerid][pTester] == 0 ? ("Admin") : ("Tester"), PlayerInfo[playerid][pTester] == 0 ? PlayerInfo[playerid][pAdmin] : PlayerInfo[playerid][pTester], e_pAccountData[playerid][mAccName],ReturnRealName(HelpmeData[helpmeid][hHelpmeBy]));
            ClearHelpme(helpmeid);
            return 1;
        
        }
        else if(strcmp(tool, "Disregard", true) == 0 || strcmp(tool, "d", true) == 0)
        {
            new helpmeid;

            if(sscanf(params, "s[21]d", tool, helpmeid))
		       return SendUsageMessage(playerid, "/reports disregard <helpmeid>");

            if(HelpmeData[helpmeid][hHelpmeExit] == false)
                return SendErrorMessage(playerid, "helpmeid not fond.");

			SendTesterMessageEx(COLOR_YELLOW2, "[%s: %d] %s ได้ลบการขอความช่วยเหลือของ %s",PlayerInfo[playerid][pTester] == 0 ? ("Admin") : ("Tester"), PlayerInfo[playerid][pTester] == 0 ? PlayerInfo[playerid][pAdmin] : PlayerInfo[playerid][pTester], e_pAccountData[playerid][mAccName],ReturnRealName(HelpmeData[helpmeid][hHelpmeBy]));
            
            ClearHelpme(helpmeid);
            return 1;
        }
        else return SendErrorMessage(playerid, "กรุณาพิมพ์ให้ถูกต้อง");
    }


    return 1;
}


stock SendTesterMessage(level, const str[])
{
	new 
		newString[128]
	;
	
	format(newString, sizeof(newString), "TesterWarn(%i): %s", level, str);
	
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pTesterDuty] && PlayerInfo[playerid][pAdminDuty])
		{
			SendClientMessage(i, COLOR_YELLOWEX, newString);
		}
	}
	return 1;
}

stock SendTesterMessageEx(color, const str[], {Float,_}:...)
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
			if (PlayerInfo[i][pAdmin] || PlayerInfo[i][pTester]) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdmin] || PlayerInfo[i][pTester]) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
CMD:anim(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"____________อนิเมชั่นตัวละคร____________");
    SendClientMessage(playerid, COLOR_WHITE,"[นั่ง/นอน] /sit /chairsit /groundsit /seat /sleep /lean");
	SendClientMessage(playerid, COLOR_WHITE,"[สัญญาณมือ] /gsign /salute");
	SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /greet /taxiL /taxiR");
    SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /fuckyou /wave /kiss /no");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /bat /punch /taunt /facepalm /aim /slapass");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /hide /crawl /crack /think /sipdrink /sipdrink2");
    SendClientMessage(playerid, COLOR_WHITE,"[อารมณ์] /cry /injured /panic");
	SendClientMessage(playerid, COLOR_WHITE,"[ยานพาหนะ] /opendoor_right /opendoor_left");
	SendClientMessage(playerid, COLOR_WHITE,"[การเดิน] /sneak /jog");
    SendClientMessage(playerid, COLOR_GREEN,"_____________________________________________");
    GameTextForPlayer(playerid, "TO STOP ANIMATION TYPE ~r~/STOPANIM OR PRESS ~r~ENTER.", 3000, 4);

	new str[3500];
    strcat(str, "/fall | /fallback | /injured | /akick | /push | /lowbodypush | /handsup | /bomb | /drunk | /getarrested | /laugh | /sup\n");
    strcat(str, "/basket | /headbutt | /medic | /spray | /robman | /taichi | /lookout | /kiss | /cellin | /cellout | /crossarms | /lay\n");
	strcat(str, "/deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload\n");
    strcat(str, "/koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /fixcar | /fixcarout\n");
    strcat(str, "/lifejump | /exhaust | /leftslap | /carlock | /hoodfrisked | /lightcig | /tapcig | /box | /lay2 | /chant | /fuckyou| /fuckyou2\n");
    strcat(str, "/shouting | /knife | /cop | /elbow | /kneekick | /airkick | /gkick | /punch | /gpunch | /fstance | /lowthrow | /highthrow | /aim\n");
    strcat(str, "/pee | /lean | /poli | /surrender | /sit | /breathless | /seat | /rap | /cross | /jiggy | /gsign\n");
    strcat(str, "/sleep | /smoke | /pee | /chora | /relax | /crabs | /stop | /wash | /mourn | /fuck | /tosteal | /crawl\n");
    strcat(str, "/followme | /greet | /still | /hitch | /palmbitch | /cpranim | /giftgiving | /slap2 | /pump | /cheer\n");
    strcat(str, "/dj | /foodeat | /wave | /slapass | /dealer | /dealstance | /inbedright | /inbedleft\n");
	strcat(str, "/wank | /bj | /getup | /follow | /stand | /slapped | /yes | /celebrate | /win | /checkout\n");
	strcat(str, "/thankyou | /invite1 | /scratch | /nod | /cry | /carsmoke | /benddown | /facepalm | /angry\n");
	strcat(str, "/cockgun | /bar | /liftup | /putdown | /camera | /think | /handstand | /panicjump\n");
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "ท่าทางอื่น ๆ", str, "โอ", "เค");
    return 1;
}
CMD:animlist(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /fall | /fallback | /injured | /akick | /push | /lowbodypush | /handsup | /bomb | /drunk | /getarrested | /laugh | /sup"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /basket | /headbutt | /medic | /spray | /robman | /taichi | /lookout | /kiss | /cellin | /cellout | /crossarms | /lay"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /efixcar | /efixcarout"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /lifejump | /exhaust | /leftslap | /carlock | /hoodfrisked | /lightcig | /tapcig | /box | /lay2 | /chant | /fuckyou| /fuckyou2"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /shouting | /knife | /cop | /elbow | /kneekick | /airkick | /gkick | /punch | /gpunch | /fstance | /lowthrow | /highthrow | /aim"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /pee | /lean | /run | /poli | /surrender | /sit | /breathless | /seat | /rap | /cross | /jiggy | /gsign"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /sleep | /smoke | /pee | /chora | /relax | /crabs | /stop | /wash | /mourn | /fuck | /tosteal | /crawl"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /followme | /greet | /still | /hitch | /palmbitch | /cpranim | /giftgiving | /slap2 | /pump | /cheer"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /dj | /foodeat | /wave | /slapass | /handstand | /camera | /think | /putdown");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /wank | /bj | /getup | /follow | /stand | /slapped | /yes | /celebrate | /win | /checkout");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /cockgun | /bar | /liftup | /thankyou | /cry | /carsmoke | /facepalm | /angry");

    return 1;
}

CMD:bar(playerid, params[])
{
	new choice;
	if(sscanf(params, "d", choice))
	{
		SendSyntaxMessage(playerid, "/bar [1-12]");
		return 1;
	}
	
	PlayerInfo[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "BAR","Barcustom_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "BAR","Barcustom_order", 4.1, 0, 1, 1, 0, 0, 1);
		case 4: ApplyAnimation(playerid, "BAR","BARman_idle", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid, "BAR","Barserve_bottle", 4.1, 0, 1, 1, 0, 0, 1);
		case 6: ApplyAnimation(playerid, "BAR","Barserve_give", 4.1, 0, 1, 1, 0, 0, 1);
		case 7: ApplyAnimation(playerid, "BAR","Barserve_glass", 4.1, 0, 1, 1, 0, 0, 1);
		case 8: ApplyAnimation(playerid, "BAR","Barserve_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid, "BAR","Barserve_loop", 4.1, 1, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid, "BAR","Barserve_order", 4.1, 0, 1, 1, 0, 0, 1);
		case 11: ApplyAnimation(playerid, "BAR","dnk_stndF_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: ApplyAnimation(playerid, "BAR","dnk_stndM_loop", 4.1, 0, 1, 1, 1, 1, 1);
	}
	return 1;
}

CMD:fall(playerid, params[])
{
    ApplyAnimation(playerid,"PED","KO_skid_front",4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:fallback(playerid, params[])
{
    ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:injured(playerid, params[])
{
    ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:akick(playerid, params[])
{
    ApplyAnimation(playerid,"POLICE","Door_Kick",4.1, 0, 1, 1, 0, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:push(playerid, params[])
{
    ApplyAnimation(playerid,"GANGS","shake_cara",4.1, 0, 1, 1, 0, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:lowbodypush(playerid, params[])
{
    ApplyAnimation(playerid,"GANGS","shake_carSH",4.1, 0, 1, 1, 0, 0, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:bomb(playerid, params[])
{
    ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:drunk(playerid, params[])
{
    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1, 1, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:getarrested(playerid, params[])
{
    ApplyAnimation(playerid,"ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:laugh(playerid, params[])
{
    ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}

CMD:salute(playerid, params[])
{
    ApplyAnimation(playerid, "GHANDS", "GSIGN5LH", 4.1, false, false, false, false, 0, false);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:sup(playerid, params[])
{
    new number;
	if(sscanf(params, "i", number)) return SendUsageMessage(playerid, "/sup [1-3]");
	PlayerInfo[playerid][pAnimation] = 1;
	if(number < 1 || number > 3) { SendUsageMessage(playerid, "/sup [1-3]"); }
	if(number == 1) { ApplyAnimation(playerid,"GANGS","hndshkba",4.1, 0, 1, 1, 1, 1, 1); }
	if(number == 2) { ApplyAnimation(playerid,"GANGS","hndshkda",4.1, 0, 1, 1, 1, 1, 1); }
    if(number == 3) { ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.1, 0, 1, 1, 1, 1, 1); }
   	return 1;
}
CMD:basket(playerid, params[])
{
    new ddr;
	if (sscanf(params, "i", ddr)) return SendUsageMessage(playerid, "/basket [1-6]");
    if(ddr < 1 || ddr > 6) return SendUsageMessage(playerid, "/basket [1-6]");
	PlayerInfo[playerid][pAnimation] = 1; 
	switch(ddr)
	{
		case 1: { ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1, 0, 1, 1, 1, 1, 1); }
		case 2: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.1, 0, 1, 1, 1, 1, 1); }
		case 3: { ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.1, 0, 1, 1, 1, 1, 1); }
		case 4: { ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1, 0, 1, 1, 1, 1, 1); }
		case 5: { ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.1, 1, 1, 1, 1, 1, 1); }
		case 6: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1, 0, 1, 1, 0, 1, 1); }
	}
   	return 1;
}
CMD:headbutt(playerid, params[])
{
    ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.1, 0, 1, 1, 0, 0, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:medic(playerid, params[])
{
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 0, 0, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:spray(playerid, params[])
{
    ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:robman(playerid, params[]) 
{
    ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:taichi(playerid, params[])
{
    ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.1, 1, 1, 1, 1, 1, 1); 
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:lookout(playerid, params[])
{
    ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 0, 0, 1); 
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:kiss(playerid, params[])
{
    ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.1, 0, 1, 1, 0, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
/*CMD:cellin(playerid, params[])
{
    
    return 1;
}
CMD:cellout(playerid, params[])

{    
    return 1;
}*/
CMD:crossarms(playerid, params[])
{
    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:lay(playerid, params[])
{
    ApplyAnimation(playerid,"BEACH", "bather",4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
///deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload");
CMD:deal(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/deal [1-2]");
		return 1;
	}

	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
		//playerid[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"DEALER","DRUGS_BUY", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
		//playerid[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:crack(playerid, params[])
{
    new choice;
	if(sscanf(params, "d", choice))
	{
		SendUsageMessage(playerid, "/crack [1-3]");
		return 1;
	}
	//playerData[playerid][pAnimation] = 1;
	PlayerInfo[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "CRACK","crckidle3", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "CRACK","crckidle4", 4.1, 0, 1, 1, 1, 1, 1);
	}
    return 1;
}
CMD:groundsit(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:chat(playerid, params[])
{
    new num;
	if(sscanf(params, "i", num)) return SendUsageMessage(playerid, "/chat [1-2]");
	if(num > 2 || num < 1) { SendUsageMessage(playerid, "/chat [1-2]"); }
	//playerData[playerid][pAnimation] = 1;
	PlayerInfo[playerid][pAnimation] = 1;
	if(num == 1) { ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1, 1, 1, 1, 1, 1, 1); }
	else { ApplyAnimation(playerid,"MISC","Idle_Chat_02",4.1, 1, 1, 1, 1, 1, 1); }
    return 1;
}
CMD:dance(playerid, params[])
{
    new dancestyle;
    if(sscanf(params, "d", dancestyle)) return SendUsageMessage(playerid,"/dance [1-3]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(dancestyle){
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
	}
    return 1;
}
CMD:fucku(playerid, params[])
{
    ApplyAnimation(playerid,"PED","fucku",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:strip(playerid, params[])
{
    new kj;
    if(sscanf(params, "i", kj)) return SendUsageMessage(playerid, "/strip [1-7]");
	if(kj < 1 || kj > 7) { SendUsageMessage(playerid, "/strip [1-7]"); }
	PlayerInfo[playerid][pAnimation] = 1;
	if(kj == 1) { ApplyAnimation(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1, 1 ); }
	if(kj == 2) { ApplyAnimation(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 3) { ApplyAnimation(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 4) { ApplyAnimation(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 5) { ApplyAnimation(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 6) { ApplyAnimation(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1, 1 ); }
    if(kj == 7) { ApplyAnimation(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1, 1 ); }
    return 1;
}
CMD:hide(playerid, params[])
{
    ApplyAnimation(playerid, "ped", "cower",4.1, 0, 1, 1, 1, 1, 1);
	PlayerInfo[playerid][pAnimation] = 1;
    return 1;
}
CMD:vomit(playerid, params[])
{
    ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:chairsit(playerid, params[])
{
    ApplyAnimation(playerid,"PED","SEAT_idle",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:reload(playerid, params[])
{
    new result[128];
	if(sscanf(params, "s[24]", result)) return SendUsageMessage(playerid, "/reload [deagle/smg/ak/m4]");
    if(strcmp(result,"deagle", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"COLT45","colt45_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
    else if(strcmp(result,"smg", true) == 0)
    {
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
	else if(strcmp(result,"ak", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
	else if(strcmp(result,"m4", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"UZI","UZI_reload",4.1, 0, 1, 1, 1, 1, 1);
    }
   	else { SendUsageMessage(playerid, "/reload [deagle/smg/ak/m4]"); }
    return 1;
}
///koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /fixcar | /fixcarout
CMD:koface(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","KO_shot_face",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:kostomach(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","KO_shot_stom",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:rollfall(playerid, params[])
{
    ApplyAnimation(playerid,"PED","BIKE_fallR",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:bat(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"BASEBALL","Bat_IDLE",4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}
CMD:die(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/die [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:joint(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:bed(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/bed [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_In_L",4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "3", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_L", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "4", true) == 0)
	{
		ApplyAnimation(playerid,"INT_HOUSE","BED_Loop_R", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:lranim(playerid, params[])
{
    SendUsageMessage(playerid, "ขออภัย ANIM นี้อยู่ในขั้นตอนการดําเนินการ ยังไม่สามารถใข้งานได้"); 
    return 1;
}
CMD:efixcar(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 0, 0, 0, 1, 0, 0);
    return 1;
}
CMD:efixcarout(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_OUT", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}
///lifejump | /exhaust | /leftslap | /carlock | /hoodfrisked | /lightcig | /tapcig | /box | /lay2 | /chant | /fuckyou| /fuckyou2
CMD:lifejump(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","EV_dive",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:exhaust(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","IDLE_tired",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:leftslap(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","BIKE_elbowL",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:carlock(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","CAR_doorlocked_LHS",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:hoodfrisked(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"POLICE","crm_drgbst_01",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:lightcig(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:tapcig(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SMOKING","M_smk_tap",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:box(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"GYMNASIUM","GYMshadowbox",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:lay2(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_in",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:chant(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:fuckyou(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"RIOT","RIOT_FUKU",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:fuckyou2(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "RIOT", "RIOT_FUKU", 4.0, 0, 0, 0, 0, 0, 0);
    return 1;
}
///shouting | /knife | /cop | /elbow | /kneekick | /airkick | /gkick | /punch | /gpunch | /fstance | /lowthrow | /highthrow | /aim
CMD:shouting(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"RIOT","RIOT_shout",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:knife(playerid, params[])
{
    new nbr;
	if(sscanf(params, "i", nbr)) return SendUsageMessage(playerid, "/knife [1-4]");
    if(nbr < 1 || nbr > 4) return SendUsageMessage(playerid, "/knife [1-4]"); 
	PlayerInfo[playerid][pAnimation] = 1;
	switch(nbr)
	{ 
		case 1: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Damage",4.1, 0, 1, 1, 1, 1, 1); }
		case 2: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.1, 0, 1, 1, 1, 1, 1); }
		case 3: { ApplyAnimation(playerid,"KNIFE","KILL_Knife_Player",4.1, 0, 1, 1, 1, 1, 1); }
		case 4: { ApplyAnimation(playerid,"KNIFE","KILL_Partial",4.1, 0, 1, 1, 1, 1, 1); }
	}
    return 1;
}
CMD:cop(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SWORD","sword_block",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:elbow(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_3",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:kneekick(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_2",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:airkick(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_C","FightC_M",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:gkick(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_G",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:punch(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "RIOT", "RIOT_PUNCHES", 4.1, 0, 1, 1, 0, 0, 0);
    return 1;
}
CMD:gpunch(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_B","FightB_G",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:fstance(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_IDLE",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:lowthrow(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:highthrow(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"GRENADE","WEAPON_throw",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:aim(playerid, params[])
{
    new lmb;
	if(sscanf(params, "i", lmb)) return SendUsageMessage(playerid, "/aim [1-3]");
	PlayerInfo[playerid][pAnimation] = 1;
	if(lmb == 1) { ApplyAnimation(playerid,"PED","gang_gunstand",4.1, 0, 1, 1, 1, 1, 1); }
    if(lmb == 2) { ApplyAnimation(playerid,"PED","Driveby_L",4.1, 0, 1, 1, 1, 1, 1); }
    if(lmb == 3) { ApplyAnimation(playerid,"PED","Driveby_R",4.1, 0, 1, 1, 1, 1, 1); }
    else { SendUsageMessage(playerid, "/aim [1-3]"); }
    return 1;
}
////pee | /lean | /run | /poli | /surrender | /sit | /breathless | /seat | /rap | /cross | /jiggy | /gsign
CMD:pee(playerid, params[])
{
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}
CMD:lean(playerid, params[])
{
    new mj;
	if(sscanf(params, "i", mj)) return SendUsageMessage(playerid, "/lean [1-2]");
	if(mj < 1 || mj > 2) { SendUsageMessage(playerid, "/lean [1-2]"); }
    PlayerInfo[playerid][pAnimation] = 1;
	if(mj == 1) { ApplyAnimation(playerid,"GANGS","leanIDLE",4.1, 0, 1, 1, 1, 1, 1); }
	if(mj == 2) { ApplyAnimation(playerid,"MISC","Plyrlean_loop",4.1, 0, 1, 1, 1, 1, 1); }
    return 1;
}
CMD:poli(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/poli [1-2]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1:ApplyAnimation(playerid,"POLICE","CopTraf_Come",4.1, 0, 1, 1, 1, 1, 1);
		case 2:ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendUsageMessage(playerid,"/poli [1-2]");
		}
	}
    return 1;
}
CMD:surrender(playerid, params[])
{
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
}
CMD:sit(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid, "/sit [1-5]");

	PlayerInfo[playerid][pAnimation] = 1;

    switch(anim){
		case 1: ApplyAnimation(playerid,"BEACH","bather",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendUsageMessage(playerid, "/sit [1-5]");
		}
	}
    return 1;
}
CMD:breathless(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/breathless [1-2]");
	PlayerInfo[playerid][pAnimation] = 1;
    switch(anim){
		case 1: ApplyAnimation(playerid,"PED","IDLE_tired",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"FAT","IDLE_tired",4.1, 1, 1, 1, 1, 1, 1);
        default: {
			return SendUsageMessage(playerid,"/breathless [1-2]");
		}
	}
    return 1;
}
CMD:seat(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/seat [1-7]");
	if(anim < 1 || anim > 7) return SendUsageMessage(playerid,"/seat [1-7]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1, 0, 0, 0, 1, 0, 0);
		case 2: ApplyAnimation(playerid,"CRIB","PED_Console_Loop",4.1, 0, 0, 0, 1, 0, 0);
		case 3: ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1, 0, 0, 0, 1, 0, 0);
		case 4: ApplyAnimation(playerid,"MISC","SEAT_LR",4.1, 0, 0, 0, 1, 0, 0);
		case 5: ApplyAnimation(playerid,"MISC","Seat_talk_01",4.1, 0, 0, 0, 1, 0, 0);
		case 6: ApplyAnimation(playerid,"MISC","Seat_talk_02",4.1, 0, 0, 0, 1, 0, 0);
		case 7: ApplyAnimation(playerid,"ped","SEAT_down",4.1, 0, 0, 0, 1, 0, 0);
	}
    return 1;
}
CMD:rap(playerid, params[])
{
    new rapstyle;
    if(sscanf(params, "d", rapstyle)) return SendUsageMessage(playerid,"/rap [1-3]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(rapstyle){
		case 1: ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.1, 1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.1, 1, 1, 1, 1, 1, 1);
		default: return SendUsageMessage(playerid,"/rap [1-3]");
	}
    return 1;
}
CMD:cross(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/cross [1-5]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"GRAVEYARD","prst_loopa",4.1, 0, 1, 1, 1, 1, 1);
		default: return SendUsageMessage(playerid,"/cross [1-5]");
	}
    return 1;
}
CMD:jiggy(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/jiggy [1-10]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"DANCING","DAN_Down_A",4.1, 1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"DANCING","DAN_Left_A",4.1, 1, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"DANCING","DAN_Loop_A",4.1, 1, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"DANCING","DAN_Right_A",4.1, 1, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1, 1, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"DANCING","dnce_M_a",4.1, 1, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"DANCING","dnce_M_b",4.1, 1, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1, 1, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1, 1, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid,"DANCING","dnce_M_d",4.1, 1, 1, 1, 1, 1, 1);
		default: return SendUsageMessage(playerid,"/jiggy [1-10]");
	}
    return 1;
}
CMD:gsign(playerid, params[])
{
    new gesture;
    if(sscanf(params, "d", gesture)) return SendUsageMessage(playerid,"/gsign [1-15]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(gesture){
		case 1: ApplyAnimation(playerid,"GHANDS","gsign1",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"GHANDS","gsign2",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1, 0, 1, 1, 1, 1, 1);
		case 5: ApplyAnimation(playerid,"GHANDS","gsign3",4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,"GHANDS","gsign3LH",4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,"GHANDS","gsign4",4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,"GHANDS","gsign4LH",4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid,"GHANDS","gsign5",4.1, 0, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid,"GHANDS","gsign5",4.1, 0, 1, 1, 1, 1, 1);
		case 11: ApplyAnimation(playerid,"GHANDS","gsign5LH",4.1, 0, 1, 1, 1, 1, 1);
		case 12: ApplyAnimation(playerid,"GANGS","Invite_No",4.1, 0, 1, 1, 1, 1, 1);
		case 13: ApplyAnimation(playerid,"GANGS","Invite_Yes",4.1, 0, 1, 1, 1, 1, 1);
		case 14: ApplyAnimation(playerid,"GANGS","prtial_gngtlkD",4.1, 0, 1, 1, 1, 1, 1);
		case 15: ApplyAnimation(playerid,"GANGS","smkcig_prtl",4.1, 0, 1, 1, 1, 1, 1);
		default: return SendUsageMessage(playerid,"/gsign [1-15]");
	}
    return 1;
}

///sleep | /smoke | /pee | /chora | /relax | /crabs | /stop | /wash | /mourn | /fuck | /tosteal | /crawl


CMD:handsup(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
  		return 1;
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "ไม่สามารถเล่น Animation ได้ในขณะนี้");
}


CMD:sleep(playerid, params[])
{
    new anim;
	
	if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/sleep [1-2]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"CRACK","crckdeth4",4.1, 0, 1, 1, 1, 1, 1); 
		case 2: ApplyAnimation(playerid,"CRACK","crckidle2",4.1, 0, 1, 1, 1, 1, 1); 
		default: {
			return SendUsageMessage(playerid,"/sleep [1-2]");
		}
	}
    return 1;
}
CMD:chora(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:relax(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:crabs(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"MISC","Scratchballs_01",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:stop(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","endchat_01",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:wash(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"BD_FIRE","wash_up",4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}
CMD:mourn(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:fuck(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","fucku",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:tosteal(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:crawl(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "PED", "CAR_CRAWLOUTRHS", 4.1, 0, 0, 0, 0, 0, 0);
    return 1;
}

///followme | /greet | /still | /hitch | /palmbitch | /cpranim | /giftgiving | /slap2 | /pump | /cheer

CMD:followme(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:still(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:hitch(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"MISC","Hiker_Pose", 4.1, 0, 1, 1, 1, 1, 1); 
    return 1;
}
CMD:palmbitch(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"MISC","bitchslap",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:cpranim(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:giftgiving(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"KISSING","gift_give",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:slap2(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SWEET","sweet_ass_slap",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:pump(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}
CMD:cheer(playerid, params[])
{
    new anim;

	if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/cheer [1-8]");
	PlayerInfo[playerid][pAnimation] = 1;
	switch(anim){
		case 1: ApplyAnimation(playerid,"ON_LOOKERS","shout_01",4.1, 0, 1, 1, 1, 1, 1); 
		case 2: ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1, 0, 1, 1, 1, 1, 1); 
		case 3: ApplyAnimation(playerid,"ON_LOOKERS","shout_in",4.1, 0, 1, 1, 1, 1, 1); 
		case 4: ApplyAnimation(playerid,"RIOT","RIOT_ANGRY_B",4.1, 0, 1, 1, 1, 1, 1); 
		case 5: ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.1, 0, 1, 1, 1, 1, 1); 
		case 6: ApplyAnimation(playerid,"RIOT","RIOT_shout",4.1, 0, 1, 1, 1, 1, 1); 
		case 7: ApplyAnimation(playerid,"STRIP","PUN_HOLLER",4.1, 0, 1, 1, 1, 1, 1); 
		case 8: ApplyAnimation(playerid,"OTB","wtchrace_win",4.1, 0, 1, 1, 1, 1, 1); 
		default: {
			return SendUsageMessage(playerid,"/cheer [1-8]");
		}
	}
    return 1;
}

//dj | /foodeat | /wave | /slapass | /handstand | /camera | /think | /putdown
CMD:dj(playerid, params[])
{
    new anim;
    if(sscanf(params, "d", anim)) return SendUsageMessage(playerid,"/dj [1-4]");
	PlayerInfo[playerid][pAnimation] = 1;
    switch(anim){
		case 1: ApplyAnimation(playerid,"SCRATCHING","scdldlp",4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,"SCRATCHING","scdlulp",4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,"SCRATCHING","scdrdlp",4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,"SCRATCHING","scdrulp",4.1, 0, 1, 1, 1, 1, 1);
		default: {
			return SendUsageMessage(playerid,"/dj [1-4]");
		}
	}
    return 1;
}
CMD:foodeat(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:wave(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}
CMD:slapass(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:handstand(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"DAM_JUMP","DAM_Dive_Loop",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:camera(playerid, params[])
{
    new choice;
	if(sscanf(params, "d", choice))
	{
		SendUsageMessage(playerid, "/camera [1-10]");
		return 1;
	}
	PlayerInfo[playerid][pAnimation] = 1;
	switch(choice) {
		case 1: ApplyAnimation(playerid,  "CAMERA","camcrch_cmon", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid,  "CAMERA","camcrch_to_camstnd", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: ApplyAnimation(playerid,  "CAMERA","camstnd_cmon", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: ApplyAnimation(playerid,  "CAMERA","camstnd_idleloop", 4.1, 1, 0, 0, 1, 1, 1);
		case 5: ApplyAnimation(playerid,  "CAMERA","camstnd_lkabt", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: ApplyAnimation(playerid,  "CAMERA","piccrch_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: ApplyAnimation(playerid,  "CAMERA","piccrch_take", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: ApplyAnimation(playerid,  "CAMERA","picstnd_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: ApplyAnimation(playerid, "CAMERA","picstnd_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: ApplyAnimation(playerid, "CAMERA","picstnd_take", 4.1, 0, 1, 1, 1, 1, 1);
	}
    return 1;
}
CMD:think(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:putdown(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

//wank | /bj | /getup | /follow | /stand | /slapped | /yes | /celebrate | /win | /checkout
CMD:wank(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/wank [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"PAULNMAC","wank_in",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "2", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.1, 1, 1, 1, 1, 1, 1);
	}
    return 1;
}
CMD:bj(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/bj [1-4]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "2", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "3", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1, 0, 1, 1, 1, 1, 1);
	}
	if(strcmp(choice, "4", true) == 0)
	{
		PlayerInfo[playerid][pAnimation] = 1;
		ApplyAnimation(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1, 1, 0, 0, 1, 1, 1);

	}
    return 1;
}
CMD:getup(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","getup",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}
CMD:follow(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"WUZI","Wuzi_follow",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:slapped(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"SWEET","ho_ass_slapped",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:yes(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"CLOTHES","CLO_Buy", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:celebrate(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/celebrate [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"benchpress","gym_bp_celebrate", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"GYMNASIUM","gym_tread_celebrate", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:win(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/win [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"CASINO","cards_win", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"CASINO","Roulette_win", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:checkout(playerid, params[])
{
    ApplyAnimation(playerid, "GRAFFITI", "graffiti_Chkout", 4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}


//cockgun | /bar | /liftup | /thankyou | /cry | /carsmoke | /facepalm | /angry
CMD:cockgun(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:liftup(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:thankyou(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"FOOD","SHP_Thank", 4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:cry(playerid, params[])
{
    new choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendUsageMessage(playerid, "/cry [1-2]");
		return 1;
	}
	if(strcmp(choice, "1", true) == 0)
	{
		ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
	if(strcmp(choice, "2", true) == 0)
	{
		ApplyAnimation(playerid,"GRAVEYARD","mrnM_loop", 4.1, 0, 1, 1, 1, 1, 1);
		PlayerInfo[playerid][pAnimation] = 1;
	}
    return 1;
}
CMD:carsmoke(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"PED","Smoke_in_car", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:facepalm(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid, "MISC", "plyr_shkhead", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:angry(playerid, params[])
{
	PlayerInfo[playerid][pAnimation] = 1;
    ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(RELEASED(88))
	{
		callcmd::stopanimation(playerid, "");
		return 1;
	}
	return 1;
}
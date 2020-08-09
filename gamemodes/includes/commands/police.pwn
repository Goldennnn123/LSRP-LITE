CMD:cuff(playerid, params[])
{
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");


    new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/cuff [ชื่อบางส่วน/ไอดี]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
    
    if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    
    if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");
		
	if(PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "ผู้เล่นคนนี้ถูกล็อคด้วยกุญแจมืออยู่แล้ว");

    /*if(GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_HANDSUP && GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_DUCK)
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ในถ้าทางขัดขืน");*/
	
	SetPlayerAttachedObject(playerb, 0, 19418,6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
	SetPlayerSpecialAction(playerb, SPECIAL_ACTION_CUFFED);

    PlayerInfo[playerb][pHandcuffed] = true;

    new str[200];
    format(str, sizeof(str), "ได้รวบแขนของ %s และหยิบกุญแจมือออกมาสวมไปที่แขนของเขา", ReturnRealName(playerb, 0));
    callcmd::me(playerid, str);
    return 1;
}

CMD:uncuff(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uncuff [ชื่อบางส่วน/ไอดี]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");
		
	if(!PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ถูกใส่กุญแจมือ");

	RemovePlayerAttachedObject(playerb, 0); 
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE); 
	
	PlayerInfo[playerb][pHandcuffed] = false;
	new str[200];
    format(str, sizeof(str), "ได้ปลดกุญแจมือของ %s", ReturnRealName(playerb, 0));
    callcmd::me(playerid, str);
	return 1;
}

CMD:tazer(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(GetPlayerWeapon(playerid) != 24)
		return SendErrorMessage(playerid, "คุณไม่มีปืนช็อตไฟฟ้า");

	if(!PlayerInfo[playerid][pTaser])
	{
		
		PlayerInfo[playerid][pTaser] = true;
		GivePlayerGun(playerid, 23, 100); 
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบปืนช็อตไฟฟ้าออกมาจากซองหนัง", ReturnName(playerid, 0)); 
	}
	else
	{
		GivePlayerGun(playerid, 24,160); 
		PlayerInfo[playerid][pTaser] = false;
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s เก็บปืนช็อตไฟฟ้าเข้าซองหนัง", ReturnName(playerid, 0)); 
	}
	
	return 1;
}

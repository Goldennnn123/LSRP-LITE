new arrest_icon;

hook OnGameModeInit()
{
	arrest_icon = CreateDynamicPickup(1239, 2, 226.9767,114.8129,999.0156, -1,-1);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pArrest] = false;
	PlayerInfo[playerid][pArrestBy] = 0;
	PlayerInfo[playerid][pArrestTime] = 0;
	return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(pickupid == arrest_icon)
	{
		SendUsageMessage(playerid, "/arrest <ชื่อบางส่วน/ไอดี> <ข้อหา> <เวลา: นาที> <ห้องขัง 1-4>");
		return 1;
	}
	return 1;
}


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
	SetPlayerSpecialAction(playerb, SPECIAL_ACTION_NONE);
	
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

	if(!PlayerInfo[playerid][pTaser])
	{

		if(GetPlayerWeapon(playerid) != 24)
			return SendErrorMessage(playerid, "คุณไม่มีปืนช็อตไฟฟ้า");
		
		PlayerInfo[playerid][pTaser] = true;
		GivePlayerGun(playerid, 23, 100); 
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s หยิบปืนช็อตไฟฟ้าออกมาจากซองหนัง", ReturnName(playerid, 0)); 
	}
	else
	{
		if(GetPlayerWeapon(playerid) != 23)
			return SendErrorMessage(playerid, "คุณไม่มีปืนช็อตไฟฟ้า");

		GivePlayerGun(playerid, 24,160); 
		PlayerInfo[playerid][pTaser] = false;
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s เก็บปืนช็อตไฟฟ้าเข้าซองหนัง", ReturnName(playerid, 0)); 
	}
	
	return 1;
}

CMD:take(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new playerb, type;

	if(sscanf(params,"dd",playerb,type))
	{
		SendUsageMessage(playerid,"/take [ไอดี/ชื่อบางส่วน] [ประเภท]");
		SendClientMessage(playerid, -1, "1.Driverlicense 2.WeaponLicense");
		return 1;
	}

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อเข้าเซืฟเวอร์");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	if(type == 1)
	{
		if(PlayerInfo[playerb][pDriverLicense] == false)
			return SendErrorMessage(playerid, "ผู้เล่นไม่มี ใบขับขี่รถยนต์");

		if(PlayerInfo[playerb][pDriverLicenseRevoke] == true)
		{
			PlayerInfo[playerb][pDriverLicenseRevoke] = false;

			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ได้คืนใบขับขี่ของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pDriverLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ได้ยึดใบขับขี่ของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
		}
		return 1;
	}
	else if(type == 2)
	{
		if(PlayerInfo[playerb][pWeaponLicense] == false)
			return SendErrorMessage(playerid, "ผู้เล่นไม่มี ใบพกอาวุธ");

		if(PlayerInfo[playerb][pWeaponLicenseRevoke] == true)
		{
			PlayerInfo[playerb][pWeaponLicenseRevoke] = false;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ได้คืนใบพกอาวุธ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));	
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pWeaponLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ได้ยึดใบพกอาวุธของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
		}
	}
	return 1;
}

CMD:givelicense(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new playerb;

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	if(sscanf(params,"d",playerb))
		return SendUsageMessage(playerid,"/givelicense [ไอดี/ชื่อบางส่วน]");

	if(PlayerInfo[playerb][pWeaponLicense] == true)
		return SendErrorMessage(playerid,"ผู้เล่นมีใบพกอาวุธอยู่แล้ว");

	PlayerInfo[playerb][pWeaponLicense] = true;
	SendPoliceMessage(0x8D8DFFFF, "HQ: %s %s มอบใบพกอาวุธ ให้กับ %s", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb, 0));
	return 1;
}

CMD:impound(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new vehicleid = GetPlayerVehicleID(playerid), trailerid = GetVehicleTrailer(vehicleid);

	if(!vehicleid)
		return SendErrorMessage(playerid, "คุณต้องอยู่บนรถ");

	if(GetVehicleModel(vehicleid) != 525)
		return SendErrorMessage(playerid, "คุณต้องนั่งอยู่บนรถ Towtruck");


	if(!IsTrailerAttachedToVehicle(vehicleid))
		return SendErrorMessage(playerid, "คุณไม่ได้ลากยานพาหนะ");
	
	if(!VehicleInfo[trailerid][eVehicleDBID] || VehicleInfo[trailerid][eVehicleAdminSpawn] || IsRentalVehicle(trailerid) || VehicleInfo[trailerid][eVehicleFaction])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้สามารถใช้ได้เฉพาะยานพาหนะส่วนตัว แต่คุณอยู่ในยานพาหนะสาธารณะ (Static)");
	
	if(VehicleInfo[trailerid][eVehicleImpounded])
		return SendErrorMessage(playerid, "ยานพาหนะคันนี้ถูกยึดแล้ว");
	
	new Float:x, Float:y, Float:z, Float:a;
	GetVehiclePos(trailerid,x,y,z);

	new query[400];
	format(query, sizeof(query), "SELECT VehicleImpoundPosX, VehicleImpoundPosY, VehicleImpoundPosZ FROM `vehicles`");
	mysql_query(dbCon, query);

	new
		Float:vehDistance[4],
		bool:checked = false
	;

	new rows;
	cache_get_row_count(rows);

	for (new i = 0; i < rows; i ++)
	{
		cache_get_value_name_float(i, "VehicleImpoundPosX",vehDistance[0]);
		cache_get_value_name_float(i, "VehicleImpoundPosY",vehDistance[1]);
		cache_get_value_name_float(i, "VehicleImpoundPosZ",vehDistance[2]);

		if (IsPlayerInRangeOfPoint(playerid, 4.5, vehDistance[0], vehDistance[1], vehDistance[2])) {
			checked = true;
			break;
		}
	}

	if(!checked) {
		GetVehicleZAngle(trailerid, a);
		VehicleInfo[trailerid][eVehicleImpounded] = true;
		VehicleInfo[trailerid][eVehicleImpoundPos][0] = x;
		VehicleInfo[trailerid][eVehicleImpoundPos][1] = y;
		VehicleInfo[trailerid][eVehicleImpoundPos][2] = z;
		VehicleInfo[trailerid][eVehicleImpoundPos][3] = a;
		SetVehiclePos(trailerid, x, y, z);
		SetVehicleZAngle(trailerid, a);
		SaveVehicle(trailerid);
		DetachTrailerFromVehicle(trailerid);
		ToggleVehicleEngine(trailerid, true); VehicleInfo[trailerid][eVehicleEngineStatus] = true;
		SendClientMessageEx(playerid, -1, "คุณได้ยึดยานพาหนะ %s เรียบร้อยแล้ว",ReturnVehicleName(trailerid));
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "พื้นที่ตรงนี้ถูกใช้งานแล้ว");
	return 1;
}

CMD:unimpound(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!GetPlayerVehicleID(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพหานะ");


	if(!VehicleInfo[vehicleid][eVehicleDBID] || VehicleInfo[vehicleid][eVehicleAdminSpawn] || IsRentalVehicle(vehicleid) || VehicleInfo[vehicleid][eVehicleFaction])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้สามารถใช้ได้เฉพาะยานพาหนะส่วนตัว แต่คุณอยู่ในยานพาหนะสาธารณะ (Static)");

	if(!VehicleInfo[vehicleid][eVehicleImpounded])
		return SendErrorMessage(playerid, "ยานพนะคันนี้ไม่ได้ถูกยึด");

	if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "ยานพาหนะไม่ใช่ของคุณ");

	
	if(PlayerInfo[playerid][pCash] < 1500)
		return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการนำรถคืน ($1,500)");


	VehicleInfo[vehicleid][eVehicleImpounded] = false;
	VehicleInfo[vehicleid][eVehicleImpoundPos][0] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][1] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][2] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][3] = 0;
	SendClientMessageEx(playerid, -1, "คุณได้นำที่ล็อกล้ออกจากยานพนะ %s ของคุณเรียบร้อยแล้ว",ReturnVehicleName(vehicleid));
	SendPoliceMessage(0x8D8DFFFF, "HQ-TRAFFIC-DIVISION: %s ได้นำยานพนะ %s ออกจากการยึดเรียบร้อยแล้ว",ReturnName(playerid,0), ReturnVehicleName(vehicleid));
	SaveVehicle(vehicleid);
	GiveMoney(playerid, -1500);
	CharacterSave(playerid);
	return 1;
}


CMD:fine(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new tagetid,reason[255],price, idx;

	if(sscanf(params, "us[255]d", tagetid, reason, price)) 
		return SendUsageMessage(playerid, "/fine <ชื่อบางส่วน/ไอดี> <สาเหตุ> <ค่าปรับ>"); 

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	if(strlen(reason) < 20 || strlen(reason) > 150)
		return SendErrorMessage(playerid, "ใส่สาเหตุให้ถูกต้อง ห้ามน้อยกว่า 20 และห้ามเกิน 150");

	if(price < 1 || price > 10000)
		return SendErrorMessage(playerid, "โปรดใส่ค่าปรับให้ถูกต้อง ห้ามน้อยกว่า $1 และห้ามเกิน $10,000");

	for(new i = 1; i < MAX_FINES; i++)
	{
		if(FineInfo[i][FineDBID])
			continue;
		
		idx = i;
		break;
	}

	new query[255];
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `fine`(`FineOwner`, `FineReson`, `FinePrice`, `FineBy`, `FineDate`) VALUES ('%d','%e','%d','%d','%e')",
	PlayerInfo[tagetid][pDBID],
	reason,
	price,
	PlayerInfo[playerid][pDBID],
	ReturnDate());
	mysql_tquery(dbCon, query);
	
	FineInfo[idx][FineDBID] = idx;
	FineInfo[idx][FineOwner] = PlayerInfo[tagetid][pDBID];
	FineInfo[idx][FineReson] = reason;
	FineInfo[idx][FinePrice] = price;
	format(FineInfo[idx][FineDate], FineInfo[idx][FineDate], "%s", ReturnDate());
	return 1;
}

CMD:impounds(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");
	new query[255];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `vehicles` WHERE `VehicleImpounded` = '1'");
	mysql_tquery(dbCon, query, "CheckVehImpound", "d", playerid);
	return 1;
}

CMD:arrest(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(!IsPlayerInRangeOfPoint(playerid, 2.5, 226.9767,114.8129,999.0156))
		return SendErrorMessage(playerid, "คุณไม่ได้อยุ่จุดส่งคุกของผู้ต้องหา");

	new tagetid,reason[255],time, room;

	if(sscanf(params, "us[255]dd", tagetid, reason, time, room))
		return SendUsageMessage(playerid, "/arrest <ชื่อบางส่วน/ไอดี> <ข้อหา> <เวลา : นาที> <ห้องขัง 1-4>");

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	if(!IsPlayerInRangeOfPoint(tagetid, 2.5, 226.9767,114.8129,999.0156))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ในจุดส่งคุก");

	if(strlen(reason) < 5 || strlen(reason) > 250)
		return SendErrorMessage(playerid, "กรอกข้อหาให้ถูกต้อง ห้ามน้อยกว่า 5 และห้ามเกิน 250");

	if(time < 1 || time > 600)
		return SendErrorMessage(playerid, "กรอกเวลาให้ถูกต้อง ห้ามน้อยกว่า 1 และห้ามมากกว่า 600 นาที");

	if(room < 1 || room > 4)
		return SendErrorMessage(playerid, "กรอกห้องขังที่จะส่งให้ผู้ต้องกาให้ถูกต้อง 1-4");

	Arrest_Jail(playerid, tagetid, reason, time, room);

	new query[500];
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `arrestrecord` (`ArrestOwnerDBID`, `ArrestByDBID`, `ArrestReason`, `ArrestTime`, `ArrestDate`) VALUES('%d','%d','%e','%d','%e')",
	PlayerInfo[tagetid][pDBID],
	PlayerInfo[playerid][pDBID],
	reason,
	time,
	ReturnDate());
	mysql_tquery(dbCon, query);
	return 1;
}

CMD:checkarrest(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");
	new query[255];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `arrestrecord` ORDER BY ArrestDBID");
	mysql_tquery(dbCon, query, "CheckArrest", "d", playerid);
	return 1;
}





Dialog:DIALOG_FINES_LIST(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	new str[50], query[150];
    format(str, sizeof(str), "%d",listitem);

    new id = GetPVarInt(playerid, str);
	
	GiveMoney(playerid, -FineInfo[id][FinePrice]);

	mysql_format(dbCon, query, sizeof(query),"DELETE FROM `fine` WHERE `FineDBID` = '%d'",FineInfo[id][FineDBID]);
	mysql_tquery(dbCon, query);

	FineInfo[id][FineDBID] = 0;
	FineInfo[id][FineOwner] = 0;
	format(FineInfo[id][FineReson], FineInfo[id][FineReson], "Clear");
	FineInfo[id][FinePrice] = 0;
	FineInfo[id][FineBy] = 0;
	format(FineInfo[id][FineDate], FineInfo[id][FineDate], "XX/XX/XXXX");
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(Pressed(KEY_SUBMISSION)) {

	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 525) { // For impounding cars.

	        new
				playerTowTruck = GetPlayerVehicleID(playerid);

	        if(!IsTrailerAttachedToVehicle(playerTowTruck)) {
				new
					targetVehicle = GetClosestVehicle(playerid, playerTowTruck); // Exempt the player's own vehicle from the loop.

				if(IsPlayerInRangeOfVehicle(playerid, targetVehicle, 10.0)) {
					AttachTrailerToVehicle(targetVehicle, playerTowTruck);

				}
	        }
	        else DetachTrailerFromVehicle(playerTowTruck);
	    }
	}
	return 1;
}

forward CheckVehImpound(playerid);
public CheckVehImpound(playerid)
{
	if(!cache_num_rows())
		return SendClientMessage(playerid, -1, "ไม่มียานพาหนะที่ถูกยึดอยู่ตอนนี้");

	new rows,countImpound; cache_get_row_count(rows);

	new vehicleid, owner, plate[32];
	new str[4000], longstr[4000];

	format(str, sizeof(str), "ชื่อรถ\tป้ายทะเบียน\tเจ้าของรถ\n");
	strcat(longstr, str);

	for (new i = 0; i < rows && i < MAX_VEHICLES; i ++)
	{
		cache_get_value_name_int(0,"VehicleModel",vehicleid);
		cache_get_value_name_int(0,"VehicleOwnerDBID",owner);
		cache_get_value_name(0,"VehiclePlates",plate, 32);
		countImpound++;
		format(str, sizeof(str), "%s\t%s\t%s\n",ReturnVehicleModelName(vehicleid), plate, ReturnDBIDName(owner));
		strcat(longstr, str);
	}
	Dialog_Show(playerid, DIALOG_SHOW_IMPOUNDS, DIALOG_STYLE_TABLIST_HEADERS, "IMPOUNDS VEHICLE:", longstr, "ยืนยัน", "ยืนยัน");
	return 1;
}

forward CheckArrest(playerid);
public CheckArrest(playerid)
{
	if(!cache_num_rows())
		return SendClientMessage(playerid, -1, "ไม่มีใครที่ถูกขังเลย");

	new rows; cache_get_row_count(rows);

	new Name, reason[255], By, time, date[60];
	new str[4000], longstr[4000];

	format(str, sizeof(str), "ชื่อ\tข้อหา\tเวลา\tผู้กุมขัง\tวันที่\n");
	strcat(longstr, str);

	for (new i = 0; i < rows && i < MAX_PLAYERS; i ++)
	{
		cache_get_value_name_int(0,"ArrestOwnerDBID",Name);
		cache_get_value_name_int(0,"ArrestByDBID",By);
		cache_get_value_name(0,"ArrestReason",reason,255);
		cache_get_value_name_int(0,"ArrestTime",time);
		cache_get_value_name(0,"ArrestDate",date,60);

		format(str, sizeof(str), "%s\t%s\t%d นาที\t%s\t%s\n",ReturnDBIDName(Name), reason, time, ReturnDBIDName(By), date);
		strcat(longstr, str);
	}

	Dialog_Show(playerid, DIALOG_SHOW_ARREST_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Arrest Record", longstr, "ยืนยัน", "ออก");
	return 1;
}
forward Freeze2Sec(playerid);
public Freeze2Sec(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}



stock Arrest_Jail(playerid, tagetid, reason[], time, room)
{
	PlayerInfo[tagetid][pArrest] = true;
	PlayerInfo[tagetid][pArrestBy] = PlayerInfo[playerid][pDBID];
	PlayerInfo[tagetid][pArrestTime] = time*60;
	PlayerInfo[tagetid][pArrestRoom] = room;
	SendPoliceMessage(0x8D8DFFFF, "HQ-ARREST: %s ถูกกุมขัง อยู่ห้องขัง Room: %d ด้วยข้อหา: %s โดย %s %s", ReturnName(tagetid,0), room, reason, ReturnFactionRank(playerid), ReturnName(playerid,0));
	switch(room)
	{
		case 1:
		{
			SetPlayerPos(playerid, 227.1921,108.9945,999.0156);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
		}
		case 2:
		{
			SetPlayerPos(playerid, 223.4052,109.4984,999.0156);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
		}
		case 3:
		{
			SetPlayerPos(playerid,219.6822,110.2353,999.0156);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
		}
		case 4:
		{
			SetPlayerPos(playerid,215.4856,109.6158,999.0156);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
		}
	}
	CharacterSave(tagetid);
	return 1;
}


stock ArrestConecterJail(playerid, time, room)
{
	SendClientMessageEx(playerid, -1, "คุณถูกกุมขัง อยู่ห้องขัง Room: A%d เหลือเวลาอีก: %d", room, time);
	TogglePlayerControllable(playerid, 0);
	switch(room)
	{
		case 1:
		{
			SetPlayerPos(playerid, 227.1921,108.9945,999.0156+1);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);

		}
		case 2:
		{
			SetPlayerPos(playerid, 223.4052,109.4984,999.0156+1);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
		case 3:
		{
			SetPlayerPos(playerid,219.6822,110.2353,999.0156+1);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
		case 4:
		{
			SetPlayerPos(playerid,215.4856,109.6158,999.0156+1);
			SetPlayerVirtualWorld(playerid, 10001);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
	}
	return 1;
}
new arrest_icon, getcar_picon;


///215.239 -2194.590 13.554 314.820 0 0

//2147.152,-2192.154,13.730,314.507 จุดที่รถจะเ spawn ออกมา

hook OnGameModeInit()
{
	arrest_icon = CreateDynamicPickup(1239, 2, 226.9767,114.8129,999.0156, -1,-1);
	getcar_picon = CreateDynamicPickup(19134, 2, 2140.071,-2197.955,13.554, -1, -1);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pArrest] = false;
	PlayerInfo[playerid][pArrestBy] = 0;
	PlayerInfo[playerid][pArrestTime] = 0;
	
	SetPVarInt(playerid,"PlayerGetVehicle", 0);
	return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(pickupid == arrest_icon)
	{
		SendUsageMessage(playerid, "/arrest <ชื่อบางส่วน/ไอดี> <ข้อหา> <เวลา: นาที> <ห้องขัง 1-4>");
		return 1;
	}
	else if(pickupid == getcar_picon)
	{
		if(ReturnFactionJob(playerid) != 1)
			return 1;


		if(!IsPlayerInAnyVehicle(playerid))
		{
			ShowVehicleSpawnMenuFaction(playerid);
		}
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

    if(PlayerInfo[playerid][pDuty] == false)
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

    if(!PlayerInfo[playerid][pDuty])
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

CMD:taser(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(!PlayerInfo[playerid][pTaser])
	{

		if(GetPlayerWeapon(playerid) != 24)
			return SendErrorMessage(playerid, "คุณไม่มีปืนช็อตไฟฟ้า");
		
		PlayerInfo[playerid][pTaser] = true;
		GivePlayerWeaponEx(playerid, 23, 100); 
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s หยิบปืนช็อตไฟฟ้าออกมาจากซองหนัง", ReturnName(playerid, 0)); 
	}
	else
	{
		if(GetPlayerWeapon(playerid) != 23)
			return SendErrorMessage(playerid, "คุณไม่มีปืนช็อตไฟฟ้า");

		GivePlayerWeaponEx(playerid, 24, 160);
		PlayerInfo[playerid][pTaser] = false;
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s เก็บปืนช็อตไฟฟ้าเข้าซองหนัง", ReturnName(playerid, 0)); 
	}
	
	return 1;
}


alias:rubberbullets("rbt")
CMD:rubberbullets(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(GetPVarInt(playerid, "Rubberbullets"))
	{
		if(GetPlayerWeapon(playerid) != 25)
			return SendErrorMessage(playerid, "คุณไม่ได้ถือ Shotgun");
		
		GivePlayerGun(playerid, 25,100);
		DeletePVar(playerid, "Rubberbullets");

		SendNearbyMessage(playerid, 15.0, COLOR_EMOTE, "> %s เก็บเรมิงตันไว้ด้านหลังของเขา", ReturnName(playerid, 0)); 
		return 1;
	}
	else
	{
		if(GetPlayerWeapon(playerid) != 25)
			return SendErrorMessage(playerid, "คุณไม่ได้ถือ Shotgun");
		
		GivePlayerGun(playerid, 25,20);
		SetPVarInt(playerid, "Rubberbullets", 1);

		SendNearbyMessage(playerid, 15.0, COLOR_EMOTE, "> %s คว้าเรมิงตัน 870 พร้อมบรรจุกระสุนยาง", ReturnName(playerid, 0));
		SendServerMessage(playerid, "คุณเปลี่ยนเป็นกระสุนยางแล้ว");
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

			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"> %s ได้คืนใบขับขี่ของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pDriverLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"> %s ได้ยึดใบขับขี่ของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
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
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"> %s ได้คืนใบพกอาวุธ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));	
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pWeaponLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"> %s ได้ยึดใบพกอาวุธของ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
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

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new playerb;

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "ยศ/ต่ำแหน่งของคุณ ไม่ได้รับอนุญาติให้ใช้คำสั่งนี้");

	if(sscanf(params,"d",playerb))
		return SendUsageMessage(playerid,"/givelicense [ไอดี/ชื่อบางส่วน]");

	if(PlayerInfo[playerb][pWeaponLicense] == true)
		return SendErrorMessage(playerid,"ผู้เล่นมีใบพกอาวุธอยู่แล้ว");

	PlayerInfo[playerb][pWeaponLicense] = true;
	return 1;
}

CMD:impound(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
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
		VehicleInfo[trailerid][eVehicleCarPark] = true;
		VehicleInfo[trailerid][eVehicleParkPos][0] = x;
		VehicleInfo[trailerid][eVehicleParkPos][1] = y;
		VehicleInfo[trailerid][eVehicleParkPos][2] = z;
		VehicleInfo[trailerid][eVehicleParkPos][3] = a;
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

	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

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
	SendFactionMessageEx(playerid, 0x8D8DFFFF, "HQ-TRAFFIC-DIVISION: %s ได้นำยานพนะ %s ออกจากการยึดเรียบร้อยแล้ว",ReturnName(playerid,0), ReturnVehicleName(vehicleid));
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

    if(PlayerInfo[playerid][pDuty] == false)
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

	SendClientMessageEx(playerid, COLOR_PURPLE, "[ ! ] คุณถูกปรับโดย %s เนื่องจาก '%s' ดูได้ที่ /fines", ReturnName(playerid,0), reason);
	SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "> %s เขียนค่าปรับ %s ให้กับ %s เนื่องจาก '%s'", ReturnName(playerid, 0), MoneyFormat(price), ReturnName(tagetid, 0), reason);
	return 1;
}

CMD:impounds(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
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

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	new tagetid,reason[255],time, room;

	if(sscanf(params, "us[255]dd", tagetid, reason, time, room))
		return SendUsageMessage(playerid, "/arrest <ชื่อบางส่วน/ไอดี> <ข้อหา> <เวลา : นาที> <ห้องขัง 1-3>");

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
		
	if(IsPlayerLogin(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	if(!IsPlayerNearPlayer(playerid, tagetid, 3.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(strlen(reason) < 5 || strlen(reason) > 250)
		return SendErrorMessage(playerid, "กรอกข้อหาให้ถูกต้อง ห้ามน้อยกว่า 5 และห้ามเกิน 250");

	if(time < 1 || time > 600)
		return SendErrorMessage(playerid, "กรอกเวลาให้ถูกต้อง ห้ามน้อยกว่า 1 และห้ามมากกว่า 600 นาที");

	if(room < 1 || room > 3)
		return SendErrorMessage(playerid, "กรอกห้องขังที่จะส่งให้ผู้ต้องกาให้ถูกต้อง 1-3");

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

CMD:checkplate(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
    {
        new
            Float:x,
            Float:y,
            Float:z
        ;

        GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
        new 
            vehicleid = GetNearestVehicle(playerid)
        ;

        if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");


		SendClientMessageEx(playerid, COLOR_GREEN, "* กำลังตรวจสอบ... พบคำตอบแล้ว: %s", VehicleInfo[vehicleid][eVehiclePlates]);
        return 1;
    }
	
	else SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");
	return 1;
}

CMD:spike_add(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้ได้หากร่างกายคุณอยู่ในสถานะไม่ปกติ");

	new idx = 0;

	for(new i = 1; i < MAX_SPIKES; i++)
    {
        if(!SpikeData[i][SpikeID])
		{
			idx = i;
			break;
		}
    }

	if(idx == 0)
		return SendErrorMessage(playerid, "การสร้าง Spike ถึงขีดจำกัดแล้วโปรดลบแล้วสร้างใหม่");

	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y,z);
	GetPlayerFacingAngle(playerid, a);
	
	SpikeData[idx][SpikeID] = idx;
	SpikeData[idx][SpikeObjet] = CreateDynamicObject(2892, x, y,z- 0.8, 0.0, 0.0, a, -1, -1, -1);
	SpikeData[idx][SpikePos][0] = x;
	SpikeData[idx][SpikePos][1] = y;
	SpikeData[idx][SpikePos][2] = z;
	SpikeData[idx][SpikePos][3] = 0.0;
	SpikeData[idx][SpikePos][4] = a;
	SpikeData[idx][SpikePos][5] = 0.0;
	SendFactionMessageEx(playerid, COLOR_COP, "*HQ-SPIKE: %s ได้วาง Spike ในพื้นที่ %s แล้ว", ReturnRealName(playerid), ReturnLocation(playerid));
	return 1;
}

CMD:spike_del(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงาน ตำรวจ/นายอำเภอ/ผู้คุมเรือนจำ"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

    if(PlayerInfo[playerid][pDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่อยู่ในการทำหน้าที่ (off-duty)");

	if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้ได้หากร่างกายคุณอยู่ในสถานะไม่ปกติ");

	new idx = 0;
	for(new i = 1; i < MAX_SPIKES; i++)
    {
        if(!SpikeData[i][SpikeID])
            continue;
        
        if(IsPlayerInRangeOfPoint(playerid, 3.0, SpikeData[i][SpikePos][0], SpikeData[i][SpikePos][1], SpikeData[i][SpikePos][2]))
        {
			idx = i;
			break;
        }
    }

	if(!idx)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดเก็บ Spike");

	SpikeData[idx][SpikeID] = 0;
	
	if(IsValidDynamicObject(SpikeData[idx][SpikeObjet]))
		DestroyDynamicObject(SpikeData[idx][SpikeObjet]);

	SpikeData[idx][SpikePos][0] = 0.0;
	SpikeData[idx][SpikePos][1] = 0.0;
	SpikeData[idx][SpikePos][2] = 0.0;
	SpikeData[idx][SpikePos][3] = 0.0;
	SpikeData[idx][SpikePos][4] = 0.0;
	SpikeData[idx][SpikePos][5] = 0.0;
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
	GlobalInfo[G_GovCash]+= FineInfo[id][FinePrice];

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
	else if(RELEASED(KEY_CTRL_BACK))
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2140.071,-2197.955,13.554))
			return 1;

		if(GetPlayerVirtualWorld(playerid) != 0)
			return 1;

		if(IsPlayerInAnyVehicle(playerid))
			return 1;

		if(ReturnFactionJob(playerid) != 1)
			return 1;

		new vehicleid = GetPlayerNearVehicle(playerid);

		if(vehicleid == INVALID_VEHICLE_ID)
		{
			ShowVehicleSpawnMenuFaction(playerid);
			return 1;
		}


		if(VehicleInfo[vehicleid][eVehicleFaction] != PlayerInfo[playerid][pFaction])
			return ShowVehicleSpawnMenuFaction(playerid);

		
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, "You Are Collect Vehicles");
		SetPVarInt(playerid,"PlayerGetVehicle", 0);
		return 1;
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

	for (new i = 1; i <= rows; i ++)
	{
		cache_get_value_name_int(i,"ArrestOwnerDBID",Name);
		cache_get_value_name_int(i,"ArrestByDBID",By);
		cache_get_value_name(i,"ArrestReason",reason,255);
		cache_get_value_name_int(i,"ArrestTime",time);
		cache_get_value_name(i,"ArrestDate",date,60);
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

	SendFactionMessageEx(playerid, 0x8D8DFFFF, "HQ-ARREST: %s ถูกกุมขัง อยู่ห้องขัง Room: %d", ReturnName(tagetid,0), room);
	SendFactionMessageEx(playerid, 0x8D8DFFFF, "ด้วยข้อหา: %s โดย %s %s",reason, ReturnFactionRank(playerid), ReturnName(playerid,0));
	switch(room)
	{
		case 1:
		{
			SetPlayerPos(tagetid, 1408.480,-3.796,1000.964);
			SetPlayerVirtualWorld(tagetid, 50835);
			SetPlayerInterior(tagetid, 3);
		}
		case 2:
		{
			SetPlayerPos(tagetid, 1405.166,-3.539,1000.964);
			SetPlayerVirtualWorld(tagetid, 50835);
			SetPlayerInterior(tagetid, 3);
		}
		case 3:
		{
			SetPlayerPos(tagetid,1402.111,-3.375,1000.964);
			SetPlayerVirtualWorld(tagetid, 50835);
			SetPlayerInterior(tagetid, 3);
		}
		/*case 4:
		{
			SetPlayerPos(tagetid,215.4856,109.6158,999.0156);
			SetPlayerVirtualWorld(tagetid, 10001);
			SetPlayerInterior(tagetid, 10);
		}*/
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
			SetPlayerPos(playerid, 1408.480,-3.796,1000.964+1);
			SetPlayerVirtualWorld(playerid, 50835);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);

		}
		case 2:
		{
			SetPlayerPos(playerid, 1405.166,-3.539,1000.964+1);
			SetPlayerVirtualWorld(playerid, 50835);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
		case 3:
		{
			SetPlayerPos(playerid,219.6822,110.2353,999.0156+1);
			SetPlayerVirtualWorld(playerid, 50835);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
		case 4:
		{
			SetPlayerPos(playerid,1402.111,-3.375,1000.964+1);
			SetPlayerVirtualWorld(playerid, 50835);
			SetPlayerInterior(playerid, 10);
			SetTimerEx("Freeze2Sec", 2000, false, "d", playerid);
		}
	}
	return 1;
}


stock ShowFines(playerid, tagerid)
{
	new str[255], fineid, longstr[255];
	format(str, sizeof(str), "สาเหตุ:\tค่าปรับ:\t วันที่:\n");
	strcat(longstr, str);

	for(new i = 1; i < MAX_FINES; i++)
	{
		if(!FineInfo[i][FineDBID])
			continue;

		if(FineInfo[i][FineOwner] != PlayerInfo[tagerid][pDBID])
			continue;

		format(str, sizeof(str), "%s...\t$%s\t%s\n", FineInfo[i][FineReson][10], MoneyFormat(FineInfo[i][FinePrice]), FineInfo[i][FineDate]);
		strcat(longstr, str);

		format(str, sizeof(str), "%d",fineid);
		SetPVarInt(playerid, str, i);
		fineid++;
	}

	if(!fineid)
	{
		Dialog_Show(playerid, DIALOG_FINES_LIST_NONE, DIALOG_STYLE_LIST, "ใบสั่ง", "ไม่มีใบสั่ง...", "ยืนยัน", "ยกเลิก");
		return 1;
	}

	Dialog_Show(playerid, DIALOG_FINES_LIST, DIALOG_STYLE_TABLIST_HEADERS, "ใบสั่ง", longstr, "ยืนยัน", "ยกเลิก");
	return 1;
}


stock ShowVehicleSpawnMenuFaction(playerid)
{

	if(ReturnFactionJob(playerid) == 1)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			new str[255], longstr[255];

			format(str, sizeof(str), "Police LS\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Police LV\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Police Ranger	\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Police SF\n");
			strcat(longstr,str);

			format(str, sizeof(str), "HPV1000\n");
			strcat(longstr,str);

			format(str, sizeof(str), "FBI Truck\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Police Maverick\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Tow Truck\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Premier\n");
			strcat(longstr,str);

			format(str, sizeof(str), "Sultan\n");
			strcat(longstr,str);


			inline police_getcar(id, dialogid, response, listitem, string:inputtext[])
			{
				#pragma unused id, dialogid, listitem, inputtext

				if(!response)
				{
					return 1;
				}
				if(response)
				{
					switch(listitem)
					{
						case 0: SpawnVehicleFaction(playerid, 596, 0, 1);
						case 1: SpawnVehicleFaction(playerid, 598, 0, 1);
						case 2: SpawnVehicleFaction(playerid, 599, 0, 1);
						case 3: SpawnVehicleFaction(playerid, 597, 0, 1);
						case 4: SpawnVehicleFaction(playerid, 523, 0, 1);
						case 5: SpawnVehicleFaction(playerid, 528, 0, 1);
						case 6: SpawnVehicleFaction(playerid, 497, 0, 1);
						case 7: SpawnVehicleFaction(playerid, 525, 0, 1);
						case 8: SpawnVehicleFaction(playerid, 426, 0, 0);
						case 9: SpawnVehicleFaction(playerid, 560, 0, 0);
					}
				}
			}

			Dialog_ShowCallback(playerid, using inline police_getcar, DIALOG_STYLE_LIST, "POLCIE CAR", longstr, "ยืนยัน", "ยกเลิก");
			return 1;
		}
	}
	return 1;
}



stock SpawnVehicleFaction(playerid, vehid, color1, color2)
{

	new vehicleid = INVALID_VEHICLE_ID;

	if(GetPVarInt(playerid, "PlayerGetVehicle"))
	{
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid);
	}


	new Float: x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);

	vehicleid = CreateVehicle(vehid, x+3, y, z, 315.537, color1, color2, -1, 1);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
		VehicleInfo[vehicleid][eVehicleFaction] = PlayerInfo[playerid][pFaction];
		VehicleInfo[vehicleid][eVehicleModel] = vehid;
		
		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
		VehicleInfo[vehicleid][eVehicleFuel] = Random(30, 100);
		VehicleInfo[vehicleid][eVehicleEngine] = 100;
		VehicleInfo[vehicleid][eVehicleElmTimer] = -1;
		VehicleInfo[vehicleid][eVehicleCarPark] = false;
	}
	
	SetVehicleHp(vehicleid);
	SetPVarInt(playerid,"PlayerGetVehicle", vehicleid);
	return 1;
}
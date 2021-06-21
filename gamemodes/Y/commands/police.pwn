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
		cache_get_value_index_float(i, 0,	vehDistance[0]);
		cache_get_value_index_float(i, 1,	vehDistance[1]);
		cache_get_value_index_float(i, 2,	vehDistance[2]);

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
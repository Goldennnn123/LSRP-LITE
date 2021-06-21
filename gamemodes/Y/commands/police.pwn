CMD:cuff(playerid, params[])
{
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");


    new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/cuff [���ͺҧ��ǹ/�ʹ�]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
    
    if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

    
    if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "������������������س");
		
	if(PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "�����蹤����١��ͤ���¡ح������������");

    /*if(GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_HANDSUP && GetPlayerSpecialAction(playerb) != SPECIAL_ACTION_DUCK)
		return SendErrorMessage(playerid, "���������������㹶�ҷҧ�Ѵ�׹");*/
	
	SetPlayerAttachedObject(playerb, 0, 19418,6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
	SetPlayerSpecialAction(playerb, SPECIAL_ACTION_CUFFED);

    PlayerInfo[playerb][pHandcuffed] = true;

    new str[200];
    format(str, sizeof(str), "���Ǻᢹ�ͧ %s �����Ժ�ح�����͡�����价��ᢹ�ͧ��", ReturnRealName(playerb, 0));
    callcmd::me(playerid, str);
    return 1;
}

CMD:uncuff(playerid, params[])
{
	if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "�س����������࿤���");
		
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");

	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/uncuff [���ͺҧ��ǹ/�ʹ�]"); 
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "������������������͡Ѻ�׿�����");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�"); 
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "������������������س");
		
	if(!PlayerInfo[playerb][pHandcuffed])
		return SendErrorMessage(playerid, "�����������١���ح����");

	RemovePlayerAttachedObject(playerb, 0); 
	SetPlayerSpecialAction(playerb, SPECIAL_ACTION_NONE);
	
	PlayerInfo[playerb][pHandcuffed] = false;
	new str[200];
    format(str, sizeof(str), "��Ŵ�ح���ͧ͢ %s", ReturnRealName(playerb, 0));
    callcmd::me(playerid, str);
	return 1;
}

CMD:tazer(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�����˹��§ҹ ���Ǩ/��������/��������͹��"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");

	if(!PlayerInfo[playerid][pTaser])
	{

		if(GetPlayerWeapon(playerid) != 24)
			return SendErrorMessage(playerid, "�س����ջ׹��͵俿��");
		
		PlayerInfo[playerid][pTaser] = true;
		GivePlayerGun(playerid, 23, 100); 
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ��Ժ�׹��͵俿���͡�Ҩҡ�ͧ˹ѧ", ReturnName(playerid, 0)); 
	}
	else
	{
		if(GetPlayerWeapon(playerid) != 23)
			return SendErrorMessage(playerid, "�س����ջ׹��͵俿��");

		GivePlayerGun(playerid, 24,160); 
		PlayerInfo[playerid][pTaser] = false;
		
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s �纻׹��͵俿����ҫͧ˹ѧ", ReturnName(playerid, 0)); 
	}
	
	return 1;
}

CMD:take(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�����˹��§ҹ ���Ǩ/��������/��������͹��"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");

	new playerb, type;

	if(sscanf(params,"dd",playerb,type))
	{
		SendUsageMessage(playerid,"/take [�ʹ�/���ͺҧ��ǹ] [������]");
		SendClientMessage(playerid, -1, "1.Driverlicense 2.WeaponLicense");
		return 1;
	}

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "�����������������������׿�����");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

	if(type == 1)
	{
		if(PlayerInfo[playerb][pDriverLicense] == false)
			return SendErrorMessage(playerid, "����������� 㺢Ѻ���ö¹��");

		if(PlayerInfo[playerb][pDriverLicenseRevoke] == true)
		{
			PlayerInfo[playerb][pDriverLicenseRevoke] = false;

			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ��׹㺢Ѻ���ͧ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pDriverLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ���ִ㺢Ѻ���ͧ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
		}
		return 1;
	}
	else if(type == 2)
	{
		if(PlayerInfo[playerb][pWeaponLicense] == false)
			return SendErrorMessage(playerid, "����������� 㺾����ظ");

		if(PlayerInfo[playerb][pWeaponLicenseRevoke] == true)
		{
			PlayerInfo[playerb][pWeaponLicenseRevoke] = false;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ��׹㺾����ظ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));	
			return 1;
		}
		else
		{
			PlayerInfo[playerb][pWeaponLicenseRevoke] = true;
			SendNearbyMessage(playerid,20.0,COLOR_EMOTE,"* %s ���ִ㺾����ظ�ͧ %s",ReturnRealName(playerid,0),ReturnRealName(playerb,0));
		}
	}
	return 1;
}

CMD:givelicense(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�����˹��§ҹ ���Ǩ/��������/��������͹��"); 
		
    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");

	new playerb;

	if(PlayerInfo[playerid][pFactionRank] > FactionInfo[PlayerInfo[playerid][pFaction]][eFactionAlterRank])
		return SendErrorMessage(playerid, "��/����˹觢ͧ�س ������Ѻ͹حҵ���������觹��");

	if(sscanf(params,"d",playerb))
		return SendUsageMessage(playerid,"/givelicense [�ʹ�/���ͺҧ��ǹ]");

	if(PlayerInfo[playerb][pWeaponLicense] == true)
		return SendErrorMessage(playerid,"��������㺾����ظ��������");

	PlayerInfo[playerb][pWeaponLicense] = true;
	SendPoliceMessage(0x8D8DFFFF, "HQ: %s %s �ͺ㺾����ظ ���Ѻ %s", ReturnFactionRank(playerid), ReturnName(playerid, 0), ReturnName(playerb, 0));
	return 1;
}

CMD:impound(playerid, params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��"); 

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س����� ���Ǩ/��������/����Ҫ������͹��");

    if(PlayerInfo[playerid][pPoliceDuty] == false && PlayerInfo[playerid][pSheriffDuty] == false && PlayerInfo[playerid][pSADCRDuty] == false)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} �س�������㹡�÷�˹�ҷ�� (off-duty)");

	new vehicleid = GetPlayerVehicleID(playerid), trailerid = GetVehicleTrailer(vehicleid);

	if(!vehicleid)
		return SendErrorMessage(playerid, "�س��ͧ���躹ö");

	if(GetVehicleModel(vehicleid) != 525)
		return SendErrorMessage(playerid, "�س��ͧ������躹ö Towtruck");


	if(!IsTrailerAttachedToVehicle(vehicleid))
		return SendErrorMessage(playerid, "�س������ҡ�ҹ��˹�");
	
	if(!VehicleInfo[trailerid][eVehicleDBID] || VehicleInfo[trailerid][eVehicleAdminSpawn] || IsRentalVehicle(trailerid) || VehicleInfo[trailerid][eVehicleFaction])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "����觹������ö����੾���ҹ��˹���ǹ��� ��س������ҹ��˹��Ҹ�ó� (Static)");
	
	if(VehicleInfo[trailerid][eVehicleImpounded])
		return SendErrorMessage(playerid, "�ҹ��˹Фѹ���١�ִ����");
	
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
		SendClientMessageEx(playerid, -1, "�س���ִ�ҹ��˹� %s ���º��������",ReturnVehicleName(trailerid));
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "��鹷��ç���١��ҹ����");
	return 1;
}

CMD:unimpound(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!GetPlayerVehicleID(playerid))
		return SendErrorMessage(playerid, "�س��������躹�ҹ��ҹ�");


	if(!VehicleInfo[vehicleid][eVehicleDBID] || VehicleInfo[vehicleid][eVehicleAdminSpawn] || IsRentalVehicle(vehicleid) || VehicleInfo[vehicleid][eVehicleFaction])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "����觹������ö����੾���ҹ��˹���ǹ��� ��س������ҹ��˹��Ҹ�ó� (Static)");

	if(!VehicleInfo[vehicleid][eVehicleImpounded])
		return SendErrorMessage(playerid, "�ҹ��Фѹ��������١�ִ");

	if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "�ҹ��˹������ͧ�س");

	
	if(PlayerInfo[playerid][pCash] < 1500)
		return SendErrorMessage(playerid, "�س���Թ�����§�͵�͡�ù�ö�׹ ($1,500)");


	VehicleInfo[vehicleid][eVehicleImpounded] = false;
	VehicleInfo[vehicleid][eVehicleImpoundPos][0] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][1] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][2] = 0;
	VehicleInfo[vehicleid][eVehicleImpoundPos][3] = 0;
	SendClientMessageEx(playerid, -1, "�س��ӷ����͡���͡�ҡ�ҹ��� %s �ͧ�س���º��������",ReturnVehicleName(vehicleid));
	SendPoliceMessage(0x8D8DFFFF, "HQ-TRAFFIC-DIVISION: %s ����ҹ��� %s �͡�ҡ����ִ���º��������",ReturnName(playerid,0), ReturnVehicleName(vehicleid));
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
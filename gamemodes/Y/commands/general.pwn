#include <YSI_Coding\y_hooks>

new bool:PlayerHelpUp[MAX_PLAYERS];

enum F_FRISK_DATA
{
	Frisk_ID,
	Frisk_BY
}

new FriskInfo[MAX_PLAYERS][F_FRISK_DATA];

hook OnPlayerConnect(playerid)
{
	PlayerHelpUp[playerid] = false;

	FriskInfo[playerid][Frisk_ID] = INVALID_PLAYER_ID;
	FriskInfo[playerid][Frisk_BY] = INVALID_PLAYER_ID;
	SetPVarInt(playerid, "HideHud", 1);
	return 1;
}

CMD:help(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrplite.in.th___________");
	SendClientMessage(playerid, COLOR_GRAD2,"[ACCOUNT] /stats /levelup /myweapon /setspawn /license /fines /frisk");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /pay /time /buy /call /coin /admins /housecmds /blindfold /gps /makegps /editgps /cigarettes");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /global /bitsamphelp /setstation /boombox /clothing /buyclothing /takegun");
	SendClientMessage(playerid, COLOR_GRAD2,"[CHAT] (/s)hout /(w)hisper /(o)oc /b /pm(ooc) (/l)ocal /me /ame /do(low) /low /radiohelp(/rhelp) ");
	SendClientMessage(playerid, COLOR_GRAD1,"[HELP] /jobhelp /fishhelp  /minerhelp /stats /report /helpme /computerhelp /drughelp /meal /dropgun");
	SendClientMessage(playerid, COLOR_GRAD2,"[ANIMATION] /anim /animlist /sa(stopanimation) /walkstyle /shakehand");
	SendClientMessage(playerid, COLOR_GRAD2,"[VEHICLE] /cw");
	SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
	return 1; 
}

CMD:onduty(playerid, params[])
{
	new police, medic, sadcr, taxi;

	foreach(new i : Player)
	{
		new factiontype = FactionInfo[PlayerInfo[i][pFaction]][eFactionJob];
		
		if(!PlayerInfo[i][pDuty])
			continue;

		if(factiontype == POLICE || factiontype == SHERIFF)
			police++;
		
		if(factiontype == SADCR)
			sadcr++;
			
		if(factiontype == MEDIC)
			medic++;

		if(PlayerTaxiDuty[i])
			taxi++;
		

	}
	SendClientMessageEx(playerid, -1, "On duty: %d PD/SD, %d DOC, %d LSFD, %d Taxis", police, sadcr, medic, taxi);
	return 1;
}

alias:radiohelp("rhelp")
CMD:radiohelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________Radio_help______________________|");
	SendClientMessage(playerid, COLOR_YELLOW,"HINT: คุณสามารถซื้อวิทยุได้ที่ร้าน 24/7");
	SendClientMessage(playerid, COLOR_WHITE,"/setchannel - ตั้งค่าแชแนล");
	SendClientMessage(playerid, COLOR_WHITE,"/setslot - ตั้งค่าห้องของแชแนล");
	SendClientMessage(playerid, COLOR_WHITE,"/r - พูดวิทยุ");
	SendClientMessage(playerid, COLOR_WHITE,"/rlow - พูดวิทยุแบบเบา");
	SendClientMessage(playerid, COLOR_WHITE,"/radioon - เปิด ปิดวิทยุ");
	SendClientMessage(playerid, COLOR_GREEN,"|_____________________________________________________|");
	return 1;
}


CMD:logout(playerid, params[])
{
	if(gettime() - PlayerInfo[playerid][pLastDamagetime] < 120)
		return SendServerMessage(playerid, "คุณได้รับดาเมจอยู่");

	SendNearbyMessage(playerid, 5.5, COLOR_GREY, "%s ได้ออกจากเกมส์ (Log-out)", ReturnRealName(playerid,0));

	new str[120];
	format(str, sizeof(str), "[%s] %s(DBID: %d) Log Out In Game", ReturnDate(),ReturnRealName(playerid,0), PlayerInfo[playerid][pDBID]);
	SendDiscordMessageEx("connecnt", str);


	/*if(PlayerInfo[playerid][pVehicleSpawned])
	{
		ResetVehicleVars(PlayerInfo[playerid][pVehicleSpawnedID]);
		DestroyVehicle(PlayerInfo[playerid][pVehicleSpawnedID]);
		
		PlayerInfo[playerid][pVehicleSpawned] = false;
		PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;
	}*/


	CharacterSave(playerid);
	SetPlayerName(playerid, e_pAccountData[playerid][mAccName]); 
	TogglePlayerSpectating(playerid, true);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerCameraPos(playerid, 2071.6313,-1828.9207,23.3445);
	SetPlayerCameraLookAt(playerid, 2096.2373,-1794.2494,13.3889);
	

	ResetPlayerCharacter(playerid);
	new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
	new maxname = strlen(pname);
	new query[MAX_STRING];

	for(new i=0; i<maxname; i++)
	{
		if(pname[i] == '_')
		{
			SendServerMessage(playerid, "คุณไม่ได้ใส่ชื่อ Username โปรดออกไปใส่ชื่อเป็น Username เพื่อเข้าสู่ระบบ");
			return Dialog_Show(playerid, DIALOG_SET_USERNAME, DIALOG_STYLE_INPUT, "เปลี่ยนชื่อเป็น Username ที่คุณต้องการ", "ใส่ชื่อ Username ที่คุณต้องการเข้าสู่ระบบ หากมีชื่อผู้ใช้อยู่แล้วจะนำเข้าสู่ระบบต่อไป:", "ยืนยัน", "ยกเลิก");
		}
	}
    
	mysql_format(dbCon, query, sizeof(query), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
	mysql_tquery(dbCon, query, "OnPlayerJoin", "d", playerid);
    SendClientMessage(playerid, -1, "ยินดีต้อนรับเข้าสู่ "EMBED_YELLOW"Los Santos Roleplay LITE");
	return 1;
}


CMD:opendoor(playerid, params[])
{
	new item[16];
	if(sscanf(params, "s[32]", item)) 
	{
	  	    //SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]"EMBED_WHITE" TIP: เมื่อเป็นคนขับ คุณสามารถระบุหน้าต่างที่จะเปิดได้");
			SendClientMessage(playerid, COLOR_LIGHTRED, "การใช้: "EMBED_WHITE"/opendoor [dr (driver) / pa (passenger) / bl (backleft) / br (backright)]");
	}

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		new vehicleid = GetNearestVehicle(playerid);

		if(HasNoEngine(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถเปิดประตูที่ยานพาหนะสิ่งนี้ได้");

		if(IsCheckBike(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถเปิดประตูที่ยานพาหนะสิ่งนี้ได้");

		if(strcmp(item, "driver", true) == 0 || strcmp(item, "dr", true) == 0)
		{
			SetVehicleParamsCarDoors(vehicleid, 1, -1, -1, -1);
			SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "* %s เปิดประตูรถ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid));
		}
		else if(strcmp(item, "passenger", true) == 0 || strcmp(item, "pa", true) == 0)
		{
			SetVehicleParamsCarDoors(vehicleid, -1, 1, -1, -1);
			SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "* %s เปิดประตูรถ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid));		
		}
		else if(strcmp(item, "backleft", true) == 0 || strcmp(item, "bl", true) == 0)
		{
			SetVehicleParamsCarDoors(vehicleid, -1, -1, 1, -1);
			SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "* %s เปิดประตูรถ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid));
		}
		else if(strcmp(item, "backright", true) == 0 || strcmp(item, "br", true) == 0)
		{
			SetVehicleParamsCarDoors(vehicleid, -1, -1, -1, 1);
			SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "* %s เปิดประตูรถ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid));		
		}
		else SendErrorMessage(playerid, "พิพม์ให้ถูกต้องด้วย");

		return 1;
	}
	else SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ยานพาหนะ");
	return 1;
}


CMD:dropgun(playerid, params[])
{
	new weaponid;
	if(sscanf(params, "i", weaponid))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "การทิ้งอาวุธด้วยคำสั่งนี้ จะทำให้อาวุธหายออกไปจากเซร์ฟเวอร์ในทันที");
		SendUsageMessage(playerid, "/dropgun <ไอดีอาวุธ>");
		return 1;
	}

	if(GetPlayerWeapon(playerid) != weaponid)
		return SendErrorMessage(playerid, "คุณไม่มีอาวุธดังกล่าว (*ถืออาวุธชนิดนั้น)");


	SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ทิ้งอาวุธ %s ออกจากตัวแล้ว", ReturnWeaponName(weaponid));
	SendNearbyMessage(playerid, 5.5, COLOR_EMOTE, "> %s ได้ทิ้งอาวุธ %s ลงพื้น", ReturnRealName(playerid,0), ReturnWeaponName(weaponid));
	
	new str[120];
	format(str, sizeof(str), "[%s] %s(DBID:%d) Drop %s(%d)",ReturnDate(), ReturnRealName(playerid,0), PlayerInfo[playerid][pDBID], ReturnWeaponName(weaponid), weaponid);
	SendDiscordMessageEx("weapons",str);

	RemovePlayerWeapon(playerid, weaponid);
	CharacterSave(playerid);
	return 1;
}

CMD:jobhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_GRAD3,"อาชีพในปัจจุบันของคุณ:");
	SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pJob]));

	if(PlayerInfo[playerid][pSideJob]) {
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessage(playerid, COLOR_GRAD3,"อาชีพเสริม:");
		SendClientMessageEx(playerid,COLOR_GRAD3,"%s", GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pSideJob]));
	}

	// อาชีพเสริม
	

	// อาชีพหลัก
	if(PlayerInfo[playerid][pJob] == JOB_FARMER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของชาวไร่:");
		SendClientMessage(playerid,COLOR_WHITE,"/harvest");
		SendClientMessage(playerid,COLOR_WHITE,"/stopharvest");
	}

	if(PlayerInfo[playerid][pJob] == JOB_TRUCKER) {
	    SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานส่งของ:");
		SendClientMessage(playerid,COLOR_WHITE,"/cargo (เพื่อดูคำสั่งเกี่ยวกับคลังสินค้า)");
	}

	if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานช่างยนต์:");
	}

	if(PlayerInfo[playerid][pJob] == JOB_MINER)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของพนักงานช่างยนต์:");
		SendClientMessage(playerid,COLOR_WHITE,"/checkore (เช็คแร่ในตัว)");
		SendClientMessage(playerid,COLOR_WHITE,"/ptze (แปรรูป)");
		SendClientMessage(playerid,COLOR_WHITE,"/sellore (ขายแร่)");
		SendClientMessage(playerid,COLOR_WHITE,"/giveore (ให้แร่)");
	}

	if(PlayerInfo[playerid][pJob] == JOB_ELECTRICIAN)
	{
 		SendClientMessage(playerid,COLOR_LIGHTRED,"คำสั่งของช่างซ่อมเสาไฟฟ้า:");
		SendClientMessage(playerid,COLOR_WHITE,"/startele (เพิ่อเริ่มงาน)");
		SendClientMessage(playerid,COLOR_WHITE,"/getstair (นำบรรไดออกมาจากท้ายยานพหานะ)");
		SendClientMessage(playerid,COLOR_WHITE,"/fixele (เริ่มซ่อมเสาไฟฟ้าที่เสียหายชำรุด)");
	}

	return 1;
}

CMD:bitsamphelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________BITSAMP : HELP___________");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_GRAD2,"[GENERAL] /checkbit /givebit /sellbit /buybit");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________BITSAMP : HELP___________");
	return 1;
}

CMD:buybit(playerid, params[])
{	
	new Float:bit;
	if(sscanf(params, "f", bit))
		return SendUsageMessage(playerid, "/buybit <จำนวนบิต:>");

	if(bit < 0.00001)
		return SendErrorMessage(playerid, "กรุณาใส่จำนวน บิตให้ถูกต้อง (*ต้องมากกว่า 0.00001*)");


	if(PlayerInfo[playerid][pCash] < bit * GlobalInfo[G_BITSAMP])
		return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

	if(GlobalInfo[G_BitStock] < bit)
		return SendErrorMessage(playerid, "BIT ในตลาดโลกไม่มี");
		

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ซื้อ BITSMAP เสียงินมาจำนวน $%s", MoneyFormat(floatround(bit * GlobalInfo[G_BITSAMP],floatround_round)));
	SendClientMessageEx(playerid, COLOR_GREY, "คุณมี BITSAMP: %.5f",PlayerInfo[playerid][pBTC]);

	PlayerInfo[playerid][pBTC]+=  bit;
	GiveMoney(playerid, -floatround(bit * GlobalInfo[G_BITSAMP],floatround_round));
	GlobalInfo[G_BITSAMP] += floatround(bit * GlobalInfo[G_BITSAMP]);
	GlobalInfo[G_BitStock]-= bit;
	CharacterSave(playerid);
	Saveglobal();
	SendClientMessageToAll(COLOR_YELLOWEX, "มีการเปลี่ยนแปลงทางราคาตลาด");
	return 1;
}


CMD:sellbit(playerid, params[])
{
	new Float:bit;
	if(sscanf(params, "f", bit))
		return SendUsageMessage(playerid, "/sellbit <จำนวนบิต:>");

	if(bit < 0.00001)
		return SendErrorMessage(playerid, "กรุณาใส่จำนวน บิตให้ถูกต้อง (*ต้องมากกว่า 0.00001*)");


	if(PlayerInfo[playerid][pBTC] < bit)
		return SendErrorMessage(playerid, "คุณมีบิตไม่เพียงพอ");
		
	new Float:result;
	
	PlayerInfo[playerid][pBTC]-= bit;
	GlobalInfo[G_BitStock]+= bit;

	if(!GlobalInfo[G_BITSAMP])
		GlobalInfo[G_BITSAMP] = 100;	
		
	result  = GlobalInfo[G_BITSAMP] * bit;
	GlobalInfo[G_BITSAMP] -= floatround(result,floatround_round);

	GlobalInfo[G_GovCash] += floatround(result * 0.07, floatround_round);
	
	GiveMoney(playerid, floatround(result - (result * 0.07),floatround_round));
	CharacterSave(playerid);
	Saveglobal();
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ขาย BITSMAP ได้เงินมาจำนวน $%s", MoneyFormat(floatround(result,floatround_round)));
	SendClientMessageEx(playerid, COLOR_GREY, "เหลือ: %.5f",PlayerInfo[playerid][pBTC]);
	SendClientMessageToAll(COLOR_YELLOWEX, "มีการเปลี่ยนแปลงทางราคาตลาด");
	return 1;
}


CMD:mask(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 3 && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณเลเวลยังไม่พอที่จะสวมใส่ Mask ได้ (เลเวลต้องมากกว่า 3 ขึ้นไป)"); 
		
	if(!PlayerInfo[playerid][pHasMask] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่มี Mask"); 
	
	if(!PlayerInfo[playerid][pMasked])
	{
		foreach(new i : Player)
		{
			ShowPlayerNameTagForPlayer(i, playerid, 0);
		}
		
		PlayerInfo[playerid][pMasked] = true;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW ON", 3000, 5); 
	}
	else
	{
		foreach(new i : Player)
		{	
			ShowPlayerNameTagForPlayer(i, playerid, 1);
		}
		
		PlayerInfo[playerid][pMasked] = false;
		GameTextForPlayer(playerid, "~p~YOUR MASK IS NOW OFF", 3000, 5); 
	}
		
	return 1;
}

CMD:gps(playerid, params[])
{
	Dialog_Show(playerid, D_GPS_LIST, DIALOG_STYLE_LIST, "GPS SYSTEM:", "[GPS GLOBAL]\n[GPS PRIVATE]", "ยินยัน", "ยกเลิก");
	return 1;
}

CMD:global(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________GLOBAL: PRICE___________");
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessageEx(playerid, COLOR_GRAD2, "BITSAMP %.5f: 1 บิตมีค่าเท่ากับ %s ",GlobalInfo[G_BitStock], MoneyFormat(GlobalInfo[G_BITSAMP]));
	SendClientMessage(playerid, COLOR_DARKGREEN, "");
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________GLOBAL: PRICE___________");
	return 1;
}

CMD:enter(playerid,params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, -2706.9470,215.1062,3.8854))
		{
			if(GetPlayerInterior(playerid) != 0)
				return 1;


			new vehicleid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vehicleid, -2722.9558,217.4294,4.0583);
			PutPlayerInVehicle(playerid, vehicleid, 0);
			return 1;
		}
		return 1;
	}
	for(new p = 1; p < MAX_HOUSE; p++)
	{
		if(!HouseInfo[p][HouseDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
		{
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

			if(HouseInfo[p][HouseLock] == true)
				return GameTextForPlayer(playerid, "~r~Locked", 3000, 1);

			if(!HouseInfo[p][HouseInterior][0] || !HouseInfo[p][HouseInterior][1] || !HouseInfo[p][HouseInterior][2])
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			PlayerInfo[playerid][pInsideProperty] = p;

			SetPlayerPos(playerid, HouseInfo[p][HouseInterior][0], HouseInfo[p][HouseInterior][1], HouseInfo[p][HouseInterior][2] - 3);
			
			SetPlayerVirtualWorld(playerid, HouseInfo[p][HouseInteriorWorld]);
			SetPlayerInterior(playerid, HouseInfo[p][HouseInteriorID]);
			
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterProperty", 2000, false, "ii", playerid, p); 

			if(HouseInfo[p][HouseMusic])
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, HouseInfo[p][HouseMusicLink]);
			}
		}

	}
	for(new b = 1; b < MAX_BUSINESS; b++)
	{
		if(!BusinessInfo[b][BusinessDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b][BusinessEntrance][0], BusinessInfo[b][BusinessEntrance][1], BusinessInfo[b][BusinessEntrance][2]))
		{
			if(GetPlayerInterior(playerid) != BusinessInfo[b][BusinessEntranceWorld])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != BusinessInfo[b][BusinessEntranceInterior])
				continue;

			if(GetPlayerMoney(playerid) < BusinessInfo[b][BusinessEntrancePrice])
				return GameTextForPlayer(playerid, "~r~You don't have money", 3000, 1);

			if(!BusinessInfo[b][BusinessInterior][0] || !BusinessInfo[b][BusinessInterior][1] || !BusinessInfo[b][BusinessInterior][2] || BusinessInfo[b][BusinessType] == BUSINESS_TYPE_DEALERVEHICLE)
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			if(BusinessInfo[b][BusinessLock] == true && !PlayerInfo[playerid][pAdminDuty] && BusinessInfo[b][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
				return GameTextForPlayer(playerid, "~r~Lock", 3000, 1);


			PlayerInfo[playerid][pInsideBusiness] = b;

			SetPlayerPos(playerid, BusinessInfo[b][BusinessInterior][0], BusinessInfo[b][BusinessInterior][1], BusinessInfo[b][BusinessInterior][2] - 3);
			SetPlayerVirtualWorld(playerid, BusinessInfo[b][BusinessInteriorWorld]);
			SetPlayerInterior(playerid, BusinessInfo[b][BusinessInteriorID]);

			GiveMoney(playerid, -BusinessInfo[b][BusinessEntrancePrice]);
			BusinessInfo[b][BusinessCash] += BusinessInfo[b][BusinessEntrancePrice];

			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterBusiness", 2000, false, "ii", playerid, b); 

			if(BusinessInfo[b][BusinessMusic])
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,  BusinessInfo[b][BusinessMusicLink]);
			}
			SendBusinessType(playerid, b);
		}
	}
	for(new e = 1; e < MAX_ENTRANCE; e++)
	{
		if(!EntranceInfo[e][EntranceDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]))
		{
			if(GetPlayerInterior(playerid) != EntranceInfo[e][EntranceLocInID])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != EntranceInfo[e][EntranceLocWorld])
				continue;

			if(!EntranceInfo[e][EntranceLocIn][0] || !EntranceInfo[e][EntranceLocIn][1] || !EntranceInfo[e][EntranceLocIn][2])
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			TogglePlayerControllable(playerid, 0);
			SetPlayerPos(playerid, EntranceInfo[e][EntranceLocIn][0], EntranceInfo[e][EntranceLocIn][1], EntranceInfo[e][EntranceLocIn][2] - 3);
			SetPlayerVirtualWorld(playerid, EntranceInfo[e][EntanceLocInWorld]);
			SetPlayerInterior(playerid, EntranceInfo[e][EntranceLocInInID]);
			SetTimerEx("OnPlayerEnter", 2000, false, "ii", playerid, e);

			return 1;
		}
	}

	return 1;
}

CMD:door(playerid, params[])
{
	return 1;
}

CMD:ram(playerid,params[])
{
	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
		return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่หน่วยงานรัฐบาล"); 

	new bool:checked = false;
	for(new p = 1; p < MAX_HOUSE; p++)
	{
		if(!HouseInfo[p][HouseDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
		{
			if(GetPlayerVirtualWorld(playerid) != HouseInfo[p][HouseEntranceWorld])
				continue;
					
			if(GetPlayerInterior(playerid) != HouseInfo[p][HouseEntranceInterior])
				continue;

			if(!HouseInfo[p][HouseInterior][0] || !HouseInfo[p][HouseInterior][1] || !HouseInfo[p][HouseInterior][2])
				return GameTextForPlayer(playerid, "~r~Close", 3000, 1);

			PlayerInfo[playerid][pInsideProperty] = p;
			HouseInfo[p][HouseLock] = false;

			SetPlayerPos(playerid, HouseInfo[p][HouseInterior][0], HouseInfo[p][HouseInterior][1], HouseInfo[p][HouseInterior][2] - 3);
			
			SetPlayerVirtualWorld(playerid, HouseInfo[p][HouseInteriorWorld]);
			SetPlayerInterior(playerid, HouseInfo[p][HouseInteriorID]);
			
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("OnPlayerEnterProperty", 2000, false, "ii", playerid, p); 

			if(HouseInfo[p][HouseMusic])
			{
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid, HouseInfo[p][HouseMusicLink]);
			}
		}
		else checked = true;

	}

	if(checked) return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้บ้าน");

	return 1;
}


CMD:exit(playerid, params[])
{
	new 
		id = PlayerInfo[playerid][pInsideProperty],
		b_id = PlayerInfo[playerid][pInsideBusiness]
	;

	if(id != 0)
	{
        if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");
		
		SetPlayerPos(playerid, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2]);
		
		SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
		SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
		PlayerInfo[playerid][pInsideProperty] = 0;
		PlayerTextDrawHide(playerid, PlayerSwicthOff[playerid][0]);
		StopAudioStreamForPlayer(playerid);
		return 1;
    }
	if(b_id != 0)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, BusinessInfo[b_id][BusinessInterior][0], BusinessInfo[b_id][BusinessInterior][1], BusinessInfo[b_id][BusinessInterior][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ประตูทางออก");

		if(BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_RESTAURANT || BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_STORE)
		{
			if(PlayerInfo[playerid][pGUI] == 5)
			{
				for(new f = 0; f < 8; f++)
				{
					PlayerTextDrawDestroy(playerid, BuyFood[playerid][f]);
				}
				PlayerInfo[playerid][pGUI] = 0;
				CancelSelectTextDraw(playerid);
			}
			if(PlayerInfo[playerid][pGUI] == 6)
			{
				MenuStore_Close(playerid);
				PlayerInfo[playerid][pGUI] = 0;
			}
		}


		StopAudioStreamForPlayer(playerid);
		
		SetPlayerPos(playerid, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2]);
		SetPlayerVirtualWorld(playerid, BusinessInfo[b_id][BusinessEntranceWorld]);
		SetPlayerInterior(playerid, BusinessInfo[b_id][BusinessEntranceInterior]);
		PlayerInfo[playerid][pInsideBusiness] = 0;

		return 1;
	}
	for(new e = 1; e < MAX_ENTRANCE; e++)
	{
		if(!EntranceInfo[e][EntranceDBID])
			continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, EntranceInfo[e][EntranceLocIn][0], EntranceInfo[e][EntranceLocIn][1], EntranceInfo[e][EntranceLocIn][2]))
		{
			if(GetPlayerInterior(playerid) != EntranceInfo[e][EntranceLocInInID])
				continue;
					
			if(GetPlayerVirtualWorld(playerid) != EntranceInfo[e][EntanceLocInWorld])
				continue;

			if(EntranceInfo[e][EntranceLocWorld] != 0)
			{
				TogglePlayerControllable(playerid, 0);
				SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]-3);
				SetTimerEx("OnPlayerExit", 2000, false, "ii", playerid, e);
				return 1;
			}
			//else SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]);

			SetPlayerPos(playerid, EntranceInfo[e][EntranceLoc][0], EntranceInfo[e][EntranceLoc][1], EntranceInfo[e][EntranceLoc][2]);
			SetPlayerVirtualWorld(playerid, EntranceInfo[e][EntranceLocInID]);
			SetPlayerInterior(playerid, EntranceInfo[e][EntranceLocWorld]);

			return 1;
		}
	}
	return 1;
}

alias:stopanimation("sa", "stopanim")
CMD:stopanimation(playerid, params[])
{
	if(PlayerInfo[playerid][pHandcuffed])
	{
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
    	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
		return 1;
	}

	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	PlayerInfo[playerid][pAnimation] = 0;
	return 1;
}


CMD:lock(playerid,params[])
{
	if(PlayerInfo[playerid][pInsideProperty])
	{
		new id = PlayerInfo[playerid][pInsideProperty];

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDBID] != HouseInfo[id][HouseRent] && PlayerInfo[playerid][pHouseKey] != id)
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของบ้านหลังนี้");

		
		if(HouseInfo[id][HouseLock])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = true;
		}
		return 1;
	}
	else if(IsPlayerNearHouse(playerid) != 0)
	{
		new id = IsPlayerNearHouse(playerid);

		if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdminDuty] && PlayerInfo[playerid][pDBID] != HouseInfo[id][HouseRent] && PlayerInfo[playerid][pHouseKey] != id)
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของบ้านหลังนี้");

		if(HouseInfo[id][HouseLock])
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			HouseInfo[id][HouseLock] = true;
		}
		return 1;
	}
	else if(PlayerInfo[playerid][pInsideBusiness])
	{
		new id = PlayerInfo[playerid][pInsideBusiness];

		if(BusinessInfo[id][BusinessOwnerDBID] !=  PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdminDuty] && PlayerInfo[playerid][pBusinessKey] != BusinessInfo[id][BusinessOwnerDBID])
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของกิจการนี้");

		if(BusinessInfo[id][BusinessLock] == true)
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = true;
		}

		return 1;
	}
	else if(IsPlayerNearBusiness(playerid) != 0)
	{
		new id = IsPlayerNearBusiness(playerid);

		if(BusinessInfo[id][BusinessOwnerDBID] !=  PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdminDuty] && PlayerInfo[playerid][pBusinessKey] != BusinessInfo[id][BusinessOwnerDBID])
			return SendErrorMessage(playerid,"คุณไม่ใช่เจ้าของกิจการนี้");

		if(BusinessInfo[id][BusinessLock] == true)
		{
			GameTextForPlayer(playerid, "~w~DOOR ~g~UNLOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = false;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~DOOR ~r~LOCKED", 1000, 6);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BusinessInfo[id][BusinessLock] = true;
		}
		return 1;

	}
	else if(!IsPlayerInAnyVehicle(playerid))
	{
		new bool:foundCar = false, vehicleid, Float:fetchPos[3];

		for (new i = 0; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, fetchPos[0], fetchPos[1], fetchPos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 2.0, fetchPos[0], fetchPos[1], fetchPos[2]))
			{
				foundCar = true;
				vehicleid = i; 
				break; 
			}
		}

		if(foundCar == true)
		{
			if(CheckPlayeyKey(playerid, vehicleid))
			{
				if(IsElecVehicle(vehicleid))
					return SendErrorMessage(playerid, "ไม่สามารถพังยานพาหนะคันนี้ได้ได้");

				if(VehicleInfo[vehicleid][eVehicleAdminSpawn])
					return SendErrorMessage(playerid, "ไม่สามารถพังยานพาหนะคันนี้ได้ได้");

				if(VehicleInfo[vehicleid][eVehicleFaction] > 0)
				{
					if(VehicleInfo[vehicleid][eVehicleFaction] != PlayerInfo[playerid][pFaction])
						return SendErrorMessage(playerid, "ไม่สามารถพังยานพาหนะคันนี้ได้ได้");	
				}

				if (!isnull(params) && !strcmp(params, "breakin", true)) 
				{
			
					SendClientMessage(playerid, COLOR_WHITE, "คุณสามารถเริ่มพังประตูได้ในขณะนี้! วิธีในการพัง:");
					SendClientMessage(playerid, COLOR_WHITE, "-กำปั้น");
					SendClientMessage(playerid, COLOR_WHITE, "-อาวุธระยะประชิด");

					VehicleInfo[vehicleid][eVedhicleBreaktime] = 20;

					new str[65];
					format(str, sizeof(str), "กำลังดำเนินการพังยานพาหนะ %d",VehicleInfo[vehicleid][eVedhicleBreaktime]);

					VehicleInfo[vehicleid][eVehicleBreakUI] = Create3DTextLabel(str, COLOR_WHITE, 0.0, 0.0, 0.0, 25.0, GetPlayerVirtualWorld(playerid), 0); 
					Attach3DTextLabelToVehicle(VehicleInfo[vehicleid][eVehicleBreakUI], vehicleid, -0.7, -1.9, -0.3); 
					VehicleInfo[vehicleid][eVehicleBreak] = true;
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: หากคุณพยายามที่จะพังเข้าไป: "EMBED_YELLOW"\"/lock "EMBED_WHITE"breakin"EMBED_YELLOW"\"");

			}

			new statusString[90]; 
			new engine, lights, alarm, doors, bonnet, boot, objective; 
			
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					
			if(VehicleInfo[vehicleid][eVehicleLocked])
			{
				if(VehicleInfo[vehicleid][eVehicleBreak])
				{
					VehicleInfo[vehicleid][eVehicleBreak] = false;
					VehicleInfo[vehicleid][eVedhicleBreaktime] = 0;

					if(IsValidDynamic3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]))
						Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]); 
				}
				format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
					
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = false;
			}
			else 
			{
				if(VehicleInfo[vehicleid][eVehicleBreak])
				{
					VehicleInfo[vehicleid][eVehicleBreak] = false;
					VehicleInfo[vehicleid][eVedhicleBreaktime] = 0;

					if(IsValidDynamic3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]))
						Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]); 
				}

				format(statusString, sizeof(statusString), "~r~%s LOCKED", ReturnVehicleName(vehicleid));
						
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = true;
			}
			GameTextForPlayer(playerid, statusString, 3000, 3);
		}
		else SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ประตู บ้าน/กิจการ/รถ");
		return 1;
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(CheckPlayeyKey(playerid, vehicleid))
			return SendErrorMessage(playerid, "คุณไม่มีกุญแจสำหรับรถคันนี้");

		if(IsElecVehicle(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถพังยานพาหนะคันนี้ได้ได้");

		new statusString[90]; 
		new engine, lights, alarm, doors, bonnet, boot, objective; 
		
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				
		if(VehicleInfo[vehicleid][eVehicleLocked])
		{
			if(VehicleInfo[vehicleid][eVehicleBreak])
			{
				VehicleInfo[vehicleid][eVehicleBreak] = false;
				VehicleInfo[vehicleid][eVedhicleBreaktime] = 0;

				if(IsValidDynamic3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]))
					Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]); 
			}

			format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
				
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
			VehicleInfo[vehicleid][eVehicleLocked] = false;
		}
		else 
		{
			if(VehicleInfo[vehicleid][eVehicleBreak])
			{
				VehicleInfo[vehicleid][eVehicleBreak] = false;
				VehicleInfo[vehicleid][eVedhicleBreaktime] = 0;

				if(IsValidDynamic3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]))
					Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleBreakUI]); 
			}

			format(statusString, sizeof(statusString), "~r~%s LOCKED", ReturnVehicleName(vehicleid));
					
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
			VehicleInfo[vehicleid][eVehicleLocked] = true;
		}
		GameTextForPlayer(playerid, statusString, 3000, 3);
		return 1;
	}
	else SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ประตู บ้าน/กิจการ/รถ");
	return 1;
}


CMD:mypos(playerid, params[])
{
	new Float:x, Float:y, Float:z, Float:a;

	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid,  x, y, z);
		GetVehicleZAngle(vehicleid, a);
		SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle_Pos: %.3f %.3f %.3f %.3f", x, y, z, a);
		SendClientMessageEx(playerid, COLOR_WHITE, "World: %d", GetVehicleVirtualWorld(vehicleid));
		SendClientMessageEx(playerid, COLOR_WHITE, "Interior: %d", GetPlayerInterior(playerid));
		return 1;
	}
	else
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		SendClientMessageEx(playerid, COLOR_WHITE, "POS: %.3f %.3f %.3f %.3f", x, y, z, a);
		SendClientMessageEx(playerid, COLOR_WHITE, "World: %d", GetPlayerVirtualWorld(playerid));
		SendClientMessageEx(playerid, COLOR_WHITE, "Interior: %d", GetPlayerInterior(playerid));
	}
	return 1;
}


CMD:check(playerid,params[])
{
	new
		Float: x,
		Float: y,
		Float: z,
		principal_str[256]
	;

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);

		new 
			vehicleid = GetNearestVehicle(playerid)
		;

		if(HasNoEngine(vehicleid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะไม่สามารถเก็บของได้");

		if(IsCheckBike(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถใช้คำสั่งนี้กับยานพาหนะที่เป็น มอเตอร์ไซต์ได้"); 

		if(!VehicleInfo[vehicleid][eVehicleDBID] && VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่ง /check ได้");

		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่กระโปรงท้ายรถ");

		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(!boot)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "กระโปรงท้ายรถยังไม่ได้ถูกเปิด");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[กระสุน: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [ว่างเปล่า]\n", principal_str, i);
		}
		Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Trunk:", principal_str, "ตกลง", "<<");
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่งนี้ได้");
		
		for(new i = 1; i < 6; i++)
		{
			if(VehicleInfo[vehicleid][eVehicleWeapons][i])
				format(principal_str, sizeof(principal_str), "%s%i. %s[กระสุน: %i]\n", principal_str, i, ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][i]), VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i]);
				
			else
				format(principal_str, sizeof(principal_str), "%s%i. [ว่างเปล่า]\n", principal_str, i);
		}
			 
		Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Trunk:", principal_str, "ตกลง", "<<");
	}
	else if(PlayerInfo[playerid][pInsideProperty])
	{
		new
			id = PlayerInfo[playerid][pInsideProperty],
			longstr[600]
		;
		
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดตู้เซฟ");
			
		for(new i = 1; i < 22; i++)
		{
			if(!HouseInfo[id][HouseWeapons][i])
				format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
				
			else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(HouseInfo[id][HouseWeapons][i]), HouseInfo[id][HouseWeaponsAmmo][i]); 
		}
		
		Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");		
	}
	else SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งได้ในขณะนี้");
	return 1;
}

CMD:place(playerid, params[])
{

	new
		Float: x,
		Float: y,
		Float: z,
		str[128],
		weaponid,
		idx
	;

	if(sscanf(params, "i", weaponid))
		return SendUsageMessage(playerid, "/place [ไอดีอาวุธ]");

	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "อาวุธเหล่านี้ถูกจัดเป็นอาวุธต้องห้ามภายในเซืฟเวอร์");


	if(GetPlayerWeapon(playerid) != weaponid)
		return SendErrorMessage(playerid, "คุณไม่ได้ถืออาวุธนี้");

	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
		
		new 
			vehicleid = GetNearestVehicle(playerid)
		;

		if(HasNoEngine(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถใช้คำสั่งนี้กับยานพาหนะที่ไม่มีเครืองยนต์ได้");

		if(IsCheckBike(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถใช้คำสั่งนี้กับยานพาหนะที่เป็น มอเตอร์ไซต์ได้");

		if(VehicleInfo[vehicleid][eVehicleFaction])
		{
			new factionid = VehicleInfo[vehicleid][eVehicleFaction];
			
			if(FactionInfo[factionid][eFactionJob] != POLICE && FactionInfo[factionid][eFactionJob] != SHERIFF)
				return SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");
			
			if(PlayerInfo[playerid][pFaction] != factionid)
				return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะแฟคชั่นอื่นได้");
			
			if(GetPlayerWeapon(playerid) != weaponid)
				return SendErrorMessage(playerid, "คุณไมได้ถืออาวุธที่คุณเลือก");

			RemovePlayerWeapon(playerid, weaponid);
		
			format(str, sizeof(str), "* %s ได้วาง %s ลงไปในรถ %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);
			SendClientMessage(playerid, COLOR_EMOTE, str);
			return 1;
		}

		/*if(!PlayerHasWeapon(playerid, weaponid))
			return SendErrorMessage(playerid, "คุณไม่มีอาวุธดังกล่าว");*/

		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "รถคันนี้เป็นรถของเฟคชั่นไม่สามารถใช้คำสั่งนี้ได้");
		
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงท้ายรถ");
 
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		
		if(!boot)
			return SendClientMessage(playerid, COLOR_YELLOWEX, "คุณไม่ได้เปิดฝากระโปรงท้ายรถ"); 
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = GetPlayerAmmo(playerid);

		PlayerInfo[playerid][pGunAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pGun][ReturnWeaponIDSlot(weaponid)] = 0;

		PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s ได้วาง %s ลงไปในรถ %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000);

		format(str, sizeof(str), "[%s] %s place weapon incar %s(%d) %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), ReturnVehicleName(vehicleid),VehicleInfo[vehicleid][eVehicleDBID],ReturnWeaponName(weaponid),weaponid,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx]);
		SendDiscordMessageEx("weapons", str);
		SaveVehicle(vehicleid); 
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
		
		if(VehicleInfo[vehicleid][eVehicleFaction])
			return SendClientMessage(playerid, COLOR_YELLOW, "รถคันนี้เป็นรถของเฟคชั่นไม่สามารถใช้คำสั่งนี้ได้");
			
		for(new i = 1; i < 6; i++)
		{
			if(!VehicleInfo[vehicleid][eVehicleWeapons][i])
			{
				idx = i;
				break;
			}
		}

		/*if(!PlayerHasWeapon(playerid, weaponid))
			return SendErrorMessage(playerid, "คุณไม่มีอาวุธดังกล่าว");*/
		
		VehicleInfo[vehicleid][eVehicleWeapons][idx] = weaponid; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx] = PlayerInfo[playerid][pGunAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pGunAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pGun][ReturnWeaponIDSlot(weaponid)] = 0;

		PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = 0;
		
		RemovePlayerWeapon(playerid, weaponid);
		
		format(str, sizeof(str), "* %s ได้วาง %s ลงไปในรถ %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponid), ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);

		format(str, sizeof(str), "[%s] %s place weapon incar %s(%d) %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), ReturnVehicleName(vehicleid),VehicleInfo[vehicleid][eVehicleDBID],ReturnWeaponName(weaponid),weaponid,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][idx]);
		SendDiscordMessageEx("weapons", str);
		SaveVehicle(vehicleid); 
	}
	else if(IsPlayerInHouse(playerid) != 0)
	{
		new
			id = IsPlayerInHouse(playerid),
			pid
		;

		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดตู้เซฟ");

		for(new i = 1; i < 22; i++)
		{
			if(!HouseInfo[id][HouseWeapons][i])
			{
				pid = i;
				break;
			}
		}

		/*if(!PlayerHasWeapon(playerid, weaponid))
			return SendErrorMessage(playerid, "คุณไม่มีอาวุธดังกล่าว");*/

		HouseInfo[id][HouseWeapons][pid] = weaponid;
		HouseInfo[id][HouseWeaponsAmmo][pid] = PlayerInfo[playerid][pGunAmmo][ReturnWeaponIDSlot(weaponid)];

		PlayerInfo[playerid][pGunAmmo][ReturnWeaponIDSlot(weaponid)] = 0;
		PlayerInfo[playerid][pGun][ReturnWeaponIDSlot(weaponid)] = 0;

		PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = 0;

		RemovePlayerWeapon(playerid, weaponid);

		format(str, sizeof(str), "* %s ได้วาง %s ไว้ในตู้เซฟ", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4000); 
		SendClientMessage(playerid, COLOR_EMOTE, str);

		format(str, sizeof(str), "[%s] %s place in house(%d) %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), id,ReturnWeaponName(weaponid),weaponid,HouseInfo[id][HouseWeaponsAmmo][pid]);
		SendDiscordMessageEx("weapons", str);

		CharacterSave(playerid); Savehouse(id);
	}
	else SendErrorMessage(playerid, "คุณไม่สามรถใช้คำสั่งนี้ได้ในขณะนี้");
	return 1;
}

CMD:takegun(playerid, params[])
{
	new slotid;

	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(HasNoEngine(vehicleid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะไม่สามารถเก็บของได้"); 

		if(!VehicleInfo[vehicleid][eVehicleDBID] && VehicleInfo[vehicleid][eVehicleAdminSpawn] && !VehicleInfo[vehicleid][eVehicleFaction])
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่ง /takegun ได้");


		if(sscanf(params, "i", slotid))
			return SendUsageMessage(playerid, "/takegun <1-5>");

		if(slotid < 1 || slotid > 5)
			return SendErrorMessage(playerid, "กรุณาใส่ สล็อตให้ถูกต้อง");

		if(VehicleInfo[vehicleid][eVehicleFaction])
		{
			new factionid = VehicleInfo[vehicleid][eVehicleFaction];
			new modelid = GetVehicleModel(vehicleid);
			
			if(FactionInfo[factionid][eFactionJob] != POLICE && FactionInfo[factionid][eFactionJob] != SHERIFF)
				return SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");
			
			if(PlayerInfo[playerid][pFaction] != factionid)
				return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะแฟคชั่นอื่นได้");

			if(modelid != 596 && modelid != 598 && modelid != 599 && modelid != 490 && modelid != 528 && modelid != 427 && modelid != 597 && modelid != 426 && modelid != 560)
				return SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");

			switch(slotid)
			{
				case 1:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 25, 100);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(25), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 2:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 29, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(29), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 3:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 31, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(31), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 4:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 34, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(34), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 5:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 27, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(27), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
			}
			return 1;
		}

		if(!VehicleInfo[vehicleid][eVehicleWeapons][slotid])
			return SendErrorMessage(playerid, "ไม่มีอาวุธใน สล็อตที่คุณเลือก");

		new str[255];

		GivePlayerValidWeapon(playerid, VehicleInfo[vehicleid][eVehicleWeapons][slotid], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid]);

		format(str, sizeof(str), "> %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][slotid]), 
		ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str);

		format(str, sizeof(str), "[%s] %s takegun leave vehicle %s(%d) %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), ReturnVehicleName(vehicleid),VehicleInfo[vehicleid][eVehicleDBID],ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][slotid]),VehicleInfo[vehicleid][eVehicleWeapons][slotid],VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid]);
		SendDiscordMessageEx("weapons", str);
				
				
		VehicleInfo[vehicleid][eVehicleWeapons][slotid] = 0; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid] = 0; 
	}
	else if(GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		new Float: x, Float: y, Float: z;
		new engine, lights, alarm, doors, bonnet, boot, objective;

		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z);

		new vehicleid = GetNearestVehicle(playerid);

		if(HasNoEngine(vehicleid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะไม่สามารถเก็บของได้"); 
		
		if(IsCheckBike(vehicleid))
			return SendErrorMessage(playerid, "ไม่สามารถใช้คำสั่งนี้กับยานพาหนะที่เป็น มอเตอร์ไซต์ได้"); 

		if(!VehicleInfo[vehicleid][eVehicleDBID] && VehicleInfo[vehicleid][eVehicleAdminSpawn] && !VehicleInfo[vehicleid][eVehicleFaction])
			return SendServerMessage(playerid, "รถคันนี้เป็นรถส่วนบุคคนไม่สามารถใช้คำสั่ง /takegun ได้");

		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงท้ายรถ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(!boot)
			return SendErrorMessage(playerid, "ท้ายยานพาหนะยังไม่เปิด");

		if(sscanf(params, "i", slotid))
			return SendUsageMessage(playerid, "/takegun <1-5>");

		if(slotid < 1 || slotid > 5)
			return SendErrorMessage(playerid, "กรุณาใส่ สล็อตให้ถูกต้อง");

		if(VehicleInfo[vehicleid][eVehicleFaction])
		{
			new factionid = VehicleInfo[vehicleid][eVehicleFaction];
			new modelid = GetVehicleModel(vehicleid);
			
			if(FactionInfo[factionid][eFactionJob] != POLICE && FactionInfo[factionid][eFactionJob] != SHERIFF)
				return SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");
			
			if(PlayerInfo[playerid][pFaction] != factionid)
				return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับยานพาหนะแฟคชั่นอื่นได้");

			if(modelid != 596 && modelid != 598 && modelid != 599 && modelid != 490 && modelid != 528 && modelid != 427 && modelid != 597 && modelid != 426 && modelid != 560)
				return SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");

			switch(slotid)
			{
				case 1:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 25, 100);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(25), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 2:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 29, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(29), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 3:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 31, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(31), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 4:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 34, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(34), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
				case 5:
				{
					new str[255];

					GivePlayerWeaponEx(playerid, 27, 60);
							
					format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(27), 
					ReturnVehicleName(vehicleid));
								
					SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
					SendClientMessage(playerid, COLOR_EMOTE, str);
				}
			}
			return 1;
		}

		if(!VehicleInfo[vehicleid][eVehicleWeapons][slotid])
			return SendErrorMessage(playerid, "ไม่มีอาวุธใน สล็อตที่คุณเลือก");

		new str[255];

		GivePlayerValidWeapon(playerid, VehicleInfo[vehicleid][eVehicleWeapons][slotid], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid]);

				
		format(str, sizeof(str), "> %s หยิบ %s ออกมาจากท้ายรถ %s", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][slotid]), 
		ReturnVehicleName(vehicleid));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str);

		format(str, sizeof(str), "[%s] %s takegun leave trunk vehicle %s(%d) %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), ReturnVehicleName(vehicleid),VehicleInfo[vehicleid][eVehicleDBID],ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][slotid]),VehicleInfo[vehicleid][eVehicleWeapons][slotid],VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid]);
		SendDiscordMessageEx("weapons", str);
				
		VehicleInfo[vehicleid][eVehicleWeapons][slotid] = 0; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][slotid] = 0; 
		return 1;
	}
	else if(PlayerInfo[playerid][pInsideProperty])
	{
		new id = PlayerInfo[playerid][pInsideProperty];

		if(!IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[id][HousePlacePos][0], HouseInfo[id][HousePlacePos][1], HouseInfo[id][HousePlacePos][2]))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้จุดตู้เซฟ");
		
		if(sscanf(params, "i", slotid))
			return SendUsageMessage(playerid, "/takegun <1-21>");

		if(slotid < 1 || slotid > 21)
			return SendErrorMessage(playerid, "กรุณาใส่ สล็อตให้ถูกต้อง");

		if(!HouseInfo[id][HouseWeapons][slotid])
			return SendErrorMessage(playerid, "ไม่มีอาวุธใน สล็อตที่คุณเลือก");

		GivePlayerValidWeapon(playerid, HouseInfo[id][HouseWeapons][slotid], HouseInfo[id][HouseWeaponsAmmo][slotid]);

		new str[255];	
		format(str, sizeof(str), "> %s หยิบ %s ออกมาจากตู้เซฟ", ReturnName(playerid, 0), ReturnWeaponName(HouseInfo[id][HouseWeapons][slotid])); 
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str); 

		format(str, sizeof(str), "[%s] %s takegun leave house %d %s(%d) Ammo: %d", ReturnDate(), ReturnRealName(playerid,0), id,ReturnWeaponName(HouseInfo[id][HouseWeapons][slotid]),HouseInfo[id][HouseWeapons][slotid],HouseInfo[id][HouseWeaponsAmmo][slotid]);
		SendDiscordMessageEx("weapons", str);
				
		HouseInfo[id][HouseWeapons][slotid] = 0; 
		HouseInfo[id][HouseWeaponsAmmo][slotid] = 0; 
			
		CharacterSave(playerid); Savehouse(id);
		return 1;
	}
	else SendErrorMessage(playerid, "ไม่มีอะไรอยู่ที่นั้น..");
	return 1;
}

CMD:checkweapons(playerid, params[])
{
	new longstr[MAX_STRING], playerb;

	if(PlayerInfo[playerid][pAdmin])
	{
		if(sscanf(params, "I(-1)", playerb))
			return 1; 

		if(playerb == -1)
		{
			for(new i = 0; i < 4; i++)
			{
					if(!PlayerInfo[playerid][pWeapons][i])
						format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
						
					else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
			}
			Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");
			return 1;
		}
		else
		{
			for(new i = 0; i < 4; i++)
			{
					if(!PlayerInfo[playerb][pWeapons][i])
						format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
						
					else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerb][pWeapons][i]), PlayerInfo[playerb][pWeaponsAmmo][i]); 
			}
			new weapons[4][2];
			SendClientMessage(playerid, -1, "-------------------------WEAPONS NOT IN DATABSE----------------------");
			
			for (new i = 0; i < 4; i++)
			{	
				GetPlayerWeaponData(playerb, i, weapons[i][0], weapons[i][1]);


				if(!weapons[i][0])
					continue;

				if(PlayerInfo[playerb][pWeapons][i])
					continue;

				if(PlayerInfo[playerb][pWeaponsAmmo][i] == weapons[i][1])
					continue;

				SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s %d", ReturnWeaponName(weapons[i][0]), weapons[i][1]);
			}
			Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons: %s", longstr, "ตกลง", "ยกเลิก", ReturnName(playerb,0));
			return 1;
		}
		
	}
	else
	{
		for(new i = 0; i < 4; i++)
		{
				if(!PlayerInfo[playerid][pWeapons][i])
					format(longstr, sizeof(longstr), "%s%d. [ว่างเปล่า]\n", longstr, i);
					
				else format(longstr, sizeof(longstr), "%s%d. %s[กระสุน: %d]\n", longstr, i, ReturnWeaponName(PlayerInfo[playerid][pWeapons][i]), PlayerInfo[playerid][pWeaponsAmmo][i]); 
		}
		Dialog_Show(playerid, DIALOG_MYEAPON, DIALOG_STYLE_LIST, "Weapons:", longstr, "ตกลง", "ยกเลิก");
	}
	return 1;
}

CMD:damages(playerid, params[])
{
	new playerb;
	
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/damages [ชื่อบางส่วน/ไอดี]");
		
	if(!IsPlayerConnected(playerb))	
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อเข้าเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(PlayerInfo[playerid][pAdminDuty])
	{
		ShowPlayerDamages(playerb, playerid, 1); 
	}
	else
	{
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ผู้เล่น");
			
		ShowPlayerDamages(playerb, playerid, 0); 
	}
	return 1;
}

CMD:acceptdeath(playerid, params[])
{
	if(GetPlayerTeam(playerid) != PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "คุณยังไม่ได้รับบาดเจ็บ");
		
	CallLocalFunction("OnPlayerDead", "iii", playerid, INVALID_PLAYER_ID, -1, 0); 
	return 1;
}

CMD:respawnme(playerid, params[])
{
	
	if(GetPlayerTeam(playerid) != PLAYER_STATE_DEAD)
		return SendErrorMessage(playerid, "คุณยังไม่ได้รับบาดเจ็บ");

	if(gettime() - PlayerInfo[playerid][pRespawnTime] < 60)
		return SendErrorMessage(playerid, "คุณยังไม่สามารถเกิดได้โปรดรออีก %d",gettime() - PlayerInfo[playerid][pRespawnTime]);

	PlayerInfo[playerid][pRespawnTime] = 0;
	SetPlayerChatBubble(playerid, "Respawned", COLOR_WHITE, 20.0, 1500);
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE); 
			
	TogglePlayerControllable(playerid, 1);

	ResetPlayerWeapons(playerid);
	
	for(new i = 0; i < 13; i++)
	{
		PlayerInfo[playerid][pWeapons][i] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
	}

	GiveMoney(playerid, -2000);
	SetPlayerHealth(playerid, 100);
	ClearDamages(playerid);
	
	SetPlayerPos(playerid, 1172.3795,-1322.9852,15.4022);
	SetPlayerFacingAngle(playerid, 268.8748);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	return 1;
}

CMD:stats(playerid, params[])
{
	new playerb;
	
	if(PlayerInfo[playerid][pAdmin])
	{
		if (sscanf(params, "I(-1)", playerb))
			return 1; 
			
		if(playerb == -1)
		{
			return ShowCharacterStats(playerid, playerid);
		}
		else
		{
			if(!IsPlayerConnected(playerb))
				return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ทำการเชื่อมต่อเข้าเซืฟเวอร์");
				
			if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
				return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 
				
			ShowCharacterStats(playerb, playerid); 
		}
	}
	else return ShowCharacterStats(playerid, playerid);
	return 1;
}

CMD:pc(playerid, params[])
{
	if(PlayerShowMecMenu[playerid])
		return MecJobShow(playerid, false);
	
	
	return SelectTextDraw(playerid, COLOR_GRAD1);
}

CMD:admins(playerid, params[])
{
	
	new bool:adminOn = false;
	
	foreach (new i : Player)
	{
		if (PlayerInfo[playerid][pAdmin]) adminOn = true;
	}
	
	if(adminOn == true)
	{
		SendClientMessage(playerid, COLOR_GREY, "Admins Online:");
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdminDuty])
			{
				SendClientMessageEx(playerid, COLOR_DARKGREEN, "(Level: %d) %s - On Duty: Yes", PlayerInfo[i][pAdmin], e_pAccountData[i][mForumName]);
			}
		}
	}
	else
	{
		return SendClientMessage(playerid, COLOR_GREY, "Admins Online:");
	}

	return 1;
}

CMD:online(playerid, params[])
{
	new Android = 0, PC = 0;

	foreach(new i : Player)
	{
		if(IsPlayerAndroid(i) == true)
		{
			Android++;
		}
		else PC++;
	}
	SendClientMessageEx(playerid, COLOR_GREY, "Android: %d คน PC: %d คน",Android, PC);
	return 1;
}


CMD:helpers(playerid, params[])
{
	new bool:TesterOn = false;
	
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pTester]) TesterOn = true;
	}
	
	if(TesterOn == true)
	{
		SendClientMessage(playerid, COLOR_GREY, "Tester Online:");
		
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pTesterDuty])
			{
				if(PlayerInfo[i][pTesterDuty])
				{
					SendClientMessageEx(playerid, COLOR_DARKGREEN, "(Level: %d) %s - On Duty: Yes", PlayerInfo[i][pTester], e_pAccountData[i][mForumName]);
				}
			}
		}
	}
	else
	{
		return SendClientMessage(playerid, COLOR_GREY, "Tester Online:");
	}
	return 1;
}

alias:ooc("o")
CMD:ooc(playerid, params[])
{
	if(isnull(params))
		return SendUsageMessage(playerid, "/(o)oc [text]"); 
		
	if(!oocEnabled && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "OOC ถูกปิดการใช้งานในเวลานี้"); 
		
	if(PlayerInfo[playerid][pAdminDuty])
		SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] {FB8C00}%s{adc3e7}: %s", ReturnRealName(playerid, 0), params); 
	else if(PlayerInfo[playerid][pTesterDuty])	
		SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] {229954}%s{adc3e7}: %s", ReturnRealName(playerid, 0), params);

	else SendClientMessageToAllEx(COLOR_SAMP, "{adc3e7}[OOC] %s: %s", ReturnRealName(playerid, 0), params);
	return 1;
}

CMD:pay(playerid, params[])
{
	new playerb, amount, emote[90], str[128]; 

	if(sscanf(params, "uiS('None')[90]", playerb, amount, emote))
		return SendUsageMessage(playerid, "/pay [ชื่อบางส่วน/ไอดี] [จำนวน] [การกระทำ (ถ้ามี)]");

	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");

	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ"); 

	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(amount > PlayerInfo[playerid][pCash])
		return SendErrorMessage(playerid, "คุณไม่มีเงินพอที่จะให้");

	if(amount < 1)
		return SendErrorMessage(playerid, "กรุณาใส่เงินให้ถูกต้อง");

	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); PlayerPlaySound(playerb, 1052, 0.0, 0.0, 0.0);

	SendClientMessageEx(playerid, COLOR_GREY, " คุณได้ทำการจ่ายเงินให้ %s จำนวน $%s.", ReturnRealName(playerb, 0), MoneyFormat(amount)); 
	SendClientMessageEx(playerb, COLOR_GREY, " คุณได้รับเงิน จำนวน $%s จาก %s", MoneyFormat(amount), ReturnRealName(playerid, 0));

	if(!strcmp(emote, "'None'", false))
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s ได้ควักเงินบางส่วนออกมาจากกระเป๋าและมอบให้กับ %s", ReturnName(playerid, 0), ReturnName(playerb, 0)); 

	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s %s %s", ReturnName(playerid, 0), emote, ReturnName(playerb, 0));

	if(PlayerInfo[playerid][pLevel] <= 3 && PlayerInfo[playerb][pLevel] <= 3 || amount >= 50000)
	{
		format(str, sizeof(str), "%s ได้จ่ายเงิน จำนวน $%s ให้กับ %s ซึ่งเหมือนจะเป็นการผิดกฏเซือเวอร์โปรดตรวจสอบด้วย", ReturnName(playerid), MoneyFormat(amount), ReturnName(playerb)); 
		SendAdminMessage(1, str);
	}
	
	format(str, sizeof(str), "[%s] %s pay to %s amount: $%s",ReturnDate(), ReturnRealName(playerid), ReturnRealName(playerb), MoneyFormat(amount));
	SendDiscordMessageEx("money", str);

	GiveMoney(playerid, -amount); GiveMoney(playerb, amount);
	return 1;
}

CMD:setchannel(playerid, params[])
{
	new 
		slot, 
		channel
	;

	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณไม่มี วิทยุ"); 
	
	if(!PlayerInfo[playerid][pRadioOn])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เปิดวิทยุ");

	if(sscanf(params, "ii", channel, slot))
		return SendUsageMessage(playerid, "/setchannel [แชลเเนว] [ส็อต]"); 
		
	if(slot > 2 || slot < 1)
		return SendErrorMessage(playerid, "ส็อตจะสามารถปรับได้เพียงแค่ (1-2)");
		
	if(channel < 1 || channel > 1000000)
		return SendErrorMessage(playerid, "คุณไม่สามารถปรับแชลแนวเกิน (1-1000000)"); 
	
	if(channel == 911)
	{
		if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
			return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่สามารถตั้งค่า คลื่นวิทยุนี้ได้เนื่องจากคุณไม่ใช่หน่วยงานรัฐบาล"); 
	}
	
	PlayerInfo[playerid][pRadio][slot] = channel;
	PlayerInfo[playerid][pMainSlot] = slot;
	SendClientMessageEx(playerid, COLOR_RADIOEX, "คุณได้ปรับวิทยุไปที่คลื่น %i ภายใต้ สล็อต %i.", channel, slot);
	UpDateRadioStats(playerid);
	CharacterSave(playerid); 
	return 1;
}

CMD:radioon(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณยังไม่มีวิทยุ");
	
	if(PlayerInfo[playerid][pRadioOn])
	{
		PlayerInfo[playerid][pRadioOn] = false;
		SendClientMessage(playerid, COLOR_GREY, "คุณได้ปิดวิทยุ");
		return 1;
	}
	else
	{
		PlayerInfo[playerid][pRadioOn] = true;
		SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดวิทยุ");
	}

	return 1;
}

alias:radio("r")
CMD:radio(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณไม่มีวิทยุ");

	if(!PlayerInfo[playerid][pRadioOn])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เปิดวิทยุ");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เซ็ต สล็อต"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/r(adio) [ข้อความ]");
		
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pRadioOn])
		{
			for(new r = 1; r < 3; r ++)
			{
				if(PlayerInfo[i][pRadio][r] == channel)
				{
					if(r != PlayerInfo[i][pMainSlot])
					{
						if(strlen(params) > 75)
						{
							SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %.75s", PlayerInfo[i][pRadio][r], PlayerInfo[playerid][pMainSlot], ReturnName(playerid, 0), params);
							SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s", PlayerInfo[i][pRadio][r],PlayerInfo[playerid][pMainSlot], params[75]);
						}
						else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], PlayerInfo[playerid][pMainSlot], ReturnName(playerid, 0), params);
					}
					else 
					{
						if(strlen(params) > 75)
						{
							SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %.75s", PlayerInfo[i][pRadio][r], PlayerInfo[playerid][pMainSlot], ReturnName(playerid, 0), params);
							SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s", PlayerInfo[i][pRadio][r], PlayerInfo[playerid][pMainSlot], params[75]);
						}
						else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], PlayerInfo[playerid][pMainSlot], ReturnName(playerid, 0), params);
					}
				}
			}
		}
	}
	
	new str[120];
	format(str, sizeof(str),"(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 10.0, 6000);

	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 10.0, posx,posy,posz))
		{
			if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
				continue;
			
			SendClientMessageEx(i, COLOR_GRAD1, "(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:rlow(playerid, params[])
{
	if(!PlayerInfo[playerid][pHasRadio])
		return SendErrorMessage(playerid, "คุณไม่มีวิทยุ");

	if(!PlayerInfo[playerid][pRadioOn])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เปิดวิทยุ");

	new
		local,
		channel
	;
		
	local = PlayerInfo[playerid][pMainSlot]; 
	channel = PlayerInfo[playerid][pRadio][local]; 
	
	if(!PlayerInfo[playerid][pRadio][local])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เซ็ตสล็อต"); 
		
	if(isnull(params))
		return SendUsageMessage(playerid, "/rlow [ข้อความ]");
		
	foreach(new i : Player)
	{
		for(new r = 1; r < 3; r ++)
		{
			if(PlayerInfo[i][pRadio][r] == channel)
			{
				if(r != PlayerInfo[i][pMainSlot])
					SendClientMessageEx(i, COLOR_RADIOEX, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
					
				else SendClientMessageEx(i, COLOR_RADIO, "**[CH: %d, S: %d] %s พูดว่า: %s", PlayerInfo[i][pRadio][r], GetChannelSlot(i, channel), ReturnName(playerid, 0), params);
			}
		}
	}

	new str[120];
	format(str, sizeof(str),"(วิทยุ) %s พูดว่า: %s", ReturnName(playerid, 0), params);
	SetPlayerChatBubble(playerid, str, COLOR_GRAD1, 5.0, 6000);
	
	new Float:posx, Float:posy, Float:posz;
	GetPlayerPos(playerid, posx,posy,posz);

	foreach(new i : Player)
	{
	   	if(i == playerid)
	       continue;

		else if(IsPlayerInRangeOfPoint(i, 5.0, posx,posy,posz))
		{
			if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
				continue;
			
			SendClientMessageEx(i, COLOR_GRAD1, "(วิทยุ) %s พูดว่า[เบา]: %s", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}

CMD:setspawn(playerid, params[])
{
	new 
		id;

	if(sscanf(params, "i", id))
	{
		SendUsageMessage(playerid, "/setspawn [spawn id]");
		SendClientMessage(playerid, COLOR_WHITE, "1. สนามบิน, 2. บ้าน, 3. เฟคชั่น, 4.จุดล่าสุด");
		return 1;
	}

	if(id > 4 || id < 1)
		return SendErrorMessage(playerid, "ไอ้ดีสปาว มีเพียง (1-4)");

	switch(id)
	{
		case 1:
		{
			if(PlayerInfo[playerid][pSpawnPoint] == 0)
				return SendErrorMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น สนามบินอยู่แล้ว");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_DEFAULT; 
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น สนามบิน");
			CharacterSave(playerid);
		}
		case 2:
		{
			new id_house = IsPlayerInHouse(playerid);

			if(id_house == 0)
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในบ้าน");

			if(HouseInfo[id_house][HouseOwnerDBID] != PlayerInfo[playerid][pDBID] && HouseInfo[id_house][HouseRent] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pHouseKey] != id_house)
				return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของบ้านหลังนี้");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_HOUSE;
			PlayerInfo[playerid][pSpawnHouse] = id_house;
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น บ้าน %s", HouseInfo[id_house][HouseName]);
			CharacterSave(playerid);
		}
		case 3:
		{
			new id_fac = PlayerInfo[playerid][pFaction];

			if(id_fac == 0)
				return SendErrorMessage(playerid, "คุณไม่มีเฟคชั่น");
			
			if(!FactionInfo[id_fac][eFactionSpawn][0] || !FactionInfo[id_fac][eFactionSpawn][1] || !FactionInfo[id_fac][eFactionSpawn][2])
				return SendErrorMessage(playerid, "เฟคชั่นของคุณยังไม่มีการเซ็ตจุดเกิด");

			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_FACTION;
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดของคุณเป็น เฟคชั่น");
			CharacterSave(playerid);
		}
		case 4:
		{
			PlayerInfo[playerid][pSpawnPoint] = SPAWN_AT_LASTPOS;
			SendServerMessage(playerid, "คุณได้ทำการเซ็ตจุดเกิดเป็นจุดเกิด ล่าสุด");
			CharacterSave(playerid);
		}
	}
	return 1;
}


alias:leavegun("lg")
CMD:leavegun(playerid, params[])
{
	if(PlayerInfo[playerid][pDuty])
		return SendErrorMessage(playerid, "คุณอยู่ในสถานะการทำงานเป็นหน่วยงานรัฐไม่สามารถใช้คำสั่งนี้ได้");

	if(GetPlayerState(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในสถานะปกติทำให้ไม่สามารถใช้คำสั่งนี้ได้");

	new 
		weaponid, 
		idx,
		id, 
		Float:x,
		Float:y,
		Float:z
	;
	
	if(sscanf(params, "i", weaponid))
	{
		SendUsageMessage(playerid, "/leavegun [ไอดีอาวุธ]");
		SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF}คุณสามารถหยิบปืนขึ้นมาโดยการพิมพ์ /grabgun."); 
		return 1;
	}
	
	if(weaponid < 1 || weaponid > 46 || weaponid == 35 || weaponid == 36 || weaponid == 37 || weaponid == 38 || weaponid == 39)
	    return SendErrorMessage(playerid, "อาวุธเหล่านี้ถูกจัดเป็นอาวุธต้องห้ามภายในเซืฟเวอร์");
		
	/*if(!PlayerHasWeapon(playerid, weaponid))
		return SendErrorMessage(playerid, "คุณไม่ได้มีอาวุธชนิดดังกล่าว"); */

	if(GetPlayerWeapon(playerid) != weaponid)
		return SendErrorMessage(playerid, "คุณไม่ได้ถืออาวุธ %s", ReturnWeaponName(weaponid));
		
	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
		{
			idx = i;
			break;
		}
	}
	
	id = ReturnWeaponIDSlot(weaponid); 
	GetPlayerPos(playerid, x, y, z); 
	
	WeaponDropInfo[idx][eWeaponDropped] = true;
	WeaponDropInfo[idx][eWeaponDroppedBy] = PlayerInfo[playerid][pDBID]; 
	
	WeaponDropInfo[idx][eWeaponWepID] = weaponid;
	WeaponDropInfo[idx][eWeaponWepAmmo] = GetPlayerAmmo(playerid);
	
	WeaponDropInfo[idx][eWeaponPos][0] = x;
	WeaponDropInfo[idx][eWeaponPos][1] = y;
	WeaponDropInfo[idx][eWeaponPos][2] = z;
	
	WeaponDropInfo[idx][eWeaponInterior] = GetPlayerInterior(playerid);
	WeaponDropInfo[idx][eWeaponWorld] = GetPlayerVirtualWorld(playerid); 
	
	RemovePlayerWeapon(playerid, weaponid);
	PlayerInfo[playerid][pGun][id] = 0;
	PlayerInfo[playerid][pGunAmmo][id] = 0; 
	PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = 0;
	PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = 0;
	
	WeaponDropInfo[idx][eWeaponObject] = CreateDynamicObject(
		ReturnWeaponsModel(weaponid),
		x,
		y,
		z - 1,
		80.0,
		0.0,
		0.0,
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid)); 
		
	WeaponDropInfo[idx][eWeaponTimer] = SetTimerEx("OnPlayerLeaveWeapon", 600000, false, "i", idx); 
	SendClientMessage(playerid, COLOR_RED, "[ ! ]{FFFFFF} อาวุธของคุณจะยังคงอยู่บนพื้นได้ถึง 10 นาทีก่อนจะถูกลบออกจากเซืฟเวอร์");
	
	new str[120];
	format(str, sizeof(str), "%s leavegun %s(%d) Ammo: %d", ReturnRealName(playerid,0),ReturnWeaponName(weaponid),weaponid, WeaponDropInfo[idx][eWeaponWepAmmo]);
	SendDiscordMessageEx("weapons", str);
	return 1;
}

alias:grabgun("gg")
CMD:grabgun(playerid, params[])
{	
	new
		bool:foundWeapon = false,
		id,
		str[128]
	;

	for(new i = 0; i < sizeof(WeaponDropInfo); i++)
	{
		if(!WeaponDropInfo[i][eWeaponDropped])
			continue; 
	
		if(IsPlayerInRangeOfPoint(playerid, 3.0, WeaponDropInfo[i][eWeaponPos][0], WeaponDropInfo[i][eWeaponPos][1], WeaponDropInfo[i][eWeaponPos][2]))
		{
			if(GetPlayerVirtualWorld(playerid) == WeaponDropInfo[i][eWeaponWorld])
			{
				foundWeapon = true;
				id = i;
			}							
		}
	}
	
	if(foundWeapon)
	{
		GivePlayerGun(playerid, WeaponDropInfo[id][eWeaponWepID], WeaponDropInfo[id][eWeaponWepAmmo]);
		
		format(str, sizeof(str), "* %s หยิบ %s ขึ้นมาจากพื้น", ReturnName(playerid, 0), ReturnWeaponName(WeaponDropInfo[id][eWeaponWepID]));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		SendClientMessage(playerid, COLOR_EMOTE, str);

		format(str, sizeof(str), "%s grabgun %s(%d) Ammo: %d", ReturnRealName(playerid,0),ReturnWeaponName(WeaponDropInfo[id][eWeaponWepID]), WeaponDropInfo[id][eWeaponWepID], WeaponDropInfo[id][eWeaponWepAmmo]);
		SendDiscordMessageEx("weapons", str);
		
		WeaponDropInfo[id][eWeaponDropped] = false; 
		WeaponDropInfo[id][eWeaponDroppedBy] = 0;
		
		WeaponDropInfo[id][eWeaponWepID] = 0; WeaponDropInfo[id][eWeaponWepAmmo] = 0; 
		
		KillTimer(WeaponDropInfo[id][eWeaponTimer]); 
		DestroyDynamicObject(WeaponDropInfo[id][eWeaponObject]); 
	}
	else return SendServerMessage(playerid, "ไม่มีอาวุธหรือสิ่งๆใดภายในบริเวณรนี้");
	return 1;
}

CMD:levelup(playerid, params[])
{
	new
		exp_count,
		str[128]
	;
	
	exp_count = ((PlayerInfo[playerid][pLevel]) * 4 + 2); 
	
	if(PlayerInfo[playerid][pExp] < exp_count)
	{
		SendServerMessage(playerid, "คุณยังมี ค่าประสบการณ์ไม่มากพอ จำเป็นต้องมีค่าประสบการณ์ %i จึงจะสามารถอัปเกรดได้", exp_count); 
		return 1; 
	}
	
	PlayerInfo[playerid][pLevel]++; 
	PlayerInfo[playerid][pExp] = 0; 
	
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]); 
	
	format(str, sizeof(str), "~g~Leveled Up~n~~w~You leveled up to level %i", PlayerInfo[playerid][pLevel]);
	GameTextForPlayer(playerid, str, 5000, 1);

	CharacterSave(playerid); 
	return 1;
}

alias:license("lic", "บัตรประชาชน", "บัตร")
CMD:license(playerid, params[])
{
	new playerb;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/license [ชื่อบางส่วน/ไอดี]"); 
	
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ"); 
		
	if(playerb != playerid)
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s หยิบบัตรประจำตัวบัตรประชาชนและยื่นให้ %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		
	else SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s หยิบบัตรประจำตัวบัตรประชาชนขึ้นมาดู", ReturnName(playerid, 0));
	
	ReturnLicenses(playerid, playerb); 	
	return 1;
}

CMD:time(playerid, params[])
{
	new str[20];
	format(str, sizeof(str), "ดูนาฬิกา");
	callcmd::ame(playerid, str);
	
	new string[128], hour, minute, seconds;
	
	gettime(hour, minute, seconds);
	
	if(PlayerInfo[playerid][pAdminjailed] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Jail Time left: %d SEC", hour, minute, PlayerInfo[playerid][pAdminjailTime]);

	else if(PlayerInfo[playerid][pArrest] == true)
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|~n~~w~Arrest Time left: %d SEC", hour, minute, PlayerInfo[playerid][pArrestTime]);
	else
		format(string, sizeof(string), "~g~|~w~%02d:%02d~g~|", hour, minute);


		
		
	GameTextForPlayer(playerid, string, 2000, 1);
	
	return 1;
}

CMD:rcp(playerid, params[])
{
	DisablePlayerCheckpoint(playerid);
	
	//Disabling checkpoint referring variables:
	PlayerCheckpoint[playerid] = 0;
	return 1;
}

CMD:b(playerid, params[])
{
	if (isnull(params))
		return SendUsageMessage(playerid, "/b [ข้อความ]"); 
	
	if(PlayerInfo[playerid][pAdminDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {FF9900}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
		Log(chatlog, WARNING, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
	}
	else if(PlayerInfo[playerid][pTesterDuty] == true)
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: ...%s ))", playerid, ReturnName(playerid), params[84]);
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] {229954}%s{AFAFAF}: %s ))", playerid, ReturnName(playerid), params);
		Log(chatlog, WARNING, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
	}
	else
	{
		if(strlen(params) > 84)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
			SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: ...%s ))", playerid, ReturnName(playerid), params[84]); 
		}
		else SendNearbyMessage(playerid, 20.0, COLOR_GREY, "(( [%d] %s: %s ))", playerid, ReturnName(playerid), params);
		Log(chatlog, WARNING, "(( [%d] %s: %.84s ))", playerid, ReturnName(playerid), params);
	}	
	return 1;
}

CMD:pm(playerid, params[])
{
	new
		playerb,
		text[144]
	;

	if(PlayerInfo[playerid][pTogPm] && !PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return SendErrorMessage(playerid, "คุณได้ปิดการรับ ข้อความส่วนตัว");
		
	if(sscanf(params, "us[144]", playerb, text))
		return SendUsageMessage(playerid, "/pm [ชื่อบางส่วน/ไอดี] [text]");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");
	
	if(PlayerInfo[playerb][pTogPm] && !PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return SendErrorMessage(playerid, "ผู้เล่นอีกฝั่งมีการปิดการใช้งานการส่งข้อความส่วนตัว");
	
	if(PlayerInfo[playerid][pAdminDuty])
	{
		
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก {FF9900}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		Log(chatlog, WARNING, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text);

		if(!PlayerInfo[playerb][pAdminDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		Log(chatlog, WARNING, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text);
	}
	else if(PlayerInfo[playerid][pTesterDuty])
	{
		SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก {229954}%s{FFDC18} (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
		Log(chatlog, WARNING, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text);

		if(!PlayerInfo[playerb][pTesterDuty])
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
			
		else SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {229954}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		Log(chatlog, WARNING, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text);
	}
	else
	{
		if(PlayerInfo[playerb][pAdminDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {FF9900}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else if(PlayerInfo[playerb][pTesterDuty])
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง {229954}%s{EEE854} (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
		else
		{
			SendClientMessageEx(playerb, COLOR_PMRECEIVED, "(( PM จาก %s (ID: %d): %s ))", ReturnName(playerid), playerid, text); 
			SendClientMessageEx(playerid, COLOR_PMSENT, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text);
			Log(chatlog, WARNING, "(( PM ส่งไปยัง %s (ID: %d): %s ))", ReturnName(playerb), playerb, text); 
		}
	}
	return 1;
}

CMD:togpm(playerid, params[])
{
	if(!PlayerInfo[playerid][pDonater] && !PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return SendErrorMessage(playerid, "คุณไม่ใช้ Donater");

	if(PlayerInfo[playerid][pTogPm])
	{
		PlayerInfo[playerid][pTogPm] = false;
		SendClientMessage(playerid, COLOR_ORANGE, "คุณได้เปิดการรับข้อความส่วนตัว");
		return 1;
	}
	else
	{
		PlayerInfo[playerid][pTogPm] = true;
		SendClientMessage(playerid, COLOR_ORANGE, "คุณได้ปิดการรับข้อความส่วนตัว");
	}
	return 1;
}

alias:quit("q")
CMD:quit(playerid, params[])
{
	if(IsPlayerAndroid(playerid))
	{
		CharacterSave(playerid);
		Kick(playerid);
		return 1;
	}
	return 1;
}

CMD:fines(playerid, params[])
{
	new factionid = PlayerInfo[playerid][pFaction];
	
	new tagerid;
	if(factionid != 0)
	{
		if(FactionInfo[factionid][eFactionJob] != POLICE && FactionInfo[factionid][eFactionJob] != SHERIFF)
			return ShowFines(playerid, playerid);

		if(sscanf(params, "i(-1)", tagerid))
			return ShowFines(playerid, playerid);
		
		if(!IsPlayerConnected(tagerid))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");

		if(IsPlayerLogin(tagerid))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

		ShowFines(playerid, tagerid);
		return 1;
	}
	else ShowFines(playerid, playerid);
	return 1;
}

CMD:helpme(playerid, params[])
{
	if(GetPVarInt(playerid, "HelpmeNows"))
		return SendErrorMessage(playerid, "คุณได้มีการ Helpme ไปแล้ว");

	
	if(isnull(params) || strlen(params) < 3)
		return SendUsageMessage(playerid, "/helpme <ข้อความ>"); 

	format(PlayerHelpme[playerid], 120, "%s",params);
	new idx;
	
	for (new i = 1; i < sizeof(HelpmeData); i ++)
	{
		if (HelpmeData[i][hHelpmeExit] == false)
		{
			idx = i;
			break; 
		}
	}




	SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER: คำขอความช่วยเหลือของคุณได้ถูกส่งไปยังผู้ดูแลทุกคนที่ออนไลน์");
	SetPVarInt(playerid, "HelpmeNows", 1);
	
	new str[60];
	format(str, sizeof(str), "[%s] %s Helpme now", ReturnDate(),ReturnRealName(playerid,0));
	SendDiscordMessageEx("support-chat", str);
			
	OnPlayerHelpme(playerid, idx, PlayerHelpme[playerid]);
	return 1;
}

CMD:setstyle(playerid, params[])
{
	if(!PlayerInfo[playerid][pDonater] && !PlayerInfo[playerid][pAdmin] && !PlayerInfo[playerid][pTester])
		return SendErrorMessage(playerid, "คุณไม่ใช่ Donater");

	new fightid;

	if(sscanf(params, "d", fightid))
		return SendUsageMessage(playerid, "/setstyle (1-6)");
	
	if(fightid < 1 || fightid > 6)
		return SendErrorMessage(playerid, "กรุณาใส่เลขให้ถูกต้อง (1-6)");

	switch(fightid)
	{
		case 1:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_NORMAL;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น ปกติ");
			CharacterSave(playerid);
			return 1;
		}
		case 2:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_BOXING;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น นักมวย");
			CharacterSave(playerid);
			return 1;
		}
		case 3:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_ELBOW;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น ใช้ศอก");
			CharacterSave(playerid);
			return 1;
		}
		case 4:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_GRABKICK;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น แกร๊บคิก");
			CharacterSave(playerid);
			return 1;
		}
		case 5:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_KNEEHEAD;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น หัวเข่า");
			return 1;
		}
		case 6:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_KUNGFU;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น กังฟู");
			CharacterSave(playerid);
			return 1;
		}
		default:
		{
			PlayerInfo[playerid][pFight] = FIGHT_STYLE_NORMAL;
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
			SendClientMessage(playerid, COLOR_GREY, "คุณได้เปลี่ยนท่าทางการสู้ของคุณเป็น ปกติ");
			CharacterSave(playerid);
			return 1;
		}
	}
	return 1;
}


CMD:cigarettes(playerid, params[])
{
	new option[11], secoption;

	if(sscanf(params, "s[11]D(-1)", option, secoption)) 
	{
		SendClientMessageEx(playerid,  -1, "{7e98b6}[!] {a9c4e4}คุณมีบุหรี่จำนวน %d มวน", PlayerInfo[playerid][pCigare]);
		SendClientMessage(playerid, -1, "{7e98b6}[!] การใช้งาน : {a9c4e4}/cigarettes use, give, drop & /passjoint");
		return 1;
	}

	if(!PlayerInfo[playerid][pCigare])
		return SendErrorMessage(playerid, "คุณไม่มีบุหรี่");

	if(CompareStrings(option, "use"))
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GREY, "คุณต้องอยู่บนพื้น");

		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		SendNearbyMessage(playerid, 3.2, COLOR_EMOTE, "> %s หยิบบุหรีออกมาหนึ่งม้วนพร้อมกับจุดแล้วคีบไว้ที่ปาก",ReturnName(playerid,0));
		SendClientMessage(playerid, -1, "{7e98b6}[!] {a9c4e4}กด ENTER เพื่อหยุดการสูบบุหรี่");
		PlayerInfo[playerid][pCigare]--;
		return 1;
	}
	else if(CompareStrings(option, "give"))
	{
		new userid, amount;

		if(sscanf(params, "{s[7]}ud", userid, amount)) 
			return SendClientMessage(playerid, -1, "{7e98b6}[!] การใช้งาน : {a9c4e4}/cigarettes give [ไอดีผู้เล่น/ชื่อบางส่วน] [จำนวน]");

		if(!IsPlayerConnected(userid))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซิร์ฟเวอร์");

		if(amount < 1)
			return SendErrorMessage(playerid, "คุณต้องระบุจำนวนมากกว่า 1");

		if (PlayerInfo[playerid][pCigare] < amount)
			return SendErrorMessage(playerid, "คุณมีบุหรี่ไม่เพียงพอ");
		
		if (!IsPlayerNearPlayer(playerid, userid, 5.0))
			return SendErrorMessage(playerid, "ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");
		
		if (userid == playerid)
			return SendErrorMessage(playerid, "คุณไม่สามารถให้บุหรี่กับตัวเองได้");

		PlayerInfo[playerid][pCigare] -= amount;
		PlayerInfo[userid][pCigare] += amount;
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s ให้บุหรี่กับ %s", ReturnName(playerid, 0), ReturnName(userid, 0));
		SendClientMessageEx(playerid, -1, "{7e98b6}[!] {a9c4e4}คุณให้บุหรี่กับ %s จำนวน {7e98b6}%d {a9c4e4}มวน", ReturnName(userid, 0), amount);
		SendClientMessageEx(userid, -1, "{7e98b6}[!] {a9c4e4}คุณได้รับบุหรี่จาก %s จำนวน {7e98b6}%d {a9c4e4}มวน", ReturnName(playerid, 0), amount);
		return 1;
	}
	else if(CompareStrings(option, "drop"))
	{
		new slot;

		if (sscanf(params, "{s[7]}d", slot)) 
			return SendClientMessage(playerid, -1, "{7e98b6}[!] การใช้งาน : {a9c4e4}/cigarettes drop [จำนวน]");
		
		if (PlayerInfo[playerid][pCigare] < slot)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีบุหรี่เพียงพอ");

		if (slot < 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องระบุจำนวนมากกว่า 1");

		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s ทิ้งบุหรี่ลงที่พื้น", ReturnRealName(playerid));

		SendClientMessageEx(playerid, -1, "{7e98b6}[!] {a9c4e4}คุณได้ทิ้งบุหรี่จำนวน %d มวน", slot);
		SendClientMessage(playerid, -1, "{7e98b6}[!] Hint: {a9c4e4}คุณสามารถซื้อบุหรี่เพิ่มได้จาก 24/7 หากคุณต้องการ");

		PlayerInfo[playerid][pCigare] -= slot;
		CharacterSave(playerid);
		return 1;
	}
	else SendErrorMessage(playerid, "คุณพิพม์คำสั่งไม่ถูกต้อง");

	return 1;
}

CMD:smoke(playerid, params[])
{
    new gesture;
    if(sscanf(params, "d", gesture)) 
		return SendUsageMessage(playerid,"/smoke [1-2]");

	if(!PlayerInfo[playerid][pCigare])
		return SendErrorMessage(playerid, "คุณไม่มีบุหรี่");

	switch(gesture)
	{
		case 1: 
		{
			ApplyAnimation(playerid,"SMOKING","M_smk_in",4.1, 0, 1, 1, 1, 1, 1);
		}
		case 2: 
		{
			ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 0, 1, 1, 1, 1, 1);
		}
		default: return SendUsageMessage(playerid,"/smoke [1-2]");
	}
    return 1;
}

CMD:checkcom(playerid, params[])
{
	new count;
	for(new i = 1; i < MAX_COMPUTER; i++)
	{
		if(!ComputerInfo[i][ComputerDBID])
			continue;

		if(ComputerInfo[i][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
			continue;

		count++;
		SendClientMessageEx(playerid, COLOR_GREY, "COMPUTER ID %d: Spawn: %s",ComputerInfo[i][ComputerDBID], (ComputerInfo[i][ComputerSpawn] != 0) ? (""EMBED_GREENMONEY"วางอยู่") : ("ยังไม่ได้วาง"));
	}

	if(!count)
		return SendClientMessage(playerid, COLOR_GREY, "คุณยังไม่มีการซื้อคอมพิวเตอร์");

	
	return 1;
}

CMD:helpup(playerid, params[])
{
	new tagerid;

	if(sscanf(params, "u", tagerid))
		return SendUsageMessage(playerid, "/helpup <ชื่อบางส่วน/ไอดี>");

	if(tagerid == playerid)
		return SendErrorMessage(playerid, "ไม่สามารถใช้กับตัวเองได้");

	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[tagerid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
	if(!IsPlayerNearPlayer(playerid, tagerid, 2.5))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

	if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD || GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
		return SendErrorMessage(playerid, "คุณไม่สามารถช่วยได้เนืองจากคุณเองก็มีสภาพร่างกายไม่พร้อม และต้องการการรักษาอย่างด่วนเช่นกัน");

	
	if(GetPlayerTeam(tagerid) == PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้รับบาดเจ็บขนาดขั้นเสียชีวิต");

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_DEAD)
		return SendErrorMessage(playerid, "ผู้เล่นเสียชีวิตแล้ว");

	if(PlayerHelpUp[tagerid])
		return SendErrorMessage(playerid, "มีการช่วยเหลืออยู่...");

	SendClientMessageEx(playerid, -1, "คุณกำลังช่วยเหลือ %s ห้ามขยับหรืออกไปไหน ในระหว่างการช่วยเหลือ", ReturnName(tagerid,0));
	PlayerHelpUp[tagerid] = true;
	SetTimerEx("HelpUpPLayer", 15000, false, "dd",playerid, tagerid);
	return 1;
}

CMD:id(playerid, params[])
{
	new tagerid;

	if(sscanf(params, "u", tagerid))
		return SendUsageMessage(playerid, "/id <ชื่อบางส่วน/ไอดี>");

	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์");
		
	if(!BitFlag_Get(gPlayerBitFlag[tagerid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	SendClientMessageEx(playerid, COLOR_GREY, "[ID: %d] ชื่อ: %s เล่นผ่าน: %s", tagerid,ReturnRealName(tagerid,0), (IsPlayerAndroid(tagerid)) ? ("Android") : ("PC"));
	return 1;
}

CMD:setstation(playerid, params[])
{
	new option[15],url[400], secstr[150];

	if(sscanf(params, "s[15]S()[150]", option,secstr)) 
	{
		SendUsageMessage(playerid, "/setstation <option>");
		SendClientMessage(playerid, -1, "ลิ้งค์สำหรับการแปลง: https://vocaroo.com/upload");
		SendClientMessage(playerid, -1, "วิธีการใช้คือ อัปโหลดเพลงที่ต้องการจากคอมพิวเตอร์ของคุณลงไปในลิ้งค์นี้");
		SendClientMessage(playerid, -1, "และนำลิ้งค์นั้นมาเป็นลิ้งในการเปิดเพลง");
		SendClientMessage(playerid, COLOR_GREY, "OPTION: Close Open");
		return 1;
	}

	if(!strcmp(option, "close", true))
	{
		if(PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pInsideProperty];

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideProperty] != PlayerInfo[playerid][pInsideProperty])
					continue;

				StopAudioStreamForPlayer(i);
			}

			HouseInfo[id][HouseMusic] = true;
			format(HouseInfo[id][HouseMusicLink], 150, "");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		if(GetPlayerVehicleID(playerid) != 0)
		{
			foreach(new i : Player)
			{
				if(GetPlayerVehicleID(i) != GetPlayerVehicleID(playerid))
					continue;

				StopAudioStreamForPlayer(i);
			}
			new vehicleid = GetPlayerVehicleID(playerid);
			VehicleInfo[vehicleid][eVehicleMusic] = false;
			format(VehicleInfo[vehicleid][eVehicleMusicLink],1,"");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pInsideBusiness])
		{
			new id = PlayerInfo[playerid][pInsideBusiness];

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideBusiness] != PlayerInfo[playerid][pInsideBusiness])
					continue;

				StopAudioStreamForPlayer(i);
			}

			BusinessInfo[id][BusinessMusic] = true;
			format(BusinessInfo[id][BusinessMusicLink], 150, "");
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้ปิดเครื่องเล่นวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pBoomBoxSpawnID] && !PlayerInfo[playerid][pInsideBusiness] && !PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pBoomBoxSpawnID];
			if(IsPlayerInRangeOfPoint(playerid, 2.5, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
			{
				foreach(new i : Player)
				{
					if(!IsPlayerInRangeOfPoint(i, 35.0, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
						continue;

					StopAudioStreamForPlayer(i);
				}
			}
			SendNearbyMessage(playerid, 15.5, COLOR_EMOTE, "> %s ได้ปิดสถานีวิทยุ", ReturnName(playerid,0));
		}
		else SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้ บ้าน / กิจการ / BoomBox");
	}
	else if(!strcmp(option, "open", true))
	{
		if(sscanf(secstr, "s[400]",url))
			return SendUsageMessage(playerid, "/setstaion <open> <url>");
	
		if(PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pInsideProperty];

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideProperty] != PlayerInfo[playerid][pInsideProperty])
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}

			HouseInfo[id][HouseMusic] = true;
			format(HouseInfo[id][HouseMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(GetPlayerVehicleID(playerid) != 0)
		{
			if(HasNoEngine(GetPlayerVehicleID(playerid)))
				return SendErrorMessage(playerid, "ไม่มีเครื่องยนต์");

			if(!VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleEngineStatus])
				return SendErrorMessage(playerid, "ต้องติดเครื่องยนต์ก่อน");

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");

			foreach(new i : Player)
			{
				if(GetPlayerVehicleID(i) != GetPlayerVehicleID(playerid))
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}
			new vehicleid = GetPlayerVehicleID(playerid);
			VehicleInfo[vehicleid][eVehicleMusic] = true;
			format(VehicleInfo[vehicleid][eVehicleMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
			return 1;
		}
		else if(PlayerInfo[playerid][pInsideBusiness])
		{
			new id = PlayerInfo[playerid][pInsideBusiness];

			if(strlen(url) < 5)
				return SendErrorMessage(playerid, "กรุณาใส่ลิ้งค์ที่ถูกต้อง");


			if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
				return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการนี้");

			foreach(new i : Player)
			{
				if(PlayerInfo[i][pInsideBusiness] != PlayerInfo[playerid][pInsideBusiness])
					continue;

				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);
			}

			BusinessInfo[id][BusinessMusic] = true;
			format(BusinessInfo[id][BusinessMusicLink], 150, "%s",url);
			SendNearbyMessage(playerid, 30.5, COLOR_EMOTE, "> %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
		}
		else if(PlayerInfo[playerid][pBoomBoxSpawnID] && !PlayerInfo[playerid][pInsideBusiness] && !PlayerInfo[playerid][pInsideProperty])
		{
			new id = PlayerInfo[playerid][pBoomBoxSpawnID];
			if(IsPlayerInRangeOfPoint(playerid, 2.5, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
			{
				foreach(new i : Player)
				{
					if(!IsPlayerInRangeOfPoint(i, 35.0, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2]))
						continue;

					StopAudioStreamForPlayer(i);
					PlayAudioStreamForPlayer(i, url, BoomBoxInfo[id][BoomBoxPos][0], BoomBoxInfo[id][BoomBoxPos][1], BoomBoxInfo[id][BoomBoxPos][2], 35.0,1);
				}
				SendNearbyMessage(playerid, 15.5, COLOR_EMOTE, "> %s ได้เปลี่ยนสถานีวิทยุ", ReturnName(playerid,0));
				return 1;
			}
		}
		else SendErrorMessage(playerid, "คุณไมได้อยู่ใกล้ บ้าน / กิจการ / BoomBox");
	}
	else SendErrorMessage(playerid, "กรุณาพิพม์ให้ถูกต้อง");
    return 1;
}

CMD:close(playerid, params[])
{
	if(PlayerInfo[playerid][pGUI] != 6)
		return 1;

	PlayerInfo[playerid][pGUI] = 6;
	MenuStore_Close(playerid);
	return 1;
}


CMD:frisk(playerid, params[])
{
	/*if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้ได้ในขณะที่คุณไม่ได้อยู่ในสถาณะปกติ");*/

	new tagerid, option[20];
	if(sscanf(params, "uS()[20]", tagerid, option))
		return SendUsageMessage(playerid, "/frisk <ชื่อบางส่วน/ไอดี>");

	/*if(GetPlayerTeam(tagerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้ได้หากผู้เล่นอีกฝ่ายไม่ได้อยู่ในสถาณะปกติ");*/

	if(FriskInfo[playerid][Frisk_ID] != INVALID_PLAYER_ID)
	{
		if(!IsPlayerNearPlayer(playerid, FriskInfo[playerid][Frisk_ID], 3.5))
		{
			FriskInfo[playerid][Frisk_ID] = 0;

			if(!IsPlayerConnected(tagerid))
				return SendErrorMessage(playerid, "ผู้เล่นไม่อยู่ภายในเซิร์ฟเวอร์");

			if(IsPlayerLogin(playerid))
				return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

			if(!IsPlayerNearPlayer(playerid, tagerid, 3.5))
				return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

			FriskInfo[playerid][Frisk_ID] = tagerid;
			FriskInfo[tagerid][Frisk_BY] = playerid;
			SendClientMessageEx(tagerid, COLOR_LIGHTRED, "%s ได้ขอค้นภายในตัวของคุณ /frisk %d yes หากคุณยอมรับ",playerid,ReturnName(playerid,0));
			SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ขอค้นตัวของ %s",ReturnName(tagerid,0));
			return 1;
		}
		else SendErrorMessage(playerid, "คุณยังมีคำขอค้นตัวอีกคนอยู่");
	}
	else
	{
		if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่อยู่ภายในเซิร์ฟเวอร์");

		if(IsPlayerLogin(playerid))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

		if(!IsPlayerNearPlayer(playerid, tagerid, 3.5))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

		if(tagerid == FriskInfo[playerid][Frisk_BY])
		{
			if(!strcmp(option, "no", true))
			{
				SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ปฏิเสธ %s ในการค้นภายในตัวของคุณ",ReturnName(tagerid,0));
				SendClientMessageEx(tagerid, COLOR_GREY, "%s ปฏิเสธในการค้นไปภายในตัว", ReturnName(playerid,0));


				FriskInfo[playerid][Frisk_ID] = INVALID_PLAYER_ID;
				FriskInfo[playerid][Frisk_BY] = INVALID_PLAYER_ID;
				FriskInfo[tagerid][Frisk_ID] = INVALID_PLAYER_ID;
				FriskInfo[tagerid][Frisk_BY] = INVALID_PLAYER_ID;
				return 1;
			}
			else if(!strcmp(option, "yes", true))
			{
				SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ยอมรับให้ %s ค้นภายในตัวของคุณ",ReturnName(tagerid,0));
				SendClientMessageEx(tagerid, COLOR_HELPME, "คุณได้เริ่มค้นไปภายในตัวของ %s", ReturnName(playerid,0));

				ShowInvPlayer(tagerid, playerid);

				FriskInfo[playerid][Frisk_ID] = INVALID_PLAYER_ID;
				FriskInfo[playerid][Frisk_BY] = INVALID_PLAYER_ID;
				FriskInfo[tagerid][Frisk_ID] = INVALID_PLAYER_ID;
				FriskInfo[tagerid][Frisk_BY] = INVALID_PLAYER_ID;
			}
			else SendErrorMessage(playerid, "ใส่ให้ถูกต้อง (yes or no)");
			return 1;
		}

		FriskInfo[playerid][Frisk_ID] = tagerid;
		FriskInfo[tagerid][Frisk_BY] = playerid;
		SendClientMessageEx(tagerid, COLOR_LIGHTRED, "%s ได้ขอค้นภายในตัวของคุณ /frisk %d yes หากคุณยอมรับ",ReturnName(playerid,0),playerid);
		SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ขอค้นตัวของ %s",ReturnName(tagerid,0));
	}
	return 1;
}

CMD:walkstyle(playerid, params[])
{
	if(!PlayerInfo[playerid][pDonater] && !PlayerInfo[playerid][pAdmin])
		return SendErrorMessage(playerid, "คุณไม่ใช่ Donater");

	new id;

	if(sscanf(params, "d", id))
		return SendUsageMessage(playerid, "/walkstyle <1-18>");

	if(id < 1 || id > 18)
		return SendErrorMessage(playerid, "คุณได้ใส่หมายเลข ท่าทางการเดินไม่ถูกต้อง (1-18)");

	PlayerInfo[playerid][pWalk] = id;

	Player_SetWalkingStyle(playerid, id);
	SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ตั้งค่าท่าทางการเดินของคุณไปที่ %d",id);
	return 1;
}

CMD:walk(playerid, params[])
{
	switch(PlayerInfo[playerid][pWalk])
	{
		case 1: ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
		case 2: ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1);
		case 3: ApplyAnimation(playerid,"PED","WALK_armed",4.1,1,1,1,1,1);
		case 4: ApplyAnimation(playerid,"PED","WALK_civi",4.1,1,1,1,1,1);
		case 5: ApplyAnimation(playerid,"PED","WALK_csaw",4.1,1,1,1,1,1);
		case 6: ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
		case 7: ApplyAnimation(playerid,"PED","WALK_drunk",4.1,1,1,1,1,1);
		case 8: ApplyAnimation(playerid,"PED","WALK_fat",4.1,1,1,1,1,1);
		case 9: ApplyAnimation(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1);
		case 10: ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
		case 11: ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,1);
		case 12: ApplyAnimation(playerid,"PED","WALK_rocket",4.1,1,1,1,1,1);
		case 13: ApplyAnimation(playerid,"PED","WALK_shuffle",4.1,1,1,1,1,1);
		case 14: ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
		case 15: ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
		case 16: ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1);
		case 17: ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
		case 18: ApplyAnimation(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1);
		default: ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,1);
	}
	return 1;
}

CMD:tackle(playerid, params[]) {
	if(GetPVarType(playerid, "TacklingMode")) {
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] "EMBED_WHITE"โหมดการเข้าปะทะถูกปิด");
		DeletePVar(playerid, "TacklingMode");
	}
	else {
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] "EMBED_WHITE"โหมดการเข้าปะทะถูกเปิด");
		SendClientMessage(playerid, COLOR_LIGHTRED, "หากคุณชกใครสักคน มันจะเป็นการพยายามเข้าปะทะ");
		SendClientMessage(playerid, COLOR_LIGHTRED, "ผู้เล่นที่คุณชกจะได้รับข้อความ แสดงให้เห็นการพยายามที่จะเข้าปะทะนี้");
		SendClientMessage(playerid, COLOR_LIGHTRED, "อารมณ์จะถูกส่งไปยังแชทผู้เล่นอื่นเพื่อแจ้งเตือนเกี่ยวกับการพยายาม");
		SendClientMessage(playerid, COLOR_LIGHTRED, "คุณจะถูกบังคับให้เล่นอนิเมชั่นกระโดดน้ำเพื่อป้องกันการพิมพ์คำสั่งผิดพลาด");
		SendClientMessage(playerid, COLOR_LIGHTRED, "หากผู้เล่นนั้นไม่เล่นบทการเข้าปะทะ รายงานภายในเกมได้เลย");
		SetPVarInt(playerid, "TacklingMode", 1);
	}
	return 1;
}

CMD:coin(playerid, params[])
{
	new str[128];
	format(str, sizeof(str), "> %s พลิกเหรียญลงพื้นและมันออก%s", ReturnRealName(playerid), (random(2)) ? ("หัว") : ("ก้อย"));
    SendNearbyMessage(playerid, 15.0, COLOR_EMOTE, str);
	return 1;
	
}

CMD:shakehand(playerid, params[])
{
	new targetid, type;

	if(sscanf(params, "ui", targetid, type))
	    return SendUsageMessage(playerid, "/shakehand <ชื่อบางส่วน/ไอดี> <ประเภท (1-6)>");

	if(!IsPlayerConnected(targetid) || !IsPlayerNearPlayer(playerid, targetid, 1.5))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์/หรือไม่ได้อยู่ใกล้คุณ");
	}
	if(targetid == playerid)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "คุณไม่สามารถใช้คำสั่งนี้กับตัวคุณเองได้");
	}

	if(PlayerInfo[playerid][pShakeOffer] != INVALID_PLAYER_ID)
	{
		new offeredby = PlayerInfo[playerid][pShakeOffer];

	    if(offeredby == INVALID_PLAYER_ID)
	    {
	        return SendClientMessage(playerid, COLOR_GREY, "ไม่ได้มีการส่งขอคำมาให้คุณ");
	    }

	    ClearAnimations(playerid);
		ClearAnimations(offeredby);

		SetPlayerToFacePlayer(playerid, offeredby);
		SetPlayerToFacePlayer(offeredby, playerid);

		switch(PlayerInfo[playerid][pShakeType])
		{
		    case 1:
		    {
				ApplyAnimation(playerid,  "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimation(offeredby, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 2:
			{
				ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimation(offeredby, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 3:
			{
				ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimation(offeredby, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 4:
			{
				ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimation(offeredby, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 5:
			{
				ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
				ApplyAnimation(offeredby, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
			}
			case 6:
			{
			    ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0);
			    ApplyAnimation(offeredby, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0);
			}
		}
  		PlayerInfo[playerid][pShakeOffer] = INVALID_PLAYER_ID;
		return 1;
	}

	if(!(1 <= type <= 6))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "คุณเลือกประเภทไม่ถูกต้อง 1-6 เท่านั้น");
	}

	PlayerInfo[targetid][pShakeOffer] = playerid;
	PlayerInfo[targetid][pShakeType] = type;

	SendClientMessageEx(targetid, COLOR_WHITE, "** %s ต้องการที่จะจับมือกับคุณ (/shakehand %d)", ReturnName(playerid, 0), playerid);
	SendClientMessageEx(playerid, COLOR_WHITE, "** คุณได้ส่งคำขอการจับมือกับ %s", ReturnName(targetid, 0));
	return 1;
}

CMD:isafk(playerid, params[])
{
	new 
		playerb;
		
	if(sscanf(params, "u", playerb))
		return SendUsageMessage(playerid, "/isafk <ชื่อบางส่วน/ไอดี>");
		
	if(!IsPlayerConnected(playerb))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");
	
	if(IsAfk{playerb})
		SendClientMessageEx(playerid, COLOR_GREY, "%s AFK %d วินาที", ReturnName(playerb), AFKCount[playerb]);
		
	else SendClientMessageEx(playerid, COLOR_GREY, "ผู้เล่นไม่ได้ AFK.", ReturnName(playerb)); 

	return 1;
}

CMD:meal(playerid, params[])
{
	new
	    type[24],
		menuid,
		value;

	if (sscanf(params, "s[24]D()D()", type, menuid, value))
 	{
	    SendClientMessage(playerid, COLOR_GRAD3, "Available commands:");
	    SendClientMessage(playerid, -1, "{FF6347}/meal order "EMBED_WHITE"- เปิดเมนูสั่งอาหาร");
        SendClientMessage(playerid, -1, "{FF6347}/meal place "EMBED_WHITE"- หากคุณกำลังถือถาดอาหาร คุณสามารถวางมันบนโต๊ะได้");
        SendClientMessage(playerid, -1, "{FF6347}/meal pickup "EMBED_WHITE"- คุณสามารถหยิบถาดอาหารของคุณที่วางอยู่ได้");
        SendClientMessage(playerid, -1, "{FF6347}/meal throw "EMBED_WHITE"- โยนถาดอาหารทิ้ง");
		return 1;
	}
	if (!strcmp(type, "order", true))
	{	
		callcmd::eat(playerid, "");
	}
	else if (!strcmp(type, "place", true))
	{
		if(MealOder[playerid] == false || PlayerInfo[playerid][pObject][9] != INVALID_OBJECT_ID)
			return SendErrorMessage(playerid, "คุณยังไม่ได้ซื้ออาหาร / หรือมีถาดอาหารที่ยังไม่ได้ทิ้ง");
		
		if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
			RemovePlayerAttachedObject(playerid, 9);

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		PlayerInfo[playerid][pObject][9] = CreateDynamicObject(2222, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		EditDynamicObject(playerid, PlayerInfo[playerid][pObject][9]);
		SetPVarInt(playerid, "MealEditPosObj", 1);

		return 1;
	}
	else if (!strcmp(type, "pickup", true))
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(PlayerInfo[playerid][pObject][9], x, y, z);

		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
		{
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ถาดอาหารของคุณ");
		}

		if(IsValidDynamicObject(PlayerInfo[playerid][pObject][9]))
            DestroyDynamicObject(PlayerInfo[playerid][pObject][9]);
		
		GetMealOder(playerid);
		return 1;
	}
	else if (!strcmp(type, "throw", true))
	{
		if(MealOder[playerid] == false)
			return SendErrorMessage(playerid, "คุณยังไม่ได้ซื้ออาหาร / หรือมีถาดอาหารที่ยังไม่ได้ทิ้ง");

		if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
			RemovePlayerAttachedObject(playerid, 9);
		
		MealOder[playerid] = false;
		SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s โยนถาดอาหารทิ้ง",ReturnName(playerid,0));
		return 1;
	}
	else SendErrorMessage(playerid, "พิพม์คำสั่งไม่ถูกต้อง");
	return 1;
}

alias:hidehud("toghud")
CMD:hidehud(playerid, params[])
{
	if(GetPVarInt(playerid, "HideHud"))
	{
		ShowHudVehicle(playerid, false);
		DeletePVar(playerid, "HideHud");
		
	}
	else
	{
		SetPVarInt(playerid, "HideHud", 1);
		ShowHudVehicle(playerid, true);
	}
	return 1;
}

CMD:dice(playerid, params[])
{
	new str[128];
	format(str, sizeof(str), "> %s ทอยลูกเต๋าและมันออก %d", ReturnRealName(playerid), random(6)+1);
    SendNearbyMessage(playerid, 15.0, COLOR_EMOTE, str);
	return 1;
}

CMD:rnumber(playerid, params[])
{
	new
	    rmin,
	    rmax,
		emote[128],
		str[128];

	if (sscanf(params, "dds[128]", rmin, rmax, emote))
	    return SendSyntaxMessage(playerid, "/rnumber <min> <max> [อารมณ์]");

	if(rmin >= rmax) {
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "ตัวเลขต่ำสุดต้องน้อยกว่าตัวเลขสูงสุด");
	}

	format(str, sizeof(str), "> %s %s %d (( %d ถึง %d ))", ReturnRealName(playerid), emote, randomEx(rmin, rmax), rmin, rmax);
    SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, str);
	return 1;
}

alias:whisper("w")
CMD:whisper(playerid, params[])
{
	new tagerid, text[128];

	if(sscanf(params, "us[128]", tagerid, text))
	    return SendSyntaxMessage(playerid, "/(w)hisper <ไอดีผู้เล่น/ชื่อบางส่วน> <ข้อความ>");
	
	if(!IsPlayerConnected(tagerid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซิร์ฟเวอร์");
	
	if (!IsPlayerNearPlayer(playerid, tagerid, 3.0))
	    return SendErrorMessage(playerid,"ผู้เล่นนั้นไม่ได้อยู่ใกล้คุณ");
	
	if (tagerid == playerid)
		return SendErrorMessage(playerid, "คุณไม่สามารถกระซิบกับตัวเองได้");
	

	if (strlen(text) > 80) {
	    SendClientMessageEx(tagerid, COLOR_YELLOW, "%s กระซิบ: %.80s", ReturnRealName(playerid), text);
	    SendClientMessageEx(tagerid, COLOR_YELLOW, "... %s **", text[80]);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "กระซิบถึง %s", ReturnRealName(tagerid));
	}
	else {
	    SendClientMessageEx(tagerid, COLOR_YELLOW, "%s กระซิบ: %s", ReturnRealName(playerid), text);
	    SendClientMessageEx(playerid, COLOR_YELLOW, "กระซิบถึง %s", ReturnRealName(tagerid));
	}
	//format(text, sizeof(text), "กระซิบ %s: %s", ReturnPlayerName(userid), text);
	//SQL_LogChat(playerid, "/w", text);
	
	format(text, sizeof(text), "%s พึมพำบางอย่าง", ReturnRealName(playerid));
	SetPlayerChatBubble(playerid, text, COLOR_PURPLE, 30.0, 6000);
	return 1;
}


CMD:cw(playerid, params[])
{
	new text[128], vehicle = GetPlayerVehicleID(playerid);

    if (sscanf(params, "s[128]", text))
	    return SendSyntaxMessage(playerid, "/(cw)hisper [ข้อความ]");

	if (!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GRAD1, "คุณไม่ได้อยู่บนรถ!");

	foreach (new i : Player)
	{
	    if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicle) {
		    if (strlen(text) > 80) {
			    SendClientMessageEx(i, 0xD7DFF3AA, "%s %s พูดว่า: %.80s", (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) ? ("คนขับ"): ("ผู้โดยสาร"), ReturnRealName(playerid), text);
			    SendClientMessageEx(i, 0xD7DFF3AA, "... %s", text[80]);
			}
			else {
			    SendClientMessageEx(i, 0xD7DFF3AA, "%s %s พูดว่า: %s", (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) ? ("คนขับ"): ("ผู้โดยสาร"), ReturnRealName(playerid), text);
			}
		}
	}

	//SQL_LogChat(playerid, "/cw", text);
	return 1;
}


CMD:guied(playerid, params[])
{
	ShowPlayerGuid(playerid);
	return 1;
}


CMD:pullincar(playerid, params[])
{
	new
		userid,
		seatname[16],
		vehicleid = GetNearestVehicle(playerid);

	if (sscanf(params, "us[16]", userid, seatname))
	    return SendSyntaxMessage(playerid, "/pullincar [ไอดีผู้เล่น/ชื่อบางส่วน] [fr (หน้าขวา) / bl (หลังซ้าย) / br (หลังขวา)]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ในเซิร์ฟเวอร์");
	
	if(userid == playerid) return SendClientMessage(playerid, COLOR_GRAD2, "คุณไม่สามารถโยนตัวเองได้");

	if (vehicleid == INVALID_VEHICLE_ID)
	    return SendClientMessage(playerid, COLOR_GRAD2, "คุณไม่ได้อยู่ใกล้ยานพาหนะใด ๆ");
	    
    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return SendClientMessage(playerid, COLOR_GRAD2, "คุณไม่ได้อยู่ใกล้ผู้เล่นนั้น");

	if (GetVehicleMaxSeats(vehicleid) < 2)
  	    return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่สามารถดึงตัวผู้เล่นนั้นในยานพาหนะนี้ได้");

	new seatid = -1;
	if(!strcmp(seatname, "หน้าขวา", true) || !strcmp(seatname, "fr", true)) {
	    if ((seatid = GetAvailableSeat(vehicleid, 1)) == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "ที่นั่งนี้ไม่ว่าง");
	}
	else if(!strcmp(seatname, "หลังซ้าย", true) || !strcmp(seatname, "bl", true)) {
	    if ((seatid = GetAvailableSeat(vehicleid, 2)) == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "ที่นั่งนี้ไม่ว่าง");
	}
	else if(!strcmp(seatname, "หลังขวา", true) || !strcmp(seatname, "br", true)) {
	    if ((seatid = GetAvailableSeat(vehicleid, 3)) == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "ที่นั่งนี้ไม่ว่าง");
	}
	else {
		return SendSyntaxMessage(playerid, "/pullincar [ไอดีผู้เล่น/ชื่อบางส่วน] [fr (หน้าขวา) / bl (หลังซ้าย) / br (หลังขวา)]");
	}

	PutPlayerInVehicle(userid, vehicleid, seatid);
	return 1;
}

CMD:eject(playerid, params[]) {
	new
		targetID;

	if(sscanf(params, "u", targetID))
		return SendSyntaxMessage(playerid, "/eject [ไอดีผู้เล่น/ชื่อบางส่วน]");

	if(!IsPlayerConnected(targetID))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ในเซิร์ฟเวอร์");

	if(targetID == playerid) return SendClientMessage(playerid, COLOR_GRAD2, "คุณไม่สามารถไล่ตัวเองได้");
	    
	if(GetPlayerState(playerid) == 2) {
		if(GetPlayerVehicleID(playerid) == GetPlayerVehicleID(targetID)) {

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ได้ผลัก %s ออกจากพาหนะ", ReturnRealName(playerid), ReturnRealName(targetID));
			RemovePlayerFromVehicle(targetID);
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "ผู้เล่นนี้ไม่ได้อยู่ภายในพาหนะ");
	}
	else SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องอยู่ในสถานะผู้ขับรถ");
	
	return 1;
}

randomEx(min, max)
{
    new rand = random(max-min)+min;
    return rand;
}

stock ShowInvPlayer(tagerid, playerid)
{
	new weapon_id[2][13];

	SendClientMessageEx(tagerid, -1, "FRISK : %s",ReturnName(playerid,0));

	ReturnLicenses(playerid, tagerid);

	if(PlayerInfo[playerid][pCash] > 500)
	{
		SendClientMessage(tagerid, -1, "เงินภายในตัว: มากกว่า $500");
	}
	else SendClientMessage(tagerid, -1, "เงินภายในตัว: น้อยกว่า $500");

	SendClientMessage(tagerid, COLOR_DARKGREEN, "______________WEAPONS_____________"); 
	for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon_id[0][i], weapon_id[1][i]); 
		
		if(!weapon_id[0][i])
			continue;
			
		SendClientMessageEx(tagerid, COLOR_GRAD1, "%s", ReturnWeaponName(weapon_id[0][i]), weapon_id[1][i]); 
	}

	if(PlayerInfo[playerid][pDrug][0] && PlayerInfo[playerid][pDrug][1] && PlayerInfo[playerid][pDrug][2])
	{
		SendClientMessage(tagerid, COLOR_GREY, "มียาเสพติดภายในตัว");
	}
	else SendClientMessage(tagerid, COLOR_GREY, "ไม่มียาเสพติดภายในตัว");
	return 1;
}

forward HelpUpPLayer(playerid, tagerid);
public HelpUpPLayer(playerid, tagerid)
{
	if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD || GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "การช่วยเหลือไม่สำเร็จเนื่องจากคุณได้เสียชีวิตก่อน");
		PlayerHelpUp[tagerid] = false;
		return 1;
	}

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_ALIVE)
	{
		PlayerHelpUp[tagerid] = false;
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้รับบาจเจ็บขนาดขั้นเสียชีวิต");
	}

	if(GetPlayerTeam(tagerid) == PLAYER_STATE_DEAD)
	{
		SendErrorMessage(playerid, "ผู้เล่นเสียชีวิตแล้ว");
		PlayerHelpUp[tagerid] = false;
		return 1;
	}

	if(!IsPlayerNearPlayer(playerid, tagerid, 2.5))
	{
		PlayerHelpUp[tagerid] = false;
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");
	}

	SetPlayerTeam(tagerid, PLAYER_STATE_ALIVE); 
	SetPlayerHealth(tagerid, 10); 
	TogglePlayerControllable(tagerid, 1); 
	SetPlayerWeather(tagerid, globalWeather);  
	PlayerHelpUp[tagerid] = false;
	SendNearbyMessage(playerid, 3.5, COLOR_EMOTE, "> %s ปฐมพยาบาลเบื่องต้นให้กับ %s",ReturnName(playerid,0), ReturnName(tagerid,0));

	new str[150];
	format(str, sizeof(str), "%s Helpup %s", ReturnRealName(playerid,0), ReturnRealName(tagerid,0));
	SendDiscordMessage("death", str);
	return 1;
}



stock OnPlayerHelpme(playerid, reportid, text[])
{
	if(HelpmeData[reportid][hHelpmeExit] == true)
	{
		for (new i = 1; i < sizeof(PlayerHelpme); i ++)
		{
			if(HelpmeData[i][hHelpmeExit] == false)
			{
				reportid = i;
				break;
			}
		}
	}
	
	HelpmeData[reportid][hHelpmeDBID] = reportid;
	HelpmeData[reportid][hHelpmeExit] = true;
		
	format(HelpmeData[reportid][hHelpmeDetel], 90, "%s", text);
	HelpmeData[reportid][hHelpmeBy] = playerid;
		
	SendTesterMessageEx(COLOR_YELLOWEX, "%s(ID: %d) ขอความช่วยเหลือ: %.40s... สามารถรับได้โดยการ /helpmes accept %d เพื่อรับ", ReturnRealName(playerid,0), playerid, HelpmeData[reportid][hHelpmeDetel], HelpmeData[reportid][hHelpmeDBID]);
		
	if(strfind(text, "hack", true) != -1 || strfind(text, "cheat", true) != -1)
	{
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin] || PlayerInfo[i][pTester]) GameTextForPlayer(i, "~y~~h~Priority Report", 4000, 1);
		}
	}
	return 1;
}

stock ClearHelpme(reportid)
{
	HelpmeData[reportid][hHelpmeExit] = false;
	HelpmeData[reportid][hHelpmeDBID] = 0;
    HelpmeData[reportid][hHelpmeBy] = INVALID_PLAYER_ID;
    HelpmeData[reportid][hHelpmeDetel] = ' ';
	return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerInfo[playerid][pGUI] == 6)
	{
		if(RELEASED(KEY_CTRL_BACK))
		{
			PlayerInfo[playerid][pGUI] = 0;
			MenuStore_Close(playerid);
			return 1;
		}
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	new str[120];
	
	for(new i = 1; i < sizeof(HelpmeData); i++)
    {
        if(HelpmeData[i][hHelpmeExit] == true)
        {
			if(HelpmeData[i][hHelpmeBy] == playerid)
			{
				ClearHelpme(i);

				format(str, sizeof(str), "[%s] %s Disconnect Helpme therefore deleted %s",ReturnDate(),ReturnRealName(playerid,0));
				SendDiscordMessageEx("support-chat",str);
				DeletePVar(playerid, "HelpmeNows");
			}
        }
    }

	if(GetPVarInt(playerid, "HideHud"))
        ShowHudVehicle(playerid, false);

	
	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{
			if(GetPVarType(issuerid, "TacklingMode") && weaponid == 0) 
			{
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s วิ่งไปที่ %s และพยายามที่จะเข้าปะทะให้ลงไปนอนกับพื้น", ReturnRealName(issuerid), ReturnRealName(playerid));
				ApplyAnimation(issuerid, "PED", "EV_dive",4.1,0,1,1,1,0);
				ApplyAnimation(playerid, "PED", "FLOOR_hit_f",4.1,0,1,1,1,0);
				return 0;
			}
		}
	}
	return 1;
}
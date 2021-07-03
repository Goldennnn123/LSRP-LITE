/**
 *  ให้ค่าประสบการณ์กับผู้เล่นพร้อมอัปเดต UI
 * @param {amount} เลขจำนวนเต็ม
 * ใช้ฟังก์ชั่น UpdatePlayerEXPBar ที่อยู่ใน ui.pwn
 */
#include <YSI_Coding\y_va>

static
    chat_msgOut[144];




new bool:IsAfk[MAX_PLAYERS char];
new AFKTimer[MAX_PLAYERS];
new AFKCount[MAX_PLAYERS];

hook OnPlayerUpdate(playerid)
{
    AFKTimer[playerid] = 3;
    return 1;
}

ptask @2PlayerTimer[1000](playerid)
{
    if(AFKTimer[playerid] > 0)
	{
		AFKTimer[playerid]--;
		if(AFKTimer[playerid] <= 0)
		{
			AFKTimer[playerid] = 0;
			AFKCount[playerid]=1;
			IsAfk{playerid} = true;
		}
		else IsAfk{playerid} = false;
        
	}
    else {
			AFKCount[playerid]++;
		}
    return 1;
}


stock PlayerSpec(playerid, playerb)
{
	
	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER || GetPlayerState(playerb) == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerb);

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			SendServerMessage(playerid, "ตอนนี้คุณกำลังส่องผู้เล่น %s  /specoff เพื่ออยุดส่อง", ReturnName(playerb));
		}
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectateVehicle(playerid, vehicleid);
			
		PlayerInfo[playerid][pSpectating] = playerb; 
		return 1;
	}
	else
	{	
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			SendServerMessage(playerid, "ตอนนี้คุณกำลังส่องผู้เล่น %s  /specoff เพื่ออยุดส่อง", ReturnName(playerb));
		}
		
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		
		TogglePlayerSpectating(playerid, true); 
		PlayerSpectatePlayer(playerid, playerb);
			
		PlayerInfo[playerid][pSpectating] = playerb; 
		return 1;
	}
}


stock GivePlayerExp(playerid, amount = 1) {
	PlayerInfo[playerid][pExp] += amount;

	new levelup = GetPlayerMaxEXP(playerid);

	if (PlayerInfo[playerid][pExp] >= levelup) {
		PlayerInfo[playerid][pExp] = levelup - PlayerInfo[playerid][pExp];
		PlayerInfo[playerid][pLevel]++;
	}

	#if defined USE_EXP_BAR
	UpdatePlayerEXPBar(playerid);
	#endif
}


stock IsPlayerLogin(playerid)
{
	if(BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		return 0;

	if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		return 1;

	return 1;
}

/**
 *  จัดรูปแบบตัวเลขให้เป็นในรูปของเงิน `,`
 * @param {number} เลขจำนวนเต็ม
 */
stock MoneyFormat(integer)
{
	new value[20], string[20];

	valstr(value, integer);

	new charcount;

	for(new i = strlen(value); i >= 0; i --)
	{
		format(string, sizeof(string), "%c%s", value[i], string);
		if(charcount == 3)
		{
			if(i != 0)
				format(string, sizeof(string), ",%s", string);
			charcount = 0;
		}
		charcount ++;
	}

	return string;
}

/**
 *  เรียกชื่อ Roleplay จากผู้เล่น ไม่มีขีดเส้นใต้ (Underscore)
 * @param {number} ไอดีผู้เล่น
 */
ReturnRealName(playerid, underScore = 1)
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);

	if(!underScore)
	{
		if(PlayerInfo[playerid][pMasked])
			format(pname, sizeof(pname), "[Mask %i_%i]", PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1]); 
			
		else
		{
			 for (new i = 0, len = strlen(pname); i < len; i ++) if (pname[i] == '_') pname[i] = ' ';
		}
	}
    return pname;
}

stock ReturnName(playerid, underScore = 1)
{
	new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName)); 
	
	if(!underScore)
	{
		if(PlayerInfo[playerid][pMasked])
			format(playersName, sizeof(playersName), "[Mask %i_%i]", PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1]); 
			
		else
		{
			for(new i = 0, j = strlen(playersName); i < j; i ++) 
			{ 
				if(playersName[i] == '_') 
				{ 
					playersName[i] = ' '; 
				} 
			} 
		}
	}
	return playersName;
}

stock ReturnDBIDName(dbid)
{
	new query[120], returnString[60];
	
	mysql_format(dbCon, query, sizeof(query), "SELECT char_name FROM characters WHERE char_dbid = %i", dbid); 
	new Cache:cache = mysql_query(dbCon, query);
	
	if(!cache_num_rows())
		returnString = "None";
		
	else
		cache_get_value_name(0, "char_name", returnString);
	
	cache_delete(cache);
	return returnString;
}


stock ReturnDate()
{
	new sendString[90], MonthStr[40], month, day, year;
	new hour, minute, second;
	
	gettime(hour, minute, second);
	getdate(year, month, day);
	switch(month)
	{
	    case 1:  MonthStr = "มกราคม";
	    case 2:  MonthStr = "กุมภาพันธ์";
	    case 3:  MonthStr = "มีนาคม";
	    case 4:  MonthStr = "เมษายน";
	    case 5:  MonthStr = "พฤษภาคม";
	    case 6:  MonthStr = "มิถุนายน";
	    case 7:  MonthStr = "กรกฎาคม";
	    case 8:  MonthStr = "สิงหาคม";
	    case 9:  MonthStr = "กันยายน";
	    case 10: MonthStr = "ตุลาคม";
	    case 11: MonthStr = "พฤศจิกายน";
	    case 12: MonthStr = "ธันวาคม";
	}
	
	format(sendString, 90, "%d %s %d %02d:%02d:%02d", day,MonthStr, year + 543, hour, minute, second);
	return sendString;
}

stock ReturnIP(playerid)
{
	new
		ipAddress[266];

	GetPlayerIp(playerid, ipAddress, sizeof(ipAddress));
	return ipAddress; 
}

/**
 *  ส่งข้อความไปยังผู้เล่นรอบ ๆ ตัวของไอดีผู้เล่นที่ระบุ
 * @param {number} ไอดีผู้เล่น
 * @param {float} ระยะทาง
 * @param {string} ข้อความ
 */
ProxDetector(playerid, Float:radius, const str[])
{
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

	foreach (new i : Player)
	{
		if(GetPlayerInterior(playerid) == GetPlayerInterior(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
		{
			GetPlayerPos(i, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if (((tempposx < radius/16) && (tempposx > -radius/16)) && ((tempposy < radius/16) && (tempposy > -radius/16)) && ((tempposz < radius/16) && (tempposz > -radius/16)))
			{
				SendClientMessage(i, COLOR_GRAD1, str);
			}
			else if (((tempposx < radius/8) && (tempposx > -radius/8)) && ((tempposy < radius/8) && (tempposy > -radius/8)) && ((tempposz < radius/8) && (tempposz > -radius/8)))
			{
				SendClientMessage(i, COLOR_GRAD2, str);
			}
			else if (((tempposx < radius/4) && (tempposx > -radius/4)) && ((tempposy < radius/4) && (tempposy > -radius/4)) && ((tempposz < radius/4) && (tempposz > -radius/4)))
			{
				SendClientMessage(i, COLOR_GRAD3, str);
			}
			else if (((tempposx < radius/2) && (tempposx > -radius/2)) && ((tempposy < radius/2) && (tempposy > -radius/2)) && ((tempposz < radius/2) && (tempposz > -radius/2)))
			{
				SendClientMessage(i, COLOR_GRAD4, str);
			}
			else if (((tempposx < radius) && (tempposx > -radius)) && ((tempposy < radius) && (tempposy > -radius)) && ((tempposz < radius) && (tempposz > -radius)))
			{
				SendClientMessage(i, COLOR_GRAD5, str);
			}
		}
	}
	return 1;
}

/**
 *  ซิงค์สิทธิ์ผู้ดูแล
 * @param {number} ไอดีผู้เล่น
 */
syncAdmin(playerid) {
	switch(PlayerInfo[playerid][pAdmin]) {
		case 1: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1;
		}
		case 2: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1 | CMD_ADM_2;
		}
		case 3: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1 | CMD_ADM_2 | CMD_ADM_3;
		}
		case 4: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1 | CMD_ADM_2 | CMD_ADM_3 | CMD_LEAD_ADMIN;
		}
		case 5: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1 | CMD_ADM_2 | CMD_ADM_3 | CMD_LEAD_ADMIN | CMD_MANAGEMENT;
		}
		case 6: {
			PlayerInfo[playerid][pCMDPermission] = CMD_TESTER | CMD_ADM_1 | CMD_ADM_2 | CMD_ADM_3 | CMD_LEAD_ADMIN | CMD_MANAGEMENT | CMD_DEV;
		}
		default: {
			PlayerInfo[playerid][pCMDPermission] = CMD_PLAYER;
		}
	}
}

/**
 *  ตรวจสอบสิทธิ์ระหว่าง Flags
 * @param {flags} ที่ต้องการเทียบ
 * @param {flags} ตัวเปรียบเทียบ
 */
stock isFlagged(flags, flagValue) {
    if ((flags & flagValue) == flagValue) {
        return true;
    }
    return false;
}


ptask FunctionPlayers[1000](playerid) 
{
	if (PlayerInfo[playerid][pAdminjailed] == true)
	{
		PlayerInfo[playerid][pAdminjailTime]--; 
			
		if(PlayerInfo[playerid][pAdminjailTime] < 1)
		{
			PlayerInfo[playerid][pAdminjailed] = false; 
			PlayerInfo[playerid][pAdminjailTime] = 0; 
				
			SendServerMessage(playerid, "คุณถูกปล่อยตัวออกจากคุกแอดมินแล้ว");
				
			new str[128];
			format(str, sizeof(str), "%s ได้ถูกปล่อยตัวออกจากคุกแอดมินแล้ว.", ReturnName(playerid));
			SendAdminMessage(1, str);
				
			SpawnPlayer(playerid);
		}
	}
	if (PlayerInfo[playerid][pArrest] == true)
	{
		PlayerInfo[playerid][pArrestTime]--; 
			
		if(PlayerInfo[playerid][pArrestTime] < 1)
		{
			PlayerInfo[playerid][pArrest] = false; 
			PlayerInfo[playerid][pArrestTime] = 0; 
			PlayerInfo[playerid][pArrestRoom] = 0;
			PlayerInfo[playerid][pArrestBy] = 0;
				
			SendServerMessage(playerid, "คุณได้ถูกปล่อยตัวออกจากคุกแล้ว");

			SendPoliceMessage(0x8D8DFFFF, "HQ-ARREST: %s ได้ถูกปล่อยตัวออกจากห้องกุมขังแล้ว.", ReturnName(playerid));
			CharacterSave(playerid);
			SpawnPlayer(playerid);
		}
	}
	return 1;
}

stock PlayNearbySound(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 15.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}

stock ShowCharacterStats(playerid, playerb)
{
	// playerid = player's statistics;
	// playerb = player receiving stats;
	
	new 
		vehicle_key[20],
		duplicate_key[20],
		business_key[20] = "None"
	;
	
	if(!PlayerInfo[playerid][pVehicleSpawned])
		vehicle_key = "ไม่มี";
	else format(vehicle_key, 32, "%d", PlayerInfo[playerid][pVehicleSpawnedID]);
	
	if(PlayerInfo[playerid][pDuplicateKey] == INVALID_VEHICLE_ID)
		duplicate_key = "ไม่มี";
	else format(duplicate_key, 32, "%d", PlayerInfo[playerid][pDuplicateKey]); 
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][BusinessDBID])
			continue;
			
		if(BusinessInfo[i][BusinessOwnerDBID] == PlayerInfo[playerid][pDBID])
			format(business_key, 20, "%d", BusinessInfo[i][BusinessDBID]); 
	}
	
	SendClientMessageEx(playerb, COLOR_DARKGREEN, "|__________________%s [%s]__________________|", ReturnRealName(playerid, 0), ReturnDate());

	SendClientMessageEx(playerb, COLOR_GRAD2, "ตัวละคร: กลุ่ม/แก๊ง:[%s] ตำแหน่ง:[%s] อาชีพ:[%s]", ReturnFactionName(playerid), ReturnFactionRank(playerid), GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pJob]));
	SendClientMessageEx(playerb, COLOR_GRAD1, "ประสบการณ์: เลเวล:[%d] ค่าประสบการณ์:[%d/%d] เวลาออนไลน์:[%d ชัวโมง]", PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pExp], ((PlayerInfo[playerid][pLevel]) * 4 + 2), PlayerInfo[playerid][pTimeplayed]);
	SendClientMessageEx(playerb, COLOR_GRAD2, "อาวุธ: อาวุธ หลัก:[%s] กระสุน:[%d] อาวุธสำรอง:[%s] กระสุน:[%d]", ShowPlayerWeapons(playerid, 4), PlayerInfo[playerid][pWeaponsAmmo][3], ShowPlayerWeapons(playerid, 3), PlayerInfo[playerid][pWeaponsAmmo][2]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "ช่องเก็บของ: เบอร์โทรศัพท์:[%d] วิทยุ:[%s] แชแนล:[%d] แมส:[%s] Melee:[%s]", PlayerInfo[playerid][pPhone], (PlayerInfo[playerid][pHasRadio] != true) ? ("ไม่มี") : ("มี"), PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]], (PlayerInfo[playerid][pHasMask] != true) ? ("ไม่มี") : ("มี"), ShowPlayerWeapons(playerid, 1));
	SendClientMessageEx(playerb, COLOR_GRAD2, "การเงิน: เงินในตัว:[$%s] เงินในธนาคาร:[$%s] เงินรายชัวโมง:[$%s] Bitsamp:[%.5f]", MoneyFormat(PlayerInfo[playerid][pCash]), MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]), PlayerInfo[playerid][pBTC]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "อื่นๆ: กุญแจรถ:[%s] กุญแจสำรอง:[%s] กุณแจธุรกิจ:[%s]", vehicle_key, duplicate_key, business_key);	

	if(PlayerInfo[playerb][pJob] == 4)
	{
		SendClientMessageEx(playerb, COLOR_GRAD1, "แร่: Unprocessed Ores:[%d] Coal Ore:[%d] Iron Ore:[%d] Copper Ore:[%d] Potassium Nitrate:[%d]", PlayerInfo[playerid][pOre], PlayerInfo[playerid][pCoal],PlayerInfo[playerid][pIron], PlayerInfo[playerid][pCopper], PlayerInfo[playerid][pKNO3]);
	}

	if(PlayerInfo[playerb][pAdmin])
	{
		SendClientMessageEx(playerb, COLOR_GRAD1, "สำหรับแอดมิน: DBID:[%d] UCP:[%s (%d)] Interior:[%d] World:[%d]", PlayerInfo[playerid][pDBID], e_pAccountData[playerid][mAccName], e_pAccountData[playerid][mDBID], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		
		SendClientMessageEx(playerb, COLOR_GRAD2, "การเชื่อมต่อ: IP:[%s] ออนไลน์ล่าสุด:[%s] ชัวโมงออนไลน์:[%d ชัวโมง]", ReturnIP(playerid), ReturnLastOnline(playerid), PlayerInfo[playerid][pTimeplayed]);
		
		SendClientMessageEx(playerb, COLOR_GRAD1, "MISC: InsideProperty:[%i] InsideBusiness:[%i]", IsPlayerInHouse(playerid), IsPlayerInBusiness(playerid)); 
	}
	
	SendClientMessageEx(playerb, COLOR_DARKGREEN, "|__________________%s [%s]__________________|", ReturnRealName(playerid, 0), ReturnDate());
	return 1;
}

stock ReturnLastOnline(playerid)
{
	new returnString[90]; 
	
	if(!PlayerInfo[playerid][pLastOnline])
		returnString = "Never";
	
	else
		format(returnString, 90, "%s", PlayerInfo[playerid][pLastOnline]);
	
	return returnString;
}

stock GetChannelSlot(playerid, chan)
{
	for(new i = 1; i < 3; i++)
	{
		if(PlayerInfo[playerid][pRadio][i] == chan)
			return i;
	}
	return 0; 
}

forward OnCallPaycheck(playerid, response);
public OnCallPaycheck(playerid, response)
{
	new
		str[128]
	;
	
	if(response)
	{
		format(str, sizeof(str), "%s called a paycheck.", ReturnName(playerid));
		SendAdminMessage(3, str);
		
		CallPaycheck(); 
	}
	return 1;
}

forward FunctionPaychecks();
public FunctionPaychecks()
{
	new 
		hour, 
		minute, 
		seconds
	;

	gettime(hour, minute, seconds); 
	
	if(minute == 00 && seconds == 59)
	{
		CallPaycheck(); 
		SetWorldTime(hour + 1); 
	}
	
	return 1;
}

forward CallPaycheck();
public CallPaycheck()
{
	foreach(new i : Player)
	{
		if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
			continue;
			
		new
			str[128],
			total_paycheck = 0
		; 
		
		new
			Float: interest,
			interest_convert,
			total_tax,
			Float:interest_saving
		; 
		
		PlayerInfo[i][pTimeplayed]++; 
		PlayerInfo[i][pExp]++;
		
		if(PlayerInfo[i][pJob] == 4 && PlayerInfo[i][pJobRank] < 3)
			PlayerInfo[i][pJobExp]++;

		if(PlayerInfo[i][pJobExp] >= 25 && PlayerInfo[i][pJobRank] == 1)
		{
			PlayerInfo[i][pJobExp] = 0;
			PlayerInfo[i][pJobRank]++;
			SendClientMessage(i, COLOR_YELLOWEX, "ยินดีด้วยคุณได้เลื่อนต่ำแหน่งงานในอาชีพ ช่างยนต์ของคุณเป็น ช่างประจำอู่");
		}
		else if(PlayerInfo[i][pJobExp] >= 50 && PlayerInfo[i][pJobRank] == 2)
		{
			PlayerInfo[i][pJobExp] = 0;
			PlayerInfo[i][pJobRank]++;
			SendClientMessage(i, COLOR_YELLOWEX, "ยินดีด้วยคุณได้เลื่อนต่ำแหน่งงานในอาชีพ ช่างยนต์ของคุณเป็น หัวหน้างานช่าง");
		}

		if(PlayerInfo[i][pExp] >= 6 && PlayerInfo[i][pLevel] == 1)
		{
			PlayerInfo[i][pExp] = 0;
			PlayerInfo[i][pLevel]++;
			format(str, sizeof(str), "~g~Leveled Up~n~~w~You leveled up to level %i", PlayerInfo[i][pLevel]);
			GameTextForPlayer(i, str, 5000, 1);
			PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
			SetPlayerScore(i, PlayerInfo[i][pLevel]); 
		}
		else if(PlayerInfo[i][pExp] >= 10 && PlayerInfo[i][pLevel] == 2)
		{
			PlayerInfo[i][pExp] = 0;
			PlayerInfo[i][pLevel]++;
			format(str, sizeof(str), "~g~Leveled Up~n~~w~You leveled up to level %i", PlayerInfo[i][pLevel]);
			GameTextForPlayer(i, str, 5000, 1);
			PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
			SetPlayerScore(i, PlayerInfo[i][pLevel]); 
		}
		
		if(PlayerInfo[i][pLevel] == 1)
			total_paycheck+= 2000; 
			
		else if(PlayerInfo[i][pLevel] == 2)
			total_paycheck+= 1500; 

		else if(PlayerInfo[i][pJob] == 4)
			total_paycheck+= 1000;
			
		//Add an auto-level up on paycheck for level 1 and 2 to prevent paycheck farming.
		if(!PlayerInfo[i][pSaving])
		{
			interest_saving = 0.2;
			interest = (PlayerInfo[i][pBank] / 100) * interest_saving;
		}
		else
		{
			interest_saving = 0.9;
			interest = (PlayerInfo[i][pBank] / 100) * interest_saving; 
		}

		interest_convert = floatround(interest, floatround_round); 
	
		total_tax = floatround((PlayerInfo[i][pBank] * 0.002), floatround_round);
		
		SendClientMessageEx(i, COLOR_WHITE, "SERVER TIME:[ %s ]", ReturnHour()); 
		
		SendClientMessage(i, COLOR_WHITE, "|___ BANK STATEMENT ___|"); 
		SendClientMessageEx(i, COLOR_GREY, "   เงินในธนาคาร: $%s", MoneyFormat(PlayerInfo[i][pBank])); 
		SendClientMessageEx(i, COLOR_GREY, "   อัตราดอกเบี้ย: %.1f",interest_saving);
		SendClientMessageEx(i, COLOR_GREY, "   ได้รับดอกเบี้ย: $%s", MoneyFormat(interest_convert));
		SendClientMessageEx(i, COLOR_GREY, "   ภาษี: $%s", MoneyFormat(total_tax)); 
		SendClientMessage(i, COLOR_WHITE, "|________________________|");
		
		PlayerInfo[i][pPaycheck]+= total_paycheck; 
		PlayerInfo[i][pBank]+= interest_convert;
		//PlayerInfo[i][pBank]+= total_paycheck;
		PlayerInfo[i][pBank]-= total_tax;
		
		SendClientMessageEx(i, COLOR_WHITE, "   เงินในธนาคาร: $%s", MoneyFormat(PlayerInfo[i][pBank]));
		
		if(PlayerInfo[i][pLevel] == 1)
			SendClientMessage(i, COLOR_WHITE, "((คุณได้รับ $2,000 จากการเป็นเลเวล 1 ))");
			
		else if(PlayerInfo[i][pLevel] == 2)
			SendClientMessage(i, COLOR_WHITE, "(( คุณได้รับ $1,500 จากการเป็นเลเวล 2. ))");
		
		format(str, sizeof(str), "~y~Payday~n~~w~Paycheck~n~~g~$%d", total_paycheck);
		GameTextForPlayer(i, str, 3000, 1); 
	
		CharacterSave(i); 
	}
	return 1;
}

stock ReturnHour()
{
	new time[36]; 
	
	gettime(time[0], time[1], time[2]);
	
	format(time, sizeof(time), "%02d:%02d", time[0], time[1]);
	return time;
}

stock ReturnLicenses(playerid, playerb)
{
	new
		driver_str[60],
		wep_str[60],
		truck_str[60]

	;
	
	if(!PlayerInfo[playerid][pDriverLicense])
		driver_str = "{FF6346}Driving License : No";
		
	else if(PlayerInfo[playerid][pDriverLicenseRevoke]) 
		driver_str = "{FF6346}Driving License : Yes";
	
	else if(PlayerInfo[playerid][pDriverLicenseSus])
		driver_str = "{F1C40F}Driving License : Yes";

	else driver_str = "{E2FFFF}Driving License : Yes";
	
	if(!PlayerInfo[playerid][pWeaponLicense])
		wep_str = "{FF6346}Weapons License : No";

	else if(PlayerInfo[playerid][pWeaponLicenseRevoke])
		wep_str = "{F1C40F}Weapons License : Yes";
	
	else wep_str = "{E2FFFF}Weapons License : Yes";

	if(!PlayerInfo[playerid][pTuckingLicense])
		truck_str = "{FF6346}Trucking License : No";
		
	else if(PlayerInfo[playerid][pTuckingLicenseRevoke]) 
		truck_str = "{FF6346}Trucking License : Yes";
	
	else if(PlayerInfo[playerid][pTuckingLicenseSus])
		truck_str = "{F1C40F}Trucking License : Yes";

	else truck_str = "{E2FFFF}Trucking License : Yes";



	
	SendClientMessage(playerb, COLOR_DARKGREEN, "______Identification_______");
	SendClientMessageEx(playerb, COLOR_GRAD2, "Name : %s", ReturnRealName(playerid, 0)); 
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", driver_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", wep_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", truck_str);
	SendClientMessage(playerb, COLOR_DARKGREEN, "___________________________"); 
	return 1;
}


stock Player_IsNearPlayer(playerid, targetid, Float:radius)
{
	new
        Float:x,
        Float:y,
        Float:z;

	GetPlayerPos(playerid, x, y, z);

    new
        matchingVW = GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid),
        matchingInt = GetPlayerInterior(playerid) == GetPlayerInterior(targetid),
        inRange = IsPlayerInRangeOfPoint(targetid, radius, x, y, z);

	return matchingVW && matchingInt && inRange;
}


stock SendMsgLocal(playerid, Float:radius = 10.0, colour, const string[]) {
    SendClientMessage(playerid, colour, string);
    foreach(new i: StreamedPlayer[playerid])
    {
        if (Player_IsNearPlayer(playerid, i, radius))
        {
            SendClientMessage(i, colour, string);
        }
    }
	return 1;
}

stock SendMsgLocalEx(playerid, Float:radius = 15.0, colour, const fmat[], {Float,_}:...) {
    va_format(chat_msgOut, sizeof (chat_msgOut), fmat, va_start<4>);
    SendClientMessage(playerid, colour, chat_msgOut);
    foreach(new i: StreamedPlayer[playerid])
    {
        if (Player_IsNearPlayer(playerid, i, radius))
        {
			if(i == playerid)
				continue;

			SendClientMessage(i, colour, chat_msgOut);	
        }
    }
	return 1;
}


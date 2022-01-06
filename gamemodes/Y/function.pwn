/**
 *  ให้ค่าประสบการณ์กับผู้เล่นพร้อมอัปเดต UI
 * @param {amount} เลขจำนวนเต็ม
 * ใช้ฟังก์ชั่น UpdatePlayerEXPBar ที่อยู่ใน ui.pwn
 */
#include <YSI_Coding\y_va>

#define WEB_SITE_FORUM "www.lsrplite.in.th/forum"

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

/*ptask PlayerDonater[1000](playerid) 
{
	if(PlayerInfo[playerid][pDonater] && PlayerInfo[playerid][pDonaterTime] > 0)
	{
		if(!PlayerInfo[playerid][pDonaterTime])
		PlayerInfo[playerid][pDonaterTime]--;
		
	}
	return 1;
}*/

stock PlayerSpec(playerid, playerb)
{
	if(PlayerDrugUse[playerid] != -1)
	{
		KillTimer(PlayerDrugUse[playerid]);
		PlayerDrugUse[playerid] = -1;
		SendClientMessage(playerid, COLOR_LIGHTRED, "สถานะคุณไม่ได้อยู้สำหรับการเสพยา");
	}

	new weapon[13][2];

	for(new i = 0; i < 13; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon[i][0], weapon[i][1]);
		PlayerInfo[playerid][pWeapons][i] = weapon[i][0];
		PlayerInfo[playerid][pWeaponsAmmo][i] = weapon[i][1];

	}

	if(PlayerInfo[playerb][pSpectating] != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[playerb][pSpectating] == playerid)
			return SendErrorMessage(playerid, "คุณไม่สามารถส่องตัวเองได้");
		
		PlayerSpec(playerid, PlayerInfo[playerb][pSpectating]);
		return 1;
	}

	if(GetPlayerState(playerb) == PLAYER_STATE_DRIVER || GetPlayerState(playerb) == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerb);

		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
			
			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);
			//SendServerMessage(playerid, "ตอนนี้คุณกำลังส่องผู้เล่น %s  /specoff เพื่ออยุดส่อง", ReturnName(playerb));
		}
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerb));
		SetPlayerInterior(playerid, GetPlayerInterior(playerb));

		
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
			//SendServerMessage(playerid, "ตอนนี้คุณกำลังส่องผู้เล่น %s  /specoff เพื่ออยุดส่อง", ReturnName(playerb));
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

/**

 * หากใส่ ! แปลว่า เข้าสู่ระบบแล้ว
 * หากไม่ใส่ ! แปลว่ายังไม่เข้าสู่ระบบ
 */
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
stock ReturnRealName(playerid, underScore = 0)
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, MAX_PLAYER_NAME);

	if(!underScore)
	{		
		for (new i = 0, len = strlen(pname); i < len; i ++) if (pname[i] == '_') pname[i] = ' ';
	}
    return pname;
}

stock ReturnName(playerid, underScore = 0)
{
	new playersName[MAX_PLAYER_NAME + 2];
	GetPlayerName(playerid, playersName, sizeof(playersName)); 
	
	if(!underScore)
	{
		if(PlayerInfo[playerid][pMasked])
			format(playersName, sizeof(playersName), "[Mask %i_%i%i]", PlayerInfo[playerid][pMaskID][0], PlayerInfo[playerid][pMaskID][1], playerid); 
			
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
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}
	
	format(sendString, 90, "%d %s %d %02d:%02d:%02d", day,MonthStr, year, hour, minute, second);
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
			
			SetPlayerHealth(playerid, 100);
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

			SendFactionMessageToAll(1, 0x8D8DFFFF, "HQ-ARREST: %s ได้ถูกปล่อยตัวออกจากห้องกุมขังแล้ว.", ReturnName(playerid));

			SetPlayerHealth(playerid, 100);
			
			SpawnPlayer(playerid);
			CharacterSave(playerid);
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
		duplicate_key[20],
		business_key[20] = "None"
	;

	
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

	GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
	GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
	
	SendClientMessageEx(playerb, COLOR_DARKGREEN, "|__________________%s [%s]__________________|", ReturnRealName(playerid, 0), ReturnDate());

	SendClientMessageEx(playerb, COLOR_GRAD2, "ตัวละคร: กลุ่ม/แก๊ง:[%s] ตำแหน่ง:[%s] อาชีพ:[%s] เลือด:[%.2f] เกราะ:[%.2f]", ReturnFactionName(playerid), ReturnFactionRank(playerid), GetJobName(PlayerInfo[playerid][pCareer], PlayerInfo[playerid][pJob]), PlayerInfo[playerid][pHealth],PlayerInfo[playerid][pArmour]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "ประสบการณ์: เลเวล:[%d] ค่าประสบการณ์:[%d/%d] เวลาออนไลน์:[%d ชัวโมง]", PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pExp], ((PlayerInfo[playerid][pLevel]) * 4 + 2), PlayerInfo[playerid][pTimeplayed]);
	SendClientMessageEx(playerb, COLOR_GRAD2, "อาวุธ: อาวุธ หลัก:[%s] กระสุน:[%d] อาวุธสำรอง:[%s] กระสุน:[%d]", ShowPlayerWeapons(playerid, 4), PlayerInfo[playerid][pGunAmmo][3], ShowPlayerWeapons(playerid, 3), PlayerInfo[playerid][pGunAmmo][2]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "ช่องเก็บของ: เบอร์โทรศัพท์:[%d] วิทยุ:[%s] แชแนล:[%d] แมส:[%s] Melee:[%s]", PlayerInfo[playerid][pPhone], (PlayerInfo[playerid][pHasRadio] != true) ? ("ไม่มี") : ("มี"), PlayerInfo[playerid][pRadio][PlayerInfo[playerid][pMainSlot]], (PlayerInfo[playerid][pHasMask] != true) ? ("ไม่มี") : ("มี"), ShowPlayerWeapons(playerid, 1));
	SendClientMessageEx(playerb, COLOR_GRAD2, "การเงิน: เงินในตัว:[$%s] เงินในธนาคาร:[$%s] เงินรายชัวโมง:[$%s] Bitsamp:[%.5f]", MoneyFormat(PlayerInfo[playerid][pCash]), MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]), PlayerInfo[playerid][pBTC]);
	SendClientMessageEx(playerb, COLOR_GRAD1, "อื่นๆ: กุญแจรถสำรอง:[%s] กุญแจกิจการ:[%s]  กุญแจบ้านสำรอง:[%d] กุจแจกิจการสำรอง [%d]", duplicate_key, business_key, PlayerInfo[playerid][pHouseKey], PlayerInfo[playerid][pBusinessKey]);	

	if(PlayerInfo[playerid][pJob] == 4)
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


stock CompareStrings(const string[], const string2[])
{
	if(!strcmp(string, string2, true))
		return true;
	else
		return false;
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

new Ticketnumber[][] = 
	{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};

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

		if(IsAfk{i}) 
		{
			if(AFKCount[i] > 120)
			{
				SendClientMessageEx(i, COLOR_LIGHTRED, "คุณไม่ได้รับ PayCheck เนื่องจากคุณมีการ AFK ไป %s วินาที ซึ่งเรากำหนดให้แค่ไม่เกิน 120 วินาที",MoneyFormat(AFKCount[i]));
				format(str, sizeof(str), "[%s] %s(DBID:%d) not paid PayCheck",ReturnDate(), ReturnRealName(i,0), PlayerInfo[i][pDBID]);
				SendDiscordMessageEx("not-paycheck", str);
				continue;
			}
		}
		
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
			total_paycheck+= 200; 
			
		else if(PlayerInfo[i][pLevel] == 2)
			total_paycheck+= 100; 

		else if(PlayerInfo[i][pJob] == 3)
			total_paycheck+= 50;
			
		//Add an auto-level up on paycheck for level 1 and 2 to prevent paycheck farming.
		if(!PlayerInfo[i][pSaving])
		{
			interest_saving = 0.03;
			interest = PlayerInfo[i][pBank] * interest_saving;
		}
		else
		{
			if(PlayerInfo[i][pBank] >= 10000000)
			{
				PlayerInfo[i][pSaving] = false;
				SendClientMessage(i, COLOR_ORANGE, "ขอแสดงความยินดีด้วยคุณได้มียอดเงินฝากออมทรัพ ถึงยอดที่กำหนดแล้วสามารถไปถอนเงินได้ที่ธนาคารของคุณ");
			}

			interest_saving = 0.04;
			interest = PlayerInfo[i][pBank] * interest_saving; 
		}

		interest_convert = floatround(interest, floatround_round); 
	
		total_tax = floatround((PlayerInfo[i][pBank] * 0.035), floatround_round);
		
		SendClientMessageEx(i, COLOR_WHITE, "SERVER TIME:[ %s ]", ReturnHour()); 
		
		SendClientMessage(i, COLOR_WHITE, "|___ BANK STATEMENT ___|"); 
		SendClientMessageEx(i, COLOR_GREY, "   เงินในธนาคาร: $%s", MoneyFormat(PlayerInfo[i][pBank])); 
		SendClientMessageEx(i, COLOR_GREY, "   อัตราดอกเบี้ย: %.2f",interest_saving);
		SendClientMessageEx(i, COLOR_GREY, "   ได้รับดอกเบี้ย: $%s", MoneyFormat(interest_convert));
		SendClientMessageEx(i, COLOR_GREY, "   ภาษี: $%s", MoneyFormat(total_tax)); 
		SendClientMessage(i, COLOR_WHITE, "|________________________|");
		
		PlayerInfo[i][pPaycheck]+= total_paycheck;

		PlayerInfo[i][pBank]+= interest_convert;
		//PlayerInfo[i][pBank]+= total_paycheck;
		PlayerInfo[i][pBank]-= total_tax;
		GlobalInfo[G_GovCash]+= floatround(total_tax, floatround_round);
		GlobalInfo[G_GovCash]-= floatround(total_paycheck, floatround_round);
		GlobalInfo[G_GovCash]-= floatround(interest_convert / 2, floatround_round);
		
		SendClientMessageEx(i, COLOR_WHITE, "   เงินในธนาคาร: $%s", MoneyFormat(PlayerInfo[i][pBank]));
		
		if(PlayerInfo[i][pLevel] == 1)
			SendClientMessage(i, COLOR_WHITE, "((คุณได้รับ $200 จากการเป็นเลเวล 1 ))");
			
		else if(PlayerInfo[i][pLevel] == 2)
			SendClientMessage(i, COLOR_WHITE, "(( คุณได้รับ $100 จากการเป็นเลเวล 2. ))");

		else if(PlayerInfo[i][pJob] == 3)
			SendClientMessage(i, COLOR_WHITE, "(( คุณได้รับ $50 จากการเป็นอาชีพช่างยนต์ ))");
		
		format(str, sizeof(str), "~y~Payday~n~~w~Paycheck~n~~g~$%d", total_paycheck);
		GameTextForPlayer(i, str, 3000, 1); 

		new randset[2];

		randset[0] = random(sizeof(Ticketnumber));
		randset[1] = random(sizeof(Ticketnumber)); 

		format(GlobalInfo[G_Ticket], 32,  "%s%s", Ticketnumber[randset[0]],Ticketnumber[randset[1]]);

		if(PlayerInfo[i][pTicket] == GlobalInfo[G_Ticket])
		{
			SendClientMessageEx(i, COLOR_GENANNOUNCE, "คุณถูกรางวัลจากการซื้อ ล็อตตารี่ %d ได้รับเงิน $200",GlobalInfo[G_Ticket]);
			GiveMoney(i, 200);
			format(PlayerInfo[i][pTicket], PlayerInfo[i][pTicket],"");
		}
		SendClientMessageEx(i, COLOR_GREY, "เลขล็อตตารี่ออก คือ: %s",  GlobalInfo[G_Ticket]);

		
		for(new h = 1; h < MAX_HOUSE; h++)
		{
			if(!HouseInfo[h][HouseDBID])
				continue;
			
			if(!HouseInfo[h][HouseOwnerDBID])
				continue;

			if(!HouseInfo[h][HouseRent])
				continue;
			
			if(HouseInfo[h][HouseRent] == PlayerInfo[i][pDBID])
			{
				GiveMoney(i, -HouseInfo[h][HouseRentPrice]);

				new total_tax_h = floatround(HouseInfo[h][HouseRentPrice] * 0.07,floatround_round);
				SendClientMessageEx(i, COLOR_LIGHTRED, "ค่าเช่าบ้านของคุณ: $%s",MoneyFormat(HouseInfo[h][HouseRentPrice]));
				
				if(HouseInfo[h][HouseOwnerDBID] == PlayerInfo[i][pDBID])
				{
					GiveMoney(i, HouseInfo[h][HouseRentPrice] - total_tax_h);
					SendClientMessageEx(i, COLOR_ORANGE,"คุณได้ค่าเช่าบ้าน: $%s",MoneyFormat(HouseInfo[h][HouseRentPrice] - total_tax_h));
				}
				else
				{
					AddPlayerCash(HouseInfo[h][HouseOwnerDBID], HouseInfo[h][HouseRentPrice] - total_tax_h);
				}
			}
			else
			{
				new total_tax_h = floatround(HouseInfo[h][HouseRentPrice] * 0.07,floatround_round);
				AddPlayerCash(HouseInfo[h][HouseRent], HouseInfo[h][HouseRentPrice] - total_tax_h);

				if(HouseInfo[h][HouseOwnerDBID] == PlayerInfo[i][pDBID])
				{
					GiveMoney(i, HouseInfo[h][HouseRentPrice] - total_tax_h);
					SendClientMessageEx(i, COLOR_ORANGE,"คุณได้ค่าเช่าบ้าน: $%s",MoneyFormat(HouseInfo[h][HouseRentPrice] - total_tax_h));
				}
				else
				{
					AddPlayerCash(HouseInfo[h][HouseOwnerDBID], HouseInfo[h][HouseRentPrice] - total_tax_h);
				}
			}
		}
		

		DelevehicleVar();
		CharacterSave(i); 
		Saveglobal();		
	}

	new str[120];
	format(str, sizeof(str), "[%s] Paycheck Now",ReturnDate());
	SendDiscordMessageEx("paycheck-hour", str);
	return 1;
}

stock DelevehicleVar()
{
	new bool:respawn/*,query[MAX_STRING]*/;

	for(new v = 1; v < MAX_VEHICLES; v++) 
	{
		if(IsVehicleOccupied(v))
			continue;

		if(!VehicleInfo[v][eVehicleDBID])
			continue;

		if(VehicleInfo[v][eVehicleFaction])
			continue;

		if(VehicleInfo[v][eVehicleCarPark])
			continue;

			
		
		respawn = true;

		foreach (new i : Player) 
		{
				
            if(VehicleInfo[v][eVehicleOwnerDBID] == PlayerInfo[i][pDBID]) 
			{
				respawn = false;
                break;
            }
        }


		if (respawn) {
			/*mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pVehicleSpawned` = '0',`pVehicleSpawnedID` = '0' WHERE `char_dbid` = '%d'",VehicleInfo[v][eVehicleOwnerDBID]);
         	mysql_tquery(dbCon, query);*/

			ResetVehicleVars(v);
			DestroyVehicle(v);
		}
	}
	return 1;
}
stock AddPlayerCash(charid, amount)
{
	new query[MAX_STRING], Money;
	
	mysql_format(dbCon, query, sizeof(query), "SELECT `pCash` FROM `characters` WHERE `char_dbid` = '%d'",charid);
	new Cache:cache = mysql_query(dbCon, query);
	
	if(!cache_num_rows())
		return 1;

	else
		cache_get_value_index_int(0, 0, Money);
	
	cache_delete(cache);

	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pCash` = '%d' WHERE `char_dbid` = '%d';",Money += amount, charid);
	mysql_tquery(dbCon, query);
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
		truck_str[60],
		taxi_str[60]

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

	if(!PlayerInfo[playerid][pTxaiLicense])
		taxi_str = "{FF6346}TAXI License : No";
		
	else if(PlayerInfo[playerid][pTxaiLicense]) 
		taxi_str = "{E2FFFF}TAXI License : Yes";



	
	SendClientMessage(playerb, COLOR_DARKGREEN, "______Identification_______");
	SendClientMessageEx(playerb, COLOR_GRAD2, "Name : %s", ReturnRealName(playerid, 0)); 
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", driver_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", wep_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", truck_str);
	SendClientMessageEx(playerb, COLOR_GRAD2, "%s", taxi_str);
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


SetPlayerToFacePlayer(playerid, targetid)
{
	new
	    Float:px,
	    Float:py,
	    Float:pz,
	    Float:tx,
	    Float:ty,
	    Float:tz;

	GetPlayerPos(targetid, tx, ty, tz);
	GetPlayerPos(playerid, px, py, pz);
	SetPlayerFacingAngle(playerid, 180.0 - atan2(px - tx, py - ty));
	return 1;
}

stock GivePlayerHealth(playerid, Float:amount)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	SetPlayerHealth(playerid, health + amount);
	return 1;
}

stock GivePlayerArmour(playerid, Float:amount)
{
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	SetPlayerArmour(playerid, armour + amount);
	return 1;
}

stock UpDateRadioStats(playerid)
{
	new str[120];

	new local = PlayerInfo[playerid][pMainSlot];
	new channel = PlayerInfo[playerid][pRadio][local];

	for(new r = 1; r < 3; r ++)
	{
		if(PlayerInfo[playerid][pRadio][r] == channel)
		{
			format(str, sizeof(str), "~b~RADIO:INFO~n~CH: ~g~%d~n~~b~SLOT: ~g~%d",PlayerInfo[playerid][pRadio][r], PlayerInfo[playerid][pMainSlot]);
			PlayerTextDrawSetString(playerid, RadioStats[playerid], str);
		}
	}
	return 1;
}

ChatAnimation(playerid, length)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !PlayerInfo[playerid][pAnimation])
	{
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.1,1,0,0,1,1);
		SetTimerEx("StopChatting", floatround(length)*100, 0, "i", playerid);
	}
	return 1;
}

forward StopChatting(playerid);
public StopChatting(playerid) ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);



stock SetPlayerSpawn(playerid)
{

	if(!PlayerInfo[playerid][pTutorial])
	{
		SetPlayerCameraPos(playerid, 1450.2858,-912.3414,84.3133);
		SetPlayerCameraLookAt(playerid,1415.9854,-809.7775,75.7696, 0);
		SetPlayerPos(playerid, 1415.9854,-809.7775,75.7696);
		ShowDialogSpawn(playerid);
		return 1;
	}

    else if(PlayerInfo[playerid][pAdminjailed] == true)
    {
        SendClientMessageEx(playerid, COLOR_REDEX, "[ADMIN JAIL:] เวลาที่อยู่ในคุกแอดมินของคุณยังไม่หมดจำเป็นต้องอยู่ในคุกอีก %d วินาที",PlayerInfo[playerid][pAdminjailTime]);
        ClearAnimations(playerid); 
	
        SetPlayerPos(playerid, 2687.3630, 2705.2537, 22.9472);
        SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 1338);
        SetPlayerWeapons(playerid);

        CharacterSave(playerid);
        StopAudioStreamForPlayer(playerid);
    }
    else if(PlayerInfo[playerid][pArrest] == true)
    {
        ArrestConecterJail(playerid, PlayerInfo[playerid][pArrestTime], PlayerInfo[playerid][pArrestRoom]);
        ClearAnimations(playerid);
        CharacterSave(playerid);
        StopAudioStreamForPlayer(playerid);
    }
    else if (PlayerInfo[playerid][pTimeout]) {

        // ตั้งค่าผู้เล่นให้กลับที่เดิมและสถานะบางอย่างเหมือนเดิม

        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

        SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
        SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

        PlayerInfo[playerid][pTimeout] = 0;

        GameTextForPlayer(playerid, "~r~crashed. ~w~returning to last position", 1000, 1);
        StopAudioStreamForPlayer(playerid);

        new query[255];
		mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `cache` WHERE C_DBID = '%d'",PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query, "OnplayerCache", "d",playerid);
    }
    else if(PlayerInfo[playerid][pSpectating] != INVALID_PLAYER_ID)
    {
        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
        PlayerInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
        StopAudioStreamForPlayer(playerid);
        RemovePlayerWeapon(playerid, 1);
    }
    else 
    {
        switch (PlayerInfo[playerid][pSpawnPoint]) {
            case SPAWN_AT_DEFAULT: {
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);
                SetPlayerPos(playerid, DEFAULT_SPAWN_LOCATION_X, DEFAULT_SPAWN_LOCATION_Y, DEFAULT_SPAWN_LOCATION_Z);
                SetPlayerFacingAngle(playerid, DEFAULT_SPAWN_LOCATION_A);
            }
            case SPAWN_AT_FACTION: {
                new id = PlayerInfo[playerid][pFaction];

                SetPlayerPos(playerid, FactionInfo[id][eFactionSpawn][0], FactionInfo[id][eFactionSpawn][1], FactionInfo[id][eFactionSpawn][2]-2);
                
                SetPlayerVirtualWorld(playerid, FactionInfo[id][eFactionSpawnWorld]);
                SetPlayerInterior(playerid, FactionInfo[id][eFactionSpawnInt]);
                TogglePlayerControllable(playerid, 0);
                SetTimerEx("SpawnFaction", 2000, false, "dd",playerid,id);
            }
            case SPAWN_AT_HOUSE: {
                
                new id = PlayerInfo[playerid][pSpawnHouse];

                SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseInteriorWorld]);
                SetPlayerInterior(playerid, HouseInfo[id][HouseInteriorID]);
                SetPlayerPos(playerid, HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2]-2);
                TogglePlayerControllable(playerid, 0);
                SetTimerEx("OnPlayerEnterProperty", 2000, false, "ii", playerid, id); 

                PlayerInfo[playerid][pInsideProperty] = id;
            }
            case SPAWN_AT_LASTPOS: 
            {
                SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        		SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        		SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
            }

        }
    }

    new query[255];
	mysql_format(dbCon, query, sizeof(query), "DELETE FROM `cache` WHERE `C_DBID` = '%d'",PlayerInfo[playerid][pDBID]);
	mysql_tquery(dbCon, query);
    return 1;
}


stock ShowDialogSpawn(playerid)
{
	new str[255], longstr[255];

	format(str, sizeof(str), "Ganton Bus Stop\n");
	strcat(longstr, str);
	format(str, sizeof(str), "Idlewood Bus Stop\n");
	strcat(longstr, str);
	format(str, sizeof(str), "Jefferson Bus Stop\n");
	strcat(longstr, str);

	Dialog_Show(playerid, D_SET_SPAWN_START, DIALOG_STYLE_LIST, "เลือกจุดเกิดเริ่มต้น", longstr, "ยืนยัน", "ยกเลิก");
	return 1;
}


Dialog:D_SET_SPAWN_START(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้เลือกจุดเกิดทำให้คุณถูกแตะ");
		KickEx(playerid);
		return 1;
	}


	// ยังไม่ผ่านบทเรียน / ตัวละครใหม่
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pCash] = DEFAULT_PLAYER_CASH;
		
	PlayerInfo[playerid][pTutorial] = true;
	SetCameraBehindPlayer(playerid);
	ShowPlayerGuid(playerid);
	
	switch(listitem)
	{
		case 0: //ganton
		{
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกเกิดที่ย่าน Ganton โปรดเลือกสกินเพื่อเล่นบทบาทด้วย");
			SetPlayerPos(playerid, 2279.3052,-1739.9686,13.5469);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			ShowSkinModelMenu(playerid);
			return 1;
		}
		case 1: //Idlewood
		{
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกเกิดที่ย่าน Idlewood โปรดเลือกสกินเพื่อเล่นบทบาทด้วย");
			SetPlayerPos(playerid, 2036.2422,-1757.5090,13.5469);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			ShowSkinModelMenu(playerid);
			return 1;
		}
		case 2: //Jefferson
		{
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกเกิดที่ย่าน Jefferson โปรดเลือกสกินเพื่อเล่นบทบาทด้วย");
			SetPlayerPos(playerid, 2202.2676,-1134.0295,25.7459);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
			ShowSkinModelMenu(playerid);
			return 1;
		}
	}
	return 1;
}


stock ShowPlayerGuid(playerid)
{
	new str[4000], longstr[4000];

	if(PlayerInfo[playerid][pInsideBusiness])
	{
		format(str, sizeof(str), "{45B39D}GUIED BUSINESS!!{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n");
		strcat(longstr, str);
		format(str, sizeof(str), "กิจการธุรกิจต่างๆที่มีอยู่ภายในเมืองมีมากมายหลายๆรูปแบบซึ่งแต่ละรูปแบบจะถูกกำหนดโดยผู้เล่นที่เป็นเจ้าของกิจการ มีสิทธิ์ในการทำกิจการทุกกิจการได้\n");
		strcat(longstr, str);
		format(str, sizeof(str), "ซึ่งในกิจการนั้นก็มีรูปแบบและกฎที่แตกต่างและยืดหยุ่นออกไปตามรูปแบบของกิจการต่างๆ ซึ่งการที่จะเข้าใจนั้นอาจจะยากนิดหน่อยแต่เชื่อได้เลยว่าเป็นเรื่องที่สนุก\n");
		strcat(longstr, str);
		format(str, sizeof(str), "และไม่แพ้กับเรื่องไหนๆเลยก็ตาม การมีกิจการนั้นจะคุณสามารถที่จะทำการติดต่อผู้ดูแลเกี่ยวกับเรื่อง Business ได้ที่ฟอรั่มหรือช่องทางดิสคอร์ดได้ตลอด และเขา\n");
		strcat(longstr, str);
		format(str, sizeof(str), "จะเป็นผู้ที่คอยแนะนำการเปิดกิจการของคุณได้ ซึ่งแต่ละกิจการมีการพึ่งพาผู้เล่นในการเล่นสวมบทบาทต่างๆ ยังไงก็แล้วแต่คุณสามารถที่จะดูกิจการอื่นๆที่คุณอยู่ตรงนี้เป็นตัวอย่าง\n");
		strcat(longstr, str);
		format(str, sizeof(str), "หรือคุณจะไปขอคำแนะนำจากผู้ดูแลได้ตลอด ยังไงเราขอให้คุณมีความสุขกับวงการธุรกิจที่คุณหวังไว้\n");
		strcat(longstr, str);
	}
	else if(PlayerInfo[playerid][pInsideProperty])
	{
		format(str, sizeof(str), "{45B39D}GUIED HOUSE!!{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n\n\n");
		strcat(longstr, str);
		format(str, sizeof(str), "เป็นเรื่องที่ดีที่คุณสงสัยในเรื่องนี้ เกี่ยวกับระบบ บ้านของเราปจุบันนี้เรามีบ้านที่ผู้เล่นสามารถขอเปิดได้ทันที โดยเราจะมีบทบาทต่างๆภายใน IC ให้ผู้เล่นได้เลือกเล่นกัน\n");
		strcat(longstr, str);
		format(str, sizeof(str), "และการขอเปิดบ้านคุณนั้นสามารถทำมันได้ฟรีโดยไม่ต้องเสียเงินผ่านระบบ OOC ใดๆทั้งนั้น ซึ่งถ้าคุณเป็นเจ้าของบ้านคุณนั้นก็จะได้รับสิทธิ์มากมายในการมีอยู่ของบ้านตัวเอง\n");
		strcat(longstr, str);
		format(str, sizeof(str), "คุณนั้นสามารถที่จะเช็คคำสั่งทั้งหมดที่เกี่ยวกับบ้านได้โดยการพิพม์ /housecmds จะมีการแสดงคำสั่งทั้งหมดที่เกี่ยวข้องกับบ้านมาให้คุณได้ทันที\n");
		strcat(longstr, str);
		format(str, sizeof(str), "หากคุณมีบ้านเป็นของตนเองคุณสามารถที่จะนำอาวุธของคุณนั้นมาเก็บไว้ที่บ้านเพื่อกันมันหายได้ หรือจะเป็นพวกยาเสพติดก็ตามที\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n\n");
		strcat(longstr, str);
		format(str, sizeof(str), "{C0392B}คำเตือน!!:{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "บ้านนั้นเป็นสิ่งที่ผู้เล่นทุกคนควรจะมีไว้เพื่อไว้ในการใช้เล่นบทบาทและเป็นที่เก็บอาวุธของเราหรือสิ่งต่างๆทุกสิ่ง และถ้าคุณมีบ้านภาระค่าใช้จ่ายในการจ่าย ค่าไฟบ้านก็จะมีเพิ่มขึ้นตามการใช้งาน\n");
		strcat(longstr, str);
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		format(str, sizeof(str), "{45B39D}GUIED VEHICLE!!{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n");
		strcat(longstr, str);
		format(str, sizeof(str), "ตอนนี้คุณอยู่บนยานพาหนะไม่ว่ายานพานะนี้จะเป็นของคุณหรือไม่แต่ที่สำคัญคือคุณไม่ควรใช้ยานพานหะไปในทางที่ ผิดกฎของเซิร์ฟเวอร์\n");
		strcat(longstr, str);
		format(str, sizeof(str), "การขับยานพาหนะทุกชนิดคุณควรจะนึกถึงการขับแบบ Roleplay Driving เราไม่ได้หมายถึงให้คุณขับตามจราจรแต่เราหมายถึงความสมจริงในการจับยานพาหนะ \n");
		strcat(longstr, str);
		format(str, sizeof(str), "เพราะคงไม่มีใครที่จะเอายานพาหนะที่หรูหราไปขับอยู่บนทางลาดชันหรือภูเขาอะไรก็ตาม การขับยานพาหนะเราควรนึกถึงตัวเครื่องของรถแต่ละคัน และควรใช้มันให้เป็นประโชยน์\n");
		strcat(longstr, str);
		format(str, sizeof(str), "สิ่งที่คุณนั้นควรทำในตอนที่ยานพาหนะของคุณเสียคือการติดต่อช่างภายในเมือง หรือทำอย่างไรก็ได้ให้มีความ Roleplay ที่สุด เราไม่ได้เคร่งคัดอะไรขนาดนั้น\n");
		strcat(longstr, str);
		format(str, sizeof(str), "สิ่แต่เราหวังว่าจะได้รับการขับรถที่ดีจากคุณ และถ้าหากคุณต้องการที่จะรู้คำสั่งของยานพาหนะทั้งหมดให้คุณพิพม์ /(v)ehicle ได้ทันที \n");
		strcat(longstr, str);
	}
	else
	{
		format(str, sizeof(str), "{229954}ยืนดีตอนรับ ผู้เล่น %s ครับ!!{FFFFFF}\n", ReturnRealName(playerid));
		strcat(longstr, str);
		format(str, sizeof(str), "อับดับแรกขอตอนรับเข้าสู่เมือง Los Santos คุณเป็นผุ้เล่นใหม่ใช่หรือไม่ เป็นเรื่องที่ดีถ้าคุณจะอ่านข้อความของเราสะหหน่อยนะ\n");
		strcat(longstr, str);
		format(str, sizeof(str), "นี่เป็นการจำลองการใช้ชีวิตในเมือง Los Santos ที่มีการจำลองมาจากเมือง los Angeles จากประเทศ อเมริกา\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n\n");
		strcat(longstr, str);
		format(str, sizeof(str), "{D35400}เรื่องแรก{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "คุณนั้นมีเงินติดตัวอยู่ $5,000 ทางทีดีคุณควรเอาเงินพวกนี้ใช้อย่างประหยัดโดยการคุณจะเอาไปใช้ในในการต่อยอดอาชีพ\n");
		strcat(longstr, str);
		format(str, sizeof(str), "ซึ่งจะภายในเมืองของเรานั้นมีอาชีพเล็กๆน้อยให้ผู้เล่นทำเพลินไม่ต้องแข่งกับเวลาอะไรมากมาย ซึ่งการใช้จ่ายเงินของผู้เล่น\n");
		strcat(longstr, str);
		format(str, sizeof(str), "ในแต่ละครั้งจะมีระบบภาษีคอยเป็นเงินสบทบให้กับการทำงานในอาชีพของทุกๆอาชีพวนไปมาอยู่ ขอให้ผู้เล่นทุกคนใช้เงินอยางระมัดระวัง!\n");
		strcat(longstr, str);
		format(str, sizeof(str), "\n\n");
		strcat(longstr, str);
		format(str, sizeof(str), "{D35400}เรื่องที่สอง{FFFFFF}\n");
		strcat(longstr, str);
		format(str, sizeof(str), "เซิร์ฟเวอร์ของเวอร์ Roleplay แบบคาสสิคอาจจะไม่ถูกใจหลายๆคนเท่าไหร่นักถ้าอยากจะอยากเข้ามาเล่นคุณสามารถเข้ามาเล่นได้แต่จำเป็นจะต้องทำตามกฎของเรา\n");
		strcat(longstr, str);
		format(str, sizeof(str), "ที่มีอยู่ภายในเซิร์ฟเวอร์ซึ่งสามารถดูได้ที่เว็บ %s\n", WEB_SITE_FORUM);
		strcat(longstr, str);
	}

	Dialog_Show(playerid, DEFAULT_DIALOG, DIALOG_STYLE_MSGBOX, "Player Guied", longstr, "ยืนยัน", "");
	return 1;
}
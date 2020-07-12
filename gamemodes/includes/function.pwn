/**
 *  ให้ค่าประสบการณ์กับผู้เล่นพร้อมอัปเดต UI
 * @param {amount} เลขจำนวนเต็ม
 * ใช้ฟังก์ชั่น UpdatePlayerEXPBar ที่อยู่ใน ui.pwn
 */
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
	
	format(sendString, 90, "%s %d, %d %02d:%02d:%02d", MonthStr, day, year, hour, minute, second);
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



forward FunctionPlayers();
public FunctionPlayers()
{
	foreach (new i : Player)
	{
		if (PlayerInfo[i][pAdminjailed] == true)
		{
			PlayerInfo[i][pAdminjailTime]--; 
			
			if(PlayerInfo[i][pAdminjailTime] < 1)
			{
				PlayerInfo[i][pAdminjailed] = false; 
				PlayerInfo[i][pAdminjailTime] = 0; 
				
				SendServerMessage(i, "คุณถูกปล่อยตัวออกจากคุกแอดมินแล้ว");
				
				new str[128];
				format(str, sizeof(str), "%s ได้ถูกปล่อยตัวออกจากคุกแอดมินแล้ว.", ReturnName(i));
				SendAdminMessage(1, str);
				
				SpawnPlayer(i);
			}
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
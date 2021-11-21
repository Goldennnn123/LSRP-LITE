#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

#define NORMAL_SKILL	1
#define MEDIUM_SKILL	2
#define FULL_SKILL		3


new const g_aWeaponSlots[] = {
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11, 0, 0
};


stock ReturnWeaponName(weaponid)
{
	new weapon[22];
    switch(weaponid)
    {
        case 0: weapon = "Hand";
        case 18: weapon = "Bottle Bomb";
        case 44: weapon = "Night Vision Goggles";
        case 45: weapon = "Thermal Goggles";
		case 54: weapon = "Fall";
        default: GetWeaponName(weaponid, weapon, sizeof(weapon));
    }
    return weapon;
}

stock ReturnWeaponIDSlot(weaponid)
{
	new returnID;
	
	switch(weaponid)
	{
		case 1 .. 10: returnID = 0;
		case 11 .. 18, 41, 43: returnID = 1;
		case 22 .. 24: returnID = 2;
		case 25, 27 .. 34: returnID = 3;
	}

	return returnID;
}

stock WeaponDataSlot(weaponid)
{
	new slot;
	
	switch (weaponid)
	{
		case 1: slot = 0;
		case 2 .. 9: slot = 1; 
		case 10 .. 15: slot = 10; 
		case 16 .. 18: slot = 8;
		case 41, 43: slot = 9; 
		case 24: slot = 2;
		case 22: slot = 2;
		case 25: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6; 
	}
	return slot;
}

stock RemovePlayerWeapon(playerid, weaponid)
{
	if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50)
	    return;
	new saveweapon[13], saveammo[13];
	for(new slot = 0; slot < 13; slot++)
	    GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
		
	ResetPlayerWeapons(playerid);
	for(new slot; slot < 13; slot++)
	{
		if(saveweapon[slot] == weaponid || saveammo[slot] == 0)
			continue;
		GivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
	}

	GivePlayerWeapon(playerid, 0, 1);
}

stock TakePlayerGuns(playerid)
{
	for(new i = 0; i < 13; i++) if(PlayerInfo[playerid][pWeaponsAmmo][i])
		PlayerInfo[playerid][pWeapons][i] = 0;  
		
	ResetPlayerWeapons(playerid); 
	return 1;
}

forward GivePlayerGun(playerid, weaponid, ammo);
public GivePlayerGun(playerid, weaponid, ammo)
{
	new idx = ReturnWeaponIDSlot(weaponid); 
	
	if(PlayerInfo[playerid][pGun][idx])
		RemovePlayerWeapon(playerid, PlayerInfo[playerid][pGun][idx]);
	
	GivePlayerWeapon(playerid, weaponid, ammo); 
	PlayerInfo[playerid][pGun][idx] = weaponid;
	PlayerInfo[playerid][pGunAmmo][idx] = ammo;
	return 1;
}


stock PlayerHasWeapons(playerid)
{
	new countWeapons = 0;
	
	for(new i = 0; i < 4; i ++)
	{
		if(PlayerInfo[playerid][pGun][i] != 0)
			countWeapons++;
	}
	if(countWeapons == 0)
		return 0;
		
	if(countWeapons > 0)
		return 1;
		
	return 1;
}

stock PlayerHasWeapon(playerid, weaponid)
{
	if(PlayerInfo[playerid][pGun][ReturnWeaponIDSlot(weaponid)] != weaponid)
		return 0;

	return 1;
}


ptask OnWeaponsUpdate[1000](playerid) 
{
	if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		return 1;

	if(!PlayerHasWeapons(playerid))
		return 1;
		
			
	for (new w = 0; w < 4; w++)
	{
		new idx = WeaponDataSlot(PlayerInfo[playerid][pGun][w]); 
			
		if(PlayerInfo[playerid][pGun][w] != 0 && PlayerInfo[playerid][pGunAmmo][w] > 0)
		{
			GetPlayerWeaponData(playerid, idx, PlayerInfo[playerid][pGun][w], PlayerInfo[playerid][pGunAmmo][w]); 
		}
			
		if(PlayerInfo[playerid][pGun][w] != 0 && PlayerInfo[playerid][pGunAmmo][w] == 0)
		{
			PlayerInfo[playerid][pGun][w] = 0;
			//Removing 0 ammo weapons;
		}
	}
	return 1;
}



hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		new
			Float:health,
			Float:armor,
			Float:amount_armour
		;
		
		PlayerInfo[playerid][pLastDamagetime] = gettime();
		GetPlayerHealth(playerid, health);
		GetPlayerArmour(playerid, armor);
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE && PlayerInfo[playerid][pDeathFix])
			SetPlayerHealth(playerid, 500); 
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{
			if(PlayerInfo[issuerid][pTaser] && weaponid == 23)
			{
				if(!Player_IsNearPlayer(playerid, issuerid, 13))
					return SendErrorMessage(issuerid, "คุณยิงในระยะที่ไกลเกินไป ไปให้ใกล้กว่านี้");

				ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
				SendNearbyMessage(playerid, 3.5, COLOR_EMOTE, "> %s ถูกยิงด้วยปืนช็อตไฟฟ้าและล้มลงไปกับพื้น",ReturnName(playerid,0));
				
				SetTimerEx("PlayerTazer", 10000, false, "d", playerid);
				TogglePlayerControllable(playerid, 0);
				return 1;
			}

			if(GetPVarInt(issuerid, "Rubberbullets") && weaponid == 25)
			{
				if(health < 25)
				{
					ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
					SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s ถูกยิงโดยเรมิงตันและล้มลงกับพื้น", ReturnRealName(playerid));
					SendClientMessageEx(issuerid, COLOR_YELLOW, "SERVER: คุณยิง %s ด้วยกระสุนยาง", ReturnRealName(playerid));
					SendClientMessage(playerid, COLOR_LIGHTRED, "ตอนนี้คุณถูกยิงด้วยกระสุนยางจนล้มลงกับพื้น หากคุณมีการขัดขืนโดยการลุกขึ้น คุณจะถูกส่งคุกแอดมินในทันที");
					SendClientMessage(playerid, COLOR_LIGHTRED, "ซึ่งจะถูกส่งในข้อหา Powergaming ในทันทีหากคุณมีการ ลุกขึ้นวิ่งหนีได้");
					SetPlayerDrunkLevel(playerid, 3500);
					return 1;
				}
				
				GivePlayerHealth(playerid, -20);
				SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "> %s ถูกยิงโดยเรมิงตัน", ReturnRealName(playerid));
		      	SendClientMessageEx(issuerid, COLOR_YELLOW, "SERVER: คุณยิง %s ด้วยกระสุนยาง", ReturnRealName(playerid));
				SetPlayerDrunkLevel(playerid, 2500);
				return 1;
			}
			
			if(armor && bodypart == BODY_PART_CHEST)
			{
				switch(weaponid)
				{
					case 0: amount = 1;
					case 1: amount = 1;
					case 2,3,4: amount = 3;
					case 5,6,7,8,15: amount = 5;
					case 11,12,13,14: amount = 0;
					case 22: { amount_armour = 15; amount = 5; }
					case 23: amount = 0;
					case 24: { amount_armour = 50; amount = 10; }
					case 25: { amount_armour = 50; amount = 15; }
					case 26: { amount_armour = 25; amount = 10; }
					case 27: { amount_armour = 50; amount = 12; }
					case 28,32: { amount_armour = 10; amount = 5; }
					case 29: { amount_armour = 35; amount = 13; }
					case 30: { amount_armour = 40; amount = 14; }
					case 31: { amount_armour = 45; amount = 16; }
					case 33,34: { amount_armour = 100; amount = 50; }
					case 35,36,37,38,39,41,42,10: { amount_armour = 0; amount = 0; }
				}

			}
			else if(bodypart == BODY_PART_CHEST)
			{
				switch(weaponid)
				{
					case 0: amount = 2;
					case 1: amount = 1;
					case 2,3,4: amount = 5;
					case 5,6,7,8,15: amount = 5;
					case 9: amount = 50;
					case 11,12,13,14: amount = 0;
					case 22: amount = 15;
					case 23: amount = 0;
					case 24: {amount = 60; }
					case 25: {amount = 65; }
					case 26: {amount = 35; }
					case 27: {amount = 62; }
					case 28,32: {amount = 15; }
					case 29: {amount = 48; }
					case 30: {amount = 54; }
					case 31: {amount = 61; }
					case 33,34: {amount = 150; }
					case 35,36,37,38,39,41,42,10: {amount = 0;}
				}
			}
			else if(bodypart == BODY_PART_HEAD)
			{
				switch(weaponid)
				{
					case 0: amount = 2;
					case 1: amount = 1;
					case 2,3,4: amount = 3;
					case 5,6,7,8,15: amount = 5;
					case 9: amount = 50;
					case 11,12,13,14: amount = 0;
					case 22: amount = 35;
					case 23: amount = 0;
					case 24: {amount = 75; }
					case 25: {amount = 150; }
					case 26: {amount = 100; }
					case 27: {amount = 100; }
					case 28,32: {amount = 35; }
					case 29: {amount = 50; }
					case 30: {amount = 95; }
					case 31: {amount = 90; }
					case 33,34: {amount = 250; }
					case 35,36,37,38,39,41,42,10: {amount = 0;}
				}
			}
			else if(bodypart == BODY_PART_LEFT_ARM || bodypart == BODY_PART_RIGHT_ARM || bodypart == BODY_PART_LEFT_LEG || bodypart == BODY_PART_RIGHT_LEG)
			{
				switch(weaponid)
				{
					case 0: amount = 2;
					case 1: amount = 1;
					case 2,3,4: amount = 3;
					case 5,6,7,8,15: amount = 5;
					case 9: amount = 50;
					case 11,12,13,14,35,36,37,38,39,41,42,10,23: amount = 0;
					case 22: amount = 15;
					case 24: {amount = 20; }
					case 25,26,27: {amount = 35; }
					case 28,32: {amount = 15; }
					case 29: {amount = 20; }
					case 30: {amount = 25; }
					case 31: {amount = 35; }
					case 33,34: {amount = 60; }
				}
			}
			else GivePlayerHealth(playerid, -3);

			GivePlayerHealth(playerid, -amount);
			GivePlayerArmour(playerid, -amount_armour);
			CallbackDamages(playerid, issuerid, bodypart, weaponid, amount, amount_armour); 
		}
		
		if(health - amount <= 4)
		{
			if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
			{
				if(IsPlayerInAnyVehicle(playerid))
					ClearAnimations(playerid); 
				
				SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED);
				CallLocalFunction("OnPlayerWounded", "iii", playerid, issuerid, weaponid); 
				return 0;
			}
			
			return 0;
		}
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
		{	
			CallLocalFunction("OnPlayerDead", "iiii", playerid, issuerid, weaponid, 1);
			return 0;
		}
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		{
			SetPlayerHealth(playerid, health);
			return 0;
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_PLAYER) //Death system; 
	{	
		if(GetPlayerTeam(hitid) == PLAYER_STATE_WOUNDED && !PlayerInfo[hitid][pDeathFix])
		{	
			CallLocalFunction("OnPlayerDead", "iii", hitid, playerid, weaponid);
			return 0; 
		} 
		else if(GetPlayerTeam(hitid) != PLAYER_STATE_ALIVE)
			return 0; 
			
	}
	return 1;
}

forward PlayerTazer(playerid);
public PlayerTazer(playerid)
{
	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);
	TogglePlayerControllable(playerid, 1);
	return 1;
}


stock ReturnBodypartName(bodypart)
{
	new bodyname[20];
	
	switch(bodypart)
	{
		case BODY_PART_CHEST:bodyname = "ลำตัว";
		case BODY_PART_GROIN:bodyname = "หน้าขา";
		case BODY_PART_LEFT_ARM:bodyname = "แขนซ้าย";
		case BODY_PART_RIGHT_ARM:bodyname = "แขนขวา";
		case BODY_PART_LEFT_LEG:bodyname = "ขาซ้าย";
		case BODY_PART_RIGHT_LEG:bodyname = "ขาขวา";
		case BODY_PART_HEAD:bodyname = "หัว";
	}
	
	return bodyname;
}

stock CallbackDamages(playerid, issuerid, bodypart, weaponid, Float:amount, Float:armor)
{
	new
		id
	;
	
	TotalPlayerDamages[playerid] ++; 
	
	for(new i = 0; i < 100; i++)
	{
		if(!DamageInfo[playerid][i][eDamageTaken])
		{
			id = i;
			break;
		}
	}
	
	if(armor > 1.0 && bodypart == BODY_PART_CHEST)
		DamageInfo[playerid][id][eDamageArmor] = floatround(armor, floatround_round);
		
	else DamageInfo[playerid][id][eDamageArmor] = 0;
	
	DamageInfo[playerid][id][eDamageTaken] = floatround(amount, floatround_round); 
	DamageInfo[playerid][id][eDamageWeapon] = weaponid;
	
	DamageInfo[playerid][id][eDamageBodypart] = bodypart; 
	DamageInfo[playerid][id][eDamageTime] = gettime();
	
	DamageInfo[playerid][id][eDamageBy] = PlayerInfo[issuerid][pDBID]; 
	return 1; 
}

stock ShowPlayerDamages(damageid, playerid, adminView)
{
	new
		caption[33],
		str[355], 
		longstr[1200]
	; 
	
	format(caption, sizeof(caption), "%s", ReturnName(damageid));
	
	if (TotalPlayerDamages[damageid] < 1)
		return Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, "ไม่ได้รับความเสียหาย...", "<<", ""); 

	switch(adminView)
	{
		case 0:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				if(gettime() - DamageInfo[damageid][i][eDamageTime] > 1000)
					continue;
					
				format(str, sizeof(str), "%d ดาเมจ จาก %s โดย %s (เกราะ: %d) %d วินาทีที่แล้ว\n", DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
		case 1:
		{
			for(new i = 0; i < 100; i ++)
			{
				if(!DamageInfo[damageid][i][eDamageTaken])
					continue;
					
				format(str, sizeof(str), "{FF6346}(%s){FFFFFF} %d ดาเมจ จาก %s โดย %s (เกราะ: %d) %d วินาทีที่แล้ว\n", ReturnDBIDName(DamageInfo[damageid][i][eDamageBy]), DamageInfo[damageid][i][eDamageTaken], ReturnWeaponName(DamageInfo[damageid][i][eDamageWeapon]), ReturnBodypartName(DamageInfo[damageid][i][eDamageBodypart]), DamageInfo[damageid][i][eDamageArmor], gettime() - DamageInfo[damageid][i][eDamageTime]); 
				strcat(longstr, str); 
			}
			
			Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, caption, longstr, "<<", ""); 
		}
	}
	return 1;
}

stock ClearDamages(playerid)
{
	for(new i = 0; i < 100; i++)
	{
		DamageInfo[playerid][i][eDamageTaken] = 0;
		DamageInfo[playerid][i][eDamageBy] = 0; 
		
		DamageInfo[playerid][i][eDamageArmor] = 0;
		DamageInfo[playerid][i][eDamageBodypart] = 0;
		
		DamageInfo[playerid][i][eDamageTime] = 0;
		DamageInfo[playerid][i][eDamageWeapon] = 0; 
	}
	
	return 1;
}

forward OnPlayerLeaveWeapon(index);
public OnPlayerLeaveWeapon(index)
{
	new str[120];
	format(str, sizeof(str), "Weapons %s(Ammo:%d) of %s(%d) Time Out it Remove", ReturnWeaponName(WeaponDropInfo[index][eWeaponWepID]),WeaponDropInfo[index][eWeaponWepID], WeaponDropInfo[index][eWeaponWepAmmo],ReturnDBIDName(WeaponDropInfo[index][eWeaponDroppedBy]),WeaponDropInfo[index][eWeaponDroppedBy]);
	SendDiscordMessageEx("weapons", str);

	WeaponDropInfo[index][eWeaponDropped] = false;
	WeaponDropInfo[index][eWeaponDroppedBy] = 0;
	
	WeaponDropInfo[index][eWeaponWepAmmo] = 0;
	WeaponDropInfo[index][eWeaponWepID] = 0;
	
	for(new i = 0; i < 3; i++)
	{
		WeaponDropInfo[index][eWeaponPos][i] = 0.0;
	}
	
	if(IsValidDynamicObject(WeaponDropInfo[index][eWeaponObject]))
	{
		DestroyDynamicObject(WeaponDropInfo[index][eWeaponObject]);
	}

	return 1;
}

forward OnPlayerWounded(playerid, killerid, reason);
public OnPlayerWounded(playerid, killerid, reason)
{
	new
		str[128]
	;
	
	PlayerInfo[playerid][pDeathFix] = 1; 
	
	format(str, sizeof(str), "%s ถูกสังหารโดย %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason)); 
	SendAdminMessageEx(COLOR_RED, 1, str); 
	format(str, sizeof(str), "%s abused by %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason));
	SendDiscordMessage("death", str); 

	GameTextForPlayer(playerid, "~b~BRUTALLY WOUNDED", 5000, 3);
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);		
	
	SetPlayerHealth(playerid, 26); 
	//SetPlayerWeather(playerid, 250); 
	
	//GiveMoney(playerid, -200); 
	SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED);
	ResetPlayerWeapons(playerid);

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
	
	SendClientMessage(playerid, COLOR_RED, "ตอนนี้คุณบาดเจ็บสาหัสคุณยังไม่ตาย");
	SendClientMessage(playerid, COLOR_RED, "สามารถยอมรับการตายโดยการพิมพ์: /acceptdeath."); 
	return 1;
}

forward OnPlayerDead(playerid, killerid, reason, executed);
public OnPlayerDead(playerid, killerid, reason, executed)
{
	new
		str[128]
	;
	
	if(executed == 1)
	{
		format(str, sizeof(str), "%s โดนสังหารซ้ำโดย %s. (%s)", ReturnName(playerid), ReturnName(killerid), ReturnWeaponName(reason)); 
		SendAdminMessageEx(COLOR_RED, 1, str);
		Log(DeathLog, WARNING, "[KILL] %s Has Been Murder by %s. (%s)", ReturnName(playerid, 0), ReturnName(killerid, 0), ReturnWeaponName(reason));
		format(str, sizeof(str), "[KILL] %s Has Been Murder by %s. (%s)", ReturnName(playerid, 0), ReturnName(killerid, 0), ReturnWeaponName(reason));
		SendDiscordMessage("death", str); 
	}
	
	SetPlayerTeam(playerid, PLAYER_STATE_DEAD); 
	PlayerInfo[playerid][pRespawnTime] = gettime(); 
	
	SendClientMessage(playerid, COLOR_YELLOWEX, "-> ตอนนี้คุณได้เสียชีวิตแล้วคุณจะสามารถเกิดได้ในอีก 60 วินาที ถึงจะพิมพ์/respawnme เพื่อไปเกิดได้"); 
	
	ClearAnimations(playerid, 1);
	for(new i =0; i <4; i++)
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	
	TogglePlayerControllable(playerid, 0);
	SetPlayerWeather(playerid, globalWeather); 
	CharacterSave(playerid);
	return 1;
}


stock ShowPlayerWeapons(playerid, slotid)
{
	new returnStr[60];
	
	switch(slotid)
	{
		case 1:
		{
			new str_1slot[60];
			
			if(!PlayerInfo[playerid][pGun][0])
				str_1slot = "ไม่มี"; 
				
			else
				format(str_1slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pGun][0]));
				
			returnStr = str_1slot;
		}
		case 2:
		{
			new str_2slot[60];
			
			if(!PlayerInfo[playerid][pGun][1])
				str_2slot = "ไม่มี"; 
				
			else
				format(str_2slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pGun][1]));
				
			returnStr = str_2slot;
		}
		case 3:
		{
			new str_3slot[60];
			
			if(!PlayerInfo[playerid][pGun][2])
				str_3slot = "ไม่มี"; 
				
			else
				format(str_3slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pGun][2]));
				
			returnStr = str_3slot;
		}
		case 4:
		{
			new str_4slot[60];
			
			if(!PlayerInfo[playerid][pGun][3])
				str_4slot = "ไม่มี"; 
				
			else
				format(str_4slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pGun][3]));
				
			returnStr = str_4slot;
		}
	}
	return returnStr;
}

stock ReturnWeaponsModel(weaponid)
{
    new WeaponModels[] =
    {
        0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
        325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
        353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
        367, 368, 368, 371
    };
    return WeaponModels[weaponid];
}

SetPlayerWeaponSkill(playerid, skill) {
	switch(skill) {
	    case NORMAL_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, i, 200);
            SetPlayerSkillLevel(playerid, 0, 40);
            SetPlayerSkillLevel(playerid, 6, 50);
	    }
	    case MEDIUM_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, i, 500);
            SetPlayerSkillLevel(playerid, 0, 500);
            SetPlayerSkillLevel(playerid, 6, 500);
	    }
	    case FULL_SKILL: {
            for(new i = 0; i != 11;++i) SetPlayerSkillLevel(playerid, i, 999);
            SetPlayerSkillLevel(playerid, 0, 998);
            SetPlayerSkillLevel(playerid, 6, 998);
	    }
	}
}

stock SetPlayerWeapons(playerid)
{
	if(PlayerInfo[playerid][pGun][0] > 0)
	{
		GivePlayerWeaponEx(playerid, PlayerInfo[playerid][pGun][0], PlayerInfo[playerid][pGunAmmo][0]);
		SendClientMessageEx(playerid, COLOR_WHITE, "ในตัวคุณมีอาวุธ %s กระสุน %d นัด",ReturnWeaponName(PlayerInfo[playerid][pGun][0]), PlayerInfo[playerid][pGunAmmo][0]);
	}
	if(PlayerInfo[playerid][pGun][1] > 0)
	{
		GivePlayerWeaponEx(playerid, PlayerInfo[playerid][pGun][1], PlayerInfo[playerid][pGunAmmo][1]);
		SendClientMessageEx(playerid, COLOR_WHITE, "ในตัวคุณมีอาวุธ %s กระสุน %d นัด",ReturnWeaponName(PlayerInfo[playerid][pGun][1]), PlayerInfo[playerid][pGunAmmo][1]);
	}

	if(PlayerInfo[playerid][pGun][2] > 0)
	{
		GivePlayerWeaponEx(playerid, PlayerInfo[playerid][pGun][2], PlayerInfo[playerid][pGunAmmo][2]);
		SendClientMessageEx(playerid, COLOR_WHITE, "ในตัวคุณมีอาวุธ %s กระสุน %d นัด",ReturnWeaponName(PlayerInfo[playerid][pGun][2]), PlayerInfo[playerid][pGunAmmo][2]);
	}

	if(PlayerInfo[playerid][pGun][3] > 0)
	{
		
		GivePlayerWeaponEx(playerid, PlayerInfo[playerid][pGun][3], PlayerInfo[playerid][pGunAmmo][3]);
		SendClientMessageEx(playerid, COLOR_WHITE, "ในตัวคุณมีอาวุธ %s กระสุน %d นัด",ReturnWeaponName(PlayerInfo[playerid][pGun][3]), PlayerInfo[playerid][pGunAmmo][3]);
	}	

	SetPlayerArmedWeapon(playerid, 0);
	return 1;
}


stock ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 4; i ++) {
		PlayerInfo[playerid][pGun][i] = 0;
		PlayerInfo[playerid][pGunAmmo][i] = 0;
	}
	return 1;
}


stock IsMelee(weaponid)
{
    if(weaponid >= 1 && weaponid <= 15) return true;
	//switch(weaponid) { case 1..8,10..13,43: { return 1; } }
	return 0;
}


stock IsPrimary(weaponid)
{
    if(weaponid >= 25 && weaponid <= 33) return true;
	//switch(weaponid) { case 25,27,29..34: { return 1; } }
	return 0;
}

stock IsSecondary(weaponid)
{
    if(weaponid >= 22 && weaponid <= 24) return true;
	//switch(weaponid) { case 22..24: { return 1; } }
	return 0;
}

stock RemoveWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
	    if (PlayerInfo[playerid][pWeapons][i] != weaponid) {
	        GivePlayerWeapon(playerid, PlayerInfo[playerid][pWeapons][i], PlayerInfo[playerid][pWeaponsAmmo][i]);
		}
		else {
            PlayerInfo[playerid][pWeapons][i] = 0;
            PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
	    }
	}
	return 1;
}

IsInvalidWeapon(weaponid)
{
	if(weaponid == 34 || weaponid == 35 || weaponid == 16 || weaponid == 18) return 1;
	else return 0;
}


stock GivePlayerValidWeapon(playerid, weaponid, ammo, license=0)
{
	#pragma unused license

	if (weaponid < 0 || weaponid > 46)
	    return 0;

    RemoveWeapon(playerid, weaponid);

	if(!IsInvalidWeapon(weaponid))
	{
		if(IsMelee(weaponid))
		{
		    PlayerInfo[playerid][pGun][0] = weaponid;
		    PlayerInfo[playerid][pGunAmmo][0] = ammo;
		    SendClientMessageEx(playerid, COLOR_GREEN, "[Melee] คุณจะเกิดด้วย %s", ReturnWeaponName(weaponid));
		}
		else if(IsPrimary(weaponid))
		{
		    PlayerInfo[playerid][pGun][3] = weaponid;
		    PlayerInfo[playerid][pGunAmmo][3] = ammo;
		    SendClientMessageEx(playerid, COLOR_GREEN, "[Primary weapon] คุณจะเกิดด้วย %s", ReturnWeaponName(weaponid));

		    
		}
		else if(IsSecondary(weaponid))
		{
		    PlayerInfo[playerid][pGun][2] = weaponid;
		    PlayerInfo[playerid][pGunAmmo][2] = ammo;
		    SendClientMessageEx(playerid, COLOR_GREEN, "[Secondary weapon] คุณจะเกิดด้วย %s", ReturnWeaponName(weaponid));

		}
	}

	PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = ammo;

	GivePlayerWeapon(playerid, weaponid, ammo);
	return license;
}


stock GivePlayerWeaponEx(playerid, weaponid, ammo)
{
	if (weaponid < 0 || weaponid > 46)
	    return 0;


	PlayerInfo[playerid][pWeapons][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerInfo[playerid][pWeaponsAmmo][g_aWeaponSlots[weaponid]] = ammo;

	return GivePlayerWeapon(playerid, weaponid, ammo);
}



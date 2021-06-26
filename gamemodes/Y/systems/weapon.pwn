#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

stock ReturnWeaponName(weaponid)
{
	new weapon[22];
    switch(weaponid)
    {
        case 0: weapon = "Fists";
        case 18: weapon = "Molotov Cocktail";
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
	
	if(PlayerInfo[playerid][pWeapons][idx])
	{
		RemovePlayerWeapon(playerid, PlayerInfo[playerid][pWeapons][idx]);
		printf("A weapon was removed. Slot: %i, Weapon: %i", idx, PlayerInfo[playerid][pWeapons][idx]);
	}
	
	GivePlayerWeapon(playerid, weaponid, ammo); 
	
	PlayerInfo[playerid][pWeapons][idx] = weaponid;
	PlayerInfo[playerid][pWeaponsAmmo][idx] = ammo;
	
	PlayerInfo[playerid][pWeaponsImmune] = gettime();
	
	printf("Weapon given: IDX: %i, Weapon ID: %i", idx, PlayerInfo[playerid][pWeapons][idx]); 
	return 1;
}


stock PlayerHasWeapons(playerid)
{
	new countWeapons = 0;
	
	for(new i = 0; i < 13; i ++)
	{
		if(PlayerInfo[playerid][pWeapons][i] != 0)
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
	if(PlayerInfo[playerid][pWeapons][ReturnWeaponIDSlot(weaponid)] != weaponid)
		return 0;

	return 1;
}


forward OnWeaponsUpdate();
public OnWeaponsUpdate()
{
	foreach(new i : Player)
	{
		if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
			continue;
		
		if(!PlayerHasWeapons(i))
			continue;
			
		for (new w = 0; w < 13; w++)
		{
			new idx = WeaponDataSlot(PlayerInfo[i][pWeapons][w]); 
			
			if(PlayerInfo[i][pWeapons][w] != 0 && PlayerInfo[i][pWeaponsAmmo][w] > 0)
			{
				GetPlayerWeaponData(i, idx, PlayerInfo[i][pWeapons][w], PlayerInfo[i][pWeaponsAmmo][w]); 
			}
			
			if(PlayerInfo[i][pWeapons][w] != 0 && PlayerInfo[i][pWeaponsAmmo][w] == 0)
			{
				PlayerInfo[i][pWeapons][w] = 0;
				//Removing 0 ammo weapons;
			}
		}
			
		return 1;
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
			SetPlayerHealth(playerid, health); 
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{
			if(weaponid == 23)
			{
				if(PlayerInfo[issuerid][pTaser] == false)
				{
					SendAdminMessageEx(COLOR_RED, 1, "%s ใช้ Tazer โดยที่ไม่ได้มีการ /tazer", ReturnRealName(issuerid, 0));
					return 0;
				}
				
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					TogglePlayerControllable(playerid, 0);
					ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);
					
					new str_msg[128];
					format(str_msg, sizeof(str_msg), "ได้ถูกปืนช็อตไฟฟ้ายิงเข้าไปที่ลำตัวของและนอนลงไปกับพื้น");
					callcmd::me(playerid, str_msg);

					SetTimerEx("PlayerTazer", 10000, false, "i", playerid);
				}
			}
			if(weaponid == 24)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor)
					{
						amount_armour = 35;
						amount = 25;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 45;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor)
					{
						amount_armour = 15;
						amount = 5;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 20;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 25)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 50;
						amount = 26;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 50;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 25;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 15;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 31)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 45;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 35;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 22.5;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 10;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == WEAPON_SNIPER)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 100;
						amount = 50;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 75;
						SetPlayerHealth(playerid, health - amount);
					}

					if(bodypart == BODY_PART_HEAD)
					{
						amount = 100;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 100;
						amount = 45;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 60;
						SetPlayerHealth(playerid, health - amount);
					}

					if(bodypart == BODY_PART_HEAD)
					{
						amount = 100;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 0)
			{
				if(armor)
				{
					amount = 0;
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 5;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 1)
			{
				if(armor)
				{
					amount_armour = 10;
					amount = 1;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid,health - amount);
				}
				else
				{
					amount = 10;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 2)
			{
				if(armor)
				{
					amount_armour = 5;
					amount = 1;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 5;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 3)
			{
				if(armor)
				{
					amount_armour = 15;
					amount = 2;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 20;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 4)
			{
				if(armor)
				{
					amount_armour = 0;
					amount = 1;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 50;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 5)
			{
				if(armor)
				{
					amount_armour = 25;
					amount = 2;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 45;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 6)
			{
				if(armor)
				{
					amount_armour = 25;
					amount = 3;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 45;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 7)
			{
				if(armor)
				{
					amount_armour = 0;
					amount = 0;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 2;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 8)
			{
				if(armor)
				{
					amount_armour = 0;
					amount = 1;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 50;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 9)
			{
				if(armor)
				{
					amount_armour = 15;
					amount = 5;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 50;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 15)
			{
				if(armor)
				{
					amount_armour = 0;
					amount = 1;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 15;
					SetPlayerHealth(playerid, health - amount);
				}
			}
			if(weaponid == 22)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 10;
						amount = 5;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 85;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 5;
						amount = 2;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 45;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 27)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 45;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 90;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 35;
						amount = 10;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 45;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 28)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 10;
						amount = 5;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 35;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 6;
						amount = 3;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 25;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 29)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 50;
						amount = 10;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 65;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 25;
						amount = 5;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 45;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 30)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 45;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 35;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 22.5;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 10;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 32)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 25;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 45;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 15;
						amount = 10;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 35;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 33)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 50;
						amount = 25;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 95;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 25;
						amount = 15;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 85;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			if(weaponid == 38)
			{
				if(IsPlayerNearPlayer(playerid, issuerid, 15.0))
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 0;
						amount = 0;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 0;
						SetPlayerHealth(playerid, health - amount);
					}
				}
				else
				{
					if(armor && bodypart == BODY_PART_CHEST)
					{
						amount_armour = 0;
						amount = 0;
						SetPlayerArmour(playerid, armor - amount_armour);
						SetPlayerHealth(playerid, health - amount);
					}
					else
					{
						amount = 0;
						SetPlayerHealth(playerid, health - amount);
					}
				}
			}
			/*if(weaponid < 400 || weaponid > 611)
			{
				if(armor)
				{
					amount_armour = 10;
					amount = 2;
					SetPlayerArmour(playerid, armor - amount_armour);
					SetPlayerHealth(playerid, health - amount);
				}
				else
				{
					amount = 15;
					SetPlayerHealth(playerid, health - amount);
				}
			}*/
			//SetPlayerHealth(playerid, health - amount); 
			CallbackDamages(playerid, issuerid, bodypart, weaponid, amount, amount_armour); 
		}
		
		if(health - amount <= 4)
		{
			if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
			{
				if(IsPlayerInAnyVehicle(playerid))
					ClearAnimations(playerid); 
				
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

	GameTextForPlayer(playerid, "~b~BRUTALLY WOUNDED", 5000, 3);
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);		
	
	SetPlayerHealth(playerid, 26); 
	//SetPlayerWeather(playerid, 250); 
	
	GiveMoney(playerid, -200); 
	SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED); 


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
	}
	
	SetPlayerTeam(playerid, PLAYER_STATE_DEAD); 
	PlayerInfo[playerid][pRespawnTime] = gettime(); 
	
	SendClientMessage(playerid, COLOR_YELLOWEX, "-> ตอนนี้คุณได้เสียชีวิตแล้วคุณจะสามารถเกิดได้ในอีก 60 วินาที ถึงจะพิมพ์/respawnme เพื่อไปเกิดได้"); 
	
	ClearAnimations(playerid, 1);
	for(new i =0; i <4; i++)
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	
	TogglePlayerControllable(playerid, 0);
	SetPlayerWeather(playerid, globalWeather); 
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
			
			if(!PlayerInfo[playerid][pWeapons][0])
				str_1slot = "ไม่มี"; 
				
			else
				format(str_1slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][0]));
				
			returnStr = str_1slot;
		}
		case 2:
		{
			new str_2slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][1])
				str_2slot = "ไม่มี"; 
				
			else
				format(str_2slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][1]));
				
			returnStr = str_2slot;
		}
		case 3:
		{
			new str_3slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][2])
				str_3slot = "ไม่มี"; 
				
			else
				format(str_3slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][2]));
				
			returnStr = str_3slot;
		}
		case 4:
		{
			new str_4slot[60];
			
			if(!PlayerInfo[playerid][pWeapons][3])
				str_4slot = "ไม่มี"; 
				
			else
				format(str_4slot, 60, "%s", ReturnWeaponName(PlayerInfo[playerid][pWeapons][3]));
				
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

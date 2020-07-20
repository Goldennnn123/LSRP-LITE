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
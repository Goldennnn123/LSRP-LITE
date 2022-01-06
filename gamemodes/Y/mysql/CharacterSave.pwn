stock CharacterSave(playerid, force = false,thread = MYSQL_TYPE_THREAD)
{
	if(BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED) || force)
	{
		new query[MAX_STRING];

        mysql_init("characters", "char_dbid", PlayerInfo[playerid][pDBID], thread);

        mysql_int(query, "pWhitelist",PlayerInfo[playerid][pWhitelist]);
        mysql_int(query, "pLastSkin",PlayerInfo[playerid][pLastSkin]);
        mysql_int(query, "pAdmin",PlayerInfo[playerid][pAdmin]);
        mysql_int(query, "pTester",PlayerInfo[playerid][pTester]);
        mysql_int(query, "pTutorial",PlayerInfo[playerid][pTutorial]);

        mysql_int(query, "pFaction",PlayerInfo[playerid][pFaction]);
        mysql_int(query, "pBadge",PlayerInfo[playerid][pBadge]);
        mysql_int(query, "pFactionRank",PlayerInfo[playerid][pFactionRank]);

        mysql_int(query, "pCash",PlayerInfo[playerid][pCash]);
        mysql_int(query, "pPaycheck",PlayerInfo[playerid][pPaycheck]);
        mysql_int(query, "pBank",PlayerInfo[playerid][pBank]);
        mysql_int(query, "pSaving",PlayerInfo[playerid][pSaving]);

        mysql_int(query, "pLevel",PlayerInfo[playerid][pLevel]);
        mysql_int(query, "pExp",PlayerInfo[playerid][pExp]);

        mysql_int(query, "pSpawnPoint",PlayerInfo[playerid][pSpawnPoint]);
        mysql_int(query, "pSpawnHouse",PlayerInfo[playerid][pSpawnHouse]);


        GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
		GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

        
        mysql_flo(query, "pHealth",PlayerInfo[playerid][pHealth]);
        mysql_flo(query, "pArmour",PlayerInfo[playerid][pArmour]);

		if (PlayerInfo[playerid][pTimeout]) {

			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);

            mysql_int(query, "pLastInterior",PlayerInfo[playerid][pLastInterior]);
            mysql_int(query, "pLastWorld",PlayerInfo[playerid][pLastWorld]);

            mysql_flo(query, "pLastPosX",PlayerInfo[playerid][pLastPosX]);
            mysql_flo(query, "pLastPosY",PlayerInfo[playerid][pLastPosY]);
            mysql_flo(query, "pLastPosZ",PlayerInfo[playerid][pLastPosZ]);
            mysql_int(query, "RentCarKey",RentCarKey[playerid]);

            mysql_int(query, "pInsideBusiness",PlayerInfo[playerid][pInsideBusiness]);
            mysql_int(query, "pInsideProperty",PlayerInfo[playerid][pInsideProperty]);
		
			printf("[%d] %s: save last data", playerid, ReturnPlayerName(playerid));
		}

        if(PlayerInfo[playerid][pSpawnPoint] == SPAWN_AT_LASTPOS)
        {
            GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);

            mysql_int(query, "pLastInterior",PlayerInfo[playerid][pLastInterior]);
            mysql_int(query, "pLastWorld",PlayerInfo[playerid][pLastWorld]);

            mysql_flo(query, "pLastPosX",PlayerInfo[playerid][pLastPosX]);
            mysql_flo(query, "pLastPosY",PlayerInfo[playerid][pLastPosY]);
            mysql_flo(query, "pLastPosZ",PlayerInfo[playerid][pLastPosZ]);
            mysql_int(query, "pInsideBusiness",PlayerInfo[playerid][pInsideBusiness]);
            mysql_int(query, "pInsideProperty",PlayerInfo[playerid][pInsideProperty]);
        }

        mysql_int(query, "pTimeout",PlayerInfo[playerid][pTimeout]);


        mysql_int(query, "pJob",PlayerInfo[playerid][pJob]);
        mysql_int(query, "pSideJob",PlayerInfo[playerid][pSideJob]);
        mysql_int(query, "pCareer",PlayerInfo[playerid][pCareer]);
        mysql_int(query, "pJobRank",PlayerInfo[playerid][pJobRank]);
        mysql_int(query, "pFishes",PlayerInfo[playerid][pFishes]);
        mysql_int(query, "pJobExp",PlayerInfo[playerid][pJobExp]);

		
        
        mysql_bool(query, "pAdminjailed",PlayerInfo[playerid][pAdminjailed]);
        mysql_int(query, "pAdminjailTime",PlayerInfo[playerid][pAdminjailTime]);

        mysql_str(query, "pLastOnline",PlayerInfo[playerid][pLastOnline]);
        mysql_int(query, "pTimeplayed",PlayerInfo[playerid][pTimeplayed]);

        mysql_int(query, "pPhone",PlayerInfo[playerid][pPhone]);
        mysql_int(query, "pPhonePower",PlayerInfo[playerid][pPhonePower]);

        new str[MAX_STRING];

		for(new i = 0; i < 4; i++)
		{
            format(str, sizeof(str), "pWeapon%d",i);
            mysql_int(query, str,PlayerInfo[playerid][pGun][i]);
            
            format(str, sizeof(str), "pWeaponsAmmo%d",i);
            mysql_int(query, str,PlayerInfo[playerid][pGunAmmo][i]);
		}

		for(new i = 1; i < MAX_PLAYER_VEHICLES_V3; i++)
		{
            format(str, sizeof(str), "pOwnedVehicles%d",i);
            mysql_int(query, str,PlayerInfo[playerid][pOwnedVehicles][i]);
		}


        mysql_int(query, "pRadioOn",PlayerInfo[playerid][pRadioOn]);
        mysql_int(query, "pHasRadio",PlayerInfo[playerid][pHasRadio]);
        mysql_int(query, "pMainSlot",PlayerInfo[playerid][pMainSlot]);
		for(new i = 1; i < 3; i++)
		{
            format(str, sizeof(str), "pRadio%i",i);
            mysql_int(query, str,PlayerInfo[playerid][pRadio][i]);
		}


        mysql_int(query, "pDriverLicense",PlayerInfo[playerid][pDriverLicense]);
        mysql_int(query, "pDriverLicenseWarn",PlayerInfo[playerid][pDriverLicenseWarn]);
        mysql_int(query, "pDriverLicenseRevoke",PlayerInfo[playerid][pDriverLicenseRevoke]);
        mysql_int(query, "pDriverLicenseSus",PlayerInfo[playerid][pDriverLicenseSus]);


        mysql_int(query, "pWeaponLicense",PlayerInfo[playerid][pWeaponLicense]);
        mysql_int(query, "pWeaponLicenseType",PlayerInfo[playerid][pWeaponLicenseType]);
        mysql_int(query, "pWeaponLicenseRevoke",PlayerInfo[playerid][pWeaponLicenseRevoke]);
        mysql_int(query, "pWeaponLicenseSus",PlayerInfo[playerid][pWeaponLicenseSus]);

        mysql_int(query, "pPilotLicense",PlayerInfo[playerid][pPilotLicense]);
        mysql_int(query, "pPilotLicenseBlacklist",PlayerInfo[playerid][pPilotLicenseBlacklist]);
        mysql_int(query, "pPilotLicenseRevoke",PlayerInfo[playerid][pPilotLicenseRevoke]);

        mysql_int(query, "pMedicLicense",PlayerInfo[playerid][pMedicLicense]);
        mysql_int(query, "pMedicLicenseRevoke",PlayerInfo[playerid][pMedicLicenseRevoke]);
        
        mysql_int(query, "pTuckingLicense",PlayerInfo[playerid][pTuckingLicense]);
        mysql_int(query, "pTuckingLicenseWarn",PlayerInfo[playerid][pTuckingLicenseWarn]);
        mysql_int(query, "pTuckingLicenseSus",PlayerInfo[playerid][pTuckingLicenseSus]);
        mysql_int(query, "pTuckingLicenseRevoke",PlayerInfo[playerid][pTuckingLicenseRevoke]);

        mysql_int(query, "pTxaiLicense",PlayerInfo[playerid][pTxaiLicense]);


        mysql_int(query, "pCPU",PlayerInfo[playerid][pCPU]);
        mysql_int(query, "pRAM",PlayerInfo[playerid][pRAM]);
        mysql_int(query, "pStored",PlayerInfo[playerid][pStored]);
        mysql_flo(query, "pBTC",PlayerInfo[playerid][pBTC]);


        mysql_bool(query, "pArrest",PlayerInfo[playerid][pArrest]);
        mysql_int(query, "pArrestBy",PlayerInfo[playerid][pArrestBy]);
        mysql_int(query, "pArrestTime",PlayerInfo[playerid][pArrestTime]);
        mysql_int(query, "pArrestRoom",PlayerInfo[playerid][pArrestRoom]);


        for(new i = 1; i <= 3; i++)
        {
           format(str, sizeof(str), "pSkinClothing%i",i);
           mysql_int(query, str,PlayerInfo[playerid][pSkinClothing][i-1]);
        }


        mysql_int(query, "pDonater",PlayerInfo[playerid][pDonater]);

        if(PlayerInfo[playerid][pDonater])
        {
            mysql_bool(query, "pHasMask",PlayerInfo[playerid][pHasMask]);
        }

        mysql_int(query, "pOre",PlayerInfo[playerid][pOre]);
        mysql_int(query, "pCoal",PlayerInfo[playerid][pCoal]);
        mysql_int(query, "pIron",PlayerInfo[playerid][pIron]);
        mysql_int(query, "pCopper",PlayerInfo[playerid][pCopper]);
        mysql_int(query, "pKNO3",PlayerInfo[playerid][pKNO3]);


        mysql_int(query, "pCigare",PlayerInfo[playerid][pCigare]);

        /*mysql_int(query, "pVehicleSpawned",PlayerInfo[playerid][pVehicleSpawned]);
        mysql_int(query, "pVehicleSpawnedID",PlayerInfo[playerid][pVehicleSpawnedID]);*/

        mysql_int(query, "pBoomBox",PlayerInfo[playerid][pBoomBox]);

        mysql_str(query, "pTicket",PlayerInfo[playerid][pTicket]);

        
        for(new i = 1; i < MAX_PLAYER_CLOTHING; i++)
        {
            format(str, sizeof(str), "pClothing%d",i);
            mysql_int(query, str,PlayerInfo[playerid][pClothing][i-1]);
        }

        mysql_flo(query, "pDrug1",PlayerInfo[playerid][pDrug][0]);
        mysql_flo(query, "pDrug2",PlayerInfo[playerid][pDrug][1]);
        mysql_flo(query, "pDrug3",PlayerInfo[playerid][pDrug][2]);
        mysql_int(query, "pAddicted",PlayerInfo[playerid][pAddicted]);
	    mysql_int(query, "pAddictedCount",PlayerInfo[playerid][pAddictedCount]);

        mysql_int(query, "pWalk",PlayerInfo[playerid][pWalk]);
        mysql_int(query, "pFight",PlayerInfo[playerid][pFight]);
        mysql_bool(query, "pTogPm",PlayerInfo[playerid][pTogPm]);

        mysql_int(query, "pHouseKey",PlayerInfo[playerid][pHouseKey]);
        mysql_int(query, "pRepairBox",PlayerInfo[playerid][pRepairBox]);

		mysql_finish(query);
        
        SaveUCP(playerid);
	}
	return 1;
}

stock SaveUCP(playerid, force = false,thread = MYSQL_TYPE_THREAD)
{
    new query[150];
    if(BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED) || force)
    {
        GetPlayerIp(playerid, PlayerInfo[playerid][pActiveIP], PlayerInfo[playerid][pActiveIP]);

        mysql_init("masters", "acc_dbid", e_pAccountData[playerid][mDBID], thread);
        mysql_str(query, "forum_name",e_pAccountData[playerid][mForumName]);
        mysql_str(query, "active_ip",ReturnIP(playerid));
        mysql_finish(query);
    }
    return 1;
}
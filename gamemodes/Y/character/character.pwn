#include <YSI_Coding\y_hooks>

//Character Selection:
#define MAX_CHARSELECT_TEXTDRAW		(20) // +1 if display server logo, +5 for New Character button
#define MAX_CHARSELECT 				(5)

new PlayerText:charSelectTextDraw[MAX_PLAYERS][MAX_CHARSELECT_TEXTDRAW];
new charSelectTextDrawID[MAX_PLAYERS][MAX_CHARSELECT];
new charSelectTextDrawCount[MAX_PLAYERS];
new characterLister[MAX_PLAYERS][5][MAX_PLAYER_NAME + 1]; 


new characterPickTime[MAX_PLAYERS];

hook OnPlayerConnect(playerid) {
    characterPickTime[playerid] = 0;
	return 1;
}

forward selectCharacter(playerid);
public selectCharacter(playerid) {
	
    if(!cache_num_rows())
	{
		CreateNewCharacter(playerid);
		return 1;
	}
	
	new rows;
	cache_get_row_count(rows);
	
	if(rows)
	{
		new playerLevel, playerLastSkin;

		#if defined IN_GAME_CREATE_CHARACTER
			new Float:td_posX= 318.0 - (85.0 * float((rows > 3 ? 3 : rows) - ((rows < 3) ? 0 : 1))) + (5.0 * float((rows > 3 ? 3 : rows) - ((rows < 3) ? 0 : 1)));
		#else
			new Float:td_posX= 318.0 - (85.0 * float((rows > 3 ? 3 : rows) - 1)) + (5.0 * float((rows > 3 ? 3 : rows) - 1));
		#endif

		new Float:td_posY= 121.0;
		for (new i = 0; i < rows; i ++)
		{
			cache_get_value_name(i, "char_name", characterLister[playerid][i], 128);
			cache_get_value_name_int(i, "pLevel", playerLevel);
			cache_get_value_name_int(i, "pLastSkin", playerLastSkin);

			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX, td_posY, "_");
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.595833, 16.450000);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255.500000, 148.500000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 2);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 70);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 0);

            new str[128];
            format(str, sizeof(str), "%s~n~Level %d", characterLister[playerid][i], playerLevel);
			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX - 73.0, td_posY, str);
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.183329, 0.849995);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], td_posX + 82.0, 17.000000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 50);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 0);

			charSelectTextDrawID[playerid][i] = charSelectTextDrawCount[playerid];
			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX - 83.0, td_posY + 13.0, "Preview_Model");
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 5);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.600000, 2.000000);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 166.500000, 140.500000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetPreviewModel(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], playerLastSkin);
			PlayerTextDrawSetPreviewRot(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -8.000000, 0.000000, -1.000000, 0.979999);
			PlayerTextDrawSetPreviewVehCol(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 1, 1);

			td_posX += 160.0;

			if (i != 0 && i%2 == 0) {
				td_posY += 164;
				#if defined IN_GAME_CREATE_CHARACTER
					td_posX= 318.0 - (65.0 * float(rows - 3) - ((rows < 3) ? 0 : 1)) + (5.0 * float(rows - 3) - ((rows < 3) ? 0 : 1));
				#else
					td_posX= 318.0 - (65.0 * float(rows - 3) - 1) + (5.0 * float(rows - 3) - 1);
				#endif
			}
		}

		#if defined IN_GAME_CREATE_CHARACTER
		if (rows < 3) {
			new i  = rows + 1;
			format(characterLister[playerid][i], MAX_PLAYER_NAME + 1, "New Character");
			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX, td_posY, "_");
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.595833, 16.450000);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255.500000, 148.500000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 2);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 70);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 0);

			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX - 73.0, td_posY, "NEW CHARACTER");
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.183329, 0.849995);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], td_posX + 82.0, 17.000000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 50);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 0);

			charSelectTextDrawID[playerid][i] = charSelectTextDrawCount[playerid];
			charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]] = CreatePlayerTextDraw(playerid, td_posX - 83.0, td_posY + 13.0, "Preview_Model");
			PlayerTextDrawFont(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 5);
			PlayerTextDrawLetterSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0.600000, 2.000000);
			PlayerTextDrawTextSize(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 166.500000, 140.500000);
			PlayerTextDrawSetOutline(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetShadow(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawAlignment(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -1);
			PlayerTextDrawBackgroundColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawBoxColor(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 255);
			PlayerTextDrawUseBox(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 0);
			PlayerTextDrawSetProportional(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetSelectable(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 1);
			PlayerTextDrawSetPreviewModel(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], 264);
			PlayerTextDrawSetPreviewRot(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]], -8.000000, 0.000000, -1.000000, 0.979999);
			PlayerTextDrawSetPreviewVehCol(playerid, charSelectTextDraw[playerid][charSelectTextDrawCount[playerid]++], 1, 1);

			td_posX += 160.0;

			if (i != 0 && i%2 == 0) {
				td_posY += 164;
				td_posX= 318.0 - (65.0 * float(rows - 3)) + (5.0 * float(rows - 3));
			}
		}
		#endif

		for (new i; i < charSelectTextDrawCount[playerid]; i++)
			PlayerTextDrawShow(playerid, charSelectTextDraw[playerid][i]);

		SelectTextDraw(playerid, 0xFFFFFF95);
	}
    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(characterPickTime[playerid] > 0) 
	{
		for (new i; i != MAX_CHARSELECT; i++)
		{
			if (playertextid == charSelectTextDraw[playerid][charSelectTextDrawID[playerid][i]])
			{

				CancelSelectTextDraw(playerid);
				
				for (new x; x < charSelectTextDrawCount[playerid]; x++)
					PlayerTextDrawDestroy(playerid, charSelectTextDraw[playerid][x]);

				charSelectTextDrawCount[playerid]=0;
				
				if (strequal(characterLister[playerid][i], "New Character", true)) {
					CreateNewCharacter(playerid);
					return 1;
				}

				new 
					string[128], thread[128]
				;
				
				characterPickTime[playerid] = 0;

				format(string, sizeof(string), "คุณเลือกตัวละคร {145F0B}%s{FFFFFF}", characterLister[playerid][i]);
				SendClientMessage(playerid, -1, string);
				
				SetPlayerName(playerid, characterLister[playerid][i]); 
				
				mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM characters WHERE char_name = '%e' LIMIT 1", characterLister[playerid][i]);
				mysql_tquery(dbCon, thread, "Query_SelectCharacter", "i", playerid); 
				return 1;
			}
		}
		SelectTextDraw(playerid, 0xFFFFFF95);
	}
    return 1;
}

forward CheckBanList(playerid);
public CheckBanList(playerid)
{	
	if(!cache_num_rows())
	{
		new pname[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, pname, sizeof(pname));
		new maxname = strlen(pname);

		for(new i=0; i<maxname; i++)
		{
			if(pname[i] == '_')
			{
				SendServerMessage(playerid, "คุณไม่ได้ใส่ชื่อ Username โปรดออกไปใส่ชื่อเป็น Username เพื่อเข้าสู่ระบบ");
				return Dialog_Show(playerid, DIALOG_SET_USERNAME, DIALOG_STYLE_INPUT, "เปลี่ยนชื่อเป็น Username ที่คุณต้องการ", "ใส่ชื่อ Username ที่คุณต้องการเข้าสู่ระบบ หากมีชื่อผู้ใช้อยู่แล้วจะนำเข้าสู่ระบบต่อไป:", "ยืนยัน", "ยกเลิก");
			}
		}

		new existCheck[129];
	
		mysql_format(dbCon, existCheck, sizeof(existCheck), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
		mysql_tquery(dbCon, existCheck, "OnPlayerJoin", "d", playerid);
	}
	else
	{
		SendServerMessage(playerid, "ไอพี \"%s\" ถูกแบนออกจากเซืฟเวอร์", ReturnIP(playerid));
		SendServerMessage(playerid, "กรุณาติดต่อ ผู้ดูแลระบบเพื่อขอปลดแบน"); 
		return KickEx(playerid);
	}
	return 1;
}

ShowCharacterSelection(playerid) {
    new query[128];
    mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE master_id = %d", e_pAccountData[playerid][mDBID]);
    mysql_tquery(dbCon, query, "selectCharacter", "d", playerid);

    characterPickTime[playerid] = 1;
}

CharacterSave(playerid, force = false)
{
	if(BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED) || force)
	{
		new query[MAX_STRING];

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pLastSkin = %i, pAdmin = %i, pTutorial = %i, pFaction = %i, pCash = %i, pLevel = %i, pExp = %i, pSpawnPoint = %i,pSpawnHouse = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pLastSkin],
			PlayerInfo[playerid][pAdmin],
			PlayerInfo[playerid][pTutorial],
			PlayerInfo[playerid][pFaction],
			GetPlayerMoney(playerid),
			PlayerInfo[playerid][pLevel],
			PlayerInfo[playerid][pExp],
			PlayerInfo[playerid][pSpawnPoint],
			PlayerInfo[playerid][pSpawnHouse],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		if (PlayerInfo[playerid][pTimeout]) {
			/* 
				บันทึกข้อมูลที่ต้องใช้หลังจากเข้าเกม
			*/
			GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
			GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

			GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

			PlayerInfo[playerid][pLastInterior] = GetPlayerInterior(playerid);
			PlayerInfo[playerid][pLastWorld] = GetPlayerVirtualWorld(playerid);

			mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pHealth = %f, pArmour = %f, pLastPosX = %f, pLastPosY = %f, pLastPosZ = %f, pLastInterior = %i, pLastWorld = %i WHERE char_dbid = %i",	
				PlayerInfo[playerid][pHealth],
				PlayerInfo[playerid][pArmour],
				PlayerInfo[playerid][pLastPosX],
				PlayerInfo[playerid][pLastPosY],
				PlayerInfo[playerid][pLastPosZ],
				PlayerInfo[playerid][pLastInterior],
				PlayerInfo[playerid][pLastWorld],
				PlayerInfo[playerid][pDBID]);
			mysql_tquery(dbCon, query);
			
			printf("[%d] %s: save last data", playerid, ReturnPlayerName(playerid));
		}
		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pTimeout = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pTimeout],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pBank = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pBank],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pFactionRank = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pFactionRank],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pHasRadio = %i, pMainSlot = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pFactionRank],
			PlayerInfo[playerid][pMainSlot],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pJob = %i, pSideJob = %i, pCareer = %i, pJobRank = %i, pPaycheck = %i, pFishes = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pJob],
			PlayerInfo[playerid][pSideJob],
			PlayerInfo[playerid][pCareer],
			PlayerInfo[playerid][pJobRank],
			PlayerInfo[playerid][pPaycheck],
			PlayerInfo[playerid][pFishes],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE masters SET forum_name = '%e', active_ip = '%e' WHERE acc_dbid = %i",	
			e_pAccountData[playerid][mForumName],
			PlayerInfo[playerid][pActiveIP],
			e_pAccountData[playerid][mDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pAdminjailed = %i, pAdminjailTime = %i WHERE char_dbid = %i",	
			PlayerInfo[playerid][pAdminjailed],
			PlayerInfo[playerid][pAdminjailTime],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pLastOnline = '%e', pTimeplayed = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pLastOnline],
			PlayerInfo[playerid][pTimeplayed],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pPhone = %d, pPhonePower = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pPhone],
			PlayerInfo[playerid][pPhonePower],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		for(new i = 0; i < 13; i++)
		{
			mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pWeapon%d = %i, pWeaponsAmmo%d = %i WHERE char_dbid = %i",
				i,
				PlayerInfo[playerid][pWeapons][i],
				i,
				PlayerInfo[playerid][pWeaponsAmmo][i],
				PlayerInfo[playerid][pDBID]);
			mysql_tquery(dbCon, query);
		}

		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pOwnedVehicles%d = %i WHERE char_dbid = %i", i, PlayerInfo[playerid][pOwnedVehicles][i], PlayerInfo[playerid][pDBID]);
			mysql_tquery(dbCon, query);
		}

		for(new i = 1; i < 3; i++)
		{
			mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pRadio%i = %i WHERE char_dbid = %i", 
				i, 
				PlayerInfo[playerid][pRadio][i],
				PlayerInfo[playerid][pDBID]);
			mysql_tquery(dbCon, query);
		}


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pDriverLicense = %d, pDriverLicenseWarn = %d,pDriverLicenseRevoke = %d,pDriverLicenseSus = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pDriverLicense],
			PlayerInfo[playerid][pDriverLicenseWarn],
			PlayerInfo[playerid][pDriverLicenseRevoke],
			PlayerInfo[playerid][pDriverLicenseSus],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pWeaponLicense = %d, pWeaponLicenseType = %d,pWeaponLicenseRevoke = %d, pDriverLicenseSus = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pWeaponLicense],
			PlayerInfo[playerid][pWeaponLicenseType],
			PlayerInfo[playerid][pWeaponLicenseRevoke],
			PlayerInfo[playerid][pWeaponLicenseSus],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pPilotLicense = %d, pPilotLicenseBlacklist = %d,pPilotLicenseRevoke = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pPilotLicense],
			PlayerInfo[playerid][pPilotLicenseBlacklist],
			PlayerInfo[playerid][pPilotLicenseRevoke],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pMedicLicense = %d, pMedicLicenseRevoke = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pMedicLicense],
			PlayerInfo[playerid][pMedicLicenseRevoke],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pTuckingLicense = %d, pTuckingLicenseWarn = %d,pTuckingLicenseSus = %d, pTuckingLicenseRevoke = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pTuckingLicense],
			PlayerInfo[playerid][pTuckingLicenseWarn],
			PlayerInfo[playerid][pTuckingLicenseSus],
			PlayerInfo[playerid][pTuckingLicenseRevoke],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pBadge = %d, pHasRadio = %d, pSaving = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pBadge],
			PlayerInfo[playerid][pHasRadio],
			PlayerInfo[playerid][pSaving],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pJobExp = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pJobExp],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pCPU = %d, pGPU = %d, pRAM = %d, pStored = %d, pBTC = %.5f WHERE char_dbid = %i",	
			PlayerInfo[playerid][pCPU],
			PlayerInfo[playerid][pGPU],
			PlayerInfo[playerid][pRAM],
			PlayerInfo[playerid][pStored],
			PlayerInfo[playerid][pBTC],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);


		mysql_format(dbCon, query, sizeof(query), "UPDATE characters SET pArrest = %d, pArrestBy = %d, pArrestTime = %d, pArrestRoom = %d WHERE char_dbid = %i",	
			PlayerInfo[playerid][pArrest],
			PlayerInfo[playerid][pArrestBy],
			PlayerInfo[playerid][pArrestTime],
			PlayerInfo[playerid][pArrestRoom],
			PlayerInfo[playerid][pDBID]);
		mysql_tquery(dbCon, query);

		mysql_finish(query);
	}
	return 1;
}

forward Query_LoadCharacter(playerid);
public Query_LoadCharacter(playerid)
{
	cache_get_value_name_int(0, "char_dbid", PlayerInfo[playerid][pDBID]);
	cache_get_value_name_int(0, "pLastSkin", PlayerInfo[playerid][pLastSkin]);
	cache_get_value_name_bool(0, "pTutorial", PlayerInfo[playerid][pTutorial]);
	cache_get_value_name_int(0, "pFaction", PlayerInfo[playerid][pFaction]);
	cache_get_value_name_int(0, "pFactionRank", PlayerInfo[playerid][pFactionRank]);
	cache_get_value_name_int(0, "pCash", PlayerInfo[playerid][pCash]);
	cache_get_value_name_int(0, "pBank", PlayerInfo[playerid][pBank]);
	cache_get_value_name_int(0, "pAdmin", PlayerInfo[playerid][pAdmin]);
	cache_get_value_name_int(0, "pLevel", PlayerInfo[playerid][pLevel]);
	cache_get_value_name_int(0, "pExp", PlayerInfo[playerid][pExp]);

	cache_get_value_name_int(0, "pTimeout", PlayerInfo[playerid][pTimeout]);

	new diff = gettime() - PlayerInfo[playerid][pTimeout];

	if (diff > 0 && diff <= 60 * TIMEOUT_CRASH_TIME) // diff = now - savetime
	{
		/* 
			โหลดข้อมูลที่ต้องใช้ตอนหลุด
		*/	
		cache_get_value_name_float(0, "pHealth", PlayerInfo[playerid][pHealth]);
		cache_get_value_name_float(0, "pArmour", PlayerInfo[playerid][pArmour]);

		cache_get_value_name_float(0, "pLastPosX", PlayerInfo[playerid][pLastPosX]);
		cache_get_value_name_float(0, "pLastPosY", PlayerInfo[playerid][pLastPosY]);
		cache_get_value_name_float(0, "pLastPosZ", PlayerInfo[playerid][pLastPosZ]);

		cache_get_value_name_int(0, "pLastInterior", PlayerInfo[playerid][pLastInterior]);
		cache_get_value_name_int(0, "pLastWorld", PlayerInfo[playerid][pLastWorld]);

		cache_get_value_name_int(0, "pBadge", PlayerInfo[playerid][pBadge]);

	} else PlayerInfo[playerid][pTimeout] = 0;

	cache_get_value_name_int(0, "pSpawnPoint", PlayerInfo[playerid][pSpawnPoint]);
	cache_get_value_name_int(0, "pSpawnHouse", PlayerInfo[playerid][pSpawnHouse]);

	cache_get_value_name_int(0, "pJob", PlayerInfo[playerid][pJob]);
	cache_get_value_name_int(0, "pSideJob", PlayerInfo[playerid][pSideJob]);
	cache_get_value_name_int(0, "pCareer", PlayerInfo[playerid][pCareer]);
	cache_get_value_name_int(0, "pJobRank", PlayerInfo[playerid][pJobRank]);
	cache_get_value_name_int(0, "pJobExp", PlayerInfo[playerid][pJobExp]);

	cache_get_value_name_int(0, "pPaycheck", PlayerInfo[playerid][pPaycheck]);
	cache_get_value_name_int(0, "pFishes", PlayerInfo[playerid][pFishes]);
	

	cache_get_value_name(0, "pLastOnline",PlayerInfo[playerid][pLastOnline], 90);
	cache_get_value_name_int(0, "pTimeplayed", PlayerInfo[playerid][pTimeplayed]);

	cache_get_value_name_int(0, "pAdminjailed",PlayerInfo[playerid][pAdminjailed]);
	cache_get_value_name_int(0, "pAdminjailTime", PlayerInfo[playerid][pAdminjailTime]);

	cache_get_value_name_int(0, "pPhone",PlayerInfo[playerid][pPhone]);
	cache_get_value_name_int(0, "pPhonePower", PlayerInfo[playerid][pPhonePower]);


	cache_get_value_name_int(0, "pDriverLicense",PlayerInfo[playerid][pDriverLicense]);
	cache_get_value_name_int(0, "pDriverLicenseWarn",PlayerInfo[playerid][pDriverLicenseWarn]);
	cache_get_value_name_int(0, "pDriverLicenseRevoke",PlayerInfo[playerid][pDriverLicenseRevoke]);
	cache_get_value_name_int(0, "pDriverLicenseSus",PlayerInfo[playerid][pDriverLicenseSus]);

	cache_get_value_name_int(0, "pWeaponLicense",PlayerInfo[playerid][pWeaponLicense]);
	cache_get_value_name_int(0, "pWeaponLicenseType",PlayerInfo[playerid][pWeaponLicenseType]);
	cache_get_value_name_int(0, "pWeaponLicenseRevoke",PlayerInfo[playerid][pWeaponLicenseRevoke]);

	cache_get_value_name_int(0, "pPilotLicense",PlayerInfo[playerid][pPilotLicense]);
	cache_get_value_name_int(0, "pPilotLicenseBlacklist",PlayerInfo[playerid][pPilotLicenseBlacklist]);
	cache_get_value_name_int(0, "pPilotLicenseRevoke",PlayerInfo[playerid][pPilotLicenseRevoke]);

	cache_get_value_name_int(0, "pMedicLicense",PlayerInfo[playerid][pMedicLicense]);
	cache_get_value_name_int(0, "pMedicLicenseRevoke",PlayerInfo[playerid][pMedicLicenseRevoke]);
	
	cache_get_value_name_int(0, "pTuckingLicense",PlayerInfo[playerid][pTuckingLicense]);
	cache_get_value_name_int(0, "pTuckingLicenseRevoke",PlayerInfo[playerid][pTuckingLicenseRevoke]);
	cache_get_value_name_int(0, "pTuckingLicenseWarn",PlayerInfo[playerid][pTuckingLicenseWarn]);
	cache_get_value_name_int(0, "pTuckingLicenseSus",PlayerInfo[playerid][pTuckingLicenseSus]);

	cache_get_value_name_int(0, "pCPU",PlayerInfo[playerid][pCPU]);
	cache_get_value_name_int(0, "pGPU",PlayerInfo[playerid][pGPU]);
	cache_get_value_name_int(0, "pRAM",PlayerInfo[playerid][pRAM]);
	cache_get_value_name_int(0, "pStored",PlayerInfo[playerid][pStored]);
	cache_get_value_name_float(0, "pBTC",PlayerInfo[playerid][pBTC]);

	cache_get_value_name_int(0, "pArrest",PlayerInfo[playerid][pArrest]);
	cache_get_value_name_int(0, "pArrestBy",PlayerInfo[playerid][pArrestBy]);
	cache_get_value_name_int(0, "pArrestTime",PlayerInfo[playerid][pArrestTime]);
	cache_get_value_name_int(0, "pArrestRoom",PlayerInfo[playerid][pArrestRoom]);

	new str[MAX_STRING];
	
	for(new i = 0; i < 13; i++)
	{
		format(str, sizeof(str), "pWeapon%d", i);
		cache_get_value_name_int(0, str,PlayerInfo[playerid][pWeapons][i]);
		
		format(str, sizeof(str), "pWeaponsAmmo%d", i);
		cache_get_value_name_int(0, str,PlayerInfo[playerid][pWeaponsAmmo][i]);
	}

	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{	
		format(str, sizeof(str), "pOwnedVehicles%d", i);
		cache_get_value_name_int(0, str,PlayerInfo[playerid][pOwnedVehicles][i]);
	}

	for(new i = 1; i < 3; i++)
	{
		format(str, sizeof(str), "pRadio%i", i);
		cache_get_value_name_int(0, str,PlayerInfo[playerid][pRadio][i]);
	}


	cache_get_value_name_int(0, "pHasRadio",PlayerInfo[playerid][pHasRadio]);
	cache_get_value_name_int(0, "pMainSlot", PlayerInfo[playerid][pMainSlot]);
	cache_get_value_name_int(0, "pSaving", PlayerInfo[playerid][pSaving]);

	return LoadCharacter(playerid);
}

forward LoadCharacter(playerid);
public LoadCharacter(playerid)
{
	new
		string[128]
	;
	
	ResetPlayerMoney(playerid);

	if (!PlayerInfo[playerid][pTutorial]) {
		// ยังไม่ผ่านบทเรียน / ตัวละครใหม่
		PlayerInfo[playerid][pLevel] = 1;
		PlayerInfo[playerid][pCash] = DEFAULT_PLAYER_CASH;
		
		PlayerInfo[playerid][pTutorial] = true;
	}
    BitFlag_On(gPlayerBitFlag[playerid], IS_LOGGED);

	SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
	SetPlayerColor(playerid, 0xFFFFFFFF);
	
    SetSpawnInfo(playerid, NO_TEAM, 1, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
    TogglePlayerSpectating(playerid, false);
	
	if (!PlayerInfo[playerid][pTimeout]) {
		format(string, sizeof(string), "~w~Welcome~n~~y~ %s", ReturnPlayerName(playerid));
		GameTextForPlayer(playerid, string, 1000, 1);
	}

	if (PlayerInfo[playerid][pAdmin])
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: คุณเข้าสู่ระบบเป็นแอดมินระดับ %i", PlayerInfo[playerid][pAdmin]);
	}

    syncAdmin(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);

	SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);

	PlayerInfo[playerid][pLastOnline] = ReturnDate();
	for(new i = 0; i < 10; i++)
	{
		RemovePlayerAttachedObject(playerid, i);
	}
	return 1;
}

CreateNewCharacter(playerid) {

	#if defined IN_GAME_CREATE_CHARACTER

		SendClientMessage(playerid, -1, "กระบวนการเหล่านี้จะคอยแนะนำคุณตลอดการสร้างตัวละครของคุณ");
		SendClientMessage(playerid, -1, "โปรดเริ่มต้นด้วยการพิมพ์ชื่อและนามสกุลของตัวละคร ต.ย: {145F0B}Douglas_Hodge");
		SendClientMessage(playerid, -1, "ชื่อตัวละครของคุณต้องอยู่ในรูปแบบ Firstname_Lastname ไม่มีตัวเลขและอักษรพิเศษ");

		characterPickTime[playerid] = 0;

		Dialog_Show(playerid, DIALOG_CREATE_CHARACTER, DIALOG_STYLE_INPUT, "ตั้งชื่อตัวละคร", "ชื่อตัวละครของคุณต้องอยู่ในรูปแบบ Firstname_Lastname ไม่มีตัวเลขและอักษรพิเศษ\n\nป้อนชื่อตัวละครด้านล่างนี้:", "ยืนยัน", "ออก");
	
	#else

		SendClientMessage(playerid, COLOR_LIGHTRED, "บัญชีของคุณยังไม่ได้ตั้งค่าไว้ให้ใช้ในเกม (ยังไม่ได้ยื่นใบสมัคร/ตัวละครยังไม่ถูกยืนยัน)");
		SendClientMessage(playerid, COLOR_LIGHTRED, "โปรดเข้าสู่ระบบด้วยบัญชีของคุณบน yoursite.com และลองใหม่อีกครั้ง");
		KickEx(playerid);

	#endif
}

Dialog:DIALOG_CREATE_CHARACTER(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Kick(playerid);
	}

	if (IsValidRoleplayName(inputtext)) {
		new query[256];
		mysql_format(dbCon, query, sizeof(query), "INSERT INTO `characters` (char_name, master_id) VALUES('%e', %d)", inputtext, e_pAccountData[playerid][mDBID]);
		mysql_tquery(dbCon, query, "OnCharacterCreated", "d", playerid);
	}
	else {
		Dialog_Show(playerid, DIALOG_CREATE_CHARACTER, DIALOG_STYLE_INPUT, "ตั้งชื่อตัวละคร", "ชื่อตัวละครไม่ถูกต้องตามรูปแบบ !!\n\nชื่อตัวละครของคุณต้องอยู่ในรูปแบบ Firstname_Lastname ไม่มีตัวเลขและอักษรพิเศษ\n\nป้อนชื่อตัวละครด้านล่างนี้:", "ยืนยัน", "ออก");
	}
	return 1;
}

forward OnCharacterCreated(playerid);
public OnCharacterCreated(playerid) {
	ShowCharacterSelection(playerid);
}

ptask CharacterTimer[1000](playerid) {
    if(characterPickTime[playerid] > 0)
	{
		characterPickTime[playerid]++;
		
		if(characterPickTime[playerid] >= 60)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกเตะเนื่องจากไม่ได้เลือกตัวละคร");
			KickEx(playerid);
		}
	}
    return 1;
}

forward Query_SelectCharacter(playerid);
public Query_SelectCharacter(playerid)
{
	if (!cache_num_rows())
	{
		SendClientMessage(playerid, -1, "[ERROR]: เกิดข้อผิดพลาดในการประมวลผลตัวละครของคุณ กำลังนำคุณกลับไปยังรายการตัวละครของคุณ...");
		ShowCharacterSelection(playerid);
		return 1;
	}
	
	new rows, thread[128]; 
	cache_get_row_count(rows); 
	
	if(rows)
	{
		mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM characters WHERE char_name = '%e'", ReturnPlayerName(playerid));
		mysql_tquery(dbCon, thread, "Query_LoadCharacter", "i", playerid);
	}
	
	return 1;
}

stock GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][pCash] += amount;
	GivePlayerMoney(playerid, amount);
	
	new string[128]; 
	
	if(amount < 0) {
		format(string, sizeof(string), "~r~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
	}
	else{
		format(string, sizeof(string), "~g~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
	}
	return 1;
}


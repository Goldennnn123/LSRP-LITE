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


forward Query_LoadCharacter(playerid);
public Query_LoadCharacter(playerid)
{
	cache_get_value_name_int(0, "char_dbid", PlayerInfo[playerid][pDBID]);
	cache_get_value_name_int(0, "pLastSkin", PlayerInfo[playerid][pLastSkin]);
	cache_get_value_name_bool(0, "pTutorial", PlayerInfo[playerid][pTutorial]);

	cache_get_value_name_int(0, "pBadge", PlayerInfo[playerid][pBadge]);
	cache_get_value_name_int(0, "pFaction", PlayerInfo[playerid][pFaction]);
	cache_get_value_name_int(0, "pFactionRank", PlayerInfo[playerid][pFactionRank]);

	cache_get_value_name_int(0, "pPaycheck", PlayerInfo[playerid][pPaycheck]);
	cache_get_value_name_int(0, "pCash", PlayerInfo[playerid][pCash]);
	cache_get_value_name_int(0, "pBank", PlayerInfo[playerid][pBank]);

	cache_get_value_name_int(0, "pAdmin", PlayerInfo[playerid][pAdmin]);
	cache_get_value_name_int(0, "pTester", PlayerInfo[playerid][pTester]);
	cache_get_value_name_int(0, "pLevel", PlayerInfo[playerid][pLevel]);
	cache_get_value_name_int(0, "pExp", PlayerInfo[playerid][pExp]);

	cache_get_value_name_int(0, "pTimeout", PlayerInfo[playerid][pTimeout]);

	cache_get_value_name_float(0, "pHealth", PlayerInfo[playerid][pHealth]);
	cache_get_value_name_float(0, "pArmour", PlayerInfo[playerid][pArmour]);

	new diff = gettime() - PlayerInfo[playerid][pTimeout];

	if (diff > 0 && diff <= 60 * TIMEOUT_CRASH_TIME) // diff = now - savetime
	{
		/* 
			โหลดข้อมูลที่ต้องใช้ตอนหลุด
		*/	

		cache_get_value_name_float(0, "pLastPosX", PlayerInfo[playerid][pLastPosX]);
		cache_get_value_name_float(0, "pLastPosY", PlayerInfo[playerid][pLastPosY]);
		cache_get_value_name_float(0, "pLastPosZ", PlayerInfo[playerid][pLastPosZ]);

		cache_get_value_name_int(0, "pLastInterior", PlayerInfo[playerid][pLastInterior]);
		cache_get_value_name_int(0, "pLastWorld", PlayerInfo[playerid][pLastWorld]);

	} else PlayerInfo[playerid][pTimeout] = 0;

	if(PlayerInfo[playerid][pDonater])
	{
		cache_get_value_name_int(0, "pHasMask", PlayerInfo[playerid][pHasMask]);
	}

	cache_get_value_name_float(0, "pLastPosX", PlayerInfo[playerid][pLastPosX]);
	cache_get_value_name_float(0, "pLastPosY", PlayerInfo[playerid][pLastPosY]);
	cache_get_value_name_float(0, "pLastPosZ", PlayerInfo[playerid][pLastPosZ]);
	cache_get_value_name_int(0, "pLastInterior", PlayerInfo[playerid][pLastInterior]);
	cache_get_value_name_int(0, "pLastWorld", PlayerInfo[playerid][pLastWorld]);

	cache_get_value_name_int(0, "pSpawnPoint", PlayerInfo[playerid][pSpawnPoint]);
	cache_get_value_name_int(0, "pSpawnHouse", PlayerInfo[playerid][pSpawnHouse]);

	cache_get_value_name_int(0, "pJob", PlayerInfo[playerid][pJob]);
	cache_get_value_name_int(0, "pSideJob", PlayerInfo[playerid][pSideJob]);
	cache_get_value_name_int(0, "pCareer", PlayerInfo[playerid][pCareer]);
	cache_get_value_name_int(0, "pJobRank", PlayerInfo[playerid][pJobRank]);
	cache_get_value_name_int(0, "pJobExp", PlayerInfo[playerid][pJobExp]);

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

	cache_get_value_name_int(0, "pSkinClothing1", PlayerInfo[playerid][pSkinClothing][0]);
	cache_get_value_name_int(0, "pSkinClothing2", PlayerInfo[playerid][pSkinClothing][1]);
	cache_get_value_name_int(0, "pSkinClothing3", PlayerInfo[playerid][pSkinClothing][2]);
	cache_get_value_name_int(0, "pDonater",PlayerInfo[playerid][pDonater]);

	cache_get_value_name_int(0, "pOre",PlayerInfo[playerid][pOre]);
	cache_get_value_name_int(0, "pCoal",PlayerInfo[playerid][pCoal]);
	cache_get_value_name_int(0, "pIron",PlayerInfo[playerid][pIron]);
	cache_get_value_name_int(0, "pCopper",PlayerInfo[playerid][pCopper]);
	cache_get_value_name_int(0, "pKNO3",PlayerInfo[playerid][pKNO3]);

	cache_get_value_name_int(0, "pWhitelist",PlayerInfo[playerid][pWhitelist]);
	cache_get_value_name_int(0, "pCigare",PlayerInfo[playerid][pCigare]);

	cache_get_value_name_int(0, "pVehicleSpawned",PlayerInfo[playerid][pVehicleSpawned]);
	cache_get_value_name_int(0, "pVehicleSpawnedID",PlayerInfo[playerid][pVehicleSpawnedID]);

	cache_get_value_name_int(0, "RentCarKey",RentCarKey[playerid]);

	cache_get_value_name_int(0, "pInsideBusiness",PlayerInfo[playerid][pInsideBusiness]);
	cache_get_value_name_int(0, "pInsideProperty",PlayerInfo[playerid][pInsideProperty]);

	cache_get_value_name_int(0, "pBoomBox",PlayerInfo[playerid][pBoomBox]);
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

	if(!PlayerInfo[playerid][pWhitelist])
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}ตัวละครของคุณยังไม่ได้รับการยืนยัน โปรดกรอกใบสมัครของคุณให้เรียบร้อยก่อนที่จะเข้าเล่นเล่นเกม");
		SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}หากคุณกรอกใบสมัครเรียบร้อยแล้วให้คุณเรียบร้อยแล้วให้คุณเข้ามายืนยันใบสมัครของคุณในห้อง ดิสคอร์ด");
		SendClientMessageEx(playerid, COLOR_YELLOW, "INFO: {FFFFFF}ชื่อ UCP: %s รหัสตัวละคร: %d", e_pAccountData[playerid][mAccName], PlayerInfo[playerid][pDBID]);
		ResetPlayerCharacter(playerid);
		KickEx(playerid);
		return 1;
	}

	foreach(new i : Player)
	{
		if(e_pAccountData[playerid][mDBID] != e_pAccountData[i][mDBID])
			continue;
		
		if(playerid == i)
			continue;

		SendAdminMessageEx(COLOR_LIGHTRED, 1, "มีการใช้ UCP เดียวกันในการเข้าสองตัวละครในเวลาเดียวกัน (%d) %s กับ (%d) %s",playerid, ReturnName(playerid,0), i, ReturnName(i,0));
	}

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
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);

	SetPlayerSkin(playerid, PlayerInfo[playerid][pLastSkin]);
	SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);

	PlayerInfo[playerid][pLastOnline] = ReturnDate();
	for(new i = 0; i < 10; i++)
	{
		RemovePlayerAttachedObject(playerid, i);
	}

	if(IsPlayerAndroid(playerid) == true)
	{
		SendClientMessage(playerid, -1, "คุณเข้าสู่ระบบด้วยอุปกรณ์ Android");
	}
	else SendClientMessage(playerid, -1, "คุณเข้าสู่ระบบด้วยอุปกรณ์ PC");

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
		mysql_format(dbCon, query, sizeof(query), "INSERT INTO `characters` (char_name, master_id, pPhone, pCash) VALUES('%e', %d, %d, %d)", inputtext, e_pAccountData[playerid][mDBID], random(99999), 5000);
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
	CharacterSave(playerid);
	
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


stock ResetPlayerCharacter(playerid)
{
	gPlayerBitFlag[playerid] = PlayerFlags:0;
    format(e_pAccountData[playerid][mForumName], e_pAccountData[playerid][mForumName], "");

	PlayerInfo[playerid][pDBID] = 0;
    PlayerInfo[playerid][pCMDPermission] = CMD_PLAYER;
    PlayerInfo[playerid][pAdmin] = CMD_PLAYER;


    PlayerInfo[playerid][pJob] = 0;
    PlayerInfo[playerid][pSideJob] = 0;
    PlayerInfo[playerid][pCareer] = 0;
    PlayerInfo[playerid][pJobRank] = 0;
    PlayerInfo[playerid][pJobExp] = 0;

    PlayerInfo[playerid][pPaycheck] = 0;
    PlayerInfo[playerid][pFishes] = 0;
    PlayerInfo[playerid][pCash] = 0;
    PlayerInfo[playerid][pBank] = 0;
    PlayerInfo[playerid][pFaction] = 0;
    PlayerInfo[playerid][pFactionRank] = 0;
    PlayerInfo[playerid][pLevel] = 0;
    PlayerInfo[playerid][pExp] = 0;
    PlayerInfo[playerid][pLastSkin] = 264;
    PlayerInfo[playerid][pTutorial] = false;

    PlayerInfo[playerid][pLastInterior] = 
    PlayerInfo[playerid][pLastWorld] = 
    PlayerInfo[playerid][pTimeout] = 
    PlayerInfo[playerid][pSpawnPoint] = 
    PlayerInfo[playerid][pSpawnHouse] = 0;

    PlayerInfo[playerid][pHealth] = 100.0;
    PlayerInfo[playerid][pArmour] = 
    PlayerInfo[playerid][pLastPosX] = 
    PlayerInfo[playerid][pLastPosY] = 
    PlayerInfo[playerid][pLastPosZ] = 0.0;

    PlayerInfo[playerid][pUnscrambleID] = 0;
    PlayerInfo[playerid][pUnscrambling] = false;
	PlayerInfo[playerid][pScrambleFailed] = 0;
	PlayerInfo[playerid][pScrambleSuccess] = 0; 

    PlayerInfo[playerid][pDuplicateKey] = 0;
    PlayerInfo[playerid][pUnscramblerTime] = 0;

    PlayerInfo[playerid][pInsideProperty] = 0;
    PlayerInfo[playerid][pInsideBusiness] = 0;

    PlayerInfo[playerid][pAdminjailed] = false;
	PlayerInfo[playerid][pAdminjailTime] = 0;

    PlayerInfo[playerid][pSpectating] = INVALID_PLAYER_ID;

    PlayerInfo[playerid][pMaskID][0] = 200000+random(199991);
	PlayerInfo[playerid][pMaskID][1] = 40+random(59);
	PlayerInfo[playerid][pMasked] = false;
    PlayerInfo[playerid][pHasMask] = false;

    PlayerInfo[playerid][pWeaponsSpawned] = false;
	
	for(new i = 0; i < 13; i++){
		PlayerInfo[playerid][pWeapons][i] = 0;
		PlayerInfo[playerid][pWeaponsAmmo][i] = 0;
	}

    for(new i = 1; i < MAX_PLAYER_VEHICLES; i++) {
		PlayerInfo[playerid][pOwnedVehicles][i] = 0; 
	}

    PlayerInfo[playerid][pHasRadio] = false;
	PlayerInfo[playerid][pMainSlot] = 1; 
	
	for(new i = 1; i < 3; i++){
		PlayerInfo[playerid][pRadio][i] = 0;
	}

    PlayerInfo[playerid][pLastDamagetime] = 0;
    PlayerInfo[playerid][pDeathFix] = 0;
    PlayerInfo[playerid][pRespawnTime] = 0;
    

    PlayerInfo[playerid][pPhone] = 0;
    PlayerInfo[playerid][pPhonePower] = 100;
    PlayerInfo[playerid][pGUI] = 0;
    PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
    PlayerInfo[playerid][pCalling] = 0;
    PlayerInfo[playerid][pPhonespeaker] = false;

    PlayerInfo[playerid][pDriverLicense] = false;
    PlayerInfo[playerid][pDriverLicenseWarn] = 0;
    PlayerInfo[playerid][pDriverLicenseRevoke] = false;
    PlayerInfo[playerid][pDriverLicenseSus] = false;

    PlayerInfo[playerid][pWeaponLicense] = false;
    PlayerInfo[playerid][pWeaponLicenseType] = 0;
    PlayerInfo[playerid][pWeaponLicenseRevoke] = false;
    PlayerInfo[playerid][pWeaponLicenseSus] = false;

    PlayerInfo[playerid][pPilotLicense] = false;
    PlayerInfo[playerid][pPilotLicenseBlacklist] = false;
    PlayerInfo[playerid][pPilotLicenseRevoke] = false;

    PlayerInfo[playerid][pMedicLicense] = false;
    PlayerInfo[playerid][pMedicLicenseRevoke] = false;

    PlayerInfo[playerid][pTuckingLicense] = false;
    PlayerInfo[playerid][pTuckingLicenseRevoke] = false;
    PlayerInfo[playerid][pTuckingLicenseWarn] = 0;
    PlayerInfo[playerid][pTuckingLicenseSus] = false;
    PlayerInfo[playerid][pFactionChat] = false;
    PlayerInfo[playerid][pFactionInvite] = 0;
	PlayerInfo[playerid][pFactionInvitedBy] = INVALID_PLAYER_ID;

    PlayerInfo[playerid][pHandcuffed] = false;

    PlayerInfo[playerid][pCPU] = 0;
    PlayerInfo[playerid][pGPU] = 0;
    PlayerInfo[playerid][pRAM] = 0;
    PlayerInfo[playerid][pStored] = 0;

    PlayerInfo[playerid][pArrest] = false;
    PlayerInfo[playerid][pArrestRoom] = 0;
    PlayerInfo[playerid][pArrestBy] = 0;
    PlayerInfo[playerid][pArrestTime] = 0;
    PlayerInfo[playerid][pDonater] = 0;
	PlayerInfo[playerid][pSkinClothing][0] = 0;
	PlayerInfo[playerid][pSkinClothing][1] = 0;
	PlayerInfo[playerid][pSkinClothing][2] = 0;
    PlayerInfo[playerid][pWhitelist] = false;
    PlayerInfo[playerid][pTester] = 0;
	// vehicles.pwn
	gLastCar[playerid] = 0;
	gPassengerCar[playerid] = 0;

    SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);

    tToAccept[playerid] = INVALID_PLAYER_ID;
	return 1;
}


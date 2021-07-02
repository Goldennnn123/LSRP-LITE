#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS (100)


/////////Hellow world /::::::::::::

//#include <progress2>    // Southclaws/progress2

// YSI Include : aktah/YSI-Y
#define YSI_YES_HEAP_MALLOC
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_MODE_CACHE
#define YSI_NO_VERSION_CHECK
#define CGEN_MEMORY 99999
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_va>
#include <YSI_Core\y_utils>
#include <YSI_Coding\y_inline>

#include <streamer>      // maddinat0r/sscanf        //aktah/SAMP-CEFixs
#include <sscanf2>      // maddinat0r/sscanf
#include <whirlpool>    // Southclaws/samp-whirlpool
#include <a_mysql>      // pBlueG/SA-MP-MySQL 
#include <Pawn.CMD>     // urShadow/Pawn.CMD
#include <easyDialog>   // aktah/easyDialog
#include <log-plugin>   // maddinat0r/samp-log
#include <strlib>
#include <Pawn.RakNet>
#include <cec>
#include <MenuStore>
#include <compat>
//#include <io>

/*======================================================================================================
										[Macros]
=======================================================================================================*/
DEFINE_HOOK_REPLACEMENT(Select, Sel);
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);

/*======================================================================================================
										[Declarations]
=======================================================================================================*/

new
    Logger:adminactionlog;

new
    Logger:allcmdlog;

new globalWeather = 2;

/*======================================================================================================
										[Modules]
=======================================================================================================*/

// ตั้งค่า

#include "config.inc"
#include "Y/configuration/general.pwn"
#include "Y/configuration/database.pwn" // สร้างไฟล์ database.pwn ด้วยตัวเองในไดเรกทอรี่ gamemodes/Y/configuration/..

// อรรถประโยชน์
#include "Y/utility/colour.pwn"
#include "Y/utility/utils.pwn"

// เอกลักษณ์
#include "Y/entities/entities.pwn"
#include "Y/entities/computer.pwn"
#include "Y/entities/fine.pwn"
#include "Y/entities/helpme.pwn"
#include "Y/entities/gps.pwn"
#include "Y/entities/vehicle_faction.pwn"
#include "Y/entities/global.pwn"
#include "Y/entities/boombox.pwn"

// ตัวหลัก
#include "Y/define.pwn"
#include "Y/enums.pwn"
#include "Y/variables.pwn"
#include "Y/function.pwn"
#include "Y/mysql/database.pwn"

#include "Y/systems/vehicles.pwn"
#include "Y/systems/cooldown.pwn"
#include "Y/systems/job.pwn"
#include "Y/systems/report.pwn"
#include "Y/systems/weapon.pwn"
#include "Y/systems/faction.pwn"
#include "Y/systems/house.pwn"
#include "Y/systems/business.pwn"
#include "Y/systems/entrance.pwn"

#include "Y/systems/phone.pwn"
#include "Y/systems/business/ui_buy.pwn"
#include "Y/systems/business/vehiclebuy.pwn"
#include "Y/systems/anim.pwn"
#include "Y/systems/furniture/computer.pwn"
#include "Y/systems/furniture/boombox.pwn"
#include "Y/systems/fine.pwn"
#include "Y/systems/gps.pwn"
#include "Y/systems/global.pwn"

#include "Y/jobs/farmer.pwn"
#include "Y/jobs/fisher.pwn"
#include "Y/jobs/trucker.pwn"
#include "Y/jobs/mechanic.pwn"
#include "Y/jobs/miner.pwn"

#include "Y/mysql/CharacterSave.pwn"
#include "Y/mysql/SaveVehicle.pwn"
#include "Y/mysql/Savefaction.pwn"
#include "Y/mysql/SaveHouse.pwn"
#include "Y/mysql/SaveBusiness.pwn"
#include "Y/mysql/SaveEntrance.pwn"
#include "Y/mysql/SaveFacVehicle.pwn"
#include "Y/mysql/SaveMc_Garage.pwn"
#include "Y/mysql/SaveComputer.pwn"
#include "Y/mysql/SaveGps.pwn"

#include "Y/registration/login.pwn"
#include "Y/character/character.pwn"

#include "Y/commands/general.pwn"
#include "Y/commands/admin.pwn"
#include "Y/commands/roleplay.pwn"
#include "Y/commands/housecmd.pwn"
#include "Y/commands/businesscmd.pwn"
#include "Y/commands/factioncmd.pwn"
#include "Y/commands/police.pwn"
#include "Y/commands/medic.pwn"
#include "Y/commands/tester.pwn"

#include "Y/Interior/Bank.pwn"
#include "Y/Interior/House1.pwn"
#include "Y/Interior/House2.pwn"
#include "Y/Interior/pizza.pwn"
#include "Y/Interior/bar2.pwn"


#include "Y/Map/LSPDHQ.pwn"
#include "Y/Map/415garage.pwn"
#include "Y/Map/garagegas.pwn"
#include "Y/Map/Hospital.pwn"
#include "Y/Map/ps.pwn"
/*#include "Y/Map/slrp.pwn"
#include "Y/Map/apartment.pwn"
#include "Y/Map/LSPDHABOR.pwn"
#include "Y/Map/Police.pwn"
#include "Y/Map/swrp.pwn"
#include "Y/Map/cityhall.pwn"
#include "Y/Map/IDLEWOOD.pwn"
#include "Y/Map/LSMALL.pwn"
#include "Y/Map/LSPDWEST.pwn"
#include "Y/Map/LSPDHQ.pwn"
#include "Y/Map/LSPDVINEWOOD.pwn"
#include "Y/Map/Police.pwn"
#include "Y/Map/415garage.pwn"
#include "Y/Map/Gas_station.pwn"
//#include "Y/Map/LSPDHQINT.pwn"
//#include "Y/Map/LSPDHQEXT.pwn"
//#include "Y/Map/LSPDHQINT2.pwn"*/


#include "Y/systems/car_rental.pwn"
#include "Y/systems/dmv.pwn"

#include "Y/test/functionPlayer.pwn"

#include "Y/systems/textdraw/computer.pwn"
#include "Y/systems/textdraw/blindfold.pwn"

#if SETUP_TABLE
    #include "install"
#endif


main() { }

public OnGameModeInit() {

    SendRconCommand("hostname "GM_HOST_NAME"");
    SetGameModeText(GM_VERSION);

    SetNameTagDrawDistance(20.0);
    
    mysql_tquery(dbCon, "SELECT * FROM factions ORDER BY dbid ASC", "Query_LoadFactions");
    mysql_tquery(dbCon, "SELECT * FROM House ORDER BY HouseDBID", "Query_LoadHouse");
    mysql_tquery(dbCon, "SELECT * FROM Business ORDER BY BusinessDBID", "Query_LoadBusiness");
    mysql_tquery(dbCon, "SELECT * FROM phonebook ORDER BY PhoneDBID", "LoadPhoneBook");
    mysql_tquery(dbCon, "SELECT * FROM entrance ORDER BY EntranceDBID", "LoadEntrance");
    mysql_tquery(dbCon, "SELECT * FROM vehicle_faction ORDER BY VehicleDBID", "LoadFactionVehicle");
    mysql_tquery(dbCon, "SELECT * FROM global ORDER BY ID", "LoadGlobal");
	
    // ใช้การควบคุมเครื่องยนต์ด้วยสคริปต์แทน
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);


    ShowPlayerMarkers(0);
    //Timer:
    SetTimer("OnPlayerNereHouseTime", 1000, true);
    SetTimer("OnPlayerNereBusinessTime", 3000, true);
    SetTimer("OnWeaponsUpdate", 1000, true);
    SetTimer("OnVehicleUpdate", 100, true);
    SetTimer("FunctionPaychecks", 1000, true);
    //Timer:

    adminactionlog = CreateLog("server/admin_action");
    allcmdlog = CreateLog("server/allcmdlog");





    new query[150];
	for (new i = 1; i < 100; i++)
	{
        mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `pVehicleSpawned` = '0', `pVehicleSpawnedID` = '0' WHERE `char_dbid` = '%d' ",i);
        mysql_tquery(dbCon, query);
	}

    return 1;
}

public OnGameModeExit() {
    DestroyLog(adminactionlog);
    DestroyLog(allcmdlog);

    foreach(new i : Player)
    {
        if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
            continue;

        CharacterSave(i);
    }
    
    for(new businessid = 0; businessid < MAX_BUSINESS; businessid++)
    {
        if(!BusinessInfo[businessid][BusinessDBID])
            continue;
        
        SaveBusiness(businessid);
    }

    for(new houseid = 0; houseid < MAX_HOUSE; houseid++)
    {
        if(!HouseInfo[houseid][HouseDBID])
            continue;
        
        Savehouse(houseid);
    }

    return 1;
}

public OnPlayerConnect(playerid) {

    // เคลียร์ตัวแปรผู้เล่น
    gPlayerBitFlag[playerid] = PlayerFlags:0;
    format(e_pAccountData[playerid][mForumName], e_pAccountData[playerid][mForumName], "");

    PlayerInfo[playerid][pCMDPermission] = CMD_PLAYER;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pTester] = 0;


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

    PlayerInfo[playerid][pBoomBox] = false;
    PlayerInfo[playerid][pBoomBoxSpawnID] = 0;
	// vehicles.pwn
	gLastCar[playerid] = 0;
	gPassengerCar[playerid] = 0;

    SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);

    tToAccept[playerid] = INVALID_PLAYER_ID;

    KillTimer(playerTowTimer[playerid]);
    playerTowingVehicle[playerid] = false;

	new query[90];
    new musicrandom = random(3);
    switch(musicrandom)
    {
        case 0:
        {
            PlayAudioStreamForPlayer(playerid, "https://media1.vocaroo.com/mp3/1eEMxGxXUiXJ"); // Alt J Breezeblocks
        }
        case 1:
        {
            PlayAudioStreamForPlayer(playerid, "https://media1.vocaroo.com/mp3/16hBMrz3ySPF"); // Blinding Lights [Acoustic Version] - The Weeknd
        }
        case 2:
        {
            PlayAudioStreamForPlayer(playerid, "https://media1.vocaroo.com/mp3/134nwjnrnmTd"); // Timber - Pitbull.
        }
    }

    mysql_format(dbCon, query, sizeof(query), "SELECT * FROM bannedlist WHERE IpAddress = '%e'", ReturnIP(playerid));
	mysql_tquery(dbCon, query, "CheckBanList", "i", playerid);

	/*mysql_format(dbCon, query, sizeof(query), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
	mysql_tquery(dbCon, query, "OnPlayerJoin", "d", playerid);*/

    SendClientMessage(playerid, -1, "ยินดีต้อนรับเข้าสู่ "EMBED_YELLOW"Los Santos Roleplay LITE");
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {

    static const szDisconnectReason[3][] = {"หลุด","ออกจากเกมส์","ถูกเตะ"};
    ProxDetector(playerid, 20.0, sprintf("*** %s ออกจากเซิร์ฟเวอร์ (%s)", ReturnPlayerName(playerid), szDisconnectReason[reason]));

    
    // บันทึกว่าหลุด
	if(reason == 0) {
		PlayerInfo[playerid][pTimeout] = gettime();
    }


    new playerTime = NetStats_GetConnectedTime(playerid);
	new secondsConnection = (playerTime % (1000*60*60)) / (1000*60);
	
	PlayerInfo[playerid][pLastOnlineTime] = secondsConnection;
    CharacterSave(playerid);
    ResetPlayerCharacter(playerid);
}

public OnPlayerRequestClass(playerid, classid) {
    TogglePlayerSpectating(playerid, true);
    defer ShowLoginCamera(playerid);
    return 1;
}

public OnPlayerSpawn(playerid) {

	if (!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		Kick(playerid);

    
    if(PlayerInfo[playerid][pWeaponsSpawned] == false)
    {
        for(new i = 0; i < 13; i ++)
        {
            if(PlayerInfo[playerid][pWeapons][i] != 0)
            {
                GivePlayerGun(playerid, PlayerInfo[playerid][pWeapons][i], PlayerInfo[playerid][pWeaponsAmmo][i]);
            }
        }

        SetPlayerArmedWeapon(playerid, 0);
        PlayerInfo[playerid][pWeaponsSpawned] = true;
    }

    SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

    if(PlayerInfo[playerid][pAdminjailed] == true)
    {
        SendClientMessageEx(playerid, COLOR_REDEX, "[ADMIN JAIL:] เวลาที่อยู่ในคุกแอดมินของคุณยังไม่หมดจำเป็นต้องอยู่ในคุกอีก %d วินาที",PlayerInfo[playerid][pAdminjailTime]);
        ClearAnimations(playerid); 
	
        SetPlayerPos(playerid, 2687.3630, 2705.2537, 22.9472);
        SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, 1338);

        CharacterSave(playerid);
        StopAudioStreamForPlayer(playerid);
        return 1;
    }

    if(PlayerInfo[playerid][pArrest] == true)
    {
        ArrestConecterJail(playerid, PlayerInfo[playerid][pArrestTime], PlayerInfo[playerid][pArrestRoom]);
        ClearAnimations(playerid);
        CharacterSave(playerid);
        StopAudioStreamForPlayer(playerid);
        return 1;
    }

    if (PlayerInfo[playerid][pTimeout]) {

        // ตั้งค่าผู้เล่นให้กลับที่เดิมและสถานะบางอย่างเหมือนเดิม

        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

        SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
        SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

        PlayerInfo[playerid][pTimeout] = 0;

        GameTextForPlayer(playerid, "~r~crashed. ~w~returning to last position", 1000, 1);
        StopAudioStreamForPlayer(playerid);
        return 1;
    }

    if(PlayerInfo[playerid][pSpectating] != INVALID_PLAYER_ID)
    {
        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
        PlayerInfo[playerid][pSpectating] = INVALID_PLAYER_ID;
        StopAudioStreamForPlayer(playerid);
        return 1;
    }
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
            SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
            SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
            SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);
        }

    }

    StopAudioStreamForPlayer(playerid); //หยุดเพลงเข้าเซิฟ

    return 1;
}

public OnPlayerText(playerid, text[]) {

    /*new str[144];

    format(str, sizeof(str), "%s พูดว่า: %s", ReturnRealName(playerid, 0), text);
    ProxDetector(playerid, 20.0, str);

	//printf("[%d]%s: %s", playerid, ReturnPlayerName(playerid), text);*/

	return 0;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED)) {
		SendClientMessage(playerid, COLOR_LIGHTRED, "ACCESS DENIED: {FFFFFF}คุณต้องเข้าสู่ระบบก่อนที่จะใช้คำสั่ง");
		return 0;
	}
    else if (!(flags & PlayerInfo[playerid][pCMDPermission]) && flags)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "ACCESS DENIED: {FFFFFF}คุณไม่ได้รับอนุญาตให้ใช้คำสั่งนี้");
        return 0;
    }

    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}เกิดข้อผิดพลาดในการใช้คำสั่ง");
        return 0;
    }

	if(flags) { // Permission CMD
		if (flags & PlayerInfo[playerid][pCMDPermission])
		{
			Log(adminactionlog, INFO, "%s: /%s %s", ReturnPlayerName(playerid), cmd, params);
		}
	}   

    Log(allcmdlog, INFO, "[CMD] %s: /%s %s", ReturnPlayerName(playerid), cmd, params);
    return 1;
}


public OnPlayerEnterCheckpoint(playerid)
{
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    return 1;
}


public OnPlayerUpdate(playerid)
{
    if(PlayerInfo[playerid][pAdminDuty])
		SetPlayerHealth(playerid, 250);
		
	//PlayerInfo[playerid][pPauseCheck] = GetTickCount(); 
	
	new
		string[128];

    if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
	{
		format(string, sizeof(string), "(( ผู้เล่นคนนี้ได้รับบาดเจ็บมา %d นาที พิมพ์ /damages %d ))", TotalPlayerDamages[playerid], playerid);
		SetPlayerChatBubble(playerid, string, COLOR_RED, 30.0, 2500); 
		
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	}
	else if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD)
	{
		SetPlayerChatBubble(playerid, "(( ผู้เล่นคนนี้เสียชีวิตแล้ว ))", COLOR_RED, 30.0, 2500); 
	}
    return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    for(new i = 1; i < MAX_MCGARAGE; i++)
    {
        if(pickupid == McGarageInfo[i][Mc_GarageIcon])
        {
            SendClientMessage(playerid, COLOR_GREY, "/trun เพื่อทำระบบแต่งรถ");
            return 1;
        }
    }

    if(pickupid == mechanic_pickup)
    {
        GameTextForPlayer(playerid, "~g~Mechamic Job ~n~~w~/takejob~n~~g~For Register", 3500, 3);
        return 1;
    }
    return 1;
}
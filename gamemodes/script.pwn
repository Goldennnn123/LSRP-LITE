#define CE_AUTO

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS (100)


/////////Hellow world /::::::::::::

//#include <progress2>    // Southclaws/progress2

// YSI Include : aktah/YSI-Includes
#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <YSI\y_va>

#include <streamer>      // maddinat0r/sscanf        //aktah/SAMP-CEFixs
#include <sscanf2>      // maddinat0r/sscanf
#include <whirlpool>    // Southclaws/samp-whirlpool
#include <a_mysql>      // pBlueG/SA-MP-MySQL 
#include <PAWN.CMD>     // urShadow/Pawn.CMD
#include <easyDialog>   // aktah/easyDialog
#include <log-plugin>   // maddinat0r/samp-log
#include <strlib>
#include <CEFix>

/*======================================================================================================
										[Macros]
=======================================================================================================*/
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);

/*======================================================================================================
										[Declarations]
=======================================================================================================*/

new
    Logger:adminactionlog;

/*======================================================================================================
										[Modules]
=======================================================================================================*/

// ��駤��
#include "includes/configuration/general.pwn"
#include "includes/configuration/database.pwn" // ���ҧ��� database.pwn ���µ���ͧ���á����� gamemodes/includes/configuration/..

// ��ö����ª��
#include "includes/utility/colour.pwn"
#include "includes/utility/utils.pwn"

// �͡�ѡɳ�
#include "includes/entities/entities.pwn"

// �����ѡ
#include "includes/define.pwn"
#include "includes/enums.pwn"
#include "includes/variables.pwn"
#include "includes/function.pwn"
#include "includes/mysql/database.pwn"

#include "includes/registration/login.pwn"
#include "includes/character/character.pwn"

#include "includes/systems/cooldown.pwn"
#include "includes/systems/vehicles.pwn"
#include "includes/systems/car_rental.pwn"
#include "includes/systems/job.pwn"
#include "includes/systems/report.pwn"
#include "includes/systems/weapon.pwn"

#include "includes/jobs/farmer.pwn"
#include "includes/jobs/fisher.pwn"

#include "includes/commands/general.pwn"
#include "includes/commands/admin.pwn"
#include "includes/commands/roleplay.pwn"

main()
{
    print("\n----------------------------------");
    print(" �����¹: https://github.com/aktah/");
    print(" �Ԣ�Է���: GNU GENERAL PUBLIC LICENSE v3");
    print(" �����Ϳ�����������������ͧ�س�ʴ���Ҥس����Ѻ��觵��仹��: ���麹˹�Ҩ͢���ѹ���������������¹�ӵ�ͧ���ź�͡");
    print(" �����Ź���ͧ�١�ʹ���е�ͧ���١��� ������ҧ�����ͧ���������١�������ҧ��觤�Ѵ");
    print(" �����Ҥس�����ҧ�������ٻẺ� � ���� \r\n");
    print(" �ҡ�س�ջѭ��� � �Ѻ���͹�����ҹ��; �Դ��� Leaks �ѹ��");
    print("----------------------------------\n");
}

public OnGameModeInit() {

    SendRconCommand("hostname "GM_HOST_NAME"");
    SetGameModeText(GM_VERSION);

    SetNameTagDrawDistance(NAME_TAG_DISTANCE);
	
    // ���äǺ�������ͧ¹�����ʤ�Ի��᷹
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);



    //Timer:
    SetTimer("FunctionPlayers", 1000, true);
    //Timer:

    adminactionlog = CreateLog("server/admin_action");

    return 1;
}

public OnGameModeExit() {
    DestroyLog(adminactionlog);

    return 1;
}

public OnPlayerConnect(playerid) {

    // ���������ü�����
    gPlayerBitFlag[playerid] = PlayerFlags:0;

    PlayerInfo[playerid][pCMDPermission] = CMD_PLAYER;
    PlayerInfo[playerid][pAdmin] = CMD_PLAYER;


    PlayerInfo[playerid][pJob] = 0;
    PlayerInfo[playerid][pSideJob] = 0;
    PlayerInfo[playerid][pCareer] = 0;
    PlayerInfo[playerid][pPaycheck] = 0;
    PlayerInfo[playerid][pFishes] = 0;
    PlayerInfo[playerid][pCash] = 0;
    PlayerInfo[playerid][pFaction] = 0;
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

	// vehicles.pwn
	gLastCar[playerid] = 0;
	gPassengerCar[playerid] = 0;

	new query[90];

    mysql_format(dbCon, query, sizeof(query), "SELECT * FROM bannedlist WHERE IpAddress = '%e'", ReturnIP(playerid));
	mysql_tquery(dbCon, query, "CheckBanList", "i", playerid);

	/*mysql_format(dbCon, query, sizeof(query), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
	mysql_tquery(dbCon, query, "OnPlayerJoin", "d", playerid);*/

    SendClientMessage(playerid, -1, "�Թ�յ�͹�Ѻ������ "EMBED_YELLOW"Samp Role Play");
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {

    static const szDisconnectReason[3][] = {"��ش","�͡�ҡ����","�١��"};
    ProxDetector(playerid, 20.0, sprintf("*** %s �͡�ҡ��������� (%s)", ReturnPlayerName(playerid), szDisconnectReason[reason]));

    
    // �ѹ�֡�����ش
	if(reason == 0) {
		PlayerInfo[playerid][pTimeout] = gettime();
    }

    CharacterSave(playerid);
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
    
    if (PlayerInfo[playerid][pTimeout]) {

        // ��駤�Ҽ���������Ѻ���������ʶҹкҧ���ҧ����͹���

        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);

        SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
        SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

        PlayerInfo[playerid][pTimeout] = 0;

        GameTextForPlayer(playerid, "~r~crashed. ~w~returning to last position", 1000, 1);
        return 1;
    }
    if(PlayerInfo[playerid][pSpectating] != INVALID_PLAYER_ID)
    {
        SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pLastWorld]);
        SetPlayerInterior(playerid, PlayerInfo[playerid][pLastInterior]);

        SetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
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
            // to add
        }
        case SPAWN_AT_HOUSE: {
            // to add
        }
    }

    return 1;
}

public OnPlayerText(playerid, text[]) {

    new str[144];

    format(str, sizeof(str), "%s �ٴ���: %s", ReturnRealName(playerid, 0), text);
    ProxDetector(playerid, 20.0, str);

	printf("[%d]%s: %s", playerid, ReturnPlayerName(playerid), text);

	return 0;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED)) {
		SendClientMessage(playerid, COLOR_LIGHTRED, "ACCESS DENIED: {FFFFFF}�س��ͧ�������к���͹����������");
		return 0;
	}
    else if (!(flags & PlayerInfo[playerid][pCMDPermission]) && flags)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "ACCESS DENIED: {FFFFFF}�س������Ѻ͹حҵ��������觹��");
        return 0;
    }

    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}�Դ��ͼԴ��Ҵ㹡��������");
        return 0;
    }

	if(flags) { // Permission CMD
		if (flags & PlayerInfo[playerid][pCMDPermission])
		{
			Log(adminactionlog, INFO, "%s: /%s %s", ReturnPlayerName(playerid), cmd, params);
		}
	}
    return 1;
}
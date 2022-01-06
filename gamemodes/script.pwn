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
#include <YSI_Visual\y_dialog>
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
#include <MenuStore>
#include <compat>
//#include <cpn>
#define DEBUG
#include <eSelection>
#include <nex-ac>
#include <nex-ac_en.lang>
#include <cec>
#include <walking_styles>
#include <td-actions>

/*======================================================================================================
										[Macros]
=======================================================================================================*/
DEFINE_HOOK_REPLACEMENT(Select, Sel);
DEFINE_HOOK_REPLACEMENT(OnPlayer, OP_);
DEFINE_HOOK_REPLACEMENT(OnModelSelection, OM_);

/*======================================================================================================
										[Declarations]
=======================================================================================================*/

new
    Logger:adminactionlog;

new
    Logger:allcmdlog;

new
    Logger:DeathLog;

new
    Logger:chatlog;

new globalWeather = 2;

/*======================================================================================================
										[Modules]
=======================================================================================================*/

// ตั้งค่า


enum {
	WALKING_STYLE_DEFAULT = 0,
	WALKING_STYLE_NORMAL,
	WALKING_STYLE_PED,
	WALKING_STYLE_GANGSTA,
	WALKING_STYLE_GANGSTA2,
	WALKING_STYLE_OLD,
	WALKING_STYLE_FAT_OLD,
	WALKING_STYLE_FAT,
	WALKING_STYLE_WOMANOLD,
	WALKING_STYLE_WOMANFATOLD,
	WALKING_STYLE_SHUFFLE,
	WALKING_STYLE_LADY,
	WALKING_STYLE_LADY2,
	WALKING_STYLE_WHORE,
	WALKING_STYLE_WHORE2,
	WALKING_STYLE_DRUNK,
	WALKING_STYLE_BLIND
};


#include "config.inc"
#include "Y/configuration/general.pwn"
#include "Y/configuration/database.pwn" // สร้างไฟล์ database.pwn ด้วยตัวเองในไดเรกทอรี่ gamemodes/Y/configuration/..

// อรรถประโยชน์
#include "Y/utility/colour.pwn"
#include "Y/utility/utils.pwn"

// เอกลักษณ์
#include "Y/entities/entities.pwn"
#include "Y/entities/veh.pwn"
#include "Y/entities/computer.pwn"
#include "Y/entities/fine.pwn"
#include "Y/entities/helpme.pwn"
#include "Y/entities/gps.pwn"
#include "Y/entities/global.pwn"
#include "Y/entities/boombox.pwn"
#include "Y/entities/clothing.pwn"
#include "Y/entities/customskin.pwn"
#include "Y/entities/fuel.pwn"
#include "Y/entities/furniture.pwn"
#include "Y/entities/package.pwn"
#include "Y/entities/cim.pwn"

// ตัวหลัก
#include "Y/define.pwn"
#include "Y/enums.pwn"
#include "Y/variables.pwn"
#include "Y/function.pwn"
#include "Y/mysql/database.pwn"

#include "Y/systems/textdraw/showmodel.pwn"
#include "Y/systems/vehicle/vehicles.pwn"
#include "Y/systems/vehicle/fuel.pwn"
#include "Y/systems/vehicle/carmod.pwn"
#include "Y/systems/vehicle/car_rental.pwn"
#include "Y/systems/vehicle/dmv.pwn"
#include "Y/systems/cooldown.pwn"
#include "Y/systems/job.pwn"
#include "Y/systems/report.pwn"
#include "Y/systems/weapon.pwn"
#include "Y/systems/faction.pwn"
#include "Y/systems/furniture/house.pwn"
#include "Y/systems/house.pwn"
#include "Y/systems/business.pwn"
#include "Y/systems/entrance.pwn"

#include "Y/systems/phone.pwn"
#include "Y/systems/business/ui_buy.pwn"
#include "Y/systems/business/vehbuy.pwn"
#include "Y/systems/anim.pwn"
#include "Y/systems/furniture/computer.pwn"
#include "Y/systems/furniture/boombox.pwn"
#include "Y/systems/furniture/spike.pwn"
#include "Y/systems/fine.pwn"
#include "Y/systems/gps.pwn"
#include "Y/systems/global.pwn"
#include "Y/systems/business/clothing.pwn"
#include "Y/systems/drug/drug.pwn"
#include "Y/systems/package.pwn"
#include "Y/systems/tolls.pwn"
#include "Y/systems/cim.pwn"
#include "Y/systems/id_card/id_card.pwn"


//#include "Y/jobs/farmer.pwn"
#include "Y/jobs/fisher.pwn"
//#include "Y/jobs/trucker.pwn"
#include "Y/jobs/mechanic.pwn"
//#include "Y/jobs/miner.pwn"
#include "Y/jobs/electrician.pwn"
#include "Y/jobs/fuel.pwn"
#include "Y/jobs/taxi.pwn"
#include "Y/jobs/truck.pwn"
#include "Y/jobs/pizza.pwn"
#include "Y/jobs/mec.pwn"

#include "Y/mysql/CharacterSave.pwn"
#include "Y/mysql/SaveVehicle.pwn"
#include "Y/mysql/Savefaction.pwn"
#include "Y/mysql/SaveHouse.pwn"
#include "Y/mysql/SaveBusiness.pwn"
#include "Y/mysql/SaveEntrance.pwn"
#include "Y/mysql/SaveFacVehicle.pwn"
#include "Y/mysql/SaveComputer.pwn"
#include "Y/mysql/SaveGps.pwn"
#include "Y/mysql/SaveClothing.pwn"
#include "Y/mysql/SaveGlobal.pwn"
#include "Y/mysql/SaveFuel.pwn"
#include "Y/mysql/SaveWp.pwn"

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
#include "Y/commands/drug.pwn"

#include "Y/Interior/house/House1.pwn"
#include "Y/Interior/house/House2.pwn"
#include "Y/Interior/house/house3.pwn"
#include "Y/Interior/house/House3.pwn"
#include "Y/Interior/house/House5.pwn"
#include "Y/Interior/house/House6.pwn"
#include "Y/Interior/house/house7.pwn"
#include "Y/Interior/house/house8.pwn"
#include "Y/Interior/house/house9.pwn"
#include "Y/Interior/house/house10.pwn"

#include "Y/Interior/lspd/wilshire.pwn"
#include "Y/Interior/lspd/jail.pwn"
#include "Y/Interior/lspd/lspd_harbor.pwn"
#include "Y/Interior/lsfd/hq_hpsital.pwn"

#include "Y/Interior/business/Bank.pwn"
#include "Y/Interior/business/Bar1.pwn"
#include "Y/Interior/business/Bar2.pwn"
#include "Y/Interior/business/Bar3.pwn"
#include "Y/Interior/business/biz1.pwn"
#include "Y/Interior/business/biz2.pwn"
#include "Y/Interior/business/biz3.pwn"
#include "Y/Interior/business/pizza.pwn"

#include "Y/Map/harbor.pwn"
#include "Y/Map/415garage.pwn"
#include "Y/Map/garagegas.pwn"
#include "Y/Map/ps.pwn"
#include "Y/Map/map_fight.pwn"
#include "Y/Map/pump.pwn"
#include "Y/Map/lsrplite_map.pwn"
#include "Y/Map/car_buy.pwn"
#include "Y/Map/chinatown.pwn"
#include "Y/Map/grovest.pwn"


#include "Y/systems/discord/discord.pwn"

#include "Y/test/functionPlayer.pwn"

#include "Y/systems/textdraw/computer.pwn"
#include "Y/systems/textdraw/blindfold.pwn"
#include "Y/systems/textdraw/td-action.pwn"
#include "Y/systems/textdraw/information.pwn"
#include "Y/systems/cctv/cctv.pwn"
#include "Y/systems/textdraw/hud_veh.pwn"
//#include "Y/systems/textdraw/mdc.pwn"

#if SETUP_TABLE
    #include "install"
#endif

main() { }


forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
    new str[120];

    /*if(PlayerInfo[playerid][pAdmin])
        return 1;*/
    
    if(IsPlayerAndroid(playerid) == true)
        return 1;

    if(!code)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น Airbreck", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Airbreck",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");

    }
    else if(code == 2)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น teleport", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke teleport",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
        //KickEx(playerid);
    }
    else if(code == 9)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น Surf", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Surf",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 15)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น ในการเสกอาวุธ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Weapons",e_pAccountData[playerid][mDBID] ,PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        RemovePlayerWeapon(playerid, GetPlayerWeapon(playerid));
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 18)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น เสก Jeckpat", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Jeckpat",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 48)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น ล่องหน", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Invisible",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
        //KickEx(playerid);
    }
    else if(code == 38)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s อินเตอร์เน็ตมีความล่าช้าเกินไป", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Low Internet",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "Ping คุณมากเกินไปในการเข้าเล่นโปรดตรวจสอบการเชื่อมต่ออินเตอร์เน็ตอีกครั้ง");
    }
    else if(code == 47)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น เสกอาวุธ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Weapons",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 11)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น ซ่อมยานพหานะ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Repair Vehicle",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
        //KickEx(playerid);
    }
    else if(code == 13)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น เสกเกราะ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Armour",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 12)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น เสกเลือด", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Health",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 23)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น แต่งยานพาหานะ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Modefile Vehicle",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 10)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น Speed Hack", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Speed Hack",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else if(code == 4)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น วาปเข้ายานพหานะ", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Warp To Vehicle",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        //SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
        //KickEx(playerid);
    }
    else if(code == 14)
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น เสกเงิน", playerid, ReturnName(playerid,0));
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacke Money",e_pAccountData[playerid][mDBID], PlayerInfo[playerid][pDBID],ReturnName(playerid,0));
	    SendDiscordMessage("hacker", str);
        //SetPlayerArmour(playerid,0);
        //SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
    }
    else 
    {
        SendAdminMessageEx(COLOR_LIGHTRED,1, "AdmWarn: [%d] %s มีความเป็นไปได้ที่จะใช้โปรแกรมในการช่วยเล่น (%d)", playerid, ReturnName(playerid,0), code);
        format(str, sizeof(str), "[HECK] UCP_ID:%d CHARDBID:%d  %s Hacker is check in game now (#%d)",e_pAccountData[playerid][mDBID],PlayerInfo[playerid][pDBID],ReturnName(playerid,0), code);
        SendDiscordMessage("hacker", str);
        /*SetPlayerArmour(playerid,0);
        SendClientMessage(playerid, COLOR_LIGHTRED, "คุณถูกต้องสงสัยว่าใช้โปรแกรมในการช่วยเล่น");
        KickEx(playerid);*/
    }
    return 1;
}

public OnGameModeInit() {

    SendRconCommand("hostname "GM_HOST_NAME"");
    SetGameModeText(GM_VERSION);

    SetNameTagDrawDistance(10.0);

    
    mysql_tquery(dbCon, "SELECT * FROM factions ORDER BY dbid ASC", "Query_LoadFactions");
    mysql_tquery(dbCon, "SELECT * FROM House ORDER BY HouseDBID", "Query_LoadHouse");
    mysql_tquery(dbCon, "SELECT * FROM Business ORDER BY BusinessDBID", "Query_LoadBusiness");
    mysql_tquery(dbCon, "SELECT * FROM phonebook ORDER BY PhoneDBID", "LoadPhoneBook");
    mysql_tquery(dbCon, "SELECT * FROM entrance ORDER BY EntranceDBID", "LoadEntrance");
    mysql_tquery(dbCon, "SELECT * FROM vehicles WHERE VehicleCarPark > 0", "LoadCarPark");
    //mysql_tquery(dbCon, "SELECT * FROM vehicles WHERE VehicleFaction > 0", "LoadFactionVehicle");
    mysql_tquery(dbCon, "SELECT * FROM global ORDER BY ID", "LoadGlobal");
    // ใช้การควบคุมเครื่องยนต์ด้วยสคริปต์แทน
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);


    ShowPlayerMarkers(0);
    ShowNameTags(1);
    //Timer:
    SetTimer("OnPlayerNereHouseTime", 1000, true);
    SetTimer("OnPlayerNereBusinessTime", 3000, true);
    SetTimer("OnVehicleUpdate", 100, true);
    SetTimer("FunctionPaychecks", 1000, true);
    //Timer:

    adminactionlog = CreateLog("server/admin_action");
    allcmdlog = CreateLog("server/allcmdlog");
    DeathLog = CreateLog("server/deathlog");
    chatlog = CreateLog("server/chatlog");
    
    return 1;
}

public OnGameModeExit() {
    DestroyLog(adminactionlog);

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

    ResetPlayerCharacter(playerid);

	new query[90];
    new musicrandom = random(2);
    switch(musicrandom)
    {
        case 0:
        {
            PlayAudioStreamForPlayer(playerid, "https://media1.vocaroo.com/mp3/19UHoxtICKtN"); // Alt J Breezeblocks
        }
        case 1:
        {
            PlayAudioStreamForPlayer(playerid, "https://media1.vocaroo.com/mp3/1iJjMS256RgV"); // Blinding Lights [Acoustic Version] - The Weeknd
        }
    }


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
    
	mysql_format(dbCon, query, sizeof(query), "SELECT COUNT(acc_name) FROM `masters` WHERE acc_name = '%e'", ReturnPlayerName(playerid));
	mysql_tquery(dbCon, query, "OnPlayerJoin", "d", playerid);

    SendClientMessage(playerid, -1, "ยินดีต้อนรับเข้าสู่ "EMBED_YELLOW"Los Santos Roleplay LITE");


    return 1;
}


hook OnPlayerDisconnect(playerid, reason)
{
    new str[120];
    format(str, sizeof(str), "[%s] %s : Disconnect", ReturnDate(),ReturnName(playerid,0));
    SendDiscordMessageEx("connecnt", str);

    static const szDisconnectReason[3][] = {"หลุด","ออกจากเกมส์","ถูกเตะ"};
    ProxDetector(playerid, 20.0, sprintf("*** %s ออกจากเซิร์ฟเวอร์ (%s)", ReturnPlayerName(playerid), szDisconnectReason[reason]));


    for(new i = 1; i <= 10; i++)
    {
        DestroyDynamicObject(PlayerInfo[playerid][pObject][i]);
        PlayerInfo[playerid][pObject][i] = INVALID_OBJECT_ID;
    }

    MealOder[playerid] = false;
    
    new playerTime = NetStats_GetConnectedTime(playerid);
	new secondsConnection = (playerTime % (1000*60*60)) / (1000*60);
	
	PlayerInfo[playerid][pLastOnlineTime] = secondsConnection;


    // บันทึกว่าหลุด
	if(reason == 0) {
		PlayerInfo[playerid][pTimeout] = gettime();


        if(PlayerInfo[playerid][pDuty])
        {
            new query[255];
            mysql_format(dbCon, query, sizeof(query), "INSERT INTO `cache`(`C_DBID`, `C_DUTY`) VALUES ('%d','%d')",PlayerInfo[playerid][pDBID], PlayerInfo[playerid][pDuty]);
            mysql_tquery(dbCon, query);
        }
    }

    CharacterSave(playerid);
    ResetPlayerCharacter(playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {

    return 1;
}

public OnPlayerRequestClass(playerid, classid) {
    TogglePlayerSpectating(playerid, true);
    //defer ShowLoginCamera(playerid);
    return 1;
}

public OnPlayerSpawn(playerid) {

	if (!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		Kick(playerid);

    SetPlayerClothing(playerid);

    SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
	SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

    StopAudioStreamForPlayer(playerid);

    SetPlayerWeapons(playerid);

    SetPlayerSpawn(playerid);
    return 1;
}

public OnPlayerText(playerid, text[]) {

    /*new str[144];

    format(str, sizeof(str), "%s พูดว่า: %s", ReturnRealName(playerid, 0), text);
    ProxDetector(playerid, 20.0, str);

	//printf("[%d]%s: %s", playerid, ReturnPlayerName(playerid), text);*/

	return 0;
}

/*public OnPlayerCommandText(playerid, cmdtext[])
{
    return 0;
    // Returning 0 informs the server that the command hasn't been processed by this script.
    // OnPlayerCommandText will be called in other scripts until one returns 1.
    // If no scripts return 1, the 'SERVER: Unknown Command' message will be shown to the player.
}*/

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED)) {
		SendClientMessage(playerid, COLOR_LIGHTRED, "ACCESS DENIED: {FFFFFF}คุณต้องเข้าสู่ระบบก่อนที่จะใช้คำสั่ง");
		return 0;
	}
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
    {
        SendClientMessage(playerid, COLOR_LIGHTRED, "ERROR: {FFFFFF}เกิดข้อผิดพลาดในการใช้คำสั่ง...");
        return 0;
    }
  
    new str[120];
    format(str, sizeof(str), "[CMD] %s: /%s",ReturnRealName(playerid, 0), cmd);
    SendDiscordMessageEx("command", str);

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
        ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);	
	}

    if(GetPlayerWeapon(playerid) != 0 && GetPlayerWeapon(playerid) != 5 && GetPlayerWeapon(playerid) != 4 && GetPlayerWeapon(playerid) != WEAPON_CAMERA && !GetPVarInt(playerid, "CheckKickPlayerWeaponsTime"))
    {   
        if(PlayerInfo[playerid][pTimeplayed] < 30)
		{
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณกำลังจะถูกเตะออกจากเซิร์ฟเวอร์ในข้อหา ครอบครองอาวุธโดยชั่วโมงออนไลน์ยังไม่ถึง 30 ชั่มโมง");
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "ขอให้คุณรีบติดต่อผู้ดูแลระบบหรือนำอาวุธของคุณไปเก็บก่อนที่จะโดนเดะ คุณต้องรีบดำเนินการภายใน 60 วินาที");
            SetTimerEx("KickPlayerWeaponsTime", 60000, false, "d",playerid);
            SetPVarInt(playerid, "CheckKickPlayerWeaponsTime",1);
		}
    }
    return 1;
}

forward KickPlayerWeaponsTime(playerid);
public KickPlayerWeaponsTime(playerid)
{
    if(PlayerInfo[playerid][pTimeplayed] < 30)
    {
        if(GetPlayerWeapon(playerid) != 0 && GetPlayerWeapon(playerid) != 5 && GetPlayerWeapon(playerid) != 4 && GetPlayerWeapon(playerid) != WEAPON_CAMERA)
        {
            SendAdminMessageEx(COLOR_LIGHTRED, 1, "%s ถูกเตะออกจากเซิร์ฟเวอร์ใน สาเหตุ ถือครองอาวุธ เมื่อออนไลน์ยังไม่ครบ 30 ชั่วโมง",ReturnRealName(playerid, 0));
            SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s ถูกเตะออกจากเซิร์ฟเวอร์ใน สาเหตุ ถือครองอาวุธ เมื่อออนไลน์ยังไม่ครบ 30 ชั่วโมง",ReturnRealName(playerid, 0));
            ResetPlayerWeapons(playerid);
            KickEx(playerid);
        }
    }
    
    DeletePVar(playerid, "CheckKickPlayerWeaponsTime");
    return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == mechanic_pickup)
    {
        GameTextForPlayer(playerid, "~g~Mechamic Job ~n~~w~/takejob~n~~g~For Register", 3500, 3);
        return 1;
    }
    return 1;
}
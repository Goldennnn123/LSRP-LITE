#define MAX_FACTION_RANKS       	(21)
#define MAX_FACTIONS				(30)
#define MAX_HOUSE					(300)
#define MAX_BUSINESS				(150)
#define MAX_PHONEBOOK				(700)
#define MAX_ENTRANCE				(700)
#define MAX_FACTION_VEHICLE			(200)
#define MAX_DRINKMENU				(200)

enum E_PLAYER_DATA
{
    pDBID,
	bool:pWhitelist,
    pAdmin,
	pTester,
	bool:pTesterDuty,
    bool:pAdminDuty,
    pLastSkin,
    bool:pTutorial,
    pLevel,
    pExp,
    pCash,
	pBank,
    pFaction,
	pFactionRank,
	pFactionInvite,
	pFactionInvitedBy,
	bool:pFactionChat,
    pTimeout,
    pSpawnPoint,
    pSpawnHouse,

    Float:pHealth,
    Float:pArmour,
    
    Float:pLastPosX,
    Float:pLastPosY,
    Float:pLastPosZ,
    pLastInterior,
    pLastWorld,

    pJob,
    pSideJob,
    pCareer,
	pJobRank,
	pJobExp,
    
    pPaycheck, // เงินเดือน - ต้องไปรับที่ธนาคาร
    pFishes,
    
    // ตัวแปรชั่วคราว (ไม่บันทึก)
    pDuplicateKey,

    pUnscrambleID,
    bool:pUnscrambling,
    pUnscramblerTime,
    Timer:pUnscrambleTimer,
    pScrambleSuccess,
	pScrambleFailed,
    pCMDPermission,

	pBadge,
    bool:pPoliceDuty,
    bool:pSheriffDuty,
    bool:pMedicDuty,
    bool:pSADCRDuty,
    bool:pGovDuty,
	bool:pDuty,
   	pActiveIP,


    pInsideProperty,
    pInsideBusiness,


    bool:pAdminjailed, 
	pAdminjailTime,

    pSpectating,

    bool:pHasMask,
    pMaskID[2],
	bool:pMasked,

    bool:pWeaponsSpawned,
	pWeaponsImmune,
	pWeapons[13], 
	pWeaponsAmmo[13],

	pGun[4],
	pGunAmmo[4],

    pOwnedVehicles[12],
	bool:pVehicleSpawned,
	pVehicleSpawnedID,

	bool:pHasRadio,
	bool:pRadioOn,
	pRadio[10],
	pMainSlot,

	pLastDamagetime,
	pDeathFix,
	pRespawnTime,

	pTimeplayed,
	pLastOnline[90],
	pLastOnlineTime,

	pPhone,
	pPhonePower,
	bool:pPhoneOff,
	pPhoneline,
	pCalling,
	bool:pPhonespeaker,

	pGUI,
	pCigare,
	bool:pBoomBox,
	pBoomBoxSpawnID,


	bool:pDriverLicense,
	pDriverLicenseWarn,
	bool:pDriverLicenseRevoke,
	bool:pDriverLicenseSus,

	bool:pWeaponLicense,
	pWeaponLicenseType,
	bool:pWeaponLicenseRevoke,
	bool:pWeaponLicenseSus,

	bool:pPilotLicense,
	bool:pPilotLicenseBlacklist,
	bool:pPilotLicenseRevoke,

	bool:pMedicLicense,
	bool:pMedicLicenseRevoke,

	bool:pTuckingLicense,
	pTuckingLicenseWarn,
	bool:pTuckingLicenseRevoke,
	bool:pTuckingLicenseSus,

	bool:pTxaiLicense,

	pCPU,
	pGPU,
	pRAM,
	pStored,
	Float:pBTC,

	bool:pHandcuffed,

	bool:pTaser,
	pSaving,

	bool:pArrest,
	pArrestBy,
	pArrestTime,
	pArrestRoom,

	pSkinClothing[3],
	
	pDonater,
	pDonaterTime,

	pOre,
	pCoal,
	pIron,
	pCopper,
	pKNO3,

	pTicket[6],

	pClothing[9],

	Float:pDrug[3],
	bool:pAddicted,
	pAddictedCount,

	pWalk,
	pFight,

	pShakeOffer,
	pShakeType,

	pObject[11],
	bool:pTogPm,
	pAnimation,

	pHouseKey,
	pBusinessKey,
	pGasCan,
	pRepairBox,

	bool:pHasid_card,
	pId_dob[50],
	pId_number,
	pId_gebder[10],
	pid_expire[50]
};

new PlayerInfo[MAX_PLAYERS][E_PLAYER_DATA], PlayerCheckpoint[MAX_PLAYERS], bool:PlayerEditObject[MAX_PLAYERS];
new PlayerDrugUse[MAX_PLAYERS], bool:MealOder[MAX_PLAYERS]; new PlayerText:RadioStats[MAX_PLAYERS];
new playerblock[MAX_PLAYERS], playershottick[MAX_PLAYERS], PlayerEdit[MAX_PLAYERS];
new PlayerSeClo[MAX_PLAYERS], PlayerSeCloBuy[MAX_PLAYERS], PlayerSeCloBuySect[MAX_PLAYERS], PlayerCloID[MAX_PLAYERS];


enum P_MASTER_ACCOUNTS
{
	mDBID,
	mAccName[64],
    mForumName[266]
}

new e_pAccountData[MAX_PLAYERS][P_MASTER_ACCOUNTS]; 


enum G_REPORT_INFO
{
	bool:rReportExists,
	rReportDetails[90], 
	rReportTime,
	rReportBy[32]
}

new ReportInfo[100][G_REPORT_INFO]; 
new playerReport[MAX_PLAYERS][128]; 

enum E_DROPPEDGUN_DATA
{
	bool:eWeaponDropped,
	eWeaponObject,
	eWeaponTimer,
	
	eWeaponWepID,
	eWeaponWepAmmo,
	
	Float:eWeaponPos[3],
	eWeaponInterior,
	eWeaponWorld,
	
	eWeaponDroppedBy
}

new WeaponDropInfo[200][E_DROPPEDGUN_DATA];


enum E_FACTION_INFO
{
	eFactionDBID,
	
	eFactionName[90],
	eFactionAbbrev[30], 
	
	Float: eFactionSpawn[3],
	eFactionSpawnInt,
	eFactionSpawnWorld,
	
	eFactionJoinRank,
	eFactionAlterRank,
	eFactionChatRank,
	eFactionTowRank,
	
	bool:eFactionChatStatus,
	eFactionChatColor,
	
	eFactionType,
	eFactionJob,	
}

new FactionInfo[MAX_FACTIONS][E_FACTION_INFO]; 
new FactionRanks[MAX_FACTIONS][MAX_FACTION_RANKS][60];
new PlayerSelectFac[MAX_PLAYERS], playerEditingRank[MAX_PLAYERS];

enum E_HOUSE_INFO
{
	HouseDBID,
	HouseName[90],
	HouseOwnerDBID,

	Float:HouseEntrance[3],
	HouseEntranceWorld,
	HouseEntranceInterior,

	Float:HouseInterior[3],
	HouseInteriorWorld,
	HouseInteriorID,

	HousePrice,
	HouseLevel,
	bool:HouseRentStats,
	HouseRent,
	HouseRentPrice,

	HouseWeapons[22],
	HouseWeaponsAmmo[22],

	Float:HousePlacePos[3],

	HousePickup,
	bool:HouseLock,
	bool:HouseSwicth,
	HouseEle,
	HouseTimerEle,


	HouseStockCPU,
	HouseStockGPU,
	HouseStockRAM,
	HouseStockStored,

	Float:HouseDrug[3],

	bool:HouseMusic,
	HouseMusicLink[150],

	HouseStatus,
	HouseAreaID,
	
}
new HouseInfo[MAX_HOUSE][E_HOUSE_INFO];

enum E_BUSINESS_INFO
{
	BusinessDBID,
	BusinessName[90],
	BusinessOwnerDBID,

	BusinessType,
	BusinessPrice,
	Businesslevel,
	BusinessEntrancePrice,
	bool:BusinessLock,
	
	BusinessEntrancePickUp,
	Float:BusinessEntrance[3],
	BusinessEntranceWorld,
	BusinessEntranceInterior,

	Float:BusinessInterior[3],
	BusinessInteriorWorld,
	BusinessInteriorID,

	BusinessBankPickup,
	Float:BusinessBankPickupLoc[3],
	BusinessBankWorld,

	BusinessCash,
	BusinessS_Cemara,
	BusinessS_Mask,
	BusinessS_Flower,

	bool:BusinessMusic,
	BusinessMusicLink[150],

	BizDrink[11],
	BizTimeRob
}
new BusinessInfo[MAX_BUSINESS][E_BUSINESS_INFO];

enum D_DRINKMENU_DATA
{
	drink_id,
	drink_bizid,
	drink_name[60],
	drink_price,
	drink_model,
	drink_drunk,
}
new DrinkMenuInfo[MAX_DRINKMENU][D_DRINKMENU_DATA];

enum E_DAMAGE_INFO
{
	eDamageTaken,
	eDamageTime,
	
	eDamageWeapon,
	
	eDamageBodypart,
	eDamageArmor,
	
	eDamageBy
}

new DamageInfo[MAX_PLAYERS][100][E_DAMAGE_INFO]; 
new TotalPlayerDamages[MAX_PLAYERS];


enum E_PONEBOOK_DATA
{
	PhoneDBID,
	PhoneOwnerDBID,

	PhoneName[60],
	PhoneNumber,
}
new PhoneInfo[MAX_PHONEBOOK][E_PONEBOOK_DATA];

enum ENTRANCE_DATA
{
	EntranceDBID,
	EntranceIconID,
	EntrancePickup,

	Float:EntranceLoc[3],
	EntranceLocWorld,
	EntranceLocInID,

	Float:EntranceLocIn[3],
	EntanceLocInWorld,
	EntranceLocInInID,
}
new EntranceInfo[MAX_ENTRANCE][ENTRANCE_DATA];
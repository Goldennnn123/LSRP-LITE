#define MAX_FACTION_RANKS       	(21)
#define MAX_FACTIONS				(30)

enum E_PLAYER_DATA
{
    pDBID,
    pAdmin,
    bool:pAdminDuty,
    pLastSkin,
    bool:pTutorial,
    pLevel,
    pExp,
    pCash,
	pBank,
    pFaction,
	pFactionRank,
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
    
    pPaycheck, // �Թ��͹ - ��ͧ��Ѻ��踹Ҥ��
    pFishes,
    
    // ����ê��Ǥ��� (���ѹ�֡)
    pDuplicateKey,

    pUnscrambleID,
    bool:pUnscrambling,
    pUnscramblerTime,
    Timer:pUnscrambleTimer,
    pScrambleSuccess,
	pScrambleFailed,
    pCMDPermission,

    pPoliceDuty,
    pSheriffDuty,
    pMedicDuty,
    pSADCRDuty,
    pGovDuty,
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

    pOwnedVehicles[7],
	bool:pVehicleSpawned,
	pVehicleSpawnedID,

	bool:pHasRadio,
	pRadio[3],
	pMainSlot

};

new PlayerInfo[MAX_PLAYERS][E_PLAYER_DATA], PlayerCheckpoint[MAX_PLAYERS];

enum P_MASTER_ACCOUNTS
{
	mDBID,
	mAccName[64],
    mForumName[266]
}

new e_pAccountData[MAX_PLAYERS][P_MASTER_ACCOUNTS]; 

enum E_VEHICLE_SYSTEM
{
	eVehicleDBID, 
	bool:eVehicleExists,
	
	eVehicleOwnerDBID,
	eVehicleFaction,
	
	eVehicleModel, 
	eVehicleColor1,
	eVehicleColor2,
	eVehiclePaintjob,
	
	Float:eVehicleParkPos[4],
	eVehicleParkInterior,
	eVehicleParkWorld,
	
	eVehiclePlates[32], 
	bool:eVehicleLocked,
	
	bool:eVehicleImpounded,
	Float:eVehicleImpoundPos[4], 
	
	eVehicleWeapons[6], //5;
	eVehicleWeaponsAmmo[6], //5;
	
	Float:eVehicleFuel,
	eVehicleSirens,
	
	eVehicleLastDrivers[5], //4;
	eVehicleLastPassengers[5], //4;
	
	bool:eVehicleLights,
	bool:eVehicleEngineStatus,
	
	bool:eVehicleAdminSpawn,
	
	Text3D:eVehicleTowDisplay,
	eVehicleTowCount,
	
	bool:eVehicleHasXMR, 
	bool:eVehicleXMROn,
	eVehicleXMRURL[128],
	
	Float:eVehicleBattery,
	Float:eVehicleEngine, 
	eVehicleTimesDestroyed,
	
	eVehicleLockLevel,
	eVehicleAlarmLevel, 
	eVehicleImmobLevel,
	
	Text3D:eVehicleEnterTD,
	eVehicleEnterTimer,
	
	bool:eVehicleHasCarsign,
	Text3D:eVehicleCarsign,
	
	eVehicleRefillCount,
	Text3D:eVehicleRefillDisplay,
	
	eVehicleTruck,
	
	Text3D:eVehicleRepairDisplay,
	eVehicleRepairCount,
    
    eVehicleMod[14]
}

new VehicleInfo[MAX_VEHICLES][E_VEHICLE_SYSTEM];


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
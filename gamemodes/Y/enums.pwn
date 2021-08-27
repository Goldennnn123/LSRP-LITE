//--------------------------------[ENUMS.PWN]--------------------------------

enum PlayerFlags:(<<= 1)    // BitFlag
{
    IS_SPAWNED = 1,
	IS_LOGGED
};

enum (<<= 1)
{
    CMD_PLAYER = 1,
    CMD_TESTER,
    CMD_ADM_1,
    CMD_ADM_2,
    CMD_ADM_3,
    CMD_LEAD_ADMIN,         // Lead Admin
    CMD_MANAGEMENT,         // Management
    CMD_DEV,                // Developer
};

enum systemE {
	OOCStatus
}
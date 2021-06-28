#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "การใช้:"EMBED_WHITE" "%1)

// ใช้มาโคร BitFlag
#define BitFlag_Get(%0,%1)   		((%0) & (%1))   // ส่งค่ากลับ 0 (เท็จ)หากยังไม่ได้ตั้งค่าให้มัน
#define BitFlag_On(%0,%1)    		((%0) |= (%1))  // ปรับค่าเป็น เปิด
#define BitFlag_Off(%0,%1)   		((%0) &= ~(%1)) // ปรับค่าเป็น ปิด
#define BitFlag_Toggle(%0,%1)		((%0) ^= (%1))  // สลับค่า (สลับ จริง/เท็จ)

#define	MAX_STRING					4000

#define SETUP_TABLE (false)

#define	SPAWN_AT_DEFAULT			0
#define	SPAWN_AT_HOUSE				1
#define	SPAWN_AT_FACTION			2
#define	SPAWN_AT_LASTPOS			3

#define MAX_PLAYER_VEHICLES			(6)

#define PLAYER_STATE_ALIVE (1)
#define PLAYER_STATE_WOUNDED (2)
#define PLAYER_STATE_DEAD (3)

#define SendUsageMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_WHITE, "USAGE: {FFFFFF}"%1) 
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "ERROR: {FFFFFF}"%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_ACTION, "SERVER: {FFFFFF}"%1) 

	
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))	

#define Pressed(%0)	\
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define PRESSING(%0,%1) \
	(%0 & (%1))

#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0






#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "�����:"EMBED_WHITE" "%1)

// ������ BitFlag
#define BitFlag_Get(%0,%1)   		((%0) & (%1))   // �觤�ҡ�Ѻ 0 (��)�ҡ�ѧ������駤������ѹ
#define BitFlag_On(%0,%1)    		((%0) |= (%1))  // ��Ѻ����� �Դ
#define BitFlag_Off(%0,%1)   		((%0) &= ~(%1)) // ��Ѻ����� �Դ
#define BitFlag_Toggle(%0,%1)		((%0) ^= (%1))  // ��Ѻ��� (��Ѻ ��ԧ/��)

#define	MAX_STRING					4000

#define	SPAWN_AT_DEFAULT			0
#define	SPAWN_AT_HOUSE				1
#define	SPAWN_AT_FACTION			2

#define MAX_PLAYER_VEHICLES			(7)

#define SendUsageMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_WHITE, "USAGE: "%1) 
	
#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_RED, "ERROR: "%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_ACTION, "SERVER: "%1) 	



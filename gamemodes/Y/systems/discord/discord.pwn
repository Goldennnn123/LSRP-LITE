#define USING_DISCORD

#include <discord-connector>

#if defined USING_DISCORD
new 
    DCC_Channel:g_ServerOpen,
	DCC_Channel:ConnactLog,
	DCC_Channel:DeathLogs,
	DCC_Channel:HackerLog,
	DCC_Channel:DrugLog,
	DCC_Channel:CommandAdminLog;
#endif


/**
* ฟังชั่นในการส่งข้อความเข้า ดิสคอร์ด เพื่อเป็นการแจ้งเตือนข้อความภายในเซิร์ฟเวอร์
* โปรดใชเอย่างระมัดระวังไม่ไปส่งในห้องของ Player;
*/
stock SendDiscordMessage(channel, const message[])
{
	switch(channel)
	{
		case 0:
		{
			g_ServerOpen = DCC_FindChannelById("848148148714209311");
			DCC_SendChannelMessage(g_ServerOpen, message);
            return 1;
		}
		case 1:
		{
			ConnactLog = DCC_FindChannelById("862580236524191744");
			DCC_SendChannelMessage(ConnactLog, message);
			return 1;
		}
		case 3:
		{
			DeathLogs = DCC_FindChannelById("862580926134878248");
			DCC_SendChannelMessage(DeathLogs, message);
			return 1;
		}
		case 4:
		{
			HackerLog = DCC_FindChannelById("863094920281325608");
			DCC_SendChannelMessage(HackerLog, message);
			return 1;
		}
		case 5:
		{
			DrugLog = DCC_FindChannelById("863604214764666900");
			DCC_SendChannelMessage(DrugLog, message);
			return 1;
		}
		case 6:
		{
			CommandAdminLog = DCC_FindChannelById("862581433302384650");
			DCC_SendChannelMessage(CommandAdminLog, message);
		}
	}
	return 1;
}


#if defined USING_DISCORD
forward DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[]);
public DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[])
{
	if(channel != CommandAdminLog)
		return 1;
	
	if(!strcmp(message, "&online", true))
	{
		new Android = 0, PC = 0; new str[60];

		foreach(new i : Player)
		{
			if(IsPlayerAndroid(i) == true)
			{
				Android++;
			}
			else PC++;
		}
		format(str, sizeof(str), "Android: %d คน PC: %d คน",Android, PC);
		SendDiscordMessage(6, str);
		return 1;
	}

	return 1;
}
#endif
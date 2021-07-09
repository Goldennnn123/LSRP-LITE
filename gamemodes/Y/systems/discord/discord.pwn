#include <discord-connector>

#if defined USING_DISCORD
new 
    DCC_Channel:g_ServerOpen,
	DCC_Channel:ConnactLog,
	DCC_Channel:DeathLogs,
	DCC_Channel:HackerLog;
#endif

stock SendDiscordMessage(channel, const message[])
{
	switch(channel)
	{
		case 0:
		{
			g_ServerOpen = DCC_FindChannelById("853624525354041375");
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
	}
	return 1;
}


#if defined USING_DISCORD
forward DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[]);
public DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[])
{
   new channel_name[32];
   DCC_GetChannelName(channel, channel_name);

   new str[145];
   format(str, sizeof str, "[Discord/%s] %s: %s", channel_name, author, message);
   SendClientMessageToAll(-1, str);
   return 1;
}
#endif
#define USING_DISCORD

#include <discord-connector>

#if defined USING_DISCORD
new 
    DCC_Channel:g_ServerOpen,
	DCC_Channel:ConnactLog,
	DCC_Channel:DeathLogs,
	DCC_Channel:HackerLog,
	DCC_Channel:DrugLog,
	DCC_Channel:CommandAdminLog,
	DCC_Channel:D_HelpupLog,
	DCC_Channel:channelFind;
#endif


/*
* �ѧ���㹡���觢�ͤ������ ��ʤ��� �����繡������͹��ͤ����������������
* �ô�����ҧ���Ѵ���ѧ���������ͧ�ͧ Player;
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
			HackerLog = DCC_FindChannelById("873840389507940372");
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
			CommandAdminLog = DCC_FindChannelById("898561843726004254");
			DCC_SendChannelMessage(CommandAdminLog, message);
		}
		case 7:
		{
			D_HelpupLog = DCC_FindChannelById("862585567232786452");
			DCC_SendChannelMessage(D_HelpupLog, message);
		}
	}
	return 1;
}

stock SendDiscordMessageEx(const channel[], const fmat[])
{
	channelFind = DCC_FindChannelById(channel);

	DCC_SendChannelMessage(channelFind, fmat);
	return 1;
}

stock SendDiscordMessageExs(channel[], fmat[],  va_args<>)
{
	new
		str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);

	channelFind = DCC_FindChannelById(channel);

	utf8encode(str, str, sizeof(str));
	return DCC_SendChannelMessage(channelFind, str);
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
		format(str, sizeof(str), "Android: %d �� PC: %d ��",Android, PC);
		SendDiscordMessage(6, str);
		return 1;
	}

	return 1;
}
#endif
#define USING_DISCORD

#include <discord-connector>

#if defined USING_DISCORD
new 
	DCC_Channel:channelFind;
	
#endif

stock SendDiscordMessage(channel[], fmat[])
{
	channelFind = DCC_FindChannelByName(channel);
	return DCC_SendChannelMessage(channelFind, fmat);
}

stock SendDiscordMessageEx(channel[], fmat[],  va_args<>)
{
	new
		str[145];

	va_format(str, sizeof (str), fmat, va_start<2>);
    utf8encode(str, str, sizeof(str));


	channelFind = DCC_FindChannelByName(channel);
	return DCC_SendChannelMessage(channelFind, str);
}
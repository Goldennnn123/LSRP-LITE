#define USING_DISCORD

#include <discord-connector>

#if defined USING_DISCORD
new 
	DCC_Channel:channelFind,
	DCC_Channel:g_Discord_Chat;
	
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

#if defined USING_DISCORD

forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
    new realMsg[100];

	g_Discord_Chat = DCC_FindChannelById("907124755411386368");  //add your channel id here


    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
    DCC_GetMessageChannel(message, channel);

    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);

    if(channel == g_Discord_Chat && !IsBot) 
    {
        new user_name[32 + 1], str[152];
        DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "{8a6cd1}[Discord] {aa1bb5}%s: {ffffff}%s",user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }
 
    return 1;
}
/*forward DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[]);
public DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[])
{
	channelFind = DCC_FindChannelByName("admin-cmd");

	if(channel != channelFind)
		return 1;
	
	new content[64];
	DCC_GetMessageContent(message, content);

	if(!strcmp(message, "/online", true))
	{
		SendDiscordMessage("admin-cmd", "/online");
		return 1;
	}

	return 1;
}*/
#endif
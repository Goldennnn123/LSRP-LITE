CMD:me(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/me [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %.80s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "... %s", params[80]);
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid, 0), params);

	Log(chatlog, WARNING, "[ME] * %s %s",ReturnName(playerid, 0), params);
	return 1;
}

CMD:ame(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/ame [action]");
	
	new string[128];
	format(string, sizeof(string), "* %s %s", ReturnName(playerid, 0), params);
	SendClientMessage(playerid, COLOR_PURPLE, string);

 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 5.0, 6000);
	Log(chatlog, WARNING, "[AME] * %s %s",ReturnName(playerid, 0), params);
	return 1;
}

CMD:do(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/do [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 15.0, COLOR_YELLOW, "* %.80s", params);
	    SendNearbyMessage(playerid, 15.0, COLOR_YELLOW, "... %s (( %s ))", params[80],ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_YELLOW, "* %s (( %s ))", params, ReturnName(playerid, 0));
	Log(chatlog, WARNING, "[DO] * %s (( %s ))",params, ReturnName(playerid, 0));
	return 1;
}

CMD:dolow(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/dolow [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 4.0, COLOR_YELLOW, "* %.80s", params);
	    SendNearbyMessage(playerid, 4.0, COLOR_YELLOW, "... %s (( %s ))", params[80], ReturnName(playerid, 0));
	}
	else SendNearbyMessage(playerid, 4.0, COLOR_YELLOW, "* %s (( %s ))", params, ReturnName(playerid, 0));
	Log(chatlog, WARNING, "[DO-LOW] * %s (( %s ))",params, ReturnName(playerid, 0));
	return 1;
}

alias:low("l")
CMD:low(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "การใช้: /low [ข้อความ]");
	
	new str[128];

	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s พูดว่า [เสียงเบา]: %.80s", ReturnName(playerid, 0), params);
	    ProxDetector(playerid, 3.0, str);

	    format(str, sizeof(str), "... %s", params[80]);
	    ProxDetector(playerid, 3.0, str);
	}
	else format(str, sizeof(str), "%s พูดว่า [เสียงเบา]: %s", ReturnName(playerid, 0), params), ProxDetector(playerid, 3.0, str);

	Log(chatlog, WARNING, "[LOW] %s พูดว่า [เสียงเบา]: %s",ReturnName(playerid, 0), params);
	return 1;
}

alias:shout("s")
CMD:shout(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "(/s)hout [ข้อความ]");

	new str[128];
	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s ตะโกน: %.80s", ReturnName(playerid, 0), params);
	    ProxDetector(playerid, 30.0, str);

	    format(str, sizeof(str), "... %s!", params[80]);
	    ProxDetector(playerid, 30.0, str);
	}
	else format(str, sizeof(str), "%s ตะโกน: %s!", ReturnName(playerid, 0), params), ProxDetector(playerid, 30.0, str);
	Log(chatlog, WARNING, "[SHOUT] %s ตะโกน: %s!",ReturnName(playerid, 0), params);
	return 1;
}
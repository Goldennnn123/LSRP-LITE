CMD:me(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/me [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %.80s", ReturnRealName(playerid,0), params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "... %s", params[80]);
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s %s", ReturnRealName(playerid,0), params);

	return 1;
}

CMD:ame(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/ame [action]");
	
	new string[128];
	format(string, sizeof(string), "* %s %s", ReturnRealName(playerid,0), params);
	SendClientMessage(playerid, COLOR_PURPLE, string);

 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 5.0, 6000);
	return 1;
}

CMD:do(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/do [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %.80s", params);
	    SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "... %s (( %s ))", params[80],ReturnRealName(playerid,0));
	}
	else SendNearbyMessage(playerid, 15.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnRealName(playerid,0));

	return 1;
}

CMD:dolow(playerid, params[])
{
	if (isnull(params))
	    return SendSyntaxMessage(playerid, "/dolow [action]");

	if (strlen(params) > 80) {
	    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %.80s", params);
	    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "... %s (( %s ))", params[80], ReturnRealName(playerid));
	}
	else SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnRealName(playerid));

	return 1;
}

alias:local("l")
CMD:local(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "(/l)ocal [ข้อความ]");

	new str[128];
	if (strlen(params) > 80) {

	    format(str, sizeof(str), "%s พูดว่า: %.80s", ReturnRealName(playerid), params);
	    ProxDetector(playerid, 20.0, str);

	    format(str, sizeof(str), "... %s", params[80]);
	    ProxDetector(playerid, 20.0, str);
	}
	else format(str, sizeof(str), "%s พูดว่า: %s", ReturnRealName(playerid), params), ProxDetector(playerid, 20.0, str);

	return 1;
}

CMD:low(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "การใช้: /low [ข้อความ]");
	
	new str[128];

	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s พูดว่า [เสียงเบา]: %.80s", ReturnRealName(playerid), params);
	    ProxDetector(playerid, 5.0, str);

	    format(str, sizeof(str), "... %s", params[80]);
	    ProxDetector(playerid, 5.0, str);
	}
	else format(str, sizeof(str), "%s พูดว่า [เสียงเบา]: %s", ReturnRealName(playerid), params), ProxDetector(playerid, 5.0, str);

	return 1;
}

alias:shout("s")
CMD:shout(playerid, params[])
{
	if (isnull(params))
	    return SendClientMessage(playerid, COLOR_GRAD2, "(/s)hout [ข้อความ]");

	new str[128];
	if (strlen(params) > 80) {
	    format(str, sizeof(str), "%s ตะโกน: %.80s", ReturnRealName(playerid), params);
	    ProxDetector(playerid, 30.0, str);

	    format(str, sizeof(str), "... %s!", params[80]);
	    ProxDetector(playerid, 30.0, str);
	}
	else format(str, sizeof(str), "%s ตะโกน: %s!", ReturnRealName(playerid), params), ProxDetector(playerid, 30.0, str);

	return 1;
}
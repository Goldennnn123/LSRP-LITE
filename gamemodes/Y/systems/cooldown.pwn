#include <YSI_Coding\y_hooks> // pawn-lang/YSI-Includes

#define MAX_COOLDOWNS 4



#define COOLDOWN_CLOTHES  	0
#define	COOLDOWN_FISHING	1
#define COOLDOWN_UNS		2


new cooldowns[MAX_PLAYERS][MAX_COOLDOWNS];
new cooldowns_expire[MAX_PLAYERS][MAX_COOLDOWNS];

stock SetCooldown(playerid,type,amount)
{

	cooldowns[playerid][type] = gettime();
	cooldowns_expire[playerid][type] = amount;

}

stock HasCooldown(playerid,type)
{
	new diff = (gettime() - cooldowns[playerid][type]);
	if(diff >= cooldowns_expire[playerid][type]) return false;
	return true;
}

ResetCooldowns(playerid) for(new i = 0; i != MAX_COOLDOWNS; ++i) cooldowns[playerid][i] = 0;

stock GetCooldownLevel(playerid,type)
{

	new diff = (cooldowns_expire[playerid][type] - (gettime() - cooldowns[playerid][type]));
	return diff;

}

hook OnPlayerConnect(playerid) {
	ResetCooldowns(playerid);
	return 1;
}
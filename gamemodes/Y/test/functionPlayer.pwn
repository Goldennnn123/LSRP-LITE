#include <YSI_Coding\y_hooks>

ptask CheckPlayer[500](playerid) 
{
    new weapons[13][2];
	for (new i = 0; i <= 12; i++)
	{	
			GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);


			if(!weapons[playerid][0])
				continue;

			if(PlayerInfo[playerid][pWeapons][i])
				continue;

			if(PlayerInfo[playerid][pWeaponsAmmo][i] == weapons[i][1])
				continue;

            if(weapons[i][1] > 500)
            {
                SendAdminMessageEx(COLOR_LIGHTRED, 1, "%s มีกระสุนเยอะเกินไป",ReturnName(playerid,0));
            }
	}
    return 1;
}


hook function SetPlayerHealth(playerid, Float:health)
{
	PlayerInfo[playerid][pHealth] = health;
	CharacterSave(playerid);
    return continue(playerid, health);
}

hook function GetPlayerMoney(playerid)
{
	return continue(playerid, PlayerInfo[playerid][pCash]);
}


stock GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][pCash] += amount;
	GivePlayerMoney(playerid, amount);
	CharacterSave(playerid);

	new str[120];
	
	new string[128]; 
	
	if(amount < 0) {
		format(string, sizeof(string), "~r~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
		format(str, sizeof(str),"%s มีเงินออกจากตัว %s", ReturnName(playerid,0),MoneyFormat(amount));
	}
	else{
		format(string, sizeof(string), "~g~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
		format(str, sizeof(str),"%s มีเงินเข้าตัว %s",ReturnName(playerid,0), MoneyFormat(amount));
	}

	SendAdminMessage(2, str);
	return 1;
}
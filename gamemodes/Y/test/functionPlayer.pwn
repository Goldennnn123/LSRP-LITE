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
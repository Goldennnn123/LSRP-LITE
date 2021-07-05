#include <YSI_Coding\y_hooks>

ptask CheckPlayer[1000](playerid) 
{
    new weapons[13][2];
	for (new i = 0; i <= 12; i++)
	{	
			GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
			
			if(PlayerInfo[playerid][pWeapons][i] == weapons[i][0])
				continue;

			if(weapons[i][0] == WEAPON_CAMERA)
				continue;

			if(PlayerInfo[playerid][pWeapons][i] == WEAPON_CAMERA && PlayerInfo[playerid][pWeapons][i] == WEAPON_FLOWER)
				continue;
			
			if(PlayerInfo[playerid][pWeaponsAmmo][i] == weapons[i][1])
				continue;


			if(weapons[i][0] == 44 || weapons[i][0] == 45 || weapons[i][0] == 38)
			{
				SendAdminMessageEx(COLOR_LIGHTRED, COLOR_LIGHTRED, "%s มีการเสกอาวุธ 44 หรือ 45 หรือ 38 Code 3",ReturnName(playerid,0));
				SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้มีการใช้โปรแกรมช่วยเล่นในการเสกอาวุธ");
				Kick(playerid);
			}

			if(PlayerInfo[playerid][pPoliceDuty])
				continue;

            if(weapons[i][1] > 400 || weapons[i][0] != WEAPON_CAMERA)
            {
                SendAdminMessageEx(COLOR_LIGHTRED, 1, "%s ผู้ต้องสงสัยในการเสกอาวุธ",ReturnName(playerid,0));
            }
	}
    return 1;
}


hook function SetPlayerHealth(playerid, Float:health)
{
	PlayerInfo[playerid][pHealth] = health;
    return continue(playerid, PlayerInfo[playerid][pHealth]);
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
		format(str, sizeof(str),"%s มีเงินออกจากตัว $%s", ReturnName(playerid,0),MoneyFormat(amount));
	}
	else{
		format(string, sizeof(string), "~g~$%d", amount);
		GameTextForPlayer(playerid, string, 2000, 1);
		format(str, sizeof(str),"%s มีเงินเข้าตัว $%s",ReturnName(playerid,0), MoneyFormat(amount));
	}

	SendAdminMessage(3, str);
	return 1;
}
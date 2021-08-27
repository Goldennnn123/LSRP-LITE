#include <YSI_Coding\y_hooks>

stock GiveMoney(playerid, amount)
{
	PlayerInfo[playerid][pCash] += amount;
	GivePlayerMoney(playerid, amount);
	CharacterSave(playerid);

	new str[120];
	
	new string[128]; 

	if(amount == 0)
		return 1;
	
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
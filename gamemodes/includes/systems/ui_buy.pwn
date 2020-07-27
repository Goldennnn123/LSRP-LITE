

Store:Shop(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "You don't have enough money.");

    if(itemid == 1)
    {
        PlayerInfo[playerid][pHasMask] = true;
    }
    if(itemid == 2)
    {
        GivePlayerWeapon(playerid, 43, 500);
    }
    if(itemid == 3)
    {
        GivePlayerWeapon(playerid, 14, 1);
    }
    
    new string[128];
    format(string, 128, "�س����� %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);
    
    GivePlayerMoney(playerid, -price);
    BusinessInfo[id][BusinessCash] += price;
    return true;
}
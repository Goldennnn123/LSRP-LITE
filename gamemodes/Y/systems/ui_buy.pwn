

Store:Shop(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "คุณมีเงินไม่เพียงพอ");

    if(itemid == 1)
    {
        PlayerInfo[playerid][pHasMask] = true;
    }
    if(itemid == 2)
    {
        PlayerInfo[playerid][pHasRadio] = true;
        PlayerInfo[playerid][pMainSlot] = 0;
        PlayerInfo[playerid][pRadio] = 0;
    }
    if(itemid == 3)
    {
        GivePlayerWeapon(playerid, 43, 500);
    }
    if(itemid == 4)
    {
        GivePlayerWeapon(playerid, 14, 1);
    }
    
    new string[128];
    format(string, 128, "คุณได้ซื้อ %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);
    
    GivePlayerMoney(playerid, -price);
    BusinessInfo[id][BusinessCash] += price;
    CharacterSave(playerid);
    return true;
}
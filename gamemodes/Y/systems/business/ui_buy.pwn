

Store:Shop(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "คุณมีเงินไม่เพียงพอ");

    if(itemid == 1)
    {
        if(BusinessInfo[id][BusinessS_Mask] < 1)
            return SendErrorMessage(playerid, "สินค้าหมด");
        
        PlayerInfo[playerid][pHasMask] = true;
        BusinessInfo[id][BusinessS_Mask]--;
    }
    if(itemid == 2)
    {
        PlayerInfo[playerid][pHasRadio] = true;
        PlayerInfo[playerid][pMainSlot] = 0;
        PlayerInfo[playerid][pRadio] = 0;
    }
    if(itemid == 3)
    {
        if(BusinessInfo[id][BusinessS_Cemara] < 1)
            return SendErrorMessage(playerid, "สินค้าหมด");

        GivePlayerWeapon(playerid, 43, 500);
        BusinessInfo[id][BusinessS_Cemara]--;
    }
    if(itemid == 4)
    {
        if(BusinessInfo[id][BusinessS_Flower] < 1)
            return SendErrorMessage(playerid, "สินค้าหมด");

        GivePlayerWeapon(playerid, 14, 1);
        BusinessInfo[id][BusinessS_Flower]--;
    }
    if(itemid == 5)
    {
        if(PlayerInfo[playerid][pCigare] >= 20)
            return SendErrorMessage(playerid, "คุณมีบุหรี่เต็มแล้ว");


        PlayerInfo[playerid][pCigare]+= 20;
    }

    if(itemid == 6)
    {
        if(PlayerInfo[playerid][pBoomBox])
            return SendErrorMessage(playerid, "คุณมี BoomBox อยู่แล้ว");

        PlayerInfo[playerid][pBoomBox] = true;
    }
    
    new string[128];
    format(string, 128, "คุณได้ซื้อ %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);
    
    GiveMoney(playerid, -price);
    new Float:result_price = price * 0.03;

    BusinessInfo[id][BusinessCash] += price - floatround(result_price, floatround_round);
    GlobalInfo[G_GovCash]+= floatround(result_price, floatround_round);
    SaveBusiness(id);
    CharacterSave(playerid);
    return true;
}
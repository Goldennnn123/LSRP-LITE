

Store:Shop(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "�س���Թ�����§��");

    if(itemid == 1)
    {
        if(BusinessInfo[id][BusinessS_Mask] < 1)
            return SendErrorMessage(playerid, "�Թ������");
        
        PlayerInfo[playerid][pHasMask] = true;
        BusinessInfo[id][BusinessS_Mask]--;
    }
    if(itemid == 2)
    {
        if(BusinessInfo[id][BusinessS_Cemara] < 1)
            return SendErrorMessage(playerid, "�Թ������");

        GivePlayerWeapon(playerid, 43, 500);
        BusinessInfo[id][BusinessS_Cemara]--;
    }
    if(itemid == 3)
    {
        if(BusinessInfo[id][BusinessS_Flower] < 1)
            return SendErrorMessage(playerid, "�Թ������");

        GivePlayerWeapon(playerid, 14, 1);
        BusinessInfo[id][BusinessS_Flower]--;
    }
    if(itemid == 4)
    {
        if(PlayerInfo[playerid][pCigare] >= 20)
            return SendErrorMessage(playerid, "�س�պ������������");


        PlayerInfo[playerid][pCigare]+= 20;
    }

    if(itemid == 5)
    {
        if(PlayerInfo[playerid][pBoomBox])
            return SendErrorMessage(playerid, "�س�� BoomBox ��������");

        PlayerInfo[playerid][pBoomBox] = true;
    }

    if(itemid == 6)
    {
        GivePlayerGun(playerid, 5, 1);
        
    }
    
    new string[128];
    format(string, 128, "�س����� %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);
    
    GiveMoney(playerid, -price);
    new Float:result_price = price * 0.07;

    BusinessInfo[id][BusinessCash] += price - floatround(result_price, floatround_round);
    GlobalInfo[G_GovCash]+= floatround(result_price, floatround_round);
    Saveglobal();
    SaveBusiness(id);
    CharacterSave(playerid);
    return true;
}
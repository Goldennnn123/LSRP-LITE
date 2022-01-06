

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
        if(BusinessInfo[id][BusinessS_Cemara] < 1)
            return SendErrorMessage(playerid, "สินค้าหมด");

        GivePlayerWeapon(playerid, 43, 500);
        BusinessInfo[id][BusinessS_Cemara]-=500;
    }
    if(itemid == 3)
    {
        if(BusinessInfo[id][BusinessS_Flower] < 1)
            return SendErrorMessage(playerid, "สินค้าหมด");

        GivePlayerValidWeapon(playerid, 14, 1);
        BusinessInfo[id][BusinessS_Flower]--;
    }
    if(itemid == 4)
    {
        if(PlayerInfo[playerid][pCigare] >= 20)
            return SendErrorMessage(playerid, "คุณมีบุหรี่เต็มแล้ว");


        PlayerInfo[playerid][pCigare]+= 20;
    }

    if(itemid == 5)
    {
        if(PlayerInfo[playerid][pBoomBox])
            return SendErrorMessage(playerid, "คุณมี BoomBox อยู่แล้ว");

        PlayerInfo[playerid][pBoomBox] = true;
    }

    if(itemid == 6)
    {
        GivePlayerValidWeapon(playerid, 5, 1);
        
    }

    if(itemid == 7)
    {
        PlayerInfo[playerid][pGasCan]+=1;
    }
    
    new string[128];
    format(string, 128, "คุณได้ซื้อ %dx %s", amount, itemname);
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

Store:Shop_Job(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;
    
    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "คุณมีเงินไม่เพียงพอ");

    if(itemid == 1)
    {   
        PlayerInfo[playerid][pRepairBox] += amount;
    }


    new string[128];
    format(string, 128, "คุณได้ซื้อ %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);

    GlobalInfo[G_GovCash]-= price;
    Saveglobal();
    CharacterSave(playerid);
    return 1;
}


Store:SHOP_POLICE(playerid, response, itemid, modelid, price, amount, itemname[])
{
    if(!response)
        return true;

    if(GetPlayerMoney(playerid) < price)
        return SendClientMessage(playerid, -1, "คุณมีเงินไม่เพียงพอ");

    if(itemid == 1)
    {   
        GivePlayerValidWeapon(playerid, 24, 100);
    }
    if(itemid == 2)
    {
        GivePlayerValidWeapon(playerid, 25, 50);
    }
    if(itemid == 3)
    {
        GivePlayerValidWeapon(playerid, 31, 250);
    }
    if(itemid == 4)
    {
        GivePlayerValidWeapon(playerid, 3, 1);
    }
    if(itemid == 5)
    {
        GivePlayerValidWeapon(playerid, 41, 100);
    }
    if(itemid == 6)
    {
        GivePlayerArmour(playerid, 100);
    }
     if(itemid == 7)
    {
        if(PlayerInfo[playerid][pHasRadio])
		    return SendErrorMessage(playerid, "คุณมีวิทยุแล้ว");

         PlayerInfo[playerid][pHasRadio] = true;
    }

    
    new string[128];
    format(string, 128, "คุณได้ซื้อ %dx %s", amount, itemname);
    SendClientMessage(playerid, -1, string);

    GlobalInfo[G_GovCash]-= price;
    Saveglobal();
    CharacterSave(playerid);
    return true;
}
CMD:bizcmd(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________________BUSINESS COMMAND__________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"[BUSINESS] /buybiz /sellbiz /lock /biz");
    SendClientMessage(playerid, COLOR_GREEN,"________________________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
    return 1;
}

CMD:buybiz(playerid,params[])
{
    new b_id = IsPlayerNearBusiness(playerid);
    new MyCash = GetPlayerMoney(playerid);
    new Level = PlayerInfo[playerid][pLevel];
    
    if(b_id != 0)
    {
        if(CountPlayerBusiness(playerid))
        {
            SendErrorMessage(playerid, "คุณเป็นเจ้าของกิจการอื่นอยู่");
            return 1;
        }

        else if(BusinessInfo[b_id][BusinessOwnerDBID])
            return SendErrorMessage(playerid, "กิจการนี้มีเจ้าของอยู่แล้ว");

        else if(MyCash < BusinessInfo[b_id][BusinessPrice])
            return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");
        
        else if(Level < BusinessInfo[b_id][Businesslevel])
            return SendErrorMessage(playerid, "คุณมีเลเวลไม่เพียงพอ");

        BusinessInfo[b_id][BusinessOwnerDBID] = PlayerInfo[playerid][pDBID];
        
        if(BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_BANK)
        {
            if(IsValidDynamicPickup(BusinessInfo[b_id][BusinessEntrancePickUp]))
                DestroyDynamicPickup(BusinessInfo[b_id][BusinessEntrancePickUp]);

            BusinessInfo[b_id][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2],-1,-1);
        }
        SendClientMessageEx(playerid, -1, "{33FF66}BUSINESS {F57C00}SYSTEM:{F57C00} ยินดีด้วย!! คุณได้ซื้อกิจการในราคา $%s", MoneyFormat(BusinessInfo[b_id][BusinessPrice]));
        Dialog_Show(playerid, DIALOG_MSG_BUSINESS, DIALOG_STYLE_MSGBOX, "{388E3C}Succes Buy Business", "{F4511E}ยินดีด้วยคุณได้เปิดกิจการใหม่ของคุณ ซึ่งการที่คุณได้เปิดกิจการใหม่นั้นจำเป็นอย่างมากที่จะต้องใช้ประสบการณ์ในการบริหารจัดการกิจการของคุณ\n\
                                                                                                        ซึ่งคุณจะได้รับประสบการณ์ต่างๆมากมายจากการเปิดกิจการนี้ แต่อย่างอื่นอย่างใด คุณควรอัพเดทบทบาทของคุณที่มีต่อ กิจการของคุณ ลงในฟอรั่ม\n\
                                                                                                        เพื่อที่จะได้ แสดงให้ผู้คนที่สนใจเข้าไปอ่านนั้น รู้จักและสนใจในกิจการของคุณ ซึ่งขอให้กิจการของคุณเติบโตไปได้ด้วยดี\n\
                                                                                                        หากมีคำข้อสงในกิจการของคุณ ลองพิมพ์ {FF0000}/bizcmd {F4511E}เพื่อดูคำสั่งต่างๆในกิจการของคุณ", "รับทราบ","");                              
        GivePlayerMoney(playerid, -BusinessInfo[b_id][BusinessPrice]);
        CharacterSave(playerid);
        SaveBusiness(b_id);
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้บริเวณกิจการที่ต้องการ ซื้อ");
    return 1;
}

CMD:sellbiz(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    new str[MAX_STRING];
    
    if(id != 0)
    {
        if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการ");

        format(str, sizeof(str), "{FFFFFF}คุณแน่ในหรือป่าวที่จะ ขายกิจการของคุณ การขายกิจการนี้คุณจะได้รับเงินจำนวน {2ECC71}$%s{FFFFFF} เงินจำนวนนี้คือเงินครึ่งนึงของราคาเต็มในกิจการหากคุณขายกิจการแล้ว\n\
                                  คุณจะไม่สามารถจัดการกิจการของคุณได้อีกเลย ขอให้คุณคิดให้ดีก่อนจะตอบ 'ยืนยัน'",MoneyFormat(BusinessInfo[id][BusinessPrice] / 2));
        Dialog_Show(playerid, DIALOG_SELL_BU, DIALOG_STYLE_MSGBOX, "คุณมั่นใจ?", str, "ยินยัน", "ยกเลิก");
        return 1;
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยู่ในกิจการ");
    return 1;
}

CMD:biz(playerid,params[])
{   
    ShowPlayerBusiness(playerid);
    return 1;
}

CMD:eat(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_RESTAURANT)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ร้านขายอาหาร");

    ShowPlayerBuyFood(playerid);
    return 1;
}

CMD:buy(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ที่ร้านสดวกซื้อ");

    MenuStore_AddItem(playerid, 1, 18919, "Mask", 5000, "Mask use /mask", 200);
    MenuStore_AddItem(playerid, 2, 367, "Camera", 15000, "Cemara To Take Photo", 200);
    MenuStore_AddItem(playerid, 3, 325, "Flower", 300, "Flower", 200);
    MenuStore_Show(playerid, Shop, "SHOP");
    return 1;
}



#include <YSI_Coding\y_hooks>


new PlayerSkinCloseID[MAX_PLAYERS];

new buy_weapon[2];

hook OnGameModeInit()
{
    buy_weapon[0] = CreateDynamicPickup(1239, 2, 1410.8884,-10.3149,1000.9465, -1, -1, -1, 300);
    return 1;
}

hook OP_Connect(playerid)
{
    PlayerSkinCloseID[playerid] = 0;
    return 1;
}

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
        if(CountPlayerBusiness(playerid) > 10)
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
        
        for(new i = 1; i < MAX_FUELS; i++)
        {
            if(!FuelInfo[i][F_ID])
                continue;

            if(FuelInfo[i][F_Business] == BusinessInfo[b_id][BusinessDBID])
            {
                FuelInfo[i][F_OwnerDBID] = PlayerInfo[playerid][pDBID];
                SaveFuel(i);
            }
        }
        
        GiveMoney(playerid, -BusinessInfo[b_id][BusinessPrice]);
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
    new id = IsPlayerInBusiness(playerid);

    if(!IsPlayerInBusiness(playerid))
        return SendErrorMessage(playerid, "คุณไมได้อยู่ในกิจการ");

    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
        return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการ");

    ShowPlayerBusiness(playerid, id);
    return 1;
}

CMD:eat(playerid, params[])
{
    if(MealOder[playerid] == true)
		return SendErrorMessage(playerid, "คุณยังมีถาดอาหารอยู่");

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_RESTAURANT)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ร้านขายอาหาร");

    callcmd::meal(playerid, "");
    PlayerInfo[playerid][pGUI] = 5;
    ShowPlayerBuyFood(playerid);
    return 1;
}

alias:createdrinkmenu("makedrink", "createdrink")
CMD:createdrinkmenu(playerid, params[])
{
    new id = IsPlayerInBusiness(playerid);

    if(!IsPlayerInBusiness(playerid))
        return SendErrorMessage(playerid, "คุณไมได้อยู่ในกิจการ");

    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
        return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการ");


    new name[60], price, model, drunk, idx = 0;

    for(new m = 1; m < MAX_DRINKMENU; m++)
    {
        if(!DrinkMenuInfo[m][drink_id])
            continue;

        idx = m;
    }


    if(!idx)
        return SendErrorMessage(playerid, "คุณสามารถสร้างเมนูได้มากสุด 10 เมนู");

    if(sscanf(params, "s[60]ddd", name, price, model, drunk))
        return SendUsageMessage(playerid, "/createdrinkmenu <ชื่อเมนู> <ราคา> <โมเดล> <ความเมา>");


    if(strlen(name) > 15)
        return SendErrorMessage(playerid, "คุณไม่ควรสร้างชื่อเมนนูเกิน 15 ตัวอักษร");

    if(price < 50 || price > 10000)
        return SendErrorMessage(playerid, "คุณตั้งราคาไม่ถูกต้อง (50 - 10000)");

    
    return 1;
}

CMD:buy(playerid, params[])
{

    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1410.8884,-10.3149,1000.9465)) /// SHOP POLICE HARBOR STATION
    {
        if(ReturnFactionJob(playerid) != POLICE)
            return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าหน้าที่ตำรวจ");

        if(!PlayerInfo[playerid][pDuty])
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในการทำหน้าที่ตำรวจ");
        
        PlayerInfo[playerid][pGUI] = 6;
        SendClientMessage(playerid, -1, "พิพม์ /close เพื่อปิดหน้าต่างการซื้อ หรือกด esc");
        MenuStore_AddItem(playerid, 1, 348, "Desert Eagle", 500, "Desert Eagle - 100 Ammo", 200);
        MenuStore_AddItem(playerid, 2, 349, "Shotgun", 550, "Shotgun - 50 Ammo", 200);
        MenuStore_AddItem(playerid, 3, 356, "M4", 1000, "M4 - 250 Ammo", 200);
        MenuStore_AddItem(playerid, 4, 334, "Nightstick", 100, "Nightstick", 200);
        MenuStore_AddItem(playerid, 5, 365, "Spraycan", 100, "Spraycan - 100 Ammo", 200);
        MenuStore_AddItem(playerid, 6, 1242, "Armour", 50, "Armour - 1", 200);
        MenuStore_AddItem(playerid, 7, 19942, "Radio", 100, "Radio - 1", 200);
        MenuStore_Show(playerid, SHOP_POLICE, "SHOP POLICE");
        return 1;
    }
    else
    {
        new id = PlayerInfo[playerid][pInsideBusiness];
    
        if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_STORE)
        {
            PlayerInfo[playerid][pGUI] = 6;
            SendClientMessage(playerid, -1, "พิพม์ /close เพื่อปิดหน้าต่างการซื้อ หรือกด esc");
            MenuStore_AddItem(playerid, 1, 18919, "OOC Mask", 100, "OOC Mask use /mask", 200);
            MenuStore_AddItem(playerid, 2, 367, "Camera", 50, "Cemara To Take Photo", 200);
            MenuStore_AddItem(playerid, 3, 325, "Flower", 10, "Flower", 200);
            MenuStore_AddItem(playerid, 4, 19897, "Cigarette", 25, "Flower", 200);
            MenuStore_AddItem(playerid, 5, 2226, "BoomBox", 500, "BoomBox use music staion", 200);
            MenuStore_AddItem(playerid, 6, 336, "Baseball Bat", 250, "Baseball Bat", 200);
            MenuStore_AddItem(playerid, 7, 1650, "GasCan", 2000, "GasCan use /refill", 200);
            MenuStore_Show(playerid, Shop, "SHOP");
            return 1;
        }
        else if(BusinessInfo[id][BusinessType] == BUSINESS_TYPE_JOB)
        {
            PlayerInfo[playerid][pGUI] = 6;
            SendClientMessage(playerid, -1, "พิพม์ /close เพื่อปิดหน้าต่างการซื้อ หรือกด esc");
            MenuStore_AddItem(playerid, 1, 19921, "Repair Box", 75, "Use In Repair Vehicle", 200);
            MenuStore_Show(playerid, Shop_Job, "SHOP");
            return 1;
        }
        else SendErrorMessage(playerid, "คุณไม่ได้อยู่ในร้าน");
        return 1;
    }
}

CMD:bank(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid),
		amount
	;
		
	if(!id)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคาร");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคาร"); 
		
	if(sscanf(params, "d", amount))
		return SendUsageMessage(playerid, "/bank [จำนวนงินที่จะฝาก]");
		
	if(amount < 1 || amount > PlayerInfo[playerid][pCash])
		return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ"); 

    if(PlayerInfo[playerid][pSaving])
        return SendErrorMessage(playerid, "คุณไม่สามารถถอนหรือฝากเงินเข้าไปเพิ่มได้จนกว่าคุณจะยกเลิกสัญญา");
		
	PlayerInfo[playerid][pBank]+= amount;
	GiveMoney(playerid, -amount); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "คุณได้ฝากเงินจำนวน $%s เข้าในบัญชีธนาคารของคุณ จากเดิม:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
	CharacterSave(playerid);
	return 1; 
}
new PlayerSavingAdd[MAX_PLAYERS];

CMD:saving(playerid, params[])
{
    if(PlayerInfo[playerid][pSaving])
        return SendErrorMessage(playerid, "คุณได้ทำการเริ่มฝากออมทรัพย์อยู่แล้ว");
    
    new
		id = IsPlayerInBusiness(playerid),
        money
	;
		
	if(!id)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคาร");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคาร");

    if(PlayerInfo[playerid][pBank])
        return SendErrorMessage(playerid, "ถอนเงินทั้งหมดของคุณออกทั้งหมดก่อนที่จะฝากเข้าไปใหม่");

    if(PlayerInfo[playerid][pCash] < 2000)
        return SendErrorMessage(playerid, "เงินที่จะต้องเริ่มต้นในการฝากเงินเข้า ไม่ต่ำกว่า $2,000 และห้ามเกิน $1,000,00");

    if(sscanf(params, "d", money))
        return SendUsageMessage(playerid, "/saving  <จำนวนเงิน>");
    
    if(money < 2000 || money >= 1000000)
        return SendErrorMessage(playerid, "คุณจะต้องฝากเงินขั้นต่ำ $2,000 และไม่เกิน $1,000,000");

    PlayerSavingAdd[playerid] = money;

    new str[1000];
    format(str, sizeof(str), "ข้อตกลงในการทำบัญชีออมทรัพย์ของคุณนั้น เป็นข้อตกลงระหว่างคุณกับธนาคาร โดย\n\
    \tเรียน %s\n\
    \t\tข้อตกลงในการทำบัญชีออมทรัพย์ของคุณนั้น เป็นข้อตกลงระหว่างคุณกับธนาคาร โดยมีข้อกำหนดต่างๆ ที่คุณจำเป็น\nจะต้องปฎิบัติตามและยอมรับมันดังข้อกำหนด\n\
    ข้อที่ 1: คุณจะได้รับดอกเบี้ยมากขึ้นจากเดิมที่คุณเคยได้นั่นก็คือ 0.9\n\
    ข้อที่ 2: คุณจะไม่สามารถถอนเงินได้จนกว่าเงินของคุณจะครบกำหนด $20,000,000\n\
    ข้อที่ 3: หากคุณทำการถอนก่อนกำหนดจะถูกทางธนาคารปรับเงินคุณ หาร 2 ของเงินทั้งหมดที่คุณมี\n\
    หากคุณอ่านข้อกำหนดของเราและได้ยอมรับโปรดใส่จำนวนเงินที่จะต้องเริ่มต้นในการฝากเงินเข้า ไม่ต่ำกว่า $2,000 และห้ามเกิน $1,000,000",ReturnName(playerid, 0));
    Dialog_Show(playerid, DIALOG_CONFIRM_SAVEING, DIALOG_STYLE_MSGBOX, "ข้อตกลงในการฝากเงินออมทรัพย์", str, "ยืนยันทำรายการ", "ยกเลิกการทำรายการ");
    return 1;
}

Dialog:DIALOG_CONFIRM_SAVEING(playerid, response, listitem, inputtext[])
{  
    if(!response)
        return SendClientMessage(playerid, -1, "คุณได้ปฎิเสธสัญญาข้อตกลงกับธนาคาร");

    new money = PlayerSavingAdd[playerid];

    GiveMoney(playerid, -money);
    PlayerInfo[playerid][pSaving] = true;
    PlayerInfo[playerid][pBank] += money;
    CharacterSave(playerid);

    SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้เริ่มฝากเงินแบบบัญชีออมทรัพย์แล้วจำนวนเงินเริ่มต้น $%s",MoneyFormat(money));
    PlayerSavingAdd[playerid] = 0;
    return 1;
}

CMD:withdraw(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness], amount;


    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE && BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคารหรือร้านสดวกซื้อ");

    if(sscanf(params, "i", amount))
		return SendUsageMessage(playerid, "/withdraw [จำนวนเงิน]");

    if(amount < 1 || amount > PlayerInfo[playerid][pBank])
		return SendErrorMessage(playerid, "คุณมีเงินในบัญชีธนาคารไม่เพียงพอ"); 

    if(PlayerInfo[playerid][pSaving] && PlayerInfo[playerid][pBank] < MONEY_MAX_SAVING)
    {
        PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank] / 2;
        PlayerInfo[playerid][pSaving] = false;
        SendClientMessage(playerid, -1, "[BANK] คุณได้ทำยื่นเรื่องถอนเงินออกจากธนาคารในระหว่างที่ฝากออมทรัพย์อยู่ทำให้สัญญาของคุณกับธนาคารขาด");
        SendClientMessage(playerid, -1, "....และตามข้อตกลงนั้นคุณได้ทำสัญญาไว้กับทางธนาคาร ธนาคารจึงจำเป็นต้องปรับเงินครึ่งนึงในบัญชีของคุณตามข้อกำหนด");

        if(PlayerInfo[playerid][pBank] < amount)
            return SendErrorMessage(playerid, "คุณมีเงินในบัญชีธนาคารไม่เพียงพอ เงินคุณเหลือ $%s", MoneyFormat(PlayerInfo[playerid][pBank]));
 
        PlayerInfo[playerid][pSaving] = false;
        PlayerInfo[playerid][pBank]-= amount;
        GiveMoney(playerid, amount);
        SendClientMessageEx(playerid, COLOR_ACTION, "คุณได้ถอนเงินจำนวน $%s จากบัญชีธนาคารของคุณ คงเหลือ:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
        CharacterSave(playerid);
        return 1;
    }

    PlayerInfo[playerid][pBank]-= amount;
	GiveMoney(playerid, amount);
    SendClientMessageEx(playerid, COLOR_ACTION, "คุณได้ถอนเงินจำนวน $%s จากบัญชีธนาคารของคุณ คงเหลือ:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
	CharacterSave(playerid);
    return 1;
}

alias:balance("bal")
CMD:balance(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid)
	;
		
	if(!id)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคารหรือร้านสดวกซื้อ");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE && BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในธนาคารหรือร้านสดวกซื้อ"); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "คุณมีเงินอยู่ในบัญชีธนาคาร $%s และมีค่าจ้างรายชั่วโมง $%s  อัพเดทเมื่อวันที่: %s", MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]), ReturnDate());	
	return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    new
		id = IsPlayerInBusiness(playerid)
	;

    if(pickupid == BusinessInfo[id][BusinessBankPickup])
    {
        if(PlayerInfo[playerid][pPaycheck] == 0)
            return 1;
        
        GiveMoney(playerid, PlayerInfo[playerid][pPaycheck]);
        SendClientMessageEx(playerid, COLOR_GREY, "คุณได้รับเงินรายชัวโมงของคุณแล้ว จำนวน $%s", MoneyFormat(PlayerInfo[playerid][pPaycheck]));
        PlayerInfo[playerid][pPaycheck] = 0;
        return 1;
    }
    return 1;
}

CMD:buygun(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_AMMUNITION)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ที่ร้านปืน");

    if(!PlayerInfo[playerid][pWeaponLicense])
        return SendErrorMessage(playerid, "คุณไม่มีใบอนุญาตสําหรับการซื้อปืน");

    if(PlayerInfo[playerid][pWeaponLicenseSus])
        return SendErrorMessage(playerid, "ใบพกอาวุธของคุณถูกยึดอยู่");

    if(PlayerInfo[playerid][pWeaponLicenseRevoke])
        return SendErrorMessage(playerid, "ใบพกอาวุธของคุณถูกยึดอยู่");
    

    new str[255],longstr[255];

    format(str, sizeof(str), "ชื่อ:\tราคา:\n");
    strcat(longstr, str);

    format(str, sizeof(str), "Desert eagle\t$35,000\n");
    strcat(longstr, str);
    format(str, sizeof(str), "Shotgun\t$55,000\n");
    strcat(longstr, str);
    format(str, sizeof(str), "Country rifle\t$45,000\n");
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_WEAPON_BUY, DIALOG_STYLE_TABLIST_HEADERS, "WEAPON SHOP:", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

CMD:buyammo(playerid, params[])
{
    
    return 1;
}

CMD:skin(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_SKIN)
        return SendErrorMessage(playerid, "คุณไม่อยุ่ในร้านขายเสื้อผ้า");

    ShowSkinModelMenu(playerid);
    return 1;
}

alias:changeclothing("cct")
CMD:changeclothing(playerid, params[])
{
    if(PlayerInfo[playerid][pGUI])
        return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งขณะมีการทำงานของระบบ Textdraw");

    new str[255], longstr[255];
    format(str, sizeof(str), "ชุดที่ 1: %d\n",PlayerInfo[playerid][pSkinClothing][0]);
    strcat(longstr, str);

    format(str, sizeof(str), "ชุดที่ 2: %d\n",PlayerInfo[playerid][pSkinClothing][1]);
    strcat(longstr, str);

    format(str, sizeof(str), "ชุดที่ 3: %d\n",PlayerInfo[playerid][pSkinClothing][2]);
    strcat(longstr, str);

    Dialog_Show(playerid, DIALOG_SKINCLOST_CHANG, DIALOG_STYLE_LIST, "Clothing Skin:", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

alias:advertisements("ads")
CMD:advertisements(playerid, params[])
{
    if(isnull(params)) 
        return SendUsageMessage(playerid, "/advertisements [ข้อความ]");

    if(PlayerInfo[playerid][pCash] < 200)
        return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ (จำเป็นต้องมี $200)");

    
    if(strlen(params) > 100)
    {
		SendClientMessageToAllEx(COLOR_LIGHTGREEN, "[Advertisements] %.89s", params);
        SendClientMessageToAllEx(COLOR_LIGHTGREEN, "... %s",params[100]);
    }
    else 
    {
        SendClientMessageToAllEx(COLOR_LIGHTGREEN, "[Advertisements] %s",params);
    }

    GiveMoney(playerid, -200);

    return 1;
}


alias:givebusinesskey("givebizkey")
CMD:givebusinesskey(playerid, params[])
{
    if(!IsPlayerInBusiness(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในกิจการของคุณ");

    new id = PlayerInfo[playerid][pInsideBusiness];

    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของกิจการ");

    new tagetid;
    if(sscanf(params, "u", tagetid))
        return SendUsageMessage(playerid, "/givebusinesskey <ชื่อบางส่วน/ไอดี> ");


    if(!IsPlayerNearPlayer(playerid, tagetid, 4.0))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ %s", ReturnRealName(playerid));


    PlayerInfo[tagetid][pBusinessKey] = id;

    GiveMoney(playerid, -1000);
    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ให้กุญแจสำรองของกิจการของคุณกับ %s เรียบร้อยแล้ว คุณเสียเงินค่ากุญแจสำรองกิจการไป $1,000", ReturnRealName(tagetid));
    SendClientMessageEx(tagetid, COLOR_LIGHTGREEN, "คุณได้รับกุจแจกิจการจาก %s หมายเลขกิจการ %d", ReturnRealName(playerid), id); 
    return 1;
}


CMD:createmenu(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_CLUB)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ที่ร้าน บาร์ ของคุณ");
    
    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ได้เป็นเจ้าของกิจการนี้");

    new idx = 0;
    for(new i = 1; i < 11; i++)
    {
        if(!BusinessInfo[id][BizDrink][i])
        {
            idx = i;
            break;
        }
    }
    if(!idx)
        return SendErrorMessage(playerid, "คุณได้สร้าง Menu เต็มแล้ว");

    new menuname[60], price, model, drunk;

    if(sscanf(params, "s[60]ddd", menuname, price, model, drunk))
    {
        SendUsageMessage(playerid, "/createmenu <ชื่อเมนู> <ราคา> <โมเดล> <drunk>");
        SendClientMessage(playerid, COLOR_WHITE, "");
        return 1;
    }
    
    if(strlen(menuname) < 5 || strlen(menuname) > 60)
        return SendErrorMessage(playerid, "กรอกชื่อให้ถูกต้อง");

    if(price < 1 || price > 5000)
        return SendErrorMessage(playerid, "กรอกราคาไม่ถูกต้อง");
    
    if(model != 1484)
        return SendErrorMessage(playerid, "ใส่ ไอดีให้ถูกต้อง");

    if(drunk < 4000 || drunk > 10000)
        return SendErrorMessage(playerid, "คุณตั้งค่าความเมาน้อยกว่า 4,000 หรือมากกว่า 10,000");

    
    CreateMenuBar(playerid, idx, menuname, price, model, drunk);
    return 1;
}

stock CreateMenuBar(playerid, newid, menuname[], price, model, drunk)
{
    new idx = 0;
    new id = PlayerInfo[playerid][pInsideBusiness];


    for(new i = 1; i < MAX_DRINKMENU; i++)
    {
        if(!DrinkMenuInfo[i][drink_id])
        {
            idx = i;
            break;
        }
    }
    if(!idx)
        return SendErrorMessage(playerid, "ไอดีถึงจุดสิ้นสุดแล้ว");

    DrinkMenuInfo[idx][drink_id] = idx;
    DrinkMenuInfo[idx][drink_bizid] = id;
    format(DrinkMenuInfo[idx][drink_name], 60, "%s",menuname);
    DrinkMenuInfo[idx][drink_price] = price;
    DrinkMenuInfo[idx][drink_model] = model;
    DrinkMenuInfo[idx][drink_drunk] = drunk;

    BusinessInfo[id][BizDrink][newid] = idx;

    SaveBusiness(id);

    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้สร้าง เมนู (%d)%s เรียบร้อยแล้ว พิมพ์ /buydrink - เพื่อดูเมนู", BusinessInfo[id][BizDrink][newid], DrinkMenuInfo[idx][drink_name]);
    return 1;
}

CMD:buydrink(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_CLUB)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ที่ร้าน บาร์ ของคุณ");
    
    if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "คุณไม่ได้เป็นเจ้าของกิจการนี้");
    
    
    new str[120], longstr[120];

    for(new i = 1; i < 11; i++)
    {
        if(!BusinessInfo[id][BizDrink][i])
            continue;
        
        format(str, sizeof(str), "%s - $%s\n", DrinkMenuInfo[BusinessInfo[id][BizDrink][i]][drink_name], MoneyFormat(DrinkMenuInfo[BusinessInfo[id][BizDrink][i]][drink_price]));
        strcat(longstr, str);
    }

    

    Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_LIST, "MENU:", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}




Dialog:DIALOG_SKINCLOST_CHANG(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;


    switch(listitem)
    {
        case 0:
        {  
            PlayerSkinCloseID[playerid] = 0;
            Dialog_Show(playerid, DIALOG_SKINCLOST_CH_SLOT, DIALOG_STYLE_LIST, "Clothing Skin:", "[ ! ] ล้าง\n[ ! ] เปลี่ยน", "ยืนยัน", "ยกเลิก");

        }
        case 1:
        {  
            PlayerSkinCloseID[playerid] = 1;
            Dialog_Show(playerid, DIALOG_SKINCLOST_CH_SLOT, DIALOG_STYLE_LIST, "Clothing Skin:", "[ ! ] ล้าง\n[ ! ] เปลี่ยน", "ยืนยัน", "ยกเลิก");

        }
        case 2:
        {  
            PlayerSkinCloseID[playerid] = 2;
            Dialog_Show(playerid, DIALOG_SKINCLOST_CH_SLOT, DIALOG_STYLE_LIST, "Clothing Skin:", "[ ! ] ล้าง\n[ ! ] เปลี่ยน", "ยืนยัน", "ยกเลิก");

        }
    }
    return 1;
}

Dialog:DIALOG_SKINCLOST_CH_SLOT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;


    new slotid = PlayerSkinCloseID[playerid];
    new skinid = PlayerInfo[playerid][pSkinClothing][slotid];
    switch(listitem)
    {
        case 0:
        {
            if(PlayerInfo[playerid][pSkinClothing][slotid] == 0)
                return SendErrorMessage(playerid, "Sloid นี้ว่างอยู่แล้ว");

            PlayerInfo[playerid][pSkinClothing][slotid] = 0;
            SendClientMessageEx(playerid, -1, "คุณได้ทำการล้างช่อง SkinClothing ช่องที %d เรียบร้อยแล้ว", slotid+1);
        }
        case 1:
        {
            if(PlayerInfo[playerid][pSkinClothing][slotid] == 0)
                return SendErrorMessage(playerid, "ไม่สามารถเปลี่ยน Skin ให้คุณได้เนื่องจากช่องนี้เป็นช่องที่ว่าง");
            
            new str[255];
            format(str, sizeof(str), "กำกลังเปลี่ยนเสื้อผ้าของเขา");

            SetTimerEx("ChangSkinClosthing", 5000, false, "dd",playerid, skinid);
            TogglePlayerControllable(playerid, 0);
            callcmd::me(playerid,  str);
        }
    }
    return 1;
}

forward ChangSkinClosthing(playerid, skinid);
public ChangSkinClosthing(playerid, skinid)
{
    new str[255];
    format(str, sizeof(str), "สำเร็จ");

    PlayerInfo[playerid][pLastSkin] = skinid; SetPlayerSkin(playerid, skinid);
    callcmd::do(playerid,  str);
    TogglePlayerControllable(playerid, 1);
    return 1;
}


Dialog:DIALOG_SKINCLOST_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    
    switch(listitem)
    {
        case 0:
        {
            ShowDialogClostingSkin(playerid, 0);
            PlayerSkinCloseID[playerid] = 0;
            return 1;
        }
        case 1:
        {
            ShowDialogClostingSkin(playerid, 1);
            PlayerSkinCloseID[playerid] = 1;
        }
        case 2:
        {
            ShowDialogClostingSkin(playerid, 2);
            PlayerSkinCloseID[playerid] = 2;
        }
    }
    return 1;
}

stock ShowDialogClostingSkin(playerid, id)
{
    SendClientMessageEx(playerid, COLOR_HELPME, "คุณได้เลือก SkinClothing Slot ที่ %d", id+1);
    Dialog_Show(playerid, DIALOG_BUYSKIN_INPUT, DIALOG_STYLE_INPUT, "ซื้อ Skin", "ในการเปลี่ยน Skin จำเป็นต้องคำนึงถึงบทบาทของตัวละครเป็นหลักหากชื่อเป็นผู้ชายแต่\nเปลี่ยนเป็น Skin ผู้หญิงแล้วทางผู้ดูแลพบเจอจะทำการแตะออกจากเซิร์ฟเวอร์\nหากถูกแต่ออกในกรณีเดียวกันครบ 3 ครั้งจะทำการลบตัวละครตัวนั้นทันที","ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_BUYSKIN_INPUT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    if(PlayerInfo[playerid][pCash] < 1000)
        return SendErrorMessage(playerid, "คุณมีเงินน้อยกว่า $1,000");
    
    new skinid = strval(inputtext);
    new id = PlayerInfo[playerid][pInsideBusiness];
    new slotid = PlayerSkinCloseID[playerid];


    PlayerInfo[playerid][pLastSkin] = skinid; SetPlayerSkin(playerid, skinid);
    PlayerInfo[playerid][pSkinClothing][slotid] = skinid;

    SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ทำการเปลี่ยน Skin ของคุณเป็น ID: %d",skinid);
    SaveBusiness(id);
    CharacterSave(playerid);
    return 1;
}

Dialog:DIALOG_WEAPON_BUY(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0:
        {
            if(PlayerInfo[playerid][pCash] < 35000)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

        
            new idx = ReturnWeaponIDSlot(24); 
            
            GivePlayerWeapon(playerid, 24, 200); 
            
            PlayerInfo[playerid][pWeapons][idx] = 24;
            PlayerInfo[playerid][pWeaponsAmmo][idx] = 200; 
            GiveMoney(playerid, -35000);
            return 1;
        }
        case 1:
        {
            if(PlayerInfo[playerid][pCash] < 55000)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

        
            new idx = ReturnWeaponIDSlot(25); 
            
            GivePlayerWeapon(playerid, 25, 200); 
            
            PlayerInfo[playerid][pWeapons][idx] = 25;
            PlayerInfo[playerid][pWeaponsAmmo][idx] = 200; 
            GiveMoney(playerid, -55000);
            return 1;
        }
        case 2:
        {
            if(PlayerInfo[playerid][pCash] < 45000)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

        
            new idx = ReturnWeaponIDSlot(33); 
            
            GivePlayerWeapon(playerid, 33, 200); 
            
            PlayerInfo[playerid][pWeapons][idx] = 33;
            PlayerInfo[playerid][pWeaponsAmmo][idx] = 200; 
            GiveMoney(playerid, -45000);
            return 1;
        }
    }
    return 1;
}

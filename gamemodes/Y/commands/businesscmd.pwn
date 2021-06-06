CMD:bizcmd(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________________BUSINESS COMMAND__________________________");

    SendClientMessage(playerid, COLOR_GRAD2,"[BUSINESS] /buybiz /sellbiz /lock /biz");
    SendClientMessage(playerid, COLOR_GREEN,"________________________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"�ô�֡�Ҥ���������������������㹿��������� /helpme ���ͤ͢������������");
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
            SendErrorMessage(playerid, "�س����Ңͧ�Ԩ����������");
            return 1;
        }

        else if(BusinessInfo[b_id][BusinessOwnerDBID])
            return SendErrorMessage(playerid, "�Ԩ��ù������Ңͧ��������");

        else if(MyCash < BusinessInfo[b_id][BusinessPrice])
            return SendErrorMessage(playerid, "�س���Թ�����§��");
        
        else if(Level < BusinessInfo[b_id][Businesslevel])
            return SendErrorMessage(playerid, "�س������������§��");

        BusinessInfo[b_id][BusinessOwnerDBID] = PlayerInfo[playerid][pDBID];
        
        if(BusinessInfo[b_id][BusinessType] == BUSINESS_TYPE_BANK)
        {
            if(IsValidDynamicPickup(BusinessInfo[b_id][BusinessEntrancePickUp]))
                DestroyDynamicPickup(BusinessInfo[b_id][BusinessEntrancePickUp]);

            BusinessInfo[b_id][BusinessEntrancePickUp] = CreateDynamicPickup(1239, 23, BusinessInfo[b_id][BusinessEntrance][0], BusinessInfo[b_id][BusinessEntrance][1], BusinessInfo[b_id][BusinessEntrance][2],-1,-1);
        }
        SendClientMessageEx(playerid, -1, "{33FF66}BUSINESS {F57C00}SYSTEM:{F57C00} �Թ�մ���!! �س����͡Ԩ�����Ҥ� $%s", MoneyFormat(BusinessInfo[b_id][BusinessPrice]));
        Dialog_Show(playerid, DIALOG_MSG_BUSINESS, DIALOG_STYLE_MSGBOX, "{388E3C}Succes Buy Business", "{F4511E}�Թ�մ��¤س���Դ�Ԩ�������ͧ�س ��觡�÷��س���Դ�Ԩ��������鹨������ҧ�ҡ���е�ͧ����ʺ��ó�㹡�ú����èѴ��áԨ��âͧ�س\n\
                                                                                                        ��觤س�����Ѻ���ʺ��ó��ҧ��ҡ��¨ҡ����Դ�Ԩ��ù�� �����ҧ������ҧ� �س����Ѿഷ���ҷ�ͧ�س����յ�� �Ԩ��âͧ�س ŧ㹿�����\n\
                                                                                                        ���ͷ����� �ʴ�����餹���ʹ�������ҹ��� ���ѡ���ʹ�㹡Ԩ��âͧ�س ��觢����Ԩ��âͧ�س�Ժ������´�\n\
                                                                                                        �ҡ�դӢ��ʧ㹡Ԩ��âͧ�س �ͧ����� {FF0000}/bizcmd {F4511E}���ʹ٤���觵�ҧ�㹡Ԩ��âͧ�س", "�Ѻ��Һ","");                              
        GivePlayerMoney(playerid, -BusinessInfo[b_id][BusinessPrice]);
        CharacterSave(playerid);
        SaveBusiness(b_id);
    }
    else SendErrorMessage(playerid, "�س���������������ǳ�Ԩ��÷���ͧ��� ����");
    return 1;
}

CMD:sellbiz(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    new str[MAX_STRING];
    
    if(id != 0)
    {
        if(BusinessInfo[id][BusinessOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendErrorMessage(playerid, "�س�������Ңͧ�Ԩ���");

        format(str, sizeof(str), "{FFFFFF}�س������ͻ��Ƿ��� ��¡Ԩ��âͧ�س ��â�¡Ԩ��ù��س�����Ѻ�Թ�ӹǹ {2ECC71}$%s{FFFFFF} �Թ�ӹǹ������Թ���觹֧�ͧ�Ҥ����㹡Ԩ����ҡ�س��¡Ԩ�������\n\
                                  �س���������ö�Ѵ��áԨ��âͧ�س���ա��� �����س�Դ���ա�͹�еͺ '�׹�ѹ'",MoneyFormat(BusinessInfo[id][BusinessPrice] / 2));
        Dialog_Show(playerid, DIALOG_SELL_BU, DIALOG_STYLE_MSGBOX, "�س����?", str, "�Թ�ѹ", "¡��ԡ");
        return 1;
    }
    else SendErrorMessage(playerid, "�س���������㹡Ԩ���");
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
        return SendErrorMessage(playerid, "�س�����������ҹ��������");

    ShowPlayerBuyFood(playerid);
    return 1;
}

CMD:buy(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness];
    

    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE)
        return SendErrorMessage(playerid, "�س�������������ҹʴǡ����");

    MenuStore_AddItem(playerid, 1, 18919, "Mask", 5000, "Mask use /mask", 200);
    MenuStore_AddItem(playerid, 2, 19942, "Radio", 10000, "Radio", 200);
    MenuStore_AddItem(playerid, 3, 367, "Camera", 15000, "Cemara To Take Photo", 200);
    MenuStore_AddItem(playerid, 4, 325, "Flower", 300, "Flower", 200);
    MenuStore_Show(playerid, Shop, "SHOP");
    return 1;
}

CMD:bank(playerid, params[])
{
	new
		id = IsPlayerInBusiness(playerid),
		amount
	;
		
	if(!id)
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��"); 
		
	if(sscanf(params, "d", amount))
		return SendUsageMessage(playerid, "/bank [�ӹǹ�Թ���нҡ]");
		
	if(amount < 1 || amount > PlayerInfo[playerid][pCash])
		return SendErrorMessage(playerid, "�س���Թ�����§��"); 
		
	PlayerInfo[playerid][pBank]+= amount;
	GiveMoney(playerid, -amount); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "�س��ҡ�Թ�ӹǹ $%s ���㹺ѭ�ո�Ҥ�âͧ�س �ҡ���:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
	CharacterSave(playerid);
	return 1; 
}
new PlayerSavingAdd[MAX_PLAYERS];

CMD:saving(playerid, params[])
{
    if(PlayerInfo[playerid][pSaving])
        return SendErrorMessage(playerid, "�س��ӡ��������ҡ�����Ѿ����������");
    
    new
		id = IsPlayerInBusiness(playerid),
        money
	;
		
	if(!id)
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��");

    if(PlayerInfo[playerid][pBank])
        return SendErrorMessage(playerid, "�͹�Թ�������ͧ�س�͡��������͹���нҡ��������");

    if(PlayerInfo[playerid][pCash] < 2000)
        return SendErrorMessage(playerid, "�Թ���е�ͧ�������㹡�ýҡ�Թ��� ����ӡ��� $2,000 ��������Թ $1,000,00");

    if(sscanf(params, "d", money))
        return SendUsageMessage(playerid, "/saving  <�ӹǹ�Թ>");
    
    if(money < 2000 || money >= 1000000)
        return SendErrorMessage(playerid, "�س�е�ͧ�ҡ�Թ��鹵�� $2,000 �������Թ $1,000,000");

    PlayerSavingAdd[playerid] = money;

    

    new str[1000];
    format(str, sizeof(str), "��͵�ŧ㹡�÷Ӻѭ�������Ѿ��ͧ�س��� �繢�͵�ŧ�����ҧ�س�Ѻ��Ҥ�� ��\n\
    \t���¹ %s\n\
    \t\t��͵�ŧ㹡�÷Ӻѭ�������Ѿ��ͧ�س��� �繢�͵�ŧ�����ҧ�س�Ѻ��Ҥ�� ���բ�͡�˹���ҧ� ���س����\n�е�ͧ��ԺѵԵ���������Ѻ�ѹ�ѧ��͡�˹�\n\
    ��ͷ�� 1: �س�����Ѻ�͡�����ҡ��鹨ҡ������س�����蹡��� 0.9\n\
    ��ͷ�� 2: �س���������ö�͹�Թ�騹�����Թ�ͧ�س�Фú��˹� $2,000,000\n\
    ��ͷ�� 3: �ҡ�س�ӡ�ö͹��͹��˹��ж١�ҧ��Ҥ�û�Ѻ�Թ�س ��� 2 �ͧ�Թ���������س��\n\
    �ҡ�س��ҹ��͡�˹��ͧ������������Ѻ�ô���ӹǹ�Թ���е�ͧ�������㹡�ýҡ�Թ��� ����ӡ��� $2,000 ��������Թ $1,000,000",ReturnName(playerid, 0));
    Dialog_Show(playerid, DIALOG_CONFIRM_SAVEING, DIALOG_STYLE_MSGBOX, "��͵�ŧ㹡�ýҡ�Թ�����Ѿ��", str, "�׹�ѹ����¡��", "¡��ԡ��÷���¡��");
    return 1;
}

Dialog:DIALOG_CONFIRM_SAVEING(playerid, response, listitem, inputtext[])
{  
    if(!response)
        return SendClientMessage(playerid, -1, "�س�黮��ʸ�ѭ�Ң�͵�ŧ�Ѻ��Ҥ��");

    new money = PlayerSavingAdd[playerid];

    GivePlayerMoney(playerid, -money);
    PlayerInfo[playerid][pSaving] = true;
    PlayerInfo[playerid][pBank] += money;
    CharacterSave(playerid);

    SendClientMessageEx(playerid, COLOR_DARKGREEN, "�س��������ҡ�ԹẺ�ѭ�������Ѿ�����Ǩӹǹ�Թ������� $%s",MoneyFormat(money));
    PlayerSavingAdd[playerid] = 0;
    return 1;
}

CMD:withdraw(playerid, params[])
{
    new id = PlayerInfo[playerid][pInsideBusiness], amount;


    if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE && BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
        return SendErrorMessage(playerid, "�س���������㹸�Ҥ��������ҹʴǡ����");

    if(sscanf(params, "i", amount))
		return SendUsageMessage(playerid, "/withdraw [�ӹǹ�Թ]");

    if(amount < 1 || amount > PlayerInfo[playerid][pBank])
		return SendErrorMessage(playerid, "�س���Թ㹺ѭ�ո�Ҥ�������§��"); 

    if(PlayerInfo[playerid][pSaving])
    {

        PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank] / 2;
        PlayerInfo[playerid][pSaving] = false;
        SendClientMessage(playerid, -1, "[BANK] �س����������ͧ�͹�Թ�͡�ҡ��Ҥ��������ҧ���ҡ�����Ѿ�����������ѭ�Ңͧ�س�Ѻ��Ҥ�âҴ");
        SendClientMessage(playerid, -1, "....��е����͵�ŧ��鹤س����ѭ�����Ѻ�ҧ��Ҥ�� ��Ҥ�è֧���繵�ͧ��Ѻ�Թ���觹֧㹺ѭ�բͧ�س�����͡�˹�");

        if(PlayerInfo[playerid][pBank] < amount)
            return SendErrorMessage(playerid, "�س���Թ㹺ѭ�ո�Ҥ�������§�� �Թ�س����� $%s", MoneyFormat(PlayerInfo[playerid][pBank]));
 
        PlayerInfo[playerid][pSaving] = false;
        PlayerInfo[playerid][pBank]-= amount;
        GiveMoney(playerid, amount);
        SendClientMessageEx(playerid, COLOR_ACTION, "�س��͹�Թ�ӹǹ $%s �ҡ�ѭ�ո�Ҥ�âͧ�س �������:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
        CharacterSave(playerid);
        return 1;
    }

    PlayerInfo[playerid][pBank]-= amount;
	GiveMoney(playerid, amount);
    SendClientMessageEx(playerid, COLOR_ACTION, "�س��͹�Թ�ӹǹ $%s �ҡ�ѭ�ո�Ҥ�âͧ�س �������:$%s", MoneyFormat(amount), MoneyFormat(PlayerInfo[playerid][pBank]));
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
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��������ҹʴǡ����");
		
	if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE && BusinessInfo[id][BusinessType] != BUSINESS_TYPE_BANK)
		return SendErrorMessage(playerid, "�س���������㹸�Ҥ��������ҹʴǡ����"); 
	
	SendClientMessageEx(playerid, COLOR_ACTION, "�س���Թ����㹺ѭ�ո�Ҥ�� $%s ����դ�Ҩ�ҧ��ª������ $%s  (%s)", MoneyFormat(PlayerInfo[playerid][pBank]), MoneyFormat(PlayerInfo[playerid][pPaycheck]), ReturnDate());	
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
        SendClientMessageEx(playerid, COLOR_GREY, "�س���Ѻ�Թ��ª������ͧ�س���� �ӹǹ $%s", MoneyFormat(PlayerInfo[playerid][pPaycheck]));
        PlayerInfo[playerid][pPaycheck] = 0;
        return 1;
    }
    return 1;
}





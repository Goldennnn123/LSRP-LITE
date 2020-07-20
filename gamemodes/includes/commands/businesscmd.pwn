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
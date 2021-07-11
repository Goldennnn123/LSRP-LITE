CMD:drughelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "____________DRUGS HELP____________");

    SendClientMessage(playerid, -1, "");
    SendClientMessage(playerid, -1, "/checkdrug (��Ǩ�������㹵��)");
    SendClientMessage(playerid, -1, "/givedrug (�����)");
    SendClientMessage(playerid, -1, "/usedrug (����)");
    SendClientMessage(playerid, -1, "");

    SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________");
    return 1;
}

CMD:checkdrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin])
    {
        new tagetid;

        if(sscanf(params, "I(-1)", tagetid))
        {
            SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
            SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
            SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
            SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
            return 1;
        }

        if(tagetid == -1)
        {
            SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
            SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
            SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
            SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
            return 1;
        }

        if(!IsPlayerConnected(tagetid))
            return SendErrorMessage(playerid, "����������������������������");

        if(IsPlayerLogin(tagetid))
            return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");
        
        SendClientMessageEx(playerid, COLOR_DARKGREEN, "__________DRUGS %s__________", ReturnName(tagetid,0));
        SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[tagetid][pDrug][0]);
        SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[tagetid][pDrug][1]);
        SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[tagetid][pDrug][2]);
        return 1;
        
    }

    SendClientMessage(playerid, COLOR_DARKGREEN, "__________DRUGS__________");
    SendClientMessageEx(playerid, -1, "Cocaine: %.2f",PlayerInfo[playerid][pDrug][0]);
    SendClientMessageEx(playerid, -1, "Cannabis: %.2f",PlayerInfo[playerid][pDrug][1]);
    SendClientMessageEx(playerid, -1, "Heroin: %.2f",PlayerInfo[playerid][pDrug][2]);
    return 1;
}

CMD:givedrug(playerid, params[])
{
    new tagetid, type, Float:amout, str[200];

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/givedrug <���ͺҧ��ǹ> <�ʹ�> <�ӹǹ : ����>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(tagetid == playerid)
        return SendErrorMessage(playerid, "�������ö��Ѻ����ͧ��");

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "����������������������������");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "�������������������Ǣͧ�س");

    if(amout < 0.01)
        return SendErrorMessage(playerid, "���ӹǹ�����Թ�");

    switch(type)
    {
        case 1:
        {
            if(PlayerInfo[playerid][pDrug][0] < amout)
                return SendErrorMessage(playerid, "�س�ըӹǹ�������§�͵�͡�����");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ��蹺ҧ���ҧ���Ѻ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "�س���ͺ Cocaine ���Ѻ %s �ӹǹ %.2f ����",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cocaine' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);

            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][0]-=amout;
            PlayerInfo[tagetid][pDrug][0]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 2:
        {
            if(PlayerInfo[playerid][pDrug][1] < amout)
                return SendErrorMessage(playerid, "�س�ըӹǹ�������§�͵�͡�����");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ��蹺ҧ���ҧ���Ѻ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "�س���ͺ Cannabis ���Ѻ %s �ӹǹ %.2f ����",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Cannabis' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);    
            Log(druglog, WARNING, str);        
            
            PlayerInfo[playerid][pDrug][1]-=amout;
            PlayerInfo[tagetid][pDrug][1]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        case 3:
        {
            if(PlayerInfo[playerid][pDrug][2] < amout)
                return SendErrorMessage(playerid, "�س�ըӹǹ�������§�͵�͡�����");

            SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "* %s ��蹺ҧ���ҧ���Ѻ %s",ReturnName(playerid,0), ReturnName(tagetid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "�س���ͺ Heroin ���Ѻ %s �ӹǹ %.2f ����",ReturnName(tagetid,0), amout);
            
            format(str, sizeof(str), "[%s] %s Give Drug 'Heroin' for %s Amount: %.2f", ReturnDate(),ReturnName(playerid,0), ReturnName(tagetid,0), amout);
            SendDiscordMessage(5, str);  
            Log(druglog, WARNING, str);

            PlayerInfo[playerid][pDrug][2]-=amout;
            PlayerInfo[tagetid][pDrug][2]+=amout;
            GiveDrug(tagetid, type, amout);
            CharacterSave(playerid);
        }
        default: SendErrorMessage(playerid, "�����������١��ͧ");
    }
    return 1;
}

CMD:usedrug(playerid, params[])
{
    new type, Float:health;

    if(sscanf(params, "d", type))
    {
        SendUsageMessage(playerid, "/usedrug <������>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    GetPlayerHealth(playerid, health);
    switch(type)
    {
        case 1:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "�س�����ʹ�֧�մ�ӡѴ����");

            SetPlayerHealth(playerid, health+2);
            SendClientMessage(playerid, COLOR_GREY, "�س���ա���ʾ���ʾ�Դ 'Cocaine' ��������ʹ�ͧ�س���� +2");
            PlayerInfo[playerid][pDrug][0]-= 0.01;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]++;
            }
            Log(druglog, WARNING, "%s �ա���� ���ʾ�Դ 'Cocaine'", ReturnName(playerid, 0));
            return 1;
        }
        case 2:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "�س�����ʹ�֧�մ�ӡѴ����");

            SetPlayerHealth(playerid, health+3);
            SendClientMessage(playerid, COLOR_GREY, "�س���ա���ʾ���ʾ�Դ 'Cannabis' ��������ʹ�ͧ�س���� +3");
            PlayerInfo[playerid][pDrug][1]-= 0.01;
            PlayerInfo[playerid][pAddicted] = true;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]+=2;
            }
            Log(druglog, WARNING, "%s �ա���� ���ʾ�Դ 'Cannabis'", ReturnName(playerid, 0));
        }
        case 3:
        {
            if(health > 200)
                return SendErrorMessage(playerid, "�س�����ʹ�֧�մ�ӡѴ����");

            SetPlayerHealth(playerid, health+5);
            SendClientMessage(playerid, COLOR_GREY, "�س���ա���ʾ���ʾ�Դ 'Heroin' ��������ʹ�ͧ�س���� +5");
            PlayerInfo[playerid][pDrug][1]-= 0.01;
            PlayerInfo[playerid][pAddicted] = true;
            if(PlayerInfo[playerid][pAddictedCount] > 4)
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
                PlayerInfo[playerid][pAddictedCount]++;
            }
            Log(druglog, WARNING, "%s �ա���� ���ʾ�Դ 'Cannabis'", ReturnName(playerid, 0));
        }
    }
    return 1;
}

CMD:buydrug(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, DrugBuyPos[RanDomDrugPoint][DrugPosX], DrugBuyPos[RanDomDrugPoint][DrugPosY], DrugBuyPos[RanDomDrugPoint][DrugPosZ]))
        return SendErrorMessage(playerid, "�س���������ش�������ʾ�Դ");
    
    new Float:amout, type;

    if(sscanf(params, "df",type,amout))
    {
        SendUsageMessage(playerid, "/buydrug <�ҷ���ͧ���> <�ӹǹ�ҷ���ͧ��� ������ҧ: 0.01>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin 4.Random");
        return 1;
    }

    BuyDrug(playerid, amout, type);
    return 1;
}

CMD:setdrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
        return SendUnauthMessage(playerid);

    new tagetid,type, Float:amout;

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/setdrug <���ͺҧ��ǹ/�ʹ�> <���������ʾ�Դ> <�ӹǹ : ����>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "����������������������������");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "�������������������Ǣͧ�س");

    if(amout < 0.01)
        return SendErrorMessage(playerid, "���ӹǹ�����Թ�");

    switch(type)
    {
        case 1:
        {
            PlayerInfo[tagetid][pDrug][0] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������Ѻ���ʾ�Դ 'Cocaine' �ͧ�س�� %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���Ѻ���ʾ�Դ 'Cocaine' �ͧ %s ����� %.2f ����",ReturnName(tagetid,0), amout);
        }
        case 2:
        {
            PlayerInfo[tagetid][pDrug][1] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������Ѻ���ʾ�Դ 'Cannabis' �ͧ�س�� %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���Ѻ���ʾ�Դ 'Cannabis' �ͧ %s ����� %.2f ����",ReturnName(tagetid,0), amout);
        }
        case 3:
        {
            PlayerInfo[tagetid][pDrug][1] = amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������Ѻ���ʾ�Դ 'Heroin' �ͧ�س�� %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���Ѻ���ʾ�Դ 'Heroin' �ͧ %s ����� %.2f ����",ReturnName(tagetid,0), amout);
        }
        default: SendErrorMessage(playerid, "����������ͧ���ʾ�Դ���١��ͧ");
    }
    return 1;
}

CMD:agivedrug(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
        return SendUnauthMessage(playerid);

    new tagetid,type, Float:amout;

    if(sscanf(params, "udf", tagetid, type, amout))
    {
        SendUsageMessage(playerid, "/agivedrug <���ͺҧ��ǹ/�ʹ�> <���������ʾ�Դ> <�ӹǹ : ����>");
        SendUsageMessage(playerid, "1.Cocaine 2.Cannabis 3.Heroin");
        return 1;
    }

    if(!IsPlayerConnected(tagetid))
        return SendErrorMessage(playerid, "����������������������������");

    if(IsPlayerLogin(tagetid))
        return SendErrorMessage(playerid, "�����蹡��ѧ�������к�");

    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
        return SendErrorMessage(playerid, "�������������������Ǣͧ�س");

    if(amout < 0.01)
        return SendErrorMessage(playerid, "���ӹǹ�����Թ�");

    switch(type)
    {
        case 1:
        {
            PlayerInfo[tagetid][pDrug][0] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������������ʾ�Դ 'Cocaine' �ͧ�س %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���������ʾ�Դ 'Cocaine' �ͧ %s ��� %.2f ����",ReturnName(tagetid,0), amout);
        }
        case 2:
        {
            PlayerInfo[tagetid][pDrug][1] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������������ʾ�Դ 'Cannabis' �ͧ�س %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���������ʾ�Դ 'Cannabis' �ͧ %s ��� %.2f ����",ReturnName(tagetid,0), amout);
        }
        case 3:
        {
            PlayerInfo[tagetid][pDrug][1] += amout;
            SendClientMessageEx(tagetid, COLOR_YELLOWEX, "���������������ʾ�Դ 'Heroin' �ͧ�س %.2f ����",amout);
            SendClientMessageEx(playerid, COLOR_GREY, "�س���������ʾ�Դ 'Heroin' �ͧ %s ��� %.2f ����",ReturnName(tagetid,0), amout);
        }
        default: SendErrorMessage(playerid, "����������ͧ���ʾ�Դ���١��ͧ");
    }
    return 1;
}
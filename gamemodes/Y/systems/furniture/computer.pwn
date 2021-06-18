#include <YSI_Coding\y_hooks>

hook OnGameModeInit@15()
{
    mysql_tquery(dbCon, "SELECT * FROM computer ORDER BY ComputerDBID", "LoadComputer");
    return 1;
}

enum P_SELECT_COMPUTER
{
    p_SelectOption,
    p_SelectCPU,
    p_SelectGPU[5],
    p_SelectRAM,
    p_SelectStored,
    p_SelePrice,
}
new PlayerSelectCom[MAX_PLAYERS][P_SELECT_COMPUTER];
new PlayerSelectSlot[MAX_PLAYERS];


hook OP_Connect(playerid)
{
    PlayerSelectCom[playerid][p_SelectCPU] = 0;

    for(new slotid = 0; slotid < 5; slotid++)
    {
        PlayerSelectCom[playerid][p_SelectGPU][slotid] = 0;
    }
    PlayerSelectCom[playerid][p_SelectRAM] = 0;
    PlayerSelectCom[playerid][p_SelectStored] = 0;
    PlayerSelectCom[playerid][p_SelePrice] = 0;
    PlayerSelectSlot[playerid] = 0;
    PlayerSelectCom[playerid][p_SelectOption] = 0;
    return 1;
}

forward LoadComputer();
public LoadComputer()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No computer were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countcomputer; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_COMPUTER; i ++)
    {
        cache_get_value_name_int(i,"ComputerDBID",ComputerInfo[i+1][ComputerDBID]);
        cache_get_value_name_int(i,"ComputerOwnerDBID",ComputerInfo[i+1][ComputerOwnerDBID]);
        cache_get_value_name_int(i,"ComputerOn",ComputerInfo[i+1][ComputerOn]);
        cache_get_value_name_int(i,"ComputerCPU",ComputerInfo[i+1][ComputerCPU]);
        cache_get_value_name_int(i,"ComputerRAM",ComputerInfo[i+1][ComputerRAM]);
        cache_get_value_name_int(i,"ComputerGPU1",ComputerInfo[i+1][ComputerGPU][0]);
        cache_get_value_name_int(i,"ComputerGPU2",ComputerInfo[i+1][ComputerGPU][1]);
        cache_get_value_name_int(i,"ComputerGPU3",ComputerInfo[i+1][ComputerGPU][2]);
        cache_get_value_name_int(i,"ComputerGPU4",ComputerInfo[i+1][ComputerGPU][3]);
        cache_get_value_name_int(i,"ComputerGPU5",ComputerInfo[i+1][ComputerGPU][4]);
        cache_get_value_name_int(i,"ComputerStored",ComputerInfo[i+1][ComputerStored]);
        cache_get_value_name_float(i,"ComputerPosX",ComputerInfo[i+1][ComputerPos][0]);
        cache_get_value_name_float(i,"ComputerPosY",ComputerInfo[i+1][ComputerPos][1]);
        cache_get_value_name_float(i,"ComputerPosZ",ComputerInfo[i+1][ComputerPos][2]);
        cache_get_value_name_float(i,"ComputerPosRX",ComputerInfo[i+1][ComputerPos][3]);
        cache_get_value_name_float(i,"ComputerPosRY",ComputerInfo[i+1][ComputerPos][4]);
        cache_get_value_name_float(i,"ComputerPosRZ",ComputerInfo[i+1][ComputerPos][5]);
        cache_get_value_name_int(i,"ComputerPosWorld",ComputerInfo[i+1][ComputerPosWorld]);
        cache_get_value_name_int(i,"ComputerPosInterior",ComputerInfo[i+1][ComputerPosInterior]);

        cache_get_value_name_int(i,"ComputerSpawn",ComputerInfo[i+1][ComputerSpawn]);
        cache_get_value_name_int(i,"ComputerStartBTC",ComputerInfo[i+1][ComputerStartBTC]);
        cache_get_value_name_float(i,"ComputerBTC",ComputerInfo[i+1][ComputerBTC]);


        if(ComputerInfo[i+1][ComputerSpawn])
        {
            if(IsValidDynamicObject(ComputerInfo[i+1][ComputerObject]))
                DestroyDynamicObject(ComputerInfo[i+1][ComputerObject]);

            ComputerInfo[i+1][ComputerObject] = CreateDynamicObject(19893, ComputerInfo[i+1][ComputerPos][0], ComputerInfo[i+1][ComputerPos][1], ComputerInfo[i+1][ComputerPos][2], ComputerInfo[i+1][ComputerPos][3], ComputerInfo[i+1][ComputerPos][4], ComputerInfo[i+1][ComputerPos][5], ComputerInfo[i+1][ComputerPosWorld], ComputerInfo[i+1][ComputerPosInterior]);
        }

        countcomputer++;
    }
    printf("[SERVER]: %i Computer were loaded from \"%s\" database...", countcomputer, MYSQL_DB);
    return 1;
}

stock ReturnCPUName(playerid)
{
    new str_sec[255];

    if(PlayerSelectCom[playerid][p_SelectCPU])
    {
        switch(PlayerSelectCom[playerid][p_SelectCPU])
        {
            case 1: format(str_sec, sizeof(str_sec), "I3");
            case 2: format(str_sec, sizeof(str_sec), "I5");
            case 3: format(str_sec, sizeof(str_sec), "I7");
            case 4: format(str_sec, sizeof(str_sec), "I9");
        }
    }
    else format(str_sec, sizeof(str_sec), "�����");

    return str_sec;
}

stock ReturnGPUName(playerid, slotid)
{
    new str_sec[255];

    if(PlayerSelectCom[playerid][p_SelectGPU][slotid])
    {
        switch(PlayerSelectCom[playerid][p_SelectGPU][slotid])
        {
            case 1: format(str_sec, sizeof(str_sec), "GTX 1650");
            case 2: format(str_sec, sizeof(str_sec), "RTX 2060");
            case 3: format(str_sec, sizeof(str_sec), "RTX 2070");
            case 4: format(str_sec, sizeof(str_sec), "RTX 2080");
            case 5: format(str_sec, sizeof(str_sec), "RTX 2090");
        }
    }
    else format(str_sec, sizeof(str_sec), "�����");

    return str_sec;
}


stock ReturnRam(playerid)
{
    new str_sec[255];

    if(PlayerSelectCom[playerid][p_SelectRAM])
    {
        switch(PlayerSelectCom[playerid][p_SelectRAM])
        {
            case 8: format(str_sec, sizeof(str_sec), "8 GB");
            case 16: format(str_sec, sizeof(str_sec), "16 GB");
            case 32: format(str_sec, sizeof(str_sec), "32 GB");
            case 64: format(str_sec, sizeof(str_sec), "64 GB");
            case 128: format(str_sec, sizeof(str_sec), "128 GB");
        }
    }
    else format(str_sec, sizeof(str_sec), "�����");

    return str_sec;
}

stock ReturnStored(playerid)
{
    new str_sec[255];

    if(PlayerSelectCom[playerid][p_SelectStored])
    {
        switch(PlayerSelectCom[playerid][p_SelectStored])
        {
            case 120: format(str_sec, sizeof(str_sec), "SSD 120 GB");
            case 256: format(str_sec, sizeof(str_sec), "SSD 256 GB");
            case 480: format(str_sec, sizeof(str_sec), "SSD 480 GB");
            case 500: format(str_sec, sizeof(str_sec), "SSD 500 GB");
            case 1000: format(str_sec, sizeof(str_sec), "SSD 1 TB");
        }
    }
    else format(str_sec, sizeof(str_sec), "0 GB");

    return str_sec;
}


stock ShowPlayerComputerSpec(playerid, option)
{
    if(option == 1)
    {
        new str[255], longstr[255];
    
        format(str, sizeof(str), "CPU: %s\n", ReturnCPUName(playerid));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 1: %s\n", ReturnGPUName(playerid, 0));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 2: %s\n", ReturnGPUName(playerid, 1));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 3: %s\n", ReturnGPUName(playerid, 2));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 4: %s\n", ReturnGPUName(playerid, 3));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 5: %s\n", ReturnGPUName(playerid, 4));
        strcat(longstr, str);
        format(str, sizeof(str), "RAM: %s \n", ReturnRam(playerid));
        strcat(longstr, str);
        format(str, sizeof(str), "Stored: %s\n", ReturnStored(playerid));
        strcat(longstr, str);

        if(PlayerSelectCom[playerid][p_SelePrice])
        {
            format(str, sizeof(str), ""EMBED_GREENMONEY"[ ! ]�׹�ѹ��ë���: %s\n", MoneyFormat(PlayerSelectCom[playerid][p_SelePrice]));
            strcat(longstr, str);
        }

        Dialog_Show(playerid, D_BUYCOMPUTER, DIALOG_STYLE_LIST, "Computer Spec", longstr, "�׹�ѹ", "¡��ԡ");
    }
    else
    {
        new str[255], longstr[255];
    
        format(str, sizeof(str), "CPU: %s\n", ReturnCPUName(playerid));
        strcat(longstr, str);

        if(PlayerSelectCom[playerid][p_SelectOption] == 2)
        {
            format(str, sizeof(str), "GPU: %s\n", ReturnGPUName(playerid, 0));
            strcat(longstr, str);

        }
        else
        {
            format(str, sizeof(str), "GPU 2: %s\n", ReturnGPUName(playerid, 1));
            strcat(longstr, str);
            format(str, sizeof(str), "GPU 3: %s\n", ReturnGPUName(playerid, 2));
            strcat(longstr, str);
            format(str, sizeof(str), "GPU 4: %s\n", ReturnGPUName(playerid, 3));
            strcat(longstr, str);
            format(str, sizeof(str), "GPU 5: %s\n", ReturnGPUName(playerid, 4));
            strcat(longstr, str);
        }

        format(str, sizeof(str), "RAM: %s \n", ReturnRam(playerid));
        strcat(longstr, str);
        format(str, sizeof(str), "Stored: %s\n", ReturnStored(playerid));
        strcat(longstr, str);

        if(PlayerSelectCom[playerid][p_SelePrice])
        {
            format(str, sizeof(str), ""EMBED_GREENMONEY"[ ! ]�׹�ѹ��ë���: %s\n", MoneyFormat(PlayerSelectCom[playerid][p_SelePrice]));
            strcat(longstr, str);
        }

        return  Dialog_Show(playerid, D_BUYCOMPUTER_2, DIALOG_STYLE_LIST, "����������", longstr, "�׹�ѹ", "¡��ԡ");
    }

    return 1;
}

CMD:buycomputer(playerid, params[])
{
    //ShowPlayerComputerSpec(playerid);
    Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "���͡��������ë��͢��", "[ ! ] ����������\n[ ! ] ���ͤ����", "�׹�ѹ", "¡��ԡ");
    return 1;
}

CMD:opencom(playerid, params[])
{
    if(!IsPlayerNearComputer(playerid))
        return SendErrorMessage(playerid, "�س������������ ���������� / ��绷�ͻ");

    new id = IsPlayerNearComputer(playerid);

    if(ComputerInfo[id][ComputerOwnerDBID] != PlayerInfo[playerid][pDBID])
        return SendErrorMessage(playerid, "�������ͧ��������ͧ�س");

    ComputerInfo[id][ComputerOn] = true;
    SendClientMessage(playerid, -1, "�Դ���......");
    LoadTD_Computer(playerid);
    ShowTD_Computer(playerid);
    return 1;
}

Dialog:D_BUYCOMPUTER_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    switch(listitem)
    {
        case 0: 
        { 
            PlayerSelectCom[playerid][p_SelectOption] = 2;

            return  ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1: 
        {
            PlayerSelectCom[playerid][p_SelectOption] = 1;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
    
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_2(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "���͡��������ë��͢��", "[ ! ] ����������\n[ ! ] ���ͤ����", "�׹�ѹ", "¡��ԡ");

    }

    switch(listitem)
    {
        case 0:
        {
            if(PlayerSelectCom[playerid][p_SelectCPU])
            {
                SendErrorMessage(playerid, "�س�����͡ CPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pCPU])
                return SendErrorMessage(playerid, "�س�� �վ��� ����㹵��");


            new str[255], longstr[255];

            format(str, sizeof(str), "I3 $4,290\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I5 $5,890\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I7 $13,500\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I9 $20,900\n");
            strcat(longstr, str);
            Dialog_Show(playerid, D_BUYCOMPUTER_CPU, DIALOG_STYLE_LIST, "���͡ CPU", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 1:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][0])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pGPU])
                return SendErrorMessage(playerid, "�س�� ���촨� ����㹵��");

            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 0;

            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 1", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 2:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectRAM])
            {
                SendErrorMessage(playerid, "�س�����͡ ��� ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pRAM])
                return SendErrorMessage(playerid, "�س�� ��� ����㹵��");

            format(str, sizeof(str), "RAM 8 GB $1,770\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 16 GB $2,700\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 32 GB $6,250\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 64 GB $17,800\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 128 GB $30,500\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_BUYCOMPUTER_RAM, DIALOG_STYLE_LIST, "���͡ RAM", longstr, "�׹�ѹ", "¡��ԡ");
            return 1;
        }
        case 3:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectStored])
            {
                SendErrorMessage(playerid, "�س�����͡ SSD ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pStored])
                return SendErrorMessage(playerid, "�س�� SSD ����㹵��");

            format(str, sizeof(str), "SSD 120 GB $850\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 256 GB $1,470\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 480 GB $1,950\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 500 GB $2,150\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 1 TB $3,350\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_BUYCOMPUTER_STORED, DIALOG_STYLE_LIST, "���͡ Stored", longstr, "�׹�ѹ", "¡��ԡ");
            return 1;
        }
        case 4:
        {
            new Price = PlayerSelectCom[playerid][p_SelePrice] - PlayerInfo[playerid][pCash];
            new money = PlayerSelectCom[playerid][p_SelePrice];

            if(PlayerSelectCom[playerid][p_SelePrice] > PlayerInfo[playerid][pCash])
            {
                ClearSelectBuyComputer(playerid);
                return SendClientMessageEx(playerid, COLOR_RED, "ERROR: "EMBED_WHITE"�س���Թ����§�� (�ѧ�Ҵ�͡ $%s)",MoneyFormat(Price));
            }

            PlayerInfo[playerid][pCPU] = PlayerSelectCom[playerid][p_SelectCPU];
            PlayerInfo[playerid][pGPU] = PlayerSelectCom[playerid][p_SelectGPU];
            PlayerInfo[playerid][pRAM] = PlayerSelectCom[playerid][p_SelectRAM];
            PlayerInfo[playerid][pStored] = PlayerSelectCom[playerid][p_SelectStored];
            SendClientMessageEx(playerid, COLOR_DARKGREEN, "�س�������������������� ���¨ӹǹ�Թ $%s", MoneyFormat(money));
            GiveMoney(playerid, -PlayerSelectCom[playerid][p_SelePrice]);
            CharacterSave(playerid);
            ClearSelectBuyComputer(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        ClearSelectBuyComputer(playerid);
        return Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "���͡��������ë��͢��", "[ ! ] ����������\n[ ! ] ���ͤ����", "�׹�ѹ", "¡��ԡ");

    }

    switch(listitem)
    {
        case 0:
        {
            if(PlayerSelectCom[playerid][p_SelectCPU])
            {
                SendErrorMessage(playerid, "�س�����͡ CPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            new str[255], longstr[255];

            format(str, sizeof(str), "I3 $4,290\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I5 $5,890\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I7 $13,500\n");
            strcat(longstr, str);
            format(str, sizeof(str), "I9 $20,900\n");
            strcat(longstr, str);
            Dialog_Show(playerid, D_BUYCOMPUTER_CPU, DIALOG_STYLE_LIST, "���͡ CPU", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 1:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][0])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }
            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 0;

            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 1", longstr, "���͡", "¡��ԡ");
            return 1;
        }

        case 2:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][1])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }


            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 1;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 2", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 3:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][2])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 2;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 3", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 4:
        {
            if(PlayerSelectCom[playerid][p_SelectGPU][3])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }
            new str[255], longstr[255];

            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 3;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 4", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 5:
        {
            if(PlayerSelectCom[playerid][p_SelectGPU][4])
            {
                SendErrorMessage(playerid, "�س�����͡ GPU ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }
            new str[255], longstr[255];

            format(str, sizeof(str), "GTX 1650 $9,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2060 $16,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2070 $23,900\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2080 $45,390\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RTX 2090 $55,900\n");
            strcat(longstr, str);
            PlayerSelectSlot[playerid] = 4;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "���͡ GPU Slot 5", longstr, "���͡", "¡��ԡ");
            return 1;
        }
        case 6:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectRAM])
            {
                SendErrorMessage(playerid, "�س�����͡ ��� ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            format(str, sizeof(str), "RAM 8 GB $1,770\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 16 GB $2,700\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 32 GB $6,250\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 64 GB $17,800\n");
            strcat(longstr, str);
            format(str, sizeof(str), "RAM 128 GB $30,500\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_BUYCOMPUTER_RAM, DIALOG_STYLE_LIST, "���͡ RAM", longstr, "�׹�ѹ", "¡��ԡ");
            return 1;
        }
        case 7:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectStored])
            {
                SendErrorMessage(playerid, "�س�����͡ SSD ����");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            format(str, sizeof(str), "SSD 120 GB $850\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 256 GB $1,470\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 480 GB $1,950\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 500 GB $2,150\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 1 TB $3,350\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_BUYCOMPUTER_STORED, DIALOG_STYLE_LIST, "���͡ Stored", longstr, "�׹�ѹ", "¡��ԡ");
            return 1;
        }
        case 8:
        {
            new Price = PlayerSelectCom[playerid][p_SelePrice] - PlayerInfo[playerid][pCash];
            new money = PlayerSelectCom[playerid][p_SelePrice];

            if(PlayerSelectCom[playerid][p_SelePrice] > PlayerInfo[playerid][pCash])
            {
                ClearSelectBuyComputer(playerid);
                return SendClientMessageEx(playerid, COLOR_RED, "ERROR: "EMBED_WHITE"�س���Թ����§�� (�ѧ�Ҵ�͡ $%s)",MoneyFormat(Price));
            }

            new idx = 0;
	
            for (new i = 1; i < MAX_COMPUTER; i ++)
            {
                if(!ComputerInfo[i][ComputerDBID])
                {
                    idx = i; 
                    break;
                }
            }
            if(idx == 0)
            {
                return SendServerMessage(playerid, "�������ö�դ�����������׿���ҡ���ҹ������ (100)"); 
            }


            SendClientMessageEx(playerid, COLOR_DARKGREEN, "�س����ͤ��������� ���¨ӹǹ�Թ $%s", MoneyFormat(money));
            GiveMoney(playerid, -money);
            CharacterSave(playerid);

            new query[500];

            new CPU = PlayerSelectCom[playerid][p_SelectCPU],
                GPU1 = PlayerSelectCom[playerid][p_SelectGPU][0],
                GPU2 = PlayerSelectCom[playerid][p_SelectGPU][1],
                GPU3 = PlayerSelectCom[playerid][p_SelectGPU][2],
                GPU4 = PlayerSelectCom[playerid][p_SelectGPU][3],
                GPU5 = PlayerSelectCom[playerid][p_SelectGPU][4],
                RAM = PlayerSelectCom[playerid][p_SelectRAM],
                Stored = PlayerSelectCom[playerid][p_SelectStored]

            ;

            mysql_format(dbCon, query, sizeof(query), "INSERT INTO `computer` (`ComputerOwnerDBID`, `ComputerOn`, `ComputerSpawn`, `ComputerCPU`, `ComputerRAM`, `ComputerGPU1`, `ComputerGPU2`, `ComputerGPU3`, `ComputerGPU4`,  `ComputerGPU5`, `ComputerStored`) VALUES('%d', '%d', '%d', '%d', '%d','%d','%d','%d','%d','%d','%d')",
                PlayerInfo[playerid][pDBID],
                0,
                0,
                PlayerSelectCom[playerid][p_SelectCPU],
                PlayerSelectCom[playerid][p_SelectRAM],
                PlayerSelectCom[playerid][p_SelectGPU][0],
                PlayerSelectCom[playerid][p_SelectGPU][1],
                PlayerSelectCom[playerid][p_SelectGPU][2],
                PlayerSelectCom[playerid][p_SelectGPU][3],
                PlayerSelectCom[playerid][p_SelectGPU][4],
                PlayerSelectCom[playerid][p_SelectStored]
                );
            mysql_tquery(dbCon, query, "OnplayerBuyComputerSucess", "dddddddddd", playerid, idx,  CPU, GPU1, GPU2, GPU3, GPU4, GPU5, RAM, Stored);
            return 1;

        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_CPU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);

    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 4290;
            PlayerSelectCom[playerid][p_SelectCPU] = 1;
            SendClientMessage(playerid, COLOR_GREY, "�س�����͡�� CPU Intel Core "EMBED_LIGHTBLUE"I3");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 5890;
            PlayerSelectCom[playerid][p_SelectCPU] = 2;
            SendClientMessage(playerid, COLOR_GREY, "�س�����͡�� CPU Intel Core "EMBED_LIGHTBLUE"I5");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 13500;
            PlayerSelectCom[playerid][p_SelectCPU] = 3;
            SendClientMessage(playerid, COLOR_GREY, "�س�����͡�� CPU Intel Core "EMBED_LIGHTBLUE"I7");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 20900;
            PlayerSelectCom[playerid][p_SelectCPU] = 4;
            SendClientMessage(playerid, COLOR_GREY, "�س�����͡�� CPU Intel Core "EMBED_LIGHTBLUE"I9");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_GPU_SLOT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);

    new slotid = PlayerSelectSlot[playerid];

    if(PlayerSelectCom[playerid][p_SelectGPU][slotid])
    {
        SendErrorMessage(playerid, "�����͡ GPU Slot %d ����", slotid+1);
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
    }

    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 1;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ���Ҵ�� ���͵��� %d �� %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 9900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 2;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ���Ҵ�� ���͵��� %d �� %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 16900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 3;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ���Ҵ�� ���͵��� %d �� %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 23900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 5;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ���Ҵ�� ���͵��� %d �� %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 45390;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 5;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ���Ҵ�� ���͵��� %d �� %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 55900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_RAM(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
    
    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 8;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ��� �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 1770;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 16;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ��� �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 2700;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 32;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ��� �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 6250;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 64;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ��� �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 17800;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 128;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ ��� �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 30500;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_STORED(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
    
    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 120;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ SSD �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 850;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 256;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ SSD �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 1470;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 480;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ SSD �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 1950;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 500;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ SSD �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 2150;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 1000;
            SendClientMessageEx(playerid, COLOR_GREY, "�س�����͡ SSD �� %s", ReturnRam(playerid));
            PlayerSelectCom[playerid][p_SelePrice]+= 3350;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
    }
    return 1;
}

stock ClearSelectBuyComputer(playerid)
{
    PlayerSelectCom[playerid][p_SelectCPU] = 0;
    PlayerSelectCom[playerid][p_SelectGPU][0] = 0;
    PlayerSelectCom[playerid][p_SelectGPU][1] = 0;
    PlayerSelectCom[playerid][p_SelectGPU][2] = 0;
    PlayerSelectCom[playerid][p_SelectGPU][3] = 0;
    PlayerSelectCom[playerid][p_SelectGPU][4] = 0;
    PlayerSelectCom[playerid][p_SelectRAM] = 0;
    PlayerSelectCom[playerid][p_SelectStored] = 0;
    PlayerSelectCom[playerid][p_SelePrice] = 0; 
    return 1;
}

stock IsPlayerNearComputer(playerid)
{
    for(new i = 1; i < MAX_COMPUTER; i++)
    {
        if(!ComputerInfo[i][ComputerDBID])
            continue;
        
        if(!ComputerInfo[i][ComputerSpawn])
            continue;
        
        
        if(IsPlayerInRangeOfPoint(playerid, 2.0, ComputerInfo[i][ComputerPos][0], ComputerInfo[i][ComputerPos][1], ComputerInfo[i][ComputerPos][2]))
            return i;

        else  return 0;
    }

    return 0;
}


forward OnplayerBuyComputerSucess(playerid, newid, CPU, GPU1, GPU2, GPU3, GPU4, GPU5, RAM, Stored);
public OnplayerBuyComputerSucess(playerid, newid, CPU, GPU1, GPU2, GPU3, GPU4, GPU5, RAM, Stored)
{

    ComputerInfo[newid][ComputerDBID] = newid;
    ComputerInfo[newid][ComputerOwnerDBID] = PlayerInfo[playerid][pDBID];
    ComputerInfo[newid][ComputerOn] = false;
    ComputerInfo[newid][ComputerSpawn] = false;
    ComputerInfo[newid][ComputerCPU] = CPU;
    ComputerInfo[newid][ComputerGPU][0] = GPU1;
    ComputerInfo[newid][ComputerGPU][1] = GPU2;
    ComputerInfo[newid][ComputerGPU][2] = GPU3;
    ComputerInfo[newid][ComputerGPU][3] = GPU4;
    ComputerInfo[newid][ComputerGPU][4] = GPU5;
    ComputerInfo[newid][ComputerRAM] = RAM;
    ComputerInfo[newid][ComputerStored] = Stored;

    SendClientMessageEx(playerid, -1, "�س����ͤ�����º�������� %d ",newid);
    return 1;
}



#include <YSI_Coding\y_hooks>

hook OnGameModeInit@15()
{
    mysql_tquery(dbCon, "SELECT * FROM computer ORDER BY ComputerDBID", "LoadComputer");
    return 1;
}

enum P_SELECT_COMPUTER
{
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
        cache_get_value_name_int(i,"ComputerPosX",ComputerInfo[i+1][ComputerPos][0]);
        cache_get_value_name_int(i,"ComputerPosY",ComputerInfo[i+1][ComputerPos][1]);
        cache_get_value_name_int(i,"ComputerPosZ",ComputerInfo[i+1][ComputerPos][2]);
        cache_get_value_name_int(i,"ComputerPosRX",ComputerInfo[i+1][ComputerPos][3]);
        cache_get_value_name_int(i,"ComputerPosRY",ComputerInfo[i+1][ComputerPos][4]);
        cache_get_value_name_int(i,"ComputerPosRZ",ComputerInfo[i+1][ComputerPos][5]);

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
    else format(str_sec, sizeof(str_sec), "ไม่มี");

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
    else format(str_sec, sizeof(str_sec), "ไม่มี");

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
    else format(str_sec, sizeof(str_sec), "ไม่มี");

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

stock ShowPlayerComputerSpec(playerid)
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
        format(str, sizeof(str), ""EMBED_GREENMONEY"[ ! ]ยืนยันการซื้อ: %s\n", MoneyFormat(PlayerSelectCom[playerid][p_SelePrice]));
        strcat(longstr, str);
    }

    Dialog_Show(playerid, D_BUYCOMPUTER, DIALOG_STYLE_LIST, "Computer Spec", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

CMD:buycomputer(playerid, params[])
{
    ShowPlayerComputerSpec(playerid);
    return 1;
}

Dialog:D_BUYCOMPUTER(playerid, response, listitem, inputtext[])
{
    if(!response)
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

    switch(listitem)
    {
        case 0:
        {
            if(PlayerSelectCom[playerid][p_SelectCPU])
            {
                SendErrorMessage(playerid, "คุณได้เลือก CPU แล้ว");
                return ShowPlayerComputerSpec(playerid);
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
            Dialog_Show(playerid, D_BUYCOMPUTER_CPU, DIALOG_STYLE_LIST, "เลือก CPU", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 1:
        {
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
            PlayerSelectSlot[playerid] = 0;

            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 1", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 2:
        {
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
            PlayerSelectSlot[playerid] = 1;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 2", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 3:
        {
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
            PlayerSelectSlot[playerid] = 2;
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 3", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 4:
        {
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
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 4", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 5:
        {
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
            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 5", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 6:
        {
            new str[255], longstr[255];

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

            Dialog_Show(playerid, D_BUYCOMPUTER_RAM, DIALOG_STYLE_LIST, "เลือก RAM", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 7:
        {
            new str[255], longstr[255];

            format(str, sizeof(str), "SSD 120 GB $\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 256 GB $\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 480 GB $\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 500 GB $\n");
            strcat(longstr, str);
            format(str, sizeof(str), "SSD 1 TB $\n");
            strcat(longstr, str);

            Dialog_Show(playerid, D_BUYCOMPUTER_RAM, DIALOG_STYLE_LIST, "เลือก Stored", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_CPU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid);

    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 4290;
            PlayerSelectCom[playerid][p_SelectCPU] = 1;
            SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I3");
            return ShowPlayerComputerSpec(playerid);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 5890;
            PlayerSelectCom[playerid][p_SelectCPU] = 2;
            SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I5");
            return ShowPlayerComputerSpec(playerid);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 13500;
            PlayerSelectCom[playerid][p_SelectCPU] = 3;
            SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I7");
            return ShowPlayerComputerSpec(playerid);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 20900;
            PlayerSelectCom[playerid][p_SelectCPU] = 4;
            SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I9");
            return ShowPlayerComputerSpec(playerid);
        }
    }
    return 1;
}

Dialog:D_BUYCOMPUTER_GPU_SLOT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPlayerComputerSpec(playerid);

    new slotid = PlayerSelectSlot[playerid];

    if(PlayerSelectCom[playerid][p_SelectGPU][slotid])
    {
        SendErrorMessage(playerid, "ได้เลือก GPU Slot %d แล้ว", slotid);
        return ShowPlayerComputerSpec(playerid);
    }

    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 1;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUName(playerid, slotid));
            PlayerSelectCom[playerid][p_SelePrice]+= 9900;
            return 1;
        }
    }
    return 1;
}
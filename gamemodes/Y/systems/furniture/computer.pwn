#include <YSI_Coding\y_hooks>
#include <YSI\y_inline>

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
new PlayerSelectSlot[MAX_PLAYERS], PlayerOldComp[MAX_PLAYERS];


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
        cache_get_value_name_int(i,"ComputerHouseDBID",ComputerInfo[i+1][ComputerHouseDBID]);
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

        ComputerInfo[i+1][ComputerOn] = false;
        ComputerInfo[i+1][ComputerStartBTC] = false;
        ComputerInfo[i+1][ComputerOpen] = INVALID_PLAYER_ID;

        countcomputer++;
    }
    printf("[SERVER]: %i Computer were loaded from \"%s\" database...", countcomputer, MYSQL_DB);
    return 1;
}



stock ShowPlayerComputerSpec(playerid, option)
{
    if(option == 1)
    {
        new str[255], longstr[255];
    
        format(str, sizeof(str), "CPU: %s\n", ReturnCPUNames(PlayerSelectCom[playerid][p_SelectCPU]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 1: %s\n", ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][0]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 2: %s\n", ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][1]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 3: %s\n", ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][2]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 4: %s\n", ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][3]));
        strcat(longstr, str);
        format(str, sizeof(str), "GPU 5: %s\n", ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][4]));
        strcat(longstr, str);
        format(str, sizeof(str), "RAM: %s \n", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
        strcat(longstr, str);
        format(str, sizeof(str), "Stored: %s\n", ReturnStoreds(PlayerSelectCom[playerid][p_SelectStored]));
        strcat(longstr, str);

        if(PlayerSelectCom[playerid][p_SelePrice])
        {
            format(str, sizeof(str), ""EMBED_GREENMONEY"[ ! ]ยืนยันการซื้อ: %s\n", MoneyFormat(PlayerSelectCom[playerid][p_SelePrice]));
            strcat(longstr, str);
        }

        Dialog_Show(playerid, D_BUYCOMPUTER, DIALOG_STYLE_LIST, "Computer Spec", longstr, "ยืนยัน", "ยกเลิก");
    }
    else
    {
        new str[255], longstr[255];
    
        format(str, sizeof(str), "CPU: %s\n", ReturnCPUNames(PlayerInfo[playerid][pCPU] || PlayerSelectCom[playerid][p_SelectCPU]));
        strcat(longstr, str);

        format(str, sizeof(str), "GPU: %s\n", ReturnGPUNames(PlayerInfo[playerid][pGPU] || PlayerSelectCom[playerid][p_SelectGPU][0]));
        strcat(longstr, str);

        format(str, sizeof(str), "RAM: %s \n", ReturnRams(PlayerInfo[playerid][pRAM] || PlayerSelectCom[playerid][p_SelectRAM]));
        strcat(longstr, str);
        format(str, sizeof(str), "Stored: %s\n", ReturnStoreds(PlayerInfo[playerid][pStored] || PlayerSelectCom[playerid][p_SelectStored]));
        strcat(longstr, str);

        if(PlayerSelectCom[playerid][p_SelePrice])
        {
            format(str, sizeof(str), ""EMBED_GREENMONEY"[ ! ]ยืนยันการซื้อ: %s\n", MoneyFormat(PlayerSelectCom[playerid][p_SelePrice]));
            strcat(longstr, str);
        }

        return  Dialog_Show(playerid, D_BUYCOMPUTER_2, DIALOG_STYLE_LIST, "ซื้ออะไหล่", longstr, "ยืนยัน", "ยกเลิก");
    }

    return 1;
}

CMD:computerhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrp-lite.co___________");
    SendClientMessage(playerid, COLOR_GRAD2, "/buycomputer (ซื่อคอม)");
    SendClientMessage(playerid, COLOR_GRAD2, "/checkcom (ตรวจสอบคอมพิวเตอร์ในตัวคุณ)");
    SendClientMessage(playerid, COLOR_GRAD2, "/placecom (วางคอม)");
    SendClientMessage(playerid, COLOR_GRAD2, "/editcom (แก้ไข, pos, upgrade, get)");
    SendClientMessage(playerid, COLOR_GRAD2, "/checkcomputer (เช็คอะไหล่ภายในตัว)");
    SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
    SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");
    return 1;
}


CMD:checkcomputer(playerid, params[])
{
    inline D_CHECKCOMPUTER(id, dialogid, response, listitem, string:inputtext[])
	{
		#pragma unused id, dialogid, listitem, inputtext

        if(!response)
            return 1;
    
	}

    new str[255], longstr[255];

    format(str, sizeof(str), "CPU: %s\n",ReturnCPUNames(PlayerInfo[playerid][pCPU]));
    strcat(longstr, str);
    format(str, sizeof(str), "GPU: %s\n",ReturnCPUNames(PlayerInfo[playerid][pGPU]));
    strcat(longstr, str);
    format(str, sizeof(str), "RAM: %s\n",ReturnCPUNames(PlayerInfo[playerid][pRAM]));
    strcat(longstr, str);
    format(str, sizeof(str), "STORED: %s\n",ReturnCPUNames(PlayerInfo[playerid][pStored]));
    strcat(longstr, str);

	Dialog_ShowCallback(playerid, using inline D_CHECKCOMPUTER, DIALOG_STYLE_LIST, "อะไหล่คอมพิวเตอร์ภายในตัว", longstr, "ยืนยัน", "ยกเลิก");
    return 1;
}

CMD:buycomputer(playerid, params[])
{
    if(IsPlayerAndroid(playerid) == true)
        return SendErrorMessage(playerid, "ระบบนี้บนแพล็ตฟอร์มของคุณยังไม่รองรับ");
        
    if(!IsPlayerInRangeOfPoint(playerid, 3.5, 1098.4377,-1520.6367,22.7446))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในจุดที่จะซื้อคอมพิวเตอร์ หรือ แล็ปท็อป");

    Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "เลือกประเภทการซื้อขาย", "[ ! ] ซื้ออะไหล่\n[ ! ] ซื้อคอมเซ็ต", "ยืนยัน", "ยกเลิก");
    return 1;
}

CMD:opencom(playerid, params[])
{
    if(IsPlayerAndroid(playerid) == true)
        return SendErrorMessage(playerid, "ระบบนี้บนแพล็ตฟอร์มของคุณยังไม่รองรับ");

    if(!IsPlayerNearComputer(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ คอมพิวเตอร์ / แล็ปท็อป");

    new id = IsPlayerNearComputer(playerid), id_h = IsPlayerInHouse(playerid);

    if(id_h == 0)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในบ้าน");

    if(!HouseInfo[id_h][HouseSwicth])
        return SendErrorMessage(playerid, "คุณยังไม่ได้เปิด สวิทซ์ไฟภายในบ้าน");

    /*if(PlayerInfo[playerid][pGUI])
        return SendErrorMessage(playerid, "มีการใช้ UI อยู่");*/
    
    if(ComputerInfo[id][ComputerOpen] != INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "มีการเปิดใช้คอมพิวเตอร์จากผู้เล่นคนอื่นอยุ่");

    if(!ComputerInfo[id][ComputerCPU])
        return SendErrorMessage(playerid, "คุณไม่ได้มี "EMBED_LIGHTRED"CPU"EMBED_WHITE" อยู่ในเครื่องคอมพิวเตอร์ของคุณไม่สามารถเปิดคอมพิวเตอร์ได้");

    if(!ComputerInfo[id][ComputerRAM])
        return SendErrorMessage(playerid, "คุณไม่ได้มี "EMBED_LIGHTRED"RAM"EMBED_WHITE" อยู่ในเครื่องคอมพิวเตอร์ของคุณไม่สามารถเปิดคอมพิวเตอร์ได้");

    SendClientMessage(playerid, -1, "เปิดคอม......");
    
    if(ComputerInfo[id][ComputerOn])
    {
        LoadTD_Computer(playerid);
        ShowTD_Computer(playerid);
        ComputerInfo[id][ComputerOpen] = playerid;
        PlayerInfo[playerid][pGUI] = 3;
    }
    else
    {
        SetTimerEx("OpenComputer", 2000, false, "dd",playerid, id);
    }
    return 1;
}


forward OpenComputer(playerid, id);
public OpenComputer(playerid, id)
{
    ComputerInfo[id][ComputerOn] = true;
    ComputerInfo[id][ComputerOpen] = playerid;
    LoadTD_Computer(playerid);
    ShowTD_Computer(playerid);
    SendClientMessage(playerid, COLOR_DARKGREEN, "ระบบ Windows เริ่มต้น");
    PlayerInfo[playerid][pGUI] = 3;
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
        return Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "เลือกประเภทการซื้อขาย", "[ ! ] ซื้ออะไหล่\n[ ! ] ซื้อคอมเซ็ต", "ยืนยัน", "ยกเลิก");

    }

    switch(listitem)
    {
        case 0:
        {
            if(PlayerSelectCom[playerid][p_SelectCPU])
            {
                SendErrorMessage(playerid, "คุณได้เลือก CPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pCPU])
                return SendErrorMessage(playerid, "คุณมี ซีพียู อยู่ในตัว");


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

            if(PlayerSelectCom[playerid][p_SelectGPU][0])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pGPU])
                return SendErrorMessage(playerid, "คุณมี การ์ดจอ อยู่ในตัว");

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

            if(PlayerSelectCom[playerid][p_SelectRAM])
            {
                SendErrorMessage(playerid, "คุณได้เลือก แรม แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pRAM])
                return SendErrorMessage(playerid, "คุณมี แรม อยู่ในตัว");

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
        case 3:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectStored])
            {
                SendErrorMessage(playerid, "คุณได้เลือก SSD แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pStored])
                return SendErrorMessage(playerid, "คุณมี SSD อยู่ในตัว");

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

            Dialog_Show(playerid, D_BUYCOMPUTER_STORED, DIALOG_STYLE_LIST, "เลือก Stored", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 4:
        {
            new Price = PlayerSelectCom[playerid][p_SelePrice] - PlayerInfo[playerid][pCash];
            new money = PlayerSelectCom[playerid][p_SelePrice];

            if(PlayerSelectCom[playerid][p_SelePrice] > PlayerInfo[playerid][pCash])
            {
                ClearSelectBuyComputer(playerid);
                return SendClientMessageEx(playerid, COLOR_RED, "ERROR: "EMBED_WHITE"คุณมีเงินไมเพียงพอ (ยังขาดีอก $%s)",MoneyFormat(Price));
            }

            PlayerInfo[playerid][pCPU] = PlayerSelectCom[playerid][p_SelectCPU];
            PlayerInfo[playerid][pGPU] = PlayerSelectCom[playerid][p_SelectGPU];
            PlayerInfo[playerid][pRAM] = PlayerSelectCom[playerid][p_SelectRAM];
            PlayerInfo[playerid][pStored] = PlayerSelectCom[playerid][p_SelectStored];
            SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ซื้ออะไหล่คอมพิวเตอร์ ด้วยจำนวนเงิน $%s", MoneyFormat(money));
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
        return Dialog_Show(playerid, D_BUYCOMPUTER_LIST, DIALOG_STYLE_LIST, "เลือกประเภทการซื้อขาย", "[ ! ] ซื้ออะไหล่\n[ ! ] ซื้อคอมเซ็ต", "ยืนยัน", "ยกเลิก");

    }

    switch(listitem)
    {
        case 0:
        {
            if(PlayerSelectCom[playerid][p_SelectCPU])
            {
                SendErrorMessage(playerid, "คุณได้เลือก CPU แล้ว");
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
            Dialog_Show(playerid, D_BUYCOMPUTER_CPU, DIALOG_STYLE_LIST, "เลือก CPU", longstr, "เลือก", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][0])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
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

            Dialog_Show(playerid, D_BUYCOMPUTER_GPU_SLOT, DIALOG_STYLE_LIST, "เลือก GPU Slot 1", longstr, "เลือก", "ยกเลิก");
            return 1;
        }

        case 2:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectGPU][1])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pDonater] < 1)
                return SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Copper");


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

            if(PlayerSelectCom[playerid][p_SelectGPU][2])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pDonater] < 2)
                return SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Gold");

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
            if(PlayerSelectCom[playerid][p_SelectGPU][3])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pDonater] < 3)
                return SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Patinum");
                
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
            if(PlayerSelectCom[playerid][p_SelectGPU][4])
            {
                SendErrorMessage(playerid, "คุณได้เลือก GPU แล้ว");
                return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
            }

            if(PlayerInfo[playerid][pDonater] < 3)
                return SendErrorMessage(playerid, "คุณไม่ใช่ Donater ระดับ Patinum");
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

            if(PlayerSelectCom[playerid][p_SelectRAM])
            {
                SendErrorMessage(playerid, "คุณได้เลือก แรม แล้ว");
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

            Dialog_Show(playerid, D_BUYCOMPUTER_RAM, DIALOG_STYLE_LIST, "เลือก RAM", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 7:
        {
            new str[255], longstr[255];

            if(PlayerSelectCom[playerid][p_SelectStored])
            {
                SendErrorMessage(playerid, "คุณได้เลือก SSD แล้ว");
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

            Dialog_Show(playerid, D_BUYCOMPUTER_STORED, DIALOG_STYLE_LIST, "เลือก Stored", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 8:
        {
            new Price = PlayerSelectCom[playerid][p_SelePrice] - PlayerInfo[playerid][pCash];
            new money = PlayerSelectCom[playerid][p_SelePrice];

            if(PlayerInfo[playerid][pCash] < PlayerSelectCom[playerid][p_SelePrice])
            {
                ClearSelectBuyComputer(playerid);
                return SendClientMessageEx(playerid, COLOR_RED, "ERROR: "EMBED_WHITE"คุณมีเงินไมเพียงพอ (ยังขาดีอก $%s)",MoneyFormat(Price));
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
                return SendServerMessage(playerid, "ไม่สามารถมีคอมพิวเตอร์ในเซืฟได้มากกว่านี้แล้ว (100)"); 
            }


            SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ซื้อคอมพิวเตอร์ ด้วยจำนวนเงิน $%s", MoneyFormat(money));
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
                CPU,
                RAM,
                GPU1,
                GPU2,
                GPU3,
                GPU4,
                GPU5,
                Stored);
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
            SendClientMessage(playerid, COLOR_GREY, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I3");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 5890;
            PlayerSelectCom[playerid][p_SelectCPU] = 2;
            SendClientMessage(playerid, COLOR_GREY, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I5");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 13500;
            PlayerSelectCom[playerid][p_SelectCPU] = 3;
            SendClientMessage(playerid, COLOR_GREY, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I7");
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelePrice] += 20900;
            PlayerSelectCom[playerid][p_SelectCPU] = 4;
            SendClientMessage(playerid, COLOR_GREY, "คุณได้เลือกใช้ CPU Intel Core "EMBED_LIGHTBLUE"I9");
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
        SendErrorMessage(playerid, "ได้เลือก GPU Slot %d แล้ว", slotid+1);
        return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
    }

    switch(listitem)
    {
        case 0:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 1;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][slotid]));
            PlayerSelectCom[playerid][p_SelePrice]+= 9900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 2;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][slotid]));
            PlayerSelectCom[playerid][p_SelePrice]+= 16900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 3;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][slotid]));
            PlayerSelectCom[playerid][p_SelePrice]+= 23900;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 5;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][slotid]));
            PlayerSelectCom[playerid][p_SelePrice]+= 45390;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectGPU][slotid] = 5;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก กร์าดจอ สล็อตที่ %d เป็น %s", slotid+1, ReturnGPUNames(PlayerSelectCom[playerid][p_SelectGPU][slotid]));
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
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก แรม เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
            PlayerSelectCom[playerid][p_SelePrice]+= 1770;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 16;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก แรม เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
            PlayerSelectCom[playerid][p_SelePrice]+= 2700;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 32;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก แรม เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
            PlayerSelectCom[playerid][p_SelePrice]+= 6250;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 64;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก แรม เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
            PlayerSelectCom[playerid][p_SelePrice]+= 17800;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectRAM] = 128;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก แรม เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectRAM]));
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
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก SSD เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectStored]));
            PlayerSelectCom[playerid][p_SelePrice]+= 850;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 1:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 256;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก SSD เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectStored]));
            PlayerSelectCom[playerid][p_SelePrice]+= 1470;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 2:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 480;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก SSD เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectStored]));
            PlayerSelectCom[playerid][p_SelePrice]+= 1950;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 3:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 500;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก SSD เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectStored]));
            PlayerSelectCom[playerid][p_SelePrice]+= 2150;
            return ShowPlayerComputerSpec(playerid, PlayerSelectCom[playerid][p_SelectOption]);
        }
        case 4:
        {
            PlayerSelectCom[playerid][p_SelectStored] = 1000;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้เลือก SSD เป็น %s", ReturnRams(PlayerSelectCom[playerid][p_SelectStored]));
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
        
        if(ComputerInfo[i][ComputerPosWorld] != GetPlayerVirtualWorld(playerid))
            continue;

        if(ComputerInfo[i][ComputerPosInterior] != GetPlayerInterior(playerid))
            continue;
        
        if(IsPlayerInRangeOfPoint(playerid, 2.0, ComputerInfo[i][ComputerPos][0], ComputerInfo[i][ComputerPos][1], ComputerInfo[i][ComputerPos][2]))
            return i;
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
    ComputerInfo[newid][ComputerOpen] = INVALID_PLAYER_ID;

    SendClientMessageEx(playerid, -1, "คุณได้ซื้อคอมเรียบร้อยแล้ว %d ",newid);
    return 1;
}




stock ReturnCPUNames(type)
{
    new str_sec[255];

    if(type != 0)
    {
        switch(type)
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


stock ReturnGPUNames(type)
{
    new str_sec[255];

    if(type)
    {
        switch(type)
        {
            case 1: format(str_sec, sizeof(str_sec), "GTX 1650");
            case 2: format(str_sec, sizeof(str_sec), "RTX 2060");
            case 3: format(str_sec, sizeof(str_sec), "RTX 2070");
            case 4: format(str_sec, sizeof(str_sec), "RTX 2080");
            case 5: format(str_sec, sizeof(str_sec), "RTX 2090");
        }
    }
    else format(str_sec, sizeof(str_sec), "NONE");

    return str_sec;
}

stock ReturnRams(type)
{
    new str_sec[255];

    if(type)
    {
        switch(type)
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


stock ReturnStoreds(type)
{
    new str_sec[255];

    if(type)
    {
        switch(type)
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


#include <YSI_Coding\y_hooks>
new PlayerSelectHouse[MAX_PLAYERS];
new OnPlayerNereHouse[MAX_PLAYERS][MAX_HOUSE];


new PlayerText:PlayerSwicthOff[MAX_PLAYERS][1];


hook OnPlayerConnect(playerid)
{
    PlayerSwicthOff[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 2.000000, "_");
	PlayerTextDrawFont(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSwicthOff[playerid][0], 0.600000, 48.999988);
	PlayerTextDrawTextSize(playerid, PlayerSwicthOff[playerid][0], 1920.500000, 1080.500000);
	PlayerTextDrawSetOutline(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerSwicthOff[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PlayerSwicthOff[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerSwicthOff[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSwicthOff[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerSwicthOff[playerid][0], 225);
	PlayerTextDrawUseBox(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSwicthOff[playerid][0], 0);
    return 1;
}


forward Query_LoadHouse();
public Query_LoadHouse()
{
    if(!cache_num_rows())
		return printf("[SERVER]: No House were loaded from \"%s\" database...", MYSQL_DB);

    new rows,countHouse,str[MAX_STRING]; cache_get_row_count(rows);

    for (new i = 0; i < rows && i < MAX_HOUSE; i ++)
    {
        cache_get_value_name_int(i,"HouseDBID",HouseInfo[i+1][HouseDBID]);
        cache_get_value_name(i,"HouseName",HouseInfo[i+1][HouseName],90);
        cache_get_value_name_int(i,"HouseOwnerDBID",HouseInfo[i+1][HouseOwnerDBID]);


        cache_get_value_name_float(i,"HouseEntranceX",HouseInfo[i+1][HouseEntrance][0]);
        cache_get_value_name_float(i,"HouseEntranceY",HouseInfo[i+1][HouseEntrance][1]);
        cache_get_value_name_float(i,"HouseEntranceZ",HouseInfo[i+1][HouseEntrance][2]);
        cache_get_value_name_int(i,"HouseEntranceWorld",HouseInfo[i+1][HouseEntranceWorld]);
        cache_get_value_name_int(i,"HouseEntranceInterior",HouseInfo[i+1][HouseEntranceInterior]);

        cache_get_value_name_float(i,"HouseInteriorX",HouseInfo[i+1][HouseInterior][0]);
        cache_get_value_name_float(i,"HouseInteriorY",HouseInfo[i+1][HouseInterior][1]);
        cache_get_value_name_float(i,"HouseInteriorZ",HouseInfo[i+1][HouseInterior][2]);
        cache_get_value_name_int(i,"HouseInteriorWorld",HouseInfo[i+1][HouseInteriorWorld]);
        cache_get_value_name_int(i,"HouseInteriorID",HouseInfo[i+1][HouseInteriorID]);

        cache_get_value_name_int(i,"HousePrice",HouseInfo[i+1][HousePrice]);
        cache_get_value_name_int(i,"HouseLevel",HouseInfo[i+1][HouseLevel]);
        cache_get_value_name_int(i,"HouseLock",HouseInfo[i+1][HouseLock]);

        cache_get_value_name_int(i,"HouseStockCPU",HouseInfo[i+1][HouseStockCPU]);
        cache_get_value_name_int(i,"HouseStockGPU",HouseInfo[i+1][HouseStockGPU]);
        cache_get_value_name_int(i,"HouseStockRAM",HouseInfo[i+1][HouseStockRAM]);
        cache_get_value_name_int(i,"HouseStockStored",HouseInfo[i+1][HouseStockStored]);

        cache_get_value_name_int(i,"HousePrice",HouseInfo[i+1][HousePrice]);
        cache_get_value_name_int(i,"HouseLevel",HouseInfo[i+1][HouseLevel]);
        cache_get_value_name_int(i,"HouseLock",HouseInfo[i+1][HouseLock]);

        cache_get_value_name_float(i,"HouseDrug1",HouseInfo[i+1][HouseDrug][0]);
        cache_get_value_name_float(i,"HouseDrug2",HouseInfo[i+1][HouseDrug][1]);
        cache_get_value_name_float(i,"HouseDrug3",HouseInfo[i+1][HouseDrug][2]);
        
        cache_get_value_name_int(i,"HouseRentStats",HouseInfo[i+1][HouseRentStats]);
        cache_get_value_name_int(i,"HouseRent",HouseInfo[i+1][HouseRent]);
        cache_get_value_name_int(i,"HouseRentPrice",HouseInfo[i+1][HouseRentPrice]);

        cache_get_value_name_int(i,"HouseEle",HouseInfo[i+1][HouseEle]);


        cache_get_value_name_float(i,"HousePlacePosX",HouseInfo[i+1][HousePlacePos][0]);
        cache_get_value_name_float(i,"HousePlacePosY",HouseInfo[i+1][HousePlacePos][1]);
        cache_get_value_name_float(i,"HousePlacePosZ",HouseInfo[i+1][HousePlacePos][2]);

        for(new w = 1; w < 22; w++)
        {
            format(str, sizeof(str), "HouseWeapons%i",w);
            cache_get_value_name_int(i,str,HouseInfo[i+1][HouseWeapons][w]);
        }
        for(new wa = 1; wa < 22; wa++)
        {
            format(str, sizeof(str), "HouseWeaponsAmmo%i",wa);
            cache_get_value_name_int(i,str,HouseInfo[i+1][HouseWeaponsAmmo][wa]);
        }

        if(IsValidDynamicPickup(HouseInfo[i+1][HousePickup]))
            DestroyDynamicPickup(HouseInfo[i+1][HousePickup]);


        DestroyDynamicArea(HouseInfo[i+1][HouseAreaID]);
        HouseInfo[i+1][HouseAreaID] = CreateDynamicSphere(HouseInfo[i+1][HouseInterior][0], HouseInfo[i+1][HouseInterior][1], HouseInfo[i+1][HouseInterior][2], 3.0, HouseInfo[i+1][HouseInteriorWorld], HouseInfo[i+1][HouseInteriorID]); // The house interior.	
		Streamer_SetIntData(STREAMER_TYPE_AREA, HouseInfo[i+1][HouseAreaID], E_STREAMER_EXTRA_ID, i+1);

        countHouse++;

        HouseInfo[i+1][HouseSwicth] = false;
        
    }

	printf("[SERVER]: %i House were loaded from \"%s\" database...", countHouse, MYSQL_DB);
    return 1;
}


forward MakeHouse(playerid, price, level, name[]);
public MakeHouse(playerid, price, level, name[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new idx = 0;
	
    for (new i = 1; i < MAX_HOUSE; i ++)
    {
        if(!HouseInfo[i][HouseDBID])
        {
            idx = i; 
            break;
        }
    }
    if(idx == 0)
    {
        return SendServerMessage(playerid, "สร้าบบ้านเกินกว่านี้ไม่ได้แล้ว (300)"); 
    }


    
    HouseInfo[idx][HouseDBID] = cache_insert_id();

    if(!HouseInfo[idx][HouseDBID])
        return SendErrorMessage(playerid, "มีข้อผิดพลาดในการสร้างบ้านโปรดตรวจสอบที่ตัวสคลิปต์ด้วย");


    format(HouseInfo[idx][HouseName], 90, "%s",name);
    HouseInfo[idx][HouseEntrance][0] = x;
    HouseInfo[idx][HouseEntrance][1] = y;
    HouseInfo[idx][HouseEntrance][2] = z;
    HouseInfo[idx][HouseEntranceWorld] = GetPlayerVirtualWorld(playerid);
    HouseInfo[idx][HouseEntranceInterior] = GetPlayerInterior(playerid);

    HouseInfo[idx][HousePrice] = price;
    HouseInfo[idx][HouseLevel] = level;

    HouseInfo[idx][HouseInterior][0] = 244.411987;
	HouseInfo[idx][HouseInterior][1] = 305.032989;
	HouseInfo[idx][HouseInterior][2] = 999.148437;
    HouseInfo[idx][HouseInteriorID] = 1;
    HouseInfo[idx][HouseInteriorWorld] = random(99999);
    Savehouse(idx);


    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้สร้างบ้านสำเร็จแล้ว %d(%s)", HouseInfo[idx][HouseDBID], HouseInfo[idx][HouseName]);
    SendDiscordMessageEx("admin-log", "[%s] %s Create Property(House) At %s Property name: %s",  ReturnDate(), ReturnRealName(playerid), ReturnLocation(playerid), name);
    return 1;
}


stock ShowSelectHouse(playerid)
{
    new str[MAX_STRING];

    new id = PlayerSelectHouse[playerid];

    new HouseNames[96];

    format(HouseNames, sizeof(HouseNames), "HOUSE: %s",HouseInfo[id][HouseName]);

    format(str, sizeof(str), "ไอดีบ้าน: %i\n\
                              ชื่อบ้าน:  %s\n\
                              ราคา:    %s\n\
                              เลเวล:   %i\n\
                              จุดหน้าบ้าน\n\
                              จุดภายใน\n",HouseInfo[id][HouseDBID],HouseInfo[id][HouseName],MoneyFormat(HouseInfo[id][HousePrice]),HouseInfo[id][HouseLevel]);

    Dialog_Show(playerid, DIALOG_SELETE_HOUSE, DIALOG_STYLE_LIST, HouseNames, str, "ยินยัน", "ยกเลิก",HouseInfo[id][HouseName]);

    return 1;
}

Dialog:DIALOG_VIEWHOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendClientMessage(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{FF0000} ยกเลิกกาแก้ไขบ้าน");
    
    new str_h[MAX_STRING], str[MAX_STRING];
    format(str_h, sizeof(str_h), "%d",listitem);

    new id = GetPVarInt(playerid, str_h);
    PlayerSelectHouse[playerid] = id;


    if(!HouseInfo[id][HouseDBID] || id > MAX_HOUSE)
        return 1;

    new HouseNames[96];
    format(HouseNames, sizeof(HouseNames), "HOUSE: %s",HouseInfo[id][HouseName]);

    format(str, sizeof(str), "ไอดีบ้าน: %i\n\
                              ชื่อบ้าน:  %s\n\
                              ราคา:    %s\n\
                              เลเวล:   %i\n\
                              จุดหน้าบ้าน\n\
                              จุดภายใน\n",HouseInfo[id][HouseDBID],HouseInfo[id][HouseName],MoneyFormat(HouseInfo[id][HousePrice]),HouseInfo[id][HouseLevel]);

    Dialog_Show(playerid, DIALOG_SELETE_HOUSE, DIALOG_STYLE_LIST, HouseNames, str, "ยินยัน", "ยกเลิก",HouseInfo[id][HouseName]);
    return 1;
}

Dialog:DIALOG_SELETE_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    else
    {
        switch(listitem)
        {
            case 0: return ShowSelectHouse(playerid);
            case 1:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_NAME, DIALOG_STYLE_INPUT, "ใส่ชื่อใหม่ของบ้าน", "เปลี่ยนชื่อบ้านหลังนี้:", "ยืนยัน", "ยกเลิก");
            }
            case 2:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_PRICE, DIALOG_STYLE_INPUT, "ใส่ราคาใหม่ของบ้าน", "เเปลี่ยนราคาของบ้านหลังนี้:", "ยืนยัน", "ยกเลิก");
            }
            case 3:
            {
                return Dialog_Show(playerid, DIALOG_HOUSE_LEVEL, DIALOG_STYLE_INPUT, "ใส่เลเวลใหม่ของบ้าน", "เเปลี่ยนเลเวลของบ้านหลังนี้:", "ยืนยัน", "ยกเลิก");
            }
            case 4:
            {
                new id = PlayerSelectHouse[playerid],Float:X,Float:Y,Float:Z;
                GetPlayerPos(playerid,X,Y,Z);

                HouseInfo[id][HouseEntrance][0] = X;
                HouseInfo[id][HouseEntrance][1] = Y;
                HouseInfo[id][HouseEntrance][2] = Z;
                HouseInfo[id][HouseEntranceWorld] = GetPlayerVirtualWorld(playerid);
                HouseInfo[id][HouseEntranceInterior] = GetPlayerInterior(playerid);

                Savehouse(id);


                if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
                    DestroyDynamicPickup(HouseInfo[id][HousePickup]);
        
                /*if(HouseInfo[id][HouseOwnerDBID])
                {
                    HouseInfo[id][HousePickup] = CreateDynamicPickup(1272, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);
                }
                else
                {
                    HouseInfo[id][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);
                }*/
            }
            case 5:
            {
                new id = PlayerSelectHouse[playerid],Float:X,Float:Y,Float:Z;
                GetPlayerPos(playerid,X,Y,Z);

                HouseInfo[id][HouseInterior][0] = X;
                HouseInfo[id][HouseInterior][1] = Y;
                HouseInfo[id][HouseInterior][2] = Z;
                
                HouseInfo[id][HouseInteriorID] = GetPlayerInterior(playerid);

                if(GetPlayerVirtualWorld(playerid) != 0)
                {
                    HouseInfo[id][HouseInteriorWorld] = GetPlayerVirtualWorld(playerid);
                }
                else
                {
                    HouseInfo[id][HouseInteriorWorld] = random(9000);
                }


                foreach(new i : Player)
                {
                    if(PlayerInfo[i][pInsideProperty] != id)
                        continue;

                    SetPlayerPos(i,HouseInfo[id][HouseInterior][0],HouseInfo[id][HouseInterior][1],HouseInfo[id][HouseInterior][2]);
                    SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseInteriorWorld]);
                    SetPlayerInterior(playerid, HouseInfo[id][HouseInteriorID]);
                    SendServerMessage(i,"ขออภัยในความไม่สดวกเนื่องจากมีการเปลี่ยนแปลง ภายใน(Interior) อย่างกระทันหันจึงจำเป็นที่ต้องเคลื่อนย้ายตัวละครที่ท่านเล่นอยู่น  ณ ขณะนี้ไปที่ Interior");
                    SendServerMessage(i,"....ใหม่");
                }
                Savehouse(id);
            }
        }
    }
    return ShowSelectHouse(playerid);
}

Dialog:DIALOG_HOUSE_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowSelectHouse(playerid);
    
    if(strlen(inputtext) > 90 || strlen(inputtext) < 3)
    {   
        SendClientMessage(playerid,COLOR_RED,"ใส่ชื่อไม่ถูกต้อง");
        return ShowSelectHouse(playerid);
    }

        
    new id = PlayerSelectHouse[playerid];

    format(HouseInfo[id][HouseName], 90, "%s", inputtext);
    Savehouse(id);

    ShowSelectHouse(playerid);

    return 1;
}

Dialog:DIALOG_HOUSE_PRICE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    else
    {
        if(strlen(inputtext) > 90000000 || strlen(inputtext) < 1)
        {   
            SendClientMessage(playerid,COLOR_RED,"ใส่เลขไม่ถูกต้อง");
            return ShowSelectHouse(playerid);
        }

        new price = strval(inputtext);

        if(price < 1 || price > 90000000)
        {   
            SendClientMessage(playerid,COLOR_RED,"ใส่เลขไม่ถูกต้อง");
            return ShowSelectHouse(playerid);
        }

        new id = PlayerSelectHouse[playerid];

        HouseInfo[id][HousePrice] = price;
        Savehouse(id);
    }
    return ShowSelectHouse(playerid);
}

Dialog:DIALOG_HOUSE_LEVEL(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    else
    {
        if(strlen(inputtext) > 90000000 || strlen(inputtext) < 1)
        {   
            SendClientMessage(playerid,COLOR_RED,"ใส่เลขไม่ถูกต้อง");
            return ShowSelectHouse(playerid);
        }

        new Level = strval(inputtext);

        if(Level < 1 || Level > 90000000)
        {   
            SendClientMessage(playerid,COLOR_RED,"ใส่เลขไม่ถูกต้อง");
            return ShowSelectHouse(playerid);
        }

        new id = PlayerSelectHouse[playerid];

        HouseInfo[id][HouseLevel] = Level;
        Savehouse(id);
    }
    return ShowSelectHouse(playerid);
}


forward OnPlayerEnterProperty(playerid,id);
public OnPlayerEnterProperty(playerid,id)
{
	SetPlayerPos(playerid, HouseInfo[id][HouseInterior][0], HouseInfo[id][HouseInterior][1], HouseInfo[id][HouseInterior][2]);
    
    SetHouseOffSwitch(playerid);
    if(!HouseInfo[id][HouseSwicth])
    {
        PlayerTextDrawShow(playerid, PlayerSwicthOff[playerid][0]);
    }
    else
    {
        PlayerTextDrawDestroy(playerid, PlayerSwicthOff[playerid][0]);
    }
    
    return TogglePlayerControllable(playerid, 1);
}

stock SetHouseOffSwitch(playerid)
{
    PlayerSwicthOff[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 2.000000, "_");
	PlayerTextDrawFont(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, PlayerSwicthOff[playerid][0], 0.600000, 48.999988);
	PlayerTextDrawTextSize(playerid, PlayerSwicthOff[playerid][0], 1920.500000, 1080.500000);
	PlayerTextDrawSetOutline(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PlayerSwicthOff[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PlayerSwicthOff[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerSwicthOff[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSwicthOff[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PlayerSwicthOff[playerid][0], 225);
	PlayerTextDrawUseBox(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerSwicthOff[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSwicthOff[playerid][0], 0);
    return 1;
}


forward HouseElectricitybill(id);
public HouseElectricitybill(id)
{
    new ele, idx, result;

    if(!HouseInfo[id][HouseSwicth])
        return 1;

    if(!HouseInfo[id][HouseOwnerDBID])
        return 1;

    for(new c = 1; c < sizeof(ComputerInfo); c++)
    {
        if(!ComputerInfo[c][ComputerDBID])
            continue;

        if(ComputerInfo[c][ComputerHouseDBID] != HouseInfo[id][HouseDBID])
            continue;

        if(ComputerInfo[c][ComputerOn] == true)
        {
            idx = c;
            break;
        }
    }

    result = ComputerInfo[idx][ComputerCPU] + ComputerInfo[idx][ComputerGPU][0] + ComputerInfo[idx][ComputerGPU][1] + ComputerInfo[idx][ComputerGPU][2] + ComputerInfo[idx][ComputerGPU][3] + ComputerInfo[idx][ComputerGPU][4];

    if(ComputerInfo[idx][ComputerStartBTC])
    {
        HouseInfo[id][HouseEle] += result *2;
    }
    else
    {
        HouseInfo[id][HouseEle] += result;
    }
        
    ele = Random(1, 5);
    HouseInfo[id][HouseEle] += ele;

    if(HouseInfo[id][HouseEle] * 7 >=  10000)
    {
        new Owner;
        foreach(new i : Player)
        {
            if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[i][pDBID])
                continue;

            Owner = i;
            break;
        }

        if(IsPlayerConnected(Owner))
        {
            GiveMoney(Owner, -HouseInfo[id][HouseEle] * 7 / 2);
            CharacterSave(Owner);
            SendClientMessageEx(Owner, COLOR_LIGHTRED, "คุณไมได้จ่ายค่าไฟบ้าน เราจำเป็นต้องตัดเงินของคุณ $%s ซึ่งเป็นครึ่งนึงของบิลค่าไฟ",MoneyFormat(HouseInfo[id][HouseEle] * 7 / 2));
            HouseInfo[id][HouseEle] -= HouseInfo[id][HouseEle] / 2;
        }
    }
    //printf("คุณเปิดไฟที่บ้านทิ้งเอาไว้ ค่าไฟในบ้าน %s เพิ่มขึ้น %d หน่วย เป็น %d", HouseInfo[id][HouseName], ele + result, HouseInfo[id][HouseEle]);
    Savehouse(id);
    return 1;

}


forward OnPlayerNereHouseTime();
public OnPlayerNereHouseTime()
{

    foreach(new i : Player)
    {
        if(!BitFlag_Get(gPlayerBitFlag[i], IS_LOGGED))
            continue;
        
        for(new p = 1; p < MAX_HOUSE; p++)
		{
            if(!HouseInfo[p][HouseDBID])
				continue;
            
            if(IsPlayerInRangeOfPoint(i, 3.0, HouseInfo[p][HouseEntrance][0], HouseInfo[p][HouseEntrance][1], HouseInfo[p][HouseEntrance][2]))
            {
                if(gettime() - OnPlayerNereHouse[i][p] < 300)
                    continue;
                
                if(GetPlayerInterior(i) != HouseInfo[p][HouseEntranceInterior])
					continue;
					
				if(GetPlayerVirtualWorld(i) != HouseInfo[p][HouseEntranceWorld])
					continue;
                
                if(HouseInfo[p][HouseOwnerDBID])
                {
                    SendClientMessageEx(i,COLOR_DARKGREEN,"%d %s, Los Santos, San Andreas", p,HouseInfo[p][HouseName]);
                    SendClientMessage(i,-1,"Available commands: /enter, /ds(hout), /ddo, /knock");
                    if(HouseInfo[p][HouseRentStats])
                    {
                        SendClientMessageEx(i,-1,"RentHouse commands: /renthouse ในราคา $%s", MoneyFormat(HouseInfo[p][HouseRentPrice]));
                    }
                    OnPlayerNereHouse[i][p] = gettime();
                }
                else
                {
                    SendClientMessageEx(i,COLOR_DARKGREEN,"%d %s, Los Santos, San Andreas", p,HouseInfo[p][HouseName]);
                    SendClientMessageEx(i,-1,"ราคา: $%s เลเวล: %d", MoneyFormat(HouseInfo[p][HousePrice]), HouseInfo[p][HouseLevel]);
                    OnPlayerNereHouse[i][p] = gettime();
                }
            }
            else
            {
                OnPlayerNereHouse[i][p] = 0;
            }
        }
    }
    return 1;
}


stock CountPlayerProperties(playerid)
{
	new
		count = 0
	;

	for(new i = 1; i < MAX_HOUSE; i++)
	{
		if(!HouseInfo[i][HouseDBID])
			continue;
			
		if(HouseInfo[i][HouseOwnerDBID] == PlayerInfo[playerid][pDBID])
			count++; 
	}
	return count; 
}

Dialog:DIALOG_SELL_HOUSE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(response)
    {
        new id = PlayerInfo[playerid][pInsideProperty];

        if(id == 0)
            return 1;

        if(HouseInfo[id][HouseOwnerDBID] != PlayerInfo[playerid][pDBID])
            return SendClientMessage(playerid, -1,"คุณไม่ใช่เจ้าของบ้าน");
        
        new Money = HouseInfo[id][HousePrice] / 2;

        new bill = HouseInfo[id][HouseEle];
        HouseInfo[id][HouseOwnerDBID] = 0;
        HouseInfo[id][HouseLock] = true;

        for(new w = 1; w < 22; w++)
        {
            HouseInfo[id][HouseWeapons][w] = 0;
            HouseInfo[id][HouseWeaponsAmmo][w] = 0;
        }

        for(new pos = 0; pos < 3; pos++)
        {
            HouseInfo[id][HousePlacePos][pos] = 0;
        }

        GiveMoney(playerid, Money);
        GiveMoney(playerid, -bill*7);
        SetPlayerPos(playerid,HouseInfo[id][HouseEntrance][0],HouseInfo[id][HouseEntrance][1],HouseInfo[id][HouseEntrance][2]);
        SetPlayerVirtualWorld(playerid, HouseInfo[id][HouseEntranceWorld]);
        SetPlayerInterior(playerid, HouseInfo[id][HouseEntranceInterior]);
        HouseInfo[id][HouseSwicth] = false;
        SetHouseOffSwitch(playerid);
        PlayerTextDrawDestroy(playerid, PlayerSwicthOff[playerid][0]);


        if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
            DestroyDynamicPickup(HouseInfo[id][HousePickup]);

        //HouseInfo[id][HousePickup] = CreateDynamicPickup(1273, 23, HouseInfo[id][HouseEntrance][0], HouseInfo[id][HouseEntrance][1], HouseInfo[id][HouseEntrance][2],-1,-1);

        SendClientMessageEx(playerid,-1,"{27AE60}HOUSE {F39C12}SYSTEM:{009933} คุณได้ขายบ้านของคุณแล้วได้เงินมาจำนวน %s",MoneyFormat(Money));
        SendClientMessageEx(playerid, -1, "{27AE60}HOUSE {F39C12}SYSTEM:{009933} คุณมีบิลค่าไฟที่ค้างไว้อยู่เราได้ทำการหักหนี้บิลไฟฟ้าของคุณจำนวน $%s",MoneyFormat(bill));
        Savehouse(id);
        return 1;
    }
    return 1;
}


stock IsPlayerNearHouse(playerid)
{
	for(new i = 1; i < MAX_HOUSE; i++)
	{
		if(!HouseInfo[i][HouseDBID])
			continue; 
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[i][HouseEntrance][0], HouseInfo[i][HouseEntrance][1], HouseInfo[i][HouseEntrance][2]) && GetPlayerVirtualWorld(playerid) == HouseInfo[i][HouseEntranceWorld])
			return i;
	} 
	return 0; 
}



Dialog:DIALOG_HOUSE_WEAPONS(playerid, response, listitem, inputtext[])
{
    if(response)
	{
		new
		id = PlayerInfo[playerid][pInsideProperty],
		str[128]
		;
				
		if(!HouseInfo[id][HouseWeapons][listitem+1])
			return SendErrorMessage(playerid, ""); 
					
		GivePlayerGun(playerid, HouseInfo[id][HouseWeapons][listitem+1], HouseInfo[id][HouseWeaponsAmmo][listitem+1]);
				
		format(str, sizeof(str), "* %s หยิบ %s ออกมาจากตู้เซฟ", ReturnName(playerid, 0), ReturnWeaponName(HouseInfo[id][HouseWeapons][listitem+1])); 
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str); 
				
		HouseInfo[id][HouseWeapons][listitem+1] = 0; 
		HouseInfo[id][HouseWeaponsAmmo][listitem+1] = 0; 
			
		CharacterSave(playerid); Savehouse(id);
		return 1;
	}
    return 1;
}

stock IsPlayerInHouse(playerid)
{
	if(PlayerInfo[playerid][pInsideProperty])
	{
		for(new i = 1; i < MAX_HOUSE; i++)
		{
			if(i == PlayerInfo[playerid][pInsideProperty] && GetPlayerVirtualWorld(playerid) == HouseInfo[i][HouseInteriorWorld])
				return i;
		}
	}
	return 0;
}

stock RemoveHouse(playerid,id)
{
    new delHouse[MAX_STRING];

    mysql_format(dbCon, delHouse, sizeof(delHouse), "DELETE FROM house WHERE HouseDBID = %d", HouseInfo[id][HouseDBID]);
	mysql_tquery(dbCon, delHouse); 

    HouseInfo[id][HouseDBID] = 0;
    format(HouseInfo[id][HouseName], HouseInfo[id][HouseName], "");
    HouseInfo[id][HouseOwnerDBID] = 0;
    HouseInfo[id][HouseEntrance][0] = 0;
    HouseInfo[id][HouseEntrance][1] = 0;
    HouseInfo[id][HouseEntrance][2] = 0;
    HouseInfo[id][HouseEntranceWorld] = 0;
    HouseInfo[id][HouseEntranceInterior] = 0;

    HouseInfo[id][HouseInterior][0] = 0;
    HouseInfo[id][HouseInterior][1] = 0;
    HouseInfo[id][HouseInterior][2] = 0;
    HouseInfo[id][HouseInteriorWorld] = 0;
    HouseInfo[id][HouseInteriorID] = 0;

    HouseInfo[id][HousePrice] = 0;
    HouseInfo[id][HouseLevel] = 0;

    HouseInfo[id][HouseLock] = true;

    for(new w = 0; w < 22; w++)
    {
        HouseInfo[id][HouseWeapons][w] = 0;
        HouseInfo[id][HouseWeaponsAmmo][w] = 0;
    }

    if(IsValidDynamicPickup(HouseInfo[id][HousePickup]))
        DestroyDynamicPickup(HouseInfo[id][HousePickup]);

    new str[MAX_STRING];
    format(str, sizeof(str), "ผู้ดูแล %d: %s ได้ลบบ้าน ไอดี %d ออกจากเซืฟเวร์แล้ว", PlayerInfo[playerid][pAdmin], ReturnRealName(playerid), id);
    SendAdminMessage(5,str);

    return 1;
}
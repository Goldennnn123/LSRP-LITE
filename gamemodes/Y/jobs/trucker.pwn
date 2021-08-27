/// /takejob:
  // /startjob:
    // /getbox:
    // /placebox:
    //check car 422,413,543,554,600
#define BOX_CEMARA 1
#define BOX_MASK 2
#define BOX_FLOWER 3
#define BOX_BOX 4

enum v_trucker {
	v_cargo_cemara,
    v_cargo_mask,
    v_cargo_flower,
    v_cargo_box,
    v_cargo_result,
};
new VehicleCargo[MAX_VEHICLES][v_trucker];
new PlayerCargo[MAX_PLAYERS][v_trucker];
new bool:PlayerGetcargo[MAX_PLAYERS];


enum T_BOX_DROP
{
	bool:TruckerDrop,
	TruckerObject,
    TruckerType,
	TruckerTimer,
	
	Float:TruckerPos[3],
	TruckerInterior,
	TruckerWorld,
	
	TruckerDroppedBy
}

new TruckerObjDrop[200][T_BOX_DROP];

hook OP_Connect(playerid)
{
    PlayerGetcargo[playerid] = false;
    PlayerCargo[playerid][v_cargo_cemara] = 0;
    PlayerCargo[playerid][v_cargo_mask] = 0;
    PlayerCargo[playerid][v_cargo_flower] = 0;
    PlayerCargo[playerid][v_cargo_box] = 0;
    return 1;
}

new trucker_picup[3];

hook OnGameModeInit()
{
    trucker_picup[0] = CreateDynamicPickup(1239, 2, -242.5856,-235.4501,2.4297, -1);
    trucker_picup[1] = CreateDynamicPickup(1239, 2, 2809.3022,-2387.2175,13.6284, -1);
    trucker_picup[2] = CreateDynamicPickup(1239, 2, 303.6682,-242.8768,1.5781, -1);
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == trucker_picup[0])
    {
        SendClientMessage(playerid, COLOR_GREY, "/takejob เพื่อสมัครงาน พนักงานส่งของ");
        return 1;
    }
    if(pickupid == trucker_picup[1])
    {
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo buy "EMBED_WHITE"- เพื่อซื้อ กล่องสินค้าจากท่าเรือ");
        return 1;
    }
    if(pickupid == trucker_picup[2])
    {
        SendClientMessage(playerid,-1, ""EMBED_YELLOW"/cargo buy "EMBED_WHITE"- เพื่อซื้อ กล่องสินค้าจากโรงงานอุสหกรรม");
        return 1;
    }
    return 1;
}

hook OP_EnterCheckpoint(playerid)
{
    if(PlayerCheckpoint[playerid] == 4)
    {
        GameTextForPlayer(playerid, "~p~This GPS TO CARGO!", 3000, 3);
        PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
        return 1;
    }
    return 1;
}



CMD:cargo(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER)
        return SendErrorMessage(playerid, "คุณไม่ใช่พนักงานส่งของ");

    new option[16];

    if(sscanf(params, "s[16]", option))
    {
        SendClientMessage(playerid, COLOR_GRAD3, "Available commands:");
	    SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo list "EMBED_WHITE"- แสดงรายการสินค้าที่บรรจุอยู่ในยานพาหนะที่ปลดล็อกอยู่ใกล้ ๆ");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo place "EMBED_WHITE"- วางลังสินค้าที่ถืออยู่ไปที่ยานพาหนะใกล้ ๆ");
        //SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo get "EMBED_WHITE"- หยิบสินค้าจากยานพาหนะที่อยู่ใกล้ๆ");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo putdown "EMBED_WHITE"- วางลังสินค้าที่ถืออยู่ลงพื้น");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo pickup "EMBED_WHITE"- หยิบลังสินค้าขึ้นมาจากพื้น");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo buy "EMBED_WHITE"- ซื้อสินค้าจากโรงงานอุตสาหกรรม");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo sell "EMBED_WHITE"- ขายสินค้าให้กับอุตสาหกรรม / ธุรกิจ");
        SendClientMessage(playerid, -1, ""EMBED_YELLOW"/cargo gps "EMBED_WHITE"- เพิ่มเปิด GPS เกี่ยวกับการงาน Trucker");
        return 1;
    }
    if(!strcmp(option, "list", true))
    {
        if(PlayerGetcargo[playerid] == true)
            return SendErrorMessage(playerid, "คุณถือกล่องสินค้าอยู่");

        
        if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
        {
            new
                Float:x,
                Float:y,
                Float:z
            ;

            GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
            new 
                vehicleid = GetNearestVehicle(playerid)
            ;

            if(GetVehicleModel(vehicleid) != 422 && GetVehicleModel(vehicleid) != 413 && GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 600)
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่ใช้สำหรับการขนกล่องส่งของ");

            
            if(VehicleInfo[vehicleid][eVehicleLocked])
                return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

            //new modelid = GetVehicleModel(vehicleid);

            if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

            new str[255];
            format(str, sizeof(str), "Cemara\t\t\t\t[%d ชิ้น]\n\
                                      Mask\t\t\t\t[%d ชิ้น]\n\
                                      Flower\t\t\t\t[%d ชิ้น]\n\
                                      สินค้าทั่วไป\t\t\t[%d ชิ้น]",
                                      VehicleCargo[vehicleid][v_cargo_cemara],
                                      VehicleCargo[vehicleid][v_cargo_mask],
                                      VehicleCargo[vehicleid][v_cargo_flower],
                                      VehicleCargo[vehicleid][v_cargo_box]);

            Dialog_Show(playerid, DIALOG_TRUCKER_LIST, DIALOG_STYLE_LIST, "Vehicle Stock", str,"เรียบร้อย", "ออก");
            return 1;
        }
        else SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถสำหรับขนกล่องลังสินค้า");
    }
    else if(!strcmp(option, "place", true))
    {
        if(PlayerGetcargo[playerid] == false)
            return SendErrorMessage(playerid, "คุณไม่ได้ถือกล่องสินค้า");

        new
            Float:x,
            Float:y,
            Float:z
        ;
            
        //new engine, lights, alarm, doors, bonnet, boot, objective;
        if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
        {
            GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
            new 
                vehicleid = GetNearestVehicle(playerid)
            ;

            if(GetVehicleModel(vehicleid) != 422 && GetVehicleModel(vehicleid) != 413 && GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 600)
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่ใช้สำหรับการขนกล่องส่งของ");

            
            if(VehicleInfo[vehicleid][eVehicleLocked])
                return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

            if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

            new modelid = GetVehicleModel(vehicleid);

            switch(modelid)
            {
                case 422:
                {

                    if(VehicleCargo[vehicleid][v_cargo_result] >= 4)
                        return SendErrorMessage(playerid, "ยานพนะพื้นที่ไม่เพียงพอต่อการวางแล้ว");

                    if(PlayerCargo[playerid][v_cargo_cemara])
                    {
                        PlayerCargo[playerid][v_cargo_cemara] = 0;
                        VehicleCargo[vehicleid][v_cargo_cemara]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);

                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_mask])
                    {
                        PlayerCargo[playerid][v_cargo_mask] = 0;
                        VehicleCargo[vehicleid][v_cargo_mask]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_flower])
                    {
                        PlayerCargo[playerid][v_cargo_flower] = 0;
                        VehicleCargo[vehicleid][v_cargo_flower]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_box])
                    {
                        PlayerCargo[playerid][v_cargo_box] = 0;
                        VehicleCargo[vehicleid][v_cargo_box]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else SendErrorMessage(playerid, "คุณไมได้ถือกล่องสินค้า");
                }
                case 413:
                {

                    if(VehicleCargo[vehicleid][v_cargo_result] >= 6)
                        return SendErrorMessage(playerid, "ยานพนะพื้นที่ไม่เพียงพอต่อการวางแล้ว");

                    if(PlayerCargo[playerid][v_cargo_cemara])
                    {
                        PlayerCargo[playerid][v_cargo_cemara] = 0;
                        VehicleCargo[vehicleid][v_cargo_cemara]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);

                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_mask])
                    {
                        PlayerCargo[playerid][v_cargo_mask] = 0;
                        VehicleCargo[vehicleid][v_cargo_mask]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_flower])
                    {
                        PlayerCargo[playerid][v_cargo_flower] = 0;
                        VehicleCargo[vehicleid][v_cargo_flower]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_box])
                    {
                        PlayerCargo[playerid][v_cargo_box] = 0;
                        VehicleCargo[vehicleid][v_cargo_box]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else SendErrorMessage(playerid, "คุณไมได้ถือกล่องสินค้า");
                }
                case 543:
                {

                    if(VehicleCargo[vehicleid][v_cargo_result] >= 4)
                        return SendErrorMessage(playerid, "ยานพนะพื้นที่ไม่เพียงพอต่อการวางแล้ว");

                    if(PlayerCargo[playerid][v_cargo_cemara])
                    {
                        PlayerCargo[playerid][v_cargo_cemara] = 0;
                        VehicleCargo[vehicleid][v_cargo_cemara]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);

                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_mask])
                    {
                        PlayerCargo[playerid][v_cargo_mask] = 0;
                        VehicleCargo[vehicleid][v_cargo_mask]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_flower])
                    {
                        PlayerCargo[playerid][v_cargo_flower] = 0;
                        VehicleCargo[vehicleid][v_cargo_flower]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_box])
                    {
                        PlayerCargo[playerid][v_cargo_box] = 0;
                        VehicleCargo[vehicleid][v_cargo_box]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else SendErrorMessage(playerid, "คุณไมได้ถือกล่องสินค้า");
                }
                case 554:
                {

                    if(VehicleCargo[vehicleid][v_cargo_result] >= 4)
                        return SendErrorMessage(playerid, "ยานพนะพื้นที่ไม่เพียงพอต่อการวางแล้ว");

                    if(PlayerCargo[playerid][v_cargo_cemara])
                    {
                        PlayerCargo[playerid][v_cargo_cemara] = 0;
                        VehicleCargo[vehicleid][v_cargo_cemara]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);

                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_mask])
                    {
                        PlayerCargo[playerid][v_cargo_mask] = 0;
                        VehicleCargo[vehicleid][v_cargo_mask]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_flower])
                    {
                        PlayerCargo[playerid][v_cargo_flower] = 0;
                        VehicleCargo[vehicleid][v_cargo_flower]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_box])
                    {
                        PlayerCargo[playerid][v_cargo_box] = 0;
                        VehicleCargo[vehicleid][v_cargo_box]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else SendErrorMessage(playerid, "คุณไมได้ถือกล่องสินค้า");
                }
                case 600:
                {

                    if(VehicleCargo[vehicleid][v_cargo_result] >= 2)
                        return SendErrorMessage(playerid, "ยานพนะพื้นที่ไม่เพียงพอต่อการวางแล้ว");

                    if(PlayerCargo[playerid][v_cargo_cemara])
                    {
                        PlayerCargo[playerid][v_cargo_cemara] = 0;
                        VehicleCargo[vehicleid][v_cargo_cemara]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);

                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_mask])
                    {
                        PlayerCargo[playerid][v_cargo_mask] = 0;
                        VehicleCargo[vehicleid][v_cargo_mask]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_flower])
                    {
                        PlayerCargo[playerid][v_cargo_flower] = 0;
                        VehicleCargo[vehicleid][v_cargo_flower]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else if(PlayerCargo[playerid][v_cargo_box])
                    {
                        PlayerCargo[playerid][v_cargo_box] = 0;
                        VehicleCargo[vehicleid][v_cargo_box]++;
                        VehicleCargo[vehicleid][v_cargo_result]++;
                        PlaceCargo(playerid);
            
                        new str[90];
                        format(str, sizeof(str), "ได้วางกล่องไว้บนรถ %s",ReturnVehicleName(vehicleid));
                        callcmd::me(playerid, str);
                        return 1;
                    }
                    else SendErrorMessage(playerid, "คุณไมได้ถือกล่องสินค้า");
                }
            }

            return 1;
        }
        return 1;
    }
    else if(!strcmp(option, "buy", true))
    {
        if(PlayerGetcargo[playerid] == true)
            return SendErrorMessage(playerid, "คุณกำลังถือกล่องสินค้าอยู่");
        
        if(IsPlayerInRangeOfPoint(playerid, 2.5, 2809.3022,-2387.2175,13.6284))
        {
            new str[255];
            format(str, sizeof(str), "Cemara\t\t$1,000\nMask\t\t$2,500\nFlower\t\t$200");
            //Dialog_Show(playerid, DIALOG_TRUCKER_BUY, DIALOG_STYLE_LIST, "TRUCKER BUY", str, "ยืนยัน", "ยกเลิก");
            Dialog_Show(playerid, DIALOG_TRUCKER_BUY, DIALOG_STYLE_LIST, "TRUCKER BUY", str, "ยืนยัน", "ยกเลิก");
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 2.5, 303.6682,-242.8768,1.5781))
        {
            if(PlayerInfo[playerid][pCash] < 500)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอที่จะซื้อสินค้านี้ "EMBED_WHITE"(ราคา : $500)");
            
            PlayerCargo[playerid][v_cargo_box]++;
            GiveMoney(playerid, -500);
            SendClientMessage(playerid, -1, "คุณได้ทำการซื้อลังสินค้า กล่องทั่วไป จำนวน 1 ลังด้วยเงิน $500");
            GetPlayerCargo(playerid);
        }
        else SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดรับซื้อลังสินค้า");
    }
    else if(!strcmp(option, "putdown", true))
    {

        if(PlayerGetcargo[playerid] == false)
            return SendErrorMessage(playerid, "คุณไม่ได้ถือกล่องสินค้า");

        new idx, Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z); 

        for(new i = 1; i < sizeof(TruckerObjDrop); i++)
        {
            if(TruckerObjDrop[i][TruckerDrop] == false)
            {
                idx = i;
                break;
            }
        }

        TruckerObjDrop[idx][TruckerDrop] = true;
        TruckerObjDrop[idx][TruckerDroppedBy] = PlayerInfo[playerid][pDBID];
        TruckerObjDrop[idx][TruckerPos][0] = x-1;
        TruckerObjDrop[idx][TruckerPos][1] = y;
        TruckerObjDrop[idx][TruckerPos][2] = z-1;
        TruckerObjDrop[idx][TruckerInterior] = GetPlayerVirtualWorld(playerid);
        TruckerObjDrop[idx][TruckerWorld] = GetPlayerInterior(playerid);

        if(PlayerCargo[playerid][v_cargo_cemara])
        {
            PlayerCargo[playerid][v_cargo_cemara]--;
            TruckerObjDrop[idx][TruckerType] = BOX_CEMARA;
        }
        else if(PlayerCargo[playerid][v_cargo_mask])
        {
            PlayerCargo[playerid][v_cargo_mask]--;
            TruckerObjDrop[idx][TruckerType] = BOX_MASK;
        }
        else if(PlayerCargo[playerid][v_cargo_flower])
        {
            PlayerCargo[playerid][v_cargo_flower]--;
            TruckerObjDrop[idx][TruckerType] = BOX_FLOWER;
        }
        else if(PlayerCargo[playerid][v_cargo_box])
        {
            PlayerCargo[playerid][v_cargo_box]--;
            TruckerObjDrop[idx][TruckerType] = BOX_BOX;
        }

        TruckerObjDrop[idx][TruckerObject] = CreateDynamicObject(2912, x-1, y, z-1, 0.0, 0.0, 0.0, TruckerObjDrop[idx][TruckerWorld], TruckerObjDrop[idx][TruckerInterior], -1);
        TruckerObjDrop[idx][TruckerTimer] = SetTimerEx("DeleteCargoObj", 300000, false, "i",idx);
        SendClientMessageEx(playerid, COLOR_RED, "[ ! ]{FFFFFF} คุณได้วางกล่องสินค้าของคุณไว้บนพื้นแล้ว ซึ่งมันจะอยู่แค่ 5 นาทีเท่านั้น (idx : %d)", idx);
        PlaceCargo(playerid);
        return 1;
    }
    else if(!strcmp(option, "pickup", true))
    {
        if(PlayerGetcargo[playerid])
            return SendErrorMessage(playerid, "คุณถือกล่องสินค้าอยู่");
        
        new id, bool:founcargo;
        for(new i = 0; i < sizeof(TruckerObjDrop); i++)
        {
            if(!TruckerObjDrop[i][TruckerDrop])
			    continue; 
            
            if(IsPlayerInRangeOfPoint(playerid, 2.5, TruckerObjDrop[i][TruckerPos][0], TruckerObjDrop[i][TruckerPos][1], TruckerObjDrop[i][TruckerPos][2]))
            {
                if(GetPlayerVirtualWorld(playerid) == TruckerObjDrop[i][TruckerWorld])
                {
                    founcargo = true;
                    id = i;
                }							
            }
        }

        if(founcargo)
        {
            switch(TruckerObjDrop[id][TruckerType])
            {
                case BOX_CEMARA:
                {
                    PlayerCargo[playerid][v_cargo_cemara]++;
                    GetPlayerCargo(playerid);
                    DeleteCargoObj(id);
                    founcargo = false;
                    SendClientMessageEx(playerid, -1, "id : %d",id);
                    return 1;
                }
                case BOX_MASK:
                {
                    PlayerCargo[playerid][v_cargo_mask]++;
                    GetPlayerCargo(playerid);
                    DeleteCargoObj(id);
                    founcargo = false;
                    
                    return 1;
                }
                case BOX_FLOWER:
                {
                    PlayerCargo[playerid][v_cargo_flower]++;
                    GetPlayerCargo(playerid);
                    DeleteCargoObj(id);
                    founcargo = false;
                    return 1;
                }
                case BOX_BOX:
                {
                    PlayerCargo[playerid][v_cargo_box]++;
                    GetPlayerCargo(playerid);
                    DeleteCargoObj(id);
                    founcargo = false;
                    return 1;
                }
            }
            return 1;
        }
        else SendErrorMessage(playerid, "ไม่มีกล่องสินค้าอยู้บริเวรนี้");
    }
    else if(!strcmp(option, "sell", true))
    {
        if(PlayerGetcargo[playerid] == false)
            return SendErrorMessage(playerid, "คุณไม่ได้ถือกล่องสินค้า");

        if(IsPlayerNearBusiness(playerid))
        {
            new id = IsPlayerNearBusiness(playerid);

            if(!BusinessInfo[id][BusinessDBID])
                return 1;

            if(BusinessInfo[id][BusinessType] != BUSINESS_TYPE_STORE)
                return 1;

            if(PlayerCargo[playerid][v_cargo_cemara])
            {
                PlayerCargo[playerid][v_cargo_cemara]--;
                BusinessInfo[id][BusinessS_Cemara]+=5;
                GiveMoney(playerid, 1075);
                SendClientMessage(playerid, -1, "คุณได้ทำการส่งของ ได้รับเงิน $1,075");
                PlaceCargo(playerid);
                SaveBusiness(id);
                return 1;
            }
            else if(PlayerCargo[playerid][v_cargo_mask])
            {
                PlayerCargo[playerid][v_cargo_mask]--;
                BusinessInfo[id][BusinessS_Mask]+=3;
                GiveMoney(playerid, 2575);
                SendClientMessage(playerid, -1, "คุณได้ทำการส่งของ ได้รับเงิน $2,575");
                PlaceCargo(playerid);
                SaveBusiness(id);
                return 1;
            }
            else if(PlayerCargo[playerid][v_cargo_flower])
            {
                PlayerCargo[playerid][v_cargo_flower]--;
                BusinessInfo[id][BusinessS_Flower]+=3;
                GiveMoney(playerid, 275);
                SendClientMessage(playerid, -1, "คุณได้ทำการส่งของ ได้รับเงิน $275");
                PlaceCargo(playerid);
                SaveBusiness(id);
                return 1;
            }
            else SendErrorMessage(playerid, "ไม่มีสินค้าอยู่ในตัว");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2486.3713,-2120.8716,13.5469))
        {
            if(!PlayerCargo[playerid][v_cargo_box])
                return SendErrorMessage(playerid, "คุณไม่มีลังสินค้าสำหรับอุสาหกรรม");

            new money = Random(520,600);
            SendClientMessageEx(playerid, -1, "คุณได้ส่งกล่องสินค้า อุสหกรรมสำเร็จแล้ว "EMBED_GREENMONEY"- ได้รับเงิน $%s", MoneyFormat(money));
            GiveMoney(playerid, money);
            PlayerCargo[playerid][v_cargo_box]--;
            PlaceCargo(playerid);
            return 1;
        }
        else SendErrorMessage(playerid, "คุณไมได้อยู่จุดส่งสินค้า");
    }
    else if(!strcmp(option, "gps", true))
    {
        if(PlayerGetcargo[playerid])
            return SendErrorMessage(playerid, "วางกล่องที่ถือก่อนที่จะใช้คำสั่งนี้");

        new vehicleid = GetPlayerVehicleID(playerid), modelid = GetVehicleModel(vehicleid);

        if(!IsPlayerInVehicle(playerid, vehicleid))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");

        if(modelid != 422 && modelid != 413 && modelid != 543 && modelid != 554 && modelid != 600)
            return SendErrorMessage(playerid, "ยานพนะไม่ใช่ยานพนะสำหรับขนกล่องสินค้าโปรดเปลี่ยนคันเพื่อทำอาชีพนี้");

        if(!VehicleCargo[vehicleid][v_cargo_result])
            return SendErrorMessage(playerid, "ไม่มีลังสินค้าอยู่ในรถ");

        new str[200];
        format(str, sizeof(str), "[ ! ] ส่งให้ธุรกิจ 24/7\n[ ! ] ส่งให้โรงงานอุสาหกรรม");
        Dialog_Show(playerid, DIALOG_TRUCKER_LIST_SELL, DIALOG_STYLE_LIST, "GPS TRUCKER:", str, "ยืนยัน", "ยกเลิก");
        return 1;
    }
    return 1;
}

Dialog:DIALOG_TRUCKER_LIST_SELL(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    switch(listitem)
    {
        case 0:
        {
            new str_bu[250], str_b[100], businessid;

            for(new i = 1; i < MAX_BUSINESS; i++)
            {
                if(!BusinessInfo[i][BusinessDBID])
                    continue;

                if(BusinessInfo[i][BusinessType] != BUSINESS_TYPE_STORE)
                    continue;
                
                format(str_bu, sizeof(str_bu), "กิจการ: %s",BusinessInfo[i][BusinessName]);

                format(str_b, sizeof(str_b), "%d",businessid);
		        SetPVarInt(playerid, str_b, i);

                businessid++;
            }

            Dialog_Show(playerid, DIALOG_TRUCKER_BU_SE, DIALOG_STYLE_LIST, "กิจการทั้งหมด:", str_bu, "ยินยัน", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            SendClientMessage(playerid, -1, "คุณเลือกที่จะส่งของให้กับ โรงงานอุสาหกรรม โปรดไปตามจุดที่เรา มาร์ากไว้ให้");
            SetPlayerCheckpoint(playerid, 2486.3713,-2120.8716,13.5469, 3.0);
            PlayerCheckpoint[playerid] = 4;
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_TRUCKER_BU_SE(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new str_b[MAX_STRING];
    format(str_b, sizeof(str_b), "%d",listitem);

    new id = GetPVarInt(playerid, str_b);
    PlayerSelectBusiness[playerid] = id;

    if(!BusinessInfo[id][BusinessDBID])
        return 1;

    SetPlayerCheckpoint(playerid, BusinessInfo[id][BusinessEntrance][0], BusinessInfo[id][BusinessEntrance][1], BusinessInfo[id][BusinessEntrance][2], 30);
    PlayerCheckpoint[playerid] = 4;
    return 1;
}
forward DeleteCargoObj(id);
public DeleteCargoObj(id)
{
    TruckerObjDrop[id][TruckerDrop] = false;
    TruckerObjDrop[id][TruckerDroppedBy] = 0;
    TruckerObjDrop[id][TruckerPos][0] = 0.0;
    TruckerObjDrop[id][TruckerPos][1] = 0.0;
    TruckerObjDrop[id][TruckerPos][2] = 0.0;
    TruckerObjDrop[id][TruckerInterior] = 0;
    TruckerObjDrop[id][TruckerWorld] = 0;
    TruckerObjDrop[id][TruckerType] = 0;
    DestroyDynamicObject(TruckerObjDrop[id][TruckerObject]);
    KillTimer(TruckerObjDrop[id][TruckerTimer]);
    return 1;
}


stock GetPlayerCargo(playerid)
{
    PlayerGetcargo[playerid] = true;
    ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, 9, 2912, 1, -0.019, 0.713999, -0.076, 0, 87.1, -9.4, 1.0000, 1.0000, 1.0000);

    new str[90];
    format(str, sizeof(str), "ได้ยกกล่องสินค้าขึ้นมถือไว้ด้วยสองมือ");
    callcmd::me(playerid, str);
    return 1;
}

stock PlaceCargo(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, 9);
    PlayerGetcargo[playerid] = false;
    return 1;
}

Dialog:DIALOG_TRUCKER_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;


    if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
    {
        new
            Float:x,
            Float:y,
            Float:z
        ;

        GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
        new 
            vehicleid = GetNearestVehicle(playerid)
        ;

        if(GetVehicleModel(vehicleid) != 422 && GetVehicleModel(vehicleid) != 413 && GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 600)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่ใช้สำหรับการขนกล่องส่งของ");

            
        if(VehicleInfo[vehicleid][eVehicleLocked])
            return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่");

        //new modelid = GetVehicleModel(vehicleid);

        if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายรถ");

        switch(listitem)
        {
            case 0:
            {
                if(!VehicleCargo[vehicleid][v_cargo_cemara])
                    return 1;

                VehicleCargo[vehicleid][v_cargo_cemara]--;
                VehicleCargo[vehicleid][v_cargo_result]--;
                PlayerCargo[playerid][v_cargo_cemara]++;
                GetPlayerCargo(playerid);
                return 1;
            }
            case 1:
            {
                if(!VehicleCargo[vehicleid][v_cargo_mask])
                    return 1;

                VehicleCargo[vehicleid][v_cargo_mask]--;
                VehicleCargo[vehicleid][v_cargo_result]--;
                PlayerCargo[playerid][v_cargo_mask]++;
                GetPlayerCargo(playerid);
                return 1;
            }
            case 2:
            {
                if(!VehicleCargo[vehicleid][v_cargo_flower])
                    return 1;

                VehicleCargo[vehicleid][v_cargo_flower]--;
                VehicleCargo[vehicleid][v_cargo_result]--;
                PlayerCargo[playerid][v_cargo_flower]++;
                GetPlayerCargo(playerid);
                return 1;
            }
            case 3:
            {
                if(!VehicleCargo[vehicleid][v_cargo_box])
                    return 1;

                VehicleCargo[vehicleid][v_cargo_box]--;
                VehicleCargo[vehicleid][v_cargo_result]--;
                PlayerCargo[playerid][v_cargo_box]++;
                GetPlayerCargo(playerid);
                return 1;
            }
        }    
        return 1;
    }
    return 1;
}

Dialog:DIALOG_TRUCKER_BUY(playerid, response, listitem, inputtext[])
{
    if(!response)
        return SendErrorMessage(playerid, "ยกเลิก");

    switch(listitem)
    {
        case 0:
        {
            if(PlayerInfo[playerid][pCash] < 1000)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอที่จะซื้อสินค้านี้");

            PlayerCargo[playerid][v_cargo_cemara]++;
            GiveMoney(playerid, -1000);
            SendClientMessage(playerid, -1, "คุณได้ทำการซื้อลังสินค้า Cemara จำนวน 1 ลังด้วยเงิน $1,000");
            GetPlayerCargo(playerid);
            return 1;
        }
        case 1:
        {
            if(PlayerInfo[playerid][pCash] < 2500)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอที่จะซื้อสินค้านี้");

            PlayerCargo[playerid][v_cargo_mask]++;
            GiveMoney(playerid, -2500);
            SendClientMessage(playerid, -1, "คุณได้ทำการซื้อลังสินค้า Mask จำนวน 1 ลังด้วยเงิน $2,500");
            GetPlayerCargo(playerid);
            return 1;
        }
        case 2:
        {
            if(PlayerInfo[playerid][pCash] < 200)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอที่จะซื้อสินค้านี้");

            PlayerCargo[playerid][v_cargo_flower]++;
            GiveMoney(playerid, -200);
            SendClientMessage(playerid, -1, "คุณได้ทำการซื้อลังสินค้า Flower จำนวน 1 ลังด้วยเงิน $200");
            GetPlayerCargo(playerid);
            return 1;
        }
    }
    return 1;
}




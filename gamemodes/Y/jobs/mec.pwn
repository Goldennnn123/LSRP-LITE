#include <YSI_Coding\y_hooks>

new mec_pick;
new PlayerText:MecTextDraw[MAX_PLAYERS][6];
new PlayerShowMecMenu[MAX_PLAYERS];

hook OnGameModeInit()
{
    mec_pick = CreateDynamicPickup(1319, 2, 90.2705,-164.6044,2.5938, -1, -1, -1);
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == mec_pick)
        return SendClientMessage(playerid, -1, "พิพม์ /mechanic เพื่อสมัครเป็นช่างยนต์");


    return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(PlayerShowMecMenu[playerid])
    {
        if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleLocked])
        {
            MecJobShow(playerid, false);
            SendErrorMessage(playerid, "ยานพาหนะถูกล็อค");
        }

        if(playertextid == MecTextDraw[playerid][3])
        {
            

            if(!IsPlayerInAnyVehicle(playerid))
                return SendInfomationMess(playerid, "~r~[!] You don't get in car", 10);

            
            new vehicleid = GetPlayerVehicleID(playerid);
            new modelid_taget = GetVehicleModel(vehicleid);
            new Float:vehhp;
            new box;


            GetVehicleHealth(vehicleid, vehhp);
            
            if(vehhp == VehicleData[modelid_taget - 400][c_max_health])
                SendClientMessage(playerid, -1, "Vehicle Not Domage");
            else
            {
                new Float:result = (VehicleData[modelid_taget - 400][c_max_health] - vehhp) / 50 * 2;
                box = floatround(result,floatround_round);
                SendClientMessageEx(playerid, -1, "Repair Box: %d",box);
            }

            if(PlayerInfo[playerid][pRepairBox] < box)
                return SendInfomationMess(playerid, "~r~ You don't have Repair Box", 5);



            
            PlayerInfo[playerid][pRepairBox] -= box;
            SetVehicleHealth(vehicleid, VehicleData[modelid_taget - 400][c_max_health]);
            SendInfomationMess(playerid, "~g~ Repair success Now!!!!", 5);

            PlayerTextDrawSetString(playerid, MecTextDraw[playerid][3], "Vehicle Not Damage");
            CharacterSave(playerid);
            
            return 1;
        }
        else if(playertextid == MecTextDraw[playerid][5])
        {
            Dialog_Show(playerid, D_MEC_MENU_LIST, DIALOG_STYLE_LIST, "เมนูช่าง", "[!] เปลี่ยนสี\n[!] แต่งรถ\n[!] ล้างที่แต่งออก", "ยืนยัน", "ยกเลิก");
            MecJobShow(playerid, false);
            return 1;
        }

        return 1;
    }
    return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(PlayerShowMecMenu[playerid])
    {
        if(clickedid == Text:INVALID_TEXT_DRAW)
        {
            MecJobShow(playerid, false);
			return 1;
        }
        return 1;
    }
    return 1;
}

///// hook Zone


///// Stock Zone
stock MecJobShow(playerid, show = false)
{
    if(show)
    {
        MecTextDraw[playerid][0] = CreatePlayerTextDraw(playerid, 98.000000, 52.000000, "_");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][0], 1);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][0], 0.600000, 14.250004);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][0], 327.500000, 152.000000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][0], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][0], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][0], 2);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][0], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][0], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][0], 135);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][0], 1);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][0], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][0], 0);

        MecTextDraw[playerid][1] = CreatePlayerTextDraw(playerid, 98.000000, 52.000000, "_");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][1], 1);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][1], 0.600000, 5.649994);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][1], 327.500000, 152.000000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][1], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][1], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][1], 2);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][1], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][1], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][1], 1097458175);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][1], 1);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][1], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][1], 0);

        MecTextDraw[playerid][2] = CreatePlayerTextDraw(playerid, 32.000000, 61.000000, "Mechanic");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][2], 2);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][2], 0.608333, 3.249998);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][2], 157.500000, 21.000000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][2], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][2], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][2], 1);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][2], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][2], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][2], 50);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][2], 0);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][2], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][2], 0);

        MecTextDraw[playerid][3] = CreatePlayerTextDraw(playerid, 22.000000, 122.000000, "Fix Vehicle ~r~$300");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][3], 1);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][3], 0.204166, 1.400000);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][3], 173.500000, 137.500000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][3], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][3], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][3], 1);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][3], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][3], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][3], 50);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][3], 0);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][3], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][3], 1);

        MecTextDraw[playerid][4] = CreatePlayerTextDraw(playerid, 22.000000, 107.000000, "Manage the Ruiner");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][4], 2);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][4], 0.212500, 1.300000);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][4], 173.500000, 31.000000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][4], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][4], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][4], 1);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][4], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][4], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][4], 50);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][4], 0);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][4], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][4], 0);

        MecTextDraw[playerid][5] = CreatePlayerTextDraw(playerid, 22.000000, 137.000000, "Mechanic Menu");
        PlayerTextDrawFont(playerid, MecTextDraw[playerid][5], 1);
        PlayerTextDrawLetterSize(playerid, MecTextDraw[playerid][5], 0.204166, 1.400000);
        PlayerTextDrawTextSize(playerid, MecTextDraw[playerid][5], 173.500000, 137.500000);
        PlayerTextDrawSetOutline(playerid, MecTextDraw[playerid][5], 1);
        PlayerTextDrawSetShadow(playerid, MecTextDraw[playerid][5], 0);
        PlayerTextDrawAlignment(playerid, MecTextDraw[playerid][5], 1);
        PlayerTextDrawColor(playerid, MecTextDraw[playerid][5], -1);
        PlayerTextDrawBackgroundColor(playerid, MecTextDraw[playerid][5], 255);
        PlayerTextDrawBoxColor(playerid, MecTextDraw[playerid][5], 50);
        PlayerTextDrawUseBox(playerid, MecTextDraw[playerid][5], 0);
        PlayerTextDrawSetProportional(playerid, MecTextDraw[playerid][5], 1);
        PlayerTextDrawSetSelectable(playerid, MecTextDraw[playerid][5], 1);


        for(new i = 0; i < 6; i++)
        {
            PlayerTextDrawShow(playerid, MecTextDraw[playerid][i]);
            SendClientMessage(playerid, -1, "");
        }

        
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            new modelid_taget = GetVehicleModel(vehicleid);
            new str[255], Float:vehhp;


            GetVehicleHealth(vehicleid, vehhp);
        
            if(vehhp == VehicleData[modelid_taget - 400][c_max_health])
                format(str, sizeof(str), "Vehicle Not Domage");
            else
            {
                new Float:result = (VehicleData[modelid_taget - 400][c_max_health] - vehhp) / 50 * 2;
                new box = floatround(result,floatround_round);

                format(str, sizeof(str), "Fix Vehicle use Repair Box: %d",box);
            }

            PlayerTextDrawSetString(playerid, MecTextDraw[playerid][3], str);
        }
        else
        {
            PlayerTextDrawSetString(playerid, MecTextDraw[playerid][3], "You Enter Vehicle");
        }

        SendClientMessage(playerid, -1, "/mecjob อีกครั้งเพื่อปิด");
        SelectTextDraw(playerid, COLOR_GRAD1);
        PlayerShowMecMenu[playerid] = true;
    }
    else
    {
        for(new i = 0; i < 6; i++)
        {
            PlayerTextDrawDestroy(playerid, MecTextDraw[playerid][i]);
        }
        PlayerShowMecMenu[playerid] = false;
        CancelSelectTextDraw(playerid);
    }
    return 1;
}
///// Stock Zone



///// Dialog Zone:
Dialog:D_MEC_MENU_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return MecJobShow(playerid, true);

    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleLocked])
        return SendErrorMessage(playerid, "ยานพาหนะถูกล็อค");

    switch(listitem)
    {
        case 0:
        {
            new str[50];
            format(str, sizeof(str), "COLOR 1\nCOLOR 2");

            Dialog_Show(playerid, D_MEC_MENU_COLO_LIST, DIALOG_STYLE_LIST, "เลือกจุดที่จะเติมสี", str, "ยินยัน", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            ShowAllComponents(playerid);
            return 1;
        }
        case 2:
        {
            if(!IsPlayerInAnyVehicle(playerid))
                return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ");

            new vehicleid = GetPlayerVehicleID(playerid);

            for(new i = 1000; i <= 1193; i++)
            {
                RemoveVehicleComponent(vehicleid,i);
            }
            SaveVehicle(vehicleid);

            SendClientMessage(playerid, -1, "ล้างสิ่งที่แต่งออกหมดแล้ว");
            return 1;
        }
    }
    return 1;
}

Dialog:D_MEC_MENU_COLO_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return MecJobShow(playerid, true);


    if(PlayerInfo[playerid][pRepairBox] < 5)
        return SendErrorMessage(playerid, "คุณมีอะไหล่ไม่เพียงพอต่อการดำเนินการ");

    switch(listitem)
    {
        case 0:
        {
            Dialog_Show(playerid, D_MEC_MENU_COLOR1, DIALOG_STYLE_INPUT, "ใส่เลขสี", "ใส่เลขสีที่คุณต้องการลงไปหากคุณไม่ทราบคุณสามารถที่จะพิพม์ /colorlist ได้", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 1:
        {
            Dialog_Show(playerid, D_MEC_MENU_COLOR2, DIALOG_STYLE_INPUT, "ใส่เลขสี", "ใส่เลขสีที่คุณต้องการลงไปหากคุณไม่ทราบคุณสามารถที่จะพิพม์ /colorlist ได้", "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:D_MEC_MENU_COLOR1(playerid, response, listitem, inputtext[])
{
    if(!response)
        return MecJobShow(playerid, true);

    if(!IsPlayerInAnyVehicle(playerid))
        return MecJobShow(playerid, true);

    
    new vehicleid = GetPlayerVehicleID(playerid);
    new newcolor = strval(inputtext);

    VehicleInfo[vehicleid][eVehicleColor1] = newcolor;
    new color2 = VehicleInfo[vehicleid][eVehicleColor2];

    PlayerInfo[playerid][pRepairBox] -= 5;
    CharacterSave(playerid);

    ChangeVehicleColor(vehicleid, newcolor, color2);
    SaveVehicle(vehicleid);

    SendInfomationMess(playerid, "~g~ChangeVehicle Color Now!!!", 5);
    return 1;
}

Dialog:D_MEC_MENU_COLOR2(playerid, response, listitem, inputtext[])
{
    if(!response)
        return MecJobShow(playerid, true);

    if(!IsPlayerInAnyVehicle(playerid))
        return MecJobShow(playerid, true);

    
    new vehicleid = GetPlayerVehicleID(playerid);
    new newcolor = strval(inputtext);

    new color1 = VehicleInfo[vehicleid][eVehicleColor1];
    VehicleInfo[vehicleid][eVehicleColor2] = newcolor;

    PlayerInfo[playerid][pRepairBox] -= 5;
    CharacterSave(playerid);

    ChangeVehicleColor(vehicleid, color1, newcolor);
    SaveVehicle(vehicleid);
    SendInfomationMess(playerid, "~g~ChangeVehicle Color Now!!!", 5);
    return 1;
}
///// Dialog Zone:


//// Zone Command
CMD:mechanic(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณเป็นอาชีพงานช่างยนต์อยู่แล้ว");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 90.2705,-164.6044,2.5938))  
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่จุดสมัครงานช่างยนต์");

    PlayerInfo[playerid][pJob] = JOB_MECHANIC;
	GameTextForPlayer(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Mechanic.~n~~w~/jobhelp.", 8000, 1);
    return 1;
}

CMD:mecjob(playerid, params[])
{
    if(!PlayerShowMecMenu[playerid])
        MecJobShow(playerid, true);

    else MecJobShow(playerid, false);
    return 1;
}

CMD:checkreapir(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");


    SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณเหลืออะไหล่ในการใช้งานอยู่ %d ชิ้น", PlayerInfo[playerid][pRepairBox]);
    return 1;
}
//// Zone Command




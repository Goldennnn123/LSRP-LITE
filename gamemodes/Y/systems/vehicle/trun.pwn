#include <YSI_Coding\y_hooks>


CMD:trun(playerid, params[])
{
    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไมได้อยู่บนยานพาหนะ");

    new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

    SendDialogVehicle(playerid, modelid);
    return 1;
}

stock SendDialogVehicle(playerid, modelid)
{
    new str[MAX_STRING], longstr[MAX_STRING];
    switch(modelid)
    {
        case 400: // Landstalker
        {
            format(str, sizeof(str), "Nitro "EMBED_YELLOW"- $1,500");
            strcat(longstr, str);

            Dialog_Show(playerid, V_VEH_LANDSTALKER, DIALOG_STYLE_LIST, "แต่งยานพหานะ", longstr, "ยืนยัน", "ยกเลิก");
            return 1;
        }
    }
    return 1;
}

Dialog:V_VEH_LANDSTALKER(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new vehicleid = GetPlayerVehicleID(playerid);

    switch(listitem)
    {
        case 0:
        {
            AddVehicleComponent(vehicleid, 1008);
            SendClientMessage(playerid, COLOR_DARKGREEN, "คุณได้ทำการแต่งยานพาหนะเรียบร้อยแล้ว");

            //GetVehicleComponentInSlot(vehicleid, slot);
        }
    }
    return 1;
}
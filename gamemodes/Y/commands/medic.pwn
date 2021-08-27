CMD:heal(playerid, params[])
{
    new factionid = PlayerInfo[playerid][pFaction], tagetid;

    if(FactionInfo[factionid][eFactionJob] != MEDIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าหน้าที แพทย์");

    if(sscanf(params, "u", tagetid))
		return SendUsageMessage(playerid, "/heal <ชื่อบางส่วน/ไอดี>"); 
		
	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
    
    if(!IsPlayerNearPlayer(playerid, tagetid, 2.5))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

    GiveMoney(tagetid, -120);
    GlobalInfo[G_GovCash] += 120;

    SendClientMessageEx(playerid, COLOR_PINK, "คุณได้ทำการรักษาเพิ่มเลือดให้กับ %s เต็ม 100 แล้ว",ReturnName(tagetid, 0));
    SendClientMessageEx(tagetid, COLOR_GREY, "คุณได้รับการรักษาจาก แพทย์ %s เลือดของคุณกลับมาเต็ม 100 แล้ว",ReturnName(playerid, 0));
    SetPlayerHealth(tagetid, 100);
    return 1;
}
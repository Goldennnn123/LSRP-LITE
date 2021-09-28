#include <YSI_Coding\y_hooks>

new taxi_vehicles[2];
new bool:PlayerTaxiExam[MAX_PLAYERS];
new PlayerTaxiPoint[MAX_PLAYERS], PlayerTaxiTime[MAX_PLAYERS];
new PlayersTaxiVehicle[MAX_PLAYERS];






////ส่วนของพนักงาน:
enum T_TAXIT_DATA
{
	T_Value,
	T_Ptaget,
	T_Vehicle,
	bool:T_Start,
	T_Scount,
}
new PlayerTaxitInfo[MAX_PLAYERS][T_TAXIT_DATA];
////ส่วนของพนักงาน:

enum E_TAXITEST_INFO
{
	Float: eCheckpointX,
	Float: eCheckpointY,
	Float: eCheckpointZ,
	bool: eFinishLine
}


new LicenseTaxiInfo[][E_TAXITEST_INFO] = 
{
	{1295.8586, -1556.1158, 13.1676, false},
	{1294.9937,-1697.9497,13.1616, false},
	{1295.3359,-1839.2048,13.1636, false},
	{1367.3125,-1872.8649,13.1611, false},
	{1514.5110,-1874.5658,13.1605, false},
	{1691.9550,-1833.1274,13.1633, false},
	{1691.9929,-1748.4672,13.1665, false},
	{1807.3558,-1735.0421,13.1680, false},
	{1926.7766,-1754.8856,13.1616, false},
	{1932.6749,-1776.2620,13.1608, false},
	{1948.3965,-1787.6583,13.1637, false},
	{2066.6904,-1814.8916,13.1608, false},
	{2091.6558,-1765.3745,13.1756, false},
	{2113.7925,-1784.2297,13.1674, false},
	{2196.1389,-1657.9421,14.8706, false},
	{2108.9565,-1610.9573,13.1536, false},
	{2056.7397,-1609.7950,13.1547, false},
	{1999.4031,-1661.5868,13.1627, false},
	{1999.7195,-1738.3478,13.1631, false},
	{1957.0138,-1750.0513,13.1604, false},
	{1835.3898,-1749.5266,13.1618, false},
	{1702.1088,-1729.7723,13.1637, false},
	{1586.0121,-1729.9825,13.1636, false},
	{1550.8309,-1729.9357,13.1614, false},
	{1444.9648,-1729.2382,13.1631, false},
	{1328.3711,-1729.4972,13.1617, false},
	{1360.8300,-1420.9401,13.1629, false},
	{1327.7432,-1481.9246,13.1630, false},
	{1301.4811,-1531.0396,13.1602, true}
};

hook OnGameModeInit()
{
    taxi_vehicles[0] = AddStaticVehicle(420,1270.5159,-1537.1450,13.3443,271.6486,6,6); SetVehicleNumberPlate(taxi_vehicles[0], "TAXI");
    taxi_vehicles[1] = AddStaticVehicle(420,1270.1414,-1530.0341,13.3438,271.2721,6,6); SetVehicleNumberPlate(taxi_vehicles[1], "TAXI");
	VehicleInfo[taxi_vehicles[0]][eVehicleFuel] = 100.0;
	VehicleInfo[taxi_vehicles[1]][eVehicleFuel] = 100.0;
	return 1;
}

stock IsPlayerInTaxiVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof taxi_vehicles; i++)
	{
		if(vehicleid == taxi_vehicles[i])
			return 1;
	}
		
	return 0;
}

stock IsInTaxiVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	if(GetVehicleModel(vehicleid) == 420 || GetVehicleModel(vehicleid) == 438)
		return 1;
		
	return 0;
}


hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(IsPlayerInTaxiVehicle(playerid))
		{
			SendClientMessage(playerid, -1, "{17A589}ตอนนี้คุณได้อยู่บนรถ ทดสอบการขับขี่เพื่อเป้นอาชีพ TXAI คุณสามารถพิมพ์ {FFFF00}/taxiexam {17A589}เพื่อทำการทดสอบการขับรถของคุณ");
			SendClientMessage(playerid, -1, "{F44336}---------------------------------{F4511E}Rule TestDriver{F44336}---------------------------------");
			SendClientMessage(playerid, -1, "1.ห้ามขับรถแล้วทำให้รถ เสียหายแม้แต่นิดเดียว");
			SendClientMessage(playerid, -1, "2.ห้ามขับด้วยความเร็วเกิน 60 กิโลเมตรต่อชั่วโมง");
			SendClientMessage(playerid, -1, "{F44336}---------------------------------{F4511E}Rule TestDriver{F44336}---------------------------------");
			SendClientMessage(playerid, COLOR_RED, "ห้ามนำรถนี้ไปใช้ในการเล่นบทบาทอื่นๆที่ไม่มีความเกี่ยวข้องใดๆกับ การทดสอบขับรถนี้ หากพบเห็น จะทำการส่ง");
			SendClientMessage(playerid, COLOR_RED, "คุกแอดมิน ตามกฎที่ได้ให้ไว้");
			return 1;
		}
	}
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerTaxiExam[playerid])
	{
		if(PlayerTaxiPoint[playerid] == 28)
		{	
			new Float:health, vehicleid = PlayersTaxiVehicle[playerid];
			GetVehicleHealth(vehicleid,health);

			if(health < 1000)
			{
				SendErrorMessage(playerid, "คุณไม่ผ่านการทดสอบนี้เนื่องจากยานพาหนะที่ทำการทดสอบได้รับความเสียหาย");
				SendClientMessage(playerid, COLOR_ORANGE, "คุณจำเป็นต้องจ่ายค่าชดใช้ในการทำยานพาหนะของ สำนักงานเสียหาย เป็นจำนวนเงิน $1,500");
				GiveMoney(playerid, -1500);
				GlobalInfo[G_GovCash] +=1500;
				StopTaxiDiverTest(playerid);
				return 1;
			}

			SendClientMessageEx(playerid, COLOR_DARKGREEN, "สำเร็จ %s ได้ผ่านการทดสอบใบขับขี่แล้ว", ReturnName(playerid, 0));
			PlayerInfo[playerid][pTxaiLicense] = true;
			StopTaxiDiverTest(playerid);
			return 1;
		}
		else
		{
			PlayerTaxiPoint[playerid]++;
			PlayerTaxiTime[playerid] += 5;

			new idx = PlayerTaxiPoint[playerid];
			SetPlayerCheckpoint(playerid, LicenseTaxiInfo[idx][eCheckpointX], LicenseTaxiInfo[idx][eCheckpointY], LicenseTaxiInfo[idx][eCheckpointZ], 3.0);
		}
		return 1;
	}
	return 1;
}

stock StopTaxiDiverTest(playerid)
{
	SetVehicleToRespawn(PlayersTaxiVehicle[playerid]);
	PlayerTaxiExam[playerid] = false;
	PlayerTaxiTime[playerid] = 0;
	PlayerTaxiPoint[playerid] = -1;
	PlayersTaxiVehicle[playerid] = INVALID_VEHICLE_ID;
	DisablePlayerCheckpoint(playerid);
	return 1;
}

stock ClearPlayerTaxitInfo(playerid)
{
	PlayerTaxitInfo[playerid][T_Value] = 0;
	PlayerTaxitInfo[playerid][T_Start] = false;
	PlayerTaxitInfo[playerid][T_Ptaget] = INVALID_PLAYER_ID;
	PlayerTaxitInfo[playerid][T_Vehicle] = INVALID_VEHICLE_ID;
	PlayerTaxitInfo[playerid][T_Scount] = 0;
	SetPlayerColor(playerid, COLOR_FACTIONCHAT);
	return 1;
}

ptask TimeCountTaxiTest[1000](playerid) 
{
	if(PlayerTaxiExam[playerid])
	{
		if(!PlayerTaxiTime[playerid])
		{
			SendErrorMessage(playerid, "คุณใช่เวลาการในทดสอบการขับขี่เพื่อเป็นพนักงานรับส่งผู้โดยสารนานเกินไป คุณสอบไม่ผ่าน");
			StopTaxiDiverTest(playerid);
			return 1;
		}

		new str[65];
		format(str, sizeof(str), "TIME %d",PlayerTaxiTime[playerid]);
		GameTextForPlayer(playerid, str, 1000, 3);
		PlayerTaxiTime[playerid]--;
	}
	return 1;
}


hook OnPlayerConnect(playerid)
{
	PlayerTaxiDuty[playerid] = false;
	StopTaxiDiverTest(playerid);
	ClearPlayerTaxitInfo(playerid);
	return 1;
}

CMD:taxicmds(playerid, params[])
{
	if(!PlayerInfo[playerid][pTxaiLicense])
		return SendErrorMessage(playerid, "คุณไม่มีใบอนุญาตการขับขี่ยานพาหนะ TAXI");
	
	SendClientMessage(playerid, COLOR_DARKGREEN, "___________www.lsrplite.xyz___________");
	SendClientMessage(playerid, COLOR_GRAD2,"[TAXI] /taxiduty /taxisetting /taxistart");
	SendClientMessage(playerid, COLOR_GREEN,"_____________________________________");
	SendClientMessage(playerid, COLOR_GRAD1,"โปรดศึกษาคำสั่งในเซิร์ฟเวอร์เพิ่มเติมในฟอรั่มหรือ /helpme เพื่อขอความช่วยเหลือ");

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerTaxiDuty[playerid] = false;
	StopTaxiDiverTest(playerid);

	return 1;
}

CMD:taxiexam(playerid, params[])
{
    if(!IsPlayerInTaxiVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไมไ่ด้อยู่บนยานพาหนะทดสอบการขับขี่");

    if(!PlayerInfo[playerid][pDriverLicense])
        return SendErrorMessage(playerid, "คุณยังไม่มีใบขับขี่");

    if(PlayerInfo[playerid][pTxaiLicense])
        return SendErrorMessage(playerid, "คุณมีใบอนุญาตการขับขี่ยานพาหนะ TAXI แล้ว");

	new vehicleid = GetPlayerVehicleID(playerid);

    PlayerTaxiExam[playerid] = true;
    PlayerTaxiTime[playerid] = 25;
	PlayerTaxiPoint[playerid] = 0;
	
	PlayersTaxiVehicle[playerid] = vehicleid;
	ToggleVehicleEngine(vehicleid, true); 
	VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
	TogglePlayerControllable(playerid, 1);

	SetPlayerCheckpoint(playerid, LicenseTaxiInfo[0][eCheckpointX], LicenseTaxiInfo[1][eCheckpointY], LicenseTaxiInfo[2][eCheckpointZ], 3.0);
    return 1;
}

CMD:taxiduty(playerid, params[])
{
	if(!PlayerInfo[playerid][pTxaiLicense])
        return SendErrorMessage(playerid, "คุณไม่มีใบอนุญาตการขับขี่ยานพาหนะ TAXI");
	
	if(!IsInTaxiVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพหานะสำหรับการทำงาน TAXI");
	
	if(PlayerTaxiDuty[playerid])
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "คุณหยุดทำงานเป็นพนักงานขับรถส่งผู้ดูสาร ประเภท TAXI");
		SetPlayerColor(playerid, COLOR_WHITE);
		PlayerTaxiDuty[playerid] = false;
		return 1;
	}
	else
	{
		SendClientMessage(playerid, COLOR_DARKGREEN, "คุณเริ่มทำงานเป็นพนักงานขับรถส่งผู้ดูสาร ประเภท TAXI");
		SetPlayerColor(playerid, COLOR_FACTIONCHAT);
		PlayerTaxiDuty[playerid] = true;
	}
	return 1;
}

CMD:taxisetting(playerid, params[])
{
	if(!PlayerTaxiDuty[playerid])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เริ่มทำงานเป็นพนักงานขับรถส่งผู้โดยสาร ประเภท TAXI");

	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(vehicleid) != 420 && GetVehicleModel(vehicleid) != 438)
		return SendErrorMessage(playerid, "ยานพาหนะของคุณไม่ใช่ TAXI หรือ Cabbie");

	new str[255], longstr[255];

	format(str, sizeof(str), "TAXI ONDUTY: {27AE60}Duty\n");
	strcat(longstr, str);
	format(str, sizeof(str), "METER: $%s", MoneyFormat(PlayerTaxitInfo[playerid][T_Value]));
	strcat(longstr, str);

	Dialog_Show(playerid, D_TAXI_SETTING, DIALOG_STYLE_LIST, "TAXI SETTING", longstr, "ยืนยัน", "ยกเลิก");
	return 1;
}

Dialog:D_TAXI_SETTING(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;
	
	switch(listitem)
	{
		case 0: return callcmd::taxisetting(playerid, "");
		case 1: return Dialog_Show(playerid, D_TAXI_SETTING_VALUE, DIALOG_STYLE_INPUT, "METER", "ใส่ราคา Meter เข้าไปเพื่อเป็นการตั้งราคา", "ยืนยัน", "ยกเลิก");
	}
	return 1;
}

Dialog:D_TAXI_SETTING_VALUE(playerid, response, listitem, inputtext[])
{

	if(!response)
		return callcmd::taxisetting(playerid, "");

	new value = strval(inputtext);

	if(value < 1 || value > 100)
		return Dialog_Show(playerid, D_TAXI_SETTING_VALUE, DIALOG_STYLE_INPUT, "METER", "คุณใส่ราคา Meter ไม่ถูกต้องกรุณาใส่ให้ถูกต้อง (1-100)", "ยืนยัน", "ยกเลิก");
	
	PlayerTaxitInfo[playerid][T_Value] = value;
	SendClientMessageEx(playerid, COLOR_YELLOW, "คุณได้ทำการตั้งค่า METER ของคุณเป็นราคาเริ่มต้นคือ $%d",value);
	return 1;
}

CMD:taxistart(playerid, params[])
{
	if(!PlayerTaxiDuty[playerid])
		return SendErrorMessage(playerid, "คุณยังไม่ได้เริ่มทำงานเป็นพนักงานขับรถส่งผู้โดยสาร ประเภท TAXI");
	
	if(!PlayerTaxitInfo[playerid][T_Value])
		return SendErrorMessage(playerid, "คุณยังไม่ได้ทำการตั้งราคา Meter ของคุณ");

	if(PlayerTaxitInfo[playerid][T_Ptaget] != INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "คุณยังมีการรับส่งผู้โดยสารอยู่");

	new tagetid;
	
	if(sscanf(params, "u", tagetid))
		return SendUsageMessage(playerid, "/taxistart <ชื่อบางส่วน/ไอดี>");

	if(tagetid == playerid)
		return SendErrorMessage(playerid, "คุณไม่สามารถใช้คำสั่งนี้กับตัวเองได้");

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

	new vehicleid = GetPlayerVehicleID(tagetid);
	
	if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่บนยานพาหนะของคุณ");

	PlayerTaxitInfo[playerid][T_Start] = true;
	PlayerTaxitInfo[playerid][T_Ptaget] = tagetid;
	SetPlayerColor(playerid, COLOR_ORANGE);
	return 1;
}

ptask TaxiStart[2000](playerid) 
{
	if(PlayerTaxitInfo[playerid][T_Start])
	{
		new tagetid = PlayerTaxitInfo[playerid][T_Ptaget];

		if(!IsPlayerConnected(tagetid))
		{
			SendErrorMessage(playerid, "ผู้เล่นได้มีการออกจากเกมส์");
			ClearPlayerTaxitInfo(playerid);
			return 1;
		}

		if(GetPlayerVehicleID(tagetid) != GetPlayerVehicleID(playerid))
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "ผู้โดยสารได้มีการลงจากรถของคุณ คุณได้รับงานสำหรับค่าโดยสารจำนวน $%s",MoneyFormat(PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]));
			SendClientMessageEx(tagetid, COLOR_LIGHTRED,"คุณได้มีการลงจากรถคุณได้เสียค่าโดยสาร จำนวน $%s",MoneyFormat(PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]));
			GiveMoney(playerid, PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]);
			GiveMoney(tagetid, -PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]);

			PlayerTaxitInfo[playerid][T_Start] = false;
			PlayerTaxitInfo[playerid][T_Scount] = false;
			PlayerTaxitInfo[playerid][T_Ptaget] = INVALID_PLAYER_ID;
			SetPlayerColor(playerid, COLOR_FACTIONCHAT);
			return 1;
		}

		if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) < 20)
		{
			new str[120];
			format(str, sizeof(str), "METER $%s",MoneyFormat(PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]));
			
			GameTextForPlayer(playerid, str, 2000, 3);
			GameTextForPlayer(PlayerTaxitInfo[playerid][T_Ptaget], str, 2000, 3);
			return 1;
		}

		new str[120];
		format(str, sizeof(str), "METER $%s",MoneyFormat(PlayerTaxitInfo[playerid][T_Scount] * PlayerTaxitInfo[playerid][T_Value]));
		
		GameTextForPlayer(playerid, str, 2000, 3);
		GameTextForPlayer(PlayerTaxitInfo[playerid][T_Ptaget], str, 2000, 3);
		PlayerTaxitInfo[playerid][T_Scount]++;
		return 1;
	}
	return 1;
}



#include <YSI_Coding\y_hooks>

new electrician_icon;

new electrician_vehicles[4];

new const Float:GoFixElePlace[50][3] = {
	{2071.5051,-1761.4661,13.5518},
	{2061.9060,-1743.0332,13.5469},
	{2087.2632,-1742.2206,13.5496},
    {2111.1458,-1742.4475,13.5547},
    {2172.0210,-1761.5598,13.5524},
    {1844.9083,-1923.1412,13.5469},
    {1309.8892,-1390.0150,13.4944},
    {1289.5519,-1414.5155,13.3457},
    {1331.5541,-1414.6498,13.5480},
    {2138.4106,-1467.9315,23.9820},
    {2137.9092,-1433.8879,23.9872},
    {2138.1287,-1399.9520,23.9859},
    {2148.2219,-1375.0604,23.9844},
    {2124.7351,-1375.1117,23.9844},
    {2099.7920,-1374.5096,23.9901},
    {2164.0718,-1393.9847,23.9844},
    {2187.9778,-1393.4795,23.9844},
    {2182.7712,-1375.2550,23.9870},
    {2227.8816,-1393.9188,24.0036},
    {2252.0183,-1394.1692,24.0043},
    {2280.5906,-1281.9570,23.9974},
    {2261.3577,-1229.8167,23.9766},
    {2219.3184,-1212.2307,23.9562},
    {2165.0911,-1200.4421,24.0316},
    {2133.7751,-1230.2777,23.9766},
    {2053.4229,-1145.3937,23.9950},
    {2039.0040,-1126.5861,24.3927},
    {2009.1179,-1126.2021,25.2633},
    {1926.6514,-1126.1129,25.1477},
    {1876.6509,-1125.2754,23.9136},
    {1837.2920,-1369.4989,13.5625},
    {1822.6068,-1543.7896,13.3900},
    {2295.3623,-1741.2587,13.5469},
    {2492.2292,-1648.4899,13.5366},
    {2415.6094,-1668.2460,13.5469},
    {2314.1750,-1671.4043,14.1522},
    {2202.9211,-1482.5472,23.9844},
    {2272.0356,-1458.3151,23.3914},
    {2334.2883,-1428.5247,24.0000},
    {2403.9795,-1434.0383,24.0000},
    {2539.3750,-1515.5809,23.9750},
    {2723.6558,-2014.4597,13.5472},
    {2751.0806,-1983.4332,13.5500},
    {2779.2622,-1939.8789,13.5394},
    {2758.7981,-1923.8022,13.5432},
    {787.6868,-1384.9188,13.7394},
    {806.4556,-1364.3446,13.5469},
    {804.1456,-1032.7946,25.1049},
    {786.9918,-1029.8816,25.2201},
    {442.6496,-1306.2279,15.1588}
};
new FixElePos[MAX_PLAYERS];
new PlayerObjectEle[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
    FixElePos[playerid] = 0;
    return 1;
}

hook OnGameModeInit()
{
    electrician_icon = CreateDynamicPickup(1239, 2, 2076.7122,-2026.7233,13.5469,-1,-1);

    electrician_vehicles[0] = AddStaticVehicle(552,2079.4280,-2006.4912,13.2500,272.9224,1,1); SetVehicleNumberPlate(electrician_vehicles[0], "ELECTRICIAN");
    electrician_vehicles[1] = AddStaticVehicle(552,2079.1851,-2019.5999,13.2428,271.2447,1,1); SetVehicleNumberPlate(electrician_vehicles[1], "ELECTRICIAN");
    electrician_vehicles[2] = AddStaticVehicle(552,2078.7402,-2033.1204,13.2460,270.0531,1,1); SetVehicleNumberPlate(electrician_vehicles[2], "ELECTRICIAN");
    electrician_vehicles[3] = AddStaticVehicle(552,2079.1179,-2047.5087,13.2448,267.0158,1,1); SetVehicleNumberPlate(electrician_vehicles[3], "ELECTRICIAN");
    
    for(new i = 0; i < sizeof electrician_vehicles; i++)
    {
        VehicleInfo[electrician_vehicles[i]][eVehicleFuel] = 100;
        VehicleInfo[electrician_vehicles[i]][eVehicleEngine] = 100;
        VehicleInfo[electrician_vehicles[i]][eVehicleCarPark] = false;
    }
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == electrician_icon)
    {
        SendClientMessage(playerid, -1, "พิพม์ /takejob เพื่อสมัครงานช่างซ่อมไฟฟ้า");
        return 1;
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
    {
        for(new i = 0; i < sizeof electrician_vehicles; i++) if(vehicleid == electrician_vehicles[i])
		{
			if(PlayerInfo[playerid][pJob] != JOB_ELECTRICIAN)
			{
				SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างซ่อมไฟฟ้า");
				return ClearAnimations(playerid);
			}
		}
    }
    return 1;
}

CMD:getstair(playerid, params[])
{
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

        new modelid = GetVehicleModel(vehicleid);

        if(modelid != 552)
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะสำหรับการซ่อมไฟฟ้า");
            
        if(VehicleInfo[vehicleid][eVehicleLocked])
            return SendServerMessage(playerid, "ยานพาหนะคันนี้ถูกล็อคอยู่");

        if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
            return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ท้ายยานพาหนะ");

        if(GetPVarInt(playerid, "GetStair"))
        {
            PlaceStair(playerid);
        }
        else GetStair(playerid);
        return 1;
    }
    else SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะสำหรับการซ่อมไฟฟ้า");
    return 1;
}

CMD:fixele(playerid, params[])
{   
    if(!FixElePos[playerid])
        return SendErrorMessage(playerid, "พิพม์ /startele เพื่อเริ่มงาน");


    if(!IsPlayerInRangeOfPoint(playerid, 2.0, GoFixElePlace[FixElePos[playerid]][0], GoFixElePlace[FixElePos[playerid]][1], GoFixElePlace[FixElePos[playerid]][2]))
    {
        SendErrorMessage(playerid, "คุณไม่ได้อยู่ในจุดซ่อมเสาไฟฟ้าที่ชำรุด ไปตามจุดที่เรามาร์ากไว้ให้คุณ");
        SetPlayerCheckpoint(playerid, GoFixElePlace[FixElePos[playerid]][0], GoFixElePlace[FixElePos[playerid]][1], GoFixElePlace[FixElePos[playerid]][2], 2);
        return 1;      
    }

    if(!GetPVarInt(playerid, "GetStair"))
        return SendErrorMessage(playerid, "คุณยังไม่ได้นำบรรไดออกมาจากท้ายรถ");

    if(IsValidDynamicObject(PlayerObjectEle[playerid]))
        DestroyDynamicObject(PlayerObjectEle[playerid]);

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    PlayerObjectEle[playerid] = CreateDynamicObject(1437, x, y, z-10, 0.0, 0.0, a, 0, 0,-1);
    MoveDynamicObject(PlayerObjectEle[playerid],x, y,z, 50000,0,0,a);

    new Float:OX, Float:OY, Float:OZ;
    GetDynamicObjectPos(PlayerObjectEle[playerid],OX,OY,OZ);
    SetPlayerPos(playerid, OX, OY, OZ+10);
    TogglePlayerControllable(playerid, 0);
    PlaceStair(playerid);

    SetTimerEx("OnRepiarEle", 10000, false, "dfff",playerid, OX, OY, OZ);
    return 1;
}


CMD:startele(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_ELECTRICIAN)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างซ่อมไฟ");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 552)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะสำหรับการซ่อมไฟฟ้า");

    if(FixElePos[playerid])
    {
        SendErrorMessage(playerid, "คุณมีจุดไฟที่ยังไม่ได้ซ่อม");
        SendClientMessage(playerid, -1, "ไปตามจุดแล้วพิพม์ /fixele เพื่อซ่อมเสาไฟฟ้าที่ชำรุดเสียหาย");
        SetPlayerCheckpoint(playerid, GoFixElePlace[FixElePos[playerid]][0], GoFixElePlace[FixElePos[playerid]][1], GoFixElePlace[FixElePos[playerid]][2], 2);
        return 1;
    }

    new timestart =  GetPVarInt(playerid, "TimeDeley");

    if(gettime() - timestart < 30)
        return SendErrorMessage(playerid, "กรุณารอ 2 นาทีก่อนที่จะไปซ่อมไฟฟ้า");

    new randdom = Random(1, 50);
    FixElePos[playerid] = randdom;
    SendClientMessage(playerid, -1, "ไปตามจุดที่เราได้มาร์ากไว้ให้คุณแล้วพิพม์ /fixele เพื่อซ่อมเสาไฟฟ้าที่ชำรุดเสียหาย");
    SetPlayerCheckpoint(playerid, GoFixElePlace[FixElePos[playerid]][0], GoFixElePlace[FixElePos[playerid]][1], GoFixElePlace[FixElePos[playerid]][2], 2);
    return 1;
}


forward OnRepiarEle(playerid, Float:x, Float:y, Float:z);
public OnRepiarEle(playerid, Float:x, Float:y, Float:z)
{
    SetPlayerPos(playerid, x, y, z);
    TogglePlayerControllable(playerid, 1);
    GetStair(playerid);
    DisablePlayerCheckpoint(playerid);
    FixElePos[playerid] = 0;

    if(IsValidDynamicObject(PlayerObjectEle[playerid]))
        DestroyDynamicObject(PlayerObjectEle[playerid]);


    new money = Random(50, 100);

    SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้ทำการซ่อมเสาไฟฟ้าที่ชำรุดสำเร็จเสร็จสิ้นแล้ว ได้เงินมาจำนวน $%s", MoneyFormat(money));
    SendClientMessageEx(playerid, COLOR_DEPT, "เสียภาษีรายได้ ร้อยละ 0.07 ($%s)",MoneyFormat(floatround(money * 0.07, floatround_round)));

    GiveMoney(playerid, money - floatround(money * 0.07, floatround_round));
    GlobalInfo[G_GovCash]+=floatround(money * 0.07, floatround_round);
    SetPVarInt(playerid, "TimeDeley",gettime());
    CharacterSave(playerid);
    return 1;
}

stock IsPlayerInElecVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof electrician_vehicles; i++)
	{
		if(vehicleid == electrician_vehicles[i])
			return 1;
	}
		
	return 0;
}

stock IsElecVehicle(vehicleid)
{
	for(new c = 0; c < sizeof electrician_vehicles; c++) if(vehicleid == electrician_vehicles[c]) return 1;
	return 0;
}

stock GetStair(playerid)
{
    SetPVarInt(playerid, "GetStair",1);
    ApplyAnimation(playerid, "CARRY","liftup", 4.1, 0, 0, 0, 0, 0, 1);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    SetPlayerAttachedObject(playerid, 9, 1437, 1, 0.014000, 0.357999, 0.405001, 179.600021, -9.899999, -90.200012, 1.0, 1.0, 1.0);
    SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s หยิบบรรไดออกมาจากท้ายรถ และถือไว้ด้วยมือทั้งสองข้าง",ReturnName(playerid,0));
    return 1;
}

stock PlaceStair(playerid)
{
    DeletePVar(playerid, "GetStair");
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, 9);
    SendNearbyMessage(playerid, 3.0, COLOR_EMOTE, "> %s วางบรรไดเก็บไว้ที่ท้ายรถ",ReturnName(playerid,0));
    return 1;
}

// /SetPlayerAttachedObject(playerid, 9, 1437, 1, 0.014000, 0.357999, 0.405001, 179.600021, -9.899999, -90.200012, 1.0, 1.0, 1.0);



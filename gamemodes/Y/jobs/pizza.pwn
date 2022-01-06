#include <YSI_Coding\y_hooks>


new pizza_veh[5];
new PizzaPosID[MAX_PLAYERS];
new PizzaStock[MAX_VEHICLES];
new bool:PlayerStartJobPizza[MAX_PLAYERS];

new const Float:GoPosPizza[58][3] = {
	{2076.9849,-1732.4987,12.9815},
    {2078.0200,-1717.2017,12.9855},
    {2077.3823,-1703.5107,12.9888},
    {2077.5588,-1655.7640,12.9902},
    {2077.7288,-1642.7772,12.9865},
    {2077.9160,-1628.4099,12.9838},
    {2006.1375,-1629.4358,12.9825},
    {2006.3010,-1641.7679,12.9792},
    {2006.3010,-1641.7679,12.9792},
    {2005.8010,-1656.0002,12.9823},
    {2006.3672,-1703.8297,12.9794},
    {2005.7749,-1717.7201,12.9825},
    {2006.2148,-1733.1230,12.9835},
    {1997.3394,-1728.0208,12.9788},
    {1971.5193,-1707.0225,15.5649},
    {1972.2728,-1672.2909,15.5643},
    {1971.2510,-1655.9199,15.5671},
    {1993.4369,-1336.5187,23.4202},
    {2026.4337,-1336.7932,23.4201},
    {2136.8005,-1379.4460,23.4249},
    {2134.1985,-1417.7814,23.4317},
    {2134.3027,-1433.1467,23.4236},
    {2133.5869,-1454.3865,23.4263},
    {2133.7732,-1477.5043,23.4265},
    {2208.4883,-1469.7438,23.4152},
    {2208.6531,-1457.1235,23.4150},
    {2208.0483,-1435.3259,23.4236},
    {2208.6904,-1410.5073,23.4248},
    {2194.1953,-1380.1650,23.4281},
    {2230.4070,-1389.2625,23.5104},
    {2243.1851,-1388.6177,23.4239},
    {2255.5286,-1388.9521,23.4297},
    {2263.9055,-1479.4950,22.4374},
    {2247.3301,-1480.1686,22.8277},
    {2232.0703,-1479.1355,23.2358},
    {2256.0188,-1296.4160,23.4272},
    {2232.5059,-1296.2699,23.4228},
    {2209.6204,-1296.1217,23.4144},
    {2149.7483,-1296.1514,23.4249},
    {2135.2791,-1296.9493,23.4259},
    {2095.3618,-1296.3521,23.4174},
    {2090.6069,-1225.1359,23.4033},
    {2105.3701,-1225.6376,23.4610},
    {2134.8411,-1224.7754,23.4182},
    {2150.8696,-1225.8088,23.4964},
    {2192.2515,-1225.0719,23.4127},
    {2208.0403,-1225.3699,23.4081},
    {2242.4104,-1225.2023,23.4075},
    {2494.4492,-1683.6847,12.9364},
    {2504.5417,-1680.1877,12.9797},
    {2507.3171,-1662.4982,13.0100},
    {2486.7644,-1654.3209,12.9280},
    {2470.2478,-1654.3630,12.9319},
    {2452.3181,-1654.3312,12.9046},
    {2415.0811,-1654.4628,12.9806},
    {2392.9675,-1654.0669,12.9794},
    {2361.1060,-1654.2814,12.9753},
    {2338.1978,-1682.5581,12.9559}

};

hook OnGameModeInit()
{
    pizza_veh[0] = AddStaticVehicleEx(448,2125.3569,-1821.4640,13.1503,269.8213,3,3, -1); // Pizza Stack Veh 1
    pizza_veh[1] = AddStaticVehicleEx(448,2125.3518,-1819.9165,13.1535,267.8990,3,3, -1); // Pizza Stack Veh 2
    pizza_veh[2] = AddStaticVehicleEx(448,2125.2891,-1818.3237,13.1548,268.6492,3,3, -1); // Pizza Stack Veh 3
    pizza_veh[3] = AddStaticVehicleEx(448,2125.1431,-1816.7518,13.1532,268.9932,3,3, -1); // Pizza Stack Veh 4
    pizza_veh[4] = AddStaticVehicleEx(448,2125.2097,-1815.1683,13.1549,264.8887,3,3, -1); // Pizza Stack Veh 5

    for(new i = 0; i < sizeof pizza_veh; i++)
    {
        SetVehicleNumberPlate(pizza_veh[i], "PIZZA");
        SetVehicleToRespawnEx(pizza_veh[i]);
        SetVehicleHp(pizza_veh[i]);
        VehicleInfo[pizza_veh[i]][eVehicleFuel] = 100.0;
        VehicleInfo[pizza_veh[i]][eVehicleEngine] = 100.0;
        VehicleInfo[pizza_veh[i]][eVehicleBattery] = 100.0;
        SetTimerEx("VehicleReset_Pizza", 1800000, true, "d", i);
    }

    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(IsPlayerInPizzaVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        
        if(PlayerCheckpoint[playerid] == 11)
        {
            PizzaStock[vehicleid]--;
            GiveMoney(playerid, 65);
            GlobalInfo[G_GovCash]+= 350;
            CharacterSave(playerid);

            SendClientMessageEx(playerid, COLOR_LIGHTGREEN, "คุณได้รับเงินจำนวน $%s จากการส่งอาหาร",MoneyFormat(200));

            if(!PizzaStock[vehicleid])
            {
                DisablePlayerCheckpoint(playerid);
                SendClientMessage(playerid, COLOR_LIGHTRED, "คุณได้ส่งอาหารหมดแล้ว ขับรถกลับไปที่จุดที่เราได้กำหนดไว้ให้");
                PlayerCheckpoint[playerid] = 12;
                SetPlayerCheckpoint(playerid, 2125.7920,-1791.8077,13.5547, 3.0);
            }
            else
            {
                PizzaPosID[playerid] = Random(0,57);
                SetPlayerCheckpoint(playerid, GoPosPizza[PizzaPosID[playerid]][0], GoPosPizza[PizzaPosID[playerid]][1], GoPosPizza[PizzaPosID[playerid]][2], 3.0);
                SendClientMessageEx(playerid, COLOR_GREY, "คุณมีอาหารเหลืออยู่จำนวน %d ถาด",PizzaStock[GetPlayerVehicleID(playerid)]);
                SendClientMessage(playerid, COLOR_ORANGE, "ไปตามจุดที่เราได้มร์ากไว้");
            }
        }
        else if(PlayerCheckpoint[playerid] == 12)
        {
            PlayerStartJobPizza[playerid] = false;
            SetVehicleToRespawnEx(GetPlayerVehicleID(playerid));
            DisablePlayerCheckpoint(playerid);
            PlayerCheckpoint[playerid] = 0;
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerStartJobPizza[playerid] = false;
    return 1;
}

ptask Vehicle_ResetPizza[1800000]() 
{
    for(new i = 0; i < sizeof pizza_veh; i++)
    {
        if(IsVehicleOccupied(i))
		    continue;

        SetVehicleToRespawnEx(pizza_veh[i]);
    }
    return 1;
}


stock IsPlayerInPizzaVehicle(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof pizza_veh; i++)
	{
		if(vehicleid == pizza_veh[i])
			return 1;
	}
    return 1;
}


CMD:pizzacmds(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN, "----------- PIZZA STACK JOB -----------");

    SendClientMessage(playerid, -1, "/startpizza - เริ่มทำงาน ต้องอยู่บนรถที่เตรียมไว้");
    SendClientMessage(playerid, -1, "/stoppizza - หยุดทำงาน");

    SendClientMessage(playerid, COLOR_DARKGREEN, "----------- PIZZA STACK JOB -----------");
    return 1;
}

CMD:stoppizza(playerid, params[])
{
    if(!PlayerStartJobPizza[playerid])
        return SendErrorMessage(playerid, "คุณได้ยกเลิกการทำงาน ส่งอาหารอยู่แล้ว");

    
    SendClientMessage(playerid, COLOR_GREY, "คุณได้หยุดการทำงานแล้วกรุณานำยานพาหนะไปคืนเรา");
    DisablePlayerCheckpoint(playerid);
    PlayerCheckpoint[playerid] = 12;
    SetPlayerCheckpoint(playerid, 2125.7920,-1791.8077,13.5547, 3.0);
    PlayerStartJobPizza[playerid] = false;
    PizzaPosID[playerid] = 0;
    return 1;
}

CMD:startpizza(playerid, params[])
{
    if(!IsPlayerInPizzaVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ Pizza");

    if(PlayerStartJobPizza[playerid])
        return SendErrorMessage(playerid, "คุณทำงานส่ง อาหารอยู่แล้ว");

    PlayerStartJobPizza[playerid] = true;

    new vehicleid = GetPlayerVehicleID(playerid);
    
    PizzaStock[vehicleid] = Random(1,10);
    PizzaPosID[playerid] = Random(0,57);


    SendClientMessage(playerid, COLOR_ORANGE, "[!] ยินดีตอนรับสู่การเริ่มงานเป็นพนักงานส่งอาหาร");
    SendClientMessageEx(playerid, COLOR_GREY, "คุณได้รับถาดอาหารมาจำนวน %d ถาดกรุณานำมันไปส่งตามที่อยู่นี้", PizzaStock[vehicleid]);
    
    ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s สตาร์ทเครื่องยนต์ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
    TogglePlayerControllable(playerid, 1);

    PlayerCheckpoint[playerid] = 11;
    SetPlayerCheckpoint(playerid, GoPosPizza[PizzaPosID[playerid]][0], GoPosPizza[PizzaPosID[playerid]][1], GoPosPizza[PizzaPosID[playerid]][2], 3.0);
    return 1;
}



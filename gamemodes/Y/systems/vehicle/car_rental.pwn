#include <YSI_Coding\y_hooks>

// Static Vehicle

hook OnGameModeInit()
{
    rental_vehicles[0] = AddStaticVehicleEx(492,1664.2168,-2248.0488,-2.9842,90.2306,223,0, -1);
    rental_vehicles[1] = AddStaticVehicleEx(492,1653.5485,-2313.4810,-2.9741,269.5144,223,0, -1);

	rental_vehicles[2] = AddStaticVehicleEx(492,1560.7415,-2308.8511,13.3286,269.5454,223,0, -1);
	rental_vehicles[3] = AddStaticVehicleEx(492,1560.7153,-2312.1589,13.3285,269.5454,223,0, -1);
	rental_vehicles[4] = AddStaticVehicleEx(492,1560.6952,-2315.5034,13.3498,269.5466,223,0, -1);
	rental_vehicles[5] = AddStaticVehicleEx(422,1560.6693,-2318.7683,13.3567,269.5466,223,0, -1);
	rental_vehicles[6] = AddStaticVehicleEx(422,1560.6440,-2321.9934,13.3636,269.5466,223,0, -1);
	rental_vehicles[7] = AddStaticVehicleEx(422,1560.6185,-2325.2891,13.3706,269.5466,223,0, -1);
	rental_vehicles[8] = AddStaticVehicleEx(492,1560.5928,-2328.5264,13.3775,269.5466,223,0, -1);
	rental_vehicles[9] = AddStaticVehicleEx(492,1560.5668,-2331.8062,13.3845,269.5466,223,0, -1);


	rental_vehicles[10] = AddStaticVehicleEx(462,1565.0138,-2343.3386,13.1463,90.7493,223,219, -1);
	rental_vehicles[11] = AddStaticVehicleEx(462,1565.1428,-2344.2258,13.1456,88.5780,223,117, -1);
	rental_vehicles[12] = AddStaticVehicleEx(462,1565.0927,-2345.1797,13.1466,95.9593,223,87, -1);
	rental_vehicles[13] = AddStaticVehicleEx(462,1565.0872,-2346.0618,13.1450,93.8681,223,228, -1);
	rental_vehicles[14] = AddStaticVehicleEx(462,1565.2903,-2347.0344,13.1454,90.4499,223,156, -1);


	rental_vehicles[15] = AddStaticVehicleEx(482,2466.847,-2118.495,13.677,2.850,2,2, -1);
    rental_vehicles[16] = AddStaticVehicleEx(482,2470.179,-2118.358,13.665,1447,2,2, -1);

	rental_vehicles[17] = AddStaticVehicleEx(492,2161.4648,-1143.6536,24.6362,91.3381,2,2, -1);
    rental_vehicles[18] = AddStaticVehicleEx(492,2161.4646,-1148.2813,24.1646,90.4821,2,2, -1);
	rental_vehicles[19] = AddStaticVehicleEx(492,2161.0586,-1152.7140,23.7260,89.6045,2,2, -1);
    rental_vehicles[20] = AddStaticVehicleEx(492,2161.4744,-1158.2817,23.6197,90.9343,2,2, -1);

	for(new c = 0; c < sizeof rental_vehicles; c++) {
    	SetVehicleNumberPlate(rental_vehicles[c], "RENTAL");
		format(VehicleInfo[rental_vehicles[c]][eVehiclePlates], 32, "RENTAL");
		SetVehicleParamsEx(rental_vehicles[c], 0, 0, 0, 0, 0, 0, 0);
		VehicleInfo[rental_vehicles[c]][eVehicleFuel] = 100;
        VehicleInfo[rental_vehicles[c]][eVehicleEngine] = 100;
	}

	return 1;
}

stock IsPlayerInRentalVehicle(playerid)
{
	new
		vehicleid = GetPlayerVehicleID(playerid);
	
	if(!vehicleid)
		return 0; 
		
	for(new i = 0; i < sizeof rental_vehicles; i++)
	{
		if(vehicleid == rental_vehicles[i])
			return 1;
	}
		
	return 0;
}

stock IsRentalVehicle(vehicleid)
{
	for(new c = 0; c < sizeof rental_vehicles; c++) if(vehicleid == rental_vehicles[c]) return 1;
	return 0;
}

stock IsPlayerRentVehicle(playerid, vehicleid)
{
	return RentCarKey[playerid] == vehicleid;
}

stock IsVehicleRented(vehicleid)
{
	foreach (new i : Player)
	{
		if(RentCarKey[i] == vehicleid) return 1;
	}
	return 0;
}

stock VehicleRentalPrice(model)
{
	switch(model)
	{
		case 482: return 300;
		case 462: return 350;
	    case 492: return 500;
	    case 422: return 550;
	}
	return 0;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
        new vehicleid = GetPlayerVehicleID(playerid);
		for(new i = 0; i < sizeof rental_vehicles; i++) if(vehicleid == rental_vehicles[i] && !IsVehicleRented(vehicleid))
		{
            new model = GetVehicleModel(vehicleid);
			SendClientMessageEx(playerid, COLOR_WHITE, "บริการเช่ายานพาหนะ: เช่า %s ในราคา %s (/rentvehicle)", ReturnVehicleName(vehicleid), MoneyFormat(VehicleRentalPrice(model)));
			SendClientMessage(playerid, COLOR_GREEN, "การเช่ายานพาหนะนี้ คุณจะสามารถใช้ /v lock มันได้");
			SendClientMessage(playerid,COLOR_WHITE,"ข้อแนะ: คุณสามารถออกจากรถด้วยการพิมพ์ /exitveh(icle)");
			TogglePlayerControllable(playerid, 0);
		}
	}
	
    return 1;
}

alias:rentvehicle("rentcar", "เช่ารถ")
CMD:rentvehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
    if(IsRentalVehicle(vehicleid))
    {
        if(RentCarKey[playerid] != vehicleid && !IsVehicleRented(vehicleid))
        {
			new cost = VehicleRentalPrice(GetVehicleModel(vehicleid));
			if(PlayerInfo[playerid][pCash] >= cost)
			{
			    RentCarKey[playerid] = GetPlayerVehicleID(playerid);
				VehicleInfo[vehicleid][eVehicleCarPark] = false;
				GiveMoney(playerid, -cost);

				SendClientMessage(playerid,COLOR_GREEN,"คุณได้เช่ายานพาหนะ (/unrentvehicle เพื่อเลิกเช่า)");
                SendClientMessage(playerid,COLOR_WHITE,"ข้อแนะ: คุณสามารถล็อกยานพาหนะที่เช่าด้วย /v lock");
                SendClientMessage(playerid,COLOR_WHITE,"/engine เพื่อสตาร์ท");
				TogglePlayerControllable(playerid, 1);
				return 1;
			}
			else return SendClientMessage(playerid, COLOR_GRAD1, "   คุณมีเงินไม่พอ !");
        }
        else return SendClientMessage(playerid, COLOR_LIGHTRED,"ยานพาหนะคันนี้ถูกเช่าแล้ว");
    }
    else return GameTextForPlayer(playerid, "~r~you're not in any vehicle.", 5000, 1);
}

CMD:unrentvehicle(playerid)
{
	if(RentCarKey[playerid] != 9999)
 	{
 	    SetVehicleToRespawn(RentCarKey[playerid]);
        RentCarKey[playerid] = 9999;

        return SendClientMessage(playerid,COLOR_GREEN,"คุณได้คืนยานพาหนะ");
 	}
 	else return GameTextForPlayer(playerid, "~r~you're not in any vehicle.", 5000, 1);
}

alias:exitvehicle("exitveh")
CMD:exitvehicle(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
		
	RemovePlayerFromVehicle(playerid);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

task rental_vehiclesalTimer[3600000]() {
	new bool:respawn;
	for(new c = 0; c < sizeof rental_vehicles; c++) {
		respawn = true;

		foreach (new i : Player) {
            if(gLastCar[i] == rental_vehicles[c] || RentCarKey[i] == rental_vehicles[c]) {
				respawn = false;
                break;
            }
        }

		if (respawn) {
         	SetVehicleToRespawn(rental_vehicles[c]);
			ResetVehicleVars(rental_vehicles[c]);
		}
	}
}
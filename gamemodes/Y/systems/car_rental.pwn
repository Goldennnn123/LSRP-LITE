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

	for(new c = 0; c < sizeof rental_vehicles; c++) {
    	SetVehicleNumberPlate(rental_vehicles[c], "RENTAL");
		ResetVehicleVars(rental_vehicles[c]);
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
	    case 492: return 1500;
	    case 422: return 2000;
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

task rental_vehiclesalTimer[300000]() {
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
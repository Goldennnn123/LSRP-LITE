#include <YSI_Coding\y_hooks>


/*CMD:infernus(playerid)
{
	ShowActionForPlayer(playerid, ActionInfernus, "Are you sure you want to spawn infernus", "Spawn car", .action_time = 10000);

	return 1;
}

Action:ActionInfernus(playerid, response)
{
	if (response == ACTION_RESPONSE_YES)
	{
		new Float:x, Float:y, Float:z, Float:ang;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, ang);

		new vehicleid = CreateVehicle(411,
			x + 2.5 * floatsin(-ang, degrees),
			y + 2.5 * floatcos(-ang, degrees),
			z + 0.3,
			ang,
			0,
			0,
			-1);

		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	} else {
		SendClientMessage(playerid, -1, "Spawn Car!! �մ͡5555+");
	}
}*/
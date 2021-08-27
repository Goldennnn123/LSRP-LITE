#include <YSI_Coding\y_hooks>
#define MAX_SPIKES (50)


enum S_SPIKE_DATA
{
    SpikeID,
    SpikeObjet,
    Float:SpikePos[6]
};
new SpikeData[MAX_SPIKES][S_SPIKE_DATA];


ptask PlayerTakeSpike[100](playerid) 
{
    for(new i = 1; i < MAX_SPIKES; i++)
    {
        if(!SpikeData[i][SpikeID])
            continue;
        
        if(IsPlayerInRangeOfPoint(playerid, 3.0, SpikeData[i][SpikePos][0], SpikeData[i][SpikePos][1], SpikeData[i][SpikePos][2]))
        {
            if(!IsPlayerInAnyVehicle(playerid))
            {
                return 1;
            }
            else
            {
                new vehicleid = GetPlayerVehicleID(playerid);
                GetVehicleDamageStatus(vehicleid, VehicleInfo[vehicleid][eVehicleDamage][0],VehicleInfo[vehicleid][eVehicleDamage][1],VehicleInfo[vehicleid][eVehicleDamage][2], VehicleInfo[vehicleid][eVehicleDamage][3]);
                
                if(VehicleInfo[vehicleid][eVehicleDamage][3]  >= 15)
                    return 1;

                UpdateVehicleDamageStatus(vehicleid,VehicleInfo[vehicleid][eVehicleDamage][0],VehicleInfo[vehicleid][eVehicleDamage][1],VehicleInfo[vehicleid][eVehicleDamage][2],15);
                SaveVehicle(vehicleid);
                SendNearbyMessage(playerid, 15.0, COLOR_YELLOW, "%s ถูก Spike ทำให้ยางแตกทั้งหมด (( %s ))", ReturnVehicleName(vehicleid), ReturnName(playerid,0));
                return 1;
            }
        }
    }
    return 1;
}
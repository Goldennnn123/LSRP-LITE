enum V_VEHFAC_DATA
{
    VehFacDBID,
    VehFacModel,
    VehFacFaction,

    VehFacColor[2],

    Float:VehFacPos[4],
    VehFacPosWorld,
}
new VehFacInfo[MAX_FACTION_VEHICLE][V_VEHFAC_DATA];
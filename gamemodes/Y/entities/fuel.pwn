#define MAX_FUELS (200)


enum F_FUEL_DATA
{
    F_ID,
    F_OwnerDBID,
    F_Business,
    Float:F_Fuel,
    F_Price,
    F_PriceBuy,
    
    F_Object,
    Float:F_Pos[6],
    
    Text3D:F_Text,
}
new FuelInfo[MAX_FUELS][F_FUEL_DATA];
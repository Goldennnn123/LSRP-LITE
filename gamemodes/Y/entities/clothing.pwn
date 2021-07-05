#define MAX_CLOTHING (100)
#define MAX_PLAYER_CLOTHING (6)

enum C_CLOTHING_DATA
{
    ClothingDBID,
    ClothingOwnerDBID,
    ClothingSpawn,
    ClothingModel,
    ClothingIndex,
    ClothingBone,
    Float:ClothingOffPos[3],
    Float:ClothingOffPosR[3],
    Float:ClothingOffPosSacal[3],
}

new ClothingInfo[MAX_CLOTHING][C_CLOTHING_DATA];
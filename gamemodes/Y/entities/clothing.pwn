#define MAX_CLOTHING (500)
#define MAX_PLAYER_CLOTHING (6)

enum C_CLOTHING_PLAYER
{
    C_ID,
    C_Owner,
    bool:C_Spawn,
    C_Model,
    C_Index,
    C_Bone,
    Float:C_OFFPOS[3],
    Float:C_OFFPOSR[3],
    Float:C_OFFPOSS[3],
}

new ClothingData[MAX_CLOTHING][C_CLOTHING_PLAYER];
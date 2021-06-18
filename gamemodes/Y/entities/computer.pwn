#define MAX_COMPUTER 100

enum COMPUTER_DATA
{
    ComputerDBID,
    ComputerOwnerDBID,
    bool:ComputerOn,

    ComputerCPU,
    ComputerRAM,
    ComputerGPU[5],
    ComputerStored,

    Float:ComputerPos[6],
    ComputerPosWorld,
    ComputerPosInterior,
    ComputerSpawn,
    ComputerStartBTC,
    Float:ComputerBTC,
    ComputerObject,
}
new ComputerInfo[MAX_COMPUTER][COMPUTER_DATA], ComputerEdit[MAX_PLAYERS];
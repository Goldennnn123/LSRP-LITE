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

    ComputerPos[6],
    ComputerPosWorld,
    ComputerPosInterior,
}
new ComputerInfo[MAX_COMPUTER][COMPUTER_DATA];
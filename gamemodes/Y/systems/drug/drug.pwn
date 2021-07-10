#include <YSI_Coding\y_hooks>
/*


    ยาเสพติดที่มี:
        - Cocain
        - Canabis
        - Heroine
*/

hook OnGameModeInit()
{

    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][pDrug][0] = 0.0;
    PlayerInfo[playerid][pDrug][1] = 0.0;
    PlayerInfo[playerid][pDrug][2] = 0.0;
    return 1;
}


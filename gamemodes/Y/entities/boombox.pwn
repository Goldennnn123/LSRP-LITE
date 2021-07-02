#define MAX_BOOMBOX (50)

enum B_BOOMBOX_DATA
{
    BoomBoxID,
    bool:BoomBoxSpawn,
    BoomBoxObject,
    Float:BoomBoxPos[6],
    BoomBoxWorld,
}
new BoomBoxInfo[MAX_BOOMBOX][B_BOOMBOX_DATA];
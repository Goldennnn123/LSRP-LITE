#define MAX_FINES 200
enum FINE_DATA
{
    FineDBID,
    FineOwner,
    FineReson[255],
    FinePrice,
    FineBy,
    FineDate[255],
}
new FineInfo[MAX_FINES][FINE_DATA];
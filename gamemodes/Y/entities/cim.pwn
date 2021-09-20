#define MAX_CIM (50)

enum CIM_DATA
{
    c_cimid,
    c_cimby,
    c_cimtext[120],
    c_cimtime[120],
    c_cimItem,
    Float:c_cimpos[3],
    c_cimworld
}
new CimInfo[MAX_CIM][CIM_DATA];

enum CIM_P_DATA
{
    c_cimpid,
    c_cimptime
}
new CimpInfo[MAX_PLAYERS][CIM_P_DATA];
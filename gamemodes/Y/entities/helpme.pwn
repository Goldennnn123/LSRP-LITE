#define MAX_HELPME 20
enum R_HELPME_DATA
{
    bool:hHelpmeExit,
    hHelpmeDBID,
    hHelpmeBy,
    hHelpmeDetel[255],
}
new HelpmeData[MAX_HELPME][R_HELPME_DATA];
new PlayerHelpme[MAX_PLAYERS][120];
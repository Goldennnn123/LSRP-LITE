#include <YSI_Coding\y_hooks>

#define MODEL_SELECTION_SKIN_MENU (0)
#define MODEL_CUSTOM_SKIN_MENU (0)


CMD:customskin(playerid, params[])
{
    if(!PlayerInfo[playerid][pFaction])
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ในเฟคชั่น");

    ShowCustomskin(playerid);
    return 1;
}

CMD:showskin(playerid, params[])
{
    ShowSkinModelMenu(playerid);
    return 1;
}

stock ShowCustomskin(playerid)
{
    new List:skins = list_new();

    new factionid = PlayerInfo[playerid][pFaction];

    for(new i = 1; i < 31; i++)
	{
		if(!CustomskinFacInfo[factionid][FactionSkin][i])
			continue;
			
		 AddModelMenuItem(skins, CustomskinFacInfo[factionid][FactionSkin][i]);
	}

    ShowModelSelectionMenu(playerid, "Skins", MODEL_CUSTOM_SKIN_MENU, skins);
    return 1;
}

stock ShowSkinModelMenu(playerid)
{
    new List:skins = list_new();

    if(IsPlayerAndroid(playerid) == false)
    {
        for(new i = 1; i < 301; i++)
            AddModelMenuItem(skins, i);

        for(new i = 29000; i < 29081; i++)
            AddModelMenuItem(skins, i);
    }
    else
    {
        for(new i = 1; i < 301; i++)
            AddModelMenuItem(skins, i);
    }

    ShowModelSelectionMenu(playerid, "Skins", MODEL_SELECTION_SKIN_MENU, skins);
}

public OnModelSelectionResponse(playerid, extraid, index, modelid, response)
{
    if(extraid == MODEL_SELECTION_SKIN_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][pLastSkin] = modelid;
            return 1;
        }
    }
    else if(extraid == MODEL_CUSTOM_SKIN_MENU)
    {
        if(response == MODEL_RESPONSE_SELECT)
        {
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][pLastSkin] = modelid;
            return 1;
        }
    }
    return 1;
}
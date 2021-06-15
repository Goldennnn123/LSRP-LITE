//LSPD HQ Text Exterior
#include <a_samp>
#include <streamer>

hook OnGameModeInit@2()
{
    new jamiejjam;
	jamiejjam = CreateDynamicObject(19482, 1539.538085, -1610.693237, 13.152813, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}LOS SANTOS POLICE DEPARTMENT", 130, "Ariel", 30, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19482, 1539.538085, -1611.103637, 12.702813, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}TO PROTECT AND TO SERVE", 130, "Ariel", 30, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19482, 1539.538085, -1610.733276, 13.092815, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}_______________________________", 130, "Ariel", 30, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(18762, 1544.516845, -1687.238281, 13.411024, 0.000000, 90.000000, 90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jamiejjam, 0, 8391, "ballys01", "greyground256128", 0x00000000);
	jamiejjam = CreateDynamicObject(19482, 1543.997802, -1687.953857, 12.402812, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}LOS SANTOS POLICE DEPARTMENT", 130, "Quartz MS", 26, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19482, 1543.997802, -1688.433837, 12.042812, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}PERSHING SQUARE HEADQUARTERS", 130, "Quartz MS", 20, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19482, 1543.997802, -1688.433837, 12.282811, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{FFFFFF}__________________________________", 130, "Quartz MS", 20, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(2256, 1544.288208, -1617.860351, 14.414562, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterial(jamiejjam, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	jamiejjam = CreateDynamicObject(19477, 1545.027954, -1617.871215, 14.254565, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{000000}POLICE PARKING", 130, "Quartz MS", 35, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19477, 1544.997924, -1617.871215, 14.044564, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{000000}RESTRICTED ACCESS", 130, "Quartz MS", 30, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19477, 1545.037963, -1617.871215, 14.214567, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{000000}__________________", 130, "Quartz MS", 30, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19477, 1545.507690, -1617.871215, 13.774560, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{000000}NO", 130, "Quartz MS", 70, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19477, 1545.507690, -1617.871215, 13.774560, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "TRESPASSING", 130, "Quartz MS", 70, 1, 0x00000000, 0x00000000, 0);
	jamiejjam = CreateDynamicObject(19477, 1545.198120, -1617.861206, 13.414565, 0.000000, 0.000000, -90.000000, 0, 0, -1, 300.00, 300.00);
	SetDynamicObjectMaterialText(jamiejjam, 0, "{000000}TREPASSING", 130, "Quartz MS", 35, 1, 0x00000000, 0x00000000, 0);
        	
			return 1;
}
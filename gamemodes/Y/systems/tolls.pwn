#include <YSI_Coding\y_hooks>


//============================Tolls============================//
// Main configuration
#define TollCost (50) 					// How much it costs to pass the tolls
#define TollDelayCop (4) 				// The timespace in seconds between each /toll command for all cops (To avoid spam)
#define TollOpenDistance (4.0) 			// The distance in units the player can be from the icon to open the toll

// Other defines
#define MAX_TOLLS (5) // Amount of tolls
#define INVALID_TOLL_ID (-1)
#define RichmanToll (0)
#define FlintToll (1)
#define LVToll (2)
#define BlueberryTollR (3)
#define BlueberryTollL (4)

#define L_sz_TollStringLocked ("Toll guard พูดว่า: ขออภัยที่กั้นปิดชั่วคราว โปรดมาใหม่ในภายหลัง")
#define L_sz_TollStringNoMoney ("คุณมีเงินไม่เพียงพอที่จะผ่าน")
#define L_sz_TollStringBye ("Toll guard พูดว่า: ขอบคุณ ขอให้ขับขี่ปลอดภัย")
#define L_sz_TollStringHurryUp ("คุณมีเวลา 6 วินาทีเพื่อจะผ่านไป ให้แน่ใจว่าคุณจะไม่ติดอยู่")


new L_a_RequestAllowedCop, // The same timer for all /toll changes
    L_a_Pickup[MAX_TOLLS*2],
	L_a_TollObject[MAX_TOLLS*2]; 

enum TOLL_INFO
{
	E_tLocked,  // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = BlueBerry right
	E_tOpenTime // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = BlueBerry right
}
new aTolls[MAX_TOLLS][TOLL_INFO];



hook OnGameModeInit()
{
    // TOLL
	/* Richman */
	CreateDynamicObject( 8168, 612.73895263672, -1191.4602050781, 20.294105529785, 0.000000, 5, 318.31237792969, -1 );
	CreateDynamicObject( 8168, 620.47265625, -1188.49609375, 20.044105529785, 0.000000, 352.99621582031, 138.94409179688, -1 );
	CreateDynamicObject( 966, 613.97229003906, -1197.7174072266, 17.475030899048, 0.000000, 0.000000, 23.81982421875, -1 );
	CreateDynamicObject( 997, 614.33209228516, -1194.3870849609, 17.709369659424, 0.000000, 0.000000, 266.70568847656, -1 );
	CreateDynamicObject( 973, 602.98425292969, -1202.1643066406, 18.000516891479, 0.000000, 0.000000, 19.849853515625, -1 );
	L_a_TollObject[0] = CreateDynamicObject( 968, 613.8935546875, -1197.7329101563, 18.109180450439, 0.000000, -90.000000, 23.81982421875, -1 );
	CreateDynamicObject( 966, 619.42913818359, -1181.6597900391, 18.725030899048, 0.000000, 0.000000, 214.37744140625, -1 );
	CreateDynamicObject( 973, 629.68823242188, -1176.0551757813, 19.500516891479, 0.000000, 0.000000, 21.831787109375, -1 );
	CreateDynamicObject( 997, 619.26574707031, -1181.6518554688, 18.709369659424, 0.000000, 0.000000, 268.68908691406, -1 );
	L_a_TollObject[1] = CreateDynamicObject( 968, 619.44201660156, -1181.6903076172, 19.525806427002, 0.000000, -90.000000, 214.37744140625, -1 );
	/* End of Richman */

	/* Flint */
	CreateDynamicObject( 8168, 61.256042480469, -1533.3946533203, 6.1042537689209, 0.000000, 0.000000, 9.9252624511719, -1 );
	CreateDynamicObject( 8168, 40.966598510742, -1529.5725097656, 6.1042537689209, 0.000000, 0.000000, 188.5712890625, -1 );
	L_a_TollObject[2] = CreateDynamicObject( 968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1 );
	CreateDynamicObject( 966, 35.889751434326, -1526.0096435547, 4.2410612106323, 0.000000, 0.000000, 270.67565917969, -1 );
	CreateDynamicObject( 966, 67.093727111816, -1536.8275146484, 3.9910612106323, 0.000000, 0.000000, 87.337799072266, -1 );
	L_a_TollObject[3] = CreateDynamicObject( 968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1 );
	CreateDynamicObject( 973, 52.9794921875, -1531.9252929688, 5.090488910675, 0.000000, 0.000000, 352.06005859375, -1 );
	CreateDynamicObject( 973, 49.042072296143, -1531.5065917969, 5.1758694648743, 0.000000, 0.000000, 352.05688476563, -1 );
	CreateDynamicObject( 997, 68.289916992188, -1546.6020507813, 4.0626411437988, 0.000000, 0.000000, 119.09942626953, -1 );
	CreateDynamicObject( 997, 34.5198097229, -1516.1402587891, 4.0626411437988, 0.000000, 0.000000, 292.50622558594, -1 );
	CreateDynamicObject( 997, 35.903915405273, -1525.8717041016, 4.0626411437988, 0.000000, 0.000000, 342.13012695313, -1 );
	CreateDynamicObject( 997, 63.914081573486, -1535.7126464844, 4.0626411437988, 0.000000, 0.000000, 342.130859375, -1 );
	/* End of Flint */

	/* LV */
	CreateDynamicObject( 8168, 1789.83203125, 703.189453125, 15.846367835999, 0.000000, 3, 99.24951171875, -1 );
	CreateDynamicObject( 8168, 1784.8334960938, 703.94799804688, 16.070636749268, 0.000000, 357, 278.61096191406, -1 );
	CreateDynamicObject( 966, 1781.4122314453, 697.32531738281, 14.636913299561, 0.000000, 0.000000, 348.09008789063, -1 );
	CreateDynamicObject( 996, 1767.3087158203, 700.50506591797, 15.281567573547, 0.000000, 0.000000, 346.10510253906, -1 );
	CreateDynamicObject( 997, 1781.6832275391, 697.34796142578, 14.698781013489, 0.000000, 3, 77.41455078125, -1 );
	CreateDynamicObject( 997, 1792.7745361328, 706.38543701172, 13.948781013489, 0.000000, 2.999267578125, 81.379638671875, -1 );
	CreateDynamicObject( 966, 1793.4289550781, 709.87982177734, 13.636913299561, 0.000000, 0.000000, 169.43664550781, -1 );
	CreateDynamicObject( 996, 1800.8060302734, 708.38299560547, 14.281567573547, 0.000000, 0.000000, 346.10229492188, -1 );
	L_a_TollObject[4] = CreateDynamicObject( 968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1 );
	L_a_TollObject[5] = CreateDynamicObject( 968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1 );
	/* End of LV */

	/* Blueberry right */
	CreateDynamicObject(966, 614.42188, 350.81711, 17.92480,   0.00000, 0.00000, 35.00000);
	CreateDynamicObject(966, 602.91162, 342.59781, 17.92480,   0.00000, 0.00000, 215.92000);
	L_a_TollObject[6] = CreateDynamicObject(968, 614.42188, 350.81711, 18.66520,   0.00000, -90.00000, 35.00000);
	L_a_TollObject[7] = CreateDynamicObject(968, 602.91162, 342.59781, 18.66520,   0.00000, -90.00000, 215.92000);
	/* Blueberry right */

	/* Blueberry left */
	CreateDynamicObject(966, -190.35580, 254.64290, 11.07090,   0.00000, 0.00000, 345.00000);
	CreateDynamicObject(966, -204.00880, 258.30411, 11.07090,   0.00000, 0.00000, -195.00000);
	L_a_TollObject[8] = CreateDynamicObject(968, -190.24850, 254.62019, 11.89360,   0.00000, -90.00000, -14.94000);
	L_a_TollObject[9] = CreateDynamicObject(968, -204.10410, 258.34149, 11.89360,   0.00000, -90.00000, -195.00000);
	/* Blueberry right */


    L_a_Pickup[0] = CreateDynamicPickup(1239, 14, 607.9684, -1194.2866, 19.0043, 0); //  Richman 1
	L_a_Pickup[1] = CreateDynamicPickup(1239, 14, 623.9500, -1183.9774, 19.2260, 0); // Richman 2
	L_a_Pickup[2] = CreateDynamicPickup(1239, 14, 39.7039, -1522.9891, 6.1995, 0); // Flint 1
	L_a_Pickup[3] = CreateDynamicPickup(1239, 14, 62.7378, -1539.9891, 6.0639, 0); // Flint 2
	L_a_Pickup[4] = CreateDynamicPickup(1239, 14, 1795.9447, 704.2550, 15.0006, 0); // LV 1
	L_a_Pickup[5] = CreateDynamicPickup(1239, 14, 1778.9886, 702.6728, 15.2574, 0); // LV 2
	L_a_Pickup[6] = CreateDynamicPickup(1239, 14, 612.53070, 346.59592, 17.92614, 0); // BlueberryR 1
	L_a_Pickup[7] = CreateDynamicPickup(1239, 14, 604.37152, 346.88141, 17.92614, 0); // BlueberryR 2
	L_a_Pickup[8] = CreateDynamicPickup(1239, 14, -195.2768,252.2416,12.0781, 0); // BlueberryL 1
	L_a_Pickup[9] = CreateDynamicPickup(1239, 14, -199.5153,260.3405,12.0781, 0); // BlueberryL 2
    return 1;
}


CMD:opentoll(playerid, params[])
{
 	new L_i_TollID;
	if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 623.9500, -1183.9774, 19.2260) || IsPlayerInRangeOfPoint(playerid, 10.0, 607.9684, -1194.2866, 19.0043)) // Richman tolls
	{
		L_i_TollID = RichmanToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 39.7039, -1522.9891, 5.1995) || IsPlayerInRangeOfPoint(playerid, 10.0, 62.7378, -1539.9891, 5.0639)) // Flint tolls
	{
		L_i_TollID = FlintToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 1795.9447, 704.2550, 15.0006) || IsPlayerInRangeOfPoint(playerid, 10.0, 1778.9886, 702.6728, 15.2574)) // LV tolls
	{
		L_i_TollID = LVToll;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, 612.53070, 346.59592, 17.92614) || IsPlayerInRangeOfPoint(playerid, 10.0, 604.37152, 346.88141, 17.92614)) // BlueberryR tolls
	{
		L_i_TollID = BlueberryTollR;
	}
	else if(IsPlayerInRangeOfPoint(playerid, TollOpenDistance, -195.2768,252.2416,12.0781) || IsPlayerInRangeOfPoint(playerid, 10.0, -199.5153,260.3405,12.0781)) // BlueberryL tolls
	{
		L_i_TollID = BlueberryTollL;
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้อยู่ใกล้ด่านกั้นพอ");
		return 1;
	}
    
	if(!Toll_TimePassedCivil(L_i_TollID, playerid))
		return 1;

    if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionType] != GOVERMENT)
	{
		if(aTolls[L_i_TollID][E_tLocked]) // If it's locked
		{
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "%s", L_sz_TollStringLocked);
			return 1;
		}
		if(PlayerInfo[playerid][pCash] < TollCost)
		{
			SendClientMessage(playerid, COLOR_RED, L_sz_TollStringNoMoney);
			return 1;
		}
		GiveMoney(playerid, -TollCost);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "%s จ่าย %d$ ให้กับ Toll guard", ReturnPlayerName(playerid), TollCost);
	}

	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "%s", L_sz_TollStringBye);
	SendClientMessage(playerid, COLOR_LIGHTRED, L_sz_TollStringHurryUp);
	Toll_OpenToll(L_i_TollID);
	return 1;
}


CMD:tolls(playerid, params[])
{
	//new faction = playerData[playerid][pFactionID];
	new option[11];

	if(FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != POLICE && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SHERIFF && FactionInfo[PlayerInfo[playerid][pFaction]][eFactionJob] != SADCR)
        return SendClientMessage(playerid, COLOR_RED, "ACCESS DENIED:{FFFFFF} คุณไม่ใช่ ตำรวจ/นายอำเภอ/ข้าราชการเรือนจำ");

	if(sscanf(params,"s[11]",option))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "การควบคุมด่านใน San Adreas");
		SendClientMessage(playerid, COLOR_GREY, "lock/release - ล็อก/ปลดล็อก ด่านทั้งหมด");
		SendClientMessage(playerid, COLOR_GREY, "flint - ล็อก/ปลดล็อก ด่าน Flint County");
		SendClientMessage(playerid, COLOR_GREY, "richman - ล็อก/ปลดล็อก ด่าน Richman");
		SendClientMessage(playerid, COLOR_GREY, "lv - ล็อก/ปลดล็อก ด่าน LS-LV");
		SendClientMessage(playerid, COLOR_GREY, "blueberryr - ล็อก/ปลดล็อก ด่าน Blueberry(ขวา)");
		SendClientMessage(playerid, COLOR_GREY, "blueberryl - ล็อก/ปลดล็อก ด่าน Blueberry(ซ้าย)");
		return 1;
	}
	if(!Toll_TimePassedCops(playerid))
		return 1;

	if(!strcmp(option, "lock", true))
	{
		aTolls[FlintToll][E_tLocked] = 1;
		aTolls[RichmanToll][E_tLocked] = 1;
		aTolls[LVToll][E_tLocked] = 1;
		aTolls[BlueberryTollR][E_tLocked] = 1;
		aTolls[BlueberryTollL][E_tLocked] = 1;

		Toll_CloseToll(FlintToll);
		Toll_CloseToll(RichmanToll);
		Toll_CloseToll(LVToll);
		Toll_CloseToll(BlueberryTollR);
		Toll_CloseToll(BlueberryTollL);

        SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: %s %s ได้ปิดด่านกั้นทั้งหมด ! **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
	}
	else if(!strcmp(option, "release", true))
	{
		aTolls[FlintToll][E_tLocked] = 0;
		aTolls[RichmanToll][E_tLocked] = 0;
		aTolls[LVToll][E_tLocked] = 0;
		aTolls[BlueberryTollR][E_tLocked] = 0;
		aTolls[BlueberryTollL][E_tLocked] = 0;


        SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: %s %s ได้เปิดด่านกั้นทั้งหมด ! **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
	}
	else if(!strcmp(option, "flint", true))
	{
		if(aTolls[FlintToll][E_tLocked] == 0)
		{
			aTolls[FlintToll][E_tLocked] = 1;
			Toll_CloseToll(FlintToll);
            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Flint County ถูก \"ล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
		else
		{
			aTolls[FlintToll][E_tLocked] = 0;
            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Flint County ถูก \"ปลดล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
	}
	else if(!strcmp(option, "richman", true))
	{
		if(aTolls[RichmanToll][E_tLocked] == 0)
		{
			aTolls[RichmanToll][E_tLocked] = 1;
			Toll_CloseToll(RichmanToll);

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Richman ถูก \"ล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
		else
		{
			aTolls[RichmanToll][E_tLocked] = 0;

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Richman ถูก \"ปลดล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
	}
	else if(!strcmp(option, "lv", true))
	{
		if(aTolls[LVToll][E_tLocked] == 0)
		{
			aTolls[LVToll][E_tLocked] = 1;
			Toll_CloseToll(LVToll);


            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ LS-LV ถูก \"ล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
		else
		{
			aTolls[LVToll][E_tLocked] = 0;

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ LS-LV ถูก \"ปลดล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
	}
	else if(!strcmp(option, "blueberryr", true))
	{
		if(aTolls[BlueberryTollR][E_tLocked] == 0)
		{
			aTolls[BlueberryTollR][E_tLocked] = 1;
			Toll_CloseToll(BlueberryTollR);

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Blueberry(ขวา) ถูก \"ล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
		else
		{
			aTolls[BlueberryTollR][E_tLocked] = 0;

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Blueberry(ขวา) ถูก \"ปลดล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
	}
	else if(!strcmp(option, "blueberryl", true))
	{
		if(aTolls[BlueberryTollL][E_tLocked] == 0)//23914
		{
			aTolls[BlueberryTollL][E_tLocked] = 1;
			Toll_CloseToll(BlueberryTollL);

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Blueberry(ซ้าย) ถูก \"ล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
		else
		{
			aTolls[BlueberryTollL][E_tLocked] = 0;

            SendFactionMessageEx(playerid, COLOR_COP, "** HQ Announcement: ด่านกั้นที่ Blueberry(ซ้าย) ถูก \"ปลดล็อก\" โดย %s %s **", ReturnFactionRank(playerid), ReturnName(playerid, 0));
		}
	}
	return 1;
}


Toll_CloseToll(TollID)
{
	if(TollID == RichmanToll)
	{
		SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 23.81982421875);
		SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 214.37744140625);
	}
	else if(TollID == FlintToll)
	{
		SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
		SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);
	}
	else if(TollID == LVToll)
	{
		SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
		SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);
	}
	else if(TollID == BlueberryTollR)
	{
		SetDynamicObjectRot(L_a_TollObject[6], 0.00000, -90.00000, 35.00000);
		SetDynamicObjectRot(L_a_TollObject[7], 0.00000, -90.00000, 215.92000);
	}
	else if(TollID == BlueberryTollL)
	{
		SetDynamicObjectRot(L_a_TollObject[8], 0.00000, -90.00000, -14.94000);
		SetDynamicObjectRot(L_a_TollObject[9], 0.00000, -90.00000, -195.00000);
	}
	return 1;
}

Toll_OpenToll(TollID)
{
	if(TollID == RichmanToll)
	{
		aTolls[RichmanToll][E_tOpenTime] = 7;
		SetDynamicObjectRot(L_a_TollObject[0], 0.000000, 0.000000, 23.81982421875);
		SetDynamicObjectRot(L_a_TollObject[1], 0.000000, 0.000000, 214.37744140625);
	}
	else if(TollID == FlintToll)
	{
		aTolls[FlintToll][E_tOpenTime] = 7;
		SetDynamicObjectRot(L_a_TollObject[2], 0.000000, 0.000000, 270.67565917969);
		SetDynamicObjectRot(L_a_TollObject[3], 0.000000, 0.000000, 87.337799072266);
	}
	else if(TollID == LVToll)
	{
		aTolls[LVToll][E_tOpenTime] = 7;
		SetDynamicObjectRot(L_a_TollObject[4], 0.000000, 0.000000, 348.10229492188);
		SetDynamicObjectRot(L_a_TollObject[5], 0.000000, 0.000000, 169.43664550781);
	}
	else if(TollID == BlueberryTollR)
	{
		aTolls[BlueberryTollR][E_tOpenTime] = 7;
		SetDynamicObjectRot(L_a_TollObject[6], 0.000000, 0.000000, 35.00000);
		SetDynamicObjectRot(L_a_TollObject[7], 0.000000, 0.000000, 215.92000);
	}
	else if(TollID == BlueberryTollL)
	{
		aTolls[BlueberryTollL][E_tOpenTime] = 7;
		SetDynamicObjectRot(L_a_TollObject[8], 0.000000, 0.000000, -14.94000);
		SetDynamicObjectRot(L_a_TollObject[9], 0.000000, 0.000000, -195.00000);
	}
}

Toll_TimePassedCivil(TollID, playerid) // People have to wait <TollDelayCivilian> seconds between every /opentoll on the same toll
{
	if(aTolls[TollID][E_tOpenTime] > 0)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Bariera este deja deschisa. Treci pana nu se inchide!");
		return 0;
	}
	return 1;
}

Toll_TimePassedCops(playerid) // Cops have to wait for <TollDelayCop> seconds between every /toll (Global)
{
	new L_i_tick = GetUnixTime();
	if(L_a_RequestAllowedCop > L_i_tick && L_a_RequestAllowedCop != 0)
	{
		new TollString[63];
		format(TollString, 63, "คุณจะต้องรออย่างน้อย %d วินาทีระหว่างการจ่ายค่าผ่านทางแต่ละครั้ง", TollDelayCop);
		SendClientMessage(playerid, COLOR_LIGHTRED, TollString);
		return 0;
	}
	L_a_RequestAllowedCop = (L_i_tick + TollDelayCop);
	return 1;
}

task OtherTimer[1000]() 
{
    TollUpdate();
}

forward TollUpdate();
public TollUpdate() // Needs to be called in the OnPlayerUpdate function
{
	for(new i = 0; i != MAX_TOLLS; ++i)
	{
		if(aTolls[i][E_tOpenTime] > 0)
		{
			aTolls[i][E_tOpenTime]--;
			if(aTolls[i][E_tOpenTime] == 1)
			{
				Toll_CloseToll(i);
			}
		}
	}
}

forward GetUnixTime();
public GetUnixTime()
{
	new Year, Month, Day,Hour,Minute,Second;
	getdate(Year, Month, Day);
	gettime(Hour,Minute,Second);
	return mktime(Hour,Minute,Second,Day,Month,Year);
}


mktime(hour,minute,second,day,month,year)
{
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
		days_of_month = {                         // Schaltjahr
			31,29,31,30,31,30,31,31,30,31,30,31
		};
	}
	else {
		days_of_month = {                         // keins
			31,28,31,30,31,30,31,31,30,31,30,31
		};
	}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) {                               // No January Calculation, because its always the 0 past months
		for(new i=0; i!=month-1;++i) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j!=year;++j) {
		timestamp2 += 31536000;
// Schaltjahr + 1 Tag
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400;
	}

	return timestamp2;
}


#define MAX_MCGARAGE 100

new mechanic_pickup;

enum S_SERVEICE_DATA
{
	S_SER_ID,
	S_SER_BY,
    S_SER_VID[2],
	S_SER_CALL,
	S_SER_COMP,
    

    S_SER_COLOR[2],
    S_SER_PAINT,
    S_SER_COMPONENT
}
new ServiceCalls[MAX_PLAYERS][S_SERVEICE_DATA];

new Float:oldhp;


new const g_arrSelectColors[256] = {
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
	0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
	0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
	0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
	0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
	0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
	0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
	0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
	0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
	0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
	0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
	0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
	0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
	0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};


hook OP_EnterCheckpoint@12(playerid)
{
    if(PlayerCheckpoint[playerid] == 5)
    {
        GameTextForPlayer(playerid, "~p~This GPS TO BUY COMP!", 3000, 3);
        PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
        return 1;
    }
    return 1;
}

hook OnPlayerConnect@12(playerid)
{
    ResetService(playerid);
    return 1;
}

stock GetRepairPrice(vehicleid)
{
	new	panels,
		doors,
		lights,
		tires;
		
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	new front_left_panel 	= 	0xf & panels;
	new front_right_panel 	= 	( ( 0xf << 4 ) & panels ) >> 4;
	new rear_left_panel 	= 	( ( 0xf << 8 ) & panels ) >> 8;
	new rear_right_panel 	= 	( ( 0xf << 12 ) & panels ) >> 12;
	
	new wind_shield			= 	( ( 0xf << 16 ) & panels ) >> 16;
	
	new front_bumper 		= 	( ( 0xf << 20 ) & panels ) >> 20;
	new rear_bumper 		= 	( ( 0xf << 24 ) & panels ) >> 24;
	new hood 				= 	0xf & doors;	
	new trunk				= 	( ( 0xf << 8 ) & doors ) >> 8;

	new front_left_seat 	= 	( ( 0xf << 16 ) & doors ) >> 16;
	new front_right_seat 	= 	( ( 0xf << 24 ) & doors ) >> 24;
	new rear_left_seat 		= 	( ( 0xf << 32 ) & doors ) >> 32;
	new rear_right_seat 	= 	( ( 0xf << 40 ) & doors ) >> 40;

	new tire_front_left = 1 & tires;
	new tire_front_right = ( ( 1 << 1 ) & tires ) >> 1;
	new tire_rear_left = ( ( 1 << 2 ) & tires ) >> 2;
	new tire_rear_right = ( ( 1 << 3 ) & tires ) >> 3;
	new panel_add = floatround( ( 	front_left_panel +
									front_right_panel +
									rear_left_panel +
									rear_right_panel +
									wind_shield +
									front_bumper +
									rear_bumper ) / 0.21 );
						
	new door_add = floatround( ( 	hood +
									trunk +
									front_left_seat +
									front_right_seat +
									rear_left_seat +
									rear_right_seat ) / 0.24 );
	
	new tire_add = floatround( ( 	tire_front_left +
									tire_front_right +
									tire_rear_left +
									tire_rear_right ) / 0.04 );
	
	new pprice = 1 * panel_add;
	new dprice = 1 * door_add;
	new tprice = 2 * tire_add;
	return tprice + dprice + pprice;
}

CMD:service(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    new option, tagetid, confirm[16];

    if(sscanf(params, "udS()[16]", tagetid, option, confirm))
    {
        SendUsageMessage(playerid, "/service <ชื่อบางส่วน/ไอดี> <service>");
        SendClientMessage(playerid, COLOR_GREY, "SERVICE : OPTION");
        SendClientMessage(playerid, -1, "1. ซ่อมภายนอก (ซ่อมให้กลับมาสภาพดีแต่ไม่เพิ่มเลือดยานพหานะ)");
        SendClientMessage(playerid, -1, "2. ซ่อมภายใน (เพิ่มเลือดยานพาหนะ)");
        SendClientMessage(playerid, -1, "3. เปลี่ยนแบตตารี่ ");
        return 1;
    }

	if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 15.0))
        return SendErrorMessage(playerid, "ผู้เล่นไมได้อยู่ใกล้คุณ");


    new vehicleid = GetPlayerVehicleID(tagetid);

    if(!IsPlayerInVehicle(tagetid, vehicleid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้ขึ้นรถ");
    
    if(!IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid)))
        return SendErrorMessage(playerid, "คุณต้องอยู่บนรถ TowTruck");
    
    new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

    if(modelid != 525)
        return SendErrorMessage(playerid, "คุณต้องอยู่บนรถ TowTruck");

    new comp;
    
    if(option >= 1 && option <= 3)
    {
        switch(option)
        {
            case 1:
            {
                GetVehicleHealth(vehicleid, oldhp);

                comp = floatround(float(GetRepairPrice(vehicleid)) / 10.0, floatround_round);

                if(comp < 1)
                    return SendErrorMessage(playerid, "รถไม่ได้รับความเสียหาย");

                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                
                    ServiceCalls[playerid][S_SER_ID] = tagetid;
                    ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
                    ServiceCalls[playerid][S_SER_VID][1] = vehicleid;
                    ServiceCalls[playerid][S_SER_COMP] = comp;
                    ServiceCalls[playerid][S_SER_CALL] = option;

                    ServiceCalls[tagetid][S_SER_BY] = playerid;
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y ย้ำๆ(1-5 ครั้ง) เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }
                //return 1;
            }
            case 2:
            {
                new Float:vehhp;
                new modelid_taget = GetVehicleModel(vehicleid);

                GetVehicleHealth(vehicleid, vehhp);
                
                if(vehhp == VehicleData[modelid_taget - 400][c_max_health])
                    return SendErrorMessage(playerid, "ภายในของรถไม่ได้รับความเสียหาย");
                
                new Float:result = (VehicleData[modelid_taget - 400][c_max_health] - vehhp) / 50 * 2;
                
                comp = floatround(result,floatround_round);
                
                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                

                    ServiceCalls[playerid][S_SER_ID] = tagetid;
                    ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
                    ServiceCalls[playerid][S_SER_VID][1] = vehicleid;
                    ServiceCalls[playerid][S_SER_COMP] = comp;
                    ServiceCalls[playerid][S_SER_CALL] = option;

                    ServiceCalls[tagetid][S_SER_BY] = playerid;
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }

            }
            case 3:
            {
                new Float:EngineLife;

                if(VehicleInfo[vehicleid][eVehicleEngine] >= 100)
                    return SendErrorMessage(playerid, "แบตตารี่เต็มแล้ว");
            
                EngineLife = 100 - VehicleInfo[vehicleid][eVehicleEngine];

                comp = floatround(EngineLife);
                if(!strcmp(confirm, "yes", true) && strlen(confirm))
                {
                    if(VehicleInfo[GetPlayerVehicleID(playerid)][eVehicleComp] < comp)
                        return SendErrorMessage(playerid, "อะไหล่ของคุณไม่เพียงพอ");
                
                    SendClientMessage(playerid, COLOR_YELLOW, "SERVER: ข้อเสนอถูกส่ง");
                    
                    ServiceCalls[playerid][S_SER_ID] = tagetid;
                    ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
                    ServiceCalls[playerid][S_SER_VID][1] = vehicleid;
                    ServiceCalls[playerid][S_SER_COMP] = comp;
                    ServiceCalls[playerid][S_SER_CALL] = option;

                    ServiceCalls[tagetid][S_SER_BY] = playerid;
                    
                    SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการซ่อมยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid));
                    return 1;
                }
                else
                {
                    SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", comp);
                    SendSyntaxMessage(playerid, "/service %d %d yes", tagetid, option);
                    return 1;
                }
            }

        }
    }
    else SendErrorMessage(playerid, "กรุณาเลือกให้ถูกต้อง");
    
    return 1;
}

alias:changcolorvehicle("chcolorveh", "setcolor")
CMD:changcolorvehicle(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ TowTruck");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพหานะ Tow Truck");

    new str_one[20], str_two[20], tagetid, confirm[20];

    if(sscanf(params, "us[20]S()[20]S()[20]", tagetid, str_one, str_two, confirm))
    {
        SendUsageMessage(playerid, "/changcolorvehicle <ชื่อบางส่วน/ไอดี> <color1 or color2>");
        return 1;
    }

    if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 15.0))
        return SendErrorMessage(playerid, "ผู้เล่นไมได้อยู่ใกล้คุณ");

    if(!IsPlayerInAnyVehicle(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่บนยานพาหนะ");


    new vehicleid_taget = GetPlayerVehicleID(tagetid);
    new vehicleid_my = GetPlayerVehicleID(playerid);

    if(VehicleInfo[vehicleid_my][eVehicleComp] < 15)
        return SendErrorMessage(playerid, "คุณมีอะไหล่ไม่เพียงพอ");

    if(!strcmp(str_one, "color1", true))
    {
        new value;

        if(sscanf(str_two, "d", value))
            return SendUsageMessage(playerid, "/changcolorvehicle %d color1 <เลขสี>");

        if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0-255)");
        
        if(!strcmp(confirm, "yes", true) && strlen(confirm))
        {
            ServiceCalls[playerid][S_SER_ID] = tagetid;
            ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
            ServiceCalls[playerid][S_SER_VID][1] = vehicleid_taget;
            ServiceCalls[playerid][S_SER_COMP] = 15;
            ServiceCalls[playerid][S_SER_CALL] = 4;
            ServiceCalls[playerid][S_SER_COLOR][0] = value;
            ServiceCalls[playerid][S_SER_COLOR][1] = VehicleInfo[vehicleid_taget][eVehicleColor2];

            ServiceCalls[tagetid][S_SER_BY] = playerid;
            SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการเปลี่ยนสียานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid_taget));
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", 15);
            SendSyntaxMessage(playerid, "/service %d %s yes", tagetid, str_one);
            return 1;
        }
    }
    else if(!strcmp(str_one, "color2", true))
    {
        new value;

        if(sscanf(str_two, "d", value))
            return SendUsageMessage(playerid, "/changcolorvehicle %d color2 <เลขสี>");

        if(value > 255 || value < 0)
			return SendErrorMessage(playerid, "ค่าต้องไม่ต่ำหรือไม่เกินกว่า (0-255)");
        
        if(!strcmp(confirm, "yes", true) && strlen(confirm))
        {
            ServiceCalls[playerid][S_SER_ID] = tagetid;
            ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
            ServiceCalls[playerid][S_SER_VID][1] = vehicleid_taget;
            ServiceCalls[playerid][S_SER_COMP] = 15;
            ServiceCalls[playerid][S_SER_CALL] = 4;
            ServiceCalls[playerid][S_SER_COLOR][0] = VehicleInfo[vehicleid_taget][eVehicleColor1];
            ServiceCalls[playerid][S_SER_COLOR][1] = value;

            ServiceCalls[tagetid][S_SER_BY] = playerid;
            SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการเปลี่ยนสียานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid_taget));
            return 1;
        }
        else
        {
            SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", 15);
            SendSyntaxMessage(playerid, "/service %d %s yes", tagetid, str_one);
            return 1;
        }
    }
    else SendErrorMessage(playerid, "กรุณาเลือก option ให้ถูกด้วย color1 or color2");

    return 1;
}

CMD:tune(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพาหนะ TowTruck");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนยานพหานะ Tow Truck");

    new componentid, tagetid, confirm[20];

    if(sscanf(params, "udS()[20]", tagetid, componentid, confirm))
        return SendUsageMessage(playerid, "/trun <ชื่อบางส่วน/ไอดี> <componentid>");

    if(!IsPlayerConnected(tagetid))
		return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์"); 
		
	if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    if(!IsPlayerNearPlayer(playerid, tagetid, 15.0))
        return SendErrorMessage(playerid, "ผู้เล่นไมได้อยู่ใกล้คุณ");

    if(!IsPlayerInAnyVehicle(tagetid))
        return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่บนยานพาหนะ");

    
    if(componentid < 1000 || componentid > 1193)
        return SendErrorMessage(playerid, "คุณใส่เลข componentid ไม่ถูกต้อง");

    if(!CheckVehicleModel(playerid, GetPlayerVehicleID(tagetid), componentid))
        return 1;
    
    new vehicleid_taget = GetPlayerVehicleID(tagetid);
    new vehicleid_my = GetPlayerVehicleID(playerid);
    new comp = floatround(componentid / 50, floatround_round);

    if(VehicleInfo[vehicleid_my][eVehicleComp] < comp)
        return SendErrorMessage(playerid, "คุณมีอะไหล่ไม่เพียงพอ");


    if(!strcmp(confirm, "yes", true) && strlen(confirm))
    {
        ServiceCalls[playerid][S_SER_ID] = tagetid;
        ServiceCalls[playerid][S_SER_VID][0] = GetPlayerVehicleID(playerid);
        ServiceCalls[playerid][S_SER_VID][1] = vehicleid_taget;
        ServiceCalls[playerid][S_SER_COMP] = comp;
        ServiceCalls[playerid][S_SER_CALL] = 5;
        ServiceCalls[playerid][S_SER_COMPONENT] = componentid;

        ServiceCalls[tagetid][S_SER_BY] = playerid;
        SendClientMessageEx(tagetid, -1, "%s ได้ยืนข้อเสนอสำหรับการแต่งยานพาหนะ %s ของคุณ "EMBED_LIGHTRED"- กด Y เพื่อยอมรับข้อเสนอนี้", ReturnName(playerid, 0), ReturnVehicleName(vehicleid_taget));
    }
    else
    {
        SendClientMessageEx(playerid, COLOR_YELLOW, "บริการนี้ต้องใช้ อะไหล่ ทั้งหมด %d ชิ้น", 15);
        SendSyntaxMessage(playerid, "/trun %d %d yes", tagetid, componentid);
    }
    return 1;
}

CMD:colorlist(playerid, params[])
{
	static
		color_code[3344];

	if (color_code[0] == EOS) {
		for(new i = 0; i < 256; i++)
		{
			if(i > 0 && (i % 16) == 0) 
                format(color_code, sizeof(color_code), "%s\n{%06x}#%03d", color_code, g_arrSelectColors[i] >>> 8, i);

			else format(color_code, sizeof(color_code), "%s{%06x}#%03d ", color_code, g_arrSelectColors[i] >>> 8, i);
		}
	}
	Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_MSGBOX, "List of Color ID's:", color_code, "Close", "");
	return 1;
}

alias:checkcomponents("checkcomp")
CMD:checkcomponents(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ TowTruck");

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่บน Tow Truck");

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่ที่นั่งคนขับของยานพาหนะ");

    SendClientMessageEx(playerid, COLOR_WHITE, "Components: %d", VehicleInfo[vehicleid][eVehicleComp]);
    return 1;
}


alias:buycomponents("buycomp")
CMD:buycomponents(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");

    if(!IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ TowTruck");

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleid) != 525)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่บน Tow Truck");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้นั่งอยู่ที่นั่งคนขับของยานพาหนะ");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1841.0283,111.5464,15.1172))
    {
        PlayerCheckpoint[playerid] = 5;
        SetPlayerCheckpoint(playerid, -1841.0283,111.5464,15.1172, 3.0);
        return SendErrorMessage(playerid, "คุณไมได้อยู่ในจุดซื้อ อะไหล่");
    }

    new amount, price = 70, confirm[60];

    if(sscanf(params, "dS()[60]", amount, confirm))
        return SendUsageMessage(playerid, "/buycomp(onents) <จำนวน> (อะไหล่ หนึ่งชิ้น เท่ากับ $70)");
    
    if(amount < 1)
        return SendErrorMessage(playerid, "กรุณาซื้อมากกกว่า 1 ชิ้น");
    
    if(!strcmp(confirm, "yes", true) && strlen(confirm))
    {
        SendClientMessageEx(playerid, -1, "คุณได้ซื้อะไหล่ จำนวน "EMBED_GREENMONEY"%s ชิ้น "EMBED_WHITE"ราคาทั้งหมด: "EMBED_LIGHTRED"$%s", MoneyFormat(amount), MoneyFormat(price * amount));
        VehicleInfo[vehicleid][eVehicleComp]+=amount;
        GiveMoney(playerid, -price * amount);
        SaveVehicle(vehicleid);
    }
    else
    {
        SendClientMessageEx(playerid, -1, "อะไหล่ จำนวน %s ชิ้น ราคารวมทั้งหมด %s", MoneyFormat(amount), MoneyFormat(price * amount));
        SendUsageMessage(playerid, "/buycomp(onents) <%d> yes",amount);
        return 1;
    }
    return 1;
}


CMD:addcomp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 5)
        return SendUnauthMessage(playerid);


    new vehicleid = GetPlayerVehicleID(playerid);

    VehicleInfo[vehicleid][eVehicleComp] = 9999;
    SendClientMessage(playerid, COLOR_DARKGREEN, "คุณได้ใช้คำสั่งในการ เพิ่มอะไหล่ในรถของคุณเป็น 9999 ชิ้น");
    return 1;
}

CMD:fixcar(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MECHANIC)
        return SendErrorMessage(playerid, "คุณไม่ใช่อาชีพช่างยนต์");
    
    if(ServiceCalls[playerid][S_SER_ID] == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "คุณยังไมได้ยื่นข้อเสนอกับใคร");


    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "ลงมาจากรถเพื่อทำการซ่อมรถ");

    new vehicleid = ServiceCalls[playerid][S_SER_VID][1];

    if(GetNearestVehicle(playerid) != vehicleid)
    {
        return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถที่จะซ่อม");
    }


    SetTimerEx("OnRepairVehicle", 1000 * ServiceCalls[playerid][S_SER_COMP], false, "ddd",playerid, ServiceCalls[playerid][S_SER_VID][1], ServiceCalls[playerid][S_SER_CALL]);
    ApplyAnimation(playerid, "CAR", "FIXN_CAR_LOOP", 4.1, 0, 0, 0, 1, 0, 0);
    SendClientMessage(playerid, COLOR_YELLOWEX, "คุณกำลังซ่อมยานพาหนะ.....");

    return 1;
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(ServiceCalls[playerid][S_SER_BY] != INVALID_PLAYER_ID)
    {
        if(RELEASED(KEY_YES))
        {
            SendClientMessageEx(ServiceCalls[playerid][S_SER_BY], -1, "%s ได้ยินยันข้อเสนอของคุณแล้ว ขั้นตอนต่อไปจะเริ่มทำการซ่อมรถ "EMBED_LIGHTBLUE"- พิมพ์คำสั่ง /fixcar ใกล้ๆรถที่จะซ่อม", ReturnName(playerid,0));
            SendClientMessage(playerid, -1, "คุณได้รับข้อเสนอแล้ว");
            ServiceCalls[playerid][S_SER_BY] = INVALID_PLAYER_ID;
            return 1;
        }
        if(RELEASED(KEY_NO))
        {
            new tagetid = ServiceCalls[playerid][S_SER_BY];

            SendClientMessageEx(tagetid, COLOR_GREY, "%s ไม่ยอมรับข้อเสนอของคุณ", ReturnName(playerid,0));
            SendClientMessageEx(playerid, COLOR_GREY, "คุณไม่ยอมรับข้อเสนอของ %s", ReturnName(tagetid,0));

            ResetService(ServiceCalls[playerid][S_SER_BY]);
            ResetService(playerid);
            return 1;
        }
    }
    return 1;
}

forward OnRepairVehicle(playerid, vehicleid, option);
public OnRepairVehicle(playerid, vehicleid, option)
{
    switch(option)
    {
        case 1:
        {
            VehicleInfo[ServiceCalls[playerid][S_SER_VID][0]][eVehicleComp] -= ServiceCalls[playerid][S_SER_COMP];
            RepairVehicle(vehicleid);
            SetVehicleHealth(vehicleid, oldhp);

            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);

            SendClientMessageEx(playerid, -1, "คุณได้ซ่อมรถ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceCalls[playerid][S_SER_COMP]);
            ResetService(ServiceCalls[playerid][S_SER_ID]);
            ResetService(playerid);
            return 1;
        }
        case 2:
        {
            new modelid = GetVehicleModel(vehicleid);
            
            SendClientMessageEx(playerid, -1, "คุณได้ซ่อมรถ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceCalls[playerid][S_SER_COMP]);
            
            VehicleInfo[ServiceCalls[playerid][S_SER_VID][0]][eVehicleComp] -= ServiceCalls[playerid][S_SER_COMP];
            SetVehicleHealth(vehicleid, VehicleData[modelid - 400][c_max_health]);
            
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(ServiceCalls[playerid][S_SER_ID]);
            ResetService(playerid);
            return 1;
        }
        case 3:
        {
            VehicleInfo[vehicleid][eVehicleEngine] = 100;
            SendClientMessageEx(playerid, -1, "คุณได้เติมแบตตารี่ %s สำเร็จแล้วใช้อะไหล่ไป %d ชิ้น", ReturnVehicleName(vehicleid), ServiceCalls[playerid][S_SER_COMP]);
            VehicleInfo[ServiceCalls[playerid][S_SER_VID][0]][eVehicleComp] -= ServiceCalls[playerid][S_SER_COMP];
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(ServiceCalls[playerid][S_SER_ID]);
            ResetService(playerid);
            return 1;
        }
        case 4:
        {
            VehicleInfo[vehicleid][eVehicleColor1] = ServiceCalls[playerid][S_SER_COLOR][0];
            VehicleInfo[vehicleid][eVehicleColor2] = ServiceCalls[playerid][S_SER_COLOR][1];
            ChangeVehicleColor(vehicleid, VehicleInfo[vehicleid][eVehicleColor1], VehicleInfo[vehicleid][eVehicleColor2]);

            SendClientMessageEx(playerid, -1, "คุณได้เปลี่ยนสียานพาหนะ %s เรียบร้อยแล้ว", ReturnVehicleName(vehicleid), ServiceCalls[playerid][S_SER_COMP]);
            VehicleInfo[ServiceCalls[playerid][S_SER_VID][0]][eVehicleComp] -= ServiceCalls[playerid][S_SER_COMP];
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(ServiceCalls[playerid][S_SER_ID]);
            ResetService(playerid);
        }
        case 5:
        {
            AddVehicleComponent(vehicleid, ServiceCalls[playerid][S_SER_COMPONENT]);
            new slotid = GetVehicleComponentType(ServiceCalls[playerid][S_SER_COMPONENT]);
            
            VehicleInfo[vehicleid][eVehicleMod][slotid] = ServiceCalls[playerid][S_SER_COMPONENT];
            SaveVehicle(vehicleid);
            SendClientMessageEx(playerid, -1, "คุณได้แต่งยานพาหนะของ %s สำหรับเร็จแล้ว", ReturnVehicleName(vehicleid));
            VehicleInfo[ServiceCalls[playerid][S_SER_VID][0]][eVehicleComp] -= ServiceCalls[playerid][S_SER_COMP];
            TogglePlayerControllable(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
            ClearAnimations(playerid);
            ResetService(ServiceCalls[playerid][S_SER_ID]);
            ResetService(playerid);
        }
    }
    return 1;
}

stock ResetService(playerid)
{
    ServiceCalls[playerid][S_SER_ID] = INVALID_PLAYER_ID;
    ServiceCalls[playerid][S_SER_BY] = INVALID_PLAYER_ID;
    ServiceCalls[playerid][S_SER_CALL] = 0;
    ServiceCalls[playerid][S_SER_COMP] = 0;
    ServiceCalls[playerid][S_SER_VID][0] = INVALID_VEHICLE_ID;
    ServiceCalls[playerid][S_SER_VID][1] = INVALID_VEHICLE_ID;

    ServiceCalls[playerid][S_SER_COLOR][0] = 0;
    ServiceCalls[playerid][S_SER_COLOR][1] = 0;
    ServiceCalls[playerid][S_SER_PAINT] = -1;
    ServiceCalls[playerid][S_SER_COMPONENT] = -1;
    return 1;
}






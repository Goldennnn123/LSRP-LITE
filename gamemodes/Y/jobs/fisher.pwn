
#include <YSI_Coding\y_hooks>

#define DELIVERY_FISH_X     2475.2932
#define DELIVERY_FISH_Y     -2710.7759
#define DELIVERY_FISH_Z     3.1963

new FishingPlace[MAX_PLAYERS];
new FishingCP[MAX_PLAYERS];
new FishingBoat[MAX_PLAYERS];

new const Float:GoFishingPlace[3][3] = {
	{813.6824,-2248.2407,-0.4488},
	{407.6824,-2318.2407,-0.5752},
	{-25.9471,-1981.9995,-0.6268}
};

new const FishNames[] = {
	"ปลาทูน่า",
	"ปลาแซลมอน",
	"ปลากระโทงดาบ",
	"ปลาไหลมอเรย์",
	"ปลาฉลาม",
    "ปลากระทุงเหวแม่หม้าย",
    "ปลากระทุงเหวควาย",
    "ปลากระทุงเหวบั้ง",
    "ปลากระทุงเหวหูดำ",
    "ปลากระบอกท่อนใต้",
    "ปลากระบอกปีกเหลือง",
    "ปลากระเบนจมูกแหลม",
    "ปลากระเบนนก",
    "ปลากระเบนแมลงวัน",
    "ปลากะตักใหญ่",
    "ปลากะโทงแทงกล้วย",
    "ปลากะพงข้างเหลือง",
    "ปลากะพงขาว",
    "ปลากะพงเขียว",
    "ปลากะพงแดงเกล็ดห่าง",
    "ปลากะพงแดงข้างแถว",
    "ปลากะพงแดงหน้าตั้ง",
    "ปลากะพงแดงสั้นหางปาน",
    "ปลากะพงปานข้างลาย",
    "ปลากะพงแสม",
    "ปลากะรังแดงจุดฟ้า",
    "ปลากุเราสี่เส้น",
    "ปลากุแลกล้วย",
    "ปลาเก๋าดอกหางตัด",
    "ปลาเก๋าแดง",
    "ปลาเก๋าจุดน้ำตาล",
    "ปลาเก๋าบั้งแฉก",
    "ปลาเก๋าหางซ้อน",
    "ปลาแข้งไก่",
    "ปลาคลุด",
    "ปลางัวใหญ่หางตัด",
    "ปลาจวดเตียนเขี้ยว",
    "ปลาจะละเม็ดขาว",
    "ปลาจะละเม็ดดำ",
    "ปลาจะละเม็ดดำ",
    "ปลาจาน",
    "ปลาฉลามหัวค้อนสั้น",
    "ปลาเฉลียบ",
    "ปลาช่อนทะเล",
    "ปลาซ่อนทรายแก้ว",
    "ปลาดอกหมากกระโดง",
    "ปลาดอกหมากครีบยาว",
    "ปลาดาบลาวยาว",
    "ปลาดาบเงินใหญ่",
    "ปลาดุกทะเล",
    "ปลาตะคองเหลือง",
    "ปลาตะเพียนน้ำเค็ม",
    "ปลาตะลุมพุก",
    "ปลาตาหวานจุด",
    "ปลาทรายขาวหูแดง",
    "ปลาทรายแดงกระโดง"
};

hook OnPlayerConnect(playerid) {
    FishingCP[playerid] = 0;
    FishingPlace[playerid] = -1;
    FishingBoat[playerid] = 0;
}

CMD:fishhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_DARKGREEN,"_______________________________________");
	SendClientMessage(playerid, COLOR_GRAD3,"/myfish /gofishing /fish /stopfishing /unloadfish");
	return 1;
}

CMD:gofishing(playerid, params[]) {

    new place;
	if(sscanf(params,"i", place)) {
        SendClientMessage(playerid, COLOR_GRAD1, "การใช้: /gofishing [1(บนเรือ)/2(จากสะพาน)]");
        return 1;
    }

    if (FishingPlace[playerid] != -1) {
        return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณมี เช็คพ้อย/ภารกิจ อยู่");
    }

    if (place == 1) {

        new vehicleid = GetPlayerVehicleID(playerid);
        if (vehicleid == INVALID_VEHICLE_ID || !IsABoat(vehicleid)) {
            SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องอยู่ ใน/ใกล้ เรือของคุณเพื่อใช้งาน");
            return 1;
        }
        else {
            vehicleid = GetNearestVehicle(playerid);
            if (vehicleid == INVALID_VEHICLE_ID || !IsABoat(vehicleid)) {
                SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องอยู่ ใน/ใกล้ เรือของคุณเพื่อใช้งาน");
                return 1;
            }
        }

        if(PlayerInfo[playerid][pFishes] > 5000) {
            SendClientMessage(playerid, COLOR_DARKGREEN, "คุณตกปลาพอแล้ว");
            SendClientMessage(playerid, COLOR_DARKGREEN, "/unloadfish หากคุณต้องการขายปลาของคุณ");
            return 1;
        }

        new rand = random(sizeof(GoFishingPlace));
        if (IsPlayerInRangeOfPoint(playerid, 30.0, GoFishingPlace[rand][0],GoFishingPlace[rand][1],GoFishingPlace[rand][2])) {
            FishingPlace[playerid] = 1;
            SendClientMessage(playerid, COLOR_WHITE, "เริ่มตกปลาได้ที่นี่ (/fish) เมื่อเสร็จแล้วให้คุณ /stopfishing และ /unloadfish");
            DisablePlayerCheckpoint(playerid);
        }
        else {
            SetPlayerCheckpoint(playerid, GoFishingPlace[rand][0],GoFishingPlace[rand][1],GoFishingPlace[rand][2], 30.0);
            SendClientMessage(playerid, COLOR_DARKGREEN, "ไปที่จุดตกปลาในมหาสมุทรและเริ่มตกปลา (/fish)");
        }
        
        FishingCP[playerid] = rand + 1;
        return 1;
    }
    else if (place == 2) {

	    if(PlayerInfo[playerid][pFishes] > 1000) {
	        SendClientMessage(playerid, COLOR_DARKGREEN, "ตกปลาพอแล้ว");
	        SendClientMessage(playerid, COLOR_DARKGREEN, "/unloadfish หากคุณต้องการขายปลาของคุณ");
            return 1;
	    }

        if (!IsPlayerInRangeOfPoint(playerid, 30.0, 383.6021,-2061.7881,7.6140))
        {
            SetPlayerCheckpoint(playerid, 383.6021,-2061.7881,7.6140, 30.0);
            SendClientMessage(playerid, COLOR_DARKGREEN, "ไปที่จุดตกปลาในมหาสมุทรและเริ่มตกปลา (/fish)");
        }
        else 
        {
            FishingPlace[playerid] = 2;
            SendClientMessage(playerid, COLOR_WHITE, "เริ่มตกปลาได้ที่นี่ (/fish) เมื่อเสร็จแล้วให้คุณ /stopfishing และ /unloadfish");
        }
        FishingCP[playerid] = sizeof(GoFishingPlace) + 1;
        return 1;
    }
    else {
        SendClientMessage(playerid, COLOR_GRAD1, "การใช้: /gofishing [1(บนเรือ)/2(จากสะพาน)]");
    }
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid) {
    if (FishingCP[playerid] != 0) {
        if (FishingCP[playerid] <= sizeof(GoFishingPlace)) { // เรือ
            new rand = FishingCP[playerid]-1;
            if (IsPlayerInRangeOfPoint(playerid, 30.0, GoFishingPlace[rand][0],GoFishingPlace[rand][1],GoFishingPlace[rand][2])) {
                FishingPlace[playerid] = 1;

                SendClientMessage(playerid, COLOR_WHITE, "เริ่มตกปลาได้ที่นี่ (/fish) เมื่อเสร็จแล้วให้คุณ /stopfishing และ /unloadfish");
                DisablePlayerCheckpoint(playerid);
            }
        }
        else {
            if (IsPlayerInRangeOfPoint(playerid, 30.0, 383.6021,-2061.7881,7.6140)) { // สะพาน LS
                FishingPlace[playerid] = 2;

                SendClientMessage(playerid, COLOR_WHITE, "เริ่มตกปลาได้ที่นี่ (/fish) เมื่อเสร็จแล้วให้คุณ /stopfishing และ /unloadfish");
                DisablePlayerCheckpoint(playerid);
            }
            else if (IsPlayerInRangeOfPoint(playerid, 2.5, DELIVERY_FISH_X,DELIVERY_FISH_Y,DELIVERY_FISH_Z) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) { // ขายปลา LS
                new earn = PlayerInfo[playerid][pFishes] + random(floatround(PlayerInfo[playerid][pFishes]/5));
  
                new Float:tax = earn * 0.07;
                GiveMoney(playerid, earn - floatround(tax, floatround_round));
                GlobalInfo[G_GovCash]+=floatround(tax, floatround_round);
                GameTextForPlayer(playerid, sprintf("~p~SOLD FISHES WEIGHT ~w~%d FOR %d", PlayerInfo[playerid][pFishes], earn - floatround(tax, floatround_round)), 8000, 4);

                PlayerInfo[playerid][pFishes] = 0;
                FishingCP[playerid] = 0;
                DisablePlayerCheckpoint(playerid);
            }
        }
        return -2; // หยุด Callback อื่น
    }
    return 1;
}

CMD:stopfishing(playerid, params[]) {
	if(FishingPlace[playerid] != -1)
	{
	    SendClientMessage(playerid, COLOR_DARKGREEN, "คุณหยุดตกปลาแล้ว");

	    if(PlayerInfo[playerid][pFishes]) 
            SendClientMessage(playerid, COLOR_DARKGREEN, "/unloadfish หากคุณต้องการขายปลาของคุณ");

	    FishingPlace[playerid]=-1;
        FishingCP[playerid] = 0;
	}
	else SendClientMessage(playerid, COLOR_WHITE, "คุณยังไม่ได้ตกปลา");
	return 1;
}

CMD:unloadfish(playerid, params[]) {

    if(FishingPlace[playerid] != -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "หยุดตกปลาก่อนเป็นอันดับแรก /stopfishing");

	if(PlayerInfo[playerid][pFishes])
	{
	    SendClientMessage(playerid, COLOR_DARKGREEN, "สถานที่สำหรับขนส่งปลาและรับเงินถูกทำเครื่องหมายไว้บนแผนที่");
        SetPlayerCheckpoint(playerid, DELIVERY_FISH_X,DELIVERY_FISH_Y,DELIVERY_FISH_Z, 2.0);
        FishingCP[playerid] = sizeof(GoFishingPlace) + 1;

	} else SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีปลา");
	
    return 1;
}

CMD:myfish(playerid, params[]) {
	if(PlayerInfo[playerid][pFishes])
	{
	    SendClientMessage(playerid, COLOR_DARKGREEN, "_______________________________________");
	    SendClientMessageEx(playerid, COLOR_DARKGREEN, "น้ำหนักปลา [%d] ปอนด์", PlayerInfo[playerid][pFishes]);
	} 
    else SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีปลา");
	
    return 1;
}

CMD:fish(playerid, params[]) {

	if(FishingPlace[playerid] != -1) {
		if(!HasCooldown(playerid,COOLDOWN_FISHING))
		{
            new Fishcaught, Fishlbs;
            SetCooldown(playerid,COOLDOWN_FISHING, 6);

            if (FishingCP[playerid] != 0) {
                if (FishingCP[playerid] <= sizeof(GoFishingPlace)) { // เรือ
                    new rand = FishingCP[playerid]-1;
                    if (IsPlayerInRangeOfPoint(playerid, 30.0, GoFishingPlace[rand][0],GoFishingPlace[rand][1],GoFishingPlace[rand][2])) {
                          
                        new vehicleid = GetPlayerVehicleID(playerid);
                        if (vehicleid == INVALID_VEHICLE_ID || !IsABoat(vehicleid)) {
                            SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องอยู่ ใน/ใกล้ เรือของคุณเพื่อใช้งาน");
                            return 1;
                        }
                        else {
                            vehicleid = GetNearestVehicle(playerid);
                            if (vehicleid == INVALID_VEHICLE_ID || !IsABoat(vehicleid)) {
                                SendClientMessage(playerid, COLOR_LIGHTRED, "คุณต้องอยู่ ใน/ใกล้ เรือของคุณเพื่อใช้งาน");
                                return 1;
                            }
                        }

                        if(random(6) >= 5)
                            return SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณจับอะไรไม่ได้เลย");
    
                        Fishcaught = random(55);

                        if(FishingPlace[playerid] != 1) Fishlbs = ((Fishcaught+1)*10) + (1 + random(10));
                        else Fishlbs = ((Fishcaught+1)*20) + (1 + random(10));

                        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s รอกม้วนคันเบ็ดขึ้นมาและพบว่าพวกเขาจับ%sได้", ReturnRealName(playerid), FishNames[Fishcaught]);
                        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณจับ%s %d ปอนด์", FishNames[Fishcaught], Fishlbs);
        
                        PlayerInfo[playerid][pFishes]+=Fishlbs;

                        if(PlayerInfo[playerid][pFishes] > 1000)
                        {
                            FishingPlace[playerid]=-1;

                            SendClientMessage(playerid, COLOR_DARKGREEN, "ตกปลาพอแล้ว");
                            SendClientMessage(playerid, COLOR_DARKGREEN, "/unloadfish หากคุณต้องการขายปลาของคุณ");
                            return 1;
                        }

                        FishingBoat[playerid]+=Fishlbs;

                        if(FishingBoat[playerid] > 1000) {
                            rand = random(sizeof(GoFishingPlace));
                            SetPlayerCheckpoint(playerid, GoFishingPlace[rand][0],GoFishingPlace[rand][1],GoFishingPlace[rand][2], 30.0);
                            FishingCP[playerid] = rand + 1;
                            FishingBoat[playerid]=0;
                            FishingPlace[playerid]=-1;
                            SendClientMessage(playerid, COLOR_DARKGREEN, "ไปตกปลาในสถานที่อื่น");
                        }
                    }
                    else SendClientMessage(playerid, COLOR_LIGHTRED, "คุณตกปลาที่นี่ไม่ได้");
                }
                else {
                    if (IsPlayerInRangeOfPoint(playerid, 30.0, 383.6021,-2061.7881,7.6140)) { // สะพาน
                        if(random(7) >= 55)
                            return SendClientMessageEx(playerid, COLOR_LIGHTRED, "คุณจับอะไรไม่ได้เลย");
    
                        Fishcaught = random(55);

                        if(FishingPlace[playerid] != 1) Fishlbs = ((Fishcaught+1)*10) + (1 + random(10));
                        else Fishlbs = ((Fishcaught+1)*20) + (1 + random(10));

                        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "> %s รอกม้วนคันเบ็ดขึ้นมาและพบว่าพวกเขาจับ%sได้", ReturnRealName(playerid), FishNames[Fishcaught]);
                        SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณจับ%s %d ปอนด์", FishNames[Fishcaught], Fishlbs);

                        PlayerInfo[playerid][pFishes]+=Fishlbs;

                        if(PlayerInfo[playerid][pFishes] > 100)
                        {
                            FishingPlace[playerid]=-1;
                            SendClientMessage(playerid, COLOR_DARKGREEN, "ตกปลาพอแล้ว");
                            SendClientMessage(playerid, COLOR_DARKGREEN, "/unloadfish หากคุณต้องการขายปลาของคุณ");
                            return 1;
                        }
                    }
                    else SendClientMessage(playerid, COLOR_LIGHTRED, "คุณตกปลาที่นี่ไม่ได้");

                }
            }
		}
		else {
			SendClientMessage(playerid, COLOR_LIGHTRED, "ไม่มีปลารอบ ๆ");
			SendClientMessage(playerid, COLOR_WHITE, "((โปรดรอ 6 วินาทีในแต่ละ /fish))");
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "คุณยังไม่ได้ตกปลา");
	}
	return 1;
}

static IsABoat(vehicleid)
{
    new model = GetVehicleModel(vehicleid);

	switch (model) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return 1;
	}
	return 0;
}
#include <YSI_Coding\y_hooks>
/*


    ยาเสพติดที่มี:
        - Cocain
        - Canabis
        - Heroine
*/
enum G_DRUG_DATA
{
    Float:DrugPosX,
    Float:DrugPosY,
    Float:DrugPosZ,
}

new
    Logger:druglog;

new DrugBuyPos[][G_DRUG_DATA] = 
{
    {1116.0817,-297.6803,74.3906},
    {2351.3037,-647.9330,128.0547},
    {2160.7305,-101.6745,2.7500},
    {2265.5637,668.1002,11.4531},
    {2326.7424,63.5122,26.4922},
    {2315.9167,1.2286,26.7422}
};

new RanDomDrugPoint;

hook OnGameModeInit()
{
    RanDomDrugPoint = Random(1, 6);

    druglog = CreateLog("server/druglog");
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerInfo[playerid][pDrug][0] = 0.0;
    PlayerInfo[playerid][pDrug][1] = 0.0;
    PlayerInfo[playerid][pDrug][2] = 0.0;

    PlayerInfo[playerid][pAddicted] = false;
    PlayerInfo[playerid][pAddictedCount] = 0;
    return 1;
}

CMD:gotodrugpos(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < LEAD_ADMIN)
        return SendErrorMessage(playerid, "เกิดข้อผิดพลาดในการใช้คำสั่ง");

    SetPlayerPos(playerid, DrugBuyPos[RanDomDrugPoint][DrugPosX], DrugBuyPos[RanDomDrugPoint][DrugPosY], DrugBuyPos[RanDomDrugPoint][DrugPosZ]);
    SendClientMessage(playerid, COLOR_GREY, "คุณได้เคลื่อนย้ายมาที่ขายยาเสพติดแล้ว");
    return 1;
}

stock BuyDrug(playerid, Float:amout, type)
{
    new newtype = Random(1,3); new str[250];

    RanDomDrugPoint = Random(1, 6);

    if(type == 4)
    {
        SendClientMessage(playerid, COLOR_GREY, "คนขายยา พูดว่า: เอาล่ะฉันได้ยาและไม่รู้ว่าจะถูกใจแกหรือป่าวแต่ฉันขายมันราคาถูกให้แกนะ อย่าเอาไปบอกใครล่ะ..");
        SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "> คนขายยา หยิบถุง ZipLock ออกมาและยื่นมันให้กับ %s",ReturnName(playerid,0));
        GiveMoney(playerid, -1000);

        GiveDrug(playerid, newtype, amout);
        return 1;
    }
    
    if(newtype != type)
        return SendClientMessage(playerid, COLOR_GREY, "คนขายยา พูดว่า: ขอโทษนะฉันไม่มีสิ่งที่แกต้องการเอาไว้ฉันจะไปหามาให้แต่ตอนนี้แกไปที่อื่นก่อน");

    switch(newtype)
    {
        case 1:
        {
            if(PlayerInfo[playerid][pCash] < 1200)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการซื้อ");

            SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "> คนขายยา หยิบถุง ZipLock ออกมาและยื่นมันให้กับ %s",ReturnName(playerid,0));
            GiveMoney(playerid, -1200);
            GiveDrug(playerid, 1, amout);
            format(str, sizeof(str), "[%s] %s Buy Drug 'Cocaine' Amount %.2f",ReturnDate(), ReturnName(playerid,0),amout);
            SendDiscordMessage("drug", str);
        }
        case 2:
        {
            if(PlayerInfo[playerid][pCash] < 1500)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการซื้อ");

            SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "* คนขายยา หยิบถุง ZipLock ออกมาและยื่นมันให้กับ %s",ReturnName(playerid,0));
            GiveMoney(playerid, -1500);
            GiveDrug(playerid, 2, amout);

            format(str, sizeof(str), "[%s] %s Buy Drug 'Cannabis' Amount %.2f", ReturnDate(), ReturnName(playerid,0),amout);
            SendDiscordMessage("drug", str);
        }
        case 3:
        {
            if(PlayerInfo[playerid][pCash] < 2500)
                return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอต่อการซื้อ");

            SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "* คนขายยา หยิบถุง ZipLock ออกมาและยื่นมันให้กับ %s",ReturnDate(),ReturnName(playerid,0));
            GiveMoney(playerid, -2500);
            GiveDrug(playerid, 2, amout);
            format(str, sizeof(str), "[%s] %s Buy Drug 'Heroin' Amount %.2f",ReturnDate(), ReturnName(playerid,0),amout);
            SendDiscordMessage("drug", str);
        }
    }
    return 1;
}

stock PlaceDrugVehicle(playerid, vehicleid, type, Float:amount)
{
    switch(type)
    {
        case 1:
        {
            VehicleInfo[vehicleid][eVehicleDrug][0]+= amount;
            PlayerInfo[playerid][pDrug][0]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cocaine' ไว้ที่ยานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            VehicleInfo[vehicleid][eVehicleDrug][1]+= amount;
            PlayerInfo[playerid][pDrug][1]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cannabis' ไว้ที่ยานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            VehicleInfo[vehicleid][eVehicleDrug][2]+= amount;
            PlayerInfo[playerid][pDrug][2]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Heroin' ไว้ที่ยานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

stock PlaceDrugHouse(playerid, houseid, type, Float:amount)
{
    switch(type)
    {
        case 1:
        {
            HouseInfo[houseid][HouseDrug][0]+= amount;
            PlayerInfo[playerid][pDrug][0]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cocaine' ไว้ที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            HouseInfo[houseid][HouseDrug][1]+= amount;
            PlayerInfo[playerid][pDrug][1]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cannabis' ไว้ที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            HouseInfo[houseid][HouseDrug][2]+= amount;
            PlayerInfo[playerid][pDrug][2]-= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Heroin' ไว้ที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

stock GetDrugVehicle(playerid, vehicleid, type, Float:amount)
{
    switch(type)
    {
        case 1:
        {
            VehicleInfo[vehicleid][eVehicleDrug][0]-= amount;
            PlayerInfo[playerid][pDrug][0]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cocaine' ขึ้นมายานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            VehicleInfo[vehicleid][eVehicleDrug][1]-= amount;
            PlayerInfo[playerid][pDrug][1]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cannabis' ขึ้นมายานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            VehicleInfo[vehicleid][eVehicleDrug][2]-= amount;
            PlayerInfo[playerid][pDrug][2]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Heroin' ขึ้นมายานะหานะ %s ของคุณแล้ว จำนวน %.2f",ReturnVehicleName(vehicleid), amount);
            SaveVehicle(vehicleid);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

stock GetDrugHouse(playerid, houseid, type, Float:amount)
{
    switch(type)
    {
        case 1:
        {
            HouseInfo[houseid][HouseDrug][0]-= amount;
            PlayerInfo[playerid][pDrug][0]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cocaine' จากที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            HouseInfo[houseid][HouseDrug][1]-= amount;
            PlayerInfo[playerid][pDrug][1]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Cannabis' จากที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            HouseInfo[houseid][HouseDrug][2]-= amount;
            PlayerInfo[playerid][pDrug][2]+= amount;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้นำ 'Heroin' จากที่บ้านของคุณแล้ว จำนวน %.2f", amount);
            Savehouse(houseid);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}

ptask AddictedCount[1000](playerid) 
{
    new 
		hour, 
		minute, 
		seconds
	;

	gettime(hour, minute, seconds); 
	
	if(minute == 00 && seconds == 59)
	{
        if(PlayerInfo[playerid][pAddictedCount])
        {
            if(PlayerInfo[playerid][pAddicted])
            {
                new Float:health;
                GetPlayerHealth(playerid, health);
                    
                if(health < 10)
                {
                    SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "* มีอาการแปลกๆใบหน้าและตาของเขาแสดงออกอย่างเห็นได้ชัด (( %s ))",ReturnName(playerid,0));
                    return 1;
                }

                SendNearbyMessage(playerid, 2.5, COLOR_EMOTE, "* มีอาการแปลกๆใบหน้าและตาของเขาแสดงออกอย่างเห็นได้ชัด (( %s ))",ReturnName(playerid,0));
                SetPlayerHealth(playerid, health-1);
                return 1;
            }
            else
            {
                PlayerInfo[playerid][pAddicted] = true;
            }
        }
        return 1;
	}
    return 1;
}


/**
    * ฟังชั่นสำหรับการให้ยาเสพติด ไว้สำหรับการทำงานในการให้ยาเสพติดทุกฟังชั่นจะได้ง่ายไม่ต้องเขียนเยอะ
*/
stock GiveDrug(playerid, type, Float:amout)
{
    switch(type)
    {
        case 1:
        {
            PlayerInfo[playerid][pDrug][0]+= amout;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้รับ Cocaine จำนวน %.2f",amout);

            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            PlayerInfo[playerid][pDrug][1]+= amout;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้รับ Cannabis จำนวน %.2f",amout);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            PlayerInfo[playerid][pDrug][2]+= amout;
            SendClientMessageEx(playerid, COLOR_GREY, "คุณได้รับ Heroin จำนวน %.2f",amout);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}




#include <YSI_Coding\y_hooks>

#define MAX_ZONE_NAME (28)
#define TEXTDRAW_PHONE "mdl-2001:"

enum E_SAZONE_MAIN 
{
    SAZONE_NAME[28],
    Float:SAZONE_AREA[6]
}

new PlayerText:PhonePlayer[MAX_PLAYERS][5];
new PlayerSelectPhoneBook[MAX_PLAYERS];
new PhoneAddName[MAX_PLAYERS][60], PhoneAddNumber[MAX_PLAYERS];
new playerPhone[MAX_PLAYERS];

new Player911Type[MAX_PLAYERS], Player911Timer[2][MAX_PLAYERS]; 
new Player911Text[MAX_PLAYERS][3][128]; 
new PhoneNumberSMS[MAX_PLAYERS];


hook OnPlayerConnect(playerid)
{
    PhonePlayer[playerid][0] = CreatePlayerTextDraw(playerid, 532.000000, 227.000000, "mdl-2001:0");
	PlayerTextDrawFont(playerid, PhonePlayer[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, PhonePlayer[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhonePlayer[playerid][0], 98.000000, 209.500000);
	PlayerTextDrawSetOutline(playerid, PhonePlayer[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PhonePlayer[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PhonePlayer[playerid][0], 1);
	PlayerTextDrawColor(playerid, PhonePlayer[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, PhonePlayer[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PhonePlayer[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, PhonePlayer[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PhonePlayer[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PhonePlayer[playerid][0], 0);

	PhonePlayer[playerid][1] = CreatePlayerTextDraw(playerid, 542.000000, 406.000000, "mdl-2001:1");
	PlayerTextDrawFont(playerid, PhonePlayer[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, PhonePlayer[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhonePlayer[playerid][1], 19.500000, 19.500000);
	PlayerTextDrawSetOutline(playerid, PhonePlayer[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PhonePlayer[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PhonePlayer[playerid][1], 1);
	PlayerTextDrawColor(playerid, PhonePlayer[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, PhonePlayer[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PhonePlayer[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, PhonePlayer[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PhonePlayer[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PhonePlayer[playerid][1], 1);

	PhonePlayer[playerid][2] = CreatePlayerTextDraw(playerid, 601.000000, 406.000000, "mdl-2001:2");
	PlayerTextDrawFont(playerid, PhonePlayer[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, PhonePlayer[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhonePlayer[playerid][2], 18.500000, 20.000000);
	PlayerTextDrawSetOutline(playerid, PhonePlayer[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PhonePlayer[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PhonePlayer[playerid][2], 1);
	PlayerTextDrawColor(playerid, PhonePlayer[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PhonePlayer[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PhonePlayer[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, PhonePlayer[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PhonePlayer[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PhonePlayer[playerid][2], 1);

	PhonePlayer[playerid][3] = CreatePlayerTextDraw(playerid, 571.000000, 406.000000, "mdl-2001:3");
	PlayerTextDrawFont(playerid, PhonePlayer[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, PhonePlayer[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PhonePlayer[playerid][3], 21.500000, 21.000000);
	PlayerTextDrawSetOutline(playerid, PhonePlayer[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PhonePlayer[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, PhonePlayer[playerid][3], 1);
	PlayerTextDrawColor(playerid, PhonePlayer[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, PhonePlayer[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PhonePlayer[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, PhonePlayer[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PhonePlayer[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PhonePlayer[playerid][3], 1);

	PhonePlayer[playerid][4] = CreatePlayerTextDraw(playerid, 569.000000, 251.000000, "XX:XX");
	PlayerTextDrawFont(playerid, PhonePlayer[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, PhonePlayer[playerid][4], 0.204166, 1.399999);
	PlayerTextDrawTextSize(playerid, PhonePlayer[playerid][4], 618.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PhonePlayer[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, PhonePlayer[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, PhonePlayer[playerid][4], 1);
	PlayerTextDrawColor(playerid, PhonePlayer[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, PhonePlayer[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PhonePlayer[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, PhonePlayer[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PhonePlayer[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PhonePlayer[playerid][4], 0);
    return 1;
}



stock ReturnPhoneDate()
{
    new MonthStr[40],str[266];
    new year,month,day;

    getdate(year, month, day);

    switch(month)
	{
	    case 1:  MonthStr = "January";
	    case 2:  MonthStr = "February";
	    case 3:  MonthStr = "March";
	    case 4:  MonthStr = "April";
	    case 5:  MonthStr = "May";
	    case 6:  MonthStr = "June";
	    case 7:  MonthStr = "July";
	    case 8:  MonthStr = "August";
	    case 9:  MonthStr = "September";
	    case 10: MonthStr = "October";
	    case 11: MonthStr = "November";
	    case 12: MonthStr = "December";
	}
    format(str, 90, "%s %d", MonthStr,day);
    return str;
}

stock ShowPhoneBook(playerid)
{
    new str[MAX_STRING], str_long[MAX_STRING],str_p[MAX_STRING],Phoneid;

    for(new l = 0; l < MAX_PHONEBOOK; l++)
    {
        if(!PhoneInfo[l][PhoneDBID])
            continue;
            
        if(PhoneInfo[l][PhoneOwnerDBID] != PlayerInfo[playerid][pDBID])
            continue;

        format(str, sizeof(str), "%s: %d\n",PhoneInfo[l][PhoneName], PhoneInfo[l][PhoneNumber]);
        strcat(str_long, str);

        format(str_p, sizeof(str_p), "%d",Phoneid);
        SetPVarInt(playerid, str_p, l);

        Phoneid++;
    }

    format(str, sizeof(str), "จัดการรายชื่อ\n");
    strcat(str_long, str);

    if(!Phoneid)
    {
        Dialog_Show(playerid,DIALOG_PHONEBOOK_LIST,DIALOG_STYLE_LIST,"PhoneBook","เพื่มรายชื่อติดต่อ\nดูรายชื่อติดต่อ","ยืนยัน","ยกเลิก");
    }
    else
    {
        Dialog_Show(playerid, DIALOG_PHONEBOOK, DIALOG_STYLE_LIST, "Phone Book", str_long, "ยืนยัน", "ยกเลิก");
    }
    return 1;
}

Dialog:DIALOG_PHONEBOOK_LIST(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    switch(listitem)
    {
        case 0: 
        {
            new Phoneid;
            for(new l = 0; l < MAX_PHONEBOOK; l++)
            {
                if(!PhoneInfo[l][PhoneDBID])
                    continue;
                    
                if(PhoneInfo[l][PhoneOwnerDBID] != PlayerInfo[playerid][pDBID])
                    continue;

                Phoneid++;
            }

            if(Phoneid >= 3)
            {
                if(PlayerInfo[playerid][pDonater] < 1)
                {
                    ShowPhoneBook(playerid);
                    SendErrorMessage(playerid, "คุณไม่สามารถเพิ่มเบอร์รายชื่อผู้ติดต่อของคุณมากกว่านี้ได้เนื่องจากคุณไม่ใช่ Donter ระบบ Copper");
                    return 1;
                }
            }

            Dialog_Show(playerid, DIALOG_ADD_PHONEBOOK, DIALOG_STYLE_INPUT, "เพื่มรายชื่อผู้ติดต่อ", "เพื่มรายชื่อผู้ติดต่อใหม่ของคุณ", "ยืนยัน", "ยกเลิก");
        }
        case 1: return ShowPhoneBook(playerid);
    }
    return 1;
}

Dialog:DIALOG_ADD_PHONEBOOK(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 60)
        return Dialog_Show(playerid, DIALOG_ADD_PHONEBOOK, DIALOG_STYLE_INPUT, "เพื่มรายชื่อผู้ติดต่อ", "กรุณาใส่ชื่อผู้ติดต่อให้ถูกต้อง {D32F2F}ห้ามเกิน 60 ตัวอักษร", "ยืนยัน", "ยกเลิก");
    
    new str[60];

    format(str, sizeof(str), inputtext);

    PhoneAddName[playerid] = str;
    Dialog_Show(playerid, DIALOG_ADD_NUMBER, DIALOG_STYLE_INPUT, "ใส่หมายเลขโทรศัพท์", "กรุณาใส่เบอร์โทรศัพท์ของรายชื่อที่คุณต้องการบันทึก", "ยืนยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_ADD_NUMBER(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 5)
        return Dialog_Show(playerid, DIALOG_ADD_NUMBER, DIALOG_STYLE_INPUT, "ใส่หมายเลขโทรศัพท์", "กรุณาใส่หมายเลขโทรศัพท์ให้ถูกต้องด้วย {D32F2F}ห้ามเกิน 5 ตัวอักษร", "ยืนยัน", "ยกเลิก");

    new Number = strval(inputtext);
    PhoneAddNumber[playerid] = Number;
    AddPhoneBook(playerid);
    return 1;
}

Dialog:DIALOG_PHONEBOOK(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    new str_p[MAX_STRING], str[MAX_STRING],str_long[MAX_STRING];

    format(str_p, sizeof(str_p), "%d",listitem);

    new id = GetPVarInt(playerid, str_p);
    PlayerSelectPhoneBook[playerid] = id;


    if(!PhoneInfo[id][PhoneDBID] || id > MAX_PHONEBOOK)
        return Dialog_Show(playerid,DIALOG_PHONEBOOK_LIST,DIALOG_STYLE_LIST,"PhoneBook","เพื่มรายชื่อติดต่อ\nดูรายชื่อติดต่อ","ยืนยัน","ยกเลิก");

    new PhoneNames[96];
    format(PhoneNames, sizeof(PhoneNames), "PHONE: %s",PhoneInfo[id][PhoneName]);

    format(str, sizeof(str), "ชื่อผู้ติดต่อ: %s\n", PhoneInfo[id][PhoneName]);
    strcat(str_long, str);
    format(str, sizeof(str), "เบอร์: %d\n", PhoneInfo[id][PhoneNumber]);
    strcat(str_long, str);
    format(str, sizeof(str), "โทรออก\n");
    strcat(str_long, str);
    format(str, sizeof(str), "ส่งข้อความ\n");
    strcat(str_long, str);
    format(str, sizeof(str), "{FF0000}ลบรายชื่อนี้\n");
    strcat(str_long, str);

    Dialog_Show(playerid, DIALOG_PHONE_SELETE_ID, DIALOG_STYLE_LIST, PhoneNames, str_long, "ยินยัน", "ยกเลิก");
    return 1;
}

Dialog:DIALOG_PHONE_SELETE_ID(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    new id = PlayerSelectPhoneBook[playerid];


    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NAME, DIALOG_STYLE_INPUT, "แก้ไขรายชื่อติดต่อ:", "โปรดใส่รายชื่อผู้ติดต่อใหม่ที่ต้องการของคุณ:", "ยืนยัน", "ยกเลิก");
        case 1: return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NUMBER, DIALOG_STYLE_INPUT, "แก้ไขเบอร์ติดต่อ:", "โปรดใส่หมายเลขโทรศัพท์ใหม่ของรายชื่อนี้ของคุณ:", "ยืนยัน", "ยกเลิก");
        case 2:
        {
            //new playerb = INVALID_PLAYER_ID, str[128];
            new str[10];
            new Number = PhoneInfo[id][PhoneNumber];

            format(str, sizeof(str), "%d",Number);
            callcmd::call(playerid, str);
            return 1;
        }
        case 3:
        {
            new Number = PhoneInfo[id][PhoneNumber];

            new playerb = INVALID_PLAYER_ID;

            foreach(new i : Player)
            { 
                if(PlayerInfo[i][pPhone] != Number)
                        continue;
                            
                if(PlayerInfo[i][pPhone] == Number)
                {
                    playerb = i;
                }
            }
            PhoneNumberSMS[playerid] = playerb;
            Dialog_Show(playerid, DIALOG_SEND_MESSAGE, DIALOG_STYLE_INPUT, "กรอกข้อความ:", "กรอกข้อความที่ต้องการจะส่ง SMS ไปหายังเบอร์ปลายทางของคุณ\n"EMBED_LIGHTRED"เสียค่าธรรมเนียมในการส่ง $3", "ยืนยัน", "ยกเลิก");
            return 1;
        }
        case 4:
        {
            new delphonebook[MAX_STRING];
            mysql_format(dbCon, delphonebook, sizeof(delphonebook),"DELETE FROM phonebook WHERE PhoneDBID = %d",id);
            mysql_tquery(dbCon, delphonebook);

            PhoneInfo[id][PhoneDBID] = 0;
            PhoneInfo[id][PhoneOwnerDBID] = 0;
            PhoneInfo[id][PhoneNumber] = 0;
            ShowPhoneBook(playerid);
            return 1;
        }
    }
    return 1;
}

Dialog:DIALOG_PHONE_EDIT_NAME(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    new id = PlayerSelectPhoneBook[playerid];

    if(strlen(inputtext) < 1 || strlen(inputtext) > 60)
        return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NAME, DIALOG_STYLE_INPUT, "แก้ไขรายชื่อติดต่อ:", "โปรดใส่รายชื่อผู้ติดต่อให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    format(PhoneInfo[id][PhoneName], PhoneInfo[id][PhoneName], inputtext);
    SetPhoneBookName(id, inputtext);
    ShowPhoneBook(playerid);
    return 1;
}

Dialog:DIALOG_PHONE_EDIT_NUMBER(playerid, response, listitem, inputtext[])
{
    if(!response)
        return ShowPhoneBook(playerid);

    new id = PlayerSelectPhoneBook[playerid];

    new Number = strval(inputtext);

    if(strlen(inputtext) < 1 || strlen(inputtext) > 5)
        return Dialog_Show(playerid, DIALOG_PHONE_EDIT_NUMBER, DIALOG_STYLE_INPUT, "แก้ไขเบอร์ติดต่อ:", "โปรดใส่หมายเลขโทรศัพท์ให้ถูกต้อง:", "ยืนยัน", "ยกเลิก");

    PhoneInfo[id][PhoneNumber] = Number;
    SetPhoneBookNumber(id, Number);
    ShowPhoneBook(playerid);
    return 1;
}


forward LoadPhoneBook();
public LoadPhoneBook()
{
    if(!cache_num_rows())
        return 1;
    
    new rows; cache_get_row_count(rows);
    for (new i = 0; i < rows && i < MAX_PHONEBOOK; i ++)
    {
        cache_get_value_name_int(i,"PhoneDBID",PhoneInfo[i+1][PhoneDBID]);
        cache_get_value_name_int(i,"PhoneOwnerDBID",PhoneInfo[i+1][PhoneOwnerDBID]);

        cache_get_value_name(i,"PhoneName",PhoneInfo[i+1][PhoneName],60);
        cache_get_value_name_int(i,"PhoneNumber",PhoneInfo[i+1][PhoneNumber]);
    }

    return 1;
}

stock SetPhoneBookName(id, const string[])
{
    new query[MAX_STRING];

    mysql_format(dbCon, query, sizeof(query),"UPDATE phonebook SET PhoneName = '%e' WHERE PhoneDBID = %d",
        string,
        PhoneInfo[id][PhoneDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}
stock SetPhoneBookNumber(id, Number)
{
    new query[MAX_STRING];

    mysql_format(dbCon, query, sizeof(query),"UPDATE phonebook SET PhoneNumber = %d WHERE PhoneDBID = %d",
        Number,
        PhoneInfo[id][PhoneDBID]);
    mysql_tquery(dbCon, query);
    return 1;
}

stock AddPhoneBook(playerid)
{
    new query[MAX_STRING];

    new idx = 0;
	
    for (new i = 1; i < MAX_PHONEBOOK; i ++)
    {
        if(!PhoneInfo[i][PhoneDBID])
        {
            idx = i; 
            break;
        }
    }
    if(idx == 0)
    {
        return SendServerMessage(playerid, "ไม่สามารถสร้างรายชื่อติดต่อได้มากว่านี้แล้ว (700)"); 
    }

    PhoneInfo[idx][PhoneDBID] = idx;
    PhoneInfo[idx][PhoneOwnerDBID] = PlayerInfo[playerid][pDBID];
    PhoneInfo[idx][PhoneName] = PhoneAddName[playerid];
    PhoneInfo[idx][PhoneNumber] = PhoneAddNumber[playerid];
    //mysql_tquery(dbCon, "SELECT * FROM phonebook ORDER BY PhoneDBID", "LoadPhoneBook");

    mysql_format(dbCon, query, sizeof(query),"INSERT INTO `phonebook` (`PhoneOwnerDBID`,`PhoneName`,`PhoneNumber`) VALUES(%d,'%e',%d)",
        PlayerInfo[playerid][pDBID],
        PhoneAddName[playerid],
        PhoneAddNumber[playerid]);
    mysql_tquery(dbCon, query);

    SendClientMessageEx(playerid, -1, "%d", PhoneInfo[idx][PhoneDBID]);
    SendClientMessageEx(playerid, -1, "{F57C00}PHONE SYSTEM:{388E3C} คุณได้เพื่มรายชื่อผู้ติดต่อ {FFEB3B}%s{388E3C} โดยใช้เบอร์: {FFEB3B}%d", PhoneAddName[playerid], PhoneAddNumber[playerid]);
    PhoneAddName[playerid] = "";
    PhoneAddNumber[playerid] = 0;
    ShowPhoneBook(playerid);
    return 1;
}


alias:phone("ph")
CMD:phone(playerid, params[])
{
    if(IsPlayerAndroid(playerid) == true)
    {
        new str[255], longstr[255];

        format(str, sizeof(str), "โทรออก\n");
        strcat(longstr, str);
        format(str, sizeof(str), "รายชื่อผู้ติดต่อ\n");
        strcat(longstr, str);
        format(str, sizeof(str), "ส่งข้อความ\n");
        strcat(longstr, str);

        Dialog_Show(playerid, DIALOG_APH_MENU, DIALOG_STYLE_LIST, "PHONE:", longstr, "ยืนยัน", "ยกเลิก");
        return 1;
    }

    if(PlayerInfo[playerid][pGUI] == 0)
    {
        new hour, seconds, minute;
        gettime(hour, minute, seconds);

        new str_time[60], str[60];

        format(str_time, sizeof(str_time), "%d:%02d",hour,minute);
        PlayerTextDrawSetString(playerid, PhonePlayer[playerid][4], str_time);

        for(new i = 0; i < 5; i++)
        {
            PlayerTextDrawShow(playerid, PhonePlayer[playerid][i]);
        }

        SelectTextDraw(playerid, COLOR_GRAD1);
        PlayerInfo[playerid][pGUI] = 1;

        format(str, sizeof(str), "หยิบโทรศัพท์ขึ้นมา");
        callcmd::me(playerid,str);
    }
    else
    {
        for(new p = 0; p < 5; p++)
        {
            PlayerTextDrawHide(playerid, PhonePlayer[playerid][p]);
        }
        CancelSelectTextDraw(playerid);
        PlayerInfo[playerid][pGUI] = 0;

        new str[120];
        format(str, sizeof(str), "เก็บโทรศัพท์");
        callcmd::me(playerid,str);

    }
    return 1;
}

CMD:call(playerid, params[])
{
    new
		str[128],
		phone_number,
		playerb = INVALID_PLAYER_ID
	;

    if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		return SendErrorMessage(playerid, "คุณไม่สามารถโทรออกได้");

    if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "โทรสัพท์ของคุณปิดเครื่องอยู่");

    /*if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "คุณถูกล็อคด้วยกุญแจมือ");*/
		
	if(PlayerInfo[playerid][pCalling])
		return SendErrorMessage(playerid, "คุณไม่สามารถโทรออกได้ในขณะนี้");
		
	if(sscanf(params, "i", phone_number))
		return SendUsageMessage(playerid, "/call [หมายเลขโทรสัพท์]");

    if(phone_number < 4)
        return SendUsageMessage(playerid, "/call [หมายเลขโทรสัพท์ (5 ตัว)]");

    foreach(new i : Player)
    { 
        if(PlayerInfo[i][pPhone] != phone_number)
            continue;
        
        if(PlayerInfo[i][pPhone] == phone_number)
        {
            playerb = i;
        }
    }
	
	format(str, sizeof(str), "* %s กดหมายเลขโทรสัพท์และกดปุ่มโทรออก", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
	SendClientMessage(playerid, COLOR_EMOTE, str); 
	
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	
	if(phone_number == 911)
	{
		PlayerInfo[playerid][pPhoneline] = 999;
		PlayerInfo[playerid][pCalling] = 1; 
	
		Player911Timer[0][playerid] = SetTimerEx("On911Call", 2000, false, "i", playerid);
		return 1;
	}
	
	if(playerb == INVALID_PLAYER_ID)
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 4500, false, "ii", playerid, 1); 
		return 1;
	}
	
	if(PlayerInfo[playerb][pPhoneOff])
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3000, false, "ii", playerid, 2); 
		return 1;
	}
	
	if(PlayerInfo[playerb][pCalling])
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3000, false, "ii", playerid, 3);
		return 1;
	}
	
	if(PlayerInfo[playerb][pPhoneline] != INVALID_PLAYER_ID)
	{
		playerPhone[playerid] = SetTimerEx("OnPhoneCall", 3300, false, "ii", playerid, 4);
		return 1;
	}
	
	SendNearbyMessage(playerb, 20.0, COLOR_EMOTE, "* %s มีเสียงกริ๊งโทรสัพท์ดังขึ้น", ReturnName(playerb, 0)); 
	SendClientMessageEx(playerb, COLOR_GREY, "[ ! ] คุณสามารถรับสายโดยการกดปุ่มรับสายโดยการพิมพ์ /p(ickup) เพื่อรับสายเรียกเข้า Phone: %i", PlayerInfo[playerid][pPhone]); 
	
	PlayerInfo[playerid][pCalling] = 1; PlayerInfo[playerb][pCalling] = 1;
	
	PlayerInfo[playerid][pPhoneline] = playerb;
	PlayerInfo[playerb][pPhoneline] = playerid; 

	PlayAudioStreamForPlayer(playerb, "https://media1.vocaroo.com/mp3/1fl8LmutfAzb");
	playerPhone[playerb] = SetTimerEx("OnSuccessCall", 1000, true, "i", playerb);
	return 1;
}


alias:hangup("h")
CMD:hangup(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "โทรสัพท์ของคุณปิดเครื่องอยู่");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "คุณถูกล็อคด้วยกุญแจมืออยู่");
		
	/*new
		str[128]
	;*/
		
	if(playerPhone[playerid])
	{
        KillTimer(playerPhone[playerid]);

        if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}

        if(GetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline]) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline], SPECIAL_ACTION_STOPUSECELLPHONE);
		}

        PlayerInfo[PlayerInfo[playerid][pPhoneline]][pCalling] = 0; PlayerInfo[playerid][pCalling] = 0;

        StopAudioStreamForPlayer(PlayerInfo[playerid][pPhoneline]);
        PlayerInfo[PlayerInfo[playerid][pPhoneline]][pPhoneline] = INVALID_PLAYER_ID;
        PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;

        SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณวางสาย"); 
        StopAudioStreamForPlayer(playerid);
		return 1;
	}
	
	if(PlayerInfo[playerid][pPhoneline] == 999 || PlayerInfo[playerid][pPhoneline] == 911)
	{
		for(new i = 0; i < 2; i++) KillTimer(Player911Timer[i][playerid]); 
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณวางสาย"); 
		
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
		PlayerInfo[playerid][pCalling] = 0;
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}
        StopAudioStreamForPlayer(playerid);
		return 1;
	}
	
	if(PlayerInfo[playerid][pPhoneline] == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "ยังไม่ได้มีใครโทรมาหาคุณ"); 
	
	if(PlayerInfo[playerid][pCalling] && PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID)
	{	
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณวางสาย"); 
		SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] ไม่มีการตอบรับจากเลขหมายที่ท่านเรียก"); 
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		}
		
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhoneline] = INVALID_PLAYER_ID; 
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0; 
		
		PlayerInfo[playerid][pCalling] = 0; 
        StopAudioStreamForPlayer(PlayerInfo[playerid][pPhoneline]);
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID; 
		printf("call 0");
        StopAudioStreamForPlayer(playerid);
        
		return 1;
	}
	
	if(!PlayerInfo[playerid][pCalling] && PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณวางสาย"); 
		//SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] ไม่มีการตอบรับจากเลขหมายที่ท่านเรียก"); 
		
		printf("pPhoneline = %i", PlayerInfo[playerid][pPhoneline]);
		
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			printf("call 1");
		}
		
		if(GetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline]) == SPECIAL_ACTION_USECELLPHONE){
			SetPlayerSpecialAction(PlayerInfo[playerid][pPhoneline], SPECIAL_ACTION_STOPUSECELLPHONE);
			printf("call 2"); 
		}
		
		/*format(str, sizeof(str), "* %s ปฏิเสทสายเรียกเข้า", ReturnName(playerid, 0));
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 3000);
		
		format(str, sizeof(str), "* %s ปฏิเสทสายเรียกเข้า", ReturnName(PlayerInfo[playerid][pPhoneline], 0));
		SetPlayerChatBubble(PlayerInfo[playerid][pPhoneline], str, COLOR_EMOTE, 20.0, 3000);*/
		
		PlayerInfo[playerid][pCalling] = 0;
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0;
		
        StopAudioStreamForPlayer(PlayerInfo[playerid][pPhoneline]);
		PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhoneline] = INVALID_PLAYER_ID;
		PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
		printf("call 3"); 
        StopAudioStreamForPlayer(playerid);
		return 1;
	}
	
	return 1;
}


alias:pickup("p")
CMD:pickup(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "โทรสัพท์ของคุณปิดอยู่");
		
	if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "คุณถูกล็อคด้วยกุญแจมือ");

	if(PlayerInfo[playerid][pPhoneline] == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "ไม่มีสายเรีบกเข้ามาหาคุณ"); 
		
	if(PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID && !PlayerInfo[playerid][pCalling])
		return SendErrorMessage(playerid, "คุณกำลัง พูดคุยอยู่อีกสาย"); 
		
	SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_GREY, "[ ! ] มีการตอบรับจากเลขหมายที่ท่านเรียก");
	SendClientMessage(playerid, COLOR_WHITE, "HINT: คุณสามารถพพิมพูดคุยกับสายตรงข้ามโดยการกด F6 แล้วพิมพ์คุยปกติได้เลย");	

	PlayerInfo[playerid][pCalling] = 0; 
	PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pCalling] = 0;
	
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	KillTimer(playerPhone[playerid]); 
	
	playerPhone[playerid] = 0; playerPhone[ PlayerInfo[playerid][pPhoneline] ] = 0;
    StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:loudspeaker(playerid, params[])
{
	if(PlayerInfo[playerid][pPhoneOff])
		return SendErrorMessage(playerid, "โทรสัพท์ของคุณปิดเครื่องอยู่");
		
	/*if(PlayerInfo[playerid][pHandcuffed])
		return SendErrorMessage(playerid, "คุณถูกใส่กุญแจมืออยู่"); */
		
	if(PlayerInfo[playerid][pPhonespeaker])
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ปิดลำโพงโทรสัพท์", ReturnName(playerid, 0));
		PlayerInfo[playerid][pPhonespeaker] = false;
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s เปิดลำโพงโทรสัพท์", ReturnName(playerid, 0));
		PlayerInfo[playerid][pPhonespeaker] = true;
	}
	
	return 1; 
}

forward OnPhoneCall(playerid, type);
public OnPhoneCall(playerid, type)
{
	switch(type)
	{
		case 1:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] หมายเลขที่คุณโทรออกไม่สามารถใช้งานได้"); 
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 2:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] ไม่สามารถติดต่อหมายเลขที่คุณโทรออกได้ในขณะนี้");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 3:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] สายไม่ว่าง");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
		case 4:
		{
			SendClientMessage(playerid, COLOR_GREY, "[ ! ] สายไม่ว่าง");
			playerPhone[playerid] = 0;
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			}
			
			return 1;
		}
	}
	return 1;
}

forward On911Call(playerid);
public On911Call(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณสามารถพพิมพูดคุยกับสายตรงข้ามโดยการกด F6");
	Player911Timer[1][playerid] = SetTimerEx("On911Pickup", 1500, false, "i", playerid);
	return 1;
}

forward On911Pickup(playerid);
public On911Pickup(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOWEX, "พนักงานสายด่วน: 911 ต้องการใช้บริการอะไรคะ?"); 
	
	PlayerInfo[playerid][pPhoneline] = 911;
	PlayerInfo[playerid][pCalling] = 0; 
	return 1; 
}

forward OnSuccessCall(playerid);
public OnSuccessCall(playerid)
{
	if(playerid != INVALID_PLAYER_ID){
		return 1;
	}
	
	return 0;
}


hook OnPlayerText(playerid, text[])
{
    new string[MAX_STRING];
    if(PlayerInfo[playerid][pPhoneline] != INVALID_PLAYER_ID && !PlayerInfo[playerid][pCalling])
	{
		if(PlayerInfo[playerid][pPhoneline] == 911)
		{
			format(string, sizeof(string), "%s พูดว่า (โทรสัพท์): %s", ReturnName(playerid, 0), text); 
			LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			
			switch(Player911Type[playerid])
			{
				case 0: // 0 service, 1 - emergency, 2 - location
				{
					if(strfind(text, "Police", true) != -1 || strfind(text, "ตำรวจ", true) != -1 || strfind(text, "Cops", true) != -1 || strfind(text, "Law enforcement", true) != -1)
					{
						format(Player911Text[playerid][0], 128, "%s", text);
						
						SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ตำรวจ พูดว่า: ตอนนี้คุณได้ถูกโอนสายไปยังสำนักงานตำรวจแล้ว กรุณาบอกเหตุฉุกเฉิกของคุณมา?"); 
						Player911Type[playerid] = 1; 
					}
					else if(strfind(text, "Medics", true) != -1 || strfind(text, "Paramedics", true) != -1 || strfind(text, "หมอ", true) != -1 || strfind(text, "Ambulance", true) != -1 || strfind(text, "Fire", true) != -1)
					{
						format(Player911Text[playerid][0], 128, "%s", text);
						
						SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ Fire DEP พูดว่า: ตอนนี้สายของคุณได้ถูกโอนมายังสำนักงาน Fire Department แล้วโปรดบอกเหตุฉุกเฉินของคุณมา?"); 
						Player911Type[playerid] = 2;
					}
					else SendClientMessage(playerid, COLOR_YELLOWEX, "พนักงานสายด่วน พูดว่า: โปรดแจ้งเราอีกทีได้ไหม");
				}
				case 1: //Police input;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "โปรดเล่าสถานการณ์คร่าวๆที่ละเอียดแบบพอเข้าใจ (เกิน 3 ตัวอักษร)"); 
						
					format(Player911Text[playerid][1], 128, "%s", text);
					
					SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ตำรวจ พูดว่า: ตอนนี้คุณอยู่ที่ไหน?"); 
					Player911Type[playerid] = 911; 
				}
				case 911: //Police;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "โปรดบอกสถาณที่ให้ชัดเจนกว่านี้ครับ (3 ตัวอักษรขึ้นไป)"); 
						
					format(Player911Text[playerid][2], 128, "%s", text);
					SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ตำรวจ พูดว่า: ทางเราได้จัดการส่งเรื่องนี้ให้เจ้าหน้าที่ที่ปฏิบัตรหน้าที่อยู่ในตอนนี้แล้ว โปรดรอเจ้าหน้าที่ไปถึง"); 
					
					Send911Message(playerid, 911); 
				}
				case 2: //Medic input;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "ปรดเล่าสถานการณ์คร่าวๆที่ละเอียดแบบพอเข้าใจ (เกิน 3 ตัวอักษร)"); 
						
					format(Player911Text[playerid][1], 128, "%s", text);
					
					SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ Fire DEP พูดว่า: ตอนนี้คุณอยู่ที่ไหน?"); 
					Player911Type[playerid] = 811; 
				}
				case 811: // Medic;
				{
					if(strlen(text) < 3)
						return SendErrorMessage(playerid, "โปรดบอกสถาณที่ให้ชัดเจนกว่านี้ครับ (3 ตัวอักษรขึ้นไป)"); 
						
					format(Player911Text[playerid][2], 128, "%s", text);
					SendClientMessage(playerid, COLOR_YELLOWEX, "เจ้าหน้าที่ Fire DEP พูดว่า: างเราได้จัดการส่งเรื่องนี้ให้เจ้าหน้าที่ที่ปฏิบัตรหน้าที่อยู่ในตอนนี้แล้ว โปรดรอเจ้าหน้าที่ไปถึง"); 
					
					Send911Message(playerid, 811); 
				}
			}
		}
		else
		{
			if(strlen(text) > 87)
			{
				format(string, sizeof(string), "%s พูดว่า (โทรสัพท์): %.87s...", ReturnName(playerid, 0), text); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				format(string, sizeof(string), "%s พูดว่า (โทรสัพท์): ... %s", ReturnName(playerid, 0), text[87]); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			}
			else
			{
				format(string, sizeof(string), "%s พูดว่า (โทรสัพท์): %s", ReturnName(playerid, 0), text); 
				LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
				
				if(!PlayerInfo[ PlayerInfo[playerid][pPhoneline] ][pPhonespeaker])
					SendClientMessage(PlayerInfo[playerid][pPhoneline], COLOR_YELLOWEX, string);
					
				else LocalChat(PlayerInfo[playerid][pPhoneline], 6.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4); 
			}
		}
		return 0; 
	}
	if (strlen(text) > 99)
	{
		format (string, sizeof(string), "%s พูดว่า: %.99s...", ReturnName(playerid, 0), text);
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				
		format (string, sizeof(string), "%s พูดว่า: ... %s", ReturnName(playerid, 0), text[99]); 
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
				
	}
	else 
	{	
		format (string, sizeof(string), "%s พูดว่า: %s", ReturnName(playerid, 0), text);
		LocalChat(playerid, 20.0, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4);
	}
    return 1;
}

stock LocalChat(playerid, Float:radi, const string[], color1, color2, color3, color4)
{
	if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED))
		return 0;
		
	new
		Float:currentPos[3], 
		Float:oldPos[3],
		Float:checkPos[3]
	;
		
	GetPlayerPos(playerid, oldPos[0], oldPos[1], oldPos[2]); 
	foreach (new i : Player)
	{
		if(!BitFlag_Get(gPlayerBitFlag[playerid], IS_LOGGED)) continue; 
		
		GetPlayerPos(i, currentPos[0], currentPos[1], currentPos[2]); 
		for (new p = 0; p < 3; p++)
		{
			checkPos[p] = (oldPos[p] - currentPos[p]);  
		}
		
		if (GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid))
			continue;
			
		if (((checkPos[0] < radi/16) && (checkPos[0] > -radi/16)) && ((checkPos[1] < radi/16) && (checkPos[1] > -radi/16)) && ((checkPos[2] < radi/16) && (checkPos[2] > -radi/16)))
		{
			SendClientMessage(i, color1, string);
		}
		else if (((checkPos[0] < radi/8) && (checkPos[0] > -radi/8)) && ((checkPos[1] < radi/8) && (checkPos[1] > -radi/8)) && ((checkPos[2] < radi/8) && (checkPos[2] > -radi/8)))
		{
			SendClientMessage(i, color2, string);
		}
		else if (((checkPos[0] < radi/4) && (checkPos[0] > -radi/4)) && ((checkPos[1] < radi/4) && (checkPos[1] > -radi/4)) && ((checkPos[2] < radi/4) && (checkPos[2] > -radi/4)))
		{
			SendClientMessage(i, color3, string);
		}
		else if (((checkPos[0] < radi/2) && (checkPos[0] > -radi/2)) && ((checkPos[1] < radi/2) && (checkPos[1] > -radi/2)) && ((checkPos[2] < radi/2) && (checkPos[2] > -radi/2)))
		{
			SendClientMessage(i, color4, string);
		}	
	}
	return 1;
}

stock Send911Message(playerid, type)
{
	switch(type)
	{
		case 911:
		{
			foreach(new i : Player) if(FactionInfo[PlayerInfo[i][pFaction]][eFactionType] == GOVERMENT)
			{
				SendClientMessage(i, COLOR_CYAN, "|____________Emergency Call____________|");
				SendClientMessageEx(i, COLOR_CYAN, "Caller: %s, เบอร์: %d, จาก: %s", ReturnName(playerid, 0), PlayerInfo[playerid][pPhone], ReturnLocation(playerid));
				SendClientMessageEx(i, COLOR_CYAN, "บริการที่ใช้: %s", Player911Text[playerid][0]);
				SendClientMessageEx(i, COLOR_CYAN, "สถานการณ์: %s", Player911Text[playerid][1]);
				SendClientMessageEx(i, COLOR_CYAN, "สถาณที่: %s", Player911Text[playerid][2]); 
			}
		}
		case 800:
		{
			foreach(new i : Player) if(FactionInfo[PlayerInfo[i][pFaction]][eFactionType] == GOVERMENT)
			{
				SendClientMessage(i, COLOR_CYAN, "|____________Emergency Call____________|");
				SendClientMessageEx(i, COLOR_CYAN, "Caller: %s, เบอร์: %d, จาก: %s", ReturnName(playerid, 0), PlayerInfo[playerid][pPhone], ReturnLocation(playerid));
				SendClientMessageEx(i, COLOR_CYAN, "บริการที่ใช้: %s", Player911Text[playerid][0]);
				SendClientMessageEx(i, COLOR_CYAN, "สถานการณ์: %s", Player911Text[playerid][1]);
				SendClientMessageEx(i, COLOR_CYAN, "สถาณที่: %s", Player911Text[playerid][2]); 
			}
		}
	}
	

	Player911Type[playerid] = 0;	
	//cmd_hangup(playerid, ""); 
    for(new i = 0; i < 2; i++) KillTimer(Player911Timer[i][playerid]); 
	SendClientMessage(playerid, COLOR_GREY, "[ ! ] คุณวางสาย"); 
		
	PlayerInfo[playerid][pPhoneline] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pCalling] = 0;
		
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE){
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
}

stock ReturnLocation(playerid)
{
	new 
		playerLocation[MAX_ZONE_NAME]
	;
	
	GetPlayer2DZone(playerid, playerLocation, MAX_ZONE_NAME);
	return playerLocation;
}

static const gSAZones[][E_SAZONE_MAIN] = {  // Majority of names and area coordinates adopted from Mabako's 'Zones Script' v0.2
        //      NAME                            AREA (Xmin,Ymin,Zmin,Xmax,Ymax,Zmax)
        {"The Big Ear",                 {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
        {"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
        {"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
        {"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
        {"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
        {"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
        {"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
        {"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
        {"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
        {"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
        {"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
        {"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
        {"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
        {"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
        {"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
        {"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
        {"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
        {"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
        {"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
        {"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
        {"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
        {"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
        {"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
        {"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
        {"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
        {"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
        {"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
        {"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
        {"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
        {"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
        {"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
        {"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
        {"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
        {"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
        {"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
        {"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
        {"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
        {"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
        {"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
        {"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
        {"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
        {"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
        {"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
        {"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
        {"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
        {"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
        {"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
        {"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
        {"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
        {"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
        {"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
        {"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
        {"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
        {"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
        {"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
        {"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
        {"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
        {"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
        {"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
        {"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
        {"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
        {"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
        {"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
        {"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
        {"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
        {"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
        {"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
        {"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
        {"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
        {"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
        {"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
        {"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
        {"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
        {"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
        {"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
        {"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
        {"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
        {"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
        {"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
        {"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
        {"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
        {"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
        {"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
        {"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
        {"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
        {"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
        {"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
        {"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
        {"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
        {"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
        {"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
        {"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
        {"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
        {"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
        {"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
        {"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
        {"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
        {"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
        {"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
        {"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
        {"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
        {"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
        {"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
        {"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
        {"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
        {"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
        {"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
        {"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
        {"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
        {"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
        {"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
        {"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
        {"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
        {"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
        {"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
        {"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
        {"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
        {"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
        {"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
        {"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
        {"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
        {"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
        {"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
        {"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
        {"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
        {"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
        {"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
        {"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
        {"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
        {"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
        {"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
        {"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
        {"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
        {"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
        {"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
        {"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
        {"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
        {"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
        {"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
        {"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
        {"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
        {"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
        {"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
        {"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
        {"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
        {"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
        {"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
        {"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
        {"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
        {"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
        {"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
        {"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
        {"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
        {"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
        {"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
        {"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
        {"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
        {"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
        {"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
        {"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
        {"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
        {"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
        {"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
        {"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
        {"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
        {"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
        {"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
        {"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
        {"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
        {"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
        {"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
        {"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
        {"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
        {"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
        {"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
        {"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
        {"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
        {"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
        {"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
        {"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
        {"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
        {"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
        {"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
        {"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
        {"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
        {"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
        {"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
        {"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
        {"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
        {"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
        {"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
        {"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
        {"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
        {"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
        {"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
        {"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
        {"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
        {"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
        {"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
        {"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
        {"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
        {"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
        {"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
        {"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
        {"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
        {"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
        {"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
        {"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
        {"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
        {"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
        {"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
        {"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
        {"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
        {"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
        {"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
        {"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
        {"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
        {"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
        {"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
        {"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
        {"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
        {"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
        {"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
        {"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
        {"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
        {"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
        {"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
        {"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
        {"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
        {"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
        {"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
        {"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
        {"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
        {"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
        {"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
        {"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
        {"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
        {"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
        {"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
        {"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
        {"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
        {"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
        {"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
        {"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
        {"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
        {"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
        {"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
        {"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
        {"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
        {"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
        {"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
        {"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
        {"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
        {"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
        {"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
        {"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
        {"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
        {"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
        {"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
        {"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
        {"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
        {"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
        {"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
        {"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
        {"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
        {"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
        {"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
        {"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
        {"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
        {"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
        {"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
        {"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
        {"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
        {"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
        {"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
        {"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
        {"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
        {"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
        {"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
        {"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
        {"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
        {"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
        {"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
        {"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
        {"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
        {"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
        {"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
        {"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
        {"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
        {"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
        {"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
        {"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
        {"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
        {"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
        {"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
        {"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
        {"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
        {"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
        {"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
        {"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
        {"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
        {"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
        {"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
        {"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
        {"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
        {"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
        {"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
        {"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
        {"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
        {"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
        {"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
        {"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
        {"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
        {"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
        {"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
        {"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
        {"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
        {"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
        {"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
        {"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
        {"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
        {"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
        {"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
        {"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
        {"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
        {"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
        {"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
        {"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
        {"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
        {"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
        {"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
        {"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
        {"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
        {"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
        {"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
        {"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
        {"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
        {"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
        {"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
        {"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
        {"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
        {"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
        {"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
        {"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
        {"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
        {"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
        {"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
        {"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
        {"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
        {"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
        {"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
        {"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
        {"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
        {"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
        {"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
        {"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
        // Main Zones
        {"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
        {"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
        {"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
        {"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
        {"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
        {"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
        {"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
        {"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
        {"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};


stock GetPlayer2DZone(playerid, zone[], len) //Credits to Cueball, Betamaster, Mabako, and Simon (for finetuning).
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i != sizeof(gSAZones); i++ )
	{
        if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
        {
            return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
        }
	}
	return 0;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    if(playertextid == PhonePlayer[playerid][3])
    {
        ShowPhoneBook(playerid);
        //Dialog_Show(playerid,DIALOG_PHONEBOOK_LIST,DIALOG_STYLE_LIST,"PhoneBook","เพื่มรายชื่อติดต่อ\nดูรายชื่อติดต่อ","ยืนยัน","ยกเลิก");
        return 1;
    }
    if(playertextid == PhonePlayer[playerid][2])
    {
        Dialog_Show(playerid,DIALOG_SMS_NUMBER,DIALOG_STYLE_INPUT,"ส่ง SMS","กรอกเบอร์ที่ต้องการส่ง SMS ไปหาเบอร์ที่ต้องการ","ยืนยัน","ยกเลิก");
        return 1;
    }
    if(playertextid == PhonePlayer[playerid][1])
    {
        Dialog_Show(playerid, DIALOG_CALL_INPUT, DIALOG_STYLE_INPUT, "ใส่เบอร์ที่ต้องการจะติดต่อ", "กรอกเบอร์ปลายทางของคุณที่ต้องการจะติดต่อไป (เบอร์ 5 หลัก)", "ยืนยัน", "ยกเลิก");
        return 1;
    }
    return 1;
}

Dialog:DIALOG_CALL_INPUT(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    new number = strval(inputtext);
    new str[40];

    format(str, number,"%d",number);
    callcmd::call(playerid, str);
    return 1;
}

Dialog:DIALOG_SMS_NUMBER(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        PhoneNumberSMS[playerid] = 0;
        return 1;
    }


    new number = strval(inputtext);
    new playerb = INVALID_PLAYER_ID;

    SendClientMessageEx(playerid, -1, "Bumber: %d",  number);

    foreach(new i : Player)
    { 
        if(PlayerInfo[i][pPhone] != number)
            continue;
                
        if(PlayerInfo[i][pPhone] == number)
        {
            playerb = i;
        }
    }

    if(!IsPlayerConnected(playerb))
        return SendErrorMessage(playerid, "ผู้เล่นไม่อยู่ภายในเซิร์ฟเวอร์");

    if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
		return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

    PhoneNumberSMS[playerid] = playerb;
    Dialog_Show(playerid, DIALOG_SEND_MESSAGE, DIALOG_STYLE_INPUT, "กรอกข้อความ:", "กรอกข้อความที่ต้องการจะส่ง SMS ไปหายังเบอร์ปลายทางของคุณ\n"EMBED_LIGHTRED"เสียค่าธรรมเนียมในการส่ง $3", "ยืนยัน", "ยกเลิก");
    //SendClientMessageEx(playerid, COLOR_REPORT, "SMS %d: %s",);

    return 1;
}

Dialog:DIALOG_SEND_MESSAGE(playerid, response, listitem, inputtext[])
{
    new playerb = INVALID_PLAYER_ID;
    playerb = PhoneNumberSMS[playerid];
    new text[400];
    
    if(strlen(inputtext) < 1 || strlen(inputtext) > 400)
    {
        PhoneNumberSMS[playerid] = 0;
        Dialog_Show(playerid, DIALOG_SEND_MESSAGE, DIALOG_STYLE_INPUT, "กรอกข้อความ:", "กรอกข้อความที่ต้องการจะส่ง SMS ไปหายังเบอร์ปลายทางของคุณ\n"EMBED_LIGHTRED"เสียค่าธรรมเนียมในการส่ง $3", "ยืนยัน", "ยกเลิก");
        return SendErrorMessage(playerid, "กรุณากรอกข้อความให้ถูกต้อง (ห้ามน้อยกว่า 3 และห้ามมากกว่า 400 อักษร)");
    }

    format(text, 90, "%s", inputtext);
    GiveMoney(playerid, -3);
    SendClientMessageEx(playerb, COLOR_REPORT, "SMS %d: %s", PlayerInfo[playerid][pPhone], text);
    return 1;
}

Dialog:DIALOG_APH_MENU(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;

    switch(listitem)
    {
        case 0: return Dialog_Show(playerid, DIALOG_CALL_INPUT, DIALOG_STYLE_INPUT, "ใส่เบอร์ที่ต้องการจะติดต่อ", "กรอกเบอร์ปลายทางของคุณที่ต้องการจะติดต่อไป (เบอร์ 5 หลัก)", "ยืนยัน", "ยกเลิก");
        case 1: return ShowPhoneBook(playerid);
        case 2: return Dialog_Show(playerid,DIALOG_SMS_NUMBER,DIALOG_STYLE_INPUT,"ส่ง SMS","กรอกเบอร์ที่ต้องการส่ง SMS ไปหาเบอร์ที่ต้องการ","ยืนยัน","ยกเลิก");
    }
    return 1;
}

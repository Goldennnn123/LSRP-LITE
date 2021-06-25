#include <YSI_Coding\y_hooks>

new miner_pickup, startjob[2], proceed_pickup;
new bool:PlayerStartOre[MAX_PLAYERS];

hook OnGameModeInit@13()
{
    miner_pickup = CreateDynamicPickup(1239, 2, 586.4755,872.6391,-42.4973, -1, -1,-1);
    proceed_pickup = CreateDynamicPickup(1239, 2, 674.1799,828.0583,-38.9921, -1, -1,-1);

    startjob[0] = CreateDynamicCircle(595.3938,926.8503, 15.0,-1);
    startjob[1] = CreateDynamicCircle(545.7205,919.6435, 15.0,-1);
    //CreateDynamicCircle(Float:x, Float:y, Float:size, worldid = -1, interiorid = -1, playerid = -1);
    return 1;
}

hook OP_PickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
    if(pickupid == miner_pickup)
    {
        SendClientMessage(playerid, -1, "����� /takejob ������Ѥçҹ �ѡ�ش����ͧ");
        return 1;
    }
    if(pickupid == proceed_pickup)
    {
        SendClientMessage(playerid, -1, "����� /ptze �������ٻ");
        return 1;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(RELEASED(KEY_RIGHT))
    {

        if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
            return 1;

        if(!IsPlayerInDynamicArea(playerid, startjob[0]) && !IsPlayerInDynamicArea(playerid, startjob[1]))
            return 1;

        if(PlayerStartOre[playerid])
            return 1;

        //GetPlayerPos(playerid, newPos[0], newPos[1], newPos[2]);

        if(IsPlayerInRangeOfPoint(playerid, 2.5, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]))
            return SendErrorMessage(playerid, "�س��ͧ����¹�ش�ش�ͧ�س");

        if(PlayerInfo[playerid][pOre] > 50)
            return SendErrorMessage(playerid, "�س�����㹵���������");

        new str[120];
        format(str, sizeof(str), "��������ش���...");
        callcmd::me(playerid, str);
        TogglePlayerControllable(playerid, 0);
        PlayerStartOre[playerid] = true;
        GetPlayerPos(playerid, PlayerInfo[playerid][pLastPosX], PlayerInfo[playerid][pLastPosY], PlayerInfo[playerid][pLastPosZ]);
        SetTimerEx("StartMine", 5000, false, "d",playerid);
        
        return 1;
    }
    return 1;
}

forward StartMine(playerid);
public StartMine(playerid)
{
    new amount = Random(1,3);
    PlayerStartOre[playerid] = false;
    PlayerInfo[playerid][pOre] += amount;
    SendClientMessageEx(playerid, COLOR_REPORT, "[MINER JOB] �س��������ش���������������ѧ��������ٻ�ӹǹ %d ���",amount);
    TogglePlayerControllable(playerid, 1);
    CharacterSave(playerid);
    return 1;
}

CMD:checkore(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
        return SendErrorMessage(playerid, "�س������Ҫվ �ѡ�ش����ͧ");

    SendClientMessage(playerid, COLOR_DARKGREEN, "---------- ORE ----------");
    SendClientMessageEx(playerid, COLOR_WHITE, "Unprocessed Ores: %d ���", PlayerInfo[playerid][pOre]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Coal Ore: %d ���", PlayerInfo[playerid][pCoal]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Iron Ore: %d ���", PlayerInfo[playerid][pIron]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Copper Ore: %d ���", PlayerInfo[playerid][pCopper]);
    SendClientMessageEx(playerid, COLOR_WHITE, "Potassium Nitrate: %d ���", PlayerInfo[playerid][pKNO3]);
    SendClientMessage(playerid, COLOR_DARKGREEN, "---------- ORE ----------");
    return 1;
}

CMD:ptze(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] != JOB_MINER && PlayerInfo[playerid][pSideJob] != JOB_MINER)
        return SendErrorMessage(playerid, "�س������Ҫվ �ѡ�ش����ͧ");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 674.1799,828.0583,-38.9921))
        return SendErrorMessage(playerid, "�س���������㹨ش Proceed");

    new amount, str[255];

    if(sscanf(params, "d",amount))
        return SendUsageMessage(playerid, "/ptze <�ӹǹ>");

    if(amount < 1)
        return SendUsageMessage(playerid, "/ptze <�ӹǹ> ���ӹǹ���١��ͧ");

    if(PlayerInfo[playerid][pOre] < amount)
        return SendErrorMessage(playerid, "�ӹǹ�����§��");

    format(str, sizeof(str), "�ӡ�����ٻ���...");
    callcmd::me(playerid, str);
    TogglePlayerControllable(playerid, 0);
    SendClientMessageEx(playerid, COLOR_YELLOW, "�س��������ٻ���ͧ�س �ӹǹ %d ��� ��ͧ������㹡�����ٻ %d �Թҷ�",amount, amount);
    SetTimerEx("ProceedOre", amount*1000, false, "dd", playerid, amount);
    return 1;
}

forward ProceedOre(playerid, amount);
public ProceedOre(playerid, amount)
{
    PlayerInfo[playerid][pOre]-= amount;
    TogglePlayerControllable(playerid, 1);
    
    new randore = random(9);
    
    switch(randore)
    {
        case 0:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� ��ҹ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 1:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� ��ҹ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 2:
        {
            PlayerInfo[playerid][pCoal] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� ��ҹ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 3:
        {
            PlayerInfo[playerid][pIron] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� ���� �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 4:
        {
            PlayerInfo[playerid][pIron] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� ���� �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 5:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� �ͧᴧ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 6:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� �ͧᴧ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 7:
        {
            PlayerInfo[playerid][pCopper] += amount;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� �ͧᴧ �� %d ��͹",amount);
            CharacterSave(playerid);
            return 1;
        }
        case 8:
        {
            PlayerInfo[playerid][pKNO3] += amount / 2;
            SendClientMessageEx(playerid, -1, "�س�����ٻ���ͧ�س �س�� �ͧᴧ �� %d ��͹",amount /2);
            CharacterSave(playerid);
            return 1;
        }
    }
    return 1;
}
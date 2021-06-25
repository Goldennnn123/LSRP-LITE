// ��ª����Ҫվ

enum
{
	JOB_NONE,
	JOB_FARMER,
	JOB_TRUCKER,
	JOB_MECHANIC,
	JOB_MINER,
}

stock GetJobName(career, jobid)
{
	#pragma unused career

	new name[32];

	switch(jobid)
	{
	    case JOB_FARMER: format(name, 32, "������");
		case JOB_TRUCKER: format(name, 32, "��ѡ�ҹ�觢ͧ");
		case JOB_MECHANIC: format(name, 32, "��ҧ¹��");
		case JOB_MINER: format(name, 32, "�ѡ�ش����ͧ");
	    default: format(name, 32, "��ҧ�ҹ");
	}
	return name;
}

CMD:takejob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != JOB_NONE)
		return SendErrorMessage(playerid, "�س���Ҫվ��������");

	if(IsPlayerInRangeOfPoint(playerid, 3.0, -242.5856,-235.4501,2.4297))
	{
		PlayerInfo[playerid][pJob] = JOB_TRUCKER;
		SendClientMessage(playerid, COLOR_DARKGREEN, "[TRUCKER JOB] �س��ӡ����Ѥçҹ ��ѡ�ҹ�觢ͧ���� ����ö����� /jobhelp ���ʹ٤����");
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 88.1169,-164.9625,2.5938))
	{
		PlayerInfo[playerid][pJob] = JOB_MECHANIC;
		SendClientMessage(playerid, COLOR_DARKGREEN, "[MECHANIC JOB] �س��ӡ����Ѥçҹ ��ҧ ����ö����� /jobhelp ���ʹ٤����");
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 586.4755,872.6391,-42.4973))
	{

		if(PlayerInfo[playerid][pJob])
		{
			if(PlayerInfo[playerid][pSideJob])
				return SendErrorMessage(playerid, "�س���Ҫվ�������������");
			
			PlayerInfo[playerid][pSideJob] = JOB_MINER;
		}
		else
		{
			PlayerInfo[playerid][pJob] = JOB_MINER;
		}

		
		SendClientMessage(playerid, COLOR_DARKGREEN, "[MINER JOB] �س��ӡ����Ѥçҹ �ѡ�ش����ͧ ����ö����� /jobhelp ���ʹ٤����");
		return 1;
	}

	else SendErrorMessage(playerid, "�س��������㹨ش��Ѥçҹ");
	
	return 1;
}

CMD:quitjob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == JOB_NONE)
		return SendErrorMessage(playerid, "�س��������Ҫվ��������");

	SendClientMessage(playerid, COLOR_HELPME, "�س���͡�ҡ�Ҫվ �Ѩ�غѹ���� �س������ö���Ѥçҹ���سʹ����׹��");
	PlayerInfo[playerid][pJob] = JOB_NONE;
	PlayerInfo[playerid][pJobRank] = 0;
	PlayerInfo[playerid][pJobExp] = 0;
	CharacterSave(playerid);
	return 1;
}
// ��ª����Ҫվ

enum
{
	JOB_NONE,
	JOB_FARMER,
	JOB_TRUCKER
}

stock GetJobName(career, jobid)
{
	#pragma unused career

	new name[32];

	switch(jobid)
	{
	    case JOB_FARMER: format(name, 32, "������");
		case JOB_TRUCKER: format(name, 32, "��ѡ�ҹ�觢ͧ");
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
	return 1;
}
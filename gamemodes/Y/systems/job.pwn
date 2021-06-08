// รายชื่ออาชีพ

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
	    case JOB_FARMER: format(name, 32, "ชาวไร่");
		case JOB_TRUCKER: format(name, 32, "พนักงานส่งของ");
	    default: format(name, 32, "ว่างงาน");
	}
	return name;
}

CMD:takejob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] != JOB_NONE)
		return SendErrorMessage(playerid, "คุณมีอาชีพอยู่แล้ว");

	if(IsPlayerInRangeOfPoint(playerid, 3.0, -242.5856,-235.4501,2.4297))
	{
		PlayerInfo[playerid][pJob] = JOB_TRUCKER;
		SendClientMessage(playerid, COLOR_DARKGREEN, "[TRUCKER JOB] คุณได้ทำการสมัครงาน พนักงานส่งของแล้ว สามารถพิมพ์ /jobhelp เพื่อดูคำสั่ง");
		return 1;
	}
	return 1;
}
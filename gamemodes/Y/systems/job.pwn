// รายชื่ออาชีพ

enum
{
	JOB_NONE,
	JOB_FARMER,
	JOB_TRUCKER,
	JOB_MECHANIC,
	JOB_MINER,
	JOB_ELECTRICIAN,
}

stock GetJobName(career, jobid)
{
	#pragma unused career

	new name[32];

	switch(jobid)
	{
	    case JOB_FARMER: format(name, 32, "ชาวไร่");
		case JOB_TRUCKER: format(name, 32, "พนักงานส่งของ");
		case JOB_MECHANIC: format(name, 32, "ช่างยนต์");
		case JOB_MINER: format(name, 32, "นักขุดเหมือง");
		case JOB_ELECTRICIAN: format(name, 32, "ช่างไฟฟ้า");
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
		GameTextForPlayer(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Trucker.~n~~w~/jobhelp.", 8000, 1);
		SendClientMessage(playerid, COLOR_DARKGREEN, "[TRUCKER JOB] คุณได้ทำการสมัครงาน พนักงานส่งของแล้ว สามารถพิมพ์ /jobhelp เพื่อดูคำสั่ง");
		CharacterSave(playerid);
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 88.1169,-164.9625,2.5938))
	{
		PlayerInfo[playerid][pJob] = JOB_MECHANIC;
		GameTextForPlayer(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Mechanic.~n~~w~/jobhelp.", 8000, 1);
		SendClientMessage(playerid, COLOR_DARKGREEN, "[MECHANIC JOB] คุณได้ทำการสมัครงาน ช่าง สามารถพิมพ์ /jobhelp เพื่อดูคำสั่ง");
		CharacterSave(playerid);
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 586.4755,872.6391,-42.4973))
	{

		if(PlayerInfo[playerid][pJob])
		{
			if(PlayerInfo[playerid][pSideJob])
				return SendErrorMessage(playerid, "คุณมีอาชีพเสริมอยู่แล้ว");
			
			PlayerInfo[playerid][pSideJob] = JOB_MINER;
		}
		else
		{
			PlayerInfo[playerid][pJob] = JOB_MINER;
		}

		
		GameTextForPlayer(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Miner.~n~~w~/jobhelp.", 8000, 1);
		SendClientMessage(playerid, COLOR_DARKGREEN, "[MINER JOB] คุณได้ทำการสมัครงาน นักขุดเหมือง สามารถพิมพ์ /jobhelp เพื่อดูคำสั่ง");
		CharacterSave(playerid);
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2076.7122,-2026.7233,13.5469))
	{

		if(PlayerInfo[playerid][pJob])
		{
			if(PlayerInfo[playerid][pSideJob])
				return SendErrorMessage(playerid, "คุณมีอาชีพเสริมอยู่แล้ว");
			
			PlayerInfo[playerid][pSideJob] = JOB_ELECTRICIAN;
		}
		else
		{
			PlayerInfo[playerid][pJob] = JOB_ELECTRICIAN;
		}

		
		GameTextForPlayer(playerid, "~r~Congratulations,~n~~w~You are now a ~y~Electrician.~n~~w~/jobhelp.", 8000, 1);
		SendClientMessage(playerid, COLOR_DARKGREEN, "[ELECTRICIAN JOB] คุณได้ทำการสมัครงาน ช่างซ่อมไฟฟ้า สามารถพิมพ์ /jobhelp เพื่อดูคำสั่ง");
		CharacterSave(playerid);
		return 1;
	}

	else SendErrorMessage(playerid, "คุณไมได้อยู่ในจุดสมัครงาน");
	
	return 1;
}

CMD:quitjob(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == JOB_NONE)
		return SendErrorMessage(playerid, "คุณไม่ได้มีอาชีพอยู่แล้ว");

	SendClientMessage(playerid, COLOR_HELPME, "คุณได้ออกจากอาชีพ ปัจจุบันแล้ว คุณจะสามารถไปสมัครงานที่คุณสนใจได้อืนได้");
	PlayerInfo[playerid][pJob] = JOB_NONE;
	PlayerInfo[playerid][pJobRank] = 0;
	PlayerInfo[playerid][pJobExp] = 0;
	CharacterSave(playerid);
	return 1;
}
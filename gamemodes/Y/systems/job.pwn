// รายชื่ออาชีพ

enum
{
	JOB_NONE,
	JOB_FARMER
}

stock GetJobName(career, jobid)
{
	#pragma unused career

	new name[32];

	switch(jobid)
	{
	    case JOB_FARMER: format(name, 32, "ชาวไร่");
	    default: format(name, 32, "ว่างงาน");
	}
	return name;
}
// ��ª����Ҫվ

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
	    case JOB_FARMER: format(name, 32, "������");
	    default: format(name, 32, "��ҧ�ҹ");
	}
	return name;
}
//เตรียมไฟล์สำหรับการสร้าง ท่าทาง Anim ต่างๆ ลงตรงนี้

//สร้างเส็จให้พืพม์ git add . และ git comit -m "พิมพ์รายละเอียดการอัพเดท" ต่อด้วยการพิมพ์ git push master/origin
#include <YSI_Coding\y_hooks>

CMD:anim(playerid, params[])
{
    SendClientMessage(playerid, COLOR_GREEN,"____________อนิเมชั่นตัวละคร____________");
    SendClientMessage(playerid, COLOR_WHITE,"[นั่ง/นอน] /sit /chairsit /groundsit /seat /sleep /lean");
	SendClientMessage(playerid, COLOR_WHITE,"[สัญญาณมือ] /gsign /salute");
	SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /greet /taxiL /taxiR");
    SendClientMessage(playerid, COLOR_WHITE,"[การสื่อสาร] /fuckyou /wave /kiss /no");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /bat /punch /taunt /facepalm /aim /slapass");
    SendClientMessage(playerid, COLOR_WHITE,"[กริยาทางกายภาพ] /hide /crawl /crack /think /sipdrink /sipdrink2");
    SendClientMessage(playerid, COLOR_WHITE,"[อารมณ์] /cry /injured /panic");
	SendClientMessage(playerid, COLOR_WHITE,"[ยานพาหนะ] /opendoor_right /opendoor_left");
	SendClientMessage(playerid, COLOR_WHITE,"[การเดิน] /sneak /jog");
    SendClientMessage(playerid, COLOR_GREEN,"_____________________________________________");

    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /fall | /fallback | /injured | /akick | /push | /lowbodypush | /handsup | /bomb | /drunk | /getarrested | /laugh | /sup"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /basket | /headbutt | /medic | /spray | /robman | /taichi | /lookout | /kiss | /cellin | /cellout | /crossarms | /lay"); // เสร็จ
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /efixcar | /efixcarout"); // กําลังทํา
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /lifejump | /exhaust | /leftslap | /carlock | /hoodfrisked | /lightcig | /tapcig | /box | /lay2 | /chant | /fuckyou| /fuckyou2");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /shouting | /knife | /cop | /elbow | /kneekick | /airkick | /gkick | /punch | /gpunch | /fstance | /lowthrow | /highthrow | /aim");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /pee | /lean | /run | /poli | /surrender | /sit | /breathless | /seat | /rap | /cross | /jiggy | /gsign");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /sleep | /smoke | /pee | /chora | /relax | /crabs | /stop | /wash | /mourn | /fuck | /tosteal | /crawl");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /followme | /greet | /still | /hitch | /palmbitch | /cpranim | /giftgiving | /slap2 | /pump | /cheer");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /dj | /foodeat | /wave | /slapass | /dealer | /dealstance | /inbedright | /inbedleft");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /wank | /bj | /getup | /follow | /stand | /slapped | /yes | /celebrate | /win | /checkout");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /thankyou | /invite1 | /scratch | /nod | /cry | /carsmoke | /benddown | /facepalm | /angry");
    SendClientMessage(playerid, COLOR_DARKGREEN, "{FFFFFF} /cockgun | /bar | /liftup | /putdown | /camera | /think | /handstand | /panicjump");

    return 1;
}
CMD:fall(playerid, params[])
{
    ApplyAnimation(playerid,"PED","KO_skid_front",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:fallback(playerid, params[])
{
    ApplyAnimation(playerid, "PED","FLOOR_hit_f", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:injured(playerid, params[])
{
    ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:akick(playerid, params[])
{
    ApplyAnimation(playerid,"POLICE","Door_Kick",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}
CMD:push(playerid, params[])
{
    ApplyAnimation(playerid,"GANGS","shake_cara",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}
CMD:lowbodypush(playerid, params[])
{
    ApplyAnimation(playerid,"GANGS","shake_carSH",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:handsup(playerid, params[])
{
    ApplyAnimation(playerid, "ROB_BANK","SHP_HandsUp_Scr",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:bomb(playerid, params[])
{
    ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}
CMD:drunk(playerid, params[])
{
    ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}
CMD:getarrested(playerid, params[])
{
    ApplyAnimation(playerid,"ped", "ARRESTgun", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:laugh(playerid, params[])
{
    ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:sup(playerid, params[])
{
    new number;
	if(sscanf(params, "i", number)) return SendUsageMessage(playerid, "/sup [1-3]");
	if(number < 1 || number > 3) { SendUsageMessage(playerid, "/sup [1-3]"); }
	if(number == 1) { ApplyAnimation(playerid,"GANGS","hndshkba",4.1, 0, 1, 1, 1, 1, 1); }
	if(number == 2) { ApplyAnimation(playerid,"GANGS","hndshkda",4.1, 0, 1, 1, 1, 1, 1); }
    if(number == 3) { ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.1, 0, 1, 1, 1, 1, 1); }
   	return 1;
}
CMD:basket(playerid, params[])
{
    new ddr;
	if (sscanf(params, "i", ddr)) return SendUsageMessage(playerid, "/basket [1-6]");
    if(ddr < 1 || ddr > 6) return SendUsageMessage(playerid, "/basket [1-6]"); 
	switch(ddr)
	{
		case 1: { ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1, 0, 1, 1, 1, 1, 1); }
		case 2: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.1, 0, 1, 1, 1, 1, 1); }
		case 3: { ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.1, 0, 1, 1, 1, 1, 1); }
		case 4: { ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1, 0, 1, 1, 1, 1, 1); }
		case 5: { ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.1, 1, 1, 1, 1, 1, 1); }
		case 6: { ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.1, 0, 1, 1, 0, 1, 1); }
	}
   	return 1;
}
CMD:headbutt(playerid, params[])
{
    ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:medic(playerid, params[])
{
    ApplyAnimation(playerid,"MEDIC","CPR",4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}
CMD:spray(playerid, params[])
{
    ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:robman(playerid, params[]) 
{
    ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:taichi(playerid, params[])
{
    ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.1, 1, 1, 1, 1, 1, 1); 
    return 1;
}
CMD:lookout(playerid, params[])
{
    ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.1, 0, 1, 1, 0, 0, 1); 
    return 1;
}
CMD:kiss(playerid, params[])
{
    ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.1, 0, 1, 1, 0, 1, 1);
    return 1;
}
/*CMD:cellin(playerid, params[])
{
    
    return 1;
}
CMD:cellout(playerid, params[])

{    
    return 1;
}*/
CMD:crossarms(playerid, params[])
{
    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
CMD:lay(playerid, params[])
{
    ApplyAnimation(playerid,"BEACH", "bather",4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}
///deal | /crack | /groundsit | /chat  | /dance | /fucku | /strip | /hide | /vomit | /chairsit | /reload");
CMD:deal(playerid, params[])
{
    
    return 1;
}
CMD:crack(playerid, params[])
{
    
    return 1;
}
CMD:groundsit(playerid, params[])
{
    
    return 1;
}
CMD:chat(playerid, params[])
{
    
    return 1;
}
CMD:dance(playerid, params[])
{
    
    return 1;
}
CMD:fucku(playerid, params[])
{
    
    return 1;
}
CMD:strip(playerid, params[])
{
    
    return 1;
}
CMD:hide(playerid, params[])
{
    
    return 1;
}
CMD:vomit(playerid, params[])
{
    
    return 1;
}
CMD:chairsit(playerid, params[])
{
    
    return 1;
}
CMD:reload(playerid, params[])
{
    
    return 1;
}
///koface | /kostomach | /rollfall | /bat | /die | /joint | /bed | /lranim | /fixcar | /fixcarout
CMD:koface(playerid, params[])
{
    
    return 1;
}
CMD:lostomach(playerid, params[])
{
    
    return 1;
}
CMD:rollfall(playerid, params[])
{
    
    return 1;
}
CMD:bat(playerid, params[])
{
    
    return 1;
}
CMD:die(playerid, params[])
{
    
    return 1;
}
CMD:joint(playerid, params[])
{
    
    return 1;
}
CMD:bed(playerid, params[])
{
    
    return 1;
}
CMD:iranim(playerid, params[])
{
    
    return 1;
}
CMD:efixcar(playerid, params[])
{
    
    return 1;
}
CMD:efixcarout(playerid, params[])
{
    
    return 1;
}


















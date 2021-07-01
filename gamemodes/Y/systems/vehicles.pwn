#include <YSI_Coding\y_hooks>

new PlayerText:Unscrambler_PTD[MAX_PLAYERS][7]; 
new PlayerText:Statsvehicle[MAX_PLAYERS][2];

new gLastCar[MAX_PLAYERS];
new gPassengerCar[MAX_PLAYERS];
new playerInsertID[MAX_PLAYERS];


new PlayerVehicleScrap[MAX_PLAYERS];
new PlayerOwnerDBID[MAX_PLAYERS];

new bool:playerTowingVehicle[MAX_PLAYERS] = false;
new	playerTowTimer[MAX_PLAYERS] = 0;

new PlayerSellVehicle[MAX_PLAYERS];
new PlayerSellVehicleBy[MAX_PLAYERS];
new PlayerSellVehicleID[MAX_PLAYERS];
new PlayerSellVehiclePrice[MAX_PLAYERS];
new bool:PlayerSellVehicleAccept[MAX_PLAYERS];

new rental_vehicles[10];
new RentCarKey[MAX_PLAYERS];


enum c_data {
	Float:c_maxhp,
};

new const VehicleData[][c_data] =
{
	{1120.0}, //Vehicle ID 401
	{900.0}, //Vehicle ID 402
	{900.0}, //Vehicle ID 403
	{2500.0}, //Vehicle ID 404
	{1120.0}, //Vehicle ID 405
	{950.0}, //Vehicle ID 406
	{3000.0}, //Vehicle ID 407
	{2500.0}, //Vehicle ID 408
	{1100.0}, //Vehicle ID 409
	{950.0}, //Vehicle ID 410
	{890.0}, //Vehicle ID 411
	{1000.0}, //Vehicle ID 412
	{1050.0}, //Vehicle ID 413
	{1500.0}, //Vehicle ID 414
	{890.9}, //Vehicle ID 415
	{1500.0}, //Vehicle ID 416
	{2600.0}, //Vehicle ID 417
	{1200.0}, //Vehicle ID 418
	{1030.0}, //Vehicle ID 419
	{1050.0}, //Vehicle ID 420
	{1100.0}, //Vehicle ID 421
	{1200.0}, //Vehicle ID 422
	{1300.0}, //Vehicle ID 423
	{900.0}, //Vehicle ID 424
	{3000.0}, //Vehicle ID 425
	{1100.0}, //Vehicle ID 426
	{10000.0}, //Vehicle ID 427
	{8900.0}, //Vehicle ID 428
	{889.0}, //Vehicle ID 429
	{1100.0}, //Vehicle ID 430
	{1500.0}, //Vehicle ID 431
	{250000.0}, //Vehicle ID 432
	{5000.0}, //Vehicle ID 433
	{800.0}, //Vehicle ID 434
	{0.0}, //Vehicle ID 435
	{1100.0}, //Vehicle ID 436
	{1500.0}, //Vehicle ID 437
	{1350.0}, //Vehicle ID 438
	{950.0}, //Vehicle ID 439
	{1350.0}, //Vehicle ID 440
	{700.0}, //Vehicle ID 441
	{1100.0}, //Vehicle ID 442
	{2500.0}, //Vehicle ID 443
	{2400.0}, //Vehicle ID 444
	{1150.0}, //Vehicle ID 445
	{1000.0}, //Vehicle ID 446
	{1250.0}, //Vehicle ID 447
	{690.0}, //Vehicle ID 448
	{0.0}, //Vehicle ID 449
	{0.0}, //Vehicle ID 450
	{890.0}, //Vehicle ID 451
	{1000.0}, //Vehicle ID 452
	{1500.0}, //Vehicle ID 453
	{1550.0}, //Vehicle ID 454
	{2500.0}, //Vehicle ID 455
	{1900.0}, //Vehicle ID 456
	{800.0}, //Vehicle ID 457
	{1150.0}, //Vehicle ID 458
	{1200.0}, //Vehicle ID 459
	{1000.0}, //Vehicle ID 460
	{700.0}, //Vehicle ID 461
	{700.0}, //Vehicle ID 462
	{700.0}, //Vehicle ID 463
	{0.0}, //Vehicle ID 464
	{0.0}, //Vehicle ID 465
	{1000.0}, //Vehicle ID 466
	{1000.0}, //Vehicle ID 467
	{700.0}, //Vehicle ID 468
	{1100.0}, //Vehicle ID 469
	{1550.0}, //Vehicle ID 470
	{700.0}, //Vehicle ID 471
	{1000.0}, //Vehicle ID 472
	{1000.0}, //Vehicle ID 473
	{1000.0}, //Vehicle ID 474
	{1000.0}, //Vehicle ID 475
	{1100.0}, //Vehicle ID 476
	{890.0}, //Vehicle ID 477
	{950.0}, //Vehicle ID 478
	{1220.0}, //Vehicle ID 479
	{890.0}, //Vehicle ID 480
	{700.0}, //Vehicle ID 481
	{1100.0}, //Vehicle ID 482
	{1200.0}, //Vehicle ID 483
	{1000.0}, //Vehicle ID 484
	{891.0}, //Vehicle ID 485
	{3500.0}, //Vehicle ID 486
	{1250.0}, //Vehicle ID 487
	{1250.0}, //Vehicle ID 488
	{1350.0}, //Vehicle ID 489
	{1350.0}, //Vehicle ID 490
	{1200.0}, //Vehicle ID 491
	{1200.0}, //Vehicle ID 492
	{1000.0}, //Vehicle ID 493
	{1350.0}, //Vehicle ID 494
	{1350.0}, //Vehicle ID 495
	{1100.0}, //Vehicle ID 496
	{1350.0}, //Vehicle ID 497
	{1300.0}, //Vehicle ID 498
	{1300.0}, //Vehicle ID 499
	{900.0}, //Vehicle ID 500
	{0.0}, //Vehicle ID 501
	{1350.0}, //Vehicle ID 502
	{1350.0}, //Vehicle ID 503
	{0.0}, //Vehicle ID 504
	{1250.0}, //Vehicle ID 505
	{790.0}, //Vehicle ID 506
	{1100.0}, //Vehicle ID 507
	{1900.0}, //Vehicle ID 508
	{700.0}, //Vehicle ID 509
	{700.0}, //Vehicle ID 510
	{1100.0}, //Vehicle ID 511
	{1350.0}, //Vehicle ID 512
	{1350.0}, //Vehicle ID 513
	{2450.0}, //Vehicle ID 514
	{1200.0}, //Vehicle ID 515
	{1200.0}, //Vehicle ID 516
	{1200.0}, //Vehicle ID 516
	{1200.0}, //Vehicle ID 517
	{1200.0}, //Vehicle ID 518
	{4500.0}, //Vehicle ID 519
	{3500.0}, //Vehicle ID 520
	{700.0}, //Vehicle ID 521
	{690.0}, //Vehicle ID 522
	{1100.0}, //Vehicle ID 523
	{4500.0}, //Vehicle ID 524
	{1400.0}, //Vehicle ID 525
	{1000.0}, //Vehicle ID 526
	{1000.0}, //Vehicle ID 527
	{15000.0}, //Vehicle ID 528
	{1100.0}, //Vehicle ID 529
	{980.0}, //Vehicle ID 530
	{1000.0}, //Vehicle ID 531
	{6000.0}, //Vehicle ID 532
	{1100.0}, //Vehicle ID 533
	{1100.0}, //Vehicle ID 534
	{1350.0}, //Vehicle ID 535
	{1100.0}, //Vehicle ID 536
	{0.0}, //Vehicle ID 537
	{0.0}, //Vehicle ID 538
	{0.0}, //Vehicle ID 539
	{1000.0}, //Vehicle ID 540
	{790.0}, //Vehicle ID 541
	{1100.0}, //Vehicle ID 542
	{1350.0}, //Vehicle ID 543
	{2600.0}, //Vehicle ID 544
	{780.0}, //Vehicle ID 545
	{1100.0}, //Vehicle ID 546
	{1100.0}, //Vehicle ID 547
	{8000.0}, //Vehicle ID 548
	{1100.0}, //Vehicle ID 549
	{1100.0}, //Vehicle ID 550
	{1090.0}, //Vehicle ID 551
	{1350.0}, //Vehicle ID 552
	{10000.0}, //Vehicle ID 553
	{1030.0}, //Vehicle ID 554
	{900.0}, //Vehicle ID 555
	{1200.0}, //Vehicle ID 556
	{1200.0}, //Vehicle ID 557
	{998.0}, //Vehicle ID 558
	{990.0}, //Vehicle ID 559
	{1200.0}, //Vehicle ID 560
	{1300.0}, //Vehicle ID 561
	{1100.0}, //Vehicle ID 562
	{2400.0}, //Vehicle ID 563
	{0.0}, //Vehicle ID 564
	{1250.0}, //Vehicle ID 565
	{1100.0}, //Vehicle ID 566
	{1100.0}, //Vehicle ID 567
	{810.0}, //Vehicle ID 568
	{0.0}, //Vehicle ID 569
	{0.0}, //Vehicle ID 570
	{0.0}, //Vehicle ID 571
	{700.0}, //Vehicle ID 572
	{1900.0}, //Vehicle ID 573
	{780.0}, //Vehicle ID 574
	{1100.0}, //Vehicle ID 575
	{1100.0}, //Vehicle ID 576
	{8000.0}, //Vehicle ID 577
	{8000.0}, //Vehicle ID 578
	{1200.0}, //Vehicle ID 579
	{1200.0}, //Vehicle ID 580
	{700.0}, //Vehicle ID 581
	{1250.0}, //Vehicle ID 582
	{890.0}, //Vehicle ID 583
	{1000.0}, //Vehicle ID 584
	{1200.0}, //Vehicle ID 585
	{900.0}, //Vehicle ID 586
	{890.0}, //Vehicle ID 587
	{1250.0}, //Vehicle ID 588
	{1500.0}, //Vehicle ID 589
	{0.0}, //Vehicle ID 590
	{0.0}, //Vehicle ID 591
	{9000.0}, //Vehicle ID 592
	{2500.0}, //Vehicle ID 593
	{0.0}, //Vehicle ID 594
	{1350.0}, //Vehicle ID 595
	{1500.0}, //Vehicle ID 596
	{1500.0}, //Vehicle ID 597
	{1500.0}, //Vehicle ID 598
	{2000.0}, //Vehicle ID 599
	{1100.0}, //Vehicle ID 600
	{25000.0}, //Vehicle ID 601
	{890.0}, //Vehicle ID 602
	{890.0}, //Vehicle ID 603
	{0.0}, //Vehicle ID 604
	{0.0}, //Vehicle ID 605
	{0.0}, //Vehicle ID 606
	{0.0}, //Vehicle ID 607
	{0.0}, //Vehicle ID 608
	{1200.0}, //Vehicle ID 609
	{0.0}, //Vehicle ID 610
	{0.0} //Vehicle ID 611
};

hook OnPlayerConnect(playerid)
{
	PlayerVehicleScrap[playerid] = 0;
	playerTowingVehicle[playerid] = false;
	playerTowTimer[playerid] = 0;

	PlayerSellVehicle[playerid] = 0;
	PlayerSellVehicleBy[playerid] = INVALID_PLAYER_ID;
	PlayerSellVehicleID[playerid] = INVALID_VEHICLE_ID;
	PlayerSellVehiclePrice[playerid] = 0;
	PlayerSellVehicleAccept[playerid] = false;
	return 1;
}


hook OnGameModeInit()
{
	SetTimer("OnVehicleUpdate", 250, true);
	return 1;
}

static const UnscrambleWord[][] = {
	"SPIDER", "DROP", "HIRE", "EARTH", "GOLD", "HEART", "FLOWER", "KNIFE",
	"POOL", "BEACH", "HEEL", "APPLE", "ART", "BEAN", "BEHIND", "AWAY",
	"COOKIE", "DANCE", "SALE", "SEXY", "BULLET", "GRAPE", "GROUND", "FLIP", "DIRT",
	"PRIDE", "AROUSE", "SOUP", "CIRCUS", "VERBA", "RENT", "REFUND", "HUMAN", "ANIMAL",
	"SNOOP", "FOUR", "TURKEY", "HOLE", "HUMOR"
}
;

static stock g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Cruiser", "SFPD Cruiser", "LVPD Cruiser",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

stock HasNoEngine(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}

stock ReturnVehicleName(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid),
		name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}

stock ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}


stock GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] - (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] - (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
} 

stock ResetVehicleVars(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;
		
	VehicleInfo[vehicleid][eVehicleDBID] = 0; 
	VehicleInfo[vehicleid][eVehicleExists] = false;
	
	VehicleInfo[vehicleid][eVehicleOwnerDBID] = 0;
	VehicleInfo[vehicleid][eVehicleFaction] = 0;
	
	VehicleInfo[vehicleid][eVehicleImpounded] = false;
	VehicleInfo[vehicleid][eVehiclePaintjob] = -1; 
	
	VehicleInfo[vehicleid][eVehicleFuel] = 100; 
	
	for(new i = 1; i < 6; i++)
	{
		VehicleInfo[vehicleid][eVehicleWeapons][i] = 0;
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][i] = 0;
	}
	
	for(new i = 1; i < 5; i++)
	{
		VehicleInfo[vehicleid][eVehicleLastDrivers][i] = 0;
		VehicleInfo[vehicleid][eVehicleLastPassengers][i] = 0;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount] = 0;
	VehicleInfo[vehicleid][eVehicleRepairCount] = 0;
	
	VehicleInfo[vehicleid][eVehicleHasXMR] = false;
	VehicleInfo[vehicleid][eVehicleBattery] = 100.0;
	VehicleInfo[vehicleid][eVehicleEngine] = 100.0;
	VehicleInfo[vehicleid][eVehicleTimesDestroyed] = 0;
	
	VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
	VehicleInfo[vehicleid][eVehicleLights] = false;
	
	VehicleInfo[vehicleid][eVehicleTruck] = 0;

	VehicleInfo[vehicleid][eVehiclePrice] = 0;
	return 1;
}

stock ToggleVehicleEngine(vehicleid, bool:enginestate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, enginestate, lights, alarm, doors, bonnet, boot, objective);
	return 1;
}

stock ToggleVehicleAlarms(vehicleid, bool:alarmstate, time = 5000)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
 
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarmstate, doors, bonnet, boot, alarmstate);
	
	if(alarmstate) defer OnVehicleAlarm[time](vehicleid);
	return 1;
}

stock ScrambleWord(const str[])
{
	new scam[16];
    strcat(scam, str);
	new tmp[2], num, len = strlen(scam);

	while(strequal(str, scam)) {
		for(new i=0; scam[i] != EOS; ++i)
		{
			num = random(len);
			tmp[0] = scam[i];
			tmp[1] = scam[num];
			scam[num] = tmp[0];
			scam[i] = tmp[1];
		}
	}
	return scam;
}

stock CreateUnscrambleTextdraw(playerid, bool:showTextdraw = true)
{
	if(showTextdraw)
	{
		//Unscrambler Textdraws:
		Unscrambler_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 199.873275, 273.593383, "<UNSCRAMBLED_WORD>");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][0], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][0], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][0], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][0], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][0]);

		Unscrambler_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 137.369461, 273.593383, "/unscramble");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][1], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][1], -490707969);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][1], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][1]);

		Unscrambler_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 305.179687, 273.593383, "TO_UNSCRAMBLE_THE_WORD");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][2], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][2], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][2], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][2], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][2]);

		Unscrambler_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 141.369705, 285.194091, "scrambledword");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][3], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][3], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][3], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][3], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][3]);

		Unscrambler_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 137.902801, 296.924377, "YOU_HAVE");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][4], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][4], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][4], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][4], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][4], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][4]);

		Unscrambler_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 184.539016, 297.024383, "001");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][5], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][5], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][5], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][5]);

		Unscrambler_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 202.540191, 297.124389, "SECONDS_LEFT_TO_FINISh.");
		PlayerTextDrawLetterSize(playerid, Unscrambler_PTD[playerid][6], 0.206330, 1.118813);
		PlayerTextDrawAlignment(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawColor(playerid, Unscrambler_PTD[playerid][6], -2147483393);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, Unscrambler_PTD[playerid][6], 255);
		PlayerTextDrawFont(playerid, Unscrambler_PTD[playerid][6], 2);
		PlayerTextDrawSetProportional(playerid, Unscrambler_PTD[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, Unscrambler_PTD[playerid][6], 0);
		PlayerTextDrawShow(playerid, Unscrambler_PTD[playerid][6]);
	}
	else
	{
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][0]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][1]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][2]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][3]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][4]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][5]);
		PlayerTextDrawDestroy(playerid, Unscrambler_PTD[playerid][6]);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		ShowspeedVehicle(playerid, vehicleid);

		if(!VehicleInfo[vehicleid][eVehicleEngineStatus] && !IsRentalVehicle(vehicleid) && !HasNoEngine(vehicleid))
		{
			SendClientMessage(playerid, COLOR_DARKGREEN, "เครื่องยนต์ดับอยู่ /en(gine)");
			SendClientMessage(playerid,COLOR_WHITE,"ข้อแนะ: คุณสามารถออกจากรถด้วยการพิมพ์ /exitveh(icle)");
			TogglePlayerControllable(playerid, 0);
		}
	
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] == PlayerInfo[playerid][pDBID])
			SendClientMessageEx(playerid, COLOR_WHITE, "ยินดีต้อนรับสู่ %s ของคุณ", ReturnVehicleName(vehicleid));

		new oldcar = gLastCar[playerid];
		if(oldcar != 0)
		{
			if((!VehicleInfo[oldcar][eVehicleDBID] && !VehicleInfo[oldcar][eVehicleAdminSpawn]) && !IsRentalVehicle(oldcar))
			{
				if(oldcar != vehicleid)
				{
					new
						engine,
						lights,
						alarm,
						doors,
						bonnet,
						boot,
						objective;
	
					GetVehicleParamsEx(oldcar, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(oldcar, engine, lights, alarm, 0, bonnet, boot, objective);
				}
			}
		}
		gLastCar[playerid] = vehicleid;
	}
	else
	{
		PlayerTextDrawDestroy(playerid, Statsvehicle[playerid][0]);
		PlayerTextDrawDestroy(playerid, Statsvehicle[playerid][1]);
	}

	if (newstate == PLAYER_STATE_PASSENGER) {
		gPassengerCar[playerid] = GetPlayerVehicleID(playerid);
	}

	return 1;
}

forward Query_AddPlayerVehicle(playerid, playerb);
public Query_AddPlayerVehicle(playerid, playerb)
{
	PlayerInfo[playerb][pOwnedVehicles][playerInsertID[playerb]] = cache_insert_id(); 
	
	SendServerMessage(playerb, "คุณได้รับยานพาหนะจาก %s เข้าสู่สล็อตที่ %i.", ReturnName(playerid), playerInsertID[playerb]);
	SendServerMessage(playerid, "คุณ %s ออกยานพาหนะใหม่", ReturnName(playerb));
	
	playerInsertID[playerb] = 0;
	CharacterSave(playerb);
	return 1;
}

alias:engine("en")
CMD:engine(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้อยู่ในที่นั่งคนขับของยานพาหนะ"); 
		
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(HasNoEngine(vehicleid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะคันนี้ไม่มีเครื่องยนต์"); 

	if(!VehicleInfo[vehicleid][eVehicleDBID] && !VehicleInfo[vehicleid][eVehicleAdminSpawn] && !IsRentalVehicle(vehicleid) && !VehicleInfo[vehicleid][eVehicleFaction] && !VehFacInfo[vehicleid][VehFacDBID])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คำสั่งนี้สามารถใช้ได้เฉพาะยานพาหนะส่วนตัว แต่คุณอยู่ในยานพาหนะสาธารณะ (Static)");
		
	if(VehicleInfo[vehicleid][eVehicleFuel] <= 0 && !VehicleInfo[vehicleid][eVehicleAdminSpawn])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "ยานพาหนะนี้ไม่มีเชื้อเพลิง!"); 

	if(VehicleInfo[vehicleid][eVehicleEngine] < 1 && !VehFacInfo[vehicleid][VehFacFaction])
		return SendErrorMessage(playerid, "ยานพาหนะของคุณแบตตารี่หมด กรุณาไปเติมก่อน");

	if(VehicleInfo[vehicleid][eVehicleImpounded])
		return SendErrorMessage(playerid, "ยานพาหนะถูกยึด พิมพ์ /unimpound เพื่อนำรถคืน จะต้องเสียง $1,500");
	
	if(VehFacInfo[vehicleid][VehFacFaction] > 0)
	{
		if(PlayerInfo[playerid][pFaction] != VehFacInfo[vehicleid][VehFacFaction] && !PlayerInfo[playerid][pAdminDuty])
		{
			return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีกุญแจสำหรับยานพาหนะคันนี้"); 
		}
	}

	if(IsRentalVehicle(vehicleid) && !IsPlayerRentVehicle(playerid, vehicleid)) {
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่มีกุญแจสำหรับยานพาหนะคันนี้");
	}

	if(
	!VehFacInfo[vehicleid][VehFacFaction] && 
	PlayerInfo[playerid][pDuplicateKey] != vehicleid && 
	VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && 
	!VehicleInfo[vehicleid][eVehicleAdminSpawn] && 
	!IsRentalVehicle(vehicleid))
	{
		new idx, str[128];
		
		if(VehicleInfo[vehicleid][eVehicleEngineStatus] && !PlayerInfo[playerid][pAdminDuty])
			return GameTextForPlayer(playerid, "~g~ENGINE IS ALREADY ON", 3000, 3);
		
		PlayerInfo[playerid][pUnscrambling] = true;
	
		for(new i = 0; i < sizeof(UnscrambleWord); i++)
		{
			idx = random(sizeof(UnscrambleWord));
		}
		
		PlayerInfo[playerid][pUnscrambleID] = idx;
		
		switch(VehicleInfo[vehicleid][eVehicleImmobLevel])
		{
			case 1: PlayerInfo[playerid][pUnscramblerTime] = 125; 
			case 2: PlayerInfo[playerid][pUnscramblerTime] = 100; 
			case 3: PlayerInfo[playerid][pUnscramblerTime] = 75; 
			case 4: PlayerInfo[playerid][pUnscramblerTime] = 50;
			case 5: PlayerInfo[playerid][pUnscramblerTime] = 25;
		}
		
		PlayerInfo[playerid][pUnscrambleTimer] = repeat OnPlayerUnscramble(playerid);
		
		CreateUnscrambleTextdraw(playerid);

		format(str, sizeof(str), "%s", UnscrambleWord[idx]); 
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], str);
		
		format(str, sizeof(str), "%d", PlayerInfo[playerid][pUnscramblerTime]);
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], str);
	
		return 1; 
	}
	
	if(!VehicleInfo[vehicleid][eVehicleEngineStatus])
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s สตาร์ทเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
		TogglePlayerControllable(playerid, 1);
	}
	else
	{
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s ดับเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
		ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		TogglePlayerControllable(playerid, 0);
	}
	return 1;
}

alias:unscramble("uns")
CMD:unscramble(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ขับยานพาหนะ");
		
	if(!PlayerInfo[playerid][pUnscrambling])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "คุณไม่ได้ต่อสายตรงยานพาหนะ");
	
	if(isnull(params)) return SendSyntaxMessage(playerid, "/(uns)cramble [คำถอดรหัส]");
	
	if(strequal(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]], params, true))
	{ // ถ้าตอบถูก:
	
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleWord)); 
		
		new displayString[60], vehicleid = GetPlayerVehicleID(playerid);
		
		format(displayString, 60, "%s", ScrambleWord(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]]));
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		//เวลาที่เพิ่มขึ้นจะขึ้นอยู่กับเลเวลของเตือนภัย:
		PlayerInfo[playerid][pUnscramblerTime] += (7 - VehicleInfo[vehicleid][eVehicleImmobLevel]) * 2;
		PlayerInfo[playerid][pScrambleSuccess]++; 
		
		PlayerPlaySound(playerid, 1052, 0, 0, 0);
		//จะต่อสายตรงได้สำเร็จนั้น ขึ้นอยู่กับเลเวลเตือนภัย:
		if(PlayerInfo[playerid][pScrambleSuccess] >= (VehicleInfo[vehicleid][eVehicleImmobLevel] * 2) + 2)
		{
			stop PlayerInfo[playerid][pUnscrambleTimer];
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			GameTextForPlayer(playerid, "~g~ENGINE TURNED ON", 2000, 3); 
			CreateUnscrambleTextdraw(playerid, false);
			
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s สตาร์ทเครื่องยนต์ของ %s", ReturnRealName(playerid), ReturnVehicleName(vehicleid)); 
			ToggleVehicleEngine(vehicleid, true); VehicleInfo[vehicleid][eVehicleEngineStatus] = true;
		}	
	}
	else
	{
		PlayerPlaySound(playerid, 1055, 0, 0, 0); 
		
		PlayerInfo[playerid][pUnscrambleID] = random(sizeof(UnscrambleWord)); 
		
		new displayString[60];
		
		format(displayString, 60, "%s", ScrambleWord(UnscrambleWord[PlayerInfo[playerid][pUnscrambleID]]));
		PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][3], displayString); 
		
		PlayerInfo[playerid][pScrambleFailed]++; 
		PlayerInfo[playerid][pUnscramblerTime] -= random(6)+1;
		
		if(PlayerInfo[playerid][pScrambleFailed] >= 5)
		{
			stop PlayerInfo[playerid][pUnscrambleTimer];
			PlayerInfo[playerid][pScrambleSuccess] = 0; 
			PlayerInfo[playerid][pUnscrambling] = false;
			
			PlayerInfo[playerid][pUnscrambleID] = 0;
			PlayerInfo[playerid][pUnscramblerTime] = 0;
			
			PlayerInfo[playerid][pScrambleFailed] = 0;
			
			new 
				vehicleid = GetPlayerVehicleID(playerid)
			;
			
			ToggleVehicleAlarms(vehicleid, true);
			NotifyVehicleOwner(vehicleid);
			
			ClearAnimations(playerid);
			CreateUnscrambleTextdraw(playerid, false);
		}
	}
	
	return 1;
}


alias:vehicle("v")
CMD:vehicle(playerid, params[])
{
	new oneString[30], secString[90];

	if(sscanf(params, "s[30]S()[90]", oneString, secString))
	{
 	    SendClientMessage(playerid, COLOR_YELLOWEX, "___________________________________________________________");
	 	SendClientMessage(playerid, COLOR_YELLOWEX, "USAGE: /(v)ehicle [action]");
	    SendClientMessage(playerid, COLOR_YELLOWEX, "[Actions] get, park, sell,buy, upgrade, list, lock");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Actions] stats, tow, duplicatekey, find, buypark($5,000)");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Delete] scrap (ตำเตือน: หากใช้คำสั่งนี้จะทำการขายรถทิ้งในทันที.)");
        SendClientMessage(playerid, COLOR_YELLOWEX, "[Hint] หากพบบัคหรือสิ่งผิดปกติให้ทำการแจ้งผู้ดูแลในทันที");
		SendClientMessage(playerid, COLOR_YELLOWEX, "___________________________________________________________");
		return 1;
	}
	if(!strcmp(oneString, "get"))
	{
		new
			slotid
		;

		if(sscanf(secString, "d", slotid))
			return SendUsageMessage(playerid, "/vehicle get [สล็อตรถ]");

		if(slotid < 0)
			return SendErrorMessage(playerid, "ไม่มีส็อตที่ต้องการ");

		if(!PlayerInfo[playerid][pOwnedVehicles][slotid])
			return SendErrorMessage(playerid, "ไม่มีรถในสล็อตนี้");

		if(PlayerInfo[playerid][pVehicleSpawned] == true)
			return SendErrorMessage(playerid, "มีรถถูกนำออกมาแล้ว");

		new threadLoad[128];

		for(new i = 0; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][eVehicleDBID] == PlayerInfo[playerid][pOwnedVehicles][slotid])
				return SendErrorMessage(playerid, "รถถูกนำออกมาอยู่แล้ว");
		}
		//Easiest way to prevent players with faction vehicles duplicating it.

		mysql_format(dbCon, threadLoad, sizeof(threadLoad), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][slotid]);
		mysql_tquery(dbCon, threadLoad, "Query_LoadPrivateVehicle", "i", playerid);
	}
	else if(!strcmp(oneString, "park"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับรถ");

		new 
			vehicleid = GetPlayerVehicleID(playerid);
			
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]))
		{
			if(VehicleInfo[vehicleid][eVehicleImpounded])
			{
				PlayerInfo[playerid][pVehicleSpawned] = false; 
				PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;

				if(PlayerSellVehicleAccept[playerid])
				{
					new tagetid = PlayerSellVehicleBy[playerid];
					PlayerSellVehicle[tagetid] = 0;
					PlayerSellVehicleBy[tagetid] = INVALID_PLAYER_ID;
					PlayerSellVehicleID[tagetid] = INVALID_VEHICLE_ID;
					PlayerSellVehiclePrice[tagetid] = 0;
					PlayerSellVehicleAccept[tagetid] = false;
				}
				
				SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้จัดเก็บรถ %s เรียบร้อย", ReturnVehicleName(vehicleid));
				
				SaveVehicle(vehicleid);
				TogglePlayerControllable(playerid, 1);
				ResetVehicleVars(vehicleid);
				DestroyVehicle(vehicleid); 
				return 1;	
			}
			SendErrorMessage(playerid, "คุณไม่ได้อยู่ในพื้นที่จอดรถของคุณ");
			SendClientMessage(playerid, 0xFF00FFFF, "ขับไปยังจุดที่เราได้ทำการ มาร์ากไว้ดังกล่าว");
		
			SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 5.0);
			PlayerCheckpoint[playerid] = 3;

			return 1;
		}
		
		PlayerInfo[playerid][pVehicleSpawned] = false; 
		PlayerInfo[playerid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;

		if(PlayerSellVehicleAccept[playerid])
		{
			new tagetid = PlayerSellVehicleBy[playerid];
			PlayerSellVehicle[tagetid] = 0;
			PlayerSellVehicleBy[tagetid] = INVALID_PLAYER_ID;
			PlayerSellVehicleID[tagetid] = INVALID_VEHICLE_ID;
			PlayerSellVehiclePrice[tagetid] = 0;
			PlayerSellVehicleAccept[tagetid] = false;
		}
		
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้จัดเก็บรถ %s เรียบร้อย", ReturnVehicleName(vehicleid));
		
		SaveVehicle(vehicleid);
		
		ResetVehicleVars(vehicleid);
		DestroyVehicle(vehicleid); 
		TogglePlayerControllable(playerid, 1);
	}
	else if(!strcmp(oneString, "buypark"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");

		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณไม่ได้ถูกนำออกมา");

		if(PlayerInfo[playerid][pCash] < 2500)
			return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ");

		new  vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ไช่เจ้าของรถ");

		GetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2]);
		GetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleParkPos][3]); 
		
		VehicleInfo[vehicleid][eVehicleParkInterior] = GetPlayerInterior(playerid);
		VehicleInfo[vehicleid][eVehicleParkWorld] = GetPlayerVirtualWorld(playerid); 
		
		SendServerMessage(playerid, "คุณได้ซื้อพื้นที่จอดรถใหม่ในราคา $2,500.");
		GiveMoney(playerid, -2500);
		SaveVehicle(vehicleid);
	}
	else if(!strcmp(oneString, "list"))
	{
		ShowVehicleList(playerid);
	}
	else if(!strcmp(oneString, "buy"))
	{
		new id = IsPlayerNearBusiness(playerid);
		new idx = 0;
		
		if(id == 0)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านตัวแทนจำหน่ายรถ");

		if(BusinessInfo[id][BusinessType] != 2)
			return SendErrorMessage(playerid,"คุณไม่ได้อยู่ร้านขายรถ");

		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(!PlayerInfo[playerid][pOwnedVehicles][i])
			{
				idx = i;
				break;
			}
		}

		if(idx == 0)
			return SendErrorMessage(playerid,"คุณมีรถเต็มตัวแล้ว");

		
		PlayerOwnerDBID[playerid] = idx;

		ShowVehicleBuy(playerid);
		SelectTextDraw(playerid, 0xFFFFFF95);
		PlayerInfo[playerid][pGUI] = 2;
	}
	else if(!strcmp(oneString, "sell"))
	{
		/*if(PlayerSellVehicleAccept[playerid])
			return SendErrorMessage(playerid, "ตอนนี้คุณอยู่ในการตกลงกันระหว่างการซื้อขายยานพาหนะอยู่ กับ %s", ReturnName(PlayerSellVehicleBy[playerid], 0));

		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภภายในรถ");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับรถ");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณยังไม่ได้ถูกนำออกมา");

		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		new
			tagetid,
			price
		;

		if(sscanf(secString, "ud", tagetid, price))
			return SendUsageMessage(playerid, "/vehicle sell <ชื่อบางส่วน/ไอดี> <ราคา>");

		if(playerid == tagetid)
			return SendErrorMessage(playerid, "ไม่สามารถขายยานพาหนะให้ตนเองได้"); 
		
		if (!IsPlayerConnected(tagetid))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ภายในเซืฟเวอร์"); 
		
		if(!BitFlag_Get(gPlayerBitFlag[tagetid], IS_LOGGED))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");

		if(PlayerInfo[tagetid][pVehicleSpawned] == true && PlayerInfo[tagetid][pVehicleSpawnedID] != INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "ผู้เล่นฝ่ายตรงข้ามมียานพาหนะอยู่");


		if(PlayerSellVehicleAccept[tagetid] == true)
			return SendErrorMessage(playerid, "ผู้เล่นกำลังทำการซื้อขายกับคนอื่นอยู่");

		if(price > 5000000 || price < 1)
			return SendErrorMessage(playerid, "กรุณาใส่ราคาที่กำหนด <1-5,000,000>");


		PlayerSellVehicle[playerid] = playerid;
		PlayerSellVehicleBy[playerid] = tagetid;
		PlayerSellVehicleID[playerid] = vehicleid;
		PlayerSellVehiclePrice[playerid] = price;
		PlayerSellVehicleAccept[playerid] = true;

		PlayerSellVehicle[tagetid] = tagetid;
		PlayerSellVehicleBy[tagetid] = playerid;
		PlayerSellVehicleID[tagetid] = vehicleid;
		PlayerSellVehiclePrice[tagetid] = price;
		PlayerSellVehicleAccept[tagetid] = true;

		SendClientMessageEx(playerid, COLOR_YELLOWEX, "คุณได้ส่งข้อเสนอราคาให้กับ %s ในการขายยานพนะ %s ในราคา $%s",ReturnName(tagetid, 0), ReturnVehicleName(vehicleid), MoneyFormat(price));
		SendClientMessageEx(tagetid, COLOR_YELLOWEX, "คุณได้รับข้อเสนอราคาจาก %s ในการขายยานพนะ %s ในราคา $%s พิมพ์ /v accept เพื่อยืนยันข้อเสนอ",ReturnName(playerid, 0), ReturnVehicleName(vehicleid), MoneyFormat(price));
		*/
		SendClientMessage(playerid, COLOR_LIGHTRED, "ขออถัยในความไม่สดวกเนื่องจากเราพบบัคในการขายรถอยู่เราขออนุญาตทำการปิดคำสั่งนี้ชั่วคราวก่อน");
		return 1;
	}
	else if(!strcmp(oneString, "accept"))
	{
		new 
			tagetid = PlayerSellVehicleBy[playerid],
			vehicleid = PlayerSellVehicleID[playerid],
			price = PlayerSellVehiclePrice[playerid]
		;

		if(!PlayerSellVehicleAccept[playerid] && playerid != tagetid)
			return SendErrorMessage(playerid, "ไม่มีใครมาทำการซื้อขายยานพาหนะกับคุณตอนนี้");
		
		if(PlayerInfo[playerid][pVehicleSpawned] == true || PlayerInfo[playerid][pVehicleSpawnedID])
		{
			return SendErrorMessage(playerid, "ยานพาหนะของคุณไปเก็บยังจุด park ก่อนที่จะทำการซื้อขายยานพาหนะ");
		}

		if(PlayerInfo[tagetid][pVehicleSpawned] == false || PlayerInfo[tagetid][pVehicleSpawnedID] == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "ผู้เล่นได้ทำการเก็บยานพาหนะไปแล้ว");

		if(PlayerInfo[playerid][pCash] < price)
			return SendErrorMessage(playerid, "คุณมีเงินไม่เพียงพอ (ขาดอีก %s)", MoneyFormat(price));
		
		new idx = 0;
		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(!PlayerInfo[playerid][pOwnedVehicles][i])
			{
				idx = i;
				break;
			}
		}

		if(idx == 0)
		{
			PlayerSellVehicle[playerid] = 0;
			PlayerSellVehicleBy[playerid] = INVALID_PLAYER_ID;
			PlayerSellVehicleID[playerid] = INVALID_VEHICLE_ID;
			PlayerSellVehiclePrice[playerid] = 0;
			PlayerSellVehicleAccept[playerid] = false;

			PlayerSellVehicle[tagetid] = 0;
			PlayerSellVehicleBy[tagetid] = INVALID_PLAYER_ID;
			PlayerSellVehicleID[tagetid] = INVALID_VEHICLE_ID;
			PlayerSellVehiclePrice[tagetid] = 0;
			PlayerSellVehicleAccept[tagetid] = false;

			return SendErrorMessage(playerid,"คุณมีรถเต็มตัวแล้ว");
		}

		
		PlayerOwnerDBID[playerid] = idx;

		//new sql_chang[500];

		new dbid = VehicleInfo[vehicleid][eVehicleDBID];

		for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
		{
			if(PlayerInfo[tagetid][pOwnedVehicles][i] == dbid)
			{
				PlayerInfo[tagetid][pOwnedVehicles][i] = 0;
			}
		}

		PlayerInfo[playerid][pOwnedVehicles][idx] = dbid;
		VehicleInfo[vehicleid][eVehicleOwnerDBID] = PlayerInfo[playerid][pDBID];
		PlayerInfo[playerid][pVehicleSpawned] = true; 
		PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid;

		GiveMoney(playerid, -price);
		GiveMoney(tagetid, price);
		SendClientMessageEx(playerid, COLOR_GREEN, "ทำการซื้อขายยานพาหนะสำเร็จ คุณจ่ายเงินไปจำนวน %s", MoneyFormat(price));
		SendClientMessageEx(tagetid, COLOR_GREEN, "ทำการซื้อขายยานพาหนะสำเร็จ คุณได้รับเงินจำนวน %s", MoneyFormat(price));
		SaveVehicle(vehicleid);
		CharacterSave(playerid);

		PlayerSellVehicle[tagetid] = 0;
		PlayerSellVehicleBy[tagetid] = INVALID_PLAYER_ID;
		PlayerSellVehicleID[tagetid] = INVALID_VEHICLE_ID;
		PlayerSellVehiclePrice[tagetid] = 0;
		PlayerSellVehicleAccept[tagetid] = false;
		PlayerInfo[tagetid][pVehicleSpawned] = false; 
		PlayerInfo[tagetid][pVehicleSpawnedID] = INVALID_VEHICLE_ID;

		PlayerSellVehicle[playerid] = 0;
		PlayerSellVehicleBy[playerid] = INVALID_PLAYER_ID;
		PlayerSellVehicleID[playerid] = INVALID_VEHICLE_ID;
		PlayerSellVehiclePrice[playerid] = 0;
		PlayerSellVehicleAccept[playerid] = false;

		CharacterSave(tagetid);
		return 1;
	}
	else if(!strcmp(oneString, "Denied"))
	{	
		if(!PlayerSellVehicleAccept[playerid])
			return SendErrorMessage(playerid, "ไม่มีใครมาทำการซื้อขายยานพาหนะกับคุณตอนนี้");


		new 
			tagetid = PlayerSellVehicleBy[playerid]
		;

		SendClientMessageEx(tagetid, COLOR_LIGHTRED, "%s :ได้ปฎิเสทข้อเสนอของคุณ",ReturnName(playerid, 0));
		SendClientMessageEx(playerid, COLOR_GREY, "คุณได้ปฎิเสทข้อเสนอของ %s",ReturnName(tagetid, 0));

		PlayerSellVehicle[tagetid] = 0;
		PlayerSellVehicleBy[tagetid] = INVALID_PLAYER_ID;
		PlayerSellVehicleID[tagetid] = INVALID_VEHICLE_ID;
		PlayerSellVehiclePrice[tagetid] = 0;
		PlayerSellVehicleAccept[tagetid] = false;

		PlayerSellVehicle[playerid] = 0;
		PlayerSellVehicleBy[playerid] = INVALID_PLAYER_ID;
		PlayerSellVehicleID[playerid] = INVALID_VEHICLE_ID;
		PlayerSellVehiclePrice[playerid] = 0;
		PlayerSellVehicleAccept[playerid] = false;

		return 1;
	}
	else if(!strcmp(oneString, "duplicatekey"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");

		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณไม่ได้ถูกนำออกมา");

		new 
			playerb, vehicleid = GetPlayerVehicleID(playerid);

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		if(sscanf(secString, "u", playerb))
			return SendUsageMessage(playerid, "/vehicle duplicatekey [ชื่อบางส่วน/ไอดี]");

		if(playerb == playerid)return SendErrorMessage(playerid, "คุณไม่สามารถให้กุญแจสำรองกับตัวเองได้");

		if(!IsPlayerConnected(playerb))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้เชื่อมต่อกับเซืฟเวอร์");

		if(!BitFlag_Get(gPlayerBitFlag[playerb], IS_LOGGED))
			return SendErrorMessage(playerid, "ผู้เล่นกำลังเข้าสู่ระบบ");
		
		if(!IsPlayerNearPlayer(playerid, playerb, 5.0))
			return SendErrorMessage(playerid, "ผู้เล่นไม่ได้อยู่ใกล้คุณ");

		SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "* %s ได้ให้ชุดกุญแจสำรองกับ %s", ReturnName(playerid, 0), ReturnName(playerb, 0));
		SendServerMessage(playerb, "%s ได้ให้ชุดกุญแจสำรองกับคุณ", ReturnName(playerid, 0));
		
		GiveMoney(playerid, -500);
		SendServerMessage(playerid, "คุณได้ให้ชุดกุญแจสำรองกับ %s  และเสียเงิน $500", ReturnName(playerb, 0));
		PlayerInfo[playerb][pDuplicateKey] = vehicleid;
	}
	else if(!strcmp(oneString, "scrap"))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภภายในรถ");
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับรถ");
			
		if(PlayerInfo[playerid][pVehicleSpawned] == false) return SendErrorMessage(playerid, "รถของคุณยังไม่ได้ถูกนำออกมา");

		new 
			str[160], 
			vehicleid = GetPlayerVehicleID(playerid)
		;

		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");

		PlayerVehicleScrap[playerid] = vehicleid;

		format(str, sizeof(str), "คุณมั่นใจใช่ไหมที่จะขายรถของคุณทิ้ง ถ้าคุณขายรถของคุณคุณจะได้รับเงิน $%s ซึ่งเป็นเงินหาร 2 ของราคาเต็มของรถ\nแล้วโปรดจงจำไว้ว่ารถของคุณจะไม่สามารถนำกลับมาได้อีกได้อีก",MoneyFormat(VehicleInfo[vehicleid][eVehiclePrice] / 2));
		Dialog_Show(playerid, DIALOG_VEH_SELL, DIALOG_STYLE_MSGBOX, "คุณแน่ในใช่ไหม?", str, "ยืนยัน", "ยกเลิก");
	}
	else if(!strcmp(oneString, "tow"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "คุณไม่ได้นำรถออกมา");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "รถคันนี้ยังเคลื่อนที่อยู่");

		if(playerTowingVehicle[playerid])
			return SendErrorMessage(playerid, "คุณกำลังส่งรถกลับอยู่....");

		VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay] = 
			Create3DTextLabel("(( | ))\nTOWING VEHICLE", COLOR_DARKGREEN, 0.0, 0.0, 0.0, 25.0, 0, 1);
		
		Attach3DTextLabelToVehicle(VehicleInfo[PlayerInfo[playerid][pVehicleSpawnedID]][eVehicleTowDisplay], PlayerInfo[playerid][pVehicleSpawnedID], -0.0, -0.0, -0.0);

		playerTowingVehicle[playerid] = true;
		playerTowTimer[playerid] = SetTimerEx("OnVehicleTow", 5000, true, "i", playerid);
		
		SendServerMessage(playerid, "คุณได้ส่งคำขอให้ประกันนำรถ %s มาไว้ที่จุดเกิดแล้ว", ReturnVehicleName(PlayerInfo[playerid][pVehicleSpawnedID]));
	}
	else if(!strcmp(oneString, "find"))
	{
		if(PlayerInfo[playerid][pVehicleSpawned] == false) 
			return SendErrorMessage(playerid, "คุณไม่ได้นำรถออกมา");
			
		if(IsVehicleOccupied(PlayerInfo[playerid][pVehicleSpawnedID]))
			return SendErrorMessage(playerid, "รถของคุณยังมีการเคลื่อนที่อยู่");
			
		new 
			Float:fetchPos[3];
		
		GetVehiclePos(PlayerInfo[playerid][pVehicleSpawnedID], fetchPos[0], fetchPos[1], fetchPos[2]);
		SetPlayerCheckpoint(playerid, fetchPos[0], fetchPos[1], fetchPos[2], 3.0);
	}
	else if(!strcmp(oneString, "stats"))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		
		if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && !PlayerInfo[playerid][pAdmin])
			return SendErrorMessage(playerid, "คุณไม่ใช่เจ้าของรถ");
		
		if(PlayerInfo[playerid][pAdmin])
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "เจ้าของรถ: %s", ReturnDBIDName(VehicleInfo[vehicleid][eVehicleOwnerDBID]));
			SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle DBID: %d",VehicleInfo[vehicleid][eVehicleDBID]);
		}
		SendClientMessageEx(playerid, COLOR_WHITE, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%i]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Security: Lock Level[%i], Alarm Level[%i], Immobilizer[%i]", VehicleInfo[vehicleid][eVehicleLockLevel], VehicleInfo[vehicleid][eVehicleAlarmLevel], VehicleInfo[vehicleid][eVehicleImmobLevel]);
		SendClientMessageEx(playerid, COLOR_WHITE, "Misc: Primary Color[%d], Secondary Color[%d], License Plate[%s]",VehicleInfo[vehicleid][eVehicleColor1],VehicleInfo[vehicleid][eVehicleColor2], VehicleInfo[vehicleid][eVehiclePlates]);
	}
	else if(!strcmp(oneString, "lock"))
	{
		new bool:foundCar = false, vehicleid, Float:fetchPos[3];
		
		for (new i = 0; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, fetchPos[0], fetchPos[1], fetchPos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 4.0, fetchPos[0], fetchPos[1], fetchPos[2]))
			{
				foundCar = true;
				vehicleid = i; 
				break; 
			}
		}
		if(foundCar == true)
		{
			if(VehicleInfo[vehicleid][eVehicleOwnerDBID] != PlayerInfo[playerid][pDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid && RentCarKey[playerid] != vehicleid && !PlayerInfo[playerid][pAdmin])
				return SendErrorMessage(playerid, "คุณไม่มีกุญแจสำหรับรถคันนี้"); 
				
			new statusString[90]; 
			new engine, lights, alarm, doors, bonnet, boot, objective; 
	
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
			if(VehicleInfo[vehicleid][eVehicleLocked])
			{
				format(statusString, sizeof(statusString), "~g~%s UNLOCKED", ReturnVehicleName(vehicleid));
			
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = false;
			}
			else 
			{
				format(statusString, sizeof(statusString), "~r~%s LOCKED", ReturnVehicleName(vehicleid));
				
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
				VehicleInfo[vehicleid][eVehicleLocked] = true;
			}
			GameTextForPlayer(playerid, statusString, 3000, 3);
		}
	}
	return 1;
}

CMD:lights(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
		
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "คุณไม่ได้อยู่ภายในรถ");
			
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
		
	if(VehicleInfo[vehicleid][eVehicleLights] == false)
	{
		ToggleVehicleLights(vehicleid, true);
	}		
	else ToggleVehicleLights(vehicleid, false);

	return 1;
}

CMD:trunk(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z
	;
		
	new engine, lights, alarm, doors, bonnet, boot, objective;
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleBoot(GetNearestVehicle(playerid), x, y, z); 
			
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
		new str[MAX_STRING];
				
		if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงท้ายรถ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ทำการเปิดฝากระโปรงท้ายรถ");
			SendClientMessage(playerid, COLOR_WHITE, "สามารถพิมพ์ /check หรือ /place ได้");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{

			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ปิดฝากระโปรงท้ายรถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
		new str[MAX_STRING];
			
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
			
		if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
			return SendErrorMessage(playerid, "คุณไม่ได้มีกุญแจ"); 
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!boot)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 1, objective);
				
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ทำการเปิดฝากระโปรงท้ายรถ");
			SendClientMessage(playerid, COLOR_WHITE, "สามารถพิมพ์ /check หรือ /place ได้"); 

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, 0, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้ปิดฝากระโปรงท้ายรถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงรถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else SendErrorMessage(playerid, "คุณได้อยู่ใกล้/ในรถ ของคุณ");
	return 1;
}

CMD:hood(playerid, params[])
{
	new
		Float:x,
		Float:y,
		Float:z
	;

	new str[MAX_STRING];
		
	new engine, lights, alarm, doors, bonnet, boot, objective;
	
	if(!IsPlayerInAnyVehicle(playerid) && GetNearestVehicle(playerid) != INVALID_VEHICLE_ID)
	{
		GetVehicleHood(GetNearestVehicle(playerid), x, y, z); 
			
		new 
			vehicleid = GetNearestVehicle(playerid)
		;
				
		if(VehicleInfo[vehicleid][eVehicleLocked])
			return SendServerMessage(playerid, "รถคันนี้ถูกล็อคอยู่"); 
			
		if(!IsPlayerInRangeOfPoint(playerid, 2.5, x, y, z))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้ฝากระโปรงหน้ารถ");
			
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else if(IsPlayerInAnyVehicle(playerid))
	{
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
			
		if(PlayerInfo[playerid][pDBID] != VehicleInfo[vehicleid][eVehicleOwnerDBID] && PlayerInfo[playerid][pDuplicateKey] != vehicleid)
			return SendErrorMessage(playerid, "คุณไม่มีกุญแจรถ"); 
				
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "คุณไม่ได้เป็นคนขับ");
				
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			
		if(!bonnet)
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 1, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้เปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, 0, boot, objective);
			SendClientMessage(playerid, COLOR_YELLOWEX, "คุณได้เปิดฝากระโปรงหน้ารถ");

			format(str, sizeof(str), "* %s ได้ปิดฝากระโปรงหน้ารถ %s", ReturnRealName(playerid, 0),ReturnVehicleName(vehicleid)); 
						
			SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
			SendClientMessage(playerid, COLOR_EMOTE, str);
		}
	}
	else return SendServerMessage(playerid, "คุณไม่ได้อยู่ใกล้รถ");
	return 1;
}

alias:rollwindow("rw")
CMD:rollwindow(playerid, params[])
{
	if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, "คุณต้องอยู่ในพาหนะเพื่อใช้สิ่งนี้ !");

	new vehicleid = GetPlayerVehicleID(playerid);
	if (!IsDoorVehicle(vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, "พาหนะนี้ไม่มีหน้าต่าง");

	new item[16];

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	  	if(sscanf(params, "s[32]", item)) {
	  	    SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ]"EMBED_WHITE" TIP: เมื่อเป็นคนขับ คุณสามารถระบุหน้าต่างที่จะเปิดได้");
			SendClientMessage(playerid, COLOR_LIGHTRED, "การใช้: "EMBED_WHITE"/rollwindow [all/frontleft(fl)/frontright(fr)/rearleft(rl)/rearright(rr)]");
		}
		else
		{
			new wdriver, wpassenger, wbackleft, wbackright;
			GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

			if(strcmp(item, "all", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
		    		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 0, 0, 0, 0);
				}
			}
			if(strcmp(item, "frontleft", true) == 0 || strcmp(item, "fl", true) == 0)
			{
			    if(wdriver == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 1, wpassenger, wbackleft, wbackright);
				}
				else if(wdriver == VEHICLE_PARAMS_ON || wdriver == VEHICLE_PARAMS_UNSET)
				{
		    		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, 0, wpassenger, wbackleft, wbackright);
				}
			}
			if(strcmp(item, "frontright", true) == 0 || strcmp(item, "fr", true) == 0)
			{
			    if(wpassenger == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
				}
				else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
				}
			}
			if(strcmp(item, "rearleft", true) == 0 || strcmp(item, "rl", true) == 0)
			{
	      		if(wbackleft == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
				}
				else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
				}
			}
			if(strcmp(item, "rearright", true) == 0 || strcmp(item, "rr", true) == 0)
			{
			    if(wbackright == VEHICLE_PARAMS_OFF)
			    {
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
				}
				else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
				{
					SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
					SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
				}
			}
		}
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		new iSeat = GetPlayerVehicleSeat(playerid);
		new wdriver, wpassenger, wbackleft, wbackright;
		GetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, wbackright);

		if(iSeat == 128) return SendClientMessage(playerid, COLOR_LIGHTRED, "เกิดข้อผิดพลาดเกี่ยวกับหมายเลขที่นั่ง");

		if(iSeat == 1)
		{
			if(wpassenger == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 1, wbackleft, wbackright);
			}
			else if(wpassenger == VEHICLE_PARAMS_ON || wpassenger == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, 0, wbackleft, wbackright);
			}
		}
		else if(iSeat == 2)
		{
			if(wbackleft == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 1, wbackright);
			}
			else if(wbackleft == VEHICLE_PARAMS_ON || wbackleft == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, 0, wbackright);
			}
		}
		else if(iSeat == 3)
		{
			if(wbackright == VEHICLE_PARAMS_OFF)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาขึ้น", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 1);
			}
			else if(wbackright == VEHICLE_PARAMS_ON || wbackright == VEHICLE_PARAMS_UNSET)
			{
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "> %s เลื่อนหน้าต่างของเขาลง", ReturnRealName(playerid));
				SetVehicleParamsCarWindows(vehicleid, wdriver, wpassenger, wbackleft, 0);
			}
		}
	}
	return 1;
}

stock ShowVehicleList(playerid)
{
	new thread[MAX_STRING];

	SendClientMessageEx(playerid, COLOR_DARKGREEN, "_________________Your vehicles(%i)_________________", CountPlayerVehicles(playerid));

	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			mysql_format(dbCon, thread, sizeof(thread), "SELECT * FROM vehicles WHERE VehicleDBID = %i", PlayerInfo[playerid][pOwnedVehicles][i]);
			mysql_tquery(dbCon, thread, "Query_ShowVehicleList", "ii", playerid, i);
		}
	}

	return 1;
}

stock CountPlayerVehicles(playerid)
{
	new
		count = 0
	;
	
	for(new i = 1; i < 6; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i])
		{
			count++;
		}
	}
	return count;
}

forward Query_ShowVehicleList(playerid, idx);
public Query_ShowVehicleList(playerid, idx)
{
	new rows; cache_get_row_count(rows);

	new
		vehicleDBID,
		vehicleModel,
		vehicleLockLevel,
		vehicleAlarmLevel,
		vehicleImmobLevel,
		vehicleTimesDestroyed,
		vehiclePlates[32],
		bool:isSpawned = false,
		color
	;

	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name_int(0,"VehicleDBID",vehicleDBID);
		cache_get_value_name_int(0,"VehicleModel",vehicleModel);

		cache_get_value_name_int(0,"VehicleLockLevel",vehicleLockLevel);
		cache_get_value_name_int(0,"VehicleAlarmLevel",vehicleAlarmLevel);
		cache_get_value_name_int(0,"VehicleImmobLevel",vehicleImmobLevel);

		cache_get_value_name_int(0,"VehicleTimesDestroyed",vehicleTimesDestroyed);

		cache_get_value_name(0,"VehiclePlates",vehiclePlates,32);
	}

	for(new id = 0; id < MAX_VEHICLES; id++)
	{
		if(VehicleInfo[id][eVehicleDBID] == vehicleDBID)
		{
			isSpawned = true;
		}
	}

	if(isSpawned)
		color = COLOR_DARKGREEN;

	else color = COLOR_WHITE;

	SendClientMessageEx(playerid, color, "Vehicle %i: %s, Lock[%i], Alarm[%i], Immobiliser[%i], Times destroyed[%i], Plates[%s]", idx, ReturnVehicleModelName(vehicleModel), vehicleLockLevel, vehicleAlarmLevel, vehicleImmobLevel, vehicleTimesDestroyed, vehiclePlates);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(HasNoEngine(vehicleid))
		ToggleVehicleEngine(vehicleid, true);
	
	SetVehicleHp(vehicleid);

	return 1;
}

stock SetVehicleHp(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	SetVehicleHealth(vehicleid, VehicleData[modelid - 400][c_maxhp]);

	if(modelid == 463)
	{
		SetVehicleHealth(vehicleid, 700);
	}
	if(modelid == 448)
	{
		SetVehicleHealth(vehicleid, 700);
	}
	return 1;
}

timer OnPlayerUnscramble[1000](playerid)
{	
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		stop PlayerInfo[playerid][pUnscrambleTimer];
		
		CreateUnscrambleTextdraw(playerid, false);
		return 1;
	}
	
	PlayerInfo[playerid][pUnscramblerTime]--;
	
	new timerString[20];
	
	format(timerString, 20, "%d", PlayerInfo[playerid][pUnscramblerTime]);
	PlayerTextDrawSetString(playerid, Unscrambler_PTD[playerid][5], timerString);
	
	if(PlayerInfo[playerid][pUnscramblerTime] < 1)
	{
		PlayerInfo[playerid][pUnscrambling] = false;
		PlayerInfo[playerid][pUnscramblerTime] = 0;
		PlayerInfo[playerid][pUnscrambleID] = 0;
		
		PlayerInfo[playerid][pScrambleSuccess] = 0; 
		PlayerInfo[playerid][pScrambleFailed] = 0; 
		stop PlayerInfo[playerid][pUnscrambleTimer]; 
		
		CreateUnscrambleTextdraw(playerid, false);
		
		new 
			vehicleid = GetPlayerVehicleID(playerid)
		;
			
		ToggleVehicleAlarms(vehicleid, true);
		NotifyVehicleOwner(vehicleid);
		
		ClearAnimations(playerid);
	}
	return 1;
}

timer OnVehicleAlarm[5000](vehicleid)
{
	return ToggleVehicleAlarms(vehicleid, false);
}

stock NotifyVehicleOwner(vehicleid)
{
	new playerid = INVALID_PLAYER_ID;

	foreach(new i : Player)
	{
		if(PlayerInfo[i][pDBID] == VehicleInfo[vehicleid][eVehicleOwnerDBID])
		{
			return SendClientMessage(playerid, COLOR_YELLOW2, "SMS: สัญญาณเตือนภัยยานพาหนะของคุณดังขึ้น, ผู้ส่ง: สัญญาณเตือนภัยของยานพาหนะ (ไม่ทราบ)");
		}
	}
	return 0;
}


forward LoadFactionVehicle();
public LoadFactionVehicle()
{
	if(!cache_num_rows())
		return print("[SERVER]: No Vehicle Faction In Database");

	new rows; cache_get_row_count(rows);
	new vehicleid = INVALID_VEHICLE_ID, amout_veh;

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2;

	for (new i = 0; i < rows && i < MAX_FACTION_VEHICLE; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			-1,
			0);

		if(vehicleid != INVALID_VEHICLE_ID)
		{
			//VehicleInfo[vehicleid][eVehicleExists] = true; 

			cache_get_value_name_int(i, "VehicleDBID",VehFacInfo[vehicleid][VehFacDBID]);

			cache_get_value_name_int(i, "VehicleFaction",VehFacInfo[vehicleid][VehFacFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehFacInfo[vehicleid][VehFacModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehFacInfo[vehicleid][VehFacColor][0]);
			cache_get_value_name_int(i, "VehicleColor2",VehFacInfo[vehicleid][VehFacColor][1]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehFacInfo[vehicleid][VehFacPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehFacInfo[vehicleid][VehFacPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehFacInfo[vehicleid][VehFacPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehFacInfo[vehicleid][VehFacPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkWorld",VehFacInfo[vehicleid][VehFacPosWorld]);

			VehicleInfo[vehicleid][eVehicleFuel] = 100;
		}

		SetVehicleNumberPlate(vehicleid, FactionInfo[VehFacInfo[vehicleid][VehFacFaction]][eFactionAbbrev]);
		SetVehicleToRespawn(vehicleid);
		SetVehicleHp(vehicleid);
		amout_veh++;
	}

	printf("[SERVER]: %d Vehicle Faction In Database...", amout_veh);
	return 1;
}


forward Query_LoadPrivateVehicle(playerid);
public Query_LoadPrivateVehicle(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "ไม่มีรถอยู่ในสล็อตนี้"); 
		
	new rows; cache_get_row_count(rows); 
	new str[MAX_STRING], vehicleid = INVALID_VEHICLE_ID; 

	new VehicleModel,Float:VehicleParkPos[4],VehicleColor1,VehicleColor2;
	
	for (new i = 0; i < rows && i < MAX_VEHICLES; i++)
	{
		cache_get_value_name_int(i, "VehicleModel", VehicleModel);
		cache_get_value_name_float(i, "VehicleParkPosX", VehicleParkPos[0]);
		cache_get_value_name_float(i, "VehicleParkPosY", VehicleParkPos[1]);
		cache_get_value_name_float(i, "VehicleParkPosZ", VehicleParkPos[2]);
		cache_get_value_name_float(i, "VehicleParkPosA", VehicleParkPos[3]);
		cache_get_value_name_int(i, "VehicleColor1", VehicleColor1);
		cache_get_value_name_int(i, "VehicleColor2", VehicleColor2);

		vehicleid = CreateVehicle(VehicleModel, 
			VehicleParkPos[0],
			VehicleParkPos[1],
			VehicleParkPos[2],
			VehicleParkPos[3],
			VehicleColor1,
			VehicleColor2,
			-1,
			0);
			
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			VehicleInfo[vehicleid][eVehicleExists] = true; 
			cache_get_value_name_int(i, "VehicleDBID",VehicleInfo[vehicleid][eVehicleDBID]);

			cache_get_value_name_int(i, "VehicleOwnerDBID",VehicleInfo[vehicleid][eVehicleOwnerDBID]);
			cache_get_value_name_int(i, "VehicleFaction",VehicleInfo[vehicleid][eVehicleFaction]);
			
			cache_get_value_name_int(i, "VehicleModel",VehicleInfo[vehicleid][eVehicleModel]);
			
			cache_get_value_name_int(i, "VehicleColor1",VehicleInfo[vehicleid][eVehicleColor1]);
			cache_get_value_name_int(i, "VehicleColor2",VehicleInfo[vehicleid][eVehicleColor2]);
			
			cache_get_value_name_float(i, "VehicleParkPosX", VehicleInfo[vehicleid][eVehicleParkPos][0]);
			cache_get_value_name_float(i, "VehicleParkPosY", VehicleInfo[vehicleid][eVehicleParkPos][1]);
			cache_get_value_name_float(i, "VehicleParkPosZ", VehicleInfo[vehicleid][eVehicleParkPos][2]);
			cache_get_value_name_float(i, "VehicleParkPosA", VehicleInfo[vehicleid][eVehicleParkPos][3]);
			
			cache_get_value_name_int(i, "VehicleParkInterior",VehicleInfo[vehicleid][eVehicleParkInterior]);
			cache_get_value_name_int(i, "VehicleParkWorld",VehicleInfo[vehicleid][eVehicleParkWorld]);
			

			cache_get_value_name(i, "VehiclePlates",VehicleInfo[vehicleid][eVehiclePlates], 32);
			cache_get_value_name_int(i, "VehicleLocked",VehicleInfo[vehicleid][eVehicleLocked]);
			
			cache_get_value_name_int(i, "VehicleImpounded",VehicleInfo[vehicleid][eVehicleImpounded]);
			
			cache_get_value_name_float(i, "VehicleImpoundPosX", VehicleInfo[vehicleid][eVehicleImpoundPos][0]);
			cache_get_value_name_float(i, "VehicleImpoundPosY", VehicleInfo[vehicleid][eVehicleImpoundPos][1]);
			cache_get_value_name_float(i, "VehicleImpoundPosZ", VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
			cache_get_value_name_float(i, "VehicleImpoundPosA", VehicleInfo[vehicleid][eVehicleImpoundPos][3]);
			
			cache_get_value_name_int(i, "VehicleFuel",VehicleInfo[vehicleid][eVehicleFuel]);
			
			cache_get_value_name_int(i, "VehicleXMR",VehicleInfo[vehicleid][eVehicleHasXMR]);
			cache_get_value_name_int(i, "VehicleTimesDestroyed",VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
			
			cache_get_value_name_float(i, "VehicleEngine",VehicleInfo[vehicleid][eVehicleEngine]);
			cache_get_value_name_float(i, "VehicleBattery",VehicleInfo[vehicleid][eVehicleBattery]);
			
			cache_get_value_name_int(i, "VehicleAlarmLevel",VehicleInfo[vehicleid][eVehicleAlarmLevel]);
			cache_get_value_name_int(i, "VehicleLockLevel",VehicleInfo[vehicleid][eVehicleLockLevel]);
			cache_get_value_name_int(i, "VehicleImmobLevel",VehicleInfo[vehicleid][eVehicleImmobLevel]);
			
			
			cache_get_value_name_int(i, "VehiclePaintjob",VehicleInfo[vehicleid][eVehiclePaintjob]);

			cache_get_value_name_int(i, "VehiclePrice",VehicleInfo[vehicleid][eVehiclePrice]);


			cache_get_value_name_int(i, "VehicleComp",VehicleInfo[vehicleid][eVehicleComp]);

			/*for(new j = 1; j < 15; j++)
			{
				format(str, sizeof(str), "VehicleMod%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleMod][j]);
			}*/
			
			for(new j = 1; j < 6; j++)
			{
				format(str, sizeof(str), "VehicleWeapons%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeapons][j]);
				
				format(str, sizeof(str), "VehicleWeaponsAmmo%d", j);
				cache_get_value_name_int(i, str,VehicleInfo[vehicleid][eVehicleWeaponsAmmo][j]);
			}
			
			
			if(VehicleInfo[vehicleid][eVehicleParkInterior] != 0)
			{
				LinkVehicleToInterior(vehicleid, VehicleInfo[vehicleid][eVehicleParkInterior]); 
				SetVehicleVirtualWorld(vehicleid, VehicleInfo[vehicleid][eVehicleParkWorld]);
			}
			
			if(!isnull(VehicleInfo[vehicleid][eVehiclePlates]))
			{
				SetVehicleNumberPlate(vehicleid, VehicleInfo[vehicleid][eVehiclePlates]);
				SetVehicleToRespawn(vehicleid); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleImpounded] == true)
			{
				SetVehiclePos(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2]);
				SetVehicleZAngle(vehicleid, VehicleInfo[vehicleid][eVehicleImpoundPos][3]); 
			}
			
			if(VehicleInfo[vehicleid][eVehicleLocked] == false)
				SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
				
			else SetVehicleParamsEx(vehicleid, 0, 0, 0, 1, 0, 0, 0);
			
			VehicleInfo[vehicleid][eVehicleAdminSpawn] = false;
			
			
			SetVehicleToRespawn(vehicleid); 
			SetVehicleHp(vehicleid);
			
			if(HasNoEngine(playerid))
				ToggleVehicleEngine(vehicleid, true); 

		}
	}
	
	PlayerInfo[playerid][pVehicleSpawned] = true;
	PlayerInfo[playerid][pVehicleSpawnedID] = vehicleid;
	
	SendClientMessageEx(playerid, COLOR_DARKGREEN, "คุณได้นำรถ %s ออกมาแล้ว", ReturnVehicleName(vehicleid));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lifespan: Engine Life[%.2f], Battery Life[%.2f], Times Destroyed[%d]", VehicleInfo[vehicleid][eVehicleEngine], VehicleInfo[vehicleid][eVehicleBattery], VehicleInfo[vehicleid][eVehicleTimesDestroyed]);
	if(VehicleInfo[vehicleid][eVehicleImpounded]) 
	{
		SendClientMessage(playerid, COLOR_RED, "รถของคุณถูกยึด");
		SendClientMessage(playerid, 0xFF00FFFF, "Hint: ไปตามจุดที่เราได้มาร์กไว้เพื่อไปที่รถ");
		SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleImpoundPos][0], VehicleInfo[vehicleid][eVehicleImpoundPos][1], VehicleInfo[vehicleid][eVehicleImpoundPos][2], 3.0);
	}
	else
	{
		SendClientMessage(playerid, 0xFF00FFFF, "Hint: ไปตามจุดที่เราได้มาร์กไว้เพื่อไปที่รถ");
		SetPlayerCheckpoint(playerid, VehicleInfo[vehicleid][eVehicleParkPos][0], VehicleInfo[vehicleid][eVehicleParkPos][1], VehicleInfo[vehicleid][eVehicleParkPos][2], 3.0);
	}
	PlayerCheckpoint[playerid] = 1; 
	return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
	if(PlayerCheckpoint[playerid] == 1)
	{
		GameTextForPlayer(playerid, "~p~You have found it!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
	}
	if(PlayerCheckpoint[playerid] == 3)
	{
		GameTextForPlayer(playerid, "~p~This is park vehicle!", 3000, 3);
		PlayerCheckpoint[playerid] = 0; DisablePlayerCheckpoint(playerid);
	}
	return 1;
}


Dialog:DIALOG_VEHICLE_WEAPONS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicleid = INVALID_VEHICLE_ID, str[128];
				
		if(!IsPlayerInAnyVehicle(playerid))
			vehicleid = GetNearestVehicle(playerid);
					
		else
		vehicleid = GetPlayerVehicleID(playerid);
					
		if(vehicleid == INVALID_VEHICLE_ID)
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่ใกล้รถ"); 
					
		if(!VehicleInfo[vehicleid][eVehicleWeapons][listitem+1])
			return SendErrorMessage(playerid, "");
				
		GivePlayerGun(playerid, VehicleInfo[vehicleid][eVehicleWeapons][listitem+1], VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1]); 
				
		format(str, sizeof(str), "* %s หยิบ %s ออกมาจากรถ %s", ReturnName(playerid, 0), ReturnWeaponName(VehicleInfo[vehicleid][eVehicleWeapons][listitem+1]), 
		ReturnVehicleName(vehicleid)); 
					
		SetPlayerChatBubble(playerid, str, COLOR_EMOTE, 20.0, 4500); 
		SendClientMessage(playerid, COLOR_EMOTE, str);
				
		VehicleInfo[vehicleid][eVehicleWeapons][listitem+1] = 0; 
		VehicleInfo[vehicleid][eVehicleWeaponsAmmo][listitem+1] = 0; 
				
		SaveVehicle(vehicleid); CharacterSave(playerid);
		return 1;
	}
	return 1;
}

Dialog:DIALOG_VEH_SELL(playerid, response, listitem, inputtext[])
{
	if(!response)
		return SendServerMessage(playerid,"คุณยกเลิกการขายรถของคุณแล้ว");

	if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถแล้วในตอนนี้ทำให้ยกเลิกในการขายยานพาหนะในตอนนี้ทันที");
	
	new vehicleid = PlayerVehicleScrap[playerid];
	new id = IsPlayerNearBusiness(playerid);
	new dbid = VehicleInfo[vehicleid][eVehicleDBID];
	new cash_back = VehicleInfo[vehicleid][eVehiclePrice] / 2;

	if(!id)
		return SendErrorMessage(playerid,"คุณไม่ได้อยู่ใกล้ร้านขายรถ");
	
	new delQuery[128];
		
	mysql_format(dbCon, delQuery, sizeof(delQuery), "DELETE FROM vehicles WHERE VehicleDBID = %i", dbid);
	mysql_tquery(dbCon, delQuery);

	SendServerMessage(playerid, "คุณได้ขายรถ รุ่น %s ออกจากตัวคุณแล้ว", ReturnVehicleName(GetPlayerVehicleID(playerid))); 
	SendServerMessage(playerid, "และคุณได้รับเงินคืนในจำนวน $%s", MoneyFormat(cash_back));
	GiveMoney(playerid, cash_back);
	BusinessInfo[id][BusinessCash] -= cash_back;

	ResetVehicleVars(GetPlayerVehicleID(playerid)); 
	DestroyVehicle(GetPlayerVehicleID(playerid));

	PlayerInfo[playerid][pVehicleSpawned] = false;
	PlayerInfo[playerid][pVehicleSpawnedID] = 0;
		
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pOwnedVehicles][i] == dbid)
		{
			PlayerInfo[playerid][pOwnedVehicles][i] = 0;
		}
	}
	return 1;
}

stock IsVehicleOccupied(vehicleid)
{
	foreach(new i : Player){
		if(IsPlayerInVehicle(i, vehicleid))return true; 
	}
	return false;
}

public OnVehicleDeath(vehicleid, killerid)
{
	VehicleInfo[vehicleid][eVehicleTimesDestroyed]++;
	VehicleInfo[vehicleid][eVehicleEngine]--;
	VehicleInfo[vehicleid][eVehicleBattery]--;
	VehicleInfo[vehicleid][eVehicleLocked] = true;
	SaveVehicle(vehicleid);
    return 1;
}

forward OnVehicleTow(playerid);
public OnVehicleTow(playerid)
{
	new vehicleid = PlayerInfo[playerid][pVehicleSpawnedID], newDisplay[128]; 
	
	if(IsVehicleOccupied(vehicleid))
	{
		KillTimer(playerTowTimer[playerid]);
		SendServerMessage(playerid, "การนำรถกลับมยังจุดเกิดนั้นถูกขัดด้วยอะไรบางอย่าง"); 
		
		playerTowingVehicle[playerid] = false;
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0;
		return 1;
	}
	
	VehicleInfo[vehicleid][eVehicleTowCount]++;
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 1) newDisplay = "(( || ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 2) newDisplay = "(( ||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 3) newDisplay = "(( |||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 4) newDisplay = "(( ||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 5) newDisplay = "(( |||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 6) newDisplay = "(( ||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 7) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 8) newDisplay = "(( |||||||| ))\nTOWING VEHICLE"; 
	
	Update3DTextLabelText(VehicleInfo[vehicleid][eVehicleTowDisplay], COLOR_DARKGREEN, newDisplay);
	
	if(VehicleInfo[vehicleid][eVehicleTowCount] == 9)
	{
		SendServerMessage(playerid, "รถของคุณถูกส่งกลับจุดเกิดแล้ว");
		GiveMoney(playerid, -2000);
		
		playerTowingVehicle[playerid] = false;	
		SetVehicleToRespawn(vehicleid); 
		
		Delete3DTextLabel(VehicleInfo[vehicleid][eVehicleTowDisplay]);
		KillTimer(playerTowTimer[playerid]);
		
		VehicleInfo[vehicleid][eVehicleTowCount] = 0; 
		VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
		return 1;
	}
	
	return 1;
}

stock ToggleVehicleLights(vehicleid, bool:lightstate)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lightstate, alarm, doors, bonnet, boot, objective);
	
	VehicleInfo[vehicleid][eVehicleLights] = lightstate;
	return 1;
}

stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z) 
{ 
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID) 
        return (x = 0.0, y = 0.0, z = 0.0), 0; 

    static 
        Float:pos[7] 
    ; 
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]); 
    GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]); 
    GetVehicleZAngle(vehicleid, pos[6]); 

    x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees)); 
    y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees)); 
    z = pos[5]; 

    return 1; 
}

stock ShowspeedVehicle(playerid, vehicleid)
{
	Statsvehicle[playerid][0] = CreatePlayerTextDraw(playerid, 529.000000, 384.000000, "100 KPH/MPH");
	PlayerTextDrawFont(playerid, Statsvehicle[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Statsvehicle[playerid][0], 0.333332, 2.049998);
	PlayerTextDrawTextSize(playerid, Statsvehicle[playerid][0], 646.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Statsvehicle[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawColor(playerid, Statsvehicle[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Statsvehicle[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Statsvehicle[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Statsvehicle[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Statsvehicle[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Statsvehicle[playerid][0], 0);

	Statsvehicle[playerid][1] = CreatePlayerTextDraw(playerid, 549.000000, 404.000000, "100%");
	PlayerTextDrawFont(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, Statsvehicle[playerid][1], 0.370833, 1.299999);
	PlayerTextDrawTextSize(playerid, Statsvehicle[playerid][1], 595.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Statsvehicle[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawColor(playerid, Statsvehicle[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Statsvehicle[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Statsvehicle[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Statsvehicle[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Statsvehicle[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Statsvehicle[playerid][1], 0);


	PlayerTextDrawShow(playerid, Statsvehicle[playerid][0]);
	PlayerTextDrawShow(playerid, Statsvehicle[playerid][1]);

	new str[MAX_STRING];

	format(str, sizeof(str), "%d%",VehicleInfo[vehicleid][eVehicleFuel]);
	PlayerTextDrawSetString(playerid, Statsvehicle[playerid][1], str);
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	new str[120];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		format(str, sizeof(str), "%d KM/H",GetVehicleSpeed(vehicleid));
		PlayerTextDrawSetString(playerid, Statsvehicle[playerid][0], str);
	}
	return 1;
}

stock GetVehicleSpeed(vehicleid)
{
    new
        Float:x,
        Float:y,
        Float:z,
        vel;
    GetVehicleVelocity( vehicleid, x, y, z );
    vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 );           // KM/H
//  vel = floatround( floatsqroot( x*x + y*y + z*z ) * 180 / MPH_KMH ); // Mph
    return vel;
}

/*forward Query_InsertVehicle_Faction(playerid, factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid);
public Query_InsertVehicle_Faction(playerid, factionid, modelid,color1,color2,Float:x,Float:y,Float:z,Float:a,world,newid)
{
	new vehicleid = INVALID_VEHICLE_ID;

	vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1, 0);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehicleInfo[vehicleid][eVehicleDBID] = newid;
		VehicleInfo[vehicleid][eVehicleModel] = modelid;
		VehicleInfo[vehicleid][eVehicleFaction] = factionid;

		VehicleInfo[vehicleid][eVehicleColor1] = color1;
		VehicleInfo[vehicleid][eVehicleColor2] = color2;
	}

	SendClientMessageEx(playerid, -1, "คุณได้สร้างรถเฟคชั่นให้กับ {FF5722}%s {FFFFFF}(%d)",FactionInfo[factionid][eFactionName],newid);
	return 1;
}*/

forward InsertVehicleFaction(playerid,newid, modelid, factionid, color1,color2);
public InsertVehicleFaction(playerid,newid, modelid, factionid, color1,color2)
{
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y,z);
	GetPlayerFacingAngle(playerid, a);

	new vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1, 0);

	if(vehicleid != INVALID_VEHICLE_ID)
	{
		VehFacInfo[vehicleid][VehFacDBID] = cache_insert_id();
		VehFacInfo[vehicleid][VehFacModel] = modelid;
		VehFacInfo[vehicleid][VehFacFaction] = factionid;

		VehFacInfo[vehicleid][VehFacColor][0] = color1;
		VehFacInfo[vehicleid][VehFacColor][1] = color2;
		VehicleInfo[vehicleid][eVehicleFuel] = 100;
	}

	SendClientMessageEx(playerid, -1, "คุณได้สร้างรถเฟคชั่นให้กับ {FF5722}%s {FFFFFF}(%d)",FactionInfo[factionid][eFactionName],cache_insert_id());
	return 1;
}

GetClosestVehicle(playerid, exception = INVALID_VEHICLE_ID) {

	new
	    Float:fDistance = FLOAT_INFINITY,
	    iIndex = -1
	;
	for(new i=0;i!=MAX_VEHICLES;i++) {
		if(i != exception) {
			new
	        	Float:temp = GetDistancePlayerVeh(playerid, i);

			if (temp < fDistance && temp < 6.0)
			{
			    fDistance = temp;
			    iIndex = i;
			}
		}
	}
	return iIndex;
}

GetDistancePlayerVeh(playerid, veh) {

	new
	    Float:Floats[7];

	GetPlayerPos(playerid, Floats[0], Floats[1], Floats[2]);
	GetVehiclePos(veh, Floats[3], Floats[4], Floats[5]);
	Floats[6] = floatsqroot((Floats[3]-Floats[0])*(Floats[3]-Floats[0])+(Floats[4]-Floats[1])*(Floats[4]-Floats[1])+(Floats[5]-Floats[2])*(Floats[5]-Floats[2]));

	return floatround(Floats[6]);
}

IsPlayerInRangeOfVehicle(playerid, vehicleid, Float: radius) {

	new
		Float:Floats[3];

	GetVehiclePos(vehicleid, Floats[0], Floats[1], Floats[2]);
	return IsPlayerInRangeOfPoint(playerid, radius, Floats[0], Floats[1], Floats[2]);
}

IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(vehicleid != 0)
	{
		if(RELEASED(KEY_CTRL_BACK))
		{
			if(!IsPlayerInAnyVehicle(playerid))
				return SendErrorMessage(playerid, "คุณไม่ได้อยู่บนรถ");

			RemovePlayerFromVehicle(playerid);
			TogglePlayerControllable(playerid, 1);

			if(VehicleInfo[vehicleid][eVehicleMusic])
			{
				StopAudioStreamForPlayer(playerid);
			}
			return 1;

		}
	}
	return 1;
}

forward OnVehicleUpdate();
public OnVehicleUpdate()
{
	new Float:Health; new playerid = INVALID_PLAYER_ID;
	for(new vehicleid = 1; vehicleid < MAX_VEHICLES; vehicleid++)
	{
		GetVehicleHealth(vehicleid, Health);

		foreach(new i : Player)
		{
			if(GetPlayerVehicleID(i) == vehicleid)
			{
				playerid = i;
			}
		}

		if(Health < 250)
		{
			SetVehicleHealth(vehicleid, 300.0);
			ToggleVehicleEngine(vehicleid, false); VehicleInfo[vehicleid][eVehicleEngineStatus] = false;
			SendClientMessage(playerid, -1, "รถดับ");
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(VehicleInfo[vehicleid][eVehicleMusic])
	{
		StopAudioStreamForPlayer(playerid);
	}
	return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(VehicleInfo[vehicleid][eVehicleMusic])
	{
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, VehicleInfo[vehicleid][eVehicleMusicLink]);
	}
	return 1;
}
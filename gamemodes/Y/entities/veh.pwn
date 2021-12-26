enum E_VEHICLE_SYSTEM
{
	eVehicleDBID, 
	bool:eVehicleExists,
	
	eVehicleName[60],
	eVehicleOwnerDBID,
	eVehicleFaction,
	
	eVehicleModel, 
	Float:eVehicleHealth,
	eVehicleColor1,
	eVehicleColor2,
	eVehiclePaintjob,
	
	bool:eVehicleCarPark,
	Float:eVehicleParkPos[4],
	eVehicleParkInterior,
	eVehicleParkWorld,
	
	eVehiclePlates[32], 
	bool:eVehicleLocked,
	
	bool:eVehicleImpounded,
	Float:eVehicleImpoundPos[4], 
	
	eVehicleWeapons[6], //5;
	eVehicleWeaponsAmmo[6], //5;
	
	Float:eVehicleFuel,
	eVehicleFuelTimer,
	eVehicleSirens,
	
	eVehicleLastDrivers[5], //4;
	eVehicleLastPassengers[5], //4;
	
	bool:eVehicleLights,
	bool:eVehicleEngineStatus,
	
	bool:eVehicleAdminSpawn,
	
	Text3D:eVehicleTowDisplay,
	eVehicleTowCount,
	
	bool:eVehicleHasXMR, 
	bool:eVehicleXMROn,
	eVehicleXMRURL[128],
	
	Float:eVehicleBattery,
	Float:eVehicleEngine, 
	eVehicleTimesDestroyed,
	
	eVehicleLockLevel,
	eVehicleAlarmLevel, 
	eVehicleImmobLevel,
	eVedhicleBreaktime,
	bool:eVehicleBreak,
	Text3D:eVehicleBreakUI,

	
	Text3D:eVehicleEnterTD,
	eVehicleEnterTimer,
	
	bool:eVehicleHasCarsign,
	Text3D:eVehicleCarsign,
	
	eVehicleRefillCount,
	Text3D:eVehicleRefillDisplay,
	
	eVehicleTruck,
	
	Text3D:eVehicleRepairDisplay,
	eVehicleRepairCount,
    
    eVehicleMod[14],

	eVehiclePrice,

	eVehicleComp,

	bool:eVehicleMusic,
	eVehicleMusicLink,

	Float:eVehicleDrug[3],

	eVehicleElmTimer,
	eVehicleElmFlash,

	eVehicleDamage[4],

	eVehicleFuelStock,

}

new VehicleInfo[MAX_VEHICLES][E_VEHICLE_SYSTEM];
new VehicleSiren[MAX_VEHICLES];
new bool:PlayerTaxiDuty[MAX_PLAYERS];


enum VehiclePriceIDs
{
    V_Name[60],
    V_Model,
    V_Type,
    V_PRICE
}

new g_aDealershipDatas[][VehiclePriceIDs] =
{
    {"Bike",509, 1, 700}, //0
    {"Faggio",462, 1, 5000}, //1
    {"Freeway",463, 1, 12000}, //3
    {"Wayfarer",586, 1, 12000}, //4

    {"BMX",481, 10,800},//104

    ///// 2 Door:
    {"Alpha",602, 2, 330000}, //5
    {"Blista",496, 2, 140000}, //6
    {"Bravura",401, 2, 40000}, //7
    {"Buccaneer",518, 2, 45000},//8
    {"Cadrona",527, 2, 45000},//9
    {"Club",589, 2, 160000},//10  
    {"Esperanto",419, 2, 50000},//11
    {"Euros",587, 2, 250000},//12
    {"Feltzer",533, 2, 65000},//13
    {"Fortune",526, 2, 55000},//14
    {"Hermes",474, 2, 60000},//15
    {"Hustler",545, 2, 85000},//16
    {"Majestic",517, 2, 65000},//17
    {"Manana",410, 2, 35000},//18
    {"Picador",600, 2, 38000},//19
    {"Previon",436, 2, 40000},//20
    {"Stallion",439, 2, 80000},//21
    {"Tampa",549, 2, 38000},//22
    {"Virgo",491, 2, 41000},//23
    ///// 2 Door:

    ///// 4 Door:
    {"Admiral",445, 3, 45000},//24
    {"Elegant",507, 3, 155000},//25
    {"Emperor",585, 3, 60000},//26
    {"Glendale",466, 3, 50000},//27
    {"Greenwood",492, 3,47000},//28
    {"Intruder",546, 3,46000},//30
    {"Merit",551, 3,150000},//31
    {"Nebula",516, 3,40000},//32
    {"Oceanic",467, 3,35000},//33
    {"Premier",426, 3,135000},//34
    {"Primo",547, 3,38000},//35
    {"Sentinel",405, 3,135000},//36
    {"Stafford",580, 3,200000},//37
    {"Stretch",409, 3,280000},//38
    {"Sunrise",550, 3,55000},//39
    {"Tahoma",566, 3,65000},//40
    {"Vincent",540, 3,51000},//41
    {"Washington",421, 3,100000},//42
    {"Willard",529, 3,45000},//43
    ///// 4 Door:

    ///// service:
    {"Bus",431, 4,70000},//44
    {"Cabbie",438, 4,50000},//45
    {"Coach",437, 4,75000},//46
    {"Taxi",420, 4,45000},//47
    {"Towtruck",525, 4,35000},//48
    ///// service:

    ///// Utility:
    {"Benson",499, 5,160000},//49
   	{"Boxville",609, 5,89000}, //50
    {"Boxville",498, 5,110000},//51
   	{"Boxville",498, 5,89000},//52
    {"Hotdog",588, 5,80000},//53
    {"Linerunner",403, 5,750000},//54
    {"Mule",414, 5,175000},//55
    {"Roadtrain",515, 5,900000},//56
    {"Tanker",514, 5,800000},//57
   	{"Tractor",431, 5,600000},//58
    {"Yankee",456, 5,250000},//59
  	{"Dune",573, 5,120000},//60
    ///// Utility:

    ///// Vans:
    {"Berkley's RC Van",459, 6,60000},//61
    {"Bobcat",422, 6,60000},//62
    {"Burrito",482, 6,120000},//63
    {"Moonbeam",418, 6,80000},//64
   	{"News Van",582, 6,150000},//65
    {"Pony",582, 6,110000},//66
    {"Rumpo",440, 6,100000},//67
    {"Sadler",543, 6,25000},//68
    {"Walton",478, 6,40000},//69
    {"Yosemite",554, 6,110000},//70
    ///// Vans:

    ///// SUVs:
    {"Huntley",579, 7,300000},//71
    {"Landstalker",400, 7,180000},//72
    {"Perennial",404, 7,99000},//73
   	{"Rancher",489, 7,99000},//74
    {"Rancher",505, 7,110000},//75
    {"Regina",479, 7,85000},//76
   	{"Romero",442, 7,120000},//77
    {"Solair",458, 7,90000},//78
    ///// SUVs:

    ///// Lowriders:
    {"Blade",536, 8,65000},//79
    {"Broadway",575, 8,80000},//80
    {"Remington",534, 8,75000},//81
    {"Savanna",567, 8,85000},//82
    {"Slamvan",535, 8,110000},//83
    {"Tornado",576, 8,58000},//84
    {"Voodoo",412, 8,65000},//85
    ///// Lowriders:

    ///// Muscle cars:
    {"Buffalo",402, 9,420000},//86
    {"Clover",542, 9,135000},//87
    {"Phoenix",603, 9,650000},//88
    {"Sabre",475, 9,160000},//89

    ///// Street racers:
    {"Banshee",429, 10,850000},//90
    {"Bullet",541, 10,1200000},//91
    {"Cheetah",415, 10,850000},//92
    {"Comet",480, 10,625000},//93
    {"Elegy",562, 10,220000},//94
    {"Flash",565, 10,180000},//95
  	{"Infernus",411, 10,460000},//96
    {"Jester",559, 10,200000},//97
    {"Stratum",561, 10,110000},//98
    {"Sultan",560, 10,785000},//99
    {"Uranus",558, 10,200000},//100

    {"FCR-900",521, 10,200000},//101
    {"PCJ-600",461, 10,200000},//102
    {"Sanchez",468, 10,200000}//103
    /////Street racers:
    
};


enum c_max_health_hp {
	Float:c_max_health,
};

new const VehicleData[][c_max_health_hp] =
{
	{1120.0}, //Vehicle ID 400
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
	{2500.0}, //Vehicle ID 450
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
	{700.0}, //Vehicle ID 464
	{700.0}, //Vehicle ID 465
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
	{1000.0}, //Vehicle ID 537
	{1000.0}, //Vehicle ID 538
	{1000.0}, //Vehicle ID 539
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
	{1250.0}, //Vehicle ID 564
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
	{1200.0}, //Vehicle ID 608
	{1200.0}, //Vehicle ID 609
	{1200.0}, //Vehicle ID 610
	{1000.0} //Vehicle ID 611
};
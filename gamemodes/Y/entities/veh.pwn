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
 //ไม่เอา   {"Pizzaboy",448, 1, 10000}, //2
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
   // {"Intruder",546, 3,54600},//29
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
   //ซ้ำ {"Boxville,609, 5,89000},//50
    {"Boxville",498, 5,110000},//51
   //ซ้ำ {"Boxville",498, 5,89000},//52
    {"Hotdog",588, 5,80000},//53
    {"Linerunner",403, 5,750000},//54
    {"Mule",414, 5,175000},//55
    {"Roadtrain",515, 5,900000},//56
    {"Tanker",514, 5,800000},//57
   //ไม่เอา {"Tractor",431, 5,600000},//58
    {"Yankee",456, 5,250000},//59
  //ไม่เอา  {"Dune",573, 5,120000},//60
    ///// Utility:

    ///// Vans:
    {"Berkley's RC Van",459, 6,60000},//61
    {"Bobcat",422, 6,60000},//62
    {"Burrito",482, 6,120000},//63
    {"Moonbeam",418, 6,80000},//64
   //ไม่เอา {"News Van",582, 6,150000},//65
    {"Pony",582, 6,110000},//66
    {"Rumpo",440, 6,100000},//67
    {"Sadler",543, 6,25000},//68
    {"Walton",478, 6,40000},//69
    {"Yosemite",554, 6,110000},//70
    ///// Vans:

    ///// SUVs:
    {"Huntley",579, 7,300000},//71
    {"Landstalker",400, 7,180000},//72
    //ไม่เอา{"Perennial",404, 7,99000},//73
   //ซ้ำ {"Rancher",489, 7,99000},//74
    {"Rancher",505, 7,110000},//75
    {"Regina",479, 7,85000},//76
   //ไม่เอา {"Romero",442, 7,120000},//77
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
  //ไม่เอา  {"Infernus",411, 10,460000},//96
    {"Jester",559, 10,200000},//97
    {"Stratum",561, 10,110000},//98
    {"Sultan",560, 10,785000},//99
    {"Uranus",558, 10,200000},//100

    {"FCR-900",521, 10,200000},//101
    {"PCJ-600",461, 10,200000},//102
    {"Sanchez",468, 10,200000}//103
    /////Street racers:
    
};
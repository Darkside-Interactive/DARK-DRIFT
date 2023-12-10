#if defined _mapicon
#endinput
#endif

#define _mapicon
#pragma library mapicon

AllMapIcones_OnGameModeInit() {
//-------------------------------MAP ICONES------------------------------------------//
		
	//HOUSES ICONES ++ 31
	for (new id=0;id<MAX_HOUSES;id++)
	{
	CreateStreamMapIcon(31, HousesCP[id][Coord_X], HousesCP[id][Coord_Y], HousesCP[id][Coord_Z]+0.1);
	}
	WriteLog("Housing Icones initialised");


	//TUNING ICONES 27
	CreateStreamMapIcon( 27, -2716.514404,218.293624,4.077047 );
	CreateStreamMapIcon( 27, -1936.977172,236.758300,33.975135);
	CreateStreamMapIcon( 27, 2386.543457,1042.123413,10.483552);
	CreateStreamMapIcon( 27, 1041.941894,-1027.738281,31.764158);
	CreateStreamMapIcon( 27, 2644.489746,-2037.680908,13.215667);

	//GYM CLUBS ICONES 54
	CreateStreamMapIcon( 54, -2268.922607,-155.624435,35.320312 );
	CreateStreamMapIcon( 54, 656.276306,-1865.521240,5.460937 );
	CreateStreamMapIcon( 54, 2229.041992,-1722.099121,13.173413 );
	CreateStreamMapIcon( 54, 1966.224365,2295.162109,16.455863 );

	//BANK ICONES 52
	CreateStreamMapIcon( 52, 2194.936279,1988.357910,12.296875);
	//AIRPORTS ICONES 5
// 	CreateStreamMapIcon( 5, 415.108459,2526.588623,17.554307 );  //OLD
	//CARYERES ICONES 11
 	CreateStreamMapIcon( 11, 777.150329,834.015563,6.862725);
	//GRUZ ICONES 51
 	CreateStreamMapIcon( 51, -69.993255,-1122.022460,0.924500);
	//DISCO CLUBS ICONES 48
	CreateStreamMapIcon( 48, 1836.786621,-1683.629760,13.333385);
	CreateStreamMapIcon( 48, -2553.027587,192.928573,6.135133);
	CreateStreamMapIcon( 48, 2508.361328,1243.785034,10.820312);
	//DM Icones
	/*
    CreateStreamMapIcon( 19, 2323.80,1283.20,97.53);
    CreateStreamMapIcon( 19, 1677.125488,1310.680297,10.385018);
    CreateStreamMapIcon( 19, -16.79,1517.15,12.34);
    CreateStreamMapIcon( 19, 2496.995361,1275.863891,10.812500);
    CreateStreamMapIcon( 19, 2525.836669,922.050048,10.397602);
    CreateStreamMapIcon( 19, 1349.0535,-1280.1948,13.3828);
    CreateStreamMapIcon( 19, 968.4420,1734.9261,8.6484);
    CreateStreamMapIcon( 19, 2095.976806,1285.144653,10.820312);
    CreateStreamMapIcon( 19, 2217.5837,-1162.9459,25.7266);
    CreateStreamMapIcon( 19, 1887.2286,-1424.6245,10.3594);
    CreateStreamMapIcon( 19, 2015.5129,2147.6936,10.8203);
    CreateStreamMapIcon( 19, 143.5471,-1567.5682,10.7642);
    CreateStreamMapIcon( 19, 1653.5696,-1051.1740,23.8984);
    CreateStreamMapIcon( 19, 2358.66, 533.56, 1.38);
    CreateStreamMapIcon( 19, 621.3632,50.6374,1.4212);
    CreateStreamMapIcon( 19, 1489.034912,722.709411,10.820312);
    CreateStreamMapIcon( 19, 2293.854492,533.003784,1.794376);
    CreateStreamMapIcon( 19, 2486.14, 2772.60, 10.35);
    CreateStreamMapIcon( 19, 2197.7671,-1643.9935,14.8291);
    CreateStreamMapIcon( 19, 951.68,-1355.8486,13.0234);
    CreateStreamMapIcon( 19, 1964.748413,1343.146850,16.591800);
    CreateStreamMapIcon( 19, 2435.204345,1662.185058,15.638896);
    CreateStreamMapIcon( 19, 2786.84, -2456.29, 13.63);
    */
		//CashBox Lombard Location
	//CarExport Location
//	CreateStreamMapIcon( 16, -1609.133056,1284.745971,7.177499);
//-----------------------------------------------------------------------------------
}


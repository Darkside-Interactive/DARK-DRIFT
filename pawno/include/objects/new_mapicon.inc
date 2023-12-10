#if defined _mapicon
#endinput
#endif

#define _mapicon
#pragma library mapicon

AllMapIcones_OnGameModeInit() {
//-------------------------------MAP ICONES------------------------------------------//
//	SetPlayerMapIcon(playerid, 5, -1981.6111, 287.9597, 35.0547, 32, 0);
//	CreateStreamMapIcon( 56, 0.0, 0.0, 0.0);
		
	//HOUSES ICONES ++ 31
//	for (new id=0;id<MAX_HOUSES;id++)
//	{
//	CreateStreamMapIcon(31, HousesCP[id][Coord_X], HousesCP[id][Coord_Y], HousesCP[id][Coord_Z]+0.1);
//	}
//	WriteLog("Housing Icones initialised");


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

	//GIRLS HOME ICONES 21
//	CreateStreamMapIcon( 21, 2402.599609,-1712.472778,13.696617);
//	CreateStreamMapIcon( 21, -383.845184,-1438.749511,25.893049);
//	CreateStreamMapIcon( 21, -1800.316040,1203.542846,24.691484);
//	CreateStreamMapIcon( 21, -2573.435791,1154.484741,55.297195);
//	CreateStreamMapIcon( 21, -1390.157470,2643.111328,55.549030);
//	CreateStreamMapIcon( 21, 2037.411987,2718.329833,11.108150);

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

	//CashBox Lombard Location
	
	//CarExport Location
//	CreateStreamMapIcon( 16, -1609.133056,1284.745971,7.177499);
//-----------------------------------------------------------------------------------
}


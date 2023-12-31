//
// Converted:   10.05.08
// Aurthor:    	Sharon
// Converter: 	MadCat
//

#if defined _race_sflvl_included
  #endinput
#endif

#define _race_sflvl_included
#pragma library race_sflvl
#include "race"

forward race_sflvl_init();

static racename[MAX_NAME] = "SF to LV Long Race";
static racefrequency = 10;
static lineupdelay = 240;
static minracers = 1;
static minlevel = 3; // minimum player level required to join this race
static cashprize = 3000; // cash earned for 1st position
static cashentry = 100; // Cash required to enter (earned by winner)
static xpprize = 2000; // xp earned for 1st position
static xpbonus = 450; // xp earned per player still in race
static maxracetime = 900;
static allowedcars[2];
static Float:startlineheading = 0.0;
static Float:racecheckpoints[][CoordInfo] = {
{-2681.6921,1307.8812,55.1999}, // 0
{-2674.7627,2195.5325,55.1974},
{-2699.5662,2377.0825,68.3282},
{-2582.9893,2488.1699,20.9011},
{-2442.0715,2431.5198,13.5886},
{-2314.5227,2380.0315,5.3942},
{-2272.5972,2298.4363,4.5904},
{-2304.2920,2310.9883,4.7580},
{-2429.4160,2334.8997,4.6080},
{-2506.8550,2332.4338,4.6082},
{-2557.6362,2292.9270,4.6082}, // 10
{-2466.9600,2276.6458,4.6075},
{-2563.9382,2476.5630,19.2937},
{-2694.5142,2397.8220,60.2889},
{-2771.9348,2401.8804,85.0547},
{-2646.8892,2667.5762,80.6778},
{-2259.9646,2677.4224,54.9753},
{-1941.6838,2612.0420,47.1688},
{-1787.5096,2700.4053,57.9704},
{-1635.5231,2701.5806,56.0269},
{-1579.0980,2671.4639,55.4158}, // 20
{-1497.4756,2642.6934,55.4599},
{-1519.9423,2602.1565,55.4623},
{-1523.8751,2550.7900,55.4604},
{-1467.2678,2600.6084,55.4597},
{-1274.5913,2663.6565,48.7378},
{-1194.6969,2619.2480,56.7049},
{-1108.6653,2423.4089,81.4078},
{-1072.6232,2224.8965,87.8315},
{-1112.3115,2110.8884,86.4906},
{-1271.4701,2000.3884,65.0218}, // 30
{-1239.7941,1924.8459,42.6355},
{-1159.6942,1801.2047,39.8124},
{-983.7184,1841.2161,62.3488},
{-883.9253,1798.0393,59.9841},
{-863.1843,1893.0977,59.9622},
{-804.5901,2042.2648,60.1349},
{-469.4209,2014.2292,60.0443},
{-385.9509,2077.0874,60.7650},
{-479.7586,1927.7014,85.9882},
{-456.0213,1761.2518,71.9787}, // 40
{-417.5898,1915.2837,57.2822},
{-412.3232,1690.2509,38.9487},
{-446.4934,1508.8208,34.9350},
{-268.8444,1244.1097,23.7957},
{-115.4108,1175.6720,19.3677},
{-110.7123,1132.0452,19.5154},
{-43.5621,1099.2119,19.3580},
{32.5156,1122.0090,19.3653},
{-64.6534,1169.7813,19.3602},
{-220.9033,1198.5597,19.3669}, // 50
{-304.8117,1148.5804,19.3663},
{-318.1539,1073.9078,19.3662},
{-234.7023,1020.3640,19.3662},
{-191.7475,943.6050,15.3216},
{-253.8903,831.4852,13.3694},
{-260.9316,787.8416,16.4465},
{-69.0062,849.4223,17.7790},
{146.0543,894.8816,20.3509},
{284.1035,992.5592,28.0940},
{477.4864,1041.0851,28.1530}, // 60
{829.0829,1162.7045,27.6657},
{772.6414,1446.6018,20.1883},
{861.4728,1598.0516,14.7073},
{776.1376,1836.8519,5.2907},
{680.9348,1859.2623,5.2717},
{661.4260,1896.4459,5.2438},
{687.0114,1914.1309,5.3113},
{768.7091,1913.8910,5.3105},
{815.7853,1976.8621,8.0694},
{816.0148,2149.3867,10.2843}, // 70
{758.2327,2438.3669,21.4600},
{823.8551,2503.2046,28.7455},
{849.8428,2498.3701,29.3803},
{853.9630,2407.7830,28.7953},
{712.9425,2358.8635,30.0255},
{847.6229,2616.0952,11.3774},
{1125.0420,2461.4001,10.4333},
{1336.5382,2386.6941,10.1963},
{1647.0190,2521.6545,8.7690},
{1816.5305,2501.4739,14.2236}, // 80
{1805.2025,2132.7673,3.6776},
{1849.5374,1785.8580,8.7651},
{1961.6584,1714.5939,10.4434},
{2046.7800,1593.7041,10.4435},
{2025.0089,1455.2468,10.4442},
{1981.6794,1394.5156,8.8815},
{1947.6085,1365.7244,8.8807},
{1931.7939,1274.6492,10.4441},
{1730.3522,1286.4081,10.4452},
{1711.5452,1430.4001,10.2790}, // 90
{1708.9957,1604.7115,9.7840},
{1489.6141,1576.9471,10.5840},
{1477.8452,1392.9819,10.5926},
{1427.3568,1266.1130,10.5916},
{1391.1938,1672.0706,10.5916},
{1446.7994,1732.4452,10.5918},
{1476.7358,1549.1154,10.5838},
{1440.0441,1464.4316,10.5928} // 98
};

static RaceID; // this will hold the id this race is assigned at init

public race_sflvl_init() // unique named init function (must be ran on gamemode init)
{
	RaceID = RegisterRace(racename);
	if (RaceID == INVALID_RACE_ID) return;

	Race[RaceID][race_frequency] = racefrequency;
 	Race[RaceID][race_lineupdelay] = lineupdelay;
 	Race[RaceID][race_minracers] = minracers;
 	Race[RaceID][race_minlevel] = minlevel;
 	Race[RaceID][race_cashprize] = cashprize;
	Race[RaceID][race_cashentry] = cashentry;
	Race[RaceID][race_xpprize] = xpprize;
	Race[RaceID][race_xpbonus] = xpbonus;
	Race[RaceID][race_maxracetime] = maxracetime;
	Race[RaceID][race_startheading] = startlineheading;
	set(Race[RaceID][race_vehicles],allowedcars);

	RaceSize[RaceID] = sizeof(racecheckpoints);
	for (new cpid=0;cpid<sizeof(racecheckpoints);cpid++)
	{
		RaceCheckpoints[RaceID][cpid][Coord_X] = racecheckpoints[cpid][Coord_X];
		RaceCheckpoints[RaceID][cpid][Coord_Y] = racecheckpoints[cpid][Coord_Y];
		RaceCheckpoints[RaceID][cpid][Coord_Z] = racecheckpoints[cpid][Coord_Z];
	}

	RaceStats[RaceID][race_timer] = MakeRaceSleepTime(RaceID);
    RaceStats[RaceID][race_state] = RACE_STATE_SLEEPING;
  	printf("Race: '%s' Loaded.",racename);
 }

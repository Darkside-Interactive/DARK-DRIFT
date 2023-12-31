//
// Converted:   10.05.08
// Aurthor:    	Sharon
// Converter: 	MadCat
//

#if defined _race_sfur_included
  #endinput
#endif

#define _race_sfur_included
#pragma library race_sfur
#include "race"

forward race_sfur_init();

static racename[MAX_NAME] = "San-Fierro Urban Race";
static racefrequency = 10;
static lineupdelay = 240;
static minracers = 1;
static minlevel = 1; // minimum player level required to join this race
static cashprize = 3000; // cash earned for 1st position
static cashentry = 100; // Cash required to enter (earned by winner)
static xpprize = 1000; // xp earned for 1st position
static xpbonus = 250; // xp earned per player still in race
static maxracetime = 900;
static allowedcars[2];
static Float:startlineheading = 136.2991;
static Float:racecheckpoints[][CoordInfo] = {
{-1569.7991,658.7461,43.2143}, // 0
{-1756.8466,483.4562,36.9651},
{-1806.4658,428.8758,19.3086},
{-1845.4272,428.6870,16.7349},
{-1853.3783,533.9314,33.7822},
{-1850.8090,603.1743,34.7427},
{-1715.2106,690.3222,24.4634},
{-1658.0751,783.2475,17.9433},
{-1614.5927,843.9599,7.2719},
{-1477.6921,835.4823,6.9146},
{-1434.4070,897.5701,6.9146}, // 10
{-1466.9934,1008.4491,6.9135},
{-1515.9139,1063.1036,6.9146},
{-1534.9283,1227.0807,6.9146},
{-1635.4779,1190.3115,6.8321},
{-1744.8069,1185.2974,24.7037},
{-1794.7440,1143.4453,36.1902},
{-1793.9978,999.4839,24.4615},
{-1825.9093,927.2253,26.6966},
{-1933.0841,926.0776,38.3367},
{-2033.6156,943.4356,48.3603}, // 20
{-2074.7695,935.9988,62.8503},
{-2100.3320,933.0989,74.1719},
{-2143.0723,970.7274,79.5786},
{-2143.5479,1100.7859,79.5762},
{-2122.1306,1176.5111,55.3016},
{-1967.1392,1141.5297,48.6927},
{-2034.9431,1076.0586,55.2974},
{-2327.1777,1075.9977,55.3053},
{-2391.1594,1019.3900,53.9847},
{-2410.5596,908.3809,45.1407}, // 30
{-2505.3462,907.4141,64.5034},
{-2525.9954,835.5220,49.5552},
{-2514.5293,808.8028,49.2163},
{-2443.2158,808.5751,34.7583},
{-2387.1187,770.7325,34.7427},
{-2482.7314,708.4196,34.7427},
{-2527.3933,664.9088,27.7491},
{-2544.4351,569.0751,14.1893},
{-2550.6472,622.3242,14.1802},
{-2587.6970,632.7044,14.1802}, // 40
{-2605.7783,605.6638,14.1851},
{-2607.8633,662.2493,23.3779},
{-2639.2849,707.8343,27.5132},
{-2750.9014,729.4254,44.0153},
{-2769.1294,807.6309,51.8487},
{-2810.1409,894.5362,43.6333},
{-2881.7603,1078.5382,30.3186},
{-2856.8267,1226.7454,5.2095},
{-2665.9775,1289.0304,6.7681},
{-2525.8467,1376.0598,6.7661}, // 50
{-2366.8499,1327.0544,13.8223},
{-2328.1833,1177.9885,46.7505},
{-2262.1995,1015.1913,83.3530},
{-2261.8511,908.3932,66.2271},
{-2261.2305,782.3309,49.0186},
{-2214.1047,731.5366,48.9856},
{-2143.0627,704.1924,69.1220},
{-2165.6589,567.1060,34.7336},
{-2292.5894,567.4587,34.7329},
{-2526.6423,532.6807,14.1804}, // 60
{-2606.8743,437.5328,14.1715},
{-2584.0957,385.0127,11.5630},
{-2557.2019,408.4691,18.3253},
{-2539.8066,318.2818,19.1529},
{-2528.1545,160.0510,3.9056},
{-2407.6125,248.9630,25.6943},
{-2314.9194,319.0774,38.7703},
{-2250.3655,304.6265,34.8912},
{-2279.9087,162.6081,34.9277},
{-2358.3103,112.8951,35.0377}, // 70
{-2441.1345,41.0123,34.0897},
{-2501.3860,-13.0281,25.3365},
{-2473.4333,-70.1241,29.7728},
{-2339.2253,-69.2982,34.8911},
{-2200.0088,-69.5931,34.8990},
{-2117.2332,-69.5359,34.9009},
{-1970.2350,-66.1656,26.2604},
{-1915.5598,-77.4997,25.0993},
{-1840.7313,-115.9055,5.2193},
{-1749.8582,-112.9371,3.2818}, // 80
{-1697.5509,-59.5360,3.2921},
{-1665.0333,-10.9060,3.2819},
{-1667.1545,8.2965,3.2818},
{-1528.8751,143.4968,3.2817},
{-1602.5815,96.4455,3.2765},
{-1681.9365,36.9151,3.2818},
{-1736.8743,28.8505,3.2818},
{-1761.3149,139.0350,3.3211},
{-1809.2384,148.3570,14.6878},
{-1803.5686,36.2839,14.6880}, // 90
{-1799.0488,-151.6147,6.9996},
{-1799.9650,-279.9442,22.2849},
{-1812.3986,-400.4187,15.9992},
{-1819.9640,-543.0903,15.2226},
{-1755.0868,-579.3116,16.0630},
{-1627.8605,-512.6422,9.4980},
{-1512.7744,-277.1027,5.7271},
{-1534.1180,-183.2704,13.8755}
};

static RaceID; // this will hold the id this race is assigned at init

public race_sfur_init() // unique named init function (must be ran on gamemode init)
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

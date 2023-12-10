//
// Created:     20.10.07
// Aurthor:    Frolov Dmitry
//

#if defined _race_morningcross_included
  #endinput
#endif

#define _race_morningcross_included
#pragma library race_morningcross
#include "race"

static racename[MAX_NAME] = "Morning Cross"; // unique name of race
static racefrequency = 1	; // frequency that race runs
static lineupdelay = 290; // how long we wait for people before starting race, in seconds
static minracers = 1; // minimum number of racers required to start this race
static minlevel = 10; // minimum player level required to join this race
static cashprize = 20000; // cash earned for 1st position
static cashentry = 600; // Cash required to enter (earned by winner)
static xpprize = 10000; // xp earned for 1st position
static xpbonus = 1000; // xp earned per player still in race
static maxracetime = 240; // time race runs for (seconds)
static allowedcars[2]; // cars allowed in this race.
static Float:startlineheading = 90.32894; // which way players face at startline
static Float:racecheckpoints[][CoordInfo] = {
{1621.824584,291.209167,20.798332},
{1558.130126,270.623291,21.407249},
{1615.591796,228.847869,29.794952},
{1669.382690,302.623809,29.837755},
{1737.930297,493.258850,29.080194},
{1805.899658,792.958251,10.972625},
{1806.518066,1102.018432,6.439206},
{1806.329711,1490.454711,6.442993},
{1806.302124,2029.909423,3.614923},
{1812.336425,2400.704833,8.658479},
{1758.989990,2555.630859,12.607428},
{1500.130249,2472.505371,6.443053},
{1152.903442,2486.441406,10.214241},
{851.071838,2637.509033,11.469441},
{629.312622,2501.926513,31.130363},
{654.826232,2110.812500,16.987457},
{641.764282,1772.660034,4.807674},
{403.545715,1589.861938,17.544544},
{300.066497,1268.633178,13.990685},
{196.540435,1167.503051,14.550086},
{259.404296,895.695739,22.545114},
{423.387359,611.158386,18.645223},
{614.925964,337.117065,18.875818},
{665.956359,311.688568,19.590097},
{961.277893,387.337921,19.587697},
{1098.697631,575.035522,19.587827},
{1379.165039,444.553771,19.574535},
{1592.376342,383.072723,19.587696},
{1625.477416,301.002838,20.788476}
};

static RaceID; // this will hold the id this race is assigned at init

forward race_morningcross_init();

public race_morningcross_init() // unique named init function (must be ran on gamemode init)
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

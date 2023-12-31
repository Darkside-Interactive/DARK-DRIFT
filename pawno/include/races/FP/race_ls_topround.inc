//
// Created:     20.10.07
// Aurthor:    Frolov Dmitry
//

#if defined _race_ls_topround_included
  #endinput
#endif

#define _race_ls_topround_included
#pragma library race_ls_topround
#include "race"

static racename[MAX_NAME] = "LS Top Round"; // unique name of race
static racefrequency = 3	; // frequency that race runs
static lineupdelay = 283; // how long we wait for people before starting race, in seconds
static minracers = 1; // minimum number of racers required to start this race
static minlevel = 0; // minimum player level required to join this race
static cashprize = 1500; // cash earned for 1st position
static cashentry = 500; // Cash required to enter (earned by winner)
static xpprize = 600; // xp earned for 1st position
static xpbonus = 150; // xp earned per player still in race
static maxracetime = 360; // time race runs for (seconds)
static allowedcars[2]; // cars allowed in this race.
static Float:startlineheading = 90.1063; // which way players face at startline
static Float:racecheckpoints[][CoordInfo] = {

{2398.393798,-1751.300415,13.087018},
{2329.658447,-1751.522460,13.084855},
{2314.598144,-1743.082519,13.088177},
{2332.614990,-1731.992553,13.086565},
{2497.185546,-1732.294921,13.086992},
{2623.036865,-1732.357543,11.000874},
{2642.896728,-1679.628051,10.437490},
{2643.059814,-1493.611694,29.963663},
{2642.620849,-1277.804809,47.449806},
{2642.740234,-1096.113769,69.092193},
{2709.330566,-1086.094238,68.952880},
{2722.569824,-1166.402343,69.007324},
{2722.702880,-1264.390747,59.287929},
{2722.548828,-1470.036865,29.985450},
{2722.748779,-1589.578125,13.849822},
{2673.334960,-1609.451904,16.174863},
{2498.707275,-1603.213500,16.731031},
{2375.960693,-1570.827880,20.278442},
{2342.281005,-1584.519165,23.425304},
{2342.983398,-1687.844604,13.063136},
{2396.638671,-1750.538574,13.087397}

};

static RaceID; // this will hold the id this race is assigned at init

forward race_ls_topround_init();

public race_ls_topround_init() // unique named init function (must be ran on gamemode init)
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

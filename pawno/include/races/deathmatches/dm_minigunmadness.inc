//
// Created:     09.09.06
// Aurthor:    Iain Gilbert
//

#if defined _dm_minigunmadness_included
  #endinput
#endif

#define _dm_minigunmadness_included
#pragma library dm_minigunmadness
#include "deathmatch"

static name[MAX_NAME] = "Minigun Madness"; // unique name of dm
static frequency = 1; // frequency that dm runs
static lineupdelay = 130; // how long we wait for people before starting dm, in seconds
static minplayers = 2; // minimum number of dmrs required to start this dm
static minlevel = 1; // minimum player level required to join this dm
static cashprize = 10000; // cash earned for 1st position
static cashentry = 500; // Cash required to enter (earned by winner)
static xpprize = 10000; // xp earned for 1st position
static xpbonus = 2000; // xp earned per player in dm
static xpkill = 3000; // xp gained when killing someone in dm
static xpdeath = 600; // xp lost on death in dm
static maxtime = 240; // time dm runs for (seconds)
static maxdistance = 100; // max distance player can wander from dm before being kicked
static activedmjoin = 1; // can players join this dm while it is in progress
static weapons[MAX_DMWEAPONS+1] = {38,26,28,0};
static Float:startcp[CoordInfo] = {2197.7671,-1643.9935,14.8291}; // where startpoint is located
static Float:centrecp[CoordInfo] = {-2069.0359,228.7548,39.0518}; // central point
static Float:spawnpoints[][CoordInfo] = {
{-2072.9880,306.5711,41.9922}, // mgmsp2
{-2052.1082,304.1552,41.9922}, // mgmsp3
{-2060.4114,253.1661,37.5827}, // mgmsp4
{-2131.7061,174.9479,42.2500}, // mgm sp5
{-2120.0977,225.4191,35.1206}, // mgmsp6
{-2028.8907,156.1449,28.8359} // mgm sp7
};

static dmid; // this will hold the id this dm is assigned at init

forward dm_minigunmadness_init();

public dm_minigunmadness_init() // unique named init function (must be ran on gamemode init)
{
	dmid = RegisterDM(name);
	if (dmid == INVALID_RACE_ID) return;

	Deathmatch[dmid][dm_frequency] = frequency;
 	Deathmatch[dmid][dm_lineupdelay] = lineupdelay;
 	Deathmatch[dmid][dm_minplayers] = minplayers;
 	Deathmatch[dmid][dm_minlevel] = minlevel;
 	Deathmatch[dmid][dm_cashprize] = cashprize;
	Deathmatch[dmid][dm_cashentry] = cashentry;
	Deathmatch[dmid][dm_xpprize] = xpprize;
	Deathmatch[dmid][dm_xpbonus] = xpbonus;
	Deathmatch[dmid][dm_xpkill] = xpkill;
	Deathmatch[dmid][dm_xpdeath] = xpdeath;
	Deathmatch[dmid][dm_maxtime] = maxtime;
	Deathmatch[dmid][dm_distance] = maxdistance;
	Deathmatch[dmid][dm_activedmjoin] = activedmjoin;
	set(Deathmatch[dmid][dm_weapons],weapons);
	DeathmatchStats[dmid][dm_timer] = MakeDMSleepTime(dmid);
	DeathmatchStats[dmid][dm_state] = DM_STATE_SLEEPING;
	
	DMStartCP[dmid][Coord_X] = startcp[Coord_X];
	DMStartCP[dmid][Coord_Y] = startcp[Coord_Y];
	DMStartCP[dmid][Coord_Z] = startcp[Coord_Z];
	
	DMCentreCP[dmid][Coord_X] = centrecp[Coord_X];
	DMCentreCP[dmid][Coord_Y] = centrecp[Coord_Y];
	DMCentreCP[dmid][Coord_Z] = centrecp[Coord_Z];
	
	DMSpawnsSize[dmid] = sizeof(spawnpoints);
	for (new spid=0;spid<sizeof(spawnpoints);spid++)
	{
		DMSpawnPoints[dmid][spid][Coord_X] = spawnpoints[spid][Coord_X];
		DMSpawnPoints[dmid][spid][Coord_Y] = spawnpoints[spid][Coord_Y];
		DMSpawnPoints[dmid][spid][Coord_Z] = spawnpoints[spid][Coord_Z];
	}

 	printf("Deathmatch: '%s' Loaded.",name);
 }
 	


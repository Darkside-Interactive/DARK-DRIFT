//
//

#if defined _dm_air_included
#endinput
#endif

#define _dm_air_included
#pragma library dm_air
#include "deathmatch"

static name[MAX_NAME] = "At Pyramid"; // unique name of dm
static frequency = 3; // frequency that dm runs
static lineupdelay = 100; // how long we wait for people before starting dm, in seconds
static minplayers = 2; // minimum number of dmrs required to start this dm
static minlevel = 12; // minimum player level required to join this dm
static cashprize = 20000; // cash earned for 1st position
static cashentry = 1500; // Cash required to enter (earned by winner)
static xpprize = 8500; // xp earned for 1st position
static xpbonus = 900; // xp earned per player in dm
static xpkill = 2000; // xp gained when killing someone in dm
static xpdeath = 400; // xp lost on death in dm
static maxtime = 240; // time dm runs for (seconds)
static maxdistance = 5000; // max distance player can wander from dm before being kicked
static activedmjoin = 1; // can players join this dm while it is in progress
static weapons[MAX_DMWEAPONS+1] = {46,28,30,0};
static Float:startcp[CoordInfo] = {2323.80,1283.20,97.53}; // where startpoint is located
static Float:centrecp[CoordInfo] = {2833.378906,2469.784423,17.671875}; // central point
static Float:spawnpoints[][CoordInfo] = {
	{2323.76,1283.35,1299.54},
	{2323.76,1283.35,1299.50},
	{2323.79,1283.35,1299.54},
	{2323.76,1283.35,1299.50},
	{2323.79,1283.35,1299.50},
	{2323.76,1283.33,1299.50},
	{2323.76,1283.30,1299.52},
	{2323.78,1283.39,1299.50}
};

static dmid; // this will hold the id this dm is assigned at init

forward dm_air_init();

public dm_air_init() // unique named init function (must be ran on gamemode init)
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
 	


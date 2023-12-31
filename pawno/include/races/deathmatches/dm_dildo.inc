//
// Created:     21.03.07
// Aurthor:    addam
//

#if defined _dm_dildo_included
  #endinput
#endif

#define _dm_dildo_included
#pragma library dm_dildo
#include "deathmatch"

static name[MAX_NAME] = "Farm Revenge"; // unique name of dm
static frequency = 2; // frequency that dm runs
static lineupdelay = 120; // how long we wait for people before starting dm, in seconds
static minplayers = 1; // minimum number of dmrs required to start this dm
static minlevel = 1; // minimum player level required to join this dm
static cashprize = 20000; // cash earned for 1st position
static cashentry = 2500; // Cash required to enter (earned by winner)
static xpprize = 12000; // xp earned for 1st position
static xpbonus = 2000; // xp earned per player in dm
static xpkill = 2500; // xp gained when killing someone in dm
static xpdeath = 100; // xp lost on death in dm
static maxtime = 240; // time dm runs for (seconds)
static maxdistance = 200; // max distance player can wander from dm before being kicked out of dm
static activedmjoin = 1; // can players join this dm while it is in progress
static weapons[MAX_DMWEAPONS+1] = {24,28,30,4,0,...};
static Float:startcp[CoordInfo] = {621.3632,50.6374,1.4212};  // where startpoint is located
static Float:centrecp[CoordInfo] = {-1444.1169,-1566.4871,101.7578};  // where central
static Float:spawnpoints[][CoordInfo] = {
	{-1422.5549,-1570.6843,101.7578},
	{-1452.3040,-1576.6777,101.7578},
	{-1452.3040,-1576.6777,101.7578},
	{-1452.6021,-1576.2151,105.1250},
	{-1444.1169,-1566.4871,101.7578},
	{-1418.4985,-1553.2576,101.7578},
	{-1435.4286,-1533.4918,101.7554},
	{-1409.0118,-1515.7222,101.6945},
	{-1468.3948,-1510.5454,101.7513},
	{-1449.7051,-1481.8016,101.7578}
};

static dmid; // this will hold the id this dm is assigned at init

forward dm_dildo_init();

public dm_dildo_init() // unique named init function (must be ran on gamemode init)
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
 	


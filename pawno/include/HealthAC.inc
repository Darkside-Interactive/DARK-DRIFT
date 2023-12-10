#include a_samp

#if defined _HealthAC_included
	#endinput
#endif
#define _HealthAC_included
#pragma library HealthAC

/*
	Health/Armour Anti-Cheat
	for PROAdmin Adminscript
	BJIADOKC (c) 2011
*/

new Float:CurrentS[MAX_PLAYERS][2];
new Float:OldS[MAX_PLAYERS][2];
new bool:HealthFalseReaction[MAX_PLAYERS] = false;

stock bSetPlayerHealth(playerid,Float:Health)
{
	if(!IsPlayerConnected(playerid) || Health < 0.0 || Health > 100.0) return 1;
	HealthFalseReaction[playerid] = true;
	OldS[playerid][0] = Health;
	CurrentS[playerid][0] = Health;
	SetPlayerHealth(playerid,Health);
	SetTimerEx("FuckHealth",500,false,"d",playerid);
	return 1;
}

stock bSetPlayerArmour(playerid,Float:Armour)
{
	if(!IsPlayerConnected(playerid) || Armour < 0.0 || Armour > 100.0) return 1;
	HealthFalseReaction[playerid] = true;
	OldS[playerid][1] = Armour;
	CurrentS[playerid][1] = Armour;
	SetPlayerArmour(playerid,Armour);
	SetTimerEx("FuckHealth",500,false,"d",playerid);
	return 1;
}

stock bOnPlayerDeath__(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	HealthFalseReaction[playerid] = true;
	return 1;
}

stock bConnect_Disconnect__(playerid)
{
	HealthFalseReaction[playerid] = true;
	return 1;
}

stock bOnPlayerSpawn__(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	HealthFalseReaction[playerid] = true;
	GetPlayerHealth(playerid,CurrentS[playerid][0]);
	GetPlayerHealth(playerid,OldS[playerid][0]);
	GetPlayerArmour(playerid,CurrentS[playerid][1]);
	GetPlayerArmour(playerid,OldS[playerid][1]);
	SetTimerEx("FuckHealth",500,false,"d",playerid);
	return 1;
}

stock bUpdate__(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	GetPlayerHealth(playerid,CurrentS[playerid][0]);
	GetPlayerArmour(playerid,CurrentS[playerid][1]);
	if(((CurrentS[playerid][0] > OldS[playerid][0]) || (CurrentS[playerid][1] > OldS[playerid][1])) && !HealthFalseReaction[playerid] && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || GetPlayerState(playerid) == PLAYER_STATE_ONFOOT))
	{
		SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (Здоровье)");
		return 1;
	}
	OldS[playerid][0] = CurrentS[playerid][0];
	OldS[playerid][1] = CurrentS[playerid][1];
	return 1;
}

forward FuckHealth(playerid);
public FuckHealth(playerid) return HealthFalseReaction[playerid] = false;

#define SetPlayerHealth bSetPlayerHealth
#define SetPlayerArmour bSetPlayerArmour
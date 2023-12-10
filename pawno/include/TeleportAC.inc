#include a_samp
#include Dini

#if defined _TeleportAC_included
	#endinput
#endif
#define _TeleportAC_included
#pragma library TeleportAC

/*
	Airbreak/Teleport Anti-Cheat
	for PROAdmin Adminscript
	BJIADOKC (c) 2011
*/

new Float:CurrentPos_[MAX_PLAYERS][3];
new Float:OldPos_[MAX_PLAYERS][3];
new Float:DistanceToNewPos[MAX_PLAYERS];
new Float:AirBreakSense2;
new bool:ABEnabled = false;
new bool:TeleportFalseReaction[MAX_PLAYERS] = false;

stock LoadABConfig(cfile[])
{
	ABEnabled = dini_Bool(cfile,"AntiAirBreak");
	AirBreakSense2 = float(dini_Int(cfile,"AirBreakSense"));
	if(AirBreakSense2 <= 20.0) AirBreakSense2 += 20.0;
	return 1;
}

stock bSetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	if(!IsPlayerConnected(playerid)) return 1;
	TeleportFalseReaction[playerid] = true;
	OldPos_[playerid][0] = x;
	OldPos_[playerid][1] = y;
	OldPos_[playerid][2] = z;
	CurrentPos_[playerid][0] = x;
	CurrentPos_[playerid][1] = y;
	CurrentPos_[playerid][2] = z;
	SetPlayerPos(playerid,x,y,z);
	TeleportFalseReaction[playerid] = false;
	return 1;
}

stock bPutPlayerInVehicle(playerid,vehicleid,seatid)
{
	if(!IsPlayerConnected(playerid) || vehicleid == INVALID_VEHICLE_ID || seatid < 0) return 1;
	TeleportFalseReaction[playerid] = true;
	GetVehiclePos(vehicleid,CurrentPos_[playerid][0],CurrentPos_[playerid][1],CurrentPos_[playerid][2]);
	for(new a = 0; a < 3; a++) OldPos_[playerid][a] = CurrentPos_[playerid][a];
	SetPlayerPos(playerid,OldPos_[playerid][0],OldPos_[playerid][1],OldPos_[playerid][2]+2.0);
	PutPlayerInVehicle(playerid,vehicleid,seatid);
	TeleportFalseReaction[playerid] = false;
	return 1;
}

stock bConnect_Disconnect___(playerid)
{
	TeleportFalseReaction[playerid] = true;
	for(new a = 0; a < 3; a++)
	{
		OldPos_[playerid][a] = 0.0;
		CurrentPos_[playerid][a] = 0.0;
	}
	DistanceToNewPos[playerid] = 0.0;
	return 1;
}

stock bOnPlayerDeath___(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	TeleportFalseReaction[playerid] = true;
	return 1;
}

stock bOnPlayerSpawn___(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	TeleportFalseReaction[playerid] = true;
	GetPlayerPos(playerid,CurrentPos_[playerid][0],CurrentPos_[playerid][1],CurrentPos_[playerid][2]);
	for(new a = 0; a < 3; a++) OldPos_[playerid][a] = CurrentPos_[playerid][a];
	TeleportFalseReaction[playerid] = false;
	return 1;
}

stock bUpdate____(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid,CurrentPos_[playerid][0],CurrentPos_[playerid][1],CurrentPos_[playerid][2]);
	else GetVehiclePos(GetPlayerVehicleID(playerid),CurrentPos_[playerid][0],CurrentPos_[playerid][1],CurrentPos_[playerid][2]);
	DistanceToNewPos[playerid] = floatsqroot(floatpower((CurrentPos_[playerid][0] - OldPos_[playerid][0]),2.0)+floatpower((CurrentPos_[playerid][1] - OldPos_[playerid][1]),2.0));
	if(!TeleportFalseReaction[playerid] && GetPlayerInterior(playerid) == 0 && (DistanceToNewPos[playerid] > 50.0) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_ONFOOT))
	{
		SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (TP)");
		return 1;
	}
	if(ABEnabled && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) && GetPlayerInterior(playerid) == 0 && (DistanceToNewPos[playerid] >= AirBreakSense2))
	{
		SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (AB)");
		return 1;
	}
	for(new a = 0; a < 3; a++) OldPos_[playerid][a] = CurrentPos_[playerid][a];
	return 1;
}

stock bOnPlayerInteriorChange(playerid,newinteriorid,oldinteriorid)
{
	#pragma unused oldinteriorid
	if(!IsPlayerConnected(playerid)) return 1;
	if(newinteriorid != 0) TeleportFalseReaction[playerid] = true;
	else TeleportFalseReaction[playerid] = false;
	return 1;
}

#define SetPlayerPos bSetPlayerPos
#define PutPlayerInVehicle bPutPlayerInVehicle
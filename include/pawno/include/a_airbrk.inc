#if defined _airbreak_included
    #endinput
#endif
#define _airbreak_included

#include <a_samp>

#define MAX_VEHICLE_AIRBREAK  	(250.0)
#define MAX_AIRBREAK_DISTANCE 	(30.0)
#define MAX_TELEPORT 			(200.0)

new CheckDelay[MAX_PLAYERS];

new stock airbreakIndexes[] =
{
    1231, 1266, 1234, 1189,
    1235, 1136, 1196, 1197,
    1198, 1159, 1133, 1130,
    1129, 1208, 1156
};


stock Float:GetVehicleSpeed(playerid)
{
    if (!IsPlayerInAnyVehicle(playerid)) return 0.0;
    new
        Float:vX,
        Float:vY,
        Float:vZ
    ;
    GetVehicleVelocity(GetPlayerVehicleID(playerid), vX, vY, vZ);
    return floatsqroot(floatpower(vX, 2) + floatpower(vY, 2) + floatpower(vZ, 2)) * 100;
}
stock indextrue(index){
	for (new l = 0; l < sizeof(airbreakIndexes); l ++)
	{
		if (index == airbreakIndexes[l])
 		    return true;
	}
	return false;
}
forward AirbreakCheck();
public AirbreakCheck()
{
    new Float:xu, Float:yu, Float:zu, index, Float:dist[5];
    foreach (new i : Player)
    {
        if (CheckDelay[i])
        {
            CheckDelay[i]--;
            continue;
        }
        if (IsPlayerInAnyVehicle(i))
			GetVehiclePos(GetPlayerVehicleID(i), xu, yu, zu);
        else
			GetPlayerPos(i, xu, yu, zu);
        index = GetPlayerAnimationIndex(i);

        dist[0] = (Player[i][pPos][0] < xu) ? Player[i][pPos][0] - xu : xu - Player[i][pPos][0];
        dist[1] = (Player[i][pPos][1] < yu) ? Player[i][pPos][1] - yu : yu - Player[i][pPos][1];
        dist[2] = (Player[i][pPos][2] < zu) ? Player[i][pPos][2] - zu : zu - Player[i][pPos][2];
        dist[3] = floatsqroot(floatpower(dist[0], 2.0) + floatpower(dist[1], 2.0) + floatpower(dist[2], 2.0));
		dist[4] = GetPlayerDistanceFromPoint(i, Player[i][pPos][0],Player[i][pPos][1],Player[i][pPos][2]);//////
        if (xu == Player[i][pPos][0] && yu == Player[i][pPos][1] && zu == Player[i][pPos][2])
        	continue;
        if (dist[3] > MAX_AIRBREAK_DISTANCE && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
        {
        	if(indextrue(index) && !floatcmp(Player[i][pPos][2], zu) || MAX_TELEPORT < dist[4])
       			CallLocalFunction("OnPlayerAirbreak", "d", i);
        }else if(GetPlayerState(i) == PLAYER_STATE_DRIVER){
            new Float:speed = GetVehicleSpeed(i);
			if (dist[3] > MAX_VEHICLE_AIRBREAK && (0.01 < speed < 1.0) || MAX_TELEPORT < dist[4])
				CallLocalFunction("OnPlayerAirbreak", "d", i);
        }
        Player[i][pPos][0] = xu;
        Player[i][pPos][1] = yu;
        Player[i][pPos][2] = zu;
    }
    return 1;
}

public OnEnterExitModShop(playerid, enterexit)
{
    if (enterexit)
        CheckDelay[playerid] = 1;
    else
		CheckDelay[playerid] = 0;
    return CallLocalFunction("ab_OnEnterExitModShop", "dd", playerid, enterexit);
}
#if defined _ALS_OnEnterExitModShop
    #undef OnEnterExitModShop
#else
    #define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop ab_OnEnterExitModShop

stock ab_SetPlayerPos(playerid, Float:xy, Float:yy, Float:zy)
{
    Player[playerid][pPos][0] = xy;
    Player[playerid][pPos][1] = yy;
    Player[playerid][pPos][2] = zy;
    CheckDelay[playerid] = 1;
    return SetPlayerPos(playerid, xy, yy, zy);
}

stock ab_SetVehiclePos(vehicleid, Float:xt, Float:yt, Float:zt)
{
	foreach (new i : Player)
    {
        if(IsPlayerInVehicle(i, vehicleid))
        {
            Player[i][pPos][0] = xt;
            Player[i][pPos][1] = yt;
            Player[i][pPos][2] = zt;
    		CheckDelay[i] = 1;
        }
    }
    return SetVehiclePos(vehicleid, xt, yt, zt);
}

stock ab_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
    new Float:xr, Float:yr, Float:zr;
    GetVehiclePos(vehicleid, xr, yr, zr);
    Player[playerid][pPos][0] = xr;
    Player[playerid][pPos][1] = yr;
    Player[playerid][pPos][2] = zr;
    CheckDelay[playerid] = 1;
    return PutPlayerInVehicle(playerid, vehicleid, seatid);
}

t_SetSpawnInfo(playerid, team, skin, Float:xD, Float:yD, Float:zD, Float:AngleD, weapon1 = 0, weapon1_ammo = 0, weapon2 = 0, weapon2_ammo = 0, weapon3 = 0, weapon3_ammo = 0){
    Player[playerid][pPos][0] = xD;
    Player[playerid][pPos][1] = yD;
    Player[playerid][pPos][2] = zD;
    CheckDelay[playerid] = 1;
	return SetSpawnInfo(playerid, team, skin, xD, yD, zD, AngleD, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}
#define SetSpawnInfo t_SetSpawnInfo
#if defined FILTERSCRIPT
    #if defined _ALS_OnFilterScriptInit
        #undef OnFilterScriptInit
    #else
        #define _ALS_OnFilterScriptInit
    #endif
    #define OnFilterScriptInit ab_OnFilterScriptInit
    forward ab_OnFilterScriptInit();
#else
    #if defined _ALS_OnGameModeInit
        #undef OnGameModeInit
    #else
        #define _ALS_OnGameModeInit
    #endif
    #define OnGameModeInit ab_OnGameModeInit
    forward ab_OnGameModeInit();
#endif

#define SetPlayerPos ab_SetPlayerPos
#define SetVehiclePos ab_SetVehiclePos
#define PutPlayerInVehicle ab_PutPlayerInVehicle
forward OnPlayerAirbreak(playerid);

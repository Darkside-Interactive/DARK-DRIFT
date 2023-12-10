#include <a_samp>
#if defined _SweeperPP_included
    #endinput
#endif
#define _SweeperPP_included

//раскомментировать, чтобы использовать streamer
//#define USE_INCOGNITO_STREAMER

#if defined USE_INCOGNITO_STREAMER
	#define sw_DestroyObject(%1) DestroyDynamicObject(%1)
	#define sw_CreateObject(%1,%2,%3,%4,%5,%6,%7) CreateDynamicObject(%1, %2, %3, %4, %5, %6, %7, -1, -1, -1)
	#define sw_AttachObjectToVehicle(%1,%2,%3,%4,%5,%6,%7,%8) AttachDynamicObjectToVehicle(%1, %2, %3, %4, %5, %6, %7, %8)
#else
	#define sw_DestroyObject(%1) DestroyObject(%1)
	#define sw_CreateObject(%1,%2,%3,%4,%5,%6,%7) CreateObject(%1, %2, %3, %4, %5, %6, %7, 0.0)
	#define sw_AttachObjectToVehicle(%1,%2,%3,%4,%5,%6,%7,%8) AttachObjectToVehicle(%1, %2, %3, %4, %5, %6, %7, %8)
#endif

#define SPRAY 18710//18671 - мега чистка
#define LIGHT 19294

#define SPRAY_1_X 0.7
#define SPRAY_2_X -0.7
#define SPRAY_Y 1.6
#define SPRAY_Z -2.2

#define LIGHT_1_X 0.4
#define LIGHT_2_X -0.4
#define LIGHT_Y 0.45
#define LIGHT_Z 1.3

static
	bool:mode_spray[2000 char],
	bool:mode_light[2000 char],
	spray_1[2000],
	spray_2[2000],
	light_1[2000],
	light_2[2000];

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SUBMISSION && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static vehicleid;
		vehicleid = GetPlayerVehicleID(playerid);

		if(GetVehicleModel(vehicleid) == 574)
		{
			if(mode_spray{vehicleid})
			{
				mode_spray{vehicleid} = false;

				sw_DestroyObject(spray_1[vehicleid]);
				sw_DestroyObject(spray_2[vehicleid]);
			}
			else
			{
				mode_spray{vehicleid} = true;

				spray_1[vehicleid] = sw_CreateObject(SPRAY, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				spray_2[vehicleid] = sw_CreateObject(SPRAY, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				sw_AttachObjectToVehicle(spray_1[vehicleid], vehicleid, SPRAY_1_X, SPRAY_Y, SPRAY_Z, 0.0, 0.0, 0.0);
				sw_AttachObjectToVehicle(spray_2[vehicleid], vehicleid, SPRAY_2_X, SPRAY_Y, SPRAY_Z, 0.0, 0.0, 0.0);
			}
		}
	}
	if(newkeys & KEY_CROUCH && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static vehicleid;
		vehicleid = GetPlayerVehicleID(playerid);

		if(GetVehicleModel(vehicleid) == 574)
		{
			if(mode_light{vehicleid})
			{
				mode_light{vehicleid} = false;

				sw_DestroyObject(light_1[vehicleid]);
				sw_DestroyObject(light_2[vehicleid]);
			}
			else
			{
				mode_light{vehicleid} = true;

				light_1[vehicleid] = sw_CreateObject(LIGHT, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				light_2[vehicleid] = sw_CreateObject(LIGHT, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				sw_AttachObjectToVehicle(light_1[vehicleid], vehicleid, LIGHT_1_X, LIGHT_Y, LIGHT_Z, 0.0, 0.0, 0.0);
				sw_AttachObjectToVehicle(light_2[vehicleid], vehicleid, LIGHT_2_X, LIGHT_Y, LIGHT_Z, 0.0, 0.0, 0.0);
			}
		}
	}
    #if defined SWEEPER_OnPlayerKeyStateChange
        return SWEEPER_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange SWEEPER_OnPlayerKeyStateChange
#if defined SWEEPER_OnPlayerKeyStateChange
forward SWEEPER_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

public OnVehicleDeath(vehicleid, killerid)
{
	mode_spray{vehicleid} = false;
	mode_light{vehicleid} = false;

	sw_DestroyObject(spray_1[vehicleid]);
	sw_DestroyObject(spray_2[vehicleid]);
	sw_DestroyObject(light_1[vehicleid]);
	sw_DestroyObject(light_2[vehicleid]);
    
    #if defined SWEEPER_OnVehicleDeath
        return SWEEPER_OnVehicleDeath(vehicleid, killerid);
    #else
        return 1;
    #endif
}

#if defined _ALS_OnVehicleDeath
    #undef OnVehicleDeath
#else
    #define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath SWEEPER_OnVehicleDeath
#if defined SWEEPER_OnVehicleDeath
forward SWEEPER_OnVehicleDeath(vehicleid, killerid);
#endif

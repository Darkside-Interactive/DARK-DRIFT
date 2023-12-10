#if defined _antispeedcheat_included
  #endinput
#endif

#define _antispeedcheat_included
#pragma library antispeedcheat
#include "base"
#include "player"
#include "vehicles"

#define ANTISPEEDCHEAT_DELAY 1000
#define MAX_FOOTSPEED 15.0 // max player footspeed per second

static Float:PlayerSpeedOldPos[MAX_PLAYERS][CoordInfo];
static Float:PlayerOldSpeed[MAX_PLAYERS];
static Float:PlayerOldAcceleration[MAX_PLAYERS];
static PlayerSpeedCheatFound[MAX_PLAYERS];

static AntiSpeedcheatEnabled = 1;
static SpeedcheatTelerance = 0;

AntiSpeedcheatLoadConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(ConfigDB)) return;

	set(temp,dini_Get(ConfigDB,"Anti_Speedcheat_Enabled"));
	if (strlen(temp) > 0) AntiSpeedcheatEnabled = strval(temp);

	set(temp,dini_Get(ConfigDB,"Anti_Speedcheat_Tolerance"));
	if (strlen(temp) > 0) SpeedcheatTelerance = strval(temp);

	return;
}

AntiSpeedcheatSaveConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);

	valstr(temp,AntiSpeedcheatEnabled);
	dini_Set(ConfigDB,"Anti_Speedcheat_Enabled",temp);

	valstr(temp,SpeedcheatTelerance);
	dini_Set(ConfigDB,"Anti_Speedcheat_Tolerance",temp);
	return;
}


public AntiSpeedCheat()
{
	if (!AntiSpeedcheatEnabled) return;
    for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
	{
        if(IsPlayerConnected(playerid))
		{
		    new Float:x,Float:y,Float:z;
            GetPlayerPos(playerid, x, y, z);
            new Float:playerspeed; // distance per tick
            
            if (PlayerSpeedOldPos[playerid][Coord_X] != 0.0)
            {
            	playerspeed = GetDistanceXYZtoXYZ(x,y,z,PlayerSpeedOldPos[playerid][Coord_X],PlayerSpeedOldPos[playerid][Coord_Y],PlayerSpeedOldPos[playerid][Coord_Z]);
            }
            playerspeed = playerspeed/(ANTISPEEDCHEAT_DELAY/1000); // convert to speed per second
            new Float:playeracceleration = playerspeed - PlayerOldSpeed[playerid];
            new Float:zchange = z - PlayerSpeedOldPos[playerid][Coord_Z];
            new string[MAX_STRING];

            if (PlayerJustTeleported[playerid] == 0)
            {
                if (playerspeed > 600)
                {
                    if ((zchange < 0-400) || (zchange > 400))
					{ // if we traveled over 400 Z either way
					    PlayerJustTeleported[playerid]++; // we have changed interior?
            			PlayerSpeedOldPos[playerid][Coord_X] = x;
            			PlayerSpeedOldPos[playerid][Coord_Y] = y;
            			PlayerSpeedOldPos[playerid][Coord_Z] = z;
					    continue;

					}
					PlayerSpeedCheatFound[playerid] = 0;
                    format(string,sizeof(string),"",playerspeed);
            		ResetPlayerSpeedCheatStats(playerid);
                    continue;
                }
                
                new PlayerState = GetPlayerState(playerid);
                if (PlayerState == PLAYER_STATE_ONFOOT)
                {
                    if (playerspeed > MAX_FOOTSPEED)
                    {
                        if (zchange < 0-(playerspeed/2))
                        {// if we are falling at least 45deg angle

                        	if (zchange < -50)
                        	{ //if we are falling faster than 50 per sec, lets add a skydive bonus, just for the fun of it
								new bonus = floatround(playerspeed);
								format(string,sizeof(string),"",bonus);
            					
							}
                        }
                        else if (PlayerSpeedCheatFound[playerid] >= SpeedcheatTelerance)
                        {
                        	PlayerSpeedCheatFound[playerid] = 0;
                        	format(string,sizeof(string),"",playerspeed);
                        	ResetPlayerSpeedCheatStats(playerid);
                        	continue;
                        }
                    	else
                    	{
                    		PlayerSpeedCheatFound[playerid]++;
                    	}
					}
					else
					{
						PlayerSpeedCheatFound[playerid] = 0;
					}
                }
                else if (PlayerState == PLAYER_STATE_DRIVER)
                {
                    new playervehiclemodel = GetSpawnVehicleModel(GetPlayerVehicleID(playerid)-1);
                    new playervehiclespeed = GetVehicleSpeed(playervehiclemodel);
                    playervehiclespeed = (playervehiclespeed*10)/20; // moo
                    
                    if (zchange > (playerspeed/2))
                    { // if we are moving upwards at at least 45deg angle
                    	if (zchange > 40)
                        { // at a decent speed
                        	PlayerSpeedCheatFound[playerid] = 0;
                        	format(string,sizeof(string),"");
            				ResetPlayerSpeedCheatStats(playerid);
            				continue;
						}
                    }
                    
                    if (playerspeed > playervehiclespeed)
                    {
                        if (PlayerSpeedCheatFound[playerid] >= SpeedcheatTelerance)
                        {
                        	PlayerSpeedCheatFound[playerid] = 1;
                        	format(string,sizeof(string),"",GetVehicleName(playervehiclemodel),playerspeed,playervehiclespeed);
                        	ResetPlayerSpeedCheatStats(playerid);
                        	continue;
                        }
                    	else
                    	{
                    		PlayerSpeedCheatFound[playerid]++;
                    	}
					}
					else
					{
						PlayerSpeedCheatFound[playerid] = 1;
					}
					
					if (((PlayerOldSpeed[playerid] > 45) && (PlayerOldSpeed[playerid] < 65)) && ((playerspeed > 55) && (playerspeed < 85)))
					{ // if player has just hit nos speeds
						if (playeracceleration > 5)
						{ // if we are accelerating significantly
						    if (playeracceleration > PlayerOldAcceleration[playerid])
						    { // if player is accelerating faster than a second ago 
						    	// must be a sudden speed boost (prolly nos), lets give them a bonus for the fun of it
						    	new bonus = (floatround(playerspeed)*10);
								format(string,sizeof(string),"",bonus);
							}
						}
					}
                }
                PlayerOldAcceleration[playerid] = playeracceleration;
                PlayerOldSpeed[playerid] = playerspeed;
            }
            PlayerSpeedOldPos[playerid][Coord_X] = x;
            PlayerSpeedOldPos[playerid][Coord_Y] = y;
            PlayerSpeedOldPos[playerid][Coord_Z] = z;
   		}
   		else
   		{
			ResetPlayerSpeedCheatStats(playerid);
   		}
   	}
}

ResetPlayerSpeedCheatStats(playerid)
{
	PlayerSpeedOldPos[playerid][Coord_X] = 0.0;
	PlayerSpeedOldPos[playerid][Coord_Y] = 0.0;
	PlayerSpeedOldPos[playerid][Coord_Z] = 0.0;
	PlayerSpeedCheatFound[playerid] = 0;
}

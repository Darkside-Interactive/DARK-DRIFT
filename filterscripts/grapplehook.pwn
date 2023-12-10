/*
	Name:		Grapple Hook Filterscript v0.1
	Author:		RyDeR`
	Русификация: Grandman
	Специально для Samp-Mods.com
*/

#include <a_samp>

#if !defined MAX_GRAPPLE_DISTANCE
	#define MAX_GRAPPLE_DISTANCE \
		(150.0)
#endif

#if !defined GRAPPLE_CROSS_INTERVAL
	#define GRAPPLE_CROSS_INTERVAL \
		(0.25)
#endif

#if !defined PLAYER_MOVE_SPEED
	#define PLAYER_MOVE_SPEED \
		(20.0)
#endif

native MapAndreas_Init(mode);
native MapAndreas_FindZ_For2DCoord(Float: x, Float: y, &Float: z);

public OnFilterScriptInit()
{
	MapAndreas_Init(2);
	
	print(" \n » GrappleHook [v0.1] (by Electric`) загружен. \n ");
	return 1;
}

public OnFilterScriptExit()
{
	print(" \n » GrappleHook [v0.1] (by Electric`) выгружен. \n ");
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#define KEY_AIMFIRE (132)
	
	if(newkeys & KEY_AIMFIRE == KEY_AIMFIRE && oldkeys & KEY_AIMFIRE != KEY_AIMFIRE)
	{
		if(GetPVarInt(playerid, "pv_GrappleEnabled") && !GetPVarInt(playerid, "pv_IsMoving"))
		{
			if(GetPlayerWeapon(playerid) == 23 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			{
				static
					Float: camVect_Z,
					Float: mapPos_Z,
					Float: pAngle,
					Float: camPos[3],
					Float: tmpPos[4]
				;
				GetPlayerCameraFrontVector(playerid, camVect_Z, camVect_Z, camVect_Z);
				GetPlayerCameraPos(playerid, camPos[0], camPos[1], camPos[2]);
				GetPlayerFacingAngle(playerid, pAngle);
				
				camVect_Z += 0.08;
				
				for(new Float: i; i < MAX_GRAPPLE_DISTANCE; i += GRAPPLE_CROSS_INTERVAL)
				{
					camPos[0] += i * floatsin(-pAngle, degrees);
					camPos[1] += i * floatcos(-pAngle, degrees);
					camPos[2] += i * camVect_Z;
					
					MapAndreas_FindZ_For2DCoord(camPos[0], camPos[1], mapPos_Z);
					
					if(tmpPos[3] < camPos[2] < mapPos_Z || camPos[2] < mapPos_Z < tmpPos[2])
					{
						static
							Float: pPos[3],
							Float: totDist
						;
						GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
						
						camPos[0] = ((camPos[0] + tmpPos[0]) / 2.0) - pPos[0];
						camPos[1] = ((camPos[1] + tmpPos[1]) / 2.0) - pPos[1];
						camPos[2] = ((camPos[2] + tmpPos[2]) / 2.0) - pPos[2];
						
						totDist = floatpower((camPos[0] * camPos[0]) + (camPos[1] * camPos[1]) + (camPos[2] * camPos[2]), 0.5);
						
						SetPVarInt(playerid, "pv_MoveTimer",
							SetTimerEx("MovePlayer", 50, true, "iffffff", playerid, camPos[0] + pPos[0], camPos[1] + pPos[1], camPos[2] + pPos[2], ((camPos[0] * PLAYER_MOVE_SPEED) / totDist) / 46.0, ((camPos[1] * PLAYER_MOVE_SPEED) / totDist) / 46.0, 0.02132 + ((camPos[2] * PLAYER_MOVE_SPEED) / totDist) / 46.0)
						);
						SetPVarFloat(playerid, "pv_OldDist", 0x7F800000);
						break;
					}
					tmpPos[0] = camPos[0];
					tmpPos[1] = camPos[1];
					tmpPos[2] = camPos[2];
					tmpPos[3] = mapPos_Z;
					
					camPos[0] -= i * floatsin(-pAngle, degrees);
					camPos[1] -= i * floatcos(-pAngle, degrees);
					camPos[2] -= i * camVect_Z;
				}
			}
		}
	}
	return 1;
}

forward MovePlayer(playerid, Float: move_X, Float: move_Y, Float: move_Z, Float: speed_X, Float: speed_Y, Float: speed_Z); public MovePlayer(playerid, Float: move_X, Float: move_Y, Float: move_Z, Float: speed_X, Float: speed_Y, Float: speed_Z)
{
	static
		Float: pPos[3]
	;
	if(GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]))
	{
		static
			Float: distLeft
		;
		pPos[0] -= move_X;
		pPos[1] -= move_Y;
		pPos[2] -= move_Z;
		
		distLeft = floatpower((pPos[0] * pPos[0]) + (pPos[1] * pPos[1]) + (pPos[2] * pPos[2]), 0.5);
		
		if(GetPVarFloat(playerid, "pv_OldDist") < distLeft)
		{
			SetPlayerVelocity(playerid, 0.0, 0.0, 0.0);
			KillTimer(GetPVarInt(playerid, "pv_MoveTimer"));
			
			SetPVarInt(playerid, "pv_IsMoving", false);
		}
		else
		{
			static
				Float: mapPos_Z
			;
			pPos[0] += move_X;
			pPos[1] += move_Y;
			pPos[2] += move_Z;
			
			MapAndreas_FindZ_For2DCoord(pPos[0], pPos[1], mapPos_Z);	
			
			SetPlayerVelocity(playerid, speed_X, speed_Y, floatabs(pPos[2] - mapPos_Z) < 1.1 ? speed_Z + 0.05 : speed_Z);
			SetPVarFloat(playerid, "pv_OldDist", distLeft);
			
			ApplyAnimation(playerid, "SHOP", "SHP_Duck_Aim", 4.0, 0, 0, 0, 0, 0);
			SetPVarInt(playerid, "pv_IsMoving", true);
		}
	}
	return ;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/grapple", true))
	{
		SetPVarInt(playerid, "pv_GrappleEnabled", !GetPVarInt(playerid, "pv_GrappleEnabled"));
		
		switch(GetPVarInt(playerid, "pv_GrappleEnabled"))
		{
			case false:
			{
				SendClientMessage(playerid, -1, "» Grapple Hooking выключен.");
				SetPlayerAmmo(playerid, 23, 0);
			}
			case true:
			{
				SendClientMessage(playerid, -1, "» Grapple Hooking включен.");
				GivePlayerWeapon(playerid, 23, 0x7F800000);
			}
		}
		return 1;
	}
	return 0;
}

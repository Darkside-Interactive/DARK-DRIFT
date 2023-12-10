/*------------------------------------------------------------------------------
			######## ##        ######             ###     ######
			##       ##       ##    ##           ## ##   ##    ##
			##       ##       ##                ##   ##  ##
			######   ##       ##               ##     ## ##
			##       ##       ##               ######### ##
			##       ##       ##    ##         ##     ## ##    ##
			######## ########  ######  ####### ##     ##  ######


 							########  ##    ##
							##     ##  ##  ##
							##     ##   ####
							########     ##
							##     ##    ##
							##     ##    ##
							########     ##


		######## ##        #######   ######  ######## ########   #######
		##       ##       ##     ## ##    ##    ##    ##     ## ##     ##
		##       ##       ##     ## ##          ##    ##     ## ##     ##
		######   ##       ##     ## ##          ##    ########  ##     ##
		##       ##       ##     ## ##          ##    ##   ##   ##     ##
		##       ##       ##     ## ##    ##    ##    ##    ##  ##     ##
		######## ########  #######   ######     ##    ##     ##  #######

                             Anti-Cheat(ELC_AC)

                               PROTECTIONS :
                              Anti-Weapon HACK
                               Anti-Ammo HACK
                            Anti-Ammo Block HACK
                               Anti-Money HACK
                               Anti SpeedHack
				     	Anti Teleport & Anti Airbreak

                                    BUG :
                                  NOTHING

                                  VERSION :
							        V1.3

                                  CREDITS :
                              ELOCTRO (SCRIPT)
                         SIM (GetTickCount for linux)

				          ELC_AC THE BEST PROTECTION
		                              !

                                    \**/
/*/- Anti-Cheat By Eloctro -----------------------------------------------------

                            ELC PRODUCTION(FRANCE)

*/
#include <a_samp>
/*----------------------------------------------------------------------------*/
//Configuration :
#define MAX_SPEED_VEHICLE                380.0 // (380=default)
#define MAX_VEHICLE_DISTANCE_PER_SECOND  180   // DISTANCE PARCOUR MAX VEHICLE PER SECOND(180=default)
#define MAX_PED_DISTANCE_PER_SECOND      100   // DISTANCE PARCOUR MAX VEHICLE PER SECOND(180=default)
#define TIRE_RATE                        1400  // (1400=default)
#define SET_POS_RATE                     4     // RELOAD POSITION PER SECOND
#define TIMER_CHEAT_RATE                 2000  // (
#define SPRINT_SPEED                     30.0 // (0=DEFAULT/BETA)
#define TIME_GRANULITY                   50   // Granulity GetTickCount

//#define NO_TICK_COUNT  //uncomment If GetTickCount() bug(linux?)
#define INCLUDE_BASE_MODE //uncomment to pass in mod include

//Calcul(DON'T TOUCH)----------------------------------------------------------
#define XMAX_VEHICLE_DISTANCE_PER_SECOND MAX_VEHICLE_DISTANCE_PER_SECOND*(TIMER_CHEAT_RATE/1000)
#define XMAX_PED_DISTANCE_PER_SECOND MAX_PED_DISTANCE_PER_SECOND*(TIMER_CHEAT_RATE/1000)
#define XSET_POS_RATE SET_POS_RATE/(TIMER_CHEAT_RATE/1000)
/*----------------------------------------------------------------------------*/
enum aELCp
{
	aMoney,
	aAmmo[12],
	aWeapon[12],
	aTickFire,
	aAmmoFire,
	aWeaponFire,
	aTimer,
	Float:aX,
	Float:aY,
	Float:aZ,
	aAntiTeleportHack,
	aAntiWeaponHack,
	aAntiMoneyHack,
	aAntiSpeedHack,
	aLoadPosition
};
new CheatPlayerInfo[MAX_PLAYERS][aELCp];
#if defined NO_TICK_COUNT
enum aELCs
{
	TickCount,
	TimerTick
};
new CheatServerInfo[aELCs];
#endif
/*----------------------------------------------------------------------------*/
stock Float:GetPlayerSpeedXY(playerid)
{
new Float:SpeedX, Float:SpeedY, Float:SpeedZ;
new Float:Speed;
if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid), SpeedX, SpeedY, SpeedZ);
else GetPlayerVelocity(playerid, SpeedX, SpeedY, SpeedZ);
Speed = floatsqroot(floatadd(floatpower(SpeedX, 2.0), floatpower(SpeedY, 2.0)));
return floatmul(Speed, 200.0);
}
#if defined NO_TCIK_COUNT
	#define GetTickCount()                          (CheatServerInfo[TickCount])
	forward TimeUpdate();
	public TimeUpdate()
	{
		CheatServerInfo[TickCount] +=TIME_GRANULITY;
		return 1;
	}
#endif
forward OnPlayerCheckCheat(playerid);
forward OnPlayerCheat(playerid, cheatid);
forward ELC_AC_EnablePlayerCheatID(playerid,cheatid,enable);
/*----------------------------------------------------------------------------*/
forward ELC_AC_GivePlayerMoney(playerid, money);
public ELC_AC_GivePlayerMoney(playerid, money)
{
    if(CheatPlayerInfo[playerid][aAntiMoneyHack]==1)CheatPlayerInfo[playerid][aAntiMoneyHack]=2;
	CheatPlayerInfo[playerid][aMoney] = CheatPlayerInfo[playerid][aMoney] + money;
	GivePlayerMoney(playerid, money);
	if(CheatPlayerInfo[playerid][aAntiMoneyHack]==2)CheatPlayerInfo[playerid][aAntiMoneyHack]=1;
	return 1;
}
stock initial_GivePlayerMoney(playerid, money)
{
	return GivePlayerMoney(playerid, money);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney ELC_AC_GivePlayerMoney
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
forward ELC_AC_ResetPlayerMoney(playerid);
public ELC_AC_ResetPlayerMoney(playerid)
{
	CheatPlayerInfo[playerid][aMoney] = 0;
	return ResetPlayerMoney(playerid);
}
stock initial_ResetPlayerMoney(playerid)
{
	return ResetPlayerMoney(playerid);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_ResetPlayerMoney
    #undef ResetPlayerMoney
#else
    #define _ALS_ResetPlayerMoney
#endif
#define ResetPlayerMoney ELC_AC_ResetPlayerMoney
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
forward ELC_AC_GetPlayerMoney(playerid);
public ELC_AC_GetPlayerMoney(playerid)
{
	return CheatPlayerInfo[playerid][aMoney];
}
stock initial_GetPlayerMoney(playerid)
{
	return GetPlayerMoney(playerid);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_GetPlayerMoney
    #undef GetPlayerMoney
#else
    #define _ALS_GetPlayerMoney
#endif
#define GetPlayerMoney ELC_AC_GetPlayerMoney
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
forward ELC_AC_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz);
public ELC_AC_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz)
{
    if(CheatPlayerInfo[playerid][aAntiTeleportHack]==1)CheatPlayerInfo[playerid][aAntiTeleportHack]=2;
	CheatPlayerInfo[playerid][aLoadPosition]=XSET_POS_RATE;
	SetPlayerPos(playerid, ix, iy, iz);
    if(CheatPlayerInfo[playerid][aAntiTeleportHack]==2)CheatPlayerInfo[playerid][aAntiTeleportHack]=1;
	return 1;
}
stock initial_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz)
{
	return SetPlayerPos(playerid, ix, iy, iz);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_SetPlayerPos
    #undef SetPlayerPos
#else
    #define _ALS_SetPlayerPos
#endif
#define SetPlayerPos ELC_AC_SetPlayerPos
//ALS_OFF_SYSTEME ----------------
#endif
/*----------------------------------------------------------------------------*/
forward ELC_AC_PutPlayerInVehicle(playerid,vehicleid, seatid);
public ELC_AC_PutPlayerInVehicle(playerid,vehicleid, seatid)
{
    if(CheatPlayerInfo[playerid][aAntiTeleportHack]==1)CheatPlayerInfo[playerid][aAntiTeleportHack]=2;
	CheatPlayerInfo[playerid][aLoadPosition]=XSET_POS_RATE;
	PutPlayerInVehicle(playerid,vehicleid, seatid);
	if(CheatPlayerInfo[playerid][aAntiTeleportHack]==2)CheatPlayerInfo[playerid][aAntiTeleportHack]=1;
	return 1;
}
stock initial_PutPlayerInVehicle(playerid,vehicleid, seatid)
{
	return PutPlayerInVehicle(playerid,vehicleid, seatid);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_PutPlayerInVehicle
    #undef PutPlayerInVehicle
#else
    #define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle ELC_AC_PutPlayerInVehicle
//ALS_OFF_SYSTEME ----------------
#endif
/*----------------------------------------------------------------------------*/
forward ELC_AC_TogglePlayerSpectating(playerid, toggle);
public ELC_AC_TogglePlayerSpectating(playerid, toggle)
{
	if(toggle==1)
	{
		CheatPlayerInfo[playerid][aAntiTeleportHack]=0;
		CheatPlayerInfo[playerid][aAntiSpeedHack]=0;
	}
	else
	{
		CheatPlayerInfo[playerid][aAntiTeleportHack]=1;
		CheatPlayerInfo[playerid][aAntiSpeedHack]=1;
		CheatPlayerInfo[playerid][aLoadPosition]=XSET_POS_RATE;
	}
	return TogglePlayerSpectating(playerid, toggle);
}
stock initial_TogglePlayerSpectating(playerid, toggle)
{
	return TogglePlayerSpectating(playerid, toggle);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_TogglePlayerSpectating
    #undef TogglePlayerSpectating
#else
    #define _ALS_TogglePlayerSpectating
#endif
#define TogglePlayerSpectating ELC_AC_TogglePlayerSpectating
//ALS_OFF_SYSTEME ----------------
#endif
//Weapon------------------------------------------------------------------------
/*#define IsNotWeaponNoAmmo(%0) (%0!=0 && %0!=1 && %0!=10)
#define IsNotWeaponVise(%0,%1) (%0>1 && %0!=10 && %0!=6 && %0!=9 && %0!=11 && %0!=12 && %1!=35 && %1!=36 %1!=43)*/
stock IsNotWeaponNoAmmo(WeaponID)
{
	new slot=GetWeaponSlot(WeaponID);
	if(slot!=0 && slot!=1 && slot!=10)return 1;
	return 0;
}
stock IsNotWeaponVise(WeaponID)
{
	new slot=GetWeaponSlot(WeaponID);
	if(slot>1 && slot!=10 && slot!=6 && slot!=9 &&slot!=11 && slot!=12 && slot!=35 && slot!=36 && slot!=43) return 1;
	return 0;
}
stock IsGiveVehicleWeapon(WeaponID)
{
	if(WeaponID==25 || WeaponID==46 || WeaponID==2) return 1;
	return 0;
}
#define IsValidWeapon(%0) (%0>=1 && %0<=18 || %0>=21 && %0<=46)
stock GetWeaponSlot(weaponid)
{
	new slot;
	switch(weaponid)
	{
		case 0,1: slot = 0;
		case 2 .. 9: slot = 1;
		case 10 .. 15: slot = 10;
		case 16 .. 18, 39: slot = 8;
		case 22 .. 24: slot =2;
		case 25 .. 27: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6;
		case 35 .. 38: slot = 7;
		case 40: slot = 12;
		case 41 .. 43: slot = 9;
		case 44 .. 46: slot = 11;
	}
	return slot;
}
/*----------------------------------------------------------------------------*/
forward ELC_AC_GivePlayerWeapon(playerid,Weapon,ammo);
public ELC_AC_GivePlayerWeapon(playerid,Weapon,ammo)
{

	if(CheatPlayerInfo[playerid][aAntiWeaponHack]==1)CheatPlayerInfo[playerid][aAntiWeaponHack]=2;
	new slot=GetWeaponSlot(Weapon);
	if(IsValidWeapon(Weapon))
	{
		CheatPlayerInfo[playerid][aWeapon][slot]=Weapon;
		CheatPlayerInfo[playerid][aAmmo][slot]=ammo+CheatPlayerInfo[playerid][aAmmo][slot];
		GivePlayerWeapon(playerid,Weapon,ammo);
	}
	if(CheatPlayerInfo[playerid][aAntiWeaponHack]==2)CheatPlayerInfo[playerid][aAntiWeaponHack]=1;
    return 1;
}
stock initial_GivePlayerWeapon(playerid,Weapon,ammo)
{
	return GivePlayerWeapon(playerid,Weapon,ammo);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_GivePlayerWeapon
    #undef GivePlayerWeapon
#else
    #define _ALS_GivePlayerWeapon
#endif
#define GivePlayerWeapon ELC_AC_GivePlayerWeapon
//ALS_OFF_SYSTEME ----------------
#endif
/*----------------------------------------------------------------------------*/
forward ELC_AC_ResetPlayerWeapons(playerid);
public ELC_AC_ResetPlayerWeapons(playerid)
{
	if(CheatPlayerInfo[playerid][aAntiWeaponHack]==1)CheatPlayerInfo[playerid][aAntiWeaponHack]=2;
	for(new i = 0; i <12; i++)
	{
        CheatPlayerInfo[playerid][aWeapon][i]=0;
        CheatPlayerInfo[playerid][aAmmo][i]=0;
	}
	ResetPlayerWeapons(playerid);
	if(CheatPlayerInfo[playerid][aAntiWeaponHack]==2)CheatPlayerInfo[playerid][aAntiWeaponHack]=1;
    return 1;
}
stock initial_ResetPlayerWeapons(playerid)
{
	return ResetPlayerWeapons(playerid);
}
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_ResetPlayerWeapons
    #undef ResetPlayerWeapons
#else
    #define _ALS_ResetPlayerWeapons
#endif
#define ResetPlayerWeapons ELC_AC_ResetPlayerWeapons
//ALS_OFF_SYSTEME ----------------
#endif
//Core--------------------------------------------------------------------------
public OnPlayerCheckCheat(playerid)
{
	if(CheatPlayerInfo[playerid][aAntiMoneyHack]==1)
	{
		if(initial_GetPlayerMoney(playerid)!=CheatPlayerInfo[playerid][aMoney])
		{
			if (CheatPlayerInfo[playerid][aMoney] > initial_GetPlayerMoney(playerid))
			{
			    CheatPlayerInfo[playerid][aMoney]=initial_GetPlayerMoney(playerid);
			}
			else
			{
				initial_ResetPlayerMoney(playerid);
				initial_GivePlayerMoney(playerid, CheatPlayerInfo[playerid][aMoney]);
				CallRemoteFunction("OnPlayerCheat", "dd", playerid,1);
			}
		}
	}
	if(CheatPlayerInfo[playerid][aAntiSpeedHack]==1)
	{
		if(GetPlayerSurfingVehicleID(playerid)!=INVALID_VEHICLE_ID || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(GetPlayerSpeedXY(playerid) > MAX_SPEED_VEHICLE)
			{
				//Cheat Vitesse(Aibreak,SpeedHack)
				CallRemoteFunction("OnPlayerCheat", "dd", playerid,5);
			}
		}
	}
	if(CheatPlayerInfo[playerid][aAntiTeleportHack]==1)
	{
		if(CheatPlayerInfo[playerid][aLoadPosition]<=0)
		{
			if(GetPlayerSurfingVehicleID(playerid)!=INVALID_VEHICLE_ID || IsPlayerInAnyVehicle(playerid))
			{
				if(!IsPlayerInRangeOfPoint(playerid,XMAX_VEHICLE_DISTANCE_PER_SECOND,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]))
				{
					//Cheat Teleport
					CallRemoteFunction("OnPlayerCheat", "dd", playerid,6);
				}
			}
			else
			{
				if(!IsPlayerInRangeOfPoint(playerid,XMAX_PED_DISTANCE_PER_SECOND,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]))
				{
					//Cheat Teleport
					CallRemoteFunction("OnPlayerCheat", "dd", playerid,6);
				}
			}
		}
		else
		{
			CheatPlayerInfo[playerid][aLoadPosition]--;
		}
		GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);

	}
	if(CheatPlayerInfo[playerid][aAntiWeaponHack]==1)
	{

		//ANTI BLOCK MUNITIONS
		if(CheatPlayerInfo[playerid][aTickFire]!=0)
		{
			if((GetTickCount()-CheatPlayerInfo[playerid][aTickFire]) >= TIRE_RATE)
			{
				if(CheatPlayerInfo[playerid][aWeaponFire]==GetPlayerWeapon(playerid))
				{
					if(CheatPlayerInfo[playerid][aAmmoFire]==GetPlayerAmmo(playerid))
					{
						CallRemoteFunction("OnPlayerCheat", "dd", playerid,4);
						GivePlayerWeapon(playerid,CheatPlayerInfo[playerid][aWeaponFire],-CheatPlayerInfo[playerid][aAmmoFire]);
					}
					CheatPlayerInfo[playerid][aTickFire]=0;
					CheatPlayerInfo[playerid][aAmmoFire]=0;
					CheatPlayerInfo[playerid][aWeaponFire]=0;
				}
				else
				{

				    new keys,ud,lr;
				    GetPlayerKeys(playerid,keys,ud,lr);
					if(keys==4 && IsNotWeaponVise(GetPlayerWeapon(playerid)))
					{

						CheatPlayerInfo[playerid][aTickFire]=GetTickCount();
						CheatPlayerInfo[playerid][aAmmoFire]=GetPlayerAmmo(playerid);
						CheatPlayerInfo[playerid][aWeaponFire]=GetPlayerWeapon(playerid);
					}
					else if(keys==132 && IsNotWeaponNoAmmo(GetPlayerWeapon(playerid)) && (GetPlayerSpeedXY(playerid) < 1))
					{
						CheatPlayerInfo[playerid][aTickFire]=GetTickCount();
						CheatPlayerInfo[playerid][aAmmoFire]=GetPlayerAmmo(playerid);
						CheatPlayerInfo[playerid][aWeaponFire]=GetPlayerWeapon(playerid);
					}
				}
			}
		}
		new WA_VAR[2];
		for(new i = 0; i <12; i++)
		{
			GetPlayerWeaponData(playerid,i,WA_VAR[0],WA_VAR[1]);
			if((WA_VAR[0]!=CheatPlayerInfo[playerid][aWeapon][i] && WA_VAR[0]!=0))
			{
				//CHEAT WEAPON
				if(!IsGiveVehicleWeapon(WA_VAR[0])) CallRemoteFunction("OnPlayerCheat", "dd", playerid,2);
				ResetPlayerWeapons(playerid);
			}
			else if(((CheatPlayerInfo[playerid][aAmmo][i]-WA_VAR[1]) < 0) && IsNotWeaponNoAmmo(WA_VAR[0]) && WA_VAR[0]!=0)
			{
				//CHEAT AMMO
				CallRemoteFunction("OnPlayerCheat", "dd", playerid,3);
				ResetPlayerWeapons(playerid);
			}
			else if(CheatPlayerInfo[playerid][aWeapon][i]!=0 && WA_VAR[0]==0)
			{
			    CheatPlayerInfo[playerid][aWeapon][i]=0;
			    CheatPlayerInfo[playerid][aAmmo][i]=0;
			}
			else
			{
			    CheatPlayerInfo[playerid][aAmmo][i]=WA_VAR[1];
			}
		}
	}
	return 1;
}

/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
public OnGameModeInit()
#else
public OnFilterScriptInit()
#endif
{
    #if defined NO_TICK_COUNT
	CheatServerInfo[TimerTick]=SetTimer("TimeUpdate", TIME_GRANULITY, true);
	#endif
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnGameModeInit", "");
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ELC_AC_OnGameModeInit
forward ELC_AC_OnGameModeInit();
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
public OnGameModeExit()
#else
public OnFilterScriptExit()
#endif
{
	#if defined NO_TICK_COUNT
	KillTimer(CheatServerInfo[TimerTick]);
	#endif
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnGameModeExit", "");
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit ELC_AC_OnGameModeExit
forward ELC_AC_OnGameModeExit();
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public OnPlayerConnect(playerid)
{
	if (!IsPlayerNPC(playerid))
	{
		CheatPlayerInfo[playerid][aTickFire]=0;
		CheatPlayerInfo[playerid][aAmmoFire]=0;
		CheatPlayerInfo[playerid][aWeaponFire]=0;
		for(new i = 0; i <12; i++)
		{
			CheatPlayerInfo[playerid][aWeapon][i]=0;
			CheatPlayerInfo[playerid][aAmmo][i]=0;
		}
		CheatPlayerInfo[playerid][aLoadPosition]=0;
		CheatPlayerInfo[playerid][aMoney] = 0;
		CheatPlayerInfo[playerid][aTimer]=SetTimerEx("OnPlayerCheckCheat", TIMER_CHEAT_RATE, 1, "i", playerid);
		CheatPlayerInfo[playerid][aX] = 0; CheatPlayerInfo[playerid][aY] = 0; CheatPlayerInfo[playerid][aZ] = 0;
		CheatPlayerInfo[playerid][aAntiTeleportHack]=0;
		CheatPlayerInfo[playerid][aAntiWeaponHack]=1;
		CheatPlayerInfo[playerid][aAntiMoneyHack]=1;
		CheatPlayerInfo[playerid][aAntiSpeedHack]=0;
		SendClientMessage(playerid,0xBD0000FF,"[ANTI-CHEAT]Ce serveur est protégé par ELC_AC(By Eloctro)");
	}
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnPlayerConnect", "d", playerid);
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect ELC_AC_OnPlayerConnect
forward ELC_AC_OnPlayerConnect(playerid);
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public OnPlayerSpawn(playerid)
{
	if (!IsPlayerNPC(playerid))
	{
		GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
		CheatPlayerInfo[playerid][aLoadPosition]=2;
		CheatPlayerInfo[playerid][aAntiTeleportHack]=1;
		CheatPlayerInfo[playerid][aAntiSpeedHack]=1;
	}
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnPlayerSpawn", "d", playerid);
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn ELC_AC_OnPlayerSpawn
forward ELC_AC_OnPlayerSpawn(playerid);
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public OnPlayerDeath(playerid, killerid, reason)
{
	if (!IsPlayerNPC(playerid))
	{
		CheatPlayerInfo[playerid][aAntiTeleportHack]=0;
		CheatPlayerInfo[playerid][aAntiSpeedHack]=0;
	}
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnPlayerDeath", "ddd", playerid, killerid, reason);
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath ELC_AC_OnPlayerDeath
forward ELC_AC_OnPlayerDeath(playerid, killerid, reason);
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public OnPlayerDisconnect(playerid, reason)
{
	if (!IsPlayerNPC(playerid))
	{
		KillTimer(CheatPlayerInfo[playerid][aTimer]);
		CheatPlayerInfo[playerid][aTickFire]=0;
		CheatPlayerInfo[playerid][aAmmoFire]=0;
		CheatPlayerInfo[playerid][aWeaponFire]=0;
	}
	CheatPlayerInfo[playerid][aLoadPosition]=0;
	CheatPlayerInfo[playerid][aX] = 0; CheatPlayerInfo[playerid][aY] = 0; CheatPlayerInfo[playerid][aZ] = 0;
	CheatPlayerInfo[playerid][aAntiTeleportHack]=0;
	CheatPlayerInfo[playerid][aAntiWeaponHack]=0;
	CheatPlayerInfo[playerid][aAntiMoneyHack]=0;
	CheatPlayerInfo[playerid][aAntiSpeedHack]=0;
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnPlayerDisconnect", "dd", playerid, reason);
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect ELC_AC_OnPlayerDisconnect
forward ELC_AC_OnPlayerDisconnect(playerid, reason);
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		if(CheatPlayerInfo[playerid][aAntiWeaponHack]==1)
		{
			if(newkeys==4)
			{
				new Float:XPOS[3];
				GetPlayerPos(playerid,XPOS[0],XPOS[1],XPOS[2]);
				if(CheatPlayerInfo[playerid][aTickFire]==0 && IsNotWeaponVise(GetPlayerWeapon(playerid)) && CheatPlayerInfo[playerid][aZ]==XPOS[2])
				{

					CheatPlayerInfo[playerid][aTickFire]=GetTickCount();
					CheatPlayerInfo[playerid][aAmmoFire]=GetPlayerAmmo(playerid);
					CheatPlayerInfo[playerid][aWeaponFire]=GetPlayerWeapon(playerid);
				}
			}
			else if(newkeys==132)
			{
				if(CheatPlayerInfo[playerid][aTickFire]==0 && IsNotWeaponNoAmmo(GetPlayerWeapon(playerid)) && (GetPlayerSpeedXY(playerid) < 1))
				{
					CheatPlayerInfo[playerid][aTickFire]=GetTickCount();
					CheatPlayerInfo[playerid][aAmmoFire]=GetPlayerAmmo(playerid);
					CheatPlayerInfo[playerid][aWeaponFire]=GetPlayerWeapon(playerid);
				}
			}
			else if(oldkeys==4&&newkeys!=132 || oldkeys==132&&newkeys!=4)
			{
                if(CheatPlayerInfo[playerid][aTickFire]!=0)
                {
                    if((GetTickCount()-CheatPlayerInfo[playerid][aTickFire]) >= TIRE_RATE)
					{
						new Float:XPOS[3];
			            GetPlayerPos(playerid,XPOS[0],XPOS[1],XPOS[2]);
						if(CheatPlayerInfo[playerid][aZ]==XPOS[2] && CheatPlayerInfo[playerid][aWeaponFire]==GetPlayerWeapon(playerid)&& CheatPlayerInfo[playerid][aAmmoFire]==GetPlayerAmmo(playerid))
						{
		                    CallRemoteFunction("OnPlayerCheat", "dd", playerid,4);
						}
						CheatPlayerInfo[playerid][aTickFire]=0;
						CheatPlayerInfo[playerid][aAmmoFire]=0;
						CheatPlayerInfo[playerid][aWeaponFire]=0;
					}
                }
			}
		}
	}
	#if defined INCLUDE_BASE_MODE
	return CallLocalFunction("ELC_AC_OnPlayerKeyStateChange", "ddd",playerid, newkeys, oldkeys);
	#else
	return 1;
	#endif
}
/*----------------------------------------------------------------------------*/
#if defined INCLUDE_BASE_MODE
//ALS_SYSTEME --------------------
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange ELC_AC_OnPlayerKeyStateChange
forward ELC_AC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
//ALS_OFF_SYSTEME ----------------
/*----------------------------------------------------------------------------*/
public ELC_AC_EnablePlayerCheatID(playerid,cheatid,enable)
{
	if(cheatid==1)//Money
	{
		if(enable==1)
		{
			CheatPlayerInfo[playerid][aMoney]=initial_GetPlayerMoney(playerid);
			CheatPlayerInfo[playerid][aAntiMoneyHack]=1;
		}
		else CheatPlayerInfo[playerid][aAntiMoneyHack]=0;
	}
	else if(cheatid==2)//Weapon
	{
		if(enable==1)
		{
			for(new i = 0; i <12; i++)
			{
				GetPlayerWeaponData(playerid,i,CheatPlayerInfo[playerid][aWeapon][i],CheatPlayerInfo[playerid][aAmmo][i]);
			}
			CheatPlayerInfo[playerid][aAntiWeaponHack]=1;
		}
		else CheatPlayerInfo[playerid][aAntiWeaponHack]=0;
	}
	else if(cheatid==3)//AirBreak/SpeedHack
	{
		if(enable==1) CheatPlayerInfo[playerid][aAntiSpeedHack]=1;
		else CheatPlayerInfo[playerid][aAntiSpeedHack]=0;
	}
	else if(cheatid==4)//Anti-Teleport
	{
		if(enable==1)
		{
			GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
			CheatPlayerInfo[playerid][aAntiTeleportHack]=1;
		}
		else CheatPlayerInfo[playerid][aAntiTeleportHack]=0;
	}
	return 1;
}
/*----------------------------------------------------------------------------*/
#define EnablePlayerCheatID ELC_AC_EnablePlayerCheatID
/*----------------------------------------------------------------------------*/

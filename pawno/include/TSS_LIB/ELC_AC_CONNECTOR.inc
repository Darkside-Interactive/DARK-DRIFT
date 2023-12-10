/*------------------------------------------------------------------------------
                                    
                             Anti-Cheat(ELC_AC)
MODE CONNECTOR
VERSION : V1.3


                                    \**/
/*/- Anti-Cheat By Eloctro -----------------------------------------------------

*/
#include <a_samp>
#define GivePlayerMoney ELC_ACc_GivePlayerMoney
#define ResetPlayerMoney ELC_ACc_ResetPlayerMoney
#define GetPlayerMoney ELC_ACc_GetPlayerMoney
#define GivePlayerWeapon ELC_ACc_GivePlayerWeapon
#define ResetPlayerWeapons ELC_ACc_ResetPlayerWeapons
#define SetPlayerPos ELC_ACc_SetPlayerPos
#define PutPlayerInVehicle ELC_ACc_PutPlayerInVehicle
#define TogglePlayerSpectating ELC_ACc_TogglePlayerSpectating
forward OnPlayerCheat(playerid, cheatid);
/*----------------------------------------------------------------------------*/
forward ELC_ACc_GivePlayerMoney(playerid, money);
public ELC_ACc_GivePlayerMoney(playerid, money)
{
	return CallLocalFunction("ELC_AC_GivePlayerMoney", "dd",playerid, money);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_ResetPlayerMoney(playerid);
public ELC_ACc_ResetPlayerMoney(playerid)
{
	return CallLocalFunction("ELC_AC_ResetPlayerMoney", "d",playerid);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_GetPlayerMoney(playerid);
public ELC_ACc_GetPlayerMoney(playerid)
{
	return CallLocalFunction("ELC_AC_GetPlayerMoney", "d",playerid);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_GivePlayerWeapon(playerid,Weapon,ammo);
public ELC_ACc_GivePlayerWeapon(playerid,Weapon,ammo)
{
	return CallLocalFunction("ELC_AC_GivePlayerWeapon", "ddd",playerid,Weapon,ammo);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_ResetPlayerWeapons(playerid);
public ELC_ACc_ResetPlayerWeapons(playerid)
{
	return CallLocalFunction("ELC_AC_ResetPlayerWeapons", "d",playerid);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz);
public ELC_ACc_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz)
{
	return CallLocalFunction("ELC_AC_SetPlayerPos", "dfff",playerid, Float:ix, Float:iy, Float:iz);
}
/*----------------------------------------------------------------------------*/
forward ELC_ACc_PutPlayerInVehicle(playerid,vehicleid, seatid);
public ELC_ACc_PutPlayerInVehicle(playerid,vehicleid, seatid)
{
	return CallLocalFunction("ELC_AC_PutPlayerInVehicle", "ddd",playerid,vehicleid, seatid);
}
/*----------------------------------------------------------------------------*/
public ELC_ACc_TogglePlayerSpectating(playerid, toggle)
{
	return CallLocalFunction("ELC_AC_TogglePlayerSpectating", "dd",playerid, toggle);
}
/*----------------------------------------------------------------------------*/
forward EnablePlayerCheatID(playerid,cheatid,enable)
public EnablePlayerCheatID(playerid,cheatid,enable)
{
	return CallLocalFunction("ELC_AC_EnablePlayerCheatID", "ddd",playerid,cheatid,enable);
}
/*----------------------------------------------------------------------------*/

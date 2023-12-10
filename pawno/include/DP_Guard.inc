stock DP_AddVehicleComponent(vehicleid, componentid)
{
	CallRemoteFunction("DP_AddVehicleComponent", "dd", vehicleid, componentid);
	return AddVehicleComponent(vehicleid, componentid);
}

stock DP_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2)
{
	new VehicleID = AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
	CallRemoteFunction("DP_AddStaticVehicle", "dffff", VehicleID, spawn_x, spawn_y, spawn_z, z_angle);
	return VehicleID;
}

stock DP_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay)
{
	new VehicleID = AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2, respawn_delay);
	CallRemoteFunction("DP_AddStaticVehicleEx", "dffff", VehicleID, spawn_x, spawn_y, spawn_z, z_angle);
	return VehicleID;
}

stock DP_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
	new VehicleID = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
	CallRemoteFunction("DP_CreateVehicle", "dffff", VehicleID, x, y, z, rotation);
	return VehicleID;
}

stock DP_PlayerSpectatePlayer(playerid, targetplayerid, mode = SPECTATE_MODE_NORMAL) return CallRemoteFunction("DP_PlayerSpectatePlayer", "ddd", playerid, targetplayerid, mode);

stock DP_PlayerSpectateVehicle(playerid, targetvehicleid, mode = SPECTATE_MODE_NORMAL) return CallRemoteFunction("DP_PlayerSpectateVehicle", "ddd", playerid, targetvehicleid, mode);

stock DP_RemoveVehicleComponent(vehicleid, componentid) return CallRemoteFunction("DP_RemoveVehicleComponent", "dd", vehicleid, componentid);
stock DP_SetPlayerHealth(playerid, Float:health) return CallRemoteFunction("DP_SetPlayerHealth", "df", playerid, health);
stock DP_SetPlayerArmour(playerid, Float:armour) return CallRemoteFunction("DP_SetPlayerArmour", "df", playerid, armour);
stock DP_ResetPlayerWeapons(playerid) return CallRemoteFunction("DP_ResetPlayerWeapons", "d", playerid);
stock DP_GivePlayerWeapon(playerid, weaponid, ammo) return CallRemoteFunction("DP_GivePlayerWeapon", "ddd", playerid, weaponid, ammo);
stock DP_SetVehicleToRespawn(vehicleid) return CallRemoteFunction("DP_SetVehicleToRespawn", "d", vehicleid);
stock DP_SetPlayerPos(playerid, Float:x, Float:y, Float:z) return CallRemoteFunction("DP_SetPlayerPos", "dfff", playerid, x, y, z);
stock DP_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z) return CallRemoteFunction("DP_SetVehiclePos", "dfff", vehicleid, x, y, z);
stock DP_SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo) return CallRemoteFunction("DP_SetSpawnInfo", "dddffffdddddd", playerid, team, skin, x, y, z, Angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);

#define SetPlayerHealth DP_SetPlayerHealth
#define SetPlayerArmour DP_SetPlayerArmour
#define AddVehicleComponent DP_AddVehicleComponent
#define AddStaticVehicle DP_AddStaticVehicle
#define AddStaticVehicleEx DP_AddStaticVehicleEx
#define CreateVehicle DP_CreateVehicle
#define RemoveVehicleComponent DP_RemoveVehicleComponent
#define SetPlayerHealth DP_SetPlayerHealth
#define ResetPlayerWeapons DP_ResetPlayerWeapons
#define GivePlayerWeapon DP_GivePlayerWeapon
#define SetVehicleToRespawn DP_SetVehicleToRespawn
#define SetPlayerPos DP_SetPlayerPos
#define SetVehiclePos DP_SetVehiclePos
#define SetSpawnInfo DP_SetSpawnInfo
#define PlayerSpectatePlayer DP_PlayerSpectatePlayer
#define PlayerSpectateVehicle DP_PlayerSpectateVehicle
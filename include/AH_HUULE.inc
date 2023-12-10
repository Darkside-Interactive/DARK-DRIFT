

#include <a_samp>
#include <dini>

// -----------------------------------------------------------------------------------------------------------------------------------------------------

//#include "../include/gl_spawns.inc" // spawn locations

// -----------------------------------------------------------------------------------------------------------------------------------------------------
// Settings
#define AC_WEAPONHACK                   1
#define AC_MONEYHACK                    1
#define AC_TELEPORTHACK                 1
#define AC_SPEEDHACK                    1
#define AC_HEALTHHACK                   1
#define AC_ARMOURHACK                   1
#define AC_VEHICLEHEALTHHACK    		1
#define AC_FAKEKILLHACK                 1
#define AC_AIRBREAKHACK                 1
#define AC_CARSPAWNHACK         		1

#define MAX_SPEED_INCREASE      40 // maximum of 40 increasable per check (if more then the user is airbreaking)
#define MIN_FORBIDDEN_SPEED     20 // minimum speed the player must be driving in a forbidden vehicle for anticheat to trigger

new szServerFile[32]                    = "server\\info.ini"; // server info file
new iForbiddenWeapons[]                 = { 8, 16, 18, 35, 36, 37, 38, 39 }; // forbidden weapon IDs
new iForbiddenVehicles[]                 = { 417, 425, 432, 447, 469, 487, 488, 497, 548, 563, 460, 476, 511, 512, 513, 519, 520, 533, 577, 592, 593 }; // forbidden vehicle IDs

// -----------------------------------------------------------------------------------------------------------------------------------------------------
// Colors
#define COLOR_DARKRED                   0xAA3333AA
#define COLOR_PINK                              0xFF66FFAA
#define COLOR_GREY                              0xAFAFAFAA

// -----------------------------------------------------------------------------------------------------------------------------------------------------

#define WEAPON_HACK                     0
#define MONEY_HACK                      1
#define TELEPORT_HACK                   2
#define SPEED_HACK                              3
#define HEALTH_HACK             4
#define ARMOUR_HACK             5
#define VEHICLEHEALTH_HACK      6
#define FAKEKILL_HACK           7
#define AIRBREAK_HACK           8
#define CARSPAWN_HACK           9

// -----------------------------------------------------------------------------------------------------------------------------------------------------

new ServerCash[MAX_PLAYERS] = 0; // sever sided cash (read from ini)
new ClientCash[MAX_PLAYERS] = 0; // client cash
new Difference[MAX_PLAYERS] = 0;
new PlayerSelecting[MAX_PLAYERS] = 0; // is the player selecting a skin?

new tmrAntiCheat_01, tmrAntiCheat_02;

new Float:fOldPos[MAX_PLAYERS][3]; // holds the latest position of the players
new Float:fCurrentPos[MAX_PLAYERS][3]; // holds the current position of the players
new PlayerUsedVehicle[MAX_PLAYERS]; // setting it through the loop, gives us some delay when the player jumps off at high speed

// -----------------------------------------------------------------------------------------------------------------------------------------------------

public OnFilterScriptInit()
{
print("\n- DCAntiCheat Script by Decysen\n");

tmrAntiCheat_01 = SetTimer("DCAntiCheat_Thread01", 100, true);
tmrAntiCheat_02 = SetTimer("DCAntiCheat_Thread02", 2000, true); // position checks (airbreak and such)

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

public OnFilterScriptExit()
{
print("\n-- DCAntiCheat Script by Decysen -> cleanup ...\n");

KillTimer(tmrAntiCheat_01);
KillTimer(tmrAntiCheat_02);

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------
forward OnPlayerRequestClassEx(playerid, classid);
public OnPlayerRequestClassEx(playerid, classid)
{
if(!PlayerSelecting[playerid])
PlayerSelecting[playerid] = 1; // selecting a class

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------
forward OnPlayerSpawnEx(playerid);
public OnPlayerSpawnEx(playerid)
{
if(PlayerSelecting[playerid])
PlayerSelecting[playerid] = 0; // no longer selecting a class

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

stock Float:GetPlayerSpeedXY(playerid)
{
new Float:SpeedX, Float:SpeedY, Float:SpeedZ;
new Float:SpeedeX;

if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid), SpeedX, SpeedY, SpeedZ);
else GetPlayerVelocity(playerid, SpeedX, SpeedY, SpeedZ);

SpeedeX = floatsqroot(floatadd(floatpower(SpeedX, 2.0), floatpower(SpeedY, 2.0)));

return floatmul(SpeedeX, 200.0);
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

forward PlayerHasMoved(playerid);
public PlayerHasMoved(playerid)
{
if(fCurrentPos[playerid][0] == fOldPos[playerid][0] &&
fCurrentPos[playerid][1] == fOldPos[playerid][1] &&
fCurrentPos[playerid][2] == fOldPos[playerid][2])
return 0;

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

HandlePlayer_Message(playerid)
{
new Name[MAX_PLAYER_NAME+1];
new string[128];

GetPlayerName(playerid, Name, sizeof(Name));

dini_IntSet(szServerFile, "anticheat_killed", (dini_Int(szServerFile, "anticheat_killed") + 1));

format(string, sizeof(string), "%s (%d) Has Been Killed By DC Anticheat. %s Cheaters Killed.", Name, playerid, dini_Get(szServerFile, "anticheat_killed"));
SendClientMessageToAll(COLOR_DARKRED, string);

format(string, sizeof(string), "* %s (%d) Has Left The Server. (Kicked)", Name, playerid);
SendClientMessage(playerid, COLOR_GREY, string);
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

HandlePlayer(playerid, reason)
{
new Name[MAX_PLAYER_NAME+1];
new string[128];

ResetPlayerWeapons(playerid);
ResetPlayerMoney(playerid);

SetPlayerInterior(playerid, 6);
SetPlayerFacingAngle(playerid, 260);
GetPlayerName(playerid, Name, sizeof(Name));
SetPlayerPos(playerid , 264.2752, 81.9539, 1001.0391);

switch(reason) {
case WEAPON_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Weapon Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Weapon Hack");
}
case MONEY_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Money Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Money Hack");
}
case TELEPORT_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Teleport Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Teleport Hack");
}
case SPEED_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (SpeedeX Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "SpeedeX Hack");
}
case HEALTH_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Health Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Health Hack");
}
case ARMOUR_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Armour Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Armour Hack");
}
case VEHICLEHEALTH_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Vehicle Health Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Vehicle Health Hack");
}
case FAKEKILL_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Fake-kill Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Fake-kill Hack");
}
case AIRBREAK_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Airbreak Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Airbreak Hack");
}
case CARSPAWN_HACK: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected! (Car Spawn Hack)", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Car Spawn Hack");
}
default: {
format(string, sizeof(string), "***BAN: %s (%d) (DC ANTICHEAT)  Cheats Detected!", Name, playerid);
SendClientMessageToAll(COLOR_PINK, string);

HandlePlayer_Message(playerid);
BanEx(playerid, "Unknown Hack");
}
}
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

forward DCAntiCheat_Thread01();
public DCAntiCheat_Thread01()
{
new Weapons[13][2];
new Name[MAX_PLAYER_NAME+1];
new szPlayerFile[128];

for (new i = 0; i < MAX_PLAYERS; i++) {
if(!IsPlayerConnected(i) || IsPlayerAdmin(i) || PlayerSelecting[i])
continue;

#if defined AC_WEAPONHACK
// Weapon hack
for (new y = 0; y < 13; y++) {
GetPlayerWeaponData(i, y, Weapons[y][0], Weapons[y][1]);

for (new x = 0; x < sizeof(iForbiddenWeapons); x++) {
if(Weapons[y][0] == iForbiddenWeapons[x]) {
		HandlePlayer(i, WEAPON_HACK);
		break;
}
}
}

if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK) {
HandlePlayer(i, WEAPON_HACK);
break;
}
#endif

#if defined AC_TELEPORTHACK
// Teleport hack
new iPlayerInterior = GetPlayerInterior(i);

if(iPlayerInterior > 3 && iPlayerInterior != 15) {
HandlePlayer(i, TELEPORT_HACK);
break;
}
#endif

#if defined AC_MONEYHACK
// Money hack
GetPlayerName(i, Name, sizeof(Name));
format(szPlayerFile, sizeof(szPlayerFile), "%s.ini", Name);

ServerCash[i] = dini_Int(szPlayerFile, "money");
ClientCash[i] = GetPlayerMoney(i);
Difference[i] = ClientCash[i] - ServerCash[i];

if(Difference[i] > 5000) {
HandlePlayer(i, MONEY_HACK);
break;
}
#endif

// Health and armour hack
#if defined AC_HEALTHHACK
new Float:PlayerHealth;
GetPlayerHealth(i, PlayerHealth);

if(PlayerHealth > 100) { HandlePlayer(i, HEALTH_HACK); break; }
#endif

#if defined AC_ARMOURHACK
new Float:PlayerArmour;
GetPlayerArmour(i, PlayerArmour);

if(PlayerArmour > 100) { HandlePlayer(i, ARMOUR_HACK); break; }
#endif

// SpeedeX hack (on foot & vehicle) and vehicle health hack
new Float:VehicleHealth;

if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER) {
#if defined AC_VEHICLEHEALTHHACK
GetVehicleHealth(GetPlayerVehicleID(i), VehicleHealth);

// Vehicle health hack
if(VehicleHealth > 1000.0) {
HandlePlayer(i, VEHICLEHEALTH_HACK);
break;
}
#endif

#if defined AC_SPEEDHACK
// SpeedeX hack
if(GetPlayerSpeedXY(i) > 260.0) {
HandlePlayer(i, SPEED_HACK);
break;
}
#endif
}
}
return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------

forward DCAntiCheat_Thread02();
public DCAntiCheat_Thread02()
{
#if defined AC_AIRBREAKHACK
for (new i = 0; i < MAX_PLAYERS; i++) {
if(!IsPlayerConnected(i) || IsPlayerAdmin(i) || PlayerSelecting[i])
continue;

// Airbreak Detection (On foot only because of planes)
if(!IsPlayerInAnyVehicle(i) && GetPlayerState(i) != PLAYER_STATE_DRIVER) {
// Airbreak detection (on foot only)
GetPlayerPos(i, fCurrentPos[i][0], fCurrentPos[i][1], fCurrentPos[i][2]);

// No need to check if the old pos hasn't been stored for the first time yet or when a player is close to a spawn
if(!fOldPos[i][0] && !fOldPos[i][1] && !fOldPos[i][2]) {
GetPlayerPos(i, fOldPos[i][0], fOldPos[i][1], fOldPos[i][2]);
continue;
}

// No need to check if the player hasn't moved
if(!PlayerHasMoved(i))
continue;

// SpeedeX difference on foot
new Float:fPosDiff_X = fCurrentPos[i][0] - fOldPos[i][0];
new Float:fPosDiff_Y = fCurrentPos[i][1] - fOldPos[i][1];
new Float:fPosDiff_Z = fCurrentPos[i][2] - fOldPos[i][2];

// Save new position
GetPlayerPos(i, fOldPos[i][0], fOldPos[i][1], fOldPos[i][2]);

// SpeedeX checks
if(fPosDiff_X >= MAX_SPEED_INCREASE || fPosDiff_X <= -MAX_SPEED_INCREASE ||
fPosDiff_Y >= MAX_SPEED_INCREASE || fPosDiff_Y <= -MAX_SPEED_INCREASE ||
fPosDiff_Z >= MAX_SPEED_INCREASE || fPosDiff_Z <= -MAX_SPEED_INCREASE) {

HandlePlayer(i, AIRBREAK_HACK);
break;
}
}
}
#endif
return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------
forward OnPlayerUpdateEx(playerid);
public OnPlayerUpdateEx(playerid)
{
if(IsPlayerInAnyVehicle(playerid)) {
#if defined AC_AIRBREAKHACK
if(!PlayerUsedVehicle[playerid])
PlayerUsedVehicle[playerid] = 1;
#endif

#if defined AC_CARSPAWNHACK
// Exclude admins
if(IsPlayerAdmin(playerid) && !PlayerSelecting[playerid])
return 1;

// Remove player from forbidden vehicles, if they are already driving it at a certain speed they will be banned
for (new x = 0; x < sizeof(iForbiddenVehicles); x++) {
if(GetVehicleModel(GetPlayerVehicleID(playerid)) == iForbiddenVehicles[x]) {
// Check whether the player is already driving it
if(GetPlayerSpeedXY(playerid) >= MIN_FORBIDDEN_SPEED) {
HandlePlayer(playerid, CARSPAWN_HACK);
break;
} else {
RemovePlayerFromVehicle(playerid);
GameTextForPlayer(playerid, "~r~Players can not use this vehicle!", 3000, 3);
break;
}
}
}
#endif
} else {
#if defined AC_AIRBREAKHACK
if(PlayerUsedVehicle[playerid]) {
PlayerUsedVehicle[playerid] = 0;

// Update position for player when he gets out
GetPlayerPos(playerid, fOldPos[playerid][0], fOldPos[playerid][1], fOldPos[playerid][2]);
}

// Save new current position to check if it differs from the old
GetPlayerPos(playerid, fCurrentPos[playerid][0], fCurrentPos[playerid][1], fCurrentPos[playerid][2]);

// No need to check if the player hasn't moved
if(!PlayerHasMoved(playerid))
return 1;

// We are near a spawn, we set the position for the first time so it does not get detected as airbreak
// We make sure the player moves away from the old position before we save the coordinates again
if(!IsPlayerInRangeOfPoint(playerid, 5.0, fOldPos[playerid][0], fOldPos[playerid][1], fOldPos[playerid][2]))
GetPlayerPos(playerid, fOldPos[playerid][0], fOldPos[playerid][1], fOldPos[playerid][2]);
#endif
}

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------
forward OnPlayerDeathEx(playerid, killerid, reason);
public OnPlayerDeathEx(playerid, killerid, reason)
{
if(!reason)
return 1;

#if defined AC_FAKEKILLHACK
// Anti Fake-Kill
if(killerid == INVALID_PLAYER_ID)
return 1;

if(!IsPlayerStreamedIn(playerid, killerid)) { // Check if the players can actually see eachother
if(GetPlayerWeapon(killerid) != reason) { // Does the killer actually have the weapon?
HandlePlayer(killerid, FAKEKILL_HACK); // Nope, banz.
return 1;
}
}
#endif

return 1;
}

// -----------------------------------------------------------------------------------------------------------------------------------------------------
forward public OnPlayerDisconnectEx(playerid, reason);
public OnPlayerDisconnectEx(playerid, reason)
{
ServerCash[playerid] = 0;
ClientCash[playerid] = 0;
Difference[playerid] = 0;
PlayerSelecting[playerid] = 0;

fCurrentPos[playerid][0] = 0;
fCurrentPos[playerid][1] = 0;
fCurrentPos[playerid][2] = 0;

fOldPos[playerid][0] = 0;
fOldPos[playerid][1] = 0;
fOldPos[playerid][2] = 0;

PlayerUsedVehicle[playerid] = 0;

return 1;
}


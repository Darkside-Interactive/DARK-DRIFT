//
// Created: 05.11.06
// Aurthor: Iain Gilbert
//

#if defined _admin_commands_dm_included
#endinput
#endif

#define _admin_commands_dm_included
#pragma library admin_commands_dm
#include "base"
#include "utils\gtoutils"
#include "player"
#include "account"
#include "deathmatch"

forward AdminDMCommandHandler(playerid,text[]);

new PlayerDMEdit[MAX_PLAYERS]=INVALID_DM_ID; // will hold id of dm a player is currently creating
public AdminDMCommandHandler(playerid,text[]) // process player commands
{
if (!IsPlayerConnected(playerid)) return 0;
if (!IsPlayerAdmin(playerid))
{
PlayerDMEdit[playerid]=INVALID_DM_ID;
return 0;
}

new cmd[20];
new idx;
set(cmd,strcharsplit(text, idx,strchar(" ")));

if(strcomp(cmd, "/dm", true) == 1)
{
set(cmd,strcharsplit(text, idx,strchar(" ")));

if(strcomp(cmd, "start", true) == 1)
{

new dmid;
dmid = strval(strcharsplit(text, idx,strchar(" ")));

if ((dmid == 0) || (dmid >= MAX_DM))
{
SendPlayerFormattedText(playerid, lang_texts[541] , 0,COLOUR_RED);
return 1;
}
if (DeathmatchStats[dmid][dm_state] == DM_STATE_DISABLED)
{
SendPlayerFormattedText(playerid, lang_texts[542] , 0,COLOUR_RED);
return 1;
}
if (DeathmatchStats[dmid][dm_state] == DM_STATE_ACTIVE)
{
SendPlayerFormattedText(playerid, lang_texts[543] , 0,COLOUR_RED);
return 1;
}
if (DeathmatchStats[dmid][dm_state] == DM_STATE_LINEUP)
{
DeathmatchStats[dmid][dm_timer] = 0;
StartDMCountdown(dmid);
return 1;
}
if (DeathmatchStats[dmid][dm_state] == DM_STATE_SLEEPING)
{
DeathmatchStats[dmid][dm_timer] = 0;
StartDMLineup(dmid);
return 1;
}
return 1;
}
}
return 0;
}






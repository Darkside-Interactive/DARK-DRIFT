//
// Created: 04.11.06
// Aurthor: Iain Gilbert
//

#if defined _admin_commands_race_included
#endinput
#endif

#define _admin_commands_race_included
#pragma library admin_commands_race
#include "base"
#include "utils\gtoutils"
#include "player"
#include "account"
#include "race"

forward AdminRaceCommandHandler(playerid,text[]);

new PlayerRaceEdit[MAX_PLAYERS]=INVALID_RACE_ID; // will hold id of race a player is currently creating
public AdminRaceCommandHandler(playerid,text[]) // process player commands
{
if (!IsPlayerConnected(playerid)) return 0;
if (!IsPlayerAdmin(playerid))
{
PlayerRaceEdit[playerid]=INVALID_RACE_ID;
return 0;
}

new cmd[20];
new idx;
set(cmd,strcharsplit(text, idx,strchar(" ")));

if(strcomp(cmd, "/race", true) == 1)
{
set(cmd,strcharsplit(text, idx,strchar(" ")));
if(strcomp(cmd, "create", true) == 1)
{
new racename[MAX_NAME];
set(racename,text);
strdel(racename, 0, idx);
if (strlen(racename) <3)
{
SendPlayerFormattedText(playerid,  lang_texts[544] , 0,COLOUR_RED);
return 1;
}
if (strlen(racename) >40)
{
SendPlayerFormattedText(playerid,  lang_texts[545] , 0,COLOUR_RED);
return 1;
}

new tempname[MAX_STRING];
set(tempname,racename);
if (!StringCharCheck(tempname))
{
SendPlayerFormattedText(playerid,  lang_texts[546] , 0,COLOUR_RED);
return 1;
}

new raceid = RegisterRace(racename);
if (raceid == INVALID_RACE_ID)
{
SendPlayerFormattedText(playerid,  lang_texts[547] , 0,COLOUR_RED);
return 1;
}

// ok we good to go

PlayerRaceEdit[playerid] = raceid;
Race[raceid][race_startheading] = 0.0;
RaceSize[raceid] = 0;
//StartHeading[raceid] = GetPlayerHeading(playerid);
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid,x,y,z);
AddRaceCP(raceid,x,y,z);
SendPlayerFormattedText(playerid,  lang_texts[548] , 0,COLOUR_GREEN);
SendPlayerFormattedText(playerid,  lang_texts[549] , 0,COLOUR_MISC);
SendPlayerFormattedText(playerid,  lang_texts[550] , 0,COLOUR_MISC);
SendPlayerFormattedText(playerid,  lang_texts[551] , 0,COLOUR_MISC);
SendPlayerFormattedText(playerid,  lang_texts[552] , 0,COLOUR_MISC);

return 1;
}

if(strcomp(cmd, "cp", true) == 1)
{
if (PlayerRaceEdit[playerid] == INVALID_RACE_ID)
{
SendPlayerFormattedText(playerid,  lang_texts[553] , 0,COLOUR_RED);
return 1;
}
new raceid = PlayerRaceEdit[playerid];
if (RaceStats[raceid][race_state] != RACE_STATE_DISABLED)
{
SendPlayerFormattedText(playerid,  lang_texts[554] , 0,COLOUR_RED);
return 1;
}

// ok, all good
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid,x,y,z);
AddRaceCP(raceid,x,y,z);
SendPlayerFormattedText(playerid,  lang_texts[555] , 0,COLOUR_GREEN);
return 1;
}

if(strcomp(cmd, "cpremove", true) == 1)
{
if (PlayerRaceEdit[playerid] == INVALID_RACE_ID)
{
SendPlayerFormattedText(playerid,  lang_texts[556] , 0,COLOUR_RED);
return 1;
}
new raceid = PlayerRaceEdit[playerid];
if (RaceStats[raceid][race_state] != RACE_STATE_DISABLED)
{
SendPlayerFormattedText(playerid,  lang_texts[557] , 0,COLOUR_RED);
return 1;
}

// ok, all good
new Float:x, Float:y, Float:z;
GetPlayerPos(playerid,x,y,z);
RemoveLastRaceCP(raceid);
SendPlayerFormattedText(playerid,  lang_texts[558] , 0,COLOUR_GREEN);
return 1;
}

if(strcomp(cmd, "save", true) == 1)
{
if (PlayerRaceEdit[playerid] == INVALID_RACE_ID)
{
SendPlayerFormattedText(playerid,  lang_texts[559] , 0,COLOUR_RED);
return 1;
}
new raceid = PlayerRaceEdit[playerid];
if (RaceStats[raceid][race_state] != RACE_STATE_DISABLED)
{
SendPlayerFormattedText(playerid,  lang_texts[560] , 0,COLOUR_RED);
return 1;
}

// ok, all good

// set default values
Race[raceid][race_frequency] = 5;
Race[raceid][race_lineupdelay] = 45;
Race[raceid][race_minracers] = 1;
Race[raceid][race_minlevel] = 0;
Race[raceid][race_cashprize] = 2000;
Race[raceid][race_cashentry] = 100;
Race[raceid][race_xpprize] = 1000;
Race[raceid][race_xpbonus] = 200;
Race[raceid][race_maxracetime] = 300;
RaceStats[raceid][race_state] = RACE_STATE_SLEEPING;
RaceSaveBaseDB(raceid);
PlayerRaceEdit[playerid] = INVALID_RACE_ID;
RaceStats[raceid][race_timer] = 5;

SendPlayerFormattedText(playerid,  lang_texts[561] , 0,COLOUR_GREEN);
return 1;
}

if(strcomp(cmd, "start", true) == 1)
{

new raceid;
raceid = strval(strcharsplit(text, idx,strchar(" ")));

if ((raceid == 0) || (raceid >= MAX_RACES))
{
SendPlayerFormattedText(playerid, lang_texts[562] , 0,COLOUR_RED);
return 1;
}
if (RaceStats[raceid][race_state] == RACE_STATE_DISABLED)
{
SendPlayerFormattedText(playerid, lang_texts[563] , 0,COLOUR_RED);
return 1;
}
if (RaceStats[raceid][race_state] == RACE_STATE_RACING)
{
SendPlayerFormattedText(playerid, lang_texts[564] , 0,COLOUR_RED);
return 1;
}
if (RaceStats[raceid][race_state] == RACE_STATE_LINEUP)
{
RaceStats[raceid][race_timer] = 0;
StartRaceCountdown(raceid);
return 1;
}
if (RaceStats[raceid][race_state] == RACE_STATE_SLEEPING)
{
RaceStats[raceid][race_timer] = 0;
StartRaceLineup(raceid);
return 1;
}
return 1;
}
}
return 0;
}






//
// Created:     05.09.06
// Aurthor:    Iain Gilbert
//

#if defined _base_included
  #endinput
#endif

#define _base_included
#pragma library base

#include <a_samp>
#include <core>
#include <float>
#include "utils\dini"

//#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#pragma tabsize 0

#define VERSION "Street Life"
#define VERSIONNAME "Copyright 2009"

#define MAX_STRING 255
#define MAX_NAME MAX_PLAYER_NAME
#define INACTIVE_PLAYER_ID 255
#define INVALID_QUEST_ID 0
#define MAX_QUESTS 255
#define MAX_WIN 500000 // Maximum gambling win
#define MAX_SPAWNPOINTS 50
#define MAX_COUNTDOWN 5

#define COLOUR_GREY 0xAFAFAFAA // grey
#define COLOUR_GREEN 0x33AA33AA // green
#define COLOUR_LIGHTGREEN 0x9ACD32AA //lightgreen
#define COLOUR_RED 0xFF3333AA // red
#define COLOUR_LIGHTRED 0xFF6347AA // lightred
#define COLOUR_YELLOW 0xFFFF00AA // yellow
#define COLOUR_WHITE 0xFFFFFFAA // white
#define COLOUR_BLUE 0x33AAFFAA // blue
#define COLOUR_LIGHTBLUE 0x33CCFFAA // LightBlue
#define COLOUR_ORANGE 0xFF9900AA //orange
#define COLOUR_PURPLE 0xC2A2DAAA //purple

#define COLOUR_CRIMSON 0xDC143CAA
#define COLOUR_LIMEGREEN 0x32CD32AA
#define COLOUR_AQUA 0x00FFFFAA
#define COLOUR_FLBLUE 0x6495EDAA
#define COLOUR_MAGENTA 0xFF00FFFF
#define COLOUR_GOLD 0xB8860BAA
#define COLOUR_PINK 0xFFC0CBAA

// TODO: more colours
#define COLOUR_MISC 0xAFAFAFAA // Grey - Misc
#define COLOUR_CHAT 0xFFFFFFAA // White - Chat
#define COLOUR_PLAYER 0xAAAAAAAA // White - Player
#define COLOUR_XP_GOOD 0x00C7FFAA // Blue - XP
#define COLOUR_XP_BAD 0x00008BAA // Blue - XP
#define COLOUR_COMBAT_GOOD 0xAA3333AA // Red - Combat
#define COLOUR_COMBAT_BAD 0xBB3333AA // Red - Combat
#define COLOUR_MONEY_GOOD 0xFFFF00AA // Yellow - Money
#define COLOUR_MONEY_BAD 0xDAA520AA // Yellow - Money
#define COLOUR_RACE 0x00F6C3F6 // green - dark
#define COLOUR_RACE_BAD 0x00F6C3F6 // yellow-green-dark
#define COLOUR_GANG 0xFF8C00AA // orange
#define COLOUR_GANG_CHAT 0xFFA500AA // orange
#define COLOUR_DM 0x5C5CF6F6 // red - purple
#define COLOUR_DM_BAD 0x9A0057F6 // red - purple




#define MIN_HEALTH 20
#define MAX_HEALTH 100
#define NUMVALUES 4	

new ConfigDB[MAX_STRING] = "GTO/Config/GTO.Config.Base.txt";
new LevelDB[MAX_STRING] = "GTO/Config/GTO.Config.Levels.txt";
new MOTDDB[MAX_STRING] = "GTO/Config/GTO.MOTD.txt";
new SecurityDB[MAX_STRING] = "GTO/Config/GTO.Security.txt";
new BansDB[MAX_STRING] = "GTO/Bans.txt";
new Verbose_Save=-1; // do we save extra un-needed db info like weapons, races, vehicels, deathmatches, etc
new ForceOverwrite = 0;


// xyz coord info
enum CoordInfo {
    Float:Coord_X,
    Float:Coord_Y,
    Float:Coord_Z
}
new PlayerPos[MAX_PLAYERS][CoordInfo];

new KickList[MAX_PLAYERS];
new DBSeperator= 124; // seperate db fields.atm for db writing im just sending a string, which is written to a file.
new nullstr[MAX_STRING];

enum LevelInfo {
	level_xp,
    	level_name[MAX_STRING]
}
#define MAX_LEVEL 51
#define MAX_XP  50000000
#define MAX_LVLXP 45000000


// level rank names by Baby Face / Cool
new LevelList[MAX_LEVEL+1][LevelInfo] = { // experience required for each level
{  0,		"Newcomer" },
{  500,		"Player" },
{  1000,	"Smoker" },
{  2000,	"Drunkard" },
{  5000,	"Drug addict" },
{  10000,	"Captain" },
{  20000,	"Street criminal" },
{  30000,	"Proud Soldier" },
{  45000,	"Горды Лейтенант" },
{  60000,	"Proud Lieutenant" },
{  80000,	"Maniac" },
{  100000,	"Maniac murderer" },
{  125000,	"General" },
{  150000,	"General colonel" },
{  175000,	"General lieutenant" },
{  200000,	"Mega player" },
{  235000,	"Generalissimo" },
{  270000,	"Main leader" },
{  310000,	"Body Guard" },
{  350000,	"Left muzhik" },
{  400000, 	"Right muzhik" },
{  500000,	"Father" },
{  600000,	"Meneger of LS" },
{  700000,	"Meneger of SF" },
{  800000,	"Meneger of LV" },
{  900000, 	"President of SA" },

{ 1000000,  "Leader of the Parliament" },
{ 2000000,	"Prizident Africas" },
{ 3000000,	"Prezident Azii" },
{ 4000000,	"Prezident Americi" },
{ 5000000,	"President of Europe" },

{ 6000000,	"Main all over the world" },
{ 7000000,	"Minister Planets Land" },
{ 9000000,	"Rescuer of the galaxy" },
{10000000,	"Owner of the galaxy" },
{11000000,	"Real PizzaBoy" },

{12000000,	"Minister of The Planet" }, // 36
{13000000,	"The Savior of The World" }, // 37
{14000000,	"Cool Fan GTA" }, // 38
{15000000,	"Mego Killer" }, // 39
{16000000,	"The Subjugator of Ladies Hearts" }, // 40

{17000000,	"Warrior" }, // 41
{18000000,	"Captain" }, // 42
{19000000,	"Komandor" }, // 43
{20000000,	"Chieftain" }, // 44
{21000000,	"1st Star General" }, // 45

{23000000,	"2st Star General" }, // 46
{25000000,	"3rd Star General" }, // 47
{28000000,	"4th Star General" }, // 48
{31000000,	"5st Star General" }, // 49
{34000000,	"Admin of the world" }, // 50
{40000000,	"Server Owner" } // 51
};



forward Base_OnGameModeInit();

public Base_OnGameModeInit(){
	UsePlayerPedAnims();
	AllowAdminTeleport(1);
//	SetDisabledWeapons(21,43,35,36,38,44,45);
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	BaseConfig();
	return 0;
}

BaseConfig(){
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);
	if (!dini_Exists(LevelDB)) dini_Create(LevelDB);
	if (!dini_Exists(BansDB)) dini_Create(BansDB);
	if (!dini_Exists(MOTDDB)) dini_Create(MOTDDB);
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	new temp[MAX_STRING];

	set(temp,dini_Get(ConfigDB,"Verbose_Save"));
	if (strlen(temp) > 0) Verbose_Save = strval(temp);
	else { valstr(temp,Verbose_Save); dini_Set(ConfigDB,"Verbose_Save",temp);  }
	set(temp,nullstr);

	for (new i=0;i<=MAX_LEVEL;i++)
	{
		new tempname[MAX_STRING];
		format(tempname,sizeof(tempname),"Level%d_Rankname",i);
		set(temp,dini_Get(LevelDB,tempname));
		if (strlen(temp) > 0) set(LevelList[i][level_name],temp);
		else {
//			set(temp,LevelList[i][level_name]);
//			dini_Set(LevelDB,"Level%d_Rankname",temp);
			dini_Set(LevelDB,tempname,LevelList[i][level_name]);
			}
		set(temp,nullstr);
		
		format(tempname,sizeof(tempname),"Level%d_Experience",i);
		set(temp,dini_Get(LevelDB,tempname));
		if (strlen(temp) > 0) LevelList[i][level_xp] = strval(temp);
		else {
//			set(temp,LevelList[i][level_xp]);
			valstr(temp,LevelList[i][level_xp]);
//			dini_Set(LevelDB,"Level%d_Experience",temp);
			dini_Set(LevelDB,tempname,temp);
			}
		set(temp,nullstr);
	}

	return 0;
}

GetLevelName(level)
{
	new name[MAX_STRING];
	if ( (level < 0) || (level > MAX_LEVEL+1 ) ) return name;
	set(name,LevelList[level][level_name]);
	return name;
}


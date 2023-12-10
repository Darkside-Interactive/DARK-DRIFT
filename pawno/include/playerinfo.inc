#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>
#include <a_players>
#include <player>

forward PHSincTime();
forward PHOnPlayerDeath(playerid);
forward PHInit(playerid);

new Text:PHHelper[MAX_PLAYERS];

//-------------------------------

public PHSincTime()
{
	for (new i;i<MAX_PLAYERS;i++)
	{
	if (!IsPlayerConnected(i)) continue;
//	new string[MAX_STRING];
//	format(string,sizeof(string), "Состояние спавна: %d, просмотра: %d" ,Player[i][Spawn],Player[i][StatShow]);
//	SendPlayerFormattedText(i, string, 0,COLOUR_XP_GOOD);

	TextDrawHideForPlayer(i,PHHelper[i]);
	if (Player[i][Spawn]>0 && Player[i][StatShow]==1)
		{
		PHInit(i);
		TextDrawShowForPlayer(i,PHHelper[i]);
//		SendPlayerFormattedText(i, "Стата отображение", 0,COLOUR_XP_GOOD);
		}
	}
}

public PHOnPlayerDeath(playerid)
{
//if (!IsPlayerConnected(playerid)) {return 0;}
TextDrawHideForPlayer(playerid,PHHelper[playerid]);
//PHHelper[playerid]="not";
return 1;
}

public PHInit(playerid)
{
    if (!IsPlayerConnected(playerid)) {return 0;}
    // Init our text display
    new string[450];
    new string1[MAX_STRING];
    new string2[MAX_STRING];

    new PHp=Player[playerid][Status];
    new PHstr[10]=" ";
    new PHstr2[10]=" ";

//	if (PHp==0) {PHstr=" ";}
	if (PHp>0 && PHp<10) {PHstr="~g~Mod.";}
	if (PHp>10) {PHstr="~b~Adm.";}
	if (IsPlayerAdmin(playerid)) {PHstr2="~r~RCON";}




    format(string2, sizeof(string2),  "~n~~g~DH ~w~%d, ~g~KL ~w~%d, ~g~JL ~w~%d/%d, ~g~MT ~w~%d", Player[playerid][Deaths], Player[playerid][Kills], Player[playerid][Jaileds], Player[playerid][JailTime], Player[playerid][Muted]);

    format(string1, sizeof(string1),  "~n~~g~CB ~w~%d ~g~OYS ~w~0 ~g~HS ~w~0", Player[playerid][CB]);

    format(string, sizeof(string),  "~g~%s ~w~%d:%d %s %s~n~~g~LVL ~w~%d:%s~n~~g~XP ~w~%d:+%d~n~~g~MON ~w~%d:~w~%d%s%s", oGetPlayerName(playerid), playerid, PlayerCount(), PHstr, PHstr2, Player[playerid][Level], GetLevelName(Player[playerid][Level]), Player[playerid][XP], GetXPToLevel(playerid, Player[playerid][Level] + 1), Player[playerid][Money], Player[playerid][Bank], string1, string2);

    PHHelper[playerid] = TextDrawCreate(150.0, 350.0, string);
    TextDrawSetString(PHHelper[playerid], string);
    TextDrawUseBox(PHHelper[playerid], 0);
    TextDrawFont(PHHelper[playerid], 2);
    TextDrawLetterSize(PHHelper[playerid], 0.4, 0.9);
    TextDrawSetShadow(PHHelper[playerid],0); // no shadow
    TextDrawSetOutline(PHHelper[playerid],1); // thickness 1
    TextDrawBackgroundColor(PHHelper[playerid],0x000000FF);
    TextDrawColor(PHHelper[playerid],0xFFFFFFFF);
    TextDrawAlignment(PHHelper[playerid],0); // align right
return 1;
}


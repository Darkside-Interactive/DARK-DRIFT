//MOTD Message module
//Created by MadCat
//Idea from FreeRoam 2.4c by ProRail

#include "base"

forward MOTD_OnGameModeInit();
forward MOTD_OnPlayerConnect(playerid);
forward LoadMOTD();

new MOTD_Line1[MAX_STRING] = "Быстро здороваться/прощаться с игроками - /ky,/bb";
new MOTD_Color[MAX_STRING] = "0xFFFF00AA";

public MOTD_OnGameModeInit(){
	LoadMOTD();
	WriteLog("MOTD loaded");
	return 0;
}

public LoadMOTD()
{
}

public MOTD_OnPlayerConnect(playerid)
{
	Debug("motd.inc > MOTD_OnPlayerConnect - Start");
	new color = HexToInt(MOTD_Color);
	if (strlen(MOTD_Line1)) SendClientMessage(playerid,color,MOTD_Line1);
	Debug("motd.inc > MOTD_OnPlayerConnect - Stop");
}

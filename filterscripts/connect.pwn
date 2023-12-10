// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
    new message22[500],ip22[50];
    GetPlayerName(playerid, message22, sizeof(message22));GetPlayerIp(playerid,ip22, sizeof(ip22));
    format(message22,sizeof(message22), "{00FF33}{0000FF} Щ{00FF33}%s{0000FF}Щ {00FF00}[ID: %d] {FFF700}«ашел(а) на сервер {FFFFFF}[IP:%s]{FFFFFF}", message22, playerid, ip22);
    SendClientMessageToAll(0xAFAFAFAA, message22);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
#endif

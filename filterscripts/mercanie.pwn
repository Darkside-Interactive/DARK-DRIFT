#define FILTERSCRIPT

#include <a_samp>

#if defined FILTERSCRIPT

forward MSeconds();
new Glow[MAX_PLAYERS];
new MSecondsTimer;
new GlowColor;

new GlowColors[37] = {
0xFF0000FF,
0xFF4E00FF,
0xFF7E00FF,
0xFFA800FF,
0xFFC000FF,
0xFFD800FF,
0xFFF600FF,
0xEAFF00FF,
0xD2FF00FF,
0x9CFF00FF,
0x3CFF00FF,
0x00FF2AFF,
0x00FF90FF,
0x00FFBAFF,
0x00FFF0FF,
0x00F6FFFF,
0x00C6FFFF,
0x00BAFFFF,
0x0096FFFF,
0x0084FFFF,
0x006CFFFF,
0x004EFFFF,
0x003CFFFF,
0x0000FFFF,
0x1200FFFF,
0x3600FFFF,
0x4E00FFFF,
0x6C00FFFF,
0x8A00FFFF,
0xA800FFFF,
0xC000FFFF,
0xDE00FFFF,
0xFF00F6FF,
0xFF00A8FF,
0xFF007EFF,
0xFF0066FF,
0xFF0036FF
};

public OnFilterScriptInit()
{
	print("\n---------------------------");
	print(" GLOW РАБОТАЕТ\n");
	print(" by БУРГЕР\n");
	MSecondsTimer = SetTimer("MSeconds", 100, 1);
	return 1;
}

public OnFilterScriptExit()
{
    KillTimer(MSecondsTimer);
	return 1;
}

//#else

public OnPlayerConnect(playerid)
{
    Glow[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public MSeconds()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(Glow[i]==1)
		{
			GlowColor = GlowColor+1;
        	if(GlowColor==36)
			{
				GlowColor=0;
			}
        	SetPlayerColor(i,GlowColors[GlowColor]);
		}
	}
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/gl", true))
	{
	    if(Glow[playerid] == 0)
	    {
			Glow[playerid] = 1;
			SendClientMessage(playerid,0xFF0036FF, "* Мигание ника включено");
    		return 1;
		}
		else if(Glow[playerid] == 1)
		{
			Glow[playerid] = 0;
			SendClientMessage(playerid,0xFF0036FF, "* Мигание ника отключено");
			return 1;
		}
	}
	if(!strcmp(cmdtext, "/gketriogkeosfdff", true))
    {
        SendClientMessage(playerid, 0x00C6FFFF, "HELP: /gl - [включить/отключить мигание]");
        return 1;
    }
	return 0;
}

#endif

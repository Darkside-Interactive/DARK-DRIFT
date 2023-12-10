//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
//CREDITS
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
//This Anti-DOS was developed for use against attacks on your SAMP server
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
//Developed by: Dark_net_by_adrian_lamo
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更

#include <a_samp>
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Variables
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
const   Menu:@INVALID_MENU = Menu:INVALID_MENU;
#undef  INVALID_MENU
#define INVALID_MENU @INVALID_MENU
#define MAX_MESSAGES 3000 // Maximum number of notifications!
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti-Pinger
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
forward CheckPing (playerid);
#define DIALOG_PINGKICKER (1000)
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
//#define MAX_IP 3
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
#define MAX_PING (250) // Maximum ping 250 ! You can change it!)
#define PING_CHECK_TIME (6) // 6 seconds
#define MAX_PING_WARNINGS (3)
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti-Pinger
new
	pl_PingWarnings [MAX_PLAYERS] = 0,
	pl_PingResults [MAX_PING_WARNINGS] = 0,
	pl_PingChecked [MAX_PLAYERS] = 0,
	pl_PingTimer [MAX_PLAYERS] = -1;
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// New s
new antifakekill[MAX_PLAYERS];
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Forwards
forward AntiFakeKill(playerid);
forward NetworkUpdate();
forward CheckPing(playerid);
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// =============== Anti-PizDos Bot ===============
public OnFilterScriptInit()
{
	print("\n-------------------------------------------");
	print("* AntiDoS - Successfully uploaded *");
	print("-------------------------------------------\n");
	return 1;
}
// =============== Anti FakeKill ===============
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
public OnPlayerDeath(playerid, killerid, reason)
{
    antifakekill[playerid] ++;
    SetTimerEx("antifakekill", 1000,false,"i",playerid);
    return 1;
}
public AntiFakeKill(playerid)
{
    antifakekill[playerid] --;
    if(antifakekill[playerid] > 5)
    {
        SendClientMessage(playerid, 0xFF0000AA, "You were kicked on suspicion of FakeKill");
        Kick(playerid);
        print("[!] FakeKill was blocked [!]");
    }
    return 1;
}
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti-Pinger
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch( dialogid )
	{
		case DIALOG_PINGKICKER:
		{
			SendClientMessage(playerid, -1, "Come back when you've fixed your Internet connection!");
			Kick (playerid);
		}
	}
	return 1;
}
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti- camp
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
public OnPlayerExitedMenu(playerid)
{
    if(playerid == INVALID_PLAYER_ID) return Kick(playerid);
    print("[!] Lager was blocked [!]");
    new Menu:current = GetPlayerMenu(playerid);
    if(GetPlayerMenu(playerid) == INVALID_MENU) return Kick(playerid);
    HideMenuForPlayer(current,playerid);
    return TogglePlayerControllable(playerid,true);
}
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti- DDoS packages
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
public NetworkUpdate()
{
	new stats[300], idx, pos, msgs;
	for(new i; i<MAX_PLAYERS; i++)
	{
       if(IsPlayerConnected(i))
       {
          idx = 0;
	      GetPlayerNetworkStats(i, stats, sizeof(stats));
	      pos = strfind(stats, "Messages received: ", false, 209);
	      msgs = strval(strtok(stats[pos+19], idx));
	      new OtherMessages[MAX_PLAYERS]; // New
	      new MessagesCount[MAX_PLAYERS]; // New
	      if(msgs - MessagesCount[i] - OtherMessages[i] > MAX_MESSAGES && msgs > 2000)
	      {
             print("[!] Was blocked by flood packages! [!]");
             BanEx(i, "You have been blocked for flooding packets!");
          }
	      MessagesCount[i] = msgs;
	      OtherMessages[i] = 0;
       }
    }
}
stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
// Anti-Pinger
//更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更更
public CheckPing(playerid)
{
	new
		pl_Ping = GetPlayerPing (playerid);

	if( pl_Ping > MAX_PING )
	{
		new
			string [128];

		pl_PingWarnings [playerid] ++;
		pl_PingResults [ pl_PingChecked[playerid] ] = pl_Ping;

		format(string, sizeof(string), "Check your Internet connection (Ping: %d)", pl_Ping );
		SendClientMessage(playerid, -1, string );
	}

	if( pl_PingChecked [playerid] >= MAX_PING_WARNINGS )
	{
		KillTimer (pl_PingTimer [playerid]);
	}

	if( pl_PingWarnings [playerid] >= MAX_PING_WARNINGS )
	{
		new
			string [128],
			dstring [256];

		format(string, sizeof(string), "You were kicked for a high ping! -\n\nYou had a big ping:\n");
		strcat(dstring, string);

		for( new i; i < MAX_PING_WARNINGS; i ++ )
		{
			format(string, sizeof(string), "* %d\n", pl_PingResults [i]);
			strcat(dstring, string);
		}

		ShowPlayerDialog(playerid, DIALOG_PINGKICKER, DIALOG_STYLE_MSGBOX, "You are violating the server rules (Ping)", dstring, "OK", "");
		TogglePlayerControllable(playerid, false);
	}

	pl_PingChecked [playerid] ++;
	return 1;
}
public OnPlayerConnect (playerid)
{
    pl_PingTimer [playerid] = SetTimerEx ( "CheckPing", PING_CHECK_TIME * 1000, true, "i", playerid );
/*    new connect_ip[32+1];
    GetPlayerIp(playerid,connect_ip,32);
    new num_ip = GetNumberOfPlayersOnThisIP(connect_ip);
    if(num_ip > MAX_IP)
    {
   //Kick(playerid);
    Ban(playerid);
*/
	return 1;
}


/*
stock GetNumberOfPlayersOnThisIP(test_ip[])
      {
     new against_ip[32+1];
      new x = 0;
     new ip_count = 0;
            for(x=0; x<MAX_PLAYERS; x++) {
     if(IsPlayerConnected(x)) {
       GetPlayerIp(x,against_ip,32);
     if(!strcmp(against_ip,test_ip)) ip_count++;
    }
  }
 return ip_count;
}
*/

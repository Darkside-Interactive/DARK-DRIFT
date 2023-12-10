/*
Created April 28th 2008 by =>Sandra<=
Adapted, recompilled, upgrade: 2008 07 02 by FP (aka SCALOlaz)
*/

#if defined _cashbox_included
  #endinput
#endif

#define _cashbox_included
#pragma library cashbox

#include <a_samp>
#include <a_players>
#include <player>

#define CashboxModel 1210
#define MinCashboxValue 80000
#define MaxCashboxValue 900000
#define ValuedropPerSecond 4

new CashBox_Enabled = 1;
new CashBoxGameTimer = 750000;
new CashBoxTime;
//new CashboxValueTime;
new MaxCashBoxTime = 750;
new CashBoxMaxPlayers = 2;

new CashBoxUseTextdraw = 1;	//Отключить показ ТекстДрава

//new h1 = 4;
//new h2 = 43;
//new h3 = 48;
//new h4 = 53;
new CashboxPickup;
new CashboxPickupOff;
//new CashboxPickup2;
//new CashboxObject;
//new CashboxObject2;
new CashboxOwner = INVALID_PLAYER_ID;
new CashboxValue;
new Float:CashboxX;
new Float:CashboxY;
new Float:CashboxZ;
new IsGameStartedCB;
new DropValueTimer;
new Text:ValueText;
new IsTextdrawCreated;
//new vps = ValuedropPerSecond;
//new mode = DifficultyMode;
new IsCashboxPickedUp;
new StartNewCBGame;

new Float:DropLocation[3] =
//{1677.1796,1447.8167,10.7823};
{1755.331298,-1927.888183,13.575839};

new Float:CashboxLocations[][3] =
{
{1936.288940,-851.478820,117.488861},
{2244.214355,-878.726013,104.831542},
{2631.651367,-839.918334,73.631683},
{2366.205566,-736.817016,128.628112},
{1930.777954,-636.857421,74.065757},
{1535.150024,-645.333679,86.069305},
{-103.123481,-1583.325317,2.617187},
{-76.401123,-1408.940307,2.704990},
{10.747440,-1238.481079,6.501829},
{137.769500,-1047.075195,54.528717},
{471.446533,-901.036071,31.962133},
{600.837646,-826.505371,74.706314},
{756.834411,-785.588562,58.866840},
{1041.580932,-711.789855,119.953002},
{1358.710083,-626.368408,109.127883},
{1486.456787,-1241.263305,14.421894},
{1556.026611,-853.505493,69.618530},
{1398.541381,-805.932739,77.252517},
{1251.097167,-1505.110229,10.054012},
{1165.619262,-1663.886108,22.234439},
{1217.322265,-1921.220825,31.260675},
{1182.231079,-2228.315185,38.637313},
{1269.793701,-2354.182617,11.436545},
{1002.779724,-2121.234375,13.093750},
{822.015075,-2062.858154,12.867187},
{851.391052,-1687.633544,14.952098},
{873.426879,-1504.772827,12.888350},
{1095.825805,-1428.786376,22.771490},
{988.340576,-1345.322387,16.666362},
{1097.659301,-1292.671142,17.046875},
{1133.258789,-1083.322631,25.907583},
{1122.614624,-1004.077819,29.863193},
{1142.320190,-853.302124,43.431854},
{931.411987,-930.258605,42.601562},
{815.059631,-1100.722656,25.789438},
{928.571350,-1253.506469,15.828446},
{706.194580,-1474.434326,5.468750},
{694.954833,-1686.716674,4.346122},
{674.367065,-1866.941406,5.460937},
{563.218200,-1549.702758,15.651779},
{576.497192,-1344.857177,21.929687},
{727.662963,-1275.821411,13.648437},
{418.214996,-1297.956665,15.019110},
{476.163208,-1504.717529,20.601634},
{413.777648,-1511.503784,31.590595},
{459.844268,-1505.458129,31.008245},
{427.147644,-1610.663696,34.171875},
{202.849655,-1426.678100,13.193929},
{163.445617,-1677.463623,14.650461},
{149.215057,-1957.734375,3.773437},
{396.985260,-2058.397460,7.835937},
{379.931121,-1880.186035,2.604305},
{698.945007,-1370.357543,29.018598},
{810.494567,-1340.229980,22.549976},
{812.186340,-1359.125610,-0.507812},
{1521.929931,-1011.663391,24.032093},
{1623.182983,-1186.982421,41.981094},
{1757.734130,-1350.334716,15.609375},
{1894.356811,-1070.063232,23.937500},
{2265.612792,-1096.355224,42.648437},
{2513.942382,-956.924865,82.316390},
{2598.390380,-1132.000000,55.601085},
{2789.285400,-1078.122680,30.718750},
{2837.079833,-1149.196899,13.502174},
{2820.840820,-1319.174682,34.033374},
{2703.943603,-1276.448486,57.889194},
{2775.635742,-2532.271972,16.224384},
{2504.916503,-2640.388671,13.862256},
{2506.127685,-2412.318847,17.882808},
{2400.438720,-2291.707519,6.062500},
{2531.840576,-2253.658203,3.000000},
{2310.009521,-2387.423095,3.000000},
{2940.052246,-2051.108642,3.548043},
{2743.325195,-1944.316040,17.320312},
{2654.994628,-1954.973632,13.546875},
{2551.364013,-1731.340209,6.242187},
{2463.553710,-1341.578735,27.409505},
{2291.758789,-1090.311157,26.890625},
{2216.572753,-1179.719116,29.797086},
{91.442924,-1478.599487,12.435089},
{293.908477,-1107.369873,82.424057},
{484.978454,-1118.491088,82.359375},
{741.022949,-1018.254516,52.737854},
{1586.469238,-2663.613525,6.112976},
{2078.696533,-2543.109619,13.546875},
{1448.241088,-2287.262451,13.546875},
{1679.973266,-898.058044,53.689704}

};

forward CashBox_OnGameModeInit();
public CashBox_OnGameModeInit(){
	CashBox_Config();
	if (CashBox_Enabled == 1) {
	CreateStreamMapIcon( 16, 1755.331298,-1927.888183,13.575839);
	StartNewCBGame = SetTimer("StartNewCashboxGame", 1000, 1);
	WriteLog("XP+CashBox Game Started");
//	return 1;
	}
}

forward CashBox_Config();
public CashBox_Config()
{
	if (!dini_Exists(ConfigDB)) return;

	new temp[MAX_STRING];

	set(temp,dini_Get(ConfigDB,"CashBox_Enabled"));
	if (strlen(temp) > 0) CashBox_Enabled = strval(temp); 
	else { valstr(temp,CashBox_Enabled); dini_Set(ConfigDB,"CashBox_Enabled",temp); }

	set(temp,nullstr);	
	set(temp,dini_Get(ConfigDB,"CashBoxGameTimer"));
	if (strlen(temp) > 0) CashBoxGameTimer = strval(temp); 
	else { valstr(temp,CashBoxGameTimer); dini_Set(ConfigDB,"CashBoxGameTimer",temp); }
	
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"MaxCashBoxTime"));
	if (strlen(temp) > 0) MaxCashBoxTime = strval(temp); 
	else { valstr(temp,MaxCashBoxTime); dini_Set(ConfigDB,"MaxCashBoxTime",temp);  }

	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"CashBoxMaxPlayers"));
	if (strlen(temp) > 0) CashBoxMaxPlayers = strval(temp); 
	else { valstr(temp,CashBoxMaxPlayers); dini_Set(ConfigDB,"CashBoxMaxPlayers",temp);  }

	if (CashBoxMaxPlayers<1 || CashBoxMaxPlayers>MAX_PLAYERS) CashBoxMaxPlayers=1;

	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"CashBoxUseTextdraw"));
	if (strlen(temp) > 0) CashBoxUseTextdraw = strval(temp); 
	else { valstr(temp,CashBoxUseTextdraw); dini_Set(ConfigDB,"CashBoxUseTextdraw",temp);  }


}

forward CashBoxDestroyPickups();
public CashBoxDestroyPickups()
{
    DestroyPickup(CashboxPickup);
    DestroyPickup(CashboxPickupOff);
//    DestroyPickup(CashboxPickup2);
//    DestroyObject(CashboxObject);
//    DestroyObject(CashboxObject2);

	if(IsTextdrawCreated == 1)
	{
		TextDrawHideForAll(ValueText);
		TextDrawDestroy(ValueText);
		IsTextdrawCreated = 0;
	}
	return 1;
}




forward CashBoxGameMessage(playerid);
public CashBoxGameMessage(playerid)
{
	if( (IsGameStartedCB == 1) && (IsCashboxPickedUp == 0) )
	{
	new str[128];
	format(str, 128, lang_texts[689], CashboxValue, GetXYZZoneName(CashboxX, CashboxY, CashboxZ));
	SendClientMessage(playerid,COLOUR_YELLOW, str);
	format(str, 128, lang_texts[690], ValuedropPerSecond);
	SendClientMessage(playerid,COLOUR_YELLOW, str);
	SendClientMessage(playerid,COLOUR_WHITE, lang_texts[691]);
	SendClientMessage(playerid,0x0E68CAA, lang_texts[692]);
	}
	return 1;
}


//  0x0E68CAA - голубоватый цвет



forward CashBoxOnPlayerDisconnect(playerid);
public CashBoxOnPlayerDisconnect(playerid)
{
	if(playerid == CashboxOwner)
	{
	CashBoxDestroyPickups();
	
	new str[128];
	GetPlayerPos(playerid, CashboxX, CashboxY, CashboxZ);
	format(str, 128, lang_texts[693],oGetPlayerName(playerid), playerid);
	SendClientMessageToAll(COLOUR_YELLOW, str);
	CashboxPickup = CreatePickup(1210, 3, CashboxX, CashboxY, CashboxZ);
//        CashboxPickup2 = CreatePickup(1318, 3, CashboxX, CashboxY, CashboxZ+h1);
//	CashboxObject = CreateObject(354, CashboxX, CashboxY, CashboxZ+h2, 0.0, 0.0, 0.0);
//	CashboxObject2 = CreateObject(354, CashboxX, CashboxY, CashboxZ+h3, 0.0, 0.0, 0.0);

	IsCashboxPickedUp=0;
	CashboxOwner = INVALID_PLAYER_ID;
	}
return 1;
}

forward CashBoxOnPlayerDeath(playerid);
public CashBoxOnPlayerDeath(playerid)
{
	if(playerid == CashboxOwner)
	{
	CashBoxDestroyPickups();

	new str[128];
	GetPlayerPos(playerid, CashboxX, CashboxY, CashboxZ);
	format(str, 128, lang_texts[694], oGetPlayerName(playerid), playerid);
	SendClientMessageToAll(COLOUR_YELLOW, str);
	CashboxPickup = CreatePickup(1210, 3, CashboxX, CashboxY, CashboxZ);
//        CashboxPickup2 = CreatePickup(1318, 3, CashboxX, CashboxY, CashboxZ+h1);
//	CashboxObject = CreateObject(354, CashboxX, CashboxY, CashboxZ+h2, 0.0, 0.0, 0.0);
//	CashboxObject2 = CreateObject(354, CashboxX, CashboxY, CashboxZ+h3, 0.0, 0.0, 0.0);

	IsCashboxPickedUp=0;
	CashboxOwner = INVALID_PLAYER_ID;
	}
return 1;
}

forward CashBoxOnPlayerCommandText(playerid, cmdtext[]);
public CashBoxOnPlayerCommandText(playerid, cmdtext[])
{
	if( (strcmp(cmdtext, "/boxstop", true) == 0) && IsPlayerAdmin(playerid) )
	{
 	KillTimer(DropValueTimer);
	CashBoxDestroyPickups();

	IsGameStartedCB = 0;
	KillTimer(StartNewCBGame);
//	SetTimer("StartNewCashboxGame", CashBoxGameTimer, 0);
	SendClientMessageToAll(COLOUR_LIGHTRED, lang_texts[695]);
   	print("[CashBox]: End Game. By Admin Command");
	CashBox_Enabled=0;
	return 1;
	}

	if(( strcmp(cmdtext, "/boxstart", true)==0) && IsPlayerAdmin(playerid) )
	{
	if (IsGameStartedCB == 0)
		{
		StartNewCashboxGame();
//		StartNewCBGame = SetTimer("StartNewCashboxGame", 1000, 0);
        	SendClientMessageToAll(COLOUR_LIGHTRED, lang_texts[696]);
   		print("[CashBox]: Start New Game. By Admin Command");
		CashBox_Enabled=1;
        	}
        return 1;
	}
	
	if(strcmp(cmdtext, "/box", true)==0)
	{
	if (CashBox_Enabled==0) return 0;
        if(IsCashboxPickedUp == 1 || IsGameStartedCB == 0)
	        {
	        new str[128];
		format(str, 128, lang_texts[697]);
	        SendClientMessage(playerid, COLOUR_LIGHTRED, str);
		} else {
			new randX = -130+random(300);
			new randY = -130+random(300);
			SetPlayerCameraPos(playerid, CashboxX+randX, CashboxY+randY, (CashboxZ+80));
			SetPlayerCameraLookAt(playerid, CashboxX, CashboxY, CashboxZ);
		        TogglePlayerControllable(playerid, 0);
		        SetTimerEx("ResetCam", 10000, 0, "i", playerid);
			}
	return 1;
	}
	
	if(strcmp(cmdtext, "/boxlom", true)==0)
	{
	if (CashBox_Enabled==0) return 0;
	new randX = -130+random(300);
	new randY = -130+random(300);
	SetPlayerCameraPos(playerid, DropLocation[0]+randX, DropLocation[1]+randY, DropLocation[2]+80);
	SetPlayerCameraLookAt(playerid, DropLocation[0], DropLocation[1], DropLocation[2]);
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("ResetCam", 10000, 0, "i", playerid);
	return 1;
	}

/*    if(strcmp(cmd, "/boxgo", true)==1)
	{
	    SetPlayerPos(playerid, 2227.74, 1516.43, 10.82);
		return 1;
	}
*/
	return 0;
}

forward CashBoxOnPlayerPickUpPickup(playerid, pickupid);
public CashBoxOnPlayerPickUpPickup(playerid, pickupid)
{
	if (CashBox_Enabled==0) return 0;
	if(pickupid == CashboxPickup  && IsPlayerInCircle(playerid, CashboxX, CashboxY,3))
	{
	    PlaySoundForPlayer(playerid, 1150);
	    new str[128];
	    DestroyPickup(CashboxPickup);
// 	    DestroyPickup(CashboxPickup2);
// 	    DestroyObject(CashboxObject);
// 	    DestroyObject(CashboxObject2);
	    IsCashboxPickedUp = 1;
		CashboxOwner = playerid;
		format(str, 128, lang_texts[698], oGetPlayerName(playerid), playerid);
		SendClientMessageToAll(COLOUR_YELLOW, str);
		SendClientMessage(playerid, 0x0E68CAA, lang_texts[699]);
		CashboxPickupOff = CreatePickup(1319, 3, DropLocation[0], DropLocation[1], DropLocation[2]);
//		CashboxPickup2 = CreatePickup(1318, 3, DropLocation[0], DropLocation[1], DropLocation[2]+h1-2);
//		CashboxObject = CreateObject(354, DropLocation[0], DropLocation[1], DropLocation[2]+h2, 0.0, 0.0, 0.0);
//		CashboxObject2 = CreateObject(354, DropLocation[0], DropLocation[1], DropLocation[2]+h3, 0.0, 0.0, 0.0);
		print("[CashBox]: CashBox Picked");
	}
	
 	if(pickupid == CashboxPickupOff && playerid == CashboxOwner && IsPlayerInCircle(playerid,DropLocation[0], DropLocation[1],3))
	{
	PlaySoundForPlayer(playerid, 1054);
	KillTimer(DropValueTimer);
	CashBoxDestroyPickups();

	new str[128];
	CashboxOwner = INVALID_PLAYER_ID;
	format(str, 128, lang_texts[700], oGetPlayerName(playerid), playerid, CashboxValue);
	SendClientMessageToAll(COLOUR_WHITE, str);
	Player[playerid][CB]++;
	oGivePlayerMoney(playerid, CashboxValue, 1);
        format(str, 128, "~y~Congratulations! ~n~ You won ~n~~g~$%d", CashboxValue);
	GameTextForPlayer(playerid, str, 4000, 3);

	StartNewCBGame = SetTimer("StartNewCashboxGame", CashBoxGameTimer, 0);
	IsGameStartedCB = 0;
	print("[CashBox]: End game. Cash Box in marker");
	}
return 1;
}

forward DropCashboxValue();
forward StartNewCashboxGame();

public StartNewCashboxGame()
{
	if (IsGameStartedCB == 1) return 0;
	if (PlayerCount() < CashBoxMaxPlayers) return 0;
	IsGameStartedCB = 1;
	IsCashboxPickedUp = 0;
//	new str[128];
	new rand = random(sizeof(CashboxLocations));
	CashboxValue = MinCashboxValue+random(MaxCashboxValue-MinCashboxValue);
	CashboxPickup = CreatePickup(1210, 3, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2]);
//	CashboxPickup2 = CreatePickup(1318, 3, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2]+h1);
//	CashboxObject = CreateObject(354, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2]+h2, 0.0, 0.0, 0.0);
//	CashboxObject2 = CreateObject(354, CashboxLocations[rand][0], CashboxLocations[rand][1], CashboxLocations[rand][2]+h3, 0.0, 0.0, 0.0);
	
	CashboxX = CashboxLocations[rand][0];
	CashboxY = CashboxLocations[rand][1];
	CashboxZ = CashboxLocations[rand][2];
	for(new i; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && (Player[i][Jailed]==0) )
		{
		CashBoxGameMessage(i);
		}
	}
	DropValueTimer = SetTimer("DropCashboxValue", 1000, 1);
        KillTimer(StartNewCBGame);
	CashBoxTime=0;
	print("[CashBox]: Start a new game");
	return 1;
}


public DropCashboxValue()
{
	if (IsGameStartedCB==0) return;

	if(IsTextdrawCreated == 1)
	{
		TextDrawDestroy(ValueText);
		IsTextdrawCreated = 0;
	}

	new TextString[40];
	if( (CashboxValue > MinCashboxValue) && (CashBoxTime<MaxCashBoxTime) )
	{
    	CashBoxTime++;
	CashboxValue -= ValuedropPerSecond;
	
	format(TextString, 60, "~b~CASHBOX: ~g~$~w~%d ~r~(~w~%d ~r~CEK.)", CashboxValue, MaxCashBoxTime-CashBoxTime);
	}
	if( (CashboxValue <= MinCashboxValue) || (CashBoxTime>=MaxCashBoxTime) )
	{
	CashboxValue = MinCashboxValue;
	SendClientMessageToAll(COLOUR_LIGHTRED, lang_texts[701]);
	format(TextString, 40, "~b~CASHBOX: ~r~GAME OVER");

	KillTimer(DropValueTimer);
	CashBoxDestroyPickups();

     	print("[CashBox]: End game. Time Out");

	StartNewCBGame = SetTimer("StartNewCashboxGame", CashBoxGameTimer*3, 0);
	IsGameStartedCB = 0;
	IsCashboxPickedUp = 0;
	}
	if(CashBoxUseTextdraw == 1)
	{
		ValueText = TextDrawCreate(430, 430, TextString);
		IsTextdrawCreated = 1;
    		TextDrawFont(ValueText, 3);

		TextDrawLetterSize(ValueText, 0.4, 0.8);
		TextDrawSetShadow(ValueText, 1);
		TextDrawSetOutline(ValueText,1); // thickness 1
		TextDrawUseBox(ValueText, 0);
		TextDrawBoxColor(ValueText, 0x000000AA);
		TextDrawBackgroundColor(ValueText,0x000000FF);
		TextDrawColor(ValueText,0xFFFFFFFF);
    		TextDrawAlignment(ValueText,0); // align right
		TextDrawShowForAll(ValueText);
	}
}

/*
Created August 3th 2008 by =>SCALOlaz<=
*/

#if defined _teleports_included
  #endinput
#endif

#define _teleports_included
#pragma library teleports
#pragma tabsize 0

#include <a_samp>
#include <a_players>
#include <player>

forward TelePort_OnGameModeInit();
forward TelePort_Config();
forward TelePortInit();
forward TelePortDestroy();
forward TelePortOnPlayerPickUpPickup(playerid, pickupid);

new TPPickupModel = 1559;	//1314
new TPPLevelMin = 10;		//Минимальный лвл игрока для юзания телепортов
new TelePort_Enabled = 1;

#define TelePortMAX 22

new TelePortPick[TelePortMAX];
new Float:TelePortIN[TelePortMAX][3] = {
//{1431.9673, -1483.0771, 20.4306},
//{1407.6762, -1487.8984, 125.3691},

{2073.321289,1912.882812,14.015681},
{1043.688476,-299.794952,77.359375},
{2621.696777,1821.047363,13.598829},

{2118.058105,2416.592041,10.820312},
{2118.135498,2416.631835,49.523437},
{2081.253906,2403.006347,74.578598},
{2048.205566,1916.410400,21.491306},

{2315.982177,1801.339843,10.820312},
{-1772.073730,888.506591,25.085937},
{-1830.568725,572.787963,35.164062},
{-1806.884155,517.996765,234.890625},
{-1820.028930,1310.323974,7.187500},
{-1813.730224,1289.626220,59.734375},
{-2817.434326,-1534.721557,139.289062},
{-1629.715332,-2245.949707,31.476562},
{2846.214599,-2368.374023,31.000892},

{2488.144287,2397.303955,4.210937},
{2487.774658,2397.462890,10.820312},
{2268.033203,2449.100830,-7.195312},
{2252.675048,2490.671875,10.990804},
{-442.274444,606.544738,16.940917},
{2118.378417,2416.667236,19.421875}

};

new Float:TelePortOUT[TelePortMAX][3] = {
//{1432.7, -1466.7, 125.3},
//{1401.2, -1493.6, 20.4},

{272.428924,1988.461181,17.640625},
{-1365.749267,-250.421997,14.143965},
{-2233.378662,-1736.977905,480.825805},

{2114.258544,2421.237304,49.523437},
{2114.367675,2422.855468,10.820312},
{2057.363525,2414.268310,150.476562},
{1968.049438,1916.983764,130.937500},

{2428.829833,1811.901855,38.820312},
{-1753.699462,890.904541,249.047973},
{-1814.899902,539.677001,234.887420},
{-1806.535034,531.475341,35.166793},
{-1819.466186,1314.546875,59.734375},
{-1813.069213,1285.470947,14.977269},
{-2239.875244,-1747.153076,480.861999},
{2322.984619,31.410966,26.484375},
{-2199.098876,2324.950439,4.982196},

{2491.271240,2398.481445,10.820312},
{2491.485351,2397.090820,4.210937},
{2251.273437,2485.959716,10.990804},
{2268.207763,2445.876464,-7.195312},
{-1379.257690,1490.220581,21.156250},
{2114.397705,2422.099609,10.557722}
};

public TelePort_Config()
{
	if (!dini_Exists(ConfigDB)) return;

	new temp[MAX_STRING];

	set(temp,dini_Get(ConfigDB,"TelePort_Enabled"));
	if (strlen(temp) > 0) TelePort_Enabled = strval(temp); 
	else { valstr(temp,TelePort_Enabled); dini_Set(ConfigDB,"TelePort_Enabled",temp); }

	set(temp,nullstr);	
	set(temp,dini_Get(ConfigDB,"TPPLevelMin"));
	if (strlen(temp) > 0) TPPLevelMin = strval(temp); 
	else { valstr(temp,TPPLevelMin); dini_Set(ConfigDB,"TPPLevelMin",temp); }
}

public TelePort_OnGameModeInit() {
	TelePort_Config();
	if (TelePort_Enabled==1) {
		TelePortInit();
		WriteLog("Teleports Loaded");
		}
}

public TelePortInit()
{
for (new i=0;i<TelePortMAX;i++)
	{

	TelePortPick[i]=CreatePickup(TPPickupModel, 1, TelePortIN[i][0], TelePortIN[i][1], TelePortIN[i][2]+1);
//	TelePortPick[i]=CreateStreamPickup(TPPickupModel, 1, TelePortIN[i][0], TelePortIN[i][1], TelePortIN[i][2]+1);
	}
}

public TelePortDestroy()
{
for (new i=0;i<TelePortMAX;i++)
	{
	DestroyPickup(TelePortPick[i]);
	}
}


public TelePortOnPlayerPickUpPickup(playerid, pickupid)
{
if (TelePort_Enabled==0) return;
if (IsPlayerInAnyDM(playerid)) return;
for (new i=0;i<TelePortMAX;i++)
	{
	if( (pickupid == TelePortPick[i]) && IsPlayerInCircle(playerid, TelePortIN[i][0], TelePortIN[i][1], 2) )
		{
		if (Player[playerid][Level]>=TPPLevelMin)
			{
			SetPlayerPos(playerid, TelePortOUT[i][0], TelePortOUT[i][1], TelePortOUT[i][2]);
			PlaySoundForPlayer(playerid,1150);
			} else {
				new message[MAX_STRING];
				format(message, sizeof(message), lang_texts[593], TPPLevelMin);
				SendPlayerFormattedText(playerid, message, 0, COLOUR_RED);
				}
		}
	}
}
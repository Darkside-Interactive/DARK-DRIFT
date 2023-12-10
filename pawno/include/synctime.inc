//Sync Time module
//Created by MadCat
//Part of code from MIC

forward SyncTime_OnGameModeInit();
forward SyncTime_OnPlayerDisconnect(playerid,reason);
forward SyncTime_OnPlayerSpawn(playerid);

forward SyncTimeConfig();
forward SyncRealTime();
forward SyncTime();
//forward GetStringGettime();

new Time_String[256];
new Text:TimeText;

new WorldTime;
//new SystemTimer;

new Real_Time = 1;

public SyncTime_OnGameModeInit()
{
//	Debug("synctime.inc > SyncTime_OnGameModeInit - Start");
	SyncTimeConfig();
//	if (Real_Time == 1){
		TimeText = TextDrawCreate(549,24,"00:00");
		TextDrawLetterSize(TimeText,0.55,2);
		TextDrawFont(TimeText,3);
		TextDrawBackgroundColor(TimeText,0x000000AA);
		TextDrawSetOutline(TimeText,2);
//		SetTimer("SyncRealTime",10000,1);
		WriteLog("Real time sync loaded");
//	} else {
//		WorldTime = 12;
//		SetTimer("SyncTime", 10000, 1);
		WriteLog("Time sync loaded");
//	}
	SetTimer("SyncRealTime", 10000, 1);

//	Debug("synctime.inc > SyncTime_OnGameModeInit - Stop");
	return 0;
}

public SyncTime_OnPlayerDisconnect(playerid,reason)
{
	#pragma unused reason
//	Debug("synctime.inc > SyncTime_OnPlayerDisconnect - Start");
	if (Real_Time == 1){
		TextDrawHideForPlayer(playerid,TimeText);
	}
//	Debug("synctime.inc > SyncTime_OnPlayerDisconnect - Stop");
	return 0;
}

public SyncTime_OnPlayerSpawn(playerid)
{
//	Debug("synctime.inc > SyncTime_OnPlayerSpawn - Start");
	if (Real_Time == 1){
		TextDrawShowForPlayer(playerid,TimeText);
	}
//	Debug("synctime.inc > SyncTime_OnPlayerSpawn - Stop");
	return 0;
}

public SyncTimeConfig()
{
//	Debug("synctime.inc > SyncTimeConfig - Start");
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);

	new temp[MAX_STRING];
	
	set(temp,dini_Get(ConfigDB,"Real_Time"));
	if (strlen(temp) > 0) Real_Time = strval(temp); 
	else { valstr(temp,Real_Time); dini_Set(ConfigDB,"Real_Time",temp); }
	set(temp,nullstr);
//	Debug("synctime.inc > SyncTimeConfig - Stop");
}

public SyncRealTime()
{
	if (Real_Time == 1) 
	{
	new hour,minute,second;
	gettime(hour,minute,second);
//	if (minute <= 9)
//	{
//		format(Time_String,255,"%d:0%d",hour,minute);
//	}
//	else
//	{
//		format(Time_String,255,"%d:%d",hour,minute);
//	}
	format(Time_String,7,"%s",GetStringGettime() );

TextDrawHideForAll(TimeText);
	TextDrawSetString(TimeText,Time_String);
TextDrawShowForAll(TimeText);
	if (hour == 0){SetWorldTime(0);}
	if (hour == 1){SetWorldTime(1);}
	if (hour == 2){SetWorldTime(2);}
	if (hour == 3){SetWorldTime(3);}
	if (hour == 4){SetWorldTime(4);}
	if (hour == 5){SetWorldTime(5);}
	if (hour == 6){SetWorldTime(6);}
	if (hour == 7){SetWorldTime(7);}
	if (hour == 8){SetWorldTime(8);}
	if (hour == 9){SetWorldTime(9);}
	if (hour == 10){SetWorldTime(10);}
	if (hour == 11){SetWorldTime(11);}
	if (hour == 12){SetWorldTime(12);}
	if (hour == 13){SetWorldTime(13);}
	if (hour == 14){SetWorldTime(14);}
	if (hour == 15){SetWorldTime(15);}
	if (hour == 16){SetWorldTime(16);}
	if (hour == 17){SetWorldTime(17);}
	if (hour == 18){SetWorldTime(18);}
	if (hour == 19){SetWorldTime(19);}
	if (hour == 20){SetWorldTime(20);}
	if (hour == 21){SetWorldTime(21);}
	if (hour == 22){SetWorldTime(22);}
	if (hour == 23){SetWorldTime(23);}
	if (hour == 24){SetWorldTime(24);}
	}

	else {
//}

//public SyncTime()
//{
//	Debug("synctime.inc > SyncTime - Start");
	if (WorldTime >= 23)
	{
		WorldTime = 0;
	} else {
		WorldTime++;
	}
	SetWorldTime(WorldTime);
//	Debug("synctime.inc > SyncTime - Stop");
	}
}

GetStringGettime()
{
    new Sctime[7];
//    new string[MAX_STRING];
    new schour,scminute,scsecond;
    gettime(schour,scminute,scsecond);
    if ( (schour <= 9) && (scminute <= 9) ) {format(Sctime,sizeof(Sctime),"0%d:0%d",schour,scminute);}
    if ( (schour <= 9) && (scminute > 9) )  {format(Sctime,sizeof(Sctime),"0%d:%d",schour,scminute);}
    if ( (schour > 9) && (scminute <= 9) ) {format(Sctime,sizeof(Sctime),"%d:0%d",schour,scminute);}
    if ( (schour > 9) && (scminute > 9) )  {format(Sctime,sizeof(Sctime),"%d:%d",schour,scminute);}
//set(string,Sctime);
return Sctime;
}
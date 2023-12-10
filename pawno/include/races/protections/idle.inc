//Anti-Idle module
//Created by Iain Gilbert
//Modder: MadCat

forward AntiIdle_OnGameModeInit();
forward AntiIdle();

new TimerAntiIdle;

new Anti_Idle_Enabled = 1;
new Action_On_MaxIdleTime = 2;
new Idle_Ban_Days = 1;
new Idle_Minutes_To_Punish_min = 150;	//ÌÈÍÈÌÓÌ 2 ìèíóòû
new Idle_Minutes_To_Punish = 480;	//8 min

new playerIdle[MAX_PLAYERS];
new Float:playerIdlePos[MAX_PLAYERS][CoordInfo];

public AntiIdle_OnGameModeInit(){
	AntiIdleConfig();
	if (Anti_Idle_Enabled == 1){
		TimerAntiIdle = SetTimer("AntiIdle",1000,1);
		WriteLog("Anti Idle Loaded");
	} else {KillTimer(TimerAntiIdle);}
	return 0;
}

AntiIdleConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"Anti_Idle_Enabled"));
	if (strlen(temp) > 0) Anti_Idle_Enabled = strval(temp);
	else { valstr(temp,Anti_Idle_Enabled); dini_Set(SecurityDB,"Anti_Idle_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_MaxIdleTime"));
	if (strlen(temp) > 0) Action_On_MaxIdleTime = strval(temp);
	else { valstr(temp,Action_On_MaxIdleTime); dini_Set(SecurityDB,"Action_On_MaxIdleTime",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Idle_Ban_Days"));
	if (strlen(temp) > 0) Idle_Ban_Days = strval(temp);
	else { valstr(temp,Idle_Ban_Days); dini_Set(SecurityDB,"Idle_Ban_Days",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Idle_Minutes_To_Punish_min"));
	if (strlen(temp) > 0) Idle_Minutes_To_Punish_min = strval(temp);
	else { valstr(temp,Idle_Minutes_To_Punish_min); dini_Set(SecurityDB,"Idle_Minutes_To_Punish_min",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Idle_Minutes_To_Punish"));
	if (strlen(temp) > 0) Idle_Minutes_To_Punish = strval(temp);
	else { valstr(temp,Idle_Minutes_To_Punish); dini_Set(SecurityDB,"Idle_Minutes_To_Punish",temp);  }
	set(temp,nullstr);

	return;
}

public AntiIdle()
{
	if (Anti_Idle_Enabled == 0) return;
new Float:x,Float:y,Float:z;
for(new playerid=0; playerid<MAX_PLAYERS; playerid++)
{
  	if( IsPlayerConnected(playerid) && Player[playerid][Jailed]==0 && !IsPlayerAdmin(playerid))
	{
	GetPlayerPos(playerid,x,y,z);

		if(GetPlayerDistanceToPoint(playerid,playerIdlePos[playerid][Coord_X], playerIdlePos[playerid][Coord_Y]) < 6 )
//        	if(x == playerIdlePos[playerid][Coord_X] && y == playerIdlePos[playerid][Coord_Y] && z == playerIdlePos[playerid][Coord_Z])
		{
			playerIdle[playerid]++;
			if( (playerIdle[playerid] > Idle_Minutes_To_Punish_min-1) && (playerIdle[playerid] < Idle_Minutes_To_Punish) )
			{
			PlaySoundForPlayer(playerid,1057);

				if ( (playerIdle[playerid] == Idle_Minutes_To_Punish_min) || (playerIdle[playerid] == Idle_Minutes_To_Punish-30) || (playerIdle[playerid] == Idle_Minutes_To_Punish-60) || (playerIdle[playerid] == Idle_Minutes_To_Punish-180) )
					{
					new message[MAX_STRING];
					format(message, sizeof(message),  lang_texts[530] , playerIdle[playerid]);
					SendClientMessage(playerid,COLOUR_RED,message);
					PlaySoundForPlayer(playerid,1057);

						if (Action_On_MaxIdleTime == 2){
               					SendClientMessage(playerid,COLOUR_RED,lang_texts[534]);
						} else if (Action_On_MaxIdleTime == 3){
						SendClientMessage(playerid,COLOUR_RED,lang_texts[535]);
						}
					}
			}        
			if(playerIdle[playerid] > Idle_Minutes_To_Punish)
			{
				playerIdle[playerid] = 0;
				if (Action_On_MaxIdleTime == 0) continue;
				if (Action_On_MaxIdleTime == 1) Report(playerid,lang_texts[536]);
				if (Action_On_MaxIdleTime == 2) KickPlayer(playerid,lang_texts[536]);
				if (Action_On_MaxIdleTime == 3)	BanPlayer(playerid,Idle_Ban_Days,lang_texts[536]);
			}
		}
        else
		{
               		playerIdle[playerid] = 0;
			playerIdlePos[playerid][Coord_X] = x;
			playerIdlePos[playerid][Coord_Y] = y;
			playerIdlePos[playerid][Coord_Z] = z;
       		}
	}
}
}



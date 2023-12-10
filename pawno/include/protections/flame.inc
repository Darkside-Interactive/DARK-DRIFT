//Anti-flame Module
//Created by [NB]Boylett (FilterScript name: xAntiSwear)
//Converted and modified by: MadCat

#define MAX_BADWORDS 200
#define STR 100

forward AntiFlame_OnGameModeInit();
forward FlameConfig();
forward AntiFlame_OnPlayerText(playerid,text[]);

new BadWords[MAX_BADWORDS][STR];
new num_badwords = 0;
new PlayerFlameCount[MAX_PLAYERS];

new AntiFlame_Enabled=1;
new FlameDB[MAX_STRING] = "GTO/Badwords.txt";
new Max_Allowed_Badwords=5;
new Action_On_MaxBadwords=2;
new Flame_Ban_Days=1;

public AntiFlame_OnGameModeInit(){
	FlameConfig();
	if (AntiFlame_Enabled == 1){
		LoadBadWords();
		new logstring[256];
		format(logstring, sizeof (logstring), "Anti Flame Loaded! Words: %d",num_badwords);
		WriteLog(logstring);
	}
	return 0;
}

public FlameConfig()
{
	if (ForceOverwrite) return;
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	new temp[MAX_STRING];
	set(temp,dini_Get(ConfigDB,"AntiFlame_DB"));
	if (strlen(temp) > 0) FlameDB = temp; 
	else { set(temp,FlameDB); dini_Set(ConfigDB,"AntiFlame_DB",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(SecurityDB,"AntiFlame_Enabled"));
	if (strlen(temp) > 0) AntiFlame_Enabled = strval(temp); 
	else { valstr(temp,AntiFlame_Enabled); dini_Set(SecurityDB,"AntiFlame_Enabled",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(SecurityDB,"Max_Allowed_Badwords"));
	if (strlen(temp) > 0) Max_Allowed_Badwords = strval(temp); 
	else { valstr(temp,Max_Allowed_Badwords); dini_Set(SecurityDB,"Max_Allowed_Badwords",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(SecurityDB,"Action_On_MaxBadwords"));
	if (strlen(temp) > 0) Action_On_MaxBadwords = strval(temp); 
	else { valstr(temp,Action_On_MaxBadwords); dini_Set(SecurityDB,"Action_On_MaxBadwords",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(SecurityDB,"Flame_Ban_Days"));
	if (strlen(temp) > 0) Flame_Ban_Days = strval(temp); 
	else { valstr(temp,Flame_Ban_Days); dini_Set(SecurityDB,"Flame_Ban_Days",temp);  }
	set(temp,nullstr);
	if (!dini_Exists(FlameDB)) dini_Create(FlameDB);
	return;
}

LoadBadWords()
{
	if (!dini_Exists(FlameDB)){ dini_Create(FlameDB); return 0;}
	new string[STR], File:file = fopen(FlameDB,io_read);
	if(file)
	{
		while(fread(file,string))
		{
			if (num_badwords >= MAX_BADWORDS) continue;
		   	
			StripNewLine(string);
            		set(BadWords[num_badwords],string);
            		num_badwords++;
		}
		fclose(file);
	}
	return 0;
}

public AntiFlame_OnPlayerText(playerid,text[])
{
	if (AntiFlame_Enabled == 0) return 0;
	if (!IsPlayerConnected(playerid)) return 0;
   	for(new s = 0; s < num_badwords; s++)
    	{
		if(strfind(text,BadWords[s],true) != -1){
			PlayerFlameCount[playerid]++;
			SendClientMessage(playerid,COLOUR_RED,lang_texts[604]);
		}
		new pos;
		while((pos = strfind(text,BadWords[s],true)) != -1) for(new i = pos, j = pos + strlen(BadWords[s]); i < j; i++) text[i] = '*';
    	}
    	if(PlayerFlameCount[playerid] >= Max_Allowed_Badwords){
	PlayerFlameCount[playerid]=0;
	if (Action_On_MaxBadwords == 0) PlayerFlameCount[playerid]=0;
	if (Action_On_MaxBadwords == 1)	Report(playerid,lang_texts[609]);
	if (Action_On_MaxBadwords == 2)	KickPlayer(playerid,lang_texts[609]);
	if (Action_On_MaxBadwords == 3) BanPlayer(playerid,Flame_Ban_Days,lang_texts[609]);
	return 0;
    }
	return 1;
}

//Anti-Jetpack Module
//Created by MadCat

forward AntiJetpack_OnGameModeInit();
forward JetpackCheckTimer();


new Anti_Jetpack_Enabled = 1;
new Action_On_Jetpack=2;
new Jetpack_Ban_Days=30;

public AntiJetpack_OnGameModeInit(){
	AntiJetpackConfig();
	if (Anti_Jetpack_Enabled == 1){
		SetTimer("JetpackCheckTimer",5000,1);
		WriteLog("Anti Jetpack Loaded");
	}
	return 0;
}

AntiJetpackConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);
	
	set(temp,dini_Get(SecurityDB,"Anti_Jetpack_Enabled"));
	if (strlen(temp) > 0) Anti_Jetpack_Enabled = strval(temp);
	else { valstr(temp,Anti_Jetpack_Enabled); dini_Set(SecurityDB,"Anti_Jetpack_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_Jetpack"));
	if (strlen(temp) > 0) Action_On_Jetpack = strval(temp);
	else { valstr(temp,Action_On_Jetpack); dini_Set(SecurityDB,"Action_On_Jetpack",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Jetpack_Ban_Days"));
	if (strlen(temp) > 0) Jetpack_Ban_Days = strval(temp);
	else { valstr(temp,Jetpack_Ban_Days); dini_Set(SecurityDB,"Jetpack_Ban_Days",temp);  }
	set(temp,nullstr);

	return;
}

public JetpackCheckTimer()
{
	if (Anti_Jetpack_Enabled == 0) return;
	for (new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		if (IsPlayerConnected(playerid))
		{
			if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK){
				if (Action_On_Jetpack == 0) continue;
				if (Action_On_Jetpack == 1) Report(playerid,lang_texts[620]);
				if (Action_On_Jetpack == 2) KickPlayer(playerid,lang_texts[620]);
				if (Action_On_Jetpack == 3) BanPlayer(playerid,Jetpack_Ban_Days,lang_texts[620]);
			}
		}
	}
}
//Anti-spam Module
//Created by MadCat

new AntiSpam_Enabled = 0;
new AntiSpam_Max_Messages = 3;
new Action_On_MaxSpam = 1;
new Spam_Ban_Days = 3;
new AntiSpam_Max_Commands = 3;
new Action_On_MaxCommandSpam = 1;
new CommandSpam_Ban_Days = 3;

new LastCommand[MAX_PLAYERS][MAX_STRING];
new CommandSpamCount[MAX_PLAYERS];

new LastText[MAX_PLAYERS][MAX_STRING];
new SpamCount[MAX_PLAYERS];

forward AntiSpam_OnGameModeInit();
forward AntiSpam_OnPlayerText(playerid,text[]);
forward AntiSpam_OnPlayerCommand(playerid,text[]);

public AntiSpam_OnGameModeInit(){
	AntiSpamConfig();
	if (AntiSpam_Enabled == 1) WriteLog("AntiSpam Loaded");
	return 0;
}

AntiSpamConfig()
{
//	Debug("protections/spam.inc > AntiSpamConfig - Start");
	new temp[MAX_STRING];
	
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"AntiSpam_Enabled"));
	if (strlen(temp) > 0) AntiSpam_Enabled = strval(temp);
	else { valstr(temp,AntiSpam_Enabled); dini_Set(SecurityDB,"AntiSpam_Enabled",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"AntiSpam_Max_Messages"));
	if (strlen(temp) > 0) AntiSpam_Max_Messages = strval(temp);
	else { valstr(temp,AntiSpam_Max_Messages); dini_Set(SecurityDB,"AntiSpam_Max_Messages",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Action_On_MaxSpam"));
	if (strlen(temp) > 0) Action_On_MaxSpam = strval(temp);
	else { valstr(temp,Action_On_MaxSpam); dini_Set(SecurityDB,"Action_On_MaxSpam",temp); }
	set(temp,nullstr);

	set(temp,dini_Get(SecurityDB,"Spam_Ban_Days"));
	if (strlen(temp) > 0) Spam_Ban_Days = strval(temp);
	else { valstr(temp,Spam_Ban_Days); dini_Set(SecurityDB,"Spam_Ban_Days",temp); }
	set(temp,nullstr);

//	Debug("protections/spam.inc > AntiSpamConfig - Stop");
	return;
}

public AntiSpam_OnPlayerText(playerid,text[])
{
	if (AntiSpam_Enabled == 0) return;
	if (!IsPlayerConnected(playerid)) return;
//	Debug("protections/spam.inc > AntiSpam_OnPlayerText - Start");
	if(strcomp(text,LastText[playerid],true) == 1){
	    	SpamCount[playerid]++;
	} else {
		SpamCount[playerid] = 0;
	}
	if(SpamCount[playerid] >= AntiSpam_Max_Messages){
		SpamCount[playerid] = 0;
		if (Action_On_MaxSpam == 0) return;
		if (Action_On_MaxSpam == 1) Report(playerid,lang_texts[723]);
		if (Action_On_MaxSpam == 2) KickPlayer(playerid,lang_texts[723]);
		if (Action_On_MaxSpam == 3) BanPlayer(playerid,Spam_Ban_Days,lang_texts[723]);
	}
	if (IsPlayerConnected(playerid)){
		format(LastText[playerid],MAX_STRING,"%s",text);
	}
//	Debug("protections/spam.inc > AntiSpam_OnPlayerText - Stop");
}

public AntiSpam_OnPlayerCommand(playerid,text[])
{
	if (AntiSpam_Enabled == 0) return;
	if (!IsPlayerConnected(playerid)) return;
//	Debug("protections/spam.inc > AntiSpam_OnPlayerCommand - Start");
	if(strcomp(text,LastCommand[playerid],true) == 1){
	    	CommandSpamCount[playerid]++;
	} else {
		CommandSpamCount[playerid] = 0;
	}
	if(CommandSpamCount[playerid] >= AntiSpam_Max_Commands){
		CommandSpamCount[playerid] = 0;
		if (Action_On_MaxCommandSpam == 0) return;
		if (Action_On_MaxCommandSpam == 1) Report(playerid,lang_texts[724]);
		if (Action_On_MaxCommandSpam == 2) KickPlayer(playerid,lang_texts[724]);
		if (Action_On_MaxCommandSpam == 3) BanPlayer(playerid,CommandSpam_Ban_Days,lang_texts[724]);
	}
	if (IsPlayerConnected(playerid)){
		format(LastCommand[playerid],MAX_STRING,"%s",text);
	}
//	Debug("protections/spam.inc > AntiSpam_OnPlayerCommand - Stop");
}
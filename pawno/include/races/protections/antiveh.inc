//Anti-Vehicles Module
//Created by SCALOlaz (FP)

forward AntiVeh_OnGameModeInit();
forward AntiVeh_Config();
forward AntiVeh_timer();

new AntiVeh_Enabled = 1;
new AntiVeh_Max;

public AntiVeh_OnGameModeInit(){
	AntiVeh_Config();
	if (AntiVeh_Enabled == 1){
		AntiVeh_Max = TotalVehicles();
		SetTimer("AntiVeh_timer",500,1);
		WriteLog("Anti Vehicles Cheat Activated");
	}
	return 0;
}

public AntiVeh_Config()
{
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	new temp[MAX_STRING];
	set(temp,dini_Get(SecurityDB,"AntiVeh_Enabled"));
	if (strlen(temp) > 0) AntiVeh_Enabled = strval(temp); 
	else { valstr(temp,AntiVeh_Enabled); dini_Set(SecurityDB,"AntiVeh_Enabled",temp); }
	set(temp,nullstr);
}

public AntiVeh_timer()
{
	if (AntiVeh_Enabled == 0) return;
	if (TotalVehicles() > AntiVeh_Max)
	{
		new logstring[MAX_STRING];
		format(logstring,sizeof(logstring),"[AntiVeh] Warning! Found New NoMode Vehicle '%s'(ID: %d)!", GetVehicleName( GetVehicleModel(AntiVeh_Max+1)), AntiVeh_Max );
		print (logstring);
		WriteLog(logstring);
		new string[MAX_STRING];
		format(string,sizeof(string), lang_texts[588], GetVehicleName( GetVehicleModel(AntiVeh_Max+1)), AntiVeh_Max );
		SendClientMessageToAll(COLOUR_RED, string);
		DestroyVehicle(AntiVeh_Max+1);

		SendClientMessageToAll(COLOUR_RED, lang_texts[587]);
		WriteLog("[AntiVehi] Destroy This Vehicle");
	}
}

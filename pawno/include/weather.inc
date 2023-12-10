//Weather module.
//Created by GTAT Dev Team
//Converted by MadCat

new WEATHER_ChangeTime[2];
new WEATHER_Weather;
new sysweath = 0;	//WEATHER 0, 1, 2

forward Weather_OnGameModeInit();
forward Weather_Timer();

public Weather_Timer(){
	if (sysweath==1)	//Automatic Randomly
	{
		if(WEATHER_ChangeTime[0] == 0){WEATHER_ChangeTime[1] = (random(180)+90);}
		WEATHER_ChangeTime[0]++;
		if(WEATHER_ChangeTime[0] >= WEATHER_ChangeTime[1])
		{
	    	WEATHER_ChangeTime[0] = 0;
		GenerateRandomWeather();
		}
	}
}

stock GenerateRandomWeather(){
	new ran = random(40);
	if(ran >= 0 && ran <= 7){
	    	WEATHER_Weather = ran;
	}
	if(ran >= 9 && ran <= 18){
	    	WEATHER_Weather = ran;
	}
	else if(ran == 20 || ran == 21){
	    	WEATHER_Weather = 7;
	}
	else if(ran == 8 || ran == 19 || ran == 22){
	    	WEATHER_Weather = 9;
	}
	else if(ran == 23 || ran == 24){
	    	WEATHER_Weather = 17;
	}
	else if (ran > 24){
		ran = random(7);
		WEATHER_Weather = ran;
	}
	SetWeather(WEATHER_Weather);
}

public Weather_OnGameModeInit(){
	SetTimer("Weather_Timer", 1000, 1);
	WriteLog("Weather system Loaded");
	return 0;
}

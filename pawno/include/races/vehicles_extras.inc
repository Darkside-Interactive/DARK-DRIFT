#if defined _vehicles_extras_included
#endinput
#endif

#define _vehicles_extras_included
#pragma library vehicles_extras
#include "base"

forward fuelconfig();
forward Fuel_OnGameModeInit();
forward CheckFuel(playerid);
forward FuelRefill(playerid);
forward FuelRefill2(vehicleid);
forward FuelEmpty(vehicleid);
forward FuelCommandHandler(playerid, cmdtext[]);
forward OnPlayerEnterFuelCheckpoint(playerid);
forward OnVehicleSpawn(vehicleid);

//Fuel (Relevant code!)
new Petrol_Time = 500;
new Petrol_Amount = 100;
new Petrol_Multiplier = 9;
new Petrol_Increment = 4;
new Petrol_Inc;

new SpeedPos = 4;

#define MAX_FUELSTATIONS 24

new Float:Petrol[MAX_VEHICLE_SPAWNS];
enum PetrolCoordInfo {
    Float:PetrolCoord_X,
    Float:PetrolCoord_Y,
    Float:PetrolCoord_Z,
    PetrolParam
}
new Float:FuelStations[MAX_FUELSTATIONS][PetrolCoordInfo] = {
//    COORDS X, Y, Z, Type of STATION: 0-all, 1-air, 2-heli, 3-boat, 4-mbike
	{2109.2126,917.5845,10.8203, 0},
	{2640.1831,1103.9224,10.8203, 0},
	{611.8934,1694.7921,6.7193, 0},
	{-1327.5398,2682.9771,49.7896, 0},
	{-2413.7427,975.9317,45.0031, 0},
	{-1672.3597,414.2950,6.8866, 0},
	{-2244.1365,-2560.6294,31.6276, 0},
	{-1603.0166,-2709.3589,48.2419, 0},
	{1939.3275,-1767.6813,13.2787, 0},
	{-94.7651,-1174.8079,1.9979, 0},
	{1381.6699,462.6467,19.8540, 0},
	{657.8167,-559.6507,16.0630, 0},
	{-1478.2916,1862.8318,32.3617, 0},
	{2147.3054,2744.9377,10.5263, 0},
	{2204.9602,2480.3494,10.5278, 0},
	{1590.9493,2202.2637,10.5247, 0},

//AIR
	{1606.173950,-2446.645507,13.554687, 1},
	{-1156.518554,-179.330459,14.148437, 1},
	{1359.415405,1756.655517,10.820312, 1},
	{396.800628,2528.603515,16.564601, 1},

//BOATS
	{-656.884582,871.513610,-0.567039, 3},
	{-1420.657104,426.267333,-0.570038, 3},
	{2085.910888,-114.627189,-0.602148, 3},
	{379.673950,-2117.019287,-0.481255, 3}

//	{-2366.620117,2276.875000,-0.733551, 3},
//	{-915.348754,2641.401611,39.991355, 3}
};



public fuelconfig()
{
	if (!dini_Exists(ConfigDB)) return;

	new temp[MAX_STRING];
	
	set(temp,dini_Get(ConfigDB,"Petrol_Amount"));
	if (strlen(temp) > 0) Petrol_Amount = strval(temp); 
	else { valstr(temp,Petrol_Amount); dini_Set(ConfigDB,"Petrol_Amount",temp); }
	
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"Petrol_Multiplier"));
	if (strlen(temp) > 0) Petrol_Multiplier = strval(temp); 
	else { valstr(temp,Petrol_Multiplier); dini_Set(ConfigDB,"Petrol_Multiplier",temp);  }
	
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"Petrol_Time"));
	if (strlen(temp) > 0) Petrol_Time = strval(temp); 
	else { valstr(temp,Petrol_Time); dini_Set(ConfigDB,"Petrol_Time",temp); }
	
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"SpeedPos"));
	if (strlen(temp) > 0) SpeedPos = strval(temp); 
	else { valstr(temp,SpeedPos); dini_Set(ConfigDB,"SpeedPos",temp); }
}

public Fuel_OnGameModeInit(){
//	Debug("vehicles_extras.inc > Fuel_OnGameModeInit - Start");
	fuelconfig();

	for (new id; id < MAX_FUELSTATIONS; id++) 
	{
		AddActiveCheckpoint(FuelStations[id][PetrolCoord_X],FuelStations[id][PetrolCoord_Y],FuelStations[id][PetrolCoord_Z],25,2);
		if (FuelStations[id][PetrolParam]==0)
			{
			CreateStreamMapIcon(55,FuelStations[id][PetrolCoord_X],FuelStations[id][PetrolCoord_Y],FuelStations[id][PetrolCoord_Z]);
			}
		if ( (FuelStations[id][PetrolParam]==1) || (FuelStations[id][PetrolParam]==2) )
			{
			CreateStreamMapIcon(5,FuelStations[id][PetrolCoord_X],FuelStations[id][PetrolCoord_Y],FuelStations[id][PetrolCoord_Z]);
			}
		if (FuelStations[id][PetrolParam]==3)
			{
			CreateStreamMapIcon(9,FuelStations[id][PetrolCoord_X],FuelStations[id][PetrolCoord_Y],FuelStations[id][PetrolCoord_Z]);
			}
	}
	for(new c=0;c<MAX_VEHICLE_SPAWNS;c++)
	{
		Petrol[c] = float(Petrol_Amount);
	}
	WriteLog("Fuel System Loaded");
//	Debug("vehicles_extras.inc > Fuel_OnGameModeInit - Stop");
	return 0;
}

new PlayerOldPos[MAX_PLAYERS][CoordInfo];

public CheckFuel(playerid)
{
	new message[MAX_STRING],speed[MAX_PLAYERS];

	new Float:x,Float:y,Float:z;

	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			//Если это не велосипед!!!
			
			GetPlayerPos(i, x, y, z);
				
			speed[i] = floatround((floatsqroot(floatpower(floatabs(floatsub(x,PlayerOldPos[i][Coord_X])),2)+floatpower(floatabs(floatsub(y,PlayerOldPos[i][Coord_Y])),2)+floatpower(floatabs(floatsub(z,PlayerOldPos[i][Coord_Z])),2))*11000)/1400);
	
			if (speed[i] > 90) format(message,sizeof(message), lang_texts[172] ,speed[i]); 
			else if (speed[i] > 2) format(message,sizeof(message), lang_texts[173] ,speed[i]); 
			else format(message,sizeof(message), lang_texts[174] ,speed[i]); 
			
			
			new pvm = GetVehicleModel(GetPlayerVehicleID(i));
			if (pvm != V_BIKE && pvm != V_BMX && pvm != V_MTBIKE) 
			{
				if (!GetPlayerRace(i))
				{
					new Vi;
					Vi = GetPlayerVehicleID(i);
					
					if (speed[i] > 2 && Petrol_Inc==0) 
					{
						Petrol[Vi] = Petrol[Vi] - (float(Petrol_Time)/float(1000 * Petrol_Multiplier));
						if (speed[i] > 90) Petrol[Vi] = Petrol[Vi] - (float(Petrol_Time)/float(1000 * Petrol_Multiplier));
					}

					if (Petrol[Vi] > 60) format(message, sizeof(message),  lang_texts[175] , message, floatround(Petrol[Vi]));
					else if (Petrol[Vi] > 40) format(message, sizeof(message),  lang_texts[176] , message, floatround(Petrol[Vi]));
					else if (Petrol[Vi] > 15) format(message, sizeof(message),  lang_texts[177] , message, floatround(Petrol[Vi]));
					else if (Petrol[Vi] <= 15) format(message, sizeof(message),  lang_texts[178] , message, floatround(Petrol[Vi]));

					
					if(Petrol[Vi] < 1)
					{
//						RemovePlayerFromVehicle(i);
						format(message,sizeof(message), lang_texts[179]);
						if(Petrol[Vi] < 0) Petrol[Vi] = 0.00;
						RemovePlayerFromVehicle(i);
					}
				}
			}
			format(message,sizeof(message),lang_texts[180],message);
			GameTextForPlayer(i, message, Petrol_Time+500, 3);

			PlayerOldPos[i][Coord_X]=x;
			PlayerOldPos[i][Coord_Y]=y;
			PlayerOldPos[i][Coord_Z]=z;

		if (Petrol_Inc==0) {Petrol_Inc=Petrol_Increment;}
		Petrol_Inc--;
		}
	}
}


public FuelRefill(playerid)
{
	new VID;
	VID = GetPlayerVehicleID(playerid);
	if(Petrol[VID] < Petrol_Amount)
	{
		new Float:FillUp;
		FillUp = float(Petrol_Amount) - Petrol[VID];
		if(GetPlayerMoney(playerid) >= floatround(FillUp))
		{
			Petrol[VID] +=FillUp;
			new mess[64];
//			format(mess, sizeof(mess), lang_texts[181], floatround(FillUp));
			format(mess, sizeof(mess), " [ АЗС ]: %s залил %d л. бензина себе в транспорт",oGetPlayerName(playerid), floatround(FillUp));
            SendClientMessageToAll(COLOUR_YELLOW, mess);
//			SendClientMessage(playerid, COLOUR_WHITE, mess);
			GivePlayerMoney(playerid, -floatround(FillUp));
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOUR_RED, lang_texts[182]);
			return 1;
		}
	}
	else
	{
		SendClientMessage(playerid, COLOUR_RED, lang_texts[183]);
		return 1;
	}
}

public FuelRefill2(vehicleid)
{
	new Float:FillUp;
	FillUp = float(Petrol_Amount) - Petrol[vehicleid];
	Petrol[vehicleid] +=FillUp;
}

public FuelEmpty(vehicleid)
{
	new Float:FillUp;
	Petrol[vehicleid] = FillUp;
}



public FuelCommandHandler(playerid, cmdtext[])
{

	if(strcmp(cmdtext, "/gasloc", true) == 0) {
		
		if ((GetPlayerDM(playerid)) || (GetPlayerRace(playerid)) || (PlayerQuest[playerid] != 100 && PlayerQuest[playerid] != 0)) return 1; //Защита от умников )

		new Float:coord_x,Float:coord_y,Float:coord_z,Float:distance,d_n,d_w;
		
		GetPlayerPos(playerid,coord_x,coord_y,coord_z);
		
		for (new p; p < MAX_FUELSTATIONS; p++) 
		{
			distance = Distance(FuelStations[p][PetrolCoord_X],FuelStations[p][PetrolCoord_Y],FuelStations[p][PetrolCoord_Z],coord_x,coord_y,coord_z,true);
			if (distance < d_n || d_n == 0) { d_n = floatround(distance); d_w = p; }
		}
		
		if (PlayerQuest[playerid] != 100)
		{
			DisablePlayerCheckpoint(playerid);
			oSetPlayerCheckpoint(playerid,FuelStations[d_w][PetrolCoord_X],FuelStations[d_w][PetrolCoord_Y],FuelStations[d_w][PetrolCoord_Z],25.0);
        		PlayerQuest[playerid] = 100; //set a dummy quest to keep the CP fixed
			SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[193]);
		} else {
		    	ResetQuest(playerid);
		}
		
		return 1;
	}
	return 0;
}


public OnPlayerEnterFuelCheckpoint(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		for (new c; c < MAX_FUELSTATIONS; c++)
		{
			
		if (oIsPlayerInCheckpoint(playerid,FuelStations[c][PetrolCoord_X],FuelStations[c][PetrolCoord_Y],FuelStations[c][PetrolCoord_Z],25))
			{
			new model = GetVehicleModel(GetPlayerVehicleID(playerid));
			new vehtype = VehicleType(model);
			if (vehtype==5)
				{
				SendClientMessage(playerid,COLOUR_YELLOW, lang_texts[590]);
				return 0;
				}
			
			if( FuelStations[c][PetrolParam]==1 && (vehtype<1 || vehtype>2) )	//AIR
			{
//			new string[MAX_STRING];
//			format(string, sizeof(string), "[ GAS ]: Тип станции: %d Ваш тип: %d", FuelStations[c][PetrolParam], vehtype); 
//			SendClientMessage(playerid,COLOUR_WHITE, string);

			SendClientMessage(playerid,COLOUR_RED, lang_texts[592]);
			return 0;
			}

			if(FuelStations[c][PetrolParam]==3 && vehtype!=3)	//BOAT
			{
			SendClientMessage(playerid,COLOUR_RED, lang_texts[591]);
			return 0;
			}

//			if(FuelStations[c][PetrolParam]==0)

			SendClientMessage(playerid,COLOUR_WHITE, lang_texts[194]);
			FuelRefill(playerid);
			if (PlayerQuest[playerid] == 100) PlayerQuest[playerid] = 0; //reset the dummy quest
			
			return 1;
			}
		}
	}
	return 0;
}

public OnVehicleSpawn(vehicleid)
{
	Petrol[vehicleid] = float(Petrol_Amount);
}

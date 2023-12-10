#include <a_samp>
#include <dini>
#include <vehicles>
#include <player>
#pragma unused strtok


// Если тачка из массива, дестроим ее при доставке
// Если тачка побита, заставляем ее починить!
// Генерим сумму за тачку
// Генерим время доставки
// Если юзаем массив, тачки все находятся во 2-ом городе!
// а куда доставлять - на корабле (как в сингле), ставим там радарную картинку

forward CarExport_OnGameModeInit();
forward CarExport_OnPlayerConnect(playerid);
forward CarExport_OnPlayerSpawn(playerid);
forward CarExport_OnPlayerCommandText(playerid, cmdtext[]);
forward CarExport_OnPlayerStateChange(playerid, newstate, oldstate);
forward OnPlayerEnterCarExCheckpoint(playerid);
forward CarExport_OnVehicleDeath(vehicleid, killerid);
forward CarExport_OnPlayerExitVehicle(playerid, vehicleid);

//General
new UseCustomVehicles = 0; //Если 1, то юзаем только тачки, описанные тут как AddExportVehicle.
			   //Если 0 то все тачки мода юзаются и респавнятся потом на свои прежние места.
new SaveSettingsInFile = 1;   //If you want to save the settings in a file, set it to '1', else set it to '0'
#define SaveFile "GTO/CarExport_Config.txt"   //This is the name of the file where the settings will get saved in.

new CarExport_Enabled = 1;

//GameTime
new CarExportGameTimer = 450000;  //How many seconds after the last game has finished, the next game should start?
new CarExportRoundTime = 500;  //Players have (default) 600 seconds (10 minutes) to take the export-car to the export-place.


//Export-Location
new Float:CarExportLocation[3] = {-1609.133056,1284.745971,7.177499};
new Float:ExportX = -1917.4036;
new Float:ExportY = 286.3559;
new Float:ExportZ = 41.0469;
new Checkpointsize = 5;

//Colors
#define COLOR_RED 0xFF0000AA
#define COLOR_GREEN 0x00FF00AA
#define COLOR_BLUE 0x0000FFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFFA500AA


new IsGameStartedCE;	//Скрипт запущен
new ExportVehicle;	//тачка на угон
new CarExportVehicleValue;	//цена тачки
new GameTimeLeft;	//прошло времени уже
new RoundTimer;		//всего времени
new PlayerInExportVehicle;	//игрок в той тачке что нужна

new Max_Players;


new CEIsExportVehicle[MAX_VEHICLES];
new PlayerVehicle[MAX_PLAYERS];

//In the list here below, you can add/remove vehiclemodels which can be used in this game.
new ExportableVehicles[][0] =
{
    //===============Convertibles
	480, //Comet
	533, //Feltzer
	439, //Stallion
	555, //Windsor
	//===============Industrial
	499, //Benson
	422, //Bobcat
	482, //Burrito
	498, //Boxville
	609, //Boxburg
	524, //Cement Truck
	578, //DFT-30
	455, //Flatbed
	403, //Linerunner
	414, //Mule
	582, //Newsvan
	514, //Petrol Tanker
	413, //Pony
	515, //Roadtrain
	440, //Rumpo
	543, //Sadler
	605, //Sadler Shit
	459, //Topfun
	531, //Tractor
	408, //Trashmaster
	552, //Utility Van
	478, //Walton
 	456, //Yankee
 	554, //Yosemite
    //===============Lowriders
    536, //Blade
    575, //Broadway
    534, //Remington
    567, //Savanna
    535, //Slamvan
    566, //Tahoma
    576, //Tornado
    412, //Voodoo
    //===============Off Road
    568, //Bandito
    424, //BF Injection
    573, //Dune
    579, //Huntley
    400, //Landstalker
    500, //Mesa
    444, //Monster
    556, //Monster "A"
    557, //Monster "B"
    470, //Patriot
    489, //Rancher
    505, //Rancher
    495, //Sandking
    //===============Public Service Vehicles
    416, //Ambulance
    433, //Barracks
    431, //Bus
    438, //Cabbie
    437, //Coach
    523, //Cop Bike HPV1000
    427, //Enforcer
    490, //FBI Rancher
    528, //FBI Truck
    407, //Firetruck (Without Ladder)
    544, //Firetruck (With Ladder)
    596, //Police Car (LSPD)
    597, //Police Car (SFPD)
    598, //Police Car (LVPD)
    599, //Ranger
    432, //Rhino
    601, //S.W.A.T.
    420, //Taxi
    //===============Saloons
    445, //Admiral
    504, //Bloodring Banger
    401, //Bravura
    518, //Buccaneer
    527, //Cadrona
    542, //Clover
    507, //Elegant
    562, //Elegy
    585, //Emperor
    419, //Esperanto
    526, //Fortune
    604, //Glendale Shit
    466, //Glendale
    492, //Greenwood
    474, //Hermes
	546, //Intruder
	517, //Majestic
	410, //Manana
	551, //Merit
	516, //Nebula
	467, //Oceanic
	600, //Picador
	426, //Premier
	436, //Previon
	547, //Primo
	405, //Sentinel
	580, //Stafford
	560, //Sultan
	550, //Sunrise
	549, //Tampa
	540, //Vincent
	491, //Virgo
	529, //Willard
    421, //Washington
    //===============Sport Vehicles
    602, //Alpha
    429, //Banshee
    496, //Blista Compact
    402, //Buffalo
    541, //Bullet
    415, //Cheetah
    589, //Club
    587, //Euros
    565, //Flash
    494, //Hotring Racer
    502, //Hotring Racer
    503, //Horring Racer
    411, //Infernus
    559, //Jester
    603, //Phoenix
    475, //Sabre
    506, //Super GT
	541, //Turismo
	558, //Uranus
	477, //ZR-350
	//===============Station Wagons
	418, //Moonbeam
	404, //Perenniel
	479, //Regina
	458, //Solair
	561, //Stratum
	//===============Other Vehicles
	485, //Baggage
	457, //Caddy
	483, //Camper (Volkswagon)
	508, //Camper
	434, //Hotknife
	545, //Hustler
	588, //Hotdog
	423, //Mr Whoopee
	442, //Romero
	428, //Securicar
	409, //Stretch
	525, //Towtruck
	583 //Tug
};


public CarExport_OnGameModeInit()
{
	Max_Players = GetMaxPlayers();

	SetTimer("CountNormalVehicles", 1000, 0);

	if(CarExport_Enabled == 1)
	{
	SetTimer("StartGame",CarExportGameTimer, 0);
	}
	return 1;
}

forward CountNormalVehicles();
public CountNormalVehicles()
{
	if(TotalVehicles() == 0)
	{
	    print("CarExport Error: No Vehicles found in gamemode!!!");
	    CarExport_Enabled = 0;
	}
}

public CarExport_OnPlayerConnect(playerid)
{
	if(IsGameStartedCE == 1)
	{
	    SetVehicleParamsForPlayer(ExportVehicle, playerid, 1, 0);
	    new string[128];
	    SendClientMessage(playerid, COLOR_YELLOW, "CarExport: Эй! Доставь тачило дилерам и получи бабло! Будь первым, наеби остальных!");
	    format(string, sizeof(string), "CarExport: Тача '%s' помечена жолтым маркером! За неё дают $%d.", GetVehicleName(GetVehicleModel(ExportVehicle)), CarExportVehicleValue);
	    SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	PlayerVehicle[playerid] = 0;
	return 1;
}

public CarExport_OnPlayerSpawn(playerid)
{
    if(IsGameStartedCE == 1)
	{
	    SetVehicleParamsForPlayer(ExportVehicle, playerid, 1, 0);
	}
	return 1;
}

//see in vehicles.inc


public CarExport_OnVehicleDeath(vehicleid, killerid)
{
	if(vehicleid == ExportVehicle)
	{
//	    	new string[128];
		SendClientMessageToAll(COLOR_ORANGE, "CarExport: Мля! Этот поц убил тачку! Игра закончена.");
//		format(string, sizeof(string), "CarExport: A new game will start in %d seconds!", CarExportGameTimer);
//		SendClientMessageToAll(COLOR_ORANGE, string);
		for(new i; i<Max_Players; i++)
		{
			SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
	    }
	    	DisablePlayerCheckpoint(PlayerInExportVehicle);
	    	KillTimer(RoundTimer);

//		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
   		SetVehicleToRespawn(ExportVehicle);
   		ExportVehicle = 0;
		CarExportVehicleValue = 0;
		GameTimeLeft = 0;
		IsGameStartedCE = 0;
		SetTimer("StartGame",(CarExportGameTimer*1000), 0);

			if (killerid!=PlayerInExportVehicle)
			{
			new string[MAX_STRING];
			format(string, sizeof(string), "CarExport: Ебааа! Чуваг %s убил тачку и получил половину бабла!", oGetPlayerName(killerid));
			SendClientMessageToAll(COLOR_ORANGE, string);
			oGivePlayerMoney(killerid, CarExportVehicleValue/2 , 1);
			}
		PlayerInExportVehicle=INVALID_PLAYER_ID;
		return 1;
	}
	return 0;
}




public CarExport_OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2)
	{
	    PlayerVehicle[playerid] = GetPlayerVehicleID(playerid);
	    if(IsPlayerInVehicle(playerid, ExportVehicle))
	    {
            SetPlayerCheckpoint(playerid, ExportX, ExportY, ExportZ, Checkpointsize);
			new string[128];
			new PlayerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
			format(string, sizeof(string), "CarExport: Хобана! Ты сел в ту самую тачку! У тя %d секунд шоп доставить ее дилеру!", GameTimeLeft);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			format(string, sizeof(string), "CarExport: %s доставил тачилу! У вас %d сек, чоп ебнуть его и не дать доставить тачку дилеру!", PlayerName, GameTimeLeft);
			for(new i; i<Max_Players; i++)
			{
				if( i != playerid)
				{
					SendClientMessage(i, COLOR_ORANGE, string);
				}
			}
			PlayerInExportVehicle = playerid;
		}
	}
	if(oldstate == 2)
	{
	    if(PlayerVehicle[playerid] == ExportVehicle)
		{
		    DisablePlayerCheckpoint(playerid);
		    PlayerInExportVehicle = -1;
		}
		PlayerVehicle[playerid] = -1;
	}
	return 1;
}

public OnPlayerEnterCarExCheckpoint(playerid)
{
	if(IsGameStartedCE == 1)
	{
	    if(IsPlayerInVehicle(playerid, ExportVehicle) && GetPlayerState(playerid) == 2)
		{
//		    	GetVehiclePos(ExportVehicle, CarX, CarY, CarZ);
//			GetVehicleZAngle(ExportVehicle, CarA);
//			SetTimerEx("TeleportCar", 2500, 0, "dffffi", ExportVehicle, CarX, CarY, CarZ, CarA, playerid);

		    new string[128], PlayerName[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
			DisablePlayerCheckpoint(playerid);
			SetVehicleToRespawn(ExportVehicle);
//			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			format(string, sizeof(string), "CarExport: %s доставил '%s' дилеру и заработал $%d", PlayerName,GetVehicleName(GetVehicleModel(ExportVehicle)), CarExportVehicleValue);
			SendClientMessageToAll(COLOR_GREEN, string);
//			format(string, sizeof(string), "CarExport: A new Exportgame will start in %d seconds!!", CarExportGameTimer);
//			SendClientMessageToAll(COLOR_GREEN, string);
			format(string, sizeof(string), "~y~Winner!!! ~n~~n~You won: ~n~~b~$%d", CarExportVehicleValue);
			GameTextForPlayer(playerid, string, 8000, 3);
			PlaySoundForPlayer(playerid, 1185);

			oGivePlayerMoney(playerid, CarExportVehicleValue, 1);
			SetTimerEx("StopSound", 10000, 3, "i", playerid);
			SetTimer("StartGame",(CarExportGameTimer*1000), 0);
			for(new i; i<Max_Players; i++)
		    {
		    	SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
			}
			KillTimer(RoundTimer);
			GameTimeLeft = 0;
			ExportVehicle = 0;
			CarExportVehicleValue = 0;
			IsGameStartedCE = 0;
			PlayerInExportVehicle = -1;
		}
	}
	return 1;
}




forward StartGame();
public StartGame()
{
 	if(IsGameStartedCE == 0)
 	{
    	StartNewGame();
	}
}

StartNewGame()
{
	if(CarExport_Enabled == 1)
	{
		new string[128];
//		new CarExportVehicleValue[256];
//		CarExportVehicleValue = CarExportMinValue+(random(CarExportMaxValue-CarExportMinValue));
		SendClientMessageToAll(COLOR_YELLOW, "Игра началазь!");
		ChooseExportCar();
		format(string, sizeof(string), "CarExport: Дилеру нады тачку '%s', платид за нее $%d. Нук ебните тачку и пригоните закащеку.", GetVehicleName(GetVehicleModel(ExportVehicle)), CarExportVehicleValue);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, "CarExport: Ана абазначена на карте жолтым маркером! Игрок, доставивший заказ наебывает остальных, ясен пень.");
		for(new i; i<Max_Players; i++)
		{
		    SetVehicleParamsForPlayer(ExportVehicle, i, 1, 0);
		}
		IsGameStartedCE = 1;
		GameTimeLeft = CarExportRoundTime;
		RoundTimer = SetTimer("StopGame", 10000, 1);
	}
}

stock IsVehicleEmpty(VehicleID)
{
	for(new i; i<Max_Players; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(IsPlayerInVehicle(i, VehicleID))
	        {
				return 0;
			}
		}
	}
	return 1;
}

ChooseExportCar()
{
	new iscarfound;
	new randomvehicle;
	new model;
	for(new i=1; i<TotalVehicles(); i++)
	{
		randomvehicle = random(TotalVehicles());
		if(UseCustomVehicles == 1)
		{
			if(CEIsExportVehicle[randomvehicle] == 1)
		    	{
		        	if(IsVehicleEmpty(randomvehicle))
		        	{
 				iscarfound = 1;
 				ExportVehicle = randomvehicle;
				}
			}
		}
		else
		{
		    model = GetVehicleModel(randomvehicle);
			for(new a; a<sizeof(ExportableVehicles); a++)
			{
			    	if(model == ExportableVehicles[a][0])
			    	{
			        	if(IsVehicleEmpty(randomvehicle))
			        	{
	 					iscarfound = 1;
	 					ExportVehicle = randomvehicle;
						break;
					}
				}
			}
		}
	if(iscarfound == 1) break;
	}
}

/*
TotalVehicles()
{
	new vid;
	vid = CreateVehicle(411, 0, 0, 0, 0, -1, -1, 10);
	DestroyVehicle(vid);
	vid--;
	return vid;
}
*/


forward StopGame();
public StopGame()
{
	if(GameTimeLeft == 300){SendClientMessageToAll(COLOR_ORANGE, "CarExport: Суки, у вас 5 минут чтоп спиздеть мафынку!");}
	if(GameTimeLeft == 60){SendClientMessageToAll(COLOR_ORANGE, "CarExport: Не ибите моск! 1 минута осталась!");}
	if(GameTimeLeft == 10){SendClientMessageToAll(COLOR_ORANGE, "CarExport: Ебануц. Кароч дилер ждет 10 сек и нахуй шлет этот заказ.");}
	if(GameTimeLeft == 0)
	{
	    KillTimer(RoundTimer);
//	    new string[128];
		SendClientMessageToAll(COLOR_RED, "CarExport: Вы бля тупицы! Проебали тачку! Она нах не нужна никому теперь!");
//		format(string, sizeof(string), "In %d seconds (%d minutes) a new game will start!", CarExportGameTimer, (CarExportGameTimer/60));
//        SendClientMessageToAll(COLOR_ORANGE, string);
        if(IsPlayerInVehicle(PlayerInExportVehicle, ExportVehicle))
        {
            GameTextForPlayer(PlayerInExportVehicle, "~r~You Failed!", 5000, 3);
            DisablePlayerCheckpoint(PlayerInExportVehicle);
		}
        IsGameStartedCE = 0;
        SetVehicleToRespawn(ExportVehicle);
        for(new i; i<Max_Players; i++)
        {
       		SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
		}
		ExportVehicle = 0;
		CarExportVehicleValue = 0;
		SetTimer("StartGame",(CarExportGameTimer*1000), 0);
		
	}
	GameTimeLeft -= 10;
}

forward StopSound(playerid);
public StopSound(playerid)
{
	PlaySoundForPlayer(playerid, 1186);
}

forward TeleportCar(carid, Float:X, Float:Y, Float:Z, Float:A, playerid);
public TeleportCar(carid, Float:X, Float:Y, Float:Z, Float:A, playerid)
{
	SetVehiclePos(carid, X, Y, Z);
	SetVehicleZAngle(carid, A);
	PutPlayerInVehicle(playerid, carid, 0);
}

/*
CreateMenus()
{
	new string[64];
    MainMenu = CreateMenu(" ", 1, 150, 150, 300, 40);
    SetMenuColumnHeader(MainMenu,0,"Settings");
    AddMenuItem(MainMenu, 0, "Set Min. CarValue");
    AddMenuItem(MainMenu, 0, "Set Max. CarValue");
    AddMenuItem(MainMenu, 0, "Set CarExportGameTimer");
    AddMenuItem(MainMenu, 0, "Set CarExportRoundTime");
    AddMenuItem(MainMenu, 0, "Set New Export-Location");
    AddMenuItem(MainMenu, 0, "Set Checkpointsize");
    AddMenuItem(MainMenu, 0, "Start/Stop Game");
    AddMenuItem(MainMenu, 0, "Exit");
    
    MinValueMenu = CreateMenu("Min. CarValue", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d dollar", CarExportMinValue);
    SetMenuColumnHeader(MinValueMenu,0, string);
    AddMenuItem(MinValueMenu, 0, "+5000");
    AddMenuItem(MinValueMenu, 0, "+1000");
    AddMenuItem(MinValueMenu, 0, "+100");
    AddMenuItem(MinValueMenu, 0, "+10");
    AddMenuItem(MinValueMenu, 0, "-10");
    AddMenuItem(MinValueMenu, 0, "-100");
    AddMenuItem(MinValueMenu, 0, "-1000");
    AddMenuItem(MinValueMenu, 0, "-5000");
    AddMenuItem(MinValueMenu, 0, "Done");
    
    MaxValueMenu = CreateMenu("Max. CarValue", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d dollar", CarExportMaxValue);
    SetMenuColumnHeader(MaxValueMenu,0, string);
    AddMenuItem(MaxValueMenu, 0, "+5000");
    AddMenuItem(MaxValueMenu, 0, "+1000");
    AddMenuItem(MaxValueMenu, 0, "+100");
    AddMenuItem(MaxValueMenu, 0, "+10");
    AddMenuItem(MaxValueMenu, 0, "-10");
    AddMenuItem(MaxValueMenu, 0, "-100");
    AddMenuItem(MaxValueMenu, 0, "-1000");
    AddMenuItem(MaxValueMenu, 0, "-5000");
    AddMenuItem(MaxValueMenu, 0, "Done");
    
    FrequencyMenu = CreateMenu("CarExportGameTimer", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d seconds", CarExportGameTimer);
    SetMenuColumnHeader(FrequencyMenu,0, string);
    AddMenuItem(FrequencyMenu, 0, "+600 seconds");
    AddMenuItem(FrequencyMenu, 0, "+60 seconds");
    AddMenuItem(FrequencyMenu, 0, "+10 seconds");
    AddMenuItem(FrequencyMenu, 0, "-10 seconds");
    AddMenuItem(FrequencyMenu, 0, "-60 seconds");
    AddMenuItem(FrequencyMenu, 0, "-600 seconds");
    AddMenuItem(FrequencyMenu, 0, "Done");
    
    RoundTimeMenu = CreateMenu("CarExportRoundTime", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current: %d seconds", CarExportRoundTime);
    SetMenuColumnHeader(RoundTimeMenu,0, string);
    AddMenuItem(RoundTimeMenu, 0, "+600 seconds");
    AddMenuItem(RoundTimeMenu, 0, "+60 seconds");
    AddMenuItem(RoundTimeMenu, 0, "+10 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-10 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-60 seconds");
    AddMenuItem(RoundTimeMenu, 0, "-600 seconds");
    AddMenuItem(RoundTimeMenu, 0, "Done");
    
    LocationMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Are you sure?");
    SetMenuColumnHeader(LocationMenu,0, string);
    AddMenuItem(LocationMenu, 0, "No");
    AddMenuItem(LocationMenu, 0, "Yes");
    
    CheckpointsizeMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), "Current Size: %d", Checkpointsize);
    SetMenuColumnHeader(CheckpointsizeMenu,0, string);
    AddMenuItem(CheckpointsizeMenu, 0, "+1");
    AddMenuItem(CheckpointsizeMenu, 0, "-1");
    AddMenuItem(CheckpointsizeMenu, 0, "Done");
    
    StartNewGameMenu = CreateMenu("Export-Location", 1, 150, 150, 300, 40);
    format(string, sizeof(string), " ", Checkpointsize);
    SetMenuColumnHeader(StartNewGameMenu,0, string);
    AddMenuItem(StartNewGameMenu, 0, "Start New Game");
    AddMenuItem(StartNewGameMenu, 0, "Stop Current Game");
    AddMenuItem(StartNewGameMenu, 0, "Back");

    

}

UpdateColumnHeader(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	new string[64];
	if(Current == MinValueMenu)
	{
	    format(string, sizeof(string), "Current: %d dollar", CarExportMinValue);
	    SetMenuColumnHeader(MinValueMenu,0, string);
	    ShowMenuForPlayer(MinValueMenu, playerid);
	}
	if(Current == MaxValueMenu)
	{
	    format(string, sizeof(string), "Current: %d dollar", CarExportMaxValue);
	    SetMenuColumnHeader(MaxValueMenu,0, string);
	    ShowMenuForPlayer(MaxValueMenu, playerid);
	}
	if(Current == FrequencyMenu)
	{
	    format(string, sizeof(string), "Current: %d seconds", CarExportGameTimer);
	    SetMenuColumnHeader(FrequencyMenu,0, string);
	    ShowMenuForPlayer(FrequencyMenu, playerid);
	}
	if(Current == RoundTimeMenu)
	{
	    format(string, sizeof(string), "Current: %d seconds", CarExportRoundTime);
	    SetMenuColumnHeader(RoundTimeMenu,0, string);
	    ShowMenuForPlayer(RoundTimeMenu, playerid);
	}
	if(Current == CheckpointsizeMenu)
	{
	    format(string, sizeof(string), "Current Size: %d", Checkpointsize);
	    SetMenuColumnHeader(CheckpointsizeMenu,0, string);
	    ShowMenuForPlayer(CheckpointsizeMenu, playerid);
	}
}
*/


SaveSettings()
{
	dini_IntSet(SaveFile, "MinValue", CarExportMinValue);
    	dini_IntSet(SaveFile, "MaxValue", CarExportMaxValue);
    	dini_IntSet(SaveFile, "CarExportGameTimer", CarExportGameTimer);
    	dini_IntSet(SaveFile, "CarExportRoundTime", CarExportRoundTime);
    	dini_FloatSet(SaveFile, "ExportX", ExportX);
    	dini_FloatSet(SaveFile, "ExportY", ExportY);
    	dini_FloatSet(SaveFile, "ExportZ", ExportZ);
    	dini_IntSet(SaveFile, "Checkpointsize", Checkpointsize);
}

stock AddExportVehicle(model, Float:X, Float:Y, Float:Z, Float:Angle, color1, color2)
{
	new newvid;
	newvid = AddStaticVehicle(model, X, Y, Z, Angle, color1, color2);
	CEIsExportVehicle[newvid] = 1;
}




public CarExport_OnPlayerExitVehicle(playerid, vehicleid)
{
	if (vehicleid==ExportVehicle)
	{
		new string[128];
		format(string, sizeof(string), "CarExport: Баран! Нук сядь назад в тачку!");
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "CarExport: Прикиньте, %s бросил тачу! Нук подберите скорее.", oGetPlayerName(playerid));
		SendClientMessageToAll(COLOR_ORANGE, string);
	}
	return 1;
}




////////////////////

public CarExport_OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/settings", cmdtext, true, 10) == 0)
	{
	    if(!IsPlayerAdmin(playerid)) return 0;
//		ShowMenuForPlayer(MainMenu, playerid);
		TogglePlayerControllable(playerid, 0);
		return 1;
	}
	return 0;
}


/*
			    if(IsGameStartedCE == 1)
				{
				    GameTextForPlayer(playerid, "~r~A game is already started!", 4000, 4);
				    ShowMenuForPlayer(StartNewGameMenu, playerid);
				}
				else
				{
				    SendClientMessageToAll(COLOR_ORANGE, "An admin started a new export-game!");
				    StartNewGame();
				    TogglePlayerControllable(playerid, 1);
				}
			}
			case 1:
			{
			    if(IsGameStartedCE == 0)
				{
				    GameTextForPlayer(playerid, "~r~Ther is no game started!", 4000, 4);
				    ShowMenuForPlayer(StartNewGameMenu, playerid);
				}
				else
				{
				    SendClientMessageToAll(COLOR_ORANGE, "An admin stoped the current export-game!");
				    KillTimer(RoundTimer);
				    new string[128];
					format(string, sizeof(string), "In %d seconds (%d minutes) a new game will start!", CarExportGameTimer, (CarExportGameTimer/60));
			        SendClientMessageToAll(COLOR_ORANGE, string);
			        if(IsPlayerInVehicle(PlayerInExportVehicle, ExportVehicle))
			        {
					}
			        IsGameStartedCE = 0;
			        SetVehicleToRespawn(ExportVehicle);
			        for(new i; i<Max_Players; i++)
			        {
			       		SetVehicleParamsForPlayer(ExportVehicle, i, 0, 0);
					}
					ExportVehicle = 0;
					CarExportVehicleValue = 0;
					SetTimer("StartGame",(CarExportGameTimer*1000), 0);
					TogglePlayerControllable(playerid, 1);
 				}
			}
		}
	}
	return 1;
}
*/

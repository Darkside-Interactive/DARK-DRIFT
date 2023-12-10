//Automatic Gates
//Created by FP (SCALOlaz)

#pragma tabsize 0

#include <a_samp>
#include <a_players>
#include <player>

forward Gates_OnGameModeInit();
forward Gates_OnGameModeExit();
forward GatesCheckTimer();

new Gates_Enabled = 1;
new Gates_Enter = 1;

#define GatesMaxObjects 17
new GatesObject[GatesMaxObjects];
new GatesPlayerViewInfo[MAX_PLAYERS][GatesMaxObjects];

new Float:Gates[GatesMaxObjects][9] = {
// CLOSED COORDS (X, Y, Z, xr, yr, zr) / OPEN COORDS (x, y, z) 
//Police departmemts
{1583.98, -1637.81, 12.772, 0.000, 0.000, 0.000,   1592.58,  -1637.81, 12.772},	//LS Police
{-1571.63, 665.58,  6.40,   0.000, 0.000, 270.000, -1571.63, 674.57,   6.40},	//SF Police 1
{-1681.85, 680.43,  19.05,  0.000, 0.000, 90.000,  -1681.85, 685.73,   19.05},	//SF Police 2
{2236.98,  2449.12, 9.849,  0.000, 0.000, 90.000,  2236.98,  2457.52,  9.849},	//LV Police 1
{2336.4,   2447.41, 4.849,  0.000, 0.000, 240.000, 2332.3,   2440.31,  4.849},	//LV Police 2
//Airports
{1958.87, -2190.0, 13.585, 0.000, 0.000, 180.000, 1953.87, -2190.0, 13.585},	//LS Airport Gate left
{1964.34, -2190.0, 13.585, 0.000, 0.000, 180.000, 1969.34, -2190.0, 13.585},	//LS Airport Gate right
{1706.57, 1610.25, 10.007, 0.000, 0.000, 73.200, 1707.91, 1615.08, 10.007}, 	//LV Airport Gate left
{1704.99, 1605.0, 10.007, 0.000, 0.000, 73.200, 1703.52, 1600.25, 10.007},	//LV Airport Gate right
{-1543.62, -432.462, 6.034, 0.000, 0.000, 315.000, -1540.04, -436.04, 6.034},	//SF Airport Gate left
{-1547.51, -428.585, 6.034, 0.000, 0.000, 315.000, -1551.12, -424.932, 6.034},	//SF Airport Gate right
{-1218.14, 68.866, 14.181, 0.000, 0.000, 225.200, -1214.32, 72.703, 14.181}, 	//SF Airport Gate left
{-1222.96, 53.819, 14.181, 0.000, 0.000, 225.200, -1226.77, 49.994, 14.181},	//SF Airport Gate right
//Medical Centers



{921.891, -1216.55, 19.59, 0.000, 0.000, 90.000, 921.891, -1207.55, 19.59},	//LS Cinema Studio
{921.891, -1225.76, 19.59, 0.000, 0.000, 90.000, 921.891, -1234.76, 19.59},	//LS Cinema Studio
//Other Gates
{2517.41, 2346.43, 13.367, 0.000, 0.000, 90.000, 2517.41, 2346.43, 18.867},	//LV Подземный гараж 1
{2498.48, 2292.28, 11.453, 0.000, 0.000, 270.000, 2498.48, 2298.58, 11.453}	//LV Подземный гараж. Вторые ворота
};

//Информация для ворот: Моделька, 0-еще закрыто 1-уже открыто, кому доступно
new GatesInfo[GatesMaxObjects][5] = {
// MODEL ID, PARAM, Access Level, Speed, TYPE (not used in this release)
//Police departmemts
{969, 0, 5, 6, 0},	//LS Police
{969, 0, 5, 6, 0},	//SF Police Bottom Gates
{969, 0, 5, 6, 0},	//SF Police Top Gates
{969, 0, 5, 6, 0},	//LV Police Top Gates
{969, 0, 5, 6, 0},	//LV Police Bottom Gates
//Airports
{988, 0, 9, 3, 0},	//LS Airport Gate left
{988, 0, 9, 3, 0},	//LS Airport Gate right
{988, 0, 10, 3, 0}, //LV Airport Gate left
{988, 0, 10, 3, 0}, //LV Airport Gate right
{988, 0, 11, 3, 0}, //SF Airport Gate left
{988, 0, 11, 3, 0}, //SF Airport Gate right
{988, 0, 11, 3, 0}, //SF Airport Gate left
{988, 0, 11, 3, 0}, //SF Airport Gate right
//Medical Centers



{971, 0, 6, 2, 0}, //LS Cinema Studio
{971, 0, 6, 2, 0}, //LS Cinema Studio
//Other gates
{971, 0, 24, 5, 0}, //LV Подземн.гараж недалеко от полиц
{975, 0, 24, 4, 0} //LV вторые ворота
};

forward Gates_Config();
public Gates_Config()
{
	if (!dini_Exists(ConfigDB)) return;

	new temp[MAX_STRING];
	set(temp,dini_Get(ConfigDB,"Gates_Enabled"));
	if (strlen(temp) > 0) Gates_Enabled = strval(temp); 
	else { valstr(temp,Gates_Enabled); dini_Set(ConfigDB,"Gates_Enabled",temp); }

	set(temp,nullstr);	
	set(temp,dini_Get(ConfigDB,"Gates_Enter"));
	if (strlen(temp) > 0) Gates_Enter = strval(temp); 
	else { valstr(temp,Gates_Enter); dini_Set(ConfigDB,"Gates_Enter",temp); }
}

public Gates_OnGameModeInit(){
	Gates_Config();
	if (Gates_Enabled==0) return 0;
	for (new h = 0; h < GatesMaxObjects; h++)
	{
	GatesObject[h]=CreateObject(GatesInfo[h][0], Gates[h][0], Gates[h][1], Gates[h][2], Gates[h][3], Gates[h][4], Gates[h][5]);
	GatesInfo[h][1]=0;	//Закрыть нах все ворота
	}
	SetTimer("GatesCheckTimer", 1000, 1);
	WriteLog("Automatic Gates Load");
	return 0;
}

public Gates_OnGameModeExit(){
	for (new h = 0; h < GatesMaxObjects; h++)
	{
	DestroyObject(GatesObject[h]);
	}
	return 0;
}

public GatesCheckTimer()
{
		for (new h = 0; h < GatesMaxObjects; h++)
			{
				if (GatesInfo[h][1]==1 && !GatesIsAnyPlayerInCircle(Gates[h][0], Gates[h][1], 14, h) )
					{
					MoveObject(GatesObject[h],Gates[h][0], Gates[h][1], Gates[h][2], GatesInfo[h][3]);
					GatesInfo[h][1]=0;		//CLOSE GATE
					}
				if (GatesInfo[h][1]==0 && GatesIsAnyPlayerInCircle(Gates[h][0], Gates[h][1], 8, h) )
					{
					MoveObject(GatesObject[h],Gates[h][6], Gates[h][7], Gates[h][8], GatesInfo[h][3]);
					GatesInfo[h][1]=1;		//OPEN GATE
					}
			}
}
// Вот тут немного сложнее будет добавить права юзверей на ворота, ибо я нахомутал тупо с проверкой ворот. )))
// Я знаю кто справится!!! Нискажу вам. Он сам все знает. Ники-кибарг, ты можешь.
// Enjoy

forward GatesIsAnyPlayerInCircle(Float:x,Float:y,radius, gates);
public GatesIsAnyPlayerInCircle(Float:x,Float:y,radius, gates)
{
new players;
for (new id = 0; id < MAX_PLAYERS; id++)
	{
	if (IsPlayerConnected(id))
		{
		if (GetPlayerDistanceToPoint(id,x,y) <= radius)
			{
			if (IsPlayerAdmin(id)) {players++; continue;}	//Админу РКОН все покуй
			if (Gates_Enter==0) return false;

			if (players<1 && (Player[id][Level] < GatesInfo[gates][2]) )	//Уровень игрока меньше чем надо
				{
				if (GatesPlayerViewInfo[id][gates]==0)
					{
					new message[MAX_STRING];
					format(message, sizeof(message), lang_texts[589], GatesInfo[gates][2]);
					SendPlayerFormattedText(id, message, 0, COLOUR_RED);
					GatesPlayerViewInfo[id][gates]=1;	//Уровень мелковат
					}
				GatesPlayerViewInfo[id][gates]=1;
				continue;
				}
			// if (GatesInfo[gates][4]==1 && Player[id][Job]!=1) continue; //Должен быть копом!


			players++;
//			GatesPlayerViewInfo[id][gates]=0;
			}

		else 	{
			GatesPlayerViewInfo[id][gates]=0;
			}
		}
	}
if (players>0) {return true;}
 else {return false;}
}
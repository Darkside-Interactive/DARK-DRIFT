// Oysters - modelid: 953

/*
Created August 3th 2008 by =>SCALOlaz<=
*/

#if defined _oysters_included
  #endinput
#endif

#define _oysters_included
#pragma library oysters
#pragma tabsize 0

#include <a_samp>
#include <a_players>
#include <player>

forward OystersInit();
forward OystersOnPlayerPickUpPickup(playerid, pickupid);
forward OystersLast();

#define OystersMAX 50

new OystersModel=953;
new OystersPicks[OystersMAX];
new OystersPick[OystersMAX];

// Oysters - modelid: 953
new Float:Oysters[OystersMAX][3] = {
//X      Y         Z
{979.0, -2210.0, -3.0},
{2750.0, -2584.0, -5.0},
{1279.0, -806.0, 85.0},
{2945.1299, -2051.9299, -3.0},
{67.0, -1018.0, -5.0},
{2327.0, -2662.0, -5.0},
{2621.0, -2506.0, -5.0},
{1249.0, -2687.0, -1.0},
{725.0, -1849.0, -5.0},
{723.0, -1586.0, -3.0},
{155.0, -1975.0, -8.0},
{1968.0, -1203.0, 17.0},
{-2657.0, 1564.0, -6.0},
{-1252.0, 501.0, -8.0},
{-1625.0, 4.0, -10.0},
{-1484.0, 1489.0, -10.0},
{-2505.4058, 1543.7236, -22.5553},
{-2727.0, -469.0, -5.0},
{-1266.0, 966.0, -10.0},
{-1013.0, 478.0, -7.0},
{-1364.0, 390.0, -5.0},
{2578.0, 2382.0, 16.0},
{2090.0, 1898.0, 8.0},
{2130.0, 1152.0, 7.0},
{2013.0, 1670.0, 7.0},
{2531.0, 1569.0, 9.0},
{2998.0, 2998.0, -10.0},
{-832.0, 925.0, -2.0},
{486.0, -253.0, -4.0},
{-90.0, -910.0, -5.0},
{26.43, -1320.9399, -10.04},
{-207.0, -1682.0, -8.0},
{-1672.0, -1641.0, -2.0},
{-1175.0, -2639.0, -2.5},
{-1097.0, -2858.0, -8.0},
{-2889.0, -1042.0, -9.0},
{-659.0, 874.0, -2.0},
{-955.0, 2628.0, 35.0},
{-1066.0, 2197.0, 32.0},
{40.0, -531.0, -8.0},
{-765.0, 247.0, -8.0},
{2098.0, -108.0, -2.0},
{2767.0, 470.0, -8.0},
{-783.0, 2116.0, 35.0},
{-821.0, 1374.0, -8.0},
{-2110.5, 2329.72, -7.5},
{-1538.0, 1708.0, -3.27},
{-2685.0, 2153.0, -5.0},
{796.0, 2939.0, -5.0},
{2179.0, 235.0, -5.0}
};

public OystersInit()
{
for (new op=0;op<50;op++)
	{
	OystersPick[op]=CreatePickup(OystersModel,15,Oysters[op][0],Oysters[op][1],Oysters[op][2]);
	OystersPicks[op]=1;
	}
}

public OystersOnPlayerPickUpPickup(playerid, pickupid)
{
for (new op=0;op<OystersMAX;op++)
	{
		if (OystersPicks[op]==1)
		{
		if( (pickupid == OystersPick[op]) && IsPlayerInCircle(playerid, Oysters[op][0],Oysters[op][1], 4) )
			{
//	    		PlaySoundForPlayer(playerid, 1150);
	    		DestroyPickup(OystersPick[op]);
			OystersPicks[op]=0;

			GivePlayerXP(playerid, 4500, 1);
			oGivePlayerMoney(playerid, 100000, 1);

// Добавить в стату игрока устрицы и подковы! В админке - вывод статы
//
	    		new string[MAX_STRING];
			format(string, MAX_STRING, "SERVER: %s(%d) Подобрал устрицу! В игре осталось ещё %d штук.", oGetPlayerName(playerid), playerid, OystersLast() );
			SendClientMessageToAll(COLOUR_LIGHTGREEN, string);
			print("[ SERVER ]: Oysters Picked");

//			return 1;
			}
		}
	}
//return 1;
}

public OystersLast()
{
new opc;
for (new op=0;op<OystersMAX;op++)
	{
	if (OystersPicks[op]==1)
		{
		opc++;
		}
	}
return opc;
}
// Horseshoes - modelid: 954

/*
Created August 3th 2008 by =>SCALOlaz<=
*/

#if defined _horseshoes_included
  #endinput
#endif

#define _horseshoes_included
#pragma library horseshoes
#pragma tabsize 0

#include <a_samp>
#include <a_players>
#include <player>

forward HorseShoesInit();
forward HorseShoesOnPlayerPickUpPickup(playerid, pickupid);
forward HorseShoesLast();
forward HorsesOystersGameMessage(playerid);

#define HorseshoesMAX 49

new HorseshoesModel=954;
new HorseshoesPicks[HorseshoesMAX];
new HorseshoesPick[HorseshoesMAX];

new Float:Horseshoes[HorseshoesMAX][3] = {
//X      Y         Z
{1224.0, 2617.0, 11.0},
{2323.0, 1284.0, 97.0},
{2035.0, 2305.0, 18.0},
{2491.0, 2263.0, 15.0},
{1433.0, 2796.0, 20.0},
{2071.0, 712.0, 11.0},
{2239.0, 1839.0, 18.0},
{2583.0, 2387.0, 16.0},
{2864.0, 857.0, 13.0},
{2612.0, 2200.0, -1.0},
{2274.0, 1507.0, 24.0},
{2184.0, 2529.0, 11.0},
{1863.0, 2314.0, 15.0},
{2054.0, 2434.0, 166.0},
{1603.0, 1435.0, 11.0},
{1362.92, 1015.24, 11.0},
{2058.7, 2159.1001, 16.0},
{2003.0, 1672.0, 12.0},
{2238.0, 1135.0, 49.0},
{1934.0601, 988.79, 22.0},
{1768.0, 2847.0, 9.0},
{1084.0, 1076.0, 11.0},
{2879.0, 2522.0, 11.0},
{2371.0, 2009.0, 15.0},
{1521.0, 1690.0, 10.6},
{2417.0, 1281.0, 21.0},
{1376.0, 2304.0, 15.0},
{1393.0, 1832.0, 12.34},
{984.0, 2563.0, 12.0},
{1767.0, 601.0, 13.0},
{2108.0, 1003.0, 46.0},
{2705.98, 1862.52, 24.41},
{2493.0, 922.0, 16.0},
{1881.0, 2846.0, 11.0},
{2020.0, 2352.0, 11.0},
{1680.3, 2226.8601, 16.11},
{1462.0, 936.0, 10.0},
{2125.5, 789.23, 11.45},
{2588.0, 1902.0, 15.0},
{919.0, 2070.0, 11.0},
{2173.0, 2465.0, 11.0},
{2031.25, 2207.3301, 11.0},
{2509.0, 1144.0, 19.0},
{2215.0, 1968.0, 11.0},
{2626.0, 2841.0, 11.0},
{2440.0801, 2161.0701, 20.0},
{1582.0, 2401.0, 19.0},
{2077.0, 1912.0, 14.0},
{970.0, 1787.0, 11.0}
};



public HorseShoesInit()
{
for (new hs=0;hs<HorseshoesMAX;hs++)
	{
	HorseshoesPick[hs]=CreatePickup(HorseshoesModel,3,Horseshoes[hs][0],Horseshoes[hs][1],Horseshoes[hs][2]);
	HorseshoesPicks[hs]=1;
	}
}

public HorseShoesOnPlayerPickUpPickup(playerid, pickupid)
{
for (new hs=0;hs<HorseshoesMAX;hs++)
	{
		if (HorseshoesPicks[hs]==1)
		{
		if( (pickupid == HorseshoesPick[hs]) && IsPlayerInCircle(playerid, Horseshoes[hs][0],Horseshoes[hs][1], 3) )
			{
//	    		PlaySoundForPlayer(playerid, 1150);
	    		DestroyPickup(HorseshoesPick[hs]);
			HorseshoesPicks[hs]=0;

			GivePlayerXP(playerid, 3000, 1);
			oGivePlayerMoney(playerid, 50000, 1);

	    		new string[MAX_STRING];
			format(string, MAX_STRING, "SERVER: %s(%d) Подобрал подкову! В игре осталось ещё %d штук", oGetPlayerName(playerid), playerid, HorseShoesLast() );
			SendClientMessageToAll(COLOUR_LIGHTGREEN, string);
			print("[ SERVER ]: Horseshoes Picked");
			return 1;
			}
		}
	}
return 1;
}

public HorseShoesLast()
{
new hsc;
for (new hs=0;hs<HorseshoesMAX;hs++)
	{
	if (HorseshoesPicks[hs]==1)
		{
		hsc++;
		}
	}
return hsc;
}


public HorsesOystersGameMessage(playerid)
{
new string[MAX_STRING];
format(string, MAX_STRING, "SERVER: Ещё несобрано %d подков и %d устриц. Поторопитесь, за каждую вы получите ХП и денег!", HorseShoesLast(), OystersLast() );
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
}

#include a_samp
#include Dini

#if defined _SpeedAC_included
	#endinput
#endif
#define _SpeedAC_included
#pragma library SpeedAC

/*
	SpeedHack Anti-Cheat
	for PROAdmin Adminscript
	BJIADOKC (c) 2011
*/

new PlayerSpeed[MAX_PLAYERS];
new Float:MaxSpeed2;

stock LoadIncludeAC()
{
	MaxSpeed2 = float(dini_Int("PROAdmin/AntiCheat/AntiCheatConfig.ini","MaxSpeed"));
	return 1;
}

stock GetPlayerSpeedEx(player)
{
	new Float:SP[3];
    if(IsPlayerInAnyVehicle(player)) GetVehicleVelocity(GetPlayerVehicleID(player), SP[0], SP[1], SP[2]);
	else GetPlayerVelocity(player, SP[0], SP[1], SP[2]);
    return floatround(floatsqroot(floatpower(SP[0],2.0)+floatpower(SP[1],2.0))*200.0);
}

stock IsPlayerOnBike(playerid)
{
 	if(IsPlayerInAnyVehicle(playerid))
 	{
 		new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  		switch(vehicleclass)
  		{
   			case 448:return 1;
   			case 461:return 1;
   			case 462:return 1;
   			case 463:return 1;
   			case 468:return 1;
   			case 521:return 1;
   			case 522:return 1;
   			case 523:return 1;
   			case 581:return 1;
   			case 586:return 1;
  		}
 	}
 	return 0;
}

stock IsPlayerInPlane(playerid)
{
 	if(IsPlayerInAnyVehicle(playerid))
 	{
  		new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  		switch(vehicleclass)
  		{
   			case 460:return 1;
   			case 464:return 1;
			case 476:return 1;
			case 511:return 1;
			case 512:return 1;
			case 513:return 1;
			case 519:return 1;
			case 520:return 1;
			case 539:return 1;
			case 553:return 1;
			case 577:return 1;
			case 592:return 1;
			case 593:return 1;
  		}
 	}
	return 0;
}

stock IsPlayerInCar(playerid) //By Sacky (Edited by Smugller)
{
 	if(IsPlayerInAnyVehicle(playerid))
 	{
  		new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  		switch(vehicleclass)
  		{
			   case 448:return 0;
			   case 461:return 0;
			   case 462:return 0;
			   case 463:return 0;
			   case 468:return 0;
			   case 521:return 0;
			   case 522:return 0;
			   case 523:return 0;
			   case 581:return 0;
			   case 586:return 0;
			   case 481:return 0;
			   case 509:return 0;
			   case 510:return 0;
			   case 430:return 0;
			   case 446:return 0;
			   case 452:return 0;
			   case 453:return 0;
			   case 454:return 0;
			   case 472:return 0;
			   case 473:return 0;
			   case 484:return 0;
			   case 493:return 0;
			   case 595:return 0;
			   case 417:return 0;
			   case 425:return 0;
			   case 447:return 0;
			   case 465:return 0;
			   case 469:return 0;
			   case 487:return 0;
			   case 488:return 0;
			   case 497:return 0;
			   case 501:return 0;
			   case 548:return 0;
			   case 563:return 0;
			   case 406:return 0;
			   case 444:return 0;
			   case 556:return 0;
			   case 557:return 0;
			   case 573:return 0;
			   case 460:return 0;
			   case 464:return 0;
			   case 476:return 0;
			   case 511:return 0;
			   case 512:return 0;
			   case 513:return 0;
			   case 519:return 0;
			   case 520:return 0;
			   case 539:return 0;
			   case 553:return 0;
			   case 577:return 0;
			   case 592:return 0;
			   case 593:return 0;
			   case 471:return 0;
  		}
  		return 1;
 	}
 	return 0;
}

stock bUpdate___(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		PlayerSpeed[playerid] = GetPlayerSpeedEx(playerid);
		if((PlayerSpeed[playerid] > floatround(MaxSpeed2) && IsPlayerInPlane(playerid)) || (PlayerSpeed[playerid] > floatround(MaxSpeed2-40.0) && IsPlayerInCar(playerid)) || (PlayerSpeed[playerid] > floatround(MaxSpeed2-80.0) && IsPlayerOnBike(playerid)))
		{
			SendClientMessageToAll(0xFF9900AA,"PROAdmin: {FF0000}Античит спалил чит (Скорость)");
			return 1;
		}
	}
	return 1;
}
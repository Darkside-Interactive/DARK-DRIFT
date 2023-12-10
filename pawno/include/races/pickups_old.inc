//Dynamic pickups module.
//Created by DracoBlue
//Tuned and fixed by MadCat

#define PICKUP_BRASS_KNUCKLES 331
#define PICKUP_GOLFCLUB 333
#define PICKUP_NITESTICK 334
#define PICKUP_KNIFE 335
#define PICKUP_BAT 336
#define PICKUP_SHOVEL 337
#define PICKUP_POOLSTICK 338
#define PICKUP_KATANA 338
#define PICKUP_CHAINSAW 341
#define PICKUP_DILDO 321
#define PICKUP_DILDO2 322
#define PICKUP_VIBRATOR1 323
#define PICKUP_VIBRATOR2 324
#define PICKUP_FLOWER 325
#define PICKUP_CANE 326
#define PICKUP_GRENADE 342
#define PICKUP_TEARGAS 343
#define PICKUP_MOLOTOV 344
#define PICKUP_MISSILE 345
#define PICKUP_COLT45 346
#define PICKUP_SILENCED 347
#define PICKUP_DEAGLE 348
#define PICKUP_SHOTGUN 349
#define PICKUP_SAWEDOFF 350
#define PICKUP_SHOTGSPA 351
#define PICKUP_UZI 352
#define PICKUP_MP5 353
#define PICKUP_HYDRAFLARE 354
#define PICKUP_AK47 355
#define PICKUP_M4 356
#define PICKUP_TEC9 372
#define PICKUP_RIFLE 357
#define PICKUP_SNIPER 358
#define PICKUP_ROCKETLAUNCHER 359
#define PICKUP_HEATSEEKER 360
#define PICKUP_FLAMETHROWER 361
#define PICKUP_MINIGUN 362
#define PICKUP_SACHEL 363
#define PICKUP_BOMB 364  // actually the detonator
#define PICKUP_SPRAYCAN 365
#define PICKUP_FIREEXTINGUISHER 366
#define PICKUP_CAMERA 367
#define PICKUP_NIGHTVISION_GOGGLES 368
#define PICKUP_THERMAL_GOGGLES 369
#define PICKUP_PARA 371
#define PICKUP_ARMOUR 1242
#define PICKUP_PACK 3013

forward Pickup_OnGameModeInit();
forward pickup_timer();

#define MAX_GAME_PICKUPS 399
#define MAX_PICKUPS 925
#define PICKUP_VIEW_DISTANCE 100

new Float:PICKUP_Pos[MAX_PICKUPS][CoordInfo];
new PICKUP_Info[MAX_PICKUPS][5];
new PickupsSpawned;
new PickupsAdded;

public Pickup_OnGameModeInit(){
	SetTimer("pickup_timer",1000,1);
	new logstring[MAX_STRING];
	format(logstring,sizeof(logstring),"Pickups System Loaded. Pickups: %d",PickupsAdded);
	printf ("SYSTEM: %s", logstring);
	WriteLog(logstring);
	return 0;
}

public pickup_timer(){
//	Debug("pickups.inc > pickup_timer - Start");
	for(new p;p<PickupsAdded;p++){
		for(new playerid;playerid<MAX_PLAYERS;playerid++){
		    if(IsPlayerConnected(playerid)){
		        if((PlayerDistanceTo(playerid,PICKUP_Pos[p][Coord_X],PICKUP_Pos[p][Coord_Y],PICKUP_Pos[p][Coord_Z],true) < PICKUP_VIEW_DISTANCE) || (GetPlayerVirtualWorld(playerid) != PICKUP_Info[p][2])){
					PICKUP_Info[p][4]++;
					break;
		        }
		    }
		}
		if(PICKUP_Info[p][4] > 0){
			if (PickupsSpawned <= MAX_GAME_PICKUPS){
				if (PICKUP_Info[p][3] == -1){
					PICKUP_CreatePickup(p);
				}
			}
		}else{
			if (PICKUP_Info[p][3] != -1){
		    		PICKUP_DestroyPickup(p);
			}
		}
		PICKUP_Info[p][4] = 0;
	}
//	Debug("pickups.inc > pickup_timer - Stop");
}

stock PICKUP_AddAPickup(model,type,Float:x,Float:y,Float:z,world){
//	Debug("pickups.inc > PICKUP_AddAPickup - Start");
	PICKUP_Info[PickupsAdded][0] = model;
	PICKUP_Info[PickupsAdded][1] = type;
	PICKUP_Pos[PickupsAdded][Coord_X] = x;
	PICKUP_Pos[PickupsAdded][Coord_Y] = y;
	PICKUP_Pos[PickupsAdded][Coord_Z] = z;
	PICKUP_Info[PickupsAdded][2] = world;
	PICKUP_Info[PickupsAdded][3] = -1;
	PickupsAdded++;
//	Debug("pickups.inc > PICKUP_AddAPickup - Stop");
}

stock PICKUP_CreatePickup(p){
//	Debug("pickups.inc > PICKUP_CreatePickup - Start");
	PICKUP_Info[p][3] = CreatePickup(PICKUP_Info[p][0],PICKUP_Info[p][1],PICKUP_Pos[p][Coord_X],PICKUP_Pos[p][Coord_Y],PICKUP_Pos[p][Coord_Z]);
	PickupsSpawned++;
//	Debug("pickups.inc > PICKUP_CreatePickup - Stop");
}

stock PICKUP_DestroyPickup(p){
//	Debug("pickups.inc > PICKUP_DestroyPickup - Start");
	DestroyPickup(PICKUP_Info[p][3]);
	PICKUP_Info[p][3] = -1;
	PickupsSpawned--;
//	Debug("pickups.inc > PICKUP_DestroyPickup - Stop");
}

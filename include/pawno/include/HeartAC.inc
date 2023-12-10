



#if defined _anticheat_included
	#endinput
#endif
#define _anticheat_included

#include <a_samp>
#include <dini>


#define aAIR_BREAK                   3
#define aSPEED_HACK                  3
#define aSPAWN_KILL                  0
#define aPA_HACK                     -1
#define aPH_HACK                     -1
#define aDRIVE_BY                    0
#define aVEHICLE_REPAIR_HACK         -1
#define aMONEY_HACK                  -1
#define aTUN_HACK                    1
#define aTP_HACK                     1


#define OFF_COLOR 0xAFAFAF88

//AntiCheat define's :
#define ANTI_TUNNING_HACK           dini_Int("anticheat/AntiCheats.ini", "AntiTunningHack")
#define ANTI_JET_PACK_HACK          dini_Int("anticheat/AntiCheats.ini", "AntiJetPackHack")
#define ANTI_LOCK_WEAPON_HACK       dini_Int("anticheat/AntiCheats.ini", "AntiLockWeaponHack")
#define ANTI_WEAPON_HACK            dini_Int("anticheat/AntiCheats.ini", "AntiWeaponHack")
#define ANTI_AMMO_HACK              dini_Int("anticheat/AntiCheats.ini", "AntiAmmoHack")
#define ANTI_TELEPORT_HACK          dini_Int("anticheat/AntiCheats.ini", "AntiTeleportHack")
#define ANTI_MONEY_HACK             dini_Int("anticheat/AntiCheats.ini", "AntiMoneyHack")
#define ANTI_SPEED_HACK             dini_Int("anticheat/AntiCheats.ini", "AntiSpeedHack")
#define ANTI_AIR_BREAK_HACK         dini_Int("anticheat/AntiCheats.ini", "AntiAirBreakHack")
#define ANTI_HEALTH_HACK            dini_Int("anticheat/AntiCheats.ini", "AntiHealthHack")
#define ANTI_ARMOUR_HACK            dini_Int("anticheat/AntiCheats.ini", "AntiArmourHack")
#define ANTI_DRIVE_BY               dini_Int("anticheat/AntiCheats.ini", "AntiDriveBy")
#define ANTI_SPAWN_KILL             dini_Int("anticheat/AntiCheats.ini", "AntiSpawnKill")
#define ANTI_VEH_HEALTH_HACK        dini_Int("anticheat/AntiCheats.ini","AntiVehicleRepairHack")
#define ANTI_FREEZE_HACK            dini_Int("anticheat/AntiCheats.ini", "AntiFreezeHack")
#define ANTI_SPECTATE_HACK          dini_Int("anticheat/AntiCheats.ini", "AntiSpectateHack")
#define ANTI_MIN_FPS                dini_Int("anticheat/AntiCheats.ini", "AntiMinFps")
#define ANTI_SLIDE_BUG              dini_Int("anticheat/AntiCheats.ini", "AntiSlideBug")
#define ANTI_BUG_C                  dini_Int("anticheat/AntiCheats.ini", "AntiBugC")
#define ANTI_PLAYER_PING            dini_Int("anticheat/AntiCheats.ini", "AntiPing")



//Params
#define AIR_BREAK                   1
#define SPEED_HACK                  2
#define SPAWN_KILL                  3
#define PA_HACK                     6
#define PH_HACK                     7
#define DRIVE_BY                    10
#define VEHICLE_REPAIR_HACK         11
#define MONEY_HACK                  12
#define PLAYER_FPS                  13
#define SLIDE_BUG                   14
#define ANTI_PING                   15
#define BUG_C                       16
#define TUNNING_VEHICLE             17
#define TELEPORT_VEHICLE            18

//Configuration :
#pragma tabsize 0
#define BanFile                     "anticheat/BanLog.ini"
#define MAX_SPEED_VEHICLE           380.0
#define MAX_WEAPONS_AMMO            99999
#define MAX_WEAPONS                 47
#define MIN_FPS 			        13
#define MAX_CHECKS 				    3
#define M_V                         20
#define MAX_HEALTH                  dini_Int("anticheat/CFG.ini", "MaxHealth")
#define MAX_ARMOUR                  dini_Int("anticheat/CFG.ini", "MaxArmour")
#define MAX_VEH_HEALTH              dini_Int("anticheat/CFG.ini", "MaxVehicleHealth")
#define MAX_PING			        dini_Int("anticheat/CFG.ini", "MaxPing")

//Pickups
#define PICKUP_TYPE_NONE            0
#define PICKUP_TYPE_WEAPON          1
#define PICKUP_TYPE_HEALTH          2
#define PICKUP_TYPE_ARMOUR          3

//xfunctions
#define xfunction%0(%1) forward%0(%1); public%0(%1)
#define ForEach(%0,%1) for(new %0 = 0; %0 != %1; %0++) if(IsPlayerConnected(%0))
/*----------------------------------------------------------------------------*/
new VehiclesTunInfo[MAX_VEHICLES][14];
enum VarACP
{
	aMoney,
	Float:xHealth,
    Float:xVehHealth,
	Float:xArmour,
	TimerX,
	TimerAFK,
	Float:aX,
	Float:aY,
	Float:aZ
};
new CheatPlayerInfo[MAX_PLAYERS][VarACP];
enum CFGac
{
	xAAirBreakHack,
	xAJetPackHack,
	xAMoneyHack,
	xAWeaponHack,
	xALockWeaponHack,
	xAAmmoHack,
	xASpeedHack,
	xAHealthHack,
    xAVehHealthHack,
    xASpectateHack,
	xAArmourHack,
    xATunHack,
    xATeleportHack,
    xAFreezeHack
};
new CheatCFG[CFGac];

enum CFGabo
{
	xASpawnKill,
    xASlideBug,
    xABugC,
	xAMinFPS,
	xAMaxPing,
	xADriveBy
};
new BugsOther[CFGabo];
//new InteriorArmour[5] = { 24,32,123,122,96};
new InteriorHealth[4]     = { 47,22,130,23};
//new InteriorCasino[4]     = { 48,62,133,23};
new xPlanes[]   = {417,425,447,460,469,476,487,488,497,511,512,513,519,520,548,553,563,577,592,593};
new xWeapons[]   = {500,777,11};// запретные ганы
new Float:PositionsCasino[][4] =
{
    {2241.2878,1617.1624,1006.1797,2.0},
    {2240.9736,1604.6592,1006.1797,6.0},
    {2242.5427,1592.8726,1006.1836,6.0},
    {2230.2124,1592.1426,1006.1832,6.0},
    {2230.4717,1604.4840,1006.1860,6.0},
    {2230.3298,1616.9272,1006.1799,3.0},
    {1956.9524,988.2533,992.4688,2.0},
    {1961.6155,993.0375,992.4688,2.0},
    {1963.7998,998.4406,992.4745,2.0},
    {1936.2885,987.1995,992.4745,2.0},
    {1944.9768,986.3937,992.4688,2.0},
    {1940.7397,990.9521,992.4609,2.0},
    {1940.0966,1005.8996,992.4688,6.0},
    {1938.8785,1014.1768,992.4688,6.0},
    {1938.8811,1021.4434,992.4688,6.0},
    {1966.5975,1006.6469,992.4745,6.0},
    {1966.5979,1014.1024,992.4688,6.0},
    {1939.8351,1029.9120,992.4688,6.0},
    {1956.8540,1047.3718,992.4688,6.0},
    {1961.3560,1042.8112,992.4688,6.0},
    {1963.8110,1037.1263,992.4745,6.0},
    {1961.7330,1025.8929,992.4688,10.0},
    {1961.7080,1010.3194,992.4688,10.0},
    {1966.5989,1029.7954,992.4745,6.0},
    {1961.4139,1017.8281,992.4688,10.0},
    {1966.5985,1021.7686,992.4688,6.0},
	{2251.9407,1586.1736,1006.1860,1.0},
    {2218.6785,1587.3448,1006.1749,1.0},
    {2219.2773,1591.7467,1006.1867,1.0},
    {2218.5408,1589.3229,1006.1840,1.0},
    {2218.6477,1593.6279,1006.1797,1.0},
    {2221.9260,1603.8285,1006.1797,1.0},
    {2218.5095,1603.8385,1006.1797,1.0},
    {2219.9597,1603.9216,1006.1797,1.0},
    {2216.3054,1603.7996,1006.1819,1.0},
    {2218.7310,1619.8046,1006.1794,1.0},
    {2218.9407,1617.8413,1006.1821,1.0},
    {2218.6680,1615.4681,1006.1797,1.0},
    {2218.6418,1613.2629,1006.1797,1.0},
	{2252.4272,1589.8412,1006.1797,5.0},
    {2252.4229,1596.6169,1006.1797,5.0},
    {2255.1565,1608.8784,1006.1860,1.0},
    {2254.8496,1610.8605,1006.1797,1.0},
    {2255.2917,1612.9167,1006.1797,1.0},
    {2255.0330,1614.8892,1006.1797,1.0},
    {2255.1213,1616.8284,1006.1797,1.0},
    {2255.2161,1618.8005,1006.1797,1.0},
    {2268.5281,1606.4894,1006.1797,1.0},
    {2270.4922,1606.8539,1006.1797,1.0},
    {2272.5693,1606.4473,1006.1797,1.0},
    {2274.5391,1607.0122,1006.1797,1.0},
    {2271.8447,1586.1633,1006.1797,1.0},
    {2261.4844,1586.1724,1006.1797,1.0},
	{2257.4507,1589.6555,1006.1797,5.0},
    {2267.8994,1589.8672,1006.1797,5.0},
    {2262.8486,1590.0260,1006.1797,5.0},
    {2272.6458,1589.7704,1006.1797,5.0},
    {2272.6533,1596.5682,1006.1797,5.0},
    {2270.4895,1596.4606,1006.1797,5.0},
    {2265.4441,1596.4299,1006.1797,5.0},
    {2260.0308,1596.7987,1006.1797,5.0},
    {2254.9907,1596.2410,1006.1797,5.0},
	{1128.7106,-1.9779,1000.6797,1.0},
    {1125.2388,1.6100,1000.6797,1.0},
    {1125.1249,-5.0489,1000.6797,1.0},
    {1127.4139,3.0199,1000.6797,1.0},
    {1135.0634,-3.8695,1000.6797,1.0},
    {1135.0861,0.6107,1000.6797,1.0},
    {1132.8943,-1.7139,1000.6797,1.0},
    {1125.3727,3.0315,1000.6797,1.0},
    {1119.0272,-1.4916,1000.6924,1.0}
};
new Float:RCP[][3]=
{
	{2065.3801,-1832.5280,13.68},
	{-99.7154,1117.5011,19.88},
	{719.8336,-456.7990,16.47},
	{-1420.4562,2583.2180,55.98},
	{-2424.8093,1021.1127,50.53},
	{1975.0587,2161.9456,11.21},
	{487.9699,-1741.5265,11.28},
	{1025.7683,-1023.8249,32.24},
	{-1904.9709,285.8506,41.18},
	{615.2845,-124.2390,997.7112},
	{616.7787,-74.8150,997.6274},
	{617.5302,-1.9900,1001.06}
};
enum WP
{
	xAmmo,
    xWeapon
};
new CheatWPInfo[MAX_PLAYERS][WP][20];

static xPlayerClassWeapons[200][3][2];
static xSpawnWeapons[MAX_PLAYERS][3][2];
static xWarns[MAX_PLAYERS][M_V];
static xHackCheck[MAX_PLAYERS][M_V];
xfunction UpdateAFK(playerid)
{
    if(GetPVarInt(playerid,"PlayerAFKUpdate") == 0)
		SetPVarInt(playerid,"GlobalAFKUpdate",GetPVarInt(playerid,"GlobalAFKUpdate")+1);
    else
		SetPVarInt(playerid,"GlobalAFKUpdate",0);
	if(GetPVarInt(playerid,"GlobalAFKUpdate") > 0)
	{
    	SetPVarInt(playerid,"AFK",1);
        SetPVarInt(playerid,"AFKTimeL",0);
	}
    else
	{
		SetPVarInt(playerid,"PlayerAFKUpdate",0);
		SetPVarInt(playerid,"AFK",0);
	}
    if(GetPVarInt(playerid,"AFK") == 0 && GetPVarInt(playerid,"AFKTimeL") != 3)
        SetPVarInt(playerid,"AFKTimeL",GetPVarInt(playerid,"AFKTimeL")+1);
	return true;
}
/*----------------------------------------------------------------------------*/
stock Float:xGetSpeed(playerid)
{
    new Float:xSpeed[3];
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),xSpeed[0], xSpeed[1], xSpeed[2]);
    else GetPlayerVelocity(playerid, xSpeed[0], xSpeed[1], xSpeed[2]);
    return floatmul(floatsqroot(floatadd(floatpower(xSpeed[0], 2.0), floatpower(xSpeed[1],2.0))), 200.0);
}
/*----------------------------------------------------------------------------*/
xfunction Xs_AC_GivePlayerMoney(playerid, money)
{
	CheatPlayerInfo[playerid][aMoney] += money;
	return GivePlayerMoney(playerid, money);
}
stock xGetWeaponModel(weaponid)
{
	switch(weaponid)
	{
	    case 1:      return 331;
		case 2..8:   return weaponid+331;
        case 9:      return 341;
		case 10..15: return weaponid+311;
		case 16..18: return weaponid+326;
		case 22..29: return weaponid+324;
		case 30,31:  return weaponid+325;
		case 32:     return 372;
		case 33..45: return weaponid+324;
		case 46:     return 371;
	}
	return 0;
}

#define IsValidWeapon(%0) (%0 >= 1 && %0 <= 18 || %0 >= 21 && %0 <= 46)
stock xGetWeaponSlot(weaponid)
{
	new slot;
	switch(weaponid)
	{
		case 0,1:          slot = 0;
		case 2 .. 9:       slot = 1;
		case 10 .. 15:     slot = 10;
		case 16 .. 18, 39: slot = 8;
		case 22 .. 24:     slot = 2;
		case 25 .. 27:     slot = 3;
		case 28, 29, 32:   slot = 4;
		case 30, 31:       slot = 5;
		case 33, 34:       slot = 6;
		case 35 .. 38:     slot = 7;
		case 40:           slot = 12;
		case 41 .. 43:     slot = 9;
		case 44 .. 46:     slot = 11;
	}
	return slot;
}
xfunction Xs_AC_GivePlayerWeapon(playerid,Weapon,ammo)
{
	new slot=xGetWeaponSlot(Weapon);
	if(IsValidWeapon(Weapon))
	{
		CheatWPInfo[playerid][xWeapon][slot] = Weapon;
		CheatWPInfo[playerid][xAmmo][slot] += ammo;
		GivePlayerWeapon(playerid,Weapon,ammo);
	}
    return 1;
}

xfunction Xs_AC_SetPlayerAmmo(playerid,weaponslot,ammo)
{
 	if(weaponslot > 0 && 12 > weaponslot)
 	{
		CheatWPInfo[playerid][xAmmo][weaponslot] = ammo;
		SetPlayerAmmo(playerid,weaponslot,ammo);
	}
    return 1;
}

xfunction Xs_AC_ResetPlayerWeapons(playerid)
{
	for(new i = 0; i < 12; i++)
	{
        CheatWPInfo[playerid][xWeapon][i] = 0;
        CheatWPInfo[playerid][xAmmo][i] = 0;
	}
    return ResetPlayerWeapons(playerid);
}
stock IsNotWeaponNoAmmo(WeaponID)
{
	new slot=xGetWeaponSlot(WeaponID);
	if(slot!=0 && slot!=1 && slot!=10)return 1;
	return 0;
}
xfunction xAddPlayerClass(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	new classid =AddPlayerClass(modelid,spawn_x,spawn_y,spawn_z,z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
	xPlayerClassWeapons[classid][0][0] = weapon1;
	xPlayerClassWeapons[classid][0][1] = weapon1_ammo;
	xPlayerClassWeapons[classid][1][0] = weapon2;
	xPlayerClassWeapons[classid][1][1] = weapon2_ammo;
	xPlayerClassWeapons[classid][2][0] = weapon3;
    xPlayerClassWeapons[classid][2][1] = weapon3_ammo;
    return classid++;
}

xfunction xAddPlayerClassEx(teamid,modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	new classid=AddPlayerClassEx(teamid,modelid,spawn_x,spawn_y,spawn_z,z_angle,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
	xPlayerClassWeapons[classid][0][0] = weapon1;
	xPlayerClassWeapons[classid][0][1] = weapon1_ammo;
	xPlayerClassWeapons[classid][1][0] = weapon2;
	xPlayerClassWeapons[classid][1][1] = weapon2_ammo;
	xPlayerClassWeapons[classid][2][0] = weapon3;
    xPlayerClassWeapons[classid][2][1] = weapon3_ammo;
    return classid++;
}

xfunction xSetSpawnInfo(playerid,team,skin,Float:x,Float:y,Float:z,Float:rotation,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo)
{
	if(!IsPlayerConnected(playerid))return 0;
    xSpawnWeapons[playerid][0][0] = weapon1;
    xSpawnWeapons[playerid][0][1] = weapon1_ammo;
    xSpawnWeapons[playerid][1][0] = weapon2;
    xSpawnWeapons[playerid][1][1] = weapon2_ammo;
    xSpawnWeapons[playerid][2][0] = weapon3;
    xSpawnWeapons[playerid][2][1] = weapon3_ammo;
	return SetSpawnInfo(playerid,team,skin,x,y,z,Float:rotation,weapon1,weapon1_ammo,weapon2,weapon2_ammo,weapon3,weapon3_ammo);
}
xfunction Xs_AC_ResetPlayerMoney(playerid)
{
	CheatPlayerInfo[playerid][aMoney] = 0;
	return ResetPlayerMoney(playerid);
}
xfunction Xs_AC_GetPlayerMoney(playerid)
{
	return CheatPlayerInfo[playerid][aMoney];
}

xfunction OFFVarTelep(playerid)
{
    return SetPVarInt(playerid,"Teleport",0);
}
xfunction Xs_AC_SetPlayerPos(playerid, Float:ix, Float:iy, Float:iz)
{
    SetPVarInt(playerid,"Teleport",1);
    if(xGetPlayerFPS(playerid) > 30)
        SetTimerEx("OFFVarTelep",2000,0,"d",playerid);
    if(xGetPlayerFPS(playerid) < 15)
        SetTimerEx("OFFVarTelep",5000,0,"d",playerid);
	return SetPlayerPos(playerid, ix, iy, iz);
}
xfunction Xs_AC_SetVehiclePos(playerid, Float:ix, Float:iy, Float:iz)
{
    SetPVarInt(playerid,"Teleport",1);
    if(xGetPlayerFPS(playerid) > 30)
        SetTimerEx("OFFVarTelep",2000,0,"d",playerid);
    if(xGetPlayerFPS(playerid) < 15)
        SetTimerEx("OFFVarTelep",5000,0,"d",playerid);
	return SetVehiclePos(playerid, ix, iy, iz);
}
xfunction Xs_AC_PutPlayerInVehicle(playerid,vehicleid, seatid)
{
    new Float:hpcar[MAX_PLAYERS];
	SetPVarInt(playerid,"Teleport",1);
    if(xGetPlayerFPS(playerid) > 30)
        SetTimerEx("OFFVarTelep",2000,0,"d",playerid);
    if(xGetPlayerFPS(playerid) < 15)
        SetTimerEx("OFFVarTelep",3000,0,"d",playerid);
	GetVehicleHealth(vehicleid,hpcar[playerid]);
	CheatPlayerInfo[playerid][xVehHealth] = hpcar[playerid];
	return PutPlayerInVehicle(playerid,vehicleid, seatid);
}
xfunction Xs_AC_TogglePlayerSpectating(playerid, toggle)
{
	if(toggle==1)
		SetPVarInt(playerid,"Spec",1);
	else
		SetPVarInt(playerid,"Spec",0);

	return TogglePlayerSpectating(playerid, toggle);
}
xfunction Xs_AC_TogglePlayerControllable(playerid, toggle)
{
	if(toggle==1)
		SetPVarInt(playerid,"Freeze",0);
	else
		SetPVarInt(playerid,"Freeze",1);

	return TogglePlayerControllable(playerid, toggle);
}
xfunction Xs_AC_RepairVehicle(playerid)
{
    CheatPlayerInfo[playerid][xVehHealth] = MAX_VEH_HEALTH;
    RepairVehicle(GetPlayerVehicleID(playerid));
    SetVehicleHealth(GetPlayerVehicleID(playerid),MAX_VEH_HEALTH);
    return 1;
}
xfunction Xs_AC_SetVehicleHealth(playerid,Float:health)
{
	if(health > MAX_VEH_HEALTH)
	{
    	CheatPlayerInfo[playerid][xVehHealth] = MAX_VEH_HEALTH;
    	SetVehicleHealth(playerid,CheatPlayerInfo[playerid][xVehHealth]);
	}
	else
	{
	    CheatPlayerInfo[playerid][xVehHealth]=health;
	    SetVehicleHealth(playerid,CheatPlayerInfo[playerid][xVehHealth]);
	}
    return 1;
}

xfunction Xs_AC_SetPlayerHealth(playerid,Float:health)
{
	if(health>MAX_HEALTH)
	{
    	CheatPlayerInfo[playerid][xHealth]=MAX_HEALTH;
    	SetPlayerHealth(playerid,CheatPlayerInfo[playerid][xHealth]);
	}
	else
	{
	    CheatPlayerInfo[playerid][xHealth]=health;
	    SetPlayerHealth(playerid,CheatPlayerInfo[playerid][xHealth]);
	}
    return 1;
}

xfunction Xs_AC_SetPlayerArmour(playerid,Float:armour)
{
	if(armour>MAX_ARMOUR)
	{
    	CheatPlayerInfo[playerid][xArmour]=MAX_ARMOUR;
    	SetPlayerArmour(playerid,CheatPlayerInfo[playerid][xArmour]);
	}
	else
	{
	    CheatPlayerInfo[playerid][xArmour]=armour;
	    SetPlayerArmour(playerid,CheatPlayerInfo[playerid][xArmour]);
	}
    return 1;
}
stock Float:xGetPointDistToPoint(Float:x1, Float:y1, Float:x2, Float:y2)
{
    return floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2) + floatpower(floatabs(floatsub(y2, y1)), 2));
}
stock IsPlayerInPlane(playerid)
{
	new x=GetVehicleModel(GetPlayerVehicleID(playerid));
	for(new i=0;i<sizeof(xPlanes);i++)
    {
	    if(x==xPlanes[i])
        {
	        return true;
        }
    }
	return false;
}
stock GetLockWeapon(playerid)//Проверка есть ли у игрока запрещеное оружие
{
	for(new i=0;i< sizeof(xWeapons); i++)
    {
	    if(GetPlayerWeapon(playerid) == xWeapons[i] && GetPlayerWeapon(playerid) != 0)
	    {
            return true;
        }
    }
	return false;
}
stock RepairCarPos(playerid)//Координат мест где можно починить тс
{
	for(new i=0;i<sizeof(RCP);i++)
    {
	    if(IsPlayerInRangeOfPoint(playerid,10.0,RCP[i][0],RCP[i][1],RCP[i][2]))
        {
	        return true;
        }
    }
	return false;
}
stock InteriorSetHealth(playerid)//интерьеры в которых можно пополнить хп
{
	for(new i=0;i<sizeof(InteriorHealth);i++)
    {
	    if(GetPlayerInterior(playerid) == InteriorHealth[i])
        {
	        return true;
        }
    }
	return false;
}

stock InteriorSetMoney(playerid)// интерьеры и позиции в которых можно заработать деньги(казино)
{
	for(new i=0;i<sizeof(PositionsCasino);i++)
    {
	    if(/*(GetPlayerInterior(playerid) == 48 || GetPlayerInterior(playerid) == 62 || GetPlayerInterior(playerid) == 133 || GetPlayerInterior(playerid) == 23 ) && */(IsPlayerInRangeOfPoint(playerid,PositionsCasino[i][3],PositionsCasino[i][0],PositionsCasino[i][1],PositionsCasino[i][2])))
        {
	        return true;
        }
    }
	return false;
}
stock TunningGarages(playerid)//Гаражи для тюнинга ТС
{
	for(new i=0;i<sizeof(RCP);i++)
    {
	    if(GetPlayerInterior(playerid) != 0 && IsPlayerInRangeOfPoint(playerid,10.0,RCP[i][0],RCP[i][1],RCP[i][2]))
        {
	        return true;
        }
    }
	return false;
}
new Float:xABHackPos2[MAX_PLAYERS][5];
new Float:xABHackPos[MAX_PLAYERS][7];
xfunction CheckPlayerAirBreak(playerid,Float:x,Float:y)
{
	GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
	xABHackPos2[playerid][2] = CheatPlayerInfo[playerid][aX];
    xABHackPos2[playerid][3] = CheatPlayerInfo[playerid][aY];
	if(xGetPointDistToPoint(xABHackPos2[playerid][0],xABHackPos2[playerid][1],xABHackPos2[playerid][2],xABHackPos2[playerid][3]) > 30)
        xAction(playerid,aAIR_BREAK,5,"Чит на полеты",AIR_BREAK);
    return TogglePlayerControllable(playerid,true);
}
xfunction GetXY2CoorPlayer(playerid)
{
    if(GetPVarInt(playerid,"Sequence") == 1)
    {
		GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
        xABHackPos[playerid][2] = CheatPlayerInfo[playerid][aX];
        xABHackPos[playerid][3] = CheatPlayerInfo[playerid][aY];
        xABHackPos[playerid][5] = CheatPlayerInfo[playerid][aZ];
        SetPVarInt(playerid,"Sequence",2);
        SetTimerEx("TestingPlayerCOOR",500,0,"d",playerid);
    }
    return 1;
}
xfunction TestingPlayerCOOR(playerid)
{
    if(GetPVarInt(playerid,"Sequence") == 2
    && GetPVarInt(playerid,"Teleport") == 0
    && GetPVarInt(playerid,"Spec") == 0
    && xGetPointDistToPoint(xABHackPos[playerid][0],xABHackPos[playerid][1],xABHackPos[playerid][2],xABHackPos[playerid][3]) > 20
	&& xABHackPos[playerid][4] == xABHackPos[playerid][5]
	&& GetPVarInt(playerid,"InteriorChange") == 0)
    {
        SetPVarInt(playerid,"Sequence",0);
        TogglePlayerControllable(playerid,false);
		GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
        xABHackPos2[playerid][0] = CheatPlayerInfo[playerid][aX];
        xABHackPos2[playerid][1] = CheatPlayerInfo[playerid][aY];
		SetTimerEx("CheckPlayerAirBreak",500,0,"ddd",playerid,xABHackPos2[playerid][0],xABHackPos2[playerid][1]);
	}
	else SetPVarInt(playerid,"Sequence",0);
	return 1;
}
xfunction GetXY2CoorVeh(playerid)
{
    if(GetPVarInt(playerid,"Sequence") == 1)
    {
	    GetVehiclePos(GetPlayerVehicleID(playerid),CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
        xABHackPos[playerid][2] = CheatPlayerInfo[playerid][aX];
        xABHackPos[playerid][3] = CheatPlayerInfo[playerid][aY];
        SetPVarInt(playerid,"Sequence",2);
        SetTimerEx("TestingVehCOOR",500,0,"d",playerid);
	}
	return 1;
}
xfunction TestingVehCOOR(playerid)
{
    if((GetPVarInt(playerid,"Sequence") == 2) && (GetPVarInt(playerid,"Teleport") == 0) &&(GetPVarInt(playerid,"Spec") == 0) &&(xGetPointDistToPoint(xABHackPos[playerid][0],xABHackPos[playerid][1],xABHackPos[playerid][2],xABHackPos[playerid][3]) > 50) && (xGetSpeed(playerid) < 10))
    {
		TogglePlayerControllable(playerid,false);
		GetVehiclePos(GetPlayerVehicleID(playerid),CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
        xABHackPos2[playerid][0] = CheatPlayerInfo[playerid][aX];
        xABHackPos2[playerid][1] = CheatPlayerInfo[playerid][aY];
		SetTimerEx("CheckVehicleAirBreak",500,0,"ddd",playerid,xABHackPos2[playerid][0],xABHackPos2[playerid][1]);
		SetPVarInt(playerid,"Sequence",0);
	}
	else SetPVarInt(playerid,"Sequence",0);
    return 1;
}
xfunction CheckVehicleAirBreak(playerid,Float:x,Float:y)
{
    GetVehiclePos(GetPlayerVehicleID(playerid),CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
	xABHackPos2[playerid][2] = CheatPlayerInfo[playerid][aX];
    xABHackPos2[playerid][3] = CheatPlayerInfo[playerid][aY];
	if(xGetPointDistToPoint(xABHackPos2[playerid][0],xABHackPos2[playerid][1],xABHackPos2[playerid][2],xABHackPos2[playerid][3]) > 30)
        xAction(playerid,aAIR_BREAK,5,"Чит на полеты",AIR_BREAK);
    return TogglePlayerControllable(playerid,true);
}
stock xKick(playerid,reason[],Type = 0)
{
    if(!IsPlayerConnected(playerid))return 0;
 	//DisabledVars(playerid);
	new xstr[256];

	if(Type == 0)
	    format(xstr, sizeof(xstr), "{FF0000}xAntiCheat: {AFAFAF}Игрок %s был кикнут(Причина: %s)",xPlayerName(playerid),reason);
	else
		format(xstr, sizeof(xstr), "Игрок %s был кикнут Администратором.(Причина: %s)",xPlayerName(playerid),reason);

	SendClientMessageToAll(0xAFAFAFAA,xstr);
    return /*Kick(playerid)*/1;
}
stock xBan(playerid,reason[],Type = 0)
{
	if(!IsPlayerConnected(playerid))return 0;

    /*new xstr[256];
    new File:file = fopen(BanFile,io_append);
    format(xstr,128,"%s\r\n",xPlayerName(playerid));
    fwrite(file,xstr);
    fclose(file);

	DisabledVars(playerid);*/
	new xstr[256];

	if(Type == 0)
	    format(xstr, sizeof(xstr), "{FF0000}xAntiCheat: {AFAFAF}Игрок %s был забанен(Причина: %s)",xPlayerName(playerid),reason);
	else
		format(xstr, sizeof(xstr), "Игрок %s был забанен Администратором.(Причина: %s)",xPlayerName(playerid),reason);

    SendClientMessageToAll(0xAFAFAFAA,xstr);
    return /*Kick(playerid)*/1;
}

stock xPlayerName(playerid)
{
    new str[MAX_PLAYER_NAME];
    GetPlayerName(playerid,str,sizeof(str));
    return str;
}
new xWeapon_ID[MAX_PLAYERS];
new xWeapon_Ammo[MAX_PLAYERS];
new xcomponentAC[MAX_PLAYERS];
xfunction IntVarDis(playerid)
{
    return SetPVarInt(playerid,"InteriorChange",0);
}
forward Xs_AC_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
public Xs_AC_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    SetTimerEx("IntVarDis",3000,0,"d",playerid);
    SetPVarInt(playerid,"InteriorChange",1);
}

new Float:xTPos[MAX_PLAYERS][4];
xfunction OnPlayerCheckCheat(playerid)
{
    if(!IsPlayerConnected(playerid))return 0;
    for(new i = 0; i < 4; i++)xTPos[playerid][i] = 0;
    if(CheatCFG[xATeleportHack] == 1 && GetPVarInt(playerid,"AFKTimeL") == 3 && GetPVarInt(playerid,"Teleport") == 0 && GetPVarInt(playerid,"Spec") == 0 && GetPVarInt(playerid,"InteriorChange") == 0)
    {
        GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
        xTPos[playerid][0] = CheatPlayerInfo[playerid][aX];
        xTPos[playerid][1] = CheatPlayerInfo[playerid][aY];
        if((xGetPointDistToPoint(xTPos[playerid][0],xTPos[playerid][1],xTPos[playerid][2],xTPos[playerid][3]) > 120 && xTPos[playerid][0] != 0 && xTPos[playerid][2] != 0))
            xAction(playerid,aTP_HACK,10,"Чит на телепорт",TELEPORT_VEHICLE);
        xTPos[playerid][2] = CheatPlayerInfo[playerid][aX];
        xTPos[playerid][3] = CheatPlayerInfo[playerid][aY];
    }
    if(CheatCFG[xATunHack] == 1 && IsPlayerInAnyVehicle(playerid))
    {
        for(new i = 0; i < 14; i++)
        {
            xcomponentAC[playerid] = GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), i);
            if(VehiclesTunInfo[GetPlayerVehicleID(playerid)][i] != xcomponentAC[playerid])
            {
                if(!TunningGarages(playerid))
                {
                    Xs_AC_RemoveVehicleComponent(GetPlayerVehicleID(playerid),xcomponentAC[playerid]);
                    xAction(playerid,aTUN_HACK,12,"Чит на тюннинг ТС",TUNNING_VEHICLE);
                }
                else
                    GetVehicleComponents(GetPlayerVehicleID(playerid));
                break;
			}
        }
    }
    for(new i = 0; i < 12; i++)
    {
        GetPlayerWeaponData(playerid, i, xWeapon_ID[playerid], xWeapon_Ammo[playerid]);
        if(CheatCFG[xAWeaponHack] == 1 && CheatWPInfo[playerid][xWeapon][i] != xWeapon_ID[playerid] && xWeapon_ID[playerid] != 0)
        {
            Xs_AC_ResetPlayerWeapons(playerid);
            xKick(playerid,"Чит на оружие");
		    break;
		}
        if(CheatCFG[xAAmmoHack] == 1 && CheatWPInfo[playerid][xAmmo][i] < xWeapon_Ammo[playerid]/* && IsNotWeaponNoAmmo(Weapon_ID[playerid])*/ && xWeapon_ID[playerid] != 0)
        {
            Xs_AC_ResetPlayerWeapons(playerid);
            xKick(playerid,"Чит на патроны");
            break;
		}
    }

    if(CheatCFG[xAFreezeHack] == 1 && GetPVarInt(playerid,"Freeze") == 1)
        TogglePlayerControllable(playerid,false);

    if(CheatCFG[xALockWeaponHack] == 1 && GetLockWeapon(playerid))
        xKick(playerid,"Запрещенное оружие");

    if(CheatCFG[xAJetPackHack] == 1 && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
		xKick(playerid,"Чит на JetPack");

    if(CheatCFG[xASpectateHack] == 1 && GetPVarInt(playerid,"Spec") == 0 && GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
    {
        TogglePlayerSpectating(playerid,0);
        xKick(playerid,"Слежка за игроками через собейт");
    }
    if(CheatCFG[xAAirBreakHack] == 1)
    {
	    if(IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid,"Sequence") == 0)
	    {
            SetPVarInt(playerid,"Sequence",1);
	        GetVehiclePos(GetPlayerVehicleID(playerid),CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
            xABHackPos[playerid][0] = CheatPlayerInfo[playerid][aX];
            xABHackPos[playerid][1] = CheatPlayerInfo[playerid][aY];
            SetTimerEx("GetXY2CoorVeh",500,0,"d",playerid);
	    }
        if((GetPlayerState(playerid) != PLAYER_STATE_DRIVER)  && !IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid,"Sequence") == 0)
	    {
            SetPVarInt(playerid,"Sequence",1);
            SetTimerEx("GetXY2CoorPlayer",500,0,"d",playerid);
	        GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
            xABHackPos[playerid][0] = CheatPlayerInfo[playerid][aX];
            xABHackPos[playerid][1] = CheatPlayerInfo[playerid][aY];
            xABHackPos[playerid][4] = CheatPlayerInfo[playerid][aZ];
	    }
    }

	if(CheatCFG[xASpeedHack] == 1 && GetPVarInt(playerid,"Spec") == 0 && (GetPlayerSurfingVehicleID(playerid)!=INVALID_VEHICLE_ID ||GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (xGetSpeed(playerid) >MAX_SPEED_VEHICLE))
		xAction(playerid,aSPEED_HACK,4,"Чит на скорость",SPEED_HACK);

    if(BugsOther[xAMinFPS] == 1 && GetPVarInt(playerid,"AFK") == 0 && (GetPVarInt(playerid,"SpawnKillTime") == 0 && GetPVarInt(playerid,"SpawnFace") == 0 && xGetPlayerFPS(playerid) < MIN_FPS))
    {
	    if(GetPVarInt(playerid, "CheckFPS") == 4)
		{
            xAction(playerid,0,0,"Низкий FPS, Лаггер",PLAYER_FPS);
            SetPVarInt(playerid, "CheckFPS", 0);
		}
		else SetPVarInt(playerid, "CheckFPS", GetPVarInt(playerid,"CheckFPS")+1);
	}
	else SetPVarInt(playerid, "CheckFPS", 0);

    if(BugsOther[xAMaxPing] == 1 && GetPVarInt(playerid,"SpawnFace") == 0 && GetPlayerPing(playerid) > MAX_PING && GetPVarInt(playerid,"AFK") == 0)
			xAction(playerid,0,0,"Слишком высокий пинг",ANTI_PING);

    if(CheatCFG[xAVehHealthHack]==1)
	{
		new Float:xget_health;
		GetVehicleHealth(GetPlayerVehicleID(playerid),xget_health);
        if(CheatPlayerInfo[playerid][xVehHealth] < xget_health && !RepairCarPos(playerid))
		{
            SetVehicleHealth(GetPlayerVehicleID(playerid),CheatPlayerInfo[playerid][xVehHealth]);
            xAction(playerid,aVEHICLE_REPAIR_HACK,11,"Чит на починку ТС",VEHICLE_REPAIR_HACK);
	    }
	    if(CheatPlayerInfo[playerid][xVehHealth] < xget_health && RepairCarPos(playerid))
            CheatPlayerInfo[playerid][xVehHealth] = xget_health;
	    if(CheatPlayerInfo[playerid][xVehHealth] > xget_health)
            CheatPlayerInfo[playerid][xVehHealth] = xget_health;
		if(CheatPlayerInfo[playerid][xVehHealth] > MAX_VEH_HEALTH)
        {
		    CheatPlayerInfo[playerid][xVehHealth] = MAX_VEH_HEALTH;
			SetVehicleHealth(GetPlayerVehicleID(playerid),MAX_VEH_HEALTH);
	 	}
	}

	if(CheatCFG[xAHealthHack] == 1)
	{
		new Float:xget_health;
		SetPVarInt(playerid,"HealthResult",0);
		GetPlayerHealth(playerid,xget_health);
        if(CheatPlayerInfo[playerid][xHealth] < xget_health)
		{
			if(InteriorSetHealth(playerid))
			{
				if(xget_health > MAX_HEALTH)
			        Xs_AC_SetPlayerHealth(playerid,MAX_HEALTH);
	 	        else
                    CheatPlayerInfo[playerid][xHealth] = xget_health;
			}
			SetPVarInt(playerid,"HealthResult",floatround(xget_health - CheatPlayerInfo[playerid][xHealth]));
            if(GetPVarInt(playerid,"HealthResult") < 35.1 && GetPVarInt(playerid,"TrueResult") == 1)
			    CheatPlayerInfo[playerid][xHealth] = xget_health;
            else
		    {
			    if(GetPVarInt(playerid,"Death") == 0)
			    {
		            SetPlayerHealth(playerid,CheatPlayerInfo[playerid][xHealth]);
                    xAction(playerid,aPH_HACK,6,"Чит на здоровье",PH_HACK);
				}
			}
			if(CheatPlayerInfo[playerid][xHealth] > xget_health)
                CheatPlayerInfo[playerid][xHealth] = xget_health;

		    if(CheatPlayerInfo[playerid][xHealth] > MAX_HEALTH)
			    Xs_AC_SetPlayerHealth(playerid,MAX_HEALTH);

            SetPlayerHealth(playerid,CheatPlayerInfo[playerid][xHealth]);
			SetPVarInt(playerid,"TrueResult",0);
        }
	}
	if(CheatCFG[xAArmourHack] == 1)
	{
	    new Float:xget_armour;
		GetPlayerArmour(playerid,xget_armour);
		if(xget_armour != CheatPlayerInfo[playerid][xArmour])
	    {
			if(xget_armour > CheatPlayerInfo[playerid][xArmour])
			{
                Xs_AC_SetPlayerArmour(playerid,CheatPlayerInfo[playerid][xArmour]);
                xAction(playerid,aPA_HACK,7,"Чит на броню",PA_HACK);
            }
            if(CheatPlayerInfo[playerid][xArmour] > xget_armour)
                CheatPlayerInfo[playerid][xArmour] = xget_armour;

            if(CheatPlayerInfo[playerid][xArmour] > MAX_ARMOUR)
			    Xs_AC_SetPlayerArmour(playerid,MAX_ARMOUR);
	    }
	}
	new xget_getmoney = GetPlayerMoney(playerid);
	if(CheatCFG[xAMoneyHack]==1)
	{
        if(InteriorSetMoney(playerid))
            CheatPlayerInfo[playerid][aMoney] = xget_getmoney;

        if(CheatPlayerInfo[playerid][aMoney] > xget_getmoney)
	    {
            SetPVarInt(playerid,"MoneyResult",CheatPlayerInfo[playerid][aMoney] - xget_getmoney);
		    if(GetPVarInt(playerid,"MoneyResult") == 1)
			    SetPVarInt(playerid,"TrueResult",1);
		    CheatPlayerInfo[playerid][aMoney]=xget_getmoney;
	    }
	    if(CheatPlayerInfo[playerid][aMoney] < xget_getmoney)
	    {
            SetPVarInt(playerid,"GetMoney",CheatPlayerInfo[playerid][aMoney]);
            Xs_AC_ResetPlayerMoney(playerid);
	    	Xs_AC_GivePlayerMoney(playerid, GetPVarInt(playerid,"GetMoney"));
            xAction(playerid,aMONEY_HACK,0,"Чит на деньги",MONEY_HACK);
		}
	}
	return 1;
}
stock xAction(playerid,numACT,numHack,reason[],def)
{
    if(!IsPlayerConnected(playerid))return 0;
    if(numACT == -1) return 0;
    switch(numACT)
    {
        case 0:
        {
            xHackCheck[playerid][def]++;
            if(xHackCheck[playerid][def] == 3)
	            xKick(playerid,reason);
        }
        case 1: CallRemoteFunction("ReportOnThePlayer", "dd", playerid,numHack);
        case 2:
        {
            SetPVarInt(playerid,"xChecks",GetPVarInt(playerid,"xChecks") + 1);
			if(GetPVarInt(playerid,"xChecks") == 3)
	            xKick(playerid,reason);
			else
			    CallRemoteFunction("ReportOnThePlayer", "dd",playerid,numHack);
        }
        case 3: xKick(playerid,reason);
        case 4: xBan(playerid,reason);
        case 5:
        {
		    xHackCheck[playerid][def]++;
            if(xHackCheck[playerid][def] == 3)
	            xBan(playerid,reason);
        }
    }
    return 1;
}

stock xGetPlayerFPS(playerid)
{
    SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
    if(GetPVarInt(playerid, "DrunkL") < 200)
        SetPlayerDrunkLevel(playerid, 2000);
    else
    {
        if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
        {
            SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") -GetPVarInt(playerid, "DrunkL")));
            if(200 > GetPVarInt(playerid, "FPS") > 0)
                SetPVarInt(playerid, "FPS2",GetPVarInt(playerid, "FPS"));
            SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
        }
    }
    return GetPVarInt(playerid, "FPS2")+3;
}


public OnPlayerUpdate(playerid)
{
    SetPVarInt(playerid,"PlayerAFKUpdate",GetPVarInt(playerid,"PlayerAFKUpdate")+1);
    new Keys, ud, lr;
    GetPlayerKeys(playerid, Keys, ud, lr);
	if(BugsOther[xASlideBug] == 1)
	{
        if(lr < 0)
	        SetPVarInt(playerid, "Slide", 1);
        else
            SetPVarInt(playerid, "Slide", 0);
    }
   	if(BugsOther[xABugC] == 1 && GetPVarInt(playerid,"Fired") == 1 && (GetTickCount() - GetPVarInt(playerid,"GTC")) < 700)
	{
	    if(Keys == KEY_CROUCH)
		{
			xAction(playerid,0,0,"Неоднократное использование 'С' бага",BUG_C);
			SetPVarInt(playerid,"Fired",0);
	    }
	    else SetPVarInt(playerid,"Fired",1);
	}
	return CallLocalFunction("Xs_AC_OnPlayerUpdate", "i",playerid);
}
#define OnPlayerUpdate Xs_AC_OnPlayerUpdate
forward Xs_AC_OnPlayerUpdate(playerid);

forward Xs_AC_OnPlayerConnect(playerid);
public Xs_AC_OnPlayerConnect(playerid)
{
	CheatPlayerInfo[playerid][aMoney] = 0;
	CheatPlayerInfo[playerid][TimerAFK]=SetTimerEx("UpdateAFK", 1000, 1, "i",playerid);
	CheatPlayerInfo[playerid][TimerX]=SetTimerEx("OnPlayerCheckCheat", 500, 1, "i",playerid);
    SetPVarInt(playerid,"SpawnFace",1);

   	new filestr[128];
	new File:file = fopen(BanFile,io_read);
    while(fread(file,filestr,sizeof(filestr)))
   	{
        if (strfind(filestr, xPlayerName(playerid), true) != -1)
	    {
            SendClientMessage(playerid, OFF_COLOR, "Вы забанены на этом сервере.");
            return Kick(playerid);
        }
	}
	return true;
}

new Float:PosSpawnTime[MAX_PLAYERS][3];
forward Xs_AC_OnPlayerSpawn(playerid);
public Xs_AC_OnPlayerSpawn(playerid)
{
	if(BugsOther[xASpawnKill] == 1)
	{
		SetPVarInt(playerid,"SpawnKillTime",1);
		SetTimerEx("SpawnKillOFFTime",11000,0,"d",playerid);
		SetTimerEx("GetPosSpawn",1000,0,"d",playerid);
	}
	CheatPlayerInfo[playerid][xHealth] = MAX_HEALTH;
	CheatPlayerInfo[playerid][xArmour] = MAX_ARMOUR;
	CheatPlayerInfo[playerid][xVehHealth] = 0;
	SetPVarInt(playerid,"SpawnFace",0);
	SetPVarInt(playerid,"Sequence",0);
	SetPVarInt(playerid,"Spec",0);
	SetPVarInt(playerid,"Fire",0);
	SetTimerEx("SpawnBugOFF",2000,0,"d",playerid);
	SetPVarInt(playerid,"Freeze",0);
	return true;
}
xfunction SpawnKillOFFTime(playerid)
{
	return SetPVarInt(playerid,"SpawnKillTime",0);
}
xfunction GetPosSpawn(playerid)
{
    GetPlayerPos(playerid,CheatPlayerInfo[playerid][aX],CheatPlayerInfo[playerid][aY],CheatPlayerInfo[playerid][aZ]);
    PosSpawnTime[playerid][0] = CheatPlayerInfo[playerid][aX];
    PosSpawnTime[playerid][1] = CheatPlayerInfo[playerid][aY];
    PosSpawnTime[playerid][2] = CheatPlayerInfo[playerid][aZ];
    return 1;
}
xfunction SpawnBugOFF(playerid)
{
    SetPVarInt(playerid,"Death",0);
	return 1;
}

forward Xs_AC_OnPlayerDeath(playerid, killerid, reason);
public Xs_AC_OnPlayerDeath(playerid, killerid, reason)
{
    SetPVarInt(playerid,"Death",1);
    SetPVarInt(playerid,"SpawnFace",1);
	new string[256];
	if(GetPVarInt(playerid,"SpawnKillTime") == 1 && killerid != INVALID_PLAYER_ID && IsPlayerInRangeOfPoint(playerid,7.5,PosSpawnTime[playerid][0],PosSpawnTime[playerid][1],PosSpawnTime[playerid][2]))
	{
		xWarns[killerid][SPAWN_KILL]++;
		if(xWarns[killerid][SPAWN_KILL] == 3)
		{
		    SetVehicleToRespawn(GetPlayerVehicleID(killerid));
		    format(string, sizeof(string), "Spawn Kill предупреждение %d/%d.Kick",xWarns[killerid][SPAWN_KILL], 3);
		    SendClientMessage(killerid,OFF_COLOR,string);
            xKick(killerid,"Неоднократный Spawn Kill");
		}
		else
		{
		    format(string, sizeof(string), "Spawn Kill предупреждение %d/%d",xWarns[killerid][SPAWN_KILL], 3);
		    SendClientMessage(killerid,OFF_COLOR,string);
		}
	}

    if(BugsOther[xADriveBy] == 1)
	{
	    if(reason == 49)
        {
   	        new Float:x,Float:y,Float:z;
	        GetPlayerPos(playerid,x,y,z);
            if((GetPlayerState(killerid) == PLAYER_STATE_DRIVER) &&(IsPlayerInRangeOfPoint(killerid,20.0,x,y,z)))
            {
                xWarns[killerid][DRIVE_BY]++;
		        if(xWarns[killerid][DRIVE_BY] == 3)
                    xKick(killerid,"Неоднократное DriveBy");
                else
                {
                    format(string, sizeof(string), "DriveBy предупреждение %d/%d",xWarns[killerid][DRIVE_BY], 3);
		            SendClientMessage(killerid,OFF_COLOR,string);
                }
				SetVehicleToRespawn(GetPlayerVehicleID(killerid));
				SetPlayerHealth(killerid,0.0);
            }
        }
	}
	return CallLocalFunction("Xs_AC_OnPlayerDeath", "idd", playerid, killerid, reason);
}
stock DisabledVars(playerid)
{
    SetPVarInt(playerid,"AFKTimeL",0);
    SetPVarInt(playerid,"InteriorChange",0);
    SetPVarInt(playerid,"xChecks",0);
    SetPVarInt(playerid,"Freeze",1);
    KillTimer(CheatPlayerInfo[playerid][TimerX]);
    KillTimer(CheatPlayerInfo[playerid][TimerAFK]);
	CheatPlayerInfo[playerid][aX] = 0;
    CheatPlayerInfo[playerid][aY] = 0;
    CheatPlayerInfo[playerid][aZ] = 0;
	for(new i = 0; i < M_V; i++)xWarns[playerid][i] = 0;
	SetPVarInt(playerid,"Spec",0);
	SetPVarInt(playerid,"Teleprt",0);
	SetPVarInt(playerid, "CheckFPS", 0);
	Xs_AC_ResetPlayerWeapons(playerid);
    SetPVarInt(playerid,"AFK",0);
    SetPVarInt(playerid,"PlayerAFKUpdate",0);
    SetPVarInt(playerid,"GlobalAFKUpdate",0);
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPVarInt(playerid, "Slide") == 1 && newkeys & KEY_SPRINT && newkeys & KEY_HANDBRAKE && !IsPlayerInAnyVehicle(playerid))
        ApplyAnimation(playerid, "PED", "getup_front", 4.0, 0, 0, 1, 0, 0);

    if(BugsOther[xABugC] == 1 && newkeys & KEY_FIRE && (GetPlayerWeapon(playerid) == 22 || GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 25 || GetPlayerWeapon(playerid) == 27) && !IsPlayerInAnyVehicle(playerid))
    {
		SetPVarInt(playerid,"Fired",1);
		SetPVarInt(playerid,"GTC",GetTickCount());
    }
	return CallLocalFunction("Xs_AC_OnPlayerKeyStateChange", "idd",playerid, newkeys,oldkeys);
}
#define OnPlayerKeyStateChange Xs_AC_OnPlayerKeyStateChange
forward Xs_AC_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new Float:hpcar[MAX_PLAYERS];
    if(newstate == PLAYER_STATE_DRIVER)
    {
		GetVehicleHealth(GetPlayerVehicleID(playerid),hpcar[playerid]);
		CheatPlayerInfo[playerid][xVehHealth] = hpcar[playerid];
    }
    if(newstate == PLAYER_STATE_ONFOOT)
	    CheatPlayerInfo[playerid][xVehHealth] = MAX_VEH_HEALTH;

    return CallLocalFunction("Xs_AC_OnPlayerStateChange", "id",playerid, newstate,oldstate);
}
#define OnPlayerStateChange Xs_AC_OnPlayerStateChange
forward Xs_AC_OnPlayerStateChange(playerid, newstate, oldstate);
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
    if(dialogid == 1250)
	{
	    if(!response) return 0;
        new detec[128],strd[2048],title[128];
    	if(strlen(inputtext) == 0) return 0;
        SetPVarInt(playerid,"Quantity",0);
        new File:file = fopen(BanFile,io_read);
        while(fread(file,detec,sizeof(detec)))
      	{
            if (strfind(detec,inputtext, true) != -1)
	        {
				format(strd,sizeof(strd),"%s\n%s",strd,detec);
				SetPVarInt(playerid,"Quantity",GetPVarInt(playerid,"Quantity") + 1);
            }
        }
		fclose(file);
        format(title,sizeof(title),"Найдено %d совпадений",GetPVarInt(playerid,"Quantity"));
		if(GetPVarInt(playerid,"Quantity") == 0)
			SendClientMessage(playerid,OFF_COLOR,"Совпадений не найденно.");
        else if(GetPVarInt(playerid,"Quantity") > 19)
		    ShowPlayerDialog(playerid,1250,DIALOG_STYLE_INPUT,"Разбан","Найдено очень много совпадений. Пожалуйста уточните","Выбрать","Назад");
		else
            ShowPlayerDialog(playerid,1251, 2 ,title,strd,"OK","Cancel");
        SetPVarInt(playerid,"Quantity",0);
        return 1;
    }
    if(dialogid == 1251)
    {
        if (!response) return 0;
        new newContent[2048], fileString[256];
        strdel(inputtext, strlen(inputtext)-1, strlen(inputtext));
        format(fileString, sizeof(fileString), "Игрок %s разбанен", inputtext);
        SendClientMessage(playerid, OFF_COLOR, fileString);
        new File:file = fopen(BanFile, io_read);
        while (fread(file, fileString, sizeof(newContent)))
        {
            if (strfind(fileString, inputtext, true) == -1)
            {
                strcat(newContent, fileString, sizeof(newContent));
            }
        }
        fclose(file);
        file = fopen(BanFile, io_write);
        fwrite(file,newContent);
        fclose(file);
        return 1;
    }
    if(dialogid == 1150)
	{
	    if(response)
		{
			if(listitem == 0)
                ShowPlayerDialog(playerid,1151,DIALOG_STYLE_INPUT,"Максимальный пинг","Введите число которое будет максимальным пингом сервера\nЧисло не должно быть больше 64000","Выбрать","Назад");
			else if(listitem == 1)
			    ShowPlayerDialog(playerid,1152,DIALOG_STYLE_INPUT,"Максимальное здоровье игрока","Введите максимальное здоровье игрока","Выбрать","Назад");
			else if(listitem == 2)
		    	ShowPlayerDialog(playerid,1153,DIALOG_STYLE_INPUT,"Максимальноездоровье ТС","Введите максимальное здоровье транспортного средства","Выбрать","Назад");
            else if(listitem == 3)
		    	ShowPlayerDialog(playerid,1154,DIALOG_STYLE_INPUT,"Максимальное кол-во брони","Введите максимальное кол-во брони","Выбрать","Назад");
		}
		return 1;
	}
	if(dialogid == 1154)
	{
		new string[256];
	    if(response)
		{
		    format(string, 256, "Максимальное кол-во брони изменено. Теперь оно равно %d%",strval(inputtext));
		    SendClientMessage(playerid,OFF_COLOR, string);
		    dini_IntSet("anticheat/CFG.ini", "MaxArmour",strval(inputtext));
		}
		return 1;
	}
	if(dialogid == 1153)
	{
		new string[256];
	    if(response)
		{
		    format(string, 256, "Максимальное здоровье ТС изменено. Теперь оно равно %d%",strval(inputtext));
		    SendClientMessage(playerid,OFF_COLOR, string);
		    dini_IntSet("anticheat/CFG.ini", "MaxVehicleHealth",strval(inputtext));
        }
		return 1;
	}
	if(dialogid == 1152)
	{
		new string[256];
	    if(response)
		{
		    format(string, 256, "Максимальное здоровье изменено. Теперь оно равно %d%",strval(inputtext));
		    SendClientMessage(playerid,OFF_COLOR, string);
		    dini_IntSet("anticheat/CFG.ini", "MaxHealth",strval(inputtext));
		}
		return 1;
	}
	if(dialogid == 1151)
	{
		new string[256];
	    if(response)
		{
			if(strval(inputtext) > 64000)return SendClientMessage(playerid,OFF_COLOR, "Максимальный пинг может быть не больше 64000");
			format(string, 256, "Максимальный пинг изменен. Теперь он равен %dm/c",strval(inputtext));
		    SendClientMessage(playerid,OFF_COLOR, string);
		    dini_IntSet("anticheat/CFG.ini", "MaxPing",strval(inputtext));
		}
		return 1;
	}
    if(dialogid == 1120)
	{
	    if(response)
		{
			if(listitem == 0)
                ShowPlayerDialog(playerid,1121,DIALOG_STYLE_LIST,"xAntiCheat конфигурации","SpeedHack\nAirBreak\nMoneyHack\nHealthHack\nArmourHack\nVehicleRepairHack\nSpectateHack\nFreezeHack\nWeaponHack\nAmmoHack\nLockWeaponHack\nJetPackHack\nTunningHack\nTeleportHack","Выбрать","Назад");
			else if(listitem == 1)
			    ShowPlayerDialog(playerid,1122,DIALOG_STYLE_LIST,"xAntiCheat конфигурации","Slide Bug\nBug C","Выбрать","Назад");
			else if(listitem == 2)
		    	ShowPlayerDialog(playerid,1123,DIALOG_STYLE_LIST,"xAntiCheat конфигурации","DriveBy\nSpawnKill\nFPS\nPing","Выбрать","Назад");
		}
		return 1;
	}
    if(dialogid == 1121)
	{
	    if(response)
		{
			if(listitem == 0)
		        ShowPlayerDialog(playerid,1124,DIALOG_STYLE_LIST,"SpeedHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 1)
			    ShowPlayerDialog(playerid,1125,DIALOG_STYLE_LIST,"AirBreak","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 2)
			    ShowPlayerDialog(playerid,1126,DIALOG_STYLE_LIST,"MoneyHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 3)
			    ShowPlayerDialog(playerid,1127,DIALOG_STYLE_LIST,"HealthHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 4)
                ShowPlayerDialog(playerid,1128,DIALOG_STYLE_LIST,"ArmourHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 5)
			    ShowPlayerDialog(playerid,1129,DIALOG_STYLE_LIST,"VehicleRepairHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 6)
			    ShowPlayerDialog(playerid,1130,DIALOG_STYLE_LIST,"SpectateHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 7)
			    ShowPlayerDialog(playerid,1131,DIALOG_STYLE_LIST,"FreezeHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 8)
			    ShowPlayerDialog(playerid,1137,DIALOG_STYLE_LIST,"WeaponHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 9)
			    ShowPlayerDialog(playerid,1138,DIALOG_STYLE_LIST,"AmmoHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 10)
			    ShowPlayerDialog(playerid,1139,DIALOG_STYLE_LIST,"LockWeaponHack","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 11)
			    ShowPlayerDialog(playerid,1140,DIALOG_STYLE_LIST,"JetPackHack","Включить\nВыключить","Выбрать","Назад");

            else if(listitem == 12)
			    ShowPlayerDialog(playerid,1142,DIALOG_STYLE_LIST,"TunningHack","Включить\nВыключить","Выбрать","Назад");

            else if(listitem == 13)
			    ShowPlayerDialog(playerid,1143,DIALOG_STYLE_LIST,"TeleportHack","Включить\nВыключить","Выбрать","Назад");
        }
		xLoadData();
		return 1;
	}
    if(dialogid == 1122)
	{
	    if(response)
		{
			if(listitem == 0)
                ShowPlayerDialog(playerid,1132,DIALOG_STYLE_LIST,"SlideBug","Включить\nВыключить ","Выбрать","Назад");

            if(listitem == 1)
                ShowPlayerDialog(playerid,1141,DIALOG_STYLE_LIST,"Bug C","Включить\nВыключить ","Выбрать","Назад");
		}
		xLoadData();
		return 1;
	}
    if(dialogid == 1123)
	{
	    if(response)
		{
			if(listitem == 0)
			    ShowPlayerDialog(playerid,1133,DIALOG_STYLE_LIST,"DriveBy","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 1)
			    ShowPlayerDialog(playerid,1134,DIALOG_STYLE_LIST,"SpawnKill","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 2)
			    ShowPlayerDialog(playerid,1135,DIALOG_STYLE_LIST,"FPS","Включить\nВыключить","Выбрать","Назад");

			else if(listitem == 3)
                ShowPlayerDialog(playerid,1136,DIALOG_STYLE_LIST,"Ping","Включить\nВыключить","Выбрать","Назад");
		}
		xLoadData();
		return 1;
	}
    xDialogOnOff(playerid,dialogid,response,listitem,1124,"AntiSpeedHack",1,"SpeedHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1125,"AntiAirBreakHack",1,"AirBreakHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1126,"AntiMoneyHack",1,"MoneyHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1127,"AntiHealthHack",1,"HealthHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1128,"AntiArmourHack",1,"ArmourHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1129,"AntiVehicleRepairHack",1,"VehicleRepairHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1130,"AntiSpectateHack",1,"SpectateHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1131,"AntiFreezeHack",1,"FreezeHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1137,"AntiWeaponHack",1,"WeaponHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1138,"AntiAmmoHack",1,"AmmoHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1139,"AntiLockWeaponHack",1,"LockWeaponHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1140,"AntiJetPackHack",1,"JetPackHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1142,"AntiTunningHack",1,"TunningHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1143,"AntiTeleportHack",1,"TeleportHack");
    xDialogOnOff(playerid,dialogid,response,listitem,1132,"AntiSlideBug",2,"SlideBug");
    xDialogOnOff(playerid,dialogid,response,listitem,1133,"AntiDriveBy",3,"DriveBy");
    xDialogOnOff(playerid,dialogid,response,listitem,1134,"AntiSpawnKill",3,"SpawnKill");
    xDialogOnOff(playerid,dialogid,response,listitem,1135,"AntiMinFps",3,"Низкий FPS");
    xDialogOnOff(playerid,dialogid,response,listitem,1136,"AntiPing",3,"Высокий Ping");
    xDialogOnOff(playerid,dialogid,response,listitem,1141,"AntiBugC",2,"BugC");
	return CallLocalFunction("Xs_AC_OnDialogResponse","dddds",playerid,dialogid,response,listitem,inputtext);
}
#define OnDialogResponse Xs_AC_OnDialogResponse
forward Xs_AC_OnDialogResponse(playerid,dialogid,response,listitem,inputtext[]);

stock xDialogOnOff(playerid,dialogid,response,listitem,FdialogID,NameVar[],group,Name[])
{
    new string[256];
    new stringinf[256];
    if(dialogid == FdialogID)
	{
	    if(response)
		{
            format(string, sizeof(string), "%s",NameVar);
			if(listitem == 0)
            {
                if(dini_Int("anticheat/AntiCheats.ini", string) == 0)
                {
                    format(stringinf, sizeof(stringinf), "Anti %s активирован",Name);
                    SendClientMessage(playerid,OFF_COLOR,stringinf);
                    dini_IntSet("anticheat/AntiCheats.ini", string,1);
                }
                else
                {
					format(stringinf, sizeof(stringinf), "Anti %s и так активирован",Name);
                    SendClientMessage(playerid,OFF_COLOR,stringinf);
                }
            }
			else if(listitem == 1)
			{
                if(dini_Int("anticheat/AntiCheats.ini", string) == 1)
                {
                    format(stringinf, sizeof(stringinf), "Anti %s деактивирован",Name);
                    SendClientMessage(playerid,OFF_COLOR,stringinf);
                    dini_IntSet("anticheat/AntiCheats.ini", string,0);
                }
                else
                {
					format(stringinf, sizeof(stringinf), "Anti %s и так деактивирован",Name);
                    SendClientMessage(playerid,OFF_COLOR,stringinf);
                }
		    }
        }
        xLoadData();
        xDialogList(playerid,response,group);
	    return 1;
	}
    return 1;
}
stock xLoadData()
{
	CheatCFG[xAMoneyHack]     = ANTI_MONEY_HACK;
	CheatCFG[xASpeedHack]     = ANTI_SPEED_HACK;
	CheatCFG[xAAirBreakHack]  = ANTI_AIR_BREAK_HACK;
	CheatCFG[xAArmourHack]    = ANTI_ARMOUR_HACK;
	CheatCFG[xAHealthHack]    = ANTI_HEALTH_HACK;
	CheatCFG[xAAmmoHack]      = ANTI_AMMO_HACK;
	CheatCFG[xAWeaponHack]    = ANTI_WEAPON_HACK;
	CheatCFG[xAJetPackHack]   = ANTI_JET_PACK_HACK;
	CheatCFG[xALockWeaponHack]= ANTI_LOCK_WEAPON_HACK;
	CheatCFG[xAVehHealthHack] = ANTI_VEH_HEALTH_HACK;
	CheatCFG[xAFreezeHack]    = ANTI_FREEZE_HACK;
	CheatCFG[xASpectateHack]  = ANTI_SPECTATE_HACK;
    CheatCFG[xATunHack]       = ANTI_TUNNING_HACK;
    CheatCFG[xATeleportHack]  = ANTI_TUNNING_HACK;

	BugsOther[xASpawnKill]   = ANTI_SPAWN_KILL;
	BugsOther[xADriveBy]     = ANTI_DRIVE_BY;
	BugsOther[xASlideBug]    = ANTI_SLIDE_BUG;
	BugsOther[xABugC]        = ANTI_BUG_C;
	BugsOther[xAMinFPS]      = ANTI_MIN_FPS;
	BugsOther[xAMaxPing]     = ANTI_PLAYER_PING;
}
stock xDialogList(playerid,response,group)
{
    if(!response)
    {
        if(group == 1)
            ShowPlayerDialog(playerid,1121,DIALOG_STYLE_LIST,"AntiCheat конфигурации","SpeedHack\nAirBreak\nMoneyHack\nHealthHack\nArmourHack\nVehicleRepairHack\nSpectateHack\nFreezeHack\nWeaponHack\nAmmoHack\nLockWeaponHack\nJetPackHack\nTunningHack\nTeleportHack","Выбрать","Назад");
        if(group == 2)
            ShowPlayerDialog(playerid,1122,DIALOG_STYLE_LIST,"AntiCheat конфигурации","SlideBug\nBug C","Выбрать","Назад");
        if(group == 3)
            ShowPlayerDialog(playerid,1123,DIALOG_STYLE_LIST,"AntiCheat конфигурации","DriveBy\nSpawnKill\nFPS\nPing","Выбрать","Назад");
    }
}
stock Xs_AC_DestroyVehicle(vehicleid)
{
    for(new i = 0; i < 13; i++)
  		VehiclesTunInfo[vehicleid][i] = 0;
    return DestroyVehicle(vehicleid);
}
forward Xs_AC_OnVehicleSpawn(vehicleid);
public Xs_AC_OnVehicleSpawn(vehicleid)
{
    for(new i = 0; i < 13; i++)
  		VehiclesTunInfo[vehicleid][i] = 0;
}

stock Xs_AC_AddVehicleComponent(vehicleid,componentid)
{
    AddVehicleComponent(vehicleid,componentid);
    new component;
    for(new i = 0; i < 13; i++)
    {
        component = GetVehicleComponentInSlot(vehicleid, i);
        if(component == componentid)
        {
  		    VehiclesTunInfo[vehicleid][i] = component;
            break;
        }
    }
}
stock GetVehicleComponents(vehicleid)
{
    new component;
    for(new i = 0; i < 13; i++)
    {
        component = GetVehicleComponentInSlot(vehicleid, i);
		VehiclesTunInfo[vehicleid][i] = component;
    }
    return 1;
}
stock Xs_AC_RemoveVehicleComponent(vehicleid,componentid)
{
    new component;
    for(new i = 0; i < 13; i++)
    {
        component = GetVehicleComponentInSlot(vehicleid, i);
        if(component == componentid)
        {
            RemoveVehicleComponent(vehicleid,componentid);
            VehiclesTunInfo[vehicleid][i] = 0;
            break;
        }
    }
	return 1;
}

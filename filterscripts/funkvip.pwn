/*
 ___________________________________________________________________
|                                                                  |
|           VIP      System FilterScript Maded By                  |
|               ____            ____         ___                   |
|				|___ U N K Y	  |  HE 	|  __ R E A T          |
|               |                 |         |___|                  |
|__________________________________________________________________|*/
#define FILTERSCRIPT
#include <a_samp>
#include <zcmd>
#include <foreach>
#include <streamer>
#include <sscanf2>
#include <dini>


#define COLOR_RED  0xFF0000FF
#define	COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_YELLOW 0xFFFF00FF
#define Grey 0xC0C0C0FF


#define MAX_LAUNCH 20
#define RocketHeight 	50
#define RocketSpread 	30
#define MAX_FIREWORKS2 100

#define MAX_VIP 3
#define PlayerFile "FuNkVip/%s.ini"
#define N 69
#define DIALOG_CMD_1 1
#define DIALOG_CMD_2 2

new Text3D:playerLabels[MAX_PLAYERS];
new String[128], Float:SpecX[MAX_PLAYERS], Float:SpecY[MAX_PLAYERS], Float:SpecZ[MAX_PLAYERS], vWorld[MAX_PLAYERS], Inter[MAX_PLAYERS];
new IsSpecing[MAX_PLAYERS], Name[MAX_PLAYER_NAME], IsPlayerSpecing[MAX_PLAYERS],spectatorid[MAX_PLAYERS];
new Flaming[MAX_PLAYERS];
new hunter[MAX_PLAYERS];
new hydra[MAX_PLAYERS];
new tank[MAX_PLAYERS];
new FireworkTotal;
new Rocket[MAX_LAUNCH];
new RocketLight[MAX_LAUNCH];
new RocketSmoke[MAX_LAUNCH];
new RocketExplosions[MAX_LAUNCH];
new Float:ry4[MAX_LAUNCH];
new Float:rx4[MAX_LAUNCH];
new Float:rz4[MAX_LAUNCH];
new Fired;



#define yellow "{ffff00}"
#define cyan "{00ff00}"
#define pink "{ffffff}"
#define orange "{ff0000}"
#define blue "{0000ff}"
#define red "{ff0000}"
#define white "{ffffff}"
#define grey "{AFAFAF}"

//#pragma tabsize 0

enum dData
{
   Vip
}
new PlayerInfo[MAX_PLAYERS][dData];

new grider[ MAX_PLAYERS ][ 3 ];

public OnFilterScriptInit()
{
	print("\n |----------------------------------------|");
	print(" |------VIP SYSTEM BY FuNkY The Great!----|");
	print(" |------------------LOADED----------------|");
	print(" |----------------------------------------|\n");
	CreateDynamicObject(18751, 4802.12012, -4921.35010, 6.67293,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4746.02295, -4921.96045, 4.34322,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4746.04004, -4875.93018, 3.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4802.34082, -4871.46094, 3.31268,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4826.47314, -4832.06494, 20.74428,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4721.94336, -4955.22510, 21.57000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4773.87988, -4955.72021, 22.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4808.41016, -4954.20020, 20.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4784.10010, -4896.81006, 2.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4787.81982, -4891.87012, 2.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4787.83984, -4903.91016, 4.38598,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4788.97021, -4962.02002, 19.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4743.64990, -4964.54980, 18.60000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4837.95264, -4837.46045, 15.85000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4773.89014, -4833.87988, 18.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4737.66016, -4829.93994, 15.60000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4715.45020, -4838.33008, 18.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1646, 4794.25439, -4835.37305, 4.16685,   3.42000, 358.38010, 179.42000);
	CreateDynamicObject(18751, 4740.95068, -4875.92676, 4.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1609, 4791.12842, -4822.72656, 0.95654,   349.00000, -14.00000, 260.00000);
	CreateDynamicObject(1610, 4802.07813, -4835.96484, 4.27208,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6295, 4925.19287, -4893.31299, 25.59238,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11495, 4856.98291, -4893.60059, 0.84668,   0.00000, 0.00000, -89.40002);
	CreateDynamicObject(18751, 4922.81152, -4888.31201, -3.02000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4945.32080, -4915.31934, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4707.08008, -4968.39014, 17.85000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1607, 4879.66553, -4911.39600, 0.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1637, 4933.35693, -4881.44873, 3.79128,   0.00000, 0.00000, 92.00000);
	CreateDynamicObject(902, 4847.81006, -4879.33008, 1.80000,   0.00000, 22.25000, 0.00000);
	CreateDynamicObject(11495, 4744.93994, -4819.68994, 1.62000,   0.00000, 0.00000, 12.00000);
	CreateDynamicObject(11495, 4740.79004, -4800.04004, 7.37000,   32.25000, 0.00000, 11.99000);
	CreateDynamicObject(11495, 4739.54004, -4794.22998, 11.15000,   34.74000, 0.00000, 11.99000);
	CreateDynamicObject(710, 4817.23047, -4963.40625, 19.97247,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1255, 4817.37354, -4836.19092, 4.49269,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 4815.88818, -4836.13525, 4.35314,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 4814.24609, -4836.20020, 4.23792,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 4812.45117, -4836.20313, 4.01941,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1255, 4810.80225, -4836.16748, 4.08267,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(710, 4824.68311, -4955.00537, 19.97247,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4788.42529, -4951.52148, 20.53000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4780.04248, -4841.18311, 18.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4830.32666, -4845.04932, 15.85000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4780.12549, -4829.68652, 16.86380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(946, 4801.90234, -4852.82666, 7.80277,   0.00000, 0.00000, -183.00000);
	CreateDynamicObject(2114, 4802.89795, -4857.03955, 6.57775,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2114, 4802.78906, -4856.07959, 6.31926,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2114, 4802.04199, -4855.85303, 6.31414,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2114, 4802.78369, -4853.23877, 5.76425,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(7885, 4684.05078, -4901.29785, 9.03502,   0.00000, 0.00000, -179.69997);
	CreateDynamicObject(18751, 4693.11084, -4873.19189, 4.23841,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(18751, 4695.86328, -4900.17432, 3.78630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11490, 4749.26758, -4945.56738, 8.75713,   0.00000, 0.00000, -178.56004);
	CreateDynamicObject(11490, 4746.17725, -4851.89893, 6.30232,   0.00000, 0.00000, -361.44003);
	CreateDynamicObject(1637, 4807.22266, -4938.17480, 10.69296,   0.00000, 0.00000, -92.63999);
	CreateDynamicObject(1637, 4787.43848, -4853.73975, 6.93244,   0.00000, 0.00000, -92.63999);
	CreateDynamicObject(1637, 4817.80127, -4859.22754, 8.90793,   0.00000, 0.00000, -92.63999);
	CreateDynamicObject(1637, 4712.00439, -4853.34082, 7.90997,   0.00000, 0.00000, -92.63999);
	CreateDynamicObject(1637, 4823.50635, -4938.40576, 8.81250,   0.00000, 0.00000, -92.63999);
	CreateDynamicObject(710, 4693.75439, -4970.40283, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4657.75879, -4924.02588, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4658.07520, -4907.76416, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4657.05957, -4891.33789, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4656.95898, -4877.19775, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4717.89502, -4831.73486, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4739.40918, -4837.42383, 17.18793,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4739.61523, -4956.74170, 21.57000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16113, 4671.47607, -4839.64551, 3.78175,   0.00000, 0.00000, -99.77999);
	CreateDynamicObject(16113, 4658.78857, -4945.57666, 1.42834,   0.00000, 0.00000, -8.81997);
	CreateDynamicObject(19840, 4684.02881, -4959.41504, 9.58090,   0.00000, 0.00000, -262.68002);
	CreateDynamicObject(19840, 4680.68018, -4954.89258, 10.86070,   10.98000, 5.82000, -234.66005);
	CreateDynamicObject(19840, 4677.14307, -4948.31592, 9.89300,   10.98000, 5.82000, -234.66005);
	CreateDynamicObject(19840, 4672.73584, -4940.96143, 9.95224,   10.98000, 5.82000, -245.52003);
	CreateDynamicObject(19840, 4689.91797, -4840.39453, 10.86070,   -0.96000, 4.74000, -310.92026);
	CreateDynamicObject(19840, 4686.27979, -4847.92236, 10.64217,   10.98000, 5.82000, -310.80014);
	CreateDynamicObject(19840, 4678.24365, -4854.27344, 10.86070,   10.98000, 5.82000, -310.80014);
	CreateDynamicObject(19840, 4672.64014, -4859.58838, 10.86070,   10.98000, 5.82000, -310.80014);
	CreateDynamicObject(710, 4705.20020, -4959.15820, 21.57000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4721.92871, -4963.41699, 21.57000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11495, 4877.27881, -4893.28613, 0.83069,   0.00000, 0.00000, -89.40002);
	CreateDynamicObject(11495, 4895.73438, -4893.00635, 0.84599,   0.00000, 0.00000, -89.40002);
	CreateDynamicObject(710, 4940.00830, -4870.58496, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4935.12012, -4876.46387, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4941.94189, -4908.08252, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4900.04980, -4915.29053, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(710, 4906.40625, -4876.66992, 15.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1607, 4873.10645, -4884.13037, 0.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1607, 4957.46338, -4935.98779, 0.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(745, 4698.40430, -4864.69287, 8.70323,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(745, 4695.80273, -4938.62256, 8.70323,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(745, 4692.30811, -4941.71826, 8.70323,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(745, 4695.63770, -4860.45947, 8.70323,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3532, 4742.07617, -4941.25049, 9.53255,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4736.33740, -4942.64893, 8.95635,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4731.88574, -4942.69727, 8.21329,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4731.91357, -4942.66211, 9.27123,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4756.76025, -4940.46729, 10.26024,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4762.37695, -4941.50049, 9.39235,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4765.05371, -4941.25586, 9.39235,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4760.24072, -4939.98193, 9.78624,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4738.71045, -4941.36426, 9.28675,   0.00000, 0.00000, -86.52001);
	CreateDynamicObject(3532, 4753.39258, -4855.66016, 7.29259,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4758.84863, -4855.15918, 7.35323,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4762.96094, -4855.47949, 7.43544,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4755.98682, -4855.89551, 7.29259,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4738.30420, -4855.46680, 7.25043,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4732.93604, -4854.70898, 7.25043,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4730.74707, -4854.52100, 7.25043,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(3532, 4736.14063, -4855.77881, 7.25043,   0.00000, 0.00000, -85.50002);
	CreateDynamicObject(6965, 4745.97852, -4901.49512, 9.03167,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3532, 4729.43799, -4944.64893, 7.26509,   0.00000, 0.00000, -198.00002);
	CreateDynamicObject(3532, 4728.49414, -4944.21484, 8.61321,   0.00000, 0.00000, -198.00002);
	CreateDynamicObject(3532, 4728.49414, -4944.21484, 7.66660,   0.00000, 0.00000, -198.00002);
	CreateDynamicObject(8171, 4780.84570, -4990.89063, 3.48947,   0.00000, 0.00000, -90.30000);
	CreateDynamicObject(8171, 4716.85352, -4990.63770, 3.48947,   0.00000, 0.00000, -270.23996);
	CreateDynamicObject(8251, 4661.78662, -4990.14746, 7.22764,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18751, 4693.18848, -4922.93848, 4.64507,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9245, 4659.11133, -4967.38965, 14.09375,   0.00000, 0.00000, -180.53990);
	CreateDynamicObject(18850, 4662.08838, -5022.41699, -8.59115,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1646, 4795.61670, -4835.36816, 4.23918,   3.42000, 358.38010, 179.42000);
	CreateDynamicObject(1646, 4797.00049, -4835.37793, 4.39105,   3.42000, 358.38010, 179.42000);
	CreateDynamicObject(1646, 4798.43799, -4835.46045, 4.52124,   3.42000, 358.38010, 179.42000);
	CreateDynamicObject(1646, 4800.02539, -4835.47607, 4.58633,   3.42000, 358.38010, 179.42000);
	CreateVehicle(519, 4664.0591, -4990.2681, 5.5556, -89.8200, -1, -1, 100);
	CreateVehicle(563, 4663.5220, -5022.4502, 4.9671, -88.5600, -1, -1, 100);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	new file[256], name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
  	format(file,sizeof(file),PlayerFile,name);
	if(!dini_Exists(file) )
 	{
	 	dini_Create(file);
	 	dini_Set(file,"Name",name);
	 	dini_IntSet(file,"Vip",0);
	 	PlayerInfo[playerid][Vip] = 0;
   	}
   	else
   	{
  	PlayerInfo[playerid][Vip] = dini_Int(file,"Vip");
   	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Flaming[playerid] = 0;
	DestroyVehicle(tank[playerid]);
	DestroyVehicle(hydra[playerid]);
	DestroyVehicle(hunter[playerid]);
    Delete3DTextLabel(playerLabels[playerid]);
	new file[256], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
   	format(file,sizeof(file),PlayerFile,name);
	if(dini_Exists(file) )
	{
			dini_IntSet(file,"Vip",PlayerInfo[playerid][Vip]);
			}
	if(IsPlayerSpecing[playerid] == 1)
	{
	    foreach(Player,i)
	    {
	    	if(spectatorid[i] == playerid)
			{
				TogglePlayerSpectating(i,false);
			}
		}
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	new ranks[90];
	switch(PlayerInfo[playerid][Vip])
	{
		case 1: ranks = ""red"Íîâè÷îê â VIP";
 		case 2: ranks = ""red"Ïğîøàğåííûé VI";
 		case 3: ranks = ""red"Çíàìåíèòûé VIP";
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}


CMD:checklevel(playerid,params[])
{

	new string[56];
	format(string,sizeof(string),"Òâîé âèï óğîâåíü %d",PlayerInfo[playerid][Vip]);
	SendClientMessage(playerid,COLOR_RED,string);

	return 1;
}
CMD:setvip(playerid,params[])
{
	new id, level;
   	if(sscanf(params,"ud",id,level) ) return SendClientMessage(playerid,COLOR_RED,"ÏĞÀÂÊÀ: /setvip [id][ level]");
	if(!IsPlayerAdmin(playerid) ) return SendClientMessage(playerid,COLOR_RED,"Íå òğîø!");
    if(level > MAX_VIP) return SendClientMessage(playerid,COLOR_RED,"Íå òğîãàé åãî");
 	if(!IsPlayerConnected(id) ) return SendClientMessage(playerid,COLOR_RED,"Íåò òàêîãî èãğîêà");
	 else
	 {
 	new name[MAX_PLAYER_NAME], playername[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
 	GetPlayerName(id,playername,sizeof(playername));

	new fstring[256], zstring[256];

	format(fstring,sizeof(fstring),"Àäìèíèñòğàòîğ %s ñäåëàë òåáÿ V.I.P %d óğîâíÿ",name,level);
 	format(zstring,sizeof(zstring),"Òû ñäåëàë èãğîêà %s V.I.P %d óğîâíÿ.",playername,level);

	SendClientMessage(playerid,COLOR_RED,zstring);
 	SendClientMessage(id,COLOR_RED,fstring);
	PlayerInfo[id][Vip] = level;
	 }
  	return 1;
}

/*_______________________________________________________________________________________
|                            /| 	   ___                                            	 |
|              /              |       /                                                  |
|             /__ EVEL       _|_     /___ OMMANDS                                        |
|________________________________________________________________________________________|*/

CMD:vipisland(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
    {
	SetCameraBehindPlayer(playerid);
	if(IsPlayerInAnyVehicle(playerid))
	{
	    LinkVehicleToInterior(GetPlayerVehicleID(playerid), 0);
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	    SetVehiclePos(GetPlayerVehicleID(playerid), 4701.8442,-4901.1357,10.7976);
	    SetVehicleZAngle(GetPlayerVehicleID(playerid), 264.5535);
	}
	else
	{
	    SetPlayerInterior(playerid, 0);
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerPos(playerid, 4701.8442,-4901.1357,10.7976);
	    SetPlayerFacingAngle(playerid, 264.5535);
	}
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "red"Íå òğîø.");
	}
	return 1;
}
CMD:vips(playerid, params[])
{
	new
	    count = 0;

	new
	    string[256],
	    string2[3000]
	;

	strcat(string2, ""yellow"");
	strcat(string2, ".:: ÂÈÏÛ ::.\n");

    foreach(Player,x)
    {
	    if(PlayerInfo[x][Vip] >= 1 || PlayerInfo[x][Vip] >= 2 || PlayerInfo[x][Vip] >= 3)
	    {
	        count++;
            format(string, sizeof(string),"»"grey"VIP %s[%d] "yellow"ÓĞÎÂÅÍÜ: %d\n", GetName(x), x, PlayerInfo[x][Vip]);
            strcat(string2, string);
        }
    }
    if(count == 0)
    {
        strcat(string2, ""red"");
        strcat(string2, "Íåò ÂÈÏÎÂ ñåé÷àñ â èãğå.");
    }

    ShowPlayerDialog(playerid, N, DIALOG_STYLE_MSGBOX, ""red"ÂÈÏÛ", string2, "Çàêğûòü", "");
	return 1;
}

CMD:vtag(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
	{
		if(PlayerInfo[playerid][Vip] == 1 )
		{
		    playerLabels[playerid] = Create3DTextLabel("Íîâè÷îê â V.I.P", 0x33CCFF99, 0.0, 0.0, 0.0, 40.0, 0, 1);
			Attach3DTextLabelToPlayer(playerLabels[playerid], playerid, 0.0, 0.0, -0.6);
    		SendClientMessage(playerid, 0x33AA33AA, "Âû âêëş÷èëè òıã V.I.P");
		}
		else if(PlayerInfo[playerid][Vip] == 2 )
		{
			playerLabels[playerid] = Create3DTextLabel("Ïğîøàğåííûé â V.I.P", 0x33CCFF99, 0.0, 0.0, 0.0, 40.0, 0, 1);
			Attach3DTextLabelToPlayer(playerLabels[playerid], playerid, 0.0, 0.0, -0.6);
			SendClientMessage(playerid, 0x33AA33AA, "Âû âêëş÷èëè òıã V.I.P");
		}
  		else if(PlayerInfo[playerid][Vip] == 3 )
		{
		playerLabels[playerid] = Create3DTextLabel("Çíàìåíèòûé â V.I.P", 0x33CCFF99, 0.0, 0.0, 0.0, 40.0, 0, 1);
		Attach3DTextLabelToPlayer(playerLabels[playerid], playerid, 0.0, 0.0, -0.6);
		SendClientMessage(playerid, 0x33AA33AA, "Âû âêëş÷èëè òıã V.I.P");
		}

	}
	else
	{
	    SendClientMessage(playerid, -1, "» "red"Íå òğîø.");
	}
	return 1;
}
CMD:vchat(playerid,params[])
{
	new string[140];
 	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "ÏĞÀÂÊÀ: /vchat [chat]");
  	if(PlayerInfo[playerid][Vip] == 1)
   	{
		format(string, 140, ""yellow"[ÂÈÏ-×ÀÒ] -- %s ( ÑÒÀÒÓÑ: ÍÎÂÈ×ÎÊ Â V.I.P): %s", GetName(playerid), params);
  	}
	else if(PlayerInfo[playerid][Vip] == 2)
	{
 		format(string, 140, ""yellow"[ÂÈÏ-×ÀÒ] -- %s ( ÑÒÀÒÓÑ: ÏĞÎØÀĞÅÍÍÛÉ Â V.I.P): %s", GetName(playerid), params);
	}
	else if(PlayerInfo[playerid][Vip] == 3)
	{
 		format(string, 140, ""yellow"[ÂÈÏ-×ÀÒ] -- %s ( ÑÒÀÒÓÑ: ÇÍÀÌÅÍÈÒÛÉ Â V.I.P: %s", GetName(playerid), params);
   	}
    SendClientMessageToAll(playerid,string);
	return 1;
}
CMD:vjetpack(playerid,params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
   	{
   	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
    SendClientMessage(playerid, COLOR_RED, "* Âû àêòèâèğîâàëè ğåæèì Ñóïåğìåíà ");
   	   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø!");
	}
	return 1;
}
CMD:clearmychat(playerid,params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
   	{
	ClearMyChat(playerid);
   	   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}


CMD:vhydra(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
	{
    DestroyVehicle(hydra[playerid]);
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
 	hydra[playerid]=CreateVehicle(520, pos[0], pos[1], pos[2], pos[3], 1, 1, 1200);
 	PutPlayerInVehicle(playerid,hydra[playerid], 0);
    SendClientMessage(playerid,COLOR_YELLOW,"Âû âçÿëè ñàìîëåò ãîäà");
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
   	return 1;
}
CMD:vtank(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
	{
    DestroyVehicle(tank[playerid]);
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
 	tank[playerid]=CreateVehicle(432, pos[0], pos[1], pos[2], pos[3], 1, 1, 1200);
 	PutPlayerInVehicle(playerid,tank[playerid], 0);
    SendClientMessage(playerid,COLOR_YELLOW,"Âû âçÿëè ğàçğóøèòåëüíóş ìîùü!");
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}
CMD:vrhino(playerid, params[]) return cmd_vtank(playerid, params);
CMD:vhunter(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 1 )
	{
    DestroyVehicle(hunter[playerid]);
	new Float:pos[4];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayerFacingAngle(playerid, pos[3]);
 	hunter[playerid]=CreateVehicle(425, pos[0], pos[1], pos[2], pos[3], 1, 1, 1200);
 	PutPlayerInVehicle(playerid,hunter[playerid], 0);
    SendClientMessage(playerid,COLOR_YELLOW,"Âû âçÿëè âåğòîõëàì ñ ìóñîğêè ãäå ñäîõ áîìæ Âàñÿ.");
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}


/*_______________________________________________________________________________________
|                           ___       	___                                             |
|              /              /    	   /                                                |
|             /__ EVEL       /---     /___ OMMANDS                                      |
|_______________________________________________________________________________________|*/


CMD:vmyw(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 2)
	{
	new weather, string[128];
	if(sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "ÏĞÀÂÊÀ: /vmyw [0 - 45]");
	if(weather < 0 || weather > 45) return SendClientMessage(playerid, -1, "» "grey"Íåâåğíûé ID ïîãîäû íàõóé! <0 - 45>");
	SetPlayerWeather(playerid, weather);
	format(string, sizeof(string), ""yellow"Âû ñìåíèëè ïëîõóş ïîãîäó");
	SendClientMessage(playerid, COLOR_GREEN, string);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}
CMD:vmyweather(playerid, params[]) return cmd_vmyw(playerid, params);

CMD:vmytime(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 2)
	{
	new time, string[128];
	if(sscanf(params, "i", time)) return SendClientMessage(playerid, COLOR_RED, "ÏĞÀÂÊÀ: /vmytime [0 - 23]");
	if(time < 0 || time > 23) return SendClientMessage(playerid, -1, "» "grey"ÍÅÂÅĞÍÎÅ ÂĞÅÌß ÁËß! <0 - 23>");
	format(string, sizeof(string), ""yellow"ÂÛ ÑÌÅÍÈËÈ ÑÅÁÅ ÂĞÅÌß ÅÏÒÀ");
	SendClientMessage(playerid, COLOR_GREEN, string);
	SetPlayerTime(playerid, time, 0);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}
CMD:myt(playerid, params[]) return cmd_vmytime(playerid, params);
CMD:vskin(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 2)
	{
	new
	    string[200],
	    SkinID
	;

	if(sscanf(params, "i", SkinID)) return SendClientMessage(playerid, COLOR_YELLOW, "ÏĞÀÂÊÀ: /vskin [Skin = 299)]");
	if(SkinID < 0 || SkinID > 299) return SendClientMessage(playerid, -1, "» "grey"ÍÅÂÅĞÍÛÉ ÈÄ ÁÎÌÆÀ.");
 	format(string, 128, ""yellow"ÂÛ ÏÅĞÅÎÄÅËÈÑÜ ÈÇ ÁÎÌÆÀ Â ÊĞÀÑÀÂ×ÈÊÀ! ID ÂÀØÅÃÎ ÁÎÌÆÀ: %d.", SkinID);
	SendClientMessage(playerid, COLOR_YELLOW, string);

	SetPlayerSkin(playerid, SkinID);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
	return 1;
}
CMD:vspec(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 2)
   	{
	new id;
	if(sscanf(params,"u", id))return SendClientMessage(playerid, COLOR_RED, "ÏĞÀÂÊÀ: /spec [id]");
	if(id == playerid)return SendClientMessage(playerid,COLOR_RED,"×Å ÏÎÅÕÀË ØÒÎËÈ, ÇÀ ÑÎÁÎÉ ÍÅ ÍÀÄÎ ÑÌÎÒĞÅÒÜ.");
	if(id == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_RED, "ÈÃĞÎÊ ÍÅ ÍÀÉÄÅÍ ÑËÅÏÎØÀĞÀ!");
	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,COLOR_RED,"ÒÛ ÓÆÅ ÑËÅÄÈØÜ ÇÀ ÎÄÍÈÌ ØÈÇÈÊ.");
	GetPlayerPos(playerid,SpecX[playerid],SpecY[playerid],SpecZ[playerid]);
	Inter[playerid] = GetPlayerInterior(playerid);
	vWorld[playerid] = GetPlayerVirtualWorld(playerid);
	TogglePlayerSpectating(playerid, true);
	if(IsPlayerInAnyVehicle(id))
	{
	    if(GetPlayerInterior(id) > 0)
	    {
			SetPlayerInterior(playerid,GetPlayerInterior(id));
		}
		if(GetPlayerVirtualWorld(id) > 0)
		{
		    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		}
	    PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
	}
	else
	{
	    if(GetPlayerInterior(id) > 0)
	    {
			SetPlayerInterior(playerid,GetPlayerInterior(id));
		}
		if(GetPlayerVirtualWorld(id) > 0)
		{
		    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		}
	    PlayerSpectatePlayer(playerid,id);
	}
	GetPlayerName(id, Name, sizeof(Name));
	format(String, sizeof(String),"ÂÛ ÍÀ×ÀËÈ ÑËÅÄÈÒÜ ÇÀ ÃÎËÎÉ ÁÀÁÎÉ "yellow"%s.",Name);
	SendClientMessage(playerid,0x0080C0FF,String);
	IsSpecing[playerid] = 1;
	IsPlayerSpecing[id] = 1;
	spectatorid[playerid] = id;
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
 	return 1;
}

CMD:vspecoff(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] >= 2)
   	{
	if(IsSpecing[playerid] == 0)return SendClientMessage(playerid,COLOR_RED,"ÒÛ ÍÅ ÑËÅÄÈØÜ ÍÈ ÇÀ ÊÅÌ.");
	TogglePlayerSpectating(playerid, 0);
	IsSpecing[playerid] = 0;
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}

CMD:vrepair(playerid, params[])
{
  if(PlayerInfo[playerid][Vip] >= 2)
  {
        if(IsPlayerInAnyVehicle(playerid))
        {
           new veh;
           veh = GetPlayerVehicleID(playerid);
           RepairVehicle(veh);
           return SendClientMessage(playerid, COLOR_YELLOW,"Î, ÒÛ ÌÅÕÀÍÈÊÎÌ ÑÒÀË, ÒÛ ÏÎ×ÈÍÈË ÑÂÎŞ ĞÀÇÂÀËŞÕÓ");
        }
        else return SendClientMessage(playerid, Grey,"ÊÎÃÎ ÁÓÄÅØÜ ×ÈÍÈÒÜ? ÑÅÁß? ÀÕÀÕ");
  }
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ");
	}
  return 1;
}

CMD:vplacefw(playerid, params[])
{
	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,Grey,"ÒÛ ÍÅ ÈÌÅÅØÜ ÏĞÀÂÀ.");
	if(PlayerInfo[playerid][Vip] >= 2)
   	{
	if(FireworkTotal == MAX_LAUNCH)
	{
		SendClientMessage(playerid, COLOR_RED, "ÍÅ ÍÀÄÎ ÂÇĞÛÂÀÒÜ ÑÅĞÂÅĞ ÏÆ!");
		return 1;
	}
	if(Fired == 1)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "ÏÓÑÒÜ ÂÇĞÛÂÛ ÂÇÎĞÂÓÒÑß È ÇÀÑÏÀÂÍÈ ÍÎÂÛÅ!");
		return 1;
	}
	new string[128];
	format(string, sizeof(string), ""yellow"%s ÏÎÑÒÀÂÈË ÔÅÉÅĞÂÅĞÊÈ ÅÃÎ ÏÓÊÀÍ ÙÀ ÂÇÀĞÂÅÒÑß.", GetName(playerid));
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	foreach(Player, i)
	{
		if(IsPlayerInRangeOfPoint(i, 30, x, y, z))
		{
			SendClientMessage(i, COLOR_YELLOW, string);
		}
	}
	GetPlayerFacingAngle(playerid, a);
	x += (2 * floatsin(-a, degrees));
	y += (2 * floatcos(-a, degrees));
	Rocket[FireworkTotal] = CreateDynamicObject(3786, x, y, z, 0, 90, 0);
	RocketLight[FireworkTotal] = CreateDynamicObject(354, x, y, z + 1, 0, 90, 0);
	RocketSmoke[FireworkTotal] = CreateDynamicObject(18716, x, y, z - 4, 0, 0, 0);
	rx4[FireworkTotal] = x;
	ry4[FireworkTotal] = y;
	rz4[FireworkTotal] = z;
	RocketExplosions[FireworkTotal] = 0;
	FireworkTotal++;
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"Íå òğîø.");
	}
   	return 1;
}

CMD:vlightfw(playerid, params[])
{

	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,Grey,"ÍÅ ÈÌÅÅØÜ ÏĞÀÂÀ.");
	if(PlayerInfo[playerid][Vip] >= 2)
   	{

	if(FireworkTotal == 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "ÊÓÏÈ ÔÅÉÅĞÂÅĞÊÈ ÏĞÅÆÄÅ ×ÅÌ ÏÎÑÒÀÂÈÒÜ");
		return 1;
	}
	if(Fired == 1)
	{
		SendClientMessage(playerid, COLOR_RED, "ÒÛ ÓÆÅ ÏÓÑÒÈË ÔÅÉÅĞÂÅĞÊ!");
		return 1;
	}
	for(new i = 0; i < FireworkTotal; i++)
	{
		CreateExplosion(rx4[i] ,ry4[i], rz4[i], 12, 5);
		new time = MoveDynamicObject(Rocket[i], rx4[i] ,ry4[i], rz4[i] + RocketHeight, 10);
		MoveDynamicObject(RocketLight[i], rx4[i] ,ry4[i], rz4[i] + 2 + RocketHeight, 10);
		MoveDynamicObject(RocketSmoke[i], rx4[i] ,ry4[i], rz4[i] + RocketHeight, 10);
		SetTimerEx("Firework", time, 0, "i", i);
	}
	Fired = 1;
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
   	return 1;
}

CMD:varmour(playerid,params[])
{
  	if(PlayerInfo[playerid][Vip] >= 2)
   	{
	SetPlayerArmour(playerid, 100);
 	SendClientMessage(playerid, -1, "» "yellow"ÒÂÎß ÁĞÎÍß ÒÅÏÅĞÜ ÍÀ ÑÎÒÊÓ.");

   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}

CMD:vspawnme( playerid, params[ ] )
{
  	if(PlayerInfo[playerid][Vip] >= 2)
	{
	SetPlayerPos( playerid, 0.0, 0.0, 0.0 );
    SpawnPlayer( playerid );
    SendClientMessage( playerid, COLOR_YELLOW, "ÒÛ ÇÀĞÅÑÏÀÂÍÈËÑß!" );
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}


/*_______________________________________________________________________________________
|                            __       ___                                               |
|              /            --/     /                                                  	|
|             /__ EVEL     __/     /___ OMMANDS                                         |
|_______________________________________________________________________________________|*/
CMD:vannounce(playerid, params[])
{

  	if(PlayerInfo[playerid][Vip] >= 3)
	{
		if(isnull(params)) return SendClientMessage(playerid, COLOR_YELLOW, "ÏĞÀÂÊÀ: /vannounce [text]");


		GameTextForAll(params, 5000, 3);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "red"ÍÅ ÒĞÎØ.");
	}
	return 1;
}

CMD:vheal(playerid,params[])
{
  	if(PlayerInfo[playerid][Vip] >= 1)
   	{
	SetPlayerHealth(playerid, 100);
 	SendClientMessage(playerid, -1, "» "yellow"ÅÁÀ ÒÛ ÌÅÄÈÊ ÒÛ ÑÅÁß ÂÛËÅ×ÈË");

   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}

CMD:vhealplayer(playerid, params[])
{
	new
	    string[200],
	    id
	;
  	if(PlayerInfo[playerid][Vip] >= 3 )
	{
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_YELLOW, "ÏĞÀÂÊÀ: /healplayer [playerid]");
		if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "» "grey"ÍÅÒ ÒÀÊÎÃÎ ÈÃĞÎÊÀ ÑËÅÏÎØÀĞÀ.");

		format(string, 128, ""grey"%s ÂÛËÅ×ÅÍ Ñ ÏÎÌÎÙÜŞ ÂĞÀ×À "yellow"%s.", GetName(id), GetName(playerid));
		SendClientMessageToAll(COLOR_RED, string);

	    SetPlayerHealth(id, 100.0);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}
CMD:vgod(playerid, params[])
{
	if(PlayerInfo[playerid][Vip] == 3 )
	{
	new id = GetPVarInt(playerid, "GodMode");
	if(id == 0)
	{
	    SendClientMessage(playerid, -1, "» "yellow"ÒÛ ÑÒÀË "red"ÈÈÑÓÑÎÌ.");
	    SetPlayerHealth(playerid, 9999999);
	    SetPVarInt(playerid, "GodMode", 1);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "yellow"ÒÛ ÑÒÀË "red"ÁÎÌÆÎÌ.");
		SetPlayerHealth(playerid, 100.0);

	    SetPVarInt(playerid, "GodMode", 0);
	}
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}
CMD:vgoto(playerid, params[])
{
	if(IsSpecing[playerid] == 1)return SendClientMessage(playerid,Grey,"ÒÛ ÍÅ ÈÌÅÅØÜ ÏĞÀÂÀ.");
	if(PlayerInfo[playerid][Vip] == 3 )
   	{
	new
		id,
		string[130],
		Float:x,
		Float:y,
		Float:z
 	;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, Grey, "ÏĞÀÂÊÀ: /vgoto [playerid]");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "» "grey"ÏĞÎÂÅĞÜ ÈÄ ÈÃĞÎÊÀ.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED, "ÍÅ ÍÀÄÎ..");
	if(GetPlayerState(id) != 1 && GetPlayerState(id) != 2 && GetPlayerState(id) != 3) return SendClientMessage(playerid, -1, "» "grey"ÈÃĞÎÊ ÍÅ ÇÀÑÏÀÂÍÈËÑß ËÎË");
	GetPlayerPos(id, x, y, z);
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	if(GetPlayerState(playerid) == 2)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), x+3, y, z);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(id));
		}
	else SetPlayerPos(playerid, x+2, y, z);
	format(string, sizeof(string), ""yellow"ÒÛ ÑÒÀË ÄÆÅÊÈ×ÀÍÎÌ È ÒÅËÅÏÎĞÒÈĞÎÂÀËÑß Ê ÈÃĞÎÊÓ %s", GetName(id));
	SendClientMessage(playerid, COLOR_YELLOW, string);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
	return 1;
}

//credits to ahmad95
CMD:vflaminghand(playerid)
{
	if(PlayerInfo[playerid][Vip] >= 3 )
   	{
    if(Flaming[playerid] == 0)
    {
    Flaming[playerid] = 1;
	SetPlayerAttachedObject( playerid, 0, 18693, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 1, 18693, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 2, 18703, 6, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );
	SetPlayerAttachedObject( playerid, 3, 18703, 5, 1.983503, 1.558882, -0.129482, 86.705787, 308.978118, 268.198822, 1.500000, 1.500000, 1.500000 );

	SendClientMessage(playerid, Grey, "ÒÛ ÑÒÀË ÁĞŞÑÎÌ ÂÑÅÌÎÃÓÙÈÌ.");
    }
    else if(Flaming[playerid] == 1)
    {
        Flaming[playerid] = 0;

        for ( new i = 0; i < 4; i++ )
	if ( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
	RemovePlayerAttachedObject( playerid, i );

        SendClientMessage(playerid, Grey, "ÒÛ ÑÒÀË ÁÎÌÆÎÌ.");

    }
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
   	return 1;
}
// credits to yugecin
CMD:vghostrider( playerid, params[ ] )
{
	if(PlayerInfo[playerid][Vip] >= 3 )
   	{
    if ( !IsPlayerInAnyVehicle( playerid ) )
		return SendClientMessage( playerid, COLOR_RED, "ÑÓÊÀ: "yellow"ÒÛ ÄÎËÆÅÍ ÁÛÒÜ ÍÀ ÌÎÒÎÖÈÊËÅ ÁÀÉÊÅĞÎÂ ÄÓĞÛÍÄÀ!" );

	if ( GetPlayerState( playerid ) != PLAYER_STATE_DRIVER)
		return SendClientMessage( playerid, COLOR_RED, "ÑÓÊÀ: "yellow"ÏĞÈÇĞÀ×ÍÛÉ ÃÎÍÙÈÊ ÁÛË ÍÅ ÏÅØÊÎÌ!");

	if ( GetVehicleModel( GetPlayerVehicleID( playerid ) ) != 463 )
		return SendClientMessage( playerid, COLOR_RED, "ÑÓÊÀ: "yellow"ÒÛ ÄÎËÆÅÍ ÑÅÑÒÜ Â ÌÎÒÎÖÈÊË ÁÀÉÊÅĞÎÂ!" );

	if ( grider[ playerid ][ 0 ] )
	{
    	DestroyObject( grider[ playerid ][ 0 ] );
    	DestroyObject( grider[ playerid ][ 1 ] );
    	DestroyObject( grider[ playerid ][ 2 ] );
    	grider[ playerid ][ 0 ] = 0;
    	return ( 1 );
	}

	new Float:vh;
	GetVehicleHealth( GetPlayerVehicleID( playerid ), vh );
	if ( vh < 250 )
		return SendClientMessage( playerid, COLOR_RED, "ÑÓÊÀ: "yellow"ÏÎ×ÈÍÈ ÑÂÎŞ ĞÀÇÂÀËÈÍÓ!" );

	grider[ playerid ][ 0 ] = CreateObject( 18689, 0.0, 0.0, 0.0, 0.0, 0.0, 256.0 );
    grider[ playerid ][ 1 ] = CreateObject( 18689, 0.0, 0.0, 0.0, 0.0, 0.0, 256.0 );
    grider[ playerid ][ 2 ] = CreateObject( 18693, 0.0, 0.0, 0.0, 0.0, 0.0, 256.0 );

    AttachObjectToVehicle( grider[ playerid ][ 0 ], GetPlayerVehicleID( playerid ), 0.0, 0.6, -1.7, 0.0, 0.0, 0.0 );
    AttachObjectToVehicle( grider[ playerid ][ 1 ], GetPlayerVehicleID( playerid ), 0.0, -1.4, -1.7, 0.0, 0.0, 0.0 );
    AttachObjectToPlayer( grider[ playerid ][ 2 ], playerid, 0.0, -0.01, -0.9, 0.0, 0.0, 0.0 );
    ChangeVehicleColor( GetPlayerVehicleID( playerid ), 0, 0 );
   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "grey"ÍÅ ÒĞÎØ.");
	}
   	return 1;
}


CMD:vcredits(playerid, params[])
{
	new string[1400];
	strcat(string, ""yellow"ÂÈÏ ÑÈÑÒÅÌÀ ÎÒ: "red"SA-MP Team\n\n");
	strcat(string, ""blue"- ÎÍ ÇÀÑÊĞÈÏÒÈË İÒÎÒ ÑÊĞÈÏÒ\n");
	strcat(string, "- ÏÅĞÅÂÅË - ]_DA[R]K_[\n");
	strcat(string, "- ÍÅÒÓ ÍÈÊÎÃÎ ÒÓÒ ÁÎËÜØÅ\n");
	strcat(string, "- ÍÅÒÓ ÍÈÊÎÃÎ ÒÓÒ ÁÎËÜØÅ\n");
	ShowPlayerDialog(playerid, N, DIALOG_STYLE_MSGBOX, ""blue"ÑÈÑÒÅÌÀ ÂÈÏ ÊĞÅÀÒÎĞÛ", string, "Close", "");
	return 1;
}

stock GetName(playerid)
{
	new pName[24];
	GetPlayerName(playerid, pName, 24);
	return pName;
}
stock ClearMyChat(playerid)
{
	for(new i=0; i<200; i++)
	{
	    SendClientMessage(playerid, -1, " ");
	}
	return 1;
}




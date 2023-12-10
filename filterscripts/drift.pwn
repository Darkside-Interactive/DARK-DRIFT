#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //максимум игроков на сервере + 1 (если 50 игроков, то пишем 51 !!!)

#if (MAX_PLAYERS > 501)
	#undef MAX_PLAYERS
	#define MAX_PLAYERS 501
#endif

#define DRIFT_MINKAT 10.0
#define DRIFT_MAXKAT 90.0
#define DRIFT_SPEED 30.0

forward LevelUpdate();
forward Drift();
forward DriftCancellation(playerid);

new dddrift[MAX_PLAYERS];//переменная контроля дрифта
new Text3D:Level3D[MAX_PLAYERS];
new LevelStats[MAX_PLAYERS];
new Text:leveldr[11];
new DriftPointsNow[MAX_PLAYERS];
new GlowColor;
new PlayerDriftCancellation[MAX_PLAYERS];
new Float:ppos[MAX_PLAYERS][3];
new	drifttimer;
new	leveltimer;
new remotelock[MAX_PLAYERS];
new Glow[MAX_PLAYERS];
new GlowColors[37] = {
0xFF0000FF,
0xFF4E00FF,
0xFF7E00FF,
0xFFA800FF,
0xFFC000FF,
0xFFD800FF,
0xFFF600FF,
0xEAFF00FF,
0xD2FF00FF,
0x9CFF00FF,
0x3CFF00FF,
0x00FF2AFF,
0x00FF90FF,
0x00FFBAFF,
0x00FFF0FF,
0x00F6FFFF,
0x00C6FFFF,
0x00BAFFFF,
0x0096FFFF,
0x0084FFFF,
0x006CFFFF,
0x004EFFFF,
0x003CFFFF,
0x0000FFFF,
0x1200FFFF,
0x3600FFFF,
0x4E00FFFF,
0x6C00FFFF,
0x8A00FFFF,
0xA800FFFF,
0xC000FFFF,
0xDE00FFFF,
0xFF00F6FF,
0xFF00A8FF,
0xFF007EFF,
0xFF0066FF,
0xFF0036FF
};

enum PlayerData
{
	Level[200]
};
new Playerdr[MAX_PLAYERS][PlayerData];
enum Float:Pos
{
	Float:sX,
	Float:sY,
	Float:sZ,
	Float:dltX,
	Float:dltY,
	Float:dltZ
};
new Float:SavedPos[MAX_PLAYERS][Pos];

public OnFilterScriptInit()
{
	drifttimer = SetTimer("Drift", 200, true);
	leveltimer = SetTimer("LevelUpdate",1991,1);

	print("Levels Downloading");
	// ==================================================================== //
	leveldr[0] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~1");
	TextDrawAlignment(leveldr[0],0);
	TextDrawBackgroundColor(leveldr[0],0x000000ff);
	TextDrawFont(leveldr[0],3);
	TextDrawLetterSize(leveldr[0],0.299999,1.000000);
	TextDrawColor(leveldr[0],0xffffffff);
	TextDrawSetOutline(leveldr[0],1);
	TextDrawSetProportional(leveldr[0],1);
	TextDrawSetShadow(leveldr[0],1);

	leveldr[1] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~2");
	TextDrawAlignment(leveldr[1],0);
	TextDrawBackgroundColor(leveldr[1],0x000000ff);
	TextDrawFont(leveldr[1],3);
	TextDrawLetterSize(leveldr[1],0.299999,1.000000);
	TextDrawColor(leveldr[1],0xffffffff);
	TextDrawSetOutline(leveldr[1],1);
	TextDrawSetProportional(leveldr[1],1);
	TextDrawSetShadow(leveldr[1],1);

	leveldr[2] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~3");
	TextDrawAlignment(leveldr[2],0);
	TextDrawBackgroundColor(leveldr[2],0x000000ff);
	TextDrawFont(leveldr[2],3);
	TextDrawLetterSize(leveldr[2],0.299999,1.000000);
	TextDrawColor(leveldr[2],0xffffffff);
	TextDrawSetOutline(leveldr[2],1);
	TextDrawSetProportional(leveldr[2],1);
	TextDrawSetShadow(leveldr[2],1);

	leveldr[3] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~4");
	TextDrawAlignment(leveldr[3],0);
	TextDrawBackgroundColor(leveldr[3],0x000000ff);
	TextDrawFont(leveldr[3],3);
	TextDrawLetterSize(leveldr[3],0.299999,1.000000);
	TextDrawColor(leveldr[3],0xffffffff);
	TextDrawSetOutline(leveldr[3],1);
	TextDrawSetProportional(leveldr[3],1);
	TextDrawSetShadow(leveldr[3],1);

	leveldr[4] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~5");
	TextDrawAlignment(leveldr[4],0);
	TextDrawBackgroundColor(leveldr[4],0x000000ff);
	TextDrawFont(leveldr[4],3);
	TextDrawLetterSize(leveldr[4],0.299999,1.000000);
	TextDrawColor(leveldr[4],0xffffffff);
	TextDrawSetOutline(leveldr[4],1);
	TextDrawSetProportional(leveldr[4],1);
	TextDrawSetShadow(leveldr[4],1);

	leveldr[5] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~6");
	TextDrawAlignment(leveldr[5],0);
	TextDrawBackgroundColor(leveldr[5],0x000000ff);
	TextDrawFont(leveldr[5],3);
	TextDrawLetterSize(leveldr[5],0.299999,1.000000);
	TextDrawColor(leveldr[5],0xffffffff);
	TextDrawSetOutline(leveldr[5],1);
	TextDrawSetProportional(leveldr[5],1);
	TextDrawSetShadow(leveldr[5],1);

	leveldr[6] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~7");
	TextDrawAlignment(leveldr[6],0);
	TextDrawBackgroundColor(leveldr[6],0x000000ff);
	TextDrawFont(leveldr[6],3);
	TextDrawLetterSize(leveldr[6],0.299999,1.000000);
	TextDrawColor(leveldr[6],0xffffffff);
	TextDrawSetOutline(leveldr[6],1);
	TextDrawSetProportional(leveldr[6],1);
	TextDrawSetShadow(leveldr[6],1);

	leveldr[7] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~8");
	TextDrawAlignment(leveldr[7],0);
	TextDrawBackgroundColor(leveldr[7],0x000000ff);
	TextDrawFont(leveldr[7],3);
	TextDrawLetterSize(leveldr[7],0.299999,1.000000);
	TextDrawColor(leveldr[7],0xffffffff);
	TextDrawSetOutline(leveldr[7],1);
	TextDrawSetProportional(leveldr[7],1);
	TextDrawSetShadow(leveldr[7],1);

	leveldr[8] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~9");
	TextDrawAlignment(leveldr[8],0);
	TextDrawBackgroundColor(leveldr[8],0x000000ff);
	TextDrawFont(leveldr[8],3);
	TextDrawLetterSize(leveldr[8],0.299999,1.000000);
	TextDrawColor(leveldr[8],0xffffffff);
	TextDrawSetOutline(leveldr[8],1);
	TextDrawSetProportional(leveldr[8],1);
	TextDrawSetShadow(leveldr[8],1);

	leveldr[9] = TextDrawCreate(515.000000,99.000000,"Drift level:~g~10");
	TextDrawAlignment(leveldr[9],0);
	TextDrawBackgroundColor(leveldr[9],0x000000ff);
	TextDrawFont(leveldr[9],3);
	TextDrawLetterSize(leveldr[9],0.299999,1.000000);
	TextDrawColor(leveldr[9],0xffffffff);
	TextDrawSetOutline(leveldr[9],1);
	TextDrawSetProportional(leveldr[9],1);
	TextDrawSetShadow(leveldr[9],1);

	leveldr[10] = TextDrawCreate(515.000000,99.000000,"Drift level:~y~VIP");
	TextDrawAlignment(leveldr[10],0);
	TextDrawBackgroundColor(leveldr[10],0x000000ff);
	TextDrawFont(leveldr[10],3);
	TextDrawLetterSize(leveldr[10],0.299999,1.000000);
	TextDrawColor(leveldr[10],0xffffffff);
	TextDrawSetOutline(leveldr[10],1);
	TextDrawSetProportional(leveldr[10],1);
	TextDrawSetShadow(leveldr[10],1);
	// ===================================================================== //
	new Max = GetMaxPlayers();
	for(new i=0; i<Max; i++)
	{
		remotelock[i] = 0;
		Level3D[i] = Create3DTextLabel(" ",0xFFFFFFAA,0.000,0.000,-4.000,18.0,0,1);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	LevelStats[playerid] = 0;
	remotelock[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	remotelock[playerid] = 0;
	return 1;
}

Float:GetPlayerTheoreticAngle(i)
{
	new Float:sin;
	new Float:dis;
	new Float:angle2;
	new Float:x,Float:y,Float:z;
	new Float:tmp3;
	new Float:tmp4;
	new Float:MindAngle;
	GetPlayerPos(i,x,y,z);
	dis = floatsqroot(floatpower(floatabs(floatsub(x,ppos[i][0])),2)+floatpower(floatabs(floatsub(y,ppos[i][1])),2));
	if(IsPlayerInAnyVehicle(i))GetVehicleZAngle(GetPlayerVehicleID(i), angle2); else GetPlayerFacingAngle(i, angle2);
	if(x>ppos[i][0]){tmp3=x-ppos[i][0];}else{tmp3=ppos[i][0]-x;}
	if(y>ppos[i][1]){tmp4=y-ppos[i][1];}else{tmp4=ppos[i][1]-y;}
	if(ppos[i][1]>y && ppos[i][0]>x){
		sin = asin(tmp3/dis);
		MindAngle = floatsub(floatsub(floatadd(sin, 90), floatmul(sin, 2)), -90.0);
	}
	if(ppos[i][1]<y && ppos[i][0]>x){
		sin = asin(tmp3/dis);
		MindAngle = floatsub(floatadd(sin, 180), 180.0);
	}
	if(ppos[i][1]<y && ppos[i][0]<x){
		sin = acos(tmp4/dis);
		MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
	}
	if(ppos[i][1]>y && ppos[i][0]<x){
		sin = asin(tmp3/dis);
		MindAngle = floatadd(sin, 180);
	}
	if(MindAngle == 0.0){
		return angle2;
	} else
		return MindAngle;
}

public OnFilterScriptExit()
{
	for(new i=0; i<11; i++)
	{
		TextDrawDestroy(leveldr[i]);
	}
	new Max = GetMaxPlayers();
	for(new i=0; i<Max; i++)
	{
		Delete3DTextLabel(Level3D[i]);
	}
	KillTimer(drifttimer);
	KillTimer(leveltimer);
	return 1;
}
public DriftCancellation(playerid){
	new locper;//если используется score
	PlayerDriftCancellation[playerid] = 0;
	GameTextForPlayer(playerid, Split("~n~~n~~n~~n~~n~~n~~n~~n~Drift: +~b~ ", tostr(DriftPointsNow[playerid]), "~w~ !"), 3000, 3);
	SetPVarInt(playerid, "MonControl", 1);
	GivePlayerMoney(playerid, DriftPointsNow[playerid]);
	locper = GetPlayerScore(playerid);//если используется score
	SetPVarInt(playerid, "ScorControl", 1);
	SetPlayerScore(playerid, (locper + (DriftPointsNow[playerid] / 1000)));//если используется score
	DriftPointsNow[playerid] = 0;
	dddrift[playerid] = 0;
    return 1;
}

Float:ReturnPlayerAngle(playerid){
	new Float:Ang;
	if(IsPlayerInAnyVehicle(playerid))GetVehicleZAngle(GetPlayerVehicleID(playerid), Ang); else GetPlayerFacingAngle(playerid, Ang);
	return Ang;
}

public Drift(){
	new Float:Angle1, Float:Angle2, Float:BySpeed, s[256];
	new Float:Z;
	new Float:X;
	new Float:Y;
	new Float:SpeedX;
	for(new g=0;g<MAX_PLAYERS;g++){
		if(IsPlayerConnected(g))
		{
			GetPlayerPos(g, X, Y, Z);
			SavedPos[ g ][ dltX ] = floatsub(X,SavedPos[ g ][ sX ]);
			SavedPos[ g ][ dltY ] = floatsub(Y,SavedPos[ g ][ sY ]);
			SavedPos[ g ][ dltZ ] = floatsub(Z,SavedPos[ g ][ sZ ]);
			SpeedX = floatsqroot(floatadd(floatadd(floatmul(SavedPos[ g ][ dltX ],SavedPos[ g ][ dltX ]),floatmul(SavedPos[ g ][ dltY ],SavedPos[ g ][ dltY ])),floatmul(SavedPos[ g ][ dltZ ],SavedPos[ g ][ dltZ ])));
			Angle1 = ReturnPlayerAngle(g);
			Angle2 = GetPlayerTheoreticAngle(g);
			BySpeed = floatmul(SpeedX, 12);
			if(IsPlayerInAnyVehicle(g) && floatabs(floatsub(Angle1, Angle2)) > DRIFT_MINKAT && floatabs(floatsub(Angle1, Angle2)) < DRIFT_MAXKAT && BySpeed > DRIFT_SPEED){
				if(PlayerDriftCancellation[g] > 0)KillTimer(PlayerDriftCancellation[g]);
				PlayerDriftCancellation[g] = 0;
				dddrift[g] += floatval( floatabs(floatsub(Angle1, Angle2)) * 3 * (BySpeed*0.1) )/10;
				//функция мода "FunNickCol" (НЕ дрифтовая)
                //(функция случайных цветов транспорта, цветов ников и маркеров, координат спавна игрока)
                //------------------------------------------------------------------------------
			if(Glow[g] == 1)//мигание ников
			{
				GlowColor++;
	        	if(GlowColor == 36)
				{
					GlowColor = 0;
				}
	        	SetPlayerColor(g ,GlowColors[GlowColor]);
			}
             //------------------------------------------------------------------------------
				if((dddrift[g] - DriftPointsNow[g]) > 2000)//если дрифт больше xxx, то:
				{
					dddrift[g] = 0;//обнуляем дрифт-очки
				}
				DriftPointsNow[g] = dddrift[g];//запоминаем последний дрифт
				PlayerDriftCancellation[g] = SetTimerEx("DriftCancellation", 3000, 0, "d", g);
			}
			if(DriftPointsNow[g] > 0){
				format(s, sizeof(s), "~n~~n~~n~~n~~n~~n~~n~~n~Drift: ~b~%d~b~ ", DriftPointsNow[g]);
				GameTextForPlayer(g, s, 3000, 3);
			}
			SavedPos[ g ][ sX ] = X;
			SavedPos[ g ][ sY ] = Y;
			SavedPos[ g ][ sZ ] = Z;

			new Float:x333, Float:y333, Float:z333;
			if(IsPlayerInAnyVehicle(g))GetVehiclePos(GetPlayerVehicleID(g), x333, y333, z333); else GetPlayerPos(g, x333, y333, z333);
			ppos[g][0] = x333;
			ppos[g][1] = y333;
			ppos[g][2] = z333;

		}
	}
    return 1;
}

Split(s1[], s2[], s3[]=""){
	new rxx[256];
	format(rxx, 256, "%s%s%s", s1, s2, s3);
	return rxx;
}

tostr(int){
	new st[256];
	format(st, 256, "%d", int);
	return st;
}

floatval(Float:val){
	new str[256];
	format(str, 256, "%.0f", val);
	return todec(str);
}

todec(str[]){ // By Luby
	return strval(str);
}

forward leveldrupr(playerid, reg);
public leveldrupr(playerid, reg)
{
	if(reg == 0)
	{
		remotelock[playerid] = 1;
		Delete3DTextLabel(Level3D[playerid]);
	}
	else
	{
		remotelock[playerid] = 0;
		Level3D[playerid] = Create3DTextLabel(" ",0xFFFFFFAA,0.000,0.000,-4.000,18.0,0,1);
		LevelStats[playerid] = 0;
	}
    return 1;
}


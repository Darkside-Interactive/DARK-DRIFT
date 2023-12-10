#include <a_samp>
#include <vehicles>

#pragma tabsize 0

new Text:vehiclebar[25];
new playervehiclebar[MAX_PLAYERS] = 1;
//new announce[MAX_PLAYERS];

forward VehicleInfoInit();
forward VEHICLEHEALTH();
forward ANNOUNCE();
forward AutoHealthOnPlayerCommandText(playerid, cmdtext[]);
//--------------------------------------------------------------------------------------------------------------------------------

public VehicleInfoInit()
{
	vehiclebar[0] = TextDrawCreate(548.0, 57.0, " ");
	TextDrawUseBox(vehiclebar[0], true);
	TextDrawBoxColor(vehiclebar[0], 0x000000ff);
	TextDrawSetShadow(vehiclebar[0],0);
	TextDrawTextSize(vehiclebar[0], 606, 0);

	vehiclebar[1] = TextDrawCreate(548.0, 60.0, " ");
	TextDrawUseBox(vehiclebar[1], true);
	TextDrawBoxColor(vehiclebar[1], 0x000000ff);
	TextDrawSetShadow(vehiclebar[1],0);
	TextDrawTextSize(vehiclebar[1], 606, 0);
	
	vehiclebar[13] = TextDrawCreate(548.0, 63.0, " ");
	TextDrawUseBox(vehiclebar[13], true);
	TextDrawBoxColor(vehiclebar[13], 0x000000ff);
	TextDrawSetShadow(vehiclebar[13],0);
	TextDrawTextSize(vehiclebar[13], 606, 0);
	
	//-----------------------
	
	vehiclebar[2] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[2], true);
	TextDrawBoxColor(vehiclebar[2], 0x004000ff);
	TextDrawSetShadow(vehiclebar[2],0);
	TextDrawTextSize(vehiclebar[2], 604, 0);

	vehiclebar[14] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[14], true);
	TextDrawBoxColor(vehiclebar[14], 0x004000ff);
	TextDrawSetShadow(vehiclebar[14],0);
	TextDrawTextSize(vehiclebar[14], 604, 0);
	
	//------------------------

	vehiclebar[3] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[3], true);
	TextDrawBoxColor(vehiclebar[3], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[3],0);
	TextDrawTextSize(vehiclebar[3], 556, 0);

	vehiclebar[15] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[15], true);
	TextDrawBoxColor(vehiclebar[15], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[15],0);
	TextDrawTextSize(vehiclebar[15], 556, 0);
	
	
	vehiclebar[4] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[4], true);
	TextDrawBoxColor(vehiclebar[4], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[4],0);
	TextDrawTextSize(vehiclebar[4], 560, 0);

	vehiclebar[16] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[16], true);
	TextDrawBoxColor(vehiclebar[16], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[16],0);
	TextDrawTextSize(vehiclebar[16], 560, 0);
	
	
	vehiclebar[5] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[5], true);
	TextDrawBoxColor(vehiclebar[5], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[5],0);
	TextDrawTextSize(vehiclebar[5], 566, 0);

	vehiclebar[17] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[17], true);
	TextDrawBoxColor(vehiclebar[17], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[17],0);
	TextDrawTextSize(vehiclebar[17], 566, 0);
	
	
	vehiclebar[6] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[6], true);
	TextDrawBoxColor(vehiclebar[6], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[6],0);
	TextDrawTextSize(vehiclebar[6], 571, 0);

	vehiclebar[18] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[18], true);
	TextDrawBoxColor(vehiclebar[18], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[18],0);
	TextDrawTextSize(vehiclebar[18], 571, 0);
	
	
	vehiclebar[7] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[7], true);
	TextDrawBoxColor(vehiclebar[7], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[7],0);
	TextDrawTextSize(vehiclebar[7], 576, 0);

	vehiclebar[19] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[19], true);
	TextDrawBoxColor(vehiclebar[19], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[19],0);
	TextDrawTextSize(vehiclebar[19], 576, 0);
	
	
	vehiclebar[8] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[8], true);
	TextDrawBoxColor(vehiclebar[8], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[8],0);
	TextDrawTextSize(vehiclebar[8], 581, 0);
	
	vehiclebar[20] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[20], true);
	TextDrawBoxColor(vehiclebar[20], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[20],0);
	TextDrawTextSize(vehiclebar[20], 581, 0);
	
	
	vehiclebar[9] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[9], true);
	TextDrawBoxColor(vehiclebar[9], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[9],0);
	TextDrawTextSize(vehiclebar[9], 586, 0);

	vehiclebar[21] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[21], true);
	TextDrawBoxColor(vehiclebar[21], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[21],0);
	TextDrawTextSize(vehiclebar[21], 586, 0);
	
	
	vehiclebar[10] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[10], true);
	TextDrawBoxColor(vehiclebar[10], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[10],0);
	TextDrawTextSize(vehiclebar[10], 591, 0);

	vehiclebar[22] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[22], true);
	TextDrawBoxColor(vehiclebar[22], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[22],0);
	TextDrawTextSize(vehiclebar[22], 591, 0);
	
	
	vehiclebar[11] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[11], true);
	TextDrawBoxColor(vehiclebar[11], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[11],0);
	TextDrawTextSize(vehiclebar[11], 596, 0);

	vehiclebar[23] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[23], true);
	TextDrawBoxColor(vehiclebar[23], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[23],0);
	TextDrawTextSize(vehiclebar[23], 596, 0);
	
	
	vehiclebar[12] = TextDrawCreate(550.0, 59.0, " ");
	TextDrawUseBox(vehiclebar[12], true);
	TextDrawBoxColor(vehiclebar[12], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[12],0);
	TextDrawTextSize(vehiclebar[12], 604, 0);

	vehiclebar[24] = TextDrawCreate(550.0, 61.0, " ");
	TextDrawUseBox(vehiclebar[24], true);
	TextDrawBoxColor(vehiclebar[24], 0x00aa00ff);
	TextDrawSetShadow(vehiclebar[24],0);
	TextDrawTextSize(vehiclebar[24], 604, 0);

	SetTimer("VEHICLEHEALTH",500,1);
//	SetTimer("ANNOUNCE",5000,1);
	print("SERVER: Init VehicleInfo");
	return 1;
}

//--------------------------------------------------------------------------------------------------------------------------------
public AutoHealthOnPlayerCommandText(playerid, cmdtext[])
{
//new string[255];
if(strcmp(cmdtext, "/commands", true) == 0) {
		SendClientMessage(playerid,0x33AA33AA,"AutoHealth:");
		SendClientMessage(playerid, 0xFFFF00AA,"/carstat - для включения/отключения отображения Статус-бара Повреждения транспорта.");
		SendClientMessage(playerid, 0xFFFF00AA,"/ahinfo - информация о модуле.");
		return 1;
	}

if(strcmp(cmdtext, "/ahinfo", true) == 0) {
		SendClientMessage(playerid, 0x33AA33AA,"AutoHealth построен на основе SimpleGoodies by Mr-Tape");
		SendClientMessage(playerid, 0x33CCFFAA,"Выводит статистику повреждения транспортного средства.");
//		SendClientMessage(playerid, 0x33CCFFAA,"Email/MSN: puddithomas@hotmail.com");
//		SendClientMessage(playerid, 0x33CCFFAA,"Name: Thomas Alexander Pedersen");
		return 1;
	}
if(strcmp(cmdtext, "/carstat", true) == 0){
if(playervehiclebar[playerid] == 0){
playervehiclebar[playerid] = 1;
}else if(playervehiclebar[playerid] == 1){
playervehiclebar[playerid] = 0;
}
return 1;
}
return 0;
}
//--------------------------------------------------------------------------------------------------------------------------------

public VEHICLEHEALTH(){
for(new i=0; i<MAX_PLAYERS; i++){
if (IsPlayerConnected(i))
{
TextDrawHideForPlayer(i,vehiclebar[0]);
TextDrawHideForPlayer(i,vehiclebar[1]);
TextDrawHideForPlayer(i,vehiclebar[13]);

TextDrawHideForPlayer(i,vehiclebar[2]);
TextDrawHideForPlayer(i,vehiclebar[14]);

TextDrawHideForPlayer(i,vehiclebar[3]);
TextDrawHideForPlayer(i,vehiclebar[15]);
TextDrawHideForPlayer(i,vehiclebar[4]);
TextDrawHideForPlayer(i,vehiclebar[16]);
TextDrawHideForPlayer(i,vehiclebar[5]);
TextDrawHideForPlayer(i,vehiclebar[17]);
TextDrawHideForPlayer(i,vehiclebar[6]);
TextDrawHideForPlayer(i,vehiclebar[18]);
TextDrawHideForPlayer(i,vehiclebar[7]);
TextDrawHideForPlayer(i,vehiclebar[19]);
TextDrawHideForPlayer(i,vehiclebar[8]);
TextDrawHideForPlayer(i,vehiclebar[20]);
TextDrawHideForPlayer(i,vehiclebar[9]);
TextDrawHideForPlayer(i,vehiclebar[21]);
TextDrawHideForPlayer(i,vehiclebar[10]);
TextDrawHideForPlayer(i,vehiclebar[22]);
TextDrawHideForPlayer(i,vehiclebar[11]);
TextDrawHideForPlayer(i,vehiclebar[23]);
TextDrawHideForPlayer(i,vehiclebar[12]);
TextDrawHideForPlayer(i,vehiclebar[24]);

	if(IsPlayerInAnyVehicle(i) == 1)	//и если игрок хочет видеть инфу...
		{
		TextDrawShowForPlayer(i,vehiclebar[0]);
		TextDrawShowForPlayer(i,vehiclebar[1]);
		TextDrawShowForPlayer(i,vehiclebar[13]);
		TextDrawShowForPlayer(i,vehiclebar[2]);
		TextDrawShowForPlayer(i,vehiclebar[14]);
//new vehicleid;
//vehicleid = GetPlayerVehicleID(i);
new Float:vhp;
//GetVehicleHealth(vehicleid,vhp);
GetVehicleHealth(GetPlayerVehicleID(i),vhp);

//if(vhp >= 0 && vhp <= 99)
if(vhp >= 250 && vhp <= 347){
TextDrawShowForPlayer(i,vehiclebar[3]);
TextDrawShowForPlayer(i,vehiclebar[15]);
}else if(vhp >= 348 && vhp <= 453){
TextDrawShowForPlayer(i,vehiclebar[4]);
TextDrawShowForPlayer(i,vehiclebar[16]);
}else if(vhp >= 454 && vhp <= 521){
TextDrawShowForPlayer(i,vehiclebar[5]);
TextDrawShowForPlayer(i,vehiclebar[17]);
}else if(vhp >= 522 && vhp <= 589){
TextDrawShowForPlayer(i,vehiclebar[6]);
TextDrawShowForPlayer(i,vehiclebar[18]);
}else if(vhp >= 590 && vhp <= 657){
TextDrawShowForPlayer(i,vehiclebar[7]);
TextDrawShowForPlayer(i,vehiclebar[19]);
}else if(vhp >= 658 && vhp <= 725){
TextDrawShowForPlayer(i,vehiclebar[8]);
TextDrawShowForPlayer(i,vehiclebar[20]);
}else if(vhp >= 726 && vhp <= 793){
TextDrawShowForPlayer(i,vehiclebar[9]);
TextDrawShowForPlayer(i,vehiclebar[21]);
}else if(vhp >= 794 && vhp <= 861){
TextDrawShowForPlayer(i,vehiclebar[10]);
TextDrawShowForPlayer(i,vehiclebar[22]);
}else if(vhp >= 862 && vhp <= 929){
TextDrawShowForPlayer(i,vehiclebar[11]);
TextDrawShowForPlayer(i,vehiclebar[23]);
}else if(vhp >= 930 && vhp <= 1000){
TextDrawShowForPlayer(i,vehiclebar[12]);
TextDrawShowForPlayer(i,vehiclebar[24]);
}
}
}
}
return 1;
}

/*
//--------------------------------------------------------------------------------------------------------------------------------
public ANNOUNCE()
{
for(new i=0; i<MAX_PLAYERS; i++){
if(IsPlayerConnected(i) == 0){
announce[i] = 0;
}else if(announce[i] == 0){
SendClientMessage(i,0xFF9900AA,"AutoHealth: Можно видеть насколько поврежден транспорт. /commands для информации");
announce[i] = 1;
playervehiclebar[i] = 1;
}
}
return 1;
}
*/
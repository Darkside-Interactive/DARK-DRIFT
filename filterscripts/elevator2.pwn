#include <a_samp>
#include <streamer>

#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //максимум игроков на сервере + 1 (если 50 игроков, то пишем 51 !!!)

#if (MAX_PLAYERS > 501)
	#undef MAX_PLAYERS
	#define MAX_PLAYERS 501
#endif

#define ELEVATOR_SPEED22      (3.0)   //скорость лифта
#define DOORS_SPEED22         (1.0)   //скорость дверей
#define ELEVATOR_WAIT_TIME22  (5000)  //время ожидания при транзитной остановке

#define X_DOOR_CLOSED22       (287.9500)
#define X_DOOR_R_OPENED22     (289.6500)
#define X_DOOR_L_OPENED22     (286.2500)
#define GROUND_Z_COORD22      (18.7000)
#define ELEVATOR_OFFSET22     (0.059523)

static FloorNames22[14][] =
{
	"Гараж",
	"1 этаж",
	"2 этаж",
	"3 этаж",
	"4 этаж",
	"5 этаж",
	"6 этаж",
	"7 этаж",
	"8 этаж",
	"9 этаж",
	"10 этаж",
	"11 этаж",
	"12 этаж",
	"13 этаж"
};

static Float:FloorZOffsets22[14] =
{
    0.0,		// 0.0,
    15.0782,	// 15.0782,
    29.1421,   // 15.0782 + 14.0639,
    33.64325,   // 15.0782 + 14.0639 + (4.50115 * 1.0),
    38.1444,   // 15.0782 + 14.0639 + (4.50115 * 2.0),
    42.64555,   // 15.0782 + 14.0639 + (4.50115 * 3.0),
    47.1467,   // 15.0782 + 14.0639 + (4.50115 * 4.0),
    51.64785,   // 15.0782 + 14.0639 + (4.50115 * 5.0),
    56.149,   // 15.0782 + 14.0639 + (4.50115 * 6.0),
    60.65015,   // 15.0782 + 14.0639 + (4.50115 * 7.0),
    65.1513,   // 15.0782 + 14.0639 + (4.50115 * 8.0),
    69.65245,   // 15.0782 + 14.0639 + (4.50115 * 9.0),
    74.1536,   // 15.0782 + 14.0639 + (4.50115 * 10.0),
    78.65475   // 15.0782 + 14.0639 + (4.50115 * 11.0),
};

new Text3D:fantxt;//переменная для хранения 3D-текста с несущесвующим ИД
new dlgcont[MAX_PLAYERS];//контроль ИД диалога
new TimElev22;
new MovObj22;
new Obj_Elevator22, Obj_ElevatorDoors22[2];
new	Obj_FloorDoors22[14][2];
new Text3D:Label_Elevator22, Text3D:Label_Floors22[14], Text3D:Label2_Floors22[14];
new ElevatorState22;
new	ElevatorFloor22;
new ElevatorQueue22[14];
new	FloorRequestedBy22[14];
new ElevatorBoostTimer22;

forward ElevTim22();
forward Elevator_MoveToFloor22(floorid);
forward Elevator_Boost22(floorid);
forward Elevator_TurnToIdle22();
forward RemoveFirstQueueFloor22();
forward Float:GetElevatorZCoordForFloor22(floorid);
forward Float:GetDoorsZCoordForFloor22(floorid);
forward StopMonit22();

public OnFilterScriptInit()
{
	fantxt = Create3DTextLabel(" ",0xFFFFFFAA,0.000,0.000,-4.000,18.0,0,1);//создаём 3D-текст с несущесвующим ИД
	for(new j; j < MAX_PLAYERS; j++)//цикл для всех игроков
	{
		dlgcont[j] = -600;//не существующий ИД диалога
	}

	MovObj22 = 0;
	TimElev22 = SetTimer("ElevTim22",450,1);

	for(new i; i < sizeof(ElevatorQueue22); i ++)
	{
	    ElevatorQueue22[i] = -1;
	    FloorRequestedBy22[i] = 10000;
	}
//объекты и 3D-тексты лифта
	Obj_Elevator22 = CreateObject(18755, 287.9500, -1609.3200, GROUND_Z_COORD22 + ELEVATOR_OFFSET22, 0.000000, 0.000000, 80.000000);
	Obj_ElevatorDoors22[0] = CreateObject(18757, X_DOOR_CLOSED22, -1609.3200, GROUND_Z_COORD22, 0.000000, 0.000000, 80.000000);
	Obj_ElevatorDoors22[1] = CreateObject(18756, X_DOOR_CLOSED22, -1609.3200, GROUND_Z_COORD22, 0.000000, 0.000000, 80.000000);
	Label_Elevator22 = CreateDynamic3DTextLabel("Нажмите {AA3333}''N'' {33AA33}для\nуправления лифтом", 0x33AA33FF, 289.23, -1610.63, 17.96, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0);

	new string[128], Float:z22;//объекты дверей на этажах
	for(new i; i < sizeof(Obj_FloorDoors22); i ++)
	{
	    Obj_FloorDoors22[i][0] = CreateDynamicObject(18757, X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(i), 0.000000, 0.000000, 80.000000, -1, -1, -1, 500);
		Obj_FloorDoors22[i][1] = CreateDynamicObject(18756, X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(i), 0.000000, 0.000000, 80.000000, -1, -1, -1, 500);
		format(string, sizeof(string), "[ %s ]\n{33AA33}Нажмите {AA2222}''N'' {33AA33}для\nвызова лифта", FloorNames22[i]);
		if(i == 0)//3D-тексты на этажах
		{
		    z22 = 17.86;
		}
		if(i == 1)
		{
		    z22 = 17.86 + 15.0782;
		}
		if(i == 2)
		{
		    z22 = 17.86 + 15.0782 + 14.0639;
		}
		if(i > 2)
		{
		    z22 = 17.86 + 15.0782 + 14.0639 + ((i-2) * 4.50115);
		}
		Label_Floors22[i] = CreateDynamic3DTextLabel(string, 0xF0F0F0FF, 290.10, -1612.84, z22, 10.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0);
		format(string, sizeof(string), "[ %s ]", FloorNames22[0]);
		Label2_Floors22[i] = CreateDynamic3DTextLabel(string, 0x33AA33FF, 287.63, -1611.43, z22 + 2.3, 10.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	}
	Floor_OpenDoors22(0);
	Elevator_OpenDoors22();

	return 1;
}

public OnFilterScriptExit()
{
	Delete3DTextLabel(fantxt);//удаляем 3D-текст с несущесвующим ИД
	KillTimer(TimElev22);

	DestroyObject(Obj_Elevator22);
	DestroyObject(Obj_ElevatorDoors22[0]);
	DestroyObject(Obj_ElevatorDoors22[1]);
	DestroyDynamic3DTextLabel(Label_Elevator22);

	for(new i; i < sizeof(Obj_FloorDoors22); i ++)
	{
	    DestroyDynamicObject(Obj_FloorDoors22[i][0]);
		DestroyDynamicObject(Obj_FloorDoors22[i][1]);
		DestroyDynamic3DTextLabel(Label_Floors22[i]);
		DestroyDynamic3DTextLabel(Label2_Floors22[i]);
	}

	return 1;
}

public OnPlayerConnect(playerid)
{
	dlgcont[playerid] = -600;//не существующий ИД диалога
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	dlgcont[playerid] = -600;//не существующий ИД диалога
	return 1;
}

public OnObjectMoved(objectid)
{
    new Float:x, Float:y, Float:z;
	if(objectid == Obj_Elevator22)
	{
		SetTimer("StopMonit22", 1000, 0);//задержка отключения мониторинга лифта

	    KillTimer(ElevatorBoostTimer22);
	    FloorRequestedBy22[ElevatorFloor22] = 10000;//освобождение места игрока в очереди обслуживания

		for(new i; i < sizeof(ElevatorQueue22) - 1; i ++){ElevatorQueue22[i] = ElevatorQueue22[i + 1];}
		ElevatorQueue22[sizeof(ElevatorQueue22) - 1] = -1;//сдвиг очереди обслуживания

	    Elevator_OpenDoors22();
	    Floor_OpenDoors22(ElevatorFloor22);
	    GetObjectPos(Obj_Elevator22, x, y, z);
	    Label_Elevator22 = CreateDynamic3DTextLabel("Нажмите {AA3333}''N'' {33AA33}для\nуправления лифтом", 0x33AA33FF, 289.23, -1610.63, z - 0.9, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0);
	    ElevatorState22 = 1;
	    SetTimer("Elevator_TurnToIdle22", ELEVATOR_WAIT_TIME22, 0);//задержка в очереди обслуживания
	}

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 152)
	{
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//не существующий ИД диалога
			return 1;
		}
		dlgcont[playerid] = -600;//не существующий ИД диалога
		if(response)
		{

			new dop = 0;
			for(new i; i < sizeof(ElevatorQueue22); i ++)
			{
				if(ElevatorQueue22[i] == listitem){dop = 1;}
			}

			new dop22 = 0;
			for(new i; i < sizeof(FloorRequestedBy22); i ++)
			{
				if(FloorRequestedBy22[i] == playerid){dop22 = 1;}
			}

			if(FloorRequestedBy22[listitem] != 10000 || dop == 1)
			{
				SendClientMessage(playerid, 0xAA3333FF, " Выбранный Вами этаж уже находится");
				SendClientMessage(playerid, 0xAA3333FF, " в очереди обслуживания !");
				return 1;
			}
			if(dop22 == 1)
			{
				SendClientMessage(playerid, 0xAA3333FF, " Вы уже выбрали этаж !");
				return 1;
			}
			CallElevator22(playerid, listitem, 1);//вызов, или начало движения лифта
		}
		return 1;
	}

	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerInAnyVehicle(playerid) && (newkeys & KEY_NO))
	{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		if(pos[2] > 12.86 && pos[2] < 101.50 &&
		pos[1] > -1611.70 && pos[1] < -1609.50 && pos[0] > 288.00 && pos[0] < 290.10)
		{
			new string[512];
			for(new i; i < sizeof(ElevatorQueue22); i ++)
			{//если этаж занят местом игрока, то отобразить этот этаж красным цветом
				if(FloorRequestedBy22[i] != 10000){strcat(string, "{FF0000}");}
				strcat(string, FloorNames22[i]);
				strcat(string, "\n");
			}

			ShowPlayerDialog(playerid, 152, DIALOG_STYLE_LIST, "Управление лифтом", string, "OK", "Отмена");
			dlgcont[playerid] = 152;
		}
		if(pos[2] > 12.86 && pos[2] < 101.50 &&
		pos[1] < -1611.70 && pos[1] > -1613.40 && pos[0] > 288.50 && pos[0] < 292.10)
		{
			new i = 13;//определение этажа, откуда поступил вызов
			while(pos[2] < GetDoorsZCoordForFloor22(i) + 3.5 && i > 0){i --;}
			if(i == 0 && pos[2] < GetDoorsZCoordForFloor22(0) + 2.0){i = -1;}
			if(i <= 12)
			{
				CallElevator22(playerid, i + 1, 0);//вызов, или начало движения лифта
			}
		}
	}

	return 1;
}

stock PlaySoundForPlayersInRange(soundid, Float:range, Float:x, Float:y, Float:z)
{//генерация звука открывания/закрывания дверей для игроков возле кабины лифта
    for(new i = 0; i < MAX_PLAYERS; i ++)
    {
        if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, range ,x ,y ,z ))
        {
            PlayerPlaySound(i, soundid, x, y, z);
        }
    }

	return 1;
}

stock Elevator_OpenDoors22()
{//открывание дверей лифта
	new Float:x, Float:y, Float:z;
	GetObjectPos(Obj_ElevatorDoors22[0], x, y, z);
	MoveObject(Obj_ElevatorDoors22[0], X_DOOR_L_OPENED22, -1609.0200, z, DOORS_SPEED22);
	MoveObject(Obj_ElevatorDoors22[1], X_DOOR_R_OPENED22, -1609.6200, z, DOORS_SPEED22);

	return 1;
}

stock Floor_OpenDoors22(floorid)
{//открывание дверей этажа
    MoveDynamicObject(Obj_FloorDoors22[floorid][0], X_DOOR_L_OPENED22 - 0.05, -1609.3100, GetDoorsZCoordForFloor22(floorid), DOORS_SPEED22);
	MoveDynamicObject(Obj_FloorDoors22[floorid][1], X_DOOR_R_OPENED22 - 0.05, -1609.9100, GetDoorsZCoordForFloor22(floorid), DOORS_SPEED22);
	PlaySoundForPlayersInRange(6401, 10.0, X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(floorid) + 5.0);

	return 1;
}

public Elevator_MoveToFloor22(floorid)
{//начало движения лифта
	MovObj22 = 1;//включение мониторинга лифта

	ElevatorState22 = 2;
	ElevatorFloor22 = floorid;
	MoveObject(Obj_Elevator22, 287.9500, -1609.3200, GetElevatorZCoordForFloor22(floorid), 0.25);
    MoveObject(Obj_ElevatorDoors22[0], X_DOOR_CLOSED22, -1609.3200, GetDoorsZCoordForFloor22(floorid), 0.25);
    MoveObject(Obj_ElevatorDoors22[1], X_DOOR_CLOSED22, -1609.3200, GetDoorsZCoordForFloor22(floorid), 0.25);
    DestroyDynamic3DTextLabel(Label_Elevator22);
	ElevatorBoostTimer22 = SetTimerEx("Elevator_Boost22", 1000, 0, "i", floorid);//таймер перехода на увеличенную скорость

	return 1;
}

public Elevator_Boost22(floorid)
{//продолжение движения лифта с увеличенной скоростью
	StopObject(Obj_Elevator22);
	StopObject(Obj_ElevatorDoors22[0]);
	StopObject(Obj_ElevatorDoors22[1]);
	MoveObject(Obj_Elevator22, 287.9500, -1609.3200, GetElevatorZCoordForFloor22(floorid), ELEVATOR_SPEED22);
    MoveObject(Obj_ElevatorDoors22[0], X_DOOR_CLOSED22, -1609.3200, GetDoorsZCoordForFloor22(floorid), ELEVATOR_SPEED22);
    MoveObject(Obj_ElevatorDoors22[1], X_DOOR_CLOSED22, -1609.3200, GetDoorsZCoordForFloor22(floorid), ELEVATOR_SPEED22);

	return 1;
}

public Elevator_TurnToIdle22()
{//очередь обслуживания
	ElevatorState22 = 0;
	ReadNextFloorInQueue22();//закрывание дверей лифта и этажа перед началом движения

	return 1;
}

public StopMonit22()
{//включение мониторинга лифта
	MovObj22 = 0;

	return 1;
}

stock ReadNextFloorInQueue22()
{//закрывание дверей лифта и этажа перед началом движения
	if(ElevatorState22 != 0 || ElevatorQueue22[0] == -1){return 1;}//если очередь обслуживания пустая, то завершить функцию
    if(ElevatorState22 == 2){return 1;}//если лифт в движении, то завершить функцию
	ElevatorState22 = 1;//присвоить лифту статус "занят"
    new Float:x, Float:y, Float:z;
	GetObjectPos(Obj_ElevatorDoors22[0], x, y, z);
	MoveObject(Obj_ElevatorDoors22[0], X_DOOR_CLOSED22, -1609.3200, z, DOORS_SPEED22);
	MoveObject(Obj_ElevatorDoors22[1], X_DOOR_CLOSED22, -1609.3200, z, DOORS_SPEED22);
    MoveDynamicObject(Obj_FloorDoors22[ElevatorFloor22][0], X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(ElevatorFloor22), DOORS_SPEED22);
	MoveDynamicObject(Obj_FloorDoors22[ElevatorFloor22][1], X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(ElevatorFloor22), DOORS_SPEED22);
	PlaySoundForPlayersInRange(6401, 10.0, X_DOOR_CLOSED22, -1609.6100, GetDoorsZCoordForFloor22(ElevatorFloor22) + 5.0);
	new Float:dop22, string[128], dop;//вычисление задержки перед началом движения лифта
	dop22 = ( 1 / DOORS_SPEED22 ) * 2000;
	format(string, sizeof(string), "%f", dop22);
	dop = strval(string);
	SetTimerEx("Elevator_MoveToFloor22", dop, 0, "i", ElevatorQueue22[0]);//таймер задержки начала движения лифта

	return 1;
}

stock CallElevator22(playerid, floorid, elevator)
{//вызов, или начало движения лифта
	new dop = 0;
	for(new i; i < sizeof(ElevatorQueue22); i ++)
	{
	    if(ElevatorQueue22[i] == floorid){dop = 1;}
	}

	if(FloorRequestedBy22[floorid] != 10000 || dop == 1)
	{
		if(elevator == 1){return 1;}
		SendClientMessage(playerid, 0xAA3333FF, " Ваш вызов уже находится");
		SendClientMessage(playerid, 0xAA3333FF, " в очереди обслуживания !");
		return 1;
	}
	if(elevator == 0){SendClientMessage(playerid, 0x33AA33FF, " Лифт вызван !");}
	FloorRequestedBy22[floorid] = playerid;//занятие места игрока в очереди обслуживания
	new slot = -1;//запись вызова, или начала движения лифта в очередь обслуживания
	new i = 0;
	while(i < sizeof(ElevatorQueue22))
	{
	    if(ElevatorQueue22[i] == -1)
	    {
	        slot = i;
	        break;
	    }
		i ++;
	}
	if(slot != -1)
	{
	    ElevatorQueue22[slot] = floorid;
	    if(ElevatorState22 == 0){ReadNextFloorInQueue22();}//если лифт свободен, то перейти к закрыванию дверей
	}

	return 1;
}

stock Float:GetElevatorZCoordForFloor22(floorid)
{//вычисление координат лифта
    return (GROUND_Z_COORD22 + FloorZOffsets22[floorid] + ELEVATOR_OFFSET22);
}

stock Float:GetDoorsZCoordForFloor22(floorid)
{//вычисление координат дверей
	return (GROUND_Z_COORD22 + FloorZOffsets22[floorid]);
}

public ElevTim22()//таймер мониторинга лифта
{
	if(MovObj22 == 1)//разрешение мониторинга лифта
	{
		new dop, string[128];
		new Float:X, Float:Y, Float:Z;
		GetObjectPos(Obj_Elevator22, X, Y, Z);
		if(15.96 < Z < 25.40){dop = 0;}//нахождение этажа, где находится кабина лифта
		if(25.40 < Z < 39.97){dop = 1;}
		if(39.97 < Z < 49.25){dop = 2;}
		if(49.25 < Z < 53.75){dop = 3;}
		if(53.75 < Z < 58.25){dop = 4;}
		if(58.25 < Z < 62.75){dop = 5;}
		if(62.75 < Z < 67.26){dop = 6;}
		if(67.26 < Z < 71.76){dop = 7;}
		if(71.76 < Z < 76.26){dop = 8;}
		if(76.26 < Z < 80.76){dop = 9;}
		if(80.76 < Z < 85.26){dop = 10;}
		if(85.26 < Z < 89.76){dop = 11;}
		if(89.76 < Z < 94.26){dop = 12;}
		if(94.26 < Z < 98.76){dop = 13;}

		for(new i; i < sizeof(Obj_FloorDoors22); i ++)
		{
			format(string, sizeof(string), "[ %s ]", FloorNames22[dop]);//создание 3D-текстов мониторинга (в зависимости от этажа)
			UpdateDynamic3DTextLabelText(Label2_Floors22[i], 0x22AA22FF, string);
		}
	}
	return 1;
}


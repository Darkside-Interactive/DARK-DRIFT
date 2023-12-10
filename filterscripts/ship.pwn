/*
	
	������� �������� ���������
	The Flying Dutchman`s ship v1.2 by Fleynaro
	
	create 01.11.2014
	update 22.11.2015
*/

#include <a_samp>

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define sign(%0) (%0 / floatabs(%0))

const 
	MAX_SHIPS 		= 5,	 		//���� ���-�� �������� �� �������.
	UPDATE			= 30,			//���-�� ���������� � �������(FPS)
	bool: ADMIN 	= false,		//�������� �������� ������ ��� ������� - true.
	Float: ANGLEY 	= 1.1,			//���� Y �������� ������� �� ����.
	Float: ANGLEX 	= 0.7,			//���� X �������� ������� �� ����.
	Float: ANGLEROT	= 8.0,			//���� ������� ��� ��������.
	HIT_HEALTH		= 1,			//���� ������� ��� �������� � ���� �� ������. ����� � ������� 1000xp
	RANDOM_ID 		= 876;			//����� ����� ��� ��������. �������� ��� ����.

	
//����������. ���� ������ ����� http://wiki.sa-mp.com/wiki/Keys � ������� value
const
	RIGHT 	= 16384,				//������� ������� 		Num 4
	LEFT 	= 8192,					//������� ������		Num 6
	FORWARD	= 131072,				//������				H
	BACK	= 262144,				//�����					N
	VERT	= 65536;				//�� ���������			Y

new Float: ANGLE_X		= 0.05,
	Float: ANGLE_Y		= 0.1,
	Float: ANGLE_ZX		= 0.15,
	Float: ANGLES		= 0.007,	//�������
	Float: MAXV_ANGLE 	= 7.0,		//��� ������� �/� ����� ������� ������������� ����������
	Float: A			= 0.7, 		//���������
	WEAPON				= -2;		//ID ������, ������� ����� ��������� �������. -1 - �� ��������� �������, -2 - ��� ������
	
new
	DIALOG_ASS_PANEL[]	=	"�������\n�� � ����\n�� ���� � ����\n������� ���������\n������� �������\n���������� ��������\n��������� ������/��� �� ������",
	DIALOG_ASS[]		=	"������� �������\n������ ��������\n���������� � �������";

enum shipInfo {
	obj,
	camera,
	captainid,
	timer,
	health,
	temp,
	Float: speedMax,
	Float: speedX, 
	Float: speedY, 
	Float: speedZ,
	Float: speed, 
	Float: angle, 
	Float: angleSpeed,
	Float: angleY,
	Float: angleX,
	Float: cos,
	Float: sin,
	bool: keyup,
	bool: keydown,
	bool: keyright,
	bool: keyleft,
	bool: ckey,
	bool: work
};

new ships[MAX_SHIPS][shipInfo], shipsCount;
new shipsID[MAX_PLAYERS], shipsTemp[MAX_PLAYERS];

forward Timer(id);

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" The Flying Dutchman`s ship v1.2 by Fleynaro is loaded.");
	print("--------------------------------------\n");
	
	for ( new i; i < MAX_PLAYERS; i ++ ) {
		shipsID[i] = -1;
	}
	
	ANGLE_X /= UPDATE / 30.0;
	ANGLE_Y /= UPDATE / 30.0;
	ANGLE_ZX /= UPDATE / 30.0;
	ANGLES /= UPDATE / 30.0;
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if ( strcmp("/ass", cmdtext, true, 10) == 0 )
	{
		if ( (IsPlayerAdmin(playerid) || !ADMIN ) )
		{
			ShowPlayerDialog(playerid, 0 + RANDOM_ID, DIALOG_STYLE_LIST, "ASS ����", DIALOG_ASS, "�������", "�����");
		} else SendClientMessage(playerid, 0xffff00ff, "[ASS] ��� ����� rcon �������.");
		return 1;
	}
	
	if ( strcmp("/asspanel", cmdtext, true, 10) == 0 )
	{
		if ( shipsID[playerid] != -1 )
		{
			shipsTemp[playerid] = shipsID[playerid];
			ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
		} else SendClientMessage(playerid, 0xffff00ff, "[ASS] � ��� ��� �������.");
		return 1;
	}
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch ( dialogid )
	{
		case 0 + RANDOM_ID:
		{
			if ( response )
			{
				switch ( listitem )
				{
					case 0: 
					{
						for ( new i; i < MAX_SHIPS; i ++ )
						{
							if ( !ships[i][work] )
							{
								new Float: x, Float: y, Float: z, Float: Angle, anim = GetPlayerAnimationIndex(playerid);
								GetPlayerPos(playerid, x, y, z);
								GetPlayerFacingAngle(playerid, Angle);
								
								if ( !((anim >= 1538 && anim <= 1542) || anim == 1544 || anim == 1250) ) {
									z += 35;
								} else {
									z += 18;
								}
								SetPlayerPos(playerid, x + 32, y, z - 2.0);
								
								ships[i][obj] = CreateObject(8493, x, y, z, ANGLEX, ANGLEY, Angle + 180);
								ships[i][captainid] = playerid;
								ships[i][timer] = SetTimerEx("Timer", 1000 / UPDATE, true, "i", shipsCount);
								ships[i][work] = true;
								ships[i][speedMax] = 10;
								ships[i][health] = 1000;
								shipsID[playerid] = i;
								
								return shipsCount ++;
							}
						}
						
						SendClientMessage(playerid, 0xffff00ff, "[ASS] ��������� ����� ��������� ��������.");
					}
					
					case 1:
					{
						new dialog[MAX_SHIPS * 20 + 1], str[20];
						
						for ( new i; i < MAX_SHIPS; i ++ )
						{
							if ( ships[i][work] ) format(str, 20, "������� %i\n", i); else format(str, 20, "�����\n", i);
							strcat(dialog, str);
						}
						
						format(str, 20, "������� (%i/%i)", shipsCount, MAX_SHIPS);
						ShowPlayerDialog(playerid, 1 + RANDOM_ID, DIALOG_STYLE_LIST, str, dialog, "�������", "�����");
					}
					
					case 2: ShowPlayerDialog(playerid, 0 + RANDOM_ID, DIALOG_STYLE_MSGBOX, "����������", "�����/��������: Marsel\n������: v1.2 (22.11.15)\n��������:\n\n��������� ������� �������� �� ������.", "�����", "");
				}
			}
		}
		
		case 1 + RANDOM_ID:
		{
			if ( response )
			{
				if ( !ships[listitem][work] ) return 1;
				shipsTemp[playerid] = listitem;
				ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
			} else ShowPlayerDialog(playerid, 0 + RANDOM_ID, DIALOG_STYLE_LIST, "ASS ����", DIALOG_ASS, "�������", "�����");
		}
		
		case 2 + RANDOM_ID:
		{
			if ( response )
			{
				new id = shipsTemp[playerid];
				
				switch ( listitem )
				{
					case 0:
					{
						DestroyObject(ships[id][obj]);
						KillTimer(ships[id][timer]);
						ships[id][work] = false;
						shipsCount --;
						SendClientMessage(playerid, 0xffffffff, "[ASS] ������ ������� ������.");
					}
					
					case 1:
					{
						ShowPlayerDialog(playerid, 5 + RANDOM_ID, DIALOG_STYLE_LIST, "�� � �������", "�� ������\n�� �����\n�� ��������", "�������", "�����");
					}
					
					case 2:
					{
						new Float:x, Float:y, Float:z;
						GetObjectPos(ships[id][obj], x, y, z);
								
						for ( new i; i < MAX_PLAYERS; i ++ )
						{
							if ( IsPlayerConnected(i) && playerid != i )
							{
								SetPlayerPos(i, x + 32 * ships[id][cos], y + 32 * ships[id][sin], z + 1.0);
							}
						}
						
						SendClientMessage(playerid, 0xffffffff, "[ASS] ��� ��������������� �� ������ �������.");
					}
					
					case 3:
					{
						ShowPlayerDialog(playerid, 3 + RANDOM_ID, DIALOG_STYLE_INPUT, "������� ���������", "������� ID ������, �������� ������ ������� ��������� ������� �������:", "�������", "�����");
					}
					
					case 4:
					{
						ShowPlayerDialog(playerid, 4 + RANDOM_ID, DIALOG_STYLE_INPUT, "������� �������", "������� ������ � ������, �� ������� ������ ������� �������. ��������: 30", "�������", "�����");
					}
					
					case 5:
					{
						ShowPlayerDialog(playerid, 6 + RANDOM_ID, DIALOG_STYLE_INPUT, "��������� ��������", "������� �������� ������� � �/���. �� ������� ����� 10 �/c.", "����������", "�����");
					}
					
					case 6:
					{
						if ( ships[id][camera] == 0 ) {
							new Float: x, Float: y, Float: z;
							GetObjectPos(ships[id][obj], x, y, z);
							ships[id][camera] = CreateObject(19300, x + 65.0 * ships[id][cos], y + 65 * ships[id][sin], z + 18.0, 0.0, 0.0, 0.0);
							AttachCameraToObject(playerid, ships[id][camera]);
						} else {
							SetCameraBehindPlayer(playerid);
							DestroyObject(ships[id][camera]);
							ships[id][camera] = 0;
						}
					}
				}
			}
		}
		
		case 3 + RANDOM_ID:
		{
			if ( response )
			{
				new idplayer = strval(inputtext), id = shipsTemp[playerid];
				
				if ( !IsPlayerConnected(idplayer) ) return SendClientMessage(playerid, 0xffff00ff, "[ASS] ������� ������ ��� �� �������.");
				
				shipsID[idplayer] = id;
				ships[id][captainid] = idplayer;
				SendClientMessage(idplayer, 0xffffffff, "[ASS] ��� ������� ��������� ����� �������");
				new Float:x, Float:y, Float:z;
				GetObjectPos(ships[id][obj], x, y, z);
				SetPlayerPos(idplayer, x + 32 * ships[id][cos], y + 32 * ships[id][sin], z + 1.0);
				
				SendClientMessage(playerid, 0xffffffff, "[ASS] �� ������� ��� ��������� ����� �������.");
				ShowPlayerDialog(playerid, 0 + RANDOM_ID, DIALOG_STYLE_LIST, "ASS ����", DIALOG_ASS, "�������", "�����");
			} else ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
		}
		
		case 4 + RANDOM_ID:
		{
			if ( response )
			{
				new id = shipsTemp[playerid];
				
				new Float:x, Float:y, Float:z;
				GetObjectPos(ships[id][obj], x, y, z);
				SetObjectPos(ships[id][obj], x, y, floatstr(inputtext));
				SendClientMessage(playerid, 0xffffffff, "[ASS] �� ������� ������� �� ��������� ���� ������.");
			} else ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
		}
		
		case 5 + RANDOM_ID:
		{
			if ( response )
			{
				new Float: x, Float: y, Float: z, id = shipsTemp[playerid];
				GetObjectPos(ships[id][obj], x, y, z);
						
				switch ( listitem )
				{
					case 0:
					{
						SetPlayerPos(playerid, x + 32 * ships[id][cos], y + 32 * ships[id][sin], z - 3.0);
						SendClientMessage(playerid, 0xffffffff, "[ASS] �� ��������������� �� ������.");
					}
					
					case 1:
					{
						SetPlayerPos(playerid, x + 1 * ships[id][cos], y + 1 * ships[id][sin], z + 10.0);
						SendClientMessage(playerid, 0xffffffff, "[ASS] �� ��������������� �� �����.");
					}
					
					case 2:
					{
						SetPlayerPos(playerid, x - 16 * ships[id][cos], y - 16 * ships[id][sin], z - 5.0);
						SendClientMessage(playerid, 0xffffffff, "[ASS] �� ��������������� �� ��������.");
					}
				}
			} else ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
		}
		
		case 6 + RANDOM_ID:
		{
			if ( response )
			{
				new Float: speed_ = floatstr(inputtext);
				
				if ( 0 < speed_ < 500 ) {
					new id = shipsTemp[playerid];
					ships[id][speedMax] = speed_;
					SendClientMessage(playerid, 0xffffffff, "[ASS] �������� �����������.");
				} else {
					SendClientMessage(playerid, 0xffff00ff, "[ASS] �������� ������ ���� � �������� 1 - 500 �/�.");
				}
			} else ShowPlayerDialog(playerid, 2 + RANDOM_ID, DIALOG_STYLE_LIST, "���������� ��������", DIALOG_ASS_PANEL, "�������", "�����");
		}
		
	}
	
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	
	if ( WEAPON != -1 ) {
		if ( hittype == 3 && (WEAPON == -2 || weaponid == WEAPON) )
		{
			for ( new i; i < MAX_SHIPS; i ++ )
			{
				if ( ships[i][work] && ships[i][health] != -1 && ships[i][obj] == hitid )
				{
					ships[i][health] -= HIT_HEALTH;
					
					if ( ships[i][health] < 1 )
					{
						ships[i][health] = -1;
						ships[i][speedX] = 0.1;
						ships[i][speedY] = 0.05;
						ships[i][speedZ] = 2;
					}
				}
			}
		}
	}
	
    return 1;
}

public Timer(id)
{
	new Float:x, Float:y, Float:z, Float: rx, Float: ry, Float: rz;
	GetObjectPos(ships[id][obj], x, y, z), GetObjectRot(ships[id][obj], rx, ry, rz);
	
	if ( ships[id][health] == -1 )
	{
		ships[id][speedX] *= 0.99;
		ships[id][speedY] *= 0.99;
		ships[id][speedZ] *= 0.9999;
		MoveObject(ships[id][obj], x, y, z - ships[id][speedZ], ships[id][speedZ]);
		
		rx -= ships[id][speedX];
		ry -= ships[id][speedY];
		SetObjectRot(ships[id][obj], rx, ry, rz);
		
		if ( ships[id][speedZ] < 0.001 )
		{
			KillTimer(ships[id][timer]);
		}
		return 1;
	}
	
	new Float: a = ships[id][speedMax] / UPDATE * A;
	
	if ( ships[id][keyup] )
	{
		if ( ships[id][speed] <= ships[id][speedMax] ) {
			ships[id][speedX] += a * floatcos(ships[id][angle], degrees);
			ships[id][speedY] += a * floatsin(ships[id][angle], degrees);
		}
		
		if ( rx - ANGLE_X >= -ANGLEROT / 3 ) {
			rx -= ANGLE_X;
		} else {
			rx = -ANGLEROT / 3;
		}
	} else if ( ships[id][keydown] )
	{
		if ( ships[id][speed] >= -ships[id][speedMax] ) {
			ships[id][speedX] -= a * floatcos(ships[id][angle], degrees);
			ships[id][speedY] -= a * floatsin(ships[id][angle], degrees);
		}
		
		if ( rx + ANGLE_X <= ANGLEROT / 3 ) {
			rx += ANGLE_X;
		} else {
			rx = ANGLEROT / 3;
		}
	} else if ( !ships[id][ckey] )  {
		ships[id][angleX] += -rx * 0.0015;
	}
	
    if ( ships[id][keyleft] ) 
	{
		if ( ships[id][ckey] ) 
		{
			new Float: x_ = -a * floatcos(ships[id][angle], degrees), Float: y_ = -a * floatsin(ships[id][angle], degrees);
			ships[id][speedX] += x_;
			ships[id][speedY] += y_;
			ships[id][speedZ] -= floatsqroot(x_ * x_ + y_ * y_) / 2;
			
			if ( rx - ANGLE_ZX >= -23 ) {
				rx -= ANGLE_ZX;
			} else {
				rx = -23;
			}
		} else {
			ships[id][angleSpeed] += ANGLES;
			
			if ( ry - ANGLE_Y >= -ANGLEROT ) {
				ry -= ANGLE_Y;
			} else {
				ry = -ANGLEROT;
			}
		}
	} else if ( ships[id][keyright] )
	{
		if ( ships[id][ckey] ) 
		{
			new Float: x_ = -a * floatcos(ships[id][angle], degrees), Float: y_ = -a * floatsin(ships[id][angle], degrees);
			ships[id][speedX] += x_;
			ships[id][speedY] += y_;
			ships[id][speedZ] += floatsqroot(x_ * x_ + y_ * y_) / 2;
			
			if ( rx + ANGLE_ZX <= 23 ) {
				rx += ANGLE_ZX;
			} else {
				rx = 23;
			}
		} else {
			ships[id][angleSpeed] -= ANGLES;
			
			if ( ry + ANGLE_Y <= ANGLEROT ) {
				ry += ANGLE_Y;
			} else {
				ry = ANGLEROT;
			}
		}
	} else {
		ships[id][angleY] += -ry * 0.0015;
	}
	
	if ( ships[id][speed] < MAXV_ANGLE ) {
		ships[id][angle] += ships[id][speed] / MAXV_ANGLE * ships[id][angleSpeed];
	} else {
		ships[id][angle] += ships[id][angleSpeed];
	}
	
	SetObjectRot(ships[id][obj], (rx + ships[id][angleX]) * (floatabs(rx) > ANGLEX ? 0.985 : 1.0), (ry + ships[id][angleY]) * (floatabs(ry) > ANGLEY ? 0.985 : 1.0), 90.0 + ships[id][angle]);
	ships[id][cos] = floatcos(ships[id][angle], degrees);
	ships[id][sin] = floatsin(ships[id][angle], degrees);
	
	ships[id][speedX] *= 0.985;
	ships[id][speedY] *= 0.985;
	ships[id][speedZ] *= 0.985;
	ships[id][angleSpeed] *= 0.985;
	
	ships[id][speed] = floatsqroot(ships[id][speedX] * ships[id][speedX] + ships[id][speedY] * ships[id][speedY] + ships[id][speedZ] * ships[id][speedZ]);
	
	MoveObject(ships[id][obj], x + ships[id][speedX], y + ships[id][speedY], z + ships[id][speedZ], ships[id][speed]);
	
	if ( ships[id][camera] != 0 ) {
		MoveObject(ships[id][camera], x + 65.0 * ships[id][cos] + ships[id][speedX], y + 65 * ships[id][sin] + ships[id][speedY], z + 18.0 + ships[id][speedZ], ships[id][speed]);
	}
	
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new id = shipsID[playerid];
	
	if ( PRESSED(FORWARD) ) ships[id][keyup] = true;
	if ( RELEASED(FORWARD) ) ships[id][keyup] = false;
	if ( PRESSED(BACK) ) ships[id][keydown] = true;
	if ( RELEASED(BACK) ) ships[id][keydown] = false;
	if ( PRESSED(RIGHT) ) ships[id][keyright] = true;
	if ( RELEASED(RIGHT) ) ships[id][keyright] = false;
	if ( PRESSED(LEFT) ) ships[id][keyleft] = true;
	if ( RELEASED(LEFT) ) ships[id][keyleft] = false;
	if ( PRESSED(VERT) ) ships[id][ckey] = true;
	if ( RELEASED(VERT) ) ships[id][ckey] = false;
	
	return 1;
}

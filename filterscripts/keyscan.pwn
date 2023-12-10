//==============================================================================
//                            �������� ���������
//==============================================================================

#define MOD55INS 1 //��������� ������ /ipban � /ipunban:
//                 //MOD55INS 1 - ������� �������� ������� 9 � 10 lvl.
//                 //MOD55INS 2 - ������� �������� ������ ������ (�������) 10 lvl.

//   �������� !!! ����� ��������� �������� ����������� ��������������� !!!
//==============================================================================
#if (MOD55INS < 1)
	#undef MOD55INS
	#define MOD55INS 1
#endif
#if (MOD55INS > 2)
	#undef MOD55INS
	#define MOD55INS 2
#endif

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 141 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

#if (MAX_PLAYERS > 501)
	#undef MAX_PLAYERS
	#define MAX_PLAYERS 501
#endif

#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00FF

forward DatCor();//��������� ����
forward TimCor();//��������� �������
forward ReadCorTime();//������ ����� cortime.ini
forward dopfunction(per);//������� �������� ������ ��� ������ ��������� �������
forward ini_GetKey( line[] );
forward ini_GetValue( line[] );
forward FPing2(playerid, para1, para2);
forward FPing3(playerid, para1, para2);
forward Prov1(playerid, para1, para2);
forward Prov2(playerid, para1, para2);
forward Prov3(playerid, para1, para2);
forward Prov4(playerid, para1, para2);
forward Prov5(playerid, para1, para2);
forward Prov6(playerid, para1, para2);
forward ReadData();//������ ����� keyscan.ini
forward SaveData();//������ ����� keyscan.ini
forward EndPlCRTp(playerid);

forward SendAdminMessage(para1, para2, color, string[]);

new ipper[MAX_PLAYERS][4][32];//������ ��� ������ /ipban � /ipunban
new timecor[8];//���������� ��������� ������� 2
new CorTime[5];//���������� ��������� ������� 1
new spectate[MAX_PLAYERS];
new mnhp;
new mnon;
new obj[4];
new razresh;
new Float:plarm, Float:plhp;
new pping1, pping2, pping3;
new pler1, pler2;
new plgl;
new plgldist;
new plloc[MAX_PLAYERS];
new pllocdist[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("         Filterscript Keyscan          ");
	print("--------------------------------------\n");
	ReadCorTime();//������ ��������� �������

	obj[0] = CreateObject(10826, 0.00, 0.00, 19500.00,   0.00, 0.00, 0.00);
	obj[1] = CreateObject(10826, 1543.85, -1353.98, 14500.00,   0.00, 0.00, 0.00);
	obj[2] = CreateObject(10826, -1981.03, 443.81, 9500.00,   0.00, 0.00, 0.00);
	obj[3] = CreateObject(10826, 2169.05, 1676.22, 4500.00,   0.00, 0.00, 0.00);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPVarInt(i, "CComAc1", 0);
		SetPVarInt(i, "PlCRTp", 0);
		spectate[i] = 600;//��������� ���� ������� (� �������) ������� ��������
		plloc[i] = 0;//��������� ���� ������� (� �������) ������� ����-��������
	}
	ReadData();//������ ����� keyscan.ini
	mnhp = 0;
	mnon = 0;
	razresh = 0;
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			DeletePVar(i, "CComAc1");
			DeletePVar(i, "PlCRTp");
		}
	}
	DestroyObject(obj[0]);
	DestroyObject(obj[1]);
	DestroyObject(obj[2]);
	DestroyObject(obj[3]);
	razresh = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "CComAc1", 0);
	SetPVarInt(playerid, "PlCRTp", 0);
	spectate[playerid] = 600;//��������� ������ (������) ������� ��������
	plloc[playerid] = 0;//��������� ������ (������) ������� ����-��������
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[256];
    new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
	new Float:X, Float:Y, Float:Z;
	new Float:Xc, Float:Yc, Float:Zc, Float:ras1, Float:ras2;
	GetPlayerPos(playerid, X, Y, Z);
	for(new i = 0; i < MAX_PLAYERS; i++)//��������� �� keyscan ������, �� ������� �������
	{
		if(spectate[i] == playerid)
		{
			spectate[i] = 600;//��������� �� ������ ������, �� ������� ������ �����
			SendClientMessage(i, COLOR_RED, " �����, �� ����������� �������� �� �������,");
			SendClientMessage(i, COLOR_RED, " ����� � �������, � ��� �������� �� ��������.");
			GetPlayerName(i, sendername, sizeof(sendername));
			format(string, sizeof(string), "* ����� %s ��� �������� �� �������� �� ����� ����������� �� ������� ������ %s", giveplayer, sendername);
			print(string);
		}
		GetPlayerPos(i, Xc, Yc, Zc);
		if(IsPlayerConnected(i) && reason == 0 && playerid != i && (-1000<(X-Xc)<1000 && -1000<(Y-Yc)<1000 && -1000<(Z-Zc)<1000))
		{
			ras1 = floatsqroot(floatmul((X-Xc), (X-Xc)) + floatmul((Y-Yc), (Y-Yc)));
			ras2 = floatsqroot(floatmul(ras1, ras1) + floatmul((Z-Zc), (Z-Zc)));
			format(string, sizeof(string), "%f", ras2);
			new dop1;
			dop1 = strval(string);
			GetPlayerName(i, sendername, sizeof(sendername));
			format(string, sizeof(string), "* ����-������� - ����� ''�������'': %s [%d] , ����� �����: %s [%d] , ����������: %d", giveplayer, playerid, sendername, i, dop1);
			if(plgl == 1 && plgldist >= dop1) { print(string); }
			SendAdminMessage(1, dop1, 0xFF6347FF, string);
		}
	}
	DeletePVar(playerid, "CComAc1");
	DeletePVar(playerid, "PlCRTp");
	spectate[playerid] = 600;//��������� ������ (������) ������� ��������
	plloc[playerid] = 0;//��������� ������ (������) ������� ����-��������
	return 1;
}

public SendAdminMessage(para1, para2, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(GetPVarInt(i, "AdmLvl") >= 1 || IsPlayerAdmin(i))
		    {
				if(para1 == 0)
				{
					SendClientMessage(i, color, string);
				}
				if(para1 == 1 && plloc[i] == 1 && pllocdist[i] >= para2)
				{
					SendClientMessage(i, color, string);
				}
			}
		}
	}
	return 1;
}

stock ini_GetKey( line[] )
{
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind( line , "=" , true ) == -1 ) return keyRes;
    strmid( keyRes , line , 0 , strfind( line , "=" , true ) , sizeof( keyRes) );
    return keyRes;
}

stock ini_GetValue( line[] )
{
	new valRes[256];
	valRes[0]=0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes , line , strfind( line , "=" , true )+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[30];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnPlayerText(playerid, text[])
{
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), " �����: %s [%d] (���) - %s", giveplayer, playerid, text);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "CComAc1", GetPVarInt(playerid, "CComAc1") + 1);
	new idx;
	idx = 0;
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	cmd = strtok(cmdtext, idx);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			format(string, sizeof(string), " �����: %s [%d] (�������) - %s", giveplayer, playerid, cmdtext);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	if(strcmp(cmd, "/a2help", true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid,COLOR_GREY," -------------------------- �������������� ������� -------------------------- ");
			if (GetPVarInt(playerid, "AdmLvl") >= 1)
			{
				SendClientMessage(playerid, COLOR_GREY, " 1 �����: /a2help, /lctp[1-3], /grtp[1-4], /allonline [0- ���], /cc,");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- ���] [0- ����., 1- ���., 2- ����������� ���������]");
				SendClientMessage(playerid, COLOR_GREY, "     ( ������������� [��������� �����������(10-1000)] )");
			}
			if (GetPVarInt(playerid, "AdmLvl") >= 2)
			{
				SendClientMessage(playerid, COLOR_GREY, " 2 �����: /keyon [�� ������], /keyoff,");
				SendClientMessage(playerid, COLOR_GREY, "     /tshp [�� ������] ( ������������� [��������� �����(10-1000)]");
			}
#if (MOD55INS == 1)
			if (GetPVarInt(playerid, "AdmLvl") >= 9)
			{
				SendClientMessage(playerid, COLOR_GREY, " 9 �����: /ipban [IP-�����], /ipunban [IP-�����]");
			}
			if (GetPVarInt(playerid, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_GREY, " 10 �����: /allonline [0- ���, 1- ������-���], /scan [0- ����., 1- ���.],");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- ���, 1- ������-���] [0- ����., 1- ���., 2- ����������� ���������]");
				SendClientMessage(playerid, COLOR_GREY, "     ( ������������� [��������� �����������(10-1000)] )");
			}
#endif
#if (MOD55INS == 2)
			if (GetPVarInt(playerid, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_GREY, " 10 �����: /allonline [0- ���, 1- ������-���], /scan [0- ����., 1- ���.],");
				SendClientMessage(playerid, COLOR_GREY, "     /ipban [IP-�����], /ipunban [IP-�����]");
				SendClientMessage(playerid, COLOR_GREY, "     /plcmon [0- ���, 1- ������-���] [0- ����., 1- ���., 2- ����������� ���������]");
				SendClientMessage(playerid, COLOR_GREY, "     ( ������������� [��������� �����������(10-1000)] )");
			}
#endif
			SendClientMessage(playerid,COLOR_GREY," ---------------------------------------------------------------------------------------------- ");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	
///*�������������
	if(strcmp(cmd, "/helptp", true) == 0)
	{
		SendClientMessage(playerid,COLOR_RED," -------------------------- �������������� ��������� -------------------------- ");
		SendClientMessage(playerid, COLOR_GREEN, "������: /clubdark /topband");
		SendClientMessage(playerid, COLOR_GREEN, "������: /spawnls /spawnsf /spawnlv");
		SendClientMessage(playerid, COLOR_GREEN, "�� ����: /dm13 /dm14");
		SendClientMessage(playerid, COLOR_GREEN, "�����������: /bdsm /samolet /parksf /bardel ");
		SendClientMessage(playerid,COLOR_RED," ---------------------------------------------------------------------------------------------- ");
		return 1;
	}
///*�������
	if (strcmp(cmd,"/samolet",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1.5786,25.1747,1199.5938+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ��������� � �������");
		return 1;
	}
///*�������
///*����
	if (strcmp(cmd,"/bdsm",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 6);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 345.5856,306.4812,999.1484+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ��������� � ������� ����");
		return 1;
	}
///*����
///*������
	if (strcmp(cmd,"/parksf",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2201.8979,1619.7367,4.5558+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ��������� � ���� ������ ��� �����");
		return 1;
	}
///*���� ��
///*dm14
	if (strcmp(cmd,"/dm14",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 2);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2546.0718,-1297.4779,1044.1250+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ��������� �� �� ���� 14");
		return 1;
	}
///*dm14
///*dm13
	if (strcmp(cmd,"/dm13",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 18);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1288.5935,-14.4722,1001.0156+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ��������� �� �� ���� 13");
		return 1;
	}
///*dm13
///*topband
	if (strcmp(cmd,"/topband",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1247.9266,-1636.5559,27.3750+1);
		SendClientMessage(playerid, COLOR_GREEN, " ��� ����� �������");
		return 1;
	}
///*topband
///*spawnsf
	if (strcmp(cmd,"/spawnsf",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, -2914.8237,464.1307,4.9141+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� ����� ��");
		return 1;
	}
///*spawnsf
///*spawnlv
	if (strcmp(cmd,"/spawnlv",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1084.9733,1086.3578,10.8359+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� ����� ��");
		return 1;
	}
///*spawnlv
///*spawnls
	if (strcmp(cmd,"/spawnls",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1266.5657,-1648.5308,13.5469+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� ����� ��");
		return 1;
	}
///*spawnls
///*leimanclub
	if (strcmp(cmd,"/clubdark",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2467.8826,-631.9252,8.2979+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� � Club Dark");
		return 1;
	}
///*leimanclub
///*�������
	if (strcmp(cmd,"/bardel",true) == 0)
	{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 2219.6941,-1145.0464,25.7891+1);
		SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� � �o�����");
		return 1;
	}
///*�������
	if (strcmp(cmd,"/lctp1",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -737.78, 486.74, 1371.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� � ������� ���� - 1 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/lctp2",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -785.24, 495.22, 1376.20+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� � ������� ���� - 2 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/lctp3",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
//------------------------------------------------------------------------------
//��� ������ ������ �������������� ��� ���������� ������� ������� (�� �������) -
//- ��� ���������� FLY-�������� (��� ��������-��������) !!! (������ ����� -
//- ��� ������ ������������ � �������� ������� !!!)
			SetPVarInt(playerid, "PlCRTp", 1);
			SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
//------------------------------------------------------------------------------
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -834.33, 503.97, 1358.30+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� � ������� ���� - 3 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp1",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 0.00, 0.00, 19516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� �������� - 1 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp2",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 1543.85, -1353.98, 14516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� �������� - 2 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp3",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, -1981.03, 443.81, 9516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� �������� - 3 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/grtp4",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPos(playerid, 2169.05, 1676.22, 4516.98+1);
			SendClientMessage(playerid, COLOR_GREEN, " ����� ���������� �� �������� - 4 !");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/keyon",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /keyon [�� ������]");
				return 1;
			}
			new para1 = strval(tmp);
			if(GetPVarInt(playerid, "AdmLvl") <= 9 && GetPVarInt(para1, "AdmLvl") >= 10)
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������ ������� �� ����������� ������ 10-�� ������ !");
				return 1;
			}
			if(IsPlayerConnected(para1))
			{
				if(spectate[playerid] == para1)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ��� ������� �� ����������� ���������� ������ !");
					return 1;
				}
				spectate[playerid] = para1;
				GetPlayerName(playerid, sendername, sizeof(sendername));
				GetPlayerName(para1, giveplayer, sizeof(giveplayer));
				format(string, sizeof(string), " *** ����� %s ������� �������� �� ����������� ������ %s .", sendername, giveplayer);
				print(string);
				SendAdminMessage(0, 0, COLOR_YELLOW, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/keyoff",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			spectate[playerid] = 600;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** ����� %s �������� �������� �� �����������.", sendername);
			print(string);
			SendAdminMessage(0, 0, COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/tshp",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 2 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /tshp [�� ������] ( ������������� [��������� �����(10-1000)] )");
				return 1;
			}
			new para1 = strval(tmp);
			tmp = strtok(cmdtext, idx);
			new para2;
			if(!strlen(tmp))
			{
				para2 = 50;
			}
			else
			{
				para2 = strval(tmp);
			}
			if(para2 < 10 || para2 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����� �� 10 �� 1000 !");
				return 1;
			}
			if(IsPlayerConnected(para1))
			{
				if(mnhp == 1)
				{
					SendClientMessage(playerid, COLOR_RED, " ������� ������ ������ ������� !");
					return 1;
				}
				mnhp = 1;
				pler1 = 0;
				pler2 = 0;
				SendClientMessage(playerid, COLOR_GREEN, " ������ �����...");
				GetPlayerArmour(para1, plarm);
				GetPlayerHealth(para1, plhp);
				pping1 = GetPlayerPing(para1);
				SetTimerEx("FPing2", 500, 0, "iii", playerid, para1, para2);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/allonline",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /allonline [0- ���, 1- ������-���]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- ���, 1- ������-��� !");
				return 1;
			}
			if (para1 == 1 && (GetPVarInt(playerid, "AdmLvl") >= 1 && GetPVarInt(playerid, "AdmLvl") <= 9))
			{
				SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ����� !");
				return 1;
			}
			if(mnon == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� ������ ������ ������� !");
				return 1;
			}
			mnon = 1;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(para1 == 0)
					{
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), " *** ID: [%d] - %s", i, giveplayer);
						SendClientMessage(playerid, COLOR_GREEN, string);
					}
					else
					{
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						new aa333[64];//��������� ��� ������������� ������� �����
						format(aa333, sizeof(aa333), "%s", giveplayer);//��������� ��� ������������� ������� �����
						printf(" *** ID: [%d] - %s", i, aa333);//��������� ��� ������������� ������� �����
//						printf(" *** ID: [%d] - %s", i, giveplayer);
					}
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para1 == 0)
			{
				format(string, sizeof(string), " *** ����� %s ������ ������ on-line ������� � ����������� ����.", sendername);
			}
			else
			{
				format(string, sizeof(string), " *** ����� %s ������ ������ on-line ������� � ������-����.", sendername);
			}
			print(string);
			SendAdminMessage(0, 0, COLOR_GREEN, string);
			mnon = 0;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/scan",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /scan [0- ����., 1- ���.]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- ����., 1- ���. !");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			if(para1 == 0)
			{
			    if(razresh == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ���� ������� ��� �������� !");
					return 1;
				}
				else
				{
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					printf("[KeyScan] *** ����� %s �������� ���� �������.", aa333);//��������� ��� ������������� ������� �����
//					printf("[KeyScan] *** ����� %s �������� ���� �������.", sendername);
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					print("--------------------------------------------------");
					SendClientMessage(playerid, COLOR_RED, " �� ��������� ���� �������.");
					razresh = 0;
				}
			}
			if(para1 == 1)
			{
			    if(razresh == 1)
				{
					SendClientMessage(playerid, COLOR_RED, " ���� ������� ��� ������� !");
					return 1;
				}
				else
				{
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					printf("[KeyScan] *** ����� %s �������� ���� �������.", aa333);//��������� ��� ������������� ������� �����
//					printf("[KeyScan] *** ����� %s �������� ���� �������.", sendername);
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					print("++++++++++++++++++++++++++++++++++++++++++++++++++");
					SendClientMessage(playerid, COLOR_GREEN, " �� �������� ���� �������.");
					razresh = 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/ipban",true) == 0)
	{
#if (MOD55INS == 1)
		if (GetPVarInt(playerid, "AdmLvl") >= 9 || IsPlayerAdmin(playerid))
#endif
#if (MOD55INS == 2)
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
#endif
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /ipban [IP-�����]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� IP-������ ������ ���� �� 7 �� 15 �������� !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//������� ��������� ����� ������� ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//���������� IP-������
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   IP-����� �� ����� ���������� � ������� !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
			new ind3 = 1;//�������� �������������� "*" � ������ �� ����� ����,
			new ind4 = 0;//� �������� ������ ������ ���� �� ����������� ���������� �����
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
					if(ipper[playerid][ind3][2] == '*')
					{
    					if(strval(ipper[playerid][ind3]) > 25) {ind4 = 1;}
					}
					if(ipper[playerid][ind3][2] != '*')
					{
    					if(strval(ipper[playerid][ind3]) > 255) {ind4 = 2;}
					}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
    		if(ind4 == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 1; i < 4; i++)//������ �������� "*" �� ������� "C"
			{
				new mm;
				mm = strlen(ipper[playerid][i]);
				for(new j = 0; j < mm; j++)
				{
					if(ipper[playerid][i][j] == '*') {ipper[playerid][i][j] = 'C';}
				}
			}
			new ip333[128];//������ ����� �����
			format(ip333, sizeof(ip333), "%s_%s_%s_%s", ipper[playerid][0], ipper[playerid][1], ipper[playerid][2], ipper[playerid][3]);

			new string222[256];
			new reason[128];//������ � ���-����
			format(reason, 128, "(������� /ipban) --- �����: [ %s ]", sendername);//��������� ����� ������
			gettime(timecor[0], timecor[1]);
			getdate(timecor[2], timecor[3], timecor[4]);
			TimCor();//��������� �������
			DatCor();//��������� ����
			new stringdop[256];
			format(stringdop,256,"[%02d:%02d | %02d/%02d/%04d] - %s",timecor[0],timecor[1],timecor[4],timecor[3],timecor[2],reason);
			format(string222,sizeof(string222),"banlist/ipadr/%s.ini",ip333);
			new File: hFile = fopen(string222, io_write);//������ �����
			if (hFile)
			{
				new var[256];
				format(var, 256, "Data=%s\n",stringdop);fwrite(hFile, var);
				fclose(hFile);
			}

			new dopper33[256];//��� IP-������
			strdel(dopper33, 0, 256);
			strcat(dopper33, "banip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " *** ����� %s ������� IP �����: [%s]", sendername, tmp);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/ipunban",true) == 0)
	{
#if (MOD55INS == 1)
		if (GetPVarInt(playerid, "AdmLvl") >= 9 || IsPlayerAdmin(playerid))
#endif
#if (MOD55INS == 2)
		if (GetPVarInt(playerid, "AdmLvl") >= 10 || IsPlayerAdmin(playerid))
#endif
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /ipunban [IP-�����]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� IP-������ ������ ���� �� 7 �� 15 �������� !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//������� ��������� ����� ������� ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//���������� IP-������
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   IP-����� �� ����� ���������� � ������� !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 && strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 && strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
			new ind3 = 1;//�������� �������������� "*" � ������ �� ����� ����,
			new ind4 = 0;//� �������� ������ ������ ���� �� ����������� ���������� �����
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' || ipper[playerid][ind3][0] == '0') {ind4 = 1;}
					if(ipper[playerid][ind3][2] == '*')
					{
    					if(strval(ipper[playerid][ind3]) > 25) {ind4 = 1;}
					}
					if(ipper[playerid][ind3][2] != '*')
					{
    					if(strval(ipper[playerid][ind3]) > 255) {ind4 = 2;}
					}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
    		if(ind4 == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 1; i < 4; i++)//������ �������� "*" �� ������� "C"
			{
				new mm;
				mm = strlen(ipper[playerid][i]);
				for(new j = 0; j < mm; j++)
				{
					if(ipper[playerid][i][j] == '*') {ipper[playerid][i][j] = 'C';}
				}
			}
			new ip333[128];//������ ����� �����
			format(ip333, sizeof(ip333), "%s_%s_%s_%s", ipper[playerid][0], ipper[playerid][1], ipper[playerid][2], ipper[playerid][3]);
			new dopper33[256];//������ IP-������
			strdel(dopper33, 0, 256);
			strcat(dopper33, "unbanip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** ����� %s �������� IP �����: [%s]", sendername, tmp);
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);

			new string222[256];
			format(string222,sizeof(string222),"banlist/ipadr/%s.ini",ip333);
			if(fexist(string222))
			{
				fremove(string222);//������� IP-����� �� ���-�����
				format(string,sizeof(string)," ( IP-����� [%s] ��� ����� �� ���-����� ) !", tmp);
				print(string);
				SendClientMessage(playerid, COLOR_GREEN, string);
			}

		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/cc",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			for(new i=0; i<150; i++)
			{
				SendClientMessageToAll(0xFFFFFFFF, " ");
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " *** ����� %s ������� ��� ������� !", sendername);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if (strcmp(cmd,"/plcmon",true) == 0)
	{
		if (GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /plcmon [0- ���, 1- ������-���] [0- ����., 1- ���.,");
				SendClientMessage(playerid, COLOR_GRAD2, " 2- ����������� ���������] ( ������������� [��������� �����������(10-1000)] )");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- ���, 1- ������-��� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para2;
			para2 = strval(tmp);
			if(para2 < 0 || para2 > 2)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- ����., 1- ���., 2- ����������� ���������] !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para3;
			new para4;
			if(!strlen(tmp))
			{
				para3 = 500;
				para4 = 0;
			}
			else
			{
				para3 = strval(tmp);
				para4 = 1;
			}
			if(para3 < 10 || para3 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����������� �� 10 �� 1000 !");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			if(para1 == 0)
			{
				if(para2 == 0)
				{
					if(plloc[playerid] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����-������� � ���� ��� �������� !");
						return 1;
					}
					else
					{
						plloc[playerid] = 0;
						format(string, sizeof(string), " *** ����� %s �������� ����-������� � ����.", aa333);
						print(string);
						SendAdminMessage(0, 0, COLOR_RED, string);
						return 1;
					}
				}
				if(para2 == 1)
				{
					if(plloc[playerid] == 1 && para4 == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " �� �� ������ ��������� ����������� !");
						return 1;
					}
					if(plloc[playerid] == 1 && para4 == 1 && pllocdist[playerid] == para3)
					{
						SendClientMessage(playerid, COLOR_RED, " �� ������ ������ ��������� ����������� !");
						return 1;
					}
					if(plloc[playerid] == 1 && para4 == 1 && pllocdist[playerid] != para3)
					{
						pllocdist[playerid] = para3;
						format(string, sizeof(string), " *** ����� %s ������� ��������� ����������� ��� ����-�������� � ���� �� %d", aa333, pllocdist[playerid]);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
					if(plloc[playerid] == 0)
					{
						plloc[playerid] = 1;
						pllocdist[playerid] = para3;
						format(string, sizeof(string), " *** ����� %s ������� ����-������� � ����, � ���������� ����������� %d", aa333, pllocdist[playerid]);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
				}
				if(para2 == 2)
				{
					if(plloc[playerid] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����-������� � ���� ��������.");
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						SendClientMessage(playerid, COLOR_GREEN, " ����-������� � ���� �������.");
						format(string, sizeof(string), " ��������� �����������: {FFFF00}%d .", pllocdist[playerid]);
						SendClientMessage(playerid, COLOR_GREEN, string);
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						printf(" *** ����� %s ���������� ��������� ����-�������� � ����.", aa333);
						return 1;
					}
				}
			}
			if(para1 == 1)
			{
				if(GetPVarInt(playerid, "AdmLvl") <= 9)
				{
					SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ����� !");
					return 1;
				}
				if(para2 == 0)
				{
					if(plgl == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����-������� � ������-���� ��� �������� !");
						return 1;
					}
					else
					{
						plgl = 0;
						SaveData();//������ ����� keyscan.ini
						format(string, sizeof(string), " *** ����� %s �������� ����-������� � ������-����.", aa333);
						print(string);
						SendAdminMessage(0, 0, COLOR_RED, string);
						return 1;
					}
				}
				if(para2 == 1)
				{
					if(plgl == 1 && para4 == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " �� �� ������ ��������� ����������� !");
						return 1;
					}
					if(plgl == 1 && para4 == 1 && plgldist == para3)
					{
						SendClientMessage(playerid, COLOR_RED, " �� ������ ������ ��������� ����������� !");
						return 1;
					}
					if(plgl == 1 && para4 == 1 && plgldist != para3)
					{
						plgldist = para3;
						SaveData();//������ ����� keyscan.ini
						format(string, sizeof(string), " *** ����� %s ������� ��������� ����������� ��� ����-�������� � ������-���� �� %d", aa333, plgldist);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
					if(plgl == 0)
					{
						plgl = 1;
						plgldist = para3;
						SaveData();//������ ����� keyscan.ini
						format(string, sizeof(string), " *** ����� %s ������� ����-������� � ������-����, � ���������� ����������� %d", aa333, plgldist);
						print(string);
						SendAdminMessage(0, 0, COLOR_GREEN, string);
						return 1;
					}
				}
				if(para2 == 2)
				{
					if(plgl == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����-������� � ������-���� ��������.");
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						SendClientMessage(playerid, COLOR_GREEN, " ����-������� � ������-���� �������.");
						format(string, sizeof(string), " ��������� �����������: {FFFF00}%d .", plgldist);
						SendClientMessage(playerid, COLOR_GREEN, string);
						SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
						printf(" *** ����� %s ���������� ��������� ����-�������� � ������-����.", aa333);
						return 1;
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	return 0;
}

public EndPlCRTp(playerid)
{
	SetPVarInt(playerid, "PlCRTp", 0);
	return 1;
}

public FPing2(playerid, para1, para2)
{
	pping2 = GetPlayerPing(para1);
	SetTimerEx("FPing3", 500, 0, "iii", playerid, para1, para2);
	return 1;
}

public FPing3(playerid, para1, para2)
{
	pping3 = GetPlayerPing(para1);
	new string[256];
	new dopper;
	dopper = (((pping1 + pping2 + pping3) / 3) * 2) + para2;
	format(string, sizeof(string), " ������� ����: %d (��� �����: %d)", (dopper - para2) / 2, dopper);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	SetPlayerArmour(para1, 90.00);
	SetTimerEx("Prov1", dopper, 0, "iii", playerid, para1, dopper);
	return 1;
}

public Prov1(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 87.00 || dopper >= 93.00)
	{
		pler1 = 1;
	}
	SetPlayerArmour(para1, 60.00);
	SetTimerEx("Prov2", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov2(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 57.00 || dopper >= 63.00)
	{
		pler1 = 1;
	}
	SetPlayerArmour(para1, 30.00);
	SetTimerEx("Prov3", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov3(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerArmour(para1, dopper);
	if(dopper <= 27.00 || dopper >= 33.00)
	{
		pler1 = 1;
	}
	SetPlayerHealth(para1, 90.00);
	SetTimerEx("Prov4", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov4(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 87.00 || dopper >= 93.00)
	{
		pler2 = 1;
	}
	SetPlayerHealth(para1, 60.00);
	SetTimerEx("Prov5", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov5(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 57.00 || dopper >= 63.00)
	{
		pler2 = 1;
	}
	SetPlayerHealth(para1, 30.00);
	SetTimerEx("Prov6", para2, 0, "iii", playerid, para1, para2);
	return 1;
}

public Prov6(playerid, para1, para2)
{
	new Float:dopper;
	GetPlayerHealth(para1, dopper);
	if(dopper <= 27.00 || dopper >= 33.00)
	{
		pler2 = 1;
	}
	SetPlayerArmour(para1, plarm);
	SetPlayerHealth(para1, plhp);
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	format(string, sizeof(string), " *** ����� %s ������������� ������ %s �� hp.", sendername, giveplayer);
	print(string);
	SendAdminMessage(0, 0, COLOR_YELLOW, string);
	if(pler1 == 0 && pler2 == 0)
	{
		format(string, sizeof(string), " ����� %s [%d]: {00FF00}����� - ��, ����� - ��", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 1 && pler2 == 0)
	{
		format(string, sizeof(string), " ����� %s [%d]: {FF0000}����� - ������, {00FF00}����� - ��", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 0 && pler2 == 1)
	{
		format(string, sizeof(string), " ����� %s [%d]: {00FF00}����� - ��, {FF0000}����� - ������", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	if(pler1 == 1 && pler2 == 1)
	{
		format(string, sizeof(string), " ����� %s [%d]: {FF0000}����� - ������, ����� - ������", giveplayer, para1);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		mnhp = 0;
		return 1;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(razresh == 1)
	{
    	new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		printf("[KeyScan][key] %s [%d] - %d ... %d", aa333, playerid, newkeys, oldkeys);//��������� ��� ������������� ������� �����
//		printf("[KeyScan][key] %s [%d] - %d ... %d", sendername, playerid, newkeys, oldkeys);
	}
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			new data;
			data = newkeys - oldkeys;
			if (data > 0)
			{
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				switch(data)
				{
					case 1: format(string, sizeof(string), " �����: %s [%d] (����������) - ��������", giveplayer, playerid);
					case 2: format(string, sizeof(string), " �����: %s [%d] (����������) - ��������", giveplayer, playerid);
					case 4: format(string, sizeof(string), " �����: %s [%d] (����������) - �����", giveplayer, playerid);
					case 8: format(string, sizeof(string), " �����: %s [%d] (����������) - ������", giveplayer, playerid);
					case 16: format(string, sizeof(string), " �����: %s [%d] (����������) - ��������� �����", giveplayer, playerid);
					case 32: format(string, sizeof(string), " �����: %s [%d] (����������) - ������", giveplayer, playerid);
					case 64: format(string, sizeof(string), " �����: %s [%d] (����������) - �������� ������", giveplayer, playerid);
					case 128: format(string, sizeof(string), " �����: %s [%d] (����������) - ������ ������, (����� ��� ������)", giveplayer, playerid);
					case 132: format(string, sizeof(string), " �����: %s [%d] (����������) - {FFFF00}������ ������-2", giveplayer, playerid);
					case 256: format(string, sizeof(string), " �����: %s [%d] (����������) - �������� �����", giveplayer, playerid);
					case 512: format(string, sizeof(string), " �����: %s [%d] (����������) - ��������� ��� �������� �����", giveplayer, playerid);
					case 1024: format(string, sizeof(string), " �����: %s [%d] (����������) - ���� �����", giveplayer, playerid);
					case 2048: format(string, sizeof(string), " �����: %s [%d] (����������) - ����� (����. ����.)", giveplayer, playerid);
					case 4096: format(string, sizeof(string), " �����: %s [%d] (����������) - ���� (����. ����.)", giveplayer, playerid);
					case 8192: format(string, sizeof(string), " �����: %s [%d] (����������) - ����� (����. ����.)", giveplayer, playerid);
					case 16384: format(string, sizeof(string), " �����: %s [%d] (����������) - ������ (����. ����.)", giveplayer, playerid);
					case 65408: format(string, sizeof(string), " �����: %s [%d] (����������) - ����� ��� �����", giveplayer, playerid);
					case 65536: format(string, sizeof(string), " �����: %s [%d] (����������) - {FFFF00}�����: ��", giveplayer, playerid);
					case 131072: format(string, sizeof(string), " �����: %s [%d] (����������) - {FFFF00}�����: ���", giveplayer, playerid);
					case 262144: format(string, sizeof(string), " �����: %s [%d] (����������) - �������� ������", giveplayer, playerid);
					case 264192: format(string, sizeof(string), " �����: %s [%d] (����������) - {FFFF00}����� ����", giveplayer, playerid);
				}
				if (data == 1 || data == 2 || data == 4 || data == 8 || data == 16 || data == 32 || data == 64 || data == 128 ||
				data == 132 || data == 256 || data == 512 || data == 1024 || data == 2048 || data == 4096 || data == 8192 ||
				data == 16384 || data == 65408 || data == 65536 || data == 131072 || data == 262144 || data == 264192)
				{
					SendClientMessage(i, COLOR_GREEN, string);
				}
				if (data != 1 && data != 2 && data != 4 && data != 8 && data != 16 && data != 32 && data != 64 && data != 128 &&
				data != 132 && data != 256 && data != 512 && data != 1024 && data != 2048 && data != 4096 && data != 8192 &&
				data != 16384 && data != 65408 && data != 65536 && data != 131072 && data != 262144 && data != 264192 &&
				(data > 0 && data < 8192))
				{
					format(string, sizeof(string), " �����: %s [%d] (����������) - {FFFF00}����������� ��� (%d)", giveplayer, playerid, data);
					SendClientMessage(i, COLOR_GREEN, string);
				}
				if (data != 1 && data != 2 && data != 4 && data != 8 && data != 16 && data != 32 && data != 64 && data != 128 &&
				data != 132 && data != 256 && data != 512 && data != 1024 && data != 2048 && data != 4096 && data != 8192 &&
				data != 16384 && data != 65408 && data != 65536 && data != 131072 && data != 262144 && data != 264192 &&
				data > 8192)
				{
					format(string, sizeof(string), " �����: %s [%d] (����������) - {FF0000}������������� ��� (%d)", giveplayer, playerid, data);
					SendClientMessage(i, COLOR_GREEN, string);
				}
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(razresh == 1)
	{
    	new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		printf("[KeyScan][click] %s [%d] - %d ... %d", aa333, playerid, clickedplayerid, source);//��������� ��� ������������� ������� �����
//		printf("[KeyScan][click] %s [%d] - %d ... %d", sendername, playerid, clickedplayerid, source);
	}
    new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new targetname[MAX_PLAYER_NAME];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (spectate[i] == playerid)
		{
			GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(clickedplayerid, targetname, sizeof(targetname));
			format(string, sizeof(string), " �����: %s [%d] {FF0000}(���� �� ������){00FF00} - %s [%d]", giveplayer, playerid, targetname, clickedplayerid);
			SendClientMessage(i, COLOR_GREEN, string);
		}
	}
	return 1;
}

public DatCor()
{
	new Float:flyear;
	timecor[3] = timecor[3] + CorTime[3];//��������� ������
	timecor[5] = 0;//������� �� ���
	if(timecor[3] < 1)
	{
		timecor[3] = 12 + timecor[3];
		timecor[5] = -1;//������� �� ���
	}
	if(timecor[3] > 12)
	{
		timecor[3] = timecor[3] - 12;
		timecor[5] = 1;//������� �� ���
	}
	timecor[2] = timecor[2] + CorTime[4] + timecor[5];//��������� ����
	flyear = float(timecor[2]);
	flyear = floatdiv(flyear, 4);
	flyear = floatfract(flyear);
	if(flyear != 0){timecor[7] = 0;}//�� ���������� ���
	if(flyear == 0){timecor[7] = 1;}//���������� ���
	timecor[4] = timecor[4] + CorTime[2] + timecor[6];//��������� �����
	timecor[5] = 0;//������� �� �����
	if(timecor[4] < 1 && timecor[3] == 3 && timecor[7] == 0)
	{
		timecor[4] = 28 + timecor[4];
		timecor[5] = -1;//������� �� �����
	}
	if(timecor[4] < 1 && timecor[3] == 3 && timecor[7] == 1)
	{
		timecor[4] = 29 + timecor[4];
		timecor[5] = -1;//������� �� �����
	}
	if(timecor[4] < 1 && (timecor[3] == 5 || timecor[3] == 7 || timecor[3] == 10 || timecor[3] == 12))
	{
		timecor[4] = 30 + timecor[4];
		timecor[5] = -1;//������� �� �����
	}
	if(timecor[4] < 1 && (timecor[3] == 2 || timecor[3] == 4 || timecor[3] == 6 || timecor[3] == 8 || timecor[3] == 9 || timecor[3] == 11 || timecor[3] == 1))
	{
		timecor[4] = 31 + timecor[4];
		timecor[5] = -1;//������� �� �����
	}
	if(timecor[4] > 28 && timecor[3] == 2 && timecor[7] == 0)
	{
		timecor[4] = timecor[4] - 28;
		timecor[5] = 1;//������� �� �����
	}
	if(timecor[4] > 29 && timecor[3] == 2 && timecor[7] == 1)
	{
		timecor[4] = timecor[4] - 29;
		timecor[5] = 1;//������� �� �����
	}
	if(timecor[4] > 30 && (timecor[3] == 4 || timecor[3] == 6 || timecor[3] == 9 || timecor[3] == 11))
	{
		timecor[4] = timecor[4] - 30;
		timecor[5] = 1;//������� �� �����
	}
	if(timecor[4] > 31 && (timecor[3] == 1 || timecor[3] == 3 || timecor[3] == 5 || timecor[3] == 7 || timecor[3] == 8 || timecor[3] == 10 || timecor[3] == 12))
	{
		timecor[4] = timecor[4] - 31;
		timecor[5] = 1;//������� �� �����
	}
	timecor[3] = timecor[3] + timecor[5];//��������� ������
	timecor[5] = 0;//������� �� ���
	if(timecor[3] < 1)
	{
		timecor[3] = 12 + timecor[3];
		timecor[5] = -1;//������� �� ���
	}
	if(timecor[3] > 12)
	{
		timecor[3] = timecor[3] - 12;
		timecor[5] = 1;//������� �� ���
	}
	timecor[2] = timecor[2] + timecor[5];//��������� ����
	return 1;
}

public TimCor()
{
	timecor[1] = timecor[1] + CorTime[1];//��������� �����
	timecor[5] = 0;//������� �� ���
	if(timecor[1] < 0)
	{
		timecor[1] = 60 + timecor[1];
		timecor[5] = -1;//������� �� ���
	}
	if(timecor[1] > 59)
	{
		timecor[1] = timecor[1] - 60;
		timecor[5] = 1;//������� �� ���
	}
	timecor[0] = timecor[0] + CorTime[0] + timecor[5];//��������� �����
	timecor[6] = 0;//������� �� ����
	if(timecor[0] < 0)
	{
		timecor[0] = 24 + timecor[0];
		timecor[6] = -1;//������� �� ����
	}
	if(timecor[0] > 23)
	{
		timecor[0] = timecor[0] - 24;
		timecor[6] = 1;//������� �� ����
	}
	return 1;
}

public ReadCorTime()
{
	new string[256];
	format(string,sizeof(string),"data/cortime.ini");
	new File: UserFile = fopen(string, io_read);//������ �����
	new key[ 256 ] , val[ 256 ];
	new Data[ 256 ];
	while ( fread( UserFile , Data , sizeof( Data ) ) )
	{
		key = ini_GetKey( Data );
		if( strcmp( key , "hour" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[0] = strval( val ); }
		if( strcmp( key , "minute" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[1] = strval( val ); }
		if( strcmp( key , "day" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[2] = strval( val ); }
		if( strcmp( key , "month" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[3] = strval( val ); }
		if( strcmp( key , "year" , true ) == 0 ) { val = ini_GetValue( Data ); CorTime[4] = strval( val ); }
	}
	fclose(UserFile);
	return 1;
}

public dopfunction(per)
{
	ReadCorTime();
	return 1;
}

public ReadData()
{
	new string[256];
	format(string,sizeof(string),"data/keyscan.ini");
	new File: UserFile = fopen(string, io_read);//������ �����
	new key[ 256 ] , val[ 256 ];
	new Data[ 256 ];
	while ( fread( UserFile , Data , sizeof( Data ) ) )
	{
		key = ini_GetKey( Data );
		if( strcmp( key , "SLMon" , true ) == 0 ) { val = ini_GetValue( Data ); plgl = strval( val ); }
		if( strcmp( key , "SLMonDist" , true ) == 0 ) { val = ini_GetValue( Data ); plgldist = strval( val ); }
	}
	fclose(UserFile);
	return 1;
}

public SaveData()
{
	new string[256];
	format(string,sizeof(string),"data/keyscan.ini");
	new File: hFile = fopen(string, io_write);//������ �����
	if (hFile)
	{
		new var[32];
		format(var, 32, "SLMon=%d\n",plgl);fwrite(hFile, var);
		format(var, 32, "SLMonDist=%d\n",plgldist);fwrite(hFile, var);
		fclose(hFile);
	}
	return 1;
}


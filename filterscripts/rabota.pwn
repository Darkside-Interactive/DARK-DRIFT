// {CA0C0C} - ������� ����
// {FAFA08} - ������ ����
// {1F08FA} - ����� ����
// {10AE12} - ������ ����
// {FFFFFF} - ����� ����

#include <a_samp>
#pragma tabsize 0
#pragma warning disable 217
#define Msend SendClientMessage
#define SPD ShowPlayerDialog
#define COLOR_WHITE 0xFFFFFFAA
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
new PickupElJob;
new elchit1[MAX_PLAYERS];
new elchit2[MAX_PLAYERS];
new elchit3[MAX_PLAYERS];
new elchit4[MAX_PLAYERS];
new elchit5[MAX_PLAYERS];
new elchit6[MAX_PLAYERS];
new elchit7[MAX_PLAYERS];
new elchit8[MAX_PLAYERS];

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return true;
		}
	}
	return false;
}

new InfoEl[16][] = { // 16
	{"{FFFFFF}\n"},
	{"\n"},
	{"\n"},
	{"������, �� ����� ��������� ������ �� ������ '��������' � ��� ������.\n"}, // 3
	{"������ � ��� �� ����� ���� �����������, ��� � ������� ��������.\n"}, // 4
	{"������� ������ 4 �����, ����� ���: {FAFA08}������{FFFFFF}, {1F08FA}�����{FFFFFF}, {CA0C0C}�������{FFFFFF}, {10AE12}�������{FFFFFF}\n"},
	{"� ������� ��� �������� �� 1 �� 4, ���� ����� ���������� �������� ���������.\n"},
	{"��� ���������� ���� ����� �������� �������, � {FAFA08}�������{FFFFFF} �� {CA0C0C}�������.{FFFFFF}\n"},
	{"� ������� ��� �������� �� 5 �� 8, ���� ����� ������� ������������.\n"},
	{"��� ���������� ���� ����� �������� �������, � {10AE12}��������{FFFFFF} �� {1F08FA}�����.{FFFFFF}\n"},
	{"����� ������� �� ��������� ������, ����� ���� ����� ������� ����� ��\n"},
	{"������������ ������! �� ������ ���������� ���������� ������, ��\n"},
	{"��������� ������. C����� ������ '/elcommand' ����� ���� ����� ��� ���� ! \n"},
	{"\n"},
	{"\n"},
	{"\n"}
};

public OnFilterScriptInit()
{
	Create3DTextLabel("(( ������ �������� ))", COLOR_WHITE, -1862.2433, -146.7663, 11.8984, 7.0,0,0);
	PickupElJob = CreatePickup(1275, 23, -1862.2433, -145.7663, 11.8984);
	Create3DTextLabel("������� #1 | ������ ������ /elchit1",COLOR_WHITE, -2532.3950195, -624.3200073, 131.7460022, 5.0, 0,0); // 1
	Create3DTextLabel("������� #2 | ������ ������ /elchit2",COLOR_WHITE, -2226.6489258, 161.5350037, 34.3199997, 5.0, 0,0); // 2
	Create3DTextLabel("������� #3 | ������ ������ /elchit3",COLOR_WHITE, -1978.3261719, 953.8310547, 44.4449997, 5.0, 0,0); // 3
	Create3DTextLabel("������� #4 | ������ ������ /elchit4",COLOR_WHITE, -2443.7158203, 1025.8847656, 749.3909988, 5.0, 0,0); // 4
	Create3DTextLabel("������� #5 | ������ ������ /elchit5",COLOR_WHITE, -1699.4765625, 414.8349609, 6.1799998, 5.0, 0,0); // 5
	Create3DTextLabel("������� #6 | ������ ������ /elchit6",COLOR_WHITE, -1693.9628906, -30.3671875, 2.5550001, 5.0, 0,0); // 6
	Create3DTextLabel("������� #7 | ������ ������ /elchit7",COLOR_WHITE, -2786.2319336, 796.6409912, 48.7999992, 5.0, 0,0); // 7
	Create3DTextLabel("������� #8 | ������ ������ /elchit8",COLOR_WHITE, -2749.6093750, 196.2587891, 6.1170001, 5.0, 0,0); // 8
	AddStaticVehicleEx(462,-1849.8979492,-144.2369995,11.5690002,0.0000000,-1,-1,15); //Faggio
	AddStaticVehicleEx(462,-1851.2900391,-144.1479950,11.5690002,0.0000000,-1,-1,15); //Faggio
	AddStaticVehicleEx(462,-1852.6610107,-144.1569977,11.5690002,0.0000000,-1,-1,15); //Faggio
	AddStaticVehicleEx(462,-1854.1190186,-144.0919952,11.5690002,0.0000000,-1,-1,15); //Faggio
	AddStaticVehicleEx(462,-1855.4949951,-144.0859985,11.5749998,0.0000000,-1,-1,15); //Faggio
	CreateObject(3273,-2532.3950195,-624.3200073,131.7460022,0.0000000,0.0000000,270.8577881); //object(substa_transf2_) (1)
	CreateObject(3273,-2226.6489258,161.5350037,34.3199997,0.0000000,0.0000000,359.9951172); //object(substa_transf2_) (2)
	CreateObject(3273,-1978.3261719,953.8310547,44.4449997,0.0000000,0.0000000,359.9945068); //object(substa_transf2_) (3)
	CreateObject(3273,-2443.7158203,1025.8847656,49.3909988,0.0000000,0.0000000,359.9945068); //object(substa_transf2_) (4)
	CreateObject(3273,-1699.4765625,414.8349609,6.1799998,0.0000000,0.0000000,44.9670410); //object(substa_transf2_) (5)
	CreateObject(3273,-1693.9628906,-30.3671875,2.5550001,0.0000000,0.0000000,44.9670410); //object(substa_transf2_) (6)
	CreateObject(3273,-2786.2319336,796.6409912,48.7999992,0.0000000,0.0000000,270.8569336); //object(substa_transf2_) (7)
	CreateObject(3273,-2749.6093750,196.2587891,6.1170001,0.0000000,0.0000000,270.8569336); //object(substa_transf2_) (8)
	return 1;
	
}

public OnFilterScriptExit()
{
	return 1;
}

//� ������� ��������� �������� ���������, ���������� ���������

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/elchit1", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ���������� ������
	if(PlayerToPoint(5.0,playerid,	-2057.51000977, -93.35166931, 34.9217834)) return Msend(playerid, COLOR_WHITE,"- ���������� ��������� ����� � �������!");
	if(elchit1[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"- �� ��� ���������� ��� ��������!");
		{
			ShowPlayerDialog(playerid, 430, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit1[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}
	
	if (strcmp("/elchit2", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
//	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -2226.6489258, 161.5350037, 34.3199997))
	if(!PlayerToPoint(2.0,playerid,	-2226.6489258, 161.5350037, 34.3199997)) return Msend(playerid, COLOR_WHITE,"- ���������� ��������� ����� � �������!");
	if(elchit2[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 430, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit2[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}
	
	if (strcmp("/elchit3", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0,	-1978.3261719, 953.8310547, 44.4449997))
	if(elchit3[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 430, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit3[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}

	if (strcmp("/elchit4", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -2443.7158203, 1025.8847656, 749.3909988))
	if(elchit4[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 430, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit4[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}

	if (strcmp("/elchit5", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -1699.4765625, 414.8349609, 6.1799998))
	if(elchit5[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 431, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit5[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}
	
	if (strcmp("/elchit6", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0,	-1693.9628906, -30.3671875, 2.5550001))
	if(elchit6[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 431, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit6[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}
	if (strcmp("/elchit7", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -2786.2319336, 796.6409912, 48.7999992))
	if(elchit7[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 431, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������ {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit7[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}
	
	if (strcmp("/elchit8", cmdtext, true, 10) == 0) // ������� 1
	{
	if(GetPVarInt(playerid,"ElJob") == 1) // �������� �� ��� ����� ��������
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -2749.6093750, 196.2587891, 6.1170001))
	if(elchit8[playerid] > gettime()) return Msend(playerid, COLOR_WHITE,"�� ��� ����� ��������� ��������!");
		{
			ShowPlayerDialog(playerid, 431, DIALOG_STYLE_LIST, "����������� �������������", "{FFFFFF}�������� ������� {FFFFFF}�� {1F08FA}�����\n{FFFFFF}�������� {FAFA08}������� {FFFFFF}�� {CA0C0C}�������\n{FFFFFF}�������� {FAFA08}������� {FFFFFF}�� {FAFA08}������", "�����", "�����");
			elchit8[playerid] = gettime() + 210; // ������ ����� �� ������������� 190 ���
			return 1;
		}
	}

	if (strcmp("/elinfo", cmdtext, true, 10) == 0)
	{
		new InfoElDialog[1000];
		format(InfoElDialog,sizeof(InfoElDialog), "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",InfoEl[0],InfoEl[1],InfoEl[2],InfoEl[3],InfoEl[4],InfoEl[5],InfoEl[6],InfoEl[7],InfoEl[8],InfoEl[9],InfoEl[10],InfoEl[11],InfoEl[12],InfoEl[13],InfoEl[14],InfoEl[15]);
		SPD(playerid,289289,DIALOG_STYLE_MSGBOX,"����������", InfoElDialog, "������", "");
		return true;
	}

	if (strcmp("/elmap", cmdtext, true, 10) == 0)
	{
	if(GetPVarInt(playerid,"ElJob") == 1)
		{
			new menu[500];
			strcat(menu, "������� #1 | ����� San Fiero\r\n");
			strcat(menu, "������� #2 | ����� San Fiero\r\n");
			strcat(menu, "������� #3 | ����� San Fiero\r\n");
			strcat(menu, "������� #4 | ����� San Fiero\r\n");
			strcat(menu, "������� #5 | ����� San Fiero\r\n");
			strcat(menu, "������� #6 | ����� San Fiero\r\n");
			strcat(menu, "������� #7 | ����� San Fiero\r\n");
			strcat(menu, "������� #8 | ����� San Fiero\r\n");
			ShowPlayerDialog(playerid, 429, DIALOG_STYLE_LIST, "���� �������", menu, "�����", "�����");
			return 1;
		}
	}
	if (strcmp("/elcommand", cmdtext, true, 10) == 0)
	{
		for(new i = 0; i < 20; i++) Msend(playerid, COLOR_WHITE,"");
	//	Msend(playerid, COLOR_WHITE,"/elchit - ������� ������ �������");
	//	Msend(playerid, COLOR_WHITE,"/elchit2 - ������� ������ �������");
		Msend(playerid, COLOR_WHITE,"/elcommand - ������ ������ ���������");
		Msend(playerid, COLOR_WHITE,"/elinfo - ��������� �������� ����������");
		Msend(playerid, COLOR_WHITE,"/elmap - ������ ��� ����� �������");
		return 1;
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 431)
	{
		if(response)
		{
			switch(listitem)
			{
			case 0: Msend(playerid, COLOR_WHITE,"�������, �������� ������! �� ��������� � �������!"), GivePlayerMoney(playerid, 200);
			case 1: Msend(playerid, COLOR_WHITE,"���, ���� ������� �����! �� ����������� �������� ������!"), SetPlayerHealth(playerid, -20);
			case 2: Msend(playerid, COLOR_WHITE,"���, ���� ������� �����! �� ����������� �������� ������!"), SetPlayerHealth(playerid, -20);
			}
		}
	}
	if(dialogid == 430)
	{
		if(response)
		{
			switch(listitem)
			{
			case 0: Msend(playerid, COLOR_WHITE,"���, ���� ������� �����! �� ����������� �������� ������!"), SetPlayerHealth(playerid, -20);
			case 1: Msend(playerid, COLOR_WHITE,"�������, �������� ������! �� ��������� � �������!"), GivePlayerMoney(playerid, 200);
			case 2: Msend(playerid, COLOR_WHITE,"���, ���� ������� �����! �� ����������� �������� ������!"), SetPlayerHealth(playerid, -20);
			}
		}
	}
	if(dialogid == 429)
	{
		if(response)
		{
			switch(listitem)
			{
			case 0: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-2532.3950195, -624.3200073, 131.7460022, 5.0);
			case 1: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-2226.6489258, 161.5350037, 34.3199997, 5.0);
			case 2: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-1978.3261719, 953.8310547, 44.4449997, 5.0);
			case 3: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-2443.7158203, 1025.8847656, 749.3909988, 5.0);
			case 4: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-1699.4765625, 414.8349609, 6.1799998, 5.0);
			case 5: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-1693.9628906, -30.3671875, 2.5550001, 5.0);
			case 6:	Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-2786.2319336, 796.6409912, 48.7999992, 5.0);
			case 7: Msend(playerid, COLOR_WHITE,"������� ������� �� �����, ������������� ����."), SetPlayerCheckpoint(playerid,-2749.6093750, 196.2587891, 6.1170001, 5.0);
			}
		}
	}
	if(dialogid == 427 && response)
	{
		SetPVarInt(playerid,"ElJob",1);
		Msend(playerid, COLOR_WHITE,"�������� '/elmap' ����� ������ ��� ����� �������, � ������������� ����.");
	}
	if(dialogid == 428 && response)
	{
		SetPVarInt(playerid,"ElJob",0);
		Msend(playerid, COLOR_WHITE,"�� ��������� ������.");
	}
    return 1;
}
public OnPlayerConnect(playerid)
{
	elchit1[playerid] = 0;
	elchit2[playerid] = 0;
	elchit3[playerid] = 0;
	elchit4[playerid] = 0;
	elchit5[playerid] = 0;
	elchit6[playerid] = 0;
	elchit7[playerid] = 0;
	elchit8[playerid] = 0;
	SetPVarInt(playerid,"ElJob", 0);
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == PickupElJob)
	{
		if(GetPVarInt(playerid,"ElJob") == 0)
		{
			SPD(playerid,427,DIALOG_STYLE_MSGBOX,"������ ��������","�� ������� ������ �������� ?", "��", "������");
		}
		else if(GetPVarInt(playerid,"ElJob") == 1)
		{
			SPD(playerid,428,DIALOG_STYLE_MSGBOX,"������ ��������","�� ������� ��������� �������� ?", "��", "������");
		}
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	SetPVarInt(playerid,"ElJob",0);
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	DisablePlayerCheckpoint(playerid); // ��������� ���-����� ���� ����� ���� �� ����.
	return 1;
}

#include <a_samp>

#pragma dynamic 8000

#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

#define OBRAD 13 //����� ����� +1

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA

new NRadio[MAX_PLAYERS];//���������� ������ ������������� �����
new STRadio[OBRAD][128];//������ URL-������ �� �����-������
new NMRadio[OBRAD][64];//������ �������� �����

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("        Filterscript Radio - 3         ");
	print("--------------------------------------\n");

	STRadio[1] = "http://www.zaycev.fm:9001/ZaycevFM(128).m3u";
	STRadio[2] = "http://ep128server.streamr.ru:8030/ep128";
	STRadio[3] = "http://air.radiorecord.ru:8102/sd90_128";
	STRadio[4] = "http://online.nashipesni.ru:8000/nashipesni";
	STRadio[5] = "http://stream05.akaver.com/russkoeradio_hi.mp3";
	STRadio[6] = "http://cast.radiogroup.com.ua:8000/avtoradio";
	STRadio[7] = "http://air.radiorecord.ru:8101/rr_128";
	STRadio[8] = "http://air.radiorecord.ru:8102/dub_128";
	STRadio[9] = "http://air.radiorecord.ru:8102/club_128";
	STRadio[10] = "http://air.radiorecord.ru:8102/mdl_128";
	STRadio[11] = "http://aska.ru-hoster.com:2199/tunein/marseli.pls";
	STRadio[12] = "http://streaming.radionomy.com/radio-xtreme---sensation-tubes-garantie";

	NMRadio[1] = "Zaycev-FM";
	NMRadio[2] = "������ +";
	NMRadio[3] = "�������������� 90-�";
	NMRadio[4] = "���� �����";
	NMRadio[5] = "������� �����";
	NMRadio[6] = "���������";
	NMRadio[7] = "Radio Record";
	NMRadio[8] = "Dubstep";
	NMRadio[9] = "Club";
	NMRadio[10] = "������ FM";
	NMRadio[11] = "LeimaN";
	NMRadio[12] = "Radio Xtreme";

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SetPVarInt(i, "CComAc2", 0);
	}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{//���������� ������� ��� ���� ������������ ��������
		if(IsPlayerConnected(i))
		{
			DeletePVar(i, "CComAc2");
			StopAudioStreamForPlayer(i);
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "CComAc2", 0);
	NRadio[playerid] = 0;//����� ������ �������������� ����� ������������� �����
	StopAudioStreamForPlayer(playerid);//�������� ����� �����
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	NRadio[playerid] = 0;//����� ������ �������������� ����� ������������� �����
	StopAudioStreamForPlayer(playerid);//�������� ����� �����
	DeletePVar(playerid, "CComAc2");
	return 1;
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

public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "CComAc2", GetPVarInt(playerid, "CComAc2") + 1);
	new string[256];
	new cmd[256];
	new tmp[256];
	new idx;
    new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,pname,sizeof(pname));
	new aa333[64];//��������� ��� ������������� ������� �����
	format(aa333, sizeof(aa333), "%s", pname);//��������� ��� ������������� ������� �����
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd,"/radon",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GREY, " �����������: /radon [�����(1-12)]");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 < 1 || para1 > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ����� ��� !");
			return 1;
		}
		if(NRadio[playerid] != para1)
		{
			NRadio[playerid] = para1;//����� ������������� �����
			StopAudioStreamForPlayer(playerid);//�������� ����� ������ �����
			PlayAudioStreamForPlayer(playerid, STRadio[para1]);//��������� ����� � �������
			format(string, sizeof(string), " �� �������� ����� %s", NMRadio[para1]);
			SendClientMessage(playerid, COLOR_GREY, string);
			printf("[radio] ����� %s ������� ����� %s .", aa333, NMRadio[para1]);//��������� ��� ������������� ������� �����
//			printf("[radio] ����� %s ������� ����� %s .", pname, NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " ������, � ��� ��� �������� ��� ����� !");
		}
	    return 1;
	}
	if (strcmp(cmd,"/radoff",true) == 0)
	{
		if(NRadio[playerid] != 0)
		{
			NRadio[playerid] = 0;//�������������� �����
			StopAudioStreamForPlayer(playerid);//�������� ����� �����
			SendClientMessage(playerid, COLOR_GREY, " �� ��������� �����");
			printf("[radio] ����� %s �������� �����.", aa333);//��������� ��� ������������� ������� �����
//			printf("[radio] ����� %s �������� �����.", pname);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " ������, � ��� ��������� ����� !");
		}
	    return 1;
	}
	if(strcmp(cmd, "/radhelp", true) == 0)
	{
		SendClientMessage(playerid,COLOR_GREY," -------------------------- ������ �� ����� -------------------------- ");
		SendClientMessage(playerid,COLOR_GREY,"               /radhelp   /radon [�����(1-12)]   /radoff");
		SendClientMessage(playerid,COLOR_GREY,"   /radall [�����(1-12)]   /radpl [�� ������] [�����(1-12)]");
		SendClientMessage(playerid,COLOR_GREY," -------------------------------------------------------------------------------- ");

		new soob11[512];
		format(soob11, sizeof(soob11), "/radhelp - ������ �� �����\
		\n/radon [�����(1-12)] - �������� �����\
		\n/radoff - ��������� �����\
		\n/radall [�����(1-12)] - �������� ����� ���� �������");
		new soob12[512];
		format(soob12, sizeof(soob12), "\n/radpl [�� ������] [�����(1-12)] - �������� ����� ���������� ������\
		\n\
		\n	������ �����:\
		\n1 - Zaycev-FM");
		new soob13[512];
		format(soob13, sizeof(soob13), "\n2 - ������ +\
		\n3 - �������������� 90-�\
		\n4 - ���� �����\
		\n5 - ������� �����");
		new soob14[512];
		format(soob14, sizeof(soob14), "\n6 - ���������\
		\n7 - Radio Record\
		\n8 - Dubstep\
		\n9 - Club");
		new soob15[512];
		format(soob15, sizeof(soob15), "\n10 - ������ FM\
		\n11 - ��� FM\
		\n12 - Radio Xtreme");
		new soob[2560];
		format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
		ShowPlayerDialog(playerid, 2, 0, "������ �� �����", soob, "OK", "");

    	return 1;
	}
	if (strcmp(cmd,"/radall",true) == 0)
    {
		if(GetPVarInt(playerid, "AdmLvl") >= 3 || IsPlayerAdmin(playerid))
        {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " �����������: /radall [�����(1-12)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 1 || para1 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ����� ��� !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if((GetPVarInt(playerid, "AdmLvl") == 3 && GetPVarInt(i, "AdmLvl") <= 3) || GetPVarInt(playerid, "AdmLvl") >= 4)
					{
						NRadio[i] = para1;//����� ������������� �����
						StopAudioStreamForPlayer(i);//�������� ����� ������ �����
						PlayAudioStreamForPlayer(i, STRadio[para1]);//��������� ����� � �������
						format(string, sizeof(string), " *** ������������� %s ������� ���� ����� %s ( ��� ���������� ������� /radoff )", pname, NMRadio[para1]);
						SendClientMessage(i, COLOR_GREY, string);
					}
					if(GetPVarInt(i, "AdmLvl") >= 4 && i != playerid)
					{
						format(string, sizeof(string), " *** ������������� %s ������� ���� ����� %s", pname, NMRadio[para1]);
						SendClientMessage(i, COLOR_GREY, string);
					}
				}
			}
			printf("[radio] A���� %s ������� ���� ����� %s .", aa333, NMRadio[para1]);//��������� ��� ������������� ������� �����
//			printf("[radio] A���� %s ������� ���� ����� %s .", pname, NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
	    return 1;
    }
	if (strcmp(cmd,"/radpl",true) == 0)
    {
		if(GetPVarInt(playerid, "AdmLvl") >= 3 || IsPlayerAdmin(playerid))
        {
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " �����������: /radpl [�� ������] [�����(1-12)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
				return 1;
			}
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� �������� ����� ������ ����, �����������: /radon !");
				return 1;
			}
			if(GetPVarInt(playerid, "AdmLvl") == 3 && GetPVarInt(para1, "AdmLvl") >= 4)
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ����� ������ 4-�� ������ !");
				return 1;
			}
    		new targetname[MAX_PLAYER_NAME];
			GetPlayerName(para1,targetname,sizeof(pname));
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �����(1-12) !");
				return 1;
			}
			new para2 = strval(tmp);
			if(para2 < 1 || para2 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ����� ��� !");
				return 1;
			}
			NRadio[para1] = para2;//����� ������������� �����
			StopAudioStreamForPlayer(para1);//�������� ����� ������ �����
			PlayAudioStreamForPlayer(para1, STRadio[para2]);//��������� ����� � �������
			format(string, sizeof(string), " *** ������������� %s ������� ��� ����� %s ( ��� ���������� ������� /radoff )", pname, NMRadio[para2]);
			SendClientMessage(para1, COLOR_GREY, string);
			format(string, sizeof(string), " *** ������������� %s ������� ������ %s ����� %s", pname, targetname, NMRadio[para2]);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
 					if((GetPVarInt(i, "AdmLvl") >= 1 || IsPlayerAdmin(i)) && i != para1)
   					{
						SendClientMessage(i, COLOR_GREY, string);
					}
				}
			}
			new aa222[64];//��������� ��� ������������� ������� �����
			format(aa222, sizeof(aa222), "%s", targetname);//��������� ��� ������������� ������� �����
			printf("[radio] A���� %s ������� ������ %s ����� %s .", aa333, aa222, NMRadio[para2]);//��������� ��� ������������� ������� �����
//			printf("[radio] A���� %s ������� ������ %s ����� %s .", pname, targetname, NMRadio[para2]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
	    return 1;
    }
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 2)
    {
		return 1;
	}
	return 0;
}


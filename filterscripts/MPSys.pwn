#include <a_samp>

//==============================================================================
//                            ��������� �������
//==============================================================================

#define FS11INS 1 //��������� ������ �������:
//                 //FS11INS 0 - ������ 0.3z � ����
//                 //FS11INS 1 - ������ 0.3.7 � ����

#define FS22INS 2 //��� �������:
//                //FS22INS 1 - ����������� ������
//                //FS22INS 2 - Drift + DM ������ �� [Gn_R],
//                //            ��� ��������� RDS ������� �� [Gn_R]
//                //FS22INS 3 - Drift non-DM ������ �� [Gn_R]


#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

//   �������� !!! ����� ��������� �������� ����������� ��������������� !!!

//------------------------------------------------------------------------------

//   �������� !!! ���� � ���� ���� �������� ������ ����������, �� ����� ���������
//   ������ ���������� (� ����) ���������� �������� ������:

//		new carplay = GetPlayerVehicleID(playerid);
//		if(CallRemoteFunction("mpsysvehfunc", "d", carplay) != 0)//������ �� ���������� �� ������� ��
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " ������ ! ��� ��������� ������� �� !");
//			return 1;
//		}

//   ��� �� ��������� ����������� �������� ���������� ������� �� !!!

//------------------------------------------------------------------------------

//   �������� !!! ��� �� ��������� ������� ���� �������, ����� �� ����������� ������
//   (� ����) �������� ������:

//		if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//������ ������� ��������� �� ������� ��
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " � ������� �� ������� �� �������� !");
//			return 1;
//		}

//------------------------------------------------------------------------------

//   �������� !!! ��� �� ��������� ���� ���� �������, ����� �� ������� ������ ��������
//   ���� "ShowPlayerDialog" (� ����, � ������� "OnPlayerKeyStateChange") �������� ������:

//		if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//������ ������� ��������� �� ������� ��
//		{
//			SendClientMessage(playerid, 0xFF0000FF, " � ������� �� ������� ���� �� �������� !");
//			return 1;
//		}

//==============================================================================

//==============================================================================

#if (FS11INS < 0)
	#undef FS11INS
	#define FS11INS 0
#endif
#if (FS11INS > 1)
	#undef FS11INS
	#define FS11INS 1
#endif
#if (FS22INS < 1)
	#undef FS22INS
	#define FS22INS 1
#endif
#if (FS22INS > 3)
	#undef FS22INS
	#define FS22INS 3
#endif

#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GREEN 0x00FF00FF
#define COLOR_RED 0xFF0000FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_BIR 0x00FFFFFF

#if (FS22INS > 1)
	forward EndPlCRTp(playerid);//���������� ���������� �������� ��������� (������ ��� ����� �� [Gn_R])
#endif
forward OneSec();//��������� ������
forward SendMPMessage(mpid, color, string[]);//��������� ������ ��

new dlgcont[MAX_PLAYERS];//�������� �� �������
new onesectimer;//���������� �������
new mpstate[MAX_PLAYERS];//�� �� ������
new mpint[MAX_PLAYERS];//�� ��������� ������
new mpvw[MAX_PLAYERS];//�� ������������ ���� ������
new Float:cormp[MAX_PLAYERS][3];//���������� �� � ���� ��
new permis[MAX_PLAYERS];//���������� �� �� �� 0- �� ��������� ��, 1- ��������� ��
new mpcount[MAX_PLAYERS];//����� ���������� ��
new mpcount22[MAX_PLAYERS];//�������� ���������� ��
new mpcarid[MAX_PLAYERS];//��������� ��������� ��
new mpfreez[MAX_PLAYERS];//��������� ������
new retint[MAX_PLAYERS];//�������� �������� �� �������� �����
new Float:corpl[MAX_PLAYERS][3];//���������� �������� �� �������� �����
new skinpl[MAX_PLAYERS];//���� ������
new mapcolpl[MAX_PLAYERS];//���� ������� ������
new countdown[MAX_PLAYERS];//���������� ��������� �������
new pnotice[MAX_PLAYERS];//�������������� ������ � ��
new anotice[MAX_PLAYERS];//�������������� ������ � ��
new timstop[MAX_PLAYERS];//��������� �������� ���������� (� �������� ���������� /mptp ��� �������)
new mpidpara1[MAX_PLAYERS];//�� ���������� (����� ������ ����)
new mpidpara2[MAX_PLAYERS];
new mpidpara3[MAX_PLAYERS][64];
new paraexit;//���������� �������� �������

//---------------- ������ ����������� ������� SetPlayerSkin --------------------
//-------------------- �� � �������� S_SetPlayerSkin --------------------------
stock S_SetPlayerSkin(const playerid, const skinid)
{
	if(paraexit == 0)//���� ���� �������� �������, ��:
	{
		ClearAnimations(playerid);//������ ������ ���� � ���������
		TogglePlayerControllable(playerid, 0);//���������� ������
		SetTimerEx("S22_SetPlayerSkin", 2000, 0, "ii", playerid, skinid);
	}
	else//�����:
	{
		SetPlayerSkin(playerid, skinid);
	}
	return 1;
}
forward S22_SetPlayerSkin(playerid, skinid);
public S22_SetPlayerSkin(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
	if(mpfreez[playerid] == 0)//���� ����� �� ��� ���������, ��:
	{
		TogglePlayerControllable(playerid, 1);//����������� ������
	}
	return 1;
}
#define SetPlayerSkin S_SetPlayerSkin
//------------------------------------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("         Filterscript MPSys             ");
	print("--------------------------------------\n");

	paraexit = 0;//���������� �������� �������
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
#if (FS22INS > 1)
		SetPVarInt(i, "CComAc10", 0);
		SetPVarInt(i, "PlCRTp", 0);
		SetPVarInt(i, "PlConRep", 0);//�������� ����������
#endif
		mpstate[i] = -600;//������� �� �� ������
		mpint[i] = -600;//������� �� ��������� ������
		mpvw[i] = -600;//������� �� ������������ ���� ������
		permis[i] = 0;//��������� �� �� ��
		mpcount[i] = 0;//������� ����� ���������� ��
		mpcount22[i] = 0;//������� ��������� ���������� ��
		mpcarid[i] = -600;//������� ���������� ��������� ��
		mpfreez[i] = 0;//������� ��������� ������
		countdown[i] = -1;//������� ��������� �������
		pnotice[i] = 0;//������� �������������� ������
		anotice[i] = 0;//������� �������������� ������
		timstop[i] = 0;//������� ��������� �������� ����������
	}
	onesectimer = SetTimer("OneSec", 987, 1);
	return 1;
}

public OnFilterScriptExit()
{
	paraexit = 1;//���������� �������� �������
	new para1 = 0;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(mpstate[i] != -600)
			{
				para1 = 1;
#if (FS22INS == 1)
	 			SetPlayerInterior(i, retint[i]);
				SetPlayerVirtualWorld(i, 0);
				SetPlayerPos(i, corpl[i][0], corpl[i][1], corpl[i][2]);
				SetCameraBehindPlayer(i);
#endif
#if (FS22INS > 1)
				if(GetPVarInt(i, "SecPris") == 0)//���� ����� �� ����� � ������, ��:
				{
					SetPVarInt(i, "PlCRTp", 1);
					SetTimerEx("EndPlCRTp", 3000, 0, "i", i);
	 				SetPlayerInterior(i, retint[i]);
					SetPlayerVirtualWorld(i, 0);
					SetPlayerPos(i, corpl[i][0], corpl[i][1], corpl[i][2]);
					SetCameraBehindPlayer(i);
				}
#endif
				if(mpfreez[i] == 1)//���� ����� ���������, ��:
				{
					TogglePlayerControllable(i, 1);//����������� ������
				}
				if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
				{
					DestroyVehicle(mpcarid[i]);//������� ���������
				}
   				for(new j = 0; j < MAX_PLAYERS; j++)//���������� ������ ����� �������
				{
					SetPlayerMarkerForPlayer(j, i, mapcolpl[i]);
				}
				SetPlayerSkin(i, skinpl[i]);//���������� ������ ����
			}
#if (FS22INS > 1)
			DeletePVar(i, "CComAc10");
			DeletePVar(i, "PlCRTp");
			DeletePVar(i, "PlConRep");//������� ���������� ���������� �����������
#endif
			mpstate[i] = -600;//������� �� �� ������
			mpint[i] = -600;//������� �� ��������� ������
			mpvw[i] = -600;//������� �� ������������ ���� ������
			permis[i] = 0;//��������� �� �� ��
			mpcount[i] = 0;//������� ����� ���������� ��
			mpcount22[i] = 0;//������� ��������� ���������� ��
			mpcarid[i] = -600;//������� ���������� ��������� ��
			mpfreez[i] = 0;//������� ��������� ������
			countdown[i] = -1;//������� ��������� �������
			pnotice[i] = 0;//������� �������������� ������
			anotice[i] = 0;//������� �������������� ������
			timstop[i] = 0;//������� ��������� �������� ����������
		}
	}
	if(para1 == 1)
	{
		SendClientMessageToAll(COLOR_RED, " ��� ����������� ���� ��������� ! (�������� ������� �����������) !");
		print("[MPSys] ��� ����������� ���� ��������� ! (�������� �������) !");
	}
	KillTimer(onesectimer);
	paraexit = 0;//���������� �������� �������
	return 1;
}

public OnPlayerConnect(playerid)
{
#if (FS22INS > 1)
	SetPVarInt(playerid, "CComAc10", 0);
	SetPVarInt(playerid, "PlCRTp", 0);
	SetPVarInt(playerid, "PlConRep", 0);//�������� ����������
#endif
	mpstate[playerid] = -600;//������� �� �� ������
	mpint[playerid] = -600;//������� �� ��������� ������
	mpvw[playerid] = -600;//������� �� ������������ ���� ������
	permis[playerid] = 0;//��������� �� �� ��
	mpcount[playerid] = 0;//������� ����� ���������� ��
	mpcount22[playerid] = 0;//������� ��������� ���������� ��
	mpcarid[playerid] = -600;//������� ���������� ��������� ��
	mpfreez[playerid] = 0;//������� ��������� ������
	countdown[playerid] = -1;//������� ��������� �������
	pnotice[playerid] = 0;//������� �������������� ������
	anotice[playerid] = 0;//������� �������������� ������
	timstop[playerid] = 0;//������� ��������� �������� ����������
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
#if (FS22INS > 1)
	DeletePVar(playerid, "CComAc10");
	DeletePVar(playerid, "PlCRTp");
	DeletePVar(playerid, "PlConRep");//������� ���������� ���������� �����������
#endif
	if(mpstate[playerid] == playerid)
	{
		if(permis[playerid] == 1)//���� ��������� �� �� ��, ��:
		{
			permis[playerid] = 0;//��������� �� �� ��
			timstop[playerid] = 1;//������������ ��������� �������� ����������
		}
		else
		{
			timstop[playerid] = 0;//������� ��������� �������� ����������
		}
		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " ������������� %s [%d] �������� ����������� ! (����� � �������) !", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		printf("[MPSys] ������������� %s [%d] �������� ����������� (ID: %d VW: %d) (����� � �������)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ������������� %s [%d] �������� ����������� (ID: %d VW: %d) (����� � �������)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
	}
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid)
	{
		if(mpcarid[playerid] != -600)//���� ���� ��������� � ��������� ��, ��:
		{
			DestroyVehicle(mpcarid[playerid]);//������� ���������
		}
		mpcount[mpstate[playerid]]--;//����� ���������� �� -1
		timstop[playerid] = 0;//��������� �������� ���������� /mptp
		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " ����� %s [%d] ����� �� �����������. (����� � �������) !", sendername, playerid);
		SendMPMessage(mpstate[playerid], COLOR_RED, string);
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		printf("[MPSys] ����� %s [%d] ����� �� ����������� (ID: %d VW: %d) (����� � �������)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ����� %s [%d] ����� �� ����������� (ID: %d VW: %d) (����� � �������)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
	}
	mpstate[playerid] = -600;//������� �� �� ������
	mpint[playerid] = -600;//������� �� ��������� ������
	mpvw[playerid] = -600;//������� �� ������������ ���� ������
	permis[playerid] = 0;//��������� �� �� ��
	mpcount[playerid] = 0;//������� ����� ���������� ��
	mpcount22[playerid] = 0;//������� ��������� ���������� ��
	mpcarid[playerid] = -600;//������� ���������� ��������� ��
	mpfreez[playerid] = 0;//������� ��������� ������
	countdown[playerid] = -1;//������� ��������� �������
	pnotice[playerid] = 0;//������� �������������� ������
	anotice[playerid] = 0;//������� �������������� ������
	return 1;
}

public SendMPMessage(mpid, color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(mpstate[i] == mpid)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
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
#if (FS22INS > 1)
	SetPVarInt(playerid, "CComAc10", GetPVarInt(playerid, "CComAc10") + 1);
#endif
	new idx;
	idx = 0;
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	cmd = strtok(cmdtext, idx);
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(strcmp(cmd, "/mphelp", true) == 0)
	{
		SendClientMessage(playerid, COLOR_BIR, " -------------------------------- ������� ������� �� --------------------------------");
		SendClientMessage(playerid, COLOR_BIR, "         ��� ����������:");
		SendClientMessage(playerid, COLOR_BIR, " /mphelp - ������ �� �������� ������� ��   /mpc [�����] - ��� ��");
		SendClientMessage(playerid, COLOR_BIR, " /mptp [�� ��] - ������������ � ��   /mpexit - ����� �� ��");
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			SendClientMessage(playerid, COLOR_BIR, "         ��� �������������:");
			SendClientMessage(playerid, COLOR_BIR, " /mpcreate [��� ��] [�������� ����������] - ������������ ��");
			SendClientMessage(playerid, COLOR_BIR, " /mpsend - ���� ��������� ���������� � ��");
			SendClientMessage(playerid, COLOR_BIR, " /mpmenu - ������� ���� ��");
			SendClientMessage(playerid, COLOR_BIR, " /mpkick [�� ������] - ������� ������ �� ��");
			SendClientMessage(playerid, COLOR_BIR, " /mpret - ��������� �� ��   /mpend - ��������� ��");
		}
		SendClientMessage(playerid,COLOR_BIR," ---------------------------------------------------------------------------------------------------");
		return 1;
	}
	if(strcmp(cmd, "/mpc", true) == 0)
	{
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "SecMute") > 0)
		{
			SendClientMessage(playerid, COLOR_RED, " �� �� ������ ��������, ��� �������� !");
			return 1;
		}
#endif
		if(mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � ������������� ��� ���������� �� !");
			return 1;
		}
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[128];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /mpc [�����]");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		if(mpstate[playerid] == playerid)
		{
			printf(" <MPC> ����������� %s [%d]: %s", aa333, playerid, result);//��������� ��� ������������� ������� �����
//			printf(" <MPC> ����������� %s [%d]: %s", sendername, playerid, result);
			format(string, sizeof(string), " <MPC> ����������� %s [%d]: {FFFFFF}%s", sendername, playerid, result);
		}
		else
		{
			printf(" <MPC> �������� %s [%d]: %s", aa333, playerid, result);//��������� ��� ������������� ������� �����
//			printf(" <MPC> �������� %s [%d]: %s", sendername, playerid, result);
			format(string, sizeof(string), " <MPC> �������� %s [%d]: {FFFFFF}%s", sendername, playerid, result);
		}
		SendMPMessage(mpstate[playerid], COLOR_YELLOW, string);
		return 1;
	}
	if(strcmp(cmd, "/mptp", true) == 0)
	{
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "SecPris") > 0)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ������� �� �������� !");
			return 1;
		}
#endif
//		if(GetPlayerInterior(playerid) != 0 || playvw != 0 || mpstate[playerid] == playerid)
		if(GetPlayerInterior(playerid) != 0 || playvw != 0 || mpstate[playerid] == playerid || mpstate[playerid] != -600)
		{
//			SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ �� �������� ����� ! � ������, ���� �� �������� �� !");
			SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ �� �������� ����� ! � ������, ���� �� �� �������� �� !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /mptp [�� ��]");
			return 1;
		}
		new para1;
		para1 = strval(tmp);
		if(para1 < 0 || para1 > (MAX_PLAYERS - 2))
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ��] �� ������� �� ������� !");
			return 1;
		}
		if(mpstate[para1] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ��] �� ������� �� ������� !");
			return 1;
		}
		if(mpstate[playerid] != -600 && mpstate[playerid] != para1)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� [�� ��] �� ��� ! ��������� �� ��� �� !");
			return 1;
		}
		if(mpstate[para1] == para1 && permis[para1] == 0 && mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " ����� [�� ��] �� ������� ������, �� �� ���� ������ ��� ��� !");
			return 1;
		}
		if(mpstate[para1] == para1 && mpcount[para1] >= mpcount22[para1] && mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " ����� [�� ��] �� ������� ������, �� ��� ������� �����������");
			SendClientMessage(playerid, COLOR_RED, " ���������� ���������� �� !");
			return 1;
		}
		if(timstop[playerid] == 0)//���� �������� �������� ���������� /mptp , ��:
		{
			mpstate[playerid] = para1;//���������� �� �� ������
			mpvw[playerid] = mpvw[para1];//���������� �� ������������ ���� ������
			skinpl[playerid] = GetPlayerSkin(playerid);//���������� ����� ������
			mapcolpl[playerid] = GetPlayerColor(playerid);//���������� ����� ������� ������
			mpcount[para1]++;//����� ���������� �� +1
			SetPVarInt(playerid, "PlConRep", 0);//�������� ����������
		}
		retint[playerid] = 0;//���������� ��������� �������� �� �������� �����
		GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//���������� ��������� �������� �� �������� �����
		if(timstop[playerid] == 0)//���� �������� �������� ���������� /mptp , ��:
		{
			new Float:cx, Float:cy, Float:cz;
			GetPlayerPos(para1, cx, cy, cz);//������ ���������� ������ � ���� ��
			cormp[playerid][0] = cx+3;//��������� ���������� �� � ���� ��
			cormp[playerid][1] = cy+3;
			cormp[playerid][2] = cz+1;
		}
		timstop[playerid] = 0;//��������� �������� ���������� /mptp
		TPmp(playerid, mpint[para1], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//�� ������ � ��� ��
		pnotice[playerid] = 0;//������� �������������� ������
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(mpstate[playerid], giveplayer, sizeof(sendername));
		format(string, sizeof(string), " �� ����������������� �� �����������, ������� ����������� ������������� %s", giveplayer);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		SendClientMessage(playerid, COLOR_YELLOW, " ��� ������ �� ����������� - ������� {00FF00}/mpexit");
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		new aa444[64];//��������� ��� ������������� ������� �����
		format(aa444, sizeof(aa444), "%s", giveplayer);//��������� ��� ������������� ������� �����
		printf("[MPSys] ����� %s [%d] ���������������� �� ����������� ( ������������� %s )", aa333, playerid, aa444);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ����� %s [%d] ���������������� �� ����������� ( ������������� %s )", sendername, playerid, giveplayer);
		return 1;
	}
	if(strcmp(cmd, "/mpexit", true) == 0)
	{
		if(playvw != mpvw[playerid]+2000 || mpstate[playerid] == playerid || mpstate[playerid] == -600)
		{
			SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ �� �� ! � ������ � ���������� �� !");
			return 1;
		}
		new para3 = mpstate[playerid];
		mpstate[playerid] = -600;//������� �� �� ������
		mpvw[playerid] = -600;//������� �� ������������ ���� ������
		if(countdown[playerid] != -1) { countdown[playerid] = -1; }//���������� �������� ������
		mpcount[para3]--;//����� ���������� �� -1
		SetPVarInt(playerid, "PlConRep", 0);//�������� ����������
		timstop[playerid] = 0;//��������� �������� ���������� /mptp
		if(mpcarid[playerid] != -600)//���� ���� ��������� � ��������� ��, ��:
		{
			DestroyVehicle(mpcarid[playerid]);//������� ���������
			mpcarid[playerid] = -600;//������� ���������� ��������� ��
		}
		if(mpfreez[playerid] == 1)//���� ����� ���������, ��:
		{
			TogglePlayerControllable(playerid, 1);//����������� ������
			mpfreez[playerid] = 0;//������� ��������� ������
		}
		SetPlayerVirtualWorld(playerid, 0);//����� ������ 0-� ����������� ��� (��� �� ����������� ��������� ������ ��)
		TPmp(playerid, retint[playerid], 0, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//�� �� �������� �����
		SetPlayerSkin(playerid, skinpl[playerid]);//���������� ������ ����
   		for(new i = 0; i < MAX_PLAYERS; i++)//���������� ������ ����� �������
		{
			SetPlayerMarkerForPlayer(i, playerid, mapcolpl[playerid]);
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(para3, giveplayer, sizeof(sendername));
		format(string, sizeof(string), " ����� %s [%d] ����� �� �����������.", sendername, playerid);
		SendMPMessage(mpstate[playerid], COLOR_RED, string);
		SendClientMessage(playerid, COLOR_RED, " �� ����� �� �����������.");
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		new aa444[64];//��������� ��� ������������� ������� �����
		format(aa444, sizeof(aa444), "%s", giveplayer);//��������� ��� ������������� ������� �����
		printf("[MPSys] ����� %s [%d] ����� �� ����������� ( ������������� %s )", aa333, playerid, aa444);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ����� %s [%d] ����� �� ����������� ( ������������� %s )", sendername, playerid, giveplayer);
		return 1;
	}
	if(strcmp(cmd, "/mpcreate", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
		{
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			if(GetPVarInt(playerid, "SecPris") > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ������� �� �������� !");
				return 1;
			}
#endif
			if(playvw != 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ �� �������� ����� !");
				return 1;
			}
			if(mpstate[playerid] == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ��� ��������� �� ! � �� ������ ������������ ������ �� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /mpcreate [��� ��(0-989)] [�������� ����������(1-40)]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 989)
			{
				SendClientMessage(playerid, COLOR_RED, " ��� �� �� 0 �� 989 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /mpcreate [��� ��(0-989)] [�������� ����������(1-40)] !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 40)
			{
				SendClientMessage(playerid, COLOR_RED, " �������� ���������� �� 1 �� 40 !");
				return 1;
			}
			mpstate[playerid] = playerid;//���������� �� �� ������
			mpint[playerid] = GetPlayerInterior(playerid);//���������� �� ��������� ������
			mpvw[playerid] = para1;//���������� �� ������������ ���� ������
			skinpl[playerid] = GetPlayerSkin(playerid);//���������� ����� ������
			mapcolpl[playerid] = GetPlayerColor(playerid);//���������� ����� ������� ������
			retint[playerid] = mpint[playerid];//���������� ��������� �������� �� �������� �����
			GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//���������� ��������� �������� �� �������� �����
			cormp[playerid][0] = corpl[playerid][0];//��������� ���������� �� � ���� ��
			cormp[playerid][1] = corpl[playerid][1];
			cormp[playerid][2] = corpl[playerid][2];
			TPmp(playerid, mpint[playerid], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//�� ������ � ��� ��
			permis[playerid] = 1;//��������� �� �� ��
			mpcount[playerid] = 0;//������� ����� ���������� ��
			mpcount22[playerid] = para2;//�������� ���������� ��
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " ������������� %s [%d] ����������� �����������, �� ������ �������� 60 ������,", sendername, playerid);
			SendClientMessageToAll(COLOR_GREEN, string);
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] ����������� ����������� (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] ����������� ����������� (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
			format(string, sizeof(string), " ��� �� ����������������� �� ����������� - ������� {FFFF00}/mptp %d", mpstate[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
			SetTimerEx("MPStart1", 20000, 0, "d", playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpsend", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � �������������� ���� �� !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
				return 1;
			}
			if(mpcount[playerid] >= mpcount22[playerid])
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��� ������� ����������� ����������");
				SendClientMessage(playerid, COLOR_RED, " ���������� �� !");
				return 1;
			}
			permis[playerid] = 1;//��������� �� �� ��
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " ������������� %s [%d] ����������� �����������, �� ������ �������� 60 ������,", sendername, playerid);
			SendClientMessageToAll(COLOR_GREEN, string);
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] ��� ��������� ���������� � ����������� (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] ��� ��������� ���������� � ����������� (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
			format(string, sizeof(string), " ��� �� ����������������� �� ����������� - ������� {FFFF00}/mptp %d", mpstate[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
			SetTimerEx("MPStart1", 20000, 0, "d", playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpmenu", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � �������������� ���� �� !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
				return 1;
			}
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpkick", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � �������������� ���� �� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /mpkick [�� ������]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������ ������� �� �� ������ ���� !");
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
				return 1;
			}
			if(mpstate[para1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� [�� ������] �� ��������� � ����� �� !");
				return 1;
			}
			mpstate[para1] = -600;//������� �� �� ������
			mpvw[para1] = -600;//������� �� ������������ ���� ������
			if(countdown[para1] != -1) { countdown[para1] = -1; }//���������� �������� ������
			mpcount[mpstate[playerid]]--;//����� ���������� �� -1
			SetPVarInt(para1, "PlConRep", 0);//�������� ����������
			timstop[para1] = 0;//��������� �������� ���������� /mptp
			if(mpcarid[para1] != -600)//���� ���� ��������� � ��������� ��, ��:
			{
				DestroyVehicle(mpcarid[para1]);//������� ���������
				mpcarid[para1] = -600;//������� ���������� ��������� ��
			}
			if(mpfreez[para1] == 1)//���� ����� ���������, ��:
			{
				TogglePlayerControllable(para1, 1);//����������� ������
				mpfreez[para1] = 0;//������� ��������� ������
			}
			if(GetPlayerVirtualWorld(para1) == mpvw[playerid]+2000)//���� ����� ��������� � ���� ��, ��:
			{
				SetPlayerVirtualWorld(para1, 0);//����� ������ 0-� ����������� ��� (��� �� ����������� ��������� ������ ��)
				TPmp(para1, retint[para1], 0, corpl[para1][0], corpl[para1][1], corpl[para1][2]);//�� �� �������� �����
			}
			SetPlayerSkin(para1, skinpl[para1]);//���������� ������ ����
   			for(new i = 0; i < MAX_PLAYERS; i++)//���������� ������ ����� �������
			{
				SetPlayerMarkerForPlayer(i, para1, mapcolpl[para1]);
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(para1, giveplayer, sizeof(sendername));
			format(string, sizeof(string), " ������������� %s [%d] ������ ������ %s [%d] �� ����������� !", sendername, playerid, giveplayer, para1);
			SendMPMessage(mpstate[playerid], COLOR_RED, string);
			SendClientMessage(para1, COLOR_RED, string);
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			new aa444[64];//��������� ��� ������������� ������� �����
			format(aa444, sizeof(aa444), "%s", giveplayer);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] ������ ������ %s [%d] �� ����������� (ID: %d VW: %d)", aa333, playerid, aa444, para1, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] ������ ������ %s [%d] �� ����������� (ID: %d VW: %d)", sendername, playerid, giveplayer, para1, mpstate[playerid], mpvw[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpret", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
		{
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
		{
			if(GetPVarInt(playerid, "SecPris") > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ������� �� �������� !");
				return 1;
			}
#endif
			if(playvw != 0 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ �� �������� ����� !");
				SendClientMessage(playerid, COLOR_RED, " � ������, ���� �� ����������� �� !");
				return 1;
			}
			retint[playerid] = GetPlayerInterior(playerid);//���������� ��������� �������� �� �������� �����
			GetPlayerPos(playerid, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//���������� ��������� �������� �� �������� �����
			TPmp(playerid, mpint[playerid], mpvw[playerid]+2000, cormp[playerid][0], cormp[playerid][1], cormp[playerid][2]);//�� ������ � ��� ��
			anotice[playerid] = 0;//������� �������������� ������
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " ������������� %s [%d] �������� �� �����������.", sendername, playerid);
			SendMPMessage(mpstate[playerid], COLOR_YELLOW, string);
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] �������� �� ����������� (ID: %d VW: %d)", aa333, playerid, mpstate[playerid], mpvw[playerid]);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] �������� �� ����������� (ID: %d VW: %d)", sendername, playerid, mpstate[playerid], mpvw[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mpend", true) == 0)
	{
#if (FS22INS == 1)
		if(IsPlayerAdmin(playerid))
#endif
#if (FS22INS > 1)
		if(GetPVarInt(playerid, "AdmLvl") >= 1 || IsPlayerAdmin(playerid))
#endif
		{
			if(playvw != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � �������������� ���� �� !");
				return 1;
			}
			if(permis[playerid] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
				return 1;
			}
			new para3 = mpstate[playerid];
			new para4 = mpvw[playerid];
			mpstate[playerid] = -600;//������� �� �� ������
			mpvw[playerid] = -600;//������� �� ������������ ���� ������
			if(countdown[playerid] != -1) { countdown[playerid] = -1; }//���������� �������� ������
			mpcount[playerid] = 0;//������� ����� ���������� ��
			mpcount22[playerid] = 0;//������� ��������� ���������� ��
			TPmp(playerid, retint[playerid], 0, corpl[playerid][0], corpl[playerid][1], corpl[playerid][2]);//�� �� �������� �����
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), " ������������� %s [%d] �������� ����������� !", sendername, playerid);
			SendClientMessageToAll(COLOR_RED, string);
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] �������� ����������� (ID: %d VW: %d)", aa333, playerid, para3, para4);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] �������� ����������� (ID: %d VW: %d)", sendername, playerid, para3, para4);
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
	if(dialogid == 700)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
/*
			if(listitem == 0)//���� �������
			{
				ShowPlayerDialog(playerid, 701, 2, "���� �������.", "������\n������ ��� ������\n��������� �������\n���\
				\n����������� ����\n������\n���\n������\n���������\n����� ������\n������\n��������� � �������\n������������\
				\n�����������\n�������", "��", "������");
				dlgcont[playerid] = 701;
				return 1;
			}
*/
#if (FS22INS < 3)
			if(listitem == 0)//���� ������� ��� ������
			{
				ShowPlayerDialog(playerid, 702, 2, "���� ������� ��� ������.", "����������� ����\n������\n������\n���������\
				\n�������\n������������ ���\n�������� ��������\n��������\n�������� � ����������\n������ ����\n��������\n�����\
				\nSPAZ 12\n���\nMP5\n��-47\n�4\nTes9\n��������\n����������� ��������\n����������", "�����", "������");
				dlgcont[playerid] = 702;
				return 1;
			}
			if(listitem == 1)//���� ������ ����)))
			{
				GivePlayerWeapon(playerid, 38, 1000);//��� ����� ������
				GivePlayerWeapon(playerid, 28, 500);
				GivePlayerWeapon(playerid, 26, 500);
				GivePlayerWeapon(playerid, 24, 500);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " �� ������ ���� ������.");
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ����� ���� ������.", aa333, playerid);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ����� ���� ������.", sendername, playerid);
				return 1;
			}
#endif
#if (FS22INS == 3)
			if(listitem == 0)//���� �������
			{
				ShowPlayerDialog(playerid, 702, 2, "���� �������.", "�����������\n����� ������\n�������", "�����", "������");
				dlgcont[playerid] = 702;
				return 1;
			}
			if(listitem == 1)//���� �������� ����)))
			{
				GivePlayerWeapon(playerid, 43, 1000);//��� ����� ���������
				GivePlayerWeapon(playerid, 14, 1000);
				GivePlayerWeapon(playerid, 46, 1000);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " �� ������ ���� ��������.");
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ����� ���� ��������.", aa333, playerid);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ����� ���� ��������.", sendername, playerid);
				return 1;
			}
#endif
			if(listitem == 2)//��������� ����� � �����
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							SetPlayerHealth(i,100);//��������� ����� � �����
							SetPlayerArmour(i,100);
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] �������� ���������� ����������� ����� � �����.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] �������� ���������� ����������� ����� � �����.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] �������� ���������� ����������� ����� � �����.", sendername, playerid);
				}
				return 1;
			}
			if(listitem == 3)//��������� ����� � ����� ����)))
			{
				SetPlayerHealth(playerid,255);//��������� ����� � �����
				SetPlayerArmour(playerid,255);
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				SendClientMessage(playerid, COLOR_GREEN, " �� ��������� ���� ����� � �����.");
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] �������� ���� ����� � �����.", aa333, playerid);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] �������� ���� ����� � �����.", sendername, playerid);
				return 1;
			}
			if(listitem == 4)//�������� �������� � ������ (� ����)
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							ResetPlayerWeapons(i);//�������� ������ � ��������
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��� �� ������ ��������� ����������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] ������� � ���������� ����������� �������� � ������.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] ������� � ���������� ����������� �������� � ������.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] ������� � ���������� ����������� �������� � ������.", sendername, playerid);
				}
				return 1;
			}
			if(listitem == 5)//���� ���������
			{
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "�������� !!!\n\n������ ����������: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ��������� !!!\n\n������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
			if(listitem == 6)//�������� ��������� (� ����)
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
							{
								para1 = 1;
								DestroyVehicle(mpcarid[i]);//������� ���������
								mpcarid[i] = -600;
							}
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " �� � ������ ��������� ����������� ��� ���������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] ������� � ���������� ����������� ���������.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] ������� � ���������� ����������� ���������.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] ������� � ���������� ����������� ���������.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS > 1)
			if(listitem == 7)//��������� ���������� (����)
			{
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
							{
								SetPVarInt(i, "PlConRep", 1);//��������� ����������
							}
						}
					}
				}
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ������������� %s [%d] �������� ���������� ����������� ����������.", sendername, playerid);
				SendMPMessage(mpstate[playerid], COLOR_RED, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] �������� ���������� ����������� ����������.", aa333, playerid);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] �������� ���������� ����������� ����������.", sendername, playerid);
				return 1;
			}
			if(listitem == 8)//�������� ���������� (����)
			{
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
							{
								SetPVarInt(i, "PlConRep", 0);//�������� ����������
							}
						}
					}
				}
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ������������� %s [%d] ������� ���������� ����������� ����������.", sendername, playerid);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ������� ���������� ����������� ����������.", aa333, playerid);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ������� ���������� ����������� ����������.", sendername, playerid);
				return 1;
			}
#endif
#if (FS22INS == 1)
			if(listitem == 7)//��������� �������� ������
#endif
#if (FS22INS > 1)
			if(listitem == 9)//��������� �������� ������
#endif
			{
				ShowPlayerDialog(playerid, 707, 1, "��������� �������� ������.", "������� ����� ������ (�� 2 �� 12):", "��", "������");
				dlgcont[playerid] = 707;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 8)//������� ����
#endif
#if (FS22INS > 1)
			if(listitem == 10)//������� ����
#endif
			{
#if (FS11INS == 0)
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 299):", "��", "������");
#endif
#if (FS11INS == 1)
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 311):", "��", "������");
#endif
				dlgcont[playerid] = 708;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 9)//������� ���� �������
#endif
#if (FS22INS > 1)
			if(listitem == 11)//������� ���� �������
#endif
			{
				ShowPlayerDialog(playerid, 709, 2, "������� ���� �������.", "{FF0000}�������\n{BF3F00}����������\
				\n{FF7F00}���������\n{FFFF00}Ƹ����\n{00FF00}������\n{00FFFF}���������\n{00BFFF}�������\n{0000FF}�����\
				\n{7F00FF}����������\n{FF00FF}���������\n{7F7F7F}�����", "��", "������");
				dlgcont[playerid] = 709;
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 10)//����������
#endif
#if (FS22INS > 1)
			if(listitem == 12)//����������
#endif
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
							TogglePlayerControllable(i, 0);//���������� ������
							mpfreez[i] = 1;
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] ��������� ���������� �����������.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] ��������� ���������� �����������.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] ��������� ���������� �����������.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 11)//����������� (����)
#endif
#if (FS22INS > 1)
			if(listitem == 13)//����������� (����)
#endif
			{
				new para1 = 0;
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							if(mpfreez[i] == 1)//���� �������� �� ��� ���������, ��:
							{
								para1 = 1;
								TogglePlayerControllable(i, 1);//����������� ������
								mpfreez[i] = 0;
							}
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ���� �������� ����������� �� ��� ��������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] ���������� ���������� �����������.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] ���������� ���������� �����������.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] ���������� ���������� �����������.", sendername, playerid);
				}
				return 1;
			}
#if (FS22INS == 1)
			if(listitem == 12)//�� � ���� (� ������ ����������)
#endif
#if (FS22INS > 1)
			if(listitem == 14)//�� � ���� (� ������ ����������)
#endif
			{
				new para1 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para1 = 1;
#if (FS22INS == 1)
							SetPlayerInterior(i, playint);
							SetPlayerVirtualWorld(i, playvw);
							SetPlayerPos(i, X+3, Y+3, Z+1);
							SetCameraBehindPlayer(i);
#endif
#if (FS22INS > 1)
							if(GetPVarInt(i, "SecPris") == 0)//���� ����� �� ����� � ������, ��:
							{
								SetPVarInt(i, "PlCRTp", 1);
								SetTimerEx("EndPlCRTp", 3000, 0, "i", i);
								SetPlayerInterior(i, playint);
								SetPlayerVirtualWorld(i, playvw);
								SetPlayerPos(i, X+3, Y+3, Z+1);
								SetCameraBehindPlayer(i);
							}
#endif
						}
					}
				}
				if(para1 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��� �� ������ ��������� ����������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] �������������� � ���� ���� ���������� �����������.", sendername, playerid);
					SendMPMessage(mpstate[playerid], COLOR_RED, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] �������������� � ���� ���� ���������� �����������.", aa333, playerid);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] �������������� � ���� ���� ���������� �����������.", sendername, playerid);
				}
			}
		}
		return 1;
	}
/*
	if(dialogid == 701)//���� �������
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			new para1;
			if(listitem == 0) { para1 = 1; }
			if(listitem == 1) { para1 = 2; }
			if(listitem == 2) { para1 = 3; }
			if(listitem == 3) { para1 = 4; }
			if(listitem == 4) { para1 = 5; }
			if(listitem == 5) { para1 = 6; }
			if(listitem == 6) { para1 = 7; }
			if(listitem == 7) { para1 = 8; }
			if(listitem == 8) { para1 = 9; }
			if(listitem == 9) { para1 = 14; }
			if(listitem == 10) { para1 = 15; }
			if(listitem == 11) { para1 = 41; }
			if(listitem == 12) { para1 = 42; }
			if(listitem == 13) { para1 = 43; }
			if(listitem == 14) { para1 = 46; }
			new para2[256];
			switch(para1)
			{
				case 1: format(para2, sizeof(para2), "������");
				case 2: format(para2, sizeof(para2), "������ ��� ������");
				case 3: format(para2, sizeof(para2), "��������� �������");
				case 4: format(para2, sizeof(para2), "���");
				case 5: format(para2, sizeof(para2), "����������� ����");
				case 6: format(para2, sizeof(para2), "������");
				case 7: format(para2, sizeof(para2), "���");
				case 8: format(para2, sizeof(para2), "������");
				case 9: format(para2, sizeof(para2), "���������");
				case 14: format(para2, sizeof(para2), "����� ������");
				case 15: format(para2, sizeof(para2), "������");
				case 41: format(para2, sizeof(para2), "��������� � �������");
				case 42: format(para2, sizeof(para2), "������������");
				case 43: format(para2, sizeof(para2), "�����������");
				case 46: format(para2, sizeof(para2), "�������");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, para1, 1000);//��� ������� ��� ������
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ����� %s [%d] ��� ���������� ����������� %s .", sendername, playerid, para2);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ����� %s [%d] ��� ���������� ����������� %s .", aa333, playerid, para2);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ����� %s [%d] ��� ���������� ����������� %s .", sendername, playerid, para2);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� ������\n��������� ����� � �����\
			\n�������� �������� � ������ (� ����)\n���� ���������\n�������� ��������� (� ����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� ������\n��������� ����� � �����\
			\n�������� �������� � ������ (� ����)\n���� ���������\n�������� ��������� (� ����)\n��������� ���������� (����)\
			\n�������� ���������� (����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n��������� ����� � �����\
			\n�������� �������� (� ����)\n���� ���������\n�������� ��������� (� ����)\n��������� ���������� (����)\
			\n�������� ���������� (����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
*/
#if (FS22INS < 3)
	if(dialogid == 702)//���� ������� ��� ������ (1)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			if(listitem == 0) { mpidpara1[playerid] = 5; }
			if(listitem == 1) { mpidpara1[playerid] = 6; }
			if(listitem == 2) { mpidpara1[playerid] = 8; }
			if(listitem == 3) { mpidpara1[playerid] = 9; }

			if(listitem == 4) { mpidpara1[playerid] = 16; }
			if(listitem == 5) { mpidpara1[playerid] = 17; }
			if(listitem == 6) { mpidpara1[playerid] = 18; }
			if(listitem == 7) { mpidpara1[playerid] = 22; }
			if(listitem == 8) { mpidpara1[playerid] = 23; }
			if(listitem == 9) { mpidpara1[playerid] = 24; }
			if(listitem == 10) { mpidpara1[playerid] = 25; }
			if(listitem == 11) { mpidpara1[playerid] = 26; }
			if(listitem == 12) { mpidpara1[playerid] = 27; }
			if(listitem == 13) { mpidpara1[playerid] = 28; }
			if(listitem == 14) { mpidpara1[playerid] = 29; }
			if(listitem == 15) { mpidpara1[playerid] = 30; }
			if(listitem == 16) { mpidpara1[playerid] = 31; }
			if(listitem == 17) { mpidpara1[playerid] = 32; }
			if(listitem == 18) { mpidpara1[playerid] = 33; }
			if(listitem == 19) { mpidpara1[playerid] = 34; }
			if(listitem == 20) { mpidpara1[playerid] = 39; }
			switch(mpidpara1[playerid])
			{
				case 5: format(mpidpara3[playerid], 64, "����������� ����");
				case 6: format(mpidpara3[playerid], 64, "������");
				case 8: format(mpidpara3[playerid], 64, "������");
				case 9: format(mpidpara3[playerid], 64, "���������");

				case 16: format(mpidpara3[playerid], 64, "�������");
				case 17: format(mpidpara3[playerid], 64, "������������ ���");
				case 18: format(mpidpara3[playerid], 64, "�������� ��������");
				case 22: format(mpidpara3[playerid], 64, "��������");
				case 23: format(mpidpara3[playerid], 64, "�������� � ����������");
				case 24: format(mpidpara3[playerid], 64, "������ ����");
				case 25: format(mpidpara3[playerid], 64, "��������");
				case 26: format(mpidpara3[playerid], 64, "�����");
				case 27: format(mpidpara3[playerid], 64, "SPAZ 12");
				case 28: format(mpidpara3[playerid], 64, "���");
				case 29: format(mpidpara3[playerid], 64, "MP5");
				case 30: format(mpidpara3[playerid], 64, "��-47");
				case 31: format(mpidpara3[playerid], 64, "�4");
				case 32: format(mpidpara3[playerid], 64, "Tes9");
				case 33: format(mpidpara3[playerid], 64, "��������");
				case 34: format(mpidpara3[playerid], 64, "����������� ��������");
				case 39: format(mpidpara3[playerid], 64, "����������");
			}
			if(mpidpara1[playerid] < 16)
			{
				new para3 = 0;
				new Float: X, Float:Y, Float: Z, playint, playvw;
				GetPlayerPos(playerid, X, Y, Z);
				playint = GetPlayerInterior(playerid);
				playvw = GetPlayerVirtualWorld(playerid);
				for(new i = 0; i < MAX_PLAYERS ; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
						GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
						{
							para3 = 1;
							GivePlayerWeapon(i, mpidpara1[playerid], 1000);//��� ������� ��� ������
						}
					}
				}
				if(para3 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
				}
				else
				{
					new string[256];
					new sendername[MAX_PLAYER_NAME];
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� �� %s .", sendername, playerid, mpidpara3[playerid]);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					new aa333[64];//��������� ��� ������������� ������� �����
					format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s .", aa333, playerid, mpidpara3[playerid]);//��������� ��� ������������� ������� �����
//					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s .", sendername, playerid, para2);
				}
			}
			else
			{
				new string[256];
				format(string, sizeof(string), "������: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "������� ����� ���� (������� ��� ��������)\n(�� 1 �� 50000):", "��", "������");
				dlgcont[playerid] = 703;
			}
		}
#endif
#if (FS22INS == 1)
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS == 2)
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS == 3)
	if(dialogid == 702)//���� �������
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			if(listitem == 0) { mpidpara1[playerid] = 43; }
			if(listitem == 1) { mpidpara1[playerid] = 14; }
			if(listitem == 2) { mpidpara1[playerid] = 46; }
			switch(mpidpara1[playerid])
			{
				case 43: format(mpidpara3[playerid], 64, "������������");
				case 14: format(mpidpara3[playerid], 64, "������ ������");
				case 46: format(mpidpara3[playerid], 64, "��������");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, mpidpara1[playerid], 1000);//��� ������� ��� ������
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� �� %s .", sendername, playerid, mpidpara3[playerid]);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s .", aa333, playerid, mpidpara3[playerid]);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s .", sendername, playerid, para2);
			}
		}
		else
		{
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
			dlgcont[playerid] = 700;
		}
		return 1;
	}
#endif
#if (FS22INS < 3)
	if(dialogid == 703)//���� ������� ��� ������ (2)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			new string[256];
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
				format(string, sizeof(string), "������: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "������� ����� ���� (������� ��� ��������)\n(�� 1 �� 50000):", "��", "������");
				dlgcont[playerid] = 703;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 1 || para1 > 50000)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ���� (������� ��� ��������) �� 1 �� 50000 !");
				format(string, sizeof(string), "������: %s .", mpidpara3[playerid]);
				ShowPlayerDialog(playerid, 703, 1, string, "������� ����� ���� (������� ��� ��������)\n(�� 1 �� 50000):", "��", "������");
				dlgcont[playerid] = 703;
				return 1;
			}
			new para2[256];
			switch(mpidpara1[playerid])
			{
				case 16: format(para2, sizeof(para2), "�������");
				case 17: format(para2, sizeof(para2), "������������� ����");
				case 18: format(para2, sizeof(para2), "�������� ��������");
				case 22: format(para2, sizeof(para2), "���������");
				case 23: format(para2, sizeof(para2), "��������� � ����������");
				case 24: format(para2, sizeof(para2), "������ ����");
				case 25: format(para2, sizeof(para2), "���������");
				case 26: format(para2, sizeof(para2), "������");
				case 27: format(para2, sizeof(para2), "SPAZ 12");
				case 28: format(para2, sizeof(para2), "���");
				case 29: format(para2, sizeof(para2), "MP5");
				case 30: format(para2, sizeof(para2), "��-47");
				case 31: format(para2, sizeof(para2), "�4");
				case 32: format(para2, sizeof(para2), "Tes9");
				case 33: format(para2, sizeof(para2), "��������");
				case 34: format(para2, sizeof(para2), "����������� ��������");
				case 39: format(para2, sizeof(para2), "����������");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
						GivePlayerWeapon(i, mpidpara1[playerid], para1);//��� ������� ��� ������
						if(mpidpara1[playerid] == 39) { GivePlayerWeapon(i, 40, 10); }
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				if(mpidpara1[playerid] >= 16 && mpidpara1[playerid] <= 18)
				{
					format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� �� %s ( �� %d ���� ) .", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s ( �� %d ���� ) .", aa333, playerid, para2, para1);
//					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s ( �� %d ���� ) .", sendername, playerid, para2, para1);
				}
				if(mpidpara1[playerid] >= 22 && mpidpara1[playerid] <= 34)
				{
					format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d ��������.", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d ��������.", aa333, playerid, para2, para1);
//					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d ��������.", sendername, playerid, para2, para1);
				}
				if(mpidpara1[playerid] == 39)
				{
					format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d �������.", sendername, playerid, para2, para1);
					SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d �������.", aa333, playerid, para2, para1);
//					printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� �� %s , � �� %d �������.", sendername, playerid, para2, para1);
				}
			}
		}
		else
		{
			ShowPlayerDialog(playerid, 702, 2, "���� ������� ��� ������.", "����������� ����\n������\n������\n���������\
			\n�������\n������������ ���\n�������� ��������\n��������\n�������� � ����������\n������ ����\n��������\n�����\
			\nSPAZ 12\n���\nMP5\n��-47\n�4\nTes9\n��������\n����������� ��������\n����������", "�����", "������");
			dlgcont[playerid] = 702;
		}
		return 1;
	}
#endif
	if(dialogid == 704)//���� ��������� (1)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "�������� !!!\n\n������ ����������: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ��������� !!!\n\n������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
			mpidpara1[playerid] = strval(inputtext);
		    if(mpidpara1[playerid] < 400 || mpidpara1[playerid] > 611)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ������ ���������� �� 400 �� 611 !");
#if (FS22INS < 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
#if (FS22INS == 3)
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "�������� !!!\n\n������ ����������: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ��������� !!!\n\n������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
				dlgcont[playerid] = 704;
				return 1;
			}
#if (FS22INS == 3)
			if(mpidpara1[playerid] == 432 || mpidpara1[playerid] == 425 || mpidpara1[playerid] == 476 || mpidpara1[playerid] == 447 ||
			mpidpara1[playerid] == 520 || mpidpara1[playerid] == 430 || mpidpara1[playerid] == 464)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ����� ����������� ������ ���������� !");
				ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "�������� !!!\n\n������ ����������: 432 , 425 , 476 ,\
				\n447 , 520 , 430 , 464 - ��������� !!!\n\n������� ������ ���������� (�� 400 �� 611):", "�����", "������");
				dlgcont[playerid] = 704;
				return 1;
			}
#endif
			new string[256];
			format(string, sizeof(string), " ������: %d .", mpidpara1[playerid]);
			ShowPlayerDialog(playerid, 705, 1, string, "������� ���� 1 ���������� (�� 0 �� 255):", "�����", "������");
			dlgcont[playerid] = 705;
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 705)//���� ��������� (2)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			new string[256];
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
				format(string, sizeof(string), " ������: %d .", mpidpara1[playerid]);
				ShowPlayerDialog(playerid, 705, 1, string, "������� ���� 1 ���������� (�� 0 �� 255):", "�����", "������");
				dlgcont[playerid] = 705;
				return 1;
			}
			mpidpara2[playerid] = strval(inputtext);
		    if(mpidpara2[playerid] < 0 || mpidpara2[playerid] > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ���� 1 ���������� �� 0 �� 255 !");
				format(string, sizeof(string), " ������: %d .", mpidpara1[playerid]);
				ShowPlayerDialog(playerid, 705, 1, string, "������� ���� 1 ���������� (�� 0 �� 255):", "�����", "������");
				dlgcont[playerid] = 705;
				return 1;
			}
			format(string, sizeof(string), " ������: %d , ���� 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
			ShowPlayerDialog(playerid, 706, 1, string, "������� ���� 2 ���������� (�� 0 �� 255):", "��", "������");
			dlgcont[playerid] = 706;
		}
		else
		{
#if (FS22INS < 3)
			ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 704, 1, "���� ���������.", "�������� !!!\n\n������ ����������: 432 , 425 , 476 ,\
			\n447 , 520 , 430 , 464 - ��������� !!!\n\n������� ������ ���������� (�� 400 �� 611):", "�����", "������");
#endif
			dlgcont[playerid] = 704;
			return 1;
		}
		return 1;
	}
	if(dialogid == 706)//���� ��������� (3)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
		new string[256];
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
				format(string, sizeof(string), " ������: %d , ���� 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
				ShowPlayerDialog(playerid, 706, 1, string, "������� ���� 2 ���������� (�� 0 �� 255):", "��", "������");
				dlgcont[playerid] = 706;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 0 || para1 > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ���� 2 ���������� �� 0 �� 255 !");
				format(string, sizeof(string), " ������: %d , ���� 1: %d .", mpidpara1[playerid], mpidpara2[playerid]);
				ShowPlayerDialog(playerid, 706, 1, string, "������� ���� 2 ���������� (�� 0 �� 255):", "��", "������");
				dlgcont[playerid] = 706;
				return 1;
			}
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para2 = 1;
						if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
						{
							DestroyVehicle(mpcarid[i]);//������� ���������
						}
						new Float:locX, Float:locY, Float:locZ;
						GetPlayerPos(i, locX, locY, locZ);
						mpcarid[i] = CreateVehicle(mpidpara1[playerid], locX, locY, locZ+3,
						0.0, mpidpara2[playerid], para1, 90000);//��� ��������� ������
						LinkVehicleToInterior(mpcarid[i], GetPlayerInterior(i));//���������� ��������� � ��������� ������
						SetVehicleVirtualWorld(mpcarid[i], GetPlayerVirtualWorld(i));//���������� ���������� ����������� ��� ������
						PutPlayerInVehicle(i, mpcarid[i], 0);
					}
				}
			}
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ������������� %s [%d] ��� ���������� ����������� �� ������ ���������� ��: %d .", sendername, playerid, mpidpara1[playerid]);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ��� ���������� ����������� �� ������ ���������� ��: %d .", aa333, playerid, mpidpara1[playerid]);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ��� ���������� ����������� �� ������ ���������� ��: %d .", sendername, playerid, mpidpara1[playerid]);
			}
		}
		else
		{
			format(string, sizeof(string), " ������: %d .", mpidpara1[playerid]);
			ShowPlayerDialog(playerid, 705, 1, string, "������� ���� 1 ���������� (�� 0 �� 255):", "�����", "������");
			dlgcont[playerid] = 705;
			return 1;
		}
		return 1;
	}
	if(dialogid == 707)//��������� �������� ������
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
				ShowPlayerDialog(playerid, 707, 1, "��������� �������� ������.", "������� ����� ������ (�� 2 �� 12):", "��", "������");
				dlgcont[playerid] = 707;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
		    if(para1 < 2 || para1 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ������ �� 2 �� 12 !");
				ShowPlayerDialog(playerid, 707, 1, "��������� �������� ������.", "������� ����� ������ (�� 2 �� 12):", "��", "������");
				dlgcont[playerid] = 707;
				return 1;
			}
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			para1++;
			countdown[playerid] = para1;
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw)
					{
						para2 = 1;
						if(countdown[i] == -1) { countdown[i] = para1; }//��������� �������� ������
					}
				}
			}
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new string[256];
				format(string, sizeof(string), " ������������� %s [%d] �������� ������ �� %d ������.", sendername, playerid, para1-1);
				SendMPMessage(mpstate[playerid], 0xC2A2DAFF, string);
			}
			new aa333[64];//��������� ��� ������������� ������� �����
			format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
			printf("[MPSys] ������������� %s [%d] �������� ������ �� %d ������.", aa333, playerid, para1-1);//��������� ��� ������������� ������� �����
//			printf("[MPSys] ������������� %s [%d] �������� ������ �� %d ������.", sendername, playerid, para1-1);
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 708)//������� ����
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			if(InpTxtControl(inputtext) == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������, ������������ ������:");
				SendClientMessage(playerid, COLOR_RED, "���� ������ 20h , ��� ��� A0h , ��� ���� ���������, ��� ~ !!!");
#if (FS11INS == 0)
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 299):", "��", "������");
#endif
#if (FS11INS == 1)
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 311):", "��", "������");
#endif
				dlgcont[playerid] = 708;
				return 1;
			}
			new para1;
			para1 = strval(inputtext);
#if (FS11INS == 0)
		    if(para1 < 0 || para1 > 299)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ����� �� 0 �� 299 !");
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 299):", "��", "������");
				dlgcont[playerid] = 708;
				return 1;
			}
#endif
#if (FS11INS == 1)
		    if(para1 < 0 || para1 > 311)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ����� �� 0 �� 311 !");
				ShowPlayerDialog(playerid, 708, 1, "������� ����.", "������� �� ����� (�� 0 �� 311):", "��", "������");
				dlgcont[playerid] = 708;
				return 1;
			}
#endif
			new para2 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para2 = 1;
						SetPlayerSkin(i, para1);//������ ���� ������
					}
				}
			}
			if(para2 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� �� ��: %d .", sendername, playerid, para1);
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� ���� �� ��: %d .", aa333, playerid, para1);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� ���� �� ��: %d .", sendername, playerid, para1);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	if(dialogid == 709)//������� ���� �������
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(GetPlayerVirtualWorld(playerid) != mpvw[playerid]+2000 || mpstate[playerid] != playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� �������� ������ � �������������� ���� �� !");
			return 1;
		}
		if(permis[playerid] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, " ������ ������ ! ��������� ��������� ���������� � �� !");
			return 1;
		}
        if(response)
		{
			new para1;
			new para2;
			para2 = -600;
			if(listitem == 0)//�������
			{
				para1 = 0xFF0000FF;
				para2 = 0;
				format(mpidpara3[playerid], 64, "�������");
			}
			if(listitem == 1)//����������
			{
				para1 = 0xBF3F00FF;
				para2 = 1;
				format(mpidpara3[playerid], 64, "����������");
			}
			if(listitem == 2)//���������
			{
				para1 = 0xFF7F00FF;
				para2 = 2;
				format(mpidpara3[playerid], 64, "���������");
			}
			if(listitem == 3)//Ƹ����
			{
				para1 = 0xFFFF00FF;
				para2 = 3;
				format(mpidpara3[playerid], 64, "Ƹ����");
			}
			if(listitem == 4)//������
			{
				para1 = 0x00FF00FF;
				para2 = 4;
				format(mpidpara3[playerid], 64, "������");
			}
			if(listitem == 5)//���������
			{
				para1 = 0x00FFFFFF;
				para2 = 5;
				format(mpidpara3[playerid], 64, "���������");
			}
			if(listitem == 6)//�������
			{
				para1 = 0x00BFFFFF;
				para2 = 6;
				format(mpidpara3[playerid], 64, "�������");
			}
			if(listitem == 7)//�����
			{
				para1 = 0x0000FFFF;
				para2 = 7;
				format(mpidpara3[playerid], 64, "�����");
			}
			if(listitem == 8)//����������
			{
				para1 = 0x7F00FFFF;
				para2 = 8;
				format(mpidpara3[playerid], 64, "����������");
			}
			if(listitem == 9)//���������
			{
				para1 = 0xFF00FFFF;
				para2 = 9;
				format(mpidpara3[playerid], 64, "���������");
			}
			if(listitem == 10)//�����
			{
				para1 = 0x7F7F7FFF;
				para2 = 10;
				format(mpidpara3[playerid], 64, "�����");
			}
			new para3 = 0;
			new Float: X, Float:Y, Float: Z, playint, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playint = GetPlayerInterior(playerid);
			playvw = GetPlayerVirtualWorld(playerid);
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 50.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
					GetPlayerVirtualWorld(i) == playvw && mpstate[i] == mpstate[playerid] && i != playerid)
					{
						para3 = 1;
			    		for(new j = 0; j < MAX_PLAYERS; j++)
						{
							SetPlayerMarkerForPlayer(j, i, para1);//������ ���� ������� ������
						}
					}
				}
			}
			if(para3 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������� 50 �.�. ��� �� ������ ��������� ����������� !");
			}
			else
			{
				new string[256];
				new sendername[MAX_PLAYER_NAME];
				GetPlayerName(playerid, sendername, sizeof(sendername));
				switch(para2)
				{
					case 0: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {FF0000}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 1: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {BF3F00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 2: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {FF7F00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 3: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {FFFF00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 4: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {00FF00}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 5: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {00FFFF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 6: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {00BFFF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 7: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {0000FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 8: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {7F00FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 9: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {FF00FF}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
					case 10: format(string, sizeof(string), " ������������� %s [%d] ������ ���������� ����������� ���� ������� �� {7F7F7F}%s{00FF00} .", sendername, playerid, mpidpara3[playerid]);
				}
				SendMPMessage(mpstate[playerid], COLOR_GREEN, string);
				new aa333[64];//��������� ��� ������������� ������� �����
				format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� ���� ������� �� %s .", aa333, playerid, mpidpara3[playerid]);//��������� ��� ������������� ������� �����
//				printf("[MPSys] ������������� %s [%d] ������ ���������� ����������� ���� ������� �� %s .", sendername, playerid, mpidpara3[playerid]);
			}
		}
		else
		{
#if (FS22INS == 1)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� �������� ������\n������� ����\n������� ���� �������\n����������\
			\n����������� (����)\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 2)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� ������� ��� ������\n���� ������ ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� � ������ (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
#if (FS22INS == 3)
			ShowPlayerDialog(playerid, 700, 2, "���� �� (� ������� 50 �.�.)", "���� �������\n���� �������� ����)))\
			\n��������� ����� � �����\n��������� ����� � ����� ����)))\n�������� �������� (� ����)\n���� ���������\
			\n�������� ��������� (� ����)\n��������� ���������� (����)\n�������� ���������� (����)\n��������� �������� ������\
			\n������� ����\n������� ���� �������\n����������\n����������� (����)\
			\n�� � ���� ���� (� ������ ����������)", "�����", "������");
#endif
			dlgcont[playerid] = 700;
		}
		return 1;
	}
	return 0;
}

forward InpTxtControl(string[]);
public InpTxtControl(string[])//�������� ��������� ������ �� ����������� �������
{
	new dln, dopper;
	dln = strlen(string);
	dopper = 1;
	for(new i = 0; i < dln; i++)
	{
		if(string[i] < 32 || string[i] == 37 ||
		string[i] == 126 || string[i] == 160) { dopper = 0; }
	}
	return dopper;
}

#if (FS22INS > 1)
	public EndPlCRTp(playerid)
	{
		SetPVarInt(playerid, "PlCRTp", 0);
		return 1;
	}
#endif

forward mpsysvehfunc(carplay);
public mpsysvehfunc(carplay)
{
	new para1 = 0;
	for(new i; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
		{
			if(mpstate[i] != -600 && mpcarid[i] != -600)//���� ����� ��������� � ��, � � ���� ���� ���������, ��:
			{
				if(mpcarid[i] == carplay)//���� �� ���������� ���������� ���� � ��, ��:
				{
					para1 = 1;//���������� 1 (�����, ���������� 0)
				}
			}
		}
	}
    return para1;
}

forward mpsysplfunc(playerid);
public mpsysplfunc(playerid)
{
	new para1 = 0;
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid)//���� ����� ��������� � ��, � �� �� ����������� ��, ��:
	{
		para1 = 1;//���������� 1 (�����, ���������� 0)
	}
    return para1;
}

forward TPmp(playerid, plint, plvw, Float:corx, Float:cory, Float:corz);
public TPmp(playerid, plint, plvw, Float:corx, Float:cory, Float:corz)
{
#if (FS22INS == 1)
	SetPlayerInterior(playerid, plint);
	SetPlayerVirtualWorld(playerid, plvw);
	SetPlayerPos(playerid, corx, cory, corz);
	SetCameraBehindPlayer(playerid);
#endif
#if (FS22INS > 1)
	if(GetPVarInt(playerid, "SecPris") == 0)//���� ����� �� ����� � ������, ��:
	{
		SetPVarInt(playerid, "PlCRTp", 1);
		SetTimerEx("EndPlCRTp", 3000, 0, "i", playerid);
	 	SetPlayerInterior(playerid, plint);
		SetPlayerVirtualWorld(playerid, plvw);
		SetPlayerPos(playerid, corx, cory, corz);
		SetCameraBehindPlayer(playerid);
	}
#endif
	return 1;
}

forward MPStart1(playerid);
public MPStart1(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " ������������� %s [%d] ����� ����������� ��� ��� (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, " ( ���� ������� ����������� ���������� ���������� ����������� )");
		if(timstop[playerid] == 1)
		{
			timstop[playerid] = 0;
		}
		permis[playerid] = 0;//��������� �� �� ��
		return 1;
	}
	else
	{
		format(string, sizeof(string), " ������������� %s [%d] ����������� �����������, �� ������ �������� 40 ������,", sendername, playerid);
		SendClientMessageToAll(COLOR_GREEN, string);
		if(mpcount[playerid] > 0)
		{
			format(string, sizeof(string), " ����� ���������� ����������� - %d �������, ����������,", mpcount[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		format(string, sizeof(string), " ��� �� ����������������� �� ����������� - ������� {FFFF00}/mptp %d", mpstate[playerid]);
		SendClientMessageToAll(COLOR_GREEN, string);
		SetTimerEx("MPStart2", 20000, 0, "d", playerid);
	}
	return 1;
}

forward MPStart2(playerid);
public MPStart2(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " ������������� %s [%d] ����� ����������� ��� ��� (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
		SendClientMessageToAll(COLOR_YELLOW, " ( ���� ������� ����������� ���������� ���������� ����������� )");
		if(timstop[playerid] == 1)
		{
			timstop[playerid] = 0;
		}
		permis[playerid] = 0;//��������� �� �� ��
		return 1;
	}
	else
	{
		format(string, sizeof(string), " ������������� %s [%d] ����������� �����������, �� ������ �������� 20 ������,", sendername, playerid);
		SendClientMessageToAll(COLOR_GREEN, string);
		if(mpcount[playerid] > 0)
		{
			format(string, sizeof(string), " ����� ���������� ����������� - %d �������, ����������,", mpcount[playerid]);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		format(string, sizeof(string), " ��� �� ����������������� �� ����������� - ������� {FFFF00}/mptp %d", mpstate[playerid]);
		SendClientMessageToAll(COLOR_GREEN, string);
		SetTimerEx("MPStart3", 20000, 0, "d", playerid);
	}
	return 1;
}

forward MPStart3(playerid);
public MPStart3(playerid)
{
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
		return 1;
	}
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600)
		{
			format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
			SendClientMessageToAll(COLOR_RED, string);
			return 1;
		}
	}
	else
	{
		format(string, sizeof(string), " ������������� ID: %d �� ���� ������ �����������, ����� � ������� (((...", playerid);
		SendClientMessageToAll(COLOR_RED, string);
		return 1;
	}
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(mpcount[playerid] >= mpcount22[playerid])
	{
		format(string, sizeof(string), " ������������� %s [%d] ����� ����������� ��� ��� (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_YELLOW, string);
	}
	if(mpcount[playerid] < mpcount22[playerid])
	{
		format(string, sizeof(string), " ������������� %s [%d] ����� ����������� ��� ��� (((...", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		SendClientMessageToAll(COLOR_RED, " ( � ������������� ����������� ���������� ����������� ) (((...");
	}
	if(timstop[playerid] == 1)
	{
		timstop[playerid] = 0;
	}
	permis[playerid] = 0;//��������� �� �� ��
	return 1;
}

forward PNotice(playerid);
public PNotice(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600) { return 1; }
	}
	else
	{
		return 1;
	}
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(mpstate[playerid] != -600 && mpstate[playerid] != playerid && mpvw[playerid] != (playvw - 2000))
	{//�������� ������ �� ��
		new para3 = mpstate[playerid];
		mpstate[playerid] = -600;//������� �� �� ������
		mpvw[playerid] = -600;//������� �� ������������ ���� ������
		mpcount[para3]--;//����� ���������� �� -1
		SetPVarInt(playerid, "PlConRep", 0);//�������� ����������
		timstop[playerid] = 0;//��������� �������� ���������� /mptp
		if(mpcarid[playerid] != -600)//���� ���� ��������� � ��������� ��, ��:
		{
			DestroyVehicle(mpcarid[playerid]);//������� ���������
			mpcarid[playerid] = -600;//������� ���������� ��������� ��
		}
		if(mpfreez[playerid] == 1)//���� ����� ���������, ��:
		{
			TogglePlayerControllable(playerid, 1);//����������� ������
			mpfreez[playerid] = 0;//������� ��������� ������
		}
		SetPlayerSkin(playerid, skinpl[playerid]);//���������� ������ ����
   		for(new i = 0; i < MAX_PLAYERS; i++)//���������� ������ ����� �������
		{
			SetPlayerMarkerForPlayer(i, playerid, mapcolpl[playerid]);
		}

		new string[256];
		new sendername[MAX_PLAYER_NAME];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerName(para3, giveplayer, sizeof(sendername));
//		format(string, sizeof(string), " ����� %s [%d] ��� ����� �� ����������� ! (�� �������)", sendername, playerid);
		format(string, sizeof(string), " ����� %s [%d] ��� ����� �� ����������� ! (�� � ������ ���)", sendername, playerid);
		SendMPMessage(para3, COLOR_RED, string);
//		SendClientMessage(playerid, COLOR_RED, " �� ���� ������� �� ����������� ! (�� �������)");
		SendClientMessage(playerid, COLOR_RED, " �� ���� ������� �� ����������� ! (�� � ������ ���)");
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		new aa444[64];//��������� ��� ������������� ������� �����
		format(aa444, sizeof(aa444), "%s", giveplayer);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ����� %s [%d] ��� ����� �� ����������� ( ������������� %s ) (�� �������)", aa333, playerid, aa444);//��������� ��� ������������� ������� �����
		printf("[MPSys] ����� %s [%d] ��� ����� �� ����������� ( ������������� %s ) (�� � ������ ���)", aa333, playerid, aa444);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ����� %s [%d] ��� ����� �� ����������� ( ������������� %s ) (�� �������)", sendername, playerid, giveplayer);
//		printf("[MPSys] ����� %s [%d] ��� ����� �� ����������� ( ������������� %s ) (�� � ������ ���)", sendername, playerid, giveplayer);
	}
	else//�����:
	{
		pnotice[playerid] = 0;//������� �������������� ������
	}
	return 1;
}

forward ANotice(playerid);
public ANotice(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(mpstate[playerid] == -600) { return 1; }
	}
	else
	{
		return 1;
	}
	new playvw;
	playvw = GetPlayerVirtualWorld(playerid);
	if(mpstate[playerid] != -600 && mpstate[playerid] == playerid && mpvw[playerid] != (playvw - 2000))
	{//�������� ������ �� �� (���������� ��)
		new para3 = mpstate[playerid];
		new para4 = mpvw[playerid];
		mpstate[playerid] = -600;//������� �� �� ������
		mpvw[playerid] = -600;//������� �� ������������ ���� ������
		if(permis[playerid] == 1)//���� ��������� �� �� ��, ��:
		{
			permis[playerid] = 0;//��������� �� �� ��
			timstop[playerid] = 1;//������������ ��������� �������� ����������
		}
		mpcount[playerid] = 0;//������� ����� ���������� ��
		mpcount22[playerid] = 0;//������� ��������� ���������� ��

		new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), " ������������� %s [%d] ��� ����� �� ����������� ! (�� �������)", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		format(string, sizeof(string), " ����������� �������������� %s [%d] ��������� !", sendername, playerid);
		SendClientMessageToAll(COLOR_RED, string);
		new aa333[64];//��������� ��� ������������� ������� �����
		format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
		printf("[MPSys] ������������� %s [%d] ��� ����� �� ����������� (ID: %d VW: %d) (�� �������)", aa333, playerid, para3, para4);//��������� ��� ������������� ������� �����
		printf("[MPSys] ����������� �������������� %s [%d] (ID: %d VW: %d) ��������� !", aa333, playerid, para3, para4);//��������� ��� ������������� ������� �����
//		printf("[MPSys] ������������� %s [%d] ��� ����� �� ����������� (ID: %d VW: %d) (�� �������)", sendername, playerid, para3, para4);
//		printf("[MPSys] ����������� �������������� %s [%d] (ID: %d VW: %d) ��������� !", sendername, playerid, para3, para4);
	}
	else//�����:
	{
		anotice[playerid] = 0;//������� �������������� ������
	}
	return 1;
}

public OneSec()
{
	for(new i = 0; i < MAX_PLAYERS; i++)//���� ��� ���� �������
	{
		if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
		{
			if(countdown[i] > 0)//���� ����� �������� �������� ������, ��:
			{
				countdown[i]-=1;
				new str[6];
				format(str,6,"...%d",countdown[i]);
				GameTextForPlayer(i,str,950,4);
				PlayerPlaySound(i,1056,0.0,0.0,0.0);
				if(countdown[i]<4)TogglePlayerControllable(i,0);
			}
			if(countdown[i] == 0)
			{
				TogglePlayerControllable(i,1);
				GameTextForPlayer(i,"~b~GO GO GO !",700,4);
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				countdown[i]=-1;
			}
			if(mpstate[i] != -600 && mpstate[mpstate[i]] == -600)
			{//������� ������� �� �������� ����� (���� ����� �������� �� ��� �� �������� �� �� ��� ����� � �������)
				mpstate[i] = -600;//������� �� �� ������
				mpvw[i] = -600;//������� �� ������������ ���� ������
				SetPVarInt(i, "PlConRep", 0);//�������� ����������
				if(countdown[i] != -1) { countdown[i] = -1; }//���������� �������� ������
				timstop[i] = 0;//��������� �������� ���������� /mptp
				if(mpcarid[i] != -600)//���� ���� ��������� � ��������� ��, ��:
				{
					DestroyVehicle(mpcarid[i]);//������� ���������
					mpcarid[i] = -600;//������� ���������� ��������� ��
				}
				if(mpfreez[i] == 1)//���� ����� ���������, ��:
				{
					TogglePlayerControllable(i, 1);//����������� ������
					mpfreez[i] = 0;//������� ��������� ������
				}
				TPmp(i, retint[i], 0, corpl[i][0], corpl[i][1], corpl[i][2]);//�� �� �������� �����
				SetPlayerSkin(i, skinpl[i]);//���������� ������ ����
   				for(new j = 0; j < MAX_PLAYERS; j++)//���������� ������ ����� �������
				{
					SetPlayerMarkerForPlayer(j, i, mapcolpl[i]);
				}
			}
			new playvw;
			playvw = GetPlayerVirtualWorld(i);
			if(mpstate[i] != -600 && mpstate[i] != i && mpvw[i] != (playvw - 2000))
			{//�������������� (���� ����� �� � ��)
				if(pnotice[i] == 1)
				{
					if(countdown[i] != -1) { countdown[i] = -1; }//���������� �������� ������
//					new string[256];
//					SendClientMessage(i, COLOR_RED, " � ��� ���� 30 ������ ��� �� ��������� �� ����������� !");
//					format(string, sizeof(string), " ��� �� ��������� �� ����������� - ������� {FFFF00}/mptp %d", mpstate[i]);
//					SendClientMessage(i, COLOR_RED, string);
//					SetTimerEx("PNotice", 30000, 0, "d", i);
					SetTimerEx("PNotice", 300, 0, "d", i);
					pnotice[i] = 2;
					timstop[i] = 1;//�������� �������� ���������� /mptp
				}
				if(pnotice[i] == 0) { pnotice[i] = 1; }
			}
			else
			{
				pnotice[i] = 0;
			}
			if(mpstate[i] != -600 && mpstate[i] == i && mpvw[i] != (playvw - 2000))
			{//�������������� (���� ����� �� � ��)
				if(anotice[i] == 1)
				{
					if(countdown[i] != -1) { countdown[i] = -1; }//���������� �������� ������
					SendClientMessage(i, COLOR_RED, " � ��� ���� 30 ������ ��� �� ��������� �� ����������� !");
					SendClientMessage(i, COLOR_RED, " ��� �� ��������� �� ����������� - ������� {FFFF00}/mpret");
					SetTimerEx("ANotice", 30000, 0, "d", i);
					anotice[i] = 2;
				}
				if(anotice[i] == 0) { anotice[i] = 1; }
			}
			else
			{
				anotice[i] = 0;
			}
		}
	}
	return 1;
}


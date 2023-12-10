#include <a_samp>
#include <MXini>

//==============================================================================
//                            ��������� �������
//==============================================================================

#define FS11INS 2 //��� �������:
//                //FS11INS 1 - ����������� ������
//                //FS11INS 2 - Drift + DM ������ �� [Gn_R],
//                //            Drift non-DM ������ �� [Gn_R],
//                //            ��� ��������� RDS ������� �� [Gn_R]

#define FS22INS 2 //����� ����������� GPS:
//                //FS11INS 1 - ����-�������
//                //FS11INS 2 - �����-������

#undef MAX_PLAYERS
#define MAX_PLAYERS 101 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

#define M_HOUS 1000 //�������� ����� �� �������
#define M_BUS 1000 //�������� �������� �� �������
#define M_GAR 1000 //�������� ������� �� �������
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
new FALSE = false, CMDSString[1000];
#define ShowInfoBox(%0,%1,%2,%3) do{format(CMDSString, 1000, %2, %3); ShowPlayerDialog(%0, 520, DIALOG_STYLE_MSGBOX, %1, CMDSString, "Close", "Cancel");}while(FALSE)
#define SendMSG(%0,%1,%2,%3,%4) do{new _str[%2]; format(_str,%2,%3,%4); SendClientMessage(%0,%1,_str);}while(FALSE)
#define Loop(%0,%1) for(new %0 = 0; %0 < %1; %0++)
#define TYPE_OUT (0)
#define TYPE_INT (1)
#define COLOR_YELLOW 0xFFF700FF
#define COLOR_GREY 0x808080FF

//   �������� !!! ����� ��������� �������� ����������� ��������������� !!!
//------------------------------------------------------------------------------

#if (FS11INS < 1)
	#undef FS11INS
	#define FS11INS 1
#endif
#if (FS11INS > 2)
	#undef FS11INS
	#define FS11INS 2
#endif
#if (FS22INS < 1)
	#undef FS22INS
	#define FS22INS 1
#endif
#if (FS22INS > 2)
	#undef FS22INS
	#define FS22INS 2
#endif

forward OneSec();//��������� ������
enum pInfo
{
	pKey[64],
	pTDReg[64],
	pIPAdr[64],
	pMinlog,
	pBanned,
	pWarns,
	pAdmin,
	pAdmshad,
	pAdmlive,
	pReg,
	camobj,
	pPrison,
	pAreg,
    pDreg,
	pPrisonsec,
	pMuted,
	pVip,
	pVIP,
	pMutedsec,
	pPolice,
	pDonateO,
	pKills,
	pGunser,
	pLogin,
	pDeaths,
	pLock,
	pDrifter,
	Float:pCordX,
	Float:pCordY,
	Float:pCordZ,
	Float:pAngle,
	pWeapSlot0,
	pWeapSlot1,
	pWeapSlot2,
	pWeapSlot3,
	pWeapSlot4,
	pWeapSlot5,
	pWeapSlot6,
	pWeapSlot7,
	pWeapSlot8,
	pWeapSlot9,
	pWeapSlot10,
	pWeapSlot11,
	pWeapSlot12,
	pAmmoSlot0,
	pAmmoSlot1,
	pAmmoSlot2,
	pAmmoSlot3,
	pAmmoSlot4,
	pAmmoSlot5,
	pAmmoSlot6,
	pAmmoSlot7,
	pAmmoSlot8,
	pAmmoSlot9,
	pAmmoSlot10,
	pAmmoSlot11,
	pAmmoSlot12,
	pFrac1,
	pFracLvl1,
	Float:pFracCordX1,
	Float:pFracCordY1,
	Float:pFracCordZ1,
	Float:pFracAngle1,
	pFracTxt1[64],
	pFrac2,
	pFracLvl2,
	Float:pFracCordX2,
	Float:pFracCordY2,
	Float:pFracCordZ2,
	Float:pFracAngle2,
	pFracTxt2[64],
	pFrac3,
	pFracLvl3,
	Float:pFracCordX3,
	Float:pFracCordY3,
	Float:pFracCordZ3,
	Float:pFracAngle3,
	pFracTxt3[64],
	pFrac4,
	pFracLvl4,
	Float:pFracCordX4,
	Float:pFracCordY4,
	Float:pFracCordZ4,
	Float:pFracAngle4,
	pFracTxt4[64],
	pFrac5,
	pFracLvl5,
	Float:pFracCordX5,
	Float:pFracCordY5,
	Float:pFracCordZ5,
	Float:pFracAngle5,
	pFracTxt5[64],
	pFrac6,
	pFracLvl6,
	Float:pFracCordX6,
	Float:pFracCordY6,
	Float:pFracCordZ6,
	Float:pFracAngle6,
	pFracTxt6[64]
};
new dlgcont[MAX_PLAYERS];//�������� �� �������
new onesectimer;//���������� �������
new gpsplay[MAX_PLAYERS];//0- GPS ��������, 1- GPS �������
new gpsplaydop[MAX_PLAYERS];//�������������� ���������� ���������
new Float:gpsplaytmpX[MAX_PLAYERS][30];//������� ��������� ���������
new Float:gpsplaytmpY[MAX_PLAYERS][30];
new PlayerInfo[MAX_PLAYERS][pInfo];
new Float:gpsplaytmpZ[MAX_PLAYERS][30];
new gpsplayvw[MAX_PLAYERS][30];//������� ��������� ����������� �����
new gpsplayint[MAX_PLAYERS][30];//������� ��������� ����������
new Float:gpsplaycnstX[MAX_PLAYERS];//������� ���������� ���������
new Float:gpsplaycnstY[MAX_PLAYERS];
new Float:gpsplaycnstZ[MAX_PLAYERS];
new sendername[MAX_PLAYER_NAME];
new idx[MAX_PLAYERS];
new tmp[MAX_PLAYERS];
new cmd[MAX_PLAYERS];
new Float:gpsplayold[MAX_PLAYERS];//�������������� ������ ����������
#if (FS22INS == 2)
	new Text:CountGPSR[MAX_PLAYERS];//�����-�����
	new Text:CountGPSG[MAX_PLAYERS];
	new Text:CountGPSY[MAX_PLAYERS];
	new Text:GPS[MAX_PLAYERS];
#endif

public OnFilterScriptInit()
{
	print(" ");
	print("--------------------------------------");
	print("     GPS System for [Gn_R] servers      ");
	print("--------------------------------------\n");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
#if (FS22INS == 2)
		GPS[i] = TextDrawCreate(510.000000,275.000000,"GPS:");//�����-�����
		TextDrawAlignment(GPS[i],0);
		TextDrawBackgroundColor(GPS[i],0x000000ff);
		TextDrawFont(GPS[i],1);
		TextDrawLetterSize(GPS[i],0.599999,2.599999);
		TextDrawColor(GPS[i],0x3333ffff);
		TextDrawSetOutline(GPS[i],1);
		TextDrawSetProportional(GPS[i],1);
		TextDrawSetShadow(GPS[i],1);

		CountGPSR[i] = TextDrawCreate(480.000000,300.000000,"_");
		TextDrawAlignment(CountGPSR[i],0);
		TextDrawBackgroundColor(CountGPSR[i],0x0000ff66);
		TextDrawFont(CountGPSR[i],2);
		TextDrawLetterSize(CountGPSR[i],0.699999,2.699999);
		TextDrawColor(CountGPSR[i],0xff3333ff);
		TextDrawSetOutline(CountGPSR[i],1);
		TextDrawSetProportional(CountGPSR[i],1);
		TextDrawSetShadow(CountGPSR[i],1);

		CountGPSG[i] = TextDrawCreate(480.000000,300.000000,"_");
		TextDrawAlignment(CountGPSG[i],0);
		TextDrawBackgroundColor(CountGPSG[i],0x0000ff66);
		TextDrawFont(CountGPSG[i],2);
		TextDrawLetterSize(CountGPSG[i],0.699999,2.699999);
		TextDrawColor(CountGPSG[i],0x33ff33ff);
		TextDrawSetOutline(CountGPSG[i],1);
		TextDrawSetProportional(CountGPSG[i],1);
		TextDrawSetShadow(CountGPSG[i],1);

		CountGPSY[i] = TextDrawCreate(480.000000,300.000000,"_");
		TextDrawAlignment(CountGPSY[i],0);
		TextDrawBackgroundColor(CountGPSY[i],0x0000ff66);
		TextDrawFont(CountGPSY[i],2);
		TextDrawLetterSize(CountGPSY[i],0.699999,2.699999);
		TextDrawColor(CountGPSY[i],0xffff33ff);
		TextDrawSetOutline(CountGPSY[i],1);
		TextDrawSetProportional(CountGPSY[i],1);
		TextDrawSetShadow(CountGPSY[i],1);
#endif
#if (FS11INS == 2)
		SetPVarInt(i, "CComAc14", 0);
#endif
		dlgcont[i] = -600;//�� ������������ �� �������
		gpsplay[i] = 0;//���������� GPS
		gpsplaydop[i] = 0;//��������� �������������� ���������� ���������
	}
	onesectimer = SetTimer("OneSec", 1007, 1);
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
#if (FS22INS == 2)
	    TextDrawHideForPlayer(i, CountGPSR[i]);//�����-�����
	    TextDrawHideForPlayer(i, CountGPSG[i]);
	    TextDrawHideForPlayer(i, CountGPSY[i]);
	    TextDrawHideForPlayer(i, GPS[i]);
		TextDrawDestroy(CountGPSR[i]);
		TextDrawDestroy(CountGPSG[i]);
		TextDrawDestroy(CountGPSY[i]);
		TextDrawDestroy(GPS[i]);
#endif
		if(IsPlayerConnected(i))
		{
			if(gpsplay[i] != 0)
			{
	 			SetPlayerInterior(i, 0);
				SetPlayerVirtualWorld(i, 0);
				SendClientMessage(i, 0xFF0000FF, "������� GPS ���� ��������� (�������� �������) !");
			}
#if (FS11INS == 2)
			DeletePVar(i, "CComAc14");
#endif
			gpsplay[i] = 0;//���������� GPS
			gpsplaydop[i] = 0;//��������� �������������� ���������� ���������
		}
	}
	KillTimer(onesectimer);
	return 1;
}

public OnPlayerConnect(playerid)
{
#if (FS11INS == 2)
	SetPVarInt(playerid, "CComAc14", 0);
#endif
	dlgcont[playerid] = -600;//�� ������������ �� �������
	gpsplay[playerid] = 0;//���������� GPS
	gpsplaydop[playerid] = 0;//��������� �������������� ���������� ���������
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(gpsplay[playerid] == 1)
	{
		new string[256];
		new playname[64];
		GetPlayerName(playerid, playname, sizeof(playname));
		format(string, sizeof(string), "[gps] ����� %s [%d] ��� �������� �� GPS (����� � �������) .", playname, playerid);
		print(string);
	}
#if (FS22INS == 2)
	TextDrawHideForPlayer(playerid, CountGPSR[playerid]);//�����-�����
	TextDrawHideForPlayer(playerid, CountGPSG[playerid]);
	TextDrawHideForPlayer(playerid, CountGPSY[playerid]);
	TextDrawHideForPlayer(playerid, GPS[playerid]);
#endif
#if (FS11INS == 2)
	DeletePVar(playerid, "CComAc14");
#endif
	dlgcont[playerid] = -600;//�� ������������ �� �������
	gpsplay[playerid] = 0;//���������� GPS
	gpsplaydop[playerid] = 0;//��������� �������������� ���������� ���������
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
#if (FS11INS == 1)
	SetPVarInt(playerid, "CComAc14", GetPVarInt(playerid, "CComAc14") + 1);
#endif
	new string[256];
	new playname[64];
	GetPlayerName(playerid, playname, sizeof(playname));
	if (strcmp("/gpson", cmdtext, true, 10) == 0)
	{
		if(gpsplay[playerid] != 0)
		{
			SendClientMessage(playerid, 0xFF0000FF, "GPS ����� ������������, ������ ���� �� � ��� �������� !");
			return 1;
		}
	    new file, f[256], string44[64], mark, mark22, stringlg[1024];
		mark = 0;
		mark22 = 1;
		for(new i = 0; i < M_HOUS; i++)//������ ���� �����
		{
		    format(f, 256, "GarHouse/Houses/%i.ini", i);
			file = ini_openFile(f);
			if(file == INI_OK)
			{
			    ini_getString(file, "HouseOwner", string44);
				if(strcmp(string44, playname, false) == 0)
				{
				    ini_getFloat(file, "SpawnOutX", gpsplaytmpX[playerid][mark]);
				    ini_getFloat(file, "SpawnOutY", gpsplaytmpY[playerid][mark]);
				    ini_getFloat(file, "SpawnOutZ", gpsplaytmpZ[playerid][mark]);
		    		ini_getInteger(file, "SpawnWorld", gpsplayvw[playerid][mark]);
		    		ini_getInteger(file, "SpawnInterior", gpsplayint[playerid][mark]);
					if(mark == 0)
					{
						format(stringlg, sizeof(stringlg), "��� - %d", mark22);
					}
					else
					{
						format(stringlg, sizeof(stringlg), "%s\n��� - %d", stringlg, mark22);
					}
					mark++;
					mark22++;
				}
				ini_closeFile(file);
			}
		}
		mark22 = 1;
		for(new i = 0; i < M_BUS; i++)//������ ���� ��������
		{
		    format(f, 256, "bussystem/%i.ini", i);
			file = ini_openFile(f);
			if(file == INI_OK)
			{
			    ini_getString(file, "PlayName", string44);
				if(strcmp(string44, playname, false) == 0)
				{
//��� ������ ��������� ��� ������������� � ������ ������� ������� �������� !!!
//--------------------------------- ������ -------------------------------------
					gpsplayvw[playerid][mark] = 0;
					gpsplayint[playerid][mark] = 0;
//---------------------------------- ����� -------------------------------------
				    ini_getFloat(file, "CordX", gpsplaytmpX[playerid][mark]);
				    ini_getFloat(file, "CordY", gpsplaytmpY[playerid][mark]);
				    ini_getFloat(file, "CordZ", gpsplaytmpZ[playerid][mark]);
		    		ini_getInteger(file, "BusVW", gpsplayvw[playerid][mark]);
		    		ini_getInteger(file, "BusInt", gpsplayint[playerid][mark]);
					if(mark == 0)
					{
						format(stringlg, sizeof(stringlg), "������ - %d", mark22);
					}
					else
					{
						format(stringlg, sizeof(stringlg), "%s\n������ - %d", stringlg, mark22);
					}
					mark++;
					mark22++;
				}
				ini_closeFile(file);
			}
		}
		mark22 = 1;
		for(new i = 0; i < M_GAR; i++)//������ ���� �������
		{
		    format(f, 256, "garages/%i.ini", i);
			file = ini_openFile(f);
			if(file == INI_OK)
			{
			    ini_getString(file, "PlayName", string44);
				if(strcmp(string44, playname, false) == 0)
				{
//��� ������ ��������� ��� ������������� � ������ ������� ������� ������� !!!
//--------------------------------- ������ -------------------------------------
					gpsplayvw[playerid][mark] = 0;
					gpsplayint[playerid][mark] = 0;
//---------------------------------- ����� -------------------------------------
				    ini_getFloat(file, "CordXin", gpsplaytmpX[playerid][mark]);
				    ini_getFloat(file, "CordYin", gpsplaytmpY[playerid][mark]);
				    ini_getFloat(file, "CordZin", gpsplaytmpZ[playerid][mark]);
		    		ini_getInteger(file, "GarVWin", gpsplayvw[playerid][mark]);
		    		ini_getInteger(file, "GarIntin", gpsplayint[playerid][mark]);
					if(mark == 0)
					{
						format(stringlg, sizeof(stringlg), "����� - %d", mark22);
					}
					else
					{
						format(stringlg, sizeof(stringlg), "%s\n����� - %d", stringlg, mark22);
					}
					mark++;
					mark22++;
				}
				ini_closeFile(file);
			}
		}
		if(mark == 0)
		{
			SendClientMessage(playerid, 0xFF0000FF, "GPS ���������� ������������ !");
			SendClientMessage(playerid, 0xFF0000FF, "� ��� ��� �� �����, �� ��������, �� ������� !");
		}
		else
		{
			ShowPlayerDialog(playerid, 900, 2, "GPS.", stringlg, "�����", "������");
			dlgcont[playerid] = 900;
		}
		return 1;
	}
	if(strcmp(cmd, "/me", true) == 0)
    {
        if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_YELLOW, "�.:Dark Drift:.� | {FF0000}�� �� ������ ������, � ��� ��� ���� !");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
        new length = strlen(cmdtext);
        new idx;
        while ((idx < length) && (cmdtext[idx] <= ' '))
		{
        	idx++;
		}
        new offset = idx;
        new result[64];
        while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
        {
        	result[idx - offset] = cmdtext[idx];
         	idx++;
        }
        result[idx - offset] = EOS;
        if(!strlen(result)) return     SendClientMessage(playerid, COLOR_GREY, "�����������: /me [��������]");
        format(string, sizeof(string), "%s %s", sendername, result);
        ProxDetector(20.0, playerid, string, 0xDE92FFFF, 0xDE92FFFF, 0xDE92FFFF, 0xDE92FFFF, 0xDE92FFFF);
        return 1;
    }
	if (strcmp("/gpsoff", cmdtext, true, 10) == 0)
	{
		if(gpsplay[playerid] != 1)
		{
			SendClientMessage(playerid, 0xFF0000FF, "GPS ����� ���������, ������ ���� �� � ��� ����ר� !");
			return 1;
		}
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		gpsplay[playerid] = 0;//���������� GPS
		gpsplaydop[playerid] = 0;//��������� �������������� ���������� ���������
#if (FS22INS == 2)
		TextDrawHideForPlayer(playerid, CountGPSR[playerid]);//�����-�����
		TextDrawHideForPlayer(playerid, CountGPSG[playerid]);
		TextDrawHideForPlayer(playerid, CountGPSY[playerid]);
		TextDrawHideForPlayer(playerid, GPS[playerid]);
#endif
		format(string, sizeof(string), "[gps] ����� %s [%d] �������� ������� GPS.", playname, playerid);
		print(string);
		SendClientMessage(playerid, 0xFF0000FF, "�� ��������� ������� GPS !");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 900)
    {
		if(dialogid != dlgcont[playerid])
		{
			dlgcont[playerid] = -600;//�� ������������ �� �������
			return 1;
		}
		dlgcont[playerid] = -600;//�� ������������ �� �������
		if(gpsplay[playerid] != 0)
		{
			SendClientMessage(playerid, 0xFF0000FF, "GPS ����� ������������, ������ ���� �� � ��� �������� !");
			return 1;
		}
        if(response)
		{
			SetPlayerVirtualWorld(playerid, gpsplayvw[playerid][listitem]);
			SetPlayerInterior(playerid, gpsplayint[playerid][listitem]);
			gpsplaycnstX[playerid] = gpsplaytmpX[playerid][listitem];
			gpsplaycnstY[playerid] = gpsplaytmpY[playerid][listitem];
			gpsplaycnstZ[playerid] = gpsplaytmpZ[playerid][listitem];
			gpsplay[playerid] = 1;//��������� GPS
			gpsplaydop[playerid] = 0;//��������� �������������� ���������� ���������
			new string[256];
			new playname[64];
			GetPlayerName(playerid, playname, sizeof(playname));
			format(string, sizeof(string), "[gps] ����� %s [%d] ����������� ������� GPS.", playname, playerid);
			print(string);
			SendClientMessage(playerid, 0x00FF00FF, "�� ������������ ������� GPS !");
		}
		return 1;
	}
	return 0;
}

public OneSec()
{
	new string[256], Float:locX, Float:locY, Float:locZ, Float:locX22, Float:locY22, Float:locZ22, Float:data, Float:data22;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(gpsplay[i] == 1)
			{
				GetPlayerPos(i, locX, locY, locZ);
				locX22 = gpsplaycnstX[i] - locX;
				locY22 = gpsplaycnstY[i] - locY;
				locZ22 = gpsplaycnstZ[i] - locZ;
				data = floatsqroot(floatmul(locX22,locX22) + floatmul(locY22,locY22) + floatmul(locZ22,locZ22));
				if(gpsplaydop[i] == 0)
				{
#if (FS22INS == 2)
					TextDrawSetString(GPS[i], "GPS:");//�����-�����
					TextDrawShowForPlayer(i, GPS[i]);

					format(string, sizeof(string), "%.2f", data);
					TextDrawSetString(CountGPSY[i], string);
					TextDrawHideForPlayer(i, CountGPSR[i]);
					TextDrawHideForPlayer(i, CountGPSG[i]);
					TextDrawShowForPlayer(i, CountGPSY[i]);
#endif
					gpsplayold[i] = data;
					gpsplaydop[i] = 1;
				}
				data22 = gpsplayold[i] - data;
				if(data22 > -0.50 && data22 < 0.50)
				{
#if (FS22INS == 1)
					format(string, sizeof(string), "~y~%.2f", data);
					GameTextForPlayer(i, string, 3000, 6);
#endif
#if (FS22INS == 2)
					format(string, sizeof(string), "%.2f", data);//�����-�����
					TextDrawSetString(CountGPSY[i], string);
					TextDrawHideForPlayer(i, CountGPSR[i]);
					TextDrawHideForPlayer(i, CountGPSG[i]);
					TextDrawShowForPlayer(i, CountGPSY[i]);
#endif
					gpsplayold[i] = data;
				}
				else
				{
					if(data22 > 0.00)
					{
#if (FS22INS == 1)
						format(string, sizeof(string), "~g~%.2f", data);
						GameTextForPlayer(i, string, 3000, 6);
#endif
#if (FS22INS == 2)
						format(string, sizeof(string), "%.2f", data);//�����-�����
						TextDrawSetString(CountGPSG[i], string);
						TextDrawHideForPlayer(i, CountGPSR[i]);
						TextDrawHideForPlayer(i, CountGPSY[i]);
						TextDrawShowForPlayer(i, CountGPSG[i]);
#endif
						gpsplayold[i] = data;
					}
					if(data22 < 0.00)
					{
#if (FS22INS == 1)
						format(string, sizeof(string), "~r~%.2f", data);
						GameTextForPlayer(i, string, 3000, 6);
#endif
#if (FS22INS == 2)
						format(string, sizeof(string), "%.2f", data);//�����-�����
						TextDrawSetString(CountGPSR[i], string);
						TextDrawHideForPlayer(i, CountGPSG[i]);
						TextDrawHideForPlayer(i, CountGPSY[i]);
						TextDrawShowForPlayer(i, CountGPSR[i]);
#endif
						gpsplayold[i] = data;
					}
				}
				if(data < 1.00)
				{
					new playname[64];
					GetPlayerName(i, playname, sizeof(playname));
					gpsplay[i] = 0;//���������� GPS
					gpsplaydop[i] = 0;//��������� �������������� ���������� ���������
#if (FS22INS == 2)
					TextDrawHideForPlayer(i, CountGPSR[i]);//�����-�����
					TextDrawHideForPlayer(i, CountGPSG[i]);
					TextDrawHideForPlayer(i, CountGPSY[i]);
					TextDrawHideForPlayer(i, GPS[i]);
#endif
					format(string, sizeof(string), "[gps] ����� %s [%d] ��� �������� �� GPS (������ ��� ������) .", playname, i);
					print(string);
					SendClientMessage(i, 0xFF0000FF, "�� ���� ��������� �� GPS (������ ��� ������) !");
				}
			}
		}
	}
	return 1;
}
stock ProxDetector(Float:radi, playerid, str[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{

				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, str);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, str);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, str);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, str);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, str);
				}
			}
		}
	}
	return 1;
}

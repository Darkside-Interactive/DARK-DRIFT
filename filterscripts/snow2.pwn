#include <a_samp>
#include <streamer>

#undef MAX_PLAYERS
#define MAX_PLAYERS 501 //�������� ������� �� ������� + 1 (���� 50 �������, �� ����� 51 !!!)

forward SnowStart(playerid);
forward STimer();
forward STimer22();

new dynobj[39];
new Text3D:ddtex;
new dopplay[MAX_PLAYERS];
new snowobj[MAX_PLAYERS];
new SnowONOFF[MAX_PLAYERS];
new Float:sx,Float:sy,Float:sz;
new pertimer;
new pertimer22;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Filterscript by Dav1dBlane             ");
	print("--------------------------------------\n");
	pertimer = SetTimer("STimer", 1003, true);
	pertimer22 = SetTimer("STimer22", 180000, true);

	for(new i=0;i<MAX_PLAYERS;i++)
	{
		SetPVarInt(i, "CComAc5", 0);
		dopplay[i] = 0;
	}

	//���������
	dynobj[0] = CreateDynamicObject(18102, -3065.14, 6134.28, 12.20,   90.00, 0.00, -90.00, -1, -1, -1, 500);
	dynobj[1] = CreateDynamicObject(18102, -3065.14, 6147.07, 12.20,   90.00, 0.00, -90.00, -1, -1, -1, 500);
	dynobj[2] = CreateDynamicObject(18102, -3049.06, 6164.92, 12.20,   90.00, 0.00, -180.00, -1, -1, -1, 500);
	dynobj[3] = CreateDynamicObject(18102, -3022.71, 6155.16, 12.20,   90.00, 0.00, 90.00, -1, -1, -1, 500);
	dynobj[4] = CreateDynamicObject(18102, -3022.71, 6142.81, 12.20,   90.00, 0.00, 90.00, -1, -1, -1, 500);

	//���� Penguin
    dynobj[5] = CreateDynamicObject(654, -3045.22, 6120.41, 7.72,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[6] = CreateDynamicObject(19122, -3041.5, 6119.76, 16.86,   0.00, 0.00, 1.32, -1, -1, -1, 500);
    dynobj[7] = CreateDynamicObject(19122, -3044.01, 6121.07, 17.87,   0.00, 0.00, 3.68, -1, -1, -1, 500);
    dynobj[8] = CreateDynamicObject(19122, -3042.38, 6121.46, 22.23,   0.00, 0.00, 3.56, -1, -1, -1, 500);
    dynobj[9] = CreateDynamicObject(19122, -3042.2, 6122.23, 19.43,   0.00, 0.00, 2.50, -1, -1, -1, 500);
    dynobj[10] = CreateDynamicObject(19122, -3043.12, 6116.48, 19.11,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[11] = CreateDynamicObject(19122, -3044.26, 6121.6, 17.43,   0.00, 0.00, 0.76, -1, -1, -1, 500);
    dynobj[12] = CreateDynamicObject(19122, -3048.77, 6122.58, 16.63,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[13] = CreateDynamicObject(19122, -3047.75, 6120.04, 19.87,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[14] = CreateDynamicObject(19122, -3046.84, 6120.61, 23.8,   0.00, 0.00, 359.05, -1, -1, -1, 500);
    dynobj[15] = CreateDynamicObject(19122, -3048.38, 6116.86, 16.5,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[16] = CreateDynamicObject(19124, -3049.3, 6119.22, 17.39,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[17] = CreateDynamicObject(19124, -3046.94, 6117.91, 20.85,   0.00, 0.00, 0.00, -1, -1, -1, 500);
	dynobj[18] = CreateDynamicObject(19124, -3044.61, 6118.38, 24.55,   0.00, 0.00, 0.83, -1, -1, -1, 500);
    dynobj[19] = CreateDynamicObject(19124, -3046.51, 6117.51, 21.38,   0.00, 0.00, 0.92, -1, -1, -1, 500);
    dynobj[20] = CreateDynamicObject(1247, -3054.39, 6102.91, 26.32,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[21] = CreateDynamicObject(7666, -3045.13, 6120.07, 30.37,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[22] = CreateDynamicObject(7666, -3045.2, 6120.21, 30.37,   0.00, 0.00, -91.00, -1, -1, -1, 500);
    dynobj[23] = CreateDynamicObject(7666, -3044.86, 6116.31, 16.73,   0.00, 0.00, 305.00, -1, -1, -1, 500);
    dynobj[24] = CreateDynamicObject(7666, -3044.27, 6122.92, 15.03,   0.00, 0.00, 86.00, -1, -1, -1, 500);
    dynobj[25] = CreateDynamicObject(3534, -3045.51, 6122.06, 20.46,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[26] = CreateDynamicObject(2497, -3050.19, 6121.26, 16.22,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[27] = CreateDynamicObject(2497, -3048.15, 6120.78, 21.87,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[28] = CreateDynamicObject(2497, -3046.53, 6118.42, 15.04,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[29] = CreateDynamicObject(2497, -3044.62, 6118, 21.65,   0.00, 0.00, 359.26, -1, -1, -1, 500);
    dynobj[30] = CreateDynamicObject(2497, -3041.1, 6118.62, 16.5,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[31] = CreateDynamicObject(2497, -3042.96, 6119.85, 23.21,   0.00, 0.00, 359.06, -1, -1, -1, 500);
    dynobj[32] = CreateDynamicObject(2497, -3046.41, 6122.54, 18.19,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[33] = CreateDynamicObject(2497, -3044.27, 6121.53, 23.73,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[34] = CreateDynamicObject(2498, -3047.4, 6120.74, 18.2,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[35] = CreateDynamicObject(2498, -3047.26, 6117.12, 18.91,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[36] = CreateDynamicObject(2498, -3042.56, 6119.09, 19.39,   0.00, 0.00, 0.17, -1, -1, -1, 500);
    dynobj[37] = CreateDynamicObject(2498, -3042.69, 6120.15, 13.72,   0.00, 0.00, 0.00, -1, -1, -1, 500);
    dynobj[38] = CreateDynamicObject(2498, -3042.29, 6123.3, 18.64,   0.00, 0.00, 0.00, -1, -1, -1, 500);

	ddtex = Create3DTextLabel("������� ����:\nSnown", 0x00FF00FF, -3045.00, 6121.03, 11.43, 25, 0, 0);
	return 1;
}

public OnFilterScriptExit()
{
	for(new i=0;i<MAX_PLAYERS;i++)//���� ��� ���� �������
	{
		if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
		{
			if(SnowONOFF[i]==1)
			{
				DestroyPlayerObject(i,snowobj[i]);
    			SnowONOFF[i]=0;
			}
			DeletePVar(i, "CComAc5");
		}
	}
 	for(new i = 0; i < 39; i++)
	{
		DestroyDynamicObject(dynobj[i]);
	}
	Delete3DTextLabel(ddtex);
	KillTimer(pertimer);
	KillTimer(pertimer22);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "CComAc5", 0);
	dopplay[playerid] = 0;
    SnowONOFF[playerid]=0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
//	SetPlayerWeather(playerid,1);
	dopplay[playerid] = 0;
    if(SnowONOFF[playerid]==1)
    {
		DestroyPlayerObject(playerid,snowobj[playerid]);
    	SnowONOFF[playerid]=0;
	}
	DeletePVar(playerid, "CComAc5");
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetTimerEx("SnowStart", 2000, 0, "i", playerid);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SetPVarInt(playerid, "CComAc5", GetPVarInt(playerid, "CComAc5") + 1);
	new string[256], sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	new aa333[64];//��������� ��� ������������� ������� �����
	format(aa333, sizeof(aa333), "%s", sendername);//��������� ��� ������������� ������� �����
    if(!strcmp(cmdtext, "/snow", true))
    {
        if(SnowONOFF[playerid]==0)
        {
			GetPlayerCameraPos(playerid,sx,sy,sz);
			snowobj[playerid]=CreatePlayerObject(playerid,18864, sx, sy, sz-5, 0.0, 0.0, 0.0, 300.0);
            SnowONOFF[playerid]=1;
//			SetPlayerWeather(playerid,9);
			printf(" �����: %s [%d] ������� ���� ����.", aa333, playerid);//��������� ��� ������������� ������� �����
//			printf(" �����: %s [%d] ������� ���� ����.", sendername, playerid);
            SendClientMessage(playerid,0x33AA33AA,"{FFF8DC}�� �������� ���� ����.");
        }
        else if(SnowONOFF[playerid]==1)
        {
            SnowONOFF[playerid]=0;
//			SetPlayerWeather(playerid,1);
            DestroyPlayerObject(playerid,snowobj[playerid]);
			printf(" �����: %s [%d] �������� ���� ����.", aa333, playerid);//��������� ��� ������������� ������� �����
//			printf(" �����: %s [%d] �������� ���� ����.", sendername, playerid);
            SendClientMessage(playerid,0xAA3333AA,"{FF0000}�� ��������� ���� ����.");
        }
        return 1;
    }
    if(!strcmp(cmdtext, "/snowall", true))
    {
		if (GetPVarInt(playerid, "AdmLvl") >= 3 || IsPlayerAdmin(playerid))
		{
            for(new i = 0; i < MAX_PLAYERS; i++)
            {
				if(IsPlayerConnected(i))
				{
			        if(SnowONOFF[i]==0)
			        {
						GetPlayerCameraPos(i,sx,sy,sz);
						snowobj[i]=CreatePlayerObject(i,18864, sx, sy, sz-5, 0.0, 0.0, 0.0, 300.0);
			            SnowONOFF[i]=1;
//			            SetPlayerWeather(i,9);
			        }
				}
			}
			printf(" *** ����� %s [%d] ���� ������� ����.", aa333, playerid);//��������� ��� ������������� ������� �����
//			printf(" *** ����� %s [%d] ���� ������� ����.", sendername, playerid);
			format(string, sizeof(string), " *** ����� %s ���� ������� ���� ( ��� ���������� �����������: /snow )", sendername);
			SendClientMessageToAll(0x33AA33AA,string);
		}
		else
		{
			SendClientMessage(playerid, 0xAA3333AA, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
        return 1;
    }
	return 0;
}

public SnowStart(playerid)
{
    if(dopplay[playerid] == 0)
    {
		GetPlayerCameraPos(playerid,sx,sy,sz);
		snowobj[playerid]=CreatePlayerObject(playerid,18864, sx, sy, sz-5, 0.0, 0.0, 0.0, 300.0);
		SnowONOFF[playerid]=1;
//		SetPlayerWeather(playerid,9);
		SendClientMessage(playerid,0xE5B884FF,"{FF8C00}[������]{FFFFFF} ��� ����������/��������� ����� �����������: /snow");
		dopplay[playerid] = 1;
	}
	return 1;
}

public STimer()
{
	for(new i=0;i<MAX_PLAYERS;i++)//���� ��� ���� �������
	{
		if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
		{
			if(SnowONOFF[i]==1)
			{
				GetPlayerCameraPos(i,sx,sy,sz);
				MovePlayerObject(i,snowobj[i],sx,sy,sz-5,9999.0);
			}
		}
	}
	return 1;
}

public STimer22()
{
	SendClientMessageToAll(0xE5B884FF,"{FF8C00}[������]{FFFFFF} ��� ����������/��������� ����� �����������: /snow");
	return 1;
}


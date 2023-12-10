//------------------------------------------------------------------------------
//              ����������� by Darwin. v2.0
//              ���������� ��� igame-comp Furious Drift
//              (c) ��� ����� �� ��������
//------------------------------------------------------------------------------
#include <a_samp>
//---------------------------------[Define's]-----------------------------------
#define MYSERVER	"31.207.170.128:1338"				   	   // IP  ������ �������
#define MYSERVER_T	"127�����0�����0�����1���������7777"   // ��������� �������
#define MYSERVERIP_T	"127�����0�����0�����1:7777"       // ��������� �������
#define MYSITE		"vk.com/twohd"					       // ��� ����
#define MYSITE_R	"��.���/�����					       // ������� �������
#define MAX_REKLAM	62
#define GNR_MODE  0               // ���� ��� ������ �������:
								  //Drift + DM (��� Drift + nonDM)
								  //���������� RDS by GNR
								  // ����� �������� define �� 1, ����� 0
#define COLOR_REKLAM 0xFF0000FF   // ���� ��������� (������ ��� GNR ������)
//------------------------------------------------------------------------------
new RekString[MAX_REKLAM][10]= //������
{
	{".ru"},
	{".ua"},
	{".com"},
	{".��"},
	{".kz"},
	{".net"},
	{".org"},
	{".biz"},
	{".name"},
	{".info"},
	{".mobi"},
	{".ru.com"},
	{".com.kz"},
	{".org.kz"},
	{".ws"},
	{".tv"},
	{".me"},
	{".fm "},
	{".tw"},
	{".co"},
	{".in"},
	{".co"},
	{".in"},
	{".net.in"},
	{".kiev.ua"},
	{".com.ua"},
	{".pp.ua"},
	{".co.ua"},
	{".biz.ua"},
	{".am"},
	{".md "},
	{".pro"},
	{".tel"},
	{".xxx"},
	{".pw"},
	{".cc"},
	{".ms"},
	{".cx"},
	{".as"},
	{".uc"},
	{".co"},
	{".lc"},
	{".wc"},
	{".7778"},
	{".7246"},
	{".7562"},
	{".7857"},
	{".su"},
	{".wix.com"},
	{".ucoz.ru"},
	{".ucoz.com"},
	{".ucoz.su"},
	{".3dn.ru"},
	{".ucoz.net"},
	{".ucoz.org"},
	{".ucoz.ua"},
	{".at.ua"},
	{".my1.ru"},
	{".clan.su"},
	{".moy.su"},
	{".do.am"},
	{":7777"}
};
public OnFilterScriptInit()
{
	printf("\n����������� ���������!");
	return 1;
}

public OnFilterScriptExit()
{
	print("\n����������� ���������!");
	return 1;
}
public OnPlayerText(playerid, text[])
{
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
#if (GNR_MODE == 0)
	if(CheckOnIP(text) && strfind(text, MYSERVER, true) == -1 && strfind(text, MYSERVER_T, true) == -1) // �����������
	{
	    new sting[256];
	    format(sting, sizeof(sting), "* ����� %s [%d] ��� ������ �� ������� ������������ �������", sendername, playerid);
	    print(sting);
		//KickPlayer(playerid,"�� ���� ������� �� ������� ������������ �������.");
		return false;
	}
	for(new i;i<MAX_REKLAM;i++)
	{
		if(strfind(text, RekString[i], true)!= -1)
		{
			if(strfind(text, MYSITE, true) == -1)
			{
			    new sting[256];
			    format(sting, sizeof(sting), "* ����� %s [%d] ��� ������ �� ������� ������������ �������", sendername, playerid);
			    print(sting);
				//KickPlayer(playerid,"�� ���� ������� �� ������� ������������ �������.");
				return false;
			}
		}
	}
#endif
#if (GNR_MODE == 1)
	if(CheckOnIP(text) && GetPVarInt(i, "AdmLvl") == 0 && strfind(text, MYSERVER, true) == -1 && strfind(text, MYSERVER_T, true) == -1) // �����������
	{
	    new sting[256];
		new sting2[128];
	    format(sting, sizeof(sting), "* ����� %s [%d] ��� ������ �� ������� ������������ �������", sendername, playerid);
	    format(sting2, sizeof(sting2), "�����: %s", text);
		print(sting);
		print(sting2);
	    SendClientMessageToAll(COLOR_REKLAM,sting);
	    SendAdminMessage(COLOR_REKLAM,sting2);
		return false;
	}
	for(new i;i<MAX_REKLAM;i++)
	{
		if(strfind(text, RekString[i], true)!= -1 && GetPVarInt(i, "AdmLvl") == 0)
		{
			if(strfind(text, MYSITE, true) == -1)
			{
			    new sting[256];
				new sting2[128];
			    format(sting, sizeof(sting), "* ����� %s [%d] ��� ������ �� ������� ������������ �������", sendername, playerid);
			    format(sting2, sizeof(sting2), "�����: %s", text);
				print(sting);
				print(sting2);
			    SendClientMessageToAll(COLOR_REKLAM,sting);
			    SendAdminMessage(COLOR_REKLAM,sting2);
				//KickPlayer(playerid,"�� ���� ������� �� ������� ������������ �������.");
				return false;
			}
		}
	}
#endif
	return 1;
}
stock IPAntiPorts[][] =
{
	"5555", "6666", "7777", "8888", "9999", "1111", "2222", "3333", "8065", "4444", "4074" // ���������� �����
};
stock CheckOnIP(string[])
{
	new i;
	for(i = sizeof(IPAntiPorts) - 1; i >= 0; i--)
	if(strfind(string, IPAntiPorts[i], false, 0) >= 0)
	return 1;
	if((i = strfind(string, ".", false, 0)) >= 0)
	{
		new digits;
		for (++i; ; i++)
		{
			switch(string[i])
			{
				case ' ': if(digits > 0) break; else continue;
				case '0'..'9': digits++;
				default: break;
			}
		}
		if(digits >= 2) return 1;
	}
	return 0;
}
/*stock KickPlayer(playerid, reason[])
{
	SendClientMessage(playerid,0xC30000FF,reason);
	return SetTimerEx("KickTimer", 1000, false, "d", playerid);
}
forward KickTimer(playerid);
public KickTimer(playerid)
{
	return Kick(playerid);
}*/
forward SendAdminMessage(color, string[]);
public SendAdminMessage(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(GetPVarInt(i, "AdmLvl") >= 1)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

//-------------------------------------------------------------------
// [FS] Simple AFK 1.11 filterscript by OFFREAL
// 13.04.2010
//-------------------------------------------------------------------

#include <a_samp>

// --------------- ����� � �������� ---------------------------------
#define MAX_AFK_TIME 3600 // ����������� ����� AFK �� ����
#define FIRST_CHECK  1500  // ������ ��������������
#define SECOND_CHECK 2500 // ������ ��������������
#define AFK_TEXT_SET 1 // ����� �� ��������� ������� AFK ��� �������

// --------------- ����� --------------------------------------------
#define T_COLOR 0xFF000080      // ���� 3� ������
#define M1_COLOR 0xFFFFFFFF // ���� ������ ������� ��������������
#define M2_COLOR 0xFFFFFFFF // ���� ������ ������� ��������������
#define MK_COLOR 0xFFFFFFFF // ���� ������ ���������� � ����

// --------------- ������ -------------------------------------------
#define T_DIST 20.0 // ���������� � �������� ����� 3� �����

// --------------- ��������� ������ ---------------------------------
enum afk_info {
AFK_Time,                       // ����� AFK
Float:AFK_Coord,        // ��������� ����������
AFK_Stat                        // ������ 3� ������
}

// --------------- ���������� ���������� ----------------------------
new PlayerAFK[MAX_PLAYERS][afk_info];   // ������ AFK �������
new AFK_Timer;          // ������ ������������� ��� ������ �������
new Text3D:AFK_3DT[MAX_PLAYERS]; // 3� ������ ��� �������� �������

// --------------- ���������� ������� �������� ----------------------
forward AFKCheck();

public AFKCheck()
{
        new Float:AFKCoords[3];
        for(new i = 0;i<MAX_PLAYERS;i++)
        {
                if(!IsPlayerConnected(i)){continue;}
                if(IsPlayerNPC(i)){continue;}

                // �������� ���������� �������
                GetPlayerPos(i,AFKCoords[0],AFKCoords[1],AFKCoords[2]);

                // ���� ���������� �� ����������
                if(AFKCoords[0] == PlayerAFK[i][AFK_Coord])
                {
                        PlayerAFK[i][AFK_Time]++;
                }
                else
                {
                        PlayerAFK[i][AFK_Time] = 0;
                        if(PlayerAFK[i][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[i]); PlayerAFK[i][AFK_Stat] = 0; }
                }

                // ��������� ������� ���������� �� ��������� ��������
                PlayerAFK[i][AFK_Coord] = AFKCoords[0];

                // ���������� 3� �����
                if(PlayerAFK[i][AFK_Time] == AFK_TEXT_SET && PlayerAFK[i][AFK_Stat] == 0)
                {
                        AFK_3DT[i] = Create3DTextLabel("������", T_COLOR, 0.00, 0.00, 10000.0, T_DIST, 0);
                        Attach3DTextLabelToPlayer(AFK_3DT[i], i, 0.0, 0.0, 0.5);
                        PlayerAFK[i][AFK_Stat] = 1;
                }

                // ������ ���� ��������� ����������� ���� RCON-������ �� AFK
                if(IsPlayerAdmin(i)){continue;}

                // ������ ������
                if(PlayerAFK[i][AFK_Time] > MAX_AFK_TIME)
                {
                        SendClientMessage(i, MK_COLOR," AFK: �� ���� ������� �� ��������� AFK ����� " #MAX_AFK_TIME " ������");
                        Kick(i);
                        continue;
                }

                // ������ ��������������
                if(PlayerAFK[i][AFK_Time] == FIRST_CHECK)
                {
                        SendClientMessage(i, M1_COLOR,
                        " AFK: �� ������ ������� ����� " #MAX_AFK_TIME - #FIRST_CHECK " ������ ���� �� ������ ���������!");
                        continue;
        }

                // ������ ��������������
                if(PlayerAFK[i][AFK_Time] == SECOND_CHECK)
                {
                        SendClientMessage(i, M2_COLOR,
                        " AFK: �� ������ ������� ����� " #MAX_AFK_TIME - #SECOND_CHECK " ������ ���� �� ������ ���������!");
                        continue;
                }
        }
        return 1;
}

public OnFilterScriptInit()
{
        print("AFK System by Burger started! ");

        // ������ ������� ��� ������� ��������
        AFK_Timer = SetTimer("AFKCheck",1000,1);
        return 1;
}

public OnFilterScriptExit()
{
        for(new i=0;i<MAX_PLAYERS;i++)
        {
                Delete3DTextLabel(AFK_3DT[i]);
        }

        KillTimer(AFK_Timer);

        return 1;
}


public OnPlayerConnect(playerid)
{
        PlayerAFK[playerid][AFK_Time] = 0;
        PlayerAFK[playerid][AFK_Stat] = 0;
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
        PlayerAFK[playerid][AFK_Time] = 0;
        if(PlayerAFK[playerid][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[playerid]); PlayerAFK[playerid][AFK_Stat] = 0; }
        return 1;
}

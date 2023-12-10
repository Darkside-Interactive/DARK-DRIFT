//-------------------------------------------------------------------
// [FS] Simple AFK 1.11 filterscript by OFFREAL
// 13.04.2010
//-------------------------------------------------------------------

#include <a_samp>

// --------------- Время в секундах ---------------------------------
#define MAX_AFK_TIME 3600 // максимально время AFK до кика
#define FIRST_CHECK  1500  // первое предупреждение
#define SECOND_CHECK 2500 // второе предупреждение
#define AFK_TEXT_SET 1 // время до появления надписи AFK над головой

// --------------- Цвета --------------------------------------------
#define T_COLOR 0xFF000080      // цвет 3Д текста
#define M1_COLOR 0xFFFFFFFF // цвет текста первого предупреждения
#define M2_COLOR 0xFFFFFFFF // цвет текста второго предупреждения
#define MK_COLOR 0xFFFFFFFF // цвет текста оповещения о кике

// --------------- Прочее -------------------------------------------
#define T_DIST 20.0 // расстояние с которого видно 3Д текст

// --------------- Структура данных ---------------------------------
enum afk_info {
AFK_Time,                       // время AFK
Float:AFK_Coord,        // последняя координата
AFK_Stat                        // статус 3Д текста
}

// --------------- Объявление переменных ----------------------------
new PlayerAFK[MAX_PLAYERS][afk_info];   // данные AFK игроков
new AFK_Timer;          // таймер фильтрскрипта для работы функции
new Text3D:AFK_3DT[MAX_PLAYERS]; // 3Д тексты над головами игроков

// --------------- Объявление функции проверки ----------------------
forward AFKCheck();

public AFKCheck()
{
        new Float:AFKCoords[3];
        for(new i = 0;i<MAX_PLAYERS;i++)
        {
                if(!IsPlayerConnected(i)){continue;}
                if(IsPlayerNPC(i)){continue;}

                // получаем координаты игроков
                GetPlayerPos(i,AFKCoords[0],AFKCoords[1],AFKCoords[2]);

                // если координата не изменилась
                if(AFKCoords[0] == PlayerAFK[i][AFK_Coord])
                {
                        PlayerAFK[i][AFK_Time]++;
                }
                else
                {
                        PlayerAFK[i][AFK_Time] = 0;
                        if(PlayerAFK[i][AFK_Stat] != 0) { Delete3DTextLabel(AFK_3DT[i]); PlayerAFK[i][AFK_Stat] = 0; }
                }

                // сохраняем текущую координату до следующей проверки
                PlayerAFK[i][AFK_Coord] = AFKCoords[0];

                // показываем 3Д текст
                if(PlayerAFK[i][AFK_Time] == AFK_TEXT_SET && PlayerAFK[i][AFK_Stat] == 0)
                {
                        AFK_3DT[i] = Create3DTextLabel("Отошел", T_COLOR, 0.00, 0.00, 10000.0, T_DIST, 0);
                        Attach3DTextLabelToPlayer(AFK_3DT[i], i, 0.0, 0.0, 0.5);
                        PlayerAFK[i][AFK_Stat] = 1;
                }

                // строка ниже исключает возможность кика RCON-админа за AFK
                if(IsPlayerAdmin(i)){continue;}

                // кикаем игрока
                if(PlayerAFK[i][AFK_Time] > MAX_AFK_TIME)
                {
                        SendClientMessage(i, MK_COLOR," AFK: Вы были кикнуты за состояние AFK более " #MAX_AFK_TIME " секунд");
                        Kick(i);
                        continue;
                }

                // первое предупреждение
                if(PlayerAFK[i][AFK_Time] == FIRST_CHECK)
                {
                        SendClientMessage(i, M1_COLOR,
                        " AFK: Вы будете кикнуты через " #MAX_AFK_TIME - #FIRST_CHECK " секунд если не начнте двигаться!");
                        continue;
        }

                // второе предупреждение
                if(PlayerAFK[i][AFK_Time] == SECOND_CHECK)
                {
                        SendClientMessage(i, M2_COLOR,
                        " AFK: Вы будете кикнуты через " #MAX_AFK_TIME - #SECOND_CHECK " секунд если не начнте двигаться!");
                        continue;
                }
        }
        return 1;
}

public OnFilterScriptInit()
{
        print("AFK System by Burger started! ");

        // запуск таймера для функции проверки
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

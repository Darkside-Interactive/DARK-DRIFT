if(listitem == 0)
	        {
ShowPlayerDialog(playerid, musicbaexele , DIALOG_STYLE_MSGBOX, "Тюнинг System дебаг", "Опреация займет от 5 до 10 секунд!", "Продолжить", "Назад");
return 1;
}
if(listitem == 1)
	        {
ShowPlayerDialog(playerid,abort,DIALOG_STYLE_MSGBOX,"Принудительное отключение аудио ","ВНИМАНИЕ данная функция может нарушить работу вашего клиента и сервера сервера!","ВКЛЮЧИТЬ","ВЫКЛЮЧИТЬ");
return 1;
}
return 1;
}

if(dialogid == musicbaexele)
{
        if(response)
        {
                musicremove = SetTimer("Musicremove",1000*1,false);
                 KillTimer(lourider);
                 KillTimer(stretrace);


        }
        else
        {
              ShowPlayerDialog(playerid, tbag, DIALOG_STYLE_LIST, "Тюнинг System дебаг","Музыка-Звуки исправление вариант 1\nМузыка-Звуки исправление вариант 2","Выбрать","Выйти");

        }
return 1;
}
if(dialogid == abort)
{

        if(response)
        {
        KillTimer(lourider);
        KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(stretrace);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(lourider);
                 KillTimer(stretrace);
                musicremove10 = SetTimer("Musicremove10",100*1,true);
                musicremove11 = SetTimer("Musicremove11",60000*1,true);



        }
        else
        {
              ShowPlayerDialog(playerid, tbag, DIALOG_STYLE_LIST, "Тюнинг System дебаг","Музыка-Звуки исправление вариант 1\nМузыка-Звуки исправление вариант 2","Выбрать","Выйти");
              KillTimer(lourider);
                 KillTimer(stretrace);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove10);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);
                 KillTimer(musicremove11);

        }
return 1;
}

 return 1;
}


forward Musicremove(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove(playerid, vehicleid)
{
KillTimer(musicremove);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 9 секунд. ");
 musicremove1 = SetTimer("Musicremove1",1000*1,false);
 return 1;
}
forward Musicremove1(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove1(playerid, vehicleid)
{

 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 8 секунд. ");
 musicremove2 = SetTimer("Musicremove2",1000*1,false);
 return 1;
}
forward Musicremove2(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove2(playerid, vehicleid)
{
KillTimer(musicremove1);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 7 секунд. ");
 musicremove3 = SetTimer("Musicremove3",1000*1,false);
 return 1;
}
forward Musicremove3(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove3(playerid, vehicleid)
{
KillTimer(musicremove2);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 6 секунд. ");
 musicremove4 = SetTimer("Musicremove4",1000*1,false);
 return 1;
}
forward Musicremove4(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove4(playerid, vehicleid)
{
KillTimer(musicremove3);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 5 секунд. ");
 musicremove5 = SetTimer("Musicremove5",1000*1,false);
 return 1;
}
forward Musicremove5(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove5(playerid, vehicleid)
{
KillTimer(musicremove4);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 4 секунд. ");
 musicremove6 = SetTimer("Musicremove6",1000*1,false);
 return 1;
}
forward Musicremove6(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove6(playerid, vehicleid)
{
KillTimer(musicremove5);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 3 секунд. ");
 musicremove7 = SetTimer("Musicremove7",1000*1,false);
 return 1;
}
forward Musicremove7(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove7(playerid, vehicleid)
{
KillTimer(musicremove6);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 2 секунд. ");
 musicremove8 = SetTimer("Musicremove8",1000*1,false);
 return 1;
}
forward Musicremove8(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove8(playerid, vehicleid)
{
KillTimer(musicremove7);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Осталось 1 секунд. ");
 musicremove9 = SetTimer("Musicremove9",1000*1,false);
 return 1;
}
forward Musicremove9(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove9(playerid, vehicleid)
{
KillTimer(musicremove8);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] Попытка остановить музыку произведенена!. ");
 KillTimer(musicremove9);
  KillTimer(musicremove10);
 StopAudioStreamForPlayer(playerid); // отключим

 return 1;
}
forward Musicremove10(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove10(playerid, vehicleid)
{

 KillTimer(lourider);
 KillTimer(stretrace);
 StopAudioStreamForPlayer(playerid);

 return 1;
}
forward Musicremove11(playerid, vehicleid);// паблик который будем ставить на 2таймер
public Musicremove11(playerid, vehicleid)
{

SendClientMessage(playerid,COLOR_WHITE,"[INFO] Для корекной работы рекомендуем перезапустить клиент. ");

 return 1;

if(listitem == 0)
	        {
ShowPlayerDialog(playerid, musicbaexele , DIALOG_STYLE_MSGBOX, "������ System �����", "�������� ������ �� 5 �� 10 ������!", "����������", "�����");
return 1;
}
if(listitem == 1)
	        {
ShowPlayerDialog(playerid,abort,DIALOG_STYLE_MSGBOX,"�������������� ���������� ����� ","�������� ������ ������� ����� �������� ������ ������ ������� � ������� �������!","��������","���������");
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
              ShowPlayerDialog(playerid, tbag, DIALOG_STYLE_LIST, "������ System �����","������-����� ����������� ������� 1\n������-����� ����������� ������� 2","�������","�����");

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
              ShowPlayerDialog(playerid, tbag, DIALOG_STYLE_LIST, "������ System �����","������-����� ����������� ������� 1\n������-����� ����������� ������� 2","�������","�����");
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


forward Musicremove(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove(playerid, vehicleid)
{
KillTimer(musicremove);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 9 ������. ");
 musicremove1 = SetTimer("Musicremove1",1000*1,false);
 return 1;
}
forward Musicremove1(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove1(playerid, vehicleid)
{

 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 8 ������. ");
 musicremove2 = SetTimer("Musicremove2",1000*1,false);
 return 1;
}
forward Musicremove2(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove2(playerid, vehicleid)
{
KillTimer(musicremove1);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 7 ������. ");
 musicremove3 = SetTimer("Musicremove3",1000*1,false);
 return 1;
}
forward Musicremove3(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove3(playerid, vehicleid)
{
KillTimer(musicremove2);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 6 ������. ");
 musicremove4 = SetTimer("Musicremove4",1000*1,false);
 return 1;
}
forward Musicremove4(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove4(playerid, vehicleid)
{
KillTimer(musicremove3);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 5 ������. ");
 musicremove5 = SetTimer("Musicremove5",1000*1,false);
 return 1;
}
forward Musicremove5(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove5(playerid, vehicleid)
{
KillTimer(musicremove4);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 4 ������. ");
 musicremove6 = SetTimer("Musicremove6",1000*1,false);
 return 1;
}
forward Musicremove6(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove6(playerid, vehicleid)
{
KillTimer(musicremove5);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 3 ������. ");
 musicremove7 = SetTimer("Musicremove7",1000*1,false);
 return 1;
}
forward Musicremove7(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove7(playerid, vehicleid)
{
KillTimer(musicremove6);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 2 ������. ");
 musicremove8 = SetTimer("Musicremove8",1000*1,false);
 return 1;
}
forward Musicremove8(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove8(playerid, vehicleid)
{
KillTimer(musicremove7);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] �������� 1 ������. ");
 musicremove9 = SetTimer("Musicremove9",1000*1,false);
 return 1;
}
forward Musicremove9(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove9(playerid, vehicleid)
{
KillTimer(musicremove8);
 KillTimer(lourider);
 KillTimer(stretrace);
 SendClientMessage(playerid,COLOR_WHITE,"[INFO] ������� ���������� ������ �������������!. ");
 KillTimer(musicremove9);
  KillTimer(musicremove10);
 StopAudioStreamForPlayer(playerid); // ��������

 return 1;
}
forward Musicremove10(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove10(playerid, vehicleid)
{

 KillTimer(lourider);
 KillTimer(stretrace);
 StopAudioStreamForPlayer(playerid);

 return 1;
}
forward Musicremove11(playerid, vehicleid);// ������ ������� ����� ������� �� 2������
public Musicremove11(playerid, vehicleid)
{

SendClientMessage(playerid,COLOR_WHITE,"[INFO] ��� �������� ������ ����������� ������������� ������. ");

 return 1;

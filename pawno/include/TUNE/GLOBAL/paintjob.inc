         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
ChangeVehiclePaintjob(car,0);
PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
ChangeVehiclePaintjob(car,1);
PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");

return 1;
}
if(listitem == 2)
{
new car = GetPlayerVehicleID(playerid);
ChangeVehiclePaintjob(car,2);
PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");
return 1;
}
if(listitem == 3)
{
new car = GetPlayerVehicleID(playerid);
ChangeVehiclePaintjob(car,3);
PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");
return 1;
}


if(listitem == 4)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
new Car = GetPlayerVehicleID(playerid), Model = GetVehicleModel(Car);
       switch(Model)
       {

	   case 411: ShowPlayerDialog(playerid, infernus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n������\n��������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 562: ShowPlayerDialog(playerid, elegy, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 559: ShowPlayerDialog(playerid, jester, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 565: ShowPlayerDialog(playerid, flash, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 561: ShowPlayerDialog(playerid, stratum, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 560: ShowPlayerDialog(playerid, sultan, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 575: ShowPlayerDialog(playerid, broadway, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 534: ShowPlayerDialog(playerid, remington, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n������� ���������/����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 567: ShowPlayerDialog(playerid, savanna, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 536: ShowPlayerDialog(playerid, blade, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 535: ShowPlayerDialog(playerid, slamvan, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������-������� ���������\n������ �������-�������\n����\n������ ������� �� �����\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�����\n�����\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");

        
       }
      

       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         KillTimer(stretrace);
         return 1;





         if(listitem == 0)
{

            ShowPlayerDialog(playerid, compactpered, DIALOG_STYLE_LIST, "�����", "������� ����\n���������� ����\n�� �������", "�������", "�����");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, compactzad, DIALOG_STYLE_LIST, "�����", "�����1\n�����\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, compactubki, DIALOG_STYLE_LIST, "����", "����1\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, compactkovh, DIALOG_STYLE_LIST, "�����", "Alien\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
         ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "���� ��� ����","�����\n�������\n������\n�����\n�������\n����\n��������� ����\n�� �������","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "������","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\n������� ����","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 9)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "������\n�����\n�������\n�������\n�������\n������\n�������\n����������\n�����\n�������\n����� �����\n������ �����\n�������� �������\n������ �����\n����� �������\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 10)
      {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[INFO] ������ ���������������. ");

        RepairVehicle(GetPlayerVehicleID(playerid));

        SendClientMessage(playerid,COLOR_WHITE,"[INFO] ������ ���������������. ");
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       return 1;

	}

if(listitem == 11)
         {
      new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1087);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
SendClientMessage(playerid,COLOR_WHITE,"[INFO] ���������� �����������. ");
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       return 1;

	}
if(listitem == 12)
      {
      new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
					PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] ������ �����������. ");
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       return 1;

	}
if(listitem == 13)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "�����","��������� X2\n������� X4\n������� X10","�������","�����");

return 1;
    }
    if(listitem == 14)
      {
      new car = GetPlayerVehicleID(playerid);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
     RemoveVehicleComponent(car,1034);
     RemoveVehicleComponent(car,1035);
     RemoveVehicleComponent(car,1036);
     RemoveVehicleComponent(car,1037);
     RemoveVehicleComponent(car,1038);
     RemoveVehicleComponent(car,1039);
     RemoveVehicleComponent(car,1040);
     RemoveVehicleComponent(car,1041);
     RemoveVehicleComponent(car,1146);
     RemoveVehicleComponent(car,1147);
     RemoveVehicleComponent(car,1148);
     RemoveVehicleComponent(car,1149);
     RemoveVehicleComponent(car,1171);
     RemoveVehicleComponent(car,1172);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
 StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
return 1;
    }

    if(listitem == 15)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "�������", "������� �� ����\n�������� ����\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 16)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"����� ������","������� ������ ���� � ������","������","������");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

  return 1;
		}

		if(listitem == 17)
      {
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"�� ������ ���� � ������!");
		ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"����-����","������� �����\n������� ��������\n�������� ����\n�������� ������������\n������� �����\n��������� �����\
		\n������� �����\n������� ��������\n��������� ����\n��������� ������������\n������� �����\n��������� �����\n������� ����\n","�������","�����");

}
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }



if(dialogid == compactpered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1013);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactpered, DIALOG_STYLE_LIST, "�����", "������� ����\n���������� ����\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1024);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactpered, DIALOG_STYLE_LIST, "�����", "������� ����\n���������� ����\n�� �������", "�������", "�����");
return 1;
}
if(listitem == 2)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
      }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }

if(dialogid == compactzad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1143);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactzad, DIALOG_STYLE_LIST, "�����", "�����1\n�����\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1144);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactzad, DIALOG_STYLE_LIST, "�����", "�����1\n�����\n�� �������", "�������", "�����");
return 1;
}
if(listitem == 2)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
      }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }

if(dialogid == compactubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1007);
AddVehicleComponent(car,1017);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactubki, DIALOG_STYLE_LIST, "����", "����1\n�� �������", "�������", "�����");
return 1;
}


if(listitem == 1)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }

if(dialogid == compactkovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1006);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactkovh, DIALOG_STYLE_LIST, "�����", "Alien\n�� �������", "�������", "�����");
return 1;
}


if(listitem == 1)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
        
        
if(dialogid == compactspoiler)
	    if(response)
	    {
         if(listitem == 0)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1000);
ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1002);
ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1003);

ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1014);

ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1015);

ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 5)
{


new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1016);
ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 6)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1023);

ShowPlayerDialog(playerid, compactspoiler, DIALOG_STYLE_LIST, "��������", "�������1\n�������2\n�������3\n�������4\n�������5\n�������6\n�������7\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 7)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;
        }
if(dialogid == compactvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1018);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");
	return 1;
}
if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1019);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");

	return 1;
}
if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1020);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");
	return 1;
}


if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1021);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");
	return 1;
}
if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1022);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, compactvihlop, DIALOG_STYLE_LIST, "������", "������� �������� �����\n������� ��������� �����\n��������\n��������� ����� 4\n��������� ������\n�� �������", "�������", "�����");

	return 1;
}
if(listitem == 5)
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
        case 496: ShowPlayerDialog(playerid, compact, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n�����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus, Tornado, Broadway, Remington, Savanna");


       }
       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        //// ������� ��� ���������
        StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         KillTimer(stretrace);
         return 1;


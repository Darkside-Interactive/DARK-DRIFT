if(listitem == 0)
{

            ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
     RemoveVehicleComponent(car,1045);
     RemoveVehicleComponent(car,1046);
     RemoveVehicleComponent(car,1047);
     RemoveVehicleComponent(car,1048);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
     RemoveVehicleComponent(car,1051);
     RemoveVehicleComponent(car,1052);
     RemoveVehicleComponent(car,1053);
     RemoveVehicleComponent(car,1054);
     RemoveVehicleComponent(car,1150);
     RemoveVehicleComponent(car,1151);
     RemoveVehicleComponent(car,1152);
     RemoveVehicleComponent(car,1153);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
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
		PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
		return 1;
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
        
if(dialogid == flashpered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1153);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1152);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashpered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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

if(dialogid == flashzad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1150);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1151);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashzad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
if(dialogid == flashubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1047);
AddVehicleComponent(car,1051);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1048);
AddVehicleComponent(car,1052);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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

if(dialogid == flashkovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1054);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1053);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashkovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
if(dialogid == flashspoiler)
	    if(response)
	    {
         if(listitem == 0)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
AddVehicleComponent(car,1049);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1049);
     RemoveVehicleComponent(car,1050);
AddVehicleComponent(car,1050);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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
if(dialogid == flashvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1046);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1045);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, flashvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

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


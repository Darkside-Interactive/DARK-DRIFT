if(listitem == 0)
{

            ShowPlayerDialog(playerid, uranuspered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, uranuszad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, uranusubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
	        ShowPlayerDialog(playerid, uranuskovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, uranusspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\nPro-carbon\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, uranusvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
     RemoveVehicleComponent(car,1088);
     RemoveVehicleComponent(car,1089);
     RemoveVehicleComponent(car,1090);
     RemoveVehicleComponent(car,1091);
     RemoveVehicleComponent(car,1092);
     RemoveVehicleComponent(car,1093);
     RemoveVehicleComponent(car,1094);
     RemoveVehicleComponent(car,1095);
     RemoveVehicleComponent(car,1163);
     RemoveVehicleComponent(car,1164);
     RemoveVehicleComponent(car,1165);
     RemoveVehicleComponent(car,1166);
     RemoveVehicleComponent(car,1167);
     RemoveVehicleComponent(car,1168);
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

if(dialogid == uranuspered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1166);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuspered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1165);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuspered, DIALOG_STYLE_LIST, "�������� ������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
if(dialogid == uranuszad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1168);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuszad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1167);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuszad, DIALOG_STYLE_LIST, "������ ������", "Alien\nX-flow\n�� �������", "�������", "�����");
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
if(dialogid == uranusubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1090);
AddVehicleComponent(car,1094);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1093);
AddVehicleComponent(car,1095);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusubki, DIALOG_STYLE_LIST, "����", "Alien\nX-flow\n�� �������", "�������", "�����");
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
if(dialogid == uranuskovh)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1088);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuskovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1091);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranuskovh, DIALOG_STYLE_LIST, "�����", "Alien\nX-flow\n�� �������", "�������", "�����");
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
if(dialogid == uranusspoiler)
	    if(response)
	    {
         if(listitem == 0)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1164);
     RemoveVehicleComponent(car,1163);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
AddVehicleComponent(car,1164);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\nPro-carbon\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1164);
     RemoveVehicleComponent(car,1163);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
AddVehicleComponent(car,1163);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\nPro-carbon\n�� �������", "�������", "�����");
return 1;
}
if(listitem == 2)
{
new car = GetPlayerVehicleID(playerid);
     RemoveVehicleComponent(car,1164);
     RemoveVehicleComponent(car,1163);
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
SetPVarInt(playerid, "object", 1);
            	SetPVarInt(playerid, "spoiler", CreateObject(1001,0,0,0,0,0,0));///////////////�������///������//////������/������/������
            	AttachObjectToVehicle(GetPVarInt(playerid, "spoiler"), GetPlayerVehicleID(playerid), 0.0, -2.4, 0.30, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusspoiler, DIALOG_STYLE_LIST, "��������", "Alien\nX-flow\nPro-carbon\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 3)
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
if(dialogid == uranusvihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1089);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1092);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, uranusvihlop, DIALOG_STYLE_LIST, "������", "Alien\nX-flow\n�� �������", "�������", "�����");
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


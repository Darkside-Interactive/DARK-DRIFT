if(listitem == 0)
{

            ShowPlayerDialog(playerid, tornadopered, DIALOG_STYLE_LIST, "�������� ������", "Chrome\nSlamin\n�� �������", "�������", "�����");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, tornadozad, DIALOG_STYLE_LIST, "������ ������", "Slamin\nChrome\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
	        ShowPlayerDialog(playerid, tornadoubki, DIALOG_STYLE_LIST, "����", "Chrome Strip\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}


if(listitem == 3)
	        {
         ShowPlayerDialog(playerid, tornadospoiler, DIALOG_STYLE_LIST, "��������", "Pro-carbon\n������� 2\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 4)
	        {
         ShowPlayerDialog(playerid, tornadovihlop, DIALOG_STYLE_LIST, "������", "Chrome\nSlamin\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
         ShowPlayerDialog(playerid, paintjob, DIALOG_STYLE_LIST, "����������� ������", "����������� ������ 1\n����������� ������ 2\n����������� ������ 3\n������ ����������� ������\n�� �������", "�������", "�����");
         PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "���� ��� ����","�����\n�������\n������\n�����\n�������\n����\n��������� ����\n�� �������","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "������","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\n������� ����","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "������\n�����\n�������\n�������\n�������\n������\n�������\n����������\n�����\n�������\n����� �����\n������ �����\n�������� �������\n������ �����\n����� �������\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}


if(listitem == 9)
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
       return 1;

	}

if(listitem == 10)
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       return 1;

	}
if(listitem == 11)
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
       return 1;

	}
if(listitem == 12)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "�����","��������� X2\n������� X4\n������� X10","�������","�����");

return 1;
    }
    if(listitem == 13)
      {
      new car = GetPlayerVehicleID(playerid);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
      PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
     RemoveVehicleComponent(car,1134);
     RemoveVehicleComponent(car,1135);
     RemoveVehicleComponent(car,1136);
     RemoveVehicleComponent(car,1137);
     RemoveVehicleComponent(car,1190);
     RemoveVehicleComponent(car,1191);
     RemoveVehicleComponent(car,1192);
     RemoveVehicleComponent(car,1193);
  
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
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
StopAudioStreamForPlayer(playerid); // ��������
KillTimer(lourider);
return 1;
    }
if(listitem == 14)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "�������", "������� �� ����\n�������� ����\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 15)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"����� ������","������� ������ ���� � ������","������","������");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}
if(listitem == 16)
      {
if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,0xFFFFFFFF,"�� ������ ���� � ������!");
		ShowPlayerDialog(playerid,automenu,DIALOG_STYLE_LIST,"����-����","������� �����\n������� ��������\n�������� ����\n�������� ������������\n������� �����\n��������� �����\
		\n������� �����\n������� ��������\n��������� ����\n��������� ������������\n������� �����\n��������� �����\n������� ����\n","�������","�����");
		PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
}
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {
        
         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        }
if(dialogid == tornadopered)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1190);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadopered, DIALOG_STYLE_LIST, "�������� ������", "Chrome\nSlamin\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1191);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadopered, DIALOG_STYLE_LIST, "�������� ������", "Chrome\nSlamin\n�� �������", "�������", "�����");
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
     }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        }

if(dialogid == tornadozad)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1192);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadozad, DIALOG_STYLE_LIST, "������ ������", "Slamin\nChrome\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1193);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadozad, DIALOG_STYLE_LIST, "������ ������", "Slamin\nChrome\n�� �������", "�������", "�����");
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
      }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        }

if(dialogid == tornadoubki)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1137);
AddVehicleComponent(car,1134);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadoubki, DIALOG_STYLE_LIST, "����", "Chrome Strip\n�� �������", "�������", "�����");
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
     }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        }



if(dialogid == tornadospoiler)
	    if(response)
	    {
         if(listitem == 0)
 {
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
            	SetPVarInt(playerid, "spoiler", CreateObject(1001,0,0,0,0,0,0));///////////////�������///������//////������/������/������
            	AttachObjectToVehicle(GetPVarInt(playerid, "spoiler"), GetPlayerVehicleID(playerid), 0.0, -2.9, 0.33, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadospoiler, DIALOG_STYLE_LIST, "��������", "Pro-carbon\n������� 2\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler2"));
DeletePVar(playerid, "object");
DestroyObject(GetPVarInt(playerid, "spoiler3"));
SetPVarInt(playerid, "object", 1);
SetPVarInt(playerid, "spoiler2", CreateObject(1016,0,0,0,0,0,0));///////////////�������///������//////������/������/������
AttachObjectToVehicle(GetPVarInt(playerid, "spoiler2"), GetPlayerVehicleID(playerid), 0.0, -2.75, 0.32, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadospoiler, DIALOG_STYLE_LIST, "��������", "Pro-carbon\n������� 2\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");

       }
       }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        }
if(dialogid == tornadovihlop)
	    if(response)
	    {
         if(listitem == 0)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1136);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadovihlop, DIALOG_STYLE_LIST, "������", "Chrome\nSlamin\n�� �������", "�������", "�����");
return 1;
}

if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1135);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, tornadovihlop, DIALOG_STYLE_LIST, "������", "Chrome\nSlamin\n�� �������", "�������", "�����");
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
        case 558: ShowPlayerDialog(playerid, uranus, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        case 576: ShowPlayerDialog(playerid, tornado, DIALOG_STYLE_LIST, "������ System �� Startserv","�������� �������\n������ �������\n����\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n���������� �����������","Add","Close");
        default: SendClientMessage(playerid,0xFF0000AA, "�� ������ ���� �: Elegy, Stratum, Flash, Sultan, Uranus, Infernus");


       }
      }
        }
        else // � ���� ����� ����� 2 ������ (� ����� ������ ��� ������ ������)
        {

         StopAudioStreamForPlayer(playerid); // ��������
         KillTimer(lourider);
         return 1;
        

         if(listitem == 0)
{

            ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");
            PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 1)
{
	        ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {
         ShowPlayerDialog(playerid, genericubka, DIALOG_STYLE_LIST, "����", "���� 1007  1017\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {
         ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1\nvents 2\nvents 3\nvents 4\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
	        {
	        ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 5)
	        {
	        ShowPlayerDialog(playerid, NEON, DIALOG_STYLE_LIST, "���� ��� ����","�����\n�������\n������\n�����\n�������\n����\n��������� ����\n�� �������","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 6)
	        {
	        ShowPlayerDialog(playerid, whel, DIALOG_STYLE_LIST, "������","Shadow\nMega\nRimshine\nWires\nClassic\nTwist\nCutter\nSwitch\nGrove\nImport\nDollar\nTrance\nAtomic\n������� ����","�������","�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 7)
	        {
	        ShowPlayerDialog(playerid, COLOR, DIALOG_STYLE_LIST, "Colors", "������\n�����\n�������\n�������\n�������\n������\n�������\n����������\n�����\n�������\n����� �����\n������ �����\n�������� �������\n������ �����\n����� �������\n�� �������", "�������", "�����");
	        PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 8)
      {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[INFO] ������ ���������������. ");

        RepairVehicle(GetPlayerVehicleID(playerid));

        SendClientMessage(playerid,COLOR_WHITE,"[INFO] ������ ���������������. ");
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
       return 1;

	}




if(listitem == 9)
      {
      new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1087);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
SendClientMessage(playerid,COLOR_WHITE,"[INFO] ���������� �����������. ");
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");

       return 1;

	}
if(listitem == 10)
      {
      new car = GetPlayerVehicleID(playerid);
		            AddVehicleComponent(car,1086);
					PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
		            SendClientMessage(playerid,COLOR_WHITE,"[INFO] ������ �����������. ");
   ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");


       return 1;

	}
if(listitem == 11)
      {
     ShowPlayerDialog(playerid, NOS, DIALOG_STYLE_LIST, "�����","��������� X2\n������� X4\n������� X10","�������","�����");

return 1;
    }
    if(listitem == 12)
      {



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

    if(listitem == 13)
      {
ShowPlayerDialog(playerid, lightsmenu, DIALOG_STYLE_LIST, "�������", "������� �� ����\n�������� ����\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 14)
      {
ShowPlayerDialog(playerid,nomer,DIALOG_STYLE_INPUT,"����� ������","������� ������ ���� � ������","������","������");
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);

		return 1;
		}

		if(listitem == 15)
      {
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\n�� �������", "�������", "�����");
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
if(dialogid == genericexhaust)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1018);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");

	return 1;
}
if(listitem == 1)
{
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1019);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");

	return 1;
}
if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1020);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");

	return 1;
}


if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1021);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");

	return 1;
}
if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1022);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericexhaust, DIALOG_STYLE_LIST, "������", "exhaust 1018\nexhaust� 1019\nexhaust 1020\nexhaust 1021\nexhaust 1022\n�� �������", "�������", "�����");

	return 1;
}







	if(listitem == 5)
{
PlayerPlaySound(playerid, 4602, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
         return 1;
        }
}

if(dialogid == genericscoop)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1004);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");

return 1;
}
if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1005);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");
	return 1;
}


if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1006);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");
	return 1;
}

if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1011);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");
	return 1;
}

if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1012);

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericscoop, DIALOG_STYLE_LIST, "Scoop", "scoop 1004\nscoop 1005\nscoop 1006\nscoop 1011\nscoop 1012\n�� �������", "�������", "�����");
	return 1;
}




	if(listitem == 5)
{

ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
         return 1;
        }
        }
if(dialogid == genericubka)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1012);
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
ShowPlayerDialog(playerid, genericubka, DIALOG_STYLE_LIST, "����", "���� 1007  1017\n�� �������", "�������", "�����");

return 1;
}


	if(listitem == 1)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
         return 1;
        }
        }
if(dialogid == genericvents)
	    if(response)
	    {
         if(listitem == 0)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1142);


 ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\n�� �������", "�������", "�����");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
         if(listitem == 1)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1143);



ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\n�� �������", "�������", "�����");

PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}
if(listitem == 2)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1144);




ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 3)
	        {

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1145);




ShowPlayerDialog(playerid, genericvents, DIALOG_STYLE_LIST, "Vents", "vents 1142\nvents 1143\nvents 1144\nvents 1145\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

if(listitem == 4)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
         return 1;
        }
}



  if(dialogid == genericlamps)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1013);
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1024);
ShowPlayerDialog(playerid, genericlamps, DIALOG_STYLE_LIST, "Lamps", "lamps 1013\nlamps 1024\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
	return 1;
}
}






if(dialogid == genericspoiler)
	    if(response)
	    {
         if(listitem == 0)
	        {
new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1000);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
return 1;
}

        if(listitem == 1)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1002);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 2)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1003);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 3)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1014);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 4)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1015);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 5)
{


new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1016);
ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}

if(listitem == 6)
{

new car = GetPlayerVehicleID(playerid);
AddVehicleComponent(car,1023);

ShowPlayerDialog(playerid, genericspoiler, DIALOG_STYLE_LIST, "C�������", "������� 1000\n������� 1001\n������� 1002\n������� 1003\n������� 1014\n������� 1015\n������� 1016\n������� 1023\n�� �������", "�������", "�����");
PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	return 1;
}









if(listitem == 7)
{
ShowPlayerDialog(playerid, generic, DIALOG_STYLE_LIST, "������ System �� Startserv","������\n������ �������\n����\nVents\n��������\n������\n����������� ������\n����\n������\n���������\n��������\n����������\n������\n�����\n������ ��� ������\n�������\n������� �����\n�����\n���������� �����������","Add","Close");
return 1;

}
return 1;

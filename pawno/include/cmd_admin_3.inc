// �������� ��� IP-������ ������

if(iscmd(cmd,"/clearip")){ restricted(3);
 getTgt("�������������: /clearip [�����]");
 ClearIP(tgt,playerid);
 return 1;
}

// ��������������� ���������� ������ � ����

if(iscmd(cmd,"/gethere")){ restricted(3);
 getTgt("�������������: /gethere [�����]");
 GetPlayerFacingPoint(playerid,x,y,z,2.0);
 SetPlayerInterior(tgt,GetPlayerInterior(playerid));
 SetPlayerVW(tgt,GetPlayerVirtualWorld(playerid));
 TeleportPlayer(tgt,x,y,z);
 GetPlayerFacingAngle(playerid,x);
 SetPlayerFacingAngle(tgt,x);
 return 1;
}

if(iscmd(cmd,"/baninfo") || iscmd(cmd,"/i") ){ restricted(1);
 if(!fexist("/var/banned.lst")) {
  Message(playerid,"������ ����� ����",clDarkRed);
  return 1;
 }
 getStr("�������������: /baninfo [�������]");
 new f = fopen("/var/banned.lst",io_read), buff[max_line], found = 0,
 idx, time, g = gtime(), account[max_line], info[max_line];
 while(fread(f,buff)){
  idx = 0; time = strval(strtok(buff,idx));
  new account[max_line]; account = strtok(buff,idx);
  if(iscmd(account,tmp)){
   found++;
   if(time>g) format(msg,max_line,"[��������%s]",ftime(time-g)); else msg = "[��������]";
   strtok(buff,idx); // ���������� ����
   strmid(info,buff,idx,strlen(buff));
   format(msg,max_line,"%s %s",msg,info);
   Message(playerid,msg,clYellow);
  }
 }
 fclose(f);
 format(msg,max_line,"H������ �����: %i",found);
 Message(playerid,msg,clYellow);
 return 1;
}

// ������ ��������� �����, � �������� �������� �� ��������� �������

if(iscmd(cmd,"/lastip")){ restricted(3);
 getStr("�������������: /ip [�������]");
 new r = LastIP(tmp,playerid);
 if(r==1) Message(playerid,"������� �� ������",clDarkRed); else
 if(r==2) Message(playerid,"���������� �������� ������ � �����, ����� ������",clDarkRed);
 return 1;
}

// ��������� ������ � ������ ��� ���������

if(iscmd(cmd,"/jail")){ restricted(3);
 getTgt("�������������: /jail [�����] [�����(������)] {�����}");
 checkplayer(tgt);
 getInt("�������������: /jail [�����] [�����(������)] {�����}");
 new place = strval(strtok(cmdtext,idx));
 if(!place) place = 1;
 JailPlayer(tgt,place,pint*60);
 SavePlayer(tgt);
 return 1;
}

// ���������� ������ �� ������ ��� ���������

if(iscmd(cmd,"/unjail")){ restricted(3);
 getTgt("�������������: /unjail [�����]");
 checkplayer(tgt);
 UnjailPlayer(tgt);
 SavePlayer(tgt);
 return 1;
}

// ��������� ��������� �������

if(iscmd(cmd,"/unban")){ restricted(3);
 getStr("�������������: /unban [�������]");
 new r = Unban(tmp);
 switch(r){
  case 0: Message(playerid,"����� ������� ��������",clYellow);
  case 1: Message(playerid,"������: ������� �� ������",clDarkRed);
  case 2: Message(playerid,"���� ���� ���� (����� ������)",clYellow);
  case 3: Message(playerid,"������: ����� �� � ����",clDarkRed);
 }
 return 1;
}

// ������� � ����� ���������� �� ��������� ������� � �������

if(iscmd(cmd,"/watch")){ restricted(3);
 getStr("�������������: /watch [����� | off]");
 if(iscmd(tmp,"off")){
  sop[playerid] = 1;
  TogglePlayerSpectating(playerid,0);
  return 1;
 }
 tgt = ReturnUser(tmp); checkplayer(tgt);
 TogglePlayerSpectating(playerid,1);
 SetPlayerInterior(playerid,GetPlayerInterior(tgt));
 SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(tgt));
 new vid = GetPlayerVehicleID(tgt);
 if(!vid) PlayerSpectatePlayer(playerid,tgt);
  else PlayerSpectateVehicle(playerid,vid);
 Watching[playerid] = tgt;
 return 1;
}
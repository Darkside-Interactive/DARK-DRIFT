public OnPlayerCommandText(playerid, cmdtext[])
{
	if(chatcon[playerid] < 0)//���� ������� ������ ������ ����, ��:
	{
		new dopcis, sstr[256];
		dopcis = FCislit(chatcon[playerid]);
		switch(dopcis)
		{
			case 0: format(sstr, sizeof(sstr), " ���� � ���� (��� � ��������) !   ���������� ����� %d ������ !", chatcon[playerid] * -1);
			case 1: format(sstr, sizeof(sstr), " ���� � ���� (��� � ��������) !   ���������� ����� %d ������� !", chatcon[playerid] * -1);
			case 2: format(sstr, sizeof(sstr), " ���� � ���� (��� � ��������) !   ���������� ����� %d ������� !", chatcon[playerid] * -1);
		}
		SendClientMessage(playerid, COLOR_RED, sstr);
		return 1;//��������� �������
	}
	chatcon[playerid]++;//���������� 1 � ����������� ���������� ����
	new idx;
	idx = 0;
	new string[256];
	new strdln[5000];
	new akk[64], ssss[256], igkey[64], tdreg[64], adrip[64];
	new cmd[256];
	new tmp[256];
	new cartype = GetPlayerVehicleID(playerid);
	new string2[256];//���������� �����
	new gid,pname[MAX_PLAYER_NAME],gname[MAX_PLAYER_NAME];
	new playermoney;
	new PlayerName=GetPlayerName(playerid);
	new State=GetPlayerState(playerid);
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new giveplayerid, moneys;
	cmd = strtok(cmdtext, idx);
	if(playspa[playerid] == 0)//����� �� �����������
	{
		printf("-----[����� �� �����������] %s [%d]: ��� ������� %s .", RealName[playerid], playerid, cmdtext);//���������� ������� � ������-���
		SendClientMessage(playerid, COLOR_RED, " �� ��� �� ������������ ! ������� ������� /help !");
		return 1;
	}
	if(PlayerInfo[playerid][pMutedsec] == 0)
	{
		printf(" ����� %s [%d] ��� ������� %s .", RealName[playerid], playerid, cmdtext);
	}
	if(PlayerInfo[playerid][pMutedsec] > 0)
	{
		printf(" ����� %s [%d] (�������) ��� �������: %s .", RealName[playerid], playerid, cmdtext);
	}
//-------------- �������, ���� ����� �� ����������� (������) -------------------
	if(strcmp(cmd, "/help", true) == 0 && playspa[playerid] == 0)
	{//���� ����� �� �����������
		SendClientMessage(playerid,COLOR_GRAD1," ----------------------------- ������ ----------------------------- ");
		SendClientMessage(playerid,COLOR_GREEN,"   ���� ��� ����������� ������ ����� � ������,");
		SendClientMessage(playerid,COLOR_GREEN,"                  ����������� �������   /spawn");
		SendClientMessage(playerid,COLOR_GRAD1," ------------------------------------------------------------------------ ");
    	return 1;
}
	if(strcmp(cmd, "/spawn", true) == 0 && playspa[playerid] == 0)
	{//���� ����� �� �����������
		SendClientMessage(playerid,COLOR_GREEN," �� ������������ !");
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid,x,y,z);
			SetPlayerPos(playerid,x,y,z+5);
			SetTimerEx("SecSpaDop", 300, 0, "i", playerid);
		}
		else
		{
			SpawnPlayer(playerid);
		}
    	return 1;
    }
	if(strcmp("/lay", cmdtext, true) == 0) {
	      ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		  return 1;
	}
	if(strcmp(cmd, "/fuck", true) == 0) {
		 ApplyAnimation(playerid,"PED","fucku",4.0,1,0,0,0,0);
	     return 1;
	}
	if(strcmp(cmd, "/stop", true) == 0) {
		 ClearAnimations(playerid);
	     return 1;
	}

//-------------- �������, ���� ����� �� ����������� (�����) --------------------
//---------- ������� �������, ����������� � ����� ������� (������) -------------
            if(!strcmp(cmd, "/korova", true))
        {
          new Float:X,Float:Y,Float:Z;
          GetPlayerPos(playerid, X,Y,Z);
          new tachka;
          tachka = CreateVehicle(462, X,Y,Z, 0.0, 1, 1, 60000);
          PutPlayerInVehicle(playerid, tachka, 0);
          new korova = CreateObject(11470, 0.42020, 1.13840, 0.58070,   0.00000, 0.00000, 0.00000);
          AttachObjectToVehicle(korova, tachka, 0.42020, 1.13840, 0.58070,   0.00000, 0.00000, 0.00000);
          return true;
}
	if(strcmp(cmd, "/cmd", true) == 0)
    {
        new String[2048];
        strins(String,"|>>>| ����� �� ������ ���������� ����� ���� ������� �� �������.\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"1. {FFFF00}/hh - {FFFFFF}������� ���� ������.\n",strlen(String));
        strins(String,"2. {FFFF00}/bb  - {FFFFFF}������� ���� ����.\n",strlen(String));
        strins(String,"3. {FFFF00}/commands - {FFFFFF}������ ������� �������.\n",strlen(String));
	    strins(String,"4. {FFFF00}/pm - {FFFFFF}�������� ������ � �����.\n",strlen(String));
	    strins(String,"5. {FFFF00}/menu - {FFFFFF}������� ���� �������.\n",strlen(String));
	    strins(String,"6. {FFFF00}/em - {FFFFFF}����������� ������.\n",strlen(String));
        strins(String,"7. {FFFF00}/adminka | /������� - {FFFFFF}��������� ���������������� ����.\n",strlen(String));
        strins(String,"8. {FFFF00}/count - {FFFFFF}������ (� ������).\n",strlen(String));
        strins(String,"9. {FFFF00}/rules - {FFFFFF}������\n",strlen(String));
        strins(String,"10. {FFFF00}/vers - {FFFFFF}����������� ������ ����\n",strlen(String));
        strins(String,"11. {FFFF00}/korova - {FFFFFF}�������� �� ������\n",strlen(String));
        strins(String,"12. {FFFF00}/getid - {FFFFFF}����������� ID ���������� ��� ������\n",strlen(String));
        strins(String,"13. {FFFF00}/report - {FFFFFF}[�� ����������] [������]\n",strlen(String));
        strins(String,"14. {FFFF00}/cmchat - {FFFFFF}�������� ���� ���\n",strlen(String));
        strins(String,"15. {FFFF00}/s - {FFFFFF}��������� ��������� ����� ���������\n",strlen(String));
        strins(String,"16. {FFFF00}/dt [����������� ���] - {FFFFFF}����� ��� ����� ��������\n",strlen(String));
        strins(String,"17. {FFFF00}/givecash | /pay [��] [�����] - {FFFFFF}�������� ������ ������� ������\n",strlen(String));
        strins(String,"18. {FFFF00}/dmcount - {FFFFFF}��������� ��������-DM ������\n",strlen(String));
        strins(String,"19. {FFFF00}/spawn - {FFFFFF}������������\n",strlen(String));
        strins(String,"20. {FFFF00}/admins - {FFFFFF}����������� On-Line �������\n",strlen(String));
        strins(String,"21. {FFFF00}/statpl 600 - {FFFFFF}����������� ���� ��������� ����������\n",strlen(String));
        strins(String,"22. {FFFF00}/obnul - {FFFFFF}�������� ��� ���� ����\n",strlen(String));
        strins(String,"23. {FFFF00}/r - {FFFFFF}����������������� �� ���������� �������\n",strlen(String));
        strins(String,"24. {FFFF00}/lic - {FFFFFF}�������� ��� �� ������� ����\n",strlen(String));
        strins(String,"25. {FFFF00}/offlic - {FFFFFF}��������� ��� �� ������� ����\n",strlen(String));
        strins(String,"26. {FFFF00}/vipinfo - {FFFFFF}������ ���� �� ���\n",strlen(String));
        strins(String,"27. {FFFF00}/vips - {FFFFFF}����������� On-Line ��� �������\n",strlen(String));
        strins(String,"28. {FFFF00}/w | /t - {FFFFFF}����� ������ � �������\n",strlen(String));
		strins(String,"29. {FFFF00}/r | /s - {FFFFFF}���������� ������� � �������� � ���\n",strlen(String));
		strins(String,"30. {FFFF00}/cs - {FFFFFF}�������� �� ��-����\n",strlen(String));
		strins(String,"31. {FFFF00}/df(1-9) - {FFFFFF}����� ���� (�� 1 �� 9)\n",strlen(String));
		strins(String,"32. {FFFF00}/radio - {FFFFFF}�������� � ���� �����\n",strlen(String));
		strins(String,"33. {FFFF00}/da - {FFFFFF}����������� � ���-����\n",strlen(String));
		strins(String,"34. {FFFF00}/net - {FFFFFF}�������� ��� ����\n",strlen(String));
		strins(String,"35. {FFFF00}/xe - {FFFFFF}��������\n",strlen(String));
		strins(String,"36. {FFFF00}/xd - {FFFFFF}�������� �� �����\n",strlen(String));
		strins(String,"37. {FFFF00}/ogur - {FFFFFF}����� ������ � ����������\n",strlen(String));
		strins(String,"38. {FFFF00}/ex - {FFFFFF}��������\n",strlen(String));
		strins(String,"39. {FFFF00}/fire - {FFFFFF}�������� ����� ��� ��������\n",strlen(String));
		strins(String,"40. {FFFF00}/ice - {FFFFFF}�������� ��� ��� ��������\n",strlen(String));
		strins(String,"41. {FFFF00}/puk - {FFFFFF}�������\n",strlen(String));
		strins(String,"42. {FFFF00}/movie | /movieoff - {FFFFFF}��������/��������� ����� ������\n",strlen(String));
		strins(String,"��� ������� ����� ��������� ��������� �� ������",strlen(String));
		strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,3005, DIALOG_STYLE_MSGBOX, "{FFFFFF}������� �������.", String, "��", "");
        return 1;
}
        if(strcmp(cmd, "/rules", true) == 0)
        {
        new String[2048];
        strins(String," {99CCFF}������������ ��������� ������ ����� �������. {6600FF}� ������ ���� ������ ��� {FF0000}��� ��� �� ����������� � ��������\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"{FFFFFF}����, ���������\n",strlen(String));
        strins(String,"{FF0000}|>>>|>>>| {FFFF00}�� ������� {FF0000}���������:\n",strlen(String));
        strins(String,"{FF3300}1. {33FF00}�� ������������ ����,���� ������� �� ����� �������\n",strlen(String));
        strins(String,"{FF3300}2. {33FF00}�� �������� ������ ������� ������� ���,��� � �� ������������ ������������� �������\n",strlen(String));
        strins(String,"{FF3300}3. {33FF00}������������� ������� ������ ����� � ����� �������\n",strlen(String));
        strins(String,"{FF3300}4. {33FF00}������� ���� ������ � �� ������ ���� ����� ������ �� ����� �������\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"{FF0000}|>>>|>>>| {99FF00}������ �� ����:\n",strlen(String));
     	strins(String,"{FFFFFF}1.{99FF00}���� ����� �� ��������, ���������� ��������� ��������� � ���� ���� {FFFFFF}(ESC)\n",strlen(String));
        strins(String,"{FFFFFF}2.{99FF00}���� �� ����������� �������� (������), ������� �� ������\n",strlen(String));
        strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,1002, DIALOG_STYLE_MSGBOX, "{FFFFFF}������", String, "��", "");
        return 1;
    }
    if(strcmp(cmd, "/line", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /line 0 , ���");
				SendClientMessage(playerid, COLOR_GRAD2, " /line [������(1-5)] [0-���������, 1-����������]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if (para1 < 0 || para1 > 5)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ������ �� 1 �� 5 , ��� 0 !");
				return 1;
			}
			if (para1 == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTBLUE, " --- ���������� ����� ---");
				format(string,sizeof(string)," ��.1-[%d] ��.2-[%d] ��.3-[%d] ��.4-[%d] ��.5-[%d]", LineStat[1], LineStat[2],
				LineStat[3], LineStat[4], LineStat[5]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				printf(" ������������� %s ���������� ���������� �����.", RealName[playerid]);
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [0-���������, 1-����������] !");
				return 1;
			}
			new stat;
			stat = strval(tmp);
			if (stat < 0 || stat > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " 0-���������, 1-���������� !");
				return 1;
			}
			if (stat == LineStat[para1] && stat == 0)
			{
				format(string,sizeof(string)," ������ %d ��� ��������� !", para1);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			if (stat == LineStat[para1] && stat == 1)
			{
				format(string,sizeof(string)," ������ %d ��� ���������� !", para1);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			if (stat == 0)
			{
				LineStat[para1] = stat;
				SaveLine();//������ ������� �����
				format(string,sizeof(string)," ������������� %s �������� ������ %d .", RealName[playerid], para1);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				if(para1 == 1) { LineOff1(); }
				if(para1 == 2) { LineOff2(); }
				if(para1 == 3) { LineOff3(); }
				if(para1 == 4) { LineOff4(); }
				if(para1 == 5) { LineOff5(); }
				return 1;
			}
			if (stat == 1)
			{
				LineStat[para1] = stat;
				SaveLine();//������ ������� �����
				format(string,sizeof(string)," ������������� %s ��������� ������ %d .", RealName[playerid], para1);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
				if(para1 == 1) { LineOn1(); }
				if(para1 == 2) { LineOn2(); }
				if(para1 == 3) { LineOn3(); }
				if(para1 == 4) { LineOn4(); }
				if(para1 == 5) { LineOn5(); }
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
	if (strcmp("/untouch", cmdtext, true, 10) == 0)
	{
		if(IsPlayerAdmin(playerid))
		{
			if(PlayerInfo[playerid][pAdmin] == 17)
			{
				SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� ������� �������� (��������������) ������ ������� !");
				return 1;
			}
			new dopper;
			format(string, sizeof(string), " *** ����� %s [%d] ������ ���� ������� (�������������) ������� �� �������.", RealName[playerid], playerid);
			print(string);
			SendClientMessage(playerid,COLOR_GREY," *** �� ������� ���� ������� (�������������) ������� �� �������.");
			PlayerInfo[playerid][pVIP] = 0;//������ VIP
			dopper = PlayerInfo[playerid][pAdmin];
			PlayerInfo[playerid][pAdmin] = 17;
			AdmUpdate(RealName[playerid], PlayerInfo[playerid][pAdmin], 1);
			new twenlim = 0;
			new restlim = 0;
			Fmadmins(1, RealName[playerid], 0, twenlim, restlim);
			if (dopper <= 2)
			{
				PlayerInfo[playerid][pAdmlive] = 1;//���������� ����������
				SendClientMessage(playerid, COLOR_GREEN, " ���������� ��������.");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}

    	if(strcmp(cmdtext, "/commands", true) == 0)
	    {
		SendClientMessage(playerid,0xFF8000AA,"����� �������� ����:");
		SendClientMessage(playerid,0x00FF00AA,"			������ ������ ALT(���� �� ������) ��� 2(���� �� � ������);");
		SendClientMessage(playerid,0x00FF00AA,"     	������� ����� '���������, � ������� �� ������� '��� ����������'.");
		SendClientMessage(playerid,0xFF8000AA,"������������:");
		SendClientMessage(playerid,0x00FF00AA,"     	������ ������ ALT(���� �� ������) ��� 2(���� �� � ������);");
		SendClientMessage(playerid,0x00FF00AA,"     	1.������� ����� '���������';");
		SendClientMessage(playerid,0x00FF00AA,"     	2.Drift-������: '/df(1-9)'(��� �������);");
		SendClientMessage(playerid,0x00FF00AA,"     	2.Drag-������: '/drag1-3'(��� �������);");
		SendClientMessage(playerid,0xFF8000AA,"������:");
		SendClientMessage(playerid,0x00FF00AA,"     	������ ������ 2;");
		SendClientMessage(playerid,0x00FF00AA,"     	������� ����� '���������';");
		SendClientMessage(playerid,0x00FF00AA,"         ������� ����� '������';");
		SendClientMessage(playerid,0x00FF00AA,"     	����� ��������� �� ������, ������� ��� �����.");
		SendClientMessage(playerid,0xFF8000AA,"������� ���� � ������:");
		SendClientMessage(playerid,0x00FF00AA,"     	������ ������ ALT(���� �� ������) ��� 2(���� �� � ������);");
		SendClientMessage(playerid,0x00FF00AA,"     	������� ����� '���������� ����������';");
		SendClientMessage(playerid,0x00FF00AA,"     	����� ��������� ��, ��� ��� �����, ��� �� �� ������ �������� ������� /skin");
		SendClientMessage(playerid,0xFF8000AA,"�������������:");
		SendClientMessage(playerid,0x00FF00AA,"     	'/������' - ������� ������;");
		SendClientMessage(playerid,0x00FF00AA,"     	'/dt [id]*' - ����� �����-����������;");
		SendClientMessage(playerid,0x00FF00AA,"     	'/pm [id] [message]' - ��������� ������ ���������;");
		SendClientMessage(playerid,0xFFFF00AA,"     	0 - ����� ���. ����� - ���� ���������.");
		return 1;
    }
    if(!strcmp(cmd, "/gang", true))
 	{
		ShowPlayerDialog(playerid, 1011, DIALOG_STYLE_LIST, "{0000FF}�����{0000FF}","{00FFFF}������� �����\n{0000FF}��������� �����\n{00FFFF}��������� ����� ������\n{0000FF}��������� �������\n{00FFFF}���������� � �����\n{0000FF}������� �� �����\n{00FFFF}�������� ���� �����\n{0000FF}���� �� �����", "�������", "������");
		return 1;
  	}
  	if(strcmp(cmd, "/fight", true) == 0 || strcmp(cmd, "/������", true) == 0)
	{
		ShowPlayerDialog(playerid, 789, DIALOG_STYLE_LIST, "����� ������", "{00ffff}Normal\n{00ffff}Boxing\n{0000ff}Kungfu\n{00ffff}KickBoxing\n{0000ff}Grabkick\n{00ffff}Elbow", "�����", "������");
		return 1;
	}
    if (strcmp(cmdtext, "/em", true)==0)
    {
    new VehicleID, Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    VehicleID = GetPlayerVehicleID(playerid);
    SetVehiclePos(VehicleID, X, Y, Z);
    SetVehicleZAngle(VehicleID, 0);
    return 1;
    }
        if(strcmp(cmdtext,"/lic",true)==0)
	    {
			testka[playerid] = 1;
			SendClientMessage(playerid, COLOR_GREEN, "�� �������� ��� �� 1 ���� (������ ��� ����, �� �� ��� ���� �����) | /offlic - ���������");
			new Float:x, Float:y, Float:z, vehicleid = GetPlayerVehicleID(playerid), vehmodel = GetVehicleModel(vehicleid), bool:found;
			for( new i;i<sizeof(DashBoards);i++ )
            	{
                if( vehmodel == DashBoards[i][modelidd] )
                {
                    x = DashBoards[i][cam_x];
                    y = DashBoards[i][cam_y];
                    z = DashBoards[i][cam_z];
                    found = true;
                    break;
                }
            }

            if( found )
            {
                PlayerInfo[playerid][camobj] = CreateObject(19254,x,y,z,0.0,0.0,0.0,200.0);
                AttachObjectToVehicle( PlayerInfo[playerid][camobj], vehicleid, x,y,z, 0, 0, 0);
                AttachCameraToObject(playerid, PlayerInfo[playerid][camobj]);
            }
            return 1;
		}
 	if(strcmp(cmdtext,"/offlic",true)==0)
	{
	   	 testka[playerid] = 0;
	   	 SendClientMessage(playerid, COLOR_GREEN, "�� ��������� ��� �� 1 ����");
	   	 SetCameraBehindPlayer( playerid );
     	 DestroyObject( PlayerInfo[playerid][camobj] );
	     return 1;
	}
        if(strcmp(cmd, "/adminka", true) == 0)
        {
        new String[2048];
        strins(String,"{00FF00}�� ����� � ������ {FF0000}'���� �� ���������������� �����'\n",strlen(String));
        strins(String,"\n",strlen(String));
        strins(String,"> {FFFF00}��������� ���������������� ���� {00FFFF}�� ��� ������:\n",strlen(String));
        strins(String,">> {0000FF}1 ����� - {FF0000}10 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}2 ����� - {FF0000}20 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}3 ����� - {FF0000}30 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}4 ����� - {FF0000}40 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}5 ����� - {FF0000}50 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}6 ����� - {FF0000}60 {FFFFFF}������\n",strlen(String));
     	strins(String,">> {0000FF}7 ����� - {FF0000}70 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}8 ����� - {FF0000}80 {FFFFFF}������\n",strlen(String));
        strins(String,">> {0000FF}9 ����� - {FF0000}90 {FFFFFF}������\n",strlen(String));
	    strins(String,">> {0000FF}10 ����� - {FF0000}100 {FFFFFF}������\n",strlen(String));
	    strins(String,">> {0000FF}11 ����� - {FF0000}150 {FFFFFF}������\n",strlen(String));
		strins(String,">> {0000FF}12 ����� - {FF0000}200 {FFFFFF}������\n",strlen(String));
		strins(String,">> {0000FF}13 ����� - {FF0000}300 {FFFFFF}������\n",strlen(String));
		strins(String,">> {0000FF}14 ����� - {FF0000}400 {FFFFFF}������\n",strlen(String));
		strins(String,">> {0000FF}��������� ������ ������������� ��� ������� �������, � ��� �� ���������",strlen(String));
	    strins(String,"\n",strlen(String));
        strins(String,"{FF0000}[��������]: {FFFFFF}�� ��������� ����� ��������� �������, ��{99FF00}�� ��������� ������ ������� �����.\n",strlen(String));
        strins(String,"{00FFFF}����� ���������� ���������������� ����� {FF0000}��� ���������� {00FFFF}��������� �� ���� � ��������:{FF00FF}SethDisquaro#4442\n",strlen(String));
        strins(String,"\n",strlen(String));
	    ShowPlayerDialog(playerid,5002, DIALOG_STYLE_MSGBOX, "{FFFFFF}�������", String, "��", "");
        return 1;
}
    if(strcmp(cmd, "/cs", true) == 0)
    {
       if(dzona[playerid] == 1)return SendClientMessage(playerid, COLOR_RED,"�� ��� ���������� � CS ����, ���-�� ����� /exitcs");
       {
           new rand = random(sizeof(DMZona));
           rand = random(sizeof(DMZona));
           SetPlayerPos(playerid, DMZona[rand][0], DMZona[rand][1], DMZona[rand][2]);
           GivePlayerWeapon(playerid,24,950);
           GivePlayerWeapon(playerid,31, 950);
           GivePlayerWeapon(playerid,34, 950);
           GivePlayerWeapon(playerid,28, 950);
           SetPlayerHealth(playerid, 100);
		   SetPlayerArmour(playerid,100);
           dzona[playerid] = 1;
           GetPlayerName(playerid, sendername, sizeof(sendername));
  		   format(string, sizeof(string), "{0066CC}%s(%d) {b22222}����� � ��unt�r Strik� {0066CC}( /cs )", sendername, playerid);
		   SendClientMessageToAll(0xb22222FF, string);
           SendClientMessage(playerid, COLOR_REDRACE,"�� � CS ���� | {999999}���-�� ����� ������� /exitcs");
	   }
       return 1;
    }
    if(strcmp(cmd, "/exitcs", true) == 0)
    {
       if(dzona[playerid] == 0)return SendClientMessage(playerid, COLOR_WHITE,"�� �� � CS ����");
       dzona[playerid] = 0;
       SpawnPlayer(playerid);
       SendClientMessage(playerid, COLOR_RED,"�� �������� CS ����");
       return 1;
    }
    if( strcmp(cmd, "/radio", true) == 0)
 {
     if(IsPlayerConnected(playerid))
     {
            ShowPlayerDialog(playerid, RADIO, DIALOG_STYLE_LIST, "�������� ����� �����:","1.Zaycev FM\n2.Radio Record\n3.Record Teodor\n4.Record Dancecore\n5.������� ������\n6.Retro FM\n7.Record DubStep\n8.Record ��������� 90-x\n9.Record Club\n10.Hip-Hop\n11.������ +\n12.RAP\n13.Zaycev FM ��������\n14.Fox FM\n15.��������-FM\n16.������-FM\n17.M���-FM\n{FF3300}��������� �����", "Ok", "�����");
        }
        return 1;
    }
    if(strcmp("/az", cmdtext, true, 10) == 0)
    {
      if(PlayerInfo[playerid][pAdmin] < 1) return 1;
      SetPlayerPos(playerid,1282.70, -801.78, 1089.94); // "-120.3881,1210.0604,1080.2694" - ������ ���� ����������.
      SendClientMessage(playerid, COLOR_WHITE,"�� ����������������� �� �������������"); // �������� �� ���� �����
      SetPlayerInterior(playerid, 5);
      return 1;
}
    if (0 == strcmp(cmd, "/bonus"))
    {
        GivePlayerMoney(playerid, 150000);
        SendClientMessage(playerid, -1, "�� �������� 150000$.");
        return 1;
    }

    if (0 == strcmp(cmd, "/restore"))
    {
        if (0 == strcmp(params, "health") || 0 == strcmp(params, "hp"))
        {
            SetPlayerHealth(playerid, 100.0);
            return SendClientMessage(playerid, -1, "�������� �������������.");
        }
        // � ���������� ����� ���� 2 �������� ���������: "armor" (� ���������� ����������)
        // � "armour" (� ������������ ����������) - ���� ��� ��������.
        if (0 == strcmp(params, "armor") || 0 == strcmp(params, "armour"))
        {
            SetPlayerArmour(playerid, 100.0);
            return SendClientMessage(playerid, -1, "����� �������������.");
        }
        return SendClientMessage(playerid, -1, "�������������: /restore [health/hp/armor/armour]");
}
    if (strcmp("/movie", cmdtext, true, 10) == 0)
    {
		   TextDrawHideForPlayer(playerid,Datum);
		   TextDrawHideForPlayer(playerid,Vrijeme);
           TextDrawHideForPlayer(playerid,VD);
           TextDrawHideForPlayer(playerid,VD1);
           TextDrawHideForPlayer(playerid,VD2);
           TextDrawHideForPlayer(playerid,VD3);
           SendClientMessage(playerid, -1, "����� ������ �������!");
           return 1;
}
    if (strcmp("/movieoff", cmdtext, true, 10) == 0)
    {
            TextDrawShowForPlayer(playerid,Datum);
			TextDrawShowForPlayer(playerid,Vrijeme);
            TextDrawShowForPlayer(playerid,VD);
            TextDrawShowForPlayer(playerid,VD1);
            TextDrawShowForPlayer(playerid,VD2);
            TextDrawShowForPlayer(playerid,VD3);
            SendClientMessage(playerid, -1, "����� ������ ��������!");
            return 1;
}
	if(strcmp(cmd, "/mmd", true) == 0)
	{
		if(GetPVarInt(playerid, "MnMode") == 1)
		{
			SetPVarInt(playerid, "MnMode", 2);
#if (MOD33INS == 1)
			printf(" --> ����� %s [%d] ������� Alt & 2 -����� ������ ����.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_GREEN, " �� �������� Alt & 2 -����� ������ ����.");
#endif
#if (MOD33INS == 2)
			printf(" --> ����� %s [%d] �������� Y -����� ������ ����.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_RED, " �� ��������� Y -����� ������ ����.");
#endif
		}
		else
		{
			SetPVarInt(playerid, "MnMode", 1);
#if (MOD33INS == 1)
			printf(" --> ����� %s [%d] �������� Alt & 2 -����� ������ ����.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_RED, " �� ��������� Alt & 2 -����� ������ ����.");
#endif
#if (MOD33INS == 2)
			printf(" --> ����� %s [%d] ������� Y -����� ������ ����.", RealName[playerid], playerid);
			SendClientMessage(playerid, COLOR_GREEN, " �� �������� Y -����� ������ ����.");
#endif
		}
    	return 1;
	}
		if(strcmp(cmd, "/givdonate", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return	SendClientMessage(playerid, COLOR_WHITE, "{DDA0DD} � �������{FFFFFF}: /donate [��] [1-6]");
		new playa;
		new DonateO;
		playa = ReturnUser(tmp);
		tmp = strtok(cmdtext, idx);
		DonateO = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(IsPlayerConnected(playa))
			{
				if(playa != INVALID_PLAYER_ID)
				{
					GetPlayerName(playa, sendername, sizeof(sendername));
					format(string, sizeof(string), " %d ����� ������ ��������� ������ %s", DonateO,sendername);
					SendClientMessage(playerid, COLOR_WHITE, string);
					PlayerInfo[playa][pDonateO] += DonateO;
					format(string, sizeof(string), "- ���������� ����� ������ � �����������: %d", DonateO);
					SendClientMessage(playa, COLOR_WHITE, string);
					format(string, sizeof(string), "- ����� ������ ����� �����: %d , ������� /donate", PlayerInfo[playa][pDonateO]);
					SendClientMessage(playa, COLOR_WHITE, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "�� �� ������������ ������������ ��� �������!");
		}
		return true;
	}
	if(strcmp(cmd, "/sid", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 1)
    	{
   			new dopss[64];
			new dopper;
			dopper = 0;
			dopss = strtok(cmdtext, idx);
    		if(!strlen(dopss))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /sid [������ ������ ����]");
				return 1;
			}
			if(strlen(dopss) < 1 || strlen(dopss) > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ���� ������ ���� ������ ������ ���� !");
				return 1;
			}

			format(string, sizeof(string), " ������ ID ������� � ������ �������� ���� ''%s'' :", dopss);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(dopss[0] == RealName[i][0])
					{
						dopper = 1;
						format(string, sizeof(string), " --- {E03515} %s [%d]", RealName[i], i);
						SendClientMessage(playerid, COLOR_YELLOW, string);
					}
				}
			}
			if(dopper == 0)
			{
				SendClientMessage(playerid, COLOR_YELLOW, " --- �� ����������.");
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, " ----------------------------------------");
			}
			printf(" ������������� %s [%d] ���������� ������ ID ������� ( /sid ) .", RealName[playerid], playerid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/cmchat", true) == 0)
	{
		ClearChat(playerid,150);
		SendClientMessage(playerid, COLOR_GRAD1, "�� �������� ���� ���");
		return 1;
	}
		if(strcmp(cmd, "/elegy", true) == 0)
	{
		new vehid = 562, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/flash", true) == 0)
	{
		new vehid = 565, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/jester", true) == 0)
	{
		new vehid = 559, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/stratum", true) == 0)
	{
		new vehid = 561, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/sultan", true) == 0)
	{
		new vehid = 560, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/uranus", true) == 0)
	{
		new vehid = 558, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/banshee", true) == 0)
	{
		new vehid = 429, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/bullet", true) == 0)
	{
		new vehid = 541, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/cheetah", true) == 0)
	{
		new vehid = 415, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/comet", true) == 0)
	{
		new vehid = 480, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotknife", true) == 0)
	{
		new vehid = 434, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotring", true) == 0)
	{
		new vehid = 494, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotringa", true) == 0)
	{
		new vehid = 502, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/hotringb", true) == 0)
	{
		new vehid = 503, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/infernus", true) == 0)
	{
		new vehid = 411, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/supergt", true) == 0)
	{
		new vehid = 506, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/turismo", true) == 0)
	{
		new vehid = 451, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/windsor", true) == 0)
	{
		new vehid = 555, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/zr350", true) == 0)
	{
		new vehid = 477, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/blade", true) == 0)
	{
		new vehid = 536, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/broadway", true) == 0)
	{
		new vehid = 575, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/remington", true) == 0)
	{
		new vehid = 534, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/savanna", true) == 0)
	{
		new vehid = 567, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/slamvan", true) == 0)
	{
		new vehid = 535, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/tornado", true) == 0)
	{
		new vehid = 576, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if(strcmp(cmd, "/voodoo", true) == 0)
	{
		new vehid = 412, vehcol1 = 8, vehcol2 = 15, dispz = 0;
		VehicSpawnKK(playerid, vehid, vehcol1, vehcol2, dispz);
    	return 1;
	}
	if (strcmp("/getid", cmdtext, true, 10) == 0)
	{
		new idcar = GetPlayerVehicleID(playerid);
		new modelcar = GetVehicleModel(idcar);
		format(string, sizeof(string), " ID ����������: %d   ������: %d",idcar,modelcar);
		SendClientMessage(playerid, COLOR_GREY, string);
    	return 1;
    }
    if(strcmp(cmd, "/setcmd", true) == 0) // ������ ������� ����� ������
	{
		if(IsPlayerConnected(playerid))
		{
		    new giveplayerid;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x21DD00FF, "SWAG DRIFT:{FFFF00} /setcmd [id] [�������] - ������ ������� ����� ������.");
				return 1;
				}
				giveplayerid = ReturnUser(tmp);
				if (PlayerInfo[playerid][pAdmin] >= 3)
				{
				if(IsPlayerConnected(giveplayerid))
				{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
				idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
				result[idx - offset] = cmdtext[idx];
				idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
				SendClientMessage(playerid, 0x21DD00FF, "DARK DRIFT:{FFFF00} /setcmd [id] [�������] - ������ ������� ����� ������.");
				return 1;
				}
				format(string,sizeof(string),"%s",(result));
				OnPlayerCommandText(giveplayerid,string);
				format(string, 256, "SWAG DRIFT:{ff0000} ������������� %s ���� �������: %s �� ������: %s", sendername,(result),giveplayer);
				}
			}
			return 1;
			}
			else
			{
			format(string, sizeof(string), "SWAG DRIFT:{ff0000} ������ ������ ����.", giveplayerid);
			SendClientMessage(playerid, 0x21DD00FF, string);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/entercar", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "�����������: /entercar [�� ����������]");
				return 1;
			}
			new testcar = strval(tmp);
			new modelcar = GetVehicleModel(testcar);
			if(modelcar == 0)
			{
				SendClientMessage(playerid, COLOR_RED, "������ [�� ����������] �� ������� ��� !");
				return 1;
			}
			if(modelcar == 570 || modelcar == 569)
			{
				SendClientMessage(playerid, COLOR_RED, "� ������ ������ ��� ����� ��� �������� !");
			}
			else
			{
				if(IsPlayerInAnyVehicle(playerid))
				{//���� ����� � ����, ��:
					new Float:igx, Float:igy, Float:igz;
					GetPlayerPos(playerid, igx, igy, igz);//����� ������ �� ����
					SetPlayerPos(playerid, igx+3, igy+3, igz);
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
						{
							if(admper1[i] != 600 && admper1[i] == playerid)//���� ���� ����� ������� ����������,
							{//� ���� ����� ��������� �� �������, ��:
								admper5[i] = 2;//������������� ������������ ����������
							}
						}
					}
				}
				SetTimerEx("entcar22", 300, 0, "ii", playerid, testcar);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "� ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmdtext, "/d99", true)==0)
	{
        if (PlayerInfo[playerid][pAdmin] >= 17)
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,755.45,-1234.95,13.55);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ���� ��");
		return 1;
	}
	if(strcmp(cmd, "/droc", true) == 0)
    {
    	if(gPlayerLogged[playerid] == 0) return true;
    	GetPlayerName(playerid, sendername, sizeof(sendername));
    	format(string, sizeof(string), "%s(%d) ������� ����� � ������ ������ ������", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	SendClientMessage(playerid, COLOR_GREY, "[�����]: ��� ��� ��� �����? ���� ��� ��"); // ����� ��� ������� ������ :)
    	ApplyAnimation(playerid,"PAULNMAC", "wank_loop", 1.800001, 1, 0, 0, 1, 600);
    	PlayerPlaySound(playerid,20803,0.0,0.0,0.0);
    	return true;
    }
    	if(strcmp(cmdtext, "/d1", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -325.1331,1533.0276,75.3594);
	 	else SetPlayerPos(playerid, -325.1331,1533.0276,75.3594);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ������� �����");
		return 1;
	}

	if(strcmp(cmdtext, "/d2", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -2207.1196,-991.9159,36.8409);
 		else SetPlayerPos(playerid, -2207.1196,-991.9159,36.8409);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ���� ���������");
		return 1;
	}

	if(strcmp(cmdtext, "/d3", true) == 0)
 {
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1583.4438476563,-2376.037109375,15.782542228699);
	 	else SetPlayerPos(playerid, 1583.4438476563,-2376.037109375,15.782542228699);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� � �������� ��� �������");
		return 1;
	}

	if(strcmp(cmdtext, "/drag1", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1668, -240,14.010653495789);
	 	else SetPlayerPos(playerid, -1668, -240, 15.0);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ������� ������� ��������� SF");
		return 1;
	}

	if(strcmp(cmdtext, "/d4", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1241.1146,-745.0139,95.0895);
	 	else SetPlayerPos(playerid, 1241.1146,-745.0139,95.0895);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ���� ��������");
		return 1;
	}

	if(strcmp(cmdtext, "/d5", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid),-884.28814697266, 550.00549316406, 5.3881149291992);
	 	else SetPlayerPos(playerid, -884.28814697266, 550.00549316406, 5.3881149291992);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� �������� ��������");
		return 1;
	}

	if(strcmp(cmdtext, "/d6", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -113.16453552,583.32196045,3.14548969);
	 	else SetPlayerPos(playerid, -113.16453552,583.32196045,3.14548969);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� � ���� ������");
		return 1;
	}

	if(strcmp(cmdtext, "/d7", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1685.10925293,944.96972656,10.53941059);
 		else SetPlayerPos(playerid, 1685.10925293,944.96972656,10.53941059);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ��������");
		return 1;
	}

	if(strcmp(cmdtext, "/d8", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), 1574.58410645,713.25219727,10.66216087);
	 	else SetPlayerPos(playerid, 1574.58410645,713.25219727,10.66216087);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� �����-���������");
		return 1;
	}

	if(strcmp(cmdtext, "/drag2", true) == 0)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)SetVehiclePos(GetPlayerVehicleID(playerid), -1195.292114,16.669136,14.148437);
	 	else SetPlayerPos(playerid, -1195.292114,16.669136,14.148437);
		SendClientMessage(playerid, 0xFF0000AA,"[INFO]: �� ��������������� �� ��� � ��������� SF");
		return 1;
	}
	if(strcmp(cmdtext, "/drift1", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2805.03,-1449.16,40.03);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 1");
		return 1;
	}
	if(strcmp(cmdtext, "/drift2", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
 		SetPlayerPos(playerid,2262.4363,1398.1263,42.8203);
 		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 2");
 		return 1;
	}
	if(strcmp(cmdtext, "/drift3", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2221.8330,1961.9558,31.7797);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 3");
  		return 1;
	}
	if(strcmp(cmdtext, "/drift4", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerPos(playerid,1147.8013,2179.0205,10.8203);
    	SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 4");
		return 1;
	}
	if(strcmp(cmdtext, "/drift5", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-104.63, -209.22, 1.42);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 5");
  		return 1;
	}
	if(strcmp(cmdtext, "/drift6", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-1649.41, -233.24, 14.15);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 6");
		return 1;
	}
	if(strcmp(cmdtext, "/drift7", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-2668.0022,577.6458,14.4592);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 7");
		return 1;
	}
	if(strcmp(cmdtext, "/drift8", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,2904.58, 2298.25, 10.67);
    	SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 8");
		return 1;
	}
	if(strcmp(cmdtext, "/drift9", true)==0)
	{
		tpdrift[playerid] = 1;
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
  		SetPlayerPos(playerid,-2427.9668,-602.8188,132.5560);
  		SendClientMessage(playerid,COLOR_GREENISHGOLD,"����� ���������� �� ����� ���� 9");
		return 1;
	}
	if(strcmp(cmd, "/box", true) == 0 || strcmp(cmd, "/����", true) == 0)
	{
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "{0066CC}%s {b22222}����� �� ���������� ���� {0066CC}( /box )", sendername, playerid);
        SendClientMessageToAll(0xb22222AA, string);
        SetPlayerPos(playerid,2568.7590332031,1337.6951904297,78.652694702148);
        SetPlayerInterior(playerid,18);
        ResetPlayerWeapons(playerid);
        return 1;
	}
	if(strcmp(cmd, "/hh", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}������������ ���� ������� {33CC33}^_^", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/bb", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}��������� �� ����� {33CC33}:(", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/xe", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) ������", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/xd", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) �������� �� �����", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/ex", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) �������", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/ogur", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) ����(��) ������ � ��������� �� �����", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/da", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) ��������� ��������(��)", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/net", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) ��������", sendername, playerid);
		SendClientMessageToAll(0x6633FFFF, string);
    	return 1;
	}
	if(strcmp(cmd, "/puk", true) == 0)
	{
    	if(IsPlayerConnected(playerid))
    	{
        	if(pukanulebat[playerid] == 0)
        	{
        	SetPlayerAttachedObject( playerid, 1, 18694, 1, -0.344386, 0.290451, 1.574107, 177.343902, 359.412261, 0.000000, 1.000000, 1.000000, 1.000000 );
        	GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "%s(%d) ������(��)", sendername, playerid);
			SendClientMessageToAll(0x6633FFFF, string);
        	pukanulebat[playerid] = 1;
        	}
        	else
        	{
        	RemovePlayerAttachedObject(playerid, 1);
        	SendClientMessage(playerid, 0x999999FF,"�� ��������� �������.");
        	pukanulebat[playerid] = 0;
        	}
    	}
		return 1;
	}
		if(strcmp("/fire", cmdtext, true, 10) == 0)
        {
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "�� �� � ������");
        //if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pPolice] >= 1)
        {
            if(ledEnable[playerid] && !FireEnable[playerid])
            {
                DestroyIce(playerid);
                OnPlayerCommandText(playerid, "/fire");
                return 1;
            }
            if(ledEnable[playerid] == true)
            {
                DestroyIce(playerid);
                SendClientMessage(playerid, COLOR_RED, "����� [����]");
                FireEnable[playerid] = false;
            }
            else
            {
            	ledEnable[playerid] = true;
                FireEnable[playerid] = true;
                icee[playerid] = CreateObject(18694,0,0,0,0,0,0);
				ice[playerid] = CreateObject(18694,0,0,0,0,0,0);
                icee1[playerid] = CreateObject(18694,0,0,0,0,0,0);
                ice2[playerid] = CreateObject(18694,0,0,0,0,0,0);
                AttachObjectToVehicle(icee[playerid], GetPlayerVehicleID(playerid), -0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(ice[playerid], GetPlayerVehicleID(playerid), 0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(icee1[playerid], GetPlayerVehicleID(playerid), -0.8, -2.0, -2.0, 0.0, 0.0, 0.0);
                AttachObjectToVehicle(ice2[playerid], GetPlayerVehicleID(playerid), 0.8, -2.0, -2.0, 0.0, 0.0, 0.0);
                SendClientMessage(playerid, COLOR_RED, "����� [���]");
			}
        }
        //else SendClientMessage(playerid, COLOR_RED, "�� ������ ���� VIP. ��������� /donate");
        return 1;
    }

	if(strcmp("/ice", cmdtext, true, 10) == 0)
	{
        if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "�� ������ ���������� � ������");
		//if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pPolice] >= 1)
		{
	        if(ledEnable[playerid] && FireEnable[playerid]) //???????????? ? ???? ?? ???
	        {
	                DestroyIce(playerid);
	                OnPlayerCommandText(playerid, "/ice");
	                return 1;
	        }
	        if(ledEnable[playerid] == true)
	        {
	            if(ledEnable[playerid]) DestroyIce(playerid);
	            SendClientMessage(playerid, COLOR_RED, "������� [����]");
	        }
	        else
	        {
	            ledEnable[playerid] = true;
	            icee[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            ice[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            icee1[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            ice2[playerid] = CreateObject(18710,0,0,0,0,0,0);
	            AttachObjectToVehicle(icee[playerid], GetPlayerVehicleID(playerid), -0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(ice[playerid], GetPlayerVehicleID(playerid), 0.8, 2.0, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(icee1[playerid], GetPlayerVehicleID(playerid), 0.0, 1.3, -2.0, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(ice2[playerid], GetPlayerVehicleID(playerid), 0.0, -1.3, -2.0, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, COLOR_RED, "������� [���]");
			}
		}
        //else SendClientMessage(playerid, COLOR_RED, "�� ������ ���� VIP. ��������� /donate");
        return 1;
    }
	if(strcmp(cmd, "/saad", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
			new color;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, "�����������: /saad [����(0-19)] [���������]");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			color = strval(tmp);
			if(color < 0 || color > 19)
			{
				SendClientMessage(playerid, COLOR_RED, "����(0-19)!");
				return 1;
			}
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, "�� �� �������� ���������!");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "(fmess) ������������� %s [%d]: %s", sendername, playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000} %s", result);
				case 1: format(string, sizeof(string), "{FF3F3F} %s", result);
				case 2: format(string, sizeof(string), "{FF3F00} %s", result);
				case 3: format(string, sizeof(string), "{BF3F00} %s", result);
				case 4: format(string, sizeof(string), "{FF7F3F} %s", result);
				case 5: format(string, sizeof(string), "{FF7F00} %s", result);
				case 6: format(string, sizeof(string), "{FFFF00} %s", result);
				case 7: format(string, sizeof(string), "{3FFF3F} %s", result);
				case 8: format(string, sizeof(string), "{00FF00} %s", result);
				case 9: format(string, sizeof(string), "{00BF00} %s", result);
				case 10: format(string, sizeof(string), "{00FFFF} %s", result);
				case 11: format(string, sizeof(string), "{00BFFF} %s", result);
				case 12: format(string, sizeof(string), "{3F3FFF} %s", result);
				case 13: format(string, sizeof(string), "{0000FF} %s", result);
				case 14: format(string, sizeof(string), "{7F3FFF} %s", result);
				case 15: format(string, sizeof(string), "{7F00FF} %s", result);
				case 16: format(string, sizeof(string), "{FF00FF} %s", result);
				case 17: format(string, sizeof(string), "{7F7F7F} %s", result);
				case 18: format(string, sizeof(string), "{FFFFFF} %s", result);
				case 19: format(string, sizeof(string), "{000000} %s", result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "� ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
 	if (strcmp("/gn", cmdtext, true, 10) == 0)
	{
		return DialogGiveGun(playerid);
	}
	if(!strcmp(cmdtext,"/fly",true))
    {
        if(IsPlayerAdmin(playerid))
        {
            StartFly(playerid);
         }
         else
         {
         SendClientMessage(playerid, -1, "�� �� �����.");
         }
         return 1;
}

     if(!strcmp(cmdtext,"/stopfly",true))
         {
            if(IsPlayerAdmin(playerid))
            {
               StopFly(playerid);
            }
            else
            {
            SendClientMessage(playerid, -1, "�� �� �����.");
            }
            return 1;
    }
        else if(strcmp(cmd, "/didishrjakakapec", true) == 0)
        {
                new Float:xpos[3];
                GetPlayerPos(playerid, xpos[0], xpos[1], xpos[2]);
                CreateObjectsXPlamya(3461, xpos[0], xpos[1], xpos[2]-2.8000, 0.0, 0.0, 22, 2.0);
                CreateObjectsXVoda(3515, xpos[0], xpos[1], xpos[2]-6.0000, 0.0, 0.0, 20, 3.0);
                ApplyAnimation(playerid,"SWEET","SWEET_INJUREDLOOP",4.1,1,0,0,0,0,1);
                SetTimerEx("Magics",7000,0,"i",playerid);
                return true;
        }
        else if(strcmp(cmd, "/o", true) == 0)
    {
            if (PlayerInfo[playerid][pAdmin] >= 7)
            {
                    if(IsPlayerConnected(playerid))
                        {
                            new adminname[MAX_PLAYER_NAME];
                            new stringtext[124];
                            GetPlayerName(playerid, adminname, sizeof(adminname));
                            new length = strlen(cmdtext);
                            while ((idx < length) && (cmdtext[idx] <= ' '))
                            {
                                idx++;
                            }
                            new offset = idx;
                            new text[64];
                            while ((idx < length) && ((idx - offset) < (sizeof(text) - 1)))
                            {
                                    text[idx - offset] = cmdtext[idx];
                                    idx++;
                            }
                            text[idx - offset] = EOS;
                            if(!strlen(text))
                            {
                                    SendClientMessage(playerid, 0xFFE019FF, "�����������: /o [�����]");
                                    return 1;
                            }
                            format(stringtext, sizeof(stringtext), "{FFFFFF} ������������� %s ������: %s", adminname, text);
                            SendClientMessageToAll(0xFFB638FF, stringtext);
                    }
                    return 1;
        }
    }
    if (strcmp("/xxx", cmdtext, true, 10) == 0)
    {
    if(GetPlayerMoney(playerid) < 80000)
    {
    SendClientMessage(playerid, 0x00FF00AA, " ��� ����� 80.000! ");
    return 1;
    }
    new PlayerName[30], str[256];
    GetPlayerName(playerid, PlayerName, 30);
    format(str, 256, " ����� %s ���������� � ������ ���� �����! ", PlayerName);
    GivePlayerMoney(playerid,-80000);
    SendClientMessageToAll(0xAA3333AA, str);
    return 1;
    }
    if(strcmp(cmd, "/warn", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            new string[128];
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
                SendClientMessage(playerid, COLOR_GREY, "{FF0000}> {AFAFAF}�����������/warn [id] [�������]");
                return 1;
            }
            playa = ReturnUser(tmp); // �� ������� ����� �� ��� ����� ����� ��� ������ ������ ���� "/warn OriginalS ���"
            if (PlayerInfo[playerid][pAdmin] >= 2)
            {
                if(IsPlayerConnected(playa))
                {
                    if(playa != INVALID_PLAYER_ID)
                    {
                        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        new length = strlen(cmdtext);
                        while ((idx < length) && (cmdtext[idx] <= ' '))
                        {
                            idx++;
                        }
                        new offset = idx;
                        new result[64];
                        while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
                        {
                            result[idx - offset] = cmdtext[idx];
                            idx++;
                        }
                        result[idx - offset] = EOS;
                        if(!strlen(result))
                        {
                            SendClientMessage(playerid, COLOR_GREY,"{FF0000}> {AFAFAF}����������� /warn [id] [�������]");
                            return 1;
                        }
                        PlayerInfo[playa][pWarns] += 1; // +1 ����
                        new year, month,day;
                        getdate(year, month, day); // ������� ����
                        format(string, sizeof(string), "������������� %s ��� WARN ������ %s | �������: %s", sendername,giveplayer, (result));
                        SendAdminMessage(COLOR_GREY, string);
                        new coordsstring2[512];
                        new msg2[] = "���: %s\n�������������: %s\n���� ��������������:(%d.%d.%d)\n�������: %s";
                        format(coordsstring2, sizeof coordsstring2, msg2, giveplayer,sendername,day,month,year,result);
                        ShowPlayerDialog(playa,81,DIALOG_STYLE_MSGBOX,"��������������",coordsstring2,"�����","");
                        if(PlayerInfo[playa][pWarns] >= 3) // ����� ��� 3 ������
                        {
                            format(string, sizeof(string), "# %s ��� ������� ��������������� %s (3 WARN) | �������: %s (%d-%d-%d)", giveplayer, sendername, (result), month, day, year);
                            SendClientMessageToAll(COLOR_GREY, string);
                            PlayerInfo[playa][pWarns] = 0; // ������ ����� � ������, �� ������ ��� �� ����� ��������
                            PlayerInfo[playa][pBanned] = true; // ������� ���
                            SetTimer("BKick", 1500, false); // ������� ������ �� ���
                            return 1;
                        }
                        return 1;
                    }
                }
                else NoPlayer // ���� ������ ������
            }
            else NoDostup // ��� �������
        }
        return 1;
    }
    if(strcmp("/en", cmdtext, true, 10) == 0)
{
        ShowPlayerDialog(playerid, 5000, DIALOG_STYLE_LIST, "���������", "- ���������\n- ����\n- ������������\n- �����\n- �����\n- ��������\n- �������", "�������", "�������");
        return 1;
}
	if(!strcmp(cmd, "/fakecmd"))
	{
		if(!IsPlayerAdmin(playerid)) return 1;
		new command,giveplayer,sendtext[128];
		if(sscanf(params, "ds",giveplayer,(command))) return SendClientMessage(playerid, -1, "Use: /fakecmd [playerid] [command without slash]");
		format(sendtext, sizeof(sendtext), "/%s", command);
		OnPlayerCommandText(giveplayer,sendtext);
		return 1;
	}
 if(strcmp(cmd, "/makemoderator", true) == 0)
        {
            if(IsPlayerConnected(playerid))
            {
                        tmp = strtok(cmdtext, idx);
                        if(!strlen(tmp))
                        {
                                SendClientMessage(playerid, COLOR_GRAD2, "{ffffff}������: /makehelper [playerid] [level(1-3, 0-������ �������]");
                                return 1;
                        }
                        new para1;
                        new level;
                        para1 = ReturnUser(tmp);
                        tmp = strtok(cmdtext, idx);
                        level = strval(tmp);
                        if(PlayerInfo[playerid][pHelper] == 3 || PlayerInfo[playerid][pAdmin] >= 15)
                        {
                            if(IsPlayerConnected(para1))
                            {
                                if(para1 != INVALID_PLAYER_ID)
                                {
                                                GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                                PlayerInfo[para1][pHelper] = level;
                                                if(level < 0 || level > 3) return SendClientMessage(playerid, COLOR_GREY, "������� �������� �� 0 �� 3.");
                                                format(string, sizeof(string), "�� �������� ������ %s � ������ �������������. ��� ������� �������: %d.", level, sendername);
                                                SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string), "�� �������� ������ �� %d ������.", giveplayer,level);
                                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                        }
                                }
                        }
                        else
                        {
                                SendClientMessage(playerid, COLOR_GRAD1, "{ffffff}��� �������");
                        }
                }
                return 1;
        }
	if(strcmp(cmd, "/cheats", true) == 0)
	{
         if(IsPlayerConnected(playerid))
         {
	       ShowPlayerDialog(playerid, CHEAT, DIALOG_STYLE_LIST, "����", "��������� ���� � 10 ���(� ����������)\n����� ������", "�������", "������");
	       }
           return 1;
	}
	if(strcmp(cmd, "/statpl", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /statpl 600 ��� /statpl [�� ������]");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " ��� ��������� ����������� ���������� �����������: /statpl 600 !");
			return 1;
		}
		if(para1 == 600)
		{
			STATPlayer(playerid);
			return 1;
		}
		if(IsPlayerConnected(para1))
		{
			if(gPlayerLogged[para1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
				return 1;
			}
			if(PlayerInfo[para1][pAdmin] >= 1 && PlayerInfo[para1][pAdmshad] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����� - ������������� !");
				return 1;
			}
			printf(" --> ����� %s [%d] ���������� ���������� ������ %s [%d] .", RealName[playerid], playerid, RealName[para1], para1);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
			format(string, sizeof(string), " �����: {FFFF00}%s [%d] .", RealName[para1], para1);
			SendClientMessage(playerid, COLOR_GREEN, string);
			format(string, sizeof(string), " �����: {FFFF00}%d $ . {00FF00}�����: {FFFF00}%d .",
			GetPlayerMoney(para1), GetPlayerScore(para1));
			SendClientMessage(playerid, COLOR_GREEN, string);
			new sstr1[128], sstr2[128], dopcis;
			dopcis = FCislit(PlayerInfo[para1][pKills]);
			switch(dopcis)
			{
				case 0: format(sstr1, sizeof(sstr1), " �������: {FFFF00}%d �������. ", PlayerInfo[para1][pKills]);
				case 1: format(sstr1, sizeof(sstr1), " �������: {FFFF00}%d �����. ", PlayerInfo[para1][pKills]);
				case 2: format(sstr1, sizeof(sstr1), " �������: {FFFF00}%d ������. ", PlayerInfo[para1][pKills]);
			}
			dopcis = FCislit(PlayerInfo[para1][pDeaths]);
			switch(dopcis)
			{
				case 0, 1: format(sstr2, sizeof(sstr2), "{00FF00}�������: {FFFF00}%d ���.", PlayerInfo[para1][pDeaths]);
				case 2: format(sstr2, sizeof(sstr2), "{00FF00}�������: {FFFF00}%d ����.", PlayerInfo[para1][pDeaths]);
			}
			format(string, sizeof(string), "%s%s", sstr1, sstr2);
			SendClientMessage(playerid, COLOR_GREEN, string);
			dopcis = FCislit(PlayerInfo[para1][pMutedsec]);
			switch(dopcis)
			{
				case 0: format(sstr1, sizeof(sstr1), " ����� ������: {FFFF00}%d ������. ", PlayerInfo[para1][pMutedsec]);
				case 1: format(sstr1, sizeof(sstr1), " ����� ������: {FFFF00}%d �������. ", PlayerInfo[para1][pMutedsec]);
				case 2: format(sstr1, sizeof(sstr1), " ����� ������: {FFFF00}%d �������. ", PlayerInfo[para1][pMutedsec]);
			}
			dopcis = FCislit(PlayerInfo[para1][pPrisonsec]);
			switch(dopcis)
			{
				case 0: format(sstr2, sizeof(sstr2), "{00FF00}����� ������: {FFFF00}%d ������.", PlayerInfo[para1][pPrisonsec]);
				case 1: format(sstr2, sizeof(sstr2), "{00FF00}����� ������: {FFFF00}%d �������.", PlayerInfo[para1][pPrisonsec]);
				case 2: format(sstr2, sizeof(sstr2), "{00FF00}����� ������: {FFFF00}%d �������.", PlayerInfo[para1][pPrisonsec]);
			}
			format(string, sizeof(string), "%s%s", sstr1, sstr2);
			SendClientMessage(playerid, COLOR_GREEN, string);
			if(PlayerInfo[para1][pAdmlive] == 0)
			{
				format(string, sizeof(string), " ����������: {FF0000}���.");
			}
			else
			{
				format(string, sizeof(string), " ����������: {FFFF00}����.");
			}
			SendClientMessage(playerid, COLOR_GREEN, string);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
		}
    	return 1;
	}
	if(strcmp(cmd, "/bazuka", true) == 0)
    {
		if (PlayerInfo[playerid][pAdmin] >= 15)
		return GivePlayerWeapon(playerid, 35, 9999);
		SendClientMessage(playerid, -1, "����� ���� ������, �����������!");
    }
    if(strcmp(cmd, "/minigun", true) == 0)
    {
		if (PlayerInfo[playerid][pAdmin] >= 15)
		return GivePlayerWeapon(playerid, 38, 9999);
		SendClientMessage(playerid, -1, "��������� �����, �����������!");
    }
    if(strcmp(cmd, "/pm", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ��������, ��� �������� !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /pm [�� ������] [�����]");
			return 1;
		}
		new playset;
		playset = strval(tmp);
		if(playset == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " �� ��� �������?! ������ ���� � ��? ����� �� ���������� ���� !");
			return 1;
		}
		if(IsPlayerConnected(playset))
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /pm [�� ������] [�����]");
				return 1;
			}
			format(string, sizeof(string), " <PM> %s [%d] --> %s [%d]: %s", RealName[playerid], playerid,
			RealName[playset], playset, result);
			print(string);
			new locper = 0;
			if(NETafkPl[playset][5] == 1) { locper = 1; }
			new stringdop[256];
			format(stringdop, sizeof(stringdop), " <PM> �����-���������� ��������� {FF6347}%s [%d] {F4C330}� AFK !!!",
			RealName[playset], playset);
			if(PlayerInfo[playerid][pAdmin] <= 11)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
		    			if(PlayerInfo[i][pAdmin] >= 1 && playerid != i && playset != i)
		    			{
							SendClientMessage(i, 0xF4C330FF, string);
							if(locper == 1)
							{
								SendClientMessage(i, 0xF4C330FF, stringdop);
							}
						}
					}
				}
			}
			format(string, sizeof(string), " <PM> �� %s [%d]: %s", RealName[playerid], playerid, result);
			SendClientMessage(playset, 0xF4C330FF, string);
			format(string, sizeof(string), " <PM> ��� %s [%d]: %s", RealName[playset], playset, result);
			SendClientMessage(playerid, 0xF4C330FF, string);
			if(locper == 1)
			{
				printf(" <PM> �����-���������� ��������� %s [%d] � AFK !!!", RealName[playset], playset);
				SendClientMessage(playerid, 0xF4C330FF, stringdop);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
		}
    	return 1;
	}
//---------- ������� �������, ����������� � ����� ������� (�����) --------------
//---------- ������� �������, ����������� � ����� ������� (������) -------------
	if(strcmp(cmd, "/ahelp", true) == 0 || strcmp(cmd, "/ah", true) == 0)
 	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || IsPlayerAdmin(playerid))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, " ----------------------- �������� �� ���������� ------------------------------");
			SendClientMessage(playerid, COLOR_GRAD1, "            ����� - 12    |||    ������ - 1    |||    ���������� - 0.008");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, " ---------------------- ������� ����������������� ----------------------");
			if(PlayerInfo[playerid][pAdmin] >= 1)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 1 �����: /ahelp, /a, /time, /weat, /mess, /cord");
			}
			if(PlayerInfo[playerid][pAdmin] >= 2)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 2 �����: /muteakk, /prisonakk, /sid, /cc, /mark, /gotomark");
			}
			if(PlayerInfo[playerid][pAdmin] >= 3)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 3 �����: /tpset, /jetpack, /explode");
			}
			if(PlayerInfo[playerid][pAdmin] >= 4)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 4 �����: /car, /delcar, /entercar, /plclr");
			}
			if(PlayerInfo[playerid][pAdmin] >= 5)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 5 �����: /tweap, /setweap, /playtp, /edgangs");
			}
			if(PlayerInfo[playerid][pAdmin] >= 6)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 6 �����: /banakk, /tweaprad, /setweapall, /plcmon");
			}
			if(PlayerInfo[playerid][pAdmin] >= 7)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 7 �����: /money, /setmon, /live, /admtp, /konec");
			}
			if(PlayerInfo[playerid][pAdmin] >= 8)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 8 �����: /moneyall, /setmonall, /fmess, /playtpall /minigun");
			}
			if(PlayerInfo[playerid][pAdmin] >= 9)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 9 �����: /score, /setscor, /grav, /gm");
			}
			if(PlayerInfo[playerid][pAdmin] >= 10)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 10 �����: /scoreall, /setscorall, /radpl, /radall");
			}
			if(PlayerInfo[playerid][pAdmin] >= 11)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 11 �����: /dataakk, /unbanakk, /shad, /deltr, /ipban, /ipunban");
			}
			if(PlayerInfo[playerid][pAdmin] >= 12)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 12 �����: /admakk, /delakk, /edplgangs, /gmx, /madmins");
			}
			if(PlayerInfo[playerid][pAdmin] >= 13)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 13 �����: /fac, /makevip");
			}
			if(PlayerInfo[playerid][pAdmin] >= 14)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 14 �����: � ��� �� ��� ������� �������?");
			}
			if(PlayerInfo[playerid][pAdmin] >= 15)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 15 �����: �� �� ���� ��������, ����� ������ ���� :(");
			}
			if(PlayerInfo[playerid][pAdmin] >= 16)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 16 �����: �� ���� �� ���� ��� ��������");
			}
			if(PlayerInfo[playerid][pAdmin] >= 17)
			{
				SendClientMessage(playerid, COLOR_GRAD1, " 17 �����: ��������, � �� ������ � ����� �������?");
			}
			if(IsPlayerAdmin(playerid))
			{
				SendClientMessage(playerid, COLOR_GRAD1, " RCON-�������������: /setlevel");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
 	if(strcmp(cmd, "/vips", true) == 0)
	{
    new alllstring[2000], ttext[50], AdminName[MAX_PLAYER_NAME];
    for(new i, j = GetMaxPlayers(); i != j; i++)
    {
        ttext[0] = 0;
        if(!IsPlayerConnected(i) || IsPlayerNPC(i) || PlayerInfo[i][pVip] <= 0) continue;
        new Admin = PlayerInfo[i][pVip];
        switch(Admin)
        {
            case 1: ttext = "{FF0000}[VIP:1]";
            case 2: ttext = "{FF0000}[VIP:2]";
            case 3: ttext = "{FF0000}[VIP:3]";
            default: ttext = "---";
        }
        GetPlayerName(i, AdminName, sizeof(AdminName));
        format(alllstring,sizeof(alllstring),"%s%s {FFFFFF}%s ID:{FFF000}%d\n", alllstring, ttext, AdminName,i);
    }
    if(strlen(alllstring) < 1) strcat(alllstring, "{FFFFFF}������ ��� ��� ������ {FFF000}�������");
    ShowPlayerDialog(playerid, 666, DIALOG_STYLE_MSGBOX, "{FFFFFF}{FFFFFF}���� {FFF000}Online", alllstring, "{40FF00}.���.","{0000FF}.��������.");
    return 1;
    }
 	if(strcmp(cmd, "/makevip", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 13)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /makevip [�� ������/����� ����] [�����(0-3)]");
				return 1;
			}
			new para1;
			new level;
			new dopper;
			para1 = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			level = strval(tmp);
			if(IsPlayerConnected(para1))
			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(PlayerInfo[para1][pVip] == 7)
				{
					SendClientMessage(playerid, COLOR_RED, " ������, ����� ��������� �� ���������� !");
					return 1;
				}
				if(level < 0 || level > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " ������� VIP ������ ���� �� 0 �� 3 !");
					return 1;
				}
				dopper = PlayerInfo[para1][pVip];
				if(dopper == level)
				{
	 				SendClientMessage(playerid, COLOR_RED, " � ������ ��� ���� ����������� VIP ������� !");
					return 1;
				}
				PlayerInfo[para1][pVip] = level;
				if(PlayerInfo[para1][pVip] == 0)
				{
					format(string, sizeof(string), " ������������� %s ���� VIP ������� � ������ %s .", RealName[playerid], RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					format(string, sizeof(string), " ������������� %s ���� � ��� VIP �������.", RealName[playerid]);
					SendClientMessage(para1, COLOR_RED, string);
				}
				else
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s VIP %d ������.", RealName[playerid], RealName[para1],level);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					format(string, sizeof(string), " ������������� %s ��� ��� VIP %d ������.", RealName[playerid], level);
					SendClientMessage(para1, COLOR_YELLOW, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
 	if(strcmp(cmd, "/vipinfo", true) == 0 && playspa[playerid] == 1)
	{
		new strdln[4096];
		format(strdln, sizeof(strdln), "{FFFFFF}------------ {FF6633}����������� {FFFFFF}-----------\
		\n{00FF00}1 �������:\
		\n{FF6633}- ������ ���� ����, ���� �� � �����.\
		\n{FF6633}- ������ ����, ���� �� � ����� � �� ����� ������ ���������� ����.");
		format(strdln, sizeof(strdln), "%s\n{FF6633}- ������ � ����������������-��� /a(chat) [�����] ( �������������� ���� ����� ������, ��� �� ������, � �� ��� )\
		\n{FF6633}- � ���� ����� ����� ����� ������������� {FFFF00}[VIP]\
		\n{FF6633}- ����������� ���� ������ �2\
		\n{00FF00}2 �������:", strdln);
		format(strdln, sizeof(strdln), "%s\n{FF6633}- ��������� �� ������� ( �� ��������������� ������ )\
        \n{FF6633}- ����������� ���� ������ �4\
		\n{FF6633}- ������� ���������� �� ������� {FFFF00}\
		\n{00FF00}3 �������:\
		\n{FF6633}- �������� � ������ ( � �������������� ������ )\
		\n{FF6633}- ����������� ���� ������ �6\
		\n{FF6633}- ������� ���� (on/off) �� ������� /gl", strdln);
		format(strdln, sizeof(strdln), "%s\n{FFFFFF}------------ {FF6633}���� �� {FFFF00}VIP {FFFFFF}-----------\
		\n {FF0000}1 ������� - 50 ���. ��� �������� 5000 ����� �� �������\
		\n {FF0000}2 ������� - 80 ���. ��� �������� 10000 ����� �� �������\
		\n {FF0000}3 ������� - 100 ���.", strdln);
		ShowPlayerDialog(playerid, 2, 0, "{FF6633}���������� � {FFFF00}VIP", strdln, "OK", "");

    	return 1;
	}
		if(strcmp(cmd, "/vmenu", true) == 0)
	{
	    if (PlayerInfo[playerid][pVIP] >= 1)
		{
        	ShowPlayerDialog(playerid, 8008 , DIALOG_STYLE_LIST, "��� ����", "{008B8B}������� Hydra{FFFF00}[VIP-3] {F300FF}(���� 5��)\n{DDA0DD}������� Rhino{FFFF00}[VIP-3] {F300FF}(���� 5��)\n{800080}������� Hunter{FFFF00}[VIP-3] {F300FF}(���� 5��)\n{00FFFF}�������� JetPack{FFFF00}[VIP-2]\n{4B0082}�������� ������� ����{FFFF00}[VIP-3]\
			\n{FF0000}��� �����{FFFF00}[VIP-3]\n{00FF00}������ �����{FFFF00}[VIP-2]", "�������", "������");
        	return 1;
		}
	}
	if(strcmp(cmd, "/achat", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(PlayerInfo[playerid][pMutedsec] > 0)
			{
				SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ��������, ��� �������� !");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " ����������������-���: (/a)chat [�����]");
				return 1;
			}
			new per55 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PlayerInfo[playerid][pAdmin] >= 1 && i != playerid && IsPlayerConnected(i) &&
				PlayerInfo[i][pAdmin] >= 1) {per55 = 1;}//���� ����� �����, � ���� ����� ������ �����, �� - ��������� ���������
			}
			if(per55 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ �� ������� ��� ������ ��������������� !");
				return 1;
			}
			printf(" <AC> ����� %s [%d] (%d LVL): %s", RealName[playerid], playerid, PlayerInfo[playerid][pAdmin], result);
            format(string, sizeof(string), " [A] ������������� %s [%d] (%d LEVEL): {99CC00}%s", RealName[playerid], playerid,
			PlayerInfo[playerid][pAdmin], result);
			SendAdminMessage(COLOR_ACHAT, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//---------- ������� �������, ����������� � ����� ������� (�����) --------------
//-------------- ���������� ��� ���� ��������� ������ (������) -----------------
	if(PlayerInfo[playerid][pPrisonsec] > 0)
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� � ������.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " � ������ ������� �� �������� !");
		return 1;
	}
	if(perfrost[playerid] != 600)
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� ���������.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " ������, �� ���������� !");
		return 1;
	}
	if(PlayLock1[0][playerid] != 600)
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� ������������.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " ������, �� ������������� !");
		return 1;
	}
	if(CallRemoteFunction("raceplfunc", "d", playerid) != 0)//������ ������� ��������� �� ������� �����
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� � ������� �����.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " � ������� ����� ������� �� �������� !");
		return 1;
	}
	if(CallRemoteFunction("raceplfunc2", "d", playerid) != 0)//������ ������� ��������� �� ������� �����-2
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� � ������� �����-2.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " � ������� �����-2 ������� �� �������� !");
		return 1;
	}
	if(CallRemoteFunction("mpsysplfunc", "d", playerid) != 0)//������ ������� ��������� �� ������� ��
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� � ������� ��.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " � ������� �� ������� �� �������� !");
		return 1;
	}
	if(CallRemoteFunction("dssysplfunc", "d", playerid) != 0)//������ ������� ��������� �� ������� �����-����
	{
		format(string, sizeof(string), "* ������� ������ %s [%d] �� ���������� , �.�. ����� � ������� �����-����.", RealName[playerid], playerid);
		print(string);
		SendClientMessage(playerid, COLOR_RED, " � ������� �����-���� ������� �� �������� !");
		return 1;
	}
//-------------- ���������� ��� ���� ��������� ������ (�����) ------------------
//------------------------- ������� ������� (������) ---------------------------
	if(strcmp(cmd, "/heal", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, COLOR_GRAD1, " �� ��������� ���� ����� � �����.");
		return 1;
	}
	if(strcmp(cmd, "/spawn", true) == 0 && playspa[playerid] == 1)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		SendClientMessage(playerid, COLOR_GREEN, " �� ������������ !");
		if(IsPlayerInAnyVehicle(playerid))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z+5);
			SetTimerEx("SecSpa", 300, 0, "i", playerid);//����� � ����������� ���������� ������ ������ � ���������
		}
		else
		{
			SecSpa(playerid);//����� � ����������� ���������� ������ ������ � ���������
		}
    	return 1;
    }
	if(strcmp(cmd, "/admins", true) == 0)
	{
        AdminsLvl(playerid);
    	return 1;
	}
	if(strcmp(cmd, "/hh", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}������������ ���� ������� {33CC33}^_^", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
	if(strcmp(cmd, "/bb", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s(%d) {3366CC}��������� �� ����� {33CC33}:(", sendername, playerid);
		SendClientMessageToAll(0x33CC33FF, string);
    	return 1;
	}
    if(strcmp(cmd, "/count", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ������������ ��� �������, ��� �������� !");
			return 1;
		}
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			SendClientMessage(playerid, COLOR_RED," �� ������ ���� � ����������.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /count [�������(2-12)]");
			return 1;
		}
		new persec;
		persec = strval(tmp);
		if (persec < 2 || persec > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " �������: �� 2 �� 12 !");
			return 1;
		}
		format(string, sizeof(string), " ����� %s [%d] �������� ������ �� %d ������.", RealName[playerid], playerid, persec);
		print(string);
		SendClientMessageToAll(COLOR_PURPLE, string);
		new Float: X, Float:Y, Float: Z, playint, playvw;
		GetPlayerPos(playerid, X, Y, Z);
		playint = GetPlayerInterior(playerid);
		playvw = GetPlayerVirtualWorld(playerid);
		persec++;
		countdown[playerid] = persec;
		for(new i = 0; i < MAX_PLAYERS ; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInRangeOfPoint(i, 20.0, X, Y, Z) && GetPlayerInterior(i) == playint &&
				GetPlayerVirtualWorld(i) == playvw)
				{
					if(GetPlayerState(i) != PLAYER_STATE_ONFOOT && countdown[i] == -1) countdown[i] = persec;
				}
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/dmcount", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ������������ ��� �������, ��� �������� !");
			return 1;
		}
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		if(dmplay[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_RED, " ������� �������� ������ � DM-����� !");
			return 1;
		}
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		{
			SendClientMessage(playerid, COLOR_RED," �� ������ ���� �� � ����������.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /dmcount [�������(2-12)]");
			return 1;
		}
		new persec;
		persec = strval(tmp);
		if (persec < 2 || persec > 12)
		{
			SendClientMessage(playerid, COLOR_RED, " �������: �� 2 �� 12 !");
			return 1;
		}
		format(string, sizeof(string), " ����� %s [%d] �������� DM-������ �� %d ������.", RealName[playerid], playerid, persec);
		print(string);
		new Float: X, Float:Y, Float: Z, playint, playvw;
		GetPlayerPos(playerid, X, Y, Z);
		playint = GetPlayerInterior(playerid);
		playvw = GetPlayerVirtualWorld(playerid);
		persec++;
		countdown22[playerid] = persec;
		for(new i = 0; i < MAX_PLAYERS ; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerInRangeOfPoint(i,300.0,X,Y,Z) && GetPlayerInterior(i) == playint &&
				GetPlayerVirtualWorld(i) == playvw)
				{
					SendClientMessage(i, COLOR_PURPLE, string);
					if(GetPlayerState(i) == PLAYER_STATE_ONFOOT && countdown22[i] == -1) countdown22[i] = persec;
				}
			}
		}
		return 1;
	}
    if(strcmp(cmd, "/givecash", true) == 0)
	{
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ������������ ��� �������, ��� �������� !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /givecash [�� ������] [�����]");
			return 1;
		}
		new playset;
		playset = strval(tmp);
		if(playset == playerid)
		{
			SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ������ ������ ���� !");
			return 1;
		}
		if(IsPlayerConnected(playset))
		{
			if(gPlayerLogged[playset] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ����� !");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " ����� �� ����� ���� ������������� ������ !"); return 1; }
			if(GetPlayerMoney(playerid) < money) { SendClientMessage(playerid, COLOR_RED, " � ��� ��� ����� ����� !"); return 1; }
			new money22 = money * -1;
			new dopper44, dopper55;
			dopper44 = GetPlayerMoney(playerid);
			dopper55 = GetPlayerMoney(playset);
			SetPVarInt(playerid, "MonControl", 1);
			GivePlayerMoney(playerid, money22);
			SetPVarInt(playset, "MonControl", 1);
			GivePlayerMoney(playset, money);
			format(string, sizeof(string), " ����� %s [%d] ������� ������ %s [%d] %d $", RealName[playerid], playerid,
			RealName[playset], playset, money);
			print(string);
			SendAdminMessage(COLOR_YELLOW, string);
			if (PlayerInfo[playerid][pAdmin] == 0)
			{
				format(string, sizeof(string), " �� �������� ������ %s [%d] %d $", RealName[playset], playset, money);
				SendClientMessage(playerid, COLOR_YELLOW, string);
			}
			if (PlayerInfo[playset][pAdmin] == 0)
			{
				format(string, sizeof(string), " ����� %s [%d] ������� ��� %d $", RealName[playerid], playerid, money);
				SendClientMessage(playset, COLOR_YELLOW, string);
			}
			printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[playerid], playerid, dopper44);
			printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[playset], playset, dopper55);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
		}
    	return 1;
	}
	if(strcmp(cmd, "/kill", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	if(strcmp(cmd, "/menu", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		gettime(timedata[0], timedata[1]);
		format(string, sizeof(string), "{458B74} ������� ���� | ������ �����: %02d:%02d", timedata[0], timedata[1]);
		ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, string, "{40E0D0}�{FFFFFF} ���������\n{40E0D0}�{FFFFFF} ���������\
        \n{40E0D0}�{FFFFFF} ���������\n{40E0D0}�{FFFFFF} ���������\n{40E0D0}�{FFFFFF} �� �����\n{40E0D0}�{FFFFFF} ���������� ����������\n{40E0D0}�{FFFFFF} �����\n{40E0D0}�{FFFFFF} ������� �������\
        \n{40E0D0}�{FFFFFF} ������� ��� �������������\n{40E0D0}�{FFFFFF} ������������� � ����\n{40E0D0}�{FFFFFF} ���� � �������\n{40E0D0}�{FFFFFF} ������� ������", "�����", "������");
		dlgcont[playerid] = 4;
    	return 1;
}
		if(strcmp(cmd, "/��������", true) == 0 || strcmp(cmd, "/obnul", true) == 0)
        {
      SetPlayerScore(playerid, 0);
      ResetPlayerMoney(playerid);
      SendClientMessage(playerid, 0x00FF00AA, "�� �������� ����");
      return 1;
 }
	if(strcmp(cmd, "/dt", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		if(GetPlayerInterior(playerid) != 0)//���� ����� � ���� ��� ������ ���������, ��:
		{
			SendClientMessage(playerid, COLOR_RED, " � ����� � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /dt [����������� ��� (0-9999)]");
			return 1;
		}
		new ii = strval(tmp);
		if(ii < 0 || ii > 9999)
		{
			SendClientMessage(playerid, COLOR_RED, " /dt [����������� ��� (0-9999)] !");
			return 1;
		}
		if(ii > 0)
		{
			if(ii == GetPlayerVirtualWorld(playerid))
			{
				format(string, sizeof(string), " �� ��� ���������� � %d ����������� ���� !!!", ii);
				SendClientMessage(playerid, COLOR_RED, string);
				return 1;
			}
			SetPlayerVirtualWorld(playerid, ii);
			if(GetPlayerState(playerid) == 2)
			{//���� ����� �� ����� ��������, ��:
				new carpl;
				carpl = GetPlayerVehicleID(playerid);//��������� �� ���� ����������
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(GetPlayerVehicleID(i) == carpl && playerid != i)//���� ����� � ���� ����������, ��:
						{//���������� ���������� �������� � ����������� ��� ������
							SetPlayerInterior(i, GetPlayerInterior(playerid));
							SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
							format(string, sizeof(string), " ��� ����������� ��� ��� ������ �� {FF0000}%d {00FF00}(�� � ������ ����� ����������)", ii);
							SendClientMessage(i, COLOR_GREEN, string);
							SendClientMessage(i, COLOR_GREEN, " ��� ���������� ������ ����� ���������� ����������� �������: {FF0000}/dt 0");
						}
					}
				}
				LinkVehicleToInterior(carpl, GetPlayerInterior(playerid));//���������� ��������� � ��������� ������
				SetVehicleVirtualWorld(carpl, GetPlayerVirtualWorld(playerid));//���������� ���������� ����������� ��� ������
			}
			format(string, sizeof(string), " ��� ����������� ��� ��� ������ �� {FF0000}%d {00FF00}(�� � ������ ����� ����������)", ii);
			SendClientMessage(playerid, COLOR_GREEN, string);
			SendClientMessage(playerid, COLOR_GREEN, " ��� ���������� ������ ����� ���������� ����������� �������: {FF0000}/dt 0");
		}
		else
		{
			if(ii == GetPlayerVirtualWorld(playerid))
			{
				SendClientMessage(playerid, COLOR_RED, " � ��� ��� �������� ����� ����� ���������� !!!");
				return 1;
			}
			SetPlayerVirtualWorld(playerid, ii);
			if(GetPlayerState(playerid) == 2)
			{//���� ����� �� ����� ��������, ��:
				new carpl;
				carpl = GetPlayerVehicleID(playerid);//��������� �� ���� ����������
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(GetPlayerVehicleID(i) == carpl && playerid != i)//���� ����� � ���� ����������, ��:
						{//���������� ���������� �������� � ����������� ��� ������
							SetPlayerInterior(i, GetPlayerInterior(playerid));
							SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
							SendClientMessage(i, COLOR_RED, " ����� ����� ���������� ��� ��������");
						}
					}
				}
				LinkVehicleToInterior(carpl, GetPlayerInterior(playerid));//���������� ��������� � ��������� ������
				SetVehicleVirtualWorld(carpl, GetPlayerVirtualWorld(playerid));//���������� ���������� ����������� ��� ������
			}
			SendClientMessage(playerid, COLOR_RED, " ����� ����� ���������� ��������");
		}
		return 1;
	}
	if(strcmp(cmd, "/s", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
 		new Float:ConX, Float:ConY, Float:ConZ;
		GetPlayerPos(playerid, ConX, ConY, ConZ);
		if(ConZ < -600 || ConZ > 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ����� ���������� ������� ���������� !");
			return 1;
		}
		GetPlayerPos(playerid, TpDestP[playerid][0], TpDestP[playerid][1], TpDestP[playerid][2]);
		TpPosP[playerid][0] = GetPlayerInterior(playerid);
		TpPosP[playerid][1] = GetPlayerVirtualWorld(playerid);
		if(GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
		{
			GetVehicleZAngle(GetPlayerVehicleID(playerid), TpDestP[playerid][3]);
		}
		else
		{
			GetPlayerFacingAngle(playerid, TpDestP[playerid][3]);
		}
		SendClientMessage(playerid, COLOR_YELLOW, " �� ��������� ������� ���������.");
		return 1;
	}
	if(strcmp(cmd, "/r", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		if(GetPlayerState(playerid) == 2)
		{
			new regm = 2, per1, per2, Float:per3;
			per1 = TpPosP[playerid][0];
			per2 = TpPosP[playerid][1];
			per3 = TpDestP[playerid][3];
			LogTelPort(playerid, regm, per1, per2, Float:per3, Float:TpDestP[playerid][0], Float:TpDestP[playerid][1],
			Float:TpDestP[playerid][2]+1);
		}
		else
		{
			SetPlayerInterior(playerid, TpPosP[playerid][0]);
			SetPlayerVirtualWorld(playerid, TpPosP[playerid][1]);
			SetPlayerPos(playerid, TpDestP[playerid][0], TpDestP[playerid][1], TpDestP[playerid][2]+1);
			SetPlayerFacingAngle(playerid, TpDestP[playerid][3]);
			SetCameraBehindPlayer(playerid);
		}
		if(TpDestP[playerid][0] > -3200 && TpDestP[playerid][0] < 3200 &&
		TpDestP[playerid][1] > -3200 && TpDestP[playerid][1] < 3200)
		{
			SendClientMessage(playerid, COLOR_GREEN, " �� ���� ��������������� �� ���������� �������.");
		}
		else
		{
			SetTimerEx("DubTlp", 1000, 0, "i", playerid);
		}
		return 1;
	}
	if(strcmp(cmd, "/cmchat", true) == 0)
	{
		ClearChat(playerid, 0);
		SendClientMessage(playerid, COLOR_GRAD1, " �� �������� ���� ���.");
		return 1;
	}
	if(strcmp(cmd, "/report", true) == 0)
	{
        if(PlayerInfo[playerid][pAdmin] >= 1)
        {
			SendClientMessage(playerid, COLOR_RED, " ������������� �� ����� ��������� ������ !");
			return 1;
		}
		if(PlayerInfo[playerid][pMutedsec] > 0)
		{
			SendClientMessage(playerid, COLOR_RED, "* �� �� ������ ��������, ��� �������� !");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /report [�� ����������] [������]");
			return 1;
		}
		new para1;
		para1 = strval(tmp);
		if(para1 == playerid)
        {
			SendClientMessage(playerid, COLOR_RED, " ������ ���������� �� ������ ���� !");
			return 1;
		}
		if(!IsPlayerConnected(para1))
		{
			SendClientMessage(playerid, COLOR_RED, " ������ [�� ����������] �� ������� ��� !");
			return 1;
		}
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[128];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_RED, " /report [�� ����������] [������] !");
			return 1;
		}
		new per55 = 0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
//				if(PlayerInfo[i][pAdmin] >= 1) {per55 = 1;}//����� ���� �������
				if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmshad] == 0) {per55 = 1;}//����� ������ �� ������� �������
			}
		}
		if(per55 == 0)
		{
			SendClientMessage(playerid, COLOR_RED, " ���� ������ �� ����������, ��� ������� �� ������� !");
			return 1;
		}
		format(string, sizeof(string), " <Report> {FFFF00}����� %s [%d] ����������� �� ������ %s [%d] , �������: %s",
		RealName[playerid], playerid, RealName[para1], para1, result);
		print(string);
		SendAdminMessage(COLOR_RED, string);
		SendClientMessage(playerid, COLOR_YELLOW, " ���� ������ ���������� �������, �������� � ������������.");
		return 1;
	}
	if(strcmp(cmd, "/tp", true) == 0)
	{
		if(admper1[playerid] != 600)
		{
			SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
			return 1;
		}
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SendClientMessage(playerid, COLOR_GREEN, " ...!");
		SetPlayerPos(playerid, -2067.5012, 1356.4471, 7.1016);
    	return 1;
    }
	if(strcmp(cmd, "/vers", true) == 0)
	{
		SendClientMessage(playerid, COLOR_GREEN, " ������ ����: 1.0");
		return 1;
	}
//------------------------- ������� ������� (�����) ----------------------------
//--------------------- ������� ������� 1 ��� (������) -------------------------
	if(strcmp(cmd, "/time", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /time [�����(0-23)]");
				return 1;
			}
			new hour1;
			hour1 = strval(tmp);
			if (hour1 < 0 || hour1 > 23)
			{
				SendClientMessage(playerid, COLOR_RED, " �����: �� 0 �� 23 !");
				return 1;
			}
			SetWorldTime(hour1);
			format(string, sizeof(string), " ������������� %s ��������� ����� �� %d �����.", RealName[playerid], hour1);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW,string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/weat", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /weat [�� ������]");
				return 1;
			}
			new testwea = strval(tmp);
			SetWeather(testwea);
			format(string, sizeof(string), " ������������� %s ��������� ID ������ �� %d", RealName[playerid], testwea);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mess", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /mess [����(0-19)] [���������] , ��� /mess 600");
				return 1;
			}
			new color;
			color = strval(tmp);
			if(color < 0 || (color > 19 && color < 600) || color > 600)
			{
				SendClientMessage(playerid, COLOR_RED, " ����(0-19) , ��� 600 !");
				return 1;
			}
			if(color == 600)
			{
				format(strdln, sizeof(strdln), "{A9C4E4}0 - {FF0000}�������\
				\n{A9C4E4}1 - {FF3F3F}������-�������\
				\n{A9C4E4}2 - {FF3F00}���������\
				\n{A9C4E4}3 - {BF3F00}����������");
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}4 - {FF7F3F}������-����������\
				\n{A9C4E4}5 - {FF7F00}���������\
				\n{A9C4E4}6 - {FFFF00}Ƹ����\
				\n{A9C4E4}7 - {3FFF3F}������-������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}8 - {00FF00}������\
				\n{A9C4E4}9 - {00BF00}Ҹ���-������\
				\n{A9C4E4}10 - {00FFFF}���������\
				\n{A9C4E4}11 - {00BFFF}�������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}12 - {3F3FFF}������-�����\
				\n{A9C4E4}13 - {0000FF}�����\
				\n{A9C4E4}14 - {7F3FFF}������-����������\
				\n{A9C4E4}15 - {7F00FF}����������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}16 - {FF00FF}���������\
				\n{A9C4E4}17 - {7F7F7F}�����\
				\n{A9C4E4}18 - {FFFFFF}�����\
				\n{A9C4E4}19 - {333333}׸����", strdln);
				ShowPlayerDialog(playerid, 2, 0, "����:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� �������� ��������� !");
				return 1;
			}
			format(string, sizeof(string), "(/mess) ����� %s [%d]: %s", RealName[playerid], playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 1: format(string, sizeof(string), "{FF3F3F}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 2: format(string, sizeof(string), "{FF3F00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 3: format(string, sizeof(string), "{BF3F00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 4: format(string, sizeof(string), "{FF7F3F}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 5: format(string, sizeof(string), "{FF7F00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 6: format(string, sizeof(string), "{FFFF00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 7: format(string, sizeof(string), "{3FFF3F}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 8: format(string, sizeof(string), "{00FF00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 9: format(string, sizeof(string), "{00BF00}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 10: format(string, sizeof(string), "{00FFFF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 11: format(string, sizeof(string), "{00BFFF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 12: format(string, sizeof(string), "{3F3FFF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 13: format(string, sizeof(string), "{0000FF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 14: format(string, sizeof(string), "{7F3FFF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 15: format(string, sizeof(string), "{7F00FF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 16: format(string, sizeof(string), "{FF00FF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 17: format(string, sizeof(string), "{7F7F7F}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 18: format(string, sizeof(string), "{FFFFFF}����� %s [%d]: %s", RealName[playerid], playerid, result);
				case 19: format(string, sizeof(string), "{333333}����� %s [%d]: %s", RealName[playerid], playerid, result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/cord", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:x, Float:y, Float:z, Float:Angle;
			GetPlayerPos(playerid, x, y, z);
			if(GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
			{
				new VID = GetPlayerVehicleID(playerid);
				GetVehicleZAngle(VID, Angle);
			}
			else
			{
				GetPlayerFacingAngle(playerid, Angle);
			}
			format(string, sizeof(string), "x = %f   y = %f   z = %f   ������� = %f   �������� = %d   ����������� ��� = %d",
			x, y, z, Angle, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			SendClientMessage(playerid, COLOR_WHITE, string);
			printf(" ������������� %s ����������� ������� /cord .", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 1 ��� (�����) --------------------------
//--------------------- ������� ������� 2 ��� (������) -------------------------
	if(strcmp(cmd, "/muteakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 2)
    	{
			new data222[3], csec;
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /muteakk [��� ��������] [����� ������");
				SendClientMessage(playerid, COLOR_GRAD2, " (����� ����������, ������� 3 �������)] [�������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /muteakk [��� ��������] [����� ������] [�������] !");
				return 1;
			}
			csec = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new file;//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getInteger(file, "AdminLevel", data222[0]);
				ini_getInteger(file, "Muted", data222[1]);
				ini_getInteger(file, "Mutedsec", data222[2]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data222[0] < 0)
			{
				fadm = data222[0] * -1;
			}
			else
			{
				fadm = data222[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//�������� �������� �� �������
			{
				format(ssss, sizeof(ssss), " ������, ������� ������ [%s] - ����� %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(csec != 3)//�������� ������
			{
				if(csec < 5) {csec = 5;}
				if(data222[2] == 0)//���� ����� �� �������, ��:
				{
					data222[1]++;
				}
				data222[2] = csec;
			}
			else//���������� ������
			{
				if(data222[2] > 0)//���� ����� �������, ��:
				{
  					data222[1]--;
					data222[2] = 0;
				}
				else
				{
			  		SendClientMessage(playerid, COLOR_RED, " ��������� ����� �� ������� !");
					return 1;
				}
			}
			file = ini_openFile(string);//������ ���������� ��������
			if(file >= 0)
			{
				ini_setInteger(file, "Muted", data222[1]);
				ini_setInteger(file, "Mutedsec", data222[2]);
				ini_closeFile(file);
			}
			if(csec != 3)//�������� ������
			{
				new dopcis;
				dopcis = FCislit(csec);
				switch(dopcis)
				{
					case 0: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s �� %d ������ , �������: %s", RealName[playerid], akk, csec, result);
					case 1: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s �� %d ������� , �������: %s", RealName[playerid], akk, csec, result);
					case 2: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s �� %d ������� , �������: %s", RealName[playerid], akk, csec, result);
				}
				print(ssss);
				SendClientMessageToAll(COLOR_RED, ssss);
			}
			else//���������� ������
			{
				format(ssss, sizeof(ssss), " ������������� %s ��������� ������� ������ %s , �������: �������� ;)))",
				RealName[playerid], akk);
				print(ssss);
				SendClientMessageToAll(COLOR_GREEN, ssss);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/prisonakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 2)
    	{
   			new data222[3], csec;
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /prisonakk [��� ��������] [����� ������");
				SendClientMessage(playerid, COLOR_GRAD2, " (����� ����������, ������� 3 �������)] [�������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /prisonakk [��� ��������] [����� ������] [�������] !");
				return 1;
			}
			csec = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new file;//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getInteger(file, "AdminLevel", data222[0]);
				ini_getInteger(file, "Prison", data222[1]);
				ini_getInteger(file, "Prisonsec", data222[2]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data222[0] < 0)
			{
				fadm = data222[0] * -1;
			}
			else
			{
				fadm = data222[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//�������� �������� �� �������
			{
				format(ssss, sizeof(ssss), " ������, ������� ������ [%s] - ����� %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(csec != 3)//�������� ������
			{
				if(csec < 5) {csec = 5;}
				if(data222[2] == 0)//���� �� � ������, ��:
				{
					data222[1]++;
				}
				data222[2] = csec;
			}
			else//���������� ������
			{
				if(data222[2] > 0)//���� ����� � ������, ��:
				{
  					data222[1]--;
					data222[2] = 0;
				}
				else
				{
			  		SendClientMessage(playerid, COLOR_RED, " ��������� ����� �� ����� � ������ !");
					return 1;
				}
			}
			file = ini_openFile(string);//������ ���������� ��������
			if(file >= 0)
			{
				ini_setInteger(file, "Prison", data222[1]);
				ini_setInteger(file, "Prisonsec", data222[2]);
				ini_closeFile(file);
			}
			if(csec != 3)//�������� ������
			{
				new dopcis;
				dopcis = FCislit(csec);
				switch(dopcis)
				{
					case 0: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s � ������ �� %d ������ , �������: %s", RealName[playerid], akk, csec, result);
					case 1: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s � ������ �� %d ������� , �������: %s", RealName[playerid], akk, csec, result);
					case 2: format(ssss, sizeof(ssss), " ������������� %s ������� ������� ������ %s � ������ �� %d ������� , �������: %s", RealName[playerid], akk, csec, result);
				}
				print(ssss);
				SendClientMessageToAll(COLOR_RED, ssss);
			}
			else//���������� ������
			{
				format(ssss, sizeof(ssss), " ������������� %s ��������� ������� ������ %s , �������: �������� ;)))",
				RealName[playerid], akk);
				print(ssss);
				SendClientMessageToAll(COLOR_GREEN, ssss);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/cc", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			ClearChat(playerid, 1);
			format(string, sizeof(string), " ������������� %s ������� ��� ������� !", RealName[playerid]);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/mark", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			TpPosA[playerid][0] = GetPlayerInterior(playerid);
			TpPosA[playerid][1] = GetPlayerVirtualWorld(playerid);
			GetPlayerPos(playerid, TpDestA[playerid][0],TpDestA[playerid][1],TpDestA[playerid][2]);
			if (GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
			{
				GetVehicleZAngle(GetPlayerVehicleID(playerid), TpDestA[playerid][3]);
			}
			else
			{
				GetPlayerFacingAngle(playerid, TpDestA[playerid][3]);
			}
			SendClientMessage(playerid, COLOR_GRAD1, " ������ ��������� ����������.");
			printf(" ������������� %s ��������� �������� ( /mark )", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotomark", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			if(GetPlayerState(playerid) == 2)//���� ����� �� ����� ��������, ��:
			{
				new regm = 2, per1, per2, Float:per3;
				per1 = TpPosA[playerid][0];
				per2 = TpPosA[playerid][1];
				per3 = TpDestA[playerid][3];
				LogTelPort(playerid, regm, per1, per2, Float:per3, Float:TpDestA[playerid][0],
				Float:TpDestA[playerid][1], Float:TpDestA[playerid][2]+1);
			}
			else//�����:
			{
				SetPlayerInterior(playerid, TpPosA[playerid][0]);
				SetPlayerVirtualWorld(playerid, TpPosA[playerid][1]);
				SetPlayerPos(playerid, TpDestA[playerid][0], TpDestA[playerid][1], TpDestA[playerid][2]+1);
				SetPlayerFacingAngle(playerid, TpDestA[playerid][3]);
				SetCameraBehindPlayer(playerid);
			}
			SendClientMessage(playerid, COLOR_GRAD1, " �� ���� ���������������.");
			printf(" ������������� %s ���������������� ( /gotomark )", RealName[playerid]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 2 ��� (�����) --------------------------
//--------------------- ������� ������� 3 ��� (������) -------------------------
	if(strcmp(cmd, "/tpset", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /tpset [���������� X] [���������� Y] [���������� Z]");
				return 1;
			}
			new cor1, cor2, cor3, Float:fcor1, Float:fcor2, Float:fcor3;
			cor1 = strval(tmp);
			if(cor1 < -19500 || cor1 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " ���������� X �� -19500 �� 19500 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [���������� Y] [���������� Z] !");
				return 1;
			}
			cor2 = strval(tmp);
			if(cor2 < -19500 || cor2 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " ���������� Y �� -19500 �� 19500 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [���������� Z] !");
				return 1;
			}
			cor3 = strval(tmp);
			if(cor3 < -500 || cor3 > 19500)
			{
				SendClientMessage(playerid, COLOR_RED, " ���������� Z �� -500 �� 19500 !");
				return 1;
			}
			format(string, sizeof(string), "%d", cor1);
			fcor1 = floatstr(string);
			format(string, sizeof(string), "%d", cor2);
			fcor2 = floatstr(string);
			format(string, sizeof(string), "%d", cor3);
			fcor3 = floatstr(string);
			SetPlayerPos(playerid, fcor1, fcor2, fcor3);
			printf(" ������������� %s ���������������� � ����������: X = %f   Y = %f   Z = %f", RealName[playerid], fcor1, fcor2, fcor3);
			format(string, sizeof(string), " �� ����������������� � ����������: X = %f   Y = %f   Z = %f", fcor1, fcor2, fcor3);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/jetpack", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /jetpack [�� ������]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(IsPlayerConnected(para1))
		    {
				if(playspa[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(admper1[para1] != 600)
				{
					SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� �� ������ ���� JetPack - � ������ ���������� !");
					return 1;
				}
				if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
				{
					SendClientMessage(playerid, COLOR_RED, " �� �� ������ ���� JetPack ������ 12-�� ������ !");
					return 1;
				}
				if(IsPlayerInAnyVehicle(para1))
				{//���� ����� � ����, ��:
					new Float:X, Float:Y, Float:Z;//�������� ������ �� ����
					GetPlayerPos(para1, X, Y, Z);
					SetPlayerPos(para1, X+3, Y+3, Z+3);
				}
				SetPlayerSpecialAction(para1, 2);
				format(string, sizeof(string), " ������������� %s ��� ������ %s JetPack .", RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
    	return 1;
	}
//------------------------------ BusSystem -------------------------------------
	if(strcmp(cmd, "/helpbiz", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessage(playerid, 0x00FFFFFF, " -------------------------- ������� �������� -------------------------- ");
			SendClientMessage(playerid, 0x00FFFFFF, "   /helpbus - ������ �� �������� BusSystem");
			SendClientMessage(playerid, 0x00FFFFFF, "   /createbus - ������� ������");
			SendClientMessage(playerid, 0x00FFFFFF, "   /removebus - ������� ������ �� ��� ID");
			SendClientMessage(playerid, 0x00FFFFFF, "   /removebusall - ������� ��� �������");
			SendClientMessage(playerid, 0x00FFFFFF, "   /gotobus - ����������������� � ������� �� ��� ID");
			SendClientMessage(playerid, 0x00FFFFFF, "   /reloadbus - ������������ ������� ��������");
			SendClientMessage(playerid, 0x00FFFFFF, " --------------------------------------------------------------------------------- ");
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
		if(strcmp(cmd, "/scrmd", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_GRAD2, " �����������: /scrmd [�����] ( 0- ������� ''Drift level'' ,");
			SendClientMessage(playerid, COLOR_GRAD2, " 1- ���������, 2- ����� �������, 3- ������� ''������� ������''");
			SendClientMessage(playerid, COLOR_GRAD2, " (� ���� ��� �������), 4- �������� ����� ������ ������� )");
			return 1;
		}
		new para1 = strval(tmp);
		if(para1 < 0 || para1 > 4)
		{
			SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 4 !");
			return 1;
		}
		if(para1 == 0)
		{
			if(scrmod[0][playerid] == 0)
			{
				scrmod[0][playerid] = 1;
				printf(" --> ����� %s [%d] �������� ������� ''Drift level'' .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " �� ��������� ������� ''Drift level'' .");
			}
			else
			{
				scrmod[0][playerid] = 0;
				printf(" --> ����� %s [%d] ������� ������� ''Drift level'' .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " �� �������� ������� ''Drift level'' .");
			}
		}
		if(para1 == 2)
		{
			if(scrmod[2][playerid] == 0)
			{
				scrmod[2][playerid] = 1;
				printf(" --> ����� %s [%d] �������� ����� �������.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " �� ��������� ����� �������.");
			}
			else
			{
				scrmod[2][playerid] = 0;
				printf(" --> ����� %s [%d] ������� ����� �������.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " �� �������� ����� �������.");
			}
		}
		if(para1 == 3)
		{
			if(dmplay[playerid] != 0)//���� ����� � DM-����, ��:
			{
				SendClientMessage(playerid, COLOR_RED, " � DM-����� ��������� ����� �� �������� !");
				return 1;
			}
			if(scrmod[3][playerid] == 0)
			{
				scrmod[3][playerid] = 1;
				Delete3DTextLabel(Level3D[playerid]);
				printf(" --> ����� %s [%d] �������� ������� ''������� ������'' (� ���� ��� �������) .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " �� ��������� ������� ''������� ������'' (� ���� ��� �������) .");
			}
			else
			{
				scrmod[3][playerid] = 0;
				Level3D[playerid] = Create3DTextLabel(" ",0xFFFFFFAA,0.000,0.000,-4.000,18.0,0,1);
				LevelStats[playerid] = 0;
				printf(" --> ����� %s [%d] ������� ������� ''������� ������'' (� ���� ��� �������) .", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " �� �������� ������� ''������� ������'' (� ���� ��� �������) .");
			}
		}
		if(para1 == 4)
		{
			if(scrmod[4][playerid] == 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					ShowPlayerNameTagForPlayer(playerid, i, false);
				}
				scrmod[4][playerid] = 1;
				printf(" --> ����� %s [%d] �������� �������� ����� ������ �������.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_RED, " �� ��������� �������� ����� ������ �������.");
			}
			else
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					ShowPlayerNameTagForPlayer(playerid, i, true);
				}
				scrmod[4][playerid] = 0;
				printf(" --> ����� %s [%d] ������� �������� ����� ������ �������.", RealName[playerid], playerid);
				SendClientMessage(playerid, COLOR_GREEN, " �� �������� �������� ����� ������ �������.");
			}
		}
    	return 1;
	}
	if(strcmp(cmd, "/createbiz", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " �����������: /createbus [���������(100-1000000 $)] [����� �����, �����");
				SendClientMessage(playerid, 0xFFFFFFFF, " ������� ������ ����� ��������� �����(10-120)] [����� �� �������");
				SendClientMessage(playerid, 0xFFFFFFFF, " �� ������ ��-���� ����(100-1000000 $)] [�������� �������(�� 3 �� 32 ��������)]");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 100 || para1 > 1000000)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " ��������� �� 100 $ �� 1000000 $ !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " /createbus [���������] [����� �����] [�����] [�������� �������] !");
				return 1;
			}
			new para2 = strval(tmp);
			if(para2 < 10 || para2 > 120)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " ����� ����� �� 10 �� 120 !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " /createbus [���������] [����� �����] [�����] [�������� �������] !");
				return 1;
			}
			new para3 = strval(tmp);
			if(para3 < 100 || para3 > 1000000)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " ����� �� 100 $ �� 1000000 $ !");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(strlen(result) < 3 || strlen(result) > 32)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " �������� �� 3 �� 32 �������� !");
				return 1;
			}
			if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " ������ ����� ������� ������ � 0-� ���������, � �� �������� ����� !");
				return 1;
			}
			new para4 = 0;
			new para5 = 0;
			while(para4 < BUS_MAX)
			{
				if(buscount[para4] == 0)
				{
					para5 = 1;
					break;
				}
				para4++;
			}
			if(para5 == 0)
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " �������� ����� �������� �������� !");
				SendClientMessage(playerid, 0xFFFFFFFF, " ��� ����������� - ��������� �������� �������� �� ������� !");
				return 1;
			}
			buscount[para4] = 1;//������ ������
			GetPlayerPos(playerid, buscordx[para4], buscordy[para4], buscordz[para4]);//����� ���������� �������
			strdel(busname[para4], 0, 64);//����� �������� �������
			strcat(busname[para4], result);
			strdel(busplayname[para4], 0, MAX_PLAYER_NAME);//������� ��� ��������� �������
			strcat(busplayname[para4], "*** INV_PL_ID");
		    buscost[para4] = para1;//����� ��������� �������
		    busminute[para4] = para2;//�����, ����� ������� ����� ������ ����� ��������� �����
		    busincome[para4] = para3;//����� ����� �� �������
		    busday[para4] = 0;//��� ������� ����� �� ��� ��������� (�������)

    		new file, f[256];//������ ������� � ����
	    	format(f, 256, "bussystem/%i.ini", para4);
			file = ini_createFile(f);
			if(file == INI_OK)
			{
		    	ini_setString(file, "BusName", busname[para4]);
		    	ini_setString(file, "PlayName", busplayname[para4]);
		    	ini_setInteger(file, "Cost", buscost[para4]);
		    	ini_setInteger(file, "Minute", busminute[para4]);
		    	ini_setInteger(file, "Income", busincome[para4]);
		    	ini_setInteger(file, "Day", busday[para4]);
		    	ini_setFloat(file, "CordX", buscordx[para4]);
		    	ini_setFloat(file, "CordY", buscordy[para4]);
		    	ini_setFloat(file, "CordZ", buscordz[para4]);
				ini_closeFile(file);
			}

			PickupID[para4] = CreateDynamicPickup(1274, 1, buscordx[para4], buscordy[para4], buscordz[para4], 0, 0, -1, 100.0);//������ ����� �������
			MapIconID[para4] = CreateDynamicMapIcon(buscordx[para4], buscordy[para4], buscordz[para4], 52, -1, 0, 0, -1, 200.0);//������ ���-������ �������
			format(string, sizeof(string), "������: %s\nID: %d", busname[para4], para4);
			Nbus[para4] = Create3DTextLabel(string, 0x00FF00FF, buscordx[para4], buscordy[para4], buscordz[para4]+0.70, 50, 0, 1);//������ 3D-����� �������
			GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("[BusSystem] ������������� %s [%d] ������ ������ ID: %d .", sendername, playerid, para4);
			format(string, sizeof(string), " ������ ID: %d ������� ������.", para4);
			SendClientMessage(playerid, 0xFFFF00FF, string);
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/removebus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0xFFFFFFFF, " �����������: /removebus [ID �������]");
				return 1;
			}
			new para1 = strval(tmp);
			format(string, sizeof(string), "bussystem/%i.ini", para1);
			if(fexist(string) || buscount[para1] == 1)//���� ���� ��� ��� ������ ����������, ��:
			{
				DestroyDynamicPickup(PickupID[para1]);//������� ����� �������
				if(busday[para1] == 0)//���� ���� ���-������ �������, ��:
				{
					DestroyDynamicMapIcon(MapIconID[para1]);//������� ���-������ �������
				}
				Delete3DTextLabel(Nbus[para1]);//������� 3D-����� �������
				if(fexist(string))//���� ���� ����������, ��:
				{
                    fremove(string);//������� ����
				}
				buscount[para1] = 0;//������� ������
				strdel(busplayname[para1], 0, MAX_PLAYER_NAME);//������� ��� ��������� �������
				strcat(busplayname[para1], "*** INV_PL_ID");
				PickupID[para1] = -600;//����� �������������� ID-����� ������ ��� �������
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] ����� %s [%d] ������ ������ ID: %d .", sendername, playerid, para1);
				format(string, sizeof(string), " ������ ID: %d ������� �����.", para1);
				SendClientMessage(playerid, 0xFFFFFFFF, string);
			}
			else//���� �� ����, � �� ��� ������ �� ����������, ��:
			{
				SendClientMessage(playerid, 0xFF0000FF, " ������� � ����� ID �� ���������� !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/removebusall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			new para1 = 0;
			for(new i; i < BUS_MAX; i++)
			{
				format(string, sizeof(string), "bussystem/%i.ini", i);
				if(fexist(string) || buscount[i] == 1)//���� ���� ��� ��� ������ ����������, ��:
				{
					para1 = 1;
					DestroyDynamicPickup(PickupID[i]);//������� ����� �������
					if(busday[i] == 0)//���� ���� ���-������ �������, ��:
					{
						DestroyDynamicMapIcon(MapIconID[i]);//������� ���-������ �������
					}
					Delete3DTextLabel(Nbus[i]);//������� 3D-����� �������
					if(fexist(string))//���� ���� ����������, ��:
					{
                    	fremove(string);//������� ����
					}
					buscount[i] = 0;//������� ������
					strdel(busplayname[i], 0, MAX_PLAYER_NAME);//������� ��� ��������� �������
					strcat(busplayname[i], "*** INV_PL_ID");
					PickupID[i] = -600;//����� �������������� ID-����� ������ ��� �������
				}
			}
			if(para1 == 1)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] ������������� %s [%d] ������ ��� �������.", sendername, playerid);
				SendClientMessage(playerid, 0xFF0000FF, " ��� ������� ���� ������� �������.");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000FF, " �� ������� �� ������� �� ������ ������� !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotobus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, 0x00FFFFFF, " �����������: /gotobus [ID �������]");
				return 1;
			}
			new para1 = strval(tmp);
			if(buscount[para1] == 1)//���� ������ ����������, ��:
			{
				SetPlayerPos(playerid, buscordx[para1], buscordy[para1]+2, buscordz[para1]+1);
				GetPlayerName(playerid, sendername, sizeof(sendername));
				printf("[BusSystem] ������������� %s [%d] ���������������� � ������� ID: %d .", sendername, playerid, para1);
				format(string, sizeof(string), " �� ����������������� � ������� ID: %d .", para1);
				SendClientMessage(playerid, 0x00FF00FF, string);
			}
			else//���� ������ �� ����������, ��:
			{
				SendClientMessage(playerid, 0xFF0000FF, " ������� � ����� ID �� ���������� !");
			}
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/reloadbus", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			printf("[BusSystem] ������������� %s [%d] ����� ������������ ������� ��������.", sendername, playerid);
			format(string, sizeof(string), " ����� %s [%d] ����� ������������ ������� ��������.", sendername, playerid);
			SendClientMessageToAll(0xFF0000FF, string);
			SetTimerEx("reloadbus1", 1000, 0, "i", playerid);
		}
		else
		{
			SendClientMessage(playerid, 0xFF0000FF, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//---------------------------- End BusSystem -----------------------------------
	if(strcmp(cmd, "/explode", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /explode [�� ������]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(IsPlayerConnected(para1))
		    {
				if(playspa[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(admper1[para1] != 600)
				{
					SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� �� ������ �������� - � ������ ���������� !");
					return 1;
				}
				if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
				{
					SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ������ 12-�� ������ !");
					return 1;
				}
				new Float:x, Float:y, Float:z;
				GetPlayerPos(para1, x, y, z);
				CreateExplosion(x, y, z, 10, 10.0);
				CreateExplosion(x, y, z, 10, 10.0);
				format(string, sizeof(string), " ������������� %s ������� ������ %s .", RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
    	return 1;
	}
//--------------------- ������� ������� 3 ��� (�����) --------------------------
//--------------------- ������� ������� 4 ��� (������) -------------------------
    if(strcmp(cmd, "/car", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /car [�� ������ ����] [����1] [����2]");
				return 1;
			}
			new car;
			car = strval(tmp);
			if(car < 400 || car > 611) { SendClientMessage(playerid, COLOR_RED, " �� ������ ���� �� ����� ���� ������ 400 ��� ������ 611 !"); return 1; }
			if(car == 537 || car == 538 || car == 569 || car == 570)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� �� ������ ���� ������� ������ !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ����1 � ����2 !");
				return 1;
			}
			new color1;
			color1 = strval(tmp);
			if(color1 < 0 || color1 > 255) { SendClientMessage(playerid, COLOR_RED, " ����� �����1 �� ����� ���� ������ 0 ��� ������ 255 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ����2 !");
				return 1;
			}
			new color2;
			color2 = strval(tmp);
			if(color2 < 0 || color2 > 255) { SendClientMessage(playerid, COLOR_RED, " ����� �����2 �� ����� ���� ������ 0 ��� ������ 255 !"); return 1; }
			new carid2;
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			carid2 = CreateVehicle(car, X+3, Y+3, Z+1, 0.0, color1, color2, 90000);
			LinkVehicleToInterior(carid2, GetPlayerInterior(playerid));//���������� ��������� � ��������� ������
			SetVehicleVirtualWorld(carid2, GetPlayerVirtualWorld(playerid));//���������� ���������� ����������� ��� ������
			format(string, sizeof(string), " ������������� %s ������ ���������   ID: %d   ������: %d .", RealName[playerid], carid2, car);
			print(string);
			format(string, sizeof(string), " ��������� ������ !   ID: %d   ������: %d", carid2, car);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/delcar", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /delcar [�� ����]");
				return 1;
			}
			new carid;
			carid = strval(tmp);
			if (carid < 1 || carid > 10000)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ����: �� 1 �� 10000 !");
				return 1;
			}
			if(CallRemoteFunction("myobjvehfunc", "d", carid) != 0)//������ �� ���������� �� ������� myobj
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� �������� ��������� ��������� !");
				return 1;
			}
			if(CallRemoteFunction("garagefunction", "d", carid) != 0)//������ �� ���������� �� ������� �������
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ��������� ������� ������� !");
				return 1;
			}
			if(CallRemoteFunction("mpsysvehfunc", "d", carid) != 0)//������ �� ���������� �� ������� ��
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ��������� ������� �� !");
				return 1;
			}
			if(CallRemoteFunction("dssysvehfunc", "d", carid) != 0)//������ �� ���������� �� ������� �����-����
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ��������� ������� �����-���� !");
				return 1;
			}
			if(CallRemoteFunction("basesysvehfunc", "d", carid) != 0)//������ �� ���������� �� ������� ���
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ��������� ������� ��� !");
				return 1;
			}
			if(CallRemoteFunction("vehsys3vehfunc", "d", carid) != 0)//������ �� ���������� �� ������� ������� ���������� vehsys3
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ������ ��������� ������ !");
				return 1;
			}
			new locper = 0;
			new locper55 = 0;
			while(locper < MAX_PLAYERS)//���������� ����� ���������
			{
			 	if(carid == playcar[locper])//���� ������������ ��������� - ������ ��������� ������, ��:
			 	{
					locper55 = 1;
					break;
			 	}
			 	if(carid == neon[locper][2])//���������� ����� ���� �� ��������� ����������
			 	{
					DestroyObject(neon[locper][0]);//������ ����
					DestroyObject(neon[locper][1]);//������ ����
					neon[locper][0] = 0;//����������� ����� �������������� ����� �������
					neon[locper][1] = 0;//����������� ����� �������������� ����� �������
					neon[locper][2] = 0;//�������������� �� ���������� � ������
			 	}
				locper++;
			}
			if(locper55 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��� ������ ��������� ������ !");
				return 1;
			}
			new model, car22;
			model = GetVehicleModel(carid);
			car22 = DestroyVehicle(carid);
			if(car22 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ����������] �� ������� ��� !");
				return 1;
			}
			format(string, sizeof(string), " ������������� %s ��������� ���������   ID: %d   ������: %d .",
			RealName[playerid], carid, model);
			print(string);
			format(string, sizeof(string), " ��������� ��������� !   ID: %d   ������: %d", carid, model);
			SendClientMessage(playerid, COLOR_GREY, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/entercar", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /entercar [�� ����������]");
				return 1;
			}
			new testcar = strval(tmp);
			new modelcar = GetVehicleModel(testcar);
			if(modelcar == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ����������] �� ������� ��� !");
				return 1;
			}
			if(modelcar == 570 || modelcar == 569)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ������ ��� ����� ��� �������� !");
			}
			else
			{
				if(IsPlayerInAnyVehicle(playerid))
				{//���� ����� � ����, ��:
					new Float:igx, Float:igy, Float:igz;
					GetPlayerPos(playerid, igx, igy, igz);//����� ������ �� ����
					SetPlayerPos(playerid, igx+3, igy+3, igz);
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))//���������� ��������� ���� ����� � ��������
						{
							if(admper1[i] != 600 && admper1[i] == playerid)//���� ���� ����� ������� ����������,
							{//� ���� ����� ��������� �� �������, ��:
								admper5[i] = 2;//������������� ������������ ����������
							}
						}
					}
				}
				SetTimerEx("entcar22", 300, 0, "ii", playerid, testcar);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/plclr", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 4)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /plclr [�� ��������� (0- ������ ���� ��������� ��");
				SendClientMessage(playerid, COLOR_GRAD2, " ������ ��������� (��� ��������) �������, 1- �������� ������");
				SendClientMessage(playerid, COLOR_GRAD2, " ������� ��� (������������� - �� ������), 2- �������� ����");
				SendClientMessage(playerid, COLOR_GRAD2, " ��������� ��������� (��� ��������) ������� ������� ����,");
				SendClientMessage(playerid, COLOR_GRAD2, " 3- ���������� ������ ���� ���� (������������� - �� ������))]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 3)
			{
				SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 3 !");
				return 1;
			}
			if(para1 == 0)
			{
				new dopper;
				dopper = 0;
				new locper, dop11, dop22, dop33;
				SendClientMessage(playerid, COLOR_YELLOW, " ��������� �� ������ ���������");
				SendClientMessage(playerid, COLOR_YELLOW, " (��� ��������) ������:");
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{//���� ����� � ��������, � ���������, ��:
						locper = 0;
						dop11 = GetPlayerColor(i);
						dop22 = 0;
						dop33 = 268435456;
						for(new j = 0; j < 8; j++)//������� ����������� ���� � �����������������
						{//(�������������� ������� �������� ��� (���� ����� � ������������� ���������) �� �����
							dop22 = dop11 / dop33;//��-�� ������������ ������� ��� ����)
							dop11 = dop11 - (dop22 * dop33);
							if(j == 6) { locper = locper + dop22 * 16; }//���� ��������� 4-� (�������) ���� (7-� � 8-� �����), ��:
							if(j == 7) { locper = locper + dop22; }//����� ��������� 4-� ���� � ���������� �����
							dop33 = dop33 / 16;
						}
						if(locper < 128)
						{//���� ����� ��������� ��������� (��� ��������), ��:
							dopper = 1;
							format(string, sizeof(string), " --- %s [%d]", RealName[i], i);
							SendClientMessage(playerid, COLOR_YELLOW, string);
						}
					}
				}
				if(dopper == 0)
				{
					SendClientMessage(playerid, COLOR_YELLOW, " --- �� ����������.");
				}
				else
				{
					SendClientMessage(playerid, COLOR_YELLOW, " ----------------------------------------");
				}
				printf(" ������������� %s ���������� ���� ��������� �������.", RealName[playerid]);
				return 1;
			}
			if(para1 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /plclr 1 [�� ������] !");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
					return 1;
				}
				if(playspa[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��� �� ����������� !");
					return 1;
				}
				ColorPlay[para2] = ColNick[8];//�������� ������ ������� ���
				SetPlayerColor(para2, ColorPlay[para2]);
			    for(new i=0;i<MAX_PLAYERS;i++)
				{
					SetPlayerMarkerForPlayer(i, para2, ColorPlay[para2]);
				}
				format(string, sizeof(string), " ������������� %s ������� ������ %s ������� ���.", RealName[playerid], RealName[para2]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
			if(para1 == 2)
			{
				new dopper;
				dopper = 0;
				new locper, dop11, dop22, dop33;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{//���� ����� � ��������, � ���������, ��:
						locper = 0;
						dop11 = GetPlayerColor(i);
						dop22 = 0;
						dop33 = 268435456;
						for(new j = 0; j < 8; j++)//������� ����������� ���� � �����������������
						{//(�������������� ������� �������� ��� (���� ����� � ������������� ���������) �� �����
							dop22 = dop11 / dop33;//��-�� ������������ ������� ��� ����)
							dop11 = dop11 - (dop22 * dop33);
							if(j == 6) { locper = locper + dop22 * 16; }//���� ��������� 4-� (�������) ���� (7-� � 8-� �����), ��:
							if(j == 7) { locper = locper + dop22; }//����� ��������� 4-� ���� � ���������� �����
							dop33 = dop33 / 16;
						}
						if(locper < 128)
						{//���� ����� ��������� ��������� (��� ��������), ��:
							dopper = 1;
							ColorPlay[i] = ColNick[8];//�������� ������ ������� ���
							SetPlayerColor(i, ColorPlay[i]);
			    			for(new k=0;k<MAX_PLAYERS;k++)
							{
								SetPlayerMarkerForPlayer(k, i, ColorPlay[i]);
							}
						}
					}
				}
				if(dopper == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� �� ������ ��������� (��� ��������) ������� �� ����������.");
				}
				else
				{
					format(string, sizeof(string), " ������������� %s ������� ���� ��������� ��������� (��� ��������) ������� ������� ����.",
					RealName[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
				}
				return 1;
			}
			if(para1 == 3)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /plclr 3 [�� ������] !");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
					return 1;
				}
				if(playspa[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��� �� ����������� !");
					return 1;
				}
				ColorPlay[para2] = ColNick[17];//������������� ������ ���� ����
				SetPlayerColor(para2, ColorPlay[para2]);
			    for(new i=0;i<MAX_PLAYERS;i++)
				{
					SetPlayerMarkerForPlayer(i, para2, ColorPlay[para2]);
				}
				format(string, sizeof(string), " ������������� %s ��������� ������ %s ���� ����.", RealName[playerid], RealName[para2]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 4 ��� (�����) --------------------------
//--------------------- ������� ������� 5 ��� (������) -------------------------
	if(strcmp(cmd, "/tweap", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /tweap [�� ������/����� ����]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				ResetPlayerWeapons(para1);//�������� ������ � ��������
				format(string, sizeof(string), " ������������� %s ������� � ������ %s ��� �������� � �� ������.",
				RealName[playerid], RealName[para1]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
		if(strcmp(cmd, "/setweap", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setweap [�� ������] [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweap 600");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - ������     2 - ������ ��� ������\
				\n3 - ��������� �������     4 - ���\
				\n5 - ����������� ����     6 - ������\
				\n7 - ���     8 - ������");
				format(strdln, sizeof(strdln), "%s\n9 - ���������     10 - �����\
				\n15 - ������     16 - �������\
				\n17 - ������������ ���     18 - �������� ��������\
				\n22 - ��������     23 - �������� � ����������", strdln);
				format(strdln, sizeof(strdln), "%s\n24 - ������ ����     25 - ��������\
				\n26 - �����     27 - SPAZ 12\
				\n28 - ���     29 - MP5\
				\n30 - ��-47     31 - �4", strdln);
				format(strdln, sizeof(strdln), "%s\n32 - Tes9     33 - ��������\
				\n34 - ����������� ��������     35 - �������� ���������\
				\n36 - ���     37 - ������\
				\n38 - Minigun     39 - ����������", strdln);
				format(strdln, sizeof(strdln), "%s\n41 - ��������� � �������     42 - ������������\
				\n43 - �����������     44 - ���� ������� �������\
				\n45 - ������������ ����     46 - �������", strdln);
				ShowPlayerDialog(playerid, 2, 0, "ID ��������� � ������:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
				return 1;
			}
			if(playspa[para1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /setweap [�� ������] [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweap 600 !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 46 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� �������� ��� ������] ��� � ������ ������� !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��������, �������, ��� ���� - �� 1 �� 50000 !");
					return 1;
				}
			}
			new para4[64];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "������");
				case 2: format(para4, sizeof(para4), "������ ��� ������");
				case 3: format(para4, sizeof(para4), "��������� �������");
				case 4: format(para4, sizeof(para4), "���");
				case 5: format(para4, sizeof(para4), "����������� ����");
				case 6: format(para4, sizeof(para4), "������");
				case 7: format(para4, sizeof(para4), "���");
				case 8: format(para4, sizeof(para4), "������");
				case 9: format(para4, sizeof(para4), "���������");
				case 10: format(para4, sizeof(para4), "�����");
				case 15: format(para4, sizeof(para4), "������");
				case 16: format(para4, sizeof(para4), "�������");
				case 17: format(para4, sizeof(para4), "������������ ���");
				case 18: format(para4, sizeof(para4), "�������� ��������");
				case 22: format(para4, sizeof(para4), "��������");
				case 23: format(para4, sizeof(para4), "�������� � ����������");
				case 24: format(para4, sizeof(para4), "������ ����");
				case 25: format(para4, sizeof(para4), "��������");
				case 26: format(para4, sizeof(para4), "�����");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "���");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "��-47");
				case 31: format(para4, sizeof(para4), "�4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "��������");
				case 34: format(para4, sizeof(para4), "����������� ��������");
				case 35: format(para4, sizeof(para4), "�������� ���������");
				case 36: format(para4, sizeof(para4), "���");
				case 37: format(para4, sizeof(para4), "������");
				case 38: format(para4, sizeof(para4), "Minigun");
				case 39: format(para4, sizeof(para4), "����������");
				case 41: format(para4, sizeof(para4), "��������� � �������");
				case 42: format(para4, sizeof(para4), "������������");
				case 43: format(para4, sizeof(para4), "�����������");
				case 44: format(para4, sizeof(para4), "���� ������� �������"), para6 = 1;
				case 45: format(para4, sizeof(para4), "������������ ����"), para6 = 1;
				case 46: format(para4, sizeof(para4), "�������");
			}
			if(PlayerInfo[para1][pAdmin] == 0 && para6 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ���� ������� ��� ������ ����� ���� ������ ������ !");
				return 1;
			}
			if(para5 == 0)
			{
				GivePlayerWeapon(para1, para2, 1000);
			}
			else
			{
				if(para2 == 37)
				{
					GivePlayerWeapon(para1, para2, para3 * 10);
				}
				else
				{
					GivePlayerWeapon(para1, para2, para3);
					if(para2 == 39) { GivePlayerWeapon(para1, 40, 10); }
				}
			}
			if(para5 == 0)
			{
				format(string, sizeof(string), " ������������� %s ��� ������ %s %s .", RealName[playerid], RealName[para1], para4);
			}
			else
			{
				if(para2 >= 16 && para2 <= 18)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s ( %d ���� ) .", RealName[playerid],
					RealName[para1], para4, para3);
				}
				if((para2 >= 35 && para2 <= 37) || para2 == 39)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s � %d �������.", RealName[playerid],
					RealName[para1], para4, para3);
				}
				if((para2 >= 22 && para2 <= 34) || para2 == 38)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s � %d ��������.", RealName[playerid],
					RealName[para1], para4, para3);
				}
			}
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/playtp", true) == 0)
	{
   		if(PlayerInfo[playerid][pAdmin] >= 5)
    	{
        	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /playtp [�� ������ ���� ��] [�� ������ � ���� ��]");
				return 1;
			}
			new playtp1;
			playtp1 = strval(tmp);
        	tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /playtp [�� ������ ���� ��] [�� ������ � ���� ��] !");
				return 1;
			}
			new playtp2;
			playtp2 = strval(tmp);
			if(!IsPlayerConnected(playtp1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������, ���� ��, ��� �� ������� !");
				return 1;
			}
			if(!IsPlayerConnected(playtp2))
			{
				SendClientMessage(playerid, COLOR_RED, " ������, � ���� ��, ��� �� ������� !");
				return 1;
			}
			if(playtp1 == playtp2)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ �� ������ � ������ ���� !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] < PlayerInfo[playtp1][pAdmin])
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ������� ������� ������, ���� ��, ���� ������ !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[playtp1][pAdmin] == 12)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� �� - ����� 12-�� ������ !");
				return 1;
			}
			if(PlayerInfo[playtp1][pAdmin] == 13)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ������� !");
				return 1;
			}
			if(PlayerInfo[playtp2][pAdmin] == 13)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, � ���� ��, ������� !");
				return 1;
			}
			if(PlayerInfo[playtp1][pPrisonsec] > 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ����� � ������ !");
				return 1;
			}
			if(perfrost[playtp1] != 600 && perfrost[playtp1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ��������� ! ( + ��� ��������� �� ���� ! )");
				return 1;
			}
			if(PlayLock1[0][playtp1] != 600 && PlayLock1[0][playtp1] != playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ������������ ! ( + ��� ������������ �� ���� ! )");
				return 1;
			}
			if(admper1[playtp1] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ����� ����������� !");
				return 1;
			}
			if(admper1[playtp2] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, � ���� ��, ����� ����������� !");
				return 1;
			}
			if(playspa[playtp1] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, ���� ��, ��� �� ����������� !");
				return 1;
			}
			if(playspa[playtp2] == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! �����, � ���� ��, ��� �� ����������� !");
				return 1;
			}
			format(string, 256, " ������������� %s �������������� ������ %s � ������ %s .", RealName[playerid], RealName[playtp1],
			RealName[playtp2]);
			print(string);
			SendAdminMessage(COLOR_RED,string);
			if(PlayerInfo[playtp1][pAdmin] == 0)
			{
				format(string,256," ������������� %s �������������� ��� � ������ %s .",RealName[playerid],RealName[playtp2]);
				SendClientMessage(playtp1,COLOR_RED,string);
			}
			new Float:PosX, Float:PosY, Float:PosZ;
			new nmod = GetVehicleModel(GetPlayerVehicleID(playtp1));
			if(nmod == 538 || nmod == 537)
			{//���� ����� � ������, �� �������� ������ �� ������
				GetPlayerPos(playtp1, PosX ,PosY, PosZ);
				SetPlayerPos(playtp1, PosX+3, PosY+3, PosZ+5);
			}
			if(PlayLock1[0][playtp1] != 600 && PlayLock1[0][playtp1] == playerid)
			{//���� ����� ������������, �� �� ���������������� ������
				PlayLock1[1][playtp1] = GetPlayerInterior(playtp2);//��������� ��������� ����������
				PlayLock1[2][playtp1] = GetPlayerVirtualWorld(playtp2);//��������� ������������ ���� ����������
				GetPlayerPos(playtp2, PlayLock2[0][playtp1], PlayLock2[1][playtp1], PlayLock2[2][playtp1]);//��������� ��������� ����������
				PlayLock2[1][playtp1] = PlayLock2[1][playtp1] + 1;
			}
			else//����� - �� �� ���������������� ������
			{
				if(GetPlayerState(playtp1) == 2)//���� ����� �� ����� ��������, ��:
				{
					new regm = 1, per1, per2, Float:per3, Float:cor1, Float:cor2, Float:cor3;
					per1 = GetPlayerInterior(playtp2);
					per2 = GetPlayerVirtualWorld(playtp2);
					GetPlayerPos(playtp2, PosX, PosY, PosZ);
					cor1 = PosX;
					cor2 = PosY+1;
					cor3 = PosZ+1;
					LogTelPort(playtp1, regm, per1, per2, Float:per3, Float:cor1, Float:cor2, Float:cor3);
				}
				else//�����:
				{
					SetPlayerInterior(playtp1, GetPlayerInterior(playtp2));
					SetPlayerVirtualWorld(playtp1, GetPlayerVirtualWorld(playtp2));
					GetPlayerPos(playtp2, PosX, PosY, PosZ);
					SetPlayerPos(playtp1, PosX, PosY+1, PosZ+1);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/edgangs", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /edgangs [����� (0- �� �� �����, 1- �� �� ������ �� �����)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [�� ����� ��� ������] [�� ��������� (0- ����������� �������� ����������");
				SendClientMessage(playerid, COLOR_GRAD2, " � �����, 1- ���������� �������� �����, 2- �������� ����� �����,");
				SendClientMessage(playerid, COLOR_GRAD2, " 3- �� �� ����� �����)]");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� 0 ��� 1 !");
				return 1;
			}
			if(para1 == 0)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� �����] [�� ��������� (0- ����������� �������� ����������");
					SendClientMessage(playerid, COLOR_RED, " � �����, 1- ���������� �������� �����, 2- �������� ����� �����,");
					SendClientMessage(playerid, COLOR_RED, " 3- �� �� ����� �����)]");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				format(string,sizeof(string),"gangs/%i.ini",para2);
				if(!fexist(string) || para2 >= (MAX_GANGS - 1))
				{
					SendClientMessage(playerid,COLOR_RED," ������ [�� �����] �� ���������� !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� ��������� (0- ����������� �������� ����������");
					SendClientMessage(playerid, COLOR_RED, " � �����, 1- ���������� �������� �����, 2- �������� ����� �����,");
					SendClientMessage(playerid, COLOR_RED, " 3- �� �� ����� �����)]");
					return 1;
				}
				new para3;
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 3 !");
					return 1;
				}
				if(para3 == 0)
				{
					new dopper[16];
					strdel(dopper, 0, 16);
					strmid(dopper, GColor[para2], 0, 6, sizeof(dopper));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					format(string, sizeof(string), " ����: [%s] ��������: [%s]", dopper, GName[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_GRAD1, " ����� �����:");
					format(string, sizeof(string), " x = %f   y = %f   z = %f", GSpawnX[para2], GSpawnY[para2], GSpawnZ[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �������� = %d   ����������� ��� = %d", GInter[para2], GWorld[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �����: [%s] ����� �������: [%d]", GHead[para2], GPlayers[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �����������: [ %s ] ID: [%d]", GTDReg[para2], para2);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					printf(" ������������� %s ���������� ���������� � ����� [ID: %d]", RealName[playerid], para2);
					return 1;
				}
				if(para3 == 1)
				{
					new result[128];
					format(result, sizeof(result), "Default - %d", para2);
					if(strcmp(GName[para2],result,false) == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " �������� ����� ��� ����������� !");
						return 1;
					}
					strdel(GName[para2], 0, 130);//������� ������� �����
					strcat(GName[para2], result);//������������� ������� �����
					GangSave(para2);//������ ID ����� � ����
					format(string, sizeof(string), " ������������� %s ��������� �������� ����� %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 2)
				{
					if(GSpawnX[para2] == 0.00 && GSpawnY[para2] == 0.00 && GSpawnZ[para2] == 0.00 &&
					GInter[para2] == 0 && GWorld[para2] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����� ����� ��� ������ !");
						return 1;
					}
					GSpawnX[para2] = 0.00;//�������� ����� �����
					GSpawnY[para2] = 0.00;
					GSpawnZ[para2] = 0.00;
					GInter[para2] = 0;
					GWorld[para2] = 0;
					GangSave(para2);//������ ID ����� � ����
					format(string, sizeof(string), " ������������� %s ������� ����� ����� %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 3)
				{
					if(admper1[playerid] != 600)
					{
						SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ����� �� �������� !");
						return 1;
					}
					if(GSpawnX[para2] == 0.00 && GSpawnY[para2] == 0.00 && GSpawnZ[para2] == 0.00 &&
					GInter[para2] == 0 && GWorld[para2] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����� ������ ����� �� ��������� !");
						return 1;
					}
					SetPlayerInterior(playerid, GInter[para2]);
					SetPlayerVirtualWorld(playerid, GWorld[para2]);
					SetPlayerPos(playerid, GSpawnX[para2], GSpawnY[para2], GSpawnZ[para2]);
					format(string, sizeof(string), " ������������� %s ���������������� �� ����� ����� %s [ID: %d]", RealName[playerid], GName[para2], para2);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
			}
			if(para1 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� ������] [�� ��������� (0- ����������� �������� ����������");
					SendClientMessage(playerid, COLOR_RED, " � �����, 1- ���������� �������� �����, 2- �������� ����� �����,");
					SendClientMessage(playerid, COLOR_RED, " 3- �� �� ����� �����)]");
					return 1;
				}
				new para2;
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
					return 1;
				}
				if(gPlayerLogged[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(PGang[para2] <= 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� �� ������� �� � ����� �� ���� !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� ��������� (0- ����������� �������� ����������");
					SendClientMessage(playerid, COLOR_RED, " � �����, 1- ���������� �������� �����, 2- �������� ����� �����,");
					SendClientMessage(playerid, COLOR_RED, " 3- �� �� ����� �����)]");
					return 1;
				}
				new para3;
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 3)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 3 !");
					return 1;
				}
				if(para3 == 0)
				{
					new dopper[16];
					strdel(dopper, 0, 16);
					strmid(dopper, GColor[PGang[para2]], 0, 6, sizeof(dopper));
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					format(string, sizeof(string), " ����: [%s] ��������: [%s]", dopper, GName[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_GRAD1, " ����� �����:");
					format(string, sizeof(string), " x = %f   y = %f   z = %f", GSpawnX[PGang[para2]], GSpawnY[PGang[para2]], GSpawnZ[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �������� = %d   ����������� ��� = %d", GInter[PGang[para2]], GWorld[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �����: [%s] ����� �������: [%d]", GHead[PGang[para2]], GPlayers[PGang[para2]]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), " �����������: [ %s ] ID: [%d]", GTDReg[PGang[para2]], PGang[para2]);
					SendClientMessage(playerid, COLOR_GRAD1, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "-----------------------------------------------------------------");
					printf(" ������������� %s ���������� ���������� � ����� [ID: %d]", RealName[playerid], PGang[para2]);
					return 1;
				}
				if(para3 == 1)
				{
					new result[128];
					format(result, sizeof(result), "Default - %d", PGang[para2]);
					if(strcmp(GName[PGang[para2]],result,false) == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " �������� ����� ��� ����������� !");
						return 1;
					}
					strdel(GName[PGang[para2]], 0, 130);//������� ������� �����
					strcat(GName[PGang[para2]], result);//������������� ������� �����
					GangSave(PGang[para2]);//������ ID ����� � ����
					format(string, sizeof(string), " ������������� %s ��������� �������� ����� %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
				}
				if(para3 == 2)
				{
					if(GSpawnX[PGang[para2]] == 0.00 && GSpawnY[PGang[para2]] == 0.00 && GSpawnZ[PGang[para2]] == 0.00 &&
					GInter[PGang[para2]] == 0 && GWorld[PGang[para2]] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����� ����� ��� ������ !");
						return 1;
					}
					GSpawnX[PGang[para2]] = 0.00;//�������� ����� �����
					GSpawnY[PGang[para2]] = 0.00;
					GSpawnZ[PGang[para2]] = 0.00;
					GInter[PGang[para2]] = 0;
					GWorld[PGang[para2]] = 0;
					GangSave(PGang[para2]);//������ ID ����� � ����
					format(string, sizeof(string), " ������������� %s ������� ����� ����� %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
				if(para3 == 3)
				{
					if(admper1[playerid] != 600)
					{
						SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ����� �� �������� !");
						return 1;
					}
					if(GSpawnX[PGang[para2]] == 0.00 && GSpawnY[PGang[para2]] == 0.00 && GSpawnZ[PGang[para2]] == 0.00 &&
					GInter[PGang[para2]] == 0 && GWorld[PGang[para2]] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ����� ������ ����� �� ��������� !");
						return 1;
					}
					SetPlayerInterior(playerid, GInter[PGang[para2]]);
					SetPlayerVirtualWorld(playerid, GWorld[PGang[para2]]);
					SetPlayerPos(playerid, GSpawnX[PGang[para2]], GSpawnY[PGang[para2]], GSpawnZ[PGang[para2]]);
					format(string, sizeof(string), " ������������� %s ���������������� �� ����� ����� %s [ID: %d]", RealName[playerid], GName[PGang[para2]], PGang[para2]);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					return 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
//--------------------- ������� ������� 5 ��� (�����) --------------------------
//--------------------- ������� ������� 6 ��� (������) -------------------------
	if(strcmp(cmd, "/banakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 6)
    	{
   			new data2[2];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /banakk [��� ��������] [�������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new file;//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "AdminLevel", data2[0]);
				ini_getInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data2[0] < 0)
			{
				fadm = data2[0] * -1;
			}
			else
			{
				fadm = data2[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//�������� �������� �� �������
			{
				format(ssss,sizeof(ssss)," ������, ������� ������ [%s] - ����� %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(data2[1] == 1)//���� ������� ��� ������������, ��:
			{
				format(ssss,sizeof(ssss)," ������� ������ [%s] ��� ������������ (�������) !", akk);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			data2[1] = 1;//���������� ��������
			strdel(ssss, 0, 256);//������ RCON-������� ����
			strcat(ssss, "banip ");
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-������� ����
			SendRconCommand("reloadbans");//RCON-������� ������������ ���-�����
			file = ini_openFile(string);//������ ���������� ��������
			if(file >= 0)
			{
				ini_setInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			format(ssss,sizeof(ssss)," ������������� %s ������� ������� ������ [%s] ( IP: [%s] ) , �������: %s",
			RealName[playerid], akk, adrip, result);
			print(ssss);
			SendAdminMessage(COLOR_RED, ssss);
			format(ssss,sizeof(ssss)," ������������� %s ������� ������� ������ [%s] , �������: %s", RealName[playerid], akk, result);
			for(new i=0;i<MAX_PLAYERS;i++)//�������� ��������� �� �������
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				{
					SendClientMessage(i, COLOR_RED, ssss);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/tweaprad", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			new Float: X, Float:Y, Float: Z, playvw;
			GetPlayerPos(playerid, X, Y, Z);
			playvw = GetPlayerVirtualWorld(playerid);
			new per55 = 0;
			for(new i = 0; i < MAX_PLAYERS ; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(IsPlayerInRangeOfPoint(i, 100.0, X, Y, Z) && GetPlayerVirtualWorld(i) == playvw && i != playerid)
					{
						per55 = 1;
						ResetPlayerWeapons(i);//�������� ������ � ��������
					}
				}
			}
			if(per55 == 0)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� ���������� �� ���������� !");
			}
			else
			{
				format(string, sizeof(string), " ������������� %s ������� � ���� ������� ��� �������� � �� ������",
				RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				format(string, sizeof(string), " *** � ������� 100 ������������ ������.");
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/setweapall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setweapall [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweapall 600");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 == 600)
			{
				format(strdln, sizeof(strdln), "1 - ������     2 - ������ ��� ������\
				\n3 - ��������� �������     4 - ���\
				\n5 - ����������� ����     6 - ������\
				\n7 - ���     8 - ������");
				format(strdln, sizeof(strdln), "%s\n9 - ���������     14 - ����� ������\
				\n15 - ������     16 - �������\
				\n17 - ������������ ���     18 - �������� ��������\
				\n22 - ��������     23 - �������� � ����������", strdln);
				format(strdln, sizeof(strdln), "%s\n24 - ������ ����     25 - ��������\
				\n26 - �����     27 - SPAZ 12\
				\n28 - ���     29 - MP5\
				\n30 - ��-47     31 - �4", strdln);
				format(strdln, sizeof(strdln), "%s\n32 - Tes9     33 - ��������\
				\n34 - ����������� ��������     35 - �������� ���������\
				\n36 - ���     37 - ������\
				\n38 - Minigun     39 - ����������", strdln);
				format(strdln, sizeof(strdln), "%s\n41 - ��������� � �������     42 - ������������\
				\n43 - �����������     44 - ���� ������� �������\
				\n45 - ������������ ����     46 - �������", strdln);
				ShowPlayerDialog(playerid, 2, 0, "ID ��������� � ������:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� �������� ��� ������] ��� � ������ ������� !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��������, �������, ��� ���� - �� 1 �� 50000 !");
					return 1;
				}
			}
			new para4[64];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "�������");
				case 2: format(para4, sizeof(para4), "������ ��� ������");
				case 3: format(para4, sizeof(para4), "��������� �������");
				case 4: format(para4, sizeof(para4), "����");
				case 5: format(para4, sizeof(para4), "����������� ����");
				case 6: format(para4, sizeof(para4), "������");
				case 7: format(para4, sizeof(para4), "���");
				case 8: format(para4, sizeof(para4), "������");
				case 9: format(para4, sizeof(para4), "���������");
				case 14: format(para4, sizeof(para4), "������ ������");
				case 15: format(para4, sizeof(para4), "������");
				case 16: format(para4, sizeof(para4), "�������");
				case 17: format(para4, sizeof(para4), "������������� ����");
				case 18: format(para4, sizeof(para4), "�������� ��������");
				case 22: format(para4, sizeof(para4), "���������");
				case 23: format(para4, sizeof(para4), "��������� � ����������");
				case 24: format(para4, sizeof(para4), "������ ����");
				case 25: format(para4, sizeof(para4), "���������");
				case 26: format(para4, sizeof(para4), "������");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "���");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "��-47");
				case 31: format(para4, sizeof(para4), "�4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "��������");
				case 34: format(para4, sizeof(para4), "����������� ��������");
				case 35: format(para4, sizeof(para4), "�������� ���������");
				case 36: format(para4, sizeof(para4), "���");
				case 37: format(para4, sizeof(para4), "�������");
				case 38: format(para4, sizeof(para4), "Minigun");
				case 39: format(para4, sizeof(para4), "����������");
				case 41: format(para4, sizeof(para4), "���������� � �������");
				case 42: format(para4, sizeof(para4), "������������");
				case 43: format(para4, sizeof(para4), "������������");
				case 44: format(para4, sizeof(para4), "����� ������� �������"), para6 = 1;
				case 45: format(para4, sizeof(para4), "������������ �����"), para6 = 1;
				case 46: format(para4, sizeof(para4), "��������");
			}
			new para777 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && PlayerInfo[i][pAdmin] >= 1 && para6 == 1)
					{
						if(para5 == 0)
						{
							para777 = 1;
							GivePlayerWeapon(i, para2, 1000);
						}
						else
						{
							para777 = 1;
							if(para2 == 37)
							{
								GivePlayerWeapon(i, para2, para3 * 10);
							}
							else
							{
								GivePlayerWeapon(i, para2, para3);
								if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
							}
						}
					}
					if(playspa[i] == 1 && para6 == 0)
					{
						if(para5 == 0)
						{
							para777 = 1;
							GivePlayerWeapon(i, para2, 1000);
						}
						else
						{
							para777 = 1;
							if(para2 == 37)
							{
								GivePlayerWeapon(i, para2, para3 * 10);
							}
							else
							{
								GivePlayerWeapon(i, para2, para3);
								if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
							}
						}
					}
				}
			}
			if(para777 == 1)
			{
				if(para5 == 0)
				{
					format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s .", RealName[playerid], para4);
				}
				else
				{
					if(para2 >= 16 && para2 <= 18)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s ( �� %d ���� ������� ) .",
						RealName[playerid], para4, para3);
					}
					if((para2 >= 35 && para2 <= 37) || para2 == 39)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s , � �� %d ������� �������.",
						RealName[playerid], para4, para3);
					}
					if((para2 >= 22 && para2 <= 34) || para2 == 38)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s , � �� %d �������� �������.",
						RealName[playerid], para4, para3);
					}
				}
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " �� ���� �� ������� �� ������� ����������� ���� �� �������� ��� ������ !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/plcmon", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /plcmon [0- ����., 1- ���., 2- ����������� ���������]");
				SendClientMessage(playerid, COLOR_GRAD2, " ( ������������� [��������� �����������(10-1000)] )");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 2)
			{
				SendClientMessage(playerid, COLOR_RED, " 0- ����., 1- ���., 2- ����������� ��������� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			new para2;
			new para3;
			if(!strlen(tmp))
			{
				para2 = 500;
				para3 = 0;
			}
			else
			{
				para2 = strval(tmp);
				para3 = 1;
			}
			if(para2 < 10 || para2 > 1000)
			{
				SendClientMessage(playerid, COLOR_RED, " ��������� ����������� �� 10 �� 1000 !");
				return 1;
			}
			if(para1 == 0)
			{
				if(plcmonloc[playerid] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ����-������� � ���� ��� �������� !");
					return 1;
				}
				else
				{
					plcmonloc[playerid] = 0;
					format(string, sizeof(string), " ������������� %s �������� ����-�������.", RealName[playerid]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					return 1;
				}
			}
			if(para1 == 1)
			{
				if(plcmonloc[playerid] == 1 && para3 == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " �� �� ������ ��������� ����������� !");
					return 1;
				}
				if(plcmonloc[playerid] == 1 && para3 == 1 && plcmondist[playerid] == para2)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ������ ������ ��������� ����������� !");
					return 1;
				}
				if(plcmonloc[playerid] == 1 && para3 == 1 && plcmondist[playerid] != para2)
				{
					plcmondist[playerid] = para2;
					format(string, sizeof(string), " ������������� %s ������� ��������� ����������� ��� ����-�������� �� %d",
					RealName[playerid], plcmondist[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					return 1;
				}
				if(plcmonloc[playerid] == 0)
				{
					plcmonloc[playerid] = 1;
					plcmondist[playerid] = para2;
					format(string, sizeof(string), " ������������� %s ������� ����-�������, � ���������� ����������� %d",
					RealName[playerid], plcmondist[playerid]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					return 1;
				}
			}
			if(para1 == 2)
			{
				if(plcmonloc[playerid] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ����-������� ��������.");
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
					SendClientMessage(playerid, COLOR_GREEN, " ����-������� �������.");
					format(string, sizeof(string), " ��������� �����������: {FFFF00}%d .", plcmondist[playerid]);
					SendClientMessage(playerid, COLOR_GREEN, string);
					SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------");
					printf(" ������������� %s ���������� ��������� ����-��������.", RealName[playerid]);
					return 1;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 6 ��� (�����) --------------------------
//--------------------- ������� ������� 7 ��� (������) -------------------------
	if(strcmp(cmd, "/money", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /money [�� ������/����� ����] [�����] [�������]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ����� � ������� !");
				return 1;
			}
			money = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				new dopper44;
				dopper44 = GetPlayerMoney(playa);
				if(money < 0)
				{
					SetPVarInt(playa, "MonControl", 1);
					GivePlayerMoney(playa, money);
					format(string, 256, " ������������� %s ����� � ������ %s %d $ , �������: %s", RealName[playerid], RealName[playa],
					money, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_RED, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_RED, string);
					}
					printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[playa], playa, dopper44);
				}
				else
				{
					new twenlim, restlim;
					if(Fmadmins(2, RealName[playerid], money, twenlim, restlim) == 1)
					{
						SetPVarInt(playa, "MonControl", 1);
						GivePlayerMoney(playa, money);
						format(string, 256, " ������������� %s ��� ������ %s %d $ , �������: %s", RealName[playerid], RealName[playa],
						money, result);
						print(string);
						if (PlayerInfo[playa][pAdmin] >= 1)
						{
							SendAdminMessage(COLOR_YELLOW, string);
						}
						else
						{
							SendClientMessageToAll(COLOR_YELLOW, string);
						}
						printf(" ������������� %s >> �������� �������� �����: [%d] ������� ��������� ������: [%d]", RealName[playerid],
						twenlim, restlim);
						printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[playa], playa, dopper44);
					}
					else
					{
						if(restlim == 0)
						{
							SendClientMessage(playerid, COLOR_RED, " ������ ! �� ������������� �������� �������� ����� !");
						}
						else
						{
							SendClientMessage(playerid, COLOR_RED, " ������ ! � ��� ������������� ������� ��������� ������ !");
						}
					}
					if(twenlim != 0)
					{
						format(string, 256, " �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
						SendClientMessage(playerid, COLOR_RED, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
		if(strcmp(cmd, "/setweap", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 5)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setweap [�� ������] [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweap 600");
				return 1;
			}
			new para1;
			para1 = strval(tmp);
			if(para1 == 600)
			{
				new soob11[256];
				format(soob11, sizeof(soob11), "1 - ������     2 - ������ ��� ������\
				\n3 - ��������� �������     4 - ���\
				\n5 - ����������� ����     6 - ������\
				\n7 - ���     8 - ������");
				new soob12[256];
				format(soob12, sizeof(soob12), "\n9 - ���������     14 - ����� ������\
				\n15 - ������     16 - �������\
				\n17 - ������������ ���     18 - �������� ��������\
				\n22 - ��������     23 - �������� � ����������");
				new soob13[256];
				format(soob13, sizeof(soob13), "\n24 - ������ ����     25 - ��������\
				\n26 - �����     27 - SPAZ 12\
				\n28 - ���     29 - MP5\
				\n30 - ��-47     31 - �4");
				new soob14[256];
				format(soob14, sizeof(soob14), "\n32 - Tes9     33 - ��������\
				\n34 - ����������� ��������     35 - �������� ���������\
				\n36 - ���     37 - ������\
				\n38 - Minigun     39 - ����������");
				new soob15[256];
				format(soob15, sizeof(soob15), "\n41 - ��������� � �������     42 - ������������\
				\n43 - �����������     44 - ���� ������� �������\
				\n45 - ������������ ����     46 - �������");
				new soob[1280];
				format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
				ShowPlayerDialog(playerid, 2, 0, "ID ��������� � ������:", soob, "OK", "");
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
				return 1;
			}
			if(DerbyID[para1] == 2)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ! ��������� ����� � ���� ����� !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " /setweap [�� ������] [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweap 600 !");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� �������� ��� ������] ��� � ������ ������� !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��������, �������, ��� ���� - �� 1 �� 50000 !");
					return 1;
				}
			}
			new para4[256];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "������");
				case 2: format(para4, sizeof(para4), "������ ��� ������");
				case 3: format(para4, sizeof(para4), "��������� �������");
				case 4: format(para4, sizeof(para4), "���");
				case 5: format(para4, sizeof(para4), "����������� ����");
				case 6: format(para4, sizeof(para4), "������");
				case 7: format(para4, sizeof(para4), "���");
				case 8: format(para4, sizeof(para4), "������");
				case 9: format(para4, sizeof(para4), "���������");
				case 14: format(para4, sizeof(para4), "����� ������");
				case 15: format(para4, sizeof(para4), "������");
				case 16: format(para4, sizeof(para4), "�������");
				case 17: format(para4, sizeof(para4), "������������ ���");
				case 18: format(para4, sizeof(para4), "�������� ��������");
				case 22: format(para4, sizeof(para4), "��������");
				case 23: format(para4, sizeof(para4), "�������� � ����������");
				case 24: format(para4, sizeof(para4), "������ ����");
				case 25: format(para4, sizeof(para4), "��������");
				case 26: format(para4, sizeof(para4), "�����");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "���");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "��-47");
				case 31: format(para4, sizeof(para4), "�4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "��������");
				case 34: format(para4, sizeof(para4), "����������� ��������");
				case 35: format(para4, sizeof(para4), "�������� ���������"), para6 = 1;
				case 36: format(para4, sizeof(para4), "���"), para6 = 1;
				case 37: format(para4, sizeof(para4), "������"), para6 = 1;
				case 38: format(para4, sizeof(para4), "Minigun"), para6 = 1;
				case 39: format(para4, sizeof(para4), "����������");
				case 41: format(para4, sizeof(para4), "��������� � �������");
				case 42: format(para4, sizeof(para4), "������������");
				case 43: format(para4, sizeof(para4), "�����������");
				case 44: format(para4, sizeof(para4), "���� ������� �������"), para6 = 1;
				case 45: format(para4, sizeof(para4), "������������ ����"), para6 = 1;
				case 46: format(para4, sizeof(para4), "�������");
			}
			if(PlayerInfo[para1][pAdmin] == 0 && para6 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ���� ������� ��� ������ ����� ���� ������ ������ !");
				return 1;
			}
			if(para5 == 0)
			{
				GivePlayerWeapon(para1, para2, 1000);
				return 1;
			}
			else
			{
				if(para2 == 37)
				{
					GivePlayerWeapon(para1, para2, para3 * 10);
				}
				else
				{
					GivePlayerWeapon(para1, para2, para3);
					if(para2 == 39) { GivePlayerWeapon(para1, 40, 10); }
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			if(para5 == 0)
			{
				format(string, sizeof(string), " ������������� %s ��� ������ %s %s .", sendername, giveplayer, para4);
			}
			else
			{
				if(para2 >= 16 && para2 <= 18)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s ( %d ���� ) .", sendername, giveplayer, para4, para3);
				}
				if((para2 >= 35 && para2 <= 37) || para2 == 39)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s � %d �������.", sendername, giveplayer, para4, para3);
				}
				if((para2 >= 22 && para2 <= 34) || para2 == 38)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s %s � %d ��������.", sendername, giveplayer, para4, para3);
				}
			}
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setweapall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 6)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setweapall [�� �������� ��� ������(1-46)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [����� ��������, �������, ��� ����(1-50000)] ��� /setweapall 600");
				return 1;
			}
			new para2;
			para2 = strval(tmp);
			if(para2 == 600)
			{
				new soob11[256];
				format(soob11, sizeof(soob11), "1 - ������     2 - ������ ��� ������\
				\n3 - ��������� �������     4 - ���\
				\n5 - ����������� ����     6 - ������\
				\n7 - ���     8 - ������");
				new soob12[256];
				format(soob12, sizeof(soob12), "\n9 - ���������     14 - ����� ������\
				\n15 - ������     16 - �������\
				\n17 - ������������ ���     18 - �������� ��������\
				\n22 - ��������     23 - �������� � ����������");
				new soob13[256];
				format(soob13, sizeof(soob13), "\n24 - ������ ����     25 - ��������\
				\n26 - �����     27 - SPAZ 12\
				\n28 - ���     29 - MP5\
				\n30 - ��-47     31 - �4");
				new soob14[256];
				format(soob14, sizeof(soob14), "\n32 - Tes9     33 - ��������\
				\n34 - ����������� ��������     35 - �������� ���������\
				\n36 - ���     37 - ������\
				\n38 - Minigun     39 - ����������");
				new soob15[256];
				format(soob15, sizeof(soob15), "\n41 - ��������� � �������     42 - ������������\
				\n43 - �����������     44 - ���� ������� �������\
				\n45 - ������������ ����     46 - �������");
				new soob[1280];
				format(soob, sizeof(soob), "%s%s%s%s%s", soob11, soob12, soob13, soob14, soob15);
				ShowPlayerDialog(playerid, 2, 0, "ID ��������� � ������:", soob, "OK", "");
				return 1;
			}
			if(para2 < 1 || para2 > 46 || para2 == 10 || para2 == 11 || para2 == 12 || para2 == 13 ||
			para2 == 19 || para2 == 20 || para2 == 21 || para2 == 40)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� �������� ��� ������] ��� � ������ ������� !");
				return 1;
			}
			new para5 = 0;
			if(para2 >= 16 && para2 <= 39) { para5 = 1; }
			new para3;
			if(para5 == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [����� ��������, �������, ��� ����(1-50000)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 50000)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ��������, �������, ��� ���� - �� 1 �� 50000 !");
					return 1;
				}
			}
			new para4[256];
		 	new para6 = 0;
			switch(para2)
			{
				case 1: format(para4, sizeof(para4), "�������");
				case 2: format(para4, sizeof(para4), "������ ��� ������");
				case 3: format(para4, sizeof(para4), "��������� �������");
				case 4: format(para4, sizeof(para4), "����");
				case 5: format(para4, sizeof(para4), "����������� ����");
				case 6: format(para4, sizeof(para4), "������");
				case 7: format(para4, sizeof(para4), "���");
				case 8: format(para4, sizeof(para4), "������");
				case 9: format(para4, sizeof(para4), "���������");
				case 14: format(para4, sizeof(para4), "������ ������");
				case 15: format(para4, sizeof(para4), "������");
				case 16: format(para4, sizeof(para4), "�������");
				case 17: format(para4, sizeof(para4), "������������� ����");
				case 18: format(para4, sizeof(para4), "�������� ��������");
				case 22: format(para4, sizeof(para4), "���������");
				case 23: format(para4, sizeof(para4), "��������� � ����������");
				case 24: format(para4, sizeof(para4), "������ ����");
				case 25: format(para4, sizeof(para4), "���������");
				case 26: format(para4, sizeof(para4), "������");
				case 27: format(para4, sizeof(para4), "SPAZ 12");
				case 28: format(para4, sizeof(para4), "���");
				case 29: format(para4, sizeof(para4), "MP5");
				case 30: format(para4, sizeof(para4), "��-47");
				case 31: format(para4, sizeof(para4), "�4");
				case 32: format(para4, sizeof(para4), "Tes9");
				case 33: format(para4, sizeof(para4), "��������");
				case 34: format(para4, sizeof(para4), "����������� ��������");
				case 35: format(para4, sizeof(para4), "�������� ���������"), para6 = 1;
				case 36: format(para4, sizeof(para4), "���"), para6 = 1;
				case 37: format(para4, sizeof(para4), "�������"), para6 = 1;
				case 38: format(para4, sizeof(para4), "Minigun"), para6 = 1;
				case 39: format(para4, sizeof(para4), "����������");
				case 41: format(para4, sizeof(para4), "���������� � �������");
				case 42: format(para4, sizeof(para4), "������������");
				case 43: format(para4, sizeof(para4), "������������");
				case 44: format(para4, sizeof(para4), "����� ������� �������"), para6 = 1;
				case 45: format(para4, sizeof(para4), "������������ �����"), para6 = 1;
				case 46: format(para4, sizeof(para4), "��������");
			}
			new para777 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && playspa[i] == 1 && PlayerInfo[i][pAdmin] >= 1 && para6 == 1 && DerbyID[i] == 0)
				{
					if(para5 == 0)
					{
						para777 = 1;
						GivePlayerWeapon(i, para2, 1000);
					}
					else
					{
						para777 = 1;
						if(para2 == 37)
						{
							GivePlayerWeapon(i, para2, para3 * 10);
						}
						else
						{
							GivePlayerWeapon(i, para2, para3);
							if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
						}
					}
				}
				if(IsPlayerConnected(i) && playspa[i] == 1 && para6 == 0 && DerbyID[i] == 0)
				{
					if(para5 == 0)
					{
						para777 = 1;
						GivePlayerWeapon(i, para2, 1000);
					}
					else
					{
						para777 = 1;
						if(para2 == 37)
						{
							GivePlayerWeapon(i, para2, para3 * 10);
						}
						else
						{
							GivePlayerWeapon(i, para2, para3);
							if(para2 == 39) { GivePlayerWeapon(i, 40, 10); }
						}
					}
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(para777 == 1)
			{
				if(para5 == 0)
				{
					format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s .", sendername, para4);
				}
				else
				{
					if(para2 >= 16 && para2 <= 18)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s ( �� %d ���� ������� ) .", sendername, para4, para3);
					}
					if((para2 >= 35 && para2 <= 37) || para2 == 39)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s , � �� %d ������� �������.", sendername, para4, para3);
					}
					if((para2 >= 22 && para2 <= 34) || para2 == 38)
					{
						format(string, sizeof(string), " ������������� %s ������ ���� ������� �� %s , � �� %d �������� �������.", sendername, para4, para3);
					}
				}
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " �� ���� �� ������� �� ������� ����������� ���� �� �������� ��� ������ !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
 	if(strcmp(cmd, "/setmonall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setmonall [�����]");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " ����� �� ����� ���� ������������� ������ !"); return 1; }
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && playspa[i] == 1)
				{
					SetPVarInt(i, "PlMon", money);
				}
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, 256, " ������������� %s ��������� ���� ������� �� %d $", sendername,money);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
 	if(strcmp(cmd, "/moneyall", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /moneyall [�����] [�������]");
				return 1;
			}
			new money;
			money = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(money < 0)
			{
				money = money * -1;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{
						SetPVarInt(i, "PlMon", GetPVarInt(i, "PlMon") - money);
					}
				}
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 256, " ������������� %s ����� � ���� ������� �� %d $ , �������: %s", sendername,money,result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && playspa[i] == 1)
					{
						SetPVarInt(i, "PlMon", GetPVarInt(i, "PlMon") + money);
					}
				}
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, 256, " ������������� %s ������ ���� ������� �� %d $ , �������: %s ", sendername,money,result);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setmon", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setmon [�� ������/����� ����] [�����]");
				return 1;
			}
			new playa;
			new money;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ����� !");
				return 1;
			}
			money = strval(tmp);
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(money < 0) { SendClientMessage(playerid, COLOR_RED, " ����� �� ����� ���� ������������� ������ !"); return 1; }
				new dopper44;
				dopper44 = GetPlayerMoney(playa);
				new twenlim, restlim;
				if(Fmadmins(2, RealName[playerid], money, twenlim, restlim) == 1)
				{
					SetPVarInt(playa, "MonControl", 1);
					ResetPlayerMoney(playa);
					GivePlayerMoney(playa, money);
					format(string, 256, " ������������� %s ��������� ������ %s %d $", RealName[playerid], RealName[playa], money);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_YELLOW, string);
					}
					printf(" ������������� %s >> �������� �������� �����: [%d] ������� ��������� ������: [%d]", RealName[playerid],
					twenlim, restlim);
					printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[playa], playa, dopper44);
				}
				else
				{
					if(restlim == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ������ ! �� ������������� �������� �������� ����� !");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, " ������ ! � ��� ������������� ������� ��������� ������ !");
					}
				}
				if(twenlim != 0)
				{
					format(string, 256, " �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_RED, string);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/live", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(PlayerInfo[playerid][pAdmlive] == 1)
			{
				PlayerInfo[playerid][pAdmlive] = 0;
				format(string, sizeof(string), " ������������� %s �������� ����������� ����������.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_RED, string);
				return 1;
			}
			else
			{
				PlayerInfo[playerid][pAdmlive] = 1;
				format(string, sizeof(string), " ������������� %s ������� ����������� ����������.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_GREEN, string);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/admtp", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			new dopper1 = 0;
			new Float:PosX, Float:PosY, Float:PosZ;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && (PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] <= 12) && i != playerid)
					{
						dopper1 = 1;
						if(PlayerInfo[i][pPrisonsec] > 0)//���� ����� � ������, ��:
						{
							PlayerInfo[i][pPrison]--;
							PlayerInfo[i][pPrisonsec] = 0;
							weapstatplay[i] = 0;
							SpawnPlayer(i);//������� ������
							SendClientMessage(i, COLOR_GREEN, "* �������� ( �� ������� /admtp )");
							SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
						}
						else
						{
							if(PlayLock1[0][i] != 600)//���� ����� ������������, ��:
							{
								PlayLock1[1][i] = GetPlayerInterior(playerid);//��������� ��������� ����������
								PlayLock1[2][i] = GetPlayerVirtualWorld(playerid);//��������� ������������ ���� ����������
								GetPlayerPos(playerid, PlayLock2[0][i], PlayLock2[1][i], PlayLock2[2][i]);//��������� ��������� ����������
								PlayLock2[1][i] = PlayLock2[1][i] + 1;
							}
							else
							{
								if(admper1[i] != 600)//���� ����� � ����������, ��:
								{
									TogglePlayerSpectating(i, 0);//��������� ���������� ��� ������
									admper6[i] = 0;//�������� ������� � ������������ ����������
									SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
								}
								else
								{
			 						SetPlayerInterior(i, GetPlayerInterior(playerid));
									SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
			   						GetPlayerPos(playerid, PosX, PosY, PosZ);
									SetPlayerPos(i, PosX, PosY+1, PosZ+1);
								}
							}
						}
					}
				}
			}
            if(dopper1 == 1)
            {
				format(string, 256, " ������������� %s �������������� ���� ������� � ����.", RealName[playerid]);
				print(string);
				SendAdminMessage(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ��� ��������� ������� ��� �� � ���� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/konec", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			if(nucexplos == 0)
			{
				SetWeather(19);
				SetWorldTime(0);
				new Float:sx, Float:sy, Float:sz;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						SnowONOFF[i] = 1;
						SetPlayerArmour(i, 100);
						SetPlayerHealth(i, 100);
						GetPlayerCameraPos(i, sx, sy, sz);
						snowobj[i] = CreatePlayerObject(i, 18864, sx, sy, sz-5, 0.0, 0.0, 0.0, 300.0);
					}
				}
				format(string, sizeof(string), "{458B74}[NEWS]: {FF0000}��������� ������� �����! ���� ������ ����� �������!!", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
				nucexplos = 1;
				nucexptime = 0;
			}
			else
			{
				SetWeather(1);
				gettime(timedata[0], timedata[1]);
				SetWorldTime(timedata[0]);
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						SnowONOFF[i] = 0;
						DestroyPlayerObject(i,snowobj[i]);
					}
				}
				format(string, sizeof(string), "{458B74}[NEWS]:{FF0000} �������������� ����� ������ ", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_GREEN, string);
				nucexplos = 0;
				nucexptime = 0;
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 7 ��� (�����) --------------------------
//--------------------- ������� ������� 8 ��� (������) -------------------------
	if(strcmp(cmd, "/moneyall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /moneyall [�����] [�������]");
				return 1;
			}
			new money;
			money = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			new dopper44;
			if(money < 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							if(money > 1000) { dopper44 = GetPlayerMoney(i); }
							SetPVarInt(i, "MonControl", 1);
							GivePlayerMoney(i, money);
							if(money > 1000)
							{
								printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[i], i, dopper44);
							}
						}
					}
				}
				format(string, 256, " ������������� %s ����� � ���� ������� �� %d $ , �������: %s", RealName[playerid], money, result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				new para22 = 0;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							para22++;
						}
					}
				}
				para22 = para22 * money;
				new twenlim, restlim;
				if(Fmadmins(2, RealName[playerid], para22, twenlim, restlim) == 1)
				{
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
						if(IsPlayerConnected(i))
						{
							if(gPlayerLogged[i] == 1)
							{
								if(money > 1000) { dopper44 = GetPlayerMoney(i); }
								SetPVarInt(i, "MonControl", 1);
								GivePlayerMoney(i, money);
								if(money > 1000)
								{
									printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[i], i, dopper44);
								}
							}
						}
					}
					format(string, 256, " ������������� %s ������ ���� ������� �� %d $ , �������: %s", RealName[playerid], money, result);
					print(string);
					SendClientMessageToAll(COLOR_YELLOW, string);
					printf(" ������������� %s >> �������� �������� �����: [%d] ������� ��������� ������: [%d]", RealName[playerid],
					twenlim, restlim);
				}
				else
				{
					if(restlim == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ������ ! �� ������������� �������� �������� ����� !");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, " ������ ! � ��� ������������� ������� ��������� ������ !");
					}
				}
				if(twenlim != 0)
				{
					format(string, 256, " �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_RED, string);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setmonall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setmonall [�����]");
				return 1;
			}
			new money;
			money = strval(tmp);
			if(money < 0) { SendClientMessage(playerid, COLOR_RED, " ����� �� ����� ���� ������������� ������ !"); return 1; }
			new para22 = 0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						para22++;
					}
				}
			}
			para22 = para22 * money;
			new twenlim, restlim;
			if(Fmadmins(2, RealName[playerid], para22, twenlim, restlim) == 1)
			{
				new dopper44;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(gPlayerLogged[i] == 1)
						{
							if(money > 1000) { dopper44 = GetPlayerMoney(i); }
							SetPVarInt(i, "MonControl", 1);
							ResetPlayerMoney(i);
							GivePlayerMoney(i, money);
							if(money > 1000)
							{
								printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[i], i, dopper44);
							}
						}
					}
				}
				format(string, 256, " ������������� %s ��������� ���� ������� �� %d $", RealName[playerid], money);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
				printf(" ������������� %s >> �������� �������� �����: [%d] ������� ��������� ������: [%d]", RealName[playerid],
				twenlim, restlim);
			}
			else
			{
				if(restlim == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ������ ! �� ������������� �������� �������� ����� !");
				}
				else
				{
					SendClientMessage(playerid, COLOR_RED, " ������ ! � ��� ������������� ������� ��������� ������ !");
				}
			}
			if(twenlim != 0)
			{
				format(string, 256, " �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
				SendClientMessage(playerid, COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/fmess", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 8)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /fmess [����(0-19)] [���������] , ��� /fmess 600");
				return 1;
			}
			new color;
			color = strval(tmp);
			if(color < 0 || (color > 19 && color < 600) || color > 600)
			{
				SendClientMessage(playerid, COLOR_RED, " ����(0-19) , ��� 600 !");
				return 1;
			}
			if(color == 600)
			{
				format(strdln, sizeof(strdln), "{A9C4E4}0 - {FF0000}�������\
				\n{A9C4E4}1 - {FF3F3F}������-�������\
				\n{A9C4E4}2 - {FF3F00}���������\
				\n{A9C4E4}3 - {BF3F00}����������");
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}4 - {FF7F3F}������-����������\
				\n{A9C4E4}5 - {FF7F00}���������\
				\n{A9C4E4}6 - {FFFF00}Ƹ����\
				\n{A9C4E4}7 - {3FFF3F}������-������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}8 - {00FF00}������\
				\n{A9C4E4}9 - {00BF00}Ҹ���-������\
				\n{A9C4E4}10 - {00FFFF}���������\
				\n{A9C4E4}11 - {00BFFF}�������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}12 - {3F3FFF}������-�����\
				\n{A9C4E4}13 - {0000FF}�����\
				\n{A9C4E4}14 - {7F3FFF}������-����������\
				\n{A9C4E4}15 - {7F00FF}����������", strdln);
				format(strdln, sizeof(strdln), "%s\n{A9C4E4}16 - {FF00FF}���������\
				\n{A9C4E4}17 - {7F7F7F}�����\
				\n{A9C4E4}18 - {FFFFFF}�����\
				\n{A9C4E4}19 - {333333}׸����", strdln);
				ShowPlayerDialog(playerid, 2, 0, "����:", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new idx22 = idx;
			new result[256];
			while ((idx22 < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				if (cmdtext[idx22] == 123 && cmdtext[idx22 + 1] == 44)
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
					idx22++;
				}
				else
				{
					result[idx - offset] = cmdtext[idx22];
					idx++;
					idx22++;
				}
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� �������� ��������� !");
				return 1;
			}
			format(string, sizeof(string), "(/fmess) ����� %s [%d]: %s", RealName[playerid], playerid, result);
			print(string);
			switch(color)
			{
				case 0: format(string, sizeof(string), "{FF0000}%s", result);
				case 1: format(string, sizeof(string), "{FF3F3F}%s", result);
				case 2: format(string, sizeof(string), "{FF3F00}%s", result);
				case 3: format(string, sizeof(string), "{BF3F00}%s", result);
				case 4: format(string, sizeof(string), "{FF7F3F}%s", result);
				case 5: format(string, sizeof(string), "{FF7F00}%s", result);
				case 6: format(string, sizeof(string), "{FFFF00}%s", result);
				case 7: format(string, sizeof(string), "{3FFF3F}%s", result);
				case 8: format(string, sizeof(string), "{00FF00}%s", result);
				case 9: format(string, sizeof(string), "{00BF00}%s", result);
				case 10: format(string, sizeof(string), "{00FFFF}%s", result);
				case 11: format(string, sizeof(string), "{00BFFF}%s", result);
				case 12: format(string, sizeof(string), "{3F3FFF}%s", result);
				case 13: format(string, sizeof(string), "{0000FF}%s", result);
				case 14: format(string, sizeof(string), "{7F3FFF}%s", result);
				case 15: format(string, sizeof(string), "{7F00FF}%s", result);
				case 16: format(string, sizeof(string), "{FF00FF}%s", result);
				case 17: format(string, sizeof(string), "{7F7F7F}%s", result);
				case 18: format(string, sizeof(string), "{FFFFFF}%s", result);
				case 19: format(string, sizeof(string), "{333333}%s", result);
			}
			SendClientMessageToAll(COLOR_WHITE, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/playtpall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 8)
		{
			if(admper1[playerid] != 600)
			{
				SendClientMessage(playerid, COLOR_RED, " � ������ ���������� ��� ������� �� �������� !");
				return 1;
			}
			new dopper1 = 0;
			new Float:PosX, Float:PosY, Float:PosZ;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(playspa[i] == 1 && (PlayerInfo[i][pAdmin] >= 0 && PlayerInfo[i][pAdmin] <= 12) && i != playerid)
					{
						if(PlayerInfo[i][pPrisonsec] == 0)//���� ����� (��� �����) �� � ������, ��:
						{
							dopper1 = 1;
							if(PlayLock1[0][i] != 600)//���� ����� ������������, ��:
							{
								PlayLock1[1][i] = GetPlayerInterior(playerid);//��������� ��������� ����������
								PlayLock1[2][i] = GetPlayerVirtualWorld(playerid);//��������� ������������ ���� ����������
								GetPlayerPos(playerid, PlayLock2[0][i], PlayLock2[1][i], PlayLock2[2][i]);//��������� ��������� ����������
								PlayLock2[1][i] = PlayLock2[1][i] + 1;
							}
							else
							{
								if(admper1[i] != 600)//���� ����� � ����������, ��:
								{
									TogglePlayerSpectating(i, 0);//��������� ���������� ��� ������
									admper6[i] = 0;//�������� ������� � ������������ ����������
									SetTimerEx("DopPlaytp", 1000, 0, "ii", playerid, i);
								}
								else
								{
			 						SetPlayerInterior(i, GetPlayerInterior(playerid));
									SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
			   						GetPlayerPos(playerid, PosX, PosY, PosZ);
									SetPlayerPos(i, PosX, PosY+1, PosZ+1);
								}
							}
						}
						if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pPrisonsec] > 0)//���� ����� � ������, ��:
						{
							dopper1 = 1;
							PlayerInfo[i][pPrison]--;
							PlayerInfo[i][pPrisonsec] = 0;
							SpawnPlayer(i);//������� ������
							SendClientMessage(i, COLOR_GREEN, "* �������� ( �� ������� /playtpall )");
							SetTimerEx("DopAdmtp", 1000, 0, "ii", playerid, i);
						}
					}
				}
			}
            if(dopper1 == 1)
            {
				format(string,256," ������������� %s �������������� ���� ������� � ����.", RealName[playerid]);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ��� ��������� ������� (��� �������) ��� �� � ���� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 8 ��� (�����) --------------------------
//--------------------- ������� ������� 9 ��� (������) -------------------------
	if(strcmp(cmd, "/score", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /score [�� ������/����� ����] [����] [�������]");
				return 1;
			}
			new playa;
			new score;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ���� � ������� !");
				return 1;
			}
			score = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				new locper;
				locper = GetPlayerScore(playa);
				new dopper44;
				dopper44 = locper;
				locper = locper + score;
				SetPVarInt(playa, "ScorControl", 1);
				SetPlayerScore(playa, locper);
				if(score < 0)
				{
					format(string, 256, " ������������� %s ����� � ������ %s %d ����� , �������: %s", RealName[playerid], RealName[playa],
					score, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_RED, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_RED, string);
					}
				}
				else
				{
					format(string, 256, " ������������� %s ��� ������ %s %d ����� , �������: %s", RealName[playerid], RealName[playa],
					score, result);
					print(string);
					if (PlayerInfo[playa][pAdmin] >= 1)
					{
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						SendClientMessageToAll(COLOR_YELLOW, string);
					}
				}
				printf("[moneysys] ���������� ���� ������ %s [%d] : %d .", RealName[playa], playa, dopper44);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setscor", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setscor [�� ������/����� ����] [����]");
				return 1;
			}
			new playa;
			new score;
			playa = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������� ���� !");
				return 1;
			}
			score = strval(tmp);
   			if(IsPlayerConnected(playa))
		    {
				if(gPlayerLogged[playa] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(score < 0) { SendClientMessage(playerid, COLOR_RED, " ���� �� ����� ���� ������������� ������ !"); return 1; }
				new dopper44;
				dopper44 = GetPlayerScore(playa);
				SetPVarInt(playa, "ScorControl", 1);
				SetPlayerScore(playa, score);
				format(string, 256, " ������������� %s ��������� ������ %s %d �����", RealName[playerid], RealName[playa], score);
				print(string);
				if (PlayerInfo[playa][pAdmin] >= 1)
				{
					SendAdminMessage(COLOR_YELLOW, string);
				}
				else
				{
					SendClientMessageToAll(COLOR_YELLOW, string);
				}
				printf("[moneysys] ���������� ���� ������ %s [%d] : %d .", RealName[playa], playa, dopper44);
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/grav", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /grav [����������(0.0001-1)]");
				return 1;
			}
			new dopper, dopper22, dopper33, testgra, Float:flgra;
			dopper = strlen(tmp);
			if (dopper < 1 || dopper > 8)
			{
				SendClientMessage(playerid, COLOR_RED, " ����������: �� 0.0001 �� 1 !");
				return 1;
			}
			dopper22 = 0;
			dopper33 = 0;
			for(new i = 0; i < dopper; i++)
			{
				if(tmp[i] < 46 || tmp[i] == 47 || tmp[i] > 57)
				{
					dopper22 = 1;
				}
				if(tmp[i] == 46)
				{
					dopper33++;
				}
			}
			if (dopper22 == 1 || dopper33 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ����������: �� 0.0001 �� 1 !");
				return 1;
			}
			flgra = floatstr(tmp);
			testgra = 0;
			testgra = floatcmp(0.000100, flgra);
			if(testgra == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ����������: �� 0.0001 �� 1 !");
				return 1;
			}
			testgra = 0;
			testgra = floatcmp(flgra, 1.000000);
			if(testgra == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ����������: �� 0.0001 �� 1 !");
				return 1;
			}
			SetGravity(flgra);
			format(string, sizeof(string), " ������������� %s ��������� ���������� �� %f", RealName[playerid], flgra);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/gm", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 9)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /gm [�� ������/����� ����] [0-������ ���������");
				SendClientMessage(playerid, COLOR_GRAD2, " ����������, 1-���� ��������� ����������]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
			if(IsPlayerConnected(para1))
			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if(PlayerInfo[para1][pAdmin] >= 7)
				{
					SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ���������� ������ 7 ������ � ���� !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [0-������ ��������� ����������, 1-���� ��������� ����������] !");
					return 1;
				}
				new stat;
				stat = strval(tmp);
				if(stat < 0 || stat > 1)
				{
	 				SendClientMessage(playerid, COLOR_RED, " 0-������ ��������� ����������, 1-���� ��������� ���������� !");
					return 1;
				}
				if(stat == 0 && PlayerInfo[para1][pAdmlive] == 0)
				{
	 				SendClientMessage(playerid, COLOR_RED, " � ���������� ������ ��� ��� ���������� !");
					return 1;
				}
				if(stat == 1 && PlayerInfo[para1][pAdmlive] == 1)
				{
	 				SendClientMessage(playerid, COLOR_RED, " � ���������� ������ ��� ���� ���������� !");
					return 1;
				}
				PlayerInfo[para1][pAdmlive] = stat;
				if(PlayerInfo[para1][pAdmlive] == 1)
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s ��������� ����������.", RealName[playerid],
					RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_GREEN, string);
					if(PlayerInfo[para1][pAdmin] == 0)
					{
						format(string, sizeof(string), " ������������� %s ��� ��� ��������� ����������.", RealName[playerid]);
						SendClientMessage(para1, COLOR_GREEN, string);
					}
				}
				else
				{
					format(string, sizeof(string), " ������������� %s ����� � ������ %s ��������� ����������.", RealName[playerid],
					RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					if(PlayerInfo[para1][pAdmin] == 0)
					{
						format(string, sizeof(string), " ������������� %s ����� � ��� ��������� ����������.", RealName[playerid]);
						SendClientMessage(para1, COLOR_RED, string);
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//--------------------- ������� ������� 9 ��� (�����) --------------------------
//-------------------- ������� ������� 10 ��� (������) -------------------------
	if(strcmp(cmd, "/scoreall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /scoreall [����] [�������]");
				return 1;
			}
			new score;
			score = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[128];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			new locper;
			new dopper44;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						locper = GetPlayerScore(i);
						if(score > 10) { dopper44 = locper; }
						locper = locper + score;
						SetPVarInt(i, "ScorControl", 1);
						SetPlayerScore(i, locper);
						if(score > 10)
						{
							printf("[moneysys] ���������� ���� ������ %s [%d] : %d .", RealName[i], i, dopper44);
						}
					}
				}
			}
			if(score < 0)
			{
				format(string, 256, " ������������� %s ����� � ���� ������� �� %d ����� , �������: %s", RealName[playerid], score, result);
				print(string);
				SendClientMessageToAll(COLOR_RED, string);
			}
			else
			{
				format(string, 256, " ������������� %s ������ ���� ������� �� %d ����� , �������: %s", RealName[playerid], score, result);
				print(string);
				SendClientMessageToAll(COLOR_YELLOW, string);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/setscorall", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setscorall [����]");
				return 1;
			}
			new score;
			score = strval(tmp);
			if(score < 0) { SendClientMessage(playerid, COLOR_RED, " ���� �� ����� ���� ������������� ������ !"); return 1; }
			new dopper44;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerLogged[i] == 1)
					{
						if(score > 10) { dopper44 = GetPlayerScore(i); }
						SetPVarInt(i, "ScorControl", 1);
						SetPlayerScore(i, score);
						if(score > 10)
						{
							printf("[moneysys] ���������� ���� ������ %s [%d] : %d .", RealName[i], i, dopper44);
						}
					}
				}
			}
			format(string, 256, " ������������� %s ��������� ���� ������� �� %d �����", RealName[playerid], score);
			print(string);
			SendClientMessageToAll(COLOR_YELLOW, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/radpl", true) == 0)
    {
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " �����������: /radpl [�� ������] [�����(1-12)]");
				SendClientMessage(playerid, COLOR_GREY, " ��� /radpl 600");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - %s\n2 - %s\n3 - %s\n4 - %s\n5 - %s\n6 - %s\n7 - %s\n8 - %s\
				\n9 - %s\n10 - %s\n11 - %s\n12 - %s", NMRadio[1], NMRadio[2], NMRadio[3], NMRadio[4],
				NMRadio[5], NMRadio[6], NMRadio[7], NMRadio[8], NMRadio[9], NMRadio[10], NMRadio[11], NMRadio[12]);
				ShowPlayerDialog(playerid, 2, 0, "������ �����", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(!IsPlayerConnected(para1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
				return 1;
			}
			if(para1 == playerid)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� �������� ����� ������ ����, ����������� ���� ������� !");
				return 1;
			}
			if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[para1][pAdmin] >= 12)
			{
				SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ����� ������ 12-�� ������ !");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " �����(1-12) !");
				return 1;
			}
			new para2 = strval(tmp);
			if(para2 < 1 || para2 > 12)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ����� ��� !");
				return 1;
			}
			NRadio[para1] = para2;//����� ������������� �����
			StopAudioStreamForPlayer(para1);//�������� ����� ������ �����
			PlayAudioStreamForPlayer(para1, STRadio[para2]);//��������� ����� � �������
			format(string, sizeof(string), " ������������� %s ������� ��� ����� %s", RealName[playerid], NMRadio[para2]);
			SendClientMessage(para1, COLOR_GREEN, string);
			SendClientMessage(para1, COLOR_GREEN, " ��� ���������� �����������: {A9C4E4}������� ���� --> {91EF03}����� --> {027FFE}��������� �����");
			format(string, sizeof(string), " *** A���� %s ������� ������ %s ����� %s", RealName[playerid], RealName[para1], NMRadio[para2]);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
 					if(PlayerInfo[i][pAdmin] >= 1 && i != para1)
   					{
						SendClientMessage(i, COLOR_GREEN, string);
					}
				}
			}
			printf("[radio] A���� %s ������� ������ %s ����� %s .", RealName[playerid], RealName[para1], NMRadio[para2]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
	    return 1;
    }
	if(strcmp(cmd, "/radall", true) == 0)
    {
		if(PlayerInfo[playerid][pAdmin] >= 10)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GREY, " �����������: /radall [�����(1-12)]");
				SendClientMessage(playerid, COLOR_GREY, " ��� /radall 600");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 == 600)
			{
				format(strdln, sizeof(strdln), "1 - %s\n2 - %s\n3 - %s\n4 - %s\n5 - %s\n6 - %s\n7 - %s\n8 - %s\
				\n9 - %s\n10 - %s\n11 - %s\n12 - %s", NMRadio[1], NMRadio[2], NMRadio[3], NMRadio[4],
				NMRadio[5], NMRadio[6], NMRadio[7], NMRadio[8], NMRadio[9], NMRadio[10], NMRadio[11], NMRadio[12]);
				ShowPlayerDialog(playerid, 2, 0, "������ �����", strdln, "OK", "");
				dlgcont[playerid] = 2;
				return 1;
			}
			if(para1 < 1 || (para1 > 12 && para1 != 600))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ ����� ��� !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if((PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[i][pAdmin] <= 11) || PlayerInfo[playerid][pAdmin] >= 12)
					{
						NRadio[i] = para1;//����� ������������� �����
						StopAudioStreamForPlayer(i);//�������� ����� ������ �����
						PlayAudioStreamForPlayer(i, STRadio[para1]);//��������� ����� � �������
						format(string, sizeof(string), " ������������� %s ������� ���� ����� %s", RealName[playerid], NMRadio[para1]);
						SendClientMessage(i, COLOR_GREEN, string);
						SendClientMessage(i, COLOR_GREEN, " ��� ���������� �����������: {A9C4E4}������� ���� --> {91EF03}����� --> {027FFE}��������� �����");
					}
					if(PlayerInfo[playerid][pAdmin] <= 11 && PlayerInfo[i][pAdmin] >= 12)
					{
						format(string, sizeof(string), " ������������� %s ������� ���� ����� %s", RealName[playerid], NMRadio[para1]);
						SendClientMessage(i, COLOR_GREEN, string);
					}
				}
			}
			printf("[radio] A���� %s ������� ���� ����� %s .", RealName[playerid], NMRadio[para1]);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
	    return 1;
    }
//-------------------- ������� ������� 10 ��� (�����) --------------------------
//-------------------- ������� ������� 11 ��� (������) -------------------------
	if(strcmp(cmd, "/dataakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 11)
    	{
   			new data44[18], Float:data4444[12], FracTxt44[2][64];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /dataakk [��� ��������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new file, locper22[64];//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "TDReg", tdreg);
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "MinLog", data44[0]);
				ini_getInteger(file, "AdminLevel", data44[1]);
				ini_getInteger(file, "AdminShadow", data44[2]);
				ini_getInteger(file, "AdminLive", data44[3]);
				ini_getInteger(file, "Prison", data44[5]);
				ini_getInteger(file, "Prisonsec", data44[6]);
				ini_getInteger(file, "Muted", data44[7]);
				ini_getInteger(file, "Mutedsec", data44[8]);
				ini_getInteger(file, "Money", data44[9]);
				ini_getInteger(file, "Score", data44[10]);
				ini_getInteger(file, "Kills", data44[11]);
				ini_getInteger(file, "Deaths", data44[12]);
				ini_getInteger(file, "Lock", data44[13]);
				ini_getFloat(file, "Cord_X", data4444[0]);
				ini_getFloat(file, "Cord_Y", data4444[1]);
				ini_getFloat(file, "Cord_Z", data4444[2]);
				ini_getFloat(file, "Angle", data4444[3]);
				ini_getInteger(file, "Frac1", data44[14]);
				ini_getInteger(file, "FracLvl1", data44[15]);
				ini_getFloat(file, "FracCord_X1", data4444[4]);
				ini_getFloat(file, "FracCord_Y1", data4444[5]);
				ini_getFloat(file, "FracCord_Z1", data4444[6]);
				ini_getFloat(file, "FracAngle1", data4444[7]);
				ini_getString(file, "FracTxt1", locper22);
				strmid(FracTxt44[0], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac2", data44[16]);
				ini_getInteger(file, "FracLvl2", data44[17]);
				ini_getFloat(file, "FracCord_X2", data4444[8]);
				ini_getFloat(file, "FracCord_Y2", data4444[9]);
				ini_getFloat(file, "FracCord_Z2", data4444[10]);
				ini_getFloat(file, "FracAngle2", data4444[11]);
				ini_getString(file, "FracTxt2", locper22);
				strmid(FracTxt44[1], locper22, 0, strlen(locper22), 64);
				ini_closeFile(file);
			}
			new fadm;
			if(data44[1] < 0)
			{
				fadm = data44[1] * -1;
			}
			else
			{
				fadm = data44[1];
			}
			if(fadm >= 12 && PlayerInfo[playerid][pAdmin] <= 11)//�������� �������� �� ������� 12-�� ���
			{
				format(ssss,sizeof(ssss)," ������, ������� ������ [%s] - ����� %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			new dopdata44;
			dopdata44 = 0;
			for(new i=0;i<MAX_PLAYERS;i++)//�������� �������� �� On-Line
			{
	   			if(IsPlayerConnected(i))
			    {
					if(strcmp(akk, RealName[i], false) == 0) { dopdata44 = 1; }
				}
			}
			new dopdata2;
			if(data44[14] == -600)
			{
				dopdata2 = 0;
			}
			else
			{
				dopdata2 = data44[14];
			}
			printf(" ������������� %s [%d] ���������� ������� ������ %s . ��� ������ !", RealName[playerid], playerid, akk);

			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
			format(ssss, sizeof(ssss), "           *** ������� ������ [%s] *** ( ��� ������ ! )", akk);
			SendClientMessage(playerid, COLOR_WHITE, ssss);
			if(dopdata44 == 1)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, " �������� !!! ������� ������ On-Line !");
			}
			format(ssss, sizeof(ssss), " ����� � ���� �����������: [ %s ]", tdreg);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " ����������: X = %f Y = %f Z = %f ����: %f",
			data4444[0], data4444[1], data4444[2], data4444[3]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " IP: [%s] ����� LVL: [%d] ��������� ������: [%d]",
			adrip, fadm, data44[2]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " ������� � ������: [%d] ������ ������: [%d] ����� �������: [%d] ������ ������: [%d]",
			data44[5], data44[6], data44[7], data44[8]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " �����: [%d $] �����: [%d] �������: [%d] �������: [%d] ���������� ��������: [%d]",
			data44[9], data44[10], data44[11], data44[12], data44[13]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " ����� �� �������: [%d] ����������: [%d]", data44[0], data44[3]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			if(fadm >= 7)
			{
				new twenlim, restlim;
				Fmadmins(2, akk, 0, twenlim, restlim);
				format(ssss,sizeof(ssss)," �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
			}
			format(ssss, sizeof(ssss), " ID �����: [%d] ������� � �����: [%d]", dopdata2, data44[15]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
/*
			format(ssss, sizeof(ssss), " ID �������-2: [%d] ������� �� �������-2: [%d] ����� �������-2: [ %s ]",
			data44[16], data44[17], FracTxt44[1]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
			format(ssss, sizeof(ssss), " ���������� �������-2: X = %f Y = %f Z = %f ���� �������-2: %f",
			data4444[8], data4444[9], data4444[10], data4444[11]);
			SendClientMessage(playerid, COLOR_GRAD1, ssss);
*/
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");

			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/unbanakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 11)
    	{
   			new data2[3];
			data2[2] = 0;//���������� �������� ���������� ��������
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /unbanakk [��� ��������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new file;//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "AdminLevel", data2[0]);
				ini_getInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
				if(IsPlayerConnected(i))
				{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������ � ����� ��������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new fadm;
			if(data2[0] < 0)
			{
				fadm = data2[0] * -1;
			}
			else
			{
				fadm = data2[0];
			}
			if(fadm >= 1 && PlayerInfo[playerid][pAdmin] <= 11)//�������� �������� �� �������
			{
				format(ssss,sizeof(ssss)," ������, ������� ������ [%s] - ����� %d LVL !", akk, fadm);
				SendClientMessage(playerid, COLOR_RED, ssss);
				return 1;
			}
			if(data2[1] == 0)//���� ������� �� ��� ������������, ��:
			{
				data2[2] = 1;//���������� � ���������� �������� ���������� �������� 1
			}
			data2[1] = 0;//����� ���������� ��������
			strdel(ssss, 0, 256);//������ RCON-������� �������
			strcat(ssss, "unbanip ");
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-������� �������
			SendRconCommand("reloadbans");//RCON-������� ������������ ���-�����
			file = ini_openFile(string);//������ ���������� ��������
			if(file >= 0)
			{
				ini_setInteger(file, "Lock", data2[1]);
				ini_closeFile(file);
			}
			if(data2[2] == 1)//���� ���������� �������� ���������� �������� = 1, ��:
			{
				format(ssss,sizeof(ssss)," ������� ������ [%s] �� ������������ (�� �������) !", akk);
				print(ssss);
				SendClientMessage(playerid, COLOR_RED, ssss);
				format(ssss,sizeof(ssss)," ( IP: [%s] ��� ����� �� ����� samp.ban ) !", adrip);
				print(ssss);
				SendClientMessage(playerid, COLOR_GREEN, ssss);
			}
			else//�����:
			{
				format(ssss,sizeof(ssss)," ������������� %s �������� ������� ������ [%s] ( IP: [%s] ) .", RealName[playerid], akk, adrip);
				print(ssss);
				SendAdminMessage(COLOR_GREEN, ssss);
				format(ssss,sizeof(ssss)," ������������� %s �������� ������� ������ [%s] .", RealName[playerid], akk);
				for(new i=0;i<MAX_PLAYERS;i++)//�������� ��������� �� �������
				{
					if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
					{
						SendClientMessage(i, COLOR_GREEN, ssss);
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/shad", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /shad [�� ������/����� ����] [0-������ ���������, 1-������]");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				if (PlayerInfo[para1][pAdmin] != 0)
				{
					if (PlayerInfo[para1][pAdmin] >= 12 && PlayerInfo[playerid][pAdmin] <= 11)
					{
						SendClientMessage(playerid, COLOR_RED, " �� �� ������ �������� ��������� ������ 12 ������ !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
					if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [0-������ ���������, 1-������] !");
						return 1;
					}
					new stat;
					stat = strval(tmp);
					if(stat < 0 || stat > 1)
					{
	 					SendClientMessage(playerid, COLOR_RED, " 0-������ ���������, 1-������ !");
						return 1;
					}
					if(stat == 0 && PlayerInfo[para1][pAdmshad] == 0)
					{
	 					SendClientMessage(playerid, COLOR_RED, " � ���������� ������ ��� ��� ��������� !");
						return 1;
					}
					if(stat == 1 && PlayerInfo[para1][pAdmshad] == 1)
					{
	 					SendClientMessage(playerid, COLOR_RED, " � ���������� ������ ��� ���� ��������� !");
						return 1;
					}
					PlayerInfo[para1][pAdmshad] = stat;
					if(PlayerInfo[para1][pAdmshad] == 1)
					{
						format(string, sizeof(string), " ������������� %s ��� ������ %s ������ ���������.", RealName[playerid],
						RealName[para1]);
						print(string);
						SendAdminMessage(COLOR_YELLOW, string);
					}
					else
					{
						format(string, sizeof(string), " ������������� %s ����� � ������ %s ������ ���������.", RealName[playerid],
						RealName[para1]);
						print(string);
						SendAdminMessage(COLOR_RED, string);
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� - �� ����� !");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
	if(strcmp(cmd, "/deltr", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
			new model, cnt;
			cnt = 0;
			for(new i = 1; i < 10001; i++)
			{
				model = GetVehicleModel(i);
				if(model == 537 || model == 538 || model == 569 || model == 570)
				{
					DestroyVehicle(i);
					cnt++;
				}
			}
			if(cnt != 0)
			{
				format(string, sizeof(string), " ���� ���������� %d ��������� ������ ������� ��� ������� !", cnt);
				SendClientMessage(playerid, COLOR_GREY, string);
			}
			else
			{
				SendClientMessage(playerid, COLOR_GREY, " ��������� ������� ��� ������� �� ���� ������� !");
			}
			format(string, sizeof(string), " ������������� %s ��������� %d ��������� ������ ������� ��� �������.",
			RealName[playerid], cnt);
			print(string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/ipban", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 11)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /ipban [IP-�����]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� IP-������ ������ ���� �� 7 �� 15 �������� !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//������� ��������� ����� ������� ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//���������� IP-������
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   IP-����� �� ����� ���������� � ������� !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
			new ind3 = 1;//�������� �������������� "*" � ������ �� ����� ����,
			new ind4 = 0;//� �������� ������ ������ ���� �� ����������� ���������� �����
			new ind5 = 0;
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' ||
					ipper[playerid][ind3][2] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
					if(strval(ipper[playerid][ind3]) > 255) {ind5 = 1;}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
    		if(ind5 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			new dopper33[256];//��� IP-������
			strdel(dopper33, 0, 256);
			strcat(dopper33, "banip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " ������������� %s ������� IP �����: [%s]", RealName[playerid], tmp);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/ipunban", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 7)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /ipunban [IP-�����]");
				return 1;
			}
			new dltmp;
			dltmp = strlen(tmp);
			if(dltmp < 7 || dltmp > 15)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� IP-������ ������ ���� �� 7 �� 15 �������� !");
				return 1;
			}
			new dopper111 = 0;
			new dopper222 = 0;
			for(new i = 0; i < dltmp; i++)
			{
				if((tmp[i] < 48 || tmp[i] > 57) && tmp[i] != '.' && tmp[i] != '*') {dopper111 = 1;}
				if(tmp[i] == '.') {dopper222++;}
			}
			if(dopper111 == 1 || dopper222 != 3)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			for(new i = 0; i < 4; i++)//������� ��������� ����� ������� ipper
			{
				for(new j = 0; j < 32; j++)
				{
					ipper[playerid][i][j] = 0;
				}
			}
			new ind1, ind2;//���������� IP-������
			ind1 = -1;
			for(new i = 0; i < 4; i++)
			{
				ind1++;
				ind2 = 0;
				while(tmp[ind1] != '.')
				{
					if(ind1 > dltmp)
					{
						break;
					}
					ipper[playerid][i][ind2] = tmp[ind1];
					ind1++;
					ind2++;
				}
			}
			dopper111 = 0;
			for(new i = 0; i < 4; i++)
			{
				if(strlen(ipper[playerid][i]) < 1 || strlen(ipper[playerid][i]) > 3) {dopper111 = 1;}
			}
    		if(dopper111 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if(strfind(ipper[playerid][0], "*", true) != -1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   IP-����� �� ����� ���������� � ������� !");
				return 1;
			}
    		if(strval(ipper[playerid][0]) > 255)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
    		if((strfind(ipper[playerid][1], "*", true) == -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) == -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) == -1 &&
			strfind(ipper[playerid][3], "*", true) != -1) ||
			(strfind(ipper[playerid][1], "*", true) != -1 && strfind(ipper[playerid][2], "*", true) != -1 &&
			strfind(ipper[playerid][3], "*", true) == -1))
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
			new ind3 = 1;//�������� �������������� "*" � ������ �� ����� ����,
			new ind4 = 0;//� �������� ������ ������ ���� �� ����������� ���������� �����
			new ind5 = 0;
			while(ind3 < 4)
			{
				if(strlen(ipper[playerid][ind3]) == 2)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
				}
				if(strlen(ipper[playerid][ind3]) == 3)
				{
					if(ipper[playerid][ind3][0] == '*' || ipper[playerid][ind3][1] == '*' ||
					ipper[playerid][ind3][2] == '*') {ind4 = 1;}
					if(ipper[playerid][ind3][0] == '0') {ind5 = 1;}
					if(strval(ipper[playerid][ind3]) > 255) {ind5 = 1;}
				}
				ind3++;
			}
    		if(ind4 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ !!!   ������ ������ �� ����� !");
				return 1;
			}
    		if(ind5 == 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ������ � ��������� IP-������ !");
				return 1;
			}
			new dopper33[256];//��� IP-������
			strdel(dopper33, 0, 256);
			strcat(dopper33, "unbanip ");
			strcat(dopper33, tmp);
			SendRconCommand(dopper33);
			SendRconCommand("reloadbans");
			format(string, sizeof(string), " ������������� %s �������� IP �����: [%s]", RealName[playerid], tmp);
			print(string);
			SendClientMessageToAll(COLOR_GREEN, string);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
//-------------------- ������� ������� 11 ��� (�����) --------------------------
//----------------- ������� ������� 12 � 13 ��� (������) -----------------------
	if(strcmp(cmd, "/admakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
   			new data2[26], Float:data333[28], FracTxt[6][64];
			akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /admakk [��� ��������] [�����(0-12)] ( �������������:");
				SendClientMessage(playerid, COLOR_GRAD2, " [�����] [����] ),");
				SendClientMessage(playerid, COLOR_GRAD2, " ��� /admakk [��� ��������] 99 [������] - ������� ������,");
				SendClientMessage(playerid, COLOR_GRAD2, " ��� /admakk [��� ��������] 100 - ����������� �������");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			new entpass[64], level, oldlevel, summ1, summ2;
			new ochki1, ochki2, dopper;
			dopper = 0;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [�����(0-12), ��� 99, ��� 100] ( �������������: [�����] [����] ) !");
				return 1;
			}
			level = strval(tmp);
			if((level < 0 || level > 12) && level != 99 && level != 100)
			{
				SendClientMessage(playerid, COLOR_RED, " ������� ������ ������ ���� �� 0 �� 12 , (��� 99, ��� 100) !");
				return 1;
			}
			if(level == 99)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " /admakk [��� ��������] 99 [������] !");
					return 1;
				}
 				if(strlen(tmp) < 3 || strlen(tmp) > 20)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ������ ������ ���� �� 3 �� 20 �������� !");
					return 1;
				}
 				if(PassControl(tmp) == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " � ������ ����� ������������ ������ ���������");
					SendClientMessage(playerid, COLOR_RED, " �������: �� a �� z , �� A �� Z , � ����� �� 0 �� 9 !");
					return 1;
				}
				strdel(entpass, 0, 64);
				strcat(entpass, tmp);
			}
			else
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					summ1 = 0;
				}
				else
				{
					summ1 = 1;
					summ2 = strval(tmp);
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					ochki1 = 0;
				}
				else
				{
					ochki1 = 1;
					ochki2 = strval(tmp);
				}
			}
			new file, locper22[64];//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "Key", igkey);
				ini_getString(file, "TDReg", tdreg);
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "MinLog", data2[0]);
				ini_getInteger(file, "AdminLevel", data2[1]);
				ini_getInteger(file, "AdminShadow", data2[2]);
				ini_getInteger(file, "AdminLive", data2[3]);
				ini_getInteger(file, "Registered", data2[4]);
				ini_getInteger(file, "Prison", data2[5]);
				ini_getInteger(file, "Prisonsec", data2[6]);
				ini_getInteger(file, "Muted", data2[7]);
				ini_getInteger(file, "Mutedsec", data2[8]);
				ini_getInteger(file, "Money", data2[9]);
				ini_getInteger(file, "Score", data2[10]);
				ini_getInteger(file, "Kills", data2[11]);
				ini_getInteger(file, "Deaths", data2[12]);
				ini_getInteger(file, "Lock", data2[13]);
				ini_getFloat(file, "Cord_X", data333[0]);
				ini_getFloat(file, "Cord_Y", data333[1]);
				ini_getFloat(file, "Cord_Z", data333[2]);
				ini_getFloat(file, "Angle", data333[3]);
				ini_getInteger(file, "Frac1", data2[14]);
				ini_getInteger(file, "FracLvl1", data2[15]);
				ini_getFloat(file, "FracCord_X1", data333[4]);
				ini_getFloat(file, "FracCord_Y1", data333[5]);
				ini_getFloat(file, "FracCord_Z1", data333[6]);
				ini_getFloat(file, "FracAngle1", data333[7]);
				ini_getString(file, "FracTxt1", locper22);
				strmid(FracTxt[0], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac2", data2[16]);
				ini_getInteger(file, "FracLvl2", data2[17]);
				ini_getFloat(file, "FracCord_X2", data333[8]);
				ini_getFloat(file, "FracCord_Y2", data333[9]);
				ini_getFloat(file, "FracCord_Z2", data333[10]);
				ini_getFloat(file, "FracAngle2", data333[11]);
				ini_getString(file, "FracTxt2", locper22);
				strmid(FracTxt[1], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac3", data2[18]);
				ini_getInteger(file, "FracLvl3", data2[19]);
				ini_getFloat(file, "FracCord_X3", data333[12]);
				ini_getFloat(file, "FracCord_Y3", data333[13]);
				ini_getFloat(file, "FracCord_Z3", data333[14]);
				ini_getFloat(file, "FracAngle3", data333[15]);
				ini_getString(file, "FracTxt3", locper22);
				strmid(FracTxt[2], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac4", data2[20]);
				ini_getInteger(file, "FracLvl4", data2[21]);
				ini_getFloat(file, "FracCord_X4", data333[16]);
				ini_getFloat(file, "FracCord_Y4", data333[17]);
				ini_getFloat(file, "FracCord_Z4", data333[18]);
				ini_getFloat(file, "FracAngle4", data333[19]);
				ini_getString(file, "FracTxt4", locper22);
				strmid(FracTxt[3], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac5", data2[22]);
				ini_getInteger(file, "FracLvl5", data2[23]);
				ini_getFloat(file, "FracCord_X5", data333[20]);
				ini_getFloat(file, "FracCord_Y5", data333[21]);
				ini_getFloat(file, "FracCord_Z5", data333[22]);
				ini_getFloat(file, "FracAngle5", data333[23]);
				ini_getString(file, "FracTxt5", locper22);
				strmid(FracTxt[4], locper22, 0, strlen(locper22), 64);
				ini_getInteger(file, "Frac6", data2[24]);
				ini_getInteger(file, "FracLvl6", data2[25]);
				ini_getFloat(file, "FracCord_X6", data333[24]);
				ini_getFloat(file, "FracCord_Y6", data333[25]);
				ini_getFloat(file, "FracCord_Z6", data333[26]);
				ini_getFloat(file, "FracAngle6", data333[27]);
				ini_getString(file, "FracTxt6", locper22);
				strmid(FracTxt[5], locper22, 0, strlen(locper22), 64);
				ini_closeFile(file);
			}
			new fadm;
			if(data2[1] < 0)
			{
				fadm = data2[1] * -1;
			}
			else
			{
				fadm = data2[1];
			}
			if(level == 100)
			{
				new dopdata44;
				dopdata44 = 0;
				for(new i=0;i<MAX_PLAYERS;i++)//�������� �������� �� On-Line
				{
	   				if(IsPlayerConnected(i))
			    	{
						if(strcmp(akk, RealName[i], false) == 0) { dopdata44 = 1; }
					}
				}
				new dopdata2;
				if(data2[14] == -600)
				{
					dopdata2 = 0;
				}
				else
				{
					dopdata2 = data2[14];
				}
				printf(" ������������� %s [%d] ���������� ������� ������ %s .", RealName[playerid], playerid, akk);

				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
				format(ssss, sizeof(ssss), "           *** ������� ������ [%s] ***", akk);
				SendClientMessage(playerid, COLOR_WHITE, ssss);
				if(dopdata44 == 1)
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, " �������� !!! ������� ������ On-Line !");
				}
				format(ssss, sizeof(ssss), " ����� � ���� �����������: [ %s ]", tdreg);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " ����������: X = %f Y = %f Z = %f ����: %f",
				data333[0], data333[1], data333[2], data333[3]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " ������: [%s] IP: [%s] ����� LVL: [%d] ��������� ������: [%d]",
				igkey, adrip, fadm, data2[2]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " ������� � ������: [%d] ������ ������: [%d] ����� �������: [%d] ������ ������: [%d]",
				data2[5], data2[6], data2[7], data2[8]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " �����: [%d $] �����: [%d] �������: [%d] �������: [%d] ���������� ��������: [%d]",
				data2[9], data2[10], data2[11], data2[12], data2[13]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " ����� �� �������: [%d] ����������: [%d]", data2[0], data2[3]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				if(fadm >= 7)
				{
					new twenlim, restlim;
					Fmadmins(2, akk, 0, twenlim, restlim);
					format(ssss,sizeof(ssss)," �������� �������� �����: [%d] ������� ��������� ������: [%d]", twenlim, restlim);
					SendClientMessage(playerid, COLOR_GRAD1, ssss);
				}
				format(ssss, sizeof(ssss), " ID �����: [%d] ������� � �����: [%d]", dopdata2, data2[15]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
/*
				format(ssss, sizeof(ssss), " ID �������-2: [%d] ������� �� �������-2: [%d] ����� �������-2: [ %s ]",
				data2[16], data2[17], FracTxt[1]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
				format(ssss, sizeof(ssss), " ���������� �������-2: X = %f Y = %f Z = %f ���� �������-2: %f",
				data333[8], data333[9], data333[10], data333[11]);
				SendClientMessage(playerid, COLOR_GRAD1, ssss);
*/
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");

				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			if(level == 99)
			{
				if(strcmp(igkey, entpass, false) == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ������� ������ ������� ��� ��������� !");
					return 1;
				}
				printf(" ������������� %s ������ ������ �������� ������ [%s] �� (%s) FP: (%s) .", RealName[playerid], akk, entpass, igkey);
				format(ssss, sizeof(ssss), " �� ������� ������ �������� ������ [%s] �� (%s) FP: (%s) .", akk, entpass, igkey);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, ssss);
				strdel(igkey, 0, 256);
				strcat(igkey, entpass);
			}
			else
			{
				if(level == fadm && (summ1 == 0 || summ2 == data2[9]) && (ochki1 == 0 || ochki2 == data2[10]))
				{
	 				SendClientMessage(playerid, COLOR_RED, " ������� ������ ������� ��� ��������� !");
					return 1;
				}
				if(level == 0 && level != fadm)
				{
					dopper = 1;
					data2[2] = 0;//������ ���������
					data2[3] = 0;//������ ����������
					data2[1] = level;//��������� ������ �������
					format(ssss, sizeof(ssss), " ������������� %s ���� ������� � �������� ������ [%s] .", RealName[playerid], akk);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					new twenlim, restlim;
					Fmadmins(0, akk, 0, twenlim, restlim);
				}
				if(level > 0 && level != fadm)
				{
					dopper = 1;
					oldlevel = fadm;//���������� ������� ������ �������
					data2[2] = 0;//������ ���������
					if(data2[1] <= 0)//��������� ������ �������
					{
						data2[1] = level * -1;
					}
					else
					{
						data2[1] = level;
					}
					format(ssss, sizeof(ssss), " ������������� %s ��� �������� ������ [%s] ������� %d ������.", RealName[playerid],
					akk, level);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					if(level <= 6 && oldlevel >= 7)
					{
						new twenlim, restlim;
						Fmadmins(0, akk, 0, twenlim, restlim);
					}
					if(level >= 7 && oldlevel <= 6)
					{
						new twenlim = 0;
						new restlim = 0;
						Fmadmins(1, akk, 0, twenlim, restlim);
					}
					if(level <= 6 && oldlevel >= 7)
					{
						data2[3] = 0;//��������� ����������
					}
					if(level >= 7 && oldlevel <= 6)
					{
						data2[3] = 1;//�������� ����������
					}
				}
				if(summ1 == 1 && summ2 != data2[9])
				{
					new dopper44;
					dopper44 = data2[9];
					dopper = 1;
					data2[9] = summ2;//��������� ������� �����
					format(ssss, sizeof(ssss), " *** ������ ���� �������� ������ [%s] ��� ������ ��: %d $ .", akk, data2[9]);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					printf("[moneysys] ���������� ����� �������� ������ %s : %d $", akk, dopper44);
				}
				if(ochki1 == 1 && ochki2 != data2[10])
				{
					dopper = 1;
					data2[10] = ochki2;//��������� ������� �����
					format(ssss, sizeof(ssss), " *** ���� �������� ������ [%s] ���� �������� ��: %d .", akk, data2[10]);
					print(ssss);
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
				}
				if(dopper == 0)
				{
	 				SendClientMessage(playerid, COLOR_RED, " ������� ������ ������� ��� ��������� !");
					return 1;
				}
			}
			file = ini_openFile(string);//������ ���������� ��������
			if(file >= 0)
			{
				ini_setString(file, "Key", igkey);
				ini_setInteger(file, "AdminLevel", data2[1]);
				ini_setInteger(file, "AdminShadow", data2[2]);
				ini_setInteger(file, "AdminLive", data2[3]);
				ini_setInteger(file, "Money", data2[9]);
				ini_setInteger(file, "Score", data2[10]);
				ini_closeFile(file);
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/delakk", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
			new data222[2];
    		akk = strtok(cmdtext, idx);
    		if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /delakk [��� ��������]");
				return 1;
			}
			if(strlen(akk) < 1 || strlen(akk) > 25)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
				return 1;
			}
			format(string, sizeof(string), "players/%s.ini", akk);
			if(!fexist(string))
			{
				SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
				return 1;
			}
			for(new i = 0; i < MAX_PLAYERS; i++)//�������� �������� �� On-Line
			{
   				if(IsPlayerConnected(i))
		    	{
					if(strcmp(akk, RealName[i], false) == 0)
					{
						format(ssss, sizeof(ssss), " ������, ������� ������ [%s] On-Line !", akk);
						SendClientMessage(playerid, COLOR_RED, ssss);
						return 1;
					}
				}
			}
			new file;//������ ��������
			file = ini_openFile(string);
			if(file >= 0)
			{
				ini_getString(file, "IPAdr", adrip);
				ini_getInteger(file, "Frac1", data222[0]);
				ini_getInteger(file, "FracLvl1", data222[1]);
				ini_closeFile(file);
			}
			if(fexist(string))
			{
				fremove(string);//������� �������
			}
			format(ssss,sizeof(ssss)," ������������� %s ������ ������� ������ [%s] .", RealName[playerid], akk);
			print(ssss);
			SendClientMessageToAll(COLOR_LIGHTBLUE, ssss);
			new twenlim, restlim;
			Fmadmins(0, akk, 0, twenlim, restlim);
			strdel(ssss, 0, 256);//������� ���������� ��� �������
			strcat(ssss, "unbanip ");//������ RCON-������� �������
			strcat(ssss, adrip);
			SendRconCommand(ssss);//RCON-������� �������
			SendRconCommand("reloadbans");//RCON-������� ������������ ���-�����
			format(ssss,sizeof(ssss)," ( IP: [%s] ��� ����� �� ����� samp.ban ) !", adrip);
			print(ssss);
			SendAdminMessage(COLOR_LIGHTBLUE, ssss);
			format(ssss,sizeof(ssss)," ( IP-����� ������ [%s] ��� ����� �� ����� samp.ban ) !", akk);
			for(new i=0;i<MAX_PLAYERS;i++)//�������� ��������� �� �������
			{
				if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] == 0)
				{
					SendClientMessage(i, COLOR_LIGHTBLUE, ssss);
				}
			}
			CallRemoteFunction("vehsys3delakkfunc", "ds", playerid, akk);//�������� ���������� �� ������� � ������� vehsys3
			if(data222[1] == 6)//���� ��������� ������� - ����� �����, ��:
			{
				format(string, sizeof(string), "gangs/%d.ini", data222[0]);
				if(fexist(string))//���� ���� � ID ����� ����������, ��:
				{
					GangSA[data222[0]] = 0;//��������� ������ ID ����� � ����
					SetTimerEx("DelAkk22", 300, 0, "i", data222[0]);
				}
			}
			else//���� ��������� ������� - �� ����� �����, ��:
			{
				if(data222[0] > 0)//���� ����� ������� � �����, ��:
				{
					format(string, sizeof(string), "gangs/%d.ini", data222[0]);
					if(fexist(string))//���� ���� � ID ����� ����������, ��:
					{
						GPlayers[data222[0]]--;//������ � ����� -1 �����, � ��������� ���������
						GangSave(data222[0]);//������ ID ����� � ����
						format(ssss, sizeof(ssss), " *** � ������� ����� ������� � ����� [%s{33CCFF}] �� %d (�������������) .",
						GName[data222[0]], GPlayers[data222[0]]);
						print(ssss);
						SendClientMessageToAll(COLOR_LIGHTBLUE, ssss);
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/edplgangs", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
   			new data222[2];
			tmp = strtok(cmdtext, idx);
    		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /edplgangs [����� (0- On-Line �����, 1- Off-Line �����)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [�� ������ (����� 0), ��� ��� �������� (����� 1)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [�� �����, ���: 0 - ������� ������ �� �����, -600 - ��������� ����������");
				SendClientMessage(playerid, COLOR_GRAD2, " ������ � �����] ( �������������: [������� � ����� (�� 1 �� 6)] )");
				return 1;
			}
			new para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " [����� (0- On-Line �����, 1- Off-Line �����)] !");
				return 1;
			}
			akk = strtok(cmdtext, idx);
			if(!strlen(akk))
			{
				SendClientMessage(playerid, COLOR_RED, " [�� ������ (����� 0), ��� ��� �������� (����� 1)] !");
				return 1;
			}
			new para2;
			if(para1 == 0)
			{
				para2 = strval(akk);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
					return 1;
				}
				if(gPlayerLogged[para2] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
			}
			if(para1 == 1)
			{
				if(strlen(akk) < 1 || strlen(akk) > 25)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ����� �������� ������ ���� �� 1 �� 25 �������� !");
					return 1;
				}
				format(string, sizeof(string), "players/%s.ini", akk);
				if(!fexist(string))
				{
					SendClientMessage(playerid,COLOR_RED," ������ �������� �� ���������� !");
					return 1;
				}
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_RED, " [�� �����, ��� 0 , ��� -600] !");
				return 1;
			}
			new para3 = strval(tmp);
			if(para3 < 0 && para3 != -600)
			{
				SendClientMessage(playerid, COLOR_RED, " [�� �����, ��� 0 , ��� -600] !");
				return 1;
			}
			new para4 = 0;
			if(para3 > 0)
			{
				new string22[256];
				format(string22,sizeof(string22),"gangs/%i.ini",para3);
				if(!fexist(string22) || para3 >= (MAX_GANGS - 1))
				{
					SendClientMessage(playerid, COLOR_RED, " ������ [�� �����] �� ������� ��� !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [������� � ����� (�� 1 �� 6)] !");
					return 1;
				}
				para4 = strval(tmp);
				if(para4 < 1 || para4 > 6)
				{
					SendClientMessage(playerid, COLOR_RED, " [������� � ����� (�� 1 �� 6)] !");
					return 1;
				}
			}
			if(para1 == 0)
			{
				if(PGang[para2] == para3 && GangLvl[para2] == para4)
				{
					SendClientMessage(playerid,COLOR_RED," � ���������� ������ ��� ����������� ����������� ������ !");
					return 1;
				}
				if(para3 == -600)
				{
					if(PGang[para2] == 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ���������� ������ %s � ����� (/edplgangs) .",
						RealName[playerid], RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(PGang[para2] > 0)
					{
						if(idgangsave[para2] > 0)//���� ID ����� ��� ������ - �������, ��:
						{
							new perloc;
							idgangsave[para2] = 0;//������� ID ����� ��� ������
							perloc = 0;
							while(perloc < MAX_PLAYERS)//���� ��� ���� �������
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//���� ���� ���� �� ���� ����� �� ����� ����������, ��:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}
						format(ssss, sizeof(ssss), " ������������� %s ������ ������ %s �� ����� (��: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ���������� ������ %s � ����� (/edplgangs) .",
						RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[PGang[para2]]--;//������ � ����� -1 �����
						GangSave(PGang[para2]);//���������� �����
					}
				}
				if(para3 == 0)
				{
					if(PGang[para2] == -600)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ���������� ������ %s � ����� (/edplgangs) .",
						RealName[playerid], RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(PGang[para2] > 0)
					{
						if(idgangsave[para2] > 0)//���� ID ����� ��� ������ - �������, ��:
						{
							new perloc;
							idgangsave[para2] = 0;//������� ID ����� ��� ������
							perloc = 0;
							while(perloc < MAX_PLAYERS)//���� ��� ���� �������
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//���� ���� ���� �� ���� ����� �� ����� ����������, ��:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}

						format(ssss, sizeof(ssss), " ������������� %s ������ ������ %s �� ����� (��: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ���������� ������ %s � ����� (/edplgangs) .",
						RealName[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[PGang[para2]]--;//������ � ����� -1 �����
						GangSave(PGang[para2]);//���������� �����
					}
				}
				if(para3 > 0)
				{
					if(PGang[para2] == -600 || PGang[para2] == 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ������ %s � ����� (��: %d) ,",
						RealName[playerid], RealName[para2], para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ������ %s ������� %d � ���� ����� (/edplgangs) .",
						RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], RealName[para2]);//��������� ��� ������ ������ �����
						}
						GPlayers[para3]++;//������ � ����� +1 �����
						GangSave(para3);//���������� �����

						if(GSkin[para3][para4-1] < 500)
						{//���� �� ������ ���������� ����, �� ������� ���� ������������ ������
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
						ColorPlay[para2] = GColorDec[para3];
						SetPlayerColor(para2, ColorPlay[para2]);//������������� ���� ����
						for(new i=0;i<MAX_PLAYERS;i++)//������������� ���� ������� ��� ���� �������
						{
							SetPlayerMarkerForPlayer(i, para2, GColorDec[para3]);
						}

						new dopper = 0;
						for(new i = 0; i < MAX_PLAYERS; i++)//���������� � ������ ID �����
						{
							if(para3 > 0 && para3 == idgangsave[i])
							{//���� ����� ������� � �����, � ID ��� ����� ��� ���� � ������, ��:
								dopper = 1;
							}
						}
						if(para3 > 0 && dopper == 0)
						{//���� ����� ������� � �����, � ID ��� ����� �� ��� ������ � ������, ��:
							idgangsave[para2] = para3;//���������� � ������ ID ����� ������
						}
					}
					if(PGang[para2] == para3)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ������ %s ������� %d � ��� ����� (/edplgangs) .",
						RealName[playerid], RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], RealName[para2]);//��������� ��� ������ ������ �����
						}
						GangSave(para3);//���������� �����

						if(GSkin[para3][para4-1] < 500)
						{//���� �� ������ ���������� ����, �� ������� ���� ������������ ������
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
					}
					if(PGang[para2] != para3 && PGang[para2] != -600 && PGang[para2] != 0)
					{
						if(idgangsave[para2] > 0)//���� ID ����� ��� ������ - �������, ��:
						{
							new perloc;
							idgangsave[para2] = 0;//������� ID ����� ��� ������
							perloc = 0;
							while(perloc < MAX_PLAYERS)//���� ��� ���� �������
							{
								if(PGang[para2] == PGang[perloc] && para2 != perloc)
								{//���� ���� ���� �� ���� ����� �� ����� ����������, ��:
									idgangsave[perloc] = PGang[para2];
									break;
								}
								perloc++;
							}
						}

						format(ssss, sizeof(ssss), " ������������� %s ������ ������ %s �� ����� (��: %d) ,",
						RealName[playerid], RealName[para2], PGang[para2]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** �������� ������ %s � ����� (��: %d) ,",
						RealName[para2], para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ������ %s ������� %d � ���� ����� (/edplgangs) .",
						RealName[para2], para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], RealName[para2]);//��������� ��� ������ ������ �����
						}
						GPlayers[PGang[para2]]--;//������ � ����� -1 �����
						GangSave(PGang[para2]);//���������� �����
						GPlayers[para3]++;//������ � ����� +1 �����
						GangSave(para3);//���������� �����

						if(GSkin[para3][para4-1] < 500)
						{//���� �� ������ ���������� ����, �� ������� ���� ������������ ������
							SetPVarInt(para2, "PlSkin", GSkin[para3][para4-1]);
							SetPlayerSkin(para2, GetPVarInt(para2, "PlSkin"));
						}
						ColorPlay[para2] = GColorDec[para3];
						SetPlayerColor(para2, ColorPlay[para2]);//������������� ���� ����
						for(new i=0;i<MAX_PLAYERS;i++)//������������� ���� ������� ��� ���� �������
						{
							SetPlayerMarkerForPlayer(i, para2, GColorDec[para3]);
						}

						new dopper = 0;
						for(new i = 0; i < MAX_PLAYERS; i++)//���������� � ������ ID �����
						{
							if(para3 > 0 && para3 == idgangsave[i])
							{//���� ����� ������� � �����, � ID ��� ����� ��� ���� � ������, ��:
								dopper = 1;
							}
						}
						if(para3 > 0 && dopper == 0)
						{//���� ����� ������� � �����, � ID ��� ����� �� ��� ������ � ������, ��:
							idgangsave[para2] = para3;//���������� � ������ ID ����� ������
						}
					}
				}
				PGang[para2] = para3;
				GangLvl[para2] = para4;
			}
			if(para1 == 1)
			{
				new file;//������ ��������
				file = ini_openFile(string);
				if(file >= 0)
				{
					ini_getInteger(file, "Frac1", data222[0]);
					ini_getInteger(file, "FracLvl1", data222[1]);
					ini_closeFile(file);
				}
				if(data222[0] == para3 && data222[1] == para4)
				{
					SendClientMessage(playerid,COLOR_RED," � ���������� ������ ��� ����������� ����������� ������ !");
					return 1;
				}
				if(para3 == -600)
				{
					if(data222[0] == 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ���������� ������� ������ %s � ����� (/edplgangs) .",
						RealName[playerid], akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(data222[0] > 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s ������ ������� ������ %s �� ����� (��: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ���������� ������� ������ %s � ����� (/edplgangs) .", akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[data222[0]]--;//������ � ����� -1 �����
						GangSave(data222[0]);//���������� �����
					}
				}
				if(para3 == 0)
				{
					if(data222[0] == -600)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ���������� ������� ������ %s � ����� (/edplgangs) .",
						RealName[playerid], akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					}
					if(data222[0] > 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s ������ ������� ������ %s �� ����� (��: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� ���������� ������� ������ %s � ����� (/edplgangs) .", akk);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						GPlayers[data222[0]]--;//������ � ����� -1 �����
						GangSave(data222[0]);//���������� �����
					}
				}
				if(para3 > 0)
				{
					if(data222[0] == -600 || data222[0] == 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� ������� ������ %s � ����� (��: %d) ,",
						RealName[playerid], akk, para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� �������� ������ %s ������� %d � ���� ����� (/edplgangs) .",
						akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], akk);//��������� ��� ������ ������ �����
						}
						GPlayers[para3]++;//������ � ����� +1 �����
						GangSave(para3);//���������� �����
					}
					if(data222[0] == para3)
					{
						format(ssss, sizeof(ssss), " ������������� %s �������� �������� ������ %s ������� %d � ��� ����� (/edplgangs) .",
						RealName[playerid], akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], akk);//��������� ��� ������ ������ �����
						}
						GangSave(para3);//���������� �����
					}
					if(data222[0] != para3 && data222[0] != -600 && data222[0] != 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s ������ ������� ������ %s �� ����� (��: %d) ,",
						RealName[playerid], akk, data222[0]);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** �������� ������� ������ %s � ����� (��: %d) ,", akk, para3);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						format(ssss, sizeof(ssss), " *** � �������� �������� ������ %s ������� %d � ���� ����� (/edplgangs) .",
						akk, para4);
						print(ssss);
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						if(para4 == 6)//���� ����������� ������� - ������� ������, ��:
						{
							strdel(GHead[para3], 0, 64);//������� ��� ������� ������ �����
							strcat(GHead[para3], akk);//��������� ��� ������ ������ �����
						}
						GPlayers[data222[0]]--;//������ � ����� -1 �����
						GangSave(data222[0]);//���������� �����
						GPlayers[para3]++;//������ � ����� +1 �����
						GangSave(para3);//���������� �����
					}
				}
				data222[0] = para3;
				data222[1] = para4;
				file = ini_openFile(string);//������ ���������� ��������
				if(file >= 0)
				{
					ini_setInteger(file, "Frac1", data222[0]);
					ini_setInteger(file, "FracLvl1", data222[1]);
					ini_closeFile(file);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
	if(strcmp(cmd, "/gmx", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 12)
		{
			format(string, sizeof(string), " ������������� %s [%d] ��������������� ������� ������� !", RealName[playerid], playerid);
			print(string);
			SendClientMessageToAll(COLOR_RED, string);
			SendClientMessageToAll(COLOR_RED, " �������� ! ����� 30 ������ ��������� ������� ������� !");
			restart = SetTimer("RestartS", 30000, 1);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
	}
	if(strcmp(cmd, "/madmins", true) == 0)
    {
   		if(PlayerInfo[playerid][pAdmin] >= 12)
    	{
			new para1, para2, para3, para4, f[256];
			tmp = strtok(cmdtext, idx);
    		if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /madmins [����� (0- �� �� ������, 1- �� ���� ������)]");
				SendClientMessage(playerid, COLOR_GRAD2, " [�� ������ / ��� ������] [�� ��������� (0- ����������� ��������");
				SendClientMessage(playerid, COLOR_GRAD2, " �������� ����� ������, 1- ���������� �������� �������� ����� ���");
				SendClientMessage(playerid, COLOR_GRAD2, " ������, 2- ������� �������� �������� ����� ������)]");
				return 1;
			}
			para1 = strval(tmp);
			if(para1 < 0 || para1 > 1)
			{
				SendClientMessage(playerid, COLOR_RED, " ����� 0 ��� 1 !");
				return 1;
			}
			if(para1 == 0)
			{
				tmp = strtok(cmdtext, idx);
	    		if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� ������] [�� ���������] !");
					return 1;
				}
				para2 = strval(tmp);
				if(!IsPlayerConnected(para2))
				{
					SendClientMessage(playerid, COLOR_RED, " ���������� [�� ������] �� ������� ��� !");
					return 1;
				}
				if(PlayerInfo[para2][pAdmin] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� [�� ������] - �� ����� !");
					return 1;
				}
				if(PlayerInfo[para2][pAdmin] <= 6)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� [�� ������] - ���� 7 lvl !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
	    		if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�� ��������� (0- ����������� �������� �������� ����� ������,");
					SendClientMessage(playerid, COLOR_RED, " 1- ���������� �������� �������� ����� ��� ������,");
					SendClientMessage(playerid, COLOR_RED, " 2- ������� �������� �������� ����� ������)] !");
					return 1;
				}
				para3 = strval(tmp);
				if(para3 < 0 || para3 > 2)
				{
					SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 2 !");
					return 1;
				}
				if(para3 == 0)
				{
					new twenlim = 0;
					new restlim = 0;
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						Fmadmins(1, RealName[para2], 0, twenlim, restlim);
					}
					else
					{
						Fmadmins(2, RealName[para2], 0, twenlim, restlim);
					}
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
					format(ssss,sizeof(ssss)," �����: [%s] �������� �����: [%d] ������� ������: [%d]", RealName[para2], twenlim, restlim);
					SendClientMessage(playerid, COLOR_GRAD1, ssss);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
					printf(" ������������� %s [%d] ���������� �������� �������� ����� ������ %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					return 1;
				}
				if(para3 == 1)
				{
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [�������� �������� �����] !");
						return 1;
					}
					para4 = strval(tmp);
					if(para4 < 0 || para4 > 2147000000)
					{
						SendClientMessage(playerid, COLOR_RED, " �������� �������� ����� �� 0 �� 2'147'000'000 !");
						return 1;
					}
					new twenlim = 0;
					new restlim = 0;
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						Fmadmins(1, RealName[para2], 0, twenlim, restlim);
					}
					else
					{
						Fmadmins(2, RealName[para2], 0, twenlim, restlim);
					}
					if(para4 == twenlim)
					{
						format(string, sizeof(string), " ��������� ���� �������� �������� ����� ��� ���������� ��� ������ %s !", RealName[para2]);
						SendClientMessage(playerid, COLOR_RED, string);
						return 1;
					}
					Fmadmins(1, RealName[para2], 0, para4, para4);
					if(para4 != 0)
					{
						format(ssss, sizeof(ssss), " ������������� %s ��������� ������ %s �������� �������� ����� � %d $ .", RealName[playerid], RealName[para2], para4);
						printf(" ������������� %s [%d] ��������� ������ %s [%d] �������� �������� ����� � %d $ ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2, para4);
					}
					else
					{
						format(ssss, sizeof(ssss), " ������������� %s ���� � ������ %s �������� �������� �����.", RealName[playerid], RealName[para2]);
						printf(" ������������� %s [%d] ���� � ������ %s [%d] �������� �������� ����� ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					}
					SendAdminMessage(COLOR_LIGHTBLUE, ssss);
					return 1;
				}
				if(para3 == 2)
				{
					format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
					if(!fexist(f))
					{
						para4 = 0;
					}
					else
					{
						para4 = 1;
					}
					if(para4 == 1)
					{
						new twenlim, restlim;
						Fmadmins(0, RealName[para2], 0, twenlim, restlim);
						format(ssss,sizeof(ssss)," �� ������� �������� �������� ����� ������ %s .", RealName[para2]);
						SendClientMessage(playerid, COLOR_YELLOW, ssss);
						printf(" ������������� %s [%d] ������ �������� �������� ����� ������ %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
					}
					else
					{
						format(string, sizeof(string), " �������� �������� ����� ������ %s ��� ��� ����� !", RealName[para2]);
						SendClientMessage(playerid, COLOR_RED, string);
					}
					return 1;
				}
			}
			if(para1 == 1)
			{
	  			new locpara;
				akk = strtok(cmdtext, idx);
	    		if(!strlen(akk))
				{
					SendClientMessage(playerid, COLOR_RED, " [��� ������] [�� ���������] !");
					return 1;
				}
				if(strlen(akk) < 1 || strlen(akk) > 25)
				{
					SendClientMessage(playerid, COLOR_RED, " ����� ���� ������ ������ ���� �� 1 �� 25 �������� !");
					return 1;
				}
				para2 = 0;//����� ���� ������ ����� ��-���� �������
				new doppara = 0;
				while(para2 < MAX_PLAYERS)
				{
					if(IsPlayerConnected(para2))
					{
						if(strcmp(akk, RealName[para2], false) == 0)
						{
							doppara = 1;
							break;
						}
					}
					para2++;
				}
				if(doppara == 0)//���� ��� ������ �� ������, ��:
				{//����� ���� ������ � ��������� �������
					format(string, sizeof(string), "players/%s.ini", akk);
					if(!fexist(string))
					{
						SendClientMessage(playerid,COLOR_RED," ���������� ���� ������ �� ���������� !");
						return 1;
					}
					new locfile;//������ ��������
					locfile = ini_openFile(string);
					if(locfile >= 0)
					{
						ini_getInteger(locfile, "AdminLevel", locpara);
						ini_closeFile(locfile);
					}
					new fadm;
					if(locpara < 0)
					{
						fadm = locpara * -1;
					}
					else
					{
						fadm = locpara;
					}
					if(fadm == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ��������� [��� ������] - �� ����� !");
						return 1;
					}
					if(fadm <= 6)
					{
						SendClientMessage(playerid, COLOR_RED, " ��������� [��� ������] - ���� 7 lvl !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [�� ��������� (0- ����������� �������� �������� ����� ������,");
						SendClientMessage(playerid, COLOR_RED, " 1- ���������� �������� �������� ����� ��� ������,");
						SendClientMessage(playerid, COLOR_RED, " 2- ������� �������� �������� ����� ������)] !");
						return 1;
					}
					para3 = strval(tmp);
					if(para3 < 0 || para3 > 2)
					{
						SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 2 !");
						return 1;
					}
					if(para3 == 0)
					{
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							Fmadmins(1, akk, 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, akk, 0, twenlim, restlim);
						}
						SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - Off-Line .");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						format(ssss,sizeof(ssss)," �����: [%s] �������� �����: [%d] ������� ������: [%d]", akk, twenlim, restlim);
						SendClientMessage(playerid, COLOR_GRAD1, ssss);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						printf(" ������������� %s [%d] ���������� �������� �������� ����� ������ %s ( /madmins ) .", RealName[playerid], playerid, akk);
						return 1;
					}
					if(para3 == 1)
					{
						tmp = strtok(cmdtext, idx);
			    		if(!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_RED, " [�������� �������� �����] !");
							return 1;
						}
						para4 = strval(tmp);
						if(para4 < 0 || para4 > 2147000000)
						{
							SendClientMessage(playerid, COLOR_RED, " �������� �������� ����� �� 0 �� 2'147'000'000 !");
							return 1;
						}
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							Fmadmins(1, akk, 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, akk, 0, twenlim, restlim);
						}
						if(para4 == twenlim)
						{
							format(string, sizeof(string), " ��������� ���� �������� �������� ����� ��� ���������� ��� ������ %s !", akk);
							SendClientMessage(playerid, COLOR_RED, string);
							return 1;
						}
						Fmadmins(1, akk, 0, para4, para4);
						SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - Off-Line .");
						if(para4 != 0)
						{
							format(ssss, sizeof(ssss), " ������������� %s ��������� ������ %s �������� �������� ����� � %d $ .", RealName[playerid], akk, para4);
							printf(" ������������� %s [%d] ��������� ������ %s �������� �������� ����� � %d $ ( /madmins ) .", RealName[playerid], playerid, akk, para4);
						}
						else
						{
							format(ssss, sizeof(ssss), " ������������� %s ���� � ������ %s �������� �������� �����.", RealName[playerid], akk);
							printf(" ������������� %s [%d] ���� � ������ %s �������� �������� ����� ( /madmins ) .", RealName[playerid], playerid, akk);
						}
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						return 1;
					}
					if(para3 == 2)
					{
						format(f, sizeof(f), "madmins/%s.ini", akk);
						if(!fexist(f))
						{
							para4 = 0;
						}
						else
						{
							para4 = 1;
						}
						if(para4 == 1)
						{
							new twenlim, restlim;
							Fmadmins(0, akk, 0, twenlim, restlim);
							SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - Off-Line .");
							format(ssss,sizeof(ssss)," �� ������� �������� �������� ����� ������ %s .", akk);
							SendClientMessage(playerid, COLOR_YELLOW, ssss);
							printf(" ������������� %s [%d] ������ �������� �������� ����� ������ %s ( /madmins ) .", RealName[playerid], playerid, akk);
						}
						else
						{
							format(string, sizeof(string), " �������� �������� ����� ������ %s ��� ��� ����� !", akk);
							SendClientMessage(playerid, COLOR_RED, string);
						}
						return 1;
					}
				}
				else//����� (���� ��� ������ ��� ������ ����� ��-���� �������), ��:
				{
					if(PlayerInfo[para2][pAdmin] == 0)
					{
						SendClientMessage(playerid, COLOR_RED, " ��������� [��� ������] - �� ����� !");
						return 1;
					}
					if(PlayerInfo[para2][pAdmin] <= 6)
					{
						SendClientMessage(playerid, COLOR_RED, " ��������� [��� ������] - ���� 7 lvl !");
						return 1;
					}
					tmp = strtok(cmdtext, idx);
		    		if(!strlen(tmp))
					{
						SendClientMessage(playerid, COLOR_RED, " [�� ��������� (0- ����������� �������� �������� ����� ������,");
						SendClientMessage(playerid, COLOR_RED, " 1- ���������� �������� �������� ����� ��� ������,");
						SendClientMessage(playerid, COLOR_RED, " 2- ������� �������� �������� ����� ������)] !");
						return 1;
					}
					para3 = strval(tmp);
					if(para3 < 0 || para3 > 2)
					{
						SendClientMessage(playerid, COLOR_RED, " �� ��������� �� 0 �� 2 !");
						return 1;
					}
					if(para3 == 0)
					{
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							Fmadmins(1, RealName[para2], 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, RealName[para2], 0, twenlim, restlim);
						}
						SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - On-Line .");
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						format(ssss,sizeof(ssss)," �����: [%s] �������� �����: [%d] ������� ������: [%d]", RealName[para2], twenlim, restlim);
						SendClientMessage(playerid, COLOR_GRAD1, ssss);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------------------------------");
						printf(" ������������� %s [%d] ���������� �������� �������� ����� ������ %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						return 1;
					}
					if(para3 == 1)
					{
						tmp = strtok(cmdtext, idx);
			    		if(!strlen(tmp))
						{
							SendClientMessage(playerid, COLOR_RED, " [�������� �������� �����] !");
							return 1;
						}
						para4 = strval(tmp);
						if(para4 < 0 || para4 > 2147000000)
						{
							SendClientMessage(playerid, COLOR_RED, " �������� �������� ����� �� 0 �� 2'147'000'000 !");
							return 1;
						}
						new twenlim = 0;
						new restlim = 0;
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							Fmadmins(1, RealName[para2], 0, twenlim, restlim);
						}
						else
						{
							Fmadmins(2, RealName[para2], 0, twenlim, restlim);
						}
						if(para4 == twenlim)
						{
							format(string, sizeof(string), " ��������� ���� �������� �������� ����� ��� ���������� ��� ������ %s !", RealName[para2]);
							SendClientMessage(playerid, COLOR_RED, string);
							return 1;
						}
						Fmadmins(1, RealName[para2], 0, para4, para4);
						SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - On-Line .");
						if(para4 != 0)
						{
							format(ssss, sizeof(ssss), " ������������� %s ��������� ������ %s �������� �������� ����� � %d $ .", RealName[playerid], RealName[para2], para4);
							printf(" ������������� %s [%d] ��������� ������ %s [%d] �������� �������� ����� � %d $ ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2, para4);
						}
						else
						{
							format(ssss, sizeof(ssss), " ������������� %s ���� � ������ %s �������� �������� �����.", RealName[playerid], RealName[para2]);
							printf(" ������������� %s [%d] ���� � ������ %s [%d] �������� �������� ����� ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						}
						SendAdminMessage(COLOR_LIGHTBLUE, ssss);
						return 1;
					}
					if(para3 == 2)
					{
						format(f, sizeof(f), "madmins/%s.ini", RealName[para2]);
						if(!fexist(f))
						{
							para4 = 0;
						}
						else
						{
							para4 = 1;
						}
						if(para4 == 1)
						{
							new twenlim, restlim;
							Fmadmins(0, RealName[para2], 0, twenlim, restlim);
							SendClientMessage(playerid, COLOR_LIGHTRED, " ��������� [��� ������] - On-Line .");
							format(ssss,sizeof(ssss)," �� ������� �������� �������� ����� ������ %s .", RealName[para2]);
							SendClientMessage(playerid, COLOR_YELLOW, ssss);
							printf(" ������������� %s [%d] ������ �������� �������� ����� ������ %s [%d] ( /madmins ) .", RealName[playerid], playerid, RealName[para2], para2);
						}
						else
						{
							format(string, sizeof(string), " �������� �������� ����� ������ %s ��� ��� ����� !", RealName[para2]);
							SendClientMessage(playerid, COLOR_RED, string);
						}
						return 1;
					}
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
    }
//----------------- ������� ������� 12 � 13 ��� (�����) ------------------------
//-------------- ������� ������� 12, 13, � ���� ��� (������) -------------------
	if(strcmp(cmd, "/setlevel", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] >= 17 || IsPlayerAdmin(playerid))
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_GRAD2, " �����������: /setlevel [�� ������/����� ����] [�����(0-17)]");
				SendClientMessage(playerid, COLOR_GRAD2, " ( �������������: [�����] )");
				return 1;
			}
			new para1;
			para1 = ReturnUser(tmp);
 			if(IsPlayerConnected(para1))
 			{
				if(gPlayerLogged[para1] == 0)
				{
					SendClientMessage(playerid, COLOR_RED, " ��������� ����� ��� �� ����������� !");
					return 1;
				}
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					SendClientMessage(playerid, COLOR_RED, " [�����(0-17)] ( �������������: [�����] ) !");
					return 1;
				}
				new level;
				level = strval(tmp);
				if(level < 0 || level > 17)
				{
	 				SendClientMessage(playerid, COLOR_RED, " ������� ������ ������ ���� �� 0 �� 17 !");
					return 1;
				}
				new summ1, summ2;
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
					summ1 = 0;
				}
				else
				{
					summ1 = 1;
					summ2 = strval(tmp);
				}
				new dopper;
				dopper = PlayerInfo[para1][pAdmin];
				if(dopper == level)
				{
	 				SendClientMessage(playerid, COLOR_RED, " � ������ ��� ���� ����������� ������� ������ !");
					return 1;
				}
				PlayerInfo[para1][pAdmin] = level;//��������� ������ �������
				new dopper44;
				dopper44 = GetPlayerMoney(para1);
				if(PlayerInfo[para1][pAdmin] == 0)
				{
					PlayerInfo[para1][pAdmshad] = 0;//������ ���������
					format(string, sizeof(string), " ������������� %s ���� ������� � ������ %s .", RealName[playerid], RealName[para1]);
					print(string);
					SendAdminMessage(COLOR_RED, string);
					format(string, sizeof(string), " ������������� %s ���� � ��� �������.", RealName[playerid]);
					SendClientMessage(para1, COLOR_RED, string);
					if(summ1 == 1 && summ2 != GetPlayerMoney(para1))
					{
						SetPVarInt(para1, "MonControl", 1);
						ResetPlayerMoney(para1);//��������� ������� �����
						GivePlayerMoney(para1, summ2);
						format(string, sizeof(string), " *** ������ ���� ������ %s ��� ������ ��: %d $ .", RealName[para1],
						GetPlayerMoney(para1));
						print(string);
						SendAdminMessage(COLOR_RED, string);
						format(string, sizeof(string), " *** ��� ������ ���� ��� ������ ��: %d $ .", GetPlayerMoney(para1));
						SendClientMessage(para1, COLOR_RED, string);
						printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[para1], para1, dopper44);
					}
				}
				else
				{
					format(string, sizeof(string), " ������������� %s ��� ������ %s ������� %d ������.", RealName[playerid],
					RealName[para1], level);
					print(string);
					SendAdminMessage(COLOR_YELLOW, string);
					if(summ1 == 1 && summ2 != GetPlayerMoney(para1))
					{
						SetPVarInt(para1, "MonControl", 1);
						ResetPlayerMoney(para1);//��������� ������� �����
						GivePlayerMoney(para1, summ2);
						format(string, sizeof(string), " *** ������ ���� ������ %s ��� ������ ��: %d $ .", RealName[para1],
						GetPlayerMoney(para1));
						print(string);
						SendAdminMessage(COLOR_YELLOW, string);
						printf("[moneysys] ���������� ����� ������ %s [%d] : %d $", RealName[para1], para1, dopper44);
					}
				}
				if(PlayerInfo[para1][pAdmin] <= 6 && dopper >= 7)
				{
					new twenlim, restlim;
					Fmadmins(0, RealName[para1], 0, twenlim, restlim);
				}
				if(PlayerInfo[para1][pAdmin] >= 7 && dopper <= 6)
				{
					new twenlim = 0;
					new restlim = 0;
					Fmadmins(1, RealName[para1], 0, twenlim, restlim);
				}
				if(PlayerInfo[para1][pAdmin] >= 7 && dopper <= 6)
				{
					PlayerInfo[para1][pAdmlive] = 1;//���������� ����������
					SendClientMessage(para1, COLOR_GREEN, " ���������� ��������.");
				}
				if(PlayerInfo[para1][pAdmin] <= 6 && dopper >= 7)
				{
					PlayerInfo[para1][pAdmlive] = 0;//������ ����������
					SendClientMessage(para1, COLOR_RED, " ���������� ���������.");
				}
				if(PlayerInfo[para1][pAdmin] >= 1 && dopper == 0)
				{
		        SendClientMessage(playerid, COLOR_RED, "* � ����� ������������ ������ �������� ������� �� ����������� ���������� ������");
		        SendClientMessage(playerid, COLOR_RED, "* �� ������ �������, ������� ��, � ����������� ���� �� ������ ������");
		        SendClientMessage(playerid, COLOR_RED, "* ����� �� �������� ���� ���������������� ������� !!!");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, " ������ [�� ������] �� ������� ��� !");
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, " � ��� ��� ���� �� ������������� ���� ������� !");
		}
		return 1;
 	}
//-------------- ������� ������� 12, 13, � ���� ��� (�����) --------------------
	return SendClientMessage(playerid,-1,"{FF0000}������: {FFFFFF}������� �� �������! ���� /cmd ��� �������!");
}

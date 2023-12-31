/*			������� �����������			*/
stock bool:IsPlayerRegistered(playerid)	//��������������� �� ���� �����?
{
	new name[MAX_PLAYER_NAME], filename[64];
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	if(fexist(filename)) return true;
	return false;
}
stock bool:LoginPlayer(playerid,password[])	//������� ����������� ������
{
	new name[MAX_PLAYER_NAME], filename[64], data[64], key[32], val[32],
		File:aFile;
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	if(!fexist(filename))
	{ 
		SendClientMessage(playerid,COLOR_GREY,"{FF0000}������:{FFFFFF} ������ �������� �� ���������");
		return false;
	}
	aFile = fopen(filename,io_read);
	if(aFile)
	{
		fread(aFile,data);
		val = GetRightSideOfString(data,"=");
		strmid(val,val,0,strlen(val)-1,sizeof(val));
		if(strcmp(password,val,false) || strlen(val) == 0)	return false;//������ ��������
		strmid(PlayerInfo[playerid][pPassword],val,0,strlen(val),MAX_USER_PASS_LEN+1);
		while(fread(aFile,data))
		{
			key = GetLeftSideOfString(data,"=");
			val = GetRightSideOfString(data,"=");
			if(!strcmp(key,"�����",true)) PlayerInfo[playerid][pAdmin] = strval(val);
			else if(!strcmp(key,"��������",true)) PlayerInfo[playerid][pTutorial] = strval(val);
			else if(!strcmp(key,"������� ���",true)) PlayerInfo[playerid][pPos_x] = floatstr(val);
			else if(!strcmp(key,"������� �����",true)) PlayerInfo[playerid][pPos_y] = floatstr(val);
			else if(!strcmp(key,"������� ���",true)) PlayerInfo[playerid][pPos_z] = floatstr(val);
			else if(!strcmp(key,"���� ��������",true)) PlayerInfo[playerid][pFacingAngle] = floatstr(val);
			else if(!strcmp(key,"��������",true)) PlayerInfo[playerid][pInterior] = strval(val);
			else if(!strcmp(key,"����������� ���",true)) PlayerInfo[playerid][pVirtualWorld] = strval(val);
			else if(!strcmp(key,"��������",true)) PlayerInfo[playerid][pKills] = strval(val);
			else if(!strcmp(key,"�������",true)) PlayerInfo[playerid][pLevel] = strval(val);
			else if(!strcmp(key,"��������� ����",true)) strmid(PlayerInfo[playerid][pLastVictim],val,0,strlen(val)-1,MAX_PLAYER_NAME);
			else if(!strcmp(key,"������",true)) PlayerInfo[playerid][pMoney] = strval(val);
			else if(!strcmp(key,"�����",true)) PlayerInfo[playerid][pGangMember] = strval(val);
			else if(!strcmp(key,"����� �����",true)) PlayerInfo[playerid][pGangLeader] = strval(val);
			else if(!strcmp(key,"������� ������ �����",true)) PlayerInfo[playerid][pEnemyKills] = strval(val);
		}
		PlayerLoggedIn[playerid] = true;
		if(PlayerInfo[playerid][pGangMember] != -1)
		UpdateGangMember(playerid);
		return true;
	}
	SendClientMessage(playerid,COLOR_GREY,"{FF0000}������: {FFFFFF}���� �� ����� ���� ������.");
	return false;
}
stock bool:SavePlayer(playerid)			//��������� ������
{
	if(!PlayerLoggedIn[playerid]) return false;	//���� ����� �� ��� �����������
	new name[MAX_PLAYER_NAME], filename[64], data[64],
		File:aFile;
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	aFile = fopen(filename,io_write);
	if(aFile)
	{
		format(data,sizeof(data),"������=%s\n",PlayerInfo[playerid][pPassword]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"�����=%d\n",PlayerInfo[playerid][pAdmin]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"��������=%d\n",PlayerInfo[playerid][pTutorial]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"������� ���=%f\n",PlayerInfo[playerid][pPos_x]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"������� �����=%f\n",PlayerInfo[playerid][pPos_y]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"������� ���=%f\n",PlayerInfo[playerid][pPos_z]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"���� ��������=%f\n",PlayerInfo[playerid][pFacingAngle]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"��������=%d\n",PlayerInfo[playerid][pInterior]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"����������� ���=%d\n",PlayerInfo[playerid][pVirtualWorld]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"��������=%d\n",PlayerInfo[playerid][pKills]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"�������=%d\n",PlayerInfo[playerid][pLevel]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"��������� ����=%s\n",PlayerInfo[playerid][pLastVictim]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"������=%d\n",PlayerInfo[playerid][pMoney]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"�����=%d\n",PlayerInfo[playerid][pGangMember]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"����� �����=%d\n",PlayerInfo[playerid][pGangLeader]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"������� ������ �����=%d\n",PlayerInfo[playerid][pEnemyKills]); fwriteRUS(aFile,data);
		fclose(aFile);
		return true;
	}
	return false;
}

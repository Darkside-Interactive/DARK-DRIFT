enum gang_enum
{
			gName[MAX_GANG_NAME],	//�������� �����
			gFounded[16],			//���� ��������� �����
			gColor,					//���� �����
			gReputation,			//��������� �����
			gPistolSkill,			//�������� �� ����� ���������
			gUziSkill,				//�������� �� ����� ���
			gSawnOffSkill,			//�������� �� ����� �����������
			gArmour,				//����� �����
	Float:	gSpawn_x,				//���������� ������ x
	Float:	gSpawn_y,				//���������� ������ y
	Float:	gSpawn_z,				//���������� ������ z
	Float:	gSpawn_a,				//���� ��������� ��� ������	
			gSpawn_i,				//�������� ��� ������
			gSpawn_w				//����������� ��� ��� ������
}
new GangInfo[MAX_GANG_AMOUNT][gang_enum];
new GangWeaponSlot[MAX_GANG_AMOUNT][12];	//��������� ������ 0-11 ����
new GangWeaponAmmo[MAX_GANG_AMOUNT][12];	//������� ��� ������� �����
stock GetFreeGangID()		//������, ���� �� ��������� ����� ��� �������� ��� ����� �����
{
	for(new id; id < MAX_GANG_AMOUNT; id++)
	{
	    if(!strcmp(GangInfo[id][gName],"None",true))
	    return id;
	}
	return -1;
}
stock LoadGangs()			//��������� �����
{
	new File:aFile = fopen("Gangs/ganglist.ini",io_read), File:bFile,
		data[64],filename[64],key[32],val[32],
		gangid = -1, i;
	print("�����:");
	if(aFile)
	{
		while(fread(aFile,data,sizeof(data)))//������� �������� ����� �� ����������� �����
		{
			strmid(key,data,1,strfind(data,"]",true,0),sizeof(key));
			gangid = strval(key);
			strmid(GangInfo[gangid][gName],data,strfind(data,"]",true,0)+1,strlen(data)-1,MAX_GANG_NAME);
			format(filename,sizeof(filename),"Gangs/[%d]%s/gang.ini",gangid,GangInfo[gangid][gName]);
			bFile = fopen(filename,io_read);
			if(bFile)
			{
				while(fread(bFile,data))//��������� ���� ���� �� ����� �����
				{
					key = GetLeftSideOfString(data,"=");
					val = GetRightSideOfString(data,"=");
					if(!strcmp(key,"����",true)) 				GangInfo[gangid][gColor]		=	strval(val);
					if(!strcmp(key,"���� ���������",true)) 		strmid(GangInfo[gangid][gFounded],val,0,strlen(val)-1,16);
					if(!strcmp(key,"���������",true)) 			GangInfo[gangid][gReputation] 	=	strval(val);
					if(!strcmp(key,"���� ���������",true)) 		GangInfo[gangid][gPistolSkill] 	= 	strval(val);
					if(!strcmp(key,"���� ���",true)) 			GangInfo[gangid][gUziSkill] 	= 	strval(val);
					if(!strcmp(key,"���� �����������",true)) 	GangInfo[gangid][gSawnOffSkill] = 	strval(val);
					if(!strcmp(key,"�����",true)) 				GangInfo[gangid][gArmour] 		= 	strval(val);
					if(!strcmp(key,"����� x",true))				GangInfo[gangid][gSpawn_x]		=	floatstr(val);
					if(!strcmp(key,"����� y",true))				GangInfo[gangid][gSpawn_y]		=	floatstr(val);
					if(!strcmp(key,"����� z",true))				GangInfo[gangid][gSpawn_z]		=	floatstr(val);
					if(!strcmp(key,"����� a",true))				GangInfo[gangid][gSpawn_a]		=	floatstr(val);
					if(!strcmp(key,"����� i",true))				GangInfo[gangid][gSpawn_i]		=	strval(val);
					if(!strcmp(key,"����� w",true))				GangInfo[gangid][gSpawn_w]		=	strval(val);
					for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
					{
						format(filename,sizeof(filename),"���� ������ %d",i);
						if(!strcmp(key,filename,true))
						{	
							GangWeaponSlot[gangid][i] = strval(val);
							break;
						}
						format(filename,sizeof(filename),"������� ���� %d",i);
						if(!strcmp(key,filename,true))
						{	
							GangWeaponAmmo[gangid][i] = strval(val);
							break;
						}
					}
				}
				fclose(bFile);	//���� �����
			}
			printf("%s, ���� ���������: %s",GangInfo[gangid][gName],GangInfo[gangid][gFounded]);
		}
		fclose(aFile);			//���������� ����, ����� ��� �������
	}
	if(gangid == -1)
	print("�� ������� ��� ��� ����");
	return 1;
}
stock SaveGang(id)				//��������� �����, -1 = ��������� ���
{
	new File:aFile, i,
		string[128], fname[64];
	if(id == -1)
	{
		for(id = 0; id < MAX_GANG_AMOUNT; id++)
		{
			if(!strcmp(GangInfo[id][gName],"None",true)) continue;	//����-���� ������
			format(fname,sizeof(fname),"Gangs/[%d]%s/gang.ini",id,GangInfo[id][gName]);
			aFile = fopen(fname,io_write);
			if(aFile)
			{
				format(string,sizeof(string),"��������=%s\n",GangInfo[id][gName]);					fwriteRUS(aFile,string);
				format(string,sizeof(string),"����=%d\n",GangInfo[id][gColor]);						fwriteRUS(aFile,string);
				format(string,sizeof(string),"���� ���������=%s\n",GangInfo[id][gFounded]);			fwriteRUS(aFile,string);
				format(string,sizeof(string),"���������=%d\n",GangInfo[id][gReputation]);			fwriteRUS(aFile,string);
				format(string,sizeof(string),"���� ���������=%d\n",GangInfo[id][gPistolSkill]);		fwriteRUS(aFile,string);
				format(string,sizeof(string),"���� ���=%d\n",GangInfo[id][gUziSkill]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"���� �����������=%d\n",GangInfo[id][gSawnOffSkill]);	fwriteRUS(aFile,string);
				format(string,sizeof(string),"�����=%d\n",GangInfo[id][gArmour]);					fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� x=%f\n",GangInfo[id][gSpawn_x]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� y=%f\n",GangInfo[id][gSpawn_y]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� z=%f\n",GangInfo[id][gSpawn_z]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� a=%f\n",GangInfo[id][gSpawn_a]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� i=%d\n",GangInfo[id][gSpawn_i]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"����� w=%d\n",GangInfo[id][gSpawn_w]);				fwriteRUS(aFile,string);
				for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
				{
					format(string,sizeof(string),"���� ������ %d=%d\n",i,GangWeaponSlot[id][i]); 	fwriteRUS(aFile,string);
					format(string,sizeof(string),"������� ���� %d=%d\n",i,GangWeaponAmmo[id][i]); 	fwriteRUS(aFile,string);
				}
				fclose(aFile);
			}
		}
	}
	else
	{
		format(fname,sizeof(fname),"Gangs/[%d]%s/gang.ini",id,GangInfo[id][gName]);
		aFile = fopen(fname,io_write);
		if(aFile)
		{
			format(string,sizeof(string),"��������=%s\n",GangInfo[id][gName]);					fwriteRUS(aFile,string);
			format(string,sizeof(string),"����=%d\n",GangInfo[id][gColor]);						fwriteRUS(aFile,string);
			format(string,sizeof(string),"���� ���������=%s\n",GangInfo[id][gFounded]);			fwriteRUS(aFile,string);
			format(string,sizeof(string),"���������=%d\n",GangInfo[id][gReputation]);			fwriteRUS(aFile,string);
			format(string,sizeof(string),"���� ���������=%d\n",GangInfo[id][gPistolSkill]);		fwriteRUS(aFile,string);
			format(string,sizeof(string),"���� ���=%d\n",GangInfo[id][gUziSkill]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"���� �����������=%d\n",GangInfo[id][gSawnOffSkill]);	fwriteRUS(aFile,string);
			format(string,sizeof(string),"�����=%d\n",GangInfo[id][gArmour]);					fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� x=%f\n",GangInfo[id][gSpawn_x]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� y=%f\n",GangInfo[id][gSpawn_y]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� z=%f\n",GangInfo[id][gSpawn_z]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� a=%f\n",GangInfo[id][gSpawn_a]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� i=%d\n",GangInfo[id][gSpawn_i]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"����� w=%d\n",GangInfo[id][gSpawn_w]);				fwriteRUS(aFile,string);
			for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
			{
				format(string,sizeof(string),"���� ������ %d=%d\n",i,GangWeaponSlot[id][i]); 	fwriteRUS(aFile,string);
				format(string,sizeof(string),"������� ���� %d=%d\n",i,GangWeaponAmmo[id][i]); 	fwriteRUS(aFile,string);
			}
			fclose(aFile);
		}
	}
	return 1;
}
stock CountGangMembers(gangid)	//��������� ���������� ������ ����� �� �����
{
	new am,	filename[MAX_GANG_NAME+32];
	format(filename,sizeof(filename),"Gangs/[%d]%s/members.ini",gangid,GangInfo[gangid][gName]);
	new File:aFile = fopen(filename,io_read);
	if(aFile)
	{
		while(fread(aFile,filename,sizeof(filename)))
		am++;
		fclose(aFile);
	}
	return am;
}
stock CountGangMembersOnline(gangid)	//���������� ���-�� ������ ����� ������
{
	new am;
	for(new i; i < GetMaxPlayers(); i++)
	{
		if(PlayerInfo[i][pGangMember] == gangid) am++;
	}
	return am;
}
stock GetGangLeaderName(gangid)	//������ ��� ������ �����
{
	new plname[MAX_PLAYER_NAME+10],filename[MAX_GANG_NAME+32];
	format(filename,sizeof(filename),"Gangs/[%d]%s/members.ini",gangid,GangInfo[gangid][gName]);
	new File:aFile = fopen(filename,io_read);
	if(aFile)
	{
		fread(aFile,filename,sizeof(filename));
		fclose(aFile);
	}
	plname = GetLeftSideOfString(filename,"=");
	return plname;
}
/*stock ShowGangMenu(playerid)
{
	ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"���� �����","������� �������� �����\n������� ���� �����\n������ ��������� ��� �����\n������ ������ ��� �����\n������ ������� ��� ������\n������ ���� ��� �����\
	\n������ ����� ��� �����\n��������� ����� ��� �����\n������ ������� ��� �����\n��������� ����� ������\n������ ����� ��� �����","�����","������");
	return 1;
}*/
stock ShowGangMenu(playerid)
{
	ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"���� �����","������� �������� �����\n������� ���� �����\n������ ��������� ��� �����\n������ ������ ��� �����\n������ ������� ��� ������\n������ ���� ��� �����\
	\n������ ������� ��� �����\n��������� ����� ������\n������ ����� ��� �����","�����","������");
	return 1;
}
stock SetGangAmmunition(playerid)
{
	if(PlayerInfo[playerid][pGangMember] == -1)	return 0;
	//��������� ������
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gPistolSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,1000);
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gUziSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,1000);
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gSawnOffSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,1000);
	//���� �����
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gArmour] > 0)
	SetPlayerArmour(playerid,GangInfo[PlayerInfo[playerid][pGangMember]][gArmour]);
	//���� ������
	for(new i; i < sizeof(GangWeaponSlot[]); i++)
	{
	    if(GangWeaponSlot[PlayerInfo[playerid][pGangMember]][i] != 0)
	    GivePlayerWeapon(playerid,GangWeaponSlot[PlayerInfo[playerid][pGangMember]][i],GangWeaponAmmo[PlayerInfo[playerid][pGangMember]][i]);
	}
	return 1;
}
stock GetGangId(name[])
{
	for(new id; id < MAX_GANG_AMOUNT; id++)
	{
		if(!strcmp(GangInfo[id][gName],"None",true)) continue;	//����-���� ������
		if(!strcmp(GangInfo[id][gName],name,true)) return id;
	}
	return -1;
}
stock UpdateGangMember(playerid)
{
	new string[64], string2[64], plname[MAX_PLAYER_NAME];
	GetPlayerName(playerid,plname,sizeof(plname));
	format(string,sizeof(string),"Gangs/[%d]%s/members.ini",PlayerInfo[playerid][pGangMember],GangInfo[PlayerInfo[playerid][pGangMember]][gName]);
	format(string2,sizeof(string2),"%s=%d\n",plname,PlayerInfo[playerid][pLevel]);
	RewriteLineInFile(plname,string2,string);
	return 1;
}
stock ResetGangStats(gangid)
{
	strmid(GangInfo[gangid][gName],"None",0,4,MAX_GANG_NAME);
	strmid(GangInfo[gangid][gFounded],"None",0,4,16);
	GangInfo[gangid][gColor] = 0;
	GangInfo[gangid][gReputation] = 0;
	GangInfo[gangid][gPistolSkill] = 0;
	GangInfo[gangid][gUziSkill] = 0;
	GangInfo[gangid][gSawnOffSkill] = 0;
	GangInfo[gangid][gArmour] = 0;
	GangInfo[gangid][gSpawn_x] = 0.0;
	GangInfo[gangid][gSpawn_y] = 0.0;
	GangInfo[gangid][gSpawn_z] = 0.0;
	GangInfo[gangid][gSpawn_a] = 0.0;
	GangInfo[gangid][gSpawn_i] = 0;
	GangInfo[gangid][gSpawn_w] = 0;
	return 1;
}

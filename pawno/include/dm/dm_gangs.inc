enum gang_enum
{
			gName[MAX_GANG_NAME],	//Название банды
			gFounded[16],			//Дата основания банды
			gColor,					//Цвет банды
			gReputation,			//Репутация банды
			gPistolSkill,			//Прокачан ли скилл пистолета
			gUziSkill,				//Прокачан ли скилл узи
			gSawnOffSkill,			//Прокачан ли скилл двухстволки
			gArmour,				//Броня банды
	Float:	gSpawn_x,				//Координата спавна x
	Float:	gSpawn_y,				//Координата спавна y
	Float:	gSpawn_z,				//Координата спавна z
	Float:	gSpawn_a,				//Угол разворота при спавне	
			gSpawn_i,				//Интерьер при спавне
			gSpawn_w				//Виртуальный мир при спавне
}
new GangInfo[MAX_GANG_AMOUNT][gang_enum];
new GangWeaponSlot[MAX_GANG_AMOUNT][12];	//Купленное оружие 0-11 слот
new GangWeaponAmmo[MAX_GANG_AMOUNT][12];	//Патроны для каждого слота
stock GetFreeGangID()		//Узнать, есть ли свободное место для создания еще одной банды
{
	for(new id; id < MAX_GANG_AMOUNT; id++)
	{
	    if(!strcmp(GangInfo[id][gName],"None",true))
	    return id;
	}
	return -1;
}
stock LoadGangs()			//Загрузить банды
{
	new File:aFile = fopen("Gangs/ganglist.ini",io_read), File:bFile,
		data[64],filename[64],key[32],val[32],
		gangid = -1, i;
	print("Банды:");
	if(aFile)
	{
		while(fread(aFile,data,sizeof(data)))//Считали название банды из уникального файла
		{
			strmid(key,data,1,strfind(data,"]",true,0),sizeof(key));
			gangid = strval(key);
			strmid(GangInfo[gangid][gName],data,strfind(data,"]",true,0)+1,strlen(data)-1,MAX_GANG_NAME);
			format(filename,sizeof(filename),"Gangs/[%d]%s/gang.ini",gangid,GangInfo[gangid][gName]);
			bFile = fopen(filename,io_read);
			if(bFile)
			{
				while(fread(bFile,data))//Считываем саму инфу из файла банды
				{
					key = GetLeftSideOfString(data,"=");
					val = GetRightSideOfString(data,"=");
					if(!strcmp(key,"Цвет",true)) 				GangInfo[gangid][gColor]		=	strval(val);
					if(!strcmp(key,"Дата Основания",true)) 		strmid(GangInfo[gangid][gFounded],val,0,strlen(val)-1,16);
					if(!strcmp(key,"Репутация",true)) 			GangInfo[gangid][gReputation] 	=	strval(val);
					if(!strcmp(key,"Скил пистолета",true)) 		GangInfo[gangid][gPistolSkill] 	= 	strval(val);
					if(!strcmp(key,"Скил узи",true)) 			GangInfo[gangid][gUziSkill] 	= 	strval(val);
					if(!strcmp(key,"Скил двухстволки",true)) 	GangInfo[gangid][gSawnOffSkill] = 	strval(val);
					if(!strcmp(key,"Броня",true)) 				GangInfo[gangid][gArmour] 		= 	strval(val);
					if(!strcmp(key,"Спавн x",true))				GangInfo[gangid][gSpawn_x]		=	floatstr(val);
					if(!strcmp(key,"Спавн y",true))				GangInfo[gangid][gSpawn_y]		=	floatstr(val);
					if(!strcmp(key,"Спавн z",true))				GangInfo[gangid][gSpawn_z]		=	floatstr(val);
					if(!strcmp(key,"Спавн a",true))				GangInfo[gangid][gSpawn_a]		=	floatstr(val);
					if(!strcmp(key,"Спавн i",true))				GangInfo[gangid][gSpawn_i]		=	strval(val);
					if(!strcmp(key,"Спавн w",true))				GangInfo[gangid][gSpawn_w]		=	strval(val);
					for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
					{
						format(filename,sizeof(filename),"Слот Оружия %d",i);
						if(!strcmp(key,filename,true))
						{	
							GangWeaponSlot[gangid][i] = strval(val);
							break;
						}
						format(filename,sizeof(filename),"Патроны Слот %d",i);
						if(!strcmp(key,filename,true))
						{	
							GangWeaponAmmo[gangid][i] = strval(val);
							break;
						}
					}
				}
				fclose(bFile);	//Файл банды
			}
			printf("%s, Дата основания: %s",GangInfo[gangid][gName],GangInfo[gangid][gFounded]);
		}
		fclose(aFile);			//Уникальный файл, когда все считали
	}
	if(gangid == -1)
	print("На сервере еще нет банд");
	return 1;
}
stock SaveGang(id)				//Сохранить банду, -1 = сохранить все
{
	new File:aFile, i,
		string[128], fname[64];
	if(id == -1)
	{
		for(id = 0; id < MAX_GANG_AMOUNT; id++)
		{
			if(!strcmp(GangInfo[id][gName],"None",true)) continue;	//Ганг-слот пустой
			format(fname,sizeof(fname),"Gangs/[%d]%s/gang.ini",id,GangInfo[id][gName]);
			aFile = fopen(fname,io_write);
			if(aFile)
			{
				format(string,sizeof(string),"Название=%s\n",GangInfo[id][gName]);					fwriteRUS(aFile,string);
				format(string,sizeof(string),"Цвет=%d\n",GangInfo[id][gColor]);						fwriteRUS(aFile,string);
				format(string,sizeof(string),"Дата основания=%s\n",GangInfo[id][gFounded]);			fwriteRUS(aFile,string);
				format(string,sizeof(string),"Репутация=%d\n",GangInfo[id][gReputation]);			fwriteRUS(aFile,string);
				format(string,sizeof(string),"Скил пистолета=%d\n",GangInfo[id][gPistolSkill]);		fwriteRUS(aFile,string);
				format(string,sizeof(string),"Скил узи=%d\n",GangInfo[id][gUziSkill]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Скил двухстволки=%d\n",GangInfo[id][gSawnOffSkill]);	fwriteRUS(aFile,string);
				format(string,sizeof(string),"Броня=%d\n",GangInfo[id][gArmour]);					fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн x=%f\n",GangInfo[id][gSpawn_x]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн y=%f\n",GangInfo[id][gSpawn_y]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн z=%f\n",GangInfo[id][gSpawn_z]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн a=%f\n",GangInfo[id][gSpawn_a]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн i=%d\n",GangInfo[id][gSpawn_i]);				fwriteRUS(aFile,string);
				format(string,sizeof(string),"Спавн w=%d\n",GangInfo[id][gSpawn_w]);				fwriteRUS(aFile,string);
				for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
				{
					format(string,sizeof(string),"Слот Оружия %d=%d\n",i,GangWeaponSlot[id][i]); 	fwriteRUS(aFile,string);
					format(string,sizeof(string),"Патроны Слот %d=%d\n",i,GangWeaponAmmo[id][i]); 	fwriteRUS(aFile,string);
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
			format(string,sizeof(string),"Название=%s\n",GangInfo[id][gName]);					fwriteRUS(aFile,string);
			format(string,sizeof(string),"Цвет=%d\n",GangInfo[id][gColor]);						fwriteRUS(aFile,string);
			format(string,sizeof(string),"Дата основания=%s\n",GangInfo[id][gFounded]);			fwriteRUS(aFile,string);
			format(string,sizeof(string),"Репутация=%d\n",GangInfo[id][gReputation]);			fwriteRUS(aFile,string);
			format(string,sizeof(string),"Скил пистолета=%d\n",GangInfo[id][gPistolSkill]);		fwriteRUS(aFile,string);
			format(string,sizeof(string),"Скил узи=%d\n",GangInfo[id][gUziSkill]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Скил двухстволки=%d\n",GangInfo[id][gSawnOffSkill]);	fwriteRUS(aFile,string);
			format(string,sizeof(string),"Броня=%d\n",GangInfo[id][gArmour]);					fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн x=%f\n",GangInfo[id][gSpawn_x]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн y=%f\n",GangInfo[id][gSpawn_y]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн z=%f\n",GangInfo[id][gSpawn_z]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн a=%f\n",GangInfo[id][gSpawn_a]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн i=%d\n",GangInfo[id][gSpawn_i]);				fwriteRUS(aFile,string);
			format(string,sizeof(string),"Спавн w=%d\n",GangInfo[id][gSpawn_w]);				fwriteRUS(aFile,string);
			for(i = 0; i < sizeof(GangWeaponSlot[]); i++)
			{
				format(string,sizeof(string),"Слот Оружия %d=%d\n",i,GangWeaponSlot[id][i]); 	fwriteRUS(aFile,string);
				format(string,sizeof(string),"Патроны Слот %d=%d\n",i,GangWeaponAmmo[id][i]); 	fwriteRUS(aFile,string);
			}
			fclose(aFile);
		}
	}
	return 1;
}
stock CountGangMembers(gangid)	//Посчитать количество членов банды из файла
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
stock CountGangMembersOnline(gangid)	//Посчиитать кол-во членов банды онлайн
{
	new am;
	for(new i; i < GetMaxPlayers(); i++)
	{
		if(PlayerInfo[i][pGangMember] == gangid) am++;
	}
	return am;
}
stock GetGangLeaderName(gangid)	//Узнать имя лидера банды
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
	ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"Меню банды","Сменить название банды\nСменить цвет банды\nКупить репутацию для банды\nКупить оружие для банды\nКупить патроны для оружия\nКупить авто для банды\
	\nКупить район для банды\nРасширить район для банды\nКупить убежище для банды\nПрокачать скилы оружия\nКупить броню для банды","Далее","Отмена");
	return 1;
}*/
stock ShowGangMenu(playerid)
{
	ShowPlayerDialog(playerid,11,DIALOG_STYLE_LIST,"Меню банды","Сменить название банды\nСменить цвет банды\nКупить репутацию для банды\nКупить оружие для банды\nКупить патроны для оружия\nКупить авто для банды\
	\nКупить убежище для банды\nПрокачать скилы оружия\nКупить броню для банды","Далее","Отмена");
	return 1;
}
stock SetGangAmmunition(playerid)
{
	if(PlayerInfo[playerid][pGangMember] == -1)	return 0;
	//Установка скилов
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gPistolSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,1000);
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gUziSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,1000);
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gSawnOffSkill] == 1)
	SetPlayerSkillLevel(playerid,WEAPONSKILL_SAWNOFF_SHOTGUN,1000);
	//Даем броню
	if(GangInfo[PlayerInfo[playerid][pGangMember]][gArmour] > 0)
	SetPlayerArmour(playerid,GangInfo[PlayerInfo[playerid][pGangMember]][gArmour]);
	//Даем оружие
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
		if(!strcmp(GangInfo[id][gName],"None",true)) continue;	//Ганг-слот пустой
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

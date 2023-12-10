/*			Система регистрации			*/
stock bool:IsPlayerRegistered(playerid)	//Зарегистрирован ли этот игрок?
{
	new name[MAX_PLAYER_NAME], filename[64];
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	if(fexist(filename)) return true;
	return false;
}
stock bool:LoginPlayer(playerid,password[])	//Попытка авторизации игрока
{
	new name[MAX_PLAYER_NAME], filename[64], data[64], key[32], val[32],
		File:aFile;
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	if(!fexist(filename))
	{ 
		SendClientMessage(playerid,COLOR_GREY,"{FF0000}ОШИБКА:{FFFFFF} Вашего аккаунта не сущестует");
		return false;
	}
	aFile = fopen(filename,io_read);
	if(aFile)
	{
		fread(aFile,data);
		val = GetRightSideOfString(data,"=");
		strmid(val,val,0,strlen(val)-1,sizeof(val));
		if(strcmp(password,val,false) || strlen(val) == 0)	return false;//Пароль неверный
		strmid(PlayerInfo[playerid][pPassword],val,0,strlen(val),MAX_USER_PASS_LEN+1);
		while(fread(aFile,data))
		{
			key = GetLeftSideOfString(data,"=");
			val = GetRightSideOfString(data,"=");
			if(!strcmp(key,"Админ",true)) PlayerInfo[playerid][pAdmin] = strval(val);
			else if(!strcmp(key,"Обучение",true)) PlayerInfo[playerid][pTutorial] = strval(val);
			else if(!strcmp(key,"Позиция икс",true)) PlayerInfo[playerid][pPos_x] = floatstr(val);
			else if(!strcmp(key,"Позиция игрек",true)) PlayerInfo[playerid][pPos_y] = floatstr(val);
			else if(!strcmp(key,"Позиция зет",true)) PlayerInfo[playerid][pPos_z] = floatstr(val);
			else if(!strcmp(key,"Угол Поворота",true)) PlayerInfo[playerid][pFacingAngle] = floatstr(val);
			else if(!strcmp(key,"Интерьер",true)) PlayerInfo[playerid][pInterior] = strval(val);
			else if(!strcmp(key,"Виртуальный мир",true)) PlayerInfo[playerid][pVirtualWorld] = strval(val);
			else if(!strcmp(key,"Убийства",true)) PlayerInfo[playerid][pKills] = strval(val);
			else if(!strcmp(key,"Уровень",true)) PlayerInfo[playerid][pLevel] = strval(val);
			else if(!strcmp(key,"Последним Убил",true)) strmid(PlayerInfo[playerid][pLastVictim],val,0,strlen(val)-1,MAX_PLAYER_NAME);
			else if(!strcmp(key,"Деньги",true)) PlayerInfo[playerid][pMoney] = strval(val);
			else if(!strcmp(key,"Банда",true)) PlayerInfo[playerid][pGangMember] = strval(val);
			else if(!strcmp(key,"Лидер Банды",true)) PlayerInfo[playerid][pGangLeader] = strval(val);
			else if(!strcmp(key,"Убийств другой банды",true)) PlayerInfo[playerid][pEnemyKills] = strval(val);
		}
		PlayerLoggedIn[playerid] = true;
		if(PlayerInfo[playerid][pGangMember] != -1)
		UpdateGangMember(playerid);
		return true;
	}
	SendClientMessage(playerid,COLOR_GREY,"{FF0000}ОШИБКА: {FFFFFF}Файл не может быть считан.");
	return false;
}
stock bool:SavePlayer(playerid)			//Сохраняем игрока
{
	if(!PlayerLoggedIn[playerid]) return false;	//Если игрок не был авторизован
	new name[MAX_PLAYER_NAME], filename[64], data[64],
		File:aFile;
	GetPlayerName(playerid,name,sizeof(name));
	format(filename,sizeof(filename),"Accounts/%s.ini",name);
	aFile = fopen(filename,io_write);
	if(aFile)
	{
		format(data,sizeof(data),"Пароль=%s\n",PlayerInfo[playerid][pPassword]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Админ=%d\n",PlayerInfo[playerid][pAdmin]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Обучение=%d\n",PlayerInfo[playerid][pTutorial]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Позиция икс=%f\n",PlayerInfo[playerid][pPos_x]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Позиция игрек=%f\n",PlayerInfo[playerid][pPos_y]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Позиция зет=%f\n",PlayerInfo[playerid][pPos_z]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Угол поворота=%f\n",PlayerInfo[playerid][pFacingAngle]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Интерьер=%d\n",PlayerInfo[playerid][pInterior]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Виртуальный мир=%d\n",PlayerInfo[playerid][pVirtualWorld]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Убийства=%d\n",PlayerInfo[playerid][pKills]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Уровень=%d\n",PlayerInfo[playerid][pLevel]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Последним убил=%s\n",PlayerInfo[playerid][pLastVictim]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Деньги=%d\n",PlayerInfo[playerid][pMoney]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Банда=%d\n",PlayerInfo[playerid][pGangMember]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Лидер Банды=%d\n",PlayerInfo[playerid][pGangLeader]); fwriteRUS(aFile,data);
		format(data,sizeof(data),"Убийств другой банды=%d\n",PlayerInfo[playerid][pEnemyKills]); fwriteRUS(aFile,data);
		fclose(aFile);
		return true;
	}
	return false;
}

/*			Сервер			*/
forward SaveAccounts();		//Сохранить аккаунты всех игроков (используем в таймере)
forward SaveAllConfig();	//Сохранить всю конфигурацию сервера (используем в таймере)
stock LoadConfig()
{
	new File:aFile = fopen("config/config.cfg",io_read),
		data[128], k[64], v[64];
	if(!aFile) return 0;
	while(fread(aFile,data,sizeof(data)))
	{
		k = GetLeftSideOfString(data,"=");
		v = GetRightSideOfString(data,"=");
		if(!strcmp(k,"Максимальное Количество Машин Банды",true)) Config[MaxGangCars_cfg] = strval(v);
		else if(!strcmp(k,"Количество Домов",true)) Config[MaxHouseAmount_cfg] = strval(v);
	}
	fclose(aFile);
	return 1;
}
stock SaveConfig()
{
	new File:aFile = fopen("config/config.cfg",io_write),
		data[128];
	if(!aFile) return 0;
	format(data,sizeof(data),"Максимальное количество машин банды=%d\nКоличество Домов=%d",Config[MaxGangCars_cfg],Config[MaxHouseAmount_cfg]);	fwriteRUS(aFile,data);
	fclose(aFile);
	return 1;
}
public SaveAccounts()		//Сохранить аккаунты всех игроков (используем в таймере)
{
	for(new playerid; playerid < GetMaxPlayers(); playerid ++)
	{
		if(IsPlayerConnected(playerid))
		SavePlayer(playerid);
	}
	return 1;
}
public SaveAllConfig()
{
	SaveConfig();
	SaveCars();
	return 1;
}
stock GetColorName(color)	//Узнать название цвета из массива со всеми цветами по его десятичному значению
{
	new name[16], string[32];
	for(new i; i < sizeof(RegistrationColors); i++)
	{
		format(string,sizeof(string),"0x%sFF",RegistrationColors[i][col_Color]);
		if(color == HexToInt(string))
		{
			strmid(name,RegistrationColors[i][col_Name],0,strlen(RegistrationColors[i]),sizeof(name));
			return name;
		}
	}
	strmid(name,"Неизвестен",0,10,sizeof(name));
	return name;
}
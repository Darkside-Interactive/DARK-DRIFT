/*			Различные функции			*/
stock split(const source[],dest[][],delimiter)		//Разбить строку на подстроки
{
	new index,length = strlen(source), dIndex, start;
	while(index <= length)
	{
		if(source[index] == delimiter || index == length)//Если текущий символ - разделитель
		{	
			strmid(dest[dIndex],source,start,index,128);
			start = index+1;
			dIndex++;
		}
		index ++;
	}
	return 1;
}
stock GetLeftSideOfString(string[],center[])	//Возвращает левую часть строки
{
	new leftside[32],
		pos = strfind(string,center,true);
	strmid(leftside,string,0,pos,sizeof(leftside));
	return leftside;
}
stock GetRightSideOfString(string[],center[])	//Возвращает правую часть строки
{
	new rightside[32],
		pos = strfind(string,center,true);
	strmid(rightside,string,pos+1,strlen(string),sizeof(rightside));
	return rightside;
}
stock HexToInt(string[])
{
	if(string[0]==0) return 0;
	new i;
	new cur=1;
	new res=0;
	for (i=strlen(string); i>0; i--)
	{
		if (string[i-1]<58) res=res+cur*(string[i-1]-48);
		else res = res+cur*(string[i-1]-65+10);
     	cur=cur*16;
 	}
	return res;
}
stock strpar(string[])	//Достать подстроку-параметр из строки
{
	new mainc[20];
	if(strfind(string," ",true) == -1)
	{
	    strmid(mainc,string,0,strlen(string),sizeof(mainc));
	    strmid(string,"",0,0,0);
	}
	else
	{
		new spacepos = strfind(string," ",true);
	    while(spacepos != -1)
		{
		    spacepos = strfind(string," ",true);
		    if(spacepos == 0)
		    strdel(string,0,1);
		    else
			{
			    strmid(mainc,string,0,spacepos,sizeof(mainc));
			    strmid(string,string,spacepos+1,strlen(string),64);
			    spacepos = -1;
			}
		}
	}
	return mainc;
}
stock fwriteRUS(File:file,string[])			//Записать строку с кирилицей 
{
	for(new i; i < strlen(string); i++)
    fputchar(file,string[i],false);
	return 1;
}
stock DeleteLineFromFile(line[],filename[])
{
    new string[64], str[32], File:handle, File:ftmp;
    handle = fopen(filename,io_read);
    format(str,sizeof(str),"%s.part",filename);
    ftmp = fopen(str,io_write);
    while(fread(handle,string))
        if(strfind(string,line) == -1)
            fwriteRUS(ftmp,string);
    fclose(handle);
    fclose(ftmp);
    handle = fopen(filename,io_write);
    ftmp = fopen(str,io_read);
    while(fread(ftmp,string))
        fwriteRUS(handle,string);
    fclose(handle);
    fclose(ftmp);
    return fremove(str);
}
stock RewriteLineInFile(line[],reline[],filename[])
{
    new string[64], str[32], File:handle, File:ftmp;
    handle = fopen(filename,io_read);
    format(str,sizeof(str),"%s.part",filename);
    ftmp = fopen(str,io_write);
    while(fread(handle,string))
	{
        if(strfind(string,line) == -1)
        fwriteRUS(ftmp,string);
		else
		fwriteRUS(ftmp,reline);
	}
    fclose(handle);
    fclose(ftmp);
    handle = fopen(filename,io_write);
    ftmp = fopen(str,io_read);
    while(fread(ftmp,string))
        fwriteRUS(handle,string);
    fclose(handle);
    fclose(ftmp);
    return fremove(str);
}
stock SetPlayerLookAt(playerid, Float:X, Float:Y)
{
    new	Float:pX,Float:pY,Float:pZ,Float:ang;
	GetPlayerPos(playerid, pX, pY, pZ);
	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);
	SetPlayerFacingAngle(playerid, ang);
    return 1;
}
stock SetPlayerLookAtFrom(playerid, Float:X, Float:Y, Float:pX, Float:pY)
{
    new	/*Float:pX,Float:pY,Float:pZ,*/Float:ang;
//	GetPlayerPos(playerid, pX, pY, pZ);
	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);
	SetPlayerFacingAngle(playerid, ang);
    return 1;
}
stock IsAPistol(gunid)
{
	if(gunid >= 22 && gunid <=24)
    return 1;
	return 0;
}
stock IsAMelee(gunid)
{
	if(gunid >= 2 && gunid <= 9)
    return 1;
	return 0;
}
stock IsAGirlsStuff(gunid)
{
	if(gunid >= 10 && gunid <= 15)
    return 1;
	return 0;
}
stock IsAGrenade(gunid)
{
	if((gunid >= 16 && gunid <= 18) || gunid == 39)
    return 1;
	return 0;
}
stock IsAShotgun(gunid)
{
	if(gunid >= 25 && gunid <= 27)
    return 1;
	return 0;
}
stock IsAMachineGun(gunid)
{
	if(gunid == 28 || gunid == 29 || gunid == 32)
    return 1;
	return 0;
}
stock IsAnAssault(gunid)
{
	if(gunid == 30 || gunid == 31)
    return 1;
	return 0;
}
stock IsARifle(gunid)
{
	if(gunid == 33 || gunid == 34)
    return 1;
	return 0;
}
stock IsAHeavyAssault(gunid)
{
	if(gunid == 35 || gunid == 36 || gunid == 37)
    return 1;
	return 0;
}
stock IsAStuff1(gunid)//Баллончик
{
	if(gunid >= 41 && gunid <= 43 )
    return 1;
	return 0;
}
stock IsAStuff2(gunid)
{
	if(gunid >= 44 && gunid <= 46 )//Парашют
    return 1;
	return 0;
}
stock GetWeaponSlot(gunid)		//Узнать в каком слоте лежит это оружие
{
	if(gunid == 1) 					return 0;//Кастет
    else if(IsAMelee(gunid)) 		return 1;//Ручное оружие
	else if(IsAPistol(gunid)) 		return 2;//Пистолеты
	else if(IsAShotgun(gunid)) 		return 3;//Дробовики
	else if(IsAMachineGun(gunid)) 	return 4;//Автоматы
	else if(IsAnAssault(gunid)) 	return 5;//Осадное
	else if(IsARifle(gunid)) 		return 6;//Винтовки
	else if(IsAHeavyAssault(gunid)) return 7;//Мощная осада
	else if(IsAGrenade(gunid)) 		return 8;//Гранаты
	else if(IsAStuff1(gunid)) 		return 9;//Вещи
	else if(IsAGirlsStuff(gunid)) 	return 10;//Вещи для девушек
	else if(IsAStuff2(gunid))		 return 11;//Вещи2
	return -1;
}
#if defined _W_PS_included
	#endinput
#endif
#define _W_PS_included
#pragma library W_PS
/*============================================================================*\
=======================|      Points Streamer v2.3	    |=======================
=======================|      Created by: White_116     |=======================
=======================|      	Date: 17.05.2013     	|=======================
================================================================================
native IsValidPoint(pointid);// Существует ли точка
native CreatePoint(Float:x, Float:y, Float:z, Float:r, worldid=-1, interior=-1);// Cоздаёт точку (х, у, z, радиус, вирт.мир, интерьер)
native DestroyPoint(pointid);// Удаляет точку
native DestroyAllPoint();// Удаляет все точки
native SetPointPos(pointid, Float:x, Float:y, Float:z);//Переместить точку
native GetPointPos(pointid, &Float:x, &Float:y, &Float:z);//Узнать координаты точки
native SetPointRadius(pointid, Float:r);//Установить радиус точки
native GetPointRadius(pointid, &Float:r);//Узнать радиус точки
native SetPointInterior(pointid, interior);//Установить интерьер точки
native GetPointInterior(pointid);//Узнать интерьер точки
native SetPointVirtualWorld(pointid, worldid);//Установить вирт.мир точки
native GetPointVirtualWorld(pointid);//Узнать вирт.мир точки
native GetPlayerPoint(playerid, mode=0); //Узнает в какой точке находится игрок (самую близлежащую, самую близлежащую с проверкой радиуса, самую первую которая входит в радиус)
native GetPlayerMultiPoint(playerid, MP[], Size);//Узнает в каких точках находится игрок
native GetVehiclePoint(vehicleid, mode=0);//Узнает в какой точке находится транспорт (самую близлежащую, самую близлежащую с проверкой радиуса, самую первую которая входит в радиус)
native GetVehicleMultiPoint(vehicleid, MP[], Size);//Узнает в каких точках находится транспорт
\*============================================================================*/
#if !defined MAX_POINTS
	#define MAX_POINTS (1000)//Максимальное число точек.
#endif
#if !defined MAX_POINTS_TO_STREAM
	#define MAX_POINTS_TO_STREAM (100)//Количество точек в чанке (MAX 255)
#endif
#if !defined MAX_POINTS_REGION
	#define MAX_POINTS_REGION (3000)//Граница
#endif
#if !defined MAX_POINTS_SETKA_DLINA
	#define MAX_POINTS_SETKA_DLINA (60)//Размер чанка
#endif
#define MAX_POINTS_STORONA_DLINA ((MAX_POINTS_REGION*2)/MAX_POINTS_SETKA_DLINA)

new	Float:PointX[MAX_POINTS+1],
	Float:PointY[MAX_POINTS+1],
	Float:PointZ[MAX_POINTS+1],
	Float:PointR[MAX_POINTS+1],
	PointXX[MAX_POINTS+1 char],
	PointYY[MAX_POINTS+1 char],
	PointS[9][MAX_POINTS+1 char];
	
#if defined PointWorld
	new PointW[MAX_POINTS+1];
#endif

#if defined PointInterior
	new PointI[MAX_POINTS+1];
#endif
	
new Point_Chunk[MAX_POINTS_STORONA_DLINA][MAX_POINTS_STORONA_DLINA][MAX_POINTS_TO_STREAM],
	Point_PointsInChunk[MAX_POINTS_STORONA_DLINA][MAX_POINTS_STORONA_DLINA char],
	Point_Created[MAX_POINTS+1],
	Point_Points;
	
new const Okrug[9][2]={{0,0},{0,1},{0,-2},{1,1},{-2,0},{2,1},{0,-2},{-2,2},{0,-2}};
//==============================================================================
//==============================================================================
//==============================================================================
stock GetChunkPosXY(region,dlina,Float:x,Float:y,&x1,&y1,p=1)
{
	if(p)
	{
		// создадим искуственную границу дальше которой нельзя находится
		if(x<-region)x=-region+1; else if(y>region)y=region-1;
		if(y<-region)y=-region+1; else if(x>region)x=region-1;
	}
	x1=floatround((x+region)/dlina,floatround_floor);
	y1=floatround((y+region)/dlina,floatround_floor);
	return 1;
}

stock IsValidPoint(P)
{
	if(Point_Points == 0)return 0;
	if(!(0 < P <= MAX_POINTS))return 0;
	if(PointS[0]{P} == 0xFF)return 0;
	return 1;
}

stock Point_sd(Float:x,Float:y,Float:r,X,Y,f[9])
{
	x+=(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA);
	y+=(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA);
	new Float:ox=floatabs(x-(MAX_POINTS_SETKA_DLINA*X));
	new Float:oy=floatabs(y-(MAX_POINTS_SETKA_DLINA*Y));

	f[0]=1;

	if(ox < r)
	{
		f[4]=1; if(Point_PointsInChunk[X-1]{Y} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(oy < r)
	{
		f[2]=1; if(Point_PointsInChunk[X]{Y-1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(MAX_POINTS_SETKA_DLINA-ox < r)
	{
		f[3]=1; if(Point_PointsInChunk[X+1]{Y} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(MAX_POINTS_SETKA_DLINA-oy < r)
	{
		f[1]=1; if(Point_PointsInChunk[X]{Y+1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(floatsqroot(floatpower(ox, 2) + floatpower(oy, 2)) < r)
	{
		f[8]=1; if(Point_PointsInChunk[X-1]{Y-1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(floatsqroot(floatpower(floatsub(MAX_POINTS_SETKA_DLINA, ox), 2) + floatpower(floatabs(oy), 2)) < r)
	{
		f[6]=1; if(Point_PointsInChunk[X-1]{Y+1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(floatsqroot(floatpower(floatabs(ox), 2) + floatpower(floatsub(MAX_POINTS_SETKA_DLINA, oy), 2)) < r)
	{
		f[7]=1; if(Point_PointsInChunk[X+1]{Y+1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	if(floatsqroot( floatpower(floatsub(MAX_POINTS_SETKA_DLINA, ox), 2) + floatpower(floatsub(MAX_POINTS_SETKA_DLINA, oy), 2)) < r)
	{
		f[5]=1; if(Point_PointsInChunk[X+1]{Y-1} >= MAX_POINTS_TO_STREAM)return 0;
	}
	return 1;
}

stock CreatePoint(Float:x, Float:y, Float:z, Float:r, w=-1, i=-1)
{
//==================== Инициализация...
	if(Point_Points == 0)
	{
	    for(new e; e < 9; e++)for(new j=1; j <= MAX_POINTS; j++)PointS[e]{j}=0xFF;
	    for(new e; e < MAX_POINTS; e++)Point_Created[e]=e+1;
		Point_Points=1;
	}
//==================== проверяем, можно ли добавить точку...
	if(Point_Points >= MAX_POINTS)
	{
		#if defined DeBug
	    	printf("W_PS-Ошибка: Количество точек привышает максимально допустимого значения MAX_POINTS =%d=", MAX_POINTS);
	    #endif
		return 0;
	}
	new ffg[9],X,Y,P=Point_Created[MAX_POINTS-Point_Points];
//==================== проверяем, можно ли добавить точку...
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA,MAX_POINTS_SETKA_DLINA, x,y, X,Y);//	узнаём к какому квадрату относится точка
	if(Point_sd(x,y,r,X,Y,ffg) == 0)
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Чанк =%d-%d= или соседний заполнен, придел MAX_POINTS_TO_STREAM =%d=", X,Y, MAX_POINTS_TO_STREAM);
	    #endif
		return -1;//	если перебор точек на 1 квадрат
	}
//==================== добовляем данные точки...
	#if defined PointWorld
	if(w < -1)PointW[P]=-w; else PointW[P]=w;
	#else
	if(w != -1)
	{
	    #if defined DeBug
			printf("W_PS-Ошибка: Поддержка вирт.миров отключена! Точка =%d=",P);
		#endif
		return -2;
	}
	#endif
//====================
	#if defined PointInterior
	if(i < -1)PointI[P]=-i; else PointI[P]=i;
	#else
	if(i != -1)
	{
	    #if defined DeBug
			printf("W_PS-Ошибка: Поддержка интерьеров отключена! Точка =%d=",P);
		#endif
		return -3;
	}
	#endif
//====================
	if(r < 0.0)PointR[P]=-r; else PointR[P]=r;
	#if defined DeBug
	    if(PointR[P] >= MAX_POINTS_SETKA_DLINA)printf("W_PS-Предупреждение:Точка =%d=, радиус привышает %d. Возможно ненахождение точки!",P, MAX_POINTS_SETKA_DLINA);
	#endif
	PointX[P]=x,
	PointY[P]=y,
	PointZ[P]=z,
	Point_Created[MAX_POINTS-Point_Points]=0;//		запомним что свободной точки нет
	Point_Points++;//								запомним сколько всего точек
	PointXX{P}=X,
	PointYY{P}=Y;
	for(new t=0; t < 9; t++)
	{
	    X+=Okrug[t][0];	Y+=Okrug[t][1];
	    if(!ffg[t])continue;
		PointS[t]{P}=Point_PointsInChunk[X]{Y};
		Point_PointsInChunk[X]{Y}++;//				запомним количество точек в квадрате
		Point_Chunk[X][Y][PointS[t]{P}]=P;//		запомним ид точки
	}

	return P;//										Отправим ид точки
}

stock DestroyAllPoint()
{
    Point_Points=0;//								Запомним сколько всего точек
    for(new i; i < 9; i++)for(new j=1; j <= MAX_POINTS; j++)PointS[i]{j}=0xFF;
	for(new j; j < MAX_POINTS_STORONA_DLINA; j++)for(new k; k < MAX_POINTS_STORONA_DLINA; k++)Point_PointsInChunk[j]{k}=0;
	return 1;
}

stock DestroyPoint(P)
{
	if(!IsValidPoint(P))
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Точки =%d= не существует. Отмена удаления.", P);
	    #endif
		return 0;
	}
	Point_Points--;//								Запомним сколько всего точек
	Point_Created[MAX_POINTS-Point_Points]=P;
	
	new X=PointXX{P};
	new Y=PointYY{P};
	for(new i; i < 9; i++)
	{
	    X+=Okrug[i][0];	Y+=Okrug[i][1];//           Окружные чанки
	    if(PointS[i]{P} == 0xFF)continue;//         Если точки нет
		new K=Point_PointsInChunk[X]{Y}--;//		Запомним количество точек в квадрате
		Point_Chunk[X][Y][PointS[i]{P}]=0;//		Обнулим удалёную точку
		new P2=Point_Chunk[X][Y][K];//				Достанем ид крайней точки
		if(P2 == 0)PointS[i]{P}=0xFF;//				Наша точка оказаласть крайней, Запомним что точки не существует
		else
		{
			Point_Chunk[X][Y][K]=0;//				Обнулим Крайнюю точку
			Point_Chunk[X][Y][PointS[i]{P}]=P2;//	Внесём ид крайней точки в удалёную
			PointS[i]{P2}=PointS[i]{P};//			Изменим позицию крайней точки
			PointS[i]{P}=0xFF;//					Запомним что точки не существует
		}
	}
	return 1;
}

stock SetPointPos(P, Float:x, Float:y, Float:z)
{
    if(!IsValidPoint(P))
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Точки =%d= не существует. Отмена перемещения.", P);
	    #endif
		return 0;
	}
    new Z,U,ffg[9];;
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA,MAX_POINTS_SETKA_DLINA, x,y, Z,U);//	узнаём к какому квадрату будет относиться точка
	if(Point_sd(x,y,PointR[P],Z,U,ffg) == 0)
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Чанк =%d-%d= или соседний заполнен, придел MAX_POINTS_TO_STREAM =%d=", X,Y, MAX_POINTS_TO_STREAM);
	    #endif
		return -1;//	если перебор точек на 1 квадрат
	}
	
	new X=PointXX{P};
	new Y=PointYY{P};
	for(new i; i < 9; i++)
	{
	    X+=Okrug[i][0];	Y+=Okrug[i][1];//           Окружные чанки
	    if(PointS[i]{P} == 0xFF)continue;//         Если точки нет
		new K=Point_PointsInChunk[X]{Y}--;//		Запомним количество точек в квадрате
		Point_Chunk[X][Y][PointS[i]{P}]=0;//		Обнулим удалёную точку
		new P2=Point_Chunk[X][Y][K];//				Достанем ид крайней точки
		if(P2 == 0)PointS[i]{P}=0xFF;//				Наша точка оказаласть крайней, Запомним что точки не существует
		else
		{
			Point_Chunk[X][Y][K]=0;//				Обнулим Крайнюю точку
			Point_Chunk[X][Y][PointS[i]{P}]=P2;//	Внесём ид крайней точки в удалёную
			PointS[i]{P2}=PointS[i]{P};//			Изменим позицию крайней точки
			PointS[i]{P}=0xFF;//					Запомним что точки не существует
		}
	}

	for(new t=0; t < 9; t++)
	{
	    Z+=Okrug[t][0];	U+=Okrug[t][1];
	    if(!ffg[t])continue;
		PointS[t]{P}=Point_PointsInChunk[Z]{U};
		Point_PointsInChunk[Z]{U}++;//				запомним количество точек в квадрате
		Point_Chunk[Z][U][PointS[t]{P}]=P;//		запомним ид точки
	}
	PointXX{P}=X;PointYY{P}=Y;
	PointX[P]=x; PointY[P]=y; PointZ[P]=z;
	return 1;
}

stock GetPointPos(P, &Float:x, &Float:y, &Float:z)
{
    if(!IsValidPoint(P))
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно определить позицию.", P);
	    #endif
		return 0;
	}
	x=PointX[P]; y=PointY[P]; z=PointZ[P];
	return 1;
}

stock SetPointRadius(P,Float:r)
{
    if(!IsValidPoint(P))
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно установить радиус.", P);
	    #endif
		return 0;
	}
	if(r < 0.0)PointR[P]=-r; else PointR[P]=r;
	return 1;
}

stock GetPointRadius(P,&Float:r)
{
    if(!IsValidPoint(P))
	{
	    #if defined DeBug
	    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно определить радиус.", P);
	    #endif
		return 0;
	}
	r=PointR[P];
	return 1;
}

#if defined PointWorld
	stock SetPointVirtualWorld(P, w)
	{
	    if(!IsValidPoint(P))
		{
		    #if defined DeBug
		    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно установить радиус.", P);
		    #endif
			return 0;
		}
		if(w < -1)PointW[P]=-w; else PointW[P]=w;
		return 1;
	}

	stock GetPointVirtualWorld(P)
	{
	    if(!IsValidPoint(P))
		{
		    #if defined DeBug
		    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно определить радиус.", P);
		    #endif
			return -2;
		}
		return PointW[P];
	}
#endif

#if defined PointInterior
	stock SetPointInterior(P, i)
	{
	    if(!IsValidPoint(P))
		{
		    #if defined DeBug
		    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно установить радиус.", P);
		    #endif
			return 0;
		}
		if(i < -1)PointI[P]=-i; else PointI[P]=i;
		return 1;
	}

	stock GetPointInterior(P)
	{
	    if(!IsValidPoint(P))
		{
		    #if defined DeBug
		    	printf("W_PS-Ошибка: Точки =%d= не существует. Не возможно определить радиус.", P);
		    #endif
			return 0;
		}
		return PointI[P];
	}
#endif

//==============================================================================
//==============================================================================
//==============================================================================
stock GetPlayerPoint(playerid, r=0)
{
	new Float:x,Float:y, Float:z, X,Y,P,P2;
	GetPlayerPos(playerid,x,y,z);
	#if defined PointWorld
	new WorldID=GetPlayerVirtualWorld(playerid);
	#endif
	
	#if defined PointInterior
	new InteriorID=GetPlayerInterior(playerid);
	#endif
	z=1000.0;
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA, MAX_POINTS_SETKA_DLINA, x, y, X, Y);//	узнаём к какому квадрату относится точка
//--------------------------
	if(r == 2)
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] || PointW[P]!=-1)continue;
			#endif
			#if defined PointInterior
			if(InteriorID != PointI[P] || PointI[P]!=-1)continue;
			#endif
            if(IsPlayerInRangeOfPoint(playerid, PointR[P], PointX[P], PointY[P], PointZ[P]))return P;
		}
	}
	else if(r == 1) 
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] && PointW[P]!=-1)continue;
			#endif
			#if defined PointInterior
			if(InteriorID != PointI[P] && PointI[P]!=-1)continue;
			#endif

			y=GetPlayerDistanceFromPoint(playerid, PointX[P], PointY[P], PointZ[P]);
			if(y < z)
			{
                z=y; P2=P;
			}
		}
	}
	else 
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] && PointW[P]!=-1)continue;
			#endif
			#if defined PointInterior
			if(InteriorID != PointI[P] && PointI[P]!=-1)continue;
			#endif
            y=GetPlayerDistanceFromPoint(playerid, PointX[P], PointY[P], PointZ[P]);
			if(y > PointR[P])continue;
			if(y < z)
			{
                z=y; P2=P;
			}
		}
	}
	return P2;
}

stock GetPlayerMultiPoint(playerid, MP[], S)
{
	new Float:x,Float:y, Float:z, X,Y,P,K;
	GetPlayerPos(playerid,x,y,z);
	#if defined PointWorld
	new WorldID=GetPlayerVirtualWorld(playerid);
	#endif

	#if defined PointInterior
	new InteriorID=GetPlayerInterior(playerid);
	#endif
	z=1000.0;
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA, MAX_POINTS_SETKA_DLINA, x, y, X, Y);//	узнаём к какому квадрату относится точка
//--------------------------
    for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
    if(K < S)
    {
        P=Point_Chunk[X][Y][OP];
        #if defined PointWorld
		if(WorldID != PointW[P] || PointW[P]!=-1)continue;
		#endif
		#if defined PointInterior
		if(InteriorID != PointI[P] || PointI[P]!=-1)continue;
		#endif
		
        if(IsPlayerInRangeOfPoint(playerid, PointR[P], PointX[P], PointY[P], PointZ[P]))
		{
			MP[K]=P; K++;
		}
	}
	return K;
}
//==============================================================================
stock GetVehiclePoint(vehicleid, r=0)
{
	new Float:x,Float:y, Float:z, X,Y,P,P2;
	GetVehiclePos(vehicleid,x,y,z);
	#if defined PointWorld
	new WorldID=GetVehicleVirtualWorld(vehicleid);
	#endif

	z=1000.0;
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA, MAX_POINTS_SETKA_DLINA, x, y, X, Y);//	узнаём к какому квадрату относится точка
//--------------------------
	if(r == 2)
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] || PointW[P]!=-1)continue;
			#endif

			if(GetVehicleDistanceFromPoint(vehicleid, PointX[P], PointY[P], PointZ[P]) <= PointR[P])return P;
		}
	}
	else if(r == 1)
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] && PointW[P]!=-1)continue;
			#endif

			y=GetVehicleDistanceFromPoint(vehicleid, PointX[P], PointY[P], PointZ[P]);
			if(y < z)
			{
                z=y; P2=P;
			}
		}
	}
	else
	{
        for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
        {
            P=Point_Chunk[X][Y][OP];
            #if defined PointWorld
			if(WorldID != PointW[P] && PointW[P]!=-1)continue;
			#endif

            y=GetVehicleDistanceFromPoint(vehicleid, PointX[P], PointY[P], PointZ[P]);
			if(y > PointR[P])continue;
			if(y < z)
			{
                z=y; P2=P;
			}
		}
	}
	return P2;
}

stock GetVehicleMultiPoint(vehicle, MP[], S)
{
	new Float:x,Float:y, Float:z, X,Y,P,K;
	GetVehiclePos(vehicleid,x,y,z);
	#if defined PointWorld
	new WorldID=GetVehicleVirtualWorld(vehicleid);
	#endif

	z=1000.0;
	GetChunkPosXY(MAX_POINTS_REGION-MAX_POINTS_SETKA_DLINA, MAX_POINTS_SETKA_DLINA, x, y, X, Y);//	узнаём к какому квадрату относится точка
//--------------------------
    for(new OP=Point_PointsInChunk[X]{Y}-1; OP > -1; OP--)
    if(K < S)
    {
        P=Point_Chunk[X][Y][OP];
        #if defined PointWorld
		if(WorldID != PointW[P] || PointW[P]!=-1)continue;
		#endif

        if(GetVehicleDistanceFromPoint(vehicleid, PointX[P], PointY[P], PointZ[P]) <= PointR[P])
		{
			MP[K]=P; K++;
		}
	}
	return K;
}

#undef MAX_POINTS_TO_STREAM
#undef MAX_POINTS_REGION
#undef MAX_POINTS_SETKA_DLINA
#undef MAX_POINTS_STORONA_DLINA
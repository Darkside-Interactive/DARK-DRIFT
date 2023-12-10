#include <a_samp>
#include <streamer>

#define MAXTEXT 19 //число текстов (ОБЯЗАТЕЛЬНО - ТОЧНОЕ КОЛИЧЕСТВО !!!)
new MyObj[MAXTEXT];

public OnFilterScriptInit()
{
	MyObj[0]=CreateDynamicObject(19479, 1266.3, -1651.962280, 24.0, 0.0, 0.0, 180.0);
	SetDynamicObjectMaterialText(MyObj[0], 0, "Leiman", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 155, 1, 0xFFFFFFFF, 0xFFFF6633, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[1]=CreateDynamicObject(19479, 1239.0, -1677.5, 15.0, 0.0, 0.0, 90.0);
	SetDynamicObjectMaterialText(MyObj[1], 0, "Leiman", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 41, 1, 0xFF000000, 0xFF66FF00, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[2]=CreateDynamicObject(19482, 2239.5044, -1150.7448, 30.0, 0.0000, 0.0000, 90.0000);
	SetDynamicObjectMaterialText(MyObj[2], 0, "Бардель", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 50, 1, 0xFF008000, 0xFFFFFFFF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[3]=CreateDynamicObject(19479, 1010.098, 2483.55, 14.162612, 0.0000, 0.0000, -90.0000);
	SetDynamicObjectMaterialText(MyObj[3], 0, "-", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 100, 1, 0xFF000000, 0xFFFF0000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[4]=CreateDynamicObject(19482, -2441.2578, 492.7998, 31.5, 0.0000, 0.0000, -65.1602); //73.5
	SetDynamicObjectMaterialText(MyObj[4], 0, "продажа", OBJECT_MATERIAL_SIZE_512x256,
 	"Tahoma", 170, 1, 0xFF000000, 0xFFFFFFFF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[5]=CreateDynamicObject(19477, 1491.65, 2773.848876, 13.5, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterialText(MyObj[5], 0, "База клана \
	\n -r", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 100, 1, 0xFFFFFFFF, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[6]=CreateDynamicObject(19482, 1491.65, 2772.0, 11.5, 0.0000, 0.0000,00.0000);
	SetDynamicObjectMaterialText(MyObj[6], 0, "Лидер \
	\n -", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 60, 1, 0xFFFFFFFF, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

	MyObj[7]=CreateDynamicObject(19482, 1491.65, 2775.5, 11.5, 0.0000, 0.0000, 0.0000);
	SetDynamicObjectMaterialText(MyObj[7], 0, "Зам \
	\n -", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 60, 1, 0xFFFFFFFF, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

 	MyObj[8]=CreateDynamicObject(19479, 2257.6, -2280.5, 17.25, 0.0000, 0.0000, 135.0);
	SetDynamicObjectMaterialText(MyObj[8], 0, "Leiman", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 155, 1, 0xFFFFFF00, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);

 	MyObj[9]=CreateDynamicObject(19482, -2065.5, -2143.0, 301.0, 0.0000, 0.0000, 51.6);
	SetDynamicObjectMaterialText(MyObj[9], 0, "VIP Leiman", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 100, 1, 0xFFFF0000, 0xFF0000FF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);////Верх

 	MyObj[10]=CreateDynamicObject(19482, -2057.0, -2149.5, 297.0078, 0.0000, 0.0000, 51.6);
	SetDynamicObjectMaterialText(MyObj[10], 0, "Лидер \
	\n Snown", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 100, 1, 0xFFFF0000, 0xFF0000FF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////лево

 	MyObj[11]=CreateDynamicObject(19482, -2072.150878, -2137.889892, 297.0078, 0.0000, 0.0000, 51.6);
	SetDynamicObjectMaterialText(MyObj[11], 0, "Зам \
	\n -", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 85, 1, 0xFFFF0000, 0xFF0000FF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////право

  	MyObj[12]=CreateDynamicObject(19477, 1269.0, -1663.0, 15.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[12], 0, "/helptp", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 160, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

  	MyObj[13]=CreateDynamicObject(19477, 1269.0, -1666.0, 15.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[13], 0, "/help", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 200, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

  	MyObj[14]=CreateDynamicObject(19477, 1269.0, -1669.0, 15.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[14], 0, "/gpson", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 150, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

  	MyObj[15]=CreateDynamicObject(19477, 1269.0, -1663.0, 19.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[15], 0, "/admins", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 140, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

  	MyObj[16]=CreateDynamicObject(19477, 1269.0, -1663.0, 17.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[16], 0, "/rules", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 140, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

  	MyObj[17]=CreateDynamicObject(19477, 1269.0, -1666.0, 17.0, 0.0000, 0.0000, 179.9610);
	SetDynamicObjectMaterialText(MyObj[17], 0, "/report", OBJECT_MATERIAL_SIZE_512x512,
 	"Tahoma", 140, 1, 0xFFFF0000, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.спавн

 	MyObj[18]=CreateDynamicObject(19482, -2697.5, 1933.7673, 183.0, 0.0000, 0.0000, 0.000);
	SetDynamicObjectMaterialText(MyObj[18], 0, "Leiman", OBJECT_MATERIAL_SIZE_512x256,
 	"Tahoma", 160, 1, 0xFFFF0000, 0xFFFFFFFF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);/////табл.скин

	return 1;
}

public OnFilterScriptExit()///////////// -2698.2217, 1933.7673, 180.8436
{
	for(new i=0; i<MAXTEXT; i++)
	{
		DestroyDynamicObject(i);
	}
	return 1;
}

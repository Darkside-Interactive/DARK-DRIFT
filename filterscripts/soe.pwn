/*
*   [FS] Server Object Editor (Серверный редактор объектов)
*   Версия: 1.5
*   Автор: Electric епта
*/
#include <a_samp>

#define DIALOG_SOE			1050
#define DIALOG_CREATE		DIALOG_SOE + 1
#define DIALOG_SELECT   	DIALOG_SOE + 2
#define DIALOG_TUTORIAL 	DIALOG_SOE + 3
#define DIALOG_SAVE_1		DIALOG_SOE + 4
#define DIALOG_SAVE_2       DIALOG_SOE + 5

enum SavedEnums {
	Float:foX,
	Float:foY,
	Float:foZ,
	Float:roX,
	Float:roY,
	Float:roZ
};

new O[SavedEnums];

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/soe", cmdtext, true, 10) == 0)
	{
	    if(0 == IsPlayerAdmin(playerid))
        return 1;
        
		ShowPlayerDialog(playerid, DIALOG_SOE, DIALOG_STYLE_LIST, "Редактор объектов", \
		"Инструкция\nСоздать объект\nИзменить карту","Выбрать","Отмена");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_SOE:
	    {
	        if(response)
	        {
	            if(listitem == 0) ShowPlayerDialog(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_MSGBOX, \
				"Инструкция","{FFFFFF}Горячие клавиши:\n\n{008080}Escape {FFFFFF}- чтобы выйти из редактора,\nили выбора объекта\n{008080}Shift {FFFFFF}- чтобы вращать камеру\nво время редактирования",\
				"Готово","Назад");
	            if(listitem == 1) ShowPlayerDialog(playerid, DIALOG_CREATE, DIALOG_STYLE_INPUT, \
				"Создание объекта","Введите ID модели объекта для того чтобы его создать\nОбъект появится перед вами, далее вы будете изменять его\n\nМаксимальный ID объекта - 19469",\
				"Создать","Назад");
				if(listitem == 2) SelectObject(playerid);
	        }
	    }
	    case DIALOG_CREATE:
	    {
			if(!response) return OnPlayerCommandText(playerid, "/soe");
			if(!strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_CREATE, DIALOG_STYLE_INPUT, \
			"Создание объекта","Введите ID модели объекта для того чтобы его создать\nОбъект появится перед вами, далее вы будете изменять его\n\nМаксимальный ID объекта - 19469\n{FF0000}Ошибка: Недопустимое значение!",\
			"Создать","Назад");
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			new obj;
			obj = CreateObject(strval(inputtext), X+1, Y+1, Z+1, 0.0,0.0,0.0);
			EditObject(playerid, obj);
			SetPVarInt(playerid, "ModelID", strval(inputtext));
		}
	    case DIALOG_SELECT:
	    {
			new objectid = GetPVarInt(playerid, "SelectedObject");
			if(response) EditObject(playerid, objectid);
			else DestroyObject(objectid) && CancelEdit(playerid);
	    }
	    case DIALOG_TUTORIAL: if(!response) return OnPlayerCommandText(playerid, "/soe");
	    case DIALOG_SAVE_1:
	    {
	        if(response) return ShowPlayerDialog(playerid, DIALOG_SAVE_2, DIALOG_STYLE_INPUT, "Название файла","Введите название текстового документа,\nв который сохранится ваш объект","Сохранить","Отмена");
	    }
	    case DIALOG_SAVE_2:
	    {
	        if(response)
	        {
	            if(!strlen(inputtext)) return SendClientMessage(playerid, 0xFF0000FF, "Вы оставили поле ввода пустым!");
	            new string1[255], string2[128], File: objs;
	            format(string2, sizeof(string2), "soe/%s.txt", inputtext);
	            objs = fopen(string2, io_append);
	            format(string1, sizeof(string1), "CreateObject(%d, %f,%f,%f, %f,%f,%f);\r\n", \
				GetPVarInt(playerid, "ModelID"), O[foX],O[foY],O[foZ], O[roX],O[roY],O[roZ]);
	            fwrite(objs, string1);
	            fclose(objs);
	        }
	    }
	}
	return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	ShowPlayerDialog(playerid, DIALOG_SELECT, DIALOG_STYLE_MSGBOX,"Действие с объектом", \
	"Выберите действие с объектом\nВы можете его отредактировать или удалить","Изменить","Удалить");
	SetPVarInt(playerid, "SelectedObject", objectid);
	SetPVarInt(playerid, "ModelID", modelid);
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(response == 1)
	{
		ShowPlayerDialog(playerid, DIALOG_SAVE_1, DIALOG_STYLE_MSGBOX, "Объект изменён",\
		"Желаете ли вы сохранить объект в файл?\n\nФайл с объектами находится в {FFFFFF}scriptfiles/soe/*.txt",\
		"Сохранить...","Отмена");
		O[foX] = fX;
		O[foY] = fY;
		O[foZ] = fZ;
		O[roX] = fRotX;
		O[roY] = fRotY;
		O[roZ] = fRotZ;
	}
}

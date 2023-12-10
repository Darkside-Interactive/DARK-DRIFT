/*
*	Created:			02.10.09
*	Author:			009
*	Last Modifed:		14.02.10
*
*	14.02.10:
*	1.Добавлены DB
*/

#if defined _furnitures_computers_included
	#endinput
#endif

#define _furnitures_computers_included
#pragma library furnitures_computers

// --------------------------------------------------
// includes
// --------------------------------------------------


// --------------------------------------------------
// defines
// --------------------------------------------------
#define COMP_FOLDER_DESKTOP 0
#define FOLDER_ACTIONS_STRING_COPY "Открыть\nСоздать папку\nСоздать файл\nУдалить\nНастройки компьютера\nВставить"
#define FOLDER_ACTIONS_STRING "Открыть\nСоздать папку\nСоздать файл\nУдалить\nНастройки компьютера"
#define FOLDER_ACTIONS_EX_STRING "Создать папку\nСоздать файл\nНастройки компьютера"
#define FOLDER_ACTIONS_EX_STRING_COPY "Создать папку\nСоздать файл\nНастройки компьютера\nВставить"
#define FILE_ACTIONS_STRING "Редактировать\nКопировать"
#define SITE_ACTIONS_STRING "Связь с администратором"
#define DB_ACTIONS_STRING "Удалить запись\nИзменить запись"
#define COMP_SETTINGS_STRING "Сменить пароль"
#define EMAIL_STRING "Авторизация\nРегистрация"
#define INTERNET_STRING "E-m@il\nКаталог сайтов\nСоздать сайт\nРедактировать сайт\nПерейти на сайт\nСоздать базу данных\nОткрыть базу данных"
#define MAX_EMAIL_SIZE 10
#define MAX_DB_SIZE 15

// --------------------------------------------------
// defines functions
// --------------------------------------------------
#define AddRecordInDataBase(%1,%2,%3,%4) \
	format(query,sizeof(query),"INSERT INTO `DataBases_data` (`id`,`Address`,`Key`,`Value`) VALUES (%d,'%s',%d,%d)",%1,%2,%3,%4); \
	samp_mysql_query(query)
#define ChangeRecordInDataBase(%1,%2,%3,%4) \
	format(query,sizeof(query),"UPDATE `DataBases_data` SET `Value`=%d WHERE `id`=%d AND `Address`='%s' AND `Key`=%d",%4,%1,%2,%3); \
	samp_mysql_query(query)
#define GetRecordIdForDataBase(%1) \
	format(query,sizeof(query),"SELECT MAX(`id`) FROM `DataBases_data` WHERE `Address`='%s'",%1); \
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result)
#define GetRecordValueFromDataBase(%1,%2,%3) \
	format(query,sizeof(query),"SELECT `Value` FROM `DataBases_data` WHERE `id`=%d AND `Address`='%s' AND `Key`=%d",%1,%2,%3); \
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result)
	
// --------------------------------------------------
// enums
// --------------------------------------------------
enum ComputersPlayerInfo {
	cCurrentFile,
	cCurrentFolder,
	cEditString[MAX_STRING],
	cCopyInfo[3],
	cEmailLogin[MAX_EMAIL_SIZE],
	cTempId,
	cLetterName[MAX_STRING],
	cLetterTo[MAX_EMAIL_SIZE],
	cSiteAddress[MAX_SITE_SIZE],
	cDBAddress[MAX_DB_SIZE],
};

// --------------------------------------------------
// news
// --------------------------------------------------
static Computers_Player[MAX_PLAYERS][ComputersPlayerInfo];

// --------------------------------------------------
// forwards
// --------------------------------------------------
forward OnEMailRecived(email[],content[],senderid);

// --------------------------------------------------
// statics functions
// --------------------------------------------------
static GetFolderName(furnitureid,folderid)
{
	Debug(DEBUG_START,"GetFolderName(%d,%d)",furnitureid,folderid);
	format(query,sizeof(query),"SELECT `Name` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Type`=%d AND `Content`='%d'",furnitureid,COMP_ROW_TYPE_FOLDER,folderid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result);
	fixchars(result);
	Debug(DEBUG_END,"GetFolderName(reason: complete)");
	return result;
}

static GetFolderContentForPlayer(furnitureid,folderid,playerid,string[],size)
{
	Debug(DEBUG_START,"GetFolderContentForPlayer(%d,%d,%d)",furnitureid,folderid,playerid);
	new name[MAX_STRING],
		tmp[MAX_STRING],
		li;
	nullstr(string);
	format(query,sizeof(query),"SELECT `Name`,`Type`,`File` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d ORDER BY `File` ASC",furnitureid,folderid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(result))
	{
		samp_mysql_get_field("Name",name);
		fixchars(name);
		samp_mysql_get_field("Type",tmp);
		switch(strval(tmp))
		{
			case COMP_ROW_TYPE_FOLDER:
			{
				samp_mysql_get_field("File",tmp);
				SetPlayerModeDialogListData(playerid,li,strval(tmp));
				format(string,size,"%s%s  \t\t[folder]\n",string,name);
				
			}
			case COMP_ROW_TYPE_FILE:
			{
				samp_mysql_get_field("File",tmp);
				SetPlayerModeDialogListData(playerid,li,strval(tmp));
				format(string,size,"%s%s  \t\t[file]\n",string,name);
				
			}
		}
		li++;
	}
	Debug(DEBUG_END,"GetFolderContentForPlayer(reason: complete)");
	return 1;
}

static ShowCompFolder(furnitureid,folderid,playerid)
{
	Debug(DEBUG_START,"ShowCompFolder(%d,%d,%d)",furnitureid,folderid,playerid);
	GetFolderContentForPlayer(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid,DialogString,sizeof(DialogString));
	if(!DialogString[0])
	{
		ShowPlayerModeDialog(playerid,DIALOG_COMP_NONEFILES,DIALOG_STYLE_MSGBOX,GetFolderName(furnitureid,Computers_Player[playerid][cCurrentFolder]),"Папка пуста","Действие","Назад");
		Debug(DEBUG_END,"ShowCompFolder(reason: complete)");
		return 1;
	}							
	ShowPlayerModeDialog(playerid,DIALOG_COMP_FOLDER,DIALOG_STYLE_LIST,GetFolderName(furnitureid,Computers_Player[playerid][cCurrentFolder]),DialogString,"Действие","Назад");
	Debug(DEBUG_END,"ShowCompFolder(reason: complete)");
	return 1;
}

static ShowMailList(playerid)
{
	Debug(DEBUG_START,"ShowMailList(%d)",playerid);
	new tmp[MAX_STRING],
		name[MAX_STRING],
		li;
	nullstr(DialogString);
	format(query,sizeof(query),"SELECT `id`,`Name`,`Sender` FROM `Email_letters` WHERE `Login`='%s' ORDER BY `id` ASC",Computers_Player[playerid][cEmailLogin]);
	samp_mysql_query(query);
	format(DialogString,sizeof(DialogString),"Написать письмо\n");
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(result))
	{
		samp_mysql_get_field("Name",name);
		fixchars(name);
		samp_mysql_get_field("Sender",tmp);
		format(DialogString,sizeof(DialogString),"%s%s \t\t[%s@mail.sa]\n",DialogString,name,tmp);
		samp_mysql_get_field("id",tmp);
		SetPlayerModeDialogListData(playerid,li,strval(tmp));
		li++;
	}
	ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,Computers_Player[playerid][cEmailLogin],DialogString,"Действия","Выход");
	Computers_Player[playerid][cUsingType] = USING_TYPE_EMAIL_MAIL_LIST;	
	Debug(DEBUG_END,"ShowMailList(reason: complete)");
	return 1;
}

static ShowDBContent(playerid)
{
	new li,
		tmp[15];
	nullstr(DialogString);
	format(query,sizeof(query),"SELECT `id`,`Key`,`Value` FROM `DataBases_data` WHERE `Address`='%s'",Computers_Player[playerid][cDBAddress]);
	samp_mysql_query(query);
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(result)) 
	{
		samp_mysql_get_field("Key",tmp);
		samp_mysql_get_field("Value",result);
		format(DialogString,sizeof(DialogString),"%s%s\t%s\n",DialogString,tmp,result);
		samp_mysql_get_field("id",tmp);
		SetPlayerModeDialogListData(playerid,li,strval(tmp));
		li++;
	}
	if(li == 0)
	{
		ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cDBAddress],"Пусто","Назад","Назад");
		Computers_Player[playerid][cUsingType] = USING_TYPE_DB_NULL;
	}
	else
	{
		ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_LIST,Computers_Player[playerid][cDBAddress],DialogString,"Действие","Отмена");
		Computers_Player[playerid][cUsingType] = USING_TYPE_DB_LIST;
	}
}

// --------------------------------------------------
// Obligatory functions
// --------------------------------------------------
Comp_Init()
{
	Debug(DEBUG_START,"Computers_Init()");
	AddActionSelectRow(RusToGame("Использовать~n~компьютер"),ACTION_USE_COMP);
	Debug(DEBUG_END,"Computers_Init(reason: complete)");
}

Comp_OnFurnitureActionCheck(playerid,actionid,furnitureid,type,modeobjectid)
{
	Debug(DEBUG_START,"Comp_OnFurnitureActionCheck(%d,%d,%d,%d,%d)",playerid,actionid,furnitureid,type,modeobjectid);
	if(type != FURNITURE_TYPE_COMPUTER) {Debug(DEBUG_END,"Comp_OnFurnitureActionCheck(reason: its not computer)");return 0;}
	if(actionid != ACTION_USE_COMP) {Debug(DEBUG_END,"Comp_OnFurnitureActionCheck(reason: any actionid)");return 0;}
	new Float:ang[3];
	GetModeObjectRot(modeobjectid,ang[0],ang[1],ang[2]);
	GetPlayerFacingAngle(playerid,ang[0]);
	ang[1] = ang[0] - ang[2];
	if(ang[1] < 0) ang[1] *= -1;
	if((ang[1] < 170.0) || (ang[1] > 190.0)) {Debug(DEBUG_END,"Comp_OnFurnitureActionCheck(reason: face not see on comp)");return 0;}
	Debug(DEBUG_END,"Comp_OnFurnitureActionCheck(reason: complete)");
	return 1;	
}

Comp_OnFurnitureActionSelect(playerid,actionid,furnitureid,type,modeobjectid)
{
	Debug(DEBUG_START,"Comp_OnFurnitureActionSelect(%d,%d,%d,%d,%d)",playerid,actionid,furnitureid,type,modeobjectid);
	if(type != FURNITURE_TYPE_COMPUTER) {Debug(DEBUG_END,"Comp_OnFurnitureActionCheck(reason: its not computer)");return 0;}
	if(actionid != ACTION_USE_COMP) {Debug(DEBUG_END,"Comp_OnFurnitureActionSelect(reason: any actionid)");return 0;}
	new Float:ang[3];
	GetModeObjectRot(modeobjectid,ang[0],ang[1],ang[2]);
	GetPlayerFacingAngle(playerid,ang[0]);
	ang[1] = ang[0] - ang[2];
	if(ang[1] < 0) ang[1] *= -1;
	if((ang[1] < 170.0) || (ang[1] > 190.0)) {Debug(DEBUG_END,"Comp_OnFurnitureActionSelect(reason: face not see on comp)");return 0;}
	Debug(DEBUG_ACTION,"Check password");
	format(query,sizeof(query),"SELECT `Password` FROM `Computers` WHERE `FurnitureId`=%d",furnitureid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result);
	if(result[0] != 0)
	{
		ShowPlayerModeDialog(playerid,DIALOG_COMP_ENTER_PASSWORD,DIALOG_STYLE_INPUT,"Введите пароль","Пожалуйста введите пароль","Ок","Отмена");
		ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_PASSWORD,COMP_INFO_PASSWORD);
		SetPlayerAction(playerid,ACTION_USE_COMP);
		Debug(DEBUG_END,"Comp_OnFurnitureActionSelect(reason: complete)");
		return 1;
	}
	Computers_Player[playerid][cCopyInfo][0] = 0;
	Computers_Player[playerid][cCurrentFolder] = COMP_FOLDER_DESKTOP; // ID desktop
	ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_CONTROL,COMP_INFO_CONTROL);
	ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
	SetPlayerAction(playerid,ACTION_USE_COMP);
	Debug(DEBUG_END,"Comp_OnFurnitureActionSelect(reason: complete)");
	return 1;
}

Comp_OnFurnitureDialogResponse(playerid,dialogid,response,listitem,inputtext[],furnitureid,type,modeobjectid)
{
	Debug(DEBUG_START,"Comp_OnFurnitureDialogResponse(%d,%d,%d,%d,'%s',%d,%d,%d)",playerid,dialogid,response,listitem,inputtext,furnitureid,type,modeobjectid);
	switch(dialogid)
	{
		case DIALOG_COMP_ENTER_PASSWORD:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ENTER_PASSWORD");
			if(!response) 
			{
				SetPlayerAction(playerid,ACTION_NONE);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strlen(inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_ENTER_PASSWORD,DIALOG_STYLE_INPUT,"Введите пароль","Не верный пароль\nПожалуйста введите пароль","Ок","Отмена");
				ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_UNPASSWORD,COMP_INFO_UNPASSWORD);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: nothing password)");
				return 1;
			}
			format(query,sizeof(query),"SELECT `Password` FROM `Computers` WHERE `FurnitureId`=%d",furnitureid);
			samp_mysql_query(query);
			samp_mysql_store_result();
			samp_mysql_fetch_row(result);
			if(strcmp(result,inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_ENTER_PASSWORD,DIALOG_STYLE_INPUT,"Введите пароль","Не верный пароль\nПожалуйста введите пароль","Ок","Отмена");
				ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_UNPASSWORD,COMP_INFO_UNPASSWORD);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: incorrect password)");
				return 1;
			}
			Computers_Player[playerid][cCopyInfo][0] = 0;
			Computers_Player[playerid][cCurrentFolder] = COMP_FOLDER_DESKTOP; // ID desktop
			ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_CONTROL,COMP_INFO_CONTROL);
			ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
			SetPlayerAction(playerid,ACTION_USE_COMP);
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_FOLDER:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_FOLDER");
			if(!response) 
			{
				if(Computers_Player[playerid][cCurrentFolder] == COMP_FOLDER_DESKTOP)
				{
					SetPlayerAction(playerid,ACTION_NONE);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				else
				{
					format(query,sizeof(query),"SELECT `Folder` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Type`=%d AND `Content`='%d'",furnitureid,COMP_ROW_TYPE_FOLDER,Computers_Player[playerid][cCurrentFolder]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					samp_mysql_fetch_row(result);				
					Computers_Player[playerid][cCurrentFolder] = strval(result);
					ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
			}
			Computers_Player[playerid][cCurrentFile] = GetPlayerModeDialogListData(playerid,listitem);
			if(!Computers_Player[playerid][cCopyInfo][0]) ShowPlayerModeDialog(playerid,DIALOG_COMP_ACTIONS,DIALOG_STYLE_LIST,"Действие",FOLDER_ACTIONS_STRING,"Выбрать","Назад");
			else ShowPlayerModeDialog(playerid,DIALOG_COMP_ACTIONS,DIALOG_STYLE_LIST,"Действие",FOLDER_ACTIONS_STRING_COPY,"Выбрать","Назад");
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_ACTIONS:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ACTIONS");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Открыть",inputtext))
			{
				if(!strcmp(GetFolderName(furnitureid,Computers_Player[playerid][cCurrentFolder]),"Internet",true))
				{
					ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				new tmp[20];
				format(query,sizeof(query),"SELECT `Type`,`Content`,`Name` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder],Computers_Player[playerid][cCurrentFile]);
				samp_mysql_query(query);
				samp_mysql_store_result();
				samp_mysql_fetch_row(result);
				samp_mysql_get_field("Type",tmp);
				switch(strval(tmp))
				{
					case COMP_ROW_TYPE_FOLDER:
					{
						samp_mysql_get_field("Content",tmp);						
						Computers_Player[playerid][cCurrentFolder] = strval(tmp);
						ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					case COMP_ROW_TYPE_FILE:
					{
						samp_mysql_get_field("Name",tmp);	
						samp_mysql_get_field("Content",result);
						ShowPlayerModeDialog(playerid,DIALOG_COMP_FILE,DIALOG_STYLE_MSGBOX,tmp,result,"Действие","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
				}
			}
			if(!strcmp("Создать папку",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_ADD_FOLDER,DIALOG_STYLE_INPUT,"Создать папку","Введите название папки:","Создать","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Создать файл",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_ADD_FILE,DIALOG_STYLE_INPUT,"Создать файл","Введите название файла:","Создать","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Удалить",inputtext))
			{
				format(query,sizeof(query),"DELETE FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder],Computers_Player[playerid][cCurrentFile]);
				samp_mysql_query(query);
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Настройки",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_SETTINGS,DIALOG_STYLE_LIST,"Настройки компьютера",COMP_SETTINGS_STRING,"Выбрать","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Вставить",inputtext))
			{
				format(query,sizeof(query),"SELECT MAX(`File`) FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder]);
				samp_mysql_query(query);
				samp_mysql_store_result();
				samp_mysql_fetch_row(result);
				format(query,sizeof(query),"UPDATE `Computers_data` SET `Folder`=%d,`File`=%d WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",Computers_Player[playerid][cCurrentFolder],(strval(result) + 1),furnitureid,Computers_Player[playerid][cCopyInfo][1],Computers_Player[playerid][cCopyInfo][2]);
				samp_mysql_query(query);
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_FILE:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ACTIONS");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			ShowPlayerModeDialog(playerid,DIALOG_COMP_ACTIONS_FILE,DIALOG_STYLE_LIST,"Действие",FILE_ACTIONS_STRING,"Выбрать","Назад");
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_NONEFILES:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_NONEFILES");
			if(!response) 
			{
				if(Computers_Player[playerid][cCurrentFolder] == COMP_FOLDER_DESKTOP)
				{
					SetPlayerAction(playerid,ACTION_NONE);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				else
				{
					format(query,sizeof(query),"SELECT `Folder` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Type`=%d AND `Content`='%d'",furnitureid,COMP_ROW_TYPE_FOLDER,Computers_Player[playerid][cCurrentFolder]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					samp_mysql_fetch_row(result);				
					Computers_Player[playerid][cCurrentFolder] = strval(result);
					ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
			}
			if(Computers_Player[playerid][cCopyInfo][0] == 0) ShowPlayerModeDialog(playerid,DIALOG_COMP_ACTIONS,DIALOG_STYLE_LIST,"Действие",FOLDER_ACTIONS_EX_STRING,"Выбрать","Назад");
			else ShowPlayerModeDialog(playerid,DIALOG_COMP_ACTIONS,DIALOG_STYLE_LIST,"Действие",FOLDER_ACTIONS_EX_STRING_COPY,"Выбрать","Назад");
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_ACTIONS_FILE:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ACTIONS_FILE");
			if(!response)
			{
				new tmp[20];
				format(query,sizeof(query),"SELECT `Content`,`Name` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder],Computers_Player[playerid][cCurrentFile]);
				samp_mysql_query(query);
				samp_mysql_store_result();
				samp_mysql_fetch_row(result);
				samp_mysql_get_field("Name",tmp);	
				samp_mysql_get_field("Content",result);
				ShowPlayerModeDialog(playerid,DIALOG_COMP_FILE,DIALOG_STYLE_MSGBOX,tmp,result,"Действие","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Редактировать",inputtext))
			{
				format(Computers_Player[playerid][cEditString],MAX_STRING,"");
				ShowPlayerModeDialog(playerid,DIALOG_COMP_FILE_EDIT,DIALOG_STYLE_INPUT,"Редактирование","\nВведите строку:","Следующая строка","Готово");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Копировать",inputtext))
			{
				Computers_Player[playerid][cCopyInfo][0] = 1;
				Computers_Player[playerid][cCopyInfo][1] = Computers_Player[playerid][cCurrentFolder];
				Computers_Player[playerid][cCopyInfo][2] = Computers_Player[playerid][cCurrentFile];
				Computers_Player[playerid][cCurrentFolder] = COMP_FOLDER_DESKTOP; // ID desktop
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
		}
		case DIALOG_COMP_ADD_FOLDER:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ADD_FOLDER");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strlen(inputtext))
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			new fileid,folderid;
			format(query,sizeof(query),"SELECT MAX(`File`) FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder]);
			samp_mysql_query(query);
			samp_mysql_store_result();
			samp_mysql_fetch_row(result);
			fileid = strval(result) + 1;
			format(query,sizeof(query),"SELECT MAX(`Content`) FROM `Computers_data` WHERE `FurnitureId`=%d AND `Type`=%d",furnitureid,COMP_ROW_TYPE_FOLDER);
			samp_mysql_query(query);
			samp_mysql_store_result();
			samp_mysql_fetch_row(result);
			folderid = strval(result) + 1;
			format(query,sizeof(query),"INSERT INTO `Computers_data` (`FurnitureId`,`Name`,`Folder`,`File`,`Type`,`Content`) VALUES (%d,'%s',%d,%d,%d,'%d')",furnitureid,inputtext,Computers_Player[playerid][cCurrentFolder],fileid,COMP_ROW_TYPE_FOLDER,folderid);
			samp_mysql_query(query);
			ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_ADD_FILE:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_ADD_FILE");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strlen(inputtext))
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			new fileid;
			format(query,sizeof(query),"SELECT MAX(`File`) FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder]);
			samp_mysql_query(query);
			samp_mysql_store_result();
			samp_mysql_fetch_row(result);
			fileid = strval(result) + 1;
			format(query,sizeof(query),"INSERT INTO `Computers_data` (`FurnitureId`,`Name`,`Folder`,`File`,`Type`) VALUES (%d,'%s',%d,%d,%d)",furnitureid,inputtext,Computers_Player[playerid][cCurrentFolder],fileid,COMP_ROW_TYPE_FILE);
			samp_mysql_query(query);
			ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_FILE_EDIT:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_FILE_EDIT");
			if(!response) 
			{
				new tmp[20];
				format(query,sizeof(query),"UPDATE `Computers_data` SET `Content`='%s' WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",Computers_Player[playerid][cEditString],furnitureid,Computers_Player[playerid][cCurrentFolder],Computers_Player[playerid][cCurrentFile]);
				samp_mysql_query(query);				
				format(query,sizeof(query),"SELECT `Content`,`Name` FROM `Computers_data` WHERE `FurnitureId`=%d AND `Folder`=%d AND `File`=%d",furnitureid,Computers_Player[playerid][cCurrentFolder],Computers_Player[playerid][cCurrentFile]);
				samp_mysql_query(query);
				samp_mysql_store_result();
				samp_mysql_fetch_row(result);
				samp_mysql_get_field("Name",tmp);	
				samp_mysql_get_field("Content",result);
				ShowPlayerModeDialog(playerid,DIALOG_COMP_FILE,DIALOG_STYLE_MSGBOX,tmp,result,"Действие","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			format(Computers_Player[playerid][cEditString],MAX_STRING,"%s%s\n",Computers_Player[playerid][cEditString],inputtext);
			format(DialogString,MAX_DIALOG_SIZE,"Введено:\n%s\n\nВведите строку:",Computers_Player[playerid][cEditString]);
			ShowPlayerModeDialog(playerid,DIALOG_COMP_FILE_EDIT,DIALOG_STYLE_INPUT,"Редактирование",DialogString,"Следующая строка","Готово");
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_SETTINGS:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_SETTINGS");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Сменить пароль",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_PASSWORD_SET,DIALOG_STYLE_INPUT,"Пароль","Введите желаемый пароль:","Готово","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
		}
		case DIALOG_COMP_PASSWORD_SET:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_PASSWORD_SET");
			if(!response) 
			{
				ShowPlayerModeDialog(playerid,DIALOG_COMP_SETTINGS,DIALOG_STYLE_LIST,"Настройки компьютера",COMP_SETTINGS_STRING,"Выбрать","Назад");
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			format(query,sizeof(query),"UPDATE `Computers` SET `Password`='%s' WHERE `FurnitureId`=%d"inputtext,,furnitureid);
			samp_mysql_query(query);
			ShowPlayerModeDialog(playerid,DIALOG_COMP_ENTER_PASSWORD,DIALOG_STYLE_INPUT,"Введите пароль","Пожалуйста введите пароль","Ок","Отмена");
			ShowHelpBoxForPlayer(playerid,HELPBOX_COMPUTER_PASSWORD,COMP_INFO_PASSWORD);
			Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_COMP_INET:
		{
			Debug(DEBUG_ACTION,"DIALOG_COMP_INET");
			if(!response) 
			{
				ShowCompFolder(furnitureid,Computers_Player[playerid][cCurrentFolder],playerid);
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("E-m@il",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,"E-m@il",EMAIL_STRING,"Выбор","Назад");
				Computers_Player[playerid][cUsingType] = USING_TYPE_STANDART;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Каталог сайтов",inputtext))
			{
				nullstr(DialogString);
				samp_mysql_query("SELECT `Address` FROM `Sites` WHERE `InCatalog`=1 ORDER BY `Address` ASC");
				samp_mysql_store_result();
				while(samp_mysql_fetch_row(result)) format(DialogString,sizeof(DialogString),"%s%s\n",DialogString,result);
				if(!DialogString[0]) 
				{
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,"Каталог сайтов","Пусто","Назад","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CATALOG_NULL;
				}
				else
				{
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_LIST,"Каталог сайтов",DialogString,"Выбор","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CATALOG_LIST;
				}
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Создать сайт",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт","Введите ваш E-m@il","Далее","Отмена");
				Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_SITE_START;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Редактировать сайт",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт","Введите адрес сайта:","Далее","Отмена");
				Computers_Player[playerid][cUsingType] = USING_TYPE_CHANGE_SITE_START;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Перейти на сайт",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Перейти на сайт","WWW:","Перейти","Отмена");
				Computers_Player[playerid][cUsingType] = USING_TYPE_GOTO_SITE;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Создать базу данных",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Создать базу данных","Введите ваш E-m@il","Далее","Отмена");
				Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_DB_START;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
			if(!strcmp("Открыть базу данных",inputtext))
			{
				ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных","Введите адрес базы данных","Далее","Отмена");
				Computers_Player[playerid][cUsingType] = USING_TYPE_OPEN_DB_START;
				Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
				return 1;
			}
		}
		case DIALOG_INET_EMAIL:
		{
			Debug(DEBUG_ACTION,"DIALOG_INET_EMAIL");
			new string[MAX_STRING];
			switch(Computers_Player[playerid][cUsingType])
			{
				case USING_TYPE_EMAIL_AUTH_LOGIN:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_EMAIL_AUTH_LOGIN");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,"E-m@il",EMAIL_STRING,"Выбор","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_STANDART;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","Введите свой логин:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEmailLogin],MAX_SMAIL_SIZE,inputtext);
					format(query,sizeof(query),"SELECT * FROM `Email_list` WHERE `Login`='%s'",Computers_Player[playerid][cEmailLogin]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","E-m@il не найден\nВведите свой логин:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(string,MAX_STRING,"%s\nВведите свой пароль:",Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_EMAIL_AUTH_PASS;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_EMAIL_AUTH_PASS:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_EMAIL_AUTH_PASS");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,"E-m@il",EMAIL_STRING,"Выбор","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_STANDART;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите свой пароль:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `Email_list` WHERE `Login`='%s' AND `Password`='%s'",Computers_Player[playerid][cEmailLogin],inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						format(string,MAX_STRING,"%s\nВведён не верный пароль\nВведите свой пароль:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					ShowMailList(playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_EMAIL_REG_LOGIN:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_EMAIL_REG_LOGIN");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,"E-m@il",EMAIL_STRING,"Выбор","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_STANDART;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","Введите желаемый логин:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(strfind(inputtext,"@mail.sa") == -1)
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","Ящик должен быть вида 123@mail.sa\nВведите желаемый логин:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEmailLogin],MAX_SMAIL_SIZE,inputtext);
					format(query,sizeof(query),"SELECT * FROM `Email_list` WHERE `Login`='%s'",Computers_Player[playerid][cEmailLogin]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","E-m@il занят\nВведите желаемый логин:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(string,MAX_STRING,"%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_EMAIL_REG_PASS;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_EMAIL_REG_PASS:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_EMAIL_REG_PASS");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,"E-m@il",EMAIL_STRING,"Выбор","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_STANDART;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"INSERT INTO `Email_list`(`Login`,`Password`) VALUES ('%s','%s')",Computers_Player[playerid][cEmailLogin],inputtext);
					samp_mysql_query(query);
					ShowMailList(playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_EMAIL_MAIL_LIST:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_EMAIL_MAIL_LIST");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(listitem == 0)
					{						
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите E-m@il получателя","Далее","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_WRITE_LETTER_LOGIN;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					Computers_Player[playerid][cTempId] = GetPlayerModeDialogListData(playerid,listitem);
					format(query,sizeof(query),"SELECT `Content` FROM `Email_letters` WHERE `Login`='%s' AND `id`=%d",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cTempId]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					samp_mysql_fetch_row(result);
					fixchars(result);
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cEmailLogin],result,"Действия","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_LETTER;	
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_LETTER:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_LETTER");
					if(!response) 
					{
						ShowMailList(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_LIST,Computers_Player[playerid][cEmailLogin],"Ответить\nУдалить","Выбрать","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_LETTER_ACTIONS;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_LETTER_ACTIONS:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_LETTER_ACTIONS");
					if(!response) 
					{
						format(query,sizeof(query),"SELECT `Content` FROM `Email_letters` WHERE `Login`='%s' AND `id`=%d",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cTempId]);
						samp_mysql_query(query);
						samp_mysql_store_result();
						samp_mysql_fetch_row(result);
						fixchars(result);
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cEmailLogin],result,"Действия","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_LETTER;	
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					switch(listitem)
					{
						case 0:
						{
							format(query,sizeof(query),"SELECT `Sender` FROM `Email_letters` WHERE `Login`='%s' AND `id`=%d",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cTempId]);
							samp_mysql_query(query);
							samp_mysql_store_result();
							samp_mysql_fetch_row(result);
							fixchars(result);							
							format(Computers_Player[playerid][cLetterTo],MAX_EMAIL_SIZE,result);
							ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите название письма:","Далее","Назад");
							Computers_Player[playerid][cUsingType] = USING_TYPE_WRITE_LETTER_NAME;
							Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
							return 1;
						}
						case 1:
						{
							format(query,sizeof(query),"DELETE FROM `Email_letters` WHERE `Login`='%s' AND `id`=%d",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cTempId]);
							samp_mysql_query(query);
							ShowMailList(playerid);
							Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
							return 1;
						}
					}
				}
				case USING_TYPE_WRITE_LETTER_LOGIN:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_WRITE_LETTER_LOGIN");
					if(!response) 
					{
						ShowMailList(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите E-m@il получателя","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cLetterTo],MAX_EMAIL_SIZE,inputtext);
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите название письма:","Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_WRITE_LETTER_NAME;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_WRITE_LETTER_NAME:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_WRITE_LETTER_NAME");
					if(!response) 
					{
						ShowMailList(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите название письма:","Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cLetterName],MAX_EMAIL_SIZE,inputtext);
					format(Computers_Player[playerid][cEditString],MAX_STRING,"");
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],"Введите текст письма:","Следующая строка","Отправить");
					Computers_Player[playerid][cUsingType] = USING_TYPE_WRITE_LETTER_CONTENT;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_WRITE_LETTER_CONTENT:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_WRITE_LETTER_CONTENT");
					if(!response) 
					{
						if(!OnEMailRecived(Computers_Player[playerid][cLetterTo],Computers_Player[playerid][cEditString],playerid))
						{
							format(query,sizeof(query),"SELECT MAX(`id`) FROM `Email_letters` WHERE `Login`='%s'",Computers_Player[playerid][cLetterTo]);
							samp_mysql_query(query);
							samp_mysql_store_result();
							samp_mysql_fetch_row(result);
							format(query,sizeof(query),"INSERT INTO `Email_letters` (`id`,`Login`,`Content`,`Sender`,`Name`) VALUES (%d,'%s','%s','%s','%s')",(strval(result) + 1),Computers_Player[playerid][cLetterTo],Computers_Player[playerid][cEditString],Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cLetterName]);
							samp_mysql_query(query);
						}
						ShowMailList(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEditString],MAX_STRING,"%s%s\n",Computers_Player[playerid][cEditString],inputtext);
					format(DialogString,MAX_DIALOG_SIZE,"Введено:\n%s\n\nВведите текст письма:",Computers_Player[playerid][cEditString]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,Computers_Player[playerid][cEmailLogin],DialogString,"Следующая строка","Отправить");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				default:
				{
					Debug(DEBUG_ACTION,"default");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strcmp("Авторизация",inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","Введите свой логин:","Далее","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_EMAIL_AUTH_LOGIN;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strcmp("Регистрация",inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_EMAIL,DIALOG_STYLE_INPUT,"E-m@il","Введите желаемый логин:","Далее","Назад");
						Computers_Player[playerid][cUsingType] = USING_TYPE_EMAIL_REG_LOGIN;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
				}
			}
		}
		case DIALOG_INET_SITE:
		{
			Debug(DEBUG_ACTION,"DIALOG_INET_SITE");
			new string[MAX_STRING];
			switch(Computers_Player[playerid][cUsingType])
			{
				case USING_TYPE_CATALOG_NULL:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CATALOG_NULL");
					ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CATALOG_LIST:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CATALOG_LIST");
					if(!response)
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cSiteAddress],MAX_SITE_SIZE,inputtext);
					format(query,sizeof(query),"SELECT `Content` FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					samp_mysql_fetch_row(result);
					fixchars(result);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cSiteAddress],result,"Действия","Выход");
					Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_CONTENT;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_SITE_CONTENT:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_SITE_CONTENT");
					if(!response)
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_LIST,Computers_Player[playerid][cSiteAddress],SITE_ACTIONS_STRING,"Действия","Выход");
					Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_ACTIONS;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_SITE_ACTIONS:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_SITE_ACTIONS");
					if(!response)
					{
						format(query,sizeof(query),"SELECT `Content` FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
						samp_mysql_query(query);
						samp_mysql_store_result();
						samp_mysql_fetch_row(result);
						fixchars(result);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cSiteAddress],result,"Действия","Выход");
						Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_CONTENT;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strcmp("Связь с администратором",inputtext))
					{
						format(Computers_Player[playerid][cEditString],MAX_STRING,"");
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,Computers_Player[playerid][cSiteAddress],"Введите текст письма:","Следующая строка","Отправить");
						Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_WRITE_LETTER;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
				}
				case USING_TYPE_SITE_WRITE_LETTER:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_SITE_WRITE_LETTER");
					if(!response) 
					{
						format(query,sizeof(query),"SELECT `EMail` FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
						samp_mysql_query(query);
						samp_mysql_store_result();
						samp_mysql_fetch_row(Computers_Player[playerid][cLetterTo]);
						if(!OnEMailRecived(Computers_Player[playerid][cLetterTo],Computers_Player[playerid][cEditString],playerid))
						{
							format(query,sizeof(query),"SELECT MAX(`id`) FROM `Email_letters` WHERE `Login`='%s'",Computers_Player[playerid][cLetterTo]);
							samp_mysql_query(query);
							samp_mysql_store_result();
							samp_mysql_fetch_row(result);
							format(query,sizeof(query),"INSERT INTO `Email_letters` (`id`,`Login`,`Content`,`Sender`,`Name`) VALUES (%d,'%s','%s','%s','Письмо пользователя сайта')",(strval(result) + 1),Computers_Player[playerid][cLetterTo],Computers_Player[playerid][cEditString],Computers_Player[playerid][cSiteAddress]);
							samp_mysql_query(query);
						}
						format(query,sizeof(query),"SELECT `Content` FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
						samp_mysql_query(query);
						samp_mysql_store_result();
						samp_mysql_fetch_row(result);
						fixchars(result);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cSiteAddress],result,"Действия","Выход");
						Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_CONTENT;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEditString],MAX_STRING,"%s%s\n",Computers_Player[playerid][cEditString],inputtext);
					format(DialogString,MAX_DIALOG_SIZE,"Введено:\n%s\n\nВведите текст письма:",Computers_Player[playerid][cEditString]);					
					format(string,sizeof(string),"www.%s.sa",Computers_Player[playerid][cSiteAddress]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,string,DialogString,"Следующая строка","Отправить");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_SITE_START:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_SITE_START");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт","Введите ваш E-m@il","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `Email_list` WHERE `Login`='%s'",inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт","Введённый E-m@il не существует\nВведите ваш E-m@il","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEmailLogin],MAX_EMAIL_SIZE,inputtext);
					format(string,MAX_STRING,"%s\nВведите желаемый адрес:",Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_SITE_STEP_2;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_SITE_STEP_2:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_SITE_STEP_2");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите желаемый адрес:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if((strfind(inputtext,"www.") == -1) || (strfind(inputtext,".sa") == -1))
					{
						format(string,MAX_STRING,"%s\nАдрес должен быть вида www.123.sa\nВведите желаемый адрес:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}					
					format(Computers_Player[playerid][cSiteAddress],MAX_SITE_SIZE,inputtext);
					format(query,sizeof(query),"SELECT * FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(samp_mysql_fetch_row(result))
					{
						format(string,MAX_STRING,"%s\nВведённый адрес занят\nВведите желаемый адрес:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(string,MAX_STRING,"%s\n%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cSiteAddress]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_SITE_STEP_3;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_SITE_STEP_3:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_SITE_STEP_3");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\n%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cSiteAddress]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Создать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEditString],MAX_STRING,"%s",inputtext);
					format(string,MAX_STRING,"%s\n%s\n%s\nОтображать сайт в каталоге?",Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEditString]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,"Создать сайт",string,"Да","Нет");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_SITE_STEP_4;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_SITE_STEP_4:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_SITE_STEP_4");
					if(!response) format(query,sizeof(query),"INSERT INTO `Sites`(`Address`,`EMail`,`Password`,`InCatalog`) VALUES ('%s','%s','%s',0)",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cEditString]);
					else format(query,sizeof(query),"INSERT INTO `Sites`(`Address`,`EMail`,`Password`,`InCatalog`) VALUES ('%s','%s','%s',1)",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin],Computers_Player[playerid][cEditString]);
					samp_mysql_query(query);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,"Создать сайт","Сайт успешно создан","Выход","Выход");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CATALOG_NULL;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CHANGE_SITE_START:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CHANGE_SITE_START");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт","Введите адрес сайта:","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cSiteAddress],MAX_SITE_SIZE,inputtext);
					format(query,sizeof(query),"SELECT * FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт","Данный сайт не существует\nВведите адрес сайта:","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(string,MAX_STRING,"%s\nВведите логин(e-m@il):",Computers_Player[playerid][cSiteAddress]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CHANGE_SITE_STEP_2;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CHANGE_SITE_STEP_2:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CHANGE_SITE_STEP_2");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите логин(e-m@il):",Computers_Player[playerid][cSiteAddress]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEmailLogin],MAX_EMAIL_SIZE,inputtext);
					format(query,sizeof(query),"SELECT * FROM `Sites` WHERE `Address`='%s' AND `EMail`='%s'",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						format(string,MAX_STRING,"%s\nНеверный логин!\nВведите логин(e-m@il):",Computers_Player[playerid][cSiteAddress]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(string,MAX_STRING,"%s\n%s\nВведите пароль:",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CHANGE_SITE_STEP_3;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CHANGE_SITE_STEP_3:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CHANGE_SITE_STEP_3");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\n%s\nВведите пароль:",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `Sites` WHERE `Address`='%s' AND `EMail`='%s' AND `Password`='%s'",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin],inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						format(string,MAX_STRING,"%s\n%s\nНеверный пароль!\nВведите пароль:",Computers_Player[playerid][cSiteAddress],Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(ExistModeProperty(MODE_PROPERTY_FURNITURE_COMP,playerid,0)) DeleteModeProperty(MODE_PROPERTY_FURNITURE_COMP",playerid,0);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт","Введите строку:","Следующая строка","Готово");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CHANGE_SITE_STEP_4;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CHANGE_SITE_STEP_4:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CHANGE_SITE_STEP_4");
					if(!response) 
					{
						format(query,sizeof(query),"UPDATE `Sites` SET `Content`='%s' WHERE `Address`=%d",GetModePropertyStr(MODE_PROPERTY_FURNITURE_COMP,playerid,0),Computers_Player[playerid][cSiteAddress]);
						samp_mysql_query(query);				
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(DialogString,MAX_DIALOG_SIZE,"%s%s\n",GetModePropertyStr(MODE_PROPERTY_FURNITURE_COMP,playerid,0),inputtext);
					SetModePropertyStr(MODE_PROPERTY_FURNITURE_COMP,playerid,0,DialogString);
					format(DialogString,MAX_DIALOG_SIZE,"Введено:\n%s\n\nВведите строку:",DialogString);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Редактировать сайт",DialogString,"Следующая строка","Готово");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}				
				case USING_TYPE_GOTO_SITE:
				{
					if(!response)
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cSiteAddress],MAX_SITE_SIZE,inputtext);
					format(query,sizeof(query),"SELECT `Content` FROM `Sites` WHERE `Address`='%s'",Computers_Player[playerid][cSiteAddress]);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_INPUT,"Перейти на сайт","Сайт не найден\nWWW:","Перейти","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					fixchars(result);
					ShowPlayerModeDialog(playerid,DIALOG_INET_SITE,DIALOG_STYLE_MSGBOX,Computers_Player[playerid][cSiteAddress],result,"Действия","Выход");
					Computers_Player[playerid][cUsingType] = USING_TYPE_SITE_CONTENT;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
			}
		}
		case DIALOG_INET_DB:
		{
			Debug(DEBUG_ACTION,"DIALOG_INET_DB");
			new string[MAX_STRING];
			switch(Computers_Player[playerid][cUsingType])
			{
				case USING_TYPE_DB_NULL:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_DB_NULL");
					ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_DB_START:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_SITE_START");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Создать базу данных","Введите ваш E-m@il","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `Email_list` WHERE `Login`='%s'",inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Создать базу данных","Введённый e-m@il не существует\nВведите ваш E-m@il","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cEmailLogin],MAX_EMAIL_SIZE,inputtext);
					format(string,MAX_STRING,"%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Создать базу данных",string,"Далее","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_CREATE_DB_STEP_2;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_CREATE_DB_STEP_2:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_CREATE_DB_STEP_2");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите желаемый пароль:",Computers_Player[playerid][cEmailLogin]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Создать базу данных",string,"Далее","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					new ip[MAX_DB_SIZE];
					format(ip,sizeof(ip),"%d.%d.%d.%d",(random(27) + 100),(random(27) + 100),(random(27) + 100),(random(27) + 100));
					format(query,sizeof(query),"SELECT * FROM `DataBases` WHERE `Address`='%s'",ip);
					samp_mysql_query(query);
					samp_mysql_store_result();
					while(samp_mysql_fetch_row(result))
					{
						format(ip,sizeof(ip),"%d.%d.%d.%d",(random(27) + 100),(random(27) + 100),(random(27) + 100),(random(27) + 100));
						format(query,sizeof(query),"SELECT * FROM `DataBases` WHERE `Address`='%s'",ip);
						samp_mysql_query(query);
						samp_mysql_store_result();
					}
					format(query,sizeof(query),"INSERT INTO `DataBases` (`EMail`,`Address`,`Password`) VALUES ('%s','%s','%s')",Computers_Player[playerid][cEmailLogin],ip,inputtext);
					samp_mysql_query(query);
					format(string,MAX_STRING,"База данных создана\nИнформация для подключения:\nIP: %s\nPassword: %s\nИнформация для изменение вручную:\nE-m@il: %s\n",ip,inputtext,Computers_Player[playerid][cEmailLogin]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_MSGBOX,"Создать базу данных",string,"Готово","Назад");
					Computers_Player[playerid][cUsingType] = USING_TYPE_DB_NULL;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_OPEN_DB_START:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_OPEN_DB_START");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных","Введите адрес базы данных","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `DataBases` WHERE `Address`='%s'",inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных","Введёный адрес базы данных не действителен\nВведите адрес базы данных","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(Computers_Player[playerid][cDBAddress],MAX_DB_SIZE,inputtext);
					format(string,MAX_STRING,"%s\nВведите email:",Computers_Player[playerid][cDBAddress]);
					ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных",string,"Далее","Отмена");
					Computers_Player[playerid][cUsingType] = USING_TYPE_OPEN_DB_STEP_2;
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_OPEN_DB_STEP_2:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_OPEN_DB_STEP_2");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strlen(inputtext))
					{
						format(string,MAX_STRING,"%s\nВведите email:",Computers_Player[playerid][cDBAddress]);
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных",string,"Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"SELECT * FROM `DataBases` WHERE `Address`='%s' AND `EMail`='%s'",Computers_Player[playerid][cDBAddress],inputtext);
					samp_mysql_query(query);
					samp_mysql_store_result();
					if(!samp_mysql_fetch_row(result))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,"Открыть базу данных","Введёный email не верен\nВведите email базы данных","Далее","Отмена");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					ShowDBContent(playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_DB_LIST:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_DB_LIST");
					if(!response) 
					{
						ShowPlayerModeDialog(playerid,DIALOG_COMP_INET,DIALOG_STYLE_LIST,"Интернет",INTERNET_STRING,"Выбор","Назад");
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					Computers_Player[playerid][cTempId] = GetPlayerModeDialogListData(playerid,listitem);
					ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_LIST,Computers_Player[playerid][cDBAddress],DB_ACTIONS_STRING,"Выбрать","Отмена");
					Computers_Player[playerid][cUsingType] = USING_TYPE_DB_ACTIONS;			
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
				case USING_TYPE_DB_ACTIONS:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_DB_ACTIONS");
					if(!response) 
					{
						ShowDBContent(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strcmp("Удалить запись",inputtext))
					{
						format(query,sizeof(query),"DELETE FROM `DataBases_data` WHERE `Address`='%s' AND `id`=%d",Computers_Player[playerid][cDBAddress],Computers_Player[playerid][cTempId]);
						samp_mysql_query(query);
						ShowDBContent(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					if(!strcmp("Изменить запись",inputtext))
					{
						ShowPlayerModeDialog(playerid,DIALOG_INET_DB,DIALOG_STYLE_INPUT,Computers_Player[playerid][cSiteAddress],"Введите новое значение:","Готово","Отмена");
						Computers_Player[playerid][cUsingType] = USING_TYPE_DB_CHANGE_VALUE;
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
				}
				case USING_TYPE_DB_CHANGE_VALUE:
				{
					Debug(DEBUG_ACTION,"USING_TYPE_DB_CHANGE_VALUE");
					if(!response) 
					{
						ShowDBContent(playerid);
						Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
						return 1;
					}
					format(query,sizeof(query),"UPDATE `DataBases_data` SET `Value`=%d WHERE `Address`='%s' AND `id`=%d",strval(inputtext),Computers_Player[playerid][cDBAddress],Computers_Player[playerid][cTempId]);
					samp_mysql_query(query);
					ShowDBContent(playerid);
					Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
					return 1;
				}
			}
		}
	}
	Debug(DEBUG_END,"Comp_OnFurnitureDialogResponse(reason: complete)");
	return 0;
}

Comp_OnFurnitureDeath(furnitureid,type,modeobjectid)
{
	Debug(DEBUG_START,"Comp_OnFurnitureDeath(%d,%d,%d)",furnitureid,type,modeobjectid);
	if(type != FURNITURE_TYPE_COMPUTER) {Debug(DEBUG_END,"Comp_OnFurnitureDeath(reason: its not computer)");return 0;}
	format(query,sizeof(query),"DELETE FROM `Computers` WHERE `FurnitureId`=%d",furnitureid);
	samp_mysql_query(query);
	format(query,sizeof(query),"DELETE FROM `Computers_data` WHERE `FurnitureId`=%d",furnitureid);
	samp_mysql_query(query);
	Debug(DEBUG_END,"Comp_OnFurnitureDeath(reason: complete)");
	return 1;
}

Comp_OnFurnitureCreated(furnitureid,type,modeobjectid)
{
	Debug(DEBUG_START,"Comp_OnFurnitureCreated(%d,%d,%d)",furnitureid,type,modeobjectid);
	if(type != FURNITURE_TYPE_COMPUTER) {Debug(DEBUG_END,"Comp_OnFurnitureCreated(reason: its not computer)");return 0;}
	format(query,sizeof(query),"INSERT INTO `Computers` (`FurnitureId`) VALUES (%d)",furnitureid);
	samp_mysql_query(query);
	format(query,sizeof(query),"INSERT INTO `Computers_data` (`FurnitureId`,`Name`,`Folder`,`File`,`Type`,`Content`) VALUES (%d,'Рабочий стол',-1,-1,%d,'%d')",furnitureid,COMP_ROW_TYPE_FOLDER,COMP_FOLDER_DESKTOP);
	samp_mysql_query(query);
	format(query,sizeof(query),"INSERT INTO `Computers_data` (`FurnitureId`,`Name`,`Folder`,`File`,`Type`) VALUES (%d,'Internet',%d,0,%d,%d)",furnitureid,COMP_FOLDER_DESKTOP,COMP_ROW_TYPE_FOLDER);
	samp_mysql_query(query);
	Debug(DEBUG_END,"Comp_OnFurnitureCreated(reason: complete)");
	return 1;
}
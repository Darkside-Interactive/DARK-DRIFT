
Dialog:Welcome ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) // Далее
	{
		if ( GetPVarInt ( playerid, "Page" ) < 4 ) SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) + 1 ) ;
	}
	else // Назад
	{
		if ( GetPVarInt ( playerid, "Page" ) == 0 )
			SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) + 1 ) ;
		else
			SetPVarInt ( playerid, "Page", GetPVarInt ( playerid, "Page" ) - 1 ) ;
	}
	
	new dialog [ 1250 ] ;
	
	switch ( GetPVarInt ( playerid, "Page" ) )
	{
		case 0: 
		{
			new DialogPage1 [ 10 ] [ ] = 
			{
				{"{FFFFFF}Здравствуй дорогой друг, на нашем сервере установлен {FF0000}RolePlay {FFFFFF}режим!\n"},
				{"{FFFFFF}Убедительная просьба прочитать эту инструкцию, она поможет тебе при регистрации!\n\n"},
				{"\t\t\t\t{64AA96}1. Логин, Никнейм\n\n"},
				{"{FFFFFF}Это Имя_Фамилия твоего персонажа. Оно может быть вымышленным, или же\n совпадать с твоим именем, все зависит от твоей фантазии.\n\n"},
				{"\t\t\tПравильные и неправильные примеры:\n\n"},
				{"\t{009B00}Pavel_Volkov - правильно\t\t{FF0000}Pashok_Volkov - неправильно\n"},
				{"\t{009B00}Jason_Statham - правильно\t\t{FF0000}Super_Man - неправильно\n"},
				{"\t{009B00}Alexey_Morozov - правильно\t{FF0000}Leha_Moroz - неправильно\n\n"},
				{"\t\t\t{64AA96}2. Role Play (РП, Ролевая игра, РПинг)\n\n"},
				{"{FFFFFF}RP - это отыгрывание роли твоего персонажа в игре. Его действий, мыслей,\n поступков. Отыгрывая, ты должен придерживаться роли своего персонажа.\n Роль может быть любая, все зависит от твоего выбора и фантазии."}
			};
		
			for ( new i = 0; i < sizeof ( DialogPage1 ) ; i++ )  strcat ( dialog, DialogPage1 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}Основы RolePlay игры!", dialog, "Далее", "" ) ;
		}
		case 1:
		{
			new DialogPage2 [ 14 ] [ ] = 
			{
				{"\t\t\t\t{64AA96}3. Основные команды в Role Play\n\n"},
				{"{FF0000}/я (/me) {FFFFFF}- Описывает действия твоего персонажа. Если используешь несколько\n действий в одной команде, то соблюдай пунктуацию. В конце ставь точку.\n\n"},
				{"\t\t\tПравильные и неправильные примеры:\n\n"},
				{"{FFFFFF}Пишем - {009B00}/я сунув руку в карман, достал из него зажигалку - правильно.\n"},
				{"{FFFFFF}Получаем - {C8A0D7}* Alex Jones сунув руку в карман, достал из него зажигалку.\n"},
				{"{FFFFFF}Пишем - {FF0000}/я Крутой - неправильно!\n\n"},
				{"{FF0000}/до (/do) {FFFFFF}- Описывает ситуацию от третьего лица. Первая буква Заглавная, в конце точка.\n\n"},
				{"\t\t\t\tПравильные примеры:\n"},
				{"{FFFFFF}Пишем - {009B00}/до Металическая зажигалка, с символом орла, в правой руке.\n"},
				{"{FFFFFF}Получаем - {C8A0D7}* (( Alex Jones[21] )) Металическая зажигалка, с символом орла, в правой руке.\n\n"},
				{"{FF0000}/тру (/try) {FFFFFF}- То же, что и {FF0000}/я (/me) {FFFFFF}, но используется, когда исход события\n заранее неизвестен 	(попытка чего либо). Используется к неодушевленным предметам.\n"},
				{"{FFFFFF}Пишем - {009B00}/тру поднять тяжелый камень с земли\n"},
				{"{FFFFFF}Получаем - {C8A0D7}*** Alex Jones попытался поднять тяжелый камень с земли и у него получилось.\n"},
				{"{FFFFFF}Или - {C8A0D7}*** Alex Jones пытается поднять тяжелый камень с земли, но ничего не получается.\n"}
			};
					
			for ( new i = 0; i < sizeof ( DialogPage2 ) ; i++ )  strcat ( dialog, DialogPage2 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}Основы RolePlay игры!", dialog, "Назад", "Далее" ) ;
		}
		case 2: 
		{
			new DialogPage3 [ 7 ] [ ] = 
			{
				{"\t\t\t\t\t{64AA96}4. Чаты, и все что к ним относится.\n\n"},
				{"{FFFFFF}1. IC (In Character) - Это информация, которой владеет твой персонаж. В IC чат нужно писать\n только то, что относится к Ролевой Игре, то что знает твой персонаж. Запрещенно писать\n капсом, смайлы, чрезмерно использовать восклицательные и вопросительные знаки. Разрешенно\n использовать -действия-, -ВЫДЕЛЕНИЕ- слов, *интонацию голоса*. Смотрим примеры.\n\n"},
				{"Alex Jones[16] говорит: Вон за -ТЕМ- углом магазин -показывая пальцем-\n"},
				{"Alex Jones[16] говорит: *кричя* Гони бабки, или я тебе бошку прострелю! -приставляя к виску пистолет-\n\n"},
				{"2. OOC (Out Of Character) - Это информация которой владеешь ты, и которая не относится к персонажу.\nВ этом чате можно общаться на любые темы, соблюдая правила приличия.\n Но не стоит его часто использовать. Команда для ООС чата {FF0000}/б (/b)\n\n"},
				{"{FFFFFF}3. MG (MetaGaming, OOC in IC) - Это использование ООС информации в IC целях. Запрещено,\n и наказуемо, от блокировки чата до блокировки акаунта.\n\n"},
				{"\t\t\t{64AA96}Более подробную информацию ты можешь узнать на нашем сайте\n"}
			};
			
			for ( new i = 0; i < sizeof ( DialogPage3 ) ; i++ )  strcat ( dialog, DialogPage3 [ i ] ) ;
			ShowDialog ( playerid, Show:Welcome, DIALOG_STYLE_MSGBOX, "{FFFFFF}Основы RolePlay игры!", dialog, "Назад", "Далее" ) ;
		}
		case 3: 
		{
			DeletePVar ( playerid, "Page" ) ;
			ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.", "Ввести", "" ) ;
		}
	}
	return 1;
}

Dialog:Mail ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.", "Ввести", "" ) ;
	
	if ( !IsValidEmail ( inputtext ) ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.\n{FF0000}Неверный формат E-Mail адреса!", "Ввести", "" ) ;
	
	SetPVarString ( playerid, "EMail", inputtext ) ;
	
	new query [ 128 ] ;
	echo ( query, "SELECT `mail` FROM `players` WHERE `mail` = '%s' LIMIT 1", inputtext ) ;
	mysql_function_query ( dbHandle, query, true, "CheckEMail", "ii", playerid, 0 ) ;
	
	return 1;
}

Dialog:MailAccept ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.", "Ввести", "" ) ;
	
	new email [ 64 ] ;
	GetPVarString ( playerid, "EMail", email, 64 ) ;
	
	new query [ 128 ] ;
	echo ( query, "SELECT * FROM `mails` WHERE `mail` = '%s' AND `key` = '%s' LIMIT 1", email, inputtext ) ;
	mysql_function_query ( dbHandle, query, true, "CheckEMailKey", "i", playerid ) ;
	
	return 1;
}

Dialog:Sex ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.", "Ввести", "" ) ;
	
	SetPVarInt ( playerid, "Sex", listitem ) ;
	
	SetTimerEx ( "ShowModelSelectionMenuDelay", 500, 0, "i", playerid ) ;
	
	return 1;
}

forward ShowModelSelectionMenuDelay ( playerid ) ;
public ShowModelSelectionMenuDelay ( playerid ) {
	return ShowModelSelectionMenu ( playerid, GetPVarInt ( playerid, "Sex" ), "B‘ЂOP CK…мA" ) ;
}

Dialog:Password ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowModelSelectionMenu ( playerid, RegSkins [ GetPVarInt ( playerid, "Sex" ) ], "B‘ЂOP CK…мA" ) ;
	
	if ( strlen ( inputtext ) < 6 || strlen ( inputtext ) > 32 ) return ShowDialog ( playerid, Show:Password, DIALOG_STYLE_INPUT, "{FFFFFF}Пароль акаунта", "Введи пароль для акаунта.\n{FF0000}От 6 до 32 символов.\nДопустимы любые символы.", "Ввести", "Назад" ) ;
	
	SetPVarString ( playerid, "InputText", inputtext ) ;
	
	new email [ 64 ] ;
	GetPVarString ( playerid, "EMail", email, 64 ) ;
	
	new string [ 444 ] ;
	
	echo ( string, 
	"\n-------------------------------------------------------------------------------------------\n\
	Логин:                  \t\t  %s \n\
	E-Mail адрес:     \t\t  %s \n\
	Выбраный пол:     \t\t  %s \n\
	Выбраный скин:    \t\t  #%d \n\
	Введеный пароль:  \t\t  %s \n\
	\n-------------------------------------------------------------------------------------------\n", 
	PlayerName [ playerid ],
	email,
	StatSex [ GetPVarInt ( playerid, "Sex" ) ], 
	GetPVarInt ( playerid, "Skin" ),
	inputtext ) ;
	
	ShowDialog ( playerid, Show:Register, DIALOG_STYLE_MSGBOX, "{FFFFFF}Подтверждение", string, "Верно", "Сначала" ) ;
	
	return 1;
}

Dialog:Register ( playerid, response, listitem, inputtext[] )
{
	if ( !response ) return ShowDialog ( playerid, Show:Mail, DIALOG_STYLE_INPUT, "{FFFFFF}Введи E-Mail", "Введи свой действующий E-Mail адрес\n\nВНИМАНИЕ! На него придет регистрационый код.", "Ввести", "" ) ;
	
	new query [ 60 + MAX_PLAYER_NAME ] ;
	echo ( query, "SELECT `id` FROM `players` WHERE `name` = '%s' LIMIT 1", PlayerName [ playerid ] ) ;
	mysql_function_query ( dbHandle, query, true, "CheckPlayerRegistered", "ii", playerid, 1 ) ;
	
	return 1;
}

Dialog:Login ( playerid, response, listitem, inputtext[] )
{
	new query [ 512 ], temp [ 128 ] ;
	
	if ( strlen ( inputtext ) < 6 )
	{
		echo   ( query, "{FFFFFF}---------------------------------------------------------------------\n\n" ) ;
		strcat ( query, "Добро пожаловать на {33AAFF}"NAME_SERVER"\n\n" ) ;
		echo   ( temp,	"{FFFFFF}Логин {33AAFF}%s {FFFFFF}зарегистрирован\n\n", PlayerName [ playerid ] ) ;
		strcat ( query, temp ) ;
		strcat ( query, "Введи пароль {FF0000}(мин. 6 симв.)\n\n" ) ;
		strcat ( query, "{FFFFFF}---------------------------------------------------------------------\n" ) ;

		ShowDialog ( playerid, Show:Login, DIALOG_STYLE_PASSWORD, "{FFFFFF}Авторизация", query, "Ввести", "" ) ;
	}
	else
	{
		mysql_real_escape_string ( inputtext, temp ) ;
		echo ( query, "SELECT * FROM `players` WHERE `name` = '%s' AND `password` = MD5('%s') LIMIT 1", PlayerName [ playerid ] , temp ) ;
		mysql_function_query ( dbHandle, query, true, "PlayerLogin", "i", playerid ) ;
	}
	return 1;
}


/*Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}


Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}


Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}

Dialog: ( playerid, response, listitem, inputtext[] )
{
	
	return 1;
}
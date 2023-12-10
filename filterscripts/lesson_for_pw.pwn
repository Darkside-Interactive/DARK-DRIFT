#include <a_samp>
#include <Pawn.CMD>
#include <a_mysql>
#include <TOTP>
#include <dc_cmd>


enum pInfo{
	googleAuth, 
	googleAuthCode	
}
new player[MAX_PLAYERS][pInfo];

new googleGeratePass[17];

new symbolsForGoogleAuth[32][] = {
	"A", "B", "C", "D", "E", "F", "G",
	"H", "I", "J", "K", "L", "M", "N",
	"O", "P", "Q", "R", "S", "T", "U",
	"V", "W", "X", "Y","Z","2", "3",
	"4", "5", "6", "7"
};

cmd:protect(playerid){

	if(player[playerid][googleAuth] == 1) // Проверяем‚ подключена защита или нет
		return SendClientMessage(playerid, -1, !"Защита уже активирована!");

	ShowPlayerDialog(playerid, ВАШ_ИД, DIALOG_STYLE_MSGBOX, !" ", !"Нажмите 'Далее' для подключения защиты", !"Далее", !"Закрыть");

}

stock DialogGenerateGoogleAuthCode(playerid){

	player[playerid][googleAuthCode] = EOS; // Чистим переменную
	googleGeratePass[0] = EOS; // Чистим переменную

    for(new i = 0; i < 17; i ++) // Генерируем нужный нам код для приложения
		strcat(googleGeratePass, symbolsForGoogleAuth[random(sizeof(symbolsForGoogleAuth))]);

	// Дальше просто форматируем данные и записываем их в базу
    static
		fmt_mysql[] = "UPDATE `accounts` SET `GoogleAuthCode` = '%s' WHERE `name` = '%s'";

    new
		mysql[sizeof(fmt_mysql)-4+MAX_PLAYER_NAME+20+1];
		playername[MAX_PLAYER_NAME];

	GetPlayerName(playerid, playername, sizeof(playername)); // Получаем никнейм игрока
    strmid(player[playerid][googleAuthCode], googleGeratePass, 0, strlen(googleGeratePass), 21);
    mysql_format(mysqlHandle, mysql, sizeof(mysql), fmt_mysql, googleGeratePass, playername);
    mysql_function_query(mysqlHandle, mysql, false, "", "");

    DialogGenerateGoogle(playerid); 

}
stock DialogGenerateGoogle(playerid){
	// Дальше после этого необходимо открыть на телефоне приложение Google Authenticator
    // И добавить туда код, который будет выведем в этом диалоге
	static const
		fmt_dialog[] = "Ваш ключ: %s\nВведите его в приложение Google Authenticator";
	new 
		dialog[sizeof(fmt_dialog)-2+21];

	format(dialog, sizeof(dialog), fmt_dialog, googleGeratePass);
	ShowPlayerDialog(playerid, ВАШ_ИД_2, DIALOG_STYLE_INPUT, !" ", dialog, !"Далее", !"Закрыть");
	return 1;

}
switch(dialogid){

	case ВАШ_ИД”:{
		if(response) return DialogGenerateGoogleAuthCode(playerid);
	    else return 1;
	}
	case ВАШ_ИД_2:{
		// Дальше необходимо будет ввести код из приложения в данный диалог и если вы ввели правильным код
        // Защита активируется
	    if(response)
		{
		    if(!strlen(inputtext))
			{
				SendClientMessage(playerid, -1, !"Вы ничего не ввели");
				DialogGenerateGoogleAuthCode(playerid);
				return true;
			}
    		new
				checkGoogleAuth = GoogleAuthenticatorCode(player[playerid][googleAuthCode], gettime());

		    if(strval(inputtext) != checkGoogleAuth)
			{
				SendClientMessage(playerid, -1, !"Пароли не совпадают!");
				DialogGenerateGoogle(playerid);
				return true;
			}
		    else
			{
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !" ", !"Вы активировали Google Authenticator", !"Закрыть", !"");

				// Массив googleAuth приравниваем к 1 и сохраняем его,
                // чтобы запретить активировать защиту ещё раз, когда она уже активна
				player[playerid][googleAuth] = 1;
				static 
					fmt_mysql[] = "UPDATE `accounts` SET `GoogleAuth` = '%d' WHERE `name` = '%s'";

				new
					mysql[sizeof(fmt_mysql)-4+1+MAX_PLAYER_NAME];

				mysql_format(mysqlHandle, mysql, sizeof(mysql), fmt_mysql, player[playerid][googleAuth], PlayerName(playerid));
				mysql_function_query(mysqlHandle, mysql, false, "", "");
			}
		}

	}
	case ВАШ_ИД_3:{
	    if(response)
		{
			if(!strlen(inputtext))
			{
				SendClientMessage(playerid, -1, !"Вы ничего не ввели");
				GoogleAuthenticator_Login(playerid);
				return 1;
			}

    		new
				checkGoogleAuth = GoogleAuthenticatorCode(player[playerid][pgoogleAuthCode], gettime());

		    if(strval(inputtext) != checkGoogleAuth)
			{
				SendClientMessage(playerid, -1, !"Вы ввели неверный данные! Ваши пароли не совпадают!");
				GoogleAuthenticator_Login(playerid);
				return 1;
			}
		    else
		 	{
				SendClientMessage(playerid, -1, !"Отлично! Введёные Вам данные совпадают, Вы можете продолжить авторизацию.");
				DialogLogin(playerid); // Вместо этого вызывайте Ваш диалог авторизации
			}
		}
		else return Kick(playerid);
	}
}

// Куда нибудь при подключении, перед авторизацией
if(player[playerid][googleAuth] == 1)// Проверяем на наличие активации защиты
{
	GoogleAuthenticator_Login(playerid);// Вызываем сток, который объявили ранее, чтобы показать диалог о вводе кода
	return true;
}
else return DialogLogin(playerid);// Если googleAuth не будет равна 1, будет показана обычная авторизация. Вместо стока DialogLogin вызывайте Ваш диалог об авторизации

stock GoogleAuthenticator_Login(playerid)
{
	ShowPlayerDialog(playerid, Р’РђРЁ_РР”_3, DIALOG_STYLE_INPUT, !" ", !"\
	Чтобы начать авторизацию откройте приложение Google Authenticator\n\
    и введите в поле ниже сгенерированный 6-ти значный код из приложения:", !"Далее", !"Выход");
	return 1;
}

cache_get_field_content(0, "GoogleAuthCode", player[playerid][googleAuthCode], mysqlHandle, 20+1);
player[playerid][googleAuth] = cache_get_field_content_int(0, "GoogleAuth");

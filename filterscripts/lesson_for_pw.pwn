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

	if(player[playerid][googleAuth] == 1) // ��������� ���������� ������ ��� ���
		return SendClientMessage(playerid, -1, !"������ ��� ������������!");

	ShowPlayerDialog(playerid, ���_��, DIALOG_STYLE_MSGBOX, !" ", !"������� '�����' ��� ����������� ������", !"�����", !"�������");

}

stock DialogGenerateGoogleAuthCode(playerid){

	player[playerid][googleAuthCode] = EOS; // ������ ����������
	googleGeratePass[0] = EOS; // ������ ����������

    for(new i = 0; i < 17; i ++) // ���������� ������ ��� ��� ��� ����������
		strcat(googleGeratePass, symbolsForGoogleAuth[random(sizeof(symbolsForGoogleAuth))]);

	// ������ ������ ����������� ������ � ���������� �� � ����
    static
		fmt_mysql[] = "UPDATE `accounts` SET `GoogleAuthCode` = '%s' WHERE `name` = '%s'";

    new
		mysql[sizeof(fmt_mysql)-4+MAX_PLAYER_NAME+20+1];
		playername[MAX_PLAYER_NAME];

	GetPlayerName(playerid, playername, sizeof(playername)); // �������� ������� ������
    strmid(player[playerid][googleAuthCode], googleGeratePass, 0, strlen(googleGeratePass), 21);
    mysql_format(mysqlHandle, mysql, sizeof(mysql), fmt_mysql, googleGeratePass, playername);
    mysql_function_query(mysqlHandle, mysql, false, "", "");

    DialogGenerateGoogle(playerid); 

}
stock DialogGenerateGoogle(playerid){
	// ������ ����� ����� ���������� ������� �� �������� ���������� Google Authenticator
    // � �������� ���� ���, ������� ����� ������� � ���� �������
	static const
		fmt_dialog[] = "��� ����: %s\n������� ��� � ���������� Google Authenticator";
	new 
		dialog[sizeof(fmt_dialog)-2+21];

	format(dialog, sizeof(dialog), fmt_dialog, googleGeratePass);
	ShowPlayerDialog(playerid, ���_��_2, DIALOG_STYLE_INPUT, !" ", dialog, !"�����", !"�������");
	return 1;

}
switch(dialogid){

	case ���_�Ĕ:{
		if(response) return DialogGenerateGoogleAuthCode(playerid);
	    else return 1;
	}
	case ���_��_2:{
		// ������ ���������� ����� ������ ��� �� ���������� � ������ ������ � ���� �� ����� ���������� ���
        // ������ ������������
	    if(response)
		{
		    if(!strlen(inputtext))
			{
				SendClientMessage(playerid, -1, !"�� ������ �� �����");
				DialogGenerateGoogleAuthCode(playerid);
				return true;
			}
    		new
				checkGoogleAuth = GoogleAuthenticatorCode(player[playerid][googleAuthCode], gettime());

		    if(strval(inputtext) != checkGoogleAuth)
			{
				SendClientMessage(playerid, -1, !"������ �� ���������!");
				DialogGenerateGoogle(playerid);
				return true;
			}
		    else
			{
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !" ", !"�� ������������ Google Authenticator", !"�������", !"");

				// ������ googleAuth ������������ � 1 � ��������� ���,
                // ����� ��������� ������������ ������ ��� ���, ����� ��� ��� �������
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
	case ���_��_3:{
	    if(response)
		{
			if(!strlen(inputtext))
			{
				SendClientMessage(playerid, -1, !"�� ������ �� �����");
				GoogleAuthenticator_Login(playerid);
				return 1;
			}

    		new
				checkGoogleAuth = GoogleAuthenticatorCode(player[playerid][pgoogleAuthCode], gettime());

		    if(strval(inputtext) != checkGoogleAuth)
			{
				SendClientMessage(playerid, -1, !"�� ����� �������� ������! ���� ������ �� ���������!");
				GoogleAuthenticator_Login(playerid);
				return 1;
			}
		    else
		 	{
				SendClientMessage(playerid, -1, !"�������! ������� ��� ������ ���������, �� ������ ���������� �����������.");
				DialogLogin(playerid); // ������ ����� ��������� ��� ������ �����������
			}
		}
		else return Kick(playerid);
	}
}

// ���� ������ ��� �����������, ����� ������������
if(player[playerid][googleAuth] == 1)// ��������� �� ������� ��������� ������
{
	GoogleAuthenticator_Login(playerid);// �������� ����, ������� �������� �����, ����� �������� ������ � ����� ����
	return true;
}
else return DialogLogin(playerid);// ���� googleAuth �� ����� ����� 1, ����� �������� ������� �����������. ������ ����� DialogLogin ��������� ��� ������ �� �����������

stock GoogleAuthenticator_Login(playerid)
{
	ShowPlayerDialog(playerid, ВАШ_ИД_3, DIALOG_STYLE_INPUT, !" ", !"\
	����� ������ ����������� �������� ���������� Google Authenticator\n\
    � ������� � ���� ���� ��������������� 6-�� ������� ��� �� ����������:", !"�����", !"�����");
	return 1;
}

cache_get_field_content(0, "GoogleAuthCode", player[playerid][googleAuthCode], mysqlHandle, 20+1);
player[playerid][googleAuth] = cache_get_field_content_int(0, "GoogleAuth");

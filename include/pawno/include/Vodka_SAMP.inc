/*
    ������  ��� ������� 'Vodka_SAMP' v2.0!
    ������, ���������� ��������� ��� � ������ ����.
		1)����������� ������� ���� � ����� 'pawno/include'
		2)����������� �� ���� ����� �������� � ����� ����� '#include <a_samp>'
			��������� '#include <Vodka_SAMP>'
    ���������: [KrYpToDeN]
    �����: kryptoden
*/

#if !defined _string_included
	#error Include 'Vodka_SAMP.inc' should be loaded after 'string.inc'!
#endif

#if defined _VodkaSAMP_included
	#endinput
#endif

#define _VodkaSAMP_included
#pragma library VodkaSAMP

native KryptoHook_GetPlayerName(name1[]);

stock _GetPlayerName(playerid, name1[], length)
{
    GetPlayerName(playerid, name1, length);
    KryptoHook_GetPlayerName(name1);
}
#define GetPlayerName _GetPlayerName

/*
    ������  ��� ������� 'Vodka_SAMP' v2.0!
    ������, ���������� ��������� ��� � ������ ����.
		1)����������� ������� ���� � ����� 'pawno/include'
		2)����������� �� ���� ����� �������� � ����� ����� '#include <a_samp>'
			��������� '#include <Vodka_SAMP>'
    ���������: [KrYpToDeN]
    �����: kryptoden
*/
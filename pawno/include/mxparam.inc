/*
    ��������

        ������ source[] ����� ��������� �� ��������� ��������
        � ������� ������� delimiter. ������ ��������� ��� ������� (��������)
        substrIndex ����� �������� � ������ dest[]


    ���������

        dest[]        ���� ����� �������� ������ ���������

        maxSize       ����. ������ ���������, ������� ����� �������� � dest[]
                      ���� ����� ��������� ������ maxSize, �� ��� ��������

        source[]      �������� ������ ��� ��������� � ������ � ��� ��������

        delimiter     ������, ������� ����� ������ �������� ������ �� ���������

        substrIndex   ���������� ����� (������) ��������� � �������� ������

        withRest      ��� ���������� ����, ���� ����� 1, �� � dest[]
                      ����� �������� ��� ���������, ������� � ����������
                      ������� substrIndex. � ��� ����� � ��� ������� delimiter,
                      ������� ����� ����� ����������� ����� ����� �������� � dest[]


    ����������

        ������


    �������

        new dest[128] = "something";

        sparam( dest, 20, "/register 123456", ' ', 0 ); // dest = "/register"
        sparam( dest, 20, "/register 123456", ' ', 1 ); // dest = "123456"
        sparam( dest,  5, "/register 123456", ' ', 0 ); // dest = "/reg"
        sparam( dest,  4, "/register 123456", ' ', 1 ); // dest = "123"

        sparam( dest, 20, "/pm 29 ��� ����, ���?", ' ', 0 );    // dest = "/pm"
        sparam( dest,  4, "/pm 29 ��� ����, ���?", ' ', 1 );    // dest = "29"
        sparam( dest, 10, "/pm 29 ��� ����, ���?", ' ', 2 );    // dest = "���"
        sparam( dest, 50, "/pm 29 ��� ����, ���?", ' ', 2, 1 ); // dest = "��� ����, ���?"
        sparam( dest, 10, "/pm 29 ��� ����, ���?", ' ', 3 );    // dest = "����,"
        sparam( dest, 50, "/pm 29 ��� ����, ���?", ' ', 3, 1 ); // dest = "����, ���?"
        sparam( dest, 10, "/pm 29 ��� ����, ���?", ' ', 4 );    // dest = "���?"

        sparam( dest, 20, "91.235.141.89", '.', 0 );    // dest = "91"
        sparam( dest, 20, "91.235.141.89", '.', 1 );    // dest = "235"
        sparam( dest, 20, "91.235.141.89", '.', 2 );    // dest = "141"
        sparam( dest, 20, "91.235.141.89", '.', 3 );    // dest = "89"
        sparam( dest, 20, "91.235.141.89", '.', 1, 1 ); // dest = "235.141.89"
        sparam( dest, 20, "91.235.141.89", '.', 2, 1 ); // dest = "141.89"

        sparam( dest, 20, "/register 123456", ' ', -1 ); // dest = "", �.�. ��������� � ����� �������� ���
        sparam( dest, 20, "/register 123456", ' ',  7 ); // dest = "", �.�. ��������� � ����� �������� ���
*/

stock sparam
(
	dest[],				maxSize		= sizeof(dest),
	const source[],		delimiter	= ' ',
	substrIndex = 0,	withRest	= 0
)
{
	dest[0] = 0; // ������� ������ ����������

	for ( new cur, pre, i = -1; ; cur++ ) // ���������� �� ������� ������� � ������ source
	{
		if ( source[cur] == 0 ) // ���� ������� ������ � source - ��� ������ ����� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
				// ��������� � dest ������ ��������� �� source
				strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize );

			return; // �������� ������ �������
		}

		if ( source[cur] == delimiter ) // ���� ������� ������ � source - ��� ������ ��� ���������� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
			{
				// ��������� � dest ������ ��������� �� source
				strmid( dest, source, pre, ( withRest ? strlen(source) : cur ), maxSize );
				return; // �������� ������ �������
			}

			pre = cur + 1;
		}
	}
}





/*
    ��������

        ������ source[] ����� ��������� �� ��������� ��������
        � ������� ������� delimiter. � ������ ��������� ��� ������� (��������)
        substrIndex ����� ���������� �������� ��� �����


    ���������

        source[]      �������� ������ ��� ��������� � ������ � ��� ��������

        delimiter     ������, ������� ����� ������ �������� ������ �� ���������

        substrIndex   ���������� ����� (������) ��������� � �������� ������


    ����������

        ������������� �������� ���������


    �������

        new number = 555;

        number = iparam( "/givecash 23 50000", ' ', -1 ); // number = 0, �.�. ��������� � ����� �������� ���
        number = iparam( "/givecash 23 50000", ' ',  0 ); // number = 0
        number = iparam( "/givecash 23 50000", ' ',  1 ); // number = 23
        number = iparam( "/givecash 23 50000", ' ',  2 ); // number = 50000
        number = iparam( "/givecash 23 50000", ' ',  3 ); // number = 0, �.�. ��������� � ����� �������� ���
*/

stock iparam ( const source[], delimiter = ' ', substrIndex = 0 )
{
	for ( new dest[12], cur, pre, i = -1; ; cur++ ) // ���������� �� ������� ������� � ������ source
	{
		if ( source[cur] == 0 ) // ���� ������� ������ � source - ��� ������ ����� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
				strmid( dest, source, pre, cur, 12 ); // ��������� � dest ������ ��������� �� source

			return strval(dest); // �������� ������ ������� � ������ ������������� �������� ���������
		}

		if ( source[cur] == delimiter ) // ���� ������� ������ � source - ��� ������ ��� ���������� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
			{
				strmid( dest, source, pre, cur, 12 );// ��������� � dest ������ ��������� �� source
				return strval(dest); // �������� ������ ������� � ������ ������������� �������� ���������
			}

			pre = cur + 1;
		}
	}
}





/*
    ��������

        ������ source[] ����� ��������� �� ��������� ��������
        � ������� ������� delimiter. � ������ ��������� ��� ������� (��������)
        substrIndex ����� ���������� �������� ��� ������� �����


    ���������

        source[]      �������� ������ ��� ��������� � ������ � ��� ��������

        delimiter     ������, ������� ����� ������ �������� ������ �� ���������

        substrIndex   ���������� ����� (������) ��������� � �������� ������


    ����������

        ������� ��������� �������� ���������


    �������

        new Float: float = 555.5;

        float = iparam( "/goto -157.2 1248.25 10", ' ', -1 ); // float = 0.0, �.�. ��������� � ����� �������� ���
        float = iparam( "/goto -157.2 1248.25 10", ' ',  0 ); // float = 0.0, �.�. ��������� "/goto" ��� �� �����
        float = iparam( "/goto -157.2 1248.25 10", ' ',  1 ); // float = -157.2
        float = iparam( "/goto -157.2 1248.25 10", ' ',  2 ); // float = 1248.25
        float = iparam( "/goto -157.2 1248.25 10", ' ',  3 ); // float = 10.0
        float = iparam( "/goto -157.2 1248.25 10", ' ',  4 ); // float = 0.0, �.�. ��������� � ����� �������� ���
*/

stock Float: fparam ( const source[], delimiter = ' ', substrIndex = 0 )
{
	for ( new dest[40], cur, pre, i = -1; ; cur++ ) // ���������� �� ������� ������� � ������ source
	{
		if ( source[cur] == 0 ) // ���� ������� ������ � source - ��� ������ ����� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
				strmid( dest, source, pre, cur, 40 ); // ��������� � dest ������ ��������� �� source

			return floatstr(dest); // �������� ������ ������� � ������ ������� ��������� �������� ���������
		}

		if ( source[cur] == delimiter ) // ���� ������� ������ � source - ��� ������ ��� ���������� ������
		{
			if ( ++i == substrIndex ) // ���� ������ ������� ��������� � ���� sourceIndex
			{
				strmid( dest, source, pre, cur, 40 );// ��������� � dest ������ ��������� �� source
				return floatstr(dest); // �������� ������ ������� � ������ ������� ��������� �������� ���������
			}

			pre = cur + 1;
		}
	}
}

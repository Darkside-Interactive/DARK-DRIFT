/*
    ##################
        Power INI
    ##################

    ��� ���������� ������� ��� ��������� �������� ������������ SA:MP,
    ������� ��������� ���������/������/������������� ����� INI �������.

    �����:   MX_Master
    ������:  0.2
    ����:    01/05/2010

    ������ �������:

        ini_open ( file_name[] )
        ini_close ( file_id )
        ini_rename_file ( file_id, new_file_name[], delete_old_file = 1 )

        ini_get ( file_id, section[], key[], value[], max_value_size = sizeof(value) )
        ini_get_int ( file_id, section[], key[], & value )
        ini_get_float ( file_id, section[], key[], & Float: value )

        ini_set ( file_id, section[], key[], value[] )
        ini_set_int ( file_id, section[], key[], value )
        ini_set_float ( file_id, section[], key[], Float: value )

        ini_remove_key ( file_id, section[], key[] )
        ini_remove_section ( file_id, section[] )

*/





//
// ���������
//
//  (?) ��� ��������� ��������� � ����� ����� �����
//
const
    // ������������� �������� ��� ���� ������
    MAX_OPENED_FILES        = 2,            // ���� �������� ������
    MAX_SECTION_SIZE        = 20 * 1024,    // ���� ������ ������ ������ � ������
    MAX_SECTIONS            = 50,           // ���� ������ � �������� �����
    MAX_SECTION_KEYS        = 200,          // ���� ������ � ������
    MAX_SECTION_NAME_SIZE   = 1024,         // ���� ������ ����� ������
    MAX_FILENAME_SIZE       = 255,          // ���� ������ ����� �����
    MAX_STR_SIZE            = 2048,         // ���� ������ ������ �����

    // ������ ������
    INT_SIZE                = 12,           // ������ ������ � ������������� ���������
    FLOAT_SIZE              = 40,           // ������ ������ � ������� �������� ���������

    // ����� �������� �� ����� ����� ������ 0
    STORE_MACHINE           = 1;            // �� ����������� ������ ��� �������� ������������ ������











//
// ��������� ��� �����������
//
//  (!) ����������� ���� ������ ������ �����, ��� ������
//  (?) 128 ����� - ��� �����
//
#pragma dynamic ( (MAX_SECTION_SIZE char) + (MAX_SECTION_NAME_SIZE char) + MAX_FILENAME_SIZE + (MAX_STR_SIZE char) + FLOAT_SIZE + 128 ) * MAX_OPENED_FILES











//
// ������ ������ �������� ��� ������ �� ������
//
//  (?) ��� ������� ��������� � ����� ����� �����
//  (!) ������������� �� ��������
//
#define ANY_SPACE_CHAR  ' ', '\t', '\r', '\n'   // ��� ���������� �������
#define STR_SPACE_CHAR  ' ', '\t'               // ������ ��������� ���������� �������
#define STR_CAR_RET     '\r'                    // ������ ������ �������
#define STR_DELIM       '\n'                    // ����������� �����
#define KEY_VAL_DELIM   '='                     // ����������� ����� � ��������
#define COMMENT_START   ';', '#'                // ������ �������
#define SECTION_START   '['                     // ������ ����� ������
#define SECTION_END     ']'                     // ����� ����� ������



//
// ������� ��� �������� ���� ����
//
//  (?) ��� ������� ��������� � ����� ����� �����
//
#define skCur[%0]    _section[file_id][sID][%0][skID]
#define sk[%0][%1]   _section[file_id][sID][%1][%0]
#define sCur[%0]     _section[file_id][sID][%0]

#define fChanged     _file[file_id][flChanged]
#define fUsed        _file[file_id][flUsed]
#define fKeys        _file[file_id][flKeys]
#define fSections    _file[file_id][flSections]











//
// ����, ������������ ��������� � ������ ������
//
enum ( += -1 )
{
    INI_OK = 0,                 // ������� ������� ���������

    INI_WRONG_FILE_ID,          // ������ �������� �� ��������� �����

    INI_FREAD_ERROR,            // ������ ������ �� �����
    INI_FWRITE_ERROR,           // ������ ��� ������ � ����

    INI_TOO_MANY_OPENED_FILES,  // ��������� ���� �������� ������
    INI_TOO_MANY_SECTIONS,
    INI_TOO_MANY_SECTION_KEYS,

    INI_KEY_NOT_FOUND,          // ���� � �������� ����� �� ������
    INI_SECTION_NOT_FOUND       // ������ � �������� ����� �� �������
}



//
// ��������� ����� ������
//
enum iniSectionData
{
    sUsed,
    sKeys,
    sNameLen,

    skUsed          [MAX_SECTION_KEYS],
    skNamePos       [MAX_SECTION_KEYS],
    skNameLen       [MAX_SECTION_KEYS],
    skValueOffset   [MAX_SECTION_KEYS],
    skValueLen      [MAX_SECTION_KEYS]
}



//
// ��������� ������ ��������� �����
//
enum iniFileData
{
    flUsed,
    flChanged,

    flKeys,
    flSections
}





//
// ��������� ����������
//
//  (?) ��� �� ����� ������ ������ � ���� �������� �������
//
static stock
    _section    [ MAX_OPENED_FILES ] [ MAX_SECTIONS + 1 ] [ iniSectionData ],   // ������ ������ ������
    _file       [ MAX_OPENED_FILES ] [ iniFileData ];                           // ������ ������� ��������� �����





















stock ini_open ( file_name[] )
{
    // ����� �����
    new file_id;
    for ( ; file_id < MAX_OPENED_FILES; file_id++ ) if ( !fUsed ) break;
    if ( file_id >= MAX_OPENED_FILES ) return INI_TOO_MANY_OPENED_FILES;



    // ���� ���� �� ���������� - �������� ��������� ����� � ���
    if ( !fexist(file_name) )
    {
        // �������� ��� ����� � propety �������
        setproperty( STORE_MACHINE, _, file_id, file_name );

        fUsed       = 1;
        fChanged    = 1; // 1 - ����� ��� �������� �������� ����� ������ ����
        fKeys       = 0;
        fSections   = 1;

        return file_id;
    }



    // ��������� ����
    new File: file = fopen( file_name, io_read );
    if ( !file ) return INI_FREAD_ERROR;



    // �������� ��������� ��������� �����
    fUsed       = 1;
    fChanged    = 0;
    fKeys       = 0;
    fSections   = 1;

    // �������� ��� ����� � propety �������
    setproperty( STORE_MACHINE, _, file_id, file_name );

    // ������� ��������� ������
    new sText [MAX_SECTION_SIZE char], // ����� ����� ������
        sName [MAX_SECTION_NAME_SIZE char], // ��� ������� ������
        fStr  [MAX_STR_SIZE char], // ������� ������, ����������� �� �����
        sID, // ������ �� ����� ������
        skID, // �� ����� ����� � ������
        sText_pos, // ����� ��� � ������ ������
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2, // ��������� ������ � ������� property ��� ���� ������
        prop_sText_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS; // ��������� ������ � ������� property ��� ������� ������

    // ����� �������� ��������� 0 ������
    setproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );
    sCur[sNameLen] = 0;



    // ������ ���� ���������, ���������� ����� ������� ������/������
    for
    (
        new fStr_endPos = fread( file, fStr, _, true ), fStr_pos, fStr_namePos, fStr_valuePos, fStr_delimPos;
        fStr_endPos > 0;
        fStr_endPos = fread( file, fStr, _, true )
    )
    {
        // ����� � ����������� ������..
        for ( fStr_pos = 0; fStr_pos < fStr_endPos; fStr_pos++ )
        {
            switch ( fStr{fStr_pos} )
            {
                case STR_SPACE_CHAR : continue;
                // ������, ������������ � �������� ; # = \r \n ��������� ��������� (������� ������� �� � ����)
                case COMMENT_START, STR_CAR_RET, STR_DELIM, KEY_VAL_DELIM : break;
                // ������� ������ ������ ( [ )
                case SECTION_START :
                {
                    // ������� � ���� ������, ���� ��� ���� ������
                    if ( fSections >= MAX_SECTIONS ) break;


                    // ���� ��� ������ ������ ����� � ������� ������
                    fStr_namePos = fStr_pos + 1;

                    // ������ ����� ����� ������
                    for ( fStr_pos = fStr_endPos - 1; fStr_pos > fStr_namePos; fStr_pos-- )
                        if ( fStr{fStr_pos} == SECTION_END ) break;

                    // ���� ��� ������� ����� ������ ��� ��� - ������ ������
                    if ( fStr_pos <= fStr_namePos ) break;


                    // �������� ����� � ��������� ������ ������
                    sText{sText_pos} = 0;
                    sText_pos        = 0;
                    setproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );

                    sCur[sUsed] = 1;
                    skID        = 0;
                    fSections++;
                    sID++;


                    // �������� ����� � ��� ����� ������
                    sCur[sNameLen] = fStr_pos - fStr_namePos;

                    fStr_valuePos = min( sCur[sNameLen], sizeof(sName)*4 - 1 ) - 1;
                    sName{fStr_valuePos + 1} = 0;

                    for ( fStr_pos--; fStr_valuePos >= 0; fStr_pos--, fStr_valuePos-- )
                        sName{fStr_valuePos} = fStr{fStr_pos};

                    setproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );

                    break;
                }
                // ������� ������ ����� ( ����� ������, ����� ; # = \r \n [ )
                default :
                {
                    // ������� � ���� ������, ���� ��� ���� ������ � ������
                    if ( sCur[sKeys] >= MAX_SECTION_KEYS ) break;

                    // ���� ��� ������ ����� ����� � ������� ������
                    fStr_namePos = fStr_pos;

                    // ������ =
                    for ( fStr_pos++; fStr_pos < fStr_endPos && fStr{fStr_pos} != KEY_VAL_DELIM; fStr_pos++ ) {}
                    if ( fStr_pos >= fStr_endPos ) break;

                    // ���� ��� =
                    fStr_delimPos    = fStr_pos;
                    skCur[skNamePos] = fStr_namePos + sText_pos;

                    // ������ ����� ����� �����
                    for ( fStr_pos--; fStr_pos >= fStr_namePos; fStr_pos-- )
                    {
                        switch ( fStr{fStr_pos} )
                        {
                            case STR_SPACE_CHAR : continue;
                            default:              break;
                        }
                    }

                    // ���� ����� ����� �����
                    skCur[skNameLen] = fStr_pos - fStr_namePos + 1;

                    // ������ ������ �������� �����
                    for ( fStr_pos = fStr_delimPos + 1; ; fStr_pos++ )
                    {
                        switch ( fStr{fStr_pos} )
                        {
                            case STR_SPACE_CHAR : continue;
                            default:              break;
                        }

                        if ( fStr_pos + 1 >= fStr_endPos ) break;
                    }

                    // ���� ��� ������ �������� �� ������ ������
                    fStr_valuePos = fStr_pos;

                    // ������ ����� �������� �����
                    for ( fStr_pos = fStr_endPos - 1;   fStr_pos >= fStr_valuePos;   fStr_pos-- )
                    {
                        switch ( fStr{fStr_pos} )
                        {
                            case ANY_SPACE_CHAR :  continue;
                            default: { fStr_pos++; break; }
                        }
                    }
                    if ( fStr_pos < fStr_valuePos ) fStr_pos++;

                    // ���� �������� ������ �������� � ����� ��������
                    skCur[skValueOffset] = fStr_valuePos - fStr_namePos;
                    skCur[skValueLen]    = fStr_pos - fStr_valuePos;

                    skCur[skUsed] = 1;
                    skID++;
                    sCur[sKeys]++;
                    fKeys++;

                    break;
                }
            }
        }

        // �������� ������ � ����� ����� ������, ���� � ����� ������
        if ( fStr_endPos + sText_pos < MAX_SECTION_SIZE )
        {
            for ( fStr_pos = 0; fStr_pos < fStr_endPos; fStr_pos++, sText_pos++ )
                sText{sText_pos} = fStr{fStr_pos};
        }
    }



    // �������� ����� � ��������� ��������� ������
    if ( fSections <= MAX_SECTIONS )
    {
        sCur[sUsed]      = 1;
        sText{sText_pos} = 0;
        setproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );
    }



    fclose(file); // ������� ����
    return file_id;
}





stock ini_close ( file_id )
{
    // ���� ������ �������� ����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;


    // ���� ���� �� ��� �������
    if ( fChanged == 0 )
    {
        fUsed = 0;
        return INI_OK;
    }


    // ������ ��� �����
    new fName[MAX_FILENAME_SIZE];
    getproperty( STORE_MACHINE, _, file_id, fName );
    strunpack( fName, fName );


    // ������� ����
    new File: file = fopen( fName, io_write );
    if ( !file ) return INI_FWRITE_ERROR;


    // ������� ��������� ������
    new sText [MAX_SECTION_SIZE char], // ����� ����� ������
        sID, // ������ �� ����� ������
        sSize, // ����� ������ ������� ������
        sCount, // ���-�� ��������� ������
        sText_pos, // ����� ��� � ������ ������
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2, // ��������� ������ � ������� property ��� ���� ������
        prop_sText_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS; // ��������� ������ � ������� property ��� ������� ������


    // ������� � ���� ������ ���� ������
    if ( fSections > 0 )
    {
        for ( ; sID < MAX_SECTIONS; sID++ )
        {
            if ( sCur[sUsed] != 1 ) continue;

            // ������ ����� ������
            getproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );

            // ����������� ������� ����� ������ � ����
            for ( sText_pos = 0, sSize = strlen(sText); sText_pos < sSize; sText_pos++ )
                fputchar( file, sText{sText_pos}, false );

            // ������ ����� � ��� ������
            deleteproperty( STORE_MACHINE, _, prop_sText_offset + sID );
            deleteproperty( STORE_MACHINE, _, prop_sName_offset + sID );

            if ( ++sCount >= fSections ) break;
        }
    }


    // ������ ��� �����
    deleteproperty( STORE_MACHINE, _, file_id );


    // ���� �� ������������ � ������
    fUsed = 0;
    fclose(file);


    return INI_OK;
}











stock ini_rename_file ( file_id, new_file_name[], delete_old_file = 1 )
{
    // ���� ������ �������� ����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;

    // ���� ����� ������� ������ ����
    if ( delete_old_file )
    {
        // ������ ��� �����
        new fName[MAX_FILENAME_SIZE];
        getproperty( STORE_MACHINE, _, file_id, fName );
        strunpack( fName, fName );

        // ������ ������ ����
        fremove(fName);
    }

    // �������� ����� ��� ����� � propety �������
    setproperty( STORE_MACHINE, _, file_id, new_file_name );

    // �������� ��������� �����
    fChanged = 1;

    return INI_OK;
}











stock ini_get ( file_id, section[], key[], value[], max_value_size = sizeof(value) )
{
    // ���� ������ �������� ����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;



    // ������� ��������� ������
    new sName [MAX_SECTION_NAME_SIZE char], // ��� ������� ������
        sID, // ������ �� ����� ������
        section_len = strlen(section),
        c, // ������� ������� � ��������� ������/�����
        count, // ���-�� ������������� ������/������ �� ����� ������
        found, // ���� - ������� �� ������/����
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2; // ��������� ������ � ������� property ��� ���� ������



    // ����� ������
    if ( fSections > 0 )
    {
        for ( ; sID < MAX_SECTIONS; sID++ )
        {
            if ( sCur[sUsed] != 1 ) continue;

            if ( sCur[sNameLen] == section_len )
            {
                // ������ ��� ������ �����
                getproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );

                // ������� ��� ������
                for ( c = section_len - 1;   c >= 0;   c-- )
                    if ( sName{c} != section[c] ) break;

                // ���� ������ ���������
                if ( c < 0 ) { found = 1; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ����� - ��������� �����
            if ( ++count >= fSections ) break;
        }
    }

    if ( found < 1 ) return INI_SECTION_NOT_FOUND;



    // ������� ��������� ������
    new key_len = strlen(key),
        sText [MAX_SECTION_SIZE char], // ����� ����� ������
        skID, // �� ����� ����� � ������
        sText_pos, // ����� ��� � ������ ������
        prop_sText_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS; // ��������� ������ � ������� property ��� ������� ������

    // ������ ����� ������
    getproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );



    // ����� �����
    found = 0;

    if ( sCur[sKeys] > 0 )
    {
        for ( count = 0;   skID < MAX_SECTION_KEYS;   skID++ )
        {
            if ( skCur[skUsed] != 1 ) continue;

            if ( skCur[skNameLen] == key_len )
            {
                // ������� ��� �����
                for ( c = 0, sText_pos = skCur[skNamePos]; c < key_len; c++, sText_pos++ )
                    if ( sText{sText_pos} != key[c] ) break;

                // ���� ����� ���������
                if ( c >= key_len ) { found++; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ������ - ��������� ����� �����
            if ( ++count >= sCur[sKeys] ) break;
        }
    }

    if ( found < 1 ) return INI_KEY_NOT_FOUND;



    max_value_size = min( skCur[skValueLen], max_value_size - 1 ); // ������ ���� ������ ������� ������
    value[max_value_size] = 0; // �������� � ��� ������ ����� ������ � ������ �����

    // �������� �������� ����� � ���������� ��������
    for ( c = 0, sText_pos = skCur[skNamePos] + skCur[skValueOffset]; c < max_value_size; c++, sText_pos++ )
        value[c] = sText{sText_pos};

    return INI_OK;
}





stock ini_get_int ( file_id, section[], key[], & value )
{
    new strValue [ INT_SIZE ],
        returned = ini_get( file_id, section, key, strValue, INT_SIZE );

    value = strval(strValue);

    return returned;
}





stock ini_get_float ( file_id, section[], key[], & Float: value )
{
    new strValue [ FLOAT_SIZE ],
        returned = ini_get( file_id, section, key, strValue, FLOAT_SIZE );

    value = floatstr(strValue);

    return returned;
}












stock ini_set ( file_id, section[], key[], value[] )
{
    // �������� �� �����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;



    // ������� ��������� ������
    new section_len = strlen(section), // ����� ��������� ������
        sName [MAX_SECTION_NAME_SIZE char], // ��� ������� ������
        sText [MAX_SECTION_SIZE char], // ����� ����� ������
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2, // ��������� ������ � ������� property ��� ���� ������
        prop_sText_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS, // ��������� ������ � ������� property ��� ������� ������
        sText_pos, // ������� ��� � ������ ������
        sID, // ������ �� ����� ������
        c,
        count, // ���-�� ������������� ������/������ �� ����� ������
        found; // ���� - ������� �� ������/����



    // ����� ������
    if ( fSections > 0 )
    {
        for ( ; sID < MAX_SECTIONS; sID++ )
        {
            if ( sCur[sUsed] != 1 ) continue;

            if ( sCur[sNameLen] == section_len )
            {
                // ������ ��� ������ �����
                getproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );

                // ������� ��� ������
                for ( c = section_len - 1;   c >= 0;   c-- )
                    if ( sName{c} != section[c] ) break;

                // ���� ������ ���������
                if ( c < 0 ) { found = 1; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ����� - ��������� �����
            if ( ++count >= fSections ) break;
        }
    }



    // ���� ������ �� �������
    if ( !found )
    {
        // ���� ����� ������ ��������
        if ( fSections >= MAX_SECTIONS ) return INI_TOO_MANY_SECTIONS;


        // ����� ���������� ����� ��� ������
        for ( sID = 1;   sID < MAX_SECTIONS;   sID++ )
            if ( sCur[sUsed] != 1 ) break;


        // �������� ��������� ������ � �����
        sCur[sUsed]    = 1;
        sCur[sKeys]    = 0;
        sCur[sNameLen] = section_len;
        fSections++;

        // �������� ��� ������
        setproperty( STORE_MACHINE, _, prop_sName_offset + sID, section );


        // �������� ��� ������ � ����� ������
        sText_pos          = 0;
        sText{sText_pos++} = STR_CAR_RET;
        sText{sText_pos++} = STR_DELIM;
        sText{sText_pos++} = SECTION_START;

        for ( c = 0;   c < section_len;   c++, sText_pos++ )
            sText{sText_pos} = section[c];

        sText{sText_pos++} = SECTION_END;
        sText{sText_pos}   = 0;

        // �������� ����� ������
        setproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );
    }
    // ���� ������ �������
    else
        // ������ ����� ������
        getproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );



    // ������� ��������� ������
    new key_len = strlen(key),
        skID, // �� ����� ����� � ������
        value_len = strlen(value), // ������ ��������
        sText_len = strlen(sText), // ����� ������ ������
        sText_offset; // �������� ������ ������



    // ����� �����
    found = 0;

    if ( sCur[sKeys] > 0 )
    {
        for ( count = 0;   skID < MAX_SECTION_KEYS;   skID++ )
        {
            if ( skCur[skUsed] != 1 ) continue;

            if ( skCur[skNameLen] == key_len )
            {
                // ������� ��� �����
                for ( c = 0, sText_pos = skCur[skNamePos];   c < key_len;   c++, sText_pos++ )
                    if ( sText{sText_pos} != key[c] ) break;

                // ���� ����� ���������
                if ( c >= key_len ) { found = 1; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ������ - ��������� ����� �����
            if ( ++count >= sCur[sKeys] ) break;
        }
    }



    // ���� ���� �� ������
    if ( !found )
    {
        // ������ �������� ������ ������ ������ � ������
        sText_offset = key_len + 3 + value_len + ( ( sText_len > 0 ) ? 2 : 0 );

        // ���� ����� ������ �������� ��� ��� ����� � ������ ������
        if ( sCur[sKeys] >= MAX_SECTION_KEYS || sText_len + sText_offset >= MAX_SECTION_SIZE )
            return INI_TOO_MANY_SECTION_KEYS;

        // ����� ���������� ����� ��� �����
        for ( skID = 0; skID < MAX_SECTION_KEYS; skID++ )
            if ( skCur[skUsed] != 1 ) break;

        // �������� ��������� �����, ������ � �����
        skCur[skUsed]        = 1;
        skCur[skNameLen]     = key_len;
        skCur[skValueOffset] = key_len + 3;
        skCur[skValueLen]    = value_len;
        fKeys++;
        sCur[sKeys]++;

        // ������ ����� ������ � ����� ��������� ������
        for ( sText_pos = sText_len - 1; sText_pos >= 0; sText_pos-- )
        {
            switch ( sText{sText_pos} )
            {
                case STR_CAR_RET, STR_DELIM : continue;
                default:                      { sText_pos++; break; }
            }
        }

        // ���� ������� ��� ������� ����� - �� ����� ����� ������ ������
        if ( sText_pos < sText_len )
        {
            // ���������� ������� � ����� ������ �� �� ����� �����
            for ( new pos = sText_pos; pos < sText_len; pos++ )
                sText{pos + sText_offset} = sText{pos};
        }

        // ������� \r\n ���� ����� ������ �� �������
        if ( sText_len > 0 )
        {
            sText{sText_pos++} = STR_CAR_RET;
            sText{sText_pos++} = STR_DELIM;
        }

        // �������� ��� �����
        skCur[skNamePos] = sText_pos;
        for ( c = 0; c < key_len; c++, sText_pos++ ) sText{sText_pos} = key[c];

        // ������� =
        sText{sText_pos++} = ' ';
        sText{sText_pos++} = KEY_VAL_DELIM;
        sText{sText_pos++} = ' ';

        // �������� ��������
        for ( c = 0; c < value_len; c++, sText_pos++ ) sText{sText_pos} = value[c];

        // + ������ ����� ������
        sText{sText_len + sText_offset} = 0;
    }
    // ���� ���� ������
    else
    {
        // ������ �������� ������ ������ ������ � ������
        sText_offset = value_len - skCur[skValueLen];

        // ���� ��� ����� � ������ ������
        if ( sText_len + sText_offset >= MAX_SECTION_SIZE )
            return INI_TOO_MANY_SECTION_KEYS;


        // ����� ������� ������, ������ ����� �������� �����
        count = 0;
        for ( new k; k < MAX_SECTION_KEYS; k++ )
        {
            if ( sk[k][skUsed] != 0 )
            {
                // ���� ��� ����� ������ ��� ����� ����� - ������� ��� ����� k
                if ( sk[k][skNamePos] > skCur[skNamePos] ) sk[k][skNamePos] += sText_offset;

                // ���� ����� ������������� ������ ����� ���-�� ������ � ������
                if ( ++count >= sCur[sKeys] ) break;
            }
        }

        // ����� ������ ������
        if ( sText_offset != 0 )
        {
            if ( sText_offset > 0 )
            {
                new valueEndPos = skCur[skNamePos] + skCur[skValueOffset] + skCur[skValueLen];

                for ( sText_pos = sText_len - 1;   sText_pos >= valueEndPos;   sText_pos-- )
                    sText{sText_pos + sText_offset} = sText{sText_pos};
            }
            else
            {
                for ( sText_pos = skCur[skNamePos] + skCur[skValueOffset] + skCur[skValueLen];   sText_pos < sText_len;   sText_pos++ )
                    sText{sText_pos + sText_offset} = sText{sText_pos};
            }

            sText{sText_len + sText_offset} = 0;
            skCur[skValueLen]               = value_len;
        }


        // �������� ����� �������� ������ �������
        for ( c = 0, sText_pos = skCur[skNamePos] + skCur[skValueOffset];   c < value_len;   c++, sText_pos++ )
            sText{sText_pos} = value[c];
    }



    // �������� ����� ������
    setproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );

    // ���� �������
    fChanged = 1;

    return INI_OK;
}





stock ini_set_int ( file_id, section[], key[], value )
{
    new strValue [ INT_SIZE ];
    format( strValue, INT_SIZE, "%d", value );

    return ini_set( file_id, section, key, strValue );
}





stock ini_set_float ( file_id, section[], key[], Float: value )
{
    new strValue [ FLOAT_SIZE ];
    format( strValue, FLOAT_SIZE, "%f", value );

    return ini_set( file_id, section, key, strValue );
}











stock ini_remove_key ( file_id, section[], key[] )
{
    // ���� ������ �������� ����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;



    // ������� ��������� ������
    new sName [MAX_SECTION_NAME_SIZE char], // ��� ������� ������
        sID, // ������ �� ����� ������
        section_len = strlen(section),
        c, // ������� ������� � ��������� ������/�����
        count, // ���-�� ������������� ������/������ �� ����� ������
        found, // ���� - ������� �� ������/����
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2; // ��������� ������ � ������� property ��� ���� ������



    // ����� ������
    if ( fSections > 0 )
    {
        for ( ; sID < MAX_SECTIONS; sID++ )
        {
            if ( sCur[sUsed] != 1 ) continue;

            if ( sCur[sNameLen] == section_len ) // � ����� ������ ���������
            {
                // ������ ��� ������ �����
                getproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );

                // ������� ��� ������
                for ( c = section_len - 1;   c >= 0;   c-- )
                    if ( sName{c} != section[c] ) break;

                // ���� ������ ���������
                if ( c < 0 ) { found = 1; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ����� - ��������� �����
            if ( ++count >= fSections ) break;
        }
    }

    if ( found < 1 ) return INI_SECTION_NOT_FOUND;



    // ������� ��������� ������
    new key_len = strlen(key),
        sText [MAX_SECTION_SIZE char], // ����� ����� ������
        skID, // �� ����� ����� � ������
        sText_pos, // ����� ��� � ������ ������
        prop_sText_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS; // ��������� ������ � ������� property ��� ������� ������

    // ������ ����� ������
    getproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );



    // ����� �����
    found = 0;

    if ( sCur[sKeys] > 0 )
    {
        for ( count = 0;   skID < MAX_SECTION_KEYS;   skID++ )
        {
            if ( skCur[skUsed] != 1 ) continue;

            if ( skCur[skNameLen] == key_len )
            {
                // ������� ��� �����
                for ( c = 0, sText_pos = skCur[skNamePos]; c < key_len; c++, sText_pos++ )
                    if ( sText{sText_pos} != key[c] ) break;

                // ���� ����� ���������
                if ( c >= key_len ) { found++; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ������ - ��������� ����� �����
            if ( ++count >= sCur[sKeys] ) break;
        }
    }

    if ( found < 1 ) return INI_KEY_NOT_FOUND;



    // ������� ��������� ������
    new sText_offset = -( skCur[skValueOffset] + skCur[skValueLen] ), // �������� ������ ������
        sText_len    = strlen(sText); // ����� ������ ������



    // ���� �� ��������� ���� ���������� �������, �� �� ������� ���� ����
    for ( sText_pos = skCur[skNamePos] + skCur[skValueOffset] + skCur[skValueLen];   sText_pos < sText_len;   sText_pos++, sText_offset-- )
        if ( sText{sText_pos} == STR_DELIM ) { sText_offset--; break; }

    // ����� ������� ������, ������ ����� �������� ����� � ������
    count = 0;
    for ( new k; k < MAX_SECTION_KEYS; k++ )
    {
        if ( sk[k][skUsed] != 0 )
        {
            // ���� ��� ����� ������ ��� ����� ����� - ������� ��� ����� k
            if ( sk[k][skNamePos] > skCur[skNamePos] ) sk[k][skNamePos] += sText_offset;

            // ���� ����� ������������� ������ ����� ���-�� ������ � ������
            if ( ++count >= sCur[sKeys] ) break;
        }
    }

    // ����� ������ ������
    for ( sText_pos = skCur[skNamePos] + skCur[skValueOffset] + skCur[skValueLen];   sText_pos < sText_len;   sText_pos++ )
        sText{sText_pos + sText_offset} = sText{sText_pos};

    // + ������ ����� ������
    sText{sText_len + sText_offset} = 0;

    // �������� ����� ������
    setproperty( STORE_MACHINE, _, prop_sText_offset + sID, sText );

    // �������� ��������� ������ � �����
    fChanged      = 1;
    skCur[skUsed] = 0;
    sCur[sKeys]--;
    fKeys--;

    return INI_OK;
}





stock ini_remove_section ( file_id, section[] )
{
    // ���� ������ �������� ����
    if ( file_id < 0 || file_id >= MAX_OPENED_FILES || fUsed == 0 )
        return INI_WRONG_FILE_ID;



    // ������� ��������� ������
    new sName [MAX_SECTION_NAME_SIZE char], // ��� ������� ������
        sID, // ������ �� ����� ������
        section_len = strlen(section),
        c, // ������� ������� � ��������� ������/�����
        count, // ���-�� ������������� ������/������ �� ����� ������
        found, // ���� - ������� �� ������/����
        prop_sName_offset = MAX_OPENED_FILES + file_id*MAX_SECTIONS*2; // ��������� ������ � ������� property ��� ���� ������



    // ����� ������
    if ( fSections > 0 )
    {
        for ( ; sID < MAX_SECTIONS; sID++ )
        {
            if ( sCur[sUsed] != 1 ) continue;

            if ( sCur[sNameLen] == section_len ) // � ����� ������ ���������
            {
                // ������ ��� ������ �����
                getproperty( STORE_MACHINE, _, prop_sName_offset + sID, sName );

                // ������� ��� ������
                for ( c = section_len - 1;   c >= 0;   c-- )
                    if ( sName{c} != section[c] ) break;

                // ���� ������ ���������
                if ( c < 0 ) { found = 1; break; }
            }

            // ���� ����� ������������� ������ ����� ���-�� ������ � ����� - ��������� �����
            if ( ++count >= fSections ) break;
        }
    }

    if ( found < 1 ) return INI_SECTION_NOT_FOUND;



    // ������ ����� ������ � �� ��� �� propety �������
    deleteproperty( STORE_MACHINE, _, prop_sName_offset + sID );
    deleteproperty( STORE_MACHINE, _, MAX_OPENED_FILES + file_id*MAX_SECTIONS*2 + MAX_SECTIONS + sID );

    // �������� ��������� ������ � �����
    fChanged    = 1;
    sCur[sUsed] = 0;
    fKeys      -= sCur[sKeys];
    fSections--;

    return INI_OK;
}





















//
// �������� �������� �������� � ��������
//

#undef MAX_OPENED_FILES
#undef MAX_SECTION_SIZE
#undef MAX_SECTIONS
#undef MAX_SECTION_KEYS
#undef MAX_SECTION_NAME_SIZE
#undef MAX_FILENAME_SIZE
#undef MAX_STR_SIZE

#undef INT_SIZE
#undef FLOAT_SIZE

#undef STORE_MACHINE





#undef ANY_SPACE_CHAR
#undef STR_SPACE_CHAR
#undef STR_CAR_RET
#undef STR_DELIM
#undef KEY_VAL_DELIM
#undef COMMENT_START
#undef SECTION_START
#undef SECTION_END





#undef skCur
#undef sk
#undef sCur

#undef fChanged
#undef fUsed
#undef fKeys
#undef fSections

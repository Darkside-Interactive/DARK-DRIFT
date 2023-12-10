// GeoIP script by Slice.

#include <a_samp>

#define MAX_COUNTRY_CODE  (3)
#define MAX_COUNTRY_NAME  (55)

enum e_COUNTRY_INFO
{
	e_szCountryCode[ MAX_COUNTRY_CODE char ],
	e_szCountryName[ MAX_COUNTRY_NAME char ]
};

enum
{
	GEOIP_STATE_NONE,
	GEOIP_STATE_RETRIEVING,
	GEOIP_STATE_RETRIEVED
};

#pragma pack 1

stock const
	g_aszCountryInfo[ ][ e_COUNTRY_INFO ] = {
		{ "XX", "Unknown | Неизвестно" },
		{ "AU", "Australia | Австралия" },
		{ "MY", "Malaysia | Малайзия" },
		{ "KR", "Kore | Коре" },
		{ "CN", "China | Китай" },
		{ "JP", "Japan | Япония" },
		{ "IN", "India | Индия" },
		{ "TW", "Taiwan | Тайвань" },
		{ "HK", "Hong Kong | Гонконг" },
		{ "TH", "Thailand | Тайланд" },
		{ "VN", "Vietnam | Вьетнам" },
		{ "FR", "France | Франция" },
		{ "EU", "Europe | Европа" },
		{ "GB", "United Kingdom | Великобритания" },
		{ "IT", "Italy | Италия" },
		{ "AE", "Arab Emirates | Арабские Эмираты" },
		{ "IL", "Israel | Израиль" },
		{ "UA", "Ukraine | Украина" },
		{ "RU", "Russian Federation | Российская Федерация" },
		{ "SE", "Sweden | Швеция" },
		{ "KZ", "Kazakhstan | Казахстан" },
		{ "PT", "Portugal | Португалия" },
		{ "GR", "Greece | Греция" },
		{ "SA", "Saudi Arabia | Саудовская Аравия" },
		{ "DK", "Denmark | Денмарк" },
		{ "IR", "Ira | Айра" },
		{ "NO", "Norway | Норвегия" },
		{ "DE", "Germany | Германия" },
		{ "US", "United States | Соеденённые Штаты" },
		{ "CA", "Canada | Канада" },
		{ "MX", "Mexico | Мексика" },
		{ "BM", "Bermuda | Бермуды" },
		{ "PR", "Puerto Rico | Пуэрто Рико" },
		{ "VI", "Virgin Island | Виргинские Острова" },
		{ "BO", "Bolivia | Боливия" },
		{ "NL", "Netherlands | Нидерланды" },
		{ "AP", "Pacific Region | Тихоокеанский регион" },
		{ "NZ", "New Zealand | Новая Зеландия" },
		{ "SG", "Singapore | Сингапур" },
		{ "ID", "Indonesia | Индонезия" },
		{ "NP", "Nepal | Непал" },
		{ "PH", "Philippines | Филиппины" },
		{ "PG", "Papua New Guinea | Папуа Новая Гвинея" },
		{ "PK", "Pakistan | Пакистан" },
		{ "ES", "Spain | Испания" },
		{ "BS", "Bahamas | Багамские острова" },
		{ "VC", "Grenadines | Гренадины" },
		{ "CL", "Chile | Чили" },
		{ "NC", "New Caledonia | Новая каледония" },
		{ "AR", "Argentina | Аргентина" },
		{ "DM", "Dominica | Доминика" },
		{ "TK", "Tokelau | Токелау" },
		{ "KH", "Cambodia | Камбоджа" },
		{ "MO", "Macau | Макао" },
		{ "MV", "Maldives | Мальдивы" },
		{ "AF", "Afghanistan | Афганистан" },
		{ "FJ", "Fiji | Фиджи" },
		{ "MN", "Mongolia | Монголия" },
		{ "WF", "Wallis and Futuna | Уоллис и Футуна" },
		{ "BD", "Bangladesh | Бангладешь" },
		{ "IE", "Ireland | Ирландия" },
		{ "AN", "Antilles | Антильские острова" },
		{ "BE", "Belgium | Бельгия" },
		{ "BZ", "Belize | Белиз" },
		{ "BR", "Brazil | Бразилия" },
		{ "CH", "Switzerland | Швейцария" },
		{ "ZA", "South Africa | ЮАР" },
		{ "EG", "Egypt | Египет" },
		{ "NG", "Nigeria | Нигерия" },
		{ "TZ", "Tanzani | Танзания" },
		{ "ZM", "Zambia | Замбия" },
		{ "SN", "Senegal | Сенегал" },
		{ "NA", "Namibia | Намибия" },
		{ "CI", "Cote D'Ivoire | Кот-д'Ивуар" },
		{ "GH", "Ghana | Гана" },
		{ "SD", "Sudan | Судан" },
		{ "CM", "Cameroon | Камерун" },
		{ "MW", "Malawi | Малави" },
		{ "AO", "Angola | Ангола" },
		{ "KE", "Kenya | Кения" },
		{ "GA", "Gabon | Габон" },
		{ "ML", "Mali | Мали" },
		{ "BJ", "Benin | Бенин" },
		{ "MG", "Madagascar | Мадагаскар" },
		{ "TD", "Chad | Чад" },
		{ "BW", "Botswana | Ботсвана" },
		{ "LY", "Arab Jamahiriya | Арабская Джамахирия" },
		{ "CV", "Cape Verde | Кабо Верде" },
		{ "RW", "Rwanda | Руанда" },
		{ "MZ", "Mozambique | Мозамбик" },
		{ "GM", "Gambia | Гамбия" },
		{ "LS", "Lesotho | Лесото" },
		{ "MU", "Mauritius | Маврикий" },
		{ "CG", "Congo | Конго" },
		{ "UG", "Uganda | Уганда" },
		{ "BF", "Burkina Faso | Буркина Фасо" },
		{ "SL", "Sierra Leone | Сьерра Леоне" },
		{ "SO", "Somalia | Сомали" },
		{ "ZW", "Zimbabwe | Зимбабве" },
		{ "CD", "Cong | Конго" },
		{ "NE", "Niger | Нигер" },
		{ "CF", "Central Africa | Центральная Африка" },
		{ "SZ", "Swaziland | Свазиленд" },
		{ "TG", "Togo | Того" },
		{ "GN", "Guinea | Гвинея" },
		{ "LR", "Liberia | Либерия" },
		{ "SC", "Seychelles | Сейшельские Острова" },
		{ "MA", "Morocco | Марокко" },
		{ "DZ", "Algeria | Алжир" },
		{ "MR", "Mauritania | Мавритания" },
		{ "DJ", "Djibouti | Джибути" },
		{ "A2", "Satellite | Спутниковый Провайдер" },
		{ "KM", "Comoros | Коморские Острова" },
		{ "RE", "Reunion | Bоссоединение" },
		{ "GQ", "Equatorial Guinea | Экваториальная Гвинея" },
		{ "TN", "Tunisia | Тунис" },
		{ "TR", "Turkey | Турция" },
		{ "BG", "Bulgaria | Болгария" },
		{ "MT", "Malta | Мальта" },
		{ "CZ", "Czech Republic | Чешская Республика" },
		{ "RS", "Serbia | Сербия" },
		{ "EE", "Estonia | Эстония" },
		{ "CY", "Cyprus | Кипр" },
		{ "LB", "Lebanon | Ливан" },
		{ "PL", "Poland | Польша" },
		{ "LU", "Luxembourg | Люксембург" },
		{ "FI", "Finland | Финляндия" },
		{ "AT", "Austria | Австрия" },
		{ "PS", "Palestinian Territory | Территория Палестины" },
		{ "AZ", "Azerbaijan | Азербайджан" },
		{ "RO", "Romania | Румыния" },
		{ "TJ", "Tajikistan | Таджикистан" },
		{ "LV", "Latvia | Латвия" },
		{ "BY", "Belarus | Беларусь" },
		{ "IS", "Iceland | Исландия" },
		{ "HU", "Hungary | Венгрия" },
		{ "SK", "Slovakia | Словакия" },
		{ "MK", "Macedonia | Македония" },
		{ "IQ", "Iraq | Ирак" },
		{ "ME", "Montenegro | Черногория" },
		{ "HR", "Croatia | Хорватия" },
		{ "JO", "Jordan | Иордания" },
		{ "YE", "Yemen | Йемен" },
		{ "BA", "Bosnia and Herzegovina | Босния и Герцеговина" },
		{ "LT", "Lithuania | Литва" },
		{ "OM", "Oman | Оман" },
		{ "BH", "Bahrain | Бахрейн" },
		{ "GE", "Georgia | Грузия" },
		{ "SY", "Syria | Сирия" },
		{ "SI", "Slovenia | Словения" },
		{ "MD", "Moldova | Молдова" },
		{ "AM", "Armenia | Армения" },
		{ "AL", "Albania | Албания" },
		{ "PA", "Panama | Панама" },
		{ "BN", "Brunei Darussalam | Бруней Даруссалам" },
		{ "LK", "Sri Lanka | Шри Ланка" },
		{ "KW", "Kuwait | Кувейт" },
		{ "AX", "Aland Islands | Аландские Острова" },
		{ "AG", "Antigua and Barbuda | Антигуа и Барбуда" },
		{ "SM", "San Marino | Сан Марино" },
		{ "FK", "Falkland Islands | Фолклендские Острова" },
		{ "UZ", "Uzbekistan | Узбекистан" },
		{ "MC", "Monaco | Монако" },
		{ "HT", "Haiti | Гаити" },
		{ "GU", "Guam | Гуам" },
		{ "JM", "Jamaica | Ямайка" },
		{ "UM", "Minor Outlying Islands | Внешние Малые Острова" },
		{ "FM", "Micronesia | Микронезия" },
		{ "EC", "Ecuador | Эквадор" },
		{ "CO", "Colombia | Колумбия" },
		{ "PE", "Peru | Перу" },
		{ "KY", "Cayman Islands | Каймановы Острова" },
		{ "HN", "Honduras | Гондурас" },
		{ "VG", "Virgin Island | Виргинские Острова" },
		{ "NI", "Nicaragua | Никарагуа" },
		{ "DO", "Dominican Republic | Доминиканская Республика" },
		{ "GD", "Grenada | Гренада" },
		{ "GT", "Guatemala | Гватемала" },
		{ "CR", "Costa Rica | Коста Рика" },
		{ "SV", "El Salvador | Сальвадор" },
		{ "VE", "Venezuela | Венесуэла" },
		{ "BB", "Barbados | Барбадос" },
		{ "TT", "Trinidad and Tobago | Тринидад и Тобаго" },
		{ "BV", "Bouvet Islands | Острова Буве" },
		{ "MH", "Marshall Islands | Маршалловы острова" },
		{ "CK", "Cook Islands | Острова Кука" },
		{ "GI", "Gibraltar | Гибралтар" },
		{ "PY", "Paraguay | Парагвай" },
		{ "A1", "Anonymous Proxy | Анонимный Прокси" },
		{ "WS", "Samoa | Самоа" },
		{ "KN", "Saint Kitts and Nevis | Сент Китс и Невис" },
		{ "UY", "Uruguay | Уругвай" },
		{ "MP", "Mariana Islands | Марианские Острова" },
		{ "PW", "Palau | Палау" },
		{ "QA", "Qatar | Катар" },
		{ "AS", "American Samoa | Американское Самоа" },
		{ "TC", "Turks and Caicos Islands | Острова Теркс и Кайкос" },
		{ "LC", "Saint Lucia | Сент Люсия" },
		{ "VA", "Holy See | Святой Престол/Ватикан" },
		{ "LA", "Lao People's Republic | Лаосская Народная Республика" },
		{ "AW", "Aruba | Аруба" },
		{ "GY", "Guyana | Гайана" },
		{ "SR", "Suriname | Суринам" },
		{ "IM", "Isle of Man | Остров Мэн" },
		{ "VU", "Vanuatu | Вануату" },
		{ "KP", "Kore | Коре" },
		{ "AI", "Anguilla | Ангилья" },
		{ "MS", "Montserrat | Монтсеррат" },
		{ "PM", "Saint Pierre and Miquelon | Сен Пьер и Микелон" },
		{ "GP", "Guadeloupe | Гваделупа" },
		{ "MF", "Saint Martin | Сен Мартен" },
		{ "GG", "Guernsey | Гёрнсей" },
		{ "BI", "Burundi | Бурунди" },
		{ "TM", "Turkmenistan | Туркменистан" },
		{ "KG", "Kyrgyzstan | Киргизия" },
		{ "MM", "Myanmar | Мьянма" },
		{ "BT", "Bhutan | Бутан" },
		{ "LI", "Liechtenstein | Лихтенштейн" },
		{ "FO", "Faroe Islands | Фарерские Острова" },
		{ "ET", "Ethiopia | Эфиопия" },
		{ "MQ", "Martinique | Мартиника" },
		{ "JE", "Jersey | Джерси" },
		{ "AD", "Andorra | Андорра" },
		{ "AQ", "Antarctica | Антарктида" },
		{ "IO", "British Territory | Британская Территория" },
		{ "ER", "Eritrea | Эритрея" },
		{ "GL", "Greenland | Гренландия" },
		{ "GW", "Guinea-Bissau | Гвинея Бисау" },
		{ "PF", "French Polynesia | Французская Полинезия" },
		{ "CU", "Cuba | Куба" },
		{ "TO", "Tonga | Тонга" },
		{ "TL", "Timor Leste | Тимор Лешти" },
		{ "ST", "Sao Tome and Principe | Сан Томе и Принсипи" },
		{ "GF", "French Guiana | Французская Гвиана" },
		{ "SB", "Solomon Islands | Соломоновы Острова" },
		{ "TV", "Tuvalu | Тувалу" },
		{ "KI", "Kiribati | Кирибати" },
		{ "NU", "Niue | Ниуэ" },
		{ "NF", "Norfolk Island | Остров Норфолк" },
		{ "NR", "Nauru | Науру" },
		{ "YT", "Mayotte | Майотта" }
	}
;

enum
{
	COUNTRY_XX, // Unknown
	COUNTRY_AU, // Australia
	COUNTRY_MY, // Malaysia
	COUNTRY_KR, // Kore
	COUNTRY_CN, // China
	COUNTRY_JP, // Japan
	COUNTRY_IN, // India
	COUNTRY_TW, // Taiwan
	COUNTRY_HK, // Hong Kong
	COUNTRY_TH, // Thailand
	COUNTRY_VN, // Vietnam
	COUNTRY_FR, // France
	COUNTRY_EU, // Europe
	COUNTRY_GB, // United Kingdom
	COUNTRY_IT, // Italy
	COUNTRY_AE, // United Arab Emirates
	COUNTRY_IL, // Israel
	COUNTRY_UA, // Ukraine
	COUNTRY_RU, // Russian Federation
	COUNTRY_SE, // Sweden
	COUNTRY_KZ, // Kazakhstan
	COUNTRY_PT, // Portugal
	COUNTRY_GR, // Greece
	COUNTRY_SA, // Saudi Arabia
	COUNTRY_DK, // Denmark
	COUNTRY_IR, // Ira
	COUNTRY_NO, // Norway
	COUNTRY_DE, // Germany
	COUNTRY_US, // United States
	COUNTRY_CA, // Canada
	COUNTRY_MX, // Mexico
	COUNTRY_BM, // Bermuda
	COUNTRY_PR, // Puerto Rico
	COUNTRY_VI, // Virgin Island
	COUNTRY_BO, // Bolivia
	COUNTRY_NL, // Netherlands
	COUNTRY_AP, // Asia/Pacific Region
	COUNTRY_NZ, // New Zealand
	COUNTRY_SG, // Singapore
	COUNTRY_ID, // Indonesia
	COUNTRY_NP, // Nepal
	COUNTRY_PH, // Philippines
	COUNTRY_PG, // Papua New Guinea
	COUNTRY_PK, // Pakistan
	COUNTRY_ES, // Spain
	COUNTRY_BS, // Bahamas
	COUNTRY_VC, // Saint Vincent and the Grenadines
	COUNTRY_CL, // Chile
	COUNTRY_NC, // New Caledonia
	COUNTRY_AR, // Argentina
	COUNTRY_DM, // Dominica
	COUNTRY_TK, // Tokelau
	COUNTRY_KH, // Cambodia
	COUNTRY_MO, // Macau
	COUNTRY_MV, // Maldives
	COUNTRY_AF, // Afghanistan
	COUNTRY_FJ, // Fiji
	COUNTRY_MN, // Mongolia
	COUNTRY_WF, // Wallis and Futuna
	COUNTRY_BD, // Bangladesh
	COUNTRY_IE, // Ireland
	COUNTRY_AN, // Netherlands Antilles
	COUNTRY_BE, // Belgium
	COUNTRY_BZ, // Belize
	COUNTRY_BR, // Brazil
	COUNTRY_CH, // Switzerland
	COUNTRY_ZA, // South Africa
	COUNTRY_EG, // Egypt
	COUNTRY_NG, // Nigeria
	COUNTRY_TZ, // Tanzani
	COUNTRY_ZM, // Zambia
	COUNTRY_SN, // Senegal
	COUNTRY_NA, // Namibia
	COUNTRY_CI, // Cote D'Ivoire
	COUNTRY_GH, // Ghana
	COUNTRY_SD, // Sudan
	COUNTRY_CM, // Cameroon
	COUNTRY_MW, // Malawi
	COUNTRY_AO, // Angola
	COUNTRY_KE, // Kenya
	COUNTRY_GA, // Gabon
	COUNTRY_ML, // Mali
	COUNTRY_BJ, // Benin
	COUNTRY_MG, // Madagascar
	COUNTRY_TD, // Chad
	COUNTRY_BW, // Botswana
	COUNTRY_LY, // Libyan Arab Jamahiriya
	COUNTRY_CV, // Cape Verde
	COUNTRY_RW, // Rwanda
	COUNTRY_MZ, // Mozambique
	COUNTRY_GM, // Gambia
	COUNTRY_LS, // Lesotho
	COUNTRY_MU, // Mauritius
	COUNTRY_CG, // Congo
	COUNTRY_UG, // Uganda
	COUNTRY_BF, // Burkina Faso
	COUNTRY_SL, // Sierra Leone
	COUNTRY_SO, // Somalia
	COUNTRY_ZW, // Zimbabwe
	COUNTRY_CD, // Cong
	COUNTRY_NE, // Niger
	COUNTRY_CF, // Central African Republic
	COUNTRY_SZ, // Swaziland
	COUNTRY_TG, // Togo
	COUNTRY_GN, // Guinea
	COUNTRY_LR, // Liberia
	COUNTRY_SC, // Seychelles
	COUNTRY_MA, // Morocco
	COUNTRY_DZ, // Algeria
	COUNTRY_MR, // Mauritania
	COUNTRY_DJ, // Djibouti
	COUNTRY_A2, // Satellite Provider
	COUNTRY_KM, // Comoros
	COUNTRY_RE, // Reunion
	COUNTRY_GQ, // Equatorial Guinea
	COUNTRY_TN, // Tunisia
	COUNTRY_TR, // Turkey
	COUNTRY_BG, // Bulgaria
	COUNTRY_MT, // Malta
	COUNTRY_CZ, // Czech Republic
	COUNTRY_RS, // Serbia
	COUNTRY_EE, // Estonia
	COUNTRY_CY, // Cyprus
	COUNTRY_LB, // Lebanon
	COUNTRY_PL, // Poland
	COUNTRY_LU, // Luxembourg
	COUNTRY_FI, // Finland
	COUNTRY_AT, // Austria
	COUNTRY_PS, // Palestinian Territor
	COUNTRY_AZ, // Azerbaijan
	COUNTRY_RO, // Romania
	COUNTRY_TJ, // Tajikistan
	COUNTRY_LV, // Latvia
	COUNTRY_BY, // Belarus
	COUNTRY_IS, // Iceland
	COUNTRY_HU, // Hungary
	COUNTRY_SK, // Slovakia
	COUNTRY_MK, // Macedonia
	COUNTRY_IQ, // Iraq
	COUNTRY_ME, // Montenegro
	COUNTRY_HR, // Croatia
	COUNTRY_JO, // Jordan
	COUNTRY_YE, // Yemen
	COUNTRY_BA, // Bosnia and Herzegovina
	COUNTRY_LT, // Lithuania
	COUNTRY_OM, // Oman
	COUNTRY_BH, // Bahrain
	COUNTRY_GE, // Georgia
	COUNTRY_SY, // Syrian Arab Republic
	COUNTRY_SI, // Slovenia
	COUNTRY_MD, // Moldov
	COUNTRY_AM, // Armenia
	COUNTRY_AL, // Albania
	COUNTRY_PA, // Panama
	COUNTRY_BN, // Brunei Darussalam
	COUNTRY_LK, // Sri Lanka
	COUNTRY_KW, // Kuwait
	COUNTRY_AX, // Aland Islands
	COUNTRY_AG, // Antigua and Barbuda
	COUNTRY_SM, // San Marino
	COUNTRY_FK, // Falkland Islands (Malvinas)
	COUNTRY_UZ, // Uzbekistan
	COUNTRY_MC, // Monaco
	COUNTRY_HT, // Haiti
	COUNTRY_GU, // Guam
	COUNTRY_JM, // Jamaica
	COUNTRY_UM, // United States Minor Outlying Islands
	COUNTRY_FM, // Micronesi
	COUNTRY_EC, // Ecuador
	COUNTRY_CO, // Colombia
	COUNTRY_PE, // Peru
	COUNTRY_KY, // Cayman Islands
	COUNTRY_HN, // Honduras
	COUNTRY_VG, // Virgin Island
	COUNTRY_NI, // Nicaragua
	COUNTRY_DO, // Dominican Republic
	COUNTRY_GD, // Grenada
	COUNTRY_GT, // Guatemala
	COUNTRY_CR, // Costa Rica
	COUNTRY_SV, // El Salvador
	COUNTRY_VE, // Venezuela
	COUNTRY_BB, // Barbados
	COUNTRY_TT, // Trinidad and Tobago
	COUNTRY_BV, // Bouvet Island
	COUNTRY_MH, // Marshall Islands
	COUNTRY_CK, // Cook Islands
	COUNTRY_GI, // Gibraltar
	COUNTRY_PY, // Paraguay
	COUNTRY_A1, // Anonymous Proxy
	COUNTRY_WS, // Samoa
	COUNTRY_KN, // Saint Kitts and Nevis
	COUNTRY_UY, // Uruguay
	COUNTRY_MP, // Northern Mariana Islands
	COUNTRY_PW, // Palau
	COUNTRY_QA, // Qatar
	COUNTRY_AS, // American Samoa
	COUNTRY_TC, // Turks and Caicos Islands
	COUNTRY_LC, // Saint Lucia
	COUNTRY_VA, // Holy See (Vatican City State)
	COUNTRY_LA, // Lao People's Democratic Republic
	COUNTRY_AW, // Aruba
	COUNTRY_GY, // Guyana
	COUNTRY_SR, // Suriname
	COUNTRY_IM, // Isle of Man
	COUNTRY_VU, // Vanuatu
	COUNTRY_KP, // Kore
	COUNTRY_AI, // Anguilla
	COUNTRY_MS, // Montserrat
	COUNTRY_PM, // Saint Pierre and Miquelon
	COUNTRY_GP, // Guadeloupe
	COUNTRY_MF, // Saint Martin
	COUNTRY_GG, // Guernsey
	COUNTRY_BI, // Burundi
	COUNTRY_TM, // Turkmenistan
	COUNTRY_KG, // Kyrgyzstan
	COUNTRY_MM, // Myanmar
	COUNTRY_BT, // Bhutan
	COUNTRY_LI, // Liechtenstein
	COUNTRY_FO, // Faroe Islands
	COUNTRY_ET, // Ethiopia
	COUNTRY_MQ, // Martinique
	COUNTRY_JE, // Jersey
	COUNTRY_AD, // Andorra
	COUNTRY_AQ, // Antarctica
	COUNTRY_IO, // British Indian Ocean Territory
	COUNTRY_ER, // Eritrea
	COUNTRY_GL, // Greenland
	COUNTRY_GW, // Guinea-Bissau
	COUNTRY_PF, // French Polynesia
	COUNTRY_CU, // Cuba
	COUNTRY_TO, // Tonga
	COUNTRY_TL, // Timor-Leste
	COUNTRY_ST, // Sao Tome and Principe
	COUNTRY_GF, // French Guiana
	COUNTRY_SB, // Solomon Islands
	COUNTRY_TV, // Tuvalu
	COUNTRY_KI, // Kiribati
	COUNTRY_NU, // Niue
	COUNTRY_NF, // Norfolk Island
	COUNTRY_NR, // Nauru
	COUNTRY_YT  // Mayotte
};

#pragma pack 0


stock GetPlayerCountryName( iPlayer )
{
	new
		iCountryIndex = CallRemoteFunction( "GetPlayerCountryIndex", "i", iPlayer ),
		szCountryName[ MAX_COUNTRY_NAME ]
	;
	
	strunpack( szCountryName, g_aszCountryInfo[ iCountryIndex ][ e_szCountryName ] );
	
	return szCountryName;
}

stock bool:GetPlayerCountryNameEx( iPlayer, szCountryName[ ], iSize = sizeof( szCountryName ) )
{
	new
		iCountryIndex = CallRemoteFunction( "GetPlayerCountryIndex", "i", iPlayer )
	;
	
	strunpack( szCountryName, g_aszCountryInfo[ iCountryIndex ][ e_szCountryName ], iSize );
	
	return ( iCountryIndex == 0 ) ? ( false ) : ( true );
}

stock GetPlayerCountryCode( iPlayer )
{
	new
		iCountryIndex = CallRemoteFunction( "GetPlayerCountryIndex", "i", iPlayer ),
		szCountryCode[ MAX_COUNTRY_CODE ]
	;
	
	strunpack( szCountryCode, g_aszCountryInfo[ iCountryIndex ][ e_szCountryCode ] );
	
	return szCountryCode;
}

stock bool:GetPlayerCountryCodeEx( iPlayer, szCountryCode[ ], iSize = sizeof( szCountryCode ) )
{
	new
		iCountryIndex = CallRemoteFunction( "GetPlayerCountryIndex", "i", iPlayer )
	;
	
	strunpack( szCountryCode, g_aszCountryInfo[ iCountryIndex ][ e_szCountryCode ], iSize );
	
	return ( iCountryIndex == 0 ) ? ( false ) : ( true );
}
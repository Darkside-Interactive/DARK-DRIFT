#include <a_samp> // Главный инклуд
#include <streamer> // Стример обьектов
#include <zcmd> // Для домов
#include <sscanf2> // Для домов
#pragma tabsize 0 //Убирает ошибки типо warning 217: loose indentation
//=[Дефайны]====================================================================
#undef MAX_PLAYERS // Максимальное количество игроков
#define MAX_PLAYERS 50 // Максимальное количество игроков стоит 500 просто вид типо 50
#define HouseFile "House/%i.ini" // Куда будет сохранят дома и вид сохраняения
////////////////////////////////////////////////////////////////////////////////
#define MAX_HOUSES                                      9999 // Максимальное количество домов
#define MAX_HOUSESPERPLAYER                     20 // Максимальное количество домов которое может купить игрок
#define HouseUpgradePercent         100 // Определяет процент для того, чтобы модернизировать дом (дом 10 м. может быть модернизирован для 5 м. когда установлено в 50),
#define ParkRange                   150.0 // Определяет диапазон для того чтобы припарковать авто вокруг дома которому это принадлежит ( Стоит = 150 m)
//-[Диалоги меню]---------------------------------------------------------------
#define DialogHouseMenu             5111
#define DialogUpgradeHouse          5222
#define DialogGoHome                5333
#define DialogHouseNameChange       5444
#define DialogSellHouse             5555
#define DialogBuyCarClass           5666
#define DialogBuyCar                5777
#define DialogSellCar               5888
#define DialogBuyInsurance          5999
#define DialogGetCarSelectHouse     5228
#define DialogGetCarSelectCar       5227
//-[Классы авто]----------------------------------------------------------------
#define VClassBike          1
#define VClassBoat          2
#define VClassConvertible   3
#define VClassHelicopter    4
#define VClassIndustrial    5
#define VClassLowRider      6
#define VClassOffRoad       7
#define VClassPlane         8
#define VClassPublic        9
#define VClassRCVehicle     10
#define VClassSaloons       11
#define VClassSportCar      12
#define VClassStationCar    13
#define VClassTrailer       14
#define VClassUnique        15
//=[Невы]=======================================================================
new bool:SpawnAtHouse = false; // Если поставить "true" то спавн будет дома, а если "false" то спавн будет как в игре
new ExitHouseTimer = 1000; // Таймер замораживает игрока при выходе из игры чтобы загрузились обьекты или дома
new bool:ShowBoughtHouses = false; // Если поставить "true" то на карте будет показывать купленные дома, а если поставить "false" то не будет показывать
new bool:LoadCarsDuringFSInit = false; // Если поставить "true" то загрузит авто прямо на дома а если поставить "false" то авто загрузится прямо перед игроком на улице
new bool:AutomaticInsurance = true; // Если поставить "true" у всех авто будет страховка и после взрыва они смогут вернуть, авто а если поставить "false" то тачка исчезнет после взрыва

enum THouseData // Главное сохранение дома
{
        PickupID,
        Text3D:DoorText,
        MapIconID,

        bool:Owned,
        Owner[24],

        HouseName[100],
        Float:HouseX,
        Float:HouseY,
        Float:HouseZ,
        HouseLevel,
        HouseMaxLevel,
        HousePrice,
        bool:HouseOpened,
        bool:Insurance,
        VehicleIDs[10],

        bool:StaticHouse,
        CarSlots
}

new AHouseData[MAX_HOUSES][THouseData];

enum TVehicleData // Вид сохранения тюнига
{
        BelongsToHouse,

        bool:Owned,
        Owner[24],

        Model,
        PaintJob,
        Components[14],
        Color1,
        Color2,

        Float:SpawnX,
        Float:SpawnY,
        Float:SpawnZ,
        Float:SpawnRot
}

new AVehicleData[2000][TVehicleData];

enum TPlayerData // Вид сохранения домов
{
        Houses[20],
    CurrentHouse,
        DialogBuyVClass,
        DialogGetCarHouseID
}

new APlayerData[MAX_PLAYERS][TPlayerData];

enum THouseInterior // Вид сохранения интерьера
{
        InteriorName[50],
        InteriorID,
        Float:IntX,
        Float:IntY,
        Float:IntZ
}

new AHouseInteriors[][THouseInterior] = // Интерьеры на покупку
{
        {"Dummy",                               0,              0.0,            0.0,            0.0}, // Level 0
        {"Small motel room",    10,     2262.83,        -1137.71,       1050.63}, // Level 1
        {"Small house",                 2,              2467.36,        -1698.38,       1013.51}, // Level 2
        {"Small house 2",               1,              223.00,         1289.26,        1082.20}, // Level 3
        {"Medium house",                10,     2260.76,        -1210.45,       1049.02}, // Level 4
        {"Medium house 2",              8,              2365.42,        -1131.85,       1050.88}, // Level 5
        {"Duplex house",                12,     2324.33,        -1144.79,       1050.71}, // Level 6
        {"Big house",                   15,     295.14,         1474.47,        1080.52}, // Level 7
        {"Big duplex house",    3,              235.50,         1189.17,        1080.34}, // Level 8
        {"Huge house",                  7,              225.63,         1022.48,        1084.07}, // Level 9
        {"Mansion",                     5,              1299.14,        -794.77,        1084.00} // Level 10
};

enum TBuyableVehicle // Вид сохранения авто
{
        CarName[50],
        VehicleClass,
        CarModel,
        Price
}

new ABuyableVehicles[][TBuyableVehicle] = // Список авто на покупку с ценой и с id"ми
{
        {"Admiral", VClassSaloons, 445, 50000},
        {"Alpha", VClassSportCar, 602, 50000},
        {"Ambulance", VClassPublic, 416, 50000},
        {"Andromada", VClassPlane, 592, 50000},
        {"Article Trailer", VClassTrailer, 591, 50000},
        {"Baggage", VClassUnique, 485, 50000},
        {"Baggage Trailer A", VClassTrailer, 606, 50000},
        {"Baggage Trailer B", VClassTrailer, 607, 50000},
        {"Bandito", VClassOffRoad, 568, 50000},
        {"Banshee", VClassSportCar, 429, 50000},
        {"Barracks", VClassPublic, 433, 50000},
        {"Beagle", VClassPlane, 511, 50000},
        {"Benson", VClassIndustrial, 499, 50000},
        {"Berkley's RC Van", VClassIndustrial, 459, 50000},
        {"BF Injection", VClassOffRoad, 424, 50000},
        {"BF-400", VClassBike, 581, 50000},
        {"Bike", VClassBike, 509, 50000},
        {"Blade", VClassLowRider, 536, 50000},
        {"Blista Compact", VClassSportCar, 496, 50000},
        {"Bloodring Banger", VClassSaloons, 504, 50000},
        {"BMX", VClassBike, 481, 50000},
        {"Bobcat", VClassIndustrial, 422, 50000},
        {"Boxville 1", VClassIndustrial, 498, 50000},
        {"Boxville 2", VClassIndustrial, 609, 50000},
        {"Bravura", VClassSaloons, 401, 50000},
        {"Broadway", VClassLowRider, 575, 50000},
        {"Buccaneer", VClassSaloons, 518, 50000},
        {"Buffalo", VClassSportCar, 402, 50000},
        {"Bullet", VClassSportCar, 541, 50000},
        {"Burrito", VClassIndustrial, 482, 50000},
        {"Bus", VClassPublic, 431, 50000},
        {"Cabbie", VClassPublic, 438, 50000},
        {"Caddy", VClassUnique, 457, 50000},
        {"Cadrona", VClassSaloons, 527, 50000},
        {"Camper", VClassUnique, 483, 50000},
        {"Cargo Trailer", VClassTrailer, 435, 50000},
        {"Cargobob", VClassHelicopter, 548, 50000},
        {"Cement Truck", VClassIndustrial, 524, 50000},
        {"Cheetah", VClassSportCar, 415, 50000},
        {"Clover", VClassSaloons, 542, 50000},
        {"Club", VClassSportCar, 589, 50000},
        {"Coach", VClassPublic, 437, 50000},
        {"Coastguard", VClassBoat, 472, 50000},
        {"Combine Harvester", VClassUnique, 532, 50000},
        {"Comet", VClassConvertible, 480, 50000},
        {"Cropduster", VClassPlane, 512, 50000},
        {"DFT-30", VClassIndustrial, 578, 50000},
        {"Dinghy", VClassBoat, 473, 50000},
        {"Dodo", VClassPlane, 593, 50000},
        {"Dozer", VClassUnique, 486, 50000},
        {"Dumper", VClassUnique, 406, 50000},
        {"Dune", VClassOffRoad, 573, 50000},
        {"Elegant", VClassSaloons, 507, 50000},
        {"Elegy", VClassSaloons, 562, 50000},
        {"Emperor", VClassSaloons, 585, 50000},
        {"Enforcer", VClassPublic, 427, 50000},
        {"Esperanto", VClassSaloons, 419, 50000},
        {"Euros", VClassSportCar, 587, 50000},
        {"Faggio", VClassBike, 462, 50000},
        {"Farm Trailer", VClassTrailer, 610, 50000},
        {"FBI Rancher", VClassPublic, 490, 50000},
        {"FBI Truck", VClassPublic, 528, 50000},
        {"FCR-900", VClassBike, 521, 50000},
        {"Feltzer", VClassConvertible, 533, 50000},
        {"Firetruck", VClassPublic, 407, 50000},
        {"Firetruck LA", VClassPublic, 544, 50000},
        {"Flash", VClassSportCar, 565, 50000},
        {"Flatbed", VClassIndustrial, 455, 50000},
        {"Fluids Trailer", VClassTrailer, 584, 50000},
        {"Forklift", VClassUnique, 530, 50000},
        {"Fortune", VClassSaloons, 526, 50000},
        {"Freeway", VClassBike, 463, 50000},
        {"Glendale", VClassSaloons, 466, 50000},
        {"Glendale Shit", VClassSaloons, 604, 50000},
        {"Greenwood", VClassSaloons, 492, 50000},
        {"Hermes", VClassSaloons, 474, 50000},
        {"Hotdog", VClassUnique, 588, 50000},
        {"Hotknife", VClassUnique, 434, 50000},
        {"Hotring Racer 1", VClassSportCar, 494, 50000},
        {"Hotring Racer 2", VClassSportCar, 502, 50000},
        {"Hotring Racer 3", VClassSportCar, 503, 50000},
        {"HPV1000", VClassPublic, 523, 50000},
        {"Hunter", VClassHelicopter, 425, 50000},
        {"Huntley", VClassOffRoad, 579, 50000},
        {"Hustler", VClassUnique, 545, 50000},
        {"Hydra", VClassPlane, 520, 50000},
        {"Infernus", VClassSportCar, 411, 50000},
        {"Intruder", VClassSaloons, 546, 50000},
        {"Jester", VClassSportCar, 559, 50000},
        {"Jetmax", VClassBoat, 493, 50000},
        {"Journey", VClassUnique, 508, 50000},
        {"Kart", VClassUnique, 571, 50000},
        {"Landstalker", VClassOffRoad, 400, 50000},
        {"Launch", VClassBoat, 595, 50000},
        {"Leviathan", VClassHelicopter, 417, 50000},
        {"Linerunner", VClassIndustrial, 403, 50000},
        {"Majestic", VClassSaloons, 517, 50000},
        {"Manana", VClassSaloons, 410, 50000},
        {"Marquis", VClassBoat, 484, 50000},
        {"Maverick", VClassHelicopter, 487, 50000},
        {"Merit", VClassSaloons, 551, 50000},
        {"Mesa", VClassOffRoad, 500, 50000},
        {"Monster", VClassOffRoad, 444, 50000},
        {"Monster A", VClassOffRoad, 556, 50000},
        {"Monster B", VClassOffRoad, 557, 50000},
        {"Moonbeam", VClassStationCar, 418, 50000},
        {"Mountain Bike", VClassBike, 510, 50000},
        {"Mower", VClassUnique, 572, 50000},
        {"Mr Whoopee", VClassUnique, 423, 50000},
        {"Mule", VClassIndustrial, 414, 50000},
        {"Nebula", VClassSaloons, 516, 50000},
        {"Nevada", VClassPlane, 553, 50000},
        {"Newsvan", VClassIndustrial, 582, 50000},
        {"NRG-500", VClassBike, 522, 50000},
        {"Oceanic", VClassSaloons, 467, 50000},
        {"Ore Trailer", VClassTrailer, 450, 50000},
        {"Packer", VClassIndustrial, 443, 50000},
        {"Patriot", VClassOffRoad, 470, 50000},
        {"PCJ-600", VClassBike, 461, 50000},
        {"Perenniel", VClassStationCar, 404, 50000},
        {"Phoenix", VClassSportCar, 603, 50000},
        {"Picador", VClassIndustrial, 600, 50000},
        {"Pizzaboy", VClassBike, 448, 50000},
        {"Police Car (LSPD)", VClassPublic, 596, 50000},
        {"Police Car (LVPD)", VClassPublic, 598, 50000},
        {"Police Car (SFPD)", VClassPublic, 597, 50000},
        {"Police Maverick", VClassHelicopter, 497, 50000},
        {"Police Ranger", VClassPublic, 599, 50000},
        {"Pony", VClassIndustrial, 413, 50000},
        {"Predator", VClassBoat, 430, 50000},
        {"Premier", VClassSaloons, 426, 50000},
        {"Previon", VClassSaloons, 436, 50000},
        {"Primo", VClassSaloons, 547, 50000},
        {"Quad", VClassBike, 471, 50000},
        {"Raindance", VClassHelicopter, 563, 50000},
        {"Rancher 1", VClassOffRoad, 489, 50000},
        {"Rancher 2", VClassOffRoad, 505, 50000},
        {"Reefer", VClassBoat, 453, 50000},
        {"Regina", VClassStationCar, 479, 50000},
        {"Remington", VClassLowRider, 534, 50000},
        {"Rhino", VClassPublic, 432, 50000},
        {"Roadtrain", VClassIndustrial, 515, 50000},
        {"Romero", VClassUnique, 442, 50000},
        {"Rumpo", VClassIndustrial, 440, 50000},
        {"Rustler", VClassPlane, 476, 50000},
        {"Sabre", VClassSportCar, 475, 50000},
        {"Sadler", VClassIndustrial, 543, 50000},
        {"Sadler Shit", VClassIndustrial, 605, 50000},
        {"SAN News Maverick", VClassHelicopter, 488, 50000},
        {"Sanchez", VClassBike, 468, 50000},
        {"Sandking", VClassOffRoad, 495, 50000},
        {"Savanna", VClassLowRider, 567, 50000},
        {"Seasparrow", VClassHelicopter, 447, 50000},
        {"Securicar", VClassUnique, 428, 50000},
        {"Sentinel", VClassSaloons, 405, 50000},
        {"Shamal", VClassPlane, 519, 50000},
        {"Skimmer", VClassPlane, 460, 50000},
        {"Slamvan", VClassLowRider, 535, 50000},
        {"Solair", VClassStationCar, 458, 50000},
        {"Sparrow", VClassHelicopter, 469, 50000},
        {"Speeder", VClassBoat, 452, 50000},
        {"Squallo", VClassBoat, 446, 50000},
        {"Stafford", VClassSaloons, 580, 50000},
        {"Stallion", VClassConvertible, 439, 50000},
        {"Stratum", VClassStationCar, 561, 50000},
        {"Stretch", VClassUnique, 409, 50000},
        {"Stuntplane", VClassPlane, 513, 50000},
        {"Sultan", VClassSaloons, 560, 50000},
        {"Sunrise", VClassSaloons, 550, 50000},
        {"Super GT", VClassSportCar, 506, 50000},
        {"S.W.A.T.", VClassPublic, 601, 50000},
        {"Sweeper", VClassUnique, 574, 50000},
        {"Tahoma", VClassLowRider, 566, 50000},
        {"Tampa", VClassSaloons, 549, 50000},
        {"Tanker", VClassIndustrial, 514, 50000},
        {"Taxi", VClassPublic, 420, 50000},
        {"Tornado", VClassLowRider, 576, 50000},
        {"Towtruck", VClassUnique, 525, 50000},
        {"Tractor", VClassIndustrial, 531, 50000},
        {"Trashmaster", VClassIndustrial, 408, 50000},
        {"Tropic", VClassBoat, 454, 50000},
        {"Tug", VClassUnique, 583, 50000},
        {"Tug Stairs Trailer", VClassTrailer, 608, 50000},
        {"Turismo", VClassSportCar, 451, 50000},
        {"Uranus", VClassSportCar, 558, 50000},
        {"Utility Trailer", VClassTrailer, 611, 50000},
        {"Utility Van", VClassIndustrial, 552, 50000},
        {"Vincent", VClassSaloons, 540, 50000},
        {"Virgo", VClassSaloons, 491, 50000},
        {"Voodoo", VClassLowRider, 412, 50000},
        {"Vortex", VClassUnique, 539, 50000},
        {"Walton", VClassIndustrial, 478, 50000},
        {"Washington", VClassSaloons, 421, 50000},
        {"Wayfarer", VClassBike, 586, 50000},
        {"Willard", VClassSaloons, 529, 50000},
        {"Windsor", VClassConvertible, 555, 50000},
    {"Yankee", VClassIndustrial, 456, 50000},
        {"Yosemite", VClassIndustrial, 554, 50000},
        {"ZR-350", VClassSportCar, 477, 50000}
};

new AVehicleModPrices[] = // Тюнинг авто с сохранением
{
        400, // ID 1000, Spoiler Pro                                                            Certain Transfender cars
        550, // ID 1001, Spoiler Win                                                            Certain Transfender cars
        200, // ID 1002, Spoiler Drag                                                           Certain Transfender cars
        250, // ID 1003, Spoiler Alpha                                                          Certain Transfender cars
        100, // ID 1004, Hood Champ Scoop                                                       Certain Transfender cars
        150, // ID 1005, Hood Fury Scoop                                                        Certain Transfender cars
        80, // ID 1006, Roof Roof Scoop                                                         Certain Transfender cars
        500, // ID 1007, Sideskirt Right Sideskirt                                      Certain Transfender cars
        500, // ID 1008, Nitro 5 times                                                          Most cars, Most planes and Most Helicopters
        200, // ID 1009, Nitro 2 times                                                          Most cars, Most planes and Most Helicopters
        1000, // ID 1010, Nitro 10 times                                        Most cars, Most planes and Most Helicopters
        220, // ID 1011, Hood Race Scoop                                        Certain Transfender cars
        250, // ID 1012, Hood Worx Scoop                                        Certain Transfender cars
        100, // ID 1013, Lamps Round Fog                                        Certain Transfender cars
        400, // ID 1014, Spoiler Champ                                          Certain Transfender cars
        500, // ID 1015, Spoiler Race                                           Certain Transfender cars
        200, // ID 1016, Spoiler Worx                                           Certain Transfender cars
        500, // ID 1017, Sideskirt Left Sideskirt                               Certain Transfender cars
        350, // ID 1018, Exhaust Upswept                                        Most cars
        300, // ID 1019, Exhaust Twin                                           Most cars
        250, // ID 1020, Exhaust Large                                          Most cars
        200, // ID 1021, Exhaust Medium                                                         Most cars
        150, // ID 1022, Exhaust Small                                                          Most cars
        350, // ID 1023, Spoiler Fury                                           Certain Transfender cars
        50, // ID 1024, Lamps Square Fog                                                        Certain Transfender cars
        1000, // ID 1025, Wheels Offroad                                                        Certain Transfender cars
        480, // ID 1026, Sideskirt Right Alien Sideskirt                        Sultan
        480, // ID 1027, Sideskirt Left Alien Sideskirt                         Sultan
        770, // ID 1028, Exhaust Alien                                  Sultan
        680, // ID 1029, Exhaust X-Flow                                                         Sultan
        370, // ID 1030, Sideskirt Left X-Flow Sideskirt                Sultan
        370, // ID 1031, Sideskirt Right X-Flow Sideskirt               Sultan
        170, // ID 1032, Roof Alien Roof Vent                                           Sultan
        120, // ID 1033, Roof X-Flow Roof Vent                          Sultan
        790, // ID 1034, Exhaust Alien                                                          Elegy
        150, // ID 1035, Roof X-Flow Roof Vent                                          Elegy
        500, // ID 1036, SideSkirt Right Alien Sideskirt                Elegy
        690, // ID 1037, Exhaust X-Flow                                                         Elegy
        190, // ID 1038, Roof Alien Roof Vent                                           Elegy
        390, // ID 1039, SideSkirt Right X-Flow Sideskirt               Elegy
        500, // ID 1040, SideSkirt Left Alien Sideskirt                         Elegy
        390, // ID 1041, SideSkirt Right X-Flow Sideskirt               Elegy
        1000, // ID 1042, SideSkirt Right Chrome Sideskirt                      Broadway
        500, // ID 1043, Exhaust Slamin                                 Broadway
        500, // ID 1044, Exhaust Chrome                                                         Broadway
        510, // ID 1045, Exhaust X-Flow                                                         Flash
        710, // ID 1046, Exhaust Alien                                                          Flash
        670, // ID 1047, SideSkirt Right Alien Sideskirt                Flash
        530, // ID 1048, SideSkirt Right X-Flow Sideskirt                       Flash
        810, // ID 1049, Spoiler Alien                                                          Flash
        620, // ID 1050, Spoiler X-Flow                                 Flash
        670, // ID 1051, SideSkirt Left Alien Sideskirt                 Flash
        530, // ID 1052, SideSkirt Left X-Flow Sideskirt                        Flash
        130, // ID 1053, Roof X-Flow                                                            Flash
        210, // ID 1054, Roof Alien                                                                     Flash
        230, // ID 1055, Roof Alien                                                                     Stratum
        520, // ID 1056, Sideskirt Right Alien Sideskirt                        Stratum
        430, // ID 1057, Sideskirt Right X-Flow Sideskirt                       Stratum
        620, // ID 1058, Spoiler Alien                                                          Stratum
        720, // ID 1059, Exhaust X-Flow                                                         Stratum
        530, // ID 1060, Spoiler X-Flow                                                         Stratum
        180, // ID 1061, Roof X-Flow                                                            Stratum
        520, // ID 1062, Sideskirt Left Alien Sideskirt                         Stratum
        430, // ID 1063, Sideskirt Left X-Flow Sideskirt                        Stratum
        830, // ID 1064, Exhaust Alien                                                          Stratum
        850, // ID 1065, Exhaust Alien                                                          Jester
        750, // ID 1066, Exhaust X-Flow                                                         Jester
        250, // ID 1067, Roof Alien                                                                     Jester
        200, // ID 1068, Roof X-Flow                                                            Jester
        550, // ID 1069, Sideskirt Right Alien Sideskirt                        Jester
        450, // ID 1070, Sideskirt Right X-Flow Sideskirt                       Jester
        550, // ID 1071, Sideskirt Left Alien Sideskirt                         Jester
        450, // ID 1072, Sideskirt Left X-Flow Sideskirt                        Jester
        1100, // ID 1073, Wheels Shadow                                                         Most cars
        1030, // ID 1074, Wheels Mega                                                           Most cars
        980, // ID 1075, Wheels Rimshine                                                        Most cars
        1560, // ID 1076, Wheels Wires                                                          Most cars
        1620, // ID 1077, Wheels Classic                                                        Most cars
        1200, // ID 1078, Wheels Twist                                                          Most cars
        1030, // ID 1079, Wheels Cutter                                                         Most cars
        900, // ID 1080, Wheels Switch                                                          Most cars
        1230, // ID 1081, Wheels Grove                                                          Most cars
        820, // ID 1082, Wheels Import                                                          Most cars
        1560, // ID 1083, Wheels Dollar                                                         Most cars
        1350, // ID 1084, Wheels Trance                                                         Most cars
        770, // ID 1085, Wheels Atomic                                                          Most cars
        100, // ID 1086, Stereo Stereo                                                          Most cars
        1500, // ID 1087, Hydraulics Hydraulics                                         Most cars
        150, // ID 1088, Roof Alien                                                                     Uranus
        650, // ID 1089, Exhaust X-Flow                                                         Uranus
        450, // ID 1090, Sideskirt Right Alien Sideskirt                        Uranus
        100, // ID 1091, Roof X-Flow                                                            Uranus
        750, // ID 1092, Exhaust Alien                                                          Uranus
        350, // ID 1093, Sideskirt Right X-Flow Sideskirt                       Uranus
        450, // ID 1094, Sideskirt Left Alien Sideskirt                         Uranus
        350, // ID 1095, Sideskirt Right X-Flow Sideskirt                       Uranus
        1000, // ID 1096, Wheels Ahab                                                           Most cars
        620, // ID 1097, Wheels Virtual                                                         Most cars
        1140, // ID 1098, Wheels Access                                                         Most cars
        1000, // ID 1099, Sideskirt Left Chrome Sideskirt                       Broadway
        940, // ID 1100, Bullbar Chrome Grill                                           Remington
        780, // ID 1101, Sideskirt Left `Chrome Flames` Sideskirt       Remington
        830, // ID 1102, Sideskirt Left `Chrome Strip` Sideskirt        Savanna
        3250, // ID 1103, Roof Convertible                                                      Blade
        1610, // ID 1104, Exhaust Chrome                                                        Blade
        1540, // ID 1105, Exhaust Slamin                                                        Blade
        780, // ID 1106, Sideskirt Right `Chrome Arches`                        Remington
        780, // ID 1107, Sideskirt Left `Chrome Strip` Sideskirt        Blade
        780, // ID 1108, Sideskirt Right `Chrome Strip` Sideskirt       Blade
        1610, // ID 1109, Rear Bullbars Chrome                                          Slamvan
        1540, // ID 1110, Rear Bullbars Slamin                                          Slamvan
        55, // ID 1111, Front Sign? Little Sign?                                        Slamvan         ???
        55, // ID 1112, Front Sign? Little Sign?                                        Slamvan         ???
        3340, // ID 1113, Exhaust Chrome                                                        Slamvan
        3250, // ID 1114, Exhaust Slamin                                                        Slamvan
        2130, // ID 1115, Front Bullbars Chrome                                         Slamvan
        2050, // ID 1116, Front Bullbars Slamin                                         Slamvan
        2040, // ID 1117, Front Bumper Chrome                                           Slamvan
        780, // ID 1118, Sideskirt Right `Chrome Trim` Sideskirt        Slamvan
        940, // ID 1119, Sideskirt Right `Wheelcovers` Sideskirt        Slamvan
        780, // ID 1120, Sideskirt Left `Chrome Trim` Sideskirt         Slamvan
        940, // ID 1121, Sideskirt Left `Wheelcovers` Sideskirt         Slamvan
        780, // ID 1122, Sideskirt Right `Chrome Flames` Sideskirt      Remington
        860, // ID 1123, Bullbars Bullbar Chrome Bars                           Remington
        780, // ID 1124, Sideskirt Left `Chrome Arches` Sideskirt       Remington
        1120, // ID 1125, Bullbars Bullbar Chrome Lights                        Remington
        3340, // ID 1126, Exhaust Chrome Exhaust                                        Remington
        3250, // ID 1127, Exhaust Slamin Exhaust                                        Remington
        3340, // ID 1128, Roof Vinyl Hardtop                                            Blade
        1650, // ID 1129, Exhaust Chrome                                                        Savanna
        3380, // ID 1130, Roof Hardtop                                                          Savanna
        3290, // ID 1131, Roof Softtop                                                          Savanna
        1590, // ID 1132, Exhaust Slamin                                                        Savanna
        830, // ID 1133, Sideskirt Right `Chrome Strip` Sideskirt       Savanna
        800, // ID 1134, SideSkirt Right `Chrome Strip` Sideskirt       Tornado
        1500, // ID 1135, Exhaust Slamin                                                        Tornado
        1000, // ID 1136, Exhaust Chrome                                                        Tornado
        800, // ID 1137, Sideskirt Left `Chrome Strip` Sideskirt        Tornado
        580, // ID 1138, Spoiler Alien                                                          Sultan
        470, // ID 1139, Spoiler X-Flow                                                         Sultan
        870, // ID 1140, Rear Bumper X-Flow                                                     Sultan
        980, // ID 1141, Rear Bumper Alien                                                      Sultan
        150, // ID 1142, Vents Left Oval Vents                                          Certain Transfender Cars
        150, // ID 1143, Vents Right Oval Vents                                         Certain Transfender Cars
        100, // ID 1144, Vents Left Square Vents                                        Certain Transfender Cars
        100, // ID 1145, Vents Right Square Vents                                       Certain Transfender Cars
        490, // ID 1146, Spoiler X-Flow                                                         Elegy
        600, // ID 1147, Spoiler Alien                                                          Elegy
        890, // ID 1148, Rear Bumper X-Flow                                                     Elegy
        1000, // ID 1149, Rear Bumper Alien                                                     Elegy
        1090, // ID 1150, Rear Bumper Alien                                                     Flash
        840, // ID 1151, Rear Bumper X-Flow                                                     Flash
        910, // ID 1152, Front Bumper X-Flow                                            Flash
        1200, // ID 1153, Front Bumper Alien                                            Flash
        1030, // ID 1154, Rear Bumper Alien                                                     Stratum
        1030, // ID 1155, Front Bumper Alien                                            Stratum
        920, // ID 1156, Rear Bumper X-Flow                                                     Stratum
        930, // ID 1157, Front Bumper X-Flow                                            Stratum
        550, // ID 1158, Spoiler X-Flow                                                         Jester
        1050, // ID 1159, Rear Bumper Alien                                                     Jester
        1050, // ID 1160, Front Bumper Alien                                            Jester
        950, // ID 1161, Rear Bumper X-Flow                                                     Jester
        650, // ID 1162, Spoiler Alien                                                          Jester
        450, // ID 1163, Spoiler X-Flow                                                         Uranus
        550, // ID 1164, Spoiler Alien                                                          Uranus
        850, // ID 1165, Front Bumper X-Flow                                            Uranus
        950, // ID 1166, Front Bumper Alien                                                     Uranus
        850, // ID 1167, Rear Bumper X-Flow                                                     Uranus
        950, // ID 1168, Rear Bumper Alien                                                      Uranus
        970, // ID 1169, Front Bumper Alien                                                     Sultan
        880, // ID 1170, Front Bumper X-Flow                                            Sultan
        990, // ID 1171, Front Bumper Alien                                                     Elegy
        900, // ID 1172, Front Bumper X-Flow                                            Elegy
        950, // ID 1173, Front Bumper X-Flow                                            Jester
        1000, // ID 1174, Front Bumper Chrome                                           Broadway
        900, // ID 1175, Front Bumper Slamin                                            Broadway
        1000, // ID 1176, Rear Bumper Chrome                                            Broadway
        900, // ID 1177, Rear Bumper Slamin                                                     Broadway
        2050, // ID 1178, Rear Bumper Slamin                                            Remington
        2150, // ID 1179, Front Bumper Chrome                                           Remington
        2130, // ID 1180, Rear Bumper Chrome                                            Remington
        2050, // ID 1181, Front Bumper Slamin                                           Blade
        2130, // ID 1182, Front Bumper Chrome                                           Blade
        2040, // ID 1183, Rear Bumper Slamin                                            Blade
        2150, // ID 1184, Rear Bumper Chrome                                            Blade
        2040, // ID 1185, Front Bumper Slamin                                           Remington
        2095, // ID 1186, Rear Bumper Slamin                                            Savanna
        2175, // ID 1187, Rear Bumper Chrome                                            Savanna
        2080, // ID 1188, Front Bumper Slamin                                           Savanna
        2200, // ID 1189, Front Bumper Chrome                                           Savanna
        1200, // ID 1190, Front Bumper Slamin                                           Tornado
        1040, // ID 1191, Front Bumper Chrome                                           Tornado
        940, // ID 1192, Rear Bumper Chrome                                                     Tornado
        1100, // ID 1193 Rear Bumper Slamin                                                     Tornado
};
new TotalHouses; // Полные здания
//==============================================================================
main() // печать в окне сервера
{
        print("\n==========================");
        print("   System House by KoTe \n.");
        print("==========================\n");
}
//==============================================================================
public OnFilterScriptInit()
{
        for (new HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
        {
                HouseFile_Load(HouseID);
                if (LoadCarsDuringFSInit == true)
                HouseFile_LoadCars(HouseID);
        }
//------------------------------------------------------------------------------
        CreateDynamicMapIcon(1039, -1032, 32, 27, 0, 0, 0, -1, 150.0); // Гараж тюнинг в ЛС
        CreateDynamicMapIcon(-1936, 235, 34, 27, 0, 0, 0, -1, 150.0); // Гараж тюнинг в СФ
        CreateDynamicMapIcon(2385, 1034, 11, 27, 0, 0, 0, -1, 150.0); // Гараж тюнинг в ЛВ
        CreateDynamicMapIcon(2646, -2025, 14, 27, 0, 0, 0, -1, 150.0); //Архангел тюнинг в СФ
//------------------------------------------------------------------------------
    printf("----------------------------------------");
    printf("Системад домов успешно загружена");
    printf("Дома загружены: %i", TotalHouses);
    printf("----------------------------------------");
    return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
        new HouseID, HouseSlot, Name[24]; // Загружает дом игрока когда он заходит в игру
        GetPlayerName(playerid, Name, sizeof(Name));

        for (HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
        {
                if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                {
                    if (AHouseData[HouseID][Owned] == true)
                    {
                                if (strcmp(AHouseData[HouseID][Owner], Name, false) == 0)
                                {
                                        APlayerData[playerid][Houses][HouseSlot] = HouseID;
                                        if (LoadCarsDuringFSInit == false)
                                        HouseFile_LoadCars(HouseID);
                                        HouseSlot++;
                                }
                    }
                }
        }
        return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
        new HouseSlot; // Сохраняет дом после выхода игрока
        for (HouseSlot = 0; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
        {
                if (APlayerData[playerid][Houses][HouseSlot] != 0)
                {
                        HouseFile_Save(APlayerData[playerid][Houses][HouseSlot]);


                        if (LoadCarsDuringFSInit == false)
                        {
                                House_RemoveVehicles(APlayerData[playerid][Houses][HouseSlot]
);
                        }

                        APlayerData[playerid][Houses][HouseSlot] = 0;
                }
        }
        APlayerData[playerid][CurrentHouse] = 0;
        APlayerData[playerid][DialogBuyVClass] = 0;
        APlayerData[playerid][DialogGetCarHouseID] = 0;
        return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
        switch (dialogid) // Диалог для всего меню
        {
                case DialogHouseMenu: Dialog_HouseMenu(playerid, response, listitem);
                case DialogUpgradeHouse: Dialog_UpgradeHouse(playerid, response, listitem);
                case DialogGoHome: Dialog_GoHome(playerid, response, listitem);
                case DialogHouseNameChange: Dialog_ChangeHouseName(playerid, response, inputtext);
                case DialogSellHouse: Dialog_SellHouse(playerid, response);
                case DialogBuyCarClass: Dialog_BuyCarClass(playerid, response, listitem);
                case DialogBuyCar: Dialog_BuyCar(playerid, response, listitem);
                case DialogSellCar: Dialog_SellCar(playerid, response, listitem);
                case DialogBuyInsurance: Dialog_BuyInsurance(playerid, response);
                case DialogGetCarSelectHouse: Dialog_GetCarSelectHouse(playerid, response, listitem);
                case DialogGetCarSelectCar: Dialog_GetCarSelectCar(playerid, response, listitem);
        }
    return 0;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
        new HouseID;
        APlayerData[playerid][CurrentHouse] = 0; // Перезагружает дом

        if (SpawnAtHouse == true)
        {
                HouseID = APlayerData[playerid][Houses][0];
                if (HouseID != 0)
                {
                        SetPlayerPos(playerid, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]);
                }
        }
        return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
        APlayerData[playerid][CurrentHouse] = 0; // Перезагружает дом

        return 1;
}
//==============================================================================
public OnPlayerRequestClass(playerid, classid)
{
        APlayerData[playerid][CurrentHouse] = 0; // Перезагружает дом

        return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
        APlayerData[playerid][CurrentHouse] = 0; // Перезагружает дом
    return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
        if (AVehicleData[vehicleid][Owned] == true) // Загружает тюнинг авто
        {
                if (AVehicleData[vehicleid][PaintJob] != 0)
                {
                        ChangeVehiclePaintjob(vehicleid, AVehicleData[vehicleid][PaintJob] - 1);
                }
                ChangeVehicleColor(vehicleid, AVehicleData[vehicleid][Color1], AVehicleData[vehicleid][Color2]);

                for (new i; i < 14; i++)
                {
                RemoveVehicleComponent(vehicleid, GetVehicleComponentInSlot(vehicleid, i));

                        if (AVehicleData[vehicleid][Components][i] != 0)
                        AddVehicleComponent(vehicleid, AVehicleData[vehicleid][Components][i]);
                }
        }
    return 1;
}
//==============================================================================
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
        if (AVehicleData[vehicleid][Owned] == true)
        {
                if ((AVehicleData[vehicleid][Color1] != color1) || (AVehicleData[vehicleid][Color2] != color2))
                INT_GivePlayerMoney(playerid, -150);
                AVehicleData[vehicleid][Color1] = color1;
                AVehicleData[vehicleid][Color2] = color2;
                if (color1 == 0)
                AVehicleData[vehicleid][PaintJob] = 0;
        }
        return 1;
}
//==============================================================================
public OnVehicleMod(playerid, vehicleid, componentid) // Для тюнинга авто
{
        if (AVehicleData[vehicleid][Owned] == true)
        {
                INT_GivePlayerMoney(playerid, -AVehicleModPrices[componentid - 1000]);
                AVehicleData[vehicleid][Components][GetVehicleComponentType(componentid)]
 = componentid;
        }
        return 1;
}
//==============================================================================
public OnVehiclePaintjob(playerid, vehicleid, paintjobid) // Для покраски авто
{
        if (AVehicleData[vehicleid][Owned] == true)
        {
            AVehicleData[vehicleid][PaintJob] = paintjobid + 1;
        }
        return 1;
}
//==============================================================================
public OnVehicleDeath(vehicleid)
{
        new HouseID, CarSlot; // После взрыва или разрушения авто он возврашается на место парковки
        if (AVehicleData[vehicleid][Owned] == true)
        {
                HouseID = AVehicleData[vehicleid][BelongsToHouse];

                if (AutomaticInsurance == false)
                {
                        if (HouseID != 0)
                        {
                                if (AHouseData[HouseID][Insurance] == false)
                                {
                                        for (CarSlot = 0; CarSlot < 10; CarSlot++)
                                        {
                                                if (AHouseData[HouseID][VehicleIDs][CarSlot] == vehicleid)
                                                    break;
                                        }
                                        Vehicle_Delete(vehicleid, HouseID, CarSlot);
                                    HouseFile_Save(HouseID);
                                }
                        }
                }
        }
        return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid,newstate,oldstate)
{
        new vid, Name[24], Msg[128], engine, lights, alarm, doors, bonnet, boot, objective;

        if (newstate == PLAYER_STATE_DRIVER) // Для того чтобы игрок не смог угнать машину другого игрока
        {
                vid = GetPlayerVehicleID(playerid);
                GetPlayerName(playerid, Name, sizeof(Name));

                if (AVehicleData[vid][Owned] == true)
                {
                        if (strcmp(AVehicleData[vid][Owner], Name, false) != 0)
                        {
                                RemovePlayerFromVehicle(playerid);
                                GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
                                SetVehicleParamsEx(vid, 0, 0, alarm, doors, bonnet, boot, objective);
                                format(Msg, 128, "Вы не можете использовать авомобиль игрока \"%s\"", AVehicleData[vid][Owner]);
                                SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                        }
                }
        }
        return 1;
}
//==============================================================================
COMMAND:createhouse(playerid, params[]) // Создать дом
{
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;
        if (INT_CheckPlayerAdminLevel(playerid, 5) == 0) return 0;
        new HPrice, MaxLevel, HouseID;

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                if (sscanf(params, "ii", HPrice, MaxLevel)) SendClientMessage(playerid, 0xFFFFFFAA, "/createhouse [Сумма] [MaxLevel 1-10]");
                else
                {
                        if ((MaxLevel >= 1) && (MaxLevel <= 10))
                        {
                                for (HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                                if (!IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                        break;

                                if (!IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                                {
                                        new Float:x, Float:y, Float:z, Msg[128];
                                        GetPlayerPos(playerid, x, y, z);
                                        AHouseData[HouseID][Owned] = false;
                                        AHouseData[HouseID][Owner] = 0;
                                        AHouseData[HouseID][HouseX] = x;
                                        AHouseData[HouseID][HouseY] = y;
                                        AHouseData[HouseID][HouseZ] = z;
                                        AHouseData[HouseID][HouseLevel] = 1;
                                        AHouseData[HouseID][HouseMaxLevel] = MaxLevel;
                                        AHouseData[HouseID][HousePrice] = HPrice;
                                        AHouseData[HouseID][HouseOpened] = false;
                                        AHouseData[HouseID][Insurance] = false;
                                        AHouseData[HouseID][StaticHouse] = false;
                                        AHouseData[HouseID][CarSlots] = 1;

                                        House_UpdateEntrance(HouseID);
                                        HouseFile_Save(HouseID);
                                        format(Msg, 128, "Вы создали дом с ID: %i", HouseID);
                                        SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                        }
                                else
                        SendClientMessage(playerid, 0xFFFFFFAA, "Лимит домов достигнут...");
                                }
                        else
                        SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны использовать максимальный уровень от 1 до 10...");
                }
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны выйти из транспорта чтобы создать дом...");
        return 1;
}
//==============================================================================
COMMAND:createstatichouse(playerid, params[]) // Добавлять дома
{
        new HPrice, Carslots, HouseID, Interior;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;
        if (INT_CheckPlayerAdminLevel(playerid, 5) == 0) return 0;

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                if (sscanf(params, "iii", HPrice, Carslots, Interior)) SendClientMessage(playerid, 0xFFFFFFAA, "/createstatichouse [Сумма] [Авто ячейки] [Интерьер]");
                else
                {
                        if ((Carslots >= 1) && (Carslots <= 10))
                        {
                                if ((Interior >= 1) && (Interior <= 10))
                                {
                                        for (HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                                        if (!IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                                break;

                                        if (!IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                                        {
                                                new Float:x, Float:y, Float:z, Msg[128];
                                                GetPlayerPos(playerid, x, y, z);
                                                AHouseData[HouseID][Owned] = false;
                                                AHouseData[HouseID][HouseX] = x;
                                                AHouseData[HouseID][HouseY] = y;
                                                AHouseData[HouseID][HouseZ] = z;
                                                AHouseData[HouseID][HouseLevel] = Interior;
                                                AHouseData[HouseID][HouseMaxLevel] = Interior;
                                                AHouseData[HouseID][HousePrice] = HPrice;
                                                AHouseData[HouseID][HouseOpened] = false;
                                                AHouseData[HouseID][Insurance] = false;
                                                AHouseData[HouseID][StaticHouse] = true;
                                                AHouseData[HouseID][CarSlots] = Carslots;

                                                House_UpdateEntrance(HouseID);
                                                HouseFile_Save(HouseID);
                                                format(Msg, 128, "Вы создали статистический дом с ID: %i", HouseID);
                                                SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                        }
                                        else
                                            SendClientMessage(playerid, 0xFFFFFFAA, "Лимит домов достиг максимума...");
                                }
                                else
                                    SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны использовать интерьеры от 1 до 10...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны импользовать от 1 до 10 ячеек авто...");
                }
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Выйди из транспорта чтобы создать дом...");
        return 1;
}
//==============================================================================
COMMAND:delhouse(playerid, params[]) // Удалить дом
{
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;
        if (INT_CheckPlayerAdminLevel(playerid, 5) == 0) return 0;
        new file[100], Msg[128], Name[24];

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                for (new HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                {
                        if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                        {
                                if (IsPlayerInRangeOfPoint(playerid, 2.5, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]))
                                {
                                        if (AHouseData[HouseID][Owned] == true)
                                        {
                                                for (new pid; pid < MAX_PLAYERS; pid++)
                                                {
                                                    if (INT_IsPlayerLoggedIn(playerid) == 1)
                                                    {
                                                        GetPlayerName(pid, Name, sizeof(Name));
                                                                if (strcmp(AHouseData[HouseID][Owner], Name, false) == 0)
                                                                {
                                                                        format(Msg, 128, "Ваш дом \"%s\" удалили...", AHouseData[HouseID][HouseName]);
                                                                        SendClientMessage(pid, 0xFFFFFFAA, Msg);

                                                                        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
                                                                if (APlayerData[pid][Houses][HouseSlot] == HouseID)
                                                                APlayerData[pid][Houses][HouseSlot] = 0;
                                                                        break;
                                                                }
                                                    }
                                                }
                                        }
                                        House_RemoveVehicles(HouseID);
                                        AHouseData[HouseID][Owned] = false;
                                        AHouseData[HouseID][Owner] = 0;
                                        AHouseData[HouseID][HouseName] = 0;
                                        AHouseData[HouseID][Insurance] = false;
                                        AHouseData[HouseID][HouseX] = 0.0;
                                        AHouseData[HouseID][HouseY] = 0.0;
                                        AHouseData[HouseID][HouseZ] = 0.0;
                                        AHouseData[HouseID][HouseLevel] = 0;
                                        AHouseData[HouseID][HouseMaxLevel] = 0;
                                        AHouseData[HouseID][HousePrice] = 0;
                                        AHouseData[HouseID][HouseOpened] = false;
                                        AHouseData[HouseID][StaticHouse] = false;
                                        AHouseData[HouseID][CarSlots] = 0;
                                        DestroyDynamicPickup(AHouseData[HouseID][PickupID]);
                                        DestroyDynamicMapIcon(AHouseData[HouseID][MapIconID]);
                                        DestroyDynamic3DTextLabel(AHouseData[HouseID][DoorText]);
                                        AHouseData[HouseID][PickupID] = 0;
                                        AHouseData[HouseID][MapIconID] = 0;

                                        format(file, sizeof(file), HouseFile, HouseID);
                                        if (fexist(file))
                                        fremove(file);

                                        format(Msg, 128, "Вы удалили дом с ID: %i", HouseID);
                                        SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                        return 1;
                                }
                        }
                }
                SendClientMessage(playerid, 0xFFFFFFAA, "Рядом нету дома чтобы удалить её...");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Выйдите из транспорта чтобы удалить дом...");
        return 1;
}
//==============================================================================
COMMAND:buyhouse(playerid, params[]) // Купить дом
{
        new Msg[128];
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                for (new HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                {
                        if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                        {
                                if (IsPlayerInRangeOfPoint(playerid, 2.5, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]))
                                {
                                    if (AHouseData[HouseID][Owned] == false)
                                    {
                                        if (INT_GetPlayerMoney(playerid) >= AHouseData[HouseID][HousePrice])
                                            House_SetOwner(playerid, HouseID);
                                        else
                                            SendClientMessage(playerid, 0xFFFFFFAA, "Вы не можете предоставить этот дом...");
                                                    }
                                            else
                                            {
                                                format(Msg, 128, "Этот дом принадлежит игроку %s", AHouseData[HouseID][Owner]);
                                                SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                    }
                                    return 1;
                                }
                        }
                }
                SendClientMessage(playerid, 0xFFFFFFAA, "Вы не у дома чтобы купить её...");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Чтобы купить дом выйди из транспорта...");
        return 1;
}
//==============================================================================
COMMAND:enter(playerid, params[]) // Для входа в дом
{
        new HouseID, IntID;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                for (HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                {
                        if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                        {
                                if (IsPlayerInRangeOfPoint(playerid, 2.5, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]))
                                {
                                        if (AHouseData[HouseID][HouseOpened] == false)
                                        {
                                                if (House_PlayerIsOwner(playerid, HouseID) == 0)
                                                {
                                                        SendClientMessage(playerid, 0xFFFFFFAA, "Этот дом закрыт для вас...");
                                                    return 1;
                                                }
                                        }
                                        IntID = AHouseData[HouseID][HouseLevel]; // Get the level of the house
                                        SetPlayerVirtualWorld(playerid, 5000 + HouseID);
                                        SetPlayerInterior(playerid, AHouseInteriors[IntID][InteriorID]);
                                        SetPlayerPos(playerid, AHouseInteriors[IntID][IntX], AHouseInteriors[IntID][IntY], AHouseInteriors[IntID][IntZ]);
                                        APlayerData[playerid][CurrentHouse] = HouseID;
                                        SendClientMessage(playerid, 0xFFFFFFAA, "Введите /housemenu для того чтобы увидеть возможности управления дома...");
                                        return 1;
                                }
                        }
                }
        }
        return 0;
}
//==============================================================================
COMMAND:housemenu(playerid, params[]) // Меню дома
{
        new OptionsList[200], DialogTitle[200], HouseID;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;
        HouseID = APlayerData[playerid][CurrentHouse];

        if (HouseID != 0)
        {
                format(DialogTitle, sizeof(DialogTitle), "Выбери возможность для %s", AHouseData[HouseID][HouseName]);

                if (AHouseData[HouseID][StaticHouse] == true)
                {
                        format(OptionsList, sizeof(OptionsList), "%sПоменять название дома\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить интерьер для дома\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить лицензию на домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sПродать домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sПродать дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sОткрыть дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sЗакрыть дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sВыйти из дома\n", OptionsList);
                        }
                        else
                        {
                        format(OptionsList, sizeof(OptionsList), "%sПоменять название дома\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить интерьер для дома\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sКупить лицензию на домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sПродать домовое авто\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sПродать дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sОткрыть дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sЗакрыть дом\n", OptionsList);
                        format(OptionsList, sizeof(OptionsList), "%sВыйти из дома\n", OptionsList);
                }
                ShowPlayerDialog(playerid, DialogHouseMenu, DIALOG_STYLE_LIST, DialogTitle, OptionsList, "Выбрать", "Отмена");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы не внутри дома...");
        return 1;
}
//==============================================================================
COMMAND:gohome(playerid, params[]) // Для телепорта к своему дому
{
        new HouseList[1000], HouseID;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;

        if (INT_IsPlayerJailed(playerid) == 0)
        {
                if (GetPlayerVehicleSeat(playerid) == -1)
                {
                        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
                        {
                            HouseID = APlayerData[playerid][Houses][HouseSlot];

                                if (HouseID != 0)
                                        format(HouseList, 1000, "%s{00FF00}%s{FFFFFF}\n", HouseList, AHouseData[HouseID][HouseName]);
                                else
                                        format(HouseList, 1000, "%s{FFFFFF}%s{FFFFFF}\n", HouseList, "Пусто");
                        }
                        ShowPlayerDialog(playerid, DialogGoHome, DIALOG_STYLE_LIST, "Выберите дом для телепорта к нему:", HouseList, "Выбрать", "Отмена");
                }
                else
                        SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны быть пешком для телепорта домой...");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы не можете исползовать команду так как вы в тюрьме...");
        return 1;
}
//==============================================================================
COMMAND:getcar(playerid, params[]) // Для телепорта своего авто
{
        new HouseList[1000], HouseID;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
                {
                    HouseID = APlayerData[playerid][Houses][HouseSlot];

                        if (HouseID != 0)
                                format(HouseList, 1000, "%s{00FF00}%s{FFFFFF}\n", HouseList, AHouseData[HouseID][HouseName]);
                        else
                                format(HouseList, 1000, "%s{FFFFFF}%s{FFFFFF}\n", HouseList, "Пусто");
                }
                ShowPlayerDialog(playerid, DialogGetCarSelectHouse, DIALOG_STYLE_LIST, "Выберите дом чтобы получить от него автомобиль:", HouseList, "Выбрать", "Отмена");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "{FF0000}Вы должны быть на ногах чтобы вызвать свой автомобиль...");
        return 1;
}
//==============================================================================
COMMAND:park(playerid, params[]) // Припарковать авто
{
        new Float:x, Float:y, Float:z, Float:rot, vid, HouseID, Msg[128];
        new engine,lights,alarm,doors,bonnet,boot,objective;
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;

        if (GetPlayerVehicleSeat(playerid) == 0)
        {
                vid = GetPlayerVehicleID(playerid);
                HouseID = AVehicleData[vid][BelongsToHouse];

                if (HouseID != 0)
                {
                        if (IsPlayerInRangeOfPoint(playerid, ParkRange, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]))
                        {
                                GetVehiclePos(vid, x, y, z);
                                GetVehicleZAngle(vid, rot);
                                AVehicleData[vid][SpawnX] = x;
                                AVehicleData[vid][SpawnY] = y;
                                AVehicleData[vid][SpawnZ] = z;
                                AVehicleData[vid][SpawnRot] = rot;

                                for (new CarSlot; CarSlot < 10; CarSlot++)
                                {
                                    if (AHouseData[HouseID][VehicleIDs][CarSlot] == vid)
                                    {
                            House_ReplaceVehicle(HouseID, CarSlot);
                            PutPlayerInVehicle(playerid, AHouseData[HouseID][VehicleIDs][CarSlot], 0);
                                                GetVehicleParamsEx(AHouseData[HouseID][VehicleIDs][CarSlot]
, engine, lights, alarm, doors, bonnet, boot, objective);
                                                SetVehicleParamsEx(AHouseData[HouseID][VehicleIDs][CarSlot]
, 1, 1, alarm, doors, bonnet, boot, objective);
                            break;
                                        }
                                }
                                SendClientMessage(playerid, 0xFFFFFFAA, "Ты припарковал свой автомобиль...");
                                HouseFile_Save(HouseID);
                        }
                        else
                        {
                            format(Msg, 128, "Вы должны быть в пределах %im чтобы припарковать авто...", ParkRange);
                            SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                        }
                }
                else
                    SendClientMessage(playerid, 0xFFFFFFAA, "Это не ваш автомобиль и вы не можете припарковать её...");
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы должны вести своё транспортное средство чтобы припарковать её...");
        return 1;
}
//==============================================================================
COMMAND:evict(playerid, params[]) // Удалить дом
{
        if (INT_IsPlayerLoggedIn(playerid) == 0) return 0;
        if (INT_CheckPlayerAdminLevel(playerid, 5) == 0) return 0;
        new Msg[128], Name[24];

        if (GetPlayerVehicleSeat(playerid) == -1)
        {
                for (new HouseID = 1; HouseID < MAX_HOUSES; HouseID++)
                {
                        if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                        {
                                if (IsPlayerInRangeOfPoint(playerid, 2.5, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]))
                                {
                                        if (AHouseData[HouseID][Owned] == true)
                                        {
                                                for (new pid; pid < MAX_PLAYERS; pid++)
                                                {
                                                    if (INT_IsPlayerLoggedIn(playerid) == 1)
                                                    {
                                                        GetPlayerName(pid, Name, sizeof(Name));
                                                                if (strcmp(AHouseData[HouseID][Owner], Name, false) == 0)
                                                                {
                                                                        format(Msg, 128, "Вы потеряли свой дом \"%s\" так как этот дом был удалён...", AHouseData[HouseID][HouseName]);
                                                                        SendClientMessage(pid, 0xFFFFFFFF, Msg);

                                                                        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
                                                                if (APlayerData[pid][Houses][HouseSlot] == HouseID)
                                                                APlayerData[pid][Houses][HouseSlot] = 0;
                                                                        break;
                                                                }
                                                    }
                                                }
                                        }
                                        House_RemoveVehicles(HouseID);
                                        AHouseData[HouseID][Owned] = false;
                                        AHouseData[HouseID][Owner] = 0;
                                        House_UpdateEntrance(HouseID);
                                        HouseFile_Save(HouseID);
                                        format(Msg, 128, "Вы выселили дом с удостверением личности: %i", HouseID);
                                        SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                        return 1;
                                }
                        }
                }
                SendClientMessage(playerid, 0xFFFFFFAA, "Нету никакого дома чтобы удалить...");
                }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "{FF0000}Вы должны быть пешком чтобы удалить дом...");
        return 1;
}
//==============================================================================
Dialog_HouseMenu(playerid, response, listitem) // Для /housemenu внутри дома
{
        if(!response) return 1;
        new UpgradeList[2000], HouseID, DialogTitle[200], Counter, UpgradePrice, Msg[128], CarSlot, VehicleClassList[1000], VehicleList[500];
    new MsgInsurance[128], BuyableCarIndex, bool:HouseHasCars = false;
        HouseID = APlayerData[playerid][CurrentHouse];
        if (AHouseData[HouseID][StaticHouse] == true)
        {
                if (listitem >= 1)
                    listitem++;
        }

        switch(listitem)
        {
            case 0: // Для измены названия дома
            {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                        format(DialogTitle, 200, "Старое имя дома: %s", AHouseData[HouseID][HouseName]);
                                ShowPlayerDialog(playerid, DialogHouseNameChange, DIALOG_STYLE_INPUT, DialogTitle, "Напишите новое имя для своего дома", "Выбрать", "Отмена");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
            }
            case 1: // Покупка интерьера дома
            {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                                if (AHouseData[HouseID][HouseLevel] < AHouseData[HouseID][HouseMaxLevel])
                                {
                                        for (new i = AHouseData[HouseID][HouseLevel] + 1; i <= AHouseData[HouseID][HouseMaxLevel]; i++)
                                        {
                                            Counter++;
                                            UpgradePrice = ((AHouseData[HouseID][HousePrice] * Counter) / 100) * HouseUpgradePercent;
                                                if (INT_GetPlayerMoney(playerid) >= UpgradePrice)
                                                        format(UpgradeList, 2000, "%s{00FF00}%s (level %i)\t\t$%i\n", UpgradeList, AHouseInteriors[i][InteriorName], i, UpgradePrice);
                                                else
                                                        format(UpgradeList, 2000, "%s{FF0000}%s (level %i)\t\t$%i\n", UpgradeList, AHouseInteriors[i][InteriorName], i, UpgradePrice);
                                        }
                                        ShowPlayerDialog(playerid, DialogUpgradeHouse, DIALOG_STYLE_LIST, "Покупка интерьера:", UpgradeList, "Выбрать", "Отмена");
                                }
                                else
                                    SendClientMessage(playerid, 0xFFFFFFAA, "{FF0000}Ваш дом и так максимального уровня вы не можете его улучшать дальше...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
            }
                case 2: // Покупка авто
                {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                            CarSlot = House_GetFreeCarSlot(HouseID);
                            if (CarSlot != -1)
                            {
                                        format(VehicleClassList, 1000, "%s{00FF00}%s{FFFFFF}\n", VehicleClassList, "Байки");
                                        format(VehicleClassList, 1000, "%s{40FF00}%s{FFFFFF}\n", VehicleClassList, "Лодки");
                                        format(VehicleClassList, 1000, "%s{80FF00}%s{FFFFFF}\n", VehicleClassList, "Кабриолеты");
                                        format(VehicleClassList, 1000, "%s{B0FF00}%s{FFFFFF}\n", VehicleClassList, "Вертолёты");
                                        format(VehicleClassList, 1000, "%s{FFFF00}%s{FFFFFF}\n", VehicleClassList, "Индустриальное авто");
                                        format(VehicleClassList, 1000, "%s{B0FF40}%s{FFFFFF}\n", VehicleClassList, "Лов-Райдеры");
                                        format(VehicleClassList, 1000, "%s{80FF80}%s{FFFFFF}\n", VehicleClassList, "Внедорожники");
                                        format(VehicleClassList, 1000, "%s{40FFB0}%s{FFFFFF}\n", VehicleClassList, "Летающие");
                                        format(VehicleClassList, 1000, "%s{00FFFF}%s{FFFFFF}\n", VehicleClassList, "Общественное авто");
                                        format(VehicleClassList, 1000, "%s{00B0FF}%s{FFFFFF}\n", VehicleClassList, "RC-Авто");
                                        format(VehicleClassList, 1000, "%s{0080FF}%s{FFFFFF}\n", VehicleClassList, "Седаны");
                                        format(VehicleClassList, 1000, "%s{0040FF}%s{FFFFFF}\n", VehicleClassList, "Спортивные");
                                        format(VehicleClassList, 1000, "%s{0000FF}%s{FFFFFF}\n", VehicleClassList, "Вагоны");
                                        format(VehicleClassList, 1000, "%s{4000FF}%s{FFFFFF}\n", VehicleClassList, "Трэйлеры");
                                        format(VehicleClassList, 1000, "%s{8000FF}%s{FFFFFF}\n", VehicleClassList, "Уникальные");
                                        ShowPlayerDialog(playerid, DialogBuyCarClass, DIALOG_STYLE_LIST, "Выберите класс транспорта:", VehicleClassList, "Выбрать", "Отмена");
                            }
                            else
                                SendClientMessage(playerid, 0xFFFFFFAA, "У этого дома уже есть автомобили...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
                }
                case 3: // Для покупки страховки авто
                {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                            if (AHouseData[HouseID][Insurance] == false)
                            {
                                if (INT_GetPlayerMoney(playerid) >= (AHouseData[HouseID][HousePrice] / 10))
                                {
                                            format(MsgInsurance, 128, "Вы уверены что хотите купить страховку за $%i", AHouseData[HouseID][HousePrice] / 10);
                                                if (AutomaticInsurance == true)
                                                        ShowPlayerDialog(playerid, DialogBuyInsurance, DIALOG_STYLE_MSGBOX, "Админ разрешил покупать страховку всем так что покупайте пока можно", MsgInsurance, "Да", "Нет");
                                                else
                                                        ShowPlayerDialog(playerid, DialogBuyInsurance, DIALOG_STYLE_MSGBOX, "Купить страхову?", MsgInsurance, "Да", "Нет");
                                        }
                                        else
                                            SendClientMessage(playerid, 0xFFFFFFAA, "Вы не можете предоставить страховку транспортного средства...");
                                }
                                else
                                    SendClientMessage(playerid, 0xFFFFFFAA, "У этого дома есть страховка по скольку это домовое авто...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
                }
                case 4: // Для продажи домового транспорта
                {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                                for (CarSlot = 0; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
                                    if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                                        HouseHasCars = true;

                                if (HouseHasCars == true)
                                {
                                        for (CarSlot = 0; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
                                        {
                                                if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                                                {
                                                    BuyableCarIndex = VehicleBuyable_GetIndex(GetVehicleModel(AHouseData[HouseID][VehicleIDs]
[CarSlot]));
                                                    format(VehicleList, 500, "%s{00FF00}%s: $%i{FFFFFF}\n", VehicleList, ABuyableVehicles[BuyableCarIndex][CarName], ABuyableVehicles[BuyableCarIndex][Price] / 2);
                                                }
                                                else
                                                        format(VehicleList, 500, "%s{FFFFFF}Пустой{FFFFFF}\n", VehicleList);
                                        }
                                        ShowPlayerDialog(playerid, DialogSellCar, DIALOG_STYLE_LIST, "Продажа домового транспорта:", VehicleList, "Выбрать", "Отмена");
                                }
                                else
                                    SendClientMessage(playerid, 0xFFFFFFAA, "У вас нету автомобиля назначено на этот дом...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
                }
                case 5: // Для продажи дома
                {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                                for (CarSlot = 0; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
                                    if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                                        HouseHasCars = true;

                                if (HouseHasCars == false)
                                {
                                    format(Msg, 128, "Вы уверены что хотите продать свой дом за $%i...", House_CalcSellPrice(HouseID));
                                        ShowPlayerDialog(playerid, DialogSellHouse, DIALOG_STYLE_MSGBOX, "Продажа дома", Msg, "Да", "Нет");
                                }
                                else
                                    SendClientMessage(playerid, 0xFFFFFFAA, "Вы не можете продать свой дом так как тут есть домовое авто продайте сначала его...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
                }
            case 6: // Для открытия дома
            {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                                AHouseData[HouseID][HouseOpened] = true;
                                SendClientMessage(playerid, 0xFFFFFFAA, "{00FF00}Вы открыли свой дом для всех игроков...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
            }
            case 7: // Для закрытия дома
            {
                        if (House_PlayerIsOwner(playerid, HouseID) == 1)
                        {
                                AHouseData[HouseID][HouseOpened] = false;
                                SendClientMessage(playerid, 0xFFFFFFAA, "Вы закрыли свой дом для других игроков...");
                        }
                        else
                            SendClientMessage(playerid, 0xFFFFFFAA, "Только хозяин дома может использовать эту команду...");
            }
            case 8: // Для выхода из дома
            {
                House_Exit(playerid, HouseID);
            }
        }
        return 1;
}
//==============================================================================
Dialog_UpgradeHouse(playerid, response, listitem) // Для того чтобы менять интерьер дома
{
        if(!response) return 1;
        new Msg[128], HouseID, hLevel, Payment;
        HouseID = APlayerData[playerid][CurrentHouse];
        hLevel = listitem + 1 + AHouseData[HouseID][HouseLevel];
        Payment = ((AHouseData[HouseID][HousePrice] * (listitem + 1)) / 100) * HouseUpgradePercent;

        if (INT_GetPlayerMoney(playerid) >= Payment)
        {
                AHouseData[HouseID][HouseLevel] = hLevel;
                AHouseData[HouseID][CarSlots] = hLevel;

                for (new OtherPlayer; OtherPlayer < MAX_PLAYERS; OtherPlayer++)
                {
                        if (APlayerData[OtherPlayer][CurrentHouse] == HouseID)
                        {
                                SetPlayerVirtualWorld(OtherPlayer, 5000 + HouseID);
                                SetPlayerInterior(OtherPlayer, AHouseInteriors[hLevel][InteriorID]);
                                SetPlayerPos(OtherPlayer, AHouseInteriors[hLevel][IntX], AHouseInteriors[hLevel][IntY], AHouseInteriors[hLevel][IntZ]);
                        }
                }
                INT_GivePlayerMoney(playerid, -Payment);
                format(Msg, 128, "Вы купили новый интерьер %i за $%i...", AHouseData[HouseID][HouseLevel], Payment);
                SendClientMessage(playerid, 0xFFFFFFFF, Msg);
                House_UpdateEntrance(HouseID);
                HouseFile_Save(HouseID);
                }
        else
        SendClientMessage(playerid, 0xFFFFFFFF, "У вас не хватает денег для покупки этого интерьера...");
        return 1;
}
//==============================================================================
Dialog_GoHome(playerid, response, listitem) // Для телепорта к своему дому
{
        if(!response) return 1;
        new HouseIndex, HouseID;
        HouseIndex = listitem;
        HouseID = APlayerData[playerid][Houses][HouseIndex];
        if (HouseID != 0)
        {
                SetPlayerPos(playerid, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]);
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "У вас нету дома...");
        return 1;
}
//==============================================================================
Dialog_ChangeHouseName(playerid, response, inputtext[]) // Чтобы поменять имя дома
{
        if ((!response) || (strlen(inputtext) == 0)) return 1;
        format(AHouseData[APlayerData[playerid][CurrentHouse]][
HouseName], 100, inputtext);
        House_UpdateEntrance(APlayerData[playerid][CurrentHouse]);
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы поменяли имя своего дома...");
        HouseFile_Save(APlayerData[playerid][CurrentHouse]);
        return 1;
}
//==============================================================================
Dialog_BuyCarClass(playerid, response, listitem) // Для выбора класса транспортного средства и покупки транспорта
{
        if(!response) return 1;

        new CarList[1000], DialogTitle[128];

        APlayerData[playerid][DialogBuyVClass] = listitem + 1;

        for (new i; i < sizeof(ABuyableVehicles); i++)
        {
                if (ABuyableVehicles[i][VehicleClass] == APlayerData[playerid][DialogBuyVClass])
                {
                        format(CarList, 1000, "%s%s%s ($%i)", CarList, "\n", ABuyableVehicles[i][CarName], ABuyableVehicles[i][Price]);
                }
        }
        if (strlen(CarList) == 0)
        {
                SendClientMessage(playerid, 0xFFFFFFAA, "Пустой");
                return 1;
        }
        switch (APlayerData[playerid][DialogBuyVClass])
        {
                case VClassBike: format(DialogTitle, 128, "Байки:");
                case VClassBoat: format(DialogTitle, 128, "Лодки:");
                case VClassConvertible: format(DialogTitle, 128, "Кабриолеты:");
                case VClassHelicopter: format(DialogTitle, 128, "Вертолёты:");
                case VClassIndustrial: format(DialogTitle, 128, "Индустриальное:");
                case VClassLowRider: format(DialogTitle, 128, "Лов-Райдеры:");
                case VClassOffRoad: format(DialogTitle, 128, "Внедорожники:");
                case VClassPlane: format(DialogTitle, 128, "Летающие:");
                case VClassPublic: format(DialogTitle, 128, "Общественное:");
                case VClassRCVehicle: format(DialogTitle, 128, "RC-Авто:");
                case VClassSaloons: format(DialogTitle, 128, "Седаны:");
                case VClassSportCar: format(DialogTitle, 128, "Спортивные:");
                case VClassStationCar: format(DialogTitle, 128, "Вагоны:");
                case VClassTrailer: format(DialogTitle, 128, "Трэйлеры:");
                case VClassUnique: format(DialogTitle, 128, "Уникальные:");
        }
        ShowPlayerDialog(playerid, DialogBuyCar, DIALOG_STYLE_LIST, DialogTitle, CarList, "Выбрать", "Отмена");
        return 1;
}
//==============================================================================
Dialog_BuyCar(playerid, response, listitem) // Для покупки авто
{
        if(!response) return 1;
        new Counter, Msg[128], cComponents[14], vid;
        new HouseID = APlayerData[playerid][CurrentHouse];

        for (new i; i < sizeof(ABuyableVehicles); i++)
        {
                if (ABuyableVehicles[i][VehicleClass] == APlayerData[playerid][DialogBuyVClass])
                {
                    if (Counter == listitem)
                        {
                            if (INT_GetPlayerMoney(playerid) >= (ABuyableVehicles[i][Price]))
                            {
                                        vid = House_AddVehicle(HouseID, ABuyableVehicles[i][CarModel], 0, cComponents, 2585.0, 2829.0, 10.9, 0.0, random(126), random(126));
                                        INT_SetVehicleFuel(vid, -1);
                                        INT_GivePlayerMoney(playerid, -ABuyableVehicles[i][Price]);
                                        format(Msg, 128, "Вы купили траспортное средство %s за $%i...", ABuyableVehicles[i][CarName], ABuyableVehicles[i][Price]);
                                        SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                                        SendClientMessage(playerid, 0xFFFFFFAA, "Теперь выйдите на улицу пропишите команду /getcar и телепортируйте своё новое транспортное средство, и припаркуйте его с помощью /park");
                                        HouseFile_Save(HouseID);
                                        }
                                else
                        SendClientMessage(playerid, 0xFFFFFFAA, "У вас не хватает денег для этого транспорта...");
                                return 1;
                                }
                        else
                        Counter++;
                        }
        }
        return 1;
}
//==============================================================================
Dialog_BuyInsurance(playerid, response) // Для покупки страховки
{
        if(!response) return 1;
        new Msg[128];
        new HouseID = APlayerData[playerid][CurrentHouse];

        AHouseData[HouseID][Insurance] = true;
        INT_GivePlayerMoney(playerid, -(AHouseData[HouseID][HousePrice] / 10));
        format(Msg, 128, "Вы купили страховку транспортного средства за $%i...", AHouseData[HouseID][HousePrice] / 10);
        SendClientMessage(playerid, 0xFFFFFFFF, Msg);
        HouseFile_Save(HouseID);
        return 1;
}
//==============================================================================
Dialog_SellHouse(playerid, response) // Для продажи дома
{
        if(!response) return 1;
        new HouseID = APlayerData[playerid][CurrentHouse];

        for (new OtherPlayer; OtherPlayer < MAX_PLAYERS; OtherPlayer++)
        {
                if (APlayerData[OtherPlayer][CurrentHouse] == HouseID)
                {
                        House_Exit(OtherPlayer, HouseID);
                }
        }
        INT_GivePlayerMoney(playerid, House_CalcSellPrice(HouseID));
        SendClientMessage(playerid, 0xFFFFFFAA, "Вы продали свой дом...");

        AHouseData[HouseID][Owned] = false;
        AHouseData[HouseID][Owner] = 0;
        AHouseData[HouseID][HouseName] = 0;
        if (AHouseData[HouseID][StaticHouse] == false)
        {
        AHouseData[HouseID][HouseLevel] = 1;
            AHouseData[HouseID][CarSlots] = 1;
        }
        AHouseData[HouseID][Insurance] = false;
        AHouseData[HouseID][HouseOpened] = false;

        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
        {
                if (APlayerData[playerid][Houses][HouseSlot] == HouseID)
                {
                    APlayerData[playerid][Houses][HouseSlot] = 0;
                    break;
                }
        }
        House_UpdateEntrance(HouseID);
        HouseFile_Save(HouseID);
        return 1;
}
//==============================================================================
Dialog_SellCar(playerid, response, listitem) // Для того чтобы продать транспортное стредство
{
        if(!response) return 1;
        new HouseID = APlayerData[playerid][CurrentHouse];
        new vid = AHouseData[HouseID][VehicleIDs][listitem];
        new CarSlot = listitem;

        if (vid != 0)
        {
                new BuyableCarIndex = VehicleBuyable_GetIndex(GetVehicleModel(vid));
                new Msg[128];
                Vehicle_Delete(vid, HouseID, CarSlot);
                INT_GivePlayerMoney(playerid, (ABuyableVehicles[BuyableCarIndex][Price] / 2));
                format(Msg, 128, "Вы продали свой %s за $%i...", ABuyableVehicles[BuyableCarIndex][CarName], ABuyableVehicles[BuyableCarIndex][Price] / 2);
                SendClientMessage(playerid, 0xFFFFFFAA, Msg);
                HouseFile_Save(HouseID);
                }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "{FF0000}У вас нету транспортного средства...");
        return 1;
}
//==============================================================================
Dialog_GetCarSelectHouse(playerid, response, listitem) // Эта функция обрабатывает отобранный дом, от которого можно получить транспортное средство, используя /getcar
{
        if(!response) return 1;
        new HouseID = APlayerData[playerid][Houses][listitem];

        if (HouseID != 0)
        {
            new BuyableCarIndex, VehicleList[500], bool:HouseHasCars = false, CarSlot;

                APlayerData[playerid][DialogGetCarHouseID] = HouseID;

                for (CarSlot = 0; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
                        if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                            HouseHasCars = true;

                if (HouseHasCars == true)
                {
                        for (CarSlot = 0; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
                        {
                                if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                                {
                                    BuyableCarIndex = VehicleBuyable_GetIndex(GetVehicleModel(AHouseData[HouseID][VehicleIDs]
[CarSlot]));
                                    format(VehicleList, 500, "%s{00FF00}%s\n", VehicleList, ABuyableVehicles[BuyableCarIndex][CarName]);
                                }
                                else
                                format(VehicleList, 500, "%s Пусто\n", VehicleList);
                        }
                        ShowPlayerDialog(playerid, DialogGetCarSelectCar, DIALOG_STYLE_LIST, "Выберите домовой автомобиль чтобы телепортировать его к себе:", VehicleList, "Выбрать", "Отмена");
                        }
                        else
                    SendClientMessage(playerid, 0xFFFFFFAA, "У этого дома нету транспортного средства...");
                        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "У вас нету дома...");
        return 1;
}
//==============================================================================
Dialog_GetCarSelectCar(playerid, response, listitem) // Эта функция для того чтобы телепортировать транспортное средство к себе
{
        if(!response) return 1;
        new HouseID = APlayerData[playerid][DialogGetCarHouseID];
        new vid = AHouseData[HouseID][VehicleIDs][listitem];
        if (vid != 0)
        {
                new Float:x, Float:y, Float:z, Float:Angle;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, Angle);
                SetVehiclePos(vid, x, y, z);
                PutPlayerInVehicle(playerid, vid, 0);
                SetVehicleZAngle(vid, Angle);
                new engine,lights,alarm,doors,bonnet,boot,objective;
                GetVehicleParamsEx(vid, engine, lights, alarm, doors, bonnet, boot, objective);
                SetVehicleParamsEx(vid, 1, 1, alarm, doors, bonnet, boot, objective);
                SendClientMessage(playerid, 0xFFFFFFAA, "Вы телепортировали транспортное средство к себе, введите /park чтобы припарковать авто...");
                }
                else
            SendClientMessage(playerid, 0xFFFFFFAA, "У вас нету домового автомобиля...");

        return 1;
}
//==============================================================================
HouseFile_Load(HouseID) // Загружает только дома
{
        new file[100], File:HFile, LineFromFile[100], ParameterName[50], ParameterValue[50];
        format(file, sizeof(file), HouseFile, HouseID);

        if (fexist(file))
        {
                HFile = fopen(file, io_read);
                fread(HFile, LineFromFile);

                while (strlen(LineFromFile) > 0)
                {
                        StripNewLine(LineFromFile);
                        sscanf(LineFromFile, "s[50]s[50]", ParameterName, ParameterValue);

                        if (strlen(LineFromFile) > 0)
                        {
                                if (strcmp(ParameterName, "Owned", false) == 0)
                                {
                                    if (strcmp(ParameterValue, "Yes", false) == 0)
                                                AHouseData[HouseID][Owned] = true;
                                        else
                                                AHouseData[HouseID][Owned] = false;
                                }
                                if (strcmp(ParameterName, "Owner", false) == 0)
                                    format(AHouseData[HouseID][Owner], 24, ParameterValue);

                                if (strcmp(ParameterName, "HouseName", false) == 0)
                                    format(AHouseData[HouseID][HouseName], 24, ParameterValue);
                                if (strcmp(ParameterName, "HouseX", false) == 0)
                                        AHouseData[HouseID][HouseX] = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "HouseY", false) == 0)
                                        AHouseData[HouseID][HouseY] = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "HouseZ", false) == 0)
                                        AHouseData[HouseID][HouseZ] = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "HouseLevel", false) == 0)
                                        AHouseData[HouseID][HouseLevel] = strval(ParameterValue);
                                if (strcmp(ParameterName, "HouseMaxLevel", false) == 0)
                                        AHouseData[HouseID][HouseMaxLevel] = strval(ParameterValue);
                                if (strcmp(ParameterName, "HousePrice", false) == 0)
                                        AHouseData[HouseID][HousePrice] = strval(ParameterValue);
                                if (strcmp(ParameterName, "HouseOpened", false) == 0)
                                {
                                    if (strcmp(ParameterValue, "Yes", false) == 0)
                                                AHouseData[HouseID][HouseOpened] = true;
                                        else
                                                AHouseData[HouseID][HouseOpened] = false;
                                }
                                if (strcmp(ParameterName, "Insurance", false) == 0)
                                {
                                    if (strcmp(ParameterValue, "Yes", false) == 0)
                                                AHouseData[HouseID][Insurance] = true;
                                        else
                                                AHouseData[HouseID][Insurance] = false;
                                }

                                if (strcmp(ParameterName, "StaticHouse", false) == 0)
                                {
                                    if (strcmp(ParameterValue, "Yes", false) == 0)
                                                AHouseData[HouseID][StaticHouse] = true;
                                        else
                                                AHouseData[HouseID][StaticHouse] = false;
                                }
                                if (strcmp(ParameterName, "CarSlots", false) == 0)
                                        AHouseData[HouseID][CarSlots] = strval(ParameterValue);
                        }
                        fread(HFile, LineFromFile);
                }
                fclose(HFile);
                House_UpdateEntrance(HouseID);
            TotalHouses++;
                return 1;
        }
        else
            return 0;
}
//==============================================================================
HouseFile_LoadCars(HouseID) // Загружает только транспортные средства
{
        new file[100], File:HFile, LineFromFile[100], ParameterName[50], ParameterValue[50];
        new vid, cModel, cPaint, cComponents[14], Float:cx, Float:cy, Float:cz, Float:crot, Col1, Col2, cFuel;

        format(file, sizeof(file), HouseFile, HouseID);

        if (fexist(file))
        {
                HFile = fopen(file, io_read);
                fread(HFile, LineFromFile);
                while (strlen(LineFromFile) > 0)
                {
                        StripNewLine(LineFromFile);
                        sscanf(LineFromFile, "s[50]s[50]", ParameterName, ParameterValue);

                        if (strlen(LineFromFile) > 0)
                        {
                                if (strcmp(ParameterName, "[Vehicle]", false) == 0)
                                {
                                    for (new i; i < 14; i++)
                                cComponents[i] = 0;
                                }
                                if (strcmp(ParameterName, "VehicleModel", false) == 0)
                                        cModel = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehiclePaintJob", false) == 0)
                                        cPaint = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleSpoiler", false) == 0)
                                        cComponents[0] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleHood", false) == 0)
                                        cComponents[1] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleRoof", false) == 0)
                                        cComponents[2] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleSideSkirt", false) == 0)
                                        cComponents[3] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleLamps", false) == 0)
                                        cComponents[4] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleNitro", false) == 0)
                                        cComponents[5] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleExhaust", false) == 0)
                                        cComponents[6] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleWheels", false) == 0)
                                        cComponents[7] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleStereo", false) == 0)
                                        cComponents[8] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleHydraulics", false) == 0)
                                        cComponents[9] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleFrontBumper", false) == 0)
                                        cComponents[10] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleRearBumper", false) == 0)
                                        cComponents[11] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleVentRight", false) == 0)
                                        cComponents[12] = strval(ParameterValue);
                                if (strcmp(ParameterName, "VehicleVentLeft", false) == 0)
                                        cComponents[13] = strval(ParameterValue);

                                if (strcmp(ParameterName, "Color1", false) == 0)
                                        Col1 = strval(ParameterValue);
                                if (strcmp(ParameterName, "Color2", false) == 0)
                                        Col2 = strval(ParameterValue);

                                if (strcmp(ParameterName, "VehicleX", false) == 0)
                                        cx = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "VehicleY", false) == 0)
                                        cy = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "VehicleZ", false) == 0)
                                        cz = floatstr(ParameterValue);
                                if (strcmp(ParameterName, "VehicleAngle", false) == 0)
                                        crot = floatstr(ParameterValue);

                                if (strcmp(ParameterName, "Fuel", false) == 0)
                                        cFuel = strval(ParameterValue);

                                if (strcmp(ParameterName, "[/Vehicle]", false) == 0)
                                {
                                        if ((Col1 == 0) && (cPaint != 0))
                                            Col1 = 1;
                                        if ((Col2 == 0) && (cPaint != 0))
                                        Col2 = 1;

                                        vid = House_AddVehicle(HouseID, cModel, cPaint, cComponents, cx, cy, cz, crot, Col1, Col2);
                                        INT_SetVehicleFuel(vid, cFuel);
                                }
                        }
                        fread(HFile, LineFromFile);
                }
                fclose(HFile);
                return 1;
        }
        else
        return 0;
}
//==============================================================================
HouseFile_Save(HouseID) // Эта функция сохранит данный дом
{
        new file[100], File:HFile, LineForFile[100], vid;

        format(file, sizeof(file), HouseFile, HouseID);

        HFile = fopen(file, io_write);

        if (AHouseData[HouseID][Owned] == true)
                format(LineForFile, 100, "Owned Yes\r\n");
        else
                format(LineForFile, 100, "Owned No\r\n");
        fwrite(HFile, LineForFile);

        format(LineForFile, 100, "Owner %s\r\n", AHouseData[HouseID][Owner]);
        fwrite(HFile, LineForFile);

        format(LineForFile, 100, "HouseName %s\r\n", AHouseData[HouseID][HouseName]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HouseX %f\r\n", AHouseData[HouseID][HouseX]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HouseY %f\r\n", AHouseData[HouseID][HouseY]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HouseZ %f\r\n", AHouseData[HouseID][HouseZ]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HouseLevel %i\r\n", AHouseData[HouseID][HouseLevel]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HouseMaxLevel %i\r\n", AHouseData[HouseID][HouseMaxLevel]);
        fwrite(HFile, LineForFile);
        format(LineForFile, 100, "HousePrice %i\r\n", AHouseData[HouseID][HousePrice]);
        fwrite(HFile, LineForFile);

        if (AHouseData[HouseID][HouseOpened] == true)
                format(LineForFile, 100, "HouseOpened Yes\r\n");
        else
                format(LineForFile, 100, "HouseOpened No\r\n");
        fwrite(HFile, LineForFile);

        if (AHouseData[HouseID][Insurance] == true)
                format(LineForFile, 100, "Insurance Yes\r\n");
        else
                format(LineForFile, 100, "Insurance No\r\n");
        fwrite(HFile, LineForFile);

        if (AHouseData[HouseID][StaticHouse] == true)
                format(LineForFile, 100, "StaticHouse Yes\r\n");
        else
                format(LineForFile, 100, "StaticHouse No\r\n");
        fwrite(HFile, LineForFile);

        format(LineForFile, 100, "CarSlots %i\r\n", AHouseData[HouseID][CarSlots]);
        fwrite(HFile, LineForFile);
        fwrite(HFile, "\r\n");

        for (new CarSlot; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
        {
                if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
                {
                        vid = AHouseData[HouseID][VehicleIDs][CarSlot];

                    format(LineForFile, 100, "[Vehicle]\r\n");
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "VehicleModel %i\r\n", AVehicleData[vid][Model]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehiclePaintJob %i\r\n", AVehicleData[vid][PaintJob]);
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "VehicleSpoiler %i\r\n", AVehicleData[vid][Components][0]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleHood %i\r\n", AVehicleData[vid][Components][1]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleRoof %i\r\n", AVehicleData[vid][Components][2]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleSideSkirt %i\r\n", AVehicleData[vid][Components][3]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleLamps %i\r\n", AVehicleData[vid][Components][4]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleNitro %i\r\n", AVehicleData[vid][Components][5]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleExhaust %i\r\n", AVehicleData[vid][Components][6]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleWheels %i\r\n", AVehicleData[vid][Components][7]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleStereo %i\r\n", AVehicleData[vid][Components][8]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleHydraulics %i\r\n", AVehicleData[vid][Components][9]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleFrontBumper %i\r\n", AVehicleData[vid][Components][10]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleRearBumper %i\r\n", AVehicleData[vid][Components][11]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleVentRight %i\r\n", AVehicleData[vid][Components][12]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleVentLeft %i\r\n", AVehicleData[vid][Components][13]);
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "Color1 %i\r\n", AVehicleData[vid][Color1]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "Color2 %i\r\n", AVehicleData[vid][Color2]);
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "VehicleX %f\r\n", AVehicleData[vid][SpawnX]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleY %f\r\n", AVehicleData[vid][SpawnY]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleZ %f\r\n", AVehicleData[vid][SpawnZ]);
                        fwrite(HFile, LineForFile);
                    format(LineForFile, 100, "VehicleAngle %f\r\n", AVehicleData[vid][SpawnRot]);
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "Fuel %i\r\n", INT_GetVehicleFuel(vid));
                        fwrite(HFile, LineForFile);

                    format(LineForFile, 100, "[/Vehicle]\r\n");
                        fwrite(HFile, LineForFile);
                        fwrite(HFile, "\r\n");
                }
        }
        fclose(HFile);
        return 1;
}
//==============================================================================
House_UpdateEntrance(HouseID) // Эти обновления функции (разрушает и обновляется), погрузка, символ карты и 3DText лейбл около входа дома
{
        new Msg[128], Float:x, Float:y, Float:z;

        x = AHouseData[HouseID][HouseX];
        y = AHouseData[HouseID][HouseY];
        z = AHouseData[HouseID][HouseZ];

        if (IsValidDynamicPickup(AHouseData[HouseID][PickupID]))
                DestroyDynamicPickup(AHouseData[HouseID][PickupID]);
        if (IsValidDynamicMapIcon(AHouseData[HouseID][MapIconID]))
                DestroyDynamicMapIcon(AHouseData[HouseID][MapIconID]);
        if (IsValidDynamic3DTextLabel(AHouseData[HouseID][DoorText]))
                DestroyDynamic3DTextLabel(AHouseData[HouseID][DoorText]);

        if (AHouseData[HouseID][Owned] == true)
        {
                AHouseData[HouseID][PickupID] = CreateDynamicPickup(1272, 1, x, y, z, 0);
                if (AHouseData[HouseID][StaticHouse] == true)
                format(Msg, 128, "{00ff00}%s\n{00ff00}Хозяин:{ffffff} %s\n{00ff00}Авто слот:{ffffff} %i\n{00ff00}nЦена:{ffffff} %i\n{00ff00}Чтобы войти введите {ffffff}/enter", AHouseData[HouseID][HouseName], AHouseData[HouseID][Owner], AHouseData[HouseID][CarSlots], AHouseData[HouseID][HouseLevel]);
                else
                        format(Msg, 128, "%s\nnХозяин: %s\nДом уровня: %i\nЧтобы войти введите /enter", AHouseData[HouseID][HouseName], AHouseData[HouseID][Owner], AHouseData[HouseID][HouseLevel]);
                AHouseData[HouseID][DoorText] = CreateDynamic3DTextLabel(Msg, 0xFFFFFFAA, x, y, z + 1.0, 50.0);
                if (ShowBoughtHouses == true)
                AHouseData[HouseID][MapIconID] = CreateDynamicMapIcon(x, y, z, 32, 0, 0, 0, -1, 150.0);
                }
                else
                {
                AHouseData[HouseID][PickupID] = CreateDynamicPickup(1273, 1, x, y, z, 0);
                if (AHouseData[HouseID][StaticHouse] == true)
                format(Msg, 128, "{00ff00}Дом продаётся\n{ffffff}$%i\n{00ff00}Авто слот:{ffffff} %i\n{00ff00}Цена:{ffffff} %i\n{00ff00}Чтобы купить дом введите {ffffff}/buyhouse", AHouseData[HouseID][HousePrice], AHouseData[HouseID][CarSlots], AHouseData[HouseID][HouseLevel]);
                else
                format(Msg, 128, "{00ff00}Дом продаётся\n{ffffff}$%i\n{00ff00}Чтобы купить дом введите {ffffff}/buyhouse", AHouseData[HouseID][HousePrice], AHouseData[HouseID][HouseMaxLevel]);
                AHouseData[HouseID][DoorText] = CreateDynamic3DTextLabel(Msg, 0xFFFFFFAA, x, y, z + 1.0, 50.0);
                AHouseData[HouseID][MapIconID] = CreateDynamicMapIcon(x, y, z, 31, 0, 0, 0, -1, 150.0);
        }
}
//==============================================================================
House_Exit(playerid, HouseID) // Эта функция для того чтобы выйти из дома
{
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, AHouseData[HouseID][HouseX], AHouseData[HouseID][HouseY], AHouseData[HouseID][HouseZ]);
        APlayerData[playerid][CurrentHouse] = 0;
        if (ExitHouseTimer > 0)
        {
            TogglePlayerControllable(playerid, 0);
                GameTextForPlayer(playerid, "Loading...", ExitHouseTimer, 4);
                SetTimerEx("House_ExitTimer", ExitHouseTimer, false, "ii", playerid, HouseID);
        }
        return 1;
}
//==============================================================================
forward House_ExitTimer(playerid, HouseID); // Позволяет двигаться игроку дальше после загрузки обьектов и зданий
public House_ExitTimer(playerid, HouseID)
{
    TogglePlayerControllable(playerid, 1);
        for (new CarSlot; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
        if (AHouseData[HouseID][VehicleIDs][CarSlot] != 0)
        SetVehicleToRespawn(AHouseData[HouseID][VehicleIDs][CarSlot]
);
        return 1;
}
//==============================================================================
House_SetOwner(playerid, HouseID) // Эта функция устанавливает собственность в данного игрока (если у него есть свободный слот для покупки дома)
{
        new FreeHouseSlot, Name[24], Msg[128];
        FreeHouseSlot = Player_GetFreeHouseSlot(playerid);
        if (FreeHouseSlot != -1)
        {
                GetPlayerName(playerid, Name, sizeof(Name));
                APlayerData[playerid][Houses][FreeHouseSlot] = HouseID;
                INT_GivePlayerMoney(playerid, -AHouseData[HouseID][HousePrice]);
                AHouseData[HouseID][Owned] = true;
                format(AHouseData[HouseID][Owner], 24, Name);
                if (AHouseData[HouseID][StaticHouse] == false)
                {
                        AHouseData[HouseID][HouseLevel] = 1;
                        AHouseData[HouseID][CarSlots] = 1;
                }
                format(AHouseData[HouseID][HouseName], 100, "%s's house", Name);
                House_UpdateEntrance(HouseID);
                HouseFile_Save(HouseID);
                format(Msg, 128, "Вы купили дом за $%i...", AHouseData[HouseID][HousePrice]);
                SendClientMessage(playerid, 0xFFFFFFAA, Msg);
        }
        else
        SendClientMessage(playerid, 0xFFFFFFAA, "У тебя и так много домов продай один дом чтобы купить этот дом...");
        return 1;
}
//==============================================================================
House_AddVehicle(HouseID, cModel, cPaint, cComponents[], Float:cx, Float:cy, Float:cz, Float:crot, Col1, Col2) // Эта функция добавляет транспортное средство к дому
{
        new vid, CarSlot;
        CarSlot = House_GetFreeCarSlot(HouseID);
        if (CarSlot != -1)
        {
                vid = CreateVehicle(cModel, cx, cy, cz, crot, Col1, Col2, 600);
                AHouseData[HouseID][VehicleIDs][CarSlot] = vid;
                AVehicleData[vid][Model] = cModel;
                AVehicleData[vid][PaintJob] = cPaint;
                if (cPaint != 0)
                ChangeVehiclePaintjob(vid, cPaint - 1);
                ChangeVehicleColor(vid, Col1, Col2);
                AVehicleData[vid][Color1] = Col1;
                AVehicleData[vid][Color2] = Col2;
                for (new i; i < 14; i++)
                {
                        AVehicleData[vid][Components][i] = cComponents[i];
                        if (AVehicleData[vid][Components][i] != 0)
                        AddVehicleComponent(vid, AVehicleData[vid][Components][i]);
                }
        AVehicleData[vid][SpawnX] = cx;
        AVehicleData[vid][SpawnY] = cy;
        AVehicleData[vid][SpawnZ] = cz;
        AVehicleData[vid][SpawnRot] = crot;
                AVehicleData[vid][Owned] = true;
                format(AVehicleData[vid][Owner], 24, AHouseData[HouseID][Owner]);
                AVehicleData[vid][BelongsToHouse] = HouseID;
        }
        else
        return 0;
        return vid;
}
//==============================================================================
House_ReplaceVehicle(HouseID, CarSlot) // Эта функция используется только, когда Вы паркуете автомобиль
{
        new vid, cModel, cPaint, cComponents[14], Float:cx, Float:cy, Float:cz, Float:crot, Col1, Col2, cFuel;
        vid = AHouseData[HouseID][VehicleIDs][CarSlot];
        cModel = AVehicleData[vid][Model];
        cPaint = AVehicleData[vid][PaintJob];
        for (new i; i < 14; i++)
        cComponents[i] = AVehicleData[vid][Components][i];
        Col1 = AVehicleData[vid][Color1];
        Col2 = AVehicleData[vid][Color2];
        cx = AVehicleData[vid][SpawnX];
        cy = AVehicleData[vid][SpawnY];
        cz = AVehicleData[vid][SpawnZ];
        crot = AVehicleData[vid][SpawnRot];
        cFuel = INT_GetVehicleFuel(vid);
        Vehicle_Delete(vid, HouseID, CarSlot);
        vid = House_AddVehicle(HouseID, cModel, cPaint, cComponents, Float:cx, Float:cy, Float:cz, Float:crot, Col1, Col2);
        INT_SetVehicleFuel(vid, cFuel);
        return vid;
}
//==============================================================================
Vehicle_Delete(vid, HouseID, CarSlot) // Эта функция удаляет транспортное средство и очищает все данные
{
        AHouseData[HouseID][VehicleIDs][CarSlot] = 0;
        DestroyVehicle(vid);
        AVehicleData[vid][Owned] = false;
        AVehicleData[vid][Owner] = 0;
        AVehicleData[vid][Model] = 0;
        AVehicleData[vid][PaintJob] = 0;
        for (new i; i < 14; i++)
        AVehicleData[vid][Components][i] = 0;
        AVehicleData[vid][Color1] = 0;
        AVehicleData[vid][Color2] = 0;
        AVehicleData[vid][SpawnX] = 0.0;
        AVehicleData[vid][SpawnY] = 0.0;
        AVehicleData[vid][SpawnZ] = 0.0;
        AVehicleData[vid][SpawnRot] = 0.0;
        AVehicleData[vid][BelongsToHouse] = 0;
        INT_SetVehicleFuel(vid, -1);
}
//==============================================================================
House_RemoveVehicles(HouseID) // Эта функция используется только, когда игрок выходит из системы (транспортные средства разгружены)
{
        new vid;
        for (new CarSlot; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
        {
                vid = AHouseData[HouseID][VehicleIDs][CarSlot];
                if (vid != 0)
                {
                        Vehicle_Delete(vid, HouseID, CarSlot);
                }
        }
}
//==============================================================================
Player_GetFreeHouseSlot(playerid) // Эта функция возвращает первую свободную щель дома для данного игрока
{
        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
        if (APlayerData[playerid][Houses][HouseSlot] == 0)
        return HouseSlot;
        return -1;
}
//==============================================================================
House_PlayerIsOwner(playerid, HouseID) // Эта функция проверяет если игроку принадлежит данный дом
{
        for (new HouseSlot; HouseSlot < MAX_HOUSESPERPLAYER; HouseSlot++)
        {
                if (APlayerData[playerid][Houses][HouseSlot] == HouseID)
                return 1;
        }
        return 0;
}
//==============================================================================
House_GetFreeCarSlot(HouseID) // Эта функция вовращает первый свободный слот авто либо свободных слотов не найдено
{
        for (new CarSlot; CarSlot < AHouseData[HouseID][CarSlots]; CarSlot++)
        {
                if (AHouseData[HouseID][VehicleIDs][CarSlot] == 0)
                    return CarSlot;
        }
        return -1;
}
//==============================================================================
House_CalcSellPrice(HouseID) // Эта функция включает продавать за цену дома
{
        new SellPrice, NumUpgrades, UpgradePrice;
        SellPrice = AHouseData[HouseID][HousePrice] / 2;
        NumUpgrades = AHouseData[HouseID][HouseLevel] - 1;
        UpgradePrice = ((AHouseData[HouseID][HousePrice] / 100) * HouseUpgradePercent) * NumUpgrades;
        SellPrice = SellPrice + UpgradePrice;
        return SellPrice;
}
//==============================================================================
VehicleBuyable_GetIndex(vModel) // Для моделей авто чтобы не спутать
{
        for (new i; i < sizeof(ABuyableVehicles); i++)
        {
                if (ABuyableVehicles[i][CarModel] == vModel)
                return i;
        }
        return -1;
}
//==============================================================================
stock StripNewLine(string[]) // Эта функция включает инклуд "dutils.inc"
{
        new len = strlen(string);
        if (string[0] == 0) return ;
        if ((string[len - 1] == '\n') || (string[len - 1] == '\r'))
        {
                string[len - 1] = 0;
                if (string[0]==0) return ;
                if ((string[len - 2] == '\n') || (string[len - 2] == '\r'))
                        string[len - 2] = 0;
        }
}
//==============================================================================
INT_GetPlayerMoney(playerid) // Для денег
{
        new Money;
        Money = CallRemoteFunction("Admin_GetPlayerMoney", "i", playerid);
        if (Money == 0)
        return GetPlayerMoney(playerid);
        else
        return Money;
}
//==============================================================================
INT_GivePlayerMoney(playerid, Money) // Для денег
{
        new Success;
        Success = CallRemoteFunction("Admin_GivePlayerMoney", "ii", playerid, Money);
        if (Success == 0)
        GivePlayerMoney(playerid, Money);
}
//==============================================================================
INT_CheckPlayerAdminLevel(playerid, AdminLevel) // Определяет достаточно ли админ уровень
{
        new Level;
        if (IsPlayerAdmin(playerid))
        return 1;
        Level = CallRemoteFunction("Admin_GetPlayerAdminLevel", "i", playerid);
        if (Level >= AdminLevel)
        return 1;
        else
        return 0;
}
//==============================================================================
INT_IsPlayerLoggedIn(playerid) // Определяет загрузился ли игрок до конца
{
        new LoggedIn;
        LoggedIn = CallRemoteFunction("Admin_IsPlayerLoggedIn", "i", playerid);
        switch (LoggedIn)
        {
                case 0: return 1;
                case 1: return 1;
                case -1: return 0;
        }
        return 0;
}
//==============================================================================
INT_SetVehicleFuel(vehicleid, Fuel) // Устанавливает топливо на авто
{
        CallRemoteFunction("Speedo_SetVehicleFuel", "ii", vehicleid, Fuel);
}
//==============================================================================
INT_GetVehicleFuel(vehicleid) // Определяет топливо в авто
{
        return CallRemoteFunction("Speedo_GetVehicleFuel", "i", vehicleid);
}
//==============================================================================
INT_IsPlayerJailed(playerid) // Эта функция работает, если игрок находится в тюрьме
{
        new Jailed;
        Jailed = CallRemoteFunction("Admin_IsPlayerJailed", "i", playerid);
        switch (Jailed)
        {
                case 0: return 0;
                case 1: return 1;
                case -1: return 0;
        }
        return 0;
}
//==============================================================================
forward Housing_IsVehicleOwned(vehicleid); // Для авто
public Housing_IsVehicleOwned(vehicleid)
{
        if (AVehicleData[vehicleid][Owned] == true)
        return 1;
        else
        return -1;
}
//№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№
//№                             System House by KoTe                          №
//№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№

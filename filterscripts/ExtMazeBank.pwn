/////////////////////////////////////
/// Samp-Mods.com - Все для SA-MP ///
/////////////////////////////////////

#include <a_samp>
#include <streamer>
#define FILTERSCRIPT

public OnFilterScriptInit()
{
		new bankaext;
		bankaext = CreateObject(10308, 948.774963, -1703.498291, 53.531391, 0.000000, 0.000000, -90.100006, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
		SetObjectMaterial(bankaext, 2, 18646, "matcolours", "grey-60-percent", 0x00000000);
		SetObjectMaterial(bankaext, 5, 18646, "matcolours", "grey-60-percent", 0x00000000);
		SetObjectMaterial(bankaext, 8, 11013, "crackdrive_sfse", "ws_asphalt2", 0x00000000);
		SetObjectMaterial(bankaext, 9, -1, "none", "none", 0xFF33CCCC);
		bankaext = CreateObject(19447, 935.346862, -1713.989990, 18.705818, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 955.306945, -1726.169799, 18.670988, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 932.167663, -1709.753051, 18.707611, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(4735, 927.264282, -1691.079956, 99.412460, 0.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "MAZE", 0, 120, "Ariel", 90, 0, 0xFFFFFFFF, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.263916, -1691.039916, 96.312446, 0.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "BANK", 0, 120, "Ariel", 90, 0, 0xFFFFFFFF, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.167480, -1681.820068, 98.312461, 90.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 120, "Ariel", 199, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.183532, -1683.350219, 97.202461, 270.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 120, "Ariel", 199, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(19447, 952.568786, -1720.528320, 18.688877, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 943.678833, -1720.512695, 18.688877, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 938.408691, -1720.503540, 18.688877, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 927.886718, -1706.680175, 18.718835, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 927.886718, -1697.200439, 18.718835, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 927.886718, -1688.080444, 18.718835, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 927.886718, -1681.510498, 18.718835, 0.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 929.082031, -1694.338867, 13.878835, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 929.076599, -1691.198974, 13.878835, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 929.076171, -1690.978881, 12.128833, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0xFFFF0000);
		bankaext = CreateObject(19447, 929.082519, -1694.548828, 12.128833, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0xFFFF0000);
		bankaext = CreateObject(19447, 929.075927, -1690.769042, 10.418833, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 929.083007, -1694.758911, 10.418833, 90.000000, 90.099990, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19325, 927.349731, -1692.581542, 16.575088, 90.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 130, "Ariel", 160, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(19325, 927.349731, -1693.021606, 16.255088, 270.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 130, "Ariel", 160, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(19447, 958.351135, -1730.738403, 18.671077, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(19447, 963.731018, -1730.748168, 18.671077, 0.000000, 90.099990, -90.099990, 900.00);
		SetObjectMaterial(bankaext, 0, 18646, "matcolours", "grey-30-percent", 0x00000000);
		bankaext = CreateObject(4735, 927.334289, -1686.359985, 26.232482, 90.000000, -0.799999, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 120, "Ariel", 199, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.316101, -1687.959472, 24.932481, 270.000000, -0.799999, -0.700000, 900.00);
		SetObjectMaterialText(bankaext, "E", 0, 120, "Ariel", 199, 0, 0xFFFF0000, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.305114, -1696.510253, 26.920227, 0.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "MAZE", 0, 120, "Ariel", 90, 0, 0xFFFFFFFF, 0x00000000, 1);
		bankaext = CreateObject(4735, 927.305114, -1696.510253, 24.120227, 0.000000, 0.000000, 0.599999, 900.00);
		SetObjectMaterialText(bankaext, "BANK", 0, 120, "Ariel", 90, 0, 0xFFFFFFFF, 0x00000000, 1);
		bankaext = CreateObject(6123, 917.398010, -1672.910034, 12.398400, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 1, 6487, "councl_law2", "rodeo3sjm", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1750.489746, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1725.689697, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1700.929809, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1676.009887, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1652.269897, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1627.960083, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 917.411132, -1604.239990, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 923.181213, -1673.930175, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 923.181213, -1713.120117, 0.667287, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 923.191894, -1692.776245, 1.321503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 923.191894, -1695.536254, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 923.191894, -1690.026123, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 923.191894, -1590.606201, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 920.011840, -1590.606201, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 915.371704, -1590.606201, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 911.681823, -1590.606201, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 911.681823, -1761.465576, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 923.141723, -1761.465576, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 920.301635, -1761.465576, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18980, 914.931518, -1761.465576, 0.781503, 0.000000, 0.000000, 0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 927.955322, -1743.856201, 0.667287, 0.000000, 0.000000, -0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 927.955322, -1750.886352, 0.667287, 0.000000, 0.000000, -0.000000, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 940.244873, -1765.212158, 0.925609, 1.199999, 0.000000, -100.400001, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		bankaext = CreateObject(18981, 950.284912, -1767.054443, 1.139431, 1.199999, 0.000000, -100.400001, 900.00);
		SetObjectMaterial(bankaext, 0, 4829, "airport_las", "Grass_128HV", 0x00000000);
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		bankaext = CreateObject(1557, 927.391906, -1691.266479, 12.537508, 0.000000, 0.000000, -90.200012, 900.00);
		bankaext = CreateObject(1557, 927.424743, -1694.266113, 12.537508, 0.000000, 0.000000, 91.200004, 900.00);
		bankaext = CreateObject(6203, 956.195007, -1689.599975, 12.796895, 0.000000, 0.000000, 0.000000, 900.00);
		bankaext = CreateObject(19124, 923.167846, -1695.537597, 13.226980, 0.000000, 0.000000, 0.000000, 900.00);
		bankaext = CreateObject(19124, 923.167846, -1692.737670, 13.986980, 0.000000, 0.000000, 0.000000, 900.00);
		bankaext = CreateObject(19124, 923.167846, -1690.047729, 13.226980, 0.000000, 0.000000, 0.000000, 900.00);
		bankaext = CreateObject(738, 923.157348, -1685.886474, 12.554203, 0.000000, 0.000000, 0.000000, 900.00);
		bankaext = CreateObject(738, 923.157348, -1701.176513, 12.554203, 0.000000, 0.000000, 0.000000, 900.00);
        return 1;
}

public OnPlayerConnect(playerid)
{
        SendClientMessage(playerid,-1,"Samp-Mods.com - Все для SA-MP");
        
		RemoveBuildingForPlayer(playerid, 6205, 954.273, -1720.800, 20.773, 0.250);
		RemoveBuildingForPlayer(playerid, 6208, 954.273, -1720.800, 20.773, 0.250);
		RemoveBuildingForPlayer(playerid, 1231, 932.468, -1709.729, 15.218, 0.250);
		RemoveBuildingForPlayer(playerid, 748, 931.273, -1702.530, 12.390, 0.250);
		RemoveBuildingForPlayer(playerid, 1231, 937.265, -1696.839, 15.218, 0.250);
		RemoveBuildingForPlayer(playerid, 729, 931.859, -1703.979, 11.320, 0.250);
		RemoveBuildingForPlayer(playerid, 1231, 933.257, -1731.479, 15.218, 0.250);
		RemoveBuildingForPlayer(playerid, 748, 931.273, -1705.630, 12.390, 0.250);
		RemoveBuildingForPlayer(playerid, 760, 930.085, -1704.479, 12.203, 0.250);
		RemoveBuildingForPlayer(playerid, 729, 940.929, -1668.859, 11.320, 0.250);
		RemoveBuildingForPlayer(playerid, 726, 958.039, -1678.050, 10.742, 0.250);
		RemoveBuildingForPlayer(playerid, 634, 972.335, -1675.540, 11.382, 0.250);
		RemoveBuildingForPlayer(playerid, 615, 968.226, -1665.689, 12.210, 0.250);
		RemoveBuildingForPlayer(playerid, 729, 970.023, -1718.000, 11.320, 0.250);
		RemoveBuildingForPlayer(playerid, 6203, 956.195, -1689.599, 12.796, 0.250);
		RemoveBuildingForPlayer(playerid, 6207, 956.195, -1689.599, 12.796, 0.250);
		RemoveBuildingForPlayer(playerid, 1297, 922.750, -1683.339, 15.937, 0.250);
		RemoveBuildingForPlayer(playerid, 6123, 917.398, -1672.910, 12.398, 0.250);
		RemoveBuildingForPlayer(playerid, 6081, 917.398, -1672.910, 12.398, 0.250);
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        if(strcmp("/sm", cmdtext, true, 10) == 0)
        {
            SetPlayerPos(playerid,919.1421,-1692.8202,13.3538);
            SetPlayerInterior(playerid, 0);
            return 1;
        }
        return 0;
}

/////////////////////////////////////
/// Samp-Mods.com - Все для SA-MP ///
/////////////////////////////////////

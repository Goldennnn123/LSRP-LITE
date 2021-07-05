#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 1226, 2114.7188, -1785.1797, 16.3984, 0.25);
    return 1;
}


hook OnGameModeInit()
{
    CreateDynamicObject(1372, 2092.55176, -1830.85364, 12.64420,   0.00000, 0.00000, 91.32000);
    CreateDynamicObject(1339, 2092.61719, -1829.01379, 13.19010,   0.00000, 0.00000, 67.79996);
    CreateDynamicObject(2840, 2092.64185, -1828.17407, 12.53200,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2840, 2093.79346, -1830.03015, 12.53200,   0.00000, 0.00000, -128.15996);
    CreateDynamicObject(2840, 2093.33228, -1831.19885, 12.53200,   0.00000, 0.00000, -65.87997);
    CreateDynamicObject(2840, 2092.82080, -1829.78113, 12.53200,   0.00000, 0.00000, -89.04005);
    CreateDynamicObject(1415, 2093.21118, -1823.06995, 12.60330,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.28394, -1829.00061, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.87061, -1828.20129, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.17578, -1829.04236, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.95801, -1830.30164, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.19263, -1829.58496, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.63550, -1830.33826, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.42896, -1831.59204, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.95947, -1831.45923, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.00000, -1830.86060, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.15552, -1830.31982, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.79663, -1831.45776, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.32764, -1831.29468, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.32764, -1831.29468, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.44824, -1828.58032, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.78784, -1828.88501, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.57080, -1829.71204, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.88867, -1827.48950, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.64111, -1828.78577, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.53271, -1829.78076, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.09399, -1829.74011, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.47754, -1831.40808, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.43530, -1830.80420, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.23071, -1831.09021, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.01563, -1830.35962, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.17969, -1825.36035, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.38818, -1824.85779, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2093.69336, -1825.27856, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.32422, -1824.21704, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.69482, -1824.13403, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2094.44287, -1824.63110, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.94653, -1826.43335, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.06055, -1825.72107, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.17944, -1826.47583, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.63062, -1825.99890, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.72388, -1827.05432, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.23999, -1828.67627, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2095.17065, -1828.12378, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2097.02832, -1830.40479, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.14941, -1829.42151, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.90845, -1827.16711, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.83252, -1829.60315, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2096.83252, -1829.60315, 12.52410,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19456, 2091.77246, -1827.17932, 13.33138,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19456, 2096.50098, -1822.43689, 13.33140,   0.00000, 0.00000, 89.76000);
    CreateDynamicObject(19456, 2106.10107, -1822.47693, 13.33140,   0.00000, 0.00000, 89.76000);
    CreateDynamicObject(1440, 2096.09961, -1823.61804, 13.05800,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1265, 2092.52075, -1827.46240, 12.98540,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1265, 2093.08984, -1826.93555, 12.98540,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1265, 2092.33643, -1826.47888, 12.98540,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2059, 2094.13257, -1826.01025, 12.56950,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(672, 2102.25562, -1829.93274, 12.81597,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2128.24414, 2128.00000, 14.70910,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2127.96167, -1788.28491, 12.64200,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, 2132.37207, -1793.05469, 12.62940,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, 2133.54395, -1799.64893, 12.62940,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, 2131.72461, -1804.26746, 12.62940,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, 2132.41577, -1809.62439, 12.62940,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1432, 2132.72290, -1816.74133, 12.62940,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2131.91333, -1793.29272, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.23462, -1792.42261, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.82080, -1793.45520, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2131.99316, -1792.62671, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2131.86255, -1792.82800, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2212, 2132.45459, -1793.25903, 13.30340,   -25.50000, 22.74000, 0.00000);
    CreateDynamicObject(1302, 2123.99097, -1799.09277, 12.52940,   0.00000, 0.00000, 88.92000);
    CreateDynamicObject(1302, 2124.01099, -1797.89282, 12.52940,   0.00000, 0.00000, 88.92000);
    CreateDynamicObject(1256, 2124.10034, -1804.81079, 13.18990,   0.00000, 0.00000, 179.52005);
    CreateDynamicObject(1256, 2124.10034, -1802.01074, 13.18990,   0.00000, 0.00000, 179.52010);
    CreateDynamicObject(1256, 2124.08032, -1807.61084, 13.18990,   0.00000, 0.00000, 179.52010);
    CreateDynamicObject(1280, 2117.17627, -1790.80627, 12.92950,   0.00000, 0.00000, -89.76000);
    CreateDynamicObject(1280, 2120.91626, -1790.80627, 12.92950,   0.00000, 0.00000, -89.76000);
    CreateDynamicObject(1280, 2113.67627, -1790.80627, 12.92950,   0.00000, 0.00000, -89.76000);
    CreateDynamicObject(948, 2118.94141, -1790.69238, 12.52810,   0.00000, 0.00000, -88.80000);
    CreateDynamicObject(948, 2115.42139, -1790.66138, 12.52810,   0.00000, 0.00000, -88.80000);
    CreateDynamicObject(970, 2100.04175, -1774.73364, 13.09700,   0.00000, 0.00000, 81.35980);
    CreateDynamicObject(970, 2099.39966, -1778.83398, 13.09700,   0.00000, 0.00000, 80.75978);
    CreateDynamicObject(970, 2100.23706, -1773.40991, 13.09700,   0.00000, 0.00000, 81.35980);
    CreateDynamicObject(970, 2101.51294, -1769.50623, 13.09700,   0.00000, 0.00000, 62.39980);
    CreateDynamicObject(970, 2098.95508, -1781.57043, 13.09700,   0.00000, 0.00000, 80.75980);
    CreateDynamicObject(970, 2101.61914, -1786.09473, 13.09700,   0.00000, 0.00000, 0.35979);
    CreateDynamicObject(970, 2100.39087, -1786.09314, 13.09700,   0.00000, 0.00000, 0.35980);
    CreateDynamicObject(970, 2098.57593, -1784.05334, 13.09700,   0.00000, 0.00000, -98.16021);
    CreateDynamicObject(970, 2101.71606, -1786.78674, 13.09700,   0.00000, 0.00000, 19.67978);
    CreateDynamicObject(970, 2098.45313, -1789.09045, 13.09700,   0.00000, 0.00000, 50.39970);
    CreateDynamicObject(970, 2095.04321, -1790.67578, 13.09700,   0.00000, 0.00000, -1.08030);
    CreateDynamicObject(970, 2093.47266, -1788.60767, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2094.51050, -1784.56287, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2095.54077, -1780.51941, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2096.57495, -1776.48621, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2097.59424, -1772.45679, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2098.62183, -1768.42651, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2099.65674, -1764.40295, 13.09700,   0.00000, 0.00000, 75.59970);
    CreateDynamicObject(970, 2102.25659, -1762.39929, 13.09700,   0.00000, 0.00000, 0.11970);
    CreateDynamicObject(970, 2105.14014, -1764.31226, 13.09700,   0.00000, 0.00000, -67.56030);
    CreateDynamicObject(970, 2104.01807, -1767.06775, 13.09700,   0.00000, 0.00000, -156.48030);
    CreateDynamicObject(14468, 2096.00171, -1788.13477, 12.72380,   0.00000, 0.00000, 75.84006);
    CreateDynamicObject(14468, 2097.18994, -1783.01038, 12.72380,   0.00000, 0.00000, 75.84006);
    CreateDynamicObject(14468, 2097.99316, -1777.69849, 12.72380,   0.00000, 0.00000, 75.84006);
    CreateDynamicObject(14468, 2099.14380, -1772.34204, 12.72380,   0.00000, 0.00000, 75.84006);
    CreateDynamicObject(14468, 2100.37305, -1768.19519, 12.72380,   0.00000, 0.00000, 55.08007);
    CreateDynamicObject(14468, 2102.47998, -1765.13635, 12.72380,   0.00000, 0.00000, 55.08007);
    CreateDynamicObject(19425, 2122.18506, -1762.16089, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2118.52051, -1762.14319, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2114.78687, -1762.09668, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2111.17847, -1762.11157, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2111.08594, -1760.66589, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2114.71460, -1760.68921, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2118.32495, -1760.75037, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2122.22290, -1760.84436, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2122.71094, -1759.56213, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2118.35840, -1759.55920, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2114.71826, -1759.48853, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19425, 2110.85474, -1759.50500, 12.35170,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2123.46777, -1785.86511, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2119.81592, -1785.88147, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2115.78442, -1785.85645, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2110.91187, -1785.85779, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2106.18286, -1785.89539, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2212, 2133.64307, -1799.95898, 13.30340,   -25.50000, 22.74000, 0.00000);
    CreateDynamicObject(1664, 2133.11182, -1799.33716, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2133.09912, -1799.87744, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2133.16455, -1799.44495, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2133.90942, -1800.16370, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2133.27954, -1799.16443, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2212, 2131.69165, -1804.46191, 13.30340,   -25.50000, 22.74000, -27.96000);
    CreateDynamicObject(1664, 2132.22412, -1804.28735, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2132.25757, -1804.12585, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2131.22583, -1804.30347, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2131.62744, -1803.65417, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.06885, -1804.66858, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2212, 2132.39380, -1809.81970, 13.30340,   -25.50000, 22.74000, -27.96000);
    CreateDynamicObject(1667, 2132.30542, -1809.05212, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.84497, -1809.94995, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.05835, -1809.93884, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2132.76855, -1809.21301, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2132.89063, -1809.37170, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.16748, -1808.47339, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.51880, -1807.82727, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.35010, -1809.35510, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.74683, -1807.52478, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.59009, -1809.08057, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.29761, -1808.42249, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.97534, -1809.50330, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.71509, -1807.10596, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.56445, -1805.92883, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.60229, -1806.83826, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.93872, -1810.48230, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.97534, -1809.50330, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.71509, -1807.10596, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.70776, -1803.93799, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.33765, -1802.95789, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.29761, -1808.42249, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.60229, -1803.06543, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.17871, -1803.85645, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.29224, -1805.77515, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.22949, -1800.05212, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.07520, -1798.95642, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.77954, -1800.73621, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.73608, -1791.41455, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.87134, -1802.01074, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.64282, -1812.06909, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.81226, -1821.77637, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1280, 2108.43018, -1790.77051, 12.92950,   0.00000, 0.00000, -89.76000);
    CreateDynamicObject(948, 2110.17725, -1790.85742, 12.52810,   0.00000, 0.00000, -88.80000);
    CreateDynamicObject(948, 2111.90796, -1790.83118, 12.52810,   0.00000, 0.00000, -88.80000);
    CreateDynamicObject(19839, 2134.63257, -1799.20386, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.88184, -1800.78943, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2212, 2132.68628, -1816.88513, 13.30340,   -25.50000, 22.74000, -46.32002);
    CreateDynamicObject(1667, 2132.12085, -1816.77893, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2132.39282, -1816.34644, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1664, 2132.29321, -1816.47681, 13.42300,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2133.09912, -1817.17810, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1667, 2132.79004, -1816.14600, 13.33092,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.75562, -1810.57825, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.27905, -1811.11133, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.62280, -1811.76416, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2129.12988, -1812.23413, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.21045, -1811.10071, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.59424, -1809.01624, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.83130, -1810.06567, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.44336, -1807.82654, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.00098, -1814.21143, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.38354, -1814.78064, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.02637, -1814.63086, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.94458, -1815.68066, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.75171, -1815.76196, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.52173, -1815.05811, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.48926, -1815.19641, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.87354, -1816.12769, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.14844, -1817.71240, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.67969, -1817.81226, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.89355, -1816.42688, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.80127, -1817.71484, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.16040, -1817.19739, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2134.11890, -1816.89294, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.55396, -1817.02209, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.71582, -1804.97339, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.97729, -1804.21362, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2134.81787, -1799.70459, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.93066, -1798.13342, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.20923, -1798.12781, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.77856, -1799.28625, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.03027, -1799.96912, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.44482, -1801.03748, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.70459, -1799.48450, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.34473, -1799.03943, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.37793, -1798.66382, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2135.14917, -1798.64929, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2143.41992, -1796.38513, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.19092, -1800.59680, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.75952, -1793.88855, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.40015, -1793.61316, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.72485, -1793.98535, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.56079, -1793.36108, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.36035, -1793.84949, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.34351, -1793.12488, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.00049, -1792.88623, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.96533, -1793.28613, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2133.45117, -1791.77051, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2131.82568, -1792.75098, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2132.74536, -1792.00061, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19839, 2130.83008, -1792.42896, 12.44828,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2128.20044, -1799.65430, 12.64202,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2127.83887, -1809.08850, 12.64202,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2127.96240, -1819.19775, 12.64202,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2123.03809, -1826.35461, 12.64202,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(738, 2111.27441, -1826.52637, 12.64202,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1226, 2101.22925, -1785.44421, 16.40625,   356.85840, 0.00000, -94.94165);
    CreateDynamicObject(1226, 2098.06323, -1791.23523, 16.40625,   356.85840, 0.00000, 61.05837);
    CreateDynamicObject(1226, 2096.44482, -1774.69885, 16.40625,   356.85840, 0.00000, -3.14159);
    CreateDynamicObject(1226, 2093.23877, -1786.78528, 16.40625,   356.85840, 0.00000, -3.14159);
    CreateDynamicObject(672, 2132.39795, -1826.23206, 12.81597,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2092.55103, -1791.21680, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2091.83325, -1802.03284, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2091.85669, -1812.03247, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2091.88599, -1822.07642, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.75122, -1816.78394, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1214, 2098.85400, -1796.30591, 12.29263,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1571, 2125.50659, -1769.07495, 13.87880,   0.00000, 0.00000, -89.88010);
    CreateDynamicObject(1257, 2114.02319, -1746.08813, 13.76000,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1216, 2117.22754, -1747.06836, 13.12110,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(633, 2105.09814, -1762.66528, 13.54350,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1226, 2124.09912, -1761.33948, 16.40625,   356.85840, 0.00000, -3.14159);
    CreateDynamicObject(1570, 2125.22949, -1776.84851, 13.67247,   0.00000, 0.00000, -89.88004);
    CreateDynamicObject(738, 2125.99341, -1781.41943, 12.64200,   0.00000, 0.00000, 0.00000);
    return 1;
}
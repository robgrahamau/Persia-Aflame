inputhash = 21002
hash = 21003
-- items go in here.
function robinput()
	if unexpected_condition then error() end
	bombergroup = {
                                ["modulation"] = 0,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["radioSet"] = true,
                                ["task"] = "Ground Attack",
                                ["uncontrolled"] = false,
                                ["route"] = 
                                {
                                    ["points"] = 
                                    {
                                        [1] = 
                                        {
                                            ["alt"] = 28,
                                            ["action"] = "From Parking Area",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                        [1] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 1,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = 1,
                                                                        ["name"] = 1,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [1]
                                                        [2] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 2,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = 1,
                                                                        ["name"] = 3,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [2]
                                                        [3] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 3,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["variantIndex"] = 2,
                                                                        ["name"] = 5,
                                                                        ["formationIndex"] = 2,
                                                                        ["value"] = 131074,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [3]
                                                        [4] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 4,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = true,
                                                                        ["name"] = 15,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [4]
                                                        [5] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 5,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["targetTypes"] = 
                                                                        {
                                                                        }, -- end of ["targetTypes"]
                                                                        ["name"] = 21,
                                                                        ["value"] = "none;",
                                                                        ["noTargetTypes"] = 
                                                                        {
                                                                            [1] = "Fighters",
                                                                            [2] = "Multirole fighters",
                                                                            [3] = "Bombers",
                                                                            [4] = "Helicopters",
                                                                            [5] = "Infantry",
                                                                            [6] = "Fortifications",
                                                                            [7] = "Tanks",
                                                                            [8] = "IFV",
                                                                            [9] = "APC",
                                                                            [10] = "Artillery",
                                                                            [11] = "Unarmed vehicles",
                                                                            [12] = "AAA",
                                                                            [13] = "SR SAM",
                                                                            [14] = "MR SAM",
                                                                            [15] = "LR SAM",
                                                                            [16] = "Aircraft Carriers",
                                                                            [17] = "Cruisers",
                                                                            [18] = "Destroyers",
                                                                            [19] = "Frigates",
                                                                            [20] = "Corvettes",
                                                                            [21] = "Light armed ships",
                                                                            [22] = "Unarmed ships",
                                                                            [23] = "Submarines",
                                                                            [24] = "Cruise missiles",
                                                                            [25] = "Antiship Missiles",
                                                                            [26] = "AA Missiles",
                                                                            [27] = "AG Missiles",
                                                                            [28] = "SA Missiles",
                                                                        }, -- end of ["noTargetTypes"]
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [5]
                                                        [6] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 6,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "EPLRS",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = true,
                                                                        ["groupId"] = 1,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [6]
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "TakeOffParkingHot",
                                            ["ETA"] = 0,
                                            ["ETA_locked"] = true,
                                            ["y"] = -160285.640625,
                                            ["x"] = -189216.875,
                                            ["formation_template"] = "",
                                            ["airdromeId"] = 22,
                                            ["speed_locked"] = true,
                                        }, -- end of [1]
                                        [2] = 
                                        {
                                            ["alt"] = 5048.0976,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 242.02460052648,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 214.96310392692,
                                            ["ETA_locked"] = false,
                                            ["y"] = -207625.3275551,
                                            ["x"] = -167636.8817381,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [2]
                                        [3] = 
                                        {
                                            ["alt"] = 7924.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 217.62629620522,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 368.48006302753,
                                            ["ETA_locked"] = false,
                                            ["y"] = -194164.24616834,
                                            ["x"] = -137059.39929146,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [3]
                                        [4] = 
                                        {
                                            ["alt"] = 8229.6,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 222.92465080381,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                        [1] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = false,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 1,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["variantIndex"] = 1,
                                                                        ["name"] = 5,
                                                                        ["formationIndex"] = 1,
                                                                        ["value"] = 65537,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [1]
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 544.42028619132,
                                            ["ETA_locked"] = false,
                                            ["y"] = -156499.15114003,
                                            ["x"] = -126120.48529556,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [4]
                                        [5] = 
                                        {
                                            ["alt"] = 7924.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 217.62629620522,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                        [1] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = false,
                                                            ["id"] = "CarpetBombing",
                                                            ["number"] = 1,
                                                            ["params"] = 
                                                            {
                                                                ["attackType"] = "Carpet",
                                                                ["attackQtyLimit"] = false,
                                                                ["attackQty"] = 1,
                                                                ["expend"] = "All",
                                                                ["altitudeEdited"] = true,
                                                                ["x"] = -126169.55994067,
                                                                ["carpetLength"] = 1414.272,
                                                                ["groupAttack"] = false,
                                                                ["y"] = -88923.364817049,
                                                                ["altitudeEnabled"] = true,
                                                                ["weaponType"] = 805339120,
                                                                ["altitude"] = 1828.8,
                                                            }, -- end of ["params"]
                                                        }, -- end of [1]
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 712.27663466108,
                                            ["ETA_locked"] = false,
                                            ["y"] = -119969.19658152,
                                            ["x"] = -126112.58869668,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [5]
                                        [6] = 
                                        {
                                            ["alt"] = 8096.0976,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 186.1065626097,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 1145.6931931037,
                                            ["ETA_locked"] = false,
                                            ["y"] = -39313.177705321,
                                            ["x"] = -125158.14647817,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [6]
                                        [7] = 
                                        {
                                            ["alt"] = 2000,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 2284.5225806315,
                                            ["ETA_locked"] = false,
                                            ["y"] = -91373.556921424,
                                            ["x"] = -179764.26550924,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [7]
                                        [8] = 
                                        {
                                            ["alt"] = 2000,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 2731.3692352346,
                                            ["ETA_locked"] = false,
                                            ["y"] = -152089.45150842,
                                            ["x"] = -192620.25157483,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [8]
                                        [9] = 
                                        {
                                            ["alt"] = 28,
                                            ["action"] = "Landing",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Land",
                                            ["ETA"] = 2808.9700394841,
                                            ["ETA_locked"] = false,
                                            ["y"] = -162030.984375,
                                            ["x"] = -188457.460938,
                                            ["formation_template"] = "",
                                            ["airdromeId"] = 22,
                                            ["speed_locked"] = true,
                                        }, -- end of [9]
                                    }, -- end of ["points"]
                                }, -- end of ["route"]
                                ["groupId"] = 1,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                    [1] = 
                                    {
                                        ["alt"] = 28,
                                        ["hardpoint_racks"] = true,
                                        ["alt_type"] = "BARO",
                                        ["livery_id"] = "usaf - 343d bs",
                                        ["skill"] = "High",
                                        ["parking"] = "96",
                                        ["speed"] = 138.88888888889,
                                        ["type"] = "B-52H",
                                        ["unitId"] = 1,
                                        ["psi"] = 1.1430847557645,
                                        ["parking_id"] = "12",
                                        ["x"] = -189216.875,
                                        ["name"] = "Aerial-1-1",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{6C47D097-83FF-4FB2-9496-EAB36DDF0B05}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [3]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = "141135",
                                            ["flare"] = 192,
                                            ["chaff"] = 1125,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -160285.640625,
                                        ["heading"] = -1.1430847557645,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 1,
                                            ["name"] = "Enfield11",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "010",
                                    }, -- end of [1]
                                    [2] = 
                                    {
                                        ["alt"] = 28,
                                        ["alt_type"] = "BARO",
                                        ["livery_id"] = "usaf - 343d bs",
                                        ["skill"] = "High",
                                        ["parking"] = "95",
                                        ["speed"] = 138.88888888889,
                                        ["type"] = "B-52H",
                                        ["unitId"] = 2,
                                        ["psi"] = 1.1430847557645,
                                        ["parking_id"] = "11",
                                        ["x"] = -189170.640625,
                                        ["name"] = "Aerial-1-2",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{6C47D097-83FF-4FB2-9496-EAB36DDF0B05}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [3]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = "141135",
                                            ["flare"] = 192,
                                            ["chaff"] = 1125,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -160342.453125,
                                        ["heading"] = -1.1430847557645,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 2,
                                            ["name"] = "Enfield12",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "011",
                                    }, -- end of [2]
                                    [3] = 
                                    {
                                        ["alt"] = 28,
                                        ["alt_type"] = "BARO",
                                        ["livery_id"] = "usaf - 343d bs",
                                        ["skill"] = "High",
                                        ["parking"] = "97",
                                        ["speed"] = 138.88888888889,
                                        ["type"] = "B-52H",
                                        ["unitId"] = 3,
                                        ["psi"] = 1.1430847557645,
                                        ["parking_id"] = "13",
                                        ["x"] = -189265.03125,
                                        ["name"] = "Aerial-1-3",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{6C47D097-83FF-4FB2-9496-EAB36DDF0B05}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [3]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = "141135",
                                            ["flare"] = 192,
                                            ["chaff"] = 1125,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -160227.265625,
                                        ["heading"] = -1.1430847557645,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 3,
                                            ["name"] = "Enfield13",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "012",
                                    }, -- end of [3]
                                    [4] = 
                                    {
                                        ["alt"] = 28,
                                        ["alt_type"] = "BARO",
                                        ["livery_id"] = "usaf - 343d bs",
                                        ["skill"] = "High",
                                        ["parking"] = "94",
                                        ["speed"] = 138.88888888889,
                                        ["type"] = "B-52H",
                                        ["unitId"] = 4,
                                        ["psi"] = 1.1430847557645,
                                        ["parking_id"] = "10",
                                        ["x"] = -189123.453125,
                                        ["name"] = "Aerial-1-4",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{6C47D097-83FF-4FB2-9496-EAB36DDF0B05}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{585D626E-7F42-4073-AB70-41E728C333E2}",
                                                }, -- end of [3]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = "141135",
                                            ["flare"] = 192,
                                            ["chaff"] = 1125,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -160400.03125,
                                        ["heading"] = -1.1430847557645,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 4,
                                            ["name"] = "Enfield14",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "013",
                                    }, -- end of [4]
                                }, -- end of ["units"]
                                ["y"] = -160285.640625,
                                ["x"] = -189216.875,
                                ["name"] = "bimb11",
                                ["communication"] = false,
                                ["start_time"] = 0,
                                ["frequency"] = 0,

                            }
	 
miragegroup = {

                                ["modulation"] = 0,
                                ["tasks"] = 
                                {
                                }, -- end of ["tasks"]
                                ["task"] = "Ground Attack",
                                ["uncontrolled"] = false,
                                ["taskSelected"] = true,
                                ["route"] = 
                                {
                                    ["points"] = 
                                    {
                                        [1] = 
                                        {
                                            ["alt"] = 22,
                                            ["action"] = "From Parking Area Hot",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                        [1] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 1,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = 1,
                                                                        ["name"] = 1,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [1]
                                                        [2] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 2,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = 1,
                                                                        ["name"] = 3,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [2]
                                                        [3] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 3,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["variantIndex"] = 2,
                                                                        ["name"] = 5,
                                                                        ["formationIndex"] = 2,
                                                                        ["value"] = 131074,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [3]
                                                        [4] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 4,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["value"] = true,
                                                                        ["name"] = 15,
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [4]
                                                        [5] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = true,
                                                            ["id"] = "WrappedAction",
                                                            ["number"] = 5,
                                                            ["params"] = 
                                                            {
                                                                ["action"] = 
                                                                {
                                                                    ["id"] = "Option",
                                                                    ["params"] = 
                                                                    {
                                                                        ["targetTypes"] = 
                                                                        {
                                                                        }, -- end of ["targetTypes"]
                                                                        ["name"] = 21,
                                                                        ["value"] = "none;",
                                                                        ["noTargetTypes"] = 
                                                                        {
                                                                            [1] = "Fighters",
                                                                            [2] = "Multirole fighters",
                                                                            [3] = "Bombers",
                                                                            [4] = "Helicopters",
                                                                            [5] = "Infantry",
                                                                            [6] = "Fortifications",
                                                                            [7] = "Tanks",
                                                                            [8] = "IFV",
                                                                            [9] = "APC",
                                                                            [10] = "Artillery",
                                                                            [11] = "Unarmed vehicles",
                                                                            [12] = "AAA",
                                                                            [13] = "SR SAM",
                                                                            [14] = "MR SAM",
                                                                            [15] = "LR SAM",
                                                                            [16] = "Aircraft Carriers",
                                                                            [17] = "Cruisers",
                                                                            [18] = "Destroyers",
                                                                            [19] = "Frigates",
                                                                            [20] = "Corvettes",
                                                                            [21] = "Light armed ships",
                                                                            [22] = "Unarmed ships",
                                                                            [23] = "Submarines",
                                                                            [24] = "Cruise missiles",
                                                                            [25] = "Antiship Missiles",
                                                                            [26] = "AA Missiles",
                                                                            [27] = "AG Missiles",
                                                                            [28] = "SA Missiles",
                                                                        }, -- end of ["noTargetTypes"]
                                                                    }, -- end of ["params"]
                                                                }, -- end of ["action"]
                                                            }, -- end of ["params"]
                                                        }, -- end of [5]
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "TakeOffParkingHot",
                                            ["ETA"] = 0,
                                            ["ETA_locked"] = true,
                                            ["y"] = -30677.607421875,
                                            ["x"] = -61191.953125,
                                            ["formation_template"] = "",
                                            ["airdromeId"] = 28,
                                            ["speed_locked"] = true,
                                        }, -- end of [1]
                                        [2] = 
                                        {
                                            ["alt"] = 2000,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 267.80291260552,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 29.938707705696,
                                            ["ETA_locked"] = false,
                                            ["y"] = -37422.388119795,
                                            ["x"] = -65526.813635782,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [2]
                                        [3] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 267.80291260552,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 91.40646387709,
                                            ["ETA_locked"] = false,
                                            ["y"] = -49771.509563685,
                                            ["x"] = -76411.286889185,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [3]
                                        [4] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 252.92203615675,
                                            ["ETA_locked"] = false,
                                            ["y"] = -71724.185963678,
                                            ["x"] = -116060.16655512,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [5]
                                        [5] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 302.55400204991,
                                            ["ETA_locked"] = false,
                                            ["y"] = -80438.225450698,
                                            ["x"] = -127053.26252337,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [6]
                                        [6] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 380.20566520516,
                                            ["ETA_locked"] = false,
                                            ["y"] = -97631.695669318,
                                            ["x"] = -140694.0858742,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [7]
                                        [7] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                        [1] = 
                                                        {
                                                            ["enabled"] = true,
                                                            ["auto"] = false,
                                                            ["id"] = "CarpetBombing",
                                                            ["number"] = 1,
                                                            ["params"] = 
                                                            {
                                                                ["attackType"] = "Carpet",
                                                                ["attackQtyLimit"] = false,
                                                                ["attackQty"] = 1,
                                                                ["expend"] = "All",
                                                                ["y"] = -172466.12520992,
                                                                ["x"] = -213315.56203037,
                                                                ["carpetLength"] = 500,
                                                                ["groupAttack"] = false,
                                                                ["altitudeEnabled"] = false,
                                                                ["weaponType"] = 805339120,
                                                                ["altitude"] = 393.8,
                                                            }, -- end of ["params"]
                                                        }, -- end of [1]
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 850.61515723596,
                                            ["ETA_locked"] = false,
                                            ["y"] = -146382.91152932,
                                            ["x"] = -232641.20040265,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [11]
                                        [8] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 1103.8993069756,
                                            ["ETA_locked"] = false,
                                            ["y"] = -203665.92739308,
                                            ["x"] = -189705.30897583,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [12]
                                        [9] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 1199.2932392067,
                                            ["ETA_locked"] = false,
                                            ["y"] = -194012.49363249,
                                            ["x"] = -164530.66799232,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [13]
                                        [10] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 1584.3268304711,
                                            ["ETA_locked"] = false,
                                            ["y"] = -119950.80090048,
                                            ["x"] = -84794.554397729,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [14]
                                        [11] = 
                                        {
                                            ["alt"] = 304.8,
                                            ["action"] = "Turning Point",
                                            ["alt_type"] = "RADIO",
                                            ["speed"] = 282.63888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Turning Point",
                                            ["ETA"] = 1853.1524014248,
                                            ["ETA_locked"] = false,
                                            ["y"] = -58150.975444382,
                                            ["x"] = -40592.437087201,
                                            ["formation_template"] = "",
                                            ["speed_locked"] = true,
                                        }, -- end of [15]
                                        [12] = 
                                        {
                                            ["alt"] = 22,
                                            ["action"] = "Landing",
                                            ["alt_type"] = "BARO",
                                            ["speed"] = 138.88888888889,
                                            ["task"] = 
                                            {
                                                ["id"] = "ComboTask",
                                                ["params"] = 
                                                {
                                                    ["tasks"] = 
                                                    {
                                                    }, -- end of ["tasks"]
                                                }, -- end of ["params"]
                                            }, -- end of ["task"]
                                            ["type"] = "Land",
                                            ["ETA"] = 1975.2373632155,
                                            ["ETA_locked"] = false,
                                            ["y"] = -30795.647521,
                                            ["x"] = -61624.488064,
                                            ["formation_template"] = "",
                                            ["airdromeId"] = 28,
                                            ["speed_locked"] = true,
                                        }, -- end of [16]
                                    }, -- end of ["points"]
                                }, -- end of ["route"]
                                ["groupId"] = 2,
                                ["hidden"] = false,
                                ["units"] = 
                                {
                                    [1] = 
                                    {
                                        ["alt"] = 22,
                                        ["hardpoint_racks"] = true,
                                        ["alt_type"] = "BARO",
                                        ["skill"] = "High",
                                        ["parking"] = "11",
                                        ["speed"] = 138.88888888889,
                                        ["AddPropAircraft"] = 
                                        {
                                            ["ReadyALCM"] = true,
                                            ["LaserCode100"] = 6,
                                            ["ForceINSRules"] = false,
                                            ["EnableTAF"] = true,
                                            ["InitHotDrift"] = 0,
                                            ["DisableVTBExport"] = false,
                                            ["NoDDMSensor"] = true,
                                            ["LaserCode1"] = 8,
                                            ["WpBullseye"] = 0,
                                            ["LoadNVGCase"] = false,
                                            ["RocketBurst"] = 6,
                                            ["LaserCode10"] = 8,
                                            ["GunBurst"] = 1,
                                        }, -- end of ["AddPropAircraft"]
                                        ["type"] = "M-2000C",
                                        ["unitId"] = 5,
                                        ["psi"] = 2.1420215535218,
                                        ["parking_id"] = "04",
                                        ["x"] = -61191.953125,
                                        ["name"] = "Aerial-1-5",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [3]
                                                [4] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [4]
                                                [5] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RPL_522}",
                                                }, -- end of [5]
                                                [6] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [6]
                                                [7] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [7]
                                                [8] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [8]
                                                [9] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [9]
                                                [10] = 
                                                {
                                                    ["CLSID"] = "{Eclair}",
                                                }, -- end of [10]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = 3165,
                                            ["flare"] = 16,
                                            ["ammo_type"] = 1,
                                            ["chaff"] = 112,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -30677.607421875,
                                        ["heading"] = 0,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 1,
                                            ["name"] = "Enfield11",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "014",
                                    }, -- end of [1]
                                    [2] = 
                                    {
                                        ["alt"] = 22,
                                        ["alt_type"] = "BARO",
                                        ["skill"] = "High",
                                        ["parking"] = "10",
                                        ["speed"] = 138.88888888889,
                                        ["AddPropAircraft"] = 
                                        {
                                            ["ReadyALCM"] = true,
                                            ["GunBurst"] = 1,
                                            ["ForceINSRules"] = false,
                                            ["LaserCode100"] = 6,
                                            ["RocketBurst"] = 6,
                                            ["DisableVTBExport"] = false,
                                            ["NoDDMSensor"] = true,
                                            ["LaserCode1"] = 8,
                                            ["WpBullseye"] = 0,
                                            ["InitHotDrift"] = 0,
                                            ["LoadNVGCase"] = false,
                                            ["LaserCode10"] = 8,
                                            ["EnableTAF"] = true,
                                        }, -- end of ["AddPropAircraft"]
                                        ["type"] = "M-2000C",
                                        ["unitId"] = 6,
                                        ["psi"] = 2.1420215535218,
                                        ["parking_id"] = "03",
                                        ["x"] = -61138.0625,
                                        ["name"] = "Aerial-1-6",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [3]
                                                [4] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [4]
                                                [5] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RPL_522}",
                                                }, -- end of [5]
                                                [6] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [6]
                                                [7] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [7]
                                                [8] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [8]
                                                [9] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [9]
                                                [10] = 
                                                {
                                                    ["CLSID"] = "{Eclair}",
                                                }, -- end of [10]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = 3165,
                                            ["flare"] = 16,
                                            ["ammo_type"] = 1,
                                            ["chaff"] = 112,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -30692.197265625,
                                        ["heading"] = 0,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 2,
                                            ["name"] = "Enfield12",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "015",
                                    }, -- end of [2]
                                    [3] = 
                                    {
                                        ["alt"] = 22,
                                        ["alt_type"] = "BARO",
                                        ["skill"] = "High",
                                        ["parking"] = "9",
                                        ["speed"] = 138.88888888889,
                                        ["AddPropAircraft"] = 
                                        {
                                            ["ReadyALCM"] = true,
                                            ["EnableTAF"] = true,
                                            ["ForceINSRules"] = false,
                                            ["LaserCode100"] = 6,
                                            ["LoadNVGCase"] = false,
                                            ["DisableVTBExport"] = false,
                                            ["NoDDMSensor"] = true,
                                            ["LaserCode1"] = 8,
                                            ["RocketBurst"] = 6,
                                            ["InitHotDrift"] = 0,
                                            ["WpBullseye"] = 0,
                                            ["LaserCode10"] = 8,
                                            ["GunBurst"] = 1,
                                        }, -- end of ["AddPropAircraft"]
                                        ["type"] = "M-2000C",
                                        ["unitId"] = 7,
                                        ["psi"] = 2.1420215535218,
                                        ["parking_id"] = "02",
                                        ["x"] = -61086.82421875,
                                        ["name"] = "Aerial-1-7",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [3]
                                                [4] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [4]
                                                [5] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RPL_522}",
                                                }, -- end of [5]
                                                [6] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [6]
                                                [7] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [7]
                                                [8] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [8]
                                                [9] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [9]
                                                [10] = 
                                                {
                                                    ["CLSID"] = "{Eclair}",
                                                }, -- end of [10]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = 3165,
                                            ["flare"] = 16,
                                            ["ammo_type"] = 1,
                                            ["chaff"] = 112,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -30704.681640625,
                                        ["heading"] = 0,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 3,
                                            ["name"] = "Enfield13",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "016",
                                    }, -- end of [3]
                                    [4] = 
                                    {
                                        ["alt"] = 22,
                                        ["alt_type"] = "BARO",
                                        ["skill"] = "High",
                                        ["parking"] = "7",
                                        ["speed"] = 138.88888888889,
                                        ["AddPropAircraft"] = 
                                        {
                                            ["ReadyALCM"] = true,
                                            ["GunBurst"] = 1,
                                            ["ForceINSRules"] = false,
                                            ["LaserCode100"] = 6,
                                            ["WpBullseye"] = 0,
                                            ["DisableVTBExport"] = false,
                                            ["NoDDMSensor"] = true,
                                            ["LaserCode1"] = 8,
                                            ["RocketBurst"] = 6,
                                            ["LoadNVGCase"] = false,
                                            ["InitHotDrift"] = 0,
                                            ["LaserCode10"] = 8,
                                            ["EnableTAF"] = true,
                                        }, -- end of ["AddPropAircraft"]
                                        ["type"] = "M-2000C",
                                        ["unitId"] = 8,
                                        ["psi"] = 2.1420215535218,
                                        ["parking_id"] = "10",
                                        ["x"] = -61152.8046875,
                                        ["name"] = "Aerial-1-8",
                                        ["payload"] = 
                                        {
                                            ["pylons"] = 
                                            {
                                                [1] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [1]
                                                [2] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [2]
                                                [3] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [3]
                                                [4] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [4]
                                                [5] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RPL_522}",
                                                }, -- end of [5]
                                                [6] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [6]
                                                [7] = 
                                                {
                                                    ["CLSID"] = "{BLG66_BELOUGA_AC}",
                                                }, -- end of [7]
                                                [8] = 
                                                {
                                                    ["CLSID"] = "{M2KC_RAFAUT_BLG66}",
                                                }, -- end of [8]
                                                [9] = 
                                                {
                                                    ["CLSID"] = "{MMagicII}",
                                                }, -- end of [9]
                                                [10] = 
                                                {
                                                    ["CLSID"] = "{Eclair}",
                                                }, -- end of [10]
                                            }, -- end of ["pylons"]
                                            ["fuel"] = 3165,
                                            ["flare"] = 16,
                                            ["ammo_type"] = 1,
                                            ["chaff"] = 112,
                                            ["gun"] = 100,
                                        }, -- end of ["payload"]
                                        ["y"] = -30566.630859375,
                                        ["heading"] = 0,
                                        ["callsign"] = 
                                        {
                                            [1] = 1,
                                            [2] = 1,
                                            [3] = 4,
                                            ["name"] = "Enfield14",
                                        }, -- end of ["callsign"]
                                        ["onboard_num"] = "017",
                                    }, -- end of [4]
                                }, -- end of ["units"]
                                ["y"] = -30677.607421875,
                                ["x"] = -61191.953125,
                                ["name"] = "Aerial-1",
                                ["communication"] = true,
                                ["start_time"] = 0,
                                ["frequency"] = 251,




}
	--dbcas:Spawn()
	--dbcap1:Spawn()
	--dbcap2:Spawn()
	--t1 = GROUP:FindByName("bimb11"):Destroy()
	--coalition.addGroup(country.id.USA,Group.Category.AIRPLANE,bombergroup)
	-- coalition.addGroup(country.id.IRAN,Group.Category.AIRPLANE,miragegroup)
	      mainmission.carrier5dead = false
      MESSAGE:New("Command reports a repaired Teddy has returned to the AO",15):ToBlue()
      hm("** US COALITION COMMAND REPORTS A REPAIRED TEDDY HAS RETURNED TO THE AO**")
      cg5:OnReSpawn(function(group) 
        if abossactive  == true then
          AirbossTeddy:Start()
        end
        ShellTeddy:Start()
        if useawacs == true then
          awacsTeddy:Start()
        end
		g5life = cg5:GetLife()
      end)
		cg5:Respawn()
		if carrier5arty ~= nil then
			carrier5arty:Stop()
		end
		carrier5arty=ARTY:New(GROUP:FindByName("Carrier Group 5","CG5"))
		carrier5arty:SetShellTypes({"MK45_127"})
		carrier5arty:SetMissileTypes({"BGM"})
		carrier5arty:SetMarkAssignmentsOn()
		carrier5arty:SetSmokeShells(20,SMOKECOLOR.Blue)
		carrier5arty:SetSmokeShells(20,SMOKECOLOR.Red)
		carrier5arty:SetSmokeShells(20,SMOKECOLOR.Orange)
		carrier5arty:SetSmokeShells(20,SMOKECOLOR.White)
		carrier5arty:SetIlluminationShells(20,1)
		carrier5arty:Start()
		tdyslot()
		tar_slot()
	--slot_khasab(1)
	--MESSAGE:New("Warning, ELINT has reports of M2000's launching strike from Ras Al Khaimah, Decrypted Target is either Abu Dhabi, Al-Dhafra or Liwa.",30,"Intel"):ToBlue()
	--[[local keys = {}
	for k, v in pairs(coroutine) do
		keys[#keys+1] = k
		BASE:E(k)
	end
	]]
	--[[
		local Players = net.get_player_list()
        for PlayerIDIndex, playerID in pairs( Players ) do
			BASE:E({playerID})
			 local _playerDetails = net.get_player_info( playerID )
			BASE:E({_playerDetails})
			
		end
		net.force_player_slot(2, 0, '')
		]]
end


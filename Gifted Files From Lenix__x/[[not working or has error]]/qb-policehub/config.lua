Config = {
    Core = 'qb-core',
    LoadedEvent = 'QBCore:Client:OnPlayerLoaded',
    UnLoadedEvent = 'QBCore:Client:OnPlayerUnload',
    JobUpdateEvent = 'QBCore:Client:OnJobUpdate',
    NotifyEvent = 'QBCore:Notify',
    SetDutyEvent = 'QBCore:Client:SetDuty',
    VoiceScript = "qb-voice",
    MenuText = 'Police Hub'
}

-- Groups : station, bank, store, speedcam, gunstores, others
-- Colors : green, blue, red, pink, purple, fst8, gray, black, aqua, orange, yellow
Config.SecurityCameras = {                                            -- All Cams
    [1] = {                                                           -- Area 1
        name = 'Pacific Bank',                                        -- Area Name
        color = 'fst8',                                               -- Area Color
        tab = 'bank',                                                 -- Area Group
        x = 244.94984436035,
        y = 226.16044616699,
        z = 109.7971572876,                                           -- Area Coords
        cams = {                                                      -- Area Cams
            [1] = { label = "#1", x = 244.94984436035, y = 226.16044616699, z = 109.7971572876, r = { x = -25.0, y = 0.0, z = 256.05 }, canRotate = true, isOnline = true },
            [2] = { label = "#2", x = 232.86, y = 221.46, z = 107.83, r = { x = -25.0, y = 0.0, z = -140.91 }, canRotate = true, isOnline = true },
            [3] = { label = "#3", x = 253.98440551758, y = 222.27117919922, z = 98.158882141113, r = { x = -21.0, y = 0.0, z = 251.87 }, canRotate = true, isOnline = true },
            [4] = { label = "#4", x = 253.98440551758, y = 222.27117919922, z = 98.158882141113, r = { x = -21.0, y = 0.0, z = 66.87 }, canRotate = true, isOnline = true },
            [5] = { label = "#5", x = 227.95289611816, y = 236.08137512207, z = 98.7, r = { x = -35.0, y = 0.0, z = 208.99 }, canRotate = true, isOnline = true },
        }
    },
    [2] = {
        name = 'Paleto Bank',
        color = 'fst8',
        tab = 'bank',
        x = -102.37850189209,
        y = 6475.5400390625,
        z = 32.739533233643,
        cams = {
            [1] = { label = "#1", x = -102.37850189209, y = 6475.5400390625, z = 32.739533233643, r = { x = -12.0, y = 0.0, z = 171.96 }, canRotate = true, isOnline = true },
            [2] = { label = "#2", x = -100.22701263428, y = 6465.3413085938, z = 33.20520401001, r = { x = -23.0, y = 0.0, z = 89.46 }, canRotate = true, isOnline = true },
            [3] = { label = "#3", x = -95.36735534668, y = 6461.1240234375, z = 32.825965881348, r = { x = -23.0, y = 0.0, z = 86.46 }, canRotate = true, isOnline = true },
        }
    },
    [3] = {
        name = 'Union Bank',
        color = 'fst8',
        tab = 'bank',
        x = -11.390551567078,
        y = -697.37561035156,
        z = 17.531019592285,
        cams = {
            [1] = { label = "#1", x = -11.390551567078, y = -697.37561035156, z = 17.531019592285, r = { x = -12.0, y = 0.0, z = 320.1220703125 }, canRotate = true, isOnline = true },
            [2] = { label = "#2", x = -1.5615615844727, y = -681.14703369141, z = 17.531019592285, r = { x = -23.0, y = 0.0, z = 333.25225830078 }, canRotate = true, isOnline = true },
            [3] = { label = "#3", x = 10.284967422485, y = -672.3681640625, z = 17.531019592285, r = { x = -23.0, y = 0.0, z = 33.473114013672 }, canRotate = true, isOnline = true },
        }
    },
    [4] = {
        name = 'Fleeca Bank Hawick Ave Alta',
        color = 'fst8',
        tab = 'bank',
        x = 309.341,
        y = -281.439,
        z = 55.88,
        cams = {
            [1] = { label = "#1", x = 310.80212402344, y = -276.46032714844, z = 56.164569854736, h = 167.72125244141, r = { x = -35.0, y = 0.0, z = 167.72125244141 }, canRotate = true, isOnline = true },
            [2] = { label = "#2", x = 309.341, y = -281.439, z = 55.88, r = { x = -35.0, y = 0.0, z = -146.1595 }, canRotate = true, isOnline = true },
            [3] = { label = "#3", x = 314.20114135742, y = -289.39883422852, z = 56.143100738525, h = 27.567405700684, r = { x = -35.0, y = 0.0, z = 23.531772613525 }, canRotate = true, isOnline = true },
        }
    },
    [5] = {
        name = 'Fleeca Bank Legion Square',
        color = 'fst8',
        tab = 'bank',
        x = 144.871,
        y = -1043.044,
        z = 31.017,
        cams = {
            [1] = { label = "#1", x = 146.45213317871, y = -1038.0847167969, z = 31.367851257324, h = 243.78932189941, r = { x = -35.0, y = 0.0, z = 243.78932189941 }, canRotate = false, isOnline = true },
            [2] = { label = "#2", x = 144.871, y = -1043.044, z = 31.017, r = { x = -35.0, y = 0.0, z = -143.9796 }, canRotate = false, isOnline = true },
            [3] = { label = "#3", x = 149.93869018555, y = -1050.9384765625, z = 31.34641456604, h = 13.458920478821, r = { x = -35.0, y = 0.0, z = 13.458920478821 }, canRotate = false, isOnline = true },
        }
    },
    [6] = {
        name = 'Fleeca Bank Hawick Ave',
        color = 'fst8',
        tab = 'bank',
        x = -355.7643,
        y = -52.506,
        z = 50.746,
        cams = {
            [1] = { label = "Fleeca Bank Hawick Ave CAM#1", x = -354.23150634766, y = -47.431282043457, z = 51.036392211914, h = 247.07577514648, r = { x = -35.0, y = 0.0, z = 247.07577514648 }, canRotate = true, isOnline = true },
            [2] = { label = "Fleeca Bank Hawick Ave CAM#2", x = -355.7643, y = -52.506, z = 50.746, r = { x = -35.0, y = 0.0, z = -143.8711 }, canRotate = true, isOnline = true },
            [3] = { label = "Fleeca Bank Hawick Ave CAM#3", x = -350.75564575195, y = -60.264350891113, z = 51.014888763428, h = 22.655572891235, r = { x = -35.0, y = 0.0, z = 22.655572891235 }, canRotate = true, isOnline = true },
        }
    },
    [7] = {
        name = 'Fleeca Bank Del Perro Blvd',
        color = 'fst8',
        tab = 'bank',
        x = -1214.226,
        y = -335.86,
        z = 39.515,
        cams = {
            [1] = { label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1216.8426513672, y = -331.37319946289, z = 39.780799865723, h = 280.29766845703, r = { x = -35.0, y = 0.0, z = 280.862 }, canRotate = false, isOnline = true },
            [2] = { label = "Fleeca Bank Del Perro Blvd CAM#2", x = -1214.226, y = -335.86, z = 39.515, r = { x = -35.0, y = 0.0, z = -97.862 }, canRotate = false, isOnline = true },
            [3] = { label = "Fleeca Bank Del Perro Blvd CAM#3", x = -1205.1798095703, y = -337.59368896484, z = 39.759349822998, r = { x = -35.0, y = 0.0, z = 80.602485656738 }, canRotate = false, isOnline = true },
        }
    },
    [8] = {
        name = 'Fleeca Bank Sandy Shores',
        color = 'fst8',
        tab = 'bank',
        x = 1178.7927246094,
        y = 2705.2976074219,
        z = 39.687863922119,
        cams = {
            [1] = { label = "Fleeca Bank Sandy Shores CAM#1", x = 1178.7927246094, y = 2705.2976074219, z = 39.687863922119, h = 310.77102661133, r = { x = -35.0, y = 0.0, z = 310.77102661133 }, canRotate = true, isOnline = true },
            [2] = { label = "Fleeca Bank Sandy Shores CAM#2", x = 1179.0222167969, y = 2705.5690917969, z = 39.460445404053, h = 317.41009521484, r = { x = -35.0, y = 0.0, z = 63.042507 }, canRotate = true, isOnline = true },
            [3] = { label = "Fleeca Bank Sandy Shores CAM#3", x = 1171.5260009766, y = 2716.5458984375, z = 40.066356658936, h = 225.66435241699, r = { x = -35.0, y = 0.0, z = 225.66435241699 }, canRotate = true, isOnline = true },
        }
    },
    [9] = {
        name = 'Vangelico Juwelier',
        color = 'orange',
        tab = 'store',
        x = -627.54,
        y = -239.74,
        z = 40.33,
        cams = {
            [1] = { label = "Vangelico Juwelier CAM#1", x = -627.54, y = -239.74, z = 40.33, r = { x = -35.0, y = 0.0, z = 5.78 }, canRotate = true, isOnline = true },
            [2] = { label = "Vangelico Juwelier CAM#2", x = -627.51, y = -229.51, z = 40.24, r = { x = -35.0, y = 0.0, z = -95.78 }, canRotate = true, isOnline = true },
            [3] = { label = "Vangelico Juwelier CAM#3", x = -620.3, y = -224.31, z = 40.23, r = { x = -35.0, y = 0.0, z = 165.78 }, canRotate = true, isOnline = true },
            [4] = { label = "Vangelico Juwelier CAM#4", x = -622.57, y = -236.3, z = 40.31, r = { x = -35.0, y = 0.0, z = 5.78 }, canRotate = true, isOnline = true },
        }
    },
    [10] = {
        name = 'Prison',
        tab = 'station',
        color = 'blue',
        x = 1744.2685546875,
        y = 2476.5234375,
        z = 47.240707397461,
        cams = {
            [1] = { label = "Prison Gym #1", x = 1744.2685546875, y = 2476.5234375, z = 47.240707397461, h = 343.95736694336, r = { x = -35.0, y = 0.0, z = 343.95736694336 }, canRotate = true, isOnline = true },
            [2] = { label = "Prison Lobby #2", x = 1752.3193359375, y = 2480.9240722656, z = 50.690326690674, h = 301.9782409668, r = { x = -20.0, y = 0.0, z = 299.77526855469, }, canRotate = true, isOnline = true },
            [3] = { label = "Prison Canten #3", x = 1790.384765625, y = 2546.248046875, z = 47.2731300354, h = 43.510237884521, r = { x = -35.0, y = 0.0, z = 42.310237884521 }, canRotate = true, isOnline = true },
            [4] = { label = "Prison OutSide #4", x = 1693.6055908203, y = 2531.8210449219, z = 72.534622192383, r = { x = -35.0, y = 0.0, z = 285.88247680664 }, canRotate = true, isOnline = true },
        }
    },
    [11] = {
        name = 'Mission Row PD',
        color = 'blue',
        tab = 'station',
        x = 442.54470825195,
        y = -978.57037353516,
        z = 32.589575195313,
        cams = {
            [1] = { label = "CAM #4", x = 464.62280273438, y = -972.78082275391, z = 27.973628234863, h = 203.2389831543, r = { x = -35.0, y = 0.0, z = 203.165348052979 }, canRotate = true, isOnline = true },
            [2] = { label = "CAM #5", x = 477.0520324707, y = -1004.823059082, z = 27.973628234863, h = 228.36015319824, r = { x = -35.0, y = 0.0, z = 228.165348052979 }, canRotate = true, isOnline = true },
            [3] = { label = "CAM #6", x = 480.78262329102, y = -990.95867919922, z = 27.973628234863, h = 355.60675048828, r = { x = -35.0, y = 0.0, z = 355.60675048828 }, canRotate = true, isOnline = true },
            [4] = { label = "CAM #7", x = 472.55490112305, y = -988.45660400391, z = 27.973628234863, h = 299.16091918945, r = { x = -35.0, y = 0.0, z = 299.60675048828 }, canRotate = true, isOnline = true },
            [5] = { label = "CAM #8", x = 426.55810546875, y = -974.56378173828, z = 27.973628234863, h = 104.82962799072, r = { x = -35.0, y = 0.0, z = 242.98411560059 }, canRotate = true, isOnline = true },
            [6] = { label = "CAM #1", x = 442.54470825195, y = -978.57037353516, z = 32.589575195313, h = 124.53234863281, r = { x = -35.0, y = 0.0, z = 124.53234863281 }, canRotate = true, isOnline = true },
            [7] = { label = "CAM #2", x = 444.6149597168, y = -997.79132080078, z = 32.589575195313, h = 47.165348052979, r = { x = -35.0, y = 0.0, z = 47.165348052979 }, canRotate = true, isOnline = true },
            [8] = { label = "CAM #3", x = 468.2350769043, y = -990.37347412109, z = 32.589575195313, h = 39.098503112793, r = { x = -35.0, y = 0.0, z = 47.165348052979 }, canRotate = true, isOnline = true },
            [9] = { label = "CAM #9", x = 449.0993347168, y = -996.26397705078, z = 36.47017288208, h = 120.04168701172, r = { x = -35.0, y = 0.0, z = 119.04168701172 }, canRotate = true, isOnline = true },
            [10] = { label = "CAM #10", x = 459.2434387207, y = -977.52368164063, z = 36.47017288208, h = 98.517997741699, r = { x = -35.0, y = 0.0, z = 98.517997741699 }, canRotate = true, isOnline = true },
        }
    },
    [12] = {
        name = 'Paleto Bay PD',
        color = 'blue',
        tab = 'station',
        x = -450.11785888672,
        y = 6000.6313476563,
        z = 29.581520080566,
        cams = {
            [1] = { label = "CAM #1", x = -450.11785888672, y = 6000.6313476563, z = 29.581520080566, h = 321.03314208984, r = { x = -35.0, y = 0.0, z = 321.53234863281 }, canRotate = true, isOnline = true },
            [2] = { label = "CAM #2", x = -448.01162719727, y = 6017.30859375, z = 29.259857177734, h = 226.21685791016, r = { x = -35.0, y = 0.0, z = 226.53234863281 }, canRotate = true, isOnline = true },
            [3] = { label = "CAM #3", x = -441.84631347656, y = 5994.826171875, z = 29.581520080566, h = 43.176891326904, r = { x = -35.0, y = 0.0, z = 43.53234863281 }, canRotate = true, isOnline = true },
            [4] = { label = "CAM #4", x = -437.04055786133, y = 6011.9853515625, z = 34.688715362549, h = 96.069107055664, r = { x = -35.0, y = 0.0, z = 96.069107055664 }, canRotate = true, isOnline = true },
            [5] = { label = "CAM #5", x = -443.09936523438, y = 6009.5249023438, z = 39.995632171631, h = 110.00628662109, r = { x = -35.0, y = 0.0, z = 110.00628662109 }, canRotate = true, isOnline = true },
            [6] = { label = "CAM #6", x = -449.99356079102, y = 5984.1860351563, z = 33.65896987915, h = 50.356781005859, r = { x = -35.0, y = 0.0, z = 50.00628662109 }, canRotate = true, isOnline = true },

        }
    },
    [13] = {
        name = 'Sandy Shores PD',
        color = 'blue',
        tab = 'station',
        x = 1829.3880615234,
        y = 3675.365234375,
        z = 36.169845581055,
        cams = {
            [1] = { label = "CAM #1", x = 1829.3880615234, y = 3675.365234375, z = 36.169845581055, h = 266.52444458008, r = { x = -35.0, y = 0.0, z = 266.53234863281 }, canRotate = true, isOnline = true },
            [2] = { label = "CAM #2", x = 1820.7365722656, y = 3669.3205566406, z = 36.169845581055, h = 266.52444458008, r = { x = -35.0, y = 0.0, z = 266.53234863281 }, canRotate = true, isOnline = true },
            [3] = { label = "CAM #3", x = 1809.6014404297, y = 3682.9267578125, z = 36.169845581055, h = 186.52444458008, r = { x = -35.0, y = 0.0, z = 186.53234863281 }, canRotate = true, isOnline = true },
            [4] = { label = "CAM #4", x = 1828.3745117188, y = 3677.5544433594, z = 40.25945892334, h = 210.91963195801, r = { x = -35.0, y = 0.0, z = 210.53234863281 }, canRotate = true, isOnline = true },
            [5] = { label = "CAM #5", x = 1810.5485839844, y = 3683.6982421875, z = 35.786472320557, h = 282.82113647461, r = { x = -35.0, y = 0.0, z = 282.53234863281 }, canRotate = true, isOnline = true },
        }
    },
    [14] = {
        name = "Limited Ltd Grove St",
        color = 'green',
        tab = 'store',
        x = -53.1433,
        y = -1746.714,
        z = 31.546,
        cams = {
            [1] = { label = "Limited Ltd Grove St. CAM#1", x = -53.1433, y = -1746.714, z = 31.546, r = { x = -35.0, y = 0.0, z = -168.9182 }, canRotate = false, isOnline = true },
            [2] = { label = "Limited Ltd Grove St. CAM#1", x = -41.446784973145, y = -1749.1292724609, z = 31.421022415161, h = 94.656242370605, r = { x = -35.0, y = 0.0, z = 94.656242370605 }, canRotate = false, isOnline = true },
        }
    },
    [15] = {
        name = 'Robs Liqour Prosperity St',
        color = 'green',
        tab = 'store',
        x = -1482.9,
        y = -380.463,
        z = 42.363,
        cams = {
            [1] = { label = "Rob's Liqour Prosperity St. CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = { x = -35.0, y = 0.0, z = 79.53281 }, canRotate = false, isOnline = true },
            [2] = { label = "Rob's Liqour Prosperity St. CAM#1", x = -1476.8312988281, y = -374.4755859375, z = 41.159664154053, h = 75.331657409668, r = { x = -35.0, y = 0.0, z = 75.331657409668 }, canRotate = false, isOnline = true },
        }
    },
    [16] = {
        name = "Rob's Liqour San Andreas Ave",
        tab = 'store',
        color = 'green',
        x = -1224.874,
        y = -911.094,
        z = 14.401,
        cams = {
            [1] = { label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = { x = -35.0, y = 0.0, z = -6.778894 }, canRotate = false, isOnline = true },
            [2] = { label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1220.3305664063, y = -918.22906494141, z = 13.326313018799, h = 351.8073425293, r = { x = -35.0, y = 0.0, z = 351.778894 }, canRotate = false, isOnline = true },
        }
    },
    [17] = {
        name = "Limited Ltd Ginger St",
        color = 'green',
        tab = 'store',
        x = -718.153,
        y = -909.211,
        z = 21.49,
        cams = {
            [1] = { label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = { x = -35.0, y = 0.0, z = -137.1431 }, canRotate = false, isOnline = true },
            [2] = { label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = { x = -35.0, y = 0.0, z = -137.1431 }, canRotate = false, isOnline = true },
        }
    },
    [18] = {
        name = "24/7 Supermarkt Innocence Blvd",
        color = 'green',
        tab = 'store',
        x = 34.15,
        y = -1342.93,
        z = 30.95,
        cams = {
            [1] = { label = "24/7 Supermarkt Innocence Blvd. CAM#1", x = 34.15, y = -1342.93, z = 30.95, r = { x = -35.0, y = 0.0, z = 124.98 }, canRotate = false, isOnline = true },                                                      -- gabz
            [2] = { label = "24/7 Supermarkt Innocence Blvd. CAM#1", x = 23.92366027832, y = -1338.6813964844, z = 31.017629623413, h = 239.44302368164, r = { x = -35.0, y = 0.0, z = 239.44302368164 }, canRotate = false, isOnline = true }, -- gabz
        }
    },
    [19] = {
        name = "Rob's Liqour El Rancho Blvd",
        color = 'green',
        tab = 'store',
        x = 1133.024,
        y = -978.712,
        z = 48.515,
        cams = {
            [1] = { label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = { x = -35.0, y = 0.0, z = -137.302 }, canRotate = false, isOnline = true },
            [2] = { label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1124.5546875, y = -979.63879394531, z = 47.415744781494, r = { x = -35.0, y = 0.0, z = 250.88375854492 }, canRotate = true, isOnline = true },
        }
    },
    [20] = {
        name = "Limited Ltd West Mirror Drive",
        color = 'green',
        tab = 'store',
        x = 1151.93,
        y = -320.389,
        z = 71.33,
        cams = {
            [1] = { label = "Limited Ltd West Mirror Drive CAM#1", x = 1151.93, y = -320.389, z = 71.33, r = { x = -35.0, y = 0.0, z = -119.4468 }, canRotate = false, isOnline = true },
            [2] = { label = "Limited Ltd West Mirror Drive CAM#1", x = 1161.6324462891, y = -312.9211730957, z = 71.205169677734, h = 136.39585876465, r = { x = -35.0, y = 0.0, z = 136.39585876465 }, canRotate = true, isOnline = true },
        }
    },
    [21] = {
        name = "24/7 Supermarkt Clinton Ave",
        color = 'green',
        tab = 'store',
        x = 383.57,
        y = 328.44,
        z = 105.09,
        cams = {
            [1] = { label = "24/7 Supermarkt Clinton Ave CAM#1", x = 383.57, y = 328.44, z = 105.09, r = { x = -35.0, y = 0.0, z = 112.585 }, canRotate = false, isOnline = true },                                            -- gabz edited
            [2] = { label = "24/7 Supermarkt Clinton Ave CAM#1", x = 374.11865234375, y = 334.96588134766, z = 105.78701324463, h = 212.99446105957, r = { x = -35.0, y = 0.0, z = 212.585 }, canRotate = true, isOnline = true }, -- gabz edited
        }
    },
    [22] = {
        name = "Limited Ltd Banham Canyon",
        color = 'green',
        tab = 'store',
        x = -1832.057,
        y = 789.389,
        z = 140.4,
        cams = {
            [1] = { label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1832.057, y = 789.389, z = 140.436, r = { x = -35.0, y = 0.0, z = -91.481 }, canRotate = false, isOnline = true },
            [2] = { label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1827.9653320313, y = 800.79138183594, z = 140.14976501465, h = 177.78363037109, r = { x = -35.0, y = 0.0, z = 177.481 }, canRotate = true, isOnline = true },
        }
    },
    [23] = {
        name = "Rob's Liqour Great Ocean Hwy",
        color = 'green',
        tab = 'store',
        x = -2966.15,
        y = 387.067,
        z = 17.393,
        cams = {
            [1] = { label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = { x = -35.0, y = 0.0, z = 32.92229 }, canRotate = false, isOnline = true },
            [2] = { label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2957.5268554688, y = 386.28033447266, z = 16.481956481934, r = { x = -35.0, y = 0.0, z = 24.500198364258 }, canRotate = true, isOnline = true },
        }
    },
    [24] = {
        name = "24/7 Supermarkt Ineseno Road",
        color = 'green',
        tab = 'store',
        x = -3045.99,
        y = 592.55,
        z = 9.36,
        cams = {
            [1] = { label = "24/7 Supermarkt Ineseno Road CAM#1", x = -3045.99, y = 592.55, z = 9.36, r = { x = -35.0, y = 0.0, z = 230.81 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Ineseno Road CAM#1", x = -3047.2260742188, y = 581.51965332031, z = 9.9295206069946, r = { x = -35.0, y = 0.0, z = 357.05746459961 }, canRotate = true, isOnline = true },
        }
    },
    [25] = {
        name = "24/7 Supermarkt Route 68",
        color = 'green',
        tab = 'store',
        x = 539.79,
        y = 2665.64,
        z = 43.86,
        cams = {
            [1] = { label = "24/7 Supermarkt Route 68 CAM#1", x = 539.79, y = 2665.64, z = 43.86, r = { x = -35.0, y = 0.0, z = 316.02 }, canRotate = false, isOnline = true },                                        -- edited gabz
            [2] = { label = "24/7 Supermarkt Route 68 CAM#1", x = 550.56011962891, y = 2662.6740722656, z = 43.977124023438, h = 78.212890625, r = { x = -35.0, y = 0.0, z = 78.02 }, canRotate = true, isOnline = true }, -- edited gabz
        }
    },
    [26] = {
        name = "Rob's Liqour Route 68",
        color = 'green',
        tab = 'store',
        x = 1169.855,
        y = 2711.493,
        z = 40.432,
        cams = {
            [1] = { label = "Rob's Liqour Route 68 CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = { x = -35.0, y = 0.0, z = 127.17 }, canRotate = false, isOnline = true },
            [2] = { label = "Rob's Liqour Route 68 CAM#1", x = 1170.095703125, y = 2720.0402832031, z = 39.157615661621, h = 121.80170440674, r = { x = -35.0, y = 0.0, z = 121.80170440674 }, canRotate = true, isOnline = true },
        }
    },
    [27] = {
        name = "24/7 Supermarkt Senora Fwy",
        color = 'green',
        tab = 'store',
        x = 2673.579,
        y = 3281.265,
        z = 57.541,
        cams = {
            [1] = { label = "24/7 Supermarkt Senora Fwy CAM#1", x = 2673.579, y = 3281.265, z = 57.541, r = { x = -35.0, y = 0.0, z = -80.242 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Senora Fwy CAM#1", x = 2670.1989746094, y = 3283.4367675781, z = 57.761768341064, h = 309.30847167969, r = { x = -35.0, y = 0.0, z = 309.242 }, canRotate = true, isOnline = true },
        }
    },
    [28] = {
        name = "24/7 Supermarkt Alhambra Dr",
        color = 'green',
        tab = 'store',
        x = 1966.36,
        y = 3748.32,
        z = 33.87055,
        cams = {
            [1] = { label = "24/7 Supermarkt Alhambra Dr. CAM#1", x = 1966.36, y = 3748.32, z = 33.87, r = { x = -35.0, y = 0.0, z = 155.69 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Alhambra Dr. CAM#1", x = 1955.3015136719, y = 3747.2468261719, z = 34.264379882813, h = 259.25018310547, r = { x = -35.0, y = 0.0, z = 259.69 }, canRotate = true, isOnline = true },
        }
    },
    [29] = {
        name = "24/7 Supermarkt Senora 2 Fwy",
        color = 'green',
        tab = 'store',
        x = 1729.522,
        y = 6419.87,
        z = 37.262,
        cams = {
            [1] = { label = "24/7 Supermarkt Senora 2 Fwy CAM#1", x = 1729.522, y = 6419.87, z = 37.262, r = { x = -35.0, y = 0.0, z = -160.089 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Senora 2 Fwy CAM#1", x = 1731.2846679688, y = 6423.2368164063, z = 36.957857513428, h = 211.62001037598, r = { x = -35.0, y = 0.0, z = 211.089 }, canRotate = true, isOnline = true },
        }
    },
    [30] = {
        name = "Del Vecchio Liquor Paleto Bay",
        color = 'green',
        tab = 'store',
        x = -163.75,
        y = 6323.45,
        z = 33.424,
        cams = {
            [1] = { label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = { x = -35.0, y = 0.0, z = 260.00 }, canRotate = false, isOnline = true },
            [2] = { label = "Del Vecchio Liquor Paleto Bay", x = -170.55867004395, y = 6317.76953125, z = 32.586853027344, h = 279.41314697266, r = { x = -35.0, y = 0.0, z = 279.41314697266 }, canRotate = true, isOnline = true },
        }
    },
    [31] = {
        name = "Don's Country Store Paleto Bay",
        color = 'green',
        tab = 'store',
        x = 166.42,
        y = 6634.4,
        z = 33.69,
        cams = {
            [1] = { label = "Don's Country Store Paleto Bay CAM#1", x = 166.42, y = 6634.4, z = 33.69, r = { x = -35.0, y = 0.0, z = 32.00 }, canRotate = false, isOnline = true },
            [2] = { label = "Don's Country Store Paleto Bay CAM#1", x = 166.53121948242, y = 6648.1225585938, z = 33.819535827637, h = 204.96231079102, r = { x = -35.0, y = 0.0, z = 204.00 }, canRotate = true, isOnline = true },
        }
    },
    [32] = {
        name = "Sandy Shores Store",
        color = 'green',
        tab = 'store',
        x = 1400.52,
        y = 3602.69,
        z = 36.65,
        cams = {
            [1] = { label = "Sandy Shores Store CAM#1", x = 1400.52, y = 3602.69, z = 36.65, r = { x = -35.0, y = 0.0, z = 62.51 }, canRotate = false, isOnline = true },
            [2] = { label = "Sandy Shores Store CAM#1", x = 1387.3292236328, y = 3607.9143066406, z = 36.980880737305, h = 269.73596191406, r = { x = -35.0, y = 0.0, z = 269.51 }, canRotate = true, isOnline = true },
        }
    },
    [33] = {
        name = "Banham Store",
        color = 'green',
        tab = 'store',
        x = -1827.46,
        y = 784.3,
        z = 139.51,
        cams = {
            [1] = { label = "Banham Store CAM#1", x = -1827.46, y = 784.3, z = 139.51, r = { x = -32.0, y = 0.0, z = 346.03 }, canRotate = false, isOnline = true },
            [2] = { label = "Banham Store CAM#1", x = -1827.9342041016, y = 800.78607177734, z = 140.14926147461, h = 171.67419433594, r = { x = -32.0, y = 0.0, z = 171.03 }, canRotate = true, isOnline = true },
        }
    },
    [34] = {
        name = "Grapeseed Store",
        color = 'green',
        tab = 'store',
        x = 1702.92,
        y = 4934.02,
        z = 43.76,
        cams = {
            [1] = { label = "Grapeseed Store CAM#1", x = 1702.92, y = 4934.02, z = 43.76, r = { x = -32.0, y = 0.0, z = 156.23 }, canRotate = false, isOnline = true },
            [2] = { label = "Grapeseed Store CAM#1", x = 1707.1224365234, y = 4918.2421875, z = 44.063694000244, h = 16.66775894165, r = { x = -32.0, y = 0.0, z = 16.23 }, canRotate = true, isOnline = true },
        }
    },
    [35] = {
        name = "PALMINO FWY Store",
        color = 'green',
        tab = 'store',
        x = 2553.48,
        y = 390.59,
        z = 109.85,
        cams = {
            [1] = { label = "PALMINO FWY Store CAM#1", x = 2553.48, y = 390.59, z = 109.85, r = { x = -32.0, y = 0.0, z = 206.95 }, canRotate = false, isOnline = true },
            [2] = { label = "PALMINO FWY Store CAM#1", x = 2548.5261230469, y = 380.623046875, z = 110.714361572266, h = 328.69888305664, r = { x = -32.0, y = 0.0, z = 328.95 }, canRotate = false, isOnline = true },
        }
    },
    [36] = {
        name = "24/7 Supermarkt Hightway",
        color = 'green',
        tab = 'store',
        x = -2971.71875,
        y = 393.72540283203,
        z = 16.543,
        cams = {
            [1] = { label = "24/7 Supermarkt Hightway", x = -2971.71875, y = 393.72540283203, z = 16.543, r = { x = -35.0, y = 0.0, z = 229.65284729004 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Hightway", x = -2957.4790039063, y = 386.31958007813, z = 16.043277740479, h = 37.548069000244, r = { x = -35.0, y = 0.0, z = 37.65284729004 }, canRotate = false, isOnline = true },
        }
    },
    [37] = {
        name = "24/7 Supermarkt Ottos",
        color = 'green',
        tab = 'store',
        x = 821.549,
        y = -778.516,
        z = 28.174,
        cams = {
            [1] = { label = "24/7 Supermarkt Ottos", x = 821.549, y = -778.516, z = 28.174, r = { x = -35.0, y = 0.0, z = 133.29306030273 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Ottos", x = 811.88104248047, y = -773.90637207031, z = 27.995631027222, h = 234.80549621582, r = { x = -35.0, y = 0.0, z = 234.29306030273 }, canRotate = false, isOnline = true },
        }
    },
    [38] = {
        name = "BurgerShot Resturant",
        color = 'red',
        tab = 'store',
        x = -1180.2362060547,
        y = -890.91149902344,
        z = 16.06103515625,
        cams = {
            [1] = { label = "BurgerShot CAM", x = -1180.2362060547, y = -890.91149902344, z = 16.06103515625, h = 80.91820526123, r = { x = -35.0, y = 0.0, z = 80.9182 }, canRotate = true, isOnline = true },
            [2] = { label = "BurgerShot CAM", x = -1195.9211425781, y = -889.85583496094, z = 16.06103515625, h = 154.36628723145, r = { x = -35.0, y = 0.0, z = 154.656242370605 }, canRotate = true, isOnline = true },
            [3] = { label = "BurgerShot CAM", x = -1191.5841064453, y = -901.49450683594, z = 15.56103515625, h = 305.05181884766, r = { x = -35.0, y = 0.0, z = 305.656242370605 }, canRotate = true, isOnline = true },
            [4] = { label = "BurgerShot CAM", x = -1181.9128417969, y = -882.95886230469, z = 16.659797668457, h = 290.33737182617, r = { x = -35.0, y = 0.0, z = 290.656242370605 }, canRotate = true, isOnline = true },
            [5] = { label = "BurgerShot CAM", x = -1197.9548339844, y = -883.97924804688, z = 16.659797668457, h = 37.951404571533, r = { x = -35.0, y = 0.0, z = 37.656242370605 }, canRotate = true, isOnline = true },
        }
    },
    [39] = {
        name = "Cat Cafe",
        color = 'pink',
        tab = 'store',
        x = -580.99969482422,
        y = -1070.4764404297,
        z = 23.907409667969,
        cams = {
            [1] = { label = "Cat Cafe CAM", x = -580.99969482422, y = -1070.4764404297, z = 25.907409667969, h = 179.07127380371, r = { x = -35.0, y = 0.0, z = 179.9182 }, canRotate = true, isOnline = true },
            [2] = { label = "Cat Cafe CAM", x = -586.34722900391, y = -1068.2716064453, z = 24.344202041626, h = 315.51483154297, r = { x = -35.0, y = 0.0, z = 315.51483154297 }, canRotate = true, isOnline = true },
            [3] = { label = "Cat Cafe CAM", x = -571.02978515625, y = -1056.7783203125, z = 24.344202041626, h = 69.015098571777, r = { x = -35.0, y = 0.0, z = 69.656242370605 }, canRotate = true, isOnline = true },
            [4] = { label = "Cat Cafe CAM", x = -590.69421386719, y = -1054.8654785156, z = 24.344202041626, h = 202.25968933105, r = { x = -35.0, y = 0.0, z = 202.656242370605 }, canRotate = true, isOnline = true },
            [5] = { label = "Cat Cafe CAM", x = -592.08276367188, y = -1056.5428466797, z = 24.344171524048, h = 148.32308959961, r = { x = -35.0, y = 0.0, z = 148.656242370605 }, canRotate = true, isOnline = true },
            [6] = { label = "Cat Cafe CAM", x = -569.16363525391, y = -1069.8951416016, z = 29.312259674072, h = 44.367084503174, r = { x = -35.0, y = 0.0, z = 44.656242370605 }, canRotate = true, isOnline = true },
        }
    },
    [40] = {
        name = "Bean Machine Cafe",
        color = 'orange',
        tab = 'store',
        x = 128.93347167969,
        y = -1029.0270996094,
        z = 31.345308303833,
        cams = {
            [1] = { label = "Bean Machine Cafe", x = 128.93347167969, y = -1029.0270996094, z = 31.345308303833, h = 44.80163192749, r = { x = -35.0, y = 0.0, z = 44.9182 }, canRotate = true, isOnline = true },
            [2] = { label = "Bean Machine Cafe", x = 113.9497756958, y = -1038.4058837891, z = 31.09422454834, h = 68.346069335938, r = { x = -35.0, y = 0.0, z = 68.51483154297 }, canRotate = true, isOnline = true },
            [3] = { label = "Bean Machine Cafe", x = 116.54112243652, y = -1036.2310791016, z = 31.277885437012, h = 255.24438476563, r = { x = -35.0, y = 0.0, z = 255.656242370605 }, canRotate = true, isOnline = true },
        }
    },
    [41] = {
        name = "Pops Diner Resturant",
        color = 'aqua',
        tab = 'store',
        x = 1590.4779052734,
        y = 6457.990234375,
        z = 28.014026641846,
        cams = {
            [1] = { label = "Pops Diner ", x = 1585.7795410156, y = 6452.6166992188, z = 27.514026641846, h = 155.24378967285, r = { x = -35.0, y = 0.0, z = 143.9182 }, canRotate = true, isOnline = true },
            [2] = { label = "Pops Diner ", x = 1590.4779052734, y = 6457.990234375, z = 27.514026641846, h = 143.94895935059, r = { x = -35.0, y = 0.0, z = 143.9182 }, canRotate = true, isOnline = true },
        }
    },
    [42] = {
        name = "Davis PD",
        color = 'blue',
        tab = 'station',
        x = 378.03497314453,
        y = -1621.0544433594,
        z = 32.477504730225,
        cams = {
            [1] = { label = "Cam ", x = 378.03497314453, y = -1621.0544433594, z = 32.477504730225, h = 236.45318603516, r = { x = -35.0, y = 0.0, z = 236.9182 }, canRotate = true, isOnline = true },
            [2] = { label = "Cam ", x = 411.81536865234, y = -1620.1248779297, z = 32.091529846191, h = 200.02745056152, r = { x = -35.0, y = 0.0, z = 200.9182 }, canRotate = true, isOnline = true },
            [3] = { label = "Cam ", x = 378.76644897461, y = -1607.240234375, z = 30.197618484497, h = 50.086513519287, r = { x = -35.0, y = 0.0, z = 200.9182 }, canRotate = true, isOnline = true },
            [4] = { label = "Cam ", x = 369.19058227539, y = -1601.3599853516, z = 26.899305343628, h = 272.7038269043, r = { x = -35.0, y = 0.0, z = 200.9182 }, canRotate = true, isOnline = true },
            [5] = { label = "Cam ", x = 359.37637329102, y = -1594.0249023438, z = 28.951709747314, h = 279.26733398438, r = { x = -35.0, y = 0.0, z = 200.9182 }, canRotate = true, isOnline = true },
        }
    },
    [43] = {
        name = "Vespucci Boulevard",
        color = 'orange',
        tab = 'speedcam',
        x = 444.40112304688,
        y = -1052.6123046875,
        z = 40.73543548584,
        cams = {
            [1] = { label = "Cam ", x = 444.40112304688, y = -1052.6123046875, z = 40.73543548584, h = 98.000358581543, r = { x = -35.0, y = 0.0, z = 98.000358581543 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = 473.33636474609, y = -1032.7633056641, z = 43.533210754395, h = 275.80764770508, r = { x = -35.0, y = 0.0, z = 275.80764770508 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = 661.29870605469, y = -1026.4425048828, z = 46.194526672363, h = 95.879318237305, r = { x = -35.0, y = 0.0, z = 95.879318237305 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = 657.96002197266, y = -1009.614074707, z = 46.704978942871, h = 274.14947509766, r = { x = -35.0, y = 0.0, z = 274.14947509766 }, canRotate = false, isOnline = true },
        }
    },
    [44] = {
        name = "Elgin Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = 348.76113891602,
        y = -428.24273681641,
        z = 54.549289703369,
        cams = {
            [1] = { label = "Cam ", x = 348.76113891602, y = -428.24273681641, z = 54.549289703369, h = 130.60638427734, r = { x = -35.0, y = 0.0, z = 130.60638427734 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = 453.32861328125, y = -357.87939453125, z = 56.299606323242, h = 132.48709106445, r = { x = -35.0, y = 0.0, z = 132.48709106445 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = 373.06408691406, y = -391.38726806641, z = 56.258228302002, h = 266.85003662109, r = { x = -35.0, y = 0.0, z = 266.85003662109 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = 441.96353149414, y = -343.8427734375, z = 57.116641998291, h = 323.07095336914, r = { x = -35.0, y = 0.0, z = 323.07095336914 }, canRotate = false, isOnline = true },
        }
    },
    [45] = {
        name = "Hawick Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = -109.99291992188,
        y = -85.59285736084,
        z = 67.585914611816,
        cams = {
            [1] = { label = "Cam ", x = -109.99291992188, y = -85.59285736084, z = 67.585914611816, h = 246.69660949707, r = { x = -35.0, y = 0.0, z = 246.69660949707 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -214.30616760254, y = -49.626979827881, z = 60.285755157471, h = 247.09072875977, r = { x = -35.0, y = 0.0, z = 247.09072875977 }, canRotate = false, isOnline = true },
        }
    },
    [46] = {
        name = "Abe Milton Parkway",
        color = 'orange',
        tab = 'speedcam',
        x = -430.87246704102,
        y = -280.63619995117,
        z = 45.25577545166,
        cams = {
            [1] = { label = "Cam ", x = -430.87246704102, y = -280.63619995117, z = 45.25577545166, h = 41.895042419434, r = { x = -35.0, y = 0.0, z = 41.895042419434 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -332.6071472168, y = -351.33056640625, z = 40.172431945801, h = 55.516189575195, r = { x = -35.0, y = 0.0, z = 55.516189575195 }, canRotate = false, isOnline = true },
        }
    },
    [47] = {
        name = "Dorset Drive",
        color = 'orange',
        tab = 'speedcam',
        x = -361.90942382813,
        y = -379.77914428711,
        z = 40.345054626465,
        cams = {
            [1] = { label = "Cam ", x = -361.90942382813, y = -379.77914428711, z = 40.345054626465, h = 256.85681152344, r = { x = -35.0, y = 0.0, z = 256.85681152344 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -505.93823242188, y = -362.03662109375, z = 44.427394866943, h = 269.07022094727, r = { x = -35.0, y = 0.0, z = 269.07022094727 }, canRotate = false, isOnline = true },
        }
    },
    [48] = {
        name = "Palomino Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = -645.75555419922,
        y = -694.13415527344,
        z = 39.766544342041,
        cams = {
            [1] = { label = "Cam ", x = -645.75555419922, y = -694.13415527344, z = 39.766544342041, h = 0.17504033446312, r = { x = -35.0, y = 0.0, z = 0.17504033446312 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -645.14068603516, y = -796.75317382813, z = 34.354969024658, h = 3.6387157440186, r = { x = -35.0, y = 0.0, z = 3.6387157440186 }, canRotate = false, isOnline = true },
        }
    },
    [49] = {
        name = "Spanish Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = -76.736518859863,
        y = 56.48473739624,
        z = 81.424140930176,
        cams = {
            [1] = { label = "Cam ", x = -76.736518859863, y = 56.48473739624, z = 81.424140930176, h = 242.30714416504, r = { x = -35.0, y = 0.0, z = 242.30714416504 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -187.35562133789, y = 119.25296783447, z = 79.34449005127, h = 237.43049621582, r = { x = -35.0, y = 0.0, z = 237.43049621582 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = -260.8288269043, y = 129.38798522949, z = 78.418067932129, h = 269.48315429688, r = { x = -35.0, y = 0.0, z = 269.48315429688 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = -361.30767822266, y = 131.23094177246, z = 75.505561828613, h = 275.78814697266, r = { x = -35.0, y = 0.0, z = 275.78814697266 }, canRotate = false, isOnline = true },
            [5] = { label = "Cam ", x = -353.98751831055, y = 120.39169311523, z = 75.90397644043, h = 94.44499206543, r = { x = -35.0, y = 0.0, z = 94.44499206543 }, canRotate = false, isOnline = true },
            [6] = { label = "Cam ", x = -252.55928039551, y = 119.17273712158, z = 78.556282043457, h = 90.11124420166, r = { x = -35.0, y = 0.0, z = 90.11124420166 }, canRotate = false, isOnline = true },
            [7] = { label = "Cam ", x = -188.08952331543, y = 108.2428894043, z = 78.875366210938, h = 56.643199920654, r = { x = -35.0, y = 0.0, z = 56.643199920654 }, canRotate = false, isOnline = true },
            [8] = { label = "Cam ", x = -127.93963623047, y = 73.033935546875, z = 80.167221069336, h = 61.679515838623, r = { x = -35.0, y = 0.0, z = 61.679515838623 }, canRotate = false, isOnline = true },
        }
    },
    [50] = {
        name = "Strawberry Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = -56.207160949707,
        y = -1628.5430908203,
        z = 38.385307312012,
        cams = {
            [1] = { label = "Cam ", x = -56.207160949707, y = -1628.5430908203, z = 38.385307312012, h = 316.87881469727, r = { x = -35.0, y = 0.0, z = 316.87881469727 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -118.81836700439, y = -1703.3482666016, z = 38.097400665283, h = 319.32150268555, r = { x = -35.0, y = 0.0, z = 319.32150268555 }, canRotate = false, isOnline = true },
        }
    },
    [51] = {
        name = "Davis Avenue",
        color = 'orange',
        tab = 'speedcam',
        x = -487.27279663086,
        y = -1888.1682128906,
        z = 26.016599655151,
        cams = {
            [1] = { label = "Cam ", x = -487.27279663086, y = -1888.1682128906, z = 26.016599655151, h = 304.36492919922, r = { x = -35.0, y = 0.0, z = 304.36492919922 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -649.69958496094, y = -2043.615234375, z = 23.401611328125, h = 325.62588500977, r = { x = -35.0, y = 0.0, z = 325.62588500977 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = -700.55645751953, y = -2129.2495117188, z = 22.483177185059, h = 139.55595397949, r = { x = -35.0, y = 0.0, z = 139.55595397949 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = -512.15509033203, y = -1933.4028320313, z = 25.718488693237, h = 131.83595275879, r = { x = -35.0, y = 0.0, z = 131.83595275879 }, canRotate = false, isOnline = true },
        }
    },
    [52] = {
        name = "Arsenal Street",
        color = 'orange',
        tab = 'speedcam',
        x = -527.67395019531,
        y = -1763.244140625,
        z = 30.972793579102,
        cams = {
            [1] = { label = "Cam ", x = -527.67395019531, y = -1763.244140625, z = 30.972793579102, h = 239.88433837891, r = { x = -35.0, y = 0.0, z = 239.88433837891 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -634.45678710938, y = -1685.7740478516, z = 33.775535583496, h = 227.80474853516, r = { x = -35.0, y = 0.0, z = 227.80474853516 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = -644.92584228516, y = -1682.9501953125, z = 34.456928253174, h = 36.464763641357, r = { x = -35.0, y = 0.0, z = 36.464763641357 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = -532.58123779297, y = -1766.5537109375, z = 30.552833557129, h = 52.920215606689, r = { x = -35.0, y = 0.0, z = 52.920215606689 }, canRotate = false, isOnline = true },
        }
    },
    [53] = {
        name = "Great Ocean Highway",
        color = 'orange',
        tab = 'speedcam',
        x = -2211.390625,
        y = -334.50256347656,
        z = 22.855121612549,
        cams = {
            [1] = { label = "Cam ", x = -2211.390625, y = -334.50256347656, z = 22.855121612549, h = 263.23779296875, r = { x = -35.0, y = 0.0, z = 263.23779296875 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -2445.4677734375, y = -217.99057006836, z = 26.665994644165, h = 243.16506958008, r = { x = -35.0, y = 0.0, z = 243.16506958008 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = -3081.9262695313, y = 786.31994628906, z = 28.666316986084, h = 222.83113098145, r = { x = -35.0, y = 0.0, z = 222.83113098145 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = -3115.1079101563, y = 1037.7496337891, z = 29.492776870728, h = 158.96687316895, r = { x = -35.0, y = 0.0, z = 158.96687316895 }, canRotate = false, isOnline = true },
            [5] = { label = "Cam ", x = -2692.2353515625, y = 2344.8005371094, z = 26.51978302002, h = 163.41654968262, r = { x = -35.0, y = 0.0, z = 163.41654968262 }, canRotate = false, isOnline = true },
            [6] = { label = "Cam ", x = -2545.7136230469, y = 3409.2294921875, z = 22.381118774414, h = 160.20637512207, r = { x = -35.0, y = 0.0, z = 160.20637512207 }, canRotate = false, isOnline = true },
            [7] = { label = "Cam ", x = -2027.3785400391, y = 4483.0747070313, z = 66.217643737793, h = 128.61772155762, r = { x = -35.0, y = 0.0, z = 128.61772155762 }, canRotate = false, isOnline = true },
            [8] = { label = "Cam ", x = -1751.1884765625, y = 4753.7216796875, z = 66.637565612793, h = 136.87809753418, r = { x = -35.0, y = 0.0, z = 136.87809753418 }, canRotate = false, isOnline = true },
        }
    },
    [54] = {
        name = "Great Ocean Highway 2",
        color = 'orange',
        tab = 'speedcam',
        x = -1750.8889160156,
        y = 4754.7895507813,
        z = 66.913772583008,
        cams = {
            [1] = { label = "Cam ", x = -1750.8889160156, y = 4754.7895507813, z = 66.913772583008, h = 129.57174682617, r = { x = -35.0, y = 0.0, z = 129.57174682617 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -515.16986083984, y = 5791.7734375, z = 44.82933807373, h = 153.49844360352, r = { x = -35.0, y = 0.0, z = 153.49844360352 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = 1578.7193603516, y = 6395.3344726563, z = 36.224994659424, h = 66.858795166016, r = { x = -35.0, y = 0.0, z = 66.858795166016 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = 1959.5163574219, y = 6182.9951171875, z = 54.89026260376, h = 20.323411941528, r = { x = -35.0, y = 0.0, z = 20.323411941528 }, canRotate = false, isOnline = true },
            [5] = { label = "Cam ", x = 2625.7961425781, y = 5058.2529296875, z = 54.482135772705, h = 194.10902404785, r = { x = -35.0, y = 0.0, z = 194.10902404785 }, canRotate = false, isOnline = true },
            [6] = { label = "Cam ", x = 2689.0251464844, y = 4805.9145507813, z = 54.449214935303, h = 189.85807800293, r = { x = -35.0, y = 0.0, z = 189.85807800293 }, canRotate = false, isOnline = true },
            [7] = { label = "Cam ", x = 2905.78125, y = 3812.5170898438, z = 63.529319763184, h = 353.63922119141, r = { x = -35.0, y = 0.0, z = 353.63922119141 }, canRotate = false, isOnline = true },
            [8] = { label = "Cam ", x = 2822.8347167969, y = 3522.6740722656, z = 63.349510192871, h = 340.33352661133, r = { x = -35.0, y = 0.0, z = 340.33352661133 }, canRotate = false, isOnline = true },
        }
    },
    [55] = {
        name = "Great Ocean Highway 3",
        color = 'orange',
        tab = 'speedcam',
        x = 1773.6585693359,
        y = 2124.8974609375,
        z = 73.647888183594,
        cams = {
            [1] = { label = "Cam ", x = 1773.6585693359, y = 2124.8974609375, z = 73.647888183594, h = 351.19976806641, r = { x = -35.0, y = 0.0, z = 351.19976806641 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = 1717.7016601563, y = 1643.7568359375, z = 92.180953979492, h = 355.13705444336, r = { x = -35.0, y = 0.0, z = 355.13705444336 }, canRotate = false, isOnline = true },
            [3] = { label = "Cam ", x = 899.69750976563, y = 203.28167724609, z = 86.154815673828, h = 317.0299987793, r = { x = -35.0, y = 0.0, z = 317.0299987793 }, canRotate = false, isOnline = true },
            [4] = { label = "Cam ", x = 703.02557373047, y = -98.449363708496, z = 64.273849487305, h = 335.85116577148, r = { x = -35.0, y = 0.0, z = 335.85116577148 }, canRotate = false, isOnline = true },
            [5] = { label = "Cam ", x = 749.26275634766, y = -87.312782287598, z = 65.669593811035, h = 150.41082763672, r = { x = -35.0, y = 0.0, z = 150.41082763672 }, canRotate = false, isOnline = true },
            [6] = { label = "Cam ", x = 963.20446777344, y = 221.75384521484, z = 87.445304870605, h = 134.81756591797, r = { x = -35.0, y = 0.0, z = 134.81756591797 }, canRotate = false, isOnline = true },
            [7] = { label = "Cam ", x = 1721.2904052734, y = 1524.3575439453, z = 93.92635345459, h = 169.69137573242, r = { x = -35.0, y = 0.0, z = 169.69137573242 }, canRotate = false, isOnline = true },
            [8] = { label = "Cam ", x = 1921.2243652344, y = 2427.9040527344, z = 65.059783935547, h = 155.43365478516, r = { x = -35.0, y = 0.0, z = 155.43365478516 }, canRotate = false, isOnline = true },
        }
    },
    [56] = {
        name = "Del Perro",
        color = 'orange',
        tab = 'speedcam',
        x = -468.79418945313,
        y = -538.06182861328,
        z = 35.54305267334,
        cams = {
            [1] = { label = "Cam ", x = -468.79418945313, y = -538.06182861328, z = 35.54305267334, h = 86.604721069336, r = { x = -35.0, y = 0.0, z = 86.604721069336 }, canRotate = false, isOnline = true },
            [2] = { label = "Cam ", x = -119.38061523438, y = -536.30133056641, z = 40.428127288818, h = 88.726867675781, r = { x = -35.0, y = 0.0, z = 88.726867675781 }, canRotate = false, isOnline = true },
        }
    },
    [57] = {
        name = "Supermarkt Brabareno",
        color = 'green',
        tab = 'store',
        x = -3245.1965332031,
        y = 1009.7352294922,
        z = 14.830641746521,
        cams = {
            [1] = { label = "24/7 Supermarkt Brabareno#1", x = -3245.1965332031, y = 1009.7352294922, z = 14.830641746521, r = { x = -35.0, y = 0.0, z = 198.98524475098 }, canRotate = false, isOnline = true },
            [2] = { label = "24/7 Supermarkt Brabareno#2", x = -3250.9296875, y = 1000.1806640625, z = 14.351303100586, h = 314.09790039063, r = { x = -35.0, y = 0.0, z = 314.09790039063 }, canRotate = false, isOnline = true },
        }
    },
    ----  Gun Stores
    [58] = {
        name = "Gun Store 1",
        color = 'red',
        tab = 'gunstores',
        x = 810.40539550781,
        y = -2149.0158691406,
        z = 31.619211196899,
        cams = {
            [1] = { label = "GUN1", x = 810.40539550781, y = -2149.0158691406, z = 31.619211196899, h = 226.54071044922, r = { x = -35.0, y = 0.0, z = 226.54071044922 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = 815.61608886719, y = -2161.4353027344, z = 31.619188308716, h = 215.85209655762, r = { x = -35.0, y = 0.0, z = 215.85209655762 }, canRotate = true, isOnline = true },
        }
    },
    [59] = {
        name = "Gun Store 2",
        color = 'red',
        tab = 'gunstores',
        x = 19.227941513062,
        y = -1114.9119873047,
        z = 31.797191619873,
        cams = {
            [1] = { label = "GUN1", x = 19.227941513062, y = -1114.9119873047, z = 31.797191619873, h = 7.5946688652039, r = { x = -35.0, y = 0.0, z = 45.123699188232 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = 18.362140655518, y = -1101.46875, z = 31.797187805176, h = 19.877038955688, r = { x = -35.0, y = 0.0, z = 24.295459747314 }, canRotate = true, isOnline = true },
        }
    },
    [60] = {
        name = "Gun Store 3",
        color = 'red',
        tab = 'gunstores',
        x = -666.203125,
        y = -943.76593017578,
        z = 23.829368591309,
        cams = {
            [1] = { label = "GUN1", x = -666.203125, y = -943.76593017578, z = 23.829368591309, h = 311.30581665039, r = { x = -35.0, y = 0.0, z = 311.54071044922 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = -666.03424072266, y = -929.24700927734, z = 23.829368591309, h = 248.69696044922, r = { x = -35.0, y = 0.0, z = 248.69696044922 }, canRotate = true, isOnline = true },
        }
    },
    [61] = {
        name = "Gun Store 4",
        color = 'red',
        tab = 'gunstores',
        x = -1302.2431640625,
        y = -391.04876708984,
        z = 39.515384674072,
        cams = {
            [1] = { label = "GUN1", x = -1302.2431640625, y = -391.04876708984, z = 39.515384674072, h = 119.35260772705, r = { x = -35.0, y = 0.0, z = 119.35260772705 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = -1314.6180419922, y = -394.68408203125, z = 39.515384674072, h = 314.19583129883, r = { x = -35.0, y = 0.0, z = 314.69696044922 }, canRotate = true, isOnline = true },
        }
    },
    [62] = {
        name = "Gun Store 5",
        color = 'red',
        tab = 'gunstores',
        x = 245.57925415039,
        y = -43.366485595703,
        z = 72.538314819336,
        cams = {
            [1] = { label = "GUN1", x = 245.57925415039, y = -43.366485595703, z = 72.538314819336, h = 196.64096069336, r = { x = -35.0, y = 0.0, z = 196.69696044922 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = 259.24420166016, y = -48.381195068359, z = 72.538314819336, h = 125.15637969971, r = { x = -35.0, y = 0.0, z = 125.35260772705 }, canRotate = true, isOnline = true },
        }
    },
    [63] = {
        name = "Gun Store 6",
        color = 'red',
        tab = 'gunstores',
        x = 2571.8657226563,
        y = 302.79776000977,
        z = 110.73508453369,
        cams = {
            [1] = { label = "GUN1", x = 2571.8657226563, y = 302.79776000977, z = 110.73508453369, h = 135.33522033691, r = { x = -35.0, y = 0.0, z = 135.33522033691 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = 2563.8620605469, y = 288.34429931641, z = 110.73509216309, h = 294.67126464844, r = { x = -35.0, y = 0.0, z = 294.67126464844 }, canRotate = true, isOnline = true },
        }
    },
    [64] = {
        name = "Gun Store 7",
        color = 'red',
        tab = 'gunstores',
        x = -3166.3056640625,
        y = 1080.869140625,
        z = 22.838771820068,
        cams = {
            [1] = { label = "GUN1", x = -3166.3056640625, y = 1080.869140625, z = 22.838771820068, h = 39.133140563965, r = { x = -35.0, y = 0.0, z = 39.69696044922 }, canRotate = true, isOnline = true },
        }
    },
    [65] = {
        name = "Gun Store 8",
        color = 'red',
        tab = 'gunstores',
        x = -1115.0960693359,
        y = 2689.5444335938,
        z = 20.554265975952,
        cams = {
            [1] = { label = "GUN1", x = -1115.0960693359, y = 2689.5444335938, z = 20.554265975952, h = 348.90670776367, r = { x = -35.0, y = 0.0, z = 348.90670776367 }, canRotate = true, isOnline = true },
            [2] = { label = "GUN1", x = -1118.7442626953, y = 2705.6391601563, z = 20.554265975952, h = 143.27917480469, r = { x = -35.0, y = 0.0, z = 143.35260772705 }, canRotate = true, isOnline = true },
        }
    },
    [66] = {
        name = "Gun Store 9",
        color = 'red',
        tab = 'gunstores',
        x = 1696.6129150391,
        y = 3751.4780273438,
        z = 36.705387115479,
        cams = {
            [1] = { label = "GUN1", x = 1696.6129150391, y = 3751.4780273438, z = 36.705387115479, h = 1.5820089578629, r = { x = -35.0, y = 0.0, z = 1.5820089578629 }, canRotate = true, isOnline = true },
        }
    },
    [67] = {
        name = "Gun Store 10",
        color = 'red',
        tab = 'gunstores',
        x = -327.66665649414,
        y = 6075.3159179688,
        z = 33.454809188843,
        cams = {
            [1] = { label = "GUN1", x = -327.66665649414, y = 6075.3159179688, z = 33.454809188843, h = 0.77708107233047, r = { x = -35.0, y = 0.0, z = 0.77708107233047 }, canRotate = true, isOnline = true },
        }
    },
    [68] = {
        name = "Gun Store 11",
        color = 'red',
        tab = 'gunstores',
        x = 846.17578125,
        y = -1025.7087402344,
        z = 28.19487953186,
        cams = {
            [1] = { label = "GUN1", x = 846.17578125, y = -1025.7087402344, z = 30.19487953186, h = 135.01954650879, r = { x = -35.0, y = 0.0, z = 135.01954650879 }, canRotate = true, isOnline = true },
        }
    },
    [69] = {
        name = "Public Depot",
        color = 'yellow',
        tab = 'others',
        x = -187.5754699707,
        y = -1167.3360595703,
        z = 24.971377182007,
        cams = {
            [1] = { label = "Depot1", x = -187.5754699707, y = -1167.3360595703, z = 24.971377182007, h = 45.847743988037, r = { x = -35.0, y = 0.0, z = 45.847743988037 }, canRotate = true, isOnline = true },
            [2] = { label = "Depot2", x = -155.52430725098, y = -1186.0202636719, z = 26.227642059326, h = 314.72119140625, r = { x = -35.0, y = 0.0, z = 314.72119140625 }, canRotate = true, isOnline = true },
            [3] = { label = "Depot3", x = -225.12986755371, y = -1185.9189453125, z = 24.534683227539, h = 321.12725830078, r = { x = -35.0, y = 0.0, z = 321.12725830078 }, canRotate = true, isOnline = true },
            [4] = { label = "Depot4", x = -224.91937255859, y = -1159.4287109375, z = 24.534683227539, h = 231.97808837891, r = { x = -35.0, y = 0.0, z = 231.97808837891 }, canRotate = true, isOnline = true },
        }
    },
    [70] = {
        name = 'Fleeca Bank Great Ocean Hwy',
        color = 'fst8',
        tab = 'bank',
        x = -2963.8996582031,
        y = 478.85543823242,
        z = 17.69686794281,
        cams = {
            [1] = { label = " Great Ocean Hwy CAM#1", x = -2963.8996582031, y = 478.85543823242, z = 17.69686794281, h = 350.5217590332, r = { x = -35.0, y = 0.0, z = 358.30316162109 }, canRotate = true, isOnline = true },
            [2] = { label = " Great Ocean Hwy CAM#2", x = -2957.0270996094, y = 476.32464599609, z = 17.66424369812, h = 71.819290161133, r = { x = -35.0, y = 0.0, z = 71.819290161133 }, canRotate = true, isOnline = true },
            [3] = { label = " Great Ocean Hwy CAM#3", x = -2952.6145019531, y = 485.99966430664, z = 17.67542552948, h = 128.81826782227, r = { x = -35.0, y = 0.0, z = 128.81826782227 }, canRotate = true, isOnline = true },
        }
    },
}

Config.Radars = {} -- Dont Touch

-- #discord.gg/2q8eaAynAf
 -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
      -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
  -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
    -- #discord.gg/2q8eaAynAf
 -- #discord.gg/2q8eaAynAf
   -- #discord.gg/2q8eaAynAf
     -- #discord.gg/2q8eaAynAf
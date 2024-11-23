-- [[ Core ]]

-- Configuration settings
Config            = {}
-- Debug print setting for displaying debug messages.
Config.DebugPrint = false
-- Locale setting for language localization.
Config.Locale     = "en"
-- ("esx" | "qb") -- > The latest version is always used.
Config.FrameWork  = "qb"
-- ("esx_notify" | "qb_notify" | "custom_notify") -- > System to be used
Config.NotifyType = "qb_notify"
--[[
    - ("target" | "drawtext" | "wais-npcdialog") -- > The setting to use when interacting with NPCs, items and vehicles.
    - To select wais-npcdialog, you must have it.
    - To select wais-npcdialog, At some points, I use target, so target must be installed.
]]
Config.InteractType = "target"
-- ("ox_target" | "qb_target" | "custom")
Config.TargetType   = "qb_target"
-- ("ox_textui" | "qb_textui" | "drawtext")
Config.TextUIType   = "drawtext"

-- [[ Delivery Config]]

--[[
    client/utils.lua:Utils.Functions.GiveVehicleKey
    You need to edit the function according to your own script !
    Changing the "script" value is not enough.
]]
Config.VehicleKeySystem = {
    active = true,
    script = "qb-vehiclekeys",
}

Config.JobOptions       = {
    --[[ Ranks
        Determines the completion experience of each level.
        The more there are, the more levels there are.
        So in this value, 7 levels have been added.
    ]]
    ranks = { 0, 1800, 4000, 6100, 9500, 12500, 16000 },
    --[[ Starting Point
        Options for where to receive the job.
    ]]
    startPoints = {
        --[[ Start Point #1 ]]
        [1] = {
            active = true,
            --[[
                Restrict jobs that can do this job
                Value: nil or "job_name" or {job_name_1 = 0, job_name_2 = 0}
            ]]
            job = nil,
            -- [[ Employer Options ]]
            employerPed = {
                -- [[ Employer will be here ]]
                spawnCoords = vector4(162.58, -3083.86, 5.95, 266.45),
                model = "mp_m_forgery_01",
                blip = {
                    active = true,
                    scale = 0.8,
                    color = 16,
                    sprite = 318,
                    title = "Delivery Job"
                },
                --[[ If you have and want Wais Dialog]]
                waisDialog = {
                    coords = vec4(163.674728, -3083.802246, 6.5, 90.708656)
                },
            },
            -- [[ Uniform Options ]]
            uniforms = {
                active = false,
                male = {
                    ["tshirt_1"] = 15,
                    ["tshirt_2"] = 0,
                    ["torso_1"] = 13,
                    ["torso_2"] = 3,
                    ["decals_1"] = 0,
                    ["decals_2"] = 0,
                    ["arms"] = 11,
                    ["pants_1"] = 96,
                    ["pants_2"] = 0,
                    ["shoes_1"] = 10,
                    ["shoes_2"] = 0,
                    ["chain_1"] = 0,
                    ["chain_2"] = 0,
                    ["helmet_1"] = -1,
                    ["helmet_2"] = 0
                },
                female = {
                    ["tshirt_1"] = 15,
                    ["tshirt_2"] = 0,
                    ["torso_1"] = 13,
                    ["torso_2"] = 3,
                    ["decals_1"] = 0,
                    ["decals_2"] = 0,
                    ["arms"] = 11,
                    ["pants_1"] = 96,
                    ["pants_2"] = 0,
                    ["shoes_1"] = 10,
                    ["shoes_2"] = 0,
                    ["chain_1"] = 0,
                    ["chain_2"] = 0,
                    ["helmet_1"] = -1,
                    ["helmet_2"] = 0
                }
            },
            -- [[ Vehicle Options ]]
            taskVehicle = {
                model = "boxville2", -- !!! I don't recommend changing it.
                -- The vehicle will spawn in the empty slot at the specified coordinates.
                spawnCoords = {
                    vec4(150.750000, -3082.590000, 5.9, 180.0),
                    vec4(145.859344, -3083.010986, 5.9, 180.0),
                    vec4(140.399994, -3082.773682, 5.9, 180.0),
                    vec4(134.149445, -3085.160400, 5.9, 180.0),
                    vec4(126.435165, -3082.984619, 5.9, 180.0),
                    vec4(148.167038, -3102.197754, 5.9, 0.0),
                    vec4(134.597809, -3101.894531, 5.9, 0.0),
                    vec4(129.415390, -3102.039551, 5.9, 0.0),
                    vec4(123.969231, -3102.355957, 5.9, 0.0),
                },
                --[[
                    -- The coordinates where the boxes to be distributed will be loaded on the vehicles.
                    -- It will work if the task type is "delivery".
                ]]
                cargoBoxesLoadCoords = {
                    vec3(144.224182, -3074.505615, 5.892334),
                    vec3(140.294510, -3074.782471, 5.892334),
                    vec3(128.729675, -3078.540771, 5.909180),
                    vec3(121.740662, -3112.021973, 5.993408),
                    vec3(138.184616, -3111.797852, 5.892334),
                },
                cargoHoldCoords = {
                    --[[ I do not recommend changing it. ]]
                    -- Left --
                    { pos = vec3(-0.70, -3.13, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -2.75, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -2.35, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -1.95, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -1.55, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -1.15, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -0.75, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(-0.70, -0.35, 0.265), rot = vec3(0.0, 0.0, 0.0) },
                    -- Right --
                    { pos = vec3(0.70, -3.13, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -2.75, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -2.35, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -1.95, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -1.55, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -1.15, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -0.75, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                    { pos = vec3(0.70, -0.35, 0.265),  rot = vec3(0.0, 0.0, 0.0) },
                },
                plate = "DELIVERY",
            }
        },
    },
    --[[ Delivery | Random objects and peds to be used in tasks. ]]
    delivery = {
        taskProps = {
            { model = "prop_cs_cardbox_01",  coords = vec3(0.05, 0.1, -0.3),  rot = vec3(300.0, 250.0, 20.0) },
            { model = "prop_cs_rub_box_01",  coords = vec3(0.25, 0.35, -0.3), rot = vec3(80.0, -0.0, 20.0) },
            { model = "prop_cs_package_01",  coords = vec3(0.15, 0.0, -0.25), rot = vec3(72.0, 85.0, 2.0) },
            { model = "prop_cs_box_clothes", coords = vec3(0.15, 0.0, -0.25), rot = vec3(72.0, 85.0, 2.0) },
            -- { model = "prop_cs_box_step",    coords = vec3(0.35, 0.15, -0.5), rot = vec3(72.0, 85.0, 2.0) },
        },
        taskPeds = {
            "u_m_m_aldinapoli", "a_f_m_eastsa_02", "a_m_m_farmer_01", "a_f_y_business_02",
            "a_m_m_hasjew_01", "a_f_y_yoga_01", "g_f_y_vagos_01", "g_m_y_korlieut_01",
            "g_f_y_ballas_01", "g_m_y_mexgoon_03",
        },
    },
}

Config.Commands         = {
    -- [[ To Open the tablet. ]]
    tabletCommand = "delivery",
    -- [[ To accept the invitation. ]]
    acceptInv = "acceptinvite",
    -- [[ To deny the invitation. ]]
    denyInv = "denyinvite",
    -- [[ To block the invitations. ]]
    blockInvitations = "blockinvitations",
    -- [[ To left the team. ]]
    leaveteam = "leaveteam",
}

--[[ You can set Commands.tabletCommand' command to use with item. ]]
Config.Tablet          = {
    active = true,
    itemName = "delivery_tablet",
}

Config.AcceptableTasks = {
    -- Min Level 1 Jobs
    [1] = {
        -- !!! Must be the same as KEY and UNIQUE.
        unique_id = 1,
        -- Min level required to perform this task
        level = 1,
        -- Short text explaining the task
        title = "Task #1",
        -- Type of task type:("delivery" or "collecting")
        type = "delivery",
        -- The required goal to complete the task
        goal = 3,
        -- Experience points for completing the mission
        exp = 400,
        -- Reward for completing the task
        fee = 5000,
        --[[
            The coordinates of the task.
            !!! Please add at least as many coordinates as there are targets.
            Coordinates will be given randomly.
            So the more coordinates you add, the more the feeling of different missions.
            !!! Please add as shown.
        ]]
        destinations = {
            [1] = { coords = vec4(479.736267, -1736.109863, 29.145020, 206.929138) },
            [2] = { coords = vec4(313.898895, -2040.672485, 20.922363, 308.976379) },
            [3] = { coords = vec4(353.248352, -2036.400024, 22.337769, 107.716537) },
            [4] = { coords = vec4(152.663742, -1823.604370, 27.864502, 56.692913) },
            [5] = { coords = vec4(-111.059341, -1593.850586, 31.975830, 238.110229) }, --
            [6] = { coords = vec4(-125.630768, -1473.481323, 33.812500, 317.480316) },
            [7] = { coords = vec4(168.145050, -1299.177979, 29.364136, 68.031494) },
        },
    },
    [2] = {
        unique_id = 2,
        level = 1,
        title = "Task #2",
        type = "collecting",
        goal = 3,
        exp = 400,
        fee = 5000,
        destinations = {
            [1] = { coords = vec4(479.736267, -1736.109863, 29.145020, 206.929138) },
            [2] = { coords = vec4(313.898895, -2040.672485, 20.922363, 308.976379) },
            [3] = { coords = vec4(353.248352, -2036.400024, 22.337769, 107.716537) },
            [4] = { coords = vec4(152.663742, -1823.604370, 27.864502, 56.692913) },
            [5] = { coords = vec4(-111.059341, -1593.850586, 31.975830, 238.110229) },
            [6] = { coords = vec4(-125.630768, -1473.481323, 33.812500, 317.480316) },
            [7] = { coords = vec4(168.145050, -1299.177979, 29.364136, 68.031494) },
        },
    },
    [3] = {
        unique_id = 3,
        level = 1,
        title = "Task #3",
        type = "delivery",
        goal = 3,
        exp = 400,
        fee = 5000,
        destinations = {
            [1] = { coords = vec4(-1011.0830, -1224.7694, 5.8178, 270.7039) },
            [2] = { coords = vec4(-1002.3689, -1219.4747, 5.7666, 166.7043) },
            [3] = { coords = vec4(-1098.7528, -1679.8223, 4.3720, 138.8091) },
            [4] = { coords = vec4(-1229.1188, -1035.1514, 8.2738, 54.1112) },
            [5] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [6] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
        },
    },
    [4] = {
        unique_id = 4,
        level = 1,
        title = "Task #4",
        type = "collecting",
        goal = 3,
        exp = 400,
        fee = 5000,
        destinations = {
            [1] = { coords = vec4(-1011.0830, -1224.7694, 5.8178, 270.7039) },
            [2] = { coords = vec4(-1002.3689, -1219.4747, 5.7666, 166.7043) },
            [3] = { coords = vec4(-1098.7528, -1679.8223, 4.3720, 138.8091) },
            [4] = { coords = vec4(-1229.1188, -1035.1514, 8.2738, 54.1112) },
            [5] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [6] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
        },
    },
    [5] = {
        unique_id = 5,
        level = 1,
        title = "Task #5",
        type = "delivery",
        goal = 3,
        exp = 400,
        fee = 5000,
        destinations = {
            [1] = { coords = vec4(93.3542, 71.2765, 73.4167, 134.4712) },
            [2] = { coords = vec4(-103.1247, -69.9278, 58.8590, 302.5392) },
            [3] = { coords = vec4(-22.9876, -192.2715, 52.3628, 109.5882) },
            [4] = { coords = vec4(-512.0361, 108.8368, 63.8005, 351.4974) },
            [5] = { coords = vec4(-1298.0808, -393.1277, 36.4557, 253.1478) },
            [6] = { coords = vec4(-1612.5510, -1028.7708, 13.1532, 238.8762) },
        },
    },
    [6] = {
        unique_id = 6,
        level = 1,
        title = "Task #6",
        type = "collecting",
        goal = 3,
        exp = 400,
        fee = 5000,
        destinations = {
            [1] = { coords = vec4(93.3542, 71.2765, 73.4167, 134.4712) },
            [2] = { coords = vec4(-103.1247, -69.9278, 58.8590, 302.5392) },
            [3] = { coords = vec4(-22.9876, -192.2715, 52.3628, 109.5882) },
            [4] = { coords = vec4(-512.0361, 108.8368, 63.8005, 351.4974) },
            [5] = { coords = vec4(-1298.0808, -393.1277, 36.4557, 253.1478) },
            [6] = { coords = vec4(-1612.5510, -1028.7708, 13.1532, 238.8762) },
        },
    },
    -- Min Level 2 Jobs
    [7] = {
        unique_id = 7,
        level = 2,
        title = "Task #7",
        type = "delivery",
        goal = 6,
        exp = 600,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(-717.6805, -1119.7814, 10.6524, 324.5773) },
            [2] = { coords = vec4(-766.9211, -1034.7822, 14.1332, 293.6201) },
            [3] = { coords = vec4(-712.2829, -1298.5209, 5.1019, 53.3707) },
            [4] = { coords = vec4(-696.6675, -1386.5317, 5.4953, 120.0416) },
            [5] = { coords = vec4(-645.6921, -1223.5043, 11.2219, 320.9676) },
            [6] = { coords = vec4(-650.0999, -1149.7506, 9.1523, 169.1946) },
            [7] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
        },
    },
    [8] = {
        unique_id = 8,
        level = 2,
        title = "Task #8",
        type = "collecting",
        goal = 6,
        exp = 600,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(-717.6805, -1119.7814, 10.6524, 324.5773) },
            [2] = { coords = vec4(-766.9211, -1034.7822, 14.1332, 293.6201) },
            [3] = { coords = vec4(-712.2829, -1298.5209, 5.1019, 53.3707) },
            [4] = { coords = vec4(-696.6675, -1386.5317, 5.4953, 120.0416) },
            [5] = { coords = vec4(-645.6921, -1223.5043, 11.2219, 320.9676) },
            [6] = { coords = vec4(-650.0999, -1149.7506, 9.1523, 169.1946) },
            [7] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
        },
    },
    [9] = {
        unique_id = 9,
        level = 2,
        title = "Task #9",
        type = "delivery",
        goal = 6,
        exp = 600,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(52.351654, -1588.219727, 29.583130, 48.188972) },
            [2] = { coords = vec4(15.6336, -1309.8014, 29.1793, 303.8186) },
            [3] = { coords = vec4(-5.0489, -1109.6482, 28.8151, 129.7470) },
            [4] = { coords = vec4(-546.5045, -889.4754, 25.0995, 185.4557) },
            [5] = { coords = vec4(-463.1349, -276.2968, 35.8806, 13.4029) },
            [6] = { coords = vec4(-468.3615, -62.5412, 44.5134, 351.8087) },
            [7] = { coords = vec4(-697.1699, 43.7915, 43.3151, 219.2770) },
        },
    },
    [10] = {
        unique_id = 10,
        level = 2,
        title = "Task #10",
        type = "collecting",
        goal = 6,
        exp = 600,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(52.351654, -1588.219727, 29.583130, 48.188972) },
            [2] = { coords = vec4(15.6336, -1309.8014, 29.1793, 303.8186) },
            [3] = { coords = vec4(-5.0489, -1109.6482, 28.8151, 129.7470) },
            [4] = { coords = vec4(-546.5045, -889.4754, 25.0995, 185.4557) },
            [5] = { coords = vec4(-463.1349, -276.2968, 35.8806, 13.4029) },
            [6] = { coords = vec4(-468.3615, -62.5412, 44.5134, 351.8087) },
            [7] = { coords = vec4(-697.1699, 43.7915, 43.3151, 219.2770) },
        },
    },
    -- Min Level 3 Jobs
    [11] = {
        unique_id = 11,
        level = 3,
        title = "Task #11",
        type = "delivery",
        goal = 8,
        exp = 600,
        fee = 30000,
        destinations = {
            [1] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [2] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [3] = { coords = vec4(-1101.8966, -1231.0469, 2.7739, 95.3342) },
            [4] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [5] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
            [6] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [7] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [8] = { coords = vec4(-1101.8966, -1231.0469, 2.7739, 95.3342) },
            [9] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [10] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
        },
    },
    [12] = {
        unique_id = 12,
        level = 3,
        title = "Task #12",
        type = "collecting",
        goal = 8,
        exp = 600,
        fee = 30000,
        destinations = {
            [1] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [2] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [3] = { coords = vec4(-1101.8966, -1231.0469, 2.7739, 95.3342) },
            [4] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [5] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
            [6] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [7] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [8] = { coords = vec4(-1101.8966, -1231.0469, 2.7739, 95.3342) },
            [9] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [10] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
        },
    },
    [13] = {
        unique_id = 13,
        level = 3,
        title = "Task #13",
        type = "delivery",
        goal = 8,
        exp = 600,
        fee = 30000,
        destinations = {
            [1] = { coords = vec4(-1407.2572, 537.0112, 122.9235, 80.6345) },
            [2] = { coords = vec4(-635.1705, 529.9332, 109.6877, 222.7794) },
            [3] = { coords = vec4(-1508.8707, 1499.6748, 115.2885, 181.4171) },
            [4] = { coords = vec4(-775.4446, 5592.9990, 33.6285, 165.5488) },
            [5] = { coords = vec4(-315.9359, 6310.1499, 32.4343, 18.2081) },
            [6] = { coords = vec4(171.3948, 6633.4185, 31.6435, 224.6780) },
            [7] = { coords = vec4(-332.5612, 6157.4058, 31.4890, 115.0903) },
            [8] = { coords = vec4(-1974.5255, 627.4402, 122.5363, 180.3733) },
            [9] = { coords = vec4(-2006.0101, 449.6665, 102.4238, 345.5418) },
        },
    },
    [14] = {
        unique_id = 14,
        level = 3,
        title = "Task #14",
        type = "collecting",
        goal = 8,
        exp = 600,
        fee = 30000,
        destinations = {
            [1] = { coords = vec4(-1407.2572, 537.0112, 122.9235, 80.6345) },
            [2] = { coords = vec4(-635.1705, 529.9332, 109.6877, 222.7794) },
            [3] = { coords = vec4(-1508.8707, 1499.6748, 115.2885, 181.4171) },
            [4] = { coords = vec4(-775.4446, 5592.9990, 33.6285, 165.5488) },
            [5] = { coords = vec4(-315.9359, 6310.1499, 32.4343, 18.2081) },
            [6] = { coords = vec4(171.3948, 6633.4185, 31.6435, 224.6780) },
            [7] = { coords = vec4(-332.5612, 6157.4058, 31.4890, 115.0903) },
            [8] = { coords = vec4(-1974.5255, 627.4402, 122.5363, 180.3733) },
            [9] = { coords = vec4(-2006.0101, 449.6665, 102.4238, 345.5418) },
        },
    },
    -- Min Level 4 Jobs
    [15] = {
        unique_id = 15,
        level = 4,
        title = "Task #15",
        type = "delivery",
        goal = 8,
        exp = 850,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(472.4281, -1277.7552, 29.5577, 293.7424) },
            [2] = { coords = vec4(597.0978, 87.0353, 92.7726, 204.1583) },
            [3] = { coords = vec4(-136.6532, 593.0619, 204.5224, 23.5872) },
            [4] = { coords = vec4(-441.1372, 1590.4307, 357.9096, 223.7085) },
            [5] = { coords = vec4(-392.4336, 1238.2635, 325.7587, 158.9265) },
            [6] = { coords = vec4(-2520.0444, 2316.8955, 33.2165, 359.1767) },
            [7] = { coords = vec4(-3231.0400, 933.8480, 13.7985, 330.5598) },
            [8] = { coords = vec4(-3209.4539, 909.3316, 13.9895, 325.0549) },
            [9] = { coords = vec4(-2185.3032, -406.6194, 13.0933, 249.0814) },
        },
    },
    [16] = {
        unique_id = 16,
        level = 4,
        title = "Task #16",
        type = "collecting",
        goal = 8,
        exp = 850,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(472.4281, -1277.7552, 29.5577, 293.7424) },
            [2] = { coords = vec4(597.0978, 87.0353, 92.7726, 204.1583) },
            [3] = { coords = vec4(-136.6532, 593.0619, 204.5224, 23.5872) },
            [4] = { coords = vec4(-441.1372, 1590.4307, 357.9096, 223.7085) },
            [5] = { coords = vec4(-392.4336, 1238.2635, 325.7587, 158.9265) },
            [6] = { coords = vec4(-2520.0444, 2316.8955, 33.2165, 359.1767) },
            [7] = { coords = vec4(-3231.0400, 933.8480, 13.7985, 330.5598) },
            [8] = { coords = vec4(-3209.4539, 909.3316, 13.9895, 325.0549) },
            [9] = { coords = vec4(-2185.3032, -406.6194, 13.0933, 249.0814) },
        },
    },
    [17] = {
        unique_id = 17,
        level = 4,
        title = "Task #17",
        type = "delivery",
        goal = 8,
        exp = 850,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(353.248352, -2036.400024, 22.337769, 107.716537) },
            [2] = { coords = vec4(152.663742, -1823.604370, 27.864502, 56.692913) },
            [3] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [4] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
            [5] = { coords = vec4(-1407.2572, 537.0112, 122.9235, 80.6345) },
            [6] = { coords = vec4(-635.1705, 529.9332, 109.6877, 222.7794) },
            [6] = { coords = vec4(-468.3615, -62.5412, 44.5134, 351.8087) },
            [7] = { coords = vec4(-697.1699, 43.7915, 43.3151, 219.2770) },
            [8] = { coords = vec4(-22.9876, -192.2715, 52.3628, 109.5882) },
        },
    },
    [18] = {
        unique_id = 18,
        level = 4,
        title = "Task #18",
        type = "collecting",
        goal = 8,
        exp = 850,
        fee = 10000,
        destinations = {
            [1] = { coords = vec4(353.248352, -2036.400024, 22.337769, 107.716537) },
            [2] = { coords = vec4(152.663742, -1823.604370, 27.864502, 56.692913) },
            [3] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [4] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
            [5] = { coords = vec4(-1407.2572, 537.0112, 122.9235, 80.6345) },
            [6] = { coords = vec4(-635.1705, 529.9332, 109.6877, 222.7794) },
            [6] = { coords = vec4(-468.3615, -62.5412, 44.5134, 351.8087) },
            [7] = { coords = vec4(-697.1699, 43.7915, 43.3151, 219.2770) },
            [8] = { coords = vec4(-22.9876, -192.2715, 52.3628, 109.5882) },
        },
    },
    -- Min Level 5 Jobs
    [19] = {
        unique_id = 19,
        level = 5,
        title = "Task #19",
        type = "collecting",
        goal = 10,
        exp = 1250,
        fee = 25000,
        destinations = {
            [1] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [2] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
            [3] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [4] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [5] = { coords = vec4(-775.4446, 5592.9990, 33.6285, 165.5488) },
            [6] = { coords = vec4(-315.9359, 6310.1499, 32.4343, 18.2081) },
            [7] = { coords = vec4(-1508.8707, 1499.6748, 115.2885, 181.4171) },
            [8] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [9] = { coords = vec4(-125.630768, -1473.481323, 33.812500, 317.480316) },
            [10] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
            [11] = { coords = vec4(168.145050, -1299.177979, 29.364136, 68.031494) },
        },
    },
    [20] = {
        unique_id = 20,
        level = 5,
        title = "Task #20",
        type = "delivery",
        goal = 10,
        exp = 1250,
        fee = 25000,
        destinations = {
            [1] = { coords = vec4(15.1934, -1032.5333, 29.3466, 130.3846) },
            [2] = { coords = vec4(-583.8513, 195.2310, 71.4421, 99.6975) },
            [3] = { coords = vec4(-1025.3828, -1137.8115, 2.1586, 26.3512) },
            [4] = { coords = vec4(-667.7000, -1104.7300, 14.6335, 71.2479) },
            [5] = { coords = vec4(-775.4446, 5592.9990, 33.6285, 165.5488) },
            [6] = { coords = vec4(-315.9359, 6310.1499, 32.4343, 18.2081) },
            [7] = { coords = vec4(-1508.8707, 1499.6748, 115.2885, 181.4171) },
            [8] = { coords = vec4(-703.3541, -1040.5404, 16.1117, 249.2910) },
            [9] = { coords = vec4(-125.630768, -1473.481323, 33.812500, 317.480316) },
            [10] = { coords = vec4(-861.8019, -1226.8802, 6.2480, 338.3543) },
            [11] = { coords = vec4(168.145050, -1299.177979, 29.364136, 68.031494) },
        },
    },
}

--[[
-- $$\   $$\  $$$$$$\  $$\   $$\ $$\   $$\ $$$$$$$\  
-- $$$\  $$ |$$  __$$\ $$ |  $$ |$$ |  $$ |$$  __$$\ 
-- $$$$\ $$ |$$ /  \__|$$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ $$\$$ |$$ |      $$$$$$$$ |$$ |  $$ |$$$$$$$\ |
-- $$ \$$$$ |$$ |      $$  __$$ |$$ |  $$ |$$  __$$\ 
-- $$ |\$$$ |$$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |  $$ |
-- $$ | \$$ |\$$$$$$  |$$ |  $$ |\$$$$$$  |$$$$$$$  |
-- \__|  \__| \______/ \__|  \__| \______/ \_______/  
-- discord.gg/sgx & Patreon.com/NCHub
]]
Config.HasTowTruck = true

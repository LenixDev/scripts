Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = {                                     -- Only used when not using qb-jobs.
    ['trucker'] = { ['label'] = 'سائق شاحنات', ['isManaged'] = false },
    ['taxi'] = { ['label'] = 'سائق تاكسي', ['isManaged'] = false },
    ['tow'] = { ['label'] = 'عامل سطحة', ['isManaged'] = false },
    ['reporter'] = { ['label'] = 'مراسل صحفي', ['isManaged'] = false },
    ['garbage'] = { ['label'] = 'جامع النفايات', ['isManaged'] = false },
    ['bus'] = { ['label'] = 'سائق حافلة', ['isManaged'] = false },
    ['hotdog'] = { ['label'] = 'بائع نقانق هوت دوج', ['isManaged'] = false },
    ['postal'] = { ['label'] = 'ساعي البريد', ['isManaged'] = false },
}

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vector3(-1294.0, -562.89, 30.57),
        showBlip = true,
        blipData = {
            sprite = 590,
            display = 4,
            scale = 0.7,
            colour = 30,
            title = 'Revival States\'s Services'
        },
        licenses = {
            ['id_card'] = {
                label = 'ID Card',
                cost = 50,
            },
            ['weaponlicense'] = {
                label = 'Weapon License',
                cost = 50,
                metadata = 'weapon'
            },
        }
    },
}

Config.DrivingSchools = {
    { -- Driving School 1
        coords = vec3(0, 0, 0),
        showBlip = false,
        blipData = {
            sprite = 225,
            display = 4,
            scale = 0.65,
            colour = 3,
            title = 'Driving School'
        },
        instructors = {
            'DJD56142',
            'DXT09752',
            'SRI85140',
        }
    },
}

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'u_m_m_bankman',
        coords = vector4(-1294.0, -562.89, 30.57, 224.19),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vec4(0, 0, 0, 0),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}

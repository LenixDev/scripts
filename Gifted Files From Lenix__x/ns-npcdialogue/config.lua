Config = {}

Config.npcs = {
    {
        name = "زكريا الحبشي",
        text = "تبي تسجل دخول و لا تسجل خروج",
        job = "Police Department",
        ped = "a_f_m_beach_01",
        coords = vector4(-1379.14, 735.99, 181.97, 2.67),
        options = {
            {
                label = "تسجيل دخول",
                event = "qb-policejob:ToggleDuty",
                type = "client",
                args = {'1'}
            },
            {
                label = "تسجيل خروج",
                event = "qb-policejob:ToggleDuty",
                type = "client",
                args = {'2'}
            },
        }
    },
}
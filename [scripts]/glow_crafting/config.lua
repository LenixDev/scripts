Config = {}

Config.prop = 'gr_prop_gr_bench_04b'

Config.craftingBenches = {
    --{id = "craft1", coords = vector3(1138.25, -2344.16, 31.35), heading = 349.43},
    {id = "craft2", coords = vector3(-1585.74, 219.14, 68.66), heading = 117.43},
}

--[[
Make sure to change the image path to your inventory image file. Default is lj-inventory, you can change it to qb-inventory by doing this example below:
    https://cfx-nui-qb-inventory/html/images/radio.png
]]


-- Recipes that come with every workbench
Config.defaultRecipes = {
    pistol_ammo = {
        item = "pistol_ammo",
        label = "رصاص خفيف",
        image = "https://archive.org/download/cuffs/np_pistol-ammo.png", 
        isAttachment = false,
        threshold = 0,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 30, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 40, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        }
    },
    rifle_ammo = {
        item = "rifle_ammo",
        label = "رصاص ثقيل",
        image = "https://archive.org/download/cuffs/np_rifle-ammo.png", 
        isAttachment = false,
        threshold = 0,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 60, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        }
    },
    weapon_handcuffs = {
        item = "handcuffs",
        label = "كلبشات",
        image = "https://archive.org/download/cuffs/cuffs.png", 
        isAttachment = false,
        threshold = 0,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 80, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        }
    },
    weapon_pistol = {
        item = "weapon_pistol",
        label = "Walther P99",
        image = "https://archive.org/download/cuffs/pistol-old.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    },
    weapon_pistol_mk2 = {
        item = "weapon_pistol_mk2",
        label = "Pistol MK2",
        image = "https://archive.org/download/cuffs/weapon_combat-pistol.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://cdn.discordapp.com/attachments/1188949169981902898/1200691386949845053/np_blueprint.png"
    },
    weapon_heavypistol = {
        item = "weapon_heavypistol",
        label = "Heavy Pistol",
        image = "https://archive.org/download/cuffs/np_heavy-pistol.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    },
    weapon_pistol50 = {
        item = "weapon_pistol50",
        label = "Pistol .50",
        image = "https://archive.org/download/cuffs/np_pistol-50.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    },
    weapon_microsmg = {
        item = "weapon_microsmg",
        label = "Micro SMG",
        image = "https://archive.org/download/cuffs/micro-smg.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    },
    weapon_gusenberg = {
        item = "weapon_gusenberg",
        label = "Thompson SMG",
        image = "https://archive.org/download/cuffs/weapon_gusenberg.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    },
    weapon_assaultrifle = {
        item = "weapon_assaultrifle",
        label = "AK47",
        image = "https://archive.org/download/cuffs/weapon_assault-rifle.png",
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
            {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
            {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
            {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
            {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
            {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
            {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
            {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
        },
        blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    },
}

--Recipes that are unlocked with blueprints
Config.blueprintRecipes = {
    --weapon_pistol50 = {
    --    item = "weapon_pistol50",
    --    label = "Pistol .50",
    --    image = "https://archive.org/download/cuffs/np_pistol-50.png",
    --    isAttachment = false,
    --    threshold = 0,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    --},
    --weapon_microsmg = {
    --    item = "weapon_microsmg",
    --    label = "Micro SMG",
    --    image = "https://archive.org/download/cuffs/micro-smg.png",
    --    isAttachment = false,
    --    threshold = 0,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
    --weapon_gusenberg = {
    --    item = "weapon_gusenberg",
    --    label = "Thompson SMG",
    --    image = "https://archive.org/download/cuffs/weapon_gusenberg.png",
    --    isAttachment = false,
    --    threshold = 0,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
    --weapon_assaultrifle = {
    --    item = "weapon_assaultrifle",
    --    label = "AK47",
    --    image = "https://archive.org/download/cuffs/weapon_assault-rifle.png",
    --    isAttachment = false,
    --    threshold = 0,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
    --weapon_pistol = {
    --    item = "weapon_pistol",
    --    label = "Walther P99",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200691827372740708/weapon_pistol_2.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 100, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    --},
    --weapon_pistol_mk2 = {
    --    item = "weapon_pistol_mk2",
    --    label = "Pistol MK2",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200689360723517541/weapon_combat-pistol.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 110, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://cdn.discordapp.com/attachments/1188949169981902898/1200691386949845053/np_blueprint.png"
    --},
    --weapon_heavypistol = {
    --    item = "weapon_heavypistol",
    --    label = "Heavy Pistol",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200698709026033735/np_heavy-pistol.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 120, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    --},
    --weapon_pistol50 = {
    --    item = "weapon_pistol50",
    --    label = "Pistol .50",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200698520303304754/weapon__pistol-50.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 130, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/np_blueprint.png"
    --},
    --weapon_microsmg = {
    --    item = "weapon_microsmg",
    --    label = "Micro SMG",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200699051214131301/micro_smg.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 140, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
    --weapon_gusenberg = {
    --    item = "weapon_gusenberg",
    --    label = "Thompson SMG",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200699204390101064/weapon_gusenberg.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
    --weapon_assaultrifle = {
    --    item = "weapon_assaultrifle",
    --    label = "AK47",
    --    image = "https://cdn.discordapp.com/attachments/1188949169981902898/1200689560699543612/weapon_assaultrifle_2.png",
    --    isAttachment = false,
    --    points = 1,
    --    components = {
    --        {item = "aluminum", label = "الومينيوم", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574977179656292/np_aluminum.png"},
    --        {item = "rubber", label = "مطاط", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574755468746793/np_rubber.png"},
    --        {item = "metalscrap", label = "خردة معدنية", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574805561315349/scrap_metal.png"},
    --        {item = "copper", label = "نحاس", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574909978521660/np_copper.png"},
    --        {item = "iron", label = "حديد", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200574856996073562/iron.png"},
    --        {item = "steel", label = "فولاذ", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575261037563954/steel_2.png"},
    --        {item = "glass", label = "زجاج", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575037967716479/np_glass.png"},
    --        {item = "plastic", label = "بلاستيك", amount = 150, image = "https://cdn.discordapp.com/attachments/1187754760795865088/1200575008502730822/plastic_2.png"},
    --    },
    --    blueprintImage = "https://archive.org/download/bp_weapon_pistol/bp_weapon_pistol.png"
    --},
}

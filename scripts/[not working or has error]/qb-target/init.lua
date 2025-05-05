function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 2.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = true

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = { 255, 255, 255, 255 }

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = { 0, 255, 206, 255 }

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = { 255, 255, 255, 255 }

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = false

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-- Whether to disable ALL controls or only specificed ones
Config.DisableControls = true

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {
	["lspd-duty-reports"] = {
		name = "pd_duty",
		coords = vector3(441.99, -981.96, 30.69),
		radius = 0.85,
		useZ=false,
		debugPoly = false,
		options = {
			{
				event = "qb-policejob:ToggleDuty",
				icon = "fas fa-circle",
				label = "تسجيل دخول/خروج ",
				job = "police",
			},
			--{
			--	event = "qb-phone:client:addPoliceAlert",
			--	icon = "fas fa-circle",
			--	label = " تقديم بلاغ ",
			--	job = {["police"] = 0, ["sheriff"] = 0,["unemployed"] = 0,["ambulance"] = 0,["judge"] = 0,["lawyer"] = 0,["bus"] = 0,["reporter"] = 0,["trucker"] = 0,["tow"] = 0,["garbage"] = 0,
			--			["vineyard"] = 0,["hotdog"] = 0,["realestate"] = 0,["taxi"] = 0,["cardealer"] = 0,["mechanic"] = 0,["mechanic2"] = 0,["mechanic3"] = 0,["beeker"] = 0,["bennys"] = 0},
			--},
		},
		distance = 3.5
	},
	["weapReg"] = {
		name = "registerWeapon",
		coords = vector3(483.27, -999.45, 31.6),
		radius = 0.5,
		debugPoly = false,
		options = {
		  {
			type = "client",
			event = "ps-mdt:client:selfregister",
			icon = 'fas fa-circle', -- This is the icon that will display next to this trigger option
			label = 'ترخيص السلاح',
			job = "police",
		  }
		},
		distance = 2.5,
	  },
}
  
Config.BoxZones = {
			["lspd-menu"] = {
				   name = "pd_bossmenu",
				   coords = vector3(461.35, -986.46, 30.73),
				   length = 1.2,
				   width = 2,
				   heading = 0,
				   debugPoly = false,
				   minZ = 25.8,
				   maxZ = 31.0,
				   options = {
					   {
						   event = "qb-bossmenu:client:OpenMenu",
						   icon = "fas fa-circle",
						   label = "المكتب",
						   job = {["police"] = 8,9,10,11,12,13,14,15,16,17,18,19},
					   },
				   },
				   distance = 3.5
			   },
			   
			--["lspd-clo"] = {
			--	name = "pd_clothing",
			--	coords = vector3(461.95, -995.63, 30.69),
			--	length = 4.4,
			--	width = 1,
			--	heading = 270,
			--	debugPoly = false,
			--	minZ = 29.29,
			--	maxZ = 33.29,
			--	options = {
			--		{
			--			event = "qb-clothing:client:openMenu",
			--			icon = "fas fa-circle",
			--			label = "الملابس",
			--			job = "police",
			--		},
			--	},
			--	distance = 3.5
			--},
			--["lspd-clo2"] = {
			--	name = "pd_clothing2",
			--	coords = vector3(461.95, -1000.23, 30.69),
			--	length = 1.0,
			--	width = 6,
			--	heading = 0,
			--	debugPoly = false,
			--	minZ = 29.49,
			--	maxZ = 33.49,
			--	options = {
			--		{
			--			event = "qb-clothing:client:openMenu",
			--			icon = "fas fa-circle",
			--			label = "الملابس",
			--			job = "police",
			--		},
			--	},
			--	distance = 3.5
			--},
			["ems-menu"] = {
				name = "ems_bossmenu",
				coords = vector3(335.73, -594.15, 43.28),
				length = 1.2,
				width = 1.5,
				heading = 250,
				debugPoly = false,
				--minZ = 25.8,
				--maxZ = 31.0,
				options = {
					{
						event = "qb-bossmenu:client:OpenMenu",
						icon = "fas fa-circle",
						label = "المكتب",
						job = {["ambulance"] = 5,6,},
					},
				},
				distance = 3.5
			},
			["ems-clo"] = {
				name = "ems_clothing",
				coords = vector3(302.18, -599.56, 43.28),
				length = 3.2,
				width = 1,
				heading = 340,
				debugPoly = false,
				--minZ = 29.49,
				--maxZ = 33.49,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						job = "ambulance",
					},
				},
				distance = 3.5
			},
			-----------------------------------
			["burger-clo"] = {
				name = "burgershot_clothing",
				coords = vector3(-1184.9, -899.32, 13.98),
				length = 2.6,
				width = 1,
				heading = 35,
				debugPoly = false,
				minZ = 11.98,
				maxZ = 15.98,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						job = "burgershot",
					},
				},
				distance = 3.5
			},
			-----------------------------------
			["lostmc"] = {
				name = "lostmc_clothing",
				coords = vector3(987.18, -93.36, 74.85),
				length = 2.2,
				width = 0.3,
				heading = 315,
				debugPoly = false,
				--minZ = 29.49,
				--maxZ = 33.49,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						gang = "lostmc",
					},
				},
				distance = 3.5
			},
			["crips"] = {
				name = "crips_clothing",
				coords = vector3(-330.15, 84.51, 54.02),
				length = 1.6,
				width = 3,
				heading = 359,
				debugPoly = false,
				--minZ = 27.52,
				--maxZ = 31.52,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						gang = "crips",
					},
				},
				distance = 3.5
			},
			["ballas"] = {
				name = "ballas_clothing",
				coords = vector3(117.45, -1964.65, 21.33),
				length = 1.5,
				width = 0.6,
				heading = 290,
				debugPoly = false,
				minZ = 18.73,
				maxZ = 22.73,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						gang = "ballas",
					},
				},
				distance = 3.5
			},
			["vagos"] = {
				name = "vagos_clothing",
				coords = vector3(343.05, -2020.29, 22.39),
				length = 1.4,
				width = 0.6,
				heading = 320,
				debugPoly = false,
				minZ = 19.79,
				maxZ = 23.79,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						gang = "vagos",
					},
				},
				distance = 3.5
			},
			["bloods"] = {
				name = "bloods_clothing",
				coords = vector3(-1559.45, -405.37, 48.26),
				length = 1.4,
				width = 0.7,
				heading = 49,
				debugPoly = false,
				minZ = 45.86,
				maxZ = 49.86,
				options = {
					{
						event = "qb-clothing:client:openMenu",
						icon = "fas fa-circle",
						label = "الملابس",
						gang = "bloods",
					},
				},
				distance = 3.5
			},
			---------------------------------
			["depot"] = {
				name = "pd_depot",
				coords = vector3(452.31, -999.84, 30.69),
				length = 2.2,
				width = 1,
				heading = 90,
				debugPoly = false,
				minZ = 27.09,
				maxZ = 31.09,
				options = {
					{
						event = "police:client:ImpoundMenuHeader",
						icon = "fas fa-circle",
						label = "المركبات المحجزوة",
						job = "police",
					},
				},
				distance = 1.5
			},
			["craft"] = {
				name = "crafting",
				coords = vector3(1130.14, -2005.1, 35.44),
				length = 4,
				width = 1,
				heading = 234.45,
				debugPoly = false,
				--minZ = 29.49,
				--maxZ = 33.49,
				options = {
					{
						event = "inventory:client:craftTarget",
						icon = "fas fa-circle",
						label = "تصنيع",
						job = "all",
					},
				},
				distance = 1.5
			},
			["money"] = {
				name = "moneywash",
				coords = vector3(-210.64, 6234.06, 31.79),
				length = 5.4,
				width = 1,
				heading = 45,
				debugPoly = false,
				minZ = 28.79,
				maxZ = 32.79,
				options = {
					{
						event = "qb-pawn:client:openMenu",
						icon = "fas fa-circle",
						label = "غسيل الفلوس",
						job = "all",
					},
				},
				distance = 1.5
			},
		}

Config.PolyZones = {

}

Config.TargetBones = {
    ["main"] = {
        bones = {
            "seat_dside_f",
            "seat_pside_f",
            "seat_dside_r",
            "seat_pside_r",
            "door_dside_f",
            "door_dside_r",
            "door_pside_f",
            "door_pside_r",
            "hbgrip_l",
            "hbgrip_r"
        },
        options = {
            {
                type = "client",
                event = "police:client:PutPlayerInVehicle",
                icon = "fas fa-circle",
                label = "ادخال في المركبة",
                
            },
            {
                type = "client",
                event = "police:client:SetPlayerOutVehicle",
                icon = "fas fa-circle",
                label = "اخراج من المركبة",
            },
            {
                type = "client",
                event = "dynyx-impound:client:OpenImpoundMenu",
                icon = "fas fa-circle",
                label = "حجز الشرطة",
                job = "police",
            },
			
        },
        distance = 3.0
    },

}

Config.TargetModels = {

}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {
	options = {
		{
			type = "client",
			event = "police:client:SearchPlayer",
			icon = "fas fa-circle", 
			label = "تفتيش",
			job = 'police',
		},
		{
			type = "client",
			event = "vehiclekeys:client:GiveKeys",
			icon = "fas fa-circle", 
			label = "اعطاء مفتاح المركبة",
		},
		{
			type = "client",
			event = "qb-phone:client:GiveContactDetails",
			icon = "fas fa-circle", 
			label = "اعطاء رقم الهاتف",
		},
		{
			type = "client",
			event = "qb-givecash:Client:Open",
			icon = "fas fa-circle", 
			label = "اعطاء مبلغ",
		},
		{
			type = "client",
			event = "police:client:RobPlayer",
			icon = "fas fa-circle", 
			label = "سرقة الشخص",
		},
		{
			type = "client",
			event = "A5:Client:TakeHostage",
			icon = "fas fa-circle", 
			label = "اخذ رهينة",
		},
	}
}

Config.Peds = {
	{
        model = `g_m_y_salvaboss_01`,
        coords = vector4(-215.39, 6232.08, 31.24, 161.06),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'PROP_HUMAN_SEAT_CHAIR',
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-pawnshop:client:openMenu",
                    icon = "fas fa-circle",
                    label = " بيع الاغراض ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `ig_thornton`,
        coords = vector4(-51.78, -790.71, 44.23, 334.48),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-rental:openMenu",
                    icon = "fas fa-circle",
                    label = " استئجار مركبة ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `ig_thornton`,
        coords = vector4(-261.46, -1029.21, 28.36, 240.51),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-rental:openMenu1",
                    icon = "fas fa-circle",
                    label = " استئجار دراجة ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `s_f_y_scrubs_01`,
        coords = vector4(-1830.0, -380.63, 49.4, 51.68),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "snw-pharmacy:client:openShop",
                    icon = "fas fa-circle",
                    label = " الصيدلية ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `s_f_y_scrubs_01`,
        coords = vector4(318.24, -1078.4, 29.48, 9.58),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "snw-pharmacy:client:openShop",
                    icon = "fas fa-circle",
                    label = " الصيدلية ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `s_f_y_scrubs_01`,
        coords = vector4(70.79, -813.82, 31.33, 252.69),
		minusOne = true,
        networked = true,
        invincible = true,
        blockevents = true,
		freeze = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "snw-pharmacy:client:openShop",
                    icon = "fas fa-circle",
                    label = " الصيدلية ",
                    job = "all",
                },
            },
            distance = 2.5
        }
    },
	{
        model = `s_f_y_scrubs_01`,
        coords = vector4(-1852.69, -335.4, 49.45, 96.49),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
        target = {
            options = {
            },
            distance = 2.5
        }
    },
}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function JobTypeCheck() return true end
local function ItemCheck() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		local timeout = 0
		while state ~= 'started' and timeout <= 100 do
			timeout += 1
			state = GetResourceState('qb-core')
			Wait(0)
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCheck = QBCore.Functions.HasItem

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		JobTypeCheck = function(jobType)
			if type(jobType) == 'table' then
				jobType = jobType[PlayerData.job.type]
				if jobType then
					return true
				end
			elseif jobType == 'all' or jobType == PlayerData.job.type then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.excludejob and JobCheck(data.excludejob) then return false end
	if data.jobType and not JobTypeCheck(data.jobType) then return false end
	if data.excludejobType and JobTypeCheck(data.excludejobType) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.excludegang and GangCheck(data.excludegang) then return false end
	if data.item and not ItemCheck(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end

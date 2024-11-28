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
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = true

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- Draw a Sprite on the center of a PolyZone to hint where it's located
Config.DrawSprite = true

-- The default distance to draw the Sprite
Config.DrawDistance = 10.0

-- The color of the sprite in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.DrawColor = { 0, 255, 206, 255 }

-- The color of the sprite in rgb when the PolyZone is targeted, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.SuccessDrawColor = { 255, 206, 255, 255 }

-- The color of the outline in rgb, the first value is red, the second value is green, the third value is blue and the last value is alpha (opacity). Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = { 0, 255, 206, 255 }

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
	["weapReg"] = {
		name = "registerWeapon",
		coords = vector3(-1099.68, -825.52, 14.28),
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
	["weapReg1"] = {
		name = "registerWeapon1",
		coords = vector3(-435.2, 6007.19, 31.38),
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
	["rec"] = {
		name = "dutyrec",
		coords = vector3(1203.59, -3266.82, 5.5),
		length = 2,
		width = 1,
		heading = 90,
		debugPoly = false,
		minZ = 1.9,
		maxZ = 5.9,
		options = {
			{
				event = "qb-recyclejob:client:target:toggleDuty",
				icon = "fas fa-circle",
				label = "تسجيل دخول",
				job = "all",
			},
		},
		distance = 1.5
	},
	["rec2"] = {
		name = "pickup",
		coords = vector3(1229.03, -3275.31, 5.5),
		length = 3,
		width = 1,
		heading = 90,
		debugPoly = false,
		minZ = 3.1,
		maxZ = 7.1,
		options = {
			{
				event = "qb-recyclejob:client:target:dropPackage",
				icon = "fas fa-circle",
				label = "تسليم الطرد",
				job = "all",
			},
		},
		distance = 1.5
	},
	["rec3"] = {
		name = "pickup2",
		coords = vector3(1225.59, -3275.44, 5.5),
		length = 3,
		width = 1,
		heading = 90,
		debugPoly = false,
		minZ = 3.1,
		maxZ = 7.1,
		options = {
			{
				event = "qb-recyclejob:client:target:dropPackage",
				icon = "fas fa-circle",
				label = "تسليم الطرد",
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
                event = "impound:client:OpenImpoundMenu",
                icon = "fas fa-circle",
                label = "حجز",
				job = "police",
            },
        },
        distance = 3.0
    },
	{
		type = "client",
		event = "cdn-fuel:client:SendMenuToServer",
		icon = "fas fa-gas-pump",
		label = "Insert Nozzle",
		canInteract = function() return Allowrefuel end
	},
	{
		type = "client",
		action = function()
			TriggerEvent('cdn-fuel:client:electric:RefuelMenu')
		end,
		icon = "fas fa-bolt",
		label = "Insert Electric Nozzle",
		canInteract = function() return AllowElectricRefuel end
	},
}

Config.TargetModels = {
	["TrailerRental"] = {
		models = { `S_F_M_Autoshop_01`,
			},
			options = {
			{
				type = "client",
				event = "az-trailer:openMenu",
				icon = "fas fa-car",
				label = "Rent Trailer",
			},
		},
			distance = 4.0
	},
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
			event = "qb-phone:client:GiveContactDetails",
			icon = "fas fa-circle", 
			label = "اعطاء رقم الهاتف",
		},
		{
			type = "client",
			event = "givecash:Client:Open",
			icon = "fas fa-circle", 
			label = "اعطاء مبلغ",
		},
		{
			type = "client",
			event = "police:client:RobPlayer",
			icon = "fas fa-circle", 
			label = "سرقة الشخص",
		},
	}
}

Config.Peds = {
	{
        model = `g_m_y_salvaboss_01`,
        coords = vector4(-216.68, 6227.52, 31.79, 18.01),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_AA_SMOKE',
        target = {
            options = {
            },
            distance = 2.5
        }
    },
	{
        model = `g_m_y_salvaboss_01`,
        coords = vector4(5401.84, -5169.69, 31.38, 179.31),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_AA_SMOKE',
        target = {
            options = {
            },
            distance = 2.5
        }
    },
	{
        model = `s_m_y_cop_01`,
        coords = vector4(426.8, -972.98, 25.7, 223.24),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_COP_IDLES',
        target = {
            options = {
            },
            distance = 2.5
        }
    },
	{
        model = `s_m_y_cop_01`,
        coords = vector4(1828.18, 3671.57, 34.34, 298.61),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_COP_IDLES',
        target = {
            options = {
            },
            distance = 2.5
        }
    },
	{
        model = `s_m_y_cop_01`,
        coords = vector4(-441.29, 5994.47, 31.49, 86.71),
		minusOne = true,
        invincible = true,
        blockevents = true,
		freeze = true,
		scenario = 'WORLD_HUMAN_COP_IDLES',
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
			timeout = timeout + 1
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

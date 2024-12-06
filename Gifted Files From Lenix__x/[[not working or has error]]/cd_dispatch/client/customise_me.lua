local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/'..Config.CommandName, 'Callsign for the dispatch', {{ name="action", help='[show / set / delete]'}, { name="callsign", help='Enter the name of your chosen callsign'}})
end)

Config.Client_Locales = { --Customise the client sided notification message.
    ['EN'] = {
        ['cooldown'] = 'There is a 1 second cooldown when pressing G to avoid issues',
    },

    ['FR'] = {
        ['cooldown'] = 'Le nom ne peut pas dépasser 10 caractères',
    },

    ['ES'] = {
        ['cooldown'] = 'El nombre no puede tener más de 10 caracteres',
    },
}

RegisterNetEvent('cd_dispatch:Error_Notification')
AddEventHandler('cd_dispatch:Error_Notification', function(message)
    if Config.ClientNotification_Type == 'chat' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> <i class="fas fa-house-user"></i> <b>PERSONAL SPAWN :</b> '..message})
    elseif Config.ClientNotification_Type == 'custom' then
        --enter custom notification here
    end
end)

function BlipSound(sound)
    if sound == 1 then
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 2 then
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 3 then 
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
        Wait(900)
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    elseif sound == 4 then 
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'panic', 0.5)
    end
end










------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------- CHAT COMMANDS (OPTIONAL) Remove/hash our if you don not want to use these. ----------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
local playAnim = false
local phoneProp = 0
local phoneModel = Config.PhoneModel


-- Item checks to return whether or not the client has a phone or not
local function HasPhone()
    return QBCore.Functions.HasItem("phone")
end


-- Loads the animdict so we can execute it on the ped
local function loadAnimDict(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function DeletePhone()
	if phoneProp ~= 0 then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

local function NewPropWhoDis()
	DeletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Wait(1)
	end
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)

	local bone = GetPedBoneIndex(PlayerPedId(), 28422)
	if phoneModel == Config.PhoneModel then
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 15.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

-- Does the actual animation of the animation when calling 911
local function PhoneCallAnim()
    loadAnimDict("cellphone@")
    local ped = PlayerPedId()
    CreateThread(function()
        NewPropWhoDis()
        playAnim = true
        while playAnim do
            if not IsEntityPlayingAnim(ped, "cellphone@", 'cellphone_text_to_call', 3) then
                TaskPlayAnim(ped, "cellphone@", 'cellphone_text_to_call', 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(100)
        end
    end)
end

local hasSentpanic = false
local charname = nil
local charnumber = nil
local phoneBox = {
    {'prop_phonebox_04'},
    {'p_phonebox_02_s'},
    {'p_phonebox_01b_s'},
    {'prop_phonebox_01a'},
    {'prop_phonebox_01b'},
    {'prop_phonebox_01c'},
    {'prop_phonebox_02'},
    {'prop_phonebox_03'},
}

local JobsTable = {
    ['police'] = {CommandName = '911s', Job = 'police'},
	['ambulance'] = {CommandName = '911ems', Job = 'ambulance'},
	['cardealer'] = {CommandName = 'cardealer', Job = 'cardealer'},
	['realestate'] = {CommandName = 'realestate', Job = 'realestate'},
	['taxi'] = {CommandName = 'taxi', Job = 'taxi'},
}

RegisterNetEvent('cd_dispatch:GetCharName')
AddEventHandler('cd_dispatch:GetCharName', function(charname2)
    charname = charname2
end)

RegisterNetEvent('cd_dispatch:GetCharNumber')
AddEventHandler('cd_dispatch:GetCharNumber', function(charnumber2)
    charnumber = charnumber2
end)

Citizen.CreateThread(function()
    for k, v in pairs(JobsTable) do
        TriggerEvent('chat:addSuggestion', '/'..v.CommandName, 'Send a call to any available '..v.Job:gsub("^%l", string.upper)..' - They will recieve your location.', {{ name='message', help='Enter the message to send (In Character)'}})
    end
    TriggerEvent('chat:addSuggestion', '/reply', 'Reply to a dispatch call', {{ name='callerid', help='ID of the caller (server ID)'}, { name='message', help='Enter the message to send (In Character)'}})
end)

for k, v in pairs(JobsTable) do
    RegisterCommand(v.CommandName, function(source, args)
        local ped = GetPlayerPed(-1)
        local message = table.concat(args, ' ')
        if not exports['Goat-police']:IsHandcuffed() then
            if HasPhone() then
                PhoneCallAnim()
                Wait(math.random(3,8) * 1000)
                playAnim = false
                if args[1] ~= nil then
                    while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
                    while charnumber == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharNumber') end
                    TriggerServerEvent('cd_dispatch:CallCommand', {job = v.Job, message = message, charnumber = charnumber, charname = charname, callinfo = exports['cd_dispatch']:GetPlayerInfo()})
                    Wait(1000)
                    DeletePhone()
                    StopEntityAnim(PlayerPedId(), 'cellphone_text_to_call', "cellphone@", 3)
                else
                    QBCore.Functions.Notify('Please enter your message to be sent to the '..v.Job, "error")
                end
            else
                QBCore.Functions.Notify("You can't call without a Phone!", "error", 4500)
            end
        else
            QBCore.Functions.Notify("You can't call police while handcuffed!", "error", 4500)
        end
    end)
end

RegisterCommand('reply', function(source, args)
    local job = GetJob()
    if JobsTable[job] ~= nil then
        local ped = GetPlayerPed(-1)
        local targetid = args[1]

        if type(args) == 'table' then  -- Check if args is a table
            local message = table.concat(args, ' ')

            if targetid ~= nil then
                if #message > 0 then
                    while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
                    TriggerServerEvent('cd_dispatch:CallCommand:Reply', { job = job, targetid = targetid, message = message, charname = charname })
                else
                    QBCore.Functions.Notify('Enter the message to send', "error")
                end
            else
                QBCore.Functions.Notify('Enter a player ID', "error")
            end
        else
            QBCore.Functions.Notify('Invalid command usage', "error")
        end
    else
        QBCore.Functions.Notify('You do not have permission to use this command', "error", 10000)
    end
end)


RegisterCommand('panic', function(source, args)
    if not hasSentpanic then
        local job = GetJob()
        if job == 'police' then
            hasSentpanic = true
            while charname == nil do Wait(500) TriggerServerEvent('cd_dispatch:GetCharName') end
            TriggerServerEvent('cd_dispatch:CallCommand:Panic', {job = job, charname = charname, callinfo = exports['cd_dispatch']:GetPlayerInfo()})
            PlayAnimation('random@arrests', 'generic_radio_chatter', 1000)
            Wait(30000)
            hasSentpanic = false
        else
            QBCore.Functions.Notify('You do not have permission to use this command', "error", 10000)
            print("You do not have permission to use this command")
        end
    else
        QBCore.Functions.Notify('You dont need to spam this', "error")
    end
end)

function PlayAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end




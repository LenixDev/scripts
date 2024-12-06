local QBCore = exports['qb-core']:GetCoreObject()

Config.Server_Locales = { --Customise the server sided notification message.
    ['EN'] = {
        ['callsign_show'] = 'CALLSIGN :',
        ['callsign_empty_1'] = 'You do not have a callsign set',
        ['callsign_set'] = 'CALLSIGN : You have set your callsign to',
        ['callsign_empty_2'] = 'The callsign can not be empty',
        ['callsign_deleted'] = 'Your callsign has been deleted',
        ['callsign_invalidformat'] = 'Invalid format (show / set / delete)',
        ['callsign_invalidperms'] = 'You do not have permission to set a callsign',
    },

    ['FR'] = {
        ['callsign_show'] = 'SIGNE D\'APPEL :',
        ['callsign_empty_1'] = 'Vous n\'avez pas défini d\'indicatif',
        ['callsign_set'] = 'CALLSIGN: vous avez défini votre indicatif sur',
        ['callsign_empty_2'] = 'L\'indicatif ne peut pas être vide',
        ['callsign_deleted'] = 'Votre indicatif a été supprimé',
        ['callsign_invalidformat'] = 'Format non valide (afficher / définir / supprimer)',
        ['callsign_invalidperms'] = 'Vous n\'êtes pas autorisé à définir un indicatif d\'appel',
    },

    ['ES'] = {
        ['callsign_show'] = 'SEÑAL DE LLAMADA :',
        ['callsign_empty_1'] = 'No tienes un indicativo establecido',
        ['callsign_set'] = 'SEÑAL DE LLAMADA: Ha configurado su indicativo de llamada en',
        ['callsign_empty_2'] = 'El indicativo no puede estar vacío',
        ['callsign_deleted'] = 'Su indicativo ha sido eliminado',
        ['callsign_invalidformat'] = 'Formato no válido (mostrar / configurar / eliminar)',
        ['callsign_invalidperms'] = 'No tienes permiso para establecer un indicativo',
    },
}

function Success_Notification(source, message, input1)
    if Config.ServerNotification_Type == 'chat' then
        if input1 ~= nil then
            TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message..' '..input1})
        else
            TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message info"> <div class="chat-message-header"> '..message})
        end
    elseif Config.ServerNotification_Type == 'custom' then
        if input1 ~= nil then
            --enter custom notification here
        else
            --enter custom notification here
        end
    end
end

function Error_Notification(source, message)
    if Config.ServerNotification_Type == 'chat' then
        TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> '..message})
    elseif Config.ServerNotification_Type == 'custom' then
        --enter custom notification here
    end
end

RegisterServerEvent('dispatch:GetRadioChannel') --If you wish to use the radio channels then you trigger this event in your radio script everytime a player switches radios
AddEventHandler('dispatch:GetRadioChannel', function(radio_channel_2)
    if Config.UseRadio then
        GlobalInfo[source].radio_channel = tostring(radio_channel_2)
    end
end)

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------- CHAT COMMANDS (OPTIONAL) Remove/hash our if you don not want to use these. ----------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
RegisterServerEvent('cd_dispatch:GetCharName')
AddEventHandler('cd_dispatch:GetCharName', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local fullname = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ''
    TriggerClientEvent('cd_dispatch:GetCharName', src, fullname)
end)

RegisterServerEvent('cd_dispatch:GetCharNumber')
AddEventHandler('cd_dispatch:GetCharNumber', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local number = Player.PlayerData.charinfo.phone
    TriggerClientEvent('cd_dispatch:GetCharNumber', src, number)
end)

RegisterServerEvent('cd_dispatch:CallCommand')
AddEventHandler('cd_dispatch:CallCommand', function(t)
    local _source = source

    if t and t.job and t.message and t.charnumber and t.charname and t.callinfo then
        local xPlayer = QBCore.Functions.GetPlayer(_source)
        local name = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
        local jobname = xPlayer.PlayerData.job.name

        -- local xPlayers = QBCore.Functions.GetPlayers()
        -- local OnDuty = 0
        -- for i = 1, #xPlayers do
        --     print("t.job: "..t.job)
        --     local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        --     if xPlayer.job.name == t.job then
        --         OnDuty = OnDuty + 1
        --     end
        -- end

        -- if OnDuty >= 1 then
            TriggerClientEvent('chat:addMessage', _source, {
                template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>Call to the '..jobname..' sent :</b> '..t.message,
            })
            TriggerClientEvent('cd_dispatch:AddNotification', -1, {
                job = t.job,
                coords = t.callinfo.coords,
                title = 'إرسال - مكالمة واردة',
                message = 'From '..t.charname..', #' ..t.charnumber.. ' ' ..'(' .._source..') at '..t.callinfo.street_1..', '..t.callinfo.street_2..' : '..t.message,
                flash = 0,
                blip = {
                    sprite = 487,
                    scale = 1.5,
                    colour = 3,
                    flashes = true,
                    text = jobname..' Call',
                    time = (5 * 60 * 1000), -- 5 mins
                    sound = 1,
                }
            })
        -- else
        --     TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'No '..jobname..' on duty to respond'})
        -- end
    else
        print('cd_dispatch:CallCommand - Invalid data received')
    end
end)

-- RegisterServerEvent('cd_dispatch:CallCommand:Reply')
-- AddEventHandler('cd_dispatch:CallCommand:Reply', function(t)
--     local _source = source

--     -- Validate target player ID
--     local targetPlayer = QBCore.Functions.GetPlayer(t.targetid)
--     print("t.targetid", t.targetid)
--     if not targetPlayer then
--         print("Invalid ID - This player is not online")
--         return
--     end

--     local name = GetPlayerName(t.targetid)
--     local jobname = (t.job:gsub("^%l", string.upper))

--     if name ~= nil then
-- 		local xPlayers = QBCore.Functions.GetPlayers()
-- 		for i = 1, #xPlayers do
--             local xPlayer = QBCore.Functions.GetPlayer(t.targetid)
--             local jobname = xPlayer.PlayerData.job.name
--             print("....."..t.job)
-- 			if jobname == t.job then
-- 				TriggerClientEvent('chat:addMessage', xPlayer.source, {
-- 				template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>'..jobname..' reply</b> from '..t.charname..' sent to <b>('..t.targetid..') : </b>'..t.message})
-- 			end
-- 		end
-- 		TriggerClientEvent('chat:addMessage', t.targetid, {
-- 		template = '<div class="chat-message police"> <div class="chat-message-header"> <class="chat-message-body"> <b>Reply</b> from <b>Police </b> ('..t.charname..') <b>:</b> '..t.message})
-- 	else
-- 		TriggerClientEvent('mythic_notify:client:SendAlert:long', _source, { type = 'error', text = 'Invalid ID - This player is not online'})
-- 	end
-- end)

RegisterServerEvent('cd_dispatch:CallCommand:Panic')
AddEventHandler('cd_dispatch:CallCommand:Panic', function(t)
	local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local name = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
	local xPlayers = QBCore.Functions.GetPlayers()

	TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = t.job,
        coords = t.callinfo.coords,
        title = 'حالة طورائ',
        message = t.charname..'\'s لقد تم تفعيل حالة طورائ. مطلوب مساعدة عاجلة في '..t.callinfo.street_1..', '..t.callinfo.street_2,
        flash = 1,
        blip = {
            sprite = 58,
            scale = 1.5,
            colour = 3,
            flashes = true,
            text = '911 - حالة طورائ',
            time = (5*60*1000),--5 mins
            sound = 4,
        }
    })
end)

RegisterServerEvent('fleecarobbery')
AddEventHandler('fleecarobbery', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-90 - سرقة بنك فليكا',
        message = 'A '..table.sex..' حالة سرقة بنك فليكا في '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 500, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 2, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - سرقة بنك فلكيا',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)


RegisterServerEvent('paletorobbery')
AddEventHandler('paletorobbery', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-90 - سرقة بنك باليتو',
        message = 'A '..table.sex..' يوجد حالة سرقة بنك باليتو في '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 500, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 12, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - سرقة بنك باليتو',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)

RegisterServerEvent('pacificrobbery')
AddEventHandler('pacificrobbery', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-90 - حالة طوارئ',
        message = 'A '..table.sex..' يوجد حالة طورائ في '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 500, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 5, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - حالة طورائ',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)

RegisterServerEvent('dispatchtest')
AddEventHandler('dispatchtest', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-15 - سرقة بقاله',
        message = 'A '..table.sex..' حالة سرقة بقاله '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 431, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 3, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - سرقة بقاله',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)

RegisterServerEvent('dispatchtestt')
AddEventHandler('dispatchtestt', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-90 - سرقة بيت',
        message = 'A '..table.sex..' حالة سرقة بيت في '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 40, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 3, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - سرقة بيت',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)



RegisterServerEvent('dispatchtesttt')
AddEventHandler('dispatchtesttt', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-90 - سرقة مجوهرات',
        message = 'A '..table.sex..' سرقة مجوهرات في '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 434, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.2, --size of the blip.
            colour = 3, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - سرقة مجوهرات',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).
        }
    })
end)

RegisterServerEvent('shooting')
AddEventHandler('shooting', function(table, customcoords)
    if customcoords ~= nil then
        table.coords = customcoords
    end
  TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job = 'police', --everyone who has this job will recieve this notification.
        coords = table.coords,
        title = '10-11 - اطلاق نار',
        message = 'A '..table.sex..' حالة اطلاق نار '..table.street_1..', '..table.street_2, --you can remove the sex/streets etc if you dont want to display them.
        flash = 0, --set to 1 to make the ui flash, used for panic button calls etc.
        blip = { --blip info.
            sprite = 156, --blips icon - more can be found here https://docs.fivem.net/docs/game-references/blips/.
            scale = 1.5, --size of the blip.
            colour = 4, --colour of the blip - can be found at then bottom of this website page https://docs.fivem.net/docs/game-references/blips/.
            flashes = false, --if set to true the blip will flash, used for more important calls.
            text = '911 - اطلاق نار',
            time = (5*60*1000),--the amount of time until the blip fades (default is 5 mins.)
            sound = 1, --the sound when recieving a notification (1 = 1 sound, 2 = 2 sounds, 3 = 3 sounds, 4 = panic button alert sound).	
        }
    })
end)



local QBCore = exports['qb-core']:GetCoreObject()

-- // IMPORTANT EVENT(S) //

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local gender = QBCore.Functions.GetPlayerData().charinfo.gender
    local model
    if gender == 0 or gender == 'man' then
        model = "mp_m_freemode_01"
    else
        model = "mp_f_freemode_01"
    end
    exports['karma-clothing']:SetModel(model)
    TriggerEvent('qb-clothing:client:loadPlayerClothing' , PlayerData.cid, false)
end)

RegisterNetEvent('qb-clothes:client:CreateFirstCharacter', function()
    TriggerEvent('karma-clothing:firstCharacterMenu', false) -- false = not free , true = free
end)

RegisterNetEvent('karma-clothing:multichar:LoadClothing')
AddEventHandler('karma-clothing:multichar:LoadClothing', function(data, cid,charPed)
    QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(model,antunes)
        exports['karma-clothing']:SetModel(model)
        TriggerEvent('qb-clothing:client:loadPlayerClothing' ,cid or false, charPed or false)
    end, cid)
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing')
AddEventHandler('qb-clothing:client:loadPlayerClothing', function(data, cid, charPed) -- EXAMPLE OF HOW THE PED CLOTHING IS LOADED !!!
    if type(cid) == "table" or not cid then
        local PlayerData = QBCore.Functions.GetPlayerData()
        cid = PlayerData.cid
    end
    QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(charPed, model,antunes)
        QBCore.Functions.TriggerCallback('karma-qb:getPedData', function(charPed, model2,headData)
            if not charPed then
                charPed = PlayerPedId()
            end
            exports['karma-clothing']:LoadPedDefaults(charPed, antunes.customHeadModel)
            if antunes then
                exports['karma-clothing']:ApplyPedClothing(charPed, antunes.drawables, antunes.props, antunes.hairColor, false);
            end
            if headData then
                exports['karma-clothing']:ApplyPedData(charPed, headData.headblend, headData.features, headData.overlays, headData.eyeColor, antunes.customHeadModel);
            end
        end , cid)
    end, cid)
end)
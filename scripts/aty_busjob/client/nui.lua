RegisterNuiCallback("uiLoaded", function(data, cb)
    uiLoaded = true
end)

RegisterNuiCallback("close", function(data, cb)
    menuOpen = false
    SetNuiFocus(false, false)
end)

RegisterNuiCallback("startRoute", function(data, cb)
    SetNuiFocus(false, false)
    local lot = Functions.FIND_EMPTY_LOT()
    
    if lot then
        CurrentJob = data
        firstStart = true
        local vehicle = Functions.CREATE_VEHICLE(lot)
        CurrentJob.Vehicle = vehicle
        menuOpen = false
        jobStarted = true
        local playerName = Config.Framework == "qb" and PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname or PlayerData.firstName .. " " .. PlayerData.lastName
        TriggerServerEvent("aty_busjob:updateWorker", "Starting...", playerName)
        TriggerServerEvent("aty_busjob:addExpedition", data)
        Config.Notify(Translation[Config.Locale].VEHICLE_CREATED, "success", 5000)
    else
        menuOpen = false
        Config.Notify(Translation[Config.Locale].NO_EMPTY_LOT, "error", 5000)
    end
end)

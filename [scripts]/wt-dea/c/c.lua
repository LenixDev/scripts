QBCore = exports['qb-core']:GetCoreObject()
--لا تلعب في شيييي
RegisterCommand('', function()
    TriggerEvent('WT:DEV:Data')
end)

RegisterNetEvent('WT:DEV:PersonalStash', function ()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    local PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "DEA"..PlayerData.citizenid,{
        maxweight = 1000000,
        slots = 50,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "DEA"..PlayerData.citizenid)
end
end)

RegisterNetEvent('WT:DEV:Data', function ()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    local dialog = exports['qb-input']:ShowInput({
        header = "تزوير بطاقة هوية",
        submitText = "تأكيد",
        inputs = {
            {
                text = "اسم الأول",
                name = "firstname",
                type = "text",
                isRequired = true,
            },
            {
                text = "اسم العائلة",
                name = "lastname",
                type = "text",
                isRequired = true,
            },
            {
                text = "الجنسية",
                name = "nationality",
                type = "text",
                isRequired = true,
            },
            {
                text = "تاريخ الميلاد 0000/00/00",
                name = "birthdate",
                type = "text",
                isRequired = true,
            },
        },
    })
    if dialog ~= nil then
        QBCore.Functions.Progressbar("GenreateIDCard", 'جاري طباعة البطاقه', 9000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@heists@prison_heiststation@cop_reactions",
            anim = "cop_b_idle",
            flags = 16,
        }, {}, {}, function()
            StopAnimTask(ped, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 0.7)
            TriggerServerEvent('YWT:DEV:Data', Data)

    end)
    Data = {
        ['citizenid']   = math.random(11111111, 99999999 ),
        ['nationality']   = dialog['nationality'],
        ['birthdate']   = dialog['birthdate'],
        ['lastname']   = dialog['lastname'],
        ['firstname']   = dialog['firstname'],
        ['gender']   = '0',
}


    end
end
end)
    
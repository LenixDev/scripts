--لا تلعب في شيييي
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    onDuty = player.job.onduty
    TriggerServerEvent("DEA:server:UpdateBlips")
    TriggerServerEvent("DEA:server:UpdateCurrentCops")
    if PlayerJob and PlayerJob.name ~= "dea" then
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerServerEvent('DEA:server:UpdateBlips')
    TriggerServerEvent("DEA:server:SetHandcuffStatus", false)
    TriggerServerEvent("DEA:server:UpdateCurrentCops")
    onDuty = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
    if DutyBlips then
        for k, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('Tkae:OnDuty', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
if not onDuty then
exports['qb-menu']:openMenu({
    {
        header = "DEA Duty",
        icon = "fas fa-clipboard-check",
        isMenuHeader = true
    },
    {
        header =' الخدمه',
        txt = 'تسجيل دخول',
        params = {
            event = 'Toggle:Duty',
        }
    },
    })
elseif onDuty then
    exports['qb-menu']:openMenu({
        {
            header = "DEA Duty",
            icon = "fas fa-ballot-ch",
            isMenuHeader = true
        },
        {
            header = 'الخدمه',
            txt = 'خروج من الخدمه',
            params = {
                event = 'Toggle:Duty',
            }
        },
        })
end
if not onDuty then
    exports['qb-menu']:openMenu({
        {
            header = "DEA Duty",
            icon = "fas fa-ballot-ch",
            isMenuHeader = true
        },
        {
            header = "تسجيل دخول / خروج",
            txt = "الخدمة ",
            params = {
                event = 'Toggle:Duty',
            }
        },
        })
elseif onDuty then
        exports['qb-menu']:openMenu({
            {
                header = "DEA Duty",
                icon = "fas fa-ballot-ch",
                isMenuHeader = true
            },
            {
                header = "تسجيل دخول/خروج",
                txt = "الخدمة",
                params = {
                    event = 'Toggle:Duty',
                }
            },
            })
end
end

end)
RegisterNetEvent('Toggle:Duty', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    onDuty = not onDuty
    TriggerServerEvent("DEA:server:UpdateCurrentCops")
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("DEA:server:UpdateBlips")
    end
end)

RegisterNetEvent('DEA:server:UpdateCurrentCops', function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "dea" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("DEA:SetCopCount", -1, amount)
end)

RegisterNetEvent('DEA:client:UpdateBlips', function(players)
    if PlayerJob and (PlayerJob.name == 'dea') and
        onDuty then
        if DutyBlips then
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
        if players then
            for k, data in pairs(players) do
                local id = GetPlayerFromServerId(data.source)
                CreateDutyBlips(id, data.label, data.job, data.location)

            end
        end
    end
end)

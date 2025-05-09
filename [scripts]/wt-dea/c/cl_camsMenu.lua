---لا تلعب في شيييي
RegisterNetEvent('WTMenuCams')
AddEventHandler('WTMenuCams', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    exports['qb-menu']:openMenu({
        {
            header = "DEA Cams",
            txt = "كاميرات جميع الاماكن العامه",
            isMenuHeader = true
        },
        {
            header = "الكاميرات",
            txt = "اماكن الكاميرات",
            params = {
                event = "Cams",
                args = {
                    cam = '1',
                }
            }
        },
        {
            header = "خروج",
            txt = "خروج",
            params = {
                event = "WTDEV-DEA:close",
            }
        },
        })
    end
end)

RegisterNetEvent('DEA:WTDEV:Cams')
AddEventHandler('DEA:WTDEV:Cams', function(DEA)
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    local ped = PlayerPedId()
    local model = GetEntityModel(PlayerPedId())
    local cam = DEA.cam
    if cam == '1' then
        TriggerEvent("DEA:client:ActiveCamera", 1)
    elseif cam == '2' then
        TriggerEvent("DEA:client:ActiveCamera", 2)
    elseif cam == '3' then
        TriggerEvent("DEA:client:ActiveCamera", 3)
    elseif cam == '4' then
        TriggerEvent("DEA:client:ActiveCamera", 4)
    end
    end
end)

RegisterNetEvent('Cams')
AddEventHandler('Cams', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
        exports['qb-menu']:openMenu({
        {
            header = "ALL CAMS",
            icon = "fas fa-camera",
            isMenuHeader = true
        },
        {
            header = "BANK CAM1",
            txt = "Cam 1",
            params = {
                event = "DEA:WTDEV:Cams",
                args = {
                    cam = '1',
                }
            }
        },
        {
            header = "BANK CAM2",
            txt = "Cam 2",
            params = {
                event = "DEA:WTDEV:Cams",
                args = {
                    cam = '2',
                }
            }
        },
        {
            header = "Police station CAM3",
            txt = "Cam 3",
            params = {
                event = "DEA:WTDEV:Cams",
                args = {
                    cam = '3',
                }
            }
        },
        {
            header = "Police station CAM4",
            txt = "Cam 4",
            params = {
                event = "DEA:WTDEV:Cams",
                args = {
                    cam = '4',
                }
            }
        },
        {
            header = "اظغط للخروج❌",
            txt = " خروج",
            params = {
                event = "",
            }
        },
        })
    end
end)



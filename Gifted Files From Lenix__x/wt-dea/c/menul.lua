--لا تلعب في شييي

local inciacenter = false



RegisterNetEvent('DEA:OpenMenu', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    print(inciacenter)
    if not inciacenter  then
        exports['qb-menu']:openMenu({
            {
                header = "القراج",
                isMenuHeader = true
            },
            {
                header = "قائمة المركبات",
                txt = "استخراج المركبات",
                params = {
                    event = "qb-DEAgarage:client:OpenMenu",
                }
            },
        })
else
    
end
end
end)

RegisterNetEvent('qb-DEAgarage:client:OpenMenu', function()
    local player = QBCore.Functions.GetPlayerData()
    local PlayerJob = player.job
    if PlayerJob and (PlayerJob.name == 'dea') then
    exports['qb-menu']:openMenu({
        {
            header = "السيارات",
            icon = "fas fa-car",
            isMenuHeader = true
        },
        {
            header = "Helicopter",
            txt = "هيليكورتر",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.zeroOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucwashington",
            txt = "ucwashington",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.FirstOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucrancher",
            txt = "ucrancher",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.SecondOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucprimo",
            txt = "ucprimo",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.ThridOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "uccoquette",
            txt = "uccoquette",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.FourthOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "uccomet",
            txt = "uccomet",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.onefifth,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucbuffalo",
            txt = "ucbuffalo",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.OneSixth,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucbanshee",
            txt = "ucbanshee",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.SeventhOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
        {
            header = "ucballer",
            txt = "ucballer",
            params = {
                event = "qb-DEAgarage:client:spawnvehicle",
                args = {
                    vehicle = Shorts.Vehicles.EighthOne,
                    CopGrade = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
                }
            }
        },
    })
end
end)
-------------------


--انتبه تلعب في شي من الي تحت

local function SetWeaponSeries()
    for k, v in pairs(Config.Items.items) do
        if Config.Items.items[k].type == "weapon" then 
            Config.Items.items[k].info.serie = 'dea'.. tostring(QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end


RegisterNetEvent('wt-dea:DEAArmory', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    local authorizedItems = {
        label = ('DEA-F.I.B'),
        slots = 30,
        items = {}
    }
    local index = 1
    for _, armoryItem in pairs(Config.Items.items) do
        for i=1, #armoryItem.authorizedJobGrades do
            if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                authorizedItems.items[index] = armoryItem
                authorizedItems.items[index].slot = index
                index = index + 1
            end
        end
    end
    SetWeaponSeries()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "dea", authorizedItems)
end)




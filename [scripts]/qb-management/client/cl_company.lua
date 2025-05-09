local QBCore = exports['qb-core']:GetCoreObject()
local PlayerCompany = {}
local shownBossMenu = false

local function CloseMenuFull()
    exports['qb-menu']:closeMenu()
    shownBossMenu = false
end

local function DrawText3D(v, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerCompany = QBCore.Functions.GetPlayerData().company
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerCompany = QBCore.Functions.GetPlayerData().company
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerCompany = JobInfo
end)

RegisterNetEvent('qb-bossmenu:client:OpenCompanyMenu', function()
    PlayerCompany = QBCore.Functions.GetPlayerData().company
    if PlayerCompany.isowner then 
        shownBossMenu = true
        local bossMenu = {
            {
                header = "Boss Menu - " .. string.upper(PlayerCompany.label),
                isMenuHeader = true,
            },
            {
                header = "Manage Employees",
                txt = "Check your Employees List",
                params = {
                    event = "qb-bossmenu:client:Companyemployeelist",
                }
            },
            {
                header = "Hire Employees",
                txt = "Hire Nearby Civilians",
                params = {
                    event = "qb-bossmenu:client:CompanyHireMenu",
                }
            },
            {
                header = "Money Management",
                txt = "Check your Company Balance",
                params = {
                    event = "qb-bossmenu:client:CompanySocietyMenu",
                }
            },
            {
                header = "Exit",
                params = {
                    event = "qb-menu:CompanycloseMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(bossMenu)
    elseif PlayerCompany.isboss then 
        shownBossMenu = true
        local bossMenu = {
            {
                header = "Boss Menu - " .. string.upper(PlayerCompany.label),
                isMenuHeader = true,
            },
            {
                header = "Manage Employees",
                txt = "Check your Employees List",
                params = {
                    event = "qb-bossmenu:client:Companyemployeelist",
                }
            },
            {
                header = "Hire Employees",
                txt = "Hire Nearby Civilians",
                params = {
                    event = "qb-bossmenu:client:CompanyHireMenu",
                }
            },
            {
                header = "Exit",
                params = {
                    event = "qb-menu:CompanycloseMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(bossMenu)
    end
end)

RegisterNetEvent('qb-bossmenu:client:Companyemployeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerCompany.label),
            isMenuHeader = true,
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:CompanyGetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                params = {
                    event = "qb-bossmenu:client:CompanyManageEmployee",
                    args = {
                        player = v,
                        work = PlayerCompany
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-bossmenu:client:OpenCompanyMenu",
            }
        }
        exports['qb-menu']:openMenu(EmployeesMenu)
    end, PlayerCompany.name)
end)

RegisterNetEvent('qb-bossmenu:client:CompanyManageEmployee', function(data)
    local EmployeeMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerCompany.label),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(QBCore.Shared.Company[data.work.name].grades) do
        EmployeeMenu[#EmployeeMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "qb-bossmenu:server:CompanyGradeUpdate",
                args = {
                    cid = data.player.empSource,
                    grado = tonumber(k),
                    nomegrado = v.name
                }
            }
        }
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        params = {
            isServer = true,
            event = "qb-bossmenu:server:CompanyFireEmployee",
            args = data.player.empSource
        }
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "< Return",
        params = {
            event = "qb-bossmenu:client:OpenCompanyMenu",
        }
    }
    exports['qb-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('qb-bossmenu:client:CompanyStash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerCompany.name, {
        maxweight = 4000000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerCompany.name)
end)

RegisterNetEvent('qb-bossmenu:client:CompanyWardrobe', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-bossmenu:client:CompanyHireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerCompany.label),
            isMenuHeader = true,
        },
    }
    QBCore.Functions.TriggerCallback('qb-bossmenu:Companygetplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    params = {
                        isServer = true,
                        event = "qb-bossmenu:server:CompanyHireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "< Return",
            params = {
                event = "qb-bossmenu:client:OpenCompanyMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qb-bossmenu:client:CompanySocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-bossmenu:server:CompanyGetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_value(cb) .. " - " .. string.upper(PlayerCompany.label),
                isMenuHeader = true,
            },
            {
                header = "Deposit",
                txt = "Deposit Money into account",
                params = {
                    event = "qb-bossmenu:client:CompanySocetyDeposit",
                    args = comma_value(cb)
                }
            },
            {
                header = "Withdraw",
                txt = "Withdraw Money from account",
                params = {
                    event = "qb-bossmenu:client:CompanySocetyWithDraw",
                    args = comma_value(cb)
                }
            },
            {
                header = "< Return",
                params = {
                    event = "qb-bossmenu:client:OpenCompanyMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerCompany.name)
end)

RegisterNetEvent('qb-bossmenu:client:CompanySocetyDeposit', function(money)
    local deposit = exports['qb-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("qb-bossmenu:server:CompanydepositMoney", tonumber(deposit.amount))
        TriggerServerEvent("qb-log:server:CreateLog", "depositbattal", "Deposit Company Balance :  ", "green", "   Added Money : $" .. deposit.amount .. "   New Balance: $ " ..money.. "")
    end
end)

RegisterNetEvent('qb-bossmenu:client:CompanySocetyWithDraw', function(money)
    local withdraw = exports['qb-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qb-bossmenu:server:CompanywithdrawMoney", tonumber(withdraw.amount))
        TriggerServerEvent("qb-log:server:CreateLog", "withdrawbattal", "Withdraw Company Balance :  ", "red", "  Remove Money : $" .. withdraw.amount .. "   New Balance: $ :" ..money.. "")
    end
end)

-- CreateThread(function()
--     while true do
--         local pos = GetEntityCoords(PlayerPedId())
--         local inRangeBoss = false
--         local nearBossmenu = false
--         for k, v in pairs(Config.Jobs) do
--             if k == PlayerJob.name and PlayerJob.isboss then
--                 if #(pos - v) < 5.0 then
--                     inRangeBoss = true
--                     if #(pos - v) <= 1.5 then
--                         if not shownBossMenu then DrawText3D(v, "~b~E~w~ - Open Job Management") end
--                         nearBossmenu = true
--                         if IsControlJustReleased(0, 38) then
--                             TriggerEvent("qb-bossmenu:client:OpenMenu")
--                         end
--                     end
                    
--                     if not nearBossmenu and shownBossMenu then
--                         CloseMenuFull()
--                         shownBossMenu = false
--                     end
--                 end
--             end
--         end
--         if not inRangeBoss then
--             Wait(1500)
--             if shownBossMenu then
--                 CloseMenuFull()
--                 shownBossMenu = false
--             end
--         end
--         Wait(3)
--     end
-- end)

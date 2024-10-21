
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('qb-Pink:server:GetPinkConfig', function(PinkConfig)
        Config.Pink = PinkConfig
    end)
end)


RegisterNetEvent('qb-Pink:client:UpdatePink', function(Info)
    Config.Pink = Info
end)

RegisterNetEvent('qb-Pink:client:RentAppart', function()
    local GlobalConfig = Config.Pink
    local PinkMenu = {
        {
            header = "Pinkcage Motel<br><br>First Payment : $ "..Config.Pink.FirstPayment.."",
            isMenuHeader = true, -- Set to true to make a nonclickable title
            icon = "fa-duotone fa-building-user",
        },
    }
    for k, v in pairs(GlobalConfig.Appartment) do 
        if not v.isOwned then 
            PinkMenu[#PinkMenu + 1] = {
                header = 'Apartment #'..k,
                txt = 'Rent This Apartment For $ '..Config.Pink.Rent..' Per Week',
                icon = "fa-regular fa-building-user",
                params = {
                    event = 'qb-Pink:client:Confirm',
                    args = {
                        appartment = k
                    }
                }
            }
        end
    end
    PinkMenu[#PinkMenu + 1] = {
        header = "Exit",
        icon = "fa-regular fa-circle-xmark",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    if #PinkMenu > 0 then 
        exports['qb-menu']:openMenu(PinkMenu)
    end
end)

RegisterNetEvent('qb-Pink:client:Confirm', function(data)
    local alert = lib.alertDialog({
        header = 'Confirmation',
        content = 'First Payment $ '..Config.Pink.FirstPayment..'\n\n\n\n\n\n\n Then $ '..Config.Pink.Rent..' Per week',
        centered = true,
        cancel = true
    })
    if alert then 
        if alert == 'confirm' then 
            TriggerServerEvent('qb-Pink:server:RentAppart', data)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:Cancel', function(data)
    local alert = lib.alertDialog({
        header = 'Confirmation',
        content = 'Are you sure you want to cancel you apartment contract ?',
        centered = true,
        cancel = true
    })
    if alert then 
        if alert == 'confirm' then 
            TriggerServerEvent('qb-Pink:server:Cancel', data)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:AppartMenu', function(data)
    PlayerData = QBCore.Functions.GetPlayerData()
    local GlobalConfig = Config.Pink
    if not GlobalConfig.Appartment[data.params.id] then return end
    if GlobalConfig.Appartment[data.params.id].Owner == PlayerData.citizenid then 
        local HeaderMsg = "Manage<br> Total Payment: $ "..GlobalConfig.Appartment[data.params.id].Total.."<br>Remaining Payment : $ "..math.ceil(Config.Pink.TotalRent - GlobalConfig.Appartment[data.params.id].Total)..""
        if GlobalConfig.Appartment[data.params.id].Total >= Config.Pink.TotalRent then 
            HeaderMsg = "Manage<br> All payment Have Been Completed"
        end
        exports['qb-menu']:openMenu({
            {
                header = HeaderMsg,
                isMenuHeader = true, -- Set to true to make a nonclickable title
                icon = "fa-solid fa-people-roof",
            },
            {
                header = "Give Key",
                txt = "Give Key To Some One",
                icon = "fa-regular fa-hand-holding-hand",
                params = {
                    isServer = true,
                    event = "qb-Pink:server:Key",
                    args = {
                        id = data.params.id,
                    }
                }
            },
            {
                header = "Remove Key",
                txt = "Remove Key From Some One",
                icon = "fa-solid fa-person-circle-minus",
                params = {
                    isServer = true,
                    event = "qb-Pink:server:RemoveKeyList",
                    args = {
                        id = data.params.id,
                    }
                }
            },
            {
                header = "Transfer",
                txt = "Transfer Your Apartment To Some One",
                icon = "fa-regular fa-turn-down-right",
                params = {
                    isServer = true,
                    event = "qb-Pink:server:Transfer",
                    args = {
                        id = data.params.id,
                    }
                }
            },
            {
                header = "Cancel",
                txt = "Cancel Your Apartment Contract",
                icon = "fa-duotone fa-trash",
                params = {
                    event = "qb-Pink:client:Cancel",
                    args = {
                        id = data.params.id,
                    }
                }
            },
            {
                header = "Exit",
                icon = "fa-regular fa-circle-xmark",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
        })
    else
        QBCore.Functions.Notify('You don\'t have access', 'error', 7500)
    end
end)

RegisterNetEvent('qb-Pink:client:AppartClothes', function(data)
    local canChange = false
    PlayerData = QBCore.Functions.GetPlayerData()
    local GlobalConfig = Config.Pink
    if not GlobalConfig.Appartment[data.params.id] then return end
    for k, v in pairs(GlobalConfig.Appartment[data.params.id].KeyHolders) do 
        if v.cid == PlayerData.citizenid then 
            canChange = true 
        end
    end
    if canChange then 
        TriggerEvent('qb-clothing:client:openOutfitMenu')
    else
        QBCore.Functions.Notify('You don\'t have access to this clothes locker', 'error', 7500)
    end
end)

RegisterNetEvent('qb-Pink:client:RemoveKeyList', function(data, players)
    if players then 
        local PinkMenu = {
            {
                header = "Remove Key",
                isMenuHeader = true, -- Set to true to make a nonclickable title
            },
        }
        for k, v in pairs(players) do 
            PinkMenu[#PinkMenu + 1] = {
                header = 'name : '..v.name,
                txt = '',
                icon = "fa-regular fa-user",
                params = {
                    isServer = true,
                    event = 'qb-Pink:server:RemoveKey',
                    args = {
                        cid = v.citizenid,
                        name = v.name,
                        id = data.id,
                    }
                }
            }
        end
        PinkMenu[#PinkMenu + 1] = {
            header = "Exit",
            icon = "fa-regular fa-circle-xmark",
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        if #PinkMenu > 0 then 
            exports['qb-menu']:openMenu(PinkMenu)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:Key', function(data, players)
    if players then 
        local PinkMenu = {
            {
                header = "Give Key",
                isMenuHeader = true, -- Set to true to make a nonclickable title
            },
        }
        for k, v in pairs(players) do 
            PinkMenu[#PinkMenu + 1] = {
                header = 'name : '..v.name,
                txt = '',
                icon = "fa-regular fa-user",
                params = {
                    isServer = true,
                    event = 'qb-Pink:server:GiveKey',
                    args = {
                        cid = v.citizenid,
                        id = data.id,
                    }
                }
            }
        end
        PinkMenu[#PinkMenu + 1] = {
            header = "Exit",
            icon = "fa-regular fa-circle-xmark",
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        if #PinkMenu > 0 then 
            exports['qb-menu']:openMenu(PinkMenu)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:Transfer', function(data, players)
    if players then 
        local PinkMenu = {
            {
                header = "Transfer",
                isMenuHeader = true, -- Set to true to make a nonclickable title
            },
        }
        for k, v in pairs(players) do 
            PinkMenu[#PinkMenu + 1] = {
                header = 'name : '..v.name,
                txt = '',
                icon = "fa-regular fa-user",
                params = {
                    isServer = true,
                    event = 'qb-Pink:server:TransferConfirm',
                    args = {
                        cid = v.citizenid,
                        id = data.id,
                    }
                }
            }
        end
        PinkMenu[#PinkMenu + 1] = {
            header = "Exit",
            icon = "fa-regular fa-circle-xmark",
            params = {
                event = "qb-menu:closeMenu",
            }
        }
        if #PinkMenu > 0 then 
            exports['qb-menu']:openMenu(PinkMenu)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:TransferConfirm', function(data)
    local alert = lib.alertDialog({
        header = 'Confirmation',
        content = 'Do you accept tp transfer apartment '..data.id..' from [ '..data.Or..' ] to your name ?',
        centered = true,
        cancel = true
    })
    if alert then 
        if alert == 'confirm' then 
            TriggerServerEvent('qb-Pink:server:TransferAccept', data)
        end
    end
end)

RegisterNetEvent('qb-Pink:client:AppartStash', function(data)
    local canChange = false
    PlayerData = QBCore.Functions.GetPlayerData()
    local GlobalConfig = Config.Pink
    if not GlobalConfig.Appartment[data.params.id] then return end
    for k, v in pairs(GlobalConfig.Appartment[data.params.id].KeyHolders) do 
        if v.cid == PlayerData.citizenid then 
            canChange = true 
        end
    end
    if canChange then 
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "pinkcage_"..data.params.id, {
            maxweight = Config.Pink.Stash.size,
            slots = Config.Pink.Stash.slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "pinkcage_"..data.params.id)
    else
        QBCore.Functions.Notify('You don\'t have access to this locker', 'error', 7500)
    end
    -- TriggerServerEvent("inventory:server:OpenInventory", "stash", "pinkcage_"..data.params.id, {
    --     maxweight = Config.Pink.Stash.size,
    --     slots = Config.Pink.Stash.slots,
    -- })
    -- TriggerEvent("inventory:client:SetCurrentStash", "pinkcage_"..data.params.id)
end)


CreateThread(function()
    for k, v in pairs(Config.Pink.Appartment) do 
        exports['qb-target']:AddBoxZone(''..v.manage.name..''..k, v.manage.coords, v.manage.info1, v.manage.info2, {
            name= ''..v.manage.name..''..k,
            heading= v.manage.heading,
            debugPoly= v.manage.debugPoly,
            minZ= v.manage.minZ,
            maxZ= v.manage.maxZ
        }, {
            options = {
				{ 
					type = "client", 
					event = "qb-Pink:client:AppartMenu",  
					icon = 'fas fa-example', 
					label = 'Manage', 
                    params = {
                        id = v.id
                    }
				}
			},
            distance = 1.5, 
        })
        exports['qb-target']:AddBoxZone(''..v.stash.name..''..k, v.stash.coords, v.stash.info1, v.stash.info2, {
            name= ''..v.stash.name..''..k,
            heading= v.stash.heading,
            debugPoly= v.stash.debugPoly,
            minZ= v.stash.minZ,
            maxZ= v.stash.maxZ
        }, {
            options = {
				{ 
					type = "client", 
					event = "qb-Pink:client:AppartStash",  
					icon = 'fas fa-example', 
					label = 'Stash', 
                    params = {
                        id = v.id
                    }
				}
			},
            distance = 1.5, 
        })
        exports['qb-target']:AddBoxZone(''..v.clothes.name..''..k, v.clothes.coords, v.clothes.info1, v.clothes.info2, {
            name= ''..v.clothes.name..''..k,
            heading= v.clothes.heading,
            debugPoly= v.clothes.debugPoly,
            minZ= v.clothes.minZ,
            maxZ= v.clothes.maxZ
        }, {
            options = {
				{ 
					type = "client", 
					event = "qb-Pink:client:AppartClothes",  
					icon = 'fas fa-example', 
					label = 'Clothes', 
                    params = {
                        id = v.id
                    }
				}
			},
            distance = 1.5, 
        })
    end
end)

-- exports('GetPinkDoorID', function(id)
--     PlayerData = QBCore.Functions.GetPlayerData()
-- 	local cid = PlayerData.citizenid
--     if Config.Pink.Appartment[id] then 
--         for k, v in pairs(Config.Pink.Appartment[id].KeyHolders) do 
--             if v.cid == cid then 
--                 return Config.Pink.Appartment[id].id 
--             end
--         end
--     end
--     return nil 
-- end)
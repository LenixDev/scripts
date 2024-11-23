local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local QBCore = exports['qb-core']:GetCoreObject()
inAuction = false
isAucStarted = false
isNotify = false
AuctionData = {}
AuctionSoldData = {}
PlayerData = QBCore.Functions.GetPlayerData()
PlayerJob = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)
CreateThread(function()
    local Blip = AddBlipForCoord(vec3(-1092.2253417969,-1268.9981689453,5.847128868103))
    SetBlipSprite(Blip, 426)
    SetBlipDisplay(Blip, 4)
    SetBlipScale(Blip, 0.7)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, 33)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName('Car Auction')
    EndTextCommandSetBlipName(Blip)
end)

RegisterNetEvent('qb-carauction:Client:AuctionSynce', function(data)
    PlayerData = QBCore.Functions.GetPlayerData()
    if data.params.action then
        if isAuth(PlayerData.job.name) then
            if inAuction then
                if not isAucStarted then
                    local isCar, model, plate = isVehPresent()
                    if isCar then
                        QBCore.Functions.TriggerCallback('qb-carauction:server:checkVehicleOwner', function(isowner, model)
                            if isowner then
                                if QBCore.Shared.Vehicles[model] then 
                                    local VehData = QBCore.Shared.Vehicles[model]
                                    AuctionData.model = VehData["model"]
                                    AuctionData.name = VehData["name"]
                                    AuctionData.plate = plate
                                    AuctionData.lastPrice = 0
                                    if AuctionData.model ~= nil and AuctionData.name ~= nil then
                                        local dialog = exports['qb-input']:ShowInput({
                                            header = "Auction Data",
                                            submitText = "Submit",
                                            inputs = {
                                                {
                                                    text = "Please add price", -- text you want to be displayed as a place holder
                                                    name = "price", -- name of the input should be unique otherwise it might override
                                                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                                                    isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                                                },
                                                {
                                                    text = "Please add time (minimum is 15 minute)", -- text you want to be displayed as a place holder
                                                    name = "time", -- name of the input should be unique otherwise it might override
                                                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                                                    isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                                                },
                                            },
                                        })
    
                                        if dialog then 
                                            if tonumber(dialog.time) and tonumber(dialog.time) > 0 then 
                                                if tonumber(dialog.price) and tonumber(dialog.price) > 0 then 
                                                    AuctionData.price = tonumber(dialog.price)
                                                    AuctionData.Started = true
                                                    TriggerServerEvent('qb-carauction:server:AuctionSynce', true, AuctionData)
                                                    TriggerServerEvent('qb-carauction:server:SynceTime', true, tonumber(dialog.time))
                                                    QBCore.Functions.Notify("car model "..AuctionData.name.."", "success")
                                                else
                                                    QBCore.Functions.Notify("Please add price higher than 0", "error")
                                                end
                                            else
                                                QBCore.Functions.Notify("Please add time higher than 0", "error")
                                            end
                                        end
    
                                    end
                                end
                            else
                                QBCore.Functions.Notify("This is not your car", "error", 3500)
                            end
                        end, plate)
                    else
                        QBCore.Functions.Notify("No car", "error")
                    end
                else
                    QBCore.Functions.Notify("Car auction is already started", "error")
                end
            end
        else
            QBCore.Functions.Notify("You are not allowed to start carauction", "error")
        end
    else
        if isAuth(PlayerData.job.name) then
            if data.params.sold then
                TriggerServerEvent('qb-carauction:server:SoldBySeller')
            else
                if inAuction then
                    if isAucStarted then
                        TriggerServerEvent('qb-carauction:server:AuctionSynce', false)
                        TriggerServerEvent('qb-carauction:server:SynceTime', false)
                    else
                        QBCore.Functions.Notify("Car auction is not started", "error")
                    end
                end
            end
        else
            QBCore.Functions.Notify("You are not allowed to do this action", "error")
        end
    end
end)

RegisterNetEvent('qb-carauction:Client:CivAuction', function(data)
    PlayerData = QBCore.Functions.GetPlayerData()
    if isAuth(PlayerData.job.name) then
        if inAuction then
            if not isAucStarted then
                local isCar, model, plate = isVehPresent()
                if isCar then
                    TriggerServerEvent('qb-carauction:server:checkVehicleCivOwner', plate)
                else
                    QBCore.Functions.Notify("No car", "error")
                end
            else
                QBCore.Functions.Notify("Car auction is already started", "error")
            end
        end
    else
        QBCore.Functions.Notify("You are not allowed to start carauction", "error")
    end
end)

RegisterNetEvent('qb-carauction:client:CivAuctionAgreesecond', function(data)
    if not data then return end 
    if QBCore.Shared.Vehicles[data.model] then 
        local VehData = QBCore.Shared.Vehicles[data.model]
        AuctionData.model = VehData["model"]
        AuctionData.name = VehData["name"]
        AuctionData.plate = data.plate
        AuctionData.lastPrice = 0
        if AuctionData.model ~= nil and AuctionData.name ~= nil then
            local dialog = exports['qb-input']:ShowInput({
                header = "Auction Data",
                submitText = "Submit",
                inputs = {
                    {
                        text = "Please add price", -- text you want to be displayed as a place holder
                        name = "price", -- name of the input should be unique otherwise it might override
                        type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                        isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    },
                    {
                        text = "Please add time (minimum is 15 minute)", -- text you want to be displayed as a place holder
                        name = "time", -- name of the input should be unique otherwise it might override
                        type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                        isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    },
                },
            })

            if dialog then 
                if tonumber(dialog.time) and tonumber(dialog.time) > 0 then 
                    if tonumber(dialog.price) and tonumber(dialog.price) > 0 then 
                        AuctionData.price = tonumber(dialog.price)
                        AuctionData.Started = true
                        TriggerServerEvent('qb-carauction:server:AuctionSynce', true, AuctionData)
                        TriggerServerEvent('qb-carauction:server:SynceTime', true, tonumber(dialog.time))
                        QBCore.Functions.Notify("car model "..AuctionData.name.."", "success")
                    else
                        QBCore.Functions.Notify("Please add price higher than 0", "error")
                    end
                else
                    QBCore.Functions.Notify("Please add time higher than 0", "error")
                end
            end

        end
    end
end)

RegisterNetEvent('qb-carauction:Client:CivAuctionAgree', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Confirmation",
        submitText = "Comfirm",
        inputs = {
            {
                text = "Please confirm",
                name = "confirm",
                type = "checkbox",
                options = {
                    { value = "agree", text = "I agree" },
                }
            },
        },
    })
    if dialog ~= nil then
        if dialog.agree == 'true' then 
            TriggerServerEvent('qb-carauction:server:CivAuctionAgreesecond', data)
        end
    end
end)

RegisterNetEvent('qb-carauction:Client:Complete', function(data)
    PlayerData = QBCore.Functions.GetPlayerData()
    if isAuth(PlayerData.job.name) then
        if #AuctionSoldData > 0 then
            local SoldList = {}
            for k, v in pairs(AuctionSoldData) do 
                SoldList[#SoldList + 1] = {
                    header = 'Car auction',
                    txt = "Name : "..v.name.." <br>Price :$"..v.price.." <br>cid : "..v.cid.." <br>Vehicle : "..v.veh.." <br>Plate : "..v.plate.."",
                    params = {
                        event = 'qb-carauction:client:COMconfirm',
                        args = {
                            plate = v.plate,
                            cid = v.cid,
                            price = v.price,
                        }
                    }
                }
            end
            if #SoldList <= 0 then return end
            exports['qb-menu']:openMenu(SoldList)
        else
            QBCore.Functions.Notify("No cars have been sold yet", "error")
        end
    else
        QBCore.Functions.Notify("You are not allowed to start carauction", "error")
    end
end)

RegisterNetEvent('qb-carauction:client:COMconfirm', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Confirmation",
        submitText = "Comfirm",
        inputs = {
            {
                text = "Please confirm",
                name = "confirm",
                type = "checkbox",
                options = {
                    { value = "agree", text = "I agree" },
                }
            },
        },
    })
    if dialog ~= nil then
        if dialog.agree == 'true' then 
            TriggerServerEvent('qb-carauction:server:complete', data)
     end
    end
end)
RegisterNetEvent('qb-carauction:client:completeted', function(plate)
    if inAuction then
        if #AuctionSoldData > 0 then
            for k, v in pairs(AuctionSoldData) do 
                if v.plate == plate then
                    table.remove(AuctionSoldData, k)
                end
            end
     end
    end
end)
RegisterNetEvent('qb-carauction:client:Sold', function(GlobalData)
    if GlobalData.cid ~= nil then
        table.insert(AuctionSoldData, {
            cid = GlobalData.cid,
            name = GlobalData.name,
            price = AuctionData.lastPrice,
            veh = AuctionData.name,
            model = AuctionData.model,
            plate = AuctionData.plate
        })
    end
    if inAuction then
        TriggerEvent('animations:client:EmoteCommandStart', {"clap"})
        Citizen.Wait(3000)
        StopAnimTask(PlayerPedId(), "amb@world_human_cheering@male_a", "base", 1.0)
    end
end)
RegisterNetEvent('qb-carauction:client:anim', function()
StopAnimTask(PlayerPedId(), "oddjobs@assassinate@vice@hooker", "argue_a", 1.0)
end)
RegisterNetEvent('qb-carauction:client:AuctionSynceGlobal', function(bool, aData)
    if bool then
        if inAuction then
            isAucStarted = bool
        end
    else
        AuctionData = {}
        isAucStarted = false
    end
    if inAuction then
        if isAucStarted then
            AuctionData = aData
            local AuData = {
                header = "Car Auction",
                DataInfo = {
                    [1] = "[ F1 ] To participate",
                    [2] = "Auction Started <br>Car name : "..AuctionData.name.." <br>Car price : "..AuctionData.price.."",
                }
            }
            ShowInfo(true, AuData)
        else
            ShowInfo(false)
        end
    else
        ShowInfo(false)
    end
end)

RegisterNetEvent('qb-carauction:Client:Counter', function(Time, sec)
    if inAuction then
        if isAucStarted then
            if AuctionData.name ~= nil then
                if AuctionData.CurrentBuyer == nil then
                    local AuData = {
                        header = "Car Auction",
                        DataInfo = {
                            [1] = "[ F1 ] To participate",
                            [2] = "Auction Started <br>Remaining time : "..Time.." : "..sec.." <br>Car name : "..AuctionData.name.." <br>Car price : "..AuctionData.price.."",
                        }
                    }
                    ShowInfo(true, AuData)
                else
                    local AuData = {
                        header = "Car Auction",
                        DataInfo = {
                            [1] = "[ F1 ] To participate",
                            [2] = "Auction Started <br>Remaining time : "..Time.." : "..sec.." <br>Car name : "..AuctionData.name.." <br>Last bit price : "..AuctionData.lastPrice.." <br>Current Buyer : "..AuctionData.CurrentBuyer.."",
                        }
                    }
                    ShowInfo(true, AuData)
                end
            end
        else
            ShowInfo(false)
        end
    else
        ShowInfo(false)
    end
end)

RegisterNetEvent('qb-carauction:Client:UpdateLocation', function()
    if inAuction then
        QBCore.Functions.TriggerCallback('qb-carauction:server:isAucStarted', function(aStarted, auData)
            if aStarted then
                isAucStarted = AuctionData.Started
                AuctionData = auData
            end
        end)
    else
        ShowInfo(false)
    end
end)

RegisterNetEvent('qb-carauction:Client:placeBit', function(BitData)
    if inAuction then
        if isAucStarted then
            if AuctionData.name ~= nil then
                if AuctionData.lastPrice == 0 then
                    AuctionData.price = AuctionData.price + BitData.price
                    AuctionData.lastPrice = AuctionData.price
                else
                    AuctionData.lastPrice = AuctionData.lastPrice + BitData.price
                end
                AuctionData.CurrentBuyer = BitData.name
                AuctionData.BuyerCid = BitData.cid
                local AuData = {
                    header = "Car Auction",
                    DataInfo = {
                        [1] = "[ F1 ] To participate",
                        [2] = "Auction Started <br>Remaining time : "..BitData.Time.." : "..BitData.sec.." <br>Car name : "..AuctionData.name.." <br>Last bit price : "..AuctionData.lastPrice.." <br>Current Buyer : "..BitData.name.."",
                    }
                }
                ShowInfo(true, AuData)
            end
        end
    else
        ShowInfo(false)
    end
end)

RegisterNetEvent('qb-carauction:client:place', function()
    if inAuction then
        if isAucStarted then
            QBCore.Functions.TriggerCallback('qb-carauction:server:GetMoney', function(Has, Money)
                if Has then
                    if Money >= AuctionData.price then
                        local menu = {}
                        for i=1, #Config.Bits, 1 do
                            menu[#menu + 1] = {
                                header = 'Car info [ '..AuctionData.name..' ]',
                                txt = Config.Bits[i].text,
                                params = {
                                    event = 'qb-carauction:client:chooceplace',
                                    args = {
                                        amount = Config.Bits[i].price,
                                        isPicked = true
                                    }
                                }
                            }
                        end
                        menu[#menu + 1] = {
                            header = 'Custom bet',
                            txt = 'Bet with custom amount',
                            params = {
                                event = 'qb-carauction:client:chooceplace',
                                args = {
                                    isPicked = false
                                }
                            }
                        }
                        if #menu <= 0 then return end
                        exports['qb-menu']:openMenu(menu)
                    else
                        QBCore.Functions.Notify("you have enough money", "error")
                    end
                else
                    QBCore.Functions.Notify("you dont have enough money", "error")
                end
            end, AuctionData.price)
        else
            QBCore.Functions.Notify("No auction found", "error")
        end
    else
        QBCore.Functions.Notify("you are not in auction house", "error")
    end
end)

RegisterNetEvent('qb-carauction:client:chooceplace', function(data)
    if inAuction then
        if isAucStarted then
            if data.isPicked then 
                TriggerServerEvent('qb-carauction:server:place', math.ceil(tonumber(data.amount)))
            else
                local dialog = exports['qb-input']:ShowInput({
                    header = "Car info [ "..AuctionData.name.." ]",
                    submitText = "Submit",
                    inputs = {
                        {
                            text = "Please place a bit", -- text you want to be displayed as a place holder
                            name = "bit", -- name of the input should be unique otherwise it might override
                            type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                            isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                        },
                    },
                })
                if dialog ~= nil then
                    if dialog.bit and tonumber(dialog.bit) > 500 then 
                        TriggerServerEvent('qb-carauction:server:place', math.ceil(tonumber(dialog.bit)))
                    else
                        QBCore.Functions.Notify("Please place a bet higher than $500", "error")
                    end
                end
            end
        else
            QBCore.Functions.Notify("No auction found", "error")
        end
    else
        QBCore.Functions.Notify("you are not in auction house", "error")
    end
end)

RegisterNetEvent('qb-carauction:Client:Transfer', function()
    TriggerServerEvent('qb-carauction:server:TransferGetPlayers')
end)

RegisterNetEvent('qb-carauction:client:TransferSendPlayers', function(players, data)
    if players then 
        if data.action == 1 then 
            local PlayersMenu = {
                {
                    header = "Transfer From",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
            }
            for k, v in pairs(players) do 
                PlayersMenu[#PlayersMenu + 1] = {
                    header = 'name : '..v.name,
                    txt = '',
                    params = {
                        isServer = true,
                        event = 'qb-carauction:server:TransferGetSecondPlayer',
                        args = {
                            seller = v.seller,
                        }
                    }
                }
            end
            PlayersMenu[#PlayersMenu + 1] = {
                header = "Exit",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            if #PlayersMenu > 0 then 
                exports['qb-menu']:openMenu(PlayersMenu)
            end
        elseif data.action == 2 then 
            local PlayersMenu = {
                {
                    header = "Transfer To",
                    isMenuHeader = true, -- Set to true to make a nonclickable title
                },
            }
            for k, v in pairs(players) do 
                PlayersMenu[#PlayersMenu + 1] = {
                    header = 'name : '..v.name,
                    txt = '',
                    params = {
                        isServer = false,
                        event = 'qb-carauction:client:TransferGetTransVehData',
                        args = {
                            seller = data.seller,
                            buyer = v.buyer,
                        }
                    }
                }
            end
            PlayersMenu[#PlayersMenu + 1] = {
                header = "Exit",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            if #PlayersMenu > 0 then 
                exports['qb-menu']:openMenu(PlayersMenu)
            end
        end
    end
end)

RegisterNetEvent('qb-carauction:client:TransferGetTransVehData', function(data)
    QBCore.Functions.TriggerCallback('qb-carauction:server:TransferGetTransVehData', function(vehicles)
        if vehicles == nil then
            QBCore.Functions.Notify("Seller does not have any vehicle to transfer", "error", 5000)
        else
            local MyVehList = {
                {
                    header = 'Choose vehicle to transfer',
                    isMenuHeader = true
                },
            }
            for k, v in pairs(vehicles) do
                if QBCore.Shared.Vehicles[v.vehicle] then 
                    local vname = QBCore.Shared.Vehicles[v.vehicle].name

                    MyVehList[#MyVehList+1] = {
                        header = vname,
                        txt = " "..vname.." ["..v.plate.."]",
                        params = {
                            isServer = true,
                            event = "qb-carauction:server:transferAccept",
                            args = {
                                plate = v.plate,
                                vname = vname,
                                seller = data.seller,
                                buyer = data.buyer,
                            }
                        }
                    }
                end
            end

            MyVehList[#MyVehList+1] = {
                header = "Exit",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            exports['qb-menu']:openMenu(MyVehList)
        end
    end, data.seller)
end)

RegisterNetEvent('qb-carauction:client:transferMenuClient', function(data)
    local dialog = exports['qb-input']:ShowInput({
        header = "Confirmation",
        submitText = "Comfirm",
        inputs = {
            {
                text = "Offer To Transfer [ "..data.vname.." ]",
                name = "taxincl",
                type = "checkbox",
                options = {
                    { value = "agree", text = "I agree" },
                }
            },
        },
    })
    if dialog ~= nil then
        if dialog.agree == 'true' then 
            QBCore.Functions.Progressbar("pdm_selling", "Preparing paper please wait", math.random(12000, 15000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('qb-carauction:server:transferAcceptFinal', data)
            end, function() -- Cancel
                QBCore.Functions.Notify("Process canceled..", "error")
            end)
        end
    end
end)

RegisterNetEvent('qb-carauction:client:GiveComm', function(amount)
    if inAuction then 
        TriggerServerEvent('qb-carauction:server:GiveComm', amount)
    end
end)

function isVehPresent()
    local vehicle = QBCore.Functions.GetClosestVehicle(Config.CarLoc)
    if DoesEntityExist(vehicle) then
        local vehCoords = #(GetEntityCoords(vehicle) - Config.CarLoc)
        if vehCoords < 8 then
            return true, GetEntityModel(vehicle), GetVehicleNumberPlateText(vehicle)
        end
    end
    return false
end


function isAuth(Job)
    answer = false
    if Config.Jobs[Job] then
        answer = true
    end
    return answer
end

function isInCarAuction()
    answer = false
    if inAuction then 
        if isAucStarted then 
            answer = true
        end
    end
    return answer
end

exports('isInCarAuction', isInCarAuction)
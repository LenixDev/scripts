TwoNa = exports["2na_core"]:getSharedObject()
MenuAccessible = false

RegisterNetEvent("sgx-banking:Client:BankMenu:Show")
AddEventHandler("sgx-banking:Client:BankMenu:Show", function() 
    if IsPlayerNearAccessLocation() then 
        TwoNa.TriggerServerCallback("sgx-banking:Server:GetUserAccounts", {}, function(bankData) 
            if bankData then 
                SetNuiFocus(true, true)
                
                SendNUIMessage({
                    action = "showMenu",
                    playerName = bankData.playerName,
                    accounts = bankData.accounts
                })
            end
        end)
    end
end)

RegisterNetEvent("sgx-banking:Client:BankMenu:Hide")
AddEventHandler("sgx-banking:Client:BankMenu:Hide", function() 
    SetNuiFocus(false, false)
                
    SendNUIMessage({
        action = "hideMenu"
    })
end)

exports.interact:AddInteraction({
    coords = vector3(314.2, -279.53, 54.18),
    distance = 4.0, -- optional
    interactDst = 1.0, -- optional
    id = 'Bank Account', -- needed for removing interactions
    name = 'Bank Account', -- optional
    options = {
         {
            label = 'Access Your Bank Account',
            event = "sgx-banking:Client:BankMenu:Show",
            action = function(entity, coords, args)
            TriggerEvent("sgx-banking:Client:BankMenu:Show")
            end,
        },
    }
})

exports.interact:AddInteraction({
    coords = vector3(312.39, -278.86, 54.18),
    distance = 4.0, -- optional
    interactDst = 1.0, -- optional
    id = 'Bank Account', -- needed for removing interactions
    name = 'Bank Account', -- optional
    options = {
         {
            label = 'Access Your Bank Account',
            event = "sgx-banking:Client:BankMenu:Show",
            action = function(entity, coords, args)
            TriggerEvent("sgx-banking:Client:BankMenu:Show")
            end,
        },
    }
})


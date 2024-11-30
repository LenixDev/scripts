local QBCore = exports[config.Core]:GetCoreObject()

RegisterNetEvent("givecash:Client:Open")
AddEventHandler("givecash:Client:Open", function ()
    local Players = {}
    local dialog = nil
    QBCore.Functions.TriggerCallback("givecash:getplayers",function(data)
        for k,v in pairs(data) do
            local coords = v.ped
            local LocalPlayerCoords = GetEntityCoords(PlayerPedId())
            local GetDis = GetDistanceBetweenCoords(LocalPlayerCoords.x, LocalPlayerCoords.y, LocalPlayerCoords.z, coords.x, coords.y, coords.z, true)
            if GetDis < 5 then
                table.insert(Players, {value = k, text = v.firstname..' '..v.lastname..' ('..k..')'})
            end
        end
        if #Players == 0 then
            table.insert(Players, {value = "none", text = "لا يوجد لاعب قريب"})
        end
        dialog = exports['qb-input']:ShowInput({
            header = " اعطاء كاش لشخص قريب ",
            submitText = "ارسال",
            inputs = {
                {
                    text = "المبلغ", -- text you want to be displayed as a place holder
                    name = "amount", -- name of the input should be unique otherwise it might override
                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                    isRequired = false, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    -- default = 1, -- Default number option, this is optional
                },
                {
                    text = "اختار لاعب", -- text you want to be displayed as a input header
                    name = "player", -- name of the input should be unique otherwise it might override
                    type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
                    options = Players,
                }
            },
        })
        TriggerServerEvent("givecash:server:givemoney", dialog)
    end)
end)

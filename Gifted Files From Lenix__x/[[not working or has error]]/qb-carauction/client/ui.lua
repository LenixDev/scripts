function ShowInfo(bool, data)
    if bool then
        SendNUIMessage({
            action = "open",
            info = data,
        })
    else
        SendNUIMessage({
            action = "close",
        })
    end
end
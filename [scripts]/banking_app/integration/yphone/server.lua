if not GetResourceState("yphone"):find('start') then return end

RegisterNetEvent('banking:server:notification', function(text, type)
    local src = source

    exports.yphone:SendNotification({
        app = "banking",
        title = "Banking",
        text = text,
        icon = ("https://cfx-nui-%s/web/dist/bank_app.png"):format(GetCurrentResourceName())
    }, 'source', src)
end)

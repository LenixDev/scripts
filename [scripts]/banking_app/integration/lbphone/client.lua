if not GetResourceState("lb-phone"):find('start') then return end

CreateThread(function()
    while GetResourceState("lb-phone") ~= "started" do
        Wait(500)
    end

    while GetResourceState("banking") ~= "started" do
        Wait(500)
    end

    local added, errorMessage = exports["lb-phone"]:AddCustomApp({
        identifier = "banking",
        name = "Bank",
        description = "Banking right in your pocket.",
        developer = "Felis Development",
        defaultApp = true,
        size = 59812,
        fixBlur = true,
        icon = "nui://" .. GetCurrentResourceName() .. "/web/dist/bank_app.png",
        ui = GetCurrentResourceName() .. "/web/dist/index.html",
    })

    if not added then
        print("Could not add app:", errorMessage)
    end
end)

AddEventHandler("banking:client:notification", function(text, type)
    exports["lb-phone"]:SendNotification({
        app = "banking",
        title = "Banking",
        content = text,
    })
end)

function SendData(data)
    exports["lb-phone"]:SendCustomAppMessage("banking", data)
end

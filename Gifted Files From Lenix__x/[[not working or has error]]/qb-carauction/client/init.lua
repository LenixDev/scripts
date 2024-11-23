


Citizen.CreateThread(function()
    Citizen.Wait(100)

    local carauction = BoxZone:Create(vector3(-1098.71, -1267.17, 5.85), 26.6, 29.0, {
        name= "carauction",
        heading=31,
        debugPoly=false,
        minZ=4.05,
        maxZ=8.05
    })
    carauction:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inAuction = true
            TriggerEvent("qb-carauction:Client:UpdateLocation")
        else
            inAuction = false
            TriggerEvent("qb-carauction:Client:UpdateLocation")
        end
    end)

    exports["qb-target"]:AddBoxZone("AuctionMain", vector3(-1085.6, -1265.87, 5.85), 1.2, 0.8, {
        name= "AuctionMain",
        heading = 30,
        debugPoly = false,
        minZ=5.4,
        maxZ=6.4,
        }, {
        options = {
            {
                event = "qb-carauction:Client:AuctionSynce",
                icon = "far fa-clipboard",
                label = "Start carauction",
                params = {
                    action = true
                },
                job = "cardealer",
            },
            {
                event = "qb-carauction:Client:CivAuction",
                icon = "far fa-clipboard",
                label = "Start civilians auction",
                params = {
                    action = true
                },
                job = "cardealer",
            },
            {
                event = "qb-carauction:Client:AuctionSynce",
                icon = "far fa-clipboard",
                label = "Stop carauction",
                params = {
                    action = false,
                    sold = false,
                },
                job = "cardealer",
            },
            {
                event = "qb-carauction:Client:AuctionSynce",
                icon = "far fa-clipboard",
                label = "Sold",
                params = {
                    action = false,
                    sold = true,
                },
                job = "cardealer",
            },
        },
        distance = 1.5
    })

    exports["qb-target"]:AddBoxZone("AuctionOffice", vector3(-1102.78, -1276.63, 5.85), 1.4, 1.4, {
        name= "AuctionOffice",
        heading = 30,
        debugPoly = false,
        minZ=5.25,
        maxZ=6.65,
        }, {
        options = {
            {
                event = "qb-carauction:Client:Complete",
                icon = "far fa-clipboard",
                label = "Complete carauction",
                params = {
                    action = "complete",
                },
                job = "cardealer",
            },
            {
                event = "qb-carauction:Client:Transfer",
                icon = "far fa-clipboard",
                label = "Transfer",
                params = {},
                job = "cardealer",
            },
            {
                event = "qb-bossmenu:client:OpenMenu",
                icon = "far fa-clipboard",
                label = "Management",
                params = {},
                job = "cardealer",
            }
        },
        distance = 1.5
    })

    for k, v in pairs(Config.ChairLocations) do 
        exports["qb-target"]:AddBoxZone(v.name, v.coords, v.info1, v.info2, {
            name = v.name,
            heading = v.heading,
            debugPoly = v.debugPoly,
            minZ = v.minZ,
            maxZ = v.maxZ,
            }, {
            options = {
                {
                    event = 'qb-carauction:client:Chair',
                    icon = "far fa-clipboard",
                    label = "Sit / Stand",
                    chair = k,
                },
            },
            job = {"all"},
            distance = 3.0
        })
    end
end)

-- RegisterNetEvent('bt-polyzone:enter')
-- AddEventHandler('bt-polyzone:enter', function(name)
--     if name == "carauction" then
--         if not inAuction then
--             inAuction = true
--             TriggerEvent("qb-carauction:Client:UpdateLocation")
--         end
--     end
-- end)

-- RegisterNetEvent('bt-polyzone:exit')
-- AddEventHandler('bt-polyzone:exit', function(name)
--     if name == "carauction" then
--         if inAuction then
--             inAuction = false
--             TriggerEvent("qb-carauction:Client:UpdateLocation")
--         end
--     end
-- end)=(1-e)*g):this.morp�,��r5�
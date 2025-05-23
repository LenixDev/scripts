local sellectcase = 1
local containerobj = nil

RegisterCommand(Config.Command, function ()
    SendNUIMessage({
        action = "OpenMenu"
    })
    SetNuiFocus(1,1)
    addContainers()
    DetailCheck(1)
    TriggerServerEvent("BakiTelli:container:getplayerdetail")
end)

if Config.Key then 
    RegisterKeyMapping(Config.Command, 'Open Containers Menu', 'keyboard', "F5")
end

RegisterNUICallback("close", function ()
    SetNuiFocus(0,0)
end)

AddEventHandler("BakiTelli:container:cl:getplayerdetail")
RegisterNetEvent("BakiTelli:container:cl:getplayerdetail", function (details)
    SendNUIMessage({
        action = "updateDetail",
        details = details,
    })
end)

AddEventHandler("Bakitelli:container:opencase:cl")
RegisterNetEvent("Bakitelli:container:opencase:cl", function (containerno, productno)
    OpenCaseAnimation()
    SendNUIMessage({
        action = "away",
        itemlabel = Config.Containers[containerno].Products[productno].itemlabel,
        itemcount = Config.Containers[containerno].Products[productno].itemcount,
        itemimage = Config.Containers[containerno].Products[productno].itemimg,
    })
end)

function addContainers()
    for k, v in ipairs(Config.Containers) do
        SendNUIMessage({
            action = "addContainer",
            CaseName = v.CaseName,
            CaseDesc = v.CaseDesc,
            CasePriceTyp = v.CasePriceTyp,
            CasePrice = v.CasePriceAmount,
            id = k,
        })
    end
end

RegisterNUICallback("getdetail", function (data)
    id = tonumber(data.id)
    DetailCheck(id)
end)

function DetailCheck(id)
    sellectcase = id
    v = Config.Containers[id]
    SendNUIMessage({
        action = "getDetail",
        CaseName = v.CaseName,
        CaseDesc = v.CaseDesc,
        CasePriceTyp = v.CasePriceTyp,
        CasePrice = v.CasePriceAmount,
        id = id,
    })
    for k, v in ipairs(v.Products) do
        SendNUIMessage({
            action = "addProduct",
            productName = v.itemlabel,
            productCount = v.itemcount,
            productimg = v.itemimg
        })
    end
end

RegisterNUICallback("OpenCase", function ()
    TriggerServerEvent('Bakitelli:container:opencase', sellectcase)
end)

function createObject(propName, coord)
    local model = GetHashKey(propName)
    RequestModel(model)
    
    while not HasModelLoaded(model) do
        Wait(1)
    end
    
    containerobj = CreateObject(model, coord.x, coord.y, coord.z, false, false, false)
    SetEntityHeading(containerobj, coord.w)
    PlaceObjectOnGroundProperly(containerobj)
    SetModelAsNoLongerNeeded(containerobj)
    return containerobj
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end


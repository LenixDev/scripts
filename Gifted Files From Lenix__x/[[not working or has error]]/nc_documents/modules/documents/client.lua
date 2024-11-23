RegisterNetEvent("nc_documents:displayDocument", function(coords, metadata) 
    local pedCoords = GetEntityCoords(PlayerPedId())
    local dist = #(coords - pedCoords)
    if (dist < Config.DisplayRadius) then 
        DisplayDocument(metadata)
    end
end)

function DisplayDocument(metadata)
    local eventName = ""
    if metadata.documentType == "card" then 
        eventName = "DisplayCard"
    elseif metadata.documentType == "document" then 
        eventName = "DisplayDocument"
    end
    metadata.container = Config.Documents[metadata.documentName].Format
    SendNUIMessage({
        name = eventName,
        value = metadata
    })
end

function HideScreen()
    SendNUIMessage({
        name = "HideScreen",
    })
end

RegisterCommand("nc_documents_close", function() 
    HideScreen()
end)

RegisterKeyMapping('nc_documents_close', 'Close Card / Document', 'keyboard', 'back')

exports("HideScreen", HideScreen)
exports("DisplayDocument", DisplayDocument)
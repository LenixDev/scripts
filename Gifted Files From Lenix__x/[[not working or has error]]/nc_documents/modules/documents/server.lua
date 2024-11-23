local registeredItems = {}

for k,v in pairs(Config.Documents) do 
    local registered = false
    local name = v.Item
    for i=1, #registeredItems do 
        if registeredItems[i] == name then
            registered = true
            break
        end
    end
    if not registered then 
        RegisterUsableItem(name, function(...) 
            DocumentItemHandler(...)
        end)
    end
end

function GiveDocument(source, documentName, metadata, cb)
    local document = Config.Documents[documentName]
    GetPlayerIdentity(source, function(info) 
        document.CreateDocument(source, info, metadata, function(result)
            if (result) then 
                local result = result
                result.label = document.ItemLabel
                result.documentName = documentName
                result.documentType = document.Type
                AddItem(source, document.Item, 1, result)
            end
            cb(result)
        end)
    end)
end

exports("GiveDocument", GiveDocument)
RegisterCallback("nc_documents:dmv:requestOption", function(source, cb, index, option)
    local cfg = Config.Locations[index].Options[option]
    if (not cfg.document or not Config.Documents[cfg.document]) then 
        cb(false)
        return ShowNotification(source, _L("dmv_err_license", cfg.document or "nil"))
    end
    if (not CanAccessGroup(source, cfg.groups)) then 
        cb(false)
        return ShowNotification(source, _L("dmv_not_group"))
    end
    for k,v in pairs(cfg.items) do 
        local count = Search(source, k)
        if count < v then 
            cb(false)
            return ShowNotification(source, _L("dmv_lack_item", k, v - count))
        end
    end 
    cb(true)
end)

RegisterCallback("nc_documents:dmv:finishProcessOption", function(source, cb, index, option, metadata)
    local cfg = Config.Locations[index].Options[option]
    if (not cfg.document or not Config.Documents[cfg.document]) then 
        cb(false)
        return ShowNotification(source, _L("dmv_err_license", cfg.document or "nil"))
    end
    if (not CanAccessGroup(source, cfg.groups)) then 
        cb(false)
        return ShowNotification(source, _L("dmv_not_group"))
    end
    for k,v in pairs(cfg.items) do 
        local count = Search(source, k)
        if count < v then 
            cb(false)
            return ShowNotification(source, _L("dmv_lack_item", k, v - count))
        end
    end

    local document = Config.Documents[cfg.document]
    
    GiveDocument(source, cfg.document, metadata, function(result) 
        if (result) then 
            for k,v in pairs(cfg.items) do 
                RemoveItem(source, k, v)
            end
        end
        cb(result)
    end)
end)

function RemoveHTML(v)
    local html = v
    html = string.gsub(html, "<", "(")
    html = string.gsub(html, ">", ")")
    return html
end

function GiveDocument(source, documentName, metadata, cb)
    local document = Config.Documents[documentName]
    GetPlayerIdentity(source, function(info) 
        for k,v in pairs(metadata) do 
            metadata[k] = RemoveHTML(v)
        end
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
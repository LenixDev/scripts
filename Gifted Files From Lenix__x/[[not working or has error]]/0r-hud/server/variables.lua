Koci = {}
Koci.Framework = Utils.Functions:GetFramework()
Koci.Utils = Utils.Functions
Koci.Server = {
    MySQL = {
        Async = {},
        Sync = {}
    },
    HUD = {}
}
Koci.Callbacks = {}

Koci.Server.RegisterServerCallback = function(key, func)
    Koci.Callbacks[key] = func
end

Koci.Server.TriggerCallback = function(key, source, payload, cb)
    if not cb then
        cb = function() end
    end

    if Koci.Callbacks[key] then
        Koci.Callbacks[key](source, payload, cb)
    end
end

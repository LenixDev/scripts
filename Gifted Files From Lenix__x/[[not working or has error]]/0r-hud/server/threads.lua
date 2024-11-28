CreateThread(function()
    while Koci.Framework == nil do
        Koci.Framework = Utils.Functions:GetFramework()
        Wait(16)
    end
end)

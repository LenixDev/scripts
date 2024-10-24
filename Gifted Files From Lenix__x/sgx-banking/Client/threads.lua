Citizen.CreateThread(function()
	if Config.ShowBlips then
		for k,v in ipairs(Config.Locations) do
            if v.name == "Bank" and Config.ShowBlips then 
                local blip = AddBlipForCoord(v.x, v.y, v.z)
                SetBlipSprite(blip, 108)
                SetBlipColour(blip, 2)
                SetBlipScale(blip, 0.6)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(tostring(v.name))
                EndTextCommandSetBlipName(blip)
            end
		end
	end
end)

Citizen.CreateThread(function() 
    local sleep = 1000

    while true do 
        for k,v in ipairs(Config.Locations) do 
            if #(GetEntityCoords(PlayerPedId()) - vector3(v.x,v.y,v.z)) < 2.5 and v.name == "Bank" then
                sleep = 1 
                TwoNa.Draw3DText(v.x, v.y, v.z, 0.7, "Press[" .. Config.ShowMenuKey .. "]To Acces Bank", true)
                break
            else
                sleep = 1000
            end
        end

        Citizen.Wait(sleep)
    end
end)
local carcasses = {
    { name = "huntingcarcass1", price = 450, illegal = false },
    { name = "huntingcarcass2", price = 800, illegal = false },
    { name = "huntingcarcass3", price = 2100, illegal = false },
    { name = "huntingcarcass4", price = 2600, illegal = false },
}

RegisterNetEvent('qb-hunting:server:sell',function()
TriggerServerEvent("qb-hunting:server:sell")
end)

function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 3 then
	  return true
	end
  end
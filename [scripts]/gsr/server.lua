local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("gsr:doTest")
AddEventHandler("gsr:doTest", function(target)
    local src = source
    TriggerClientEvent('gsr:requestGSR', target, src)  -- Trigger GSR check
end)

RegisterNetEvent("gsr:returnGSR")
AddEventHandler("gsr:returnGSR", function(shotRecently, policeId)
	local src = source
	local result = 'سلبية [❌]'
	if shotRecently then result = 'إيجابية [✔️]';
	TriggerClientEvent('QBCore:Notify', policeId, "وصلت نتائج اختبار GSR: "..result, "success")
	else
	TriggerClientEvent('QBCore:Notify', policeId, "وصلت نتائج اختبار GSR: "..result, "error")
	end
end)

-- Register the "gsr" item
QBCore.Functions.CreateUseableItem("gsr", function(source)
    TriggerClientEvent('gsr:testGSR', source)  -- Trigger the event when the item is used
end)
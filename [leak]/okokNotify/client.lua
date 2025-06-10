function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('okokNotify:Alert')
AddEventHandler('okokNotify:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)

-- Example Commands - Delete them

RegisterCommand('success', function()
	exports['okokNotify']:Alert("THÀNH CÔNG", "Bạn đã gửi <span style='color:#47cf73'>420€</span> cho Tommy!", 5000, 'success')
end)

RegisterCommand('info', function()
	exports['okokNotify']:Alert("THÔNG TIN", "Sòng bạc đã mở!", 5000, 'info')
end)

RegisterCommand('error', function()
	exports['okokNotify']:Alert("LỖI", "Vui lòng thử lại sau!", 5000, 'error')
end)

RegisterCommand('warning', function()
	exports['okokNotify']:Alert("CẢNH BÁO", "Bạn đang trở nên lo lắng!", 5000, 'warning')
end)

-- RegisterCommand('phone', function()
-- 	exports['okokNotify']:Alert("SMS", "<span style='color:#f38847'>Tommy: </span> Where are you?", 5000, 'phonemessage')
-- end)

RegisterCommand('longtext', function()
	exports['okokNotify']:Alert("TIN NHẮN DÀI", "Dịch vụ khách hàng là rất quan trọng, và khách hàng là một trong nhiều.", 5000, 'neutral')
end)

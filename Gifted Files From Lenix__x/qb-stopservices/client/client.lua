local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('police:client:playerservices', function()
	local officerdetails = {
        {
            header = "خدمات المواطن"  ,
            isMenuHeader = true,
        },
        {
            
            header = "التحقق من الخدمات",
            txt = "تحقق اذا كانت الخدمات فعالة ام لا",
            params = {
                event = "police:client:checkservices"
            }
        },
        {
            header = "إيقاف الخدمات",
            txt = "إيقاف خدمات مواطن معيين",
            params = {
                event = "police:client:manageservices",
                args = {
                    status = true
                }
            }
        },
        {
            header = "إلغاء إيقاف الخدمات",
            txt = "إلغاء إيقاف خدمات مواطن معيين",
            params = {
                event = "police:client:manageservices",
                args = {
                    status = false
                }
            }
        },
        {
            header = "العودة",
            txt = "العودة إلى القائمة الرئيسية",
            params = {
                event = "qb-mineboss:client:OpenMenu",
            }
        },
    }
	exports['qb-menu']:openMenu(officerdetails)
end)

RegisterNetEvent('police:client:manageservices', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    if data.status then
        local service = exports['qb-input']:ShowInput({
            header = "إيقاف خدمات مواطن",
            submitText = "إيقاف",
            inputs = {
                {
                    text = "رقم هوية المواطن",
                    name = "citizenid", -- name of the input should be unique otherwise it might override
                    type = "text", -- type of the input
                    isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                }
                
            }
        })
        if service ~= nil then
            if service.citizenid == nil then 
                return 
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end
            QBCore.Functions.TriggerCallback('police:server:servicescheck', function(result)
                retval = result
                if retval then
                    QBCore.Functions.Notify("!خدمات المواطن تم إيقافها بالفعل", "erorr")
                else
                    TriggerServerEvent("police:server:manageservices", service.citizenid, true)
                end
            end, service.citizenid)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end
    else
        local service = exports['qb-input']:ShowInput({
            header = "إلغاء إيقاف خدمات مواطن",
            submitText = "إلغاء",
            inputs = {
                {
                    text = "رقم هوية المواطن",
                    name = "citizenid", -- name of the input should be unique otherwise it might override
                    type = "text", -- type of the input
                    isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                }
                
            }
        })
        if service ~= nil then
            if service.citizenid == nil then 
                return 
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end
            QBCore.Functions.TriggerCallback('police:server:servicescheck', function(result)
                retval = result
                if not retval then
                    QBCore.Functions.Notify("!خدمات المواطن فعالة بالفعل", "erorr")
                else
                    TriggerServerEvent("police:server:manageservices", service.citizenid, false)
                end
            end, service.citizenid)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end
    end
end)

RegisterNetEvent('police:client:checkservices', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    local service = exports['qb-input']:ShowInput({
        header = "التحقق من خدمات المواطن",
		submitText = "بحث",
        inputs = {
            {
                text = "هوية المواطن",
				name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            }
			
        }
    })
    if service ~= nil then
        if service.citizenid == nil then 
            return 
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end
        QBCore.Functions.TriggerCallback('police:server:servicescheck', function(result)
            retval = result
            if retval then
                QBCore.Functions.Notify("خدمات المواطن غير فعالة")
            else
                QBCore.Functions.Notify("خدمات المواطن فعالة")
            end
        end, service.citizenid, true)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end
end)
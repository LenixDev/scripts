local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('Rc2-polapply:openApply', function()
    local input = lib.inputDialog('Open a Case', {
        {type = 'input', label = 'First and last names', description = 'Your names here...', required = true},
        {type = 'number', label = 'Name of the accused person', description = 'Accused name here..', required = true},
        {type = 'input', label = 'Your phone number', description = 'Your phone number here...', required = true},
        {type = 'input', label = "The accused's person number", description = 'Kinda important...', required = true},
        {type = 'select', label = 'Gender', options = {
            {value = 'Male', label = 'Male'},
            {value = 'Woman', label = 'Woman'}
        }, required = true},
        {type = 'textarea', label = 'Mention the hadith in detail', required = true, min = 10, max = 300},
        {type = 'input', label = 'Discord:', required = true},
    })

    -- Validate the input to ensure no nil or empty values are concatenated
    if input then
        -- Check if any input field is missing or empty
        for _, field in ipairs(input) do
            if field == nil or field == '' then
                TriggerClientEvent('QBCore:Notify', source, "Please fill out all fields correctly.", "error")
                return
            end
        end
        
        -- Now proceed with sending the application
        TriggerServerEvent('Rc2-polapply:sendApply', input)
    else
        TriggerClientEvent('QBCore:Notify', source, "Input was canceled or incomplete.", "error")
    end
end)

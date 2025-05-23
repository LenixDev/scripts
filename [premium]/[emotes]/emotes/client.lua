RegisterCommand("emotemenu", function(source)
    TriggerEvent("emotes:OpenMenu")
end) 

RegisterCommand("emtc", function(source)
    ExecuteCommand("e c")
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/emtt', 'Open emote menu', {})
    TriggerEvent('chat:addSuggestion', '/emtc', 'Cancel current emote', {})
end)

RegisterKeyMapping("emotemenu", "Open emote menu", "keyboard", 'F3')

RegisterKeyMapping("emtc", "Cancel current emote", "keyboard", 'X')

local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('Rc2-polapply:sendApply', function(input)
  if input then
    local src = source
    local date = os.date('%d-%m-%Y')
    local embed = {
      {
        ["thumbnail"] = {
          ["url"] = "https://static.wikia.nocookie.net/alterlifepolicedepartement/images/5/51/R_%281%29.png/revision/latest?cb=20220111090530"
        },
        ["color"] = 1127128,
        ["title"] = 'Police application',
        ["description"] = '**First and Last Names:** '..input[1]..'\n'..
                          '**Age:** '..input[2]..'\n'..
                          '**Date of Birth:** '..date..'\n'..
                          '**Phone number:** '..input[4]..'\n'..
                          '**Gender:** '..input[5]..'\n'..
                          '**Do you have experience in this work?:** '..input[6]..'\n'..
                          '**Why you want to become a police officer?:** '..input[7]..'\n'..
                          '**Discord:** '..input[8],
      }
    }

    -- Send the embed to the webhook
    PerformHttpRequest(Config.WebHook, function(err, text, headers)
    end, 'POST', json.encode({username = "Police Application", embeds = embed}), { ['Content-Type'] = 'application/json' })
  end
end)

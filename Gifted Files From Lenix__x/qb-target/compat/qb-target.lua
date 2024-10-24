local function exportHandler(exportName, func)
    print(exportName)
    AddEventHandler(('__cfx_export_qb-target_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

exportHandler('AddBoxZone', function(name, center, length, width, options, targetoptions)
    local z = center.z

    if not options.minZ then
        options.minZ = -100
    end

    if not options.maxZ then
        options.maxZ = 800
    end

    if not options.useZ then
        z = z + math.abs(options.maxZ - options.minZ) / 2
        center = vec3(center.x, center.y, z)
    end

    return exports['qb-target']:boxZone(name, center, length, width, options, targetoptions)
end)

exportHandler('AddPolyZone', function(name, points, options, targetoptions)
    return exports['qb-target']:polyZone(name, points, options, targetoptions)
end)

exportHandler('AddCircleZone', function(name, center, radius, options, targetoptions)
    return exports['qb-target']:circleZone(name, center, radius, options, targetoptions)
end)

exportHandler('RemoveZone', function(id)
    return exports['qb-target']:removeZone(id)
end)

exportHandler('AddTargetBone', function(bones, options)
    exports['qb-target']:targetBone(bones, options)
end)

exportHandler('AddTargetEntity', function(entities, options)
    exports['qb-target']:targetEntity(entities, options)
end)

exportHandler('RemoveTargetEntity', function(entities, labels)
    exports['qb-target']:removeTEntity(entities, labels)
end)

exportHandler('AddTargetModel', function(models, options)
    exports['qb-target']:targetModel(models, options)
end)

exportHandler('RemoveTargetModel', function(models, labels)
    exports['qb-target']:removeTModel(models, labels)
end)

exportHandler('AddGlobalPed', function(options)
    exports['qb-target']:globalPed(options)
end)

exportHandler('RemoveGlobalPed', function(labels)
    exports['qb-target']:RemoveGlobalPed(labels)
end)

exportHandler('AddGlobalVehicle', function(options)
    exports['qb-target']:globalVehicle(options)
end)

exportHandler('RemoveGlobalVehicle', function(labels)
    exports['qb-target']:removeGlobalVehicle(labels)
end)

exportHandler('AddGlobalObject', function(options)
    exports['qb-target']:globalObject(options)
end)

exportHandler('RemoveGlobalObject', function(labels)
    exports['qb-target']:RemoveGlobalObject(labels)
end)

exportHandler('AddGlobalPlayer', function(options)
    exports['qb-target']:globalPlayer(options)
end)

exportHandler('AddEntityZone', function(name, entity, options, targetoptions)
    exports['qb-target']:entityZone(name, entity, options, targetoptions)
end)

exportHandler('RemoveTargetBone', function(bones, labels)
    exports['qb-target']:removeTBone(bones, labels)
end)
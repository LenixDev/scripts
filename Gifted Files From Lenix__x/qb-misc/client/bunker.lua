
CreateThread(function()
    exports["qb-target"]:AddBoxZone("BunkerCrafting", vector3(2154.44, 3361.05, 45.06), 1.0, 2.8, {
        name="BunkerCrafting",
        heading=301,
        --debugPoly=true,
        minZ=30.22,
        maxZ=32.42
  }, {
    options = {
        {
            type = "client",
            icon = "fas fa-hand",
            label = 'Craft',
            action = function()
                TriggerEvent('qb-crafting:client:OpenMainCraft', Config.BunkerCrafting)
            end,
        }
    },
    distance = 2.0
  })
end)
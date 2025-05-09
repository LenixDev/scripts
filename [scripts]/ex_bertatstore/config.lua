Config = {}

Config.type = "QBCORE" --- or QBCORE

Config.skinstyle = "qb-clothing"   ---- qb-clothing, esx_skin, ownsystem , custom  (for save)

Config.dovmeliste = json.decode(LoadResourceFile(GetCurrentResourceName(), 'dovmeler.json'))

Customedit = function(skin)
   print(json.encode(skin))
 end

Config.BarberStores = {
       ----- store 1-----------------------------------------------------------

    {
        ['storename'] = "Barber Store",
        ['storedrawtext'] = "Barber Store [E]",
        ['storecoords'] = {["x"]= -814.3,["y"] = -183.8, ["z"] = 36.6,["h"] = 96}, 
        ['storeblips'] = {['blipshow'] = true, ['blipsprite'] = 71, ['blipcolor'] = 3, ['blipscale'] = 0.8}, 
        ['storemarkers'] = {['markertype'] = 27,['markersize']= 0.7, ['markercolor'] = {['r'] = 255, ['g'] = 0 , ['b'] = 0}},
        ['storeprice'] = 2000,
        ['storecategory'] = {
            ['hair'] = false,
            ['bread'] = false,
            ['makeup'] = false,
            ['tattoo'] = true
        }
    },

    {
        ['storename'] = "Barber Store",
        ['storedrawtext'] = "Barber Store [E]",
        ['storecoords'] = {["x"]= 136.826,["y"] = -1708.373, ["z"] = 28.291,["h"] = 96}, 
        ['storeblips'] = {['blipshow'] = true, ['blipsprite'] = 71, ['blipcolor'] = 3, ['blipscale'] = 0.8}, 
        ['storemarkers'] = {['markertype'] = 27,['markersize']= 0.7, ['markercolor'] = {['r'] = 255, ['g'] = 0 , ['b'] = 0}},
        ['storeprice'] = 2000,
        ['storecategory'] = {
            ['hair'] = false,
            ['bread'] = false,
            ['makeup'] = false,
            ['tattoo'] = true
        }
    }

    
}


if Config.type == "ESX" then
ESX = exports['es_extended']:getSharedObject()
elseif Config.type == "QBCORE" then
QBCore = exports['qb-core']:GetCoreObject()
end

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local showMarker1 = false
local waitingKey1 = false


------ cam ---------------------------------------

local kamera = -1
local kameradogrultu = 0.0
local zoom = "genel"
local kameraktif = false
local camOffset, zoomOffset = 1.8, 0.0
local dondurme = 0
local orderlist = {}
local totalmoney = 0
local oldskin = nil
local yesinmenu = false
---------------------------------------------------------------

Citizen.CreateThread(function()
    for k,v in pairs(Config.StoreList) do
       if v.storeblips.blipshow then
            local blip = AddBlipForCoord(v.storecoords.x,v.storecoords.y,v.storecoords.z)
            SetBlipSprite(blip, v.storeblips.blipsprite)
            SetBlipColour(blip, v.storeblips.blipcolor)
            SetBlipScale(blip, v.storeblips.blipscale)
    
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.storename)
            EndTextCommandSetBlipName(blip)
       end
     
    end
    
end)



if Config.type == "ESX" then
  if Config.skinstyle == "ownsystem" then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded',function()
        TriggerServerEvent('ex_clothingstore:getinfos')

    end)
  end
elseif Config.type == "QBCORE" then
  if Config.skinstyle == "ownsystem" then  
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        TriggerServerEvent('ex_clothingstore:getinfos')

    end)
 end
end




function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(PlayerPedId(), i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(PlayerPedId(), i)}
    end
    return props
end



-------------------------------------- clothing insert valuesss bro --------------------------------------------------------------------------------------------------------------------------------------------------------------------


function controlblacklist(number, list)
    local deger = false
    for k,v in pairs(list) do
        if tonumber(v) == tonumber(number) then
            deger = true 
            break
        end
    end

    return deger

end


function torsovalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[11][2])
    local torsolist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
            -- print(i)
        --    for c,d in pairs(currentdata.storecategorysettings.Jackets.changeset.male) do
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Jackets.blacklist)
             if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Jackets.changeset.male[tostring(i)]
                if buitem then
                    
                       torsolist[#torsolist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "torso_1"  , ["itemimage"] = buitem.itemimage}
                    
                else
                 
                      torsolist[#torsolist + 1] = {["itemname"] =  "Jacket #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Jackets.factor) , ["itemvaluename"] = "torso_1" , ["itemimage"] = "categoryicons/torso.svg" }
                
                end
             end
               

        --    end
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
         

            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Jackets.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Jackets.changeset.female[tostring(i)]
                if buitem then
                    torsolist[#torsolist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "torso_1" , ["itemimage"] = buitem.itemimage  }
                else
                    torsolist[#torsolist + 1] = {["itemname"] =  "Jacket #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Jackets.factor) , ["itemvaluename"] = "torso_1", ["itemimage"] = "categoryicons/torso.svg" }
    
                end
            end


            
        end
    end
    
    return torsolist
end




function tshirtvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[8][2])
    local tshirtlist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Tshirt.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Tshirt.changeset.male[tostring(i)]

                if buitem then
                    tshirtlist[#tshirtlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "tshirt_1" , ["itemimage"] = buitem.itemimage  }
                else
                    tshirtlist[#tshirtlist + 1] = {["itemname"] =  "Tshirt #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Tshirt.factor) , ["itemvaluename"] = "tshirt_1" , ["itemimage"] = "categoryicons/tshirt.svg" }

                end
            end
               

      
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
         
                local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Tshirt.blacklist)
                if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Tshirt.changeset.female[tostring(i)]
                    if buitem then
                        tshirtlist[#tshirtlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "tshirt_1" , ["itemimage"] = buitem.itemimage }
                    else
                        tshirtlist[#tshirtlist + 1] = {["itemname"] =  "Tshirt #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Tshirt.factor) , ["itemvaluename"] = "tshirt_1" ,["itemimage"] = "categoryicons/tshirt.svg" }
        
                    end
                end

         
            
        end
    end
    
    return tshirtlist
end



function pantsvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[4][2])
    local pantslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
           
                local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Pants.blacklist)
                if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Pants.changeset.male[tostring(i)]

                    if buitem then
                        pantslist[#pantslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "pants_1" ,  ["itemimage"] = buitem.itemimage }
                    else
                        pantslist[#pantslist + 1] = {["itemname"] =  "Pants #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Pants.factor) , ["itemvaluename"] = "pants_1" , ["itemimage"] = "categoryicons/pants.svg" }

                    end
                end
               

          
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
           
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Pants.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Pants.changeset.female[tostring(i)]
                if buitem then
                    pantslist[#pantslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "pants_1" , ["itemimage"] = buitem.itemimage  }
                else
                    pantslist[#pantslist + 1] = {["itemname"] =  "Pants #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Pants.factor) , ["itemvaluename"] = "pants_1", ["itemimage"] = "categoryicons/pants.svg"  }
    
                end
            end

         
            
        end
    end
    
    return pantslist
end




function shoesvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[6][2])
    local shoeslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
     
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Shoes.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Shoes.changeset.male[tostring(i)]

                if buitem then
                    shoeslist[#shoeslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "shoes_1" ,  ["itemimage"] = buitem.itemimage }
                else
                    shoeslist[#shoeslist + 1] = {["itemname"] =  "Shoes #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Shoes.factor) , ["itemvaluename"] = "shoes_1" , ["itemimage"] = "categoryicons/shoes.svg" }

                end
            end
               

        
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
        
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Shoes.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Shoes.changeset.female[tostring(i)]

                if buitem then
                    shoeslist[#shoeslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "shoes_1" , ["itemimage"] = buitem.itemimage  }
                else
                    shoeslist[#shoeslist + 1] = {["itemname"] =  "Shoes #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Shoes.factor) , ["itemvaluename"] = "shoes_1" , ["itemimage"] = "categoryicons/shoes.svg" }
    
                end
            end

       
            
        end
    end
    
    return shoeslist
end




function armsvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[3][2])
    local armslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do

            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Arms.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Arms.changeset.male[tostring(i)]

                if buitem then
                    armslist[#armslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "arms_1" , ["itemimage"] = buitem.itemimage }
                else
                    armslist[#armslist + 1] = {["itemname"] =  "Arms #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Arms.factor) , ["itemvaluename"] = "arms_1", ["itemimage"] = "categoryicons/arms.svg" }

                end
            end
            

     
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
            
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Arms.blacklist)
            if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Arms.changeset.female[tostring(i)]

                if buitem then
                    armslist[#armslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "arms_1" , ["itemimage"] = buitem.itemimage }
                else
                    armslist[#armslist + 1] = {["itemname"] =  "Arms #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Arms.factor) , ["itemvaluename"] = "arms_1" , ["itemimage"] = "categoryicons/arms.svg" }
    
                end
            end

        
            
        end
    end
    
    return armslist
end



function maskvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[1][2])
    local masklist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
         
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Mask.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Mask.changeset.male[tostring(i)]

                if buitem then
                    masklist[#masklist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "mask_1", ["itemimage"] = buitem.itemimage }
                else
                    masklist[#masklist + 1] = {["itemname"] =  "Mask #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Mask.factor) , ["itemvaluename"] = "mask_1" , ["itemimage"] = "categoryicons/mask.svg" }

                end
            end
            

   
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
           
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Mask.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Mask.changeset.female[tostring(i)]
                if buitem then
                    masklist[#masklist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "mask_1" , ["itemimage"] = buitem.itemimage }
                else
                    masklist[#masklist + 1] = {["itemname"] =  "Mask #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Mask.factor) , ["itemvaluename"] = "mask_1" , ["itemimage"] = "categoryicons/mask.svg" }

                end
            end

           
            
        end
    end
    
    return masklist
end



function glassesvalues(currentdata)
    local deneme = tonumber(GetPropDrawablesTotal()[1][2])
    local glasseslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Glasses.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Glasses.changeset.male[tostring(i)]

                if buitem then
                    glasseslist[#glasseslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "glasses_1" , ["itemimage"] = buitem.itemimage }
                else
                    glasseslist[#glasseslist + 1] = {["itemname"] =  "Glasses #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Glasses.factor) , ["itemvaluename"] = "glasses_1" , ["itemimage"] = "categoryicons/glasses.svg" }

                end
            end
               

        
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
            
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Glasses.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Glasses.changeset.female[tostring(i)]

                if buitem then
                    glasseslist[#glasseslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "glasses_1" , ["itemimage"] = buitem.itemimage }
                else
                    glasseslist[#glasseslist + 1] = {["itemname"] =  "Glasses #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Glasses.factor) , ["itemvaluename"] = "glasses_1" , ["itemimage"] = "categoryicons/glasses.svg" }
    
                end
            end

         
            
        end
    end
    
    return glasseslist
end



function earringsvalues(currentdata)
    local deneme = tonumber(GetPropDrawablesTotal()[2][2])
    local earringslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Earrings.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Earrings.changeset.male[tostring(i)]

                if buitem then
                    earringslist[#earringslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "ears_1" , ["itemimage"] = buitem.itemimage }
                else
                    earringslist[#earringslist + 1] = {["itemname"] =  "Earring #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Earrings.factor) , ["itemvaluename"] = "ears_1" , ["itemimage"] = "categoryicons/ears.svg" }

                end
            end
            

     
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
            
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Earrings.blacklist)
            if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Earrings.changeset.female[tostring(i)]

                if buitem then
                    earringslist[#earringslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "ears_1", ["itemimage"] = buitem.itemimage }
                else
                    earringslist[#earringslist + 1] = {["itemname"] =  "Earring #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Earrings.factor) , ["itemvaluename"] = "ears_1" , ["itemimage"] = "categoryicons/ears.svg" }
    
                end
            end

          
            
        end
    end
    
    return earringslist
end




function vestvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[9][2])
    local vestlist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Vest.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Vest.changeset.male[tostring(i)]

                if buitem then
                    vestlist[#vestlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "vest_1" , ["itemimage"] = buitem.itemimage }
                else
                    vestlist[#vestlist + 1] = {["itemname"] =  "Vest #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Vest.factor) , ["itemvaluename"] = "vest_1" , ["itemimage"] = "categoryicons/vest.svg" }

                end
            end
               

       
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
        
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Vest.blacklist)
            if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Vest.changeset.female[tostring(i)]

                if buitem then
                    vestlist[#vestlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "vest_1" , ["itemimage"] = buitem.itemimage }
                else
                    vestlist[#vestlist + 1] = {["itemname"] =  "Vest #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Vest.factor) , ["itemvaluename"] = "vest_1" , ["itemimage"] = "categoryicons/vest.svg" }
    
                end
            end

          
            
        end
    end
    
    return vestlist
end



function helmetvalues(currentdata)
    local deneme = tonumber(GetPropDrawablesTotal()[0][2])
    local helmetlist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Helmet.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Helmet.changeset.male[tostring(i)]

                if buitem then
                    helmetlist[#helmetlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "helmet_1" , ["itemimage"] = buitem.itemimage }
                else
                    helmetlist[#helmetlist + 1] = {["itemname"] =  "Helmet #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Helmet.factor) , ["itemvaluename"] = "helmet_1" , ["itemimage"] = "categoryicons/helmet.svg" }

                end
            end
               

          
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
           
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Helmet.blacklist)
            if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Helmet.changeset.female[tostring(i)]
                
                if buitem then
                    helmetlist[#helmetlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "helmet_1" , ["itemimage"] = buitem.itemimage }
                else
                    helmetlist[#helmetlist + 1] = {["itemname"] =  "Helmet #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Helmet.factor) , ["itemvaluename"] = "helmet_1" , ["itemimage"] = "categoryicons/helmet.svg" }
    
                end
            end

    
            
        end
    end
    
    return helmetlist
end



function chainvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[7][2])
    local chainlist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Chain.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Chain.changeset.male[tostring(i)]

                if buitem then
                    chainlist[#chainlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "chain_1" , ["itemimage"] = buitem.itemimage }
                else
                    chainlist[#chainlist + 1] = {["itemname"] =  "Chain #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Chain.factor) , ["itemvaluename"] = "chain_1" , ["itemimage"] = "categoryicons/chain.svg" }

                end
            end
               

         
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
        
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Chain.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Chain.changeset.female[tostring(i)]

                if buitem then
                    chainlist[#chainlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "chain_1" , ["itemimage"] = buitem.itemimage }
                else
                    chainlist[#chainlist + 1] = {["itemname"] =  "Chain #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Chain.factor) , ["itemvaluename"] = "chain_1" , ["itemimage"] = "categoryicons/chain.svg" }
    
                end
            end

          
            
        end
    end
    
    return chainlist
end



function bagvalues(currentdata)
    local deneme = tonumber(GetDrawablesTotal()[5][2])
    local baglist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Bag.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Bag.changeset.male[tostring(i)]

                if buitem then
                    baglist[#baglist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "bag_1" , ["itemimage"] = buitem.itemimage }
                else
                    baglist[#baglist + 1] = {["itemname"] =  "Bag #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Bag.factor) , ["itemvaluename"] = "bag_1" , ["itemimage"] = "categoryicons/bag.svg" }

                end
            end
               

          
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
           
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Bag.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Bag.changeset.female[tostring(i)]

                if buitem then
                    baglist[#baglist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "bag_1" , ["itemimage"] = dbuitem.itemimage }
                else
                    baglist[#baglist + 1] = {["itemname"] =  "Bag #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Bag.factor) , ["itemvaluename"] = "bag_1" , ["itemimage"] = "categoryicons/bag.svg" }
    
                end
            end

          
            
        end
    end
    
    return baglist
end




function watchesvalues(currentdata)
    local deneme = tonumber(GetPropDrawablesTotal()[6][2])
    local watchlist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
          
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Watch.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Watch.changeset.male[tostring(i)]

                if buitem then
                    watchlist[#watchlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "watches_1" , ["itemimage"] = buitem.itemimage }
                else
                    watchlist[#watchlist + 1] = {["itemname"] =  "Watch #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Watch.factor) , ["itemvaluename"] = "watches_1" , ["itemimage"] = "categoryicons/watches.svg" }

                end
            end
               

         
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
            
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Watch.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Watch.changeset.female[tostring(i)]

                if buitem then
                    watchlist[#watchlist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "watches_1" , ["itemimage"] = buitem.itemimage }
                else
                    watchlist[#watchlist + 1] = {["itemname"] =  "Watch #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Watch.factor) , ["itemvaluename"] = "watches_1" , ["itemimage"] = "categoryicons/watches.svg" }
    
                end
            end

         
            
        end
    end
    
    return watchlist
end



function braceletsvalues(currentdata)
    local deneme = tonumber(GetPropDrawablesTotal()[7][2])
    local braceletslist = {}
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        for i=1,tonumber(deneme) do
        
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Bracelets.blacklist)
            if checkblacklist == false then
                local buitem = currentdata.storecategorysettings.Bracelets.changeset.male[tostring(i)]

                if buitem then
                    braceletslist[#braceletslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "bracelets_1" , ["itemimage"] = buitem.itemimage }
                else
                    braceletslist[#braceletslist + 1] = {["itemname"] =  "Bracelets #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Bracelets.factor) , ["itemvaluename"] = "bracelets_1" , ["itemimage"] = "categoryicons/bracelets.svg" }

                end
            end
               

         
          
            
        end
    else
        for i=1,tonumber(deneme) do
    
        
            local checkblacklist = controlblacklist(i, currentdata.storecategorysettings.Bracelets.blacklist)
            if checkblacklist == false then
                    local buitem = currentdata.storecategorysettings.Bracelets.changeset.female[tostring(i)]
                
                if buitem then
                    braceletslist[#braceletslist + 1] = {["itemname"] =  buitem.itemname, ["itemvalue"] = i , ["itemprice"] = buitem.itemprice, ["itemvaluename"] = "bracelets_1" , ["itemimage"] = buitem.itemimage }
            
                    braceletslist[#braceletslist + 1] = {["itemname"] =  "Bracelets #"..i, ["itemvalue"] = i , ["itemprice"] = i * tonumber(currentdata.storecategorysettings.Bracelets.factor) , ["itemvaluename"] = "bracelets_1" , ["itemimage"] = "categoryicons/bracelets.svg" }
    
                end
            end

        
            
        end
    end
    
    return braceletslist
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function ShowMarker1(type, koord, markers, textt)
    Citizen.CreateThread(function()
        while showMarker1 == type do
            Citizen.Wait(1)
            if yesinmenu == false then
            DrawText3D(vector3(koord.x, koord.y, koord.z +0.8), textt)

              DrawMarker(markers.markertype, koord, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, tonumber(markers.markersize), tonumber(markers.markersize), tonumber(markers.markersize), markers.markercolor.r, markers.markercolor.g,markers.markercolor.b, 100, false, true, 2, true, nil, nil, false)
            else
                Citizen.Wait(500)
            end
        end
    end)
end

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    -- DrawRect(0.0, 0.0105, 0.010 + text:gsub('~.-~', ''):len() / 170, 0.03, 35, 35, 35, 50)
    ClearDrawOrigin()
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
      
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist
            for k,v in pairs(Config.StoreList) do
				
                dist = #(pedCoords - vector3(v.storecoords.x,v.storecoords.y,v.storecoords.z))
                if dist < 3 then
                    if not showMarker1 then
                        showMarker1 = k
                      
                        ShowMarker1(k, vector3(v.storecoords.x,v.storecoords.y,v.storecoords.z), v.storemarkers, v.storedrawtext)
                
                    end
                    if dist < 1.5 then
                        if not waitingKey1 then
                            waitingKey1 = k
                            WaitingKeys1(k, v)
                            
                        end
                    else 
                        waitingKey1 = false
                        
                    end
                elseif showMarker1 == k then
                    showMarker1 = false
                    
                end
				
            end
       
    end
end)



function WaitingKeys1(type, maindata)
    Citizen.CreateThread(function()
        while waitingKey1 == type do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
                local allcompanents = {['torso'] = torsovalues(maindata),['tshirt'] =tshirtvalues(maindata),['pants'] =pantsvalues(maindata),['shoes'] =shoesvalues(maindata),['arms'] =armsvalues(maindata),['mask'] =maskvalues(maindata),['glasses'] =glassesvalues(maindata),['ears'] =earringsvalues(maindata) ,['vest'] =vestvalues(maindata) ,['helmet'] =helmetvalues(maindata) ,['chain'] =chainvalues(maindata),['bag'] =bagvalues(maindata),['watches'] =watchesvalues(maindata),['bracelets'] =braceletsvalues(maindata)}
				local companentstate = {['torso'] = maindata.storecategorysettings.Jackets.state,['tshirt'] =maindata.storecategorysettings.Tshirt.state,['pants'] =maindata.storecategorysettings.Pants.state,['shoes'] = maindata.storecategorysettings.Shoes.state,['arms'] =maindata.storecategorysettings.Arms.state,['mask'] =maindata.storecategorysettings.Mask.state,['glasses'] =maindata.storecategorysettings.Glasses.state,['ears'] = maindata.storecategorysettings.Earrings.state ,['vest'] = maindata.storecategorysettings.Vest.state ,['helmet'] = maindata.storecategorysettings.Helmet.state ,['chain'] = maindata.storecategorysettings.Chain.state,['bag'] =maindata.storecategorysettings.Bag.state,['watches'] = maindata.storecategorysettings.Watch.state,['bracelets'] = maindata.storecategorysettings.Bracelets.state}
                SetNuiFocus(true, true)
                oldskin = getoldskin()
                yesinmenu = true
                SendNUIMessage({
                    action = "storeopen",
                    companents = allcompanents,
                    states = companentstate,
                    orderlist = orderlist,
                    totalprice = totalmoney

                })

                CreateCamBro()

            end
        end
    end)
end


function CreateCamBro() 
    if not DoesCamExist(kamera) then
        kamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    SetCamActive(kamera, true)
    RenderScriptCams(true, true, 500, true, true)

    local playerPed = PlayerPedId()
    local playerHeading = GetEntityHeading(playerPed)
    FreezeEntityPosition(playerPed, false)
    if playerHeading + 94 < 360.0 then
        kameradogrultu = playerHeading + 94.0
    elseif playerHeading + 94 >= 360.0 then
        kameradogrultu = playerHeading - 266.0 --194
    end
    dondurme = kameradogrultu
    kameraktif = true
    SetCamCoord(kamera, GetEntityCoords(GetPlayerPed(-1)))

end


function texturesnui(coming)


    SendNUIMessage({
        action = "texturenui",
        comingtextures = coming,
        texturesimiz = GetTextureTotals()[tostring(coming)]

    })
end


function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(PlayerPedId(), idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(PlayerPedId(), idx, value)
    end
    return values
end
function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == 'mp_f_freemode_01' or model == 'mp_m_freemode_01') then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(PlayerPedId(), i) == -1 then
            SetPedComponentVariation(PlayerPedId(), i, 15, 0, 2)
        end
        drawables[tonumber(i)] = {drawable_names[i+1], GetPedDrawableVariation(PlayerPedId(), i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(PlayerPedId(), i)}
    end
    return props
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if kameraktif == true then
            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)

            -- DisplayHud(false)
            -- DisplayRadar(false)


            if zoom == "kafa" then
                zoomOffset = 0.5
                camOffset = 0.7
            elseif zoom == "gozburun" then
                zoomOffset = 0.4
                camOffset = 0.7
            elseif zoom == "ust" then
                zoomOffset = 1.2
                camOffset = 0.5
            elseif zoom == "pantolon" then
                zoomOffset = 1.2
                camOffset = -0.3
            elseif zoom == "genel" then
                zoomOffset = 1.8
                camOffset = 0.0
            elseif zoom == "ayakkabi" then
                zoomOffset = 1.0
                camOffset = -0.8
            end
            local angle = kameradogrultu * math.pi / 180.0
            local theta = {
                x = math.cos(angle),
                y = math.sin(angle)
            }

            local pos = {
                x = coords.x + (zoomOffset * theta.x),
                y = coords.y + (zoomOffset * theta.y)
            }

            local angleToLook = kameradogrultu - 180.0 --140.0
            if angleToLook > 360 then
                angleToLook = angleToLook - 360
            elseif angleToLook < 0 then
                angleToLook = angleToLook + 360
            end

            angleToLook = angleToLook * math.pi / 180.0
            local thetaToLook = {
                x = math.cos(angleToLook),
                y = math.sin(angleToLook)
            }

            local posToLook = {
                x = coords.x + (zoomOffset * thetaToLook.x),
                y = coords.y + (zoomOffset * thetaToLook.y)
            }

            SetCamCoord(kamera, pos.x, pos.y, coords.z + camOffset)
            PointCamAtCoord(kamera, posToLook.x, posToLook.y, coords.z + camOffset)
        else
            Citizen.Wait(500)
        end
    end

end)


RegisterNUICallback('texturechange', function(data)
    local playerPed = PlayerPedId()
    if data.clothingtype == "torso_1" then


        SetPedComponentVariation(playerPed, 11, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
       
    elseif data.clothingtype == "tshirt_1" then
        SetPedComponentVariation(playerPed, 8, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
     
    elseif data.clothingtype == "shoes_1" then
        SetPedComponentVariation(playerPed, 6, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
        
    
    elseif data.clothingtype == "pants_1" then
        SetPedComponentVariation(playerPed, 4, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
      
 
    elseif data.clothingtype == "vest_1" then
        SetPedComponentVariation(playerPed, 9, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
     
   
    elseif data.clothingtype == "mask_1" then
        SetPedComponentVariation(playerPed, 1, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
     
      
    elseif data.clothingtype == "arms_1" then
        SetPedComponentVariation(playerPed, 3, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
 
     
    elseif data.clothingtype == "bag_1" then
        SetPedComponentVariation(playerPed, 5, tonumber(data.clothingvalue),  tonumber(data.texturevalue),  2)
       

    elseif data.clothingtype == "glasses_1" then
        SetPedPropIndex(playerPed, 1, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2)
     
    elseif data.clothingtype == "watches_1" then
        SetPedPropIndex(playerPed, 6, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2)
      
    elseif data.clothingtype == "ears_1" then
        SetPedPropIndex(playerPed, 2, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2)
    
    elseif data.clothingtype == "helmet_1" then
        SetPedPropIndex(playerPed, 0, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2)
      
    elseif data.clothingtype == "chain_1" then
      SetPedComponentVariation(playerPed, 7, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2) 
 
    elseif data.clothingtype == "bracelets_1" then
        SetPedPropIndex(playerPed, 7, tonumber(data.clothingvalue), tonumber(data.texturevalue), 2)
      
    
    end
end)



RegisterNUICallback('showthiscloth', function(data)

    local playerPed = PlayerPedId()
    if data.itemvaluename == "torso_1" then
        SetPedComponentVariation(playerPed, 11, data.itemvalue,  0,  2)
        texturesnui("jackets")
    elseif data.itemvaluename == "tshirt_1" then
        SetPedComponentVariation(playerPed, 8, data.itemvalue,  0,  2)
        texturesnui("undershirts")
    elseif data.itemvaluename == "shoes_1" then
        SetPedComponentVariation(playerPed, 6, data.itemvalue,  0,  2)
        texturesnui("shoes")
    
    elseif data.itemvaluename == "pants_1" then
        SetPedComponentVariation(playerPed, 4, data.itemvalue,  0,  2)
        texturesnui("legs")
 
    elseif data.itemvaluename == "vest_1" then
        SetPedComponentVariation(playerPed, 9, data.itemvalue,  0,  2)
        texturesnui("vest")
   
    elseif data.itemvaluename == "mask_1" then
        SetPedComponentVariation(playerPed, 1, data.itemvalue,  0,  2)
        texturesnui("masks")
      
    elseif data.itemvaluename == "arms_1" then
        SetPedComponentVariation(playerPed, 3, data.itemvalue,  0,  2)
        texturesnui("arms")
     
    elseif data.itemvaluename == "bag_1" then
        SetPedComponentVariation(playerPed, 5, data.itemvalue,  0,  2)
        texturesnui("bags")

    elseif data.itemvaluename == "glasses_1" then
        SetPedPropIndex(playerPed, 1, data.itemvalue, 0, 2)
        texturesnui("glasses")
    elseif data.itemvaluename == "watches_1" then
        SetPedPropIndex(playerPed, 6, data.itemvalue, 0, 2)
        texturesnui("watches")
    elseif data.itemvaluename == "ears_1" then
        SetPedPropIndex(playerPed, 2, data.itemvalue, 0, 2)
        texturesnui("earrings")
    elseif data.itemvaluename == "helmet_1" then
        SetPedPropIndex(playerPed, 0, data.itemvalue, 0, 2)
        texturesnui("hats")
    elseif data.itemvaluename == "chain_1" then
      SetPedComponentVariation(playerPed, 7, data.itemvalue, 0, 2) 
      texturesnui("neck")
    elseif data.itemvaluename == "bracelets_1" then
        SetPedPropIndex(playerPed, 7, data.itemvalue, 0, 2)
        texturesnui("braclets")
    
    end
end)


RegisterNUICallback('addinorder', function(data)
    local order = data.orderinfo1
    order.texture = data.orderinfo2

    for k,v in pairs(orderlist) do
        if v.itemvaluename == order.itemvaluename then
            return
        end
    end
    table.insert( orderlist, order )
    totalmoney =  tonumber(totalmoney) + tonumber(order.itemprice)

    refreshordernui()


end)

RegisterNuiCallback('deleteorder', function(data)
   
    local deleteprice = orderlist[data].itemprice
    totalmoney = tonumber(totalmoney) - tonumber(deleteprice)
    table.remove( orderlist, data )
    refreshordernui()
end)


function refreshordernui( )
    SendNUIMessage({
        action = "refreshorder",
        orderlist = orderlist,
        totalmoney = totalmoney
    })
end


RegisterNuiCallback('pay', function(data)
    if Config.Wardrobe == false then
       TriggerServerEvent('ex_clothingstore:pay:server', orderlist,totalmoney,data.data)
    else
        opensavenui()
    end
end)

RegisterNuiCallback('pay2', function(data)
    
    TriggerServerEvent('ex_clothingstore:pay:server', orderlist,totalmoney,data.data)
   
end)

RegisterNuiCallback('pay3', function(data)
    
    TriggerServerEvent('ex_clothingstore:paywithsave:server', orderlist,totalmoney,data.data, data.wardrobename)
   
end)

function opensavenui()
    SendNUIMessage({
        action = "opensavepart"
      
    })
end


RegisterNetEvent('ex_clothingstore:confirmbuy')
AddEventHandler('ex_clothingstore:confirmbuy', function(order)
   if Config.skinstyle == "esx_skin" then
    setoldskin(oldskin)
    insertnewclothings(order)
    Wait(300)
    TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerServerEvent('ex_clothingstore:saveownesx', getoldskin(), skin)
    end)
   elseif Config.skinstyle == "qb-clothing" then

    setoldskin(oldskin)
    Wait(300)
    insertnewclothings(order)
    Wait(100)
    TriggerServerEvent('ex_clothingstore:saveownqb', getoldskin())
   elseif Config.skinstyle == "ownsystem" then
    
    
    setoldskin(oldskin)
    Wait(300)
    insertnewclothings(order)
    Wait(100)
    TriggerServerEvent('ex_clothingstore:saveown', getoldskin())
 
   elseif Config.skinstyle == "custom" then
    local skinlistbeye = getserverskins(order)
    Customedit(skinlistbeye)

   end
   
   if Config.forinventorys == true then
    local skinlistbeye = getserverskins(order)
    Forlikeinventorys(skinlistbeye)
   end

   yesinmenu = false
   orderlist = {}
   totalmoney = 0

   

   closestore()
end)



function getserverskins(skinlist)
    local skinbeya = {}
    for k,v in pairs(skinlist) do
      
        local skinzero = v.itemvaluename:gsub('%_1', '')
        local text1 = tostring(skinzero.."_1")
        local text2 = tostring(skinzero.."_2")

        skinbeya[text1] = v.itemvalue
        skinbeya[text2] = v.texture

    end

    return skinbeya
end

if Config.usedemowardrobecommand then 

    RegisterCommand('wardrobedemo', function()

        TriggerEvent('ex_clothingstore:wardrobe')
    end)
end

RegisterNetEvent('ex_clothingstore:wardrobe')
AddEventHandler('ex_clothingstore:wardrobe', function()
   TriggerServerEvent('ex_clothingstore:wardrobeinfo')
end)

RegisterNetEvent('ex_clothingstore:setclothe')
AddEventHandler('ex_clothingstore:setclothe', function(comingskin)
    setoldskin(comingskin)
end)


RegisterNetEvent('ex_clothingstore:openwardrobenui')
AddEventHandler('ex_clothingstore:openwardrobenui', function(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "wardrobeopen",
        wardrobeinfo = data
       
    })
    
end)


function closestore()
   SetNuiFocus(false,false)
   Kameraiptal2()
   SendNUIMessage({
    action = "closestore"
   
})
end

RegisterNuiCallback('useward', function(data)

    TriggerServerEvent('ex_clothingstore:useward', data.wardid)
end)


RegisterNuiCallback('closenuiward', function()

    SetNuiFocus(false,false)
end)



RegisterNuiCallback('deleteward', function(data)

    TriggerServerEvent('ex_clothingstore:deleteward', data.wardid)
end)

RegisterNetEvent('ex_clothingstore:sendnewwardrobe')
AddEventHandler('ex_clothingstore:sendnewwardrobe', function(data)
    SendNUIMessage({
        action = "rewardrobe",
        wardrobeinfo = data
       
    })
end)


RegisterNetEvent('ex_clothingstore:useward:client')
AddEventHandler('ex_clothingstore:useward:client', function(comeskin)
    setwardrobec(comeskin.skin)
    SetNuiFocus(false, false)
    local AnimSet = "clothingspecs"
    local AnimationOn = "take_off"
    local AnimationOff = "take_off"
    loadAnimDict( AnimSet )
    TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOff, 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Citizen.Wait(500)
    ClearPedTasks(PlayerPedId())
end)


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function setwardrobec(data )

    for k,v in pairs(data) do
        local playerPed = PlayerPedId()
       
        if k == "torso_1" then
    
    
            SetPedComponentVariation(playerPed, 11, tonumber(data.torso_1),  tonumber(data.torso_2),  2)
           
        elseif k == "tshirt_1" then
            SetPedComponentVariation(playerPed, 8, tonumber(data.tshirt_1),  tonumber(data.tshirt_2),  2)
         
        elseif k == "shoes_1" then
            SetPedComponentVariation(playerPed, 6, tonumber(data.shoes_1),  tonumber(data.shoes_2),  2)
            
        
        elseif k == "pants_1" then
            SetPedComponentVariation(playerPed, 4, tonumber(data.pants_1),  tonumber(data.pants_2),  2)
           
     
        elseif k == "vest_1" then
            SetPedComponentVariation(playerPed, 9, tonumber(data.vest_1),  tonumber(data.vest_2),  2)
         
       
        elseif k == "mask_1" then
            
           
            SetPedComponentVariation(playerPed, 1, tonumber(data.mask_1),  tonumber(data.mask_2),  2)
         
          
        elseif k == "arms_1" then
            SetPedComponentVariation(playerPed, 3, tonumber(data.arms_1),  tonumber(data.arms_2),  2)
     
         
        elseif k == "bag_1" then
            SetPedComponentVariation(playerPed, 5, tonumber(data.bag_1),  tonumber(data.bag_2),  2)
           
    
        elseif k == "glasses_1" then
            SetPedPropIndex(playerPed, 1, tonumber(data.glasses_1), tonumber(data.glasses_2), 2)
         
        elseif k == "watches_1" then
            SetPedPropIndex(playerPed, 6, tonumber(data.watches_1), tonumber(data.watches_2), 2)
          
        elseif k == "ears_1" then
            SetPedPropIndex(playerPed, 2, tonumber(data.ears_1), tonumber(data.ears_2), 2)
        
        elseif k == "helmet_1" then
            SetPedPropIndex(playerPed, 0, tonumber(data.helmet_1), tonumber(data.helmet_2), 2)
          
        elseif k == "chain_1" then
          SetPedComponentVariation(playerPed, 7, tonumber(data.chain_1), tonumber(data.chain_2), 2) 
     
        elseif k == "bracelets_1" then
            SetPedPropIndex(playerPed, 7, tonumber(data.bracelets_1), tonumber(data.bracelets_2), 2)
          
        
        end
    end
end

function setoldskin(skin)
    local playerPed = PlayerPedId()
 
    SetPedComponentVariation(playerPed, 11, tonumber(skin.torso_1),  tonumber(skin.torso_2),  2)
    SetPedComponentVariation(playerPed, 8, tonumber(skin.tshirt_1),  tonumber(skin.tshirt_2),  2)
    SetPedComponentVariation(playerPed, 6, tonumber(skin.shoes_1),  tonumber(skin.shoes_2),  2)
    SetPedComponentVariation(playerPed, 4, tonumber(skin.pants_1),  tonumber(skin.pants_2),  2)
    SetPedComponentVariation(playerPed, 9, tonumber(skin.vest_1),  tonumber(skin.vest_2),  2)
    SetPedComponentVariation(playerPed, 1, tonumber(skin.mask_1),  tonumber(skin.mask_2),  2)
    SetPedComponentVariation(playerPed, 3, tonumber(skin.arms),  tonumber(skin.arms_2),  2)
    SetPedComponentVariation(playerPed, 5, tonumber(skin.bags_1),  tonumber(skin.bags_2),  2)
    SetPedComponentVariation(playerPed, 7,  tonumber(skin.chain_1),  tonumber(skin.chain_2), 2)

    if tonumber(skin.glasses_1) == -1 then
        ClearPedProp(playerPed, 1)
    else
        SetPedPropIndex(playerPed, 1, tonumber(skin.glasses_1), tonumber(skin.glasses_2), 2)
    end


    if tonumber(skin.watches_1) == -1 then
        ClearPedProp(playerPed, 6)
    else
        SetPedPropIndex(playerPed, 6, tonumber(skin.watches_1), tonumber(skin.watches_2), 2)
    end

    if tonumber(skin.ears_1) == -1 then
        ClearPedProp(playerPed, 2)
    else
        SetPedPropIndex(playerPed, 2, tonumber(skin.ears_1), tonumber(skin.ears_2), 2)
    end

    if tonumber(skin.helmet_1) == -1 then
        ClearPedProp(playerPed, 0)
    else
        SetPedPropIndex(playerPed, 0, tonumber(skin.helmet_1), tonumber(skin.helmet_2), 2)
    end


    if tonumber(skin.bracelets_1) == -1 then
        ClearPedProp(playerPed, 7)
    else
        SetPedPropIndex(playerPed, 7, tonumber(skin.bracelets_1), tonumber(skin.bracelets_2), 2)
    end

   
end



RegisterNuiCallback('camerachange' , function()
    if zoom == "genel" then 
        zoom = "kafa"
    elseif zoom == "kafa" then
        zoom = "ust"
    elseif zoom == "ust" then
        zoom = "pantolon"
    elseif zoom == "pantolon" then
        zoom = "ayakkabi"
    elseif zoom == "ayakkabi" then
        zoom = "genel"
    end


end)

RegisterNuiCallback('clearprop', function()
    local playerPed = PlayerPedId()
    setoldskin(oldskin)
    ClearPedProp(playerPed, 1)
    ClearPedProp(playerPed, 6)
    ClearPedProp(playerPed, 2)
    ClearPedProp(playerPed, 0)
    ClearPedProp(playerPed, 7)
    SetPedComponentVariation(playerPed, 1,-1,  0,  2)

    if Config.skinstyle == "esx_skin" then
        
        Wait(300)
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('ex_clothingstore:saveownesx', getoldskin(), skin)
        end)
       elseif Config.skinstyle == "qb-clothing" then
        TriggerServerEvent('ex_clothingstore:saveownqb', getoldskin())
       elseif Config.skinstyle == "ownsystem" then
        
        
      
        Wait(300)
        TriggerServerEvent('ex_clothingstore:saveown', getoldskin())
        
     
       elseif Config.skinstyle == "custom" then
    
        Customedit(order)
    
    end

    oldskin = getoldskin()
end)

function getoldskin()
   
    local skin = {}
    skin.tshirt_1 = GetDrawables()[8][2]
    skin.tshirt_2 = GetDrawTextures()[9][2]
    skin.torso_1 = GetDrawables()[11][2]
    skin.torso_2 = GetDrawTextures()[12][2]
    skin.shoes_1 = GetDrawables()[6][2]
    skin.shoes_2 = GetDrawTextures()[7][2]
    skin.pants_1 = GetDrawables()[4][2]
    skin.pants_2 = GetDrawTextures()[5][2]
    skin.vest_1 = GetDrawables()[9][2]
    skin.vest_2 = GetDrawTextures()[10][2]
    skin.mask_1 = GetDrawables()[1][2]
    skin.mask_2 = GetDrawTextures()[2][2]
    skin.bags_1 = GetDrawables()[5][2]
    skin.bags_2 = GetDrawTextures()[6][2]
    skin.chain_1 = GetDrawables()[7][2]
    skin.chain_2 = GetDrawTextures()[8][2]
    skin.arms = GetDrawables()[3][2]
    skin.arms_2 = GetDrawTextures()[4][2]


    -------------------------------------------------
    skin.helmet_1 = GetProps()[0][2]
    skin.helmet_2 = GetPropTextures()[1][2]
    skin.glasses_1 = GetProps()[1][2]
    skin.glasses_2 = GetPropTextures()[2][2]
    skin.ears_1 = GetProps()[2][2]
    skin.ears_2 = GetPropTextures()[3][2]
    skin.watches_1 = GetProps()[6][2]
    skin.watches_2 = GetPropTextures()[7][2]
    skin.bracelets_1 = GetProps()[7][2]
    skin.bracelets_2 = GetPropTextures()[8][2]

  return skin

end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(PlayerPedId(), i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(PlayerPedId(), i)})
    end
    return textures
end

function insertnewclothings(data)
    for k,v in pairs(data) do
        local playerPed = PlayerPedId()
        if v.itemvaluename == "torso_1" then
    
    
            SetPedComponentVariation(playerPed, 11, tonumber(v.itemvalue),  tonumber(v.texture),  2)
           
        elseif v.itemvaluename == "tshirt_1" then
            SetPedComponentVariation(playerPed, 8, tonumber(v.itemvalue),  tonumber(v.texture),  2)
         
        elseif v.itemvaluename == "shoes_1" then
            SetPedComponentVariation(playerPed, 6, tonumber(v.itemvalue),  tonumber(v.texture),  2)
            
        
        elseif v.itemvaluename == "pants_1" then
            SetPedComponentVariation(playerPed, 4, tonumber(v.itemvalue),  tonumber(v.texture),  2)
           
     
        elseif v.itemvaluename == "vest_1" then
            SetPedComponentVariation(playerPed, 9, tonumber(v.itemvalue),  tonumber(v.texture),  2)
         
       
        elseif v.itemvaluename == "mask_1" then
            SetPedComponentVariation(playerPed, 1, tonumber(v.itemvalue),  tonumber(v.texture),  2)
         
          
        elseif v.itemvaluename == "arms_1" then
            SetPedComponentVariation(playerPed, 3, tonumber(v.itemvalue),  tonumber(v.texture),  2)
     
         
        elseif v.itemvaluename == "bag_1" then
            SetPedComponentVariation(playerPed, 5, tonumber(v.itemvalue),  tonumber(v.texture),  2)
           
    
        elseif v.itemvaluename == "glasses_1" then
            SetPedPropIndex(playerPed, 1, tonumber(v.itemvalue), tonumber(v.texture), 2)
         
        elseif v.itemvaluename == "watches_1" then
            SetPedPropIndex(playerPed, 6, tonumber(v.itemvalue), tonumber(v.texture), 2)
          
        elseif v.itemvaluename == "ears_1" then
            SetPedPropIndex(playerPed, 2, tonumber(v.itemvalue), tonumber(v.texture), 2)
        
        elseif v.itemvaluename == "helmet_1" then
            SetPedPropIndex(playerPed, 0, tonumber(v.itemvalue), tonumber(v.texture), 2)
          
        elseif v.itemvaluename == "chain_1" then
          SetPedComponentVariation(playerPed, 7, tonumber(v.itemvalue), tonumber(v.texture), 2) 
     
        elseif v.itemvaluename == "bracelets_1" then
            SetPedPropIndex(playerPed, 7, tonumber(v.itemvalue), tonumber(v.texture), 2)
          
        
        end
    end
end


function Kameraiptal2()
    kameraktif = false
    SetCamActive(kamera, false)
    RenderScriptCams(false, true, 500, true, true)
    kamera = nil
end


RegisterNuiCallback('exitstore', function( )
   setoldskin(oldskin)
   orderlist = {}
   totalmoney = 0
   closestore()
   yesinmenu = false
end)


RegisterNetEvent('ex_clothingstore:notify')
AddEventHandler('ex_clothingstore:notify', function(notifytext, time)
    SendNUIMessage({
        action = "notify",
        notifytext = notifytext,
        time = time
      
    })
end)


RegisterNUICallback('rotate', function(data)
    if data.key == "left" then
        
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 20.0)
    elseif data.key == "right" then

        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 20.0)

    end
end)
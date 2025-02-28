
if Config.type == "ESX" then
ESX = exports['es_extended']:getSharedObject()
elseif Config.type == "QBCORE" then
QBCore = exports['qb-core']:GetCoreObject()
end
    

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}

local coloritems = {{'hair_color_2'}}
local kamera = -1
local kameradogrultu = 0.0
local zoom = "ust"
local kameraktif = false
local camOffset, zoomOffset = 1.8, 0.0
local dondurme = 0
local showMarker1 = false
local waitingKey1 = false
local playercurrenttattoo = nil
local changetatto = {}
changetatto.ZONE_HEAD = nil
changetatto.ZONE_LEFT_LEG = nil
changetatto.ZONE_LEFT_ARM = nil
changetatto.ZONE_RIGHT_LEG = nil
changetatto.ZONE_TORSO = nil
changetatto.ZONE_RIGHT_ARM = nil
local toggleClothing = {}
local kiyafetcikartmis = false
local yesinmenu = false


Citizen.CreateThread(function()
    for k,v in pairs(Config.BarberStores) do
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
          TriggerServerEvent('ex_bertatstore:getinfos')
          TriggerServerEvent('ex_bertatstore:getattooinfo')
  
      end)
    elseif  Config.skinstyle == "esx_skin" or Config.skinstyle == "custom" then
        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded',function()
            TriggerServerEvent('ex_bertatstore:getattooinfo')
    
        end)
    end
  elseif Config.type == "QBCORE" then
    if Config.skinstyle == "ownsystem" then  
      RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
          TriggerServerEvent('ex_bertatstore:getinfos')
          TriggerServerEvent('ex_bertatstore:getattooinfo')
  
      end)

    elseif Config.skinstyle == "qb-clothing" or Config.skinstyle == "custom" then
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            TriggerServerEvent('ex_bertatstore:getattooinfo')
    
        end)
   end
  end

-- RegisterCommand('getbarber', function()
   
--     local maxvalue = getmaxvalue()
--     playerold = getplayerold()
--     playercurrent = getplayerold()
--     SetNuiFocus(true, true)
--     colorpalettevalue()
--     CreateCamBro()
--     SendNUIMessage({
--         action = "barberopen",
--         maxvalue = maxvalue
--     })
   
-- end)

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

function Kameraiptal2()
    kameraktif = false
    SetCamActive(kamera, false)
    RenderScriptCams(false, true, 500, true, true)
    kamera = nil
end

RegisterNetEvent('ex_bertatstore:setclothe')
AddEventHandler('ex_bertatstore:setclothe', function(comingskin)
    setoldskin(comingskin)
end)

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


function getheaddata(number)
    local info = {}
    local playerPed = PlayerPedId()
    
    local blesuccess, bleoverlayValue, blecolourType, blefirstColour, blesecondColour, bleoverlayOpacity = GetPedHeadOverlayData(playerPed, tonumber(number))
    info.value = bleoverlayValue
    info.firstcolor = blefirstColour
    info.secondcolor = blesecondColour
    info.opacity = bleoverlayOpacity



    return info
end

function getplayerold( )
    local skin = {}
    local playerPed = PlayerPedId()
    
    skin.hair_1 = GetPedDrawableVariation( playerPed, 2 )
    skin.hair_2 = GetPedTextureVariation( playerPed, 2 )
    skin.hair_color_1 = GetPedHairColor(playerPed)
    skin.hair_color_2 = GetPedHairHighlightColor(playerPed)
    skin.eye_color = GetPedEyeColor(playerPed)
    skin.blemishes_1 = getheaddata(0).value
    skin.blemishes_2 = getheaddata(0).opacity
    skin.beard_1 = getheaddata(1).value
    skin.beard_2 = getheaddata(1).opacity
    skin.beard_3 = getheaddata(1).firstcolor
    skin.beard_4 = getheaddata(1).secondcolor
    skin.eyebrows_1 = getheaddata(2).value
    skin.eyebrows_2 = getheaddata(2).opacity
    skin.eyebrows_3 = getheaddata(2).firstcolor
    skin.eyebrows_4 = getheaddata(2).secondcolor
    skin.makeup_1 = getheaddata(4).value
    skin.makeup_2 = getheaddata(4).opacity
    skin.makeup_3 = getheaddata(4).firstcolor
    skin.makeup_4 = getheaddata(4).secondcolor
    skin.lipstick_1 = getheaddata(8).value
    skin.lipstick_2 = getheaddata(8).opacity
    skin.lipstick_3 = getheaddata(8).firstcolor
    skin.lipstick_4 = getheaddata(8).secondcolor
    skin.blush_1 = getheaddata(5).value
    skin.blush_2 = getheaddata(5).opacity
    skin.blush_3 = getheaddata(5).firstcolor
    skin.complexion_1 = getheaddata(6).value
    skin.complexion_2 = getheaddata(6).opacity
    skin.sun_1 = getheaddata(7).value
    skin.sun_2 = getheaddata(7).opacity
    skin.moles_1 = getheaddata(9).value
    skin.moles_2 = getheaddata(9).opacity
    skin.chest_1 = getheaddata(10).value
    skin.chest_2 = getheaddata(10).opacity
    skin.chest_3 = getheaddata(10).firstcolor

 

    return skin

end


function getmaxvalue()
    local maxs = {}
    local playerPed = PlayerPedId()
    local getplayerskin = getplayerold()
    maxs.hair_1 = GetNumberOfPedDrawableVariations(playerPed, 2) - 1
    maxs.hair_2 = GetNumberOfPedTextureVariations(playerPed, 2, tonumber(getplayerskin.hair_1)) - 1
    maxs.hair_color_1 = GetNumHairColors() - 1
    maxs.hair_color_2 = GetNumHairColors() - 1
    maxs.eye_color = 31
    maxs.blemishes_1 = GetPedHeadOverlayNum(0) - 1
    maxs.blemishes_2 = 10
    maxs.beard_1 = GetPedHeadOverlayNum(1) - 1
    maxs.beard_2 = 10
    maxs.beard_3 = GetNumHairColors() - 1
    maxs.beard_4 = GetNumHairColors() - 1
    maxs.eyebrows_1 = GetPedHeadOverlayNum(2) - 1
    maxs.eyebrows_2 = 10
    maxs.eyebrows_3 = GetNumHairColors() - 1
    maxs.eyebrows_4 = GetNumHairColors() - 1
    maxs.makeup_1 = GetPedHeadOverlayNum(4) - 1
    maxs.makeup_2 = 10
    maxs.makeup_3 = GetNumHairColors() - 1
    maxs.makeup_4 = GetNumHairColors() - 1
    maxs.lipstick_1 = GetPedHeadOverlayNum(8) - 1
    maxs.lipstick_2 = 10
    maxs.lipstick_3 = GetNumHairColors() - 1
    maxs.lipstick_4 = GetNumHairColors() - 1
    maxs.blush_1 = GetPedHeadOverlayNum(5) - 1
    maxs.blush_2 = 10
    maxs.blush_3 = GetNumHairColors() - 1
    maxs.complexion_1 = GetPedHeadOverlayNum(6) - 1
    maxs.complexion_2 = 10
    maxs.sun_1 = GetPedHeadOverlayNum(7) - 1
    maxs.sun_2 = 10
    maxs.moles_1 = GetPedHeadOverlayNum(9) - 1
    maxs.moles_2 = 10
    maxs.chest_1 = GetPedHeadOverlayNum(10) - 1
    maxs.chest_2 = 10
    maxs.chest_3 = GetNumHairColors() - 1

    return maxs
end

RegisterNuiCallback('change', function(data)
    local playerPed = PlayerPedId()
    if data.typename == "hair_1" then
       
        SetPedComponentVariation(playerPed, 2, tonumber(data.value), tonumber(playercurrent.hair_2), 2)
        playercurrent.hair_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "hair_2" then
        SetPedComponentVariation(playerPed, 2, tonumber(playercurrent.hair_1), tonumber(data.value), 2)
        playercurrent.hair_2 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "eye_color" then
        SetPedEyeColor(playerPed, tonumber(data.value))
        playercurrent.eye_color = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "blemishes_1" then
      
        SetPedHeadOverlay(playerPed, 0, tonumber(data.value), (tonumber(playercurrent.blemishes_2) / 10) + 0.0)
        playercurrent.blemishes_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "blemishes_2" then
        SetPedHeadOverlay(playerPed, 0, tonumber(playercurrent.blemishes_1), tonumber(data.value) / 10 + 0.0)
        playercurrent.blemishes_2 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "beard_1" then
        SetPedHeadOverlay(playerPed, 1,  tonumber(data.value), tonumber(playercurrent.beard_2) / 10 + 0.0)
        playercurrent.beard_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "beard_2" then
        SetPedHeadOverlay(playerPed, 1,  tonumber(playercurrent.beard_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.beard_2 = tonumber(data.value)
        changetexturelimit()

    elseif data.typename == "eyebrows_1" then
        SetPedHeadOverlay(playerPed, 2,  tonumber(data.value), tonumber(playercurrent.eyebrows_2) / 10 + 0.0)
        playercurrent.eyebrows_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "eyebrows_2" then
        SetPedHeadOverlay(playerPed, 2,  tonumber(playercurrent.eyebrows_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.eyebrows_2 = tonumber(data.value)
        changetexturelimit()


    elseif data.typename == "makeup_1" then
        SetPedHeadOverlay(playerPed, 4,  tonumber(data.value), tonumber(playercurrent.makeup_2) / 10 + 0.0)
        playercurrent.makeup_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "makeup_2" then
        SetPedHeadOverlay(playerPed, 4,  tonumber(playercurrent.makeup_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.makeup_2 = tonumber(data.value)
        changetexturelimit()

    elseif data.typename == "lipstick_1" then
        SetPedHeadOverlay(playerPed, 8,  tonumber(data.value), tonumber(playercurrent.lipstick_2) / 10 + 0.0)
        playercurrent.lipstick_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "lipstick_2" then
        SetPedHeadOverlay(playerPed, 8,  tonumber(playercurrent.lipstick_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.lipstick_2 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "blush_1" then
        SetPedHeadOverlay(playerPed, 5,  tonumber(data.value), tonumber(playercurrent.blush_2) / 10 + 0.0)
        playercurrent.blush_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "blush_2" then
        SetPedHeadOverlay(playerPed, 5,  tonumber(playercurrent.blush_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.blush_2 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "complexion_1" then
        SetPedHeadOverlay(playerPed, 6,  tonumber(data.value), tonumber(playercurrent.complexion_2) / 10 + 0.0)
        playercurrent.complexion_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "complexion_2" then
        SetPedHeadOverlay(playerPed, 6,  tonumber(playercurrent.complexion_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.complexion_2 = tonumber(data.value)
        changetexturelimit()

    elseif data.typename == "sun_1" then
        SetPedHeadOverlay(playerPed, 7,  tonumber(data.value), tonumber(playercurrent.sun_2) / 10 + 0.0)
        playercurrent.sun_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "sun_2" then
        SetPedHeadOverlay(playerPed, 7,  tonumber(playercurrent.sun_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.sun_2 = tonumber(data.value)
        changetexturelimit()

    elseif data.typename == "moles_1" then
        SetPedHeadOverlay(playerPed, 9,  tonumber(data.value), tonumber(playercurrent.moles_2) / 10 + 0.0)
        playercurrent.moles_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "moles_2" then
        SetPedHeadOverlay(playerPed, 9,  tonumber(playercurrent.moles_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.moles_2 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "chest_1" then
        SetPedHeadOverlay(playerPed, 10,  tonumber(data.value), tonumber(playercurrent.chest_2) / 10 + 0.0)
        playercurrent.chest_1 = tonumber(data.value)
        changetexturelimit()
    elseif data.typename == "chest_2" then
        SetPedHeadOverlay(playerPed, 10,  tonumber(playercurrent.chest_1) ,tonumber(data.value) / 10 + 0.0)
        playercurrent.chest_2 = tonumber(data.value)
        changetexturelimit()


        
    end
end)


function changetexturelimit()
    local maxvalue = getmaxvalue()
    
    SendNUIMessage({
        action = "maxrefresh",
        maxvalue = maxvalue
    })
end


function colorpalettevalue()
	hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        action="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        coloritems = coloritems
    
    })
end


RegisterNuiCallback('colorchange', function(data)
    local playerPed = PlayerPedId()

    if data.colortype == "hair_color_1" then
        SetPedHairColor(playerPed, tonumber(data.value), tonumber(playercurrent.hair_color_2))
        playercurrent.hair_color_1 = tonumber(data.value)
    elseif data.colortype == "hair_color_2" then
    
        SetPedHairColor(playerPed,tonumber(playercurrent.hair_color_1) , tonumber(data.value) )
        playercurrent.hair_color_2 = tonumber(data.value)
    elseif data.colortype == "beard_3" then
        SetPedHeadOverlayColor(playerPed, 1, 1, tonumber(data.value), tonumber(playercurrent.beard_4))
        playercurrent.beard_3 = tonumber(data.value)
    elseif data.colortype == "beard_4" then
        SetPedHeadOverlayColor(playerPed, 1, 1, tonumber(playercurrent.beard_3) ,tonumber(data.value))
        playercurrent.beard_4 = tonumber(data.value)

    elseif data.colortype == "eyebrows_3" then
        SetPedHeadOverlayColor(playerPed, 2, 1, tonumber(data.value), tonumber(playercurrent.eyebrows_4))
        playercurrent.eyebrows_3 = tonumber(data.value)
    elseif data.colortype == "eyebrows_4" then
        SetPedHeadOverlayColor(playerPed, 2, 1, tonumber(playercurrent.eyebrows_3) ,tonumber(data.value))
        playercurrent.eyebrows_4 = tonumber(data.value)

    elseif data.colortype == "makeup_3" then
        SetPedHeadOverlayColor(playerPed, 4, 1, tonumber(data.value), tonumber(playercurrent.makeup_4))
        playercurrent.makeup_3 = tonumber(data.value)
    elseif data.colortype == "makeup_4" then
        SetPedHeadOverlayColor(playerPed, 4, 1, tonumber(playercurrent.makeup_3) ,tonumber(data.value))
        playercurrent.makeup_4 = tonumber(data.value)
    elseif data.colortype == "lipstick_3" then
        SetPedHeadOverlayColor(playerPed, 8, 1, tonumber(data.value), tonumber(playercurrent.lipstick_4))
        playercurrent.lipstick_3 = tonumber(data.value)
    elseif data.colortype == "lipstick_4" then
        SetPedHeadOverlayColor(playerPed, 8, 1, tonumber(playercurrent.lipstick_3) ,tonumber(data.value))
        playercurrent.lipstick_4 = tonumber(data.value)

    elseif data.colortype == "blush_3" then
        SetPedHeadOverlayColor(playerPed, 5, 1, tonumber(data.value))
        playercurrent.blush_3 = tonumber(data.value)
    elseif data.colortype == "chest_3" then
        SetPedHeadOverlayColor(playerPed, 10, 1, tonumber(data.value))
        playercurrent.chest_3 = tonumber(data.value)
 
    end
end)


RegisterNUICallback('rotate', function(data)
    if data.key == "left" then
        
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 20.0)
    elseif data.key == "right" then

        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 20.0)

    end
end)


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

function setoldskin(skin)
    local playerPed = PlayerPedId()
   
   
    SetPedComponentVariation(playerPed, 2, tonumber(skin.hair_1), tonumber(skin.hair_2), 2)

    SetPedEyeColor(playerPed, tonumber(skin.eye_color))
    SetPedHeadOverlay(playerPed, 0, tonumber(skin.blemishes_1), (tonumber(skin.blemishes_2) ) + 0.0)
    SetPedHeadOverlay(playerPed, 1,  tonumber(skin.beard_1), tonumber(skin.beard_2) + 0.0)
    SetPedHeadOverlay(playerPed, 2,  tonumber(skin.eyebrows_1), tonumber(skin.eyebrows_2) + 0.0)
    SetPedHeadOverlay(playerPed, 4,  tonumber(skin.makeup_1), tonumber(skin.makeup_2) + 0.0)
    SetPedHeadOverlay(playerPed, 8,  tonumber(skin.lipstick_1), tonumber(skin.lipstick_2)  + 0.0)
    SetPedHeadOverlay(playerPed, 5,  tonumber(skin.blush_1), tonumber(skin.blush_2)  + 0.0)
    SetPedHeadOverlay(playerPed, 6,  tonumber(skin.complexion_1), tonumber(skin.complexion_2) + 0.0)
    SetPedHeadOverlay(playerPed, 7,  tonumber(skin.sun_1), tonumber(skin.sun_2)  + 0.0)
    SetPedHeadOverlay(playerPed, 9,  tonumber(skin.moles_1), tonumber(skin.moles_2)  + 0.0)
    SetPedHeadOverlay(playerPed, 10,  tonumber(skin.chest_1), tonumber(skin.chest_2)  + 0.0)
      



    SetPedHairColor(playerPed, tonumber(skin.hair_color_1), tonumber(skin.hair_color_2))
    SetPedHeadOverlayColor(playerPed, 1, 1, tonumber(skin.beard_3), tonumber(skin.beard_4))
    SetPedHeadOverlayColor(playerPed, 2, 1, tonumber(skin.eyebrows_3), tonumber(skin.eyebrows_4))
    SetPedHeadOverlayColor(playerPed, 4, 1, tonumber(skin.makeup_3), tonumber(skin.makeup_4))
    SetPedHeadOverlayColor(playerPed, 8, 1, tonumber(skin.lipstick_3), tonumber(skin.lipstick_4))
    SetPedHeadOverlayColor(playerPed, 5, 1, tonumber(skin.blush_3))
    SetPedHeadOverlayColor(playerPed, 10, 1, tonumber(skin.chest_3))

 

   
end



function kiyafetfonksiyon()
  
   if kiyafetcikartmis then 
    kiyafetgiycikart("torsos")
	kiyafetgiycikart("jackets")
	kiyafetgiycikart("shoes")
	kiyafetgiycikart("legs")
	kiyafetgiycikart("undershirts")
    kiyafetcikartmis = false
   end
end

RegisterNuiCallback('takeonoff', function()
    if kiyafetcikartmis == false then kiyafetcikartmis = true else kiyafetcikartmis = false end
    kiyafetgiycikart("torsos")
	kiyafetgiycikart("jackets")
	kiyafetgiycikart("shoes")
	kiyafetgiycikart("legs")
	kiyafetgiycikart("undershirts")
end)

function kiyafetgiycikart(clothingType)
	local fuckingData = {
        ['name'] = clothingType,
    }

	ClearPedTasks(PlayerPedId())
    ToggleProps(fuckingData)
end

function DoesTableHaveValue(tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end


function ToggleProps(data)
    local name = data["name"]

    selectedValue = DoesTableHaveValue(drawable_names, name)
    
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
         
            SetPedComponentVariation(PlayerPedId(), tonumber(selectedValue), tonumber(toggleClothing[name][1]), tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
           
            toggleClothing[name] = {
                GetPedDrawableVariation(PlayerPedId(), tonumber(selectedValue)),
                GetPedTextureVariation(PlayerPedId(), tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end
            if name == "shoes" then
                value = 34
            end

            SetPedComponentVariation(PlayerPedId(), tonumber(selectedValue), value, 0, 2)
        end
    else
        selectedValue = DoesTableHaveValue(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    PlayerPedId(),
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(PlayerPedId(), tonumber(selectedValue)),
                    GetPedPropTextureIndex(PlayerPedId(), tonumber(selectedValue))
                }
                ClearPedProp(PlayerPedId(), tonumber(selectedValue))
            end
        end
    end
end


RegisterNuiCallback('exitstore', function( )
    setoldskin(playerold)
    insertattoo(playercurrenttattoo)
    kiyafetfonksiyon()
    closestore()
    yesinmenu = false
 end)


 function closestore()
    changetatto.ZONE_HEAD = nil
changetatto.ZONE_LEFT_LEG = nil
changetatto.ZONE_LEFT_ARM = nil
changetatto.ZONE_RIGHT_LEG = nil
changetatto.ZONE_TORSO = nil
changetatto.ZONE_RIGHT_ARM = nil
    SetNuiFocus(false,false)
    Kameraiptal2()
    SendNUIMessage({
     action = "closestore"
    
 })
 end


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


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
      
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist
            for k,v in pairs(Config.BarberStores) do
				
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



function WaitingKeys1(type, maindata)
    Citizen.CreateThread(function()
        while waitingKey1 == type do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
                local maxvalue = getmaxvalue()
                playerold = getplayerold()
           
                playercurrent = getplayerold()
                SetNuiFocus(true, true)
                colorpalettevalue()
                CreateCamBro()
                local tattoinfo = tattosetup()
                yesinmenu = true
                SendNUIMessage({
                    action = "barberopen",
                    maxvalue = maxvalue,
                    categoryset = maindata.storecategory,
                    storeprice = maindata.storeprice,
                    playerinfos = playercurrent
                })

            end
        end
    end)
end


function tattosetup()
    if Config.type == "ESX" then
        ESX.TriggerServerCallback('ex_bertatstore:gettattoinfos', function(playertattoo, tattolist)
        tattodata = gettattolistinfo(tattolist)
        playercurrenttattoo = playertattoo

        -- inserplayertattoo(playertattoo)
        SendNUIMessage({
            action = "tattoinfo",
            tattodata = tattodata
    
        })
        
        end)
    elseif Config.type == "QBCORE" then
        QBCore.Functions.TriggerCallback('ex_bertatstore:gettattoinfos', function(playertattoo, tattolist)
            tattodata = gettattolistinfo(tattolist)
            SendNUIMessage({
                action = "tattoinfo",
                tattodata = tattodata
        
            })
        
        end)
    end
  
end

function gettattolistinfo(gelenveri)
    local toplam = {}
    local  kafazone = {}
    local solbacakzone = {}
    local solkolzone = {}
    local sagbacakzone = {}
    local govdezone = {}
    local sagkolzone = {}
    for k,v in pairs(gelenveri) do
        if v.Zone == "ZONE_HEAD" then
        table.insert(kafazone, {label= v.Name, price = v.Price, koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
         if v.Zone == "ZONE_LEFT_LEG" then
        table.insert(solbacakzone, {label= v.Name, price = v.Price,koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
          if v.Zone == "ZONE_LEFT_ARM" then
        table.insert(solkolzone, {label= v.Name, price = v.Price,koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
         if v.Zone == "ZONE_RIGHT_LEG" then
        table.insert(sagbacakzone, {label= v.Name, price = v.Price,koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
         if v.Zone == "ZONE_TORSO" then
        table.insert(govdezone, {label= v.Name, price = v.Price,koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
          if v.Zone == "ZONE_RIGHT_ARM" then
        table.insert(sagkolzone, {label= v.Name, price = v.Price,koleksiyon = v.Collection, hasnamemale = v.HashNameMale,hasnamefamele = v.HashNameFemale})
        end
    end
    toplam.ZONE_HEAD = kafazone
    toplam.ZONE_LEFT_LEG = solbacakzone
    toplam.ZONE_LEFT_ARM = solkolzone
    toplam.ZONE_RIGHT_LEG = sagbacakzone
    toplam.ZONE_TORSO = govdezone
    toplam.ZONE_RIGHT_ARM = sagkolzone

    return toplam





end

RegisterNuiCallback('pay', function(data)
    TriggerServerEvent('ex_bertatstore:pay:server', data.price, data.data, changetatto)
  
end)


RegisterNetEvent('ex_bertatstore:notify')
AddEventHandler('ex_bertatstore:notify', function(notifytext, time)
    SendNUIMessage({
        action = "notify",
        notifytext = notifytext,
        time = time
      
    })
end)


RegisterNetEvent('ex_bertatstore:confirmbuy')
AddEventHandler('ex_bertatstore:confirmbuy', function(tattoo)

  if Config.skinstyle == "esx_skin" then

    TriggerEvent('skinchanger:getSkin', function(skin)
       
        TriggerServerEvent('ex_bertatstore:saveownesx', getplayerold(), skin)
      end)

   elseif Config.skinstyle == "qb-clothing" then

 
    TriggerServerEvent('ex_bertatstore:saveownqb', playercurrent)
   elseif Config.skinstyle == "ownsystem" then
    
    
    TriggerServerEvent('ex_bertatstore:saveown', playercurrent)
 
   elseif Config.skinstyle == "custom" then

    Customedit(getplayerold())

   end

   insertattoo(tattoo)
   yesinmenu = false
   kiyafetfonksiyon()
   changetatto.ZONE_HEAD = nil
    changetatto.ZONE_LEFT_LEG = nil
    changetatto.ZONE_LEFT_ARM = nil
    changetatto.ZONE_RIGHT_LEG = nil
    changetatto.ZONE_TORSO = nil
    changetatto.ZONE_RIGHT_ARM = nil
   

   closestore()
end)



function insertattoo(geledovme)
     ClearPedDecorations(PlayerPedId())
     
    if geledovme ~= nil and (json.encode(geledovme) ~= "[]") then
       
	    if (geledovme.ZONE_HEAD ~= "[]") then
	    for i = 1 , #geledovme.ZONE_HEAD, 1 do
	        
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_HEAD[i].koleksiyon), GetHashKey(geledovme.ZONE_HEAD[i].hasname))
	   end
	   end
	   if (geledovme.ZONE_LEFT_LEG ~= "[]") then
	    for i = 1 , #geledovme.ZONE_LEFT_LEG, 1 do
	   
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_LEFT_LEG[i].koleksiyon), GetHashKey(geledovme.ZONE_LEFT_LEG[i].hasname))
	   end
	   end
      if (geledovme.ZONE_LEFT_ARM ~= "[]") then
	    for i = 1 , #geledovme.ZONE_LEFT_ARM, 1 do
	   
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_LEFT_ARM[i].koleksiyon), GetHashKey(geledovme.ZONE_LEFT_ARM[i].hasname))
	   end
	   end
	    if (geledovme.ZONE_RIGHT_LEG ~= "[]") then
	    for i = 1 , #geledovme.ZONE_RIGHT_LEG, 1 do
	   
            AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_RIGHT_LEG[i].koleksiyon), GetHashKey(geledovme.ZONE_RIGHT_LEG[i].hasname))
	   end
	   end
	    if (geledovme.ZONE_TORSO ~= "[]") then
	    for i = 1 , #geledovme.ZONE_TORSO, 1 do
	   
        AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_TORSO[i].koleksiyon), GetHashKey(geledovme.ZONE_TORSO[i].hasname))
	   end
	   end
	    if (geledovme.ZONE_RIGHT_ARM ~= "[]") then
	    for i = 1 , #geledovme.ZONE_RIGHT_ARM, 1 do
	   
        AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_RIGHT_ARM[i].koleksiyon), GetHashKey(geledovme.ZONE_RIGHT_ARM[i].hasname))
	   end
	   end
	end
end




RegisterNuiCallback('changetattoo', function(data)
    ClearPedDecorations(PlayerPedId())
    
    if GetEntityModel(PlayerPedId()) == 1885233650 then
        AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(tattodata[tostring(data.typename)][tonumber(data.value)].koleksiyon), GetHashKey(tattodata[tostring(data.typename)][tonumber(data.value)].hasnamemale))
        changetatto[tostring(data.typename)] = {["koleksiyon"] = tattodata[tostring(data.typename)][tonumber(data.value)].koleksiyon, ["hasname"] = tattodata[tostring(data.typename)][tonumber(data.value)].hasnamemale }
    else
        AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(tattodata[tostring(data.typename)][tonumber(data.value)].koleksiyon), GetHashKey(tattodata[tostring(data.typename)][tonumber(data.value)].hasnamefamele))
        changetatto[tostring(data.typename)] = {["koleksiyon"] = tattodata[tostring(data.typename)][tonumber(data.value)].koleksiyon, ["hasname"] = tattodata[tostring(data.typename)][tonumber(data.value)].hasnamefamele }
    end
    

    insertothers(playercurrenttattoo)
end)





function insertothers(geledovme)
 
    
   if geledovme ~= nil and (json.encode(geledovme) ~= "[]") then
      
       if (geledovme.ZONE_HEAD ~= "[]") then
       for i = 1 , #geledovme.ZONE_HEAD, 1 do
          
           AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_HEAD[i].koleksiyon), GetHashKey(geledovme.ZONE_HEAD[i].hasname))
      end
      end
      if (geledovme.ZONE_LEFT_LEG ~= "[]") then
       for i = 1 , #geledovme.ZONE_LEFT_LEG, 1 do
      
           AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_LEFT_LEG[i].koleksiyon), GetHashKey(geledovme.ZONE_LEFT_LEG[i].hasname))
      end
      end
     if (geledovme.ZONE_LEFT_ARM ~= "[]") then
       for i = 1 , #geledovme.ZONE_LEFT_ARM, 1 do
      
           AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_LEFT_ARM[i].koleksiyon), GetHashKey(geledovme.ZONE_LEFT_ARM[i].hasname))
      end
      end
       if (geledovme.ZONE_RIGHT_LEG ~= "[]") then
       for i = 1 , #geledovme.ZONE_RIGHT_LEG, 1 do
      
           AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_RIGHT_LEG[i].koleksiyon), GetHashKey(geledovme.ZONE_RIGHT_LEG[i].hasname))
      end
      end
       if (geledovme.ZONE_TORSO ~= "[]") then
       for i = 1 , #geledovme.ZONE_TORSO, 1 do
      
       AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_TORSO[i].koleksiyon), GetHashKey(geledovme.ZONE_TORSO[i].hasname))
      end
      end
       if (geledovme.ZONE_RIGHT_ARM ~= "[]") then
       for i = 1 , #geledovme.ZONE_RIGHT_ARM, 1 do
      
       AddPedDecorationFromHashes(PlayerPedId(), GetHashKey(geledovme.ZONE_RIGHT_ARM[i].koleksiyon), GetHashKey(geledovme.ZONE_RIGHT_ARM[i].hasname))
      end
      end
   end
end

RegisterNuiCallback('cleartattoo', function()
    TriggerServerEvent('ex_bertatstore:cleartatto')
    playercurrenttattoo = nil
    ClearPedDecorations(PlayerPedId())
    changetatto.ZONE_HEAD = nil
    changetatto.ZONE_LEFT_LEG = nil
    changetatto.ZONE_LEFT_ARM = nil
    changetatto.ZONE_RIGHT_LEG = nil
    changetatto.ZONE_TORSO = nil
    changetatto.ZONE_RIGHT_ARM = nil
end)


RegisterNetEvent('ex_bertatstore:settattoo')
AddEventHandler('ex_bertatstore:settattoo', function(tattodatass)
  insertattoo(tattodatass)
end)
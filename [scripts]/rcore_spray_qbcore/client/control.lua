Fonts = {}

for idx, f in pairs(FONTS) do
    Fonts[idx] = f.label
end

SprayFont = 1
SprayText = ''
FormattedSprayText = ''

SprayColor = 1

SprayScaleMin = 60
SprayScaleMax = 200
CurrentSprayScale = 40
SprayScale = 1
SprayScaleSelect = {}

for i = SprayScaleMin, SprayScaleMax, 5 do
    table.insert(SprayScaleSelect, i)
end

IsSpraying = false

local lastFormattedText = nil
function ResetFormattedText()
    local tmp = SprayText

    if tmp ~= lastFormattedText then
        lastFormattedText = tmp

        if FONTS[SprayFont].forceUppercase then
            tmp = tmp:upper()
        end

        FormattedSprayText = RemoveDisallowedCharacters(tmp, FONTS[SprayFont].allowedInverse)
    end
end

RegisterNetEvent('rcore_spray:spray')
AddEventHandler('rcore_spray:spray', function(text)
    if not IsSpraying then
        if text then
            SprayText = text
            IsSpraying = true
            ResetFormattedText()
            WarMenu.OpenMenu('spray')
        else
            TriggerEvent('chat:addMessage', {
                templateId = 'warning',
                args = {Config.Text.USAGE}
            })
        end
    end
end, false)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('spray', Config.Text.MENU.TITLE)
    WarMenu.SetSubTitle('spray', Config.Text.MENU.SUBTITLE)
    WarMenu.SetMenuX('spray', 0.75)
    WarMenu.SetMenuY('spray', 0.35)
    while true do
        Wait(0)

        if IsSpraying then
            if WarMenu.IsMenuOpened('spray') then
                if WarMenu.ComboBox(Config.Text.MENU.FONTS, Fonts, SprayFont, SprayFont, function(currentIndex, selectedIndex)
                    SprayFont = currentIndex
                    ResetFormattedText()
				end) then
                elseif WarMenu.ColorSelector(Config.Text.MENU.COLOR, SIMPLE_COLORS, SprayColor, function(i) 
                    SprayColor = i 
                end) then
                elseif WarMenu.ComboBox(Config.Text.MENU.SIZE, SprayScaleSelect, SprayScale, SprayScale, function(currentIndex, selectedIndex)
					SprayScale = currentIndex
                end) then
                elseif WarMenu.Button(Config.Text.MENU.SPRAY) then
                    WarMenu.CloseMenu()
                    PersistSpray()
                    IsSpraying = false
                    SprayText = ''
                end

                WarMenu.Display()
            else
                IsSpraying = false
                SprayText = ''
            end
        end
    end
end)

function PersistSpray()
    IsSpraying = false
        
    local rayEndCoords, rayNormal, sprayFwdVector = FindRaycastedSprayCoords()
    if rayEndCoords and rayNormal then
        local sprayLocation = rayEndCoords + sprayFwdVector * SPRAY_FORWARD_OFFSET
        

        local ped = PlayerPedId()

        local canPos = vector3(0.072, 0.041, -0.06)
        local canRot = vector3(33.0, 38.0, 0.0)
    
        local canObj = CreateObject(
            `ng_proc_spraycan01b`,
            0.0, 0.0, 0.0,
            true, false, false
        )
        AttachEntityToEntity(
            canObj, ped, 
            GetPedBoneIndex(ped, 57005), 
            canPos.x, canPos.y, canPos.z, 
            canRot.x, canRot.y, canRot.z, 
            true, true, false, true, 1, true
        )

        local isCancelled = false

        Citizen.CreateThread(function()
            Wait(2000)
            while not isCancelled do
                SprayEffects()
                Wait(5000)
            end
        end)

        CancellableProgress(
            Config.SPRAY_PROGRESSBAR_DURATION, 
            'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 
            'weed_spraybottle_stand_spraying_01_inspector', 
            16,
            function() -- success
                TriggerServerEvent('rcore_spray:addSpray', {
                    location = sprayLocation,
                    realRotation = currentComputedRotation, 
                    
                    scale = (SprayScaleSelect[SprayScale] / 10.0) * FONTS[SprayFont].sizeMult,
                    text = FormattedSprayText,
                    font = FONTS[SprayFont].font,
                    originalColor = SprayColor,
                    interior = GetInteriorFromEntity(PlayerPedId()) > 0
                })
                ClearPedTasks(ped)
                DeleteObject(canObj)
                isCancelled = true
            end,
            function()
                ClearPedTasks(ped)
                DeleteObject(canObj)
                isCancelled = true
            end
        )
    end
end

--[[
cut_rcepsilon
  cs_rcepsilon_cola_can
  liquid_splash_paint
  liquid_spray_paint

  /anim  weed_spraybottle_stand_spraying_01_inspector

]]


function SprayEffects()
    local dict = "scr_recartheft"
    local name = "scr_wheel_burnout"
    
    local ped = PlayerPedId()
    local fwd = GetEntityForwardVector(ped)
    local coords = GetEntityCoords(ped) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

	RequestNamedPtfxAsset(dict)
    -- Wait for the particle dictionary to load.
    while not HasNamedPtfxAssetLoaded(dict) do
        Citizen.Wait(0)
	end

	local pointers = {}
    
    local color = COLORS[SprayColor]['color'].rgb

    local heading = GetEntityHeading(ped)

    UseParticleFxAssetNextCall(dict)
    SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
    SetParticleFxNonLoopedAlpha(1.0)
    local ptr = StartNetworkedParticleFxNonLoopedAtCoord(
        name, 
        coords.x, coords.y, coords.z + 2.0, 
        0.0, 0.0, heading, 
        0.7, 
        0.0, 0.0, 0.0
    )
    RemoveNamedPtfxAsset(dict)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 100 )
    end
end

function RemoveDisallowedCharacters(str, inverse)
    local replaced, _ = str:gsub(inverse, '')

    return replaced
end

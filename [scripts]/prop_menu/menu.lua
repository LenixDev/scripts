-----------------------------------------------------------
----                    Prop menu                      ----
----             Made by Tamir112#5345                 ----
----        For more scripts and updates Join:         ----
----              discord.gg/bDPaRDeBKJ                ----
----                                                   ----
-----------------------------------------------------------

local List = {}
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "~b~Prop Menu", 1380, 0)
mainMenu:SetMenuWidthOffset(45)

_menuPool:Add(mainMenu)
mainMenu:SetMenuWidthOffset(45)
List = {}
for i, Prop in pairs(Config.Props) do
    name = Prop.name
    local propp = NativeUI.CreateItem(name, 'Place down a ~o~'..name)
mainMenu:AddItem(propp)
table.insert(List, Prop.spawncode)
end
local RemoveProps = NativeUI.CreateItem('~r~Remove Props', 'Remove the closest prop to your ped')
mainMenu:AddItem(RemoveProps)

mainMenu.OnItemSelect = function(sender, item, index)
if item == RemoveProps then
    for _, Prop in pairs(Config.Props) do
        DeleteProp(Prop.spawncode)
    end

else
      SpawnProp(List[index])

end
end


_menuPool:RefreshIndex() 

  
   Citizen.CreateThread(function()
      while true do
          Citizen.Wait(0)
          _menuPool:MouseControlsEnabled (false)
          _menuPool:MouseEdgeEnabled (false)
          _menuPool:ControlDisablingEnabled(false)
          _menuPool:ProcessMenus()
         if IsControlJustPressed(1, Config.keybind) then
              mainMenu:Visible(not mainMenu:Visible())
    end
    end
  end) 

---------------------------------------------------




--Prop Functions
function DeleteProp(Object)
    local Hash = GetHashKey(Object)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, Hash, true) then
        local Prop = GetClosestObjectOfType(x, y, z, 1.5, Hash, false, false, false)
        DeleteObject(Prop)
        Notify('~r~Prop Removed!')
    end
end
function SpawnProp(Object)
    local Player = PlayerPedId()
    local Coords = GetEntityCoords(Player)
    local Heading = GetEntityHeading(Player)

    RequestModel(Object)
    while not HasModelLoaded(Object) do
        Citizen.Wait(0)
    end

    local OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0)
    local Prop = CreateObjectNoOffset(Object, OffsetCoords, false, true, false)
    SetEntityHeading(Prop, Heading)
    PlaceObjectOnGroundProperly(Prop)
    SetEntityCollision(Prop, false, true)
    SetEntityAlpha(Prop, 100)
    FreezeEntityPosition(Prop, true)
    SetModelAsNoLongerNeeded(Object)

    Notify('Press ~g~E ~w~to place\nPress ~r~R ~w~to cancel')

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            local OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0)
            local Heading = GetEntityHeading(Player)

			SetEntityCoordsNoOffset(Prop, OffsetCoords)
			SetEntityHeading(Prop, Heading)
            PlaceObjectOnGroundProperly(Prop)
			DisableControlAction(1, 38, true) 
			DisableControlAction(1, 140, true) 
            
            
            if IsDisabledControlJustPressed(1, 38) then 
                local PropCoords = GetEntityCoords(Prop)
                local PropHeading = GetEntityHeading(Prop)
                DeleteObject(Prop)

                RequestModel(Object)
                while not HasModelLoaded(Object) do
                    Citizen.Wait(0)
                end

                local Prop = CreateObjectNoOffset(Object, PropCoords, true, true, true)
                SetEntityHeading(Prop, PropHeading)
                PlaceObjectOnGroundProperly(Prop)
                FreezeEntityPosition(Prop, true)
				SetEntityInvincible(Prop, true)
                SetModelAsNoLongerNeeded(Object)
                return
            end

            if IsDisabledControlJustPressed(1, 140) then 
                DeleteObject(Prop)
                return
            end
        end
    end)
end

function Notify(Text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(Text)
    DrawNotification(true, true)
end
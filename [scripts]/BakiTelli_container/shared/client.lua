local containerobj = nil
local cancelOperation = false

RegisterNUICallback("SkipVideo", function ()
  cancelOperation = true
end)

function OpenCaseAnimation()
  if Config.Animation.Video then 
  containerlocation = GetEntityCoords(PlayerPedId())
  SendNUIMessage({
    action = "skip"
  })
  SetNuiFocus(1,1)
    DoScreenFadeOut(800)
    Citizen.Wait(800)
    if cancelOperation then
        DoScreenFadeIn(800)
        Citizen.Wait(800)
        cancelOperation = false
        return
    end
    TriggerServerEvent("BakiTelli:container:SetPlayerRoutingBucket", false)
    SetEntityCoords(PlayerPedId(), Config.Animation.AnimationCoord.x, Config.Animation.AnimationCoord.y, Config.Animation.AnimationCoord.z)
    SetEntityHeading(PlayerPedId(), Config.Animation.AnimationCoord.w)
    FreezeEntityPosition(PlayerPedId(), true)
    containerobj = createObject(Config.Animation.ContainerObj, Config.Animation.ContainerCoords)
    Citizen.Wait(2500)
    if cancelOperation then
        DeleteEntity(containerobj)
        containerobj = nil
        DoScreenFadeIn(800)
        Citizen.Wait(800)
        FreezeEntityPosition(PlayerPedId(), false)
        SetNuiFocus(1,1)
        TriggerServerEvent("BakiTelli:container:SetPlayerRoutingBucket", true)
        SetEntityCoords(PlayerPedId(), containerlocation.x, containerlocation.y, containerlocation.z)
        cancelOperation = false
        return
    end
    DoScreenFadeIn(800)
    FreezeEntityPosition(PlayerPedId(), false)
    TaskGoToCoordAnyMeans(PlayerPedId(), vector3(Config.Animation.CharacterGoLocation.x, Config.Animation.CharacterGoLocation.y, Config.Animation.CharacterGoLocation.z), 1.0, 0, 0, 786603, 0xbf800000)
    Citizen.Wait(4000)
    SetEntityHeading(PlayerPedId(), Config.Animation.CharacterGoLocation.w)
    Citizen.Wait(750)
    loadAnimDict("veh@boat@predator@ds@base")
    TaskPlayAnim(PlayerPedId(), 'veh@boat@predator@ds@base', 'pov_hotwire', 3.0, 3.0, -1, 1, 0, false, false, false)
    Citizen.Wait(5000)
    StopAnimTask(PlayerPedId(), 'veh@boat@predator@ds@base', 'pov_hotwire', 1.0)
    DoScreenFadeOut(1600)
    Citizen.Wait(1600)
    if cancelOperation then
        DeleteEntity(containerobj)
        containerobj = nil
        SetEntityCoords(PlayerPedId(), containerlocation.x, containerlocation.y, containerlocation.z)
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerServerEvent("BakiTelli:container:SetPlayerRoutingBucket", true)
        Citizen.Wait(4200)
        DoScreenFadeIn(1600)
        Citizen.Wait(1600)
        FreezeEntityPosition(PlayerPedId(), false)
        SetNuiFocus(1,1)
        cancelOperation = false
        return
    end
    DeleteEntity(containerobj)
    containerobj = nil
    SetEntityCoords(PlayerPedId(), containerlocation.x, containerlocation.y, containerlocation.z)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerServerEvent("BakiTelli:container:SetPlayerRoutingBucket", true)
    Citizen.Wait(4200)
    DoScreenFadeIn(1600)
    Citizen.Wait(1600)
    FreezeEntityPosition(PlayerPedId(), false)
    SetNuiFocus(1,1)
    cancelOperation = false
  end
end

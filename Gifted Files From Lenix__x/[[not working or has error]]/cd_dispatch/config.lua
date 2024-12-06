Config = {}

Config.core = 'qb-core' --اسم الكور حقك
Config.Language = 'EN' --EN / FR / EN.
Config.UseQBCore = true --If you are using ESX.
Config.QBCoreTrigger = 'QBCore:GetObject' --You can change this trigger for ESX.
Config.ServerNotification_Type = 'chat' --chat / mythic_old / mythic_new / esx / custom
Config.ClientNotification_Type = 'chat' --chat / mythic_old / mythic_new / esx / custom.
Config.UsingOnesync = true --Choose if you are using onesync/infinity.
Config.UsingMultichar = false --If you are using a multi character script, make sure to trigger this event from your multi char script after you have spawned in: TriggerEvent('cd_garage_GrabInfo')
Config.PhoneModel = 'prop_npc_phone_02'

Config.CommandName = 'pdcallsign' --Customise the command where you will set your call sign.
Config.ToggleUI = 303 --Key to open/close the small UI. (U default).
Config.MoveMode = 311 --Key to enable/disable move mode for the small UI. (K default).
Config.OpenLarge = 1312 --Key to open tyhe large UI. (L default).
Config.Respond = 47 --Key to respond/unrespond on the small UI. (G default).
Config.MoveRight = 175 --Key to scroll right through the notifications on the small UI. (RIGHT ARROW default)
Config.MoveLeft = 174 --Key to scroll left through the notifications on the small UI. (LEFT ARROW default)
Config.UseRadio = false --Choose wether you want to display which officers are in which radio channels.
Config.DayHours = {[1] = 6, [2] = 22} --If the game time is between 6am to 10pm then dark mode will be enabled, else lightmode will be enabled (using 24 hour clock).

Config.AllowedJobs = { --A list of jobs who are allowed to use this dispatch.
  	['police'] = true,
    ['ambulance'] = true,
    ['mechanic'] = true,
    ['weazel'] = true,
}

Config.DefaultCallsignColour = 'blue' --The default blip colour, even if the blip is nil.
Config.CallsignData = { --The only colours available by default are blue/orange/yellow/red.More can be added in the java side.
	[1] = {blipname = 'LSPD', blipcolour = 'blue'},
	[2] = {blipname = 'BCSO', blipcolour = 'orange'},
	[3] = {blipname = 'SAST', blipcolour = 'yellow'},
	[4] = {blipname = 'MED', blipcolour = 'red'},
}








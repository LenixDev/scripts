Shared = {}
Shared.Entries = {}

Shared.ShowingInteractDistance = 8

Shared.Entries[#Shared.Entries + 1] = {
    id = "toggleduty",
    coords = { x = -1163.61, y = -892.21, z =  14.11 },
    distance = 1.5,
    key = "key",
    text = "npc_talk",
    type = "client",
    event = "qb-policejob:ToggleDuty",
    parameters = { },
}
--Shared.Entries[#Shared.Entries + 1] = {
--    id = "enter_apartments",
--    coords = { x = -1448.8, y = -538.36, z = 34.76 }, -- -1448.8, -538.36, 34.76
--    distance = 2.5,
--    key = "key",
--    text = "npc_talk",
--    type = "client",
--    event = "np-apartments:talk",
--    parameters = { },
--}
--
--Shared.Entries[#Shared.Entries + 1] = {
--    id = "apartments_stash",
--    coords = { x = -821.740, y = 3471.299, z = -160.0 },
--    distance = 1.5,
--    key = "key",
--    type = "client",
--    event = "np-apartments:stash",
--    parameters = { },
--}
--
--Shared.Entries[#Shared.Entries + 1] = {
--    id = "apartments_outfits",
--    coords = { x = -817.35, y = 3471.200, z = -159.6 },
--    distance = 1.5,
--    key = "key",
--    type = "server",
--    event = "np-clothing:listCharacterOutfits",
--    parameters = { },
--}
--
--Shared.Entries[#Shared.Entries + 1] = {
--    id = "chopshop_npc",
--    coords = { x = -494.2057, y = -720.7625, z = 23.82066 },
--    distance = 1.5,
--    key = "key",
--    text = "npc_talk",
--    type = "client",
--    event = "np-chopshop/talkToRoman",
--    parameters = { },
--}
--
--Shared.Entries[#Shared.Entries + 1] = {
--    id = "impound_records",
--    coords = { x = -192.2665, y = -1162.312, z = 23.46819 },
--    distance = 1.5,
--    key = "key",
--    text = "impound_records",
--    type = "client",
--    event = "np-vehicles:viewImpoundRecords",
--    parameters = { },
--}
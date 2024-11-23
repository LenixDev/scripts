# Thank you for purchasing karma-clothing we hope you enjoy it took alot of time and if you have any questions feel free to reach out to me anytime <3

# Important Notice !!!

You **MUST** ensure to modify any instance calling the "qb-clothing:client:loadPlayerClothing" function. Make sure to provide a **CID** (Client ID) and **character model** to load. Use this to load the given CID clothing !

Example : 

    local PlayerData = QBCore.Functions.GetPlayerData()
    local cid = PlayerData.cid
    local charPed = PlayerPedId()

    TriggerEvent('qb-clothing:client:loadPlayerClothing', cid, charPed)


# Please add this to your server/resource.cfg
ensure karma-polyzone
ensure karma-focusmanager
ensure karma-clothing
ensure karma-outfits

# The script was leaked by https://discord.gg/zarevstore
# Join for more NP 4.0 scripts
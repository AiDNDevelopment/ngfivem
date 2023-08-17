local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("spawnCokePlants")
AddEventHandler("spawnCokePlants", function()
    print("Server spawn coke plants triggered")
    local _source = source
    TriggerClientEvent("spawnCokePlants", _source)
end)

QBCore.Functions.CreateCallback('rewardPlayer', function(source, cb) 
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return cb(false) end
    local ammount = math.random(1, 5)
    if player.Functions.AddItem("coca_leaf", ammount) then 
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["coca_leaf"], "add", ammount)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("processCocaLeaves")
AddEventHandler("processCocaLeaves", function()
    local source = source -- The player's server ID
    local player = QBCore.Functions.GetPlayer(source)
    
    if player then
        local itemInfo = player.Functions.GetItemByName("coca_leaf")
        local requiredAmount = 100
        
        if itemInfo and itemInfo.amount and itemInfo.amount >= requiredAmount then
            -- Remove the required amount of coca leaves
            player.Functions.RemoveItem("coca_leaf", requiredAmount)
            
            -- Start the first processing step
            TriggerClientEvent("startProcessingStep", source)
        else
            TriggerClientEvent("QBCore:Notify", source, "You need at least " .. requiredAmount .. " coca leaves to process coke.", "error")
        end
    end
end)

QBCore.Functions.CreateCallback('rewardProcessing', function(source, cb) 
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return cb(false) end
    if player.Functions.AddItem("coke_brick", 1) then 
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["coke_brick"], "add", 1)
        cb(true)
    else
        cb(false)
    end
end)
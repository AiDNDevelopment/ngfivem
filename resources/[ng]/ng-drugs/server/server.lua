local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName then 
        TriggerEvent("spawnCokePlants")
    end
end)

RegisterServerEvent("spawnCokePlants")
AddEventHandler("spawnCokePlants", function()
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

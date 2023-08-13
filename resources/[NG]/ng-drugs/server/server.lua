local QBCore = exports['qb-core']:GetCoreObject()
local interactedPlants = {} 

RegisterNetEvent("ng-drugs:server:interactWeedPlant", function(plantIndex)
    local source = source
    
    -- Check if the plant has already been interacted with
    if not interactedPlants[plantIndex] then
        interactedPlants[plantIndex] = true -- Mark the plant as interacted
        
        print("Interacted with plant " .. plantIndex)
        TriggerClientEvent("QBCore:Notify", source, 'You have interacted', 'success')
        
        -- Call your function to delete the plant on the client side
        TriggerClientEvent("DeletePlant", source, plantIndex)
    else
        print("Plant " .. plantIndex .. " has already been interacted with.")
    end
end)
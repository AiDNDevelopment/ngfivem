--Coke Processing Variables
local cokeProcessingZones = {
    vector3(1090.33, -3196.66, -38.99),
    vector3(1092.87, -3196.67, -38.99),
    vector3(1095.79, -3196.62, -38.99),
    vector3(1087.24, -3197.46, -38.99),
}
local isProcessing = false
local currentStep = 0
local weighZones = {
    vector3(1090.5, -3194.83, -38.99),
    vector3(1092.98, -3194.83, -38.99),
    vector3(1095.35, -3194.82, -38.99),
    vector3(1100.83, -3198.73, -38.99),
}
local isWeighing = false
local interactionRadius = 1.0

--#region Coke Processing
local function interactWithProcessing()
    -- Trigger a server event to process coca leaves
    TriggerServerEvent("processCocaLeaves")
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, processingCoords in ipairs(cokeProcessingZones) do
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, processingCoords.x, processingCoords.y, processingCoords.z)

            if distance <= interactionRadius then
                DrawText3D(processingCoords.x, processingCoords.y, processingCoords.z + 1.0, "[E] Process Coke")

                if IsControlJustReleased(0, 38) then -- "E" key
                    interactWithProcessing()
                end
            end
        end
    end
end)

RegisterNetEvent("startProcessingStep")
AddEventHandler("startProcessingStep", function(requiredAmount)
    if not isProcessing then
        isProcessing = true
        currentStep = 1
        
        local playerPed = PlayerPedId()
        
        -- Start animation for the first processing step
        
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", -1, true) -- Chemical mixing animation
        
        -- Display progress bar for the first step
        QBCore.Functions.Progressbar("processing_step", "Mixing Chemicals", 10000, false, true, {}, {}, {}, {}, function()
            -- First step completed, end the animation and start second step
            ClearPedTasks(playerPed) -- Clear the animation task
            currentStep = 2
            TriggerEvent("continueProcessing")
        end)
    end
end)

RegisterNetEvent("continueProcessing")
AddEventHandler("continueProcessing", function(requiredAmount)
    if currentStep == 2 then
        local playerPed = PlayerPedId()
        ClearPedTasks(playerPed)
        
        -- Start animation for the second processing step
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", -1, true) -- Pouring animation
        
        -- Display progress bar for the second step
        QBCore.Functions.Progressbar("processing_step", "Pouring Mixture", 10000, false, true, {}, {}, {}, {}, function()
            -- Both steps completed
            isProcessing = false
            currentStep = 0
            ClearPedTasks(playerPed)
            QBCore.Functions.TriggerCallback("rewardProcessing", function(success)
                if success then 
                    TriggerEvent('inventory:client:itemBox', QBCore.Shared.Items["coke_brick"], "add")
                else
                    QBCore.Functions.Notify("Could not add item to inventory.", "error")
                end
            end)
        end)
    end
end)

local function interactWeighZone()
    print("Weighing coke")
    TriggerServerEvent("weighCoke")
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, weighCoords in ipairs(weighZones) do 
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, weighCoords.x, weighCoords.y, weighCoords.z)

            if distance <= interactionRadius then 
                DrawText3D(weighCoords.x, weighCoords.y, weighCoords.z + 1.0, "[E] Weigh Coke")

                if IsControlJustReleased(0, 38) then 
                    interactWeighZone()
                end
            end
        end
    end
end)

RegisterNetEvent("startWeighing")
AddEventHandler("startWeighing", function() 
    if not isWeighing then 
        isWeighing = true

        local playerPed = PlayerPedId()

        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", -1, true)

        QBCore.Functions.Progressbar("weighing", "Weighing up droogs", 20000, false, true, {},{},{},{},function()
            ClearPedTasks(playerPed)
            QBCore.Functions.TriggerCallback("weighReward", function(success)
                if success then 
                    TriggerEvent('inventory:client:itemBox', QBCore.Shared.Items["cokebaggy"], "add")
                    ClearPedTasks(playerPed)
                    isWeighing = false
                else
                    QBCore.Functions.Notify("Could not add item to inventory.", "error")
                    ClearPedTasks(playerPed)
                    isWeighing = false
                end
            end)
        end)
    end
end)
--#endregion Coke Processing

--#region
-- Player has Ingredients in correct ammounts
-- Plauer has correct vehicle
-- Player does minigame?
-- Player has meth?
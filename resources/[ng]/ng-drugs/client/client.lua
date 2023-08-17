local QBCore = exports['qb-core']:GetCoreObject()

local spawnedPlants = {}
local maxPlants = 200
local interactionRadius = 2.0

local spawnCenter = vector2(-1369.19, 4421.76) -- Change to your desired x, y coordinates
local spawnRadius = 45

local hasSpawnedPlants = false -- Variable to track if plants have been spawned

local cokeProcessingZones = {
    vector3(1389.72, 3603.41, 38.94),
    vector3(1388.96, 3605.72, 38.94),
    vector3(1390.08, 3608.93, 38.94),
    vector3(1394.67, 3601.89, 38.94),
    vector3(1391.89, 3605.87, 38.94),
}


local isProcessing = false
local currentStep = 0

local weighZones = {
    vector3(1396.98, 3605.31, 38.94),
    vector3(1394.28, 3610.33, 38.94)
}

local isWeighing = false

--#region Coke picking
RegisterNetEvent("QBCore:client:onPlayerLoaded", function()
    print("Client has been loaded")
    checkCoords()
end)

local function findGroundZ(coord)
    local _, groundZ, _ = GetGroundZFor_3dCoord(coord.x, coord.y, 1000.0, 0.0)
    return groundZ
end

function checkCoords()
    Citizen.CreateThread(function()
        while true do 
            local coords = GetEntityCoords(PlayerPedId())
            if not hasSpawnedPlants and GetDistanceBetweenCoords(coords, spawnCenter, true) < 1000 then 
                TriggerServerEvent("spawnCokePlants")
                hasSpawnedPlants = true
            end
            Citizen.Wait(1 * 60000)
        end
    end)
end

AddEventHandler('onClientMapStart', function()
    print("Client map has started")
    Citizen.Wait(10000) -- Wait for 1 minute (adjust as needed)
    checkCoords()
end)

local function spawnPlant()
    local plantModel = "h4_prop_bush_cocaplant_01"
    local spawnOffsetX = math.random(-spawnRadius, spawnRadius)
    local spawnOffsetY = math.random(-spawnRadius, spawnRadius)
    
    local groundZ = findGroundZ(vector2(spawnCenter.x + spawnOffsetX, spawnCenter.y + spawnOffsetY))
    if groundZ then
        local plantCoords = vector3(
            spawnCenter.x + spawnOffsetX,
            spawnCenter.y + spawnOffsetY,
            groundZ
        )
        
        local plantObject = CreateObject(GetHashKey(plantModel), plantCoords.x, plantCoords.y, plantCoords.z, true, true, true)
        if DoesEntityExist(plantObject) then
            print("Spawned a plant object:", plantObject)
            return plantObject
        else
            print("Failed to spawn plant.")
            return nil
        end
    else
        print("Failed to find ground level.")
        return nil
    end
end

local function deletePlant(plantObject)
    if DoesEntityExist(plantObject) then
        DeleteObject(plantObject)
        print("Deleted plant object:", plantObject)
    end
end


local function interactWithPlant(plantObject)
    local playerPed = PlayerPedId()

    -- Play animation for 60 seconds
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", -1, true)

    -- Display QB Progressbar for 60 seconds
    QBCore.Functions.Progressbar("interacting_with_plant", "Harvesting Plant", 45000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Completion callback
        ClearPedTasks(playerPed) -- Clear the animation task

        -- Delete the current plant
        deletePlant(plantObject)

        QBCore.Functions.TriggerCallback("rewardPlayer", function(success)
            if success then 
                TriggerEvent('inventory:client:itemBox', QBCore.Shared.Items["coca_leaf"], "add")
            else
                QBCore.Functions.Notify("Could not add item to inventory.", "error")
            end
        end)
        
        Citizen.CreateThread(function()
            Citizen.Wait(10000) -- Wait for 10 seconds

            -- Spawn a new plant
            local newPlantObject = spawnPlant(spawnRadius)
            if newPlantObject then
                table.insert(spawnedPlants, newPlantObject)
            end
        end)
    end)
end

RegisterNetEvent("spawnCokePlants")
AddEventHandler("spawnCokePlants", function()
    print("Spawn coke plants client event triggered.")
    for i = 1, maxPlants do
        local plantObject = spawnPlant()
        if plantObject then
            table.insert(spawnedPlants, plantObject)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, plantObject in ipairs(spawnedPlants) do
            local plantCoords = GetEntityCoords(plantObject)
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, plantCoords.x, plantCoords.y, plantCoords.z)

            if distance <= interactionRadius then
                -- Display UI prompt for interaction
                DrawText3D(plantCoords.x, plantCoords.y, plantCoords.z + 1.0, "[E] Harvest")

                -- Check if the player pressed the "E" key
                if IsControlJustReleased(0, 38) then -- "E" key
                    interactWithPlant(plantObject)
                end
            end
        end
    end
end)

-- Helper function to display 3D text
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, plantObject in ipairs(spawnedPlants) do
        deletePlant(plantObject)
    end

    print("Resource stopped: " .. resourceName)
end)
--#endregion Coke picking

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
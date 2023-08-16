local QBCore = exports['qb-core']:GetCoreObject()

local spawnedPlants = {}
local maxPlants = 5
local spawnInterval = 1800 -- Respawn interval in seconds (30 minutes)
local interactionRadius = 2.0

local spawnCenter = vector2(-1369.19, 4421.76) -- Change to your desired x, y coordinates

local function findGroundZ(coord)
    local _, groundZ, _ = GetGroundZFor_3dCoord(coord.x, coord.y, 1000.0, 0.0)
    return groundZ
end

local function spawnPlant()
    local plantModel = "prop_weed_01"
    local spawnOffsetX = math.random(-5, 5)
    local spawnOffsetY = math.random(-5, 5)
    
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
    -- Perform the interaction logic here
    print("Interacted with plant:", plantObject)
    
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
        local newPlantObject = spawnPlant()
        if newPlantObject then
            table.insert(spawnedPlants, newPlantObject)
        end
    end)
end

RegisterNetEvent("spawnCokePlants")
AddEventHandler("spawnCokePlants", function()
    print("Spawn coke plants event triggered.")
    for i = 1, maxPlants do
        local plantObject = spawnPlant()
        if plantObject then
            table.insert(spawnedPlants, plantObject)
        end
    end
end)

AddEventHandler("onClientMapStart", function()
    TriggerEvent("spawnCokePlants")
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
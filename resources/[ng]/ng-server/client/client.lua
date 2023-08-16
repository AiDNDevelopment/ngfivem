local QBCore = exports['qb-core']:GetCoreObject()

local spawnedVehicle = nil
local showMarker = false

--MATERIAL PICKUP 1(Our Time:)
RegisterNetEvent('matrun:client:matrun1', function()
    if DoesEntityExist(spawnedVehicle) then
        TriggerEvent('qb-core:client:DrawText', 'You already took a vehicle, If you left it then its toast', 'right')
        Wait(5000)
        TriggerEvent('qb-core:client:HideText')
    else
        MatPickup1()
    end
end)

--MATERIAL DROPOFF 1
RegisterNetEvent('matrun:client:dropoff1', function()
    MatDrop1()
end)

--MATERIAL PICKUP 2(OUR TIME:)
RegisterNetEvent('matrun:client:matrun2', function()
    if DoesEntityExist(spawnedVehicle) then
        TriggerEvent('qb-core:client:DrawText', 'You already took a vehicle, If you left it then its toast', 'right')
        Wait(5000)
        TriggerEvent('qb-core:client:HideText')
    else
        MatPickup2()
    end
end)

--MATERIAL DROPOFF 2
RegisterNetEvent('matrun:client:dropoff2', function()
    MatDrop2()
end)

--MATERIAL PICKUP 3(OUR TIME:)
RegisterNetEvent('matrun:client:matrun3', function()
    if DoesEntityExist(spawnedVehicle) then
        TriggerEvent('qb-core:client:DrawText', 'You already took a vehicle, If you left it then its toast', 'right')
        Wait(5000)
        TriggerEvent('qb-core:client:HideText')
    else
        MatPickup3()
    end
end)

--MATERIAL DROPOFF 3
RegisterNetEvent('matrun:client:dropoff3', function()
    MatDrop3()
end)

--MATERIAL PICKUP 1
function MatPickup1()
    if DoesEntityExist(spawnedVehicle) then
        print("A vehicle is already spawned")
        return
    end

    local vehicleModel = GetHashKey("burrito3")

    print("Spawning burrito")

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end

    spawnedVehicle = CreateVehicle(vehicleModel, 702.95, -1142.03, 23.67,89.47, true, false)
    SetEntityAsMissionEntity(spawnedVehicle, true, true)

    GetVehicleDoorLockStatus(spawnedVehicle)
    SetVehicleDoorsLocked(spawnedVehicle, 1)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

    local playerID = GetPlayerServerId(PlayerId())
    TriggerServerEvent('matDrop1Instructions', playerID)

    local x,y,z = 843.62, -2180.04, 30.3

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if showMarker then
                DrawMarker(1, x, y, z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 255, false, false, false)
            end
        end
    end)
    showMarker = true
    return spawnedVehicle
end

--MATERIAL DROP 1
function MatDrop1()
    if DoesEntityExist(spawnedVehicle) then
        if IsMatDrop1VehInPlace(spawnedVehicle, 843.62, -2180.04, 30.3, 5.0) then
            local playerID = GetPlayerServerId(PlayerId())
            HideMarker()
            TriggerEvent('qb-core:client:DrawText', 'Thanks, Heres your cut.', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerReward', playerID)
            DeleteVehicle(spawnedVehicle)
        else 
            local playerID = GetPlayerServerId(PlayerId())
            TriggerEvent('qb-core:client:DrawText', 'You didnt bring the truck?', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerLeftTruck', playerID)
            Wait(2000)
            arrivedNoVeh()
            HideMarker()
        end
    else
        local playerID = GetPlayerServerId(PlayerId())
        TriggerEvent('qb-core:client:DrawText', "Go see my buddy, I'll send you a location", 'right')
        Wait(3000)
        TriggerEvent('qb-core:client:HideText')
        TriggerServerEvent('stillNeedToStart', playerID)
    end
end

--MATERIAL PICKUP 2
function MatPickup2()
    if DoesEntityExist(spawnedVehicle) then
        print("A vehicle is already spawned")
        return
    end

    local vehicleModel = GetHashKey("burrito3")

    print("Spawning burrito")

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end
    
    spawnedVehicle = CreateVehicle(vehicleModel, -852.13, -2933.1, 13.97, 155.49, true, false)
    SetEntityAsMissionEntity(spawnedVehicle, true, true)

    GetVehicleDoorLockStatus(spawnedVehicle)
    SetVehicleDoorsLocked(spawnedVehicle, 1)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

    local playerID = GetPlayerServerId(PlayerId())
    TriggerServerEvent('matDrop2Instructions', playerID)

    local x,y,z = 259.05, -15.29, 73.66

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if showMarker then
                DrawMarker(1, x, y, z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 255, false, false, false)
            end
        end
    end)
    showMarker = true
    return spawnedVehicle
end

--MATERIAL DROP 2
function MatDrop2()
    if DoesEntityExist(spawnedVehicle) then
        if IsMatDrop2VehInPlace(spawnedVehicle, 258.39, -14.84, 73.67, 5.0) then
            local playerID = GetPlayerServerId(PlayerId())
            HideMarker()
            TriggerEvent('qb-core:client:DrawText', 'Thanks, Heres your cut.', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerRewardHigh', playerID)
            DeleteVehicle(spawnedVehicle)
        else 
            local playerID = GetPlayerServerId(PlayerId())
            TriggerEvent('qb-core:client:DrawText', 'You didnt bring the truck?', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerLeftTruck', playerID)
            Wait(2000)
            arrivedNoVeh()
            HideMarker()
        end
    else
        local playerID = GetPlayerServerId(PlayerId())
        TriggerEvent('qb-core:client:DrawText', "Go see my buddy, I'll send you a location", 'right')
        Wait(3000)
        TriggerEvent('qb-core:client:HideText')
        TriggerServerEvent('stillNeedToStart2', playerID)
    end
end

--MATERIAL PICKUP 3
function MatPickup3()
    if DoesEntityExist(spawnedVehicle) then
        print("A vehicle is already spawned")
        return
    end

    local vehicleModel = GetHashKey("burrito3")

    print("Spawning burrito")

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end

    spawnedVehicle = CreateVehicle(vehicleModel, 1757.82, 3326.95, 41.33, 120.69, true, false)
    SetEntityAsMissionEntity(spawnedVehicle, true, true)

    GetVehicleDoorLockStatus(spawnedVehicle)
    SetVehicleDoorsLocked(spawnedVehicle, 1)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

    local playerID = GetPlayerServerId(PlayerId())
    TriggerServerEvent('matDrop3Instructions', playerID)

    local x,y,z = -355.83, 6068.12, 31.5

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if showMarker then
                DrawMarker(1, x, y, z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 255, false, false, false)
            end
        end
    end)
    showMarker = true
    return spawnedVehicle
end

--MATERIAL DROP 3
function MatDrop3()
    if DoesEntityExist(spawnedVehicle) then
        if IsMatDrop3VehInPlace(spawnedVehicle, -355.83, 6068.12, 31.5, 5.0) then
            local playerID = GetPlayerServerId(PlayerId())
            HideMarker()
            TriggerEvent('qb-core:client:DrawText', 'Thanks, Heres your cut.', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerRewardHigh', playerID)
            DeleteVehicle(spawnedVehicle)
        else 
            local playerID = GetPlayerServerId(PlayerId())
            TriggerEvent('qb-core:client:DrawText', 'You didnt bring the truck?', 'right')
            Wait(3000)
            TriggerEvent('qb-core:client:HideText')
            TriggerServerEvent('playerLeftTruck', playerID)
            Wait(2000)
            arrivedNoVeh()
            HideMarker()
        end
    else
        local playerID = GetPlayerServerId(PlayerId())
        TriggerEvent('qb-core:client:DrawText', "Go see my buddy, I'll send you a location", 'right')
        Wait(3000)
        TriggerEvent('qb-core:client:HideText')
        TriggerServerEvent('stillNeedToStart3', playerID)
    end
end

--CHECKS TO MAKE SURE THE VEHICLE SPAWNED FROM MAT PICKUP 1 IS IN THE CORRECT SPOT
function IsMatDrop1VehInPlace(vehicle, x, y, z, radius)
    local vehicleCoords = GetEntityCoords(vehicle)
    local distance = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, x, y, z)
    return distance <= radius
end

--CHECKS TO MAKE SURE THE VEHICLE SPAWNED FROM MAT PICKUP 2 IS IN THE CORRECT SPOT
function IsMatDrop2VehInPlace(vehicle, x, y, z, radius)
    local vehicleCoords = GetEntityCoords(vehicle)
    local distance = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, x, y, z)
    return distance <= radius
end

--CHECKS TO MAKE SURE THE VEHICLE SPAWNED FROM MAT PICKUP 3 IS IN THE CORRECT SPOT
function IsMatDrop3VehInPlace(vehicle, x, y, z, radius)
    local vehicleCoords = GetEntityCoords(vehicle)
    local distance = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, x, y, z)
    return distance <= radius
end

--HIDES THE DELIVERY MARKER
function HideMarker()
    showMarker = false
end

--SHOWS THE DELIVERY MARKER
function ShowMarker()
    showMarker = true
end

--IF THE PLAYER ARRIVES AT THE DELIVERY POINT WITHOUT THE VEHICLE, THIS DELETES IT
function arrivedNoVeh()
    if DoesEntityExist(spawnedVehicle) then
        DeleteVehicle(spawnedVehicle)
    end
end

--PART OF /CANCELRUN .. DELETES THE VAN IN A CLEAN WAY
RegisterNetEvent('cancelrun', function()
    if DoesEntityExist(spawnedVehicle) then
        TriggerEvent('qb-core:client:DrawText', 'Run is being cancelled, Your vehicle will be removed', 'right')
        Wait(3000)
        TriggerEvent('qb-core:client:HideText')
        DeleteVehicle(spawnedVehicle)
    else
        TriggerEvent('qb-core:client:DrawText', 'You cant cancel a run that doesnt exist', 'right')
        Wait(1000)
        TriggerEvent('qb-core:client:HideText')
    end
end)

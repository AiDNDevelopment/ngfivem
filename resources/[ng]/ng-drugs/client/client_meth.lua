local QBCore = exports['qb-core']:GetCoreObject()
local vehicleFound = false  -- Added variable to track if vehicle has been found

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, 0, 71)

        if DoesEntityExist(vehicle) then 
            local modelName = GetEntityModel(vehicle)
            local vehicleName = GetDisplayNameFromVehicleModel(modelName)

            if vehicleName == "JOURNEY" or vehicleName == "JOURNEY2" then
                if not vehicleFound then  -- Check if the vehicle has not been found before
                    vehicleFound = true
                    local plate = GetVehicleNumberPlateText(vehicle)
                    TriggerServerEvent("ng-drugs:server:checkJourneyOwned", plate, PlayerId())
                end
            else
                vehicleFound = false  -- Reset the vehicleFound variable if the vehicle is not appropriate
            end
        else
            vehicleFound = false  -- Reset the vehicleFound variable if no vehicle is found
        end
    end
end)

RegisterNetEvent("enterJourney")
AddEventHandler("enterJourney", function()
    local playerId = source
    local notificationMessage = "Press ~g~E~w~ to enter Journey (Player ID: " .. playerId .. ")"
    
    QBCore.Functions.Notify(notificationMessage, "success")

    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then 
        local modelName = GetEntityModel(vehicle)
        local vehicleName = GetDisplayNameFromVehicleModel(modelName)

        if vehicleName == "JOURNEY" or vehicleName == "JOURNEY2" then
            local targetSeat = 2  -- Change this to the desired seat index

            local keyPressed = false
            while not keyPressed do
                Citizen.Wait(0)
                if IsControlJustReleased(0, 38) then  -- "E" key
                    keyPressed = true
                end
            end

            if IsVehicleSeatFree(vehicle, targetSeat) then
                TaskWarpPedIntoVehicle(playerPed, vehicle, targetSeat)
            end
        end
    end
end)

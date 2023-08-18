local oxmysql = exports["oxmysql"]

RegisterServerEvent("ng-drugs:server:checkJourneyOwned")
AddEventHandler("ng-drugs:server:checkJourneyOwned", function(plate)
    local playerId = source -- Store the player ID before the callback
    print("Checking journey for plate: " .. plate)
    
    local response = oxmysql:fetchSync('SELECT `citizenid` FROM `player_vehicles` WHERE plate = ?', { plate })

    if response[1] then
        print("Plate is owned. Triggering client event for Player ID: " .. tostring(playerId))
        TriggerClientEvent("enterJourney", playerId) -- Trigger the client event
    else
        print("Plate is not owned.")
    end
end)

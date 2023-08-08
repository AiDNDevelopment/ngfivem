local QBCore = exports['qb-core']:GetCoreObject()

--CHECKS THE LICENSE PLATE AGAINST THE DB AND CHECKS TO SEE IF ITS VALID
RegisterNetEvent('checkVehicleOwnership')
AddEventHandler('checkVehicleOwnership', function(plate)
    local playerId = source
    print("Player ID on server side: " .. playerId)
    local result = exports.oxmysql:fetchSync('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
    local isOwned = result ~= nil
    TriggerClientEvent('checkVehicleOwnershipResult', playerId, isOwned)
end)
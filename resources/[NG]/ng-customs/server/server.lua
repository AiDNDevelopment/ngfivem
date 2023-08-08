RegisterNetEvent('attachSpoiler')
AddEventHandler('attachSpoiler', function(vehicle, spoilerIndex)
    TriggerClientEvent('attachSpoilerClient', -1, vehicle, spoilerIndex)
end)

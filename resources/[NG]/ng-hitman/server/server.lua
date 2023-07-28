local QBCore = exports['qb-core']:GetCoreObject()

-- Commands
-- check contracted
QBCore.Commands.Add("checkcontracted", "Check if player is contracted", {{name = "target", help = "ID of the target player"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1])) --/checkcontracted {id}

    if Player then -- check to make sure the player is online
        local plicense = QBCore.Functions.GetIdentifier(args[1], 'license') -- get players license
        local result = exports.oxmysql:fetchSync('SELECT contracted FROM players WHERE license = ?', { plicense }) -- using this license we go and check if the player is contracted

        if result[1].contracted == 1 then --If the result is 1 or above we have a contract on that player
            print ("Contracted") -- Prints contracted in server side for debug
            local contractAmmount = exports.oxmysql:fetchSync('SELECT contract_ammount FROM players WHERE license = ?', { plicense }) -- if we have a contract we then go to check how much the contract is worth
            TriggerClientEvent('QBCore:Notify',source,Player.PlayerData.charinfo.firstname ..' is contracted for: '.. '$'..contractAmmount[1].contract_ammount, 'error') --Debug notif because print doesnt handle arithmatic ig
        else
            TriggerClientEvent('QBCore:Notify', source, "Player is not contracted", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Lang:t('error.not_online')", 'error') -- if player is not online then we have an issue
    end
end)

--set contract
QBCore.Commands.Add("setcontract", "Set contract amount for player", {{name = "target", help = "ID of the target player"}, {name = "amount", help = "Contract amount"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])

    if Player then
        local plicense = QBCore.Functions.GetIdentifier(args[1], 'license')
        local result = exports.oxmysql:fetchSync('SELECT contracted FROM players WHERE license = ?', { plicense })
        if result[1].contracted == 1 then
            TriggerClientEvent('QBCore:Notify', source, Player.PlayerData.charinfo.firstname ..' is already contracted', 'error')
        elseif result[1].contracted == 0 then
            exports.oxmysql:execute('UPDATE players SET contract_ammount = ?, contracted = 1 WHERE license = ?', { amount, plicense })
            TriggerClientEvent('QBCore:Notify', source, "Contract amount set to $" .. amount, 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Lang:t('error.not_online')", 'error')
    end
end)

-- remove contract
QBCore.Commands.Add("removecontract", "Remove contract for player", {{name = "target", help = "ID of the target player"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))

    if Player then
        local plicense = QBCore.Functions.GetIdentifier(args[1], 'license')
        local result = exports.oxmysql:fetchSync('SELECT contracted FROM players WHERE license = ?', { plicense })
        if result[1].contracted == 1 then
            exports.oxmysql:execute('UPDATE players SET contract_ammount = 0, contracted = 0 WHERE license = ?', { plicense })
            TriggerClientEvent('QBCore:Notify', source, "Contract removed", 'success')
        else
            TriggerClientEvent('QBCore:Notify', source, "Player is not contracted", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Lang:t('error.not_online')", 'error')
    end
end)

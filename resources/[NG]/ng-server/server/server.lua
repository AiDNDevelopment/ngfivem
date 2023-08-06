local QBCore = exports['qb-core']:GetCoreObject()
local NewbColor = {255, 255, 0}
local hiddenPlayers = {}

--START MATERIAL RUNNING FUNCTIONS
--
--ADD MATERIAL PACKAGES TO THE PLAYER
RegisterNetEvent('addMatPackage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('matpackage', 1)
    
end)

-- REMOVE MATERIAL PACKAGES FROM THE PLAYER
RegisterNetEvent('removeMatPackages', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem('matpackage', 1)
end)

--PLAYER REWARD FOR COMPLETING THE RUN
RegisterNetEvent('playerMatReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
end)

--HIGH PLAYER REWARD (IN PREPERATION FOR VIP)
RegisterNetEvent('playerMatRewardHigh', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
end)

RegisterNetEvent('matDrop1Instructions', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'Get this vehicle to my guy.',
        embed = {
            type = "location",
            coords = { 843.62, -2180.04, 30.3 },
            phoneNumber = '911'
        }
    })
end)

RegisterNetEvent('stillNeedToStart', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'This is his location',
        embed = {
            type = "location",
            coords = { 843.62, -2180.04, 30.3 },
            phoneNumber = '911'
        }
    })
end)
--END MATERIAL RUNNING FUNCTIONS

--START COMMANDS
--
-- /NEWB COMMAND
QBCore.Commands.Add('newb', 'Send a message to the Newb Channel', {}, false, function(source, args)
    if hiddenPlayers[source] then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {'[NEWB]', 'You have toggled off newb messages and cannot send messages to this channel.'}
        })
        return
    end

    --local playerName = GetPlayerName(source)
    local message = table.concat(args, ' ')
    local Players = QBCore.Functions.GetPlayers()
    for _, v in pairs(Players) do
        if not hiddenPlayers[v] or v == source then
            TriggerClientEvent('chat:addMessage', v, {
                color = NewbColor,
                multiline = true,
                args = {'NEWB | '.. GetPlayerName(source), message}
            })
        end
    end
end, 'user')

-- /TOGNEWB COMMAND
QBCore.Commands.Add('tognewb', 'Toggle visibility of newb messages', {}, false, function(source)
    if hiddenPlayers[source] then
        hiddenPlayers[source] = nil
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {'[NEWB]', 'You will now see messages in the newb channel.'}
        })
    else
        hiddenPlayers[source] = true
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {'[NEWB]', 'You will no longer see messages in the newb channel.'}
        })
    end
end, 'user')

--/CANCELRUN COMMAND
QBCore.Commands.Add('cancelrun', 'cancels last material run and removes the vehicle', {}, false, function(source)
    TriggerClientEvent("cancelrun", source)
end,false)
--END COMMANDS
local QBCore = exports['qb-core']:GetCoreObject()
local NewbColor = {255, 255, 0}
local hiddenPlayers = {}

--START MATERIAL RUNNING FUNCTIONS
--
--PLAYER REWARD FOR COMPLETING THE RUN
RegisterNetEvent('playerReward', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    player.Functions.AddItem('gunparts', 100)

    TriggerClientEvent('QBCore:Notify', playerID, 'You have gained 100 gunparts!', 'success')
end)

RegisterNetEvent('playerRewardHigh', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    player.Functions.AddItem('gunparts', 500)

    TriggerClientEvent('QBCore:Notify', playerID, 'You have gained 500 gunparts!', 'success')
end)

--SENDS A MESSAGE TO THE PLAYER GIVING THEM INSTRUCTIONS TO MAT DROP 1
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

--SENDS A MESSAGE TO THE PLAYER GIVING THEM INSTRUCTIONS TO MAT DROP 2
RegisterNetEvent('matDrop2Instructions', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'Get this vehicle to my guy.',
        embed = {
            type = "location",
            coords = { 258.39, -14.84, 73.67},
            phoneNumber = '911'
        }
    })
end)

RegisterNetEvent('matDrop3Instructions', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'Get this vehicle to my guy.',
        embed = {
            type = "location",
            coords = { -355.83, 6068.12, 31.5},
            phoneNumber = '911'
        }
    })
end)

--SENDS A MESSAGE TO THE PLAYER GIVING THEM THE LOCATION OF MAT PICKUP 1 (IF THEY ARENT ALREADY ON A JOB)
RegisterNetEvent('stillNeedToStart', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'My buddy is waiting, go see him and bring me what he gives you.',
        embed = {
            type = "location",
            coords = { 702.61, -1138.32, 22.72, 314.6 },
            phoneNumber = '911'
        }
    })
end)
--SENDS A MESSAGE TO THE PLAUER GIVING THEM THE LOCATION OF MAT PICKUP 2 (IF THEY ARENT ALREADY ON A JOB)
RegisterNetEvent('stillNeedToStart2', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'My buddy is waiting, go see him and bring me what he gives you.',
        embed = {
            type = "location",
            coords = { -841.99, -2932.41, 12.95, 152.45 },
            phoneNumber = '911'
        }
    })
end)

--SENDS A MESSAE TO THE PLAYER GIVING THEM THE LOCATION OF MAT PICKUP 3 (IF THEY ARENT ALREADY ON A JOB)
RegisterNetEvent('stillNeedToStart3', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'My buddy is waiting, go see him and bring me what he gives you.',
        embed = {
            type = "location",
            coords = { 1761.01, 3324.92, 40.4, 104.27 },
            phoneNumber = '911'
        }
    })
end)

--SENDS A MESSAGE TO THE PLAYER IF THEY TURN UP TO THE DELIVERY POINT WITHOUT THE TRUCK
RegisterNetEvent('playerLeftTruck', function(playerID)
    local player = QBCore.Functions.GetPlayer(playerID)

    local phoneNumber = player.PlayerData.charinfo.phone

    print(phoneNumber)
    exports.npwd:emitMessage({
        senderNumber = '???',
        targetNumber = phoneNumber,
        message = 'What the hell! My contact said you turned up without the truck. This job is a bust.',
    })
end)
--
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
--
--END COMMANDS
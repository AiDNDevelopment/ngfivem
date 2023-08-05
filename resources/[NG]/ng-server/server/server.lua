local QBCore = exports['qb-core']:GetCoreObject()
local NewbColor = {255, 255, 0}
local hiddenPlayers = {}

--Materials Functions

--add Materials packages
RegisterNetEvent('addMatPackage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('matpackage', 1)
    
end)

-- Remove Materials Packages
RegisterNetEvent('removeMatPackages', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem('matpackage', 1)
end)

--Reward the player with gunparts
RegisterNetEvent('playerMatReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
end)

RegisterNetEvent('playerMatRewardHigh', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
end)
---End Materials Functions

---Commands

-- Newb command
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

-- Toggles newb
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
--End commands
local QBCore = exports['qb-core']:GetCoreObject()
NewbColor = {255, 255, 0}
local hiddenPlayers = {}







-- Newb command
QBCore.Commands.Add('newb', 'Send a message to the Newb Channel', {}, false, function(source, args)
    if hiddenPlayers[source] then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {'[Newb]', 'You have toggled off newb messages and cannot send messages to this channel.'}
        })
        return
    end

    local playerName = GetPlayerName(source)
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
QBCore.Commands.Add('toggleNewb', 'Toggle visibility of newb messages', {}, false, function(source, args)
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
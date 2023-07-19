QBCore.Commands.Add('newb', Lang:t("command.ooc.help"), {}, false, function(source, args)
        local message = table.concat(args, ' ')
        local Players = QBCore.Functions.GetPlayers()
        local Player = QBCore.Functions.GetPlayer(source)
        local playerCoords = GetEntityCoords(GetPlayerPed(source))
        for _, v in pairs(Players) do
            if v == source then
                TriggerClientEvent('chat:addMessage', v, {
                    color = QBConfig.Commands.NEWBColor,
                    multiline = true,
                    args = {'NEWB | '.. GetPlayerName(source), message}
                })
            elseif #(playerCoords - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
                TriggerClientEvent('chat:addMessage', v, {
                    color = QBConfig.Commands.NEWBColor,
                    multiline = true,
                    args = {'NEWB | '.. GetPlayerName(source), message}
                })
            elseif QBCore.Functions.HasPermission(v, 'admin') then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chat:addMessage', v, {
                        color = QBConfig.Commands.NEWBColor,
                        multiline = true,
                        args = {'Proximity OOC | '.. GetPlayerName(source), message}
                })
                TriggerEvent('qb-log:server:CreateLog', 'ooc', 'OOC', 'white', '**' .. GetPlayerName(source) .. '** (CitizenID: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. source .. ') **Message:** ' .. message, false)
                end
             end
        end
end, 'user')
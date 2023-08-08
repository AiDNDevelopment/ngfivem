CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 38) then
            test()
        end
    end
end)

RegisterNetEvent('attachSpoilerClient')
AddEventHandler('attachSpoilerClient', function(vehicle, spoilerIndex)
    print('attachSpoilerClient called with vehicle:', vehicle, 'spoilerIndex:', spoilerIndex)
    SetVehicleMod(vehicle, 0, spoilerIndex)
end)


function test()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local radius = 5.0 -- Change this to the radius in which you want to search for vehicles
    local modelHash = 0 -- Set this to 0 to search for any vehicle model
    local flags = 70 -- Set this to 70 to search for any vehicle type
    local vehicle = GetClosestVehicle(x, y, z, radius, modelHash, flags)
    if vehicle == 0 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Me", "No vehicle found!"}
        })
        return
    end
    openSpoilerMenu(vehicle)
end


function openSpoilerMenu(vehicle)
    local accept = exports["nh-context"]:ContextMenu({
        {
            header = "Select Spoiler",
        },
        {
            header = "Spoiler 1",
            args = {"1"}
        },
        {
            header = "Spoiler 2",
            args = {"2"}
        },
        {
            header = "Spoiler 3",
            args = {"3"}
        },
        {
            header = "Spoiler 4",
            args = {"4"}
        },
        {
            header = "Spoiler 5",
            args = {"5"}
        },
        {
            header = "Spoiler 6",
            args = {"6"}
        },
        {
            header = "Spoiler 7",
            args = {"7"}
        },
        {
            header = "Spoiler 8",
            args = {"8"}
        },
        {
            header = "Spoiler 9",
            args = {"9"}
        },
        {
            header = "Spoiler 10",
            args = {"10"}
        },
    })
    if accept ~= nil then
        if accept == "1" then
            TriggerEvent('attachSpoilerClient', vehicle, 1)
        elseif accept == "2" then
            TriggerEvent('attachSpoilerClient', vehicle, 2)
        elseif accept == "3" then
            TriggerEvent('attachSpoilerClient', vehicle, 3)
        elseif accept == "4" then
            TriggerEvent('attachSpoilerClient', vehicle, 4)
        elseif accept == "5" then
            TriggerEvent('attachSpoilerClient', vehicle, 5)
        elseif accept == "6" then
            TriggerEvent('attachSpoilerClient', vehicle, 6)
        elseif accept == "7" then
            TriggerEvent('attachSpoilerClient', vehicle, 7)
        elseif accept == "8" then
            TriggerEvent('attachSpoilerClient', vehicle, 8)
        elseif accept == "9" then
            TriggerEvent('attachSpoilerClient', vehicle, 9)
        elseif accept == "10" then
            TriggerEvent('attachSpoilerClient', vehicle, 10)
        end
    end
end


local QBCore = exports['qb-core']:GetCoreObject()
local blip = AddBlipForCoord(116.44, -1088.16, 29.22) -- this is our mision bli
local PackageCount = 0

--This Sets up the materials pickup and then handles everything to do with pickup
local Zone = nil
CreateThread(function()
    Zone = BoxZone:Create(vector3(156.47, -1065.58, 29.19), 1.4, 1, {
        name="matPickup1",
        heading=250,
        debugPoly=true,
        minZ=27.59,
        maxZ=31.59,
    })

    Zone:onPlayerInOut(function(isPointInside)
        local Player = PlayerPedId()
        if isPointInside and Player and PackageCount <= 0 then
            Wait(1000)
            QBCore.Functions.Notify('Client Ping')
            TriggerServerEvent('addMatPackage')
            PackageCount = PackageCount + 1
            DeliverPackages()
        else if PackageCount >= 1 then
            Wait(1000)
            QBCore.Functions.Notify('Deliver the packages you have first')
        end
        end
    end)
end)

--This sets up the materials drop off zone and handles everything at the drop off
CreateThread(function()
    Zone = BoxZone:Create(vector3(116.46, -1089.3, 29.23), 1.4, 1, {
        name="matDropoff",
        heading=92,
        debugPoly=true,
        minZ=27.23,
        maxZ=31.23
    })

    Zone:onPlayerInOut(function(isPointInside)
        local Player = PlayerPedId()
        if isPointInside and Player then
            QBCore.Functions.Notify('Inside Dropoff')
            TriggerServerEvent('removeMatPackages')
            Wait(1000)
            playerMatReward()
        end
    end)
end)

--Player has to deliver materials packages to a dropoff, this generates a blip that the player can target for gps
function DeliverPackages()
    SetBlipSprite(blip, 286)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Deliver Packages")
    EndTextCommandSetBlipName(blip)
end

--After the player has done the package drop off the player is then rewarded with gun parts which can be crafted into weapons later
function playerMatReward()
    Wait(1000)
    QBCore.Functions.Notify('You have been rewarded with Gun Parts')
    RemoveBlip(blip)
end
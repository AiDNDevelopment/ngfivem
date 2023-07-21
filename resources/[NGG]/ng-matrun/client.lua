local QBCore = exports['qb-core']:GetCoreObject()
local blip = AddBlipForCoord(802.93, -2135.77, 29.43) -- this is our mision bli
local PackageCount = 0

--This Sets up the materials pickup 1 and then handles everything to do with pickup
local Zone = nil

CreateThread(function()
    Zone = BoxZone:Create(vector3(704.64, -1142.62, 23.61), 6.4, 7, {
        name="matCollection1",
        heading=0,
        debugPoly=true,
        minZ=20.01,
        maxZ=27.21
      })
      

    Zone:onPlayerInOut(function(isPointInside)
        --local Player = PlayerPedId()
        if isPointInside and PackageCount == 0 then
            DeliverPackages()
        else if PackageCount == 1 then
            Wait(1000)
            QBCore.Functions.Notify('Deliver the packages you have first')
        end
        end
    end)
end)

--This sets up the materials drop off zone and handles everything at the drop off
CreateThread(function()
    Zone = BoxZone:Create(vector3(803.01, -2134.89, 29.37), 9.2, 5, {
        name="matDropoff1",
        heading=0,
        debugPoly=true,
        minZ=28.17,
        maxZ=32.17
      })

    Zone:onPlayerInOut(function(isPointInside)
        --local Player = PlayerPedId()
        if isPointInside and PackageCount == 1 then
            TriggerServerEvent('removeMatPackages')
            PackageCount = 0
            playerMatReward()
        else 
            QBCore.Functions.Notify('Go get a package')
        end
    end)
end)

--Player has to deliver materials packages to a dropoff, this generates a blip that the player can target for gps
function DeliverPackages()
    PackageCount = 1

    Wait(1000)
    TriggerServerEvent('addMatPackage')

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
    TriggerServerEvent('playerMatReward')
    
    RemoveBlip(blip)
end
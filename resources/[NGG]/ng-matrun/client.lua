local QBCore = exports['qb-core']:GetCoreObject()
local PackageCount = 0
local Zone = nil


--Materials Pickup 1
CreateThread(function()
    Zone = BoxZone:Create(vector3(704.64, -1142.62, 23.61), 6.4, 7, {
        name="matCollection1",
        heading=0,
        debugPoly=true,
        minZ=20.01,
        maxZ=27.21
      })
      
    Zone:onPlayerInOut(function(isPointInside)
        if isPointInside and PackageCount == 0 then
            DeliverPackages()
        else if PackageCount == 1 then
            Wait(5000)
            TriggerEvent('qb-core:client:DrawText', 'I can’t hand over more than one package.', 'top')
            Wait(5000)
            TriggerEvent('qb-core:client:HideText')
        end
        end
    end)
end)

--Materials Dropoff 1
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
            TriggerEvent('qb-core:client:DrawText', 'You’re empty-handed. Where’s the package?', 'top')
            Wait(5000)
            TriggerEvent('qb-core:client:HideText')
        end
    end)
end)


--This handles giving the player the package for delivery and instructing them on where to go. 
function DeliverPackages()
    PackageCount = 1 -- Adjust the package count to 1 so that we cant collect another
    TriggerServerEvent('addMatPackage')
    TriggerEvent('qb-core:client:DrawText', 'Get this package to my guy at Ammu-Nation #11.', 'top') -- Fancy notification at the top of the screen with this text

    blip = AddBlipForCoord(802.93, -2135.77, 29.43) -- This is the marker blip, Having it anywhere else places the marker the entire time until 1 run has been done
    SetBlipSprite(blip, 286) -- All of this is the styling of the blip
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Deliver Packages")
    EndTextCommandSetBlipName(blip) -- This is the end of the blip config

    Wait(5000)
    TriggerEvent('qb-core:client:HideText') -- Hides the text shown earlier on
end

--After the player has done the package drop off the player is then rewarded with gun parts which can be crafted into weapons later
function playerMatReward()
    Wait(1500)
    TriggerEvent('qb-core:client:DrawText', 'You delivered. Here’s a taste of the profits.', 'top')
    TriggerServerEvent('playerMatReward')
    RemoveBlip(blip)
    Wait(5000)
    TriggerEvent('qb-core:client:HideText')
end
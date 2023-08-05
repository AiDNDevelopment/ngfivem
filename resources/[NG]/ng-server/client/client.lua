local PackageCount = 0
local Zone = nil
local spawnedVehicle

--START MATERIAL RUNNING CLIENT SIDE SCRIPTS
--
--Materials Pickup 2 (Our Time:)
CreateThread(function()
    Zone = BoxZone:Create(vector3(-655.87, -2451.1, 13.94), 10.2, 7, {
      name="matPick2",
      heading=240,
      debugPoly=true,
      minZ=11.74,
      maxZ=15.74
    })
      
    Zone:onPlayerInOut(function(isPointInside)
        if isPointInside and PackageCount == 0 then
            DeliverPackages2()
        else if PackageCount == 1 then
            Wait(5000)
            TriggerEvent('qb-core:client:DrawText', 'I can’t hand over more than one package.', 'top')
            Wait(5000)
            TriggerEvent('qb-core:client:HideText')
        end
        end
    end)
end)

--Materials Pickup Sandy (Our Time:)
CreateThread(function()
    Zone = BoxZone:Create(vector3(1693.54, 3284.29, 41.15), 12.0, 15, {
        name="matPickupSandy",
        heading=35,
        debugPoly=true,
        minZ=40.15,
        maxZ=44.75
      })
      
    Zone:onPlayerInOut(function(isPointInside)
        if isPointInside and PackageCount == 0 then
            DeliverPackagesSandy()
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

--Materials drop 2
CreateThread(function()
    Zone = BoxZone:Create(vector3(250.84, -15.54, 73.63), 6.0, 7, {
        name="matDrop2",
        heading=70,
        debugPoly=true,
        minZ=72.63,
        maxZ=76.83
      })

    Zone:onPlayerInOut(function(isPointInside)
        --local Player = PlayerPedId()
        if isPointInside and PackageCount == 1 then
            TriggerServerEvent('removeMatPackages')
            PackageCount = 0
            playerMatRewardHigh()
        else
            TriggerEvent('qb-core:client:DrawText', 'You’re empty-handed. Where’s the package?', 'top')
            Wait(5000)
            TriggerEvent('qb-core:client:HideText')
        end
    end)
end)

--Materials drop Sandy shores
CreateThread(function()
    Zone = BoxZone:Create(vector3(-356.79, 6069.37, 31.5), 7.4, 10, {
        name="matDropSandy",
        heading=315,
        debugPoly=true,
        minZ=30.3,
        maxZ=36.1
      })

    Zone:onPlayerInOut(function(isPointInside)
        --local Player = PlayerPedId()
        if isPointInside and PackageCount == 1 then
            TriggerServerEvent('removeMatPackages')
            PackageCount = 0
            playerMatRewardHigh()
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
    TriggerEvent('qb-core:client:DrawText', 'Get this package to my guy at Ammu-Nation #11.', 'right') -- Fancy notification at the top of the screen with this text
    

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

function DeliverPackages2()
    PackageCount = 1 -- Adjust the package count to 1 so that we cant collect another
    TriggerServerEvent('addMatPackage')
    TriggerEvent('qb-core:client:DrawText', 'Get this package to my guy at Ammu-Nation.', 'top') -- Fancy notification at the top of the screen with this text

    blip2 = AddBlipForCoord(250.99, -15.49, 73.6) -- This is the marker blip, Having it anywhere else places the marker the entire time until 1 run has been done
    SetBlipSprite(blip2, 286) -- All of this is the styling of the blip
    SetBlipDisplay(blip2, 2)
    SetBlipScale(blip2, 1.0)
    SetBlipColour(blip2, 5)
    SetBlipAsShortRange(blip2, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Deliver Packages")
    EndTextCommandSetBlipName(blip2) -- This is the end of the blip config

    Wait(5000)
    TriggerEvent('qb-core:client:HideText') -- Hides the text shown earlier on
end

function DeliverPackagesSandy()
    PackageCount = 1 -- Adjust the package count to 1 so that we cant collect another
    TriggerServerEvent('addMatPackage')
    TriggerEvent('qb-core:client:DrawText', 'Get this package to my guy at Ammu-Nation.', 'top') -- Fancy notification at the top of the screen with this text

    blipSandy = AddBlipForCoord(-356.65, 6068.84, 31.5) -- This is the marker blip, Having it anywhere else places the marker the entire time until 1 run has been done
    SetBlipSprite(blipSandy, 286) -- All of this is the styling of the blip
    SetBlipDisplay(blipSandy, 2)
    SetBlipScale(blipSandy, 1.0)
    SetBlipColour(blipSandy, 5)
    SetBlipAsShortRange(blipSandy, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Deliver Packages")
    EndTextCommandSetBlipName(blipSandy) -- This is the end of the blip config

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

function playerMatRewardHigh()
    Wait(1500)
    TriggerEvent('qb-core:client:DrawText', 'You delivered. Here’s a taste of the profits.', 'top')
    Wait(2000)
    TriggerEvent('qb-core:client:HideText')
    Wait(1500)
    TriggerEvent('qb-core:client:DrawText', 'Here’s some extra for doing the longer run.', 'top')
    TriggerServerEvent('playerMatRewardHigh')
    RemoveBlip(blip2)
    Wait(5000)
    TriggerEvent('qb-core:client:HideText')
end

--MATERIAL PICKUP 1
function MatPickup1()
    if DoesEntityExist(spawnedVehicle) then
        print("A vehicle is already spawned")
        return
    end

    local vehicleModel = GetHashKey("burrito3")

    print("Spawning burrito")

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end

    spawnedVehicle = CreateVehicle(vehicleModel, 702.95, -1142.03, 23.67,89.47, true, false)
    SetEntityAsMissionEntity(spawnedVehicle, true, true)

    GetVehicleDoorLockStatus(spawnedVehicle)
    SetVehicleDoorsLocked(spawnedVehicle, 1)

    local playerPed = PlayerPedId()
    TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

    return spawnedVehicle
end

RegisterNetEvent('matrun:client:matrun1', function()

    if DoesEntityExist(spawnedVehicle) then
        TriggerEvent('qb-core:client:DrawText', 'If you left the vehicle its toast', 'right')
        Wait(5000)
        TriggerEvent('qb-core:client:HideText')
    else
        MatPickup1()
    end

end)

RegisterNetEvent('cancelrun', function()
    if DoesEntityExist(spawnedVehicle) then
        DeleteVehicle(spawnedVehicle)
        print("Vehicle deleted")
    else
        print("No vehicle to delete")
    end
end)
--END MATERIAL RUNNING CLIENT SIDE SCRIPTS
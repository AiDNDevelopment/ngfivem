local QBCore = exports['qb-core']:GetCoreObject()
local classTable = {
    [0] = "Compacts",
    [1] = "Sedans",
    [2] = "SUVs",
    [3] = "Coupes",
    [4] = "Muscle",
    [5] = "Sports Classics",
    [6] = "Sports",
    [7] = "Super",
    [8] = "Motorcycles",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility"
}

--DEBUG PROBBALY CHANGE THIS BUT THIS CHECKS IF THE PLAYER IS PRESSING E
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 38) then
            print("getting vehicle")
            getPlayerVeh()
        end
    end
end)

--#region FIND THE VEHICLE TO MOD
function getClosestVehicleToPlayer()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    return GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
end

--GETS THE CLOSEST VEHICLE AND BEGINS TO CHECK IF ITS PLAYER OWNED
function getPlayerVeh()
    local closestVehicle = getClosestVehicleToPlayer()
    local plate = GetVehicleNumberPlateText(closestVehicle)
    TriggerServerEvent('checkVehicleOwnership',plate)
    getPlayerVehInfo()
end

function getPlayerVehInfo()
    local closestVehicle = getClosestVehicleToPlayer()
    local model = GetEntityModel(closestVehicle)
    local make = GetDisplayNameFromVehicleModel(model)
    local makeName = GetLabelText(make)
    local class = GetVehicleClass(closestVehicle)
    local classString = classTable[class]

    print("make ".. makeName)
    print("class " .. classString)
end

RegisterNetEvent('checkVehicleOwnershipResult', function(isOwned)
    if isOwned then
        TriggerEvent("ng-customs:mainMenu")
    else
        print("Vehicle not registered by any player")
    end
end)
--#endregion

--#region EACH PART HAS ITS OWN MENU
RegisterNetEvent("ng-customs:mainMenu", function()
    TriggerEvent("nh-context:createMenu", {
        {
            header = "Main Menu"
        },
        {
            header = "Spoilers",
            context = "Open Spoiler Selection",
            event = "ng-customs:spoilerMenu"
        },
        {
            header = "Bumper (F)",
            context = "Open bumper (F) selection",
            event = "ng-customs:fBumperMenu"
        },
        {
            header = "Bumper (R)",
            context = "Open bumper (R) selection",
            event = "ng-customs:rBumperMenu"
        },
        {
            header = "Skirts",
            context = "Open skirt selection",
            event = "ng-customs:skirtMenu"
        },
        {
            header = "Exhausts",
            context = "Open exhaust selection",
            event = "ng-customs:exhaustMenu"
        },
        {
            header = "Roofs",
            context = "Open roof selection",
            event = "ng-customs:roofMenu"
        },
    })
end)

RegisterNetEvent("ng-customs:spoilerMenu", function()
    local menu = {
        {
            header = "Spoilers"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setSpoiler",
            args = {i}
        })
    end

    TriggerEvent("nh-context:createMenu", menu)
end)

RegisterNetEvent("ng-customs:fBumperMenu", function()
    local menu = {
        {
            header = "Bumpers(F)"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setfBumper",
            args = {i}
        })
    end
    TriggerEvent("nh-context:createMenu", menu)
end)

RegisterNetEvent("ng-customs:rBumperMenu", function()
    local menu = {
        {
            header = "Bumpers(F)"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setrBumper",
            args = {i}
        })
    end
    TriggerEvent("nh-context:createMenu", menu)
end)

RegisterNetEvent("ng-customs:skirtMenu", function()
    local menu = {
        {
            header = "Skirts"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setSkirt",
            args = {i}
        })
    end

    TriggerEvent("nh-context:createMenu", menu)
end)

RegisterNetEvent("ng-customs:exhaustMenu", function()
    local menu = {
        {
            header = "Skirts"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setExhaust",
            args = {i}
        })
    end

    TriggerEvent("nh-context:createMenu", menu)
end)

RegisterNetEvent("ng-customs:roofMenu", function()
    local menu = {
        {
            header = "Skirts"
        },
        {
            header = "< GO BACK",
            event = "ng-customs:mainMenu"
        },
    }

    for i = 1, 15 do
        table.insert(menu, {
            header = "Option " .. i,
            event = "ng-customs:setChassis",
            args = {i}
        })
    end

    TriggerEvent("nh-context:createMenu", menu)
end)
--#endregion

--#region SET PART SCRIPTS
RegisterNetEvent("ng-customs:setSpoiler", function(args) 
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
    
    if args >= 1 and args <= 15 then
        print("Selected " .. args)
        SetVehicleMod(vehicle, 0, args)
    end    
end)

RegisterNetEvent("ng-customs:setfBumper", function(args)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.9, 0, 70)

    if args >=1 and args <=15 then 
        print("Selected " .. args)
        SetVehicleMod(vehicle, 1, args)
    end
end)

RegisterNetEvent("ng-customs:setrBumper", function(args)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.9, 0, 70)

    if args >=1 and args <=15 then 
        print("Selected " .. args)
        SetVehicleMod(vehicle, 2, args)
    end
end)

RegisterNetEvent("ng-customs:setSkirt", function(args) 
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
    
    if args >= 1 and args <= 15 then
        print("Selected " .. args)
        SetVehicleMod(vehicle, 3, args)
    end    
end)

RegisterNetEvent("ng-customs:setExhaust", function(args) 
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
    
    if args >= 1 and args <= 15 then
        print("Selected " .. args)
        SetVehicleMod(vehicle, 4, args)
    end    
end)

RegisterNetEvent("ng-customs:setRoof", function(args) 
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
    
    if args >= 1 and args <= 15 then
        print("Selected " .. args)
        SetVehicleMod(vehicle, 5, args)
    end    
end)
--#endregion
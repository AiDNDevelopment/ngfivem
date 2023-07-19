--This is really just a bunch of net events that all do roughly the same thing but with differnet names, they should be easy enough to understand
-- 
local QBCore = exports['qb-core']:GetCoreObject()

--add Materials packages
RegisterNetEvent('addMatPackage', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
    
end)

-- Remove Materials Packages
RegisterNetEvent('removeMatPackages', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem('gunparts', 1)
end)

--Reward the player with gunparts
RegisterNetEvent('playerMatReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('gunparts', 1)
end)
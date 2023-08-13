
local zoneX = -1351.5
local zoneY = 4421.07
local zoneRadius = 100

local spawnedProps = {}

local minDistance = 10

-- Number of weed plants to spawn
local numWeedPlants = 100


function SpawnWeedPlant(x, y, z)
    local weedObject = GetHashKey(Config.PlantModel)
    local weedEntity = CreateObjectNoOffset(weedObject, x, y, z, true, false, true)
    table.insert(spawnedProps, weedEntity)
end

function getDistance(x1, y1, x2, y2)
    return math.sqrt((x2-x1) ^ 2 + (y2 - y1) ^ 2)
end

-- Function to generate random positions within the defined zone
function GenerateRandomPositionInZone()
    local randomX, randomY

    -- Generate random positions until a valid position is found
    while true do
        local randomAngle = math.rad(math.random(360)) -- Random angle in radians
        local randomDistance = math.random() * zoneRadius

        randomX = zoneX + randomDistance * math.cos(randomAngle)
        randomY = zoneY + randomDistance * math.sin(randomAngle)

        -- Check if the generated position is far enough from existing weed plants
        local isValid = true
        for i, prop in ipairs(spawnedProps) do
            local propX, propY = table.unpack(GetEntityCoords(prop))
            local distance = getDistance(randomX, randomY, propX, propY)
            if distance < minDistance then
                isValid = false
                break
            end
        end

        if isValid then
            break
        end
    end

    return randomX, randomY
end

function RegisterWeedPlantTargets(spawnedProps)
    for i, prop in ipairs(spawnedProps) do
        local eventName = "ng-drugs:client:interactWeedPlant" .. i
        local args = i
        exports["qb-target"]:AddBoxZone("WeedPlant" .. i, GetEntityCoords(prop), 1.0, 1.0, {
            name = "WeedPlant" .. i,
            heading = 0,
            debugPoly = true,
            minZ = GetEntityCoords(prop).z,
            maxZ = GetEntityCoords(prop).z + 1.0
        }, {
            options = {
                {
                    type = 'client',
                    event = eventName,
                    icon = "fas fa-cannabis",
                    label = "Interact with weed plant",
                }
            },
            distance = 1.5
        })

        RegisterPlantInteractionHandler(eventName, i)
    end
end

function RegisterPlantInteractionHandler(eventName, index)
    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function()
        local plantIndex = index
        TriggerServerEvent("ng-drugs:server:interactWeedPlant", plantIndex)
    end)
end

-- Generate random positions within the zone and spawn weed plants
for i = 1, numWeedPlants do
    local randomX, randomY = GenerateRandomPositionInZone()
    local foundGround, groundZ = GetGroundZFor_3dCoord(randomX, randomY, 1000.0)
    if foundGround then
        SpawnWeedPlant(randomX, randomY, groundZ)
    end
end

RegisterWeedPlantTargets(spawnedProps)

RegisterNetEvent("ng-drugs:client:deletePlant", function(plantIndex)
    print(plantIndex)
    local prop = spawnedProps[plantIndex]
    if DoesEntityExist(prop) then 
        DeleteObject(prop)
        spawnedProps[plantIndex] = nil
        local zoneName = "WeedPlant" .. plantIndex
        exports["qb-target"]:RemoveZone(zoneName)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then 
        return
    end

    for i, prop in pairs(spawnedProps) do 
        if DoesEntityExist(prop) then 
            DeleteObject(prop)
        end
    end

    for i, prop in pairs(spawnedProps) do 
        exports["qb-target"]:RemoveZone("WeedPlant" .. i)
    end

    spawnedProps = {}
end)

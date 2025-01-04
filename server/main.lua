local Core = exports.vorp_core:GetCore()

local function isCloseToDoor(playerPed, door)
    local coords <const> = GetEntityCoords(playerPed)
    local distance = #(coords - door.Pos)
    return distance <= 3.0
end

RegisterNetEvent("vorp_doorlocks:Server:UpdateDoorState", function(door, state, isLockPicked)
    local _source <const> = source

    local value <const> = Config.Doors[door]
    if not value then return end

    if value and not isCloseToDoor(GetPlayerPed(_source), value) then
        return print(string.format(Config.lang.HackAttempt, GetPlayerName(_source), _source))
    end

    -- player was removed from the door perms
    if value.isAllowed == false then
        return Core.NotifyObjective(_source, "not allowed to open this door", 5000) 
    end

    -- export wasn't used to allow or disallow so we check for permissions, other wise if true then player was allowed so we skip permissions checks
    if value.isAllowed == nil then
        if not isLockPicked and value.Permissions then
            local user <const> = Core.getUser(_source)
            if not user then return end

            local notify = Config.lang.NotAllowed
            local character <const> = user.getUsedCharacter
            local job <const> = character.job
            local grade <const> = character.jobGrade

            if not value.Permissions[job] then
                notify = Config.lang.NotAllowed
            end

            if grade < value.Permissions[job] then
                notify = Config.lang.GradeNotalowed
            end

            -- if its valid then allow check if its char id allowed
            if not value.UniquePermissions then
                return Core.NotifyObjective(_source, notify, 5000)
            end
        end

        if not isLockPicked and value.UniquePermissions then
            local charid <const> = Player(_source).state.Character.CharId
            if not value.UniquePermissions[charid] then
                return Core.NotifyObjective(_source, "not allowed to open this door", 5000)
            end
        end
    end

    value.DoorState = state -- sync
    TriggerClientEvent("vorp_doorlocks:Client:UpdateDoorState", -1, door, state)
end)

CreateThread(function()
    for _, value in pairs(Config.Lockpicks) do
        for _, item in pairs(value) do
            exports.vorp_inventory:registerUsableItem(item, function(data)
                TriggerClientEvent("vorp_doorlocks:Client:lockpickdoor", data.source, item, data.item.id)
                exports.vorp_inventory:closeInventory(data.source)
            end)
        end
    end
end)


RegisterNetEvent("vorp_doorlocks:Server:AlertPolice", function(door)
    local _source <const> = source
    -- security
    local value <const> = Config.Doors[door]
    if not value then return end
    if not value.Alert then return end

    local sourceCoords = GetEntityCoords(GetPlayerPed(_source))
    local distances = {}

    for _, playerId in ipairs(GetPlayers()) do
        if Player(tonumber(playerId)).state.isPoliceDuty then
            local playerCoords = GetEntityCoords(GetPlayerPed(tonumber(playerId)))
            local distance = #(sourceCoords - playerCoords)
            table.insert(distances, { id = playerId, distance = distance })
        end
    end

    table.sort(distances, function(a, b) return a.distance < b.distance end)

    for i = 1, math.min(Config.MinAlert, #distances) do
        local closestPlayer = distances[i]
        Core.NotifyLeft(tonumber(closestPlayer.id), Config.lang.Alerts.PoliceAlertTitle,
            Config.lang.Alerts.PoliceAlertMessage, Config.lang.Alerts.PoliceAlertIcon,
            Config.lang.Alerts.PoliceAlertPicture, Config.lang.Alerts.PoliceAlertDuration,
            Config.lang.Alerts.PoliceAlertColor)
    end
end)

-- remove item
RegisterNetEvent("vorp_doorlocks:Server:RemoveLockpick", function(id)
    local _source <const> = source
    local user <const> = Core.getUser(_source)
    if not user then return end

    local result = exports.vorp_inventory:subItemById(_source, id)
    if not result then
        print("player", GetPlayerName(_source),  "lockpicked door but the lockpick wasnt in his inventory probably removed the item to pick it up later")
    end
end)

AddEventHandler("vorp:SelectedCharacter", function(source, character)
    if Config.DevMode then return end

    -- Sync door states
    local gatherStates = {}
    for key, value in pairs(Config.Doors) do
        gatherStates[key] = value.DoorState
    end

    local data <const> = msgpack.pack(gatherStates)
    TriggerClientEvent("vorp_doorlocks:Client:Sync", source, data)
end)


AddEventHandler("vorp:playerJobChange", function(source, newjob, oldjob)
    SetTimeout(1000, function() -- wait for statebags to be available
        TriggerClientEvent("vorp_doorlocks:Client:UpdatePerms", source)
    end)
end)

-- easily from your resources allow or disallow source to this door dynamically
exports('updateDoorPermission', function(source, door, allow)
    if not Config.Doors[door] then return print("no door exists with this id", door) end

    if not Player(source).state.IsInSession then
        return print("you cannot modify permissions until player is in session", source)
    end
    
    Config.Doors[door].isAllowed = allow
    TriggerClientEvent("vorp_doorlocks:Client:UpdatePerms", source, { door = door, perms = allow })
end)

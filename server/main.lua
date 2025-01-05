local Core <const> = exports.vorp_core:GetCore()

local function isCloseToDoor(playerPed, door)
    local coords <const> = GetEntityCoords(playerPed)
    local distance <const> = #(coords - door.Pos)
    return distance <= 3.0
end

Core.Callback.Register("vorp_doorlocks:Server:CheckDoorState", function(source, cb, door, state)
    local _source <const> = source

    local value <const> = Config.Doors[door]
    if not value then return cb(false) end

    if value and not isCloseToDoor(GetPlayerPed(_source), value) then
        print(string.format(Config.lang.HackAttempt, GetPlayerName(_source), _source))
        return cb(false)
    end

    -- player was removed from the door perms
    if value.isAllowed == false then
        Core.NotifyObjective(_source, "not allowed to open this door", 5000)
        return cb(false)
    end

    -- export wasn't used to allow or disallow so we check for permissions, other wise if true then player was allowed so we skip permissions checks
    if value.isAllowed == nil then
        if value.Permissions then
            local user <const> = Core.getUser(_source)
            if not user then return cb(false) end

            local notify = ""
            local character <const> = user.getUsedCharacter
            local job <const> = character.job
            local grade <const> = character.jobGrade

            if value.Permissions[job] == nil then
                notify = Config.lang.NotAllowed
            end

            if grade < value.Permissions[job] then
                notify = Config.lang.GradeNotalowed
            end

            -- if its valid then allow check if its char id allowed
            if not value.UniquePermissions and notify ~= "" then
                Core.NotifyObjective(_source, notify, 5000)
                return cb(false)
            end
        end

        if value.UniquePermissions then
            local charid <const> = Player(_source).state.Character.CharId
            if value.UniquePermissions[charid] == nil then
                Core.NotifyObjective(_source, "not allowed to open this door", 5000)
                return cb(false)
            end
        end
    end

    if value.DoubleDoor then
        local door1 <const> = Config.Doors[value.DoubleDoor]
        if door1 then
            door1.DoorState = state
        end
    end

    value.DoorState = state -- sync
    TriggerClientEvent("vorp_doorlocks:Client:UpdateDoorState", -1, door, state, value.DoubleDoor)
    return cb(true)
end)

local lockpicking = {}

RegisterNetEvent("vorp_doorlocks:Server:UpdateDoorState", function(door)
    local _source <const> = source

    local value <const> = Config.Doors[door]
    if not value then return end

    if value and not isCloseToDoor(GetPlayerPed(_source), value) then
        return print(string.format(Config.lang.HackAttempt, GetPlayerName(_source), _source))
    end

    if not lockpicking[_source] then
        return print(string.format("player %s tried to lockpick door without using lockpick", GetPlayerName(_source)))
    end

    if value.DoubleDoor then
        local door1 <const> = Config.Doors[value.DoubleDoor]
        if door1 then
            door1.DoorState = 0
        end
    end

    value.DoorState = 0 -- sync
    TriggerClientEvent("vorp_doorlocks:Client:UpdateDoorState", -1, door, 0, value.DoubleDoor)
end)

CreateThread(function()
    for _, value in pairs(Config.Lockpicks) do
        for _, item in pairs(value) do
            exports.vorp_inventory:registerUsableItem(item, function(data)
                exports.vorp_inventory:closeInventory(data.source)

                lockpicking[data.source] = true

                local result <const> = Core.Callback.TriggerAwait("vorp_doorlocks:Client:lockpickdoor", data.source, item)

                if result then
                    local result1 <const> = exports.vorp_inventory:subItemById(data.source, data.item.id)
                    if not result1 then
                        print("player", GetPlayerName(data.source), "lockpicked door but the lockpick wasnt in his inventory probably removed the item to pick it up later")
                    end
                end

                if lockpicking[data.source] then
                    lockpicking[data.source] = nil
                end
            end)
        end
    end
end)



RegisterNetEvent("vorp_doorlocks:Server:AlertPolice", function(door)
    local _source <const> = source

    local value <const> = Config.Doors[door]
    if not value or not value.Alert then return end

    if not lockpicking[_source] then return end

    local sourceCoords <const> = GetEntityCoords(GetPlayerPed(_source))
    local distances <const> = {}

    for _, playerId in ipairs(GetPlayers()) do
        if Player(tonumber(playerId)).state.isPoliceDuty then
            local playerCoords <const> = GetEntityCoords(GetPlayerPed(tonumber(playerId)))
            local distance <const> = #(sourceCoords - playerCoords)
            table.insert(distances, { id = playerId, distance = distance })
        end
    end

    if #distances == 0 then return end

    table.sort(distances, function(a, b) return a.distance < b.distance end)

    for i = 1, math.min(Config.MinAlert, #distances) do
        local closestPlayer <const> = distances[i]
        Core.NotifyLeft(tonumber(closestPlayer.id), Config.lang.Alerts.PoliceAlertTitle,
            Config.lang.Alerts.PoliceAlertMessage, Config.lang.Alerts.PoliceAlertIcon,
            Config.lang.Alerts.PoliceAlertPicture, Config.lang.Alerts.PoliceAlertDuration,
            Config.lang.Alerts.PoliceAlertColor)
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

--player drop event
AddEventHandler("playerDropped", function()
    local _source <const> = source
    if lockpicking[_source] then
        lockpicking[_source] = nil
    end
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

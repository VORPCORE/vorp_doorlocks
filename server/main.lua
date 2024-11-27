local Core = exports.vorp_core:GetCore()

local function isCloseToDoor(playerPed, door)
    local coords <const> = GetEntityCoords(playerPed)
    local distance = #(coords - door.Pos)
    return distance <= 3.0
end

RegisterNetEvent("vorp_doorlocks:Server:UpdateDoorState", function(door, state, isLockPicked)
    local _source <const> = source

    local value <const> = Config.Doors[door]

    if value and not isCloseToDoor(GetPlayerPed(_source), value) then
        return print(string.format(Config.lang.HackAttempt, GetPlayerName(_source), _source))
    end

    if not isLockPicked and value and value.Permissions then
        local user <const> = Core.getUser(_source)
        if not user then return end
        local character <const> = user.getUsedCharacter
        local job <const> = character.job
        local grade <const> = character.jobGrade
        if not value.Permissions[job] then
            return Core.NotifyObjective(_source, Config.lang.NotAllowed, 5000)
        end

        if  grade < value.Permissions[job]  then
            return Core.NotifyObjective(_source, Config.lang.GradeNotalowed, 5000)
        end
    end

    value.DoorState = state -- sync
    TriggerClientEvent("vorp_doorlocks:Client:UpdateDoorState", -1, door, state)
end)

CreateThread(function()
    for _, value in pairs(Config.Lockpicks) do
        for _, item in pairs(value) do
            exports.vorp_inventory:registerUsableItem(item, function(data)
                TriggerClientEvent("vorp_doorlocks:Client:lockpickdoor", data.source, item)
                exports.vorp_inventory:closeInventory(data.source)
            end)
        end
    end
end)

RegisterNetEvent("vorp_doorlocks:Server:AlertPolice", function()
    local _source <const> = source
    --TODO: only closest player ? show on map where it was?
    for index, value in ipairs(GetPlayers()) do
        if Player(tonumber(value)).state.isPoliceDuty then
            Core.NotifyLeft(tonumber(value), Config.lang.Alerts.PoliceAlertTitle, Config.lang.Alerts.PoliceAlertMessage, Config.lang.Alerts.PoliceAlertIcon, Config.lang.Alerts.PoliceAlertPicture, Config.lang.Alerts.PoliceAlertDuration, Config.lang.Alerts.PoliceAlertColor)
        end
    end
end)

-- remove item
RegisterNetEvent("vorp_doorlocks:Server:RemoveLockpick", function(item)
    local _source <const> = source
    local user <const> = Core.getUser(_source)
    if not user then return end
    exports.vorp_inventory:subItem(_source, item, 1)
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

local Core = exports.vorp_core:GetCore()

RegisterNetEvent("vorp_doorlocks:Server:UpdateDoorState", function(door, state)
    local _source <const> = source

    local value = Config.Doors[door]
    if value and value.Permissions then
        local user = Core.getUser(_source)
        if not user then return end
        local character = user.getUsedCharacter
        local job = character.job
        if not value.Permissions[job] then return Core.NotifyObjective("you dont have the right job", 5000) end
    end

    Config.Doors[door].state = state -- sync
    TriggerClientEvent("vorp_doorlocks:Client:UpdateDoorState", -1, door, state)
end)

CreateThread(function()
    for door, value in pairs(Config.Doors) do
        if value.BreakAble then
            for _, item in ipairs(value.BreakAble) do
                exports.vorp_inventory:registerUsableItem(item, function(data)
                    TriggerClientEvent("vorp_doorlocks:Client:lockpickdoor", data.source, door, item)
                    exports.vorp_inventory:closeInventory(data.source)
                end)
            end
        end
    end
end)

RegisterNetEvent("vorp_doorlocks:Server:AlertPolice", function()
    local _source <const> = source
    --todo needs to alert vorp police
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

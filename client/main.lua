local PromptGroup1 <const> = GetRandomIntInRange(0, 0xffffff)
local OpenDoors = 0
local Core <const> = exports.vorp_core:GetCore()
local LIB <const> = Import "/config"
local CONFIG <const> = LIB.CONFIG --[[@as vorp_doorlocks_config]]

local GetEntityCoords <const> = GetEntityCoords
local Wait <const> = Wait


local function loadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model, false)
        repeat Wait(0) until HasModelLoaded(model)
    end
end

local function loadAnim(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        repeat Wait(0) until HasAnimDictLoaded(dict)
    end
end


local function PlayKeyAnim(ped)
    local player <const> = ped
    local coords <const> = GetEntityCoords(player)
    local model <const> = 'p_key02x'
    local dict <const> = 'script_common@jail_cell@unlock@key'

    loadModel(model)
    loadAnim(dict)

    local prop <const> = CreateObject(joaat(model), coords.x, coords.y, coords.z + 0.2, false, false, false, false, false)
    repeat Wait(0) until DoesEntityExist(prop)

    SetModelAsNoLongerNeeded(model)
    SetEntityVisible(prop, false)
    TaskPlayAnim(player, dict, 'action', 8.0, -8.0, 2500, 8, 0, true, false, false)
    Wait(750)
    SetEntityVisible(prop, true)
    AttachEntityToEntity(prop, player, GetEntityBoneIndexByName(player, "SKEL_R_Finger12"), 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true, false, false)
    Wait(1750)
    SetEntityAsNoLongerNeeded(prop)
    DeleteEntity(prop)
    RemoveAnimDict(dict)
end


local function registerPrompt()
    OpenDoors = UiPromptRegisterBegin()
    UiPromptSetControlAction(OpenDoors, `INPUT_INTERACT_LOCKON_ANIMAL`) -- G by default
    local str = VarString(10, 'LITERAL_STRING', CONFIG.lang.PromptText)
    UiPromptSetText(OpenDoors, str)
    UiPromptSetEnabled(OpenDoors, true)
    UiPromptSetVisible(OpenDoors, true)
    UiPromptSetStandardMode(OpenDoors, true)
    UiPromptSetGroup(OpenDoors, PromptGroup1, 0)
    UiPromptRegisterEnd(OpenDoors)
end

local function addDoorsToSystem()
    for door, value in pairs(CONFIG.Doors) do
        if not IsDoorRegisteredWithSystem(door) then
            AddDoorToSystemNew(door, true, true, false, 0, 0, false)
        end
        DoorSystemSetDoorState(door, value.DoorState)
        SetDoorNetworked(door)
    end
end


local function startLockPickAnim()
    local player <const> = CACHE.Ped
    loadAnim('script_proc@rustling@unapproved@gate_lockpick')
    TaskPlayAnim(player, 'script_proc@rustling@unapproved@gate_lockpick', 'enter', 1.0, -1.0, 3500, 1, 0, true, 0, false, "", false)
    Wait(3500)
    loadAnim('script_ca@carust@02@ig@ig1_rustlerslockpickingconv01')
    TaskPlayAnim(player, 'script_ca@carust@02@ig@ig1_rustlerslockpickingconv01', 'idle_01_smhthug_01', 1.0, -1.0, -1, 1, 0, true, 0, false, "", false)
end

local function getDoorForLockPick(item)
    for door, value in pairs(CONFIG.Doors) do
        if value.BreakAble and value.BreakAble == item then
            local distance <const> = #(GetEntityCoords(CACHE.Ped) - value.Pos)
            if distance < 2.0 then
                return true, door
            end
        end
    end
    return false
end

local function leaveLockpick()
    Wait(1000)
    TaskPlayAnim(CACHE.Ped, 'script_proc@rustling@unapproved@gate_lockpick', 'exit', 1.0, -1.0, 2500, 1, 0, true, 0, false, "", false)
    Wait(2500)
    RemoveAnimDict('script_ca@carust@02@ig@ig1_rustlerslockpickingconv01')
    RemoveAnimDict('script_proc@rustling@unapproved@gate_lockpick')
end

Core.Callback.Register("vorp_doorlocks:Client:lockpickdoor", function(cb, item)
    local isLockpick <const>, door <const> = getDoorForLockPick(item)
    if not isLockpick then
        Core.NotifyObjective(CONFIG.lang.Notneardoor, 2000)
        return cb(false)
    end

    local value <const> = CONFIG.Doors[door]
    if value.DoorState == 0 then
        Core.NotifyObjective(CONFIG.lang.Alreadyopen, 5000)
        return cb(false)
    end

    startLockPickAnim()

    local result <const> = exports.lockpick:startLockpick(value.Difficulty)
    if result then
        if value.Alert then
            if math.random() < CONFIG.AlertProbability then
                TriggerServerEvent("vorp_doorlocks:Server:AlertPolice", door)
            end
        end
        TriggerServerEvent("vorp_doorlocks:Server:UpdateDoorState", door)
        CreateThread(leaveLockpick)
        Wait(1000) -- give time to update door state
        return cb(false)
    else
        CreateThread(leaveLockpick)
        return cb(true)
    end
end)

local function ThreadHandler()
    while true do
        local sleep = 1000
        for door, v in pairs(CONFIG.Doors) do
            if v.isAllowed then
                local distance <const> = #(GetEntityCoords(CACHE.Ped) - v.Pos)
                if distance < CONFIG.InteractionDistance then
                    repeat
                        Wait(0)
                        local label <const> = VarString(10, 'LITERAL_STRING', v.Name .. " " .. (v.DoorState == 0 and CONFIG.lang.Opened or CONFIG.lang.Closed))
                        UiPromptSetActiveGroupThisFrame(PromptGroup1, label, 0, 0, 0, 0)

                        local str = VarString(10, 'LITERAL_STRING', (v.DoorState == 1 and CONFIG.lang.Open or CONFIG.lang.Close))
                        UiPromptSetText(OpenDoors, str)

                        if UiPromptIsJustPressed(OpenDoors) then
                            local state <const> = v.DoorState == 0 and 1 or 0
                            local result = Core.Callback.TriggerAwait("vorp_doorlocks:Server:CheckDoorState", door, state)
                            if result then
                                local ped = CACHE.Ped
                                HidePedWeapons(ped, 2, true)
                                PlayKeyAnim(ped)
                                ClearPedTasksImmediately(ped)
                                v.DoorState = state
                            end
                        end
                    until #(GetEntityCoords(CACHE.Ped) - v.Pos) > CONFIG.InteractionDistance
                end
            end
        end

        Wait(sleep)
    end
end

local function manageDoorState()
    for _, value in pairs(CONFIG.Doors) do
        local isAllowed = false

        if value.UniquePermissions then
            local charid <const> = LocalPlayer.state.Character.CharId
            if value.UniquePermissions[charid] then
                isAllowed = true
            end
        end

        if value.Permissions and not isAllowed then
            local job <const> = LocalPlayer.state.Character.Job
            local grade <const> = LocalPlayer.state.Character.Grade
            if (value.Permissions[job] and value.Permissions[job] <= grade) then
                isAllowed = true
            end
        end

        if (not value.Permissions and not value.UniquePermissions) or
            (value.Permissions and not next(value.Permissions)) and
            (value.UniquePermissions and not next(value.UniquePermissions)) then
            isAllowed = true
        end

        value.isAllowed = isAllowed
    end
end

RegisterNetEvent("vorp_doorlocks:Client:UpdatePerms", function(perms)
    if not LocalPlayer.state.IsInSession then return end

    if perms and CONFIG.Doors[perms.door] then
        CONFIG.Doors[perms.door].isAllowed = perms.allowed
        return
    end

    Wait(1000)
    manageDoorState()
end)

RegisterNetEvent("vorp_doorlocks:Client:UpdateDoorState", function(door, state, doubleDoor)
    if doubleDoor and CONFIG.Doors[doubleDoor] then
        CONFIG.Doors[doubleDoor].DoorState = state
        if state == 1 then
            DoorSystemForceShut(doubleDoor, true)
            DoorSystemSetOpenRatio(doubleDoor, 0.0, true)
        end
        DoorSystemSetDoorState(doubleDoor, state)
    end
    CONFIG.Doors[door].DoorState = state
    if state == 1 then
        DoorSystemForceShut(door, true)
        DoorSystemSetOpenRatio(door, 0.0, true)
    end
    DoorSystemSetDoorState(door, state)
end)

RegisterNetEvent("vorp_doorlocks:Client:Sync", function(data)
    local doors <const> = msgpack.unpack(data)
    for door, state in pairs(doors) do
        CONFIG.Doors[door].DoorState = state
        if state == 1 then
            DoorSystemForceShut(door, true)
            DoorSystemSetOpenRatio(door, 0.0, true)
        end
        DoorSystemSetDoorState(door, state)
    end

    repeat Wait(2000) until LocalPlayer.state.Character

    manageDoorState()
    registerPrompt()
    addDoorsToSystem()
    CreateThread(ThreadHandler)
end)

AddEventHandler("onClientResourceStart", function(resource)
    if GetCurrentResourceName() ~= resource then return end
    if not CONFIG.DevMode then return end

    repeat Wait(2000) until LocalPlayer.state.IsInSession
    manageDoorState()
    registerPrompt()
    addDoorsToSystem()
    CreateThread(ThreadHandler)
end)

-- get door id by distance
exports('getDoorIdByDistance', function(dist)
    for door, value in pairs(CONFIG.Doors) do
        local distance <const> = #(GetEntityCoords(CACHE.Ped) - value.Pos)
        if distance < (dist or 1.5) then
            return door
        end
    end
end)

--get door id by exact coords?
exports('getDoorIdByDoorCoords', function(x, y, z)
    for door, value in pairs(CONFIG.Doors) do
        if value.Pos.x == x and value.Pos.y == y and value.Pos.z == z then
            return door
        end
    end
end)

-- get doorid by name you can use unique names for doors this is useful instead of getting by distance
exports('getDoorIdByName', function(name)
    for door, value in pairs(CONFIG.Doors) do
        local match = value.Name:match(name)
        if match then
            return door
        end
    end
end)

exports('getDoorState', function(door)
    if not CONFIG.Doors[door] then return end
    return CONFIG.Doors[door].DoorState
end)

-- will still check for permissions
exports('setDoorState', function(door, state)
    if not CONFIG.Doors[door] then return print("no door exists with this id", door) end

    if CONFIG.Doors[door].DoorState == state then return print("door already is on this state", state) end

    local result = Core.Callback.TriggerAwait("vorp_doorlocks:Server:CheckDoorState", door, state)
    return result
end)

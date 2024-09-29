Config = {}

Config.DevMode = false        -- set to false on live servers

Config.AlertProbability = 0.5 -- 0.5 = 50% chance of alerting police if Config.Doors.Alert is true

Config.Permissions = {
    location = { -- name must match config.Doors.Perms
        ValSheriff = true,
        -- can add as many jobs as you wish
    },
    -- add more here to make unique door permissions
}

Config.Lockpicks = {
    location = {
        "lockpick" --ITEMS HERE CANNOT BE NAMED THE SAME YOU MUST MAKE THEM UNIQUE
    },
    -- add more here to make unique door lockpicks
}

Config.Doors = {
    --VALENTINE SHERIFF DOORS
    -- doors id
    [1988748538] = {
        Pos = vector3(-276.01260375977, 802.59106445313, 118.41165161133), -- door position
        Name = "Front Door",                                               -- door name
        DoorState = 0,                                                     -- default door state 0 is open 1 is close
        Permissions = Config.Permissions.location,                         -- will use the jobs for this location if false everyone can open and close doors
        BreakAble = Config.Lockpicks.location,                             -- will use the lockpick item for this location, if false it will not use lockpick and cant be lockpicked
        Difficulty = 3,                                                    -- lockpick difficulty, how many tries
        Alert = true,
    },
    [395506985]  = {
        Pos = vector3(-275.84475708008, 812.02703857422, 118.41483306885),
        Name = "Back Door",
        DoorState = 0,
        Permissions = Config.Permissions.location,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    --Cells
    [1508776842] = {
        Pos = vector3(-270.76641845703, 810.02648925781, 118.39580535889),
        Name = "Back Jail Door",
        DoorState = 1,
        Permissions = Config.Permissions.location,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [193903155]  = {
        Pos = vector3(-272.05209350586, 808.25830078125, 118.36851501465),
        Name = "Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.location,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [295355979]  = {
        Pos = vector3(-273.46432495117, 809.96606445313, 118.36823272705),
        Name = "Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.location,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [535323366]  = {
        Pos = vector3(-275.02328491211, 808.27404785156, 118.36856842041),
        Name = "Door 3",
        DoorState = 1,
        Permissions = Config.Permissions.location,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    --ADD MORE DOORS HERE
}

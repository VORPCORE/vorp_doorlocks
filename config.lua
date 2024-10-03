Config = {}

Config.DevMode = false        -- Set to false on live servers

Config.AlertProbability = 0.5 -- 0.5 = 50% chance of alerting police if Config.Doors.Alert is true

Config.Permissions = {

	---- Sheriff / Police / Doctor(Medic) Office Doors Permission ----
    ValSheriff = { -- Name must match config.Doors.Perms
        ValSheriff = true,
        -- Can add as many jobs as you wish
    },
    ValMedic = {
        ValMedic = true,
        ValDoctor = true,
    },
    BWPolice = {
        BWPolice = true,
    },
    RhoSheriff = {
        RhoSheriff = true,
    },
    SDPolice = {
        SDPolice = true,
    },
    StrSheriff = {
        StrSheriff = true,
    },
    ArmSheriff = {
        ArmSheriff = true,
    },
	
	---- Bank Doors Permission ----
    ValBank = {
        ValBank = true,
		ValSheriff = true,
		BWPolice = true,
		RhoSheriff = true,
		SDPolice = true,
		StrSheriff = true,
		ArmSheriff = true,
    },
    BWBank = {
        BWBank = true,
		ValSheriff = true,
		BWPolice = true,
		RhoSheriff = true,
		SDPolice = true,
		StrSheriff = true,
		ArmSheriff = true,
    },
    SDBank = {
        SDBank = true,
		ValSheriff = true,
		BWPolice = true,
		RhoSheriff = true,
		SDPolice = true,
		StrSheriff = true,
		ArmSheriff = true,
    },
    RhoBank = {
        RhoBank = true,
		ValSheriff = true,
		BWPolice = true,
		RhoSheriff = true,
		SDPolice = true,
		StrSheriff = true,
		ArmSheriff = true,
    },
	
    -- Add more here to make unique door permissions
}

Config.Lockpicks = {
    location = {
        "lockpick" -- ITEMS HERE CANNOT BE NAMED THE SAME YOU MUST MAKE THEM UNIQUE
    },
    -- Add more here to make unique door lockpicks
}

Config.Doors = {
    -- Valentine Sheriff Doors
    -- Doors ID
    [1988748538] = {
        Pos = vector3(-276.01260375977, 802.59106445313, 118.41165161133), -- Door Position
        Name = "Front Door",                                               -- Door Name
        DoorState = 0,                                                     -- Default door State 0 is open 1 is close
        Permissions = Config.Permissions.ValSheriff,                       -- Will use the jobs for this location if false everyone can open and close doors
        BreakAble = Config.Lockpicks.location,                             -- Will use the lockpick item for this location, if false it will not use lockpick and cant be lockpicked
        Difficulty = 3,                                                    -- Lockpick Difficulty, how many tries
        Alert = true,
    },
    [395506985]  = {
        Pos = vector3(-275.84475708008, 812.02703857422, 118.41483306885),
        Name = "Back Door",
        DoorState = 0,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [1508776842] = {
        Pos = vector3(-270.76641845703, 810.02648925781, 118.39580535889),
        Name = "Back Jail Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [193903155]  = {
        Pos = vector3(-272.05209350586, 808.25830078125, 118.36851501465),
        Name = "Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [295355979]  = {
        Pos = vector3(-273.46432495117, 809.96606445313, 118.36823272705),
        Name = "Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [535323366]  = {
        Pos = vector3(-275.02328491211, 808.27404785156, 118.36856842041),
        Name = "Door 3",
        DoorState = 1,
        Permissions = Config.Permissions.ValSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Valentine Doctor/Medic Doors
    -- Doors ID
    [3588026089]  = {
        Pos = vector3(-282.8079528808594, 803.954833984375, 118.39317321777344),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValMedic,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [4067537969]  = {
        Pos = vector3(-286.6419982910156, 809.7845458984375, 118.42121887207031),
        Name = "Front Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ValMedic,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [925575409]  = {
        Pos = vector3(-290.8585510253906, 813.3575439453125, 118.41549682617188),
        Name = "Iron Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.ValMedic,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3439738919]  = {
        Pos = vector3(-281.0743408203125, 815.23779296875, 118.41590118408203),
        Name = "Iron Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ValMedic,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Blackwater Police Doors
    -- Doors ID
    [3821185084]  = {
        Pos = vector3(-757.0423583984375, -1269.92333984375, 43.06862640380859),
        Name = "Front Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3410720590]  = {
        Pos = vector3(-757.0423583984375, -1268.4853515625, 43.06859970092773),
        Name = "Front Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2810801921]  = {
        Pos = vector3(-769.1376342773438, -1268.745361328125, 43.04003143310547),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [2514996158]  = {
        Pos = vector3(-765.8612060546875, -1264.703857421875, 43.02326965332031),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2167775834]  = {
        Pos = vector3(-763.5278930664062, -1262.4609375, 43.02326583862305),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.BWPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Rhodes Sheriff Doors
    -- Doors ID
    [349074475]  = {
        Pos = vector3(1359.7095947265625, -1305.9598388671875, 76.76844787597656),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1614494720]  = {
        Pos = vector3(1359.0985107421875, -1297.53466796875, 76.7876205444336),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- Cell
    [1878514758]  = {
        Pos = vector3(1357.333740234375, -1302.453857421875, 76.76018524169922),
        Name = "Cell Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Saint Denis Police Doors
    -- Doors ID
    [1674105116]  = {
        Pos = vector3(2493.37255859375, -1305.68701171875, 47.95257186889648),
        Name = "Front Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1979938193]  = {
        Pos = vector3(2493.37255859375, -1307.41845703125, 47.95257186889648),
        Name = "Front Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1694749582]  = {
        Pos = vector3(2493.37255859375, -1310.2252197265625, 47.95257186889648),
        Name = "Front Door 3 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1992193795]  = {
        Pos = vector3(2493.37255859375, -1311.95654296875, 47.95257186889648),
        Name = "Front Door 4 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2503834054]  = {
        Pos = vector3(2495.953369140625, -1317.28271484375, 47.95257186889648),
        Name = "Front Door 5 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [305296302]  = {
        Pos = vector3(2497.684814453125, -1317.28271484375, 47.95257186889648),
        Name = "Front Door 6 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [603068205]  = {
        Pos = vector3(2506.606201171875, -1317.2796630859375, 47.95257186889648),
        Name = "Front Door 7 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1020479727]  = {
        Pos = vector3(2508.337646484375, -1317.2796630859375, 47.95257186889648),
        Name = "Front Door 8 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [417663242]  = {
        Pos = vector3(2516.144287109375, -1309.9276123046875, 47.95257186889648),
        Name = "Back Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1611175760]  = {
        Pos = vector3(2516.14453125, -1307.724853515625, 47.95257186889648),
        Name = "Back Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    --[[ -- You can open them if you want to deal with a bit more doors (more security) at entrances and exits
    [1879655431]  = {
        Pos = vector3(2510.90771484375, -1305.41162109375, 47.95716857910156),
        Name = "In Door 1 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3124713594]  = {
        Pos = vector3(2510.90771484375, -1307.141357421875, 47.95716857910156),
        Name = "In Door 2 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3430284519]  = {
        Pos = vector3(2510.90771484375, -1310.4840087890625, 47.95257186889648),
        Name = "In Door 3 (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3601535313]  = {
        Pos = vector3(2510.90771484375, -1312.2154541015625, 47.95257186889648),
        Name = "In Door 4 (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    --]]

    -- Cells
    [2515591150]  = {
        Pos = vector3(2503.638671875, -1309.8763427734375, 47.95327377319336),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1995743734]  = {
        Pos = vector3(2499.752197265625, -1309.8763427734375, 47.95327377319336),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3365520707]  = {
        Pos = vector3(2498.5, -1307.85595703125, 47.95327377319336),
        Name = "Cell Door 3",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1711767580]  = {
        Pos = vector3(2502.427734375, -1307.85498046875, 47.95326995849609),
        Name = "Cell Door 4",
        DoorState = 1,
        Permissions = Config.Permissions.SDPolice,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Strawberry Sheriff Doors
    -- Doors ID
    [1821044729]  = {
        Pos = vector3(-1806.6751708984375, -350.31280517578125, 163.64759826660156),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1514359658]  = {
        Pos = vector3(-1812.669189453125, -345.08489990234375, 163.64759826660156),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [1207903970]  = {
        Pos = vector3(-1812.0101318359375, -351.92095947265625, 160.46839904785156),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [902070893]  = {
        Pos = vector3(-1814.400390625, -353.1470947265625, 160.44180297851562),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.StrSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

    -- Armadillo Sheriff Doors
    -- Doors ID
    [66424668]  = {
        Pos = vector3(-3624.6982421875, -2605.415771484375, -14.35151767730712),
        Name = "Front Door",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- Cells
    [4016307508]  = {
        Pos = vector3(-3620.9931640625, -2600.2490234375, -14.35159301757812),
        Name = "Cell Door 1",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [4235597664]  = {
        Pos = vector3(-3619.148193359375,-2604.20654296875,-14.35159301757812),
        Name = "Cell Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.ArmSheriff,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
	
	-- Valentine Bank Doors
	-- Doors ID
    [2642457609]  = {
        Pos = vector3(-309.05206298828125, 779.7301025390625, 117.72991180419922),
        Name = "Front Door 1 (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3886827663]  = {
        Pos = vector3(-306.8853454589844, 780.1154174804688, 117.72991180419922),
        Name = "Front Door 2 (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1340831050]  = {
        Pos = vector3(-311.7406311035156, 774.6756591796875, 117.72991180419922),
        Name = "Gate to Tellers",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3718620420]  = {
        Pos = vector3(-311.0597839355469, 770.1240234375, 117.70217895507812),
        Name = "Door Behind Tellers",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [576950805]  = {
        Pos = vector3(-307.7537536621094, 766.3489990234375, 117.70159149169922),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2343746133]  = {
        Pos = vector3(-301.9361877441406, 771.751953125, 117.72990417480469),
        Name = "Door to Backrooms",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2307914732]  = {
        Pos = vector3(-301.510009765625, 762.9834594726562, 117.77313232421875),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [334467483]  = {
        Pos = vector3(-302.9228210449219, 767.6043090820312, 117.69805145263672),
        Name = "Door to Hall in Vault Antechamber",
        DoorState = 1,
        Permissions = Config.Permissions.ValBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
	
	-- Blackwater Bank Doors
	-- Doors ID
    [531022111]  = {
        Pos = vector3(-809.141845703125, -1279.1900634765625, 42.6614990234375),
        Name = "Front Door",
        DoorState = 0,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2817192481]  = {
        Pos = vector3(-817.8110961914062, -1277.66845703125, 42.65194320678711),
        Name = "Office Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2117902999]  = {
        Pos = vector3(-816.7252807617188, -1276.7509765625, 42.6412353515625),
        Name = "Teller Gate",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1462330364]  = {
        Pos = vector3(-817.7865600585938, -1274.38525390625, 42.66213226318359),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.BWBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },

	-- Saint Denis Bank Doors
	-- Doors ID
    [2158285782]  = {
        Pos = vector3(2637.7978515625, -1298.036376953125, 51.24600982666015),
        Name = "West Entrance (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1733501235]  = {
        Pos = vector3(2638.72216796875, -1300.0184326171875, 51.24600982666015),
        Name = "West Entrance (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [965922748]  = {
        Pos = vector3(2648.98046875, -1300.0491943359375, 51.24539184570312),
        Name = "Manager's Office (Left)",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1634115439]  = {
        Pos = vector3(2646.980224609375, -1300.983154296875, 51.24538421630859),
        Name = "Manager's Office (Right)",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2817024187]  = {
        Pos = vector3(2642.15673828125, -1285.4188232421875, 51.24600982666015),
        Name = "North Entrance (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2089945615]  = {
        Pos = vector3(2640.175537109375, -1286.342529296875, 51.24600982666015),
        Name = "North Entrance (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1751238140]  = {
        Pos = vector3(2643.300537109375, -1300.4267578125, 51.25582504272461),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.SDBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
	
	-- Rhodes Bank Doors
	-- Doors ID
    [3317756151]  = {
        Pos = vector3(1296.27197265625, -1299.0120849609375, 76.03963470458984),
        Name = "Front Door 1 (Left)",
        DoorState = 0,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3088209306]  = {
        Pos = vector3(1294.595703125, -1297.583740234375, 76.03963470458984),
        Name = "Front Door 2 (Right)",
        DoorState = 0,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2058564250]  = {
        Pos = vector3(1285.1475830078125, -1303.1185302734375, 76.04006958007812),
        Name = "Door to Backrooms",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [1634148892]  = {
        Pos = vector3(1295.734130859375, -1305.474853515625, 76.03300476074219),
        Name = "Teller Gate",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3483244267]  = {
        Pos = vector3(1282.536376953125, -1309.31591796875, 76.03642272949219),
        Name = "Vault Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [3142122679]  = {
        Pos = vector3(1278.85595703125, -1310.403076171875, 76.03964233398438),
        Name = "Back Door",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    [2513778780]  = {
        Pos = vector3(1279.4113769531,-1311.4263916016,76.03205871582),
        Name = "Back Door 2",
        DoorState = 1,
        Permissions = Config.Permissions.RhoBank,
        BreakAble = Config.Lockpicks.location,
        Difficulty = 3,
        Alert = true,
    },
    -- ADD MORE DOORS HERE
}

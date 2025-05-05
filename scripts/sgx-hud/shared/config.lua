Config = {}

-- // Hud Options // --
Config.Settings = 'hud'
Config.HudRestart = 'restarthud'

-- // Compass Options // --
Config.ShowCompass = {}
Config.FollowCam = true 

-- // Speedometer Options // --
Config.SpeedType = true -- true for MPH, false for KPH

-- // Manual Gear Options // --
Config.ManualGearbox = {'club'} -- Add name of the car here like this {'club', 'carsnamehere'}
Config.EngineStall = true -- Engine stalls if you start driving using wrong gear!
Config.enginebrake = true -- Vehicle breakes if you downshift into wrong gears
Config.gears = {
    [1] = {0.90},--1
    [2] = {3.33, 0.90},--2
    [3] = {3.33, 1.57, 0.90},--3
    [4] = {3.33, 1.83, 1.22, 0.90},--4
    [5] = {3.33, 1.92, 1.36, 1.05, 0.90},--5
    [6] = {3.33, 1.95, 1.39, 1.09, 0.95, 0.90},--6
    [7] = {4.00, 2.34, 1.67, 1.31, 1.14, 1.08, 0.90},--7
    [8] = {5.31, 3.11, 2.22, 1.74, 1.51, 1.43, 1.20, 0.90},--8
    [9] = {7.70, 4.51, 3.22, 2.52, 2.20, 2.08, 1.73, 1.31, 0.90}--9
}

Config.vehicles = {
    [GetHashKey('omnis')] = { 
        [5] = {3.885, 2.312, 1.51848, 1.0688, 0.90},
        [6] = {3.33,2.5, 2.0, 1.633, 1.089, 0.90},
    },
    -- [GetHashKey('car')] = { 
    --     [7] = {4.00, 2.34, 1.67, 1.31, 1.14, 1.08, 0.90},
    --     [8] = {5.31, 3.11, 2.22, 1.74, 1.51, 1.43, 1.20, 0.90},
    -- },
    -- [GetHashKey('car')] = {
    --     [5] = {3.33, 1.92, 1.36, 1.05, 0.90},
    --     [6] = {3.33, 1.95, 1.39, 1.09, 0.95, 0.90},
    -- },
    -- [GetHashKey('car')] = {
    --     [6] = {4.585, 2.72, 1.81, 1.333, 1.084, 0.90},
    --     [7] = {4.00, 2.34, 1.67, 1.31, 1.14, 1.08, 0.90},
    -- },
    -- [GetHashKey('car')] = {
    --     [7] = {4.205, 2.523364, 1.892523, 1.4509, 1.17757, 0.988, 0.90},
    --     [8] = {5.31, 3.11, 2.22, 1.74, 1.51, 1.43, 1.20, 0.90},
    -- },
    -- [GetHashKey('car')] = {
    --     [8] = {6.36, 4.24, 2.8416, 2.249, 1.733, 1.349, 1.132, 0.90},
    --     [9] = {7.70, 4.51, 3.22, 2.52, 2.20, 2.08, 1.73, 1.31, 0.90}
    -- },    
}

Config.animationDuration = 100 -- Time interval for the animation (Preferred to be at 1000) (Don't change unless you don't know what you're doing)
Config.CommandName = "togglegear" -- Command name to toggle gear animations

Config.BlacklistCars = { -- Blacklist a specific vehicle
    -- "blista",
    -- "fmj"
}

Config.RHDCars = { -- For Right Hand Drive Vehicles
   -- "fk8",
   -- "fd2"
}
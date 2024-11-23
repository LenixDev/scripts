Venom = {}

Venom.CoreName = 'qb-core'
Venom.CoreTriggerName = 'QBCore'
Venom.MenuName = 'qb-menu'
Venom.InputName = 'qb-input'
Venom.TargetName = 'qb-target'
Venom.LogsTrigger = 'qb-logs'
Venom.Doorlockevent = 'qb-doorlock:server:updateState'
Venom.RoomRentCost = 250
Venom.DailyRentTimer = 60 * (60 * 1000) -- 1 Hour
Venom.DailyRental = 10 -- 504 / 24 = 21/h$
Venom.Maxweight = 700000
Venom.MaxSlots = 50

Venom.Reception = {coords = vector3(-661.61, -1101.96, 15.06), ped = 'a_m_y_business_02', heading = 156.08}

Venom.Bliplabel = "Appartment"
Venom.Blipscale = 0.7
Venom.Blipsprite = 476
Venom.Blipcolour = 66
Venom.Blipdisplay = 4


Venom.Rooms = {
    [101] = {
        Door = {
            Id = 'appartment-101',
            isClosed = true,
            Coords = vec3(-660.090027, -1101.336914, 22.037678)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-661.16, -1098.57, 22.51),
            heading = 240,
            minZ=21.06,
            maxZ=23.46,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [102] = {
        Door = {
            Id = 'appartment-102',
            isClosed = true,
            Coords = vec3(-655.082703, -1099.652222, 22.038019)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-653.9, -1102.29, 21.82),
            heading = 240,
            minZ=21.06,
            maxZ=23.46,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [103] = {
        Door = {
            Id = 'appartment-103',
            isClosed = true,
            Coords = vec3(-655.431091, -1091.400757, 22.037086)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.15, -1088.81, 21.82),
            heading = 58,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [104] = {
        Door = {
            Id = 'appartment-104',
            isClosed = true,
            Coords = vec3(-650.423828, -1089.716064, 22.037428)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.48, -1092.37, 21.81),
            heading = 60,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [105] = {
        Door = {
            Id = 'appartment-105',
            isClosed = true,
            Coords = vec3(-645.759766, -1079.768799, 22.036835)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.73, -1082.47, 21.78),
            heading = 327,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [201] = {
        Door = {
            Id = 'appartment-201',
            isClosed = true,
            Coords = vec3(-660.088989, -1101.336914, 26.806276)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-661.17, -1098.93, 26.6),
            heading = 330,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [202] = {
        Door = {
            Id = 'appartment-202',
            isClosed = true,
            Coords = vec3(-655.081665, -1099.652222, 26.806618)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-653.99, -1102.26, 26.47),
            heading = 327,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [203] = {
        Door = {
            Id = 'appartment-203',
            isClosed = true,
            Coords = vec3(-655.430054, -1091.400757, 26.805685)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.38, -1088.81, 26.42),
            heading = 58,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [204] = {
        Door = {
            Id = 'appartment-204',
            isClosed = true,
            Coords = vec3(-650.422791, -1089.716064, 26.806026)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.51, -1092.15, 26.48),
            heading = 60,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [205] = {
        Door = {
            Id = 'appartment-205',
            isClosed = true,
            Coords = vec3(-645.758728, -1079.768799, 26.805433)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.77, -1082.34, 26.57),
            heading = 58,
            minZ=25.68,
            maxZ=28.28,
            width = 1,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [301] = {
        Door = {
            Id = 'appartment-301',
            isClosed = true,
            Coords = vec3(-660.088989, -1101.336914, 31.575277)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-661.02, -1098.81, 31.49),
            heading = 328,
            minZ=30.65,
            maxZ=33.05,
            width = 1.2,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [302] = {
        Door = {
            Id = 'appartment-302',
            isClosed = true,
            Coords = vec3(-655.081665, -1099.652222, 31.575619)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-653.89, -1102.19, 31.49),
            heading = 330,
            minZ=30.65,
            maxZ=33.05,
            width = 1.2,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [303] = {
        Door = {
            Id = 'appartment-303',
            isClosed = true,
            Coords = vec3(-655.430054, -1091.400757, 31.574686)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.48, -1088.83, 31.49),
            heading = 328,
            minZ=30.65,
            maxZ=33.05,
            width = 1.2,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [304] = {
        Door = {
            Id = 'appartment-304',
            isClosed = true,
            Coords = vec3(-650.422791, -1089.716064, 31.575027)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.25, -1092.12, 31.49),
            heading = 328,
            minZ=30.65,
            maxZ=33.05,
            width = 1.2,
            hight = 2,
        },
        isOwned = false,
        Owner = nil,
    },
    [305] = {
        Door = {
            Id = 'appartment-305',
            isClosed = true,
            Coords = vec3(-645.758728, -1079.768799, 31.574434)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.68, -1082.17, 31.49),
            heading = 328,
            minZ=30.65,
            maxZ=33.05,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [401] = {
        Door = {
            Id = 'appartment-401',
            isClosed = true,
            Coords = vec3(-660.088989, -1101.336914, 36.344376)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-661.32, -1098.97, 36.08),
            heading = 328,
            minZ=35.02,
            maxZ=37.82,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [402] = {
        Door = {
            Id = 'appartment-402',
            isClosed = true,
            Coords = vec3(-655.081665, -1099.652222, 36.344719)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-653.91, -1102.09, 36.08),
            heading = 328,
            minZ=35.02,
            maxZ=37.82,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [403] = {
        Door = {
            Id = 'appartment-403',
            isClosed = true,
            Coords = vec3(-655.430054, -1091.400757, 36.343784)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.53, -1088.99, 36.08),
            heading = 328,
            minZ=35.02,
            maxZ=37.82,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [404] = {
        Door = {
            Id = 'appartment-404',
            isClosed = true,
            Coords = vec3(-650.422791, -1089.716064, 36.344128)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.46, -1092.28, 36.08),
            heading = 328,
            minZ=35.02,
            maxZ=37.82,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [405] = {
        Door = {
            Id = 'appartment-405',
            isClosed = true,
            Coords = vec3(-645.758728, -1079.768799, 36.343536)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.61, -1082.43, 36.08),
            heading = 328,
            minZ=35.02,
            maxZ=37.82,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },

    [501] = {
       Door = {
          Id = 'appartment-501',
        isClosed = true,
        Coords = vec3(-660.088989, -1101.336914, 41.113377)
      },
    locker = {
        maxweight = 0,
        slots = 0,
        coords = vector3(-661.22, -1098.64, 40.99),
        heading = 328,
        minZ=40.09,
        maxZ=42.54,
        width = 1.2,
        hight = 2.2,
    },
    isOwned = false,
    Owner = nil,
    },
    [502] = {
        Door = {
            Id = 'appartment-502',
            isClosed = true,
            Coords = vec3(-655.081665, -1099.652222, 41.113720)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-654.03, -1102.35, 40.98),
            heading = 328,
        minZ=40.09,
        maxZ=42.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [503] = {
        Door = {
            Id = 'appartment-503',
            isClosed = true,
            Coords = vec3(-655.430054, -1091.400757, 41.112785)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.61, -1088.67, 40.93),
            heading = 328,
        minZ=40.09,
        maxZ=42.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [504] = {
        Door = {
            Id = 'appartment-504',
            isClosed = true,
            Coords = vec3(-650.422791, -1089.716064, 41.113129)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.27, -1092.48, 40.98),
            heading = 328,
        minZ=40.09,
        maxZ=42.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [505] = {
        Door = {
            Id = 'appartment-505',
            isClosed = true,
            Coords = vec3(-645.758728, -1079.768799, 41.112537)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.72, -1082.41, 40.96),
            heading = 328,
        minZ=40.09,
        maxZ=42.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },

    [601] = {
       Door = {
          Id = 'appartment-601',
        isClosed = true,
        Coords = vec3(-660.088989, -1101.336914, 45.881874)
      },
    locker = {
        maxweight = 0,
        slots = 0,
        coords = vector3(-661.13, -1098.67, 45.87),
        heading = 328,
        minZ=45.09,
        maxZ=47.54,
        width = 1.2,
        hight = 2.2,
    },
    isOwned = false,
    Owner = nil,
    },
    [602] = {
        Door = {
            Id = 'appartment-602',
            isClosed = true,
            Coords = vec3(-655.081665, -1099.652222, 45.882217)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-653.82, -1102.24, 45.91),
            heading = 328,
            minZ=45.09,
            maxZ=47.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [603] = {
        Door = {
            Id = 'appartment-603',
            isClosed = true,
            Coords = vec3(-655.430054, -1091.400757, 45.881283)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-656.55, -1088.77, 45.82),
            heading = 328,
            minZ=45.09,
            maxZ=47.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [604] = {
        Door = {
            Id = 'appartment-604',
            isClosed = true,
            Coords = vec3(-650.422791, -1089.716064, 45.881626)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-649.41, -1092.38, 45.87),
            heading = 328,
            minZ=45.09,
            maxZ=47.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
    [605] = {
        Door = {
            Id = 'appartment-605',
            isClosed = true,
            Coords = vec3(-645.758728, -1079.768799, 45.881035)
        },
        locker = {
            maxweight = 0,
            slots = 0,
            coords = vector3(-644.55, -1082.37, 45.87),
            heading = 328,
        minZ=45.09,
        maxZ=47.54,
            width = 1.2,
            hight = 2.2,
        },
        isOwned = false,
        Owner = nil,
    },
}
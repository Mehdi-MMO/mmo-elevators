Config = {}

Config.Circle = {
    levitating = false,
    color = { -- RGBA
        r = 240,
        g = 240,
        b = 240,
        a = 100
    }
}

-- Note: Organizing the elevators is only for the UI presentation, but it does not affect the functionality of the script.
Config.elevators = { 
        -- Del Perro Heights --
    {
        id = "delperroheights",
        floor = 2,
        coords = vector3(-1500, -525.9, 69.55),
        heading = 31.4
    }, 
    {
        id = "delperroheights",
        floor = 1,
        coords = vector3(-1449.95, -525.8, 56.94),
        heading = 34
    }, 
    {
        id = "delperroheights",
        floor = 0,
        coords = vector3(-1447.7, -537.45, 34.75),
        heading = 213.70
    }, 
        -- Alta Sreet --
    {
        id = "delperroheights",
        floor = 3,
        coords = vector3(-1452.1, -540.7, 74.05),
        heading = 30.70
    },
    {
        id = "3altastreet",
        floor = 1,
        coords = vector3(-273.2, -967.3, 77.2),
        heading = 247.30
    },
    {
        id = "3altastreet",
        name = "The Majesty Floor", -- optional
        floor = 2,
        coords = vector3(-269.90, -941, 92.5),
        heading = 64.70
    },  
    {
        id = "3altastreet",
        floor = 0,
        coords = vector3(-268.9, -962.35, 31.2),
        heading = 296.90
    }, 
}

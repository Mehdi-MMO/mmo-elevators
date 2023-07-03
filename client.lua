local menuOpen = false -- Flag to track if the menu is open or closed
local CircleConfig = Config.Circle -- Circle configuration

local function gimmeElev(floor, id)
    local options = {}
    for _, elevator in pairs(Config.elevators) do
        if elevator.id == id and (elevator.floor == floor + 1 or elevator.floor == floor - 1) then
            options[#options + 1] = {
                title = elevator.floor > floor and "UP" or "DOWN", -- Set the title based on the direction
                description = elevator.name or "Level " .. elevator.floor,
                onSelect = function(args)
                    SetEntityCoords(ped, elevator.coords.x, elevator.coords.y, elevator.coords.z - 1.0, false,
                        false, false, false)
                    SetEntityHeading(ped, elevator.heading)
                    SetGameplayCamRelativeHeading(0)
                    menuOpen = false -- Close the menu after selecting an option
                end
            }
        end
    end
    return options
end

CreateThread(function()
    local wait = 500
    while true do
        Wait(wait)
        for _, elevator in pairs(Config.elevators) do
            local dist = #(pedCoords - elevator.coords)
            if dist < 3.5 then
                wait = 0
                DrawMarker(1, elevator.coords.x, elevator.coords.y, elevator.coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.001,
                    1.0001, 0.5001, CircleConfig.color.r, CircleConfig.color.g, CircleConfig.color.b,
                    CircleConfig.color.a, CircleConfig.levitating, 0, 0, 0) -- The actual circle
                if not menuOpen and dist < 1.0 then
                    lib.showTextUI("[E] - Elevator")
                    if IsControlJustPressed(0, 51) then
                        lib.registerContext({
                            id = elevator.id,
                            title = elevator.name or "Elevator Level " .. elevator.floor,
                            onExit = function()
                                menuOpen = false -- Close the menu when exiting the context
                            end,
                            options = gimmeElev(elevator.floor, elevator.id)
                        })
                        menuOpen = true -- Set the menu open flag to true
                        lib.showContext(elevator.id)
                        lib.hideTextUI()
                    end
                elseif dist > 1.0 and menuOpen then
                    menuOpen = false -- Close the menu when moving away from the elevator
                    lib.hideContext(true)
                    lib.hideTextUI()
                end
                break
            else
                wait = 500
            end
        end
    end
end)

CreateThread(function()
    while true do
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)
        Wait(500)
    end
end)

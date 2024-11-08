local menuOpen = false
local CircleConfig = Config.Circle

local function gimmeElev(floor, id)
    local options = {}
    for _, elevator in pairs(Config.elevators) do
        if elevator.id == id and (elevator.floor == floor + 2 or elevator.floor == floor - 1 or elevator.floor == floor + 1 or elevator.floor == floor + 2) then
            options[#options + 1] = {
                title = elevator.floor > floor and "UP" or "DOWN",
                description = elevator.name and elevator.name .. ' (' .. elevator.floor .. ')' or "Level " .. elevator.floor,
                onSelect = function(args)
                    SetEntityCoords(ped, elevator.coords.x, elevator.coords.y, elevator.coords.z - 1.0, false, false, false, false)
                    SetEntityHeading(ped, elevator.heading)
                    SetGameplayCamRelativeHeading(0)
                    menuOpen = false
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
        local playerInRange = false
        for _, elevator in pairs(Config.elevators) do
            local dist = #(pedCoords - elevator.coords)
            if dist < 3.5 then
                wait = 0
                playerInRange = true
                DrawMarker(1, elevator.coords.x, elevator.coords.y, elevator.coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, CircleConfig.color.r, CircleConfig.color.g, CircleConfig.color.b, CircleConfig.color.a, CircleConfig.levitating, 0, 0, 0)

                if not menuOpen and dist < 1.0 then
                    lib.showTextUI("[E] - Elevator")
                    if IsControlJustPressed(0, 51) then
                        lib.registerContext({
                            id = elevator.id,
                            title = elevator.name or "Elevator Level " .. elevator.floor,
                            onExit = function()
                                menuOpen = false
                            end,
                            options = gimmeElev(elevator.floor, elevator.id)
                        })
                        menuOpen = true
                        lib.showContext(elevator.id)
                        lib.hideTextUI()
                    end
                elseif dist > 1.0 and menuOpen then
                    menuOpen = false
                    lib.hideContext(true)
                    lib.hideTextUI()
                end
                break
            else
                wait = 500
            end
        end
        
        if not playerInRange then
            lib.hideTextUI()
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

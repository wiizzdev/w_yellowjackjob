local mainMenu = RageUI.CreateMenu("", "Garage")
local open = false

mainMenu.Closed = function() open = false end

function Garage()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while open do 
		        RageUI.IsVisible(mainMenu, function() 
                    for k,v in pairs(Config.Garage.Vehicle) do
                        RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                if ESX.Game.IsSpawnPointClear(Config.Garage.Spawn.p, 2.0) then
                                    ESX.Game.SpawnVehicle(v.name, Config.Garage.Spawn.p, Config.Garage.Spawn.h, function(vehicle)
                                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                                    end)
                                    RageUI.CloseAll()
                                    open = false
                                else
                                    ESX.ShowNotification("~r~La sortie est bloqué")
                                end
                            end
                        })
                    end
		        end)
		    Wait(0)
		    end
	    end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.Garage.Pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 20.0 then
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, false)
                    if dist <= 0.8 then
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour sortir un "..Config.Color.."Véhicule")
                        if IsControlJustPressed(1,51) then
					        Garage()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.Garage.Delete) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 20.0 then
                    wait = 0
                    DrawMarker(36,  v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, true)
                    if dist <= 3.0 then
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour "..Config.Color.."ranger votre Véhicule")
                        if IsControlJustPressed(1,51) then
                            DeleteEntity(GetVehiclePedIsIn(GetPlayerPed(-1)))                            
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)
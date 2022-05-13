local mainMenu = RageUI.CreateMenu("", "Actions Patron")
local open = false 

mainMenu.Closed = function() open = false end

function Boss()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while open do 
		        RageUI.IsVisible(mainMenu, function()
			        RageUI.Button("Retirer argent société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            local amount = KeyboardInput("Retirer ", nil, 7)
                            amount = tonumber(amount)
                            if amount then
                                TriggerServerEvent('esx_society:withdrawMoney', 'yellowjack', amount)
                            else
                                ESX.ShowNotification("~r~Montant invalide")
                            end
                        end
			        })
			        RageUI.Button("Déposer argent société", nil, {RightLabel = "→"}, true , {
				        onSelected = function()
                            local amount = KeyboardInput("Retirer ", nil, 7)
                            amount = tonumber(amount)
                            if amount then
                                TriggerServerEvent('esx_society:depositMoney', 'yellowjack', amount)
                            else
                                ESX.ShowNotification("~r~Montant invalide")
                            end
				        end
			        })
                    RageUI.Button("Ouvrir le menu société", nil, {RightLabel = "→"}, true, {
                        onSelected = function()   
                            Bossdefault()
                            RageUI.CloseAll()
                            open = false
                        end
                    })
		        end)
		    Wait(0)
		    end
	    end)
    end
end

function Bossdefault()
    TriggerEvent('esx_society:openBossMenu', 'yellowjack', function(data, menu)
        menu.close()
    end, {wash = false})
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.Patron.Pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' and ESX.PlayerData.job.grade_name == 'boss' then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, false)
                    if dist <= 1.0 then
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le "..Config.Color.."Menu Patron")
                        if IsControlJustPressed(1,51) then
					        Boss()
                        end
                    end
                end
            end
        Citizen.Wait(wait)
        end
    end
end)
local mainMenu = RageUI.CreateMenu("", "Fabrication de Boissons")
local open,craftencours,fermerlemenu,chargement = false,false,false,0

mainMenu.Closed = function() open = false end

function Prepararion()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while open do
                if fermerlemenu then mainMenu.Closable = false else mainMenu.Closable = true end
                RageUI.IsVisible(mainMenu, function()
                    if not craftencours then
                        for k,v in pairs(Config.Boissons.List) do
                            RageUI.Button(v.label, nil, {RightLabel = "→"}, true, {
                                onSelected = function()
                                    craftencours = true
                                    label = v.label
                                    name = v.name
                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                    ESX.Streaming.RequestAnimDict("mini@repair", function()
                                        TaskPlayAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 51, 0, false, false, false)
                                        RemoveAnimDict("mini@repair")
                                    end)
                                end
                            })
                        end
                    else
                        RageUI.Separator("Fabrication de "..Config.Color..""..label.. " ~s~en cours...")
                        RageUI.PercentagePanel(chargement, "("..Config.Color..""..math.floor(chargement * 100).."%~s~)", "", "", {})
                        if chargement < 1.0 then
                            chargement = chargement + 0.001
                            fermerlemenu = true
                        else 
                            chargement = 0 
                        end
                        if chargement >= 1.0 then
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            ESX.Streaming.RequestAnimDict("move_m@_idles@shake_off", function()
                                TaskPlayAnim(GetPlayerPed(-1), "move_m@_idles@shake_off", "shakeoff_1", 8.0, -8.0, -1, 51, 0, false, false, false)
                                RemoveAnimDict("move_m@_idles@shake_off")
                            end)
                            TriggerServerEvent('yellowjack:preparer', name)
                            Wait(2000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            chargement = 0
                            craftencours = false
                            fermerlemenu = false
                            RageUI.CloseAll()
                            open = false
                        end
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
    	for k,v in pairs(Config.Boissons.Pos) do
        	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' and ESX.PlayerData.job.grade_name == 'barman' then
            	local coords = GetEntityCoords(GetPlayerPed(-1), false)
            	local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            	if dist <= 2.0 then 
					wait = 0
            		DrawMarker(Config.Markers.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, false)
            		if dist <= 0.8 then 
						wait = 0
						ESX.ShowHelpNotification("~INPUT_TALK~ pour "..Config.Color.."Préparer des Boissons")
                		if IsControlJustPressed(1,51) then
							Prepararion()
           				end
        			end
        		end
    		end
		Citizen.Wait(wait)
		end
	end
end)
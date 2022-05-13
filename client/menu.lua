local mainMenu = RageUI.CreateMenu("", "Yellow Jack")
local annonces = RageUI.CreateSubMenu(mainMenu, "", "Annonces")
local open = false

mainMenu.Closed = function() open = false end

function Menu()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
			while open do
		   		RageUI.IsVisible(mainMenu, function() 
                    RageUI.Button("Annonces", nil, {RightLabel = "→"}, true, {}, annonces)
                    RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            Facture()
                            RageUI.CloseAll()
                            open = false
                        end
                    })
                end)
                RageUI.IsVisible(annonces, function() 
                    RageUI.Button("Annonce d'Ouverture", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        	TriggerServerEvent('yellowjack:ouvert')
                        end
                    })		
					RageUI.Button("Annonce de Fermeture", nil, {RightLabel = "→"}, true , {
    					onSelected = function()
        					TriggerServerEvent('yellowjack:ferme')
    					end
					})
					RageUI.Button("Annonce Personnalisée", nil, {RightLabel = "→"}, true , {
						onSelected = function()
							local notif = KeyboardInput("Contenue de l'Annonce ", nil, 100)
							if notif then
								TriggerServerEvent('yellowjack:perso', notif)
							else
								ESX.ShowNotification("~r~Annonce invalide")
							end
						end
					})
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Blips.Pos) do
		local blip = AddBlipForCoord(v.x, v.y, v.z) 
		SetBlipSprite(blip, Config.Blips.Sprite)
		SetBlipDisplay(blip, 4) 
		SetBlipScale(blip, Config.Blips.Scale)
		SetBlipColour(blip, Config.Blips.Colour)
		SetBlipAsShortRange(blip, true) 
		BeginTextCommandSetBlipName('STRING') 
		AddTextComponentSubstringPlayerName(Config.Blips.Name)
		EndTextCommandSetBlipName(blip) 
	end
end)

function Facture()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {title = "Montant de la facture"},
	    function(data, menu)
		    local amount = tonumber(data.value)
		    local player, distance = ESX.Game.GetClosestPlayer()  
		    if player ~= -1 and distance <= 3.0 then  
		        menu.close()
		        if amount == nil then
			        ESX.ShowNotification("Montant Invalide")
		        else
			        local playerPed = GetPlayerPed(-1)
			        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			        Citizen.Wait(5000)
			        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_yellowjack', ('yellowjack'), amount)
			        Citizen.Wait(100)
			        ESX.ShowNotification("Vous avez bien envoyé la facture")
		        end
		    else
		        ESX.ShowNotification("~r~Aucun joueur à proximité")
		    end
	    end, function(data, menu)
		menu.close()
	end)
end

Keys.Register('F6', 'yellowjackjob', 'Ouvrir le menu Yellow Jack', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then
    	Menu()
	end
end)
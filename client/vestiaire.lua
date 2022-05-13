local mainMenu = RageUI.CreateMenu("", "Vestiaire")
local open = false

mainMenu.Closed = function() open = false end

function Vestiaire()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while open do 
		        RageUI.IsVisible(mainMenu, function()
                    RageUI.Separator("↓ "..Config.Color.."Vêtements Civils ~s~↓")
                    RageUI.Button("Tenue de Civil", nil, {RightLabel = "→"}, true, {onSelected = function() Tenuecivil() end})
                    RageUI.Separator("↓ "..Config.Color.."Vêtements de Service ~s~↓")
                    if ESX.PlayerData.job.grade_name == 'barman' or ESX.PlayerData.job.grade_name == 'gerant' or ESX.PlayerData.job.grade_name == 'boss' then
                        RageUI.Button("Tenue de Barman", nil, {RightLabel = "→"}, true, {onSelected = function() Tenuebarman() end})
                    end
                    if ESX.PlayerData.job.grade_name == 'gerant' or ESX.PlayerData.job.grade_name == 'boss' then
                        RageUI.Button("Tenue de Gérant", nil, {RightLabel = "→"}, true, {onSelected = function() Tenuegerant() end})
                    end
                    if ESX.PlayerData.job.grade_name == 'boss' then
                        RageUI.Button("Tenue de Patron", nil, {RightLabel = "→"}, true, {onSelected = function() Tenuepatron() end})
                    end
		        end)
		    Wait(0)
		    end
	    end)
    end
end

function Tenuecivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) 
        TriggerEvent('skinchanger:loadSkin', skin) 
        ESX.ShowNotification("Vous avez repris votre tenue de "..Config.Color.."Civil")
    end) 
end

function Tenuebarman()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        for k,v in pairs(Config.Vestiaire.Tenue.Barman) do
            if skin.sex == 0 then
                clothesSkin = {
                    ['tshirt_1'] = v.male.tshirt_1,     ['tshirt_2'] = v.male.tshirt_2,
                    ['torso_1'] = v.male.torso_1,       ['torso_2'] = v.male.torso_2,
                    ['decals_1'] = v.male.decals_1,     ['decals_2'] = v.male.decals_2,
                    ['chain_1'] = v.male.chain_1,       ['chain_2'] = v.male.chain_2,
                    ['arms'] = v.male.arms,
                    ['pants_1'] = v.male.pants_1,       ['pants_2'] = v.male.pants_2,
                    ['shoes_1'] = v.male.shoes_1,       ['shoes_2'] = v.male.shoes_2,
                    ['helmet_1'] = v.male.helmet_1,     ['helmet_2'] = v.male.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Barman")
            else
                clothesSkin = {
                    ['tshirt_1'] = v.female.tshirt_1,     ['tshirt_2'] = v.female.tshirt_2,
                    ['torso_1'] = v.female.torso_1,       ['torso_2'] = v.female.torso_2,
                    ['decals_1'] = v.female.decals_1,     ['decals_2'] = v.female.decals_2,
                    ['chain_1'] = v.female.chain_1,       ['chain_2'] = v.female.chain_2,
                    ['arms'] = v.female.arms,
                    ['pants_1'] = v.female.pants_1,       ['pants_2'] = v.female.pants_2,
                    ['shoes_1'] = v.female.shoes_1,       ['shoes_2'] = v.female.shoes_2,
                    ['helmet_1'] = v.female.helmet_1,     ['helmet_2'] = v.female.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Barwoman")
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end

function Tenuegerant()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        for k,v in pairs(Config.Vestiaire.Tenue.Gerant) do
            if skin.sex == 0 then
                clothesSkin = {
                    ['tshirt_1'] = v.male.tshirt_1,     ['tshirt_2'] = v.male.tshirt_2,
                    ['torso_1'] = v.male.torso_1,       ['torso_2'] = v.male.torso_2,
                    ['decals_1'] = v.male.decals_1,     ['decals_2'] = v.male.decals_2,
                    ['chain_1'] = v.male.chain_1,       ['chain_2'] = v.male.chain_2,
                    ['arms'] = v.male.arms,
                    ['pants_1'] = v.male.pants_1,       ['pants_2'] = v.male.pants_2,
                    ['shoes_1'] = v.male.shoes_1,       ['shoes_2'] = v.male.shoes_2,
                    ['helmet_1'] = v.male.helmet_1,     ['helmet_2'] = v.male.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Gérant")
            else
                clothesSkin = {
                    ['tshirt_1'] = v.female.tshirt_1,     ['tshirt_2'] = v.female.tshirt_2,
                    ['torso_1'] = v.female.torso_1,       ['torso_2'] = v.female.torso_2,
                    ['decals_1'] = v.female.decals_1,     ['decals_2'] = v.female.decals_2,
                    ['chain_1'] = v.female.chain_1,       ['chain_2'] = v.female.chain_2,
                    ['arms'] = v.female.arms,
                    ['pants_1'] = v.female.pants_1,       ['pants_2'] = v.female.pants_2,
                    ['shoes_1'] = v.female.shoes_1,       ['shoes_2'] = v.female.shoes_2,
                    ['helmet_1'] = v.female.helmet_1,     ['helmet_2'] = v.female.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Gérante")
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end

function Tenuepatron()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        for k,v in pairs(Config.Vestiaire.Tenue.Patron) do
            if skin.sex == 0 then
                clothesSkin = {
                    ['tshirt_1'] = v.male.tshirt_1,     ['tshirt_2'] = v.male.tshirt_2,
                    ['torso_1'] = v.male.torso_1,       ['torso_2'] = v.male.torso_2,
                    ['decals_1'] = v.male.decals_1,     ['decals_2'] = v.male.decals_2,
                    ['chain_1'] = v.male.chain_1,       ['chain_2'] = v.male.chain_2,
                    ['arms'] = v.male.arms,
                    ['pants_1'] = v.male.pants_1,       ['pants_2'] = v.male.pants_2,
                    ['shoes_1'] = v.male.shoes_1,       ['shoes_2'] = v.male.shoes_2,
                    ['helmet_1'] = v.male.helmet_1,     ['helmet_2'] = v.male.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Patron")
            else
                clothesSkin = {
                    ['tshirt_1'] = v.female.tshirt_1,     ['tshirt_2'] = v.female.tshirt_2,
                    ['torso_1'] = v.female.torso_1,       ['torso_2'] = v.female.torso_2,
                    ['decals_1'] = v.female.decals_1,     ['decals_2'] = v.female.decals_2,
                    ['chain_1'] = v.female.chain_1,       ['chain_2'] = v.female.chain_2,
                    ['arms'] = v.female.arms,
                    ['pants_1'] = v.female.pants_1,       ['pants_2'] = v.female.pants_2,
                    ['shoes_1'] = v.female.shoes_1,       ['shoes_2'] = v.female.shoes_2,
                    ['helmet_1'] = v.female.helmet_1,     ['helmet_2'] = v.female.helmet_2
                }
                ESX.ShowNotification("Vous avez équipé votre tenue de "..Config.Color.."Patronne")
            end
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
    	local wait = 900
    	for k,v in pairs(Config.Vestiaire.Pos) do
        	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then 
            	local coords = GetEntityCoords(GetPlayerPed(-1), false)
            	local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            	if dist <= 2.0 then 
					wait = 0
            		DrawMarker(Config.Markers.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, false)
            		if dist <= 0.8 then 
						wait = 0
						ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le "..Config.Color.."Vestiaire")
                		if IsControlJustPressed(1,51) then
							Vestiaire()
           				end
        			end
        		end
    		end
		Citizen.Wait(wait)
		end
	end
end)
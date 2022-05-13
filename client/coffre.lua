local mainMenu = RageUI.CreateMenu("", "Coffre")
local PutMenu = RageUI.CreateSubMenu(mainMenu, "", "Inventaire")
local GetMenu = RageUI.CreateSubMenu(mainMenu, "", "Stockage")
local PlayerInventory,all_items = {},{}
local open = false

mainMenu.Closed = function() open = false end

function Coffre()
	if not open then open = true RageUI.Visible(mainMenu, true)
		CreateThread(function()
		    while open do
		        RageUI.IsVisible(mainMenu, function() 
			        RageUI.Button("Prendre un objet", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            getStock()
                        end
                    }, GetMenu)
                    RageUI.Button("Déposer un objet", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            getInventory()
                        end
                    }, PutMenu)
                end)
                RageUI.IsVisible(GetMenu, function()
                    for k,v in pairs(all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = ""..Config.Color.."x"..v.nb}, true, {
                            onSelected = function()
                                local count = KeyboardInput("Nombre d'Objet à prendre ",nil,4)
                                count = tonumber(count)
                                if count <= v.nb then
                                    TriggerServerEvent('yellowjack:takeStockItems', v.item, count)
                                else
                                    ESX.ShowNotification("~r~Montont invalide")
                                end
                                getStock()
                            end
                        })
                    end
                end)
                RageUI.IsVisible(PutMenu, function()
                    for k,v in pairs(all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = ""..Config.Color.."x"..v.nb}, true, {
                            onSelected = function()
                                local count = KeyboardInput("Nombre d'objet à déposer ",nil,4)
                                count = tonumber(count)
                                if count <= v.nb then
                                    TriggerServerEvent("yellowjack:putStockItems", v.item, count)
                                else
                                    ESX.ShowNotification("~r~Montant invalide")
                                end
                                getInventory()
                            end
                        })
                    end
                end)
		    Wait(0)
		    end
	    end)
    end
end

function getInventory()   
	ESX.TriggerServerCallback('yellowjack:playerinventory', function(inventory)                               
		all_items = inventory
	end)
end

function getStock()
    ESX.TriggerServerCallback('yellowjack:getStockItems', function(inventory)                    
        all_items = inventory
    end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry..':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Citizen.Wait(0) end
    if UpdateOnscreenKeyboard() ~= 2 then local result = GetOnscreenKeyboardResult() Citizen.Wait(500) blockinput = false return result else Citizen.Wait(500) blockinput = false return nil end
end

Citizen.CreateThread(function()
    while true do
    	local wait = 900
        for k,v in pairs(Config.Coffre.Pos) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellowjack' then
                local coords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
                if dist <= 2.0 then
                    wait = 0
                    DrawMarker(Config.Markers.Type, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.Markers.Color.r, Config.Markers.Color.g, Config.Markers.Color.b, Config.Markers.Color.a, false, false, p19, false)
                    if dist <= 0.8 then 
                        wait = 0
                        ESX.ShowHelpNotification("~INPUT_TALK~ pour ouvrir le "..Config.Color.."Coffre")
                        if IsControlJustPressed(1,51) then
                            Coffre()
                        end
                    end
                end
            end
        end
	Citizen.Wait(wait)
	end
end)
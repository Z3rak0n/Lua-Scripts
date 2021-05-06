
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(200)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)

local group 

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Admin Menu", "~b~Hier findest du das Admin menu")
_menuPool:Add(mainMenu)

function CreateMenu(menu)
	--Ausweis
	local submenu = _menuPool:AddSubMenu(menu, "Managment", "Hier findest du dein ausweis")
	local show = NativeUI.CreateItem("Unsichtbar", "")
	submenu:AddItem(show)

	local lookat = NativeUI.CreateItem("Sichtbar", "")
	submenu:AddItem(lookat)

	local god = NativeUI.CreateItem("Godmode", "an")
	submenu:AddItem(god)

	local godoff = NativeUI.CreateItem("Godmode", "aus")
	submenu:AddItem(godoff)

	local id = NativeUI.CreateItem("Teleport to Marker", "aus")
	submenu:AddItem(id)

	submenu.OnItemSelect = function(sender, item, index)
		if item == show then
			TriggerServerEvent('invisiblee', Source)
		elseif item == lookat then
			TriggerServerEvent('visiblee', Source)
		elseif item == god then
			godmodeon()
		elseif item == godoff then
			godmodeoff()
		elseif item == id then
			TriggerEvent('teleportMarker')
		end
	end
	
	--Waffenschein

	local submenuweapon = _menuPool:AddSubMenu(menu, "Teleport Options", "Hier findest du alle Teleport möglichkeiten")
	local show = NativeUI.CreateItem("Teleport zum Spieler zeigen", "")
	submenuweapon:AddItem(show)

	local lookat = NativeUI.CreateItem("Waffenschein ansehen", "")
	submenuweapon:AddItem(lookat)

	submenuweapon.OnItemSelect = function(sender, item, index)
		if item == show then
			AddMenuIncidentLocation()
		elseif item == lookat then
			--LookatIdWeapon()
		end
	end

	--Driver License

	local submenudriver = _menuPool:AddSubMenu(menu, "Führerschein", "Hier findest du dein Führerschein")
	local show = NativeUI.CreateItem("Führerschein zeigen", "")
	submenudriver:AddItem(show)

	local lookat = NativeUI.CreateItem("Führerschein ansehen", "")
	submenudriver:AddItem(lookat)

	submenudriver.OnItemSelect = function(sender, item, index)
		if item == show then
			--ShowIdDriver()
		elseif item == lookat then
			--LookatIdDriver()
		end
	end
end	

CreateMenu(mainMenu)
_menuPool:MouseEdgeEnabled(false)
_menuPool:RefreshIndex()


Citizen.CreateThread(function()
	while true do
			Citizen.Wait(0)
			_menuPool:ProcessMenus()
			--[[ The "e" button will activate the menu ]]--
		
			if IsControlJustPressed(1, 208) then
				if group == Config.AdminGroup then				
					
					mainMenu:Visible(not mainMenu:Visible())
					notify("Menu Open POG")
				end
			end
	end
end)




--[[RegisterCommand('+menu', function()

    mainMenu:Visible(not mainMenu:Visible())
end)

RegisterKeyMapping('+menu', 'Ausweis Menu', 'keyboard', 'numpad2')

RegisterCommand('-menu', function()
end)--]]



ESX = nil
 Citizen.CreateThread(function()
	while ESX == nil do
		 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			 Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local plate = nil


_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu(Translation[Config.Locale]['Admission_office'], Translation[Config.Locale]['Platechange'])
_menuPool:Add(mainMenu)

function CreateMenu(menu)
	--Ausweis


  local plate = UIMenuItem.New(Translation[Config.Locale]['header'], Translation[Config.Locale]['subtitle'])
  menu:AddItem(plate)
  
    menu.OnItemSelect = function(sender, item, index)
        if item == plate then
             Changer(newplate)
        end
    end
end

function Menu()
    local marker = DrawMarker(1, Config.Zones.Pos.x, Config.Zones.Pos.y, Config.Zones.Pos.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, Config.Color.r, Config.Color.g, Config.Color.b, Config.Color.a, false, false, 2, false, nil, nil, false)
    local p = GetEntityCoords(PlayerPedId())
    if IsControlJustReleased(1, 38) then
        local dist = Vdist(p.x, p.y, p.z, Config.Zones.Pos.x, Config.Zones.Pos.y, Config.Zones.Pos.z)
        if dist < Config.Distance then
            mainMenu:Visible(not mainMenu:Visible())
            
        end
    end
end


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false 
		return result 
        
	else
		Citizen.Wait(500) 
		blockinput = false
		return nil
	end
    newplate(result)
end

-- Threads --


CreateMenu(mainMenu)

_menuPool:MouseEdgeEnabled(false)
_menuPool:RefreshIndex()

local blips = {

     {title="Zulassungs stelle", colour=30, id=326, x = 338.66809082031, y = -1562.7145996094, z = 29.298038482666}
  }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        Menu()
        if IsControlJustReleased(1, 38) then
            TriggerServerEvent('CheckPlate', -1, plate)
            print(plate)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

function Changer(newplate)
    local p = PlayerPedId()
    local coords = GetEntityCoords(p)
    local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 20.0)
    if veh ~= nil then 
        -- if plate < 8 then
        --     print("Nein")
        -- else
        -- end
        local oldplate = GetVehicleNumberPlateText(veh)
        local plate = KeyboardInput("StarWars", plattxt, 8)
        if SetVehicleNumberPlateText(veh, plate) then
            TriggerServerEvent('plate:update', oldplate, plate)
        end
        if (Config.Debug == true) then
        print(plate)
        end
    end
    
    
end


--- Functions ---

function GetAllVehicles()
    local vehicles = {}
    
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end
    
    return vehicles
end

-- Return closest loaded vehicle entity or nil if no vehicle is found
function GetClosestVehicle(x, y, z, maxRadius)
    local vehicles       = GetAllVehicles()
    local dist           = maxRadius
    local closestVehicle = nil
    
    for i=1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local tempDist = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, x, y, z)
        if (tempDist < dist) then
            dist = tempDist
            closestVehicle = vehicles[i]
        end
    end
    
    if (closestVehicle ~= nil and DoesEntityExist(closestVehicle)) then
        return closestVehicle
    else
        return nil
    end
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end

        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}



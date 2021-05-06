----------------------Client Events -----------------
RegisterNetEvent('invisible')
AddEventHandler('invisible', function(Source)
	local pp = PlayerId()
	SetPlayerVisibleLocally(PlayerPedId(), false)
	SetEntityVisible(PlayerPedId(), false, false)
end)

RegisterNetEvent('visible')
AddEventHandler('visible', function(Source)
local gay = PlayerPedId()
SetPlayerVisibleLocally(PlayerPedId(), true)
SetEntityVisible(PlayerPedId(), true, false)
end)

RegisterNetEvent('teleportMarker')
AddEventHandler('teleportMarker', function()
	local WaypointHandle = GetFirstBlipInfoId(8)

	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

				break
			end

			Citizen.Wait(5)
		end

		notify("Teleported.")
	else
		notify("Please place your waypoint.")
	end
end)


---------------Functions----------------
function godmodeon()
    local playerPed = GetPlayerPed(-1)
	if SetEntityInvincible() == true then
	    SetEntityInvincible(playerPed,true)
	    notify("GodMode ~r~On")
	end

end

function tpplayer()
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(targetId)
  
	--NetworkSetInSpectatorMode(false, playerPed) -- turn off spectator mode just in case
	
	if PlayerId() == targetId then
	  drawNotification("~r~This player is you!")
	elseif not NetworkIsPlayerActive(targetId) then
	  drawNotification("~r~This player is not in game.")
	else
	  local targetCoords = GetEntityCoords(targetPed)
	  local targetVeh = GetVehiclePedIsIn(targetPed, False)
	  local seat = -1
  
	  drawNotification("~g~Teleporting to " .. GetPlayerName(targetId) .. " (Player " .. targetId .. ").")
  
	  if targetVeh then
		local numSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVeh))
		if numSeats > 1 then
		  for i=0, numSeats do
			if seat == -1 and IsVehicleSeatFree(targetveh, i) then seat = 1 end
		  end
		end
	  end
	  if seat == -1 then
		SetEntityCoords(playerPed, targetCoords, 1, 0, 0, 1)
	  else
		SetPedIntoVehicle(playerPed, targetVeh, seat)
	  end
	end
end



function AddMenuIncidentLocation(menu)
    local incidentLocation = NativeUI.CreateItem("Incident Location", "Please input the exact location of the incident?")
    incidentLocation:SetRightBadge(BadgeStyle.Tick)
    menu:AddItem(incidentLocation)
    incidentLocation.Activated = function(sender, item, index)
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 128 + 1)
        while(UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if(GetOnscreenKeyboardResult()) then
            result = GetOnscreenKeyboardResult()
        end
    end
    incidentLocation = result
end

function godmodeoff()
	local playerPed = GetPlayerPed(-1)
	if (SetEntityInvincible() == false) then
	    SetEntityInvincible(playerPed,false)
	    notify("GodMode ~r~Off")
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function cloth()
	local player = PlayerId()
	local ped = PlayerPedId()
	local draw = GetNumberOfPedDrawableVariations(ped, 1)
	local number = GetNumberOfPedTextureVariations(ped, 1, 3)
	local model = GetHashKey("mp_m_freemode_01")
	
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(100)
	end
	SetPlayerModel(player, model)
	
	Citizen.Wait(200)
	SetPedDefaultComponentVariation(PlayerPedId())
	SetPedComponentVariation(PlayerPedId(), 1, 135, 0, 0)
	SetPedComponentVariation(PlayerPedId(), 11, 287, 0, 0)
	SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
	SetPedComponentVariation(PlayerPedId(), 3, 166, 0, 0)
	SetPedComponentVariation(PlayerPedId(), 4, 114, 0, 0)
	SetPedComponentVariation(PlayerPedId(), 6, 78, 0, 0)
	SetModelAsNoLongerNeeded(model)

	
	--[[Female 
		
	SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 2)
	SetPedComponentVariation(PlayerPedId(), 4, 21, 0, 2)
	SetPedComponentVariation(PlayerPedId(), 6, 34, 0, 2)
	SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2)
	SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 2)--]]
end

function setUniform(uniform, playerPed)
	local player = PlayerId()
	local ped = PlayerPedId()
	local draw = GetNumberOfPedDrawableVariations(ped, 1)
	local number = GetNumberOfPedTextureVariations(ped, 1, 3)
	local model = GetHashKey("mp_m_freemode_01")
	
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(100)
	end
	SetPlayerModel(player, model)
	
	Citizen.Wait(200)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin.sex == 0 then
			modelHash = GetHashKey(data.current.maleModel)
		else
			modelHash = GetHashKey(data.current.femaleModel)
		end

		ESX.Streaming.RequestModel(modelHash, function()
			SetPlayerModel(PlayerId(), modelHash)
			SetModelAsNoLongerNeeded(modelHash)
			SetPedDefaultComponentVariation(PlayerPedId())

			TriggerEvent('esx:restoreLoadout')
		end)
	end)
end



------ Bullshit -------


function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end


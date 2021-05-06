function notify(text)
    local mugshot = RegisterPedheadshot(PlayerPedId())
    while (not IsPedheadshotReady(mugshot)) do
        Citizen.Wait(0)
    end
    if (not IsPedheadshotValid(mugshot)) then
        return
    end

    local txdString = GetPedheadshotTxdString(mugshot)
    local name = source

    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)

    --local notification = DrawNotificationIcon(txdString, txdString, 0, 0, "FM_GEN_UNLOCK")
    SetNotificationMessage_3(txdString, txdString, true, 5, GetPlayerName(PlayerId()), "", text)
    local notification = DrawNotification(true, true)
    UnregisterPedheadshot(mugshot)

end

function subTitle(text)
	SetTextColour(186, 186, 186, 255)
	SetTextScale(0.378, 0.378)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.165, 0.956)
end

RegisterNetEvent('notify')
AddEventHandler('notify', function(noti)
	subTitle(noti)
end)

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
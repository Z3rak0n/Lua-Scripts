TriggerEvent("es:addGroup", "mod", "user", function(group) end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
    invisible = "superadmin",
    visible = "superadmin"
}

RegisterNetEvent('invisiblee')
AddEventHandler('invisiblee', function(Source)
    local Source = source
    TriggerEvent('es:getPlayerFromId', source, function(user)
        TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
            if available or user.getGroup() == "superadmin" then
                TriggerClientEvent('invisible', Source)
            else
                notify("Du hast nicht Rechte HUDN")
            end
        end)
    end)
end)

RegisterNetEvent('visiblee')
AddEventHandler('visiblee', function(Source)
    local Source = source
    TriggerEvent('es:getPlayerFromId', source, function(user)
        TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
            if available or user.getGroup() == "superadmin" then
                TriggerClientEvent('visible', Source)
            else
                
                notify("Du hast nicht Rechte HUDN")
            end
        end)
    end)
end)



RegisterNetEvent('idabove')
AddEventHandler('idabove', function(text)
    

end)

function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("es_admin:setGroup", v.get('source'), v.get('group'))
		end
	end)
end
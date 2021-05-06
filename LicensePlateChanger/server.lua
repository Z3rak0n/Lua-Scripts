local ESX = nil
local price = Config.price
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent('plate:update')
AddEventHandler('plate:update', function( oldP, newP)
    local oldplate = string.upper(tostring(oldP):match("^%s*(.-)%s*$"))
    local newplate = string.upper(newP)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local money    = xPlayer.getMoney(xPlayer)
    MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles', {},
    function (result)
    local result = result
      local dupe = false
  
      for i=1, #result, 1 do
        if result[i].plate == newplate then
          dupe = true
        end
      end
  
      if not dupe then
        MySQL.Async.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE plate = @plate', {['@plate'] = oldplate},
        function (result)
          if result[1] ~= nil then
            local vehicle = json.decode(result[1].vehicle)
            vehicle.plate = newplate
            MySQL.Async.execute('UPDATE owned_vehicles SET plate = @newplate, vehicle = @vehicle WHERE plate = @oldplate', {['@newplate'] = newplate, ['@oldplate'] = oldplate, ['@vehicle'] = json.encode(vehicle)})
            if xPlayer.getMoney() >= price then
              xPlayer.removeMoney(Config.price)
            else
              print("hallo")
            end
            
          end
        end)
      end
      if Config.Debug == true then
        print(price)
        print(money)
        print(oldplate)
        print(newplate)
        print("DEBUG TABLES")
      end
    end)
end)



RegisterNetEvent('CheckPlate')
AddEventHandler('CheckPlate', function(source, plate)
  MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
    if result ~= plate then
      print("error")
      return
    else
      print(#result[1].plate)
		end
    
  end)
end)
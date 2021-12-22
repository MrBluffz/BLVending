ESX = nil
local CooldownTable = {}

while not ESX do TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end) end

ESX.RegisterServerCallback("BLVending:canRob", function(source, cb, proploc)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local police = 0

	if CooldownTable[tostring(proploc)] then
		TriggerClientEvent("esx:showNotification", source, "This machine can't be robbed for a bit longer")
		cb(false)
		goto theend
	else
		CooldownTable[tostring(proploc)] = Config.Cooldown
	end

	for i = 1, #xPlayers do
		local tPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if tPlayer.getJob().name == "police" then police = police + 1 end
	end

	if police < math.floor(Config.MinPolice) then
		TriggerClientEvent("esx:showNotification", source, 'Not enough police online for this action!')
		cb(false)
		goto theend
	end

	if xPlayer.getInventoryItem(Config.RequiredItem).count > 0 then
		cb(true)
	else
		TriggerClientEvent("esx:showNotification", source, 'You are missing the required item.')
		cb(false)
	end
	::theend::
end)

RegisterNetEvent('BLVending:SuccessRob')
AddEventHandler('BLVending:SuccessRob', function(shop)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	math.randomseed(os.time())
	local items = Config.RobRewards[shop]
	local reward = math.random(1, #items)
	if Config.RemoveRobItem then xPlayer.removeInventoryItem(Config.RequiredItem) end
	if items[reward].name == 'money' then
		xPlayer.addAccountMoney('money', math.random(items[reward].min, items[reward].max))
	else
		xPlayer.addInventoryItem(items[reward].name, math.random(items[reward].min, items[reward].max))
	end
end)

RegisterNetEvent('BLVending:NotifPolice')
AddEventHandler('BLVending:NotifPolice', function(loc)
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers do
		local tPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if tPlayer.getJob().name == "police" then
			TriggerClientEvent("esx:showNotification", xPlayers[i], 'Vending Machine Theft Alert! Check Map!')
			TriggerClientEvent('BLVending:RobBlip', xPlayers[i], loc)
		end
	end
end)

Citizen.CreateThread(function()
	local time = Config.CooldownCheck
	while true do
		Citizen.Wait(time)
		for k, v in pairs(CooldownTable) do
			v = v - time
			if v < 0 then v = 0 end
			if v == 0 then
				CooldownTable[k] = nil
			else
				CooldownTable[k] = v
			end
		end
	end
end)

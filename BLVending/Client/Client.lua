-- Don't touch any of these please....
local ESX
local playerData

-- In case someone job changes
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(j)
	playerData.job = j
	setupThirdEye()
end)

-- ESX Setup
setupEsx = function()
	while not ESX do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(100)
	end
	while not ESX.IsPlayerLoaded() do Wait(500) end
	playerData = ESX.GetPlayerData()
	Wait(100)
end

setupThirdEye = function()
	Wait(0)
	local options = {
		{
			name = 'open',
			label = 'Purchase Items',
		},
	}

	if playerData.job.name ~= 'police' then
		table.insert(options, {
			name = 'rob',
			label = 'Steal Item',
		})
	end

	for k, v in pairs(Config.VendingMachineModels) do
		exports["fivem-target"]:AddTargetModel({
			name = k,
			label = "Vending Machine",
			icon = "fas fa-cash-register",
			model = GetHashKey(k),
			interactDist = 2,
			onInteract = OpenVending,
			options = options,
		})
	end
end

RegisterNetEvent('BLVending:RobBlip')
AddEventHandler('BLVending:RobBlip', function(loc)
	local Blip = AddBlipForCoord(loc)
	local radius = AddBlipForRadius(loc, 40.0)
	SetBlipSprite(Blip, 126)
	SetBlipColour(Blip, 1)
	SetBlipAlpha(Blip, 250)
	SetBlipDisplay(Blip, 4)
	SetBlipScale(Blip, 1.2)
	SetBlipFlashes(Blip, true)
	SetBlipAsShortRange(Blip, true)

	SetBlipHighDetail(radius, true)
	SetBlipColour(radius, 5)
	SetBlipAlpha(radius, 250)
	SetBlipAsShortRange(radius, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Vending Machine Theft Alert")
	EndTextCommandSetBlipName(Blip)
	Wait(Config.BlipDuration)
	RemoveBlip(Blip)
	RemoveBlip(radius)
end)

function PlayAnimation(ped, animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
end

-- Main Thread
Citizen.CreateThread(function()
	setupEsx()
	setupThirdEye()
end)

OpenVending = function(targetName, optionName, vars, entityHit)
	local ped = PlayerPedId()
	local loc = GetEntityCoords(ped)
	local machineloc = GetEntityCoords(entityHit)
	if optionName == 'rob' then
		ESX.TriggerServerCallback("BLVending:canRob", function(can)
			if can then
				PlayAnimation(ped, 'amb@prop_human_bum_bin@base', 'base', -1)
				TriggerServerEvent('BLVending:NotifPolice', loc)
				exports["mf-inventory"]:startMinigame(Config.Count, Config.Speed, function(res)
					if res then
						ClearPedTasksImmediately(ped)
						TriggerServerEvent('BLVending:SuccessRob', Config.VendingMachineModels[targetName])
					else
						ClearPedTasksImmediately(ped)
						ESX.ShowNotification('You failed to break in, run before the cops show up!')
					end
				end)
			end
		end, machineloc)
	else
		exports["mf-inventory"]:openOtherInventory(Config.VendingMachineModels[targetName])
	end
end

--[[
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
─██████──────────██████─████████████████──────██████████████───██████─────────██████──██████─██████████████─██████████████─██████████████████─
─██░░██████████████░░██─██░░░░░░░░░░░░██──────██░░░░░░░░░░██───██░░██─────────██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░░░██─
─██░░░░░░░░░░░░░░░░░░██─██░░████████░░██──────██░░██████░░██───██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████─████████████░░░░██─
─██░░██████░░██████░░██─██░░██────██░░██──────██░░██──██░░██───██░░██─────────██░░██──██░░██─██░░██─────────██░░██─────────────────████░░████─
─██░░██──██░░██──██░░██─██░░████████░░██──────██░░██████░░████─██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████───────████░░████───
─██░░██──██░░██──██░░██─██░░░░░░░░░░░░██──────██░░░░░░░░░░░░██─██░░██─────────██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─────████░░████─────
─██░░██──██████──██░░██─██░░██████░░████──────██░░████████░░██─██░░██─────────██░░██──██░░██─██░░██████████─██░░██████████───████░░████───────
─██░░██──────────██░░██─██░░██──██░░██────────██░░██────██░░██─██░░██─────────██░░██──██░░██─██░░██─────────██░░██─────────████░░████─────────
─██░░██──────────██░░██─██░░██──██░░██████────██░░████████░░██─██░░██████████─██░░██████░░██─██░░██─────────██░░██─────────██░░░░████████████─
─██░░██──────────██░░██─██░░██──██░░░░░░██────██░░░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██─────────██░░██─────────██░░░░░░░░░░░░░░██─
─██████──────────██████─██████──██████████────████████████████─██████████████─██████████████─██████─────────██████─────────██████████████████─
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 
]] 
-- ####################################################################################
-- #                                   DISCORD:                                       #
-- #                          https://discord.gg/QPPSBncbZn                           #
-- ####################################################################################
local sec = 1000
local min = 60 * sec

Config = {}
-- Don't touch above

-- How often to check for Cooldown
Config.CooldownCheck = 10 * sec

-- Minigame settings
Config.Count = 4
Config.Speed = 0.6

-- Rob settings
Config.MinPolice = 2
Config.RequiredItem = 'phone'
Config.RemoveRobItem = true
Config.Cooldown = 5 * min
Config.BlipDuration = 7 * sec

-- Vending machine prop name, follow by shop identifier from your mf-config
Config.VendingMachineModels = {
	['prop_vend_snak_01'] = 'shop1',
	['p_ld_coffee_vend_s'] = 'shop1',
	['p_ld_coffee_vend_01'] = 'shop1',
	['prop_vend_water_01'] = 'shop1',
	['prop_vend_condom_01'] = 'shop1',
	['prop_vend_coffe_01'] = 'shop1',
	['prop_vend_fridge01'] = 'shop1',
	['prop_vend_soda_02'] = 'shop1',
	['prop_vend_soda_01'] = 'shop1',
	['prop_vend_fags_01'] = 'shop1',
}

-- the 'shop1' part needs to match the shop type from above
Config.RobRewards = {
	['shop1'] = {
		{
			name = 'water',
			min = 1,
			max = 2,
		}, {
			name = 'bread',
			min = 1,
			max = 2,
		}, {
			name = 'money',
			min = 10,
			max = 2000,
		},
	},
}

---@diagnostic disable: undefined-global, lowercase-global
---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- Creation Date: [24/05/2021 10:02]
--- Original Authors GitHub: https://github.com/ImBaphomettt | https://github.com/ItsikNox | https://github.com/Kalyptus
---
--- Ported to YimMenu-Lua by SAMURAI (xesdoog)
--- https://github.com/xesdoog
--- Port Date: [02/01/2024 18:00]
---

require('includes/RageUI_init')
require('includes/vehicle_spawner')


local MainMenu = RageUI.CreateMenu("YimRageUI", "Example RageUI Menu");
-- MainMenu.EnableMouse = false
local SubMenu       = RageUI.CreateSubMenu(MainMenu, "Submenu", "This is a submenu.")
SubMenu.EnableMouse = true
local SpawnInside   = false
local vehicleNames  = GetVehicleNames()
local ListIndex     = 1
local GridX, GridY  = 0, 0

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		-- Items
		Items:CheckBox("Spawn Inside", "Automatically teleport inside the vehicle when you spawn it.", SpawnInside, { Style = 1 }, function(onSelected, IsChecked)
			if onSelected then
				SpawnInside = IsChecked
			end
		end)
		Items:AddList("Vehicle:", vehicleNames, ListIndex, "Press [Enter] to spawn the vehicle.", { IsDisabled = false }, function(Index, onSelected, onListChange)
			if onListChange then
				ListIndex = Index
			end
			if onSelected then
				SpawnVeh(joaat(Vehicles_t[ListIndex]), SpawnInside)
			end
		end)
		Items:AddSeparator("--- Separator ---")
		Items:AddButton("Open Submenu", "This is a button that opens a submenu and enables the mouse.", { IsDisabled = false }, function()
		end, SubMenu)
		Items:AddButton("Show Message", "This is a button that simply displays a message.", { IsDisabled = false }, function(onSelected)
			if onSelected then
				gui.show_message("YimRageUI", "Hey there, partner!")
			end
		end)
		Items:AddButton("Disabled Button", "This button is disabled.", { IsDisabled = true }, function() end)


	end, function()
		-- Panels
	end)

	SubMenu:IsVisible(function(Items)
		-- Items
		Items:Heritage(math.round(GridX * 10), math.round(GridY * 10))
		Items:AddButton("Example MP Player Heritage", "Press and hold [LMB] to move the circle around the grid.", { IsDisabled = false }, function() end)

	end, function(Panels)
		-- Panels
		Panels:Grid(GridX, GridY, "Top", "Bottom", "Left", "Right", function(X, Y, _, _)
			GridX = X
			GridY = Y
		end, 1)
	end)
end

RegisterKeyMapping("F5", "Open/Close UI", function()
	Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef, false)
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)

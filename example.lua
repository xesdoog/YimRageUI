---@diagnostic disable
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


local MenuPosition = vec2:new(1, 1)
local vehicleNames = GetVehicleNames()
local SpawnInside  = false
local MenuPos_x    = {}
local MenuPos_y    = {}
local ListIndex    = 1
local GridX, GridY = 0, 0

for x = 1, 1600 do
	table.insert(MenuPos_x, x)
end

for y = 1, 900 do
	table.insert(MenuPos_y, y)
end


local MainMenu = RageUI.CreateMenu("YimRageUI", "Example RageUI Menu", MenuPosition.x, MenuPosition.y)
-- MainMenu.EnableMouse = true
local SubMenu = RageUI.CreateSubMenu(MainMenu, "Submenu", "This is an example submenu.")
local SettingsSubMenu = RageUI.CreateSubMenu(MainMenu, "Settings", "Example settings submenu.")
SubMenu.EnableMouse = true
SettingsSubMenu.EnableMouse = false

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

		Items:AddButton("Show Message", "This is a button that simply displays a message.", { IsDisabled = false }, function(onSelected)
			if onSelected then
				gui.show_message("YimRageUI", "Hey there, partner!")
			end
		end)

		Items:AddButton("Disabled Button", "This button is disabled.", { IsDisabled = true }, function() end)

		Items:AddButton("Open Submenu", "This is a button that opens a submenu and enables the mouse.", { IsDisabled = false }, function()
		end, SubMenu)

		Items:AddButton("Menu Settings", "This is a button that opens a settings submenu.", { IsDisabled = false }, function()
		end, SettingsSubMenu)

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

	SettingsSubMenu:IsVisible(function(Items)
		-- Items
		Items:AddList("Menu X:", MenuPos_x, MenuPosition.x or 0, "Move left/right", { IsDisabled = false }, function(Index, onSelected, onListChange)
			if onListChange then
				MenuPosition.x = Index
				MainMenu.X = MenuPosition.x
				SubMenu.X = MenuPosition.x
				SettingsSubMenu.X = MenuPosition.x
			end
		end)

		Items:AddList("Menu Y:", MenuPos_y, MenuPosition.y or 0, "Move up/down", { IsDisabled = false }, function(Index, onSelected, onListChange)
			if onListChange then
				MenuPosition.y = Index
				MainMenu.Y = MenuPosition.y
				SubMenu.Y = MenuPosition.y
				SettingsSubMenu.Y = MenuPosition.y
			end
		end)

		Items:AddList("Theme", { "Light" }, 1, "Test_a", { IsDisabled = true }, function() end)

		Items:AddList("Type", { "commonmenu" }, 1, "Test_b", { IsDisabled = true }, function() end)

		Items:AddList("Backgroud", { "gradient_bgd" }, 1, "Test_c", { IsDisabled = true }, function() end)

		Items:AddList("Text Colour", { "Default" }, 1, "Test_d", { IsDisabled = true }, function() end)

	end, function()
		-- Panels
	end)
end

RegisterKeyMapping("F5", "Open/Close UI", function()
	Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef, false)
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)

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

local basePath = 'includes/'
local modules  = {
    'RageUI',
    'Menu',
    'MenuController',
    'components/Audio',
    'components/Visual',
    'components/Graphics',
    'components/Util',
    'components/Keys',
    'elements/ItemsBadge',
    'elements/ItemsColour',
    'elements/PanelColour',
    'items/Items',
    'items/Panels',
}

for _, module in pairs(modules) do
    require(string.format("%s%s", basePath, module))
end

local MainMenu = RageUI.CreateMenu("Title", "SUBTITLE");
MainMenu.EnableMouse = true;

local SubMenu = RageUI.CreateSubMenu(MainMenu, "Title", "SubTitle")

local Checked = false;
local ListIndex = 1;

local GridX, GridY = 0, 0

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:Heritage(1, 2)
		Items:AddButton("Sub Menu", "Sub Menu", { IsDisabled = false }, function(onSelected)

		end, SubMenu)
		Items:AddButton("Hello world", "Hello world.", { IsDisabled = false }, function(onSelected)

		end)
		Items:AddList("List", { 1, 2, 3 }, ListIndex, nil, { IsDisabled = false }, function(Index, onSelected, onListChange)
			if (onListChange) then
				ListIndex = Index;
			end
		end)
		Items:AddSeparator("Separator")
		Items:CheckBox("Hello", "Descriptions", Checked, { Style = 1 }, function(onSelected, IsChecked)
			if (onSelected) then
				Checked = IsChecked
			end
		end)


	end, function(Panels)
		Panels:Grid(GridX, GridY, "Top", "Bottom", "Left", "Right", function(X, Y, CharacterX, CharacterY)
			GridX = X;
			GridY = Y;
		end, 1)
	end)

	SubMenu:IsVisible(function(Items)
		-- Items
		Items:AddButton("Hello world", "Hello world.", { IsDisabled = false }, function(onSelected)

		end)
	end, function()
		-- Panels
	end)
end

script.register_looped("RAGEUI", function(rageui)
    while true do
        RageUI.PoolMenus.Timer = 250
        if RageUI.PoolMenus.Name ~= nil then
            RageUI.PoolMenus[RageUI.PoolMenus.Name]()
        end
        rageui:sleep(RageUI.PoolMenus.Timer)
        if RageUI.PoolMenus.Timer == 250 then
            RageUI.PoolMenus.Name = nil
            RageUI.Pool();
        end
    end
end)

RegisterKeyMapping("F5", "Test", function()
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)

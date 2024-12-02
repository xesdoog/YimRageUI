---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:20]
--- 


---CreateMenu
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIMenus
---@public
function RageUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
	local Menu = {}
	Menu.Display = {};

	Menu.InstructionalButtons = {}

	Menu.Display.Header = true;
	Menu.Display.Subtitle = true;
	Menu.Display.Background = true;
	Menu.Display.Navigation = true;
	Menu.Display.InstructionalButton = true;
	Menu.Display.PageCounter = true;

	Menu.Title = Title or ""
	Menu.TitleFont = 1
	Menu.TitleScale = 1.2
	Menu.Subtitle = string.upper(Subtitle) or nil
	Menu.SubtitleHeight = -37
	Menu.Description = nil
	Menu.DescriptionHeight = RageUI.Settings.Items.Description.Background.Height
	Menu.X = X or 0
	Menu.Y = Y or 0
	Menu.Parent = nil
	Menu.WidthOffset = 0
	Menu.Open = false
	Menu.Controls = RageUI.Settings.Controls
	Menu.Index = 1
	Menu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = R, G = G, B = B, A = A } }
	Menu.Rectangle = nil
	Menu.Pagination = { Minimum = 1, Maximum = 10, Total = 10 }
	Menu.Safezone = true
	Menu.SafeZoneSize = nil
	Menu.EnableMouse = false
	Menu.Options = 0
	Menu.Closable = true

	if string.starts(Menu.Subtitle, "~") then
		Menu.PageCounterColour = string.lower(string.sub(Menu.Subtitle, 1, 3))
	else
		Menu.PageCounterColour = ""
	end

	if Menu.Subtitle ~= "" then
		local SubtitleLineCount = Graphics.GetLineCount(Menu.Subtitle, Menu.X + RageUI.Settings.Items.Subtitle.Text.X, Menu.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

		if SubtitleLineCount > 1 then
			Menu.SubtitleHeight = 18 * SubtitleLineCount
		else
			Menu.SubtitleHeight = 0
		end
	end

	script.run_in_fiber( function()
		if not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(Menu.InstructionalScaleform) then
			Menu.InstructionalScaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS")
			while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(Menu.InstructionalScaleform) do
				coroutine.yield()
			end
		end
	end)

	return setmetatable(Menu, RageUIMenus)
end

---CreateSubMenu
---@param ParentMenu function
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIMenus
---@public
function RageUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
	if ParentMenu ~= nil then
		if ParentMenu() then
			local Menu = RageUI.CreateMenu(Title or ParentMenu.Title, string.upper(Subtitle) or string.upper(ParentMenu.Subtitle), X or ParentMenu.X, Y or ParentMenu.Y)
			Menu.Parent = ParentMenu
			Menu.WidthOffset = ParentMenu.WidthOffset
			Menu.Safezone = ParentMenu.Safezone
			if ParentMenu.Sprite then
				Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
			else
				Menu.Rectangle = ParentMenu.Rectangle
			end
			return setmetatable(Menu, RageUIMenus)
		else
			return nil
		end
	else
		return nil
	end
end

---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function RageUIMenus:SetSubtitle(Subtitle)
	self.Subtitle = string.upper(Subtitle) or string.upper(self.Subtitle)
	if string.starts(self.Subtitle, "~") then
		self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
	else
		self.PageCounterColour = ""
	end
	if self.Subtitle ~= "" then
		local SubtitleLineCount = Graphics.GetLineCount(self.Subtitle, self.X + RageUI.Settings.Items.Subtitle.Text.X, self.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

		if SubtitleLineCount > 1 then
			self.SubtitleHeight = 18 * SubtitleLineCount
		else
			self.SubtitleHeight = 0
		end
	else
		self.SubtitleHeight = -37
	end
end

function RageUIMenus:AddInstructionButton(button)
	if type(button) == "table" and #button == 2 then
		table.insert(self.InstructionalButtons, button)
		self.UpdateInstructionalButtons(true);
	end
end

function RageUIMenus:RemoveInstructionButton(button)
	if type(button) == "table" then
		for i = 1, #self.InstructionalButtons do
			if button == self.InstructionalButtons[i] then
				table.remove(self.InstructionalButtons, i)
				self.UpdateInstructionalButtons(true);
				break
			end
		end
	else
		if tonumber(button) then
			if self.InstructionalButtons[tonumber(button)] then
				table.remove(self.InstructionalButtons, tonumber(button))
				self.UpdateInstructionalButtons(true);
			end
		end
	end
end

---@param Visible boolean
function RageUIMenus:UpdateInstructionalButtons(Visible)

	if not Visible then
		return
	end

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "CLEAR_ALL")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "TOGGLE_MOUSE_BUTTONS")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(0)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "CREATE_CONTAINER")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "SET_DATA_SLOT")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(2, 176, true))
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION("HUD_INPUT2"))
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

	if self.Closable then
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "SET_DATA_SLOT")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(1)
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(2, 177, true))
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION("HUD_INPUT3"))
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	end

	local count = 2

	if (self.InstructionalButtons ~= nil) then
		for i = 1, #self.InstructionalButtons do
			if self.InstructionalButtons[i] then
				if #self.InstructionalButtons[i] == 2 then
					GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "SET_DATA_SLOT")
					GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(count)
					GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(self.InstructionalButtons[i][1])
					GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(self.InstructionalButtons[i][2])
					GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
					count = count + 1
				end
			end
		end
	end

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.InstructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(-1)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end

---IsVisible
---@param Item fun(Item:Items)
---@param Panel fun(Panel:Panels)
function RageUIMenus:IsVisible(Item, Panel)
	if (RageUI.Visible(self)) and (MISC.UPDATE_ONSCREEN_KEYBOARD() ~= 0) and (MISC.UPDATE_ONSCREEN_KEYBOARD() ~= 3) then
		RageUI.Banner()
		RageUI.Subtitle()
		Item(Items);
		RageUI.Background();
		RageUI.Navigation();
		RageUI.Description();
		Panel(Panels);
		RageUI.PoolMenus.Timer = 1
		RageUI.Render()
	end
end

function RageUIMenus:KeysRegister(Controls, ControlName, Description, Action)
	RegisterKeyMapping(string.format('riv-%s', ControlName), Description, "keyboard", Controls)
	RegisterCommand(string.format('riv-%s', ControlName), function(source, args)
		if (Action ~= nil) then
			Action();
		end
	end, false)
end

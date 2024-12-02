---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:44]
--- 

Visual = {};

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(sub)
    end
end

function Visual.Notification(args)
    script.run_in_fiber(function()
        if (not args.dict) and (args.name )then
            args.dict = args.name
        end
        if not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(args.dict) then
            GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(args.dict, false)
            while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(args.dict) do
                coroutine.yield()
            end
        end
        if (args.backId) then
            HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(args.backId)
        end
        HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("jamyfafi")
        if (args.message) then
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(args.message)
            if string.len(args.message) > 99 then
                AddLongString(args.message)
            end
        end
        if (args.title) and (args.subtitle) and (args.name) then
            HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(args.dict or "CHAR_DEFAULT", args.name or "CHAR_DEFAULT", true, args.icon or 0, args.title or "", args.subtitle or "")
            GRAPHICS.SET_STREAMED_TEXTURE_DICT_AS_NO_LONGER_NEEDED(args.dict)
        end
        HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, true)
    end)
end

function Visual.Subtitle(text, time)
    HUD.CLEAR_PRINTS()
    HUD.BEGIN_TEXT_COMMAND_PRINT("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_PRINT(time and math.ceil(time) or 0, true)
end

function Visual.FloatingHelpText(text, sound, loop)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("jamyfafi")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, loop or 0, sound or false, -1)
end

function Visual.Prompt(text, spinner)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(spinner or 1)
end

function Visual.PromptDuration(duration, text, spinner)
    script.run_in_fiber(function(pmpt)
        pmpt:sleep(0.01)
        Visual.Prompt(text, spinner)
        pmpt:sleep(duration)
        if (HUD.BUSYSPINNER_IS_ON()) then
            HUD.BUSYSPINNER_OFF();
        end
    end)
end

function Visual.FloatingHelpTextToEntity(text, x, y)
    HUD.SET_FLOATING_HELP_TEXT_SCREEN_POSITION(1, x, y)
    HUD.SET_FLOATING_HELP_TEXT_STYLE(1, 1, 2, -1, 3, 0)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("jamyfafi")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    HUD.END_TEXT_COMMAND_DISPLAY_HELP(2, false, false, -1)
end

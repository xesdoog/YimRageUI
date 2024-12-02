---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File Created: [24/05/2021 00:00]
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:44]
--- 

local VK = {
    ["BACKSPACE"]           = 0x08,
    ["TAB"]                 = 0x09,
    ["CLEAR"]               = 0x0C,
    ["ENTER"]               = 0x0D,
    ["SHIFT"]               = 0x10,
    ["CTRL"]                = 0x11,
    ["ALT"]                 = 0x12,
    ["PAUSE"]               = 0x13,
    ["CAPSLOCK"]            = 0x14,
    ["ESC"]                 = 0x1B,
    ["SPACEBAR"]            = 0x20,
    ["PAGEUP"]              = 0x21,
    ["PAGEDOWN"]            = 0x22,
    ["END"]                 = 0x23,
    ["HOME"]                = 0x24,
    ["LEFT ARROW"]          = 0x25,
    ["UP ARROW"]            = 0x26,
    ["RIGHT ARROW"]         = 0x27,
    ["DOWN ARROW"]          = 0x28,
    ["SELECT"]              = 0x29,
    ["PRINT"]               = 0x2A,
    ["EXECUTE"]             = 0x2B,
    ["PRINT SCREEN"]        = 0x2C,
    ["INSERT"]              = 0x2D,
    ["DEL"]                 = 0x2E,
    ["HELP"]                = 0x2F,
    ["0"]                   = 0x30,
    ["1"]                   = 0x31,
    ["2"]                   = 0x32,
    ["3"]                   = 0x33,
    ["4"]                   = 0x34,
    ["5"]                   = 0x35,
    ["6"]                   = 0x36,
    ["7"]                   = 0x37,
    ["8"]                   = 0x38,
    ["9"]                   = 0x39,
    ["A"]                   = 0x41,
    ["B"]                   = 0x42,
    ["C"]                   = 0x43,
    ["D"]                   = 0x44,
    ["E"]                   = 0x45,
    ["F"]                   = 0x46,
    ["G"]                   = 0x47,
    ["H"]                   = 0x48,
    ["I"]                   = 0x49,
    ["J"]                   = 0x4A,
    ["K"]                   = 0x4B,
    ["L"]                   = 0x4C,
    ["M"]                   = 0x4D,
    ["N"]                   = 0x4E,
    ["O"]                   = 0x4F,
    ["P"]                   = 0x50,
    ["Q"]                   = 0x51,
    ["R"]                   = 0x52,
    ["S"]                   = 0x53,
    ["T"]                   = 0x54,
    ["U"]                   = 0x55,
    ["V"]                   = 0x56,
    ["W"]                   = 0x57,
    ["X"]                   = 0x58,
    ["Y"]                   = 0x59,
    ["Z"]                   = 0x5A,
    ["Left Windows"]        = 0x5B,
    ["Right Windows"]       = 0x5C,
    ["Apps"]                = 0x5D,
    ["Sleep"]               = 0x5F,
    ["Numpad 0"]            = 0x60,
    ["Numpad 1"]            = 0x61,
    ["Numpad 2"]            = 0x62,
    ["Numpad 3"]            = 0x63,
    ["Numpad 4"]            = 0x64,
    ["Numpad 5"]            = 0x65,
    ["Numpad 6"]            = 0x66,
    ["Numpad 7"]            = 0x67,
    ["Numpad 8"]            = 0x68,
    ["Numpad 9"]            = 0x69,
    ["VK_MULTIPLY"]         = 0x6A,
    ["VK_ADD"]              = 0x6B,
    ["VK_SEPARATOR"]        = 0x6C,
    ["VK_SUBTRACT"]         = 0x6D,
    ["VK_DECIMAL"]          = 0x6E,
    ["VK_DIVIDE"]           = 0x6F,
    ["F1"]                  = 0x70,
    ["F2"]                  = 0x71,
    ["F3"]                  = 0x72,
    ["F4"]                  = 0x73,
    ["F5"]                  = 0x74,
    ["F6"]                  = 0x75,
    ["F7"]                  = 0x76,
    ["F8"]                  = 0x77,
    ["F9"]                  = 0x78,
    ["F10"]                 = 0x79,
    ["F11"]                 = 0x7A,
    ["F12"]                 = 0x7B,
    ["F13"]                 = 0x7C,
    ["F14"]                 = 0x7D,
    ["F15"]                 = 0x7E,
    ["F16"]                 = 0x7F,
    ["F17"]                 = 0x80,
    ["F18"]                 = 0x81,
    ["F19"]                 = 0x82,
    ["F20"]                 = 0x83,
    ["F21"]                 = 0x84,
    ["F22"]                 = 0x85,
    ["F23"]                 = 0x86,
    ["F24"]                 = 0x87,
    ["NUMLOCK"]             = 0x90,
    ["SCROLLLOCK"]          = 0x91,
    ["LSHIFT"]              = 0xA0,
    ["RSHIFT"]              = 0xA1,
    ["LCTRL"]               = 0xA2,
    ["RCTRL"]               = 0xA3,
    ["LALT"]                = 0xA4,
    ["RALT"]                = 0xA5,
    ["Browser Back"]        = 0xA6,
    ["Browser Forward"]     = 0xA7,
    ["Browser Refresh"]     = 0xA8,
    ["Browser Stop"]        = 0xA9,
    ["Browser Search"]      = 0xAA,
    ["Browser Favorites"]   = 0xAB,
    ["Browser Start"]       = 0xAC,
    ["Volume Mute"]         = 0xAD,
    ["Volume Down"]         = 0xAE,
    ["Volume Up"]           = 0xAF,
    ["Next Track"]          = 0xB0,
    ["Previous Track"]      = 0xB1,
    ["Stop Media"]          = 0xB2,
    ["Play/Pause Media"]    = 0xB3,
    ["Start Mail"]          = 0xB4,
    ["Select Media"]        = 0xB5,
    ["Start Application 1"] = 0xB6,
    ["Start Application 2"] = 0xB7,
    ["VK_OEM_1"]            = 0xBA,
    ["VK_OEM_PLUS"]         = 0xBB,
    ["VK_OEM_COMMA"]        = 0xBC,
    ["VK_OEM_MINUS"]        = 0xBD,
    ["VK_OEM_PERIOD"]       = 0xBE,
    ["VK_OEM_2"]            = 0xBF,
    ["VK_OEM_3"]            = 0xC0,
    ["VK_OEM_4"]            = 0xDB,
    ["VK_OEM_5"]            = 0xDC,
    ["VK_OEM_6"]            = 0xDD,
    ["VK_OEM_7"]            = 0xDE,
    ["VK_OEM_8"]            = 0xDF,
    ["VK_OEM_102"]          = 0xE2,
    ["Attn"]                = 0xF6,
    ["Erase EOF"]           = 0xF9,
    ["Play"]                = 0xFA,
    ["Zoom"]                = 0xFB,
    ["Clear"]               = 0xFE,
    ["MOUSE4"]              = 0x10020,
    ["MOUSE5"]              = 0x20040,
}

---Register
---@param KeyName string
---@param Description string
---@param Action function
function RegisterKeyMapping(KeyName, Description, Action)
    Registered_keys = {}
    if VK[KeyName] then
        local this_keymap = {keyN = KeyName, keyC = VK[KeyName], desc = Description, action = Action}
        table.insert(Registered_keys, this_keymap)
    end
end

event.register_handler(menu_event.Wndproc, function(_, msg, wParam, _)
    if Registered_keys ~= nil and #Registered_keys > 0 then
        if msg == 0x0101 or msg == 0x0105 then
            for _, keymap in pairs(Registered_keys) do
                if wParam == keymap.keyC then
                    if keymap.action ~= nil then
                        keymap.action()
                    end
                end
            end
        end
    end
end)
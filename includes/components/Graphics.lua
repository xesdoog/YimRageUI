---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 00:00]
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:44]
--- 

---@param str string
local function StringToArray(str)
    local charCount = #str
    local strCount = math.ceil(charCount / 99)
    local strings = {}

    for i = 1, strCount do
        local start = (i - 1) * 99 + 1
        local clamp = math.clamp(#string.sub(str, start), 0, 99)
        local finish = ((i ~= 1) and (start - 1) or 0) + clamp

        strings[i] = string.sub(str, start, finish)
    end

    return strings
end

local function AddText(str)
    str = tostring(str)
    local charCount = #str

    if charCount < 100 then
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(str)
    else
        local strings = StringToArray(str)
        for s = 1, #strings do
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(strings[s])
        end
    end
end

local function RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = text, (x or 0) / 1920, (y or 0) / 1080
    HUD.SET_TEXT_FONT(font or 0)
    HUD.SET_TEXT_SCALE(1.0, scale or 0)
    HUD.SET_TEXT_COLOUR(r or 255, g or 255, b or 255, a or 255)
    if dropShadow then
        HUD.SET_TEXT_DROP_SHADOW()
    end
    if outline then
        HUD.SET_TEXT_OUTLINE()
    end
    if alignment ~= nil then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            HUD.SET_TEXT_CENTRE(true)
        elseif alignment == 2 or alignment == "Right" then
            HUD.SET_TEXT_RIGHT_JUSTIFY(true)
        end
    end
    if wordWrap and wordWrap ~= 0 then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            HUD.SET_TEXT_WRAP(X - ((wordWrap / 1920) / 2), X + ((wordWrap / 1920) / 2))
        elseif alignment == 2 or alignment == "Right" then
            HUD.SET_TEXT_WRAP(0, X)
        else
            HUD.SET_TEXT_WRAP(X, X + (wordWrap / 1920))
        end
    else
        if alignment == 2 or alignment == "Right" then
            HUD.SET_TEXT_WRAP(0, X)
        end
    end
    return Text, X, Y
end

Graphics = {};

function Graphics.MeasureStringWidth(str, font, scale)
    HUD.BEGIN_TEXT_COMMAND_GET_SCREEN_WIDTH_OF_DISPLAY_TEXT("CELL_EMAIL_BCON")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(str)
    HUD.SET_TEXT_FONT(font or 0)
    HUD.SET_TEXT_SCALE(1.0, scale or 0)
    return HUD.END_TEXT_COMMAND_GET_SCREEN_WIDTH_OF_DISPLAY_TEXT(true) * 1920
end

function Graphics.Rectangle(x, y, width, height, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080
    GRAPHICS.DRAW_RECT(X + Width * 0.5, Y + Height * 0.5, Width, Height, r or 255, g or 255, b or 255, a or 255, false)
end

function Graphics.Sprite(dictionary, name, x, y, width, height, heading, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080

    if not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dictionary) then
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dictionary, true)
    end

    GRAPHICS.DRAW_SPRITE(dictionary, name, X + Width * 0.5, Y + Height * 0.5, Width, Height, heading or 0, r or 255, g or 255, b or 255, a or 255, false)
end

function Graphics.GetLineCount(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    HUD.BEGIN_TEXT_COMMAND_GET_NUMBER_OF_LINES_FOR_STRING("CELL_EMAIL_BCON")
    AddText(Text)
    return HUD.END_TEXT_COMMAND_GET_NUMBER_OF_LINES_FOR_STRING(X, Y)
end

function Graphics.Text(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("CELL_EMAIL_BCON")
    AddText(Text)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(X, Y, 0)
end

function Graphics.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(PAD.GET_CONTROL_NORMAL(2, 239) * 1920) / 1920, math.round(PAD.GET_CONTROL_NORMAL(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function Graphics.ConvertToPixel(x, y)
    return (x * 1920), (y * 1080)
end

function Graphics.ScreenToWorld(distance, flags)
    local camRot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local camPos = CAM.GET_GAMEPLAY_CAM_COORD()
    local mouse  = vec2:new(PAD.GET_CONTROL_NORMAL(2, 239), PAD.GET_CONTROL_NORMAL(2, 240))
    local cam3DPos, forwardDir = Graphics.ScreenRelToWorld(camPos, camRot, mouse)
    local direction = camPos + forwardDir * distance
    local rayHandle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
        cam3DPos.x, cam3DPos.y, cam3DPos.z,
        direction.x, direction.y, direction.z,
        flags, 0, 0
    )

    local _, hit, endCoords, surfaceNormal, entityHit = SHAPETEST.GET_SHAPE_TEST_RESULT(
        rayHandle, hit, endCoords, surfaceNormal, entityHit
    )

    return hit, endCoords, surfaceNormal, entityHit, (entityHit >= 1 and ENTITY.GET_ENTITY_TYPE(entityHit) or 0), direction, mouse
end

---@param camPos vec3
---@param camRot vec3
---@param cursor vec2
function Graphics.ScreenRelToWorld(camPos, camRot, cursor)
    local camForward   = Graphics.RotationToDirection(camRot)
    local rotUp        = vec3:new(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown      = vec3:new(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft      = vec3:new(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight     = vec3:new(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight     = Graphics.RotationToDirection(rotRight) - Graphics.RotationToDirection(rotLeft)
    local camUp        = Graphics.RotationToDirection(rotUp) - Graphics.RotationToDirection(rotDown)
    local rollRad      = -(camRot.y * math.pi / 180.0)
    local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad)
    local camUpRoll    = camRight * math.sin(rollRad) + camUp * math.cos(rollRad)
    local point3DZero  = camPos + camForward * 1.0
    local point3D      = point3DZero + camRightRoll + camUpRoll
    local point2D      = Graphics.World3DToScreen2D(point3D)
    local point2DZero  = Graphics.World3DToScreen2D(point3DZero)
    local scaleX       = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY       = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret   = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir   = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
end

function Graphics.RotationToDirection(rotation)
    local x, z = (rotation.x * math.pi / 180.0), (rotation.z * math.pi / 180.0)
    local num  = math.abs(math.cos(x))
    return vec3:new((-math.sin(z) * num), (math.cos(z) * num), math.sin(x))
end

function Graphics.World3DToScreen2D(pos)
    local aX, aY = GRAPHICS.GET_SCREEN_RESOLUTION(aX, aY)
    local _, sX, sY = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, aX, aY)
    return vec2:new(sX, sY)
end
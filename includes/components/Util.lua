---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 09:57]
---
--- Ported To YimMenu-Lua by SAMURAI (xesdoog)
--- File Modified: [02/01/2024 17:44]
--- 

---@param num number
---@param numDecimalPlaces? number
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---@param String string
---@param Start string
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@param x number
---@param min number
---@param max number
function math.clamp(x, min, max)
    if x >= min then
        if x <= max then return x end
        return max
    end
    return min
end

---@param vec vec3
---@param includeZ boolean
function vec3:reverse(vec, includeZ)
    return vec3:new(-vec.x, -vec.y, includeZ and -vec.z or vec.z)
end

---@param v1 vec3
---@param v2 vec3
---@return vec3
function vec3:add(v1, v2)
    return vec3:new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
end

---@param v1 vec3
---@param v2 vec3
---@return vec3
function vec3:sub(v1, v2)
    return vec3:new(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
end

---@param v1 vec3
---@param p1 vec3 | number
---@return vec3
function vec3:mult(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec3:new(v1.x * p1.x, v1.y * p1.y, v1.z * p1.z)
    elseif type(p1) == 'number' then
        return vec3:new(v1.x * p1, v1.y * p1, v1.z * p1)
    end
    return vec3:new(0.0, 0.0, 0.0)
end

---@meta
---Class representing a 2D vector.
---@class vec2
---@field x float x component of the vector.
---@field y float y component of the vector.
vec2 = {}

---Returns: vec2: A 2D vector that contains x and y values.
---
---**Example Usage:**
---```lua
---myInstance = vec2:new(x, y)
---```
---@param x float x component of the vector.
---@param y float y component of the vector.
---@return vec2
function vec2:new(x, y) end
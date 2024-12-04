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

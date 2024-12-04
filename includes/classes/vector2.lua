---@diagnostic disable
---@meta
---Class representing a 2D vector.
---@class vec2
---@field x float x component of the vector.
---@field y float y component of the vector.
vec2 = {}
vec2.__index = vec2
vec2.__tostring = function(vec)
    return string.format("(%s, %s)", vec.x, vec.y)
end

---@param v1 vec2
---@param p1 vec2 | number
---@return vec2
vec2.__add = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec2:new(v1.x + p1.x, v1.y + p1.y)
    elseif type(p1) == 'number' then
        return vec2:new(v1.x + p1, v1.y + p1)
    end
    return vec2:new(0, 0)
end

---@param v1 vec2
---@param p1 vec2 | number
---@return vec2
vec2.__sub = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec2:new(v1.x - p1.x, v1.y - p1.y)
    elseif type(p1) == 'number' then
        return vec2:new(v1.x - p1, v1.y - p1)
    end
    return vec2:new(0, 0)
end

---@param v1 vec2
---@param p1 vec2 | number
---@return vec2
vec2.__mult = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec2:new(v1.x * p1.x, v1.y * p1.y)
    elseif type(p1) == 'number' then
        return vec2:new(v1.x * p1, v1.y * p1)
    end
    return vec2:new(0, 0)
end

---@param v1 vec2
---@param p1 vec2 | number
---@return vec2
vec2.__div = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec2:new(v1.x / p1.x, v1.y / p1.y)
    elseif type(p1) == 'number' then
        return vec2:new(v1.x / p1, v1.y / p1)
    end
    return vec2:new(0, 0)
end

-- Constructor
--
-- Returns `vec2`: A 2D vector containing x and y values.
--
-- **Example Usage:**
-- ```lua
-- myInstance = vec2:new(x, y)
-- ```
---@param x float x component of the vector.
---@param y float y component of the vector.
---@return vec2
function vec2:new(x, y)
    setmetatable(self, vec2)
    self.x = x or 0
    self.y = y or 0
    return self
end

---@param vec vec2
function vec2:inverse(vec)
    return vec2:new(-vec.x, -vec.y)
end

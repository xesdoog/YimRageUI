---@diagnostic disable
---@meta
---Class representing a 3D vector.
---@class vec3
---@field x float x component of the vector.
---@field y float y component of the vector.
---@field z float z component of the vector.
vec3 = {}
vec3.__index = vec3
vec3.__tostring = function(vec)
    return string.format("(%s, %s, %s)", vec.x, vec.y, vec.z)
end

---@param v1 vec3
---@param p1 vec3 | number
---@return vec3
vec3.__add = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec3:new(v1.x + p1.x, v1.y + p1.y, v1.z + p1.z)
    elseif type(p1) == 'number' then
        return vec3:new(v1.x + p1, v1.y + p1, v1.z + p1)
    end
    return vec3:new(0, 0, 0)
end

---@param v1 vec3
---@param p1 vec3 | number
---@return vec3
vec3.__sub = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec3:new(v1.x - p1.x, v1.y - p1.y, v1.z - p1.z)
    elseif type(p1) == 'number' then
        return vec3:new(v1.x - p1, v1.y - p1, v1.z - p1)
    end
    return vec3:new(0, 0, 0)
end

---@param v1 vec3
---@param p1 vec3 | number
---@return vec3
vec3.__mult = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec3:new(v1.x * p1.x, v1.y * p1.y, v1.z * p1.z)
    elseif type(p1) == 'number' then
        return vec3:new(v1.x * p1, v1.y * p1, v1.z * p1)
    end
    return vec3:new(0, 0, 0)
end

---@param v1 vec3
---@param p1 vec3 | number
---@return vec3
vec3.__div = function(v1, p1)
    if type(p1) == 'table' or type(p1) == 'userdata' then
        return vec3:new(v1.x / p1.x, v1.y / p1.y, v1.z / p1.z)
    elseif type(p1) == 'number' then
        return vec3:new(v1.x / p1, v1.y / p1, v1.z / p1)
    end
    return vec3:new(0, 0, 0)
end

-- Constructor

---Returns: `vec3`: a vector containing x, y, and z values.
---**Example Usage:**
---```lua
---myInstance = vec3:new(x, y, z)
---```
---@param x float x component of the vector.
---@param y float y component of the vector.
---@param z float z component of the vector.
---@return vec3
function vec3:new(x, y, z)
    setmetatable(self, vec3)
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
    return self
end

---@param vec vec3
---@param includeZ boolean
function vec3:inverse(vec, includeZ)
    return vec3:new(-vec.x, -vec.y, includeZ and -vec.z or vec.z)
end

---@param this vec3
---@param that vec3
function vec3:distance(this, that)
    local dist_x = (that.x - this.x) ^ 2
    local dist_y = (that.y - this.y) ^ 2
    local dist_z = (that.z - this.z) ^ 2
    return math.sqrt(dist_x + dist_y + dist_z)
end

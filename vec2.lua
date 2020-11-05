--Most functions have a Capital and lower case version
--the lower case version will create a new vector while the capital version will modify the original
local ffi = require("ffi")

ffi.cdef("typedef struct {double x,y;} vec2;")

local mt = {}
mt.__index = mt

local vec2 = {new = ffi.typeof("vec2")}
vec2.mt = mt


--lenght
local sqrt = math.sqrt
function mt:getLength()
  return sqrt(self.x^2+self.y^2)
end

--transform to unit vector
function mt:normalise()
  if self.x ~= 0 or self.y ~= 0 then
    local l = self:getLength()
    return vec2.new(self.x/l,self.y/l)
  else
    return vec2.new(0,0)
  end
end

function mt:Normalise()
  if self.x ~= 0 or self.y ~= 0 then
    local l = self:getLength()
    self.x,self.y = self.x/l,self.y/l
  end
  return self
end

--returns normal vector
function mt:getNormal()
  return vec2.new(-self.y,self.x)
end

function mt:GetNormal()
  self.x,self.y = -self.y,self.x
  return self
end

--for printing
local formstr = "Vector(%.2f, %.2f)"
function mt.__tostring(vec)
  return formstr:format(vec.x,vec.y)
end

--adding 2 vectors
function mt.__add(v1,v2)
    return vec2.new(v1.x+v2.x,v1.y+v2.y)
end

function mt:Add(v2)
    self.x = self.x+v2.x
    self.y = self.y+v2.y
    return self
end

--subtracting vectors
function mt.__sub(v1,v2)
    return vec2.new(v1.x-v2.x,v1.y-v2.y)
end

function mt:Sub(v2)
    self.x = self.x-v2.x
    self.y = self.y-v2.y
    return self
end

-- Dot product of 2 vectors
function mt.__mul(a,b)
  return a.x*b.x+a.y*b.y
end

--Cross product
function mt.__div(a,b)
  return a.x*b.y - a.y*b.x
end

function mt:scale(s)
  return vec2.new(self.x*s,self.y*s)
end

function mt:Scale(s)
  self.x,self.y = self.x*s,self.y*s
  return self
end

function mt:div(s)
  return vec2.new(self.x/s,self.y/s)
end

function mt:Div(s)
  self.x,self.y  = self.x/s,self.y/s
  return self
end

--project b onto a
function mt.__mod(a,b)
  return a:scale((a*b)/(a*a))
end

function mt:Project(b)
  self:Scale((self*b)/(self*self))
  return self
end

function mt.__unm(v)
  return vec2.new(-v.y,-v.y)
end
mt.negate = vec2.mt.__unm

function mt:Negate()
    self.x = -self.s
    self.y = -self.y
    return self
end

local cos,sin = math.cos,math.sin
function mt:rotate(a)
  local u, v = self.x, self.y
  local c, s = cos(a), sin(a)
  return vec2.new(u*c - v*s,u*s + v*c)
end

function mt:Rotate(a)
    local u, v = self.x, self.y
    local c, s = cos(a), sin(a)
    self.x,self.y = u*c - v*s,u*s + v*c
    return self
end

function mt.__eq(v1,v2)
  return (v1.x == v2.x and v1.y == v2.y)
end

function mt.__lt(v1,v2)
  return v1:getLength() < v2:getLength()
end

function mt.__le(v1,v2)
  return v1:getLenght() <= v2:getLength()
end

if love then
  function mt:draw(x,y)
    love.graphics.line(x,y,x+self.x,y+self.y)
  end
end

ffi.metatype("vec2",vec2.mt)
return vec2

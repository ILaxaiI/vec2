local sqrt = math.sqrt
local cos,sin = math.cos,math.sin
local ffi = require("ffi")
ffi.cdef("typedef struct {double x,y;} vec2;")
local vec2 = {}

vec2.mt = {}
vec2.mt.__index = vec2.mt

function vec2.new(x,y)
 return ffi.new("vec2",x,y)
end


--lenght
function vec2.mt:getLength()
    return sqrt(self.x^2+self.y^2)
end

--transform to unit vector
function vec2.mt:normalise()
  if self.x == 0 and self.y == 0 then
    return vec2.new(0,0)
  else
    local l = self:getLength()
    return vec2.new(self.x/l,self.y/l)
  end
end

--returns normal vector
function vec2.mt:getNormal()
  return vec2.new(-self.y,self.x)
end

--for printing
function vec2.mt.__tostring(vec)
  return "x= "..vec.x..", y= "..vec.y
end

--adding 2 vectors
function vec2.mt.__add(v1,v2)
  if ffi.istype("vec2",v2) then
    return vec2.new(v1.x+v2.x,v1.y+v2.y)
  elseif type(v2) == "number" then
    return vec2.new(v1.x+v2,v1.y+v2)
  end
end

function vec2.mt:add(v2)
  if ffi.istype("vec2",v2) then
    self.x = self.x+v2.x
    self.y = self.y+v2.y
  elseif type(v2) == "number" then
    self.x = self.x+v2
    self.y = self.y+v2
  end
end


--subtracting vectors
function vec2.mt.__sub(v1,v2)
  if ffi.istype("vec2",v2) then
    return vec2.new(v1.x-v2.x,v1.y-v2.y)
  elseif type(v2) == "number" then
    return vec2.new(v1.x-v2,v1.y-v2)
  end
end

function vec2.mt:sub(v2)
  if ffi.istype("vec2",v2) then
    self.x = self.x-v2.x
    self.y = self.y-v2.y
  elseif type(v2) == "number" then
    self.x = self.x-v2
    self.y = self.y-v2
  end
end


--multiplying a vector buy a number or Dot product
function vec2.mt.__mul(a,b)
  if ffi.istype("vec2",b) and type(a) == "number" then 
    return vec2.new(a*b.x,a*b.y)
  elseif ffi.istype("vec2",a) and type(b) == "number" then
    return vec2.new(b*a.x,b*a.y)
  elseif ffi.istype("vec2",a) and ffi.istype("vec2",b) then
    return a.x*b.x+a.y*b.y
  end
end

function vec2.mt:scaleup(s)
  if type(s) == "number" then
    self.x = self.x*s
    self.y = self.y*s
  end
end


--dividing a vector by a number or Cross product
function vec2.mt.__div(a,b)
  if ffi.istype("vec2",a) and type(b) == "number"  then
    return vec2.new(a.x/b,a.y/b)
  elseif ffi.istype("vec2",a) and ffi.istype("vec2",b) then
    return a.x*b.y - a.y*b.x
  end  
end

function vec2.mt:scaledown(s)
  if type(s) == "number" then
    self.x = self.x/s
    self.y = self.y/s
  end
end


--do mod operation on both coordinates, or project b onto a 
function vec2.mt.__mod(a,b)
  if ffi.istype("vec2",a) and type(b) == "number" then
    return vec2.new(a.x%b,a.y%b)
  elseif ffi.istype("vec2",a) and ffi.istype("vec2",b) then
    if a.x == 0 and a.y == 0 then 
      return vec2.new(0,0)
    else
      return a*((a*b)/(a*a))
    end
  end
end

function vec2.mt.__unm(v)
  return vec2.new(-v.y,-v.y)
end

function vec2.mt:rotate(a)  
  local u, v = self.x, self.y
  local c, s = cos(a), sin(a)
  return vec2.new(u*c - v*s,u*s + v*c)
end


function vec2.mt.__eq(v1,v2)
  return (v1.x == v2.x and v1.y == v2.y)
end

function vec2.mt.__lt(v1,v2)
  return v1:getLength() < v2:getLength()
end

function vec2.mt.__le(v1,v2)
  return v1:getLenght() <= v2:getLength()
end

function vec2.mt:getX()
  return self.x
end

function vec2.mt:getY()
  return self.y
end

function vec2.mt:getXY()
  return self.x,self.y
end


ffi.metatype("vec2",vec2.mt)

return vec2
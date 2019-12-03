# vec2
Vec2 module using FFI

This was written in the Love game engine, wich uses luajit

usage:
vec2 = require "vec2"

vec = vec2.new(x,y)

|maths:||
|-|-|
|v = v1+v2|add|
|v = v1-v2|subtract|
|s = v1*v2| skalar multiply|
|x = v1/v2| cross multiply |
|v%num|modulo on x,y|
|v1%v2|vector projection|
|vec:rotate(angle)|rotation|
these create a new vector without overriding the old ones

|also||
|-|-|
|v:add(num / vec)||
|v:sub(num / vec)||
|v:scaleup(num)| multiply by num|
|v:scaledown(num)| divide by num|


|vector comparisions||
|--|--|
|v1 == v2|x=x,y=y|
|v1 < v2|length < length|
|v1 >= v2|length >= length| 

in order to increase the speed when used where jit is off there are functions for
v:getX() , :getY() , getXY()

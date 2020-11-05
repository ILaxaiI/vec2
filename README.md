# vec2
Vec2 module using FFI

This was written in the Love game engine, wich uses luajit

usage:
vec2 = require "vec2"
local vec = vec2.new(10,10)

Most methods have a capital 1st letter variant, those modify the original vector instead of creating a new one
<style>
  .list = {
    list-style-type:none;
  }
</style>
methods:
 <ul class = "list">
  <li>getLength(vec) : returns its length</li>
  <li>n/Normalise(vec) : returns a/Converts to unitvector</li>
  <li>g/GetNormal(vec) : returns the normal vector to vec</li>
  <li></li>
  <li>v1+v2 (\__add) / v1:Add(v2) : add 2 vectors</li>
  <li>v1-v2 (\__sub) / v1:Sub(v2) : subtraction</li>
  <li></li>
  <li>v1\*v2 / : dot product</li>
  <li>v1/v2 : cross product</li>
  <li>v1%v2 / v1:Project(v2) : projects v2 onto v1</li>
  <li></li>
  <li>s/Scale(number) : multiply the vectors components by number</li>
  <li>d/Div(number) : divide the vectors components by number</li>
  <li></li>
  <li>v1 = -v1 (\__unm) / v1:Negate() : negates the vector</li>
  <li>r/Rotate(angleinRad) : rotates the vector</li>
 </ul>
 
 comparision:
 <ul style = "list-style-type:none;">
  <li>v1 == v2 : checks if both coordinates are the same</li>
  <li>v1 <,<= v2 : compares getLength of the vectors</li>
 <ul>

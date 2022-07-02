local Entity = require 'entity'
local Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, 'wall.png')
  self.strength = 100
  self.tempStrength = self.strength
end

return Wall

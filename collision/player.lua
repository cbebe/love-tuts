local Entity = require 'entity'

local Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, 'player.png')
end

return Player

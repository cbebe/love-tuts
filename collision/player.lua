local Entity = require 'entity'
local Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, 'player.png')
end

local down = love.keyboard.isDown

function Player:update(dt)
  Player.super.update(self, dt)

  if down('left') then
    self.x = self.x - 200 * dt
  elseif down('right') then
    self.x = self.x + 200 * dt
  end

  if down('up') then
    self.y = self.y - 200 * dt
  elseif down('down') then
    self.y = self.y + 200 * dt
  end
end

return Player

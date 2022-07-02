local Entity = require 'entity'
local Box = require 'box'
local Player = Entity:extend()

function Player:new(x, y)
  Player.super.new(self, x, y, 'player.png')
  self.strength = 10
  self.tempStrength = self.strength
  self.canJump = false
end

local down = love.keyboard.isDown

function Player:update(dt)
  Player.super.update(self, dt)

  if down('left') then
    self.x = self.x - 200 * dt
  elseif down('right') then
    self.x = self.x + 200 * dt
  end

  if self.last.y ~= self.y then
    self.canJump = false
  end
end

function Player:jump()
  if self.canJump then
    self.gravity = -300
    self.canJump = false
  end
end

function Player:collide(e, direction)
  Player.super.collide(self, e, direction)
  if direction == "bottom" then
    self.canJump = true
  end
end

function Player:checkResolve(e, direction)
  if e:is(Box) then
    return direction == "bottom"
  end
  return true
end

return Player

local Object = require 'classic'
local Entity = Object:extend()

function Entity:new(x, y, imagePath)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(imagePath)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.last = {}
  self.last.x = self.x
  self.last.y = self.y

  self.strength = 0
  self.tempStrength = self.strength
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  self.tempStrength = self.strength
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

local function entityWasHorizontallyAligned(self, e)
  return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

local function entityWasVerticallyAligned(self, e)
  return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

local function handleVerticalPushback(self, e)
  if self.x + self.width/2 < e.x + e.width/2 then
    local pushback = self.x + self.width - e.x
    self.x = self.x - pushback
  else
    local pushback = e.x + e.width - self.x
    self.x = self.x + pushback
  end
end

local function handleHorizontalPushback(self, e)
  if self.y + self.height/2 < e.y + e.height/2 then
    local pushback = self.y + self.height - e.y
    self.y = self.y - pushback
  else
    local pushback = e.y + e.height - self.y
    self.y = self.y + pushback
  end
end

local function entityCheckCollision(self, e)
  return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

function Entity:resolveCollision(e)
  if self.tempStrength > e.tempStrength then
    return e:resolveCollision(self)
  end

  if entityCheckCollision(self, e) then
    self.tempStrength = e.tempStrength
    if entityWasVerticallyAligned(self, e) then
      handleVerticalPushback(self, e)
    elseif entityWasHorizontallyAligned(self, e) then
      handleHorizontalPushback(self, e)
    end
    return true
  end
  return false
end

return Entity

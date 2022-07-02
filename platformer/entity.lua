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

  self.gravity = 0
  self.weight = 400
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  self.tempStrength = self.strength

  self.gravity = self.gravity + self.weight * dt
  self.y = self.y + self.gravity * dt
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

function Entity:collide(e, direction)
  if direction == "right" then
    local pushback = self.x + self.width - e.x
    self.x = self.x - pushback
  elseif direction == "left" then
    local pushback = e.x + e.width - self.x
    self.x = self.x + pushback
  elseif direction == "bottom" then
    local pushback = self.y + self.height - e.y
    self.y = self.y - pushback
    self.gravity = 0
  elseif direction == "top" then
    local pushback = e.y + e.height - self.y
    self.y = self.y + pushback
  end
end

local function resolveCollisionCheck(self, e, dir, opp)
  local a = self:checkResolve(e, dir)
  local b = e:checkResolve(self, opp)
  if a and b then
    self:collide(e, dir)
  end
end

local function handleVerticalPushback(self, e)
  if self.x + self.width/2 < e.x + e.width/2 then
    resolveCollisionCheck(self, e, "right", "left")
  else
    resolveCollisionCheck(self, e, "left", "right")
  end
end

local function handleHorizontalPushback(self, e)
  if self.y + self.height/2 < e.y + e.height/2 then
    resolveCollisionCheck(self, e, "bottom", "top")
  else
    resolveCollisionCheck(self, e, "top", "bottom")
  end
end

function Entity:checkResolve(e, direction)
  return true
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

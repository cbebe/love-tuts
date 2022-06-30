Player = Entity:extend()

function Player:new(x, y, size, image)
  Player.super.new(self, x, y, size, image)
  self.shake = {
    duration = 0,
    wait = 0,
    offset = { x = 0, y = 0 }
  }
  self.score = 0
end

function Player:update(dt)
  if self.shake.duration > 0 then
    self.shake.duration = self.shake.duration - dt
    if self.shake.wait > 0 then
      self.shake.wait = self.shake.wait - dt
    else
      self.shake.offset.x = love.math.random(-5,5)
      self.shake.offset.y = love.math.random(-5,5)
      self.shake.wait = 0.05
    end
  end

  if love.keyboard.isDown('left') then
    self.x = self.x - 200 * dt
  elseif love.keyboard.isDown('right') then
    self.x = self.x + 200 * dt
  end

  if love.keyboard.isDown('up') then
    self.y = self.y - 200 * dt
  elseif love.keyboard.isDown('down') then
    self.y = self.y + 200 * dt
  end
end

function Player:checkCoin(coin)
  local collide = self:checkCollision(coin)
  if collide then
    self.size = player.size + 1
    self.score = player.score + 1
    self.shake.duration = 0.15
  end

  return collide
end

function Player:draw()
  love.graphics.translate(-self.x + 400, -self.y + 300)
  if self.shake.duration > 0 then
    love.graphics.translate(self.shake.offset.x, self.shake.offset.y)
  end

  Player.super.draw(self)
end

function Player:load(data)
  self.x = data.x
  self.y = data.y
  self.size = data.size
  self.score = data.score
end

function Player:save()
  return {
    x = self.x,
    y = self.y,
    size = self.size,
    score = self.score
  }
end

Bullet = Object:extend()

function Bullet:new(x, y)
  self.image = love.graphics.newImage 'bullet.png'
  self.x = x
  self.y = y
  self.speed = 700
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Bullet:checkCollision(obj)
  local s_left, s_right, s_top, s_bottom =
    self.x, self.x + self.width, self.y, self.y + self.height
  local o_left, o_right, o_top, o_bottom =
    obj.x, obj.x + obj.width, obj.y, obj.y + obj.height

  if s_right > o_left and s_left < o_right and s_bottom > o_top and s_top < o_bottom then
    self.dead = true
    local increase = obj.speed > 0 and 50 or -50
    obj.speed = obj.speed + increase
  end
end

function Bullet:update(dt)
  self.y = self.y + self.speed * dt

  if self.y > love.graphics.getHeight() then
    love.load()
  end
end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y)
end


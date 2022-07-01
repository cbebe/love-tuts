Entity = Object:extend()

function Entity:new(x, y, size, image)
  self.x = x
  self.y = y
  self.size = size
  self.image = image
end

function Entity:draw()
  love.graphics.circle('line', self.x, self.y, self.size)
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1,
    self.image:getWidth()/2, self.image:getHeight()/2)
end

function Entity:checkCollision(target)
  return math.sqrt(
    (self.x - target.x)^2 + (self.y - target.y)^2
  ) < self.size + target.size
end


local circle, arrow, mouse_x, mouse_y
function love.load()
  circle = {}
  circle.x = 100
  circle.y = 100
  circle.radius = 25
  circle.speed = 200


  arrow = {}
  arrow.x = 200
  arrow.y = 200
  arrow.speed = 300
  arrow.angle = 0
  arrow.image = love.graphics.newImage('arrow_right.png', nil)
  arrow.origin_x = arrow.image:getWidth() / 2
  arrow.origin_y = arrow.image:getHeight() / 2
end

function love.update(dt)
  mouse_x, mouse_y = love.mouse.getPosition()
  arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
  local cos = math.cos(arrow.angle)
  local sin = math.sin(arrow.angle)

  arrow.x = arrow.x + arrow.speed * cos * dt
  arrow.y = arrow.y + arrow.speed * sin * dt
end

function love.draw()
  love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1,
    arrow.origin_x, arrow.origin_y)
  love.graphics.circle('fill', mouse_x, mouse_y, 5)
end

function love.load()
  Object = require 'classic'
  require 'player'
  love.window.setTitle('Shoot the Enemy')
  love.window.setMode(500, 500)

  p = Player()
end

function love.update(dt)
  p:update(dt)
end

function love.draw()
  p:draw()
end

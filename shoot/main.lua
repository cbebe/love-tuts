function love.load()
  Object = require 'classic'
  require 'player'
  require 'enemy'
  love.window.setTitle('Shoot the Enemy')

  p = Player()
  e = Enemy()
end

function love.update(dt)
  p:update(dt)
  e:update(dt)
end

function love.draw()
  p:draw()
  e:draw()
end

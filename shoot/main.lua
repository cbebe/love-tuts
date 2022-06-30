function love.load()
  Object = require 'classic'
  require 'player'
  require 'enemy'
  require 'bullet'
  love.window.setTitle('Shoot the Enemy')

  p = Player()
  e = Enemy()
  bulletList = {}
end

function love.keypressed(key)
  p:keyPressed(key)
end

function love.update(dt)
  p:update(dt)
  e:update(dt)

  for i,v in ipairs(bulletList) do
    v:update(dt)
  end
end

function love.draw()
  p:draw()
  e:draw()

  for i,v in ipairs(bulletList) do
    v:draw(dt)
  end
end

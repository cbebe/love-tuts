function love.load()
  Object = require 'classic'
  require 'player'
  require 'enemy'
  require 'bullet'

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
    v:checkCollision(e)

    if v.dead then
      table.remove(bulletList, i)
    end
  end
end

function love.draw()
  p:draw()
  e:draw()

  for i,v in ipairs(bulletList) do
    v:draw(dt)
  end
end

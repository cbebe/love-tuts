function love.load()
  player = require 'player' (100, 100)
  wall = require 'wall' (200, 100)
end

function love.update(dt)
  player:update(dt)
  wall:update(dt)
end

function love.draw()
  player:draw(dt)
  wall:draw(dt)
  player:resolveCollision(wall)
end

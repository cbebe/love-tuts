function love.load()
  local player = require 'player' (100, 100)
  local wall = require 'wall' (200, 100)
  local Box = require 'box'
  local box1 = Box(400, 150)
  local box2 = Box(500, 150)
  objects = {}
  table.insert(objects, player)
  table.insert(objects, wall)
  table.insert(objects, box1)
  table.insert(objects, box2)
end

function love.update(dt)
  for i,v in ipairs(objects) do
    v:update(dt)
  end

  local loop = true
  local limit = 0
  while loop do
    loop = false
    limit = limit + 1
    if limit > 100 then break end
    for i=1,#objects-1 do
      for j=i+1,#objects do
        local collision = objects[i]:resolveCollision(objects[j])
        if collision then
          loop = true
        end
      end
    end
  end
end

function love.draw()
  for i,v in ipairs(objects) do
    v:draw()
  end
end

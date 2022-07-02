function love.load()
  local Player = require 'player'
  local Wall = require 'wall'
  local Box = require 'box'

  local player = Player(100, 100)
  local box = Box(550, 150)

  objects = {}
  table.insert(objects, player)
  table.insert(objects, box)

  map = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  }

  walls = {}
  for i,v in ipairs(map) do
    for j,w in ipairs(v) do
      if w == 1 then
        table.insert(walls, Wall((j-1)*50, (i-1)*50))
      end
    end
  end

end

function love.update(dt)
  for i,v in ipairs(objects) do
    v:update(dt)
  end

  for i,v in ipairs(walls) do
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

    for i,wall in ipairs(walls) do
      for j,object in ipairs(objects) do
        local collision = object:resolveCollision(wall)
        if collision then
          loop = true
        end
      end
    end
  end
end

function love.keypressed(key)
  if key == "space" then
    objects[1]:jump()
  end
end

function love.draw()
  for i,v in ipairs(objects) do
    v:draw()
  end
  for i,v in ipairs(walls) do
    v:draw()
  end
end

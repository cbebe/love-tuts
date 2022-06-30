function love.load()
  fruits = { "apple", "orange", "banana" }
  idx = 1
  x = 100
  y = 50
end

function love.update(dt)
  if love.keyboard.isDown("1") then
    idx = idx + 1
    if idx > table.getn(fruits) then
      idx = 1
    end

  elseif love.keyboard.isDown("2") then
    idx = idx - 1
    if idx < 1 then
      idx = table.getn(fruits)
    end
  end
  if love.keyboard.isDown("right") then
      x = x + 100 * dt
  elseif love.keyboard.isDown("left") then
      x = x - 100 * dt
  elseif love.keyboard.isDown("down") then
      y = y + 100 * dt
  elseif love.keyboard.isDown("up") then
      y = y - 100 * dt
  end
end

function love.draw()
  love.graphics.rectangle("line", x, y, 200, 150)
  love.graphics.print(fruits[idx], 100, 100)
end

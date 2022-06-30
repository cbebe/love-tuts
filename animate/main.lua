function love.load()
  image = love.graphics.newImage "jump.png"
  local width, height = image:getWidth(), image:getHeight()
  frames = {}
  local frame_width, frame_height = 117, 233

  local maxFrames = 5
  for i=0,1 do
    for j=0,2 do
      table.insert(frames, love.graphics.newQuad(
        1 + j * (frame_width + 2), 1 + i * (frame_height + 2),
        frame_width, frame_height, width, height)
      )
      if #frames == maxFrames then break end
    end
  end

  currentFrame = 1
end

function love.update(dt)
  currentFrame = currentFrame + 10 * dt
  if currentFrame >= 6 then
    currentFrame = 1
  end
end

function love.draw()
  love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)
end

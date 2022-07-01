function love.load()
  fileName = 'savedata.txt'
  lume = require 'lume'
  Entity = require 'entity'
  screenCanvas = love.graphics.newCanvas(400, 600)
  local Player = require 'player'

  local playerImage = love.graphics.newImage('face.png')
  local player1Controls = {
    up = 'up',
    left = 'left',
    down = 'down',
    right = 'right',
  }
  local player2Controls = {
    up = 'w',
    left = 'a',
    down = 's',
    right = 'd',
  }
  player1 = Player(100, 100, 25, playerImage, player1Controls)
  player2 = Player(300, 100, 25, playerImage, player2Controls)

  coins = {}
  coinImage = love.graphics.newImage('dollar.png')
  if love.filesystem.getInfo(fileName) then
    loadFile(coinImage)
  else
    generateCoins(coinImage)
  end
end

function loadFile(coinImage)
  local file = love.filesystem.read(fileName)
  local data = lume.deserialize(file)
  player1:load(data.player1)
  player2:load(data.player2)
  for i,v in ipairs(data.coins) do
    coins[i] = Entity(v.x, v.y, 10, coinImage)
  end
end

function generateCoins(coinImage)
  for i=1,25 do
    local coin = Entity(
      love.math.random(50 ,650),
      love.math.random(50 ,450),
      10,
      coinImage
    )
    table.insert(coins, coin)
  end
end

function love.update(dt)
  player1:update(dt)
  player2:update(dt)

  for i=#coins,1,-1 do
    if player1:checkCoin(coins[i]) or player2:checkCoin(coins[i]) then
      table.remove(coins, i)
    end
  end
  if #coins == 0 then
    generateCoins(coinImage)
  end
end

function love.draw()
  drawGame(player1)
  drawGame(player2, 400)
  love.graphics.line(400, 0, 400, 600)
  love.graphics.print('Player 1: ' .. player1.score, 10, 10)
  love.graphics.print('Player 2: ' .. player2.score, 10, 30)
end

function drawGame(focus, off)
  love.graphics.setCanvas(screenCanvas)
    love.graphics.clear()
    love.graphics.push()
      love.graphics.translate(-focus.x + 200, -focus.y + 300)
      player1:draw()
      player2:draw()
      for i,v in ipairs(coins) do
        v:draw()
      end
    love.graphics.pop()
  love.graphics.setCanvas()
  love.graphics.draw(screenCanvas, off)
end

function saveGame()
  local data = {}
  data.player1 = player1:save()
  data.player2 = player2:save()
  data.coins = {}
  for i,v in ipairs(coins) do
    data.coins[i] = { x = v.x, y = v.y }
  end
  local serialized = lume.serialize(data)
  love.filesystem.write(fileName, serialized)
end

function love.keypressed(key)
  if key == 'f1' then
    saveGame()
  elseif key == "f2" then
    love.filesystem.remove(fileName)
    love.event.quit("restart")
  end
end

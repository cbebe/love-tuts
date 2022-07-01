function love.load()
  Object = require 'classic'
  lume = require 'lume'
  require 'entity'
  require 'player'

  local playerImage = love.graphics.newImage('face.png')
  player = Player(100, 100, 25, playerImage)

  coins = {}
  local coinImage = love.graphics.newImage('dollar.png')
  if love.filesystem.getInfo("savedata.txt") then
    loadFile(coinImage)
  else
    generateCoins(coinImage)
  end
end

function loadFile(coinImage)
  file = love.filesystem.read("savedata.txt")
  data = lume.deserialize(file)
  player:load(data.player)
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
  player:update(dt)

  for i=#coins,1,-1 do
    if player:checkCoin(coins[i]) then
      table.remove(coins, i)
    end
  end
end

function love.draw()
  love.graphics.push()
    player:draw()
    for i,v in ipairs(coins) do
      v:draw()
    end
  love.graphics.pop()
  love.graphics.print(player.score, 10, 10)
end

function saveGame()
  local data = {}
  data.player = player:save()
  data.coins = {}
  for i,v in ipairs(coins) do
    data.coins[i] = { x = v.x, y = v.y }
  end
  local serialized = lume.serialize(data)
  love.filesystem.write('savedata.txt', serialized)
end

function love.keypressed(key)
  if key == 'f1' then
    saveGame()
  elseif key == "f2" then
    love.filesystem.remove("savedata.txt")
    love.event.quit("restart")
  end
end

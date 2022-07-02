local Object = require 'classic'
local Entity = require 'entity'
local Game = Object:extend()
local lume = require 'lume'

local function loadGame(self)
  local file = love.filesystem.read(self.fileName)
  local data = lume.deserialize(file)
  for i=1,#self.players do
    if data.players[i] ~= nil then
      self.players[i]:load(data.players[i])
    end
  end
  for i,v in ipairs(data.coins) do
    self.coins[i] = Entity(v.x, v.y, 10, self.coinImage)
  end
end

local function generateCoins(self)
  for i=1,25 do
    local coin = Entity(
      love.math.random(50 ,650),
      love.math.random(50 ,450),
      10,
      self.coinImage
    )
    table.insert(self.coins, coin)
  end
end

function Game:new(fileName, coinImage, players)
  self.screenCanvas = love.graphics.newCanvas(400, 600)
  self.fileName = fileName
  self.players = players
  self.coinImage = coinImage
  self.coins = {}
  if love.filesystem.getInfo(self.fileName) then
    loadGame(self)
  else
    generateCoins(self)
  end
end



local function any(arr, fn)
  for i,v in ipairs(arr) do
    if fn(v) then
      return true
    end
  end
  return false
end


function Game:update(dt)
  for i,v in ipairs(self.players) do
    v:update(dt)
  end

  for i=#self.coins,1,-1 do
    if any(self.players, function (p)
      return p:checkCoin(self.coins[i])
    end) then
      table.remove(self.coins, i)
    end
  end
  if #self.coins == 0 then
    generateCoins(self)
  end
end
function Game:save()
  local data = {}
  data.players = {}
  for i,v in ipairs(self.players) do
    data.players[i] = v:save()
  end
  data.coins = {}
  for i,v in ipairs(self.coins) do
    data.coins[i] = { x = v.x, y = v.y }
  end
  local serialized = lume.serialize(data)
  love.filesystem.write(self.fileName, serialized)
end

function Game:reset()
  love.filesystem.remove(self.fileName)
  love.event.quit("restart")
end

function Game:drawPlayerScreen(focus, off)
  love.graphics.setCanvas(self.screenCanvas)
    love.graphics.clear()
    love.graphics.push()
      local p = self.players[focus]
      love.graphics.translate(-p.x + 200, -p.y + 300)
      for i,v in ipairs(self.players) do
        v:draw()
      end
      for i,v in ipairs(self.coins) do
        v:draw()
      end
    love.graphics.pop()
  love.graphics.setCanvas()
  love.graphics.draw(self.screenCanvas, off)
end


return Game

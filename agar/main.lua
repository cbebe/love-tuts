local game

function love.load()
  local fileName = 'savedata.txt'
  local Player = require 'player'
  local playerImage = love.graphics.newImage('face.png', nil)
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
  local player1 = Player(100, 100, 25, playerImage, player1Controls)
  local player2 = Player(300, 100, 25, playerImage, player2Controls)
  local coinImage = love.graphics.newImage('dollar.png', nil)
  game = require'game'(fileName, coinImage, {player1, player2})
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:drawPlayerScreen(1)
  game:drawPlayerScreen(2, 400)
  love.graphics.line(400, 0, 400, 600)
  for i=1,#game.players do
    local line = 'Player ' .. i .. ': ' .. game.players[i].score
    love.graphics.print(line, 10, 10 + (i - 1) * 20)
  end
end


function love.keypressed(key)
  if key == 'f1' then
    game:save()
  elseif key == "f2" then
    game:reset()
  end
end

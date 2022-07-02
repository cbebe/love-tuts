local circle, bullets

function love.load()
    circle = {x = 100, y = 100}
    bullets = {}
end

function love.update(dt)
    for _,v in ipairs(bullets) do
        v.x = v.x + 400 * dt
    end
end

function love.draw()
    love.graphics.circle("fill", circle.x, circle.y, 50)

    for _,v in ipairs(bullets) do
        love.graphics.circle("fill", v.x, v.y, 10)
    end
end


local function shoot()
    table.insert(bullets, { x = circle.x, y = circle.y })
end

function love.keypressed(key)
    if key == "space" then
        shoot()
    end
end


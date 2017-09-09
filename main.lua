function love.load()
    time = 1
    grid = {
        w = 10,
        h = 7
    }
    fonts = {
        h = love.graphics.newFont("font/Leokadia.ttf", 30),
        b = love.graphics.newFont("font/Sunday-Regular.otf", 30),
        f = love.graphics.newFont("font/Pecita.otf", 30)
    }
end

function love.update(dt)
end

function love.draw()
    love.graphics.setFont(fonts.h)
    love.graphics.print("text", 0, 0)
    love.graphics.setFont(fonts.b)
    love.graphics.print("text", 0, 100)
    love.graphics.setFont(fonts.f)
end
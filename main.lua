function love.load()
    love.window.setFullscreen(true)
    lib = love.filesystem.load("kiselev.lib.lua")
    menu = love.filesystem.load("menu.lua")    
    lib()
    grid = {
        w = 2500,
        h = 1500
    }
    fonts = {
        h = love.graphics.newFont("font/Sunday-Regular.otf", 200),
        b = love.graphics.newFont("font/Nickainley-Normal.otf", 150),
        f = love.graphics.newFont("font/Pecita.otf", 75)
    }
    colors = {
        l = hc("#ffffff"), -- light
        d = hc("#111119"), -- dark
        g = hc("#576C4E"), -- green
        b = hc("#788998"), -- blue
        r = hc("#cf4332")  -- red
    }
    fit()
    love.graphics.setDefaultFilter("linear")
    function update(dt)
        if time == nil then
            time = dt
        else
            time = time + dt
        end
        if load ~= nil and time > 1 then
            menu()
            load()
        end
    end
    function draw()
        love.graphics.setBackgroundColor(colors.d)
        if fonts.f ~= nil then
            love.graphics.setFont(fonts.f)
            love.graphics.printf("Loading...", 0, 710, 2500, "center")
        end
    end
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if update ~= nil then
        update(dt)
    end    
end

function love.draw()
    drawfit()
    draw()
    meshfit()
end
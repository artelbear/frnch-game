-- Menu by kiselev nikolay
-- Just part of project


function load()
    time = 0
    kr = images.kr[love.math.random(#images.kr)]    

    
    menu = {
        head = {
            Color = colors.l,
            Text = love.graphics.newText(fonts.h)
        },
        start = {
            Color = colors.l,
            Text = love.graphics.newText(fonts.b)
        },
        exit = {
            Color = colors.l,
            Text = love.graphics.newText(fonts.b)
        },
        about = {
            Color = colors.l,
            Text = love.graphics.newText(fonts.f)
        }
    }
    
    menu.head.w = 2400
    menu.start.w = 700
    menu.exit.w = 300
    menu.about.w = 500
    
    menu.head.Text:setf("douceur sur l'eau", menu.head.w, "center")
    menu.start.Text:setf("Start game", menu.start.w, "center")
    menu.exit.Text:setf("Exit", menu.exit.w, "center")
    menu.about.Text:setf("by Artel Bear --1", menu.about.w, "right")
    
    menu.head.x = 50
    menu.head.y = 50

    menu.start.x = 900
    menu.start.y = 375

    menu.exit.x = 1050
    menu.exit.y = 575

    menu.about.x = 1900
    menu.about.y = 1400


    menu.start.fun = function()
        load_start = love.filesystem.load("load_start.lua")
        load_start()
        load()
    end

    menu.exit.fun = function()
        love.event.quit()
    end

    menu.about.fun = function()
        love.system.openURL("http://the.artelbear.space/")
    end


    rain = {}

    background = love.graphics.newImage("img/bg.jpg")
end


function update(dt)
    time = time + dt
    normalTime = math.floor(time * 55)
    
    if normalTime ~= step then
        step = normalTime
    
        if step % 10 == 0 then
            rain[#rain + 1] = {}
            rain[#rain].i = love.math.random(7)
            rain[#rain].x = love.math.random(0, grid.w)
            rain[#rain].y = -rain[#rain].i / 2
            rain[#rain].f = true
        end

        if step % 1 == 0 then
            for i, drop in ipairs(rain) do
                if drop.y < grid.h * 1.3 then
                    drop.y = drop.y + 5
                    if i % 2 == 0 then
                        drop.x = drop.x + 0.5
                    else
                        drop.x = drop.x - 0.5
                    end
                else
                    drop.f = false
                end
            end
        end        
    
    end

    
    for key, val in pairs(menu) do
        if val ~= nil and val.fun ~= nil then
            x, y = mou()
            if x ~= nil and y ~= nil and x >= val.x and x <= val.x + val.w and y >= val.y and y <= val.y + val.Text:getHeight() then
                val.Color = colors.r
                if love.mouse.isDown(1) then
                    val.fun()
                    val.fun = nil
                    val.Color = colors.l
                end
            else
                val.Color = colors.l
            end
        end
    end
end


function draw()
    love.graphics.setColor(255, 255, 255, 100)
    love.graphics.draw(background)

    love.graphics.setLineWidth(15)
    for i, drop in ipairs(rain) do
        if drop.f then
            love.graphics.setColor(colors.b)
            love.graphics.circle("line", drop.x, drop.y, drop.i)
            love.graphics.circle("fill", drop.x, drop.y, drop.i)
        end
    end

    love.graphics.setColor(menu.head.Color)
    love.graphics.draw(menu.head.Text, menu.head.x, menu.head.y)

    love.graphics.setColor(menu.start.Color)
    love.graphics.draw(menu.start.Text, menu.start.x, menu.start.y)

    love.graphics.setColor(menu.exit.Color)
    love.graphics.draw(menu.exit.Text, menu.exit.x, menu.exit.y)

    love.graphics.setColor(menu.about.Color)
    love.graphics.draw(menu.about.Text, menu.about.x, menu.about.y)
end
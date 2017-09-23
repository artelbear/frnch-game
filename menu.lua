-- Menu by kiselev nikolay
-- Just part of project


function load()
    time = 0

    
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
    menu.about.Text:setf("by Artel Bear", menu.about.w, "right")
    
    menu.head.x = 50
    menu.head.y = 50

    menu.start.x = 900
    menu.start.y = 375

    menu.exit.x = 1050
    menu.exit.y = 575

    menu.about.x = 1900
    menu.about.y = 1350


    menu.start.fun = function()
        start = love.filesystem.load("start.lua")
        start()
        load()
    end

    menu.exit.fun = function()
        love.event.quit()
    end

    menu.about.fun = function()
        love.system.openURL("http://the.artelbear.space/")
    end


    wawe = 0
    waweStep = 0.1

    local em = {}
    em.w = grid.w / 50
    em.h = grid.h / 50
    line = {}
    for j = 0, 50 do
        for i = 0, 50 do
            line[#line+1] = em.w * i
            line[#line+1] = em.h * j
        end
    end
    print(table.concat(line, "), ("))
end

function update(dt)
    time = time + dt
    normalTime = math.floor(time * 1000)
    if normalTime ~= step then
        step = normalTime
        if step % 2 == 0 then
            -- PLACE FOR CURVE OF WAWESTEP
            if wawe < -5 or wawe > 5 then
                waweStep = -waweStep
            end
            wawe = wawe + waweStep
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
    love.graphics.setColor(colors.l)
    love.graphics.setBackgroundColor(colors.d)
    love.graphics.setColor(colors.b)
    love.graphics.line()
    love.graphics.setColor(menu.head.Color)
    love.graphics.draw(menu.head.Text, menu.head.x + wawe, menu.head.y)
    love.graphics.setColor(menu.start.Color)
    love.graphics.draw(menu.start.Text, menu.start.x - wawe, menu.start.y)
    love.graphics.setColor(menu.exit.Color)
    love.graphics.draw(menu.exit.Text, menu.exit.x + wawe, menu.exit.y)
    love.graphics.setColor(menu.about.Color)
    love.graphics.draw(menu.about.Text, menu.about.x - wawe, menu.about.y)
end
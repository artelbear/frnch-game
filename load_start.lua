-- Main by kiselev nikolay
-- Just part of project


function load()
    time = 0

    function draw()
        love.graphics.setBackgroundColor(colors.d)
        if fonts.f ~= nil then
            love.graphics.setFont(fonts.f)
            love.graphics.printf("Loading...", 0, 1210, 1500, "center")
        end
    end

    startit = love.filesystem.load("start.lua")

    images = {}
    loadFolder("sh", "bargas")
    loadFolder("bl", "content")
    loadInFolder("br", "content")

    function update(dt)
        if time == nil then
            time = dt
        else
            time = time + dt
        end
        if load ~= nil and time > 1 then
            startit()
            load()
        end
    end
end

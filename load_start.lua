-- Main by kiselev nikolay
-- Just part of project


function load()
    time = 0

    function draw()
        love.graphics.setBackgroundColor(colors.d)
        if fonts.f ~= nil then
            love.graphics.setFont(fonts.f)
            love.graphics.printf("Loading...", 0, 710, 2500, "center")
        end
    end
    
    startit = love.filesystem.load("start.lua")    
    
    images = {}
    images.bargas = {}
    local files = love.filesystem.getDirectoryItems("img/sh")
    for i, v in ipairs(files) do
        vname = fur.split(v, ".")
        vname = vname[1]
        images.bargas[vname] = love.graphics.newImage("img/sh/" .. v)
    end

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

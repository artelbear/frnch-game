-- COPYRIGHT: KISELEV 2017
-- Licence: MIT

if grid == nil then
    grid = {
        w = 600,
        h = 600
    }
end

function mou(x, y)
	if x == nil or y == nil then
		x, y = love.mouse.getPosition()
	end
	local w, h = love.window.getMode()
	local nx = x / s - fortouch[1]
	local ny = y / s - fortouch[2]
	if nx >= 0 and ny >= 0 and nx <= grid.w and ny <= grid.h then
		return nx, ny
	else
		return nil, nil
	end		
end

function hc(hex)
	hex = hex:gsub("#","")
	return {tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))}
end

function fit()
	local w, h = love.window.getMode()
	if w / grid.w < h / grid.h then
		s = w / grid.w
		t = {0, (h / s - grid.h) / 2}
	else
		s = h / grid.h
		t = {(w / s - grid.w) / 2, 0}
	end
    backimg = love.graphics.newImage(".bmp")
    backimg:setWrap("repeat")
    backimg:setFilter("nearest")
    local w, h = love.window.getMode()
    local iw, ih = backimg:getDimensions()
    iw = (iw / s) * 2
    ih = (ih / s) * 2
    if w / grid.w < h / grid.h then
        side = t[2]
        fortouch = {0, side}
        meshp = {x1 = 0, y1 = -side, x2 = 0, y2 = grid.h}
        vertices = {
            {0, 0, 0, 0, 255, 255, 255},
            {grid.w, 0, grid.w / iw, 0, 255, 255, 255},
            {grid.w, side, grid.w / iw, side / ih, 255, 255, 255},
            {0, side, 0, side / ih, 255, 255, 255}
        }
    else
        side = t[1]
        fortouch = {side, 0}
        meshp = {x1 = -side, y1 = 0, x2 = grid.w, y2 = 0}
        vertices = {
            {0, 0, 0, 0, 255, 255, 255},
            {side, 0, side / iw, 0, 255, 255, 255},
            {side, grid.h, side / iw, grid.h / ih, 255, 255, 255},
            {0, grid.h, 0, grid.h / ih, 255, 255, 255}
        }
    end
    mesh = love.graphics.newMesh(vertices, "fan")
    mesh:setTexture(backimg)
end

function love.arch(readyarch)
	if readyarch == nil then
		arch = {}
		arch[2] = love.draw
		love.draw = nil
		arch[6] = love.keypressed
		love.keypressed = nil
		arch[7] = love.keyreleased
		love.keyreleased = nil
		arch[10] = love.mousefocus
		love.mousefocus = nil
		arch[11] = love.mousemoved
		love.mousemoved = nil
		arch[12] = love.mousepressed
		love.mousepressed = nil
		arch[13] = love.mousereleased
		love.mousereleased = nil
		arch[14] = love.quit
		love.quit = nil
		arch[17] = love.textedited
		love.textedited = nil
		arch[18] = love.textinput
		love.textinput = nil
		arch[23] = love.update
		love.update = nil
		arch[25] = love.wheelmove
		love.wheelmove = nil
		return arch
	else
		love.draw = readyarch[2]
		love.keypressed = readyarch[6]
		love.keyreleased = readyarch[7]
		love.load = readyarch[8]
		love.mousefocus = readyarch[10]
		love.mousemoved = readyarch[11]
		love.mousepressed = readyarch[12]
		love.mousereleased = readyarch[13]
		love.quit = readyarch[14]
		love.textedited = readyarch[17]
		love.textinput = readyarch[18]
		love.update = readyarch[23]
		love.wheelmove = readyarch[25]
	end
end

function drawfit()
	love.graphics.scale(s, s)
	love.graphics.translate(t[1], t[2])
end

function meshfit()
    love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(mesh, meshp.x1, meshp.y1)
	love.graphics.draw(mesh, meshp.x2, meshp.y2)
end
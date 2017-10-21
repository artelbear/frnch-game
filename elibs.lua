-- elibs by kiselev nikolay
-- Just part of project

do --init
  print("ELIBS IS INIT")

  game = {}
  game.map = {}

  player = {}
  scale = 0.5
end

function game.add(posx, posy, sprite)
  n = #player + 1
  if sprite == nil then sprite = "shfirst" end
  player[n] = {}
  player[n].i = images.bargas[sprite]
  player[n].w = player[n].i:getWidth() * 0.6
  player[n].h = player[n].i:getHeight() * 0.6
  player[n].b = love.physics.newBody(world, posx * wid - wid / 2, posy * hid - hid / 2, "dynamic")
  player[n].s = love.physics.newRectangleShape(player[n].w, player[n].h)
  player[n].f = love.physics.newFixture(player[n].b, player[n].s)
  player[n].b:setAngle(math.rad(-90))
end

function game.autodraw()
  local coloR = {love.graphics.getColor()}
  for i, v in ipairs(player) do
    -- love.graphics.setColor(coloR)
    -- love.graphics.polygon("line", v.b:getWorldPoints(v.s:getPoints()))
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), 0.6, 0.6, v.w / 1.2, v.h / 1.2)
  end
  for y, line in ipairs(map) do
    for x, content in ipairs(line) do
      if hasTV(invisible, content) then
        local x = x - 1
        local y = y - 1
        local im = images.content[content]
        if im ~= nil then
          love.graphics.setColor(255, 255, 255, 255)
          love.graphics.draw(images.content[content], x * wid, y * hid, 0, wid / im:getWidth(), hid / im:getHeight())
        else
          love.graphics.setColor(coloR)
          love.graphics.rectangle("line", x * wid, y * hid, wid, hid)
        end
      elseif content ~= "" then
        local x = x - 1
        local y = y - 1
        love.graphics.setColor(coloR)
        love.graphics.rectangle("fill", x * wid, y * hid, wid, hid)
        local im = images.content[content]
        if im ~= nil then
          love.graphics.setColor(255, 255, 255, 255)
          love.graphics.draw(images.content[content], x * wid, y * hid, 0, wid / im:getWidth(), hid / im:getHeight())
        end
      end
    end
  end
  love.graphics.setColor(coloR)
end

function game.map.size(w)
  local h = w * 1.66666666667
  h = math.floor(h)
  map = {}
  for y = 1, h do
    map[y] = {}
    for x = 1, w do
      map[y][x] = ""
    end
  end
  wid = grid.w / #map[1]
  hid = grid.h / #map
end

function game.map.set(content, ...)
  local dots = {...}
  for i = 1, #dots / 2 do
    local num = i * 2
    map[dots[num]][dots[num - 1]] = content
  end
end

function game.map.get(x, y)
  return map[y][x]
end

function game.map.print()
  for y, line in ipairs(map) do
    local s = ""
    for x, content in ipairs(line) do
      s = s .. content .. ", "
    end
    print(s)
  end
end

function game.map.electro(tab)
  local keys = keysTV(tab)
  game.map.size(#tab[1])
  for y, line in ipairs(tab) do
    for x, content in ipairs(line) do
      if content ~= "" then
        local thekey = ""
        while hasTV(invisible, thekey) do
          thekey = love.math.random(#keys)
          print(thekey)
        end
        game.map.set(thekey, x, y)
      end
    end
  end
end

function game.map.phy()
  obj = {}
  for y, line in ipairs(map) do
    for x, content in ipairs(line) do
      if content ~= "" and (not hasTV(invisible, content)) then
        local x = x - 1
        local y = y - 1
        local n = #obj + 1
        obj[n] = {}
        obj[n].b = love.physics.newBody(world, x * wid + wid / 2, y * hid + hid / 2, "static")
        obj[n].s = love.physics.newRectangleShape(wid, hid)
        obj[n].f = love.physics.newFixture(obj[n].b, obj[n].s)
      end
    end
  end
  return obj
end

function game.checkObj(obj)
  love.graphics.setColor(255, 0, 0)
  for i, v in ipairs(obj) do
    love.graphics.polygon("line", v.b:getWorldPoints(v.s:getPoints()))
  end
end

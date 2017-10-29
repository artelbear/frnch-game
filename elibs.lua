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
  player[n].scale = 3
  player[n].w = player[n].i:getWidth()
  player[n].h = player[n].i:getHeight()
  player[n].b = love.physics.newBody(world, posx * wid - wid / 2, posy * hid - hid / 2, "dynamic")
  player[n].s = love.physics.newRectangleShape(player[n].w / player[n].scale / 1.1, player[n].h / player[n].scale / 1.1)
  player[n].f = love.physics.newFixture(player[n].b, player[n].s)
  player[n].b:setMass(player[n].b:getMass() / 1500)
  player[n].b:setAngle(math.rad(-90))
  player[n].f:setRestitution(0.2)
end

function game.autodraw()
  love.graphics.push()
  if #player == 1 then
    love.graphics.scale(2, 2)
    dx = (-player[1].b:getX() + (grid.w / 4))
    dy = (-player[1].b:getY() + ((grid.h / 16 * 13) / 4))
    thedx = math.floor(dx)
    thedy = math.floor(dy)
    love.graphics.translate(thedx, thedy)
  end
  love.graphics.rectangle("fill", 0, 0, grid.w, grid.h / 16 * 13)
  local coloR = {love.graphics.getColor()}
  for i, v in ipairs(player) do
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), 1 / v.scale, 1 / v.scale, v.w / 2, v.h / 2)
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
        -- love.graphics.setColor(coloR)
        -- love.graphics.rectangle("fill", x * wid, y * hid, wid, hid)
        local im = images.content[content]
        if im ~= nil then
          love.graphics.setColor(255, 255, 255, 255)
          love.graphics.draw(images.content[content], x * wid, y * hid, 0, wid / im:getWidth(), hid / im:getHeight())
        end
      end
    end
  end
  if #player == 1 then
    love.graphics.pop()
  end
  love.graphics.setColor(coloR)
end

function game.winpoint(x, y)
  print("WIN" .. x .. "+" .. y)
end

function game.map.size(w)
  local h = w * 1.6
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
  local keys = keysTV(images.content)
  for y, line in ipairs(tab) do
    for x, content in ipairs(line) do
      if content == "w" then
        game.winpoint(x, y)
      elseif content == "=" then
        local thekey = love.math.random(#invisible)
        game.map.set(invisible[thekey], x, y)
      elseif content == "o" then
        local thekey = love.math.random(#keys)
        while hasTV(invisible, keys[thekey]) do
          thekey = love.math.random(#keys)
        end
        game.map.set(keys[thekey], x, y)
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

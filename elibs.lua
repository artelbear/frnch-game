-- elibs by kiselev nikolay
-- Just part of project

do --init
  print("ELIBS IS INIT")

  game = {}
  game.map = {}

  player = {}
  scale = 0.5

  map = {
    {"0", "0", "0", "0", "0", "0", "0"},
    {"0", "", "", "", "0", "w", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "0", "", "0"},
    {"0", "", "0", "", "", "", "0"},
    {"0", "", "0", "0", "0", "0", "0"}
  }

  wid = grid.w / #map[1]
  hid = grid.h / #map
end

function game.add(posx, posy, sprite)
  n = #player + 1
  if sprite == nil then sprite = "first" end
  player[n] = {}
  player[n].i = images.bargas[sprite]
  player[n].w = player[n].i:getWidth() * scale
  player[n].h = player[n].i:getHeight() * scale
  player[n].b = love.physics.newBody(world, posx * wid - wid / 2, posy * hid - hid / 2, "dynamic")
  player[n].s = love.physics.newRectangleShape(player[n].w, player[n].h)
  player[n].f = love.physics.newFixture(player[n].b, player[n].s)
  player[n].b:setAngle(math.rad(-90))
end

function game.autodraw()
  for i, v in ipairs(player) do
    -- love.graphics.polygon("line", v.b:getWorldPoints(v.s:getPoints()))
    love.graphics.draw(v.i, v.b:getX(), v.b:getY(), v.b:getAngle(), scale, scale, v.w, v.h)
  end
  for y, line in ipairs(map) do
    for x, content in ipairs(line) do
      if content ~= "" then
        local x = x - 1
        local y = y - 1
        local im = images.content[content]
        if im ~= nil then
          love.graphics.draw(images.content[content], x * wid, y * hid, 0, wid / im:getWidth(), hid / im:getHeight())
        else
          love.graphics.rectangle("fill", x * wid, y * hid, wid, hid)
        end
      end
    end
  end
end

function game.map.set(x, y, content)
  map[y][x] = content
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

function game.map.phy()
  obj = {}
  for y, line in ipairs(map) do
    for x, content in ipairs(line) do
      if content ~= "" then
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

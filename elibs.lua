-- elibs by kiselev nikolay
-- Just part of project

do --init
  print("ELIBS IS INIT")
  game = {}
  player = {}
  scale = 0.5
end

function game.map(table)
  if table == nil then
    map = {
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
      {"", "", "", "", "", "", "", "", "", "", "", "", "", "", ""},
    }
  end
end

function game.add(sprite)
  n = #player + 1
  if sprite == nil then sprite = "first" end
  player[n] = {}
  player[n].i = images.bargas[sprite]
  player[n].w = player[n].i:getWidth() / scale
  player[n].h = player[n].i:getHeight() / scale
  player[n].b = love.physics.newBody(world, grid.w / 2, grid.h / 2, "dynamic")
  player[n].s = love.physics.newRectangleShape(player[n].w, player[n].h)
  player[n].f = love.physics.newFixture(player[n].b, player[n].s)
  player[n].b:setAngle(-90)
  player[n].b:applyLinearImpulse(100, 0)
end

function game.autodraw()
  for i, v in ipairs(player) do
    local ox = v.w / 2
    local oy = v.h / 2
    local body = v.b
    love.graphics.draw(v.i, body:getX(), body:getY(), math.rad(body:getAngle()), scale, scale, ox, oy)
  end
end

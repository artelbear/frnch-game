-- Start by kiselev nikolay
-- Just part of project

function load()
  local elibs = love.filesystem.load("elibs.lua")
  elibs()

  love.physics.setMeter(1500)
  world = love.physics.newWorld(0, 0)
  borders = {}
  borders.b = love.physics.newBody(world, 0, 0, "static")
  borders.s = love.physics.newChainShape(true, 0, 0, grid.w, 0, grid.w, grid.h, 0, grid.h)
  borders.f = love.physics.newFixture(borders.b, borders.s)

  game.map.size(5)
  game.add(2, 8)

  electromap = {
    {"1", "", "", "", "1"},
    {"1", "1", "1", "", ""},
    {"1", "", "1", "1", ""},
    {"1", "", "", "", ""},
    {"1", "", "1", "", ""},
    {"1", "", "1", "", "1"},
    {"1", "", "1", "", ""},
    {"1", "", "1", "1", "1"}
  }

  game.map.electro(electromap)
  game.map.set("w", 2, 1)

  obj = game.map.phy()
end

function update(dt)
  world:update(dt)
  if love.keyboard.isDown("up") then
    local A = player[1].b:getAngle()
    player[1].b:applyForce(math.cos(A) * 10, math.sin(A) * 10)
  end
  if love.keyboard.isDown("right") then
    player[1].b:applyAngularImpulse(20)
  end
  if love.keyboard.isDown("left") then
    player[1].b:applyAngularImpulse(-20)
  end
end

function draw()
  -- love.graphics.setColor(colors.b)
  game.autodraw()
end

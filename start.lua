-- Start by kiselev nikolay
-- Just part of project

function load()
  local elibs = love.filesystem.load("elibs.lua")
  elibs()

  love.physics.setMeter(1500)
  world = love.physics.newWorld(0, 0)
  game.add(2, 11, "shfuture")
  obj = game.map.phy()

  game.map.set("w", 1, 1, 1, 2, 3, 3)
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
  game.autodraw()
end

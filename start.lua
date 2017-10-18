-- Start by kiselev nikolay
-- Just part of project

function load()
  local elibs = love.filesystem.load("elibs.lua")
  elibs()
  love.physics.setMeter(1500)
  world = love.physics.newWorld(0, 0)
  game.add()
end

function update(dt)
  world:update(dt)
end

function draw()
  game.autodraw()
end

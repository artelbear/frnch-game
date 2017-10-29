-- Start by kiselev nikolay
-- Just part of project

function load()
  local elibs = love.filesystem.load("elibs.lua")
  elibs()

  love.physics.setMeter(10)
  world = love.physics.newWorld(0, 0)
  borders = {}
  borders.b = love.physics.newBody(world, 0, 0, "static")
  borders.s = love.physics.newChainShape(true, 0, 0, grid.w, 0, grid.w, grid.h / 16 * 13, 0, grid.h / 16 * 13)
  borders.f = love.physics.newFixture(borders.b, borders.s)

  game.map.size(10)
  game.add(5, 9, "shfuture")

  electromap = {
    {" ", " ", " ", " ", " ", " ", "o", " ", "o", "o"},
    {" ", "o", "o", "o", "o", " ", " ", " ", " ", " "},
    {" ", " ", "o", " ", " ", " ", "o", "o", " ", "o"},
    {"o", " ", "o", "=", "o", " ", " ", " ", " ", " "},
    {"o", " ", "o", " ", "o", "o", "o", "o", "o", " "},
    {"o", " ", "o", " ", " ", " ", " ", " ", " ", " "},
    {"o", " ", "o", "o", "o", "o", "o", "o", "o", " "},
    {"o", " ", "o", "o", " ", " ", "o", "o", " ", " "},
    {"o", "=", "o", "o", " ", " ", " ", " ", " ", "o"},
    {"o", " ", "o", "o", " ", " ", "o", "=", "o", "o"},
    {"o", " ", "o", "o", "o", "o", "o", " ", " ", "o"},
    {"o", "w", "o", " ", " ", " ", " ", " ", " ", " "},
    {"o", "o", "o", " ", "o", "o", "o", "o", "o", " "},
    {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
    {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "},
    {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "}
  }

  game.map.electro(electromap)

  obj = game.map.phy()
  game.map.print()



  menu = {
    up = {Color = colors.l,Text = love.graphics.newText(fonts.h)},
    left = {Color = colors.l,Text = love.graphics.newText(fonts.h)},
    right = {Color = colors.l,Text = love.graphics.newText(fonts.h)}}
  menu.up.w = 400
  menu.left.w = 300
  menu.right.w = 300
  menu.up.Text:setf("/\\", menu.up.w, "center")
  menu.left.Text:setf("<", menu.left.w, "center")
  menu.right.Text:setf(">", menu.right.w, "center")
  menu.up.x = grid.w / 2 - menu.up.w / 2
  menu.up.y = grid.h / 16 * 13.5
  menu.left.x = 0
  menu.left.y = grid.h / 16 * 13.5
  menu.right.x = grid.w - menu.right.w
  menu.right.y = grid.h / 16 * 13.5
  menu.up.fun = function()
    local A = player[1].b:getAngle()
    player[1].b:applyForce(math.cos(A) * 10, math.sin(A) * 10)
  end
  menu.left.fun = function()
    player[1].b:applyAngularImpulse(-3000)
  end
  menu.right.fun = function()
    player[1].b:applyAngularImpulse(3000)
  end
end

function update(dt)
  world:update(dt * 2)
  for key, val in pairs(menu) do
    if val ~= nil and val.fun ~= nil then
      x, y = mou()
      if x ~= nil and y ~= nil and x >= val.x and x <= val.x + val.w and y >= val.y and y <= val.y + val.Text:getHeight() then
        val.Color = colors.r
        if love.mouse.isDown(1) then
            val.fun()
            val.Color = colors.l
        end
      else
        val.Color = colors.l
      end
    end
  end
end

function draw()
  game.autodraw()


  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, grid.h / 16 * 13, grid.w, grid.h / 16 * 3)

  love.graphics.setColor(menu.up.Color)
  love.graphics.draw(menu.up.Text, menu.up.x, menu.up.y)

  love.graphics.setColor(menu.left.Color)
  love.graphics.draw(menu.left.Text, menu.left.x, menu.left.y)

  love.graphics.setColor(menu.right.Color)
  love.graphics.draw(menu.right.Text, menu.right.x, menu.right.y)
end

-- Start by kiselev nikolay
-- Just part of project


function load()
    realm = {
        main = love.physics.newWorld(0, 0, true),
        obj = {
            first_player = {}
        }
    }
    local binding = images.bargas.first
    local working = realm.obj.first_player
    working.i = binding
    working.w = binding:getWidth()
    working.h = binding:getHeight()
    working.b = love.physics.newBody(realm.main, grid.w / 2, grid.h / 2, "dynamic")
    working.s = love.physics.newRectangleShape(binding:getWidth(), binding:getHeight())
    working.f = love.physics.newFixture(working.b, working.s)
    realm.obj.first_player = working
end

function update()
end

function draw()
    fstplr = realm.obj.first_player
    love.graphics.draw(fstplr.i, fstplr.b:getX(), fstplr.b:getY(), fstplr.b:getAngle(), 1, 1, fstplr.w / 2, fstplr.h / 2)
end
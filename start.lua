-- Start by kiselev nikolay
-- Just part of project


function load()
    realm = {
        main = love.physics.newWorld(0, 0, true),
        obj = {
            first_player = {},
            left_mesh = {},
            right_mesh = {},
            aaaa = {}
        }
    }

    realm.obj.first_player.i = images.bargas.first
    realm.obj.first_player.w = realm.obj.first_player.i:getWidth()
    realm.obj.first_player.h = realm.obj.first_player.i:getHeight()
    realm.obj.first_player.b = love.physics.newBody(realm.main, grid.w / 2, grid.h / 4 * 3, "dynamic")
    realm.obj.first_player.s = love.physics.newRectangleShape(realm.obj.first_player.w, realm.obj.first_player.h)
    realm.obj.first_player.f = love.physics.newFixture(realm.obj.first_player.b, realm.obj.first_player.s)
    realm.obj.first_player.b:setAngle(math.rad(-90))

    realm.obj.left_mesh.b = love.physics.newBody(realm.main, grid.w / 4, 0, "dynamic")
    realm.obj.left_mesh.s = love.physics.newEdgeShape(0, 0, 0, grid.h)
    realm.obj.left_mesh.f = love.physics.newFixture(realm.obj.left_mesh.b, realm.obj.left_mesh.s)

    realm.obj.right_mesh.b = love.physics.newBody(realm.main, grid.w / 4, 0, "dynamic")
    realm.obj.right_mesh.s = love.physics.newEdgeShape(0, 0, 0, grid.h)
    realm.obj.right_mesh.f = love.physics.newFixture(realm.obj.right_mesh.b, realm.obj.right_mesh.s)
end

function update()
end

function draw()
    love.graphics.draw(realm.obj.first_player.i, realm.obj.first_player.b:getX(), realm.obj.first_player.b:getY(), realm.obj.first_player.b:getAngle(), 1, 1, realm.obj.first_player.w / 2, realm.obj.first_player.h / 2)
    love.graphics.line(grid.w / 4, 0, grid.w / 4, grid.h)
    love.graphics.line(grid.w / 4 * 3, 0, grid.w / 4 * 3, grid.h)
end
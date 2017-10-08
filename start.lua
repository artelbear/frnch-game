-- Start by kiselev nikolay
-- Just part of project


local tester = love.filesystem.load("test.lua")
tester()

function load()
    love.physics.setMeter(1500)
    realm = {
        main = love.physics.newWorld(0, 0, true),
        obj = {
            first_player = {},
            left_mesh = {},
            right_mesh = {},
            aaaa = {}
        }
    }

    realm.obj.first_player.i = images.bargas.iron
    realm.obj.first_player.w = realm.obj.first_player.i:getWidth()
    realm.obj.first_player.h = realm.obj.first_player.i:getHeight()
    realm.obj.first_player.b = love.physics.newBody(realm.main, grid.w / 2, grid.h / 4 * 3, "dynamic")
    realm.obj.first_player.s = love.physics.newRectangleShape(realm.obj.first_player.w / 2, realm.obj.first_player.h / 2)
    realm.obj.first_player.f = love.physics.newFixture(realm.obj.first_player.b, realm.obj.first_player.s)
    realm.obj.first_player.b:setAngle(math.rad(-90))
    realm.obj.first_player.b:setAngularDamping(0.654)
    realm.obj.first_player.b:setLinearDamping(0.574)
    realm.obj.first_player.b:setMass(1000)

    realm.obj.left_mesh.b = love.physics.newBody(realm.main, grid.w / 12, grid.h / 2, "static")
    realm.obj.left_mesh.s = love.physics.newRectangleShape(0, 0, grid.w / 8, grid.h)
    realm.obj.left_mesh.f = love.physics.newFixture(realm.obj.left_mesh.b, realm.obj.left_mesh.s)

    realm.obj.right_mesh.b = love.physics.newBody(realm.main, grid.w / 12 * 11, grid.h / 2, "static")
    realm.obj.right_mesh.s = love.physics.newRectangleShape(0, 0, grid.w / 8, grid.h)
    realm.obj.right_mesh.f = love.physics.newFixture(realm.obj.right_mesh.b, realm.obj.right_mesh.s)

    realm.main:setCallbacks(beginContact, endContact, preSolve, postSolve)
    game_play = true    
end

function update(dt)
    if game_play then    
        realm.main:update(dt)
    end
end

action = {
    right = function()
        realm.obj.first_player.b:applyAngularImpulse(5)
        realm.obj.first_player.b:applyLinearImpulse(75000, 25)
    end,
    left = function()
        realm.obj.first_player.b:applyAngularImpulse(-5)
        realm.obj.first_player.b:applyLinearImpulse(-75000, 25)
    end,
    up = function()
        print("up")
    end,
    down = function()
        print("down")
    end,
    ok = function()
        print("ok")
    end,
    pause = function()
        print("pause")
    end,
    lose = function()
        game_play = false
        love.filesystem.load("menu.lua")()
    end
}

function beginContact(a, b, coll)
    if a == realm.obj.first_player.f or b == realm.obj.first_player.f then
        if a == realm.obj.left_mesh.f or b == realm.obj.left_mesh.f then
            action.lose()
        elseif a == realm.obj.right_mesh.f or b == realm.obj.right_mesh.f then
            action.lose()            
        end
    end
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "a" or key == "left" then
        action.left()
    elseif key == "d" or key == "right" then
        action.right()
    elseif key == "return" then
        action.ok()
    elseif key == "escape" then
        action.pause()
    end
end

function draw()
    love.graphics.draw(realm.obj.first_player.i, realm.obj.first_player.b:getX(), realm.obj.first_player.b:getY(), realm.obj.first_player.b:getAngle(), 1, 1, realm.obj.first_player.w / 2, realm.obj.first_player.h / 2)
    love.graphics.polygon("fill", realm.obj.left_mesh.b:getWorldPoints(realm.obj.left_mesh.s:getPoints()))
    love.graphics.polygon("fill", realm.obj.right_mesh.b:getWorldPoints(realm.obj.right_mesh.s:getPoints()))
end
require("consts")

local canvas

local shader

local SM = require("objects.sm")
local sm

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    shader = love.graphics.newShader("data/key.glsl")
    
    canvas = love.graphics.newCanvas(SCREEN_W, SCREEN_H)

    sm = SM:new()
    sm:init()
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.setShader(shader)
    love.graphics.clear()
    
    sm:draw()
    
    love.graphics.setCanvas()
    love.graphics.setShader()
    
    love.graphics.draw(canvas)
end

function love.update(dt)
    sm:update(dt)
end

function love.keypressed(key)
    sm:keypressed(key)
end

function love.mousepressed(x, y, button)
    sm:mousepressed(x, y, button)
end
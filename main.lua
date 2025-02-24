require "consts"

local zoom = 1
local canvas

local GM = require "scripts.gm"
local gm

local shader

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    shader = love.graphics.newShader("data/key.glsl")
    
    canvas = love.graphics.newCanvas(SCREEN_W, SCREEN_H)
    gm = GM:new()
    gm:init()

    local w, h = love.graphics.getDimensions()
    zoom = h/SCREEN_H
end

function love.draw()
    love.graphics.setCanvas(canvas)
    love.graphics.setShader(shader)
    love.graphics.clear()
    
    gm:draw()
    
    love.graphics.setCanvas()
    love.graphics.setShader()
    
    love.graphics.draw(canvas, 0, 0, 0, zoom, zoom)
end

function love.update(dt)
    dt = dt*60
    gm:update(dt)
end

function love.keypressed(key)
    gm:keypressed(key)
end

function love.resize(w, h)
    zoom = h/SCREEN_H
end
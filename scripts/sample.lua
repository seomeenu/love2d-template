local Objects = require "objects"

local Sample = Objects:new()

function Sample:init(gm, x, y)
    self.gm = gm
    self.tag = "sample"
    self.col = true

    self.x = x
    self.y = y
    self.w = 32
    self.h = 32
end

function Sample:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Sample:update(dt)
    
end

return Sample
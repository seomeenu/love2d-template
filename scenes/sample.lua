local Object = require("object")

local Sample = Object:new()

function Sample:init(sm)
    self.sm = sm
    self.objects = {}
end

function Sample:draw()
    for _, object in ipairs(self.objects) do
        object:draw()
    end
end

function Sample:update(dt)
    for _, object in ipairs(self.objects) do
        object:update(dt)
    end
end

return Sample
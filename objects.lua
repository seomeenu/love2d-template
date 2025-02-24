local Objects = {}

function Objects:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Objects:init()
    
end

function Objects:update(dt)
  -- update object properties
end

function Objects:draw()
  -- draw object on screen
end

return Objects

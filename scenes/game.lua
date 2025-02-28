local function check_collision(a, b)
    return a.x < b.x+b.w and
            b.x < a.x+a.w and
            a.y < b.y+b.h and
            b.y < a.y+a.h
end

local function check_filtered(b, filters)
    local filtered = false
    if filters then
        for i, filter in ipairs(filters) do
            if b.tag == filter then
                filtered = true
                break
            end
        end
    end
    return filtered
end

local Object = require("object")

local Game = Object:new()

function Game:add(object, ...)
    local o = object:new()
    o:init(self, ...)
    table.insert(self.objects, o)
    return o
end

function Game:remove(object)
    for i, o in ipairs(self.objects) do
        if o == object then
            table.remove(self.objects, i)
            return
        end
    end
end

function Game:init(sm)
    self.sm = sm
    self.objects = {}
end

function Game:update(dt)
    for _, object in ipairs(self.objects) do
        object:update(dt)
    end
end

function Game:draw()
    for _, object in ipairs(self.objects) do
        object:draw()
    end
end

function Game:keypressed(key)
    -- self.player:keypressed(key)
end

function Game:check(a, filters)
    local cols = {}
    for _, b in ipairs(self.objects) do
        if not check_filtered(b, filters) then
            if a ~= b and check_collision(a, b) then
                table.insert(cols, b)
            end
        end
    end
    return cols
end

function Game:move_x(a, x, filters)
    a.x = a.x+x
    local cols = self:check(a, filters)
    for _, c in ipairs(cols) do
        if c.col then
            if x > 0 then
                a.x = c.x-a.w
            else
                a.x = c.x+c.w
            end
            return c
        end
    end
    return nil
end

function Game:move_y(a, y, filters)
    a.y = a.y+y
    local cols = self:check(a, filters)
    for _, c in ipairs(cols) do
        if c.col then
            if y > 0 then
                a.y = c.y-a.h
            else
                a.y = c.y+c.h
            end
            return c
        end
    end
    return nil
end

return Game
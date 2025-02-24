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

local Objects = require "objects"

local GM = Objects:new()

function GM:add(object, ...)
    local o = object:new()
    o:init(self, ...)
    table.insert(self.objects, o)
    return o
end

function GM:remove(object)
    for i, o in ipairs(self.objects) do
        if o == object then
            table.remove(self.objects, i)
            return
        end
    end
end

function GM:init()
    self.objects = {}
end

function GM:update(dt)
    if dt > 2 then
        return
    end
    for _, object in ipairs(self.objects) do
        object:update(dt)
    end
end

function GM:draw()
    for _, object in ipairs(self.objects) do
        object:draw()
    end
end

function GM:keypressed(key)
    self.player:keypressed(key)
end

function GM:check(a, filters)
    local cols = {}
    if a.col then
        for _, b in ipairs(self.objects) do
            if b.col then
                if not check_filtered(b, filters) then
                    if a ~= b and check_collision(a, b) then
                        table.insert(cols, b)
                    end
                end
            end
        end
    end
    return cols
end

function GM:move_x(a, x, filters)
    a.x = a.x+x
    local cols = self:check(a, filters)
    if #cols ~= 0 then
        local c = cols[1]
        if x > 0 then
            a.x = c.x-a.w
        else
            a.x = c.x+c.w
        end
        return c
    end
    return nil
end

function GM:move_y(a, y, filters)
    a.y = a.y+y
    local cols = self:check(a, filters)
    if #cols ~= 0 then
        local c = cols[1]
        if y > 0 then
            a.y = c.y-a.h
        else
            a.y = c.y+c.h
        end
        return c
    end
    return nil
end

return GM
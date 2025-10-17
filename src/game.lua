Imgs = {
    r = love.graphics.newImage("imgs/r.png"),
    p = love.graphics.newImage("imgs/p.png"),
    s = love.graphics.newImage("imgs/s.png"),
}

Speed = 2.6

function NewEntity(type, x, y)
    local e = {}
    e.dir = 0
    e.x = x
    e.y = y
    e.type = type

    function e:update(dt)
        e.dir = e.dir+math.random(-10, 10)*0.05*dt
        e.x = e.x+math.cos(e.dir)*Speed*dt
        e.y = e.y+math.sin(e.dir)*Speed*dt

        if self.x < 0 then
            e.dir = 0
        end
        if self.x > SW then
            e.dir = math.pi
        end
        if self.y < 0 then
            e.dir = math.pi/2
        end
        if self.y > SH then
            e.dir = math.pi*3/2
        end
        
        for i, o in ipairs(EatTable[self.type]) do
            if ((e.x-o.x)^2+(e.y-o.y)^2)^0.5 < 50 then
                if not o.remove then
                    o.remove = true
                    table.insert(Tables[self.type], NewEntity(self.type, self.x, self.y))
                end
            end
        end
    end

    function e:draw()
        love.graphics.draw(Imgs[self.type], self.x, self.y, 0, 0.1, 0.1)
    end

    return e
end

Rs = {}
Ps = {}
Ss = {}

EatTable = {
    r = Ss,
    p = Rs,
    s = Ps,
}

Tables = {
    r = Rs,
    p = Ps,
    s = Ss,
}

Margin = 100
StartPos = {
    r = {x = SW/2, y = Margin*0.7},
    p = {x = SW-Margin, y = SH-Margin},
    s = {x = Margin, y = SH-Margin},
}

function Summon(type)
    local sp = StartPos[type]
    for _ = 1, N do
        table.insert(Tables[type], NewEntity(type, sp.x, sp.y))
    end
end

function UpdateTable(dt, t)
    for i = #t, 1, -1 do
        local e = t[i]
        e:update(dt)
        if e.remove then
            table.remove(t, i)
        end
    end
end

function DrawTable(t)
    love.graphics.rectangle("fill", 10, 10, 10, 10)
    for _, e in ipairs(t) do
        e:draw()
    end
end
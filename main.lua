require("src.game")

Zoom = 1
OffsetX = 0

N = 50
BaseSpeed = 1
Speed = BaseSpeed

function love.load()
    Font = love.graphics.newFont(20)
    love.graphics.setFont(Font)
end

function love.keypressed(key)
    if key == "r" then
        Restart()
    end
    if key == "up" then
        N = N+10
    end
    if key == "down" then
        N = N-10
    end
end

function love.update(dt)
    dt = dt*60

    UpdateTable(dt, Rs)
    UpdateTable(dt, Ps)
    UpdateTable(dt, Ss)

    if love.keyboard.isDown("space") then
        Speed = BaseSpeed*2
    else
        Speed = BaseSpeed
    end
end

local function draw_hud()
    love.graphics.setColor(0, 0, 0)
    local groups = {
        {img = Imgs.r, count = #Rs},
        {img = Imgs.p, count = #Ps},
        {img = Imgs.s, count = #Ss},
    }
    table.sort(groups, function (a, b)
        return a.count > b.count
    end)
    local gap = 30
    love.graphics.setColor(1, 1, 1)
    for i, item in ipairs(groups) do
        love.graphics.draw(item.img, 10, (i-1)*gap, 0, 0.05, 0.05)
    end
    love.graphics.setColor(0, 0, 0)
    local speed_s = "speed: "..Speed
    love.graphics.print(speed_s, SW-Font:getWidth(speed_s)-10, 0)
    local N_s = "N: "..N
    love.graphics.print(N_s, SW-Font:getWidth(N_s)-10, gap)
    for i, item in ipairs(groups) do
        love.graphics.print(tostring(item.count), 40, (i-1)*gap)
    end
    love.graphics.setColor(1, 1, 1)
end

function love.draw()
    love.graphics.push()

    love.graphics.translate(OffsetX, 0)
    love.graphics.scale(Zoom)
    love.graphics.setBackgroundColor(1, 1, 1)
    
    DrawTable(Rs)
    DrawTable(Ps)
    DrawTable(Ss)

    draw_hud()

    love.graphics.pop()
end

function love.resize(w, h)
    Zoom = h/SH
    OffsetX = (w-SW*Zoom)/2
end
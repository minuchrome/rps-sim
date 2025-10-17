require("src.game")

Zoom = 1
OffsetX = 0
local started = false

function love.load()
    N = 100
    love.graphics.setFont(love.graphics.newFont(40))
    math.randomseed(os.time())
end

function love.keypressed(key)
    if not started and key == "space" then
        Summon("r")
        Summon("p")
        Summon("s")
        started = true
    end
end

function love.update(dt)
    dt = dt*60
    UpdateTable(dt, Rs)
    UpdateTable(dt, Ps)
    UpdateTable(dt, Ss)
end

local function draw_hud()
    love.graphics.setColor(0, 0, 0)
    if not started then
        love.graphics.print("press [space] to start")
    else
        local groups = {
            {img = Imgs.r, count = #Rs},
            {img = Imgs.p, count = #Ps},
            {img = Imgs.s, count = #Ss},
        }
        table.sort(groups, function (a, b)
            return a.count > b.count
        end)
        local gap = 60
        love.graphics.setColor(1, 1, 1)
        for i, item in ipairs(groups) do
            love.graphics.draw(item.img, 20, (i-1)*gap, 0, 0.1, 0.1)
        end
        love.graphics.setColor(0, 0, 0)
        for i, item in ipairs(groups) do
            love.graphics.print(tostring(item.count), 80, (i-1)*gap)
        end
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
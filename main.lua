require("src.game")

Zoom = 1
OffsetX = 0

function love.load()
    N = 20
    Summon("r")
    Summon("p")
    Summon("s")
    math.randomseed(os.time())
    love.graphics.setFont(love.graphics.newFont(20))
end

function love.update(dt)
    dt = dt*60
    UpdateTable(dt, Rs)
    UpdateTable(dt, Ps)
    UpdateTable(dt, Ss)
end

function love.draw()
    love.graphics.push()

    love.graphics.translate(OffsetX, 0)
    love.graphics.scale(Zoom)
    love.graphics.setBackgroundColor(1, 1, 1)
    
    DrawTable(Rs)
    DrawTable(Ps)
    DrawTable(Ss)

    love.graphics.pop()
end

function love.resize(w, h)
    Zoom = h/SH
    OffsetX = (w-SW*Zoom)/2
end
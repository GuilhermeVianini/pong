if arg[2] == "debug" then
    require("lldebugger").start()
end

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--[[tamanho da tela do jogo]]

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen=false,
        resizable=false,
        vsync=true
    })
end
--[[ os padroes de tamanho de tela não poderao ser alterados mas será sincronizado com o monitor]]

function love.draw()
    love.graphics.printf(
        'Hello Pong',
        0,
        WINDOW_HEIGHT / 2 - 6,
        WINDOW_WIDTH,
        'center')
end

--[[renderiza o texto na tela comecando por x=0 e y= tamanho/2 -6 pra centralizar
porque a fonte do love2d é 12px. O alinhamento é center ]]
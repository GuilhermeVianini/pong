
-- https://github.com/Ulydev/push
push = require "push" -- algum erro com a importação do push

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[tamanho da tela do jogo]]

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT= 243
--[[a tela do jogo ainda será 1280/720 porém, para a estética de jogo antigo, é determinado um tamanho virtual que vai fazer o programa rodar em 432/243]]

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') --altera o grafico com resolução mais "borrada" ou "reta"

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
--[[ os padroes de tamanho de tela não poderao ser alterados mas será sincronizado com o monitor]]

function love.keypressed(key)
    if key == 'escape' then
        --função para terminar a execução
        love.event.quit()
    end
end

function love.draw()
    push: apply('start') -- inicia o grafico virtual

    love.graphics.printf('Hello Pong', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')-- troquei a  width e height pelas virtuais

    push: apply('end')
end

--[[renderiza o texto na tela comecando por x=0 e y= tamanho/2 -6 pra centralizar
porque a fonte do love2d é 12px. O alinhamento é center ]]
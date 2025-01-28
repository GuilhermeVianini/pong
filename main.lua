
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
--[[tamanho da tela do jogo]]
--[[a tela do jogo ainda será 1280/720 porém, para a estética de jogo antigo, é determinado um tamanho virtual que vai fazer o programa rodar em 432/243]]

PADDLE_SPEED = 200
--[[determina a velocidade do bastão baseando no tempo de atualização multiplicado pelo valor determinado]]

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- texto retrô
    smallFont = love.graphics.newFont('font.ttf', 8)
    
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- trocar fonte
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Score = 0
    player2Score = 0
    --iniciar pontuação zerada

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end
--[[ os padroes de tamanho de tela não poderao ser alterados mas será sincronizado com o monitor]]

function love.update(dt)
    -- movimento do player 1
    if love.keyboard.isDown('w') then
        --valores positivos e negativos de movimento do eixo y
        player1Y = player1Y + -PADDLE_SPEED * dt

    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    --movimento do player 2
    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.keypressed(key)
    if key == 'escape'
        then love.event.quit()
    end
end

function love.draw()
    push:apply('start') -- inicia o grafico virtual

    -- limpa a tela com as cores rgb determinadas
    love.graphics.clear(0.15, 0.17, 0.20, 1)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong', 0, 20, VIRTUAL_WIDTH, 'center')

    -- desenha pontuação dos dois no topo da tela
    --precisa alterar a fonte para desenhar
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/ 2 + 30, VIRTUAL_HEIGHT / 3)
    
    --retangulo da esquerda
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    --retangulo da direita
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    --bola
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end

--[[renderiza o texto na tela comecando por x=0 e y= tamanho/2 -6 pra centralizar
porque a fonte do love2d é 12px. O alinhamento é center ]]
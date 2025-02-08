
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
    
    math.randomseed(os.time())

    -- texto retrô
    smallFont = love.graphics.newFont('font.ttf', 8)
    -- trocar fonte
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    --velocidade e posição da bola no começo
    ballX = VIRTUAL_WIDTH /2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    --altera a direção da bola
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- variavel para identificar o estado do jogo "menu, jogo, lista de pontuação..."
    gameState = 'start'
end
--[[ os padroes de tamanho de tela não poderao ser alterados mas será sincronizado com o monitor]]

function love.update(dt)
    -- movimento do player 1
    if love.keyboard.isDown('w') then
        --valores positivos e negativos de movimento do eixo y
        --agora as hastes não saem da tela
        player1Y = math.max(0, player1Y + -PADDLE_SPEED *dt)

    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    --movimento do player 2
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    --atualiza a bola bazeado no DX e DY se não estiver no começo
    --escala a velocidade da bola por dt então depende de framerate
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

function love.keypressed(key)
    if key == 'escape'
        then love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState =='start' then
            gameState = 'play'
        else
            gameState= 'start'
            
            --bola começa no meio
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            --valor aleatorio de velocidade para a bola
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

function love.draw()
    push:apply('start') -- inicia o grafico virtual

    -- limpa a tela com as cores rgb determinadas
    love.graphics.clear(0.15, 0.17, 0.20, 1)

    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State', 0, 20, VIRTUAL_WIDTH, 'center')
    end
    
    --retangulo da esquerda
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    --retangulo da direita
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    --bola
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    push:apply('end')
end

--[[renderiza o texto na tela comecando por x=0 e y= tamanho/2 -6 pra centralizar
porque a fonte do love2d é 12px. O alinhamento é center ]]
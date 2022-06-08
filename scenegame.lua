function updateGame()
    -- Pacaman moves
    local camc = math.floor((pacman.x + camera.x) / 8) + 1
    local caml = math.floor((pacman.y + camera.y) / 8) + 1
    local c = math.floor(pacman.x / 8) + 1
    local l = math.floor(pacman.y / 8) + 1
    local oldX,
        oldY = pacman.x, pacman.y
    local oldCamX,
        oldCamY = camera.x, camera.y
    if pacman.moving then
        if pacman.columnTo > pacman.column then -- To the right
            pacman.x = pacman.x + 1
            if (pacman.x / 8) + 1 >= pacman.columnTo then
                pacman.moving = false
                pacman.column = pacman.columnTo
            end
            -- Camera
            if camc > 5 and string.sub(map.currentGrid[l], c + 4, c + 4) ~= "" then
                camera.x = camera.x - 1
            end
        elseif pacman.columnTo < pacman.column then -- To the left
            pacman.x = pacman.x - 1
            if (pacman.x / 8) + 1 <= pacman.columnTo then
                pacman.moving = false
                pacman.column = pacman.columnTo
            end
            -- Camera
            if camc < 3 then
                camera.x = camera.x + 1
                if c <= 2 then
                    camera.x = 0
                end
            end
        elseif pacman.lineTo < pacman.line then -- To up
            pacman.y = pacman.y - 1
            if (pacman.y / 8) + 1 <= pacman.lineTo then
                pacman.line = pacman.lineTo
                pacman.moving = false
            end
            -- Camera
            if caml < 3 and map.currentGrid[l - 2] ~= nil then
                camera.y = camera.y + 1
            end
        elseif pacman.lineTo > pacman.line then -- To bottom
            pacman.y = pacman.y + 1
            if (pacman.y / 8) + 1 >= pacman.lineTo then
                pacman.line = pacman.lineTo
                pacman.moving = false
            end
            -- Camera
            if caml > 2 and map.currentGrid[l + 3] ~= nil then
                camera.y = camera.y - 1
            end
        end
    else
        if vthumb.buttonR.pressed then
            pacman.columnTo = pacman.columnTo + 1
            pacman.current = pacman.right
            pacman.moving = true
        elseif vthumb.buttonL.pressed then
            pacman.columnTo = pacman.columnTo - 1
            pacman.current = pacman.left
            pacman.moving = true
        elseif vthumb.buttonU.pressed then
            pacman.lineTo = pacman.lineTo - 1
            pacman.current = pacman.up
            pacman.moving = true
        elseif vthumb.buttonD.pressed then
            pacman.lineTo = pacman.lineTo + 1
            pacman.current = pacman.down
            pacman.moving = true
        end
        if
            pacman.columnTo < 1 or pacman.columnTo > map.width or pacman.lineTo < 1 or pacman.lineTo > map.height or
                not canWalk(pacman.lineTo, pacman.columnTo)
         then
            pacman.columnTo = pacman.column
            pacman.lineTo = pacman.line
            pacman.moving = false
        end
    end

    --[[
        if vthumb.buttonR.pressed == true and canWalk(pacman.x + 8, pacman.y + 2) and pacman.x < (map.width - 1) * 8 then
        pacman.x = pacman.x + 1
        pacman.current = pacman.right
        -- Camera
        if camc > 5 and string.sub(map.currentGrid[l], c + 4, c + 4) ~= "" then
            camera.x = camera.x - 1
        end
    elseif vthumb.buttonL.pressed == true and canWalk(pacman.x - 2, pacman.y + 2) and pacman.x > 0 then
        -- Camera
        if camc < 3 then
            camera.x = camera.x + 1
            if c <= 2 then
                camera.x = 0
            end
        end
        pacman.x = pacman.x - 1
        pacman.current = pacman.left
    elseif vthumb.buttonU.pressed == true and canWalk(pacman.x + 2, pacman.y - 2) and pacman.y > 0 then
        -- Camera
        if caml < 3 and map.currentGrid[l - 2] ~= nil then
            camera.y = camera.y + 1
        end
        pacman.y = pacman.y - 1
        pacman.current = pacman.up
    elseif vthumb.buttonD.pressed == true and canWalk(pacman.x + 2, pacman.y + 8) and pacman.y < (map.height - 1) * 8 then
        -- Camera
        if caml > 2 and map.currentGrid[l + 3] ~= nil then
            camera.y = camera.y - 1
        end
        pacman.y = pacman.y + 1
        pacman.current = pacman.down
    end
    ]]
end

function drawGame()
    drawMap()
    -- drawString(1, 1, "HS " .. hiScore .. " " .. currentScore)
    drawElements(camera.x, camera.y)
end

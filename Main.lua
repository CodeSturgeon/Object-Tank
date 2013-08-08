--displayMode(FULLSCREEN)
supportedOrientations(LANDSCAPE_LEFT)

-- Use this function to perform your initial setup
function setup()
    objects = {} -- Live objects in the tank
    classes = {Star, Tree, Rock, Heart}
    table.insert(objects, Heart())
    --table.insert(objects, classes[math.random(#classes)]())
    -- Create a wall around the screen to make the tank
    border = physics.body(CHAIN, true,
        vec2(0,HEIGHT),
        vec2(0,45),
        vec2(285,45),
        vec2(285,0),
        vec2(WIDTH, 0),
        vec2(WIDTH, HEIGHT)
    )
end

-- Trace a body's points
function traceBody(bod)
    for i, v in ipairs(bod.points) do
        if i == 1 then
            -- First point gets stashed as there is no line to draw
            sv = v
        else
            -- Draw line to the last point
            line(lv.x, lv.y, v.x, v.y)
        end

        -- At the end of the run, close the loop
        if i == #bod.points then
            line(v.x, v.y, sv.x, sv.y)
        end

        -- Stash for next loop
        lv = v
    end
end

-- This function gets called once every frame
function draw()
    background(40, 40, 50)

    -- Draw the enclosing wall
    stroke(255, 255, 255, 255)
    strokeWidth(5)
    traceBody(border)

    -- Let each object draw it's self
    for i, obj in pairs(objects) do
        --print(i)
        if obj.destroy then
            --print "destroy"
            obj.body:destroy()
            objects[i] = nil
        else
            --print "draw"
            obj:draw()
        end
    end

    physics.gravity(Gravity)
    
end

function touched(touch)
    -- Ignore button touches
    if touch.y < 50  and touch.x < 290 then return end

    -- See if one of the objects was touched
    local touchfound = false
    for i, obj in pairs(objects) do
        if obj:touched(touch) then touchfound = true end
    end

    -- Make a new object if this is a fresh touch
    if touchfound == false and touch.state == BEGAN then
        table.insert(objects,
            classes[math.random(#classes)](
                touch.x,
                touch.y,
                math.random(20)+20
            )
        )
    end
end

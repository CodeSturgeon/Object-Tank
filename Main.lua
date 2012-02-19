supportedOrientations(LANDSCAPE_ANY)
displayMode(FULLSCREEN)

-- Use this function to perform your initial setup
function setup()
    objects = {}
    scenery = {}
    classes = {Star, Tree, Rock, Heart}
    table.insert(objects, Heart())
    --table.insert(objects, classes[math.random(#classes)]())
    -- Create a wall around the screen
    table.insert(scenery,
        physics.body(CHAIN, true,
            vec2(0,HEIGHT), vec2(0,45), vec2(WIDTH, 45), vec2(WIDTH, HEIGHT)
        )
    )
end

-- This function gets called once every frame
function draw()
    background(40, 40, 50)

    -- Draw the enclosing wall
    stroke(255, 255, 255, 255)
    strokeWidth(5)
    line(0,45,0,HEIGHT)
    line(0,45,WIDTH,45)
    line(0,HEIGHT,WIDTH,HEIGHT)
    line(WIDTH,HEIGHT,WIDTH,45)

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
    local touchfound = false
    for i, obj in pairs(objects) do
        if obj:touched(touch) then touchfound = true end
    end
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

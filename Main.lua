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
            vec2(0,HEIGHT),
            vec2(0,45),
            vec2(285,45),
            vec2(285,0),
            vec2(WIDTH, 0),
            vec2(WIDTH, HEIGHT)
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
    line(0,45,285,45)
    line(285,45, 285, 0)
    line(285, 0, WIDTH, 0)
    line(0,HEIGHT,WIDTH,HEIGHT)
    line(WIDTH,HEIGHT,WIDTH,0)

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
    if touch.y < 50  and touch.x < 290 then return end
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

-- Use this function to perform your initial setup

thingy_types = {}
function setup()
    enabled_thingys = {}
    objects = {} -- Live objects in the tank
    makeParams()
end

function makeParams()
    parameter.clear()
    parameter.action('ReTab', (function ()
        saveProjectTab('Thingy', '-- Thingy tab')
        saveProjectTab('SmpTgy', '-- SmpTgy')
    end))
    parameter.action('Fullscreen',
        (function () displayMode(FULLSCREEN_NO_BUTTONS) end)
    )
    parameter.integer('ObjSizeMin', 10, 50, 20)
    parameter.integer('ObjSizeRnd', 10, 50, 20)
    parameter.boolean('OrientationLock', false, (function (value)
        if value then
            supportedOrientations(CurrentOrientation)
        else
            supportedOrientations(ANY)
        end
    end))
    parameter.boolean('DebugDraw', false)
    parameter.number('GravFactor', 0.0, 5.0, 1.0)
    parameter.boolean('GravArrow', false)
    for i, v in ipairs(thingy_types) do
        print(i)
        print(v.name)
        --parameter.boolean('enable'+v.name, true, (function (value)
        --    print(value)
        --end))
    end
end

-- Create border object taking screen shape in to account
function makeBorder()
    local cdm = displayMode()
    local bargs = {CHAIN, true, vec2(WIDTH,0), vec2(WIDTH, HEIGHT)}

    -- Avoid the flyout button if needed
    if cdm == FULLSCREEN or cdm == STANDARD then
        table.insert(bargs, vec2(60, HEIGHT))
        table.insert(bargs, vec2(60, HEIGHT-60))
        table.insert(bargs, vec2(0, HEIGHT-60))
    else
        table.insert(bargs, vec2(0,HEIGHT))
    end

    -- Avoid the button bar if need
    if cdm == FULLSCREEN then
        table.insert(bargs, vec2(0,45))
        table.insert(bargs, vec2(285,45))
        table.insert(bargs, vec2(285,0))
    else
        table.insert(bargs, vec2(0,0))
    end

    return physics.body(unpack(bargs))
end

-- Trace a body's points
-- FIXME look at the debug draw version
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

    -- Redraw border if the screen changes
    if dsm ~= displayMode() or lor ~= CurrentOrientation then
        if border ~= nil then border:destroy() end -- Account for first run nil
        dsm = displayMode()
        lor = CurrentOrientation
        border = makeBorder()
    end

    -- Draw the enclosing wall
    stroke(255, 255, 255, 255)
    strokeWidth(5)
    traceBody(border)

    -- Gravity line
    if GravArrow then
        line(
            WIDTH/2,
            HEIGHT/2,
            (WIDTH/2)+(Gravity.x*200),
            (HEIGHT/2)+(Gravity.y*200)
        )
    end

    -- Let each object draw or destroy it's self
    for i, obj in pairs(objects) do
        if obj.destroy then
            obj.body:destroy()
            objects[i] = nil
        else
            obj:draw()
        end
    end

    physics.gravity(Gravity*GravFactor)
    
end

function touched(touch)
    -- Ignore flyout touches
    local cdm = displayMode()
    if cdm ~= FULLSCREEN_NO_BUTTONS and (touch.x < 60 and touch.y > HEIGHT-60) 
    then
        return
    end

    -- Avoid the button bar if need
    if cdm == FULLSCREEN and (touch.x < 285 and touch.y < 45) then
        return
    end

    -- See if one of the objects was touched
    local touchfound = false
    for i, obj in pairs(objects) do
        if obj:touched(touch) then touchfound = true end
    end

    -- Make a new object if this is a fresh touch
    if touchfound == false and touch.state == BEGAN then
        table.insert(objects,
            thingy_types[math.random(#thingy_types)](
                touch.x,
                touch.y,
                math.random(ObjSizeRnd)+ObjSizeMin
            )
        )
    end
end

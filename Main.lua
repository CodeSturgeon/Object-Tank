-- Main.lua

thingy_types = {}

function setup()
    enabled_thingys = {}
    objects = {} -- Live objects in the tank
    makeParams()

    -- Set the display mode as AirCode starts in a strange state
    displayMode(STANDARD)
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

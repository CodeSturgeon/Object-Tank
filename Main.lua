-- Main.lua

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
        saveProjectTab('World', '-- World tab')
        saveProjectTab('Thingy', '-- Thingy tab')
        saveProjectTab('SmpTgy', '-- SmpTgy')
    end))
    parameter.integer('ObjSizeMin', 10, 50, 20)
    parameter.integer('ObjSizeRnd', 10, 50, 20)
    parameter.action('Fullscreen',
        (function () displayMode(FULLSCREEN_NO_BUTTONS) end)
    )
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

    -- Enable individual Thingy types
    enabled_thingys = 0
    for i, v in ipairs(thingy_types) do
        function classToggle(cls)
            return function (value)
                if value then
                    enabled_thingys = enabled_thingys + 1
                else
                    enabled_thingys = enabled_thingys - 1
                end
            end
        end
        parameter.boolean('enable' .. v.name, true, classToggle(v))
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
        if enabled_thingys == 0 then
            return
        end
        local thing_type
        repeat
            -- FIXME CRASHES WITHOUT any enabled
            thing_type = thingy_types[math.random(#thingy_types)]
        until _G['enable' .. thing_type.name]

        table.insert(objects,
            thing_type(
                touch.x,
                touch.y,
                math.random(ObjSizeRnd)+ObjSizeMin
            )
        )
    end
end

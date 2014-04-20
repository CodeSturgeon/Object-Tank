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

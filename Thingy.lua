Thingy = class()

function Thingy:init(x, y)
    self.body.interpolate = true
    --self.body.sleepingAllowed = false
    self.body.x = x or WIDTH/2
    self.body.y = y or HEIGHT/2
    self.touchMap = {}
end

function Thingy:draw()
    self:touchforce()

    pushStyle()
    pushMatrix()
    translate(self.body.x, self.body.y)
    rotate(self.body.angle)

    -- If body is out of sight or other wise destroyed
    if self.body.x > WIDTH or self.body.y > HEIGHT
        or self.body.x < 0 or self.body.y < 0
        or self.destruct
    then
        -- signal mail loop to kill off this object
        self.destroy = true
    else
        self:drawMe()
        --self:debugOverlay()
    end

    popMatrix()
    popStyle()
end

function Thingy:debugOverlay()
    pushStyle()
    noFill()
    body = self.body
    if body.type == STATIC then
        stroke(255,255,255,255)
    elseif body.type == DYNAMIC then
        stroke(150,255,150,255)
    elseif body.type == KINEMATIC then
        stroke(150,150,255,255)
    end

    if body.shapeType == POLYGON then
        strokeWidth(5.0)
        local points = body.points
        for j = 1,#points do
            a = points[j]
            b = points[(j % #points)+1]
            line(a.x, a.y, b.x, b.y)
        end
    elseif body.shapeType == CHAIN or body.shapeType == EDGE then
        strokeWidth(5.0)
        local points = body.points
        for j = 1,#points-1 do
            a = points[j]
            b = points[j+1]
            line(a.x, a.y, b.x, b.y)
        end      
    elseif body.shapeType == CIRCLE then
        strokeWidth(5.0)
        line(0,0,body.radius-3,0)
        strokeWidth(2.5)
        ellipse(0,0,body.radius*2)
    end
    popStyle()
end

function Thingy:touchforce()
    pushStyle()
    smooth()

    strokeWidth(5)
    stroke(128,0,128)
    
    -- Apply touches as force
    local gain = 2.0
    local damp = 0.5
    for k,v in pairs(self.touchMap) do
        local worldAnchor = self.body:getWorldPoint(v.anchor)
        local touchPoint = v.tp
        local diff = touchPoint - worldAnchor
        local vel = self.body:getLinearVelocityFromWorldPoint(worldAnchor)
        self.body:applyForce( (1/1) * diff * gain - vel * damp, worldAnchor)
 
        line(touchPoint.x, touchPoint.y, worldAnchor.x, worldAnchor.y)
    end

    popStyle()
end

function Thingy:touched(touch)
    local touchPoint = vec2(touch.x, touch.y)
    if touch.state == BEGAN then
        if self.body:testPoint(touchPoint) then
            self.touchMap[touch.id] = {
                tp = touchPoint,
                anchor = self.body:getLocalPoint(touchPoint),
                moved = false
            }
            return true
        end
    elseif touch.state == MOVING and self.touchMap[touch.id] then
        self.touchMap[touch.id].tp = touchPoint
        self.touchMap[touch.id].moved = true
        return true
    elseif touch.state == ENDED and self.touchMap[touch.id] then
        if self.touchMap[touch.id].moved == false then
            self.destruct = 4
        end
        self.touchMap[touch.id] = nil
        return true
    end
    return false
end

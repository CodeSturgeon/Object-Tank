-- Simple Thingy based objects

thingy_types = {}

--
-- Heart
--
Heart = class(Thingy)
Heart.name = 'Heart'
table.insert(thingy_types, Heart)

function Heart:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 30)
    self.body.restitution = 0.3
    Thingy.init(self, x, y)
end

function Heart:drawMe()
    sprite("Planet Cute:Heart",
        0,
        self.body.radius*0.07,
        self.body.radius*2.2
    )
end


--
-- Rock
--
Rock = class(Thingy)
Rock.name = 'Rock'
table.insert(thingy_types, Rock)

function Rock:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 30)
    self.body.restitution = 0.15
    self.body.density = 2
    Thingy.init(self, x, y)
end

function Rock:drawMe()
    sprite("Planet Cute:Rock", 0, self.body.radius*0.65, self.body.radius*2.3)
end


--
-- Tree
--
Tree = class(Thingy)
Tree.name = 'Tree'
table.insert(thingy_types, Tree)

function Tree:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 30)
    self.body.restitution = 0.3
    Thingy.init(self, x, y)
end

function Tree:drawMe()
    sprite(
        "Planet Cute:Tree Short",
        0,
        self.body.radius*0.45,
        self.body.radius*2.5
    )
end


-- 
-- Star
--
Star = class(Thingy)
Star.name = 'Star'
table.insert(thingy_types, Star)

function Star:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 30)
    self.body.restitution = 0.8
    self.body.density = 0.5
    Thingy.init(self, x, y)
end

function Star:drawMe()
    sprite(
        "Planet Cute:Star",
        0,
        self.body.radius*0.4,
        self.body.radius*2.5
    )
end


--
-- Coin
--
Coin = class(Thingy)
Coin.name = 'Coin'
table.insert(thingy_types, Coin)

function Coin:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 35)
    self.body.restitution = 0.4
    self.body.density = 1.2
    Thingy.init(self, x, y)
end

function Coin:drawMe()
    sprite(
        "Platformer Art:Coin",
        0,
        0,
        self.body.radius*2
    )
end


--
-- Planet
--
Planet = class(Thingy)
Planet.name = 'Planet'
table.insert(thingy_types, Planet)

function Planet:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 35)
    self.body.restitution = 0.4
    self.body.density = 3
    Thingy.init(self, x, y)
end

function Planet:drawMe()
    sprite(
        "SpaceCute:Planet",
        0,
        -3,
        self.body.radius*2
    )
end


--
-- Circle
--
Circle = class(Thingy)
Circle.name = 'Circle'
table.insert(thingy_types, Circle)

function Circle:init(x, y, size, static)
    self.body = physics.body(CIRCLE, size or 35)
    self.body.restitution = 0.4
    self.body.density = 1.2
    if static then
        self.body.type = STATIC
    end
    Thingy.init(self, x, y)
end

function Circle:drawMe()
    stroke(190, 101, 101, 255)
    strokeWidth(2)
    if self.body.type == STATIC then
        fill(10, 10, 10, 10)
    else
        fill(31, 6, 235, 255)
    end
    ellipse(0, 0, self.body.radius * 2)
end

--
-- Square
--
Square = class(Thingy)
Square.name = 'Square'
table.insert(thingy_types, Square)

function Square:init(x, y, size)
    self.body = physics.body(POLYGON,
        vec2(-size,size),
        vec2(-size,-size),
        vec2(size,-size),
        vec2(size,size)
    )
    self.body.restitution = 0.4
    self.body.density = 1.2
    --self.body.type = STATIC
    self.size = size*2
    Thingy.init(self, x, y)
end

function Square:drawMe()
    sprite("Platformer Art:Block Special Brick", 0, 0, self.size, self.size)
end

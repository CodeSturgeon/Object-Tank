-- Simple Thingy based objects

--
-- Heart
--
Heart = class(Thingy)
table.insert(thingy_types, Heart)

function Heart:init(x, y, size)
    self.name = 'Heart'
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
table.insert(thingy_types, Rock)

function Rock:init(x, y, size)
    self.name = 'Rock'
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
table.insert(thingy_types, Tree)

function Tree:init(x, y, size)
    self.name = 'Tree'
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
table.insert(thingy_types, Star)

function Star:init(x, y, size)
    self.name = 'Star'
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
table.insert(thingy_types, Coin)

function Coin:init(x, y, size)
    self.name = 'Coin'
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
-- Circle
--
Circle = class(Thingy)
table.insert(thingy_types, Circle)

function Circle:init(x, y, size)
    self.name = 'Circle'
    self.body = physics.body(CIRCLE, size or 35)
    self.body.restitution = 0.4
    self.body.density = 1.2
    Thingy.init(self, x, y)
end

function Circle:drawMe()
    stroke(190, 101, 101, 255)
    strokeWidth(2)
    fill(31, 6, 235, 255)
    ellipse(0, 0, self.body.radius * 2)
end

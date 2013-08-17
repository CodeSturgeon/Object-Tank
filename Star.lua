Star = class(Thingy)

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

Coin = class(Thingy)

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

Circle = class(Thingy)

function Circle:init(x, y, size)
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
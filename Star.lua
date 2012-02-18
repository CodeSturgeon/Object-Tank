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

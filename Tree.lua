Tree = class(Thingy)

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

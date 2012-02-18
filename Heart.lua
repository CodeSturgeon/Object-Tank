Heart = class(Thingy)

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

Rock = class(Thingy)

function Rock:init(x, y, size)
    self.body = physics.body(CIRCLE, size or 30)
    self.body.restitution = 0.15
    self.body.density = 2
    Thingy.init(self, x, y)
end

function Rock:drawMe()
    sprite("Planet Cute:Rock", 0, self.body.radius*0.65, self.body.radius*2.3)
end

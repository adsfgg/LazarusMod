local oldOnUpdate = Drifter.OnUpdate

function Drifter:OnUpdate(deltaTime)
    oldOnUpdate(self, deltaTime)

    -- What's the point of a tech tree when classes constantly use their own methods to determine when they have a tech.........
    self.hasCamouflage = false
    self.hasCelerity = false
    self.hasRegeneration = false
end
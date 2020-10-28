function Hydra:CreateSpikeProjectile()

    -- TODO: make hitscan at account for target velocity (more inaccurate at higher speed)

    local startPoint = self:GetBarrelPoint()
    local directionToTarget = self.target:GetEngagementPoint() - self:GetEyePos()
    local targetDistance = directionToTarget:GetLength()
    local theTimeToReachEnemy = targetDistance / Hydra.kSpikeSpeed
    local engagementPoint = self.target:GetEngagementPoint()
    if self.target.GetVelocity then

        local targetVelocity = self.target:GetVelocity()
        engagementPoint = self.target:GetEngagementPoint() - ((targetVelocity:GetLength() * Hydra.kTargetVelocityFactor * theTimeToReachEnemy) * GetNormalizedVector(targetVelocity))

    end

    local fireDirection = GetNormalizedVector(engagementPoint - startPoint)
    -- local fireCoords = Coords.GetLookIn(startPoint, fireDirection)

    -- local spreadFraction = Clamp((targetDistance - Hydra.kNearDistance) / (Hydra.kFarDistance - Hydra.kNearDistance), 0, 1)
    -- local spread = Hydra.kNearSpread * (1.0 - spreadFraction) + Hydra.kFarSpread * spreadFraction

    -- local spreadDirection = CalculateSpread(fireCoords, spread, math.random)

    local fireCoords = Coords.GetLookIn(startPoint, fireDirection)
    local spreadDirection = CalculateSpread(fireCoords, Hydra.kSpread, math.random)

    local endPoint = startPoint + spreadDirection * Hydra.kRange

    local trace = Shared.TraceRay(startPoint, endPoint, CollisionRep.Damage, PhysicsMask.Bullets, EntityFilterOneAndIsa(self, "Hydra"))

    if trace.fraction < 1 then

        local surface

        -- Disable friendly fire.
        trace.entity = (not trace.entity or GetAreEnemies(trace.entity, self)) and trace.entity or nil

        if not trace.entity then
            surface = trace.surface
        end

        -- local direction = (trace.endPoint - startPoint):GetUnit()
        self:DoDamage(Hydra.kDamage, trace.entity, trace.endPoint, fireDirection, surface, false, true)

    end

end

function Hydra:AttackTarget()

    self:TriggerUncloak()

    self:CreateSpikeProjectile()
    self:TriggerEffects("hydra_attack")


    -- self.timeOfNextFire = Shared.GetTime() + self:GetRateOfFire()

    self.timeOfNextFire = Shared.GetTime() + 0.5 + math.random()
end
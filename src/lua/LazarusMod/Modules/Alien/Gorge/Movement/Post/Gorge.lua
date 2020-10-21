Gorge.kAirControl = 30 -- 9

Gorge.kJumpHeight = 1.2 -- 1.23 is this even noticable?
Gorge.kMaxBackwardSpeedScalar = 0.5 --0.7
-- NOTE:
-- The start slide speed is 7.75 for R4 and 8.9 for R5
Gorge.kStartSlideSpeed = 8.9 -- 9.6 
Gorge.kMaxSlidingSpeed = 13 -- 14
Gorge.kSlideCoolDown = 1.5 -- 0.5

Gorge.kBellySlideControl = 10 --25

Gorge.kBellyFriction = 0.2 --0.1
Gorge.kBellyFrictionOnInfestation = 0.068 --0.039

function Gorge:GetCanAttack()
    return Alien.GetCanAttack(self) and not self:GetIsBellySliding()
end

function Gorge:PostUpdateMove(input)

    if self:GetIsBellySliding() and self:GetIsOnGround() then

        local velocity = self:GetVelocity()

        local yTravel = self:GetOrigin().y - self.prevY
        local xzSpeed = velocity:GetLengthXZ()

        -- if yTravel > 0 then
        --     xzSpeed = xzSpeed + yTravel * -3
        -- else
        --     xzSpeed = xzSpeed + yTravel * -4
        -- end

        xzSpeed = xzSpeed + yTravel * -4

        if xzSpeed < self.kMaxSlidingSpeed or yTravel > 0 then

            local directionXZ = GetNormalizedVectorXZ(velocity)
            directionXZ:Scale(xzSpeed)

            velocity.x = directionXZ.x
            velocity.z = directionXZ.z

            self:SetVelocity(velocity)

        end

        self.verticalVelocity = yTravel / input.time

    end

end

function Gorge:GetAirFriction()
    local speedFraction = self:GetVelocity():GetLengthXZ() / self:GetMaxSpeed()
    return math.max(0.15 * speedFraction, 0.12)
end

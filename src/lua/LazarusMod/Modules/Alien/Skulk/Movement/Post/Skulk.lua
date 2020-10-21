Skulk.kMaxSpeed = 7.0
Skulk.kSneakSpeedModifier = 0.5
Skulk.kWallJumpForce = 5.2

function Skulk:GetMaxSpeed(possible)
    if possible then
        return Skulk.kMaxSpeed
    end

    local maxspeed = Skulk.kMaxSpeed
    if self:GetIsWallWalking() then
        maxspeed = maxspeed + 0.25
    end

    if self.movementModiferState then
        maxspeed = maxspeed * Skulk.kSneakSpeedModifier
    end

    return maxspeed
end

function Skulk:ModifyJump(input, velocity, jumpVelocity)
    if self:GetCanWallJump() then
        -- we add the bonus in the direction the move is going
        local viewCoords = self:GetViewAngles():GetCoords()

        jumpVelocity.y = 3 + math.min(1, 1 + viewCoords.zAxis.y) * 2

        if not self:GetRecentlyWallJumped() then
            local minimumForce = Skulk.kMinWallJumpForce
            local scalableForce = Skulk.kWallJumpForce
            local verticalForce = Skulk.kVerticalWallJumpForce
            local maxSpeed = self:GetMaxWallJumpSpeed()
            local celerityMod = maxSpeed - Skulk.kWallJumpMaxSpeed

            local fraction = 1 - Clamp( velocity:GetLengthXZ() / maxSpeed , 0, 1)

            local force = math.max(minimumForce, (scalableForce + celerityMod) * fraction)

            local direction = input.move.z == -1 and -1 or 1
            local bonusVec = viewCoords.zAxis * direction
            bonusVec.y = 0
            bonusVec:Normalize()

            bonusVec:Scale(force)

            bonusVec.y = viewCoords.zAxis.y * verticalForce
            jumpVelocity:Add(bonusVec)
        end

        self.timeLastWallJump = Shared.GetTime()
    end
end

Skulk.ModifyCelerityBonus = nil

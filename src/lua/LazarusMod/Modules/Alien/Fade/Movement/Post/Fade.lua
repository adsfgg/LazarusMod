local kBlinkSpeed = 14
local kBlinkAddAcceleration = 1
local kBlinkMaxSpeed = 25
local kMaxSpeed = debug.getupvaluex(Fade.GetMaxSpeed, "kMaxSpeed", false)
local kBlinkAcceleration = debug.getupvaluex(Fade.ModifyVelocity, "kBlinkAcceleration", false)

function Fade:GetGroundFriction()
    return 9
end

function Fade:GetAirFriction()
    return (self:GetIsBlinking() or self:GetRecentlyShadowStepped()) and 0 or (0.17  - (GetHasCelerityUpgrade(self) and self:GetSpurLevel() or 0) * 0.01)
end

function Fade:ModifyVelocity(input, velocity, deltaTime)
    if self:GetIsBlinking() then
        local wishDir = self:GetViewCoords().zAxis
        local maxSpeedTable = { maxSpeed = kBlinkSpeed } 
        self:ModifyMaxSpeed(maxSpeedTable, input)
        local prevSpeed = velocity:GetLength()
        local maxSpeed = math.max(prevSpeed, maxSpeedTable.maxSpeed)
        maxSpeed = math.min(kBlinkMaxSpeed, maxSpeed)

        velocity:Add(wishDir * kBlinkAcceleration * deltaTime)

        if velocity:GetLength() > maxSpeed then
            velocity:Normalize()
            velocity:Scale(maxSpeed)
        end

        velocity:Add(wishDir * kBlinkAddAcceleration * deltaTime)
    end
end

function Fade:GetMaxSpeed(possible)
    if possible then
        return kMaxSpeed
    end
    
    if self:GetIsBlinking() then
        return kBlinkSpeed
    end
    
    -- Take into account crouching.
    return kMaxSpeed
end

Fade.GetSpeedScalar = Player.GetSpeedScalar

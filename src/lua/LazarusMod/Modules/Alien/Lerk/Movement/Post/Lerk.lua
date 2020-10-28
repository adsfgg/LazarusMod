-- Lower swoop gravity
Lerk.kSwoopGravity = Lerk.kGravity * 4
Lerk.kWallGripMaxSpeed = 2
Lerk.kAirFrictionMinSpeed = 7
Lerk.kAirFrictionBleedAmount = 0.2
Lerk.kGlideAccelBleedTime = 1.0
Lerk.kGlideAccelBleedAmount = 4

function Lerk:GetAirFriction()
    -- return 0.1 - (GetHasCelerityUpgrade(self) and self:GetSpurLevel() or 0) * 0.02
    local celerityMod = (GetHasCelerityUpgrade(self) and self:GetSpurLevel() or 0)
    local frictionMod = self:GetFrictionModifier()
    return frictionMod * (Lerk.kAirFrictionBleedAmount - (celerityMod * 0.01)) + 0.1 - (celerityMod * 0.02)
end

local function UpdateFlap(self, input, velocity)
    local flapPressed = bit.band(input.commands, Move.Jump) ~= 0

    if flapPressed ~= self.flapPressed then
        self.flapPressed = flapPressed
        -- nostalgia only allowed gliding if you weren't on the ground, it feels 68.89x better without though
        --self.glideAllowed = not self:GetIsOnGround()
        self.glideAllowed = true

        if flapPressed and self:GetEnergy() > kLerkFlapEnergyCost and not self.gliding then
            local flapForce = Lerk.kFlapForce
            -- take off
            if self:GetIsOnGround() or input.move:GetLength() == 0 then
                local wishDir = self:GetViewCoords():TransformVector(input.move)
                wishDir:Normalize()
                if velocity:GetLengthXZ() < 4.5 then
                    velocity:Add(wishDir * (3 + flapForce + (GetHasCelerityUpgrade(self) and self:GetSpurLevel() or 0) * 0.3) * 0.5)
                end
                velocity.y = velocity.y * 0.5 + 5
            else
                local move = Vector(input.move)
                move.x = move.x * 0.75
                -- flap only at 50% speed side wards

                local wishDir = self:GetViewCoords():TransformVector(move)
                wishDir:Normalize()

                -- the speed we already have in the new direction
                local currentSpeed = move:DotProduct(velocity)
                -- prevent exceeding max speed of kMaxSpeed by flapping
                local maxSpeedTable = { maxSpeed = Lerk.kMaxSpeed }
                self:ModifyMaxSpeed(maxSpeedTable, input)

                local maxSpeed = math.max(currentSpeed, maxSpeedTable.maxSpeed)

                if input.move.z ~= 1 and velocity.y < 0 then
                    -- apply vertical flap
                    velocity.y = velocity.y * 0.5 + 3.8
                elseif input.move.z == 1 and input.move.x == 0 then
                    -- flapping forward
                    flapForce = 3 + flapForce + (GetHasCelerityUpgrade(self) and self:GetSpurLevel() or 0) * 0.3
                elseif input.move.z == 0 and input.move.x ~= 0 then
                    -- strafe flapping
                    velocity.y = velocity.y + 3.5
                end

                -- directional flap
                velocity:Scale(0.65)
                velocity:Add(wishDir * flapForce)

                if velocity:GetLengthSquared() > maxSpeed * maxSpeed then
                    velocity:Normalize()
                    velocity:Scale(maxSpeed)
                end
            end

            self:DeductAbilityEnergy(kLerkFlapEnergyCost)
            self.lastTimeFlapped = Shared.GetTime()
            self.onGround = false
            self:TriggerEffects("flap")
        end
    end
end

local function UpdateAirBrake(self, input, velocity, deltaTime)
    -- More control when moving forward
    local holdingShift = bit.band(input.commands, Move.MovementModifier) ~= 0
    if input.move.z ~= 0 and holdingShift then
        if velocity:GetLengthXZ() > Lerk.kAirFrictionMinSpeed then
            local yVel = velocity.y
            local newScale = math.max(velocity:GetLengthXZ() - (8 * deltaTime), Lerk.kAirFrictionMinSpeed)
            velocity.y = 0
            velocity:Normalize()
            velocity:Scale(newScale)
            velocity.y = yVel
        end
    end
end

local function UpdateGlide(self, input, velocity, deltaTime)
    -- more control when moving forward
    local holdingGlide = bit.band(input.commands, Move.Jump) ~= 0 and self.glideAllowed
    if input.move.z == 1 and holdingGlide then
        local useMove = Vector(input.move)
        useMove.x = useMove.x * 0.5

        local wishDir = GetNormalizedVector(self:GetViewCoords():TransformVector(useMove))
        -- slow down when moving in another XZ direction, accelerate when falling down
        local currentDir = GetNormalizedVector(velocity)
        -- local glideAccel = -currentDir.y * deltaTime * Lerk.kGlideAccel
        local glideAccel = -currentDir.y * deltaTime * (Lerk.kGlideAccel - self:GetAccelerationModifier() * Lerk.kGlideAccelBleedAmount)

        local maxSpeedTable = { maxSpeed = Lerk.kMaxSpeed }
        self:ModifyMaxSpeed(maxSpeedTable, input)

        local speed = velocity:GetLength() -- velocity:DotProduct(wishDir) * 0.1 + velocity:GetLength() * 0.9
        local useSpeed = math.min(maxSpeedTable.maxSpeed, speed + glideAccel)

        -- when speed falls below 1, set horizontal speed to 1, and vertical speed to zero, but allow dive to regain speed
        if useSpeed < 4 then
            useSpeed = 4
            local newY = math.min(wishDir.y, 0)
            wishDir.y = newY
            wishDir = GetNormalizedVector(wishDir)
        end

        -- when gliding we always have 100% control
        local redirectVelocity = wishDir * useSpeed
        VectorCopy(redirectVelocity, velocity)

        self.gliding = not self:GetIsOnGround()
    else
        self.gliding = false
    end

    UpdateAirBrake(self, input, velocity, deltaTime)
end

function Lerk:GetAccelerationModifier()
    local speed = self:GetVelocity():GetLengthXZ()
    if speed < Lerk.kAirFrictionMinSpeed then
        return 0
    end

    return Clamp((speed - Lerk.kAirFrictionMinSpeed) / (Lerk.kMaxSpeed - Lerk.kAirFrictionMinSpeed), 0, 1)
end

function Lerk:GetFrictionModifier()
    local speed = self:GetVelocity():GetLengthXZ()
    if speed < Lerk.kAirFrictionMinSpeed then
        return 0
    end

    return math.pow(Clamp((Shared.GetTime() - self:GetTimeOfLastFlap()) / Lerk.kGlideAccelBleedTime, 0, 1), 3)
end

function Lerk:PreUpdateMove(input, runningPrediction)
    PROFILE("Lerk:PreUpdateMove")

    local wallGripPressed = bit.band(input.commands, Move.MovementModifier) ~= 0 and bit.band(input.commands, Move.Jump) == 0
    local wallGripDesired = self:GetVelocity():GetLengthXZ() <= Lerk.kWallGripMaxSpeed or input.move.z == 0
    
    if not self:GetIsWallGripping() and wallGripPressed and self.wallGripAllowed and wallGripDesired then
        -- check if we can grab anything around us
        local wallNormal = self:GetAverageWallWalkingNormal(Lerk.kWallGripRange, Lerk.kWallGripFeelerSize)
        
        if wallNormal then
            self.wallGripTime = Shared.GetTime()
            self.wallGripNormalGoal = wallNormal
            self:SetVelocity(Vector(0,0,0))
        end
    else
        -- we always abandon wall gripping if we flap (even if we are sliding to a halt)
        local breakWallGrip = bit.band(input.commands, Move.Jump) ~= 0 or input.move:GetLength() > 0 or self:GetCrouching()
        
        if breakWallGrip then
            self.wallGripTime = 0
            self.wallGripNormal = nil
            self.wallGripAllowed = false
        end
    end
end

debug.setupvaluex(Lerk.ModifyVelocity, "UpdateGlide", UpdateGlide)
debug.setupvaluex(Lerk.ModifyVelocity, "UpdateCrouchDive", function() end)

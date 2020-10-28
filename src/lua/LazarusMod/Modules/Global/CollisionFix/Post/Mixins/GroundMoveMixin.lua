-- local logger = LazarusMod:GetModule('logger')
local FlushCollisionCallbacks = debug.getupvaluex(GroundMoveMixin.UpdatePosition, "FlushCollisionCallbacks")
local DoStepMove = debug.getupvaluex(GroundMoveMixin.UpdatePosition, "DoStepMove")
local kStepHeight = debug.getupvaluex(DoStepMove, "kStepHeight")
local kDownSlopeFactor = debug.getupvaluex(DoStepMove, "kDownSlopeFactor")
local GetIsCloseToGround = debug.getupvaluex(DoStepMove, "GetIsCloseToGround")

local function CheckForInvalidEntityStep(self, hitEntities)
    if hitEntities then
        for i = 1, #hitEntities do
            if not self:GetCanStepOver(hitEntities[i]) then
                return true
            end
        end
    end

    return false
end

-- Fix teleporting on top of players
-- Check for entities in both the step up and step down traces, abort if we're stepping ontop of entities we shouldn't be
local function DoStepMove(self, _, velocity, deltaTime)

    PROFILE("GroundMoveMixin:DoStepMove")
    
    local oldOrigin = Vector(self:GetOrigin())
    local oldVelocity = Vector(velocity)
    local success = false
    local stepAmount = 0
    local slowDownFraction = self.GetCollisionSlowdownFraction and self:GetCollisionSlowdownFraction() or 1
    local deflectMove = self.GetDeflectMove and self:GetDeflectMove() or false
    
    -- step up at first
    local _, hitEntities = self:PerformMovement(Vector(0, kStepHeight, 0), 1)
    stepAmount = self:GetOrigin().y - oldOrigin.y
    local shouldBlockStep = stepAmount > 0.02

    if CheckForInvalidEntityStep(self, hitEntities) then
        -- logger:PrintWarn("Step up of distance %s blocked", stepAmount)
        self:SetOrigin(oldOrigin)
        VectorCopy(oldVelocity, velocity)
        self:PerformMovement(velocity * deltaTime, 3, velocity, true, slowDownFraction, deflectMove)
        return false
    end

    -- do the normal move
    local startOrigin = Vector(self:GetOrigin())
    local completedMove = self:PerformMovement(velocity * deltaTime, 3, velocity, true, slowDownFraction, deflectMove)
    local horizMoveAmount = (startOrigin - self:GetOrigin()):GetLengthXZ()
    
    if completedMove then
        -- step down again
        local _, hitEntities, averageSurfaceNormal = self:PerformMovement(Vector(0, -stepAmount - horizMoveAmount * kDownSlopeFactor, 0), 1)
        if CheckForInvalidEntityStep(self, hitEntities) then
            -- logger:PrintWarn("Step down of distance %s blocked", -stepAmount - horizMoveAmount * kDownSlopeFactor)
            self:SetOrigin(oldOrigin)
            VectorCopy(oldVelocity, velocity)
            self:PerformMovement(velocity * deltaTime, 3, velocity, true, slowDownFraction, deflectMove)
            return false
        end
        
        if averageSurfaceNormal and averageSurfaceNormal.y >= 0.5 then
            success = true
        else    
            local onGround = GetIsCloseToGround(self, 0.15)
            
            if onGround then
                success = true
            end
        end
    end
    
    -- not succesful. fall back to normal move
    if not success then
        self:SetOrigin(oldOrigin)
        VectorCopy(oldVelocity, velocity)
        self:PerformMovement(velocity * deltaTime, 3, velocity, true, slowDownFraction, deflectMove)
    end

    return success
end

function GroundMoveMixin:UpdatePosition(input, velocity, deltaTime)

    PROFILE("GroundMoveMixin:UpdatePosition")
    
    if self.controller then
        
        local stepAllowed = self.onGround and self:GetCanStep()
        local didStep = false
        local stepAmount = 0
        local hitObstacle = false
    
        -- check if we are allowed to step:
        local _, hitEntities = self:PerformMovement(velocity * deltaTime * 2.5, 1, nil, false)
  
        if stepAllowed and hitEntities then
        
            for i = 1, #hitEntities do
                if not self:GetCanStepOver(hitEntities[i]) then
                
                    hitObstacle = true
                    stepAllowed = false
                    break
                    
                end
            end
        
        end
        
        if not stepAllowed then
            
            local slowDownFraction = self.GetCollisionSlowdownFraction and self:GetCollisionSlowdownFraction() or 1 
            
            local deflectMove = self.GetDeflectMove and self:GetDeflectMove() or false
            
            self:PerformMovement(velocity * deltaTime, 3, velocity, true, slowDownFraction * 0.5, deflectMove)
            
        else        
            didStep, stepAmount = DoStepMove(self, input, velocity, deltaTime)            
        end
        
        FlushCollisionCallbacks(self, velocity)
        
        if self.OnPositionUpdated then
            self:OnPositionUpdated(self:GetOrigin() - self.prevOrigin, stepAllowed, input, velocity)
        end
        
    end
    
    SetSpeedDebugText("onGround %s", ToString(self.onGround))

end

if Server then
    -- Repaired by marine with welder or MAC
    function PowerPoint:OnWeldOverride(entity, elapsedTime)
        local welded = false
        
        -- Marines can repair power points
        if entity:isa("Welder") then
            local amount = kWelderPowerRepairRate * elapsedTime
            welded = (self:AddHealth(amount) > 0)
        elseif entity:isa("MAC") then
            welded = self:AddHealth(MAC.kRepairHealthPerSecond * elapsedTime) > 0
        else
            local amount = kBuilderPowerRepairRate * elapsedTime
            welded = (self:AddHealth(amount) > 0)
        end
        
        if self:GetHealthScalar() > self.kDamagedPercentage then
            self:StopDamagedSound()
            
            if self:GetLightMode() == kLightMode.LowPower and self:GetIsPowering() then
                self:SetLightMode(kLightMode.Normal)
            end
        end
        
        if self:GetPowerState() == PowerPoint.kPowerState.destroyed then
            if self:GetHealthScalar() == 1 then
                self:StopDamagedSound()
                self.health = kPowerPointHealth
                self.armor = kPowerPointArmor
                self:SetMaxHealth(kPowerPointHealth)
                self:SetMaxArmor(kPowerPointArmor)
                self.alive = true
                
                PowerUp(self)
            else
                --Required here as in this state PowerPoint doesn't "read" as infestable (aka, it's dead, Jim)
                self:InfestationNeedsUpdate()
            end
        end
        
        if welded then
            self:AddAttackTime(-0.1)
        end     
    end
end
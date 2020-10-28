function Marine:OnUpdateAnimationInput(modelMixin)
    PROFILE("Marine:OnUpdateAnimationInput")
    
    Player.OnUpdateAnimationInput(self, modelMixin)
    
    local animationLength = modelMixin:isa("ViewModel") and 0 or 0.5
    
    if not self:GetIsJumping() and self:GetIsSprinting() then
        modelMixin:SetAnimationInput("move", "sprint")
    end

    if self:GetIsStunned() and self:GetRemainingStunTime() > animationLength then
        modelMixin:SetAnimationInput("move", "stun")
    end
    
    local activeWeapon = self:GetActiveWeapon()
    local catalystSpeed = 1
    
    if activeWeapon and activeWeapon.GetCatalystSpeedBase then
        catalystSpeed = activeWeapon:GetCatalystSpeedBase()
    end

    -- Lower speed of rifle bash
    if activeWeapon and activeWeapon.kMapName == "rifle" and activeWeapon.secondaryAttacking then
        catalystSpeed = catalystSpeed * 0.75
    end
    
    if self:GetHasCatPackBoost() then
        catalystSpeed = kCatPackWeaponSpeed * catalystSpeed
    end

    modelMixin:SetAnimationInput("catalyst_speed", catalystSpeed) 
end

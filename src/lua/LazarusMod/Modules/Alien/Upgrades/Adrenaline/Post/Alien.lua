function Alien:GetRecuperationRate()
    local scalar = ConditionalValue(self:GetGameEffectMask(kGameEffect.OnFire), kOnFireEnergyRecuperationScalar, 1)
    scalar = scalar * (self.electrified and kElectrifiedEnergyRecuperationScalar or 1)
    local rate = 0
    
    if self.hasAdrenalineUpgrade then
        rate = (( Alien.kEnergyAdrenalineRecuperationRate - Alien.kEnergyRecuperationRate) * (GetSpurLevel(self:GetTeamNumber()) / 3) + Alien.kEnergyRecuperationRate)
    else
        rate = Alien.kEnergyRecuperationRate
    end
    
    rate = rate * scalar
    return rate
end

function Alien:GetAdrenalineMaxEnergy()
    if self.hasAdrenalineUpgrade then
        return (kAdrenalineAbilityMaxEnergy - kAbilityMaxEnergy) * (GetSpurLevel(self:GetTeamNumber()) / 3)
    end
    
    return 0
end
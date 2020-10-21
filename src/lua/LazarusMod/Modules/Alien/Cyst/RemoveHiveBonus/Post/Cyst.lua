function Cyst:GetAutoBuildRateMultiplier()
    return 1
end

function Cyst:GetIsCamouflaged()
    -- return self:GetIsConnected() and self:GetIsBuilt() and not self:GetIsInCombat() and GetHasTech(self, kTechId.ShadeHive)
    return false
end

function Cyst:GetMatureMaxArmor()
    -- if GetHasTech(self, kTechId.CragHive) then
    --     return 25
    -- end

    return kMatureCystArmor
end

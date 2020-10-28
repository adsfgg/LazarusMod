local oldSetGestationData = Embryo.SetGestationData
function Embryo:SetGestationData(techIds, previousTechId, healthScalar, armorScalar)
    local currentUpgrades = self:GetUpgrades()
    oldSetGestationData(self, techIds, previousTechId, healthScalar, armorScalar)
    local lifeformTime = ConditionalValue(self.gestationTypeTechId ~= previousTechId, self:GetGestationTime(self.gestationTypeTechId), 0)

    local newUpgradesAmount = 0
    local replacementUpgrades = {}

    for _, upgradeId in ipairs(self.evolvingUpgrades) do
        if not table.contains(currentUpgrades, upgradeId) then
            newUpgradesAmount = newUpgradesAmount + 1
        end
        local currentChamberId = GetHiveTypeForUpgrade(upgradeId)
        for _,cId in ipairs(currentUpgrades) do
            if GetHiveTypeForUpgrade(cId) == currentChamberId and not table.contains(self.evolvingUpgrades, cId) and not table.contains(replacementUpgrades, cId) then
                table.insert(replacementUpgrades, cId)
            end
        end
    end

    self.gestationTime = lifeformTime + (newUpgradesAmount * kUpgradeGestationTime) + (#replacementUpgrades * kReplaceUpgradeGestationTime)

    if Embryo.gFastEvolveCheat then
        self.gestationTime = 5
    elseif Shared.GetDevMode() then
        self.gestationTime = 2
    end
end

-- don't know if i want to keep this...
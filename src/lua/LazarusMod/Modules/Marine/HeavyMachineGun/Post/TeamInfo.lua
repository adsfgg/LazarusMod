for i,v in ipairs(TeamInfo.kRelevantTechIdsMarine) do
    if v == kTechId.AdvancedArmoryUpgrade then
        table.insert(TeamInfo.kRelevantTechIdsMarine, i + 1, kTechId.HeavyMachineGunTech)
    end
end

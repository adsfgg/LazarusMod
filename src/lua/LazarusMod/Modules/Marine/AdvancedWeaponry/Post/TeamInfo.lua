for i,v in ipairs(TeamInfo.kRelevantTechIdsMarine) do
    if v == kTechId.AdvancedWeaponry then
        table.remove(TeamInfo.kRelevantTechIdsMarine, i)
    end
end

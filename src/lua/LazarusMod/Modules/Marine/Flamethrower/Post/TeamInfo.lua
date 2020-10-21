for i,v in ipairs(TeamInfo.kRelevantTechIdsMarine) do
    if v == kTechId.ShotgunTech then
        table.insert(TeamInfo.kRelevantTechIdsMarine, i + 1, kTechId.FlamethrowerTech)
    end
end

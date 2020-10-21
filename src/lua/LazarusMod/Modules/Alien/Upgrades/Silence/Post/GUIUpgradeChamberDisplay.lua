local kIndexToUpgrades = debug.getupvaluex(GUIUpgradeChamberDisplay.Update, "kIndexToUpgrades")

for _,v in ipairs(kIndexToUpgrades) do
    if v[1] == kTechId.Veil then
        table.insert(v, kTechId.Silence)
    end
end

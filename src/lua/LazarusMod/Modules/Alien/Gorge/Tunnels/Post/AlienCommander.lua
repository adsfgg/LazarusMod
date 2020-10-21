local gAlienMenuButtons =
{
    [kTechId.BuildMenu] = { kTechId.Cyst, kTechId.Harvester, kTechId.DrifterEgg, kTechId.Hive,
                            kTechId.ThreatMarker, kTechId.NeedHealingMarker, kTechId.ExpandingMarker, kTechId.None --[[ kTechId.BuildTunnelMenu ]] },

    [kTechId.AdvancedMenu] = { kTechId.Crag, kTechId.Shade, kTechId.Shift, kTechId.Whip,
                               kTechId.Shell, kTechId.Veil, kTechId.Spur, kTechId.None },

    [kTechId.AssistMenu] = { kTechId.HealWave, kTechId.ShadeInk, kTechId.SelectShift, kTechId.SelectDrifter,
                             kTechId.NutrientMist, kTechId.Rupture, kTechId.BoneWall, kTechId.Contamination }
}

local gAlienMenuIds = {}
do
    for menuId, _ in pairs(gAlienMenuButtons) do
        gAlienMenuIds[#gAlienMenuIds+1] = menuId
    end
end

function AlienCommander:GetButtonTable()
    return gAlienMenuButtons
end

function AlienCommander:GetMenuIds()
    return gAlienMenuIds
end

debug.setupvaluex(AlienCommander.GetQuickMenuTechButtons, "gAlienMenuButtons", gAlienMenuButtons)

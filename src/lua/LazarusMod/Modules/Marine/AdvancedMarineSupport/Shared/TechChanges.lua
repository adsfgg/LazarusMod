local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveMarineResearchNode(kTechId.AdvancedMarineSupport)
techHandler:AddMarineResearchNode(kTechId.NanoShieldTech)
techHandler:AddMarineResearchNode(kTechId.CatPackTech)

techHandler:ChangeMarineTargetedActivation(kTechId.NanoShield, kTechId.NanoShieldTech)
techHandler:ChangeMarineTargetedActivation(kTechId.PowerSurge, kTechId.RoboticsFactory)
techHandler:ChangeMarineTargetedActivation(kTechId.CatPack, kTechId.CatPackTech)

techHandler:AddTechData({
    [kTechDataId] = kTechId.NanoShieldTech,
    [kTechDataDisplayName] = "NANO_SHIELD_TECH",
    [kTechDataTooltipInfo] = "NANO_SHIELD_DEFENSE_TOOLTIP",
    [kTechDataCostKey] = kNanoShieldResearchCost,
    [kTechDataResearchTimeKey] = kNanoSnieldResearchTime
})

techHandler:AddTechData({
    [kTechDataId] = kTechId.CatPackTech,
    [kTechDataCostKey] = kCatPackTechResearchCost,
    [kTechDataResearchTimeKey] = kCatPackTechResearchTime,
    [kTechDataDisplayName] = "CAT_PACKS",
    [kTechDataTooltipInfo] = "CAT_PACK_TECH_TOOLTIP"
})

techHandler:AddMaterialOffset(kTechId.NanoShieldTech, 55)
techHandler:AddMaterialOffset(kTechId.CatPackTech, 164)

-- Remove adv support from tech map
techHandler:RemoveMarineTechMapTech(kTechId.AdvancedMarineSupport)
techHandler:RemoveMarineTechMapLine({7, 4.5, 8, 4.5})

-- Add NanoShieldTech to techmap
techHandler:AddMarineTechMapTech(kTechId.NanoShieldTech, 8, 4.5)
techHandler:AddMarineTechMapLine({7, 4.5, 8, 4.5})

-- Add CatPackTech to techmap
techHandler:AddMarineTechMapTech(kTechId.CatPackTech, 8, 5.5)
techHandler:AddMarineTechMapLine({7, 5.5, 8, 5.5})

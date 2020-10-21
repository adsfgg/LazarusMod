local techHandler = LazarusMod:GetModule('techhandler')

techHandler:AddAlienBuyNode(kTechId.Silence, kTechId.Veil, kTechId.None, kTechId.AllAliens)
techHandler:AddMaterialOffset(kTechId.Silence, 65)
techHandler:AddTechData({
    [kTechDataId] = kTechId.Silence,
    [kTechDataCategory] = kTechId.ShadeHive,
    [kTechDataDisplayName] = "SILENCE",
    [kTechDataSponitorCode] = "S",
    [kTechDataTooltipInfo] = "SILENCE_TOOLTIP",
    [kTechDataCostKey] = kSilenceCost
})

techHandler:AddAlienTechMapTech(kTechId.Silence, 6, 5)
techHandler:AddAlienTechMapLine(kTechId.Veil, kTechId.Silence)

Script.Load("lua/LazarusMod/Modules/Alien/Gorge/Tunnels/New/TunnelExit.lua")

local techHandler = LazarusMod:GetModule('techhandler')
techHandler:AddTechData({
    [kTechDataId] = kTechId.GorgeTunnelEntrance,
    [kTechDataCategory] = kTechId.Gorge,
    [kTechDataMaxExtents] = Vector(1.2, 1.2, 1.2),
    [kTechDataTooltipInfo] = "GORGE_TUNNEL_TOOLTIP",
    [kTechDataGhostModelClass] = "AlienGhostModel",
    [kTechDataAllowConsumeDrop] = true,
    [kTechDataAllowStacking] = false,
    [kTechDataMaxAmount] = 1,
    [kTechDataMapName] = TunnelEntrance.kMapName,
    [kTechDataDisplayName] = "TUNNEL_ENTRANCE",
    [kTechDataHint] = "TUNNEL_ENTRANCE_HINT",
    [kTechDataCostKey] = kGorgeTunnelCost,
    [kTechDataMaxHealth] = kTunnelEntranceHealth,
    [kTechDataMaxArmor] = kTunnelEntranceArmor,
    [kTechDataBuildTime] = kGorgeTunnelBuildTime,
    [kTechDataModel] = TunnelEntrance.kModelName,
    [kTechDataRequiresInfestation] = false,
    [kTechDataPointValue] = kTunnelEntrancePointValue
})

techHandler:AddTechData({
    [kTechDataId] = kTechId.GorgeTunnelExit,
    [kTechDataCategory] = kTechId.Gorge,
    [kTechDataMaxExtents] = Vector(1.2, 1.2, 1.2),
    [kTechDataTooltipInfo] = "GORGE_TUNNEL_TOOLTIP",
    [kTechDataGhostModelClass] = "AlienGhostModel",
    [kTechDataAllowConsumeDrop] = true,
    [kTechDataAllowStacking] = false,
    [kTechDataMaxAmount] = 1,
    [kTechDataMapName] = TunnelEntrance.kMapName,
    [kTechDataDisplayName] = "TUNNEL_EXIT",
    [kTechDataHint] = "TUNNEL_EXIT_HINT",
    [kTechDataCostKey] = kGorgeTunnelCost,
    [kTechDataMaxHealth] = kTunnelEntranceHealth,
    [kTechDataMaxArmor] = kTunnelEntranceArmor,
    [kTechDataBuildTime] = kGorgeTunnelBuildTime,
    [kTechDataModel] = TunnelExit.kModelName,
    [kTechDataRequiresInfestation] = false,
    [kTechDataPointValue] = kTunnelEntrancePointValue
})

techHandler:AddAlienBuildNode(kTechId.GorgeTunnelEntrance)
techHandler:AddAlienBuildNode(kTechId.GorgeTunnelExit)

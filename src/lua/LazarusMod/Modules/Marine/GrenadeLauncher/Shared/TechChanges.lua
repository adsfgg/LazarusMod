local techHandler = LazarusMod:GetModule('techhandler')

techHandler:AddMarineResearchNode(kTechId.GrenadeLauncherTech, kTechId.AdvancedArmory, kTechId.None)
techHandler:ChangeMarineTargetedBuyNode(kTechId.GrenadeLauncher, kTechId.GrenadeLauncherTech)
techHandler:ChangeMarineTargetedActivation(kTechId.DropGrenadeLauncher, kTechId.GrenadeLauncherTech)

techHandler:AddMarineTechMapTech(kTechId.GrenadeLauncherTech, 2.5, 5)
techHandler:AddMarineTechMapLine(kTechId.AdvancedArmory, kTechId.GrenadeLauncherTech)

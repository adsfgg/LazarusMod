local techHandler = LazarusMod:GetModule('techhandler')

techHandler:AddMarineResearchNode(kTechId.HeavyMachineGunTech, kTechId.AdvancedArmory, kTechId.None)
techHandler:ChangeMarineTargetedBuyNode(kTechId.HeavyMachineGun, kTechId.HeavyMachineGunTech)
techHandler:ChangeMarineTargetedActivation(kTechId.DropHeavyMachineGun, kTechId.HeavyMachineGunTech)

techHandler:AddMarineTechMapTech(kTechId.HeavyMachineGunTech, 2.5, 6)
techHandler:AddMarineTechMapLine(kTechId.AdvancedArmory, kTechId.HeavyMachineGunTech)

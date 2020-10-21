local techHandler = LazarusMod:GetModule('techhandler')

techHandler:AddMarineResearchNode(kTechId.FlamethrowerTech, kTechId.Armory, kTechId.None)
techHandler:ChangeMarineTargetedBuyNode(kTechId.Flamethrower, kTechId.FlamethrowerTech)
techHandler:ChangeMarineTargetedActivation(kTechId.DropFlamethrower, kTechId.FlamethrowerTech)
techHandler:ChangeTechData(kTechId.DropFlamethrower, {
    [kStructureAttachId] = {kTechId.Armory, kTechId.AdvancedArmory},
})

techHandler:AddMarineTechMapTech(kTechId.FlamethrowerTech, 5, 3)
techHandler:AddMarineTechMapLine(kTechId.Armory, kTechId.FlamethrowerTech)

-- Move welder over
techHandler:ChangeMarineTechMapTech(kTechId.Welder, 6, 3)
techHandler:ChangeMarineTechMapLine(kTechId.Armory, kTechId.Welder)

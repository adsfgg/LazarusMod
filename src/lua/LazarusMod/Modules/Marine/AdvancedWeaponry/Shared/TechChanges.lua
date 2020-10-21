local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveMarineResearchNode(kTechId.AdvancedWeaponry)
techHandler:RemoveMarineTechMapTech(kTechId.AdvancedWeaponry)
techHandler:RemoveMarineTechMapLine(kTechId.AdvancedArmory, kTechId.AdvancedWeaponry)

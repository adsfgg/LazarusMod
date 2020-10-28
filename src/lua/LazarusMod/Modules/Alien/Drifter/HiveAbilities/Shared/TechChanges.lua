local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienPassive(kTechId.DrifterCamouflage)
techHandler:RemoveAlienTechMapTech(kTechId.DrifterCamouflage)
techHandler:RemoveAlienTechMapLine(kTechId.ShadeHive, kTechId.DrifterCamouflage)

techHandler:RemoveAlienPassive(kTechId.DrifterCelerity)
techHandler:RemoveAlienTechMapTech(kTechId.DrifterCelerity)
techHandler:RemoveAlienTechMapLine(kTechId.ShiftHive, kTechId.DrifterCelerity)

techHandler:RemoveAlienPassive(kTechId.DrifterRegeneration)
techHandler:RemoveAlienTechMapTech(kTechId.DrifterRegeneration)
techHandler:RemoveAlienTechMapLine(kTechId.CragHive, kTechId.DrifterRegeneration)

local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienPassive(kTechId.CystCelerity)
techHandler:RemoveAlienTechMapTech(kTechId.CystCelerity)
techHandler:RemoveAlienTechMapLine(kTechId.ShiftHive, kTechId.CystCelerity)

techHandler:RemoveAlienPassive(kTechId.CystCarapace)
techHandler:RemoveAlienTechMapTech(kTechId.CystCarapace)
techHandler:RemoveAlienTechMapLine(kTechId.CragHive, kTechId.CystCarapace)

techHandler:RemoveAlienPassive(kTechId.CystCamouflage)
techHandler:RemoveAlienTechMapTech(kTechId.CystCamouflage)
techHandler:RemoveAlienTechMapLine(kTechId.ShadeHive, kTechId.CystCamouflage)

local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienBuyNode(kTechId.Vampirism)
techHandler:RemoveAlienTechMapTech(kTechId.Vampirism)
techHandler:RemoveAlienTechMapLine(kTechId.Shell, kTechId.Vampirism)

-- Shift Carapace a bit to the left 
techHandler:ChangeAlienTechMapTech(kTechId.Carapace, 3, 5)
techHandler:ChangeAlienTechMapLine(kTechId.Shell, kTechId.Carapace)

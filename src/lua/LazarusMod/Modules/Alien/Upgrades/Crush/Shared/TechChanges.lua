local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienBuyNode(kTechId.Crush)
techHandler:RemoveAlienTechMapTech(kTechId.Crush)
techHandler:RemoveAlienTechMapLine(kTechId.Spur, kTechId.Crush)

-- Shift Celerity a bit to the left 
techHandler:ChangeAlienTechMapTech(kTechId.Celerity, 9, 5)
techHandler:ChangeAlienTechMapLine(kTechId.Spur, kTechId.Celerity)

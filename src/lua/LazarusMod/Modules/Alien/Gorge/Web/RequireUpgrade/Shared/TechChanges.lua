local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienPassive(kTechId.WebTech)
techHandler:AddAlienResearchNode(kTechId.WebTech, kTechId.BioMassFive, kTechId.None, kTechId.AllAliens)
techHandler:AddAlienTechMapTech(kTechId.WebTech, 7, 10)

techHandler:ChangeAlienBuyNode(kTechId.Web, kTechId.WebTech)

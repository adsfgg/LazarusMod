local techHandler = LazarusMod:GetModule('techhandler')

techHandler:RemoveAlienBuyNode(kTechId.Focus)
techHandler:RemoveAlienTechMapTech(kTechId.Focus)
techHandler:RemoveAlienTechMapLine(kTechId.Veil, kTechId.Focus)


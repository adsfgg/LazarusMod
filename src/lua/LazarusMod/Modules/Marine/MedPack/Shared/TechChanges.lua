local techHandler = LazarusMod:GetModule('techhandler')

techHandler:ChangeTechData(kTechId.MedPack, {
    [kCommanderSelectRadius] = techHandler.Remove
})

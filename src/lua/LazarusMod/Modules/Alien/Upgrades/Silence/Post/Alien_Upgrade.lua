local HasUpgrade = debug.getupvaluex(GetHasRegenerationUpgrade, "HasUpgrade")

function GetHasSilenceUpgrade(callingEntity)
    return HasUpgrade(callingEntity, kTechId.Silence)
end

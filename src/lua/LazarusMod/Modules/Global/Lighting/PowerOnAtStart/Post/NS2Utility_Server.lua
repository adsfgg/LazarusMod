local logger = LazarusMod:GetModule('logger')

function DestroyPowerForLocation(locationName, instantAuxilaryLights)
    logger:PrintWarn("Ignoring call to DestroyPowerForLocation(%s, %s)", locationName, instantAuxilaryLights)
end
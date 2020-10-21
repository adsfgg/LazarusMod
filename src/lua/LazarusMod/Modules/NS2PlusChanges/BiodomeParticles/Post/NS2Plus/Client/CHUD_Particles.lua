-- Block Biodome props on biodome_old.

local logger = LazarusMod:GetModule('logger')
logger:PrintInfo("Attempting to modify NS2Plus -- blockedProps")

local blockedProps = debug.getupvaluex(LoadMapEntity, "blockedProps", false)
blockedProps["ns2_biodome_old"] = blockedProps["ns2_biodome"]
debug.setupvaluex(LoadMapEntity, "blockedProps", blockedProps, false)

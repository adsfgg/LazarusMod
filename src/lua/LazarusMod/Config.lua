--[[
    ==========================================================
                          Mod Framework
    ==========================================================
    
    This is the main config file for your mod.

    For information on how to use this file see the wiki.
]]

function GetModFrameworkConfigLazarusMod()
    -- Main config
    local config = {}

    -- Logger
    config.logger = {}
    config.logger.enabled = true
    config.logger.level = "fatal"

    -- Versioning
    config.versioning = {}
    config.versioning.revision = 2
    config.versioning.display = true

    -- Tech Handler
    config.techhandler = {}
    config.techhandler.techIdsToAdd = {
        "GorgeTunnelEntrance",
        "GorgeTunnelExit",

        "Silence",

        "NanoShieldTech",
        "CatPackTech",
    }
    
    return config
end

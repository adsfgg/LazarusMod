Script.Load("lua/LazarusMod/Modules/Alien/Gorge/Tunnels/New/GorgeTunnelAbility.lua")

class 'GorgeTunnelExitAbility' (GorgeTunnelAbility)

function GorgeTunnelExitAbility:GetTunnelClass()
    return TunnelExit
end

function GorgeTunnelExitAbility:GetDropStructureId()
    return kTechId.GorgeTunnelExit
end

function GorgeTunnelExitAbility:GetDropClassName()
    return "TunnelExit"
end

function GorgeTunnelExitAbility:GetDropMapName()
    return TunnelExit.kMapName
end

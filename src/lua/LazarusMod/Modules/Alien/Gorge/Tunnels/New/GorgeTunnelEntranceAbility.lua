Script.Load("lua/LazarusMod/Modules/Alien/Gorge/Tunnels/New/GorgeTunnelAbility.lua")

class 'GorgeTunnelEntranceAbility' (GorgeTunnelAbility)

function GorgeTunnelEntranceAbility:GetTunnelClass()
    return TunnelEntrance
end

function GorgeTunnelEntranceAbility:GetDropStructureId()
    return kTechId.GorgeTunnelEntrance
end

function GorgeTunnelEntranceAbility:GetDropClassName()
    return "TunnelEntrance"
end

function GorgeTunnelEntranceAbility:GetDropMapName()
    return TunnelEntrance.kMapName
end

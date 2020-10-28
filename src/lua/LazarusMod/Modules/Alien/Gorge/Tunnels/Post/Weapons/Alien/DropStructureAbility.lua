Script.Load("lua/LazarusMod/Modules/Alien/Gorge/Tunnels/New/GorgeTunnelEntranceAbility.lua")
Script.Load("lua/LazarusMod/Modules/Alien/Gorge/Tunnels/New/GorgeTunnelExitAbility.lua")

DropStructureAbility.kSupportedStructures = { HydraStructureAbility, ClogAbility, BabblerEggAbility, GorgeTunnelEntranceAbility, GorgeTunnelExitAbility, WebsAbility }

local kMaxStructuresPerType = 20
local networkVars = 
{
    numHydrasLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
    numWebsLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
    numClogsLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
    numTunnelEntrancesLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
    numTunnelExitsLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
    numBabblersLeft = string.format("private integer (0 to %d)", kMaxStructuresPerType),
}

local oldOnCreate = DropStructureAbility.OnCreate
function DropStructureAbility:OnCreate()
    oldOnCreate(self)
    self.numTunnelEntrancesLeft = 0
    self.numTunnelExitsLeft = 0
end

local oldGetNumStructuresBuilt = DropStructureAbility.GetNumStructuresBuilt
function DropStructureAbility:GetNumStructuresBuilt(techId)
    if techId == kTechId.GorgeTunnelEntrance then
        return self.numTunnelEntrancesLeft
    end

    if techId == kTechId.GorgeTunnelExit then
        return self.numTunnelExitsLeft
    end

    return oldGetNumStructuresBuilt(self, techId) 
end

function DropStructureAbility:DropStructure(player, origin, direction, structureAbility, lastClickedPosition, lastClickedPositionNormal)

    -- If we have enough resources
    if Server then

        local coords, valid, onEntity = self:GetPositionForStructure(origin, direction, structureAbility, lastClickedPosition, lastClickedPositionNormal)
        local techId = structureAbility:GetDropStructureId()

        local maxStructures = -1

        if not LookupTechData(techId, kTechDataAllowConsumeDrop, false) then
            maxStructures = LookupTechData(techId, kTechDataMaxAmount, 0)
        end

        valid = valid and self:GetNumStructuresBuilt(techId) ~= maxStructures -- -1 is unlimited

        local cost = LookupTechData(structureAbility:GetDropStructureId(), kTechDataCostKey, 0)
        local enoughRes = player:GetResources() >= cost
        local energyCost = structureAbility:GetEnergyCost()
        local enoughEnergy = player:GetEnergy() >= energyCost

        if valid and enoughRes and structureAbility:IsAllowed(player) and enoughEnergy and not self:GetHasDropCooldown() then

            -- Create structure
            local structure = self:CreateStructure(coords, player, structureAbility)

            if structure then

                structure:SetOwner(player)

                if HasMixin(structure, "ClogFall") then
                    if onEntity then
                        if onEntity:isa("Clog") then
                            onEntity:ConnectToClog(structure)
                        elseif structure:isa("Clog") and onEntity:isa("Web") then
                            onEntity:ConnectToClog(structure)
                        else
                            structure.fallWaiting = 0.0
                            structure:SetUpdates(true, kDefaultUpdateRate)
                        end
                    else
                        -- touching level, therefore can never move again, as the level doesn't move.
                        structure.doneFalling = true
                    end
                end

                player:GetTeam():AddGorgeStructure(player, structure)

                -- Check for space
                if structure:SpaceClearForEntity(coords.origin) then

                    local angles = Angles()

                    if structure:isa("BabblerEgg") and coords.yAxis.y > 0.8 then
                        angles.yaw = math.random() * math.pi * 2

                    elseif structure:isa("Clog") then

                        angles.yaw = math.random() * math.pi * 2
                        angles.pitch = math.random() * math.pi * 2
                        angles.roll = math.random() * math.pi * 2
                    elseif structure:isa("TunnelEntrace") then
                        angles:BuildFromCoords(coords)
                        angles.roll = 0
                        angles.pitch = 0
                    else
                        angles:BuildFromCoords(coords)
                    end

                    structure:SetAngles(angles)

                    if structure.SetVariant then
                        structure:SetVariant(player:GetVariant())
                    end

                    if structure.OnCreatedByGorge then
                        structure:OnCreatedByGorge()
                    end

                    player:AddResources(-cost)

                    player:DeductAbilityEnergy(energyCost)
                    player:TriggerEffects("spit_structure", {effecthostcoords = Coords.GetLookIn(origin, direction)} )

                    if structureAbility.OnStructureCreated then
                        structureAbility:OnStructureCreated(structure, lastClickedPosition)
                    end

                    self.timeLastDrop = Shared.GetTime()

                    return true

                else

                    player:TriggerInvalidSound()
                    DestroyEntity(structure)

                end

            else
                player:TriggerInvalidSound()
            end

        else

            if not valid then
                player:TriggerInvalidSound()
            elseif not enoughRes then
                player:TriggerInvalidSound()
            end

        end

    end

    return true

end

function DropStructureAbility:ProcessMoveOnWeapon(input)
    -- Show ghost if we're able to create structure, and if menu is not visible
    local player = self:GetParent()
    if player then
        if Server then
            local team = player:GetTeam()
            local numAllowedHydras = LookupTechData(kTechId.Hydra, kTechDataMaxAmount, -1)
            local numAllowedClogs = LookupTechData(kTechId.Clog, kTechDataMaxAmount, -1)
            local numAllowedWebs = LookupTechData(kTechId.Web, kTechDataMaxAmount, -1)
            local numAllowedTunnelEntrances = LookupTechData(kTechId.GorgeTunnelEntrance, kTechDataMaxAmount, -1)
            local numAllowedTunnelExits = LookupTechData(kTechId.GorgeTunnelExit, kTechDataMaxAmount, -1)
            local numAllowedBabblers = LookupTechData(kTechId.BabblerEgg, kTechDataMaxAmount, -1)

            if numAllowedHydras >= 0 then
                self.numHydrasLeft = team:GetNumDroppedGorgeStructures(player, kTechId.Hydra)
            end

            if numAllowedClogs >= 0 then
                self.numClogsLeft = team:GetNumDroppedGorgeStructures(player, kTechId.Clog)
            end

            if numAllowedWebs >= 0 then
                self.numWebsLeft = team:GetNumDroppedGorgeStructures(player, kTechId.Web)
            end

            if numAllowedTunnelEntrances >= 0 then
                self.numTunnelEntrancesLeft = team:GetNumDroppedGorgeStructures(player, kTechId.GorgeTunnelEntrance)
            end

            if numAllowedTunnelExits >= 0 then
                self.numTunnelExitsLeft = team:GetNumDroppedGorgeStructures(player, kTechId.GorgeTunnelExit)
            end

            if numAllowedBabblers >= 0 then
                self.numBabblersLeft = team:GetNumDroppedGorgeStructures(player, kTechId.BabblerEgg)
            end
        end
    end
end

Shared.LinkClassToMap("DropStructureAbility", DropStructureAbility.kMapName, networkVars)

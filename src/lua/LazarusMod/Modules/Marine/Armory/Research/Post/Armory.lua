function Armory:GetItemList(forPlayer)
    local itemList = {
        kTechId.Welder,
        kTechId.LayMines,
        kTechId.Shotgun,
        kTechId.Flamethrower, -- Add ft
        kTechId.ClusterGrenade,
        kTechId.GasGrenade,
        kTechId.PulseGrenade
    }

    if self:GetTechId() == kTechId.AdvancedArmory then
        itemList = {
            kTechId.Welder,
            kTechId.LayMines,
            kTechId.Shotgun,
            kTechId.Flamethrower,
            kTechId.GrenadeLauncher,
            kTechId.HeavyMachineGun,
            kTechId.ClusterGrenade,
            kTechId.GasGrenade,
            kTechId.PulseGrenade,
        }
    end

    return itemList
end

function Armory:GetTechButtons(techId)
    local techButtons = {
        kTechId.ShotgunTech, kTechId.MinesTech, kTechId.GrenadeTech, kTechId.FlamethrowerTech,
        kTechId.None, kTechId.None, kTechId.None, kTechId.None 
    }
    
    -- Show button to upgraded to advanced armory
    if self:GetTechId() == kTechId.Armory and self:GetResearchingId() ~= kTechId.AdvancedArmoryUpgrade then
        techButtons[kMarineUpgradeButtonIndex] = kTechId.AdvancedArmoryUpgrade
    else
        techButtons[5] = kTechId.HeavyMachineGunTech
        techButtons[6] = kTechId.GrenadeLauncherTech
    end

    return techButtons
end

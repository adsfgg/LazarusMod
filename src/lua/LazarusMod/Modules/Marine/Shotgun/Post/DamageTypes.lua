function NS2Gamerules_GetUpgradedDamageScalar( attacker, weaponTechId )
    if GetHasTech(attacker, kTechId.Weapons3, true) then
        return kWeapons3DamageScalar
    elseif GetHasTech(attacker, kTechId.Weapons2, true) then
        return kWeapons2DamageScalar
    elseif GetHasTech(attacker, kTechId.Weapons1, true) then
        return kWeapons1DamageScalar
    end

    return 1.0
end
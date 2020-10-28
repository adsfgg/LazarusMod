function Babbler:ModifyDamageTaken(damageTable, attacker, doer, damageType, hitPoint)
    damageTable.damage = math.min(20, damageTable.damage)
end
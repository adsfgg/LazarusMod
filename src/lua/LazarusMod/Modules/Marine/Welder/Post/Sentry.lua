function Sentry:OnWeldOverride(entity, elapsedTime)
    local welded = false
    
    -- faster repair rate for sentries, promote use of welders
    if entity:isa("Welder") then
        local amount = kWelderSentryRepairRate * elapsedTime     
        self:AddHealth(amount)
    elseif entity:isa("MAC") then
        self:AddHealth(MAC.kRepairHealthPerSecond * elapsedTime)
    end 
end
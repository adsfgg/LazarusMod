function WeldableMixin:OnWeld(doer, elapsedTime, player, weldPerSecOverride)
    if self:GetCanBeWelded(doer) then
        if self.OnWeldOverride then
            self:OnWeldOverride(doer, elapsedTime, weldPerSecOverride)
        elseif doer:isa("MAC") then
            self:AddHealth(MAC.kRepairHealthPerSecond * elapsedTime)
        elseif doer:isa("Welder") then
            self:AddHealth(doer:GetRepairRate(self) * elapsedTime)
        end
        
        if player and player.OnWeldTarget then
            player:OnWeldTarget(self)
        end 
    end 
end
function JetpackMarine:GetFuel()
    local dt = Shared.GetTime() - self.timeJetpackingChanged
    local rate = -kJetpackUseFuelRate

    if not self.jetpacking then
        rate = kJetpackReplenishFuelRate
        dt = math.max(0, dt - JetpackMarine.kJetpackFuelReplenishDelay)
    end

    if self:GetDarwinMode() then
        return 1
    else
        return Clamp(self.jetpackFuelOnChange + rate * dt, 0, 1)
    end
end
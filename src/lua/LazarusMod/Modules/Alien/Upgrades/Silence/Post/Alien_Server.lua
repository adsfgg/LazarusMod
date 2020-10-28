local oldOnProcessMove = Alien.OnProcessMove
function Alien:OnProcessMove(input)
    oldOnProcessMove(self, input)
    self:UpdateSilenceLevel()
end

function Alien:UpdateSilenceLevel()
    if GetHasSilenceUpgrade(self) then
        self.silenceLevel = self:GetVeilLevel()
    else
        self.silenceLevel = 0
    end
end
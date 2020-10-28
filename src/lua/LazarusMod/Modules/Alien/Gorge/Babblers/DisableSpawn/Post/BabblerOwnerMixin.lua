BabblerOwnerMixin.networkVars = 
{
	babblerCount = "integer (0 to 6)" -- reduce from 18
}

function BabblerOwnerMixin:__initmixin()
    PROFILE("BabblerOwnerMixin:__initmixin")
    self.babblerCount = 0
end

local kDrifterSelfOrderRange = 12
local IsBeingGrown = debug.getupvaluex(Drifter.OnOverrideOrder, "IsBeingGrown")
local PlayOrderedSounds = debug.getupvaluex(Drifter.OnOverrideOrder, "PlayOrderedSounds")
local UpdateTasks = debug.getupvaluex(Drifter.OnUpdate, "UpdateTasks")

local function FindTask(self)
    -- find ungrown structures that aren't cysts
    for _, structure in ipairs(GetEntitiesWithMixinForTeamWithinRange("Construct", self:GetTeamNumber(), self:GetOrigin(), kDrifterSelfOrderRange)) do
        if not structure:GetIsBuilt() and not IsBeingGrown(self, structure) and (not structure.GetCanAutoBuild or structure:GetCanAutoBuild()) and not structure:isa("Cyst") then
            self:GiveOrder(kTechId.Grow, structure:GetId(), structure:GetOrigin(), nil, false, false)
            return
        end
    end
end

function Drifter:OnOverrideOrder(order)
    local orderTarget

    if order:GetParam() ~= nil then
        orderTarget = Shared.GetEntity(order:GetParam())
    end

    local orderType = order:GetType()
    if orderType == kTechId.Default or orderType == kTechId.Grow or orderType == kTechId.Move then
        if orderTarget and HasMixin(orderTarget, "Construct") and not orderTarget:GetIsBuilt() and GetAreFriends(self, orderTarget) and not IsBeingGrown(self, orderTarget) and (not orderTarget.GetCanAutoBuild or orderTarget:GetCanAutoBuild()) and not orderTarget:isa("Cyst") then
            order:SetType(kTechId.Grow)
        elseif orderTarget and orderTarget:isa("Alien") and orderTarget:GetIsAlive() then
            order:SetType(kTechId.Follow)
        else
            order:SetType(kTechId.Move)
        end
    end

    if GetAreEnemies(self, orderTarget) then
        order.orderParam = -1
    end

    PlayOrderedSounds(self)
end

debug.setupvaluex(UpdateTasks, "FindTask", FindTask)
debug.setupvaluex(Drifter.OnUpdate, "UpdateTasks", UpdateTasks)

local oldUpdateButton = debug.getupvaluex(GUIGorgeBuildMenu.Update, "UpdateButton")
local kCenteredStructureCountPos = debug.getupvaluex(oldUpdateButton, "kCenteredStructureCountPos")
local kDefaultStructureCountPos = debug.getupvaluex(oldUpdateButton, "kDefaultStructureCountPos")

local rowTable
local function GetRowForTechId(techId)
    if not rowTable then
        rowTable = {}
        rowTable[kTechId.Hydra] = 1
        rowTable[kTechId.BabblerEgg] = 2
        rowTable[kTechId.Clog] = 3
        rowTable[kTechId.GorgeTunnelEntrance] = 4
        rowTable[kTechId.GorgeTunnelExit] = 4
        rowTable[kTechId.Web] = 5
    end
    
    return rowTable[techId]
end

local function UpdateButton(button, index)
    local col = 1
    local color = GUIGorgeBuildMenu.kAvailableColor
    
    if button.techId == kTechId.GorgeTunnelEntrance then
        color = Color(0, 1, 0.2, 1)
    elseif button.techId == kTechId.GorgeTunnelExit then
        color = Color(0.8, 0.6, 1, 1)
    end

    if not GorgeBuild_GetCanAffordAbility(button.techId) then
        col = 2
        color = GUIGorgeBuildMenu.kTooExpensiveColor
    end
    
    if not GorgeBuild_GetIsAbilityAvailable(index) then
        col = 3
        color = GUIGorgeBuildMenu.kUnavailableColor
    end
    
    local row = GetRowForTechId(button.techId)
   
    button.graphicItem:SetTexturePixelCoordinates(GUIGetSprite(col, row, GUIGorgeBuildMenu.kPixelSize, GUIGorgeBuildMenu.kPixelSize))
    button.description:SetColor(color)
    button.costIcon:SetColor(color)
    button.costText:SetColor(color)

    local numLeft = GorgeBuild_GetNumStructureBuilt(button.techId)
    if numLeft == -1 then
        button.structuresLeft:SetIsVisible(false)
    else
        button.structuresLeft:SetIsVisible(true)
        local amountString = ToString(numLeft)
        local maxNum = GorgeBuild_GetMaxNumStructure(button.techId)
        
        if maxNum > 0 then
            amountString = amountString .. "/" .. ToString(maxNum)
        end
        
        if numLeft >= maxNum then
            color = GUIGorgeBuildMenu.kTooExpensiveColor
        end
        
        button.structuresLeft:SetColor(color)
        button.structuresLeft:SetText(amountString)
    end    
    
    local cost = GorgeBuild_GetStructureCost(button.techId)
    if cost == 0 then
        button.costIcon:SetIsVisible(false)
        button.structuresLeft:SetPosition(kCenteredStructureCountPos)
    else
        button.costIcon:SetIsVisible(true)
        button.costText:SetText(ToString(cost))
        button.structuresLeft:SetPosition(kDefaultStructureCountPos)
    end
end

debug.setupvaluex(GUIGorgeBuildMenu.Update, "UpdateButton", UpdateButton)

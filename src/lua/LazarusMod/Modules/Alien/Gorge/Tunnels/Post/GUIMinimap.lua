-- local kBlipInfo = debug.getupvaluex(GUIMinimap.Initialize, "kBlipInfo")
-- local kBlipColorType = debug.getupvaluex(GUIMinimap.Initialize, "kBlipColorType")
-- local kBlipSizeType = debug.getupvaluex(GUIMinimap.Initialize, "kBlipSizeType")
-- local kStaticBlipsLayer = debug.getupvaluex(GUIMinimap.Initialize, "kStaticBlipsLayer")
-- kBlipInfo[kMinimapBlipType.TunnelEntrance] = {kBlipColorType.MAC, kBlipSizeType.Normal, kStaticBlipsLayer}

-- debug.setupvaluex(GUIMinimap.Initialize, "kBlipInfo", kBlipInfo)

-- Initialize a minimap item (icon) from a blipType
function GUIMinimap:InitMinimapIcon(item, blipType, blipTeam)

    local blipInfo = self.blipInfoTable[blipType]
    local texCoords, colorType, sizeType, layer = blipInfo[1], blipInfo[2], blipInfo[3], blipInfo[4]

    item.blipType = blipType
    item.blipSizeType = sizeType
    item.blipSize = self.blipSizeTable[item.blipSizeType]
    item.blipTeam = blipTeam

    if item.blipType == kMinimapBlipType.TunnelEntrance then
        if item.blipTeam == kMinimapBlipTeam.InactiveAlien then
            item.blipColor = Color(0, 85/255, 17/255, 1)
        else
            item.blipColor = Color(0, 1, 0.2, 1)
        end
    elseif item.blipType == kMinimapBlipType.TunnelExit then
        if item.blipTeam == kMinimapBlipTeam.InactiveAlien then
            item.blipColor = Color(68/255, 51/255, 85/255, 1)
        else
            item.blipColor = Color(0.8, 0.6, 1, 1)
        end
    else
        item.blipColor = self.blipColorTable[item.blipTeam][colorType]
    end

    item:SetLayer(layer)
    item:SetTexturePixelCoordinates(GUIUnpackCoords(texCoords))
    item:SetSize(item.blipSize)
    item:SetColor(item.blipColor)
    item:SetStencilFunc(self.stencilFunc)
    item:SetTexture(self.iconFileName)
    item:SetIsVisible(self.visible)

    item.resetMinimapItem = false

    return item
end
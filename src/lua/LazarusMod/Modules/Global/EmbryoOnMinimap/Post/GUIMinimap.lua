local kBlipInfo = debug.getupvaluex(GUIMinimap.Initialize, "kBlipInfo")
local kBlipColorType = debug.getupvaluex(GUIMinimap.Initialize, "kBlipColorType")
local kBlipSizeType = debug.getupvaluex(GUIMinimap.Initialize, "kBlipSizeType")
local kStaticBlipsLayer = debug.getupvaluex(GUIMinimap.Initialize, "kStaticBlipsLayer")

kBlipInfo[kMinimapBlipType.Egg] = { kBlipColorType.Team, kBlipSizeType.Egg, kStaticBlipsLayer, "Infestation" }

debug.setupvaluex(GUIMinimap.Initialize, "kBlipInfo", kBlipInfo)

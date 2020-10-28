-- The blackout length after a power node is destroyed was lowered and not included in any change logs.
-- Tut tut tut.

local kOffTime = 15 --12
debug.setupvaluex(NoPowerLightWorker.Run, "kOffTime", kOffTime, false)
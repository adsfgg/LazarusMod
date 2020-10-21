-- This is the same width as vanilla, but with 1.2 height.
-- 
-- There is an issue with 1 height when you're on top of a marine's head you can't hit them unless you crouch
-- This is true for most structures too.
-- Something to consider...

function SwipeBlink:GetMeleeBase()
    return .7, 1
end
local oldBuildClassToGrid = BuildClassToGrid
function BuildClassToGrid()
    local classToGrid = oldBuildClassToGrid()
    classToGrid["TunnelExit"] = {3,8}
    return classToGrid
end

SWEP.Base = "rust_swep"

SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/darky_m/rust/w_buildingplan.mdl"

SWEP.Primary.Automatic = false

util.PrecacheModel("models/environment/crates/locked_crate.mdl")

local function IsInTerrain(pos)
    local tr = {}
    tr.start = pos
    tr.endpos = pos - Vector(0, 0, 120)
    tr.filter = pl
    tr = util.TraceLine(tr)
    return (tr.Hit and tr.HitTexture == "**displacement**")
end

function SWEP:GetBuildTransform(index, rotation)
    local pl = self:GetOwner()
    local tr = pl:GetBuildTrace()

    local model = "models/environment/crates/locked_crate.mdl"
    local structure = "models/environment/crates/locked_crate.mdl"

    local pos = tr.HitPos
    local ang = tr.HitNormal:Angle()

    return pos, ang, true, true
end

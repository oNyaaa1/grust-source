AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Initialize()
    self:SetHoldType("duel")
end

function SWEP:PrimaryAttack()
		-- TODO: Find a more elegant solution
    if (game.SinglePlayer()) then
        self:CallOnClient("PrimaryAttack")
    end
end

function SWEP:PlaceBuilding(index, rotation)
    local pl = self:GetOwner()
    local block = "models/environment/crates/locked_crate.mdl"

    local pos, ang, valid, reason = self:GetBuildTransform(index, rotation)

    local ent = ents.Create("rust_lockedcrate")
    ent:SetPos(pos)
    ent:SetAngles(self:GetAngles())
    ent:SetModel(block)
    ent:Spawn()
    ent.OwnerID = pl:SteamID()

    pl:EmitSound(string.format("building/hammer_saw_%i.wav", math.random(1, 3)))
    ParticleEffect("building_smoke", ent:GetPos(), ent:GetAngles())
end

util.AddNetworkString("gRust.PlaceBuilding")
net.Receive("gRust.PlaceBuilding", function(len, pl)
    local index = net.ReadUInt(4)
    local rotation = net.ReadUInt(9)
    local swep = pl:GetActiveWeapon()
    if (!IsValid(swep) or swep:GetClass() != "rust_lc") then return end

    swep:PlaceBuilding(index, rotation)
end)

ENT.Base = "rust_lootbox"
DEFINE_BASECLASS("rust_lootbox")

ENT.Slots = 12
ENT.SelectAmount = { 3, 5 }

function ENT:OnInventoryAttached(inv)
    self.Containers = self.Containers or {}
    self.Containers[1] = inv
end

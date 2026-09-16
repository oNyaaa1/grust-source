util.AddNetworkString("RustHitmarker")

hook.Add("EntityTakeDamage", "RustHitmarker_Server", function(ent, dmg)
    local attacker = dmg:GetAttacker()
    if !ent:IsPlayer() and attacker:IsPlayer() then
        net.Start("RustHitmarker")
        net.Send(attacker)
        ent:EmitSound("combat/hitmarker.wav")
        return
    end
    if not IsValid(attacker) or not attacker:IsPlayer() then return end
    if not (ent:IsPlayer() or ent:IsNPC()) then return end

    net.Start("RustHitmarker")
    net.Send(attacker)
    ent:EmitSound("combat/hitmarker.wav")
end)

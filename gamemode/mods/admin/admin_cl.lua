local color_red = Color(255, 0, 0)
hook.Add("HUDPaint", "ESP", function()
    if not LocalPlayer():IsAdmin() then return end
    if not LocalPlayer():GetNWBool("Admin_ESP", false) then return end
    local tab = {}
    for k, v in pairs(player.GetAll()) do
        if v == LocalPlayer() then continue end
        tab[k] = v
    end

    halo.Add(tab, Color(0, 0, 255), 1, 1, 1, true, true)
    for k, v in pairs(tab) do
        local Position = (v:GetPos() + Vector(0, 0, 80)):ToScreen()
        draw.DrawText(v:Name(), "Default", Position.x, Position.y, Color(255, 255, 255, 255), 1)
    end
end)

hook.Add("PostDrawTranslucentRenderables", "MySuper3DRenderingHook", function()
    if not LocalPlayer():IsAdmin() then return end
    if not LocalPlayer():GetNWBool("Admin_ESP", false) then return end
    for k, v in pairs(player.GetAll()) do
        v.EyePosz = v:EyePos()
        render.DrawLine(v.EyePosz, v.EyePosz + v:EyeAngles():Forward() * 1200, color_red)
    end
end)

hook.Add("PostDrawTranslucentRenderables", "ESP_3D", function()
    if not LocalPlayer():IsAdmin() then return end
    if not LocalPlayer():GetNWBool("Admin_ESP", false) then return end
    local tab = {}
    local found = {}
    for k, v in pairs(ents.GetAll()) do
        if v:GetNWString("OwnerNick", "") then found[k] = v end
    end

    for k, v in pairs(found) do
        if v:GetPos():Distance(LocalPlayer():GetPos()) >= 500 then continue end
        local pos = v:GetPos() + Vector(0, 0, 0)
        local ang = (LocalPlayer():GetPos() - pos):Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        ang:RotateAroundAxis(ang:Up(), 90)
        cam.Start3D2D(pos, ang, 1)
        draw.SimpleText(tostring(found[k]:GetNWString("OwnerNick", "")), "DermaDefault", -20, -150, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end

    for k, v in pairs(player.GetAll()) do
        if v == LocalPlayer() then continue end
        tab[k] = v
    end

    for k, v in pairs(tab) do
        local pos = v:GetPos() + Vector(0, 0, 0)
        local ang = (LocalPlayer():GetPos() - pos):Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        ang:RotateAroundAxis(ang:Up(), 90)
        cam.Start3D2D(pos, ang, 1)
        surface.SetDrawColor(255, 255, 255, 128)
        surface.DrawOutlinedRect(-10, -70, 15, 90)
        draw.SimpleText(v:Nick(), "DermaDefault", -20, -150, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end)

hook.Add("CalcView", "EasyLookDown", function(ply, pos, angles, fov, znear, zfar)
    /*if not ply:IsAdmin() then return end
    if not ply:GetNWBool("Admin_Spectate", false) then return end
    local targ = ply:GetNWEntity("Admin_Spectate2", NULL)
    if targ == NULL then return end
    local eyeBone = targ:LookupBone("ValveBiped.Bip01_Head1") -- or try "eyes" if that doesn't work
    local eyePos = targ:GetShootPos()
    if eyeBone then
        local bonePos, boneAng = targ:GetBonePosition(eyeBone)
        if bonePos then eyePos = bonePos end
    end

    --local bodyAngles = targ:GetAngles()
    local view = {
        origin = eyePos + (targ:GetForward() * 10) + (targ:GetUp() * 10),
        angles = targ:EyeAngles(),
        fov = 10000000000,
        drawviewer = true,
        znear = znear,
        zfar = zfar,
    }
    return view*/
end)

hook.Add("CreateMove", "spectate", function(cmd)
    local ply = LocalPlayer()
    if not ply then return end
    if not ply:IsAdmin() then return end
    if not ply:GetNWBool("Admin_Spectate", false) then return end
    cmd:ClearMovement()
end)

RunConsoleCommand("gmod_mcore_test","1")
RunConsoleCommand("cl_threaded_bone_setup","1")
RunConsoleCommand("cl_threaded_client_leaf_system","1")
RunConsoleCommand("r_threaded_particles","1")
RunConsoleCommand("r_threaded_renderables","1")
RunConsoleCommand("r_queued_ropes","1")
RunConsoleCommand("mat_queue_mode","2")

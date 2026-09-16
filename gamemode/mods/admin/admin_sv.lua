--[[
Commands such as !goto, !tp, !cloak, !god, !esp, !mute, !ban (for a while), and !unban are required.
And make a stack of ammo and medical syringes as in x100000
and make semi-automatic mods too x100 in crates
!ban,bot06,test,1000
]]
print("Admin commands loaded")
function FindIDName(name)
    for k, v in pairs(player.GetAll()) do
        if string.find(string.lower(v:Nick()), string.lower(name)) then return v end
    end
    return NULL
end

function AddESP(ply, msg)
    local fnd = string.sub(msg, 1, #"!esp") == "!esp"
    if ply.AdminESP == nil then ply.AdminESP = false end
    if fnd and ply:GetUserGroup() == "moderator" then
        ply.AdminESP = not ply.AdminESP
        ply:SetNWBool("Admin_ESP", ply.AdminESP)
        local noclip_MSg = ply.AdminESP and "Activated" or "Deactivated"
        ply:ChatPrint("You've " .. noclip_MSg .. " ESP")
        print("You've " .. noclip_MSg .. " ESP")
        return ""
    end

    if fnd and ply:IsAdmin() then
        ply.AdminESP = not ply.AdminESP
        ply:SetNWBool("Admin_ESP", ply.AdminESP)
        local noclip_MSg = ply.AdminESP and "Activated" or "Deactivated"
        ply:ChatPrint("You've " .. noclip_MSg .. " ESP")
        print("You've " .. noclip_MSg .. " ESP")
        return ""
    end
end

function AddTeleport(ply, msg)
    if string.sub(msg, 1, #"!tp") == "!tp" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        local tr = ply:GetEyeTrace()
        nick:SetPos(tr.HitPos + tr.HitNormal * 32 + ply:GetForward() * 24)
        ply:ChatPrint("You've Teleported " .. nick)
        return ""
    end
end

hook.Add("PlayerInitialSpawn", "AddCCStatus", function(ply)
    if not file.IsDir("content_creator", "DATA") then
        file.CreateDir("content_creator")
        file.Write("content_creator/content_creator.txt", util.TableToJSON({}, true))
    end

    local fr = util.JSONToTable(file.Read("content_creator/content_creator.txt"))
    local ture = false
    for k, v in pairs(fr) do
        if v and ply:SteamID64() == v.sid then ture = true end
    end

    if ture == true then
        timer.Simple(3, function()
            ply:SetUserGroup("content_creator")
            ply:ChatPrint("You're Granted Content creator " .. ply:Nick())
        end)
    end

    if not file.IsDir("vip", "DATA") then
        file.CreateDir("vip")
        file.Write("vip/vip.txt", util.TableToJSON({}, true))
    end

    local fr = util.JSONToTable(file.Read("vip/vip.txt"))
    local ture = false
    for k, v in pairs(fr) do
        if v and ply:SteamID64() == v.sid then ture = true end
    end

    if ture == true then
        timer.Simple(3, function()
            ply:SetUserGroup("vip")
            ply:ChatPrint("You're Granted vip " .. ply:Nick())
        end)
    end

    if not file.IsDir("moderator", "DATA") then
        file.CreateDir("moderator")
        file.Write("moderator/moderator.txt", util.TableToJSON({}, true))
    end

    local fr = util.JSONToTable(file.Read("moderator/moderator.txt"))
    local ture = false
    for k, v in pairs(fr) do
        if v and ply:SteamID64() == v.sid then ture = true end
    end

    if ture == true then
        timer.Simple(3, function()
            ply:SetUserGroup("moderator")
            ply:ChatPrint("You're Granted moderator " .. ply:Nick())
        end)
    end

    ply:DrawShadow(true)
    ply:SetMaterial("")
    ply:SetRenderMode(RENDERMODE_NORMAL)
    ply:Fire("alpha", 255, 0)
    local activeWeapon = ply:GetActiveWeapon()
    if IsValid(activeWeapon) then
        activeWeapon:SetRenderMode(RENDERMODE_NORMAL)
        activeWeapon:Fire("alpha", 255, 0)
        activeWeapon:SetMaterial("")
    end

    ply:GodDisable()
end)

function AddContentCreator(ply, msg)
    if string.sub(msg, 1, #"!cc") == "!cc" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        nick:SetUserGroup("content_creator")
        if not file.IsDir("content_creator", "DATA") then
            file.CreateDir("content_creator")
            file.Write("content_creator/content_creator.txt", util.TableToJSON({}, true))
        end

        local frd = util.JSONToTable(file.Read("content_creator/content_creator.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(nick:Nick()),
            sid = nick:SteamID64(),
        })

        file.Write("content_creator/content_creator.txt", util.TableToJSON(frd, true))
        ply:ChatPrint("You've Granted " .. nick .. " Content creator")
        nick:ChatPrint("You're Granted Content creator" .. nick:Nick())
        return ""
    end
end

function AddmodCreator(ply, msg)
    if string.sub(msg, 1, #"!mod") == "!mod" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        nick:SetUserGroup("moderator")
        if not file.IsDir("moderator", "DATA") then
            file.CreateDir("moderator")
            file.Write("moderator/moderator.txt", util.TableToJSON({}, true))
        end

        local frd = util.JSONToTable(file.Read("moderator/moderator.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(nick:Nick()),
            sid = nick:SteamID64(),
        })

        file.Write("moderator/moderator.txt", util.TableToJSON(frd, true))
        ply:ChatPrint("You've Granted " .. nick:Nick() .. " moderator")
        nick:ChatPrint("You're Granted moderator " .. nick:Nick())
        return ""
    end
end

function AddvipCreator(ply, msg)
    if string.sub(msg, 1, #"!vip") == "!vip" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        print(nick:Nick())
        nick:SetUserGroup("vip")
        if not file.IsDir("vip", "DATA") then
            file.CreateDir("vip")
            file.Write("vip/vip.txt", util.TableToJSON({}, true))
        end

        local frd = util.JSONToTable(file.Read("vip/vip.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(nick:Nick()),
            sid = nick:SteamID64(),
        })

        file.Write("vip/vip.txt", util.TableToJSON(frd, true))
        ply:ChatPrint("You've Granted " .. nick:Nick() .. " VIP")
        nick:ChatPrint("You're Granted VIP " .. nick:Nick())
        return ""
    end
end

function AddscreenGrab(ply, msg)
    if string.sub(msg, 1, #"!screen") == "!screen" and ply:GetUserGroup() == "moderator" then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        if not nick then
            ply:PrintMessage(err)
            return
        end

        ply.ScreenGrabTime = CurTime() + (tonumber(explo[3]) or 60)
        nick.ScreenGrabber = ply
        net.Start("bScreenGrabStart")
        net.Send(nick)
        ply:PrintMessage(HUD_PRINTTALK, "Starting screengrab on: " .. tostring(nick:Nick()))
        return ""
    end

    if string.sub(msg, 1, #"!screen") == "!screen" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        if not nick then
            ply:PrintMessage(err)
            return
        end

        ply.ScreenGrabTime = CurTime() + (tonumber(explo[3]) or 60)
        nick.ScreenGrabber = ply
        net.Start("bScreenGrabStart")
        net.Send(nick)
        ply:PrintMessage(HUD_PRINTTALK, "Starting screengrab on: " .. tostring(nick:Nick()))
        return ""
    end
end

function AddSpectate(ply, msg)
    if string.sub(msg, 1, #"!spec") == "!spec" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        if not ply.Spectating then ply.Spectating = false end
        ply.Spectating = not ply.Spectating
        if ply.Spectating then
            ply:ChatPrint("You've spectated'd " .. nick:Nick())
           ply:Spectate(OBS_MODE_IN_EYE)
           ply:SpectateEntity(nick)
        else
            ply:ChatPrint("You've Unspectated'd " .. nick:Nick())
           ply:UnSpectate()
           ply:SetCollisionGroup(COLLISION_GROUP_NONE)
        end

        return ""
    end
end

function AddGoto(ply, msg)
    if string.sub(msg, 1, #"!goto") == "!goto" and ply:GetUserGroup() == "moderator" then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        ply:SetPos(nick:GetPos() + nick:GetForward() * 124)
        ply:ChatPrint("You've Goto'd " .. nick)
        return ""
    end

    if string.sub(msg, 1, #"!goto") == "!goto" and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        ply:SetPos(nick:GetPos() + nick:GetForward() * 124)
        ply:ChatPrint("You've Goto'd " .. nick)
        return ""
    end
end

function AddCloak(ply, msg)
    if string.sub(msg, 1, #"!cloak") == "!cloak" and ply:GetUserGroup() == "moderator" then
        ply:DrawShadow(false)
        ply:SetMaterial("models/effects/vol_light001")
        ply:SetRenderMode(RENDERMODE_TRANSALPHA)
        ply:Fire("alpha", visibility, 0)
        if IsValid(ply:GetActiveWeapon()) then
            ply:GetActiveWeapon():SetRenderMode(RENDERMODE_TRANSALPHA)
            ply:GetActiveWeapon():Fire("alpha", 0, 0)
            ply:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
            if ply:GetActiveWeapon():GetClass() == "gmod_tool" then
                ply:DrawWorldModel(false) -- tool gun has problems
            else
                ply:DrawWorldModel(true)
            end
        end

        ply:ChatPrint("You've Cloaked " .. ply:Nick())
        return ""
    end

    if string.sub(msg, 1, #"!cloak") == "!cloak" and ply:IsAdmin() then
        ply:DrawShadow(false)
        ply:SetMaterial("models/effects/vol_light001")
        ply:SetRenderMode(RENDERMODE_TRANSALPHA)
        ply:Fire("alpha", visibility, 0)
        if IsValid(ply:GetActiveWeapon()) then
            ply:GetActiveWeapon():SetRenderMode(RENDERMODE_TRANSALPHA)
            ply:GetActiveWeapon():Fire("alpha", 0, 0)
            ply:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
            if ply:GetActiveWeapon():GetClass() == "gmod_tool" then
                ply:DrawWorldModel(false) -- tool gun has problems
            else
                ply:DrawWorldModel(true)
            end
        end

        ply:ChatPrint("You've Cloaked " .. ply:Nick())
        return ""
    end
end

function AddUnCloak(ply, msg)
    if string.sub(msg, 1, #"!uncloak") == "!uncloak" and ply:GetUserGroup() == "moderator" then
        ply:DrawShadow(true)
        ply:SetMaterial("")
        ply:SetRenderMode(RENDERMODE_NORMAL)
        ply:Fire("alpha", 255, 0)
        local activeWeapon = ply:GetActiveWeapon()
        if IsValid(activeWeapon) then
            activeWeapon:SetRenderMode(RENDERMODE_NORMAL)
            activeWeapon:Fire("alpha", 255, 0)
            activeWeapon:SetMaterial("")
        end

        ply:ChatPrint("You've uncloaked " .. ply:Nick())
        return ""
    end

    if string.sub(msg, 1, #"!uncloak") == "!uncloak" and ply:IsAdmin() then
        ply:DrawShadow(true)
        ply:SetMaterial("")
        ply:SetRenderMode(RENDERMODE_NORMAL)
        ply:Fire("alpha", 255, 0)
        local activeWeapon = ply:GetActiveWeapon()
        if IsValid(activeWeapon) then
            activeWeapon:SetRenderMode(RENDERMODE_NORMAL)
            activeWeapon:Fire("alpha", 255, 0)
            activeWeapon:SetMaterial("")
        end

        ply:ChatPrint("You've uncloaked " .. ply:Nick())
        return ""
    end
end

function AddNoClip(ply, msg)
    if ply.NoClip == nil then ply.NoClip = false end
    if string.sub(msg, 1, #"!noclip") == "!noclip" and ply:GetUserGroup() == "moderator" then
        ply.NoClip = not ply.NoClip
        local noclip = ply.NoClip and MOVETYPE_NOCLIP or MOVETYPE_WALK
        local noclip_MSg = ply.NoClip and "Activated" or "Deactivated"
        ply:SetMoveType(noclip)
        ply:SetNWBool("MOVETYPE", ply.NoClip)
        ply:ChatPrint("You've " .. noclip_MSg .. " noclip")
        return ""
    end

    if string.sub(msg, 1, #"!noclip") == "!noclip" and ply:IsAdmin() then
        ply.NoClip = not ply.NoClip
        local noclip = ply.NoClip and MOVETYPE_NOCLIP or MOVETYPE_WALK
        local noclip_MSg = ply.NoClip and "Activated" or "Deactivated"
        ply:SetMoveType(noclip)
        ply:SetNWBool("MOVETYPE", ply.NoClip)
        ply:ChatPrint("You've " .. noclip_MSg .. " noclip")
        return ""
    end
end

function AddGodmode(ply, msg)
    if ply.GodMode == nil then ply.GodMode = false end
    if string.sub(msg, 1, #"!god") == "!god" and ply:GetUserGroup() == "moderator" then
        ply.GodMode = not ply.GodMode
        local noclip_MSg = ply.GodMode and "Activated" or "Deactivated"
        if ply.GodMode then
            ply:GodEnable()
        else
            ply:GodDisable()
        end

        ply:ChatPrint("You've " .. noclip_MSg .. " GodMode")
        return ""
    end

    if string.sub(msg, 1, #"!god") == "!god" and ply:IsAdmin() then
        ply.GodMode = not ply.GodMode
        local noclip_MSg = ply.GodMode and "Activated" or "Deactivated"
        if ply.GodMode then
            ply:GodEnable()
        else
            ply:GodDisable()
        end

        ply:ChatPrint("You've " .. noclip_MSg .. " GodMode")
        return ""
    end
end

hook.Add("PlayerSpawn", "VIPDAY", function(pl) end) --if not pl:IsAdmin() then pl:SetUserGroup("vip") end end)
timer.Create("banlistshower", 60 * 5, 0, function()
    local fr = file.Exists("banned/banned.txt", "DATA") and util.JSONToTable(file.Read("banned/banned.txt"))
    net.Start("gRust.SendChat")
    net.WritePlayer("Console")
    net.WriteString("Cheaters " .. table.Count(fr) .. " Have been banned!")
    net.WriteBool(false)
    net.WriteBool(false)
    net.Broadcast()
    net.Start("gRust.SendChat")
    net.WritePlayer("Console")
    net.WriteString("Читеры " .. table.Count(fr) .. " забанены!")
    net.WriteBool(false)
    net.WriteBool(false)
    net.Broadcast()
end)

local allowed = {
    ["76561197972075795"] = true, -- Me
}

hook.Add("CheckPassword", "access_whitelist", function(steamID64)
    if allowed and not allowed[steamID64] and #player.GetAll() >= 30 then return false, "Slots free for admin" end
    if not file.IsDir("banned", "DATA") then file.CreateDir("banned") end
    local fr = file.Exists("banned/banned.txt", "DATA") and util.JSONToTable(file.Read("banned/banned.txt")) or {
        banned = false
    }

    local ture = false
    local nick = ""
    for k, v in pairs(fr) do
        if v and steamID64 == v.sid and v.banned then
            nick = v.nick
            ture = true
        end
    end

    if ture == true then
        print("Rejected", nick, steamID64)
        return false, "Banned: Rejected"
    end
end)

function AddBan(ply, msg)
    local findstr = string.find(msg, "!ban")
    if findstr and ply:GetUserGroup() == "moderator" then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        if not file.IsDir("banned", "DATA") then
            file.CreateDir("banned")
            file.Write("banned/banned.txt", util.TableToJSON({}, true))
        end

        local frd = util.JSONToTable(file.Read("banned/banned.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(nick:Nick()),
            sid = nick:SteamID64(),
            banned = true,
            time = tonumber(explo[4])
        })

        file.Write("banned/banned.txt", util.TableToJSON(frd, true))
        nick:Kick(explo[3])
        ply:ChatPrint("Banned: Reason: " .. explo[3] .. " Nick: " .. tostring(nick:Nick()))
        return ""
    end

    if findstr and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nick = FindIDName(explo[2])
        if not file.IsDir("banned", "DATA") then
            file.CreateDir("banned")
            file.Write("banned/banned.txt", util.TableToJSON({}, true))
        end

        local frd = util.JSONToTable(file.Read("banned/banned.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(nick:Nick()),
            sid = nick:SteamID64(),
            banned = true,
            time = explo[4]
        })

        file.Write("banned/banned.txt", util.TableToJSON(frd, true))
        nick:Kick(explo[3])
        ply:ChatPrint("Banned: Reason: " .. explo[3] .. " Nick: " .. tostring(nick:Nick()))
        return ""
    end
end

function FindIDNameUnban(name)
    local frd = util.JSONToTable(file.Read("banned/banned.txt", "DATA"))
    for k, v in pairs(frd) do
        if string.find(string.lower(v.nick), string.lower(name)) then return k end
    end
    return NULL
end

function AddKick(ply, msg)
    local findstr = string.find(msg, "!kick")
    if findstr and ply:GetUserGroup() == "moderator" then
        local explo = string.Explode(",", msg)
        local nickz = FindIDName(explo[2])
        nickz:Kick(explo[3])
        ply:ChatPrint("Kicked: Nick: " .. tostring(nickz:Nick()))
        return ""
    end

    if findstr and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nickz = FindIDName(explo[2])
        nickz:Kick(explo[3])
        ply:ChatPrint("Kicked: Nick: " .. tostring(nickz:Nick()))
        return ""
    end
end

function AddHealthAdd(ply, msg)
    local findstr = string.find(msg, "!hp")
    if findstr and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nickz = FindIDName(explo[2])
        local hp = math.Clamp(nickz:Health() + tonumber(explo[3] or 100), 0, nickz:GetMaxHealth())
        nickz:SetHealth(hp)
        ply:ChatPrint("SetHealth: Nick: " .. tostring(nickz:Nick()) .. " Health:" .. hp .. "/" .. nickz:GetMaxHealth())
        return ""
    end
end

function AddUnBan(ply, msg)
    local findstr = string.find(msg, "!unban")
    if findstr and ply:IsAdmin() then
        local explo = string.Explode(",", msg)
        local nickz = FindIDNameUnban(explo[2])
        if not file.Exists("banned/banned.txt", "DATA") then return end
        local frd = util.JSONToTable(file.Read("banned/banned.txt", "DATA"))
        if frd == nil then return end
        frd[nickz].time = 0
        file.Write("banned/banned.txt", util.TableToJSON(frd, true))
        ply:ChatPrint("Unbanned: Nick: " .. tostring(frd[nickz].nick))
        return ""
    end
end

function AddKitBob(ply, msg)
    local findstr = string.find(string.lower(msg), "!kit")
    local findstr2 = string.find(string.lower(msg), "/kit")
    if findstr or findstr2 then
        net.Start("Kit_BobTheBuilder")
        net.Send(ply)
        return ""
    end
end

function AddKitBob2(ply, msg)
    local findstr = string.find(string.lower(msg), "/kit")
    if findstr then
        net.Start("Kit_BobTheBuilder")
        net.Send(ply)
        return ""
    end
end

function AlterTable(tbl)
    if not file.Exists("banned/banned.txt", "DATA") then return end
    local frd = util.JSONToTable(file.Read("banned/banned.txt", "DATA"))
    if frd == nil then return end
    for k, v in pairs(frd) do
        frd[k].time = (tonumber(v.time) or 1) - 1
        if tonumber(frd[k].time) <= 0 then table.remove(frd, k) end
    end

    file.Write("banned/banned.txt", util.TableToJSON(frd, true))
end

local cdBanned = 0
hook.Add("Tick", "bANaLTER", function()
    if cdBanned >= CurTime() then return end
    cdBanned = CurTime() + 1
    local check = AlterTable()
    if check == nil then return end
end)

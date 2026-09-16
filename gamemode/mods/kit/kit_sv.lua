util.AddNetworkString("BobTheBuilder")
util.AddNetworkString("Kit_BobTheBuilder")
util.AddNetworkString("KitCollect")
net.Receive("KitCollect", function(len, pl)
    if not file.IsDir("kits", "DATA") then
        file.CreateDir("kits")
        file.Write("kits/kits.txt", util.TableToJSON({}, true))
    end

    local fr = file.Exists("kits/kits.txt", "DATA") and util.JSONToTable(file.Read("kits/kits.txt")) or {
        kit = false
    }

    local timerz = 0
    local str = net.ReadString()
    local ture = false
    for k, v in pairs(fr) do
        if v and pl:SteamID64() == v.sid and v.kit == str then
            ture = true
            timerz = v.time
        end
    end

    if ture == true then
        pl:ChatPrint("You've can get ur  " .. str .. " In : " .. tostring(string.FormattedTime(timerz,"%02i:%02i")))
        return
    end

    local inv = pl:GetInventory()
    if str == "Kit Builder" and ture == false then
        local Wood = gRust.CreateItem("wood")
        Wood:SetQuantity(10000)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("metal_fragments")
        Wood:SetQuantity(1000)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("furnace")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("large_wood_box")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("building_plan")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("hammer")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("sheet_metal_double_door")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("key_lock")
        Wood:SetQuantity(2)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("sleeping_bag")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("workbench_level_1")
        Wood:SetQuantity(1)
        inv:Set(inv:FirstEmpty(), Wood)
        local frd = util.JSONToTable(file.Read("kits/kits.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(pl:Nick()),
            sid = pl:SteamID64(),
            kit = str,
            time = 60 * 15
        })

        file.Write("kits/kits.txt", util.TableToJSON(frd, true))
    end

    if str == "Kit Starter" and ture == false then
        local Wood = gRust.CreateItem("hunting_bow")
        Wood:SetQuantity(2)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("arrow")
        Wood:SetQuantity(30)
        inv:Set(inv:FirstEmpty(), Wood)
        local Wood = gRust.CreateItem("medical_syringe")
        Wood:SetQuantity(2)
        inv:Set(inv:FirstEmpty(), Wood)
        local frd = util.JSONToTable(file.Read("kits/kits.txt", "DATA"))
        table.insert(frd, {
            nick = tostring(pl:Nick()),
            sid = pl:SteamID64(),
            kit = str,
            time = 60 * 5
        })

        file.Write("kits/kits.txt", util.TableToJSON(frd, true))
    end

end)

function AlterTable(tbl)
    if not file.Exists("kits/kits.txt", "DATA") then return end
    local frd = util.JSONToTable(file.Read("kits/kits.txt", "DATA"))
    if frd == nil then return end
    for k, v in pairs(frd) do
        frd[k].time = (tonumber(v.time) or 0) - 1
        if frd[k].time <= 0 then table.remove(frd, k) end
    end

    file.Write("kits/kits.txt", util.TableToJSON(frd, true))
end

local cdBanned = 0
hook.Add("Tick", "kITERaLTER", function()
    if cdBanned >= CurTime() then return end
    cdBanned = CurTime() + 1
    local check = AlterTable()
    if check == nil then return end
end)

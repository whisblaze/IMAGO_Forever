-- ============================================================
-- IMAGO — core/SocialSync.lua
-- Peer-to-peer score sharing via addon chat messages.
-- Protocol (prefix "IMAGO"):
--   "Q"            -> score query, answered with S:<score>
--   "S:<score>"    -> score announcement/reply
--   "A:<id>:<score>" -> achievement earned broadcast
-- ============================================================

IMAGO.Social = IMAGO.Social or {}

local PREFIX = "IMAGO"
local board = {} -- sender name -> score (ephemeral, peers share while online)

local function MyName()
    local name, realm = UnitName("player")
    return (realm and realm ~= "") and (name .. "-" .. realm) or name
end

local function MyScore()
    if IMAGO.GetChronicleScore then
        return (IMAGO.GetChronicleScore())
    end
    return 0
end

local function Send(msg, channel, target)
    if C_ChatInfo and C_ChatInfo.SendAddonMessage then
        C_ChatInfo.SendAddonMessage(PREFIX, msg, channel, target)
    end
end

-- Addon broadcasts go to guild + whichever group channel applies
-- (raids hear nothing on PARTY).
local function Broadcast(msg)
    if IsInGuild and IsInGuild() then Send(msg, "GUILD") end
    if IsInRaid and IsInRaid() then
        Send(msg, "RAID")
    elseif IsInGroup and IsInGroup() then
        Send(msg, "PARTY")
    end
end

-- What kind of chronicle entry a slug points at, and its record.
local function EntryKindAndData(slug)
    local npc = IMAGO.GetNPCData and IMAGO.GetNPCData(slug)
    if npc then return "npc", npc end
    if IMAGOdb and IMAGOdb.races and IMAGOdb.races[slug] then
        return "race", IMAGOdb.races[slug]
    end
    if IMAGOdb and IMAGOdb.classes and IMAGOdb.classes[slug] then
        return "class", IMAGOdb.classes[slug]
    end
    return nil, nil
end

local KIND_LABEL_KEY = {
    npc = "TAB_FATES", race = "TAB_RACES",
    class = "TAB_CLASSES", zone = "TAB_ZONES",
}

local function KindLabel(kind)
    return IMAGO.L[KIND_LABEL_KEY[kind] or "TAB_FATES"] or "Entry"
end

-- Sorted board for the leaderboard UI (includes self)
function IMAGO.Social.GetBoard()
    local list = { { name = MyName(), score = MyScore(), isSelf = true } }
    for name, score in pairs(board) do
        list[#list + 1] = { name = name, score = score }
    end
    table.sort(list, function(a, b) return a.score > b.score end)
    return list
end

-- Ask group + guild for their scores
function IMAGO.Social.QueryScores()
    Broadcast("Q")
    -- own entry is always present; re-announce so others see us too
    if IsInGuild and IsInGuild() then Send("S:" .. MyScore(), "GUILD") end
end

-- Post own score into guild/party chat (falls back to local print)
local function Say(msg, channel)
    if C_ChatInfo and C_ChatInfo.SendChatMessage then
        C_ChatInfo.SendChatMessage(msg, channel)
    else
        SendChatMessage(msg, channel)
    end
end

function IMAGO.Social.PostScore()
    local msg = string.format("[IMAGO] %s: %d",
        IMAGO.L["ACH_SCORE"] or "Chronicle Score", MyScore())
    if IsInGuild and IsInGuild() then
        Say(msg, "GUILD")
    end
    if IsInRaid and IsInRaid() then
        Say(msg, "RAID")
    elseif IsInGroup and IsInGroup() then
        Say(msg, "PARTY")
    end
    if not IsInGuild() and not IsInGroup() then
        print(msg)
    end
end

-- Share an entry (fate/race/class): invisible addon broadcast to guild +
-- group peers plus a ready-made chat line (the player picks the channel).
function IMAGO.Social.ShareNPC(slug)
    local kind, data = EntryKindAndData(slug)
    if not kind then return end
    local name = (data and data.name) or slug
    local cat = data and data.category and (IMAGO.L[data.category] or data.category) or ""
    Broadcast("N:" .. kind .. ":" .. slug)
    local line = string.format(IMAGO.L["FACT_SHARE_LINE"] or "[IMAGO] %s: %s", KindLabel(kind), name)
    if cat ~= "" then line = line .. " — " .. cat end
    if ChatFrame_OpenChat then
        ChatFrame_OpenChat(line)
    else
        print(line)
    end
end

-- Share a zone dossier: same broadcast, labeled "Zone".
function IMAGO.Social.ShareZone(slug)
    local mapID = tonumber(tostring(slug):match("^zone:(%d+)$") or slug)
    local zd = mapID and IMAGOdb and IMAGOdb.zones and IMAGOdb.zones[mapID]
    local name = (zd and zd.name)
        or (C_Map and C_Map.GetMapInfo and (C_Map.GetMapInfo(mapID) or {}).name)
        or tostring(slug)
    Broadcast("N:zone:" .. tostring(mapID or slug))
    local line = string.format(IMAGO.L["FACT_SHARE_LINE"] or "[IMAGO] %s: %s", KindLabel("zone"), name)
    if ChatFrame_OpenChat then
        ChatFrame_OpenChat(line)
    else
        print(line)
    end
end

-- Share where a fate was found: addon broadcast with mapID + coords (shown
-- as text on the receiver's side only — no pins, no UI intrusion) plus a
-- ready-made chat line. Falls back to name/zone when no coords are stored.
function IMAGO.Social.ShareLocation(slug)
    local _, data = EntryKindAndData(slug)
    local name = (data and data.name) or slug
    local d = IMAGOSaved.discoveredAt and IMAGOSaved.discoveredAt[slug]
    -- no discovery stamp -> there is no location to share; hint instead
    if not d then
        print(string.format("|c%s[IMAGO]|r %s",
            IMAGO_HEX and IMAGO_HEX.GOLD or "FFD0AD4D",
            IMAGO.L["SHARE_LOC_UNKNOWN"] or "Location unknown — the entry hasn't been discovered yet."))
        return
    end
    local mapID = d and d.mapID or nil
    local x, y = d and d.x, d and d.y
    local zone = d and d.zone
    if (not zone or zone == "") and mapID and C_Map and C_Map.GetMapInfo then
        local ok, mi = pcall(C_Map.GetMapInfo, mapID)
        if ok and mi and mi.name then zone = mi.name end
    end
    local payload = "L:" .. slug
    if mapID and x and y then
        payload = payload .. ":" .. mapID .. ":" .. x .. ":" .. y
    end
    Broadcast(payload)
    local info = name
    if zone and zone ~= "" then info = info .. " — " .. zone end
    if x and y then info = info .. string.format(" (%.1f, %.1f)", x * 100, y * 100) end
    local line = string.format(IMAGO.L["FACT_SHARE_LOC_LINE"] or "[IMAGO] Location: %s", info)
    if ChatFrame_OpenChat then
        ChatFrame_OpenChat(line)
    else
        print(line)
    end
end

-- Called by GetChronicleScore when an achievement completes for the first time
function IMAGO.Social.OnEarned(def)
    Broadcast("A:" .. def.id .. ":" .. MyScore())
end

-- ------------------------------------------------------------
-- Incoming messages + login announce
-- ------------------------------------------------------------
local syncFrame = CreateFrame("Frame")
syncFrame:RegisterEvent("PLAYER_LOGIN")
syncFrame:SetScript("OnEvent", function(_, event, ...)
    if event == "PLAYER_LOGIN" then
        if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
            C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
        end
        syncFrame:RegisterEvent("CHAT_MSG_ADDON")
        -- Announce own score once channels are up
        if C_Timer and C_Timer.After then
            C_Timer.After(12, function()
                if IsInGuild and IsInGuild() then Send("S:" .. MyScore(), "GUILD") end
            end)
        end
        return
    end

    if event ~= "CHAT_MSG_ADDON" then return end
    local prefix, msg, channel, sender = ...
    if prefix ~= PREFIX or type(msg) ~= "string" then return end
    if sender == MyName() then return end

    local op, payload = msg:match("^(%a+):(.*)$")

    if msg == "Q" then
        local target = (channel == "WHISPER") and sender or nil
        Send("S:" .. MyScore(), channel, target)

    elseif op == "S" then
        board[sender] = tonumber(payload) or 0
        if IMAGO.Social.OnBoardChanged then IMAGO.Social.OnBoardChanged() end

    elseif op == "A" then
        local achId, sc = payload:match("^(.-):(%d+)$")
        if achId then
            board[sender] = tonumber(sc) or board[sender]
            local achName = IMAGO.L["ACH_" .. achId:upper() .. "_NAME"] or achId
            if IMAGOSaved.socialBroadcast ~= false then
                print(string.format("|c%s[IMAGO]|r %s — %s \"%s\"",
                    IMAGO_HEX and IMAGO_HEX.GOLD or "FFD0AD4D",
                    sender,
                    IMAGO.L["ACH_BROADCAST"] or "earned",
                    achName))
            end
            if IMAGO.Social.OnBoardChanged then IMAGO.Social.OnBoardChanged() end
        end

    elseif op == "N" then
        -- A peer shared an entry (npc/race/class/zone). Name only if we
        -- already found it — no spoilers.
        local kind, slug = payload:match("^(%a+):(.+)$")
        if not kind then kind, slug = "npc", payload end -- legacy "N:<slug>"
        if slug and slug ~= "" then
            local disc = IMAGOSaved.encyclopediaMode
            if not disc then
                if kind == "npc" then
                    disc = (IMAGOSaved.seenNPCs and IMAGOSaved.seenNPCs[slug])
                        or (IMAGOSaved.manualUnlocks and IMAGOSaved.manualUnlocks[slug])
                elseif kind == "race" then
                    disc = (IMAGOSaved.seenRaces and IMAGOSaved.seenRaces[slug])
                        or (IMAGOSaved.manualRaceUnlocks and IMAGOSaved.manualRaceUnlocks[slug])
                elseif kind == "class" then
                    disc = (IMAGOSaved.seenClasses and IMAGOSaved.seenClasses[slug])
                        or (IMAGOSaved.manualClassUnlocks and IMAGOSaved.manualClassUnlocks[slug])
                elseif kind == "zone" then
                    local n = tonumber(slug)
                    disc = (IMAGOSaved.seenZones and (IMAGOSaved.seenZones[n] or IMAGOSaved.seenZones[slug]))
                        or (IMAGOSaved.manualZoneUnlocks and (IMAGOSaved.manualZoneUnlocks[n] or IMAGOSaved.manualZoneUnlocks[slug]))
                end
            end
            local line
            if disc then
                local _, data = EntryKindAndData(slug)
                if not data and kind == "zone" then
                    data = IMAGOdb and IMAGOdb.zones and IMAGOdb.zones[tonumber(slug)]
                end
                line = string.format("%s — %s %s %s",
                    sender, IMAGO.L["FACT_SHARED"] or "shared a fate:",
                    KindLabel(kind), (data and data.name) or slug)
            else
                line = string.format("%s %s",
                    sender, IMAGO.L["FACT_SHARED_UNKNOWN"] or "shared an entry you haven't found yet")
            end
            print(string.format("|c%s[IMAGO]|r %s", IMAGO_HEX and IMAGO_HEX.GOLD or "FFD0AD4D", line))
        end

    elseif op == "L" then
        -- A peer shared where they found a fate: name, zone (resolved from
        -- the mapID) and the coords they stood at. Text only, nothing else.
        local slug, mapID, xs, ys = payload:match("^(.-):(%d+):([%d%.]+):([%d%.]+)$")
        slug = slug or payload
        if slug and slug ~= "" then
            local _, data = EntryKindAndData(slug)
            local info = (data and data.name) or slug
            if mapID and C_Map and C_Map.GetMapInfo then
                local ok, mi = pcall(C_Map.GetMapInfo, tonumber(mapID))
                if ok and mi and mi.name then info = info .. " — " .. mi.name end
            end
            if xs and ys then
                info = info .. string.format(" (%.1f, %.1f)",
                    (tonumber(xs) or 0) * 100, (tonumber(ys) or 0) * 100)
            end
            print(string.format("|c%s[IMAGO]|r %s %s %s",
                IMAGO_HEX and IMAGO_HEX.GOLD or "FFD0AD4D",
                sender,
                IMAGO.L["FACT_SHARED_LOC"] or "shared a location:", info))
        end
    end
end)

-- ------------------------------------------------------------
-- Player tooltip: show Chronicle Score of known IMAGO users
-- ------------------------------------------------------------
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
        if InCombatLockdown() then return end
        if tooltip ~= GameTooltip then return end
        local _, unit = tooltip:GetUnit()
        if not unit or not UnitIsPlayer(unit) then return end
        local name, realm = UnitName(unit)
        if not name then return end
        local full = (realm and realm ~= "") and (name .. "-" .. realm) or name
        local score = board[full] or board[name]
        if score then
            local c = IMAGO_COLORS and IMAGO_COLORS.GOLD or { 0.82, 0.68, 0.30 }
            tooltip:AddLine(string.format("IMAGO: %d %s",
                score, IMAGO.L["ACH_SCORE"] or "Chronicle Score"), c[1], c[2], c[3])
            tooltip:Show()
        end
    end)
end

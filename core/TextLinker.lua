-- ============================================================
-- IMAGO — core/TextLinker.lua
-- Text hyperlink system
-- ============================================================

IMAGO.TextLinker = IMAGO.TextLinker or {}

local npcList  = nil
local zoneList = nil

-- ============================================================
-- BUILD NPC LOOKUP
-- ============================================================
function IMAGO.TextLinker.BuildNameLookup()
    npcList = nil

    if not IMAGOdb or not IMAGOdb.npcs then return end

    local flat = {}   -- name (as written) → slug

    for _, entries in pairs(IMAGOdb.npcs) do
        if type(entries) == "table" then
            for slug, data in pairs(entries) do
                if type(data.name) == "string" and data.name ~= "" then
                    flat[data.name] = slug
                end
                if type(data.aliases) == "table" then
                    for _, alias in ipairs(data.aliases) do
                        if type(alias) == "string" and alias ~= "" then
                            flat[alias] = slug
                        end
                    end
                end
            end
        end
    end

    -- Convert to a sorted list, longest name first, so "Alleria Windrunner"
    -- is matched before a bare "Alleria" alias.
    npcList = {}
    for name, slug in pairs(flat) do
        npcList[#npcList + 1] = { name = name, slug = slug }
    end
    table.sort(npcList, function(a, b) return #a.name > #b.name end)
end

-- ============================================================
-- BUILD ZONE LOOKUP
-- ============================================================
function IMAGO.TextLinker.BuildZoneLookup()
    zoneList = nil

    if not IMAGOdb or not IMAGOdb.zones then return end

    local flat = {}   -- name → mapID

    for mapID, data in pairs(IMAGOdb.zones) do
        if type(data.name) == "string" and data.name ~= "" then
            flat[data.name] = mapID
        end
        if type(data.aliases) == "table" then
            for _, alias in ipairs(data.aliases) do
                if type(alias) == "string" and alias ~= "" then
                    flat[alias] = mapID
                end
            end
        end
    end

    zoneList = {}
    for name, mapID in pairs(flat) do
        zoneList[#zoneList + 1] = { name = name, mapID = mapID }
    end
    table.sort(zoneList, function(a, b) return #a.name > #b.name end)
end

-- ============================================================
-- SHARED PLAIN-TEXT LINK INJECTOR
-- Inserts `link` around the FIRST unambiguous word-boundary
-- occurrence of `searchName` in `text`.
-- Returns new text + true on success, original text + false otherwise.
-- Uses plain string.find (no patterns) for Lua 5.1 safety.
-- ============================================================
local function InjectFirstLink(text, searchName, link)
    local result = ""
    local pos    = 1

    while pos <= #text do
        local s, e = string.find(text, searchName, pos, true)
        if not s then
            result = result .. text:sub(pos)
            return result, false
        end

        local charBefore = s > 1     and text:sub(s - 1, s - 1) or ""
        local charAfter  = e < #text and text:sub(e + 1, e + 1) or ""

        if charBefore:match("%a") or charAfter:match("%a") then
            -- Part of a longer word — skip past this position
            result = result .. text:sub(pos, s)
            pos = s + 1
        else
            -- Valid word-boundary match — splice in the link and stop
            result = result .. text:sub(pos, s - 1) .. link .. text:sub(e + 1)
            return result, true
        end
    end

    return result, false
end

-- ============================================================
-- LINKNAMES
-- Replaces the first occurrence of each known NPC name (or alias)
-- and each known zone name in a lore string with a colored hyperlink.
--
--   NPC  links → |cffffe34d  soft gold
--   Zone links → |cff83dbff  ice blue
--
-- @param text       string   Raw lore text
-- @param selfSlug   string?  NPC slug of the page being shown (skipped)
-- @param selfMapID  number?  Zone mapID of the page being shown (skipped)
-- @return           string
-- ============================================================
function IMAGO.TextLinker.LinkNames(text, selfSlug, selfMapID, sharedNPCLinks, sharedZoneLinks)
    if not text or text == "" then return text end

    -- ---- 1. NPC links ----------------------------------------
    local linkedNPCSlugs = sharedNPCLinks or {}

    for _, entry in ipairs(npcList or {}) do
        local slug = entry.slug
        if slug ~= selfSlug and not linkedNPCSlugs[slug] then
            local link = "|Himago-npc:" .. slug .. "|h|" .. "c" .. IMAGO_HEX.GOLD_BRIGHT .. entry.name .. "|r|h"
            local newText, ok = InjectFirstLink(text, entry.name, link)
            if ok then
                text = newText
                linkedNPCSlugs[slug] = true
            end
        end
    end

    -- ---- 2. Zone links ----------------------------------------
    local linkedZoneIDs = sharedZoneLinks or {}

    for _, entry in ipairs(zoneList or {}) do
        local mapID = entry.mapID
        if mapID ~= selfMapID and not linkedZoneIDs[mapID] then
            local link = "|Himago-zone:" .. tostring(mapID) .. "|h|" .. "c" .. IMAGO_HEX.VOID .. entry.name .. "|r|h"
            local newText, ok = InjectFirstLink(text, entry.name, link)
            if ok then
                text = newText
                linkedZoneIDs[mapID] = true
            end
        end
    end

    return text
end

-- ============================================================
-- HYPERLINK CLICK HANDLER
-- Attach to any Frame that shows IMAGO lore via:
--   frame:SetHyperlinksEnabled(true)
--   frame:SetScript("OnHyperlinkClick", IMAGO.TextLinker.OnHyperlinkClick)
-- ============================================================
function IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
    local linkType, payload = link:match("^([^:]+):(.+)$")

    if linkType == "imago-npc" then
        if IMAGO.Chronicle and IMAGO.Chronicle.OpenToNPCSlug then
            IMAGO.Chronicle.OpenToNPCSlug(payload, { skipDiscoveryCinematic = true })
        end

    elseif linkType == "imago-zone" then
        local mapID = tonumber(payload)
        if mapID and IMAGO.Chronicle and IMAGO.Chronicle.OpenToZoneMapID then
            IMAGO.Chronicle.OpenToZoneMapID(mapID)
        end
    end
end
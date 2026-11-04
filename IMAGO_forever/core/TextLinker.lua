-- ============================================================
-- IMAGO — core/TextLinker.lua
-- Text hyperlink system
-- ============================================================

IMAGO.TextLinker = IMAGO.TextLinker or {}

local npcList      = nil
local zoneList     = nil
local codexList    = nil
local timelineList = nil

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
-- BUILD CODEX LOOKUP
-- Only entries flagged `linkable` in the static data contribute
-- their title + aliases — keeps generic words unlinked.
-- ============================================================
function IMAGO.TextLinker.BuildCodexLookup()
    codexList = nil

    if not IMAGOdb or not IMAGOdb.codex or not IMAGOdb.codex.entries then return end

    local flat = {}   -- name → slug

    for slug, data in pairs(IMAGOdb.codex.entries) do
        if data.linkable and type(data.title) == "string" and data.title ~= "" then
            flat[data.title] = slug
            if type(data.aliases) == "table" then
                for _, alias in ipairs(data.aliases) do
                    if type(alias) == "string" and alias ~= "" then
                        flat[alias] = slug
                    end
                end
            end
        end
    end

    codexList = {}
    for name, slug in pairs(flat) do
        codexList[#codexList + 1] = { name = name, slug = slug }
    end
    table.sort(codexList, function(a, b) return #a.name > #b.name end)
end

-- ============================================================
-- BUILD TIMELINE LOOKUP
-- Same rule as the Codex: only events flagged `linkable` in
-- data/timeline_static.lua contribute title + aliases.
-- ============================================================
function IMAGO.TextLinker.BuildTimelineLookup()
    timelineList = nil

    if not IMAGOdb or not IMAGOdb.timeline or not IMAGOdb.timeline.events then return end

    local flat = {}   -- name → slug

    for slug, data in pairs(IMAGOdb.timeline.events) do
        if data.linkable and type(data.title) == "string" and data.title ~= "" then
            flat[data.title] = slug
            if type(data.aliases) == "table" then
                for _, alias in ipairs(data.aliases) do
                    if type(alias) == "string" and alias ~= "" then
                        flat[alias] = slug
                    end
                end
            end
        end
    end

    timelineList = {}
    for name, slug in pairs(flat) do
        timelineList[#timelineList + 1] = { name = name, slug = slug }
    end
    table.sort(timelineList, function(a, b) return #a.name > #b.name end)
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

        -- Skip matches inside already-injected link markup (|H...|h)
        local insideLink = false
        local hStart = 1
        while true do
            local ls, le = text:find("|H", hStart, true)
            if not ls or ls >= s then break end
            local he = text:find("|h", le + 1, true)
            if not he then break end
            if s >= ls and s < he then
                insideLink = true
                break
            end
            hStart = he + 1
        end

        if insideLink or charBefore:match("%a") or charAfter:match("%a") then
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
--   All link kinds (NPC, zone, codex, timeline) share one gold: gold means
--   "clickable"; the kind is conveyed by the footer's type tag instead.
--
-- @param text       string   Raw lore text
-- @param selfSlug   string?  NPC slug of the page being shown (skipped)
-- @param selfMapID  number?  Zone mapID of the page being shown (skipped)
-- @param sharedNPCLinks   table?  Dedup set for NPC links
-- @param sharedZoneLinks  table?  Dedup set for zone links
-- @param sharedCodexLinks table?  Dedup set for codex links
-- @param selfCodexSlug  string?  Codex slug of the page being shown (skipped)
-- @param sharedTimelineLinks table?  Dedup set for timeline links
-- @param selfTimelineSlug  string?  Timeline slug of the page being shown (skipped)
-- @return           string
-- ============================================================
function IMAGO.TextLinker.LinkNames(text, selfSlug, selfMapID, sharedNPCLinks, sharedZoneLinks, sharedCodexLinks, selfCodexSlug, sharedTimelineLinks, selfTimelineSlug)
    if not text or text == "" then return text end

    -- ---- 1. NPC links ----------------------------------------
    local linkedNPCSlugs = sharedNPCLinks or {}

    for _, entry in ipairs(npcList or {}) do
        local slug = entry.slug
        if slug ~= selfSlug and not linkedNPCSlugs[slug] then
            local link = "|Himago-npc:" .. slug .. "|h|" .. "c" .. IMAGO_HEX.GOLD .. entry.name .. "|r|h"
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
            local link = "|Himago-zone:" .. tostring(mapID) .. "|h|" .. "c" .. IMAGO_HEX.GOLD .. entry.name .. "|r|h"
            local newText, ok = InjectFirstLink(text, entry.name, link)
            if ok then
                text = newText
                linkedZoneIDs[mapID] = true
            end
        end
    end

    -- ---- 3. Codex links (lowest priority — runs last) --------
    local linkedCodexSlugs = sharedCodexLinks or {}

    for _, entry in ipairs(codexList or {}) do
        local slug = entry.slug
        if slug ~= selfCodexSlug and not linkedCodexSlugs[slug] then
            local link = "|Himago-codex:" .. slug .. "|h|" .. "c" .. IMAGO_HEX.GOLD .. entry.name .. "|r|h"
            local newText, ok = InjectFirstLink(text, entry.name, link)
            if ok then
                text = newText
                linkedCodexSlugs[slug] = true
            end
        end
    end

    -- ---- 4. Timeline links (same tier as codex — runs last) --
    local linkedTimelineSlugs = sharedTimelineLinks or {}

    for _, entry in ipairs(timelineList or {}) do
        local slug = entry.slug
        if slug ~= selfTimelineSlug and not linkedTimelineSlugs[slug] then
            local link = "|Himago-timeline:" .. slug .. "|h|" .. "c" .. IMAGO_HEX.GOLD .. entry.name .. "|r|h"
            local newText, ok = InjectFirstLink(text, entry.name, link)
            if ok then
                text = newText
                linkedTimelineSlugs[slug] = true
            end
        end
    end

    return text
end

--- Zone mapID for a zone name or alias (nil if the zone is not in the DB)
function IMAGO.TextLinker.FindZoneID(name)
    for _, entry in ipairs(zoneList or {}) do
        if entry.name == name then return entry.mapID end
    end
end

-- ============================================================
-- FINDREFERENCES
-- Same lookup lists and word-boundary rule as LinkNames, but
-- instead of injecting links it returns every referenced entry,
-- ordered by first appearance across `texts`:
--   { { kind = "npc"|"zone"|"codex"|"timeline", id = ..., name = ... }, ... }
-- Higher-priority kinds claim their text span first, so a zone
-- name inside an NPC name is not counted twice.
-- @param texts  table   Array of plain strings (lore, timeline lines)
-- @param self   table?  { npc = slug, zone = mapID, codex = slug, timeline = slug }
-- ============================================================
local function FirstBoundaryMatch(text, name, claimed)
    local pos = 1
    while true do
        local s, e = string.find(text, name, pos, true)
        if not s then return nil end
        local before = s > 1 and text:sub(s - 1, s - 1) or ""
        local after  = e < #text and text:sub(e + 1, e + 1) or ""
        local free = true
        for _, c in ipairs(claimed) do
            if s <= c[2] and e >= c[1] then free = false break end
        end
        if free and not before:match("%a") and not after:match("%a") then
            return s, e
        end
        pos = s + 1
    end
end

function IMAGO.TextLinker.FindReferences(texts, selfIds)
    selfIds = selfIds or {}
    local refs, seen = {}, {}
    local passes = {
        { kind = "npc",      list = npcList,      key = "slug"  },
        { kind = "zone",     list = zoneList,     key = "mapID" },
        { kind = "codex",    list = codexList,    key = "slug"  },
        { kind = "timeline", list = timelineList, key = "slug"  },
    }
    for ti, text in ipairs(texts or {}) do
        if type(text) == "string" and text ~= "" then
            local claimed = {}
            for _, pass in ipairs(passes) do
                for _, entry in ipairs(pass.list or {}) do
                    local id = entry[pass.key]
                    local tag = pass.kind .. ":" .. tostring(id)
                    local s, e = FirstBoundaryMatch(text, entry.name, claimed)
                    if s then
                        -- Claim the span even for self/known refs so nested
                        -- names inside it are never counted separately
                        claimed[#claimed + 1] = { s, e }
                        if id ~= selfIds[pass.kind] and not seen[tag] then
                            seen[tag] = true
                            refs[#refs + 1] = { kind = pass.kind, id = id, name = entry.name,
                                                order = ti * 1000000 + s }
                        end
                    end
                end
            end
        end
    end
    table.sort(refs, function(a, b) return a.order < b.order end)
    return refs
end

-- ============================================================
-- BACKLINK INDEX
-- The reverse direction of FindReferences: for every entry A
-- whose texts reference B, A is stored under B's key. Detail
-- views merge FindReferences (outgoing) with GetBacklinks
-- (incoming), so chips always run both ways — automatically,
-- without curated related lists.
-- Built once at init, after all lookups and localized data.
-- ============================================================
local backlinkIndex = nil

function IMAGO.TextLinker.BuildBacklinkIndex()
    backlinkIndex = {}

    local function scan(kind, id, order, texts)
        for _, ref in ipairs(IMAGO.TextLinker.FindReferences(texts, { [kind] = id })) do
            local tag = ref.kind .. ":" .. tostring(ref.id)
            local list = backlinkIndex[tag]
            if not list then
                list = {}
                backlinkIndex[tag] = list
            end
            list[#list + 1] = { kind = kind, id = id, order = order or 0 }
        end
    end

    local codex = IMAGOdb and IMAGOdb.codex and IMAGOdb.codex.entries
    if codex then
        for slug, data in pairs(codex) do
            if not data.stub and type(data.body) == "string" and data.body ~= "" then
                scan("codex", slug, data.order, { data.body })
            end
        end
    end

    local timeline = IMAGOdb and IMAGOdb.timeline and IMAGOdb.timeline.events
    if timeline then
        for slug, data in pairs(timeline) do
            if not data.stub and type(data.body) == "string" and data.body ~= "" then
                scan("timeline", slug, data.order, { data.body })
            end
        end
    end

    if IMAGOdb and IMAGOdb.zones then
        for mapID, data in pairs(IMAGOdb.zones) do
            local texts = { data.lore }
            for _, poi in ipairs(data.pointsOfInterest or {}) do
                texts[#texts + 1] = poi.name
                texts[#texts + 1] = poi.lore
            end
            scan("zone", mapID, mapID, texts)
        end
    end

    if IMAGOdb and IMAGOdb.npcs then
        for _, entries in pairs(IMAGOdb.npcs) do
            if type(entries) == "table" then
                for slug, data in pairs(entries) do
                    if type(data) == "table" and type(data.lore) == "string" and data.lore ~= "" then
                        scan("npc", slug, 0, { data.lore })
                    end
                end
            end
        end
    end

    -- Race dossiers: every localized field contributes, so mentions of
    -- codex terms / zones / NPCs inside race lore backlink to the race
    if IMAGOdb and IMAGOdb.races then
        for slug, d in pairs(IMAGOdb.races) do
            local texts = { d.overview, d.history, d.culture,
                d.relationsIntro, d.groupsIntro, d.groupsFootnote }
            for _, g in pairs(d.groups or {}) do
                if type(g) == "table" then texts[#texts + 1] = g.lore end
            end
            for _, r in ipairs(d.relations or {}) do
                texts[#texts + 1] = (r.name or "") .. " " .. (r.text or "")
            end
            for _, t in pairs(d.figureText or {}) do
                if type(t) == "table" then texts[#texts + 1] = t.title end
            end
            scan("race", slug, 0, texts)
        end
    end

    -- Class dossiers, same rule
    if IMAGOdb and IMAGOdb.classes then
        for slug, d in pairs(IMAGOdb.classes) do
            local texts = { d.overview, d.history, d.racesIntro,
                d.racesFoot, d.orgsIntro, d.orgsFoot, d.variants }
            for _, e in ipairs(d.raceEntries or {}) do
                texts[#texts + 1] = e.text
            end
            for _, g in pairs(d.groups or {}) do
                if type(g) == "table" then texts[#texts + 1] = g.lore end
            end
            for _, t in pairs(d.figureText or {}) do
                if type(t) == "table" then texts[#texts + 1] = t.title end
            end
            scan("class", slug, 0, texts)
        end
    end

    for _, list in pairs(backlinkIndex) do
        table.sort(list, function(a, b)
            if a.order ~= b.order then return a.order < b.order end
            return tostring(a.id) < tostring(b.id)
        end)
    end
end

--- Reverse refs for one entry: every entry whose texts link to
--- `kind:id`, sorted by source order. Same { kind, id } shape
--- as FindReferences results, so it can be merged into ref lists.
function IMAGO.TextLinker.GetBacklinks(kind, id)
    local list = backlinkIndex and backlinkIndex[kind .. ":" .. tostring(id)]
    return list or {}
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

    elseif linkType == "imago-codex" then
        if IMAGO.Chronicle and IMAGO.Chronicle.OpenToCodex then
            IMAGO.Chronicle.OpenToCodex(payload)
        end

    elseif linkType == "imago-timeline" then
        if IMAGO.Chronicle and IMAGO.Chronicle.OpenToTimeline then
            IMAGO.Chronicle.OpenToTimeline(payload)
        end

    elseif linkType == "imago-race" then
        if IMAGO.Chronicle and IMAGO.Chronicle.OpenToRace then
            IMAGO.Chronicle.OpenToRace(payload)
        end

    elseif linkType == "imago-class" then
        if IMAGO.Chronicle and IMAGO.Chronicle.OpenToClass then
            IMAGO.Chronicle.OpenToClass(payload)
        end
    end
end
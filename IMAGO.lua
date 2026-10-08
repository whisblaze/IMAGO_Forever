-- ============================================================
-- IMAGO — The world has a story.
-- IMAGO.lua — Main file: init, events, coordination & scanner
-- ============================================================

IMAGO = IMAGO or {}
IMAGO.VERSION = "1.0.0" 

IMAGO.UI = IMAGO.UI or {}
IMAGO.L = IMAGO.L or {}
IMAGO.Locale = IMAGO.Locale or {}
IMAGO.LocaleData = IMAGO.LocaleData or {}

local defaults = {
    enabled       = true,
    seenZones     = {},
    seenNPCs      = {},
    seenRaces     = {},
    viewedNPCs    = {},
    viewedRaces   = {},
    manualRaceUnlocks = {},
    favorites     = {},
    history       = {},
    migratedSlugSuffix = false,
    showOnceOnlyNPC = false,
    showOnceOnlyZone = true,
    noMainLoreTimerClose = false,
    enableIdleFlashcards = true,
    keepSnippetOpen = false,
    enableMotD = true,
    opaqueUI = false,
    minimapPos    = 220,
    hideMinimap   = false,
    -- Combat & Break Contact
    closeOnCombat = true,
    enableBreakContact = true,
    breakContactDistance = 50,
    -- Debug: chat output for zone checks (raw vs. resolved uiMapID)
    debugMap      = false,
    -- Mode Toggle
    encyclopediaMode = false,
    manualUnlocks = {},
}

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================

local DEV_PLAYERS = {
    ["lyvienne"] = true,
    ["avesa"] = true,
}

function IMAGO.IsDeveloper()
    local name, realm = UnitName("player")
    if not name then return false end
    name = tostring(name):lower()
    if DEV_PLAYERS[name] then return true end
    if realm and realm ~= "" then
        local full = name .. "-" .. tostring(realm):lower()
        if DEV_PLAYERS[full] then return true end
    end
    return false
end


--- Returns the NPC record for a slug from the categorized database.
function IMAGO.GetNPCData(slug)
    if not IMAGOdb or not IMAGOdb.npcs or not slug then return nil end
    for cat, entries in pairs(IMAGOdb.npcs) do
        if type(entries) == "table" and entries[slug] then
            return entries[slug]
        end
    end
    return nil
end

--- Builds the reverse lookup (NPC ID → slug) for all categories.
function IMAGO.BuildReverseLookup()
    if not IMAGOdb or not IMAGOdb.npcs then return end
    IMAGOdb.idToSlug = {}
    for cat, entries in pairs(IMAGOdb.npcs) do
        if type(entries) == "table" then
            for slug, data in pairs(entries) do
                if data.ids then
                    for _, entry in ipairs(data.ids) do
                        local id = type(entry) == "table" and entry[1] or entry
                        IMAGOdb.idToSlug[tonumber(id)] = slug
                        IMAGOdb.idToSlug[tostring(tonumber(id)) .. "_cat"] = cat
                    end
                end
            end
        end
    end
end

--- Returns the NPC ID and type from a GUID (safe against secret strings).
function IMAGO.GetNPCIDFromGUID(guid)
    if not guid then return nil, nil end
    
    -- Since WoW 11.0 (Retail) this is the safest way for "secret strings"
    if C_CreatureInfo and C_CreatureInfo.GetCreatureIDFromGUID then
        local npcID = C_CreatureInfo.GetCreatureIDFromGUID(guid)
        if npcID then return npcID, "Creature" end
    end

    -- Fallback for older versions or if the above fails
    local ok, cType, _, _, _, _, npcIDStr = pcall(strsplit, "-", guid)
    if ok and cType then
        local isNPC = false
        pcall(function() if cType == "Creature" or cType == "Vehicle" then isNPC = true end end)
        if isNPC then return tonumber(npcIDStr), cType end
    end
    return nil, nil
end

--- Adds an entry to the history (max 50 entries).
function IMAGO.AddToHistory(entry)
    IMAGOSaved.history = IMAGOSaved.history or {}
    table.insert(IMAGOSaved.history, 1, entry)
    if #IMAGOSaved.history > 50 then
        table.remove(IMAGOSaved.history)
    end
end

-- ============================================================
-- THE SCANNER MODULE
-- ============================================================
IMAGO.Scanner = {}

function IMAGO.Scanner.DiscoverNPC(npcID, questName)
    if not IMAGOSaved.enabled then return false end
    if not IMAGOdb or not IMAGOdb.idToSlug then return false end
    
    local slug = IMAGOdb.idToSlug[npcID]
    local cat = IMAGOdb.idToSlug[tostring(npcID) .. "_cat"]

    if slug then
        local npcData = cat and IMAGOdb.npcs[cat] and IMAGOdb.npcs[cat][slug] or IMAGO.GetNPCData(slug)
        local name = npcData and npcData.name
        local lore = npcData and npcData.lore
        local isNewDiscovery = false

        if not IMAGOSaved.seenNPCs[slug] then
            IMAGOSaved.seenNPCs[slug] = true
            IMAGO.AddToHistory(slug)
            
            local msg
            if questName then
                msg = IMAGO.L["QUEST_DISCOVERY"] and string.format(IMAGO.L["QUEST_DISCOVERY"], questName, name)
            else
                msg = IMAGO.L["CHAT_DISCOVERY"] and string.format(IMAGO.L["CHAT_DISCOVERY"], name)
            end
            print(msg)
            PlaySound(3175, "Master")
            
            if IMAGO.Display and IMAGO.Display.Show then
                IMAGO.Display.Show(name, lore, "npc", true, slug)
            end

            if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
                IMAGO.Chronicle.UpdateList()
            end

            if npcData and npcData.raceKey then
                IMAGO.Scanner.DiscoverRace(npcData.raceKey)
            end

            isNewDiscovery = true
        else
            if npcData and npcData.raceKey then
                IMAGO.Scanner.DiscoverRace(npcData.raceKey)
            end
            if not IMAGO.Scanner.IsShowOnceOnlyEnabled("npc") then
                if IMAGO.Display and IMAGO.Display.Show then
                    local msgKnown = IMAGO.L["CHAT_KNOWN"] and string.format(IMAGO.L["CHAT_KNOWN"], name) or ("|cFF888888[IMAGO]|r Archiv-Eintrag abgerufen: |cFFCCCCCC" .. name .. "|r")
                    print(msgKnown)
                    IMAGO.Display.Show(name, lore, "npc", false, slug)
                end
            end
        end

        return true, isNewDiscovery
    end
    return false, false
end

--- Unlocks a race record (Races tab). Triggered when an NPC of that race is discovered.
function IMAGO.Scanner.DiscoverRace(raceSlug)
    if not IMAGOSaved or not IMAGOSaved.enabled then return false end
    if not IMAGOdb or not IMAGOdb.races then return false end
    local data = IMAGOdb.races[raceSlug]
    if not data then return false end

    IMAGOSaved.seenRaces = IMAGOSaved.seenRaces or {}
    if IMAGOSaved.seenRaces[raceSlug] then return true end

    IMAGOSaved.seenRaces[raceSlug] = true

    local name = data.name or raceSlug
    local msg = IMAGO.L["CHAT_RACE_DISCOVERY"] and string.format(IMAGO.L["CHAT_RACE_DISCOVERY"], name)
        or ("|cFF9370DB[IMAGO]|r New race documented: |cFFFFD700" .. name .. "|r")
    print(msg)
    PlaySound(3175, "Master")

    if IMAGO.Display and IMAGO.Display.Show then
        IMAGO.Display.Show(name, data.history, "race", true, raceSlug)
    end

    if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
        IMAGO.Chronicle.UpdateList()
    end

    return true
end

--- Scans all quest_ids with an NPC they unlock and reveal those whose quest is completed.
function IMAGO.Scanner.SweepQuestUnlocks()
    if not IMAGOdb or not IMAGOdb.questToSlug then return end
    for questID, slug in pairs(IMAGOdb.questToSlug) do
        if not IMAGOSaved.seenNPCs[slug] and C_QuestLog.IsQuestFlaggedCompleted(questID) then
            local questName = QuestUtils_GetQuestName(questID) or "Unknown Quest"
            local data = IMAGO.GetNPCData(slug)
            local npcID = data and data.ids and data.ids[1] and (type(data.ids[1]) == "table" and data.ids[1][1] or data.ids[1])
            if npcID then
                IMAGO.Scanner.DiscoverNPC(npcID, questName)
            end
        end
    end
end

local lastNPCID = nil
-- Last processed zone key: "c:<uiMapID>" = IMAGO zone, "r:<uiMapID>" = raw table ID only
local lastZoneKey = nil
local zoneCheckNilRetries = 0
local ZONE_CHECK_NIL_MAX = 12

function IMAGO.Scanner.EnsureZoneProgressTables()
    if not IMAGOSaved then return end
    IMAGOSaved.seenZones = IMAGOSaved.seenZones or {}
    -- Migrate string keys from older saves to real uiMapID numbers
    local sz = IMAGOSaved.seenZones
    local toMigrate = {}
    for k, v in pairs(sz) do
        if v and type(k) == "string" then
            local n = tonumber(k)
            if n then toMigrate[k] = n end
        end
    end
    for strKey, numId in pairs(toMigrate) do
        sz[strKey] = nil
        sz[numId] = true
    end
    local dz = IMAGOSaved.discoveredZones
    if type(dz) == "table" and dz ~= IMAGOSaved.seenZones then
        for id, v in pairs(dz) do
            if v then
                local n = type(id) == "number" and id or tonumber(id)
                if n then IMAGOSaved.seenZones[n] = true end
            end
        end
    end
    IMAGOSaved.discoveredZones = IMAGOSaved.seenZones
end

--- WoW checkbuttons often return 1/nil instead of true/false — normalize for reliable logic.
function IMAGO.Scanner.IsShowOnceOnlyEnabled(type)
    if not IMAGOSaved then return false end
    local v
    if type == "npc" then
        v = IMAGOSaved.showOnceOnlyNPC
    elseif type == "zone" then
        v = IMAGOSaved.showOnceOnlyZone
    else
        return false
    end
    return v == true or v == 1
end

function IMAGO.Scanner.IsZoneMarkedSeen(zoneId)
    if not IMAGOSaved or not IMAGOSaved.seenZones then return false end
    local n = tonumber(zoneId) or zoneId
    if type(n) ~= "number" then return false end
    return not not (IMAGOSaved.seenZones[n] or IMAGOSaved.seenZones[tostring(n)])
end

--- Returns the first uiMapID on the path (incl. start) with an entry in IMAGOdb.zones, else nil.
function IMAGO.Scanner.ResolveTrackedZoneMapID(uiMapID)
    if not uiMapID or type(uiMapID) ~= "number" or not IMAGOdb or not IMAGOdb.zones then
        return nil
    end
    local id = uiMapID
    local depth = 0
    while id and depth < 24 do
        if IMAGOdb.zones[id] then
            return id
        end
        local info = C_Map.GetMapInfo(id)
        if not info then
            return nil
        end
        id = info.parentMapID
        depth = depth + 1
    end
    return nil
end

function IMAGO.Scanner.CheckNPC()
    if not UnitExists("target") then 
        lastNPCID = nil
        return 
    end

    -- During combat lockdown, unit GUIDs may be "secret strings";
    -- any string operation (e.g. strsplit) would then fail. The lore popup
    -- cannot be updated reliably here anyway.
    if InCombatLockdown() then
        return
    end

    local okGuid, guid = pcall(UnitGUID, "target")
    if not okGuid or not guid then return end

    local npcID, creatureType = IMAGO.GetNPCIDFromGUID(guid)
    if not npcID then return end

    if npcID == lastNPCID then return end
    lastNPCID = npcID
    IMAGO.Scanner.DiscoverNPC(npcID)
end

function IMAGO.Scanner.CheckZone()
    if not IMAGOSaved or not IMAGOSaved.enabled then return end
    IMAGO.Scanner.EnsureZoneProgressTables()

    local rawMapID = C_Map.GetBestMapForUnit("player")
    if not rawMapID then
        zoneCheckNilRetries = zoneCheckNilRetries + 1
        if zoneCheckNilRetries <= ZONE_CHECK_NIL_MAX then
            C_Timer.After(0.5, IMAGO.Scanner.CheckZone)
        end
        return
    end

    if not C_Map.GetMapInfo(rawMapID) then
        zoneCheckNilRetries = zoneCheckNilRetries + 1
        if zoneCheckNilRetries <= ZONE_CHECK_NIL_MAX then
            C_Timer.After(0.5, IMAGO.Scanner.CheckZone)
        end
        return
    end

    zoneCheckNilRetries = 0

    local canonicalMapID = IMAGO.Scanner.ResolveTrackedZoneMapID(rawMapID)
    local key = canonicalMapID and ("c:" .. tostring(canonicalMapID)) or ("r:" .. tostring(rawMapID))

    -- After /reload, lastZoneKey is nil: without seeding, DiscoverZone would run again.
    -- If the zone is already in seenZones and "only once" is active, align the state
    -- and do not fire a redundant popup.
    if lastZoneKey == nil and canonicalMapID and IMAGO.Scanner.IsShowOnceOnlyEnabled("zone")
        and IMAGO.Scanner.IsZoneMarkedSeen(canonicalMapID) then
        lastZoneKey = key
    end

    if IMAGOSaved.debugMap and IMAGO.isDeveloper then
        local rawInfo = C_Map.GetMapInfo(rawMapID)
        local rawName = rawInfo and rawInfo.name or "?"
        if canonicalMapID then
            local cInfo = C_Map.GetMapInfo(canonicalMapID)
            local cName = cInfo and cInfo.name or "?"
            print(string.format(
                "|cFF9370DB[IMAGO DEBUG]|r Zone-Check: raw uiMapID=%d (%s) -> tracked=%d (%s)",
                rawMapID, rawName, canonicalMapID, cName
            ))
        else
            print(string.format(
                "|cFF9370DB[IMAGO DEBUG]|r Zone-Check: raw uiMapID=%d (%s) -> keine IMAGO-Zone (Parent-Kette)",
                rawMapID, rawName
            ))
        end
    end

    if key == lastZoneKey then
        return
    end
    lastZoneKey = key

    if canonicalMapID then
        IMAGO.Scanner.DiscoverZone(canonicalMapID)
    end
end

function IMAGO.Scanner.CheckInstance() end
function IMAGO.Scanner.CheckEncounter(id) end

-- ============================================================
-- ZONE SCANNER & AUTO-POPUP
-- ============================================================

function IMAGO.Scanner.DiscoverZone(mapID)
    if not IMAGOSaved.enabled then return false end
    IMAGO.Scanner.EnsureZoneProgressTables()
    if not IMAGOdb or not IMAGOdb.zones then return false end

    local zoneData = IMAGOdb.zones[mapID]
    if not zoneData then return false end 

    local trackedID = tonumber(mapID) or mapID
    if type(trackedID) ~= "number" then return false end

    local name = zoneData.name
    local lore = zoneData.lore

    local wasSeen = IMAGO.Scanner.IsZoneMarkedSeen(trackedID)
    local isNew = not wasSeen

    IMAGOSaved.seenZones[trackedID] = true
    IMAGOSaved.discoveredZones = IMAGOSaved.seenZones

    if isNew then
        IMAGO.AddToHistory({type="zone", id=trackedID, time=time()})
        print("|cFF9370DB[IMAGO]|r Neue Region betreten: |cFFFFD700" .. name .. "|r")
    end

    local showOnceOnly = IMAGO.Scanner.IsShowOnceOnlyEnabled("zone")
    if IMAGO.Display and IMAGO.Display.Show then
        if isNew or not showOnceOnly then
            IMAGO.Display.Show(name, lore, "zone", isNew)
        end
    end

    if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
        IMAGO.Chronicle.UpdateList()
    end

    return true
end

-- ============================================================
-- FEATURE: MINIMAP BUTTON
-- ============================================================
function IMAGO.CreateMinimapButton()
    local dragFrame = CreateFrame("Button", "IMAGOMinimapButton", Minimap)
    dragFrame:SetSize(31, 31)
    dragFrame:SetFrameStrata("MEDIUM")
    dragFrame:SetFrameLevel(Minimap:GetFrameLevel() + 5)
    dragFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    dragFrame.icon = dragFrame:CreateTexture(nil, "BACKGROUND")
    dragFrame.icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09") 
    dragFrame.icon:SetSize(20, 20)
    dragFrame.icon:SetPoint("CENTER", 0, 0)
    
    dragFrame.border = dragFrame:CreateTexture(nil, "OVERLAY")
    dragFrame.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    dragFrame.border:SetSize(53, 53)
    dragFrame.border:SetPoint("TOPLEFT", 0, 0)
    
    local function UpdatePosition()
        local angle = math.rad(IMAGOSaved.minimapPos or 220)
        -- THE FIX: calculate the radius dynamically (minimap width / 2 + buffer)
        local radius = (Minimap:GetWidth() / 2) + 5 
        local x = math.cos(angle) * radius
        local y = math.sin(angle) * radius
        dragFrame:SetPoint("CENTER", Minimap, "CENTER", x, y)
    end
    
    dragFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    dragFrame:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            if IMAGO.Chronicle then IMAGO.Chronicle.Toggle() end
        elseif button == "RightButton" then
            if IMAGO.Snippets and IMAGO.Snippets.ShowRandom then
                IMAGO.Snippets.ShowRandom(true)
            end
        end
    end)
    
    dragFrame:RegisterForDrag("LeftButton")
    dragFrame:SetScript("OnDragStart", function()
        dragFrame:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            cx, cy = cx / scale, cy / scale
            local angle = math.deg(math.atan2(cy - my, cx - mx))
            if angle < 0 then angle = angle + 360 end
            IMAGOSaved.minimapPos = angle
            UpdatePosition()
        end)
    end)
    dragFrame:SetScript("OnDragStop", function()
        dragFrame:SetScript("OnUpdate", nil)
    end)

    -- Tooltip on hover
    dragFrame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:AddLine(IMAGO.L["MINIMAP_TOOLTIP_TITLE"], 1, 0.85, 0.1)
        GameTooltip:AddLine(IMAGO.L["MINIMAP_TOOLTIP_LEFTCLICK"], 1, 1, 1)
        GameTooltip:AddLine(IMAGO.L["MINIMAP_TOOLTIP_RIGHTCLICK"], 1, 1, 1)
        GameTooltip:Show()
    end)

    dragFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Reacts to UI scale and Edit Mode changes
    dragFrame:SetScript("OnEvent", UpdatePosition)
    UpdatePosition()
    
     -- Apply saved hide state
    if IMAGOSaved.hideMinimap then
        dragFrame:Hide()
    end

    IMAGO.minimapButton = dragFrame
end

-- ============================================================
-- FEATURE: "DID YOU KNOW?"
-- ============================================================
local function ShowLoginFact()
    if not IMAGOSaved.enabled then return end
    if not IMAGOSaved.enableMotD then return end
    
    local discovered = {}
    for slug, isSeen in pairs(IMAGOSaved.seenNPCs) do
        if isSeen and IMAGO.GetNPCData(slug) then
            table.insert(discovered, slug)
        end
    end
    
    if #discovered > 0 then
        local randomSlug = discovered[math.random(1, #discovered)]
        local npcData = IMAGO.GetNPCData(randomSlug)
        local name = npcData and npcData.name
        local lore = npcData and npcData.lore
        local firstSentence = lore and (lore:match("^(.-%.%s)") or lore) or ""
        
        print(string.format("|cFF9370DB[IMAGO]|r |cFFFFD700%s|r (|cFFCCCCCC%s|r) - %s", IMAGO.L["LOGIN_DID_YOU_KNOW"], name, firstSentence))
    else
        print("|cFF9370DB[IMAGO]|r |cFF888888" .. IMAGO.L["LOGIN_EMPTY_CHRONICLE"] .. "|r")
    end
end

-- ============================================================
-- ENCOUNTER JOURNAL INTEGRATION
-- ============================================================

-- Build reverse lookup: encounter_journal_id -> slug
local function BuildEJLookup()
    IMAGO.ejIDToSlug = {}
    for catKey, entries in pairs(IMAGOdb.npcs) do
        if type(entries) == "table" then
            for slug, data in pairs(entries) do
                if data.encounter_journal_id then
                    local id = data.encounter_journal_id
                    if type(id) == "table" then id = id[1] end
                    IMAGO.ejIDToSlug[id] = slug
                end
            end
        end
    end
end

local function InjectIMAGOButton(encounterID)
    if not EncounterJournal then return end

    local encounterFrame = EncounterJournal.encounter
    if not encounterFrame then return end

    if not encounterFrame.imagoBtn then
        local btn = CreateFrame("Button", nil, encounterFrame)
        btn:SetSize(22, 22)
        btn:SetPoint("TOPRIGHT", encounterFrame.info.difficulty, "TOPLEFT", -6, 0)

        btn.icon = btn:CreateTexture(nil, "ARTWORK")
        btn.icon:SetAllPoints()
        btn.icon:SetTexture("Interface\\Icons\\INV_Misc_Book_09")
        btn.icon:SetAlpha(0.7)
        btn.border = btn:CreateTexture(nil, "OVERLAY")
        btn.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
        btn.border:SetSize(58, 58)
        btn.border:SetPoint("TOPLEFT", -7, 7)

        local hl = btn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.15)

        btn:SetScript("OnEnter", function(self)
            self.icon:SetAlpha(1.0)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
            GameTooltip:AddLine("Open in IMAGO Chronicle", 1, 0.85, 0.1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function(self)
            self.icon:SetAlpha(0.7)
            GameTooltip:Hide()
        end)

        encounterFrame.imagoBtn = btn
    end

    local slug = encounterID and IMAGO.ejIDToSlug and IMAGO.ejIDToSlug[encounterID]

    if slug and (
        (IMAGOSaved.seenNPCs and IMAGOSaved.seenNPCs[slug]) or
        (IMAGOSaved.encyclopediaMode)
    ) then
        encounterFrame.imagoBtn:SetScript("OnClick", function()
            EncounterJournal:Hide()
            IMAGO.Chronicle.OpenToNPCSlug(slug)
        end)
        encounterFrame.imagoBtn:Show()
    else
        encounterFrame.imagoBtn:Hide()
    end
end

-- Wait for Blizzard_EncounterJournal to load before hooking
local ejHookFrame = CreateFrame("Frame")
ejHookFrame:RegisterEvent("ADDON_LOADED")
ejHookFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "Blizzard_EncounterJournal" then
        hooksecurefunc("EJ_SelectEncounter", InjectIMAGOButton)
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

-- Register a PLAYER_LOGIN hook to build the lookup once the DB is ready
local ejLoginFrame = CreateFrame("Frame")
ejLoginFrame:RegisterEvent("PLAYER_LOGIN")
ejLoginFrame:SetScript("OnEvent", function(self)
    BuildEJLookup()
    self:UnregisterEvent("PLAYER_LOGIN")
end)

-- ============================================================
-- WORLD MAP INTEGRATION
-- ============================================================

-- IMAGO Icon will go below all other map icons (even other addon ones) if they are parented under the WorldMapFrame
local function GetLowestMapButton(f)
    local excludeBtn = f.SidePanelToggle

    local lowestBtn = f.imagoAnchorBtn
    local lowestBottom = lowestBtn and lowestBtn:GetBottom() or nil

    local children = {f:GetChildren()}
    for _, child in ipairs(children) do
        if child ~= f.imagoBtn and child ~= excludeBtn and child:IsObjectType("Button") and child:IsShown() then
            local top = child:GetTop()
            local left = child:GetLeft()
            if top and left and lowestBtn and math.abs(left - lowestBtn:GetLeft()) < 10 then
                local bottom = child:GetBottom()
                if bottom and (not lowestBottom or bottom < lowestBottom) then
                    lowestBottom = bottom
                    lowestBtn = child
                end
            end
        end
    end

    return lowestBtn
end

local function InjectIMAGOMapButton()
    local f = WorldMapFrame
    if not f then return end

    if not f.imagoAnchorBtn then
        local children = {f:GetChildren()}
        f.imagoAnchorBtn = children[7]
    end
    if not f.imagoAnchorBtn then return end

    if not f.imagoBtn then
        local btn = CreateFrame("Button", nil, f)
        btn:SetSize(31, 31)
        btn:SetFrameStrata("DIALOG")
        btn:SetFrameLevel(f:GetFrameLevel() + 50)
        btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

        btn.icon = btn:CreateTexture(nil, "BACKGROUND")
        btn.icon:SetTexture("Interface\\Icons\\inv_misc_book_09")
        btn.icon:SetSize(20, 20)
        btn.icon:SetPoint("CENTER", 0, 0)

        btn.border = btn:CreateTexture(nil, "OVERLAY")
        btn.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
        btn.border:SetSize(53, 53)
        btn.border:SetPoint("TOPLEFT", 0, 0)

        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_LEFT")
            GameTooltip:AddLine("Open in IMAGO Chronicle", 1, 0.85, 0.1)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        f.imagoBtn = btn
    end

    -- Recalculate anchor each time, in case other addons added buttons
    local anchorBtn = GetLowestMapButton(f)
    f.imagoBtn:ClearAllPoints()
    f.imagoBtn:SetPoint("TOPRIGHT", anchorBtn, "BOTTOMRIGHT", 0, -2)

    local mapID = f:GetMapID()
    local zoneData = mapID and IMAGOdb.zones and IMAGOdb.zones[mapID]
    local isSeen = mapID and IMAGOSaved.seenZones and IMAGOSaved.seenZones[mapID]
    local isManual = mapID and IMAGOSaved.manualZoneUnlocks and IMAGOSaved.manualZoneUnlocks[mapID]

    if zoneData and (isSeen or isManual or IMAGOSaved.encyclopediaMode) then
        f.imagoBtn:SetScript("OnClick", function()
            f:Hide()
            IMAGO.Chronicle.OpenToZoneMapID(mapID)
        end)
        f.imagoBtn:Show()
    else
        f.imagoBtn:Hide()
    end
end

hooksecurefunc(WorldMapFrame, "OnMapChanged", InjectIMAGOMapButton)
WorldMapFrame:HookScript("OnShow", InjectIMAGOMapButton)

-- ============================================================
-- EVENTS & INITIALIZATION
-- ============================================================
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
initFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
initFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
initFrame:RegisterEvent("PLAYER_DEAD")
initFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
initFrame:RegisterEvent("PLAYER_CONTROL_LOST")
initFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
initFrame:RegisterEvent("QUEST_TURNED_IN")

initFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "IMAGO_forever" then IMAGO.Init() end
    elseif event == "PLAYER_ENTERING_WORLD" then
        local isInitialLogin, isReloadingUi = ...
        IMAGO.Scanner.EnsureZoneProgressTables()
        if isInitialLogin then
            C_Timer.After(2, function()
                IMAGO.Scanner.SweepQuestUnlocks()
            end)
            if IMAGOSaved and IMAGOSaved.enableMotD then
                C_Timer.After(4, ShowLoginFact)
            end
        end
        C_Timer.After(0.5, function()
            IMAGO.Scanner.CheckZone()
        end)
        C_Timer.After(2, function()
            IMAGO.Scanner.CheckZone()
            IMAGO.Scanner.CheckInstance()
        end)
    elseif event == "QUEST_TURNED_IN" then
        local questID = ...
        local slug = IMAGOdb.questToSlug and IMAGOdb.questToSlug[questID]
        if slug and not IMAGOSaved.seenNPCs[slug] then
            local questName = QuestUtils_GetQuestName(questID) or "Unknown Quest"
            local data = IMAGO.GetNPCData(slug)
            local npcID = data and data.ids and data.ids[1] and (type(data.ids[1]) == "table" and data.ids[1][1] or data.ids[1])
            if npcID then
                IMAGO.Scanner.DiscoverNPC(npcID, questName)
            end
        end
        if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
            IMAGO.Chronicle.UpdateList()
    end

    elseif event == "ZONE_CHANGED_NEW_AREA" then
        C_Timer.After(1, function() IMAGO.Scanner.CheckZone() end)
    elseif event == "PLAYER_TARGET_CHANGED" then
        IMAGO.Scanner.CheckNPC()
    elseif event == "PLAYER_DEAD" or event == "UNIT_SPELLCAST_CHANNEL_START" or event == "PLAYER_CONTROL_LOST" then
        if IMAGO.Snippets and IMAGO.Snippets.HandleEvent then
            IMAGO.Snippets.HandleEvent(event, ...)
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- Combat Mode: Close Discovery Card when entering combat
        if IMAGOSaved.closeOnCombat ~= false and IMAGO.Display.frame and IMAGO.Display.frame:IsShown() then
            IMAGO.Display.HideLorePanel()
        end
    end
end)

function IMAGO.Init()
    IMAGOSaved = IMAGOSaved or {}

    if IMAGOSaved.showOnceOnly ~= nil then
        if IMAGOSaved.showOnceOnlyNPC == nil then IMAGOSaved.showOnceOnlyNPC = IMAGOSaved.showOnceOnly end
        if IMAGOSaved.showOnceOnlyZone == nil then IMAGOSaved.showOnceOnlyZone = IMAGOSaved.showOnceOnly end
    end
    if IMAGOSaved.noTimerClose ~= nil and IMAGOSaved.noMainLoreTimerClose == nil then
        IMAGOSaved.noMainLoreTimerClose = IMAGOSaved.noTimerClose
    end

    for key, value in pairs(defaults) do
        if IMAGOSaved[key] == nil then IMAGOSaved[key] = value end
    end
    IMAGOSaved.viewedNPCs = IMAGOSaved.viewedNPCs or {}
    
    -- Normalize the booleans
    IMAGOSaved.enabled = (IMAGOSaved.enabled == true or IMAGOSaved.enabled == 1)
    IMAGOSaved.showOnceOnlyNPC = (IMAGOSaved.showOnceOnlyNPC == true or IMAGOSaved.showOnceOnlyNPC == 1)
    IMAGOSaved.showOnceOnlyZone = (IMAGOSaved.showOnceOnlyZone == true or IMAGOSaved.showOnceOnlyZone == 1)
    IMAGOSaved.noMainLoreTimerClose = (IMAGOSaved.noMainLoreTimerClose == true or IMAGOSaved.noMainLoreTimerClose == 1)
    IMAGOSaved.enableIdleFlashcards = (IMAGOSaved.enableIdleFlashcards == true or IMAGOSaved.enableIdleFlashcards == 1)
    IMAGOSaved.keepSnippetOpen = (IMAGOSaved.keepSnippetOpen == true or IMAGOSaved.keepSnippetOpen == 1)
    IMAGOSaved.enableMotD = (IMAGOSaved.enableMotD == true or IMAGOSaved.enableMotD == 1)
    IMAGOSaved.opaqueUI = (IMAGOSaved.opaqueUI == true or IMAGOSaved.opaqueUI == 1)
    IMAGOSaved.hideMinimap = (IMAGOSaved.hideMinimap == true or IMAGOSaved.hideMinimap == 1)
    IMAGOSaved.debugMap = (IMAGOSaved.debugMap == true or IMAGOSaved.debugMap == 1)

    -- Initialize locale (reads IMAGOSaved.language override)
    if IMAGO.Locale.Init then IMAGO.Locale.Init() end

    IMAGO.isDeveloper = IMAGO.IsDeveloper()
    if not IMAGO.isDeveloper then
        IMAGOSaved.debugMap = false
    end

    IMAGO.Scanner.EnsureZoneProgressTables()

    if IMAGO.BuildReverseLookup then IMAGO.BuildReverseLookup() end

    -- Migration v1.5: seenNPCs/viewedNPCs/favorites/history slugs -> slug_midnight
    if not IMAGOSaved.migratedSlugSuffix then
        -- seenNPCs + viewedNPCs (both keyed by slug)
        local toMigrate = {}
        for slug, val in pairs(IMAGOSaved.seenNPCs or {}) do
            if not slug:find("_midnight$") and IMAGO.GetNPCData(slug .. "_midnight") then
                toMigrate[slug] = val
            end
        end
        for slug, val in pairs(toMigrate) do
            IMAGOSaved.seenNPCs[slug .. "_midnight"] = val
            IMAGOSaved.seenNPCs[slug] = nil
            if IMAGOSaved.viewedNPCs[slug] then
                IMAGOSaved.viewedNPCs[slug .. "_midnight"] = IMAGOSaved.viewedNPCs[slug]
                IMAGOSaved.viewedNPCs[slug] = nil
            end
        end
        -- favorites (keyed by slug)
        local favMigrate = {}
        for slug, val in pairs(IMAGOSaved.favorites or {}) do
            if not slug:find("_midnight$") and IMAGO.GetNPCData(slug .. "_midnight") then
                favMigrate[slug] = val
            end
        end
        for slug, val in pairs(favMigrate) do
            IMAGOSaved.favorites[slug .. "_midnight"] = val
            IMAGOSaved.favorites[slug] = nil
        end
        -- history (array of slugs or zone-tables)
        local hist = IMAGOSaved.history or {}
        for i, slug in ipairs(hist) do
            if type(slug) == "string" and not slug:find("_midnight$") and IMAGO.GetNPCData(slug .. "_midnight") then
                hist[i] = slug .. "_midnight"
            end
        end
        IMAGOSaved.migratedSlugSuffix = true
    end

    if IMAGO.Options and IMAGO.Options.Init then IMAGO.Options.Init() end
    
    if IMAGO.Display and IMAGO.Display.CreateFrame then IMAGO.Display.CreateFrame() end
    if IMAGO.UnitContextMenu and IMAGO.UnitContextMenu.Init then IMAGO.UnitContextMenu.Init() end
    if IMAGO.TextLinker and IMAGO.TextLinker.BuildNameLookup then IMAGO.TextLinker.BuildNameLookup() end
    if IMAGO.TextLinker and IMAGO.TextLinker.BuildZoneLookup then IMAGO.TextLinker.BuildZoneLookup() end
    IMAGO.CreateMinimapButton()

    if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
            if not IMAGOSaved.enabled then return end
            if InCombatLockdown() then return end
            if tooltip ~= GameTooltip then return end

            securecall(function()
                local guid = data and data.guid
                
                if not guid then
                    local _, unit = tooltip:GetUnit()
                    if unit then
                        local ok, unitGuid = pcall(UnitGUID, unit)
                        if ok then guid = unitGuid end
                    end
                end

                if not guid then return end

                local npcID = IMAGO.GetNPCIDFromGUID(guid)
                if npcID and IMAGOdb and IMAGOdb.idToSlug then
                    local slug = IMAGOdb.idToSlug[npcID]
                    if slug then
                        local _ = tooltip:AddLine(" ")
                        if IMAGOSaved.seenNPCs[slug] then
                            _ = tooltip:AddLine(IMAGO.L["TOOLTIP_KNOWN"] or "IMAGO: In Chronik verzeichnet")
                        else
                            _ = tooltip:AddLine(IMAGO.L["TOOLTIP_UNKNOWN"] or "IMAGO: Schicksal verborgen")
                        end
                    end
                end
            end)
        end)
    end

    SLASH_IMAGO1 = "/imago"
    SlashCmdList["IMAGO"] = function(msg)
        msg = msg:lower():trim()
        local isDev = IMAGO.isDeveloper
        
        if msg == "" then
            if IMAGO.Chronicle then IMAGO.Chronicle.Toggle() end
        elseif msg == "settings" or msg == "config" then
            if Settings and Settings.OpenToCategory and IMAGO.settingsCategory then
                Settings.OpenToCategory(IMAGO.settingsCategory:GetID())
            end
        elseif msg == "idle" then
            if IMAGO.Snippets and IMAGO.Snippets.ShowRandom then
                IMAGO.Snippets.ShowRandom(true)
            end
        elseif msg == "help" then
            print("|cFF9370DBIMAGO Slash Commands:|r")
            print("|cFFFFD700/imago|r - " .. (IMAGO.L["CMD_HELP_OPEN_DESC"] or "Öffnet oder schließt die Chronik"))
            print("|cFFFFD700/imago settings|r - " .. (IMAGO.L["CMD_HELP_SETTINGS_DESC"] or "Öffnet die Addon-Einstellungen"))
            print("|cFFFFD700/imago help|r - " .. (IMAGO.L["CMD_HELP_HELP_DESC"] or "Zeigt diese Hilfe an"))
        elseif msg == "dev" then
            print("dev command:", isDev)
            if not isDev then return end
            print("|cFFFFD700[IMAGO DEV]|r Befehle:")
            print("|cFFFFD700/imago debugmap|r - Zonen-Debug an/aus (Chat-Ausgabe)")
            print("|cFFFFD700/imago map|r - Aktuelle uiMapID anzeigen (für zones.lua)")
            print("|cFFFFD700/imago validate|r - Datenbank-Validierung (IDs/Lore)")
            print("|cFFFFD700/imago unlockall|r - Alles freischalten (Test)")
            print("|cFFFFD700/imago scan <id>|r - NPC per ID testen/anzeigen")
            print("|cFFFFD700/imago unsee npc <slug>|r - Remove NPC from seenNPCs")
            print("|cFFFFD700/imago unsee zone <mapID>|r - Remove zone from seenZones")
        elseif msg == "debugmap" then
            if not isDev then return end
            IMAGOSaved.debugMap = not IMAGOSaved.debugMap
            print(string.format(
                "|cFFFFD700IMAGO:|r Zonen-Debug %s (/imago debugmap zum Umschalten)",
                IMAGOSaved.debugMap and "|cFF00FF00AN|r" or "|cFFFF0000AUS|r"
            ))
        elseif msg == "reset" then
            IMAGOSaved.seenZones     = {}
            IMAGOSaved.discoveredZones = IMAGOSaved.seenZones
            IMAGOSaved.seenNPCs      = {}
            IMAGOSaved.seenRaces     = {}
            IMAGOSaved.viewedNPCs    = {}
            IMAGOSaved.viewedRaces   = {}
            IMAGOSaved.manualRaceUnlocks = {}
            IMAGOSaved.favorites     = {}
            IMAGOSaved.history       = {}
            print("|cFFFFD700IMAGO:|r " .. (IMAGO.L["RESET_DONE"] or "Historie zurückgesetzt."))
            if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
                IMAGO.Chronicle.UpdateList()
            end
            
        elseif msg == "map" then
            if not isDev then return end
            -- THE ULTIMATE DEV TOOL FOR ZONE IDS
            local mapID = C_Map.GetBestMapForUnit("player")
            if mapID then
                local mapInfo = C_Map.GetMapInfo(mapID)
                local mapName = mapInfo and mapInfo.name or "Unbekannt"
                print(string.format("|cFFFFD700[IMAGO DEV]|r Aktuelle Map ID: |cFF00FF00%d|r (%s)", mapID, mapName))
                print("|cFFCCCCCCTrage exakt diese ID in deine zones.lua ein!|r")
            else
                print("|cFFFF0000[IMAGO DEV]|r Konnte Map ID nicht ermitteln.")
            end
        elseif msg == "validate" then
            if not isDev then return end
            print(IMAGO.L["VAL_START"] or "|cFFFFD700[IMAGO]|r Starte Datenbank-Validierung...")
            local count, missingIDs, missingLore = 0, 0, 0
            for cat, entries in pairs(IMAGOdb.npcs) do
                if type(entries) == "table" then
                    for slug, data in pairs(entries) do
                        count = count + 1
                        if not data.displayID and not data.ids then
                            print(string.format(IMAGO.L["VAL_ERR_ID"] or "|cFFFF0000Fehler:|r %s hat weder displayID noch ids-Array!", slug))
                            missingIDs = missingIDs + 1
                        end
                        if not data.lore or data.lore == "" then
                            print(string.format(IMAGO.L["VAL_WARN_LORE"] or "|cFFFF8C00Warnung:|r %s hat keine Lore in der aktuellen Sprache!", slug))
                            missingLore = missingLore + 1
                        end
                    end
                end
            end
            print(string.format(IMAGO.L["VAL_DONE"] or "Validierung beendet. %d NPCs geprüft. %d kritische Fehler, %d Warnungen.", count, missingIDs, missingLore))
        
        elseif msg == "unlockall" then
            if not isDev then return end
            local count = 0
            -- 1. Unlock NPCs
            for cat, entries in pairs(IMAGOdb.npcs or {}) do
                if type(entries) == "table" then
                    for slug, _ in pairs(entries) do
                        if not IMAGOSaved.seenNPCs[slug] then
                            IMAGOSaved.seenNPCs[slug] = true
                            IMAGOSaved.viewedNPCs[slug] = true
                            count = count + 1
                        end
                    end
                end
            end
            
            -- 2. Unlock zones
            for mapID, _ in pairs(IMAGOdb.zones or {}) do
                if not IMAGOSaved.seenZones[mapID] then
                    IMAGOSaved.seenZones[mapID] = true
                    count = count + 1
                end
            end

            -- 3. Unlock races
            for slug, _ in pairs(IMAGOdb.races or {}) do
                if not IMAGOSaved.seenRaces[slug] then
                    IMAGOSaved.seenRaces[slug] = true
                    count = count + 1
                end
            end

            -- Output in chat
            local successMsg = IMAGO.L["CMD_UNLOCKALL_SUCCESS"] and string.format(IMAGO.L["CMD_UNLOCKALL_SUCCESS"], count) or string.format("|cFF9370DB[IMAGO]|r Alle Archive geöffnet. %d neue Einträge entschlüsselt.", count)
            print(successMsg)
            
            -- Refresh the UI immediately if open
            if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
                IMAGO.Chronicle.UpdateList()
            end

        elseif msg:match("^scan %d+") then
            if not isDev then return end
            local id = tonumber(msg:match("^scan (%d+)"))
            local isRelevant = IMAGO.Scanner.DiscoverNPC(id)
            if not isRelevant then print("|cFFFF0000IMAGO:|r ID " .. id .. " ist nicht in der Datenbank.") end
        elseif msg:match("^unsee npc .+") then
            --if not isDev then return end
            local slug = msg:match("^unsee npc (.+)")
            if IMAGOSaved.seenNPCs[slug] then
                IMAGOSaved.seenNPCs[slug] = nil
                IMAGOSaved.viewedNPCs[slug] = nil
                print("|cFFFFD700[IMAGO DEV]|r Removed NPC from seenNPCs: " .. slug)
            else
                print("|cFFFFD700[IMAGO DEV]|r NPC not in seenNPCs: " .. slug)
            end
            if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
                IMAGO.Chronicle.UpdateList()
            end
        elseif msg:match("^unsee zone %d+") then
            --if not isDev then return end
            local mapID = tonumber(msg:match("^unsee zone (%d+)"))
            if IMAGOSaved.seenZones[mapID] then
                IMAGOSaved.seenZones[mapID] = nil
                print("|cFFFFD700[IMAGO DEV]|r Removed zone from seenZones: " .. mapID)
            else
                print("|cFFFFD700[IMAGO DEV]|r Zone not in seenZones: " .. mapID)
            end
            if IMAGO.Chronicle and IMAGO.Chronicle.frame and IMAGO.Chronicle.frame:IsShown() then
                IMAGO.Chronicle.UpdateList()
            end
        end
    end
end

-- ============================================================
-- LOCALE INIT (moved here from core/Locale.lua)
-- Resolves the active locale and applies its strings onto IMAGO.L,
-- falling back to enUS for any missing key.
-- ============================================================
function IMAGO.Locale.Init()
    local function ResolveLocale()
        if IMAGOSaved and IMAGOSaved.language then return IMAGOSaved.language end
        local c = GetLocale()
        if c == "deDE" then return "deDE" end
        if c == "ruRU" then return "ruRU" end
        return "enUS"
    end
    local locale = ResolveLocale()
    local L_EN = IMAGO.LocaleData.enUS or {}
    local L_DE = IMAGO.LocaleData.deDE or {}
    local L_RU = IMAGO.LocaleData.ruRU or {}
    local targetL = L_EN
    if locale == "deDE" then targetL = L_DE
    elseif locale == "ruRU" then targetL = L_RU
    end
    -- Fallback: pull missing keys from EN
    for k, v in pairs(L_EN) do
        IMAGO.L[k] = targetL[k] or v
    end
    IMAGO.currentLocale = locale
end
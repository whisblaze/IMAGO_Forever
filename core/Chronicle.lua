-- ============================================================
-- IMAGO — core/Chronicle.lua
-- The Chronicle: 10/10 cinematic UI, dashboard, search & filter
-- ============================================================

IMAGO.Chronicle = IMAGO.Chronicle or {}

-- Fonts resolve via IMAGO.FONT_TITLE / IMAGO.FONT_BODY at call time —
-- the saved titleFont is applied in Init, after saved vars load.

local LAYOUT = IMAGO.LAYOUT

local NBSP = "\194\160"

-- WoW FontStrings only wrap on plain spaces. Gluing fragile word groups
-- with NBSP keeps auto-wrap from orphaning them ("a boundless",
-- " - a boundless", "10,000 DP").
local function WrapGlue(text)
    if not text or text == "" then return text end
    text = text:gsub("(%s%a) ", "%1" .. NBSP)
    text = text:gsub(" %- ", NBSP .. "-" .. NBSP)
    text = text:gsub(" %– ", NBSP .. "–" .. NBSP)
    text = text:gsub("(%d) (A?DP)", "%1" .. NBSP .. "%2")
    return text
end

local eraColors = {
    ["Ancient"]   = {0.85, 0.65, 0.13},     -- Titanic bronze (Creation/Old Gods)
    ["Pre-WC1"]   = {0.60, 0.10, 0.10},     -- Blood red (orc invasion/First War)
    ["WC1"]       = {0.60, 0.10, 0.10},     -- Blood red (orc invasion/First War)
    ["Pre-WC2"]   = {0.10, 0.30, 0.80},     -- Lordaeron blue (Alliance/Second War)
    ["WC2"]       = {0.10, 0.30, 0.80},     -- Lordaeron blue (Alliance/Second War)
    ["Pre-WC3"]   = {0.45, 0.80, 0.20},     -- Plague green (the Scourge/Third War)
    ["WC3"]       = {0.45, 0.80, 0.20},     -- Plague green (the Scourge/Third War)
    ["Pre-Forever"]   = {0.48, 0.29, 0.12},   -- Dark copper (old world)
    ["Forever"]   = {0.10, 0.44, 0.62},       -- Petrol blue, brightened for dark bg (WoW Forever)
}

-- Chronological order of timeline era labels (caps at Forever)
local ERA_ORDER = {
    Ancient = 1, ["Pre-WC1"] = 2, WC1 = 3, ["Pre-WC2"] = 4, WC2 = 5,
    ["Pre-WC3"] = 6, WC3 = 7, ["Pre-Forever"] = 8, Forever = 9,
}

-- NPC records are expansion-scoped via their slug suffix: the timeline only
-- shows entries up to that era, and the era's own entry sits behind spoiler
-- protection. Records without a suffix show the full timeline with the
-- Forever-era entry spoiler-gated.
local SLUG_ERA = {
    _forever = "Forever",
}

-- Category → alignment crest shown in the NPC detail header
local FACTION_ICONS = {
    CAT_KINGDOM_STORMWIND    = "Interface\\Timer\\Alliance-Logo",
    CAT_DWARVES_IRONFORGE    = "Interface\\Timer\\Alliance-Logo",
    CAT_GNOMEREGAN_EXILES   = "Interface\\Timer\\Alliance-Logo",
    CAT_NIGHT_ELVES_DARNASSUS    = "Interface\\Timer\\Alliance-Logo",
    CAT_THERAMORE    = "Interface\\Timer\\Alliance-Logo",
    CAT_WILDHAMMER_CLAN   = "Interface\\Timer\\Alliance-Logo",
    CAT_ORCS_HORDE         = "Interface\\Timer\\Horde-Logo",
    CAT_DARKSPEAR_TROLLS   = "Interface\\Timer\\Horde-Logo",
    CAT_FORSAKEN     = "Interface\\Timer\\Horde-Logo",
    CAT_TAUREN_THUNDER_BLUFF = "Interface\\Timer\\Horde-Logo",
}

-- Shared left edge of the Fates detail column (detail-pane x): the stage
-- is 264 wide at x=10, plus a 30 px gap. Sub-tabs, lore/timeline text and
-- the footer's CONNECTIONS column all start here. The scroll frame sits
-- LORE_INSET px further left because its content is inset by that much.
local LORE_X, LORE_INSET = 304, 20
-- Shared readable measure for the lore text and the timeline entries:
-- both end on the same right edge, comfortably short of the scrollbar.
local LORE_TEXT_W = 460
-- The scroll frame reserves an 8 px scrollbar gutter, so its right edge sits
-- 8 px past the footer's right edge (detail-x -8) to land the text on it.
local LORE_RIGHT = 0

-- Zone page: a 760 px wide hero banner on top, below it the text column
-- (Lore | Places sub-tabs) on the left and the side panel (DOSSIER,
-- CONNECTIONS, RECORD) on the right.
local ZONE_HERO_H = 200
local ZONE_SIDE_W, ZONE_GAP = 270, 14

-- One button chrome for the whole window (same as Back / Mode / Filter):
-- tooltip-border edge in gold at 0.35 on a translucent face. Hover lifts
-- the border to bright gold; `active` fills the face gold. `face`
-- overrides the resting fill color (used by the RECORD buttons).
local function ChromeButton(b, face, edge)
    b:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = edge or 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    local G, GB, BG = IMAGO_COLORS.GOLD, IMAGO_COLORS.GOLD_BRIGHT, IMAGO_COLORS.BG_MAIN
    function b:ChromeRest(active)
        if active then
            self:SetBackdropColor(G[1], G[2], G[3], 0.35)
        else
            local f = face or BG
            self:SetBackdropColor(f[1], f[2], f[3], face and 0.9 or 0.5)
        end
        self:SetBackdropBorderColor(G[1], G[2], G[3], 0.35)
    end
    function b:ChromeHover()
        self:SetBackdropBorderColor(GB[1], GB[2], GB[3], 0.7)
    end
    b:ChromeRest(false)
end

-- Warm graphite fill for the RECORD buttons: a dark bronze/stone tone
-- that reads against the panel and keeps the gold border's contrast.
local ACT_FACE = { 0.16, 0.135, 0.105 }

-- Closes the Chronicle and opens the world map on a zone
local function OpenZoneOnMap(mapID)
    local f = IMAGO.Chronicle.frame
    if f then f:Hide() end
    if OpenWorldMap then
        OpenWorldMap(mapID)
    elseif WorldMapFrame then
        ShowUIPanel(WorldMapFrame)
        if WorldMapFrame.SetMapID then WorldMapFrame:SetMapID(mapID) end
    end
end

-- Race alignment → crest shown in the race detail header
local RACE_ALIGN_ICONS = {
    Alliance = "Interface\\Timer\\Alliance-Logo",
    Horde    = "Interface\\Timer\\Horde-Logo",
    Neutral  = "Interface\\AddOns\\IMAGO_forever\\media\\worldmap.tga",
}

IMAGO.Chronicle.ranks = IMAGO.Chronicle.ranks or {}

-- Navigation stack for the back button
local navStack = {}
local isNavigatingBack = false

local function GetCrypticName(name)
    local crypt = ""
    local consonants = {"k", "z", "n", "h", "r", "t", "x", "v", "l", "s", "q", "w", "y"}
    local vowels = {"a", "u", "o", "i", "e"}

    for i = 1, #name do
        local char = string.sub(name, i, i)
        if char:match("%A") and char ~= "ä" and char ~= "ö" and char ~= "ü" then
            crypt = crypt .. char
        else
            local isUpper = (char == string.upper(char))
            local byteVal = string.byte(char) + i
            local isVowel = char:lower():match("[aeiouäöü]")
            local newChar = isVowel and vowels[(byteVal % #vowels) + 1] or consonants[(byteVal % #consonants) + 1]
            crypt = crypt .. (isUpper and string.upper(newChar) or newChar)
        end
    end
    return crypt
end

local function GetValidModelID(npcData)
    -- SetCreature with the creature ID resolves the correct model itself;
    -- displayID holds creature IDs here, so SetDisplayInfo would render
    -- whatever model that number happens to map to — a different NPC.
    if npcData.ids and type(npcData.ids) == "table" then
        local entry = npcData.ids[1]
        if entry then
            return type(entry) == "table" and tonumber(entry[1]) or tonumber(entry), false
        end
    end
    if npcData.displayID then return tonumber(npcData.displayID), true end
    return nil
end

-- SetCreature/SetDisplayInfo issued in the same frame as Show() can silently
-- produce nothing, which is why entries used to need a second click. A
-- working "second click" runs ClearModel + Set*, so the retries repeat that
-- full reset with growing gaps (an in-flight load is never starved by
-- rapid re-issues), while mdl._modelToken invalidates stale callbacks when
-- the frame is re-purposed quickly.
local function LoadModelCreature(mdl, modelID, isDisplay, onReady)
    if not mdl or not modelID then return end
    local token = (mdl._modelToken or 0) + 1
    mdl._modelToken = token

    local fired = false
    local done = false
    local function Ready(stopLadder)
        if stopLadder then done = true end
        if fired or mdl._modelToken ~= token then return end
        fired = true
        if onReady then onReady(mdl) end
    end

    -- nil = no probe API on this client
    local function ProbeLoaded()
        if mdl.HasModelLoaded then
            return mdl:HasModelLoaded() and true or false
        elseif mdl.GetModelFileID then
            local id = mdl:GetModelFileID()
            return (id ~= nil and id ~= 0) and true or false
        end
        return nil
    end

    local function ApplyModel()
        if mdl._modelToken ~= token or not mdl:IsShown() then return end
        mdl:ClearModel()
        if isDisplay then mdl:SetDisplayInfo(modelID) else mdl:SetCreature(modelID) end
    end

    ApplyModel()

    -- Retries repeat the ClearModel+Set* reset only while no load is
    -- confirmed — re-setting a model that already rendered is what caused
    -- the flicker, so a probe hit or the load event stops the ladder.
    local attempts = 0
    local function Tick()
        if done or mdl._modelToken ~= token or not mdl:IsShown() then return end
        if ProbeLoaded() == true then return end
        attempts = attempts + 1
        if attempts > 3 then return end
        ApplyModel()
        C_Timer.After(0.3, Tick)
    end
    C_Timer.After(0.15, Tick)

    -- Preferred ready signal when the client fires it.
    pcall(mdl.SetScript, mdl, "OnModelLoaded", function(self)
        if self._modelToken ~= token then return end
        pcall(self.SetScript, self, "OnModelLoaded", nil)
        Ready(true)
    end)
    -- Fallback: by 0.5 s the first deferred Set calls have landed — fires
    -- onReady for the animation but does not stop the retry ladder.
    C_Timer.After(0.5, function()
        if mdl._modelToken == token and mdl:IsShown() then Ready(false) end
    end)
end

local function ApplyZoneEntryNormal(btn, isManual)
    if not btn then return end
    if btn.activeBar then btn.activeBar:Hide() end
    if btn.isVisible then
        btn.bg:SetTexture(btn.texturePath)
        btn.bg:SetDesaturated(false)
        btn.bg:SetVertexColor(1, 1, 1, 1)
        btn.bg:SetTexCoord(0, 1, 0.2, 0.8)
        btn.t:SetText(btn.name or "")
        btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
        btn.overlay:SetColorTexture(0, 0, 0, 0.6)
    else
        btn.bg:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        btn.bg:SetDesaturated(true)
        btn.bg:SetVertexColor(0.2, 0.2, 0.2, 0.8)
        btn.bg:SetTexCoord(0, 1, 0, 1)
        btn.t:SetText(btn.unknownName or (IMAGO.L and IMAGO.L["ZONE_UNKNOWN_NAME"]) or "Unbekannte Region")
        btn.t:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        btn.overlay:SetColorTexture(0, 0, 0, 0.6)
    end
end

local function ApplyZoneEntrySelected(btn)
    if not btn then return end
    if btn.activeBar then btn.activeBar:Show() end
    if btn.t then
        btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end
    if btn.overlay then
        btn.overlay:SetColorTexture(0, 0, 0, 0.2)
    end
end

local function ApplyNPCButtonNormal(btn)
    if not btn then return end
    if btn.selected then btn.selected:Hide() end
    if btn.activeBar then btn.activeBar:Hide() end
    if not btn.t then return end
    if btn.isVisible then
        btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
    else
        btn.t:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    end
end

local function ApplyNPCButtonSelected(btn)
    if not btn then return end
    if btn.selected then btn.selected:Show() end
    if btn.activeBar then btn.activeBar:Show() end
    if btn.t then
        btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end
end

-- ============================================================
-- CINEMATIC DISCOVERY EVENT 
-- ============================================================
function IMAGO.Chronicle.ShowCinematic(npcData, callback)
    if not IMAGO.Chronicle.cinematicFrame then
        local cf = CreateFrame("Button", "IMAGOCinematicFrame", UIParent)
        cf:SetAllPoints()
        cf:SetFrameStrata("FULLSCREEN_DIALOG") 
        cf:SetFrameLevel(999) 
        cf:EnableMouse(true)
        cf:RegisterForClicks("AnyUp")

        cf.bg = cf:CreateTexture(nil, "BACKGROUND")
        cf.bg:SetAllPoints()
        cf.bg:SetColorTexture(0.02, 0.02, 0.02, 0.95)

        cf.model = CreateFrame("PlayerModel", nil, cf)
        cf.model:SetSize(800, 800) 
        cf.model:SetPoint("CENTER", 0, 80) 
        
        cf.model:SetScript("OnUpdate", function(self, elapsed)
            self.facing = (self.facing or 0) + (elapsed * 0.15)
            self:SetFacing(self.facing)
        end)

        cf.name = cf:CreateFontString(nil, "OVERLAY")
        cf.name:SetFont(IMAGO.FONT_TITLE, 64, "OUTLINE")
        cf.name:SetPoint("BOTTOM", cf.model, "BOTTOM", 0, -80)
        cf.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        cf.name:SetShadowColor(0,0,0,1)
        cf.name:SetShadowOffset(2, -2)

        cf.sub = cf:CreateFontString(nil, "OVERLAY")
        cf.sub:SetFont(IMAGO.FONT_BODY, 16, "OUTLINE")
        cf.sub:SetPoint("TOP", cf.name, "BOTTOM", 0, -15)
        cf.sub:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

        IMAGO.Chronicle.cinematicFrame = cf
    end

    local cf = IMAGO.Chronicle.cinematicFrame
    cf.name:SetText(npcData and npcData.name or "")
    cf.sub:SetText(IMAGO.L["CINEMATIC_CONTINUE"])

    cf.model:ClearModel()
    local modelID, isDisplay = GetValidModelID(npcData)
    if modelID then 
        LoadModelCreature(cf.model, modelID, isDisplay, function(mdl)
            if cf:IsShown() then mdl:SetFacing(mdl.facing or -0.3) end
        end)
    end
    
    cf.model:SetCamDistanceScale(1.5)  
    cf.model:SetPosition(0, 0, -0.3)   
    cf.model.facing = -0.3
    cf.model:SetFacing(-0.3)

    cf:SetAlpha(0)
    cf:Show()
    
    local soundID = SOUNDKIT.UI_LEGENDARY_LOOT_TOAST or 44204
    PlaySound(soundID, "Master") 

    UIFrameFadeIn(cf, 1.0, 0, 1)

    cf:SetScript("OnClick", function(self)
        self:SetScript("OnClick", nil) 
        if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end
        
        UIFrameFadeOut(self, 0.5, 1, 0)
        C_Timer.After(0.5, function()
            self:Hide()
            if callback then callback() end
        end)
    end)
end

-- ============================================================
-- THE MAIN WINDOW
-- ============================================================
function IMAGO.Chronicle.CreateFrame()
    if IMAGO.Chronicle.frame then return end

    local f = CreateFrame("Frame", "IMAGOChronicleFrame", UIParent, "BackdropTemplate")
    f:SetFrameStrata("DIALOG")
    f:SetFrameLevel(100)
    f:SetSize(1100, 700)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:Hide()

    -- Allow ESC to close
    table.insert(UISpecialFrames, "IMAGOChronicleFrame")

    local backdropDefault = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }
    local backdropOpaque = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }
    local detailBackdropDefault = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    }
    local detailBackdropOpaque = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    }
    f:SetBackdrop((IMAGOSaved and IMAGOSaved.opaqueUI) and backdropOpaque or backdropDefault)
    f:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], (IMAGOSaved and IMAGOSaved.opaqueUI) and 1.0 or 0.95)
    f:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)

    -- Custom slim close button matching the header controls
    f.closeBtn = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.closeBtn:SetSize(18, 18)
    f.closeBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -10, -12)
    f.closeBtn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8, insets = {left=2,right=2,top=2,bottom=2} })
    f.closeBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
    f.closeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

    f.closeBtn.label = f.closeBtn:CreateFontString(nil, "OVERLAY")
    f.closeBtn.label:SetFont(IMAGO.FONT_BODY, 12, "")
    f.closeBtn.label:SetPoint("CENTER", f.closeBtn, "CENTER", 0, 0)
    f.closeBtn.label:SetText("X")
    f.closeBtn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

    f.closeBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.7)
        self.label:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end)
    f.closeBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
        self.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    end)
    f.closeBtn:SetScript("OnClick", function(self)
        self:GetParent():Hide()
    end)
    f.closeBtn:HookScript("OnClick", function()
        wipe(navStack)
        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(false) end
    end)

    -- 1. NEW: Header background (darkens the top area for more focus)
    f.headerBg = f:CreateTexture(nil, "BACKGROUND")
    f.headerBg:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
    f.headerBg:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)
    f.headerBg:SetHeight(45)
    f.headerBg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    if IMAGOSaved and IMAGOSaved.opaqueUI then
        f.headerBg:SetGradient("VERTICAL", CreateColor(0, 0, 0, 1), CreateColor(0, 0, 0, 1))
    else
        f.headerBg:SetGradient("VERTICAL", CreateColor(0, 0, 0, 0.7), CreateColor(0, 0, 0, 0))
    end

    -- 2. NEW: Divider under the title (separates header from content)
    f.headerLine = f:CreateTexture(nil, "ARTWORK")
    f.headerLine:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -49)
    f.headerLine:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -49)
    f.headerLine:SetHeight(1)
    f.headerLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.headerLine:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4))

    -- 3. The title: just "IMAGO", wide tracking + gold ornament lines so it
    -- reads as a deliberate emblem, not lost space
    f.title = f:CreateFontString(nil, "OVERLAY")
    f.title:SetFont(IMAGO.FONT_TITLE, 27, "OUTLINE")
    f.title:SetPoint("TOP", f, "TOP", 0, -14)
    f.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.title:SetShadowColor(0, 0, 0, 1) -- NEW: The drop shadow
    f.title:SetShadowOffset(2, -2)
    f.title:SetText("I  M  A  G  O")

    -- Flanking ornament lines fading outwards (like the discovery card divider)
    f.titleLineLeft = f:CreateTexture(nil, "ARTWORK")
    f.titleLineLeft:SetSize(95, 1)
    f.titleLineLeft:SetPoint("RIGHT", f.title, "LEFT", -20, -1)
    f.titleLineLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.titleLineLeft:SetGradient("HORIZONTAL",
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0),
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7))

    f.titleLineRight = f:CreateTexture(nil, "ARTWORK")
    f.titleLineRight:SetSize(95, 1)
    f.titleLineRight:SetPoint("LEFT", f.title, "RIGHT", 20, -1)
    f.titleLineRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.titleLineRight:SetGradient("HORIZONTAL",
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7),
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    f.settingsBtn = CreateFrame("Button", nil, f)
    f.settingsBtn:SetSize(18, 18)
    f.settingsBtn:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -12)
    f.settingsBtn:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton")
    f.settingsBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    f.settingsBtn:SetScript("OnClick", function()
        if Settings and Settings.OpenToCategory and IMAGO.settingsCategory then
            Settings.OpenToCategory(IMAGO.settingsCategory:GetID())
        end
    end)

    f.activeFilter = "ALL"

    -- Shared sidebar container (Fates / Zones)
    f.sidebar = CreateFrame("Frame", nil, f)
    f.sidebar:SetPoint("TOPLEFT", f, "TOPLEFT", LAYOUT.SIDEBAR_OFFSET_LEFT, -LAYOUT.WORKSPACE_TOP)
    f.sidebar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", LAYOUT.SIDEBAR_OFFSET_LEFT, LAYOUT.WORKSPACE_BOTTOM)
    f.sidebar:SetWidth(LAYOUT.SIDEBAR_WIDTH)

    f.sidebar.bg = f.sidebar:CreateTexture(nil, "BACKGROUND")
    f.sidebar.bg:SetAllPoints()
    f.sidebar.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])
    f.sidebar.bg:SetAlpha((IMAGOSaved and IMAGOSaved.opaqueUI) and 1.0 or 0.85)

    f.sidebar.rightBorder = f.sidebar:CreateTexture(nil, "ARTWORK")
    f.sidebar.rightBorder:SetWidth(LAYOUT.DIVIDER_WIDTH)
    f.sidebar.rightBorder:SetPoint("TOPRIGHT", f.sidebar, "TOPRIGHT", 0, 0)
    f.sidebar.rightBorder:SetPoint("BOTTOMRIGHT", f.sidebar, "BOTTOMRIGHT", 0, 0)
    f.sidebar.rightBorder:SetColorTexture(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.8)

    -- Global search bar: slim custom EditBox in the main header,
    -- right-aligned next to the close button, vertically on the same
    -- line as the small header buttons. Filters the active tab.
    f.searchBox = CreateFrame("EditBox", "IMAGOChronicleSearch", f, "BackdropTemplate")
    f.searchBox:SetSize(160, 18)
    -- Top edge -12 = same height as settings gear & back button;
    -- right edge 46px from frame right = clear of the 32px close button
    f.searchBox:SetPoint("TOPRIGHT", f, "TOPRIGHT", -46, -12)
    f.searchBox:SetAutoFocus(false)
    f.searchBox:SetFont(IMAGO.FONT_BODY, 12, "")
    f.searchBox:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
    f.searchBox:SetTextInsets(20, 4, 0, 0)
    f.searchBox:SetMaxLetters(60)
    f.searchBox:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    f.searchBox:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
    f.searchBox:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

    f.searchBox.icon = f.searchBox:CreateTexture(nil, "OVERLAY")
    f.searchBox.icon:SetSize(11, 11)
    f.searchBox.icon:SetPoint("LEFT", f.searchBox, "LEFT", 5, 0)
    f.searchBox.icon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
    f.searchBox.icon:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.searchBox.icon:SetAlpha(0.85)

    f.searchBox.instructions = f.searchBox:CreateFontString(nil, "OVERLAY")
    f.searchBox.instructions:SetFont(IMAGO.FONT_BODY, 12, "")
    f.searchBox.instructions:SetPoint("LEFT", f.searchBox, "LEFT", 20, 0)
    f.searchBox.instructions:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    f.searchBox.instructions:SetText("Search...")
    f.searchBox.Instructions = f.searchBox.instructions -- compat with template-style access

    f.searchBox:SetScript("OnTextChanged", function(self)
        self.instructions:SetShown((self:GetText() or "") == "" and not self:HasFocus())
        IMAGO.Chronicle.UpdateList()
        -- Timeline/Codex: search filters the middle list, not the sidebar
        if f.activeTabIndex == 6 then
            IMAGO.Chronicle.ShowTimelineDefault()
        elseif f.activeTabIndex == 7 then
            IMAGO.Chronicle.ShowCodexDefault()
        end
    end)
    f.searchBox:SetScript("OnEditFocusGained", function(self)
        self.instructions:Hide()
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7)
    end)
    f.searchBox:SetScript("OnEditFocusLost", function(self)
        self.instructions:SetShown((self:GetText() or "") == "")
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
    end)
    f.searchBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    f.searchBox:SetScript("OnEnterPressed",  function(self) self:ClearFocus() end)

    -- Slim filter button matching the header search bar
    f.filterBtn = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.filterBtn:SetSize(LAYOUT.FILTER_WIDTH, 18)
    f.filterBtn:SetPoint("TOPRIGHT", f.searchBox, "TOPLEFT", -LAYOUT.SIDEBAR_CONTROL_GAP, 0)
    f.filterBtn:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    f.filterBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
    f.filterBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

    f.filterBtn.t = f.filterBtn:CreateFontString(nil, "OVERLAY")
    f.filterBtn.t:SetFont(IMAGO.FONT_BODY, 11, "")
    f.filterBtn.t:SetPoint("CENTER", f.filterBtn, "CENTER", -3, 0)
    f.filterBtn.t:SetWidth(LAYOUT.FILTER_WIDTH - 20)
    f.filterBtn.t:SetWordWrap(false)
    f.filterBtn.t:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.filterBtn:SetFontString(f.filterBtn.t)
    f.filterBtn:SetText(IMAGO.L["FILTER_LABEL"] or "Filter")

    -- Small gold chevron hinting at the dropdown
    f.filterBtn.chevron = f.filterBtn:CreateFontString(nil, "OVERLAY")
    f.filterBtn.chevron:SetFont(IMAGO.FONT_BODY, 10, "")
    f.filterBtn.chevron:SetPoint("RIGHT", f.filterBtn, "RIGHT", -5, -1)
    f.filterBtn.chevron:SetText(">")
    f.filterBtn.chevron:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    f.filterBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.7)
        self.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end)
    f.filterBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
        self.t:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    end)
    
    f.filterMenu = CreateFrame("Frame", nil, f, "BackdropTemplate")
    f.filterMenu:SetSize(200, 200)
    f.filterMenu:SetPoint("TOPLEFT", f.filterBtn, "BOTTOMLEFT", 0, -5)
    f.filterMenu:SetFrameLevel(f:GetFrameLevel() + 10)
    f.filterMenu:Hide()
    f.filterMenu:SetBackdrop({
        bgFile = ((IMAGOSaved and IMAGOSaved.opaqueUI) and "Interface\\Buttons\\WHITE8X8") or "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    f.filterMenu:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], (IMAGOSaved and IMAGOSaved.opaqueUI) and 1.0 or 0.98)
    f.filterMenu:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)

    -- Pool of reusable filter buttons — rebuilt dynamically each time the menu opens
    f.filterMenu.pool = {}

    local function GetOrCreateMenuBtn(idx)
        if f.filterMenu.pool[idx] then return f.filterMenu.pool[idx] end
        local btn = CreateFrame("Button", nil, f.filterMenu)
        btn:SetSize(180, 20)
        local hl = btn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.2)
        btn.t = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btn.t:SetPoint("LEFT", 10, 0)
        btn:SetScript("OnClick", function()
            f.activeFilter = btn._filterId
            f.filterMenu:Hide()
            IMAGO.Chronicle.UpdateList()
        end)
        f.filterMenu.pool[idx] = btn
        return btn
    end

    f.filterMenu.Rebuild = function()
        for _, b in ipairs(f.filterMenu.pool) do b:Hide() end
        local allItems
        if f.activeTabIndex == 4 then
            allItems = {
                {id = "ALL",      name = IMAGO.L["FILTER_ALL_RACES"] or "All Races"},
                {id = "Alliance", name = IMAGO.L["RACE_ALIGN_ALLIANCE"]  or "Alliance"},
                {id = "Horde",    name = IMAGO.L["RACE_ALIGN_HORDE"]     or "Horde"},
                {id = "Neutral",  name = IMAGO.L["RACE_ALIGN_NEUTRAL"]   or "Neutral"},
            }
        else
            allItems = {
                {id = "ALL",  name = IMAGO.L["FILTER_ALL"]  or "All Echoes"},
                {id = "HIST", name = IMAGO.L["FILTER_HIST"] or "Recently Discovered"},
                {id = "FAV",  name = IMAGO.L["FILTER_FAV"]  or "Favorites"},
            }
            local catSet, catList = {}, {}
            for cat, entries in pairs(IMAGOdb.npcs or {}) do
                if type(entries) == "table" and next(entries) then
                    catSet[cat] = true
                    table.insert(catList, {id = cat, name = IMAGO.L[cat] or cat})
                end
            end
            table.sort(catList, function(a, b) return a.name < b.name end)
            for _, c in ipairs(catList) do table.insert(allItems, c) end
        end
        local menuY = -8
        for i, item in ipairs(allItems) do
            local btn = GetOrCreateMenuBtn(i)
            btn._filterId = item.id
            local isActive = (f.activeFilter or "ALL") == item.id
            btn.t:SetText((isActive and "> " or "") .. item.name)
            if item.id == "FAV" then
                btn.t:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            else
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
            end
            btn:SetPoint("TOP", f.filterMenu, "TOP", 0, menuY)
            btn:Show()
            menuY = menuY - 22
        end
        f.filterMenu:SetSize(200, math.abs(menuY) + 10)
    end

    f.filterBtn:SetScript("OnClick", function()
        if f.filterMenu:IsShown() then
            f.filterMenu:Hide()
        else
            f.filterMenu.Rebuild()
            f.filterMenu:Show()
        end
    end)

    f.scrollFrame = CreateFrame("ScrollFrame", "IMAGOChronicleScroll", f.sidebar, "UIPanelScrollFrameTemplate")
    f.scrollFrame:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_LIST_TOP)
    f.scrollFrame:SetPoint("BOTTOMRIGHT", f.sidebar, "BOTTOMRIGHT", 0, 0)

    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleScrollScrollBar", f.scrollFrame)

    f.content = CreateFrame("Frame", nil, f.scrollFrame)
    f.content:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 1)
    f.scrollFrame:SetScrollChild(f.content)

    -- Static list headers for Fates/Zones/Races/Classes: tab name in gold
    -- plus a compact counter (replaces the old per-tab progress footer).
    -- Headers with a progress value get a slim progress bar along their
    -- bottom edge and click through to the Achievements tab.
    local function CreateListHeader()
        local h = CreateFrame("Button", nil, f.sidebar)
        h:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, LAYOUT.SIDEBAR_HEADER_HEIGHT)
        h:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_HEADER_TOP)
        h.bg = h:CreateTexture(nil, "BACKGROUND")
        h.bg:SetAllPoints()
        h.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])
        h.hl = h:CreateTexture(nil, "HIGHLIGHT")
        h.hl:SetAllPoints()
        h.hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.3)
        h.t = h:CreateFontString(nil, "OVERLAY")
        IMAGO.ApplyTextStyle(h.t, "SIDEBAR_HEADER")
        h.t:SetPoint("CENTER", 0, 3)
        -- slim progress bar, same palette as the Achievements bars
        h.prog = CreateFrame("Frame", nil, h)
        h.prog:SetPoint("BOTTOMLEFT", h, "BOTTOMLEFT", 8, 4)
        h.prog:SetPoint("BOTTOMRIGHT", h, "BOTTOMRIGHT", -8, 4)
        h.prog:SetHeight(5)
        h.prog.track = h.prog:CreateTexture(nil, "BACKGROUND")
        h.prog.track:SetAllPoints()
        h.prog.track:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
        h.prog.fill = h.prog:CreateTexture(nil, "ARTWORK")
        h.prog.fill:SetPoint("LEFT", h.prog, "LEFT", 0, 0)
        h.prog.fill:SetHeight(5)
        h.prog.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)
        h.prog:Hide()
        h:SetScript("OnClick", function()
            if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
            IMAGO.Chronicle.SelectMainTab(8)
        end)
        h:Hide()
        return h
    end
    f.sidebar.fatesHeader   = CreateListHeader()
    f.sidebar.zonesHeader   = CreateListHeader()
    f.sidebar.racesHeader   = CreateListHeader()
    f.sidebar.classesHeader = CreateListHeader()

    -- "FATES  ·  3 / 16": label keeps the header style, counter is muted.
    -- frac (0..1) fills the progress bar and makes the header clickable.
    local PROG_W = LAYOUT.SIDEBAR_USABLE_WIDTH - 16
    function f.SetSidebarHeader(header, label, count, frac)
        if not header then return end
        local c = IMAGO_COLORS.TEXT_SECONDARY
        local hex = string.format("%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
        header.t:SetText(label .. "|cff" .. hex .. "  \194\183  " .. (count or "") .. "|r")
        if frac then
            header.prog.fill:SetWidth(math.max(0.001, PROG_W * math.min(1, math.max(0, frac))))
            header.prog:Show()
            header:EnableMouse(true)
            header.t:ClearAllPoints()
            header.t:SetPoint("CENTER", 0, 3)
        else
            header.prog:Hide()
            header:EnableMouse(false)
            header.t:ClearAllPoints()
            header.t:SetPoint("CENTER", 0, 0)
        end
        header:Show()
    end

    -- Codex fixed sidebar header (outside the scroll area)
    f.sidebar.codexHeader = CreateFrame("Button", nil, f.sidebar)
    f.sidebar.codexHeader:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, LAYOUT.SIDEBAR_HEADER_HEIGHT)
    f.sidebar.codexHeader:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_HEADER_TOP)

    f.sidebar.codexHeader.bg = f.sidebar.codexHeader:CreateTexture(nil, "BACKGROUND")
    f.sidebar.codexHeader.bg:SetAllPoints()
    f.sidebar.codexHeader.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])

    local cxhl = f.sidebar.codexHeader:CreateTexture(nil, "HIGHLIGHT")
    cxhl:SetAllPoints()
    cxhl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.3)

    f.sidebar.codexHeader.t = f.sidebar.codexHeader:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.sidebar.codexHeader.t, "SIDEBAR_HEADER")
    f.sidebar.codexHeader.t:SetPoint("CENTER", 0, 0)
    f.sidebar.codexHeader.t:SetText(IMAGO.L["CODEX_OVERVIEW"] or "CODEX")

    f.sidebar.codexHeader:SetScript("OnClick", function()
        if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
        IMAGO.Chronicle.SetDetailAction(nil)
        f.selectedCodexCat = nil
        f.selectedCodexSlug = nil
        f.selectedTimelineSlug = nil
        f.selectedTimelineEra = nil
        IMAGO.Chronicle.UpdateList()
        IMAGO.Chronicle.ShowCodexDefault()
    end)
    f.sidebar.codexHeader:Hide()

    -- Timeline fixed sidebar header (outside the scroll area)
    f.sidebar.timelineHeader = CreateFrame("Button", nil, f.sidebar)
    f.sidebar.timelineHeader:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, LAYOUT.SIDEBAR_HEADER_HEIGHT)
    f.sidebar.timelineHeader:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_HEADER_TOP)

    f.sidebar.timelineHeader.bg = f.sidebar.timelineHeader:CreateTexture(nil, "BACKGROUND")
    f.sidebar.timelineHeader.bg:SetAllPoints()
    f.sidebar.timelineHeader.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])

    local tlhl = f.sidebar.timelineHeader:CreateTexture(nil, "HIGHLIGHT")
    tlhl:SetAllPoints()
    tlhl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.3)

    f.sidebar.timelineHeader.t = f.sidebar.timelineHeader:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.sidebar.timelineHeader.t, "SIDEBAR_HEADER")
    f.sidebar.timelineHeader.t:SetPoint("CENTER", 0, 0)
    f.sidebar.timelineHeader.t:SetText(IMAGO.L["TIMELINE_ERAS"] or "HISTORICAL ERAS")

    f.sidebar.timelineHeader:SetScript("OnClick", function()
        if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
        IMAGO.Chronicle.SetDetailAction(nil)
        f.selectedTimelineEra = nil
        f.selectedTimelineSlug = nil
        IMAGO.Chronicle.UpdateList()
        IMAGO.Chronicle.ShowTimelineDefault()
    end)
    f.sidebar.timelineHeader:Hide()

    -- ============================================================
    -- RIGHT SIDE: THE DETAIL FRAME
    -- ============================================================
    f.detailFrame = CreateFrame("Frame", nil, f, "BackdropTemplate")
    f.detailFrame:SetPoint("TOPLEFT", f.sidebar, "TOPRIGHT", LAYOUT.CONTENT_PADDING_LEFT, 0)
    f.detailFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -LAYOUT.CONTENT_PADDING_RIGHT, LAYOUT.WORKSPACE_BOTTOM)
    f.detailFrame:SetBackdrop((IMAGOSaved and IMAGOSaved.opaqueUI) and detailBackdropOpaque or detailBackdropDefault)
    f.detailFrame:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], (IMAGOSaved and IMAGOSaved.opaqueUI) and 1.0 or 0.95)

    -- NEW: The race icon (fix for the current bug!)
    f.factionIcon = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.factionIcon:SetSize(50, 50)
    f.factionIcon:SetPoint("TOPRIGHT", f.detailFrame, "TOPRIGHT", -20, -10)
    f.factionIcon:SetAlpha(0.7)
    f.factionIcon:Hide()

    -- Race emblem box: male+female icons side by side (thin gold border each),
    -- tabard below at near-native size.
    f.raceEmblemBox = CreateFrame("Frame", nil, f.detailFrame)
    f.raceEmblemBox:SetSize(230, 250)
    f.raceEmblemBox:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 35, -110)
    f.raceEmblemBox:Hide()

    local function MakeRaceIcon(parent, xOffset)
        local t = parent:CreateTexture(nil, "ARTWORK")
        t:SetSize(64, 64)
        t:SetPoint("TOP", parent, "TOP", xOffset, -15)
        t:SetAlpha(0.95)
        local ring = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        ring:SetPoint("TOPLEFT", t, "TOPLEFT", -2, 2)
        ring:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 2, -2)
        ring:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 10,
        })
        ring:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
        return t
    end

    f.raceEmblem  = MakeRaceIcon(f.raceEmblemBox, -42)
    f.raceEmblem2 = MakeRaceIcon(f.raceEmblemBox,  42)

    f.raceEmblemCap = f.raceEmblemBox:CreateFontString(nil, "OVERLAY")
    f.raceEmblemCap:SetFont(IMAGO.FONT_BODY, 11)
    f.raceEmblemCap:SetPoint("TOP", f.raceEmblem, "BOTTOM", 0, -5)
    f.raceEmblemCap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    f.raceEmblem2Cap = f.raceEmblemBox:CreateFontString(nil, "OVERLAY")
    f.raceEmblem2Cap:SetFont(IMAGO.FONT_BODY, 11)
    f.raceEmblem2Cap:SetPoint("TOP", f.raceEmblem2, "BOTTOM", 0, -5)
    f.raceEmblem2Cap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    f.raceTabard = f.raceEmblemBox:CreateTexture(nil, "ARTWORK")
    f.raceTabard:SetSize(48, 62)
    f.raceTabard:SetPoint("TOP", f.raceEmblemBox, "TOP", 0, -112)
    f.raceTabard:SetAlpha(0.95)

    f.raceTabardCap = f.raceEmblemBox:CreateFontString(nil, "OVERLAY")
    f.raceTabardCap:SetFont(IMAGO.FONT_BODY, 11)
    f.raceTabardCap:SetPoint("TOP", f.raceTabard, "BOTTOM", 0, -5)
    f.raceTabardCap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    -- Zone image for the Settlements sub-tab (left column)
    f.raceZoneImage = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.raceZoneImage:SetSize(230, 130)
    f.raceZoneImage:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 35, -110)
    f.raceZoneImage:SetAlpha(0.9)
    f.raceZoneImage:Hide()

    f.raceZoneBorder = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.raceZoneBorder:SetPoint("TOPLEFT", f.raceZoneImage, "TOPLEFT", -2, 2)
    f.raceZoneBorder:SetPoint("BOTTOMRIGHT", f.raceZoneImage, "BOTTOMRIGHT", 2, -2)
    f.raceZoneBorder:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    f.raceZoneBorder:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.8)
    f.raceZoneBorder:Hide()

    -- Race artwork on the History sub-tab: like the zone hero it grows on
    -- mouseover from a cropped band to the full portrait. Textures are
    -- 2:3, so full height = width * 3 / 2.
    f.racePortrait = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.racePortrait._baseH, f.racePortrait._fullH = 230, 345
    f.racePortrait:SetSize(230, f.racePortrait._baseH)
    f.racePortrait:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 35, -110)
    f.racePortrait:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12 })
    f.racePortrait:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.8)
    f.racePortrait:EnableMouse(true)
    f.racePortrait:Hide()

    f.racePortrait.tex = f.racePortrait:CreateTexture(nil, "ARTWORK")
    f.racePortrait.tex:SetAllPoints()

    f.racePortrait._baseLevel = f.detailFrame:GetFrameLevel() + 1
    f.racePortrait:SetFrameLevel(f.racePortrait._baseLevel)

    function f.racePortrait:SetPortraitH(h)
        self:SetHeight(h)
        -- top-aligned crop: the base band shows head and shoulders.
        -- The 2:3 image sits in the top 0.75 of its 512x1024 power-of-2
        -- canvas, so the visible fraction scales against that bound.
        self.tex:SetTexCoord(0, 1, 0, 0.75 * math.min(1, h / self._fullH))
    end

    function f.racePortrait:Reset()
        self._cur, self._target = self._baseH, self._baseH
        self:SetPortraitH(self._baseH)
        self:SetFrameLevel(self._baseLevel)
    end

    f.racePortrait:SetScript("OnEnter", function(self)
        self._target = self._fullH
        self:SetFrameLevel(self._baseLevel + 60)
    end)
    f.racePortrait:SetScript("OnLeave", function(self)
        self._target = self._baseH
    end)
    f.racePortrait:SetScript("OnUpdate", function(self, dt)
        local cur, tgt = self._cur or self._baseH, self._target or self._baseH
        if cur == tgt then
            if cur == self._baseH and self:GetFrameLevel() ~= self._baseLevel then
                self:SetFrameLevel(self._baseLevel)
            end
            return
        end
        cur = cur + (tgt - cur) * math.min(1, dt * 12)
        if math.abs(tgt - cur) < 0.6 then cur = tgt end
        self._cur = cur
        self:SetPortraitH(cur)
    end)
    f.racePortrait:SetScript("OnHide", function(self) self:Reset() end)

    f.detailTitle = f.detailFrame:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.detailTitle, "DISPLAY")
    f.detailTitle:SetPoint("TOP", f.detailFrame, "TOP", 0, -15)
    f.detailTitle:SetWordWrap(false)
    f.detailTitle:SetWidth(640)
    f.detailTitle:SetJustifyH("CENTER")

    -- Invisible hover layer so a clipped title shows its full text
    f.titleHover = CreateFrame("Button", nil, f.detailFrame)
    f.titleHover:SetAllPoints(f.detailTitle)
    f.titleHover:SetScript("OnEnter", function(self)
        if f.detailTitle:IsShown() then
            IMAGO.ShowTooltipIfTruncated(self, f.detailTitle)
        end
    end)
    f.titleHover:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- The rule under the title spans the full inner width (left stage edge
    -- at x=10 to the footer's right edge at -8), centred on the title; it
    -- softens toward the ends but still reaches them
    local detailW = f:GetWidth() - LAYOUT.SIDEBAR_OFFSET_LEFT - LAYOUT.SIDEBAR_WIDTH
        - LAYOUT.CONTENT_PADDING_LEFT - LAYOUT.CONTENT_PADDING_RIGHT
    local GR = IMAGO_COLORS.GOLD
    f.detailLineLeft = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailLineLeft:SetSize(detailW / 2 - 10, 1)
    f.detailLineLeft:SetPoint("TOPRIGHT", f.detailTitle, "BOTTOM", 0, -8)
    f.detailLineLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.detailLineLeft:SetGradient("HORIZONTAL", CreateColor(GR[1], GR[2], GR[3], 0.28), CreateColor(GR[1], GR[2], GR[3], 0.7))

    f.detailLineRight = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailLineRight:SetSize(detailW / 2 - 8, 1)
    f.detailLineRight:SetPoint("TOPLEFT", f.detailTitle, "BOTTOM", 0, -8)
    f.detailLineRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.detailLineRight:SetGradient("HORIZONTAL", CreateColor(GR[1], GR[2], GR[3], 0.7), CreateColor(GR[1], GR[2], GR[3], 0.28))

    -- Zone elements (image, border, divider)
    f.detailImage = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailImage:SetSize(760, 200) -- Wide panorama format
    f.detailImage:SetPoint("TOP", f.detailFrame, "TOP", 0, -70) -- Centered
    f.detailImage:SetTexCoord(0, 1, 0.195, 0.805)
    f.detailImage:Hide()

    f.detailImageBorder = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.detailImageBorder:SetPoint("TOPLEFT", f.detailImage, "TOPLEFT", -2, 2)
    f.detailImageBorder:SetPoint("BOTTOMRIGHT", f.detailImage, "BOTTOMRIGHT", 2, -2)
    f.detailImageBorder:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    f.detailImageBorder:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.8)
    f.detailImageBorder:Hide()

    -- Zone hero: own frame so a hover can raise it above the text column
    -- and the side panel. Expands on mouseover from the banner height to the
    -- image's full 16:9 height, easing both size and crop band together.
    f.zoneHero = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.zoneHero:SetSize(760, ZONE_HERO_H)
    f.zoneHero:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12 })
    f.zoneHero:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.8)
    f.zoneHero:EnableMouse(true)
    f.zoneHero:Hide()

    f.zoneHero.tex = f.zoneHero:CreateTexture(nil, "ARTWORK")
    f.zoneHero.tex:SetAllPoints()

    f.zoneHero._baseLevel = f.detailFrame:GetFrameLevel() + 1
    f.zoneHero:SetFrameLevel(f.zoneHero._baseLevel)

    local ZONE_HERO_FULL = math.floor(760 * 9 / 16)

    function f.zoneHero:SetHeroH(h)
        self:SetHeight(h)
        local frac = math.min(1, (16 / 9) * h / 760)
        local v0 = math.max(0, math.min(1 - frac, (self._focus or 0.5) - frac / 2))
        self.tex:SetTexCoord(0, 1, v0, v0 + frac)
    end

    f.zoneHero:SetScript("OnEnter", function(self)
        self._target = ZONE_HERO_FULL
        self:SetFrameLevel(self._baseLevel + 60)
    end)
    f.zoneHero:SetScript("OnLeave", function(self)
        self._target = ZONE_HERO_H
    end)
    f.zoneHero:SetScript("OnUpdate", function(self, dt)
        local cur, tgt = self._cur or ZONE_HERO_H, self._target or ZONE_HERO_H
        if cur == tgt then
            if cur == ZONE_HERO_H and self:GetFrameLevel() ~= self._baseLevel then
                self:SetFrameLevel(self._baseLevel)
            end
            return
        end
        cur = cur + (tgt - cur) * math.min(1, dt * 12)
        if math.abs(tgt - cur) < 0.6 then cur = tgt end
        self._cur = cur
        self:SetHeroH(cur)
    end)

    f.detailSeparator = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailSeparator:SetSize(450, 8)
    f.detailSeparator:SetPoint("TOP", f.detailImage, "BOTTOM", 0, -15)
    f.detailSeparator:SetTexture("Interface\\COMMON\\UI-TooltipDivider-Transparent")
    f.detailSeparator:SetAlpha(0.6)
    f.detailSeparator:Hide()

    local function CreateTab(parent, text, xOffset, width)
        local tab = CreateFrame("Button", nil, parent)
        tab:SetSize(width or 100, 25)
        tab:SetPoint("TOPLEFT", parent, "TOPLEFT", 300 + xOffset, -80)

        tab.text = tab:CreateFontString(nil, "OVERLAY")
        tab.text:SetFont(IMAGO.FONT_BODY, 14, "OUTLINE")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(text)
        tab.text:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

        tab.activeLine = tab:CreateTexture(nil, "ARTWORK")
        tab.activeLine:SetSize(70, 2)
        tab.activeLine:SetPoint("BOTTOM", tab, "BOTTOM", 0, 0)
        tab.activeLine:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 1)
        tab.activeLine:Hide()
        return tab
    end

    f.tabLore = CreateTab(f.detailFrame, IMAGO.L["TAB_DETAIL_LORE"], 0)
    f.tabTime = CreateTab(f.detailFrame, IMAGO.L["TAB_DETAIL_TIMELINE"], 100)

    -- Fates sub-tabs sit on the shared left edge (LORE_X): text and the
    -- active underline are left-aligned and exactly as wide as the label
    for _, tab in ipairs({ f.tabLore, f.tabTime }) do
        local w = math.ceil(tab.text:GetStringWidth()) + 2
        tab:SetWidth(w)
        tab.text:ClearAllPoints()
        tab.text:SetPoint("LEFT", tab, "LEFT", 0, 0)
        tab.activeLine:ClearAllPoints()
        tab.activeLine:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT", 0, 0)
        tab.activeLine:SetWidth(w)
    end
    f.tabLore:ClearAllPoints()
    f.tabLore:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", LORE_X, -80)
    f.tabTime:ClearAllPoints()
    f.tabTime:SetPoint("TOPLEFT", f.tabLore, "TOPRIGHT", 28, 0)

    -- Zone sub-tabs (Lore | Places): same left-aligned label and underline
    -- as the Fates tabs; positioned per zone in ShowZoneDetail
    f.zoneTabs = {
        lore = CreateTab(f.detailFrame, IMAGO.L["TAB_DETAIL_LORE"], 0),
        poi  = CreateTab(f.detailFrame, IMAGO.L["ZONE_TAB_PLACES"] or "Places", 100),
    }
    for key, tab in pairs(f.zoneTabs) do
        local w = math.ceil(tab.text:GetStringWidth()) + 2
        tab:SetWidth(w)
        tab.text:ClearAllPoints()
        tab.text:SetPoint("LEFT", tab, "LEFT", 0, 0)
        tab.activeLine:ClearAllPoints()
        tab.activeLine:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT", 0, 0)
        tab.activeLine:SetWidth(w)
        tab:SetScript("OnClick", function() IMAGO.Chronicle.ShowZonePage(key) end)
        tab:Hide()
    end

    -- Race detail sub-tabs (Races tab, index 3). Six dossier sections;
    -- widths are measured from the label text (group tab name varies per
    -- race: Kingdoms / Clans / Tribes / Orders ...) and re-laid out in
    -- RenderRaceTab — see LayoutRaceTabs.
    f.raceTabKeys = {"overview", "history", "culture", "groups", "figures", "settlements"}
    local raceTabLocale = {
        overview    = "RACE_TAB_OVERVIEW",
        history     = "RACE_TAB_HISTORY",
        culture     = "RACE_TAB_CULTURE",
        groups      = "RACE_TAB_GROUPS",
        figures     = "RACE_TAB_FIGURES",
        settlements = "RACE_TAB_SETTLEMENTS",
    }
    f.raceTabs = {}
    for i, key in ipairs(f.raceTabKeys) do
        local tab = CreateTab(f.detailFrame, IMAGO.L[raceTabLocale[key]] or key, 0)
        tab.text:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
        tab.raceTabKey = key
        tab.raceLocaleKey = raceTabLocale[key]
        tab:SetScript("OnClick", function()
            f.activeRaceTab = key
            if f.selectedRace then
                IMAGO.Chronicle.RenderRaceTab(key)
            end
            if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
        end)
        tab:Hide()
        f.raceTabs[i] = tab
    end

    -- Class detail sub-tabs (Classes tab, index 4). Five dossier sections;
    -- widths are measured from the label text and re-laid out in
    -- RenderClassTab — same strip mechanics as the race tabs.
    f.classTabKeys = {"overview", "history", "races", "orgs", "members"}
    local classTabLocale = {
        overview = "CLASS_TAB_OVERVIEW",
        history  = "CLASS_TAB_HISTORY",
        races    = "CLASS_TAB_RACES",
        orgs     = "CLASS_TAB_ORGS",
        members  = "CLASS_TAB_MEMBERS",
    }
    f.classTabs = {}
    for i, key in ipairs(f.classTabKeys) do
        local tab = CreateTab(f.detailFrame, IMAGO.L[classTabLocale[key]] or key, 0)
        tab.text:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
        tab.classTabKey = key
        tab.classLocaleKey = classTabLocale[key]
        tab:SetScript("OnClick", function()
            f.activeClassTab = key
            if f.selectedClass then
                IMAGO.Chronicle.RenderClassTab(key)
            end
            if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
        end)
        tab:Hide()
        f.classTabs[i] = tab
    end

    -- Class emblem (left column, shown on every sub-tab): the class icon
    -- in a gold ring — mirrors the race emblem box.
    f.classEmblemBox = CreateFrame("Frame", nil, f.detailFrame)
    f.classEmblemBox:SetSize(230, 250)
    f.classEmblemBox:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 35, -110)
    f.classEmblemBox:Hide()

    local function MakeClassEmblem(parent, size, yOffset)
        local t = parent:CreateTexture(nil, "ARTWORK")
        t:SetSize(size, size)
        t:SetPoint("TOP", parent, "TOP", 0, yOffset)
        t:SetAlpha(0.95)
        local ring = CreateFrame("Frame", nil, parent, "BackdropTemplate")
        ring:SetPoint("TOPLEFT", t, "TOPLEFT", -2, 2)
        ring:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 2, -2)
        ring:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 10,
        })
        ring:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
        return t
    end

    f.classIcon  = MakeClassEmblem(f.classEmblemBox, 88, -14)

    -- Class crest: large artwork under the icon; a Button wrapper so the
    -- hover state can grow it softly around its center (196 -> 232)
    local crestBtn = CreateFrame("Button", nil, f.classEmblemBox)
    crestBtn:SetSize(150, 150)
    crestBtn:SetPoint("CENTER", f.classEmblemBox, "TOP", 0, -200)
    f.classCrest = crestBtn:CreateTexture(nil, "ARTWORK")
    f.classCrest:SetAllPoints()
    f.classCrest:SetAlpha(0.95)
    crestBtn._size, crestBtn._target = 150, 150
    crestBtn:SetScript("OnEnter", function(self) self._target = 180 end)
    crestBtn:SetScript("OnLeave", function(self) self._target = 150 end)
    crestBtn:SetScript("OnUpdate", function(self)
        local diff = self._target - self._size
        if diff ~= 0 and math.abs(diff) > 0.5 then
            self._size = self._size + diff * 0.25
            self:SetSize(self._size, self._size)
        end
    end)

    f.classIconCap = f.classEmblemBox:CreateFontString(nil, "OVERLAY")
    f.classIconCap:SetFont(IMAGO.FONT_BODY, 11)
    f.classIconCap:SetPoint("TOP", f.classIcon, "BOTTOM", 0, -5)
    f.classIconCap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    f.classCrestCap = f.classEmblemBox:CreateFontString(nil, "OVERLAY")
    f.classCrestCap:SetFont(IMAGO.FONT_BODY, 11)
    f.classCrestCap:SetPoint("TOP", f.classCrest, "BOTTOM", 0, -5)
    f.classCrestCap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    -- Shared bottom-fade widget for scrolling text columns: a 24px
    -- gradient pinned to the scroll frame's bottom edge. Visibility is
    -- driven by UpdateScrollBarVisibility (only while real content is
    -- still hidden below the viewport).
    local function AttachBottomFade(scrollFrame, parent)
        local fade = CreateFrame("Frame", nil, parent or scrollFrame:GetParent())
        fade:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMLEFT", 0, 0)
        fade:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", -IMAGO.LAYOUT.SCROLLBAR_GUTTER, 0)
        fade:SetHeight(24)
        fade:SetFrameLevel(scrollFrame:GetFrameLevel() + 5)
        local tex = fade:CreateTexture(nil, "OVERLAY")
        tex:SetAllPoints()
        tex:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        tex:SetGradient("VERTICAL",
            CreateColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 1),
            CreateColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0))
        fade:Hide()
        scrollFrame.imagoBottomFade = fade
        return fade
    end

    -- ============================================================
    -- CODEX PANELS (tab 5): middle entry list + right content column
    -- ============================================================
    f.codexListPanel = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.codexListPanel:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, 0)
    f.codexListPanel:SetPoint("BOTTOMLEFT", f.detailFrame, "BOTTOMLEFT", 10, 0)
    f.codexListPanel:SetWidth(250)
    f.codexListPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    f.codexListPanel:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.85)
    f.codexListPanel:Hide()

    f.codexListPanel.rightBorder = f.codexListPanel:CreateTexture(nil, "ARTWORK")
    f.codexListPanel.rightBorder:SetWidth(LAYOUT.DIVIDER_WIDTH)
    f.codexListPanel.rightBorder:SetPoint("TOPRIGHT", f.codexListPanel, "TOPRIGHT", 0, 0)
    f.codexListPanel.rightBorder:SetPoint("BOTTOMRIGHT", f.codexListPanel, "BOTTOMRIGHT", 0, 0)
    f.codexListPanel.rightBorder:SetColorTexture(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.8)

    -- Panel header row: shows the selected category / "Search Results"
    f.codexCatHeading = f.codexListPanel:CreateFontString(nil, "OVERLAY")
    f.codexCatHeading:SetFont(IMAGO.FONT_TITLE, 15, "OUTLINE")
    f.codexCatHeading:SetPoint("TOPLEFT", f.codexListPanel, "TOPLEFT", 12, -9)
    f.codexCatHeading:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.codexCatHeading:SetJustifyH("LEFT")
    f.codexCatHeading:Hide()

    f.codexListPanel.headingLine = f.codexListPanel:CreateTexture(nil, "ARTWORK")
    f.codexListPanel.headingLine:SetHeight(1)
    f.codexListPanel.headingLine:SetPoint("TOPLEFT", f.codexListPanel, "TOPLEFT", 10, -34)
    f.codexListPanel.headingLine:SetPoint("TOPRIGHT", f.codexListPanel, "TOPRIGHT", -10, -34)
    f.codexListPanel.headingLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.codexListPanel.headingLine:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    f.codexListScroll = CreateFrame("ScrollFrame", "IMAGOChronicleCodexList", f.codexListPanel, "UIPanelScrollFrameTemplate")
    f.codexListScroll:SetPoint("TOPLEFT", f.codexListPanel, "TOPLEFT", 0, -40)
    f.codexListScroll:SetPoint("BOTTOMRIGHT", f.codexListPanel, "BOTTOMRIGHT", 0, 4)
    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleCodexListScrollBar", f.codexListScroll)

    f.codexListContent = CreateFrame("Frame", nil, f.codexListScroll)
    f.codexListContent:SetSize(238, 1)
    f.codexListScroll:SetScrollChild(f.codexListContent)

    f.codexContent = CreateFrame("Frame", nil, f.detailFrame)
    f.codexContent:SetPoint("TOPLEFT", f.codexListPanel, "TOPRIGHT", 15, -10)
    f.codexContent:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -15, 20)
    f.codexContent:Hide()

    f.codexTitle = f.codexContent:CreateFontString(nil, "OVERLAY")
    f.codexTitle:SetFont(IMAGO.FONT_TITLE, 24, "OUTLINE")
    f.codexTitle:SetPoint("TOPLEFT", f.codexContent, "TOPLEFT", 10, -5)
    f.codexTitle:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.codexTitle:SetJustifyH("LEFT")

    f.codexCatTag = f.codexContent:CreateFontString(nil, "OVERLAY")
    f.codexCatTag:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
    f.codexCatTag:SetPoint("TOPLEFT", f.codexTitle, "BOTTOMLEFT", 0, -8)
    f.codexCatTag:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    f.codexCatTag:SetJustifyH("LEFT")

    f.codexDivider = f.codexContent:CreateTexture(nil, "ARTWORK")
    f.codexDivider:SetHeight(1)
    f.codexDivider:SetPoint("TOPLEFT", f.codexCatTag, "BOTTOMLEFT", 0, -8)
    f.codexDivider:SetPoint("TOPRIGHT", f.codexContent, "TOPRIGHT", -10, -70)
    f.codexDivider:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.codexDivider:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    f.codexBodyScroll = CreateFrame("ScrollFrame", "IMAGOChronicleCodexBody", f.codexContent, "UIPanelScrollFrameTemplate")
    f.codexBodyScroll:SetPoint("TOPLEFT", f.codexContent, "TOPLEFT", 10, -90)
    f.codexBodyScroll:SetPoint("BOTTOMRIGHT", f.codexContent, "BOTTOMRIGHT", -10, 10)
    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleCodexBodyScrollBar", f.codexBodyScroll, IMAGO_COLORS.GOLD)
    AttachBottomFade(f.codexBodyScroll, f.codexContent)

    f.codexBodyContent = CreateFrame("Frame", nil, f.codexBodyScroll)
    f.codexBodyContent:SetSize(460, 1)
    f.codexBodyScroll:SetScrollChild(f.codexBodyContent)
    f.codexBodyContent:SetHyperlinksEnabled(true)
    f.codexBodyContent:EnableMouse(true)
    f.codexBodyContent:SetScript("OnHyperlinkClick", function(self, link, text, button)
        if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
            IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
        end
    end)

    f.codexBody = f.codexBodyContent:CreateFontString(nil, "OVERLAY")
    f.codexBody:SetFont(IMAGO.FONT_BODY, 14)
    f.codexBody:SetPoint("TOPLEFT", f.codexBodyContent, "TOPLEFT", 0, 0)
    f.codexBody:SetWidth(460)
    f.codexBody:SetJustifyH("LEFT")
    f.codexBody:SetSpacing(8)
    f.codexBody:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])

    -- ============================================================
    -- TIMELINE PANELS (Tab 5: chronology list + event detail)
    -- ============================================================
    f.timelineListPanel = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.timelineListPanel:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, 0)
    f.timelineListPanel:SetPoint("BOTTOMLEFT", f.detailFrame, "BOTTOMLEFT", 10, 0)
    f.timelineListPanel:SetWidth(250)
    f.timelineListPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    f.timelineListPanel:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.85)
    f.timelineListPanel:Hide()

    f.timelineListPanel.rightBorder = f.timelineListPanel:CreateTexture(nil, "ARTWORK")
    f.timelineListPanel.rightBorder:SetWidth(LAYOUT.DIVIDER_WIDTH)
    f.timelineListPanel.rightBorder:SetPoint("TOPRIGHT", f.timelineListPanel, "TOPRIGHT", 0, 0)
    f.timelineListPanel.rightBorder:SetPoint("BOTTOMRIGHT", f.timelineListPanel, "BOTTOMRIGHT", 0, 0)
    f.timelineListPanel.rightBorder:SetColorTexture(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.8)

    f.timelineChronoHeading = f.timelineListPanel:CreateFontString(nil, "OVERLAY")
    f.timelineChronoHeading:SetFont(IMAGO.FONT_TITLE, 15, "OUTLINE")
    f.timelineChronoHeading:SetPoint("TOPLEFT", f.timelineListPanel, "TOPLEFT", 12, -9)
    f.timelineChronoHeading:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.timelineChronoHeading:SetJustifyH("LEFT")
    f.timelineChronoHeading:Hide()

    f.timelineListPanel.headingLine = f.timelineListPanel:CreateTexture(nil, "ARTWORK")
    f.timelineListPanel.headingLine:SetHeight(1)
    f.timelineListPanel.headingLine:SetPoint("TOPLEFT", f.timelineListPanel, "TOPLEFT", 10, -34)
    f.timelineListPanel.headingLine:SetPoint("TOPRIGHT", f.timelineListPanel, "TOPRIGHT", -10, -34)
    f.timelineListPanel.headingLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.timelineListPanel.headingLine:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    f.timelineListScroll = CreateFrame("ScrollFrame", "IMAGOChronicleTimelineList", f.timelineListPanel, "UIPanelScrollFrameTemplate")
    f.timelineListScroll:SetPoint("TOPLEFT", f.timelineListPanel, "TOPLEFT", 0, -40)
    f.timelineListScroll:SetPoint("BOTTOMRIGHT", f.timelineListPanel, "BOTTOMRIGHT", 0, 4)
    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleTimelineListScrollBar", f.timelineListScroll, IMAGO_COLORS.GOLD)

    f.timelineListContent = CreateFrame("Frame", nil, f.timelineListScroll)
    f.timelineListContent:SetSize(236, 1)
    f.timelineListScroll:SetScrollChild(f.timelineListContent)

    -- The vertical chronology line running behind the node dots
    f.timelineListContent.line = f.timelineListContent:CreateTexture(nil, "BORDER")
    f.timelineListContent.line:SetWidth(2)
    f.timelineListContent.line:SetColorTexture(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3], 0.35)

    f.timelineContent = CreateFrame("Frame", nil, f.detailFrame)
    f.timelineContent:SetPoint("TOPLEFT", f.timelineListPanel, "TOPRIGHT", 15, -10)
    f.timelineContent:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -15, 20)
    f.timelineContent:Hide()

    f.timelineTitle = f.timelineContent:CreateFontString(nil, "OVERLAY")
    f.timelineTitle:SetFont(IMAGO.FONT_TITLE, 24, "OUTLINE")
    f.timelineTitle:SetPoint("TOPLEFT", f.timelineContent, "TOPLEFT", 10, -5)
    f.timelineTitle:SetWidth(455)
    f.timelineTitle:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.timelineTitle:SetJustifyH("LEFT")

    f.timelineEraTag = f.timelineContent:CreateFontString(nil, "OVERLAY")
    f.timelineEraTag:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
    f.timelineEraTag:SetPoint("TOPLEFT", f.timelineTitle, "BOTTOMLEFT", 0, -4)
    f.timelineEraTag:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    f.timelineEraTag:SetJustifyH("LEFT")

    f.timelineDivider = f.timelineContent:CreateTexture(nil, "ARTWORK")
    f.timelineDivider:SetHeight(1)
    f.timelineDivider:SetPoint("TOPLEFT", f.timelineContent, "TOPLEFT", 10, -70)
    f.timelineDivider:SetPoint("TOPRIGHT", f.timelineContent, "TOPRIGHT", -10, -70)
    f.timelineDivider:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.timelineDivider:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    f.timelineBodyScroll = CreateFrame("ScrollFrame", "IMAGOChronicleTimelineBody", f.timelineContent, "UIPanelScrollFrameTemplate")
    f.timelineBodyScroll:SetPoint("TOPLEFT", f.timelineContent, "TOPLEFT", 10, -90)
    f.timelineBodyScroll:SetPoint("BOTTOMRIGHT", f.timelineContent, "BOTTOMRIGHT", -10, 10)
    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleTimelineBodyScrollBar", f.timelineBodyScroll, IMAGO_COLORS.GOLD)
    AttachBottomFade(f.timelineBodyScroll, f.timelineContent)

    f.timelineBodyContent = CreateFrame("Frame", nil, f.timelineBodyScroll)
    f.timelineBodyContent:SetSize(460, 1)
    f.timelineBodyScroll:SetScrollChild(f.timelineBodyContent)
    f.timelineBodyContent:SetHyperlinksEnabled(true)
    f.timelineBodyContent:EnableMouse(true)
    f.timelineBodyContent:SetScript("OnHyperlinkClick", function(self, link, text, button)
        if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
            IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
        end
    end)

    f.timelineBody = f.timelineBodyContent:CreateFontString(nil, "OVERLAY")
    f.timelineBody:SetFont(IMAGO.FONT_BODY, 14)
    f.timelineBody:SetPoint("TOPLEFT", f.timelineBodyContent, "TOPLEFT", 0, 0)
    f.timelineBody:SetWidth(460)
    f.timelineBody:SetJustifyH("LEFT")
    f.timelineBody:SetSpacing(6)
    f.timelineBody:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])

    f.infoScroll = CreateFrame("ScrollFrame", "IMAGOChronicleInfoScroll", f.detailFrame, "UIPanelScrollFrameTemplate")
    f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", LORE_X - LORE_INSET, -116)
    f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", LORE_RIGHT, f._infoBottom or 100)

    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleInfoScrollScrollBar", f.infoScroll, IMAGO_COLORS.GOLD)

    -- Bottom fade-out over the scroll viewport: signals that more text
    -- follows instead of cutting a line in half. Only visible while the
    -- content actually overflows (wired in UpdateScrollBarVisibility).
    f.infoScrollFade = AttachBottomFade(f.infoScroll, f.detailFrame)

    f.infoContent = CreateFrame("Frame", nil, f.infoScroll)
    f.infoContent:SetSize(440, 1)
    f.infoScroll:SetScrollChild(f.infoContent)

    f.loreBody = f.infoContent:CreateFontString(nil, "OVERLAY")
    f.loreBody:SetFont(IMAGO.FONT_BODY, 14)
    f.loreBody:SetPoint("TOPLEFT", f.infoContent, "TOPLEFT", LORE_INSET, 0)
    f.loreBody:SetWidth(420)
    f.loreBody:SetJustifyH("LEFT")
    f.loreBody:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
    f.loreBody:SetSpacing(6)

    f.loreSource = f.infoContent:CreateFontString(nil, "OVERLAY")
    f.loreSource:SetFont(IMAGO.FONT_BODY, 12, "")
    f.loreSource:SetPoint("BOTTOMRIGHT", f.infoContent, "BOTTOMRIGHT", -20, 8)
    f.loreSource:SetWidth(420)
    f.loreSource:SetJustifyH("LEFT")
    f.loreSource:SetWordWrap(false)
    f.loreSource:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    f.loreSource:Hide()

    f.infoContent:SetHyperlinksEnabled(true)
    f.infoContent:SetScript("OnHyperlinkClick", function(self, link, text, button)
        if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
            IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
        end
    end)

    local function AdjustInfoScroll()
        if not f.infoScroll or not f.infoContent then return end
        local w = f.infoScroll:GetWidth()
        if not w or w <= 0 then return end
        local contentW = math.max(1, w - IMAGO.LAYOUT.SCROLLBAR_GUTTER)
        f.infoContent:SetWidth(contentW)
        -- Lore and the Timeline sub-tab share one right edge; the column
        -- stays wider than the text on purpose (comfortable right margin)
        local textW = math.min(contentW - LORE_INSET - (f.infoScroll._extraPad or 0), LORE_TEXT_W)
        f.loreBody:ClearAllPoints()
        -- Center-justified pages (e.g. the undiscovered-zone note) must span
        -- the full scroll width, otherwise the text only centers inside a
        -- narrow left-anchored box.
        if f.loreBody.GetJustifyH and f.loreBody:GetJustifyH() == "CENTER" then
            f.loreBody:SetWidth(contentW)
            f.loreBody:SetPoint("TOP", f.infoContent, "TOP", 0, 0)
        else
            f.loreBody:SetWidth(textW)
            f.loreBody:SetPoint("TOPLEFT", f.infoContent, "TOPLEFT", LORE_INSET, 0)
        end
        if f.loreSource then
            f.loreSource:SetWidth(textW)
        end
        if f.timelineContainer then
            f.timelineContainer:SetWidth(contentW - LORE_INSET)
        end
        local h = 1
        if f.loreBody:IsShown() then
            -- the source line follows the text: left-aligned, 14 px below
            local y = f.loreBody:GetStringHeight() + 10
            if f.loreSource and f.loreSource:IsShown() then
                f.loreSource:ClearAllPoints()
                f.loreSource:SetPoint("TOPLEFT", f.loreBody, "BOTTOMLEFT", 0, -14)
                y = y + 14 + f.loreSource:GetStringHeight()
            end
            h = y + 12
        elseif f.timelineContainer and f.timelineContainer:IsShown() then
            h = f.timelineContainer:GetHeight() + 20
        end
        f.infoContent:SetHeight(math.max(1, h))
        IMAGO.UpdateScrollBarVisibility(f.infoScroll)
    end

    local anims = {
        {id=3, label="St", name="Static"},
        {id=5, label="Ru", name="Run"},
        {id=26, label="Cs", name="Combat"},
        {id=18, label="At", name="Attack"}
    }

    -- Full interaction setup for a PlayerModel: anim buttons, zoom, rotate, pan.
    -- Applied to detailModel immediately and to detailModel2 on first use.
    -- Anim buttons sit centered in a bar at the bottom of mdl._btnHost
    -- (the stage frame for detailModel, the model itself otherwise).
    local function ApplyModelUI(mdl)
        mdl.animButtons = {}
        local host = mdl._btnHost or mdl
        local function UpdateAnimButtons(activeId)
            for _, btn in ipairs(mdl.animButtons) do
                btn:ChromeRest(btn.animId == activeId)
            end
        end

        for i, anim in ipairs(anims) do
            local btn = CreateFrame("Button", nil, host, "BackdropTemplate")
            btn:SetSize(30, 20)
            btn:SetPoint("BOTTOM", host, "BOTTOM", (i - (#anims + 1) / 2) * 36, 10)
            btn.animId = anim.id
            ChromeButton(btn)

            -- Text
            btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            btn.text:SetPoint("CENTER")
            btn.text:SetFont(IMAGO.FONT_BODY, 12, "")
            btn.text:SetText(anim.label)
            btn.text:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

            -- Click
            btn:SetScript("OnClick", function()
                mdl:SetAnimation(anim.id)
                mdl.currentAnim = anim.id
                UpdateAnimButtons(anim.id)
            end)

            -- Hover
            btn:SetScript("OnEnter", function()
                btn:ChromeHover()
                btn.text:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            end)
            btn:SetScript("OnLeave", function()
                btn:ChromeRest(btn.animId == mdl.currentAnim)
                btn.text:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
            end)

            table.insert(mdl.animButtons, btn)
        end

        mdl.UpdateAnimButtons = UpdateAnimButtons

        -- Start OnShow animation
        mdl:SetScript("OnShow", function(self)
            self:SetAnimation(0) -- Idle as default
            if self.UpdateAnimButtons then
                self.UpdateAnimButtons(0)
            end
        end)

        mdl:EnableMouse(true)
        mdl:EnableMouseWheel(true)
        mdl:SetScript("OnMouseWheel", function(self, delta)
            local zoom = self.zoomLevel or 1.0
            zoom = zoom - (delta * 0.15)
            if zoom < 0.2 then zoom = 0.2 end
            if zoom > 3.0 then zoom = 3.0 end
            self:SetCamDistanceScale(zoom)
            self.zoomLevel = zoom
        end)
        mdl:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" then
                self.isRotating = true
                self.lastX, self.lastY = GetCursorPosition()
            elseif button == "RightButton" then
                self.isPanning = true
                self.lastX, self.lastY = GetCursorPosition()
            end
        end)
        mdl:SetScript("OnMouseUp", function(self, button)
            if button == "LeftButton" then self.isRotating = false end
            if button == "RightButton" then self.isPanning = false end
        end)
        mdl:SetScript("OnHide", function(self)
            self.isRotating = false
            self.isPanning = false
        end)
        mdl:SetScript("OnUpdate", function(self)
            local x, y = GetCursorPosition()
            if self.isRotating then
                local diff = (x - self.lastX) * 0.01
                self.lastX = x
                self:SetFacing((self:GetFacing() or 0) + diff)
            elseif self.isPanning then
                local diffX = (x - self.lastX) * 0.01
                local diffY = (y - self.lastY) * 0.01
                self.lastX = x
                self.lastY = y
                self.posY = (self.posY or 0) + diffX
                self.posZ = (self.posZ or 0) + diffY
                self:SetPosition(self.posX or 0, self.posY, self.posZ)
            end
        end)
    end

    -- Model stage: a slightly lighter surface with a soft glow behind the
    -- model (no border — the detail pane's own background is the frame).
    -- The stage carries the anim-button bar along its bottom edge.
    f.stageFrame = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    local st = f.stageFrame
    st:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -76)
    st:SetPoint("BOTTOMLEFT", f.detailFrame, "BOTTOMLEFT", 10, f._infoBottom or 180)
    st:SetWidth(264)
    st:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    st:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.5)
    st:SetFrameLevel(f.detailFrame:GetFrameLevel())
    -- Depth without borders: a warm spotlight column behind the model
    -- (two mirrored gradients), warm floor light rising from the anim
    -- bar, and dark vignettes on all four edges
    local WHITE = "Interface\\ChatFrame\\ChatFrameBackground"
    local GC = IMAGO_COLORS.GOLD
    local function StageLayer(sub, orient, c1, a1, c2, a2)
        local t = st:CreateTexture(nil, "BACKGROUND", nil, sub)
        t:SetTexture(WHITE)
        t:SetGradient(orient, CreateColor(c1[1], c1[2], c1[3], a1), CreateColor(c2[1], c2[2], c2[3], a2))
        return t
    end
    local BLACK = { 0, 0, 0 }
    -- spotlight column: left half fades in, right half fades out
    st.spotL = StageLayer(1, "HORIZONTAL", GC, 0, GC, 0.055)
    st.spotL:SetPoint("TOPLEFT", st, "TOPLEFT", 0, 0)
    st.spotL:SetPoint("BOTTOMRIGHT", st, "BOTTOM", 0, 0)
    st.spotR = StageLayer(1, "HORIZONTAL", GC, 0.055, GC, 0)
    st.spotR:SetPoint("TOPLEFT", st, "TOP", 0, 0)
    st.spotR:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", 0, 0)
    -- floor light above the anim bar
    st.floor = StageLayer(2, "VERTICAL", GC, 0.035, GC, 0)
    st.floor:SetPoint("BOTTOMLEFT", st, "BOTTOMLEFT", 0, 0)
    st.floor:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", 0, 0)
    st.floor:SetHeight(120)
    -- bottom vignette: settles the stage floor instead of lighting it
    st.vigB = StageLayer(3, "VERTICAL", BLACK, 0.40, BLACK, 0)
    st.vigB:SetPoint("BOTTOMLEFT", st, "BOTTOMLEFT", 0, 0)
    st.vigB:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", 0, 0)
    st.vigB:SetHeight(90)
    -- edge vignettes
    st.vigL = StageLayer(3, "HORIZONTAL", BLACK, 0.45, BLACK, 0)
    st.vigL:SetPoint("TOPLEFT", st, "TOPLEFT", 0, 0)
    st.vigL:SetPoint("BOTTOMLEFT", st, "BOTTOMLEFT", 0, 0)
    st.vigL:SetWidth(56)
    st.vigR = StageLayer(3, "HORIZONTAL", BLACK, 0, BLACK, 0.45)
    st.vigR:SetPoint("TOPRIGHT", st, "TOPRIGHT", 0, 0)
    st.vigR:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", 0, 0)
    st.vigR:SetWidth(56)
    st.vigT = StageLayer(3, "VERTICAL", BLACK, 0, BLACK, 0.45)
    st.vigT:SetPoint("TOPLEFT", st, "TOPLEFT", 0, 0)
    st.vigT:SetPoint("TOPRIGHT", st, "TOPRIGHT", 0, 0)
    st.vigT:SetHeight(48)
    -- anim bar: a darker strip along the stage floor
    st.bar = st:CreateTexture(nil, "BACKGROUND", nil, 4)
    st.bar:SetColorTexture(0, 0, 0, 0.18)
    st.bar:SetPoint("BOTTOMLEFT", st, "BOTTOMLEFT", 0, 0)
    st.bar:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", 0, 0)
    st.bar:SetHeight(40)
    st:Hide()

    f.detailModel = CreateFrame("PlayerModel", nil, f.detailFrame)
    f.detailModel._btnHost = st
    f.detailModel:SetPoint("TOPLEFT", st, "TOPLEFT", 8, -8)
    f.detailModel:SetPoint("BOTTOMRIGHT", st, "BOTTOMRIGHT", -8, 40)
    ApplyModelUI(f.detailModel)
    f.ApplyModelUI = ApplyModelUI

    -- The stage/lore panels exist only for fate details. The race/mount
    -- view reuses detailModel outside the stage, so _inStage gates it.
    f.detailModel:HookScript("OnShow", function(mdl)
        if mdl._inStage then
            mdl:ClearAllPoints()
            mdl:SetPoint("TOPLEFT", f.stageFrame, "TOPLEFT", 8, -8)
            mdl:SetPoint("BOTTOMRIGHT", f.stageFrame, "BOTTOMRIGHT", -8, 40)
            f.stageFrame:Show()
        end
    end)
    f.detailModel:HookScript("OnHide", function()
        if f.stageFrame then f.stageFrame:Hide() end
        -- race-mode captions die with their model wherever it is hidden
        if f.detailModelCap then f.detailModelCap:Hide() end
    end)

    -- Empty-state: shown in the detail pane until an entry is selected
    f.startPage = CreateFrame("Frame", nil, f.detailFrame)
    f.startPage:SetAllPoints()

    f.startPage.logo = f.startPage:CreateTexture(nil, "ARTWORK")
    f.startPage.logo:SetSize(110, 110)
    f.startPage.logo:SetPoint("TOP", f.startPage, "TOP", 0, -140)
    f.startPage.logo:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\Logo.tga")
    f.startPage.logo:SetAlpha(0.35)

    f.startPage.logoLine = f.startPage:CreateTexture(nil, "ARTWORK")
    f.startPage.logoLine:SetSize(320, 1)
    f.startPage.logoLine:SetPoint("TOP", f.startPage.logo, "BOTTOM", 0, -12)
    f.startPage.logoLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.startPage.logoLine:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35))

    f.startPage.hint = f.startPage:CreateFontString(nil, "OVERLAY")
    f.startPage.hint:SetFont(IMAGO.FONT_BODY, 13)
    f.startPage.hint:SetPoint("TOP", f.startPage.logoLine, "BOTTOM", 0, -18)
    f.startPage.hint:SetWidth(420)
    f.startPage.hint:SetJustifyH("CENTER")
    f.startPage.hint:SetSpacing(4)
    f.startPage.hint:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    f.startPage.hint:SetText(IMAGO.L["STARTPAGE_HINT"] or "Select an entry from the list.")

    f.hintPage = CreateFrame("Frame", nil, f.detailFrame)
    f.hintPage:SetAllPoints()
    f.hintPage:Hide()

    -- 1. An invisible anchor point, oriented to TOP with a 100px offset downward
    f.hintPage.centerAnchor = CreateFrame("Frame", nil, f.hintPage)
    f.hintPage.centerAnchor:SetPoint("TOP", f.detailFrame, "TOP", 0, -200)
    f.hintPage.centerAnchor:SetSize(1, 1)

    -- 2. The void aura (pulsing, in the background)
    f.hintPage.aura = f.hintPage:CreateTexture(nil, "BACKGROUND")
    f.hintPage.aura:SetSize(300, 300) -- Slightly larger than the original
    f.hintPage.aura:SetPoint("CENTER", f.hintPage.centerAnchor, "CENTER", 0, 0)
    f.hintPage.aura:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\undiscovered.tga") 
    f.hintPage.aura:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3]) -- Magic gold

    local agAura = f.hintPage.aura:CreateAnimationGroup()
    local fadeOut = agAura:CreateAnimation("Alpha")
    fadeOut:SetFromAlpha(0.8)
    fadeOut:SetToAlpha(0.2)
    fadeOut:SetDuration(2.5) -- Breathes out slowly
    fadeOut:SetOrder(1)
    fadeOut:SetSmoothing("IN_OUT")
    local fadeIn = agAura:CreateAnimation("Alpha")
    fadeIn:SetFromAlpha(0.2)
    fadeIn:SetToAlpha(0.8)
    fadeIn:SetDuration(2.5) -- Breathes in slowly
    fadeIn:SetOrder(2)
    fadeIn:SetSmoothing("IN_OUT")
    agAura:SetLooping("REPEAT")
    agAura:Play()

    -- 3. The void silhouette (static, firmly anchored)
    f.hintPage.icon = f.hintPage:CreateTexture(nil, "ARTWORK")
    f.hintPage.icon:SetSize(250, 250) 
    f.hintPage.icon:SetPoint("CENTER", f.hintPage.centerAnchor, "CENTER", 0, 0)
    f.hintPage.icon:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\undiscovered.tga")
    -- Reduces opacity to 75% for a more ghostly look
    f.hintPage.icon:SetAlpha(0.4)

    -- 4. The warning text (flows cleanly below the icon again)
    f.hintPage.warning = f.hintPage:CreateFontString(nil, "OVERLAY")
    f.hintPage.warning:SetFont(IMAGO.FONT_BODY, 15, "OUTLINE")
    f.hintPage.warning:SetPoint("TOP", f.hintPage.icon, "BOTTOM", 0, -20)
    f.hintPage.warning:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.hintPage.warning:SetText(IMAGO.L["HINT_IDENTITY_HIDDEN"])

    -- 5. The description
    f.hintPage.desc = f.hintPage:CreateFontString(nil, "OVERLAY")
    f.hintPage.desc:SetFont(IMAGO.FONT_BODY, 14)
    f.hintPage.desc:SetPoint("TOP", f.hintPage.warning, "BOTTOM", 0, -15)
    f.hintPage.desc:SetWidth(400)
    f.hintPage.desc:SetJustifyH("CENTER")
    f.hintPage.desc:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.hintPage.desc:SetSpacing(6)

    -- ==========================================
    -- FOOTER BAND: one flat surface across the detail pane in the stage's
    -- lighter tone. Three columns — DOSSIER, CONNECTIONS, RECORD — split
    -- by ~30 px of air, no borders, no hairlines. Height fits content.
    -- ==========================================
    local function OnFactLink(self, link, text, button)
        local cat = link:match("^imago%-cat:(.+)$")
        if cat then
            IMAGO.Chronicle.FocusCategory(cat)
            return
        end
        local race = link:match("^imago%-race:(.+)$")
        if race then
            IMAGO.Chronicle.OpenToRace(race)
            return
        end
        local class = link:match("^imago%-class:(.+)$")
        if class then
            IMAGO.Chronicle.OpenToClass(class)
        elseif IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
            IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
        end
    end

    f.factsMeasure = f.detailFrame:CreateFontString(nil, "OVERLAY")
    f.factsMeasure:SetFont(IMAGO.FONT_BODY, 13)
    f.factsMeasure:SetWordWrap(false)
    f.factsMeasure:Hide()

    local band = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    band:SetPoint("BOTTOMLEFT", f.detailFrame, "BOTTOMLEFT", 10, 8)
    band:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -8, 8)
    band:SetHeight(120)
    band:SetFrameLevel(f.detailFrame:GetFrameLevel() + 3)
    -- flat surface in the same lighter tone as the model stage; the
    -- three columns are separated by ~30 px of air, not by hairlines
    band:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    band:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.5)
    band:Hide()
    f.factsBand = band

    -- Three columns (ratio 1.1 : 1.15 : 1), padded 16 px each side
    band.PAD, band.ROW_Y, band.ROW_H = 10, 38, 21
    band.LAB_W, band.TAG_W = 64, 50

    -- Column separators: 1 px in the dark line colour, fading out softly
    -- at both ends (two half-height gradients meeting in the middle)
    band.seps = {}
    local DV = IMAGO_COLORS.DIVIDER
    for i = 1, 2 do
        local up = band:CreateTexture(nil, "BACKGROUND", nil, 1)
        up:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        up:SetWidth(1)
        up:SetGradient("VERTICAL", CreateColor(DV[1], DV[2], DV[3], 1), CreateColor(DV[1], DV[2], DV[3], 0))
        local dn = band:CreateTexture(nil, "BACKGROUND", nil, 1)
        dn:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        dn:SetWidth(1)
        dn:SetGradient("VERTICAL", CreateColor(DV[1], DV[2], DV[3], 0), CreateColor(DV[1], DV[2], DV[3], 1))
        band.seps[i] = { up = up, dn = dn }
    end

    -- Column heads: 12 px in the brighter gold (labels stay 11 px grey), a
    -- 1 px hairline in the dark line colour underneath. No bar, no strip —
    -- the gold edge means "selected" in the list. The connections head
    -- carries a right-aligned "discovered / total" counter.
    band.heads, band.hairs = {}, {}
    for i = 1, 3 do
        local h = band:CreateFontString(nil, "OVERLAY")
        h:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
        h:SetJustifyH("LEFT")
        h:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        band.heads[i] = h
        local hr = band:CreateTexture(nil, "ARTWORK")
        hr:SetColorTexture(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 1)
        hr:SetHeight(1)
        band.hairs[i] = hr
    end
    band.count = band:CreateFontString(nil, "OVERLAY")
    band.count:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
    band.count:SetJustifyH("RIGHT")
    band.count:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

    -- Value row (DOSSIER / RECORD): 64 px label + 13 px value. The row
    -- itself is the click/hover area, so link values navigate and every
    -- truncated value shows the full text in a tooltip.
    local function MakeKV(parent)
        local b = CreateFrame("Button", nil, parent or band)
        b:SetHeight(band.ROW_H)
        b.lab = b:CreateFontString(nil, "OVERLAY")
        b.lab:SetFont(IMAGO.FONT_BODY, 11)
        b.lab:SetJustifyH("LEFT")
        b.lab:SetJustifyV("TOP")
        b.lab:SetWordWrap(false)
        b.lab:SetPoint("TOPLEFT", b, "TOPLEFT", 0, -5)
        b.lab:SetWidth(band.LAB_W)
        b.lab:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        b.val = b:CreateFontString(nil, "OVERLAY")
        b.val:SetFont(IMAGO.FONT_BODY, 13)
        b.val:SetJustifyH("LEFT")
        b.val:SetJustifyV("TOP")
        b.val:SetWordWrap(false)
        -- top-aligned with the label (label 11 px sits 2 px lower so the
        -- baselines of label and value line up)
        b.val:SetPoint("TOPLEFT", b.lab, "TOPRIGHT", 0, 2)
        b:SetScript("OnEnter", function(self)
            if self._gold then
                self.val:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            end
            IMAGO.ShowTooltipIfTruncated(self, self.val, self._plain)
        end)
        b:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            if self._gold then
                self.val:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            end
        end)
        b:SetScript("OnClick", function(self)
            if self._nav then OnFactLink(self, self._nav, self._plain or "", "LeftButton") end
        end)
        return b
    end

    -- Connection row: 50 px type tag + name (+ lock icon when
    -- undiscovered). Rows are buttons like the kv rows; hover shows a
    -- soft row fill plus a brighter name on discovered entries.
    local function MakeCX(parent)
        local b = CreateFrame("Button", nil, parent or band)
        b:SetHeight(band.ROW_H)
        b.hl = b:CreateTexture(nil, "HIGHLIGHT")
        b.hl:SetAllPoints()
        b.hl:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.07)
        b.tag = b:CreateFontString(nil, "OVERLAY")
        b.tag:SetFont(IMAGO.FONT_BODY, 11)
        b.tag:SetJustifyH("LEFT")
        b.tag:SetPoint("LEFT", b, "LEFT", 0, 0)
        b.tag:SetWidth(band.TAG_W)
        b.tag:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        b.name = b:CreateFontString(nil, "OVERLAY")
        b.name:SetFont(IMAGO.FONT_BODY, 13)
        b.name:SetJustifyH("LEFT")
        b.name:SetWordWrap(false)
        b.name:SetPoint("LEFT", b, "LEFT", band.TAG_W + 4, 0)
        b.icon = b:CreateTexture(nil, "ARTWORK")
        b.icon:SetSize(12, 12)
        b.icon:SetPoint("RIGHT", b, "RIGHT", -2, 0)
        b:SetScript("OnEnter", function(self)
            if self._gold then
                self.name:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            end
            if self._moreList then
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:AddLine(IMAGO.L["FACT_MORE"] or "Also mentioned", IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                for _, it in ipairs(self._moreList) do
                    GameTooltip:AddLine(it.plain, 1, 1, 1)
                end
                GameTooltip:Show()
            else
                IMAGO.ShowTooltipIfTruncated(self, self.name, self._plain)
            end
        end)
        b:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            if self._gold then
                self.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            end
        end)
        b:SetScript("OnClick", function(self)
            if self._nav then
                OnFactLink(self, self._nav, self._plain or "", "LeftButton")
            elseif self._moreList then
                IMAGO.Chronicle.ShowConnPopup(self._moreList, self)
            end
        end)
        return b
    end

    band.kv, band.rk, band.cx = {}, {}, {}
    band.MakeKV, band.MakeCX = MakeKV, MakeCX
    band.more = MakeCX()
    band.empty = band:CreateFontString(nil, "OVERLAY")
    band.empty:SetFont(IMAGO.FONT_BODY, 12)
    band.empty:SetJustifyH("LEFT")
    band.empty:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

    -- RECORD action buttons: equal columns, always in one row, text only
    -- (the available icons aren't a uniform set). Shared by the footer band
    -- and the zone side panel.
    local function MakeActRow(parent, defs)
        local row = {}
        for i, a in ipairs(defs) do
            local b = CreateFrame("Button", nil, parent, "BackdropTemplate")
            b:SetHeight(24)
            ChromeButton(b, ACT_FACE, 12)
            b.lab = b:CreateFontString(nil, "OVERLAY")
            b.lab:SetFont(IMAGO.FONT_BODY, 12, "")
            b.lab:SetWordWrap(false)
            b.lab:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            b.dot = b:CreateTexture(nil, "ARTWORK")
            b.dot:SetSize(5, 5)
            b.dot:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            b.dot:Hide()
            b._act = a
            b:SetScript("OnEnter", function(self)
                self:ChromeHover()
                self.lab:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
                if self._note then
                    GameTooltip:SetOwner(self, "ANCHOR_TOP")
                    local pv = self._note:sub(1, 120)
                    if #self._note > 120 then pv = pv .. "…" end
                    GameTooltip:AddLine(pv, 1, 1, 1)
                    GameTooltip:Show()
                elseif self._act.tip and IMAGO.L[self._act.tip] then
                    GameTooltip:SetOwner(self, "ANCHOR_TOP")
                    GameTooltip:AddLine(IMAGO.L[self._act.tip], 1, 1, 1)
                    GameTooltip:Show()
                end
            end)
            b:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                self:ChromeRest(false)
                self.lab:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            end)
            b:SetScript("OnClick", function(self)
                if self._slug then self._act.onClick(self._slug) end
            end)
            row[i] = b
        end
        return row
    end

    band.acts = MakeActRow(band, {
        { key = "share", label = "FACT_SHARE",
          onClick = function(slug)
              if IMAGO.Social and IMAGO.Social.ShareNPC then IMAGO.Social.ShareNPC(slug) end
          end },
        { key = "loc", label = "FACT_SHARE_LOC",
          onClick = function(slug)
              if IMAGO.Social and IMAGO.Social.ShareLocation then IMAGO.Social.ShareLocation(slug) end
          end },
        { key = "notes", label = "FACT_NOTES",
          onClick = function(slug) IMAGO.Chronicle.OpenNotePopup(slug) end },
    })
    band:Hide()
    f.factsBand = band

    -- ==========================================
    -- ZONE SIDE PANEL: the footer's three blocks (DOSSIER, CONNECTIONS,
    -- RECORD) stacked in a column right of the zone text. Rows, heads and
    -- buttons are the band's own builders; the layout is vertical and is
    -- done in IMAGO.Chronicle.SetZoneSide.
    -- ==========================================
    local side = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    side:SetWidth(ZONE_SIDE_W)
    side:SetFrameLevel(f.detailFrame:GetFrameLevel() + 3)
    side:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    side:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.5)
    side:Hide()
    side.PAD = 12
    side.heads, side.hairs = {}, {}
    for i = 1, 3 do
        local h = side:CreateFontString(nil, "OVERLAY")
        h:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
        h:SetJustifyH("LEFT")
        h:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        side.heads[i] = h
        local hr = side:CreateTexture(nil, "ARTWORK")
        hr:SetColorTexture(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 1)
        hr:SetHeight(1)
        side.hairs[i] = hr
    end
    side.count = side:CreateFontString(nil, "OVERLAY")
    side.count:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
    side.count:SetJustifyH("RIGHT")
    side.count:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
    side.kv, side.rk, side.cx = {}, {}, {}
    side.MakeKV = function() return MakeKV(side) end
    side.MakeCX = function() return MakeCX(side) end
    side.more = MakeCX(side)
    side.empty = side:CreateFontString(nil, "OVERLAY")
    side.empty:SetFont(IMAGO.FONT_BODY, 12)
    side.empty:SetJustifyH("LEFT")
    side.empty:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    side.acts = MakeActRow(side, {
        { key = "share", label = "FACT_SHARE",
          onClick = function(slug)
              if IMAGO.Social and IMAGO.Social.ShareZone then IMAGO.Social.ShareZone(slug) end
          end },
        { key = "notes", label = "FACT_NOTES",
          onClick = function(slug) IMAGO.Chronicle.OpenNotePopup(slug) end },
    })
    f.zoneSide = side

    -- infoContent hosts the lore-text hyperlinks
    f.infoContent:SetScript("OnHyperlinkClick", OnFactLink)

    -- Personal note popup: per-fate free text in IMAGOSaved.notes.
    -- Movable dialog. The input is a stock multiline EditBox used as the
    -- scroll child of a ScrollFrame (no fixed height, width synced to the
    -- viewport, caret follow in OnCursorChanged). Saves while typing and on
    -- close; Esc closes only this popup, never the Chronicle window.
    do
        local G, M, P = IMAGO_COLORS.GOLD, IMAGO_COLORS.TEXT_MUTED, IMAGO_COLORS.TEXT_PRIMARY
        local npop = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
        npop.maxLetters = 1000
        npop:SetSize(440, 320)
        npop:SetFrameStrata("DIALOG")
        npop:SetMovable(true)
        npop:SetClampedToScreen(true)
        npop:EnableMouse(true)
        npop:EnableKeyboard(true)
        npop:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        npop:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 1.0)
        npop:SetBackdropBorderColor(G[1], G[2], G[3], 0.7)

        -- position: offset from the detail pane, remembered for the session
        function npop.Place()
            npop:ClearAllPoints()
            npop:SetPoint("CENTER", f.detailFrame, "CENTER", npop._dx or 0, npop._dy or 20)
        end
        local function stopDrag()
            npop:StopMovingOrSizing()
            local nx, ny = npop:GetCenter()
            local px, py = f.detailFrame:GetCenter()
            if nx and px then npop._dx, npop._dy = nx - px, ny - py end
            npop.Place()
        end
        npop:RegisterForDrag("LeftButton")
        npop:SetScript("OnDragStart", npop.StartMoving)
        npop:SetScript("OnDragStop", stopDrag)

        -- header strip is a drag handle too (child frames swallow drags)
        local hdr = CreateFrame("Frame", nil, npop)
        hdr:SetPoint("TOPLEFT", npop, "TOPLEFT", 0, 0)
        hdr:SetPoint("TOPRIGHT", npop, "TOPRIGHT", -34, 0)
        hdr:SetHeight(56)
        hdr:EnableMouse(true)
        hdr:RegisterForDrag("LeftButton")
        hdr:SetScript("OnDragStart", function() npop:StartMoving() end)
        hdr:SetScript("OnDragStop", stopDrag)

        npop.kicker = npop:CreateFontString(nil, "OVERLAY")
        npop.kicker:SetFont(IMAGO.FONT_BODY, 10, "")
        npop.kicker:SetPoint("TOPLEFT", npop, "TOPLEFT", 18, -14)
        npop.kicker:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        npop.title = npop:CreateFontString(nil, "OVERLAY")
        npop.title:SetFont(IMAGO.FONT_TITLE, 15)
        npop.title:SetPoint("TOPLEFT", npop, "TOPLEFT", 18, -27)
        npop.title:SetWidth(380)
        npop.title:SetJustifyH("LEFT")
        npop.title:SetWordWrap(false)
        npop.title:SetTextColor(G[1], G[2], G[3])
        npop.rule = npop:CreateTexture(nil, "ARTWORK")
        npop.rule:SetColorTexture(G[1], G[2], G[3], 0.35)
        npop.rule:SetPoint("TOPLEFT", npop, "TOPLEFT", 18, -53)
        npop.rule:SetPoint("TOPRIGHT", npop, "TOPRIGHT", -18, -53)
        npop.rule:SetHeight(1)

        npop.close = CreateFrame("Button", nil, npop, "BackdropTemplate")
        npop.close:SetSize(16, 16)
        npop.close:SetPoint("TOPRIGHT", npop, "TOPRIGHT", -12, -12)
        npop.close:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        npop.close:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
        npop.close:SetBackdropBorderColor(G[1], G[2], G[3], 0.35)
        npop.close.label = npop.close:CreateFontString(nil, "OVERLAY")
        npop.close.label:SetFont(IMAGO.FONT_BODY, 11, "")
        npop.close.label:SetPoint("CENTER", npop.close, "CENTER", 0, 0)
        npop.close.label:SetText("X")
        npop.close.label:SetTextColor(G[1], G[2], G[3])
        npop.close:SetScript("OnClick", function() npop:Hide() end)
        npop.close:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(G[1], G[2], G[3], 0.9) end)
        npop.close:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(G[1], G[2], G[3], 0.35) end)

        npop.hint = npop:CreateFontString(nil, "OVERLAY")
        npop.hint:SetFont(IMAGO.FONT_BODY, 11, "")
        npop.hint:SetPoint("BOTTOMLEFT", npop, "BOTTOMLEFT", 18, 16)
        npop.hint:SetTextColor(M[1], M[2], M[3], 0.75)
        npop.hint:SetText(IMAGO.L["FACT_NOTES_HINT"] or "Saved automatically")
        npop.count = npop:CreateFontString(nil, "OVERLAY")
        npop.count:SetFont(IMAGO.FONT_BODY, 10, "")
        npop.count:SetPoint("BOTTOMRIGHT", npop, "BOTTOMRIGHT", -18, 16)
        npop.count:SetTextColor(M[1], M[2], M[3], 0.7)

        -- input well (408 x 215): dark field, border lights up on focus
        local box = CreateFrame("Frame", nil, npop, "BackdropTemplate")
        box:SetPoint("TOPLEFT", npop, "TOPLEFT", 16, -63)
        box:SetPoint("BOTTOMRIGHT", npop, "BOTTOMRIGHT", -16, 42)
        box:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        box:SetBackdropColor(0, 0, 0, 0.35)
        box:SetBackdropBorderColor(G[1], G[2], G[3], 0.22)

        -- viewport (392 x 199); the themed scrollbar sits inside its right edge
        local sf = CreateFrame("ScrollFrame", "IMAGOChronicleNoteScroll", box, "UIPanelScrollFrameTemplate")
        sf:SetPoint("TOPLEFT", box, "TOPLEFT", 8, -8)
        sf:SetPoint("BOTTOMRIGHT", box, "BOTTOMRIGHT", -8, 8)
        IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleNoteScrollScrollBar", sf, IMAGO_COLORS.GOLD)
        npop.scroll = sf

        local eb = CreateFrame("EditBox", nil, sf)
        eb:SetAllPoints()
        eb:SetMultiLine(true)
        eb:EnableMouse(true)
        eb:SetAutoFocus(false)
        eb:SetCountInvisibleLetters(false)
        eb:SetMaxLetters(npop.maxLetters)
        eb:SetFont(IMAGO.FONT_BODY, 13, "")
        eb:SetTextColor(P[1], P[2], P[3])
        sf:SetScrollChild(eb)
        eb:SetWidth(380)
        npop.edit = eb

        -- keep the wrap width equal to the viewport (minus scrollbar room)
        sf:SetScript("OnSizeChanged", function(_, w)
            if w and w > 40 then eb:SetWidth(w - 12) end
        end)
        -- click on the empty part of the field: focus, caret to the end
        sf:EnableMouse(true)
        sf:SetScript("OnMouseUp", function()
            eb:SetFocus()
            eb:SetCursorPosition(eb:GetNumLetters())
        end)
        -- only the visible slice of the (taller) editbox takes clicks
        local function hitRect(self, off)
            eb:SetHitRectInsets(0, 0, off, math.max(0, eb:GetHeight() - off - self:GetHeight()))
        end
        sf:HookScript("OnVerticalScroll", hitRect)
        sf:HookScript("OnScrollRangeChanged", function(self, _, yr)
            if yr == 0 then eb:SetHitRectInsets(0, 0, 0, 0) else hitRect(self, self:GetVerticalScroll()) end
        end)

        -- keep the caret inside the viewport while typing or navigating
        eb:SetScript("OnCursorChanged", function(_, _, y, _, h)
            local off = sf:GetVerticalScroll()
            y = -y
            if y < off then
                sf:SetVerticalScroll(y)
            else
                y = y + h - sf:GetHeight()
                if y > off then sf:SetVerticalScroll(y) end
            end
        end)

        function npop.UpdateCount()
            local n, full = eb:GetNumLetters(), eb:GetNumLetters() >= npop.maxLetters
            local c = full and G or M
            npop.count:SetText(n .. " / " .. npop.maxLetters)
            npop.count:SetTextColor(c[1], c[2], c[3], full and 1 or 0.7)
        end

        -- store the text for the current fate; refresh the record button dot
        function npop.Save()
            local slug = npop._slug
            if not slug then return end
            local t = (eb:GetText() or ""):gsub("^%s+", ""):gsub("%s+$", "")
            IMAGOSaved.notes = IMAGOSaved.notes or {}
            IMAGOSaved.notes[slug] = (t ~= "") and t or nil
            -- the Notes button of whichever panel is showing this entry
            local btns = {
                f.factsBand and f.factsBand.acts and f.factsBand.acts[3],
                f.zoneSide and f.zoneSide.acts and f.zoneSide.acts[1],
            }
            for i = 1, 2 do
                local b = btns[i]
                if b and b._slug == slug then
                    b._note = (t ~= "") and t or nil
                    if b._note then
                        b.dot:ClearAllPoints()
                        b.dot:SetPoint("LEFT", b.lab, "RIGHT", 4, 0)
                        b.dot:Show()
                    else
                        b.dot:Hide()
                    end
                end
            end
        end

        -- called one frame after opening, once the scroll range is known
        function npop.ScrollToEnd()
            if not npop:IsShown() then return end
            IMAGO.UpdateScrollBarVisibility(sf)
            sf:SetVerticalScroll(sf:GetVerticalScrollRange() or 0)
        end

        eb:SetScript("OnTextChanged", function(_, userInput)
            npop.UpdateCount()
            if userInput then npop.Save() end
        end)
        eb:SetScript("OnEditFocusGained", function() box:SetBackdropBorderColor(G[1], G[2], G[3], 0.55) end)
        eb:SetScript("OnEditFocusLost", function(self)
            self:HighlightText(0, 0)
            box:SetBackdropBorderColor(G[1], G[2], G[3], 0.22)
        end)
        -- Esc with the field focused: the editbox consumes the key
        eb:SetScript("OnEscapePressed", function() npop:Hide() end)
        -- Esc without focus: swallow it here so it never reaches the
        -- Chronicle window (UISpecialFrames) or the game menu
        npop:SetScript("OnKeyDown", function(self, key)
            if key == "ESCAPE" then
                self:SetPropagateKeyboardInput(false)
                self:Hide()
            else
                self:SetPropagateKeyboardInput(true)
            end
        end)
        npop:SetScript("OnHide", function()
            npop.Save()
            npop._slug = nil
            eb:ClearFocus()
        end)
        f:HookScript("OnHide", function()
            if npop:IsShown() then npop.Save() npop:Hide() end
        end)

        npop.UpdateCount()
        npop:Hide()
        f.notePopup = npop
    end

    -- ==========================================
    -- MODE TOGGLE BUTTON + DROPDOWN
    -- ==========================================
    f.modeBtn = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.modeBtn:SetSize(64, 18)
    -- Header row: settings gear | back | mode — same top line at -12
    f.modeBtn:SetPoint("TOPLEFT", f, "TOPLEFT", 102, -12)
    f.modeBtn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8, insets = {left=2,right=2,top=2,bottom=2} })
    f.modeBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
    f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

    f.modeBtn.label = f.modeBtn:CreateFontString(nil, "OVERLAY")
    f.modeBtn.label:SetFont(IMAGO.FONT_BODY, 11, "")
    f.modeBtn.label:SetPoint("CENTER", f.modeBtn, "CENTER", -3, 0)
    f.modeBtn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

    -- Gold chevron = dropdown hint (same as filter button)
    f.modeBtn.chevron = f.modeBtn:CreateFontString(nil, "OVERLAY")
    f.modeBtn.chevron:SetFont(IMAGO.FONT_BODY, 10, "")
    f.modeBtn.chevron:SetPoint("RIGHT", f.modeBtn, "RIGHT", -5, -1)
    f.modeBtn.chevron:SetText(">")
    f.modeBtn.chevron:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])

    local function UpdateModeBtn()
        f.modeBtn.label:SetText(IMAGO.L["MODE_LABEL"])
    end

     -- ==========================================
    -- DETAIL ACTION ICON (top-right, clickable texture)
    -- ==========================================
    f.detailActionBtn = CreateFrame("Button", nil, f.detailFrame)
    f.detailActionBtn:SetSize(22, 22)
    f.detailActionBtn:SetPoint("TOPRIGHT", f.detailFrame, "TOPRIGHT", -14, -14)
    f.detailActionBtn:SetFrameLevel(f.detailFrame:GetFrameLevel() + 2)

    f.detailActionBtn.icon = f.detailActionBtn:CreateTexture(nil, "ARTWORK")
    f.detailActionBtn.icon:SetAllPoints()
    f.detailActionBtn.icon:SetAlpha(0.7)

    local hl = f.detailActionBtn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetColorTexture(1, 1, 1, 0.15)

    f.detailActionBtn:SetScript("OnEnter", function(self)
        self.icon:SetAlpha(1.0)
        if self._tooltip then
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
            GameTooltip:AddLine(self._tooltip, IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            GameTooltip:Show()
        end
    end)
    f.detailActionBtn:SetScript("OnLeave", function(self)
        self.icon:SetAlpha(0.7)
        GameTooltip:Hide()
    end)
    f.detailActionBtn:Hide()

    function IMAGO.Chronicle.SetDetailAction(config)
        local btn = IMAGO.Chronicle.frame and IMAGO.Chronicle.frame.detailActionBtn
        if not btn then return end
        if not config then
            btn:Hide()
            btn:SetScript("OnClick", nil)
            btn._tooltip = nil
            return
        end
        btn._tooltip = config.tooltip
        if config.atlas then
            btn.icon:SetAtlas(config.atlas, true)
        elseif config.texture then
            btn.icon:SetTexture(config.texture)
            btn.icon:SetTexCoord(0, 1, 0, 1)
        end
        btn:SetSize(22, 22)
        if not btn.border then
            btn.border = btn:CreateTexture(nil, "OVERLAY")
            btn.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
            btn.border:SetSize(58, 58)
            btn.border:SetPoint("TOPLEFT", -7, 7)
        end
        btn.border:Show()
        btn:SetScript("OnClick", config.onClick)
        btn:Show()
    end
    -- ==========================================
    -- CONFIRM DIALOG (reusable)
    -- ==========================================
    f.confirmDialog = CreateFrame("Frame", nil, f, "BackdropTemplate")
    f.confirmDialog:SetSize(320, 130)
    f.confirmDialog:SetPoint("CENTER", f.detailFrame, "CENTER", 0, 20)
    f.confirmDialog:SetFrameStrata("FULLSCREEN_DIALOG")
    f.confirmDialog:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 14, insets = {left=4,right=4,top=4,bottom=4} })
    f.confirmDialog:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 1.0)
    f.confirmDialog:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
    f.confirmDialog:Hide()

    f.confirmDialog.title = f.confirmDialog:CreateFontString(nil, "OVERLAY")
    f.confirmDialog.title:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
    f.confirmDialog.title:SetPoint("TOP", f.confirmDialog, "TOP", 0, -14)
    f.confirmDialog.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

    f.confirmDialog.line = f.confirmDialog:CreateTexture(nil, "ARTWORK")
    f.confirmDialog.line:SetSize(280, 1)
    f.confirmDialog.line:SetPoint("TOP", f.confirmDialog.title, "BOTTOM", 0, -6)
    f.confirmDialog.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.confirmDialog.line:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4)

    f.confirmDialog.desc = f.confirmDialog:CreateFontString(nil, "OVERLAY")
    f.confirmDialog.desc:SetFont(IMAGO.FONT_BODY, 11)
    f.confirmDialog.desc:SetPoint("TOP", f.confirmDialog.line, "BOTTOM", 0, -8)
    f.confirmDialog.desc:SetWidth(290)
    f.confirmDialog.desc:SetJustifyH("CENTER")
    f.confirmDialog.desc:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
    f.confirmDialog.desc:SetSpacing(3)

    local function MakeConfirmBtn(label, xOff, color)
        local btn = CreateFrame("Button", nil, f.confirmDialog, "BackdropTemplate")
        btn:SetSize(90, 24)
        btn:SetPoint("BOTTOM", f.confirmDialog, "BOTTOM", xOff, 10)
        btn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 10, insets = {left=3,right=3,top=3,bottom=3} })
        btn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.9)
        btn:SetBackdropBorderColor(color[1], color[2], color[3], 0.7)
        btn.lbl = btn:CreateFontString(nil, "OVERLAY")
        btn.lbl:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
        btn.lbl:SetPoint("CENTER")
        btn.lbl:SetText(label)
        btn.lbl:SetTextColor(color[1], color[2], color[3])
        btn:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(color[1], color[2], color[3], 1) end)
        btn:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(color[1], color[2], color[3], 0.7) end)
        return btn
    end

    f.confirmDialog.yesBtn = MakeConfirmBtn(IMAGO.L["CONFIRM_YES"], -52, {0.2, 0.9, 0.3})
    f.confirmDialog.noBtn  = MakeConfirmBtn(IMAGO.L["CONFIRM_NO"],   52, {0.9, 0.3, 0.2})

    f.confirmDialog.noBtn:SetScript("OnClick", function()
        f.confirmDialog:Hide()
    end)

    f.ShowConfirm = function(title, desc, onYes)
        f.confirmDialog.title:SetText(title)
        f.confirmDialog.desc:SetText(desc)
        f.confirmDialog.yesBtn:SetScript("OnClick", function()
            f.confirmDialog:Hide()
            onYes()
        end)
        if f.modeDropdown:IsShown() then f.modeDropdown:Hide() end
        f.confirmDialog:Show()
    end

    -- Dropdown Frame
    f.modeDropdown = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
    f.modeDropdown:SetSize(160, 54)
    f.modeDropdown:SetFrameStrata("DIALOG")
    f.modeDropdown:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 10, insets = {left=3,right=3,top=3,bottom=3} })
    f.modeDropdown:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 1.0)
    f.modeDropdown:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.8)
    f.modeDropdown:Hide()

    local function CreateDropdownEntry(parent, text, yOffset, modeValue)
        local btn = CreateFrame("Button", nil, parent)
        btn:SetSize(150, 22)
        btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, yOffset)

        btn.check = btn:CreateTexture(nil, "ARTWORK")
        btn.check:SetSize(7, 7)
        btn.check:SetPoint("LEFT", btn, "LEFT", 6, 0)
        btn.check:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        btn.check:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 1)
        btn.check:Hide()

        btn.text = btn:CreateFontString(nil, "OVERLAY")
        btn.text:SetFont(IMAGO.FONT_BODY, 11)
        btn.text:SetPoint("LEFT", btn, "LEFT", 18, 0)
        btn.text:SetText(text)

        btn.modeValue = modeValue
        btn:SetScript("OnEnter", function(self)
            self.text:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        end)
        btn:SetScript("OnLeave", function(self)
            self.text:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
        end)
        return btn
    end

    f.modeDropdown.entryExplorer = CreateDropdownEntry(f.modeDropdown, IMAGO.L["MODE_EXPLORER"], -5, false)
    f.modeDropdown.entryEncyclopedia = CreateDropdownEntry(f.modeDropdown, IMAGO.L["MODE_ENCYCLOPEDIA"], -27, true)

    -- Explorer: switch immediately
    f.modeDropdown.entryExplorer:SetScript("OnClick", function()
        IMAGOSaved.encyclopediaMode = false
        f.modeDropdown:Hide()
        IMAGO.Chronicle.UpdateList()
    end)

    -- Encyclopedia: confirmation first
    f.modeDropdown.entryEncyclopedia:SetScript("OnClick", function()
        if IMAGOSaved.encyclopediaMode then
            f.modeDropdown:Hide()
            return
        end
        f.ShowConfirm(
            IMAGO.L["CONFIRM_ENC_TITLE"],
            IMAGO.L["CONFIRM_ENC_DESC"],
            function()
                IMAGOSaved.encyclopediaMode = true
                IMAGO.Chronicle.UpdateList()
            end
        )
    end)

    local function UpdateDropdownChecks()
        local isEnc = IMAGOSaved and IMAGOSaved.encyclopediaMode
        f.modeDropdown.entryExplorer.check:SetShown(not isEnc)
        f.modeDropdown.entryExplorer.text:SetTextColor(isEnc and IMAGO_COLORS.TEXT_MUTED[1] or IMAGO_COLORS.GOLD[1], isEnc and IMAGO_COLORS.TEXT_MUTED[2] or IMAGO_COLORS.GOLD[2], isEnc and IMAGO_COLORS.TEXT_MUTED[3] or IMAGO_COLORS.GOLD[3])
        f.modeDropdown.entryEncyclopedia.check:SetShown(isEnc)
        f.modeDropdown.entryEncyclopedia.text:SetTextColor(isEnc and IMAGO_COLORS.GOLD[1] or IMAGO_COLORS.TEXT_MUTED[1], isEnc and IMAGO_COLORS.GOLD[2] or IMAGO_COLORS.TEXT_MUTED[2], isEnc and IMAGO_COLORS.GOLD[3] or IMAGO_COLORS.TEXT_MUTED[3])
    end

    f.modeBtn:SetScript("OnClick", function()
        if f.modeDropdown:IsShown() then
            f.modeDropdown:Hide()
        else
            f.modeDropdown:ClearAllPoints()
            f.modeDropdown:SetPoint("TOPLEFT", f.modeBtn, "BOTTOMLEFT", 0, -2)
            UpdateDropdownChecks()
            f.modeDropdown:Show()
        end
    end)
    f.modeBtn:SetScript("OnEnter", function()
        f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.7)
        f.modeBtn.label:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end)
    f.modeBtn:SetScript("OnLeave", function()
        f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
        f.modeBtn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    end)

    -- Back button: top bar, right of the settings gear — same slim
    -- style as the header search bar and filter button
    f.backBtn = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.backBtn:SetSize(58, 18)
    -- Top edge -12 = same line as settings gear, search & filter
    f.backBtn:SetPoint("TOPLEFT", f, "TOPLEFT", 36, -12)
    f.backBtn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8, insets = {left=2,right=2,top=2,bottom=2} })
    f.backBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.5)
    f.backBtn:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.35)

    f.backBtn.label = f.backBtn:CreateFontString(nil, "OVERLAY")
    f.backBtn.label:SetFont(IMAGO.FONT_BODY, 11, "")
    f.backBtn.label:SetPoint("CENTER", f.backBtn, "CENTER", 0, 0)
    f.backBtn.label:SetText("< " .. (IMAGO.L and IMAGO.L["BACK"] or "Back"))
    f.backBtn.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    f.backBtn.enabled = false

    f.backBtn:SetScript("OnEnter", function(self)
        if self.enabled then
            self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.7)
        end
    end)
    f.backBtn:SetScript("OnLeave", function(self)
        if self.enabled then
            self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
        else
            self:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.35)
        end
    end)
    f.backBtn:SetScript("OnClick", function(self)
        if not self.enabled then return end
        local prev = table.remove(navStack)
        if not prev then return end

        isNavigatingBack = true
        if prev.type == "npc" then
            IMAGO.Chronicle.OpenToNPCSlug(prev.slug, { skipDiscoveryCinematic = true })
        elseif prev.type == "zone" then
            IMAGO.Chronicle.OpenToZoneMapID(prev.mapID)
        elseif prev.type == "race" then
            IMAGO.Chronicle.OpenToRace(prev.slug)
        elseif prev.type == "class" then
            IMAGO.Chronicle.OpenToClass(prev.slug)
        elseif prev.type == "codex" then
            IMAGO.Chronicle.OpenToCodex(prev.slug)
        elseif prev.type == "timeline" then
            IMAGO.Chronicle.OpenToTimeline(prev.slug)
        end
        C_Timer.After(0, function()
            isNavigatingBack = false
        end)

        if #navStack == 0 then
            self.enabled = false
            self:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.35)
            self.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        end
    end)

    IMAGO.Chronicle.SetBackEnabled = function(val)
        local btn = IMAGO.Chronicle.frame and IMAGO.Chronicle.frame.backBtn
        if not btn then return end
        btn.enabled = val
        if val then
            btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
            btn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        else
            btn:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.35)
            btn.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        end
    end

    -- Close dropdown on outside click
    f:HookScript("OnMouseDown", function()
        if f.modeDropdown:IsShown() then f.modeDropdown:Hide() end
    end)

    f.UpdateModeBtn = UpdateModeBtn

    -- ==-- ==========================================
    -- NEW: MAIN TABS (BOTTOM TABS) LOCALIZED
    -- ==========================================
    f.numTabs = 9
    f.mainTabs = {}
    local tabNames = {IMAGO.L["TAB_HOME"], IMAGO.L["TAB_FATES"], IMAGO.L["TAB_ZONES"], IMAGO.L["TAB_RACES"], IMAGO.L["TAB_CLASSES"], IMAGO.L["TAB_TIMELINE"], IMAGO.L["TAB_CODEX"], IMAGO.L["TAB_ACHIEVEMENTS"], IMAGO.L["TAB_CREDITS"]}
    for i = 1, f.numTabs do
        -- Fallback so a missing/mistimed locale string can never break tab creation
        local name = tabNames[i] or ("Tab " .. i)
        local tab = CreateFrame("Button", f:GetName().."Tab"..i, f, "PanelTabButtonTemplate")
        tab:SetText(name)
        PanelTemplates_TabResize(tab, 0)
        if i == 1 then
            tab:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 15, 2)
        else
            tab:SetPoint("LEFT", _G[f:GetName().."Tab"..(i-1)], "RIGHT", 0, 0)
        end
        tab:SetScript("OnClick", function()
            IMAGO.Chronicle.SelectMainTab(i)
            if SOUNDKIT and SOUNDKIT.IG_CHARACTER_INFO_TAB then PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB) end
        end)
        f.mainTabs[i] = tab
    end

    if IMAGO.ApplyThemeSurfaces then IMAGO.ApplyThemeSurfaces() end

    -- ==========================================
    -- NEW: TAB SWITCHING LOGIC (LOCALIZED)
    -- ==========================================
    function IMAGO.Chronicle.SelectMainTab(index)
        -- OpenTo* sets this before a targeted jump; consume it on every switch
        local skipAutoSelect = f._skipAutoSelect
        f._skipAutoSelect = nil
        PanelTemplates_SetTab(f, index)
        f.activeTabIndex = index
        if IMAGO.ApplyThemeSurfaces then IMAGO.ApplyThemeSurfaces() end
        f.activeFilter = "ALL"
        -- Clear a stale search term when switching tabs
        if f.searchBox and (f.searchBox:GetText() or "") ~= "" then
            f.searchBox:SetText("")
        end
        if f.filterBtn then
            f.filterBtn:SetText(IMAGO.L["FILTER_LABEL"] or "Filter")
            f.activeFilter = nil
        end
        
        -- RESET: Safely hide everything on the right side
        if f.detailTitle then f.detailTitle:Hide() end
        if f.detailLineLeft then f.detailLineLeft:Hide() end
        if f.detailLineRight then f.detailLineRight:Hide() end
        if f.tabLore then f.tabLore:Hide() end
        if f.tabTime then f.tabTime:Hide() end
        if f.infoScroll then f.infoScroll:Hide() end
        if f.detailModel then f.detailModel:Hide() end
        if f.detailModel2 then f.detailModel2:Hide() end
        if f.factionIcon then f.factionIcon:Hide() end
        if f.hintPage then f.hintPage:Hide() end
        if f.startPage then f.startPage:Hide() end
        if f.achievementsPage then f.achievementsPage:Hide() end
        if f.homePage then f.homePage:Hide() end
        if f.detailImage then f.detailImage:Hide() end

        if f.detailImageBorder then f.detailImageBorder:Hide() end -- NEW: hide the border
        if f.detailSeparator then f.detailSeparator:Hide() end

        if f.detailImage then f.detailImage:Hide() end

        if f.detailImageBorder then f.detailImageBorder:Hide() end
        if f.detailSeparator then f.detailSeparator:Hide() end
        if f.creditsPage then f.creditsPage:Hide() end
        if f.creditsHeader then f.creditsHeader:Hide() end
        if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
        if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
        if f.raceContainer then f.raceContainer:Hide() end
        if f.classContainer then f.classContainer:Hide() end
        if f.raceEmblemBox then f.raceEmblemBox:Hide() end
        if f.raceZoneImage then f.raceZoneImage:Hide() end
        if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end
        if f.classIcon then f.classIcon:Hide() end
        if f.classEmblemBox then f.classEmblemBox:Hide() end
        if f.codexListPanel then f.codexListPanel:Hide() end
        if f.codexContent then f.codexContent:Hide() end
        if f.codexCatHeading then f.codexCatHeading:Hide() end
        if f.timelineListPanel then f.timelineListPanel:Hide() end
        if f.timelineContent then f.timelineContent:Hide() end
        if f.timelineChronoHeading then f.timelineChronoHeading:Hide() end
        IMAGO.Chronicle.SetDetailAction(nil)
        if f.filterMenu         then f.filterMenu:Hide()         end
        if f.modeDropdown       then f.modeDropdown:Hide()       end

        -- Timeline/Codex/Credits have no facts band/modeBtn — hidden until a
        -- Fates/Zones/Races/Classes entry fills the band
        if f.factsBand then f.factsBand:Hide() end
        IMAGO.Chronicle.HideZoneDetail()
        if f.stageFrame then f.stageFrame:Hide() end
        if f.notePopup then f.notePopup:Hide() end
        if f.modeBtn then f.modeBtn:SetShown(index >= 2 and index <= 5) end

        -- Global header search: visible on all content tabs, per-tab hint
        local searchHintKeys = {
            "SEARCH_IN_FATES", "SEARCH_IN_ZONES", "SEARCH_IN_RACES",
            "SEARCH_IN_CLASSES", "SEARCH_IN_TIMELINE", "SEARCH_IN_CODEX"
        }
        local hintKey = searchHintKeys[index - 1]
        if f.searchBox.Instructions then
            f.searchBox.Instructions:SetText((hintKey and IMAGO.L[hintKey]) or "Search...")
        end
        f.searchBox:SetShown(hintKey ~= nil)
        f.filterBtn:SetShown(index == 2 or index == 4)

        -- Sidebar list starts below the header strip (every list tab has one)
        if f.scrollFrame then
            f.scrollFrame:ClearAllPoints()
            f.scrollFrame:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_LIST_TOP)
            f.scrollFrame:SetPoint("BOTTOMRIGHT", f.sidebar, "BOTTOMRIGHT", 0, 0)
        end

        if index == 1 then
            -- Home tab: full-width landing page
            f.searchBox:Hide()
            f.filterBtn:Hide()
            f.sidebar:Hide()
            f.detailFrame:Hide()
            IMAGO.Chronicle.ShowHome()
        elseif index >= 2 and index <= 5 then
            -- Fates/Zones/Races/Classes: flat list (no expansion picker)
            -- (UpdateList shows the matching list header with its counter)
            f.sidebar:Show(); f.detailFrame:Show()
            IMAGO.Chronicle.UpdateList()
            if not skipAutoSelect then IMAGO.Chronicle.AutoSelectEntry(index) end
        elseif index == 6 then
            -- Timeline tab: era sidebar + chronology list + event detail
            f.sidebar:Show(); f.detailFrame:Show()
            if f.sidebar.zonesHeader then f.sidebar.zonesHeader:Hide() end
            if f.sidebar.racesHeader then f.sidebar.racesHeader:Hide() end
            if f.sidebar.classesHeader then f.sidebar.classesHeader:Hide() end
            if f.sidebar.codexHeader then f.sidebar.codexHeader:Hide() end
            if f.sidebar.timelineHeader then f.sidebar.timelineHeader:Show() end
            IMAGO.Chronicle.UpdateList()
            IMAGO.Chronicle.ShowTimelineDefault()
        elseif index == 7 then
            -- Codex tab: categories sidebar + entry list + content
            f.sidebar:Show(); f.detailFrame:Show()
            if f.sidebar.zonesHeader then f.sidebar.zonesHeader:Hide() end
            if f.sidebar.racesHeader then f.sidebar.racesHeader:Hide() end
            if f.sidebar.classesHeader then f.sidebar.classesHeader:Hide() end
            if f.sidebar.codexHeader then f.sidebar.codexHeader:Show() end
            if f.sidebar.timelineHeader then f.sidebar.timelineHeader:Hide() end
            IMAGO.Chronicle.UpdateList()
            IMAGO.Chronicle.ShowCodexDefault()
        elseif index == 8 then
            -- Achievements tab: unified progress across all categories
            f.searchBox:Hide()
            f.filterBtn:Hide()
            f.sidebar:Hide()
            f.detailFrame:Hide()
            IMAGO.Chronicle.ShowAchievements()
        elseif index == 9 then
            -- Credits tab
            f.searchBox:Hide()
            f.filterBtn:Hide()
            f.sidebar:Hide()
            f.detailFrame:Hide()

            if not f.creditsPage then
                -- Static header area (not scrollable)
                f.creditsHeader = CreateFrame("Frame", nil, f)
                f.creditsHeader:SetSize(f:GetWidth(), 250)
                f.creditsHeader:SetPoint("TOP", f, "TOP", 0, 0)

                f.creditsHeader.logo = f.creditsHeader:CreateTexture(nil, "ARTWORK")
                f.creditsHeader.logo:SetSize(100, 100)
                f.creditsHeader.logo:SetPoint("TOP", 0, -85) -- Shifted further down
                f.creditsHeader.logo:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\Logo.tga")

                f.creditsHeader.title = f.creditsHeader:CreateFontString(nil, "OVERLAY")
                f.creditsHeader.title:SetFont(IMAGO.FONT_TITLE, 28, "OUTLINE")
                f.creditsHeader.title:SetPoint("TOP", f.creditsHeader.logo, "BOTTOM", 0, -5)
                f.creditsHeader.title:SetText(IMAGO.L["CREDITS_TITLE"])
                f.creditsHeader.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

                f.creditsHeader.desc = f.creditsHeader:CreateFontString(nil, "OVERLAY")
                f.creditsHeader.desc:SetFont(IMAGO.FONT_BODY, 13)
                f.creditsHeader.desc:SetPoint("TOP", f.creditsHeader.title, "BOTTOM", 0, -10)
                f.creditsHeader.desc:SetWidth(550)
                f.creditsHeader.desc:SetText(IMAGO.L["CREDITS_DESC"])
                f.creditsHeader.desc:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                f.creditsHeader.desc:SetJustifyH("CENTER")

                f.creditsHeader.topHint = f.creditsHeader:CreateFontString(nil, "OVERLAY")
                f.creditsHeader.topHint:SetFont(IMAGO.FONT_BODY, 12)
                f.creditsHeader.topHint:SetPoint("TOP", f.creditsHeader.desc, "BOTTOM", 0, -10)
                f.creditsHeader.topHint:SetWidth(500)
                f.creditsHeader.topHint:SetText(IMAGO.L["CREDITS_TOP_HINT"])
                f.creditsHeader.topHint:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
                f.creditsHeader.topHint:SetJustifyH("CENTER")

                -- Elegant golden divider (gradient)
                f.creditsHeader.separator = f.creditsHeader:CreateTexture(nil, "ARTWORK")
                f.creditsHeader.separator:SetSize(400, 1)
                f.creditsHeader.separator:SetPoint("TOP", f.creditsHeader.topHint, "BOTTOM", 0, -20)
                f.creditsHeader.separator:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                f.creditsHeader.separator:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4))

                -- Only the name list is scrollable
                f.creditsPage = CreateFrame("ScrollFrame", "IMAGOCreditsScrollFrame", f, "UIPanelScrollFrameTemplate")
                f.creditsPage:SetPoint("TOPLEFT", f.creditsHeader, "BOTTOMLEFT", 0, -40) -- Increased from -10 to -40
                f.creditsPage:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 50)
                
                local content = CreateFrame("Frame", nil, f.creditsPage)
                content:SetSize(f:GetWidth(), 1) -- Full width for perfect centering
                f.creditsPage:SetScrollChild(content)
                f.creditsPage.content = content

                -- Scrollbar styling & positioning
                if _G[f.creditsPage:GetName().."ScrollBar"] then
                    local sb = _G[f.creditsPage:GetName().."ScrollBar"]
                    sb:ClearAllPoints()
                    sb:SetPoint("TOPRIGHT", f.creditsPage, "TOPRIGHT", -15, 0) -- Scrollbar flush at the top
                    sb:SetPoint("BOTTOMRIGHT", f.creditsPage, "BOTTOMRIGHT", -15, 0)
                    sb:SetWidth(10)
                    for _, res in ipairs({sb:GetRegions()}) do
                        if res:IsObjectType("Texture") then res:SetVertexColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.5) end
                    end
                end

                local contributors = {
                    {name = "Whisblaze", roles = "Creator, Lua Developer, Lore Scribe, Data Miner", top = true},
                    {name = "SilverWind_809", roles = "Co-Creator, Lua Developer, Lore Scribe, Data Miner", top = true},
                    {name = "Cadash", roles = "Lore Scribe, Archivist, Data Miner, Translator", top = true},
                }

                local yOffset = -40 -- More space after the divider
                local spacing = 25
                for i, person in ipairs(contributors) do
                    local entry = content:CreateFontString(nil, "OVERLAY")
                    
                    if person.top then
                        -- Noble gold for top members
                        entry:SetFont(IMAGO.FONT_BODY, 16, "OUTLINE")
                        entry:SetText(string.format("|cFFC8A84B%s|r  |cFFD4AF37(%s)|r", person.name, person.roles))
                    else
                        -- Subtle silver for everyone else
                        entry:SetFont(IMAGO.FONT_BODY, 14, "")
                        entry:SetText(string.format("|cFFC0C0C0%s|r  |cFF888888(%s)|r", person.name, person.roles))
                    end
                    
                    entry:SetPoint("TOP", content, "TOP", 0, yOffset)
                    yOffset = yOffset - (person.top and 30 or spacing)
                end
                content:SetHeight(math.abs(yOffset) + 20)
            end
            if f.creditsHeader then f.creditsHeader:Show() end
            f.creditsPage:Show()
        end
    end

    local function ApplyOpaqueUI()
        local opaque = IMAGOSaved and IMAGOSaved.opaqueUI
        f:SetBackdrop(opaque and backdropOpaque or backdropDefault)
        f:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], opaque and 1.0 or 0.95)
        f:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
        if f.headerBg then
            if opaque then
                f.headerBg:SetGradient("VERTICAL", CreateColor(0, 0, 0, 1), CreateColor(0, 0, 0, 1))
            else
                f.headerBg:SetGradient("VERTICAL", CreateColor(0, 0, 0, 0.7), CreateColor(0, 0, 0, 0))
            end
        end
        if f.filterMenu then
            f.filterMenu:SetBackdrop(opaque and backdropOpaque or backdropDefault)
            f.filterMenu:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], opaque and 1.0 or 0.98)
            f.filterMenu:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
        end
        if f.detailFrame then
            f.detailFrame:SetBackdrop(opaque and detailBackdropOpaque or detailBackdropDefault)
            f.detailFrame:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], opaque and 1.0 or 0.95)
        end
        if f.sidebar and f.sidebar.bg then
            f.sidebar.bg:SetAlpha(opaque and 1.0 or 0.85)
        end
    end

    f:SetScript("OnShow", ApplyOpaqueUI)

    IMAGO.Chronicle.frame = f
    IMAGO.Chronicle.buttons = {}
    IMAGO.Chronicle.headers = {}

    -- Empty detail pane (list has nothing openable yet): dimmed emblem + hint
    f.ShowEmptyState = function(text)
        if f.factsBand then f.factsBand:Hide() end
        f.startPage.hint:SetText(text or IMAGO.L["STARTPAGE_HINT"] or "Select an entry from the list on the left.")
        f.detailTitle:Hide()
        f.detailLineLeft:Hide()
        f.detailLineRight:Hide()
        f.tabLore:Hide()
        f.tabTime:Hide()
        f.infoScroll:Hide()
        if f.loreSource then f.loreSource:Hide() end
        f.detailModel:Hide()

        if f.detailModel2 then f.detailModel2:Hide() end
        f.hintPage:Hide()
        f.factionIcon:Hide()
        if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
                if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
                if f.classIcon then f.classIcon:Hide() end
                if f.classEmblemBox then f.classEmblemBox:Hide() end
        if f.raceContainer then f.raceContainer:Hide() end
        if f.classContainer then f.classContainer:Hide() end
        if f.raceEmblemBox then f.raceEmblemBox:Hide() end
        if f.raceZoneImage then f.raceZoneImage:Hide() end
        if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end
        if f.codexListPanel then f.codexListPanel:Hide() end
        if f.codexContent then f.codexContent:Hide() end
        if f.codexCatHeading then f.codexCatHeading:Hide() end
        if f.timelineListPanel then f.timelineListPanel:Hide() end
        if f.timelineContent then f.timelineContent:Hide() end
        if f.timelineChronoHeading then f.timelineChronoHeading:Hide() end
        if f.detailImage then f.detailImage:Hide() end

        if f.detailImageBorder then f.detailImageBorder:Hide() end
        if f.detailSeparator then f.detailSeparator:Hide() end
        IMAGO.Chronicle.HideZoneDetail()
        IMAGO.Chronicle.SetDetailAction(nil)
        f.startPage:Show()
    end

    local function ShowTab(mode)
        f.loreBody:Hide()
        if f.loreSource then f.loreSource:Hide() end
        if f.timelineContainer then f.timelineContainer:Hide() end
        if f.detailImage then f.detailImage:Hide() end

        if f.detailImageBorder then f.detailImageBorder:Hide() end
        if f.detailSeparator then f.detailSeparator:Hide() end

        f.tabLore.text:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        f.tabLore.activeLine:Hide()
        f.tabTime.text:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        f.tabTime.activeLine:Hide()

        f.infoScroll:ClearAllPoints()
        f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", LORE_X - LORE_INSET, -116)
        f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", LORE_RIGHT, f._infoBottom or 100)
        f.infoScroll:SetVerticalScroll(0)

        if mode == "lore" then
            f.loreBody:Show()
            if f.loreSource and (f.loreSource:GetText() or "") ~= "" then
                f.loreSource:Show()
            end
            f.tabLore.text:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            f.tabLore.activeLine:Show()
        else
            IMAGO.Chronicle.RenderTimeline()
            f.tabTime.text:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            f.tabTime.activeLine:Show()
        end
        AdjustInfoScroll()
    end

    f.tabLore:SetScript("OnClick", function() ShowTab("lore") end)
    f.tabTime:SetScript("OnClick", function() ShowTab("time") end)
    f.ShowTab = ShowTab
    IMAGO.Chronicle.AdjustInfoScroll = AdjustInfoScroll
    IMAGO.Chronicle.SelectMainTab(1)
end

function IMAGO.Chronicle.RenderTimeline()
    local f = IMAGO.Chronicle.frame
    local data = f.selectedNPC
    if not data or not data.timeline then return end

    if not f.timelineContainer then
        f.timelineContainer = CreateFrame("Frame", nil, f.infoContent)
        f.timelineContainer:SetPoint("TOPLEFT", 20, 0)
        f.timelineContainer:SetSize(420, 1)
        f.timelineContainer.eras = {}
        f.timelineContainer.texts = {}
        f.timelineContainer.dividers = {}

        f.timelineContainer:EnableMouse(true)
        f.timelineContainer:SetHyperlinksEnabled(true)
        f.timelineContainer:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
                IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
            end
        end)
    end
    f.timelineContainer:Show()

    -- Hide all previous elements (pairs for sparse tables)
    for _, fs in pairs(f.timelineContainer.eras) do fs:Hide() end
    for _, fs in pairs(f.timelineContainer.texts) do fs:Hide() end
    for _, div in pairs(f.timelineContainer.dividers) do div:Hide() end

    -- Shared link-state for this render pass: each NPC/zone name is
    -- hyperlinked only on its FIRST occurrence across the whole timeline.
    local selfSlug = f.selectedNPCSlug
    local sharedNPCLinks, sharedZoneLinks = {}, {}

    -- Expansion scoping: hide timeline entries beyond the NPC's own
    -- expansion; that expansion's era entry gets spoiler protection.
    local npcSlug = selfSlug or ""
    local npcEra
    for suffix, era in pairs(SLUG_ERA) do
        if npcSlug:sub(-#suffix) == suffix then npcEra = era break end
    end
    local cutoffOrder = npcEra and ERA_ORDER[npcEra] or math.huge
    local spoilerEra  = npcEra or "Forever"

    local visibleEntries = {}
    for _, entry in ipairs(data.timeline) do
        local ord = ERA_ORDER[entry.era]
        if not ord or ord <= cutoffOrder then
            visibleEntries[#visibleEntries + 1] = entry
        end
    end

    IMAGOSaved.revealedSpoilers = IMAGOSaved.revealedSpoilers or {}
    local isRevealed = IMAGOSaved.revealedSpoilers[npcSlug]
        or (IMAGOSaved.revealedMidnight and IMAGOSaved.revealedMidnight[npcSlug])

    local y = 0
    local contentW = math.max(1, (f.infoScroll:GetWidth() or 0) - IMAGO.LAYOUT.SCROLLBAR_GUTTER)
    -- entry text ends on the lore text's right edge (era label 80 px + its
    -- 20 px gap to the left of it), dividers span exactly era + text
    local textW = math.max(310, math.min(contentW - 140, LORE_TEXT_W - 100))
    local dividerW = math.max(320, textW + 100)

    for i, entry in ipairs(visibleEntries) do
        -- Subtle divider before each entry (except the first)
        if i > 1 then
            local divider = f.timelineContainer.dividers[i]
            if not divider then
                divider = f.timelineContainer:CreateTexture(nil, "ARTWORK")
                divider:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                f.timelineContainer.dividers[i] = divider
            end
            divider:SetSize(dividerW, 1)
            divider:SetPoint("TOPLEFT", 0, -y + 10)
            divider:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.05))
            divider:Show()
        end

        local era = f.timelineContainer.eras[i]
        if not era then
            era = f.timelineContainer:CreateFontString(nil, "OVERLAY")
            era:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
            f.timelineContainer.eras[i] = era
        end

        local col = eraColors[entry.era] or {1, 1, 1}
        era:SetTextColor(unpack(col))
        era:SetPoint("TOPLEFT", 0, -y)
        era:SetText("[" .. entry.era .. "]")
        era:Show()

        local txt = f.timelineContainer.texts[i]
        if not txt then
            txt = f.timelineContainer:CreateFontString(nil, "OVERLAY")
            txt:SetFont(IMAGO.FONT_BODY, 14, "")
            txt:SetJustifyH("LEFT")
            txt:SetSpacing(6)
            f.timelineContainer.texts[i] = txt
        end
        txt:SetWidth(textW)

        -- Link this entry's text against the shared tables, in timeline order,
        -- so the same name/zone is never linked twice across the timeline.
        local linkedEntryText = IMAGO.TextLinker.LinkNames(
            entry.text or "", selfSlug, nil, sharedNPCLinks, sharedZoneLinks
        )

        -- Spoiler protection for the NPC's own expansion era
        local isSpoilerEntry = (entry.era == spoilerEra)

        if isSpoilerEntry and not isRevealed then
            local L = IMAGO.L
            local spoilerCol = eraColors[spoilerEra] or IMAGO_COLORS.VOID
            local spoilerTitle = L["SPOILER_" .. spoilerEra .. "_TITLE"] or L["SPOILER_FOREVER_TITLE"]
            local spoilerHint  = L["SPOILER_" .. spoilerEra .. "_HINT"]  or L["SPOILER_FOREVER_HINT"]
            txt:SetText("[" .. spoilerTitle .. "] — " .. spoilerHint)
            txt:SetTextColor(unpack(spoilerCol))
            txt.realText = linkedEntryText
            txt.npcSlug = npcSlug
            txt.isSpoiler = true
            txt:EnableMouse(true)
            txt:SetScript("OnMouseUp", function(self)
                IMAGOSaved.revealedSpoilers[self.npcSlug] = true
                if IMAGOSaved.revealedMidnight then IMAGOSaved.revealedMidnight[self.npcSlug] = true end
                self:SetText(self.realText)
                self:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
                self.isSpoiler = false
                self:EnableMouse(false)
                self:SetScript("OnMouseUp", nil)
                self:SetScript("OnEnter", nil)
                self:SetScript("OnLeave", nil)
                UIFrameFadeIn(self, 0.3, 0, 1)
            end)
            txt:SetScript("OnEnter", function(self)
                if self.isSpoiler then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText("⚠️ " .. L["SPOILER_TOOLTIP_TITLE"], IMAGO_COLORS.DANGER[1], IMAGO_COLORS.DANGER[2], IMAGO_COLORS.DANGER[3])
                    GameTooltip:AddLine(L["SPOILER_TOOLTIP_DESC_" .. spoilerEra] or L["SPOILER_TOOLTIP_DESC"], IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
                    GameTooltip:Show()
                    -- Hover effect: brighter text
                    self:SetTextColor(unpack(spoilerCol))
                end
            end)
            txt:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
                if self.isSpoiler then
                    self:SetTextColor(unpack(spoilerCol))
                end
            end)
        else
            txt:SetText(linkedEntryText)
            txt:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
            txt.isSpoiler = false
            txt:EnableMouse(false)
            txt:SetScript("OnMouseUp", nil)
            txt:SetScript("OnEnter", nil)
            txt:SetScript("OnLeave", nil)
        end
        txt:SetPoint("TOPLEFT", 100, -y)
        txt:Show()

        local textHeight = txt:GetStringHeight()
        y = y + math.max(20, textHeight) + 28
    end
    f.timelineContainer:SetHeight(y - 5)
    if IMAGO.Chronicle.AdjustInfoScroll then IMAGO.Chronicle.AdjustInfoScroll() end
end

-- ============================================================
-- AUTO-SELECT: opening Fates/Zones/Races/Classes shows an entry
-- right away (last viewed, else first openable) instead of an
-- empty overview page.
-- ============================================================
function IMAGO.Chronicle.RememberViewed(tab, id)
    if id == nil then return end
    IMAGOSaved.lastViewed = IMAGOSaved.lastViewed or {}
    IMAGOSaved.lastViewed[tab] = id
end

local AUTO_LISTS = {
    [2] = { list = "buttons",      id = "npcSlug" },
    [3] = { list = "zoneButtons",  id = "mapID" },
    [4] = { list = "raceButtons",  id = "raceSlug" },
    [5] = { list = "classButtons", id = "classSlug" },
}

-- Openable without side effects: shown, unlocked, and not a fresh
-- discovery (those keep their first-open reveal for the player's click)
local function IsSafeAutoPick(tab, btn)
    if not btn:IsShown() then return false end
    if not btn.isVisible then return false end
    local id = btn[AUTO_LISTS[tab].id]
    if tab == 2 then
        return not (btn.isSeen and not (IMAGOSaved.viewedNPCs or {})[id])
    elseif tab == 4 then
        return (IMAGOSaved.viewedRaces or {})[id] or not (IMAGOSaved.seenRaces or {})[id]
    elseif tab == 5 then
        return (IMAGOSaved.viewedClasses or {})[id] or not (IMAGOSaved.seenClasses or {})[id]
    end
    return true
end

function IMAGO.Chronicle.AutoSelectEntry(tab)
    local f = IMAGO.Chronicle.frame
    local cfg = AUTO_LISTS[tab]
    if not f or not cfg then return end

    local last = IMAGOSaved.lastViewed and IMAGOSaved.lastViewed[tab]
    local anyVisible

    -- Fates live in collapsible categories (collapsed on first open), so
    -- the target is chosen from the data, not from the shown buttons:
    -- last viewed if still openable, else the first openable fate in list
    -- order. Its category is then expanded so the button exists.
    if tab == 2 then
        local seenT, viewedT = IMAGOSaved.seenNPCs or {}, IMAGOSaved.viewedNPCs or {}
        local manualT = IMAGOSaved.manualUnlocks or {}
        local function visible(slug)
            return seenT[slug] or manualT[slug] or IMAGOSaved.encyclopediaMode
        end
        local function safe(slug)
            return visible(slug) and not (seenT[slug] and not viewedT[slug])
        end
        local target = (type(last) == "string" and IMAGO.GetNPCData(last) and safe(last)) and last or nil
        local cats = {}
        for cat in pairs(IMAGOdb.npcs or {}) do cats[#cats + 1] = cat end
        table.sort(cats)
        for _, cat in ipairs(cats) do
            local entries = IMAGOdb.npcs[cat]
            if type(entries) == "table" then
                local slugs = {}
                for slug, d in pairs(entries) do
                    if visible(slug) then anyVisible = true end
                    slugs[#slugs + 1] = { slug = slug, name = d.name or slug }
                end
                table.sort(slugs, function(a, b) return a.name < b.name end)
                for _, s in ipairs(slugs) do
                    if not target and safe(s.slug) then target = s.slug end
                end
            end
        end
        local data = target and IMAGO.GetNPCData(target)
        if data and data.category then
            -- only the opened entry's group stays expanded by default
            IMAGO.Chronicle.expandedCats = IMAGO.Chronicle.expandedCats or {}
            local n = 0
            for _ in pairs(IMAGO.Chronicle.expandedCats) do n = n + 1 end
            if n ~= 1 or not IMAGO.Chronicle.expandedCats[data.category] then
                IMAGO.Chronicle.expandedCats = { [data.category] = true }
                IMAGO.Chronicle.UpdateList()
            end
        end
        last = target
    end

    local pick
    for _, btn in ipairs(IMAGO.Chronicle[cfg.list] or {}) do
        if tab ~= 2 and btn:IsShown() and btn.isVisible then anyVisible = true end
        if IsSafeAutoPick(tab, btn) then
            if btn[cfg.id] == last then pick = btn break end
            -- Fates: only the data-chosen target (never a random shown one)
            if tab ~= 2 then pick = pick or btn end
        end
    end

    if pick then
        -- Not a user navigation: keep it out of the back-button stack
        local prev = isNavigatingBack
        isNavigatingBack = true
        f._autoSelecting = true
        pick:Click()
        f._autoSelecting = nil
        isNavigatingBack = prev
    elseif f.ShowEmptyState then
        -- Nothing discovered yet (explorer mode): show the tab's own
        -- introduction — what it contains, how to unlock it, and the
        -- encyclopedia-mode hint for readers who want everything now.
        local text
        if not anyVisible and not IMAGOSaved.encyclopediaMode then
            local keys = {
                [2] = { "HOME_DESC_FATES",   "EMPTY_HOWTO_FATES" },
                [3] = { "HOME_DESC_ZONES",   "EMPTY_HOWTO_ZONES" },
                [4] = { "HOME_DESC_RACES",   "EMPTY_HOWTO_RACES" },
                [5] = { "HOME_DESC_CLASSES", "EMPTY_HOWTO_CLASSES" },
            }
            local k = keys[tab]
            if k then
                text = "|c" .. IMAGO_HEX.TEXT_SECONDARY .. (IMAGO.L[k[1]] or "") .. "|r"
                    .. "\n\n|c" .. IMAGO_HEX.GOLD .. (IMAGO.L[k[2]] or "") .. "|r"
                    .. "\n\n" .. (IMAGO.L["EMPTY_ENCYCLOPEDIA"] or "")
            end
        end
        f.ShowEmptyState(text)
    end
end

-- ============================================================
-- FACTS BAND: per-entry facts + "Connections" (entries referenced
-- in the text) at the bottom of the detail pane.
-- ============================================================
local function HexOf(c)
    return string.format("%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
end

local REF_HEX = { npc = "GOLD_BRIGHT", zone = "VOID", codex = "CODEX", timeline = "TIMELINE", race = "GOLD_BRIGHT", class = "GOLD_BRIGHT" }

local function IsRefDiscovered(ref)
    if IMAGOSaved.encyclopediaMode then return true end
    if ref.kind == "npc" then
        return (IMAGOSaved.seenNPCs or {})[ref.id] or (IMAGOSaved.manualUnlocks or {})[ref.id]
    elseif ref.kind == "zone" then
        return (IMAGOSaved.seenZones or {})[ref.id] or (IMAGOSaved.manualZoneUnlocks or {})[ref.id]
    elseif ref.kind == "race" then
        return (IMAGOSaved.seenRaces or {})[ref.id]
    elseif ref.kind == "class" then
        return (IMAGOSaved.seenClasses or {})[ref.id] or (IMAGOSaved.manualClassUnlocks or {})[ref.id]
    end
    return true -- Codex/Timeline entries are always readable
end

-- Canonical display name (a text match may have hit an alias)
local function RefName(ref)
    local d
    if ref.kind == "npc" then
        d = IMAGO.GetNPCData and IMAGO.GetNPCData(ref.id)
        return d and d.name or ref.name
    elseif ref.kind == "zone" then
        d = IMAGOdb.zones and IMAGOdb.zones[ref.id]
        return d and d.name or ref.name
    elseif ref.kind == "codex" then
        d = IMAGOdb.codex and IMAGOdb.codex.entries and IMAGOdb.codex.entries[ref.id]
        return d and d.title or ref.name
    elseif ref.kind == "race" then
        d = IMAGOdb.races and IMAGOdb.races[ref.id]
        return d and d.name or ref.name or tostring(ref.id)
    elseif ref.kind == "class" then
        d = IMAGOdb.classes and IMAGOdb.classes[ref.id]
        return d and d.name or ref.name or tostring(ref.id)
    end
    d = IMAGOdb.timeline and IMAGOdb.timeline.events and IMAGOdb.timeline.events[ref.id]
    return d and d.title or ref.name
end

-- Builds { text = <rendered>, plain = <tooltip text> } list items for refs:
-- discovered ones first (clickable, link colors as in the lore text),
-- undiscovered NPCs/zones afterwards as muted, non-clickable "???"
local function RefItems(refs)
    local known, unknown = {}, {}
    local muted = "|cff" .. HexOf(IMAGO_COLORS.TEXT_MUTED)
    for _, ref in ipairs(refs or {}) do
        if IsRefDiscovered(ref) then
            local name = RefName(ref) or tostring(ref.id)
            known[#known + 1] = {
                text = "|Himago-" .. ref.kind .. ":" .. tostring(ref.id) .. "|h|c"
                    .. IMAGO_HEX[REF_HEX[ref.kind]] .. name .. "|r|h",
                plain = name,
                kind = ref.kind, id = ref.id, disc = true,
            }
        else
            -- kind/id stay intact for the type tag + spoiler-safe counting;
            -- only the name is masked
            unknown[#unknown + 1] = {
                text = muted .. "???|r", plain = "???",
                kind = ref.kind, id = ref.id, disc = false,
            }
        end
    end
    for _, it in ipairs(unknown) do known[#known + 1] = it end
    return known
end

-- Type tag per connection kind (EVENT / TERM / FATE / ZONE)
local TAG_KEY = {
    npc = "FACT_TAG_FATE", zone = "FACT_TAG_ZONE",
    codex = "FACT_TAG_CODEX", timeline = "FACT_TAG_EVENT",
    race = "FACT_TAG_RACE", class = "FACT_TAG_CLASS",
}
local LOCK_TEX = "Interface\\PetBattles\\PetBattle-LockIcon2"

--- facts: array of { label = "FACTION", text = "…", nav = "imago-…" } (max 6)
---        -> left column "DOSSIER"; nav values render gold + clickable
--- refs:  output of IMAGO.TextLinker.FindReferences
---        -> middle column "CONNECTIONS" (tag + name + ">" or lock)
--- rec:   { slug, date, place, note } -> right column "RECORD"
---        (discovery stamp and the share/location/notes action row)
--- Columns are fixed at 1 : 1.15 : 1; the band hides when fully empty.
function IMAGO.Chronicle.SetFactsBand(facts, refs, rec)
    local f = IMAGO.Chronicle.frame
    local band = f and f.factsBand
    if not band then return end
    facts, refs = facts or {}, refs or {}
    if f.notePopup then f.notePopup:Hide() end
    if f.connPopup then f.connPopup:Hide() end
    if f.connCatcher then f.connCatcher:Hide() end
    IMAGO.Chronicle.HideZoneDetail()

    local items = RefItems(refs)
    local nF = math.min(#facts, 6)
    local nC = #items
    local discN = 0
    for _, it in ipairs(items) do if it.disc then discN = discN + 1 end end

    local shown = { nF > 0, true, rec ~= nil }

    -- One grid for everything: 12 px outer margin, 30 px gap between
    -- columns (the separator sits dead centre in it), columns weighted
    -- 1.1 : 1.15 : 1. Accent bar, wash, text, rows, counter and buttons
    -- all derive from cx/cw; content is inset by band.PAD inside a column.
    local W = band:GetWidth()
    if W < 50 then W = 800 end
    -- Column 2 starts on the lore column's left edge (the band sits at
    -- detail-x 10), so the CONNECTIONS bar lines up with the tabs and the
    -- lore text; column 1 then spans the stage width above it.
    local OUT, GAP = 12, 30
    local c2 = LORE_X - 10
    local rest = W - OUT - c2 - GAP
    local cw = { c2 - OUT - GAP, rest * 1.15 / 2.15, rest * 1 / 2.15 }
    local cx = { OUT, c2, c2 + cw[2] + GAP }

    -- Label column per column: ~64 px baseline, grown to fit the actual
    -- label texts (e.g. "DISCOVERED" needs ~76 px), capped at 110
    local labW = { band.LAB_W, band.LAB_W, band.LAB_W }
    f.factsMeasure:SetWordWrap(false)
    f.factsMeasure:SetFont(IMAGO.FONT_BODY, 11)
    if shown[1] then
        local w = band.LAB_W
        for i = 1, nF do
            f.factsMeasure:SetText(facts[i].label or "")
            w = math.max(w, f.factsMeasure:GetStringWidth() + 6)
        end
        labW[1] = math.min(w, 110)
    end
    if shown[3] then
        local w = 88
        for _, key in ipairs({ "FACT_DISCOVERED", "FACT_PLACE" }) do
            f.factsMeasure:SetText(IMAGO.L[key] or "")
            w = math.max(w, f.factsMeasure:GetStringWidth() + 6)
        end
        labW[3] = math.min(w, 110)
    end

    -- PLACE: zone + muted coordinates on one line when they fit, else
    -- deliberately on two (zone / coordinates). Decided before the band
    -- height so the footer always fits its rows and buttons.
    local placeText, placeTwo = "—", false
    if shown[3] and rec.zone then
        placeText = rec.zone
        if rec.coords then
            local valW = cw[3] - 2 * band.PAD - labW[3]
            f.factsMeasure:SetFont(IMAGO.FONT_BODY, 13)
            f.factsMeasure:SetWordWrap(false)
            f.factsMeasure:SetMaxLines(1)
            f.factsMeasure:SetWidth(0)
            f.factsMeasure:SetText(rec.zone .. "  " .. rec.coords)
            local fits = f.factsMeasure:GetStringWidth() <= valW
            placeTwo = not fits
            placeText = rec.zone .. (fits and "  " or "\n") .. "|cff" .. HexOf(IMAGO_COLORS.TEXT_MUTED)
                .. rec.coords .. "|r"
        end
    end

    if not (shown[1] or shown[3] or nC > 0) then
        band:Hide()
        f._infoBottom = 20
    else
        -- fixed height: six row slots per column keeps the footer (and the
        -- scroll area above it) the same size on every entry
        local bandH = band.ROW_Y + 6 * band.ROW_H + 12
        band:SetHeight(bandH)
        band:Show()
        -- 8 px band offset + 20 px air between text column and footer
        f._infoBottom = 8 + bandH + 20
    end
    if f.infoScroll then
        for i = 1, f.infoScroll:GetNumPoints() do
            local p, rel, rp, x = f.infoScroll:GetPoint(i)
            if p == "BOTTOMRIGHT" then
                f.infoScroll:SetPoint(p, rel, rp, x, f._infoBottom)
                break
            end
        end
    end
    -- The stage bottoms out on the shared edge above the band
    if f.stageFrame then
        f.stageFrame:ClearAllPoints()
        f.stageFrame:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -76)
        f.stageFrame:SetPoint("BOTTOMLEFT", f.detailFrame, "BOTTOMLEFT", 10, f._infoBottom)
        f.stageFrame:SetWidth(264)
    end

    local headTxt = {
        IMAGO.L["FACT_TITLE"] or "DOSSIER",
        IMAGO.L["FACT_CONNECTIONS"] or "CONNECTIONS",
        IMAGO.L["FACT_RECORD"] or "RECORD",
    }
    for i = 1, 3 do
        band.heads[i]:SetShown(shown[i])
        band.hairs[i]:SetShown(shown[i])
        if shown[i] then
            band.heads[i]:SetText(headTxt[i])
            band.heads[i]:ClearAllPoints()
            band.heads[i]:SetPoint("TOPLEFT", band, "TOPLEFT", cx[i] + band.PAD, -13)
            -- the one hairline of the footer: under the head, in the dark
            -- line colour, across the column's content width
            band.hairs[i]:ClearAllPoints()
            band.hairs[i]:SetPoint("TOPLEFT", band, "TOPLEFT", cx[i] + band.PAD, -31)
            band.hairs[i]:SetWidth(cw[i] - 2 * band.PAD)
        end
    end

    -- Soft separators dead centre in the 30 px gap, running from the top
    -- of the heading strip to the bottom edge of the buttons (12 px margin)
    local bh = band:GetHeight()
    for i = 1, 2 do
        local s = band.seps[i]
        local on = shown[i] and shown[i + 1]
        s.up:SetShown(on)
        s.dn:SetShown(on)
        if on then
            local sx = cx[i + 1] - GAP / 2
            local half = math.max(1, (bh - 10 - 12) / 2)
            s.up:ClearAllPoints()
            s.up:SetPoint("TOPLEFT", band, "TOPLEFT", sx, -10)
            s.up:SetHeight(half)
            s.dn:ClearAllPoints()
            s.dn:SetPoint("BOTTOMLEFT", band, "BOTTOMLEFT", sx, 12)
            s.dn:SetHeight(half)
        end
    end

    for _, r in ipairs(band.kv) do r:Hide() end
    for _, r in ipairs(band.rk) do r:Hide() end
    for _, r in ipairs(band.cx) do r:Hide() end
    band.more:Hide()
    band.more._moreList = nil
    band.empty:Hide()
    band.count:Hide()
    for _, b in ipairs(band.acts) do b:Hide() end

    local function KVRow(pool, i, col, label, text, nav, wrap)
        local r = pool[i]
        if not r then r = band.MakeKV() pool[i] = r end
        r.lab:SetText(label)
        r.lab:SetWidth(labW[col])
        local valW = cw[col] - 2 * band.PAD - labW[col]
        r.val:SetWidth(valW)
        r.val:SetWordWrap(wrap and true or false)
        r.val:SetMaxLines(wrap and 2 or 1)
        r.val:SetText(text)
        r._gold = nav ~= nil
        r._nav = nav
        r._plain = text
        r.val:SetTextColor(nav and IMAGO_COLORS.GOLD[1] or IMAGO_COLORS.TEXT_PRIMARY[1],
            nav and IMAGO_COLORS.GOLD[2] or IMAGO_COLORS.TEXT_PRIMARY[2],
            nav and IMAGO_COLORS.GOLD[3] or IMAGO_COLORS.TEXT_PRIMARY[3])
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", band, "TOPLEFT", cx[col] + band.PAD,
            -(band.ROW_Y + (i - 1) * band.ROW_H))
        r:SetWidth(cw[col] - 2 * band.PAD)
        r:Show()
        return r
    end

    -- DOSSIER — one line per fact (hover shows the full value when cut)
    if shown[1] then
        for i = 1, nF do
            local fact = facts[i]
            KVRow(band.kv, i, 1, fact.label, fact.text, fact.nav, false)
        end
    end

    -- CONNECTIONS
    band.count:SetText(discN .. " / " .. nC)
    band.count:ClearAllPoints()
    band.count:SetPoint("TOPRIGHT", band, "TOPLEFT", cx[2] + cw[2] - band.PAD, -14)
    band.count:Show()
    if nC == 0 then
        band.empty:SetText(IMAGO.L["FACT_EMPTY"] or "No connections yet")
        band.empty:ClearAllPoints()
        band.empty:SetPoint("TOPLEFT", band, "TOPLEFT", cx[2] + band.PAD, -band.ROW_Y - 2)
        band.empty:Show()
    end
    -- six slots: all items when <= 6, otherwise five + the "+N more" row
    local visN = math.min(nC, 6)
    if nC > 6 then visN = 5 end
    for i = 1, visN do
        local it = items[i]
        local r = band.cx[i]
        if not r then r = band.MakeCX() band.cx[i] = r end
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", band, "TOPLEFT", cx[2] + band.PAD,
            -(band.ROW_Y + (i - 1) * band.ROW_H))
        r:SetWidth(cw[2] - 2 * band.PAD)
        local nameMax = cw[2] - 2 * band.PAD - band.TAG_W - 4 - 6
        r.tag:SetText(IMAGO.L[TAG_KEY[it.kind] or ""] or (it.kind or "?"):upper())
        r.tag:Show()
        if it.disc then
            r.name:SetText(it.plain)
            r.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            r._gold = true
            r._nav = "imago-" .. it.kind .. ":" .. tostring(it.id)
            r._plain = it.plain
            r.icon:Hide()
        else
            r.name:SetText(IMAGO.L["FACT_UNDISCOVERED"] or "??? Undiscovered")
            r.name:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.7)
            r._gold = false
            r._nav = nil
            r._plain = nil
            r.icon:SetTexture(LOCK_TEX)
            r.icon:SetVertexColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.8)
            r.icon:Show()
        end
        -- the name box hugs its text (capped), so the lock sits directly
        -- behind the name instead of at the column edge
        r.name:SetWidth(math.min(r.name:GetStringWidth() + 1, nameMax))
        r.icon:ClearAllPoints()
        r.icon:SetPoint("LEFT", r.name, "RIGHT", 6, 0)
        r:Show()
    end
    if nC > visN then
        local r = band.more
        local tail = {}
        for i = visN + 1, nC do tail[#tail + 1] = items[i] end
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", band, "TOPLEFT", cx[2] + band.PAD,
            -(band.ROW_Y + visN * band.ROW_H))
        r:SetWidth(cw[2] - 2 * band.PAD)
        r.tag:Hide()
        r.name:SetWidth(cw[2] - 2 * band.PAD - band.TAG_W - 4)
        r.name:SetText(string.format(IMAGO.L["FACT_MORE_N"] or "+%d more", nC - visN))
        r.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        r._gold = false
        r._nav = nil
        r._plain = nil
        r._moreList = tail
        r.icon:Hide()
        r:Show()
    end

    -- RECORD
    if shown[3] then
        KVRow(band.rk, 1, 3, IMAGO.L["FACT_DISCOVERED"] or "DISCOVERED", rec.date or "—")
        local pr = KVRow(band.rk, 2, 3, IMAGO.L["FACT_PLACE"] or "PLACE", placeText, nil, placeTwo)
        pr:SetHeight(placeTwo and 34 or band.ROW_H)

        -- three equal action buttons, always on one row, 6px gaps.
        -- The available icons come from different families, so the whole
        -- row stays text only — one uniform look or no icons at all.
        local inner = cw[3] - 2 * band.PAD
        local bw = (inner - 12) / 3
        for i, b in ipairs(band.acts) do
            b:SetWidth(bw)
            b:ClearAllPoints()
            b:SetPoint("BOTTOMLEFT", band, "BOTTOMLEFT",
                cx[3] + band.PAD + (i - 1) * (bw + 6), 12)
            b._slug = rec.slug
            b.lab:SetText(IMAGO.L[b._act.label] or "")
            b.lab:SetWidth(bw - 8)
            b.lab:ClearAllPoints()
            b.lab:SetPoint("CENTER", b, "CENTER", 0, 0)
            b.lab:Show()
            if b._act.key == "notes" then
                if rec.note and rec.note ~= "" then
                    b._note = rec.note
                    b.dot:ClearAllPoints()
                    b.dot:SetPoint("LEFT", b.lab, "RIGHT", 4, 0)
                    b.dot:Show()
                else
                    b._note = nil
                    b.dot:Hide()
                end
            end
            b:Show()
        end
    end

    if IMAGO.Chronicle.AdjustInfoScroll then IMAGO.Chronicle.AdjustInfoScroll() end
end

--- Opens the personal note editor for a fate or a zone ("zone:<mapID>"),
--- saved in IMAGOSaved.notes. Clicking Notes again for the same entry
--- closes it.
function IMAGO.Chronicle.OpenNotePopup(slug)
    local f = IMAGO.Chronicle.frame
    local npop = f and f.notePopup
    if not npop or not slug then return end
    if npop:IsShown() then
        local same = npop._slug == slug
        npop:Hide()
        if same then return end
    end
    npop._slug = slug
    local zoneID = tonumber(tostring(slug):match("^zone:(%d+)$"))
    local data = (zoneID and IMAGOdb.zones and IMAGOdb.zones[zoneID])
        or (IMAGO.GetNPCData and IMAGO.GetNPCData(slug))
        or (IMAGOdb.races and IMAGOdb.races[slug])
        or (IMAGOdb.classes and IMAGOdb.classes[slug])
    npop.kicker:SetText(IMAGO.L["FACT_NOTES_TITLE"] or "Notes")
    npop.title:SetText((data and data.name) or slug)
    npop.Place()
    npop.edit:SetText((IMAGOSaved.notes and IMAGOSaved.notes[slug]) or "")
    npop:Show()
    npop.scroll:SetVerticalScroll(0)
    npop.edit:SetFocus()
    npop.edit:SetCursorPosition(npop.edit:GetNumLetters())
    npop.UpdateCount()
    C_Timer.After(0, npop.ScrollToEnd)
end

--- Overflow list for the facts band's "+N more" row: the same connection
--- rows, but inside a clickable popup anchored to that row. Clicking a row
--- navigates exactly like a band chip; clicking anywhere else dismisses.
function IMAGO.Chronicle.ShowConnPopup(items, anchorRow)
    local f = IMAGO.Chronicle.frame
    local band = f and f.factsBand
    if not (band and band.MakeCX) or not items or #items == 0 then return end
    local pop = f.connPopup
    if not pop then
        -- click-catcher below the popup (created first = lower frame level):
        -- any click outside the list dismisses it
        local catch = CreateFrame("Button", nil, f.detailFrame)
        catch:SetAllPoints(f.detailFrame)
        catch:SetFrameStrata("DIALOG")
        catch:SetScript("OnClick", function(self)
            if f.connPopup then f.connPopup:Hide() end
            self:Hide()
        end)
        catch:Hide()
        f.connCatcher = catch
        pop = CreateFrame("Frame", nil, f.detailFrame, "BackdropTemplate")
        pop:SetFrameStrata("DIALOG")
        pop:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })
        pop:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 1.0)
        pop:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7)
        pop:EnableMouse(true)
        pop.rows = {}
        pop.head = pop:CreateFontString(nil, "OVERLAY")
        pop.head:SetFont(IMAGO.FONT_BODY, 11)
        pop.head:SetPoint("TOPLEFT", 12, -10)
        pop.head:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        f.connPopup = pop
    end
    if pop:IsShown() and pop._anchor == anchorRow then
        pop:Hide()
        f.connCatcher:Hide()
        return
    end
    pop._anchor = anchorRow
    pop.head:SetText(IMAGO.L["FACT_MORE"] or "Also mentioned")
    local W = math.max(220, (anchorRow and anchorRow.GetWidth and anchorRow:GetWidth() or 0))
    local n = math.min(#items, 14)
    pop:SetSize(W, 26 + n * band.ROW_H + 8)
    for i = 1, n do
        local it = items[i]
        local r = pop.rows[i]
        if not r then r = band.MakeCX(pop) pop.rows[i] = r end
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", pop, "TOPLEFT", 8, -(26 + (i - 1) * band.ROW_H))
        r:SetWidth(W - 16)
        r.tag:SetText(IMAGO.L[TAG_KEY[it.kind] or ""] or (it.kind or "?"):upper())
        r.tag:Show()
        if it.disc then
            r.name:SetText(it.plain)
            r.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            r._gold = true
            r._nav = "imago-" .. it.kind .. ":" .. tostring(it.id)
            r._plain = it.plain
            r.icon:Hide()
        else
            r.name:SetText(IMAGO.L["FACT_UNDISCOVERED"] or "??? Undiscovered")
            r.name:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.7)
            r._gold = false
            r._nav = nil
            r._plain = nil
            r.icon:SetTexture(LOCK_TEX)
            r.icon:SetVertexColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.8)
            r.icon:Show()
        end
        r.name:SetWidth(math.min(r.name:GetStringWidth() + 1, W - 16 - band.TAG_W - 4))
        r.icon:ClearAllPoints()
        r.icon:SetPoint("LEFT", r.name, "RIGHT", 6, 0)
        r._moreList = nil
        r:Show()
    end
    for i = n + 1, #pop.rows do pop.rows[i]:Hide() end
    pop:ClearAllPoints()
    pop:SetPoint("BOTTOMLEFT", anchorRow or band, "TOPLEFT", -4, 6)
    f.connCatcher:Show()
    pop:Show()
end

--- Fates entry: DOSSIER rows (optional ROLE, linked AFFILIATION and RACE),
--- connections from the lore plus every timeline line the player may
--- currently see (spoiler-safe), and the RECORD column.
function IMAGO.Chronicle.FillNPCFacts(slug, data)
    if not data then return IMAGO.Chronicle.SetFactsBand(nil) end
    local L = IMAGO.L
    local facts = {}

    -- FACTION comes from the category→crest mapping, GROUP is the category
    -- itself; ROLE is an optional fourth row (kept last so the three
    -- standard rows always read FACTION / GROUP / RACE)
    local crest = FACTION_ICONS[data.category]
    facts[#facts + 1] = { label = L["FACT_FACTION"] or "FACTION",
        text = crest == "Interface\\Timer\\Alliance-Logo" and (L["RACE_ALIGN_ALLIANCE"] or "Alliance")
            or crest == "Interface\\Timer\\Horde-Logo" and (L["RACE_ALIGN_HORDE"] or "Horde")
            or (L["RACE_ALIGN_NEUTRAL"] or "Neutral") }
    if data.category and L[data.category] then
        facts[#facts + 1] = { label = L["FACT_GROUP"] or "GROUP",
            text = L[data.category], nav = "imago-cat:" .. data.category }
    end
    if type(data.race) == "string" and data.race ~= "" then
        local nav
        if data.raceKey and IMAGOdb.races and IMAGOdb.races[data.raceKey] then
            nav = "imago-race:" .. data.raceKey
        end
        facts[#facts + 1] = { label = L["FACT_RACE"] or "RACE", text = data.race, nav = nav }
    end
    if type(data.role) == "string" and data.role ~= "" then
        facts[#facts + 1] = { label = L["FACT_ROLE"] or "ROLE", text = data.role }
    end

    -- Same era scoping + spoiler gate as RenderTimeline: hidden or still
    -- spoiler-protected lines never leak names into the connections
    local texts = { data.lore }
    local npcEra
    for suffix, era in pairs(SLUG_ERA) do
        if slug:sub(-#suffix) == suffix then npcEra = era break end
    end
    local cutoff = npcEra and ERA_ORDER[npcEra] or math.huge
    local spoilerEra = npcEra or "Forever"
    local revealed = (IMAGOSaved.revealedSpoilers or {})[slug]
        or (IMAGOSaved.revealedMidnight and IMAGOSaved.revealedMidnight[slug])
    for _, entry in ipairs(data.timeline or {}) do
        local ord = ERA_ORDER[entry.era]
        if (not ord or ord <= cutoff) and (entry.era ~= spoilerEra or revealed) then
            texts[#texts + 1] = entry.text
        end
    end

    -- RECORD column: discovery stamp (written at real discoveries only);
    -- the zone carries its coordinates alongside in a muted tone
    local stamp = IMAGOSaved.discoveredAt and IMAGOSaved.discoveredAt[slug]
    local zone, coords
    if stamp and stamp.zone and stamp.zone ~= "" then
        zone = stamp.zone
        if stamp.x and stamp.y then
            coords = string.format("%.1f, %.1f", stamp.x * 100, stamp.y * 100)
        end
    end
    local rec = {
        slug = slug,
        date = stamp and stamp.t and date("%d %b %Y", stamp.t) or nil,
        zone = zone,
        coords = coords,
        note = IMAGOSaved.notes and IMAGOSaved.notes[slug] or nil,
    }

    -- outgoing links from the NPC's texts, plus backlink chips for
    -- entries whose texts link back to this NPC
    local refs = IMAGO.TextLinker.FindReferences(texts, { npc = slug })
    local seenRef = {}
    for _, r in ipairs(refs) do seenRef[r.kind .. ":" .. tostring(r.id)] = true end
    for _, r in ipairs(IMAGO.TextLinker.GetBacklinks("npc", slug)) do
        local tag = r.kind .. ":" .. tostring(r.id)
        if not seenRef[tag] then
            seenRef[tag] = true
            refs[#refs + 1] = r
        end
    end
    IMAGO.Chronicle.SetFactsBand(facts, refs, rec)
end

--- Race entry: DOSSIER rows from the overview facts (capital links to its
--- zone record), connections from every race text plus backlinks, and the
--- RECORD column (discovery stamp + personal note, same as fates).
function IMAGO.Chronicle.FillRaceFacts(slug, data, isVisible)
    if not isVisible or not data then return IMAGO.Chronicle.SetFactsBand(nil) end
    local L = IMAGO.L
    local df = data.facts or {}
    -- first implemented settlement doubles as the capital's zone link
    local capNav
    for _, sid in ipairs(data.settlements or {}) do
        if type(sid) == "number" and IMAGOdb.zones and IMAGOdb.zones[sid] then
            capNav = "imago-zone:" .. sid
            break
        end
    end
    -- dossier values stay short: no parentheticals, no ", <descriptor>"
    -- tails — the full wording remains in the overview text and tooltip
    local function TrimFact(key, v)
        v = v:gsub("%s*%b()", "")
        if key == "capital" or key == "leader" then
            local parts = {}
            for seg in v:gmatch("[^;·]+") do
                local s = seg:match("^%s*(.-)%s*$")
                s = s:match("^([^,]+)") or s
                parts[#parts + 1] = s
            end
            v = table.concat(parts, " · ")
        end
        return v
    end
    local FACT_ROWS = {
        { "faction",  "RACE_FACT_FACTION"  },
        { "capital",  "RACE_FACT_CAPITAL"  },
        { "leader",   "RACE_FACT_LEADER"   },
        { "mount",    "RACE_FACT_MOUNT"    },
        { "language", "RACE_FACT_LANGUAGE" },
    }
    local facts = {}
    for _, row in ipairs(FACT_ROWS) do
        local v = df[row[1]]
        if v and v ~= "" then
            facts[#facts + 1] = {
                label = L[row[2]] or row[1]:upper(),
                text = TrimFact(row[1], v),
                nav = (row[1] == "capital") and capNav or nil,
            }
        end
    end

    -- every race text contributes to the outgoing reference scan
    local texts = { data.overview, data.history, data.culture,
        data.relationsIntro, data.groupsIntro, data.groupsFootnote }
    for _, g in pairs(data.groups or {}) do
        if type(g) == "table" and g.lore then texts[#texts + 1] = g.lore end
    end
    if data.relations then
        for _, r in ipairs(data.relations) do
            texts[#texts + 1] = (r.name or "") .. " " .. (r.text or "")
        end
    end
    if data.figureText then
        for _, t in pairs(data.figureText) do
            if t.title then texts[#texts + 1] = t.title end
        end
    end
    if data.settlementText then
        for _, t in pairs(data.settlementText) do
            if t.lore then texts[#texts + 1] = t.lore end
        end
    end

    local stamp = IMAGOSaved.discoveredAt and IMAGOSaved.discoveredAt[slug]
    local zone, coords
    if stamp and stamp.zone and stamp.zone ~= "" then
        zone = stamp.zone
        if stamp.x and stamp.y then
            coords = string.format("%.1f, %.1f", stamp.x * 100, stamp.y * 100)
        end
    end
    local rec = {
        slug = slug,
        date = stamp and stamp.t and date("%d %b %Y", stamp.t) or nil,
        zone = zone,
        coords = coords,
        note = IMAGOSaved.notes and IMAGOSaved.notes[slug] or nil,
    }

    local refs = IMAGO.TextLinker.FindReferences(texts, { race = slug })
    local seenRef = {}
    for _, r in ipairs(refs) do seenRef[r.kind .. ":" .. tostring(r.id)] = true end
    for _, r in ipairs(IMAGO.TextLinker.GetBacklinks("race", slug)) do
        local tag = r.kind .. ":" .. tostring(r.id)
        if not seenRef[tag] then
            seenRef[tag] = true
            refs[#refs + 1] = r
        end
    end
    IMAGO.Chronicle.SetFactsBand(facts, refs, rec)
end

--- Class variant: playable RACES in the dossier, outgoing references +
--- backlinks in connections, discovery stamp + notes in the record column
function IMAGO.Chronicle.FillClassFacts(slug, data)
    if not data then return IMAGO.Chronicle.SetFactsBand(nil) end
    local L = IMAGO.L

    local facts = {}
    local names = {}
    for _, rslug in ipairs(data.races or {}) do
        local rd = IMAGOdb.races and IMAGOdb.races[rslug]
        names[#names + 1] = (rd and rd.name) or rslug
    end
    if #names > 0 then
        facts[#facts + 1] = { label = L["CLASS_FACT_RACES"] or "RACES",
                              text = table.concat(names, " · ") }
    end

    -- every class text contributes to the outgoing reference scan
    local texts = { data.overview, data.history, data.racesIntro,
        data.racesFoot, data.orgsIntro, data.orgsFoot, data.variants }
    for _, e in ipairs(data.raceEntries or {}) do
        texts[#texts + 1] = e.text
    end
    for _, g in pairs(data.groups or {}) do
        if type(g) == "table" and g.lore then texts[#texts + 1] = g.lore end
    end
    if data.figureText then
        for _, t in pairs(data.figureText) do
            if t.title then texts[#texts + 1] = t.title end
        end
    end

    local stamp = IMAGOSaved.discoveredAt and IMAGOSaved.discoveredAt[slug]
    local zone, coords
    if stamp and stamp.zone and stamp.zone ~= "" then
        zone = stamp.zone
        if stamp.x and stamp.y then
            coords = string.format("%.1f, %.1f", stamp.x * 100, stamp.y * 100)
        end
    end
    local rec = {
        slug = slug,
        date = stamp and stamp.t and date("%d %b %Y", stamp.t) or nil,
        zone = zone,
        coords = coords,
        note = IMAGOSaved.notes and IMAGOSaved.notes[slug] or nil,
    }

    local refs = IMAGO.TextLinker.FindReferences(texts, { class = slug })
    local seenRef = {}
    for _, r in ipairs(refs) do seenRef[r.kind .. ":" .. tostring(r.id)] = true end
    for _, r in ipairs(IMAGO.TextLinker.GetBacklinks("class", slug)) do
        local tag = r.kind .. ":" .. tostring(r.id)
        if not seenRef[tag] then
            seenRef[tag] = true
            refs[#refs + 1] = r
        end
    end
    IMAGO.Chronicle.SetFactsBand(facts, refs, rec)
end

-- ============================================================
-- ZONE PAGE: hero banner, Lore | Places sub-tabs, the text column and
-- the side panel (DOSSIER, CONNECTIONS, RECORD)
-- ============================================================

--- Hides everything the zone page adds to the detail pane
function IMAGO.Chronicle.HideZoneDetail()
    local f = IMAGO.Chronicle.frame
    if not f then return end
    if f.zoneSide then f.zoneSide:Hide() end
    if f.zoneHero then f.zoneHero:Hide() end
    if f.zoneTabs then
        f.zoneTabs.lore:Hide()
        f.zoneTabs.poi:Hide()
    end
    if f.infoScroll then f.infoScroll._extraPad = nil end
    f._zonePages = nil
end

-- Alliance / Horde / Neutral label for a faction category (as in the
-- Fates DOSSIER)
local function FactionLabel(category)
    local L = IMAGO.L
    local crest = FACTION_ICONS[category]
    return crest == "Interface\\Timer\\Alliance-Logo" and (L["RACE_ALIGN_ALLIANCE"] or "Alliance")
        or crest == "Interface\\Timer\\Horde-Logo" and (L["RACE_ALIGN_HORDE"] or "Horde")
        or (L["RACE_ALIGN_NEUTRAL"] or "Neutral")
end

-- Continent a zone lies on, read from the client's map hierarchy: it is
-- localized by the client and there is nothing to maintain in the data
local function ZoneRegionName(mapID)
    if not (C_Map and C_Map.GetMapInfo) then return nil end
    local continent = (Enum and Enum.UIMapType and Enum.UIMapType.Continent) or 2
    local id = mapID
    for _ = 1, 8 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if not ok or not info then return nil end
        if id ~= mapID and info.mapType == continent then return info.name end
        id = info.parentMapID
        if not id or id == 0 then return nil end
    end
end

-- Every lowercase name a fate's `zones` entry may use for this zone: the
-- entry's name, its aliases and the client's own (localized) map name
local function ZoneNameSet(mapID, zoneData)
    local set = {}
    local function put(n)
        if type(n) == "string" and n ~= "" then set[n:lower()] = true end
    end
    put(zoneData.name)
    for _, a in ipairs(zoneData.aliases or {}) do put(a) end
    if C_Map and C_Map.GetMapInfo then
        local ok, info = pcall(C_Map.GetMapInfo, mapID)
        if ok and info then put(info.name) end
    end
    return set
end

-- Connections that do not depend on the lore text: the fates whose
-- `zones` list names this zone, then the races that settle here
local function ZoneLinks(mapID, zoneData)
    local names = ZoneNameSet(mapID, zoneData)
    local fates, races = {}, {}
    for _, entries in pairs(IMAGOdb.npcs or {}) do
        if type(entries) == "table" then
            for slug, d in pairs(entries) do
                if type(d) == "table" and type(d.zones) == "table" then
                    for _, zn in ipairs(d.zones) do
                        if type(zn) == "string" and names[zn:lower()] then
                            fates[#fates + 1] = { kind = "npc", id = slug, name = d.name or slug }
                            break
                        end
                    end
                end
            end
        end
    end
    for key, rd in pairs(IMAGOdb.races or {}) do
        for _, id in ipairs(rd.settlements or {}) do
            if id == mapID then
                races[#races + 1] = { kind = "race", id = key, name = rd.name or key }
                break
            end
        end
    end
    -- stable order, whatever pairs() returns
    table.sort(fates, function(a, b) return a.name < b.name end)
    table.sort(races, function(a, b) return a.name < b.name end)
    local out = {}
    for _, r in ipairs(fates) do out[#out + 1] = r end
    for _, r in ipairs(races) do out[#out + 1] = r end
    return out
end

--- Lays the side panel out vertically: DOSSIER rows, CONNECTIONS rows (as
--- many as fit, then "+N more") and the RECORD block pinned to the bottom.
--- facts: { label, text, nav }   refs: TextLinker-style refs
--- rec:   { slug, date, note }
function IMAGO.Chronicle.SetZoneSide(facts, refs, rec)
    local f = IMAGO.Chronicle.frame
    local side, band = f and f.zoneSide, f and f.factsBand
    if not (side and band) then return end
    local L = IMAGO.L
    local items = RefItems(refs)
    local nF, nC = math.min(#facts, 4), #items
    local discN = 0
    for _, it in ipairs(items) do if it.disc then discN = discN + 1 end end

    local imgLeft = (f.detailFrame:GetWidth() - 760) / 2
    local top = f._zoneTop or 232
    side:ClearAllPoints()
    side:SetPoint("TOPRIGHT", f.detailFrame, "TOPRIGHT", -imgLeft, -top)
    side:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -imgLeft, 8)
    local avail = (f.detailFrame:GetHeight() or 0) - top - 8
    if avail < 200 then avail = 320 end

    local PAD, ROW = side.PAD, band.ROW_H
    local inner = ZONE_SIDE_W - 2 * PAD

    -- label column: grown to the longest label, capped
    f.factsMeasure:SetWordWrap(false)
    f.factsMeasure:SetMaxLines(0)
    f.factsMeasure:SetWidth(0)
    f.factsMeasure:SetFont(IMAGO.FONT_BODY, 11)
    local labW = band.LAB_W
    local labels = { L["FACT_DISCOVERED"] or "DISCOVERED" }
    for i = 1, nF do labels[#labels + 1] = facts[i].label or "" end
    for _, t in ipairs(labels) do
        f.factsMeasure:SetText(t)
        labW = math.max(labW, f.factsMeasure:GetStringWidth() + 6)
    end
    labW = math.min(labW, 96)

    for i = 1, 3 do
        side.heads[i]:Hide()
        side.hairs[i]:Hide()
    end
    for _, pool in ipairs({ side.kv, side.rk, side.cx }) do
        for _, r in ipairs(pool) do r:Hide() end
    end
    side.more:Hide()
    side.more._moreList = nil
    side.empty:Hide()
    side.count:Hide()
    for _, b in ipairs(side.acts) do b:Hide() end

    local y = 12

    -- head + hairline of a block; returns the block's top
    local function Head(i, text)
        local h, hr = side.heads[i], side.hairs[i]
        h:SetText(text)
        h:ClearAllPoints()
        h:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -y)
        h:Show()
        hr:ClearAllPoints()
        hr:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -(y + 18))
        hr:SetWidth(inner)
        hr:Show()
        local at = y
        y = y + 26
        return at
    end

    -- label + value row at the current y (the caller advances y)
    local function KVRow(pool, i, label, text, nav, wrap)
        local r = pool[i]
        if not r then r = side.MakeKV() pool[i] = r end
        r.lab:SetText(label)
        r.lab:SetWidth(labW)
        r.val:SetWidth(inner - labW)
        r.val:SetWordWrap(wrap and true or false)
        r.val:SetMaxLines(wrap and 2 or 1)
        r.val:SetText(text)
        r._gold = nav ~= nil
        r._nav = nav
        r._plain = text
        local c = nav and IMAGO_COLORS.GOLD or IMAGO_COLORS.TEXT_PRIMARY
        r.val:SetTextColor(c[1], c[2], c[3])
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -y)
        r:SetWidth(inner)
        r:SetHeight(ROW)
        r:Show()
        return r
    end

    -- DOSSIER: values may wrap to two lines, the next row shifts down
    if nF > 0 then
        Head(1, L["FACT_TITLE"] or "DOSSIER")
        for i = 1, nF do
            local fact = facts[i]
            local r = KVRow(side.kv, i, fact.label, fact.text, fact.nav, true)
            local two = r.val:GetStringHeight() > 16
            r:SetHeight(two and 34 or ROW)
            y = y + (two and 34 or ROW)
        end
        y = y + 8
    end

    -- CONNECTIONS: the RECORD block (pinned to the bottom) is reserved
    -- first, the list gets what is left
    local recH = rec and (26 + ROW + 8 + 24) or 0
    local connTop = Head(2, L["FACT_CONNECTIONS"] or "CONNECTIONS")
    side.count:SetText(discN .. " / " .. nC)
    side.count:ClearAllPoints()
    side.count:SetPoint("TOPRIGHT", side, "TOPLEFT", ZONE_SIDE_W - PAD, -(connTop + 1))
    side.count:Show()
    local room = avail - 10 - (rec and (recH + 12) or 0) - y
    local cap = math.max(1, math.floor(room / ROW))
    local visN = nC
    if nC > cap then visN = math.max(1, cap - 1) end

    if nC == 0 then
        side.empty:SetText(L["FACT_EMPTY"] or "No connections yet")
        side.empty:ClearAllPoints()
        side.empty:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -(y + 2))
        side.empty:Show()
        y = y + ROW
    end
    local nameMax = inner - band.TAG_W - 4 - 6
    for i = 1, visN do
        local it = items[i]
        local r = side.cx[i]
        if not r then r = side.MakeCX() side.cx[i] = r end
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -y)
        r:SetWidth(inner)
        r.tag:SetText(L[TAG_KEY[it.kind] or ""] or (it.kind or "?"):upper())
        r.tag:Show()
        if it.disc then
            r.name:SetText(it.plain)
            r.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            r._gold = true
            r._nav = "imago-" .. it.kind .. ":" .. tostring(it.id)
            r._plain = it.plain
            r.icon:Hide()
        else
            r.name:SetText(L["FACT_UNDISCOVERED"] or "??? Undiscovered")
            r.name:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.7)
            r._gold = false
            r._nav = nil
            r._plain = nil
            r.icon:SetTexture(LOCK_TEX)
            r.icon:SetVertexColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.8)
            r.icon:Show()
        end
        r.name:SetWidth(math.min(r.name:GetStringWidth() + 1, nameMax))
        r.icon:ClearAllPoints()
        r.icon:SetPoint("LEFT", r.name, "RIGHT", 6, 0)
        r:Show()
        y = y + ROW
    end
    if nC > visN then
        local tail = {}
        for i = visN + 1, nC do tail[#tail + 1] = items[i] end
        local r = side.more
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", side, "TOPLEFT", PAD, -y)
        r:SetWidth(inner)
        r.tag:Hide()
        r.name:SetWidth(inner - band.TAG_W - 4)
        r.name:SetText(string.format(L["FACT_MORE_N"] or "+%d more", nC - visN))
        r.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        r._gold = false
        r._nav = nil
        r._plain = nil
        r._moreList = tail
        r.icon:Hide()
        r:Show()
        y = y + ROW
    end

    -- RECORD: discovery date + Notes / Map buttons, pinned to the bottom
    if rec then
        y = math.max(y + 12, avail - 10 - recH)
        Head(3, L["FACT_RECORD"] or "RECORD")
        KVRow(side.rk, 1, L["FACT_DISCOVERED"] or "DISCOVERED", rec.date or "—")
        y = y + ROW + 8
        local bw = (inner - (#side.acts - 1) * 6) / #side.acts
        for i, b in ipairs(side.acts) do
            b:SetWidth(bw)
            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", side, "TOPLEFT", PAD + (i - 1) * (bw + 6), -y)
            b._slug = rec.slug
            b.lab:SetText(L[b._act.label] or "")
            b.lab:SetWidth(bw - 8)
            b.lab:ClearAllPoints()
            b.lab:SetPoint("CENTER", b, "CENTER", 0, 0)
            b.lab:Show()
            b._note = nil
            b.dot:Hide()
            if b._act.key == "notes" and rec.note and rec.note ~= "" then
                b._note = rec.note
                b.dot:ClearAllPoints()
                b.dot:SetPoint("LEFT", b.lab, "RIGHT", 4, 0)
                b.dot:Show()
            end
            b:Show()
        end
    end
    side:Show()
end

--- Facts, connections and record of a zone, shown in the side panel
local function FillZoneFacts(mapID, zoneData)
    local L = IMAGO.L
    local facts = {}
    -- every dossier row is client data (C_Map) or our own data — nothing
    -- is derived or reconstructed from other entries
    local region = ZoneRegionName(mapID)
    if region then
        facts[#facts + 1] = { label = L["FACT_REGION"] or "REGION", text = region }
    end
    if type(zoneData.territory) == "string" then
        facts[#facts + 1] = { label = L["FACT_TERRITORY"] or "TERRITORY",
            text = L["TERRITORY_" .. zoneData.territory:upper()] or zoneData.territory }
    end
    local minL, maxL = zoneData.levelMin, zoneData.levelMax
    if not (minL and maxL) and C_Map and C_Map.GetMapLevels then
        local okL, cMin, cMax = pcall(C_Map.GetMapLevels, mapID)
        if okL and cMin and cMax and cMax > 0 then minL, maxL = cMin, cMax end
    end
    if minL and maxL then
        facts[#facts + 1] = { label = L["FACT_LEVEL"] or "LEVEL",
            text = string.format("%d – %d", minL, maxL) }
    end
    if type(zoneData.changes) == "string" then
        facts[#facts + 1] = { label = L["FACT_CHANGES"] or "CHANGES",
            text = L["CHANGES_" .. zoneData.changes:upper()] or zoneData.changes }
    end

    -- fates and races tied to the zone first, then mentions in its texts
    local texts = { zoneData.lore or "" }
    for _, poi in ipairs(zoneData.pointsOfInterest or {}) do
        texts[#texts + 1] = poi.name or ""
        texts[#texts + 1] = poi.lore or ""
    end
    local refs, seen = {}, {}
    local function add(r)
        local tag = r.kind .. ":" .. tostring(r.id)
        if not seen[tag] then
            seen[tag] = true
            refs[#refs + 1] = r
        end
    end
    for _, r in ipairs(ZoneLinks(mapID, zoneData)) do add(r) end
    for _, r in ipairs(IMAGO.TextLinker.FindReferences(texts, { zone = mapID })) do add(r) end
    for _, r in ipairs(IMAGO.TextLinker.GetBacklinks("zone", mapID)) do add(r) end

    local key = "zone:" .. mapID
    local stamp = IMAGOSaved.zoneDiscoveredAt and IMAGOSaved.zoneDiscoveredAt[mapID]
    IMAGO.Chronicle.SetZoneSide(facts, refs, {
        slug = key,
        date = stamp and stamp.t and date("%d %b %Y", stamp.t) or nil,
        note = IMAGOSaved.notes and IMAGOSaved.notes[key] or nil,
    })
end

--- Switches the zone text between the "lore" and "poi" (Places) pages
function IMAGO.Chronicle.ShowZonePage(page)
    local f = IMAGO.Chronicle.frame
    local pages = f and f._zonePages
    if not pages then return end
    if page == "poi" and not pages.poi then page = "lore" end
    f._zonePage = page

    for key, tab in pairs(f.zoneTabs) do
        local on = key == page
        local c = on and IMAGO_COLORS.GOLD_BRIGHT or IMAGO_COLORS.TEXT_MUTED
        tab.text:SetTextColor(c[1], c[2], c[3])
        tab.activeLine:SetShown(on)
    end

    -- pass mapID as selfMapID so the zone does not link back to itself
    f.loreBody:SetText(WrapGlue(IMAGO.TextLinker.LinkNames(pages[page] or "", nil, pages.mapID, nil, nil)))
    f.loreBody:SetJustifyH("LEFT")
    f.loreBody:Show()
    if f.loreSource then f.loreSource:Hide() end
    f.infoScroll:SetVerticalScroll(0)
    if IMAGO.Chronicle.AdjustInfoScroll then IMAGO.Chronicle.AdjustInfoScroll() end
end

--- Zone page: hero banner on top; below it the text column (with Lore |
--- Places tabs when the zone has points of interest) and the side panel.
function IMAGO.Chronicle.ShowZoneDetail(mapID, zoneData)
    local f = IMAGO.Chronicle.frame
    local imgLeft = (f.detailFrame:GetWidth() - 760) / 2
    local colW = 760 - ZONE_SIDE_W - ZONE_GAP

    -- Hero: the zoneHero frame owns the banner (detailImage stays hidden on
    -- zone pages). Optional zoneData.imageFocus (0..1) picks the crop band.
    local top = 70
    f.detailImage:Hide()
    if f.detailImageBorder then f.detailImageBorder:Hide() end
    local hz = f.zoneHero
    if hz and zoneData.texturePath and zoneData.texturePath ~= "" then
        hz._focus = zoneData.imageFocus or 0.5
        hz:ClearAllPoints()
        hz:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft, -70)
        hz:SetWidth(760)
        hz.tex:SetTexture(zoneData.texturePath)
        hz.tex:SetDesaturated(false)
        hz.tex:SetVertexColor(1, 1, 1, 1)
        -- snap to banner height on open; the hover animation grows it
        hz._cur, hz._target = ZONE_HERO_H, ZONE_HERO_H
        hz:SetFrameLevel(hz._baseLevel)
        hz:SetHeroH(ZONE_HERO_H)
        hz:Show()
        top = 70 + ZONE_HERO_H + 12
    elseif hz then
        hz:Hide()
    end
    if f.detailSeparator then f.detailSeparator:Hide() end
    f._zoneTop = top

    -- pages: lore (gold drop cap, UTF-8 aware) and the points of interest
    local lore = zoneData.lore or ""
    local b1 = string.byte(lore, 1) or 0
    local charLen = b1 >= 240 and 4 or b1 >= 224 and 3 or b1 >= 192 and 2 or 1
    local parts = {}
    for _, poi in ipairs(zoneData.pointsOfInterest or {}) do
        parts[#parts + 1] = "|c" .. IMAGO_HEX.GOLD_BRIGHT .. (poi.name or "") .. "|r\n" .. (poi.lore or "")
    end
    f._zonePages = {
        lore = "|c" .. IMAGO_HEX.GOLD .. lore:sub(1, charLen) .. "|r" .. lore:sub(charLen + 1),
        poi = #parts > 0 and table.concat(parts, "\n\n") or nil,
        mapID = mapID,
    }

    -- sub-tabs only when there is a second page
    local tabs = f.zoneTabs
    local textTop = top
    if f._zonePages.poi then
        tabs.lore:ClearAllPoints()
        tabs.lore:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft + LORE_INSET, -top)
        tabs.poi:ClearAllPoints()
        tabs.poi:SetPoint("TOPLEFT", tabs.lore, "TOPRIGHT", 28, 0)
        tabs.lore:Show()
        tabs.poi:Show()
        textTop = top + 25 + 8
    else
        tabs.lore:Hide()
        tabs.poi:Hide()
    end

    f.infoScroll:ClearAllPoints()
    f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft, -textTop)
    f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMLEFT", imgLeft + colW, 8)
    -- the narrow zone column has no LORE_TEXT_W headroom left, so the text
    -- would run up to the scrollbar; keep an extra 14 px of air on the right
    f.infoScroll._extraPad = 14
    f.infoScroll:Show()

    FillZoneFacts(mapID, zoneData)
    IMAGO.Chronicle.ShowZonePage("lore")
    -- Map shortcut: circular action button top-right, like Retail
    IMAGO.Chronicle.SetDetailAction({
        label   = IMAGO.L["ACTION_OPEN_MAP"] or "World Map",
        tooltip = IMAGO.L["ACTION_OPEN_MAP_TIP"] or "Open this zone on the world map",
        texture = "Interface\\Icons\\icon_treasuremap",
        onClick = function() OpenZoneOnMap(mapID) end,
    })
end

--- Jumps to the Fates sidebar and opens the faction/category group the
--- affiliation link in the DOSSIER column points at.
function IMAGO.Chronicle.FocusCategory(catKey)
    local f = IMAGO.Chronicle.frame
    if not f or not catKey then return end
    if f.activeTabIndex ~= 2 then
        IMAGO.Chronicle.SelectMainTab(2)
    end
    IMAGO.Chronicle.expandedCats = { [catKey] = true }
    IMAGO.Chronicle.UpdateList()
    -- scroll the category header into view once the list is rebuilt
    C_Timer.After(0, function()
        for _, hdr in ipairs(IMAGO.Chronicle.headers or {}) do
            if hdr:IsShown() and hdr.catKey == catKey then
                local _, _, _, _, y = hdr:GetPoint(1)
                if y and f.scrollFrame then
                    f.scrollFrame:SetVerticalScroll(math.max(0, -y - 4))
                end
                break
            end
        end
    end)
end

function IMAGO.Chronicle.UpdateList()
    local f = IMAGO.Chronicle.frame
    if not f then return end
    
    IMAGOSaved.favorites = IMAGOSaved.favorites or {}
    IMAGOSaved.history = IMAGOSaved.history or {}
    IMAGO.Chronicle.zoneButtons = IMAGO.Chronicle.zoneButtons or {}
    
    local locale = GetLocale()
    local activeTab = f.activeTabIndex or 1
    local yOffset = 4

    -- 1. Hide everything to guarantee a clean start
    for _, b in pairs(IMAGO.Chronicle.buttons or {}) do b:Hide() end
    for _, h in pairs(IMAGO.Chronicle.headers or {}) do h:Hide() end
    for _, zb in pairs(IMAGO.Chronicle.zoneButtons or {}) do zb:Hide() end
    for _, fb in pairs(IMAGO.Chronicle.raceButtons or {}) do fb:Hide() end
    for _, cb in pairs(IMAGO.Chronicle.classButtons or {}) do cb:Hide() end
    for _, cb in pairs(IMAGO.Chronicle.codexCatButtons or {}) do cb:Hide() end
    for _, tb in pairs(IMAGO.Chronicle.timelineEraButtons or {}) do tb:Hide() end

    -- ============================================================
    -- CLEANUP: Hides custom buttons before new tabs load
    -- ============================================================
    if f.sidebar.fatesHeader then
        f.sidebar.fatesHeader:Hide()
    end
    if f.sidebar.zonesHeader then
        f.sidebar.zonesHeader:Hide()
    end
    if f.sidebar.racesHeader then
        f.sidebar.racesHeader:Hide()
    end
    if f.sidebar.classesHeader then
        f.sidebar.classesHeader:Hide()
    end
    if f.sidebar.codexHeader then
        f.sidebar.codexHeader:Hide()
    end
    if f.sidebar.timelineHeader then
        f.sidebar.timelineHeader:Hide()
    end

    -- ============================================================
    -- TAB 2: NPCs / FATES
    -- ============================================================
    if activeTab == 2 then
        local searchString = f.searchBox:GetText():lower()
        local activeFilter = f.activeFilter or "ALL"
        
        local total, seen = 0, 0
        for _, entries in pairs(IMAGOdb.npcs) do
            if type(entries) == "table" then
                for slug, _ in pairs(entries) do
                    total = total + 1
                    if IMAGOSaved.seenNPCs[slug] then seen = seen + 1 end
                end
            end
        end

        f.SetSidebarHeader(f.sidebar.fatesHeader, IMAGO.L["SIDEBAR_FATES"] or "FATES",
            string.format("%d / %d", seen, total), total > 0 and seen / total or 0)

        local categories = {}
        
        if activeFilter == "HIST" then
            local histCat = { list = {}, totalCat = 0, seenCat = 0 }
            for _, slug in ipairs(IMAGOSaved.history) do
                local data = IMAGO.GetNPCData(slug)
                if data then
                    local name = data.name or ""
                    if searchString == "" or name:lower():find(searchString) then
                        table.insert(histCat.list, {slug = slug, data = data})
                        histCat.seenCat = histCat.seenCat + 1
                        histCat.totalCat = histCat.totalCat + 1
                    end
                end
            end
            if histCat.totalCat > 0 then
                local histTitle = IMAGO.L["FILTER_HIST"]
                categories[histTitle] = histCat
            end
        else
            for catKey, entries in pairs(IMAGOdb.npcs) do
                if type(entries) == "table" then
                    for slug, data in pairs(entries) do
                        local isSeen = IMAGOSaved.seenNPCs[slug]
                        local name = data.name or ""
                        
                        local matchesSearch = true
                        if searchString ~= "" then
                            local isEncyclopedia = IMAGOSaved.encyclopediaMode
                            if isSeen or isEncyclopedia then
                                if not name:lower():find(searchString) then matchesSearch = false end
                            else
                                local undiscoveredText = (IMAGO.L["UNDISCOVERED"] or "unentdeckt"):lower()
                                if not undiscoveredText:find(searchString) then matchesSearch = false end
                            end
                        end
                        
                        local matchesFilter = true
                        if activeFilter == "FAV" and not IMAGOSaved.favorites[slug] then matchesFilter = false end
                        if activeFilter:find("CAT_") and catKey ~= activeFilter then matchesFilter = false end
                        
                        if matchesSearch and matchesFilter then
                            if not categories[catKey] then 
                                categories[catKey] = { list = {}, totalCat = 0, seenCat = 0 } 
                            end
                            table.insert(categories[catKey].list, {slug = slug, data = data})
                            categories[catKey].totalCat = categories[catKey].totalCat + 1
                            if isSeen then categories[catKey].seenCat = categories[catKey].seenCat + 1 end
                        end
                    end
                end
            end
        end

        local bIdx, hIdx = 1, 1
        
        local sortedCats = {}
        for k in pairs(categories) do table.insert(sortedCats, k) end
        table.sort(sortedCats)

        IMAGO.Chronicle.expandedCats = IMAGO.Chronicle.expandedCats or {}

        for _, catKey in ipairs(sortedCats) do
            local catData = categories[catKey]
            local npcs = catData.list
            local hdr = IMAGO.Chronicle.headers[hIdx]
            
            if not hdr then
                hdr = CreateFrame("Button", nil, f.content)
                hdr:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 26)

                hdr.bg = hdr:CreateTexture(nil, "BACKGROUND")
                hdr.bg:SetAllPoints()
                hdr.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

                local hl = hdr:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                hl:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2), CreateColor(0, 0, 0, 0))

                hdr.icon = hdr:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(hdr.icon, "NAV_ITEM")
                hdr.icon:SetPoint("LEFT", 5, 0)

                hdr.t = hdr:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(hdr.t, "NAV_CATEGORY")
                hdr.t:SetPoint("LEFT", 20, 0)
                hdr.t:SetPoint("RIGHT", hdr, "RIGHT", -10, 0)
                hdr.t:SetJustifyH("LEFT")
                hdr.t:SetWordWrap(false)

                hdr:SetScript("OnEnter", function(self)
                    IMAGO.ShowTooltipIfTruncated(self, self.t)
                end)
                hdr:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                hdr:SetScript("OnClick", function(self)
                    local cat = self.catKey
                    IMAGO.Chronicle.expandedCats[cat] = not IMAGO.Chronicle.expandedCats[cat]
                    if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
                    IMAGO.Chronicle.UpdateList()
                end)

                IMAGO.Chronicle.headers[hIdx] = hdr
            end
            
            hdr.catKey = catKey
            
            if not IMAGO.Chronicle.expandedCats[catKey] then
                hdr.icon:SetText("+")
                hdr.icon:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                hdr.t:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
                hdr.bg:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.3), CreateColor(0, 0, 0, 0))
            else
                hdr.icon:SetText("-")
                hdr.icon:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
                hdr.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                hdr.bg:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2), CreateColor(0, 0, 0, 0))
            end
            
            hdr:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
            local catName = IMAGO.L[catKey] or catKey
            if activeFilter == "HIST" then
                hdr.t:SetText(catName)
            else
                hdr.t:SetText(catName .. " (" .. catData.seenCat .. "/" .. catData.totalCat .. ")")
            end
            hdr:Show()
            
            yOffset = yOffset + 30
            hIdx = hIdx + 1

            if IMAGO.Chronicle.expandedCats[catKey] then
                if activeFilter ~= "HIST" then
                    table.sort(npcs, function(a, b) 
                        return (a.data.name or "") < (b.data.name or "")
                    end)
                end

                for _, npc in ipairs(npcs) do
                    local btn = IMAGO.Chronicle.buttons[bIdx]
                    if not btn then
                        btn = CreateFrame("Button", nil, f.content)
                        btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 35)
                        btn.bg = btn:CreateTexture(nil, "BACKGROUND")
                        btn.bg:SetAllPoints()

                        btn.selected = btn:CreateTexture(nil, "ARTWORK")
                        btn.selected:SetAllPoints()
                        btn.selected:SetColorTexture(IMAGO_COLORS.BG_SELECTED[1], IMAGO_COLORS.BG_SELECTED[2], IMAGO_COLORS.BG_SELECTED[3], 0.3)
                        btn.selected:Hide()

                        btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
                        btn.activeBar:SetWidth(2)
                        btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
                        btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
                        btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
                        btn.activeBar:Hide()

                        local hl = btn:CreateTexture(nil, "HIGHLIGHT")
                        hl:SetAllPoints()
                        hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

                        btn.fav = CreateFrame("Button", nil, btn)
                        btn.fav:SetSize(16, 16)
                        btn.fav:SetPoint("LEFT", btn, "LEFT", 8, 0)
                        btn.fav.icon = btn.fav:CreateTexture(nil, "OVERLAY")
                        btn.fav.icon:SetAllPoints()
                        btn.fav.icon:SetAtlas("collections-icon-favorites")

                        btn.t = btn:CreateFontString(nil, "OVERLAY")
                        IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
                        btn.t:SetPoint("LEFT", btn, "LEFT", 28, 0)
                        btn.t:SetJustifyH("LEFT")
                        btn.t:SetWordWrap(false)

                        btn.newTag = btn:CreateFontString(nil, "OVERLAY")
                        IMAGO.ApplyTextStyle(btn.newTag, "NAV_META", IMAGO_COLORS.GOLD)
                        btn.newTag:SetPoint("RIGHT", btn, "RIGHT", -5, 0)
                        btn.newTag:SetText(IMAGO.L["TAG_NEW"])
                        local ag = btn.newTag:CreateAnimationGroup()
                        local anim = ag:CreateAnimation("Alpha")
                        anim:SetFromAlpha(0.4)
                        anim:SetToAlpha(1.0)
                        anim:SetDuration(1.2)
                        anim:SetOrder(1)
                        ag:SetLooping("BOUNCE")
                        ag:Play()
                        btn.newTagAnim = ag

                        btn:SetScript("OnEnter", function(self)
                            IMAGO.ShowTooltipIfTruncated(self, self.t)
                        end)
                        btn:SetScript("OnLeave", function()
                            GameTooltip:Hide()
                        end)

                        IMAGO.Chronicle.buttons[bIdx] = btn
                    end
                    
                    btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
                    btn.npcSlug = npc.slug
                    btn._listScrollY = yOffset
                    btn.isSeen = IMAGOSaved.seenNPCs[npc.slug]
                    btn.isManual = IMAGOSaved.manualUnlocks and IMAGOSaved.manualUnlocks[npc.slug]
                    btn.isEncyclopedia = IMAGOSaved.encyclopediaMode
                    btn.isVisible = btn.isSeen or btn.isEncyclopedia or btn.isManual
                    btn.name = npc.data.name or ""
                    -- no resting fill: only the selected entry gets a
                    -- surface, hover only while the cursor is over a row
                    btn.bg:SetColorTexture(1, 1, 1, 0)

                    local isSeen = btn.isSeen
                    local isManual = btn.isManual
                    local isEncyclopedia = btn.isEncyclopedia
                    local isVisible = btn.isVisible
                    local hasViewed = IMAGOSaved.viewedNPCs and IMAGOSaved.viewedNPCs[npc.slug]
                    local isFav = IMAGOSaved.favorites and IMAGOSaved.favorites[npc.slug]

                    if isSeen then
                        btn.fav:Show()
                        if isFav then
                            btn.fav.icon:SetDesaturated(false)
                            btn.fav.icon:SetAlpha(1.0)
                        else
                            btn.fav.icon:SetDesaturated(true)
                            btn.fav.icon:SetAlpha(0.3)
                        end

                        btn.fav:SetScript("OnClick", function()
                            IMAGOSaved.favorites[npc.slug] = not IMAGOSaved.favorites[npc.slug]
                            IMAGO.Chronicle.UpdateList()
                        end)
                    else
                        btn.fav:Hide()
                    end

                    btn.t:SetText(isVisible and btn.name or IMAGO.L["UNDISCOVERED"])
                    ApplyNPCButtonNormal(btn)

                    if isSeen and not hasViewed and not isEncyclopedia then
                        btn.newTag:Show()
                    else
                        btn.newTag:Hide()
                    end

                    btn.t:ClearAllPoints()
                    local leftInset = 28
                    local rightInset = btn.newTag:IsShown() and -45 or -10
                    btn.t:SetPoint("LEFT", btn, "LEFT", leftInset, 0)
                    btn.t:SetPoint("RIGHT", btn, "RIGHT", rightInset, 0)

                    if f.selectedNPC and f.selectedNPC == npc.data then
                        ApplyNPCButtonSelected(btn)
                    end
                    
                    btn:SetScript("OnClick", function()
                        local name = btn.name or ""
                        if IsShiftKeyDown() and isVisible then
                            local linkText = string.format("|cFF9370DB[IMAGO: %s]|r", name)
                            local editBox = ChatEdit_ChooseBoxForSend()
                            if editBox then
                                editBox:Show()
                                editBox:SetFocus()
                                editBox:Insert(linkText)
                            end
                            return
                        end

                        f.startPage:Hide()
                        IMAGO.Chronicle.SetFactsBand(nil)
                        if not isNavigatingBack then
                            local entry = nil
                            if f.selectedNPCSlug and f.selectedNPCSlug ~= "" and f.selectedNPCSlug ~= npc.slug then
                                entry = { type = "npc", slug = f.selectedNPCSlug }
                            elseif f.selectedZoneMapID then
                                entry = { type = "zone", mapID = f.selectedZoneMapID }
                            elseif f.selectedRaceSlug then
                                entry = { type = "race", slug = f.selectedRaceSlug }
                            elseif f.selectedClassSlug then
                                entry = { type = "class", slug = f.selectedClassSlug }
                            elseif f.selectedCodexSlug then
                                entry = { type = "codex", slug = f.selectedCodexSlug }
                            elseif f.selectedTimelineSlug then
                                entry = { type = "timeline", slug = f.selectedTimelineSlug }
                            end
                            if entry then
                                table.insert(navStack, entry)
                                if IMAGO.Chronicle.SetBackEnabled then
                                    IMAGO.Chronicle.SetBackEnabled(true)
                                end
                            end
                        end
                        f.selectedZoneMapID = nil
                        f.selectedRaceSlug = nil
                        f.selectedClassSlug = nil
                        f.selectedCodexSlug = nil
                        f.selectedTimelineSlug = nil
                        f.selectedTimelineEra = nil

                        f.selectedNPC = npc.data
                        f.selectedNPCSlug = npc.slug
                        IMAGO.Chronicle.RememberViewed(2, npc.slug)
                        
                        for _, b in pairs(IMAGO.Chronicle.buttons) do
                            if b ~= btn then ApplyNPCButtonNormal(b) end
                        end
                        ApplyNPCButtonSelected(btn)
                        
                        if isVisible then
                            f.hintPage:Hide()
                            if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
                if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
                if f.classIcon then f.classIcon:Hide() end
                if f.classEmblemBox then f.classEmblemBox:Hide() end
                            if f.raceContainer then f.raceContainer:Hide() end
                            if f.classContainer then f.classContainer:Hide() end
                            if f.raceEmblemBox then f.raceEmblemBox:Hide() end
        if f.raceZoneImage then f.raceZoneImage:Hide() end
        if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end

                            local function OpenLoreTab()
                                f.detailTitle:Show()
                                f.detailLineLeft:Show()
                                f.detailLineRight:Show()
                                f.tabLore:Show()
                                f.tabTime:Show()
                                f.infoScroll:Show()
                                f.detailModel._inStage = true
                                f.detailModel:Show()
                                -- clear race-mode leftovers on the shared model
                                -- column: captions + second model belong to the
                                -- race tabs; the emote bar belongs to the stage
                                if f.detailModelCap then f.detailModelCap:Hide() end
                                if f.detailModel2Cap then f.detailModel2Cap:Hide() end
                                if f.detailModel2 then f.detailModel2:Hide() end
                                if f.detailModel.animButtons then
                                    for _, b in ipairs(f.detailModel.animButtons) do b:Show() end
                                end

                                local cat = npc.data.category or ""
                                local factionTex = FACTION_ICONS[cat]
                                if factionTex then
                                    f.factionIcon:SetTexture(factionTex)
                                    f.factionIcon:Show()
                                else
                                    f.factionIcon:Hide()
                                end

                                f.detailTitle:SetText(name)
                                f.detailTitle:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

                                local lore = npc.data.lore or ""
                                local firstByte = string.byte(lore, 1)
                                local charLen = firstByte >= 192 and 2 or 1  -- UTF-8: 2 bytes if >= 0xC0
                                local firstLetter = lore:sub(1, charLen)
                                local restLore = lore:sub(charLen + 1)
                                -- Pass selfSlug so the NPC doesn't link their own name,
                                local linked = IMAGO.TextLinker.LinkNames("|c" .. IMAGO_HEX.GOLD .. firstLetter .. "|r" .. restLore,
                                    npc.slug,
                                    nil, nil, nil
                                )
                                
                                -- display only: a blank line between paragraphs
                                f.loreBody:SetText(WrapGlue((linked:gsub("\n+", "\n\n"))))
                                f.loreBody:SetJustifyH("LEFT")
                                IMAGO.Chronicle.FillNPCFacts(npc.slug, npc.data)

                                local source = npc.data.source
                                if source and source ~= "" then
                                    local fmt = IMAGO.L["LORE_AUTHOR"] or "Written by %s"
                                    f.loreSource:SetText(string.format(fmt, source))
                                else
                                    f.loreSource:Hide()
                                end

                                f.detailModel:ClearModel()
                                local modelID, isDisplay = GetValidModelID(npc.data)
                                if modelID then 
                                    LoadModelCreature(f.detailModel, modelID, isDisplay, function(mdl)
                                        mdl:SetAnimation(0)
                                        if mdl.UpdateAnimButtons then mdl.UpdateAnimButtons(0) end
                                    end)
                                end
                                
                                f.detailModel.zoomLevel = 1.0
                                f.detailModel.posX = 0
                                f.detailModel.posY = 0
                                f.detailModel.posZ = 0
                                f.detailModel:SetCamDistanceScale(1.0)
                                f.detailModel:SetPosition(0, 0, 0)
                                f.detailModel:SetFacing(0)
                                
                                btn.newTag:Hide()
                                f.ShowTab("lore")

                                -- Encounter Journal action button
                                local raidID = npc.data.raidEncounterID
                                local dungeonID = npc.data.dungeonEncounterID
                                local encounterID = npc.data.encounter_journal_id
                                
                                if encounterID then
                                    IMAGO.Chronicle.SetDetailAction({
                                        tooltip = IMAGO.L["ACTION_OPEN_EJ"] or "Open in Encounter Journal",
                                        texture = "Interface\\Icons\\inv_misc_book_07",
                                        onClick = function()
                                            f:Hide()
                                            local name, desc, jEncID, rootSectionID, journalLink, journalInstanceID, _, _ = EJ_GetEncounterInfo(encounterID)

                                            if C_AddOns and C_AddOns.LoadAddOn then
                                                C_AddOns.LoadAddOn("Blizzard_EncounterJournal")
                                            end
                                            local _, _, _, _, _, _, _, _, _, _, _, isRaid = EJ_GetInstanceInfo(journalInstanceID)
                                            local difficulty = isRaid and 15 or 2
                                            if EncounterJournal_OpenJournal then
                                                EJ_SetDifficulty(difficulty)
                                                EncounterJournal_OpenJournal(difficulty, journalInstanceID, encounterID)
                                            end
                                        end,
                                    })
                                else
                                    IMAGO.Chronicle.SetDetailAction(nil)
                                end
                                
                            end         
                            IMAGOSaved.viewedNPCs = IMAGOSaved.viewedNPCs or {}
                            if isSeen and not IMAGOSaved.viewedNPCs[npc.slug] then
                                IMAGOSaved.viewedNPCs[npc.slug] = true
                                f.detailTitle:Hide()
                                f.detailLineLeft:Hide()
                                f.detailLineRight:Hide()
                                f.tabLore:Hide()
                                f.tabTime:Hide()
                                f.infoScroll:Hide()
                                f.detailModel:Hide()

                                if f.detailModel2 then f.detailModel2:Hide() end
                                f.factionIcon:Hide()
                                IMAGO.Chronicle.ShowCinematic(npc.data, OpenLoreTab)
                            else
                                OpenLoreTab()
                            end
                        else
                            f.tabLore:Hide()
                            f.tabTime:Hide()
                            f.infoScroll:Hide()
                            f.detailModel:Hide()

                            if f.detailModel2 then f.detailModel2:Hide() end
                            f.factionIcon:Hide()
                            f.detailTitle:Show()
                            f.detailLineLeft:Show()
                            f.detailLineRight:Show()
                            f.hintPage:Show()
                            
                            -- NPC PHANTOM: re-enable aura and reset icon
                            IMAGO.Chronicle.SetDetailAction(nil)
                            f.hintPage.aura:Show() -- THIS IS WHERE IT GETS RE-ENABLED!
                            f.hintPage.warning:SetText(IMAGO.L["HINT_IDENTITY_HIDDEN"] or "IDENTITÄT VERBORGEN")
                            f.hintPage.icon:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\undiscovered.tga")
                            f.hintPage.icon:SetTexCoord(0, 1, 0, 1)
                            
                            f.detailTitle:SetText(GetCrypticName(name))
                            f.detailTitle:SetTextColor(0.4, 0.3, 0.5, 0.9) 
                            
                            local localZones = npc.data.zones
                            if localZones and #localZones > 0 then
                                local zoneStr = table.concat(localZones, ", ")
                                f.hintPage.desc:SetText(string.format(IMAGO.L["HINT_SCOUTS"], zoneStr))
                            else
                                f.hintPage.desc:SetText(IMAGO.L["HINT_UNKNOWN_LOC"])
                            end
                        end
                    end)

                    btn:SetScript("OnMouseUp", function(self, mouseBtn)
                        if mouseBtn == "RightButton" and not isSeen and not isEncyclopedia then
                            if isManual then
                                IMAGOSaved.manualUnlocks[npc.slug] = nil
                                IMAGO.Chronicle.UpdateList()
                            else
                                f.ShowConfirm(
                                    IMAGO.L["CONFIRM_UNLOCK_TITLE"],
                                    IMAGO.L["CONFIRM_UNLOCK_DESC"],
                                    function()
                                        IMAGOSaved.manualUnlocks = IMAGOSaved.manualUnlocks or {}
                                        IMAGOSaved.manualUnlocks[npc.slug] = true
                                        IMAGO.Chronicle.UpdateList()
                                    end
                                )
                            end
                        end
                    end)
                    
                    btn:Show()
                    yOffset = yOffset + 35
                    bIdx = bIdx + 1
                end 
            end 
        end 

    f.content:SetHeight(math.max(1, yOffset))
    IMAGO.UpdateScrollBarVisibility(f.scrollFrame)

    -- ============================================================
    -- TAB 3: ZONES OF MEMORY
    -- ============================================================
    elseif activeTab == 3 then
        if f.sidebar.zonesHeader then f.sidebar.zonesHeader:Show() end
        local zIdx = 1
        local totalZones, seenZones = 0, 0

        for mapID, zdata in pairs(IMAGOdb.zones or {}) do
            totalZones = totalZones + 1
            if IMAGOSaved.seenZones[mapID] then seenZones = seenZones + 1 end
        end

        f.SetSidebarHeader(f.sidebar.zonesHeader, IMAGO.L["SIDEBAR_ZONES"] or "ZONES",
            string.format("%d / %d", seenZones, totalZones), totalZones > 0 and seenZones / totalZones or 0)

        local sortedZones = {}
        for mapID, data in pairs(IMAGOdb.zones or {}) do
            table.insert(sortedZones, {id = mapID, data = data})
        end
        table.sort(sortedZones, function(a, b)
            return (a.data.name or "") < (b.data.name or "")
        end)

    for _, zoneObj in ipairs(sortedZones) do
        local mapID = zoneObj.id
        local zoneData = zoneObj.data
        local isSeen = IMAGOSaved.seenZones[mapID]
        local isEncyclopedia = IMAGOSaved.encyclopediaMode
        local isManual = IMAGOSaved.manualZoneUnlocks and IMAGOSaved.manualZoneUnlocks[mapID]
        local isZoneVisible = isSeen or isEncyclopedia or isManual
        local name = zoneData.name or ""

        local btn = IMAGO.Chronicle.zoneButtons[zIdx]
        if not btn then
            btn = CreateFrame("Button", nil, f.content)
            btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 60)

            btn.bg = btn:CreateTexture(nil, "BACKGROUND")
            btn.bg:SetAllPoints()

            btn.overlay = btn:CreateTexture(nil, "ARTWORK")
            btn.overlay:SetAllPoints()
            btn.overlay:SetColorTexture(0, 0, 0, 0.6)

            btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
            btn.activeBar:SetWidth(2)
            btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
            btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
            btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            btn.activeBar:Hide()

            local hl = btn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

            btn.t = btn:CreateFontString(nil, "OVERLAY")
            IMAGO.ApplyTextStyle(btn.t, "ZONE_ITEM")
            btn.t:SetPoint("LEFT", 15, 0)
            btn.t:SetPoint("RIGHT", btn, "RIGHT", -10, 0)
            btn.t:SetJustifyH("LEFT")
            btn.t:SetWordWrap(false)

            btn:SetScript("OnEnter", function(self)
                IMAGO.ShowTooltipIfTruncated(self, self.t)
            end)
            btn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            IMAGO.Chronicle.zoneButtons[zIdx] = btn
        end

        btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
        btn.mapID = mapID
        btn.zoneMapID = mapID
        btn._listScrollY = yOffset
        btn.isSeen = isSeen
        btn.isEncyclopedia = isEncyclopedia
        btn.isManual = isManual
        btn.isVisible = isZoneVisible
        btn.name = name
        btn.texturePath = zoneData and zoneData.texturePath
        btn.unknownName = IMAGO.L["ZONE_UNKNOWN_NAME"] or "Unbekannte Region"

        if isZoneVisible then
            ApplyZoneEntryNormal(btn, isManual)

            btn:SetScript("OnClick", function()
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end

                for _, zb in pairs(IMAGO.Chronicle.zoneButtons or {}) do
                    if zb ~= btn then ApplyZoneEntryNormal(zb) end
                end
                ApplyZoneEntrySelected(btn)

                if not isNavigatingBack then
                    local entry = nil
                    if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
                        entry = { type = "npc", slug = f.selectedNPCSlug }
                    elseif f.selectedZoneMapID and f.selectedZoneMapID ~= mapID then
                        entry = { type = "zone", mapID = f.selectedZoneMapID }
                    elseif f.selectedRaceSlug then
                        entry = { type = "race", slug = f.selectedRaceSlug }
                    elseif f.selectedClassSlug then
                        entry = { type = "class", slug = f.selectedClassSlug }
                    elseif f.selectedCodexSlug then
                        entry = { type = "codex", slug = f.selectedCodexSlug }
                    elseif f.selectedTimelineSlug then
                        entry = { type = "timeline", slug = f.selectedTimelineSlug }
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end
                f.selectedNPCSlug = nil
                f.selectedRaceSlug = nil
                f.selectedClassSlug = nil
                f.selectedCodexSlug = nil
                f.selectedTimelineSlug = nil
                f.selectedTimelineEra = nil
                f.selectedZoneMapID = mapID
                IMAGO.Chronicle.RememberViewed(3, mapID)

                f.startPage:Hide()
                IMAGO.Chronicle.SetFactsBand(nil)
                f.hintPage:Hide()
                f.tabLore:Hide()
                f.tabTime:Hide()
                f.detailModel:Hide()

                if f.detailModel2 then f.detailModel2:Hide() end
                f.factionIcon:Hide()
                if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
                if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
                if f.classIcon then f.classIcon:Hide() end
                if f.classEmblemBox then f.classEmblemBox:Hide() end
                if f.raceContainer then f.raceContainer:Hide() end
                if f.classContainer then f.classContainer:Hide() end
                if f.raceEmblemBox then f.raceEmblemBox:Hide() end
                if f.raceZoneImage then f.raceZoneImage:Hide() end
                if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end
                if f.timelineContainer then f.timelineContainer:Hide() end

                f.detailTitle:Show()
                f.detailLineLeft:Show()
                f.detailLineRight:Show()
                f.detailTitle:SetText(name)
                f.detailTitle:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

                IMAGO.Chronicle.ShowZoneDetail(mapID, zoneData)
                end
            )

            btn:SetScript("OnMouseUp", function(self, mouseBtn)
                if mouseBtn == "RightButton" and not isSeen and not isEncyclopedia then
                    if isManual then
                        IMAGOSaved.manualZoneUnlocks[mapID] = nil
                        IMAGO.Chronicle.UpdateList()
                    else
                        f.ShowConfirm(
                            IMAGO.L["CONFIRM_UNLOCK_TITLE"],
                            IMAGO.L["CONFIRM_UNLOCK_DESC"],
                            function()
                                IMAGOSaved.manualZoneUnlocks = IMAGOSaved.manualZoneUnlocks or {}
                                IMAGOSaved.manualZoneUnlocks[mapID] = true
                                IMAGO.Chronicle.UpdateList()
                            end
                        )
                    end
                end
            end)
        else
            ApplyZoneEntryNormal(btn)

            btn:SetScript("OnClick", function()
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end

                for _, zb in pairs(IMAGO.Chronicle.zoneButtons or {}) do
                    if zb ~= btn then ApplyZoneEntryNormal(zb) end
                end
                ApplyZoneEntrySelected(btn)

                if not isNavigatingBack then
                    local entry = nil
                    if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
                        entry = { type = "npc", slug = f.selectedNPCSlug }
                    elseif f.selectedZoneMapID and f.selectedZoneMapID ~= mapID then
                        entry = { type = "zone", mapID = f.selectedZoneMapID }
                    elseif f.selectedRaceSlug then
                        entry = { type = "race", slug = f.selectedRaceSlug }
                    elseif f.selectedClassSlug then
                        entry = { type = "class", slug = f.selectedClassSlug }
                    elseif f.selectedCodexSlug then
                        entry = { type = "codex", slug = f.selectedCodexSlug }
                    elseif f.selectedTimelineSlug then
                        entry = { type = "timeline", slug = f.selectedTimelineSlug }
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end
                f.selectedNPCSlug = nil
                f.selectedRaceSlug = nil
                f.selectedClassSlug = nil
                f.selectedCodexSlug = nil
                f.selectedTimelineSlug = nil
                f.selectedTimelineEra = nil
                f.selectedZoneMapID = mapID
                IMAGO.Chronicle.RememberViewed(3, mapID)

                f.startPage:Hide()
                IMAGO.Chronicle.SetFactsBand(nil)
                f.hintPage:Hide()
                f.tabLore:Hide()
                f.tabTime:Hide()
                f.detailModel:Hide()

                if f.detailModel2 then f.detailModel2:Hide() end
                f.factionIcon:Hide()
                if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
                if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
                if f.classIcon then f.classIcon:Hide() end
                if f.classEmblemBox then f.classEmblemBox:Hide() end
                if f.raceContainer then f.raceContainer:Hide() end
                if f.classContainer then f.classContainer:Hide() end
                if f.raceEmblemBox then f.raceEmblemBox:Hide() end
                if f.raceZoneImage then f.raceZoneImage:Hide() end
                if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end
                if f.timelineContainer then f.timelineContainer:Hide() end

                f.detailLineLeft:Hide()
                f.detailLineRight:Hide()
                if f.detailImageBorder then f.detailImageBorder:Hide() end
                if f.detailSeparator then f.detailSeparator:Hide() end

                f.detailTitle:Show()
                IMAGO.Chronicle.SetDetailAction(nil)
                f.detailTitle:SetText(IMAGO.L["ZONE_UNDISCOVERED"] or "Unentdeckt")
                f.detailTitle:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        

                if f.detailImage then
                    f.detailImage:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\worldmap.tga")
                    f.detailImage:SetDesaturated(true)
                    f.detailImage:SetVertexColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.8)
                    f.detailImage:SetSize(760, 400)
                    f.detailImage:SetTexCoord(0, 1, 0, 1)
                    f.detailImage:Show()
                end

                local warningHeader = "\n\n|c" .. IMAGO_HEX.TEXT_SECONDARY .. (IMAGO.L["ZONE_UNEXPLORED_HEADER"] or "GEBIET UNERKUNDET") .. "|r"
                local descText = "\n\n|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["ZONE_UNEXPLORED_DESC"] or "Die Kartographie dieser Region ist noch unvollständig.\nReise dorthin, um ihre Geheimnisse zu offenbaren.") .. "|r"
                -- Pass mapID as selfMapID so undiscovered zone page doesn’t self-link
                f.loreBody:SetText(WrapGlue(IMAGO.TextLinker.LinkNames(warningHeader .. descText, nil, mapID, nil, nil)))
                f.loreBody:SetJustifyH("CENTER")
                f.loreBody:Show()
                if f.loreSource then f.loreSource:Hide() end

                local imgLeft = (f.detailFrame:GetWidth() - 760) / 2
                f.infoScroll:ClearAllPoints()
                f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft, -470)
                f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMLEFT", imgLeft + 760, f._infoBottom or 100)
                f.infoScroll:Show()
                f.infoScroll:SetVerticalScroll(0)
                if IMAGO.Chronicle.AdjustInfoScroll then IMAGO.Chronicle.AdjustInfoScroll() end
            end)

            btn:SetScript("OnMouseUp", function(self, mouseBtn)
                if mouseBtn == "RightButton" and not isSeen and not isEncyclopedia then
                    f.ShowConfirm(
                        IMAGO.L["CONFIRM_UNLOCK_TITLE"],
                        IMAGO.L["CONFIRM_UNLOCK_DESC"],
                        function()
                            IMAGOSaved.manualZoneUnlocks = IMAGOSaved.manualZoneUnlocks or {}
                            IMAGOSaved.manualZoneUnlocks[mapID] = true
                            IMAGO.Chronicle.UpdateList()
                        end
                    )
                end
            end)
        end

        btn:Show()
        yOffset = yOffset + 65
        zIdx = zIdx + 1
    end

    f.content:SetHeight(math.max(1, yOffset))
    IMAGO.UpdateScrollBarVisibility(f.scrollFrame)

    -- ============================================================
    -- TAB 4: RACES
    -- ============================================================
    elseif activeTab == 4 then
        if f.sidebar.racesHeader then f.sidebar.racesHeader:Show() end
        IMAGOSaved.seenRaces = IMAGOSaved.seenRaces or {}
        IMAGOSaved.viewedRaces = IMAGOSaved.viewedRaces or {}
        IMAGOSaved.manualRaceUnlocks = IMAGOSaved.manualRaceUnlocks or {}

        local totalRaces, seenRaces = 0, 0
        for slug, _ in pairs(IMAGOdb.races or {}) do
            totalRaces = totalRaces + 1
            if IMAGOSaved.seenRaces[slug] then seenRaces = seenRaces + 1 end
        end

        f.SetSidebarHeader(f.sidebar.racesHeader, IMAGO.L["SIDEBAR_RACES"] or "RACES",
            string.format("%d / %d", seenRaces, totalRaces), totalRaces > 0 and seenRaces / totalRaces or 0)

        local searchString = f.searchBox:GetText():lower()
        local activeFilter = f.activeFilter or "ALL"

        local sortedRaces = {}
        for slug, data in pairs(IMAGOdb.races or {}) do
            local name = data.name or slug
            local isSeen = IMAGOSaved.seenRaces[slug]
            local isEncyclopedia = IMAGOSaved.encyclopediaMode
            local isManual = IMAGOSaved.manualRaceUnlocks[slug]
            local isVisible = isSeen or isEncyclopedia or isManual

            local matchesSearch = true
            if searchString ~= "" then
                if isVisible then
                    if not name:lower():find(searchString) then matchesSearch = false end
                else
                    local undiscoveredText = (IMAGO.L["UNDISCOVERED"] or "undiscovered"):lower()
                    if not undiscoveredText:find(searchString) then matchesSearch = false end
                end
            end

            local matchesFilter = true
            if activeFilter ~= "ALL" and not activeFilter:find("CAT_") then
                if data.alignment == "Both" then
                    if activeFilter == "Neutral" then matchesFilter = false end
                elseif data.alignment ~= activeFilter then
                    matchesFilter = false
                end
            end

            if matchesSearch and matchesFilter then
                table.insert(sortedRaces, {slug = slug, data = data, isVisible = isVisible, isSeen = isSeen, isManual = isManual})
            end
        end
        table.sort(sortedRaces, function(a, b)
            if a.isVisible ~= b.isVisible then return a.isVisible end
            return (a.data.name or a.slug) < (b.data.name or b.slug)
        end)

        IMAGO.Chronicle.raceButtons = IMAGO.Chronicle.raceButtons or {}
        local rIdx = 1
        for _, race in ipairs(sortedRaces) do
            local btn = IMAGO.Chronicle.raceButtons[rIdx]
            if not btn then
                btn = CreateFrame("Button", nil, f.content)
                btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 35)

                btn.bg = btn:CreateTexture(nil, "BACKGROUND")
                btn.bg:SetAllPoints()

                btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
                btn.activeBar:SetWidth(2)
                btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
                btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
                btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
                btn.activeBar:Hide()

                local hl = btn:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

                btn.crest = btn:CreateTexture(nil, "ARTWORK")
                btn.crest:SetSize(20, 20)
                btn.crest:SetPoint("LEFT", btn, "LEFT", 8, 0)

                btn.t = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
                btn.t:SetPoint("LEFT", btn, "LEFT", 34, 0)
                btn.t:SetPoint("RIGHT", btn, "RIGHT", -10, 0)
                btn.t:SetJustifyH("LEFT")
                btn.t:SetWordWrap(false)

                btn.newTag = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.newTag, "NAV_META", IMAGO_COLORS.GOLD)
                btn.newTag:SetPoint("RIGHT", btn, "RIGHT", -5, 0)
                btn.newTag:SetText(IMAGO.L["TAG_NEW"])

                btn:SetScript("OnEnter", function(self)
                    IMAGO.ShowTooltipIfTruncated(self, self.t)
                end)
                btn:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                IMAGO.Chronicle.raceButtons[rIdx] = btn
            end

            btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
            btn.raceSlug = race.slug
            btn._listScrollY = yOffset
            btn.isSeen = race.isSeen
            btn.isManual = race.isManual
            btn.isEncyclopedia = IMAGOSaved.encyclopediaMode
            btn.isVisible = race.isVisible
            btn._zebra = (rIdx % 2 == 0)
            btn.bg:SetColorTexture(1, 1, 1, (btn._zebra and 0.03) or 0)

            local raceData = race.data
            local displayName = race.isVisible and (raceData.name or race.slug) or GetCrypticName(raceData.name or race.slug)

            local isDual = (raceData.alignment == "Both")
            local crest = RACE_ALIGN_ICONS[isDual and "Alliance" or raceData.alignment]
            if crest then
                if isDual then
                    if not btn.crest2 then
                        btn.crest2 = btn:CreateTexture(nil, "ARTWORK")
                        btn.crest2:SetSize(14, 14)
                        btn.crest2:SetPoint("LEFT", btn, "LEFT", 21, 0)
                    end
                    btn.crest:SetSize(14, 14)
                    btn.crest:ClearAllPoints()
                    btn.crest:SetPoint("LEFT", btn, "LEFT", 5, 0)
                    btn.crest2:SetTexture(RACE_ALIGN_ICONS.Horde)
                    btn.crest2:SetDesaturated(not race.isVisible)
                    btn.crest2:Show()
                else
                    if btn.crest2 then btn.crest2:Hide() end
                    btn.crest:SetSize(20, 20)
                    btn.crest:ClearAllPoints()
                    btn.crest:SetPoint("LEFT", btn, "LEFT", 8, 0)
                end
                btn.crest:SetTexture(crest)
                btn.crest:SetDesaturated(not race.isVisible)
                btn.crest:Show()
            else
                btn.crest:Hide()
                if btn.crest2 then btn.crest2:Hide() end
            end

            if race.isVisible then
                btn.t:SetText(displayName)
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
            else
                btn.t:SetText(displayName)
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
            end

            local hasViewed = IMAGOSaved.viewedRaces[race.slug]
            if race.isSeen and not hasViewed and not btn.isEncyclopedia then
                btn.newTag:Show()
            else
                btn.newTag:Hide()
            end

            if f.selectedRaceSlug == race.slug then
                btn.activeBar:Show()
                btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            else
                btn.activeBar:Hide()
            end

            btn:SetScript("OnClick", function(self)
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end

                for _, fb in pairs(IMAGO.Chronicle.raceButtons or {}) do
                    if fb ~= self then
                        if fb.activeBar then fb.activeBar:Hide() end
                    end
                end
                self.activeBar:Show()

                if not isNavigatingBack then
                    local entry = nil
                    if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
                        entry = { type = "npc", slug = f.selectedNPCSlug }
                    elseif f.selectedZoneMapID then
                        entry = { type = "zone", mapID = f.selectedZoneMapID }
                    elseif f.selectedRaceSlug and f.selectedRaceSlug ~= self.raceSlug then
                        entry = { type = "race", slug = f.selectedRaceSlug }
                    elseif f.selectedClassSlug then
                        entry = { type = "class", slug = f.selectedClassSlug }
                    elseif f.selectedCodexSlug then
                        entry = { type = "codex", slug = f.selectedCodexSlug }
                    elseif f.selectedTimelineSlug then
                        entry = { type = "timeline", slug = f.selectedTimelineSlug }
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end
                f.selectedNPCSlug = nil
                f.selectedZoneMapID = nil
                f.selectedClassSlug = nil
                f.selectedCodexSlug = nil
                f.selectedTimelineSlug = nil
                f.selectedTimelineEra = nil
                f.selectedRace = self._raceData
                f.selectedRaceSlug = self.raceSlug
                IMAGO.Chronicle.RememberViewed(4, self.raceSlug)
                f.activeRaceTab = f.activeRaceTab or "overview"

                IMAGOSaved.viewedRaces[self.raceSlug] = true
                self.newTag:Hide()

                IMAGO.Chronicle.RenderRace(self.raceSlug, self._raceData, self.isVisible)
            end)

            btn._raceData = raceData

            btn:SetScript("OnMouseUp", function(self, mouseBtn)
                if mouseBtn == "RightButton" and not self.isSeen and not self.isEncyclopedia then
                    if self.isManual then
                        IMAGOSaved.manualRaceUnlocks[self.raceSlug] = nil
                        IMAGO.Chronicle.UpdateList()
                    else
                        f.ShowConfirm(
                            IMAGO.L["CONFIRM_UNLOCK_TITLE"],
                            IMAGO.L["CONFIRM_UNLOCK_DESC"],
                            function()
                                IMAGOSaved.manualRaceUnlocks = IMAGOSaved.manualRaceUnlocks or {}
                                IMAGOSaved.manualRaceUnlocks[self.raceSlug] = true
                                IMAGO.Chronicle.UpdateList()
                            end
                        )
                    end
                end
            end)

            btn:Show()
            yOffset = yOffset + 35
            rIdx = rIdx + 1
        end

        for i = rIdx, #IMAGO.Chronicle.raceButtons do
            IMAGO.Chronicle.raceButtons[i]:Hide()
        end

        f.content:SetHeight(math.max(1, yOffset))
        IMAGO.UpdateScrollBarVisibility(f.scrollFrame)

    -- ============================================================
    -- TAB 5: CLASSES (skeleton — all visible, placeholder content)
    -- ============================================================
    elseif activeTab == 5 then
        if f.sidebar.classesHeader then f.sidebar.classesHeader:Show() end
        IMAGOSaved.seenClasses = IMAGOSaved.seenClasses or {}
        IMAGOSaved.viewedClasses = IMAGOSaved.viewedClasses or {}
        IMAGOSaved.manualClassUnlocks = IMAGOSaved.manualClassUnlocks or {}

        local totalClasses, seenClasses = 0, 0
        for slug, _ in pairs(IMAGOdb.classes or {}) do
            totalClasses = totalClasses + 1
            if IMAGOSaved.seenClasses[slug] then seenClasses = seenClasses + 1 end
        end

        f.SetSidebarHeader(f.sidebar.classesHeader, IMAGO.L["SIDEBAR_CLASSES"] or "CLASSES",
            string.format("%d / %d", seenClasses, totalClasses), totalClasses > 0 and seenClasses / totalClasses or 0)

        local searchString = f.searchBox:GetText():lower()

        local classOrder = {"warrior", "paladin", "hunter", "rogue", "priest", "shaman", "mage", "warlock", "druid"}
        local sortedClasses = {}
        for _, slug in ipairs(classOrder) do
            local data = IMAGOdb.classes and IMAGOdb.classes[slug]
            if data then
                local name = data.name or slug
                local isSeen = IMAGOSaved.seenClasses[slug]
                local isManual = IMAGOSaved.manualClassUnlocks[slug]
                local isVisible = isSeen or isManual or IMAGOSaved.encyclopediaMode
                local matchesSearch = true
                if searchString ~= "" then
                    if isVisible then
                        if not name:lower():find(searchString) then matchesSearch = false end
                    else
                        local undiscoveredText = (IMAGO.L["UNDISCOVERED"] or "undiscovered"):lower()
                        if not undiscoveredText:find(searchString) then matchesSearch = false end
                    end
                end
                if matchesSearch then
                    table.insert(sortedClasses, {slug = slug, data = data,
                        isVisible = isVisible, isSeen = isSeen, isManual = isManual})
                end
            end
        end
        table.sort(sortedClasses, function(a, b)
            if a.isVisible ~= b.isVisible then return a.isVisible end
            return (a.data.name or a.slug) < (b.data.name or b.slug)
        end)

        IMAGO.Chronicle.classButtons = IMAGO.Chronicle.classButtons or {}
        local cIdx = 1
        for _, cls in ipairs(sortedClasses) do
            local btn = IMAGO.Chronicle.classButtons[cIdx]
            if not btn then
                btn = CreateFrame("Button", nil, f.content)
                btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 35)

                btn.bg = btn:CreateTexture(nil, "BACKGROUND")
                btn.bg:SetAllPoints()

                btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
                btn.activeBar:SetWidth(2)
                btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
                btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
                btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
                btn.activeBar:Hide()

                local hl = btn:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

                btn.icon = btn:CreateTexture(nil, "ARTWORK")
                btn.icon:SetSize(20, 20)
                btn.icon:SetPoint("LEFT", btn, "LEFT", 8, 0)

                btn.t = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
                btn.t:SetPoint("LEFT", btn, "LEFT", 34, 0)
                btn.t:SetPoint("RIGHT", btn, "RIGHT", -10, 0)
                btn.t:SetJustifyH("LEFT")
                btn.t:SetWordWrap(false)

                btn:SetScript("OnEnter", function(self)
                    IMAGO.ShowTooltipIfTruncated(self, self.t)
                end)
                btn:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                IMAGO.Chronicle.classButtons[cIdx] = btn
            end

            btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
            btn.classSlug = cls.slug
            btn._classData = cls.data
            btn.isSeen = cls.isSeen
            btn.isManual = cls.isManual
            btn.isEncyclopedia = IMAGOSaved.encyclopediaMode
            btn.isVisible = cls.isVisible
            btn._zebra = (cIdx % 2 == 0)
            btn.bg:SetColorTexture(1, 1, 1, (btn._zebra and 0.03) or 0)

            local coords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[cls.data.classFile]
            if coords then
                btn.icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
                btn.icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
                btn.icon:SetDesaturated(not cls.isVisible)
                btn.icon:Show()
            else
                btn.icon:Hide()
            end

            local displayName = cls.isVisible and (cls.data.name or cls.slug)
                or GetCrypticName(cls.data.name or cls.slug)
            local classColor = RAID_CLASS_COLORS and RAID_CLASS_COLORS[cls.data.classFile]
            btn.t:SetText(displayName)
            if cls.isVisible and classColor then
                btn.t:SetTextColor(classColor.r, classColor.g, classColor.b)
            elseif cls.isVisible then
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
            else
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
            end

            if not btn.newTag then
                btn.newTag = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.newTag, "NAV_META", IMAGO_COLORS.GOLD)
                btn.newTag:SetPoint("RIGHT", btn, "RIGHT", -5, 0)
            end
            btn.newTag:SetText(IMAGO.L["TAG_NEW"])
            local hasViewed = IMAGOSaved.viewedClasses[cls.slug]
            if cls.isSeen and not hasViewed and not btn.isEncyclopedia then
                btn.newTag:Show()
            else
                btn.newTag:Hide()
            end

            if f.selectedClassSlug == cls.slug then
                btn.activeBar:Show()
                btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            else
                btn.activeBar:Hide()
            end

            btn:SetScript("OnClick", function(self)
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end

                for _, fb in pairs(IMAGO.Chronicle.classButtons or {}) do
                    if fb ~= self and fb.activeBar then fb.activeBar:Hide() end
                end
                self.activeBar:Show()

                if not isNavigatingBack then
                    local entry = nil
                    if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
                        entry = { type = "npc", slug = f.selectedNPCSlug }
                    elseif f.selectedZoneMapID then
                        entry = { type = "zone", mapID = f.selectedZoneMapID }
                    elseif f.selectedRaceSlug then
                        entry = { type = "race", slug = f.selectedRaceSlug }
                    elseif f.selectedClassSlug and f.selectedClassSlug ~= self.classSlug then
                        entry = { type = "class", slug = f.selectedClassSlug }
                    elseif f.selectedCodexSlug then
                        entry = { type = "codex", slug = f.selectedCodexSlug }
                    elseif f.selectedTimelineSlug then
                        entry = { type = "timeline", slug = f.selectedTimelineSlug }
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end

                f.selectedNPCSlug = nil
                f.selectedZoneMapID = nil
                f.selectedRace = nil
                f.selectedRaceSlug = nil
                f.selectedCodexSlug = nil
                f.selectedTimelineSlug = nil
                f.selectedTimelineEra = nil
                f.selectedClass = self._classData
                f.selectedClassSlug = self.classSlug
                IMAGO.Chronicle.RememberViewed(5, self.classSlug)
                f.activeClassTab = f.activeClassTab or "overview"

                IMAGOSaved.viewedClasses[self.classSlug] = true
                if self.newTag then self.newTag:Hide() end

                IMAGO.Chronicle.RenderClass(self.classSlug, self._classData, self.isVisible)
            end)

            btn:SetScript("OnMouseUp", function(self, mouseBtn)
                if mouseBtn == "RightButton" and not self.isSeen and not self.isEncyclopedia then
                    if self.isManual then
                        IMAGOSaved.manualClassUnlocks[self.classSlug] = nil
                        IMAGO.Chronicle.UpdateList()
                    else
                        f.ShowConfirm(
                            IMAGO.L["CONFIRM_UNLOCK_TITLE"],
                            IMAGO.L["CONFIRM_UNLOCK_DESC"],
                            function()
                                IMAGOSaved.manualClassUnlocks = IMAGOSaved.manualClassUnlocks or {}
                                IMAGOSaved.manualClassUnlocks[self.classSlug] = true
                                IMAGO.Chronicle.UpdateList()
                            end
                        )
                    end
                end
            end)

            btn:Show()
            yOffset = yOffset + 35
            cIdx = cIdx + 1
        end

        for i = cIdx, #IMAGO.Chronicle.classButtons do
            IMAGO.Chronicle.classButtons[i]:Hide()
        end

        f.content:SetHeight(math.max(1, yOffset))
        IMAGO.UpdateScrollBarVisibility(f.scrollFrame)

    -- ============================================================
    -- TAB 6: TIMELINE — era list in the sidebar
    -- ============================================================
    elseif activeTab == 6 then
        if f.sidebar.timelineHeader then f.sidebar.timelineHeader:Show() end

        IMAGO.Chronicle.timelineEraButtons = IMAGO.Chronicle.timelineEraButtons or {}
        local teIdx = 1
        for _, era in ipairs(IMAGOdb.timeline and IMAGOdb.timeline.eras or {}) do
            local btn = IMAGO.Chronicle.timelineEraButtons[teIdx]
            if not btn then
                btn = CreateFrame("Button", nil, f.content, "BackdropTemplate")
                btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 50)

                btn.bg = btn:CreateTexture(nil, "BACKGROUND")
                btn.bg:SetAllPoints()

                btn:SetBackdrop({
                    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                    edgeSize = 10,
                    insets = { left = 3, right = 3, top = 3, bottom = 3 }
                })
                btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0)

                local hl = btn:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

                btn.icon = btn:CreateTexture(nil, "ARTWORK")
                btn.icon:SetSize(28, 28)
                btn.icon:SetPoint("LEFT", btn, "LEFT", 10, 0)

                btn.t = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
                btn.t:SetPoint("TOPLEFT", btn, "TOPLEFT", 48, -8)
                btn.t:SetPoint("RIGHT", btn, "RIGHT", -10, 0)
                btn.t:SetJustifyH("LEFT")
                btn.t:SetWordWrap(false)

                btn.range = btn:CreateFontString(nil, "OVERLAY")
                btn.range:SetFont(IMAGO.FONT_BODY, 10, "")
                btn.range:SetPoint("TOPLEFT", btn.t, "BOTTOMLEFT", 0, -2)
                btn.range:SetPoint("RIGHT", btn, "RIGHT", -10, 0)
                btn.range:SetJustifyH("LEFT")
                btn.range:SetWordWrap(false)
                btn.range:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

                btn:SetScript("OnEnter", function(self)
                    IMAGO.ShowTooltipIfTruncated(self, self.t)
                end)
                btn:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                IMAGO.Chronicle.timelineEraButtons[teIdx] = btn
            end

            btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
            btn._eraKey = era.key
            btn._zebra = (teIdx % 2 == 0)
            btn.bg:SetColorTexture(1, 1, 1, (btn._zebra and 0.03) or 0)

            if era.icon then
                btn.icon:SetTexture(era.icon)
                btn.icon:Show()
            else
                btn.icon:Hide()
            end

            local eraName = (IMAGOdb.timelineEraNames and IMAGOdb.timelineEraNames[era.key]) or era.key
            btn.t:SetText(eraName)
            btn.range:SetText((IMAGOdb.timelineEraRanges and IMAGOdb.timelineEraRanges[era.key]) or "")

            if f.selectedTimelineEra == era.key then
                btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
                btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            else
                btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
                btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
            end

            btn:SetScript("OnClick", function(self)
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
                f.selectedTimelineEra = self._eraKey
                IMAGO.Chronicle.UpdateList()
                -- Per spec: opening an era shows its first event immediately
                local first = IMAGO.Chronicle.GetTimelineEvents(self._eraKey)[1]
                if first then
                    IMAGO.Chronicle.RenderTimelineEvent(first.slug)
                else
                    IMAGO.Chronicle.RenderTimelineEvent(nil)
                end
            end)

            btn:Show()
            yOffset = yOffset + 54
            teIdx = teIdx + 1
        end

        for i = teIdx, #IMAGO.Chronicle.timelineEraButtons do
            IMAGO.Chronicle.timelineEraButtons[i]:Hide()
        end

        f.content:SetHeight(math.max(1, yOffset))
        IMAGO.UpdateScrollBarVisibility(f.scrollFrame)

    -- ============================================================
    -- TAB 7: CODEX — category list in the sidebar
    -- ============================================================
    elseif activeTab == 7 then
        if f.sidebar.codexHeader then f.sidebar.codexHeader:Show() end

        IMAGO.Chronicle.codexCatButtons = IMAGO.Chronicle.codexCatButtons or {}
        local ccIdx = 1
        for _, cat in ipairs(IMAGOdb.codex and IMAGOdb.codex.categories or {}) do
            local btn = IMAGO.Chronicle.codexCatButtons[ccIdx]
            if not btn then
                btn = CreateFrame("Button", nil, f.content)
                btn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 46)

                btn.bg = btn:CreateTexture(nil, "BACKGROUND")
                btn.bg:SetAllPoints()

                btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
                btn.activeBar:SetWidth(2)
                btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
                btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
                btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
                btn.activeBar:Hide()

                local hl = btn:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

                btn.icon = btn:CreateTexture(nil, "ARTWORK")
                btn.icon:SetSize(22, 22)
                btn.icon:SetPoint("LEFT", btn, "LEFT", 10, 0)

                btn.t = btn:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
                btn.t:SetPoint("LEFT", btn, "LEFT", 40, 0)
                btn.t:SetPoint("RIGHT", btn, "RIGHT", -22, 0)
                btn.t:SetJustifyH("LEFT")
                btn.t:SetWordWrap(false)

                btn.chevron = btn:CreateFontString(nil, "OVERLAY")
                btn.chevron:SetFont(IMAGO.FONT_BODY, 14, "")
                btn.chevron:SetPoint("RIGHT", btn, "RIGHT", -6, 0)
                btn.chevron:SetText(">")
                btn.chevron:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

                btn:SetScript("OnEnter", function(self)
                    IMAGO.ShowTooltipIfTruncated(self, self.t)
                end)
                btn:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)

                IMAGO.Chronicle.codexCatButtons[ccIdx] = btn
            end

            btn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
            btn._catKey = cat.key
            btn._zebra = (ccIdx % 2 == 0)
            btn.bg:SetColorTexture(1, 1, 1, (btn._zebra and 0.03) or 0)

            if cat.icon then
                btn.icon:SetTexture(cat.icon)
                btn.icon:Show()
            else
                btn.icon:Hide()
            end

            local catName = IMAGO.L["CODEX_CAT_" .. cat.key:upper()]
                or (IMAGOdb.codexCatNames and IMAGOdb.codexCatNames[cat.key]) or cat.key
            btn.t:SetText(catName)
            btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])

            if f.selectedCodexCat == cat.key then
                btn.activeBar:Show()
                btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
            else
                btn.activeBar:Hide()
            end

            btn:SetScript("OnClick", function(self)
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
                f.selectedCodexCat = self._catKey
                IMAGO.Chronicle.UpdateList()
                -- Per spec: opening a category shows its first entry immediately
                local first = IMAGO.Chronicle.GetCodexEntries(self._catKey)[1]
                if first then
                    IMAGO.Chronicle.RenderCodexEntry(first.slug)
                else
                    IMAGO.Chronicle.RenderCodexEntry(nil)
                end
            end)

            btn:Show()
            yOffset = yOffset + 46
            ccIdx = ccIdx + 1
        end

        for i = ccIdx, #IMAGO.Chronicle.codexCatButtons do
            IMAGO.Chronicle.codexCatButtons[i]:Hide()
        end

        f.content:SetHeight(math.max(1, yOffset))
        IMAGO.UpdateScrollBarVisibility(f.scrollFrame)
    end
end

-- ============================================================
-- RACE DETAIL RENDERER (TAB 3)
-- ============================================================

--- Shared sub-tab strip layout for the race + class dossier pages.
--- Both strips use identical geometry, fonts and behaviour so switching
--- between the two tabs never shifts the headings:
---  * the fit pass measures BOTH tab sets and picks the largest font
---    size that fits each of them (one shared size for both strips)
---  * leftover width is spread evenly over the gaps so every strip
---    spans the same edges (x=300 → detailFrame right - 12)
--- keyField: "raceTabKey" or "classTabKey" — the tab field compared
--- against activeKey for the active-line + gold label.
local function LayoutSubTabStrip(tabs, keyField, activeKey)
    local f = IMAGO.Chronicle.frame
    if not f or not tabs then return end
    local maxStrip = math.max(280, (f.detailFrame:GetWidth() or 830) - 300 - 12)

    local function RaceLabel(t)
        local rd = f.selectedRace
        return (t.raceTabKey == "groups" and rd and rd.groupTabLabel)
            or (t.raceLocaleKey and IMAGO.L[t.raceLocaleKey]) or t.raceTabKey
    end
    local function ClassLabel(t)
        return (t.classLocaleKey and IMAGO.L[t.classLocaleKey]) or t.classTabKey
    end
    -- fit considers both sets so race + class always share one font size
    local sets = {
        { tabs = f.raceTabs,  getLabel = RaceLabel },
        { tabs = f.classTabs, getLabel = ClassLabel },
    }
    local function Measure(set, fontSize, gap)
        local total = 0
        for i, t in ipairs(set.tabs or {}) do
            t.text:SetFont(IMAGO.FONT_BODY, fontSize, "OUTLINE")
            t.text:SetText(set.getLabel(t))
            total = total + math.ceil(t.text:GetStringWidth()) + 2 + (i > 1 and gap or 0)
        end
        return total
    end
    local fontSize, gap = 12, 22
    for pass = 1, 8 do
        local fits = true
        for _, s in ipairs(sets) do
            if s.tabs and #s.tabs > 0 and Measure(s, fontSize, gap) > maxStrip then
                fits = false
                break
            end
        end
        if fits then break end
        if gap > 12 then gap = gap - 6
        elseif fontSize > 10 then fontSize, gap = fontSize - 1, 18
        else break end
    end

    -- lay out this strip at the shared size; spread leftover width into
    -- the gaps so the bar always spans the same area
    local getLabel = (keyField == "raceTabKey") and RaceLabel or ClassLabel
    local widths, total = {}, 0
    for i, t in ipairs(tabs) do
        t.text:SetFont(IMAGO.FONT_BODY, fontSize, "OUTLINE")
        t.text:SetText(getLabel(t))
        widths[i] = math.ceil(t.text:GetStringWidth()) + 2
        total = total + widths[i] + (i > 1 and gap or 0)
    end
    if total < maxStrip and #tabs > 1 then
        gap = math.min(40, gap + (maxStrip - total) / (#tabs - 1))
    end
    local tabX = 0
    for i, t in ipairs(tabs) do
        local w = widths[i] or 60
        t:SetWidth(w)
        t.text:ClearAllPoints()
        t.text:SetPoint("LEFT", t, "LEFT", 0, 0)
        t:ClearAllPoints()
        t:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 300 + tabX, -80)
        t.activeLine:ClearAllPoints()
        t.activeLine:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT", 0, 0)
        t.activeLine:SetWidth(w)
        local active = (t[keyField] == activeKey)
        t.text:SetTextColor(active and IMAGO_COLORS.GOLD_BRIGHT[1] or IMAGO_COLORS.TEXT_MUTED[1],
            active and IMAGO_COLORS.GOLD_BRIGHT[2] or IMAGO_COLORS.TEXT_MUTED[2],
            active and IMAGO_COLORS.GOLD_BRIGHT[3] or IMAGO_COLORS.TEXT_MUTED[3])
        if active then t.activeLine:Show() else t.activeLine:Hide() end
        tabX = tabX + w + gap
    end
end

--- Renders the detail page for a race into the detailFrame.
function IMAGO.Chronicle.RenderRace(slug, data, isVisible)
    local f = IMAGO.Chronicle.frame
    if not f then return end

    f.startPage:Hide()
    IMAGO.Chronicle.FillRaceFacts(slug, data, isVisible)
    f.hintPage:Hide()
    f.tabLore:Hide()
    f.tabTime:Hide()
    if f.loreBody then f.loreBody:Hide() end
    if f.loreSource then f.loreSource:Hide() end
    if f.timelineContainer then f.timelineContainer:Hide() end
    if f.detailImage then f.detailImage:Hide() end
    if f.detailImageBorder then f.detailImageBorder:Hide() end
    if f.detailSeparator then f.detailSeparator:Hide() end
    IMAGO.Chronicle.SetDetailAction(nil)

    if not isVisible then
        -- Undiscovered race: cryptic title + hint page
        for _, t in ipairs(f.raceTabs or {}) do t:Hide() end
        if f.raceContainer then f.raceContainer:Hide() end
        if f.classContainer then f.classContainer:Hide() end
        if f.raceEmblemBox then f.raceEmblemBox:Hide() end
        if f.raceZoneImage then f.raceZoneImage:Hide() end
        if f.raceZoneBorder then f.raceZoneBorder:Hide() end
        if f.racePortrait then f.racePortrait:Hide() end
        f.detailModel:Hide()

        if f.detailModel2 then f.detailModel2:Hide() end
        f.factionIcon:Hide()
        f.infoScroll:Hide()

        f.detailTitle:Show()
        f.detailLineLeft:Show()
        f.detailLineRight:Show()
        f.detailTitle:SetText(GetCrypticName(data.name or slug))
        f.detailTitle:SetTextColor(0.4, 0.3, 0.5, 0.9)

        f.hintPage:Show()
        f.hintPage.aura:Show()
        f.hintPage.warning:SetText(IMAGO.L["HINT_RACE_LOCKED"] or "PEOPLE UNKNOWN")
        f.hintPage.icon:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\undiscovered.tga")
        f.hintPage.icon:SetTexCoord(0, 1, 0, 1)
        f.hintPage.desc:SetText(IMAGO.L["HINT_RACE_LOCKED_DESC"] or "Meet a member of this race in the world to reveal its chronicle entry.")
        return
    end

    f.detailTitle:Show()
    f.detailLineLeft:Show()
    f.detailLineRight:Show()
    f.detailTitle:SetText(data.name or slug)
    f.detailTitle:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

    local isDual = (data.alignment == "Both")
    local alignCrest = RACE_ALIGN_ICONS[isDual and "Alliance" or data.alignment]
    if alignCrest and not isDual then
        f.factionIcon:SetTexture(alignCrest)
        f.factionIcon:Show()
    else
        f.factionIcon:Hide()
    end

    if isDual then
        -- Dual-faction race (Skyborne): both faction crests, no tabard yet
        f.raceEmblem:SetTexture(RACE_ALIGN_ICONS.Alliance)
        f.raceEmblem2:SetTexture(RACE_ALIGN_ICONS.Horde)
        f.raceEmblem2:Show()
        f.raceEmblemCap:SetText("Alliance")
        f.raceEmblem2Cap:SetText("Horde")
        f.raceTabard:Hide()
        f.raceTabardCap:Hide()
    else
        f.raceEmblem:SetTexture(data.iconM)
        f.raceEmblem2:SetTexture(data.iconF)
        f.raceEmblem2:Show()
        f.raceEmblemCap:SetText(IMAGO.L["RACE_CAP_MALE"] or "Male")
        f.raceEmblem2Cap:SetText(IMAGO.L["RACE_CAP_FEMALE"] or "Female")
        f.raceTabardCap:SetText(IMAGO.L["RACE_CAP_TABARD"] or "Tabard")
        if data.tabard then
            f.raceTabard:SetTexture(data.tabard)
            f.raceTabard:Show()
            f.raceTabardCap:Show()
        else
            f.raceTabard:Hide()
            f.raceTabardCap:Hide()
        end
    end
    -- Emblem box fills the left column on tabs without a model; RenderRaceTab toggles it
    f.raceEmblemBox:Hide()

    if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
    if f.classIcon then f.classIcon:Hide() end
    if f.classEmblemBox then f.classEmblemBox:Hide() end
    for _, t in ipairs(f.raceTabs or {}) do t:Show() end
    f.infoScroll:Show()
    IMAGO.Chronicle.RenderRaceTab(f.activeRaceTab or "overview")
end

--- Renders one sub-tab's content into f.infoContent via a pooled container.
function IMAGO.Chronicle.RenderRaceTab(tabKey)
    local f = IMAGO.Chronicle.frame
    local data = f and f.selectedRace
    if not f or not data then return end

    -- Reuse the NPC scroll geometry: model column left, text right
    f.infoScroll:ClearAllPoints()
    f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 302, -116)
    f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -16, f._infoBottom or 100)
    f.infoScroll:SetVerticalScroll(0)

    -- Sub-tab strip: shared layout with the class tabs — same font size,
    -- same span (measured + gap-stretched in LayoutSubTabStrip).
    LayoutSubTabStrip(f.raceTabs, "raceTabKey", tabKey)

    -- Lazy-create the container + pooled widgets inside infoContent
    if not f.raceContainer then
        f.raceContainer = CreateFrame("Frame", nil, f.infoContent)
        f.raceContainer:SetPoint("TOPLEFT", 10, 0)
        f.raceContainer:SetSize(420, 1)
        f.raceContainer.lines = {}   -- FontString pool
        f.raceContainer.rows = {}    -- Button pool (clickable figures/settlements)
        f.raceContainer.headers = {} -- Button pool (accordion headers)
        f.raceContainer.sections = {}-- Frame pool (section heads: label + line)
        f.raceContainer:EnableMouse(true)
        f.raceContainer:SetHyperlinksEnabled(true)
        f.raceContainer:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
                IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
            end
        end)
    end
    local c = f.raceContainer
    c:Show()
    for _, l in ipairs(c.lines) do l:Hide() end
    for _, r in ipairs(c.rows) do r:Hide() end
    for _, h in ipairs(c.headers) do h:Hide() end
    for _, s in ipairs(c.sections) do s:Hide() end
    if c.mtable then c.mtable:Hide() end

    local lineIdx, rowIdx, hdrIdx, secIdx = 0, 0, 0, 0
    local y = 0
    local contentW = math.max(1, (f.infoScroll:GetWidth() or 0) - IMAGO.LAYOUT.SCROLLBAR_GUTTER - 30)

    local function GetLine()
        lineIdx = lineIdx + 1
        local l = c.lines[lineIdx]
        if not l then
            l = c:CreateFontString(nil, "OVERLAY")
            l:SetFont(IMAGO.FONT_BODY, 13)
            l:SetJustifyH("LEFT")
            l:SetSpacing(5)
            l:SetWidth(contentW)
            c.lines[lineIdx] = l
        end
        l:SetWidth(contentW)
        return l
    end

    -- AddText(text, color, size, justify, font) — stacks a wrapped line
    local function AddText(text, color, size, justify, font)
        local l = GetLine()
        l:SetFont(font or IMAGO.FONT_BODY, size or 13)
        l:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        l:SetText(text)
        l:SetJustifyH(justify or "LEFT")
        l:SetTextColor(color[1], color[2], color[3])
        l:Show()
        y = y + l:GetStringHeight() + 10
    end

    local function AddGap(px) y = y + (px or 6) end

    -- Non-interactive section head: gold-muted caps label + fading line
    local function AddSectionHead(label)
        secIdx = secIdx + 1
        local h = c.sections[secIdx]
        if not h then
            h = CreateFrame("Frame", nil, c)
            h:SetSize(contentW, 24)
            h.t = h:CreateFontString(nil, "OVERLAY")
            h.t:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
            h.t:SetPoint("LEFT", 2, 0)
            h.line = h:CreateTexture(nil, "ARTWORK")
            h.line:SetHeight(1)
            h.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            c.sections[secIdx] = h
        end
        h.t:SetText(label)
        h.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        h.line:ClearAllPoints()
        h.line:SetPoint("LEFT", h.t, "RIGHT", 8, -1)
        h.line:SetWidth(math.max(1, contentW - h.t:GetStringWidth() - 12))
        h.line:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.5), CreateColor(0, 0, 0, 0))
        h:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        h:SetWidth(contentW)
        h:Show()
        y = y + 26
    end

    -- Clickable row: name (gold when linked) over a wrapping title line,
    -- closed by a fading divider. Height follows the title's wrap.
    local function AddRow(name, title, onClick)
        rowIdx = rowIdx + 1
        local r = c.rows[rowIdx]
        if not r then
            r = CreateFrame("Button", nil, c)
            r:SetSize(contentW, 40)
            r.name = r:CreateFontString(nil, "OVERLAY")
            r.name:SetFont(IMAGO.FONT_BODY, 15, "")
            r.name:SetPoint("TOPLEFT", 2, -7)
            r.name:SetPoint("TOPRIGHT", -6, -7)
            r.name:SetJustifyH("LEFT")
            r.name:SetWordWrap(false)
            r.title = r:CreateFontString(nil, "OVERLAY")
            r.title:SetFont(IMAGO.FONT_BODY, 12, "")
            r.title:SetPoint("TOPLEFT", 2, -25)
            r.title:SetPoint("TOPRIGHT", -6, -25)
            r.title:SetJustifyH("LEFT")
            r.title:SetWordWrap(true)
            r.title:SetSpacing(3)
            r.line = r:CreateTexture(nil, "ARTWORK")
            r.line:SetHeight(1)
            r.line:SetPoint("BOTTOMLEFT", 2, 1)
            r.line:SetPoint("BOTTOMRIGHT", -2, 1)
            r.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            r.line:SetGradient("HORIZONTAL",
                CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.28),
                CreateColor(0, 0, 0, 0))
            local hl = r:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.15)
            c.rows[rowIdx] = r
        end
        r:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        r:SetWidth(contentW)
        if onClick then
            r.name:SetText("|c" .. IMAGO_HEX.GOLD_BRIGHT .. name .. "|r")
            r:EnableMouse(true)
            r:SetScript("OnClick", onClick)
        else
            r.name:SetText("|c" .. IMAGO_HEX.TEXT_PRIMARY .. name .. "|r")
            r:EnableMouse(false)
            r:SetScript("OnClick", nil)
        end
        r.title:SetText(title or "")
        r.title:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        local titleH = (title and title ~= "") and (r.title:GetStringHeight() + 6) or 0
        local rh = 30 + titleH
        r:SetHeight(rh)
        r:Show()
        y = y + rh + 2
    end

    -- Member table: caps header + zebra rows with fixed-width cells that
    -- wrap within their column. entries[i] = { name, cells = {...}, onClick }
    local function AddMemberTable(colFracs, colLabels, entries)
        if not c.mtable then
            local t = CreateFrame("Frame", nil, c)
            t.heads = {}
            t.rows = {}
            t.line = t:CreateTexture(nil, "ARTWORK")
            t.line:SetHeight(1)
            t.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            c.mtable = t
        end
        local t = c.mtable
        t:Show()
        t:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        local tw = contentW
        t:SetWidth(tw)
        local xs, x = {}, 0
        for i, fr in ipairs(colFracs) do
            xs[i] = x
            x = x + math.floor(tw * fr + 0.5)
        end
        for i, lab in ipairs(colLabels) do
            local h = t.heads[i]
            if not h then
                h = t:CreateFontString(nil, "OVERLAY")
                h:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
                h:SetJustifyH("LEFT")
                h:SetWordWrap(false)
                t.heads[i] = h
            end
            h:ClearAllPoints()
            h:SetPoint("TOPLEFT", xs[i] + 4, -4)
            h:SetWidth(math.max(1, (xs[i + 1] or tw) - xs[i] - 10))
            h:SetText(lab)
            h:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
            h:Show()
        end
        for i = #colLabels + 1, #t.heads do t.heads[i]:Hide() end
        t.line:ClearAllPoints()
        t.line:SetPoint("TOPLEFT", 0, -20)
        t.line:SetPoint("TOPRIGHT", 0, -20)
        t.line:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.6),
            CreateColor(0, 0, 0, 0))
        local ncols = #colFracs
        local ty = 24
        for ri, e in ipairs(entries) do
            local r = t.rows[ri]
            if not r then
                r = CreateFrame("Button", nil, t)
                r.cells = {}
                r.bg = r:CreateTexture(nil, "BACKGROUND")
                r.bg:SetAllPoints()
                r.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                r.line = r:CreateTexture(nil, "ARTWORK")
                r.line:SetHeight(1)
                r.line:SetPoint("BOTTOMLEFT", 0, 0)
                r.line:SetPoint("BOTTOMRIGHT", 0, 0)
                r.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                local hl = r:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.15)
                t.rows[ri] = r
            end
            while #r.cells < ncols do
                local cell = r:CreateFontString(nil, "OVERLAY")
                cell:SetJustifyH("LEFT")
                cell:SetWordWrap(true)
                cell:SetSpacing(2)
                r.cells[#r.cells + 1] = cell
            end
            r:SetPoint("TOPLEFT", 0, -ty)
            r:SetWidth(tw)
            local maxH = 0
            for i = 1, ncols do
                local cell = r.cells[i]
                cell:ClearAllPoints()
                cell:SetPoint("TOPLEFT", xs[i] + 4, -5)
                cell:SetWidth(math.max(1, (xs[i + 1] or tw) - xs[i] - 10))
                if i == 1 then
                    cell:SetFont(IMAGO.FONT_BODY, 13)
                    local hex = e.onClick and IMAGO_HEX.GOLD_BRIGHT or IMAGO_HEX.TEXT_PRIMARY
                    cell:SetText("|c" .. hex .. (e.name or "") .. "|r")
                else
                    cell:SetFont(IMAGO.FONT_BODY, 12)
                    cell:SetText("|c" .. IMAGO_HEX.TEXT_SECONDARY .. (e.cells[i - 1] or "") .. "|r")
                end
                local hgt = cell:GetStringHeight()
                if hgt > maxH then maxH = hgt end
            end
            local rh = maxH + 12
            r:SetHeight(rh)
            r.line:SetGradient("HORIZONTAL",
                CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.22),
                CreateColor(0, 0, 0, 0))
            if ri % 2 == 0 then
                r.bg:Show()
                r.bg:SetGradient("HORIZONTAL",
                    CreateColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.35),
                    CreateColor(0, 0, 0, 0))
            else
                r.bg:Hide()
            end
            if e.onClick then
                r:EnableMouse(true)
                r:SetScript("OnClick", e.onClick)
            else
                r:EnableMouse(false)
                r:SetScript("OnClick", nil)
            end
            r:Show()
            ty = ty + rh
        end
        for i = #entries + 1, #t.rows do t.rows[i]:Hide() end
        t:SetHeight(math.max(1, ty))
        y = y + ty + 6
    end

    -- Accordion header: toggles f.raceExpanded[key]
    f.raceExpanded = f.raceExpanded or {}
    local function AddSection(key, label, body)
        hdrIdx = hdrIdx + 1
        local h = c.headers[hdrIdx]
        if not h then
            h = CreateFrame("Button", nil, c)
            h:SetSize(contentW, 26)
            h.bg = h:CreateTexture(nil, "BACKGROUND")
            h.bg:SetAllPoints()
            h.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            h.bg:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.3), CreateColor(0, 0, 0, 0))
            h.icon = h:CreateFontString(nil, "OVERLAY")
            h.icon:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
            h.icon:SetPoint("LEFT", 5, 0)
            h.t = h:CreateFontString(nil, "OVERLAY")
            h.t:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
            h.t:SetPoint("LEFT", 20, 0)
            h.line = h:CreateTexture(nil, "ARTWORK")
            h.line:SetSize(contentW, 1)
            h.line:SetPoint("BOTTOM", 0, 0)
            h.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            h.line:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.5), CreateColor(0, 0, 0, 0))
            h:SetScript("OnClick", function(self)
                f.raceExpanded[self._key] = not f.raceExpanded[self._key]
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
                IMAGO.Chronicle.RenderRaceTab(self._tabKey)
            end)
            c.headers[hdrIdx] = h
        end
        h._key = key
        h._tabKey = tabKey
        h:SetWidth(contentW)
        h.line:SetWidth(contentW)
        h:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        local open = f.raceExpanded[key]
        h.icon:SetText(open and "-" or "+")
        h.icon:SetTextColor(open and IMAGO_COLORS.GOLD[1] or IMAGO_COLORS.GOLD_MUTED[1],
            open and IMAGO_COLORS.GOLD[2] or IMAGO_COLORS.GOLD_MUTED[2],
            open and IMAGO_COLORS.GOLD[3] or IMAGO_COLORS.GOLD_MUTED[3])
        h.t:SetText(label)
        h.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        h:Show()
        y = y + 30

        if open and body and body ~= "" then
            AddText(IMAGO.TextLinker.LinkNames(body), IMAGO_COLORS.TEXT_SECONDARY)
        end
    end

    -- Left column presenter: emblem box, 1-2 PlayerModels, or zone image.
    local function HideModelChrome(mdl)
        if mdl and mdl.animButtons then
            for _, b in ipairs(mdl.animButtons) do b:Hide() end
        end
    end

    local function HideLeftColumn()
        f.detailModel:Hide()
        if f.detailModel2 then f.detailModel2:Hide() end
        if f.detailModelCap then f.detailModelCap:Hide() end
        if f.detailModel2Cap then f.detailModel2Cap:Hide() end
        if f.stageFrame then f.stageFrame:Hide() end
        HideModelChrome(f.detailModel)
        HideModelChrome(f.detailModel2)
        f.raceEmblemBox:Hide()
        f.raceZoneImage:Hide()
        f.raceZoneBorder:Hide()
        if f.racePortrait then f.racePortrait:Hide() end
    end

    local function SetupModel(mdl, creatureID)
        mdl:Show()
        mdl:ClearModel()
        mdl:SetCamDistanceScale(1.0)
        mdl:SetPosition(0, 0, 0)
        mdl:SetFacing(0)
        LoadModelCreature(mdl, creatureID, false, function(m)
            m:SetAnimation(0)
        end)
    end

    local function MakeModelCaption(key, fallback)
        local cap = f.detailFrame:CreateFontString(nil, "OVERLAY")
        cap:SetFont(IMAGO.FONT_BODY, 11)
        cap:SetJustifyH("CENTER")
        cap:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        cap:SetText((key and (IMAGO.L[key] or fallback)) or "")
        return cap
    end

    -- id1 = leader/mount creature, id2 = optional second creature (epic mount)
    local function SetDetailModels(id1, id2, cap1, cap2)
        HideLeftColumn()
        if not id1 then
            f.raceEmblemBox:Show()
            return
        end
        if not f.detailModelCap then
            f.detailModelCap  = MakeModelCaption()
            f.detailModel2Cap = MakeModelCaption()
        end
        -- keep the model column clear of the facts band at the bottom;
        -- all left-column visuals share the same -110 top edge
        local avail = math.max(120,
            (f.detailFrame:GetHeight() or 600) - 110 - (f._infoBottom or 20) - 36)
        f.detailModel._inStage = false
        f.detailModel:ClearAllPoints()
        if id2 then
            -- Two stacked models (racial mount + epic mount)
            local each = math.min(185, (avail - 26) / 2)
            f.detailModel:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -110)
            f.detailModel:SetSize(280, each)
            if not f.detailModel2 then
                f.detailModel2 = CreateFrame("PlayerModel", nil, f.detailFrame)
                f.detailModel2:SetFrameLevel(f.detailModel:GetFrameLevel())
                if f.ApplyModelUI then f.ApplyModelUI(f.detailModel2) end
                HideModelChrome(f.detailModel2)
                -- caption dies with the model wherever it is hidden
                f.detailModel2:HookScript("OnHide", function()
                    if f.detailModel2Cap then f.detailModel2Cap:Hide() end
                end)
            end
            f.detailModel2:ClearAllPoints()
            f.detailModel2:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -110 - each - 26)
            f.detailModel2:SetSize(280, each)
            f.detailModelCap:ClearAllPoints()
            f.detailModelCap:SetPoint("TOP", f.detailModel, "BOTTOM", 0, -2)
            f.detailModelCap:SetText(IMAGO.L[cap1] or cap1 or "")
            f.detailModelCap:Show()
            f.detailModel2Cap:ClearAllPoints()
            f.detailModel2Cap:SetPoint("TOP", f.detailModel2, "BOTTOM", 0, -2)
            f.detailModel2Cap:SetText(IMAGO.L[cap2] or cap2 or "")
            f.detailModel2Cap:Show()
            SetupModel(f.detailModel, id1)
            SetupModel(f.detailModel2, id2)
        else
            f.detailModel:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -110)
            f.detailModel:SetSize(280, math.min(400, avail))
            if cap1 then
                f.detailModelCap:ClearAllPoints()
                f.detailModelCap:SetPoint("TOP", f.detailModel, "BOTTOM", 0, -6)
                f.detailModelCap:SetText(IMAGO.L[cap1] or cap1)
                f.detailModelCap:Show()
            end
            SetupModel(f.detailModel, id1)
        end
    end

    -- Shows a zone image in the left column; falls back to the emblem box
    local function SetZoneImage(mapID)
        HideLeftColumn()
        local zoneData = mapID and IMAGOdb.zones and IMAGOdb.zones[mapID]
        local tex = zoneData and zoneData.texturePath or nil
        if not tex then
            f.raceEmblemBox:Show()
            return
        end
        f.raceZoneImage:SetTexture(tex)
        f.raceZoneImage:Show()
        f.raceZoneBorder:Show()
    end

    -- Race artwork in the left column (History tab). Returns false when
    -- the race has no imagePath so the caller can fall back to zone art
    -- or the emblem box.
    local function SetRacePortrait()
        HideLeftColumn()
        if not (data.imagePath and data.imagePath ~= "") then return false end
        f.racePortrait.tex:SetTexture(data.imagePath)
        f.racePortrait:Reset()
        f.racePortrait:Show()
        return true
    end

    -- First settlement that exists as a zone record (for the History and
    -- Settlements left-column images; emblem box fallback)
    local function FirstZoneImage()
        for _, sid in ipairs(data.settlements or {}) do
            if type(sid) == "number" then
                local zd = IMAGOdb.zones and IMAGOdb.zones[sid]
                if zd and zd.texturePath then
                    SetZoneImage(sid)
                    return true
                end
            end
        end
        return false
    end

    -- Class icon strip: "|Ticon|t Name" runs in class colors
    local function ClassStrip(classes)
        local parts = {}
        for _, cl in ipairs(classes or {}) do
            local coords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[cl.classFile]
            local slug = string.lower(cl.classFile or "")
            local cdata = IMAGOdb.classes and IMAGOdb.classes[slug]
            local cname = (cdata and cdata.name) or slug
            local discovered = IsRefDiscovered({ kind = "class", id = slug })
            if not discovered then
                cname = GetCrypticName(cname)
            end
            local col = RAID_CLASS_COLORS and RAID_CLASS_COLORS[cl.classFile]
            local chex = col and string.format("FF%02X%02X%02X",
                math.floor(col.r * 255 + 0.5), math.floor(col.g * 255 + 0.5), math.floor(col.b * 255 + 0.5))
                or IMAGO_HEX.TEXT_SECONDARY
            local icon = ""
            if coords then
                icon = "|TInterface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES:13:13:0:0:256:256:"
                    .. math.floor(coords[1] * 256) .. ":" .. math.ceil(coords[2] * 256) .. ":"
                    .. math.floor(coords[3] * 256) .. ":" .. math.ceil(coords[4] * 256) .. "|t "
            end
            -- discovered classes link straight to their dossier page;
            -- notes and the new-combo star stay outside the link span
            local name = "|c" .. chex .. cname .. "|r"
            if discovered then
                name = "|Himago-class:" .. slug .. "|h" .. name .. "|h"
            end
            if discovered and cl.note then
                name = name .. " (" .. cl.note .. ")"
            end
            parts[#parts + 1] = icon .. name
        end
        return table.concat(parts, "   ")
    end

    local function Linkify(text)
        return IMAGO.TextLinker.LinkNames(text or "", nil, nil, nil, nil)
    end

    -- ---- CONTENT PER TAB ------------------------------------
    -- Left column rule: crests + tabard on Overview; homeland artwork
    -- wherever a zone record exists (crests as fallback) on the other
    -- text tabs; models only on Culture (mounts) and Figures (leader).
    -- Only the Overview text is final — the other sub-tabs are still
    -- being written/reviewed, so they show a work-in-progress note
    -- instead of their draft content.
    if tabKey ~= "overview" then
        SetDetailModels(nil)
        AddText(IMAGO.L["RACE_WIP_NOTE"] or "This entry is still being written.", IMAGO_COLORS.TEXT_MUTED, 14)
        c:SetHeight(math.max(1, y))
        f.infoContent:SetHeight(math.max(1, y + 20))
        IMAGO.UpdateScrollBarVisibility(f.infoScroll)
        return
    end
    if tabKey == "overview" then
        -- the identity tab always shows race icons + tabard
        SetDetailModels(nil)
        -- Epigraph quote in the display font (sets it apart from the tab
        -- strip's gold labels) + intro prose + class strip
        local q = data.quote
        if q and q.text and q.text ~= "" then
            AddGap(10)
            AddText(string.format(IMAGO.L["RACE_QUOTE_FMT"] or "“%s”", q.text), IMAGO_COLORS.GOLD, 15, "CENTER", IMAGO.FONT_TITLE)
            if q.author and q.author ~= "" then
                AddText("— " .. q.author, IMAGO_COLORS.GOLD_MUTED, 12, "CENTER")
            end
            AddGap(8)
        end
        if data.overview and data.overview ~= "" then
            AddText(Linkify(data.overview), IMAGO_COLORS.TEXT_PRIMARY, 14)
        end
        if data.classes and #data.classes > 0 then
            AddGap(12)
            AddText("|c" .. IMAGO_HEX.GOLD_MUTED .. (IMAGO.L["RACE_FACT_CLASSES"] or "CLASSES") .. "|r",
                IMAGO_COLORS.TEXT_SECONDARY)
            AddText(ClassStrip(data.classes), IMAGO_COLORS.TEXT_SECONDARY)
        end

    elseif tabKey == "history" then
        if not (SetRacePortrait() or FirstZoneImage()) then SetDetailModels(nil) end
        local hist = data.history or ""
        local firstByte = string.byte(hist, 1)
        local charLen = firstByte and firstByte >= 192 and 2 or 1
        local linked = IMAGO.TextLinker.LinkNames("|c" .. IMAGO_HEX.GOLD .. hist:sub(1, charLen) .. "|r" .. hist:sub(charLen + 1), nil, nil, nil, nil)
        AddText(linked, IMAGO_COLORS.TEXT_PRIMARY, 14)
        if data.source and data.source ~= "" then
            AddGap(10)
            AddText(string.format(IMAGO.L["LORE_AUTHOR"] or "Written by %s", data.source), IMAGO_COLORS.GOLD_MUTED, 11)
        end

    elseif tabKey == "culture" then
        -- Racial mount + epic mount models, stacked (emblem when absent)
        SetDetailModels(data.mountID, data.epicMountID, "RACE_CAP_MOUNT", "RACE_CAP_EPIC_MOUNT")
        if data.culture and data.culture ~= "" then
            AddText(Linkify(data.culture), IMAGO_COLORS.TEXT_PRIMARY, 14)
        end
        if data.relations and #data.relations > 0 then
            AddGap(10)
            AddSectionHead(IMAGO.L["RACE_SEC_RELATIONS"] or "RELATIONS")
            if data.relationsIntro and data.relationsIntro ~= "" then
                AddText(Linkify(data.relationsIntro), IMAGO_COLORS.TEXT_SECONDARY)
                AddGap(2)
            end
            for _, rel in ipairs(data.relations) do
                AddText("|c" .. IMAGO_HEX.GOLD .. rel.name .. "|r   " .. Linkify(rel.text),
                    IMAGO_COLORS.TEXT_SECONDARY)
            end
        end

    elseif tabKey == "groups" then
        if not FirstZoneImage() then SetDetailModels(nil) end
        if data.groupsIntro and data.groupsIntro ~= "" then
            AddText(Linkify(data.groupsIntro), IMAGO_COLORS.TEXT_SECONDARY)
            AddGap(2)
        end
        local any = false
        for _, key in ipairs(data.groups or {}) do
            local sg = data.groups[key]
            if type(sg) == "table" then
                any = true
                AddSection("grp:" .. key, sg.name or key, sg.lore)
            end
        end
        if data.groupsFootnote and data.groupsFootnote ~= "" then
            AddGap(4)
            AddText(data.groupsFootnote, IMAGO_COLORS.TEXT_MUTED, 12)
        end
        if not any then
            AddText(IMAGO.L["RACE_EMPTY_GROUPS"] or "No groups recorded.", IMAGO_COLORS.TEXT_MUTED)
        end

    elseif tabKey == "figures" then
        SetDetailModels(data.leaderID, nil, "RACE_CAP_LEADER")
        local entries = {}
        for _, m in ipairs(data.figures or {}) do
            local fk = m.slug or m.key
            local extra = fk and data.figureText and data.figureText[fk]
            local npcData = m.slug and IMAGO.GetNPCData(m.slug)
            if npcData then
                local slug = m.slug
                entries[#entries + 1] = {
                    name = npcData.name or slug,
                    cells = { (extra and extra.role) or npcData.race or "",
                              (extra and extra.aff) or "" },
                    onClick = function() IMAGO.Chronicle.OpenToNPCSlug(slug) end,
                }
            elseif extra then
                -- no NPC dossier (dead slug or plain text figure) — the
                -- figure still belongs in the table, just not clickable
                entries[#entries + 1] = {
                    name = extra.name or fk,
                    cells = { extra.role or "", extra.aff or "" },
                }
            else
                entries[#entries + 1] = {
                    name = fk or "?",
                    cells = { "", "" },
                }
            end
        end
        if #entries > 0 then
            AddMemberTable({ 0.30, 0.42, 0.28 }, {
                IMAGO.L["MEMBER_COL_NAME"] or "Name",
                IMAGO.L["MEMBER_COL_ROLE"] or "Role",
                IMAGO.L["MEMBER_COL_AFF"] or "Affiliation",
            }, entries)
        else
            AddText(IMAGO.L["RACE_EMPTY_FIGURES"] or "No notable figures recorded.", IMAGO_COLORS.TEXT_MUTED)
        end

    elseif tabKey == "settlements" then
        -- Settlement dossiers aren't written yet — stub like the timeline
        if not FirstZoneImage() then SetDetailModels(nil) end
        AddText(IMAGO.L["TIMELINE_STUB"] or "This entry is still being written.", IMAGO_COLORS.TEXT_MUTED)
    end

    c:SetHeight(math.max(1, y))
    f.infoContent:SetHeight(math.max(1, y + 20))
    IMAGO.UpdateScrollBarVisibility(f.infoScroll)
end

-- ============================================================
-- CLASS DETAIL RENDERER (TAB 4 — skeleton, placeholder content)
-- ============================================================

--- Renders the detail page for a class into the detailFrame.
function IMAGO.Chronicle.RenderClass(slug, data, isVisible)
    local f = IMAGO.Chronicle.frame
    if not f or not data then return end

    f.startPage:Hide()
    IMAGO.Chronicle.SetFactsBand(nil)
    f.hintPage:Hide()
    f.tabLore:Hide()
    f.tabTime:Hide()
    if f.loreSource then f.loreSource:Hide() end
    if f.timelineContainer then f.timelineContainer:Hide() end
    if f.detailImage then f.detailImage:Hide() end
    if f.detailImageBorder then f.detailImageBorder:Hide() end
    if f.detailSeparator then f.detailSeparator:Hide() end
    if f.raceTabs then for _, t in ipairs(f.raceTabs) do t:Hide() end end
    if f.classTabs then for _, t in ipairs(f.classTabs) do t:Hide() end end
    if f.classIcon then f.classIcon:Hide() end
    if f.classEmblemBox then f.classEmblemBox:Hide() end
    if f.classContainer then f.classContainer:Hide() end
    if f.raceContainer then f.raceContainer:Hide() end
    if f.raceEmblemBox then f.raceEmblemBox:Hide() end
    if f.raceZoneImage then f.raceZoneImage:Hide() end
    if f.raceZoneBorder then f.raceZoneBorder:Hide() end
    if f.racePortrait then f.racePortrait:Hide() end
    -- no models or fate stage on class pages — the emblem box is the
    -- uniform left column; hide their animation buttons too
    if f.stageFrame then f.stageFrame:Hide() end
    for _, mdl in ipairs({ f.detailModel, f.detailModel2 }) do
        if mdl then
            mdl:Hide()
            if mdl.animButtons then
                for _, b in ipairs(mdl.animButtons) do b:Hide() end
            end
        end
    end
    if f.detailModelCap then f.detailModelCap:Hide() end
    if f.detailModel2Cap then f.detailModel2Cap:Hide() end
    f.factionIcon:Hide()
    IMAGO.Chronicle.SetDetailAction(nil)

    if not isVisible then
        -- Undiscovered class: cryptic title + hint page
        f.infoScroll:Hide()

        f.detailTitle:Show()
        f.detailLineLeft:Show()
        f.detailLineRight:Show()
        f.detailTitle:SetText(GetCrypticName(data.name or slug))
        f.detailTitle:SetTextColor(0.4, 0.3, 0.5, 0.9)

        f.hintPage:Show()
        f.hintPage.aura:Show()
        f.hintPage.warning:SetText(IMAGO.L["HINT_CLASS_LOCKED"] or "CLASS UNKNOWN")
        f.hintPage.icon:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\undiscovered.tga")
        f.hintPage.icon:SetTexCoord(0, 1, 0, 1)
        f.hintPage.desc:SetText(IMAGO.L["HINT_CLASS_LOCKED_DESC"] or "Meet a member of this class in the world to reveal its chronicle entry.")
        return
    end

    f.detailTitle:Show()
    f.detailLineLeft:Show()
    f.detailLineRight:Show()
    f.detailTitle:SetText(data.name or slug)
    local classColor = RAID_CLASS_COLORS and RAID_CLASS_COLORS[data.classFile]
    if classColor then
        f.detailTitle:SetTextColor(classColor.r, classColor.g, classColor.b)
    else
        f.detailTitle:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end

    -- left column: class icon + class crest side by side, identical on
    -- every tab (captions like the race emblem box)
    local coords = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[data.classFile]
    if coords then
        f.classIcon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
        f.classIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
        f.classIcon:Show()
    else
        f.classIcon:Hide()
    end
    f.classIconCap:SetText(IMAGO.L["CLASS_CAP_ICON"] or "Class Icon")

    local crestPath = "Interface\\AddOns\\IMAGO_forever\\media\\classes\\" .. slug .. "_crest.tga"
    f.classCrest:SetTexture(crestPath)
    f.classCrest:SetTexCoord(0, 1, 0, 1)
    f.classCrest:Show()
    f.classCrestCap:SetText(IMAGO.L["CLASS_CAP_CREST"] or "Class Crest")
    f.classEmblemBox:Show()

    for _, t in ipairs(f.classTabs or {}) do t:Show() end
    f.infoScroll:Show()
    IMAGO.Chronicle.FillClassFacts(slug, data)
    IMAGO.Chronicle.RenderClassTab(f.activeClassTab or "overview")
end

--- Renders one class sub-tab into the shared info column.
--- Mirrors RenderRaceTab: same strip layout, pooled widgets, row and
--- accordion components. Left column is always the class emblem box.
function IMAGO.Chronicle.RenderClassTab(tabKey)
    local f = IMAGO.Chronicle.frame
    local data = f and f.selectedClass
    if not f or not data then return end

    f.infoScroll:ClearAllPoints()
    f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 302, -116)
    f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", -16, f._infoBottom or 100)
    f.infoScroll:SetVerticalScroll(0)
    if f.loreBody then f.loreBody:Hide() end

    -- Sub-tab strip: shared layout with the race tabs — same font size,
    -- same span (measured + gap-stretched in LayoutSubTabStrip).
    LayoutSubTabStrip(f.classTabs, "classTabKey", tabKey)

    -- Lazy-create the container + pooled widgets inside infoContent
    if not f.classContainer then
        f.classContainer = CreateFrame("Frame", nil, f.infoContent)
        f.classContainer:SetPoint("TOPLEFT", 10, 0)
        f.classContainer:SetSize(420, 1)
        f.classContainer.lines = {}
        f.classContainer.rows = {}
        f.classContainer.headers = {}
        f.classContainer.sections = {}
        f.classContainer:EnableMouse(true)
        f.classContainer:SetHyperlinksEnabled(true)
        f.classContainer:SetScript("OnHyperlinkClick", function(self, link, text, button)
            if IMAGO.TextLinker and IMAGO.TextLinker.OnHyperlinkClick then
                IMAGO.TextLinker.OnHyperlinkClick(self, link, text, button)
            end
        end)
    end
    local c = f.classContainer
    c:Show()
    for _, l in ipairs(c.lines) do l:Hide() end
    for _, r in ipairs(c.rows) do r:Hide() end
    for _, h in ipairs(c.headers) do h:Hide() end
    for _, s in ipairs(c.sections) do s:Hide() end
    if c.mtable then c.mtable:Hide() end

    local lineIdx, rowIdx, hdrIdx, secIdx = 0, 0, 0, 0
    local y = 0
    local contentW = math.max(1, (f.infoScroll:GetWidth() or 0) - IMAGO.LAYOUT.SCROLLBAR_GUTTER - 30)

    local function GetLine()
        lineIdx = lineIdx + 1
        local l = c.lines[lineIdx]
        if not l then
            l = c:CreateFontString(nil, "OVERLAY")
            l:SetFont(IMAGO.FONT_BODY, 13)
            l:SetJustifyH("LEFT")
            l:SetSpacing(5)
            c.lines[lineIdx] = l
        end
        l:SetWidth(contentW)
        return l
    end

    local function AddText(text, color, size, justify, font)
        local l = GetLine()
        l:SetFont(font or IMAGO.FONT_BODY, size or 13)
        l:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        l:SetText(text)
        l:SetJustifyH(justify or "LEFT")
        l:SetTextColor(color[1], color[2], color[3])
        l:Show()
        y = y + l:GetStringHeight() + 10
    end

    local function AddGap(px) y = y + (px or 6) end

    local function AddSectionHead(label)
        secIdx = secIdx + 1
        local h = c.sections[secIdx]
        if not h then
            h = CreateFrame("Frame", nil, c)
            h:SetSize(contentW, 24)
            h.t = h:CreateFontString(nil, "OVERLAY")
            h.t:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
            h.t:SetPoint("LEFT", 2, 0)
            h.line = h:CreateTexture(nil, "ARTWORK")
            h.line:SetHeight(1)
            h.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            c.sections[secIdx] = h
        end
        h.t:SetText(label)
        h.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        h.line:ClearAllPoints()
        h.line:SetPoint("LEFT", h.t, "RIGHT", 8, -1)
        h.line:SetWidth(math.max(1, contentW - h.t:GetStringWidth() - 12))
        h.line:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.5), CreateColor(0, 0, 0, 0))
        h:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        h:SetWidth(contentW)
        h:Show()
        y = y + 26
    end

    local function AddRow(name, title, onClick)
        rowIdx = rowIdx + 1
        local r = c.rows[rowIdx]
        if not r then
            r = CreateFrame("Button", nil, c)
            r:SetSize(contentW, 40)
            r.name = r:CreateFontString(nil, "OVERLAY")
            r.name:SetFont(IMAGO.FONT_BODY, 15, "")
            r.name:SetPoint("TOPLEFT", 2, -7)
            r.name:SetPoint("TOPRIGHT", -6, -7)
            r.name:SetJustifyH("LEFT")
            r.name:SetWordWrap(false)
            r.title = r:CreateFontString(nil, "OVERLAY")
            r.title:SetFont(IMAGO.FONT_BODY, 12, "")
            r.title:SetPoint("TOPLEFT", 2, -25)
            r.title:SetPoint("TOPRIGHT", -6, -25)
            r.title:SetJustifyH("LEFT")
            r.title:SetWordWrap(true)
            r.title:SetSpacing(3)
            r.line = r:CreateTexture(nil, "ARTWORK")
            r.line:SetHeight(1)
            r.line:SetPoint("BOTTOMLEFT", 2, 1)
            r.line:SetPoint("BOTTOMRIGHT", -2, 1)
            r.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            r.line:SetGradient("HORIZONTAL",
                CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.28),
                CreateColor(0, 0, 0, 0))
            local hl = r:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.15)
            c.rows[rowIdx] = r
        end
        r:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        r:SetWidth(contentW)
        if onClick then
            r.name:SetText("|c" .. IMAGO_HEX.GOLD_BRIGHT .. name .. "|r")
            r:EnableMouse(true)
            r:SetScript("OnClick", onClick)
        else
            r.name:SetText("|c" .. IMAGO_HEX.TEXT_PRIMARY .. name .. "|r")
            r:EnableMouse(false)
            r:SetScript("OnClick", nil)
        end
        r.title:SetText(title or "")
        r.title:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        local titleH = (title and title ~= "") and (r.title:GetStringHeight() + 6) or 0
        local rh = 30 + titleH
        r:SetHeight(rh)
        r:Show()
        y = y + rh + 2
    end

    -- Member table: caps header + zebra rows with fixed-width cells that
    -- wrap within their column. entries[i] = { name, cells = {...}, onClick }
    local function AddMemberTable(colFracs, colLabels, entries)
        if not c.mtable then
            local t = CreateFrame("Frame", nil, c)
            t.heads = {}
            t.rows = {}
            t.line = t:CreateTexture(nil, "ARTWORK")
            t.line:SetHeight(1)
            t.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            c.mtable = t
        end
        local t = c.mtable
        t:Show()
        t:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        local tw = contentW
        t:SetWidth(tw)
        local xs, x = {}, 0
        for i, fr in ipairs(colFracs) do
            xs[i] = x
            x = x + math.floor(tw * fr + 0.5)
        end
        for i, lab in ipairs(colLabels) do
            local h = t.heads[i]
            if not h then
                h = t:CreateFontString(nil, "OVERLAY")
                h:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
                h:SetJustifyH("LEFT")
                h:SetWordWrap(false)
                t.heads[i] = h
            end
            h:ClearAllPoints()
            h:SetPoint("TOPLEFT", xs[i] + 4, -4)
            h:SetWidth(math.max(1, (xs[i + 1] or tw) - xs[i] - 10))
            h:SetText(lab)
            h:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
            h:Show()
        end
        for i = #colLabels + 1, #t.heads do t.heads[i]:Hide() end
        t.line:ClearAllPoints()
        t.line:SetPoint("TOPLEFT", 0, -20)
        t.line:SetPoint("TOPRIGHT", 0, -20)
        t.line:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.6),
            CreateColor(0, 0, 0, 0))
        local ncols = #colFracs
        local ty = 24
        for ri, e in ipairs(entries) do
            local r = t.rows[ri]
            if not r then
                r = CreateFrame("Button", nil, t)
                r.cells = {}
                r.bg = r:CreateTexture(nil, "BACKGROUND")
                r.bg:SetAllPoints()
                r.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                r.line = r:CreateTexture(nil, "ARTWORK")
                r.line:SetHeight(1)
                r.line:SetPoint("BOTTOMLEFT", 0, 0)
                r.line:SetPoint("BOTTOMRIGHT", 0, 0)
                r.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                local hl = r:CreateTexture(nil, "HIGHLIGHT")
                hl:SetAllPoints()
                hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.15)
                t.rows[ri] = r
            end
            while #r.cells < ncols do
                local cell = r:CreateFontString(nil, "OVERLAY")
                cell:SetJustifyH("LEFT")
                cell:SetWordWrap(true)
                cell:SetSpacing(2)
                r.cells[#r.cells + 1] = cell
            end
            r:SetPoint("TOPLEFT", 0, -ty)
            r:SetWidth(tw)
            local maxH = 0
            for i = 1, ncols do
                local cell = r.cells[i]
                cell:ClearAllPoints()
                cell:SetPoint("TOPLEFT", xs[i] + 4, -5)
                cell:SetWidth(math.max(1, (xs[i + 1] or tw) - xs[i] - 10))
                if i == 1 then
                    cell:SetFont(IMAGO.FONT_BODY, 13)
                    local hex = e.onClick and IMAGO_HEX.GOLD_BRIGHT or IMAGO_HEX.TEXT_PRIMARY
                    cell:SetText("|c" .. hex .. (e.name or "") .. "|r")
                else
                    cell:SetFont(IMAGO.FONT_BODY, 12)
                    cell:SetText("|c" .. IMAGO_HEX.TEXT_SECONDARY .. (e.cells[i - 1] or "") .. "|r")
                end
                local hgt = cell:GetStringHeight()
                if hgt > maxH then maxH = hgt end
            end
            local rh = maxH + 12
            r:SetHeight(rh)
            r.line:SetGradient("HORIZONTAL",
                CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.22),
                CreateColor(0, 0, 0, 0))
            if ri % 2 == 0 then
                r.bg:Show()
                r.bg:SetGradient("HORIZONTAL",
                    CreateColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.35),
                    CreateColor(0, 0, 0, 0))
            else
                r.bg:Hide()
            end
            if e.onClick then
                r:EnableMouse(true)
                r:SetScript("OnClick", e.onClick)
            else
                r:EnableMouse(false)
                r:SetScript("OnClick", nil)
            end
            r:Show()
            ty = ty + rh
        end
        for i = #entries + 1, #t.rows do t.rows[i]:Hide() end
        t:SetHeight(math.max(1, ty))
        y = y + ty + 6
    end

    f.classExpanded = f.classExpanded or {}
    local function AddSection(key, label, body)
        hdrIdx = hdrIdx + 1
        local h = c.headers[hdrIdx]
        if not h then
            h = CreateFrame("Button", nil, c)
            h:SetSize(contentW, 26)
            h.bg = h:CreateTexture(nil, "BACKGROUND")
            h.bg:SetAllPoints()
            h.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            h.bg:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.3), CreateColor(0, 0, 0, 0))
            h.icon = h:CreateFontString(nil, "OVERLAY")
            h.icon:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
            h.icon:SetPoint("LEFT", 5, 0)
            h.t = h:CreateFontString(nil, "OVERLAY")
            h.t:SetFont(IMAGO.FONT_BODY, 13, "OUTLINE")
            h.t:SetPoint("LEFT", 20, 0)
            h.line = h:CreateTexture(nil, "ARTWORK")
            h.line:SetSize(contentW, 1)
            h.line:SetPoint("BOTTOM", 0, 0)
            h.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            h.line:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.5), CreateColor(0, 0, 0, 0))
            h:SetScript("OnClick", function(self)
                f.classExpanded[self._key] = not f.classExpanded[self._key]
                if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
                IMAGO.Chronicle.RenderClassTab(self._tabKey)
            end)
            c.headers[hdrIdx] = h
        end
        h._key = key
        h._tabKey = tabKey
        h:SetWidth(contentW)
        h.line:SetWidth(contentW)
        h:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -y)
        local open = f.classExpanded[key]
        h.icon:SetText(open and "-" or "+")
        h.icon:SetTextColor(open and IMAGO_COLORS.GOLD[1] or IMAGO_COLORS.GOLD_MUTED[1],
            open and IMAGO_COLORS.GOLD[2] or IMAGO_COLORS.GOLD_MUTED[2],
            open and IMAGO_COLORS.GOLD[3] or IMAGO_COLORS.GOLD_MUTED[3])
        h.t:SetText(label)
        h.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        h:Show()
        y = y + 30

        if open and body and body ~= "" then
            AddText(IMAGO.TextLinker.LinkNames(body), IMAGO_COLORS.TEXT_SECONDARY)
        end
    end

    local function Linkify(text)
        return IMAGO.TextLinker.LinkNames(text or "", nil, nil, nil, nil)
    end

    local function RaceName(rslug)
        local rd = IMAGOdb.races and IMAGOdb.races[rslug]
        local name = (rd and rd.name) or rslug
        if not IsRefDiscovered({ kind = "race", id = rslug }) then
            return GetCrypticName(name)
        end
        return name
    end

    -- "|Ticon|t Name" runs for the playable races — mirrors the race
    -- overview's class strip
    local function RaceStrip(races)
        local parts = {}
        for _, rslug in ipairs(races or {}) do
            local rd = IMAGOdb.races and IMAGOdb.races[rslug]
            if rd then
                local icon = rd.iconM and ("|T" .. rd.iconM .. ":14:14|t ") or ""
                local name = "|c" .. IMAGO_HEX.GOLD .. RaceName(rslug) .. "|r"
                if IsRefDiscovered({ kind = "race", id = rslug }) then
                    name = "|Himago-race:" .. rslug .. "|h" .. name .. "|h"
                end
                parts[#parts + 1] = icon .. name
            end
        end
        return table.concat(parts, "   ")
    end

    -- ---- CONTENT PER TAB ------------------------------------
    -- The class emblem box is the uniform left column on every tab.
    if tabKey == "overview" then
        local q = data.quote
        if q and q.text and q.text ~= "" then
            AddGap(10)
            AddText(string.format(IMAGO.L["RACE_QUOTE_FMT"] or "“%s”", q.text), IMAGO_COLORS.GOLD, 15, "CENTER", IMAGO.FONT_TITLE)
            if q.author and q.author ~= "" then
                AddText("— " .. q.author, IMAGO_COLORS.GOLD_MUTED, 12, "CENTER")
            end
            AddGap(8)
        end
        if data.overview and data.overview ~= "" then
            AddText(Linkify(data.overview), IMAGO_COLORS.TEXT_PRIMARY, 14)
        end
        if data.races and #data.races > 0 then
            AddGap(12)
            AddText("|c" .. IMAGO_HEX.GOLD_MUTED .. (IMAGO.L["CLASS_FACT_RACES"] or "RACES") .. "|r",
                IMAGO_COLORS.TEXT_SECONDARY)
            AddText(RaceStrip(data.races), IMAGO_COLORS.TEXT_SECONDARY)
        end

    elseif tabKey == "history" then
        local hist = data.history or ""
        local firstByte = string.byte(hist, 1)
        local charLen = firstByte and firstByte >= 192 and 2 or 1
        local linked = Linkify("|c" .. IMAGO_HEX.GOLD .. hist:sub(1, charLen) .. "|r" .. hist:sub(charLen + 1))
        AddText(linked, IMAGO_COLORS.TEXT_PRIMARY, 14)

    elseif tabKey == "races" then
        if data.racesIntro and data.racesIntro ~= "" then
            AddText(Linkify(data.racesIntro), IMAGO_COLORS.TEXT_PRIMARY, 14)
            AddGap(4)
        end
        local covered = {}
        for _, e in ipairs(data.raceEntries or {}) do
            if e.race and e.race ~= "" then
                covered[e.race] = true
                AddRow(RaceName(e.race), Linkify(e.text), function()
                    IMAGO.Chronicle.OpenToRace(e.race)
                end)
            end
        end
        -- races without their own entry line (e.g. prose-only §3)
        for _, rslug in ipairs(data.races or {}) do
            if not covered[rslug] then
                AddRow(RaceName(rslug), nil, function()
                    IMAGO.Chronicle.OpenToRace(rslug)
                end)
            end
        end
        if data.racesFoot and data.racesFoot ~= "" then
            AddGap(6)
            AddText(Linkify(data.racesFoot), IMAGO_COLORS.TEXT_SECONDARY)
        end

    elseif tabKey == "orgs" then
        if data.orgsIntro and data.orgsIntro ~= "" then
            AddText(Linkify(data.orgsIntro), IMAGO_COLORS.TEXT_SECONDARY)
            AddGap(2)
        end
        local any = false
        for _, key in ipairs(data.groups or {}) do
            local sg = data.groups[key]
            if type(sg) == "table" then
                any = true
                AddSection("grp:" .. key, sg.name or key, sg.lore)
            end
        end
        if data.orgsFoot and data.orgsFoot ~= "" then
            AddGap(4)
            AddText(data.orgsFoot, IMAGO_COLORS.TEXT_MUTED, 12)
        end
        if not any then
            AddText(IMAGO.L["RACE_EMPTY_GROUPS"] or "No groups recorded.", IMAGO_COLORS.TEXT_MUTED)
        end

    elseif tabKey == "members" then
        local entries = {}
        for _, m in ipairs(data.figures or {}) do
            local fk = m.slug or m.key
            local extra = fk and data.figureText and data.figureText[fk]
            local npcData = m.slug and IMAGO.GetNPCData(m.slug)
            if npcData then
                local slug = m.slug
                entries[#entries + 1] = {
                    name = npcData.name or slug,
                    cells = { (extra and extra.role) or npcData.race or "",
                              (extra and extra.aff) or "",
                              (extra and extra.race) or "" },
                    onClick = function() IMAGO.Chronicle.OpenToNPCSlug(slug) end,
                }
            elseif extra then
                -- no NPC dossier (dead slug or plain text figure) — the
                -- figure still belongs in the table, just not clickable
                entries[#entries + 1] = {
                    name = extra.name or fk,
                    cells = { extra.role or "", extra.aff or "", extra.race or "" },
                }
            else
                entries[#entries + 1] = {
                    name = fk or "?",
                    cells = { "", "", "" },
                }
            end
        end
        if #entries > 0 then
            AddMemberTable({ 0.26, 0.36, 0.22, 0.16 }, {
                IMAGO.L["MEMBER_COL_NAME"] or "Name",
                IMAGO.L["MEMBER_COL_ROLE"] or "Role",
                IMAGO.L["MEMBER_COL_AFF"] or "Affiliation",
                IMAGO.L["MEMBER_COL_RACE"] or "Race",
            }, entries)
        else
            AddText(IMAGO.L["RACE_EMPTY_FIGURES"] or "No notable figures recorded.", IMAGO_COLORS.TEXT_MUTED)
        end

    end

    c:SetHeight(math.max(1, y))
    f.infoContent:SetHeight(math.max(1, y + 20))
    IMAGO.UpdateScrollBarVisibility(f.infoScroll)
end

--- Navigate to a race by slug: switches to the Races tab and clicks its button.
function IMAGO.Chronicle.OpenToRace(slug)
    if not slug or not (IMAGOdb.races and IMAGOdb.races[slug]) then return false end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame
    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(4)
    f:Show()

    local function scrollToButton(btn)
        if not btn or not f.scrollFrame or not f.content then return end
        local range = math.max(0, (f.content:GetHeight() or 0) - (f.scrollFrame:GetHeight() or 0))
        local target = math.max(0, math.min(range, (btn._listScrollY or 0) - 40))
        f.scrollFrame:SetVerticalScroll(target)
    end

    for _, btn in pairs(IMAGO.Chronicle.raceButtons or {}) do
        if btn.raceSlug == slug and btn:IsShown() then
            local fn = btn:GetScript("OnClick")
            if fn then fn(btn) end
            C_Timer.After(0, function()
                if f:IsShown() then scrollToButton(btn) end
            end)
            return true
        end
    end

    return false
end

--- Opens the Chronicle (Fates tab), prepares the list, and runs the same logic as a click on the NPC.
--- opts.skipDiscoveryCinematic: skip the discovery cinematic (e.g. context menu).
function IMAGO.Chronicle.OpenToNPCSlug(slug, opts)
    opts = opts or {}
    if type(slug) ~= "string" or slug == "" or not IMAGO.GetNPCData(slug) then
        return false
    end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame

    -- Push current page onto nav stack before navigating away.
    -- Skip if navigating back, or already on this NPC.
    if not isNavigatingBack then
        local entry = nil
        if f.selectedNPCSlug and f.selectedNPCSlug ~= "" and f.selectedNPCSlug ~= slug then
            entry = { type = "npc", slug = f.selectedNPCSlug }
        elseif f.selectedZoneMapID then
            entry = { type = "zone", mapID = f.selectedZoneMapID }
        elseif f.selectedRaceSlug then
            entry = { type = "race", slug = f.selectedRaceSlug }
        elseif f.selectedClassSlug then
            entry = { type = "class", slug = f.selectedClassSlug }
        elseif f.selectedCodexSlug then
            entry = { type = "codex", slug = f.selectedCodexSlug }
        elseif f.selectedTimelineSlug then
            entry = { type = "timeline", slug = f.selectedTimelineSlug }
        end
        if entry then
            table.insert(navStack, entry)
            if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
        end
    end
    f.selectedZoneMapID = nil
    f.selectedRaceSlug = nil
    f.selectedClassSlug = nil
    f.selectedCodexSlug = nil
    f.selectedTimelineSlug = nil
    f.selectedTimelineEra = nil

    local data = IMAGO.GetNPCData(slug)
    if not data then return false end

    f.activeFilter = "ALL"
    if f.searchBox then f.searchBox:SetText("") end

    -- only the opened entry's group is expanded by default
    local cat = data.category or "CAT_ENIGMATIC"
    IMAGO.Chronicle.expandedCats = { [cat] = true }

    if opts.skipDiscoveryCinematic then
        IMAGOSaved.viewedNPCs = IMAGOSaved.viewedNPCs or {}
        IMAGOSaved.viewedNPCs[slug] = true
    end

    f.selectedNPC = data
    f.selectedNPCSlug = slug

    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(2)
    f:Show()

    local function scrollToButton(btn)
        if not btn or not f.scrollFrame or not f.content then return end
        local scroll = f.scrollFrame
        local range = 0
        if scroll.GetVerticalScrollRange then
            range = scroll:GetVerticalScrollRange() or 0
        else
            range = math.max(0, (f.content:GetHeight() or 0) - (scroll:GetHeight() or 0))
        end
        local y = btn._listScrollY or 0
        local target = math.max(0, math.min(range, y - 40))
        scroll:SetVerticalScroll(target)
    end

    for _, btn in pairs(IMAGO.Chronicle.buttons or {}) do
        if btn.npcSlug == slug and btn:IsShown() then
            if btn.Click then
                btn:Click()
            else
                local fn = btn:GetScript("OnClick")
                if fn then fn(btn) end
            end
            C_Timer.After(0, function()
                if f:IsShown() then scrollToButton(btn) end
            end)
            return true
        end
    end

    return false
end

--- Navigate back to a zone by mapID: switches to the zones tab, finds the button, and clicks it.
function IMAGO.Chronicle.OpenToZoneMapID(mapID)
    if not mapID then return false end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame
    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(3)
    f:Show()

    local function scrollToButton(btn)
        if not btn or not f.scrollFrame or not f.content then return end
        local scroll = f.scrollFrame
        local range = math.max(0, (f.content:GetHeight() or 0) - (scroll:GetHeight() or 0))
        local _, _, _, _, btnY = btn:GetPoint()
        local target = math.max(0, math.min(range, -(btnY or 0) - 40))
        scroll:SetVerticalScroll(target)
    end

    for _, btn in pairs(IMAGO.Chronicle.zoneButtons or {}) do
        if btn.zoneMapID == mapID and btn:IsShown() then
            local fn = btn:GetScript("OnClick")
            if fn then fn(btn) end
            C_Timer.After(0, function()
                if f:IsShown() then scrollToButton(btn) end
            end)
            return true
        end
    end

    return false
end

-- ============================================================
-- CODEX RENDERER (TAB 5)
-- ============================================================

--- Sorted entry list for a category; honors the sidebar search box
--- (search hits all categories, match on title or body).
function IMAGO.Chronicle.GetCodexEntries(catKey)
    local f = IMAGO.Chronicle.frame
    local searchString = ""
    if f and f.searchBox then
        searchString = (f.searchBox:GetText() or ""):lower()
    end

    local list = {}
    for slug, data in pairs(IMAGOdb.codex and IMAGOdb.codex.entries or {}) do
        local matchCat = (catKey == nil) or (data.category == catKey)
        if matchCat then
            local matchSearch = true
            if searchString ~= "" then
                local title = (data.title or slug):lower()
                local body = (data.body or ""):lower()
                matchSearch = title:find(searchString, 1, true) ~= nil
                    or body:find(searchString, 1, true) ~= nil
            end
            if matchSearch then
                table.insert(list, { slug = slug, data = data })
            end
        end
    end
    table.sort(list, function(a, b)
        local oa, ob = a.data.order or 999, b.data.order or 999
        if oa ~= ob then return oa < ob end
        return (a.data.title or a.slug) < (b.data.title or b.slug)
    end)
    return list
end

--- Resolves a `related` reference to a display name + click handler.
--- Returns nil for unresolvable refs so dead chips are hidden.
local function ResolveCodexRef(ref)
    if type(ref) ~= "table" then return nil end
    if ref.type == "timeline" then
        local ev = IMAGOdb.timeline and IMAGOdb.timeline.events and IMAGOdb.timeline.events[ref.slug]
        if ev then
            return ev.title or ref.slug, function() IMAGO.Chronicle.OpenToTimeline(ref.slug) end
        end
    elseif ref.type == "codex" then
        local e = IMAGOdb.codex and IMAGOdb.codex.entries and IMAGOdb.codex.entries[ref.slug]
        if e then
            return e.title or ref.slug, function() IMAGO.Chronicle.OpenToCodex(ref.slug) end
        end
    elseif ref.type == "race" then
        local r = IMAGOdb.races and IMAGOdb.races[ref.slug]
        if r then
            return r.name or ref.slug, function() IMAGO.Chronicle.OpenToRace(ref.slug) end
        end
    elseif ref.type == "class" then
        local c = IMAGOdb.classes and IMAGOdb.classes[ref.slug]
        if c then
            return c.name or ref.slug, function() IMAGO.Chronicle.OpenToClass(ref.slug) end
        end
    elseif ref.type == "npc" then
        local n = IMAGO.GetNPCData(ref.slug)
        if n then
            return n.name or ref.slug, function() IMAGO.Chronicle.OpenToNPCSlug(ref.slug, { skipDiscoveryCinematic = true }) end
        end
    elseif ref.type == "zone" then
        local z = IMAGOdb.zones and IMAGOdb.zones[ref.mapID]
        if z then
            return z.name or tostring(ref.mapID), function() IMAGO.Chronicle.OpenToZoneMapID(ref.mapID) end
        end
    end
    return nil
end

--- Collects every related ref for a detail view: entries the body
--- text links to (FindReferences) plus entries whose texts link
--- back to this one (backlink index). Fully automatic — there are
--- no curated related lists anymore. Returns refs in the
--- ResolveCodexRef shape: { type, slug } / { type = "zone", mapID }.
local function CollectRelatedRefs(kind, id, body)
    local refs, seen = {}, {}
    local function push(rkind, rid)
        local tag = rkind .. ":" .. tostring(rid)
        if not seen[tag] then
            seen[tag] = true
            if rkind == "zone" then
                refs[#refs + 1] = { type = "zone", mapID = rid }
            else
                refs[#refs + 1] = { type = rkind, slug = rid }
            end
        end
    end
    for _, r in ipairs(IMAGO.TextLinker.FindReferences({ body or "" }, { [kind] = id })) do
        push(r.kind, r.id)
    end
    for _, r in ipairs(IMAGO.TextLinker.GetBacklinks(kind, id)) do
        push(r.kind, r.id)
    end
    return refs
end

--- Locale-safe uppercase (string.upper ignores umlauts & cyrillic;
--- German umlauts map here, other scripts pass through unchanged)
local function ToDisplayCaps(s)
    if not s then return "" end
    s = s:gsub("ä", "Ä"):gsub("ö", "Ö"):gsub("ü", "Ü")
    return s:upper()
end

--- Shared related-entry chip (Codex + Timeline detail views).
local function MakeRelatedChip(parent)
    local chip = CreateFrame("Button", nil, parent, "BackdropTemplate")
    chip:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    })
    chip.t = chip:CreateFontString(nil, "OVERLAY")
    chip.t:SetFont(IMAGO.FONT_BODY, 12, "")
    chip.t:SetPoint("CENTER")
    chip:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 1)
        self.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end)
    chip:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7)
        self.t:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    end)
    return chip
end

--- Applies text, size, colors and click handler — identical for
--- Codex and Timeline chips.
local function ConfigureRelatedChip(chip, name, onClick)
    chip.t:SetText(name)
    chip.t:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    chip:SetSize(math.floor(chip.t:GetStringWidth() + 22 + 0.5), 24)
    chip:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.8)
    chip:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7)
    chip:SetScript("OnClick", onClick)
end

--- Builds the middle column entry list for the selected category.
function IMAGO.Chronicle.RenderCodexCategory(catKey)
    local f = IMAGO.Chronicle.frame
    if not f then return end

    -- Heading where the back button used to be: current category (or search state)
    if f.codexCatHeading then
        if catKey then
            f.codexCatHeading:SetText(ToDisplayCaps(IMAGO.L["CODEX_CAT_" .. catKey:upper()]
                or (IMAGOdb.codexCatNames and IMAGOdb.codexCatNames[catKey]) or catKey))
        else
            f.codexCatHeading:SetText(ToDisplayCaps(IMAGO.L["CODEX_SEARCH_RESULTS"] or "Search Results"))
        end
        f.codexCatHeading:Show()
    end

    f.codexEntryButtons = f.codexEntryButtons or {}
    local list = IMAGO.Chronicle.GetCodexEntries(catKey)
    local yOffset = 4
    local contentW = 236

    local eIdx = 1
    for _, entry in ipairs(list) do
        local btn = f.codexEntryButtons[eIdx]
        if not btn then
            btn = CreateFrame("Button", nil, f.codexListContent)
            btn:SetSize(contentW, 40)

            btn.bg = btn:CreateTexture(nil, "BACKGROUND")
            btn.bg:SetAllPoints()

            btn.activeBar = btn:CreateTexture(nil, "OVERLAY")
            btn.activeBar:SetWidth(2)
            btn.activeBar:SetPoint("TOPLEFT",    btn, "TOPLEFT",    0, -3)
            btn.activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 0,  3)
            btn.activeBar:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            btn.activeBar:Hide()

            local hl = btn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

            btn.t = btn:CreateFontString(nil, "OVERLAY")
            IMAGO.ApplyTextStyle(btn.t, "NAV_ITEM")
            btn.t:SetPoint("LEFT", btn, "LEFT", 10, 0)
            btn.t:SetPoint("RIGHT", btn, "RIGHT", -18, 0)
            btn.t:SetJustifyH("LEFT")
            btn.t:SetWordWrap(false)

            btn.chevron = btn:CreateFontString(nil, "OVERLAY")
            btn.chevron:SetFont(IMAGO.FONT_BODY, 12, "")
            btn.chevron:SetPoint("RIGHT", btn, "RIGHT", -5, 0)
            btn.chevron:SetText(">")
            btn.chevron:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

            btn:SetScript("OnEnter", function(self)
                IMAGO.ShowTooltipIfTruncated(self, self.t)
            end)
            btn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            f.codexEntryButtons[eIdx] = btn
        end

        btn:SetPoint("TOPLEFT", f.codexListContent, "TOPLEFT", 0, -yOffset)
        btn.codexSlug = entry.slug
        btn._listScrollY = yOffset
        btn._zebra = (eIdx % 2 == 0)
        btn.bg:SetColorTexture(1, 1, 1, (btn._zebra and 0.03) or 0)
        btn.t:SetText(entry.data.title or entry.slug)

        if f.selectedCodexSlug == entry.slug then
            btn.activeBar:Show()
            btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
        else
            btn.activeBar:Hide()
            local c = entry.data.stub and IMAGO_COLORS.TEXT_MUTED or IMAGO_COLORS.TEXT_PRIMARY
            btn.t:SetTextColor(c[1], c[2], c[3])
        end

        btn:SetScript("OnClick", function(self)
            if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
            IMAGO.Chronicle.RenderCodexEntry(self.codexSlug)
        end)

        btn:Show()
        yOffset = yOffset + 40
        eIdx = eIdx + 1
    end

    for i = eIdx, #f.codexEntryButtons do
        f.codexEntryButtons[i]:Hide()
    end

    f.codexListContent:SetHeight(math.max(1, yOffset))
    IMAGO.UpdateScrollBarVisibility(f.codexListScroll)
    f.codexListPanel:Show()
end

--- Renders one codex entry into the right content column.
function IMAGO.Chronicle.RenderCodexEntry(slug)
    local f = IMAGO.Chronicle.frame
    if not f then return end

    local data = slug and IMAGOdb.codex and IMAGOdb.codex.entries and IMAGOdb.codex.entries[slug]
    if not data then
        -- Empty state (e.g. category has no entries)
        f.selectedCodexSlug = nil
        f.selectedTimelineSlug = nil
        f.selectedTimelineEra = nil
        f.codexTitle:SetText("")
        f.codexCatTag:SetText("")
        f.codexBody:SetText("|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["CODEX_EMPTY"] or "No entries in this category.") .. "|r")
        for _, chip in ipairs(f.codexChips or {}) do chip:Hide() end
        if f.codexRelatedHead then f.codexRelatedHead:Hide() end
        f.codexBodyContent:SetHeight(60)
        f.codexContent:Show()
        return
    end

    -- navStack: push the previous codex page
    if not isNavigatingBack and f.selectedCodexSlug and f.selectedCodexSlug ~= slug then
        table.insert(navStack, { type = "codex", slug = f.selectedCodexSlug })
        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
    end
    f.selectedCodexSlug = slug

    -- Highlight in the middle list (rebuild if category mismatch)
    if data.category and data.category ~= f.selectedCodexCat then
        f.selectedCodexCat = data.category
        IMAGO.Chronicle.UpdateList()
    end
    IMAGO.Chronicle.RenderCodexCategory(f.selectedCodexCat)

    f.codexTitle:SetText(data.title or slug)

    local catName = IMAGO.L["CODEX_CAT_" .. (data.category or ""):upper()]
        or (IMAGOdb.codexCatNames and IMAGOdb.codexCatNames[data.category]) or ""
    f.codexCatTag:SetText(catName ~= "" and ToDisplayCaps(catName) or "")

    -- text column follows the scroll viewport (minus the scrollbar gutter)
    local bodyW = math.max(1, (f.codexBodyScroll:GetWidth() or 0) - IMAGO.LAYOUT.SCROLLBAR_GUTTER)
    f.codexBodyContent:SetWidth(bodyW)
    f.codexBody:SetWidth(bodyW)

    local body = data.body or ""
    body = IMAGO.TextLinker.LinkNames(body, nil, nil, nil, nil, nil, slug)
    f.codexBody:SetText(WrapGlue(body))

    -- Chip list = everything the linker marked in the body text
    -- plus everything that links back to this entry. Fully
    -- automatic — no curated related lists.
    local chipRefs = CollectRelatedRefs("codex", slug, data.body)

    -- Related-entry chips below the body text
    f.codexChips = f.codexChips or {}
    local bodyH = f.codexBody:GetStringHeight()
    local chipY = bodyH + 20

    if not f.codexRelatedHead then
        f.codexRelatedHead = f.codexBodyContent:CreateFontString(nil, "OVERLAY")
        f.codexRelatedHead:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
        f.codexRelatedHead:SetJustifyH("LEFT")
        f.codexRelatedHead:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    end

    local chipIdx = 1
    local chipX = 0
    local rowH = 26
    local maxW = bodyW - 5
    if #chipRefs > 0 then
        f.codexRelatedHead:SetPoint("TOPLEFT", f.codexBodyContent, "TOPLEFT", 0, -chipY)
        f.codexRelatedHead:SetText("|TInterface\\Buttons\\UI-GuildButton-PublicNote-Up:12:12|t  " .. (IMAGO.L["CODEX_RELATED"] or "RELATED ENTRIES"))
        f.codexRelatedHead:Show()
        chipY = chipY + 20

        for _, ref in ipairs(chipRefs) do
            local name, onClick = ResolveCodexRef(ref)
            if name then
                local chip = f.codexChips[chipIdx]
                if not chip then
                    chip = MakeRelatedChip(f.codexBodyContent)
                    f.codexChips[chipIdx] = chip
                end

                ConfigureRelatedChip(chip, name, onClick)

                if chipX + chip:GetWidth() > maxW then
                    chipX = 0
                    chipY = chipY + rowH
                end
                chip:SetPoint("TOPLEFT", f.codexBodyContent, "TOPLEFT",
                    math.floor(chipX + 0.5), -math.floor(chipY + 0.5))
                chip:Show()
                chipX = chipX + chip:GetWidth() + 8
                chipIdx = chipIdx + 1
            end
        end
        chipY = chipY + rowH
    else
        f.codexRelatedHead:Hide()
    end

    for i = chipIdx, #f.codexChips do
        f.codexChips[i]:Hide()
    end

    f.codexBodyContent:SetHeight(math.max(1, chipY + 10))
    f.codexBodyScroll:SetVerticalScroll(0)
    IMAGO.UpdateScrollBarVisibility(f.codexBodyScroll)
    f.codexContent:Show()
end

--- Default state for the Codex tab: first category, first entry.
function IMAGO.Chronicle.ShowCodexDefault()
    local f = IMAGO.Chronicle.frame
    if not f then return end

    if f.codexListPanel then f.codexListPanel:Show() end
    if f.codexContent then f.codexContent:Show() end

    local searchActive = f.searchBox and (f.searchBox:GetText() or "") ~= ""

    if searchActive then
        -- Search hits are listed category-less in the middle column
        local hits = IMAGO.Chronicle.GetCodexEntries(nil)
        f.selectedCodexCat = nil
        IMAGO.Chronicle.RenderCodexCategory(nil)
        if hits[1] then
            IMAGO.Chronicle.RenderCodexEntry(hits[1].slug)
        else
            f.codexTitle:SetText("")
            f.codexCatTag:SetText("")
            f.codexBody:SetText("|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["CODEX_SEARCH_EMPTY"] or "No entries match this search.") .. "|r")
            if f.codexRelatedHead then f.codexRelatedHead:Hide() end
            for _, chip in ipairs(f.codexChips or {}) do chip:Hide() end
            f.codexBodyContent:SetHeight(60)
            f.codexContent:Show()
        end
        return
    end

    local cats = IMAGOdb.codex and IMAGOdb.codex.categories or {}
    local catKey = f.selectedCodexCat or (cats[1] and cats[1].key)
    f.selectedCodexCat = catKey

    IMAGO.Chronicle.RenderCodexCategory(catKey)

    -- Keep current entry if it belongs to the category; else first entry
    local slug = f.selectedCodexSlug
    local data = slug and IMAGOdb.codex.entries[slug]
    if not data or data.category ~= catKey then
        local first = IMAGO.Chronicle.GetCodexEntries(catKey)[1]
        slug = first and first.slug or nil
    end
    IMAGO.Chronicle.RenderCodexEntry(slug)
end

--- Public navigation API: open the Codex tab at a given entry.
function IMAGO.Chronicle.OpenToCodex(slug)
    if not slug or not (IMAGOdb.codex and IMAGOdb.codex.entries and IMAGOdb.codex.entries[slug]) then
        return false
    end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame
    local data = IMAGOdb.codex.entries[slug]

    -- Push current page onto nav stack before navigating away.
    if not isNavigatingBack then
        local entry = nil
        if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
            entry = { type = "npc", slug = f.selectedNPCSlug }
        elseif f.selectedZoneMapID then
            entry = { type = "zone", mapID = f.selectedZoneMapID }
        elseif f.selectedRaceSlug then
            entry = { type = "race", slug = f.selectedRaceSlug }
        elseif f.selectedClassSlug then
            entry = { type = "class", slug = f.selectedClassSlug }
        elseif f.selectedCodexSlug and f.selectedCodexSlug ~= slug then
            entry = { type = "codex", slug = f.selectedCodexSlug }
        elseif f.selectedTimelineSlug then
            entry = { type = "timeline", slug = f.selectedTimelineSlug }
        end
        if entry then
            table.insert(navStack, entry)
            if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
        end
    end
    f.selectedNPCSlug = nil
    f.selectedZoneMapID = nil
    f.selectedRaceSlug = nil
    f.selectedClassSlug = nil

    f.selectedCodexCat = data.category
    f.selectedCodexSlug = nil  -- RenderCodexEntry sets it (and may push navStack)
    f.selectedTimelineSlug = nil
    f.selectedTimelineEra = nil

    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(7)
    f:Show()

    IMAGO.Chronicle.RenderCodexEntry(slug)

    -- Scroll the middle list to the entry's button
    C_Timer.After(0, function()
        if not f:IsShown() then return end
        for _, btn in pairs(f.codexEntryButtons or {}) do
            if btn.codexSlug == slug and btn:IsShown() then
                local range = math.max(0, (f.codexListContent:GetHeight() or 0) - (f.codexListScroll:GetHeight() or 0))
                local target = math.max(0, math.min(range, (btn._listScrollY or 0) - 40))
                f.codexListScroll:SetVerticalScroll(target)
                break
            end
        end
    end)

    return true
end

--- Navigate to a class by slug: switches to the Classes tab and clicks its button.
function IMAGO.Chronicle.OpenToClass(slug)
    if not slug or not (IMAGOdb.classes and IMAGOdb.classes[slug]) then return false end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame
    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(5)
    f:Show()

    for _, btn in pairs(IMAGO.Chronicle.classButtons or {}) do
        if btn.classSlug == slug and btn:IsShown() then
            local fn = btn:GetScript("OnClick")
            if fn then fn(btn) end
            return true
        end
    end

    return false
end

-- ============================================================
-- TIMELINE TAB (index 5): eras > chronology > event detail
-- ============================================================

--- Events for one era (or all eras when eraKey == nil during search),
--- sorted by `year` then `order`. Optionally filters by search text.
function IMAGO.Chronicle.GetTimelineEvents(eraKey)
    local f = IMAGO.Chronicle.frame
    local search = ""
    if f and f.searchBox then
        search = (f.searchBox:GetText() or ""):lower()
    end

    local list = {}
    for slug, data in pairs(IMAGOdb.timeline and IMAGOdb.timeline.events or {}) do
        if not eraKey or data.era == eraKey then
            local matchSearch = true
            if search ~= "" then
                local title = (data.title or ""):lower()
                local body = (data.body or ""):lower()
                matchSearch = title:find(search, 1, true) ~= nil or body:find(search, 1, true) ~= nil
            end
            if matchSearch then
                table.insert(list, { slug = slug, data = data })
            end
        end
    end
    table.sort(list, function(a, b)
        local ya, yb = a.data.year or 0, b.data.year or 0
        if ya ~= yb then return ya < yb end
        local oa, ob = a.data.order or 999, b.data.order or 999
        if oa ~= ob then return oa < ob end
        return (a.data.title or a.slug) < (b.data.title or b.slug)
    end)
    return list
end

--- Builds the middle column chronology for the selected era
--- (eraKey == nil renders cross-era search hits).
function IMAGO.Chronicle.RenderTimelineEra(eraKey)
    local f = IMAGO.Chronicle.frame
    if not f then return end

    -- Heading where the back button used to be: static "CHRONOLOGY"
    -- (or the search state, matching the Codex behavior)
    if f.timelineChronoHeading then
        if eraKey then
            f.timelineChronoHeading:SetText(IMAGO.L["TIMELINE_CHRONOLOGY"] or "CHRONOLOGY")
        else
            f.timelineChronoHeading:SetText(IMAGO.L["TIMELINE_SEARCH_RESULTS"] or "Search Results")
        end
        f.timelineChronoHeading:Show()
    end

    f.timelineEventButtons = f.timelineEventButtons or {}
    local list = IMAGO.Chronicle.GetTimelineEvents(eraKey)
    local yOffset = 6
    local contentW = 236
    local rowH = 40
    local lineX = 9        -- center of the vertical line
    local nodeSize = 10

    local eIdx = 1
    local firstCenterY, lastCenterY
    for _, entry in ipairs(list) do
        local btn = f.timelineEventButtons[eIdx]
        if not btn then
            btn = CreateFrame("Button", nil, f.timelineListContent, "BackdropTemplate")
            btn:SetSize(contentW - 22, rowH - 4)

            btn:SetBackdrop({
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeSize = 8,
                insets = { left = 2, right = 2, top = 2, bottom = 2 }
            })

            local hl = btn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.2)

            btn.node = f.timelineListContent:CreateTexture(nil, "ARTWORK")
            btn.node:SetSize(nodeSize, nodeSize)
            btn.node:SetTexture("Interface\\COMMON\\Indicator-Yellow")

            btn.year = btn:CreateFontString(nil, "OVERLAY")
            btn.year:SetFont(IMAGO.FONT_BODY, 12, "OUTLINE")
            btn.year:SetPoint("TOPLEFT", btn, "TOPLEFT", 8, -5)
            btn.year:SetPoint("RIGHT", btn, "RIGHT", -8, 0)
            btn.year:SetJustifyH("LEFT")
            btn.year:SetWordWrap(false)
            btn.year:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

            btn.t = btn:CreateFontString(nil, "OVERLAY")
            btn.t:SetFont(IMAGO.FONT_BODY, 12, "")
            btn.t:SetPoint("TOPLEFT", btn.year, "BOTTOMLEFT", 0, -1)
            btn.t:SetPoint("RIGHT", btn, "RIGHT", -8, 0)
            btn.t:SetJustifyH("LEFT")
            btn.t:SetWordWrap(false)
            btn.t:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])

            btn:SetScript("OnEnter", function(self)
                IMAGO.ShowTooltipIfTruncated(self, self.t)
            end)
            btn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            f.timelineEventButtons[eIdx] = btn
        end

        local centerY = yOffset + rowH / 2
        if not firstCenterY then firstCenterY = centerY end
        lastCenterY = centerY

        btn:SetPoint("TOPLEFT", f.timelineListContent, "TOPLEFT", 22, -yOffset)
        btn.node:ClearAllPoints()
        btn.node:SetPoint("CENTER", f.timelineListContent, "TOPLEFT", lineX, -centerY)
        btn.node:Show()

        btn.timelineSlug = entry.slug
        btn._listScrollY = yOffset
        btn.t:SetText(entry.data.title or entry.slug)
        btn.year:SetText(entry.data.yearLabel or tostring(entry.data.year or ""))

        if f.selectedTimelineSlug == entry.slug then
            btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
            btn.node:SetDesaturated(false)
            btn.node:SetAlpha(1)
            btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
        else
            btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
            btn.node:SetDesaturated(true)
            btn.node:SetAlpha(0.45)
            -- stub = text still being written — dimmed like Codex stubs
            local c = entry.data.stub and IMAGO_COLORS.TEXT_MUTED or IMAGO_COLORS.TEXT_PRIMARY
            btn.t:SetTextColor(c[1], c[2], c[3])
        end

        btn:SetScript("OnClick", function(self)
            if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
            IMAGO.Chronicle.RenderTimelineEvent(self.timelineSlug)
        end)

        btn:Show()
        yOffset = yOffset + rowH
        eIdx = eIdx + 1
    end

    -- Stretch the vertical line from the first to the last node
    if f.timelineListContent.line then
        if firstCenterY then
            f.timelineListContent.line:ClearAllPoints()
            f.timelineListContent.line:SetPoint("TOP", f.timelineListContent, "TOPLEFT", lineX, -firstCenterY)
            f.timelineListContent.line:SetPoint("BOTTOM", f.timelineListContent, "TOPLEFT", lineX, -lastCenterY)
            f.timelineListContent.line:Show()
        else
            f.timelineListContent.line:Hide()
        end
    end

    for i = eIdx, #f.timelineEventButtons do
        local stale = f.timelineEventButtons[i]
        stale:Hide()
        if stale.node then stale.node:Hide() end
    end

    f.timelineListContent:SetHeight(math.max(1, yOffset))
    IMAGO.UpdateScrollBarVisibility(f.timelineListScroll)
    f.timelineListPanel:Show()
end

--- Renders one timeline event into the right content column.
function IMAGO.Chronicle.RenderTimelineEvent(slug)
    local f = IMAGO.Chronicle.frame
    if not f then return end

    local data = slug and IMAGOdb.timeline and IMAGOdb.timeline.events and IMAGOdb.timeline.events[slug]
    if not data then
        f.selectedTimelineSlug = nil
        f.timelineTitle:SetText("")
        f.timelineEraTag:SetText("")
        f.timelineBody:SetText("|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["TIMELINE_EMPTY"] or "No events in this era.") .. "|r")
        for _, chip in ipairs(f.tlChips or {}) do chip:Hide() end
        if f.tlRelatedHead then f.tlRelatedHead:Hide() end
        f.timelineBodyContent:SetHeight(60)
        f.timelineContent:Show()
        return
    end

    -- navStack: push the previous timeline page
    if not isNavigatingBack and f.selectedTimelineSlug and f.selectedTimelineSlug ~= slug then
        table.insert(navStack, { type = "timeline", slug = f.selectedTimelineSlug })
        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
    end
    f.selectedTimelineSlug = slug

    -- Highlight in the middle list (rebuild if era mismatch)
    if data.era and data.era ~= f.selectedTimelineEra then
        f.selectedTimelineEra = data.era
        IMAGO.Chronicle.UpdateList()
    end
    IMAGO.Chronicle.RenderTimelineEra(f.selectedTimelineEra)

    local yearLabel = data.yearLabel or ""
    f.timelineTitle:SetText((data.title or slug) .. (yearLabel ~= "" and ("  (" .. yearLabel .. ")") or ""))

    local eraName = (IMAGOdb.timelineEraNames and IMAGOdb.timelineEraNames[data.era]) or data.era or ""
    local tag = IMAGO.L["TIMELINE_TAG"] or "HISTORICAL TIMELINE"
    f.timelineEraTag:SetText(ToDisplayCaps(eraName .. " / " .. tag))

    -- Divider and body scroll follow the actual header height
    -- (long titles wrap onto a second line)
    local headH = f.timelineTitle:GetStringHeight() + f.timelineEraTag:GetStringHeight() + 16
    f.timelineDivider:ClearAllPoints()
    f.timelineDivider:SetPoint("TOPLEFT", f.timelineEraTag, "BOTTOMLEFT", 0, -8)
    f.timelineDivider:SetPoint("TOPRIGHT", f.timelineContent, "TOPRIGHT", -10, -headH)
    f.timelineBodyScroll:ClearAllPoints()
    f.timelineBodyScroll:SetPoint("TOPLEFT", f.timelineContent, "TOPLEFT", 10, -(headH + 12))
    f.timelineBodyScroll:SetPoint("BOTTOMRIGHT", f.timelineContent, "BOTTOMRIGHT", -10, 10)

    local body = data.body or ""
    if data.stub then
        -- Entry text is still being written — show a muted note
        -- instead of placeholder lore.
        body = "|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["TIMELINE_STUB"] or "This entry is still being written.") .. "|r"
    else
        body = IMAGO.TextLinker.LinkNames(body, nil, nil, nil, nil, nil, nil, nil, slug)
    end
    -- text column follows the scroll viewport (minus the scrollbar gutter)
    local tlBodyW = math.max(1, (f.timelineBodyScroll:GetWidth() or 0) - IMAGO.LAYOUT.SCROLLBAR_GUTTER)
    f.timelineBodyContent:SetWidth(tlBodyW)
    f.timelineBody:SetWidth(tlBodyW)
    f.timelineBody:SetText(WrapGlue(body))

    -- Related-entry chips below the body text (same widget style as Codex)
    f.tlChips = f.tlChips or {}
    local bodyH = f.timelineBody:GetStringHeight()
    local chipY = bodyH + 20

    if not f.tlRelatedHead then
        f.tlRelatedHead = f.timelineBodyContent:CreateFontString(nil, "OVERLAY")
        f.tlRelatedHead:SetFont(IMAGO.FONT_BODY, 11, "OUTLINE")
        f.tlRelatedHead:SetJustifyH("LEFT")
        f.tlRelatedHead:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    end

    -- Same automatic chips as the Codex: outgoing text links
    -- plus backlink chips (entries that link back here).
    local chipRefs = CollectRelatedRefs("timeline", slug, data.body)

    local chipIdx = 1
    local chipX = 0
    local rowH = 26
    local maxW = tlBodyW - 5
    if #chipRefs > 0 then
        f.tlRelatedHead:SetPoint("TOPLEFT", f.timelineBodyContent, "TOPLEFT", 0, -chipY)
        f.tlRelatedHead:SetText("|TInterface\\Buttons\\UI-GuildButton-PublicNote-Up:12:12|t  " .. (IMAGO.L["TIMELINE_RELATED"] or "RELATED ENTRIES"))
        f.tlRelatedHead:Show()
        chipY = chipY + 20

        for _, ref in ipairs(chipRefs) do
            local name, onClick = ResolveCodexRef(ref)
            if name then
                local chip = f.tlChips[chipIdx]
                if not chip then
                    chip = MakeRelatedChip(f.timelineBodyContent)
                    f.tlChips[chipIdx] = chip
                end

                ConfigureRelatedChip(chip, name, onClick)

                if chipX + chip:GetWidth() > maxW then
                    chipX = 0
                    chipY = chipY + rowH
                end
                chip:SetPoint("TOPLEFT", f.timelineBodyContent, "TOPLEFT",
                    math.floor(chipX + 0.5), -math.floor(chipY + 0.5))
                chip:Show()
                chipX = chipX + chip:GetWidth() + 8
                chipIdx = chipIdx + 1
            end
        end
        chipY = chipY + rowH
    else
        f.tlRelatedHead:Hide()
    end

    for i = chipIdx, #f.tlChips do
        f.tlChips[i]:Hide()
    end

    f.timelineBodyContent:SetHeight(math.max(1, chipY + 10))
    f.timelineBodyScroll:SetVerticalScroll(0)
    IMAGO.UpdateScrollBarVisibility(f.timelineBodyScroll)
    f.timelineContent:Show()
end

--- Default state for the Timeline tab: first era, first event.
function IMAGO.Chronicle.ShowTimelineDefault()
    local f = IMAGO.Chronicle.frame
    if not f then return end

    if f.timelineListPanel then f.timelineListPanel:Show() end
    if f.timelineContent then f.timelineContent:Show() end

    local searchActive = f.searchBox and (f.searchBox:GetText() or "") ~= ""

    if searchActive then
        -- Search hits are listed era-less in the middle column
        local hits = IMAGO.Chronicle.GetTimelineEvents(nil)
        f.selectedTimelineEra = nil
        IMAGO.Chronicle.RenderTimelineEra(nil)
        if hits[1] then
            IMAGO.Chronicle.RenderTimelineEvent(hits[1].slug)
        else
            f.timelineTitle:SetText("")
            f.timelineEraTag:SetText("")
            f.timelineBody:SetText("|c" .. IMAGO_HEX.TEXT_MUTED .. (IMAGO.L["TIMELINE_SEARCH_EMPTY"] or "No events match this search.") .. "|r")
            if f.tlRelatedHead then f.tlRelatedHead:Hide() end
            for _, chip in ipairs(f.tlChips or {}) do chip:Hide() end
            f.timelineBodyContent:SetHeight(60)
            f.timelineContent:Show()
        end
        return
    end

    local eras = IMAGOdb.timeline and IMAGOdb.timeline.eras or {}
    local eraKey = f.selectedTimelineEra or (eras[1] and eras[1].key)
    f.selectedTimelineEra = eraKey

    IMAGO.Chronicle.RenderTimelineEra(eraKey)

    -- Keep current event if it belongs to the era; else first event
    local slug = f.selectedTimelineSlug
    local data = slug and IMAGOdb.timeline.events[slug]
    if not data or data.era ~= eraKey then
        local first = IMAGO.Chronicle.GetTimelineEvents(eraKey)[1]
        slug = first and first.slug or nil
    end
    IMAGO.Chronicle.RenderTimelineEvent(slug)
end

--- Public navigation API: open the Timeline tab at a given event.
function IMAGO.Chronicle.OpenToTimeline(slug)
    if not slug or not (IMAGOdb.timeline and IMAGOdb.timeline.events and IMAGOdb.timeline.events[slug]) then
        return false
    end

    if not IMAGO.Chronicle.frame then
        IMAGO.Chronicle.CreateFrame()
    end

    local f = IMAGO.Chronicle.frame
    local data = IMAGOdb.timeline.events[slug]

    -- Push current page onto nav stack before navigating away.
    if not isNavigatingBack then
        local entry = nil
        if f.selectedNPCSlug and f.selectedNPCSlug ~= "" then
            entry = { type = "npc", slug = f.selectedNPCSlug }
        elseif f.selectedZoneMapID then
            entry = { type = "zone", mapID = f.selectedZoneMapID }
        elseif f.selectedRaceSlug then
            entry = { type = "race", slug = f.selectedRaceSlug }
        elseif f.selectedClassSlug then
            entry = { type = "class", slug = f.selectedClassSlug }
        elseif f.selectedCodexSlug then
            entry = { type = "codex", slug = f.selectedCodexSlug }
        elseif f.selectedTimelineSlug and f.selectedTimelineSlug ~= slug then
            entry = { type = "timeline", slug = f.selectedTimelineSlug }
        end
        if entry then
            table.insert(navStack, entry)
            if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
        end
    end
    f.selectedNPCSlug = nil
    f.selectedZoneMapID = nil
    f.selectedRaceSlug = nil
    f.selectedClassSlug = nil
    f.selectedCodexSlug = nil
    f.selectedTimelineSlug = nil
    f.selectedTimelineEra = data.era

    f._skipAutoSelect = true -- targeted open: don't auto-pick an entry
    IMAGO.Chronicle.SelectMainTab(6)
    f:Show()

    IMAGO.Chronicle.RenderTimelineEvent(slug)

    -- Scroll the middle list to the event's button
    C_Timer.After(0, function()
        if f.timelineEventButtons then
            for _, btn in pairs(f.timelineEventButtons) do
                if btn.timelineSlug == slug and btn:IsShown() then
                    f.timelineListScroll:SetVerticalScroll(math.max(0, (btn._listScrollY or 0) - 60))
                    break
                end
            end
        end
    end)
    return true
end

function IMAGO.Chronicle.Toggle()
    if not IMAGO.Chronicle.frame then IMAGO.Chronicle.CreateFrame() end
    local f = IMAGO.Chronicle.frame
    if f:IsShown() then
        f:Hide()
    else
        local tabIdx = f.activeTabIndex or 1
        IMAGO.Chronicle.SelectMainTab(tabIdx)
        if f.UpdateModeBtn then f.UpdateModeBtn() end
        f:Show()
    end
end

-- ============================================================
-- ACHIEVEMENTS TAB: standing summary + scrollable achievement list
-- ============================================================
function IMAGO.Chronicle.ShowAchievements()
    local f = IMAGO.Chronicle.frame
    if not f then return end

    -- Two cards side by side: full-width rows left most of the card empty,
    -- half-width cards keep name, description and bar comfortably together
    local ROW_H, COLS, COL_GAP = 82, 2, 10

    -- Lazy-build the page once, then populate on every show
    if not f.achievementsPage then
        local p = CreateFrame("Frame", nil, f)
        p:SetPoint("TOPLEFT", f, "TOPLEFT", LAYOUT.SIDEBAR_OFFSET_LEFT, -LAYOUT.WORKSPACE_TOP)
        p:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -LAYOUT.CONTENT_PADDING_RIGHT, LAYOUT.WORKSPACE_BOTTOM)
        f.achievementsPage = p

        -- ================= LEFT: standing summary =================
        local lp = CreateFrame("Frame", nil, p, "BackdropTemplate")
        lp:SetPoint("TOPLEFT", p, "TOPLEFT", 0, 0)
        lp:SetPoint("BOTTOMLEFT", p, "BOTTOMLEFT", 0, 0)
        lp:SetWidth(320)
        lp:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 14,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        lp:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.85)
        lp:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)
        p.leftPanel = lp

        lp.heading = lp:CreateFontString(nil, "OVERLAY")
        lp.heading:SetPoint("TOPLEFT", lp, "TOPLEFT", 16, -14)
        lp.heading:SetFont(IMAGO.FONT_BODY, 11)
        lp.heading:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        lp.heading:SetText(string.upper(IMAGO.L["ACH_STANDING"] or "Chronicle Standing"))

        lp.rank = lp:CreateFontString(nil, "OVERLAY")
        lp.rank:SetPoint("TOPLEFT", lp.heading, "BOTTOMLEFT", 0, -8)
        lp.rank:SetFont(IMAGO.FONT_TITLE, 22, "OUTLINE")
        lp.rank:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

        lp.bar = CreateFrame("Frame", nil, lp, "BackdropTemplate")
        lp.bar:SetSize(288, 12)
        lp.bar:SetPoint("TOPLEFT", lp.rank, "BOTTOMLEFT", 0, -12)
        lp.bar:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        lp.bar:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)
        lp.bar.bg = lp.bar:CreateTexture(nil, "BACKGROUND")
        lp.bar.bg:SetAllPoints()
        lp.bar.bg:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
        lp.bar.fill = lp.bar:CreateTexture(nil, "ARTWORK")
        lp.bar.fill:SetPoint("LEFT", lp.bar, "LEFT", 1, 0)
        lp.bar.fill:SetHeight(10)
        lp.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)

        lp.barText = lp:CreateFontString(nil, "OVERLAY")
        lp.barText:SetPoint("TOPLEFT", lp.bar, "BOTTOMLEFT", 0, -5)
        lp.barText:SetFont(IMAGO.FONT_BODY, 11)
        lp.barText:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

        lp.divider1 = lp:CreateTexture(nil, "ARTWORK")
        lp.divider1:SetSize(288, 1)
        lp.divider1:SetPoint("TOPLEFT", lp.barText, "BOTTOMLEFT", 0, -14)
        lp.divider1:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        lp.divider1:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4),
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

        -- Per-category progress rows (clickable -> filters the list)
        -- Row 1 is "All": clears the filter and shows overall totals
        lp.catRows = {}
        local CAT_FILTERS = { nil, "fates", "zones", "races", "classes" }
        for i = 1, 5 do
            local row = CreateFrame("Button", nil, lp)
            row:SetSize(288, 40)
            row.filter = CAT_FILTERS[i]
            if i == 1 then
                row:SetPoint("TOPLEFT", lp.divider1, "BOTTOMLEFT", 0, -14)
            else
                row:SetPoint("TOPLEFT", lp.catRows[i - 1], "BOTTOMLEFT", 0, -8)
            end

            -- Active-filter indicator: thin gold bar on the left edge
            row.marker = row:CreateTexture(nil, "ARTWORK")
            row.marker:SetSize(3, 30)
            row.marker:SetPoint("LEFT", row, "LEFT", -6, 0)
            row.marker:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
            row.marker:Hide()

            row.hl = row:CreateTexture(nil, "HIGHLIGHT")
            row.hl:SetAllPoints()
            row.hl:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.06)

            row:SetScript("OnClick", function(self)
                f.achFilter = (f.achFilter == self.filter) and nil or self.filter
                IMAGO.Chronicle.ShowAchievements()
            end)

            row.label = row:CreateFontString(nil, "OVERLAY")
            row.label:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
            row.label:SetFont(IMAGO.FONT_BODY, 12)
            row.label:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])

            row.count = row:CreateFontString(nil, "OVERLAY")
            row.count:SetPoint("TOPRIGHT", row, "TOPRIGHT", 0, 0)
            row.count:SetFont(IMAGO.FONT_BODY, 11)
            row.count:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

            row.bar = CreateFrame("Frame", nil, row, "BackdropTemplate")
            row.bar:SetSize(288, 8)
            row.bar:SetPoint("TOPLEFT", row.label, "BOTTOMLEFT", 0, -7)
            row.bar:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
                insets = { left = 2, right = 2, top = 2, bottom = 2 } })
            row.bar:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.3)
            row.bar.bg = row.bar:CreateTexture(nil, "BACKGROUND")
            row.bar.bg:SetAllPoints()
            row.bar.bg:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
            row.bar.fill = row.bar:CreateTexture(nil, "ARTWORK")
            row.bar.fill:SetPoint("LEFT", row.bar, "LEFT", 1, 0)
            row.bar.fill:SetHeight(6)
            row.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)

            lp.catRows[i] = row
        end

        lp.divider2 = lp:CreateTexture(nil, "ARTWORK")
        lp.divider2:SetSize(288, 1)
        lp.divider2:SetPoint("TOPLEFT", lp.catRows[5], "BOTTOMLEFT", 0, -14)
        lp.divider2:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        lp.divider2:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4),
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

        lp.scoreLabel = lp:CreateFontString(nil, "OVERLAY")
        lp.scoreLabel:SetPoint("TOPLEFT", lp.divider2, "BOTTOMLEFT", 0, -14)
        lp.scoreLabel:SetFont(IMAGO.FONT_BODY, 11)
        lp.scoreLabel:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        lp.scoreLabel:SetText(string.upper(IMAGO.L["ACH_SCORE"] or "Chronicle Score"))

        -- Classic score badge: number inside a gold-bordered plaque
        lp.scoreBox = CreateFrame("Frame", nil, lp, "BackdropTemplate")
        lp.scoreBox:SetSize(96, 46)
        lp.scoreBox:SetPoint("TOPLEFT", lp.scoreLabel, "BOTTOMLEFT", 0, -6)
        lp.scoreBox:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 10,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        lp.scoreBox:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.9)
        lp.scoreBox:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6)

        lp.score = lp.scoreBox:CreateFontString(nil, "OVERLAY")
        lp.score:SetPoint("CENTER", lp.scoreBox, "CENTER", 0, 0)
        lp.score:SetFont(IMAGO.FONT_TITLE, 24, "OUTLINE")
        lp.score:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        -- Score composition explained on hover
        lp.scoreBox:EnableMouse(true)
        lp.scoreBox:SetScript("OnEnter", function()
            GameTooltip:SetOwner(lp.scoreBox, "ANCHOR_RIGHT")
            GameTooltip:SetText(IMAGO.L["ACH_SCORE"] or "Chronicle Score",
                IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            GameTooltip:AddLine(string.format(IMAGO.L["ACH_SCORE_TIP_PROGRESS"] or "%d points from achievement progress",
                lp._progressPts or 0), 1, 1, 1)
            GameTooltip:AddLine(string.format(IMAGO.L["ACH_SCORE_TIP_BONUS"] or "%d bonus points from completed achievements",
                lp._bonus or 0), 1, 1, 1)
            GameTooltip:Show()
        end)
        lp.scoreBox:SetScript("OnLeave", function() GameTooltip:Hide() end)

        lp.divider3 = lp:CreateTexture(nil, "ARTWORK")
        lp.divider3:SetSize(288, 1)
        lp.divider3:SetPoint("TOPLEFT", lp.scoreBox, "BOTTOMLEFT", 0, -14)
        lp.divider3:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        lp.divider3:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4),
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

        -- ================= RIGHT: achievement list =================
        p.listTitle = p:CreateFontString(nil, "OVERLAY")
        p.listTitle:SetPoint("TOPLEFT", lp, "TOPRIGHT", 24, -6)
        p.listTitle:SetFont(IMAGO.FONT_TITLE, 18, "OUTLINE")
        p.listTitle:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        p.listTitle:SetText(string.upper(IMAGO.L["TAB_ACHIEVEMENTS"] or "Achievements"))

        -- Post own score into guild/party chat
        p.postBtn = CreateFrame("Button", nil, p, "BackdropTemplate")
        p.postBtn:SetSize(90, 20)
        p.postBtn:SetPoint("LEFT", lp.scoreBox, "RIGHT", 10, 0)
        p.postBtn:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        p.postBtn:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.8)
        p.postBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)
        p.postBtn.t = p.postBtn:CreateFontString(nil, "OVERLAY")
        p.postBtn.t:SetFont(IMAGO.FONT_BODY, 10)
        p.postBtn.t:SetAllPoints()
        p.postBtn.t:SetText(IMAGO.L["ACH_POST_SCORE"] or "Post Score")
        p.postBtn.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        p.postBtn:SetScript("OnEnter", function()
            p.postBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.8)
            p.postBtn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
        end)
        p.postBtn:SetScript("OnLeave", function()
            p.postBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)
            p.postBtn.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        end)
        p.postBtn:SetScript("OnClick", function()
            if IMAGO.Social and IMAGO.Social.PostScore then
                IMAGO.Social.PostScore()
            end
        end)

        p.scroll = CreateFrame("ScrollFrame", "IMAGOAchScroll", p, "UIPanelScrollFrameTemplate")
        p.scroll:SetPoint("TOPLEFT", p.listTitle, "BOTTOMLEFT", -6, -10)
        p.scroll:SetPoint("BOTTOMRIGHT", p, "BOTTOMRIGHT", 0, 0)
        if p.scroll.ScrollBar then
            p.scroll.ScrollBar:ClearAllPoints()
            p.scroll.ScrollBar:SetPoint("TOPRIGHT", p.scroll, "TOPRIGHT", -4, -14)
            p.scroll.ScrollBar:SetPoint("BOTTOMRIGHT", p.scroll, "BOTTOMRIGHT", -4, 14)
            p.scroll.ScrollBar:SetWidth(8)
        end

        p.content = CreateFrame("Frame", nil, p.scroll)
        p.content:SetSize(700, 1)
        p.scroll:SetScrollChild(p.content)

        p.rows = {}
    end

    local function GetRow(i)
        local p = f.achievementsPage
        if p.rows[i] then return p.rows[i] end
        local row = CreateFrame("Frame", nil, p.content, "BackdropTemplate")
        row:SetSize(p.content:GetWidth(), ROW_H - 6)
        row:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 14,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        row:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.9)
        row:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.45)

        -- Completion check — top-aligned beside the name so the
        -- description can use the card's full width below
        row.check = row:CreateTexture(nil, "ARTWORK")
        row.check:SetSize(20, 20)
        row.check:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -9)
        row.check:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
        row.check:SetDesaturated(true)
        row.check:SetVertexColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        -- Goal star: tracks this achievement as the Home tab's "Next goal"
        row.star = CreateFrame("Button", nil, row)
        row.star:SetSize(16, 16)
        row.star:SetPoint("LEFT", row.check, "RIGHT", 6, 0)
        row.star.icon = row.star:CreateTexture(nil, "OVERLAY")
        row.star.icon:SetAllPoints()
        row.star.icon:SetAtlas("collections-icon-favorites")
        row.star:SetScript("OnClick", function(self)
            if not self.achId then return end
            IMAGOSaved.trackedGoal = (IMAGOSaved.trackedGoal == self.achId) and nil or self.achId
            IMAGO.Chronicle.ShowAchievements()
        end)
        row.star:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            local tip = (IMAGOSaved.trackedGoal == self.achId)
                and (IMAGO.L["ACH_CLEAR_GOAL"] or "Stop tracking as your goal")
                or (IMAGO.L["ACH_SET_GOAL"] or "Track as your goal on the Home tab")
            GameTooltip:SetText(tip, 1, 1, 1)
            GameTooltip:Show()
        end)
        row.star:SetScript("OnLeave", function() GameTooltip:Hide() end)

        row.name = row:CreateFontString(nil, "OVERLAY")
        row.name:SetPoint("TOPLEFT", row, "TOPLEFT", 62, -8)
        row.name:SetFont(IMAGO.FONT_BODY, 13)
        row.name:SetJustifyH("LEFT")

        row.desc = row:CreateFontString(nil, "OVERLAY")
        row.desc:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -30)
        row.desc:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -30)
        row.desc:SetFont(IMAGO.FONT_BODY, 11)
        row.desc:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        row.desc:SetMaxLines(2)
        row.desc:SetJustifyH("LEFT")

        row.points = row:CreateFontString(nil, "OVERLAY")
        row.points:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -8)
        row.points:SetFont(IMAGO.FONT_BODY, 11)
        row.points:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        -- clip the name before it can slide under the points label
        row.name:SetPoint("TOPRIGHT", row.points, "TOPLEFT", -8, 0)

        row.bar = CreateFrame("Frame", nil, row, "BackdropTemplate")
        row.bar:SetSize(170, 10)
        row.bar:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -12, 10)
        row.bar:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 } })
        row.bar:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.3)
        row.bar.bg = row.bar:CreateTexture(nil, "BACKGROUND")
        row.bar.bg:SetAllPoints()
        row.bar.bg:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
        row.bar.fill = row.bar:CreateTexture(nil, "ARTWORK")
        row.bar.fill:SetPoint("LEFT", row.bar, "LEFT", 1, 0)
        row.bar.fill:SetHeight(8)
        row.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)

        row.progText = row:CreateFontString(nil, "OVERLAY")
        row.progText:SetPoint("BOTTOMRIGHT", row.bar, "TOPRIGHT", 0, 2)
        row.progText:SetFont(IMAGO.FONT_BODY, 10)
        row.progText:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

        p.rows[i] = row
        return row
    end

    -- ================= Populate =================
    local p = f.achievementsPage
    local counts = IMAGOdb.achievementCounts

    local sFates, tFates = 0, 0
    for _, entries in pairs(IMAGOdb.npcs or {}) do
        if type(entries) == "table" then
            for slug in pairs(entries) do
                tFates = tFates + 1
                if IMAGOSaved.seenNPCs and IMAGOSaved.seenNPCs[slug] then sFates = sFates + 1 end
            end
        end
    end
    local sZones, tZones = counts.ZonesCount()
    local sRaces, tRaces = counts.RacesCount()
    local sClasses, tClasses = counts.ClassesCount()
    local sAll, tAll = counts.OverallCount()
    local percAll = tAll > 0 and (sAll / tAll) * 100 or 0

    local rankTitle = ""
    for _, r in ipairs(IMAGO.Chronicle.ranks or {}) do
        if percAll >= r.perc then rankTitle = r.title or "" end
    end

    local lp = p.leftPanel
    lp.rank:SetText(rankTitle)
    lp.bar.fill:SetWidth(math.max(1, (percAll / 100) * 286))
    lp.barText:SetText(string.format(IMAGO.L["ACH_OVERALL_PROGRESS"] or "%d / %d entries uncovered (%d%%)",
        sAll, tAll, math.floor(percAll)))

    local catData = {
        { label = IMAGO.L["ACH_ALL"] or "All", seen = sAll, total = tAll },
        { label = IMAGO.L["TAB_FATES"] or "Fates", seen = sFates, total = tFates },
        { label = IMAGO.L["TAB_ZONES"] or "Zones", seen = sZones, total = tZones },
        { label = IMAGO.L["TAB_RACES"] or "Races", seen = sRaces, total = tRaces },
        { label = IMAGO.L["TAB_CLASSES"] or "Classes", seen = sClasses, total = tClasses },
    }
    for i, c in ipairs(catData) do
        local row = lp.catRows[i]
        local perc = c.total > 0 and (c.seen / c.total) * 100 or 0
        row.label:SetText(c.label)
        row.count:SetText(string.format("%d / %d  (%d%%)", c.seen, c.total, math.floor(perc)))
        row.bar.fill:SetWidth(math.max(1, (perc / 100) * 286))
        local isActive = (f.achFilter == row.filter)
        row.marker:SetShown(isActive)
        row.label:SetTextColor(isActive and IMAGO_COLORS.GOLD[1] or IMAGO_COLORS.TEXT_PRIMARY[1],
            isActive and IMAGO_COLORS.GOLD[2] or IMAGO_COLORS.TEXT_PRIMARY[2],
            isActive and IMAGO_COLORS.GOLD[3] or IMAGO_COLORS.TEXT_PRIMARY[3])
    end

    -- Score model: 1 point per progress step inside each achievement (kept
    -- even when content grows) + bonus points per currently-complete one.
    local score, progressPts, bonus, evaluated = IMAGO.GetChronicleScore()
    if f.achFilter then
        local filtered = {}
        for _, ach in ipairs(evaluated) do
            if ach.def.cat == f.achFilter then filtered[#filtered + 1] = ach end
        end
        evaluated = filtered
    end
    -- Stable curated order: open achievements first (easy -> hard), earned last
    for order, ach in ipairs(evaluated) do ach.order = order end
    table.sort(evaluated, function(a, b)
        if a.done ~= b.done then return not a.done end
        return a.order < b.order
    end)

    lp.score:SetText(tostring(score))
    lp._progressPts, lp._bonus = progressPts, bonus

    -- Cards keep ~26px clearance to the scrollbar on the right
    local contentW = math.max(100, p.scroll:GetWidth() - 26)
    p.content:SetWidth(contentW)
    local cardW = math.floor((contentW - COL_GAP) / COLS)
    local i = 1
    for _, ach in ipairs(evaluated) do
        local row = GetRow(i)
        local colN = (i - 1) % COLS
        local rowN = math.floor((i - 1) / COLS)
        row:SetPoint("TOPLEFT", p.content, "TOPLEFT", colN * (cardW + COL_GAP), -rowN * ROW_H)
        row:SetWidth(cardW)

        local key = "ACH_" .. string.upper(ach.def.id)
        row.name:SetText(IMAGO.L[key .. "_NAME"] or ach.def.id)
        row.desc:SetText(IMAGO.L[key .. "_DESC"] or "")
        row.points:SetText(string.format(IMAGO.L["ACH_POINTS"] or "%d pts", ach.def.points or 0))
        row.progText:SetText(string.format("%d / %d", ach.seen, ach.total))
        row.bar.fill:SetWidth(math.max(1, ach.frac * 168))

        -- Goal star state: lit gold when tracked, faint outline otherwise
        row.star.achId = ach.def.id
        if IMAGOSaved.trackedGoal == ach.def.id then
            row.star.icon:SetDesaturated(false)
            row.star.icon:SetVertexColor(1, 1, 1)
            row.star:SetAlpha(1)
        else
            row.star.icon:SetDesaturated(true)
            row.star.icon:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            row.star:SetAlpha(0.3)
        end

        row.points:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        if ach.done then
            row.check:Show()
            row.check:SetAlpha(1)
            row.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
            row:SetBackdropColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.10)
            row:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)
            row.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.95)
        elseif ach.earned then
            -- Earned once but currently incomplete: dimmed check, neutral card
            row.check:Show()
            row.check:SetAlpha(0.35)
            row.points:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
            row.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
            row:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.9)
            row:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.55)
            row.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)
        else
            row.check:Hide()
            row.check:SetAlpha(1)
            row.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
            row:SetBackdropColor(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.9)
            row:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.45)
            row.bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)
        end

        row:Show()
        i = i + 1
    end
    for j = i, #p.rows do p.rows[j]:Hide() end

    p.content:SetHeight(math.max(1, math.ceil((i - 1) / COLS) * ROW_H))
    p:Show()
end




-- ============================================================
-- HOME TAB: dashboard — standing, latest discovery, next goal,
-- plus a 3x2 feature grid
-- ============================================================

-- Shared progress bar matching the Achievements tab style:
-- gold-tinted track, gold border, 10px frame / 8px fill,
-- count text right-aligned above the bar.
local function HomeBar(parent)
    local bar = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    bar:SetHeight(10)
    bar:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 6,
        insets = { left = 2, right = 2, top = 2, bottom = 2 } })
    bar:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.3)
    bar.bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg:SetAllPoints()
    bar.bg:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
    bar.fill = bar:CreateTexture(nil, "ARTWORK")
    bar.fill:SetPoint("LEFT", bar, "LEFT", 1, 0)
    bar.fill:SetHeight(8)
    bar.fill:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.85)
    bar.count = bar:CreateFontString(nil, "OVERLAY")
    bar.count:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", 0, 2)
    bar.count:SetFont(IMAGO.FONT_BODY, 12)
    bar.count:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
    bar.SetProgress = function(self, frac, text)
        frac = math.max(0, math.min(1, frac or 0))
        self.fill:SetWidth(math.max(0.001, (self:GetWidth() - 2) * frac))
        self.count:SetText(text or "")
    end
    return bar
end

local function HomePanel(p, x, y, w, h, label)
    local panel = CreateFrame("Frame", nil, p, "BackdropTemplate")
    panel:SetSize(w, h)
    panel:SetPoint("TOPLEFT", p, "TOPLEFT", x, y)
    panel:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    panel:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.55)
    panel:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)

    panel.label = panel:CreateFontString(nil, "OVERLAY")
    panel.label:SetFont(IMAGO.FONT_BODY, 12)
    panel.label:SetPoint("TOPLEFT", panel, "TOPLEFT", 14, -12)
    panel.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    panel.label:SetText(label)
    return panel
end

-- Text link with a plain ">" suffix (glyph-safe in all client fonts)
local function HomeAction(parent, text)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(220, 16)
    btn.t = btn:CreateFontString(nil, "OVERLAY")
    btn.t:SetFont(IMAGO.FONT_BODY, 13)
    btn.t:SetPoint("LEFT", btn, "LEFT", 0, 0)
    btn.t:SetText((text or "") .. " >")
    btn.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    btn:SetScript("OnEnter", function()
        btn.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    end)
    btn:SetScript("OnLeave", function()
        btn.t:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
    end)
    return btn
end

function IMAGO.Chronicle.ShowHome()
    local f = IMAGO.Chronicle.frame
    if not f then return end

    local GAP = 16          -- column + row gap (equal, per layout spec)
    local ROW_GAP = 16
    local PANEL_H = 128
    local PADX = 14         -- inner panel padding
    local BOT_Y = 14        -- footer row anchor at panel/tile bottom
    local OUTER = 26        -- outer page margin

    if not f.homePage then
        local p = CreateFrame("Frame", nil, f)
        p:SetPoint("TOPLEFT", f, "TOPLEFT", LAYOUT.SIDEBAR_OFFSET_LEFT + OUTER, -LAYOUT.WORKSPACE_TOP)
        p:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -LAYOUT.CONTENT_PADDING_RIGHT - OUTER, LAYOUT.WORKSPACE_BOTTOM + 4)
        f.homePage = p

        -- Header: WELCOME BACK / <name> left, score right
        p.welcomeLabel = p:CreateFontString(nil, "OVERLAY")
        p.welcomeLabel:SetFont(IMAGO.FONT_BODY, 12)
        p.welcomeLabel:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -6)
        p.welcomeLabel:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        p.welcomeLabel:SetText(IMAGO.L["HOME_WELCOME_LABEL"] or "WELCOME BACK")

        p.welcome = p:CreateFontString(nil, "OVERLAY")
        p.welcome:SetFont(IMAGO.FONT_TITLE, 22, "OUTLINE")
        p.welcome:SetPoint("TOPLEFT", p.welcomeLabel, "BOTTOMLEFT", 0, -6)
        p.welcome:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        p.welcome:SetMaxLines(1)
        p.welcome:SetJustifyH("LEFT")

        -- Centered subtitle on the page's middle axis, styled to match the
        -- I M A G O window title: same font family, outline, drop shadow and
        -- letter tracking (UTF-8 safe so Cyrillic survives the spacing pass)
        p.tagline = p:CreateFontString(nil, "OVERLAY")
        p.tagline:SetFont(IMAGO.FONT_TITLE, 20, "OUTLINE")
        p.tagline:SetPoint("CENTER", p, "TOP", 0, -30)
        p.tagline:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        p.tagline:SetShadowColor(0, 0, 0, 1)
        p.tagline:SetShadowOffset(2, -2)
        local tagline = IMAGO.L["HOME_TAGLINE"] or "CHRONICLE OF THE UNFORGOTTEN"
        p.tagline:SetText((tagline:gsub("([%z\1-\127\194-\244][\128-\191]*)", "%1 ")))

        p.scoreLabel = p:CreateFontString(nil, "OVERLAY")
        p.scoreLabel:SetFont(IMAGO.FONT_BODY, 12)
        p.scoreLabel:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -6)
        p.scoreLabel:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        p.scoreLabel:SetText(IMAGO.L["ACH_SCORE"] and string.upper(IMAGO.L["ACH_SCORE"]) or "CHRONICLE SCORE")

        p.scoreBox = CreateFrame("Frame", nil, p, "BackdropTemplate")
        p.scoreBox:SetSize(58, 32)
        p.scoreBox:SetPoint("TOPRIGHT", p.scoreLabel, "BOTTOMRIGHT", 0, -6)
        -- cap the welcome line at the score label so double names
        -- truncate with ellipsis instead of overlapping it
        p.welcome:SetPoint("RIGHT", p.scoreLabel, "LEFT", -12, 0)
        p.scoreBox:SetBackdrop({
            bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        p.scoreBox:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.85)
        p.scoreBox:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)
        p.scoreBox.t = p.scoreBox:CreateFontString(nil, "OVERLAY")
        p.scoreBox.t:SetFont(IMAGO.FONT_TITLE, 20)
        p.scoreBox.t:SetAllPoints()
        p.scoreBox.t:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        local W = p:GetWidth()
        local colW = math.floor((W - 2 * GAP) / 3)

        -- ==== STATUS ROW: 3 panels, identical inner structure =====
        -- label -> title -> subtext -> bar row -> link row (all panels)
        local pY = -84
        local TITLE_Y = -32        -- title under label
        local BAR_Y  = BOT_Y + 22  -- progress bar row
        local LINK_Y = BOT_Y       -- action link row

        -- Panel 1: CHRONICLE STANDING
        local s = HomePanel(p, 0, pY, colW, PANEL_H, IMAGO.L["HOME_STANDING"] or "CHRONICLE STANDING")
        s.rank = s:CreateFontString(nil, "OVERLAY")
        s.rank:SetFont(IMAGO.FONT_TITLE, 18)
        s.rank:SetPoint("TOPLEFT", s, "TOPLEFT", PADX, TITLE_Y)
        s.rank:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        s.count = s:CreateFontString(nil, "OVERLAY")
        s.count:SetFont(IMAGO.FONT_BODY, 12)
        s.count:SetPoint("TOPLEFT", s.rank, "BOTTOMLEFT", 0, -4)
        s.count:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

        -- Full-width bar (anchored left AND right), count hidden —
        -- the % is already in s.count text
        s.bar = HomeBar(s)
        s.bar:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", PADX, BAR_Y)
        s.bar:SetPoint("RIGHT", s, "RIGHT", -PADX, 0)
        s.bar.count:Hide()

        s.link = HomeAction(s, IMAGO.L["HOME_VIEW_ACH"] or "View achievements")
        s.link:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", PADX, LINK_Y)
        s.link:SetScript("OnClick", function()
            IMAGO.Chronicle.SelectMainTab(8)
        end)
        p.standingPanel = s

        -- Panel 2: LATEST DISCOVERY
        local l = HomePanel(p, colW + GAP, pY, colW, PANEL_H,
            IMAGO.L["HOME_LATEST"] and string.upper(IMAGO.L["HOME_LATEST"]) or "LATEST DISCOVERY")
        l.name = l:CreateFontString(nil, "OVERLAY")
        l.name:SetFont(IMAGO.FONT_TITLE, 18)
        l.name:SetPoint("TOPLEFT", l, "TOPLEFT", PADX, TITLE_Y)
        l.name:SetWidth(colW - PADX * 2)
        l.name:SetJustifyH("LEFT")
        l.name:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        l.kind = l:CreateFontString(nil, "OVERLAY")
        l.kind:SetFont(IMAGO.FONT_BODY, 12)
        l.kind:SetPoint("TOPLEFT", l.name, "BOTTOMLEFT", 0, -4)
        l.kind:SetWidth(colW - PADX * 2)
        l.kind:SetJustifyH("LEFT")
        l.kind:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

        l.link = HomeAction(l, IMAGO.L["HOME_READ_ENTRY"] or "Read entry")
        l.link:SetPoint("BOTTOMLEFT", l, "BOTTOMLEFT", PADX, LINK_Y)
        p.latestPanel = l

        -- Panel 3: NEXT GOAL
        local g = HomePanel(p, 2 * (colW + GAP), pY, colW, PANEL_H, IMAGO.L["HOME_NEXT_GOAL"] or "NEXT GOAL")
        g.name = g:CreateFontString(nil, "OVERLAY")
        g.name:SetFont(IMAGO.FONT_TITLE, 18)
        g.name:SetPoint("TOPLEFT", g, "TOPLEFT", PADX, TITLE_Y)
        g.name:SetWidth(colW - PADX * 2)
        g.name:SetJustifyH("LEFT")
        g.name:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])

        g.desc = g:CreateFontString(nil, "OVERLAY")
        g.desc:SetFont(IMAGO.FONT_BODY, 13)
        g.desc:SetPoint("TOPLEFT", g.name, "BOTTOMLEFT", 0, -4)
        g.desc:SetWidth(colW - PADX * 2)
        g.desc:SetJustifyH("LEFT")
        g.desc:SetSpacing(2)
        g.desc:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

        -- Small star shown beside the title when the goal was picked manually
        -- via the star button in the Achievements tab
        g.star = g:CreateTexture(nil, "OVERLAY")
        g.star:SetSize(20, 20)
        g.star:SetPoint("TOPRIGHT", g, "TOPRIGHT", -PADX + 4, -8)
        g.star:SetAtlas("collections-icon-favorites")
        g.star:Hide()

        g.bar = HomeBar(g)
        g.bar:SetPoint("BOTTOMLEFT", g, "BOTTOMLEFT", PADX, BAR_Y)
        g.bar:SetPoint("RIGHT", g, "RIGHT", -PADX, 0)

        g.link = HomeAction(g, IMAGO.L["HOME_VIEW_ACH"] or "View achievements")
        g.link:SetPoint("BOTTOMLEFT", g, "BOTTOMLEFT", PADX, LINK_Y)
        g.link:SetScript("OnClick", function()
            IMAGO.Chronicle.SelectMainTab(8)
        end)
        p.goalPanel = g

        -- ==== SECTION HEADER: THE CHRONICLE =========================
        p.secLabel = p:CreateFontString(nil, "OVERLAY")
        p.secLabel:SetFont(IMAGO.FONT_TITLE, 13)
        p.secLabel:SetPoint("TOPLEFT", p, "TOPLEFT", 0, pY - PANEL_H - 28)
        p.secLabel:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
        p.secLabel:SetText(IMAGO.L["HOME_SECTION"] or "THE CHRONICLE")

        -- Solid gold line from label to ~60px before the right edge,
        -- then a short fade-out so the line clearly reaches the edge
        p.secLine = p:CreateTexture(nil, "ARTWORK")
        p.secLine:SetHeight(1)
        p.secLine:SetPoint("LEFT", p.secLabel, "RIGHT", 14, 0)
        p.secLine:SetPoint("RIGHT", p, "RIGHT", -60, 0)
        p.secLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        p.secLine:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

        p.secFade = p:CreateTexture(nil, "ARTWORK")
        p.secFade:SetHeight(1)
        p.secFade:SetPoint("LEFT", p.secLine, "RIGHT", 0, 0)
        p.secFade:SetPoint("RIGHT", p, "RIGHT", 0, 0)
        p.secFade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
        p.secFade:SetGradient("HORIZONTAL",
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35),
            CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

        -- ==== TILE GRID: 3 x 2, fills remaining height ==============
        local tileY = pY - PANEL_H - 56
        local availH = p:GetHeight() + tileY      -- space from tileY down to p bottom
        local BOTTOM_PAD = 26
        local TILE_H = math.floor((availH - BOTTOM_PAD - ROW_GAP) / 2)

        local defs = {
            { tab = 2, name = "TAB_FATES",    desc = "HOME_DESC_FATES",    progress = true },
            { tab = 3, name = "TAB_ZONES",    desc = "HOME_DESC_ZONES",    progress = true },
            { tab = 4, name = "TAB_RACES",    desc = "HOME_DESC_RACES",    progress = true },
            { tab = 5, name = "TAB_CLASSES",  desc = "HOME_DESC_CLASSES",  progress = true },
            { tab = 6, name = "TAB_TIMELINE", desc = "HOME_DESC_TIMELINE" },
            { tab = 7, name = "TAB_CODEX",    desc = "HOME_DESC_CODEX" },
        }
        p.tiles = {}
        for i, def in ipairs(defs) do
            local row = math.floor((i - 1) / 3)
            local col = (i - 1) % 3
            local t = CreateFrame("Button", nil, p, "BackdropTemplate")
            t:SetSize(colW, TILE_H)
            t:SetPoint("TOPLEFT", p, "TOPLEFT", col * (colW + GAP), tileY - row * (TILE_H + ROW_GAP))
            t:SetBackdrop({
                bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeSize = 8,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            t:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.75)
            t:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)

            -- Header band: warm gold gradient strip across the tile width,
            -- a thin divider below it, the title vertically centered inside
            local HEADER_H = 30
            t.header = t:CreateTexture(nil, "ARTWORK")
            t.header:SetPoint("TOPLEFT", t, "TOPLEFT", 3, -3)
            t.header:SetPoint("TOPRIGHT", t, "TOPRIGHT", -3, -3)
            t.header:SetHeight(HEADER_H)
            t.header:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            -- Horizontal warm-brown -> gold-brown sweep (dark left, lit right)
            local function SetHeaderGrad(tile, hover)
                local k = hover and 1.35 or 1
                tile.header:SetGradient("HORIZONTAL",
                    CreateColor(0.22 * k, 0.16 * k, 0.09 * k, 0.9),
                    CreateColor(0.50 * k, 0.38 * k, 0.20 * k, 0.9))
            end
            SetHeaderGrad(t, false)

            t.headerLine = t:CreateTexture(nil, "ARTWORK")
            t.headerLine:SetPoint("TOPLEFT", t.header, "BOTTOMLEFT", 0, 0)
            t.headerLine:SetPoint("TOPRIGHT", t.header, "BOTTOMRIGHT", 0, 0)
            t.headerLine:SetHeight(1)
            t.headerLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            t.headerLine:SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.35)

            -- Top-light: 1px translucent edge catching light on the metal rim
            t.topLight = t:CreateTexture(nil, "ARTWORK")
            t.topLight:SetPoint("TOPLEFT", t, "TOPLEFT", 4, -4)
            t.topLight:SetPoint("TOPRIGHT", t, "TOPRIGHT", -4, -4)
            t.topLight:SetHeight(1)
            t.topLight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
            t.topLight:SetColorTexture(1, 1, 1, 0.08)


            t.name = t:CreateFontString(nil, "OVERLAY")
            t.name:SetFont(IMAGO.FONT_TITLE, 18)
            t.name:SetPoint("LEFT", t.header, "LEFT", PADX - 3, 0)
            t.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
            t.name:SetText(IMAGO.L[def.name] or def.name)

            t.desc = t:CreateFontString(nil, "OVERLAY")
            t.desc:SetFont(IMAGO.FONT_BODY, 13)
            t.desc:SetPoint("TOPLEFT", t, "TOPLEFT", PADX, -(HEADER_H + 14))
            t.desc:SetWidth(colW - PADX * 2)
            t.desc:SetMaxLines(4)
            t.desc:SetJustifyH("LEFT")
            t.desc:SetSpacing(3)
            t.desc:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
            t.desc:SetText(IMAGO.L[def.desc] or "")

            if def.progress then
                t.bar = HomeBar(t)
                t.bar:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT", PADX, BOT_Y)
                t.bar:SetPoint("RIGHT", t, "RIGHT", -PADX, 0)
                t.desc:SetPoint("BOTTOM", t.bar, "TOP", 0, 12)
                t.na = t:CreateFontString(nil, "OVERLAY")
                t.na:SetFont(IMAGO.FONT_BODY, 12)
                t.na:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT", PADX, BOT_Y)
                t.na:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
                t.na:SetText(IMAGO.L["HOME_NA"] or "Not yet available")
                t.na:Hide()
            else
                t.browse = t:CreateFontString(nil, "OVERLAY")
                t.browse:SetFont(IMAGO.FONT_BODY, 13)
                t.browse:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT", PADX, BOT_Y)
                t.browse:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                t.browse:SetText((IMAGO.L["HOME_BROWSE"] or "Browse") .. " >")
                t.desc:SetPoint("BOTTOM", t.browse, "TOP", 0, 12)
            end

            t.tabIndex = def.tab
            t:SetScript("OnClick", function(self)
                if not self.enabled then return end
                if SOUNDKIT and SOUNDKIT.IG_CHARACTER_INFO_TAB then PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB) end
                IMAGO.Chronicle.SelectMainTab(self.tabIndex)
            end)
            t:SetScript("OnEnter", function(self)
                if not self.enabled then return end
                self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 0.8)
                self:SetBackdropColor(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.85)
                self.name:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
                SetHeaderGrad(self, true)
            end)
            t:SetScript("OnLeave", function(self)
                if not self.enabled then
                    self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
                    return
                end
                self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)
                self:SetBackdropColor(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], 0.75)
                self.name:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                SetHeaderGrad(self, false)
            end)
            t.enabled = true
            p.tiles[i] = t
        end
    end

    local p = f.homePage

    -- ==== POPULATE ==============================================
    local playerName = (UnitName and UnitName("player")) or ""
    p.welcome:SetText(playerName)

    local score, _, _, evaluated = 0, 0, 0, nil
    if IMAGO.GetChronicleScore then
        score, _, _, evaluated = IMAGO.GetChronicleScore()
    end
    p.scoreBox.t:SetText(tostring(score or 0))

    -- Counts
    local seen, total = 0, 0
    for _, entries in pairs(IMAGOdb.npcs or {}) do
        if type(entries) == "table" then
            for slug in pairs(entries) do
                total = total + 1
                if IMAGOSaved.seenNPCs[slug] then seen = seen + 1 end
            end
        end
    end
    local sZ, tZ = 0, 0
    for mapID in pairs(IMAGOdb.zones or {}) do
        tZ = tZ + 1
        if IMAGOSaved.seenZones[mapID] then sZ = sZ + 1 end
    end
    local sR, tR = 0, 0
    for slug in pairs(IMAGOdb.races or {}) do
        tR = tR + 1
        if IMAGOSaved.seenRaces[slug] then sR = sR + 1 end
    end
    local sC, tC = 0, 0
    for slug in pairs(IMAGOdb.classes or {}) do
        tC = tC + 1
        if (IMAGOSaved.seenClasses or {})[slug] then sC = sC + 1 end
    end
    local allSeen, allTotal = seen + sZ + sR + sC, total + tZ + tR + tC
    local perc = allTotal > 0 and (allSeen / allTotal) * 100 or 0

    -- Standing panel
    local rankTitle = IMAGO.Chronicle.ranks and IMAGO.Chronicle.ranks[1] and IMAGO.Chronicle.ranks[1].title or ""
    for _, r in ipairs(IMAGO.Chronicle.ranks or {}) do
        if perc >= r.perc then rankTitle = r.title end
    end
    local s = p.standingPanel
    s.rank:SetText(rankTitle)
    s.count:SetText(string.format(IMAGO.L["HOME_ENTRIES_FMT"] or "%d / %d entries uncovered (%d%%)", allSeen, allTotal, math.floor(perc)))
    s.bar:SetProgress(perc / 100, "")

    -- Latest discovery panel
    local l = p.latestPanel
    local hist = IMAGOSaved.history or {}
    local last = hist[1]
    local lastName, lastKind, lastTab
    if type(last) == "string" then
        local data = IMAGO.GetNPCData and IMAGO.GetNPCData(last)
        lastName = data and data.name or last
        lastKind = IMAGO.L["TAB_FATES"] or "Fates"
        if data and data.category and IMAGO.L[data.category] then
            lastKind = lastKind .. " · " .. IMAGO.L[data.category]
        end
        lastTab = 2
    elseif type(last) == "table" and last.type == "zone" then
        local zd = IMAGOdb.zones and IMAGOdb.zones[last.id]
        if zd and zd.name then
            lastName = zd.name
        elseif C_Map and C_Map.GetMapInfo then
            local info = C_Map.GetMapInfo(last.id)
            lastName = info and info.name
        end
        lastKind = IMAGO.L["TAB_ZONES"] or "Zones"
        lastTab = 3
    elseif type(last) == "table" and last.type == "race" then
        local rd = IMAGOdb.races and IMAGOdb.races[last.id]
        lastName = (rd and rd.name) or last.id
        lastKind = IMAGO.L["TAB_RACES"] or "Races"
        lastTab = 4
    elseif type(last) == "table" and last.type == "class" then
        local cd = IMAGOdb.classes and IMAGOdb.classes[last.id]
        lastName = (cd and cd.name) or last.id
        lastKind = IMAGO.L["TAB_CLASSES"] or "Classes"
        lastTab = 5
    end
    if lastName then
        l.name:SetText(lastName)
        l.kind:SetText(lastKind or "")
        l.link:Show()
        l.link:SetScript("OnClick", function()
            IMAGO.Chronicle.SelectMainTab(lastTab or 2)
        end)
    else
        l.name:SetText(IMAGO.L["HOME_NONE_YET"] or "The chronicle awaits your first discovery.")
        l.kind:SetText("")
        l.link:Hide()
    end

    -- Next goal panel: the achievement starred in the Achievements tab wins
    -- (while incomplete); otherwise fall back to the closest auto-pick
    local g = p.goalPanel
    local best, manual = nil, false
    local trackedId = IMAGOSaved.trackedGoal
    if trackedId and evaluated then
        for _, a in ipairs(evaluated) do
            if a.def.id == trackedId and not a.done then
                best, manual = a, true
                break
            end
        end
    end
    if not best and evaluated then
        for _, a in ipairs(evaluated) do
            if not a.done then
                local remain = a.total - a.seen
                if not best or remain < (best.total - best.seen)
                    or (remain == (best.total - best.seen) and a.frac > best.frac) then
                    best = a
                end
            end
        end
    end
    if best then
        local key = string.upper(best.def.id or "")
        g.name:SetText(IMAGO.L["ACH_" .. key .. "_NAME"] or "")
        g.desc:SetText(IMAGO.L["ACH_" .. key .. "_DESC"] or "")
        g.star:SetShown(manual)
        g.bar:Show()
        g.bar:SetProgress(best.frac, string.format("%d / %d", best.seen, best.total))
    else
        g.name:SetText(IMAGO.L["HOME_ALL_DONE"] or "All goals completed.")
        g.desc:SetText("")
        g.star:Hide()
        g.bar:Hide()
    end

    -- Tiles
    local progByTab = { [2] = { seen, total }, [3] = { sZ, tZ }, [4] = { sR, tR }, [5] = { sC, tC } }
    for _, t in ipairs(p.tiles) do
        local c = progByTab[t.tabIndex]
        if c then
            if c[2] > 0 then
                t.enabled = true
                t:SetAlpha(1)
                t.bar:Show()
                t.na:Hide()
                t.bar:SetProgress(c[1] / c[2], string.format("%d / %d", c[1], c[2]))
            else
                -- Not yet available: dimmed, no hover/click
                t.enabled = false
                t:SetAlpha(0.6)
                t:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.15)
                t.bar:Hide()
                t.na:Show()
            end
        end
    end

    p:Show()
end

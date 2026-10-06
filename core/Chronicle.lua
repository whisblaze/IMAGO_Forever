-- ============================================================
-- IMAGO — core/Chronicle.lua
-- The Chronicle: 10/10 cinematic UI, dashboard, search & filter
-- ============================================================

IMAGO.Chronicle = IMAGO.Chronicle or {}

-- ============================================================
-- LOCALE-AWARE FONTS
-- ============================================================
local FONT_TITLE, FONT_BODY
local locale = GetLocale()
if locale == "ruRU" then
    -- Cyrillic
    FONT_TITLE = "Fonts\\FRIZQT___CYR.TTF"
    FONT_BODY  = "Fonts\\FRIZQT___CYR.TTF"
elseif locale == "koKR" then
    FONT_TITLE = "Fonts\\2002.TTF"
    FONT_BODY  = "Fonts\\2002.TTF"
elseif locale == "zhCN" then
    FONT_TITLE = "Fonts\\ARKai_T.TTF"
    FONT_BODY  = "Fonts\\ARKai_C.TTF"
elseif locale == "zhTW" then
    FONT_TITLE = "Fonts\\blei00d.TTF"
    FONT_BODY  = "Fonts\\blei00d.TTF"
else
    -- Default Latin (deDE, enUS, frFR, esES, etc.)
    FONT_TITLE = "Fonts\\MORPHEUS.TTF"
    FONT_BODY  = "Fonts\\FRIZQT__.TTF"
end

local LAYOUT = IMAGO.LAYOUT

local eraColors = {
    ["Ancient"]   = {0.85, 0.65, 0.13},     -- Titanic bronze (Creation/Old Gods)
    ["Pre-WC1"]   = {0.60, 0.10, 0.10},     -- Blood red (orc invasion/First War)
    ["WC1"]       = {0.60, 0.10, 0.10},     -- Blood red (orc invasion/First War)
    ["Pre-WC2"]   = {0.10, 0.30, 0.80},     -- Lordaeron blue (Alliance/Second War)
    ["WC2"]       = {0.10, 0.30, 0.80},     -- Lordaeron blue (Alliance/Second War)
    ["Pre-WC3"]   = {0.45, 0.80, 0.20},     -- Plague green (the Scourge/Third War)
    ["WC3"]       = {0.45, 0.80, 0.20},     -- Plague green (the Scourge/Third War)
    ["Pre-Classic"]   = {0.7, 0.7, 0.7},        -- Neutral stone gray (old world)
    ["Classic"]   = {0.7, 0.7, 0.7},        -- Neutral stone gray (old world)
    ["Pre-TBC"]   = {0.12, 1.0, 0.0},       -- Darker forest/fel green (Outland)
    ["TBC"]       = {0.12, 1.0, 0.0},       -- Darker forest/fel green (Outland)
    ["Pre-WotLK"] = {0.0, 0.8, 1.0},        -- Frost blue (Icecrown/Arthas)
    ["WotLK"]     = {0.0, 0.8, 1.0},        -- Frost blue (Icecrown/Arthas)
    ["Pre-Cata"]  = {1.0, 0.27, 0.0},       -- Magma red (Deathwing)
    ["Cata"]      = {1.0, 0.27, 0.0},       -- Magma red (Deathwing)
    ["Pre-MoP"]   = {0.0, 1.0, 0.59},       -- Jade green (Pandaria)
    ["MoP"]       = {0.0, 1.0, 0.59},       -- Jade green (Pandaria)
    ["Pre-WoD"]   = {0.77, 0.12, 0.23},     -- Iron Horde dark red (Grommash)
    ["WoD"]       = {0.77, 0.12, 0.23},     -- Iron Horde dark red (Grommash)
    ["Pre-Legion"]= {0.19, 1.0, 0.0},       -- PIERCING FEL GREEN (Burning Legion)
    ["Legion"]    = {0.19, 1.0, 0.0},       -- PIERCING FEL GREEN (Burning Legion)
    ["Pre-BfA"]   = {1.0, 0.82, 0.0},       -- Azerite gold (Heart of Azeroth)
    ["BfA"]       = {1.0, 0.82, 0.0},       -- Azerite gold (Heart of Azeroth)
    ["Pre-SL"]    = {0.64, 0.21, 0.93},     -- Anima violet (Shadowlands)
    ["SL"]        = {0.64, 0.21, 0.93},     -- Anima violet (Shadowlands)
    ["Pre-DF"]    = {1.0, 0.49, 0.04},      -- Aspect amber (dragonflights)
    ["DF"]        = {1.0, 0.49, 0.04},      -- Aspect amber (dragonflights)
    ["Pre-TWW"]   = {0.0, 0.8, 1.0},        -- Radiant blue (the call of the Light)
    ["TWW"]       = {0.0, 0.8, 1.0},        -- Radiant blue (the call of the Light)
    ["Pre-MN"]    = {IMAGO_COLORS.VOID[1], IMAGO_COLORS.VOID[2], IMAGO_COLORS.VOID[3]},       -- Deep void violet (Xal'atath)
    ["Midnight"]  = {IMAGO_COLORS.VOID[1], IMAGO_COLORS.VOID[2], IMAGO_COLORS.VOID[3]},       -- Deep void violet (Xal'atath)
}

-- Chronological order of timeline era labels
local ERA_ORDER = {
    Ancient = 1, ["Pre-WC1"] = 2, WC1 = 3, ["Pre-WC2"] = 4, WC2 = 5,
    ["Pre-WC3"] = 6, WC3 = 7, ["Pre-Classic"] = 8, Classic = 9,
    ["Pre-TBC"] = 10, TBC = 11, ["Pre-WotLK"] = 12, WotLK = 13,
    ["Pre-Cata"] = 14, Cata = 15, ["Pre-MoP"] = 16, MoP = 17,
    ["Pre-WoD"] = 18, WoD = 19, ["Pre-Legion"] = 20, Legion = 21,
    ["Pre-BfA"] = 22, BfA = 23, ["Pre-SL"] = 24, SL = 25,
    ["Pre-DF"] = 26, DF = 27, ["Pre-TWW"] = 28, TWW = 29,
    ["Pre-MN"] = 30, Midnight = 31,
}

-- NPC records are expansion-scoped via their slug suffix: the timeline only
-- shows entries up to that expansion, and the expansion's own era entry sits
-- behind spoiler protection. Records without a suffix keep the legacy
-- behavior (full timeline, Midnight era spoiler-gated).
local SLUG_ERA = {
    _midnight = "Midnight",
    _tww      = "TWW",
}

-- Category → faction crest shown in the detail header
local FACTION_ICONS = {
    CAT_STORMWIND    = "Interface\\Timer\\Alliance-Logo",
    CAT_IRONFORGE    = "Interface\\Timer\\Alliance-Logo",
    CAT_GNOMEREGAN   = "Interface\\Timer\\Alliance-Logo",
    CAT_DARNASSUS    = "Interface\\Timer\\Alliance-Logo",
    CAT_THERAMORE    = "Interface\\Timer\\Alliance-Logo",
    CAT_WILDHAMMER   = "Interface\\Timer\\Alliance-Logo",
    CAT_ORCS         = "Interface\\Timer\\Horde-Logo",
    CAT_DARKSPEAR    = "Interface\\Timer\\Horde-Logo",
    CAT_FORSAKEN     = "Interface\\Timer\\Horde-Logo",
    CAT_THUNDERBLUFF = "Interface\\Timer\\Horde-Logo",
}

IMAGO.Chronicle.ranks = IMAGO.Chronicle.ranks or {}
IMAGO.Chronicle.zoneRanks = IMAGO.Chronicle.zoneRanks or {}

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
    if npcData.displayID then return tonumber(npcData.displayID) end
    if npcData.ids and type(npcData.ids) == "table" then
        local entry = npcData.ids[2] or npcData.ids[1]
        if entry then
            return type(entry) == "table" and tonumber(entry[1]) or tonumber(entry)
        end
    end
    return nil
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
        cf.name:SetFont(FONT_TITLE, 64, "OUTLINE")
        cf.name:SetPoint("BOTTOM", cf.model, "BOTTOM", 0, -80)
        cf.name:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        cf.name:SetShadowColor(0,0,0,1)
        cf.name:SetShadowOffset(2, -2)

        cf.sub = cf:CreateFontString(nil, "OVERLAY")
        cf.sub:SetFont(FONT_BODY, 16, "OUTLINE")
        cf.sub:SetPoint("TOP", cf.name, "BOTTOM", 0, -15)
        cf.sub:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])

        IMAGO.Chronicle.cinematicFrame = cf
    end

    local cf = IMAGO.Chronicle.cinematicFrame
    cf.name:SetText(npcData and npcData.name or "")
    cf.sub:SetText(IMAGO.L["CINEMATIC_CONTINUE"])

    -- FIX: SetCreature again with a safe cache-reload timer
    cf.model:ClearModel()
    local modelID = GetValidModelID(npcData)
    if modelID then 
        cf.model:SetCreature(modelID)
        C_Timer.After(0.15, function()
            if cf:IsShown() then cf.model:SetCreature(modelID) end
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

    f.closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    f.closeBtn:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)
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

    -- 3. The title itself (slightly larger & with engraved shadow)
    f.title = f:CreateFontString(nil, "OVERLAY")
    f.title:SetFont(FONT_TITLE, 24, "OUTLINE") -- Increased from 22 to 24 for more presence
    f.title:SetPoint("TOP", f, "TOP", 0, -16)
    f.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.title:SetShadowColor(0, 0, 0, 1) -- NEW: The drop shadow
    f.title:SetShadowOffset(2, -2)
    f.title:SetText("IMAGO — " .. (IMAGO.L["WINDOW_TITLE"] or "Chronik der Unvergessenen"))

    f.settingsBtn = CreateFrame("Button", nil, f)
    f.settingsBtn:SetSize(18, 18)
    f.settingsBtn:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -12)
    f.settingsBtn:SetNormalTexture("Interface\\Buttons\\UI-OptionsButton")
    f.settingsBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    f.settingsBtn:SetScript("OnClick", function()
        if Settings and Settings.OpenToCategory and IMAGO.settingsCategory then
            Settings.OpenToCategory(IMAGO.settingsCategory:GetID())
        elseif InterfaceOptionsFrame_OpenToCategory then
            InterfaceOptionsFrame_OpenToCategory("IMAGO")
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

    f.searchBox = CreateFrame("EditBox", "IMAGOChronicleSearch", f, "SearchBoxTemplate")
    f.searchBox:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH - (LAYOUT.SIDEBAR_CONTROL_PADDING * 2) - LAYOUT.SIDEBAR_CONTROL_GAP - LAYOUT.FILTER_WIDTH, 20)
    f.searchBox:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", LAYOUT.SIDEBAR_CONTROL_PADDING, -5)
    f.searchBox:SetAutoFocus(false)
    f.searchBox:SetScript("OnTextChanged", function(self)
        SearchBoxTemplate_OnTextChanged(self)
        IMAGO.Chronicle.UpdateList()
    end)

    f.filterBtn = CreateFrame("Button", nil, f, "UIMenuButtonStretchTemplate")
    f.filterBtn:SetSize(LAYOUT.FILTER_WIDTH, 22)
    f.filterBtn:SetPoint("LEFT", f.searchBox, "RIGHT", LAYOUT.SIDEBAR_CONTROL_GAP, 0)
    f.filterBtn.t = f.filterBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.filterBtn.t:SetPoint("CENTER")
    f.filterBtn:SetText(IMAGO.L["FILTER_ALL"])

    local btnText = f.filterBtn:GetFontString()
    if btnText then
        -- Forces the text to be 15px narrower than the button itself
        btnText:SetWidth(f.filterBtn:GetWidth() - 15) 
        -- Prevents line wraps and automatically enables the trailing "..."
        btnText:SetWordWrap(false) 
    end
    
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
            f.filterBtn:SetText(btn.t:GetText())
            f.filterMenu:Hide()
            IMAGO.Chronicle.UpdateList()
        end)
        f.filterMenu.pool[idx] = btn
        return btn
    end

    f.filterMenu.Rebuild = function()
        for _, b in ipairs(f.filterMenu.pool) do b:Hide() end
        local allItems = {
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
        local menuY = -8
        for i, item in ipairs(allItems) do
            local btn = GetOrCreateMenuBtn(i)
            btn._filterId = item.id
            btn.t:SetText(item.name)
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
    f.scrollFrame:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, -LAYOUT.SIDEBAR_HEADER_HEIGHT)
    f.scrollFrame:SetPoint("BOTTOMRIGHT", f.sidebar, "BOTTOMRIGHT", 0, 0)

    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleScrollScrollBar", f.scrollFrame)

    f.content = CreateFrame("Frame", nil, f.scrollFrame)
    f.content:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 1)
    f.scrollFrame:SetScrollChild(f.content)

    -- Zones fixed sidebar header (outside the scroll area)
    f.sidebar.zonesHeader = CreateFrame("Button", nil, f.sidebar)
    f.sidebar.zonesHeader:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, LAYOUT.SIDEBAR_HEADER_HEIGHT)
    f.sidebar.zonesHeader:SetPoint("TOPLEFT", f.sidebar, "TOPLEFT", 0, 0)

    f.sidebar.zonesHeader.bg = f.sidebar.zonesHeader:CreateTexture(nil, "BACKGROUND")
    f.sidebar.zonesHeader.bg:SetAllPoints()
    f.sidebar.zonesHeader.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])

    local zhl = f.sidebar.zonesHeader:CreateTexture(nil, "HIGHLIGHT")
    zhl:SetAllPoints()
    zhl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.3)

    f.sidebar.zonesHeader.t = f.sidebar.zonesHeader:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.sidebar.zonesHeader.t, "SIDEBAR_HEADER")
    f.sidebar.zonesHeader.t:SetPoint("CENTER", 0, 0)
    f.sidebar.zonesHeader.t:SetText(IMAGO.L["ZONES_OVERVIEW"] or (GetLocale() == "deDE" and "ZONEN ÜBERSICHT" or "ZONES OVERVIEW"))

    f.sidebar.zonesHeader:SetScript("OnClick", function()
        if SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON) end
        IMAGO.Chronicle.SetDetailAction(nil)
        for _, zb in pairs(IMAGO.Chronicle.zoneButtons or {}) do
            ApplyZoneEntryNormal(zb, zb.isManual)
        end
        f.selectedZoneMapID = nil
        if f.ShowDashboard then f.ShowDashboard() end
    end)
    f.sidebar.zonesHeader:Hide()

    -- ============================================================
    -- RIGHT SIDE: THE DETAIL FRAME
    -- ============================================================
    f.detailFrame = CreateFrame("Frame", nil, f, "BackdropTemplate")
    f.detailFrame:SetPoint("TOPLEFT", f.sidebar, "TOPRIGHT", LAYOUT.CONTENT_PADDING_LEFT, 0)
    f.detailFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -LAYOUT.CONTENT_PADDING_RIGHT, LAYOUT.WORKSPACE_BOTTOM)
    f.detailFrame:SetBackdrop((IMAGOSaved and IMAGOSaved.opaqueUI) and detailBackdropOpaque or detailBackdropDefault)
    f.detailFrame:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], (IMAGOSaved and IMAGOSaved.opaqueUI) and 1.0 or 0.95)

    -- NEW: The faction icon (fix for the current bug!)
    f.factionIcon = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.factionIcon:SetSize(50, 50)
    f.factionIcon:SetPoint("TOPRIGHT", f.detailFrame, "TOPRIGHT", -20, -10)
    f.factionIcon:SetAlpha(0.7)
    f.factionIcon:Hide()

    f.detailTitle = f.detailFrame:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.detailTitle, "DISPLAY")
    f.detailTitle:SetPoint("TOP", f.detailFrame, "TOP", 0, -15)

    -- The decorative lines under the title
    f.detailLineLeft = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailLineLeft:SetSize(355, 1)
    f.detailLineLeft:SetPoint("TOPRIGHT", f.detailTitle, "BOTTOM", 0, -8)
    f.detailLineLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.detailLineLeft:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7))

    f.detailLineRight = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailLineRight:SetSize(355, 1)
    f.detailLineRight:SetPoint("TOPLEFT", f.detailTitle, "BOTTOM", 0, -8)
    f.detailLineRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.detailLineRight:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

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

    f.detailSeparator = f.detailFrame:CreateTexture(nil, "ARTWORK")
    f.detailSeparator:SetSize(450, 8)
    f.detailSeparator:SetPoint("TOP", f.detailImage, "BOTTOM", 0, -15)
    f.detailSeparator:SetTexture("Interface\\COMMON\\UI-TooltipDivider-Transparent")
    f.detailSeparator:SetAlpha(0.6)
    f.detailSeparator:Hide()

    local function CreateTab(parent, text, xOffset)
        local tab = CreateFrame("Button", nil, parent)
        tab:SetSize(100, 25)
        tab:SetPoint("TOPLEFT", parent, "TOPLEFT", 300 + xOffset, -80)

        tab.text = tab:CreateFontString(nil, "OVERLAY")
        tab.text:SetFont(FONT_BODY, 14, "OUTLINE")
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

    f.infoScroll = CreateFrame("ScrollFrame", "IMAGOChronicleInfoScroll", f.detailFrame, "UIPanelScrollFrameTemplate")
    f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 310, -115)
    f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", 0, 100)

    IMAGO.StyleAndAnchorScrollBar("IMAGOChronicleInfoScrollScrollBar", f.infoScroll, IMAGO_COLORS.GOLD)

    f.infoContent = CreateFrame("Frame", nil, f.infoScroll)
    f.infoContent:SetSize(440, 1)
    f.infoScroll:SetScrollChild(f.infoContent)

    f.loreBody = f.infoContent:CreateFontString(nil, "OVERLAY")
    f.loreBody:SetFont(FONT_BODY, 14)
    f.loreBody:SetPoint("TOPLEFT", f.infoContent, "TOPLEFT", 10, 0)
    f.loreBody:SetWidth(420)
    f.loreBody:SetJustifyH("LEFT")
    f.loreBody:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3])
    f.loreBody:SetSpacing(6)

    f.loreSource = f.infoContent:CreateFontString(nil, "OVERLAY")
    f.loreSource:SetFont(FONT_BODY, 12, "")
    f.loreSource:SetPoint("BOTTOMRIGHT", f.infoContent, "BOTTOMRIGHT", -20, 8)
    f.loreSource:SetWidth(420)
    f.loreSource:SetJustifyH("RIGHT")
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
        f.loreBody:SetWidth(contentW - 40)
        f.loreBody:ClearAllPoints()
        f.loreBody:SetPoint("TOPLEFT", f.infoContent, "TOPLEFT", 20, 0)
        if f.loreSource then
            f.loreSource:SetWidth(contentW - 40)
        end
        if f.timelineContainer then
            f.timelineContainer:SetWidth(contentW - 20)
        end
        local h = 1
        if f.loreBody:IsShown() then
            h = f.loreBody:GetStringHeight() + 20
            if f.loreSource and f.loreSource:IsShown() then
                h = h + f.loreSource:GetStringHeight()
            end
        elseif f.timelineContainer and f.timelineContainer:IsShown() then
            h = f.timelineContainer:GetHeight() + 20
        end
        f.infoContent:SetHeight(math.max(1, h))
        IMAGO.UpdateScrollBarVisibility(f.infoScroll)
    end

    f.detailModel = CreateFrame("PlayerModel", nil, f.detailFrame)
    f.detailModel:SetSize(280, 400)
    f.detailModel:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 10, -80)
    -- No border - the model floats freely

    -- Animation switcher buttons
    f.detailModel.animButtons = {}
    local anims = {
        {id=3, label="St", name="Static"},
        {id=5, label="Ru", name="Run"},
        {id=26, label="Cs", name="Combat"},
        {id=18, label="At", name="Attack"}
    }

    local function UpdateAnimButtons(activeId)
        for _, btn in ipairs(f.detailModel.animButtons) do
            if btn.animId == activeId then
                btn.bg:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4)
            else
                btn.bg:SetVertexColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.6)
            end
        end
    end

    for i, anim in ipairs(anims) do
        local btn = CreateFrame("Button", nil, f.detailModel)
        btn:SetSize(20, 18)
        btn:SetPoint("BOTTOMLEFT", 8 + (i-1)*24, 8)
        btn.animId = anim.id

        -- Background
        btn.bg = btn:CreateTexture(nil, "BACKGROUND")
        btn.bg:SetAllPoints()
        btn.bg:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

        -- Text
        btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        btn.text:SetPoint("CENTER")
        btn.text:SetText(anim.label)
        btn.text:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])

        -- Click
        btn:SetScript("OnClick", function()
            f.detailModel:SetAnimation(anim.id)
            f.detailModel.currentAnim = anim.id
            UpdateAnimButtons(anim.id)
        end)

        -- Hover
        btn:SetScript("OnEnter", function()
            btn.text:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        end)
        btn:SetScript("OnLeave", function()
            btn.text:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
        end)

        table.insert(f.detailModel.animButtons, btn)
    end

    f.detailModel.UpdateAnimButtons = UpdateAnimButtons

    -- Start OnShow animation
    f.detailModel:SetScript("OnShow", function(self)
        self:SetAnimation(0) -- Idle as default
        if self.UpdateAnimButtons then
            self.UpdateAnimButtons(0)
        end
    end)
    
    f.detailModel:EnableMouse(true)
    f.detailModel:EnableMouseWheel(true)
    f.detailModel:SetScript("OnMouseWheel", function(self, delta)
        local zoom = self.zoomLevel or 1.0
        zoom = zoom - (delta * 0.15)
        if zoom < 0.2 then zoom = 0.2 end
        if zoom > 3.0 then zoom = 3.0 end
        self:SetCamDistanceScale(zoom)
        self.zoomLevel = zoom
    end)
    f.detailModel:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            self.isRotating = true
            self.lastX, self.lastY = GetCursorPosition()
        elseif button == "RightButton" then
            self.isPanning = true
            self.lastX, self.lastY = GetCursorPosition()
        end
    end)
    f.detailModel:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then self.isRotating = false end
        if button == "RightButton" then self.isPanning = false end
    end)
    f.detailModel:SetScript("OnHide", function(self)
        self.isRotating = false
        self.isPanning = false
    end)
    f.detailModel:SetScript("OnUpdate", function(self)
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

    f.startPage = CreateFrame("Frame", nil, f.detailFrame)
    f.startPage:SetAllPoints()

    -- 1. HEADER: The logo (isolated)
    f.startPage.logo = f.startPage:CreateTexture(nil, "ARTWORK")
    f.startPage.logo:SetSize(140, 140) 
    f.startPage.logo:SetPoint("TOP", f.startPage, "TOP", 0, -55)
    f.startPage.logo:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\Logo.tga")

    -- Horizontal divider to separate the logo from the rest of the data
    f.startPage.logoLine = f.startPage:CreateTexture(nil, "ARTWORK")
    f.startPage.logoLine:SetSize(520, 1)
    f.startPage.logoLine:SetPoint("TOP", f.startPage.logo, "BOTTOM", 0, -5)
    f.startPage.logoLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.startPage.logoLine:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5))

    -- 2. HERO SECTION: The current rank
    f.startPage.rankLabel = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.rankLabel, "NAV_ITEM", IMAGO_COLORS.GOLD_MUTED)
    f.startPage.rankLabel:SetPoint("TOP", f.startPage.logoLine, "BOTTOM", 0, -30)

    f.startPage.rankName = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.rankName, "RANK_TITLE")
    f.startPage.rankName:SetPoint("TOP", f.startPage.rankLabel, "BOTTOM", 0, -8)

    -- 3. TWO-COLUMN LAYOUT: The milestones
    -- Vertical divider in the middle
    f.startPage.vLine = f.startPage:CreateTexture(nil, "ARTWORK")
    f.startPage.vLine:SetSize(1, 200)
    f.startPage.vLine:SetPoint("TOP", f.startPage.rankName, "BOTTOM", 0, -35)
    f.startPage.vLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.startPage.vLine:SetGradient("VERTICAL", CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.3), CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0))

    -- LEFT COLUMN (achieved - right-aligned)
    f.startPage.completedLabel = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.completedLabel, "NAV_ITEM", IMAGO_COLORS.GOLD)
    f.startPage.completedLabel:SetPoint("TOPRIGHT", f.startPage.vLine, "TOPLEFT", -20, 0)

    f.startPage.completedMilestones = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.completedMilestones, "NAV_ITEM")
    f.startPage.completedMilestones:SetPoint("TOPRIGHT", f.startPage.completedLabel, "BOTTOMRIGHT", 0, -10)
    f.startPage.completedMilestones:SetJustifyH("RIGHT")
    f.startPage.completedMilestones:SetSpacing(8)

    f.startPage.nextLabel = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.nextLabel, "NAV_ITEM", IMAGO_COLORS.TEXT_MUTED)
    f.startPage.nextLabel:SetPoint("TOPLEFT", f.startPage.vLine, "TOPRIGHT", 20, 0)

    f.startPage.milestones = f.startPage:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(f.startPage.milestones, "NAV_ITEM", IMAGO_COLORS.TEXT_MUTED)
    f.startPage.milestones:SetPoint("TOPLEFT", f.startPage.nextLabel, "BOTTOMLEFT", 0, -10)
    f.startPage.milestones:SetJustifyH("LEFT")
    f.startPage.milestones:SetSpacing(8)

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
    f.hintPage.warning:SetFont(FONT_BODY, 15, "OUTLINE")
    f.hintPage.warning:SetPoint("TOP", f.hintPage.icon, "BOTTOM", 0, -20)
    f.hintPage.warning:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.hintPage.warning:SetText(IMAGO.L["HINT_IDENTITY_HIDDEN"])

    -- 5. The description
    f.hintPage.desc = f.hintPage:CreateFontString(nil, "OVERLAY")
    f.hintPage.desc:SetFont(FONT_BODY, 14)
    f.hintPage.desc:SetPoint("TOP", f.hintPage.warning, "BOTTOM", 0, -15)
    f.hintPage.desc:SetWidth(400)
    f.hintPage.desc:SetJustifyH("CENTER")
    f.hintPage.desc:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.hintPage.desc:SetSpacing(6)

    f.footer = IMAGO.CreateProgressFooter(f.detailFrame, 620)

    -- ==========================================
    -- MODE TOGGLE BUTTON + DROPDOWN
    -- ==========================================
    f.modeBtn = CreateFrame("Button", nil, f.detailFrame, "BackdropTemplate")
    f.modeBtn:SetSize(85, 22)
    f.modeBtn:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 14, -14)
    f.modeBtn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 10, insets = {left=3,right=3,top=3,bottom=3} })
    f.modeBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.85)
    f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6)

    f.modeBtn.label = f.modeBtn:CreateFontString(nil, "OVERLAY")
    f.modeBtn.label:SetFont(FONT_BODY, 11, "OUTLINE")
    f.modeBtn.label:SetPoint("CENTER", f.modeBtn, "CENTER", 0, 0)
    f.modeBtn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

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
        btn.border = btn:CreateTexture(nil, "OVERLAY")
        btn.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
        btn.border:SetSize(58, 58)
        btn.border:SetPoint("TOPLEFT", -7, 7)
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
    f.confirmDialog:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.97)
    f.confirmDialog:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.9)
    f.confirmDialog:Hide()

    f.confirmDialog.title = f.confirmDialog:CreateFontString(nil, "OVERLAY")
    f.confirmDialog.title:SetFont(FONT_BODY, 13, "OUTLINE")
    f.confirmDialog.title:SetPoint("TOP", f.confirmDialog, "TOP", 0, -14)
    f.confirmDialog.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

    f.confirmDialog.line = f.confirmDialog:CreateTexture(nil, "ARTWORK")
    f.confirmDialog.line:SetSize(280, 1)
    f.confirmDialog.line:SetPoint("TOP", f.confirmDialog.title, "BOTTOM", 0, -6)
    f.confirmDialog.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.confirmDialog.line:SetVertexColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.4)

    f.confirmDialog.desc = f.confirmDialog:CreateFontString(nil, "OVERLAY")
    f.confirmDialog.desc:SetFont(FONT_BODY, 11)
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
        btn.lbl:SetFont(FONT_BODY, 11, "OUTLINE")
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
    f.modeDropdown:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.97)
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
        btn.text:SetFont(FONT_BODY, 11)
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
        f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 1)
    end)
    f.modeBtn:SetScript("OnLeave", function()
        f.modeBtn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6)
    end)

    -- Back button: sits to the right of modeBtn inside detailFrame
    f.backBtn = CreateFrame("Button", nil, f.detailFrame, "BackdropTemplate")
    f.backBtn:SetSize(70, 22)
    f.backBtn:SetPoint("LEFT", f.modeBtn, "RIGHT", 8, 0)
    f.backBtn:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 10, insets = {left=3,right=3,top=3,bottom=3} })
    f.backBtn:SetBackdropColor(IMAGO_COLORS.BG_MAIN[1], IMAGO_COLORS.BG_MAIN[2], IMAGO_COLORS.BG_MAIN[3], 0.85)
    f.backBtn:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.4)

    f.backBtn.label = f.backBtn:CreateFontString(nil, "OVERLAY")
    f.backBtn.label:SetFont(FONT_BODY, 11, "OUTLINE")
    f.backBtn.label:SetPoint("CENTER", f.backBtn, "CENTER", 0, 0)
    f.backBtn.label:SetText("< " .. (IMAGO.L and IMAGO.L["BACK"] or "Back"))
    f.backBtn.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    f.backBtn.enabled = false

    f.backBtn:SetScript("OnEnter", function(self)
        if self.enabled then
            self:SetBackdropBorderColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3], 1)
        end
    end)
    f.backBtn:SetScript("OnLeave", function(self)
        if self.enabled then
            self:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6)
        else
            self:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.4)
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
        end
        C_Timer.After(0, function()
            isNavigatingBack = false
        end)

        if #navStack == 0 then
            self.enabled = false
            self:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.4)
            self.label:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
        end
    end)

    IMAGO.Chronicle.SetBackEnabled = function(val)
        local btn = IMAGO.Chronicle.frame and IMAGO.Chronicle.frame.backBtn
        if not btn then return end
        btn.enabled = val
        if val then
            btn:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.6)
            btn.label:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
        else
            btn:SetBackdropBorderColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3], 0.4)
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
    f.numTabs = 4
    local tabNames = {IMAGO.L["TAB_FATES"], IMAGO.L["TAB_ZONES"], IMAGO.L["TAB_INSTANCES"], IMAGO.L["TAB_CREDITS"]}
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
    end

    -- ==========================================
    -- NEW: THE "COMING SOON" SCREEN
    -- ==========================================
    f.comingSoonPage = CreateFrame("Frame", nil, f)
    f.comingSoonPage:SetAllPoints()
    f.comingSoonPage:Hide()

    f.comingSoonPage.bg = f.comingSoonPage:CreateTexture(nil, "BACKGROUND")
    f.comingSoonPage.bg:SetAllPoints()
    f.comingSoonPage.bg:SetColorTexture(0.04, 0.04, 0.04, 0.98)

    f.comingSoonPage.icon = f.comingSoonPage:CreateTexture(nil, "ARTWORK")
    f.comingSoonPage.icon:SetSize(250, 250)
    f.comingSoonPage.icon:SetPoint("TOP", 0, -100)
    f.comingSoonPage.icon:SetTexture("Interface\\AddOns\\IMAGO_forever\\media\\Logo.tga")
    f.comingSoonPage.icon:SetAlpha(0.1)
    f.comingSoonPage.icon:SetDesaturated(true)

    f.comingSoonPage.title = f.comingSoonPage:CreateFontString(nil, "OVERLAY")
    f.comingSoonPage.title:SetFont(FONT_TITLE, 36, "OUTLINE")
    f.comingSoonPage.title:SetPoint("CENTER", 0, -30)
    f.comingSoonPage.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.comingSoonPage.title:SetShadowColor(0, 0, 0, 1)
    f.comingSoonPage.title:SetShadowOffset(2, -2)

    f.comingSoonPage.desc = f.comingSoonPage:CreateFontString(nil, "OVERLAY")
    f.comingSoonPage.desc:SetFont(FONT_BODY, 15)
    f.comingSoonPage.desc:SetPoint("TOP", f.comingSoonPage.title, "BOTTOM", 0, -20)
    f.comingSoonPage.desc:SetTextColor(IMAGO_COLORS.TEXT_MUTED[1], IMAGO_COLORS.TEXT_MUTED[2], IMAGO_COLORS.TEXT_MUTED[3])
    f.comingSoonPage.desc:SetJustifyH("CENTER")
    f.comingSoonPage.desc:SetSpacing(8)


    -- ==========================================
    -- NEW: TAB SWITCHING LOGIC (LOCALIZED)
    -- ==========================================
    function IMAGO.Chronicle.SelectMainTab(index)
        PanelTemplates_SetTab(f, index) 
        f.activeTabIndex = index 
        
        -- RESET: Safely hide everything on the right side
        if f.detailTitle then f.detailTitle:Hide() end
        if f.detailLineLeft then f.detailLineLeft:Hide() end
        if f.detailLineRight then f.detailLineRight:Hide() end
        if f.tabLore then f.tabLore:Hide() end
        if f.tabTime then f.tabTime:Hide() end
        if f.infoScroll then f.infoScroll:Hide() end
        if f.detailModel then f.detailModel:Hide() end
        if f.factionIcon then f.factionIcon:Hide() end
        if f.hintPage then f.hintPage:Hide() end
        if f.startPage then f.startPage:Hide() end
        if f.detailImage then f.detailImage:Hide() end
        if f.detailImageBorder then f.detailImageBorder:Hide() end -- NEW: hide the border
        if f.detailSeparator then f.detailSeparator:Hide() end
        
        if f.detailImage then f.detailImage:Hide() end
        if f.detailImageBorder then f.detailImageBorder:Hide() end
        if f.detailSeparator then f.detailSeparator:Hide() end
        if f.creditsPage then f.creditsPage:Hide() end
        if f.creditsHeader then f.creditsHeader:Hide() end
        IMAGO.Chronicle.SetDetailAction(nil)
        if f.filterMenu         then f.filterMenu:Hide()         end

        if index == 1 or index == 2 then
            f.comingSoonPage:Hide()
            -- Fates/Zones: flat list (no expansion picker)
            f.searchBox:SetShown(index == 1)
            f.filterBtn:SetShown(index == 1)
            f.sidebar:Show(); f.detailFrame:Show()
            if f.sidebar.zonesHeader then f.sidebar.zonesHeader:SetShown(index == 2) end
            IMAGO.Chronicle.UpdateList()
            if f.ShowDashboard then f.ShowDashboard() end
        elseif index == 3 then
            -- Hide main UI (for the instances tab)
            f.searchBox:Hide()
            f.filterBtn:Hide()
            f.sidebar:Hide()
            f.detailFrame:Hide()

            f.comingSoonPage.title:SetText(IMAGO.L["COMING_SOON_INSTANCES_TITLE"])
            f.comingSoonPage.desc:SetText(IMAGO.L["COMING_SOON_INSTANCES_DESC"])
            f.comingSoonPage:Show()
        elseif index == 4 then
            -- Credits tab
            f.searchBox:Hide()
            f.filterBtn:Hide()
            f.sidebar:Hide()
            f.detailFrame:Hide()
            f.comingSoonPage:Hide()

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
                f.creditsHeader.title:SetFont(FONT_TITLE, 28, "OUTLINE")
                f.creditsHeader.title:SetPoint("TOP", f.creditsHeader.logo, "BOTTOM", 0, -5)
                f.creditsHeader.title:SetText(IMAGO.L["CREDITS_TITLE"])
                f.creditsHeader.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

                f.creditsHeader.desc = f.creditsHeader:CreateFontString(nil, "OVERLAY")
                f.creditsHeader.desc:SetFont(FONT_BODY, 13)
                f.creditsHeader.desc:SetPoint("TOP", f.creditsHeader.title, "BOTTOM", 0, -10)
                f.creditsHeader.desc:SetWidth(550)
                f.creditsHeader.desc:SetText(IMAGO.L["CREDITS_DESC"])
                f.creditsHeader.desc:SetTextColor(IMAGO_COLORS.GOLD_MUTED[1], IMAGO_COLORS.GOLD_MUTED[2], IMAGO_COLORS.GOLD_MUTED[3])
                f.creditsHeader.desc:SetJustifyH("CENTER")

                f.creditsHeader.topHint = f.creditsHeader:CreateFontString(nil, "OVERLAY")
                f.creditsHeader.topHint:SetFont(FONT_BODY, 12)
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
                    {name = "Cadash", roles = "Lore Scribe, Translator", top = true},
                    {name = "austin", roles = "Archivist, Lore Scribe", top = true},
                    {name = "Elanor", roles = "Data Miner, Translator, Moderator", top = true},
                    {name = "DeMaa", roles = "Lua Developer, Moderator", top = true},
                    {name = "druidian", roles = "Archivist, Lore Scribe", top = true},
                    {name = "Minorou", roles = "Lore Scribe", top = true},
                    {name = "MayaWoW", roles = "Data Miner, Translator", top = true},
                    {name = "Lewi", roles = "Archivist, Lore Scribe, Translator", top = true},
                    {name = "Nebb", roles = "Lore Scribe", top = true},
                    {name = "Metrus", roles = "Lore Scribe, Translator", top = true},
                    {name = "Karstan", roles = "Lore Scribe, Translator"},
                    {name = "Elsafan (Crazycat).", roles = "Archivist, Data Miner"},
                    {name = "Travanoid", roles = "Lore Scribe"},
                    {name = "Lemurensohn", roles = "Archivist, Translator"},
                    {name = "zeerocool11", roles = "Archivist, Lore Scribe, Data Miner, Lua Developer"},
                    {name = "ALI4S", roles = "Lua Developer"},
                    {name = "Remu", roles = "Data Miner, Translator"},
                    {name = "zelkaris", roles = "Lore Scribe, Data Miner, Lua Developer"},
                    {name = "Duschgell", roles = "Archivist"},
                    {name = "Nihilea", roles = "Data Miner, Translator"},
                    {name = "Saljourn", roles = "Lore Scribe, Data Miner"},
                    {name = "Riknar", roles = "Lore Scribe"},
                    {name = "MortiousPrime", roles = "Archivist, Lore Scribe, Data Miner"},
                    {name = "LeoColpas", roles = "Translator"},
                    {name = "Chadson Chappo", roles = "Archivist"},
                    {name = "ruffboi", roles = "Lore Scribe"},
                    {name = "Echo_Delta_Golf", roles = "Lore Scribe"},
                    {name = "Lilith", roles = "Translator"},
                    {name = "LowRoars", roles = "Archivist, Lore Scribe, Data Miner, Lua Developer"},
                    {name = "咪嚕", roles = "Archivist, Translator"},
                    {name = "Silver_Wind809", roles = "Data Miner, Lua Developer"},
                    {name = "William Orr", roles = "Data Miner"},
                    {name = "Nuise_16094", roles = "Translator"},
                    {name = "Nuise", roles = "Translator"},
                    {name = "Jay! :P", roles = "Lore Scribe, Data Miner"},
                    {name = "!pxrty193", roles = "Lua Developer"},
                    {name = "johnnyd2", roles = "Tester"},
                    {name = "Kittywulfe", roles = "Tester"},
                }

                local yOffset = -40 -- More space after the divider
                local spacing = 25
                for i, person in ipairs(contributors) do
                    local entry = content:CreateFontString(nil, "OVERLAY")
                    
                    if person.top then
                        -- Noble gold for top members
                        entry:SetFont(FONT_BODY, 16, "OUTLINE")
                        entry:SetText(string.format("|cFFC8A84B%s|r  |cFFD4AF37(%s)|r", person.name, person.roles))
                    else
                        -- Subtle silver for everyone else
                        entry:SetFont(FONT_BODY, 14, "")
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

    f.ShowDashboard = function()
        f.detailTitle:Hide()
        f.detailLineLeft:Hide()
        f.detailLineRight:Hide()
        f.tabLore:Hide()
        f.tabTime:Hide()
        f.infoScroll:Hide()
        if f.loreSource then f.loreSource:Hide() end
        f.detailModel:Hide()
        f.hintPage:Hide() 
        f.factionIcon:Hide()
        if f.detailImage then f.detailImage:Hide() end
        if f.detailImageBorder then f.detailImageBorder:Hide() end
        if f.detailSeparator then f.detailSeparator:Hide() end
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
        f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", 300, -115)
        f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMRIGHT", 0, 100)
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
    local spoilerEra  = npcEra or "Midnight"

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
    local textW = math.max(310, contentW - 140)
    local dividerW = math.max(320, contentW - 60)

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
            era:SetFont(FONT_BODY, 13, "OUTLINE")
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
            txt:SetFont(FONT_BODY, 14, "")
            txt:SetJustifyH("LEFT")
            txt:SetSpacing(4)
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
            local spoilerTitle = L["SPOILER_" .. spoilerEra .. "_TITLE"] or L["SPOILER_MIDNIGHT_TITLE"]
            local spoilerHint  = L["SPOILER_" .. spoilerEra .. "_HINT"]  or L["SPOILER_MIDNIGHT_HINT"]
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
    if IMAGO.Chronicle.homeBtn then IMAGO.Chronicle.homeBtn:Hide() end

    -- ============================================================
    -- CLEANUP: Hides custom buttons before new tabs load
    -- ============================================================
    if f.sidebar.zonesHeader then
        f.sidebar.zonesHeader:Hide()
    end

    -- ============================================================
    -- TAB 1: NPCs / FATES
    -- ============================================================
    if activeTab == 1 then
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

        local perc = total > 0 and (seen / total) * 100 or 0
        local rankTitle = IMAGO.Chronicle.ranks[1] and IMAGO.Chronicle.ranks[1].title or ""
        for _, r in ipairs(IMAGO.Chronicle.ranks) do 
            if perc >= r.perc then rankTitle = r.title end 
        end

        IMAGO.UpdateProgressFooter(f.footer, perc, 100, rankTitle, string.format(IMAGO.L["FOOTER_PROGRESS"], seen, total, math.floor(perc)))
        
        f.startPage.rankLabel:SetText(IMAGO.L["STARTPAGE_RANK"])
        f.startPage.completedLabel:SetText(IMAGO.L["STARTPAGE_COMPLETED"])
        f.startPage.nextLabel:SetText(IMAGO.L["STARTPAGE_NEXT"])
        f.startPage.rankName:SetText(rankTitle)
        
        local completedRanksStr, nextRanksStr = "", ""
        
        for _, r in ipairs(IMAGO.Chronicle.ranks) do
            local rTitle = r.title or ""
            if r.perc <= perc then
                completedRanksStr = completedRanksStr .. string.format("|c%s%s (%s %d%%)|r\n", IMAGO_HEX.GOLD, rTitle, IMAGO.L["WORD_AT"], r.perc)
            else
                nextRanksStr = nextRanksStr .. string.format("|c%s%s (%s %d%%)|r\n", IMAGO_HEX.TEXT_MUTED, rTitle, IMAGO.L["WORD_AT"], r.perc)
            end
        end
        
        f.startPage.completedMilestones:SetText(completedRanksStr == "" and IMAGO.L["STARTPAGE_NO_MILESTONES"] or completedRanksStr)
        f.startPage.milestones:SetText(nextRanksStr == "" and IMAGO.L["STARTPAGE_MAX_REACHED"] or nextRanksStr)

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
        
        if not IMAGO.Chronicle.homeBtn then
            local homeBtn = CreateFrame("Button", nil, f.content)
            homeBtn:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 35)
            homeBtn.bg = homeBtn:CreateTexture(nil, "BACKGROUND")
            homeBtn.bg:SetAllPoints()
            homeBtn.bg:SetColorTexture(IMAGO_COLORS.BG_PANEL[1], IMAGO_COLORS.BG_PANEL[2], IMAGO_COLORS.BG_PANEL[3], IMAGO_COLORS.BG_PANEL[4])

            local hl = homeBtn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(IMAGO_COLORS.BG_HOVER[1], IMAGO_COLORS.BG_HOVER[2], IMAGO_COLORS.BG_HOVER[3], 0.3)

            homeBtn.t = homeBtn:CreateFontString(nil, "OVERLAY")
            IMAGO.ApplyTextStyle(homeBtn.t, "SIDEBAR_HEADER")
            homeBtn.t:SetPoint("LEFT", homeBtn, "LEFT", 10, 0)
            homeBtn.t:SetPoint("RIGHT", homeBtn, "RIGHT", -10, 0)
            homeBtn.t:SetWordWrap(false)
            homeBtn.t:SetJustifyH("CENTER")

            homeBtn:SetScript("OnEnter", function(self)
                IMAGO.ShowTooltipIfTruncated(self, self.t)
            end)
            homeBtn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)

            homeBtn:SetScript("OnClick", function()
                f.selectedNPC = nil
                for _, b in pairs(IMAGO.Chronicle.buttons) do
                    ApplyNPCButtonNormal(b)
                end
                IMAGO.Chronicle.SetDetailAction(nil)
                if f.ShowDashboard then f.ShowDashboard() end
            end)
            IMAGO.Chronicle.homeBtn = homeBtn
        end
        
        IMAGO.Chronicle.homeBtn.t:SetText(IMAGO.L["DASHBOARD_TITLE"])
        IMAGO.Chronicle.homeBtn:SetPoint("TOPLEFT", f.content, "TOPLEFT", 0, -yOffset)
        IMAGO.Chronicle.homeBtn:Show()
        yOffset = yOffset + 45

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

                hdr.line = hdr:CreateTexture(nil, "ARTWORK")
                hdr.line:SetSize(LAYOUT.SIDEBAR_USABLE_WIDTH, 1)
                hdr.line:SetPoint("BOTTOM", 0, 0)
                hdr.line:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
                hdr.line:SetGradient("HORIZONTAL", CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0.5), CreateColor(IMAGO_COLORS.DIVIDER[1], IMAGO_COLORS.DIVIDER[2], IMAGO_COLORS.DIVIDER[3], 0))

                hdr.icon = hdr:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(hdr.icon, "NAV_ITEM")
                hdr.icon:SetPoint("LEFT", 5, 0)

                hdr.t = hdr:CreateFontString(nil, "OVERLAY")
                IMAGO.ApplyTextStyle(hdr.t, "NAV_CATEGORY")
                hdr.t:SetPoint("LEFT", 20, 0)
                hdr.t:SetPoint("RIGHT", hdr, "RIGHT", -10, 0)
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
                        btn.newTag.ag = ag

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
                    btn.bg:SetColorTexture(1, 1, 1, (bIdx % 2 == 0 and 0.03 or 0))

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
                    local leftInset = btn.fav:IsShown() and 28 or 8
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
                        if not isNavigatingBack then
                            local entry = nil
                            if f.selectedNPCSlug and f.selectedNPCSlug ~= "" and f.selectedNPCSlug ~= npc.slug then
                                entry = { type = "npc", slug = f.selectedNPCSlug }
                            elseif f.selectedZoneMapID then
                                entry = { type = "zone", mapID = f.selectedZoneMapID }
                            end
                            if entry then
                                table.insert(navStack, entry)
                                if IMAGO.Chronicle.SetBackEnabled then
                                    IMAGO.Chronicle.SetBackEnabled(true)
                                end
                            end
                        end
                        f.selectedZoneMapID = nil

                        f.selectedNPC = npc.data
                        f.selectedNPCSlug = npc.slug
                        
                        for _, b in pairs(IMAGO.Chronicle.buttons) do
                            if b ~= btn then ApplyNPCButtonNormal(b) end
                        end
                        ApplyNPCButtonSelected(btn)
                        
                        if isVisible then
                            f.hintPage:Hide()
                            
                            local function OpenLoreTab()
                                f.detailTitle:Show()
                                f.detailLineLeft:Show()
                                f.detailLineRight:Show()
                                f.tabLore:Show()
                                f.tabTime:Show()
                                f.infoScroll:Show()
                                f.detailModel:Show()
                                
                                local cat = npc.data.category or ""
                                local factionTex = FACTION_ICONS[cat]
                                if factionTex then
                                    f.factionIcon:SetTexture(factionTex)
                                    f.factionIcon:Show()
                                else
                                    f.factionIcon:Hide()
                                end

                                f.detailTitle:SetText(name)

                                local lore = npc.data.lore or ""
                                local firstByte = string.byte(lore, 1)
                                local charLen = firstByte >= 192 and 2 or 1  -- UTF-8: 2 bytes if >= 0xC0
                                local firstLetter = lore:sub(1, charLen)
                                local restLore = lore:sub(charLen + 1)
                                -- Pass selfSlug so the NPC doesn't link their own name,
                                local linked = IMAGO.TextLinker.LinkNames("|cffc8a84b" .. firstLetter .. "|r" .. restLore,
                                    npc.slug,
                                    nil, nil, nil
                                )
                                
                                f.loreBody:SetText(linked)

                                local source = npc.data.source
                                if source and source ~= "" then
                                    local fmt = IMAGO.L["LORE_AUTHOR"] or "Written by %s"
                                    f.loreSource:SetText(string.format(fmt, source))
                                else
                                    f.loreSource:Hide()
                                end

                                f.detailModel:ClearModel()
                                local modelID = GetValidModelID(npc.data)
                                if modelID then 
                                    f.detailModel:SetCreature(modelID)
                                    -- Start animation after a short delay (model must load)
                                    C_Timer.After(0.2, function()
                                        if f.detailModel:IsShown() then 
                                            f.detailModel:SetCreature(modelID)
                                            f.detailModel:SetAnimation(0)
                                            -- Reset buttons to idle
                                            if f.detailModel.UpdateAnimButtons then
                                                f.detailModel.UpdateAnimButtons(0)
                                            end
                                        end
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
                                            elseif LoadAddOn then
                                                LoadAddOn("Blizzard_EncounterJournal")
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

    -- ============================================================
    -- TAB 2: ZONES OF MEMORY
    -- ============================================================
    elseif activeTab == 2 then
        if f.sidebar.zonesHeader then f.sidebar.zonesHeader:Show() end
        local zIdx = 1
        local totalZones, seenZones = 0, 0

        for mapID, zdata in pairs(IMAGOdb.zones or {}) do
            totalZones = totalZones + 1
            if IMAGOSaved.seenZones[mapID] then seenZones = seenZones + 1 end
        end

        local perc = totalZones > 0 and (seenZones / totalZones) * 100 or 0

        local rankTitle = IMAGO.Chronicle.zoneRanks[1] and IMAGO.Chronicle.zoneRanks[1].title or ""
        for _, r in ipairs(IMAGO.Chronicle.zoneRanks) do 
            if perc >= r.perc then rankTitle = r.title end 
        end

        IMAGO.UpdateProgressFooter(f.footer, perc, 100, rankTitle, string.format(IMAGO.L["FOOTER_ZONES_PROGRESS"] or "%d / %d Zonen entdeckt (%d%%)", seenZones, totalZones, math.floor(perc)))

        f.startPage.rankLabel:SetText(IMAGO.L["STARTPAGE_ZONES_RANK"])
        f.startPage.rankName:SetText(rankTitle)
        f.startPage.completedLabel:SetText(IMAGO.L["STARTPAGE_COMPLETED"]) -- Reusing the existing string!
        f.startPage.nextLabel:SetText(IMAGO.L["STARTPAGE_ZONES_NEXT"])

        local completedRanksStr, nextRanksStr = "", ""
                
        for _, r in ipairs(IMAGO.Chronicle.zoneRanks) do
            local rTitle = r.title or ""
            if r.perc <= perc then
                completedRanksStr = completedRanksStr .. string.format("|c%s%s (%s %d%%)|r\n", IMAGO_HEX.GOLD, rTitle, IMAGO.L["WORD_AT"], r.perc)
            else
                nextRanksStr = nextRanksStr .. string.format("|c%s%s (%s %d%%)|r\n", IMAGO_HEX.TEXT_MUTED, rTitle, IMAGO.L["WORD_AT"], r.perc)
            end
        end

        f.startPage.completedMilestones:SetText(completedRanksStr == "" and IMAGO.L["STARTPAGE_NO_MILESTONES"] or completedRanksStr)
        f.startPage.milestones:SetText(nextRanksStr == "" and "|c" .. IMAGO_HEX.SUCCESS .. (IMAGO.L["STARTPAGE_MAX_REACHED"] or "MAXIMALRANG ERREICHT!") .. "|r" or nextRanksStr)

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
        local lore = zoneData.lore or ""

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
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end
                f.selectedNPCSlug = nil
                f.selectedZoneMapID = mapID

                f.startPage:Hide()
                f.hintPage:Hide()
                f.tabLore:Hide() 
                f.tabTime:Hide()
                f.detailModel:Hide()
                f.factionIcon:Hide()
                if f.timelineContainer then f.timelineContainer:Hide() end

                f.detailTitle:Show()
                f.detailLineLeft:Show()
                f.detailLineRight:Show()
                f.detailTitle:SetText(name)

                if f.detailImage then
                    if zoneData.texturePath and zoneData.texturePath ~= "" then
                        f.detailImage:SetTexture(zoneData.texturePath)
                        f.detailImage:SetDesaturated(false)
                        f.detailImage:SetVertexColor(1, 1, 1, 1)
                        f.detailImage:SetSize(760, 200)
                        f.detailImage:SetTexCoord(0, 1, 0.195, 0.805)
                        f.detailImage:Show()
                        if f.detailImageBorder then f.detailImageBorder:Show() end
                        if f.detailSeparator then f.detailSeparator:Show() end
                    else
                        f.detailImage:Hide()
                        if f.detailImageBorder then f.detailImageBorder:Hide() end
                        if f.detailSeparator then f.detailSeparator:Hide() end
                    end
                end

                -- Some languages take 2 bytes for their characters
                local firstByte = string.byte(lore, 1)
                local charLen = firstByte >= 192 and 2 or 1  -- UTF-8: 2 bytes if >= 0xC0
                local firstLetter = lore:sub(1, charLen)
                local restLore = lore:sub(charLen + 1)
                local formattedLore = "|c" .. IMAGO_HEX.GOLD .. firstLetter .. "|r" .. restLore

                if zoneData.pointsOfInterest and next(zoneData.pointsOfInterest) then
                    formattedLore = formattedLore .. "\n\n|c" .. IMAGO_HEX.GOLD .. (IMAGO.L["ZONE_POI_HEADER"] or "POINTS OF INTEREST") .. "|r\n_________________________________\n\n"
                    for _, poi in ipairs(zoneData.pointsOfInterest) do
                        local pName = poi.name or ""
                        local pLore = poi.lore or ""
                        formattedLore = formattedLore .. "|c" .. IMAGO_HEX.GOLD_BRIGHT .. "> " .. pName .. "|r\n" .. pLore .. "\n\n"
                    end
                end

                -- Pass mapID as selfMapID
                -- so this zone doesn’t link back to itself.
                f.loreBody:SetText(IMAGO.TextLinker.LinkNames(formattedLore, nil, mapID, nil, nil))
                f.loreBody:SetJustifyH("LEFT")
                f.loreBody:Show()
                if f.loreSource then f.loreSource:Hide() end

                local imgLeft = (f.detailFrame:GetWidth() - 760) / 2
                f.infoScroll:ClearAllPoints()
                f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft, -290)
                f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMLEFT", imgLeft + 760, 100)
                f.infoScroll:Show()
                f.infoScroll:SetVerticalScroll(0)
                if IMAGO.Chronicle.AdjustInfoScroll then IMAGO.Chronicle.AdjustInfoScroll() end

                -- Action button: open this zone on the World Map
                IMAGO.Chronicle.SetDetailAction({
                    label   = IMAGO.L["ACTION_OPEN_MAP"] or "World Map",
                    tooltip = IMAGO.L["ACTION_OPEN_MAP_TIP"] or "Open this zone on the World Map",
                    texture   = "Interface\\Icons\\icon_treasuremap",
                    onClick = function() 
                        f:Hide()
                        OpenWorldMap(mapID)
                    end,
                })
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
                    end
                    if entry then
                        table.insert(navStack, entry)
                        if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
                    end
                end
                f.selectedNPCSlug = nil
                f.selectedZoneMapID = mapID

                f.startPage:Hide()
                f.hintPage:Hide()
                f.tabLore:Hide()
                f.tabTime:Hide()
                f.detailModel:Hide()
                f.factionIcon:Hide()
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
                f.loreBody:SetText(IMAGO.TextLinker.LinkNames(warningHeader .. descText, nil, mapID, nil, nil))
                f.loreBody:SetJustifyH("CENTER")
                f.loreBody:Show()
                if f.loreSource then f.loreSource:Hide() end

                local imgLeft = (f.detailFrame:GetWidth() - 760) / 2
                f.infoScroll:ClearAllPoints()
                f.infoScroll:SetPoint("TOPLEFT", f.detailFrame, "TOPLEFT", imgLeft, -470)
                f.infoScroll:SetPoint("BOTTOMRIGHT", f.detailFrame, "BOTTOMLEFT", imgLeft + 760, 100)
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
    end
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
        end
        if entry then
            table.insert(navStack, entry)
            if IMAGO.Chronicle.SetBackEnabled then IMAGO.Chronicle.SetBackEnabled(true) end
        end
    end
    f.selectedZoneMapID = nil

    local data = IMAGO.GetNPCData(slug)
    if not data then return false end

    f.activeFilter = "ALL"
    if f.searchBox then f.searchBox:SetText("") end

    IMAGO.Chronicle.expandedCats = IMAGO.Chronicle.expandedCats or {}
    local cat = data.category or "CAT_ENIGMATIC"
    IMAGO.Chronicle.expandedCats[cat] = true

    if opts.skipDiscoveryCinematic then
        IMAGOSaved.viewedNPCs = IMAGOSaved.viewedNPCs or {}
        IMAGOSaved.viewedNPCs[slug] = true
    end

    f.selectedNPC = data
    f.selectedNPCSlug = slug

    IMAGO.Chronicle.SelectMainTab(1)
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
    IMAGO.Chronicle.SelectMainTab(2)
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
-- ============================================================
-- IMAGO — core/Display.lua
-- The cinematic title card: fade in, hold, fade out
-- ============================================================

IMAGO.Display = {}

-- Fonts resolve via IMAGO.FONT_TITLE / IMAGO.FONT_BODY at call time —
-- the saved titleFont is applied in Init, after saved vars load.
local FADE_IN_TIME = 0.6
local closeTimer = nil
local QUEUE_SHOW_DELAY = 0.3
local CARD_WIDTH = 560
local BODY_MAX_CHARS = 260

-- Pending discoveries: while a card is visible, further unlocks wait here
-- instead of overwriting the current card mid-fade.
IMAGO.Display.queue = IMAGO.Display.queue or {}

local COLORS = {
    zone      = {r=1,    g=0.82, b=0},
    instance  = {r=0.6,  g=0.8,  b=1},
    npc       = {r=1,    g=0.78, b=0.1},
    encounter = {r=1,    g=0.4,  b=0.2},
    race      = {r=0.65, g=0.55, b=1},
    class     = {r=0.78, g=0.51, b=0.18},
}

-- Glyph prefixes must be font-safe: the Classic client lacks ⚔/☠/❖/✦
-- and renders them as empty squares. Keep all labels empty.
local LABELS = {
    zone      = "",
    instance  = "",
    npc       = "",
    encounter = "",
    race      = "",
    class     = "",
}

local CARD_BACKDROP = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

-- Stone/dark background candidates, tried in order. GetTextureFilePath()
-- returns nil for files that do not resolve in this client, so the first
-- texture that actually exists wins. Last entry is guaranteed present.
local STONE_TEXTURES = {
    "Interface\\FrameGeneral\\UI-Background-Rock",
    "Interface\\FrameGeneral\\UI-Background-Marble",
    "Interface\\DialogFrame\\UI-DialogBox-Background",
    "Interface\\Tooltips\\UI-Tooltip-Background",
}

local function PickStoneTexture(tex)
    for _, path in ipairs(STONE_TEXTURES) do
        tex:SetTexture(path)
        if not tex.GetTextureFilePath then return end -- old API: keep first guess
        if tex:GetTextureFilePath() then return end
    end
end

local function ApplyBackdrop(f)
    local opaque = IMAGOSaved and IMAGOSaved.opaqueUI
    local bg = IMAGO_COLORS.BG_MAIN
    local border = IMAGO_COLORS.GOLD_MUTED
    f:SetBackdrop(CARD_BACKDROP)
    f:SetBackdropColor(bg[1], bg[2], bg[3], opaque and 1 or bg[4])
    f:SetBackdropBorderColor(border[1], border[2], border[3], 1.0)

    if not f.stoneTex then
        -- ARTWORK/-7: above the backdrop's NineSlice centre, below text/lines.
        f.stoneTex = f:CreateTexture(nil, "ARTWORK", nil, -7)
        f.stoneTex:SetPoint("TOPLEFT", f, "TOPLEFT", 3, -3)
        f.stoneTex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -3, 3)
        f.stoneTex:SetHorizTile(true)
        f.stoneTex:SetVertTile(true)
    end
    -- Texture + tint may come from the active theme.
    local theme = IMAGO.ACTIVE_THEME
    if theme and theme.stoneTex then
        f.stoneTex:SetTexture(theme.stoneTex)
    else
        PickStoneTexture(f.stoneTex)
    end
    local tint = (theme and theme.stoneTint) or { 0.62, 0.62, 0.67, 0.85 }
    f.stoneTex:SetVertexColor(tint[1], tint[2], tint[3], tint[4])
end

local function countKeys(t)
    if type(t) ~= "table" then return 0 end
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

local function TruncateBody(text)
    if type(text) ~= "string" then return "" end
    if #text <= BODY_MAX_CHARS then return text end
    local cut = text:sub(1, BODY_MAX_CHARS)
    -- Prefer ending on a sentence boundary, fall back to a word boundary.
    local sentenceEnd = cut:match("^.*()[%.%!%?]%s")
    local wordEnd = cut:match("^.*()%s")
    if sentenceEnd and sentenceEnd > BODY_MAX_CHARS * 0.4 then
        -- Ends on sentence punctuation: drop it so we get "…" not ".…"
        cut = cut:sub(1, sentenceEnd - 1)
    elseif wordEnd and wordEnd > BODY_MAX_CHARS * 0.5 then
        cut = cut:sub(1, wordEnd - 1)
    end
    -- |r closes any colour escape the cut may have left open.
    return cut .. "…|r"
end

-- "Read more" targets per category (Chronicle openers).
local OPEN_HANDLERS = {
    npc  = function(refID) return IMAGO.Chronicle.OpenToNPCSlug(refID) end,
    race = function(refID) return IMAGO.Chronicle.OpenToRace(refID) end,
    class = function(refID) return IMAGO.Chronicle.OpenToClass(refID) end,
    zone = function(refID) return IMAGO.Chronicle.OpenToZoneMapID(refID) end,
}

local function UpdateQueueCounter(f)
    if not f.queueCount then return end
    local n = #IMAGO.Display.queue
    if n > 0 then
        f.queueCount:SetFormattedText((IMAGO.L and IMAGO.L["QUEUE_MORE"]) or "+%d more", n)
        f.queueCount:Show()
    else
        f.queueCount:Hide()
    end
end

local function ShowNextFromQueue()
    local f = IMAGO.Display.frame
    local entry = table.remove(IMAGO.Display.queue, 1)
    if not entry or not f or not IMAGOSaved or not IMAGOSaved.enabled then return end
    if f:IsShown() then
        -- Should not happen, but never drop a discovery: requeue it.
        table.insert(IMAGO.Display.queue, 1, entry)
        return
    end
    IMAGO.Display.Show(entry.title, entry.body, entry.category, entry.isNew, entry.refID)
end

local function EnqueueDiscovery(f, title, bodyText, category, isNew, refID)
    -- Dedupe: skip if already queued or currently shown.
    if f._current and f._current.category == category and f._current.refID == refID then return end
    for _, e in ipairs(IMAGO.Display.queue) do
        if e.category == category and e.refID == refID then return end
    end
    table.insert(IMAGO.Display.queue, {
        title = title, body = bodyText, category = category,
        isNew = isNew, refID = refID,
    })
    UpdateQueueCounter(f)
end

function IMAGO.GetProgress(type)
    if not IMAGOSaved or not IMAGOdb then return 0, 0 end

    local savedTable, dbTable
    if type == "npc" then
        savedTable = IMAGOSaved.seenNPCs
        -- NPCs are now categorized - count across all categories
        local totalNPCs = 0
        for _, category in pairs(IMAGOdb.npcs or {}) do
            for _ in pairs(category) do
                totalNPCs = totalNPCs + 1
            end
        end
        local seen = 0
        for slug, v in pairs(savedTable or {}) do
            if v and IMAGO.GetNPCData(slug) then seen = seen + 1 end
        end
        return seen, totalNPCs
    elseif type == "zone" then
        savedTable = IMAGOSaved.seenZones
        dbTable = IMAGOdb.zones
        if not savedTable or not dbTable then return 0, 0 end
        local seen = 0
        for key, v in pairs(savedTable) do
            if v and dbTable[key] then seen = seen + 1 end
        end
        return seen, countKeys(dbTable)
    elseif type == "race" then
        savedTable = IMAGOSaved.seenRaces
        dbTable = IMAGOdb.races
        if not savedTable or not dbTable then return 0, 0 end
        local seen = 0
        for key, v in pairs(savedTable) do
            if v and dbTable[key] then seen = seen + 1 end
        end
        return seen, countKeys(dbTable)
    elseif type == "class" then
        savedTable = IMAGOSaved.seenClasses
        dbTable = IMAGOdb.classes
        if not savedTable or not dbTable then return 0, 0 end
        local seen = 0
        for key, v in pairs(savedTable) do
            if v and dbTable[key] then seen = seen + 1 end
        end
        return seen, countKeys(dbTable)
    else
        return 0, 0
    end
end

local function RegisterLoreFrameForEscapeDismiss(frame)
    local name = frame:GetName()
    if not name then return end
    for i = 1, #UISpecialFrames do
        if UISpecialFrames[i] == name then return end
    end
    tinsert(UISpecialFrames, name)
end

function IMAGO.Display.HideLorePanel()
    if closeTimer then closeTimer:Cancel(); closeTimer = nil end
    local f = IMAGO.Display.frame
    if not f then return end
    if f.animFadeIn then f.animFadeIn:Stop() end
    UIFrameFadeRemoveFrame(f)
    f:SetAlpha(1)
    f:Hide()
    f.trackingNPC = nil -- Clear break contact tracking
    f._current = nil
end

function IMAGO.Display.CheckBreakContact()
    local f = IMAGO.Display.frame
    if not f or not f:IsShown() or not f.trackingNPC then return end

    local x, y, mapID = UnitPosition("player")
    if not x or not y or not mapID then return end

    -- Check if map changed (teleport, instance change, etc.)
    if mapID ~= f.trackingNPC.mapID then
        IMAGO.Display.HideLorePanel()
        return
    end

    -- Calculate distance
    local dx = x - f.trackingNPC.startX
    local dy = y - f.trackingNPC.startY
    local distance = math.sqrt(dx * dx + dy * dy)

    local threshold = IMAGOSaved.breakContactDistance or 50
    if distance >= threshold then
        IMAGO.Display.HideLorePanel()
        return
    end

    -- Continue checking
    C_Timer.After(0.5, function()
        IMAGO.Display.CheckBreakContact()
    end)
end

local function attachProgressFontString(f)
    if f.progressText then return end

    -- Warmer, richer brown so the button stands out from the stone backdrop.
    local BTN_BG     = { 0.26, 0.18, 0.09, 1.00 }
    local BTN_HOVER  = { 0.34, 0.24, 0.12, 1.00 }
    local BORDER     = IMAGO_COLORS.BORDER
    local GOLD       = IMAGO_COLORS.GOLD
    local GOLD_MUTED = IMAGO_COLORS.GOLD_MUTED
    local GOLD_BRT   = IMAGO_COLORS.GOLD_BRIGHT

    -- Read more button (opens the entry in the Chronicle), theme-styled.
    f.readMore = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.readMore:SetSize(150, 26)
    f.readMore:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    f.readMore:SetBackdropColor(BTN_BG[1], BTN_BG[2], BTN_BG[3], BTN_BG[4])
    f.readMore:SetBackdropBorderColor(GOLD_MUTED[1], GOLD_MUTED[2], GOLD_MUTED[3], 0.9)

    f.readMore.label = f.readMore:CreateFontString(nil, "OVERLAY")
    f.readMore.label:SetFont(IMAGO.FONT_BODY, 12, "")
    f.readMore.label:SetPoint("CENTER", 0, 0)
    f.readMore.label:SetTextColor(GOLD_BRT[1], GOLD_BRT[2], GOLD_BRT[3])
    f.readMore.label:SetText((IMAGO.L and IMAGO.L["READ_MORE"]) or "Read more")

    f.readMore:SetScript("OnEnter", function(self)
        self:SetBackdropColor(BTN_HOVER[1], BTN_HOVER[2], BTN_HOVER[3], BTN_HOVER[4])
        self:SetBackdropBorderColor(GOLD[1], GOLD[2], GOLD[3], 1)
    end)
    f.readMore:SetScript("OnLeave", function(self)
        self:SetBackdropColor(BTN_BG[1], BTN_BG[2], BTN_BG[3], BTN_BG[4])
        self:SetBackdropBorderColor(GOLD_MUTED[1], GOLD_MUTED[2], GOLD_MUTED[3], 0.9)
    end)
    f.readMore:SetScript("OnClick", function()
        local cur = f._current
        IMAGO.Display.HideLorePanel()
        if cur and OPEN_HANDLERS[cur.category] and cur.refID ~= nil then
            OPEN_HANDLERS[cur.category](cur.refID)
        end
    end)
    f.readMore:Hide()

    -- Symmetric fading divider above the progress row.
    f.progressDividerL = f:CreateTexture(nil, "ARTWORK")
    f.progressDividerL:SetSize(150, 1)
    f.progressDividerL:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.progressDividerL:SetGradient("HORIZONTAL",
        CreateColor(GOLD[1], GOLD[2], GOLD[3], 0),
        CreateColor(GOLD[1], GOLD[2], GOLD[3], 0.5))
    f.progressDividerL:Hide()

    f.progressDividerR = f:CreateTexture(nil, "ARTWORK")
    f.progressDividerR:SetSize(150, 1)
    f.progressDividerR:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.progressDividerR:SetGradient("HORIZONTAL",
        CreateColor(GOLD[1], GOLD[2], GOLD[3], 0.5),
        CreateColor(GOLD[1], GOLD[2], GOLD[3], 0))
    f.progressDividerR:Hide()

    -- Progress bar styled like the Chronicle footer: framed, ticked, gold fill.
    local BAR_W = 400
    f.progressBar = CreateFrame("StatusBar", nil, f)
    f.progressBar:SetSize(BAR_W, 10)
    f.progressBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    f.progressBar:GetStatusBarTexture():SetColorTexture(GOLD[1], GOLD[2], GOLD[3], 0.7)
    f.progressBar:SetMinMaxValues(0, 100)
    f.progressBar:SetValue(0)

    f.progressBar.bg = f.progressBar:CreateTexture(nil, "BACKGROUND")
    f.progressBar.bg:SetAllPoints()
    local bgR = IMAGO_COLORS.BG_RAISED
    f.progressBar.bg:SetColorTexture(bgR[1], bgR[2], bgR[3], 0.9)

    for i = 1, 9 do
        local tick = f.progressBar:CreateTexture(nil, "OVERLAY")
        tick:SetColorTexture(0, 0, 0, 0.9)
        tick:SetSize(2, 10)
        tick:SetPoint("LEFT", f.progressBar, "LEFT", BAR_W * (i / 10), 0)
    end

    f.progressBar.border = CreateFrame("Frame", nil, f.progressBar, "BackdropTemplate")
    f.progressBar.border:SetPoint("TOPLEFT", f.progressBar, "TOPLEFT", -3, 3)
    f.progressBar.border:SetPoint("BOTTOMRIGHT", f.progressBar, "BOTTOMRIGHT", 3, -3)
    f.progressBar.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    f.progressBar.border:SetBackdropBorderColor(GOLD[1], GOLD[2], GOLD[3], 0.5)

    f.progressBar:Hide()

    f.progressText = f:CreateFontString(nil, "OVERLAY")
    f.progressText:SetFont(IMAGO.FONT_BODY, 11, "")
    f.progressText:SetWidth(520)
    f.progressText:SetJustifyH("CENTER")
    f.progressText:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
    f.progressText:SetShadowColor(0, 0, 0, 1)
    f.progressText:SetShadowOffset(1, -1)
    f.progressText:Hide()

    -- "+n" counter for queued discoveries
    f.queueCount = f:CreateFontString(nil, "OVERLAY")
    f.queueCount:SetFont(IMAGO.FONT_BODY, 11, "")
    f.queueCount:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -12, 10)
    f.queueCount:SetJustifyH("RIGHT")
    f.queueCount:SetTextColor(GOLD[1], GOLD[2], GOLD[3], 0.9)
    f.queueCount:SetShadowColor(0, 0, 0, 1)
    f.queueCount:SetShadowOffset(1, -1)
    f.queueCount:Hide()
end

function IMAGO.Display.CreateFrame()
    if IMAGO.Display.frame then
        attachProgressFontString(IMAGO.Display.frame)
        return
    end

    local f = CreateFrame("Frame", "IMAGODisplayFrame", UIParent, "BackdropTemplate")
    f:SetSize(CARD_WIDTH, 115)

    if IMAGOSaved.framePoint then
        f:SetPoint(IMAGOSaved.framePoint, UIParent, IMAGOSaved.frameRelative, IMAGOSaved.frameX, IMAGOSaved.frameY)
    else
        f:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 180)
    end

    f:SetScale(IMAGOSaved.frameScale or 1.0)
    f:SetFrameStrata("HIGH")
    f:SetAlpha(0)
    f:Hide()

    ApplyBackdrop(f)

    f.newBadge = f:CreateFontString(nil, "OVERLAY")
    f.newBadge:SetFont(IMAGO.FONT_TITLE, 13, "OUTLINE")
    f.newBadge:SetPoint("TOP", f, "TOP", 0, -6)
    f.newBadge:SetTextColor(IMAGO_COLORS.GOLD_BRIGHT[1], IMAGO_COLORS.GOLD_BRIGHT[2], IMAGO_COLORS.GOLD_BRIGHT[3])
    f.newBadge:SetShadowColor(0, 0, 0, 1)
    f.newBadge:SetShadowOffset(1, -1)
    f.newBadge:SetText(GetLocale() == "deDE" and "* NEU *" or "* NEW *")
    f.newBadge:Hide()

    f.lineTopLeft = f:CreateTexture(nil, "ARTWORK")
    f.lineTopLeft:SetSize(240, 1)
    f.lineTopLeft:SetPoint("TOPRIGHT", f, "TOP", 0, -12)
    f.lineTopLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

    f.lineTopRight = f:CreateTexture(nil, "ARTWORK")
    f.lineTopRight:SetSize(240, 1)
    f.lineTopRight:SetPoint("TOPLEFT", f, "TOP", 0, -12)
    f.lineTopRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

    f.lineBottomLeft = f:CreateTexture(nil, "ARTWORK")
    f.lineBottomLeft:SetSize(240, 1)
    f.lineBottomLeft:SetPoint("BOTTOMRIGHT", f, "BOTTOM", 0, 12)
    f.lineBottomLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

    f.lineBottomRight = f:CreateTexture(nil, "ARTWORK")
    f.lineBottomRight:SetSize(240, 1)
    f.lineBottomRight:SetPoint("BOTTOMLEFT", f, "BOTTOM", 0, 12)
    f.lineBottomRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

    f.title = f:CreateFontString(nil, "OVERLAY")
    f.title:SetFont(IMAGO.FONT_TITLE, 24, "OUTLINE") 
    f.title:SetPoint("TOP", f, "TOP", 0, -18)
    f.title:SetWidth(CARD_WIDTH - 40)
    f.title:SetShadowColor(0, 0, 0, 1)
    f.title:SetShadowOffset(1, -1)
    f.title:SetJustifyH("CENTER")

    f.body = f:CreateFontString(nil, "OVERLAY")
    f.body:SetFont(IMAGO.FONT_BODY, 13, "")
    f.body:SetPoint("TOP", f.title, "BOTTOM", 0, -10)
    f.body:SetWidth(CARD_WIDTH - 56)
    f.body:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3], 0.95)
    f.body:SetShadowColor(0, 0, 0, 1)
    f.body:SetShadowOffset(1, -1)
    f.body:SetJustifyH("LEFT")
    f.body:SetWordWrap(true)
    f.body:SetSpacing(3)

    attachProgressFontString(f)

    -- No UIPanelCloseButtonTemplate: not available as an inherit in some clients.
    f.closeButton = CreateFrame("Button", nil, f)
    f.closeButton:SetSize(28, 28)
    f.closeButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)
    f.closeButton:RegisterForClicks("LeftButtonUp")

    local closeIcon = f.closeButton:CreateFontString(nil, "OVERLAY")
    closeIcon:SetFont(IMAGO.FONT_BODY, 22, "OUTLINE")
    closeIcon:SetText("×")
    closeIcon:SetPoint("CENTER", 0, 0)
    closeIcon:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.75)
    f.closeButton.closeIcon = closeIcon

    f.closeButton:SetScript("OnEnter", function(self)
        if self.closeIcon then self.closeIcon:SetTextColor(IMAGO_COLORS.DANGER[1], IMAGO_COLORS.DANGER[2], IMAGO_COLORS.DANGER[3], 1) end
    end)
    f.closeButton:SetScript("OnLeave", function(self)
        if self.closeIcon then self.closeIcon:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.75) end
    end)
    f.closeButton:SetScript("OnClick", function()
        IMAGO.Display.HideLorePanel()
    end)

    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        IMAGOSaved.framePoint = point
        IMAGOSaved.frameRelative = relativePoint
        IMAGOSaved.frameX = xOfs
        IMAGOSaved.frameY = yOfs
    end)

    -- right click to close
    f:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            self._mouseDownX, self._mouseDownY = GetCursorPosition()
        end
    end)
    f:SetScript("OnMouseUp", function(self, button)
        if button ~= "RightButton" then return end
        if self._dragging then return end
        if GetMouseFocus and GetMouseFocus() ~= self then return end
        if not self._mouseDownX then return end

        local x, y = GetCursorPosition()
        local dx = math.abs(x - self._mouseDownX)
        local dy = math.abs(y - self._mouseDownY)
        self._mouseDownX, self._mouseDownY = nil, nil

        if dx < 6 and dy < 6 then
            IMAGO.Display.HideLorePanel()
        end
    end)

    -- Any hide (X, right click, ESC, auto-timer, break contact) advances the queue.
    f:SetScript("OnHide", function()
        if #IMAGO.Display.queue > 0 then
            C_Timer.After(QUEUE_SHOW_DELAY, ShowNextFromQueue)
        end
    end)

    RegisterLoreFrameForEscapeDismiss(f)

    IMAGO.Display.frame = f
end

function IMAGO.Display.Show(title, bodyText, category, isNew, refID)
    if not IMAGOSaved.enabled then return end
    if not IMAGO.Display.frame then return end

    local f = IMAGO.Display.frame
    attachProgressFontString(f)

    -- Card already visible? Queue this discovery instead of overwriting it.
    if f:IsShown() then
        EnqueueDiscovery(f, title, bodyText, category, isNew, refID)
        return
    end

    f._current = { category = category, refID = refID }

    ApplyBackdrop(f)
    local color = COLORS[category] or COLORS.zone
    local label = LABELS[category] or ""

    if not f.animFadeIn then
        f.animFadeIn = f:CreateAnimationGroup()
        local fadeIn = f.animFadeIn:CreateAnimation("Alpha")
        fadeIn:SetOrder(1)
        fadeIn:SetFromAlpha(0)
        fadeIn:SetToAlpha(1)
        fadeIn:SetDuration(FADE_IN_TIME)
        f.animFadeIn:SetScript("OnFinished", function()
            f:SetAlpha(1)
        end)
    end

    f.animFadeIn:Stop()
    UIFrameFadeRemoveFrame(f)

    f.title:ClearAllPoints()
    if isNew then
        f.newBadge:Show()
        f.title:SetPoint("TOP", f, "TOP", 0, -22)
    else
        f.newBadge:Hide()
        f.title:SetPoint("TOP", f, "TOP", 0, -18)
    end

    f.title:SetText(label .. title)
    f.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])

    f.lineTopLeft:SetGradient("HORIZONTAL", CreateColor(color.r, color.g, color.b, 0), CreateColor(color.r, color.g, color.b, 0.6))
    f.lineTopRight:SetGradient("HORIZONTAL", CreateColor(color.r, color.g, color.b, 0.6), CreateColor(color.r, color.g, color.b, 0))
    f.lineBottomLeft:SetGradient("HORIZONTAL", CreateColor(color.r, color.g, color.b, 0), CreateColor(color.r, color.g, color.b, 0.6))
    f.lineBottomRight:SetGradient("HORIZONTAL", CreateColor(color.r, color.g, color.b, 0.6), CreateColor(color.r, color.g, color.b, 0))

    f.body:SetText(TruncateBody(bodyText))

    -- Read more: only for categories that can open a Chronicle entry
    if OPEN_HANDLERS[category] and refID ~= nil then
        f.readMore.label:SetText((IMAGO.L and IMAGO.L["READ_MORE"]) or "Read more")
        f.readMore:Show()
    else
        f.readMore:Hide()
    end

    -- Break Contact: Track NPC position for distance check
    f.trackingNPC = nil
    if category == "npc" and refID and IMAGOSaved.enableBreakContact ~= false then
        local x, y, mapID = UnitPosition("player")
        if x and y and mapID then
            f.trackingNPC = {
                slug = refID,
                startX = x,
                startY = y,
                mapID = mapID,
                startTime = GetTime()
            }
            -- Start distance check timer
            C_Timer.After(0.5, function()
                IMAGO.Display.CheckBreakContact()
            end)
        end
    end

    -- Anchor chain: body -> readMore -> progressBar -> progressText
    local prev = f.body
    local chainHeight = 0

    if f.readMore:IsShown() then
        f.readMore:ClearAllPoints()
        f.readMore:SetPoint("TOP", prev, "BOTTOM", 0, -14)
        prev = f.readMore
        chainHeight = chainHeight + 14 + 26
    end

    local hasProgress = (category == "npc" or category == "zone" or category == "race" or category == "class")
    if hasProgress then
        local seen, total = IMAGO.GetProgress(category)
        local perc = (total > 0) and math.floor((seen / total) * 100 + 0.5) or 0
        local localeKey = (category == "npc") and "DISPLAY_PROGRESS_NPC"
            or (category == "race") and "DISPLAY_PROGRESS_RACE"
            or (category == "class") and "DISPLAY_PROGRESS_CLASS"
            or "DISPLAY_PROGRESS_ZONE"
        local defaultText = (category == "npc") and "Fortschritt: %d%% (%d/%d NPCs)"
            or (category == "race") and "Fortschritt: %d%% (%d/%d Völker)"
            or (category == "class") and "Fortschritt: %d%% (%d/%d Klassen)"
            or "Fortschritt: %d%% (%d/%d Zonen)"

        f.progressDividerL:ClearAllPoints()
        f.progressDividerL:SetPoint("TOP", prev, "BOTTOM", -75, -14)
        f.progressDividerL:Show()
        f.progressDividerR:ClearAllPoints()
        f.progressDividerR:SetPoint("TOP", prev, "BOTTOM", 75, -14)
        f.progressDividerR:Show()

        f.progressBar:ClearAllPoints()
        f.progressBar:SetPoint("TOP", prev, "BOTTOM", 0, -22)
        f.progressBar:SetMinMaxValues(0, math.max(1, total))
        f.progressBar:SetValue(seen)
        f.progressBar:Show()

        f.progressText:ClearAllPoints()
        f.progressText:SetPoint("TOP", f.progressBar, "BOTTOM", 0, -4)
        f.progressText:SetText(string.format(
            IMAGO.L[localeKey] or defaultText,
            perc, seen, total
        ))
        f.progressText:Show()

        chainHeight = chainHeight + 22 + 10 + 4 + f.progressText:GetStringHeight()
    else
        f.progressText:SetText("")
        f.progressText:Hide()
        f.progressBar:Hide()
        f.progressDividerL:Hide()
        f.progressDividerR:Hide()
    end

    local titleHeight = f.title:GetStringHeight()
    local bodyHeight = f.body:GetStringHeight()
    local paddingTop, spacing, paddingBottom = (isNew and 24 or 18), 10, 18
    local totalHeight = paddingTop + titleHeight + spacing + bodyHeight + chainHeight + paddingBottom
    f:SetHeight(math.max(115, totalHeight))

    UpdateQueueCounter(f)

    -- Timer logic for automatic closing
    if closeTimer then closeTimer:Cancel(); closeTimer = nil end
    if not IMAGOSaved.noMainLoreTimerClose then
        closeTimer = C_Timer.After(30, function()
            IMAGO.Display.HideLorePanel()
        end)
    end

    f:SetAlpha(0)
    f:Show()
    f.animFadeIn:Play()
end

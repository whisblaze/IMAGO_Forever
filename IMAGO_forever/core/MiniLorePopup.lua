IMAGO.UI = IMAGO.UI or {}

-- Fonts resolve via IMAGO.FONT_TITLE / IMAGO.FONT_BODY at call time —
-- the saved titleFont is applied in Init, after saved vars load.
local FADE_IN_SECONDS = 0.25
local SNIPPET_AUTO_HIDE_SECONDS = 15
local SNIPPET_FADE_OUT_SECONDS = 0.6

local CARD_BACKDROP = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

-- Stone/dark background candidates, tried in order. Same set as the
-- discovery card so both popups share the anthracite look.
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

local function CancelSnippetTimers(f)
    if f._snippetAutoHideTimer then
        f._snippetAutoHideTimer:Cancel()
        f._snippetAutoHideTimer = nil
    end
    if f._snippetHideAfterFadeTimer then
        f._snippetHideAfterFadeTimer:Cancel()
        f._snippetHideAfterFadeTimer = nil
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
        f.stoneTex = f:CreateTexture(nil, "ARTWORK", nil, -7)
        f.stoneTex:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -4)
        f.stoneTex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
        f.stoneTex:SetHorizTile(true)
        f.stoneTex:SetVertTile(true)
    end
    local theme = IMAGO.ACTIVE_THEME
    if theme and theme.stoneTex then
        f.stoneTex:SetTexture(theme.stoneTex)
    else
        PickStoneTexture(f.stoneTex)
    end
    local tint = (theme and theme.stoneTint) or { 0.62, 0.62, 0.67, 0.85 }
    f.stoneTex:SetVertexColor(tint[1], tint[2], tint[3], tint[4])
end

local function RegisterForEscapeDismiss(frame)
    local name = frame:GetName()
    if not name then return end
    for i = 1, #UISpecialFrames do
        if UISpecialFrames[i] == name then return end
    end
    tinsert(UISpecialFrames, name)
end

function IMAGO.UI.HideSnippetPopup()
    local f = IMAGO.UI.MiniLorePopup
    if not f then return end
    CancelSnippetTimers(f)
    UIFrameFadeRemoveFrame(f)
    f:SetAlpha(1)
    f:Hide()
end

local function CreateMiniLorePopupFrame()
    if IMAGO.UI.MiniLorePopup then return IMAGO.UI.MiniLorePopup end

    local f = CreateFrame("Frame", "IMAGOMiniLorePopup", UIParent, "BackdropTemplate")
    f:SetSize(560, 110)

    if IMAGOSaved and IMAGOSaved.snippetPopupPoint then
        f:SetPoint(IMAGOSaved.snippetPopupPoint, UIParent, IMAGOSaved.snippetPopupRelative, IMAGOSaved.snippetPopupX, IMAGOSaved.snippetPopupY)
    else
        f:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 240)
    end

    f:SetFrameStrata("HIGH")
    f:SetAlpha(0)
    f:Hide()

    ApplyBackdrop(f)

    f.lineTopLeft = f:CreateTexture(nil, "ARTWORK")
    f.lineTopLeft:SetSize(240, 1)
    f.lineTopLeft:SetPoint("TOPRIGHT", f, "TOP", 0, -12)
    f.lineTopLeft:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.lineTopLeft:SetGradient("HORIZONTAL", CreateColor(1, 0.78, 0.1, 0), CreateColor(1, 0.78, 0.1, 0.6))

    f.lineTopRight = f:CreateTexture(nil, "ARTWORK")
    f.lineTopRight:SetSize(240, 1)
    f.lineTopRight:SetPoint("TOPLEFT", f, "TOP", 0, -12)
    f.lineTopRight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    f.lineTopRight:SetGradient("HORIZONTAL", CreateColor(1, 0.78, 0.1, 0.6), CreateColor(1, 0.78, 0.1, 0))

    f.title = f:CreateFontString(nil, "OVERLAY")
    f.title:SetFont(IMAGO.FONT_TITLE, 18, "OUTLINE")
    f.title:SetPoint("TOP", f, "TOP", 0, -16)
    f.title:SetTextColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3])
    f.title:SetShadowColor(0, 0, 0, 1)
    f.title:SetShadowOffset(1, -1)
    f.title:SetJustifyH("CENTER")

    f.body = f:CreateFontString(nil, "OVERLAY")
    f.body:SetFont(IMAGO.FONT_BODY, 13, "")
    f.body:SetPoint("TOP", f.title, "BOTTOM", 0, -8)
    f.body:SetWidth(504)
    f.body:SetTextColor(IMAGO_COLORS.TEXT_PRIMARY[1], IMAGO_COLORS.TEXT_PRIMARY[2], IMAGO_COLORS.TEXT_PRIMARY[3], 0.95)
    f.body:SetShadowColor(0, 0, 0, 1)
    f.body:SetShadowOffset(1, -1)
    f.body:SetJustifyH("CENTER")
    f.body:SetWordWrap(true)
    f.body:SetSpacing(3)

    -- Same brown/gold button style as the discovery card's "Read more".
    local BTN_BG     = { 0.26, 0.18, 0.09, 1.00 }
    local BTN_HOVER  = { 0.34, 0.24, 0.12, 1.00 }
    local GOLD       = IMAGO_COLORS.GOLD
    local GOLD_MUTED = IMAGO_COLORS.GOLD_MUTED
    local GOLD_BRT   = IMAGO_COLORS.GOLD_BRIGHT

    f.nextButton = CreateFrame("Button", nil, f, "BackdropTemplate")
    f.nextButton:SetSize(140, 24)
    f.nextButton:SetPoint("BOTTOM", f, "BOTTOM", 0, 12)
    f.nextButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    f.nextButton:SetBackdropColor(BTN_BG[1], BTN_BG[2], BTN_BG[3], BTN_BG[4])
    f.nextButton:SetBackdropBorderColor(GOLD_MUTED[1], GOLD_MUTED[2], GOLD_MUTED[3], 0.9)

    f.nextButton.label = f.nextButton:CreateFontString(nil, "OVERLAY")
    f.nextButton.label:SetFont(IMAGO.FONT_BODY, 12, "")
    f.nextButton.label:SetPoint("CENTER", 0, 0)
    f.nextButton.label:SetTextColor(GOLD_BRT[1], GOLD_BRT[2], GOLD_BRT[3])
    f.nextButton.label:SetText((IMAGO.L and IMAGO.L["NEXT"]) or "Next")

    f.nextButton:SetScript("OnEnter", function(self)
        self:SetBackdropColor(BTN_HOVER[1], BTN_HOVER[2], BTN_HOVER[3], BTN_HOVER[4])
        self:SetBackdropBorderColor(GOLD[1], GOLD[2], GOLD[3], 1)
    end)
    f.nextButton:SetScript("OnLeave", function(self)
        self:SetBackdropColor(BTN_BG[1], BTN_BG[2], BTN_BG[3], BTN_BG[4])
        self:SetBackdropBorderColor(GOLD_MUTED[1], GOLD_MUTED[2], GOLD_MUTED[3], 0.9)
    end)
    f.nextButton:SetScript("OnClick", function()
        if IMAGO.Snippets and IMAGO.Snippets.ShowRandom then
            IMAGO.Snippets.ShowRandom(true)
        end
    end)

    f.closeButton = CreateFrame("Button", nil, f)
    f.closeButton:SetSize(24, 24)
    f.closeButton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)
    f.closeButton:RegisterForClicks("LeftButtonUp")

    local closeIcon = f.closeButton:CreateFontString(nil, "OVERLAY")
    closeIcon:SetFont(IMAGO.FONT_BODY, 20, "OUTLINE")
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
        IMAGO.UI.HideSnippetPopup()
    end)

    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        self._dragging = true
        self:StartMoving()
    end)
    f:SetScript("OnDragStop", function(self)
        self._dragging = nil
        self:StopMovingOrSizing()
        local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
        if IMAGOSaved then
            IMAGOSaved.snippetPopupPoint = point
            IMAGOSaved.snippetPopupRelative = relativePoint
            IMAGOSaved.snippetPopupX = xOfs
            IMAGOSaved.snippetPopupY = yOfs
        end
    end)

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
            IMAGO.UI.HideSnippetPopup()
        end
    end)

    f:SetScript("OnHide", function(self)
        CancelSnippetTimers(self)
        UIFrameFadeRemoveFrame(self)
        self:SetAlpha(1)
        self._mouseDownX, self._mouseDownY = nil, nil
        self._dragging = nil
    end)

    RegisterForEscapeDismiss(f)

    IMAGO.UI.MiniLorePopup = f
    return f
end

function IMAGO.UI.ShowSnippetPopup(text, categoryKey)
    if type(text) ~= "string" or text == "" then return end

    local f = CreateMiniLorePopupFrame()
    CancelSnippetTimers(f)
    UIFrameFadeRemoveFrame(f)

    ApplyBackdrop(f)

    local title = (IMAGO.L and categoryKey and IMAGO.L[categoryKey]) or (categoryKey or "IMAGO")
    f.title:SetText(title)
    f.body:SetText(text)
    f.nextButton.label:SetText((IMAGO.L and IMAGO.L["NEXT"]) or "Next")

    local titleHeight = f.title:GetStringHeight()
    local bodyHeight = f.body:GetStringHeight()
    local buttonHeight = f.nextButton:GetHeight()
    local totalHeight = 18 + titleHeight + 8 + bodyHeight + 14 + buttonHeight + 14
    f:SetHeight(math.max(110, totalHeight))

    f:SetAlpha(0)
    f:Show()
    UIFrameFadeIn(f, FADE_IN_SECONDS, 0, 1)

    if IMAGOSaved and IMAGOSaved.keepSnippetOpen then return end

    f._snippetToken = (f._snippetToken or 0) + 1
    local token = f._snippetToken
    f._snippetAutoHideTimer = C_Timer.NewTimer(SNIPPET_AUTO_HIDE_SECONDS, function()
        if not f:IsShown() or f._snippetToken ~= token then return end
        UIFrameFadeOut(f, SNIPPET_FADE_OUT_SECONDS, f:GetAlpha(), 0)
        f._snippetHideAfterFadeTimer = C_Timer.NewTimer(SNIPPET_FADE_OUT_SECONDS, function()
            if f:IsShown() and f._snippetToken == token then
                IMAGO.UI.HideSnippetPopup()
            end
        end)
    end)
end

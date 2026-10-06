IMAGO.UI = IMAGO.UI or {}

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
local FADE_IN_SECONDS = 0.25
local SNIPPET_AUTO_HIDE_SECONDS = 15
local SNIPPET_FADE_OUT_SECONDS = 0.6

local BACKDROP_DEFAULT = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

local BACKDROP_OPAQUE = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

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

local function ApplyBackdrop(f, alpha)
    local opaque = IMAGOSaved and IMAGOSaved.opaqueUI
    f:SetBackdrop(opaque and BACKDROP_OPAQUE or BACKDROP_DEFAULT)
    f:SetBackdropColor(0.05, 0.05, 0.05, opaque and 1.0 or alpha)
    f:SetBackdropBorderColor(1, 0.78, 0.1, 0.9)
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
    f:SetSize(520, 110)

    if IMAGOSaved and IMAGOSaved.snippetPopupPoint then
        f:SetPoint(IMAGOSaved.snippetPopupPoint, UIParent, IMAGOSaved.snippetPopupRelative, IMAGOSaved.snippetPopupX, IMAGOSaved.snippetPopupY)
    else
        f:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 240)
    end

    f:SetFrameStrata("HIGH")
    f:SetAlpha(0)
    f:Hide()

    ApplyBackdrop(f, 0.82)

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
    f.title:SetFont(FONT_TITLE, 18, "OUTLINE")
    f.title:SetPoint("TOP", f, "TOP", 0, -16)
    f.title:SetTextColor(1, 0.78, 0.1, 0.95)
    f.title:SetShadowColor(0, 0, 0, 1)
    f.title:SetShadowOffset(1, -1)
    f.title:SetJustifyH("CENTER")

    f.body = f:CreateFontString(nil, "OVERLAY")
    f.body:SetFont(FONT_BODY, 13, "")
    f.body:SetPoint("TOP", f.title, "BOTTOM", 0, -8)
    f.body:SetWidth(480)
    f.body:SetTextColor(0.95, 0.95, 0.95, 0.95)
    f.body:SetShadowColor(0, 0, 0, 1)
    f.body:SetShadowOffset(1, -1)
    f.body:SetJustifyH("CENTER")
    f.body:SetWordWrap(true)
    f.body:SetSpacing(3)

    f.nextButton = CreateFrame("Button", nil, f, "UIMenuButtonStretchTemplate")
    f.nextButton:SetSize(120, 22)
    f.nextButton:SetPoint("BOTTOM", f, "BOTTOM", 0, 12)
    f.nextButton:SetText((IMAGO.L and IMAGO.L["NEXT"]) or "Next")
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
    closeIcon:SetFont(FONT_TITLE, 20, "OUTLINE")
    closeIcon:SetText("×")
    closeIcon:SetPoint("CENTER", 0, 0)
    closeIcon:SetTextColor(1, 0.78, 0.1, 0.75)
    f.closeButton.closeIcon = closeIcon

    f.closeButton:SetScript("OnEnter", function(self)
        if self.closeIcon then self.closeIcon:SetTextColor(1, 0.25, 0.25, 1) end
    end)
    f.closeButton:SetScript("OnLeave", function(self)
        if self.closeIcon then self.closeIcon:SetTextColor(1, 0.78, 0.1, 0.75) end
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

    ApplyBackdrop(f, 0.82)

    local title = (IMAGO.L and categoryKey and IMAGO.L[categoryKey]) or (categoryKey or "IMAGO")
    f.title:SetText(title)
    f.body:SetText(text)
    f.nextButton:SetText((IMAGO.L and IMAGO.L["NEXT"]) or "Next")

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

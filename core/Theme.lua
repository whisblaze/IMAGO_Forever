-- ============================================================
-- IMAGO — core/Theme.lua
-- Obsidian & Antique Gold Design System
-- ============================================================

IMAGO_COLORS = {
    -- Backgrounds
    BG_MAIN     = { 0.043, 0.039, 0.031, 0.96 }, -- #0B0A08  Obsidian
    BG_PANEL    = { 0.071, 0.063, 0.051, 0.96 }, -- #12100D  Black Walnut
    BG_RAISED   = { 0.102, 0.090, 0.067, 1.00 }, -- #1A1711  Dark Bronze
    BG_HOVER    = { 0.141, 0.122, 0.086, 1.00 }, -- #241F16  Warm Shadow
    BG_SELECTED = { 0.173, 0.145, 0.090, 1.00 }, -- #2C2517  Bronze Shadow

    -- Structure
    BORDER      = { 0.357, 0.286, 0.133, 1.00 }, -- #5B4922  Aged Bronze
    DIVIDER     = { 0.231, 0.192, 0.114, 1.00 }, -- #3B311D  Dark Bronze

    -- Gold hierarchy
    GOLD        = { 0.816, 0.678, 0.302, 1.00 }, -- #D0AD4D  Antique Gold
    GOLD_BRIGHT = { 0.902, 0.780, 0.400, 1.00 }, -- #E6C766  Bright Gold
    GOLD_MUTED  = { 0.620, 0.506, 0.208, 1.00 }, -- #9E8135  Old Gold

    -- Text
    TEXT_PRIMARY   = { 0.914, 0.886, 0.827, 1.00 }, -- #E9E2D3  Warm Parchment
    TEXT_SECONDARY = { 0.722, 0.682, 0.604, 1.00 }, -- #B8AE9A  Dusty Parchment
    TEXT_MUTED     = { 0.494, 0.463, 0.412, 1.00 }, -- #7E7669  Ash

    -- Semantic
    SUCCESS = { 0.561, 0.702, 0.408, 1.00 }, -- #8FB368  Muted Moss
    WARNING = { 0.839, 0.604, 0.290, 1.00 }, -- #D69A4A  Amber
    DANGER  = { 0.784, 0.416, 0.353, 1.00 }, -- #C86A5A  Faded Crimson
    VOID    = { 0.659, 0.545, 0.847, 1.00 }, -- #A88BD8  Muted Violet
}

IMAGO_HEX = {
    GOLD           = "FFD0AD4D",
    GOLD_BRIGHT    = "FFE6C766", -- Used for Character Links
    GOLD_MUTED     = "FF9E8135",

    TEXT_PRIMARY   = "FFE9E2D3",
    TEXT_SECONDARY = "FFB8AE9A",
    TEXT_MUTED     = "FF7E7669",

    SUCCESS = "FF8FB368",
    WARNING = "FFD69A4A",
    DANGER  = "FFC86A5A",
    VOID    = "FFA88BD8", -- Used for Zone Links
    CODEX   = "FF66C5E0", -- Used for Codex Links
}

-- Shared geometry for Fates and Zones.
IMAGO.LAYOUT = {
    WINDOW_W = 1100,
    WINDOW_H = 700,

    HEADER_HEIGHT = 45,
    HEADER_INSET_TOP = 4,
    HEADER_TO_WORKSPACE_GAP = 9,
    WORKSPACE_TOP = 58,

    SIDEBAR_OFFSET_LEFT = 10,
    SIDEBAR_WIDTH = 230,
    SIDEBAR_HEADER_HEIGHT = 30,

    SCROLLBAR_WIDTH = 4,
    SCROLLBAR_GUTTER = 8,
    SIDEBAR_USABLE_WIDTH = 222, -- SIDEBAR_WIDTH - SCROLLBAR_GUTTER
    SIDEBAR_CONTROL_PADDING = 4,
    SIDEBAR_CONTROL_GAP = 6,
    FILTER_WIDTH = 78,

    DIVIDER_WIDTH = 1,

    CONTENT_PADDING_LEFT  = 4,
    CONTENT_PADDING_RIGHT = 10,

    WORKSPACE_BOTTOM = 20,
}

-- Shared font assets.
IMAGO.FONT_TITLE = IMAGO.FONT_TITLE or ""
IMAGO.FONT_BODY = IMAGO.FONT_BODY or ""

local locale = GetLocale()
if locale == "ruRU" then
    IMAGO.FONT_TITLE = "Fonts\\FRIZQT___CYR.TTF"
    IMAGO.FONT_BODY  = "Fonts\\FRIZQT___CYR.TTF"
elseif locale == "koKR" then
    IMAGO.FONT_TITLE = "Fonts\\2002.TTF"
    IMAGO.FONT_BODY  = "Fonts\\2002.TTF"
elseif locale == "zhCN" then
    IMAGO.FONT_TITLE = "Fonts\\ARKai_T.TTF"
    IMAGO.FONT_BODY  = "Fonts\\ARKai_C.TTF"
elseif locale == "zhTW" then
    IMAGO.FONT_TITLE = "Fonts\\blei00d.TTF"
    IMAGO.FONT_BODY  = "Fonts\\blei00d.TTF"
else
    -- Default Latin (deDE, enUS, frFR, esES, etc.)
    IMAGO.FONT_TITLE = "Fonts\\MORPHEUS.TTF"
    IMAGO.FONT_BODY  = "Fonts\\FRIZQT__.TTF"
end

-- Centralized typography roles for Fates and Zones navigation.
IMAGO.TYPOGRAPHY = {
    DISPLAY = {
        font  = IMAGO.FONT_TITLE,
        size  = 32,
        flags = "OUTLINE",
        color = IMAGO_COLORS.GOLD,
        shadowColor  = {0, 0, 0, 1},
        shadowOffset = {2, -2},
    },
    SIDEBAR_HEADER = {
        font  = IMAGO.FONT_TITLE,
        size  = 15,
        flags = "OUTLINE",
        color = IMAGO_COLORS.GOLD,
    },
    NAV_CATEGORY = {
        font  = IMAGO.FONT_BODY,
        size  = 12,
        flags = "",
        color = IMAGO_COLORS.TEXT_SECONDARY,
        shadowColor  = {0, 0, 0, 0.5},
        shadowOffset = {1, -1},
    },
    RANK_TITLE = {
        font  = IMAGO.FONT_BODY,
        size  = 24,
        flags = "OUTLINE",
        color = IMAGO_COLORS.GOLD_BRIGHT,
    },
    NAV_ITEM = {
        font  = IMAGO.FONT_BODY,
        size  = 13,
        flags = "",
        color = IMAGO_COLORS.TEXT_PRIMARY,
    },
    NAV_META = {
        font  = IMAGO.FONT_BODY,
        size  = 9,
        flags = "",
        color = IMAGO_COLORS.TEXT_MUTED,
    },
    ZONE_ITEM = {
        font  = IMAGO.FONT_BODY,
        size  = 16,
        flags = "OUTLINE",
        color = IMAGO_COLORS.TEXT_PRIMARY,
        shadowColor  = {0, 0, 0, 0.5},
        shadowOffset = {1, -1},
    },
}

-- Apply a typography role (font + color + optional shadow) to a FontString.
function IMAGO.ApplyTextStyle(fontString, role, color)
    if not fontString or not IMAGO.TYPOGRAPHY[role] then return end
    local s = IMAGO.TYPOGRAPHY[role]
    local font = s.font or IMAGO.FONT_BODY
    fontString:SetFont(font, s.size, s.flags)
    local c = color or s.color
    fontString:SetTextColor(c[1], c[2], c[3])
    if s.shadowColor then
        fontString:SetShadowColor(s.shadowColor[1], s.shadowColor[2], s.shadowColor[3], s.shadowColor[4])
    end
    if s.shadowOffset then
        fontString:SetShadowOffset(s.shadowOffset[1], s.shadowOffset[2])
    end
end

-- Hidden measuring FontString for truncation checks
local IMAGO_TOOLTIP_MEASURE = UIParent:CreateFontString(nil, "ARTWORK")
IMAGO_TOOLTIP_MEASURE:Hide()

-- Returns true if the given FontString is currently ellipsized.
function IMAGO.IsTextTruncated(fontString)
    if not fontString then return false end
    local text = fontString:GetText() or ""
    if text == "" then return false end

    local font, size, flags = fontString:GetFont()
    IMAGO_TOOLTIP_MEASURE:SetFont(font, size, flags or "")
    IMAGO_TOOLTIP_MEASURE:SetText(text)
    IMAGO_TOOLTIP_MEASURE:SetWordWrap(false)
    IMAGO_TOOLTIP_MEASURE:SetWidth(0)

    local fullW = IMAGO_TOOLTIP_MEASURE:GetStringWidth()
    local visibleW = fontString:GetWidth()
    if not visibleW or visibleW <= 0 then return false end
    return fullW > visibleW + 1
end

-- Shows a GameTooltip with the full text only when the FontString is truncated.
function IMAGO.ShowTooltipIfTruncated(owner, fontString, fallbackText)
    if not fontString or not IMAGO.IsTextTruncated(fontString) then return end
    GameTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    GameTooltip:SetText(fallbackText or fontString:GetText() or "", 1, 1, 1, 1, true)
    GameTooltip:Show()
end

-- Internal: style a ScrollBar thumb and hide its track.  Returns the thumb.
local function StyleScrollBarInternal(sb, thumbColor, hoverColor)
    local w = IMAGO.LAYOUT.SCROLLBAR_WIDTH
    sb:SetWidth(w)

    local name = sb:GetName() or ""
    local up = _G[name .. "ScrollUpButton"]
    local dn = _G[name .. "ScrollDownButton"]
    if up then up:Hide() end
    if dn then dn:Hide() end

    local thumb = sb.GetThumbTexture and sb:GetThumbTexture()
    if not thumb then return end

    -- Hide the stock track/background textures; keep only the thumb.
    for _, region in ipairs({sb:GetRegions()}) do
        if region ~= thumb and region:GetObjectType() == "Texture" then
            region:Hide()
        end
    end

    -- Default thumb: GOLD_MUTED, alpha 0.40
    local c = thumbColor or IMAGO_COLORS.GOLD_MUTED
    local ca = (c[4] and c[4] * 0.40) or 0.40
    thumb:SetColorTexture(c[1], c[2], c[3], ca)
    thumb:SetWidth(w)

    -- Hover: GOLD, alpha 0.60
    local h = hoverColor or IMAGO_COLORS.GOLD
    local ha = (h[4] and h[4] * 0.60) or 0.60
    sb:SetScript("OnEnter", function()
        thumb:SetColorTexture(h[1], h[2], h[3], ha)
    end)
    sb:SetScript("OnLeave", function()
        thumb:SetColorTexture(c[1], c[2], c[3], ca)
    end)

    -- Keep the thumb hidden when the scroll child does not overflow, even
    -- if the default UIPanelScrollFrameTemplate tries to show the bar.
    local scrollFrame = sb:GetParent()
    if scrollFrame and not scrollFrame.__IMAGOScrollBarHooked then
        scrollFrame:HookScript("OnScrollRangeChanged", function(self) IMAGO.UpdateScrollBarVisibility(self) end)
        scrollFrame.__IMAGOScrollBarHooked = true
    end
end

-- Style a UIPanelScrollFrameTemplate scrollbar without re-anchoring it.
-- name: the global ScrollBar name, e.g. "IMAGOChronicleScrollScrollBar"
function IMAGO.StyleScrollBar(name, thumbColor, hoverColor)
    C_Timer.After(0, function()
        local sb = _G[name]
        if sb then StyleScrollBarInternal(sb, thumbColor, hoverColor) end
    end)
end

-- Show or hide a scrollbar based on whether its scroll child actually overflows.
function IMAGO.UpdateScrollBarVisibility(scrollFrame)
    if not scrollFrame then return end
    local sb = scrollFrame.ScrollBar or _G[(scrollFrame:GetName() or "") .. "ScrollBar"]
    if not sb then return end
    if not scrollFrame.__IMAGO_UpdatingScrollBar then
        scrollFrame.__IMAGO_UpdatingScrollBar = true
        scrollFrame:UpdateScrollChildRect()
        scrollFrame.__IMAGO_UpdatingScrollBar = nil
    end
    local range = scrollFrame:GetVerticalScrollRange() or 0
    if range <= 0.5 then
        sb:Hide()
    else
        sb:Show()
    end
end

-- Style and anchor a UIPanelScrollFrameTemplate scrollbar so it sits inside
-- the reserved gutter on the right side of the sidebar.
-- name: the global ScrollBar name, e.g. "IMAGOChronicleScrollScrollBar"
-- scrollFrame: the ScrollFrame that owns this scrollbar
function IMAGO.StyleAndAnchorScrollBar(name, scrollFrame, thumbColor, hoverColor)
    C_Timer.After(0, function()
        local sb = _G[name]
        if not sb then return end

        local w = IMAGO.LAYOUT.SCROLLBAR_WIDTH
        local gutter = IMAGO.LAYOUT.SCROLLBAR_GUTTER
        local rightOffset = -(gutter - w) / 2

        sb:ClearAllPoints()
        sb:SetPoint("TOPRIGHT", scrollFrame, "TOPRIGHT", rightOffset, -16)
        sb:SetPoint("BOTTOMRIGHT", scrollFrame, "BOTTOMRIGHT", rightOffset, 16)

        StyleScrollBarInternal(sb, thumbColor, hoverColor)
    end)
end

--- Create a reusable progress/rank footer for Fates and Zones.
--- The footer contains a rank title, progress text and a gold status bar.
--- @param parent Frame
--- @param width number
--- @return table footer
function IMAGO.CreateProgressFooter(parent, width)
    local footer = CreateFrame("Frame", nil, parent)
    footer:SetSize(width, 80)
    footer:SetPoint("BOTTOM", parent, "BOTTOM", 0, 0)

    footer.hLine = footer:CreateTexture(nil, "ARTWORK")
    footer.hLine:SetSize(width, 1)
    footer.hLine:SetPoint("TOP", footer, "TOP", 0, 0)
    footer.hLine:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    footer.hLine:SetGradient("HORIZONTAL",
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0),
        CreateColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5))

    footer.rankText = footer:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(footer.rankText, "NAV_ITEM", IMAGO_COLORS.GOLD_BRIGHT)
    footer.rankText:SetPoint("TOP", footer, "TOP", 0, -15)

    footer.progText = footer:CreateFontString(nil, "OVERLAY")
    IMAGO.ApplyTextStyle(footer.progText, "NAV_ITEM")
    footer.progText:SetTextColor(IMAGO_COLORS.TEXT_SECONDARY[1], IMAGO_COLORS.TEXT_SECONDARY[2], IMAGO_COLORS.TEXT_SECONDARY[3])
    footer.progText:SetPoint("TOP", footer.rankText, "BOTTOM", 0, -2)

    local barW = width - 40
    footer.bar = CreateFrame("StatusBar", nil, footer, "BackdropTemplate")
    footer.bar:SetSize(barW, 16)
    footer.bar:SetPoint("BOTTOM", footer, "BOTTOM", 0, 15)
    footer.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    footer.bar:GetStatusBarTexture():SetColorTexture(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.7)
    footer.bar:SetMinMaxValues(0, 100)
    footer.bar:SetValue(0)

    footer.bar.bg = footer.bar:CreateTexture(nil, "BACKGROUND")
    footer.bar.bg:SetAllPoints()
    footer.bar.bg:SetColorTexture(IMAGO_COLORS.BG_RAISED[1], IMAGO_COLORS.BG_RAISED[2], IMAGO_COLORS.BG_RAISED[3], 0.9)

    for i = 1, 9 do
        local tick = footer.bar:CreateTexture(nil, "OVERLAY")
        tick:SetColorTexture(0, 0, 0, 0.9)
        tick:SetSize(2, 16)
        tick:SetPoint("LEFT", footer.bar, "LEFT", barW * (i / 10), 0)
    end

    footer.bar.border = CreateFrame("Frame", nil, footer.bar, "BackdropTemplate")
    footer.bar.border:SetPoint("TOPLEFT", footer.bar, "TOPLEFT", -4, 4)
    footer.bar.border:SetPoint("BOTTOMRIGHT", footer.bar, "BOTTOMRIGHT", 4, -4)
    footer.bar.border:SetBackdrop({
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
    })
    footer.bar.border:SetBackdropBorderColor(IMAGO_COLORS.GOLD[1], IMAGO_COLORS.GOLD[2], IMAGO_COLORS.GOLD[3], 0.5)

    return footer
end

--- Update a progress footer built with IMAGO.CreateProgressFooter.
--- @param footer table
--- @param value number
--- @param max number
--- @param rankTitle string
--- @param progressText string
function IMAGO.UpdateProgressFooter(footer, value, max, rankTitle, progressText)
    if not footer then return end
    footer.bar:SetMinMaxValues(0, math.max(1, max or 1))
    footer.bar:SetValue(value or 0)
    if footer.rankText then footer.rankText:SetText(rankTitle or "") end
    if footer.progText then footer.progText:SetText(progressText or "") end
end

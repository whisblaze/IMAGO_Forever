-- ============================================================
-- IMAGO — core/Theme.lua
-- Obsidian & Antique Gold Design System
-- ============================================================

-- Live palettes. IMAGO_COLORS/IMAGO_HEX are filled by IMAGO.ApplyTheme();
-- color sub-tables are mutated in place so existing references stay valid.
IMAGO_COLORS = IMAGO_COLORS or {}
IMAGO_HEX = IMAGO_HEX or {}

-- Complete UI themes: colors, hex text colors, optional font overrides and
-- optional popup background-texture settings (stoneTex + stoneTint).
IMAGO.THEMES = {
    obsidian = {
        labelKey = "OPT_THEME_OBSIDIAN",
        colors = {
            BG_MAIN     = { 0.043, 0.039, 0.031, 0.96 },
            BG_PANEL    = { 0.071, 0.063, 0.051, 0.96 },
            BG_RAISED   = { 0.102, 0.090, 0.067, 1.00 },
            BG_HOVER    = { 0.141, 0.122, 0.086, 1.00 },
            BG_SELECTED = { 0.173, 0.145, 0.090, 1.00 },
            BORDER      = { 0.357, 0.286, 0.133, 1.00 },
            DIVIDER     = { 0.231, 0.192, 0.114, 1.00 },
            GOLD        = { 0.816, 0.678, 0.302, 1.00 },
            GOLD_BRIGHT = { 0.902, 0.780, 0.400, 1.00 },
            GOLD_MUTED  = { 0.620, 0.506, 0.208, 1.00 },
            TEXT_PRIMARY   = { 0.914, 0.886, 0.827, 1.00 },
            TEXT_SECONDARY = { 0.722, 0.682, 0.604, 1.00 },
            TEXT_MUTED     = { 0.494, 0.463, 0.412, 1.00 },
            SUCCESS = { 0.561, 0.702, 0.408, 1.00 },
            WARNING = { 0.839, 0.604, 0.290, 1.00 },
            DANGER  = { 0.784, 0.416, 0.353, 1.00 },
            VOID    = { 0.659, 0.545, 0.847, 1.00 },
        },
        hex = {
            GOLD = "FFD0AD4D", GOLD_BRIGHT = "FFE6C766", GOLD_MUTED = "FF9E8135",
            TEXT_PRIMARY = "FFE9E2D3", TEXT_SECONDARY = "FFB8AE9A", TEXT_MUTED = "FF7E7669",
            SUCCESS = "FF8FB368", WARNING = "FFD69A4A", DANGER = "FFC86A5A",
            VOID = "FFA88BD8", CODEX = "FF66C5E0", TIMELINE = "FFC98B5E",
        },
        stoneTint = { 0.62, 0.62, 0.67, 0.85 },
    },
}

IMAGO.THEME_ORDER = { "obsidian" }

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
    -- header pushed down so its 30 px centre lands on the detail title's
    -- centre (title top at -15, 32 px font -> centre ~-31)
    SIDEBAR_HEADER_TOP = 16,
    -- list begins below the title's divider line (~-55) with ~8 px air
    SIDEBAR_LIST_TOP = 63,

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
    IMAGO.IS_LATIN_LOCALE = true
    IMAGO.FONT_TITLE = "Fonts\\FRIZQT__.TTF"
    IMAGO.FONT_BODY  = "Fonts\\FRIZQT__.TTF"
end

-- Locale-default fonts; themes may override via fontTitle/fontBody.
IMAGO.DEFAULT_FONT_TITLE = IMAGO.FONT_TITLE
IMAGO.DEFAULT_FONT_BODY  = IMAGO.FONT_BODY

-- Selectable header fonts (Latin locales only; other scripts keep their
-- required fonts).
IMAGO.TITLE_FONTS = {
    morpheus = { file = "Fonts\\MORPHEUS.TTF", labelKey = "OPT_TITLEFONT_MORPHEUS" },
    frizqt   = { file = "Fonts\\FRIZQT__.TTF", labelKey = "OPT_TITLEFONT_FRIZQT" },
    arialn   = { file = "Fonts\\ARIALN.TTF",   labelKey = "OPT_TITLEFONT_ARIALN" },
}
IMAGO.TITLE_FONT_ORDER = { "frizqt", "morpheus", "arialn" }

-- True if the font file exists in this client. SetFont throws a script
-- error on missing assets in some clients, so it runs inside pcall.
function IMAGO.IsFontAvailable(path)
    if not IMAGO_FONT_PROBE then
        IMAGO_FONT_PROBE = UIParent:CreateFontString(nil, "ARTWORK")
        IMAGO_FONT_PROBE:Hide()
    end
    local ok = pcall(IMAGO_FONT_PROBE.SetFont, IMAGO_FONT_PROBE, path, 12, "")
    return ok == true
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

    -- native check honors word wrap + max lines (dossier values wrap twice)
    if fontString.IsTruncated then
        local ok, res = pcall(fontString.IsTruncated, fontString)
        if ok then return res and true or false end
    end

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
    -- Up/down arrow buttons are re-shown by UIPanelScrollBarTemplate's own
    -- scroll logic, so hiding once is not enough: they get alpha 0, lose
    -- mouse input and re-hide themselves whenever the template shows them.
    local function Grab(key)
        local o = _G[name .. key]
        if o and o.Hide then return o end
        o = sb[key]
        return (o and o.Hide) and o or nil
    end
    for _, b in pairs({ Grab("ScrollUpButton") or sb.Back,
                        Grab("ScrollDownButton") or sb.Forward }) do
        if b then
            b:SetAlpha(0)
            if b.EnableMouse then b:EnableMouse(false) end
            b:SetScript("OnShow", function(s) s:Hide() end)
            b:Hide()
        end
    end
    for _, key in ipairs({ "ScrollBarTop", "ScrollBarBottom", "ScrollBarMiddle" }) do
        local t = Grab(key)
        if t and t.Hide then t:Hide() end
    end

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
    if not scrollFrame.__IMAGO_UpdatingScrollBar then
        scrollFrame.__IMAGO_UpdatingScrollBar = true
        scrollFrame:UpdateScrollChildRect()
        scrollFrame.__IMAGO_UpdatingScrollBar = nil
    end
    local range = scrollFrame:GetVerticalScrollRange() or 0
    if sb then
        if range <= 0.5 then
            sb:Hide()
        else
            sb:Show()
        end
    end
    -- optional bottom fade overlay owned by the scroll frame: only when
    -- real content still sits below the viewport. The threshold is the
    -- fade's own height plus the content's bottom margin — smaller
    -- remainders are just padding or a sliver of the last line, and
    -- dimming them makes the fade look like it triggers too early.
    if scrollFrame.imagoBottomFade then
        local minHidden = (scrollFrame.imagoBottomFade:GetHeight() or 24) + 20
        local function updateFade()
            local r = scrollFrame:GetVerticalScrollRange() or 0
            local s = scrollFrame:GetVerticalScroll() or 0
            scrollFrame.imagoBottomFade:SetShown(
                scrollFrame:IsShown() and (r - s) > minHidden)
        end
        updateFade()
        if not scrollFrame.__IMAGO_FadeHooked then
            scrollFrame.__IMAGO_FadeHooked = true
            scrollFrame:HookScript("OnVerticalScroll", updateFade)
            -- Hiding the scroll frame must drop the fade immediately —
            -- no scroll event fires on Hide, so without this the overlay
            -- would float stale over whatever replaces the scroll area.
            scrollFrame:HookScript("OnHide", function()
                scrollFrame.imagoBottomFade:Hide()
            end)
            scrollFrame:HookScript("OnShow", updateFade)
        end
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

-- ============================================================
-- Theme switching
-- ============================================================

-- Applies a theme: mutates IMAGO_COLORS sub-tables in place (references in
-- TYPOGRAPHY and consumer files stay valid), replaces IMAGO_HEX entries and
-- updates the font pair + typography font roles.
function IMAGO.ApplyTheme(id)
    local t = IMAGO.THEMES[id] or IMAGO.THEMES.obsidian
    IMAGO.ACTIVE_THEME = t
    IMAGO.ACTIVE_THEME_ID = (IMAGO.THEMES[id] and id) or "obsidian"

    for key, src in pairs(t.colors or {}) do
        local dst = IMAGO_COLORS[key]
        if dst then
            dst[1], dst[2], dst[3], dst[4] = src[1], src[2], src[3], src[4]
        else
            IMAGO_COLORS[key] = { src[1], src[2], src[3], src[4] }
        end
    end

    for key, v in pairs(t.hex or {}) do
        IMAGO_HEX[key] = v
    end

    -- Theme font overrides only on Latin locales; other scripts keep their
    -- required fonts (Cyrillic, Korean, Chinese).
    local isLatin = (IMAGO.IS_LATIN_LOCALE == true)
    local fontTitle = (isLatin and t.fontTitle) or IMAGO.DEFAULT_FONT_TITLE
    local fontBody  = (isLatin and t.fontBody)  or IMAGO.DEFAULT_FONT_BODY

    -- User-selected header font (Latin locales only). Falls back silently
    -- when the font file is missing in this client.
    if isLatin and IMAGOSaved and IMAGOSaved.titleFont then
        local tf = IMAGO.TITLE_FONTS[IMAGOSaved.titleFont]
        if tf and IMAGO.IsFontAvailable(tf.file) then
            fontTitle = tf.file
        end
    end

    IMAGO.FONT_TITLE = fontTitle
    IMAGO.FONT_BODY  = fontBody

    -- Rebind typography roles (colors may resolve after TYPOGRAPHY defined).
    if IMAGO.TYPOGRAPHY then
        local C = IMAGO_COLORS
        IMAGO.TYPOGRAPHY.DISPLAY.color = C.GOLD
        IMAGO.TYPOGRAPHY.SIDEBAR_HEADER.color = C.GOLD
        IMAGO.TYPOGRAPHY.NAV_CATEGORY.color = C.TEXT_SECONDARY
        IMAGO.TYPOGRAPHY.RANK_TITLE.color = C.GOLD_BRIGHT
        IMAGO.TYPOGRAPHY.NAV_ITEM.color = C.TEXT_PRIMARY
        IMAGO.TYPOGRAPHY.NAV_META.color = C.TEXT_MUTED
        IMAGO.TYPOGRAPHY.ZONE_ITEM.color = C.TEXT_PRIMARY

        IMAGO.TYPOGRAPHY.DISPLAY.font = fontTitle
        IMAGO.TYPOGRAPHY.SIDEBAR_HEADER.font = fontTitle
        IMAGO.TYPOGRAPHY.NAV_CATEGORY.font = fontBody
        IMAGO.TYPOGRAPHY.RANK_TITLE.font = fontBody
        IMAGO.TYPOGRAPHY.NAV_ITEM.font = fontBody
        IMAGO.TYPOGRAPHY.NAV_META.font = fontBody
        IMAGO.TYPOGRAPHY.ZONE_ITEM.font = fontBody
    end

    IMAGO.ApplyThemeSurfaces()
end

-- Re-tints already-created themed surfaces that do not refresh themselves.
-- Currently: the Chronicle's bottom PanelTabButtonTemplate tabs.
function IMAGO.ApplyThemeSurfaces()
    local f = IMAGO.Chronicle and IMAGO.Chronicle.frame
    if not f or not f.mainTabs then return end
    local tint = IMAGO.ACTIVE_THEME and IMAGO.ACTIVE_THEME.tabTint
    local activeIdx = f.activeTabIndex or 1
    for i, tab in ipairs(f.mainTabs) do
        for _, region in ipairs({ tab:GetRegions() }) do
            if region:GetObjectType() == "Texture" then
                if tint then
                    region:SetVertexColor(tint[1], tint[2], tint[3])
                else
                    region:SetVertexColor(1, 1, 1)
                end
            end
        end
        -- Tab labels: gold like before, bright white when active.
        local fs = tab.Text or (tab.GetFontString and tab:GetFontString())
        if fs then
            local c = (i == activeIdx) and IMAGO_COLORS.TEXT_PRIMARY or IMAGO_COLORS.GOLD
            fs:SetTextColor(c[1], c[2], c[3])
        end
    end
end

-- Initial theme from saved settings (defaults to obsidian).
IMAGO.ApplyTheme((IMAGOSaved and IMAGOSaved.uiTheme) or "obsidian")

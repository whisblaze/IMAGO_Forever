-- ============================================================
-- IMAGO — core/Options.lua
-- Interface options in the standard WoW menu
-- ============================================================

IMAGO.Options = {}

function IMAGO.Options.Init()
    -- Create main panel
    local panel = CreateFrame("Frame", "IMAGOOptionsPanel")
    panel.name = "IMAGO"

    -- ScrollFrame for scrollable content
    local scrollFrame = CreateFrame("ScrollFrame", "IMAGOOptionsScroll", panel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 10, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

    -- ScrollChild frame - all controls go in here
    local content = CreateFrame("Frame", "IMAGOOptionsContent", scrollFrame)
    content:SetSize(580, 800) -- height adjusted later
    scrollFrame:SetScrollChild(content)

    -- Title (localized)
    local title = content:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 10, -10)
    title:SetText(IMAGO.L["SETTINGS_TITLE"])

    local description = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    description:SetText(IMAGO.L["SETTINGS_DESC"])

    local function CreateSectionHeader(text, anchor, x, y)
        local header = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        header:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", x or 0, y or -18)
        header:SetText(text)
        return header
    end

    local generalHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_GENERAL"], description, 0, -18)

    -- Checkbox: Enable addon (localized)
    local cbEnabled = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbEnabled:SetPoint("TOPLEFT", generalHeader, "BOTTOMLEFT", 0, -10)
    cbEnabled.Text:SetText(IMAGO.L["OPT_ENABLE"])
    cbEnabled:SetChecked(IMAGOSaved.enabled)
    cbEnabled:SetScript("OnClick", function(self) 
        IMAGOSaved.enabled = self:GetChecked() and true or false
    end)

    -- Button: Reset history (localized)
    local btnReset = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    btnReset:SetPoint("TOPLEFT", cbEnabled, "BOTTOMLEFT", 0, -14)
    btnReset:SetSize(160, 26)
    btnReset:SetText(IMAGO.L["OPT_RESET_BTN"])
    btnReset:SetScript("OnClick", function()
        IMAGOSaved.seenZones = {}
        IMAGOSaved.discoveredZones = IMAGOSaved.seenZones
        IMAGOSaved.seenNPCs = {}
        IMAGOSaved.seenInstances = {}
        print("|cFFFFD700IMAGO:|r " .. IMAGO.L["RESET_DONE"])
    end)

    local discoveryHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_DISCOVERY_CARD"], btnReset, 0, -22)

    -- Checkbox: Show only once (NPCs)
    local cbOnceNPC = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbOnceNPC:SetPoint("TOPLEFT", discoveryHeader, "BOTTOMLEFT", 0, -10)
    cbOnceNPC.Text:SetText(IMAGO.L["OPT_ONCE_ONLY_NPC"])
    cbOnceNPC:SetChecked(IMAGOSaved.showOnceOnlyNPC)
    cbOnceNPC:SetScript("OnClick", function(self)
        IMAGOSaved.showOnceOnlyNPC = self:GetChecked() and true or false
    end)

    -- Checkbox: Show only once (zones)
    local cbOnceZone = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbOnceZone:SetPoint("TOPLEFT", cbOnceNPC, "BOTTOMLEFT", 0, -10)
    cbOnceZone.Text:SetText(IMAGO.L["OPT_ONCE_ONLY_ZONE"])
    cbOnceZone:SetChecked(IMAGOSaved.showOnceOnlyZone)
    cbOnceZone:SetScript("OnClick", function(self)
        IMAGOSaved.showOnceOnlyZone = self:GetChecked() and true or false
    end)

    -- Checkbox: Keep main lore window open (no timer)
    local cbNoMainLoreTimer = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbNoMainLoreTimer:SetPoint("TOPLEFT", cbOnceZone, "BOTTOMLEFT", 0, -10)
    cbNoMainLoreTimer.Text:SetText(IMAGO.L["OPT_MAIN_LORE_NO_TIMER"])
    cbNoMainLoreTimer:SetChecked(IMAGOSaved.noMainLoreTimerClose)
    cbNoMainLoreTimer:SetScript("OnClick", function(self)
        IMAGOSaved.noMainLoreTimerClose = self:GetChecked() and true or false
    end)

    -- Combat Mode: Close on Combat
    local cbCloseOnCombat = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbCloseOnCombat:SetPoint("TOPLEFT", cbNoMainLoreTimer, "BOTTOMLEFT", 0, -10)
    cbCloseOnCombat.Text:SetText(IMAGO.L["OPT_CLOSE_ON_COMBAT"])
    cbCloseOnCombat:SetChecked(IMAGOSaved.closeOnCombat ~= false)
    cbCloseOnCombat:SetScript("OnClick", function(self)
        IMAGOSaved.closeOnCombat = self:GetChecked() and true or false
    end)

    -- Break Contact: Enable
    local cbBreakContact = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbBreakContact:SetPoint("TOPLEFT", cbCloseOnCombat, "BOTTOMLEFT", 0, -10)
    cbBreakContact.Text:SetText(IMAGO.L["OPT_ENABLE_BREAK_CONTACT"])
    cbBreakContact:SetChecked(IMAGOSaved.enableBreakContact ~= false)
    cbBreakContact:SetScript("OnClick", function(self)
        IMAGOSaved.enableBreakContact = self:GetChecked() and true or false
    end)

    -- Break Contact: distance slider (compact spacing)
    local sliderDistance = CreateFrame("Slider", "IMAGOBreakContactSlider", content, "OptionsSliderTemplate")
    sliderDistance:SetPoint("TOPLEFT", cbBreakContact, "BOTTOMLEFT", 0, -15)
    sliderDistance:SetMinMaxValues(10, 200)
    sliderDistance:SetValueStep(10)
    sliderDistance:SetObeyStepOnDrag(true)
    sliderDistance:SetValue(IMAGOSaved.breakContactDistance or 50)

    _G[sliderDistance:GetName() .. "Low"]:SetText("10")
    _G[sliderDistance:GetName() .. "High"]:SetText("200")
    _G[sliderDistance:GetName() .. "Text"]:SetText(IMAGO.L["OPT_BREAK_CONTACT_DISTANCE"])

    sliderDistance:SetScript("OnValueChanged", function(self, value)
        IMAGOSaved.breakContactDistance = value
    end)

    local flashcardsHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_IDLE_FLASHCARDS"], sliderDistance, 0, -22)

    local cbEnableFlashcards = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbEnableFlashcards:SetPoint("TOPLEFT", flashcardsHeader, "BOTTOMLEFT", 0, -10)
    cbEnableFlashcards.Text:SetText(IMAGO.L["OPT_ENABLE_IDLE_FLASHCARDS"])
    cbEnableFlashcards:SetChecked(IMAGOSaved.enableIdleFlashcards)
    cbEnableFlashcards:SetScript("OnClick", function(self)
        local enabled = self:GetChecked() and true or false
        IMAGOSaved.enableIdleFlashcards = enabled
        if not enabled and IMAGO.UI and IMAGO.UI.HideSnippetPopup then
            IMAGO.UI.HideSnippetPopup()
        end
    end)

    -- Checkbox: Keep idle flashcards open (no timer)
    local cbKeepSnippetOpen = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbKeepSnippetOpen:SetPoint("TOPLEFT", cbEnableFlashcards, "BOTTOMLEFT", 0, -10)
    cbKeepSnippetOpen.Text:SetText(IMAGO.L["OPT_SNIPPET_NO_TIMER"])
    cbKeepSnippetOpen:SetChecked(IMAGOSaved.keepSnippetOpen)
    cbKeepSnippetOpen:SetScript("OnClick", function(self)
        IMAGOSaved.keepSnippetOpen = self:GetChecked() and true or false
    end)

    local motdHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_MOTD"], cbKeepSnippetOpen, 0, -18)

    local cbEnableMotD = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbEnableMotD:SetPoint("TOPLEFT", motdHeader, "BOTTOMLEFT", 0, -10)
    cbEnableMotD.Text:SetText(IMAGO.L["OPT_ENABLE_MOTD"])
    cbEnableMotD:SetChecked(IMAGOSaved.enableMotD)
    cbEnableMotD:SetScript("OnClick", function(self)
        IMAGOSaved.enableMotD = self:GetChecked() and true or false
    end)

    local uiHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_UI"], cbEnableMotD, 0, -18)

    -- Checkbox: 100% opaque windows
    local cbOpaqueUI = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbOpaqueUI:SetPoint("TOPLEFT", uiHeader, "BOTTOMLEFT", 0, -10)
    cbOpaqueUI.Text:SetText(IMAGO.L["OPT_OPAQUE_UI"])
    cbOpaqueUI:SetChecked(IMAGOSaved.opaqueUI)
    cbOpaqueUI:SetScript("OnClick", function(self)
        IMAGOSaved.opaqueUI = self:GetChecked() and true or false
    end)

    -- Checkbox: Show minimap icon
    local cbMinimap = CreateFrame("CheckButton", nil, content, "InterfaceOptionsCheckButtonTemplate")
    cbMinimap:SetPoint("TOPLEFT", cbOpaqueUI, "BOTTOMLEFT", 0, -10)
    cbMinimap.Text:SetText(IMAGO.L["OPT_SHOW_MINIMAP"])
    cbMinimap:SetChecked(not IMAGOSaved.hideMinimap)
    cbMinimap:SetScript("OnClick", function(self)
        local hide = not (self:GetChecked() and true or false)
        IMAGOSaved.hideMinimap = hide
        if IMAGO.minimapButton then
            if hide then
                IMAGO.minimapButton:Hide()
            else
                IMAGO.minimapButton:Show()
            end
        end
    end)

    -- Slider: Scale (localized)
    local sliderScale = CreateFrame("Slider", "IMAGOScaleSlider", content, "OptionsSliderTemplate")
    sliderScale:SetPoint("TOPLEFT", cbMinimap, "BOTTOMLEFT", 0, -40)
    sliderScale:SetMinMaxValues(0.5, 2.0)
    sliderScale:SetValueStep(0.05)
    sliderScale:SetObeyStepOnDrag(true)
    sliderScale:SetValue(IMAGOSaved.frameScale or 1.0)
    
    _G[sliderScale:GetName() .. "Low"]:SetText("50%")
    _G[sliderScale:GetName() .. "High"]:SetText("200%")
    _G[sliderScale:GetName() .. "Text"]:SetText(IMAGO.L["OPT_SCALE"])

    sliderScale:SetScript("OnValueChanged", function(self, value)
        IMAGOSaved.frameScale = value
        if IMAGO.Display.frame then
            IMAGO.Display.frame:SetScale(value)
        end
    end)

    -- --------------------------------------------------------
    -- Language
    -- --------------------------------------------------------
    local langHeader = CreateSectionHeader(IMAGO.L["SETTINGS_SEC_LANGUAGE"], sliderScale, 0, -22)

    local languages = {
        { code = "enUS", label = "English" },
        { code = "esES", label = "Español" },
        { code = "deDE", label = "Deutsch" },
        { code = "ruRU", label = "\208\160\209\131\209\129\209\129\208\186\208\184\208\185" },
    }

    local currentLang = IMAGOSaved.language or IMAGO.currentLocale or "enUS"
    local langButtons = {}
    local lastLangBtn = nil

    for i, lang in ipairs(languages) do
        local rb = CreateFrame("CheckButton", "IMAGOLangRadio_" .. lang.code, content, "UIRadioButtonTemplate")
        if lastLangBtn then
            rb:SetPoint("TOPLEFT", lastLangBtn, "BOTTOMLEFT", 0, -10)
        else
            rb:SetPoint("TOPLEFT", langHeader, "BOTTOMLEFT", 0, -10)
        end
        rb.text:SetText(lang.label)
        rb:SetChecked(currentLang == lang.code)
        rb:SetScript("OnClick", function()
            IMAGOSaved.language = lang.code
            for _, btn in ipairs(langButtons) do
                btn:SetChecked(btn.langCode == lang.code)
            end
        end)
        rb.langCode = lang.code
        langButtons[i] = rb
        lastLangBtn = rb
    end

    local langNote = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    langNote:SetPoint("TOPLEFT", lastLangBtn, "BOTTOMLEFT", 0, -8)
    langNote:SetText("|cFFAAAAAA" .. IMAGO.L["OPT_LANGUAGE_NOTE"] .. "|r")

    -- Set content height (enough room for all elements)
    content:SetHeight(900)

    -- Register in the WoW settings menu
    local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
    Settings.RegisterAddOnCategory(category)
    IMAGO.settingsCategory = category
end

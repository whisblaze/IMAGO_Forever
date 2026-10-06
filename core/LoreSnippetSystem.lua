IMAGO.Snippets = IMAGO.Snippets or {}

local COOLDOWN_SECONDS = 15
local lastAutoAt = 0

local CATEGORIES = { "FUN_FACT", "DID_YOU_KNOW", "HISTORICAL_FACT", "BEHIND_THE_SCENES"}

local FISHING_SPELL_IDS = {
    [51294] = true,
    [271990] = true,
    [131476] = true,
    [110410] = true,
    [7731] = true,
    [7732] = true,
    [158743] = true,
    [33095] = true,
    [131490] = true,
    [88868] = true,
    [272011] = true,
    [18248] = true,
    [271616] = true,
    [131474] = true,
}

local function GetNow()
    return (GetTime and GetTime()) or 0
end

local function GetLocalizedSnippetText(entry)
    if type(entry) == "string" then return entry end
    if type(entry) ~= "table" then return nil end

    return entry.text
end

local function PickRandom()
    if type(IMAGO.LoreSnippets) ~= "table" then return nil, nil end

    local available = {}
    for i = 1, #CATEGORIES do
        local k = CATEGORIES[i]
        local list = IMAGO.LoreSnippets[k]
        if type(list) == "table" and #list > 0 then
            available[#available + 1] = k
        end
    end
    if #available == 0 then return nil, nil end

    local categoryKey = available[math.random(1, #available)]
    local list = IMAGO.LoreSnippets[categoryKey]
    local entry = list[math.random(1, #list)]
    local text = GetLocalizedSnippetText(entry)
    if not text or text == "" then return nil, nil end

    return categoryKey, text
end

function IMAGO.Snippets.ShowRandom(ignoreCooldown)
    if not IMAGOSaved or not IMAGOSaved.enabled then return false end
    if not IMAGOSaved.enableIdleFlashcards then return false end

    if not ignoreCooldown then
        local now = GetNow()
        if (now - lastAutoAt) < COOLDOWN_SECONDS then return false end
    end

    local categoryKey, text = PickRandom()
    if not categoryKey or not text then return false end

    if IMAGO.UI and IMAGO.UI.ShowSnippetPopup then
        IMAGO.UI.ShowSnippetPopup(text, categoryKey)
    else
        local title = (IMAGO.L and IMAGO.L[categoryKey]) or categoryKey
        print("|cff00ccff[IMAGO]|r " .. title .. ": " .. text)
    end

    if not ignoreCooldown then
        lastAutoAt = GetNow()
    end

    return true
end

function IMAGO.Snippets.HandleEvent(event, ...)
    if not IMAGOSaved or not IMAGOSaved.enabled then return end
    if not IMAGOSaved.enableIdleFlashcards then return end

    if event == "PLAYER_DEAD" then
        IMAGO.Snippets.ShowRandom(false)
        return
    end

    if event == "UNIT_SPELLCAST_CHANNEL_START" then
        local unitTarget = ...
        local spellID = select(3, ...)
        if unitTarget == "player" and spellID and FISHING_SPELL_IDS[spellID] then
            IMAGO.Snippets.ShowRandom(false)
        end
        return
    end

    if event == "PLAYER_CONTROL_LOST" then
        C_Timer.After(0.1, function()
            if UnitOnTaxi and UnitOnTaxi("player") then
                IMAGO.Snippets.ShowRandom(false)
            end
        end)
        return
    end
end

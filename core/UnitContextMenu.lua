-- ============================================================
-- IMAGO — core/UnitContextMenu.lua
-- Entry in the target right-click menu (Menu API, ~11.0+)
-- ============================================================

IMAGO.UnitContextMenu = {}

function IMAGO.UnitContextMenu.TryShowLoreForUnit(unit)
    if not IMAGOSaved or not IMAGOSaved.enabled then return end
    if not unit or not UnitExists(unit) then return end
    if UnitIsPlayer(unit) then return end

    if InCombatLockdown() then
        print(IMAGO.L["CONTEXT_LORE_COMBAT"] or "|cFF888888IMAGO:|r Im Kampf nicht verfügbar.")
        return
    end

    local okGuid, guid = pcall(UnitGUID, unit)
    if not okGuid or not guid then return end

    local npcID, creatureType = IMAGO.GetNPCIDFromGUID(guid)
    if not npcID then
        print(IMAGO.L["CONTEXT_LORE_NONE"] or "|cFF888888IMAGO:|r Keine Lore für diesen NPC gefunden.")
        return
    end

    local slug = IMAGOdb.idToSlug[npcID]
    if not slug or not IMAGO.GetNPCData(slug) then
        print(IMAGO.L["CONTEXT_LORE_NONE"] or "|cFF888888IMAGO:|r Keine Lore für diesen NPC gefunden.")
        return
    end

    if IMAGO.Chronicle and IMAGO.Chronicle.OpenToNPCSlug then
        local ok = IMAGO.Chronicle.OpenToNPCSlug(slug, { skipDiscoveryCinematic = true })
        if not ok then
            print(IMAGO.L["CONTEXT_LORE_CHRONICLE_FAIL"] or "|cFF888888IMAGO:|r Chronik konnte den Eintrag nicht fokussieren.")
        end
    end
end

function IMAGO.UnitContextMenu.Init()
    if IMAGO.UnitContextMenu._registered then return end
    if not Menu or type(Menu.ModifyMenu) ~= "function" then return end

    Menu.ModifyMenu("MENU_UNIT_TARGET", function(_, rootDescription)
        if not IMAGOSaved or not IMAGOSaved.enabled then return end
        if not rootDescription or type(rootDescription.CreateButton) ~= "function" then return end

        -- Always a dynamic target; avoids stale tokens between menu open and click.
        local unit = "target"
        if not UnitExists(unit) or UnitIsPlayer(unit) then return end

        if rootDescription.CreateDivider then
            rootDescription:CreateDivider()
        end
        rootDescription:CreateButton(IMAGO.L["CONTEXT_LORE_BTN"] or "IMAGO Lore", function()
            IMAGO.UnitContextMenu.TryShowLoreForUnit(unit)
        end)
    end)

    IMAGO.UnitContextMenu._registered = true
end

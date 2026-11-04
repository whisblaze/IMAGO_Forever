-- ============================================================
-- IMAGO Forever — data/timeline_static.lua (static data)
-- Timeline tab: curated Warcraft chronicle, ending at the
-- Classic era (~23-25 ADP). No unlocks, no progress — every
-- event is always readable. Eras define the left column; each
-- event belongs to exactly one era via its `era` field.
--
-- NOTE: IMAGOdb.timelines (plural, locales/*/data/timelines.lua)
-- is the per-NPC era history shown in the Fates detail view.
-- This table (singular) is the standalone Timeline main tab.
--
-- Events are sorted in the chronology column by `year`, then
-- `order`. `year` is a pure sort key — the displayed label is
-- localized (`yearLabel` in locales/*/data/timeline.lua).
-- Undated mythic events use sentinel years far in the past.
--
-- Related-entry chips are fully automatic: the detail view shows
-- every entry the body text links to (TextLinker.FindReferences)
-- plus every entry whose texts link back (TextLinker.GetBacklinks).
-- There are no curated related lists in this file.
--
-- linkable = true adds the event's title (and locale `aliases`)
-- to the TextLinker lookup so lore texts auto-link to it. Only
-- set for unambiguous event names — generic titles like
-- "The First War" stay unlinked to avoid noisy matches.
--
-- stub = true marks entries whose lore text is still being
-- written — the chronology list renders them dimmed and the
-- detail view shows a work-in-progress note instead of a body.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}

-- ============================================================
-- ERAS (left column, array order = display order)
-- ============================================================

IMAGOdb.timeline.eras = {
    { key = "cosmos", icon = "Interface\\Icons\\Spell_Nature_Starfall" },
    { key = "early_peoples", icon = "Interface\\Icons\\Ability_Mount_Raptor" },
    { key = "sundering", icon = "Interface\\Icons\\Spell_Nature_Earthquake" },
    { key = "kaldorei", icon = "Interface\\Icons\\Ability_Racial_Shadowmeld" },
    { key = "kingdoms", icon = "Interface\\Icons\\INV_Crown_01" },
    { key = "fall_draenor", icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy" },
    { key = "first_war", icon = "Interface\\Icons\\Ability_Warrior_WarCry" },
    { key = "second_war", icon = "Interface\\Icons\\INV_Sword_27" },
    { key = "between_wars", icon = "Interface\\Icons\\INV_Misc_Map_01" },
    { key = "third_war", icon = "Interface\\Icons\\Spell_Shadow_DeathCoil" },
    { key = "new_order", icon = "Interface\\Icons\\Ability_EyeOfTheOwl" },
}

-- ============================================================
-- EVENTS
-- ============================================================

IMAGOdb.timeline.events = {

    -- ============ COSMOS ============

    ["creation_universe"] = {
        era = "cosmos", year = -999999, order = 10,
    },

    ["black_empire"] = {
        era = "cosmos", year = -999998, order = 20,
    },

    ["ordering_azeroth"] = {
        era = "cosmos", year = -999997, order = 30,
    },

    ["sargeras_fall"] = {
        era = "cosmos", year = -999996, order = 40, linkable = true,
    },

    ["doom_karesh"] = {
        era = "cosmos", year = -100000, order = 45, linkable = true,
    },

    ["charge_dragonflights"] = {
        era = "cosmos", year = -20285, order = 50,
    },

    ["odyns_halls"] = {
        era = "cosmos", year = -20200, order = 60,
    },

    ["keepers_fall"] = {
        era = "cosmos", year = -20000, order = 70,
    },

    ["winterskorn_war"] = {
        era = "cosmos", year = -20000, order = 80,
    },

    ["tyrs_sacrifice"] = {
        era = "cosmos", year = -20000, order = 90,
    },

    -- ============ EARLY_PEOPLES ============

    ["twin_empires"] = {
        era = "early_peoples", year = -16000, order = 100,
    },

    ["thunder_king"] = {
        era = "early_peoples", year = -15000, order = 110, stub = true,
    },

    ["rise_kaldorei"] = {
        era = "early_peoples", year = -15000, order = 120, stub = true,
    },

    ["corruption_eredar"] = {
        era = "early_peoples", year = -13000, order = 130, stub = true,
    },

    ["pandaria_freed"] = {
        era = "early_peoples", year = -12000, order = 140, stub = true,
    },

    -- ============ SUNDERING ============

    ["war_ancients"] = {
        era = "sundering", year = -10000, order = 150, linkable = true, stub = true,
    },

    ["the_sundering"] = {
        era = "sundering", year = -10000, order = 160, linkable = true, stub = true,
    },

    ["nordrassil_hyjal"] = {
        era = "sundering", year = -10000, order = 170, stub = true,
    },

    -- ============ KALDOREI ============

    ["war_satyr"] = {
        era = "kaldorei", year = -9300, order = 180, stub = true,
    },

    ["the_long_vigil"] = {
        era = "kaldorei", year = -7300, order = 190, stub = true,
    },

    ["founding_quelthalas"] = {
        era = "kaldorei", year = -6800, order = 200, stub = true,
    },

    ["andrassil_vordrassil"] = {
        era = "kaldorei", year = -4500, order = 210, stub = true,
    },

    -- ============ KINGDOMS ============

    ["arathor_troll_wars"] = {
        era = "kingdoms", year = -2800, order = 220, stub = true,
    },

    ["council_tirisfal"] = {
        era = "kingdoms", year = -2680, order = 230, stub = true,
    },

    ["awakening_dwarves"] = {
        era = "kingdoms", year = -2500, order = 240, stub = true,
    },

    ["seven_kingdoms"] = {
        era = "kingdoms", year = -1200, order = 250, stub = true,
    },

    ["war_shifting_sands"] = {
        era = "kingdoms", year = -975, order = 260, stub = true,
    },

    ["aegwynn_tomb"] = {
        era = "kingdoms", year = -823, order = 270, stub = true,
    },

    ["war_three_hammers"] = {
        era = "kingdoms", year = -230, order = 280, stub = true,
    },

    ["draenei_draenor"] = {
        era = "kingdoms", year = -200, order = 290, stub = true,
    },

    ["medivh_born"] = {
        era = "kingdoms", year = -45, order = 300, stub = true,
    },

    -- ============ FALL_DRAENOR ============

    ["guldan_fel"] = {
        era = "fall_draenor", year = -12, order = 310, stub = true,
    },

    ["horde_forms"] = {
        era = "fall_draenor", year = -8, order = 320, stub = true,
    },

    ["draenei_genocide"] = {
        era = "fall_draenor", year = -4, order = 330, stub = true,
    },

    ["dark_portal_built"] = {
        era = "fall_draenor", year = -1, order = 340, stub = true,
    },

    -- ============ FIRST_WAR ============

    ["dark_portal_opens"] = {
        era = "first_war", year = 0, order = 350, linkable = true, stub = true,
    },

    ["fall_guardian"] = {
        era = "first_war", year = 3, order = 360, stub = true,
    },

    ["fall_stormwind"] = {
        era = "first_war", year = 3, order = 370, stub = true,
    },

    -- ============ SECOND_WAR ============

    ["alliance_lordaeron"] = {
        era = "second_war", year = 4, order = 380, stub = true,
    },

    ["horde_campaign"] = {
        era = "second_war", year = 6, order = 390, stub = true,
    },

    ["guldan_betrayal"] = {
        era = "second_war", year = 6, order = 400, stub = true,
    },

    ["siege_blackrock"] = {
        era = "second_war", year = 6, order = 410, stub = true,
    },

    -- ============ BETWEEN_WARS ============

    ["sons_of_lothar"] = {
        era = "between_wars", year = 7, order = 420, stub = true,
    },

    ["birth_lich_king"] = {
        era = "between_wars", year = 8, order = 430, stub = true,
    },

    ["grim_batol"] = {
        era = "between_wars", year = 10, order = 440, linkable = true, stub = true,
    },

    ["war_spider_cult"] = {
        era = "between_wars", year = 10, order = 450, stub = true,
    },

    ["thrall_new_horde"] = {
        era = "between_wars", year = 18, order = 460, stub = true,
    },

    -- ============ THIRD_WAR ============

    ["plague_lordaeron"] = {
        era = "third_war", year = 20, order = 470, stub = true,
    },

    ["frostmourne_claimed"] = {
        era = "third_war", year = 20, order = 480, stub = true,
    },

    ["fall_quelthalas_dalaran"] = {
        era = "third_war", year = 20, order = 490, stub = true,
    },

    ["horde_kalimdor"] = {
        era = "third_war", year = 20, order = 500, stub = true,
    },

    ["battle_hyjal"] = {
        era = "third_war", year = 21, order = 510, stub = true,
    },

    -- ============ NEW_ORDER ============

    ["illidan_betrayer"] = {
        era = "new_order", year = 22, order = 520, stub = true,
    },

    ["forsaken_lichking"] = {
        era = "new_order", year = 22, order = 530, stub = true,
    },

    ["durotar_founded"] = {
        era = "new_order", year = 23, order = 540, stub = true,
    },

}

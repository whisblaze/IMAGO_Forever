-- ============================================================
-- IMAGO Forever — data/codex_static.lua (static data)
-- Codex: curated lore lexicon. No unlocks, no progress — every
-- entry is always readable. Categories define the sidebar; each
-- entry belongs to exactly one category and is sorted by `order`.
--
-- related = clickable links rendered as chips below the text:
--   { type = "codex", slug = <codex entry slug> }
--   { type = "race",  slug = <race slug> }
--   { type = "class", slug = <class slug> }
--   { type = "npc",   slug = <fates slug> }
--   { type = "zone",  mapID = <uiMapID> }     -- (reserved)
--
-- linkable = true adds the entry's title (and locale `aliases`)
-- to the TextLinker lookup so lore texts auto-link to it.
-- Only set for unambiguous proper nouns.
--
-- Localized text (title, body, aliases) lives in
-- locales/base/data/codex.lua. Category icons are placeholders —
-- swap the `icon` fields once final FileIDs are supplied.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.codex = IMAGOdb.codex or {}

-- ============================================================
-- CATEGORIES (sidebar, fixed order)
-- ============================================================

IMAGOdb.codex.categories = {
    { key = "cosmology", icon = "Interface\\Icons\\Spell_Arcane_StarFire" },
    { key = "magic",     icon = "Interface\\Icons\\Spell_Arcane_Blink" },
    { key = "peoples",   icon = "Interface\\Icons\\INV_Misc_GroupLooking" },
    { key = "history",   icon = "Interface\\Icons\\INV_Misc_Book_09" },
    { key = "factions",  icon = "Interface\\Icons\\INV_BannerPVP_02" },
}

-- ============================================================
-- ENTRIES
-- ============================================================

IMAGOdb.codex.entries = {

    -- ============ COSMOLOGY ============

    ["great_sundering"] = {
        category = "cosmology", order = 10, linkable = true,
        related = {
            { type = "codex", slug = "well_of_eternity" },
            { type = "codex", slug = "war_of_ancients" },
            { type = "race",  slug = "night_elf" },
            { type = "codex", slug = "burning_legion" },
        },
    },

    ["well_of_eternity"] = {
        category = "cosmology", order = 20, linkable = true,
        related = {
            { type = "codex", slug = "great_sundering" },
            { type = "codex", slug = "highborne" },
            { type = "codex", slug = "arcane" },
            { type = "codex", slug = "war_of_ancients" },
        },
    },

    ["titans"] = {
        category = "cosmology", order = 30, linkable = true,
        related = {
            { type = "codex", slug = "old_gods" },
            { type = "race",  slug = "dwarf" },
        },
    },

    ["old_gods"] = {
        category = "cosmology", order = 40, linkable = true,
        related = {
            { type = "codex", slug = "titans" },
        },
    },

    ["emerald_dream"] = {
        category = "cosmology", order = 50, linkable = true,
        related = {
            { type = "codex", slug = "nature" },
            { type = "class", slug = "druid" },
            { type = "npc",   slug = "fandral_staghelm" },
        },
    },

    ["twisting_nether"] = {
        category = "cosmology", order = 60, linkable = true,
        related = {
            { type = "codex", slug = "burning_legion" },
            { type = "codex", slug = "fel" },
        },
    },

    -- ============ MAGIC & POWERS ============

    ["arcane"] = {
        category = "magic", order = 10,
        related = {
            { type = "codex", slug = "kirin_tor" },
            { type = "codex", slug = "well_of_eternity" },
            { type = "class", slug = "mage" },
        },
    },

    ["fel"] = {
        category = "magic", order = 20,
        related = {
            { type = "codex", slug = "burning_legion" },
            { type = "codex", slug = "twisting_nether" },
            { type = "class", slug = "warlock" },
        },
    },

    ["holy_light"] = {
        category = "magic", order = 30,
        related = {
            { type = "class", slug = "paladin" },
            { type = "class", slug = "priest" },
            { type = "npc",   slug = "tirion_fordring" },
        },
    },

    ["nature"] = {
        category = "magic", order = 40,
        related = {
            { type = "codex", slug = "emerald_dream" },
            { type = "class", slug = "druid" },
            { type = "class", slug = "shaman" },
        },
    },

    -- ============ PEOPLES & ORIGINS ============

    ["highborne"] = {
        category = "peoples", order = 10, linkable = true,
        related = {
            { type = "race",  slug = "night_elf" },
            { type = "codex", slug = "well_of_eternity" },
            { type = "npc",   slug = "tyrande_whisperwind" },
            { type = "npc",   slug = "fandral_staghelm" },
        },
    },

    ["forsaken_people"] = {
        category = "peoples", order = 20, linkable = true,
        related = {
            { type = "race",  slug = "undead" },
            { type = "npc",   slug = "sylvanas_windrunner" },
            { type = "codex", slug = "scourge" },
            { type = "codex", slug = "lich_king" },
        },
    },

    -- ============ HISTORY & CONCEPTS ============

    ["war_of_ancients"] = {
        category = "history", order = 10, linkable = true,
        related = {
            { type = "codex", slug = "great_sundering" },
            { type = "codex", slug = "burning_legion" },
            { type = "codex", slug = "well_of_eternity" },
            { type = "race",  slug = "night_elf" },
        },
    },

    ["dark_portal"] = {
        category = "history", order = 20, linkable = true,
        related = {
            { type = "codex", slug = "guardians_tirisfal" },
            { type = "race",  slug = "orc" },
            { type = "npc",   slug = "thrall" },
        },
    },

    ["lich_king"] = {
        category = "history", order = 30, linkable = true,
        related = {
            { type = "codex", slug = "scourge" },
            { type = "codex", slug = "forsaken_people" },
            { type = "npc",   slug = "sylvanas_windrunner" },
        },
    },

    -- ============ FACTIONS & ORDERS ============

    ["kirin_tor"] = {
        category = "factions", order = 10, linkable = true,
        related = {
            { type = "codex", slug = "arcane" },
            { type = "class", slug = "mage" },
            { type = "npc",   slug = "jaina_proudmoore" },
        },
    },

    ["guardians_tirisfal"] = {
        category = "factions", order = 20, linkable = true,
        related = {
            { type = "codex", slug = "kirin_tor" },
            { type = "codex", slug = "dark_portal" },
            { type = "codex", slug = "burning_legion" },
        },
    },

    ["burning_legion"] = {
        category = "factions", order = 30, linkable = true,
        related = {
            { type = "codex", slug = "twisting_nether" },
            { type = "codex", slug = "fel" },
            { type = "codex", slug = "war_of_ancients" },
            { type = "race",  slug = "orc" },
        },
    },

    ["scourge"] = {
        category = "factions", order = 40, linkable = true,
        related = {
            { type = "codex", slug = "lich_king" },
            { type = "codex", slug = "forsaken_people" },
            { type = "race",  slug = "undead" },
        },
    },
}

-- ============================================================
-- IMAGO Forever — data/timeline_static.lua (static data)
-- Timeline tab: curated Warcraft chronicle, ending at the
-- Classic era (~25-30 ADP). No unlocks, no progress — every
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
-- related = clickable chips below the body text:
--   { type = "timeline", slug = <timeline event slug> }
--   { type = "codex",    slug = <codex entry slug> }
--   { type = "race",     slug = <race slug> }
--   { type = "class",    slug = <class slug> }
--   { type = "npc",      slug = <fates slug> }
--
-- linkable = true adds the event's title (and locale `aliases`)
-- to the TextLinker lookup so lore texts auto-link to it. Only
-- set for unambiguous event names — generic titles like
-- "The First War" stay unlinked to avoid noisy matches.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}

-- ============================================================
-- ERAS (left column, array order = display order)
-- ============================================================

IMAGOdb.timeline.eras = {
    { key = "mythos",       icon = "Interface\\Icons\\Spell_Nature_Starfall" },
    { key = "kaldorei",     icon = "Interface\\Icons\\Ability_Racial_Shadowmeld" },
    { key = "long_vigil",   icon = "Interface\\Icons\\Ability_EyeOfTheOwl" },
    { key = "kingdoms",     icon = "Interface\\Icons\\INV_Crown_01" },
    { key = "fall_draenor", icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy" },
    { key = "great_wars",   icon = "Interface\\Icons\\Ability_Warrior_WarCry" },
    { key = "present",      icon = "Interface\\Icons\\INV_Misc_Map_01" },
}

-- ============================================================
-- EVENTS
-- ============================================================

IMAGOdb.timeline.events = {

    -- ============ ERA 1: DAWN OF CREATION ============

    ["creation_universe"] = {
        era = "mythos", year = -999999, order = 10,
        related = {
            { type = "codex", slug = "holy_light" },
            { type = "codex", slug = "twisting_nether" },
            { type = "codex", slug = "titans" },
        },
    },

    ["old_gods_come"] = {
        era = "mythos", year = -150000, order = 10,
        related = {
            { type = "codex", slug = "old_gods" },
            { type = "codex", slug = "titans" },
            { type = "timeline", slug = "ordering_azeroth" },
        },
    },

    ["ordering_azeroth"] = {
        era = "mythos", year = -147000, order = 10,
        related = {
            { type = "codex", slug = "titans" },
            { type = "codex", slug = "old_gods" },
            { type = "race",  slug = "dwarf" },
        },
    },

    ["sargeras_fall"] = {
        era = "mythos", year = -50000, order = 10, linkable = true,
        related = {
            { type = "codex",    slug = "burning_legion" },
            { type = "codex",    slug = "titans" },
            { type = "codex",    slug = "twisting_nether" },
            { type = "timeline", slug = "corruption_eredar" },
        },
    },

    ["charge_dragonflights"] = {
        era = "mythos", year = -20285, order = 10,
        related = {
            { type = "codex", slug = "titans" },
        },
    },

    ["aqir_troll_war"] = {
        era = "mythos", year = -16000, order = 10,
        related = {
            { type = "race",  slug = "troll" },
            { type = "codex", slug = "old_gods" },
        },
    },

    ["curse_flesh"] = {
        era = "mythos", year = -15000, order = 10,
        related = {
            { type = "race", slug = "dwarf" },
            { type = "race", slug = "gnome" },
            { type = "race", slug = "human" },
        },
    },

    ["rise_kaldorei"] = {
        era = "mythos", year = -15000, order = 20,
        related = {
            { type = "race",     slug = "night_elf" },
            { type = "codex",    slug = "well_of_eternity" },
            { type = "timeline", slug = "highborne_empire" },
        },
    },

    -- ============ ERA 2: AGE OF THE KALDOREI ============

    ["highborne_empire"] = {
        era = "kaldorei", year = -13500, order = 10,
        related = {
            { type = "codex", slug = "highborne" },
            { type = "codex", slug = "well_of_eternity" },
            { type = "race",  slug = "night_elf" },
        },
    },

    ["corruption_eredar"] = {
        era = "kaldorei", year = -13000, order = 10,
        related = {
            { type = "codex", slug = "burning_legion" },
            { type = "codex", slug = "twisting_nether" },
        },
    },

    ["war_ancients"] = {
        era = "kaldorei", year = -10000, order = 10, linkable = true,
        related = {
            { type = "codex", slug = "burning_legion" },
            { type = "codex", slug = "well_of_eternity" },
            { type = "npc",   slug = "tyrande_whisperwind" },
        },
    },

    ["the_sundering"] = {
        era = "kaldorei", year = -10000, order = 20, linkable = true,
        related = {
            { type = "timeline", slug = "war_ancients" },
            { type = "timeline", slug = "nordrassil_hyjal" },
            { type = "race",     slug = "night_elf" },
        },
    },

    ["nordrassil_hyjal"] = {
        era = "kaldorei", year = -10000, order = 30,
        related = {
            { type = "codex", slug = "well_of_eternity" },
            { type = "codex", slug = "nature" },
            { type = "class", slug = "druid" },
        },
    },

    -- ============ ERA 3: THE LONG VIGIL ============

    ["sentinels_vigil"] = {
        era = "long_vigil", year = -9400, order = 10,
        related = {
            { type = "race", slug = "night_elf" },
            { type = "npc",  slug = "tyrande_whisperwind" },
            { type = "npc",  slug = "shandris_feathermoon" },
        },
    },

    ["war_satyr"] = {
        era = "long_vigil", year = -9300, order = 10,
        related = {
            { type = "race", slug = "night_elf" },
            { type = "codex", slug = "fel" },
            { type = "class", slug = "druid" },
        },
    },

    ["exile_highborne"] = {
        era = "long_vigil", year = -7300, order = 10,
        related = {
            { type = "codex",    slug = "highborne" },
            { type = "codex",    slug = "arcane" },
            { type = "timeline", slug = "founding_quelthalas" },
        },
    },

    ["founding_quelthalas"] = {
        era = "long_vigil", year = -6800, order = 10,
        related = {
            { type = "codex", slug = "highborne" },
            { type = "race",  slug = "undead" },
        },
    },

    ["andrassil_vordrassil"] = {
        era = "long_vigil", year = -4500, order = 10,
        related = {
            { type = "npc",   slug = "fandral_staghelm" },
            { type = "codex", slug = "old_gods" },
            { type = "class", slug = "druid" },
        },
    },

    ["arathor_troll_wars"] = {
        era = "long_vigil", year = -2800, order = 10,
        related = {
            { type = "race", slug = "human" },
            { type = "race", slug = "troll" },
            { type = "codex", slug = "arcane" },
        },
    },

    -- ============ ERA 4: AGE OF MORTAL KINGDOMS ============

    ["council_tirisfal"] = {
        era = "kingdoms", year = -2610, order = 10,
        related = {
            { type = "codex", slug = "guardians_tirisfal" },
            { type = "codex", slug = "burning_legion" },
            { type = "class", slug = "mage" },
        },
    },

    ["awakening_dwarves"] = {
        era = "kingdoms", year = -2500, order = 10,
        related = {
            { type = "race", slug = "dwarf" },
            { type = "race", slug = "gnome" },
            { type = "codex", slug = "titans" },
        },
    },

    ["seven_kingdoms"] = {
        era = "kingdoms", year = -1200, order = 10,
        related = {
            { type = "race", slug = "human" },
            { type = "codex", slug = "kirin_tor" },
        },
    },

    ["war_shifting_sands"] = {
        era = "kingdoms", year = -975, order = 10,
        related = {
            { type = "npc",  slug = "fandral_staghelm" },
            { type = "race", slug = "night_elf" },
            { type = "codex", slug = "old_gods" },
        },
    },

    ["aegwynn_tomb"] = {
        era = "kingdoms", year = -823, order = 10,
        related = {
            { type = "codex",    slug = "guardians_tirisfal" },
            { type = "codex",    slug = "burning_legion" },
            { type = "timeline", slug = "medivh_born" },
        },
    },

    ["orcish_clans"] = {
        era = "kingdoms", year = -800, order = 10,
        related = {
            { type = "race",  slug = "orc" },
            { type = "class", slug = "shaman" },
        },
    },

    ["war_three_hammers"] = {
        era = "kingdoms", year = -230, order = 10,
        related = {
            { type = "race", slug = "dwarf" },
            { type = "npc",  slug = "magni_bronzebeard" },
        },
    },

    ["draenei_draenor"] = {
        era = "kingdoms", year = -200, order = 10,
        related = {
            { type = "codex", slug = "holy_light" },
            { type = "race",  slug = "orc" },
        },
    },

    ["gurubashi_war"] = {
        era = "kingdoms", year = -18, order = 10,
        related = {
            { type = "race", slug = "troll" },
            { type = "race", slug = "human" },
        },
    },

    -- ============ ERA 5: THE FALL OF DRAENOR ============

    ["medivh_born"] = {
        era = "fall_draenor", year = -45, order = 10,
        related = {
            { type = "codex",    slug = "guardians_tirisfal" },
            { type = "timeline", slug = "aegwynn_tomb" },
            { type = "timeline", slug = "dark_portal_opens" },
        },
    },

    ["guldan_fel"] = {
        era = "fall_draenor", year = -10, order = 10,
        related = {
            { type = "codex", slug = "fel" },
            { type = "codex", slug = "burning_legion" },
            { type = "class", slug = "warlock" },
        },
    },

    ["horde_forms"] = {
        era = "fall_draenor", year = -8, order = 10,
        related = {
            { type = "race",  slug = "orc" },
            { type = "codex", slug = "burning_legion" },
        },
    },

    ["draenei_genocide"] = {
        era = "fall_draenor", year = -7, order = 10,
        related = {
            { type = "timeline", slug = "draenei_draenor" },
            { type = "race",     slug = "orc" },
            { type = "codex",    slug = "fel" },
        },
    },

    ["shadow_council"] = {
        era = "fall_draenor", year = -6, order = 10,
        related = {
            { type = "codex", slug = "fel" },
            { type = "class", slug = "warlock" },
            { type = "timeline", slug = "guldan_fel" },
        },
    },

    ["blood_mannoroth"] = {
        era = "fall_draenor", year = -3, order = 10,
        related = {
            { type = "codex", slug = "fel" },
            { type = "race",  slug = "orc" },
            { type = "timeline", slug = "third_war" },
        },
    },

    ["shattrath_falls"] = {
        era = "fall_draenor", year = -3, order = 20,
        related = {
            { type = "timeline", slug = "draenei_genocide" },
            { type = "race",     slug = "orc" },
        },
    },

    ["dark_portal_built"] = {
        era = "fall_draenor", year = -1, order = 10,
        related = {
            { type = "timeline", slug = "medivh_born" },
            { type = "timeline", slug = "dark_portal_opens" },
        },
    },

    -- ============ ERA 6: THE GREAT WARS ============

    ["dark_portal_opens"] = {
        era = "great_wars", year = 0, order = 10, linkable = true,
        related = {
            { type = "race",     slug = "orc" },
            { type = "timeline", slug = "first_war" },
        },
    },

    ["first_war"] = {
        era = "great_wars", year = 0, order = 20,
        related = {
            { type = "race", slug = "human" },
            { type = "race", slug = "orc" },
        },
    },

    ["fall_stormwind"] = {
        era = "great_wars", year = 3, order = 10,
        related = {
            { type = "race",     slug = "human" },
            { type = "codex",    slug = "guardians_tirisfal" },
            { type = "timeline", slug = "alliance_lordaeron" },
        },
    },

    ["alliance_lordaeron"] = {
        era = "great_wars", year = 5, order = 10,
        related = {
            { type = "race",  slug = "human" },
            { type = "race",  slug = "dwarf" },
            { type = "race",  slug = "gnome" },
            { type = "class", slug = "paladin" },
        },
    },

    ["second_war"] = {
        era = "great_wars", year = 5, order = 20,
        related = {
            { type = "race",  slug = "orc" },
            { type = "race",  slug = "human" },
            { type = "race",  slug = "troll" },
            { type = "class", slug = "paladin" },
        },
    },

    ["siege_blackrock"] = {
        era = "great_wars", year = 6, order = 10,
        related = {
            { type = "timeline", slug = "dark_portal_opens" },
            { type = "race",     slug = "orc" },
            { type = "race",     slug = "human" },
        },
    },

    ["invasion_draenor"] = {
        era = "great_wars", year = 8, order = 10,
        related = {
            { type = "timeline", slug = "dark_portal_opens" },
            { type = "timeline", slug = "birth_lich_king" },
        },
    },

    ["birth_lich_king"] = {
        era = "great_wars", year = 8, order = 20,
        related = {
            { type = "codex", slug = "lich_king" },
            { type = "codex", slug = "scourge" },
            { type = "codex", slug = "burning_legion" },
        },
    },

    ["grim_batol"] = {
        era = "great_wars", year = 10, order = 10, linkable = true,
        related = {
            { type = "timeline", slug = "second_war" },
            { type = "race",     slug = "dwarf" },
            { type = "race",     slug = "orc" },
        },
    },

    ["thrall_new_horde"] = {
        era = "great_wars", year = 15, order = 10,
        related = {
            { type = "npc",   slug = "thrall" },
            { type = "race",  slug = "orc" },
            { type = "class", slug = "shaman" },
        },
    },

    ["third_war"] = {
        era = "great_wars", year = 20, order = 10,
        related = {
            { type = "codex", slug = "scourge" },
            { type = "codex", slug = "lich_king" },
            { type = "race",  slug = "undead" },
            { type = "npc",   slug = "sylvanas_windrunner" },
        },
    },

    ["battle_hyjal"] = {
        era = "great_wars", year = 21, order = 10,
        related = {
            { type = "npc",  slug = "thrall" },
            { type = "npc",  slug = "jaina_proudmoore" },
            { type = "npc",  slug = "tyrande_whisperwind" },
            { type = "codex", slug = "burning_legion" },
        },
    },

    -- ============ ERA 7: THE PRESENT AGE ============

    ["ascension_lich_king"] = {
        era = "present", year = 22, order = 10,
        related = {
            { type = "codex", slug = "lich_king" },
            { type = "codex", slug = "scourge" },
            { type = "npc",   slug = "bolvar_fordragon" },
        },
    },

    ["forsaken_rise"] = {
        era = "present", year = 22, order = 20,
        related = {
            { type = "codex", slug = "forsaken_people" },
            { type = "race",  slug = "undead" },
            { type = "npc",   slug = "sylvanas_windrunner" },
        },
    },

    ["teldrassil"] = {
        era = "present", year = 23, order = 10,
        related = {
            { type = "race", slug = "night_elf" },
            { type = "npc",  slug = "fandral_staghelm" },
            { type = "npc",  slug = "tyrande_whisperwind" },
        },
    },

    ["durotar_founded"] = {
        era = "present", year = 23, order = 20,
        related = {
            { type = "npc",  slug = "thrall" },
            { type = "race", slug = "orc" },
            { type = "race", slug = "troll" },
            { type = "race", slug = "tauren" },
        },
    },

    ["forsaken_horde"] = {
        era = "present", year = 23, order = 30,
        related = {
            { type = "codex", slug = "forsaken_people" },
            { type = "npc",   slug = "sylvanas_windrunner" },
            { type = "race",  slug = "undead" },
        },
    },

    ["cycle_hatred"] = {
        era = "present", year = 24, order = 10,
        related = {
            { type = "race", slug = "human" },
            { type = "race", slug = "orc" },
            { type = "npc",  slug = "jaina_proudmoore" },
            { type = "npc",  slug = "thrall" },
        },
    },

    ["scourge_invasion"] = {
        era = "present", year = 25, order = 10,
        related = {
            { type = "codex", slug = "scourge" },
            { type = "codex", slug = "lich_king" },
            { type = "npc",   slug = "tirion_fordring" },
        },
    },
}

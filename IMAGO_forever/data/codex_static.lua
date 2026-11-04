-- ============================================================
-- IMAGO Forever — data/codex_static.lua (static data)
-- Codex: curated lore lexicon. No unlocks, no progress — every
-- entry is always readable. Categories define the sidebar; each
-- entry belongs to exactly one category and is sorted by `order`.
--
-- Related-entry chips are fully automatic: the detail view shows
-- every entry the body text links to (TextLinker.FindReferences)
-- plus every entry whose texts link back (TextLinker.GetBacklinks).
-- There are no curated related lists in this file.
--
-- linkable = true adds the entry's title (and locale `aliases`)
-- to the TextLinker lookup so lore texts auto-link to it.
-- Only set for unambiguous proper nouns.
--
-- stub = true marks entries whose body is still a placeholder —
-- the entry list renders them dimmed.
--
-- Localized text (title, body, aliases) lives in
-- locales/base/data/codex.lua (+ locale overrides).
-- Category icons are placeholders — swap the `icon` fields once
-- final FileIDs are supplied.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.codex = IMAGOdb.codex or {}

-- ============================================================
-- CATEGORIES (sidebar, fixed order)
-- ============================================================

IMAGOdb.codex.categories = {
    { key = "cosmos", icon = "Interface\\Icons\\Spell_Arcane_StarFire" },
    { key = "magic", icon = "Interface\\Icons\\Spell_Arcane_Blink" },
    { key = "worlds", icon = "Interface\\Icons\\INV_Misc_Map02" },
    { key = "sites", icon = "Interface\\Icons\\INV_Misc_Rune_06" },
    { key = "peoples", icon = "Interface\\Icons\\INV_Misc_GroupLooking" },
    { key = "factions", icon = "Interface\\Icons\\INV_BannerPVP_02" },
    { key = "artifacts", icon = "Interface\\Icons\\INV_Sword_39" },
    { key = "concepts", icon = "Interface\\Icons\\INV_Misc_Book_09" },
}

-- ============================================================
-- ENTRIES
-- ============================================================

IMAGOdb.codex.entries = {

    -- ============ COSMOS ============

    ["cosmic_forces"] = {
        category = "cosmos", order = 10, linkable = true,
    },

    ["holy_light"] = {
        category = "cosmos", order = 20, linkable = false,
    },

    ["void"] = {
        category = "cosmos", order = 30, linkable = false,
    },

    ["life"] = {
        category = "cosmos", order = 40, linkable = false,
    },

    ["death"] = {
        category = "cosmos", order = 50, linkable = false,
    },

    ["great_dark_beyond"] = {
        category = "cosmos", order = 60, linkable = true,
    },

    ["twisting_nether"] = {
        category = "cosmos", order = 70, linkable = true,
    },

    ["world_souls"] = {
        category = "cosmos", order = 80, linkable = true,
    },

    ["titans"] = {
        category = "cosmos", order = 90, linkable = true,
    },

    ["pantheon"] = {
        category = "cosmos", order = 100, linkable = true,
    },

    ["void_lords"] = {
        category = "cosmos", order = 110, linkable = true,
    },

    ["old_gods"] = {
        category = "cosmos", order = 120, linkable = true,
    },

    ["emerald_dream"] = {
        category = "cosmos", order = 130, linkable = true,
    },

    ["emerald_nightmare"] = {
        category = "cosmos", order = 140, linkable = true,
    },

    ["shadowlands"] = {
        category = "cosmos", order = 150, linkable = false,
    },

    ["elements"] = {
        category = "cosmos", order = 160, linkable = false,
    },

    ["elemental_lords"] = {
        category = "cosmos", order = 170, linkable = true,
    },

    ["elemental_plane"] = {
        category = "cosmos", order = 180, linkable = true,
    },

    -- ============ MAGIC ============

    ["arcane"] = {
        category = "cosmos", order = 52, linkable = false,
    },

    ["fel"] = {
        category = "cosmos", order = 54, linkable = true,
    },

    ["church_holy_light"] = {
        category = "magic", order = 30, linkable = true,
    },

    ["druids"] = {
        category = "magic", order = 40, linkable = false,
    },

    ["shamanism"] = {
        category = "magic", order = 50, linkable = false,
    },

    ["necromancy"] = {
        category = "magic", order = 60, linkable = false,
    },

    ["council_of_tirisfal"] = {
        category = "magic", order = 70, linkable = true,
    },

    ["guardians_tirisfal"] = {
        category = "magic", order = 80, linkable = true,
    },

    ["plague_of_undeath"] = {
        category = "magic", order = 90, linkable = true,
    },

    ["elune"] = {
        category = "magic", order = 100, linkable = true,
    },

    ["earth_mother"] = {
        category = "magic", order = 110, linkable = true,
    },

    ["anshe"] = {
        category = "magic", order = 120, linkable = true,
    },

    -- ============ WORLDS ============

    ["azeroth"] = {
        category = "worlds", order = 10, linkable = false,
    },

    ["kalimdor"] = {
        category = "worlds", order = 20, linkable = true, stub = true,
    },

    ["eastern_kingdoms"] = {
        category = "worlds", order = 30, linkable = true, stub = true,
    },

    ["northrend"] = {
        category = "worlds", order = 40, linkable = true, stub = true,
    },

    ["draenor"] = {
        category = "worlds", order = 50, linkable = true, stub = true,
    },

    ["argus"] = {
        category = "worlds", order = 60, linkable = true,
    },

    ["karesh"] = {
        category = "worlds", order = 70, linkable = true, stub = true,
    },

    ["well_of_eternity"] = {
        category = "worlds", order = 80, linkable = true,
    },

    ["maelstrom"] = {
        category = "worlds", order = 90, linkable = true,
    },

    ["dark_portal"] = {
        category = "worlds", order = 100, linkable = true,
    },

    ["world_trees"] = {
        category = "worlds", order = 110, linkable = true,
    },

    ["moonwells"] = {
        category = "worlds", order = 120, linkable = true,
    },

    ["ley_lines"] = {
        category = "worlds", order = 130, linkable = true,
    },

    -- ============ SITES ============

    ["tomb_of_sargeras"] = {
        category = "sites", order = 10, linkable = true, stub = true,
    },

    ["forge_of_wills"] = {
        category = "sites", order = 20, linkable = true, stub = true,
    },

    -- ============ PEOPLES ============

    ["earthen"] = {
        category = "peoples", order = 10, linkable = true,
    },

    ["vrykul"] = {
        category = "peoples", order = 20, linkable = true,
    },

    ["mechagnomes"] = {
        category = "peoples", order = 30, linkable = true,
    },

    ["tolvir"] = {
        category = "peoples", order = 40, linkable = true, stub = true,
    },

    ["anubisath_giants"] = {
        category = "peoples", order = 50, linkable = true, stub = true,
    },

    ["naga"] = {
        category = "peoples", order = 60, linkable = true,
    },

    ["murlocs"] = {
        category = "peoples", order = 70, linkable = true,
    },

    ["makrura"] = {
        category = "peoples", order = 80, linkable = true,
    },

    ["kobolds"] = {
        category = "peoples", order = 90, linkable = true,
    },

    ["gnolls"] = {
        category = "peoples", order = 100, linkable = true,
    },

    ["troggs"] = {
        category = "peoples", order = 110, linkable = true,
    },

    ["ogres"] = {
        category = "peoples", order = 120, linkable = true,
    },

    ["furbolgs"] = {
        category = "peoples", order = 130, linkable = true,
    },

    ["harpies"] = {
        category = "peoples", order = 140, linkable = true,
    },

    ["centaurs"] = {
        category = "peoples", order = 150, linkable = true,
    },

    ["quilboar"] = {
        category = "peoples", order = 160, linkable = true,
    },

    ["wolvar"] = {
        category = "peoples", order = 170, linkable = true, stub = true,
    },

    ["taunka"] = {
        category = "peoples", order = 180, linkable = true, stub = true,
    },

    ["tuskarr"] = {
        category = "peoples", order = 190, linkable = true, stub = true,
    },

    ["arakkoa"] = {
        category = "peoples", order = 200, linkable = true, stub = true,
    },

    ["ethereals"] = {
        category = "peoples", order = 210, linkable = true, stub = true,
    },

    ["magnataurs"] = {
        category = "peoples", order = 220, linkable = true, stub = true,
    },

    ["high_elves"] = {
        category = "peoples", order = 230, linkable = true,
    },

    ["bogstroks"] = {
        category = "peoples", order = 240, linkable = true, stub = true,
    },

    ["highborne"] = {
        category = "peoples", order = 250, linkable = true,
    },

    ["zandalari"] = {
        category = "peoples", order = 260, linkable = true, stub = true,
    },

    ["gurubashi_empire"] = {
        category = "peoples", order = 270, linkable = true, stub = true,
    },

    ["amani_empire"] = {
        category = "peoples", order = 280, linkable = true, stub = true,
    },

    ["drakkari"] = {
        category = "peoples", order = 290, linkable = true, stub = true,
    },

    ["fel_orcs"] = {
        category = "peoples", order = 300, linkable = true, stub = true,
    },

    ["naaru"] = {
        category = "peoples", order = 310, linkable = true, stub = true,
    },

    ["eredar"] = {
        category = "peoples", order = 320, linkable = true, stub = true,
    },

    ["nathrezim"] = {
        category = "peoples", order = 330, linkable = true, stub = true,
    },

    ["annihilan"] = {
        category = "peoples", order = 340, linkable = true, stub = true,
    },

    ["felguards"] = {
        category = "peoples", order = 350, linkable = true, stub = true,
    },

    ["shivarra"] = {
        category = "peoples", order = 360, linkable = true, stub = true,
    },

    ["wrathguard"] = {
        category = "peoples", order = 370, linkable = true, stub = true,
    },

    ["infernal"] = {
        category = "peoples", order = 380, linkable = true, stub = true,
    },

    ["fel_reavers"] = {
        category = "peoples", order = 390, linkable = true, stub = true,
    },

    ["satyrs"] = {
        category = "peoples", order = 400, linkable = true,
    },

    ["constructs"] = {
        category = "peoples", order = 410, linkable = true, stub = true,
    },

    ["dragonflights"] = {
        category = "peoples", order = 420, linkable = true,
    },

    ["black_dragonflight"] = {
        category = "peoples", order = 430, linkable = true,
    },

    ["red_dragonflight"] = {
        category = "peoples", order = 440, linkable = true,
    },

    ["blue_dragonflight"] = {
        category = "peoples", order = 450, linkable = true,
    },

    ["green_dragonflight"] = {
        category = "peoples", order = 460, linkable = true,
    },

    ["bronze_dragonflight"] = {
        category = "peoples", order = 470, linkable = true,
    },

    ["aspects"] = {
        category = "peoples", order = 480, linkable = true, stub = true,
    },

    ["proto_dragons"] = {
        category = "peoples", order = 490, linkable = true, stub = true,
    },

    ["wild_gods"] = {
        category = "peoples", order = 500, linkable = true,
    },

    ["loa"] = {
        category = "peoples", order = 510, linkable = false,
    },

    ["august_celestials"] = {
        category = "peoples", order = 520, linkable = true, stub = true,
    },

    ["ancients"] = {
        category = "peoples", order = 530, linkable = true, stub = true,
    },

    ["demigods"] = {
        category = "peoples", order = 540, linkable = true, stub = true,
    },

    ["dryads"] = {
        category = "peoples", order = 550, linkable = true,
    },

    ["wildkin"] = {
        category = "peoples", order = 560, linkable = true,
    },

    ["scourge"] = {
        category = "peoples", order = 570, linkable = true,
    },

    ["lich_king"] = {
        category = "peoples", order = 580, linkable = true,
    },

    ["banshees"] = {
        category = "peoples", order = 590, linkable = true, stub = true,
    },

    ["valkyr"] = {
        category = "peoples", order = 600, linkable = true, stub = true,
    },

    ["qiraji"] = {
        category = "peoples", order = 610, linkable = true,
    },

    ["nerubians"] = {
        category = "peoples", order = 620, linkable = true,
    },

    ["silithid"] = {
        category = "peoples", order = 630, linkable = true,
    },

    -- ============ FACTIONS ============

    ["alliance"] = {
        category = "factions", order = 10, linkable = true,
    },

    ["horde"] = {
        category = "factions", order = 20, linkable = true,
    },

    ["alliance_of_lordaeron"] = {
        category = "factions", order = 30, linkable = true,
    },

    ["old_horde"] = {
        category = "factions", order = 40, linkable = true,
    },

    ["burning_legion"] = {
        category = "factions", order = 50, linkable = true,
    },

    ["shadow_council"] = {
        category = "factions", order = 60, linkable = true, stub = true,
    },

    ["cult_of_the_damned"] = {
        category = "factions", order = 70, linkable = true, stub = true,
    },

    ["twilights_hammer"] = {
        category = "factions", order = 80, linkable = true,
    },

    ["hour_of_twilight"] = {
        category = "factions", order = 90, linkable = true,
    },

    ["kirin_tor"] = {
        category = "factions", order = 100, linkable = true,
    },

    ["order_of_the_silver_hand"] = {
        category = "factions", order = 110, linkable = true,
    },

    ["argent_dawn"] = {
        category = "factions", order = 120, linkable = true,
    },

    ["brotherhood_of_the_light"] = {
        category = "factions", order = 130, linkable = true,
    },

    ["cenarion_circle"] = {
        category = "factions", order = 140, linkable = true, stub = true,
    },

    ["earthen_ring"] = {
        category = "factions", order = 150, linkable = true,
    },

    ["scarlet_crusade"] = {
        category = "factions", order = 160, linkable = true,
    },

    ["explorers_league"] = {
        category = "factions", order = 170, linkable = true, stub = true,
    },

    ["si7"] = {
        category = "factions", order = 180, linkable = true, stub = true,
    },

    ["royal_apothecary_society"] = {
        category = "factions", order = 190, linkable = true, stub = true,
    },

    ["elder_council"] = {
        category = "factions", order = 200, linkable = true, stub = true,
    },

    ["kaldorei_empire"] = {
        category = "factions", order = 210, linkable = true, stub = true,
    },

    ["arathor_empire"] = {
        category = "factions", order = 220, linkable = true, stub = true,
    },

    ["seven_kingdoms"] = {
        category = "factions", order = 230, linkable = true, stub = true,
    },

    ["empire_of_zul"] = {
        category = "factions", order = 240, linkable = true, stub = true,
    },

    ["shadowmoon_clan"] = {
        category = "factions", order = 250, linkable = true, stub = true,
    },

    ["frostwolf_clan"] = {
        category = "factions", order = 260, linkable = true, stub = true,
    },

    ["warsong_clan"] = {
        category = "factions", order = 270, linkable = true, stub = true,
    },

    ["blackrock_clan"] = {
        category = "factions", order = 280, linkable = true, stub = true,
    },

    ["bleeding_hollow_clan"] = {
        category = "factions", order = 290, linkable = true, stub = true,
    },

    ["burning_blade_clan"] = {
        category = "factions", order = 300, linkable = true, stub = true,
    },

    ["dragonmaw_clan"] = {
        category = "factions", order = 310, linkable = true, stub = true,
    },

    ["shattered_hand_clan"] = {
        category = "factions", order = 320, linkable = true, stub = true,
    },

    ["grimtotem_clan"] = {
        category = "factions", order = 330, linkable = true, stub = true,
    },

    ["black_empire"] = {
        category = "factions", order = 340, linkable = true,
    },

    -- ============ ARTIFACTS ============

    ["ashbringer"] = {
        category = "artifacts", order = 10, linkable = true, stub = true,
    },

    ["frostmourne"] = {
        category = "artifacts", order = 20, linkable = true, stub = true,
    },

    ["doomhammer"] = {
        category = "artifacts", order = 30, linkable = true, stub = true,
    },

    ["gorehowl"] = {
        category = "artifacts", order = 40, linkable = true, stub = true,
    },

    ["atiesh"] = {
        category = "artifacts", order = 50, linkable = true, stub = true,
    },

    ["sulfuras"] = {
        category = "artifacts", order = 60, linkable = true, stub = true,
    },

    ["dragon_soul"] = {
        category = "artifacts", order = 70, linkable = true, stub = true,
    },

    ["skull_of_guldan"] = {
        category = "artifacts", order = 80, linkable = true,
    },

    ["eye_of_sargeras"] = {
        category = "artifacts", order = 90, linkable = true, stub = true,
    },

    ["book_of_medivh"] = {
        category = "artifacts", order = 100, linkable = true, stub = true,
    },

    ["horn_of_cenarius"] = {
        category = "artifacts", order = 110, linkable = true, stub = true,
    },

    ["discs_of_norgannon"] = {
        category = "artifacts", order = 120, linkable = true, stub = true,
    },

    -- ============ CONCEPTS ============

    ["curse_of_flesh"] = {
        category = "concepts", order = 10, linkable = true,
    },

    ["warchief"] = {
        category = "concepts", order = 20, linkable = true, stub = true,
    },

    ["dragon_queen"] = {
        category = "concepts", order = 30, linkable = true, stub = true,
    },

    ["keepers"] = {
        category = "concepts", order = 40, linkable = true, stub = true,
    },

    ["makgora"] = {
        category = "concepts", order = 50, linkable = true, stub = true,
    },

    ["technology"] = {
        category = "concepts", order = 60, linkable = false, stub = true,
    },

    ["ancestor_loa_worship"] = {
        category = "concepts", order = 70, linkable = true, stub = true,
    },

}

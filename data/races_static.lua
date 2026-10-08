-- ============================================================
-- IMAGO Forever — data/races_static.lua  (static data)
-- Playable race records: leaderID = creature ID used for the
-- Figures-tab model; mountID/epicMountID = creature IDs of the
-- racial mounts shown stacked in the Culture tab (hidden if nil).
-- iconM/iconF = race icon FileIDs (portraits), tabard = race tabard.
-- figures = array of { slug = <npc slug> } (links to Fates) or
-- { key = <localized key> } (plain text entry).
-- settlements = array of uiMapIDs (link activates once the zone
-- exists in IMAGOdb.zones); names/lore are localized.
-- groups = array of keys; texts live in locales.
-- Localized texts (name, history, culture, groups, figures,
-- settlements) live in locales/<locale>/data/races.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

IMAGOdb.races["human"] = {
    iconM = 236448, -- race icon FileID (male)
    iconF = 236447, -- race icon FileID (female)
    tabard = 255150, -- race tabard FileID
    mountID = 307,       -- racial mount (creature ID)
    epicMountID = 14560,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 1748, -- Highlord Bolvar Fordragon
    figures = {
        { slug = "bolvar_fordragon" },
        { slug = "anduin_wrynn" },
        { slug = "jaina_proudmoore" },
        { slug = "tirion_fordring" },
        { key = "katrana_prestor" },
    },
    settlements = { 84, 37 }, -- Stormwind City, Elwynn Forest
    groups = { "stormwind", "theramore", "lords_of_lordaeron" },
}

IMAGOdb.races["dwarf"] = {
    iconM = 236444, -- race icon FileID (male)
    iconF = 236443, -- race icon FileID (female)
    tabard = 255148, -- race tabard FileID
    mountID = 4779,       -- racial mount (creature ID)
    epicMountID = 14547,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 2784, -- King Magni Bronzebeard
    figures = {
        { slug = "magni_bronzebeard" },
        { key = "moira_bronzebeard" },
        { key = "brann_bronzebeard" },
    },
    settlements = { 87, 27 }, -- Ironforge, Dun Morogh
    groups = { "bronzebeard_clan", "wildhammer_clan", "dark_iron_clan" },
}

IMAGOdb.races["gnome"] = {
    iconM = 236446, -- race icon FileID (male)
    iconF = 236445, -- race icon FileID (female)
    tabard = 255149, -- race tabard FileID
    mountID = 7739,       -- racial mount (creature ID)
    epicMountID = 14552,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 7937, -- High Tinker Mekkatorque
    figures = {
        { slug = "mekkatorque" },
        { key = "sicco_thermaplugg" },
    },
    settlements = { 27 }, -- Dun Morogh (Tinker Town, Ironforge)
    groups = { "survivors_of_gnomeregan" },
}

IMAGOdb.races["night_elf"] = {
    iconM = 236450, -- race icon FileID (male)
    iconF = 236449, -- race icon FileID (female)
    tabard = 255151, -- race tabard FileID
    mountID = 7690,       -- racial mount (creature ID)
    epicMountID = 14602,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 7999, -- Tyrande Whisperwind
    figures = {
        { slug = "tyrande_whisperwind" },
        { slug = "shandris_feathermoon" },
        { slug = "fandral_staghelm" },
        { key = "malfurion_stormrage" },
    },
    settlements = { 89, 57 }, -- Darnassus, Teldrassil
    groups = { "sentinels", "sisterhood_of_elune" },
}

-- ============================================================
-- HORDE
-- ============================================================

IMAGOdb.races["orc"] = {
    iconM = 236452, -- race icon FileID (male)
    iconF = 236451, -- race icon FileID (female)
    tabard = 255152, -- race tabard FileID
    mountID = 358,       -- racial mount (creature ID)
    epicMountID = 14539,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 4949, -- Thrall
    figures = {
        { slug = "thrall" },
        { slug = "rexxar" },
        { key = "eitrigg" },
    },
    settlements = { 85, 1 }, -- Orgrimmar, Durotar
    groups = { "frostwolf_clan", "warsong_clan" },
}

IMAGOdb.races["troll"] = {
    iconM = 236456, -- race icon FileID (male)
    iconF = 236455, -- race icon FileID (female)
    tabard = 255154, -- race tabard FileID
    mountID = 6075,       -- racial mount (creature ID)
    epicMountID = 14543,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 10540, -- Vol'jin
    figures = {
        { slug = "voljin" },
        { key = "senjin" },
    },
    settlements = { 1 }, -- Durotar (Echo Isles)
    groups = { "darkspear_tribe", "shadow_hunters" },
}

IMAGOdb.races["undead"] = {
    iconM = 236458, -- race icon FileID (male)
    iconF = 236457, -- race icon FileID (female)
    tabard = 456569, -- race tabard FileID
    mountID = 11153,       -- racial mount (creature ID)
    epicMountID = 14558,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 10181, -- Lady Sylvanas Windrunner
    figures = {
        { slug = "sylvanas_windrunner" },
        { slug = "varimathras" },
        { key = "master_apothecary_faranell" },
    },
    settlements = { 18 }, -- Tirisfal Glades (Undercity)
    groups = { "royal_apothecary_society", "deathguards" },
}

IMAGOdb.races["tauren"] = {
    iconM = 236454, -- race icon FileID (male)
    iconF = 236453, -- race icon FileID (female)
    tabard = 255153, -- race tabard FileID
    mountID = 12149,       -- racial mount (creature ID)
    epicMountID = 14542,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 3057, -- Cairne Bloodhoof
    figures = {
        { slug = "cairne_bloodhoof" },
        { key = "baine_bloodhoof" },
        { key = "magatha_grimtotem" },
    },
    settlements = { 88, 7 }, -- Thunder Bluff, Mulgore
    groups = { "bloodhoof_tribe", "grimtotem_tribe" },
}

-- ============================================================
-- BOTH FACTIONS (WoW Forever exclusive)
-- ============================================================

IMAGOdb.races["skyborne"] = {
    alignment = "Both", -- playable on Alliance and Horde
    isNew = true, -- WoW Forever exclusive race
    figures = {},
    settlements = {},
    groups = {},
}

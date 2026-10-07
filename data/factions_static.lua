-- ============================================================
-- IMAGO Forever — data/factions_static.lua  (static data)
-- Faction records: leaderID = creature ID used for the leader
-- model, mountID optional (racial mount model, hidden if nil).
-- members = array of { slug = <npc slug> } (links to Fates) or
-- { key = <localized key> } (plain text entry).
-- settlements = array of uiMapIDs (link activates once the zone
-- exists in IMAGOdb.zones); names/lore are localized.
-- subgroups = array of keys; texts live in locales.
-- Localized texts (name, history, culture, subgroups, members,
-- settlements) live in locales/<locale>/data/factions.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.factions = IMAGOdb.factions or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

IMAGOdb.factions["kingdom_of_stormwind"] = {
    alignment = "Alliance",
    leaderID = 1748, -- Highlord Bolvar Fordragon
    members = {
        { slug = "bolvar_fordragon" },
        { slug = "anduin_wrynn" },
        { key = "katrana_prestor" },
    },
    settlements = { 84 }, -- Stormwind City
    subgroups = { "house_of_nobles", "westfall_brigade", "si7" },
}

IMAGOdb.factions["ironforge_dwarves"] = {
    alignment = "Alliance",
    leaderID = 2784, -- King Magni Bronzebeard
    members = {
        { slug = "magni_bronzebeard" },
        { key = "moira_bronzebeard" },
        { key = "brann_bronzebeard" },
    },
    settlements = { 87 }, -- Ironforge
    subgroups = { "bronzebeard_clan", "explorers_league" },
}

IMAGOdb.factions["gnomeregan_exiles"] = {
    alignment = "Alliance",
    leaderID = 7937, -- High Tinker Mekkatorque
    members = {
        { slug = "mekkatorque" },
        { key = "sicco_thermaplugg" },
    },
    settlements = { 27 }, -- Dun Morogh (Tinker Town, Ironforge)
    subgroups = { "survivors_of_gnomeregan" },
}

IMAGOdb.factions["darnassus_night_elves"] = {
    alignment = "Alliance",
    leaderID = 7999, -- Tyrande Whisperwind
    members = {
        { slug = "tyrande_whisperwind" },
        { slug = "shandris_feathermoon" },
        { key = "malfurion_stormrage" },
    },
    settlements = { 89, 57 }, -- Darnassus, Teldrassil
    subgroups = { "sentinels", "sisterhood_of_elune" },
}

IMAGOdb.factions["theramore"] = {
    alignment = "Alliance",
    leaderID = 4968, -- Lady Jaina Proudmoore
    members = {
        { slug = "jaina_proudmoore" },
    },
    settlements = { 70 }, -- Dustwallow Marsh
    subgroups = { "theramore_guard" },
}

-- ============================================================
-- HORDE
-- ============================================================

IMAGOdb.factions["orcs_of_the_horde"] = {
    alignment = "Horde",
    leaderID = 4949, -- Thrall
    members = {
        { slug = "thrall" },
        { slug = "rexxar" },
        { key = "eitrigg" },
    },
    settlements = { 85, 1 }, -- Orgrimmar, Durotar
    subgroups = { "frostwolf_clan", "warsong_clan" },
}

IMAGOdb.factions["darkspear_trolls"] = {
    alignment = "Horde",
    leaderID = 10540, -- Vol'jin
    members = {
        { slug = "voljin" },
        { key = "senjin" },
    },
    settlements = { 1 }, -- Durotar (Echo Isles)
    subgroups = { "darkspear_shadow_hunters" },
}

IMAGOdb.factions["the_forsaken"] = {
    alignment = "Horde",
    leaderID = 10181, -- Lady Sylvanas Windrunner
    members = {
        { slug = "sylvanas_windrunner" },
        { slug = "varimathras" },
        { key = "master_apothecary_faranell" },
    },
    settlements = { 18 }, -- Tirisfal Glades (Undercity)
    subgroups = { "royal_apothecary_society", "deathguards" },
}

IMAGOdb.factions["thunder_bluff_tauren"] = {
    alignment = "Horde",
    leaderID = 3057, -- Cairne Bloodhoof
    members = {
        { slug = "cairne_bloodhoof" },
        { key = "baine_bloodhoof" },
        { key = "magatha_grimtotem" },
    },
    settlements = { 88, 7 }, -- Thunder Bluff, Mulgore
    subgroups = { "bloodhoof_tribe", "grimtotem_tribe" },
}

-- ============================================================
-- OTHERS
-- ============================================================

IMAGOdb.factions["cenarion_circle"] = {
    alignment = "Neutral",
    leaderID = 3516, -- Arch Druid Fandral Staghelm
    members = {
        { slug = "fandral_staghelm" },
        { key = "malfurion_stormrage" },
    },
    settlements = { 80 }, -- Moonglade
    subgroups = { "keepers_of_the_grove", "druids_of_the_circle" },
}

IMAGOdb.factions["argent_dawn"] = {
    alignment = "Neutral",
    leaderID = 1855, -- Tirion Fordring
    members = {
        { slug = "tirion_fordring" },
        { key = "lord_maxwell_tyrosus" },
    },
    settlements = { 23 }, -- Eastern Plaguelands (Light's Hope Chapel)
    subgroups = { "brotherhood_of_the_light" },
}

IMAGOdb.factions["goblin_cartels"] = {
    alignment = "Neutral",
    leaderID = 3391, -- Gazlowe
    members = {
        { slug = "gazlowe" },
        { key = "baron_revilgaz" },
    },
    settlements = { 11, 71 }, -- The Barrens (Ratchet), Tanaris (Gadgetzan)
    subgroups = { "steamwheedle_cartel", "booty_bay" },
}

IMAGOdb.factions["skyborne"] = {
    alignment = "Neutral",
    isNew = true, -- WoW Forever exclusive race
    members = {},
    settlements = {},
    subgroups = {},
}

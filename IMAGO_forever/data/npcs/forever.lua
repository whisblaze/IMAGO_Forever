-- ============================================================
-- IMAGO Forever — data/npcs/forever.lua  (static data)
-- NPC records: ids = creature IDs used for detection,
-- displayID optional (falls back to ids[1] for the 3D model).
-- Localized texts (name, race, lore, zones, source, timeline)
-- live in locales/<locale>/data/npcs/forever_npcs.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.npcs = IMAGOdb.npcs or {}

-- Alliance
IMAGOdb.npcs.CAT_KINGDOM_STORMWIND      = IMAGOdb.npcs.CAT_KINGDOM_STORMWIND   or {}
IMAGOdb.npcs.CAT_DWARVES_IRONFORGE      = IMAGOdb.npcs.CAT_DWARVES_IRONFORGE   or {}
IMAGOdb.npcs.CAT_GNOMEREGAN_EXILES      = IMAGOdb.npcs.CAT_GNOMEREGAN_EXILES or {}
IMAGOdb.npcs.CAT_NIGHT_ELVES_DARNASSUS  = IMAGOdb.npcs.CAT_NIGHT_ELVES_DARNASSUS   or {}
IMAGOdb.npcs.CAT_THERAMORE              = IMAGOdb.npcs.CAT_THERAMORE   or {}
IMAGOdb.npcs.CAT_WILDHAMMER_CLAN        = IMAGOdb.npcs.CAT_WILDHAMMER_CLAN  or {}
-- Horde
IMAGOdb.npcs.CAT_ORCS_HORDE             = IMAGOdb.npcs.CAT_ORCS_HORDE        or {}
IMAGOdb.npcs.CAT_DARKSPEAR_TROLLS       = IMAGOdb.npcs.CAT_DARKSPEAR_TROLLS   or {}
IMAGOdb.npcs.CAT_FORSAKEN               = IMAGOdb.npcs.CAT_FORSAKEN    or {}
IMAGOdb.npcs.CAT_TAUREN_THUNDER_BLUFF   = IMAGOdb.npcs.CAT_TAUREN_THUNDER_BLUFF or {}
-- Others
IMAGOdb.npcs.CAT_SKYBORNE      = IMAGOdb.npcs.CAT_SKYBORNE      or {}
IMAGOdb.npcs.CAT_CENARION_CIRCLE_FOREVER      = IMAGOdb.npcs.CAT_CENARION_CIRCLE_FOREVER      or {}
IMAGOdb.npcs.CAT_ARGENT        = IMAGOdb.npcs.CAT_ARGENT        or {}
IMAGOdb.npcs.CAT_DALARAN       = IMAGOdb.npcs.CAT_DALARAN       or {}
IMAGOdb.npcs.CAT_GOBLIN_CARTELS_FOREVER        = IMAGOdb.npcs.CAT_GOBLIN_CARTELS_FOREVER        or {}
IMAGOdb.npcs.CAT_SHENDRALAR    = IMAGOdb.npcs.CAT_SHENDRALAR    or {}
IMAGOdb.npcs.CAT_DRAGONFLIGHTS = IMAGOdb.npcs.CAT_DRAGONFLIGHTS or {}
IMAGOdb.npcs.CAT_ELEMENTALS    = IMAGOdb.npcs.CAT_ELEMENTALS    or {}
IMAGOdb.npcs.CAT_CENTAUR       = IMAGOdb.npcs.CAT_CENTAUR       or {}
IMAGOdb.npcs.CAT_NEUTRAL_INDEPENDENT       = IMAGOdb.npcs.CAT_NEUTRAL_INDEPENDENT       or {}
IMAGOdb.npcs.CAT_CUSTOM        = IMAGOdb.npcs.CAT_CUSTOM        or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

-- CAT_KINGDOM_STORMWIND — Kingdom of Stormwind
IMAGOdb.npcs.CAT_KINGDOM_STORMWIND["bolvar_fordragon_forever"] = {
    displayID = 1748,
    ids = {1748},
    zones = {},
    raceKey = "human",
    category = "CAT_KINGDOM_STORMWIND",
}

IMAGOdb.npcs.CAT_KINGDOM_STORMWIND["mathias_shaw_forever"] = {
    displayID = 332,
    ids = {332},
    zones = {},
    raceKey = "human",
    category = "CAT_KINGDOM_STORMWIND",
}

IMAGOdb.npcs.CAT_KINGDOM_STORMWIND["lady_katrana_prestor_forever"] = {
    displayID = 1749,
    ids = {1749},
    zones = {},
    raceKey = "human",
    category = "CAT_KINGDOM_STORMWIND",
}

IMAGOdb.npcs.CAT_KINGDOM_STORMWIND["anduin_wrynn_forever"] = {
    displayID = 1747,
    ids = {1747},
    zones = {},
    raceKey = "human",
    category = "CAT_KINGDOM_STORMWIND",
}

-- CAT_DWARVES_IRONFORGE — Dwarves of Ironforge
IMAGOdb.npcs.CAT_DWARVES_IRONFORGE["king_magni_bronzebeard_forever"] = {
    displayID = 2784,
    ids = {2784},
    zones = {},
    raceKey = "dwarf",
    category = "CAT_DWARVES_IRONFORGE",
}

-- CAT_GNOMEREGAN_EXILES — Gnomeregan Exiles
IMAGOdb.npcs.CAT_GNOMEREGAN_EXILES["high_tinker_mekkatorque_forever"] = {
    displayID = 7937,
    ids = {7937, 219659},
    zones = {},
    raceKey = "gnome",
    category = "CAT_GNOMEREGAN_EXILES",
}

-- CAT_NIGHT_ELVES_DARNASSUS — Night Elves of Darnassus
IMAGOdb.npcs.CAT_NIGHT_ELVES_DARNASSUS["tyrande_whisperwind_forever"] = {
    displayID = 7999,
    ids = {7999, 15633},
    zones = {},
    raceKey = "night_elf",
    category = "CAT_NIGHT_ELVES_DARNASSUS",
}

-- CAT_WILDHAMMER_CLAN — Wildhammer Clan
IMAGOdb.npcs.CAT_WILDHAMMER_CLAN["falstad_wildhammer_forever"] = {
    displayID = 5635,
    ids = {5635},
    zones = {},
    raceKey = "dwarf",
    category = "CAT_WILDHAMMER_CLAN",
}

-- ============================================================
-- HORDE
-- ============================================================

-- CAT_ORCS_HORDE — Orcs of the Horde
IMAGOdb.npcs.CAT_ORCS_HORDE["thrall_forever"] = {
    displayID = 4949,
    ids = {4949},
    zones = {},
    raceKey = "orc",
    category = "CAT_ORCS_HORDE",
}

IMAGOdb.npcs.CAT_ORCS_HORDE["high_overlord_saurfang_forever"] = {
    displayID = 14720,
    ids = {14720},
    zones = {},
    raceKey = "orc",
    category = "CAT_ORCS_HORDE",
}

IMAGOdb.npcs.CAT_ORCS_HORDE["eitrigg_forever"] = {
    displayID = 3144,
    ids = {3144},
    zones = {},
    raceKey = "orc",
    category = "CAT_ORCS_HORDE",
}

IMAGOdb.npcs.CAT_ORCS_HORDE["drek_thar_forever"] = {
    displayID = 11946,
    ids = {11946},
    zones = {},
    raceKey = "orc",
    category = "CAT_ORCS_HORDE",
}

IMAGOdb.npcs.CAT_ORCS_HORDE["nazgrel_forever"] = {
    displayID = 3230,
    ids = {3230},
    zones = {},
    raceKey = "orc",
    category = "CAT_ORCS_HORDE",
}

-- CAT_DARKSPEAR_TROLLS— Darkspear Trolls
IMAGOdb.npcs.CAT_DARKSPEAR_TROLLS["vol_jin_forever"] = {
    displayID = 10540,
    ids = {10540},
    zones = {},
    raceKey = "troll",
    category = "CAT_DARKSPEAR_TROLLS",
}

-- CAT_FORSAKEN — The Forsaken
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner_forever"] = {
    displayID = 10181,
    ids = {10181},
    zones = {},
    raceKey = "undead",
    category = "CAT_FORSAKEN",
}

IMAGOdb.npcs.CAT_FORSAKEN["varimathras_forever"] = {
    displayID = 2425,
    ids = {2425},
    zones = {},
    raceKey = "dreadlord",
    category = "CAT_FORSAKEN",
}

-- CAT_TAUREN_THUNDER_BLUFF — Tauren of Thunder Bluff
IMAGOdb.npcs.CAT_TAUREN_THUNDER_BLUFF["cairne_bloodhoof_forever"] = {
    displayID = 3057,
    ids = {3057},
    zones = {},
    raceKey = "tauren",
    category = "CAT_TAUREN_THUNDER_BLUFF",
}

IMAGOdb.npcs.CAT_TAUREN_THUNDER_BLUFF["baine_bloodhoof_forever"] = {
    displayID = 2993,
    ids = {2993},
    zones = {},
    raceKey = "tauren",
    category = "CAT_TAUREN_THUNDER_BLUFF",
}

IMAGOdb.npcs.CAT_TAUREN_THUNDER_BLUFF["magatha_grimtotem_forever"] = {
    displayID = 4046,
    ids = {4046},
    zones = {},
    raceKey = "tauren",
    category = "CAT_TAUREN_THUNDER_BLUFF",
}


-- ============================================================
-- OTHERS
-- ============================================================

-- CAT_SKYBORN — Skyborne
IMAGOdb.npcs.CAT_SKYBORNE["high_priestess_lorthuna_forever"] = {
    displayID = 252076,
    ids = {252076, 264712, 256249, 252957},
    zones = {},
    raceKey = "skyborne",
    category = "CAT_SKYBORNE",
}

-- CAT_CENARION — Cenarion Circle
IMAGOdb.npcs.CAT_CENARION_CIRCLE_FOREVER["fandral_staghelm_forever"] = {
    displayID = 3516,
    ids = {3516, 15382},
    zones = {},
    raceKey = "night_elf",
    category = "CAT_CENARION_CIRCLE_FOREVER",
}

IMAGOdb.npcs.CAT_CENARION_CIRCLE_FOREVER["hamuul_runetotem_forever"] = {
    displayID = 5769,
    ids = {5769},
    zones = {},
    raceKey = "tauren",
    category = "CAT_CENARION_CIRCLE_FOREVER",
}

-- CAT_NEUTRAL — Neutral / Independant
IMAGOdb.npcs.CAT_NEUTRAL_INDEPENDENT["tirion_fordring_forever"] = {
    displayID = 1855,
    ids = {1855, 12126},
    zones = {},
    raceKey = "human",
    category = "CAT_NEUTRAL_INDEPENDENT",
}

-- CAT_GOBLIN — Goblin Cartels
IMAGOdb.npcs.CAT_GOBLIN_CARTELS_FOREVER["monte_gazlowe_forever"] = {
    displayID = 3391,
    ids = {3391},
    zones = {},
    raceKey = "goblin",
    category = "CAT_GOBLIN_CARTELS_FOREVER",
}

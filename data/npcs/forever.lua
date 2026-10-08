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
IMAGOdb.npcs.CAT_STORMWIND   = IMAGOdb.npcs.CAT_STORMWIND   or {}
IMAGOdb.npcs.CAT_IRONFORGE   = IMAGOdb.npcs.CAT_IRONFORGE   or {}
IMAGOdb.npcs.CAT_GNOMEREGAN  = IMAGOdb.npcs.CAT_GNOMEREGAN  or {}
IMAGOdb.npcs.CAT_DARNASSUS   = IMAGOdb.npcs.CAT_DARNASSUS   or {}
IMAGOdb.npcs.CAT_THERAMORE   = IMAGOdb.npcs.CAT_THERAMORE   or {}
IMAGOdb.npcs.CAT_WILDHAMMER  = IMAGOdb.npcs.CAT_WILDHAMMER  or {}
-- Horde
IMAGOdb.npcs.CAT_ORCS        = IMAGOdb.npcs.CAT_ORCS        or {}
IMAGOdb.npcs.CAT_DARKSPEAR   = IMAGOdb.npcs.CAT_DARKSPEAR   or {}
IMAGOdb.npcs.CAT_FORSAKEN    = IMAGOdb.npcs.CAT_FORSAKEN    or {}
IMAGOdb.npcs.CAT_THUNDERBLUFF = IMAGOdb.npcs.CAT_THUNDERBLUFF or {}
-- Others
IMAGOdb.npcs.CAT_SKYBORNE      = IMAGOdb.npcs.CAT_SKYBORNE      or {}
IMAGOdb.npcs.CAT_CENARION      = IMAGOdb.npcs.CAT_CENARION      or {}
IMAGOdb.npcs.CAT_ARGENT        = IMAGOdb.npcs.CAT_ARGENT        or {}
IMAGOdb.npcs.CAT_DALARAN       = IMAGOdb.npcs.CAT_DALARAN       or {}
IMAGOdb.npcs.CAT_GOBLIN        = IMAGOdb.npcs.CAT_GOBLIN        or {}
IMAGOdb.npcs.CAT_SHENDRALAR    = IMAGOdb.npcs.CAT_SHENDRALAR    or {}
IMAGOdb.npcs.CAT_DRAGONFLIGHTS = IMAGOdb.npcs.CAT_DRAGONFLIGHTS or {}
IMAGOdb.npcs.CAT_ELEMENTALS    = IMAGOdb.npcs.CAT_ELEMENTALS    or {}
IMAGOdb.npcs.CAT_CENTAUR       = IMAGOdb.npcs.CAT_CENTAUR       or {}
IMAGOdb.npcs.CAT_NEUTRAL       = IMAGOdb.npcs.CAT_NEUTRAL       or {}
IMAGOdb.npcs.CAT_CUSTOM        = IMAGOdb.npcs.CAT_CUSTOM        or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

-- CAT_STORMWIND — Kingdom of Stormwind
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"] = {
    ids = {1748},
    zones = {},
    category = "CAT_STORMWIND",
    raceKey = "human",
}

IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"] = {
    ids = {1747},
    zones = {},
    category = "CAT_STORMWIND",
    raceKey = "human",
}

-- CAT_IRONFORGE — Dwarves of Ironforge
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"] = {
    ids = {2784},
    zones = {},
    category = "CAT_IRONFORGE",
    raceKey = "dwarf",
}

-- CAT_GNOMEREGAN — Gnomeregan Exiles
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"] = {
    ids = {7937},
    zones = {},
    category = "CAT_GNOMEREGAN",
    raceKey = "gnome",
}

-- CAT_DARNASSUS — Night Elves of Darnassus
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"] = {
    ids = {7999},
    zones = {},
    category = "CAT_DARNASSUS",
    raceKey = "night_elf",
}

IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"] = {
    ids = {3936},
    zones = {},
    category = "CAT_DARNASSUS",
    raceKey = "night_elf",
}

-- CAT_THERAMORE — Theramore
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"] = {
    ids = {4968},
    zones = {},
    category = "CAT_THERAMORE",
    raceKey = "human",
}

-- ============================================================
-- HORDE
-- ============================================================

-- CAT_ORCS — Orcs of the Horde
IMAGOdb.npcs.CAT_ORCS["thrall"] = {
    ids = {4949},
    zones = {},
    category = "CAT_ORCS",
    raceKey = "orc",
}

IMAGOdb.npcs.CAT_ORCS["rexxar"] = {
    ids = {10182},
    zones = {},
    category = "CAT_ORCS",
    raceKey = "orc",
}

-- CAT_DARKSPEAR — Darkspear Trolls
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"] = {
    ids = {10540},
    zones = {},
    category = "CAT_DARKSPEAR",
    raceKey = "troll",
}

-- CAT_FORSAKEN — The Forsaken
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"] = {
    ids = {10181},
    zones = {},
    category = "CAT_FORSAKEN",
    raceKey = "undead",
}

IMAGOdb.npcs.CAT_FORSAKEN["varimathras"] = {
    ids = {2425},
    zones = {},
    category = "CAT_FORSAKEN",
    raceKey = "undead",
}

-- CAT_THUNDERBLUFF — Tauren of Thunder Bluff
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"] = {
    ids = {3057},
    zones = {},
    category = "CAT_THUNDERBLUFF",
    raceKey = "tauren",
}

-- ============================================================
-- OTHERS
-- ============================================================

-- CAT_CENARION — Cenarion Circle
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"] = {
    ids = {3516},
    zones = {},
    category = "CAT_CENARION",
    raceKey = "night_elf",
}

-- CAT_ARGENT — Argent Dawn & Silver Hand
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"] = {
    ids = {1855, 12126},
    zones = {},
    category = "CAT_ARGENT",
    raceKey = "human",
}

-- CAT_GOBLIN — Goblin Cartels
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"] = {
    ids = {3391},
    zones = {},
    category = "CAT_GOBLIN",
    
}

-- ============================================================
-- IMAGO Forever — data/zones_static.lua  (static data)
-- Zone database is empty by design — Forever entries go here:
-- IMAGOdb.zones[uiMapID] = { id, expansion, texturePath, ... }
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.zones = IMAGOdb.zones or {}

IMAGOdb.zones[1453] = {
    id = 1453,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\stormwind.tga",
    -- curated zone facts, values as listed on the zone's Wowhead page:
    -- territory: "alliance" | "horde" | "contested"
    -- changes:   "unchanged" | "new" | "updated"
    -- levelMin/levelMax: level range of the zone
    territory = "alliance",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 60,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1455] = {
    id = 1455,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Ironforge.tga",
    territory = "alliance",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 60,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1426] = {
    id = 1426,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Dunmorogh.tga",
    territory = "alliance",
    changes = "updated",
    levelMin = 1,
    levelMax = 56,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1420] = {
    id = 1420,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\TirisfallGlades.tga",
    territory = "horde",
    changes = "updated",
    levelMin = 1,
    levelMax = 12,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1429] = {
    id = 1429,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Elwynn.tga",
    territory = "alliance",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 10,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1438] = {
    id = 1438,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Teldrassil.tga",
    territory = "alliance",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 11,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1411] = {
    id = 1411,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Durotar.tga",
    territory = "horde",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 10,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1412] = {
    id = 1412,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Mulgore.tga",
    territory = "horde",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 10,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1454] = {
    id = 1454,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Orgrimmar.tga",
    territory = "horde",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 60,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1457] = {
    id = 1457,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Darnassus.tga",
    territory = "alliance",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 60,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

IMAGOdb.zones[1458] = {
    id = 1458,
    texturePath = "Interface\\AddOns\\IMAGO_forever\\media\\zones\\Undercity.tga",
    territory = "horde",
    changes = "unchanged",
    levelMin = 1,
    levelMax = 60,
    name = "",
    lore = "",
    pointsOfInterest = {},
}

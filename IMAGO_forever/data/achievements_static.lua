-- ============================================================
-- IMAGO Forever — data/achievements_static.lua (static data)
-- Achievement definitions: id, points, eval() -> seen, total.
-- Localized name/desc live in locales/<locale>/locale.lua as
-- L["ACH_<ID>_NAME"] / L["ACH_<ID>_DESC"] (id uppercased).
-- ============================================================

IMAGOdb = IMAGOdb or {}

local ALLIANCE = {
    "CAT_KINGDOM_STORMWIND", "CAT_DWARVES_IRONFORGE", "CAT_GNOMEREGAN_EXILES",
    "CAT_NIGHT_ELVES_DARNASSUS", "CAT_THERAMORE", "CAT_WILDHAMMER_CLAN",
}
local HORDE = {
    "CAT_ORCS_HORDE", "CAT_DARKSPEAR_TROLLS", "CAT_FORSAKEN", "CAT_TAUREN_THUNDER_BLUFF",
}
local NEUTRAL = {
    "CAT_SKYBORNE", "CAT_CENARION", "CAT_ARGENT", "CAT_DALARAN",
    "CAT_GOBLIN_CARTELS_FOREVER", "CAT_SHENDRALAR", "CAT_DRAGONFLIGHTS",
    "CAT_ELEMENTALS", "CAT_CENTAUR", "CAT_NEUTRAL_INDEPENDENT", "CAT_CUSTOM",
}

local function Merge(...)
    local out = {}
    for _, t in ipairs({...}) do
        for _, v in ipairs(t) do out[#out + 1] = v end
    end
    return out
end

local ALL_CATS = Merge(ALLIANCE, HORDE, NEUTRAL)

local function Seen(seenTable, key)
    return seenTable and seenTable[key] and true or false
end

local function FatesCount(cats)
    local seen, total = 0, 0
    for _, cat in ipairs(cats) do
        for slug in pairs(IMAGOdb.npcs and IMAGOdb.npcs[cat] or {}) do
            total = total + 1
            if IMAGOSaved and Seen(IMAGOSaved.seenNPCs, slug) then
                seen = seen + 1
            end
        end
    end
    return seen, total
end

local function ZonesCount()
    local seen, total = 0, 0
    for mapID in pairs(IMAGOdb.zones or {}) do
        total = total + 1
        if IMAGOSaved and Seen(IMAGOSaved.seenZones, mapID) then
            seen = seen + 1
        end
    end
    return seen, total
end

local function RacesCount()
    local seen, total = 0, 0
    for slug in pairs(IMAGOdb.races or {}) do
        total = total + 1
        if IMAGOSaved and Seen(IMAGOSaved.seenRaces, slug) then
            seen = seen + 1
        end
    end
    return seen, total
end

local function ClassesCount()
    local seen, total = 0, 0
    for slug in pairs(IMAGOdb.classes or {}) do
        total = total + 1
        if IMAGOSaved and Seen(IMAGOSaved.seenClasses, slug) then
            seen = seen + 1
        end
    end
    return seen, total
end

local function OverallCount()
    local s1, t1 = FatesCount(ALL_CATS)
    local s2, t2 = ZonesCount()
    local s3, t3 = RacesCount()
    local s4, t4 = ClassesCount()
    return s1 + s2 + s3 + s4, t1 + t2 + t3 + t4
end

-- Progress toward an overall percent threshold (25%, 50%, 100%)
local function OverallGoal(frac)
    local seen, total = OverallCount()
    if total == 0 then return 0, 0 end
    local goal = math.max(1, math.ceil(total * frac))
    return math.min(seen, goal), goal
end

local function FavoritesCount()
    local n = 0
    for _, v in pairs(IMAGOSaved and IMAGOSaved.favorites or {}) do
        if v then n = n + 1 end
    end
    return n
end

local function ViewedFatesCount()
    local n = 0
    for _, v in pairs(IMAGOSaved and IMAGOSaved.viewedNPCs or {}) do
        if v then n = n + 1 end
    end
    return n
end

local function AtLeast(count, goal)
    return math.min(count, goal), goal
end

-- Order = display order (roughly easy to hard)
IMAGOdb.achievements = {
    { id = "first_echo", cat = "fates", points = 10,
      eval = function()
          local s = FatesCount(ALL_CATS)
          return math.min(s, 1), 1
      end },
    { id = "studious", cat = "fates", points = 10,
      eval = function() return AtLeast(ViewedFatesCount(), 10) end },
    { id = "curator", cat = "fates", points = 10,
      eval = function() return AtLeast(FavoritesCount(), 5) end },
    { id = "first_lesson", cat = "classes", points = 10,
      eval = function()
          local s = ClassesCount()
          return math.min(s, 1), 1
      end },
    { id = "imago_awakens", cat = "overall", points = 15, eval = function() return OverallGoal(0.25) end },
    { id = "alliance_chronicler", cat = "fates", points = 30, eval = function() return FatesCount(ALLIANCE) end },
    { id = "horde_chronicler", cat = "fates", points = 30, eval = function() return FatesCount(HORDE) end },
    { id = "united_chronicler", cat = "fates", points = 40,
      eval = function() return FatesCount(Merge(ALLIANCE, HORDE)) end },
    { id = "free_voices", cat = "fates", points = 20, eval = function() return FatesCount(NEUTRAL) end },
    { id = "argent_chronicler", cat = "fates", points = 10, eval = function() return FatesCount({"CAT_ARGENT"}) end },
    { id = "cenarion_keeper", cat = "fates", points = 10, eval = function() return FatesCount({"CAT_CENARION"}) end },
    { id = "diplomat", cat = "races", points = 35, eval = function() return RacesCount() end },
    { id = "class_chronicler", cat = "classes", points = 35, eval = function() return ClassesCount() end },
    { id = "half_chronicle", cat = "overall", points = 25, eval = function() return OverallGoal(0.50) end },
    { id = "worldwalker", cat = "zones", points = 30, eval = function() return ZonesCount() end },
    { id = "perfected_imago", cat = "overall", points = 50, eval = function() return OverallGoal(1.00) end },
}

-- Exposed for the achievements summary column
IMAGOdb.achievementCounts = {
    FatesCount = FatesCount,
    ZonesCount = ZonesCount,
    RacesCount = RacesCount,
    ClassesCount = ClassesCount,
    OverallCount = OverallCount,
}

-- Shared score calculation: 1 point per progress step inside each
-- achievement + bonus per currently-complete one. Also returns the
-- evaluated list so UI doesn't recompute.
function IMAGO.GetChronicleScore()
    IMAGOSaved = IMAGOSaved or {}
    IMAGOSaved.achievementsDone = IMAGOSaved.achievementsDone or {}
    local evaluated, progressPts, bonus = {}, 0, 0
    for _, def in ipairs(IMAGOdb.achievements or {}) do
        local seen, total = def.eval()
        if total > 0 then
            progressPts = progressPts + math.min(seen, total)
            if seen >= total and not IMAGOSaved.achievementsDone[def.id] then
                IMAGOSaved.achievementsDone[def.id] = time()
                if IMAGO.Social and IMAGO.Social.OnEarned then
                    IMAGO.Social.OnEarned(def)
                end
            end
            local done = seen >= total
            if done then bonus = bonus + (def.points or 0) end
            evaluated[#evaluated + 1] = {
                def = def, seen = seen, total = total, done = done,
                earned = IMAGOSaved.achievementsDone[def.id] ~= nil,
                frac = math.min(seen, total) / total,
            }
        end
    end
    return progressPts + bonus, progressPts, bonus, evaluated
end

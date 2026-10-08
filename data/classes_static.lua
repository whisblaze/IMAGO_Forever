-- ============================================================
-- IMAGO Forever - Classes (static records)
-- ============================================================
-- Skeleton only: one record per playable class in Forever.
-- icon = class icon texcoords key (CLASS_ICON_TCOORDS),
-- color resolved via RAID_CLASS_COLORS at render time.
-- Localized text lives in locales/base/data/classes.lua.

IMAGOdb.classes = IMAGOdb.classes or {}

IMAGOdb.classes["warrior"] = { classFile = "WARRIOR" }
IMAGOdb.classes["paladin"] = { classFile = "PALADIN" }
IMAGOdb.classes["hunter"]  = { classFile = "HUNTER" }
IMAGOdb.classes["rogue"]   = { classFile = "ROGUE" }
IMAGOdb.classes["priest"]  = { classFile = "PRIEST" }
IMAGOdb.classes["shaman"]  = { classFile = "SHAMAN" }
IMAGOdb.classes["mage"]    = { classFile = "MAGE" }
IMAGOdb.classes["warlock"] = { classFile = "WARLOCK" }
IMAGOdb.classes["druid"]   = { classFile = "DRUID" }

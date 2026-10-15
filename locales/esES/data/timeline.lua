-- ============================================================
-- IMAGO Forever — locales/esES/data/timeline.lua
-- Localized Timeline text: era names + title / yearLabel / body
-- per event slug. Empty by design — falls back to
-- locales/base/data/timeline.lua.
-- ============================================================

if GetLocale() ~= "esES" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}
IMAGOdb.timeline.events = IMAGOdb.timeline.events or {}

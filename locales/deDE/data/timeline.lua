-- ============================================================
-- IMAGO Forever — locales/deDE/data/timeline.lua
-- German overrides: era names + title / yearLabel / body
-- per event slug. Structure lives in data/timeline_static.lua,
-- English fallback in locales/base/data/timeline.lua.
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}
IMAGOdb.timeline.events = IMAGOdb.timeline.events or {}

IMAGOdb.timelineEraNames = {
    mythos       = "Morgen der Schöpfung",
    kaldorei     = "Zeitalter der Kaldorei",
    long_vigil   = "Die Lange Wacht",
    kingdoms     = "Zeitalter der sterblichen Königreiche",
    fall_draenor = "Der Fall Draenors",
    great_wars   = "Die Großen Kriege",
    present      = "Die Gegenwart",
}

local ev = IMAGOdb.timeline.events

-- ============ ERA 1: DAWN OF CREATION ============

if ev["creation_universe"] then
    ev["creation_universe"].title = "Die Erschaffung des Kosmos"
    ev["creation_universe"].yearLabel = "Vor aller Aufzeichnung"
    ev["creation_universe"].body = [[
Noch bevor der Kosmos Gestalt annahm, existierte allein das Licht – ein grenzenloses Meer lebendiger Energie. Doch wo es sich ausbreitete und seine Kraft verlor, blieben Flecken kalter Leere zurück. Diese Flecken verschmolzen miteinander und formten eine zweite Urkraft. Die Leere ist eine dunkle, vampirische Macht, die alles verschlingen möchte. Die wachsende Spannung dieser beiden gegensätzlichen Energien entlud sich schließlich in einer Reihe entsetzlicher Explosionen. Dabei entstand das materielle Universum, das auch als das Große Dunkle Jenseits bezeichnet wird. Die instabilsten Kräfte verfestigten sich zur chaotischen Astraldimension des Wirbelnden Nethers.

Splitterfragmente des Lichts wurden durch das Universum geschleudert und hauchten zahllosen Welten den Funken des Lebens ein. Meistens entstanden daraus Elementargeister. Doch wo sich das gebrochene Licht zu Wolken sammelte, entstanden die Naaru. Sie schworen, das Leben zu schützen. In den feurigen Kernen weniger Welten schlummerten zugleich die Weltenseelen künftiger Titanen. Als diese kolossalen Wesen erwachten, machten sie sich auf die Suche nach weiteren Artgenossen, mit dem Ziel Ordnung in das junge Universum zu bringen.]]
end

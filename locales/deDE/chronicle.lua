-- ============================================================
-- IMAGO — locales/deDE/chronicle.lua
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGO.Chronicle = IMAGO.Chronicle or {}

IMAGO.Chronicle.ranks = {
    {perc = 0,   title = "Stiller Beobachter"},
    {perc = 10,  title = "Sammler der Fragmente"},
    {perc = 25,  title = "Schreiber der Echos"},
    {perc = 40,  title = "Chronist der Unvergessenen"},
    {perc = 60,  title = "Hüter des Vermächtnisses"},
    {perc = 80,  title = "Hüter der Weltenseele"},
    {perc = 95,  title = "Das Gedächtnis von Azeroth"},
    {perc = 100, title = "Vollendetes Imago"},
}

IMAGO.Chronicle.zoneRanks = {
    {perc = 0,   title = "Wanderer"},
    {perc = 20,  title = "Späher"},
    {perc = 40,  title = "Kartograph"},
    {perc = 60,  title = "Pfadfinder"},
    {perc = 80,  title = "Entdecker"},
    {perc = 100, title = "Weltenwanderer"},
}

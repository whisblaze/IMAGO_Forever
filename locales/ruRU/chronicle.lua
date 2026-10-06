-- ============================================================
-- IMAGO — locales/ruRU/chronicle.lua
-- ============================================================

if GetLocale() ~= "ruRU" then return end

IMAGO.Chronicle = IMAGO.Chronicle or {}

IMAGO.Chronicle.ranks = {
    {perc = 0,   title = "Безмолвный Наблюдатель"},
    {perc = 10,  title = "Собиратель Осколков"},
    {perc = 25,  title = "Летописец Отголосков"},
    {perc = 40,  title = "Хронист Незабытых"},
    {perc = 60,  title = "Хранитель Наследия"},
    {perc = 80,  title = "Хранитель Души Мира"},
    {perc = 95,  title = "Великий Архивариус Канона"},
    {perc = 100, title = "Совершенный Имаго"},
}

IMAGO.Chronicle.zoneRanks = {
    {perc = 0,   title = "Странник"},
    {perc = 20,  title = "Разведчик"},
    {perc = 40,  title = "Картограф"},
    {perc = 60,  title = "Следопыт"},
    {perc = 80,  title = "Исследователь"},
    {perc = 100, title = "Мироходец"},
}
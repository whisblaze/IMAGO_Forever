-- ============================================================
-- IMAGO Forever - Classes (enUS base text, placeholder)
-- ============================================================

local names = {
    warrior = "Warrior",
    paladin = "Paladin",
    hunter  = "Hunter",
    rogue   = "Rogue",
    priest  = "Priest",
    shaman  = "Shaman",
    mage    = "Mage",
    warlock = "Warlock",
    druid   = "Druid",
}

for slug, name in pairs(names) do
    local c = IMAGOdb.classes and IMAGOdb.classes[slug]
    if c then
        c.name = name
        c.overview = name .. " class overview. Content coming soon."
        c.mechanics = "Placeholder: class mechanics and resource systems for " .. name .. "."
        c.talents = "Placeholder: talent trees and builds for " .. name .. "."
        c.trainers = "Placeholder: trainers and starting locations for " .. name .. "."
    end
end

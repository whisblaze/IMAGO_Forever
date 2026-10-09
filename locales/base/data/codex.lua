-- ============================================================
-- IMAGO Forever — locales/base/data/codex.lua (enUS fallback)
-- Localized Codex text: title, body and aliases per entry slug.
-- Structure (slugs, categories, related, linkable) lives in
-- data/codex_static.lua.
--
-- aliases = extra names the TextLinker will auto-link to this
-- entry (title is linked automatically when linkable = true).
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.codex = IMAGOdb.codex or {}
IMAGOdb.codex.entries = IMAGOdb.codex.entries or {}

-- Category display names
IMAGOdb.codexCatNames = {
    cosmology = "Cosmology",
    magic     = "Magic & Powers",
    peoples   = "Peoples & Origins",
    history   = "History & Concepts",
    factions  = "Factions & Orders",
}

local e = IMAGOdb.codex.entries

-- ============ COSMOLOGY ============

if e["great_sundering"] then
    e["great_sundering"].title = "The Great Sundering"
    e["great_sundering"].aliases = { "the Sundering" }
    e["great_sundering"].body = [[
The Great Sundering was the cataclysmic event that shattered ancient Kalimdor and reshaped the world. When the Well of Eternity imploded at the end of the War of the Ancients, the landmass broke apart; the continents drifted, and Azeroth was forever changed.

It marked the end of the night elves' golden age, the drowning of Queen Azshara's capital, and the beginning of the world as mortals know it — the conflicts it set in motion still define the present age.]]
end

if e["well_of_eternity"] then
    e["well_of_eternity"].title = "The Well of Eternity"
    e["well_of_eternity"].body = [[
The Well of Eternity was a lake of pure arcane energy at the heart of old Kalimdor — the source of all magic on Azeroth. The night elves' Highborne built their civilization upon its shores, and their reckless experiments with its power drew the Burning Legion's gaze.

Its destruction caused the Great Sundering. What remains of its energy was hidden in a second Well beneath Mount Hyjal — and in the vial Illidan poured into it, the seed of every arcane conflict since.]]
end

if e["titans"] then
    e["titans"].title = "The Titans"
    e["titans"].body = [[
The titans are colossal beings of order who traveled the cosmos shaping worlds. Long before recorded history, they came to Azeroth, imprisoned the Old Gods who ruled it, and left behind the keepers and machines meant to watch over their work.

The dwarves call themselves their heirs — the earthen were titan-forged before the flesh-curse softened them. Uldaman's discs and the Explorers' League dig sites are what remains of that inheritance.]]
end

if e["old_gods"] then
    e["old_gods"].title = "The Old Gods"
    e["old_gods"].body = [[
The Old Gods are entities of the Void that ruled Azeroth in its primordial blackness, until the titans chained them beneath the earth. They do not break free — they whisper, corrupt, and wait.

Their influence surfaces wherever the world bleeds: in the madness of cultists, in the silithid hives of Silithus, and in the quiet dreams of those who dig too deep.]]
end

if e["emerald_dream"] then
    e["emerald_dream"].title = "The Emerald Dream"
    e["emerald_dream"].body = [[
The Emerald Dream is the verdant, spiritual echo of Azeroth as it was before mortal hands shaped it. The green dragonflight guards it, and druids walk it in their sleep — or at least they did, until something began to go wrong inside it.

Malfurion Stormrage lies trapped within, and the corruption festering there has already crept into Teldrassil's roots. The Dream is not the refuge it once was.]]
end

if e["twisting_nether"] then
    e["twisting_nether"].title = "The Twisting Nether"
    e["twisting_nether"].body = [[
The Twisting Nether is the formless astral chaos between worlds — the highway of demons and the grave of failed invasions. Creatures of the Burning Legion reform there when slain, which is why demons can only be truly destroyed within it.

Every portal, every summoning circle, every warlock's bargain draws on its currents. The Nether is not a place armies march through; it is the storm they sail.]]
end

-- ============ MAGIC & POWERS ============

if e["arcane"] then
    e["arcane"].title = "Arcane Magic"
    e["arcane"].body = [[
Arcane magic is the raw power of order — the force that shaped the cosmos, channeled through will and formula. Every spell a mage casts is a negotiation with it, and every negotiation has a price.

The Kirin Tor codified its study; the Highborne drowned in its depths; the Well of Eternity was its reservoir. Arcane power does not corrupt by itself — but it makes its users believe they are the exception.]]
end

if e["fel"] then
    e["fel"].title = "Fel Magic"
    e["fel"].body = [[
Fel is the magic of the Twisting Nether — chaotic, corrosive, and generous with power it fully intends to collect on. It burns worlds to fuel itself, and it leaves the user changed.

Orcs know its taste better than anyone: the fel enslaved their ancestors to the Legion and birthed the Horde of the First War. Warlocks wield it still, and everyone who counts on them counts the cost.]]
end

if e["holy_light"] then
    e["holy_light"].title = "The Holy Light"
    e["holy_light"].body = [[
The Holy Light is the force of faith made manifest — a power that answers conviction rather than formula. Priests channel it to mend, paladins to smite, and the Church of the Holy Light built human civilization's conscience upon it.

It stripped Tirion Fordring of everything he had for saving an orc — and answered him again years later. The Light's favor, it turns out, follows the soul, not the title.]]
end

if e["nature"] then
    e["nature"].title = "Nature Magic"
    e["nature"].body = [[
Nature magic is the power of the living world — growth, balance, spirit, and storm. Druids draw it from the Emerald Dream and the wild gods; shamans bargain for it with the elements themselves.

It is the oldest power in Azeroth and the least obedient. The land answers only those it chooses to hear, and it forgets neither kindness nor scar.]]
end

-- ============ PEOPLES & ORIGINS ============

if e["highborne"] then
    e["highborne"].title = "The Highborne"
    e["highborne"].aliases = { "Highborne" }
    e["highborne"].body = [[
The Highborne were the arcane aristocracy of ancient night elf civilization — Queen Azshara's favored caste, who considered command of the Well of Eternity's power their birthright.

Their hubris opened the door to the Burning Legion and shattered the world. The survivors became the high elves of Quel'Thalas — and what followed Azshara into the sea is better left unspoken.]]
end

if e["forsaken_people"] then
    e["forsaken_people"].title = "The Forsaken"
    e["forsaken_people"].aliases = { "Forsaken" }
    e["forsaken_people"].body = [[
The Forsaken are the free-willed undead who broke from the Lich King's grip when his power faltered — the risen citizens of fallen Lordaeron, led by Sylvanas Windrunner.

Allied to the Horde by necessity and feared by everyone including their allies, they are a people defined by what they will not forgive. Their answer to the question of what unlife is for is still being written — in vengeance, survival, and apothecary smoke.]]
end

-- ============ HISTORY & CONCEPTS ============

if e["war_of_ancients"] then
    e["war_of_ancients"].title = "The War of the Ancients"
    e["war_of_ancients"].body = [[
Ten thousand years ago, the Highborne's pact with Sargeras let the Burning Legion into Azeroth for the first time. The War of the Ancients was the night elves' desperate answer — the last stand of a civilization fighting for the world itself.

It ended with the Well of Eternity's implosion, the Great Sundering, and the Legion's first defeat. It also ended the night elves' age of dominance — a price they still pay.]]
end

if e["dark_portal"] then
    e["dark_portal"].title = "The Dark Portal"
    e["dark_portal"].body = [[
The Dark Portal is the gateway between Azeroth and the orcish homeworld of Draenor — opened by the corrupted Guardian Medivh to let the Horde through, and never truly closed since.

Every war of the last generation traces back to that gateway. The orcs came through it as conquerors, stayed as refugees, and built Durotar within sight of the world their ancestors burned.]]
end

if e["lich_king"] then
    e["lich_king"].title = "The Lich King"
    e["lich_king"].body = [[
The Lich King is the master of the Scourge — a soul forged by the Legion as an instrument of conquest, bound to the Frozen Throne in distant Northrend. His plague unmade Lordaeron and his servant Arthas carried the fall out.

When his grip briefly slipped, the Forsaken were born. He is the reason the dead walk — and the reason the living cannot forget.]]
end

-- ============ FACTIONS & ORDERS ============

if e["kirin_tor"] then
    e["kirin_tor"].title = "The Kirin Tor"
    e["kirin_tor"].body = [[
The Kirin Tor is the magocratic order that rules Dalaran, the floating city of wizards — the finest arcane institution Azeroth has ever produced, and the one most certain it knows better than everyone else.

Jaina Proudmoore studied among them. When the Scourge came, the Kirin Tor learned what every keeper of arcane secrets eventually learns: knowledge is no shield against the dead.]]
end

if e["guardians_tirisfal"] then
    e["guardians_tirisfal"].title = "The Guardians of Tirisfal"
    e["guardians_tirisfal"].aliases = { "Guardian of Tirisfal", "the Guardian" }
    e["guardians_tirisfal"].body = [[
The Guardians of Tirisfal were a secret line of empowered mages, created by the orders of old to hunt demons too strong for armies — one champion at a time, wielding the concentrated power of the council behind them.

The line ended with Medivh, the Guardian who opened the Dark Portal. His betrayal is the reason Azeroth almost fell — and the reason no one has been allowed that power since.]]
end

if e["burning_legion"] then
    e["burning_legion"].title = "The Burning Legion"
    e["burning_legion"].aliases = { "Burning Legion" }
    e["burning_legion"].body = [[
The Burning Legion is the demon army of Sargeras — the force that shattered the orcish homeworld, broke ancient Kalimdor, and turned the Scourge loose on Lordaeron. It does not negotiate; it arrives.

Twice it has been driven from Azeroth at catastrophic cost. The demons remember both defeats, and the Twisting Nether is very patient.]]
end

if e["scourge"] then
    e["scourge"].title = "The Scourge"
    e["scourge"].body = [[
The Scourge is the undead host of the Lich King — the plague-born army that consumed Lordaeron, Dalaran, and Quel'Thalas in a single generation. Its soldiers were once the people it destroyed.

The Scourge still festers in the Plaguelands, and the Forsaken are what it looks like when the harvest refuses its master. Every crusader, every grave, every haunted mile of the Eastern Kingdoms is its ledger.]]
end

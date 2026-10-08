-- ============================================================
-- IMAGO Forever — locales/base/data/races.lua (enUS fallback)
-- Localized race texts. Static records (IDs, figures,
-- settlements, group keys) live in data/races_static.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

local f = IMAGOdb.races["human"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Humans"
    f.source = "warcraft.wiki.gg/wiki/Human"
    f.history = [[
Youngest of Azeroth's great peoples — and the most stubborn. Seven kingdoms rose from the Arathi Empire's ashes; most are gone now. Lordaeron fell to the Scourge, and Stormwind alone carries the old banner of human power.
Short-lived and burning bright, humans rebuilt their capital stone by stone after the First War and now hold the southern Eastern Kingdoms — proud, indebted, and beset by Defias bandits and scheming nobles alike.]]
    f.culture = {
        biology = "Hardy and short-lived, humans adapt faster than any elder race. Their societies prize martial tradition, trade, and civic pride.",
        beliefs = "The Church of the Holy Light shapes human civilization — its cathedrals, its paladins, and its wars.",
        relations = "The backbone of the Alliance: close ties with Ironforge, shelter for the Gnomeregan exiles, uneasy friendship with the kaldorei. Enemies of the Horde since the First War.",
    }
    f.groups["stormwind"] = { name = "Kingdom of Stormwind", lore = "The last great human kingdom. Rebuilt after the First War, ruled by a boy-king and his regent — and whispered over by Lady Katrana Prestor." }
    f.groups["theramore"] = { name = "Theramore", lore = "Jaina Proudmoore's island city on Kalimdor — home of the Lordaeron refugees who crossed the sea and chose peace over vengeance." }
    f.groups["lords_of_lordaeron"] = { name = "Remnants of Lordaeron", lore = "The greatest human kingdom lies in ruins. Its survivors shelter in Theramore, fight for the Argent Dawn — or rose again as something else." }
    f.figureText["bolvar_fordragon"] = { title = "Highlord of Stormwind — Regent for the missing king" }
    f.figureText["anduin_wrynn"] = { title = "The boy king of Stormwind" }
    f.figureText["jaina_proudmoore"] = { title = "Lady of Theramore — leader of the Lordaeron refugees" }
    f.figureText["tirion_fordring"] = { title = "Exiled paladin — hero of the Plaguelands" }
    f.figureText["katrana_prestor"] = { name = "Lady Katrana Prestor", title = "Royal advisor — and more than she appears" }
    f.settlementText[84] = { name = "Stormwind City", lore = "The white-walled capital, rebuilt stone by stone after the First War. Its heroes' statues line the Valley of Heroes." }
    f.settlementText[37] = { name = "Elwynn Forest", lore = "Stormwind's green heartland — farms, forests, and a kobold problem nobody admits exists." }
end

f = IMAGOdb.races["dwarf"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Dwarves"
    f.source = "warcraft.wiki.gg/wiki/Dwarf"
    f.history = [[
Heirs of the earthen. The dwarves of Khaz Modan dug too deep and woke things best left buried — a history they repeat proudly. Ironforge has never fallen.
King Magni Bronzebeard holds the clans together through grief and grit: his brother Muradin dead in Northrend, his daughter Moira lost to the Dark Irons, his people split between mountain halls and surface wars. What dwarves lack in numbers they repay in stubbornness and steel.]]
    f.culture = {
        biology = "Stout, long-lived, and carved from the earth itself. Dwarven society runs on clan loyalty, craftsmanship, and ale.",
        beliefs = "A pragmatic faith — the Holy Light serves, but ancestors and the mysteries of the titans occupy the dwarven soul. The Explorers' League chases their titan-forged origins.",
        relations = "Stormwind's oldest ally and the Alliance's arsenal. Old grudges simmer against the Dark Irons and, less openly, against anyone who forgets dwarven sacrifices.",
    }
    f.groups["bronzebeard_clan"] = { name = "Bronzebeard Clan", lore = "The ruling clan of Ironforge, led by King Magni. Keepers of the mountain and of old debts." }
    f.groups["wildhammer_clan"] = { name = "Wildhammer Clan", lore = "The storm-riders of Aerie Peak — Gryphon masters who prefer wind and sky to Ironforge's stone." }
    f.groups["dark_iron_clan"] = { name = "Dark Iron Clan", lore = "The banished third clan, thralls of the Firelord in Blackrock. Emperor Thaurissan's people raid upward; Moira Bronzebeard sits among them." }
    f.figureText["magni_bronzebeard"] = { title = "King of Ironforge — head of the Bronzebeard clan" }
    f.figureText["moira_bronzebeard"] = { name = "Moira Bronzebeard", title = "King Magni's daughter — now Empress of the Dark Irons" }
    f.figureText["brann_bronzebeard"] = { name = "Brann Bronzebeard", title = "Explorer, chronicler, the wandering Bronzebeard" }
    f.settlementText[87] = { name = "Ironforge", lore = "The mountain city that has never fallen — a forge-heart of anvils, ale, and ancient stone." }
    f.settlementText[27] = { name = "Dun Morogh", lore = "The dwarven highlands — snow, rams, and the gates of Ironforge itself." }
end

f = IMAGOdb.races["gnome"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Gnomes"
    f.source = "warcraft.wiki.gg/wiki/Gnome"
    f.history = [[
The gnomes lost everything in a single day. When troggs breached Gnomeregan, High Tinker Mekkatorque followed his advisor Thermaplugg's counsel and flooded the city with radiation — killing most of the invaders and most of his people.
Now a nation of refugees in Ironforge's Tinker Town, the gnomes bury their grief in invention. Mekkatorque has never stopped planning the reclamation, and some exiles have never forgiven him for ordering it.]]
    f.culture = {
        biology = "Small, brilliant, and long-lived. Gnomish society prizes engineering genius above birthright — the High Tinker is an elected office.",
        beliefs = "Gnomes place faith in physics more than priests. What little reverence exists points toward logic, invention, and the occasional machine that should not work but does.",
        relations = "Guests of Ironforge and loyal Alliance members, though some dwarves quietly resent housing a people who irradiated their own capital.",
    }
    f.groups["survivors_of_gnomeregan"] = { name = "Survivors of Gnomeregan", lore = "The irradiated city's refugees — engineers, soldiers, and the irradiated survivors nobody talks about. All of them want their city back." }
    f.figureText["mekkatorque"] = { title = "High Tinker — leader of the Gnomeregan exiles" }
    f.figureText["sicco_thermaplugg"] = { name = "Sicco Thermaplugg", title = "The traitor — architect of Gnomeregan's fall" }
    f.settlementText[27] = { name = "Tinker Town, Ironforge", lore = "The exiles' quarter in Ironforge — part workshop, part refugee camp, entirely gnomish." }
end

f = IMAGOdb.races["night_elf"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Night Elves"
    f.source = "warcraft.wiki.gg/wiki/Night_elf"
    f.history = [[
Ten thousand years ago the kaldorei broke the world to save it. Immortal then, they sacrificed Nordrassil to stop the Legion at Hyjal — and woke to find themselves mortal, diminished, and ruled from a World Tree planted without blessing.
Tyrande Whisperwind leads alone; Malfurion sleeps unwakeable in the Dream, and Fandral Staghelm grows bolder in his absence. The night elves' new tree, Teldrassil, is already sickening — though few will say so aloud.]]
    f.culture = {
        biology = "Tall, violet-skinned, once-immortal. The kaldorei are a martial-spiritual society divided between Elune's priestesses and the druids' Emerald Dream.",
        beliefs = "Elune, the Moon Goddess, is their faith absolute — the Sisterhood serves her from the Temple of the Moon. Druids answer to Cenarius and the Cenarion Circle instead.",
        relations = "Newest members of the Alliance and its most aloof. The Horde's lumber operations in Ashenvale have made neighbors into enemies.",
    }
    f.groups["sentinels"] = { name = "The Sentinels", lore = "The night elf army — huntresses, archers, and watchers commanded by Shandris Feathermoon." }
    f.groups["sisterhood_of_elune"] = { name = "Sisterhood of Elune", lore = "The priestesshood that has guided kaldorei society since before the Sundering. Tyrande stands at its head." }
    f.figureText["tyrande_whisperwind"] = { title = "High Priestess of Elune — ruler of the night elves" }
    f.figureText["shandris_feathermoon"] = { title = "General of the Sentinel Army" }
    f.figureText["fandral_staghelm"] = { title = "Archdruid of the Cenarion Circle — Tyrande's rival" }
    f.figureText["malfurion_stormrage"] = { name = "Malfurion Stormrage", title = "Archdruid — lost in the Emerald Dream" }
    f.settlementText[89] = { name = "Darnassus", lore = "The moonlit capital on Teldrassil's crown — a city grown, not built." }
    f.settlementText[57] = { name = "Teldrassil", lore = "The second World Tree, planted without the Aspects' blessing. Its corruption is already visible to those who look." }
end

-- ============================================================
-- HORDE
-- ============================================================

f = IMAGOdb.races["orc"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Orcs"
    f.source = "warcraft.wiki.gg/wiki/Orc"
    f.history = [[
Born of the invading Horde, remade in internment camps, and freed by a slave who remembered what his people were. Thrall's orcs crossed the sea to a desert nobody wanted and named it for his father.
The new Horde is young and its sins are recent. Warsong lumber camps in Ashenvale, renegade clans loyal to the old ways, and the Alliance's long memory all press on Orgrimmar's gates. Thrall holds it together through sheer moral authority — and everyone knows it.]]
    f.culture = {
        biology = "Orcs are strong, green-skinned children of Draenor — a warrior culture rebuilding itself as shamanic clans under a single Warchief.",
        beliefs = "The elements, the ancestors, and the spirits of the land. Thrall restored shamanism as the orcish soul; warlocks are tolerated, not trusted.",
        relations = "Loathed by the Alliance, allied to Darkspear, tauren, and Forsaken by need and oath. The Horde is a family of survivors — and everyone else remembers the invasion.",
    }
    f.groups["frostwolf_clan"] = { name = "Frostwolf Clan", lore = "Thrall's own clan, holdout of the old shamanic ways. Drek'Thar still leads them in Alterac's valleys." }
    f.groups["warsong_clan"] = { name = "Warsong Clan", lore = "Grom Hellscream's clan — honored for his sacrifice, resented for the bloodlust it could not wash away." }
    f.figureText["thrall"] = { title = "Warchief of the Horde" }
    f.figureText["rexxar"] = { title = "Champion of the Horde — wanderer of the wilds" }
    f.figureText["eitrigg"] = { name = "Eitrigg", title = "Thrall's advisor — the orc Tirion Fordring saved" }
    f.settlementText[85] = { name = "Orgrimmar", lore = "The fortress city cut into Durotar's red rock — new capital of a people still deciding what they are." }
    f.settlementText[1]  = { name = "Durotar", lore = "The harsh red land Thrall claimed for the Horde, named for his father. Scorpids, quilboar, and hard-won pride." }
end

f = IMAGOdb.races["troll"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Trolls"
    f.source = "warcraft.wiki.gg/wiki/Jungle_troll"
    f.history = [[
The smallest tribe of a shattered empire. The jungle trolls of the Darkspear were driven from Stranglethorn and nearly destroyed on their island refuge — until Thrall's Horde arrived at the moment of their extinction.
Vol'jin swore his people's service to the Warchief — an oath that made them orphans within a Horde that tolerates them, and a tribe other trolls call weak. They dwell on the Echo Isles and in Orgrimmar's shadow, watching. The Darkspears have always survived by watching.]]
    f.culture = {
        biology = "Jungle trolls — tall, lean, tusked, and regenerating. The smallest and most adaptable tribe of a fallen empire.",
        beliefs = "The loa, the ancestors, and the shadow. Darkspear shadow hunters walk between worlds; their voodoo is older than orcish honor.",
        relations = "Bound to the Horde by oath and gratitude. Other troll tribes despise them; the Alliance barely distinguishes them. Their patience is legendary and total.",
    }
    f.groups["darkspear_tribe"] = { name = "Darkspear Tribe", lore = "Vol'jin's tribe — the Horde's trolls, loyal since Sen'jin's death on the isles." }
    f.groups["shadow_hunters"] = { name = "Shadow Hunters", lore = "Priest-hunters of the tribe — loa-touched killers who answer only to their chieftain." }
    f.figureText["voljin"] = { title = "Chieftain of the Darkspear tribe" }
    f.figureText["senjin"] = { name = "Sen'jin", title = "Vol'jin's father — died warning Thrall of the sea witch" }
    f.settlementText[1] = { name = "Echo Isles", lore = "The Darkspears' hard-won island home off Durotar's coast — won, lost, and won again." }
end

f = IMAGOdb.races["undead"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "The Forsaken"
    f.source = "warcraft.wiki.gg/wiki/Forsaken"
    f.history = [[
The dead who refused to stay down. When the Lich King's grip slipped, Sylvanas Windrunner led the free-willed undead to seize Lordaeron's ruins — and to ask, with their newfound will, what unlife was for.
The answer, so far: revenge, survival, and the Royal Apothecary Society's experiments in the Undercity's depths. Allied to the Horde out of necessity, feared by everyone including their allies, the Forsaken are a people defined entirely by what they will not forgive.]]
    f.culture = {
        biology = "Free-willed undead — the risen citizens of fallen Lordaeron. No reproduction; every Forsaken is a survivor of the Scourge's harvest.",
        beliefs = "The Cult of Forgotten Shadows — Light's doctrine inverted. Some cling to old faith; most believe only in free will, vengeance, and the Queen.",
        relations = "Horde members by treaty, pariahs by nature. The Scarlet Crusade hunts them; the Alliance refuses to believe they are people; the Horde finds them useful and unnerving in equal measure.",
    }
    f.groups["royal_apothecary_society"] = { name = "Royal Apothecary Society", lore = "The alchemists of the Undercity — officially curing undeath, unofficially brewing the next plague." }
    f.groups["deathguards"] = { name = "The Deathguard", lore = "The Forsaken's soldiers — dead men standing eternal watch over lands that buried them." }
    f.figureText["sylvanas_windrunner"] = { title = "Banshee Queen of the Forsaken" }
    f.figureText["varimathras"] = { title = "Dreadlord — Sylvanas' second, master of the Undercity" }
    f.figureText["master_apothecary_faranell"] = { name = "Master Apothecary Faranell", title = "Head of the Royal Apothecary Society" }
    f.settlementText[18] = { name = "The Undercity", lore = "Lordaeron's sewers and crypts beneath the ruins — throne room of the Banshee Queen." }
end

f = IMAGOdb.races["tauren"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Tauren"
    f.source = "warcraft.wiki.gg/wiki/Tauren"
    f.history = [[
Nomads for a thousand years, hunted nearly to extinction by the centaur — until a strange green army helped them reach Mulgore's mesas and stand finally still.
Cairne Bloodhoof united the tribes atop Thunder Bluff and swore a blood debt to Thrall. The tauren are the Horde's conscience: slow to anger, impossible to move, and — as the Grimtotem prove — not entirely united behind the High Chieftain's peaceful counsel.]]
    f.culture = {
        biology = "Towering, hoofed, and ancient. Tauren society is tribal — Bloodhoof, Grimtotem, and lesser tribes — bound by shared rites of hunt and earth.",
        beliefs = "The Earth Mother, the sky father An'she, and the hunt. Tauren druids and shamans serve balance; their druidism under Hamuul Runetotem is young but deep-rooted.",
        relations = "The Horde's most honorable member and its quietest skeptic. Peaceful by creed, terrifying when roused; the centaur war is eternal.",
    }
    f.groups["bloodhoof_tribe"] = { name = "Bloodhoof Tribe", lore = "The ruling tribe — Cairne's own, keepers of Mulgore and the alliance with Thrall." }
    f.groups["grimtotem_tribe"] = { name = "Grimtotem Tribe", lore = "The tribe that disagrees. Magatha's Grimtotem hold Thunder Bluff's heights and their own counsel — which rarely matches Cairne's." }
    f.figureText["cairne_bloodhoof"] = { title = "High Chieftain — uniter of the tauren tribes" }
    f.figureText["baine_bloodhoof"] = { name = "Baine Bloodhoof", title = "Cairne's son — Bloodhoof heir, centaur target" }
    f.figureText["magatha_grimtotem"] = { name = "Magatha Grimtotem", title = "Elder Crone — Cairne's rival on the bluff" }
    f.settlementText[88] = { name = "Thunder Bluff", lore = "Four mesas joined by bridges and lifts — the first permanent tauren city in a thousand years." }
    f.settlementText[7]  = { name = "Mulgore", lore = "The green homeland finally won — kodo herds, windfury harpy cliffs, and the promise of peace." }
end

-- ============================================================
-- BOTH FACTIONS (WoW Forever exclusive)
-- ============================================================

f = IMAGOdb.races["skyborne"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Skyborne"
    f.source = "warcraft.wiki.gg/wiki/Skyborne"
    f.history = [[
The winged people of the heights — new to Azeroth's factions and new to IMAGO's chronicle. The Skyborne arrive with WoW Forever itself: a race of sky-dwellers whose loyalty is unwritten.
What is known is thin — they claim Zephras Isle and its floating heights, they walk among both factions' envoys, and their arrival marks the first new people to enter Azeroth's story in years. What is unknown is everything else: their history, their gods, and what the sky kept for them.]]
    f.culture = {
        biology = "Winged humanoids of the sky-lands — the details of their origin are still being documented by IMAGO's chroniclers.",
        beliefs = "Unknown. Skyborne faith remains a gap in the archive — one of the first questions every explorer asks.",
        relations = "Playable for both factions — courted by Alliance and Horde alike, claimed by neither. Their allegiance will shape Forever's balance — and its story.",
    }
end

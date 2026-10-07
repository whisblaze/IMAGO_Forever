-- ============================================================
-- IMAGO Forever — locales/base/data/factions.lua (enUS fallback)
-- Localized faction texts. Static records (IDs, members,
-- settlements, subgroups keys) live in data/factions_static.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.factions = IMAGOdb.factions or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

local f = IMAGOdb.factions["kingdom_of_stormwind"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Kingdom of Stormwind"
    f.source = "warcraft.wiki.gg/wiki/Stormwind_(kingdom)"
    f.history = [[
The last great human kingdom. Stormwind fell to the Horde in the First War, was rebuilt in the Second, and now stands as the beating heart of the Alliance — proud, scarred, and deeply indebted.
With King Varian Wrynn lost at sea, the realm is ruled in his son's name by Regent Bolvar Fordragon, while the court whispers with the schemes of Lady Katrana Prestor. Stonemasons unpaid for the city's rebuilding turned to banditry, and the Defias plague the kingdom's breadbasket. Stormwind endures — but it is a kingdom held together by vigilance and debt.]]
    f.culture = {
        biology = "Humans of Stormwind are a hardy, short-lived people shaped by two wars and a rebuilt homeland. They prize martial tradition and civic pride.",
        beliefs = "The Church of the Holy Light is the kingdom's spiritual foundation, centered on the Cathedral of Light. Paladins and priests of the Silver Hand tradition hold honored places.",
        relations = "The anchor of the Alliance — close ties with Ironforge, the Gnomeregan exiles, and Darnassus. Hostile toward the Horde since the First War, though Theramore keeps a channel open.",
    }
    f.subgroups["house_of_nobles"] = { name = "House of Nobles", lore = "The squabbling aristocracy that rules in the boy-king's name. Too many debts, too many secrets — and one countess who is not what she seems." }
    f.subgroups["westfall_brigade"] = { name = "Westfall Brigade", lore = "The People's Militia holds the breadbasket against the Defias Brotherhood — unpaid, undermanned, and unbowed." }
    f.subgroups["si7"] = { name = "SI:7", lore = "Stormwind's intelligence service. Mathias Shaw's agents watch the kingdom's enemies — and sometimes its own court." }
    f.memberText["katrana_prestor"] = { name = "Lady Katrana Prestor", title = "Royal advisor — and more than she appears" }
    f.settlementText[84] = { name = "Stormwind City", lore = "The white-walled capital, rebuilt stone by stone after the First War. Its heroes' statues line the Valley of Heroes." }
end

f = IMAGOdb.factions["ironforge_dwarves"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Dwarves of Ironforge"
    f.source = "warcraft.wiki.gg/wiki/Kingdom_of_Ironforge"
    f.history = [[
Heirs of the earthen, the dwarves of Khaz Modan dug too deep and woke things best left buried — a history they repeat proudly. Ironforge has never fallen.
King Magni Bronzebeard holds the clans together through grief and grit: his brother Muradin dead in Northrend, his daughter Moira lost to the Dark Irons, his people split between mountain halls and surface wars. What Ironforge lacks in numbers it repays in stubbornness and steel.]]
    f.culture = {
        biology = "Stout, long-lived, and carved from the earth itself. Dwarven society runs on clan loyalty, craftsmanship, and ale.",
        beliefs = "A pragmatic faith — the Holy Light serves, but ancestors and the mysteries of the titans occupy the dwarven soul. The Explorers' League chases their titan-forged origins.",
        relations = "Stormwind's oldest ally and the Alliance's arsenal. Old grudges simmer against the Dark Irons and, less openly, against anyone who forgets dwarven sacrifices.",
    }
    f.subgroups["bronzebeard_clan"] = { name = "Bronzebeard Clan", lore = "The ruling clan of Ironforge, led by King Magni. Keepers of the mountain and of old debts." }
    f.subgroups["explorers_league"] = { name = "Explorers' League", lore = "Dwarven archaeologists who dig for titan relics across the world. Brann Bronzebeard leads their wildest expeditions." }
    f.memberText["moira_bronzebeard"] = { name = "Moira Bronzebeard", title = "King Magni's daughter — now Empress of the Dark Irons" }
    f.memberText["brann_bronzebeard"] = { name = "Brann Bronzebeard", title = "Explorer, chronicler, the wandering Bronzebeard" }
    f.settlementText[87] = { name = "Ironforge", lore = "The mountain city that has never fallen — a forge-heart of anvils, ale, and ancient stone." }
end

f = IMAGOdb.factions["gnomeregan_exiles"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Gnomeregan Exiles"
    f.source = "warcraft.wiki.gg/wiki/Gnomeregan_(nation)"
    f.history = [[
The gnomes lost everything in a single day. When troggs breached Gnomeregan, High Tinker Mekkatorque followed his advisor Thermaplugg's counsel and flooded the city with radiation — killing most of the invaders and most of his people.
Now a nation of refugees in Ironforge's Tinker Town, the gnomes bury their grief in invention. Mekkatorque has never stopped planning the reclamation, and some exiles have never forgiven him for ordering it.]]
    f.culture = {
        biology = "Small, brilliant, and long-lived. Gnomish society prizes engineering genius above birthright — the High Tinker is an elected office.",
        beliefs = "Gnomes place faith in physics more than priests. What little reverence exists points toward logic, invention, and the occasional machine that should not work but does.",
        relations = "Guests of Ironforge and loyal Alliance members, though some dwarves quietly resent housing a people who irradiated their own capital.",
    }
    f.subgroups["survivors_of_gnomeregan"] = { name = "Survivors of Gnomeregan", lore = "The irradiated city's refugees — engineers, soldiers, and the irradiated survivors nobody talks about. All of them want their city back." }
    f.memberText["sicco_thermaplugg"] = { name = "Sicco Thermaplugg", title = "The traitor — architect of Gnomeregan's fall" }
    f.settlementText[27] = { name = "Tinker Town, Ironforge", lore = "The exiles' quarter in Ironforge — part workshop, part refugee camp, entirely gnomish." }
end

f = IMAGOdb.factions["darnassus_night_elves"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Night Elves of Darnassus"
    f.source = "warcraft.wiki.gg/wiki/Darnassus_(nation)"
    f.history = [[
Ten thousand years ago the kaldorei broke the world to save it. Immortal then, they sacrificed Nordrassil to stop the Legion at Hyjal — and woke to find themselves mortal, diminished, and ruled from a World Tree planted without blessing.
Tyrande Whisperwind leads alone; Malfurion sleeps unwakeable in the Dream, and Fandral Staghelm grows bolder in his absence. The night elves' new tree, Teldrassil, is already sickening — though few will say so aloud.]]
    f.culture = {
        biology = "Tall, violet-skinned, once-immortal. The kaldorei are a martial-spiritual society divided between Elune's priestesses and the druids' Emerald Dream.",
        beliefs = "Elune, the Moon Goddess, is their faith absolute — the Sisterhood serves her from the Temple of the Moon. Druids answer to Cenarius and the Cenarion Circle instead.",
        relations = "Newest members of the Alliance and its most aloof. The Horde's lumber operations in Ashenvale have made neighbors into enemies.",
    }
    f.subgroups["sentinels"] = { name = "The Sentinels", lore = "The night elf army — huntresses, archers, and watchers commanded by Shandris Feathermoon." }
    f.subgroups["sisterhood_of_elune"] = { name = "Sisterhood of Elune", lore = "The priestesshood that has guided kaldorei society since before the Sundering. Tyrande stands at its head." }
    f.memberText["malfurion_stormrage"] = { name = "Malfurion Stormrage", title = "Archdruid — lost in the Emerald Dream" }
    f.settlementText[89] = { name = "Darnassus", lore = "The moonlit capital on Teldrassil's crown — a city grown, not built." }
    f.settlementText[57] = { name = "Teldrassil", lore = "The second World Tree, planted without the Aspects' blessing. Its corruption is already visible to those who look." }
end

f = IMAGOdb.factions["theramore"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Theramore"
    f.source = "warcraft.wiki.gg/wiki/Theramore_Isle"
    f.history = [[
A city built by refugees and held together by hope. Jaina Proudmoore led the survivors of Lordaeron across the sea, and on a swampy island in Dustwallow Marsh raised the last beacon of human power on Kalimdor.
Theramore is peace made flesh — proof that Alliance and Horde can share a world. It is also fragile: one border skirmish, one intercepted supply caravan, one hard year could sink it. Jaina knows this. She pays the price anyway.]]
    f.culture = {
        biology = "Mostly humans of Lordaeron and Kul Tiras stock, with elves, dwarves, and gnomes among the defenders. A soldier-settler society on a hostile frontier.",
        beliefs = "The Holy Light crossed the sea with them, but pragmatism rules — on Kalimdor, diplomacy is a survival doctrine.",
        relations = "Officially Alliance, personally allied with Thrall's Horde. Despised by hawks on both sides; indispensable to peace on both.",
    }
    f.subgroups["theramore_guard"] = { name = "Theramore Guard", lore = "The city-state's defenders — veterans of Hyjal who chose walls over war." }
    f.settlementText[70] = { name = "Theramore Isle", lore = "The white towers in the swamp — Alliance foothold, diplomatic bridge, and powder keg." }
end

-- ============================================================
-- HORDE
-- ============================================================

f = IMAGOdb.factions["orcs_of_the_horde"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Orcs of the Horde"
    f.source = "warcraft.wiki.gg/wiki/Orgrimmar_(faction)"
    f.history = [[
Born of the invading Horde, remade in internment camps, and freed by a slave who remembered what his people were. Thrall's orcs crossed the sea to a desert nobody wanted and named it for his father.
The new Horde is young and its sins are recent. Warsong lumber camps in Ashenvale, renegade clans loyal to the old ways, and the Alliance's long memory all press on Orgrimmar's gates. Thrall holds it together through sheer moral authority — and everyone knows it.]]
    f.culture = {
        biology = "Orcs are strong, green-skinned children of Draenor — a warrior culture rebuilding itself as shamanic clans under a single Warchief.",
        beliefs = "The elements, the ancestors, and the spirits of the land. Thrall restored shamanism as the orcish soul; warlocks are tolerated, not trusted.",
        relations = "Loathed by the Alliance, allied to Darkspear, tauren, and Forsaken by need and oath. The Horde is a family of survivors — and everyone else remembers the invasion.",
    }
    f.subgroups["frostwolf_clan"] = { name = "Frostwolf Clan", lore = "Thrall's own clan, holdout of the old shamanic ways. Drek'Thar still leads them in Alterac's valleys." }
    f.subgroups["warsong_clan"] = { name = "Warsong Clan", lore = "Grom Hellscream's clan — honored for his sacrifice, resented for the bloodlust it could not wash away." }
    f.memberText["eitrigg"] = { name = "Eitrigg", title = "Thrall's advisor — the orc Tirion Fordring saved" }
    f.settlementText[85] = { name = "Orgrimmar", lore = "The fortress city cut into Durotar's red rock — new capital of a people still deciding what they are." }
    f.settlementText[1]  = { name = "Durotar", lore = "The harsh red land Thrall claimed for the Horde, named for his father. Scorpids, quilboar, and hard-won pride." }
end

f = IMAGOdb.factions["darkspear_trolls"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Darkspear Trolls"
    f.source = "warcraft.wiki.gg/wiki/Darkspear_tribe"
    f.history = [[
The smallest tribe of a shattered empire. Driven from Stranglethorn, nearly destroyed on the Darkspear islands, the Darkspears survived only because Thrall's Horde arrived at the moment of their extinction.
Vol'jin swore his people's service to the Warchief — an oath that made them orphans within a Horde that tolerates them and trolls who call them weak. They dwell on the Echo Isles and in Orgrimmar's shadow, watching. The Darkspears have always survived by watching.]]
    f.culture = {
        biology = "Jungle trolls — tall, lean, tusked, and regenerating. The smallest and most adaptable tribe of a fallen empire.",
        beliefs = "The loa, the ancestors, and the shadow. Darkspear shadow hunters walk between worlds; their voodoo is older than orcish honor.",
        relations = "Bound to the Horde by oath and gratitude. Other troll tribes despise them; the Alliance barely distinguishes them. Their patience is legendary and total.",
    }
    f.subgroups["darkspear_shadow_hunters"] = { name = "Darkspear Shadow Hunters", lore = "Priest-hunters of the tribe — loa-touched killers who answer only to Vol'jin." }
    f.memberText["senjin"] = { name = "Sen'jin", title = "Vol'jin's father — died warning Thrall of the sea witch" }
    f.settlementText[1] = { name = "Echo Isles", lore = "The Darkspears' hard-won island home off Durotar's coast — won, lost, and won again." }
end

f = IMAGOdb.factions["the_forsaken"]
if f then
    f.memberText = f.memberText or {}
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
    f.subgroups["royal_apothecary_society"] = { name = "Royal Apothecary Society", lore = "The alchemists of the Undercity — officially curing undeath, unofficially brewing the next plague." }
    f.subgroups["deathguards"] = { name = "The Deathguard", lore = "The Forsaken's soldiers — dead men standing eternal watch over lands that buried them." }
    f.memberText["master_apothecary_faranell"] = { name = "Master Apothecary Faranell", title = "Head of the Royal Apothecary Society" }
    f.settlementText[18] = { name = "The Undercity", lore = "Lordaeron's sewers and crypts beneath the ruins — throne room of the Banshee Queen." }
end

f = IMAGOdb.factions["thunder_bluff_tauren"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Tauren of Thunder Bluff"
    f.source = "warcraft.wiki.gg/wiki/Thunder_Bluff_(faction)"
    f.history = [[
Nomads for a thousand years, hunted nearly to extinction by the centaur — until a strange green army helped them reach Mulgore's mesas and stand finally still.
Cairne Bloodhoof united the tribes atop Thunder Bluff and swore a blood debt to Thrall. The tauren are the Horde's conscience: slow to anger, impossible to move, and — as the Grimtotem prove — not entirely united behind the High Chieftain's peaceful counsel.]]
    f.culture = {
        biology = "Towering, hoofed, and ancient. Tauren society is tribal — Bloodhoof, Grimtotem, and lesser tribes — bound by shared rites of hunt and earth.",
        beliefs = "The Earth Mother, the sky father An'she, and the hunt. Tauren druids and shamans serve balance; their druidism under Hamuul Runetotem is young but deep-rooted.",
        relations = "The Horde's most honorable member and its quietest skeptic. Peaceful by creed, terrifying when roused; the centaur war is eternal.",
    }
    f.subgroups["bloodhoof_tribe"] = { name = "Bloodhoof Tribe", lore = "The ruling tribe — Cairne's own, keepers of Mulgore and the alliance with Thrall." }
    f.subgroups["grimtotem_tribe"] = { name = "Grimtotem Tribe", lore = "The tribe that disagrees. Magatha's Grimtotem hold Thunder Bluff's heights and their own counsel — which rarely matches Cairne's." }
    f.memberText["baine_bloodhoof"] = { name = "Baine Bloodhoof", title = "Cairne's son — Bloodhoof heir, centaur target" }
    f.memberText["magatha_grimtotem"] = { name = "Magatha Grimtotem", title = "Elder Crone — Cairne's rival on the bluff" }
    f.settlementText[88] = { name = "Thunder Bluff", lore = "Four mesas joined by bridges and lifts — the first permanent tauren city in a thousand years." }
    f.settlementText[7]  = { name = "Mulgore", lore = "The green homeland finally won — kodo herds, windfury harpy cliffs, and the promise of peace." }
end

-- ============================================================
-- OTHERS
-- ============================================================

f = IMAGOdb.factions["cenarion_circle"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Cenarion Circle"
    f.source = "warcraft.wiki.gg/wiki/Cenarion_Circle"
    f.history = [[
The druidic order sworn to the Emerald Dream and the wilds. Founded after the Sundering, led for millennia by Malfurion Stormrage — and now, with Malfurion unwakeable, commanded by his successor Fandral Staghelm.
The Circle's charge is vast: the Plaguelands' corruption, the Silithus threat, the Dream's growing sickness, and a new World Tree that Fandral planted and the Aspects refused to bless. Druids serve the balance — which means the Circle's neutrality often looks like indifference to both factions.]]
    f.culture = {
        biology = "Mostly night elf and tauren druids — two races' only shared institution. Membership transcends faction; so does the suspicion of outsiders.",
        beliefs = "The Emerald Dream, the wild gods, and Cenarius' teachings. Balance is doctrine: nature is not kind, and neither are its druids.",
        relations = "Neutral to both factions and indispensable to both. Both armies need druids at Silithus and the Plaguelands; neither can command them.",
    }
    f.subgroups["keepers_of_the_grove"] = { name = "Keepers of the Grove", lore = "Cenarius' sons — the half-stag guardians who walk between the Dream and the waking world." }
    f.subgroups["druids_of_the_circle"] = { name = "Druids of the Circle", lore = "Night elf and tauren druids bound to the Dream — healers of the land, regardless of whose banner flies over it." }
    f.memberText["malfurion_stormrage"] = { name = "Malfurion Stormrage", title = "First druid — lost in the Dream" }
    f.settlementText[80] = { name = "Moonglade", lore = "The untouchable vale where the Circle meets — neutral ground since before either faction existed." }
end

f = IMAGOdb.factions["argent_dawn"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Argent Dawn & Silver Hand"
    f.source = "warcraft.wiki.gg/wiki/Argent_Dawn"
    f.history = [[
The light that stayed lit in the Plaguelands. The Argent Dawn draws from both factions' refugees — paladins, priests, and soldiers who fight the Scourge regardless of flag.
At Light's Hope Chapel they hold the line the kingdoms abandoned. The Silver Hand's heirs — exiles like Tirion Fordring and survivors like Maxwell Tyrosus — keep the old oath alive in the world's graveyard, asking only one question of recruits: will you fight the darkness, or just the Horde?]]
    f.culture = {
        biology = "A self-selecting order — human, dwarf, and even Forsaken members bound by oath, not blood. Numbers are thin; conviction is not.",
        beliefs = "The Holy Light, stripped of politics. The Dawn's creed is the Silver Hand's old one: fight evil, wherever it festers and whoever serves it.",
        relations = "Neutral and trusted by both factions — the only force either will allow near the other's wounded. The Scarlet Crusade considers them traitors; the feeling is mutual.",
    }
    f.subgroups["brotherhood_of_the_light"] = { name = "Brotherhood of the Light", lore = "The Dawn's militant core — veterans who take the war to Naxxramas itself." }
    f.memberText["lord_maxwell_tyrosus"] = { name = "Lord Maxwell Tyrosus", title = "Commander at Light's Hope Chapel" }
    f.settlementText[23] = { name = "Light's Hope Chapel", lore = "The last consecrated ground in the Plaguelands — where the Dawn buries its dead and counts its victories." }
end

f = IMAGOdb.factions["goblin_cartels"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Goblin Cartels"
    f.source = "warcraft.wiki.gg/wiki/Goblin"
    f.history = [[
Profit's true believers. The goblin cartels — Steamwheedle chief among them — fought the Second War, bankrolled it, and emerged richer than either side.
They built Orgrimmar's walls, run the zeppelins, and own the world's neutral ports: Ratchet, Booty Bay, Gadgetzan, Everlook. Gazlowe and his peers owe allegiance to no flag, honor only contract, and maintain neutrality the way they maintain engines — profitably.]]
    f.culture = {
        biology = "Short, green, and long-minded. Goblin society is mercantile to the bone — status is wealth, loyalty is contractual.",
        beliefs = "Commerce, engineering, and explosives — in that order. Their only sacred institution is the ledger.",
        relations = "Neutral by design and indispensable by practice. Both factions buy goblin ships, goblin labor, and goblin silence; both suspect them entirely, correctly.",
    }
    f.subgroups["steamwheedle_cartel"] = { name = "Steamwheedle Cartel", lore = "The largest cartel — Ratchet, Booty Bay, Gadgetzan, Everlook. Gazlowe builds the Horde's towers for fair price." }
    f.subgroups["booty_bay"] = { name = "Booty Bay", lore = "The pirate-port franchise — nominally Steamwheedle, actually run by Baron Revilgaz and whoever can afford him." }
    f.memberText["baron_revilgaz"] = { name = "Baron Revilgaz", title = "Ruler of Booty Bay" }
    f.settlementText[11] = { name = "Ratchet", lore = "Gazlowe's port on the Barrens coast — where Alliance ships and Horde armies both dock, one at a time." }
    f.settlementText[71] = { name = "Gadgetzan", lore = "The desert trade hub — steam-powered neutrality in Tanaris' bleached bones." }
end

f = IMAGOdb.factions["skyborne"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Skyborne"
    f.source = "warcraft.wiki.gg/wiki/Skyborne"
    f.history = [[
The winged people of the heights — new to Azeroth's faction politics and new to IMAGO's chronicle. The Skyborne arrive with WoW Forever itself: a race of sky-dwellers whose loyalty is unwritten.
What is known is thin — they claim Zephras Isle and its floating heights, they walk among both factions' envoys, and their arrival marks the first new people to enter Azeroth's story in years. What is unknown is everything else: their history, their gods, and what the sky kept for them.]]
    f.culture = {
        biology = "Winged humanoids of the sky-lands — the details of their origin are still being documented by IMAGO's chroniclers.",
        beliefs = "Unknown. Skyborne faith remains a gap in the archive — one of the first questions every explorer asks.",
        relations = "Courted by both factions and claimed by neither. Their allegiance will shape Forever's balance — and its story.",
    }
end

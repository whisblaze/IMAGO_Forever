-- ============================================================
-- IMAGO Forever — locales/base/data/timeline.lua (enUS fallback)
-- Localized Timeline text: era names, era range labels, and
-- title / yearLabel / body per event slug.
-- Structure (eras, year sort keys, related) lives in
-- data/timeline_static.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}
IMAGOdb.timeline.events = IMAGOdb.timeline.events or {}

IMAGOdb.timelineEraNames = {
    mythos       = "Dawn of Creation",
    kaldorei     = "Age of the Kaldorei",
    long_vigil   = "The Long Vigil",
    kingdoms     = "Age of Mortal Kingdoms",
    fall_draenor = "The Fall of Draenor",
    great_wars   = "The Great Wars",
    present      = "The Present Age",
}

IMAGOdb.timelineEraRanges = {
    mythos       = "(-∞  –  c. -15,000 DP)",
    kaldorei     = "(c. -15,000 – -10,000 DP)",
    long_vigil   = "(c. -10,000 – -2,800 DP)",
    kingdoms     = "(c. -2,800 – -18 DP)",
    fall_draenor = "(-45 – -1 DP)",
    great_wars   = "(0 – 21 ADP)",
    present      = "(22 ADP – today)",
}

local ev = IMAGOdb.timeline.events

-- ============ ERA 1: DAWN OF CREATION ============

if ev["creation_universe"] then
    ev["creation_universe"].title = "The Creation of the Cosmos"
    ev["creation_universe"].yearLabel = "Before Recorded Time"
    ev["creation_universe"].body = [[
Before the cosmos took shape, only the Light existed - a boundless sea of living energy. Yet as it expanded and its energies faded, pockets of cold void remained. These pockets merged and coalesced to form a second primordial force. The Void was a dark and vampiric power that sought to devour all energy. The growing tension between these two opposing energies eventually erupted in a series of catastrophic explosions. In that moment, the physical universe was born, which is also known as the Great Dark Beyond. The most unstable energies coalesced to form the chaotic astral dimension of the Twisting Nether.

Shards of Light were flung throughout the universe, suffusing countless worlds with the spark of life. Most commonly, they gave rise to elemental spirits. Yet where the fractured Light gathered into clouds, the naaru emerged. They vowed to protect life. Meanwhile, the world-souls of the nascent titans slumbered within the fiery cores of a few worlds. When these colossal beings awoke, they set out in search of more of their kind, with the goal of bringing order to the young universe.]]
end

if ev["old_gods_come"] then
    ev["old_gods_come"].title = "The Coming of the Old Gods"
    ev["old_gods_come"].yearLabel = "Unknown Date"
    ev["old_gods_come"].body = [[
Void lords hurl the Old Gods across the cosmos like seeds of corruption, tasked with finding and twisting unborn worldsouls. Several of them crash into Azeroth and enslave the world's Elemental Lords.

For an age beyond counting, the Black Empire of the Old Gods rules Azeroth's surface — until the titans' arrival ends their reign.]]
end

if ev["ordering_azeroth"] then
    ev["ordering_azeroth"].title = "The Ordering of Azeroth"
    ev["ordering_azeroth"].yearLabel = "c. -147,000 DP"
    ev["ordering_azeroth"].body = [[
The titan Pantheon discovers Azeroth in the grip of the Old Gods and wages war upon them. Unable to destroy the parasites without killing the worldsoul, the titans instead imprison them deep beneath the earth.

Their keepers and the titan-forged — earthen, vrykul, giants and mechagnomes — shape the young world, seed life and raise the machines of Ulduar, Uldaman and Uldum. Azeroth is ordered, and the titans move on, leaving watchers behind.]]
end

if ev["sargeras_fall"] then
    ev["sargeras_fall"].title = "The Fall of Sargeras"
    ev["sargeras_fall"].yearLabel = "Unknown Date"
    ev["sargeras_fall"].body = [[
TODO — write event text (see TIMELINE_SOURCES.md, event 3a)]]
end

if ev["charge_dragonflights"] then
    ev["charge_dragonflights"].title = "Charge of the Dragonflights"
    ev["charge_dragonflights"].yearLabel = "c. -20,285 DP"
    ev["charge_dragonflights"].body = [[
After the proto-dragons bring down the monstrous Galakrond, the titan keepers empower five of their number as the Dragon Aspects: Alexstrasza of life, Malygos of magic, Neltharion of earth, Nozdormu of time and Ysera of the Dream.

The dragonflights are charged with guarding Azeroth — a duty that will one day be twisted into tragedy.]]
end

if ev["aqir_troll_war"] then
    ev["aqir_troll_war"].title = "The Aqir and Troll War"
    ev["aqir_troll_war"].yearLabel = "c. -16,000 DP"
    ev["aqir_troll_war"].body = [[
The trolls, earliest great mortal civilization of Azeroth, rise on the slopes of primordial Kalimdor and forge the Empire of Zul. When the insectoid aqir — last servants of the Old Gods — threaten the world, the troll tribes unite against them.

After generations of war the aqir are shattered; their survivors flee to the far corners and become the ancestors of the qiraji, the nerubians and the mantid. The trolls enter their golden age.]]
end

if ev["curse_flesh"] then
    ev["curse_flesh"].title = "The Curse of Flesh"
    ev["curse_flesh"].yearLabel = "c. -15,000 DP"
    ev["curse_flesh"].body = [[
Even imprisoned, the Old Gods reach outward. Their Curse of Flesh slowly transforms the titan-forged — creatures of metal and stone — into beings of living flesh.

From the afflicted vrykul descend the first humans; from the mechagnomes, the gnomes; from the earthen, the dwarves. Mortality itself is the Old Gods' lasting poison.]]
end

if ev["rise_kaldorei"] then
    ev["rise_kaldorei"].title = "Rise of the Kaldorei"
    ev["rise_kaldorei"].yearLabel = "c. -15,000 DP"
    ev["rise_kaldorei"].body = [[
A tribe of dark trolls migrates to the shores of the Well of Eternity, a lake of raw arcane power at the heart of ancient Kalimdor. Over generations the Well's energies transform them into a new race — the kaldorei, the night elves.

They master arcane magic, raise glittering cities, and reshape the land itself. Yet some among them warn that the Well's power has a price — warnings that go unheeded.]]
end

-- ============ ERA 2: AGE OF THE KALDOREI ============

if ev["highborne_empire"] then
    ev["highborne_empire"].title = "Azshara and the Highborne"
    ev["highborne_empire"].yearLabel = "c. -13,500 DP"
    ev["highborne_empire"].body = [[
Under Queen Azshara, the night elf empire reaches its zenith. Her favored courtiers — the Highborne — delve ever deeper into the Well of Eternity, certain its power is theirs by right.

Their reckless experiments send ripples of arcane energy through the Twisting Nether, and something vast and hungry takes notice.]]
end

if ev["corruption_eredar"] then
    ev["corruption_eredar"].title = "The Corruption of the Eredar"
    ev["corruption_eredar"].yearLabel = "c. -13,000 DP"
    ev["corruption_eredar"].body = [[
On the distant world of Argus, Sargeras corrupts the eredar, offering power in exchange for service in his Burning Legion. Archimonde and Kil'jaeden accept; the prophet Velen refuses and flees with his followers aboard the Genedar.

The Legion names the exiles "draenei" — the Exiled Ones — and hunts them across the cosmos. Their flight will one day end on a world called Draenor.]]
end

if ev["war_ancients"] then
    ev["war_ancients"].title = "The War of the Ancients"
    ev["war_ancients"].aliases = { "War of the Ancients" }
    ev["war_ancients"].yearLabel = "-10,000 DP"
    ev["war_ancients"].body = [[
Drawn by the Highborne's magic, Sargeras chooses Azeroth for conquest. Queen Azshara, promised a world reshaped for her glory, helps open a portal through which the Burning Legion pours into the world and lays waste to the kaldorei civilization.

Malfurion Stormrage, Tyrande Whisperwind and Illidan lead the desperate resistance, joined by dragons, demigods and mortals of every kind — the first great war for Azeroth's soul.]]
end

if ev["the_sundering"] then
    ev["the_sundering"].title = "The Great Sundering"
    ev["the_sundering"].aliases = { "the Sundering" }
    ev["the_sundering"].yearLabel = "-10,000 DP"
    ev["the_sundering"].body = [[
To stop Sargeras himself from crossing over, the defenders destroy the Well of Eternity. Its implosion shatters the world: eighty percent of Kalimdor sinks beneath the waves, leaving only scattered continents behind.

Azshara and her Highborne are swallowed by the sea and reborn as the naga. The Sundering ends the night elves' golden age — and births the world map known to this day.]]
end

if ev["nordrassil_hyjal"] then
    ev["nordrassil_hyjal"].title = "Mount Hyjal and Illidan's Gift"
    ev["nordrassil_hyjal"].yearLabel = "-10,000 DP"
    ev["nordrassil_hyjal"].body = [[
On Mount Hyjal, the world tree Nordrassil is planted — and beneath it Illidan pours a stolen vial of the Well of Eternity, creating a second font of arcane power. For this deed he is imprisoned for ten thousand years.

Blessed by the Dragon Aspects, Nordrassil grants the night elves vitality and a bond to the Emerald Dream — a fragile new beginning on the ashes of the old world.]]
end

-- ============ ERA 3: THE LONG VIGIL ============

if ev["sentinels_vigil"] then
    ev["sentinels_vigil"].title = "The Sentinels and the Long Vigil"
    ev["sentinels_vigil"].yearLabel = "c. -9,400 DP"
    ev["sentinels_vigil"].body = [[
Rebuilding among the forests of Ashenvale, the night elves reshape their society: Tyrande leads through the Sisterhood of Elune, the Sentinel army stands guard, and Malfurion teaches the first druids — who will sleep for ages within the Emerald Dream.

A veil of mist shrouds Kalimdor from the outside world. For nearly ten thousand years, the night elves keep their watch alone.]]
end

if ev["war_satyr"] then
    ev["war_satyr"].title = "The War of the Satyr"
    ev["war_satyr"].yearLabel = "c. -9,300 DP"
    ev["war_satyr"].body = [[
Kaldorei twisted into satyrs by the Legion raise a demonic army against Ashenvale. In desperation, the Druids of the Pack unleash the forbidden pack form — and lose themselves to the savagery of the first worgen.

Malfurion banishes the feral worgen into the Emerald Dream. Both victories carry seeds of a curse that will sleep for millennia.]]
end

if ev["exile_highborne"] then
    ev["exile_highborne"].title = "Exile of the Highborne"
    ev["exile_highborne"].yearLabel = "-7,300 DP"
    ev["exile_highborne"].body = [[
The surviving Highborne refuse to abandon arcane magic. When the kaldorei outlaw it, they are exiled — sailing east across the sea to the lands that will become the Eastern Kingdoms.

Under the sun their violet hue fades, and the exiles begin to become something new: the high elves. Their severance from the night elves is permanent.]]
end

if ev["founding_quelthalas"] then
    ev["founding_quelthalas"].title = "The Founding of Quel'Thalas"
    ev["founding_quelthalas"].yearLabel = "-6,800 DP"
    ev["founding_quelthalas"].body = [[
On the northernmost edge of the Eastern Kingdoms — atop sacred Amani ground — the Highborne found the kingdom of Quel'Thalas, sustained by a new fount of power: the Sunwell.

Silvermoon rises as one of the most beautiful cities ever built, and the high elves prosper — while the displaced trolls of Zul'Aman nurse a hatred that will never die.]]
end

if ev["andrassil_vordrassil"] then
    ev["andrassil_vordrassil"].title = "Fandral and the Fall of Andrassil"
    ev["andrassil_vordrassil"].yearLabel = "-4,500 DP"
    ev["andrassil_vordrassil"].body = [[
Without the Cenarion Circle's consent, Archdruid Fandral Staghelm plants branches of Nordrassil across the world to halt the spread of saronite — the black blood of the Old God Yogg-Saron.

The greatest cutting, Andrassil, grows into a world tree in the Grizzly Hills — but is corrupted at its roots and must be felled. Renamed Vordrassil, it stands as proof of what Fandral's pride can cost.]]
end

if ev["arathor_troll_wars"] then
    ev["arathor_troll_wars"].title = "Arathor and the Troll Wars"
    ev["arathor_troll_wars"].yearLabel = "-2,800 DP"
    ev["arathor_troll_wars"].body = [[
Human tribes unite as the kingdom of Arathor — and when Quel'Thalas begs for aid against the resurgent Amani, humanity marches north. Together, elves and men break the troll empire forever.

In gratitude, the high elves teach one hundred humans the arcane arts. Magic has come to mankind — with consequences no one yet foresees.]]
end

-- ============ ERA 4: AGE OF MORTAL KINGDOMS ============

if ev["council_tirisfal"] then
    ev["council_tirisfal"].title = "The Council and Guardian of Tirisfal"
    ev["council_tirisfal"].yearLabel = "-2,610 DP"
    ev["council_tirisfal"].body = [[
Humanity's reckless new mages draw demons back to Azeroth. The magi of Dalaran form the secret Council of Tirisfal to hunt them — and soon learn to pour their combined power into a single champion: the Guardian of Tirisfal.

Each Guardian serves for a century before passing the mantle on. For thousands of years the line holds — until the greatest Guardian of all becomes the Legion's unwitting gate.]]
end

if ev["awakening_dwarves"] then
    ev["awakening_dwarves"].title = "The Awakening of the Dwarves"
    ev["awakening_dwarves"].yearLabel = "-2,500 DP"
    ev["awakening_dwarves"].body = [[
The earthen of Uldaman — long slumbering, softened by the Curse of Flesh — awaken as the first dwarves. Migrating west, they carve the mountain kingdom of Khaz Modan and raise Ironforge.

Their gnome cousins settle beside them in Gnomeregan, and a friendship of stone and gear is forged that endures to this day.]]
end

if ev["seven_kingdoms"] then
    ev["seven_kingdoms"].title = "The Seven Kingdoms"
    ev["seven_kingdoms"].yearLabel = "-1,200 DP"
    ev["seven_kingdoms"].body = [[
Arathor fractures. From its far-flung city-states arise seven human kingdoms: Lordaeron, Alterac, Gilneas, Dalaran, Stromgarde, Kul Tiras — and far to the south, Stormwind.

They trade and feud as rivals do, each proud and independent. When the Horde eventually comes, this disunity will nearly cost humanity the world.]]
end

if ev["war_shifting_sands"] then
    ev["war_shifting_sands"].title = "The War of the Shifting Sands"
    ev["war_shifting_sands"].yearLabel = "-975 DP"
    ev["war_shifting_sands"].body = [[
The qiraji of Ahn'Qiraj awaken under their Old God master and swarm across Kalimdor. Fandral Staghelm leads night elves and dragons in a grinding war that seals the insectoid empire behind the Scarab Wall.

Victory costs him his son Valstann — a wound that shapes the archdruid's fate, and leaves the sealed horror beneath Silithus merely waiting.]]
end

if ev["aegwynn_tomb"] then
    ev["aegwynn_tomb"].title = "Aegwynn and the Tomb of Sargeras"
    ev["aegwynn_tomb"].yearLabel = "-823 DP"
    ev["aegwynn_tomb"].body = [[
Aegwynn, the most powerful Guardian ever to hold the mantle, faces an avatar of Sargeras himself in Northrend — and wins. She buries the fallen titan's form beneath the sunken ruins of Suramar, the Tomb of Sargeras.

But the Dark Titan's spirit is cunning: unseen, it hides within Aegwynn, waiting. When she conceives a son, that spirit passes silently into the child — Medivh.]]
end

if ev["orcish_clans"] then
    ev["orcish_clans"].title = "The Orcish Clans of Draenor"
    ev["orcish_clans"].yearLabel = "c. -800 DP"
    ev["orcish_clans"].body = [[
On the red world of Draenor, orcish clans spread across the land — Frostwolves, Warsong, Shadowmoon, Blackrock and a dozen more — proud, fierce and bound to shamanic tradition.

At the Throne of the Elements their shaman commune with the spirits, and at Oshu'gun they honor their ancestors. Twice a year the clans gather at the Kosh'harg festival — in peace. It is the last peace Draenor will know.]]
end

if ev["war_three_hammers"] then
    ev["war_three_hammers"].title = "War of the Three Hammers"
    ev["war_three_hammers"].yearLabel = "-230 DP"
    ev["war_three_hammers"].body = [[
When High King Modimus Anvilmar dies without an heir, the Bronzebeard, Wildhammer and Dark Iron clans turn on each other for Ironforge. The Bronzebeards win; the Wildhammers withdraw to Grim Batol; the Dark Irons flee south.

In vengeful desperation, Emperor Thaurissan summons a power he cannot control: Ragnaros the Firelord tears into the world, enslaving the Dark Irons beneath what becomes Blackrock Mountain.]]
end

if ev["draenei_draenor"] then
    ev["draenei_draenor"].title = "The Draenei Reach Draenor"
    ev["draenei_draenor"].yearLabel = "-200 DP"
    ev["draenei_draenor"].body = [[
After millennia of flight, Velen's exiles crash-land on a quiet red world and name it Draenor — the Exiles' Refuge. They raise Shattrath, the Temple of Karabor and the necropolis of Auchindoun.

For two centuries the draenei live in peace beside the orcish clans — unaware that the Burning Legion has found them once more.]]
end

if ev["gurubashi_war"] then
    ev["gurubashi_war"].title = "The Gurubashi War"
    ev["gurubashi_war"].yearLabel = "-18 DP"
    ev["gurubashi_war"].body = [[
Enraged by human expansion into Stranglethorn Vale, the Gurubashi trolls rally under Zan'non and march on Stormwind itself. King Barathen Wrynn falls in the siege.

Only the reluctant, world-shaking magic of young Medivh — first public display of the Guardian's power — saves the city. The trolls retreat, but the jungle keeps its grudges.]]
end

-- ============ ERA 5: THE FALL OF DRAENOR ============

if ev["medivh_born"] then
    ev["medivh_born"].title = "The Birth of Medivh"
    ev["medivh_born"].yearLabel = "-45 DP"
    ev["medivh_born"].body = [[
Aegwynn bears a son by the mage Nielas Aran: Medivh, heir to the power of Tirisfal — and, unknown to all, vessel of the buried spirit of Sargeras.

When the boy's power erupts at fourteen, it kills his father and casts Medivh into years of coma. He awakens seemingly himself — but the Dark Titan's shadow now steers the greatest Guardian the world has known.]]
end

if ev["guldan_fel"] then
    ev["guldan_fel"].title = "Gul'dan and the Fel Pact"
    ev["guldan_fel"].yearLabel = "-10 DP"
    ev["guldan_fel"].body = [[
Exiled and scorned by his own clan, the orc Gul'dan answers Kil'jaeden's whisper and becomes the first orcish warlock. He floods the Throne of the Elements with fel, silencing the elements that once guided his people.

Cut off from the spirits, desperate and afraid, the orcish clans become easy prey for the lie the Legion is about to sell them.]]
end

if ev["horde_forms"] then
    ev["horde_forms"].title = "The Horde is Forged"
    ev["horde_forms"].yearLabel = "-8 DP"
    ev["horde_forms"].body = [[
Gul'dan's agents manufacture a war: the Bladewind clan is slaughtered and the crime blamed on the draenei. Enraged, the chieftains unite the clans into a single war-machine — the Horde.

Elder shaman Ner'zhul, first tool of the deception, discovers Kil'jaeden's lies too late; his apprentice Gul'dan has him caged. The Horde now answers to the Legion's puppet.]]
end

if ev["draenei_genocide"] then
    ev["draenei_genocide"].title = "Genocide of the Draenei"
    ev["draenei_genocide"].yearLabel = "-7 – -3 DP"
    ev["draenei_genocide"].body = [[
The Horde turns on its peaceful neighbors. Village by village, city by city, the draenei are hunted and slaughtered across Draenor while their world itself dies beneath the fel.

Survivors hiding in the Zangar marshes are twisted by the red mist into the Broken — pitied, feared and finally exiled by their own kin. A culture of two hundred years is erased in four.]]
end

if ev["shadow_council"] then
    ev["shadow_council"].title = "Blackhand and the Shadow Council"
    ev["shadow_council"].yearLabel = "-6 DP"
    ev["shadow_council"].body = [[
To rule the Horde visibly, Gul'dan raises the brutal, popular chieftain Blackhand as its first Warchief. To rule it in truth, he founds the Shadow Council — a hidden conclave of warlocks, assassins and spies.

Clans are reshaped into instruments: Warsong becomes cavalry, Blackrock the iron fist, Twilight's Hammer the cult of the end times. Even chieftains who speak out are quietly murdered.]]
end

if ev["blood_mannoroth"] then
    ev["blood_mannoroth"].title = "The Blood of Mannoroth"
    ev["blood_mannoroth"].yearLabel = "-3 DP"
    ev["blood_mannoroth"].body = [[
At the base of a corrupted mountain, Gul'dan offers the chieftains a chalice of demon blood. One after another they drink the blood of Mannoroth — gaining berserker strength, and binding the entire orc race to the Burning Legion.

Only a few refuse: Orgrim Doomhammer, and Durotan's Frostwolves. Those who drank see their skin turn sickly green — the mark every orc still bears.]]
end

if ev["shattrath_falls"] then
    ev["shattrath_falls"].title = "The Fall of Shattrath and Karabor"
    ev["shattrath_falls"].yearLabel = "-3 DP"
    ev["shattrath_falls"].body = [[
Drunk on fel and demon blood, the Horde storms the draenei's last bastions. Karabor is shattered and darkened into the Black Temple; Shattrath is drowned in plague-mist and rubble.

Velen leads the survivors into hiding in Telredor. To the victors, Draenor is now a dying world with nothing left to conquer — until a robed stranger from across the stars offers them a new one.]]
end

if ev["dark_portal_built"] then
    ev["dark_portal_built"].title = "The Dark Portal is Built"
    ev["dark_portal_built"].yearLabel = "-1 DP"
    ev["dark_portal_built"].body = [[
Medivh — or the thing inside him — appears to Gul'dan in dreams, offering the Horde a fertile new world and showing the warlock the Tomb of Sargeras as bait.

Together, Guardian and warlock raise the greatest portal ever built. In the Blasted Lands, stone frames the void — and behind it, Azeroth waits unknowing.]]
end

-- ============ ERA 6: THE GREAT WARS ============

if ev["dark_portal_opens"] then
    ev["dark_portal_opens"].title = "The Opening of the Dark Portal"
    ev["dark_portal_opens"].aliases = { "the Dark Portal" }
    ev["dark_portal_opens"].yearLabel = "0 DP"
    ev["dark_portal_opens"].body = [[
The Dark Portal ignites and the Horde pours through into Azeroth — the hinge on which all modern history turns. Everything before this moment is "DP": years before the Portal.

Swamp-skirmishes follow, dismissed in Stormwind as monster tales. In the north, Khadgar becomes apprentice to the Guardian Medivh and befriends the half-orc Garona — and begins to suspect his master's shadow.]]
end

if ev["first_war"] then
    ev["first_war"].title = "The First War"
    ev["first_war"].yearLabel = "0 – 3 ADP"
    ev["first_war"].body = [[
Orcish warbands sweep north and west through Stormwind's lands, razing villages as they come. The kingdom's knights win battles — Brightwood, Redridge — but cannot stem the tide.

Khadgar and Garona finally confront Medivh at Karazhan; the Guardian dies by his apprentice's hand, and his death-blast scars the land into Deadwind Pass. But the Horde still stands.]]
end

if ev["fall_stormwind"] then
    ev["fall_stormwind"].title = "The Fall of Stormwind"
    ev["fall_stormwind"].yearLabel = "3 ADP"
    ev["fall_stormwind"].body = [[
Orgrim Doomhammer kills Warchief Blackhand in single combat and leads the Horde's final siege on Stormwind City. In the hour of crisis, Garona — compelled by Gul'dan's old commands — assassinates King Llane in his own keep.

The city burns and falls. Anduin Lothar gathers the survivors onto ships and flees north to Lordaeron — carrying warning, and a plea for alliance.]]
end

if ev["alliance_lordaeron"] then
    ev["alliance_lordaeron"].title = "The Alliance of Lordaeron"
    ev["alliance_lordaeron"].yearLabel = "4 – 5 ADP"
    ev["alliance_lordaeron"].body = [[
Lothar's refugees reach Capital City and the Seven Kingdoms convene. For the first time, humanity unites: the Alliance of Lordaeron is born, joined by dwarves, gnomes and — honoring an ancient debt — the high elves.

Archbishop Faol and Lothar found the Order of the Silver Hand; the first paladins take the field. Meanwhile the Horde conquers Khaz Modan, binds the red dragonflight at Grim Batol, and sails north.]]
end

if ev["second_war"] then
    ev["second_war"].title = "The Second War"
    ev["second_war"].yearLabel = "5 – 6 ADP"
    ev["second_war"].body = [[
The greatest war the world has known rages across the Eastern Kingdoms: Hillsbrad burns, the Wildhammers are battered, Zul'jin's Amani join the Horde, and Quel'Thalas itself is breached.

At the walls of Capital City, Gul'dan betrays the Horde — sailing for the Tomb of Sargeras to claim its power, and finding only death. The shattered offensive collapses, and the Alliance sweeps south.]]
end

if ev["siege_blackrock"] then
    ev["siege_blackrock"].title = "The Siege of Blackrock Spire"
    ev["siege_blackrock"].yearLabel = "6 ADP"
    ev["siege_blackrock"].body = [[
The Alliance corners the Horde at Blackrock Mountain. Doomhammer slays Anduin Lothar in single combat — but Turalyon takes up the broken sword, rallies the broken army, and wins the day anyway.

Doomhammer is chained. Khadgar destroys the Dark Portal — though a rift between the worlds remains. The Second War is over; the Eastern Kingdoms begin, slowly, to heal.]]
end

if ev["invasion_draenor"] then
    ev["invasion_draenor"].title = "The Invasion of Draenor"
    ev["invasion_draenor"].yearLabel = "8 ADP"
    ev["invasion_draenor"].body = [[
The elder shaman Ner'zhul seizes Azerothian artifacts and re-opens the Portal to flee his dying world. The Alliance answers by invading Draenor itself — the Sons of Lothar, led by Turalyon, Alleria and Khadgar.

Ner'zhul's reckless portal ritual tears Draenor apart into the floating wreck called Outland. Khadgar seals the Portal behind him, trapping the expedition on a broken world — heroes presumed lost forever.]]
end

if ev["birth_lich_king"] then
    ev["birth_lich_king"].title = "The Birth of the Lich King"
    ev["birth_lich_king"].yearLabel = "8 ADP"
    ev["birth_lich_king"].body = [[
Fleeing through the rifts, Ner'zhul falls into Kil'jaeden's hands. His body is destroyed; his spirit is bound into a crystal of ice and hurled at Azeroth — the Frozen Throne.

The Lich King is born in Northrend, armed with the Plague of Undeath and one purpose: to soften Azeroth for the Legion's return. From his throne he begins to whisper — and Kel'Thuzad answers.]]
end

if ev["grim_batol"] then
    ev["grim_batol"].title = "The Battle of Grim Batol"
    ev["grim_batol"].yearLabel = "c. 10 ADP"
    ev["grim_batol"].body = [[
TODO — write event text (see TIMELINE_SOURCES.md, event 43a)]]
end

if ev["thrall_new_horde"] then
    ev["thrall_new_horde"].title = "Thrall and the New Horde"
    ev["thrall_new_horde"].yearLabel = "15 – 18 ADP"
    ev["thrall_new_horde"].body = [[
In the internment camps, the defeated orcs sink into lethargy — until Thrall, son of Durotan, raised as a human's slave-gladiator, escapes Durnholde. Taught his heritage by Grom Hellscream and Orgrim Doomhammer, he inherits the mantle of Warchief.

Thrall frees the camps one by one and reforges the Horde on shamanic honor instead of demon blood. The Alliance, bled dry by camp costs, fractures: Quel'Thalas, Gilneas and Stromgarde walk out.]]
end

if ev["third_war"] then
    ev["third_war"].title = "The Third War"
    ev["third_war"].yearLabel = "20 ADP"
    ev["third_war"].body = [[
The Plague of Undeath sweeps Lordaeron. Prince Arthas Menethil pursues it past all mercy — culling Stratholme, sailing to Northrend, taking up Frostmourne, and returning as the Lich King's death knight to murder his father and his kingdom.

Silvermoon falls; the Sunwell is defiled to raise Kel'Thuzad; Dalaran is shattered summoning Archimonde. Meanwhile Thrall's Horde — warned by the reborn Medivh — sails west to Kalimdor and meets its destiny.]]
end

if ev["battle_hyjal"] then
    ev["battle_hyjal"].title = "The Battle of Mount Hyjal"
    ev["battle_hyjal"].yearLabel = "21 ADP"
    ev["battle_hyjal"].body = [[
At Medivh's urging, mortal enemies make impossible peace: Jaina's humans, Thrall's Horde and Tyrande's night elves hold the slopes of Mount Hyjal together while the wisps gather.

When Archimonde climbs to seize the World Tree, the defenders detonate the spirits of ten thousand years — destroying the demon lord and, with him, the Burning Legion's third invasion. The mortal races have saved their world.]]
end

-- ============ ERA 7: THE PRESENT AGE ============

if ev["ascension_lich_king"] then
    ev["ascension_lich_king"].title = "Ascension of the Lich King"
    ev["ascension_lich_king"].yearLabel = "22 ADP"
    ev["ascension_lich_king"].body = [[
Illidan's failed ritual to shatter the Frozen Throne leaves the Lich King bleeding power. Arthas races to Icecrown, defeats Illidan at the glacier's foot, and ascends the Frozen Throne — donning the Helm of Domination.

Arthas Menethil and Ner'zhul become one: the true Lich King. He sleeps now in Icecrown — and dreams of the living.]]
end

if ev["forsaken_rise"] then
    ev["forsaken_rise"].title = "Rise of the Forsaken"
    ev["forsaken_rise"].yearLabel = "22 ADP"
    ev["forsaken_rise"].body = [[
As the Lich King's grip weakens, the banshee Sylvanas Windrunner breaks free — and leads the sentient undead of the Plaguelands in revolt against their master.

Cast out by the living, hunted by the Scourge, the Forsaken claim the ruins beneath Lordaeron as the Undercity. Their queen's question will shape the Horde's future: who will shelter the dead?]]
end

if ev["teldrassil"] then
    ev["teldrassil"].title = "The Planting of Teldrassil"
    ev["teldrassil"].yearLabel = "23 ADP"
    ev["teldrassil"].body = [[
Denied the Aspects' blessing, Fandral Staghelm leads the planting of a second World Tree — Teldrassil, off the coast of Darkshore — to restore the night elves' lost immortality.

Darnassus rises in its boughs. Yet without the dragons' blessing, corruption already gnaws at its roots.]]
end

if ev["durotar_founded"] then
    ev["durotar_founded"].title = "The Founding of Durotar"
    ev["durotar_founded"].yearLabel = "23 ADP"
    ev["durotar_founded"].body = [[
On Kalimdor's eastern coast, Thrall's orcs settle the harsh red land of Durotar, raising Orgrimmar — named for the fallen Doomhammer — as their capital. Tauren under Cairne Bloodhoof and Darkspear trolls under Vol'jin stand beside them.

When Admiral Proudmoore's fleet lands to crush the Horde, Rexxar and the mok'nathal help repel him. Jaina chooses peace over her father — a wound between Theramore and Stormwind that never fully closes.]]
end

if ev["forsaken_horde"] then
    ev["forsaken_horde"].title = "The Forsaken Join the Horde"
    ev["forsaken_horde"].yearLabel = "23 ADP"
    ev["forsaken_horde"].body = [[
Spurned by the Alliance that once claimed them, the Forsaken find an unlikely advocate: the tauren, whose seers counsel mercy. Thrall accepts Sylvanas' people into the Horde.

The pact gives the Horde a foothold in the Eastern Kingdoms — and gives the Forsaken protection they never fully trust. A cold alliance of convenience, destined to be tested.]]
end

if ev["cycle_hatred"] then
    ev["cycle_hatred"].title = "An Uneasy Peace"
    ev["cycle_hatred"].yearLabel = "24 ADP"
    ev["cycle_hatred"].body = [[
Three years after Hyjal, the world is fragile calm: Theramore and Orgrimmar hold a wary truce, cultists of the Burning Blade whisper in both capitals, and the scars of three wars refuse to fade.

Adventurers now walk a world where old hatreds sleep lightly — and where dragons, cults and whispering gods are waking.]]
end

if ev["scourge_invasion"] then
    ev["scourge_invasion"].title = "The Scourge Invasion and Naxxramas"
    ev["scourge_invasion"].yearLabel = "25 – 30 ADP"
    ev["scourge_invasion"].body = [[
The Lich King's heralds rain necropolises upon the world; the floating fortress Naxxramas anchors above the Plaguelands, and Kel'Thuzad commands its horrors.

The Argent Dawn marshals the living against the dead. This is the world as the heroes of Azeroth know it today — the present age, where the chronicle leaves the writing to them.]]
end

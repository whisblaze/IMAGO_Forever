-- ============================================================
-- IMAGO Forever — locales/base/data/races.lua (enUS fallback)
-- Race dossier texts generated from the design documents.
-- Static records (IDs, figures, settlements, group keys)
-- live in data/races_static.lua.
-- figureText: name = display name, role/aff = member table
-- columns (Rolle | Zugehörigkeit), title = legacy combined.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}


-- ============================================================
-- ALLIANCE
-- ============================================================

local f = IMAGOdb.races["human"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Humans"
    f.groupTabLabel = "Kingdoms"
    f.quote = { text = "Vengeance cannot be a part of what we must do. If we allow our passions to turn to bloodlust, then we will become as vile as the orcs.", author = "Uther the Lightbringer" }
    f.overview = "Humans are a resilient species native to Azeroth, descended from the barbaric half-giant vrykul of Northrend. Though among the younger races of the world, they have faced every challenge with fortitude. Their continued ability to adapt and rebuild has made them a vital force in an ever-changing world. Since the fall of Lordaeron, the kingdom of Stormwind stands as the strongest bastion of humanity and leads the multiracial Alliance."
    f.facts = {
        faction = "Alliance",
        capital = "Stormwind City",
        leader = "Child King Anduin Wrynn, Regent Bolvar Fordragon (King Varian missing)",
        mount = "Horse",
        language = "Common",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "PALADIN" }, { classFile = "PRIEST" }, { classFile = "MAGE" }, { classFile = "WARLOCK" }, { classFile = "ROGUE" }, { classFile = "HUNTER" } }
    f.history = [[Humans descend from the vrykul, barbaric half-giants of Northrend who were themselves titan-forged. Around 15,000 years before the Dark Portal, the curse of flesh caused women of the Dragonflayer clan to bear small, malformed children. King Ymiron declared them aberrations and ordered them destroyed, but some parents hid them among a vrykul population in Tirisfal Glades. Over the ages, those children degenerated into mortal beings called humans. For millennia, scattered tribes flourished in the Eastern Kingdoms, warring constantly with each other and with the Amani forest trolls, their origins forgotten.

Humankind stepped into history during the Troll Wars of 2,800 BDP. The Arathi tribe under Warlord Thoradin united the tribes into the Empire of Arathor, the first great human civilization. The beleaguered high elves of Quel'Thalas taught one hundred humans the arcane in exchange for military aid, and together they crushed the trolls. Arathor's city-states grew autonomous until the empire split around 1,200 BDP into the Seven Kingdoms: Gilneas, Alterac, Dalaran and Lordaeron in the north, Kul Tiras in the southwest, and Stormwind in the far south. The old capital Strom became Stromgarde.

Disaster struck when the orcish Horde opened the Dark Portal and ruined Stormwind in the First War. Its survivors fled north, and the Seven Kingdoms unified as the Alliance of Lordaeron, defeating the Horde in the Second War. Then a plague decimated Lordaeron, and the corrupted Prince Arthas Menethil drove the Scourge to eradicate his own kingdom; Dalaran fell as well. Humanity survived the Third War at Mount Hyjal at terrible cost. Since then, Stormwind stands as humanity's last great bastion, rebuilding and reorganizing the Alliance. In Lordaeron, the Silver Hand's remnants reforged themselves as the fanatical Scarlet Crusade, while the Argent Dawn formed as its more temperate counterpart, and the surviving magi sealed Dalaran's ruins beneath an arcane dome.]]
    f.culture = [[Humans are a naturally proud and ambitious people, triumphalist to the point of arrogance at times, yet just as capable of noble, altruistic deeds. They live in villages, towns and great bustling cities. The peasantry farms and mines outside the walls, merchants and craftsmen fill the streets, and the nobility rule from their castles. Their lifespan is short, perhaps that is why humans embrace risk and courage so readily. They are skilled sailors; Kul Tiras commands Azeroth's greatest navy. Their sayings: "Those who do not learn from history are condemned to repeat it." "Know your enemy." "Plenty of time for sleep in the grave."

The dominant religion is faith in the Holy Light, first revealed to early human priests by the naaru after the Troll Wars. The Church of the Holy Light guides nearly all human societies, and its martial arm is the Order of the Silver Hand. In Kul Tiras, sailors worship the Tidemother and the Tidesages bless every ship; in isolated Gilneas, the old animistic ways survive among the harvest-witches. Humans also carry darker faiths: the Cult of the Damned, the Twilight's Hammer, and hidden warlock enclaves such as the one beneath Stormwind's Slaughtered Lamb.]]
    f.relationsIntro = "Straightforward and outspoken, humans get along with other races and earn their trust with relative ease. Their true strength lies in the ability to look past their own interests and seek diplomatic solutions. Humans began the Alliance, and it could not exist without them."
    f.relations = {
        { name = "Dwarves of Ironforge", text = "Humanity's closest and most natural allies since the days of the Empire of Arathor. Both peoples have long shared the secrets of metal-smithing and engineering and discovered a common love for battle and storytelling. When the Alliance liberated Ironforge from the Old Horde in the Second War, the dwarves pledged that they owed a debt that could never be repaid." },
        { name = "Wildhammer dwarves", text = "A friendly bond since the Second War, when humans saved them from the orcs; the grateful dwarves joined the Alliance and support it ever since with their gryphon riders." },
        { name = "Gnomes", text = "Humans greatly respect gnomish technological prowess and the gnomes' steadfast loyalty to the Alliance, and many lend their aid to the gnomes' continuing fight for Gnomeregan." },
        { name = "Elves", text = "A source of mystery and frustration, especially the exotic night elves allied to them. Despite this, humans respect the night elves' endeavors to restore and preserve the natural beauty of Azeroth, above all the Cenarion Circle's work in the plaguelands." },
        { name = "Orcs", text = "First contact came in the First War, when the orcish Horde destroyed Stormwind and created an enmity that continues today. Though some leaders like Jaina Proudmoore have made peace, the great majority of humanity still keeps a strong grudge for the atrocities committed against them." },
        { name = "Trolls", text = "An old enmity from the many wars since the birth of the Empire of Arathor; the people of Stromgarde in particular feud bitterly with the Amani." },
        { name = "Kinship", text = "Humans have been known to rarely intermarry with other races, most notably high elves: Alodi, the first Guardian of Tirisfal, was a half-elf; the paladin Turalyon married the ranger Alleria Windrunner; Rhonin, leader of the Kirin Tor, wed her sister Vereesa." },
    }
    f.groupsIntro = "The Seven Kingdoms at year 25:"
    f.groups["stormwind"] = { name = "Stormwind", lore = "The strongest bastion of humanity; rebuilt, leads the Alliance." }
    f.groups["lordaeron"] = { name = "Lordaeron", lore = "Destroyed in the Third War; its ruins contested by Scourge and Forsaken." }
    f.groups["dalaran"] = { name = "Dalaran", lore = "Sealed beneath an arcane dome; the Kirin Tor rebuild within." }
    f.groups["kul_tiras"] = { name = "Kul Tiras", lore = "Isolated after Lord Admiral Proudmoore's death." }
    f.groups["gilneas"] = { name = "Gilneas", lore = "Withdrawn behind the Greymane Wall." }
    f.groups["stromgarde"] = { name = "Stromgarde", lore = "Collapsed after King Thoras's murder; its keep besieged by the Syndicate and ogres." }
    f.groups["alterac"] = { name = "Alterac", lore = "Destroyed for its betrayal; its remnants fallen to the Syndicate." }
    f.groups["theramore"] = { name = "Theramore", lore = "Jaina's young isle-kingdom on Kalimdor." }
    f.groupsFootnote = "Orders: Church of the Holy Light · Knights of the Silver Hand · Kirin Tor · Scarlet Crusade · Argent Dawn · the Syndicate · the Defias Brotherhood · the Cult of the Damned · the Twilight's Hammer."
    f.figureText["varian_wrynn"] = { name = "Varian Wrynn", role = "Missing king of Stormwind.", aff = "Stormwind, Alliance", title = "Missing king of Stormwind. — Stormwind, Alliance" }
    f.figureText["anduin_wrynn_forever"] = { name = "Anduin Wrynn", role = "Child king under Regent Bolvar Fordragon.", aff = "Stormwind, Alliance", title = "Child king under Regent Bolvar Fordragon. — Stormwind, Alliance" }
    f.figureText["llane_wrynn"] = { name = "Llane Wrynn", role = "Former king, assassinated by Garona.", aff = "Stormwind", title = "Former king, assassinated by Garona. — Stormwind" }
    f.figureText["anduin_lothar"] = { name = "Anduin Lothar", role = "Lord-Regent, Supreme Commander of the Alliance of Lordaeron.", aff = "Alliance of Lordaeron", title = "Lord-Regent, Supreme Commander of the Alliance of Lordaeron. — Alliance of Lordaeron" }
    f.figureText["turalyon"] = { name = "Turalyon", role = "Paladin of the Silver Hand, leader of the Alliance Expedition.", aff = "Silver Hand", title = "Paladin of the Silver Hand, leader of the Alliance Expedition. — Silver Hand" }
    f.figureText["terenas_menethil_ii"] = { name = "Terenas Menethil II", role = "Last true king of Lordaeron.", aff = "Lordaeron", title = "Last true king of Lordaeron. — Lordaeron" }
    f.figureText["arthas_menethil"] = { name = "Arthas Menethil", role = "Fallen prince; now the Lich King in Northrend.", aff = "Scourge", title = "Fallen prince; now the Lich King in Northrend. — Scourge" }
    f.figureText["calia_menethil"] = { name = "Calia Menethil", role = "Princess of Lordaeron, in hiding.", aff = "Lordaeron", title = "Princess of Lordaeron, in hiding. — Lordaeron" }
    f.figureText["uther_the_lightbringer"] = { name = "Uther the Lightbringer", role = "First paladin, Supreme Commander of the Silver Hand.", aff = "Silver Hand", title = "First paladin, Supreme Commander of the Silver Hand. — Silver Hand" }
    f.figureText["genn_greymane"] = { name = "Genn Greymane", role = "King of Gilneas behind the Wall.", aff = "Gilneas", title = "King of Gilneas behind the Wall. — Gilneas" }
    f.figureText["darius_crowley"] = { name = "Darius Crowley", role = "Gilnean lord behind the Wall.", aff = "Gilneas", title = "Gilnean lord behind the Wall. — Gilneas" }
    f.figureText["daelin_proudmoore"] = { name = "Daelin Proudmoore", role = "Former Lord Admiral of Kul Tiras.", aff = "Kul Tiras", title = "Former Lord Admiral of Kul Tiras. — Kul Tiras" }
    f.figureText["jaina_proudmoore"] = { name = "Jaina Proudmoore", role = "Ruler of Theramore.", aff = "Theramore", title = "Ruler of Theramore. — Theramore" }
    f.figureText["bolvar_fordragon_forever"] = { name = "Bolvar Fordragon", role = "Regent of Stormwind.", aff = "Stormwind", title = "Regent of Stormwind. — Stormwind" }
    f.figureText["alexandros_mograine"] = { name = "Alexandros Mograine", role = "First wielder of the Ashbringer.", aff = "Silver Hand", title = "First wielder of the Ashbringer. — Silver Hand" }
    f.figureText["tirion_fordring_forever"] = { name = "Tirion Fordring", role = "Paladin in exile in the Plaguelands.", aff = "Argent Dawn", title = "Paladin in exile in the Plaguelands. — Argent Dawn" }
    f.figureText["aegwynn"] = { name = "Aegwynn", role = "Former Guardian of Tirisfal, in Theramore.", aff = "Theramore", title = "Former Guardian of Tirisfal, in Theramore. — Theramore" }
    f.figureText["medivh"] = { name = "Medivh", role = "Last Guardian of Tirisfal, master of Karazhan.", aff = "Karazhan", title = "Last Guardian of Tirisfal, master of Karazhan. — Karazhan" }
    f.figureText["khadgar"] = { name = "Khadgar", role = "Mage of the Alliance Expedition.", aff = "Sons of Lothar", title = "Mage of the Alliance Expedition. — Sons of Lothar" }
    f.figureText["antonidas"] = { name = "Antonidas", role = "Former leader of the Kirin Tor.", aff = "Kirin Tor", title = "Former leader of the Kirin Tor. — Kirin Tor" }
    f.figureText["rhonin"] = { name = "Rhonin", role = "Leader of the Kirin Tor.", aff = "Kirin Tor", title = "Leader of the Kirin Tor. — Kirin Tor" }
    f.figureText["thoras_trollbane"] = { name = "Thoras Trollbane", role = "Former king of Stromgarde.", aff = "Stromgarde", title = "Former king of Stromgarde. — Stromgarde" }
    f.figureText["galen_trollbane"] = { name = "Galen Trollbane", role = "Prince over what remains of Stromgarde.", aff = "Stromgarde", title = "Prince over what remains of Stromgarde. — Stromgarde" }
    f.figureText["danath_trollbane"] = { name = "Danath Trollbane", role = "Force Commander of the Sons of Lothar.", aff = "Sons of Lothar", title = "Force Commander of the Sons of Lothar. — Sons of Lothar" }
    f.figureText["reginald_windsor"] = { name = "Reginald Windsor", role = "Marshal of Stormwind.", aff = "Stormwind", title = "Marshal of Stormwind. — Stormwind" }
    f.figureText["mathias_shaw"] = { name = "Mathias Shaw", role = "Director of SI:7.", aff = "SI:7", title = "Director of SI:7. — SI:7" }
    f.figureText["aiden_perenolde"] = { name = "Aiden Perenolde", role = "Former king of Alterac, betrayer of the Alliance.", aff = "Alterac", title = "Former king of Alterac, betrayer of the Alliance. — Alterac" }
    f.figureText["edwin_van_cleef"] = { name = "Edwin van Cleef", role = "Kingpin of the Defias Brotherhood.", aff = "Defias Brotherhood", title = "Kingpin of the Defias Brotherhood. — Defias Brotherhood" }
    f.figureText["alonsus_faol"] = { name = "Alonsus Faol", role = "Former Archbishop.", aff = "Church of the Holy Light", title = "Former Archbishop. — Church of the Holy Light" }
    f.figureText["archbishop_benedictus"] = { name = "Archbishop Benedictus", role = "Head of the Church of the Holy Light.", aff = "the Church, Stormwind", title = "Head of the Church of the Holy Light. — the Church, Stormwind" }
    f.figureText["archmage_arugal"] = { name = "Archmage Arugal", role = "Mage in Shadowfang Keep.", aff = "Kirin Tor", title = "Mage in Shadowfang Keep. — Kirin Tor" }
    f.figureText["othmar_garithos"] = { name = "Othmar Garithos", role = "Former commander of the Alliance resistance.", aff = "Alliance resistance", title = "Former commander of the Alliance resistance. — Alliance resistance" }
    f.figureText["saidan_dathrohan"] = { name = "Saidan Dathrohan", role = "Grand Crusader", aff = "Scarlet Crusade", title = "Grand Crusader — Scarlet Crusade" }
    f.figureText["aedelas_blackmoore"] = { name = "Aedelas Blackmoore", role = "Former commander of the internment camps.", aff = "Lordaeron", title = "Former commander of the internment camps. — Lordaeron" }
    f.figureText["maxwell_tyrosus"] = { name = "Maxwell Tyrosus", role = "Leader of the Argent Dawn.", aff = "Argent Dawn", title = "Leader of the Argent Dawn. — Argent Dawn" }
end

f = IMAGOdb.races["dwarf"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Dwarves"
    f.groupTabLabel = "Clans"
    f.quote = { text = "If there's one thing dwarves love, it's drinking. And fighting. Two things.", author = "Pewter Drinking Cup" }
    f.overview = "Dwarves are an ancient, bold and courageous race descended from the earthen, split into great clans. The Bronzebeards of Ironforge hold the mountains of Khaz Modan; the Wildhammers nest on Aerie Peak in the Hinterlands; the Dark Irons brood in Shadowforge City beneath Blackrock Mountain. Short and stout, they are masters of the forge, and when the call to battle sounds, they rise with unmatched valor. Under King Magni Bronzebeard, the dwarves remain the staunchest friends the Alliance has."
    f.facts = {
        faction = "Alliance (Ironforge); Wildhammers friendly but outside the reformed Alliance; Dark Irons hostile",
        capital = "Ironforge · Aerie Peak · Shadowforge City",
        leader = "King Magni Bronzebeard",
        mount = "Ram (Gryphon for the Wildhammers)",
        language = "Dwarven, Common",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "PALADIN" }, { classFile = "PRIEST" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" } }
    f.history = [[The dwarves derive from the earthen, titan-forged creatures of living stone shaped by the Forge of Wills. After Keeper Loken's betrayal tainted the Forge with the curse of flesh, Keeper Tyr led the afflicted south to Uldaman. When the curse overtook them, most earthen asked to be put to slumber until a cure could be found. Ages later they awoke as flesh and called themselves dwarves. Remembering their maker, they named their land Khaz Modan, "Mountain of Khaz", won it from the ice trolls, and raised mighty Ironforge beneath the mountains. Around 2,500 BDP they befriended the gnomes of the nearby caverns, and around 1,200 BDP the expeditions of Gilneas and Alterac first encountered them. Humans and dwarves quickly bonded over battle, storytelling and strong ale, and the humans introduced them to the Holy Light.

By that age, three great clans shared Ironforge under High King Modimus Anvilmar: the Bronzebeards, masters of the military and trade; the Wildhammers, resilient mountaineers of the foothills; and the scheming Dark Irons of the Thaurissan family. When Modimus died, civil war erupted. The victorious Bronzebeards kept Dun Morogh, the Wildhammers withdrew to Grim Batol, the Dark Irons founded Thaurissan in the Redridge Mountains. Years later the Dark Irons struck both kingdoms at once. Sorcerer-Thane Thaurissan was repelled at Ironforge while his wife Modgud broke Grim Batol's gates before falling to Thane Khardros, and her magic left the citadel cursed forever. As the victors marched on his capital, Thaurissan's hatred summoned the Firelord Ragnaros into the world; the devastation annihilated his kingdom and scarred the north into the Burning Steppes and Searing Gorge. The Dark Irons were dragged into Shadowforge as Ragnaros's slaves. The homeless Wildhammers settled Aerie Peak in the Hinterlands, and the Thandol Span was raised as a pledge that the clans would never raise arms against each other again.

In the Great Wars, dwarves stood with humanity. The Horde ground through Khaz Modan but broke on Ironforge, and the freed kingdoms joined the Alliance of Lordaeron. Kurdran Wildhammer's gryphon riders drew Aerie Peak into the Alliance, and when the war ended, Kurdran flew through the Dark Portal with the Sons of Lothar. Through the Third War, Ironforge and Aerie Peak dwarves fought the Scourge across Lordaeron, Northrend and Kalimdor; Magni himself forged the Ashbringer for Highlord Alexandros Mograine. When Gnomeregan fell to the troggs, Magni took the gnome refugees in. In recent years, driven by ruins hinting at a lost heritage, Magni has steered his people's industry toward archaeology, and the Explorers' League now digs for the truth of dwarven origins.]]
    f.culture = [[Dwarves are a hardy people steeped in tradition, with a zest for combat, exploration and fine ale. What they lack in height they make up in heart. All dwarves are stubborn and admire bravery; they would rather die fighting than live as slaves. They call themselves "the earth folk", navigate tunnels by reading the rock's striations, and retain their ancestors' affinity for stonework, mining and gemcraft. Blood is counted by clan, the core of dwarven identity. Deepest of all bonds is Gwyarbrawden, a vow of warriors to avenge each other's deaths at any length, a custom few outsiders know.

Dwarves love gold and drink, so gambling comes naturally: few travel without dice, and "rolling the bones" settles arguments. Their table is "stick-to-your-ribs" fare washed down with beer: haggis and Ironforge pale ale, spice bread, boar meat, Thelsamar's blood sausages and arctic char. In faith, most Ironforge dwarves follow the Holy Light taught by humans, keeping the Hall of Mysteries. Older still runs veneration of Khaz'goroth the titan father, remembered in the Feast of Winter Veil. The Wildhammers practice shamanism; the enslaved Dark Irons once worshipped Ragnaros as a demigod. Bronzebeards distrust warlocks; a dwarven warlock is an anomaly. They bury their dead in the earth and lay their heroes to rest beside their gryphons. Their oaths swear by beards and hammers: "By Magni's beard", "Madoran's hammer". An old saying warns: "If ye want to topple a wall, start with the foundation."]]
    f.relations = {
        { name = "Gnomes", text = "\"Cousins\" by shared titan-forged ancestry; the dwarves taught stonework and helped found Gnomeregan, the gnomes taught science and engineering. After the trogg disaster, Magni took the refugees into Ironforge." },
        { name = "Humans", text = "Allies since the days of Arathor; the cathedral bells of Capital City and Stormwind were forged in Ironforge as tokens of friendship. When the Alliance broke the Horde's siege in the Second War, the dwarves pledged a debt they could never repay. Magni still honors it." },
        { name = "The clans among themselves", text = "The Thandol Span and the Valley of Kings monument pledge never to fight again. The Dark Irons, enslaved in Shadowforge, brood on hatred for the rest of their kind." },
        { name = "The Horde", text = "Khaz Modan remembers the invasion; dwarves hold the old grudge against orcs." },
    }
    f.groups["bronzebeard_clan"] = { name = "Bronzebeard clan", lore = "Rulers of Ironforge and Dun Morogh, the largest clan; led by King Magni Bronzebeard." }
    f.groups["wildhammer_clan"] = { name = "Wildhammer clan", lore = "The gryphon riders of Aerie Peak, still bound to nature; led by Falstad Wildhammer. Outside the reformed Alliance but friendly." }
    f.groups["dark_iron_clan"] = { name = "Dark Iron clan", lore = "Descendants of Thaurissan's kingdom, enslaved to Ragnaros in Shadowforge City; ruled by Emperor Dagran Thaurissan." }
    f.groups["stormpike_clan"] = { name = "Stormpike clan", lore = "Fighting the Frostwolf orcs in Alterac Valley; led by Vanndar Stormpike." }
    f.groups["explorers_league"] = { name = "The Explorers' League", lore = "Magni's order of archaeologists plumbing dwarven origins; led by Brann Bronzebeard." }
    f.groupsFootnote = "- Lesser clans: Rom's dwindled clan, the Wildhammer families of Northeron and the Highlands, the Skardyn cursed within Grim Batol; far north, the Frostborn dwarves of the Storm Peaks."
    f.figureText["modimus_anvilmar"] = { name = "Modimus Anvilmar", role = "Last High King of all dwarves before the War of the Three Hammers.", aff = "Ironforge", title = "Last High King of all dwarves before the War of the Three Hammers. — Ironforge" }
    f.figureText["madoran_bronzebeard"] = { name = "Madoran Bronzebeard", role = "Thane of the Bronzebeards in the War of the Three Hammers.", aff = "Bronzebeard clan", title = "Thane of the Bronzebeards in the War of the Three Hammers. — Bronzebeard clan" }
    f.figureText["king_magni_bronzebeard_forever"] = { name = "Magni Bronzebeard", role = "King of Ironforge.", aff = "Alliance, Bronzebeard clan", title = "King of Ironforge. — Alliance, Bronzebeard clan" }
    f.figureText["muradin_bronzebeard"] = { name = "Muradin Bronzebeard", role = "Middle Bronzebeard brother, lost on expedition in Northrend.", aff = "Bronzebeard clan", title = "Middle Bronzebeard brother, lost on expedition in Northrend. — Bronzebeard clan" }
    f.figureText["brann_bronzebeard"] = { name = "Brann Bronzebeard", role = "Leader of the Explorers' League.", aff = "Explorer's League", title = "Leader of the Explorers' League. — Explorer's League" }
    f.figureText["moira_thaurissan"] = { name = "Moira Thaurissan", role = "Magni's daughter, consort of Emperor Dagran in Shadowforge.", aff = "Dark Iron clan", title = "Magni's daughter, consort of Emperor Dagran in Shadowforge. — Dark Iron clan" }
    f.figureText["thargas_anvilmar"] = { name = "Thargas Anvilmar", role = "Defender of Thandol Span, last descendant of Modimus.", aff = "Ironforge", title = "Defender of Thandol Span, last descendant of Modimus. — Ironforge" }
    f.figureText["hjalmar_anvilmar"] = { name = "Hjalmar Anvilmar", role = "Elder brother of Thargas.", aff = "Ironforge", title = "Elder brother of Thargas. — Ironforge" }
    f.figureText["baelgun_flamebeard"] = { name = "Baelgun Flamebeard", role = "Leader of the remnants of Muradin's Northrend expedition.", aff = "Explorer's League", title = "Leader of the remnants of Muradin's Northrend expedition. — Explorer's League" }
    f.figureText["high_priest_rohan"] = { name = "High Priest Rohan", role = "High priest in the Hall of Mysteries.", aff = "Ironforge", title = "High priest in the Hall of Mysteries. — Ironforge" }
    f.figureText["vanndar_stormpike"] = { name = "Vanndar Stormpike", role = "General of the Stormpike Guard.", aff = "Stormpike clan", title = "General of the Stormpike Guard. — Stormpike clan" }
    f.figureText["hemet_nesingwary"] = { name = "Hemet Nesingwary", role = "World-renowned hunter.", aff = "Independent", title = "World-renowned hunter. — Independent" }
    f.figureText["rom"] = { name = "Rom", role = "Aided Rhonin in freeing Alexstrasza.", aff = "Alliance of Lordaeron", title = "Aided Rhonin in freeing Alexstrasza. — Alliance of Lordaeron" }
    f.figureText["thane_korthazz"] = { name = "Thane Korth'azz", role = "Fallen paladin, death knight in Naxxramas.", aff = "Scourge", title = "Fallen paladin, death knight in Naxxramas. — Scourge" }
    f.figureText["khardros_wildhammer"] = { name = "Khardros Wildhammer", role = "High Thane of the Wildhammers in the War of the Three Hammers.", aff = "Wildhammer clan", title = "High Thane of the Wildhammers in the War of the Three Hammers. — Wildhammer clan" }
    f.figureText["falstad_wildhammer"] = { name = "Falstad Wildhammer", role = "Ruler of Aerie Peak.", aff = "Wildhammer clan", title = "Ruler of Aerie Peak. — Wildhammer clan" }
    f.figureText["kurdran_wildhammer"] = { name = "Kurdran Wildhammer", role = "Gryphon-riding hero, through the portal with the Sons of Lothar.", aff = "Sons of Lothar", title = "Gryphon-riding hero, through the portal with the Sons of Lothar. — Sons of Lothar" }
    f.figureText["sorcerer_thane_thaurissan"] = { name = "Sorcerer-Thane Thaurissan", role = "Emperor of the Dark Irons, summoner of Ragnaros.", aff = "Dark Iron clan", title = "Emperor of the Dark Irons, summoner of Ragnaros. — Dark Iron clan" }
    f.figureText["modgud"] = { name = "Modgud", role = "Thaurissan's wife, curser of Grim Batol.", aff = "Dark Iron clan", title = "Thaurissan's wife, curser of Grim Batol. — Dark Iron clan" }
    f.figureText["emperor_dagran_thaurissan"] = { name = "Emperor Dagran Thaurissan", role = "Ruler of the Dark Irons in Shadowforge.", aff = "Dark Iron clan", title = "Ruler of the Dark Irons in Shadowforge. — Dark Iron clan" }
    f.figureText["franclorn_forgewright"] = { name = "Franclorn Forgewright", role = "Former chief architect, builder of Blackrock Spire and the Stonewrought Dam.", aff = "Dark Iron clan", title = "Former chief architect, builder of Blackrock Spire and the Stonewrought Dam. — Dark Iron clan" }
end

f = IMAGOdb.races["gnome"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Gnomes"
    f.groupTabLabel = "Orders"
    f.quote = { text = "I trusted Thermaplugg. Never did I expect that he would betray me and the entire gnomish people. ... Now we have been displaced from our home and that madman is in charge. The king of nothing... We will retake Gnomeregan. We will not stop until the city is back in our control.", author = "High Tinker Mekkatorque" }
    f.overview = "The clever, spunky and oftentimes eccentric gnomes present a unique paradox among the civilized races of Azeroth. Brilliant inventors with an irrepressibly cheerful disposition, they have suffered treachery, displacement and near-genocide. It is their remarkable optimism in the face of calamity that symbolizes their unshakable spirit. Driven from irradiated Gnomeregan by troggs and betrayal, the survivors now live among their dwarven cousins in Ironforge's Tinker Town, led by High Tinker Gelbin Mekkatorque."
    f.facts = {
        faction = "Alliance",
        capital = "Gnomeregan (lost, irradiated); current seat: Tinker Town, Ironforge",
        leader = "High Tinker Gelbin Mekkatorque",
        mount = "Mechanostrider",
        language = "Gnomish, Common",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "ROGUE" }, { classFile = "MAGE" }, { classFile = "WARLOCK" }, { classFile = "PRIEST" } }
    f.history = [[The gnomes descend from mechagnomes, small clockwork creatures wrought by the Watcher Mimiron. Left to maintain Uldaman after Loken's betrayal, they too succumbed to the curse of flesh, degenerated into flesh beings and abandoned the vaults some 3,000 years before the Dark Portal. The first gnomes carved out an existence in the snowy mountains west of Uldaman, surviving ice trolls and the elements through technological dedication, and within a few generations had lost all memory of their titan-forged heritage. Around 2,500 BDP the arriving dwarves found them and helped lay the foundations of Gnomeregan. The gnomish kingdom industrialized in peace. Their arcanists were remarkable: Indus sat on the founding Council of Tirisfal, and Erbag served it in Aegwynn's day. Their last king, Mechagon, led followers away four hundred years ago in search of a mythical land of technology; since then the gnomes have elected their High Tinkers by merit.

When the Horde invaded Khaz Modan in the Second War, dwarves and gnomes held the passes together. Gnomeregan's iron gate and devilish traps stalled the siege until Lothar freed them both, and the gnomes repaid the Alliance with submarines, flying machines and motivated troops, igniting a lasting technological rivalry with the goblins. Afterward, High Tinker Mekkatorque designed the Deeprun Tram to link Ironforge and Stormwind, and when the Alliance frayed around Year 18 he reaffirmed the gnomes' loyalty to King Terenas.

Then came the catastrophe that broke them. As Lordaeron fell, brutish troggs erupted beneath Gnomeregan and tunneled through its lower levels. Mekkatorque contained them for five years without asking the beleaguered Alliance for aid, until his trusted advisor Sicco Thermaplugg proposed flooding the lower city with toxic radiation, presenting falsified data and promising filters would protect the people. The High Tinker approved. The gas failed to kill the troggs, while broken filtration let it flood gnomish homes. Within days, nearly eighty percent of the gnomish race had perished. Mekkatorque led the survivors to Ironforge, where Magni Bronzebeard granted them Tinker Town. The High Tinker has since refused an immediate attempt to retake the city and bound the gnomes' fate to the modern Alliance, while the full extent of Thermaplugg's treachery emerges only slowly.]]
    f.culture = [[Gnomes are an ambitious folk who celebrate creativity and craft, their lives validated by a masterful command of the scientific laws of the universe. To be pitied is unbearable to them. They have always been scholars rather than warriors, offsetting lack of strength with ingenuity and daring, and no gnome can turn down a puzzle. Since the fall of Gnomeregan, hardship has hardened them: gnomish melee fighters are more common, and gnomes talk back to Tall Folk more readily than ever. Uniquely among the races, they had no history of internecine violence, which is why they abandoned monarchy centuries ago and elect leaders by the benefit their work brings the race. It made Thermaplugg's betrayal all the more shocking.

They speak Gnomish and Common and are renowned mechanics, engineers and technicians, supplying the Alliance its most advanced weaponry, artillery and war machines. In faith they have long been interested in the Holy Light, though technology and the fate of Gnomeregan always came first. Enough are drawn to darker paths to make gnomish rogues and warlocks unremarkable.]]
    f.relations = {
        { name = "Dwarves", text = "The gnomes' cousins and closest friends since first meeting; each taught the other its craft. After the trogg disaster Magni opened Ironforge's gates to them, and dwarves remain their chief support in the dream of reclaiming Gnomeregan." },
        { name = "Humans", text = "Liberators of the Second War; gnomes pledged a debt of gratitude and have equipped Alliance armies ever since. Gnomish mages have always held seats in the Kirin Tor; Indus was a founding member of the Council of Tirisfal." },
        { name = "Night elves", text = "Despite their arcane craft, gnomes are tolerated in kaldorei lands; engineers and sappers from Tinker Town aid the Sentinels in Ashenvale." },
        { name = "Goblins", text = "A technological rivalry born in the Second War, when goblin devices served the Horde; each race claims to be the smarter, and gnomes hold goblin engineering for crude." },
        { name = "Dark Iron dwarves", text = "Enemies as allies of their cousins' foe; agents of Shadowforge were found entangled with Thermaplugg in fallen Gnomeregan." },
        { name = "Orcs", text = "As victims of the Old Horde's invasion, gnomes still deeply distrust orcs and their allies." },
    }
    f.groups["kingdom_of_gnomeregan_in_exile"] = { name = "Kingdom of Gnomeregan in exile", lore = "The ruling council reconvened in Tinker Town under High Tinker Mekkatorque. Its course: no reckless retaking, technology for the Alliance first." }
    f.groups["thermapluggs_court"] = { name = "Thermaplugg's court", lore = "The betrayer sealed himself in the irradiated depths as self-proclaimed \"King of Gnomeregan\"; the leper gnomes of the fallen city answer to his madness." }
    f.groups["gnomeregan_covert_ops"] = { name = "Gnomeregan Covert Ops", lore = "The gnomes' intelligence arm, agents active across Alliance affairs." }
    f.groups["kirin_tor"] = { name = "The Kirin Tor", lore = "Gnomish arcanists have always held seats in Dalaran's order." }
    f.groups["leper_gnomes"] = { name = "Leper gnomes", lore = "The irradiated survivors twisted in mind and body, bound to Thermaplugg's madness." }
    f.figureText["high_tinker_mekkatorque_forever"] = { name = "Gelbin Mekkatorque", role = "High Tinker of Gnomeregan, exiled in Tinker Town.", aff = "Kingdom of Gnomeregan, Alliance", title = "High Tinker of Gnomeregan, exiled in Tinker Town. — Kingdom of Gnomeregan, Alliance" }
    f.figureText["sicco_thermaplugg"] = { name = "Sicco Thermaplugg", role = "Betrayer of Gnomeregan, self-proclaimed \"king\" in its depths.", aff = "Gnomeregan (renegade)", title = "Betrayer of Gnomeregan, self-proclaimed \"king\" in its depths. — Gnomeregan (renegade)" }
    f.figureText["indus"] = { name = "Indus", role = "Mage of Dalaran, founding member of the Council of Tirisfal.", aff = "Council of Tirisfal", title = "Mage of Dalaran, founding member of the Council of Tirisfal. — Council of Tirisfal" }
    f.figureText["erbag"] = { name = "Erbag", role = "Member of the Council of Tirisfal in Aegwynn's day.", aff = "Council of Tirisfal", title = "Member of the Council of Tirisfal in Aegwynn's day. — Council of Tirisfal" }
    f.figureText["king_mechagon"] = { name = "King Mechagon", role = "Last king of the gnomes, vanished 400 years ago.", aff = "Kingdom of Gnomeregan", title = "Last king of the gnomes, vanished 400 years ago. — Kingdom of Gnomeregan" }
    f.figureText["tinkmaster_overspark"] = { name = "Tinkmaster Overspark", role = "Chief Architect of Gnomish Engineering.", aff = "Gnomeregan", title = "Chief Architect of Gnomish Engineering. — Gnomeregan" }
    f.figureText["brink_spannercrank"] = { name = "Brink Spannercrank", role = "Assassin and SI:7 agent.", aff = "SI:7", title = "Assassin and SI:7 agent. — SI:7" }
    f.figureText["kelsey_steelspark"] = { name = "Kelsey Steelspark", role = "Gnomeregan Covert Ops agent.", aff = "Gnomeregan Covert Ops", title = "Gnomeregan Covert Ops agent. — Gnomeregan Covert Ops" }
    f.figureText["pip_quickwit"] = { name = "Pip Quickwit", role = "Inventor and explorer.", aff = "Independent", title = "Inventor and explorer. — Independent" }
    f.figureText["millhouse_manastorm"] = { name = "Millhouse Manastorm", role = "Powerful mage of questionable loyalty.", aff = "Independent", title = "Powerful mage of questionable loyalty. — Independent" }
    f.figureText["narain_soothfancy"] = { name = "Narain Soothfancy", role = "Retired engineer turned master soothsayer in Tanaris.", aff = "Independent", title = "Retired engineer turned master soothsayer in Tanaris. — Independent" }
    f.figureText["oglethorpe_obnoticus"] = { name = "Oglethorpe Obnoticus", role = "Exiled mekgineer in Booty Bay.", aff = "Independent", title = "Exiled mekgineer in Booty Bay. — Independent" }
    f.figureText["silas_darkmoon"] = { name = "Silas Darkmoon", role = "Founder and manager of the Darkmoon Faire.", aff = "Darkmoon Faire", title = "Founder and manager of the Darkmoon Faire. — Darkmoon Faire" }
    f.figureText["j_d_collie"] = { name = "J.D. Collie", role = "Researcher of the power crystals in Un'Goro Crater.", aff = "Independent", title = "Researcher of the power crystals in Un'Goro Crater. — Independent" }
    f.figureText["linken"] = { name = "Linken", role = "Hero of Un'Goro Crater.", aff = "Independent", title = "Hero of Un'Goro Crater. — Independent" }
    f.figureText["doctor_weavil"] = { name = "Doctor Weavil", role = "Leader of undead \"drudge gnomes\" on Alcaz Island.", aff = "Independent", title = "Leader of undead \"drudge gnomes\" on Alcaz Island. — Independent" }
end

f = IMAGOdb.races["night_elf"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Night Elves"
    f.groupTabLabel = "Factions"
    f.quote = { text = "Darkness covered us in the beginning, and we could not see. We cried for guidance and the moon shone down bright upon us. Her soft light not only illuminated the night for us but also gave comfort.", author = "Tyrande Whisperwind" }
    f.overview = "The kaldorei, the \"children of the stars\", are one of the oldest and longest-lived cultures in existence. They once ruled a magical empire that spanned ancient Kalimdor, and for ten thousand years they served as the self-appointed guardians of nature and the World Tree. The Third War cost them their immortality, when Nordrassil was sacrificed to slay Archimonde. Now, from their young city Darnassus in the boughs of the unblessed World Tree Teldrassil, they have ended the Long Vigil and joined the Alliance."
    f.facts = {
        faction = "Alliance",
        capital = "Darnassus, upon Teldrassil",
        leader = "High Priestess Tyrande Whisperwind (Archdruid Malfurion lies in an unexplained coma; Fandral Staghelm leads the druids)",
        mount = "Nightsaber",
        language = "Darnassian, Common",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "PRIEST" }, { classFile = "ROGUE" }, { classFile = "DRUID" } }
    f.history = [[Some fifteen thousand years ago, a tribe of dark trolls longing for peace settled beside the translucent waters of the Well of Eternity. The Well's cosmic power suffused them, and they became intelligent, near-immortal beings who named themselves kaldorei, children of the stars, and began to worship the moon goddess Elune. Guided by the demigod Cenarius, they flourished; then, drawn to the arcane, they built around the Well an empire of wonders under the beloved Queen Azshara and her haughty Highborne.

As the Highborne's reckless experiments poured arcane energy into the Twisting Nether, Sargeras answered. Posing as a god, he persuaded Azshara and her counselor Xavius to open a portal for his Burning Legion. Resistance formed around Malfurion Stormrage, the first druid, Tyrande Whisperwind and Lord Kur'talos Ravencrest. When the Well imploded, the Great Sundering drowned continents and dragged Azshara's faithful down into the deeps as naga.

The survivors turned from the arcane forever. On Mount Hyjal, Illidan Stormrage secretly poured vials of the old Well into a lake, a second Well of Eternity, and was imprisoned beneath the Barrow Deeps for refusing to surrender his power. To mask the new Well, the Dragon Aspects raised Nordrassil above it: Nozdormu blessed the kaldorei with agelessness, and Ysera bound their druids to the Emerald Dream. Thus began the Long Vigil. Tyrande reformed the Sisterhood of Elune into the Sentinels and ruled alone while the druids slept. When the exiled Highborne under Dath'Remar unleashed a storm upon Ashenvale in protest, they were banished across the sea to found Quel'Thalas. The millennia brought the War of the Satyr, which birthed the first worgen, and the War of the Shifting Sands, which cost Fandral Staghelm his son Valstann and saw the qiraji sealed behind the Scarab Wall.

Isolation ended in the Third War. The Warsong clan's axes bit into Ashenvale, Cenarius fell to demon-blooded orcs, and when the Legion and the Scourge came, Tyrande awoke Malfurion and the druids. The kaldorei finally stood beside the mortal races at Mount Hyjal, where wisps tore Archimonde apart. Victory cost the World Tree and their immortality. Now Malfurion lies in a coma his peers cannot explain; Fandral Staghelm has planted Teldrassil, a tree the Aspects refused to bless and which is quietly falling to corruption, and built Darnassus in its boughs. The night elves have joined the Alliance; their druids remain neutral in the Cenarion Circle at Nighthaven.]]
    f.culture = [[Bound to nature for ten thousand years, the kaldorei are slow to change and slow to anger. They are primarily nocturnal, stronger at night, and call the beasts of their forests "wild kin". Their faith centers on Elune, the moon goddess: her Sisterhood of Elune leads the nation's protectors, the Sentinels, and the moonwells serve every segment of society for healing and blessing. They honor their ancestors with offerings and believe the valiant dead ride the sky as stars. The kaldorei keep close kinship with the Ancient Guardians, Cenarius, Aviana, Ursoc and Ursol, Malorne, and old bonds with the red, green and bronze dragonflights that once blessed their tree.

By custom, the dead return to nature: priestesses cleanse them in a moonwell, sing their lives in temple arias, and lay them in a grove where a druid draws flowers up to encase the body. A child receives an owl feather on its first birthday; a rider keeps a fang of a fallen saber. They do not torture prisoners and take no delight in needless death. For ten thousand years, arcane magic was outlawed on pain of death. "Tor ilisar'thera'nal!", "Let our enemies beware!", is an ancient war cry.]]
    f.relations = {
        { name = "High elves", text = "A lingering grudge; the kaldorei still view their Thalassian kin with suspicion and count it their duty to remind allies what the Highborne's arcane hunger once wrought." },
        { name = "Orcs", text = "The bitterest wound: Warsong axes in Ashenvale and Cenarius's death beneath fel blades. Respect for Warchief Thrall and fellow druids tempers it." },
        { name = "Tauren", text = "The closest friend within the Horde; welcomed into the Cenarion Circle and the Moonglade. Hamuul Runetotem shares a deep bond with Malfurion and walks freely in Darnassus." },
        { name = "The Alliance", text = "Joined after Hyjal; some traditionalists still hold \"lesser races\" in open contempt. In the Plaguelands, night elves labor to cleanse and restore the land." },
        { name = "Allies of nature", text = "Furbolgs, wildkin, green dragons and the bog beast Rethiel the Greenwarden in the Wetlands." },
    }
    f.groups["darnassus"] = { name = "Darnassus", lore = "The night elf nation upon Teldrassil, led by High Priestess Tyrande Whisperwind." }
    f.groups["sisterhood_of_elune"] = { name = "Sisterhood of Elune", lore = "Priestesses of the moon goddess; the order from which the Sentinels were forged." }
    f.groups["sentinels"] = { name = "The Sentinels", lore = "The kaldorei's warrior protectors, mostly women, patrolling the forests; General Shandris Feathermoon commands from Feathermoon Stronghold." }
    f.groups["silverwing_sentinels"] = { name = "Silverwing Sentinels", lore = "Su'ura Swiftarrow's specialized force holding Ashenvale against the Warsong clan." }
    f.groups["watchers"] = { name = "The Watchers", lore = "Marshals and jailers of night elf society, led by Maiev Shadowsong, keepers of the Barrow Deeps." }
    f.groups["cenarion_circle"] = { name = "Cenarion Circle", lore = "Malfurion's neutral order of druids seated in Nighthaven, open to tauren and Horde students; Archdruid Fandral Staghelm leads it in Malfurion's unexplained sleep." }
    f.groups["highborne_shendralar"] = { name = "The Highborne Shen'dralar", lore = "The hidden magi of Eldre'Thalas in Feralas, still feeding their arcane thirst from the demon Immol'thar, unseen by kaldorei society." }
    f.groups["allies_of_nature"] = { name = "Allies of nature", lore = "Ancients, wisps, hippogryphs, chimaeras, mountain giants, dryads and keepers of the grove, furbolgs, wildkin and the green dragonflight." }
    f.figureText["tyrande_whisperwind_forever"] = { name = "Tyrande Whisperwind", role = "High Priestess of Elune, sole ruler of the kaldorei.", aff = "Darnassus, the Sisterhood", title = "High Priestess of Elune, sole ruler of the kaldorei. — Darnassus, the Sisterhood" }
    f.figureText["malfurion_stormrage"] = { name = "Malfurion Stormrage", role = "Archdruid, founder of the Cenarion Circle.", aff = "Cenarion Circle", title = "Archdruid, founder of the Cenarion Circle. — Cenarion Circle" }
    f.figureText["fandral_staghelm_forever"] = { name = "Fandral Staghelm", role = "Leading archdruid, planter of Teldrassil.", aff = "Cenarion Circle, Darnassus", title = "Leading archdruid, planter of Teldrassil. — Cenarion Circle, Darnassus" }
    f.figureText["shandris_feathermoon"] = { name = "Shandris Feathermoon", role = "General of the Sentinels.", aff = "the Sentinels", title = "General of the Sentinels. — the Sentinels" }
    f.figureText["maiev_shadowsong"] = { name = "Maiev Shadowsong", role = "Leader of the Watchers, Illidan's former jailer.", aff = "Behüter", title = "Leader of the Watchers, Illidan's former jailer. — Behüter" }
    f.figureText["jarod_shadowsong"] = { name = "Jarod Shadowsong", role = "Last leader of the Kaldorei Resistance.", aff = "Kaldorei", title = "Last leader of the Kaldorei Resistance. — Kaldorei" }
    f.figureText["broll_bearmantle"] = { name = "Broll Bearmantle", role = "Archdruid of the Circle.", aff = "Cenarion Circle", title = "Archdruid of the Circle. — Cenarion Circle" }
    f.figureText["suura_swiftarrow"] = { name = "Su'ura Swiftarrow", role = "Leader of the Silverwing Sentinels in Ashenvale.", aff = "Silverwing Sentinels", title = "Leader of the Silverwing Sentinels in Ashenvale. — Silverwing Sentinels" }
    f.figureText["naralex"] = { name = "Naralex", role = "Druid trapped in the Emerald Dream.", aff = "Cenarion Circle", title = "Druid trapped in the Emerald Dream. — Cenarion Circle" }
    f.figureText["archdruid_renferal"] = { name = "Archdruid Renferal", role = "Archdruid of the Circle.", aff = "Cenarion Circle", title = "Archdruid of the Circle. — Cenarion Circle" }
    f.figureText["mordent_evenshade"] = { name = "Mordent Evenshade", role = "Leader of the Shen'dralar Highborne.", aff = "Shen'dralar", title = "Leader of the Shen'dralar Highborne. — Shen'dralar" }
    f.figureText["prince_tortheldrin"] = { name = "Prince Tortheldrin", role = "Ruler of Eldre'Thalas.", aff = "Shen'dralar", title = "Ruler of Eldre'Thalas. — Shen'dralar" }
    f.figureText["kurtalos_ravencrest"] = { name = "Kur'talos Ravencrest", role = "First leader of the Kaldorei Resistance.", aff = "Kaldorei resistance", title = "First leader of the Kaldorei Resistance. — Kaldorei resistance" }
    f.figureText["valstann_staghelm"] = { name = "Valstann Staghelm", role = "Fandral's son, fell in the War of the Shifting Sands.", aff = "Kaldorei", title = "Fandral's son, fell in the War of the Shifting Sands. — Kaldorei" }
    f.figureText["queen_azshara"] = { name = "Queen Azshara", role = "Former queen, now queen of the naga.", aff = "Nazjatar", title = "Former queen, now queen of the naga. — Nazjatar" }
    f.figureText["illidan_stormrage"] = { name = "Illidan Stormrage", role = "\"The Betrayer\", lord of Outland.", aff = "Illidari", title = "\"The Betrayer\", lord of Outland. — Illidari" }
    f.figureText["lady_vashj"] = { name = "Lady Vashj", role = "Leader of Illidan's naga.", aff = "Wyrmbog", title = "Leader of Illidan's naga. — Wyrmbog" }
    f.figureText["xavius"] = { name = "Xavius", role = "First of the satyrs, sealed since the War of the Ancients.", aff = "Satyrs", title = "First of the satyrs, sealed since the War of the Ancients. — Satyrs" }
    f.figureText["ralaar_fangfire"] = { name = "Ralaar Fangfire", role = "The first worgen, sealed in the Dream.", aff = "Druids of the Scythe", title = "The first worgen, sealed in the Dream. — Druids of the Scythe" }
    f.figureText["keeper_remulos"] = { name = "Keeper Remulos", role = "Son of Cenarius, keeper of Moonglade.", aff = "Cenarion Circle", title = "Son of Cenarius, keeper of Moonglade. — Cenarion Circle" }
    f.figureText["rabine_saturna"] = { name = "Rabine Saturna", role = "Keeper in Nighthaven.", aff = "Cenarion Circle", title = "Keeper in Nighthaven. — Cenarion Circle" }
    f.figureText["omen"] = { name = "Omen", role = "Corrupted demigod at the heart of Moonglade.", aff = "Independent", title = "Corrupted demigod at the heart of Moonglade. — Independent" }
end


-- ============================================================
-- HORDE
-- ============================================================

f = IMAGOdb.races["orc"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Orcs"
    f.groupTabLabel = "Clans"
    f.quote = { text = "To pretend it [the demonic corruption] did not exist is to forget how dreadful the impact was. To make ourselves into victims, rather than claiming our participation in our own destruction. We chose this path, we orcs. We chose it right up until it was too late to turn back. And having made that choice, we can, with the knowledge that we have of the end of that dark and shameful road, choose not to take it.", author = "Thrall" }
    f.overview = "The orcs are a prolific, physically powerful race from the once-lush world of Draenor. A shamanistic people corrupted by Kil'jaeden into a bloodthirsty Horde, they drank the blood of Mannoroth and were enslaved to the Burning Legion. Then Thrall, son of Durotan, arose from the internment camps, rekindled the old ways, and led his people to Kalimdor. There they broke their demonic bondage and founded the nation of Durotar and the city of Orgrimmar."
    f.facts = {
        faction = "Horde",
        capital = "Orgrimmar",
        leader = "Warchief Thrall",
        mount = "Wolf",
        language = "Orcish",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" }, { classFile = "WARLOCK" }, { classFile = "MAGE" } }
    f.history = [[The orcs descend from Grond, the stone giant shaped by the titan Aggramar. Through colossals, magnaron, gronn, ogron and ogres, the smallest of Grond's line survived Draenor's wilds by wit and community. After the ogres threw off ogron mastery, the orcs spread from Gorgrond's caves and formed the clans, and only the Kosh'harg festivals kept peace between them.

Shadowmoon mystics discovered the Throne of the Elements in northwestern Nagrand and taught the clans shamanism; the bond between shamans crossed clan lines and became orcdom's conscience. When the Gorian Empire of the ogres seized the Throne, Nelgarm's united clans reclaimed it and the spirits shattered Goria to ash, a wrath the shamans swore never to invoke again. The draenei's arrival gave the clans a cordial, distant trading partner.

Then Kil'jaeden deceived the elder shaman Ner'zhul, appearing as an ancestor spirit to turn the orcs against the draenei. The elements abandoned them, and Ner'zhul's apprentice Gul'dan filled the void with warlock schools, the Shadow Council, and the Old Horde under the puppet Warchief Blackhand. On the eve of Shattrath's fall the chieftains drank Mannoroth's blood, and bloodlust drowned the draenei. Deprived of enemies, the clans turned on each other until Medivh's whispers opened the Dark Portal. The First War ruined Stormwind; Doomhammer slew Blackhand and drove the Horde north. The Second War carried them to the walls of Capital City, until Gul'dan's desertion split the Horde at the brink of victory. Defeat, the shattered Portal, and the internment camps followed.

Years later Thrall, son of the murdered Durotan, escaped Durnholde and learned shamanism from Drek'Thar among the exiled Frostwolves. With Grom Hellscream and Doomhammer he founded the New Horde; Doomhammer fell in the last assault, and Thrall took up his armor and hammer. Following the Prophet's raven, the orcs sailed to Kalimdor, saving the Darkspear trolls on the way and befriending Cairne's tauren. In Ashenvale, Mannoroth's blood enslaved the Warsong again, but Grom slew the pit lord and freed them all at the cost of his life. After Archimonde's fall at Hyjal, Thrall founded Durotar in his father's name and Orgrimmar in Doomhammer's. When Daelin Proudmoore's fleet struck the young nation, Jaina's loyalty and Rexxar's aid held it, and Vol'jin pledged his tribe to the Horde forever.]]
    f.culture = [[Orcish society prizes honor above all, first honor to the clan and the Horde, then to the self, and hospitality counts among the greatest honors that can be given. All orcs pull their own weight; weakness risks exile. Children belong to the clan: at a newborn's naming, the father raises the infant for the clan's blessing in the water where the frail were once drowned, a cruelty the Frostwolves rejected. Young orcs train weapons at six, hunt at twelve, and earn adulthood in the om'riggor rite. Their songs carry their memory: lok'tra for a great battle, lok'amon for a family's history, lok'vadnod, composed for a single person, the highest honor an orc can receive.

Shamanism is their soul's root. Since the Shadowmoon first taught the elements' tongue, orc shamans have been honored as second only to chieftains. In barren Durotar they are indispensable, bargaining rain and hearthfire from the elementals. The dead were once burned on pyres, their ashes given to fire, air, water and earth; bloodlust abandoned that custom, and graveyards now stand beside the old fires. Orcs eat heartily, fresh meat above all, and their chosen companions are the great dire wolves. On Kalimdor they took the tauren's Lo'Gosh as their own hero: a wolf god whose will, like theirs, not even death can stop.]]
    f.relations = {
        { name = "Tauren and jungle trolls", text = "Unquestionable bonds; the tauren sheltered the orcs in a strange land, the Darkspear swore allegiance after Thrall saved their tribe." },
        { name = "The Forsaken", text = "Accepted into the Horde's ranks only reluctantly, after much debate among Thrall, Cairne and Vol'jin." },
        { name = "Humans", text = "A long history of violence and a grudging respect for their strength; most orcs still resent the internment camps, though they fought beside humans at Hyjal. One human commands true respect: Jaina Proudmoore, who chose the orcs over her own father." },
        { name = "The nations of the Alliance", text = "Thrall has tried to build threads of contact, even toward the Ironforge dwarves." },
        { name = "Smaller allies", text = "The Mok'nathal half-ogres and the Stonemaul ogres count among the Horde's affiliated peoples." },
    }
    f.groupsIntro = "Every orc belongs to a clan; each clan has its own culture and name, led by a chieftain who holds the title by Mak'gora challenge or inheritance, and all clans answer to the Warchief. The fourteen great clans:"
    f.groups["frostwolf"] = { name = "Frostwolf", lore = "Thrall's own clan, exiled by Gul'dan for refusing the blood; now home in Alterac Valley." }
    f.groups["warsong"] = { name = "Warsong", lore = "Nomads named for their battle-chants; Grom's clan." }
    f.groups["blackrock"] = { name = "Blackrock", lore = "Militaristic smiths who led the Horde's charge; split between Thrall's loyalists and Rend's Dark Horde at Blackrock Spire." }
    f.groups["bleeding_hollow"] = { name = "Bleeding Hollow", lore = "Fanatic seers who sacrifice an eye for visions." }
    f.groups["shattered_hand"] = { name = "Shattered Hand", lore = "Former slaves of ogres, freed by Kargath; the Horde's assassins." }
    f.groups["shadowmoon"] = { name = "Shadowmoon", lore = "Once the spiritual heart of the clans; Ner'zhul's clan." }
    f.groups["dragonmaw"] = { name = "Dragonmaw", lore = "The wayward riders who chained the dragonqueen at Grim Batol." }
    f.groups["burning_blade"] = { name = "Burning Blade", lore = "Demon-crazed blademasters of utter bloodlust." }
    f.groups["thunderlord"] = { name = "Thunderlord", lore = "Hunters of Draenor's giants, mostly fallen to fel corruption." }
    f.groups["stormreaver"] = { name = "Stormreaver", lore = "Gul'dan's personal guard, slaughtered in the Tomb of Sargeras gambit." }
    f.groups["twilights_hammer"] = { name = "Twilight's Hammer", lore = "Cho'gall's nihilists, now a cult of the Old Gods." }
    f.groups["laughing_skull"] = { name = "Laughing Skull", lore = "Treacherous thieves once led by the ogre Mogor." }
    f.groups["bonechewer"] = { name = "Bonechewer", lore = "Cannibals ornamented in bone, mostly fallen to corruption." }
    f.groups["black_tooth_grin"] = { name = "Black Tooth Grin", lore = "Rend and Maim's splinter clan within the Dark Horde." }
    f.groupsFootnote = "Beyond them stand the Mok'nathal of Rexxar's people and the Stonemaul ogres, smaller peoples bound to the Horde."
    f.figureText["thrall_forever"] = { name = "Thrall", role = "Warchief of the New Horde, founder of Durotar.", aff = "Horde, Frostwolf clan", title = "Warchief of the New Horde, founder of Durotar. — Horde, Frostwolf clan" }
    f.figureText["blackhand"] = { name = "Blackhand", role = "First Warchief of the Old Horde.", aff = "Old Horde, Blackrock clan", title = "First Warchief of the Old Horde. — Old Horde, Blackrock clan" }
    f.figureText["guldan"] = { name = "Gul'dan", role = "Master of the Shadow Council.", aff = "Shadow Council", title = "Master of the Shadow Council. — Shadow Council" }
    f.figureText["orgrim_doomhammer"] = { name = "Orgrim Doomhammer", role = "Warchief of the Second War.", aff = "Old Horde", title = "Warchief of the Second War. — Old Horde" }
    f.figureText["nerzhul"] = { name = "Ner'zhul", role = "Former elder shaman, now the Lich King.", aff = "Scourge", title = "Former elder shaman, now the Lich King. — Scourge" }
    f.figureText["grommash_hellscream"] = { name = "Grommash Hellscream", role = "Former chieftain of the Warsong, redeemer of the orcs.", aff = "Warsong clan", title = "Former chieftain of the Warsong, redeemer of the orcs. — Warsong clan" }
    f.figureText["garrosh_hellscream"] = { name = "Garrosh Hellscream", role = "Son of Grom, living among the Mag'har.", aff = "Mag'har", title = "Son of Grom, living among the Mag'har. — Mag'har" }
    f.figureText["durotan"] = { name = "Durotan", role = "Thrall's father, former chieftain of the Frostwolves.", aff = "Frostwolf clan", title = "Thrall's father, former chieftain of the Frostwolves. — Frostwolf clan" }
    f.figureText["draka"] = { name = "Draka", role = "Mate of Durotan, mother of Thrall.", aff = "Frostwolf clan", title = "Mate of Durotan, mother of Thrall. — Frostwolf clan" }
    f.figureText["greatmother_geyah"] = { name = "Greatmother Geyah", role = "Spiritual leader of the Mag'har.", aff = "Mag'har", title = "Spiritual leader of the Mag'har. — Mag'har" }
    f.figureText["drekthar"] = { name = "Drek'Thar", role = "Chieftain and elder shaman of the Frostwolves.", aff = "Frostwolf clan", title = "Chieftain and elder shaman of the Frostwolves. — Frostwolf clan" }
    f.figureText["rend_blackhand"] = { name = "Rend Blackhand", role = "Son of Blackhand, Warchief of the Dark Horde.", aff = "Dark Horde", title = "Son of Blackhand, Warchief of the Dark Horde. — Dark Horde" }
    f.figureText["teron_gorefiend"] = { name = "Teron Gorefiend", role = "First of the death knights.", aff = "Shadowmoon clan", title = "First of the death knights. — Shadowmoon clan" }
    f.figureText["broxigar"] = { name = "Broxigar", role = "Veteran, the only mortal to wound Sargeras.", aff = "Horde", title = "Veteran, the only mortal to wound Sargeras. — Horde" }
    f.figureText["varok_saurfang"] = { name = "Varok Saurfang", role = "Brother of Broxigar, high commander of the Horde.", aff = "Horde", title = "Brother of Broxigar, high commander of the Horde. — Horde" }
    f.figureText["dranosh_saurfang"] = { name = "Dranosh Saurfang", role = "Son of Saurfang, among the Mag'har.", aff = "Mag'har", title = "Son of Saurfang, among the Mag'har. — Mag'har" }
    f.figureText["eitrigg"] = { name = "Eitrigg", role = "High-ranking commander, Thrall's advisor.", aff = "Horde", title = "High-ranking commander, Thrall's advisor. — Horde" }
    f.figureText["kilrogg_deadeye"] = { name = "Kilrogg Deadeye", role = "Former chieftain of the Bleeding Hollow.", aff = "Bleeding Hollow clan", title = "Former chieftain of the Bleeding Hollow. — Bleeding Hollow clan" }
    f.figureText["jorin_deadeye"] = { name = "Jorin Deadeye", role = "Son of Kilrogg, chieftain of the Bleeding Hollow.", aff = "Mag'har", title = "Son of Kilrogg, chieftain of the Bleeding Hollow. — Mag'har" }
    f.figureText["kargath_bladefist"] = { name = "Kargath Bladefist", role = "Chieftain of the Shattered Hand.", aff = "Fel Horde", title = "Chieftain of the Shattered Hand. — Fel Horde" }
    f.figureText["zuluhed_the_whacked"] = { name = "Zuluhed the Whacked", role = "Former chieftain of the Dragonmaw.", aff = "Dragonmaw clan", title = "Former chieftain of the Dragonmaw. — Dragonmaw clan" }
    f.figureText["rehgar_earthfury"] = { name = "Rehgar Earthfury", role = "Advisor to Thrall.", aff = "Horde", title = "Advisor to Thrall. — Horde" }
    f.figureText["nazgrel"] = { name = "Nazgrel", role = "Thrall's loyal advisor.", aff = "Frostwolf clan", title = "Thrall's loyal advisor. — Frostwolf clan" }
    f.figureText["samuro"] = { name = "Samuro", role = "Blademaster, companion of Rexxar.", aff = "Independent", title = "Blademaster, companion of Rexxar. — Independent" }
    f.figureText["rokaro"] = { name = "Rokaro", role = "Champion of the Horde, companion of Rexxar.", aff = "Horde", title = "Champion of the Horde, companion of Rexxar. — Horde" }
    f.figureText["utok_scratcher"] = { name = "Utok Scratcher", role = "Chronicler of the Second War.", aff = "Old Horde", title = "Chronicler of the Second War. — Old Horde" }
    f.figureText["drakthul"] = { name = "Drak'thul", role = "Hermit, last survivor of the Stormreavers.", aff = "Independent", title = "Hermit, last survivor of the Stormreavers. — Independent" }
end

f = IMAGOdb.races["troll"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Trolls"
    f.groupTabLabel = "Tribes"
    f.quote = { text = "When you became a shadow hunter, you transcended being my son. You became a father for all trolls. You bear responsibility for all of us, for what we gonna become.", author = "Sen'jin" }
    f.overview = "Trollkind is one of Azeroth's oldest native races, divided into many tribes adapted to every land: jungle, forest, ice and sand. Most tribes adhere to the ancient Zandalari tribe yet hold no loyalty beyond their own, but the Darkspear tribe, driven from Stranglethorn and rescued by Thrall, swore itself to the new Horde. From their threatened fishing village of Sen'jin on the Durotar coast, the Echo Isles lost to the traitor Zalazane, they fight to reclaim their first home on Kalimdor."
    f.facts = {
        faction = "Horde (Darkspear tribe; other tribes independent or hostile)",
        capital = "Sen'jin Village, Durotar (the Echo Isles held by Zalazane)",
        leader = "Chieftain Vol'jin, son of Sen'jin",
        mount = "Raptor",
        language = "Zandali, Orcish",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "MAGE" }, { classFile = "PRIEST" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" }, { classFile = "WARLOCK" } }
    f.history = [[The trolls were among the first races to arise around the Well of Eternity, savage hunter-gatherers who worshipped the Wild Gods as "loa" and raised their shrines on the holy peaks of Zandalar, crowned by the temple city Zuldazar. When the C'Thrax Kith'ix rallied the aqiri swarms, the Zandalari united all tribes into the Empire of Zul and broke the insectoid legions; the far-flung strongholds that guarded the victory grew into the empires of the Amani, Gurubashi and Drakkari. Dark trolls settling by the Well became the first night elves, whose queen Azshara later humbled the troll nations and fostered a hatred that has never cooled.

Centuries of ruin followed the Sundering. In the north, Zandalari-guided Amani under Jintha nearly destroyed Quel'Thalas until Arathor's hundred magi burned their warbands from the field. In the south, the starving Gurubashi gave themselves to Hakkar the Soulflayer; the Zandalari stormed Zul'Gurub to end his reign, and when the surviving Atal'ai raised a new temple in the Swamp of Sorrows, Ysera sank it beneath the mire and set her green dragons to guard it. And on Stormwind's border, the Gurubashi warlord Zan'non's siege broke only when the Guardian Medivh rained fire from the walls.

The wars of the new age found the tribes divided. In the Second War the Amani joined Doomhammer's Horde after their warlord Zul'jin was freed from human chains, until the elves pushed them back to Zul'Aman. In the Third War, the Darkspear trolls of the South Seas islands fought beside Thrall against Daelin Proudmoore's fleet and the naga Zar'jira. Their wise chieftain Sen'jin fell, and his son Vol'jin led the survivors west to join the Horde on Kalimdor. The Darkspears claimed the Echo Isles, then lost them to the witch doctor Zalazane's mind-slavery, and now hold the fishing village of Sen'jin. Meanwhile the old threats stir: the Atal'ai returned to the Sunken Temple as its green dragon wardens slipped into the Emerald Nightmare, and Jin'do the Hexxer's Hakkari have enslaved Zul'Gurub's priests. The Zandalari call for aid to stop Hakkar's return.]]
    f.culture = [[All trollkind is divided into tribes. Every six years envoys gather at Zuldazar to weigh matters touching the whole race, and once a generation the greatest trolls duel in the Gurubashi Arena for the glory of the loa, among the highest honors a troll can win. They wear gold rather than rings, bind blood to raptor companions over years of mutual survival, and walk barefoot save in war. Their bodies regenerate wounds that would slay other races; only the loa's curse can strip that gift, and a removed head makes death sure.

Their magic is their own: voodoo, the ancient power of the trolls, and hoodoo beside it; e'ko the life force in every creature, juju the objects that house it, muisek the avenging spirit of a violent death, and mojo the fluid of ritual. The loa grant even druidism and shamanism's gifts, for the trolls learn magic not by study but from the gods themselves. Their faith is complex and dark: countless loa, most weak, some mighty; families keep family loa, cities their civic gods, nations the greatest names. And cannibalism runs deep. Most tribes eat their dead foes; the Zandalar and Revantusk abstain, and the Darkspear gave the custom up upon joining the Horde.]]
    f.relations = {
        { name = "The Horde", text = "The Darkspear's sworn allegiance, bought with Sen'jin's blood on the islands and sealed at Hyjal; Vol'jin sits beside Thrall in counsel." },
        { name = "Other troll tribes", text = "The Darkspear are pariahs to most of trollkind; the Gurubashi tribes that tormented them in Stranglethorn remain bitter rivals, while the Revantusk of the Hinterlands stand with the Horde." },
        { name = "The Zandalari", text = "The self-styled protectors of all trolls, who reach the Darkspear when the fate of the race is at stake, as now, when Hakkar rises in Zul'Gurub." },
        { name = "Night elves", text = "The oldest hatred; Azshara's ancient humiliation burns in every troll tale, and the Horde's war in Ashenvale renews it." },
        { name = "The Alliance", text = "Trolls count the humans of Stormwind as butchers of the Gurubashi war, and the high elves of Quel'Thalas as squatters on sacred Amani ground." },
        { name = "The naga", text = "The Darkspear's first enemy on their islands was the naga sorceress Zar'jira, who cost Sen'jin his life." },
    }
    f.groups["darkspear_tribe"] = { name = "Darkspear tribe", lore = "Vol'jin's own, exiles of Stranglethorn, sworn to the Horde; home at Sen'jin Village, the Echo Isles under Zalazane's thrall." }
    f.groups["zandalari_tribe_zandalari_empire"] = { name = "Zandalari tribe / Zandalari Empire", lore = "The spiritual leaders of all trolls on their island Zandalar; they convene the tribes, keep the lore, and now call for aid against Hakkar." }
    f.groups["gurubashi_tribes"] = { name = "Gurubashi tribes", lore = "The jungle trolls of Stranglethorn: the Gurubashi at Zul'Gurub enthralled by Jin'do's Hakkari, the Bloodscalp at Zul'Kunda, the Skullsplitter at Zul'Mamwe, and the Atal'ai in the Sunken Temple." }
    f.groups["amani_tribes"] = { name = "Amani tribes", lore = "The forest trolls of the north: the Amani of Zul'Aman, the Mossflayer of Zul'Mashar in the Plaguelands, the Witherbark of the Arathi Highlands, the Vilebranch of the Hinterlands, and the Smolderthorn and Firetree clinging to Blackrock Spire under the Dark Horde." }
    f.groups["revantusk_tribe"] = { name = "Revantusk tribe", lore = "Forest trolls of Revantusk Village, the only forest tribe allied with the Horde." }
    f.groups["shatterspear_tribe"] = { name = "Shatterspear tribe", lore = "Reclusive jungle trolls of Shatterspear Vale in Darkshore under Chieftain Jor'kil, bound by a peace pact with the night elves; unaligned." }
    f.groups["drakkari_tribes"] = { name = "Drakkari tribes", lore = "The ice trolls: the Drakkari of Zul'Drak, the Frostmane raiding Dun Morogh, the Winterax and Winterfang of the north." }
    f.groups["farraki_tribe"] = { name = "Farraki tribe", lore = "The sand trolls of Zul'Farrak in Tanaris." }
    f.groups["shadowtooth_clan"] = { name = "Shadowtooth clan", lore = "Dark trolls lingering in the caverns beneath Mount Hyjal." }
    f.figureText["vol_jin_forever"] = { name = "Vol'jin", role = "Chieftain of the Darkspear, son of Sen'jin.", aff = "Darkspear tribe, Horde", title = "Chieftain of the Darkspear, son of Sen'jin. — Darkspear tribe, Horde" }
    f.figureText["senjin"] = { name = "Sen'jin", role = "Former chieftain of the Darkspear, Vol'jin's father.", aff = "Darkspear tribe", title = "Former chieftain of the Darkspear, Vol'jin's father. — Darkspear tribe" }
    f.figureText["rokhan"] = { name = "Rokhan", role = "Lead scout of the Darkspear.", aff = "Darkspear tribe, Horde", title = "Lead scout of the Darkspear. — Darkspear tribe, Horde" }
    f.figureText["master_gadrin"] = { name = "Master Gadrin", role = "Advisor and mentor to Vol'jin, leader of Sen'jin Village.", aff = "Darkspear tribe", title = "Advisor and mentor to Vol'jin, leader of Sen'jin Village. — Darkspear tribe" }
    f.figureText["zalazane"] = { name = "Zalazane", role = "Traitor, self-proclaimed ruler of the Echo Isles.", aff = "Darkspear tribe (renegade)", title = "Traitor, self-proclaimed ruler of the Echo Isles. — Darkspear tribe (renegade)" }
    f.figureText["zuljin"] = { name = "Zul'jin", role = "Former warlord of the Amani.", aff = "Amani", title = "Former warlord of the Amani. — Amani" }
    f.figureText["jindo_the_hexxer"] = { name = "Jin'do the Hexxer", role = "Master of Zul'Gurub through the Hakkari.", aff = "Hakkari", title = "Master of Zul'Gurub through the Hakkari. — Hakkari" }
    f.figureText["zanzil_the_outcast"] = { name = "Zanzil the Outcast", role = "Outcast witch doctor.", aff = "Gurubashi", title = "Outcast witch doctor. — Gurubashi" }
    f.figureText["jammalan_the_prophet"] = { name = "Jammal'an the Prophet", role = "Leader of the Atal'ai in the Sunken Temple.", aff = "Atal'ai", title = "Leader of the Atal'ai in the Sunken Temple. — Atal'ai" }
    f.figureText["elder_torntusk"] = { name = "Elder Torntusk", role = "Co-leader of the Revantusk.", aff = "Revantusk, Horde", title = "Co-leader of the Revantusk. — Revantusk, Horde" }
    f.figureText["primal_torntusk"] = { name = "Primal Torntusk", role = "Co-leader of the Revantusk.", aff = "Revantusk, Horde", title = "Co-leader of the Revantusk. — Revantusk, Horde" }
    f.figureText["warlord_threshjin"] = { name = "Warlord Thresh'jin", role = "Leader of the Mossflayer.", aff = "Mossflayer", title = "Leader of the Mossflayer. — Mossflayer" }
    f.figureText["war_master_voone"] = { name = "War Master Voone", role = "Leader of the Smolderthorn at Blackrock.", aff = "Firegut, Dark Horde", title = "Leader of the Smolderthorn at Blackrock. — Firegut, Dark Horde" }
    f.figureText["ganzulah"] = { name = "Gan'zulah", role = "Leader of the Bloodscalp.", aff = "Bloodscalp", title = "Leader of the Bloodscalp. — Bloodscalp" }
    f.figureText["anathek_the_cruel"] = { name = "Ana'thek the Cruel", role = "Leader of the Skullsplitter.", aff = "Skullsplitter", title = "Leader of the Skullsplitter. — Skullsplitter" }
    f.figureText["chief_ukorz_sandscalp"] = { name = "Chief Ukorz Sandscalp", role = "Chieftain of the Sandfury.", aff = "Sandfury", title = "Chieftain of the Sandfury. — Sandfury" }
    f.figureText["king_rastakhan"] = { name = "King Rastakhan", role = "God King of the Zandalari Empire.", aff = "Zandalari", title = "God King of the Zandalari Empire. — Zandalari" }
    f.figureText["zanza_the_restless"] = { name = "Zanza the Restless", role = "Loa of Zandalar.", aff = "Zandalari", title = "Loa of Zandalar. — Zandalari" }
    f.figureText["hakkar_the_soulflayer"] = { name = "Hakkar the Soulflayer", role = "Loa of Blood, being summoned in Zul'Gurub.", aff = "Atal'ai, Hakkari", title = "Loa of Blood, being summoned in Zul'Gurub. — Atal'ai, Hakkari" }
    f.figureText["frost_king_malakk"] = { name = "Frost King Malakk", role = "Ruler of the Drakkari.", aff = "Drakkari Empire", title = "Ruler of the Drakkari. — Drakkari Empire" }
end

f = IMAGOdb.races["undead"]
if f then
    f.figureText = f.figureText or {}
    f.name = "The Forsaken"
    f.groupTabLabel = "Orders"
    f.quote = { text = "Do not shy from dark paths, if those paths lead to victory.", author = "Forsaken proverb" }
    f.overview = "Death offered no escape for the scores of humans and high elves slain by the Lich King's forces during the Third War. They rose as Scourge minions, enslaved to war on all they once held dear. When the Lich King's grip faltered, a contingent of the undead broke free, tormented by memories of their atrocities and hunted by a world that saw only monsters. The former Ranger-General of Silvermoon, Sylvanas Windrunner, rallied these Forsaken, made the Undercity beneath Lordaeron's ruins their refuge, and bound them to her burning purpose: the destruction of Arthas – once the Lich King's champion and the despoiler of their homelands, now himself a being risen beyond death."
    f.facts = {
        faction = "Horde",
        capital = "The Undercity, beneath the Ruins of Lordaeron",
        leader = "Sylvanas Windrunner, the Banshee Queen; majordomo Varimathras",
        mount = "Skeletal horse",
        language = "Gutterspeak, Orcish",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "ROGUE" }, { classFile = "MAGE" }, { classFile = "PRIEST" }, { classFile = "WARLOCK" }, { classFile = "PALADIN" } }
    f.history = [[Lordaeron fell in the Third War to Arthas Menethil's Scourge, its dead raised to serve. But when Illidan's attack on the Frozen Throne weakened the Lich King's power, many undead across the Plaguelands woke to free will and to horror at their own deeds. As Arthas departed for Northrend, Sylvanas Windrunner, herself a banshee torn from the Scourge, rallied the free-willed and seized the undead empire. With banshees controlling gnolls, bandits and ogres, the dreadlord Varimathras's coerced oath, and Grand Marshal Garithos's Alliance resistance enthralled to her will, she reclaimed Lordaeron. Then she executed her living allies rather than honor her promise to leave them the city. From the ruins of Capital City she proclaimed her faction the "Forsaken" and swore to slaughter any who stood in their way. The catacombs the Scourge had begun beneath the city became their refuge: the Undercity.

To shield her budding nation, Sylvanas sent emissaries seeking allies. None returned from the Alliance. It was the kind-hearted tauren of Thunder Bluff who answered: Archdruid Hamuul Runetotem saw hope of redemption in them, and the elder crone Magatha Grimtotem argued that tauren ways might restore their humanity. Thrall and Cairne doubted, but the Earthen Ring held it the Horde's duty to aid a people wrestling inner demons as the orcs once had. The alliance was forged: the Forsaken gained their chance at vengeance, the Horde an invaluable foothold in the Eastern Kingdoms.

Now the Forsaken are the Horde's foremost power east of the sea. They war without pause against the Scarlet Crusade, whose zealots would purge every undead from Azeroth, while the Defilers hold the Arathi Basin's resources. In the Apothecarium, the Royal Apothecary Society works toward a New Plague, a weapon against the Scourge and ostensibly the living. And Nathanos Blightcaller, the champion Sylvanas tore personally from the Scourge's grip, hunts the Scarlet Crusade.]]
    f.culture = [[Undercity never sleeps, and neither do its people. Undeath reshapes more than flesh: souls bind imperfectly to their bodies, muting pain and touch alike, and the Holy Light that heals a Forsaken brings agony, yet some priests still wield it at full cost. Most Forsaken feel remorse, pity or rage; few feel joy. A new-risen may wake in terror or frenzy and is guided gently through "the Gift" until their will returns. Then comes the ultimatum all Forsaken accept: serve the Dark Lady, or return to the grave. Free will is their culture's cornerstone, and their queen demands loyalty but holds no thrall.

They mark their rebirth with new names, Nathanos Marris became Blightcaller, and dress in black, gray and dark purple. They need no food and taste little of it anyway; their tongues read texture instead. They know a hunger for humanoid flesh and mend themselves by cannibalizing the dead, by grafting new muscle and sinew, or by draining the living. The true death, execution, answers high treason and rebellion; the Last Death is the end they choose for themselves. Their mounts are skeletal horses and great bats. Their faiths divide: some keep the Holy Light still, at terrible price; others built the Cult of Forgotten Shadow from Bishop Natalie Seline's recovered teachings, preaching balance between Light and darkness, and that the faiths of life failed them.]]
    f.relations = {
        { name = "The Horde", text = "An alliance of convenience, entered because the \"primitive races\" could serve Forsaken victory; they keep their own machinations, and the orcs watch a nation that quietly kills prisoners and experiments on its own allies." },
        { name = "The tauren", text = "Their staunchest advocates; the Elder Council's intentions are pure, while a sealed letter spoke of an alliance between the Forsaken and the Grimtotem." },
        { name = "The Revantusk trolls", text = "Accepting enough to fight beside them against the Scarlet Crusade." },
        { name = "The living world", text = "Humans call them \"deaders\", \"rotters\" and \"bonebags\"; the Scarlet Crusade counts them as monsters regardless of allegiance, and the Forsaken forge documents to poison Alliance-Crusade relations." },
    }
    f.groups["undercity"] = { name = "The Undercity", lore = "The Forsaken nation under Sylvanas Windrunner, Banshee Queen; the dreadlord Varimathras serves as her majordomo." }
    f.groups["royal_apothecary_society"] = { name = "The Royal Apothecary Society", lore = "Faranell's alchemists and necromancers of the Apothecarium, stitching abominations and pursuing the New Plague." }
    f.groups["deathguard"] = { name = "The Deathguard", lore = "The Forsaken's soldiers and watchmen, holding the roads and villages of Tirisfal." }
    f.groups["deathstalkers"] = { name = "The Deathstalkers", lore = "Spies, assassins and scouts in the dark places of the living." }
    f.groups["defilers"] = { name = "The Defilers", lore = "The Forsaken host tasked with claiming the resources of Arathi Basin." }
    f.groups["dark_rangers"] = { name = "The dark rangers", lore = "Undead elven rangers under the Banshee Queen, heirs of Quel'Thalas's own." }
    f.groups["cult_of_forgotten_shadow"] = { name = "The Cult of Forgotten Shadow", lore = "The shadow priests' order, born of Natalie Seline's recovered teachings." }
    f.groups["scourge_and_the_scarlet_crusade"] = { name = "The Scourge and the Scarlet Crusade", lore = "The two besetting foes: the masters they escaped, and the zealots who would unmake them." }
    f.figureText["sylvanas_windrunner_forever"] = { name = "Sylvanas Windrunner", role = "The Dark Lady, Banshee Queen of the Forsaken.", aff = "Forsaken, Horde", title = "The Dark Lady, Banshee Queen of the Forsaken. — Forsaken, Horde" }
    f.figureText["varimathras_forever"] = { name = "Varimathras", role = "Arch Lord of the Undercity, Sylvanas's majordomo.", aff = "Forsaken", title = "Arch Lord of the Undercity, Sylvanas's majordomo. — Forsaken" }
    f.figureText["nathanos_blightcaller"] = { name = "Nathanos Blightcaller", role = "Champion of the Banshee Queen, Ranger Lord.", aff = "Forsaken", title = "Champion of the Banshee Queen, Ranger Lord. — Forsaken" }
    f.figureText["master_apothecary_faranell"] = { name = "Master Apothecary Faranell", role = "Leader of the Royal Apothecary Society.", aff = "Royal Apothecary Society", title = "Leader of the Royal Apothecary Society. — Royal Apothecary Society" }
    f.figureText["belmont"] = { name = "Belmont", role = "Leader of the Deathstalkers.", aff = "Deathstalkers", title = "Leader of the Deathstalkers. — Deathstalkers" }
    f.figureText["alexi_barov"] = { name = "Alexi Barov", role = "Heir of House Barov.", aff = "Forsaken", title = "Heir of House Barov. — Forsaken" }
    f.figureText["helcular"] = { name = "Helcular", role = "Forsaken necromancer.", aff = "Forsaken", title = "Forsaken necromancer. — Forsaken" }
    f.figureText["gunther_arcanus"] = { name = "Gunther Arcanus", role = "Lich recruited by the Apothecarium.", aff = "Forsaken", title = "Lich recruited by the Apothecarium. — Forsaken" }
    f.figureText["leonid_barthalomew"] = { name = "Leonid Barthalomew", role = "Researcher of undeath, Argent Dawn.", aff = "Argent Dawn", title = "Researcher of undeath, Argent Dawn. — Argent Dawn" }
    f.figureText["alonsus_faol"] = { name = "Alonsus Faol", role = "Former Archbishop of the Church of the Holy Light.", aff = "the Church", title = "Former Archbishop of the Church of the Holy Light. — the Church" }
end

f = IMAGOdb.races["tauren"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Tauren"
    f.groupTabLabel = "Tribes"
    f.quote = { text = "Into the brave hearts of her pure children, the Earthmother placed the love of the hunt. For the creatures of the first dawn were savage and fierce. They hid from the Earthmother, finding solace in the shadows and the wild places of the land. The Shu'halo hunted these beasts wherever they could be found and tamed them with the Earthmother's blessing.", author = "The White Stag and the Moon" }
    f.overview = "The tauren, shu'halo in their own tongue, are a noble race of enormous bovine humanoids who wandered Kalimdor's plains for countless generations, always harried by the brutal centaur. When Thrall's Horde helped Cairne Bloodhoof fend off the centaur and reach the lush valley of Mulgore, High Chieftain Cairne Bloodhoof built the first tauren city of Thunder Bluff on its mesas. Recognizing the honor and ferocity of their new friends, the tauren gladly joined the new Horde as steadfast allies."
    f.facts = {
        faction = "Horde",
        capital = "Thunder Bluff, Mulgore",
        leader = "High Chieftain Cairne Bloodhoof (counseled by Archdruid Hamuul Runetotem and elder crone Magatha Grimtotem)",
        mount = "Kodo",
        language = "Taur-ahe, Orcish",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "SHAMAN" }, { classFile = "DRUID" } }
    f.history = [[The tauren descend from the yaungol, a bovine race of ancient Kalimdor that lived in peace with the demigod Cenarius before being driven south and enslaved by the mogu. Freed in the pandaren revolution, some yaungol wandered back north and settled by the Well of Eternity, and there the Well's energies changed them into the tauren. The Sundering cut them off from their yaungol and taunka kin forever.

In the War of the Ancients the tauren tribes of Highmountain answered Korialstrasz's call and marched beneath Huln Highmountain, wielder of the eagle spear, whose valor earned them Cenarius's blessing, the Horns of Eche'ro. Millennia later the shu'halo of the Barrens awakened Princess Theradras beneath the sacred meadow of Mashan'she, unknowingly unleashing ruin: the elemental drained the land into Desolace, and her union with Zaetar, son of Cenarius, spawned the centaur, who murdered their father and drove the tauren into an endless nomadic war. For generations the tribes roamed the Barrens hunting kodo, united only by hatred of their sworn foe.

Extinction loomed when Cairne Bloodhoof found the green-skinned strangers from over the sea. With Thrall's orcs at their side, the Bloodhoof tribe drove back the centaur and claimed the grasslands of Mulgore, the first true homeland in millennia, and Cairne raised Thunder Bluff as a refuge for every tribe. Bound by blood-debt, the tauren stood with the Horde at Mount Hyjal. Now the scattered tribes have united under the wise High Chieftain, yet peace is not whole: the Grimtotem plot to usurp his rule, the Bristleback quilboar press into Mulgore, and a strange evil has crept into the Emerald Dream itself.]]
    f.culture = [[The shu'halo strive for balance: their warriors fight only when there is need, their hunters take only what the tribes require, and their shamans stand as guides and mediators to the elemental spirits. They are a calm, steady people who prize wise discussion over haste and hold their elders in deepest respect, yet the rites of the Great Hunt are the heart of their spiritual culture, and every tauren seeks identity as hunter and child of the Earthmother. They are taught never to waste what nature gives, for if they honor the Earthmother, she will bless them in return.

Their faith is the Earth Mother, their creator: when her children fell to the corrupting whispers below the earth, she tore out her eyes and set them spinning across the sky, Mu'sha the moon and An'she the sun, neither greater than the other. Darkness is not evil to them but natural. Their dead are not buried but burned, ritually bathed, wrapped, and given to pyre and wind and river, to become one with Earth Mother and Sky Father; only the most valiant rest at sacred Red Rocks. Young tauren earn the standing of brave through the Rites of the Earthmother: Strength, Courage, Honor, Winds, Vision, and Wisdom. Kodos bear them; wyverns are sacred. White-furred tauren, taken as omens of a coming age, wander the land as reclusive priests.]]
    f.relations = {
        { name = "The Horde", text = "Unshakeable allies bound by blood-debt; the Grimtotem remain the only tribe that never formally joined." },
        { name = "The Forsaken", text = "The kind-hearted tauren were Sylvanas's most promising door into the Horde; the Elder Council still hopes to cure their curse." },
        { name = "The Alliance", text = "The least hostile of the Horde's peoples; yet dwarven digging scars the Earth Mother in their eyes, and the dwarves of Bael'dun Keep nearly wiped out the Stonespire tribe." },
        { name = "Night elves", text = "Their best tie across the lines: shared druidic faith and the open gates of Moonglade, Hamuul working beside the kaldorei in the Cenarion Circle." },
        { name = "The centaur", text = "The eternal enemy, born of their own tragic awakening; Horde support has finally turned the ancient war in the tauren's favor." },
        { name = "The quilboar", text = "Raiders of land and food; the Bristleback have warred on Red Cloud Mesa for years." },
        { name = "Harpies", text = "The Windfury covens poach kodo herds and war over the Stonetalons." },
        { name = "Furbolgs", text = "Friendly since the War of the Ancients." },
    }
    f.groups["bloodhoof_tribe"] = { name = "Bloodhoof tribe", lore = "Cairne's own tribe, ruling from Bloodhoof Village and Thunder Bluff." }
    f.groups["grimtotem_tribe"] = { name = "Grimtotem tribe", lore = "The aggressive extreme of taurenkind, openly hostile to the other tribes and plotting to usurp Cairne's rule under elder crone Magatha." }
    f.groups["runetotem_tribe"] = { name = "Runetotem tribe", lore = "Hamuul's tribe, heart of tauren druidism in Thunder Bluff." }
    f.groups["tribes_of_thunder_bluff"] = { name = "The tribes of Thunder Bluff", lore = "Cloudsong, Dawnstrider, Eagletalon, Hawkwind, Ragetotem, Skychaser, Steelrage, Stonehoof, Thunderhorn, Wildmane, Winterhoof and others." }
    f.groups["far_tribes"] = { name = "The far tribes", lore = "Cliffrunner at Freewind Post, Cliffwalker in Stonetalon, Ironhoof at Last Forest in Desolace, Farwanderers at Camp Narache, Stonespire of the southern Barrens." }
    f.groups["earthen_ring"] = { name = "Earthen Ring", lore = "The worldwide circle of shamans, originally founded by tauren; its Elder Council governs Thunder Bluff beside the High Chieftain." }
    f.groups["longwalkers"] = { name = "Longwalkers", lore = "Scouts and messengers sworn only to the High Chieftain." }
    f.groups["outrunners"] = { name = "Outrunners", lore = "Guardians of every traveler crossing Mulgore's plains." }
    f.figureText["cairne_bloodhoof_forever"] = { name = "Cairne Bloodhoof", role = "High Chieftain of the united tauren tribes.", aff = "Horde, Thunder Bluff", title = "High Chieftain of the united tauren tribes. — Horde, Thunder Bluff" }
    f.figureText["baine_bloodhoof"] = { name = "Baine Bloodhoof", role = "Cairne's son, heir of the Bloodhoof tribe.", aff = "Horde, Thunder Bluff", title = "Cairne's son, heir of the Bloodhoof tribe. — Horde, Thunder Bluff" }
    f.figureText["magatha_grimtotem"] = { name = "Magatha Grimtotem", role = "Elder Crone of the Grimtotem tribe.", aff = "Grimtotem tribe", title = "Elder Crone of the Grimtotem tribe. — Grimtotem tribe" }
    f.figureText["hamuul_runetotem"] = { name = "Hamuul Runetotem", role = "Archdruid of the tauren, student of Malfurion.", aff = "Thunder Bluff, Cenarion Circle", title = "Archdruid of the tauren, student of Malfurion. — Thunder Bluff, Cenarion Circle" }
    f.figureText["huln_highmountain"] = { name = "Huln Highmountain", role = "Leader of the tribes in the War of the Ancients.", aff = "Kaldorei resistance", title = "Leader of the tribes in the War of the Ancients. — Kaldorei resistance" }
    f.figureText["muln_earthfury"] = { name = "Muln Earthfury", role = "Leader of the Earthen Ring.", aff = "Earthen Ring", title = "Leader of the Earthen Ring. — Earthen Ring" }
    f.figureText["perith_stormhoof"] = { name = "Perith Stormhoof", role = "One of the oldest Longwalkers.", aff = "Bloodhoof tribe", title = "One of the oldest Longwalkers. — Bloodhoof tribe" }
    f.figureText["tagar_bloodhoof"] = { name = "Tagar Bloodhoof", role = "Second to Cairne.", aff = "Bloodhoof tribe", title = "Second to Cairne. — Bloodhoof tribe" }
    f.figureText["bovan_windtotem"] = { name = "Bovan Windtotem", role = "Leader of the Windtotem tribe.", aff = "Windtotem tribe", title = "Leader of the Windtotem tribe. — Windtotem tribe" }
    f.figureText["fleet_master_seahorn"] = { name = "Fleet Master Seahorn", role = "Fleet master of the Blackwater Raiders.", aff = "Blackwater Raiders", title = "Fleet master of the Blackwater Raiders. — Blackwater Raiders" }
    f.figureText["xarantaur"] = { name = "Xarantaur", role = "Watcher, student of Cenarius.", aff = "Bronze dragonflight", title = "Watcher, student of Cenarius. — Bronze dragonflight" }
    f.figureText["trag_highmountain"] = { name = "Trag Highmountain", role = "Traveler raised into undeath.", aff = "Independent", title = "Traveler raised into undeath. — Independent" }
end


-- ============================================================
-- BOTH FACTIONS (WoW Forever exclusive)
-- ============================================================

f = IMAGOdb.races["skyborne"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Skyborne"
    f.groupTabLabel = "Orders"
    f.quote = { text = "So now you see? There is a world of knowledge and untapped potential outside of Skywall. This will never stop being our home, but I've come to believe that the path to our salvation lies below. We must travel to Azeroth and gain the power and means to save Zephras Isle. This is the way. Will you have the courage to join us when the time comes?", author = "Ayessa Dawnsinger" }
    f.overview = "The Skyborne, the shen'dorei or \"hidden people\", are an elven race descended from the citizens of Eldre'Thalas, Highborne magisters and kaldorei alike, who fled Prince Tortheldrin's persecution nearly ten thousand years ago. They struck a pact with the wind spirits of Skywall, who raised Zephras Isle into the Elemental Plane of Air, and there they built a civilization hidden for millennia. Now the wind spirits are gone, the pylons that hold their islands aloft are failing, and the Skyborne descend upon Azeroth to save their home: the High Order seeking the Alliance's arcane wisdom, the Windshapers seeking the Horde's shamans."
    f.facts = {
        faction = "Alliance (High Order) and Horde (Windshapers); the Al'Aketh cult answers to Al'Akir",
        capital = "Valanaar, Zephras Isle (Elemental Plane of Air)",
        leader = "High Elder Talaanis Shadowsong (Zephras council), Supreme Magister Elaadrin Evengale (High Order), Grand Skyseer Ayessa Dawnsinger (Windshapers), High Priestess Lorthuna (Al'Aketh)",
        mount = "Galestrider",
        language = "Darnassian, Common, Orcish",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "DRUID" }, { classFile = "MAGE", note = "High Order only" }, { classFile = "SHAMAN", note = "Windshapers only" } }
    f.history = [[After the Sundering left Eldre'Thalas starving for magic, Prince Tortheldrin proposed drawing power from a demon world through crystalline foci. When noble houses opposed the plan, he silenced them in a single bloody night of purges. The resistance he created was led by the Shal'nan, "the Veiled One", a masked figure whose name became a battle cry. On the eve of the summoning ritual the rebels stormed the inner sanctum: wild magic ruptured, portals tore open, and though the rebels averted the city's destruction, the Shal'nan emerged as the confrontation's only survivor, forever changed and silent ever since on what he saw.

Scattered but free, the rebels fled west through Eldre'narr and sailed into the unknown. There they found an undiscovered land ruled by primordial wind spirits, and with Tortheldrin's fleet on their heels they bargained: the spirits lifted an entire landmass into the sky, anchoring Zephras Isle within Skywall. For millennia the shen'dorei thrived hidden in the Elemental Plane of Air. The Shal'nan abdicated his rule at the founding of the Shrine of the Four Winds, entrusting government to elected councils of elders. Skywall changed them, and in recent generations children began to be born with vivid cerulean skin, the "Sky-Touched Blessing" now claiming three of every ten newborns. And though they lived among the wind spirits, the spirits never once spoke Al'Akir's name.

Then, some centuries ago, the wind spirits vanished, and the Shal'nan with them. Without their magic, ancient pylons began to fail; Ban'aethal fell into the sky and refugees crowded Zephras Isle. The High Order and the Windshapers divided over the answer: Elaadrin Evengale's magisters opened a "keyhole" to Azeroth and won the Kirin Tor's welcome; Ayessa Dawnsinger reached the Earthen Ring and proposed seeking its shamanic mastery on Kalimdor. Grievances deepened, and the Al'Aketh, the hidden cult of Al'Akir's worshippers, struck at the pylons. Only a desperate truce of High Order, Windshapers and Peacekeepers stopped High Priestess Lorthuna at the Shrine of Akir, too late. Rohash of the Conclave of Wind answered her beacon and summoned the Windlord's armies; only the Kirin Tor and the Earthen Ring forced his retreat, with his promise to carry word of the islands to Al'Akir. With their refuge exposed and their home failing, the Skyborne set out for Azeroth: the High Order to the Alliance, the Windshapers to the Horde.]]
    f.culture = [[The shen'dorei are governed not by kings but by the Council of Elders, democratically chosen provincial leaders, one council per island, with High Elder Talaanis Shadowsong presiding over Zephras Isle's own. Their faith is elemental: the Windshapers' shamans are the spiritual leaders, guarding sacred sites like the standing stones of the Shen'dar Highlands and teaching skysight, the gift of perceiving and communing with elemental spirits, a gift growing rarer each year. The High Order's magisters instead chase the arcane heritage of their Highborne ancestors, drawing power from the ley lines that rise ever closer to the island's surface. Druidism survives, rare; some still "dream in emerald".

Their crafts and customs bear the stamp of Skywall: windstones hold concentrated elemental power as currency and fuel alike; skycutters carry them between islands; the magesmiths of fallen Ban'aethal were the finest artisans of the Isles. On coming of age each shen'dorei receives an heirloom passed down from the dead, returned to a communal collection to bless another youth, and at death their ashes are scattered to the winds. Their table knows crab meat and eggs fried in ursera tallow; even so humble a leaf as dried peacebloom finds its way into a pipe.]]
    f.relations = {
        { name = "The Alliance", text = "Bound through the Kirin Tor, who perceived the High Order's keyhole and agreed to receive them as guests; the High Order fights beside them for Azeroth's lost arcane knowledge." },
        { name = "The Horde", text = "Bound through the Earthen Ring, whose shamans the Windshapers count as orders of magnitude wiser in the elemental planes; the Windshapers fight beside them to master skysight and call the missing patrons home." },
        { name = "Between the orders", text = "Bitter. The High Order presses for self-reliant arcane mastery while the Windshapers hold faith with the spirits; sabotage and dead magisters have made the peace of the Shrine of Akir a temporary ceasefire, nothing more." },
        { name = "Al'Akir and his Conclave", text = "The looming threat. Rohash knows of them now and has sworn to carry word to the Windlord." },
        { name = "The Kaldorei", text = "Their ancestors' people, from whom they split ten thousand years ago; the night elves know nothing of their survival." },
        { name = "The wind spirits", text = "Their vanished patrons, \"wayward brothers\" of Rohash's Conclave by his own words." },
    }
    f.groups["high_order"] = { name = "The High Order", lore = "Descendants of Eldre'Thalas's Highborne magisters under Supreme Magister Elaadrin Evengale; recovering their ancestors' arcane lore and standing with the Alliance." }
    f.groups["windshapers"] = { name = "The Windshapers", lore = "Descendants of the kaldorei citizens under Grand Skyseer Ayessa Dawnsinger; shamanic spiritual leaders of the shen'dorei, standing with the Horde." }
    f.groups["alaketh"] = { name = "The Al'Aketh", lore = "The cult of Al'Akir the Windlord under High Priestess Lorthuna; risen to prominence since the spirits' departure, sworn to bring the Windlord's gaze to Zephras." }
    f.groups["peacekeepers"] = { name = "The Peacekeepers", lore = "Zephras Isle's militia and closest thing to an army; the Empyrean Blades, once the Shal'nan's personal guard, now serve as their elite under Captain Valennia Stormfist." }
    f.groups["nightclaw_druids"] = { name = "The Nightclaw Druids", lore = "Secretive druids of the Shadowgale Forest, independent of every other faction." }
    f.groups["rangers_of_thendal_grove"] = { name = "The Rangers of Thendal Grove", lore = "Rangers keeping Thendal Village and its surrounds." }
    f.groups["council_of_elders"] = { name = "The Council of Elders", lore = "The islands' democratic governments, one per island." }
    f.figureText["the_shalnan"] = { name = "The Shal'nan", role = "\"The Veiled One\", first leader of the shen'dorei.", aff = "Shen'dorei", title = "\"The Veiled One\", first leader of the shen'dorei. — Shen'dorei" }
    f.figureText["talaanis_shadowsong"] = { name = "Talaanis Shadowsong", role = "High Elder of Zephras Isle.", aff = "Council of Elders", title = "High Elder of Zephras Isle. — Council of Elders" }
    f.figureText["valennia_stormfist"] = { name = "Valennia Stormfist", role = "Peacekeeper Captain.", aff = "Peacekeepers", title = "Peacekeeper Captain. — Peacekeepers" }
    f.figureText["elaadrin_evengale"] = { name = "Elaadrin Evengale", role = "Supreme Magister of the High Order.", aff = "High Order, Alliance", title = "Supreme Magister of the High Order. — High Order, Alliance" }
    f.figureText["ayessa_dawnsinger"] = { name = "Ayessa Dawnsinger", role = "Grand Skyseer of the Windshapers.", aff = "Windshapers, Horde", title = "Grand Skyseer of the Windshapers. — Windshapers, Horde" }
    f.figureText["high_priestess_lorthuna"] = { name = "High Priestess Lorthuna", role = "Leader of the Al'Aketh, hurled into the sky.", aff = "Al'Aketh", title = "Leader of the Al'Aketh, hurled into the sky. — Al'Aketh" }
    f.figureText["belathaan_brightwish"] = { name = "Belathaan Brightwish", role = "Magister of the High Order.", aff = "High Order", title = "Magister of the High Order. — High Order" }
    f.figureText["commander_haalien"] = { name = "Commander Haalien", role = "Former Nightclaw druid turned to the cult.", aff = "Al'Aketh", title = "Former Nightclaw druid turned to the cult. — Al'Aketh" }
    f.figureText["elegael_thornpaw"] = { name = "Elegael Thornpaw", role = "Leader of the Nightclaw Druids.", aff = "Nightclaw", title = "Leader of the Nightclaw Druids. — Nightclaw" }
    f.figureText["lotheluum_starbreeze"] = { name = "Lotheluum Starbreeze", role = "Investigator of the Al'Aketh attacks.", aff = "Independent", title = "Investigator of the Al'Aketh attacks. — Independent" }
    f.figureText["illaya_amberwing"] = { name = "Illaya Amberwing", role = "Ayessa's mentor, aging bearer of skysight.", aff = "Windshapers", title = "Ayessa's mentor, aging bearer of skysight. — Windshapers" }
    f.figureText["dorii_brightwhisper"] = { name = "Dorii Brightwhisper", role = "Advocate of arcane self-reliance.", aff = "High Order", title = "Advocate of arcane self-reliance. — High Order" }
    f.figureText["resaan"] = { name = "Resaan", role = "Dweller of fallen Ban'aethal.", aff = "Independent", title = "Dweller of fallen Ban'aethal. — Independent" }
    f.figureText["ealaane_nimbuswalker"] = { name = "Ealaane Nimbuswalker", role = "Resaan's widow.", aff = "Independent", title = "Resaan's widow. — Independent" }
end

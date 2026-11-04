-- ============================================================
-- IMAGO Forever — locales/base/data/classes.lua (enUS fallback)
-- Class dossier texts generated from the design documents.
-- Static records (classFile, faction, races, figure keys,
-- group keys) live in data/classes_static.lua.
-- figureText: name = display name, role/aff/race = member
-- table columns, title = legacy combined string.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.classes = IMAGOdb.classes or {}

local c = IMAGOdb.classes["warrior"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Warrior"
    c.quote = { text = "My blade seeks vengeance!", author = "Blademaster" }
    c.overview = [[Warriors are the quintessential fearless fighters on the battlefield, and their pure martial prowess inspires courage in allies and despair in enemies. Experts in all manner of melee weaponry and possessing incredible physical strength and skill, they are perfectly suited to serve as frontline combatants and battlefield commanders.

For as long as war has raged, heroes from every race have aimed to master the art of battle. Warriors combine strength, leadership, and a vast knowledge of arms and armor to wreak havoc in glorious combat. Some protect from the front lines with shields, locking down enemies while allies support them from behind with spell and bow. Others forgo the shield and unleash their rage at the closest threat with a variety of deadly weapons. The warrior's battle cries embolden friends and leave foes cowering in fear, and with legendary precision they target the smallest gaps in armor and slice at hamstrings in a blur of steel. Every dragon slain, corrupted tyrant toppled, and demon banished from Azeroth has trembled in the face of these lords of war.

Warriors train constantly and strive for perfection in armed combat. Though they come from all walks of life, they are united in their singular commitment to engage in glorious battle. Many serve as mercenary soldiers, while others become adventurers and danger-seeking fortune hunters.]]
    c.history = [[When Odyn the All-Father created the Valarjar, he looked to the mighty vrykul to fill its ranks, for he saw in them, above all other titan-forged, the perfect expression of the warrior spirit.

It was the vrykul Heimir of the Black Fist, king of the Tideskorn clan, who trained the first mortal warriors of Azeroth. He showed them the rudiments of battle and demonstrated the forms and techniques that would lay the foundation for honorable warfare, and he remained with them until they had truly developed a warrior's spirit; only then did he leave, returning generations later to build their knowledge yet again. Over the ages the tradition grew: students became masters, and masters instructed new acolytes, so that with each of the king's returns the mortals learned new, advanced techniques. Heimir's dream was that one day these outsiders would become mighty warriors in their own right, equal to any vrykul, and for a protector of Azeroth there was no better occupation than teaching the weakest the ways of strength.]]
    c.racesIntro = [[The warrior class is open to all nine races of the year 25: **Human, Dwarf, Night Elf, Gnome** (Alliance), **Orc, Undead, Tauren, Troll** (Horde) and the **Skyborne** (both factions). From the knights of Stormwind to the grunts of the Horde and the braves of Thunder Bluff, every people fields its own warriors.]]
    c.groups["knights_of_stormwind"] = { name = "Knights of Stormwind", lore = "The knighted warriors of the Stormwind army. They patrol the streets and make up the majority of the army." }
    c.groups["guardsmen"] = { name = "Guardsmen", lore = "Every major city has skilled warriors protecting its citizens. Be it the Stormwind Royal Guards or the Forsaken Deathguards, they are a major factor of a nation's security." }
    c.groups["warsong_clan"] = { name = "The Warsong Clan", lore = "An orcish clan from Draenor known for its warlike traditions and unbending fighting spirit." }
    c.groups["blackrock_clan"] = { name = "The Blackrock Clan", lore = "One of the largest orcish clans known for strict military discipline. They have produced some of the most prominent orcish warriors of all time, such as Broxigar and Varok Saurfang, Orgrim Doomhammer, Eitrigg, and Blackhand." }
    c.groups["black_tooth_grin_clan"] = { name = "The Black Tooth Grin Clan", lore = "Formed by Warchief Blackhand shortly before the opening of the Dark Portal. They served as scouts and guardians and were usually the first to be sent into skirmishes. After the Second War they merged with the Blackrock Clan." }
    c.groups["blademasters"] = { name = "Blademasters", lore = "Legendary warriors of the Burning Blade Clan skilled with swords, axes, and polearms. They have remained loyal to the new Horde." }
    c.groups["korkron"] = { name = "The Kor'kron", lore = "The personal bodyguards of the Warchief. They are fierce and sometimes ruthless warriors and act as enforcers of their leader's will." }
    c.groups["dreadguard"] = { name = "The Dreadguard", lore = "Elite Forsaken military, their main objective originally lay in protecting the Banshee Queen. They have expanded into every corner of Forsaken territory nowadays, guarding important strategic locations." }
    c.groups["spellbreakers"] = { name = "Spellbreakers", lore = "Specialized warriors from Quel'Thalas, who are trained to disrupt the flow of magic in order to destroy enemy spellcasters." }
    c.groups["kings_guard"] = { name = "The King's Guard", lore = "Personal guardsmen of the members of the royal lineage of the Menethils. The order went defunct with Lordaeron's destruction." }
    c.groups["brotherhood_of_the_horse"] = { name = "Brotherhood of the Horse", lore = "A group of knightly warriors among the Stormwind military. It was destroyed in the First War." }
    c.figureText["anduin_lothar"] = { name = "Anduin Lothar", role = "Knight Champion of Stormwind, Supreme Commander of the Alliance of Lordaeron.", aff = "Alliance", race = "Human", title = "Knight Champion of Stormwind, Supreme Commander of the Alliance of Lordaeron. — Alliance (Human)" }
    c.figureText["varian_wrynn"] = { name = "Varian Wrynn", role = "Missing king of Stormwind.", aff = "Stormwind", race = "Human", title = "Missing king of Stormwind. — Stormwind (Human)" }
    c.figureText["llane_wrynn"] = { name = "Llane Wrynn", role = "Former king of Stormwind, slain in the First War.", aff = "Stormwind", race = "Human", title = "Former king of Stormwind, slain in the First War. — Stormwind (Human)" }
    c.figureText["marshal_reginald_windsor"] = { name = "Marshal Reginald Windsor", role = "Marshal of Stormwind.", aff = "Alliance", race = "Human", title = "Marshal of Stormwind. — Alliance (Human)" }
    c.figureText["king_magni_bronzebeard_forever"] = { name = "Magni Bronzebeard", role = "King of Ironforge.", aff = "Alliance", race = "Dwarf", title = "King of Ironforge. — Alliance (Dwarf)" }
    c.figureText["muradin_bronzebeard"] = { name = "Muradin Bronzebeard", role = "Middle Bronzebeard brother; presumed dead in Northrend.", aff = "Ironforge", race = "Dwarf", title = "Middle Bronzebeard brother; presumed dead in Northrend. — Ironforge (Dwarf)" }
    c.figureText["thargas_anvilmar"] = { name = "Thargas Anvilmar", role = "Defender of Thandol Span, last descendant of Modimus Anvilmar.", aff = "Ironforge", race = "Dwarf", title = "Defender of Thandol Span, last descendant of Modimus Anvilmar. — Ironforge (Dwarf)" }
    c.figureText["thoras_trollbane"] = { name = "Thoras Trollbane", role = "Former king of fallen Stromgarde.", aff = "Stromgarde", race = "Human", title = "Former king of fallen Stromgarde. — Stromgarde (Human)" }
    c.figureText["galen_trollbane"] = { name = "Galen Trollbane", role = "Crown prince of ruined Stromgarde.", aff = "Stromgarde", race = "Human", title = "Crown prince of ruined Stromgarde. — Stromgarde (Human)" }
    c.figureText["daelin_proudmoore"] = { name = "Daelin Proudmoore", role = "Former Lord Admiral of Kul Tiras.", aff = "Kul Tiras", race = "Human", title = "Former Lord Admiral of Kul Tiras. — Kul Tiras (Human)" }
    c.figureText["genn_greymane"] = { name = "Genn Greymane", role = "King of Gilneas behind the Wall.", aff = "Gilneas", race = "Human", title = "King of Gilneas behind the Wall. — Gilneas (Human)" }
    c.figureText["kurtalos_ravencrest"] = { name = "Kur'talos Ravencrest", role = "Lord of Black Rook Hold, first leader of the Kaldorei Resistance.", aff = "Kaldorei", race = "Night elf", title = "Lord of Black Rook Hold, first leader of the Kaldorei Resistance. — Kaldorei (Night elf)" }
    c.figureText["jarod_shadowsong"] = { name = "Jarod Shadowsong", role = "Former leader of the Kaldorei Resistance, in self-chosen exile.", aff = "Kaldorei", race = "Night elf", title = "Former leader of the Kaldorei Resistance, in self-chosen exile. — Kaldorei (Night elf)" }
    c.figureText["cairne_bloodhoof_forever"] = { name = "Cairne Bloodhoof", role = "Chieftain of the united tauren tribes.", aff = "Horde", race = "Tauren", title = "Chieftain of the united tauren tribes. — Horde (Tauren)" }
    c.figureText["baine_bloodhoof"] = { name = "Baine Bloodhoof", role = "Son of Cairne.", aff = "Bloodhoof tribe", race = "Tauren", title = "Son of Cairne. — Bloodhoof tribe (Tauren)" }
    c.figureText["blackhand"] = { name = "Blackhand", role = "First Warchief of the Old Horde.", aff = "Old Horde", race = "Orc", title = "First Warchief of the Old Horde. — Old Horde (Orc)" }
    c.figureText["orgrim_doomhammer"] = { name = "Orgrim Doomhammer", role = "Warchief during the Second War.", aff = "Old Horde", race = "Orc", title = "Warchief during the Second War. — Old Horde (Orc)" }
    c.figureText["grommash_hellscream"] = { name = "Grommash Hellscream", role = "Former chieftain of the Warsong clan, redeemer of the orcs.", aff = "Warsong clan", race = "Orc", title = "Former chieftain of the Warsong clan, redeemer of the orcs. — Warsong clan (Orc)" }
    c.figureText["dalrend_blackhand"] = { name = "Dal'rend Blackhand", role = "Warchief of the Dark Horde at Blackrock Spire.", aff = "Dark Horde", race = "Orc", title = "Warchief of the Dark Horde at Blackrock Spire. — Dark Horde (Orc)" }
    c.figureText["durotan"] = { name = "Durotan", role = "Father of Thrall, former chieftain of the Frostwolf clan.", aff = "Frostwolf", race = "Orc", title = "Father of Thrall, former chieftain of the Frostwolf clan. — Frostwolf (Orc)" }
    c.figureText["eitrigg"] = { name = "Eitrigg", role = "Advisor to Thrall.", aff = "Horde", race = "Orc", title = "Advisor to Thrall. — Horde (Orc)" }
    c.figureText["varok_saurfang"] = { name = "Varok Saurfang", role = "Brother of Broxigar, high commander of the Horde's forces.", aff = "Horde", race = "Orc", title = "Brother of Broxigar, high commander of the Horde's forces. — Horde (Orc)" }
    c.figureText["broxigar"] = { name = "Broxigar", role = "Orcish veteran; only mortal to have wounded Sargeras.", aff = "Horde", race = "Orc", title = "Orcish veteran; only mortal to have wounded Sargeras. — Horde (Orc)" }
    c.figureText["kilrogg_deadeye"] = { name = "Kilrogg Deadeye", role = "Former chieftain of the Bleeding Hollow clan.", aff = "Old Horde", race = "Orc", title = "Former chieftain of the Bleeding Hollow clan. — Old Horde (Orc)" }
    c.figureText["kargath_bladefist"] = { name = "Kargath Bladefist", role = "Chieftain of the Shattered Hand clan.", aff = "Outland", race = "Orc", title = "Chieftain of the Shattered Hand clan. — Outland (Orc)" }
    c.figureText["danath_trollbane"] = { name = "Danath Trollbane", role = "Former Force Commander of the Sons of Lothar.", aff = "Sons of Lothar", race = "Human", title = "Former Force Commander of the Sons of Lothar. — Sons of Lothar (Human)" }
    c.figureText["kurdran_wildhammer"] = { name = "Kurdran Wildhammer", role = "Wildhammer warrior of the Alliance Expedition.", aff = "Wildhammer", race = "Dwarf", title = "Wildhammer warrior of the Alliance Expedition. — Wildhammer (Dwarf)" }
    c.figureText["nazgrel"] = { name = "Nazgrel", role = "Orcish veteran, advisor to Thrall.", aff = "Horde", race = "Orc", title = "Orcish veteran, advisor to Thrall. — Horde (Orc)" }
    c.variants = "Berserker · Brave · Duelist · Footman · Gladiator · Grunt · Knight · Marine · Mountain king · Raider · Shieldbearer · Shieldmaiden · Spellbreaker · Mounted warrior"
end

c = IMAGOdb.classes["paladin"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Paladin"
    c.quote = { text = "In all things, paladins must reflect the Light... it's aiding others that will truly set you apart from the other citizens. Compassion, patience, bravery — these things mean as much to a paladin as strength in battle.", author = "Tome of Divinity" }
    c.overview = [[Paladins are holy knights, protectors of the people, and dispensers of justice. Where a Holy Priest serves as voice of the Light, preaching to the downtrodden and disillusioned, the paladin serves as hand of the Light, defending the faithful and enforcing divine law like a righteous hammer.

This is the call of the paladin: to protect the weak, to bring justice to the unjust, and to vanquish evil from the darkest corners of the world. These holy warriors are equipped with plate armor so they can confront the toughest of foes, and the blessing of the Light allows them to heal wounds and, in some cases, even restore life to the dead. Ready to serve, paladins can defend their allies with sword and shield, or they can wield massive two-handed weapons against their enemies. The Light grants paladins additional power against the undead and demons, ensuring that these profane beings corrupt the world no longer.

Paladins are not only zealots, but also guardians of the righteous, and they bestow blessings on those the Light would shine upon. The Light radiates from paladins, and worthy allies who stand near them are emboldened by its power. Although paladins were once exclusively human, a number of stout-hearted dwarves have recently been welcomed into the Order of the Silver Hand.]]
    c.history = [[The humans of Lordaeron were the first paladins on Azeroth, though not the first paladins of all: the draenei had known holy warriors of the Light far longer. The human paladins were founded during the Second War as a holy order of warriors whose purpose was to defend and shepherd the war-torn populace of Lordaeron. Archbishop Alonsus Faol had seen that the pious Clerics of Northshire, who had suffered terrible attrition in the First War, were ill-suited for the dangers of combat. Along with the surviving clerics he sought out only those of the greatest virtue among the knighthood of Lordaeron and tutored them in the ways of magic. Led by the crusading Uther the Lightbringer, the new paladins, christened the Knights of the Silver Hand, healed the wounds of battle and restored faith in freedom from orcish tyranny.

By the time of the Third War the order had fallen on hard times. The entire Silver Hand was disbanded for refusing to kill innocent townsfolk believed to be contaminated by the undead plague. Disenfranchised and driven from their homes, the paladins still worked selflessly to protect humanity. Many traveled to quarantined lands to ease the suffering within, and although they were immune to disease, the populace persecuted them out of fear of infection. Some pushed on to Northrend; embittered by their trials, they accepted the Lich King's offer of untold power and became death knights in his service.

Following the Third War, the humans of Stormwind and the dwarves of Ironforge began training their own paladins as members of the Knights of the Silver Hand. The same faith carried into darker channels: the Scarlet Crusade broke away from the Silver Hand and took the hunt for the Scourge so far that it turned on its former allies, suspecting anyone it believed carried the taint of undeath.]]
    c.racesFoot = "Each swears to the faith of the Church of the Holy Light. Their class mounts are the summoned warhorse and the charger."
    c.raceEntries = {
        { race = "human", text = "The first paladin people of Azeroth. The Order of the Silver Hand was founded among the knights of Lordaeron; after its fall, Stormwind carried the tradition on." },
        { race = "dwarf", text = "Recently welcomed into the Order of the Silver Hand; stout-hearted dwarves of Ironforge now train as paladins." },
    }
    c.groups["knights_of_the_silver_hand"] = { name = "Order of the Silver Hand", lore = "The first human paladin order founded by Alonsus Faol during the Second War to combat the warlocks of the Horde. Disbanded and its members slaughtered in the Third War by Arthas Menethil, yet survivors of the order remain." }
    c.groups["scarlet_crusade"] = { name = "The Scarlet Crusade", lore = "A fanatical sect of light-worshipers dedicated to exterminate the undead on Azeroth. They believe any non-human to carry the taint of undeath and have made enemies everywhere." }
    c.groups["brotherhood_of_northshire"] = { name = "Brotherhood of Northshire", lore = "A pious branch of the Church of the Holy Light who served Stormwind as priests and clerics before the First War. Their heroic sacrifice against the Horde inspired Alonsus Faol to train the first paladins and he drew from their ranks many of the first ones." }
    c.groups["argent_dawn"] = { name = "The Argent Dawn", lore = "Originally part of the Silver Hand, some members split after the order evolved into the fanatical Scarlet Crusade. Now, the Argent Dawn protects the Plaguelands from all evil, accepting everyone of good heart into their ranks, even if they are no paladins." }
    c.groups["champions_of_peace"] = { name = "The Champions of Peace", lore = "Led by Gavinrad the Dire, the champions served the Silver Hand as guardians of Andorhal during the Scourge of Lordaeron. They were all slain by Arthas Menethil." }
    c.figureText["uther_the_lightbringer"] = { name = "Uther the Lightbringer", role = "First human paladin, supreme leader of the Order of the Silver Hand.", aff = "Silver Hand", race = "Human", title = "First human paladin, supreme leader of the Order of the Silver Hand. — Silver Hand (Human)" }
    c.figureText["turalyon"] = { name = "Turalyon", role = "Paladin of the Silver Hand, leader of the Alliance expedition through the Dark Portal.", aff = "Silver Hand", race = "Human", title = "Paladin of the Silver Hand, leader of the Alliance expedition through the Dark Portal. — Silver Hand (Human)" }
    c.figureText["gavinrad"] = { name = "Gavinrad", role = "Leader of the Champions of Peace, knight of Stormwind.", aff = "Silver Hand", race = "Human", title = "Leader of the Champions of Peace, knight of Stormwind. — Silver Hand (Human)" }
    c.figureText["tirion_fordring_forever"] = { name = "Tirion Fordring", role = "Former paladin lord, excommunicated for defending the orc Eitrigg; lives in exile.", aff = "Independent", race = "Human", title = "Former paladin lord, excommunicated for defending the orc Eitrigg; lives in exile. — Independent (Human)" }
    c.figureText["saidan_dathrohan"] = { name = "Saidan Dathrohan", role = "Grand Crusader of the Scarlet Crusade; secretly replaced by the dreadlord Balnazzar.", aff = "Scarlet Crusade", race = "Human", title = "Grand Crusader of the Scarlet Crusade; secretly replaced by the dreadlord Balnazzar. — Scarlet Crusade (Human)" }
    c.figureText["grayson_shadowbreaker"] = { name = "Grayson Shadowbreaker", role = "Silver Hand mission specialist, paladin leader in Stormwind.", aff = "Silver Hand", race = "Human", title = "Silver Hand mission specialist, paladin leader in Stormwind. — Silver Hand (Human)" }
    c.figureText["maxwell_tyrosus"] = { name = "Maxwell Tyrosus", role = "Member of the Argent Dawn at Light's Hope Chapel.", aff = "Argent Dawn", race = "Human", title = "Member of the Argent Dawn at Light's Hope Chapel. — Argent Dawn (Human)" }
    c.figureText["arthas_menethil"] = { name = "Arthas Menethil", role = "Former promising member of the Silver Hand and crown prince of Lordaeron, ended up a death knight and betrayer of the order.", aff = "Scourge", race = "Human", title = "Former promising member of the Silver Hand and crown prince of Lordaeron, ended up a death knight and betrayer of the order. — Scourge (Human)" }
    c.figureText["bolvar_fordragon_forever"] = { name = "Bolvar Fordragon", role = "Regent of Stormwind and Commander of Stormwind's military.", aff = "Stormwind", race = "Human", title = "Regent of Stormwind and Commander of Stormwind's military. — Stormwind (Human)" }
    c.figureText["alexandros_mograine"] = { name = "Alexandros Mograine", role = "Former Highlord of the Silver Hand. Known as \"the Ashbringer\".", aff = "Silver Hand", race = "Human", title = "Former Highlord of the Silver Hand. Known as \"the Ashbringer\". — Silver Hand (Human)" }
    c.variants = "Crusader · Freethinker · Justicar · Templar · Vindicator"
end

c = IMAGOdb.classes["hunter"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Hunter"
    c.quote = { text = "The beasts around me are nothing compared to the beast within.", author = "Rexxar" }
    c.overview = [[From an early age the call of the wild draws some adventurers from the comfort of their homes into the unforgiving primal world outside. Those who endure become hunters. As masters of their environment, hunters are able to slip like ghosts through the trees and lay traps in the paths of their enemies. These expert marksmen drop foes dead in their tracks with flawless shots from a bow, crossbow, or rifle, and with the ability to wield two weapons simultaneously they can unleash a flurry of blows on anyone unfortunate enough to stumble into close combat with them.

The art of survival is central to the isolated life of a hunter. Hunters track beasts with ease and enhance their own abilities by attuning themselves to the feral aspects of various creatures. They are known for the lifelong bonds they form with animals of the wild, training great hawks, cats, bears, and many other beasts to fight alongside them.

Hunters know the uncharted places of the world. Gifted with a deep empathy for all life, they have an uncanny knack for befriending wild animals and taming them as pets, and they can use their finely honed senses to become master trackers. Wherever hunters go, they fight back the ravages of sickness, exploitation, and industrialization.]]
    c.history = [[Hunters are relentless in their pursuit of prey: beasts more cunning than wit, dangerous monsters, or monstrous people, the deadliest quarry of all. Beyond their skills as survivalists they are students of what they hunt, observing abilities and tactics and using that knowledge to make themselves more dangerous and unpredictable foes. As they set out across Azeroth to explore unknown lands and hunt all manner of dangerous and exotic quarry, hunters often find themselves alone in hostile territory, surviving only by their wits.]]
    c.raceEntries = {
        { race = "dwarf", text = "Heir to the riflemen of Ironforge; long hunting tradition in the snows of Dun Morogh." },
        { race = "night_elf", text = "The huntresses and archers of the Kaldorei; many serve among the Sentinels." },
        { race = "orc", text = "Hunters of the clan tradition, companions of wolves and boars." },
        { race = "tauren", text = "Keepers of the Great Hunt of the plains; the hunt is a sacred bond with the land." },
        { race = "troll", text = "Headhunters and trackers of the Darkspear tribe." },
    }
    c.groups["farstriders"] = { name = "The Farstriders", lore = "Hunters and huntresses of Quel'Thalas, led by the Ranger-General. They patrol the kingdom's borders and know the forests like the back of their hands." }
    c.groups["riflemen"] = { name = "Riflemen", lore = "Sharp-shooters of Khaz Modan who prefer blunderbusses to bows. They are skilled mountaineers and are the first to detect danger to their kingdom." }
    c.groups["dark_rangers"] = { name = "Dark Rangers", lore = "Deadly undead hunters who serve Lady Sylvanas Windrunner as one of her deadliest fighters. They sow hate and dissent among enemy ranks, forsaking this cruel undead fate they've been dealt." }
    c.groups["frostwolf_clan"] = { name = "The Frostwolf Clan", lore = "An orcish clan from Draenor with traditions of hunting gronn, surviving the treacherous icy climate of northern Draenor, and befriending direwolves. They have kept most of their habits on Azeroth as well." }
    c.groups["nesingwary_safari"] = { name = "Nesingwary Safari", lore = "Big game hunters and adventurers of exceptional skill who follow the Alliance hero and author, Hemet Nesingwary himself on his sensationalist exploits." }
    c.groups["dragon_hunters"] = { name = "Dragon Hunters", lore = "Highly specialized, predominantly dwarven hunters who are experts in felling mighty dragons. Even Kalecgos fell prey to one such group once." }
    c.figureText["sylvanas_windrunner_forever"] = { name = "Sylvanas Windrunner", role = "Banshee Queen of the Forsaken, former Ranger-General of Silvermoon.", aff = "Forsaken, Horde", race = "Undead high elf", title = "Banshee Queen of the Forsaken, former Ranger-General of Silvermoon. — Forsaken, Horde (Undead high elf)" }
    c.figureText["nathanos_blightcaller"] = { name = "Nathanos Blightcaller", role = "Champion of the Banshee Queen, Ranger Lord of the Forsaken.", aff = "Forsaken", race = "Undead human", title = "Champion of the Banshee Queen, Ranger Lord of the Forsaken. — Forsaken (Undead human)" }
    c.figureText["rexxar"] = { name = "Rexxar", role = "Champion of the Horde, last of the Mok'Nathal.", aff = "Horde", race = "Mok'Nathal", title = "Champion of the Horde, last of the Mok'Nathal. — Horde (Mok'Nathal)" }
    c.figureText["alleria_windrunner"] = { name = "Alleria Windrunner", role = "Former ranger captain of Quel'Thalas, leader of the Alliance Expedition; missing since.", aff = "Alliance of Lordaeron", race = "High elf", title = "Former ranger captain of Quel'Thalas, leader of the Alliance Expedition; missing since. — Alliance of Lordaeron (High elf)" }
    c.figureText["shandris_feathermoon"] = { name = "Shandris Feathermoon", role = "General of the Sentinel Army.", aff = "the Sentinels", race = "Night elf", title = "General of the Sentinel Army. — the Sentinels (Night elf)" }
    c.figureText["hemet_nesingwary"] = { name = "Hemet Nesingwary", role = "The most renowned big-game hunter on Azeroth.", aff = "Independent", race = "Dwarf", title = "The most renowned big-game hunter on Azeroth. — Independent (Dwarf)" }
    c.figureText["halduron_brightwing"] = { name = "Halduron Brightwing", role = "Ranger-General of Silvermoon.", aff = "Farstriders", race = "High elf", title = "Ranger-General of Silvermoon. — Farstriders (High elf)" }
    c.figureText["vereesa_windrunner"] = { name = "Vereesa Windrunner", role = "Youngest of the Windrunner sisters.", aff = "Quel'Thalas", race = "High elf", title = "Youngest of the Windrunner sisters. — Quel'Thalas (High elf)" }
    c.figureText["huln_highmountain"] = { name = "Huln Highmountain", role = "Leader of the tauren in the War of the Ancients, wielder of Talonclaw.", aff = "Highmountain tribe", race = "Tauren", title = "Leader of the tauren in the War of the Ancients, wielder of Talonclaw. — Highmountain tribe (Tauren)" }
    c.variants = "Archer · Beastmaster · Dark ranger · Elven ranger · Headhunter · Marksman · Ranger · Rifleman · Tracker · Trapper"
end

c = IMAGOdb.classes["rogue"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Rogue"
    c.quote = { text = "You're gonna find a number of outfits that covet our skills. Adventurers, SI:7... heck, even the disorganized rabble wouldn't mind a spy or two inside Stormwind. But you remember this: You're your own man. Don't let nobody bully you into doing something you don't wanna do! Besides, we hold all the cards... at least, we do before the game's done.", author = "Jorik Kerridan" }
    c.overview = [[Rogues fend for themselves, looking for fights in which they dictate the terms. They are the shadows in the night that remain unseen until the right moment comes to strike, then they dispatch an opponent with quick blade work or a deadly toxin snuck into the bloodstream. Rogues are opportunistic thieves, bandits, and assassins, but there is an unparalleled art to what they do.

For rogues, the only code is the contract, and their honor is purchased in gold. Free from the constraints of a conscience, these fighters rely on brutal and efficient tactics. Lethal assassins and masters of stealth, they approach their marks from behind, pierce a vital organ, and vanish into the shadows before the victim hits the ground. Rogues can dip their weapons in paralyzing toxins that render foes unable to defend themselves, and they wear leather armor so they can move unencumbered, ensuring that they land the first strike.

Rogues are most successful when their deeds never come to light. Fond of poisons and silent projectile weapons, they rely on a blend of stealth and minor mysticism. Usually in the employ of rich nobles or local governments, the rogue redistributes wealth or eliminates designated targets, for a rogue's allegiance lasts only as long as the latest contract. Some wield no magic at all; others use magic items, and a few draw on the Void to attain true invisibility even in broad daylight.]]
    c.history = [[The rogue has no chronicle of its own; its history is written in the ledgers of others. In Stormwind, two outfits have long divided the shadows: the Stormwind Assassin's Guild and the crown's own intelligence service, SI:7. The dwarves of Ironforge keep their secrets in the Forlorn Cavern, where the Hidden Circle sharpens its knives. In the hills of Alterac, Lord Jorach Ravenholdt presides over Ravenholdt Manor and its Assassin's League, an order that sells discretion to the highest bidder.

The most infamous name of the age is the Defias Brotherhood: born of the unpaid Stonemasons Guild that rebuilt Stormwind after the Second War, turned to banditry and blood under Edwin VanCleef when the nobles refused them their wages. In Orgrimmar, the remnants of the Shattered Hand clan serve the Horde with quieter blades, and among the Forsaken the Deathstalkers watch the roads of the dead.]]
    c.raceEntries = {
        { race = "human", text = "The assassin's guilds and SI:7 of Stormwind." },
        { race = "dwarf", text = "The Hidden Circle of the Forlorn Cavern." },
        { race = "gnome", text = "Covert agents of Gnomeregan." },
        { race = "night_elf", text = "Shadowy scouts among the Kaldorei, few in number." },
        { race = "orc", text = "Remnants of the Shattered Hand clan, the Horde's quiet blades." },
        { race = "troll", text = "Stalkers and headhunters of the Darkspear." },
        { race = "undead", text = "Deathstalkers and shadowstalkers of the Forsaken." },
    }
    c.groups["si_7"] = { name = "SI:7", lore = "Stormwind's eyes and ears, led by Mathias Shaw. They are the kingdom's spies and assassins and will do the dirty work that paladins or guards deem themselves too noble for." }
    c.groups["defias_brotherhood"] = { name = "Defias Brotherhood", lore = "Formerly mere artisans of the Stonemason's Guild, these scorned workers have become thieves and cutthroats of the most ruthless kind." }
    c.groups["ravenholdt"] = { name = "Ravenholdt", lore = "A powerful organization of thieves and assassins led by Jorach Ravenholdt. They are in conflict with the Syndicate, have been known to aid the Alliance, but mostly act independently. They are also known as the Assassin's League." }
    c.groups["hidden_circle"] = { name = "Hidden Circle", lore = "A group of thieves working in secret in Ironforge. While they have their fellow dwarves' best interests in mind, they are not particularly fond of the wealthy royalty." }
    c.groups["shattered_hand_clan"] = { name = "Shattered Hand Clan", lore = "A purely orcish clan of former slaves who practiced self-mutilation on Draenor, the Shattered Hand have become a force of merciless assassins for the Horde on Azeroth." }
    c.groups["deathstalkers"] = { name = "Deathstalkers", lore = "Originally the elite guard of Varimathras, these Forsaken rogues have grown vastly in numbers and are employed wherever deemed necessary." }
    c.groups["wastewanderers"] = { name = "The Wastewanderers", lore = "Human bandits and nomads who are the bane of any traveler in Uldum and Tanaris." }
    c.groups["blackwater_cartel"] = { name = "Blackwater Cartel", lore = "Under Trade Prince Baron Revilgaz, this unusual goblin cartel operates from Booty Bay. They are a motley mix of pirates, bankers and inventors." }
    c.groups["bloodsail_buccaneers"] = { name = "Bloodsail Buccaneers", lore = "The most notorious and bloodthirsty pirate band on Azeroth. Few merchants spotting their red sails live to tell the tale." }
    c.groups["southsea_freebooters"] = { name = "Southsea Freebooters", lore = "A group of pirates causing trouble at the coasts of Kalimdor." }
    c.groups["shera_alikh"] = { name = "Shera Ali'kh", lore = "An ancient order of assassins serving the Zandalari Empire." }
    c.figureText["edwin_vancleef"] = { name = "Edwin VanCleef", role = "Kingpin of the Defias Brotherhood, former leader of the Stonemasons Guild.", aff = "Defias Brotherhood", race = "Human", title = "Kingpin of the Defias Brotherhood, former leader of the Stonemasons Guild. — Defias Brotherhood (Human)" }
    c.figureText["mathias_shaw"] = { name = "Mathias Shaw", role = "Spymaster of SI:7.", aff = "SI:7", race = "Human", title = "Spymaster of SI:7. — SI:7 (Human)" }
    c.figureText["jorach_ravenholdt"] = { name = "Jorach Ravenholdt", role = "Lord of the Assassin's League.", aff = "Ravenholdt", race = "Human", title = "Lord of the Assassin's League. — Ravenholdt (Human)" }
    c.figureText["hulfdan_blackbeard"] = { name = "Hulfdan Blackbeard", role = "Leader of the Hidden Circle in Ironforge.", aff = "Hidden Circle", race = "Dwarf", title = "Leader of the Hidden Circle in Ironforge. — Hidden Circle (Dwarf)" }
    c.figureText["garona_halforcen"] = { name = "Garona Halforcen", role = "Gul'dan's former personal assassin, slayer of King Llane; in hiding.", aff = "Independent", race = "Half-orc", title = "Gul'dan's former personal assassin, slayer of King Llane; in hiding. — Independent (Half-orc)" }
    c.figureText["renzik_the_shiv"] = { name = "Renzik \"The Shiv\"", role = "Second-in-Command of SI:7, only goblin loyal to Stormwind.", aff = "SI:7", race = "Goblin", title = "Second-in-Command of SI:7, only goblin loyal to Stormwind. — SI:7 (Goblin)" }
    c.figureText["marin_noggenfogger"] = { name = "Marin Noggenfogger", role = "Up-and-coming inventor and businessman in Gadgetzan.", aff = "Gadgetzan", race = "Goblin", title = "Up-and-coming inventor and businessman in Gadgetzan. — Gadgetzan (Goblin)" }
    c.variants = "Assassin · Bandit · Brigand · Duelist · Infiltrator · Pirate · Spy · Spymaster · Thief"
end

c = IMAGOdb.classes["priest"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Priest"
    c.quote = { text = "It is faith in ourselves that separates us from others, and with our powers, we will cause great change in all of Azeroth. The weak will come to lean on you. The lepers will call you Lord. And the ignorant will look to you for guidance.", author = "Dark Cleric Duesten" }
    c.overview = [[Priests are devoted to the spiritual, and express their unwavering faith by serving the people. For millennia they have left behind the confines of their temples and the comfort of their shrines so they can support their allies in war-torn lands. In the midst of terrible conflict, no hero questions the value of the priestly orders. These masters of the healing arts keep their companions fighting far beyond their normal capacities with an array of restorative powers and blessings, yet the divine forces at the priest's command can also be turned against foes, smiting them with holy fury.

As light cannot exist without darkness, and darkness without light, some priests tap into shadow to better understand their own abilities, as well as the abilities of those who threaten them.

Priests guide the spiritual destiny of their people. Through their unique insight into the mind, they are able to shape an individual's beliefs, whether to inspire or terrify, soothe or dominate, heal or harm. Just as the heart can hold both darkness and light, priests wield powers of creation and devastation by channeling the potent forces underlying faith.]]
    c.history = [[The worship of the Light took different forms among the peoples of Azeroth. The night elves founded the Sisterhood of Elune long before the War of the Ancients: an order of priestesses devoted to the moon goddess Elune, whose power and grace they channel to heal a war-weary land and to guard their realms.

The humans were the first to discover the Holy Light on Azeroth. Around 1,200 years before the Dark Portal, the Church of the Holy Light was founded in Lordaeron, its precepts codified from the Light-based traditions of a religious movement under the Empire of Arathor, formed by the priestess Mereldar and her companions after they received mysterious visions from holy beings. For centuries the Church spread its faith through the Seven Kingdoms, building temples and shrines throughout the human lands. Its doctrine is more philosophical than theistic, yet its believers hold that devotion connects them to a greater, mysterious force in the universe.

The Clerics of Northshire served the kingdom of Stormwind in the First War as battlefield healers and were largely destroyed, unprepared for the hazards of combat. The Second War saw fragile priests replaced on the field by armored paladins, the Knights of the Silver Hand, established by the Church's leader Archbishop Alonsus Faol and his apprentice Uther.

In the Third War, the altruistic priests of Quel'Thalas refused to abandon their duties and remained in Lordaeron despite the edicts of Silvermoon, healing the wounded of the fighting elite. Other clergy broke entirely: the Fallen Priests, once counted among the most devout of Lordaeron, lost their sense of the Holy Light after years of war and now spread only bitterness and negativity.

After the Third War, many Forsaken priests turned away from the Light and formed the Cult of the Forgotten Shadow on the teachings of the late Bishop Natalie Seline. Though they wield dark energies, they believe that balance between Light and darkness must hold, and that a member of the cult must know the Light as well.]]
    c.raceEntries = {
        { race = "human", text = "Faithful of the Church of the Holy Light, founded in Lordaeron on Mereldar's visions." },
        { race = "dwarf", text = "Clergy of Ironforge; the kingdom's priests and paladins serve the Church of the Holy Light." },
        { race = "night_elf", text = "Priestesses of the Sisterhood of Elune, channeling the Mother Moon." },
        { race = "troll", text = "Spiritual servants of the Loa; the Darkspear circle preserves their priestly rites." },
        { race = "undead", text = "Many Forsaken priests turned from the Light to the Cult of the Forgotten Shadow." },
    }
    c.groups["church_of_the_holy_light"] = { name = "Church of the Holy Light", lore = "The predominantly human organization of the Eastern Kingdoms' primary faith. Formed more than 1200 years ago by the priestess Mereldar in Lordaeron." }
    c.groups["brotherhood_of_northshire"] = { name = "Brotherhood of Northshire", lore = "A pious branch of the Church of the Holy Light who served Stormwind as priests and clerics before the First War. Their heroic sacrifice against the Horde inspired Alonsus Faol to train the first paladins and he drew from their ranks many of the first ones." }
    c.groups["sisterhood_of_elune"] = { name = "Sisterhood of Elune", lore = "An ancient night elven order of warrior priestesses led by Tyrande Whisperwind. They worship Elune and are granted her powers to heal their allies and strike at their enemies." }
    c.groups["cult_of_the_forgotten_shadow"] = { name = "Cult of the Forgotten Shadow", lore = "Formed by Natalie Seline, this order is seen as heretical by many for its study and, in some cases, worship of the Void. The cult has many followers in the remains of Lordaeron and accepts all races." }
    c.groups["thalassian_priesthood"] = { name = "Thalassian Priesthood", lore = "Ill-suited for combat, these high elven healers served Silvermoon as combat medics. Most died during Silvermoon's fall, but the priesthood remains active among the blood elves." }
    c.groups["darkspear_circle"] = { name = "Darkspear Circle", lore = "Troll priests who practice the old ways of worship of the loa and who are granted powers of Light and voodoo. Witch-doctors even mastered the art of resurrection." }
    c.figureText["tyrande_whisperwind_forever"] = { name = "Tyrande Whisperwind", role = "High Priestess of Elune, leader of the Sisterhood and the Sentinels.", aff = "Sisterhood of Elune", race = "Night elf", title = "High Priestess of Elune, leader of the Sisterhood and the Sentinels. — Sisterhood of Elune (Night elf)" }
    c.figureText["archbishop_benedictus"] = { name = "Archbishop Benedictus", role = "Head of the Church of the Holy Light in Stormwind.", aff = "Church of the Holy Light", race = "Human", title = "Head of the Church of the Holy Light in Stormwind. — Church of the Holy Light (Human)" }
    c.figureText["alonsus_faol"] = { name = "Alonsus Faol", role = "Former head of the Church, founder of the Knights of the Silver Hand.", aff = "Church of the Holy Light", race = "Human", title = "Former head of the Church, founder of the Knights of the Silver Hand. — Church of the Holy Light (Human)" }
    c.figureText["sally_whitemane"] = { name = "Sally Whitemane", role = "High Inquisitor of the Scarlet Crusade at the Scarlet Monastery.", aff = "Scarlet Crusade", race = "Human", title = "High Inquisitor of the Scarlet Crusade at the Scarlet Monastery. — Scarlet Crusade (Human)" }
    c.figureText["moira_thaurissan"] = { name = "Moira Thaurissan", role = "Princess of Ironforge, held by Emperor Thaurissan in Shadowforge.", aff = "Dark Iron clan", race = "Dwarf", title = "Princess of Ironforge, held by Emperor Thaurissan in Shadowforge. — Dark Iron clan (Dwarf)" }
    c.figureText["natalie_seline"] = { name = "Natalie Seline", role = "Bishop of Lordaeron, whose writings founded the Cult of the Forgotten Shadow.", aff = "Cult of the Forgotten Shadow", race = "Human", title = "Bishop of Lordaeron, whose writings founded the Cult of the Forgotten Shadow. — Cult of the Forgotten Shadow (Human)" }
    c.variants = "Acolyte · Anchorite · Chaplain · Cleric · Confessor · Death priest · High priest · Priestess of the Moon · Prophet · Shadow priest · Templar · Voodoo priest"
end

c = IMAGOdb.classes["shaman"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Shaman"
    c.quote = { text = "Know this: a shaman must never demand power; to do so would arouse the anger of the elements, and a shaman without the elements' protection is nothing. Those that follow the path of the shaman must never forget this most vital tenet. However, a shaman that works in a respectful union with the elements wields a power rivaled by few.", author = "Teo Hammerstorm" }
    c.overview = [[For millennia, since the primitive tribal cultures of Azeroth and Draenor, the natural elements of the physical universe have been celebrated, feared, and even worshiped. Mystics sought communion with the earth, air, fire, and water, and learned to tap into their raw power. In time, these spiritual guides came to understand that nature's elemental forces are not wholly benevolent, but have been locked in an unending conflict of chaos and primal fury that once consumed the physical realm. So began the calling of the shaman: to bring balance to these volatile energies, leveraging their intensity to mend wounds, or to inflict them.

Shaman are spiritual guides and practitioners, not of the divine, but of the very elements. Unlike other mystics, they commune with forces that are not strictly benevolent: the elements are chaotic, and left to their own devices they rage against one another in unending primal fury. It is the call of the shaman to bring balance to this chaos. Acting as moderators among earth, fire, water, and air, shaman summon totems that focus the elements to support their allies or punish those who threaten them. They can also call upon elemental forces directly, unleashing torrents of lava and bolts of lightning against their foes.

Shaman commune directly with the elements, and their combination of wisdom and resilience makes them ideal tribal advisors and leaders. In battle the shaman uses totems and spells to manipulate the elements and provoke other fighters into untold heights of rage and might. Shaman exemplify the primal bond between the savage races and their environment.]]
    c.history = [[Shamanism is the oldest faith of the mortal races. On Draenor the orcs were shamanistic; on Azeroth the tauren walked the same path, while the trolls had a long history of shamanistic worship of the loa. Even humanity's primitive belief systems once incorporated crude forms of shamanism before the Holy Light and the arcane took their place. Two hundred and thirty years before the opening of the Dark Portal, the tauren founded the Earthen Ring to lead their people with wisdom and maintain harmony between the elemental spirits.

On Draenor, shamanism died in betrayal. Kil'jaeden, eredar lord of the Burning Legion, distorted the shaman's bond with their ancestors in the sacred mountain Oshu'gun, taking the form of the ancestors himself to convince the orcs that the draenei were the enemy. The massacres that followed offended the spirits, who denied the shaman their powers. Cut off, the shaman were offered the more efficient powers of the Legion instead, and most accepted, becoming warlocks. On Blackhand's orders the orcs were forbidden ever to return to the mountain, so that none would learn of the deception. Shamanism was, in effect, outlawed.

It stayed all but extinct among the orcs until Thrall, son of the slain Durotan and future chieftain of the Frostwolf clan, took up the mantle of Warchief of the New Horde. He ushered in a new generation of shamanism, broke the crippling lethargy of the captive orcs and outlawed the Legion's dark magic in turn. In the days of the internment camps, "shaman" had been a derogatory word for a teller of impossible tales. Now the new orcish nation of Durotar itself is led by a shaman of great power.]]
    c.raceEntries = {
        { race = "orc", text = "Their ancestral path, lost through Kil'jaeden's deception and restored by Thrall." },
        { race = "tauren", text = "Founders of the Earthen Ring; keepers of elemental harmony since ancient days." },
        { race = "troll", text = "A long tradition of shamanistic worship of the loa and the spirits." },
    }
    c.groups["earthen_ring"] = { name = "Earthen Ring", lore = "An old faction of Azerothian shaman dedicated to preserving the fragile balance between the elements. They accept and train all races." }
    c.groups["shadowmoon_clan"] = { name = "The Shadowmoon Clan", lore = "One of the greatest orcish clans on Draenor, the shaman of the Shadowmoon were peaceful and wise. Under Elder Shaman Ner'zhul, the clan fell to corruption by the Burning Legion and forsook the elements it once revered." }
    c.groups["alaketh"] = { name = "The Al'Aketh", lore = "A cult of fanatics led by Lorthuna who seek the end of the shen'dorei by the Windlord Al'Akir." }
    c.groups["windshapers"] = { name = "The Windshapers", lore = "The shen'dorei who have joined the Horde and held fast to their shamanistic beliefs. They honor the elements and intend to gather more knowledge about the Elemental Plane." }
    c.figureText["thrall_forever"] = { name = "Thrall", role = "Warchief of the New Horde, restorer of orcish shamanism.", aff = "Frostwolf clan, Horde", race = "Orc", title = "Warchief of the New Horde, restorer of orcish shamanism. — Frostwolf clan, Horde (Orc)" }
    c.figureText["drekthar"] = { name = "Drek'Thar", role = "Chieftain and elder shaman of the Frostwolf clan.", aff = "Frostwolf clan, Earthen Ring", race = "Orc", title = "Chieftain and elder shaman of the Frostwolf clan. — Frostwolf clan, Earthen Ring (Orc)" }
    c.figureText["magatha_grimtotem"] = { name = "Magatha Grimtotem", role = "Elder Crone of the Grimtotem tribe.", aff = "Grimtotem tribe", race = "Tauren", title = "Elder Crone of the Grimtotem tribe. — Grimtotem tribe (Tauren)" }
    c.figureText["muln_earthfury"] = { name = "Muln Earthfury", role = "Leader of the Earthen Ring.", aff = "Earthen Ring", race = "Tauren", title = "Leader of the Earthen Ring. — Earthen Ring (Tauren)" }
    c.figureText["rehgar_earthfury"] = { name = "Rehgar Earthfury", role = "Advisor to Thrall, former gladiator master.", aff = "Horde", race = "Orc", title = "Advisor to Thrall, former gladiator master. — Horde (Orc)" }
    c.figureText["nerzhul"] = { name = "Ner'zhul", role = "Former elder shaman of the Shadowmoon clan; became the Lich King.", aff = "Scourge", race = "Orc", title = "Former elder shaman of the Shadowmoon clan; became the Lich King. — Scourge (Orc)" }
    c.figureText["zuluhed_the_whacked"] = { name = "Zuluhed the Whacked", role = "Former chieftain of the Dragonmaw clan, at Dragonmaw Fortress in Shadowmoon Valley.", aff = "Dragonmaw clan", race = "Orc", title = "Former chieftain of the Dragonmaw clan, at Dragonmaw Fortress in Shadowmoon Valley. — Dragonmaw clan (Orc)" }
    c.figureText["greatmother_geyah"] = { name = "Greatmother Geyah", role = "Spiritual leader of the Mag'har.", aff = "Mag'har", race = "Orc", title = "Spiritual leader of the Mag'har. — Mag'har (Orc)" }
    c.figureText["ayessa_dawnsinger"] = { name = "Ayessa Dawnsinger", role = "Leader of the Windshapers of the Skyborne.", aff = "Windshapers, Horde", race = "Skyborne", title = "Leader of the Windshapers of the Skyborne. — Windshapers, Horde (Skyborne)" }
    c.variants = "Augur · Earthmender · Elementalist · Farseer · Geomancer · Mystic · Seer · Spiritwalker · Summoner"
end

c = IMAGOdb.classes["mage"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Mage"
    c.quote = { text = "Bein' a mage means knowin' power can flow in more than one direction.", author = "Ganvar Singebeard" }
    c.overview = [[Students gifted with a keen intellect and unwavering discipline may walk the path of the mage. The arcane magic available to magi is both great and dangerous, and thus is revealed only to the most devoted practitioners. To avoid interference with their spellcasting, magi wear only cloth armor, but arcane shields and enchantments give them additional protection.

To keep enemies at bay, magi can summon bursts of fire to incinerate distant targets and cause entire areas to erupt, setting groups of foes ablaze. Masters of ice can command blizzards that tear into flesh and limit movement, and should enemies manage to survive this assault, the mage can shrink them into harmless sheep in the blink of an eye. Powerful magi can even generate enhancements and portals, assisting allies by sharpening their minds and transporting them instantly across the world.

Magi are wizards of immense knowledge and skill. Their obvious physical frailty is deceptive, for they can call upon the cosmic energies of the Twisting Nether. Rarely do magi engage in melee combat; instead, they prefer to attack from a distance, hurling powerful bolts of frost and flame at their unsuspecting enemies.]]
    c.history = [[Arcane magic is far older than humanity. Around 15,000 years ago the Kaldorei Empire was defined by direct manipulation of magic drawn from the Well of Eternity. The mages of Mennar Academy, among the first to study the arcane, warned of arcane addiction and urged caution, which put them in conflict with Queen Azshara and the Highborne. Their empire's misuse of the Well eventually drew the attention of Sargeras and led to the War of the Ancients. After the Great Sundering, the night elf wizard Meitre left behind a wealth of scrolls that became the basis of modern arcane magic; nine thousand years later, high elf and human magi were still learning from them.

During the Troll Wars, around 2,800 years before the Dark Portal, the high elves taught arcane magic to one hundred humans of the Empire of Arathor, the first human magi in history. As their numbers and power grew, the magicians became conceited and isolated, and the city-state of Dalaran became a haven for Arathor's magi, whom the empire's citizens viewed with growing suspicion. For centuries the Church of the Holy Light considered the Kirin Tor heretics for their methods, tolerating them only because they practiced no dark magic.

Stormwind kept its own secretive order, the Conjurers of Azeroth, who served as advisors of the court until they fell in the First War. In the Second War a new order of mages arose, determined to command more aggressive and destructive magiks, resolute in their efforts to defend the people whether in their sanctum at the Violet Citadel or on the battlefields of Lordaeron. At year 25 the ruins of Dalaran lie sealed beneath a great violet dome while the Kirin Tor rebuild within.]]
    c.raceEntries = {
        { race = "human", text = "Heirs of the Hundred taught by the high elves; Dalaran and Stormwind's academies carry the tradition." },
        { race = "gnome", text = "Adopted the arcane arts in Dalaran; their inquisitive minds take readily to spellcraft." },
        { race = "troll", text = "The Darkspear learned arcane ways after joining the Horde, alongside their older spiritual traditions." },
        { race = "undead", text = "Once magi of Lordaeron and Dalaran; the Forsaken keep their arcane knowledge beyond death." },
    }
    c.groups["kirin_tor"] = { name = "The Kirin Tor", lore = "The magocracy of Dalaran and the foremost body of arcane learning on Azeroth. They consist mainly of human and high elven mages and while they serve as a neutral force, they lean heavily towards the Alliance." }
    c.groups["magisters"] = { name = "The Magisters", lore = "Silvermoon's mages led by Grand Magister Rommath, who hold strong political influence in the kingdom." }
    c.groups["violet_eye"] = { name = "The Violet Eye", lore = "Mages of the Kirin Tor who secretly keep an eye on Karazhan, even after Medivh's demise." }
    c.groups["academy_of_arcane_arts_and_sciences"] = { name = "Academy of Arcane Arts and Sciences", lore = "An institution in Stormwind City focused on the study of the arcane. Its campus houses a sizable library of magical tomes and scrolls." }
    c.groups["wizards_sanctum_society"] = { name = "Wizard's Sanctum Society", lore = "Stormwind's mages who investigate and neutralize any magical threats in the city and Elwynn Forest." }
    c.groups["magical_preservation_society"] = { name = "The Magical Preservation Society", lore = "A small order of scholars of the Alliance who carefully aim to preserve, protect and study the magic of Azeroth." }
    c.groups["eaaaes"] = { name = "E.A.A.A.E.S.", lore = "An organization of enthusiastic gnomish mages intending to combine Arcane magic, Alchemy, and Engineering into one art." }
    c.groups["council_of_tirisfal"] = { name = "Council of Tirisfal", lore = "Ancient secret order of mages sworn to protect Azeroth from the Burning Legion. Ironically found its end through demon corruption by their own leader – the Guardian Medivh." }
    c.groups["conjurers_of_stormwind"] = { name = "The Conjurers", lore = "Stormwind's former court order, destroyed alongside the kingdom during the First War." }
    c.groups["one_hundred"] = { name = "The One Hundred", lore = "The hundred humans of Arathor first taught arcane magic by the high elves during the Troll Wars." }
    c.groups["moon_guard"] = { name = "The Moon Guard", lore = "A group of elite Kaldorei sorcerers who originally served Queen Azshara before and during the War of the Ancients. Many switched sides during the war and while the organization is considerably less important now, they still remain active." }
    c.groups["violet_council"] = { name = "The Violet Council", lore = "Dalaran's elite line of defense during Arthas' assault on the city. They all died." }
    c.groups["high_order"] = { name = "The High Order", lore = "Skyborne mages who seek to reclaim their arcane birthright and reject the elements of Skywall. They have joined the Alliance." }
    c.figureText["antonidas"] = { name = "Antonidas", role = "Former leading archmage of the Kirin Tor and ruler of Dalaran.", aff = "Kirin Tor", race = "Human", title = "Former leading archmage of the Kirin Tor and ruler of Dalaran. — Kirin Tor (Human)" }
    c.figureText["jaina_proudmoore"] = { name = "Jaina Proudmoore", role = "Leader of Theramore, former apprentice of Antonidas.", aff = "Theramore", race = "Human", title = "Leader of Theramore, former apprentice of Antonidas. — Theramore (Human)" }
    c.figureText["mordent_evenshade"] = { name = "Mordent Evenshade", role = "Leader of the surviving Shen'dralar at Evenshade's Overlook.", aff = "Shen'dralar", race = "Night elf", title = "Leader of the surviving Shen'dralar at Evenshade's Overlook. — Shen'dralar (Night elf)" }
    c.figureText["aegwynn"] = { name = "Aegwynn", role = "Penultimate Guardian of Tirisfal, mother of Medivh; lives hidden at Theramore.", aff = "Theramore", race = "Human", title = "Penultimate Guardian of Tirisfal, mother of Medivh; lives hidden at Theramore. — Theramore (Human)" }
    c.figureText["khadgar"] = { name = "Khadgar", role = "Archmage, former apprentice of Medivh, missing since the expedition to Draenor.", aff = "Sons of Lothar", race = "Human", title = "Archmage, former apprentice of Medivh, missing since the expedition to Draenor. — Sons of Lothar (Human)" }
    c.figureText["medivh"] = { name = "Medivh", role = "The Last Guardian of Tirisfal and master of Karazhan.", aff = "Independent", race = "Human", title = "The Last Guardian of Tirisfal and master of Karazhan. — Independent (Human)" }
    c.figureText["rhonin"] = { name = "Rhonin", role = "Leader of the Kirin Tor.", aff = "Kirin Tor", race = "Human", title = "Leader of the Kirin Tor. — Kirin Tor (Human)" }
    c.figureText["modera"] = { name = "Modera", role = "Archmage and member of the Council of Six.", aff = "Kirin Tor", race = "Human", title = "Archmage and member of the Council of Six. — Kirin Tor (Human)" }
    c.figureText["kaelthas_sunstrider"] = { name = "Kael'thas Sunstrider", role = "Prince of fallen Quel'Thalas; beyond the Dark Portal.", aff = "Survivors of Quel'Thalas", race = "High elf", title = "Prince of fallen Quel'Thalas; beyond the Dark Portal. — Survivors of Quel'Thalas (High elf)" }
    c.figureText["chogall"] = { name = "Cho'gall", role = "Leader of the Twilight's Hammer cult; in hiding.", aff = "Twilight's Hammer", race = "Ogre mage", title = "Leader of the Twilight's Hammer cult; in hiding. — Twilight's Hammer (Ogre mage)" }
    c.figureText["meryl_felstorm"] = { name = "Meryl Felstorm", role = "Undead mage, founding member of the Council of Tirisfal.", aff = "Council of Tirisfal", race = "Undead", title = "Undead mage, founding member of the Council of Tirisfal. — Council of Tirisfal (Undead)" }
    c.figureText["prince_tortheldrin"] = { name = "Prince Tortheldrin", role = "Tyrannical leader of the night elves of Eldre'Thalas.", aff = "Shen'dralar", race = "Night elf", title = "Tyrannical leader of the night elves of Eldre'Thalas. — Shen'dralar (Night elf)" }
    c.figureText["ansirem_runeweaver"] = { name = "Ansirem Runeweaver", role = "Archmage and member of the Council of Six.", aff = "Kirin Tor", race = "Human", title = "Archmage and member of the Council of Six. — Kirin Tor (Human)" }
    c.figureText["elaadrin_evengale"] = { name = "Elaadrin Evengale", role = "Leader of the High Order of the Skyborne.", aff = "High Order, Alliance", race = "Skyborne", title = "Leader of the High Order of the Skyborne. — High Order, Alliance (Skyborne)" }
    c.variants = "Archmage · Arcanist · Battle mage · Conjurer · Enchanter · Hedge wizard · Sorcerer · Spellbreaker · Warmage · Wizard"
end

c = IMAGOdb.classes["warlock"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Warlock"
    c.quote = { text = "Behold those who have power, and who are not afraid to wield it. Behold... the warlocks!", author = "Gul'dan" }
    c.overview = [[Warlocks are the most volatile and insatiable of spellcasters. Though they often pledge themselves to the service of noble causes and are not innately evil, their desire to understand darker magics and exercise unwavering command over demonic forces breeds mistrust among even their closest allies. Warlocks peer into the Void without hesitation, leveraging the chaos they glimpse within to devastating ends in battle; their greatest abilities are fueled by the souls they have harvested from their victims.

In the face of demonic power, most heroes see death. Warlocks see only opportunity. Dominance is their aim, and they have found a path to it in the dark arts. These voracious spellcasters summon demonic minions to fight beside them: at first only the service of imps, but as a warlock's knowledge grows, seductive succubi, loyal voidwalkers, and horrific felhunters join the dark sorcerer's ranks. Warlocks can ignite distant enemies in searing flame, send them fleeing in terror and pain, or afflict them with corrupting diseases and curses that steal the victim's vitality. These practitioners of the profane are feared across Azeroth, and many who have felt their wrath now prefer to fight alongside a warlock than against one.

As physically weak spellcasters bereft of heavy armor, cunning warlocks allow their minions to take the brunt of enemy attacks to save their own skin. To replenish the dreadful energy their spells expend, they drain vitality from their victims, and they summon and control terrifying demonic entities. Still, warlocks are feared above all else for their singular wickedness and cruelty.]]
    c.history = [[Warlock magic was born among the eredar of Argus, whose chaos magics burned out whole worlds. On Azeroth, demons survived mostly as rumor and folk legend: the Kirin Tor forbade demonology outright, and cases like the cult of Zmodlor at Jortas were secretly neutralized by the Kirin Tor and the Council of Tirisfal. Some of the mages charged with hunting demons turned to the dark arts themselves; Aegwynn fought against the greatest spellcasters of her age when they fell into demonic lore.

On Draenor, Kil'jaeden created a new generation of warlocks by instructing the orc shaman in fel and demonic magics. He first targeted Gul'dan, a weak, crippled orc whom the elements had refused, and the orc became the most powerful mortal warlock in history. Gul'dan faked apprenticeship to the elder shaman Ner'zhul, taught his brethren the new power that reeked of doom, and with Kil'jaeden's help founded the Shadow Council, a secretive sect that spread warlock magic throughout Draenor and manipulated the clans. As more orcs embraced the fel, the gentle fields of Draenor blackened and withered; the demon energies were slowly killing the world. Some warlocks were not permitted to join the Council and remained loyal to their clans, such as Drek'Thar and Nekros Skullcrusher.

In the First War the warlocks were the most powerful fighting force of the Horde, channeling fire, brimstone and shadow through their bodies and summoning demons. In the Second War, Orgrim Doomhammer slaughtered most of the Shadow Council at Blackrock Spire; Gul'dan transferred some of their spirits into the first death knights, and survivors fled to his Stormreaver clan. In the Third War, warlocks survived only in the Old Horde's remnants.

After the Third War, the Alliance and the Horde began tolerating the warlocks and their practices: their expertise on demonic subjects was undeniable, though society still shunned them. Most practice in hidden enclaves.]]
    c.raceEntries = {
        { race = "human", text = "Tolerated in hidden covens like the one beneath the Slaughtered Lamb in Stormwind." },
        { race = "gnome", text = "Once trained under the masters of Gnomeregan; since the city's fall they dwell in Ironforge under Magni's watch." },
        { race = "orc", text = "Heirs of Gul'dan's corruption; tolerated in the Cleft of Shadow of Orgrimmar." },
        { race = "undead", text = "Practitioners who carried their dark knowledge beyond death." },
    }
    c.groups["shadow_council"] = { name = "The Shadow Council", lore = "Gul'dan's secretive sect that spread demonic corruption and turned the Horde's shaman into warlocks before the First War. It was broken up by Orgrim Doomhammer yet some of its members survived." }
    c.groups["slaughtered_lamb_coven"] = { name = "The Slaughtered Lamb Coven", lore = "Stormwind's hidden warlock coven based in the Slaughtered Lamb tavern's cellars. They are barely tolerated by the guards." }
    c.groups["stormreaver_clan"] = { name = "The Stormreaver Clan", lore = "A small orcish warlock clan founded and led by Gul'dan during the Second War. Most members died in the Tomb of Sargeras but remnants remain." }
    c.groups["burning_blade_clan"] = { name = "The Burning Blade Clan", lore = "An orcish clan from Draenor, now based in Durotar. While some members have become loyal to the New Horde, the clan has mostly remained in service to the Burning Legion and plans to take over Orgrimmar." }
    c.groups["searing_blade"] = { name = "The Searing Blade", lore = "A subgroup of the Burning Blade who resided in Ragefire Chasm and planned to usurp Warchief Thrall." }
    c.groups["argus_wake"] = { name = "Argus Wake", lore = "A mysterious scheming cabal of warlocks loyal to the Shadow Council and the Burning Legion. They helped the Syndicate in hopes of using Stromgarde as a base of operations." }
    c.groups["cult_of_the_dark_strand"] = { name = "Cult of the Dark Strand", lore = "A cult in the Shadow Council led by the ancient Highborne Athrikus Narassin who made contact with entities in the Twisting Nether." }
    c.groups["shadowsworn"] = { name = "The Shadowsworn", lore = "Uniting various sects of the Shadow Council as well as the Dreadmaul ogre tribe, these demon worshipers held control of one of the Altars of Storms in the Blasted Lands." }
    c.figureText["guldan"] = { name = "Gul'dan", role = "First orcish warlock, creator of the Shadow Council; died at the Tomb of Sargeras.", aff = "Stormreaver clan", race = "Orc", title = "First orcish warlock, creator of the Shadow Council; died at the Tomb of Sargeras. — Stormreaver clan (Orc)" }
    c.figureText["kiljaeden"] = { name = "Kil'jaeden", role = "The Deceiver, supreme commander of the Burning Legion.", aff = "Burning Legion", race = "Eredar", title = "The Deceiver, supreme commander of the Burning Legion. — Burning Legion (Eredar)" }
    c.figureText["archimonde"] = { name = "Archimonde", role = "The Defiler, eredar overlord of the Legion; destroyed at Hyjal.", aff = "Burning Legion", race = "Eredar", title = "The Defiler, eredar overlord of the Legion; destroyed at Hyjal. — Burning Legion (Eredar)" }
    c.figureText["teron_gorefiend"] = { name = "Teron Gorefiend", role = "The first death knight, former warlock of the Shadow Council.", aff = "Shadowmoon clan", race = "Orc", title = "The first death knight, former warlock of the Shadow Council. — Shadowmoon clan (Orc)" }
    c.figureText["nekros_skullcrusher"] = { name = "Nekros Skullcrusher", role = "Second-in-command of the Dragonmaw clan, last holder of the Demon Soul.", aff = "Dragonmaw clan", race = "Orc", title = "Second-in-command of the Dragonmaw clan, last holder of the Demon Soul. — Dragonmaw clan (Orc)" }
    c.figureText["neeru_fireblade"] = { name = "Neeru Fireblade", role = "Warlock of the Cleft of Shadow, secret leader of the Burning Blade; watched by Thrall.", aff = "Cleft of Shadow", race = "Orc", title = "Warlock of the Cleft of Shadow, secret leader of the Burning Blade; watched by Thrall. — Cleft of Shadow (Orc)" }
    c.variants = "Acolyte · Demoniac · Necrolyte · Shadowcaster · Shadowmage · Summoner · Hidden warlock · Uncorrupted warlock"
end

c = IMAGOdb.classes["druid"]
if c then
    c.figureText = c.figureText or {}
    c.groups = c.groups or {}
    c.name = "Druid"
    c.quote = { text = "The land and I are one.", author = "Malfurion Stormrage" }
    c.overview = [[Guardians of nature who seek to preserve balance and protect life, druids have unmatched versatility on the field of battle. This is in part because druidism is much more than a fighting discipline: it is a way of life steeped in traditions so ancient that even the origin of their kind is preserved largely in mythology passed on through millennia.

Druids harness nature's raw energy for an incredible breadth of offensive and defensive abilities, as well as to restore life to the wounded. Through communion with nature and the demigod Cenarius, Lord of the Forest, druids are supernaturally endowed with the gift of shapeshifting, allowing them to take the form of all manner of nature's creature and access powers as distinct as they are diverse. They are deeply in tune with the animal spirits of Azeroth: as master shapeshifters they can morph into a bear, cat, storm crow, or sea lion with ease, tearing enemies to shreds one minute and surveying the battlefield from the sky the next. These keepers of the natural order are among the most versatile heroes in Azeroth, and they must be prepared to adjust to new challenges on a moment's notice.

Druids live in a state of unparalleled union with nature. Tightly bound to the plant and animal kingdoms, they are natural shapeshifters, and so they know firsthand the abuse visited on their wild brethren. In consequence, despite their numbers, druids tend to be wary, reclusive, and difficult to spot; few outsiders have plumbed the depths of their secrets.]]
    c.history = [[Long before the night elves, between 12,000 and 11,900 years before the Dark Portal, the demigod Cenarius gave guidance to the nomadic yaungol in the grassy plains of central Kalimdor and taught them secrets of the wilds and of druidic magic. From this grew the ancient tauren tale that the Wild God had personally instructed their race as the first druids, a reinterpretation of their ancestors' past.

With the rise of the Kaldorei Empire, a few night elves learned from Cenarius. Some of those he touched chose to join the demigod in protecting his realm and became woodland guardians, forever altered. But none truly followed his path until Malfurion Stormrage. The young prodigy proved the first mortal with the aptitude and will to wield the forces inherent in all nature, the first true mortal druid on Azeroth, and the first to walk the Emerald Dream.

The War of the Satyr forced Malfurion to reflect on the state of druidism. Without regulation, individuals like Ralaar Fangfire and his Druids of the Scythe would inevitably go too far. Malfurion and his followers therefore created the Cenarion Circle, a harmonious order to guide and watch over the world's druids and their practices.

Until the end of the Third War, druids periodically visited the Emerald Dream to monitor the ebb and flow of life on Azeroth. Today such visits have become difficult due to Nordrassil's poor health. After the war, Hamuul Runetotem learned the druidic arts from Malfurion and became the first tauren druid in nearly twenty generations. Although Archdruid Fandral Staghelm opposed their entry, the keeper of the grove Remulos welcomed the tauren into the Cenarion Circle and taught them many closely guarded secrets.]]
    c.raceEntries = {
        { race = "night_elf", text = "The first druids of Azeroth were Kaldorei, taught by Cenarius himself; Malfurion Stormrage was the first mortal druid. Night elf druids also draw on Elune's moonlight." },
        { race = "tauren", text = "Descendants of the yaungol whom Cenarius taught in ancient times. After the Third War Hamuul Runetotem became the first tauren druid in nearly twenty generations; Remulos welcomed them into the Cenarion Circle." },
    }
    c.groups["cenarion_circle"] = { name = "Cenarion Circle", lore = "The primary druid organization on Azeroth harboring members of both Alliance and Horde. Founded by Malfurion Stormrage, they aim to guard the fragile balance of nature." }
    c.groups["emerald_circle"] = { name = "The Emerald Circle", lore = "A branch of the Cenarion Circle dedicated to combat the corruption of Felwood." }
    c.groups["druids_of_the_claw"] = { name = "Druids of the Claw", lore = "An ancient druidic order revering the bear god Ursoc as their patron. They predominantly fight in bear or cat form." }
    c.groups["druids_of_the_fang"] = { name = "Druids of the Fang", lore = "A group of druids under Naralex who aimed to cleanse the Wailing Caverns. Instead they became lost to corruption of the Emerald Nightmare." }
    c.groups["druids_of_the_scythe"] = { name = "Druids of the Scythe", lore = "Created during the War of the Satyr by a desperate druid named Ralaar Fangfire. They fought in worgen form but most lost their minds in animalistic rage harming friends and foes alike. Banished into the Dream by Malfurion Stormrage." }
    c.groups["druids_of_the_talon"] = { name = "Druids of the Talon", lore = "Revering Aviana, this order specializes in the druidic art of flying." }
    c.groups["druids_of_the_antler"] = { name = "Druids of the Antler", lore = "An elusive order rarely seen by outsiders. They revere the Great White Stag Malorne." }
    c.groups["thornweavers"] = { name = "Thornweavers", lore = "Quillboar spellcasters who cause most of the enormous thorns protecting their settlements to grow." }
    c.figureText["cenarius"] = { name = "Cenarius", role = "Lord of the Forest, demigod of the groves, the \"father of druidism\".", aff = "Cenarion Circle", race = "Demigod", title = "Lord of the Forest, demigod of the groves, the \"father of druidism\". — Cenarion Circle (Demigod)" }
    c.figureText["malfurion_stormrage"] = { name = "Malfurion Stormrage", role = "First mortal druid, founder of the Cenarion Circle; slumbers in the Emerald Dream.", aff = "Cenarion Circle", race = "Night elf", title = "First mortal druid, founder of the Cenarion Circle; slumbers in the Emerald Dream. — Cenarion Circle (Night elf)" }
    c.figureText["fandral_staghelm_forever"] = { name = "Fandral Staghelm", role = "Archdruid, leads the druids of Darnassus in Malfurion's absence.", aff = "Cenarion Circle", race = "Night elf", title = "Archdruid, leads the druids of Darnassus in Malfurion's absence. — Cenarion Circle (Night elf)" }
    c.figureText["hamuul_runetotem"] = { name = "Hamuul Runetotem", role = "Archdruid of the tauren, leader of the Horde druids.", aff = "Thunder Bluff", race = "Tauren", title = "Archdruid of the tauren, leader of the Horde druids. — Thunder Bluff (Tauren)" }
    c.figureText["remulos"] = { name = "Remulos", role = "Son of Cenarius, guardian of Moonglade.", aff = "Cenarion Circle", race = "Keeper of the grove", title = "Son of Cenarius, guardian of Moonglade. — Cenarion Circle (Keeper of the grove)" }
    c.figureText["broll_bearmantle"] = { name = "Broll Bearmantle", role = "Champion of the Cenarion Circle.", aff = "Cenarion Circle", race = "Night elf", title = "Champion of the Cenarion Circle. — Cenarion Circle (Night elf)" }
    c.variants = "Archdruid · Haruspex · Hierophant · Thornweaver · Plagueshifter"
end

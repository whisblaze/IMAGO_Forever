-- ============================================================
-- IMAGO Forever — locales/base/data/codex.lua
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
    cosmos     = "Cosmos & Primal Forces",
    magic      = "Magic & Faith",
    worlds     = "Worlds & Geography",
    sites      = "Historic Sites & Artifact Locations",
    peoples    = "Peoples & Creatures (non-playable)",
    factions   = "Factions & Orders",
    artifacts  = "Artifacts & Weapons",
    concepts   = "Concepts, Titles & Customs",
}

local e = IMAGOdb.codex.entries

-- ============ COSMOS ============

if e["cosmic_forces"] then
    e["cosmic_forces"].title = "Cosmic Forces"
    e["cosmic_forces"].body = [[
Six forces of magic are known to battle for dominance in the Great Dark Beyond. There is the Light and the Void, who stand in constant opposition to another, and there are Life and Death holding sway over every being.

The forces of Order and Disorder, opposing one another as the Titans and the Burning Legion, have come closest to total dominance in the past.
]]
end

if e["holy_light"] then
    e["holy_light"].title = "The Light"
    e["holy_light"].aliases = { "The Holy Light", "Holy Light" }
    e["holy_light"].body = [[
Holy, benevolent magic that aids everyone who is strong of belief. While it is predominantly used for good - such as by priests to heal the wounded, or by paladins to protect the helpless - the Light itself doesn't distinguish love from hatred.

It can manifest in many forms and is revered in many cultures as a force of worship.
]]
end

if e["void"] then
    e["void"].title = "Void"
    e["void"].body = [[
A cosmic force that is everything and nothing at the same time, an endless hunger with the goal to consume the entire physical universe and make it a place of torment.

Mortals have often intended to wield the Void's power as it grants infinite possibilities and sweet promises. Almost all who try to master it sooner or later fall to madness, however.
]]
end

if e["life"] then
    e["life"].title = "Life"
    e["life"].body = [[
The force of nature, renewal and growth in the cosmos. Life magic manifests itself through the elements and can be witnessed in its purest form in the Emerald Dream.

Druids and shaman share an innate connection to the land and channel life magic to preserve the delicate balance of the world.
]]
end

if e["death"] then
    e["death"].title = "Death"
    e["death"].body = [[
One of the six cosmic forces and the counterbalance to Life. Death acts as the end of everything that exists, and claims every soul eventually. It also offers new beginnings as its magic permeates the spirit realms.

Death magic can be used by necromancers.
]]
end

if e["great_dark_beyond"] then
    e["great_dark_beyond"].title = "Great Dark Beyond"
    e["great_dark_beyond"].body = [[
It is the name given to the physical universe consisting of endless planets, stars and civilizations.

According to the Titans, the Great Dark Beyond came into existence after a clash between the Light and the Void ruptured the fabric of creation.
]]
end

if e["twisting_nether"] then
    e["twisting_nether"].title = "Twisting Nether"
    e["twisting_nether"].body = [[
The Twisting Nether is a chaotic realm between the physical and astral plane. The Burning Legion hails from here and every demon slain is reborn through the Nether's magic.

There is not one singular way to perceive it's myriad of different energies and many have been driven mad by just the sight of this twisted dimension.
]]
end

if e["world_souls"] then
    e["world_souls"].title = "World-Souls"
    e["world_souls"].aliases = { "World-Soul" }
    e["world_souls"].body = [[
World-souls are the spirits of titans. They formed deep within the fiery core of a small number of worlds and slumbered there for ages while their energies suffused the celestial bodies.

When they finally awoke, they did so as living worlds. The Pantheon searched endlessly for them and hoped that ordering new worlds would call forth the world-souls and bring them to maturity.

Azeroth too harbors such a slumbering world-soul.
]]
end

if e["titans"] then
    e["titans"].title = "Titans"
    e["titans"].body = [[
Born of souls of sentient planets, the titans are enormous beings of arcane energy who are rivaled in power by few others.

They roam the cosmos in search of other world-souls and combat corruption of the Void and Disorder wherever they encounter it. Azeroth has not only been cleansed by the titans from the taint of the Old Gods, but the world and all of its realms have been ordered and machine races like the keepers and the earthen have been created in the titans' image to maintain their vision of a perfect Azeroth.
]]
end

if e["pantheon"] then
    e["pantheon"].title = "Pantheon"
    e["pantheon"].body = [[
The Pantheon was the ruling order of the titans. Its members:

• Aman'Thul — Highfather of the Pantheon

• Sargeras — Defender of the Pantheon (before his fall)

• Aggramar — Lieutenant of the Great Sargeras

• Eonar — the Life-Binder

• Khaz'goroth — Shaper and Forger of Worlds

• Norgannon — Keeper of Celestial Magics and Lore

• Golganneth — Lord of the Skies and Roaring Oceans
]]
end

if e["void_lords"] then
    e["void_lords"].title = "Void Lords"
    e["void_lords"].body = [[
The Void Lords are monstrous entities of pure shadow energy. They are more cruel and merciless than any mortal can comprehend. Driven by an insatiable hunger, they seek to devour all matter and energy in the physical universe.

In their natural state, they exist outside reality. Only the most powerful among them can manifest in the physical universe, and even then only for a limited time. To maintain their presence in reality, they must consume untold amounts of matter and energy.
]]
end

if e["old_gods"] then
    e["old_gods"].title = "Old Gods"
    e["old_gods"].body = [[
Old Gods are eldritch fleshy manifestations of the void lords. Four of them ruled over Azeroth and grew like cancers into the world itself. Killing one of them damaged Azeroth so much that the titans had to resolve to imprison the other three, namely N'Zoth, C'Thun, and Yogg-Saron.

Like the Void itself, the Old Gods whisper of mysterious prophecies and merely being in their presence is enough to turn a mind to madness.
]]
end

if e["emerald_dream"] then
    e["emerald_dream"].title = "The Emerald Dream"
    e["emerald_dream"].body = [[
A realm of spirit that exists parallel to Azeroth and shows the world how it would be in its natural state if there were no intelligent societies. It is a realm druids come to often in their sleep to learn from it how to better aid Azeroth.

The green dragon aspect holds dominion over the Emerald Dream.
]]
end

if e["emerald_nightmare"] then
    e["emerald_nightmare"].title = "Emerald Nightmare"
    e["emerald_nightmare"].body = [[
Through the world tree Andrassil, the Old God Yogg-Saron gained access to the Emerald Dream. He corrupted it from a serene natural echo of Azeroth into a horrific place of decay.

Dreamers who get caught in the Nightmare may never wake up again, and its foul taint can even spread from the spirit realm into the physical world.
]]
end

if e["shadowlands"] then
    e["shadowlands"].title = "Shadowlands"
    e["shadowlands"].body = [[
Like the Emerald Dream, the Shadowlands are indirectly bound to Azeroth. But where the Dream represents life, the Shadowlands stand for death. They are nightmarish realms of decay, labyrinthine spiritual planes populated by the souls of all who have left the world of the living behind.

Little is known of their origins, yet they have existed since the first mortal life stirred in the physical universe. Many believe the souls of the dying are drawn to this grim place, where they linger for all eternity.
]]
end

if e["elements"] then
    e["elements"].title = "Elements"
    e["elements"].body = [[
Every planet in the Great Dark Beyond holds elements of its own, volatile natural energies that decide the form of nature and life. They can manifest physically as elemental spirits, and fulfil their natural purpose as a primitive life form.

Inherently imbued in Azeroth are five elements: Fire, Water, Air, Earth, and Spirit, although the latter was partially consumed by the world-soul.
]]
end

if e["elemental_lords"] then
    e["elemental_lords"].title = "Elemental Lords"
    e["elemental_lords"].body = [[
The leaders and most powerful of the elementals. In Azeroth's ancient times, the four Elemental Lords' rule kept the world in a state of perpetual, natural chaos.

They were first subdued by the Old Gods during the Black Empire and then imprisoned in the Elemental Plane by the Titan Keepers.
]]
end

if e["elemental_plane"] then
    e["elemental_plane"].title = "Elemental Plane"
    e["elemental_plane"].body = [[
A pocket dimension of titanic make to imprison the Elemental Lords of Azeroth. It contains four interlinked dimensions, one for each of the dominant elements: the Firelands, Skywall, Deepholm, and the Abyssal Maw.

The banished elements fight endless battles in the confines of their prison dimensions.
]]
end

-- ============ MAGIC ============

if e["arcane"] then
    e["arcane"].title = "Arcane"
    e["arcane"].body = [[
Also known as order magic, arcane is the magical language of the Titans and is maybe the most versatile of all the cosmic forces.

With enough intellect, patience and study, a mage can learn to mold the arcane in almost any way or shape they need: be it manipulation of time and space, conjuration of objects out of thin air, teleportation, raw destruction... Imagination is the limit.
]]
end

if e["fel"] then
    e["fel"].title = "Fel Magic"
    e["fel"].body = [[
The sickly green magic of the Fel is chaos made manifest. It's a volatile magic which comes easy to the wielder, promising great power for a great price. Fel corrupts the caster and means great suffering for victims of its spells.

All demons of the Burning Legion bear its taint and they are quick to spread the corruption throughout the Great Dark Beyond.
]]
end

if e["church_holy_light"] then
    e["church_holy_light"].title = "Church of the Holy Light"
    e["church_holy_light"].body = [[
For over two thousand years the worship of the Holy Light has been the prevalent religion of the human race. In the Church they have an institution of priests who channel and teach the virtues of the Light.

With the threat of the orcish Horde during the Second War, the Church taught knights to use the light in combat and created the very first paladins.
]]
end

if e["druids"] then
    e["druids"].title = "Druids"
    e["druids"].body = [[
Druidism is a school of nature magic. It enables its practitioners to channel natural energies and transform into animals.

The first druid on Azeroth was Malfurion Stormrage, who was taught by Cenarius, a demigod of nature. Druids possess a deep connection to nature through the Emerald Dream, a primordial realm uniting all aspects of nature.
]]
end

if e["shamanism"] then
    e["shamanism"].title = "Shamanism"
    e["shamanism"].body = [[
Shamans are spellcasters that serve as mediators between the elements and their own people. They are chosen by nature and can never demand to wield the elemental powers, but must be deemed worthy of them. Some of them can commune with the world itself.

The strongest shamans can move mountains and create blizzards during a beautiful day, and prophetic visions warn them of the future. They are feared on the battlefield and revered as elders.
]]
end

if e["necromancy"] then
    e["necromancy"].title = "Necromancy"
    e["necromancy"].body = [[
Few things are as vile and reprehensible as the use of magic to raise and master the dead. Necromancers are the enemies of life itself. They are reviled and feared everywhere.

Some of the most gruesome deeds in Azeroth's history were committed by them. Their foul reputation is well earned.

Necromancers and death knights forcefully raise the bodies of the fallen as mindless servants, doing great harm to the soul.
]]
end

if e["council_of_tirisfal"] then
    e["council_of_tirisfal"].title = "Council of Tirisfal"
    e["council_of_tirisfal"].body = [[
Reckless use of arcane magic from Dalaran caught the attention of the demons of the Burning Legion. Alarmed by the scale of this massive, enemy army, this secret council was formed with the goal to find and exterminate any agents if the Legion on Azeroth.

They are led by the Guardian.
]]
end

if e["guardians_tirisfal"] then
    e["guardians_tirisfal"].title = "Guardian of Tirisfal"
    e["guardians_tirisfal"].aliases = { "Guardians of Tirisfal", "the Guardian" }
    e["guardians_tirisfal"].body = [[
To combat the most ferocious demons, the Council of Tirisfal chose a champion and imbued them with their combined power. The Guardian thus became an extraordinarily powerful mage.

The Dark Titan Sargeras possessed the Last Guardian Medivh to construct the Dark Portal and to allow the orcish Horde to enter Azeroth. It was decided that no single mortal should ever wield such power again.
]]
end

if e["plague_of_undeath"] then
    e["plague_of_undeath"].title = "Plague of Undeath"
    e["plague_of_undeath"].body = [[
The Plague of Undeath is a magical affliction that the Lich King brought upon Lordaeron after his creation by Kil'jaeden. Spread through contaminated grain shipments smuggled into the kingdom by the archmage Kel'Thuzad, it turns the living into undead servants of the Scourge.

Thus arose the undead army with which the Burning Legion began its renewed assault on Azeroth.
]]
end

if e["elune"] then
    e["elune"].title = "Elune"
    e["elune"].body = [[
The goddess of the moon is worshiped by the Kaldorei as their primary deity and her favors grant her priestesses the power to heal allies, illuminate the dark, and obliterate their foes in holy moonlight.

To the tauren she is known as Mu'sha, and they believe her to be a daughter of the Earth Mother.
]]
end

if e["earth_mother"] then
    e["earth_mother"].title = "Earth Mother"
    e["earth_mother"].body = [[
Tauren myth sees the Earth Mother as the creator of the land and the tauren's deep reverence of nature reflects their belief.

Although she gave all of herself to rid the land of the Old Gods millennia ago, the tauren know that the Earth Mother still watches out for all her children.
]]
end

if e["anshe"] then
    e["anshe"].title = "An'she"
    e["anshe"].aliases = { "Mu'sha" }
    e["anshe"].body = [[
An'she is the sun, who the tauren worship as a deity. He is the twin-brother of the moon, Mu'sha, and one of the Eyes of the Earth Mother.

Tauren priests can channel the Light through reverence of An'she.
]]
end

-- ============ WORLDS ============

if e["azeroth"] then
    e["azeroth"].title = "Azeroth"
    e["azeroth"].body = [[
Both the name of the planet and of the slumbering world-soul inside it. Azeroth has been coveted by almost all of the cosmic forces in the past and the present and her Champions have stopped at nothing to protect her.

According to the Titans, Azeroth, whenever she wakes up, will be the most powerful among them.
]]
end

if e["kalimdor"] then
    e["kalimdor"].title = "Kalimdor"
    e["kalimdor"].body = [[
Entry under construction — coming soon.
]]
end

if e["eastern_kingdoms"] then
    e["eastern_kingdoms"].title = "Eastern Kingdoms"
    e["eastern_kingdoms"].body = [[
Entry under construction — coming soon.
]]
end

if e["northrend"] then
    e["northrend"].title = "Northrend"
    e["northrend"].body = [[
Entry under construction — coming soon.
]]
end

if e["draenor"] then
    e["draenor"].title = "Draenor"
    e["draenor"].aliases = { "Outland" }
    e["draenor"].body = [[
Entry under construction — coming soon.
]]
end

if e["argus"] then
    e["argus"].title = "Argus"
    e["argus"].body = [[
Argus was the home world to the eredar, an intelligent species who sought to improve the universe through their thirst for knowledge. The planet was ruled by the powerful Archimonde, the genius Kil'jaeden and the spiritual leader Velen.

Unfortunately for them all, Sargeras needed some powerful servants to lead his Burning Legion, so he convinced the eredar to become his demonic generals. Only Velen and his loyal followers managed to escape on the Genedar. They became known as draenei (the exiled).
]]
end

if e["karesh"] then
    e["karesh"].title = "K'aresh"
    e["karesh"].body = [[
Entry under construction — coming soon.
]]
end

if e["well_of_eternity"] then
    e["well_of_eternity"].title = "Well of Eternity"
    e["well_of_eternity"].body = [[
Beneath the World Tree of Nordrassil rests a glimmering lake of immense arcane power. It is the second Well of Eternity, as the first one was destroyed and caused the Great Sundering at the end of the War of the Ancients.

While it is considerably weaker than the original Well, and Nordrassil keeps its influence contained, it is still one of the most powerful fonts of magic on Azeroth and was coveted by the Burning Legion twice already to hasten their invasion.
]]
end

if e["maelstrom"] then
    e["maelstrom"].title = "The Maelstrom"
    e["maelstrom"].body = [[
In the center of the Great Sea dividing the continents, this gigantous vortex of water creates a permanent tidal storm that's impossible to cross via ship.

The Maelstrom was formed when the original Well of Eternity imploded during the Great Sundering.
]]
end

if e["dark_portal"] then
    e["dark_portal"].title = "Dark Portal"
    e["dark_portal"].body = [[
A massive portal created as a gateway between Azeroth and Draenor to enable the Old Horde's invasion and the First War. It was built in two identical versions on both planets by Medivh and Gul'dan respectively.

The opening of the Portal marked the beginning of a new era for Azeroth and is now used as the starting point in the calendar.
]]
end

if e["world_trees"] then
    e["world_trees"].title = "World Trees"
    e["world_trees"].aliases = { "Nordrassil", "Vordrassil" }
    e["world_trees"].body = [[
These massive, magical trees are connected to the Emerald Dream. They are sacred to the Kaldorei and the elves even made their homes in some of them.

The great trees are inherently magical and serve a variety of different purposes, such as giving the night elves immortality and containing the powers of the Well of the Eternity in place.
]]
end

if e["moonwells"] then
    e["moonwells"].title = "Moonwells"
    e["moonwells"].body = [[
These pools of silvery water can be found near almost any major night elven dwelling. They are repositories of the second Well of Eternity and filled with a mixture of nature magic and the blessings of Elune.

Moonwells heal both the land around them, as well as any being in contact with its holy waters.
]]
end

if e["ley_lines"] then
    e["ley_lines"].title = "Ley Lines"
    e["ley_lines"].body = [[
Ley lines form networks of channels of immense arcane energy across a planet, comparable to blood vessels in a mortal body. Where such lines coalesce into nexus points, mages have found their spells to be considerably stronger in potency.

Magical sites have for that reason often been constructed on these nexus points, such as the Well of Eternity and Dalaran.
]]
end

-- ============ SITES ============

if e["tomb_of_sargeras"] then
    e["tomb_of_sargeras"].title = "Tomb of Sargeras"
    e["tomb_of_sargeras"].body = [[
Entry under construction — coming soon.
]]
end

if e["forge_of_wills"] then
    e["forge_of_wills"].title = "Forge of Wills"
    e["forge_of_wills"].aliases = { "Forge of Origination", "Forge of Origination" }
    e["forge_of_wills"].body = [[
Entry under construction — coming soon.
]]
end

-- ============ PEOPLES ============

if e["earthen"] then
    e["earthen"].title = "Earthen"
    e["earthen"].body = [[
The earthen emerged from the Forge of Wills as the second generation, after the keepers' first design had produced the savage troggs. The craggy, kindhearted earthen shaped mountains and carved out the deep places of the world.

When the curse of flesh broke out among them, many asked for sleep within Uldaman. More followed during the Sundering, feeling the pain of the broken world as their own. Those who stayed awake or awoke ages later degenerated into beings of flesh.

From them came the dwarves.
]]
end

if e["vrykul"] then
    e["vrykul"].title = "Vrykul"
    e["vrykul"].body = [[
The vrykul are an iron-skinned race of the titan-forged, once charged with guarding the keepers' holdings. After Loken's betrayal they lived in the north of Kalimdor in small clans, some as nomads, others in settlements.

Warlike tribes like the Winterskorn believed they would ascend to the Halls of Valor after a glorious death. The vrykul were the first to show the curse of flesh.

Millennia later they gave birth to stunted children of flesh. King Ymiron ordered them killed, but some parents carried the children south.

From them came the humans.
]]
end

if e["mechagnomes"] then
    e["mechagnomes"].title = "Mechagnomes"
    e["mechagnomes"].body = [[
The mechagnomes are small clockwork beings designed by Keeper Mimiron to build and maintain the keepers' extraordinary machineries. When Mimiron was slain through Loken's sabotage, his faithful mechagnomes saved him by building a mechanical body for his soul.

Later a group of them followed the keepers Tyr, Archaedas and Ironaya to Uldaman. There they stayed awake to maintain the fortress while the earthen slept, until the curse of flesh overcame them as well.

From them came the gnomes.
]]
end

if e["tolvir"] then
    e["tolvir"].title = "Tol'vir"
    e["tolvir"].body = [[
Entry under construction — coming soon.
]]
end

if e["anubisath_giants"] then
    e["anubisath_giants"].title = "Anubisath Giants"
    e["anubisath_giants"].body = [[
Entry under construction — coming soon.
]]
end

if e["naga"] then
    e["naga"].title = "Naga"
    e["naga"].body = [[
The serpentine naga are among the most notorious villains of Azeroth. These masters of sorcery were once night elves who served at the court of Queen Azshara during the War of the Ancients.

When the Well of Eternity shattered in the Sundering, the Maelstrom dragged them into the depths of the sea. Transformed by the Old Gods, they have haunted the oceans of Azeroth ever since.

In the darkness of the ocean floor, Azshara and her loyal followers built the capital city of Nazjatar.
]]
end

if e["murlocs"] then
    e["murlocs"].title = "Murlocs"
    e["murlocs"].body = [[
The murlocs remain a peculiar encounter for adventurers in Azeroth. They are known for their gurgling battle cry and tend to attack and overwhelm the unsuspecting with primitive spears, slimy limbs, fishy breath, and elemental magic.

They live along coasts, rivers, and lakes and always appear in swarms. Yet they are social creatures who, when attacked, usually retreat from the fight into the safety of the larger group of their kin.

There are cases of peaceful interaction between murlocs and other peoples, but they are rare.
]]
end

if e["makrura"] then
    e["makrura"].title = "Makrura"
    e["makrura"].body = [[
The makrura, sometimes called lobstrok, are a primitive people of water dwellers who can also survive on land for short periods. These crab-like creatures exist in colonies along the coasts of Azeroth and in the depths of the oceans.

The unusually mighty among them are feared as especially dangerous opponents.
]]
end

if e["kobolds"] then
    e["kobolds"].title = "Kobolds"
    e["kobolds"].body = [[
The rat-like kobolds are rumored to be descendants of the troggs. Although they live underground, kobolds have rather poor night vision and rely on candles when wandering through their ancestral mines.

Kobolds fear other peoples and are therefore found in mines or near the surface. Strangely, the kobold clans have nonetheless managed to maintain connections with two other peoples not exactly known for peaceful relations: the vicious harpies and the magnataurs of Northrend.
]]
end

if e["gnolls"] then
    e["gnolls"].title = "Gnolls"
    e["gnolls"].body = [[
The brutal and warlike gnolls value strength above all else. Although they are savage and feared fighters, gnolls are by no means among the most intelligent peoples.

Gnolls have often been enlisted as mercenaries, yet their penchant for cruelty and their limited intelligence make constant supervision necessary.

One particularly grim gnoll known as Hogger terrorizes Elwynn Forest.
]]
end

if e["troggs"] then
    e["troggs"].title = "Troggs"
    e["troggs"].body = [[
The troggs arose as the first, flawed design of the Forge of Wills — misshapen, brutal, and dangerous beings. For millennia they rested undisturbed deep beneath the earth, until the dwarves excavated the titan fortresses, such as Uldaman.

Once awakened, the troggs surged from the earth, eager to unleash their aggression on their distant dwarven kin. Although cunning in battle, troggs can generally not be called particularly intelligent. Instead they rely on their savagery and thick hides to protect them.

Most of them are dangerous fighters, yet some slightly cleverer troggs can also cast spells.
]]
end

if e["ogres"] then
    e["ogres"].title = "Ogres"
    e["ogres"].body = [[
These brutal humanoids originally hail from Draenor and now inhabit various regions within and beyond Azeroth. Ogres are feared opponents, known for their strength and toughness.

Their society is based on clans, and every clan is independent. Within a clan, victory over one's rival is the only path to advancement.

Although they are usually indifferent or hostile toward other peoples, several ogre clans have become reliable allies of the Horde. Ogres are generally not famous for their intelligence, yet mages were not entirely unknown among them on Draenor.

Through the efforts of the orc warlock Gul'dan, many ogres received a sharper mind and the ability to cast spells. These ogre magi often enjoy great prestige within the clans.
]]
end

if e["furbolgs"] then
    e["furbolgs"].title = "Furbolgs"
    e["furbolgs"].body = [[
According to the furbolgs' oral traditions, their people have a far-reaching history. They reluctantly took part in the War of the Ancients against the Burning Legion and afterward forged friendly alliances with the night elves and the tauren.

They lived in peaceful isolation until the Third War and the corruption of the Burning Legion destroyed the furbolgs' ancestral forests. Some tribes succumbed to the corruption, turned more violent, and followed warlike leaders who called for raids on neighboring settlements. The uncorrupted tribes withdrew even further, fearing that contact with the outside world might bring the corruption into their homeland.
]]
end

if e["harpies"] then
    e["harpies"].title = "Harpies"
    e["harpies"].body = [[
Although some tales claim the harpies are the offspring of night elves cursed by Queen Azshara, it is now known that they are in truth the progeny of the demigoddess Aviana. Despite their physical resemblance to the night elves, these aggressive beings have little in common with that people.

Like the night elves, harpies use nature-based magic, but they also destroy the environment in which they settle, kill every living being they encounter, and plunder the land to build nests notorious for their dreadful stench. The harpies were first discovered in the Stonetalon Mountains, but have since spread as far as the Storm Peaks in Northrend.
]]
end

if e["centaurs"] then
    e["centaurs"].title = "Centaurs"
    e["centaurs"].body = [[
The centaur combine numerous traits: a passion for battle, hatred of their ancestors and the tauren, and an overwhelming contempt for centaurs of other tribes. Legend has it they descend from the union of Zaetar, son of the Ancient Cenarius, with Theradras, daughter of Therazane, the elemental ruler of earth.

The centaur later turned vicious, brutal, and cruel, and killed their father Zaetar.
]]
end

if e["quilboar"] then
    e["quilboar"].title = "Quilboar"
    e["quilboar"].body = [[
The quilboar are aggressive, boar-like humanoids known for their fearlessness and cruelty. They believe themselves to be the mortal descendants of the demigod Ancient Agamaggan, and they have long waged wars over land and food with other peoples, such as the centaur and the tauren.

They built their dwellings within vast thorny tangles they believe grew from Agamaggan's blood, and there they founded their colonies. The most famous of these are Razorfen Downs and Razorfen Kraul in Kalimdor, the home of the Razorfen and Death's Head tribes.

The quilboar are loyal to their tribe and defend their territory with reckless savagery.
]]
end

if e["wolvar"] then
    e["wolvar"].title = "Wolvar"
    e["wolvar"].body = [[
Entry under construction — coming soon.
]]
end

if e["taunka"] then
    e["taunka"].title = "Taunka"
    e["taunka"].body = [[
Entry under construction — coming soon.
]]
end

if e["tuskarr"] then
    e["tuskarr"].title = "Tuskarr"
    e["tuskarr"].body = [[
Entry under construction — coming soon.
]]
end

if e["arakkoa"] then
    e["arakkoa"].title = "Arakkoa"
    e["arakkoa"].body = [[
Entry under construction — coming soon.
]]
end

if e["ethereals"] then
    e["ethereals"].title = "Ethereals"
    e["ethereals"].body = [[
Entry under construction — coming soon.
]]
end

if e["magnataurs"] then
    e["magnataurs"].title = "Magnataurs"
    e["magnataurs"].body = [[
Entry under construction — coming soon.
]]
end

if e["high_elves"] then
    e["high_elves"].title = "High Elves"
    e["high_elves"].aliases = { "Quel'dorei", "Quel'dorei" }
    e["high_elves"].body = [[
The Highborne broke with the other night elves, as they did not want to give up arcane magic. The price was exile from Hyjal.

Under the leadership of Dath'Remar Sunstrider, the banished people put to sea in a fleet and crossed the Maelstrom. In the Eastern Kingdoms his scouts discovered a place in the north where mighty ley lines converged. Dath'Remar poured a secretly taken vial of water from the Well of Eternity into a lake and thereby called the Sunwell into being – named after him and his boldness.

The elves called the land Quel'Thalas, the High Home. Since it had been built upon the ruins of ancient Amani holy places, the high elves fought the trolls there for centuries. Within its borders civilization flourished; their capital Silvermoon became a shining monument to the elves' ancient empire.

In the Third War the Scourge brought down Quel'Thalas's defenses and the survivors took the name Sin'dorei, the blood elves.
]]
end

if e["bogstroks"] then
    e["bogstroks"].title = "Bogstroks"
    e["bogstroks"].body = [[
Entry under construction — coming soon.
]]
end

if e["highborne"] then
    e["highborne"].title = "Highborne"
    e["highborne"].body = [[
The Highborne used to be the elite of the Kaldorei ten thousand years ago and served closely at Queen Azshara's side. Their former allegiance to the queen and unwillingness to abandon arcane magic meant their exile from night elven culture following the Great Sundering.

Some of the Highborne joined Dath'remar Sunstrider and became the Quel'dorei, others were twisted into the Naga alongside Azshara, while even others toiled away in the wilds of Kalimdor, seeking mana and arcane nourishment at all costs.
]]
end

if e["zandalari"] then
    e["zandalari"].title = "Zandalari"
    e["zandalari"].body = [[
Entry under construction — coming soon.
]]
end

if e["gurubashi_empire"] then
    e["gurubashi_empire"].title = "Gurubashi Empire"
    e["gurubashi_empire"].body = [[
Entry under construction — coming soon.
]]
end

if e["amani_empire"] then
    e["amani_empire"].title = "Amani Empire"
    e["amani_empire"].body = [[
Entry under construction — coming soon.
]]
end

if e["drakkari"] then
    e["drakkari"].title = "Drakkari"
    e["drakkari"].body = [[
Entry under construction — coming soon.
]]
end

if e["fel_orcs"] then
    e["fel_orcs"].title = "Fel Orcs"
    e["fel_orcs"].body = [[
Entry under construction — coming soon.
]]
end

if e["naaru"] then
    e["naaru"].title = "Naaru"
    e["naaru"].body = [[
Entry under construction — coming soon.
]]
end

if e["eredar"] then
    e["eredar"].title = "Eredar"
    e["eredar"].aliases = { "Man'ari" }
    e["eredar"].body = [[
Entry under construction — coming soon.
]]
end

if e["nathrezim"] then
    e["nathrezim"].title = "Nathrezim"
    e["nathrezim"].aliases = { "Dreadlords" }
    e["nathrezim"].body = [[
Entry under construction — coming soon.
]]
end

if e["annihilan"] then
    e["annihilan"].title = "Annihilan"
    e["annihilan"].aliases = { "Pit Lords" }
    e["annihilan"].body = [[
Entry under construction — coming soon.
]]
end

if e["felguards"] then
    e["felguards"].title = "Felguards"
    e["felguards"].aliases = { "Mo'arg" }
    e["felguards"].body = [[
Entry under construction — coming soon.
]]
end

if e["shivarra"] then
    e["shivarra"].title = "Shivarra"
    e["shivarra"].aliases = { "Sayaad", "Succubi" }
    e["shivarra"].body = [[
Entry under construction — coming soon.
]]
end

if e["wrathguard"] then
    e["wrathguard"].title = "Wrathguard"
    e["wrathguard"].body = [[
Entry under construction — coming soon.
]]
end

if e["infernal"] then
    e["infernal"].title = "Infernal"
    e["infernal"].body = [[
Entry under construction — coming soon.
]]
end

if e["fel_reavers"] then
    e["fel_reavers"].title = "Fel Reavers"
    e["fel_reavers"].body = [[
Entry under construction — coming soon.
]]
end

if e["satyrs"] then
    e["satyrs"].title = "Satyrs"
    e["satyrs"].body = [[
The cunning and deceitful satyrs are corrupted servants of the Burning Legion who delight in inflicting physical and emotional pain on their foes. The first satyr was Xavius, the chief advisor of the former night elf queen Azshara.

When Xavius was slain by Malfurion Stormrage, his failure and death enraged Sargeras, the ruler of the Burning Legion. After torturing Xavius' bodiless spirit, he twisted and disfigured the night elf into the first satyr. Sargeras also granted him the power to transform others into satyrs.

Although the satyrs are splintered into many different factions, each pursuing its own goals, all these corrupted beings still heed the Burning Legion.
]]
end

if e["constructs"] then
    e["constructs"].title = "Constructs"
    e["constructs"].aliases = { "Golems" }
    e["constructs"].body = [[
Entry under construction — coming soon.
]]
end

if e["dragonflights"] then
    e["dragonflights"].title = "Dragonflights"
    e["dragonflights"].body = [[
Immense winged reptilian creatures who have been changed by the Titans to serve as guardians of Azeroth. They are highly intelligent beings, capable of shape-shifting and possess incredible magical power.

They are divided in five flights, all tasked to safeguard a different aspect of the Titans' vision of Azeroth.
]]
end

if e["black_dragonflight"] then
    e["black_dragonflight"].title = "Black Dragonflight"
    e["black_dragonflight"].body = [[
A swarm of obsidian dragons tasked by the Titan Khaz'goroth to protect the earth and the deep places therein. Neltharion, for the longest time the aspect of the flight, failed to fulfill his duty when the Old Gods, who were deeply rooted into Azeroth by this point, corrupted him.

The black dragonflight's legacy sees them not as noble protectors, but as monsters in opposition to all life.
]]
end

if e["red_dragonflight"] then
    e["red_dragonflight"].title = "Red Dragonflight"
    e["red_dragonflight"].body = [[
Led by Alexstrasza the Life-Binder, the red flight were ordered by the Titan Eonar and put in charge of safeguarding all life on Azeroth. Red dragons can heal nature and purify corruption with their healing fire breath.

They love all creatures of the universe and only act aggressively if anyone or anything threatens to harm creation in a way that is too destructive to ignore.
]]
end

if e["blue_dragonflight"] then
    e["blue_dragonflight"].title = "Blue Dragonflight"
    e["blue_dragonflight"].body = [[
A flight of dragons tasked by the Titan Norgannon to control and manage the flow of magic on Azeroth. The blue dragons usually keep to themselves and don't much associate with mortals. Their understanding of the arcane and the ley lines is beyond compare.

The blue dragons' numbers were heavily decimated by Deathwing during the War of the Ancients.
]]
end

if e["green_dragonflight"] then
    e["green_dragonflight"].title = "Green Dragonflight"
    e["green_dragonflight"].body = [[
Charged by the Titan Eonar with protecting Azeroth's nature and keep watch over the Emerald Dream. Green dragons tend to be peaceful creatures and often work closely with the druids. Instead of killing their foes, they prefer to put them to sleep.

Being asleep most of the time, residing between the Dream and the physical world, green dragons are very susceptible to corruption.
]]
end

if e["bronze_dragonflight"] then
    e["bronze_dragonflight"].title = "Bronze Dragonflight"
    e["bronze_dragonflight"].body = [[
In all certainty the most mysterious of the five flights, the bronze have been tasked by Aman'Thul to maintain the One True Timeline. Their aspect, Nozdormu the Timeless one, has seen all of past, present, and future.

Rarely seen, always acting in secret on the sidelines, bronze dragons are among the wisest beings on Azeroth.
]]
end

if e["aspects"] then
    e["aspects"].title = "Dragon Aspects"
    e["aspects"].body = [[
Entry under construction — coming soon.
]]
end

if e["proto_dragons"] then
    e["proto_dragons"].title = "Proto-Dragons"
    e["proto_dragons"].body = [[
Entry under construction — coming soon.
]]
end

if e["wild_gods"] then
    e["wild_gods"].title = "Wild Gods"
    e["wild_gods"].body = [[
Immortal manifestations of life who hail from the Emerald Dream and usually appear to mortals in the form of great animals.

They are revered by druids, traditionally by the night elven ones, and have been known to work together with the mortal races when a great threat endangers nature and life.
]]
end

if e["loa"] then
    e["loa"].title = "Loa"
    e["loa"].body = [[
A term used for any being worshiped by trolls of any tribe. Most of the loa are Wild Gods and appear in the shape of animals, but other life forms have been known as loa as well, such as spirits.

Loa vary in strength, and either bless their followers with a wide array of different powers, often in exchange for sacrifices.
]]
end

if e["august_celestials"] then
    e["august_celestials"].title = "August Celestials"
    e["august_celestials"].body = [[
Entry under construction — coming soon.
]]
end

if e["ancients"] then
    e["ancients"].title = "Ancients"
    e["ancients"].body = [[
Entry under construction — coming soon.
]]
end

if e["demigods"] then
    e["demigods"].title = "Demigods"
    e["demigods"].body = [[
Entry under construction — coming soon.
]]
end

if e["dryads"] then
    e["dryads"].title = "Dryads and Keepers of the Grove"
    e["dryads"].aliases = { "Keepers of the Grove" }
    e["dryads"].body = [[
Both the keepers of the grove and the dryads descend from the demigod Cenarius. The dryads are daughters of Cenarius, while the keepers are apparently descendants of Cenarius' sons Remulos and Zaetar.

Dryads have the upper body of female night elves and the lower bodies of fauns. The keepers appear to be a combination of a mighty stag and a male night elf with a tree-trunk-like arm.

Both species prefer peace, yet when necessary they do not shy away from violence. The dryads are curious, but few of them ever leave the forest. The keepers of the grove are revered for their abilities as healers on the one hand, yet feared for their nature-based magic on the other.
]]
end

if e["wildkin"] then
    e["wildkin"].title = "Wildkin"
    e["wildkin"].body = [[
The wildkin are serene and mighty creatures whom the night elves believe were created by the moon goddess Elune. They resemble a cross between a bear and a horned owl, which explains both their wisdom and their ferocity.

Wildkin have long been allies of the night elves and aid them in protecting their sacred places. Although they are contemplative creatures, the wildkin hold an especially strong grudge against the Burning Legion and the Scourge, for they recognize the danger both pose. While the wildkin are not hostile to Azeroth's other inhabitants by nature, some have been corrupted or otherwise driven to aggression and now assault travelers and even their allies, the night elves.
]]
end

if e["scourge"] then
    e["scourge"].title = "The Scourge"
    e["scourge"].body = [[
Created by the Burning Legion originally, the undead army of the Scourge has since broken free from the demons' control. Ruled by the Lich King, it is a vast army of walking corpses, wraiths, and damned beings.

Its base of power lies in Northrend and its terrifying destructive force can still be seen in the Plaguelands, where the land and people still suffer from the lingering curse of Undeath.
]]
end

if e["lich_king"] then
    e["lich_king"].title = "The Lich King"
    e["lich_king"].body = [[
The entity sitting on the Frozen Throne atop Icecrown Citadel controls the entire army of the Scourge.

With unmatched psychic strength, as well as dominance over the dead and the frozen climate, even getting close to him is a guaranteed death sentence.
]]
end

if e["banshees"] then
    e["banshees"].title = "Banshees"
    e["banshees"].body = [[
Entry under construction — coming soon.
]]
end

if e["valkyr"] then
    e["valkyr"].title = "Val'kyr"
    e["valkyr"].aliases = { "Valkyrion" }
    e["valkyr"].body = [[
Entry under construction — coming soon.
]]
end

if e["qiraji"] then
    e["qiraji"].title = "Qiraji"
    e["qiraji"].body = [[
The qiraji once ruled an empire stretching across all of Silithus in southwestern Kalimdor.

Hundreds of years ago, these aggressive and intelligent insectoids waged a brutal war against the night elves. With the support of the bronze dragonflight they were eventually driven back into their former city of Ahn'Qiraj and sealed inside, which banished the threat they posed for centuries.

Years later, the qiraji stirred again behind the walls of Ahn'Qiraj under the influence of the Old God C'Thun.
]]
end

if e["nerubians"] then
    e["nerubians"].title = "Nerubians"
    e["nerubians"].body = [[
The nerubians are an ancient people of highly intelligent spider-like beings whose known settlements centered on the once-mighty underground kingdom of Azjol-Nerub. They are cruel by nature and usually attack other species on sight — unless a possible cooperation offers them advantages.

Each of the nerubians' various subspecies bears unique physical traits and holds a distinct place in nerubian society.

Although their realm once stretched across most of Northrend, the long, grueling war against the Scourge reduced the former conquerors to a fraction of their earlier might. Even so, individual groups of nerubian warriors still pose a threat.
]]
end

if e["silithid"] then
    e["silithid"].title = "Silithid"
    e["silithid"].body = [[
The silithid are an insectoid species found mainly in Kalimdor. Unlike the qiraji, silithid are not an intelligent race, yet they remain dangerous opponents.

Their swarms consist of various species. Each species has a unique body form ranging from small wasps to giant colossi, and a specific function within the hive.

The vast underground hives are made up of far-reaching tunnels that serve both as dwelling places and as protection for their delicate eggs and larvae. Although not all silithid are hostile by nature, they defend their hives with utmost determination.
]]
end

-- ============ FACTIONS ============

if e["alliance"] then
    e["alliance"].title = "Alliance"
    e["alliance"].body = [[
A political coalition of that has evolved from the Alliance of Lordaeron. Humans, dwarves, gnomes and night elves form the core races that called for its formation after the Third War, all of them bound together by ideals of faith, honor, and justice.

The Alliance traditionally is at war with the Horde, though there are many in its ranks who seek peace.
]]
end

if e["horde"] then
    e["horde"].title = "The Horde"
    e["horde"].body = [[
Under Warchief Thrall, the orcish Horde turned a new leaf and became a proud and honorable new faction where outcast and desperate races banded together in a tight-knit union.

As one of the two major political powers on Azeroth, the Horde frequently finds itself at war with its counterpart - the Alliance.
]]
end

if e["alliance_of_lordaeron"] then
    e["alliance_of_lordaeron"].title = "Alliance of Lordaeron"
    e["alliance_of_lordaeron"].body = [[
A coalition of the seven human kingdoms, the dwarves and gnomes of the Eastern Kingdoms, as well as the high elves of Quel'Thalas. It was formed in response to the invasion of the orcish Horde during the beginning of the Second War.

Under King Terenas Menethil II the Alliance vanquished the Horde, but fell apart in the following years when many nations departed from the coalition and when Lordaeron eventually fell to the Scourge.
]]
end

if e["old_horde"] then
    e["old_horde"].title = "Old Horde"
    e["old_horde"].body = [[
Driven by a demonic curse, the orcish Horde of Draenor came to Azeroth in order to kill and conquer. They destroyed the kingdoms of Stormwind and Alterac and were only halted by the Alliance of Lordaeron.

The Old Horde died a slow death on Azeroth after losing the Second War, as the surviving orcs wasted away in interment camps or were lost on a shattered Draenor.
]]
end

if e["burning_legion"] then
    e["burning_legion"].title = "Burning Legion"
    e["burning_legion"].body = [[
Led by the Dark Titan Sargeras, the Burning Legion is a nearly endless immortal army of demons whose only goal it is to extinguish all life in the cosmos.

They have conquered almost every planet they have set their sights on in the past, be it through slow manipulation or through sheer overwhelming force. Azeroth has resisted more than once already, but one day the Legion will surely return to try and claim her again.
]]
end

if e["shadow_council"] then
    e["shadow_council"].title = "Shadow Council"
    e["shadow_council"].body = [[
Entry under construction — coming soon.
]]
end

if e["cult_of_the_damned"] then
    e["cult_of_the_damned"].title = "Cult of the Damned"
    e["cult_of_the_damned"].body = [[
Entry under construction — coming soon.
]]
end

if e["twilights_hammer"] then
    e["twilights_hammer"].title = "Twilight's Hammer Cult"
    e["twilights_hammer"].body = [[
This nihilist sect worships the Old Gods with the goal to bring about the Hour of Twilight.

The cult was originally founded on Draenor, by the ogre Cho'gall, but has become an even greater threat on Azeroth.
]]
end

if e["hour_of_twilight"] then
    e["hour_of_twilight"].title = "Hour of Twilight"
    e["hour_of_twilight"].body = [[
An old prophecy speaks of the day when the Old Gods will return to Azeroth and bring about the end of the world. The Hour of Twilight marks Azeroth's last moments of existence before the Void consumes all life on it.

The Twilight's Hammer cult seeks to bring this fate about.
]]
end

if e["kirin_tor"] then
    e["kirin_tor"].title = "Kirin Tor"
    e["kirin_tor"].body = [[
The Wizard Council of the magocracy of Dalaran is an elite group of the world's most powerful mortal mages. Originally members of one of the seven human kingdoms, the Kirin Tor also host several elven mages.

Standing with the other nations, they utilize their destructive arcane magic to combat any threat to their world. In times of peace, they dedicate their time to learn more about the various forms magic can take and have made Dalaran one of Azeroth's greatest universities.
]]
end

if e["order_of_the_silver_hand"] then
    e["order_of_the_silver_hand"].title = "Order of the Silver Hand"
    e["order_of_the_silver_hand"].aliases = { "Knights of the Silver Hand" }
    e["order_of_the_silver_hand"].body = [[
The first order of paladins created by the Church's archbishop, Alonsus Faol. These noble light-wielding knights were the Alliance of Lordaeron's answer to the destruction caused by the orcish Horde.

Without the Silver Hand, the Second War might not have been won by the Alliance.
]]
end

if e["argent_dawn"] then
    e["argent_dawn"].title = "Argent Dawn"
    e["argent_dawn"].body = [[
A neutral faction without need for political power that was created to combat evil all across Azeroth, primarily in the Plaguelands of Lordaeron.

Its members hail from both the Horde and the Alliance and most of them are paladins or priests - though every follower of the Light is welcomed. They have a strict moral code and always strife to act rationally.
]]
end

if e["brotherhood_of_the_light"] then
    e["brotherhood_of_the_light"].title = "Brotherhood of the Light"
    e["brotherhood_of_the_light"].body = [[
A subsection of the Argent Dawn whose members, while holding the same beliefs as their brothers-in-arms, employ radical methods to exterminate evil.

If not for their lack of prejudice and fanaticism, they would be indistinguishable from the Scarlet Crusade.
]]
end

if e["cenarion_circle"] then
    e["cenarion_circle"].title = "Cenarion Circle"
    e["cenarion_circle"].body = [[
Entry under construction — coming soon.
]]
end

if e["earthen_ring"] then
    e["earthen_ring"].title = "Earthen Ring"
    e["earthen_ring"].body = [[
Whether they are Horde or Alliance, the shaman of the Earthen Ring put aside their differences and work together for the good of the world they all live in.

They are found primarily where the earth needs healing and where the elements are in turmoil.
]]
end

if e["scarlet_crusade"] then
    e["scarlet_crusade"].title = "Scarlet Crusade"
    e["scarlet_crusade"].body = [[
After the Third War, a fanatical sect evolved from the Order of the Silver Hand, believing that the Light demanded of them to exterminate all the undead - whether they were mindless Scourge or conscious Forsaken.

The Scarlet Crusade antagonize all those who they deem blasphemers, even casting suspicion on non-humans in general.
]]
end

if e["explorers_league"] then
    e["explorers_league"].title = "Explorers' League"
    e["explorers_league"].body = [[
Entry under construction — coming soon.
]]
end

if e["si7"] then
    e["si7"].title = "SI:7"
    e["si7"].body = [[
Entry under construction — coming soon.
]]
end

if e["royal_apothecary_society"] then
    e["royal_apothecary_society"].title = "Royal Apothecary Society"
    e["royal_apothecary_society"].body = [[
Entry under construction — coming soon.
]]
end

if e["elder_council"] then
    e["elder_council"].title = "Elder Council"
    e["elder_council"].body = [[
Entry under construction — coming soon.
]]
end

if e["kaldorei_empire"] then
    e["kaldorei_empire"].title = "Kaldorei Empire"
    e["kaldorei_empire"].body = [[
Entry under construction — coming soon.
]]
end

if e["arathor_empire"] then
    e["arathor_empire"].title = "Arathor Empire"
    e["arathor_empire"].body = [[
Entry under construction — coming soon.
]]
end

if e["seven_kingdoms"] then
    e["seven_kingdoms"].title = "Seven Kingdoms"
    e["seven_kingdoms"].body = [[
Entry under construction — coming soon.
]]
end

if e["empire_of_zul"] then
    e["empire_of_zul"].title = "Empire of Zul"
    e["empire_of_zul"].body = [[
Entry under construction — coming soon.
]]
end

if e["shadowmoon_clan"] then
    e["shadowmoon_clan"].title = "Shadowmoon Clan"
    e["shadowmoon_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["frostwolf_clan"] then
    e["frostwolf_clan"].title = "Frostwolf Clan"
    e["frostwolf_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["warsong_clan"] then
    e["warsong_clan"].title = "Warsong Clan"
    e["warsong_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["blackrock_clan"] then
    e["blackrock_clan"].title = "Blackrock Clan"
    e["blackrock_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["bleeding_hollow_clan"] then
    e["bleeding_hollow_clan"].title = "Bleeding Hollow Clan"
    e["bleeding_hollow_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["burning_blade_clan"] then
    e["burning_blade_clan"].title = "Burning Blade Clan"
    e["burning_blade_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["dragonmaw_clan"] then
    e["dragonmaw_clan"].title = "Dragonmaw Clan"
    e["dragonmaw_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["shattered_hand_clan"] then
    e["shattered_hand_clan"].title = "Shattered Hand Clan"
    e["shattered_hand_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["grimtotem_clan"] then
    e["grimtotem_clan"].title = "Grimtotem Clan"
    e["grimtotem_clan"].body = [[
Entry under construction — coming soon.
]]
end

if e["black_empire"] then
    e["black_empire"].title = "Black Empire"
    e["black_empire"].body = [[
When the Old Gods came to Azeroth they embedded themselves into the land itself, like tentacled corrupting parasites. They subdued the Elemental Lords and built civilizations of living beings made from their own flesh, and swarmed the world with their armies of faceless ones and insectoids.

It was one of the darkest eras for Azeroth and the world was almost corrupted by the Void.
]]
end

-- ============ ARTIFACTS ============

if e["ashbringer"] then
    e["ashbringer"].title = "Ashbringer"
    e["ashbringer"].body = [[
Entry under construction — coming soon.
]]
end

if e["frostmourne"] then
    e["frostmourne"].title = "Frostmourne"
    e["frostmourne"].body = [[
Entry under construction — coming soon.
]]
end

if e["doomhammer"] then
    e["doomhammer"].title = "Doomhammer"
    e["doomhammer"].body = [[
Entry under construction — coming soon.
]]
end

if e["gorehowl"] then
    e["gorehowl"].title = "Gorehowl"
    e["gorehowl"].body = [[
Entry under construction — coming soon.
]]
end

if e["atiesh"] then
    e["atiesh"].title = "Atiesh"
    e["atiesh"].body = [[
Entry under construction — coming soon.
]]
end

if e["sulfuras"] then
    e["sulfuras"].title = "Sulfuras"
    e["sulfuras"].body = [[
Entry under construction — coming soon.
]]
end

if e["dragon_soul"] then
    e["dragon_soul"].title = "Dragon Soul"
    e["dragon_soul"].aliases = { "Demon Soul" }
    e["dragon_soul"].body = [[
Entry under construction — coming soon.
]]
end

if e["skull_of_guldan"] then
    e["skull_of_guldan"].title = "Skull of Gul'dan"
    e["skull_of_guldan"].body = [[
Gul'dan's skull was a source of unimaginable power. Whoever possessed it heard a fragment of Gul'dan's soul whispering to them.

Ner'zhul used the skull to open the portals that destroyed Draenor. The human mage Khadgar employed it to destroy the Dark Portal. And finally, the skull transformed the night elf Illidan Stormrage into a demon.
]]
end

if e["eye_of_sargeras"] then
    e["eye_of_sargeras"].title = "Eye of Sargeras"
    e["eye_of_sargeras"].body = [[
Entry under construction — coming soon.
]]
end

if e["book_of_medivh"] then
    e["book_of_medivh"].title = "Book of Medivh"
    e["book_of_medivh"].body = [[
Entry under construction — coming soon.
]]
end

if e["horn_of_cenarius"] then
    e["horn_of_cenarius"].title = "Horn of Cenarius"
    e["horn_of_cenarius"].body = [[
Entry under construction — coming soon.
]]
end

if e["discs_of_norgannon"] then
    e["discs_of_norgannon"].title = "Discs of Norgannon"
    e["discs_of_norgannon"].body = [[
Entry under construction — coming soon.
]]
end

-- ============ CONCEPTS ============

if e["curse_of_flesh"] then
    e["curse_of_flesh"].title = "Curse of Flesh"
    e["curse_of_flesh"].body = [[
Planted by the Old God Yogg-Saron to corrupt the artificial creations of the Titans. The curse spread through the titan-forged races and transformed them into beings of flesh and blood.

That meant that these new races became independent of the orders of their Titan masters, severely weakening their hold on Azeroth. The gnomes, dwarves, troggs, and vrykul were some of these new races.
]]
end

if e["warchief"] then
    e["warchief"].title = "Warchief"
    e["warchief"].body = [[
Entry under construction — coming soon.
]]
end

if e["dragon_queen"] then
    e["dragon_queen"].title = "Dragon Queen"
    e["dragon_queen"].body = [[
Entry under construction — coming soon.
]]
end

if e["keepers"] then
    e["keepers"].title = "Keepers"
    e["keepers"].body = [[
Entry under construction — coming soon.
]]
end

if e["makgora"] then
    e["makgora"].title = "Mak'Gora"
    e["makgora"].body = [[
Entry under construction — coming soon.
]]
end

if e["technology"] then
    e["technology"].title = "Technology"
    e["technology"].body = [[
Entry under construction — coming soon.
]]
end

if e["ancestor_loa_worship"] then
    e["ancestor_loa_worship"].title = "Ancestor and Loa Worship"
    e["ancestor_loa_worship"].body = [[
Entry under construction — coming soon.
]]
end


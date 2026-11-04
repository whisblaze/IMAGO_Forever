-- ============================================================
-- IMAGO Forever — locales/base/data/timeline.lua (enUS fallback)
-- Localized Timeline text: era names, era range labels, and
-- title / yearLabel / body per event slug.
-- Structure (eras, year sort keys, related, stub) lives in
-- data/timeline_static.lua.
--
-- Entries flagged `stub = true` have no body yet — the detail
-- view shows a work-in-progress note instead.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}
IMAGOdb.timeline.events = IMAGOdb.timeline.events or {}

IMAGOdb.timelineEraNames = {
    cosmos         = "Cosmos & the Beginning",
    early_peoples  = "The Early Peoples of Azeroth",
    sundering      = "War of the Ancients & the Sundering",
    kaldorei       = "The Age of the Night Elves",
    kingdoms       = "The Eastern Kingdoms",
    fall_draenor   = "The Fall of Draenor",
    first_war      = "The First War",
    second_war     = "The Second War",
    between_wars   = "Between the Wars",
    third_war      = "The Third War",
    new_order      = "The New World Order",
}

IMAGOdb.timelineEraRanges = {
    cosmos         = "(undated – c. -20,000 DP)",
    early_peoples  = "(c. -16,000 – -12,000 DP)",
    sundering      = "(-10,000 DP)",
    kaldorei       = "(c. -9,300 – -3,000 DP)",
    kingdoms       = "(c. -2,800 – -45 DP)",
    fall_draenor   = "(-12 – -1 DP)",
    first_war      = "(0 – 3 ADP)",
    second_war     = "(4 – 6 ADP)",
    between_wars   = "(7 – 19 ADP)",
    third_war      = "(20 – 21 ADP)",
    new_order      = "(22 – 23 ADP)",
}

local ev = IMAGOdb.timeline.events

-- ============ COSMOS ============

if ev["creation_universe"] then
    ev["creation_universe"].title = "Mythos"
    ev["creation_universe"].yearLabel = "Unknown Date"
    ev["creation_universe"].body = [[
Before the cosmos took shape, there was only the Light, a boundless sea of living energy. But where it spread and its force waned, pockets of cold nothingness remained. These pockets merged with one another and formed a second primal force. The Void is a dark, vampiric power that yearns to devour all things. The mounting tension between these two opposing energies finally erupted in a series of cataclysmic explosions. From them the physical universe was born, also known as the Great Dark Beyond. The most unstable energies coalesced into the chaotic astral dimension of the Twisting Nether.

Shards of fractured Light were hurled through the universe and breathed the spark of life into countless worlds. Most often they gave rise to elemental spirits. But where the broken Light gathered into clouds, the naaru came into being. They swore to protect life. In the fiery cores of a few worlds slumbered the world-souls of future titans. When these colossal beings awoke, they set out in search of others of their kind, determined to bring order to the young universe.
]]
end

if ev["black_empire"] then
    ev["black_empire"].title = "The Black Empire"
    ev["black_empire"].yearLabel = "Unknown Date"
    ev["black_empire"].body = [[
The dark spirits of the Void known as the void lords had long watched the titans of the Pantheon with envy for their power, and they yearned to corrupt one of them. But the noble titans proved impervious to their insidious attempts. So the void lords decided to influence a titan in its most vulnerable state: before it awoke.

In their blind search for slumbering world-souls, the void lords hurled dark creatures through the universe. They blighted every world in their path and came to be known as the Old Gods.

Plummeting from the Great Dark, the Old Gods bored like gigantic parasites deep into Azeroth's crust. Their tendrils crept inexorably toward the world's defenseless heart.

From the organic decay of the Old Gods rose the intelligent n'raqi and the resilient aqir. As loyal servants they henceforth carried out their masters' will. Under the n'raqi's oversight, the aqir raised gigantic temple cities around the bodies of the Old Gods.

From the bastion of mighty Y'Shaarj at the heart of Azeroth, these realms soon spread across the entire planet. The Black Empire was born.

The elemental lords rose against the Black Empire, but the endless masses of n'raqi and aqir shattered them. With the enslavement of the elementals, all of Azeroth sank into an abyss of suffering and death.
]]
end

if ev["ordering_azeroth"] then
    ev["ordering_azeroth"].title = "The Ordering of Azeroth"
    ev["ordering_azeroth"].yearLabel = "c. -147,000 DP"
    ev["ordering_azeroth"].body = [[
On his journeys through the cosmos, the titan Aggramar followed the gentle dreams of a slumbering world-soul and so discovered the world of Azeroth, still unknown to the titans.

Though the Black Empire ruled the surface, Azeroth's world-soul remained uncorrupted. The Pantheon resolved to save it at all costs. Fearing that their gigantic forms might crush the world-soul, the titans created the titan-forged from metal and stone: the metallic race of the aesir and the stone race of the vanir. Some titan-forged became mighty leaders and were granted the powers of the titans. They came to be known as the keepers.

The furious elemental lords assailed the invaders, but the keepers crushed their armies and banished them to a magically fashioned pocket dimension, the so-called Elemental Plane.

When Y'Shaarj began to poison the minds of the titan-forged, it was the titan Aman'Thul himself who tore the Old God from the world's crust with his bare hands. But its deep-rooted tendrils ripped a gaping wound in the surface, and Azeroth's lifeblood spilled forth uncontrollably. To keep the world from destruction, the Pantheon did not slay the remaining Old Gods but had the keepers imprison them deep beneath the earth.

The keepers staunched the escaping lifeblood with magical wards. The calmed energies eventually formed the Well of Eternity, which carried new life across all of Azeroth.

Two mighty titan forges stabilized the world-soul and produced new races of the titan-forged, among them the earthen. The keepers shaped the land and named the flourishing heart continent Kalimdor, the "land of eternal starlight." Before departing, the Pantheon appointed Algalon the Observer as its warden. He was given the authority to activate the Forge of Origination should the world-soul's corruption ever threaten, wiping out all life on Azeroth to cleanse it.
]]
end

if ev["sargeras_fall"] then
    ev["sargeras_fall"].title = "Sargeras' Betrayal"
    ev["sargeras_fall"].yearLabel = "Unknown Date"
    ev["sargeras_fall"].body = [[
When demons from the Twisting Nether invaded the farthest reaches of creation and threatened the Pantheon's search for new world-souls, the titans sent forth their mightiest warrior, the noble Sargeras. He swore not to rest until the universe had been cleansed of all demonic influence.

But defeated demons did not die for good; their spirits returned to the Nether and were reborn in new bodies. So Sargeras forged an escape-proof prison in its depths: Mardum, the Plane of Banishment.

His hunt drew him to a remote corner of the Great Dark, to a black, desiccated world over whose surface the Old Gods swarmed. Their tendrils had burrowed down to its core, and the world-soul within dreamed only dark nightmares.

Interrogated nathrezim (dreadlords) revealed the void lords' plan to him: a corrupted world-soul would awaken as a dark titan whom not even the Pantheon could resist, and who would subject all creation to the will of the Void.

For the first time, the titans' undefeated champion knew fear, for the void lords had sought world-souls just as the Pantheon had, and here they had already consumed theirs. Heavy with sorrow, Sargeras saw but one way to keep the dark titan from awakening. With a single stroke of his blade he split the world and killed its slumbering world-soul.

The Pantheon condemned the deed: together they could have cleansed the soul. But Sargeras was convinced that only a creation burned to ash could escape the void lords. When his kin would not follow him, he left the Pantheon for good, to wage the war against the Void alone.

To stop the void lords, Sargeras tore apart his own prison, Mardum, and unleashed its demons in an explosion of fel magic. Thus was born his army, the Burning Legion.

At Nihilam the Pantheon stood against Sargeras, but it fell: Aggramar died beneath his blade, the other titans in a storm of fel magic. Only their spirits escaped. Norgannon gathered them at the last moment and hurled them into the cosmos.
]]
end

if ev["doom_karesh"] then
    ev["doom_karesh"].title = "The Doom of K'aresh"
    ev["doom_karesh"].yearLabel = "c. -100,000 DP"
    ev["doom_karesh"].body = [[
Once a thriving world of golden deserts and bustling city-states, K'aresh was home to a flourishing civilization. Under the guidance of High Priest Salhadaar and the Council of Oracles, the K'areshi prospered. Yet even as their civilization flourished, a terrible fate was drawing near.

As both suns were extinguished in an instant, Dimensius the All-Devouring descended upon K'aresh, unleashing the Void upon its unsuspecting inhabitants and started the Devouring War. Countless gateways tore open across the planet, flooding its skies and sands with dark energies. The K'areshi had received warnings of the impending catastrophe, but by the time they understood their world's desperate plea, the enemy was already upon them.

Desperate to survive, the K'areshi raised magical shields around their cities, which transformed the Void's corrupting energies into arcane power. The barriers held, but their protection came at a terrible cost. Prolonged exposure to the shields' magic stripped the K'areshi of their physical forms, leaving their souls transformed into beings of pure energy. What should have been the end of their civilization became their only chance at survival. They held Dimensius at bay - until the All-Devouring summoned armies beyond their ability to withstand.

In a final, desperate gambit, a handful of its defenders made an impossible choice to stop Dimensius once and for all. The plan succeeded, scattering fragments of the void lord across the Great Dark Beyond - but at the terrible cost of their home. K'aresh was obliterated, its once-great cities reduced to ruins. In the aftermath, the truth of the planet's downfall faded into legend, leaving its survivors to mourn a world they believed had been lost entirely to the All-Devouring.

As K'aresh crumbled, its people fled into distant realms, eventually becoming the ethereals and brokers. Yet a few refused to abandon their shattered home, becoming the wastelanders who still wandered its desolate remains.
]]
end

if ev["charge_dragonflights"] then
    ev["charge_dragonflights"].title = "The Dragon Aspects"
    ev["charge_dragonflights"].yearLabel = "c. -20,285 DP"
    ev["charge_dragonflights"].body = [[
While Sargeras shattered the Pantheon, new life arose on the ordered world. Among it were the proto-dragons, descended from elementals that had escaped banishment to the Elemental Plane. Galakrond was the largest proto-dragon ever to soar over Azeroth. Driven by insatiable hunger, he even devoured his own kind. The flesh of the dead corrupted him, necrotic rot disfigured his limbs, and dozens of eyes sprouted from his body. Death energies streamed from his hide, raising the dead back to life.

When Tyr, mightiest of all the keepers, recognized the danger, he could not rouse his indifferent siblings to act. So he resolved to face Galakrond alone. He found five extraordinary proto-dragons of different strains who joined him. Under Tyr's leadership, the five proto-dragons defeated Galakrond in the peaks of northern Kalimdor. Galakrond then plunged into what would later become the Dragonblight.

Instead of rebuking his siblings, Tyr convinced them to make the five proto-dragons wardens of Azeroth. Acting as conduits for their creators' powers, the assembled keepers bestowed the Pantheon's blessing upon each proto-dragon. Thus each of the five received the might of a titan, and the Dragon Aspects were born: Nozdormu the Timeless, Alexstrasza the Life-Binder and Dragonqueen, Ysera the Dreamer, Malygos the Spell-Weaver, and Neltharion the Earth-Warder.

To aid the Aspects in their charge, the keepers created a race of their own for them. From magically altered proto-dragon eggs came the five dragonflights in the image of the Aspects: the bronze, the red, the green, the blue, and the black flight. As a symbol of their unity, the keepers raised Wyrmrest Temple in northern Kalimdor.
]]
end

if ev["odyns_halls"] then
    ev["odyns_halls"].title = "Odyn and the Halls of Valor"
    ev["odyns_halls"].yearLabel = "c. -20,200 DP"
    ev["odyns_halls"].body = [[
While the other keepers blessed the proto-dragons, Odyn brooded in the halls of Ulduar. He was the Prime Designate and alone had spoken against the empowerment. To him, dragons were primitive life-forms that could not be entrusted with the fate of the world. Only the titan-forged were fit to be its protectors. But Tyr and the others had prevailed.

Odyn was certain the Aspects would fail. So he decided to create an elite army himself to defend Azeroth. For this he chose the vrykul, whose courage and strength he admired. To him they were the perfect embodiment of the warrior spirit. The other keepers bade him abandon his plan, but Odyn remained unmoved. When none would join him, he declared he would pursue it alone.

He summoned the sorceress Helya, whom he had loved like an adopted daughter through the ages. She wrapped a wing of Ulduar in a mighty spell, tore it from the earth, and lifted it into the clouds. Thus the Halls of Valor were born. From his floating citadel, Odyn proclaimed to all vrykul that the souls of those who fell gloriously in battle would be brought to the Halls and clad in new storm-forged bodies. These champions, the Valarjar, were to serve as Azeroth's foremost guardians.

Yet a way was still needed to guide the souls of the dead to the Halls. Odyn studied the energies of the Shadowlands and found a way to transform vrykul into ghostly val'kyr. These servants walked between the planes and guided the souls of worthy vrykul, but they were cursed to exist as shades forevermore. Since no one volunteered, Odyn resolved to create the val'kyr by force. Helya rebuked him for it and threatened to return the Halls to Ulduar. Blinded by his dream, Odyn shattered her body and remade her spirit into the first val'kyr.

Her scream of pain pierced to the heart of the Shadowlands. Though she hated him from then on, she was bound to his will and created more val'kyr. Over the ages, the Halls filled with Valarjar, whom Odyn trained. He knew no remorse, for in his eyes all of it served the safety of Azeroth.
]]
end

if ev["keepers_fall"] then
    ev["keepers_fall"].title = "The Fall of the Keepers"
    ev["keepers_fall"].yearLabel = "c. -20,000 DP"
    ev["keepers_fall"].body = [[
After the fall of the Pantheon there was silence, and no keeper suffered from it more than Loken. He sought comfort from Sif, the wife of his brother Thorim. Friendship became forbidden love, and love became obsession. When Sif tried to break the bond, Loken struck her down out of jealousy.

But her spirit appeared and forgave him. Heeding her counsel, he blamed the ice giant king Arngrim and unleashed a war of the giants. She also persuaded him to create an army with the Forge of Wills and to chastise Thorim, whereupon Thorim sank into solitude.

When the spirit fell silent and Loken saw a corruption upon his warriors, he pierced the deception: Sif's spirit had never existed. It was an illusion of Yogg-Saron, the Old God imprisoned within Ulduar. Yogg-Saron had poisoned the creation matrix so that every new creation would degenerate into mortal flesh. Thus the curse of flesh came into the world.

Driven by guilt, Loken covered up his deeds and moved against the other keepers. First he won the ghostly val'kyr Helya to his side. She was the adopted daughter of the keeper Odyn and carried the souls of fallen vrykul to the Halls of Valor. She had never forgiven him her forced transformation. For her freedom she sealed the Halls, trapping Odyn and the Valarjar within. Her realm became Helheim.

With Yogg-Saron's power, Loken defeated or corrupted the remaining keepers as well. Only Tyr, Archaedas, and Ironaya eluded him. Highkeeper Ra had already vanished earlier, having learned of the Pantheon's fall. Loken crowned himself supreme keeper and sealed Ulduar, unaware that the Old God beneath him was waking.
]]
end

if ev["winterskorn_war"] then
    ev["winterskorn_war"].title = "The Winterskorn War"
    ev["winterskorn_war"].yearLabel = "c. -20,000 DP"
    ev["winterskorn_war"].body = [[
Some time after Loken's betrayal, the titan-forged banished from Ulduar had scattered across northern Kalimdor. The giants withdrew to the mountains and seas, the earthen dug themselves into the depths, and many vrykul banded together in small clans. A brittle peace reigned between them, but it did not hold. Soon two of Loken's creations stirred: the fire giants Volkhan and Ignis sought to conquer the Storm Peaks around Ulduar, and they needed an army.

Though many vrykul were warlike, most shunned fighting among themselves. Not so the Winterskorn: their faith in ascension to the Halls of Valor had bred a culture of violence. Volkhan and Ignis subjugated the clan. They armed it with enchanted armor and forged weapons that shattered iron and stone.

But as they set out, the metallic skins of the Winterskorn grew brittle; the first symptoms of the curse of flesh showed. Since the vrykul alone no longer sufficed, the two giants fashioned mighty molten golems and iron constructs.

The army marched first against the good-natured earthen and massacred entire caverns. The survivors fled to Tyr, Archaedas, and Ironaya. Tyr led the boldest into skirmishes, his companions built defenses, and together they threw back the Winterskorn.

But the giants created a greater army and enslaved proto-dragon flocks with enchanted snares. The new assault broke the defense. Vrykul and golems hunted the earthen on the ground while proto-dragons swooped down on them from the air. Even Tyr, Archaedas, and Ironaya had to flee before the Winterskorn's fury.

Knowing they could not win alone, Tyr called the five Dragon Aspects to aid. Outraged by the dead titan-forged and the enslaved proto-dragons, they worked in concert as they once had against Galakrond: Alexstrasza held the Winterskorn back with gigantic walls of fire, Malygos drained the constructs of their magic and freed the proto-dragons, while Neltharion raised mountains from the earth that penned in the vrykul and the giants. Finally Ysera and Nozdormu wrapped the Winterskorn in a mist that sent them to sleep. In tomb cities they sank into a slumber lasting millennia, until they awoke as beings of flesh and blood.
]]
end

if ev["tyrs_sacrifice"] then
    ev["tyrs_sacrifice"].title = "Tyr's Sacrifice"
    ev["tyrs_sacrifice"].yearLabel = "c. -20,000 DP"
    ev["tyrs_sacrifice"].body = [[
Tyr knew he could not face Loken directly, so he devised a plan with Archaedas and Ironaya: they would steal the Discs of Norgannon, which had recorded all things, including Loken's treachery. While Tyr drew Loken into a quarrel at the gates of Ulduar, his companions slipped inside and stole the discs.

Beforehand the keepers had gathered the titan-forged around Ulduar: vrykul marked by the curse, most of the earthen, and many mechagnomes. For weeks they marched south. But when Loken noticed the theft, panic seized him: the Pantheon would learn of it, and that would be his death sentence. In desperation he woke the C'Thraxxi Zakazj and Kith'ix, the cruellest generals of the Black Empire. He ordered them to slay Tyr and his followers. They obeyed, for they sensed Yogg-Saron's breath within him.

Far to the south, the C'Thraxxi caught up with the refugees in a quiet glade. Tyr ordered the others to march on while he faced the monstrosities alone. For six days and nights the battle raged until Tyr, his strength spent, released his remaining power in a blinding explosion of arcane energy. He and Zakazj were killed. Kith'ix fled westward, gravely wounded. In honor of their companion, Ironaya named the glade "Tyr's Fall," or in the vrykul tongue "Tirisfal." They buried him beneath his silver hand, and the vrykul stayed behind to guard his tomb.

Archaedas and Ironaya pressed on to Uldaman with the earthen and mechagnomes and built vaults for the discs there. When the earthen were marked by the curse of flesh, they asked for sleep and were sealed away. The mechagnomes, however, stayed awake and watched over the site. In Ulduar, Loken created his own archive, the Tribunal of Ages, and erased his sins. But this distorted history. Finally he rigged the communication devices so that only his own death could still summon Algalon to Azeroth.

While the Winterskorn slept, the Dragonflayer clan dominated the north. When the curse of flesh brought forth deformed children, King Ymiron, who blamed the silent keepers for it, ordered the infants slain. Some mothers could not bring themselves to do it and fled south, to a land they knew only from legends. The vrykul of Tirisfal raised the children as their own, and so the first humans came to be. Though the curse weakened the titan-forged, it also gave rise to courage and heroism, which the Old God had not foreseen. The Dragonflayers too finally sank into slumber to escape the curse.
]]
end

-- ============ EARLY_PEOPLES ============

if ev["twin_empires"] then
    ev["twin_empires"].title = "The Twin Empires"
    ev["twin_empires"].yearLabel = "c. -16,000 DP"
    ev["twin_empires"].body = [[
Gravely wounded by Tyr, Kith'ix fled to the mountains of the southwest and sank into a deep slumber. The loa living there, ghostly Wild Gods, buried him beneath black rock. Millennia later, new intelligent life blossomed in the dense forests around the Well of Eternity. Among the first peoples were the trolls, wild hunters and gatherers who could even regrow lost limbs. What united them was the worship of the loa, whom they saw as gods. Many tribes arose around the sacred mountain range of Zandalar. The mightiest, the Zandalari, built the temple city of Zuldazar. But over the centuries, rival tribes rose: the Gurubashi, the Amani, and the Drakkari.

There was one place forbidden to the tribes: a mound of black stone against which the loa had urgently warned. But curiosity won out. Rebellious trolls dug up the mound and found the jagged hide of a sleeping creature. They took it for an undiscovered loa and roused it with bloody offerings. Kith'ix awoke and slew his wakers. Then Kith'ix called the aqir to him, an insectoid people that had dwelled underground since the fall of the Black Empire. Under his command the insectoids raised the empire of Azj'Aqir. When the swarms had grown large enough, they swept across the land and brought down many lesser troll tribes.

When the aqir drew near the sacred mountains, the feuding tribes united under Zandalari leadership into the Empire of Zul. With ambushes in the jungles and the loa at their side, they threw the insectoids back and gravely wounded Kith'ix. The C'Thrax fled to the northeast. To end the threat, the Zandalari sent the tribes out to hunt him down. The Drakkari marched north and shattered the obsidian destroyers, enslaved tol'vir. The Gurubashi fought the aqir and their anubisath giants at Ahn'Qiraj, the prison of the Old God C'Thun. The Amani pursued Kith'ix and dragged him into death in a suicidal battle. Afterwards they founded the city of Zul'Aman on the battlefield.

Without their master, the aqir lost their bite and their empire crumbled. The survivors turned into three new peoples: in the north arose the nerubians of Azjol-Nerub, near Ahn'Qiraj the qiraji, and in the southeast the mantid. The troll tribes likewise drifted apart without a common enemy. Their fortresses became realms of their own, foremost the twin empires of Zul'Aman of the Amani and Zul'Gurub of the Gurubashi. The Zandalari withdrew to their plateaus and devoted themselves to spiritual knowledge, yet their influence remained immense.
]]
end

if ev["thunder_king"] then
    ev["thunder_king"].title = "The Thunder King"
    ev["thunder_king"].yearLabel = "c. -15,000 DP"
end

if ev["rise_kaldorei"] then
    ev["rise_kaldorei"].title = "The Rise of the Kaldorei"
    ev["rise_kaldorei"].yearLabel = "c. -15,000 DP"
end

if ev["corruption_eredar"] then
    ev["corruption_eredar"].title = "Sargeras Tempts the Eredar"
    ev["corruption_eredar"].yearLabel = "c. -13,000 DP"
end

if ev["pandaria_freed"] then
    ev["pandaria_freed"].title = "The Liberation of Pandaria"
    ev["pandaria_freed"].yearLabel = "c. -12,000 DP"
end

-- ============ SUNDERING ============

if ev["war_ancients"] then
    ev["war_ancients"].title = "The War of the Ancients"
    ev["war_ancients"].aliases = { "Krieg der Ahnen" }
    ev["war_ancients"].yearLabel = "-10,000 DP"
end

if ev["the_sundering"] then
    ev["the_sundering"].title = "The Great Sundering"
    ev["the_sundering"].aliases = { "die Teilung" }
    ev["the_sundering"].yearLabel = "-10,000 DP"
end

if ev["nordrassil_hyjal"] then
    ev["nordrassil_hyjal"].title = "Nordrassil and Illidan's Imprisonment"
    ev["nordrassil_hyjal"].yearLabel = "-10,000 DP"
end

-- ============ KALDOREI ============

if ev["war_satyr"] then
    ev["war_satyr"].title = "The War of the Satyr and the Worgen Curse"
    ev["war_satyr"].yearLabel = "-9,300 DP"
end

if ev["the_long_vigil"] then
    ev["the_long_vigil"].title = "The Long Vigil"
    ev["the_long_vigil"].yearLabel = "-7,300 DP"
end

if ev["founding_quelthalas"] then
    ev["founding_quelthalas"].title = "The Founding of Quel'Thalas"
    ev["founding_quelthalas"].yearLabel = "-6,800 DP"
end

if ev["andrassil_vordrassil"] then
    ev["andrassil_vordrassil"].title = "Vordrassil and the Gnomes"
    ev["andrassil_vordrassil"].yearLabel = "-4,500 / -3,000 DP"
end

-- ============ KINGDOMS ============

if ev["arathor_troll_wars"] then
    ev["arathor_troll_wars"].title = "Arathor and the Troll Wars"
    ev["arathor_troll_wars"].yearLabel = "-2,800 DP"
end

if ev["council_tirisfal"] then
    ev["council_tirisfal"].title = "The Council and Guardians of Tirisfal"
    ev["council_tirisfal"].yearLabel = "-2,680 / -2,610 DP"
end

if ev["awakening_dwarves"] then
    ev["awakening_dwarves"].title = "The Awakening of the Dwarves"
    ev["awakening_dwarves"].yearLabel = "-2,500 DP"
end

if ev["seven_kingdoms"] then
    ev["seven_kingdoms"].title = "The Seven Kingdoms"
    ev["seven_kingdoms"].yearLabel = "-1,200 DP"
end

if ev["war_shifting_sands"] then
    ev["war_shifting_sands"].title = "The War of the Shifting Sands"
    ev["war_shifting_sands"].yearLabel = "-975 DP"
end

if ev["aegwynn_tomb"] then
    ev["aegwynn_tomb"].title = "The Guardian Aegwynn"
    ev["aegwynn_tomb"].yearLabel = "-823 DP"
end

if ev["war_three_hammers"] then
    ev["war_three_hammers"].title = "The War of the Three Hammers"
    ev["war_three_hammers"].yearLabel = "-230 DP"
end

if ev["draenei_draenor"] then
    ev["draenei_draenor"].title = "The Draenei on Draenor"
    ev["draenei_draenor"].yearLabel = "-200 DP"
end

if ev["medivh_born"] then
    ev["medivh_born"].title = "The Birth of Medivh"
    ev["medivh_born"].yearLabel = "-45 DP"
end

-- ============ FALL_DRAENOR ============

if ev["guldan_fel"] then
    ev["guldan_fel"].title = "Kil'jaeden and Gul'dan"
    ev["guldan_fel"].yearLabel = "-12 DP"
end

if ev["horde_forms"] then
    ev["horde_forms"].title = "The Formation of the Horde"
    ev["horde_forms"].yearLabel = "-8 – -6 DP"
end

if ev["draenei_genocide"] then
    ev["draenei_genocide"].title = "The Genocide of the Draenei"
    ev["draenei_genocide"].yearLabel = "-4 – -2 DP"
end

if ev["dark_portal_built"] then
    ev["dark_portal_built"].title = "Dying Draenor and the Portal"
    ev["dark_portal_built"].yearLabel = "-1 DP"
end

-- ============ FIRST_WAR ============

if ev["dark_portal_opens"] then
    ev["dark_portal_opens"].title = "The Horde Enters Azeroth"
    ev["dark_portal_opens"].yearLabel = "0 ADP"
end

if ev["fall_guardian"] then
    ev["fall_guardian"].title = "The Fall of the Guardian"
    ev["fall_guardian"].yearLabel = "3 ADP"
end

if ev["fall_stormwind"] then
    ev["fall_stormwind"].title = "The Fall of Stormwind"
    ev["fall_stormwind"].yearLabel = "3 ADP"
end

-- ============ SECOND_WAR ============

if ev["alliance_lordaeron"] then
    ev["alliance_lordaeron"].title = "The Alliance of Lordaeron"
    ev["alliance_lordaeron"].yearLabel = "4 – 5 ADP"
end

if ev["horde_campaign"] then
    ev["horde_campaign"].title = "The Horde's Campaign"
    ev["horde_campaign"].yearLabel = "6 ADP"
end

if ev["guldan_betrayal"] then
    ev["guldan_betrayal"].title = "Gul'dan's Betrayal"
    ev["guldan_betrayal"].yearLabel = "6 ADP"
end

if ev["siege_blackrock"] then
    ev["siege_blackrock"].title = "The Battle of Blackrock"
    ev["siege_blackrock"].yearLabel = "6 ADP"
end

-- ============ BETWEEN_WARS ============

if ev["sons_of_lothar"] then
    ev["sons_of_lothar"].title = "The Sons of Lothar"
    ev["sons_of_lothar"].yearLabel = "7 – 8 ADP"
end

if ev["birth_lich_king"] then
    ev["birth_lich_king"].title = "Outland and the Lich King"
    ev["birth_lich_king"].yearLabel = "8 ADP"
end

if ev["grim_batol"] then
    ev["grim_batol"].title = "The Battle of Grim Batol"
    ev["grim_batol"].yearLabel = "10 ADP"
end

if ev["war_spider_cult"] then
    ev["war_spider_cult"].title = "The War of the Spider and the Cult of the Damned"
    ev["war_spider_cult"].yearLabel = "10 – 18 ADP"
end

if ev["thrall_new_horde"] then
    ev["thrall_new_horde"].title = "The New Horde"
    ev["thrall_new_horde"].yearLabel = "18 – 19 ADP"
end

-- ============ THIRD_WAR ============

if ev["plague_lordaeron"] then
    ev["plague_lordaeron"].title = "The Plague of Lordaeron"
    ev["plague_lordaeron"].yearLabel = "20 ADP"
end

if ev["frostmourne_claimed"] then
    ev["frostmourne_claimed"].title = "Frostmourne"
    ev["frostmourne_claimed"].yearLabel = "20 ADP"
end

if ev["fall_quelthalas_dalaran"] then
    ev["fall_quelthalas_dalaran"].title = "The Fall of Quel'Thalas and Dalaran"
    ev["fall_quelthalas_dalaran"].yearLabel = "20 ADP"
end

if ev["horde_kalimdor"] then
    ev["horde_kalimdor"].title = "The Horde in Kalimdor"
    ev["horde_kalimdor"].yearLabel = "20 ADP"
end

if ev["battle_hyjal"] then
    ev["battle_hyjal"].title = "The Battle of Mount Hyjal"
    ev["battle_hyjal"].yearLabel = "21 ADP"
end

-- ============ NEW_ORDER ============

if ev["illidan_betrayer"] then
    ev["illidan_betrayer"].title = "Illidan, the Betrayer"
    ev["illidan_betrayer"].yearLabel = "22 ADP"
end

if ev["forsaken_lichking"] then
    ev["forsaken_lichking"].title = "The Forsaken and the New Lich King"
    ev["forsaken_lichking"].yearLabel = "22 ADP"
end

if ev["durotar_founded"] then
    ev["durotar_founded"].title = "The Founding of Durotar"
    ev["durotar_founded"].yearLabel = "23 ADP"
end


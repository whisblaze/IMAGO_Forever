-- ============================================================
-- IMAGO Forever — locales/<locale>/data/zones.lua
-- Localized zone texts. Empty by design — entries go here:
-- IMAGOdb.zones[uiMapID].name / .lore / .aliases / .pointsOfInterest
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.zones = IMAGOdb.zones or {}

IMAGOdb.zones[1453].name = "Stormwind"
IMAGOdb.zones[1453].aliases = { "Stormwind City" }
IMAGOdb.zones[1453].lore = "As the shining beacon to the people of Stormwind and to the Alliance as a whole, Stormwind is a booming city of commerce, with something for everyone. From the wonders of the Arcane in the Mage Quarter, to the skilled smiths and engineers in the Dwarven Quarter, all manner of business can get done here. Don't forget the great Deeprun Tram, created by the Gnomes to connect Ironforge and Stormwind and making easy travel between the two capitals.\n\nWhile Stormwind is well guarded, with soldiers patrolling the streets, that does not mean all is safe. The stockades - prison to the most vicious of criminals - is a dangerous place to venture, so be prepared. Whispers also tell of a great beast swimming in the moats between city sectors. Best stay out of the water lest those rumors be true."
IMAGOdb.zones[1453].pointsOfInterest = {
    {
        name = "Stormwind Keep",
        lore = "The very heart of the capital, this keep, though well protected, is open for all citizens of the alliance. There are many areas, such as the royal libraries, the gardens, and the gallery, that anyone can enter. As home to the royal family and their nobles, there are of course private areas that only those of certain rank are allowed in."
    },
    {
        name = "Valley of Heroes",
        lore = "Erected at the very entrance of Stormwind, this memorial is dedicated to the heroes of the alliance that fought bravely in the Invasion of Draenor. The heroes depicted are General Turalyon, Archmage Khadgar, Ranger Captain Alleria Windrunner, Kurdran Wildhammer, and Danath Trollbane."
    },
    {
        name = "Stormwind Harbor",
        lore = "A new addition to Stormwind, this harbor acts as a central access point for the Alliances new allies, the night elves. With a passenger ship going from here to Auberdine, Darkshore, even inexperienced adventurers can find their way to and from Kalimdor."
    },
}

IMAGOdb.zones[1455].name = "Ironforge"
IMAGOdb.zones[1455].aliases = { "Ironforge City" }
IMAGOdb.zones[1455].lore = [[Carved into the very mountain itself, Ironforge is a grand display of dwarven craftsmanship. The openness of the caverns keep it from feeling too enclosed, and yet there is a cozy air about the city as dwarves live their life filled with boisterious laughter and hearty drinks.

It is a proud city, never having been claimed by the enemy, though many have tried. From demons of the Burning Legion, to the Dark Iron Dwarves, none were able to breech it's sturdy walls!

There are rumors though, that the Dark Iron dwarves have not given up, that they have dug through the very mountain and breeched into the forgotten Old Ironfoge, deep below in the Hall of Thanes. Perhaps this should be looked in to.]]
IMAGOdb.zones[1455].pointsOfInterest = {
    {
        name = "Tinker Town",
        lore = [[Having been displaced from their own city, the gnomes of Gnomeragan were given this quarter of Ironforge to make their home. It houses the entrance to the Deeprun Tram, one of the greatest feats of Gnomish Engineering, which connects Ironforge to Stormwind. Ignore those goblin rumors that the tram is a myth. It's here! Come see it for yourselves!]]
    },
    {
        name = "The Great Forge",
        lore = [[A major landmark of the city, this forge sits in the very center, surrounded by blacksmiths and tradesmen alike. Travelers should be wary when walking in the forge. Dwarves know how to keep their feet study, and thus can easily work around the flowing rivers of lava pouring around, but it can be quite dangerous for people who don't watch their step.]]
    },
    {
        name = "The High Seat",
        lore = [[Where once was the council of three, now stands only one, the Brownzebeard clan. It is here in the High Seat that alliance members can make audience with Magni Bronzebeard, leader of the dwarves. It is here that one can find entrance to the Halls of Thane. Once blocked off, Ironforge has opened the passage to the deep city just to make sure no one can come in from behind.]]
    },
}

IMAGOdb.zones[1426].name = "Dun Morogh"
IMAGOdb.zones[1426].aliases = { "Dun'morogh" }
IMAGOdb.zones[1426].lore = [[At the heart of the Khaz Modan region, surrounded by high mountains, lies Dun'morogh, home to the dwarves and gnomes of the Alliance. The land is filled with harsh snowy winds and rocky mountain hills, hiding rich ores in the land below. Carved into the mountains themselves is the great city of Ironforge, where dwarves and gnomes call home.

Where snow leopards and wolves stalked the forests and bears made their dens, now troggs and trolls have snuck in, trying to take over the land. The hearty alliance members will have none of it though, constantly keeping the invaders in check and their home safe.]]
IMAGOdb.zones[1426].pointsOfInterest = {
    {
        name = "Coldridge Valley",
        lore = [[In an isolated valley in the southern corner of Dun'morogh, dwarven smiths build and work in the enclave of Anvilmar. Trolls and troggs alike have found their way in though and make constant strikes against the citizens of the area. It is here that young dwarves and gnomes seeking adventure are first tested. What better way to start one's journey than by defending your home?]]
    },
    {
        name = "Amberstill Ranch",
        lore = [[Tucked in at the base of the snowy hills of Dun'morogh, between Kharanos and the gate passes of Loch Modan, this ranch holds a special place in dwarven society. It is here that the great rams favored by the Dwarves are raised and tamed. With hand-crafted saddles and fierce training, the Amerstill family works hard to provide sterdy mounts for their people.]]
    },
    {
        name = "Steelgrill's Depot",
        lore = [[Though it's only a small settlement outside the larger town of Kharanos, that doesn't mean the depot is any less busy. It is filled to the brim with miners and engineers alike. It is here the gnomes develop their mechanostrider mounts, wondrous machines that can stand alongside any ram of Ironforge or steed of Stormwind. It is here that plans are being made to take back the city of Gnomeregan…]]
    },
}

IMAGOdb.zones[1420].name = "Tirisfal Glades"
IMAGOdb.zones[1420].aliases = { "Tirisfal", "Tirisfall Glades" }
IMAGOdb.zones[1420].lore = [[Not even twenty years ago, the mighty kingdom of Lordaeron beat back the orcish Horde in this myth-rich land named after the great Titan Keeper Tyr, who himself vanquished an ancient evil many ages ago. There were few nations like Lordaeron, the undisputed leader of the Alliance, and the populace flourished under the rule of King Terenas II. Then the land was razed by the Scourge, betrayed by its own crown prince, and the once-beautiful land succumbed to death.

The gloomy, perpetually sickly sky reminds everyone each day of what was lost. Flora and fauna desperately cling to life on the plagued soil, but it is Lordaeron's citizens who have changed the most. The undead walk this forsaken kingdom, and the few who regained what remains of their minds have joined the Banshee Queen in an attempt at a new beginning. Rejected by the Alliance for what they have become, the Forsaken have now become part of the Horde. Under a new banner and new leadership, Lordaeron's fallen soldiers will defend the ruins of their new old home.]]
IMAGOdb.zones[1420].pointsOfInterest = {
    {
        name = "The Scarlet Monastery",
        lore = [[The Church of the Holy Light was powerful here when this kingdom was still alive, and the undead are an affront to that holiness. That is what the Scarlet Crusade believes, and their priests and paladins make no distinction between Forsaken and Scourge. Led by High Inquisitor Whitemane and Commander Mograine, the cathedral marks the order's stronghold and poses the most prevalent threat to the Forsaken.]]
    },
    {
        name = "Bandarion Keep",
        lore = [[Formerly a military outpost of the Argent Dawn, the keep recently came into the hands of the Tyr's Watch and was renamed in honor of the first Forsaken paladin: Garek Bandarion. New undead paladins train and meditate here and come to terms with their paradoxical existence. The Argent Dawn is still welcome here and, unlike the Scarlet Crusade, sees the Forsaken for what they are: people trying to survive.]]
    },
    {
        name = "Brill",
        lore = [[Between the mass graves of Deathknell and the haunted Agamand Mills lies a peaceful little town. Peaceful by Forsaken standards, anyway. It is now a place of respite for adventurers in these parts and fortified well enough to ward off the Scarlets, yet in some way, Brill is where the doom of the land started. The necromancer Kel'Thuzad began his experiments with the plague of undeath here, marking the beginning of the Scourge of Lordaeron.]]
    },
}

IMAGOdb.zones[1429].name = "Elwynn Forest"
IMAGOdb.zones[1429].aliases = { "Elwynn" }
IMAGOdb.zones[1429].lore = [[Filled with lush farmlands, clear lakes, and rich mines, Elwynn Forest is the picture of comfort and serenity. It is no wonder it is a thriving landscape. It sits just to the south of the Burning Steppes, where the volcanic ash helps furtilize the nearby landscapes. So futile and beautiful is the land that the humans of Stormwind made settlement here and it is here their civilization has thrived. During the First War, orcs laid siege to Elwynn, desecrating towns and destroying all they could. That would not be enough. The land has flourished and the humans have rebuilt their settlements better than ever.

The human capital of Stormwind sits just northwest of the forest, so Elwynn is well guarded. Travelers can often find soldiers patrolling the roads and towns gaurded by knights. A good thing too, seeing as how not all is peaceful in these forests. While the wild life of boars, bears, and wolves cause their own problems, it is the rising threat of the Defias Brotherhood that is the true danger. Civil unrest has caused some citizens to turn from their peaceful farming and logging ways. Bandits hide amongst the trees, and though the Marshalls do their best to keep control, they are always looking for more recruits.]]
IMAGOdb.zones[1429].pointsOfInterest = {
    {
        name = "Tower of Azora",
        lore = [[A strange tower sitting in the center of Elwynn Forest. It hosues many gnomes who call themselves the servants of Azora, all headed by the human archmage Theocritus. Though young Enchanters can find tutelage here, the tower's main focus seems to be keeping an eye on it's rival Tower of Ilgalar in Redridge Mountains. The servants of Azora use magical means to scry on Morganth, the leader of Ilgalar. There is still some mystery as to why the Tower of Azora seems so intent on the Tower of Ilgalar, and yet lets the rest of Elwynn deal with it's own problems.]]
    },
    {
        name = "Northshire Abbey",
        lore = [[This abby was once the home to the Clerics of Northshire, who later joined the Knights of the Silver Hand. The abbey housed many rare tomes and librems that the Clerics tried their best to keep safe. During the First War, it was destroyed by the orcs in their invasion of Elwynn, but like the rest of the forest, it too was rebuilt to greater strength. Now it is used as a recruitment site for any curious adventurers. It's library is still the target of Defias Theives, and so the abbey needs defenders. Who better than young humans eager to prove themselves?]]
    },
    {
        name = "Eastvale Logging Camp",
        lore = [[A key logging export for the Kingdom of Stormwind, this camp sits on the eastmost side of Elwynn, bordering the Redridge Mountains. The lumber gathered from here helps support many of the kingdom's ventures. Eastvale is not just a simple logging camp, though. It is also home to the tamers of Stormwind's great steeds. These horses are used for the great soldiers of the alliance. Only those who have proven themselves to Stormwind can be permitted to learn from Eastvale's trainers.]]
    },
}

IMAGOdb.zones[1438].name = "Teldrassil"
IMAGOdb.zones[1438].lore = [[With the destruction of the Wold Tree Hyjal, after the Second Invasion of the Burning Legion, Azeroth needed a new World Tree, or so thought the Night Elves. Led by Archdruid Fandral Staghelm, the druids planted a new seed just off the coast of northern kalimdor. It grew into the mighty 'Crown of the Earth', Teldrassil, and became home for all night elves in their new capital, Darnassus.

It was meant to replace Hyjal, to give the elves their immortality back, and yet… though it grew swiftly, it fell to corruption just as fast. This great tree is now a sign of the Night Elves arrogance, to demand their eternal life back so soon after they had given it up. Though it has fallen into shadow, the night elves still call it home and do what they can to keep it safe.

Local creatures such as furbolgs, grell, and even the plants themselves, have been corrupted. It is the duty of the elves to keep them in check, culling and pruning as needed to try to keep Teldrassil safe and the darkness at bay.]]
IMAGOdb.zones[1438].pointsOfInterest = {
    {
        name = "Shadowglen",
        lore = [[Surrounded by high roots and mountains, this glade is home to Aldrassil - a great tree sprouting from Teldrassil itself. Many young night elves find themselves starting their journey here as they are taught about the corruption in their lands and how they must keep it at bay.]]
    },
    {
        name = "Rut'theran Village",
        lore = [[Sitting on the very edges of the roots of Teldrassil lies this small fishing village. It is the Night Elf's one point of ground access to their home, creating quite the barrier of entry for enemies. A portal stands ever open for entry into Darnassus, with only a single ship route bringing visitors in from Auberdine, Darkshore.]]
    },
    {
        name = "Ban'ethil Barrow Den",
        lore = [[Once a sacred resting place created to host the sleeping druids of the talon, the site is now overrun by corrupted furblogs. The Gnarlpine have invaded so deeply that any lone Night Elf will find it hard to venture into these once hallowed dens.]]
    },
}

IMAGOdb.zones[1411].name = "Durotar"
IMAGOdb.zones[1411].lore = [[Dry, red sands broken up by treacherous canyons, sharp cacti, and watering holes filled with crocolisks – this desert was hardly an ideal place for a new faction to settle. Yet Thrall led his people here, knowing that the harsh landscape would remind the orcs of their destroyed home of Draenor and serve as an emphasis of the need to atone for their actions during the First and Second Wars on Azeroth. The land was named after Durotan, Thrall's father and former chieftain of the Frostwolf Clan.

The orcs and trolls call this land home now, but tauren, Forsaken, and, more recently, the Windshapers are welcome visitors as well. Despite its harshness, a great sense of unity and companionship can be felt here. Most members of the new Horde simply want to live a peaceful and quiet life, and in Durotar, they are unlikely to be disturbed.]]
IMAGOdb.zones[1411].pointsOfInterest = {
    {
        name = "The Valley of Trials",
        lore = [[Young orcs and trolls who wish to prove themselves as valuable members of the Horde must undergo several rites of passage, and this valley is their proving ground. From culling boars and scorpids to rooting out lesser demons of the Burning Blade Clan, every Horde adventurer has gone through the drill.]]
    },
    {
        name = "The Echo Isles",
        lore = [[The Darkspear were nearly wiped out during the Third War, and the Echo Isles off the coast of Durotar were meant to become their new home. After fending off sea giants and fighting tooth and nail to defend the islands against Admiral Daelin Proudmoore, the trolls eventually lost them to one of their own. Zalazane and his undead slaves rule this place now, and have forced the Darkspear to evacuate.]]
    },
    {
        name = "Tiragarde Keep",
        lore = [[What remains of Daelin Proudmoore's loyal expeditionary force now mans this fortress in the very heart of enemy territory. These Kul Tiran soldiers have sworn to continue fighting the Horde in retaliation for both the Second War and the death of Admiral Daelin. Jaina, Thrall's human friend and a daughter of Kul Tiras herself, disapproves of what is happening here, but her influence over her homeland's politics has been severely limited since the Third War, to put it mildly.]]
    },
}

IMAGOdb.zones[1412].name = "Mulgore"
IMAGOdb.zones[1412].lore = [[Protected by high mountains on all sides, Mulgore's grassy plains are filled to the brim with life. Kodos, tallstriders, and prairie wolves live between the mesas in the fields below, the natural wildlife in the area. While it may seem peaceful at a glance, various centaur clans and tauren tribes fight over who has rightful claim over the land. The tauren have managed to gain their foothold, building the great city of Thunderbluff to overlook the area, but that won't stop their enemies from trying to take it back.

Though the centaurs are their biggest threat, Mulgore has also been infested by another race - quilboars. Having been driven away from Durotan by the orcs, these 'boar men' found their way in from the one of the few entrances to the grassy lands, connected to the Barrens to the east. Though it's only a minor concern, the tauren are certainly keeping their eye on the plains and those who dare tred on their sacred lands.]]
IMAGOdb.zones[1412].pointsOfInterest = {
    {
        name = "Camp Narache",
        lore = [[Found in the southern end of Mulgore, this Camp sits atop the edge of Red Cloud Mesa. It is home to the Hawkwind Tribe, a family who has dedicated their members towards helping young tauren with their training and helping keep the quilboar population under control.]]
    },
    {
        name = "Skywatcher Plateau",
        lore = [[Once known as Stontalon pass, a simple pathway between the Stonetalon Mountains and Desolace, Skywatcher Plateau now holds ports for the Horde's newest allies, the Windshaper Skyborne. Camp Gev'rek sits atop the plateau and welcomes all who travel the winds.]]
    },
    {
        name = "Bloodhoof Village",
        lore = [[Named after Cairne Bloodhoof and his tribe, this village is one of the few permanent settlements made down in the valley, differing from the taurens' usual tradition of making their homes on the upper flats of the mesas.  It is here kodo are raised and trained to become mounts for the tauren people. Baine Bloodhoof, son of the tuaren cheiften, leads the village and keeps it running smoothly, protecting it from the various dangers that Mulgore holds.]]
    },
}

IMAGOdb.zones[1454].name = "Orgrimmar"
IMAGOdb.zones[1454].lore = [[The rustic warrior city and capital of the New Horde was constructed in a relatively short time after Warchief Thrall settled in Durotar following the Third War. Orgrimmar is well-fortified, with high towers and heavy gates, and naturally protected by the mountain range into which it was built. Originally, Thrall wanted to make the city as peaceful as possible, without even considering the need for military defenses. Daelin Proudmoore's attack on the half-finished settlement and its inhabitants quickly changed his mind, however.

So while the Horde indeed needed to remain a military power, that doesn't mean that only soldiers dwell in Orgrimmar. Zeppelins provide transport to and from other Horde settlements, and the city has quickly become a center of trade for all Horde races. Despite its intimidating exterior, Orgrimmar has proven far more hospitable than many might have expected.]]
IMAGOdb.zones[1454].pointsOfInterest = {
    {
        name = "Grommash Hold",
        lore = [[The imposing keep in the heart of the city is where the Warchief holds court and passes judgment. It is not adorned with riches or baubles, but is instead built in a rough and simple style. Before entering, visitors are greeted by a monument to the orcs' final triumph over their demonic corruption: the skull and armor of the pit lord Mannoroth, displayed prominently for all to see before the hold.]]
    },
    {
        name = "Cleft of Shadows",
        lore = [[The demonic practices of the warlocks were a major factor in the Horde's descent into corruption on Draenor. While Thrall has not outlawed the use of Fel magic, the remaining warlocks prefer to dwell in the caves beneath Orgrimmar, away from prying eyes. The entrance to the tunnel system of Ragefire Chasm can also be found here, and rumors of Burning Blade activity aimed at destroying Orgrimmar from within have been growing louder recently.]]
    },
    {
        name = "The Ring of Valor",
        lore = [[Orgrimmar's gladiatorial arena seems to have been built with the typical Horde philosophy in mind: a place where warriors can fight one another for glory and the amusement of the crowds. Alas, the coliseum is not intended for daily spectacles, but instead serves as a training ground for new recruits and as the battlefield of choice for a Mak'gora, should one be invoked.]]
    },
}

IMAGOdb.zones[1457].name = "Darnassus"
IMAGOdb.zones[1457].aliases = { "Darnassus City" }
IMAGOdb.zones[1457].lore = [[Though it is newly created compared to the likes of Stormwind or Ironforge, Darnassus makes it place as a capital of the night elves by being a perfect example of their life style and acts as a symbol of their continued survival after the third war. Most buildings are built directly into the living trees, hollowed out enough for business and trade, but alive and growing still. The city sits on the edge of a lake with bridges spanning over the waters, like vines tying it all together.

Though it lives in peace with nature, that does not make it defenseless. Night elven sentinels patrol it's roads elite warriors trained to protect their people. Not only that, but ancient protectors and ancients of war walk the streets and place their roots in the city, acting as nature's guardians alongside their night elven allies.]]
IMAGOdb.zones[1457].pointsOfInterest = {
    {
        name = "Temple Gardens",
        lore = [[While many night elves might wander here for peace and to walk amongst the flowing waters, for most visitors, this will be the first sight of Darnassus they see. Kept open for all hours during peaceful times, it is here that a portal to Rut'theran Village rests and creates the only way for grounded travelers to leave the great boughs of Teldrassil.]]
    },
    {
        name = "Temple of the Moon",
        lore = [[Unlike a majority of Darnassus' buildings, this temple was made from stone brought from outside Teldrassil to make sure it lasts through time.  It is the headquarters of the Sisterhood of Elune, priestesses dedicated to the moon goddess, Elune. Tyrande, head priestess of the night elves, can be found here and welcome any who seek Elune's guidance.]]
    },
    {
        name = "Cenarion Enclave",
        lore = [[As the Temple of the Moon is home to the priestesses of the night elves, so to is the Cenarion Enclave home to the druidic practices of Darnassus. Archdruid Staghelm stands here and guides his people in their duties. The enclave is also where night elves can find the tamed nightsabers used as mounts for those who have shown true loyalty to Darnassus.]]
    },
}

IMAGOdb.zones[1458].name = "Undercity"
IMAGOdb.zones[1458].lore = [[Before the fall of the human kingdom of Lordaeron, there lay the Undercity. It's chambers acted as tombs and dungeons for the kingdom above. After Arthas and the Scourge attacked, he intended to make the catwcombs his new bastion for the undead, but was unable to do so before leaving for Northrend. Sylvanas Windrunner, free from the hold of the Lich King, took her Forsaken members and captured it for her own purposes, turning the twisting halls into a proper city for her people.

Though it is a stronghold of the Horde, due to the poisonous fumes and toxic sludge that fill the caverns, living creatures have a hard time navigating the area. Instead, it is the perfect haven for the Forsaken undead, with its dark and cold halls giving them a sanctuary away from those who would see the undead destroyed.]]
IMAGOdb.zones[1458].pointsOfInterest = {
    {
        name = "Apothecarium",
        lore = [[Home to the Royal Apothecary Society, this sanctum is where the Forsaken develope their plagues and poisons. Since the Forsaken have no means of repopulation, they must instead turn to their own plague to continue their people's existence. It is also here that Forsaken medicine is studied due to their unique body structure.]]
    },
    {
        name = "Runis of Lordaeron",
        lore = [[Where once it was a mighty capital, now all that remains is broken stone and lost spirits. Some can still hear the haunting cries of the dead, whispering on the wind. Adventurers that make their way here might find remnants of the Scourge left by Arthas. Even if the Undercity is already under Horde control, best kill these creatures before they cause too much trouble.]]
    },
    {
        name = "The Royal Quarter",
        lore = [[Hidden away in the back of the Undercity, these quarters are where Sylvanas Windrunner lead her people. The elite Royal Dreadguards keep all who enter under observation. It is said there are secret passageways hidden here and throughout the entire city, and only the Banshee Queen knows of them to their fullest intent.]]
    },
}


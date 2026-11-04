-- ============================================================
-- IMAGO Forever — locales/deDE/data/races.lua (deDE localized)
-- Race dossier texts generated from the design documents.
-- Static records (IDs, figures, settlements, group keys)
-- live in data/races_static.lua.
-- figureText: name = display name, role/aff = member table
-- columns (Rolle | Zugehörigkeit), title = legacy combined.
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}


-- ============================================================
-- ALLIANCE
-- ============================================================

local f = IMAGOdb.races["human"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Menschen"
    f.groupTabLabel = "Königreiche"
    f.quote = { text = "Rache darf kein Teil dessen sein, was wir zu tun haben. Wenn wir zulassen, dass unsere Leidenschaften in Blutgier umschlagen, werden wir so verkommen wie die Orcs.", author = "Uther Lichtbringer" }
    f.overview = "Die Menschen sind ein widerstandsfähiges Volk Azeroths, das von den barbarischen Halbriesen der Vrykul aus Nordend abstammt. Obwohl sie zu den jüngeren Völkern der Welt gehören, sind sie jeder Herausforderung mit Standhaftigkeit begegnet. Ihre Fähigkeit, sich anzupassen und wiederaufzubauen, hat sie zu einer entscheidenden Kraft in einer sich wandelnden Welt gemacht. Seit dem Fall Lordaerons ist das Königreich Sturmwind die stärkste Bastion der Menschheit und führt die Allianz der Völker an."
    f.facts = {
        faction = "Allianz",
        capital = "Sturmwind",
        leader = "Kindkönig Anduin Wrynn, Regent Bolvar Fordragon (König Varian verschollen)",
        mount = "Pferd",
        language = "Gemeinsprache",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "PALADIN" }, { classFile = "PRIEST" }, { classFile = "MAGE" }, { classFile = "WARLOCK" }, { classFile = "ROGUE" }, { classFile = "HUNTER" } }
    f.history = [[Die Menschen stammen von den Vrykul ab, barbarischen Halbriesen aus Nordend, die selbst titangeschmiedet waren. Etwa 15.000 Jahre vor dem Dunklen Portal brachten Frauen des Drachenschinder-Klans durch den Fluch des Fleisches kleine, missgestaltete Kinder zur Welt. König Ymiron erklärte sie zu Missgeburten und ordnete ihre Tötung an, doch einige Eltern versteckten sie bei einem Vrykul-Stamm in den Tirisfal-Ländereien. Über die Zeitalter entarteten diese Kinder zu sterblichen Wesen, den Menschen. Jahrtausende lang florierten verstreute Stämme in den Östlichen Königreichen, bekriegten sich untereinander und kämpften gegen die Waldtrolle der Amani; ihre Herkunft geriet in Vergessenheit.

Die Menschheit trat in die Geschichte während der Trollkriege von 2.800 vDP. Der Arathi-Stamm unter Kriegsherr Thoradin einte die Stämme zum Imperium Arathor, der ersten großen menschlichen Zivilisation. Die bedrängten Hochelfen von Quel'Thalas lehrten einhundert Menschen die Arkanmagie im Tausch für militärische Hilfe, und gemeinsam zerschlugen sie die Trolle. Arathors Stadtstaaten wurden immer selbstständiger, bis das Reich um 1.200 vDP in die Sieben Königreiche zerbrach: Gilneas, Alterac, Dalaran und Lordaeron im Norden, Kul Tiras im Südwesten und Sturmwind im fernen Süden. Die alte Hauptstadt Strom wurde zu Stromgarde.

Das Unglück kam, als die orcische Horde das Dunkle Portal öffnete und Sturmwind im Ersten Krieg verwüstete. Die Überlebenden flohen nach Norden, und die Sieben Königreiche einten sich zur Allianz von Lordaeron, die die Horde im Zweiten Krieg besiegte. Dann dezimierte eine Pestilenz Lordaeron, und der verderbte Prinz Arthas Menethil hetzte die Geißel gegen sein eigenes Königreich; auch Dalaran fiel. Die Menschheit überlebte den Dritten Krieg am Berg Hyjal um einen schrecklichen Preis. Seither steht Sturmwind als letzte große Bastion der Menschheit, wieder aufgebaut und neu geordnet. In Lordaeron schmiedeten sich die Reste der Silbernen Hand zum fanatischen Scharlachroten Kreuzzug, während sich die Argentumdämmerung als gemäßigteres Gegenstück formierte, und die überlebenden Magier versiegelten Dalarans Ruinen unter einer magischen Kuppel.]]
    f.culture = [[Die Menschen sind ein von Natur stolzes und ehrgeiziges Volk, zeitweise siegessicher bis zur Überheblichkeit, doch ebenso fähig zu noblen, selbstlosen Taten. Sie leben in Dörfern, Städten und großen lebendigen Städten. Das Landvolk baut und schürft vor den Mauern, Händler und Handwerker füllen die Straßen, und der Adel herrscht von seinen Burgen. Ihre Lebensspanne ist kurz; vielleicht umarmen Menschen deshalb Risiko und Mut so bereitwillig. Sie sind geübte Seefahrer; Kul Tiras befehligt die größte Flotte Azeroths. Ihre Weisheiten: „Wer nicht aus der Geschichte lernt, ist verdammt, sie zu wiederholen." „Kenne deinen Feind." „Schlafen kann man auch im Grab."

Die herrschende Religion ist der Glaube an das Heilige Licht, das frühen menschlichen Priestern nach den Trollkriegen durch die Naaru offenbart wurde. Die Kirche des Heiligen Lichts lenkt nahezu alle menschlichen Gesellschaften, ihr kämpferischer Arm ist der Orden der Silbernen Hand. In Kul Tiras verehren die Seeleute die Gezeitenmutter, und die Gezeitenweisen segnen jedes Schiff; im abgeschiedenen Gilneas überleben die alten animistischen Wege bei den Erntehexen. Die Menschen tragen auch dunklere Glaubensformen: den Kult der Verdammten, den Schattenhammer und die verborgenen Hexenmeister-Enklaven wie jene unter Sturmwinds Geschlachtetem Lamm.]]
    f.relationsIntro = "Geradlinig und offen kommen die Menschen mit anderen Völkern aus und gewinnen ihr Vertrauen mit relativer Leichtigkeit. Ihre wahre Stärke liegt darin, über die eigenen Interessen hinauszublicken und diplomatische Lösungen zu suchen. Die Menschen gründeten die Allianz, und ohne sie könnte sie nicht bestehen."
    f.relations = {
        { name = "Eisenschmiedezwerge", text = "Der engste und natürlichste Verbündete der Menschen seit den Tagen des Imperiums Arathor. Beide Völker teilen seit Langem die Geheimnisse der Metallbearbeitung und des Ingenieurwesens und entdeckten eine gemeinsame Liebe für Kampf und Geschichtenerzählen. Als die Allianz Eisenschmiede im Zweiten Krieg von der Alten Horde befreite, gelobten die Zwerge, eine Schuld zu tragen, die nie beglichen werden könne." },
        { name = "Wildhammerzwerge", text = "Eine freundschaftliche Bindung seit dem Zweiten Krieg, als die Menschen sie vor den Orcs retteten; die dankbaren Zwerge traten der Allianz bei und unterstützen sie seitdem mit ihren Greifenreitern." },
        { name = "Gnome", text = "Die Menschen achten das gnomische technische Können und die unerschütterliche Treue der Gnome zur Allianz hoch, und viele leihen den Gnomen im fortwährenden Kampf um Gnomeregan ihre Hilfe." },
        { name = "Elfen", text = "Eine Quelle von Geheimnis und Frustration, vor allem die exotischen Nachtelfen, mit denen sie verbündet sind. Dennoch achten die Menschen die Bemühungen der Nachtelfen, die natürliche Schönheit Azeroths wiederherzustellen und zu bewahren, vor allem die Arbeit des Zirkels des Cenarius in den Pestländern." },
        { name = "Orcs", text = "Der erste Kontakt kam im Ersten Krieg, als die orcische Horde Sturmwind zerstörte und eine Feindschaft schuf, die bis heute währt. Obwohl einige Anführer wie Jaina Prachtmeer Frieden geschlossen haben, hegt die große Mehrheit der Menschheit einen starken Groll wegen der an ihnen verübten Greueltaten." },
        { name = "Trolle", text = "Eine alte Feindschaft aus den vielen Kriegen seit der Geburt des Imperiums Arathor; besonders das Volk Stromgardes führt eine bittere Fehde mit den Amani." },
        { name = "Verwandtschaft", text = "Menschen sind bekannt dafür, selten Ehen mit anderen Völkern einzugehen, vor allem mit Hochelfen: Alodi, der erste Wächter von Tirisfal, war ein Halbelf; der Paladin Turalyon ehelichte die Waldläuferin Alleria Windläufer; Rhonin, der Anführer der Kirin Tor, ihre Schwester Vereesa." },
    }
    f.groupsIntro = "Die Sieben Königreiche zum Jahr 25:"
    f.groups["stormwind"] = { name = "Sturmwind", lore = "Die stärkste Bastion der Menschheit; wiederaufgebaut, führt die Allianz." }
    f.groups["lordaeron"] = { name = "Lordaeron", lore = "Im Dritten Krieg zerstört; seine Ruinen umkämpft von Geißel und Verlassenen." }
    f.groups["dalaran"] = { name = "Dalaran", lore = "Unter einer Arkan-Kuppel versiegelt; die Kirin Tor bauen darin wieder auf." }
    f.groups["kul_tiras"] = { name = "Kul Tiras", lore = "Isoliert seit dem Tod des Großadmirals Prachtmeer." }
    f.groups["gilneas"] = { name = "Gilneas", lore = "Hinter dem Graumähnenwall zurückgezogen." }
    f.groups["stromgarde"] = { name = "Stromgarde", lore = "Zerfallen seit König Thoras' Ermordung; die Feste von Syndikat und Ogern belagert." }
    f.groups["alterac"] = { name = "Alterac", lore = "Für seinen Verrat vernichtet; seine Reste dem Syndikat verfallen." }
    f.groups["theramore"] = { name = "Theramore", lore = "Jainas junge Inselnation auf Kalimdor." }
    f.groupsFootnote = "Orden: Kirche des Heiligen Lichts · Ritter der Silbernen Hand · Kirin Tor · Scharlachroter Kreuzzug · Argentumdämmerung · das Syndikat · die Defiasbruderschaft · der Kult der Verdammten · der Schattenhammer."
    f.figureText["varian_wrynn"] = { name = "Varian Wrynn", role = "Verschollener König Sturmwinds", aff = "Sturmwind, Allianz", title = "Verschollener König Sturmwinds — Sturmwind, Allianz" }
    f.figureText["anduin_wrynn_forever"] = { name = "Anduin Wrynn", role = "Kindkönig unter Regentschaft Bolvar Fordragons", aff = "Sturmwind, Allianz", title = "Kindkönig unter Regentschaft Bolvar Fordragons — Sturmwind, Allianz" }
    f.figureText["llane_wrynn"] = { name = "Llane Wrynn", role = "Ehemaliger König, von Garona ermordet", aff = "Sturmwind", title = "Ehemaliger König, von Garona ermordet — Sturmwind" }
    f.figureText["anduin_lothar"] = { name = "Anduin Lothar", role = "Lordregent, Oberbefehlshaber der Allianz von Lordaeron", aff = "Allianz von Lordaeron", title = "Lordregent, Oberbefehlshaber der Allianz von Lordaeron — Allianz von Lordaeron" }
    f.figureText["turalyon"] = { name = "Turalyon", role = "Paladin, Heerführer der Allianz-Expedition", aff = "Silberne Hand", title = "Paladin, Heerführer der Allianz-Expedition — Silberne Hand" }
    f.figureText["terenas_menethil_ii"] = { name = "Terenas Menethil II.", role = "Letzter wahrer König Lordaerons", aff = "Lordaeron", title = "Letzter wahrer König Lordaerons — Lordaeron" }
    f.figureText["arthas_menethil"] = { name = "Arthas Menethil", role = "Verderbter Prinz; nun Lichkönig in Nordend", aff = "Geißel", title = "Verderbter Prinz; nun Lichkönig in Nordend — Geißel" }
    f.figureText["calia_menethil"] = { name = "Calia Menethil", role = "Prinzessin Lordaerons, im Verborgenen", aff = "Lordaeron", title = "Prinzessin Lordaerons, im Verborgenen — Lordaeron" }
    f.figureText["uther_the_lightbringer"] = { name = "Uther Lichtbringer", role = "Erster Paladin, Oberkommandant der Silbernen Hand", aff = "Silberne Hand", title = "Erster Paladin, Oberkommandant der Silbernen Hand — Silberne Hand" }
    f.figureText["genn_greymane"] = { name = "Genn Graumähne", role = "König von Gilneas hinter dem Wall", aff = "Gilneas", title = "König von Gilneas hinter dem Wall — Gilneas" }
    f.figureText["darius_crowley"] = { name = "Darius Crowley", role = "Gilnearischer Lord", aff = "Gilneas", title = "Gilnearischer Lord — Gilneas" }
    f.figureText["daelin_proudmoore"] = { name = "Daelin Prachtmeer", role = "Ehemaliger Großadmiral von Kul Tiras", aff = "Kul Tiras", title = "Ehemaliger Großadmiral von Kul Tiras — Kul Tiras" }
    f.figureText["jaina_proudmoore"] = { name = "Jaina Prachtmeer", role = "Herrscherin von Theramore", aff = "Theramore", title = "Herrscherin von Theramore — Theramore" }
    f.figureText["bolvar_fordragon_forever"] = { name = "Bolvar Fordragon", role = "Regent Sturmwinds", aff = "Sturmwind", title = "Regent Sturmwinds — Sturmwind" }
    f.figureText["alexandros_mograine"] = { name = "Alexandros Mograine", role = "Erster Träger der Aschenbringer", aff = "Silberne Hand", title = "Erster Träger der Aschenbringer — Silberne Hand" }
    f.figureText["tirion_fordring_forever"] = { name = "Tirion Fordring", role = "Paladin im Exil in den Pestländern", aff = "Argentumdämmerung", title = "Paladin im Exil in den Pestländern — Argentumdämmerung" }
    f.figureText["aegwynn"] = { name = "Aegwynn", role = "Vorletzte Wächterin von Tirisfal, in Theramore", aff = "Theramore", title = "Vorletzte Wächterin von Tirisfal, in Theramore — Theramore" }
    f.figureText["medivh"] = { name = "Medivh", role = "Letzter Wächter von Tirisfal, Meister Karazhans", aff = "Karazhan", title = "Letzter Wächter von Tirisfal, Meister Karazhans — Karazhan" }
    f.figureText["khadgar"] = { name = "Khadgar", role = "Magier der Allianz-Expedition", aff = "Söhne Lothars", title = "Magier der Allianz-Expedition — Söhne Lothars" }
    f.figureText["antonidas"] = { name = "Antonidas", role = "Ehemaliger Anführer der Kirin Tor", aff = "Kirin Tor", title = "Ehemaliger Anführer der Kirin Tor — Kirin Tor" }
    f.figureText["rhonin"] = { name = "Rhonin", role = "Anführer der Kirin Tor", aff = "Kirin Tor", title = "Anführer der Kirin Tor — Kirin Tor" }
    f.figureText["thoras_trollbane"] = { name = "Thoras Trollbann", role = "Ehemaliger König Stromgardes", aff = "Stromgarde", title = "Ehemaliger König Stromgardes — Stromgarde" }
    f.figureText["galen_trollbane"] = { name = "Galen Trollbann", role = "Prinz über den Rest Stromgardes", aff = "Stromgarde", title = "Prinz über den Rest Stromgardes — Stromgarde" }
    f.figureText["danath_trollbane"] = { name = "Danath Trollbann", role = "Force-Commander der Söhne Lothars", aff = "Söhne Lothars", title = "Force-Commander der Söhne Lothars — Söhne Lothars" }
    f.figureText["reginald_windsor"] = { name = "Reginald Windsor", role = "Marschall von Sturmwind", aff = "Sturmwind", title = "Marschall von Sturmwind — Sturmwind" }
    f.figureText["mathias_shaw"] = { name = "Mathias Shaw", role = "Direktor des SI:7", aff = "SI:7", title = "Direktor des SI:7 — SI:7" }
    f.figureText["aiden_perenolde"] = { name = "Aiden Perenolde", role = "Ehemaliger König Alteracs, Verräter", aff = "Alterac", title = "Ehemaliger König Alteracs, Verräter — Alterac" }
    f.figureText["edwin_van_cleef"] = { name = "Edwin van Cleef", role = "Anführer der Defiasbruderschaft", aff = "Defiasbruderschaft", title = "Anführer der Defiasbruderschaft — Defiasbruderschaft" }
    f.figureText["alonsus_faol"] = { name = "Alonsus Faol", role = "Ehemaliger Erzbischof", aff = "Kirche des Heiligen Lichts", title = "Ehemaliger Erzbischof — Kirche des Heiligen Lichts" }
    f.figureText["archbishop_benedictus"] = { name = "Erzbischof Benedictus", role = "Oberhaupt der Kirche des Heiligen Lichts", aff = "Kirche, Sturmwind", title = "Oberhaupt der Kirche des Heiligen Lichts — Kirche, Sturmwind" }
    f.figureText["archmage_arugal"] = { name = "Erzmagier Arugal", role = "Magier in Burg Shadowfang", aff = "Kirin Tor", title = "Magier in Burg Shadowfang — Kirin Tor" }
    f.figureText["othmar_garithos"] = { name = "Othmar Garithos", role = "Ehemaliger Kommandant der Allianz-Resistance", aff = "Allianz-Resistance", title = "Ehemaliger Kommandant der Allianz-Resistance — Allianz-Resistance" }
    f.figureText["saidan_dathrohan"] = { name = "Saidan Dathrohan", role = "Großkreuzzügler (heimlich Balnazzar)", aff = "Scharlachroter Kreuzzug", title = "Großkreuzzügler (heimlich Balnazzar) — Scharlachroter Kreuzzug" }
    f.figureText["aedelas_blackmoore"] = { name = "Aedelas Schwarzmoor", role = "Ehemaliger Kommandant der Internierungslager", aff = "Lordaeron", title = "Ehemaliger Kommandant der Internierungslager — Lordaeron" }
    f.figureText["maxwell_tyrosus"] = { name = "Maxwell Tyrosus", role = "Anführer der Argentumdämmerung", aff = "Argentumdämmerung", title = "Anführer der Argentumdämmerung — Argentumdämmerung" }
end

f = IMAGOdb.races["dwarf"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Zwerge"
    f.groupTabLabel = "Klans"
    f.quote = { text = "Wenn es etwas gibt, das Zwerge lieben, dann ist es Trinken. Und Kämpfen. Zwei Dinge.", author = "Zinnbecher" }
    f.overview = "Die Zwerge sind ein uraltes, kühnes und mutiges Volk, das von den Irdischen abstammt und in große Klans gespalten ist. Die Bronzebärte Eisenschmiedes beherrschen die Berge Khaz Modans; die Wildhammer nisten auf dem Nistgipfel im Hinterland; die Dunkeleisen brüten in der Schattenschmiede unter dem Schwarzfels. Klein und stämmig sind sie Meister der Schmiede, und wenn der Ruf zur Schlacht erschallt, erheben sie sich mit unübertroffenem Mut. Unter König Magni Bronzebart bleiben die Zwerge die treuesten Freunde, die die Allianz hat."
    f.facts = {
        faction = "Allianz (Eisenschmiede); Wildhammer freundlich, aber außerhalb der neu formierten Allianz; Dunkeleisen feindlich",
        leader = "König Magni Bronzebart",
        mount = "Widder (Greif bei den Wildhammern)",
        language = "Zwergisch, Gemeinsprache",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "PALADIN" }, { classFile = "PRIEST" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" } }
    f.history = [[Die Zwerge stammen von den Irdischen ab, titangeschmiedeten Wesen aus lebendigem Stein, geformt in der Schmiede des Willens. Nach dem Verrat des Hüters Loken, der die Schmiede mit dem Fluch des Fleisches verderbte, führte Hüter Tyr die Befallenen gen Süden nach Uldaman. Als der Fluch sie übermannte, baten die meisten Irdischen um Schlaf, bis ein Heilmittel gefunden sei. Zeitalter später erwachten sie als Fleisch und nannten sich Zwerge. In Erinnerung an ihren Schöpfer nannten sie ihr Land Khaz Modan, „Berg von Khaz", rangen es den Eistrollen ab und erbauten unter den Bergen die mächtige Eisenschmiede. Um 2.500 vDP freundeten sie sich mit den Gnomen der nahen Höhlen an, und um 1.200 vDP stießen die Expeditionen von Gilneas und Alterac erstmals auf sie. Menschen und Zwerge verbanden sich rasch über Kampf, Geschichten und starkes Bier, und die Menschen brachten ihnen das Heilige Licht.

In jener Ära lebten drei große Klans in Eisenschmiede unter Hochkönig Modimus Ambossmar: die Bronzebärte, Herren über Militär und Handel; die Wildhammer, zähe Bergsteiger der Vorgebirge; und die ränkeschmiedenden Dunkeleisen der Familie Thaurissan. Als Modimus starb, brach Bürgerkrieg aus. Die siegreichen Bronzebärte behielten Dun Morogh, die Wildhammer zogen nach Grim Batol, die Dunkeleisen gründeten Thaurissan im Rotkammgebirge. Jahre später schlugen die Dunkeleisen beide Reiche zugleich. Zauberthan Thaurissan wurde an Eisenschmiede zurückgeworfen, während seine Frau Modgud Grim Batols Tore brach, ehe sie Than Khardros fiel; ihre Magie ließ die Feste für immer verflucht zurück. Als die Sieger auf seine Hauptstadt marschierten, rief Thaurissans Hass den Feuerfürsten Ragnaros in die Welt. Die Verwüstung vernichtete sein Reich und zeichnete den Norden zu Brennender Steppe und Sengender Schlucht. Die Dunkeleisen wurden als Sklaven des Feuerfürsten in die Schattenschmiede geschleppt. Die heimatlosen Wildhammer siedelten auf dem Nistgipfel im Hinterland, und die Thandol-Brücke wurde als Schwur errichtet, dass die Klans nie wieder die Waffen gegeneinander erheben würden.

In den Großen Kriegen standen die Zwerge an der Seite der Menschen. Die Horde mahlte durch Khaz Modan, brach aber an Eisenschmiede, und die befreiten Königreiche traten der Allianz von Lordaeron bei. Kurdran Wildhammers Greifenreiter zogen den Nistgipfel in die Allianz, und als der Krieg endete, flog Kurdran mit den Söhnen Lothars durch das Dunkle Portal. Während des Dritten Kriegs kämpften Zwerge aus Eisenschmiede und Nistgipfel gegen die Geißel in Lordaeron, Nordend und Kalimdor; Magni selbst schmiedete den Aschenbringer für Hochlord Alexandros Mograine. Als Gnomeregan an die Troggs fiel, nahm Magni die gnomischen Flüchtlinge auf. In jüngster Zeit, getrieben von Ruinen, die auf ein verlorenes Erbe deuten, lenkt Magni die Industrie seines Volkes zur Archäologie, und die Forscherliga gräbt nun nach der Wahrheit zwergischer Ursprünge.]]
    f.culture = [[Die Zwerge sind ein zähes Volk, tief in Tradition verwurzelt, mit Vorliebe für Kampf, Erkundung und gutes Bier. Was ihnen an Größe fehlt, gleichen sie mit Herz aus. Alle Zwerge sind stur und bewundern Tapferkeit; lieber sterben sie kämpfend, als als Sklaven zu leben. Sie nennen sich „das Erdvolk", lesen im Gestein die Richtung der Tunnel und bewahren die Affinität ihrer Ahnen zu Steinwerk, Bergbau und Edelsteinkunst. Blut wird im Klan gezählt, dem Kern zwergischer Identität. Das tiefste aller Bande ist Gwyarbrawden, der Schwur von Kriegern, den Tod des anderen um jeden Preis zu rächen, ein Brauch, den kaum ein Außenstehender kennt.

Zwerge lieben Gold und Trank, also liegt ihnen das Würfelspiel im Blut: Kaum einer reist ohne Knochenwürfel, und „die Knochen rollen" schlichtet Streit. Ihr Tisch trägt deftige Kost mit reichlich Bier: Haggis und Eisenschmiede-Pale-Ale, Gewürzbrot, Eberfleisch, Thelsamars Blutwürste und Saibling. Im Glauben folgen die meisten Zwerge Eisenschmiedes dem von den Menschen gelehrten Heiligen Licht in der Halle der Mysterien. Älter noch ist die Verehrung des Titanenvaters Khaz'goroth, die im Winterhauchfest fortlebt. Die Wildhammer praktizieren Schamanismus; die versklavten Dunkeleisen beteten Ragnaros einst als Halbgott an. Bronzebärte misstrauen Hexenmeistern; ein zwergischer Hexenmeister ist eine Anomalie. Sie bestatten ihre Toten in der Erde und betten ihre Helden neben ihren Greifen. Ihre Eide schwören auf Bärte und Hämmer: „Bei Magnis Bart", „Madorans Hammer". Ein altes Sprichwort mahnt: „Willst du eine Mauer stürzen, fang beim Fundament an."]]
    f.relations = {
        { name = "Gnome", text = "„Vettern\" durch gemeinsame titangeschmiedete Abstammung; die Zwerge lehrten Steinarbeit und halfen Gnomeregan zu gründen, die Gnome lehrten Wissenschaft und Ingenieurwesen. Nach der Trogg-Katastrophe nahm Magni die Flüchtlinge in Eisenschmiede auf." },
        { name = "Menschen", text = "Verbündete seit den Tagen Arathors; die Glocken der Kathedralen von Hauptstadt und Sturmwind wurden in Eisenschmiede als Zeichen der Freundschaft gegossen. Als die Allianz die Belagerung der Horde im Zweiten Krieg brach, gelobten die Zwerge eine Schuld, die sie nie zurückzahlen könnten. Magni hält sie noch immer." },
        { name = "Die Klans untereinander", text = "Thandol-Brücke und Monument im Tal der Könige geloben, nie wieder gegeneinander zu kämpfen. Die versklavten Dunkeleisen in der Schattenschmiede brüten über ihrem Hass auf die übrigen ihresgleichen." },
        { name = "Die Horde", text = "Khaz Modan erinnert die Invasion; die Zwerge hegen den alten Groll gegen die Orcs." },
    }
    f.groups["bronzebeard_clan"] = { name = "Bronzebartklan", lore = "Herrscher von Eisenschmiede und Dun Morogh, der größte Klan; geführt von König Magni Bronzebart." }
    f.groups["wildhammer_clan"] = { name = "Wildhammerklan", lore = "Die Greifenreiter des Nistgipfels, noch der Natur verbunden; geführt von Falstad Wildhammer. Außerhalb der neu formierten Allianz, aber freundlich." }
    f.groups["dark_iron_clan"] = { name = "Dunkeleisenklan", lore = "Nachfahren von Thaurissans Reich, Ragnaros in der Schattenschmiede versklavt; beherrscht von Imperator Dagran Thaurissan." }
    f.groups["stormpike_clan"] = { name = "Sturmlanzenklan", lore = "Kämpft im Alteractal gegen die Frostwolf-Orcs; geführt von Vanndar Sturmlanze." }
    f.groups["explorers_league"] = { name = "Die Forscherliga", lore = "Magnis Orden der Archäologen, der die Geheimnisse zwergischer Ursprünge ausgräbt; geführt von Brann Bronzebart." }
    f.groupsFootnote = "- Kleinere Klans: Roms dezimierter Klan, die Wildhammer-Familien von Northeron und den Highlands, die in Grim Batol verfluchten Skardyn; fern im Norden die Frostartigen Zwerge der Sturmgipfel."
    f.figureText["modimus_anvilmar"] = { name = "Modimus Ambossmar", role = "Letzter Hochkönig aller Zwerge vor dem Krieg der Drei Hämmer", aff = "Eisenschmiede", title = "Letzter Hochkönig aller Zwerge vor dem Krieg der Drei Hämmer — Eisenschmiede" }
    f.figureText["madoran_bronzebeard"] = { name = "Madoran Bronzebart", role = "Than der Bronzebärte im Krieg der Drei Hämmer", aff = "Bronzebartklan", title = "Than der Bronzebärte im Krieg der Drei Hämmer — Bronzebartklan" }
    f.figureText["king_magni_bronzebeard_forever"] = { name = "Magni Bronzebart", role = "König von Eisenschmiede", aff = "Allianz, Bronzebartklan", title = "König von Eisenschmiede — Allianz, Bronzebartklan" }
    f.figureText["muradin_bronzebeard"] = { name = "Muradin Bronzebart", role = "Mittlerer Bronzebart-Bruder, auf Expedition in Nordend", aff = "Bronzebartklan", title = "Mittlerer Bronzebart-Bruder, auf Expedition in Nordend — Bronzebartklan" }
    f.figureText["brann_bronzebeard"] = { name = "Brann Bronzebart", role = "Anführer der Forscherliga", aff = "Forscherliga", title = "Anführer der Forscherliga — Forscherliga" }
    f.figureText["moira_thaurissan"] = { name = "Moira Thaurissan", role = "Tochter Magnis, Gemahlin Kaiser Dagrans", aff = "Dunkeleisenklan", title = "Tochter Magnis, Gemahlin Kaiser Dagrans — Dunkeleisenklan" }
    f.figureText["thargas_anvilmar"] = { name = "Thargas Ambossmar", role = "Verteidiger der Thandol-Brücke, letzter Nachfahre Modimus'", aff = "Eisenschmiede", title = "Verteidiger der Thandol-Brücke, letzter Nachfahre Modimus' — Eisenschmiede" }
    f.figureText["hjalmar_anvilmar"] = { name = "Hjalmar Ambossmar", role = "Älterer Bruder Thargas'", aff = "Eisenschmiede", title = "Älterer Bruder Thargas' — Eisenschmiede" }
    f.figureText["baelgun_flamebeard"] = { name = "Baelgun Flammenbart", role = "Anführer der Reste von Muradins Nordend-Expedition", aff = "Forscherliga", title = "Anführer der Reste von Muradins Nordend-Expedition — Forscherliga" }
    f.figureText["high_priest_rohan"] = { name = "Hohepriester Rohan", role = "Hohepriester in der Halle der Mysterien", aff = "Eisenschmiede", title = "Hohepriester in der Halle der Mysterien — Eisenschmiede" }
    f.figureText["vanndar_stormpike"] = { name = "Vanndar Sturmlanze", role = "General der Sturmlanzen-Garde", aff = "Sturmlanzenklan", title = "General der Sturmlanzen-Garde — Sturmlanzenklan" }
    f.figureText["hemet_nesingwary"] = { name = "Hemet Nesingwary", role = "Weltberühmter Jäger", aff = "Unabhängig", title = "Weltberühmter Jäger — Unabhängig" }
    f.figureText["rom"] = { name = "Rom", role = "Helfer Rhonins bei der Befreiung Alexstraszas", aff = "Allianz von Lordaeron", title = "Helfer Rhonins bei der Befreiung Alexstraszas — Allianz von Lordaeron" }
    f.figureText["thane_korthazz"] = { name = "Than Korth'azz", role = "Gefallener Paladin, Todesritter in Naxxramas", aff = "Geißel", title = "Gefallener Paladin, Todesritter in Naxxramas — Geißel" }
    f.figureText["khardros_wildhammer"] = { name = "Khardros Wildhammer", role = "Hochthan der Wildhammer im Krieg der Drei Hämmer", aff = "Wildhammerklan", title = "Hochthan der Wildhammer im Krieg der Drei Hämmer — Wildhammerklan" }
    f.figureText["falstad_wildhammer"] = { name = "Falstad Wildhammer", role = "Herrscher des Nistgipfels", aff = "Wildhammerklan", title = "Herrscher des Nistgipfels — Wildhammerklan" }
    f.figureText["kurdran_wildhammer"] = { name = "Kurdran Wildhammer", role = "Greifenreiter-Held, mit den Söhnen Lothars durchs Portal", aff = "Söhne Lothars", title = "Greifenreiter-Held, mit den Söhnen Lothars durchs Portal — Söhne Lothars" }
    f.figureText["sorcerer_thane_thaurissan"] = { name = "Zauberthan Thaurissan", role = "Imperator der Dunkeleisen, rief Ragnaros", aff = "Dunkeleisenklan", title = "Imperator der Dunkeleisen, rief Ragnaros — Dunkeleisenklan" }
    f.figureText["modgud"] = { name = "Modgud", role = "Gemahlin Thaurissans, verfluchte Grim Batol", aff = "Dunkeleisenklan", title = "Gemahlin Thaurissans, verfluchte Grim Batol — Dunkeleisenklan" }
    f.figureText["emperor_dagran_thaurissan"] = { name = "Kaiser Dagran Thaurissan", role = "Regent der Dunkeleisen in der Schattenschmiede", aff = "Dunkeleisenklan", title = "Regent der Dunkeleisen in der Schattenschmiede — Dunkeleisenklan" }
    f.figureText["franclorn_forgewright"] = { name = "Franclorn Schmiedebinder", role = "Ehemaliger Chefarchitekt, Erbauer von Schwarzfelsturm und Steinschmieddamm", aff = "Dunkeleisenklan", title = "Ehemaliger Chefarchitekt, Erbauer von Schwarzfelsturm und Steinschmieddamm — Dunkeleisenklan" }
end

f = IMAGOdb.races["gnome"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Gnome"
    f.groupTabLabel = "Orden"
    f.quote = { text = "Ich habe Thermadraht vertraut. Ich hätte nie vermutet, dass er mich und das ganze Gnomenvolk verraten würde. ... Jetzt sind wir aus unserer Heimat verdrängt worden und dieser Wahnsinnige ist dafür verantwortlich. Der König des Nichts... Wir werden Gnomeregan zurückerobern. Wir werden nicht ruhen, bis die Stadt wieder unter unserer Kontrolle steht.", author = "Hochtüftler Mekkadrill" }
    f.overview = "Die klugen, frechen und oft exzentrischen Gnome stellen ein einzigartiges Paradoxon unter den zivilisierten Völkern Azeroths dar. Brillante Erfinder mit unbezähmbar fröhlichem Wesen haben sie Verrat, Vertreibung und fast einen Völkermord erlitten. Ihr bemerkenswerter Optimismus angesichts dieser Katastrophe verkörpert ihren unerschütterlichen Geist. Aus dem verstrahlten Gnomeregan von Troggs und Verrat vertrieben, leben die Überlebenden nun bei ihren zwergischen Vettern im Tüftlerviertel von Eisenschmiede, geführt von Hochtüftler Gelbin Mekkadrill."
    f.facts = {
        faction = "Allianz",
        capital = "Gnomeregan (verloren, verstrahlt); jetziger Sitz: Tüftlerviertel, Eisenschmiede",
        leader = "Hochtüftler Gelbin Mekkadrill",
        mount = "Roboschreiter",
        language = "Gnomisch, Gemeinsprache",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "ROGUE" }, { classFile = "MAGE" }, { classFile = "WARLOCK" }, { classFile = "PRIEST" } }
    f.history = [[Die Gnome stammen von den Mechagnomen ab, kleinen Uhrwerkwesen, geschmiedet vom Wächter Mimiron. Nach Lokans Verrat zur Instandhaltung Uldamans zurückgelassen, erlagen auch sie dem Fluch des Fleisches, entarteten zu Wesen aus Fleisch und verließen die Hallen etwa 3.000 Jahre vor dem Dunklen Portal. Die ersten Gnome schlugen sich ein Dasein in den schneeigen Bergen westlich von Uldaman, überlebten Eistrolle und die Elemente durch Hingabe an die Technik und hatten binnen weniger Generationen jede Erinnerung an ihr titangeschmiedetes Erbe verloren. Um 2.500 vDP fanden die einziehenden Zwerge sie und halfen beim Grundstein Gnomeregans. Das Gnomkönigreich industrialisierte sich in Frieden. Ihre Arkanisten waren bemerkenswert: Indus saß im Gründungsrat von Tirisfal, und Erbag diente ihm zu Aegwynns Zeiten. Ihr letzter König, Mechagon, führte vor vierhundert Jahren Gefolgsleute fort auf der Suche nach einem sagenhaften Land der Technik; seither wählen die Gnome ihre Hochtüftler nach Verdienst.

Als die Horde im Zweiten Krieg in Khaz Modan einfiel, hielten Zwerge und Gnome die Pässe gemeinsam. Gnomeregans Eisentor und teuflische Fallen bremsten die Belagerung, bis Lothar beide befreite, und die Gnome vergalten es der Allianz mit U-Booten, Flugmaschinen und motivierten Truppen, womit sie eine bis heute währende Technikrivalität mit den Goblins entfachten. Danach entwarf Hochtüftler Mekkadrill die Tiefenbahn zwischen Eisenschmiede und Sturmwind, und als die Allianz um das Jahr 18 zerbröckelte, bekräftigte er die Treue der Gnome zu König Terenas.

Dann kam die Katastrophe, die sie brach. Während Lordaeron fiel, brachen brutale Troggs unter Gnomeregan hervor und wühlten Tunnel durch die unteren Ebenen. Mekkadrill hielt sie fünf Jahre lang zurück, ohne die bedrängte Allianz um Hilfe zu bitten, bis sein vertrauter Berater Sicco Thermadraht vorschlug, die untere Stadt mit giftiger Strahlung zu fluten, mit gefälschten Daten und dem Versprechen, Filter würden das Volk schützen. Der Hochtüftler stimmte zu. Das Gas tötete die Troggs nicht, während versagende Filter es in gnomische Wohnungen dringen ließen. Binnen Tagen waren fast achtzig Prozent des Gnomvolks verendet. Mekkadrill führte die Überlebenden nach Eisenschmiede, wo Magni Bronzebart ihnen das Tüftlerviertel gewährte. Der Hochtüftler hat seither einen sofortigen Rückeroberungsversuch abgelehnt und das Schicksal der Gnome an die moderne Allianz gebunden, während das volle Ausmaß von Thermadrahts Verrat nur langsam ans Licht kommt.]]
    f.culture = [[Die Gnome sind ein ehrgeiziges Volk, das Kreativität und Handwerk feiert und dessen Leben sich in der meisterhaften Beherrschung der Naturgesetze bewährt. Bemitleidet zu werden ist ihnen unerträglich. Sie waren stets eher Gelehrte als Krieger und gleichen fehlende Kraft mit Erfindungsgeist und Kühnheit aus, und kein Gnom kann einem Rätsel widerstehen. Seit dem Fall Gnomeregans hat die Not sie abgehärtet: Gnomische Nahkämpfer werden häufiger, und Gnome widersprechen den „Großwüchsigen" bereitwilliger denn je. Einzigartig unter den Völkern hatten sie keine Geschichte innerer Gewalt, weshalb sie die Monarchie vor Jahrhunderten ablegten und ihre Anführer nach dem Nutzen ihrer Arbeit für das Volk wählen. Thermadrahts Verrat traf umso schockierender.

Sie sprechen Gnomisch und Gemeinsprache und sind berühmte Mechaniker, Ingenieure und Techniker, die die Allianz mit ihren fortschrittlichsten Waffen, Artillerie und Kriegsmaschinen beliefern. Im Glauben interessierten sie sich lange für das Heilige Licht, doch Technik und das Schicksal Gnomeregans gingen stets vor. Genug werden von dunkleren Pfaden angezogen, dass gnomische Schurken und Hexenmeister nichts Ungewöhnliches sind.]]
    f.relations = {
        { name = "Zwerge", text = "Die Vettern und engsten Freunde der Gnome seit der ersten Begegnung; jeder lehrte den anderen sein Handwerk. Nach der Trogg-Katastrophe öffnete Magni ihnen Eisenschmiedes Tore, und Zwerge bleiben ihre größte Stütze im Traum, Gnomeregan zurückzugewinnen." },
        { name = "Menschen", text = "Befreier des Zweiten Kriegs; die Gnome gelobten Dankbarkeit und rüsten die Armeen der Allianz seither aus. Gnomische Magier hatten stets Sitze in den Kirin Tor; Indus war Gründungsmitglied des Rats von Tirisfal." },
        { name = "Nachtelfen", text = "Trotz ihres Arkanhandwerks werden Gnome auf kaldorei Gebiet geduldet; Ingenieure und Pioniere aus dem Tüftlerviertel helfen den Schildwachen in Eschental." },
        { name = "Goblins", text = "Eine technologische Rivalität aus dem Zweiten Krieg, als Goblin-Geräte der Horde dienten; beide Völker beanspruchen die Krone des Einfallsreichtums, und Gnome halten Goblin-Technik für grob." },
        { name = "Dunkeleisenzwerge", text = "Feinde als Verbündete des Feindes ihrer Vettern; Agenten der Schattenschmiede wurden mit Thermadraht im gefallenen Gnomeregan verflochten gefunden." },
        { name = "Orcs", text = "Als Opfer der Invasion der Alten Horde misstrauen die Gnome den Orcs und ihren Verbündeten noch immer tief." },
    }
    f.groups["kingdom_of_gnomeregan_in_exile"] = { name = "Königreich Gnomeregan im Exil", lore = "Der Rat tagt neu im Tüftlerviertel unter Hochtüftler Mekkadrill. Sein Kurs: keine waghalsige Rückeroberung, Technik für die Allianz zuerst." }
    f.groups["thermapluggs_court"] = { name = "Thermadrahts Hof", lore = "Der Verräter versiegelte sich als selbsternannter „König von Gnomeregan\" in den verstrahlten Tiefen; die Lepragnome der gefallenen Stadt gehorchen seinem Wahnsinn." }
    f.groups["gnomeregan_covert_ops"] = { name = "Gnomeregan-Geheimdienst", lore = "Der Ausspäharm der Gnome, Agenten in allerlei Allianzangelegenheiten aktiv." }
    f.groups["kirin_tor"] = { name = "Die Kirin Tor", lore = "Gnomische Arkanisten hatten stets Sitze in Dalarans Orden." }
    f.groups["leper_gnomes"] = { name = "Lepragnome", lore = "Die von der Strahlung an Geist und Körper verdrehten Überlebenden, an Thermadrahts Wahnsinn gefesselt." }
    f.figureText["high_tinker_mekkatorque_forever"] = { name = "Gelbin Mekkadrill", role = "Hochtüftler von Gnomeregan, im Exil im Tüftlerviertel", aff = "Königreich Gnomeregan, Allianz", title = "Hochtüftler von Gnomeregan, im Exil im Tüftlerviertel — Königreich Gnomeregan, Allianz" }
    f.figureText["sicco_thermaplugg"] = { name = "Sicco Thermadraht", role = "Verräter Gnomeregans, selbsternannter „König\" in den Tiefen", aff = "Gnomeregan (abtrünnig)", title = "Verräter Gnomeregans, selbsternannter „König\" in den Tiefen — Gnomeregan (abtrünnig)" }
    f.figureText["indus"] = { name = "Indus", role = "Magierin von Dalaran, Gründungsmitglied des Rats von Tirisfal", aff = "Rat von Tirisfal", title = "Magierin von Dalaran, Gründungsmitglied des Rats von Tirisfal — Rat von Tirisfal" }
    f.figureText["erbag"] = { name = "Erbag", role = "Mitglied des Rats von Tirisfal zu Aegwynns Zeiten", aff = "Rat von Tirisfal", title = "Mitglied des Rats von Tirisfal zu Aegwynns Zeiten — Rat von Tirisfal" }
    f.figureText["king_mechagon"] = { name = "König Mechagon", role = "Letzter König der Gnome, vor 400 Jahren verschwunden", aff = "Königreich Gnomeregan", title = "Letzter König der Gnome, vor 400 Jahren verschwunden — Königreich Gnomeregan" }
    f.figureText["tinkmaster_overspark"] = { name = "Tinkmaster Overspark", role = "Chefarchitekt der gnomischen Ingenieurskunst", aff = "Gnomeregan", title = "Chefarchitekt der gnomischen Ingenieurskunst — Gnomeregan" }
    f.figureText["brink_spannercrank"] = { name = "Brink Spannercrank", role = "Assassine und SI:7-Agent", aff = "SI:7", title = "Assassine und SI:7-Agent — SI:7" }
    f.figureText["kelsey_steelspark"] = { name = "Kelsey Steelspark", role = "Agentin der Gnomeregan-Geheimdienste", aff = "Gnomeregan Covert Ops", title = "Agentin der Gnomeregan-Geheimdienste — Gnomeregan Covert Ops" }
    f.figureText["pip_quickwit"] = { name = "Pip Quickwit", role = "Erfinder und Entdecker", aff = "Unabhängig", title = "Erfinder und Entdecker — Unabhängig" }
    f.figureText["millhouse_manastorm"] = { name = "Millhouse Manastorm", role = "Mächtiger Magier zweifelhafter Loyalität", aff = "Unabhängig", title = "Mächtiger Magier zweifelhafter Loyalität — Unabhängig" }
    f.figureText["narain_soothfancy"] = { name = "Narain Soothfancy", role = "Pensionierter Ingenieur, nun Wahrsager in Tanaris", aff = "Unabhängig", title = "Pensionierter Ingenieur, nun Wahrsager in Tanaris — Unabhängig" }
    f.figureText["oglethorpe_obnoticus"] = { name = "Oglethorpe Obnoticus", role = "Verstoßener Mekingenieur in Beutebucht", aff = "Unabhängig", title = "Verstoßener Mekingenieur in Beutebucht — Unabhängig" }
    f.figureText["silas_darkmoon"] = { name = "Silas Darkmoon", role = "Gründer und Leiter des Dunkelmond-Jahrmarkts", aff = "Dunkelmond-Jahrmarkt", title = "Gründer und Leiter des Dunkelmond-Jahrmarkts — Dunkelmond-Jahrmarkt" }
    f.figureText["j_d_collie"] = { name = "J.D. Collie", role = "Forscherin der Machtkristalle im Krater von Un'Goro", aff = "Unabhängig", title = "Forscherin der Machtkristalle im Krater von Un'Goro — Unabhängig" }
    f.figureText["linken"] = { name = "Linken", role = "Held des Kraters von Un'Goro", aff = "Unabhängig", title = "Held des Kraters von Un'Goro — Unabhängig" }
    f.figureText["doctor_weavil"] = { name = "Doktor Weavil", role = "Anführer untoter „Drohgnome\" auf Insel Alcaz", aff = "Unabhängig", title = "Anführer untoter „Drohgnome\" auf Insel Alcaz — Unabhängig" }
end

f = IMAGOdb.races["night_elf"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Nachtelfen"
    f.groupTabLabel = "Fraktionen"
    f.quote = { text = "Dunkelheit hüllte uns am Anfang ein, und wir konnten nicht sehen. Wir schrien nach Führung, und der Mond schien hell auf uns herab. Sein sanftes Licht erhellte nicht nur die Nacht für uns, es gab auch Trost.", author = "Tyrande Wisperwind" }
    f.overview = "Die Kaldorei, die „Kinder der Sterne\", sind eine der ältesten und langlebigsten Kulturen, die es gibt. Einst herrschten sie über ein Magie-Imperium, das das alte Kalimdor umspannte, und zehntausend Jahre lang dienten sie als selbsternannte Wächter der Natur und des Weltenbaums. Der Dritte Krieg kostete sie ihre Unsterblichkeit, als Nordrassil geopfert wurde, um Archimonde zu vernichten. Nun haben sie von ihrer jungen Stadt Darnassus in den Zweigen des ungesegneten Weltenbaums Teldrassil die Lange Wache beendet und sind der Allianz beigetreten."
    f.facts = {
        faction = "Allianz",
        capital = "Darnassus, auf Teldrassil",
        leader = "Hohepriesterin Tyrande Wisperwind (Erzdruide Malfurion liegt in unerklärtem Koma; Fandral Hirschhaupt führt die Druiden)",
        mount = "Nachtsäbler",
        language = "Darnassisch, Gemeinsprache",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "PRIEST" }, { classFile = "ROGUE" }, { classFile = "DRUID" } }
    f.history = [[Vor etwa fünfzehntausend Jahren ließ sich ein Stamm dunkler Trolle, der sich nach Frieden sehnte, am schimmernden Wasser des Brunnens der Ewigkeit nieder. Die kosmische Kraft des Brunnens durchdrang sie, und sie wurden zu intelligenten, nahezu unsterblichen Wesen, die sich Kaldorei nannten, Kinder der Sterne, und begannen, die Mondgöttin Elune zu verehren. Geleitet vom Halbgott Cenarius florierten sie; dann, zur Arkanen hingezogen, errichteten sie um den Brunnen ein Imperium der Wunder unter der geliebten Königin Azshara und ihren hochmütigen Hochgeborenen.

Als die rücksichtslosen Experimente der Hochgeborenen arkane Energie in den Wirbelnden Nether strömen ließen, antwortete Sargeras. Als Gott verkleidet überredete er Azshara und ihren Berater Xavius, ein Portal für seine Brennende Legion zu öffnen. Widerstand formierte sich um Malfurion Sturmgrimm, den ersten Druiden, Tyrande Wisperwind und Lord Kur'talos Rabenkrone. Als der Brunnen implodierte, ertränkte die Große Zerschlagung Kontinente und riss Azsharas Getreue als Naga in die Tiefe.

Die Überlebenden kehrten der Arkanmagie für immer den Rücken. Auf dem Berg Hyjal goss Illidan Sturmgrimm heimlich Phiolen des alten Brunnens in einen See, einen zweiten Brunnen der Ewigkeit, und wurde gefangen, weil er seine Macht nicht aufgeben wollte. Um den neuen Brunnen zu verbergen, zogen die Drachenaspekte Nordrassil über ihm empor: Nozdormu segnete die Kaldorei mit Alterslosigkeit, und Ysera band ihre Druiden an den Smaragdgrünen Traum. So begann die Lange Wache. Tyrande formte die Schwesternschaft der Elune zu den Schildwachen um und herrschte allein, während die Druiden schliefen. Als die verbannten Hochgeborenen unter Dath'Remar aus Protest einen Sturm über Eschental entfesselten, wurden sie übers Meer vertrieben und gründeten Quel'Thalas. Die Jahrtausende brachten den Krieg der Satyrn, der die ersten Worgen gebar, und den Krieg der Sandschollen, der Fandral Hirschhaupt seinen Sohn Valstann kostete und die Qiraji hinter dem Skarabäuswall einschloss.

Die Isolation endete im Dritten Krieg. Die Äxte des Kriegshymnenklans bissen in Eschental, Cenarius fiel unter dämonenblütigen Orcs, und als Legion und Geißel kamen, weckte Tyrande Malfurion und die Druiden. Die Kaldorei standen schließlich an der Seite der sterblichen Völker am Berg Hyjal, wo Irrwische Archimonde zerrissen. Der Sieg kostete den Weltenbaum und ihre Unsterblichkeit. Nun liegt Malfurion in einem Koma, das seine Gefährten nicht erklären können; Fandral Hirschhaupt hat Teldrassil gepflanzt, einen Baum, den die Aspekte zu segnen verweigerten und der still der Verderbnis verfällt, und Darnassus in seinen Zweigen errichtet. Die Nachtelfen sind der Allianz beigetreten; ihre Druiden bleiben neutral im Zirkel des Cenarius in Nachthafen.]]
    f.culture = [[Zehntausend Jahre an die Natur gebunden, wandeln die Kaldorei sich langsam und zürnen langsam. Sie sind vorwiegend nachtaktiv, in der Nacht stärker, und nennen die Bestien ihrer Wälder „wildes Gezweig". Ihr Glaube gilt Elune, der Mondgöttin: Ihre Schwesternschaft der Elune führt die Schutzmacht des Volkes, die Schildwachen, und die Mondbrunnen dienen allen Schichten der Gesellschaft zu Heilung und Segen. Sie ehren ihre Ahnen mit Gaben und glauben, die tapferen Toten reiten als Sterne über den Himmel. Die Kaldorei pflegen enge Verwandtschaft mit den Uralten Wächtern, Cenarius, Aviana, Ursoc und Ursol, Malorne, und alte Bande zu den roten, grünen und bronzenen Drachenschwärmen, die einst ihren Baum segneten.

Nach Brauch kehren die Toten zur Natur zurück: Priesterinnen reinigen sie im Mondbrunnen, besingen ihr Leben in Tempel-Arien und betten sie in einen Hain, wo ein Druide Blumen emporwachsen lässt, die den Leib umschließen. Ein Kind erhält zum ersten Geburtstag eine Eulenfeder; ein Reiter bewahrt einen Fangzahn des gefallenen Säblers. Sie foltern keine Gefangenen und erfreuen sich nicht an unnötigem Tod. Zehntausend Jahre lang war Arkanmagie bei Todesstrafe verboten. „Tor ilisar'thera'nal!", „Unsere Feinde sollen sich hüten!", ist ein uralter Schlachtruf.]]
    f.relations = {
        { name = "Hochelfen", text = "Ein währender Groll; die Kaldorei betrachten ihre thalassische Verwandtschaft noch mit Misstrauen und sehen es als ihre Pflicht, Verbündete daran zu erinnern, was der arkanische Hunger der Hochgeborenen einst anrichtete." },
        { name = "Orcs", text = "Die bitterste Wunde: Kriegshymnen-Äxte in Eschental und Cenarius' Tod unter Teufelsklingen. Der Respekt vor Kriegshäuptling Thrall und den Druidenbrüdern mäßigt sie." },
        { name = "Tauren", text = "Der engste Freund in der Horde; willkommen im Zirkel des Cenarius und in der Mondlichtung. Hamuul Runentotem teilt ein tiefes Band mit Malfurion und wandelt frei in Darnassus." },
        { name = "Die Allianz", text = "Beigetreten nach dem Hyjal; manche Traditionalisten verachten die „niederen Völker\" noch offen. In den Pestländern arbeiten Nachtelfen daran, das Land zu läutern und wiederherzustellen." },
        { name = "Verbündete der Natur", text = "Furbolgs, Wildekin, grüne Drachen und die Sumpfbestie Rethiel der Grünwärter in den Marschen." },
    }
    f.groups["darnassus"] = { name = "Darnassus", lore = "Die Nachtelfen-Nation auf Teldrassil, geführt von Hohepriesterin Tyrande Wisperwind." }
    f.groups["sisterhood_of_elune"] = { name = "Schwesternschaft der Elune", lore = "Priesterinnen der Mondgöttin; der Orden, aus dem die Schildwachen geschmiedet wurden." }
    f.groups["sentinels"] = { name = "Die Schildwachen", lore = "Die Kriegerinnen der Kaldorei, die Wälder patrouillierend; General Shandris Mondfeder befehligt von der Festung Mondfeder." }
    f.groups["silverwing_sentinels"] = { name = "Silberschwingen", lore = "Su'ura Flinkspeers Sondertruppe, die Eschental gegen den Kriegshymnenklan hält." }
    f.groups["watchers"] = { name = "Die Behüter", lore = "Marschälle und Kerkermeister der Nachtelfen, geführt von Maiev Schattensang, Wächter der Grabhügel." }
    f.groups["cenarion_circle"] = { name = "Zirkel des Cenarius", lore = "Malfurions neutraler Druidenorden in Nachthafen, offen auch für Tauren und Schüler der Horde; Erzdruide Fandral Hirschhaupt führt ihn seit Malfurions unerklärtem Schlaf." }
    f.groups["highborne_shendralar"] = { name = "Die Hochgeborenen Shen'dralar", lore = "Die verborgenen Magier von Eldre'Thalas in Feralas, die ihren Arkandurst noch am Dämon Immol'thar stillen, von der kaldorei Gesellschaft unbemerkt." }
    f.groups["allies_of_nature"] = { name = "Verbündete der Natur", lore = "Uralte, Irrwische, Hippogryphen, Chimären, Bergriesen, Dryaden und Hüter des Hains, Furbolgs, Wildekin und der grüne Drachenschwarm." }
    f.figureText["tyrande_whisperwind_forever"] = { name = "Tyrande Wisperwind", role = "Hohepriesterin der Elune, Alleinherrscherin der Kaldorei", aff = "Darnassus, Schwesternschaft", title = "Hohepriesterin der Elune, Alleinherrscherin der Kaldorei — Darnassus, Schwesternschaft" }
    f.figureText["malfurion_stormrage"] = { name = "Malfurion Sturmgrimm", role = "Erzdruide, Begründer des Zirkels des Cenarius", aff = "Zirkel des Cenarius", title = "Erzdruide, Begründer des Zirkels des Cenarius — Zirkel des Cenarius" }
    f.figureText["fandral_staghelm_forever"] = { name = "Fandral Hirschhaupt", role = "Führender Erzdruide, Pflanzer Teldrassils", aff = "Zirkel des Cenarius, Darnassus", title = "Führender Erzdruide, Pflanzer Teldrassils — Zirkel des Cenarius, Darnassus" }
    f.figureText["shandris_feathermoon"] = { name = "Shandris Mondfeder", role = "General der Schildwachen", aff = "Schildwachen", title = "General der Schildwachen — Schildwachen" }
    f.figureText["maiev_shadowsong"] = { name = "Maiev Schattensang", role = "Anführerin der Behüter, ehemalige Kerkermeisterin Illidans", aff = "Behüter", title = "Anführerin der Behüter, ehemalige Kerkermeisterin Illidans — Behüter" }
    f.figureText["jarod_shadowsong"] = { name = "Jarod Schattensang", role = "Letzter Anführer der Kaldorei-Resistance", aff = "Kaldorei", title = "Letzter Anführer der Kaldorei-Resistance — Kaldorei" }
    f.figureText["broll_bearmantle"] = { name = "Broll Bärenfell", role = "Erzdruide des Zirkels", aff = "Zirkel des Cenarius", title = "Erzdruide des Zirkels — Zirkel des Cenarius" }
    f.figureText["suura_swiftarrow"] = { name = "Su'ura Flinkspeer", role = "Anführerin der Silberschwingen in Eschental", aff = "Silberschwingen", title = "Anführerin der Silberschwingen in Eschental — Silberschwingen" }
    f.figureText["naralex"] = { name = "Naralex", role = "Druide, schlafend in den Höhlen des Wehklagens, im Traum gefangen", aff = "Zirkel des Cenarius", title = "Druide, schlafend in den Höhlen des Wehklagens, im Traum gefangen — Zirkel des Cenarius" }
    f.figureText["archdruid_renferal"] = { name = "Erzdruide Renferal", role = "Erzdruidin", aff = "Zirkel des Cenarius", title = "Erzdruidin — Zirkel des Cenarius" }
    f.figureText["mordent_evenshade"] = { name = "Mordent Evenshade", role = "Anführer der Shen'dralar-Hochgeborenen", aff = "Shen'dralar", title = "Anführer der Shen'dralar-Hochgeborenen — Shen'dralar" }
    f.figureText["prince_tortheldrin"] = { name = "Prinz Tortheldrin", role = "Herrscher von Eldre'Thalas", aff = "Shen'dralar", title = "Herrscher von Eldre'Thalas — Shen'dralar" }
    f.figureText["kurtalos_ravencrest"] = { name = "Kur'talos Rabenkrone", role = "Erster Anführer der Kaldorei-Resistance", aff = "Kaldorei-Resistance", title = "Erster Anführer der Kaldorei-Resistance — Kaldorei-Resistance" }
    f.figureText["valstann_staghelm"] = { name = "Valstann Hirschhaupt", role = "Sohn Fandrals, fiel im Krieg der Sandschollen", aff = "Kaldorei", title = "Sohn Fandrals, fiel im Krieg der Sandschollen — Kaldorei" }
    f.figureText["queen_azshara"] = { name = "Königin Azshara", role = "Ehemalige Königin, nun Königin der Naga", aff = "Nazjatar", title = "Ehemalige Königin, nun Königin der Naga — Nazjatar" }
    f.figureText["illidan_stormrage"] = { name = "Illidan Sturmgrimm", role = "„Der Verräter\", Herr über Scherbenwelt", aff = "Illidari", title = "„Der Verräter\", Herr über Scherbenwelt — Illidari" }
    f.figureText["lady_vashj"] = { name = "Lady Vashj", role = "Führerin von Illidans Naga", aff = "Echsennarbe", title = "Führerin von Illidans Naga — Echsennarbe" }
    f.figureText["xavius"] = { name = "Xavius", role = "Erster Satyr, versiegelt seit dem Krieg der Ahnen", aff = "Satyrn", title = "Erster Satyr, versiegelt seit dem Krieg der Ahnen — Satyrn" }
    f.figureText["ralaar_fangfire"] = { name = "Ralaar Fangzahn", role = "Erster Worgen, in den Traum versiegelt", aff = "Druiden der Sense", title = "Erster Worgen, in den Traum versiegelt — Druiden der Sense" }
    f.figureText["keeper_remulos"] = { name = "Bewahrer Remulos", role = "Sohn des Cenarius, Hüter der Mondlichtung", aff = "Zirkel des Cenarius", title = "Sohn des Cenarius, Hüter der Mondlichtung — Zirkel des Cenarius" }
    f.figureText["rabine_saturna"] = { name = "Rabine Saturna", role = "Bewahrerin in Nachthafen", aff = "Zirkel des Cenarius", title = "Bewahrerin in Nachthafen — Zirkel des Cenarius" }
    f.figureText["omen"] = { name = "Omen", role = "Verdorbener Halbgott in der Mondlichtung", aff = "Unabhängig", title = "Verdorbener Halbgott in der Mondlichtung — Unabhängig" }
end


-- ============================================================
-- HORDE
-- ============================================================

f = IMAGOdb.races["orc"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Orcs"
    f.groupTabLabel = "Klans"
    f.quote = { text = "So zu tun, als hätte es die dämonische Verderbnis nicht gegeben, heißt vergessen, wie furchtbar ihre Wirkung war. Uns zu Opfern zu machen, statt unseren Anteil an unserer eigenen Vernichtung einzugestehen. Wir haben diesen Weg gewählt, wir Orcs. Wir wählten ihn bis zu dem Punkt, an dem es zu spät war umzukehren. Und weil wir ihn wählten, können wir, im Wissen um das Ende jenes dunklen und schmachvollen Weges, ihn nun nicht noch einmal gehen.", author = "Thrall" }
    f.overview = "Die Orcs sind ein zahlreiches, körperlich mächtiges Volk aus der einst grünen Welt Draenor. Ein schamanistisches Volk, von Kil'jaeden zu einer blutdürstigen Horde verdorben, tranken sie das Blut Mannoroths und wurden der Brennenden Legion hörig. Dann erhob sich Thrall, Sohn Durotans, aus den Internierungslagern, entfachte die alten Wege neu und führte sein Volk nach Kalimdor. Dort brachen sie ihre dämonische Knechtschaft und gründeten die Nation Durotar und die Stadt Orgrimmar."
    f.facts = {
        faction = "Horde",
        capital = "Orgrimmar",
        leader = "Kriegshäuptling Thrall",
        mount = "Wolf",
        language = "Orcisch",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" }, { classFile = "WARLOCK" }, { classFile = "MAGE" } }
    f.history = [[Die Orcs stammen von Grond ab, dem steinernen Riesen, geformt vom Titanen Aggramar. Über Kolosse, Magnaron, Gronn, Ogron und Oger überlebte der kleinste Spross von Gronds Linie die Wildnis Draenors durch Scharfsinn und Gemeinschaft. Nachdem die Oger die Ogron-Herrschaft abwarfen, breiteten sich die Orcs aus den Höhlen Gorgronds aus und bildeten die Klans, und nur die Kosh'harg-Feste hielten den Frieden zwischen ihnen.

Mystiker des Schattenmondklans entdeckten den Thron der Elemente im Nordwesten Nagrands und lehrten die Klans den Schamanismus; das Band zwischen Schamanen überschritt Klangrenzen und wurde das Gewissen der Orcheit. Als das Gorianische Ogerreich den Thron besetzte, führte der Schamane Nelgarm die vereinten Klans zur Rückeroberung, und die Geister zerschmetterten Goria zu Asche, ein Zorn, den die Schamanen schworen nie wieder zu rufen. Die Ankunft der Draenei gab den Klans einen höflichen, distanzierten Handelspartner.

Dann täuschte Kil'jaeden den Ältestenschamanen Ner'zhul, erschien als Ahnengeist und hetzte die Orcs gegen die Draenei. Die Elemente verließen sie, und Ner'zhuls Schüler Gul'dan füllte die Lücke mit Hexenmeisterschulen, dem Schattenrat und der Alten Horde unter dem Marionetten-Kriegshäuptling Schwarzfaust. Am Vorabend des Falls von Shattrath tranken die Häuptlinge Mannoroths Blut, und der Blutrausch ertränkte die Draenei. Feindlos wandten sich die Klans gegeneinander, bis Medivhs Geflüster das Dunkle Portal öffnete. Der Erste Krieg verwüstete Sturmwind; Schicksalshammer erschlug Schwarzfaust und trieb die Horde nordwärts. Der Zweite Krieg trug sie an die Mauern der Hauptstadt, bis Gul'dans Desertion die Horde am Rande des Sieges spaltete. Niederlage, das zerstörte Portal und die Internierungslager folgten.

Jahre später entkam Thrall, Sohn des ermordeten Durotan, aus Durnholde und lernte bei den verbannten Frostwölfen Schamanismus von Drek'Thar. Mit Grom Höllschrei und Schicksalshammer gründete er die Neue Horde; Schicksalshammer fiel im letzten Sturm, und Thrall legte seine Rüstung und seinen Hammer an. Dem Raben des Propheten folgend segelten die Orcs nach Kalimdor, retteten unterwegs die Dunkelspeere und freundeten sich mit Cairnes Tauren an. In Eschental versklavte Mannoroths Blut die Kriegshymnen erneut, doch Grom erschlug den Grubenlord und befreite sie alle um den Preis seines Lebens. Nach Archimondes Fall am Hyjal gründete Thrall Durotar nach seinem Vater und Orgrimmar nach Schicksalshammer. Als Daelin Prachtmeers Flotte die junge Nation traf, hielten Jainas Loyalität und Rexxars Hilfe sie stand, und Vol'jin schwor seinem Stamm die ewige Treue zur Horde.]]
    f.culture = [[Die orcische Gesellschaft ehrt die Ehre über alles, zuerst die Ehre des Klans und der Horde, dann die eigene, und Gastfreundschaft zählt zu den größten Ehren, die man erweisen kann. Jeder Orc trägt sein Gewicht; Schwäche riskiert die Verbannung. Kinder gehören dem Klan: Bei der Namensgebung hebt der Vater den Säugling im Wasser zum Segen des Klans empor, dort, wo die Schwachen einst ertränkt wurden, eine Grausamkeit, die die Frostwölfe ablehnten. Junge Orcs üben mit sechs die Waffen, jagen mit zwölf und verdienen das Erwachsensein im om'riggor-Ritus. Ihre Lieder tragen ihre Erinnerung: lok'tra für eine große Schlacht, lok'amon für die Geschichte eines Geschlechts, lok'vadnod, für einen Einzelnen verfasst, die höchste Ehre, die ein Orc empfangen kann.

Der Schamanismus ist die Wurzel ihrer Seele. Seit die Schattenmonden die Zunge der Elemente lehrten, gelten Schamanen als zweithöchste Ehre nach den Häuptlingen. Im kargen Durotar sind sie unverzichtbar, handeln Regen und Herdfeuer von den Elementaren. Die Toten wurden einst auf Scheiterhaufen verbrannt, die Asche Feuer, Luft, Wasser und Erde gegeben; der Blutrausch verwarf diesen Brauch, und Friedhöfe stehen nun neben den alten Feuern. Orcs essen herzhaft, frisches Fleisch vor allem, und ihre erkorenen Gefährten sind die großen Terrorwölfe. Auf Kalimdor nahmen sie den Lo'Gosh der Tauren als eigenen Helden an: einen Wolfsgeist, dessen Wille, wie ihrer, nicht einmal der Tod stoppt.]]
    f.relations = {
        { name = "Tauren und Dschungeltrolle", text = "Unantastbare Bande; die Tauren gaben den Orcen Obdach in einem fremden Land, die Dunkelspeere schworen Treue, nachdem Thrall ihren Stamm rettete." },
        { name = "Die Verlassenen", text = "Nur widerwillig in die Reihen der Horde aufgenommen, nach langem Streit zwischen Thrall, Cairne und Vol'jin." },
        { name = "Menschen", text = "Eine lange Geschichte der Gewalt und ein widerwilliger Respekt vor ihrer Stärke; die meisten Orcs hegen noch Groll über die Internierungslager, obwohl sie am Hyjal Seite an Seite mit Menschen kämpften. Ein Mensch gebietet wahren Respekt: Jaina Prachtmeer, die die Orcs über ihren eigenen Vater stellte." },
        { name = "Die Nationen der Allianz", text = "Thrall hat Fäden des Kontakts zu knüpfen versucht, selbst zu den Zwergen Eisenschmiedes." },
        { name = "Kleinere Verbündete", text = "Die Halboger der Mok'nathal und die Oger der Steinbrecher zählen zu den angeschlossenen Völkern der Horde." },
    }
    f.groupsIntro = "Jeder Orc gehört einem Klan an; jeder Klan hat eigene Kultur und Namen, geführt von einem Häuptling, der seinen Titel durch Mak'gora-Herausforderung oder Erbe trägt, und alle Klans folgen dem Kriegshäuptling. Die vierzehn großen Klans:"
    f.groups["frostwolf"] = { name = "Frostwolf", lore = "Thralls eigener Klan, von Gul'dan verbannt, weil er das Blut verweigerte; heute zuhause im Alteractal." }
    f.groups["warsong"] = { name = "Kriegshymnenklan", lore = "Nomaden, benannt nach ihren Schlachtgesängen; Groms Klan." }
    f.groups["blackrock"] = { name = "Schwarzfelsklan", lore = "Militante Schmiede, die den Sturm der Horde anführten; gespalten zwischen Thralls Getreuen und Rends Dunkler Horde am Schwarzfels." }
    f.groups["bleeding_hollow"] = { name = "Klan der Blutenden Augenhöhle", lore = "Fanatische Seher, die ein Auge für Visionen opfern." }
    f.groups["shattered_hand"] = { name = "Klan der Zerschmetterten Hand", lore = "Einst Sklaven der Oger, von Kargath befreit; die Assassinen der Horde." }
    f.groups["shadowmoon"] = { name = "Schattenmondklan", lore = "Einst das geistige Herz der Klans; Ner'zhuls Klan." }
    f.groups["dragonmaw"] = { name = "Drachenmalklan", lore = "Die abtrünnigen Reiter, die die Drachenkönigin in Grim Batol ketteten." }
    f.groups["burning_blade"] = { name = "Klan der Brennenden Klinge", lore = "Dämonenwahnsinnige Klingenmeister vollster Blutgier." }
    f.groups["thunderlord"] = { name = "Donnerfürstenklan", lore = "Jäger der Giganten Draenors, größtenteils der Teufelsverderbnis verfallen." }
    f.groups["stormreaver"] = { name = "Sturmrächerklan", lore = "Gul'dans Leibgarde, im Grabmal-Gambit abgeschlachtet." }
    f.groups["twilights_hammer"] = { name = "Klan des Schattenhammers", lore = "Cho'galls Nihilisten, nun ein Kult der Alten Götter." }
    f.groups["laughing_skull"] = { name = "Klan des Lachenden Schädels", lore = "Verräterische Diebe, einst vom Oger Mogor geführt." }
    f.groups["bonechewer"] = { name = "Knochenmalmerklan", lore = "Kannibalen, mit Knochen geschmückt, größtenteils verdorben." }
    f.groups["black_tooth_grin"] = { name = "Klan der Schwarzen Zähne", lore = "Rends und Maims Splitterklan in der Dunklen Horde." }
    f.groupsFootnote = "Daneben stehen die Mok'nathal von Rexxars Volk und die Steinbrecher-Oger, kleinere Völker, an die Horde gebunden."
    f.figureText["thrall_forever"] = { name = "Thrall", role = "Kriegshäuptling der Neuen Horde, Gründer Durotars", aff = "Horde, Frostwolfklan", title = "Kriegshäuptling der Neuen Horde, Gründer Durotars — Horde, Frostwolfklan" }
    f.figureText["blackhand"] = { name = "Blackhand", role = "Erster Kriegshäuptling der Alten Horde", aff = "Alte Horde, Schwarzfelsklan", title = "Erster Kriegshäuptling der Alten Horde — Alte Horde, Schwarzfelsklan" }
    f.figureText["guldan"] = { name = "Gul'dan", role = "Meister des Schattenrats", aff = "Schattenrat", title = "Meister des Schattenrats — Schattenrat" }
    f.figureText["orgrim_doomhammer"] = { name = "Orgrim Schicksalshammer", role = "Kriegshäuptling im Zweiten Krieg", aff = "Alte Horde", title = "Kriegshäuptling im Zweiten Krieg — Alte Horde" }
    f.figureText["nerzhul"] = { name = "Ner'zhul", role = "Ehemaliger Ältestenschamane, nun der Lichkönig", aff = "Geißel", title = "Ehemaliger Ältestenschamane, nun der Lichkönig — Geißel" }
    f.figureText["grommash_hellscream"] = { name = "Grommash Höllschrei", role = "Ehemaliger Häuptling der Kriegshymnen, Erlöser der Orcs", aff = "Kriegshymnenklan", title = "Ehemaliger Häuptling der Kriegshymnen, Erlöser der Orcs — Kriegshymnenklan" }
    f.figureText["garrosh_hellscream"] = { name = "Garrosh Höllschrei", role = "Sohn Groms, in Garadar", aff = "Mag'har", title = "Sohn Groms, in Garadar — Mag'har" }
    f.figureText["durotan"] = { name = "Durotan", role = "Vater Thralls, ehemaliger Häuptling der Frostwölfe", aff = "Frostwolfklan", title = "Vater Thralls, ehemaliger Häuptling der Frostwölfe — Frostwolfklan" }
    f.figureText["draka"] = { name = "Draka", role = "Gefährtin Durotans, Mutter Thralls", aff = "Frostwolfklan", title = "Gefährtin Durotans, Mutter Thralls — Frostwolfklan" }
    f.figureText["greatmother_geyah"] = { name = "Großmutter Geyah", role = "Geistige Anführerin der Mag'har", aff = "Mag'har", title = "Geistige Anführerin der Mag'har — Mag'har" }
    f.figureText["drekthar"] = { name = "Drek'Thar", role = "Häuptling und Ältestenschamane der Frostwölfe", aff = "Frostwolfklan", title = "Häuptling und Ältestenschamane der Frostwölfe — Frostwolfklan" }
    f.figureText["rend_blackhand"] = { name = "Rend Schwarzfaust", role = "Sohn Blackhands, Kriegshäuptling der Dunklen Horde", aff = "Dunkle Horde", title = "Sohn Blackhands, Kriegshäuptling der Dunklen Horde — Dunkle Horde" }
    f.figureText["teron_gorefiend"] = { name = "Teron Blutschatten", role = "Erster der Todesritter", aff = "Schattenmondklan", title = "Erster der Todesritter — Schattenmondklan" }
    f.figureText["broxigar"] = { name = "Broxigar", role = "Veteran, der einzige Sterbliche, der Sargeras verwundete", aff = "Horde", title = "Veteran, der einzige Sterbliche, der Sargeras verwundete — Horde" }
    f.figureText["varok_saurfang"] = { name = "Varok Saurfang", role = "Bruder Broxigars, ranghoher Kommandant der Horde", aff = "Horde", title = "Bruder Broxigars, ranghoher Kommandant der Horde — Horde" }
    f.figureText["dranosh_saurfang"] = { name = "Dranosh Saurfang", role = "Sohn Saurfangs", aff = "Mag'har", title = "Sohn Saurfangs — Mag'har" }
    f.figureText["eitrigg"] = { name = "Eitrigg", role = "Hochrangiger Kommandant, Thralls Berater", aff = "Horde", title = "Hochrangiger Kommandant, Thralls Berater — Horde" }
    f.figureText["kilrogg_deadeye"] = { name = "Kilrogg Totauge", role = "Ehemaliger Häuptling der Blutenden Augenhöhle", aff = "Blutende Augenhöhle", title = "Ehemaliger Häuptling der Blutenden Augenhöhle — Blutende Augenhöhle" }
    f.figureText["jorin_deadeye"] = { name = "Jorin Totauge", role = "Sohn Kilroggs, Häuptling der Blutenden Augenhöhle", aff = "Mag'har", title = "Sohn Kilroggs, Häuptling der Blutenden Augenhöhle — Mag'har" }
    f.figureText["kargath_bladefist"] = { name = "Kargath Messerfaust", role = "Häuptling der Zerschmetterten Hand", aff = "Teufelshorde", title = "Häuptling der Zerschmetterten Hand — Teufelshorde" }
    f.figureText["zuluhed_the_whacked"] = { name = "Zuluhed der Wahnsinnige", role = "Ehemaliger Häuptling des Drachenmalklans", aff = "Drachenmalklan", title = "Ehemaliger Häuptling des Drachenmalklans — Drachenmalklan" }
    f.figureText["rehgar_earthfury"] = { name = "Rehgar Erdenwut", role = "Berater Thralls", aff = "Horde", title = "Berater Thralls — Horde" }
    f.figureText["nazgrel"] = { name = "Nazgrel", role = "Thralls treuer Berater", aff = "Frostwolfklan", title = "Thralls treuer Berater — Frostwolfklan" }
    f.figureText["samuro"] = { name = "Samuro", role = "Klingenmeister, Gefährte Rexxars", aff = "Unabhängig", title = "Klingenmeister, Gefährte Rexxars — Unabhängig" }
    f.figureText["rokaro"] = { name = "Rokaro", role = "Champion der Horde, Gefährte Rexxars", aff = "Horde", title = "Champion der Horde, Gefährte Rexxars — Horde" }
    f.figureText["utok_scratcher"] = { name = "Utok Scratcher", role = "Chronist des Zweiten Krieges", aff = "Alte Horde", title = "Chronist des Zweiten Krieges — Alte Horde" }
    f.figureText["drakthul"] = { name = "Drak'thul", role = "Einsiedler, letzter Überlebender der Sturmrächer", aff = "Unabhängig", title = "Einsiedler, letzter Überlebender der Sturmrächer — Unabhängig" }
end

f = IMAGOdb.races["troll"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Trolle"
    f.groupTabLabel = "Stämme"
    f.quote = { text = "Als du Schattenjäger wurdest, gingst du darüber hinaus, mein Sohn zu sein. Du wurdest ein Vater für alle Trolle. Du trägst die Verantwortung für uns alle, für das, was wir werden.", author = "Sen'jin" }
    f.overview = "Die Trollheit ist eines der ältesten Urvölker Azeroths, zerteilt in viele Stämme, die sich jedem Land anpassten: Dschungel, Wald, Eis und Sand. Die meisten Stämme halten sich an den uralten Stamm der Zandalari und kennen darüber hinaus keine Treue, doch der Dunkelspeer-Stamm, aus dem Schlingendorntal vertrieben und von Thrall gerettet, schwor sich der neuen Horde. Von ihrem bedrohten Fischerdorf Sen'jin an der Küste Durotars, die Echoinseln an den Verräter Zalazane verloren, kämpfen sie darum, ihre erste Heimat auf Kalimdor zurückzugewinnen."
    f.facts = {
        faction = "Horde (Dunkelspeer-Stamm; andere Stämme unabhängig oder feindlich)",
        capital = "Dorf Sen'jin, Durotar (die Echoinseln von Zalazane gehalten)",
        leader = "Häuptling Vol'jin, Sohn Sen'jins",
        mount = "Raptor",
        language = "Zandali, Orcisch",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "MAGE" }, { classFile = "PRIEST" }, { classFile = "ROGUE" }, { classFile = "SHAMAN" }, { classFile = "WARLOCK" } }
    f.history = [[Die Trolle gehörten zu den ersten Völkern, die um den Brunnen der Ewigkeit entstanden, wilde Jäger und Sammler, die die Wilden Götter als „Loa" verehrten und ihre Schreine auf den heiligen Gipfeln Zandalars errichteten, gekrönt von der Tempelstadt Zuldazar. Als der C'Thrax Kith'ix die Aqir-Schwärme sammelte, vereinten die Zandalari alle Stämme zum Imperium von Zul und brachen die Insektoiden-Legionen; die weit gestreuten Festungen, die den Sieg bewachten, wuchsen zu den Reichen der Amani, Gurubashi und Drakkari. Dunkle Trolle, die am Brunnen siedelten, wurden die ersten Nachtelfen, deren Königin Azshara die Trollnationen später demütigte und einen Hass nährte, der nie erkaltete.

Jahrhunderte des Verfalls folgten der Zerschlagung. Im Norden vernichteten die von Zandalari geführten Amani unter Jintha beinahe Quel'Thalas, bis Arathors hundert Magier ihre Kriegsmeuten vom Feld brannten. Im Süden ergaben sich die hungernden Gurubashi Hakkar dem Seelenschinder; die Zandalari stürmten Zul'Gurub, um seiner Herrschaft ein Ende zu setzen, und als die überlebenden Atal'ai einen neuen Tempel im Sumpf des Elends errichteten, versenkte Ysera ihn im Schlamm und setzte ihre grünen Drachen zur Wache. Und an Sturmwinds Grenze brach die Belagerung des Gurubashi-Kriegsfürsten Zan'non erst, als der Wächter Medivh Feuer von den Mauern regnen ließ.

Die Kriege des neuen Zeitalters fanden die Stämme gespalten. Im Zweiten Krieg schlossen sich die Amani Schicksalshammers Horde an, nachdem ihr Kriegsfürst Zul'jin aus menschlichen Ketten befreit worden war, bis die Elfen sie nach Zul'Aman zurückdrängten. Im Dritten Krieg kämpften die Dunkelspeer-Trolle der Südseeinseln an Thralls Seite gegen Daelin Prachtmeers Flotte und die Naga Zar'jira. Ihr weiser Häuptling Sen'jin fiel, und sein Sohn Vol'jin führte die Überlebenden westwärts, sich der Horde auf Kalimdor anzuschließen. Die Dunkelspeere beanspruchten die Echoinseln, verloren sie dann an Zalazanes Willensknechtung und halten nun das Fischerdorf Sen'jin. Unterdessen regen sich die alten Bedrohungen: Die Atal'ai kehrten in den Versunkenen Tempel zurück, als dessen grüne Drachenwächter in den Smaragdgrünen Alptraum glitten, und Jin'do des Hexxers Hakkari haben Zul'Gurubs Priester versklavt. Die Zandalari rufen um Hilfe, Hakkars Rückkehr zu verhindern.]]
    f.culture = [[Die ganze Trollheit ist in Stämme geteilt. Alle sechs Jahre versammeln sich Abgesandte in Zuldazar, um zu beraten, was das ganze Volk berührt, und einmal je Generation duellieren die größten Trolle in der Gurubashi-Arena zum Ruhm der Loa, eine der höchsten Ehren, die ein Troll erringen kann. Sie tragen Gold statt Ringe, binden Blut an Raptor-Gefährten über Jahre des gegenseitigen Überlebens und gehen barfuß außer im Krieg. Ihre Körper erneuern Wunden, die andere Völker töten würden; nur der Fluch eines Loa kann diese Gabe nehmen, und ein abgetrennter Kopf macht den Tod gewiss.

Ihre Magie ist die ihre: Voodoo, die uralte Macht der Trolle, und Hoodoo daneben; E'ko die Lebenskraft in jeder Kreatur, Juju die Gegenstände, die sie bergen, Muisek der rächende Geist eines gewaltsamen Todes, und Mojo das Fluidum des Rituals. Die Loa gewähren selbst Gaben der Druidik und des Schamanismus, denn Trolle lernen Magie nicht durch Studium, sondern von den Göttern selbst. Ihr Glaube ist vielschichtig und dunkel: zahllose Loa, die meisten schwach, manche mächtig; Familien hüten Familien-Loa, Städte ihre städtischen Gottheiten, Nationen die größten Namen. Und der Kannibalismus reicht tief. Die meisten Stämme essen ihre toten Feinde; die Zandalar und die Revantusk enthalten sich, und die Dunkelspeere gaben den Brauch beim Eintritt in die Horde auf.]]
    f.relations = {
        { name = "Die Horde", text = "Die geschworene Treue der Dunkelspeere, mit Sen'jins Blut auf den Inseln erkauft und am Hyjal besiegelt; Vol'jin sitzt neben Thrall im Rat." },
        { name = "Andere Trollstämme", text = "Die Dunkelspeere sind den meisten der Trollheit verstoßen; die Gurubashi-Stämme, die sie im Schlingendorntal quälten, bleiben erbitterte Rivalen, während die Revantusk des Hinterlands zur Horde stehen." },
        { name = "Die Zandalari", text = "Die selbsternannten Schützer aller Trolle, die die Dunkelspeere erreichen, wenn das Schicksal des Volkes auf dem Spiel steht, wie nun, da Hakkar in Zul'Gurub wiederkehrt." },
        { name = "Nachtelfen", text = "Der älteste Hass; Azsharas uralte Demütigung brennt in jeder Troll-Legende, und der Krieg der Horde in Eschental erneuert ihn." },
        { name = "Die Allianz", text = "Trolle zählen die Menschen Sturmwinds zu den Schlächtern des Gurubashi-Krieges und die Hochelfen Quel'Thalas' als Eindringlinge auf heiligem Amani-Grund." },
        { name = "Die Naga", text = "Der erste Feind der Dunkelspeere auf ihren Inseln war die Naga-Hexerin Zar'jira, die Sen'jin das Leben kostete." },
    }
    f.groups["darkspear_tribe"] = { name = "Dunkelspeer-Stamm", lore = "Vol'jins eigene, Exilanten des Schlingendorntals, der Horde verschworen; zuhause im Dorf Sen'jin, die Echoinseln unter Zalazanes Bann." }
    f.groups["zandalari_tribe_zandalari_empire"] = { name = "Zandalari-Stamm / Zandalari-Imperium", lore = "Die geistigen Führer aller Trolle auf ihrer Insel Zandalar; sie rufen die Stämme zusammen, hüten das Wissen und rufen jetzt Hilfe gegen Hakkar." }
    f.groups["gurubashi_tribes"] = { name = "Gurubashi-Stämme", lore = "Die Dschungeltrolle des Schlingendorntals: die Gurubashi in Zul'Gurub unter dem Bann von Jin'dos Hakkari, die Blutskalpe in Zul'Kunda, die Schädelspalter in Zul'Mamwe und die Atal'ai im Versunkenen Tempel." }
    f.groups["amani_tribes"] = { name = "Amani-Stämme", lore = "Die Waldtrolle des Nordens: die Amani von Zul'Aman, die Moosschinder von Zul'Mashar in den Pestländern, die Bleichborken der Arathihochlande, die Bösen Zweige des Hinterlands sowie die Gluthauer und Feuerbäume, die sich unter der Dunklen Horde an die Schwarzfelsspitze klammern." }
    f.groups["revantusk_tribe"] = { name = "Revantusk-Stamm", lore = "Waldtrolle des Dorfs Revantusk, der einzige Waldtrollstamm im Bunde mit der Horde." }
    f.groups["shatterspear_tribe"] = { name = "Shatterspear-Stamm", lore = "Zurückgezogene Dschungeltrolle des Shatterspeertals in Dunkelküste unter Häuptling Jor'kil, an einen Friedenspakt mit den Nachtelfen gebunden; neutral." }
    f.groups["drakkari_tribes"] = { name = "Drakkari-Stämme", lore = "Die Eistrolle: die Drakkari von Zul'Drak, die Frostmähnen, die Dun Morogh überfallen, die Winterax und Winterfang des Nordens." }
    f.groups["farraki_tribe"] = { name = "Farraki-Stamm", lore = "Die Sandtrolle von Zul'Farrak in Tanaris." }
    f.groups["shadowtooth_clan"] = { name = "Schattenzahn-Clan", lore = "Dunkle Trolle, die in den Höhlen unter dem Hyjal verharren." }
    f.figureText["vol_jin_forever"] = { name = "Vol'jin", role = "Häuptling der Dunkelspeere, Sohn Sen'jins", aff = "Dunkelspeere, Horde", title = "Häuptling der Dunkelspeere, Sohn Sen'jins — Dunkelspeere, Horde" }
    f.figureText["senjin"] = { name = "Sen'jin", role = "Ehemaliger Häuptling der Dunkelspeere, Vater Vol'jins", aff = "Dunkelspeere", title = "Ehemaliger Häuptling der Dunkelspeere, Vater Vol'jins — Dunkelspeere" }
    f.figureText["rokhan"] = { name = "Rokhan", role = "Chefspäher der Dunkelspeere", aff = "Dunkelspeere, Horde", title = "Chefspäher der Dunkelspeere — Dunkelspeere, Horde" }
    f.figureText["master_gadrin"] = { name = "Meister Gadrin", role = "Ratgeber und Mentor Vol'jins, Führer Sen'jins", aff = "Dunkelspeere", title = "Ratgeber und Mentor Vol'jins, Führer Sen'jins — Dunkelspeere" }
    f.figureText["zalazane"] = { name = "Zalazane", role = "Verräter, selbsternannter Herrscher der Echoinseln", aff = "Dunkelspeere (abtrünnig)", title = "Verräter, selbsternannter Herrscher der Echoinseln — Dunkelspeere (abtrünnig)" }
    f.figureText["zuljin"] = { name = "Zul'jin", role = "Ehemaliger Kriegsfürst der Amani", aff = "Amani", title = "Ehemaliger Kriegsfürst der Amani — Amani" }
    f.figureText["jindo_the_hexxer"] = { name = "Jin'do der Hexxer", role = "Beherrscher Zul'Gurubs durch die Hakkari", aff = "Hakkari", title = "Beherrscher Zul'Gurubs durch die Hakkari — Hakkari" }
    f.figureText["zanzil_the_outcast"] = { name = "Zanzil der Ausgestoßene", role = "Verstoßener Hexendoktor", aff = "Gurubashi", title = "Verstoßener Hexendoktor — Gurubashi" }
    f.figureText["jammalan_the_prophet"] = { name = "Jammal'an der Prophet", role = "Führer der Atal'ai im Versunkenen Tempel", aff = "Atal'ai", title = "Führer der Atal'ai im Versunkenen Tempel — Atal'ai" }
    f.figureText["elder_torntusk"] = { name = "Ältester Tornhauer", role = "Mitführer der Revantusk", aff = "Revantusk, Horde", title = "Mitführer der Revantusk — Revantusk, Horde" }
    f.figureText["primal_torntusk"] = { name = "Ur-Tornhauer", role = "Mitführerin der Revantusk", aff = "Revantusk, Horde", title = "Mitführerin der Revantusk — Revantusk, Horde" }
    f.figureText["warlord_threshjin"] = { name = "Kriegsfürst Thresh'jin", role = "Anführer der Moosschinder", aff = "Moosschinder", title = "Anführer der Moosschinder — Moosschinder" }
    f.figureText["war_master_voone"] = { name = "Kriegsmeister Voone", role = "Anführer der Gluthauer am Schwarzfels", aff = "Gluthauer, Dunkle Horde", title = "Anführer der Gluthauer am Schwarzfels — Gluthauer, Dunkle Horde" }
    f.figureText["ganzulah"] = { name = "Gan'zulah", role = "Anführer der Blutskalpe", aff = "Blutskalpe", title = "Anführer der Blutskalpe — Blutskalpe" }
    f.figureText["anathek_the_cruel"] = { name = "Ana'thek die Grausame", role = "Anführerin der Schädelspalter", aff = "Schädelspalter", title = "Anführerin der Schädelspalter — Schädelspalter" }
    f.figureText["chief_ukorz_sandscalp"] = { name = "Häuptling Ukorz Sandhaut", role = "Häuptling der Sandwüter", aff = "Sandwüter", title = "Häuptling der Sandwüter — Sandwüter" }
    f.figureText["king_rastakhan"] = { name = "König Rastakhan", role = "Gottkönig des Zandalari-Imperiums", aff = "Zandalari", title = "Gottkönig des Zandalari-Imperiums — Zandalari" }
    f.figureText["zanza_the_restless"] = { name = "Zanza der Ruhelose", role = "Loa Zandalars", aff = "Zandalari", title = "Loa Zandalars — Zandalari" }
    f.figureText["hakkar_the_soulflayer"] = { name = "Hakkar der Seelenschinder", role = "Blut-Loa, im Zul'Gurub beschworen", aff = "Atal'ai, Hakkari", title = "Blut-Loa, im Zul'Gurub beschworen — Atal'ai, Hakkari" }
    f.figureText["frost_king_malakk"] = { name = "Frostkönig Malakk", role = "Herrscher der Drakkari", aff = "Drakkari-Imperium", title = "Herrscher der Drakkari — Drakkari-Imperium" }
end

f = IMAGOdb.races["undead"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Die Verlassenen"
    f.groupTabLabel = "Orden"
    f.quote = { text = "Scheue keine dunklen Pfade, wenn diese Pfade zum Sieg führen.", author = "Sprichwort der Verlassenen" }
    f.overview = "Der Tod bot kein Entrinnen für die Scharen von Menschen und Hochelfen, die den Streitkräften des Lichkönigs im Dritten Krieg zum Opfer fielen. Sie wurden als Diener der Geißel auferweckt und gezwungen, gegen alles zu kämpfen, was ihnen einst teuer war. Als der Griff des Lichkönigs schwächelte, riss sich ein Teil der Untoten frei, gequält von Erinnerungen an ihre Gräuaten und gejagt von einer Welt, die nur Ungeheuer sah. Die einstige Waldläufergeneralin von Silbermond, Sylvanas Windläufer, sammelte diese Verlassenen, machte die Unterstadt unter den Ruinen Lordaerons zu ihrer Zuflucht und band sie an ihr brennendes Ziel: die Vernichtung von Arthas – einst Champion des Lichkönigs und Verwüster ihrer Heimat, nun selbst ein Wesen, das über den Tod hinaus aufgestiegen ist."
    f.facts = {
        faction = "Horde",
        capital = "Die Unterstadt, unter den Ruinen von Lordaeron",
        leader = "Sylvanas Windläufer, die Bansheekönigin; Majordomus Varimathras",
        mount = "Skelettpferd",
        language = "Gossensprache, Orcisch",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "ROGUE" }, { classFile = "MAGE" }, { classFile = "PRIEST" }, { classFile = "WARLOCK" }, { classFile = "PALADIN" } }
    f.history = [[Lordaeron fiel im Dritten Krieg unter Arthas Menethils Geißel, seine Toten zum Dienst auferweckt. Doch als Illidans Angriff auf den Frostthron die Macht des Lichkönigs schwächte, erwachten viele Untote in den Pestländern zum freien Willen und zum Grauen über die eigenen Taten. Während Arthas gen Nordend zog, sammelte Sylvanas Windläufer, selbst eine der Geißel entrissene Banshee, die Willensfreien und riss das untote Reich an sich. Mit Banshees, die Gnolle, Banditen und Oger beherrschten, dem erzwungenen Eid des Schreckenslords Varimathras und dem ihrem Willen hörigen Allianz-Widerstand des Großmarschalls Garithos holte sie Lordaeron zurück. Dann ließ sie ihre lebenden Verbündeten hinrichten, statt ihr Versprechen zu halten, ihnen die Stadt zu lassen. Von den Ruinen der Hauptstadt proklamierte sie ihre Fraktion zu den „Verlassenen" und schwor, jeden zu erschlagen, der ihrer Herrschaft im Weg stünde. Die Katakomben, die die Geißel unter der Stadt begonnen hatte, wurden ihre Zuflucht: die Unterstadt.

Um ihre junge Nation zu schützen, sandte Sylvanas Abgesandte auf Verbündeten-Suche. Von der Allianz kehrte keiner zurück. Es waren die gutherzigen Tauren von Donnerfels, die antworteten: Erzdruide Hamuul Runentotem sah Hoffnung auf Erlösung in ihnen, und die Ältestenmatrone Magatha Grimmtotem meinte, die Tauren-Wege könnten ihre Menschlichkeit zurückholen. Thrall und Cairne zweifelten, doch der Irdene Ring hielt es für die Pflicht der Horde, einem Volk zu helfen, das mit inneren Dämonen rang wie einst die Orcs. Das Bündnis wurde geschmiedet: Die Verlassenen gewannen ihre Chance auf Rache, die Horde einen unbezahlbaren Brückenkopf in den Östlichen Königreichen.

Nun sind die Verlassenen die vorderste Macht der Horde östlich des Meeres. Sie kriegen ohne Pause gegen den Scharlachroten Kreuzzug, dessen Zeloten jeden Untoten aus Azeroth tilgen wollen, während die Entweihten die Ressourcen des Arathibeckens sichern. Im Apothekarium arbeitet die Königliche Apothekervereinigung an einer Neuen Seuche, einer Waffe gegen die Geißel und vorgeblich die Lebenden. Und Nathanos Pestrufer, der Champion, den Sylvanas eigenhändig dem Griff der Geißel entriss, jagt den Scharlachroten Kreuzzug.]]
    f.culture = [[Die Unterstadt schläft nie, und ihre Bewohner auch nicht. Der Untod formt mehr als das Fleisch: Die Seelen haften nur unvollkommen an ihren Körpern, dämpfen Schmerz wie Gefühl, und das Heilige Licht, das einen Verlassenen heilt, bringt Agonie, doch manche Priester wirken es noch um vollen Preis. Die meisten Verlassenen empfinden Reue, Mitleid oder Zorn; wenige Freude. Ein Neu-Erweckter mag in Schrecken oder Raserei aufwachen und wird sanft durch „die Gabe" geführt, bis sein Wille wiederkehrt. Dann kommt die letzte Weisung, die jeder Verlassene erhält: Diene der Dunklen Fürstin, oder kehre ins Grab zurück. Der freie Wille ist der Grundstein ihrer Kultur, und ihre Königin verlangt Treue, hält aber niemanden im Bann.

Sie zeichnen ihre Wiedergeburt mit neuen Namen, Nathanos Marris wurde Pestrufer, und kleiden sich in Schwarz, Grau und Dunkelviolett. Sie brauchen keine Nahrung und schmecken ohnehin wenig; ihre Zungen lesen stattdessen Textur. Ein Hunger auf humanoides Fleisch kennt sie, und sie flicken sich durch Kannibalismus an den Toten, durch Anheften neuer Muskeln und Sehnen oder durch das Aussaugen der Lebenden. Der wahre Tod, die Hinrichtung, ahndet Hochverrat und Aufstand; der Letzte Tod ist das Ende, das sie selbst wählen. Ihre Reittiere sind Skelettpferde und große Fledermäuse. Ihre Glauben spalten sich: Manche halten am Heiligen Licht fest, um schrecklichen Preis; andere errichteten den Kult des Vergessenen Schattens aus den wiedergefundenen Lehren Bischof Natalie Selines, lehren das Gleichgewicht von Licht und Dunkelheit und dass die Glauben des Lebens sie verrieten.]]
    f.relations = {
        { name = "Die Horde", text = "Ein Zweckbündnis, eingegangen, weil die „primitiven Völker\" dem Sieg der Verlassenen dienen konnten; sie verfolgen eigene Ränke, und die Orcs beobachten ein Volk, das Gefangene still umbringt und an eigenen Verbündeten experimentiert." },
        { name = "Die Tauren", text = "Ihre standhaftesten Fürsprecher; die Absichten des Rates der Ältesten sind rein, während ein versiegelter Brief von einem Bündnis zwischen Verlassenen und Grimmtotems sprach." },
        { name = "Die Revantusk-Trolle", text = "Entgegenkommend genug, um Seite an Seite gegen den Scharlachroten Kreuzzug zu kämpfen." },
        { name = "Die lebende Welt", text = "Menschen nennen sie „Totlinge\", „Moderer\" und „Knochensäcke\"; der Scharlachrote Kreuzzug zählt sie ungeachtet der Gesinnung zu den Monstern, und die Verlassenen fälschen Dokumente, um Allianz-Kreuzzug-Verhältnisse zu vergiften." },
    }
    f.groups["undercity"] = { name = "Die Unterstadt", lore = "Die Verlassenen-Nation unter Sylvanas Windläufer, der Bansheekönigin; der Schreckenslord Varimathras dient als ihr Majordomus." }
    f.groups["royal_apothecary_society"] = { name = "Die Königliche Apothekervereinigung", lore = "Faranells Alchemisten und Nekromanten des Apothekariums, die Monstrositäten zusammennähen und die Neue Seuche verfolgen." }
    f.groups["deathguard"] = { name = "Die Todeswache", lore = "Die Soldaten und Wachen der Verlassenen, die Straßen und Dörfer Tirisfals haltend." }
    f.groups["deathstalkers"] = { name = "Die Todespirscher", lore = "Spione, Assassinen und Kundschafter in den dunklen Orten der Lebenden." }
    f.groups["defilers"] = { name = "Die Entweihten", lore = "Die Heerschar der Verlassenen, mit dem Auftrag, die Ressourcen des Arathibeckens zu beanspruchen." }
    f.groups["dark_rangers"] = { name = "Die dunklen Waldläufer", lore = "Untote elfische Waldläufer unter der Bansheekönigin, Erben Quel'Thalas' eigen." }
    f.groups["cult_of_forgotten_shadow"] = { name = "Der Kult des Vergessenen Schattens", lore = "Der Orden der Schattenpriester, geboren aus Natalie Selines wiedergefundenen Lehren." }
    f.groups["scourge_and_the_scarlet_crusade"] = { name = "Die Geißel und der Scharlachrote Kreuzzug", lore = "Die zwei belagernden Feinde: die Meister, denen sie entrannen, und die Zeloten, die sie vernichten würden." }
    f.figureText["sylvanas_windrunner_forever"] = { name = "Sylvanas Windläufer", role = "Die Dunkle Fürstin, Bansheekönigin der Verlassenen", aff = "Verlassene, Horde", title = "Die Dunkle Fürstin, Bansheekönigin der Verlassenen — Verlassene, Horde" }
    f.figureText["varimathras_forever"] = { name = "Varimathras", role = "Erz-Lord der Unterstadt, Sylvanas' Majordomus", aff = "Verlassene", title = "Erz-Lord der Unterstadt, Sylvanas' Majordomus — Verlassene" }
    f.figureText["nathanos_blightcaller"] = { name = "Nathanos Pestrufer", role = "Champion der Bansheekönigin, Waldläuferlord", aff = "Verlassene", title = "Champion der Bansheekönigin, Waldläuferlord — Verlassene" }
    f.figureText["master_apothecary_faranell"] = { name = "Meisterapotheker Faranell", role = "Leiter der Königlichen Apothekervereinigung", aff = "Apothekervereinigung", title = "Leiter der Königlichen Apothekervereinigung — Apothekervereinigung" }
    f.figureText["belmont"] = { name = "Belmont", role = "Führer der Todespirscher", aff = "Todespirscher", title = "Führer der Todespirscher — Todespirscher" }
    f.figureText["alexi_barov"] = { name = "Alexi Barov", role = "Erbe des Hauses Barov", aff = "Verlassene", title = "Erbe des Hauses Barov — Verlassene" }
    f.figureText["helcular"] = { name = "Helcular", role = "Nekromant der Verlassenen", aff = "Verlassene", title = "Nekromant der Verlassenen — Verlassene" }
    f.figureText["gunther_arcanus"] = { name = "Gunther Arcanus", role = "Lich, rekrutiert vom Apothekarium", aff = "Verlassene", title = "Lich, rekrutiert vom Apothekarium — Verlassene" }
    f.figureText["leonid_barthalomew"] = { name = "Leonid Barthalomew", role = "Forscher des Untods", aff = "Argentumdämmerung", title = "Forscher des Untods — Argentumdämmerung" }
    f.figureText["alonsus_faol"] = { name = "Alonsus Faol", role = "Ehemaliger Erzbischof der Kirche des Heiligen Lichts", aff = "Kirche", title = "Ehemaliger Erzbischof der Kirche des Heiligen Lichts — Kirche" }
end

f = IMAGOdb.races["tauren"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Tauren"
    f.groupTabLabel = "Stämme"
    f.quote = { text = "In die tapferen Herzen ihrer reinen Kinder legte die Erdenmutter die Liebe zur Jagd. Denn die Geschöpfe der ersten Dämmerung waren wild und grausam. Sie versteckten sich vor der Erdenmutter und fanden Trost im Schatten und an den wilden Orten des Landes. Die Shu'halo jagten diese Bestien, wo immer sie sie fanden, und zähmten sie mit dem Segen der Erdenmutter.", author = "Der weiße Hirsch und der Mond" }
    f.overview = "Die Tauren, shu'halo in ihrer eigenen Zunge, sind ein edles Volk gewaltiger rinderhafter Humanoide, das seit unzähligen Geschlechtern die Ebenen Kalimdors durchzog, stets bedrängt von den brutalen Zentauren. Als Thralls Horde Cairne Bluthuf half, die Zentauren abzuwehren und das üppige Tal von Mulgore zu erreichen, errichtete Oberhäuptling Cairne Bluthuf mit Donnerfels die erste Stadt der Tauren auf seinen Tafelbergen. In Anerkennung der Ehre und Tapferkeit ihrer neuen Freunde traten die Tauren der neuen Horde gern als standhafte Verbündete bei."
    f.facts = {
        faction = "Horde",
        capital = "Donnerfels, Mulgore",
        leader = "Oberhäuptling Cairne Bluthuf (beraten von Erzdruide Hamuul Runentotem und der Ältestenmatrone Magatha Grimmtotem)",
        mount = "Kodo",
        language = "Taur-ahe, Orcisch",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "SHAMAN" }, { classFile = "DRUID" } }
    f.history = [[Die Tauren stammen von den Yaungol ab, einem rinderhaften Volk des alten Kalimdor, das in Frieden mit dem Halbgott Cenarius lebte, ehe es südwärts getrieben und von den Mogu versklavt wurde. In der Pandaren-Revolution befreit, wanderten manche Yaungol nordwärts zurück und siedelten am Brunnen der Ewigkeit, und dort wandelten die Energien des Brunnens sie zu den Tauren. Die Zerschlagung schnitt sie für immer von ihren Yaungol- und Taunka-Verwandten ab.

Im Krieg der Ahnen folgten die Tauren-Stämme von Highmountain dem Ruf Korialstrasz' und marschierten unter Huln Highmountain, Träger des Adlerspeers, dessen Tapferkeit ihnen den Segen des Cenarius einbrachte, die Hörner Eche'ros. Jahrtausende später weckten die Shu'halo des Brachlands Prinzessin Theradras unter der heiligen Wiese von Mashan'she und entfesselten unwissend Verderben: Die Elementare sog das Land zu Desolace aus, und ihre Verbindung mit Zaetar, Sohn des Cenarius, gebar die Zentauren, die ihren Vater ermordeten und die Tauren in einen endlosen Nomadenkrieg trieben. Geschlechter lang durchstreiften die Stämme das Brachland auf Kodo-Jagd, nur vereint im Hass auf den Erzfeind.

Die Ausrottung stand bevor, als Cairne Bluthuf die grünhäutigen Fremden von über dem Meer fand. Mit Thralls Orcs an ihrer Seite trieb der Bluthufstamm die Zentauren zurück und gewann die Graslande Mulgores, die erste wahre Heimat seit Jahrtausenden, und Cairne errichtete Donnerfels als Zuflucht für jeden Stamm. Durch Blutschuld gebunden standen die Tauren mit der Horde am Berg Hyjal. Nun haben sich die verstreuten Stämme unter dem weisen Oberhäuptling vereint, doch der Friede ist nicht ganz: Die Grimmtotems planen, seine Herrschaft zu usurpieren, die Borstennacken drängen nach Mulgore, und ein fremdes Übel ist in den Smaragdgrünen Traum selbst eingekrochen.]]
    f.culture = [[Die Shu'halo streben nach Gleichgewicht: Ihre Krieger kämpfen nur, wenn es Not tut, ihre Jäger nehmen nur, was die Stämme zum Leben brauchen, und ihre Schamanen stehen als Führer und Mittler zu den Geistern der Elemente. Sie sind ein ruhiges, beständiges Volk, das weise Beratung dem Übereilten vorzieht und seine Ältesten tief ehrt, doch die Riten der Großen Jagd sind das Herz ihrer geistigen Kultur, und jeder Tauren sucht seine Bestimmung als Jäger und Kind der Erdenmutter. Man lehrt sie, nichts zu verschwenden, was die Natur gibt, denn ehrt man die Erdenmutter, segnet sie im Gegenzug.

Ihr Glaube gilt der Erdenmutter, ihrer Schöpferin: Als ihre Kinder den verderbenden Stimmen unter der Erde verfielen, riss sie sich die Augen aus und setzte sie ewig über den Himmel kreisend, Mu'sha der Mond und An'she die Sonne, keins größer als das andere. Dunkelheit gilt ihnen nicht als böse, sondern als natürlich. Ihre Toten werden nicht begraben, sondern verbrannt, rituell gewaschen, gehüllt und Scheiterhaufen, Wind und Fluss übergeben, eins zu werden mit Erdenmutter und Himmelsvater; nur die Tapfersten ruhen am heiligen Roten Fels. Junge Tauren verdienen den Rang des Kriegers durch die Riten der Erdenmutter: Stärke, Mut, Ehre, Winde, Vision und Weisheit. Kodos tragen sie; Wyvern sind heilig. Weißfellige Tauren, als Omen eines kommenden Zeitalters gewertet, wandern als einsiedlerische Priester durchs Land.]]
    f.relations = {
        { name = "Die Horde", text = "Unerschütterliche Verbündete, durch Blutschuld gebunden; die Grimmtotems bleiben der einzige Stamm, der ihr nie förmlich beitrat." },
        { name = "Die Verlassenen", text = "Die gutherzigen Tauren waren Sylvanas' vielversprechendste Tür in die Horde; der Rat der Ältesten hofft noch, ihren Fluch zu heilen." },
        { name = "Die Allianz", text = "Das geringst feindselige Volk der Horde; doch zwergisches Graben vernarbt die Erdenmutter in ihren Augen, und die Zwerge von Burg Bael'dun löschten den Steinsäulen-Stamm beinahe aus." },
        { name = "Nachtelfen", text = "Ihr bestes Band über die Fronten hinweg: geteilter druidischer Glaube und die offenen Tore der Mondlichtung, Hamuul wirkt Seite an Seite mit den Kaldorei im Zirkel des Cenarius." },
        { name = "Die Zentauren", text = "Der ewige Feind, aus ihrem eigenen tragischen Erwecken geboren; die Unterstützung der Horde hat den uralten Krieg endlich zu Tauren-Gunsten gewendet." },
        { name = "Die Stacheleber", text = "Räuber von Land und Nahrung; die Borstennacken kriegen seit Jahren gegen die Rotwolken-Mesa." },
        { name = "Harpyien", text = "Die Windfurien-Kovenn plündern Kodo-Herden und kriegen um die Steinkrallen." },
        { name = "Furbolgs", text = "Seit dem Krieg der Ahnen befreundet." },
    }
    f.groups["bloodhoof_tribe"] = { name = "Bluthufstamm", lore = "Cairnes eigener Stamm, herrschend vom Bluthufdorf und Donnerfels aus." }
    f.groups["grimtotem_tribe"] = { name = "Grimmtotem-Stamm", lore = "Das aggressive Äußerste der Taurenkindschaft, den übrigen Stämmen offen feindlich und unter der Ältestenmatrone Magatha darauf sinnend, Cairnes Herrschaft zu usurpieren." }
    f.groups["runetotem_tribe"] = { name = "Runentotem-Stamm", lore = "Hamuuls Stamm, Herz der Tauren-Druidik auf Donnerfels." }
    f.groups["tribes_of_thunder_bluff"] = { name = "Die Stämme Donnerfels'", lore = "Wolkensang, Dämmerwandler, Adlerklaue, Falkenwind, Wutentotem, Himmelsjäger, Stahlwut, Steinhuf, Donnerhorn, Wildmähne und Winterhuf." }
    f.groups["far_tribes"] = { name = "Die fernen Stämme", lore = "Klippenläufer am Freiwindposten, Klippenwandler in den Steinkrallen, Eisenhuf im Letzten Wald von Desolace, Weitwanderer am Camp Narache, Steinsäulen des südlichen Brachlands." }
    f.groups["earthen_ring"] = { name = "Irdener Ring", lore = "Der weltumspannende Kreis der Schamanen, ursprünglich von Tauren gegründet; sein Rat der Ältesten regiert Donnerfels neben dem Oberhäuptling." }
    f.groups["longwalkers"] = { name = "Weitläufer", lore = "Späher und Boten, allein dem Oberhäuptling verschworen." }
    f.groups["outrunners"] = { name = "Ausreiter", lore = "Hüter jedes Reisenden quer durch die Ebenen Mulgores." }
    f.figureText["cairne_bloodhoof_forever"] = { name = "Cairne Bluthuf", role = "Oberhäuptling der vereinten Tauren-Stämme", aff = "Horde, Donnerfels", title = "Oberhäuptling der vereinten Tauren-Stämme — Horde, Donnerfels" }
    f.figureText["baine_bloodhoof"] = { name = "Baine Bluthuf", role = "Sohn Cairnes, Erbe des Bluthufstamms", aff = "Horde, Donnerfels", title = "Sohn Cairnes, Erbe des Bluthufstamms — Horde, Donnerfels" }
    f.figureText["magatha_grimtotem"] = { name = "Magatha Grimmtotem", role = "Ältestenmatrone des Grimmtotem-Stamms", aff = "Grimmtotem", title = "Ältestenmatrone des Grimmtotem-Stamms — Grimmtotem" }
    f.figureText["hamuul_runetotem"] = { name = "Hamuul Runentotem", role = "Erzdruide der Tauren, Schüler Malfurions", aff = "Donnerfels, Zirkel des Cenarius", title = "Erzdruide der Tauren, Schüler Malfurions — Donnerfels, Zirkel des Cenarius" }
    f.figureText["huln_highmountain"] = { name = "Huln Hochberg", role = "Führer der Stämme im Krieg der Ahnen", aff = "Kaldorei-Resistance", title = "Führer der Stämme im Krieg der Ahnen — Kaldorei-Resistance" }
    f.figureText["muln_earthfury"] = { name = "Muln Erdwut", role = "Führer des Irdenen Rings", aff = "Irdener Ring", title = "Führer des Irdenen Rings — Irdener Ring" }
    f.figureText["perith_stormhoof"] = { name = "Perith Sturmhuf", role = "Einer der ältesten Weitläufer", aff = "Bluthufstamm", title = "Einer der ältesten Weitläufer — Bluthufstamm" }
    f.figureText["tagar_bloodhoof"] = { name = "Tagar Bluthuf", role = "Zweiter unter Cairne", aff = "Bluthufstamm", title = "Zweiter unter Cairne — Bluthufstamm" }
    f.figureText["bovan_windtotem"] = { name = "Bovan Windtotem", role = "Anführer des Windtotem-Stamms", aff = "Windtotemstamm", title = "Anführer des Windtotem-Stamms — Windtotemstamm" }
    f.figureText["fleet_master_seahorn"] = { name = "Flottenmeister Seahorn", role = "Flottenmeister der Schwarzwasserpiraten", aff = "Schwarzwasser-Piraten", title = "Flottenmeister der Schwarzwasserpiraten — Schwarzwasser-Piraten" }
    f.figureText["xarantaur"] = { name = "Xarantaur", role = "Behüter, Schüler des Cenarius", aff = "Bronzener Drachenschwarm", title = "Behüter, Schüler des Cenarius — Bronzener Drachenschwarm" }
    f.figureText["trag_highmountain"] = { name = "Trag Hochberg", role = "Reisender, ins Untod erhoben", aff = "Unabhängig", title = "Reisender, ins Untod erhoben — Unabhängig" }
end


-- ============================================================
-- BOTH FACTIONS (WoW Forever exclusive)
-- ============================================================

f = IMAGOdb.races["skyborne"]
if f then
    f.figureText = f.figureText or {}
    f.name = "Himmelsgeborene"
    f.groupTabLabel = "Orden"
    f.quote = { text = "Also, nun seht ihr es? Es gibt eine Welt voller Wissen und ungenutztem Potenzial außerhalb von Skywall. Das wird niemals aufhören, unsere Heimat zu sein, doch ich bin zu der Überzeugung gelangt, dass der Pfad zu unserer Rettung weiter unten liegt. Wir müssen nach Azeroth reisen und die Macht und die Mittel erlangen, Zephras Isle zu retten. So ist der Weg. Werdet ihr den Mut haben, euch uns anzuschließen, wenn es so weit ist?", author = "Ayessa Dawnsinger" }
    f.overview = "Die Himmelsgeborenen, die Shen'dorei oder „das verborgene Volk\", sind ein Elfenvolk, das von den Bürgern Eldre'Thalas' abstammt, Hochgeborene Magister wie Kaldorei gleichermaßen, die vor beinahe zehntausend Jahren Prinz Tortheldrins Verfolgung flohen. Sie schlossen einen Pakt mit den Windgeistern von Skywall, die Zephras Isle in die Elementarebene der Luft hoben, und dort bauten sie eine seit Jahrtausenden verborgene Zivilisation. Nun sind die Windgeister verschwunden, die Pylonen, die ihre Inseln tragen, versagen, und die Himmelsgeborenen steigen auf Azeroth herab, um ihre Heimat zu retten: Der Hohe Orden sucht die arkanen Weisheiten der Allianz, die Windformer die Schamanen der Horde."
    f.facts = {
        faction = "Allianz (Hoher Orden) und Horde (Windformer); der Al'Aketh-Kult folgt Al'Akir",
        capital = "Valanaar, Zephras Isle (Elementarebene der Luft)",
        leader = "Hochältester Talaanis Shadowsong (Rat von Zephras), Oberster Magister Elaadrin Evengale (Hoher Orden), Groß-Himmelsseherin Ayessa Dawnsinger (Windformer), Hohepriesterin Lorthuna (Al'Aketh)",
        mount = "Sturmschreiter",
        language = "Darnassisch, Gemeinsprache, Orcisch",
    }
    f.classes = { { classFile = "WARRIOR" }, { classFile = "HUNTER" }, { classFile = "ROGUE" }, { classFile = "DRUID" }, { classFile = "MAGE", note = "nur Hoher Orden" }, { classFile = "SHAMAN", note = "nur Windformer" } }
    f.history = [[Nachdem die Zerschlagung Eldre'Thalas nach Magie hungern ließ, schlug Prinz Tortheldrin vor, Kraft aus einer Dämonenwelt durch kristalline Foki zu ziehen. Als Adelsgeschlechter den Plan ablehnten, brachte er sie in einer einzigen blutigen Nacht von Säuberungen zum Schweigen. Der Widerstand, den er schuf, wurde vom Shal'nan geführt, dem „Verschleierten", einer maskierten Gestalt, deren Name zum Schlachtruf wurde. Am Vorabend des Beschwörungsrituals stürmten die Rebellen das innere Sanktum: Wilde Magie barst, Portale rissen auf, und obwohl die Rebellen die Vernichtung der Stadt abwendeten, ging der Shal'nan als einziger Überlebender des Zusammenstoßes hervor, für immer verändert und seitdem verschlossen über das, was er sah.

Zerstreut, doch frei, flohen die Rebellen westwärts durch Eldre'narr und segelten ins Ungewisse. Dort fanden sie ein unentdecktes Land unter der Herrschaft urzeitlicher Windgeister, und mit Tortheldrins Flotte im Nacken handelten sie: Die Geister hoben eine ganze Landmasse in den Himmel und verankerten Zephras Isle in Skywall. Jahrtausende gediehen die Shen'dorei verborgen in der Elementarebene der Luft. Der Shal'nan legte seine Herrschaft bei der Grundsteinlegung des Schreins der Vier Winde nieder und übergab die Regierung gewählten Ältestenräten. Skywall veränderte sie, und in jüngeren Generationen wurden Kinder mit leuchtend himmelblauer Haut geboren, der „Himmelsberührte Segen", der nun drei von zehn Neugeborenen auszeichnet. Und obwohl sie unter den Windgeistern lebten, sprachen die Geister Al'Akirs Namen nie aus.

Dann, vor einigen Jahrhunderten, verschwanden die Windgeister, und der Shal'nan mit ihnen. Ohne ihre Magie begannen die alten Pylonen zu versagen; Ban'aethal stürzte aus dem Himmel und Flüchtlinge drängten sich auf Zephras Isle. Der Hohe Orden und die Windformer entzweiten sich über die Antwort: Elaadrin Evengales Magister öffneten ein „Schlüsselloch" nach Azeroth und gewannen das Willkommen der Kirin Tor; Ayessa Dawnsinger erreichte den Irdischen Ring und schlug vor, dessen schamanische Meisterschaft auf Kalimdor zu suchen. Die Missstimmung wuchs, und die Al'Aketh, der verborgene Kult der Anbeter Al'Akirs, schlugen auf die Pylonen. Nur ein verzweifelter Waffenstillstand von Hohem Orden, Windformern und Friedensbewahrern stoppte Hohepriesterin Lorthuna am Schrein von Akir, zu spät. Rohash vom Konklave der Winde beantwortete ihr Signal und rief die Armeen des Windlords; nur die Kirin Tor und der Irdene Ring zwangen ihn zum Rückzug, mit seinem Versprechen, Al'Akir von den Inseln Kunde zu bringen. Mit entblößter Zuflucht und versagender Heimat zogen die Himmelsgeborenen gen Azeroth: der Hohe Orden zur Allianz, die Windformer zur Horde.]]
    f.culture = [[Die Shen'dorei werden nicht von Königen regiert, sondern vom Rat der Ältesten, demokratisch gewählten Provinzführern, je ein Rat pro Insel, wobei Hochältester Talaanis Shadowsong über den Rat von Zephras Isle wacht. Ihr Glaube ist elementar: Die Schamanen der Windformer sind die geistigen Führer, hüten heilige Stätten wie die Steinkreise der Shen'dar-Hochlande und lehren die Himmelssicht, die Gabe, Elementargeister zu erkennen und mit ihnen zu verkehren, eine Gabe, die mit jedem Jahr seltener wird. Die Magister des Hohen Ordens jagen stattdessen dem arkanen Erbe ihrer Hochgeborenen-Vorfahren nach und schöpfen Kraft aus den Leylinien, die immer näher an die Inseloberfläche steigen. Die Druidik überlebt, selten; manche „träumen noch in Smaragd".

Ihre Handwerke und Bräuche tragen Skywalls Stempel: Windsteine fassen konzentrierte Elementarkraft als Währung und Brennstoff zugleich; Himmelsschneider tragen sie zwischen den Inseln; die Magieschmiede des gefallenen Ban'aethal waren die besten Handwerker der Inseln. Beim Erwachsenwerden erhält jeder Shen'dorei ein Erbstück von den Toten weitergegeben, zurückgegeben an eine gemeinsame Sammlung, um eine neue Jugend zu segnen, und im Tod wird die Asche den Winden übergeben. Ihr Tisch kennt Krebsfleisch und in Ursera-Talg gebratene Eier; selbst ein schlichtes Blatt wie getrocknetes Friedensblumenkraut findet seinen Weg in eine Pfeife.]]
    f.relations = {
        { name = "Die Allianz", text = "Gebunden durch die Kirin Tor, die das Schlüsselloch des Hohen Ordens erkannten und sie als Gäste aufzunehmen einwilligten; der Hohe Orden kämpft an ihrer Seite um verlorenes arkanes Wissen." },
        { name = "Die Horde", text = "Gebunden durch den Irdischen Ring, dessen Schamanen die Windformer als um Größenordnungen weiser in den Elementarebenen zählen; die Windformer kämpfen an ihrer Seite, um die Himmelssicht zu meistern und die verschwundenen Gönner heimzurufen." },
        { name = "Zwischen den Orden", text = "Bitter. Der Hohe Orden drängt auf eigenständige arkane Meisterschaft, während die Windformer den Geistern die Treue halten; Sabotage und tote Magister haben den Frieden des Schreins von Akir zu einem bloßen, zeitweiligen Waffenstillstand gemacht." },
        { name = "Al'Akir und seine Konklave", text = "Die drohende Gefahr. Rohash weiß nun von ihnen und hat geschworen, dem Windlord Kunde zu bringen." },
        { name = "Die Kaldorei", text = "Das Volk ihrer Vorfahren, von dem sie sich vor zehntausend Jahren trennten; die Nachtelfen wissen nichts von ihrem Überleben." },
        { name = "Die Windgeister", text = "Ihre verschwundenen Gönner, „irrende Brüder\" von Rohashs Konklave nach seinen eigenen Worten." },
    }
    f.groups["high_order"] = { name = "Der Hohe Orden", lore = "Nachkommen der Hochgeborenen-Magister Eldre'Thalas' unter Oberstem Magister Elaadrin Evengale; das arkanische Wissen der Ahnen zurückgewinnend und an der Seite der Allianz stehend." }
    f.groups["windshapers"] = { name = "Die Windformer", lore = "Nachkommen der Kaldorei-Bürger unter Groß-Himmelsseherin Ayessa Dawnsinger; schamanische geistige Führer der Shen'dorei, an der Seite der Horde stehend." }
    f.groups["alaketh"] = { name = "Die Al'Aketh", lore = "Der Kult Al'Akirs des Windlords unter Hohepriesterin Lorthuna; zu Prominenz aufgestiegen seit dem Verschwinden der Geister und geschworen, den Blick des Windlords auf Zephras zu lenken." }
    f.groups["peacekeepers"] = { name = "Die Friedensbewahrer", lore = "Zephras Isles Miliz und das Nächste an einer Armee; die Empyrean-Klingen, einst die Leibgarde des Shal'nan, dienen nun als ihre Elite unter Hauptmann Valennia Stormfist." }
    f.groups["nightclaw_druids"] = { name = "Die Nachtklaue-Druiden", lore = "Geheimnisvolle Druiden des Schattenwindwaldes, unabhängig von jeder anderen Fraktion." }
    f.groups["rangers_of_thendal_grove"] = { name = "Die Waldläufer des Thendal-Hains", lore = "Waldläufer, die Dorf Thendal und dessen Umland hüten." }
    f.groups["council_of_elders"] = { name = "Der Rat der Ältesten", lore = "Die demokratischen Regierungen der Inseln, je einer pro Insel." }
    f.figureText["the_shalnan"] = { name = "Der Shal'nan", role = "„Der Verschleierte\", erster Führer der Shen'dorei", aff = "Shen'dorei", title = "„Der Verschleierte\", erster Führer der Shen'dorei — Shen'dorei" }
    f.figureText["talaanis_shadowsong"] = { name = "Talaanis Shadowsong", role = "Hochältester von Zephras Isle", aff = "Rat der Ältesten", title = "Hochältester von Zephras Isle — Rat der Ältesten" }
    f.figureText["valennia_stormfist"] = { name = "Valennia Stormfist", role = "Hauptmann der Friedensbewahrer", aff = "Friedensbewahrer", title = "Hauptmann der Friedensbewahrer — Friedensbewahrer" }
    f.figureText["elaadrin_evengale"] = { name = "Elaadrin Evengale", role = "Oberster Magister des Hohen Ordens", aff = "Hoher Orden, Allianz", title = "Oberster Magister des Hohen Ordens — Hoher Orden, Allianz" }
    f.figureText["ayessa_dawnsinger"] = { name = "Ayessa Dawnsinger", role = "Groß-Himmelsseherin der Windformer", aff = "Windformer, Horde", title = "Groß-Himmelsseherin der Windformer — Windformer, Horde" }
    f.figureText["high_priestess_lorthuna"] = { name = "Hohepriesterin Lorthuna", role = "Führerin der Al'Aketh, in den Himmel geschleudert", aff = "Al'Aketh", title = "Führerin der Al'Aketh, in den Himmel geschleudert — Al'Aketh" }
    f.figureText["belathaan_brightwish"] = { name = "Belathaan Brightwish", role = "Magister des Hohen Ordens", aff = "Hoher Orden", title = "Magister des Hohen Ordens — Hoher Orden" }
    f.figureText["commander_haalien"] = { name = "Kommandant Haalien", role = "Ehemaliger Nachtklaue, zum Kult übergetreten", aff = "Al'Aketh", title = "Ehemaliger Nachtklaue, zum Kult übergetreten — Al'Aketh" }
    f.figureText["elegael_thornpaw"] = { name = "Elegael Thornpaw", role = "Führerin der Nachtklaue-Druiden", aff = "Nachtklaue", title = "Führerin der Nachtklaue-Druiden — Nachtklaue" }
    f.figureText["lotheluum_starbreeze"] = { name = "Lotheluum Starbreeze", role = "Ermittlerin der Al'Aketh-Angriffe", aff = "Unabhängig", title = "Ermittlerin der Al'Aketh-Angriffe — Unabhängig" }
    f.figureText["illaya_amberwing"] = { name = "Illaya Amberwing", role = "Mentorin Ayessas, alternde Himmelssicht-Trägerin", aff = "Windformer", title = "Mentorin Ayessas, alternde Himmelssicht-Trägerin — Windformer" }
    f.figureText["dorii_brightwhisper"] = { name = "Dorii Brightwhisper", role = "Fürsprecherin arkaner Selbstgenügsamkeit", aff = "Hoher Orden", title = "Fürsprecherin arkaner Selbstgenügsamkeit — Hoher Orden" }
    f.figureText["resaan"] = { name = "Resaan", role = "Bewohner des gefallenen Ban'aethal", aff = "Unabhängig", title = "Bewohner des gefallenen Ban'aethal — Unabhängig" }
    f.figureText["ealaane_nimbuswalker"] = { name = "Ealaane Nimbuswalker", role = "Witwe Resaans", aff = "Unabhängig", title = "Witwe Resaans — Unabhängig" }
end

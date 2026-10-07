-- ============================================================
-- IMAGO Forever — locales/deDE/data/factions.lua
-- German localization
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.factions = IMAGOdb.factions or {}

-- ============================================================
-- ALLIANZ
-- ============================================================

local f = IMAGOdb.factions["kingdom_of_stormwind"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Königreich Sturmwind"
    f.source = "warcraft.wiki.gg/wiki/Stormwind_(kingdom)"
    f.history = [[
Das letzte große Menschenkönigreich. Sturmwind fiel im Ersten Krieg an die Horde, wurde im Zweiten wieder aufgebaut und ist heute das schlagende Herz der Allianz — stolz, narbenübersät und hoch verschuldet.
Da König Varian Wrynn auf See verschollen ist, regiert Regent Bolvar Fordragon im Namen seines Sohnes, während am Hof die Intrigen von Lady Katrana Prestor flüstern. Die unbezahlten Steinmetzen wurden zu Banditen, und die Defias plagen die Kornkammer des Königreichs. Sturmwind besteht — aber es ist ein Reich, das nur durch Wachsamkeit und Schulden zusammengehalten wird.]]
    f.culture = {
        biology = "Die Menschen Sturmwinds sind ein zähes, kurzlebiges Volk, geformt von zwei Kriegen und einer wiedererbauten Heimat. Sie schätzen kriegerische Tradition und bürgerlichen Stolz.",
        beliefs = "Die Kirche des Heiligen Lichts ist das spirituelle Fundament des Königreichs, ihr Zentrum die Kathedrale des Lichts. Paladine und Priester der Silberhand-Tradition genießen Ehrenplätze.",
        relations = "Der Anker der Allianz — enge Bande mit Eisenschmiede, den Gnomeregan-Exilanten und Darnassus. Der Horde seit dem Ersten Krieg feindlich gesinnt, doch Theramore hält einen Kanal offen.",
    }
    f.subgroups["house_of_nobles"] = { name = "Haus der Noblen", lore = "Der zänkische Adel, der im Namen des Kindkönigs herrscht. Zu viele Schulden, zu viele Geheimnisse — und eine Gräfin, die nicht ist, was sie scheint." }
    f.subgroups["westfall_brigade"] = { name = "Westfallbrigade", lore = "Die Volksmiliz hält die Kornkammer gegen die Bruderschaft der Defias — unbezahlt, unterbesetzt und unbeugsam." }
    f.subgroups["si7"] = { name = "SI:7", lore = "Sturmwinds Geheimdienst. Mathias Shaws Agenten beobachten die Feinde des Königreichs — und manchmal den eigenen Hof." }
    f.memberText["katrana_prestor"] = { name = "Lady Katrana Prestor", title = "Königliche Beraterin — und mehr, als sie scheint" }
    f.settlementText[84] = { name = "Sturmwind", lore = "Die weißgemauerte Hauptstadt, nach dem Ersten Krieg Stein für Stein wiedererrichtet. Die Heldenstatuen säumen das Tal der Helden." }
end

f = IMAGOdb.factions["ironforge_dwarves"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Zwerge von Eisenschmiede"
    f.source = "warcraft.wiki.gg/wiki/Kingdom_of_Ironforge"
    f.history = [[
Erben der Irdenen. Die Zwerge von Khaz Modan gruben zu tief und weckten Dinge, die besser begraben geblieben wären — eine Geschichte, die sie stolz wiederholen. Eisenschmiede ist nie gefallen.
König Magni Bronzebeard hält die Klans durch Gram und Grimm zusammen: sein Bruder Muradin tot in Nordend, seine Tochter Moira an die Dunkeleisen verloren, sein Volk gespalten zwischen Berghallen und Oberflächenkriegen. Was Eisenschmiede an Zahl fehlt, zahlt es in Sturheit und Stahl zurück.]]
    f.culture = {
        biology = "Stämmig, langlebig und wie aus der Erde selbst gehauen. Zwergische Gesellschaft läuft über Klan-Treue, Handwerkskunst und Bier.",
        beliefs = "Ein pragmatischer Glaube — das Heilige Licht dient, doch die Ahnen und die Mysterien der Titanen füllen die zwergische Seele. Die Forscherliga jagt ihrem titanengeschmiedeten Ursprung nach.",
        relations = "Sturmwinds ältester Verbündeter und das Arsenal der Allianz. Alte Fehden mit den Dunkeleisen schwelen — und weniger offen gegen jeden, der zwergische Opfer vergisst.",
    }
    f.subgroups["bronzebeard_clan"] = { name = "Bronzebeard-Klan", lore = "Der herrschende Klan Eisenschmiedes, geführt von König Magni. Hüter des Berges und alter Schuldner." }
    f.subgroups["explorers_league"] = { name = "Forscherliga", lore = "Zwergische Archäologen, die weltweit nach Titanenrelikten graben. Brann Bronzebeard führt ihre wildesten Expeditionen." }
    f.memberText["moira_bronzebeard"] = { name = "Moira Bronzebeard", title = "König Magnis Tochter — nun Kaiserin der Dunkeleisen" }
    f.memberText["brann_bronzebeard"] = { name = "Brann Bronzebeard", title = "Forscher, Chronist, der wandernde Bronzebeard" }
    f.settlementText[87] = { name = "Eisenschmiede", lore = "Die Bergstadt, die nie gefallen ist — ein Schmiedeherz aus Ambossen, Bier und uraltem Stein." }
end

f = IMAGOdb.factions["gnomeregan_exiles"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Gnomeregan-Exilanten"
    f.source = "warcraft.wiki.gg/wiki/Gnomeregan_(nation)"
    f.history = [[
Die Gnome verloren alles an einem einzigen Tag. Als Troggs in Gnomeregan einbrachen, folgte Hochtüftler Mekkatorque dem Rat seines Beraters Thermaplugg und flutete die Stadt mit Strahlung — tötete die meisten Eindringlinge und die meisten seines Volkes.
Nun eine Nation von Flüchtlingen in Eisenschmiedes Tüftlerstadt, vergraben die Gnome ihre Trauer in Erfindungen. Mekkatorque hat nie aufgehört, die Rückeroberung zu planen — und manche Exilanten haben ihm nie verziehen, dass er sie befohlen hat.]]
    f.culture = {
        biology = "Klein, brillant und langlebig. Die gnomische Gesellschaft stellt Erfindungsgenie über Geburtsrecht — der Hochtüftler ist ein gewähltes Amt.",
        beliefs = "Gnome setzen eher auf Physik als auf Priester. Was an Ehrfurcht existiert, gilt der Logik, der Erfindung und gelegentlich der Maschine, die nicht funktionieren sollte, es aber tut.",
        relations = "Gäste Eisenschmiedes und treue Allianz-Mitglieder — obwohl manche Zwerge es still übelnehmen, ein Volk zu beherbergen, das die eigene Hauptstadt verstrahlt hat.",
    }
    f.subgroups["survivors_of_gnomeregan"] = { name = "Überlebende von Gnomeregan", lore = "Die Flüchtlinge der verstrahlten Stadt — Ingenieure, Soldaten und die verstrahlten Überlebenden, über die niemand spricht. Sie alle wollen ihre Stadt zurück." }
    f.memberText["sicco_thermaplugg"] = { name = "Sicco Thermaplugg", title = "Der Verräter — Architekt von Gnomeregans Fall" }
    f.settlementText[27] = { name = "Tüftlerstadt, Eisenschmiede", lore = "Das Viertel der Exilanten in Eisenschmiede — teils Werkstatt, teils Flüchtlingslager, ganz und gar gnomisch." }
end

f = IMAGOdb.factions["darnassus_night_elves"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Nachtelfen von Darnassus"
    f.source = "warcraft.wiki.gg/wiki/Darnassus_(nation)"
    f.history = [[
Vor zehntausend Jahren brachen die Kaldorei die Welt, um sie zu retten. Einst unsterblich, opferten sie Nordrassil, um die Legion am Hyjal aufzuhalten — und erwachten als sterbliches, geschwächtes Volk, regiert von einem Weltenbaum, der ohne Segen gepflanzt wurde.
Tyrande Wisperwind führt allein; Malfurion schläft unerweckbar im Traum, und Fandral Hirschhaupt wächst in seiner Abwesenheit über sich hinaus. Der neue Baum der Nachtelfen, Teldrassil, ist bereits krank — auch wenn es nur wenige laut aussprechen.]]
    f.culture = {
        biology = "Groß, violett-häutig, einst unsterblich. Die Kaldorei sind eine kriegerisch-spirituelle Gesellschaft, gespalten zwischen Elunes Priesterinnen und den Druiden des Smaragdgrünen Traums.",
        beliefs = "Elune, die Mondgöttin, ist ihr absoluter Glaube — die Schwesternschaft dient ihr vom Mondtempel aus. Die Druiden hingegen folgen Cenarius und dem Zirkel des Cenarius.",
        relations = "Neueste Mitglieder der Allianz und ihre unnahbarsten. Die Holzoperationen der Horde im Eschental haben aus Nachbarn Feinde gemacht.",
    }
    f.subgroups["sentinels"] = { name = "Die Schildwache", lore = "Die Armee der Nachtelfen — Jägerinnen, Bogenschützinnen und Wächterinnen unter Shandris Mondfeder." }
    f.subgroups["sisterhood_of_elune"] = { name = "Schwesternschaft der Elune", lore = "Das Priesterinnentum, das die kaldoreische Gesellschaft seit vor der Zerschlagung führt. Tyrande steht an seiner Spitze." }
    f.memberText["malfurion_stormrage"] = { name = "Malfurion Sturmgrimm", title = "Erzdruide — verloren im Smaragdgrünen Traum" }
    f.settlementText[89] = { name = "Darnassus", lore = "Die mondhelle Hauptstadt auf Teldrassils Krone — eine gewachsene, nicht gebaute Stadt." }
    f.settlementText[57] = { name = "Teldrassil", lore = "Der zweite Weltenbaum, ohne den Segen der Aspekte gepflanzt. Seine Verderbnis ist für jene sichtbar, die hinsehen." }
end

f = IMAGOdb.factions["theramore"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Theramore"
    f.source = "warcraft.wiki.gg/wiki/Theramore_Isle"
    f.history = [[
Eine Stadt, gebaut von Flüchtlingen und zusammengehalten durch Hoffnung. Jaina Prachtmeer führte die Überlebenden Lordaerons über das Meer und errichtete auf einer sumpfigen Insel im Düstermarschen das letzte menschliche Leuchtfeuer Kalimdors.
Theramore ist Friede aus Fleisch — der Beweis, dass Allianz und Horde sich eine Welt teilen können. Es ist auch fragil: ein Grenzzwischenfall, ein abgefangener Karawanen, ein hartes Jahr könnte es versenken. Jaina weiß das. Sie zahlt den Preis trotzdem.]]
    f.culture = {
        biology = "Überwiegend Menschen aus Lordaeron und Kul Tiras, mit Elfen, Zwergen und Gnomen unter den Verteidigern. Eine Soldaten-Siedler-Gesellschaft an einer feindlichen Grenze.",
        beliefs = "Das Heilige Licht reiste mit ihnen über das Meer, doch Pragmatismus herrscht — auf Kalimdor ist Diplomatie eine Überlebensdoktrin.",
        relations = "Offiziell Allianz, persönlich verbündet mit Thralls Horde. Von Falken auf beiden Seiten verachtet; für den Frieden auf beiden unverzichtbar.",
    }
    f.subgroups["theramore_guard"] = { name = "Theramore-Wache", lore = "Die Verteidiger des Stadtstaates — Hyjal-Veteranen, die Mauern dem Krieg vorziehen." }
    f.settlementText[70] = { name = "Insel Theramore", lore = "Die weißen Türme im Sumpf — Allianz-Brückenkopf, diplomatische Brücke und Pulverfass." }
end

-- ============================================================
-- HORDE
-- ============================================================

f = IMAGOdb.factions["orcs_of_the_horde"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Orcs der Horde"
    f.source = "warcraft.wiki.gg/wiki/Orgrimmar_(faction)"
    f.history = [[
Geboren aus der einfallenden Horde, in Internierungslagern neu geschmiedet und befreit von einem Sklaven, der sich erinnerte, was sein Volk einst war. Thralls Orcs segelten über das Meer in eine Wüste, die niemand wollte, und nannten sie nach seinem Vater.
Die neue Horde ist jung, und ihre Sünden sind frisch. Kriegshymnen-Holzfällerlager im Eschental, abtrünnige Klans der alten Schule und das lange Gedächtnis der Allianz drücken auf Orgrimmars Tore. Thrall hält alles durch schiere moralische Autorität zusammen — und jeder weiß es.]]
    f.culture = {
        biology = "Orcs sind starke, grünhäutige Kinder Draenors — eine Kriegerkultur, die sich unter einem einzigen Kriegshäuptling als schamanistische Klans neu erfindet.",
        beliefs = "Die Elemente, die Ahnen und die Geister des Landes. Thrall stellte den Schamanismus als orcische Seele wieder her; Hexenmeister werden geduldet, nicht vertraut.",
        relations = "Von der Allianz verachtet, aus Not und Eid mit Dunkelspeeren, Tauren und Verlassenen verbündet. Die Horde ist eine Familie von Überlebenden — und alle anderen erinnern sich an die Invasion.",
    }
    f.subgroups["frostwolf_clan"] = { name = "Frostwolfklan", lore = "Thralls eigener Klan, Bewahrer der alten schamanistischen Wege. Drek'Thar führt sie noch in Alteracs Tälern." }
    f.subgroups["warsong_clan"] = { name = "Kriegshymnenklan", lore = "Grom Höllschreis Klan — geehrt für sein Opfer, verachtet für den Blutrausch, den es nicht abwaschen konnte." }
    f.memberText["eitrigg"] = { name = "Eitrigg", title = "Thralls Berater — der Orc, den Tirion Fordring rettete" }
    f.settlementText[85] = { name = "Orgrimmar", lore = "Die Festungsstadt, in Durotars roten Fels geschnitten — neue Hauptstadt eines Volkes, das noch entscheidet, was es ist." }
    f.settlementText[1]  = { name = "Durotar", lore = "Das raue rote Land, das Thrall für die Horde beanspruchte, benannt nach seinem Vater. Skorpide, Stacheleber und hart erkämpfter Stolz." }
end

f = IMAGOdb.factions["darkspear_trolls"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Darkspear-Trolle"
    f.source = "warcraft.wiki.gg/wiki/Darkspear_tribe"
    f.history = [[
Der kleinste Stamm eines zersplitterten Reiches. Aus dem Schlingendorntal vertrieben, auf den Darkspear-Inseln beinahe vernichtet — die Dunkelspeere überlebten nur, weil Thralls Horde im Moment ihrer Auslöschung eintraf.
Vol'jin schwor den Dienst seines Volkes dem Kriegshäuptling — ein Eid, der sie zu Waisen in einer Horde machte, die sie duldet, und zu Trollen, die andere Stämme für schwach halten. Sie wohnen auf den Echoinseln und in Orgrimmars Schatten, beobachtend. Die Dunkelspeere haben immer durch Beobachten überlebt.]]
    f.culture = {
        biology = "Dschungeltrolle — groß, hager, mit Hauer und Regeneration. Der kleinste und anpassungsfähigste Stamm eines gefallenen Reiches.",
        beliefs = "Die Loa, die Ahnen und der Schatten. Dunkelspeer-Schattenjäger wandeln zwischen den Welten; ihr Voodoo ist älter als orcische Ehre.",
        relations = "Durch Eid und Dankbarkeit an die Horde gebunden. Andere Trollstämme verachten sie; die Allianz unterscheidet sie kaum. Ihre Geduld ist legendär und total.",
    }
    f.subgroups["darkspear_shadow_hunters"] = { name = "Dunkelspeer-Schattenjäger", lore = "Priesterjäger des Stammes — loaberührte Killer, die nur Vol'jin gehorchen." }
    f.memberText["senjin"] = { name = "Sen'jin", title = "Vol'jins Vater — starb, als er Thrall vor der Seehexe warnte" }
    f.settlementText[1] = { name = "Echoinseln", lore = "Die hart erkämpfte Inselheimat der Dunkelspeere vor Durotars Küste — gewonnen, verloren und wieder gewonnen." }
end

f = IMAGOdb.factions["the_forsaken"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Die Verlassenen"
    f.source = "warcraft.wiki.gg/wiki/Forsaken"
    f.history = [[
Die Toten, die sich weigerten, liegen zu bleiben. Als der Griff des Lichkönigs nachließ, führte Sylvanas Windläufer die freiwilligen Untoten, um Lordaerons Ruinen zu erobern — und mit ihrem neugewonnenen Willen zu fragen, wofür das Untod taugt.
Die Antwort bisher: Rache, Überleben und die Experimente der Königlichen Apothekervereinigung in Unterstadts Tiefen. Aus Not mit der Horde verbündet, von allen gefürchtet einschließlich der Verbündeten — die Verlassenen sind ein Volk, das sich vollständig darüber definiert, was es nicht vergibt.]]
    f.culture = {
        biology = "Freiwillige Untote — die auferstandenen Bürger des gefallenen Lordaeron. Keine Fortpflanzung; jeder Verlassene ist ein Überlebender der Geißel-Ernte.",
        beliefs = "Der Kult der Vergessenen Schatten — die Licht-Doktrin umgekehrt. Manche halten am alten Glauben fest; die meisten glauben nur an freien Willen, Rache und die Königin.",
        relations = "Horde-Mitglieder per Vertrag, Pariahs von Natur. Der Scharlachrote Kreuzzug jagt sie; die Allianz weigert sich zu glauben, dass sie Menschen sind; die Horde findet sie nützlich und beunruhigend zugleich.",
    }
    f.subgroups["royal_apothecary_society"] = { name = "Königliche Apothekervereinigung", lore = "Die Alchemisten der Unterstadt — offiziell heilen sie den Untod, inoffiziell brauen sie die nächste Seuche." }
    f.subgroups["deathguards"] = { name = "Die Todeswache", lore = "Die Soldaten der Verlassenen — tote Männer auf ewigem Wacht über Länder, die sie begruben." }
    f.memberText["master_apothecary_faranell"] = { name = "Meisterapotheker Faranell", title = "Leiter der Königlichen Apothekervereinigung" }
    f.settlementText[18] = { name = "Unterstadt", lore = "Lordaerons Kanalisation und Krypten unter den Ruinen — Thronsaal der Bansheekönigin." }
end

f = IMAGOdb.factions["thunder_bluff_tauren"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Tauren von Donnerfels"
    f.source = "warcraft.wiki.gg/wiki/Thunder_Bluff_(faction)"
    f.history = [[
Nomaden für tausend Jahre, von den Zentauren fast bis zur Auslöschung gejagt — bis eine fremde grüne Armee ihnen half, Mulgores Tafelberge zu erreichen und endlich stillzustehen.
Cairne Bluthuf vereinte die Stämme auf Donnerfels und schwor Thrall eine Blutschuld. Die Tauren sind das Gewissen der Horde: langsam zum Zorn, unmöglich zu bewegen und — wie die Grimmtotem beweisen — nicht gänzlich einig hinter dem friedlichen Rat des Oberhäuptlings.]]
    f.culture = {
        biology = "Hochgewachsen, gehuf't und uralt. Die Tauren-Gesellschaft ist tribal — Bluthuf, Grimmtotem und kleinere Stämme — gebunden durch gemeinsame Riten der Jagd und der Erde.",
        beliefs = "Die Erdenmutter, der Himmelsvater An'she und die Jagd. Tauren-Druiden und -Schamanen dienen dem Gleichgewicht; ihr Druidentum unter Hamuul Runentotem ist jung, aber tief verwurzelt.",
        relations = "Das ehrenhafteste und stillste skeptischste Mitglied der Horde. Friedlich aus Überzeugung, furchterregend wenn erweckt; der Zentaurenkrieg ist ewig.",
    }
    f.subgroups["bloodhoof_tribe"] = { name = "Bluthufstamm", lore = "Der herrschende Stamm — Cairnes eigener, Hüter Mulgores und des Bündnisses mit Thrall." }
    f.subgroups["grimtotem_tribe"] = { name = "Grimmtotemstamm", lore = "Der Stamm, der widerspricht. Magathas Grimmtotem halten Donnerfels' Höhen und ihren eigenen Rat — der selten zu Cairnes passt." }
    f.memberText["baine_bloodhoof"] = { name = "Baine Bluthuf", title = "Cairnes Sohn — Bluthuf-Erbe, Zentaurenziel" }
    f.memberText["magatha_grimtotem"] = { name = "Magatha Grimmtotem", title = "Urgroßmutter — Cairnes Rivale auf dem Fels" }
    f.settlementText[88] = { name = "Donnerfels", lore = "Vier Tafelberge, verbunden durch Brücken und Aufzüge — die erste permanente Tauren-Stadt in tausend Jahren." }
    f.settlementText[7]  = { name = "Mulgore", lore = "Die endlich gewonnene grüne Heimat — Kodoherden, Windzornklippen und das Versprechen des Friedens." }
end

-- ============================================================
-- SONSTIGE
-- ============================================================

f = IMAGOdb.factions["cenarion_circle"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Zirkel des Cenarius"
    f.source = "warcraft.wiki.gg/wiki/Cenarion_Circle"
    f.history = [[
Der druidische Orden, dem Smaragdgrünen Traum und den Wildnissen vereidigt. Gegründet nach der Zerschlagung, Jahrtausende von Malfurion Sturmgrimm geführt — und nun, mit Malfurion unerweckbar, von seinem Nachfolger Fandral Hirschhaupt befehligt.
Die Aufgabe des Zirkels ist gewaltig: die Verderbnis der Pestländer, die Silithus-Bedrohung, die wachsende Krankheit des Traums und ein neuer Weltenbaum, den Fandral pflanzte und die Aspekte nicht segnen wollten. Druiden dienen dem Gleichgewicht — was bedeutet, dass die Neutralität des Zirkels für beide Fraktionen oft wie Gleichgültigkeit aussieht.]]
    f.culture = {
        biology = "Überwiegend Nachtelfen- und Tauren-Druiden — die einzige gemeinsame Institution zweier Völker. Mitgliedschaft transzendiert die Fraktion; ebenso das Misstrauen der Außenstehenden.",
        beliefs = "Der Smaragdgrüne Traum, die wilden Götter und Cenarius' Lehren. Gleichgewicht ist Doktrin: Die Natur ist nicht gütig, und ihre Druiden sind es auch nicht.",
        relations = "Neutral gegenüber beiden Fraktionen und für beide unverzichtbar. Beide Armeen brauchen Druiden in Silithus und den Pestländern; keine kann sie befehligen.",
    }
    f.subgroups["keepers_of_the_grove"] = { name = "Hüter des Hains", lore = "Cenarius' Söhne — die halbhirschigen Wächter, die zwischen Traum und Wachwelt wandeln." }
    f.subgroups["druids_of_the_circle"] = { name = "Druiden des Zirkels", lore = "Nachtelfen- und Tauren-Druiden, dem Traum verpflichtet — Heiler des Landes, unabhängig davon, wessen Banner darüber weht." }
    f.memberText["malfurion_stormrage"] = { name = "Malfurion Sturmgrimm", title = "Erster Druide — verloren im Traum" }
    f.settlementText[80] = { name = "Mondlichtung", lore = "Das unantastbare Tal, in dem der Zirkel tagt — neutraler Boden seit bevor eine der beiden Fraktionen existierte." }
end

f = IMAGOdb.factions["argent_dawn"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Argentumdämmerung & Silberne Hand"
    f.source = "warcraft.wiki.gg/wiki/Argent_Dawn"
    f.history = [[
Das Licht, das in den Pestländern brannte. Die Argentumdämmerung zieht aus den Flüchtlingen beider Fraktionen — Paladine, Priester und Soldaten, die die Geißel bekämpfen, egal unter welchem Banner.
An der Kapelle des Hoffnungsvollen Lichts halten sie die Linie, die die Königreiche aufgegeben haben. Die Erben der Silberhand — Verbannte wie Tirion Fordring, Überlebende wie Maxwell Tyrosus — halten den alten Eid am Friedhof der Welt lebendig und stellen Rekruten nur eine Frage: Bekämpfst du die Dunkelheit, oder nur die Horde?]]
    f.culture = {
        biology = "Ein selbstgewählter Orden — Mensch, Zwerg und sogar verlassene Mitglieder, durch Eid verbunden, nicht durch Blut. Die Zahl ist dünn; die Überzeugung nicht.",
        beliefs = "Das Heilige Licht, von Politik befreit. Das Bekenntnis der Dämmerung ist das alte der Silberhand: Bekämpfe das Böse, wo es schwelt und wem es dient.",
        relations = "Neutral und von beiden Fraktionen vertraut — die einzige Kraft, die beide an den Verwundeten des anderen dulden. Der Scharlachrote Kreuzzug hält sie für Verräter; das Gefühl beruht auf Gegenseitigkeit.",
    }
    f.subgroups["brotherhood_of_the_light"] = { name = "Bruderschaft des Lichts", lore = "Der militante Kern der Dämmerung — Veteranen, die den Krieg nach Naxxramas selbst tragen." }
    f.memberText["lord_maxwell_tyrosus"] = { name = "Lord Maxwell Tyrosus", title = "Kommandant an der Kapelle des Hoffnungsvollen Lichts" }
    f.settlementText[23] = { name = "Kapelle des Hoffnungsvollen Lichts", lore = "Der letzte geweihte Boden in den Pestländern — wo die Dämmerung ihre Toten begräbt und ihre Siege zählt." }
end

f = IMAGOdb.factions["goblin_cartels"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Goblin-Kartelle"
    f.source = "warcraft.wiki.gg/wiki/Goblin"
    f.history = [[
Die wahren Gläubigen des Profits. Die Goblin-Kartelle — Steamwheedle an der Spitze — fochten den Zweiten Krieg, finanzierten ihn und kamen reicher heraus als beide Seiten.
Sie bauten Orgrimmars Mauern, betreiben die Zeppeline und besitzen die neutralen Häfen der Welt: Ratschet, Beutebucht, Gadgetzan, Ewige Warte. Gazlowe und seinesgleichen schulden keiner Flagge Treue, ehren nur Verträge und pflegen Neutralität so, wie sie Maschinen pflegen — profitabel.]]
    f.culture = {
        biology = "Klein, grün und weitsichtig. Die Goblin-Gesellschaft ist bis ins Mark merkantil — Status ist Reichtum, Loyalität ist Vertragssache.",
        beliefs = "Handel, Ingenieurskunst und Sprengstoff — in dieser Reihenfolge. Ihre einzige heilige Institution ist das Hauptbuch.",
        relations = "Neutral aus Prinzip und unverzichtbar aus Praxis. Beide Fraktionen kaufen Goblin-Schiffe, Goblin-Arbeit und Goblin-Schweigen; beide misstrauen ihnen vollkommen — völlig zurecht.",
    }
    f.subgroups["steamwheedle_cartel"] = { name = "Steamwheedle-Kartell", lore = "Das größte Kartell — Ratschet, Beutebucht, Gadgetzan, Ewige Warte. Gazlowe baut die Türme der Horde für fairen Preis." }
    f.subgroups["booty_bay"] = { name = "Beutebucht", lore = "Die Piratenhafen-Franchise — nominell Steamwheedle, tatsächlich von Baron Revilgaz und wem immer ihn bezahlt regiert." }
    f.memberText["baron_revilgaz"] = { name = "Baron Revilgaz", title = "Herrscher von Beutebucht" }
    f.settlementText[11] = { name = "Ratschet", lore = "Gazlowes Hafen an der Brachland-Küste — wo Allianzschiffe und Horde-Armeen beide anlegen, immer nacheinander." }
    f.settlementText[71] = { name = "Gadgetzan", lore = "Die Wüsten-Handelsnabe — dampfbetriebene Neutralität in Tanaris' gebleichten Knochen." }
end

f = IMAGOdb.factions["skyborne"]
if f then
    f.memberText = f.memberText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Skyborne"
    f.source = "warcraft.wiki.gg/wiki/Skyborne"
    f.history = [[
Das geflügelte Volk der Höhen — neu in Azeroths Fraktionspolitik und neu in IMAGOs Chronik. Die Skyborne treffen mit WoW Forever selbst ein: ein Volk von Himmelsbewohnern, deren Loyalität ungeschrieben ist.
Bekannt ist nur wenig — sie beanspruchen Zephras' Eiland und dessen schwebende Höhen, sie wandeln unter den Gesandten beider Fraktionen, und ihre Ankunft markiert das erste neue Volk, das in Jahren in Azeroths Geschichte eintritt. Unbekannt ist alles andere: ihre Geschichte, ihre Götter und was der Himmel für sie bewahrte.]]
    f.culture = {
        biology = "Geflügelte Humanoide der Himmelslande — die Details ihres Ursprungs werden noch von IMAGOs Chronisten dokumentiert.",
        beliefs = "Unbekannt. Der Glaube der Skyborne bleibt eine Lücke im Archiv — eine der ersten Fragen, die jeder Erforscher stellt.",
        relations = "Von beiden Fraktionen umworben und von keiner beansprucht. Ihre Loyalität wird Forevers Gleichgewicht formen — und seine Geschichte.",
    }
end

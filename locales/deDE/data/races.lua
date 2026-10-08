-- ============================================================
-- IMAGO Forever — locales/deDE/data/races.lua
-- German localization of race texts.
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}

-- ============================================================
-- ALLIANZ
-- ============================================================

local f = IMAGOdb.races["human"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Menschen"
    f.source = "warcraft.wiki.gg/wiki/Human"
    f.history = [[
Das jüngste der großen Völker Azeroths — und das sturste. Sieben Königreiche erhoben sich aus der Asche des Arathi-Imperiums; die meisten sind Geschichte. Lordaeron fiel der Geißel, und nur Sturmwind trägt noch das alte Banner menschlicher Macht.
Kurzlebig und hell brennend, erbauten die Menschen ihre Hauptstadt Stein für Stein neu nach dem Ersten Krieg und halten nun die südlichen Östlichen Königreiche — stolz, verschuldet und bedrängt von Defias-Banditen und intriganten Adligen gleichermaßen.]]
    f.culture = {
        biology = "Zäh und kurzlebig — kein älteres Volk passt sich schneller an. Ihre Gesellschaften preisen Kriegertradition, Handel und bürgerlichen Stolz.",
        beliefs = "Die Kirche des Heiligen Lichts prägt die menschliche Zivilisation — ihre Kathedralen, ihre Paladine und ihre Kriege.",
        relations = "Das Rückgrat der Allianz: enge Bande mit Eisenschmiede, Zuflucht für die Exilanten Gnomeregans, gespannte Freundschaft mit den Kaldorei. Feinde der Horde seit dem Ersten Krieg.",
    }
    f.groups["stormwind"] = { name = "Königreich Sturmwind", lore = "Das letzte große Menschenkönigreich. Nach dem Ersten Krieg neu erbaut, regiert von einem Kindskönig und seinem Regenten — und umflüstert von Lady Katrana Prestor." }
    f.groups["theramore"] = { name = "Theramore", lore = "Jaina Prachtmeers Inselstadt auf Kalimdor — Heimat der Flüchtlinge Lordaerons, die über das Meer zogen und den Frieden der Rache vorzogen." }
    f.groups["lords_of_lordaeron"] = { name = "Überreste Lordaerons", lore = "Das größte Menschenkönigreich liegt in Trümmern. Seine Überlebenden fanden Schutz in Theramore, kämpfen für die Argentumdämmerung — oder erhoben sich als etwas anderes." }
    f.figureText["bolvar_fordragon"] = { title = "Hochlord von Sturmwind — Regent für den verschollenen König" }
    f.figureText["anduin_wrynn"] = { title = "Der junge König von Sturmwind" }
    f.figureText["jaina_proudmoore"] = { title = "Herrin von Theramore — Anführerin der Lordaeron-Flüchtlinge" }
    f.figureText["tirion_fordring"] = { title = "Verstoßener Paladin — Held der Pestländer" }
    f.figureText["katrana_prestor"] = { name = "Lady Katrana Prestor", title = "Königliche Beraterin — und mehr, als sie scheint" }
    f.settlementText[84] = { name = "Sturmwind", lore = "Die weiß gemauerte Hauptstadt, nach dem Ersten Krieg Stein für Stein neu errichtet. Im Tal der Helden stehen die Statuen ihrer Größten." }
    f.settlementText[37] = { name = "Wald von Elwynn", lore = "Sturmwinds grünes Kernland — Höfe, Wälder und ein Koboldproblem, das niemand zugeben will." }
end

f = IMAGOdb.races["dwarf"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Zwerge"
    f.source = "warcraft.wiki.gg/wiki/Dwarf"
    f.history = [[
Erben der Irdnen. Die Zwerge von Khaz Modan gruben zu tief und weckten Dinge, die besser begraben geblieben wären — eine Geschichte, die sie mit Stolz wiederholen. Eisenschmiede ist nie gefallen.
König Magni Bronzebeard hält die Klans durch Trauer und Grimm zusammen: Sein Bruder Muradin tot in Nordend, seine Tochter Moira verloren an die Dunkeleisen, sein Volk zerrissen zwischen Berghallen und Oberflächenkriegen. Was den Zwergen an Zahl fehlt, begleichen sie mit Sturheit und Stahl.]]
    f.culture = {
        biology = "Stämmig, langlebig und aus der Erde selbst geformt. Zwergische Gesellschaft läuft auf Klanloyalität, Handwerkskunst und Bier.",
        beliefs = "Ein pragmatischer Glaube — das Heilige Licht dient, doch die Ahnen und die Geheimnisse der Titanen besetzen die zwergische Seele. Die Forscherliga jagt ihrem titanengeschmiedeten Ursprung nach.",
        relations = "Sturmwinds ältester Verbündeter und das Arsenal der Allianz. Alte Fehden schwelen gegen die Dunkeleisen — und, weniger offen, gegen jeden, der zwergische Opfer vergisst.",
    }
    f.groups["bronzebeard_clan"] = { name = "Bronzebart-Klan", lore = "Der herrschende Klan Eisenschmiedes, geführt von König Magni. Hüter des Berges und alter Schulden." }
    f.groups["wildhammer_clan"] = { name = "Wildhammerklan", lore = "Die Sturmreiter vom Nistgipfel — Greifenmeister, die Wind und Himmel dem Stein Eisenschmiedes vorziehen." }
    f.groups["dark_iron_clan"] = { name = "Dunkeleisenklan", lore = "Der verbannte dritte Klan, Knechte des Feuerlords im Schwarzfels. Kaiser Thaurissans Volk streift aufwärts; Moira Bronzebart sitzt unter ihnen." }
    f.figureText["magni_bronzebeard"] = { title = "König von Eisenschmiede — Oberhaupt des Bronzebart-Clans" }
    f.figureText["moira_bronzebeard"] = { name = "Moira Bronzebart", title = "König Magnis Tochter — nun Kaiserin der Dunkeleisen" }
    f.figureText["brann_bronzebeard"] = { name = "Brann Bronzebart", title = "Forscher, Chronist, der wandernde Bronzebart" }
    f.settlementText[87] = { name = "Eisenschmiede", lore = "Die Bergstadt, die nie gefallen ist — ein Schmiedeherz aus Ambossen, Bier und altem Stein." }
    f.settlementText[27] = { name = "Dun Morogh", lore = "Das zwergische Hochland — Schnee, Widder und die Tore Eisenschmiedes selbst." }
end

f = IMAGOdb.races["gnome"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Gnome"
    f.source = "warcraft.wiki.gg/wiki/Gnome"
    f.history = [[
Die Gnome verloren alles an einem einzigen Tag. Als Troggs Gnomeregan durchbrachen, folgte Hochtüftler Mekkadrill dem Rat seines Beraters Thermadraht und flutete die Stadt mit Strahlung — tötete die meisten Eindringlinge und die meisten seines Volkes.
Nun eine Nation von Flüchtlingen in Eisenschmiedes Tüftlerstadt, vergraben die Gnome ihren Schmerz in Erfindungen. Mekkadrill hat nie aufgehört, die Rückeroberung zu planen — und manche Exilanten haben ihm den Befehl nie verziehen.]]
    f.culture = {
        biology = "Klein, brillant und langlebig. Gnomische Gesellschaft stellt Ingenieursgenie über Geburtsrecht — der Hochtüftler ist ein gewähltes Amt.",
        beliefs = "Gnome vertrauen eher der Physik als Priestern. Was an Ehrfurcht existiert, gilt der Logik, der Erfindung und der gelegentlichen Maschine, die nicht funktionieren dürfte, aber tut.",
        relations = "Gäste Eisenschmiedes und loyale Allianzmitglieder, obwohl manche Zwerge es still verübeln, ein Volk zu beherbergen, das die eigene Hauptstadt verstrahlte.",
    }
    f.groups["survivors_of_gnomeregan"] = { name = "Überlebende Gnomeregans", lore = "Die Flüchtlinge der verstrahlten Stadt — Ingenieure, Soldaten und die verstrahlten Überlebenden, über die niemand spricht. Sie alle wollen ihre Stadt zurück." }
    f.figureText["mekkatorque"] = { title = "Hochtüftler — Anführer der Gnomeregan-Exilanten" }
    f.figureText["sicco_thermaplugg"] = { name = "Sicco Thermadraht", title = "Der Verräter — Architekt von Gnomeregans Fall" }
    f.settlementText[27] = { name = "Tüftlerstadt, Eisenschmiede", lore = "Das Viertel der Exilanten in Eisenschmiede — halb Werkstatt, halb Flüchtlingslager, ganz gnomisch." }
end

f = IMAGOdb.races["night_elf"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Nachtelfen"
    f.source = "warcraft.wiki.gg/wiki/Night_elf"
    f.history = [[
Vor zehntausend Jahren brachen die Kaldorei die Welt, um sie zu retten. Damals unsterblich, opferten sie Nordrassil, um die Legion am Hyjal aufzuhalten — und erwachten sterblich, vermindert und regiert von einem Weltenbaum, der ohne Segen gepflanzt wurde.
Tyrande Wisperwind führt allein; Malfurion schlägt unweckbar im Traum, und Fandral Hirschhaupt wird in seiner Abwesenheit kühner. Der neue Baum der Nachtelfen, Teldrassil, beginnt bereits zu siechen — auch wenn es wenige laut sagen.]]
    f.culture = {
        biology = "Groß, violett-häutig, einst unsterblich. Die Kaldorei sind eine kriegerisch-spirituelle Gesellschaft, geteilt zwischen Elunes Priesterinnen und dem Smaragdgrünen Traum der Druiden.",
        beliefs = "Elune, die Mondgöttin, ist ihr absoluter Glaube — die Schwesternschaft dient ihr vom Tempel des Mondes. Druiden hingegen folgen Cenarius und dem Zirkel des Cenarius.",
        relations = "Neuestes Mitglied der Allianz — und ihr unnahbarstes. Die Holzfällerlager der Horde in Eschental haben aus Nachbarn Feinde gemacht.",
    }
    f.groups["sentinels"] = { name = "Die Schildwache", lore = "Das Heer der Nachtelfen — Jägerinnen, Bogenschützinnen und Wächterinnen unter dem Kommando von Shandris Mondfeder." }
    f.groups["sisterhood_of_elune"] = { name = "Schwesternschaft der Elune", lore = "Das Priesterinnentum, das die kaldoreische Gesellschaft seit vor der Zerschlagung führt. Tyrande steht an seiner Spitze." }
    f.figureText["tyrande_whisperwind"] = { title = "Hohepriesterin der Elune — Herrscherin der Nachtelfen" }
    f.figureText["shandris_feathermoon"] = { title = "Generalin der Schildwachenarmee" }
    f.figureText["fandral_staghelm"] = { title = "Erzdruide des Zirkels des Cenarius — Tyrandes Rivale" }
    f.figureText["malfurion_stormrage"] = { name = "Malfurion Sturmgrimm", title = "Erzdruide — verloren im Smaragdgrünen Traum" }
    f.settlementText[89] = { name = "Darnassus", lore = "Die mondbeschienene Hauptstadt auf Teldrassils Krone — eine gewachsene, keine gebaute Stadt." }
    f.settlementText[57] = { name = "Teldrassil", lore = "Der zweite Weltenbaum, gepflanzt ohne den Segen der Aspekte. Seine Verderbnis ist für jene sichtbar, die hinsehen." }
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
Geboren aus der einfallenden Horde, neu geschmiedet in Internierungslagern und befreit von einem Sklaven, der sich erinnerte, was sein Volk einst war. Thralls Orcs segelten über das Meer in eine Wüste, die niemand wollte, und benannten sie nach seinem Vater.
Die neue Horde ist jung, und ihre Sünden sind frisch. Warsong-Holzfällerlager in Eschental, abtrünnige Klans der alten Wege und das lange Gedächtnis der Allianz drücken auf Orgrimmars Tore. Thrall hält alles zusammen durch reine moralische Autorität — und jeder weiß es.]]
    f.culture = {
        biology = "Orcs sind starke, grünhäutige Kinder Draenors — eine Kriegerkultur, die sich unter einem einzigen Kriegshäuptling als schamanische Klans neu erfindet.",
        beliefs = "Die Elemente, die Ahnen und die Geister des Landes. Thrall stellte den Schamanismus als orcische Seele wieder her; Hexenmeister werden geduldet, nicht vertraut.",
        relations = "Gehasst von der Allianz, verbunden mit Dunkelspeeren, Tauren und Verlassenen aus Not und Eid. Die Horde ist eine Familie von Überlebenden — und alle anderen erinnern sich an die Invasion.",
    }
    f.groups["frostwolf_clan"] = { name = "Frostwolfklan", lore = "Thralls eigener Klan, Hort der alten schamanischen Wege. Drek'Thar führt sie noch immer in Alteracs Tälern." }
    f.groups["warsong_clan"] = { name = "Kriegshymnenklan", lore = "Grom Höllschreis Klan — geehrt für sein Opfer, vergrämt für den Blutrausch, den er nicht abwaschen konnte." }
    f.figureText["thrall"] = { title = "Kriegshäuptling der Horde" }
    f.figureText["rexxar"] = { title = "Champion der Horde — Wanderer der Wildnis" }
    f.figureText["eitrigg"] = { name = "Eitrigg", title = "Thralls Berater — der Orc, den Tirion Fordring rettete" }
    f.settlementText[85] = { name = "Orgrimmar", lore = "Die Festungsstadt, in Durotars roten Fels geschnitten — neue Hauptstadt eines Volkes, das noch entscheidet, was es ist." }
    f.settlementText[1]  = { name = "Durotar", lore = "Das raue rote Land, das Thrall für die Horde beanspruchte, benannt nach seinem Vater. Skorpide, Stacheleber und hart erkämpfter Stolz." }
end

f = IMAGOdb.races["troll"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Trolle"
    f.source = "warcraft.wiki.gg/wiki/Jungle_troll"
    f.history = [[
Der kleinste Stamm eines zerbrochenen Imperiums. Die Dschungeltrolle der Dunkelspeere wurden aus Schlingendorntal vertrieben und auf ihrer Inselzuflucht beinahe vernichtet — bis Thralls Horde im Moment ihres Untergangs eintraf.
Vol'jin schwor den Dienst seines Volkes dem Kriegshäuptling — ein Eid, der sie zu Waisen in einer Horde machte, die sie duldet, und zu einem Stamm, den andere Trolle schwach nennen. Sie leben auf den Echoinseln und in Orgrimmars Schatten — und beobachten. Die Dunkelspeere haben stets durch Beobachten überlebt.]]
    f.culture = {
        biology = "Dschungeltrolle — groß, sehnig, hauerbewehrt und regenerierend. Der kleinste und anpassungsfähigste Stamm eines gefallenen Imperiums.",
        beliefs = "Die Loa, die Ahnen und der Schatten. Schattenjäger der Dunkelspeere wandeln zwischen den Welten; ihr Voodoo ist älter als orcische Ehre.",
        relations = "Durch Eid und Dankbarkeit an die Horde gebunden. Andere Trollstämme verachten sie; die Allianz unterscheidet sie kaum. Ihre Geduld ist legendär und total.",
    }
    f.groups["darkspear_tribe"] = { name = "Dunkelspeerstamm", lore = "Vol'jins Stamm — die Trolle der Horde, loyal seit Sen'jins Tod auf den Inseln." }
    f.groups["shadow_hunters"] = { name = "Schattenjäger", lore = "Priesterjäger des Stammes — loa-berührte Todesbringer, die nur ihrem Häuptling gehorchen." }
    f.figureText["voljin"] = { title = "Häuptling des Dunkelspeer-Stammes" }
    f.figureText["senjin"] = { name = "Sen'jin", title = "Vol'jins Vater — starb, als er Thrall vor der Seehexe warnte" }
    f.settlementText[1] = { name = "Echoinseln", lore = "Die hart erkämpfte Inselheimat der Dunkelspeere vor Durotars Küste — gewonnen, verloren und wieder gewonnen." }
end

f = IMAGOdb.races["undead"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Die Verlassenen"
    f.source = "warcraft.wiki.gg/wiki/Forsaken"
    f.history = [[
Die Toten, die sich weigerten, liegen zu bleiben. Als der Griff des Lichkönigs nachließ, führte Sylvanas Windläufer die freiwilligen Untoten, um Lordaerons Ruinen zu besetzen — und mit ihrem neuen Willen zu fragen, wofür das Unleben gut ist.
Die Antwort bislang: Rache, Überleben und die Experimente der Königlichen Apothekervereinigung in den Tiefen der Unterstadt. Aus Not der Horde verbündet, von allen gefürchtet einschließlich ihrer Verbündeten — die Verlassenen sind ein Volk, das ganz durch das definiert ist, was es nicht vergeben wird.]]
    f.culture = {
        biology = "Freiwillige Untote — die wiedererweckten Bürger des gefallenen Lordaeron. Keine Fortpflanzung; jeder Verlassene ist ein Überlebender der Ernte der Geißel.",
        beliefs = "Der Kult der Vergessenen Schatten — die Doktrin des Lichts, invertiert. Manche klammern sich an alten Glauben; die meisten glauben nur an freien Willen, Rache und die Königin.",
        relations = "Hordemitglieder per Vertrag, Pariahs von Natur. Der Scharlachrote Kreuzzug jagt sie; die Allianz weigert sich zu glauben, dass sie Personen sind; die Horde findet sie gleichermaßen nützlich und unheimlich.",
    }
    f.groups["royal_apothecary_society"] = { name = "Königliche Apothekervereinigung", lore = "Die Alchemisten der Unterstadt — offiziell Heiler der Untoten, inoffiziell Brauer der nächsten Seuche." }
    f.groups["deathguards"] = { name = "Die Todeswache", lore = "Die Soldaten der Verlassenen — tote Männer, die ewige Wache über Lande halten, die sie begruben." }
    f.figureText["sylvanas_windrunner"] = { title = "Bansheekönigin der Verlassenen" }
    f.figureText["varimathras"] = { title = "Schreckenslord — Sylvanas' Stellvertreter, Herr der Unterstadt" }
    f.figureText["master_apothecary_faranell"] = { name = "Apothekermeister Faranell", title = "Leiter der Königlichen Apothekervereinigung" }
    f.settlementText[18] = { name = "Die Unterstadt", lore = "Lordaerons Kanäle und Krypten unter den Ruinen — Thronsaal der Bansheekönigin." }
end

f = IMAGOdb.races["tauren"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Tauren"
    f.source = "warcraft.wiki.gg/wiki/Tauren"
    f.history = [[
Nomaden seit tausend Jahren, von den Zentauren beinahe ausgerottet — bis eine fremde grüne Armee ihnen half, die Tafelberge Mulgores zu erreichen und endlich stillzustehen.
Cairne Bluthuf einte die Stämme auf Donnerfels und schwor Thrall einen Blutschwur. Die Tauren sind das Gewissen der Horde: langsam zum Zorn, unmöglich zu bewegen — und, wie die Grimmtotem beweisen, nicht völlig einig hinter dem friedlichen Rat des Oberhäuptlings.]]
    f.culture = {
        biology = "Aufragend, gehuf und uralt. Tauren-Gesellschaft ist stammesgebunden — Bluthuf, Grimmtotem und kleinere Stämme — verbunden durch gemeinsame Riten der Jagd und Erde.",
        beliefs = "Die Erdenmutter, der Himmelsvater An'she und die Jagd. Tauren-Druiden und -Schamanen dienen dem Gleichgewicht; ihre Druidik unter Hamuul Runentotem ist jung, aber tief verwurzelt.",
        relations = "Das ehrenhafteste Mitglied der Horde und ihr leisester Skeptiker. Friedfertig aus Überzeugung, furchterregend im Zorn; der Zentaurenkrieg ist ewig.",
    }
    f.groups["bloodhoof_tribe"] = { name = "Bluthufstamm", lore = "Der herrschende Stamm — Cairnes eigener, Hüter Mulgores und des Bündnisses mit Thrall." }
    f.groups["grimtotem_tribe"] = { name = "Grimmtotemstamm", lore = "Der Stamm, der widerspricht. Magathas Grimmtotem halten Donnerfels' Höhen und ihren eigenen Rat — der selten mit Cairnes übereinstimmt." }
    f.figureText["cairne_bloodhoof"] = { title = "Oberhäuptling — Einiger der Tauren-Stämme" }
    f.figureText["baine_bloodhoof"] = { name = "Baine Bluthuf", title = "Cairnes Sohn — Erbe der Bluthufe, Ziel der Zentauren" }
    f.figureText["magatha_grimtotem"] = { name = "Magatha Grimmtotem", title = "Ältestengreisin — Cairnes Rivalin auf der Anhöhe" }
    f.settlementText[88] = { name = "Donnerfels", lore = "Vier Tafelberge, verbunden durch Brücken und Aufzüge — die erste feste Taurenstadt seit tausend Jahren." }
    f.settlementText[7]  = { name = "Mulgore", lore = "Die endlich gewonnene grüne Heimat — Kodoherden, Windfurienklippen und das Versprechen des Friedens." }
end

-- ============================================================
-- BEIDE FRAKTIONEN (WoW Forever exklusiv)
-- ============================================================

f = IMAGOdb.races["skyborne"]
if f then
    f.figureText = f.figureText or {}
    f.settlementText = f.settlementText or {}
    f.name = "Skyborne"
    f.source = "warcraft.wiki.gg/wiki/Skyborne"
    f.history = [[
Das geflügelte Volk der Höhen — neu in Azeroths Fraktionspolitik und neu in IMAGOs Chronik. Die Skyborne kommen mit WoW Forever selbst: ein Volk der Himmelsbewohner, dessen Loyalität ungeschrieben ist.
Was bekannt ist, ist dünn — sie beanspruchen Zephras' Eiland und seine schwebenden Höhen, sie wandeln unter den Gesandten beider Fraktionen, und ihre Ankunft markiert das erste neue Volk, das seit Jahren in Azeroths Geschichte eintritt. Was unbekannt ist, ist alles andere: ihre Geschichte, ihre Götter und was der Himmel für sie bewahrte.]]
    f.culture = {
        biology = "Geflügelte Humanoide der Himmelslande — die Details ihres Ursprungs werden noch von IMAGOs Chronisten dokumentiert.",
        beliefs = "Unbekannt. Der Glaube der Skyborne bleibt eine Lücke im Archiv — eine der ersten Fragen jedes Entdeckers.",
        relations = "Für beide Fraktionen spielbar — von Allianz und Horde gleichermaßen umworben, von keiner beansprucht. Ihre Entscheidung wird Forevers Gleichgewicht prägen — und seine Geschichte.",
    }
end

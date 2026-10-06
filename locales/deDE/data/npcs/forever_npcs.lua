-- ============================================================
-- IMAGO Forever — locales/deDE/data/npcs/forever_npcs.lua
-- German localization
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.npcs = IMAGOdb.npcs or {}

-- CAT_STORMWIND — Königreich Sturmwind
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].name = "Hochlord Bolvar Fordragon"
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].race = "Mensch"
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].lore =
[[
Als Veteran der Silbernen Hand diente Bolvar Fordragon Sturmwind auf unzähligen Schlachtfeldern mit Ehre. Als König Varian Wrynn auf See verschwand, übernahm Bolvar die Regentschaft, um im Namen des jungen Prinzen Anduin zu regieren.
Geleitet von Pflichtgefühl und Argwohn zugleich, lenkt er das Königreich vom Thronsaal aus, während die Machenschaften von Lady Katrana Prestor den Hof um ihn herum vergiften. Kaum jemand in Sturmwind ahnt, wie viel der Stabilität des Reiches auf seinen Schultern ruht.]]
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].zones = {"Sturmwind"}
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].source = "warcraft.wiki.gg/wiki/Bolvar_Fordragon"
IMAGOdb.npcs.CAT_STORMWIND["bolvar_fordragon"].timeline = {
    {era = "WC2", text = "Kämpfte als Paladin der Silbernen Hand im Zweiten Krieg und dessen Nachwehen."},
    {era = "Pre-Classic", text = "Wurde zum Regenten von Sturmwind ernannt, als König Varian Wrynn auf seiner Reise nach Theramore verschwand."},
    {era = "Forever", text = "Regiert Sturmwind in Anduins Namen, während er unwissentlich von Lady Katrana Prestor manipuliert wird — dem schwarzen Drachen Onyxia in Verkleidung."},
}

IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].name = "Anduin Wrynn"
IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].race = "Mensch"
IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].lore =
[[
Der Kindkönig von Sturmwind. Anduin wurde gekrönt, nachdem sein Vater Varian Wrynn auf einer diplomatischen Reise nach Theramore verschwunden war — ein Verschwinden, das, wie gemunkelt wird, kein Unfall war.
Zu jung, um allein zu regieren, verlässt er sich auf Regent Bolvar Fordragon und den Rat von Lady Katrana Prestor. Sanftmütig und für sein Alter aufmerksam, spürt Anduin, dass an seinem Hof etwas zutiefst falsch ist — auch wenn er es noch nicht benennen kann.]]
IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].zones = {"Sturmwind"}
IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].source = "warcraft.wiki.gg/wiki/Anduin_Wrynn"
IMAGOdb.npcs.CAT_STORMWIND["anduin_wrynn"].timeline = {
    {era = "Pre-Classic", text = "Wurde zum König von Sturmwind gekrönt, nachdem sein Vater Varian auf See verschwunden war."},
    {era = "Forever", text = "Regiert unter der Führung von Bolvar Fordragon, während Lady Prestor das Königreich insgeheim in den Ruin treibt."},
}

-- CAT_IRONFORGE — Zwerge von Eisenschmiede
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].name = "König Magni Bronzebart"
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].race = "Zwerg"
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].lore =
[[
König von Khaz Modan und ältester der Bronzebart-Brüder. Magni ist das Herz von Eisenschmiede — ein Schmied, ein Krieger und ein Herrscher, gebunden an alte Fehden und noch ältere Treue.
Er selbst schmiedete die große Klinge Aschenbringer, in Trauer und Zorn über den Tod seines Bruders Muradin. Fremden gegenüber schroff und seiner Tochter Moira gegenüber streng, hält Magni dennoch die zwergischen Klans in einer Welt zusammen, die von Tag zu Tag gefährlicher wird.]]
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].zones = {"Eisenschmiede"}
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].source = "warcraft.wiki.gg/wiki/Magni_Bronzebeard"
IMAGOdb.npcs.CAT_IRONFORGE["magni_bronzebeard"].timeline = {
    {era = "WC2", text = "Führte die Zwerge von Khaz Modan bei der Verteidigung ihrer Heimat gegen die Horde."},
    {era = "WC3", text = "Glaubte, sein Bruder Muradin sei von Arthas erschlagen worden, und schmiedete in seiner Trauer Aschenbringer."},
    {era = "Forever", text = "Regiert Eisenschmiede, während Dunkeleisen-Infiltratoren Unruhe stiften und das Schicksal seiner Tochter Moira den Klan spaltet."},
}

-- CAT_GNOMEREGAN — Gnomeregan-Exilanten
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].name = "Hochtüftler Mekkadrill"
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].race = "Gnom"
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].lore =
[[
Gelbin Mekkadrill, Hochtüftler der Gnome, führte sein Volk durch den dunkelsten Tag seiner Geschichte. Als Troggs Gnomeregan überrannten, folgte er Sicco Thermadrahts Rat und flutete die Stadt mit Strahlung — ein Opfer, das wenige rettete und viele verdammte.
Nun lebt er im Exil bei den Zwergen von Eisenschmiede und führt ein Volk ohne Heimat — von manchen für eben jene Katastrophe verantwortlich gemacht, die er zu verhindern suchte. Die Rückeroberung Gnomeregans hat er nie aufgegeben.]]
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].zones = {"Eisenschmiede"}
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].source = "warcraft.wiki.gg/wiki/Gelbin_Mekkatorque"
IMAGOdb.npcs.CAT_GNOMEREGAN["mekkatorque"].timeline = {
    {era = "Pre-Classic", text = "Ordnete die Verstrahlung Gnomeregans an, um die Trogg-Invasion zu stoppen — eine Katastrophe, die unzähligen Gnomen Leben und Verstand kostete."},
    {era = "Forever", text = "Führt die gnomischen Exilanten von Tüftlerstadt in Eisenschmiede aus und finanziert still den Krieg zur Rückeroberung seiner verstrahlten Stadt."},
}

-- CAT_DARNASSUS — Nachtelfen von Darnassus
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].name = "Tyrande Wisperwind"
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].race = "Nachtelf"
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].lore =
[[
Hohepriesterin der Elune und alleinige Anführerin der Nachtelfen in Malfurions Abwesenheit. Tyrande trägt ihr Volk seit zehntausend Jahren — durch den Krieg der Urtume, die Zerschlagung der Welt und die Schlacht am Berg Hyjal.
Vom Mondtempel in Darnassus aus regiert sie ein geschwächtes Volk: nicht länger unsterblich, mit einem neuen Weltenbaum ohne Segen. Tyrandes Glaube an Elune ist absolut, und ihre Geduld mit jenen, die ihr Volk bedrohen, ist kurz.]]
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].zones = {"Darnassus"}
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].source = "warcraft.wiki.gg/wiki/Tyrande_Whisperwind"
IMAGOdb.npcs.CAT_DARNASSUS["tyrande_whisperwind"].timeline = {
    {era = "Ancient", text = "Übernahm das Kommando über die Schwesternschaft von Elune und kämpfte im Krieg der Urtume an der Seite von Malfurion und Illidan."},
    {era = "WC3", text = "Führte die Schildwachen gegen die Rückkehr der Brennenden Legion, befreite Illidan aus seinem Gefängnis und kämpfte in der Schlacht am Berg Hyjal, bei der Nordrassil geopfert wurde."},
    {era = "Forever", text = "Regiert von Darnassus aus, dem neu ergrünen Weltenbaum Teldrassil — einem Baum, den sie nie wollte und dem sie nicht ganz traut."},
}

IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].name = "Shandris Mondfeder"
IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].race = "Nachtelf"
IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].lore =
[[
Von der ersten Invasion der Brennenden Legion zur Waise gemacht, wurde Shandris in der Schwesternschaft der Elune aufgezogen und wurde Tyrandes Ziehtochter in allem außer dem Namen. Nun befehligt sie die Schildwachenarmee als deren Generalin.
Sie herrscht über die Festung, die ihren Namen trägt, in Feralas — und wacht über Ruinen, die älter sind als jede Erinnerung, und über Feinde, die noch älter sind: die Naga, die aus dem Meer steigen, und das Flüstern des Smaragdgrünen Alptraums, der unter der Erde sich regt.]]
IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].zones = {"Feralas"}
IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].source = "warcraft.wiki.gg/wiki/Shandris_Feathermoon"
IMAGOdb.npcs.CAT_DARNASSUS["shandris_feathermoon"].timeline = {
    {era = "Ancient", text = "Überlebte als Kind den Krieg der Urtume und wurde unter Tyrandes Fittiche genommen."},
    {era = "WC3", text = "Befehligte die Schildwachen bei der Verteidigung Kalimdors während der zweiten Invasion der Legion."},
    {era = "Forever", text = "Regiert die Mondfederfeste in Feralas als Generalin der Schildwachenarmee."},
}

-- CAT_THERAMORE — Theramore
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].name = "Lady Jaina Prachtmeer"
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].race = "Mensch"
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].lore =
[[
Tochter von Admiral Daelin Prachtmeer und einst Schülerin von Antonidas, ist Jaina vielleicht die mächtigste Zauberin der Welt. Sie führte die Überlebenden Lordaerons über das Meer und gründete Theramore an Kalimdors staubiger Küste.
Jaina hat den Frieden mit Blut bezahlt: Sie stand tatenlos dabei, während Thralls Horde ihren eigenen Vater tötete, statt den Krieg beide Völker verschlingen zu lassen. Sie glaubt noch immer, dass Menschen und Orcs nebeneinander existieren können — eine Überzeugung, die mit jedem Jahr einsamer wird.]]
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].zones = {"Düstermarschen"}
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].source = "warcraft.wiki.gg/wiki/Jaina_Proudmoore"
IMAGOdb.npcs.CAT_THERAMORE["jaina_proudmoore"].timeline = {
    {era = "WC3", text = "Beherzigte Medivhs Warnung, führte Lordaerons Überlebende nach Kalimdor und kämpfte am Hyjal. Später wählte sie den Frieden über ihren eigenen Vater und ließ die Horde Daelin Prachtmeer töten."},
    {era = "Pre-Classic", text = "Gründete die Inselstadt Theramore als Leuchtfeuer der Zusammenarbeit zwischen Allianz und Horde."},
    {era = "Forever", text = "Regiert Theramore und vermittelt den brüchigen Frieden zwischen den Fraktionen — darunter den Gipfel, bei dem Varian Wrynn verschwand."},
}

-- CAT_ORCS — Orcs der Horde
IMAGOdb.npcs.CAT_ORCS["thrall"].name = "Thrall"
IMAGOdb.npcs.CAT_ORCS["thrall"].race = "Orc"
IMAGOdb.npcs.CAT_ORCS["thrall"].lore =
[[
Als Sklave in der Festung Durnholde aufgewachsen, entkam Thrall — geboren als Go'el, Sohn des Durotan — und vereinte die zerstreuten orcischen Klans, um sein Volk aus den Internierungslagern zu befreien. Er baute die Horde auf den schamanistischen Traditionen seiner Ahnen neu auf.
Als Kriegshäuptling führte er die Orcs über das Meer nach Kalimdor, gründete Orgrimmar und Durotar und gewann Jaina Prachtmeer am Hyjal als Verbündete. Thrall trägt die Last, zu beweisen, dass die Horde mehr sein kann als das Monster, an das die Allianz sich erinnert.]]
IMAGOdb.npcs.CAT_ORCS["thrall"].zones = {"Orgrimmar"}
IMAGOdb.npcs.CAT_ORCS["thrall"].source = "warcraft.wiki.gg/wiki/Thrall"
IMAGOdb.npcs.CAT_ORCS["thrall"].timeline = {
    {era = "Pre-WC3", text = "Entkam aus Durnholde, lernte den Schamanismus von Drek'Thars Frostwölfen und befreite an der Seite von Orgrim Schicksalshammer die Internierungslager — dessen Rüstung und Hammer er erbte."},
    {era = "WC3", text = "Segelte nach Kalimdor, verbündete sich mit Cairnes Tauren und den Dunkelspeertrollen und kämpfte am Berg Hyjal gegen die Brennende Legion."},
    {era = "Forever", text = "Regiert als Kriegshäuptling von Orgrimmar aus und hält eine junge Horde zusammen, umgeben von Feinden und alten Feindschaften."},
}

IMAGOdb.npcs.CAT_ORCS["rexxar"].name = "Rexxar"
IMAGOdb.npcs.CAT_ORCS["rexxar"].race = "Halbogr (Mok'Nathal)"
IMAGOdb.npcs.CAT_ORCS["rexxar"].lore =
[[
Der letzte Sohn der Mok'Nathal, dem Halboger-Klan der Schergrat-Berge. Rexxar ist ein Tierführer, der Tieren mehr vertraut als Königreichen. Mit seiner Bärin Misha an seiner Seite durchstreift er Kalimdors Wildnis, statt in einem Thronsaal zu sitzen.
Doch die Horde schuldet ihm mehr, als die meisten wissen: Als Admiral Prachtmeers Flotte drohte, Durotar zu vernichten, war es Rexxar, der Thralls Bitte zu Jaina trug und das Blatt wendete. Der Kriegshäuptling ernannte ihn zum Champion der Horde — ein Titel, den er nur trägt, wenn die Horde ihn braucht.]]
IMAGOdb.npcs.CAT_ORCS["rexxar"].zones = {"Feralas", "Desolace", "Steinkrallengebirge"}
IMAGOdb.npcs.CAT_ORCS["rexxar"].source = "warcraft.wiki.gg/wiki/Rexxar"
IMAGOdb.npcs.CAT_ORCS["rexxar"].timeline = {
    {era = "WC3", text = "Schloss sich Thralls Sache in Kalimdor an, sammelte Oger unter dem Banner der Horde und kämpfte, um Durotar vor Daelin Prachtmeers Invasion zu retten."},
    {era = "Pre-Classic", text = "Wurde zum Champion der Horde ernannt und kehrte dann in die Wildnis zurück, die er seine Heimat nennt."},
    {era = "Forever", text = "Streift mit Misha durch die Wildnis Kalimdors, keiner Fahne verpflichtet außer der eigenen — bis die Horde wieder ruft."},
}

-- CAT_DARKSPEAR — Dunkelspeertrolle
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].name = "Vol'jin"
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].race = "Troll"
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].lore =
[[
Sohn des Sen'jin und Anführer des Dunkelspeerstammes. Vol'jin erbte ein zerschlagenes Volk — von seiner Inselheimat von Murlocs und einer Seehexe gleichermaßen gejagt und nur durch Thralls einfallende Horde gerettet.
Er schwor die Dunkelspeere der Horde die Treue und dient als Thralls vertrauenswürdigster Berater, wobei er die neue Horde seines Kriegshäuptlings mit der Geduld und dem Zweifel eines Schattenpriesters beobachtet. Vol'jin sieht weiter als die meisten; was er kommen sieht, lässt ihn still bleiben — vorerst.]]
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].zones = {"Orgrimmar"}
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].source = "warcraft.wiki.gg/wiki/Vol'jin"
IMAGOdb.npcs.CAT_DARKSPEAR["voljin"].timeline = {
    {era = "WC3", text = "Schwor den Dunkelspeerstamm der Horde, nachdem Thrall sie vor der Seehexe Zar'jira gerettet hatte."},
    {era = "Forever", text = "Berät Thrall vom Grommash-Festbau aus, das stille Gewissen im Rat des Kriegshäuptlings."},
}

-- CAT_FORSAKEN — Die Verlassenen
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].name = "Fürstin Sylvanas Windläufer"
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].race = "Untoter"
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].lore =
[[
Einst Waldläufergeneralin von Silbermond, fiel Sylvanas bei der Verteidigung von Quel'Thalas und wurde von Arthas als Banshee wiedererweckt — eine Trophäe, für die er sie leiden ließ. Als der Griff des Lichkönigs schwächer wurde, brach sie frei, holte sich ihren Körper zurück und sammelte jeden Untoten, der ihr folgen wollte.
Nun herrscht sie als Bansheekönigin der Verlassenen von Unterstadt aus, unter den Ruinen Lordaerons. Ihr Bündnis mit der Horde ist eines der Zweckmäßigkeit, und ihr Hass auf Arthas ist der Motor allem, was sie tut.]]
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].zones = {"Unterstadt"}
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].source = "warcraft.wiki.gg/wiki/Sylvanas_Windrunner"
IMAGOdb.npcs.CAT_FORSAKEN["sylvanas_windrunner"].timeline = {
    {era = "WC3", text = "Fiel bei der Verteidigung von Quel'Thalas an Arthas und wurde als Banshee wiedererweckt. Später befreite sie sich, tötete die Rivalen des Schreckenslords Balnazzar und nahm die Ruinen Lordaerons für ihre Verlassenen."},
    {era = "Pre-Classic", text = "Sicherte Unterstadt und schmiedete einen unsicheren Pakt mit der Horde."},
    {era = "Forever", text = "Herrscht über die Verlassenen und rüstet sie gegen die Geißel, den Scharlachroten Kreuzzug — und, wie manche munkeln, gegen alle anderen."},
}

IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].name = "Varimathras"
IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].race = "Nathrezim"
IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].lore =
[[
Ein Schreckenslord der Brennenden Legion. Varimathras wurde zurückgelassen, um Lordaeron zu halten, als der Krieg der Legion im Norden zusammenbrach. Als Sylvanas ihn besiegte, bot er ihr seine Dienste im Tausch für sein Leben an — und tötete sogar seinen eigenen Bruder Balnazzar, um sie zu beweisen.
Nun dient er als ihr Leutnant in Unterstadt, stets der nützliche Ratgeber. Ob ein Dämon jemals wirklich kapituliert oder nur wartet, ist eine Frage, deren Antwort die Bansheekönigin sich leisten zu können glaubt, zu ignorieren.]]
IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].zones = {"Unterstadt"}
IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].source = "warcraft.wiki.gg/wiki/Varimathras"
IMAGOdb.npcs.CAT_FORSAKEN["varimathras"].timeline = {
    {era = "WC3", text = "Herrschte mit seinen Schreckenslord-Brüdern über die Pestländer, bis Sylvanas ihn auf ihre Seite zwang und ihn Balnazzar töten ließ."},
    {era = "Forever", text = "Dient als Sylvanas' Wesir in Unterstadt — vorgeblich loyal, ewig geduldig."},
}

-- CAT_THUNDERBLUFF — Tauren von Donnerfels
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].name = "Cairne Bluthuf"
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].race = "Tauren"
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].lore =
[[
Oberhäuptling der Tauren. Cairne vereinte die wandernden Stämme nach Generationen der Bedrängnis durch die Zentauren. Als Thralls Orcs den Tauren halfen, das Brachland in die Sicherheit Mulgores zu überqueren, schwor Cairne der Horde eine Blutschuld.
Von den Hochplateaus Donnerfels aus führt er mit der Geduld eines Volkes, das die Zeit in Jahrhunderten misst. Weise, bedacht und vollkommen unnachgiebig, sobald sein Wort gegeben ist, ist Cairne die Seele von Thralls Horde.]]
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].zones = {"Donnerfels"}
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].source = "warcraft.wiki.gg/wiki/Cairne_Bloodhoof"
IMAGOdb.npcs.CAT_THUNDERBLUFF["cairne_bloodhoof"].timeline = {
    {era = "WC3", text = "Führte sein Volk mit Thralls Hilfe durch das Brachland, gründete Donnerfels und kämpfte an der Seite der Horde am Hyjal."},
    {era = "Forever", text = "Regiert die vereinten Taurenstämme und berät den Kriegshäuptling — während die Sicherheit seines Sohnes Baine seine einzige Sorge bleibt."},
}

-- CAT_CENARION — Zirkel des Cenarius
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].name = "Erzdruide Fandral Hirschhaupt"
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].race = "Nachtelf"
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].lore =
[[
Erzdruide des Zirkels des Cenarius und Anführer der Druiden in Malfurion Sturmgrimms unerklärter Abwesenheit. Es war Fandral, der Teldrassil pflanzte, den neuen Weltenbaum — ohne den Segen der Drachenaspekte und über Tyrandes Einwand hinweg.
Brillant, stolz und unermesslich verbittert, hat sich Fandral nie vom Verlust seines Sohnes Valstann im Krieg der Sandstürme erholt. Manche sagen, sein Gram sei eine Wunde; andere flüstern, er sei eine Tür.]]
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].zones = {"Darnassus"}
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].source = "warcraft.wiki.gg/wiki/Fandral_Staghelm"
IMAGOdb.npcs.CAT_CENARION["fandral_staghelm"].timeline = {
    {era = "Ancient", text = "Kämpfte im Krieg der Sandstürme und verlor seinen Sohn Valstann an die Qiraji — eine Trauer, die er nie ablegte."},
    {era = "Pre-Classic", text = "Pflanzte Teldrassil als neuen Weltenbaum und übernahm die Führung der Druiden, während Malfurion im Smaragdgrünen Traum verloren blieb."},
    {era = "Forever", text = "Leitet den Zirkel des Cenarius von der Enklave des Cenarius in Darnassus aus, im stillen Widerstreit mit Tyrande."},
}

-- CAT_ARGENT — Argentumdämmerung & Silberne Hand
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].name = "Tirion Fordring"
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].race = "Mensch"
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].lore =
[[
Einst Lord von Mardenholde und Paladin der Silbernen Hand, wurde Tirion exkommuniziert, weil er den Orc Eitrigg verteidigte — eine Ketzer-Barmherzigkeit in den Augen seines Volkes. Er wählte das Exil, statt seine Ehre zu verraten.
Nun lebt er als Einsiedler an der Grenze der Pestländer und betrauert einen Sohn, der aufwuchs, um Orcs zu hassen, und eine Welt, die vergaß, was Ehre bedeutet. Fremden, die ihn aufsuchen, stellt er nur eine Frage: Ob sie sich noch daran erinnern, dass Blut und Ehre nicht dasselbe sind.]]
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].zones = {"Östliche Pestländer", "Westliche Pestländer"}
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].source = "warcraft.wiki.gg/wiki/Tirion_Fordring"
IMAGOdb.npcs.CAT_ARGENT["tirion_fordring"].timeline = {
    {era = "WC2", text = "Diente als Paladin der Silbernen Hand im Zweiten Krieg und wurde Lord von Mardenholde."},
    {era = "Pre-Classic", text = "Wurde aus der Allianz verstoßen und der Titel des Lichts beraubt, weil er dem Orc Eitrigg das Leben gerettet hatte."},
    {era = "Forever", text = "Lebt im Exil in den Östlichen Pestländern, hält den Glauben aufrecht — und prüft jene, die ihn finden, mit der Erinnerung daran, was Ehre kostet."},
}

-- CAT_GOBLIN — Goblin-Kartelle
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].name = "Gazlowe"
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].race = "Goblin"
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].lore =
[[
Chefingenieur des Dampfdruckkartells und Herrscher von Ratschet. Gazlowe baute die Mauern Orgrimmars und die Zeppelinmasten, die die Hauptstädte der Horde verbinden — für einen fairen Preis, selbstverständlich.
Neutral aus Vertrag und Opportunist aus Natur, verkauft Gazlowe an jeden und schuldet keiner Flagge Gefolgschaft. Im Brachland, wo Allianzschiffe und Hordeklingen gleichermaßen seinen Hafen durchqueren, ist diese Neutralität mehr wert als Gold.]]
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].zones = {"Brachland"}
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].source = "warcraft.wiki.gg/wiki/Gazlowe"
IMAGOdb.npcs.CAT_GOBLIN["gazlowe"].timeline = {
    {era = "WC3", text = "Wurde von Thrall beauftragt, die Gründung Orgrimmars zu planen."},
    {era = "Forever", text = "Betreibt Ratschet als neutralen Freihafen und profitiert von den Spannungen, die andere zu überleben er hilft."},
}

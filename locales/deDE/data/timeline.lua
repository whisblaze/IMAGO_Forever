-- ============================================================
-- IMAGO Forever — locales/deDE/data/timeline.lua
-- Localized Timeline text: era names, era range labels, and
-- title / yearLabel / body per event slug.
-- Structure (eras, year sort keys, related, stub) lives in
-- data/timeline_static.lua.
--
-- Entries flagged `stub = true` have no body yet — the detail
-- view shows a work-in-progress note instead.
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.timeline = IMAGOdb.timeline or {}
IMAGOdb.timeline.events = IMAGOdb.timeline.events or {}

IMAGOdb.timelineEraNames = {
    cosmos         = "Kosmos & Anbeginn",
    early_peoples  = "Die frühen Völker Azeroths",
    sundering      = "Krieg der Ahnen & Teilung",
    kaldorei       = "Das Zeitalter der Nachtelfen",
    kingdoms       = "Die Östlichen Königreiche",
    fall_draenor   = "Der Untergang Draenors",
    first_war      = "Der Erste Krieg",
    second_war     = "Der Zweite Krieg",
    between_wars   = "Zwischen den Kriegen",
    third_war      = "Der Dritte Krieg",
    new_order      = "Die neue Weltordnung",
}

IMAGOdb.timelineEraRanges = {
    cosmos         = "(ohne Datum – c. -20,000 DP)",
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
    ev["creation_universe"].yearLabel = "Ohne Datum"
    ev["creation_universe"].body = [[
Noch bevor der Kosmos Gestalt annahm, existierte allein das Licht – ein grenzenloses Meer lebendiger Energie. Doch wo es sich ausbreitete und seine Kraft verlor, blieben Flecken kalter Leere zurück. Diese Flecken verschmolzen miteinander und formten eine zweite Urkraft. Die Leere ist eine dunkle, vampirische Macht, die alles verschlingen möchte. Die wachsende Spannung dieser beiden gegensätzlichen Energien entlud sich schließlich in einer Reihe entsetzlicher Explosionen. Dabei entstand das materielle Universum, das auch als das Große Dunkle Jenseits bezeichnet wird. Die instabilsten Kräfte verfestigten sich zur chaotischen Astraldimension des Wirbelnden Nethers.

Splitterfragmente des Lichts wurden durch das Universum geschleudert und hauchten zahllosen Welten den Funken des Lebens ein. Meistens entstanden daraus Elementargeister. Doch wo sich das gebrochene Licht zu Wolken sammelte, entstanden die Naaru. Sie schworen, das Leben zu schützen. In den feurigen Kernen weniger Welten schlummerten zugleich die Weltenseelen künftiger Titanen. Als diese kolossalen Wesen erwachten, machten sie sich auf die Suche nach weiteren Artgenossen, mit dem Ziel Ordnung in das junge Universum zu bringen.
]]
end

if ev["black_empire"] then
    ev["black_empire"].title = "Das Schwarze Imperium"
    ev["black_empire"].yearLabel = "Ohne Datum"
    ev["black_empire"].body = [[
Die als Leerenfürsten bekannten dunklen Geister der Leere beobachteten die Titanen des Pantheons lange neidisch wegen ihrer Macht und strebten danach, einen von ihnen zu korrumpieren. Doch die edlen Titanen erwiesen sich als unempfänglich für ihre heimtückischen Korruptionsversuche. Also beschlossen die Leerenfürsten, einen Titanen in dessen verletzlichstem Zustand zu beeinflussen: bevor er erwachte.

Auf der blinden Suche nach schlummernden Weltenseelen schleuderten die Leerenfürsten dunkle Kreaturen durch das Universum. Sie verseuchten jede Welt auf ihrem Weg und wurden schließlich als die Alten Götter bekannt.

Aus dem Großen Dunklen gestürzt, bohrten sich die Alten Götter wie gigantische Parasiten tief in die Kruste Azeroths. Ihre Ranken strebten unaufhaltsam dem wehrlosen Herzen der Welt entgegen.

Aus dem organischen Zerfall der Alten Götter entstanden die intelligenten N'raqi und die zähen Aqir. Als loyale Diener führten sie fortan den Willen ihrer Meister aus. Die Aqir errichteten unter der Aufsicht der N'raqi gigantische Tempelstädte um die Körper der Alten Götter.

Von der Bastion des mächtigen Y'Shaarj im Herzen Azeroths aus überzogen diese Reiche bald den gesamten Planeten. Das Schwarze Imperium war geboren.

Die Elementarlords stellten sich dem Schwarzen Imperium entgegen, wurden jedoch von den endlosen Massen der N'raqi und Aqir zerschmettert. Mit der Versklavung der Elementare versank ganz Azeroth in einen Abgrund aus Leid und Tod.
]]
end

if ev["ordering_azeroth"] then
    ev["ordering_azeroth"].title = "Die Ordnung Azeroths"
    ev["ordering_azeroth"].yearLabel = "c. -147,000 DP"
    ev["ordering_azeroth"].body = [[
Während seiner Reisen durch den Kosmos folgte der Titan Aggramar den sanften Träumen einer schlummernden Weltenseele und entdeckte so die den Titanen noch unbekannte Welt Azeroth.

Obwohl das Schwarze Imperium die Oberfläche beherrschte, war Azeroths Weltenseele noch unkorrumpiert. Das Pantheon beschloss, sie um jeden Preis zu retten. Da sie aufgrund ihrer gigantischen Gestalt Angst davor hatten, die Weltenseele zu zerquetschen, schufen die Titanen die Titangeschmiedeten aus Metall und Stein - das metallene Geschlecht der Aesir und das steinerne der Vanir. Einige Titangeschmiedete wurden zu mächtigen Anführern und erhielten die Kräfte der Titanen. Sie wurden als Hüter bekannt.

Die wütenden Elementarlords griffen die Eindringlinge an, doch die Hüter zerschlugen ihre Streitkräfte und verbannten die Elementarlords in eine magisch geschaffene Taschendimension – die sogenannte Elementarebene.

Als Y'Shaarj begann, die Gedanken der Titanengeschmiedeten zu vergiften, war es der Titan Aman'Thul selbst, der Y'Shaarj mit bloßen Händen aus der Weltkruste riss. Doch die tief verwurzelten Ranken des Alten Gottes rissen eine klaffende Wunde in die Oberfläche, aus der das Lebensblut von Azeroth unkontrolliert hervorströmte. Um eine Zerstörung Azeroths zu verhindern, tötete das Pantheon die übrigen Alten Götter nicht, sondern ließ sie durch die Hüter tief unter der Erde einkerkern.

Die Hüter stillten das austretende Lebensblut mit magischen Schutzkreisen. Die beruhigten Energien formten schließlich den Brunnen der Ewigkeit, der neues Leben über ganz Azeroth brachte.

Zwei mächtige Titanenschmieden stabilisierten die Weltenseele und brachten neue Geschlechter der Titanengeschmiedeten hervor, darunter die Irdenen. Die Hüter ordneten das Land und tauften den blühenden Hauptkontinent Kalimdor, das „Land des ewigen Sternenlichts". Vor ihrer Abreise setzte das Pantheon Algalon den Beobachter als Wächter ein. Er erhielt die Befugnis, im Falle einer drohenden Korruption der Weltenseele die Schmiede des Ursprungs zu aktivieren und alles Leben auf Azeroth zur Reinigung auszulöschen.
]]
end

if ev["sargeras_fall"] then
    ev["sargeras_fall"].title = "Sargeras' Verrat"
    ev["sargeras_fall"].yearLabel = "Ohne Datum"
    ev["sargeras_fall"].body = [[
Als Dämonen aus dem Wirbelnden Nether in die fernsten Winkel der Schöpfung einfielen und die Suche des Pantheons nach weiteren Weltenseelen bedrohten, entsandten die Titanen ihren mächtigsten Streiter, den edlen Sargeras. Er schwor, nicht zu ruhen, bis das Universum von allem dämonischen Einfluss gereinigt sei.

Doch besiegte Dämonen starben nicht endgültig, sondern ihre Geister kehrten in den Nether zurück und erwachten in neuen Körpern. Deshalb schmiedete Sargeras in dessen Innerem ein ausbruchsicheres Gefängnis: Mardum, die Ebene der Verbannung.

Auf seiner Jagd zog es Ihn in einen entlegenen Winkel des Großen Dunklen zu einer schwarzen, ausgedörrten Welt, über deren Oberfläche die Alten Götter schwärmten. Ihre Ranken hatten sich bis zum Kern gegraben, die Weltenseele darin träumte nur noch düstere Alpträume.

Verhörte Nathrezim (=Schreckenlords) offenbarten ihm den Plan der Leerenfürsten: Eine verdorbene Weltenseele würde als dunkler Titan erwachen, dem nicht einmal das Pantheon Widerstand leisten könnte und der die gesamte Schöpfung dem Willen der Leere unterwerfen würde.

Zum ersten Mal kannte der unbesiegte Champion der Titanen Furcht, denn die Leerenfürsten hatten wie das Pantheon nach Weltenseelen gesucht und diese hier bereits verzehrt. Voller Trauer sah Sargeras nur einen Ausweg, um den dunklen Titanen am Erwachen zu hindern. Mit einem einzigen Hieb seiner Klinge spaltete er die Welt und tötete ihre schlummernde Weltenseele.

Das Pantheon verurteilte die Tat: Gemeinsam hätte man die Seele läutern können. Doch Sargeras war überzeugt, dass nur eine niedergebrannte Schöpfung den Leerenfürsten noch entkommen könne. Als die Seinen nicht mitziehen wollten, verließ er das Pantheon für immer, um den Kampf gegen die Leere allein zu führen.

Um die Leerenfürsten aufzuhalten, zeriss Sargeras sein eigenes Gefängnis Mardum und entfesselte dessen Dämonen in einer Explosion aus Teufelsmagie. Dies war die Geburtsstunde seiner Armee, der Brennenden Legion.

Bei Nihilam stellte sich das Pantheon Sargeras entgegen, doch es fiel: Aggramar starb unter seiner Klinge, die übrigen Titanen in einem Sturm aus Teufelsmagie. Nur ihre Geister entkamen. Norgannon barg sie im letzten Moment und schleuderte sie in den Kosmos.
]]
end

if ev["doom_karesh"] then
    ev["doom_karesh"].title = "Das Unheil von K'aresh"
    ev["doom_karesh"].yearLabel = "ca. -100.000 DP"
    ev["doom_karesh"].body = [[
Einst war K'aresh eine blühende Welt mit goldenen Wüsten und geschäftigen Stadtstaaten. Unter der Führung von Hohepriester Salhadaar und dem Orakelrat gedieh die Zivilisation der K'areshi. Doch während ihre Welt florierte, rückte bereits ein schreckliches Schicksal näher.

In nur wenigen Sekunden verdunkelte sich der Himmel als beide Sonnen erloschen. Dimensius der alles Verschlingende fiel über K'aresh her und entfesselte die Leere über dessen ahnungslose Bewohner. Überall auf dem Planeten rissen Portale auf, die Himmel und Wüsten mit dunkler Energie überfluteten. Warnungen vor der drohenden Katastrophe hatte es gegeben, doch als die K'areshi die Gefahr endlich begriffen, stand der Feind bereits vor ihrer Tür.

In ihrer Verzweiflung errichteten sie magische Schutzschilde um ihre Städte, die die verderblichen Energien der Leere in arkane Macht umwandelten. Die Barrieren hielten stand, doch ihr Schutz forderte einen schrecklichen Preis: Die Magie entzog den K'areshi nach und nach ihre körperliche Gestalt, bis von ihnen nur noch Seelen aus reiner Energie übrig blieben. Was das Ende ihrer Zivilisation hätte sein sollen, wurde zu ihrer einzigen Überlebenschance. Sie hielten Dimensius zurück – bis der alles Verschlingende Armeen herbeirief, denen sie nicht mehr gewachsen waren.

In einem letzten verzweifelten Versuch trafen einige Verteidiger eine unmögliche Entscheidung, um Dimensius aufzuhalten. Ihr Plan gelang: Fragmente des Leerenfürsten wurden in die Weiten des Großen Dunklen Jenseits verstreut. Doch K'aresh selbst wurde vernichtet, seine einst prachtvollen Städte zu Ruinen zerschmettert. Mit der Zeit verblasste die Wahrheit über den Untergang und wurde zur Legende. Die Überlebenden trauerten um eine Heimat, die sie für immer an die Leere verloren glaubten.

Während K'aresh in Stücke barst, flohen seine Bewohner in ferne Gefilde. Im Laufe der Zeit wurden sie zu den Astralen und Mittlern. Doch nicht alle kehrten ihrer zerstörten Heimat den Rücken: Einige blieben zurück und wurden zu den Ödnisbewohnern, die noch immer durch die trostlosen Überreste ihrer Welt ziehen.
]]
end

if ev["charge_dragonflights"] then
    ev["charge_dragonflights"].title = "Die Drachenaspekte"
    ev["charge_dragonflights"].yearLabel = "c. -20,285 DP"
    ev["charge_dragonflights"].body = [[
Während Sargeras das Pantheon zerschlug, entstand auf der geordneten Welt neues Leben. Dazu gehörten die Protodrachen, die aus Elementaren hervorgegangen waren, die der Verbannung in die Elementarebene entkommen konnten. Galakrond war der größte Protodrache, der je über Azeroth geflogen war. Aus unstillbarem Hunger verschlang er sogar seine Artgenossen. Das Fleisch der Toten verdarb ihn, nekrotische Fäulnis entstellte seine Glieder und dutzende Augen sprossen aus seinem Körper. Von seinem Fell strömten Todesenergien, die Totes wieder zum Leben erweckten.

Als Tyr, der mächtigste aller Hüter, die Gefahr erkannte, konnte er seine gleichgültigen Geschwister nicht zum Handeln bewegen. Also entschloss er sich, Galakrond allein zu stellen. Er fand fünf außergewöhnliche Protodrachen verschiedener Linien, die sich ihm anschlossen. Unter Tyrs Führung besiegten die fünf Protodrachen Galakrond in den Gipfeln des nördlichen Kalimdor. Galakrond stürzte daraufhin in die spätere Drachenöde.

Statt seine Geschwister zu tadeln, überzeugte Tyr sie, die fünf Protodrachen zu Wächtern Azeroths zu machen. Als Kanäle für die Kräfte ihrer Schöpfer verliehen die versammelten Hüter jedem Protodrachen den Segen des Pantheons. So empfing jeder der Fünf die Kraft eines Titanen und es entstanden die Drachenaspekte: Nozdormu der Zeitlose, Alexstrasza die Lebensbinderin und Drachenkönigin, Ysera die Träumerin, Malygos der Zauberwirker und Neltharion der Erdwächter.

Um die Aspekte in ihrer Aufgabe zu unterstützen, erschufen die Hüter ihnen ein eigenes Volk. Aus magisch veränderten Protodrachen-Eiern entstanden die fünf Drachenschwärme nach dem Ebenbild der Aspekte: der bronzene, der rote, der grüne, der blaue und der schwarze Schwarm. Als Symbol ihrer Einheit errichteten die Hüter den Wyrmruhtempel im Norden Kalimdors.
]]
end

if ev["odyns_halls"] then
    ev["odyns_halls"].title = "Odyn und die Hallen der Tapferkeit"
    ev["odyns_halls"].yearLabel = "c. -20,200 DP"
    ev["odyns_halls"].body = [[
Während die anderen Hüter die Protodrachen segneten, grollte Odyn in den Hallen Ulduars. Er war der oberste designierte Wächter und hatte als Einziger der Ermächtigung widersprochen. Für ihn waren Drachen primitive Lebensformen, denen man das Schicksal der Welt nicht anvertrauen konnte. Nur die Titanengeschmiedeten waren als Beschützer geeignet. Doch Tyr und die anderen hatten sich durchgesetzt.

Odyn war überzeugt, dass die Aspekte versagen würden. Also beschloss er, selbst eine Elitearmee zu erschaffen, die Azeroth verteidigen sollte. Dafür wählte er die Vrykul, deren Mut und Kraft er bewunderte. Für ihn waren sie die vollkommenste Verkörperung des Kriegergeistes. Die anderen Hüter forderten ihn auf, seinen Plan aufzugeben, doch Odyn blieb unbeirrbar. Als sich ihm niemand anschloss, kündigte er an, den Plan allein zu verfolgen.

Er rief die Zauberin Helya zu sich, die er über die Zeitalter hinweg wie eine Ziehtochter geliebt hatte. Sie umspannte einen Flügel Ulduars mit einem gewaltigen Zauber, riss ihn aus der Erde und hob ihn in die Wolken. So entstanden die Hallen der Tapferkeit. Von seiner schwebenden Zitadelle aus verkündete Odyn allen Vrykul, dass die Seelen all jener, die ruhmreich im Kampf fielen, in die Hallen geholt und in einen neuen, sturmgeschmiedeten Körper gehüllt würden. Diese Champions, die Valarjar, sollten als Azeroths vorderste Wächter dienen.

Es fehlte jedoch noch ein Weg, um die Seelen der Toten zu den Hallen zu geleiten. Odyn studierte die Energien der Schattenlande und fand einen Weg, Vrykul in geisterhafte Val'kyr zu verwandeln. Diese Diener wandelten zwischen den Ebenen und geleiteten die Seelen würdiger Vrykul, doch waren sie auf ewig als Schemen verflucht. Da sich niemand freiwillig meldete, beschloss Odyn, die Val'kyr mit Gewalt zu erschaffen. Helya tadelte ihn dafür und drohte, die Hallen nach Ulduar zurückzubringen. Geblendet von seinem Traum zerschmetterte Odyn ihren Körper und formte ihren Geist zur ersten Val'kyr.
Ihr Schmerzensschrei drang bis ins Herz der Schattenlande. Zwar hasste sie ihn fortan, doch sie war an seinen Willen gebunden und erschuf weitere Val'kyr. Über Zeitalter hinweg füllten sich die Hallen mit Valarjar, die Odyn trainierte. Reue kannte er keine, denn in seinen Augen tat er alles für die Sicherheit Azeroths.
]]
end

if ev["keepers_fall"] then
    ev["keepers_fall"].title = "Der Fall der Hüter"
    ev["keepers_fall"].yearLabel = "c. -20,000 DP"
    ev["keepers_fall"].body = [[
Nach dem Fall des Pantheons herrschte Schweigen, und kein Hüter litt mehr darunter als Loken. Er suchte Trost bei Sif, der Gefährtin seines Bruders Thorim. Aus Freundschaft wurde verbotene Liebe, aus Liebe Besessenheit. Als Sif den Bund lösen wollte, erschlug Loken sie aus Eifersucht.

Doch ihr Geist erschien und verzieh ihm. Ihrem Rat folgend schob er die Schuld auf den Eisriesenkönig Arngrim und entfesselte einen Krieg der Riesen. Sie überredete ihn auch, mit der Schmiede des Willens eine Armee zu erschaffen und Thorim zu tadeln, worauf dieser in Einsamkeit versank.

Als der Geist schwieg und Loken eine Verderbnis an seinen Kriegern erkannte, durchschaute er die Täuschung: Sifs Geist hatte nie existiert, er war eine Illusion des in Ulduar eingekerkerten Alten Gottes Yogg-Saron. Dieser hatte die Erschaffungsmatrix vergiftet, sodass jede Schöpfung zu vergänglichem Fleisch verkommen sollte. So gelangte der Fluch des Fleisches in die Welt.

Von Schuld getrieben, vertuschte Loken seine Taten und ging über die anderen Hüter her. Zunächst gewann er die geisterhafte Val'kyr Helya für sich. Sie war die Ziehtochter des Hüters Odyn und trug die Seelen gefallener Vrykul in die Hallen der Tapferkeit. Sie hatte ihm ihre unfreiwillige Verwandlung nie verziehen. Für ihre Freiheit versiegelte sie die Hallen, Odyn und die Valarjar darin eingeschlossen. Ihr Reich wurde Helheim.

Mit der Macht Yogg-Sarons besiegte oder korrumpierte Loken auch die übrigen Hüter. Nur Tyr, Archaedas und Ironaya konnten sich ihm entziehen. Zuvor war bereits Hochhüter Ra verschwunden, dem der Fall des Pantheons bekannt geworden war. Loken krönte sich zum obersten Hüter und versiegelte Ulduar, ohne zu ahnen, dass unter ihm der Alte Gott erwachte.
]]
end

if ev["winterskorn_war"] then
    ev["winterskorn_war"].title = "Der Winterskorn-Krieg"
    ev["winterskorn_war"].yearLabel = "c. -20,000 DP"
    ev["winterskorn_war"].body = [[
Einige Zeit nach Lokens Verrat hatten sich die aus Ulduar verbannten Titanengeschmiedeten über den Norden Kalimdors zerstreut. Die Riesen zogen in die Berge und Meere, die Irdenen gruben sich in die Tiefe, und viele Vrykul sammelten sich in kleinen Clans. Zwischen ihnen herrschte ein brüchiger Friede, doch er hielt nicht. Schon bald rührten sich zwei Geschöpfe Lokens: Die Feuerriesen Volkhan und Ignis wollten die Sturmgipfel um Ulduar erobern und suchten eine Armee.

Obwohl viele Vrykul kriegerisch waren, mieden die meisten den Kampf untereinander. Nicht so die Winterskorn: Ihr Glaube an den Aufstieg in die Hallen der Tapferkeit hatte eine Kultur der Gewalt geschaffen. Volkhan und Ignis unterwarfen den Klan. Sie rüsteten ihn mit verzauberter Rüstung aus und schmiedeten Waffen, die Eisen und Stein zerschmetterten.

Doch beim Aufbruch wurden die metallenen Häute der Winterskorn brüchig, es zeigten sich erste Symptome des Fluchs des Fleisches. Da die Vrykul allein nicht mehr genügten, formten die beiden Riesen mächtige, geschmolzene Golems und Eisenkonstrukte.

Das Heer marschierte zuerst gegen die gutmütigen Irdenen und massakrierte ganze Höhlen. Die Überlebenden flohen zu Tyr, Archaedas und Ironaya. Tyr führte die Tapfersten in Scharmützel, seine Gefährten bauten Verteidigungsanlagen, und gemeinsam schlugen sie die Winterskorn zurück.

Doch die Riesen schufen eine größere Armee und versklavten Protodrachen-Schwärme mit verzauberten Schlingen. Der neue Angriff zerbrach die Verteidigung. Vrykul und Golems jagten die Irdenen am Boden, während Protodrachen aus der Luft auf sie hinabstießen. Selbst Tyr, Archaedas und Ironaya mussten vor der Wut der Winterskorn fliehen.

Da Tyr wusste, dass sie allein nicht siegen konnten, rief er die fünf Drachenaspekte zu Hilfe. Empört über die toten Titanengeschmiedeten und die versklavten Protodrachen wirkten sie im Einklang wie einst gegen Galakrond: Alexstrasza hielt die Winterskorn mit gigantischen Feuerwällen zurück, Malygos entzog den Konstrukten ihre Magie und befreite die Protodrachen, während Neltharion Berge aus der Erde wachsen ließ, die die Vrykul und die Riesen einpferchten. Zuletzt hüllten Ysera und Nozdormu die Winterskorn in einen Nebel, der sie einschlafen ließ. In Grabstädten versanken sie in einen Jahrtausende langen Schlummer, bis sie als Wesen aus Fleisch und Blut erwachten.
]]
end

if ev["tyrs_sacrifice"] then
    ev["tyrs_sacrifice"].title = "Tyrs Opfer"
    ev["tyrs_sacrifice"].yearLabel = "c. -20,000 DP"
    ev["tyrs_sacrifice"].body = [[
Tyr wusste, dass er Loken nicht direkt stellen konnte, also entwarf er mit Archaedas und Ironaya einen Plan: Sie wollten die Scheiben von Norgannon stehlen, die alles aufgezeichnet hatten, auch Lokens Verrat. Während Tyr Loken an den Toren Ulduars in einen Streit verwickelte, drangen seine Gefährten ein und stahlen die Scheiben.

Zuvor hatten die Hüter die Titanengeschmiedeten um Ulduar versammelt: vom Fluch gezeichnete Vrykul, die meisten Irdenen und viele Mechagnome. Wochenlang zogen sie gen Süden. Doch als Loken den Raub bemerkte, packte ihn die Panik: Das Pantheon würde es erfahren – und das wäre sein Todesurteil. In Verzweiflung weckte er die C'Thraxxi Zakazj und Kith'ix, die grausamsten Generäle des Schwarzen Imperiums. Er befahl ihnen, Tyr und seine Anhänger zu töten. Sie gehorchten, da sie Yogg-Sarons Hauch in ihm spürten.

Weit im Süden holten die C'Thraxxi die Flüchtlinge in einer stillen Lichtung ein. Tyr befahl den anderen weiterzuziehen, während er sich den Scheusalen allein stellte. Sechs Tage und Nächte wütete der Kampf, bis Tyr, dessen Kraft erschöpft war, seine verbliebene Macht in einer blendenden Explosion arkaner Energie entlud. Dabei wurden er selbst und Zakazj getötet. Kith'ix floh schwer verwundet gen Westen. Zu Ehren ihres Gefährten nannte Ironaya die Lichtung „Tyrs Sturz", auf Vrykulisch „Tirisfal". Sie begruben ihn unter seiner silbernen Hand und die Vrykul blieben als Wächter seines Grabes zurück.

Archaedas und Ironaya zogen mit den Irdenen und Mechagnomen weiter nach Uldaman und bauten dort Kammern für die Scheiben. Als die Irdenen vom Fluch des Fleisches gezeichnet wurden, baten sie um Schlaf und wurden versiegelt. Die Mechagnome hingegen blieben wach und wachten über die Stätte. In Ulduar schuf Loken ein eigenes Archiv, das Tribunal der Zeitalter, und tilgte seine Sünden. Doch dadurch verzerrte sich die Geschichte. Schließlich manipulierte er die Kommunikationsgeräte so, dass nur sein eigener Tod Algalon noch nach Azeroth rufen konnte.

Während die Winterskorn schliefen, dominierte der Klan der Drachenschinder den Norden. Als der Fluch des Fleisches entstellte Kinder hervorbrachte, befahl König Ymiron, der die schweigenden Hüter dafür verantwortlich machte, die Säuglinge zu töten. Einige Mütter brachten es jedoch nicht übers Herz und flohen gen Süden, in ein Land, das sie nur aus Legenden kannten. Die Vrykul von Tirisfal zogen die Kinder wie eigene auf und so entstanden die ersten Menschen. Zwar schwächte der Fluch die Titanengeschmiedeten, doch er gebar auch Tapferkeit und Heldenmut, womit der Alte Gott nicht gerechnet hatte. Auch die Drachenschinder versanken schließlich im Schlaf, um dem Fluch zu entkommen.
]]
end

-- ============ EARLY_PEOPLES ============

if ev["twin_empires"] then
    ev["twin_empires"].title = "Die Zwillingsimperien"
    ev["twin_empires"].yearLabel = "c. -16,000 DP"
    ev["twin_empires"].body = [[
Der von Tyr schwer verwundete Kith'ix floh in die Berge des Südwestens und versank in einen tiefen Schlaf. Die dort lebenden Loa, geisterhafte Wilde Götter, begruben ihn unter schwarzem Gestein. Jahrtausende später erblühte neues intelligentes Leben in den dichten Wäldern um den Brunnen der Ewigkeit. Zu den ersten Völkern zählten die Trolle, wilde Jäger und Sammler, denen sogar verlorene Glieder nachwuchsen. Was sie einte, war die Verehrung der Loa, die sie als Gottheiten sahen. Um die heilige Bergkette Zandalar entstanden viele Stämme. Der mächtigste, die Zandalari, errichtete die Tempelstadt Zuldazar. Doch im Laufe der Jahrhunderte erhoben sich rivalisierende Stämme: die Gurubashi, die Amani und die Drakkari.

Es gab einen Ort, der den Stämmen verboten war: ein Hügel aus schwarzem Stein, vor dem die Loa eindringlich warnten. Doch die Neugier siegte. Rebellische Trolle gruben den Hügel aus und fanden das gezackte Fell einer schlafenden Kreatur. Sie hielten sie für einen unentdeckten Loa und weckten sie mit blutigen Opfern. Kith'ix erwachte und erschlug seine Erwecker. Dann rief Kith'ix die Aqir herbei, ein insektenartiges Volk, das seit dem Fall des Schwarzen Imperiums unter der Erde lebte. Unter seinem Befehl errichteten die Insektoiden das Reich Azj'Aqir. Als die Schwärme groß genug waren, fegten sie über das Land und brachten etliche kleinere Trollstämme zu Fall.

Als die Aqir den heiligen Bergen nahekamen, schlossen sich die zerstrittenen Stämme unter der Führung der Zandalari zum Imperium von Zul zusammen. Mit Hinterhalten in den Dschungeln und den Loa an ihrer Seite warfen sie die Insektoiden zurück und verwundeten Kith'ix schwer. Der C'Thrax floh in den Nordosten. Um die Gefahr zu beenden, sandten die Zandalari die Stämme zur Jagd aus. Die Drakkari zogen gen Norden und zerschmetterten die Obsidianzerstörer – versklavte Tol'vir. Die Gurubashi kämpften bei Ahn'Qiraj, dem Gefängnis des Alten Gottes C'Thun, gegen die Aqir und ihre Anubisath-Riesen. Die Amani verfolgten Kith'ix und rissen ihn in einer selbstmörderischen Schlacht mit in den Tod. Anschließend gründeten sie auf dem Schlachtfeld die Stadt Zul'Aman.

Ohne ihren Herrn verloren die Aqir ihren Biss und ihr Reich zerfiel. Die Überlebenden wandelten sich zu drei neuen Völkern: Im Norden entstanden die Neruber von Azjol-Nerub, bei Ahn'Qiraj die Qiraji und im Südosten die Mantis. Auch die Trollstämme zerfielen ohne gemeinsamen Feind. Aus ihren Festungen wurden eigene Reiche, allen voran die Zwillingsimperien Zul'Aman der Amani und Zul'Gurub der Gurubashi. Die Zandalari zogen sich auf ihre Plateaus zurück und widmeten sich dem geistigen Wissen, doch ihr Einfluss blieb gewaltig.
]]
end

if ev["thunder_king"] then
    ev["thunder_king"].title = "Der Donnerkönig"
    ev["thunder_king"].yearLabel = "c. -15,000 DP"
end

if ev["rise_kaldorei"] then
    ev["rise_kaldorei"].title = "Der Aufstieg der Kaldorei"
    ev["rise_kaldorei"].yearLabel = "c. -15,000 DP"
end

if ev["corruption_eredar"] then
    ev["corruption_eredar"].title = "Sargeras ködert die Eredar"
    ev["corruption_eredar"].yearLabel = "c. -13,000 DP"
end

if ev["pandaria_freed"] then
    ev["pandaria_freed"].title = "Die Befreiung Pandarias"
    ev["pandaria_freed"].yearLabel = "c. -12,000 DP"
end

-- ============ SUNDERING ============

if ev["war_ancients"] then
    ev["war_ancients"].title = "Der Krieg der Ahnen"
    ev["war_ancients"].aliases = { "War of the Ancients" }
    ev["war_ancients"].yearLabel = "-10,000 DP"
end

if ev["the_sundering"] then
    ev["the_sundering"].title = "Die Teilung der Welt"
    ev["the_sundering"].aliases = { "the Sundering", "Great Sundering" }
    ev["the_sundering"].yearLabel = "-10,000 DP"
end

if ev["nordrassil_hyjal"] then
    ev["nordrassil_hyjal"].title = "Nordrassil und Illidans Gefangenschaft"
    ev["nordrassil_hyjal"].yearLabel = "-10,000 DP"
end

-- ============ KALDOREI ============

if ev["war_satyr"] then
    ev["war_satyr"].title = "Der Satyrkrieg und der Worgenfluch"
    ev["war_satyr"].yearLabel = "-9,300 DP"
end

if ev["the_long_vigil"] then
    ev["the_long_vigil"].title = "Die Lange Wacht"
    ev["the_long_vigil"].yearLabel = "-7,300 DP"
end

if ev["founding_quelthalas"] then
    ev["founding_quelthalas"].title = "Die Gründung von Quel'Thalas"
    ev["founding_quelthalas"].yearLabel = "-6,800 DP"
end

if ev["andrassil_vordrassil"] then
    ev["andrassil_vordrassil"].title = "Vordrassil und die Gnome"
    ev["andrassil_vordrassil"].yearLabel = "-4,500 / -3,000 DP"
end

-- ============ KINGDOMS ============

if ev["arathor_troll_wars"] then
    ev["arathor_troll_wars"].title = "Arathor und die Trollkriege"
    ev["arathor_troll_wars"].yearLabel = "-2,800 DP"
end

if ev["council_tirisfal"] then
    ev["council_tirisfal"].title = "Der Rat und die Wächter von Tirisfal"
    ev["council_tirisfal"].yearLabel = "-2,680 / -2,610 DP"
end

if ev["awakening_dwarves"] then
    ev["awakening_dwarves"].title = "Das Erwachen der Zwerge"
    ev["awakening_dwarves"].yearLabel = "-2,500 DP"
end

if ev["seven_kingdoms"] then
    ev["seven_kingdoms"].title = "Die sieben Königreiche"
    ev["seven_kingdoms"].yearLabel = "-1,200 DP"
end

if ev["war_shifting_sands"] then
    ev["war_shifting_sands"].title = "Der Krieg der Sandstürme"
    ev["war_shifting_sands"].yearLabel = "-975 DP"
end

if ev["aegwynn_tomb"] then
    ev["aegwynn_tomb"].title = "Die Wächterin Aegwynn"
    ev["aegwynn_tomb"].yearLabel = "-823 DP"
end

if ev["war_three_hammers"] then
    ev["war_three_hammers"].title = "Der Krieg der drei Hämmer"
    ev["war_three_hammers"].yearLabel = "-230 DP"
end

if ev["draenei_draenor"] then
    ev["draenei_draenor"].title = "Die Draenei auf Draenor"
    ev["draenei_draenor"].yearLabel = "-200 DP"
end

if ev["medivh_born"] then
    ev["medivh_born"].title = "Die Geburt Medivhs"
    ev["medivh_born"].yearLabel = "-45 DP"
end

-- ============ FALL_DRAENOR ============

if ev["guldan_fel"] then
    ev["guldan_fel"].title = "Kil'jaeden und Gul'dan"
    ev["guldan_fel"].yearLabel = "-12 DP"
end

if ev["horde_forms"] then
    ev["horde_forms"].title = "Die Entstehung der Horde"
    ev["horde_forms"].yearLabel = "-8 – -6 DP"
end

if ev["draenei_genocide"] then
    ev["draenei_genocide"].title = "Der Völkermord an den Draenei"
    ev["draenei_genocide"].yearLabel = "-4 – -2 DP"
end

if ev["dark_portal_built"] then
    ev["dark_portal_built"].title = "Das sterbende Draenor und das Portal"
    ev["dark_portal_built"].yearLabel = "-1 DP"
end

-- ============ FIRST_WAR ============

if ev["dark_portal_opens"] then
    ev["dark_portal_opens"].title = "Die Horde betritt Azeroth"
    ev["dark_portal_opens"].yearLabel = "0 ADP"
end

if ev["fall_guardian"] then
    ev["fall_guardian"].title = "Der Fall des Wächters"
    ev["fall_guardian"].yearLabel = "3 ADP"
end

if ev["fall_stormwind"] then
    ev["fall_stormwind"].title = "Der Fall Sturmwinds"
    ev["fall_stormwind"].yearLabel = "3 ADP"
end

-- ============ SECOND_WAR ============

if ev["alliance_lordaeron"] then
    ev["alliance_lordaeron"].title = "Die Allianz von Lordaeron"
    ev["alliance_lordaeron"].yearLabel = "4 – 5 ADP"
end

if ev["horde_campaign"] then
    ev["horde_campaign"].title = "Der Feldzug der Horde"
    ev["horde_campaign"].yearLabel = "6 ADP"
end

if ev["guldan_betrayal"] then
    ev["guldan_betrayal"].title = "Gul'dans Verrat"
    ev["guldan_betrayal"].yearLabel = "6 ADP"
end

if ev["siege_blackrock"] then
    ev["siege_blackrock"].title = "Die Schlacht am Schwarzfels"
    ev["siege_blackrock"].yearLabel = "6 ADP"
end

-- ============ BETWEEN_WARS ============

if ev["sons_of_lothar"] then
    ev["sons_of_lothar"].title = "Die Söhne Lothars"
    ev["sons_of_lothar"].yearLabel = "7 – 8 ADP"
end

if ev["birth_lich_king"] then
    ev["birth_lich_king"].title = "Die Scherbenwelt und der Lichkönig"
    ev["birth_lich_king"].yearLabel = "8 ADP"
end

if ev["grim_batol"] then
    ev["grim_batol"].title = "Die Schlacht von Grim Batol"
    ev["grim_batol"].yearLabel = "10 ADP"
end

if ev["war_spider_cult"] then
    ev["war_spider_cult"].title = "Der Krieg der Spinne und der Kult der Verdammten"
    ev["war_spider_cult"].yearLabel = "10 – 18 ADP"
end

if ev["thrall_new_horde"] then
    ev["thrall_new_horde"].title = "Die neue Horde"
    ev["thrall_new_horde"].yearLabel = "18 – 19 ADP"
end

-- ============ THIRD_WAR ============

if ev["plague_lordaeron"] then
    ev["plague_lordaeron"].title = "Die Seuche von Lordaeron"
    ev["plague_lordaeron"].yearLabel = "20 ADP"
end

if ev["frostmourne_claimed"] then
    ev["frostmourne_claimed"].title = "Frostgram"
    ev["frostmourne_claimed"].yearLabel = "20 ADP"
end

if ev["fall_quelthalas_dalaran"] then
    ev["fall_quelthalas_dalaran"].title = "Der Fall von Quel'Thalas und Dalaran"
    ev["fall_quelthalas_dalaran"].yearLabel = "20 ADP"
end

if ev["horde_kalimdor"] then
    ev["horde_kalimdor"].title = "Die Horde in Kalimdor"
    ev["horde_kalimdor"].yearLabel = "20 ADP"
end

if ev["battle_hyjal"] then
    ev["battle_hyjal"].title = "Die Schlacht am Berg Hyjal"
    ev["battle_hyjal"].yearLabel = "21 ADP"
end

-- ============ NEW_ORDER ============

if ev["illidan_betrayer"] then
    ev["illidan_betrayer"].title = "Illidan, der Verräter"
    ev["illidan_betrayer"].yearLabel = "22 ADP"
end

if ev["forsaken_lichking"] then
    ev["forsaken_lichking"].title = "Die Verlassenen und der neue Lichkönig"
    ev["forsaken_lichking"].yearLabel = "22 ADP"
end

if ev["durotar_founded"] then
    ev["durotar_founded"].title = "Die Gründung Durotars"
    ev["durotar_founded"].yearLabel = "23 ADP"
end


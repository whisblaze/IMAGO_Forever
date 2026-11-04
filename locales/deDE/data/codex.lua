-- ============================================================
-- IMAGO Forever — locales/deDE/data/codex.lua
-- Localized Codex text: title, body and aliases per entry slug.
-- Structure (slugs, categories, related, linkable) lives in
-- data/codex_static.lua.
--
-- aliases = extra names the TextLinker will auto-link to this
-- entry (title is linked automatically when linkable = true).
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.codex = IMAGOdb.codex or {}
IMAGOdb.codex.entries = IMAGOdb.codex.entries or {}

-- Category display names
IMAGOdb.codexCatNames = {
    cosmos     = "Kosmos & Urkräfte",
    magic      = "Magie & Glauben",
    worlds     = "Welten & Geographie",
    sites      = "Historische Anlagen & Artefakt-Orte",
    peoples    = "Völker & Kreaturen (nicht spielbar)",
    factions   = "Fraktionen & Orden",
    artifacts  = "Artefakte & Waffen",
    concepts   = "Konzepte, Titel & Bräuche",
}

local e = IMAGOdb.codex.entries

-- ============ COSMOS ============

if e["cosmic_forces"] then
    e["cosmic_forces"].title = "Die sechs kosmischen Mächte"
    e["cosmic_forces"].aliases = { "Cosmic Forces" }
    e["cosmic_forces"].body = [[
Sechs Kräfte der Magie ringen im Großen Dunklen Jenseits um die Vorherrschaft. Es gibt das Licht und die Leere, die einander ständig gegenüberstehen, und es gibt Leben und Tod, die über jedes Wesen herrschen.

Die Kräfte von Ordnung und Unordnung, einander gegenüberstehend als die Titanen und die Brennende Legion, sind der vollständigen Vorherrschaft am nächsten gekommen.
]]
end

if e["holy_light"] then
    e["holy_light"].title = "Licht"
    e["holy_light"].body = [[
Heilige, wohlwollende Magie, die jedem hilft, der stark im Glauben ist. Sie wird überwiegend zum Guten eingesetzt, etwa von Priestern, die Verwundete heilen, oder von Paladinen, die Hilflose beschützen. Doch das Licht selbst unterscheidet Liebe nicht von Hass.

Es kann in vielen Formen erscheinen und wird in vielen Kulturen als Macht der Verehrung geehrt.
]]
end

if e["void"] then
    e["void"].title = "Leere"
    e["void"].body = [[
Eine kosmische Macht, die alles und nichts zugleich ist. Ein endloser Hunger mit dem Ziel, das gesamte physische Universum zu verschlingen und es zu einem Ort der Qual zu machen.

Sterbliche haben oft versucht, die Macht der Leere zu führen, denn sie gewährt unendliche Möglichkeiten und süße Versprechen. Doch fast alle, die sie zu beherrschen versuchen, verfallen früher oder später dem Wahnsinn.
]]
end

if e["life"] then
    e["life"].title = "Leben"
    e["life"].body = [[
Die Kraft der Natur, der Erneuerung und des Wachstums im Kosmos. Lebensmagie zeigt sich durch die Elemente und ist in ihrer reinsten Form im Smaragdgrünen Traum zu beobachten.

Druiden und Schamanen teilen eine angeborene Verbindung zum Land und lenken Lebensmagie, um das empfindliche Gleichgewicht der Welt zu bewahren.
]]
end

if e["death"] then
    e["death"].title = "Tod"
    e["death"].body = [[
Eine der sechs kosmischen Mächte und das Gegengewicht zum Leben. Der Tod bedeutet das Ende von allem, was existiert, und fordert am Ende jede Seele.

Zugleich bietet er neue Anfänge, denn seine Magie durchdringt die Geisterreiche. Todesmagie kann von Nekromanten eingesetzt werden.
]]
end

if e["great_dark_beyond"] then
    e["great_dark_beyond"].title = "Großes Dunkle Jenseits"
    e["great_dark_beyond"].aliases = { "Great Dark Beyond" }
    e["great_dark_beyond"].body = [[
So heißt das physische Universum, das aus endlosen Planeten, Sternen und Zivilisationen besteht.

Nach den Titanen entstand das Große Dunkle Jenseits, als ein Zusammenstoß zwischen dem Licht und der Leere das Gefüge der Schöpfung zerriss.
]]
end

if e["twisting_nether"] then
    e["twisting_nether"].title = "Wirbelnder Nether"
    e["twisting_nether"].aliases = { "Twisting Nether" }
    e["twisting_nether"].body = [[
Der Wirbelnde Nether ist ein chaotisches Reich zwischen der physischen und der astralen Ebene. Die Brennende Legion stammt von dort, und jeder getötete Dämon wird durch die Magie des Nethers wiedergeboren.

Es gibt keinen einzigen Weg, seine unzähligen verschiedenen Energien wahrzunehmen. Viele sind allein vom Anblick dieser verdrehten Dimension dem Wahnsinn verfallen.
]]
end

if e["world_souls"] then
    e["world_souls"].title = "Weltenseelen"
    e["world_souls"].aliases = { "World-Souls", "World-Soul" }
    e["world_souls"].body = [[
Weltenseelen sind die Geister der Titanen. Sie entstanden tief im feurigen Kern einiger weniger Welten und schlummerten dort Äonen lang, während ihre Energien die Himmelskörper durchdrangen.

Wenn sie erwachten, taten sie es als lebende Welten. Das Pantheon suchte unablässig nach ihnen und hoffte, durch die Ordnung neuer Welten die Seelen hervorzurufen und zur Reife zu bringen.

Auch Azeroth beherbergt eine solche schlummernde Weltenseele.
]]
end

if e["titans"] then
    e["titans"].title = "Titanen"
    e["titans"].aliases = { "Titans" }
    e["titans"].body = [[
Geboren aus den Seelen empfindsamer Planeten sind die Titanen gewaltige Wesen aus arkaner Energie, deren Macht nur von wenigen übertroffen wird.

Sie durchstreifen den Kosmos auf der Suche nach weiteren Weltenseelen und bekämpfen die Verderbnis der Leere und der Unordnung, wo immer sie ihnen begegnen. Azeroth wurde von den Titanen nicht nur vom Makel der Alten Götter gereinigt. Die Welt und all ihre Reiche wurden geordnet, und Maschinenvölker wie die Hüter und die Irdenen wurden nach dem Vorbild der Titanen erschaffen, um ihre Vision eines perfekten Azeroth zu bewahren.
]]
end

if e["pantheon"] then
    e["pantheon"].title = "Pantheon"
    e["pantheon"].body = [[
Das Pantheon war die herrschende Ordnung der Titanen. Seine Mitglieder:

• Aman'Thul der Hochvater

• Sargeras der Verteidiger (vor seinem Fall)

• Aggramar sein Stellvertreter

• Eonar die Lebensbinderin

• Khaz'goroth der Former und Weltenschmied

• Norgannon der Wächter der himmlischen Magien und Lehren

• Golganneth der Herr der Himmel und tosenden Meere
]]
end

if e["void_lords"] then
    e["void_lords"].title = "Leerenfürsten"
    e["void_lords"].aliases = { "Void Lords" }
    e["void_lords"].body = [[
Die Leerenfürsten sind monströse Wesenheiten aus purer Schattenenergie. Sie sind grausamer und gnadenloser, als ein Sterblicher begreifen kann. Getrieben von unstillbarem Hunger verschlingen sie alle Substanz und Energie des materiellen Universums.

In ihrem natürlichen Zustand existieren sie außerhalb der Realität. Nur die mächtigsten von ihnen können im materiellen Universum Gestalt annehmen, und selbst das nur für begrenzte Zeit. Um ihre Präsenz in der Realität aufrechtzuerhalten, müssen sie unvorstellbare Mengen an Materie und Energie konsumieren.
]]
end

if e["old_gods"] then
    e["old_gods"].title = "Alte Götter"
    e["old_gods"].aliases = { "Old Gods" }
    e["old_gods"].body = [[
Die Alten Götter sind unheimliche fleischige Manifestationen der Leerenfürsten. Vier von ihnen herrschten über Azeroth und wuchsen wie Krebsgeschwüre in die Welt hinein. Eines von ihnen zu töten beschädigte Azeroth so sehr, dass die Titanen beschlossen, die übrigen drei einzusperren: N'Zoth, C'Thun und Yogg-Saron.

Wie die Leere selbst flüstern die Alten Götter mysteriöse Prophezeiungen, und schon ihre Anwesenheit reicht aus, um einen Geist dem Wahnsinn zu übergeben.
]]
end

if e["emerald_dream"] then
    e["emerald_dream"].title = "Smaragdgrüner Traum"
    e["emerald_dream"].aliases = { "The Emerald Dream" }
    e["emerald_dream"].body = [[
Ein Reich der Geister, das parallel zu Azeroth existiert und der Welt zeigt, wie sie in ihrem natürlichen Zustand ohne intelligente Gesellschaften wäre. Es ist ein Reich, das Druiden oft im Schlaf besuchen, um von ihm zu lernen, wie sie Azeroth besser helfen können.

Der Aspekt des grünen Drachenschwarms herrscht über den Smaragdgrünen Traum.
]]
end

if e["emerald_nightmare"] then
    e["emerald_nightmare"].title = "Smaragdgrüner Alptraum"
    e["emerald_nightmare"].aliases = { "Emerald Nightmare" }
    e["emerald_nightmare"].body = [[
Durch den Weltenbaum Andrassil erlangte der Alte Gott Yogg-Saron Zugang zum Smaragdgrünen Traum. Er verderbte ihn von einem heiteren natürlichen Abbild Azeroths zu einem schrecklichen Ort des Verfalls.

Träumer, die im Alptraum gefangen werden, erwachen vielleicht nie wieder, und sein übler Makel kann sich vom Geisterreich bis in die physische Welt ausbreiten.
]]
end

if e["shadowlands"] then
    e["shadowlands"].title = "Schattenlande"
    e["shadowlands"].body = [[
Wie der Smaragdgrüne Traum sind die Schattenlande indirekt mit Azeroth verbunden. Doch während der Traum das Leben repräsentiert, stehen die Schattenlande für den Tod. Sie sind albtraumhafte Reiche des Niedergangs, labyrinthische spirituelle Ebenen, bevölkert von den Seelen all jener, die die Welt der Lebenden hinter sich gelassen haben.

Über ihren Ursprung ist wenig bekannt. Doch sie existieren, seit sich das erste sterbliche Leben im physischen Universum regte. Viele glauben, dass die Seelen der Sterblichen im Augenblick des Todes zu diesem finsteren Ort gezogen werden, wo sie bis in alle Ewigkeit verweilen.
]]
end

if e["elements"] then
    e["elements"].title = "Elemente"
    e["elements"].body = [[
Jeder Planet im Großen Dunklen Jenseits beherbergt eigene Elemente, unbeständige natürliche Energien, die über die Form von Natur und Leben entscheiden. Sie können sich physisch als Elementargeister manifestieren und ihren natürlichen Zweck als primitive Lebensform erfüllen.

In Azeroth sind von Natur aus fünf Elemente eingeprägt: Feuer, Wasser, Luft, Erde und Geist. Letzterer wurde allerdings teilweise von der Weltenseele verzehrt.
]]
end

if e["elemental_lords"] then
    e["elemental_lords"].title = "Elementarlords"
    e["elemental_lords"].aliases = { "Elemental Lords" }
    e["elemental_lords"].body = [[
Die Anführer und Mächtigsten der Elementare. In Azeroths Urzeiten hielt die Herrschaft der vier Elementarlords die Welt in einem Zustand ständigen natürlichen Chaos.

Sie wurden zuerst von den Alten Göttern während des Schwarzen Imperiums unterworfen und dann von den Titanenhütern in die Elementarebene eingesperrt.
]]
end

if e["elemental_plane"] then
    e["elemental_plane"].title = "Elementarebene"
    e["elemental_plane"].aliases = { "Elemental Plane" }
    e["elemental_plane"].body = [[
Eine Taschendimension titanischer Machart, geschaffen, um die Elementarlords Azeroths einzusperren. Sie umfasst vier miteinander verknüpfte Dimensionen, eine für jedes der vorherrschenden Elemente: die Feuerlande, die Himmelswand, Tiefenheim und den Abgründigen Schlund.

Die verbannten Elemente kämpfen in den Grenzen ihrer Gefängnisdimensionen endlose Schlachten.
]]
end

-- ============ MAGIC ============

if e["arcane"] then
    e["arcane"].title = "Arkane Magie"
    e["arcane"].body = [[
Auch als Magie der Ordnung bekannt. Das Arkane ist die magische Sprache der Titanen und vielleicht die vielseitigste aller kosmischen Mächte.

Mit genug Intellekt, Geduld und Studium kann ein Magier lernen, das Arkane in fast jede Form zu formen, die er braucht. Manipulation von Zeit und Raum, Herbeizauberung von Gegenständen aus dem Nichts, Teleportation, rohe Zerstörung. Die Vorstellungskraft ist die Grenze.
]]
end

if e["fel"] then
    e["fel"].title = "Teufelsmagie"
    e["fel"].aliases = { "Fel Magic" }
    e["fel"].body = [[
Die kränklich grüne Magie des Teufelischen ist manifestiertes Chaos. Sie ist eine unbeständige Magie, die dem Wirker leicht fällt und große Macht für einen großen Preis verspricht. Das Teufelische verdirbt den Zauberwirker und bedeutet großes Leid für die Opfer seiner Zauber.

Alle Dämonen der Brennenden Legion tragen seinen Makel und tragen die Verderbnis rasch durch das Große Dunkle Jenseits.
]]
end

if e["church_holy_light"] then
    e["church_holy_light"].title = "Kirche des Heiligen Lichts"
    e["church_holy_light"].aliases = { "Church of the Holy Light" }
    e["church_holy_light"].body = [[
Seit über zweitausend Jahren ist die Verehrung des Heiligen Lichts die vorherrschende Religion der Menschen. In der Kirche haben sie eine Institution von Priestern, die die Tugenden des Lichts kanalisieren und lehren.

Mit der Bedrohung durch die orcische Horde im Zweiten Krieg lehrte die Kirche Ritter, das Licht im Kampf zu nutzen, und erschuf die allerersten Paladine.
]]
end

if e["druids"] then
    e["druids"].title = "Druidentum"
    e["druids"].body = [[
Das Druidentum ist eine Schule der Naturmagie. Sie befähigt die Druiden dazu, natürliche Energien zu kanalisieren und sich in Tiere zu verwandeln.

Der erste Druide auf Azeroth war Malfurion Sturmgrimm, der von Cenarius, einem Halbgott der Natur, unterrichtet wurde. Druiden verfügen über eine tiefe Verbindung zur Natur, und zwar durch den Smaragdgrünen Traum, ein ursprüngliches Reich, das alle Aspekte der Natur vereint.
]]
end

if e["shamanism"] then
    e["shamanism"].title = "Schamanismus"
    e["shamanism"].body = [[
Schamanen sind Zauberwirker, die zwischen den Elementen und ihrem eigenen Volk vermitteln. Sie werden von der Natur erwählt und können die elementaren Kräfte niemals fordern, sondern müssen sich ihrer würdig erweisen. Manche von ihnen können mit der Welt selbst kommunizieren.

Die stärksten Schamanen können Berge versetzen und an einem schönen Tag Schneestürme erzeugen, und prophetische Visionen warnen sie vor der Zukunft. Auf dem Schlachtfeld werden sie gefürchtet und als Älteste verehrt.
]]
end

if e["necromancy"] then
    e["necromancy"].title = "Nekromantie"
    e["necromancy"].body = [[
Kaum etwas ist so abscheulich und verwerflich wie der Gebrauch von Magie, um die Toten zu erwecken und zu beherrschen. Nekromanten sind die Feinde des Lebens selbst. Sie werden allseits verachtet und gefürchtet.

Einige der grässlichsten Taten in Azeroths Geschichte wurden von ihnen verübt. Ihren üblen Ruf haben sie sich redlich verdient.

Nekromanten und Todesritter erwecken die Körper der Gefallenen gewaltsam zu willenlosen Dienern. Die Seele des Leichnams nimmt dabei großen Schaden.
]]
end

if e["council_of_tirisfal"] then
    e["council_of_tirisfal"].title = "Rat von Tirisfal"
    e["council_of_tirisfal"].aliases = { "Council of Tirisfal" }
    e["council_of_tirisfal"].body = [[
Der leichtsinnige Einsatz arkaner Magie aus Dalaran erregte die Aufmerksamkeit der Dämonen der Brennenden Legion. Beunruhigt vom Ausmaß dieser gewaltigen feindlichen Armee wurde dieser geheime Rat gebildet. Sein Ziel war es, alle Agenten der Legion auf Azeroth zu finden und zu vernichten.

Angeführt wird er vom Wächter.
]]
end

if e["guardians_tirisfal"] then
    e["guardians_tirisfal"].title = "Wächter von Tirisfal"
    e["guardians_tirisfal"].aliases = { "Guardian of Tirisfal", "Guardians of Tirisfal", "the Guardian" }
    e["guardians_tirisfal"].body = [[
Um die grausamsten Dämonen zu bekämpfen, wählte der Rat von Tirisfal einen Champion und erfüllte ihn mit ihrer vereinten Macht. Der Wächter wurde so ein außergewöhnlich mächtiger Magier.

Noch vor seiner Geburt ging der Geist des dunklen Titanen Sargeras von seiner Mutter Aegwynn auf den ungeborenen Medivh über. Von Geburt an besessen, errichtete der letzte Wächter später das Dunkle Portal und ermöglichte der orcischen Horde den Einzug nach Azeroth. Es wurde beschlossen, dass nie wieder ein einzelner Sterblicher solche Macht führen sollte.
]]
end

if e["plague_of_undeath"] then
    e["plague_of_undeath"].title = "Seuche des Untodes"
    e["plague_of_undeath"].aliases = { "Plague of Undeath" }
    e["plague_of_undeath"].body = [[
Die Seuche des Untodes ist eine magische Plage, die der Lichkönig nach seiner Erschaffung durch Kil'jaeden über Lordaeron brachte. Durch kontaminierte Kornlieferungen, die der Erzmagier Kel'Thuzad ins Königreich schmuggelte, verwandelt sie die Lebenden in untote Diener der Geißel.

So entstand die untote Armee, mit der die Brennende Legion ihren erneuten Angriff auf Azeroth begann.
]]
end

if e["elune"] then
    e["elune"].title = "Elune"
    e["elune"].body = [[
Die Göttin des Mondes wird von den Kaldorei als ihre wichtigste Gottheit verehrt. Ihre Gunst gewährt ihren Priesterinnen die Macht, Verbündete zu heilen, die Dunkelheit zu erleuchten und ihre Feinde in heiligem Mondlicht zu vernichten.

Bei den Tauren ist sie als Mu'sha bekannt, und sie glauben, dass sie eine Tochter der Erdenmutter ist.
]]
end

if e["earth_mother"] then
    e["earth_mother"].title = "Erdenmutter"
    e["earth_mother"].aliases = { "Earth Mother" }
    e["earth_mother"].body = [[
Der Tauren-Mythos sieht die Erdenmutter als die Schöpferin des Landes, und die tiefe Ehrfurcht der Tauren vor der Natur spiegelt ihren Glauben.

Obwohl sie vor Jahrtausenden alles von sich gab, um das Land von den Alten Göttern zu befreien, wissen die Tauren, dass die Erdenmutter noch immer über all ihre Kinder wacht.
]]
end

if e["anshe"] then
    e["anshe"].title = "An'she"
    e["anshe"].aliases = { "Mu'sha" }
    e["anshe"].body = [[
An'she ist die Sonne, die die Tauren als Gottheit verehren. Er ist der Zwillingsbruder des Mondes Mu'sha und eines der Augen der Erdenmutter.

Taurenpriester können das Licht durch die Verehrung von An'she kanalisieren.
]]
end

-- ============ WORLDS ============

if e["azeroth"] then
    e["azeroth"].title = "Azeroth"
    e["azeroth"].body = [[
Azeroth ist sowohl der Name des Planeten als auch der schlummernden Weltenseele in seinem Inneren. Nahezu alle kosmischen Mächte haben Azeroth in der Vergangenheit und Gegenwart begehrt, und ihre Champions haben vor nichts Halt gemacht, sie zu beschützen.

Nach den Titanen wird Azeroth, wenn sie erwacht, die Mächtigste unter ihnen sein.
]]
end

if e["kalimdor"] then
    e["kalimdor"].title = "Kalimdor"
    e["kalimdor"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["eastern_kingdoms"] then
    e["eastern_kingdoms"].title = "Östliche Königreiche"
    e["eastern_kingdoms"].aliases = { "Eastern Kingdoms" }
    e["eastern_kingdoms"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["northrend"] then
    e["northrend"].title = "Nordend"
    e["northrend"].aliases = { "Northrend" }
    e["northrend"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["draenor"] then
    e["draenor"].title = "Draenor / Scherbenwelt"
    e["draenor"].aliases = { "Draenor", "Outland" }
    e["draenor"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["argus"] then
    e["argus"].title = "Argus"
    e["argus"].body = [[
Argus war die Heimatwelt der Eredar, eines intelligenten Volkes, das aus seinem Wissensdurst das Universum verbessern wollte. Der Planet wurde regiert vom mächtigen Archimonde, dem genialen Kil'jaeden und dem spirituellen Anführer Velen.

Zu ihrem aller Unglück brauchte Sargeras mächtige Diener, die seine Brennende Legion anführten, also brachte er die Eredar dazu, zu seinen dämonischen Generälen zu werden. Nur Velen und seinen loyalen Anhängern gelang die Flucht auf der Genedar. Sie wurden als Draenei bekannt, die Verbannten.
]]
end

if e["karesh"] then
    e["karesh"].title = "K'aresh"
    e["karesh"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["well_of_eternity"] then
    e["well_of_eternity"].title = "Brunnen der Ewigkeit"
    e["well_of_eternity"].aliases = { "Well of Eternity" }
    e["well_of_eternity"].body = [[
Unter dem Weltenbaum Nordrassil ruht ein schimmernder See von gewaltiger arkaner Macht. Es ist der zweite Brunnen der Ewigkeit, denn der erste wurde zerstört und verursachte die Große Teilung am Ende des Kriegs der Ahnen.

Obwohl er deutlich schwächer ist als der ursprüngliche Brunnen und Nordrassil seinen Einfluss eingrenzt, ist er noch immer eine der mächtigsten Quellen der Magie auf Azeroth. Die Brennende Legion begehrte ihn bereits zweimal, um ihre Invasion zu beschleunigen.
]]
end

if e["maelstrom"] then
    e["maelstrom"].title = "Mahlstrom"
    e["maelstrom"].aliases = { "The Maelstrom" }
    e["maelstrom"].body = [[
Im Zentrum des Großen Meeres, das die Kontinente trennt, erzeugt dieser gewaltige Wasserwirbel einen ständigen Sturm, der mit Schiffen unmöglich zu überqueren ist.

Der Mahlstrom entstand, als der ursprüngliche Brunnen der Ewigkeit während der Großen Teilung implodierte.
]]
end

if e["dark_portal"] then
    e["dark_portal"].title = "Dunkles Portal"
    e["dark_portal"].aliases = { "Dark Portal" }
    e["dark_portal"].body = [[
Ein gewaltiges Portal, das als Tor zwischen Azeroth und Draenor erschaffen wurde, um die Invasion der Alten Horde und den Ersten Krieg zu ermöglichen. Es wurde in zwei identischen Ausführungen auf beiden Planeten gebaut, von Medivh und Gul'dan.

Die Öffnung des Portals markierte den Beginn einer neuen Ära für Azeroth und dient heute als Ausgangspunkt des Kalenders.
]]
end

if e["world_trees"] then
    e["world_trees"].title = "Weltenbäume"
    e["world_trees"].aliases = { "World Trees", "Nordrassil", "Vordrassil" }
    e["world_trees"].body = [[
Diese gewaltigen magischen Bäume sind mit dem Smaragdgrünen Traum verbunden. Sie sind den Kaldorei heilig, und die Elfen errichteten in einigen von ihnen sogar ihre Heime.

Die großen Bäume sind von Natur aus magisch und dienen vielen verschiedenen Zwecken. Sie gewährten den Nachtelfen die Unsterblichkeit und halten die Mächte des Brunnens der Ewigkeit an ihrem Platz.
]]
end

if e["moonwells"] then
    e["moonwells"].title = "Mondbrunnen"
    e["moonwells"].aliases = { "Moonwells" }
    e["moonwells"].body = [[
Diese Becken silbrigen Wassers finden sich nahe fast jeder größeren nachtelfischen Siedlung. Sie sind Reservoirs des zweiten Brunnens der Ewigkeit und gefüllt mit einer Mischung aus Naturmagie und den Segen Elunes.

Mondbrunnen heilen sowohl das Land um sie herum als auch jedes Wesen, das mit ihrem heiligen Wasser in Berührung kommt.
]]
end

if e["ley_lines"] then
    e["ley_lines"].title = "Leylinien"
    e["ley_lines"].aliases = { "Ley Lines" }
    e["ley_lines"].body = [[
Leylinien bilden Netzwerke von Kanälen gewaltiger arkaner Energie auf einem Planeten, vergleichbar mit Blutgefäßen in einem sterblichen Körper. Wo sich solche Linien zu Knotenpunkten vereinigen, haben Magier festgestellt, dass ihre Zauber erheblich stärker wirken.

Magische Stätten wurden aus diesem Grund oft auf diesen Knotenpunkten errichtet, etwa der Brunnen der Ewigkeit und Dalaran.
]]
end

-- ============ SITES ============

if e["tomb_of_sargeras"] then
    e["tomb_of_sargeras"].title = "Grabmal des Sargeras"
    e["tomb_of_sargeras"].aliases = { "Tomb of Sargeras" }
    e["tomb_of_sargeras"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["forge_of_wills"] then
    e["forge_of_wills"].title = "Schmiede des Willens und des Ursprungs"
    e["forge_of_wills"].aliases = { "Forge of Wills", "Forge of Origination" }
    e["forge_of_wills"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

-- ============ PEOPLES ============

if e["earthen"] then
    e["earthen"].title = "Irdenen"
    e["earthen"].aliases = { "Earthen" }
    e["earthen"].body = [[
Die Irdenen kamen als zweite Generation aus der Schmiede des Willens, nachdem der erste Entwurf der Hüter die wilden Troggs hervorgebracht hatte. Die felsigen, gutherzigen Irdenen formten Berge und trieben die tiefen Stellen der Welt aus.

Als der Fluch des Fleisches unter ihnen ausbrach, baten viele um den Schlaf in Uldaman. Bei der Großen Teilung folgten ihnen weitere, weil sie den Schmerz der gebrochenen Welt als den ihren fühlten. Jene, die wach blieben oder Äonen später erwachten, degenerierten zu Wesen aus Fleisch.

Aus ihnen wurden die Zwerge.
]]
end

if e["vrykul"] then
    e["vrykul"].title = "Vrykul"
    e["vrykul"].body = [[
Die Vrykul sind ein eisenhäutiges Volk der Titanengeschmiedeten, einst damit beauftragt, den Besitz der Hüter zu bewachen. Nach Lokens Verrat lebten sie im Norden Kalimdors in kleinen Clans, manche als Nomaden, andere in Siedlungen.

Kriegerische Stämme wie die Winterkorn glaubten daran, nach einem glorreichen Tod in die Hallen der Tapferkeit aufzusteigen. Die Vrykul waren die Ersten, die den Fluch des Fleisches zeigten.

Jahrtausende später gebaren sie verkümmerte Kinder aus Fleisch. König Ymiron befahl, sie zu töten, doch manche Eltern brachten die Kinder in den Süden.

Aus ihnen wurden die Menschen.
]]
end

if e["mechagnomes"] then
    e["mechagnomes"].title = "Mechagnome"
    e["mechagnomes"].aliases = { "Mechagnomes" }
    e["mechagnomes"].body = [[
Die Mechagnome sind kleine Uhrwerkwesen, die Hüter Mimiron entworfen hatte, um die außergewöhnlichen Maschinen der Hüter zu bauen und zu warten. Als Mimiron durch Lokens Sabotage starb, retteten ihm seine treuen Mechagnome das Leben, indem sie einen mechanischen Körper für seine Seele bauten.

Später folgte eine Gruppe von ihnen den Hütern Tyr, Archaedas und Ironaya nach Uldaman. Dort blieben sie wach, um die Festung zu warten, während die Irdenen schliefen, bis auch sie dem Fluch des Fleisches erlagen.

Aus ihnen wurden die Gnome.
]]
end

if e["tolvir"] then
    e["tolvir"].title = "Tol'vir"
    e["tolvir"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["anubisath_giants"] then
    e["anubisath_giants"].title = "Anubisath-Riesen und Riesenarten"
    e["anubisath_giants"].aliases = { "Anubisath Giants" }
    e["anubisath_giants"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["naga"] then
    e["naga"].title = "Naga"
    e["naga"].body = [[
Die schlangenartigen Naga gehören zu den berüchtigsten Schurken von Azeroth. Diese Meister der Zauberei waren einst Nachtelfen, die im Krieg der Ahnen am Hof von Königin Azshara dienten.

Als der Brunnen der Ewigkeit bei der Großen Teilung zerbrach, riss der Mahlstrom sie in die Tiefen des Meeres. Von den Alten Göttern verwandelt, suchen sie seither die Meere Azeroths heim.

In der Finsternis des Meeresgrunds errichteten Azshara und ihre Getreue die Hauptstadt Nazjatar.
]]
end

if e["murlocs"] then
    e["murlocs"].title = "Murlocs"
    e["murlocs"].body = [[
Die Murlocs sind für Abenteurer in Azeroth nach wie vor eine besondere Begegnung. Sie sind für ihren gurgelnden Schlachtruf bekannt und neigen dazu, Ahnungslose mit primitiven Speeren, schleimigen Gliedmaßen, fischigem Atem und Elementarmagie anzugreifen und zu überwältigen.

Sie leben entlang von Küsten, Flüssen und Seen und treten stets in Scharen auf. Dabei sind sie soziale Wesen und ziehen sich, wenn sie angegriffen werden, meist vom Kampf zurück in die Sicherheit der größeren Gruppe ihrer Artgenossen.

Zwar gibt es Fälle friedlicher Interaktion zwischen Murlocs und anderen Völkern, doch diese sind selten.
]]
end

if e["makrura"] then
    e["makrura"].title = "Makrura"
    e["makrura"].body = [[
Die Makrura, manchmal auch Lobstrok genannt, sind ein primitives Volk von Wasserbewohnern, die auch kurze Zeit an Land überleben können. Diese Krabbenwesen existieren in Kolonien entlang der Küsten von Azeroth und in den Tiefen der Ozeane.

Besonders die ungewöhnlich mächtigen unter ihnen sind gefürchtete Gegner.
]]
end

if e["kobolds"] then
    e["kobolds"].title = "Kobolde"
    e["kobolds"].aliases = { "Kobolds" }
    e["kobolds"].body = [[
Die rattenartigen Kobolde sind Gerüchten zufolge Abkömmlinge der Troggs. Obwohl sie unter der Erde leben, haben die Kobolde keine besonders guten Nachtsichtfähigkeiten und verlassen sich beim Wandern durch ihre heimatlichen Minen auf Kerzen.

Die Kobolde fürchten sich vor anderen Völkern und sind daher in Minen oder an der Oberfläche in der Nähe zu finden. Seltsamerweise ist es den Klans der Kobolde trotzdem gelungen, Verbindungen zu zwei anderen Völkern zu unterhalten, die nicht unbedingt für ihre friedlichen Beziehungen zu anderen bekannt sind: zu den bösartigen Harpyien und den Magnatauren aus Nordend.
]]
end

if e["gnolls"] then
    e["gnolls"].title = "Gnolle"
    e["gnolls"].aliases = { "Gnolls" }
    e["gnolls"].body = [[
Die brutalen und kriegerischen Gnolle schätzen Stärke mehr als alles andere. Auch wenn sie wilde und gefürchtete Kämpfer sind, gehören die Gnolle keineswegs zu den intelligentesten Völkern.

Gnolle wurden oft als Söldner verpflichtet, doch ihr Hang zur Grausamkeit und ihre beschränkte Intelligenz machen dauerhafte Beaufsichtigung nötig.

Ein besonders grimmiger Gnoll namens Hogger terrorisiert den Wald von Elwynn.
]]
end

if e["troggs"] then
    e["troggs"].title = "Troggs"
    e["troggs"].body = [[
Die Troggs entstanden als erster, misslungener Entwurf der Schmiede des Willens — missgestaltete, brutale und gefährliche Wesen. Jahrtausendelang ruhten sie ungestört tief unter der Erde, bis die Zwerge die Festungen der Titanen, so etwa Uldaman, ausgruben.

Sobald sie erwacht waren, strömten die Troggs aus der Erde, begierig darauf, ihre Aggressionen an ihren entfernten zwergischen Verwandten auszulassen. Auch wenn sie im Kampf recht gerissen sind, kann man die Troggs allgemein nicht als sonderlich intelligent bezeichnen. Stattdessen verlassen sie sich darauf, dass ihre Wildheit und ihre dicke Haut sie schützen.

Die meisten von ihnen sind gefährliche Kämpfer, doch einige etwas klügere Troggs können auch Zauber wirken.
]]
end

if e["ogres"] then
    e["ogres"].title = "Oger"
    e["ogres"].aliases = { "Ogres" }
    e["ogres"].body = [[
Diese brutalen Humanoiden stammen ursprünglich von Draenor und bewohnen inzwischen verschiedene Regionen in und außerhalb Azeroths. Oger sind gefürchtete Gegner, die für ihre Kraft und Zähigkeit bekannt sind.

Ihre Gesellschaft basiert auf Klans, und jeder Klan ist selbstständig. Innerhalb des Klans ist der Sieg über den Rivalen der einzige Weg zum Aufstieg.

Obwohl sie anderen Völkern normalerweise gleichgültig oder feindlich gegenüberstehen, sind verschiedene Ogerklans zuverlässige Verbündete der Horde geworden. Im Allgemeinen sind Oger nicht für ihre Intelligenz berühmt, doch Magier waren unter ihnen auf Draenor nicht vollkommen unbekannt.

Durch die Bemühungen des Ork-Hexenmeisters Gul'dan wurde vielen Ogern ein schärferer Verstand und die Fähigkeit, Zauber zu wirken, zuteil. Diese Oger-Magier genießen innerhalb der Klans oft großes Ansehen.
]]
end

if e["furbolgs"] then
    e["furbolgs"].title = "Furbolgs"
    e["furbolgs"].body = [[
Nach den mündlichen Traditionen der Furbolgs hat ihr Volk eine weit zurückreichende Geschichte. Sie nahmen widerwillig am Krieg der Ahnen gegen die Brennende Legion teil und schmiedeten danach freundschaftliche Bündnisse mit den Nachtelfen und den Tauren.

Sie lebten in friedlicher Isolation, bis der Dritte Krieg und die Verderbnis der Brennenden Legion die heimatlichen Wälder der Furbolgs vernichteten. Einige Stämme verfielen der Verderbnis, wurden damit gewalttätiger und folgten kriegerischen Anführern, die zu Überfällen auf benachbarte Siedlungen aufriefen. Die unverdorbenen Stämme zogen sich noch weiter zurück, da sie befürchteten, der Kontakt zur Außenwelt könne die Verderbnis in ihre Heimat einschleppen.
]]
end

if e["harpies"] then
    e["harpies"].title = "Harpyien"
    e["harpies"].aliases = { "Harpies" }
    e["harpies"].body = [[
Obwohl manche Geschichten behaupten, die Harpyien seien die Nachkommen von Nachtelfen, die von Königin Azshara verflucht wurden, ist mittlerweile bekannt, dass sie in Wahrheit die Sprößlinge der Halbgöttin Aviana sind. Trotz ihrer körperlichen Ähnlichkeit zu den Nachtelfen haben diese angriffslustigen Wesen wenig mit jenem Volk gemein.

Wie die Nachtelfen nutzen die Harpyien naturbasierte Magie, aber sie zerstören auch die Umgebung, in der sie sich niederlassen, töten alle Lebewesen, auf die sie stoßen, und plündern das Land, um Nester zu bauen, die für ihren schrecklichen Gestank berüchtigt sind. Die Harpyien wurden zuerst im Steinkrallengebirge entdeckt, haben sich mittlerweile jedoch bis in die Sturmgipfel in Nordend ausgebreitet.
]]
end

if e["centaurs"] then
    e["centaurs"].title = "Zentauren"
    e["centaurs"].aliases = { "Centaurs" }
    e["centaurs"].body = [[
Die Zentauren vereinen zahlreiche Eigenschaften in sich: Leidenschaft für den Kampf, Hass auf ihre Ahnen und die Tauren sowie eine überwältigende Verachtung für die Zentauren anderer Stämme. Der Legende nach entstammen sie der Verbindung von Zaetar, dem Sohn des Uralten Cenarius, mit Theradras, der Tochter von Therazane, der elementaren Herrscherin der Erde.

Später wurden die Zentauren bösartig, brutal und grausam und töteten ihren Vater Zaetar.
]]
end

if e["quilboar"] then
    e["quilboar"].title = "Stacheleber"
    e["quilboar"].aliases = { "Quilboar" }
    e["quilboar"].body = [[
Die Stacheleber sind aggressive, eberähnliche Humanoide, die für ihre Furchtlosigkeit und ihre Grausamkeit bekannt sind. Sie glauben, die sterblichen Nachfahren des halbgöttlichen Uralten Agamaggan zu sein, und führten lange mit anderen Völkern, wie den Zentauren und den Tauren, Kriege um Land und Nahrungsmittel.

Ihre Behausungen errichteten sie in den riesigen dornigen Schlingen, von denen sie glauben, sie seien aus dem Blute Agamaggans erwachsen, und gründeten dort ihre Kolonien. Die berühmtesten davon sind der Hügel der Klingenhauer und der Kral der Klingenhauer in Kalimdor, die Heimat der Stämme der Klingenhauer und der Totenköpfe.

Die Stacheleber stehen treu zu ihrem Stamm und verteidigen ihr Territorium mit waghalsiger Wildheit.
]]
end

if e["wolvar"] then
    e["wolvar"].title = "Wolvar"
    e["wolvar"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["taunka"] then
    e["taunka"].title = "Taunka"
    e["taunka"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["tuskarr"] then
    e["tuskarr"].title = "Tuskarr"
    e["tuskarr"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["arakkoa"] then
    e["arakkoa"].title = "Arakkoa"
    e["arakkoa"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["ethereals"] then
    e["ethereals"].title = "Astrale"
    e["ethereals"].aliases = { "Ethereals" }
    e["ethereals"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["magnataurs"] then
    e["magnataurs"].title = "Magnatauren"
    e["magnataurs"].aliases = { "Magnataurs" }
    e["magnataurs"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["high_elves"] then
    e["high_elves"].title = "Hochelfen / Quel'dorei"
    e["high_elves"].aliases = { "High Elves", "Quel'dorei" }
    e["high_elves"].body = [[
Die Hochgeborenen brachen mit den anderen Nachtelfen, da sie die arkane Magie nicht aufgeben wollten. Der Preis dafür war die Verbannung vom Hyjal.

Unter der Führung von Dath'remar Sonnenwanderer stach das verbannte Volk mit einer Flotte in See und überquerte den Mahlstrom. In den Östlichen Königreichen entdeckten seine Späher im Norden einen Ort, an dem sich mächtige Leylinien trafen. Dath'remar goss eine heimlich entwendete Phiole mit Wasser des Brunnens der Ewigkeit in einen See und rief damit den Sonnenbrunnen ins Leben – benannt nach ihm und seiner Verwegenheit.

Das Land nannten die Elfen Quel'Thalas, das Hohe Heim. Da es auf den Ruinen uralter Amani-Heiligtümer errichtet worden war, kämpften die Hochelfen dort jahrhundertelang gegen die Trolle. Innerhalb seiner Grenzen blühte die Zivilisation auf; ihre Hauptstadt Silbermond wurde zum leuchtenden Denkmal für das alte Reich der Elfen.

Im Dritten Krieg riss die Geißel die Verteidigung von Quel'Thalas nieder und die Überlebenden nannten sich fortan Sin'dorei, die Blutelfen.
]]
end

if e["bogstroks"] then
    e["bogstroks"].title = "Bogstroks"
    e["bogstroks"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["highborne"] then
    e["highborne"].title = "Hochgeborene"
    e["highborne"].aliases = { "Highborne" }
    e["highborne"].body = [[
Die Hochgeborenen waren vor zehntausend Jahren die Elite der Kaldorei und dienten eng an der Seite von Königin Azshara. Ihre frühere Treue zur Königin und ihre Unwilligkeit, die arkane Magie aufzugeben, bedeuteten nach der Großen Teilung ihre Verbannung aus der nachtelfischen Kultur.

Manche der Hochgeborenen schlossen sich Dath'remar Sonnenwanderer an und wurden die Quel'dorei. Andere wurden zusammen mit Azshara zu den Naga verdreht. Wieder andere plagten sich in den Wildnissen Kalimdors ab und suchten um jeden Preis nach Mana und arkaner Nahrung.
]]
end

if e["zandalari"] then
    e["zandalari"].title = "Zandalari"
    e["zandalari"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["gurubashi_empire"] then
    e["gurubashi_empire"].title = "Gurubashi"
    e["gurubashi_empire"].aliases = { "Gurubashi Empire" }
    e["gurubashi_empire"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["amani_empire"] then
    e["amani_empire"].title = "Amani"
    e["amani_empire"].aliases = { "Amani Empire" }
    e["amani_empire"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["drakkari"] then
    e["drakkari"].title = "Drakkari"
    e["drakkari"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["fel_orcs"] then
    e["fel_orcs"].title = "Teufelsorcs"
    e["fel_orcs"].aliases = { "Fel Orcs" }
    e["fel_orcs"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["naaru"] then
    e["naaru"].title = "Naaru"
    e["naaru"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["eredar"] then
    e["eredar"].title = "Eredar / Man'ari"
    e["eredar"].aliases = { "Eredar", "Man'ari" }
    e["eredar"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["nathrezim"] then
    e["nathrezim"].title = "Nathrezim / Schreckenslords"
    e["nathrezim"].aliases = { "Nathrezim", "Dreadlords" }
    e["nathrezim"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["annihilan"] then
    e["annihilan"].title = "Annihilan / Grubenlords"
    e["annihilan"].aliases = { "Annihilan", "Pit Lords" }
    e["annihilan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["felguards"] then
    e["felguards"].title = "Mo'arg / Teufelswachen"
    e["felguards"].aliases = { "Felguards", "Mo'arg" }
    e["felguards"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["shivarra"] then
    e["shivarra"].title = "Shivarra / Sayaad"
    e["shivarra"].aliases = { "Shivarra", "Sayaad", "Succubi" }
    e["shivarra"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["wrathguard"] then
    e["wrathguard"].title = "Zornwächter"
    e["wrathguard"].aliases = { "Wrathguard" }
    e["wrathguard"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["infernal"] then
    e["infernal"].title = "Infernale"
    e["infernal"].aliases = { "Infernal" }
    e["infernal"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["fel_reavers"] then
    e["fel_reavers"].title = "Teufelshäscher"
    e["fel_reavers"].aliases = { "Fel Reavers" }
    e["fel_reavers"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["satyrs"] then
    e["satyrs"].title = "Satyrn"
    e["satyrs"].aliases = { "Satyrs" }
    e["satyrs"].body = [[
Die gerissenen und listigen Satyrn sind verdorbene Diener der Brennenden Legion, die sich daran erfreuen, ihren Gegnern körperliche und emotionale Schmerzen zuzufügen. Zum ersten Satyr wurde Xavius, der oberste Ratgeber der früheren Nachtelfenkönigin Azshara.

Als Xavius von Malfurion Sturmgrimm getötet wurde, erzürnten sein Versagen und sein Tod Sargeras, den Herrscher der Brennenden Legion. Nachdem er Xavius' körperlosen Geist gefoltert hatte, veränderte und entstellte er den Nachtelfen und machte aus ihm den ersten Satyr. Zudem verlieh Sargeras ihm die Macht, auch andere in Satyrn zu verwandeln.

Auch wenn die Satyrn in viele verschiedene Fraktionen zersplittert sind und jede dieser Gruppen ihre eigenen Ziele verfolgt, hören alle diese verdorbenen Wesen noch immer auf die Brennende Legion.
]]
end

if e["constructs"] then
    e["constructs"].title = "Konstrukte / Golems"
    e["constructs"].aliases = { "Constructs", "Golems" }
    e["constructs"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["dragonflights"] then
    e["dragonflights"].title = "Drachenschwärme"
    e["dragonflights"].aliases = { "Dragonflights" }
    e["dragonflights"].body = [[
Gewaltige geflügelte Reptilienwesen, die von den Titanen verändert wurden, um als Wächter Azeroths zu dienen. Sie sind hochintelligente Wesen, die der Gestaltwandlung mächtig sind und unglaubliche magische Kraft besitzen.

Sie sind in fünf Schwärme geteilt, von denen jeder damit beauftragt ist, einen anderen Aspekt der titanischen Vision Azeroths zu schützen.
]]
end

if e["black_dragonflight"] then
    e["black_dragonflight"].title = "Schwarzer Drachenschwarm"
    e["black_dragonflight"].aliases = { "Black Dragonflight" }
    e["black_dragonflight"].body = [[
Ein Schwarm obsidianfarbener Drachen, vom Titanen Khaz'goroth damit beauftragt, die Erde und die tiefen Orte darin zu beschützen. Neltharion, lange Zeit der Aspekt des Schwarms, erfüllte seine Pflicht nicht mehr, als die Alten Götter, die zu diesem Zeitpunkt tief in Azeroth verwurzelt waren, ihn verdarbten.

Das Erbe des schwarzen Drachenschwarms sieht sie nicht als edle Beschützer, sondern als Monster im Widerstand gegen alles Leben.
]]
end

if e["red_dragonflight"] then
    e["red_dragonflight"].title = "Roter Drachenschwarm"
    e["red_dragonflight"].aliases = { "Red Dragonflight" }
    e["red_dragonflight"].body = [[
Geführt von Alexstrasza der Lebensbinderin wurde der rote Schwarm vom Titanen Eonar beauftragt und mit dem Schutz allen Lebens auf Azeroth betraut. Rote Drachen können die Natur heilen und Verderbnis mit ihrem heilenden Feuerodem reinigen.

Sie lieben alle Geschöpfe des Universums und handeln nur aggressiv, wenn jemand oder etwas droht, die Schöpfung auf zu zerstörerische Weise zu verletzen.
]]
end

if e["blue_dragonflight"] then
    e["blue_dragonflight"].title = "Blauer Drachenschwarm"
    e["blue_dragonflight"].aliases = { "Blue Dragonflight" }
    e["blue_dragonflight"].body = [[
Ein Drachenschwarm, vom Titanen Norgannon damit beauftragt, den Fluss der Magie auf Azeroth zu kontrollieren und zu verwalten. Die blauen Drachen halten sich meist für sich und verkehren kaum mit Sterblichen. Ihr Verständnis des Arkanen und der Leylinien ist unvergleichlich.

Die Zahl der blauen Drachen wurde von Todesschwinge während des Kriegs der Ahnen stark dezimiert.
]]
end

if e["green_dragonflight"] then
    e["green_dragonflight"].title = "Grüner Drachenschwarm"
    e["green_dragonflight"].aliases = { "Green Dragonflight" }
    e["green_dragonflight"].body = [[
Vom Titanen Eonar damit beauftragt, Azeroths Natur zu beschützen und Wache über den Smaragdgrünen Traum zu halten. Grüne Drachen sind meist friedliche Geschöpfe und arbeiten oft eng mit den Druiden zusammen. Statt ihre Feinde zu töten, versetzen sie sie lieber in Schlaf.

Da sie die meiste Zeit schlafen und zwischen dem Traum und der physischen Welt residieren, sind grüne Drachen sehr anfällig für Verderbnis.
]]
end

if e["bronze_dragonflight"] then
    e["bronze_dragonflight"].title = "Bronzener Drachenschwarm"
    e["bronze_dragonflight"].aliases = { "Bronze Dragonflight" }
    e["bronze_dragonflight"].body = [[
Mit ziemlicher Sicherheit der mysteriöseste der fünf Schwärme. Die Bronzenen wurden von Aman'Thul damit beauftragt, die eine wahre Zeitlinie zu wahren. Ihr Aspekt Nozdormu der Zeitlose hat die gesamte Vergangenheit, Gegenwart und Zukunft gesehen.

Selten gesehen und immer heimlich am Rande handelnd gehören bronzene Drachen zu den weisesten Wesen Azeroths.
]]
end

if e["aspects"] then
    e["aspects"].title = "Drachenaspekte als Institution"
    e["aspects"].aliases = { "Dragon Aspects" }
    e["aspects"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["proto_dragons"] then
    e["proto_dragons"].title = "Protodrachen"
    e["proto_dragons"].aliases = { "Proto-Dragons" }
    e["proto_dragons"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["wild_gods"] then
    e["wild_gods"].title = "Wilde Götter"
    e["wild_gods"].aliases = { "Wild Gods" }
    e["wild_gods"].body = [[
Unsterbliche Manifestationen des Lebens, die aus dem Smaragdgrünen Traum stammen und Sterblichen meist in Gestalt großer Tiere erscheinen.

Sie werden von Druiden verehrt, traditionell von den nachtelfischen, und haben zusammen mit den sterblichen Völkern gearbeitet, wenn eine große Bedrohung die Natur und das Leben gefährdete.
]]
end

if e["loa"] then
    e["loa"].title = "Loa"
    e["loa"].body = [[
Ein Begriff für jedes Wesen, das von Trollen irgendeines Stammes verehrt wird. Die meisten Loa sind Wilde Götter und erscheinen in Gestalt von Tieren, doch auch andere Lebensformen wurden als Loa bekannt, etwa Geister.

Loa variieren in Stärke und segnen ihre Anhänger mit einem breiten Spektrum verschiedener Kräfte, oft im Tausch gegen Opfergaben.
]]
end

if e["august_celestials"] then
    e["august_celestials"].title = "Die Erhabenen"
    e["august_celestials"].aliases = { "August Celestials" }
    e["august_celestials"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["ancients"] then
    e["ancients"].title = "Urtume"
    e["ancients"].aliases = { "Ancients" }
    e["ancients"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["demigods"] then
    e["demigods"].title = "Halbgötter"
    e["demigods"].aliases = { "Demigods" }
    e["demigods"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["dryads"] then
    e["dryads"].title = "Dryaden und Hüter des Hains"
    e["dryads"].aliases = { "Dryads and Keepers of the Grove", "Keepers of the Grove" }
    e["dryads"].body = [[
Sowohl die Hüter des Hains als auch die Dryaden stammen vom Halbgott Cenarius ab. Die Dryaden sind Töchter des Cenarius, die Hüter des Hains hingegen augenscheinlich Nachfahren von Cenarius' Söhnen Remulos und Zaetar.

Dryaden haben den Oberkörper weiblicher Nachtelfen und die Unterleiber von Faunen. Die Hüter scheinen eine Kombination aus einem mächtigen Hirsch und einem männlichen Nachtelf mit einem baumstammähnlichen Arm zu sein.

Beide Arten bevorzugen den Frieden, doch wenn nötig, schrecken sie nicht vor Gewalt zurück. Die Dryaden sind neugierig, aber nur wenige von ihnen verlassen jemals den Wald. Die Hüter des Hains werden einerseits für ihre Fähigkeiten als Heiler verehrt, andererseits jedoch für ihre naturbasierte Magie gefürchtet.
]]
end

if e["wildkin"] then
    e["wildkin"].title = "Wildekin"
    e["wildkin"].aliases = { "Wildkin" }
    e["wildkin"].body = [[
Die Wildekin sind gelassene und mächtige Geschöpfe, von denen die Nachtelfen glauben, sie seien von der Mondgöttin Elune geschaffen worden. Sie erinnern an eine Kreuzung aus einem Bären und einer gehörnten Eule, was sowohl ihre Weisheit als auch ihre Grausamkeit erklärt.

Wildekin sind schon lange Verbündete der Nachtelfen und unterstützen sie dabei, ihre heiligen Orte zu schützen. Auch wenn sie eher nachdenkliche Geschöpfe sind, hegen die Wildekin einen besonders starken Groll gegen die Brennende Legion und die Geißel, denn sie erkennen die Gefahr, die von beiden ausgeht. Obwohl die Wildekin anderen Bewohnern Azeroths gegenüber nicht von Natur aus feindlich gesinnt sind, wurden doch einige verdorben oder auf andere Weise zur Aggression getrieben und fallen nun Reisende und sogar ihre Verbündeten, die Nachtelfen, an.
]]
end

if e["scourge"] then
    e["scourge"].title = "Die Geißel"
    e["scourge"].aliases = { "The Scourge" }
    e["scourge"].body = [[
Ursprünglich von der Brennenden Legion erschaffen, hat sich die untote Armee der Geißel seither aus der Kontrolle der Dämonen befreit. Beherrscht vom Lichkönig ist sie eine gewaltige Armee wandelnder Leichen, Gespenster und verdammter Wesen.

Ihre Machtbasis liegt in Nordend, und ihre schreckliche zerstörerische Kraft ist noch immer in den Pestländern zu sehen, wo Land und Menschen noch immer unter dem fortwirkenden Fluch des Untodes leiden.
]]
end

if e["lich_king"] then
    e["lich_king"].title = "Der Lichkönig als Amt"
    e["lich_king"].aliases = { "The Lich King" }
    e["lich_king"].body = [[
Die Entität, die auf dem Frostthron auf der Eiskronenzitadelle sitzt, kontrolliert die gesamte Armee der Geißel.

Mit unvergleichlicher psychischer Stärke sowie Herrschaft über die Toten und das gefrorene Klima bedeutet schon, ihm nahe zu kommen, eine garantierte Todesstrafe.
]]
end

if e["banshees"] then
    e["banshees"].title = "Banshees"
    e["banshees"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["valkyr"] then
    e["valkyr"].title = "Val'kyr"
    e["valkyr"].aliases = { "Valkyrion" }
    e["valkyr"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["qiraji"] then
    e["qiraji"].title = "Qiraji"
    e["qiraji"].body = [[
Die Qiraji herrschten einst über ein Reich, das sich über ganz Silithus im Südwesten Kalimdors erstreckte.

Vor Hunderten von Jahren führten diese aggressiven und intelligenten Insektoiden einen brutalen Krieg gegen die Nachtelfen. Mit Unterstützung des Bronzenen Drachenschwarms wurden sie schließlich in ihre einstige Stadt Ahn'Qiraj zurückgedrängt und eingeschlossen, was die von ihnen ausgehende Bedrohung über Jahrhunderte hinweg bannte.

Jahre später regten sich die Qiraji unter dem Einfluss des Alten Gottes C'Thun erneut hinter den Mauern von Ahn'Qiraj.
]]
end

if e["nerubians"] then
    e["nerubians"].title = "Neruber"
    e["nerubians"].aliases = { "Nerubians" }
    e["nerubians"].body = [[
Die Neruber sind ein uraltes Volk hochintelligenter spinnenartiger Wesen, deren bekannte Siedlungsgebiete sich auf das einst mächtige unterirdische Königreich Azjol-Nerub konzentrierten. Sie sind von Natur aus grausam und greifen andere Spezies meist an, sobald sie sie sehen — es sei denn, eine mögliche Kooperation birgt für sie Vorteile.

Jede der verschiedenen Unterarten der Neruber hat einzigartige körperliche Merkmale und nimmt einen bestimmten Platz in der nerubischen Gesellschaft ein.

Obwohl sich ihr Reich einst über einen Großteil von Nordend erstreckte, hat der lange, zermürbende Krieg gegen die Geißel die einstigen Eroberer auf einen Bruchteil ihrer früheren Macht reduziert. Trotz allem stellen einzelne Gruppen nerubischer Krieger noch immer eine Gefahr dar.
]]
end

if e["silithid"] then
    e["silithid"].title = "Silithiden"
    e["silithid"].aliases = { "Silithid" }
    e["silithid"].body = [[
Die Silithiden sind eine insektoide Spezies, die man vor allem in Kalimdor findet. Anders als die Qiraji sind die Silithiden zwar keine intelligente Rasse, bleiben aber dennoch gefährliche Gegner.

Die Schwärme der Silithiden bestehen aus verschiedenen Arten. Jede Art hat eine einzigartige Körperform, die von kleinen Wespen bis zu riesigen Kolossen reicht, und innerhalb des Stocks eine bestimmte Funktion inne.

Die riesigen unterirdischen Stöcke bestehen vornehmlich aus weitreichenden Tunneln, die sowohl als Wohnstätte als auch als Schutz für ihre empfindlichen Eier und Larven dienen. Obwohl nicht alle Silithiden von Natur aus feindlich sind, verteidigen sie ihre Stöcke mit äußerster Entschlossenheit.
]]
end

-- ============ FACTIONS ============

if e["alliance"] then
    e["alliance"].title = "Die Allianz"
    e["alliance"].aliases = { "Alliance" }
    e["alliance"].body = [[
Eine politische Koalition, die aus der Allianz von Lordaeron hervorgegangen ist. Menschen, Zwerge, Gnome und Nachtelfen bilden die Kernvölker, die nach dem Dritten Krieg ihre Bildung forderten, alle durch Ideale von Glauben, Ehre und Gerechtigkeit miteinander verbunden.

Die Allianz befindet sich traditionell im Krieg mit der Horde, obwohl es in ihren Reihen viele gibt, die Frieden suchen.
]]
end

if e["horde"] then
    e["horde"].title = "Die Horde"
    e["horde"].aliases = { "The Horde" }
    e["horde"].body = [[
Unter Kriegshäuptling Thrall begann die orcische Horde ein neues Kapitel und wurde eine stolze und ehrenhafte neue Fraktion, in der ausgestoßene und verzweifelte Völker sich zu einem eng verbundenen Bündnis zusammenschlossen.

Als eine der zwei großen politischen Mächte Azeroths befindet sich die Horde häufig im Krieg mit ihrem Gegenstück, der Allianz.
]]
end

if e["alliance_of_lordaeron"] then
    e["alliance_of_lordaeron"].title = "Allianz von Lordaeron"
    e["alliance_of_lordaeron"].aliases = { "Alliance of Lordaeron" }
    e["alliance_of_lordaeron"].body = [[
Eine Koalition der sieben Menschenkönigreiche, der Zwerge und Gnome der Östlichen Königreiche sowie der Hochelfen von Quel'Thalas. Sie wurde als Antwort auf die Invasion der orcischen Horde zu Beginn des Zweiten Krieges gebildet.

Unter König Terenas Menethil II. besiegte die Allianz die Horde, zerfiel aber in den folgenden Jahren, als viele Nationen die Koalition verließen und als Lordaeron schließlich an die Geißel fiel.
]]
end

if e["old_horde"] then
    e["old_horde"].title = "Die Alte Horde"
    e["old_horde"].aliases = { "Old Horde" }
    e["old_horde"].body = [[
Getrieben von einem dämonischen Fluch kam die orcische Horde von Draenor nach Azeroth, um zu töten und zu erobern. Sie zerstörte die Königreiche Sturmwind und Alterac und wurde nur von der Allianz von Lordaeron aufgehalten.

Die Alte Horde starb auf Azeroth einen langsamen Tod, nachdem sie den Zweiten Krieg verloren hatte. Die überlebenden Orcs verkümmerten in Internierungslagern oder gingen auf einem zerschmetterten Draenor verloren.
]]
end

if e["burning_legion"] then
    e["burning_legion"].title = "Brennende Legion"
    e["burning_legion"].aliases = { "Burning Legion" }
    e["burning_legion"].body = [[
Geführt vom dunklen Titanen Sargeras ist die Brennende Legion eine nahezu endlose unsterbliche Armee von Dämonen, deren einziges Ziel es ist, alles Leben im Kosmos auszulöschen.

Sie hat in der Vergangenheit fast jeden Planeten erobert, den sie ins Visier nahm, sei es durch langsame Manipulation oder durch schiere überwältigende Gewalt. Azeroth hat bereits mehr als einmal widerstanden, doch eines Tages wird die Legion sicher zurückkehren, um sie erneut für sich zu beanspruchen.
]]
end

if e["shadow_council"] then
    e["shadow_council"].title = "Schattenrat"
    e["shadow_council"].aliases = { "Shadow Council" }
    e["shadow_council"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["cult_of_the_damned"] then
    e["cult_of_the_damned"].title = "Kult der Verdammten"
    e["cult_of_the_damned"].aliases = { "Cult of the Damned" }
    e["cult_of_the_damned"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["twilights_hammer"] then
    e["twilights_hammer"].title = "Schattenhammerkult"
    e["twilights_hammer"].aliases = { "Twilight's Hammer Cult" }
    e["twilights_hammer"].body = [[
Diese nihilistische Sekte verehrt die Alten Götter mit dem Ziel, die Stunde des Zwielichts herbeizuführen.

Der Kult wurde ursprünglich auf Draenor vom Oger Cho'gall gegründet, ist aber auf Azeroth zu einer noch größeren Bedrohung geworden.
]]
end

if e["hour_of_twilight"] then
    e["hour_of_twilight"].title = "Stunde des Zwielichts"
    e["hour_of_twilight"].aliases = { "Hour of Twilight" }
    e["hour_of_twilight"].body = [[
Eine alte Prophezeiung spricht vom Tag, an dem die Alten Götter nach Azeroth zurückkehren und das Ende der Welt herbeiführen werden. Die Stunde des Zwielichts markiert Azeroths letzte Momente der Existenz, bevor die Leere alles Leben auf ihr verschlingt.

Der Schattenhammerkult versucht, dieses Schicksal herbeizuführen.
]]
end

if e["kirin_tor"] then
    e["kirin_tor"].title = "Kirin Tor"
    e["kirin_tor"].body = [[
Der Zaubererrat der Magokratie von Dalaran ist eine Elitegruppe der mächtigsten sterblichen Magier der Welt. Ursprünglich Mitglieder eines der sieben Menschenkönigreiche beherbergen die Kirin Tor auch mehrere elfische Magier.

An der Seite der anderen Nationen nutzen sie ihre zerstörerische arkane Magie, um jede Bedrohung für ihre Welt zu bekämpfen. In Friedenszeiten widmen sie ihre Zeit, mehr über die verschiedenen Formen zu lernen, die Magie annehmen kann, und haben Dalaran zu einer der größten Universitäten Azeroths gemacht.
]]
end

if e["order_of_the_silver_hand"] then
    e["order_of_the_silver_hand"].title = "Orden der Silbernen Hand"
    e["order_of_the_silver_hand"].aliases = { "Order of the Silver Hand", "Knights of the Silver Hand" }
    e["order_of_the_silver_hand"].body = [[
Der erste Paladinorden, vom Erzbischof der Kirche Alonsus Faol erschaffen. Diese edlen lichtführenden Ritter waren die Antwort der Allianz von Lordaeron auf die Zerstörung durch die orcische Horde.

Ohne die Silberne Hand wäre der Zweite Krieg vielleicht nicht von der Allianz gewonnen worden.
]]
end

if e["argent_dawn"] then
    e["argent_dawn"].title = "Argentumdämmerung"
    e["argent_dawn"].aliases = { "Argent Dawn" }
    e["argent_dawn"].body = [[
Eine neutrale Fraktion ohne Bedürfnis nach politischer Macht, erschaffen, um das Böse in ganz Azeroth zu bekämpfen, vor allem in den Pestländern von Lordaeron.

Ihre Mitglieder stammen sowohl von der Horde als auch von der Allianz, und die meisten von ihnen sind Paladine oder Priester, doch jeder Anhänger des Lichts ist willkommen. Sie haben einen strikten Moralkodex und streben immer danach, rational zu handeln.
]]
end

if e["brotherhood_of_the_light"] then
    e["brotherhood_of_the_light"].title = "Bruderschaft des Lichts"
    e["brotherhood_of_the_light"].aliases = { "Brotherhood of the Light" }
    e["brotherhood_of_the_light"].body = [[
Ein Unterabschnitt der Argentumdämmerung, dessen Mitglieder zwar dieselben Überzeugungen teilen wie ihre Waffenbrüder, aber radikale Methoden anwenden, um das Böse auszulöschen.

Wären da nicht ihr Mangel an Vorurteilen und Fanatismus, wären sie vom Scharlachroten Kreuzzug nicht zu unterscheiden.
]]
end

if e["cenarion_circle"] then
    e["cenarion_circle"].title = "Zirkel des Cenarius"
    e["cenarion_circle"].aliases = { "Cenarion Circle" }
    e["cenarion_circle"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["earthen_ring"] then
    e["earthen_ring"].title = "Irdener Ring"
    e["earthen_ring"].aliases = { "Earthen Ring" }
    e["earthen_ring"].body = [[
Ob Horde oder Allianz, die Schamanen des Irdenen Rings legen ihre Differenzen beiseite und arbeiten zusammen zum Wohle der Welt, in der sie alle leben.

Sie finden sich vor allem dort, wo die Erde Heilung braucht und wo die Elemente in Aufruhr sind.
]]
end

if e["scarlet_crusade"] then
    e["scarlet_crusade"].title = "Scharlachroter Kreuzzug"
    e["scarlet_crusade"].aliases = { "Scarlet Crusade" }
    e["scarlet_crusade"].body = [[
Nach dem Dritten Krieg entwickelte sich aus dem Orden der Silbernen Hand eine fanatische Sekte. Sie glaubte, dass das Licht von ihnen forderte, alle Untoten auszulöschen, ob hirnlose Geißel oder bewusste Verlassene.

Der Scharlachrote Kreuzzug bekämpft all jene, die sie für Blasphemiker halten, und hegt sogar Argwohn gegen Nichtmenschen im Allgemeinen.
]]
end

if e["explorers_league"] then
    e["explorers_league"].title = "Forscherliga"
    e["explorers_league"].aliases = { "Explorers' League" }
    e["explorers_league"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["si7"] then
    e["si7"].title = "SI:7"
    e["si7"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["royal_apothecary_society"] then
    e["royal_apothecary_society"].title = "Königliche Apothekervereinigung"
    e["royal_apothecary_society"].aliases = { "Royal Apothecary Society" }
    e["royal_apothecary_society"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["elder_council"] then
    e["elder_council"].title = "Ältestenrat"
    e["elder_council"].aliases = { "Elder Council" }
    e["elder_council"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["kaldorei_empire"] then
    e["kaldorei_empire"].title = "Kaldorei-Imperium"
    e["kaldorei_empire"].aliases = { "Kaldorei Empire" }
    e["kaldorei_empire"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["arathor_empire"] then
    e["arathor_empire"].title = "Arathor-Imperium"
    e["arathor_empire"].aliases = { "Arathor Empire" }
    e["arathor_empire"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["seven_kingdoms"] then
    e["seven_kingdoms"].title = "Die Sieben Königreiche"
    e["seven_kingdoms"].aliases = { "Seven Kingdoms" }
    e["seven_kingdoms"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["empire_of_zul"] then
    e["empire_of_zul"].title = "Imperium von Zul"
    e["empire_of_zul"].aliases = { "Empire of Zul" }
    e["empire_of_zul"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["shadowmoon_clan"] then
    e["shadowmoon_clan"].title = "Schattenmond"
    e["shadowmoon_clan"].aliases = { "Shadowmoon Clan" }
    e["shadowmoon_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["frostwolf_clan"] then
    e["frostwolf_clan"].title = "Frostwolf"
    e["frostwolf_clan"].aliases = { "Frostwolf Clan" }
    e["frostwolf_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["warsong_clan"] then
    e["warsong_clan"].title = "Kriegshymnen"
    e["warsong_clan"].aliases = { "Warsong Clan" }
    e["warsong_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["blackrock_clan"] then
    e["blackrock_clan"].title = "Schwarzfels"
    e["blackrock_clan"].aliases = { "Blackrock Clan" }
    e["blackrock_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["bleeding_hollow_clan"] then
    e["bleeding_hollow_clan"].title = "Blutaugen"
    e["bleeding_hollow_clan"].aliases = { "Bleeding Hollow Clan" }
    e["bleeding_hollow_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["burning_blade_clan"] then
    e["burning_blade_clan"].title = "Brennende Klinge"
    e["burning_blade_clan"].aliases = { "Burning Blade Clan" }
    e["burning_blade_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["dragonmaw_clan"] then
    e["dragonmaw_clan"].title = "Drachenmal"
    e["dragonmaw_clan"].aliases = { "Dragonmaw Clan" }
    e["dragonmaw_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["shattered_hand_clan"] then
    e["shattered_hand_clan"].title = "Zerschmetterte Hand"
    e["shattered_hand_clan"].aliases = { "Shattered Hand Clan" }
    e["shattered_hand_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["grimtotem_clan"] then
    e["grimtotem_clan"].title = "Grimmtotem"
    e["grimtotem_clan"].aliases = { "Grimtotem Clan" }
    e["grimtotem_clan"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["black_empire"] then
    e["black_empire"].title = "Schwarzes Imperium"
    e["black_empire"].aliases = { "Black Empire" }
    e["black_empire"].body = [[
Als die Alten Götter nach Azeroth kamen, betteten sie sich in das Land selbst ein, wie tentakelbewehrte verderbende Parasiten. Sie unterwarfen die Elementarlords und bauten Zivilisationen lebender Wesen aus ihrem eigenen Fleisch. Sie überschwemmten die Welt mit ihren Armeen aus Gesichtslosen und Insektoiden.

Es war eine der dunkelsten Epochen für Azeroth, und die Welt wurde beinahe von der Leere verdorben.
]]
end

-- ============ ARTIFACTS ============

if e["ashbringer"] then
    e["ashbringer"].title = "Aschenbringer"
    e["ashbringer"].aliases = { "Ashbringer" }
    e["ashbringer"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["frostmourne"] then
    e["frostmourne"].title = "Frostgram"
    e["frostmourne"].aliases = { "Frostmourne" }
    e["frostmourne"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["doomhammer"] then
    e["doomhammer"].title = "Schicksalshammer"
    e["doomhammer"].aliases = { "Doomhammer" }
    e["doomhammer"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["gorehowl"] then
    e["gorehowl"].title = "Blutschrei"
    e["gorehowl"].aliases = { "Gorehowl" }
    e["gorehowl"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["atiesh"] then
    e["atiesh"].title = "Atiesh"
    e["atiesh"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["sulfuras"] then
    e["sulfuras"].title = "Sulfuras"
    e["sulfuras"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["dragon_soul"] then
    e["dragon_soul"].title = "Drachenseele / Dämonenseele"
    e["dragon_soul"].aliases = { "Dragon Soul", "Demon Soul" }
    e["dragon_soul"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["skull_of_guldan"] then
    e["skull_of_guldan"].title = "Schädel des Gul'dan"
    e["skull_of_guldan"].aliases = { "Skull of Gul'dan" }
    e["skull_of_guldan"].body = [[
Gul'dans Schädel war eine Quelle unvorstellbarer Macht. Wer ihn in seinem Besitz hatte, dem flüsterte ein Fragment von Gul'dans Seele Dinge zu.

Ner'zhul benutzte den Schädel, um das Portal zu öffnen, das Draenor zerstörte. Der menschliche Magier Khadgar setzte ihn ein, um das Dunkle Portal zu vernichten. Und schließlich verwandelte der Schädel den Nachtelfen Illidan Sturmgrimm in einen Dämon.
]]
end

if e["eye_of_sargeras"] then
    e["eye_of_sargeras"].title = "Auge des Sargeras"
    e["eye_of_sargeras"].aliases = { "Eye of Sargeras" }
    e["eye_of_sargeras"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["book_of_medivh"] then
    e["book_of_medivh"].title = "Buch des Medivh"
    e["book_of_medivh"].aliases = { "Book of Medivh" }
    e["book_of_medivh"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["horn_of_cenarius"] then
    e["horn_of_cenarius"].title = "Horn des Cenarius"
    e["horn_of_cenarius"].aliases = { "Horn of Cenarius" }
    e["horn_of_cenarius"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["discs_of_norgannon"] then
    e["discs_of_norgannon"].title = "Scheiben von Norgannon"
    e["discs_of_norgannon"].aliases = { "Discs of Norgannon" }
    e["discs_of_norgannon"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

-- ============ CONCEPTS ============

if e["curse_of_flesh"] then
    e["curse_of_flesh"].title = "Fluch des Fleisches"
    e["curse_of_flesh"].aliases = { "Curse of Flesh" }
    e["curse_of_flesh"].body = [[
Vom Alten Gott Yogg-Saron gepflanzt, um die künstlichen Schöpfungen der Titanen zu verderben. Der Fluch verbreitete sich durch die titanengeschmiedeten Völker und verwandelte sie in Wesen aus Fleisch und Blut.

Das bedeutete, dass diese neuen Völker unabhängig von den Befehlen ihrer Titanenmeister wurden und deren Griff auf Azeroth stark schwächten. Die Gnome, Zwerge, Troggs und Vrykul waren einige dieser neuen Völker.
]]
end

if e["warchief"] then
    e["warchief"].title = "Kriegshäuptling"
    e["warchief"].aliases = { "Warchief" }
    e["warchief"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["dragon_queen"] then
    e["dragon_queen"].title = "Drachenkönigin"
    e["dragon_queen"].aliases = { "Dragon Queen" }
    e["dragon_queen"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["keepers"] then
    e["keepers"].title = "Hochhüter und Hüter als Institution"
    e["keepers"].aliases = { "Keepers" }
    e["keepers"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["makgora"] then
    e["makgora"].title = "Mak'Gora"
    e["makgora"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["technology"] then
    e["technology"].title = "Technologie"
    e["technology"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end

if e["ancestor_loa_worship"] then
    e["ancestor_loa_worship"].title = "Ahnen-/Loa-Verehrung"
    e["ancestor_loa_worship"].aliases = { "Ancestor and Loa Worship" }
    e["ancestor_loa_worship"].body = [[
Eintrag in Erstellung — kommt bald.
]]
end


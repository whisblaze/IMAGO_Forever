-- ============================================================
-- IMAGO Forever — locales/<locale>/data/zones.lua
-- Localized zone texts. Empty by design — entries go here:
-- IMAGOdb.zones[uiMapID].name / .lore / .aliases / .pointsOfInterest
-- ============================================================

if GetLocale() ~= "deDE" then return end

IMAGOdb = IMAGOdb or {}
IMAGOdb.zones = IMAGOdb.zones or {}

IMAGOdb.zones[1455].name = "Eisenschmiede"
IMAGOdb.zones[1455].aliases = { "Ironforge" }
IMAGOdb.zones[1455].lore = [[In den Berg selbst gehauen, ist Eisenschmiede ein gewaltiges Zeugnis zwergischer Handwerkskunst. Die Weite der Höhlen lässt die Stadt nie eng wirken, und doch liegt eine gemütliche Wärme über ihr, während die Zwerge ihr Leben mit ausgelassenem Gelächter und deftigem Bier verbringen.

Es ist eine stolze Stadt, die noch nie einem Feind gefallen ist, obwohl es viele versucht haben. Von den Dämonen der Brennenden Legion bis zu den Dunkeleisenzwergen — keiner vermochte ihre robusten Mauern zu durchbrechen!

Doch es gehen Gerüchte um, dass die Dunkeleisenzwerge nicht aufgegeben haben, dass sie sich durch den Berg selbst gegraben und in das vergessene Alt-Eisenschmiede tief unten in der Halle der Thane eingedrungen sind. Vielleicht sollte man dem nachgehen.]]
IMAGOdb.zones[1455].pointsOfInterest = {
    {
        name = "Tüftlerstadt",
        lore = [[Nachdem sie aus ihrer eigenen Stadt vertrieben worden waren, wurde den Gnomen von Gnomeregan dieses Viertel Eisenschmiedes als Heimat gegeben. Es beherbergt den Eingang zur Tiefenbahn, einer der größten Leistungen gnomischer Ingenieurskunst, die Eisenschmiede mit Sturmwind verbindet. Ignoriert die Goblin-Gerüchte, die Bahn sei ein Mythos. Sie ist hier! Kommt und seht sie euch an!]]
    },
    {
        name = "Die Große Schmiede",
        lore = [[Ein bedeutendes Wahrzeichen der Stadt: Diese Schmiede liegt im Zentrum, umringt von Schmieden und Händlern aller Art. Reisende sollten in der Schmiede vorsichtig sein. Zwerge wissen, wie man festen Tritts bleibt, und können so mühelos um die fließenden Lavaströme herum arbeiten, doch für alle, die nicht auf ihre Schritte achten, kann es gefährlich werden.]]
    },
    {
        name = "Der Hohe Sitz",
        lore = [[Wo einst der Rat der Drei tagte, steht nun nur noch einer — der Bronzebart-Klan. Hier am Hohen Sitz können Mitglieder der Allianz Audienz bei Magni Bronzebart, dem Anführer der Zwerge, erhalten. Hier befindet sich auch der Zugang zu den Hallen der Thane. Einst versperrt, hat Eisenschmiede den Weg in die Tiefenstadt geöffnet, nur um sicherzugehen, dass niemand von hinten eindringen kann.]]
    },
}

IMAGOdb.zones[1426].name = "Dun Morogh"
IMAGOdb.zones[1426].aliases = { "Dun'morogh" }
IMAGOdb.zones[1426].lore = [[Im Herzen der Region Khaz Modan, umringt von hohen Bergen, liegt Dun Morogh, die Heimat der Zwerge und Gnome der Allianz. Das Land ist erfüllt von rauen Schneewinden und felsigen Berghügeln, die reiche Erzadern im Boden darunter verbergen. In die Berge selbst gehauen liegt die große Stadt Eisenschmiede, die Zwerge und Gnome ihr Zuhause nennen.

Wo einst Schneeleoparden und Wölfe durch die Wälder streiften und Bären ihre Höhlen hatten, sind nun Troggs und Trolle eingeschlichen und versuchen, das Land zu übernehmen. Die wackeren Allianzmitglieder lassen das jedoch nicht zu und halten die Eindringlinge ständig in Schach und ihre Heimat sicher.]]
IMAGOdb.zones[1426].pointsOfInterest = {
    {
        name = "Kaltroostal",
        lore = [[In einem abgeschiedenen Tal in der südlichen Ecke von Dun Morogh bauen und arbeiten zwergische Schmiede in der Enklave Ambossar. Trolle und Troggs haben jedoch ebenfalls den Weg hinein gefunden und führen ständige Angriffe auf die Bewohner der Gegend. Hier werden junge Zwerge und Gnome auf der Suche nach Abenteuern zum ersten Mal geprüft. Welcher bessere Beginn einer Reise, als das eigene Zuhause zu verteidigen?]]
    },
    {
        name = "Bernruh-Hof",
        lore = [[Eingebettet am Fuße der schneebedeckten Hügel von Dun Morogh, zwischen Kharanos und den Passen nach Loch Modan, hat dieser Hof einen besonderen Platz in der zwergischen Gesellschaft. Hier werden die großen Widder gezüchtet und gezähmt, die die Zwerge so schätzen. Mit handgefertigten Sätteln und strengem Training arbeitet die Familie Bernruh hart daran, ihrem Volk wackere Reittiere zu stellen.]]
    },
    {
        name = "Stahlgrills Depot",
        lore = [[Auch wenn es nur eine kleine Siedlung außerhalb der größeren Stadt Kharanos ist, heißt das nicht, dass im Depot weniger Betrieb herrscht. Es ist bis zum Rand gefüllt mit Minenarbeitern und Ingenieuren. Hier entwickeln die Gnome ihre Roboschreiter-Reittiere, wundersame Maschinen, die mühelos neben jedem Widder Eisenschmiedes oder Streitross Sturmwinds bestehen. Hier werden die Pläne geschmiedet, die Stadt Gnomeregan zurückzuerobern…]]
    },
}

IMAGOdb.zones[1420].name = "Tirisfal"
IMAGOdb.zones[1420].aliases = { "Tirisfal Glades" }
IMAGOdb.zones[1420].lore = [[Noch vor zwanzig Jahren schlug das mächtige Königreich Lordaeron die orcische Horde in diesem sagenumwobenen Land zurück, das nach dem großen Titanenhüter Tyr benannt ist, der selbst vor Äonen ein uraltes Übel vernichtete. Es gab wenige Nationen wie Lordaeron, den unangefochtenen Anführer der Allianz, und das Volk blühte unter der Herrschaft von König Terenas II. auf. Dann wurde das Land von der Geißel verwüstet, von seinem eigenen Kronprinzen verraten, und das einst so schöne Land erlag dem Tod.

Der düstere, ewig kränkelnde Himmel erinnert jeden Tag an das Verlorene. Flora und Fauna klammern sich verzweifelt an den geplagten Boden, doch die Bürger Lordaerons haben sich am meisten verändert. Die Untoten durchstreifen dieses verlassene Königreich, und die wenigen, die den Rest ihres Verstands zurückerlangt haben, haben sich der Bansheekönigin angeschlossen, um einen Neuanfang zu wagen. Von der Allianz für das verstoßen, was sie geworden sind, sind die Verlassenen nun Teil der Horde. Unter neuem Banner und neuer Führung werden Lordaerons gefallene Soldaten die Ruinen ihres neuen alten Zuhauses verteidigen.]]
IMAGOdb.zones[1420].pointsOfInterest = {
    {
        name = "Das Scharlachrote Kloster",
        lore = [[Die Kirche des Heiligen Lichts war mächtig hier, als dieses Königreich noch lebte, und die Untoten sind ein Frevel gegen diese Heiligkeit. So jedenfalls glaubt es der Scharlachrote Kreuzzug, und seine Priester und Paladine machen keinen Unterschied zwischen Verlassenen und Geißel. Geführt von Hochinquisitorin Weißsträhne und Kommandant Mograine, markiert die Kathedrale die Festung des Ordens und stellt die größte Bedrohung für die Verlassenen dar.]]
    },
    {
        name = "Burg Bandarion",
        lore = [[Einst ein militärischer Außenposten der Argentumdämmerung, fiel die Burg kürzlich an Tyrs Wacht und wurde zu Ehren des ersten Paladins der Verlassenen umbenannt: Garek Bandarion. Neue untote Paladine trainieren und meditieren hier und finden sich mit ihrer paradoxen Existenz ab. Die Argentumdämmerung ist hier weiterhin willkommen und sieht, anders als der Scharlachrote Kreuzzug, die Verlassenen als das, was sie sind: Menschen, die zu überleben versuchen.]]
    },
    {
        name = "Brill",
        lore = [[Zwischen den Massengräbern von Todesend und den verfluchten Agamand-Mühlen liegt ein friedliches Städtchen. Friedlich jedenfalls nach den Maßstäben der Verlassenen. Es ist nun ein Rastplatz für Abenteurer in diesen Gefilden und befestigt genug, um die Scharlachroten abzuwehren — und doch begann in gewisser Weise hier das Verhängnis des Landes. Der Nekromant Kel'Thuzad begann hier seine Experimente mit der Seuche des Untodes und markierte damit den Anfang der Geißel Lordaerons.]]
    },
}

IMAGOdb.zones[1429].name = "Wald von Elwynn"
IMAGOdb.zones[1429].aliases = { "Elwynn", "Elwynnwald" }
IMAGOdb.zones[1429].lore = [[Erfüllt von saftigen Ackerflächen, klaren Seen und reichen Minen ist der Wald von Elwynn das Bild von Behaglichkeit und Gelassenheit. Kein Wunder, dass es eine so blühende Landschaft ist. Er liegt direkt südlich der Brennenden Steppe, deren vulkanische Asche die nahen Böden fruchtbar macht. So fruchtbar und schön ist das Land, dass die Menschen Sturmwinds es besiedelten und ihre Zivilisation hier gedieh. Während des Ersten Krieges belagerten Orks Elwynn, schändeten Dörfer und zerstörten alles, was sie konnten. Es sollte nicht genug sein. Das Land ist erblüht, und die Menschen haben ihre Siedlungen schöner denn je wiederaufgebaut.

Die menschliche Hauptstadt Sturmwind liegt nordwestlich des Waldes, Elwynn ist daher gut bewacht. Reisende finden oft Soldaten, die die Straßen patrouillieren, und von Rittern beschützte Städte. Auch gut so, denn nicht alles ist friedlich in diesen Wäldern. Während die wilden Eber, Bären und Wölfe ihre eigenen Probleme bereiten, ist die wachsende Bedrohung durch die Defias-Bruderschaft die wahre Gefahr. Ziviler Unfriede hat manche Bürger von ihren friedlichen Höfen und Holzfällerlagerstätten abgebracht. Banditen verstecken sich zwischen den Bäumen, und auch wenn die Marshals ihr Bestes tun, die Kontrolle zu behalten, suchen sie stets nach weiteren Rekruten.]]
IMAGOdb.zones[1429].pointsOfInterest = {
    {
        name = "Turm von Azora",
        lore = [[Ein seltsamer Turm im Zentrum des Waldes von Elwynn. Er beherbergt viele Gnome, die sich Diener Azoras nennen und alle dem menschlichen Erzmagier Theocritus unterstehen. Auch wenn junge Verzauberer hier Unterricht finden können, scheint der Turm vor allem den Rivalen Turm von Ilgalar im Rotkammgebirge zu beobachten. Die Diener Azoras bespähen Morganth, den Anführer von Ilgalar, auf magischem Wege. Es bleibt ein Rätsel, warum der Turm von Azora so sehr auf den Turm von Ilgalar fixiert ist und den Rest von Elwynn seine eigenen Probleme lösen lässt.]]
    },
    {
        name = "Abtei von Nordhain",
        lore = [[Diese Abtei war einst die Heimat der Kleriker von Nordhain, die später den Rittern der Silbernen Hand beitraten. Die Abtei bewahrte viele seltene Folianten und Librams, die die Kleriker mit aller Kraft zu schützen suchten. Während des Ersten Krieges wurde sie von den Orks bei ihrer Invasion Elwynns zerstört, doch wie der Rest des Waldes wurde auch sie stärker wiederaufgebaut. Nun dient sie als Anwerbungsstätte für alle neugierigen Abenteurer. Ihre Bibliothek ist weiterhin das Ziel von Defias-Dieben, und so braucht die Abtei Verteidiger. Wer wäre dafür besser geeignet als junge Menschen, die sich beweisen wollen?]]
    },
    {
        name = "Holzfällerlager des Osttals",
        lore = [[Ein wichtiger Holzexporteur des Königreichs Sturmwind: Dieses Lager liegt an der östlichsten Seite Elwynns und grenzt ans Rotkammgebirge. Das hier gefällte Holz trägt viele der Unternehmungen des Königreichs. Das Osttal ist jedoch nicht nur ein einfaches Holzfällerlager. Es ist auch die Heimat der Zähmer der großen Streitrösser Sturmwinds. Diese Pferde dienen den großen Soldaten der Allianz. Nur wer sich gegenüber Sturmwind bewiesen hat, darf bei den Trainern des Osttals lernen.]]
    },
}

IMAGOdb.zones[1438].name = "Teldrassil"
IMAGOdb.zones[1438].lore = [[Nach der Vernichtung des Weltenbaums Hyjal durch die zweite Invasion der Brennenden Legion brauchte Azeroth einen neuen Weltenbaum — so jedenfalls dachten die Nachtelfen. Geführt von Erzdruide Fandral Hirschhaupt pflanzten die Druiden einen neuen Samen knapp vor der Küste des nördlichen Kalimdors. Er wuchs zum mächtigen „Krone der Erde", Teldrassil, und wurde zur Heimat aller Nachtelfen in ihrer neuen Hauptstadt Darnassus.

Er sollte Hyjal ersetzen, den Elfen ihre Unsterblichkeit zurückgeben — und doch, so schnell er wuchs, so schnell fiel er der Verderbnis anheim. Dieser große Baum ist nun ein Zeichen der Arroganz der Nachtelfen, die ihr ewiges Leben so bald zurückforderten, nachdem sie es aufgegeben hatten. Obwohl er in Schatten gefallen ist, nennen die Nachtelfen ihn noch immer ihre Heimat und tun, was sie können, um ihn zu schützen.

Die heimischen Geschöpfe wie Furbolgs, Grells und sogar die Pflanzen selbst wurden verderbt. Es ist die Pflicht der Elfen, sie in Schach zu halten, sie auszudünnen und zu stutzen, wo immer es nötig ist, um Teldrassil zu schützen und die Dunkelheit fernzuhalten.]]
IMAGOdb.zones[1438].pointsOfInterest = {
    {
        name = "Laubschattental",
        lore = [[Umgeben von hohen Wurzeln und Bergen ist diese Lichtung die Heimat von Aldrassil — einem großen Baum, der aus Teldrassil selbst entsprießt. Viele junge Nachtelfen beginnen hier ihre Reise, während sie über die Verderbnis in ihrem Land und ihre Pflicht, sie fernzuhalten, unterrichtet werden.]]
    },
    {
        name = "Rut'theran",
        lore = [[An den äußersten Wurzeln Teldrassils liegt dieses kleine Fischerdorf. Es ist der einzige Landzugang der Nachtelfen zu ihrer Heimat und damit eine beachtliche Barriere für Feinde. Ein Portal steht stets offen für den Weg nach Darnassus, während nur eine einzige Schiffsroute Besucher aus Auberdine in der Dunkelküste bringt.]]
    },
    {
        name = "Grabhügel von Ban'ethil",
        lore = [[Einst ein heilige Ruhestätte, geschaffen für die schlafenden Druiden der Kralle, ist die Stätte nun von verderbten Furbolgs überrannt. Die Knarzklauen sind so tief vorgedrungen, dass es jeder allein reisende Nachtelf schwer haben wird, in diese einst geheiligten Bauten einzudringen.]]
    },
}

IMAGOdb.zones[1411].name = "Durotar"
IMAGOdb.zones[1411].lore = [[Trockener, roter Sand, zerrissen von tückischen Schluchten, scharfe Kakteen und Wasserlöcher voller Krokilisken — diese Wüste war kaum ein idealer Ort für eine neue Fraktion, sich niederzulassen. Doch Thrall führte sein Volk hierher, in dem Wissen, dass die raue Landschaft die Orks an ihre zerstörte Heimat Draenor erinnern und das Bedürfnis betonen würde, für ihre Taten im Ersten und Zweiten Krieg auf Azeroth zu sühnen. Das Land wurde nach Durotan benannt, Thralls Vater und ehemaligem Häuptling des Frostwolfklans.

Orks und Trolle nennen dieses Land nun ihre Heimat, doch auch Tauren, Verlassene und — jüngst — die Windformer sind willkommene Besucher. Trotz aller Rauheit liegt ein großes Gefühl von Einigkeit und Kameradschaft über diesem Land. Die meisten Mitglieder der neuen Horde wollen schlicht ein friedliches und ruhiges Leben führen — und in Durotar werden sie wohl kaum gestört.]]
IMAGOdb.zones[1411].pointsOfInterest = {
    {
        name = "Tal der Prüfungen",
        lore = [[Junge Orks und Trolle, die sich als wertvolle Mitglieder der Horde beweisen wollen, müssen mehrere Übergangsriten bestehen — und dieses Tal ist ihr Prüfungsgelände. Vom Ausdünnen der Eber und Skorpide bis zum Ausrotten niederer Dämonen des Klans der Brennenden Klinge hat jeder Abenteurer der Horde die Übung durchlaufen.]]
    },
    {
        name = "Echoinseln",
        lore = [[Die Dunkelspeere wurden im Dritten Krieg beinahe ausgelöscht, und die Echoinseln vor der Küste Durotars sollten ihre neue Heimat werden. Nachdem sie Seeriesen abgewehrt und die Inseln mit Zähnen und Klauen gegen Admiral Daelin Prachtmeer verteidigt hatten, verloren die Trolle sie schließlich an einen der ihren. Zalazane und seine untoten Sklaven herrschen nun über diesen Ort und haben die Dunkelspeere zur Flucht gezwungen.]]
    },
    {
        name = "Burg Tiragarde",
        lore = [[Was von Daelin Prachtmeers treuem Expeditionskorps übrig blieb, besetzt nun diese Festung mitten im Herzen des Feindeslandes. Diese Soldaten von Kul Tiras haben geschworen, den Kampf gegen die Horde fortzusetzen — aus Vergeltung für den Zweiten Krieg wie für den Tod Admirals Daelins. Jaina, Thralls menschliche Freundin und selbst eine Tochter von Kul Tiras, missbilligt, was hier geschieht, doch ihr Einfluss auf die Politik ihrer Heimat ist seit dem Dritten Krieg stark begrenzt — um es milde auszudrücken.]]
    },
}

IMAGOdb.zones[1412].name = "Mulgore"
IMAGOdb.zones[1412].lore = [[Von hohen Bergen an allen Seiten geschützt, sind Mulgores grasbewachsene Ebenen bis zum Rand erfüllt von Leben. Kodos, Weitschreiter und Präriewölfe leben zwischen den Tafelbergen in den Feldern darunter — das natürliche Wild der Gegend. Auch wenn es auf den ersten Blick friedlich wirkt, streiten verschiedene Zentauren-Clans und Tauren-Stämme darum, wem das Land rechtmäßig gehört. Den Tauren ist es gelungen, Fuß zu fassen und die große Stadt Donnerfels zu errichten, die über die Gegend wacht — doch ihre Feinde werden nicht aufhören zu versuchen, es zurückzuerobern.

Obwohl die Zentauren ihre größte Bedrohung sind, wurde Mulgore auch von einem anderen Volk heimgesucht — den Stachelebern. Von den Orks aus Durotar vertrieben, fanden diese „Ebermenschen" durch einen der wenigen Eingänge in die grasigen Lande hinein, der im Osten mit dem Brachland verbunden ist. Auch wenn es nur eine geringe Sorge ist, behalten die Tauren die Ebenen gewiss im Auge — und all jene, die es wagen, ihre heiligen Länder zu betreten.]]
IMAGOdb.zones[1412].pointsOfInterest = {
    {
        name = "Camp Narache",
        lore = [[Am südlichen Ende Mulgores liegt dieses Lager auf dem Rand der Roten Wolkenmesa. Es ist die Heimat des Falkenwind-Stamms, einer Familie, die ihre Mitglieder der Aufgabe gewidmet hat, junge Tauren in ihrer Ausbildung zu unterstützen und die Stacheleber-Population unter Kontrolle zu halten.]]
    },
    {
        name = "Himmelswächterplateau",
        lore = [[Einst bekannt als Steinkrallenpass, ein schlichter Pfad zwischen dem Steinkrallengebirge und Desolace, beherbergt das Himmelswächterplateau nun Ankerplätze für die neuesten Verbündeten der Horde — die Windformer der Himmelsgeborenen. Camp Gev'rek liegt auf dem Plateau und heißt alle willkommen, die mit den Winden reisen.]]
    },
    {
        name = "Dorf der Bluthufe",
        lore = [[Nach Cairne Bluthuf und seinem Stamm benannt, ist dieses Dorf eine der wenigen dauerhaften Siedlungen unten im Tal — anders als die übliche Tradition der Tauren, ihre Heime auf den oberen Ebenen der Tafelberge zu errichten. Hier werden Kodos aufgezogen und ausgebildet, um Reittiere für das Volk der Tauren zu werden. Baine Bluthuf, der Sohn des Häuptlings der Tauren, führt das Dorf, hält es am Laufen und schützt es vor den mannigfachen Gefahren, die Mulgore birgt.]]
    },
}

IMAGOdb.zones[1454].name = "Orgrimmar"
IMAGOdb.zones[1454].lore = [[Die rustikale Kriegerstadt und Hauptstadt der neuen Horde wurde in verhältnismäßig kurzer Zeit errichtet, nachdem Kriegshäuptling Thrall sich im Gefolge des Dritten Krieges in Durotar niedergelassen hatte. Orgrimmar ist gut befestigt, mit hohen Türmen und schweren Toren, und auf natürliche Weise durch das Gebirge geschützt, in das sie gebaut wurde. Ursprünglich wollte Thrall die Stadt so friedlich wie möglich gestalten, ohne auch nur an militärische Verteidigung zu denken. Daelin Prachtmeers Angriff auf die halbfertige Siedlung und ihre Bewohner änderte seine Meinung jedoch rasch.

Auch wenn die Horde also tatsächlich eine Militärmacht bleiben musste, heißt das nicht, dass in Orgrimmar nur Soldaten leben. Zeppeline verbinden die Stadt mit den anderen Siedlungen der Horde, und sie ist rasch zum Handelszentrum aller Völker der Horde geworden. Trotz ihrer einschüchternden Fassade hat sich Orgrimmar als weitaus gastfreundlicher erwiesen, als viele erwartet hätten.]]
IMAGOdb.zones[1454].pointsOfInterest = {
    {
        name = "Grommash-Feste",
        lore = [[Die imposante Feste im Herzen der Stadt ist der Ort, an dem der Kriegshäuptling Hof hält und Urteile spricht. Sie ist nicht mit Reichtümern oder Tand geschmückt, sondern in rauem, schlichtem Stil erbaut. Vor dem Eintritt werden Besucher von einem Denkmal an den endgültigen Triumph der Orks über ihre dämonische Verderbnis begrüßt: Schädel und Rüstung des Grubenlords Mannoroth, prominent für alle sichtbar vor der Feste aufgestellt.]]
    },
    {
        name = "Kluft der Schatten",
        lore = [[Die dämonischen Praktiken der Hexenmeister waren ein wesentlicher Faktor für den Fall der Horde in die Verderbnis auf Draenor. Auch wenn Thrall den Einsatz von Teufelsmagie nicht verboten hat, ziehen es die verbliebenen Hexenmeister vor, in den Höhlen unter Orgrimmar zu leben — fernab neugieriger Blicke. Hier findet sich auch der Eingang zum Tunnelsystem des Flammenschlunds, und die Gerüchte über Aktivitäten der Brennenden Klinge, die darauf abzielen, Orgrimmar von innen zu zerstören, werden in letzter Zeit immer lauter.]]
    },
    {
        name = "Ring der Ehre",
        lore = [[Orgrimmars gladiatorische Arena scheint mit der typischen Philosophie der Horde im Sinn erbaut worden zu sein: ein Ort, an dem Krieger gegeneinander um Ruhm und zur Belustigung der Massen kämpfen. Doch das Kolosseum ist nicht für tägliche Schauspiele gedacht, sondern dient als Übungsplatz für neue Rekruten — und als Schlachtfeld der Wahl für ein Mak'gora, sollte eines ausgerufen werden.]]
    },
}

IMAGOdb.zones[1457].name = "Darnassus"
IMAGOdb.zones[1457].aliases = { "Darnassus City" }
IMAGOdb.zones[1457].lore = [[Auch wenn sie neu ist im Vergleich zu Sturmwind oder Eisenschmiede, macht Darnassus ihren Platz als Hauptstadt der Nachtelfen dadurch wett, ein vollkommenes Beispiel ihrer Lebensweise zu sein — und ein Symbol ihres fortwährenden Überlebens nach dem Dritten Krieg. Die meisten Gebäude sind direkt in die lebenden Bäume gebaut, gerade genug ausgehöhlt für Geschäfte und Handel, doch lebendig und weiter wachsend. Die Stadt liegt am Rand eines Sees, Brücken spannen über das Wasser wie Lianen, die alles zusammenhalten.

Doch ihr Leben im Frieden mit der Natur macht sie nicht wehrlos. Schildwachen der Nachtelfen patrouillieren ihre Straßen — Elitekriegerinnen, ausgebildet, um ihr Volk zu schützen. Und nicht nur das: Uralte Beschützer und Uralten des Krieges wandeln durch die Straßen und schlagen in der Stadt Wurzeln, als Wächter der Natur an der Seite ihrer nachtelfischen Verbündeten.]]
IMAGOdb.zones[1457].pointsOfInterest = {
    {
        name = "Tempelgärten",
        lore = [[Auch wenn viele Nachtelfen hierher wandern mögen, um Frieden zu finden und zwischen fließenden Wassern zu wandeln — für die meisten Besucher wird dies der erste Anblick Darnassus' sein. In friedlichen Zeiten zu allen Stunden offen gehalten, ruht hier ein Portal nach Rut'theran, das den einzigen Weg für bodengebundene Reisende schafft, die großen Äste Teldrassils zu verlassen.]]
    },
    {
        name = "Tempel des Mondes",
        lore = [[Anders als die meisten Gebäude Darnassus' wurde dieser Tempel aus Stein errichtet, der von außerhalb Teldrassils herbeigeschafft wurde, damit er die Zeit überdauert. Er ist das Hauptquartier der Schwesternschaft der Elune — Priesterinnen, die der Mondgöttin Elune geweiht sind. Tyrande, die oberste Priesterin der Nachtelfen, ist hier zu finden und heißt jeden willkommen, der Elunes Führung sucht.]]
    },
    {
        name = "Enklave des Cenarius",
        lore = [[Wie der Tempel des Mondes die Heimat der Priesterinnen der Nachtelfen ist, so ist die Enklave des Cenarius die Heimat der druidischen Praktiken Darnassus'. Erzdruide Hirschhaupt steht hier und leitet sein Volk in seinen Pflichten. In der Enklave finden die Nachtelfen auch die gezähmten Nachtsäbler, die als Reittiere für jene dienen, die Darnassus wahre Treue bewiesen haben.]]
    },
}

IMAGOdb.zones[1458].name = "Unterstadt"
IMAGOdb.zones[1458].aliases = { "Undercity" }
IMAGOdb.zones[1458].lore = [[Vor dem Fall des menschlichen Königreichs Lordaeron lag dort die Unterstadt. Ihre Kammern dienten als Grüfte und Verliese für das Königreich darüber. Nachdem Arthas und die Geißel angriffen, wollte er die Katakomben zu seiner neuen Bastion für die Untoten machen, konnte dies jedoch nicht vollenden, bevor er nach Nordend aufbrach. Sylvanas Windläufer, befreit aus dem Griff des Lichkönigs, nahm ihre Verlassenen und eroberte sie für ihre eigenen Zwecke — und verwandelte die gewundenen Hallen in eine richtige Stadt für ihr Volk.

Auch wenn sie eine Festung der Horde ist, können Lebewesen wegen der giftigen Dämpfe und des toxischen Schlamms, der die Kavernen füllt, nur schwer durch die Gegend navigieren. Stattdessen ist sie der perfekte Zufluchtsort für die untoten Verlassenen — ihre dunklen, kalten Hallen bieten ihnen ein Heiligtum fern all jener, die die Untoten vernichtet sehen wollen.]]
IMAGOdb.zones[1458].pointsOfInterest = {
    {
        name = "Apothekarium",
        lore = [[Heimat der Königlichen Apothekervereinigung — in diesem Heiligtum entwickeln die Verlassenen ihre Seuchen und Gifte. Da die Verlassenen sich nicht fortpflanzen können, müssen sie sich stattdessen ihrer eigenen Seuche bedienen, um die Existenz ihres Volkes fortzusetzen. Hier wird aufgrund ihrer einzigartigen Körperstruktur auch die Medizin der Verlassenen erforscht.]]
    },
    {
        name = "Ruinen von Lordaeron",
        lore = [[Wo einst eine mächtige Hauptstadt stand, ist nur noch zerbrochener Stein und sind verlorene Geister übrig. Manche können noch immer die quälenden Schreie der Toten hören, die im Wind flüstern. Abenteurer, die hierher gelangen, finden vielleicht Reste der Geißel, die Arthas zurückließ. Auch wenn die Unterstadt bereits unter der Kontrolle der Horde steht — tötet diese Kreaturen besser, bevor sie zu viel Unheil anrichten.]]
    },
    {
        name = "Königsviertel",
        lore = [[Verborgen im hintersten Winkel der Unterstadt führt Sylvanas Windläufer von hier aus ihr Volk. Die Elite der königlichen Schreckenswachen hält jeden, der eintritt, unter Beobachtung. Es heißt, es gäbe geheime Gänge hier und in der gesamten Stadt — und nur die Bansheekönigin kennt sie in ihrem vollen Ausmaß.]]
    },
}

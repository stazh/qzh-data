# Quellen zur Zürcher Geschichte: Daten

## Repository
Dieses Repository beinhaltet die Quellenstücke für Projekt „Zürcher Rechtsquellen“. Die TEI-Publisher Webapplikation, mit der die Quellenstücke angezeigt werden, befindet sich hier: https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte

## Workflow zur Bearbeitung der Quellenstücke

Die Quellenstücke (TEI-XMLs) befinden sich im Verzeichnis `/quellenstuecke`. Quellenstücke, die in diesen Ordner abgelegt werden, werden durch die Webapplikation automatisch erfasst.

Mit einem GIT-Client können die Quellenstücke bearbeitet, gelöscht oder ergänzt werden. Eine Einführung in das Thema GIT befindet sich hier: [https://www.youtube.com/watch?v=dyY539HzN6Q][1] (Minute 0 bis Minute 39)

Minimale Anpassungen an den Quellenstücken können auch direkt über die GitLab Webseite vorgenommen werden:

![][image-1]

Für grössere Änderungen empfiehlt sich jedoch stark die Verwendung eines GIT-Clients (zum Beispiel Sourcetree oder GitHub Desktop).  

Eine konkrete Anleitung zum Anlegen eines Accounts bei GitLab und zum Verbinden mit dem GitLab Client (SourceTree, GitHub Desktop) befindet sich hier: [https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte/-/blob/master/documentation/Arbeiten\_mit\_TEI\_Publisher\_GIT\_Workflow/index.md][2]. Für die Pflege der Quellenstücke müssen nur die Schritte 3, 4, 5, 11 und 12 beachtet werden. Die restlichen Schritte werden nur dann benötigt, wenn man Änderungen am Quellcode der Webapplikation selbst vornehmen will. Für Änderungen an den Quellenstücken wird nicht zwingend eine lokale Installation der ExistDB benötigt. Eine lokale Installation der ExistDB hat jedoch den Vorteil, dass die Änderungen an den Quellenstücken auf dem lokalen ExistDB-Server getestet werden können.

## Hinweise für das Tagging der Quellenstücke

### Erfassen von Metadaten

Im Tag `seriesStmt` könnten Metadaten für das Quellenstück eingetragen werden. Hier ein Beispiel:

```swift
 <teiHeader>
  <fileDesc>
   <titleStmt>
    <respStmt>
     <persName>Andrea Schmid-Kunz</persName>
     <resp key="transcript"/>
    </respStmt>
    <respStmt>
     <persName>Michael Schaffner</persName>
     <resp key="tagging"/>
    </respStmt>
   </titleStmt>
   <publicationStmt>
    <date type="electronic" when="2021-05-01"/>
    <date type="print" when="2018-12-31"/>
   </publicationStmt>
   <seriesStmt xml:id="ssrq-sds-fds">
    <title>Gelebte Reformation. Zürich 1500-1800</title>
    <link>https://www.zh.ch/de/direktion-der-justiz-und-des-innern/staatsarchiv.html</link>
    <respStmt>
     <persName>Francisca Loetz. Unter Mitarbeit von Wolfram Schneider-Lastin</persName>
     <resp>Herausgeberschaft</resp>
    </respStmt>
    <idno>QZH_022</idno>
   </seriesStmt>

	...

  </fileDesc>
 </teiHeader>
```

Diese Informationen werden im TEI-Publisher verwendet, um die Metadaten zum Quellenstück darzustellen:

![][image-2]

Es ist zu beachten, dass der angegebene Text für den Tag `<idno>` mit dem Dateinamen der XML-Datei übereinstimmen muss. Die Datei `quellenstücke/QZH_022.xml` hat also den Tag `<idno>QZH_022</idno>`

Die Angabe eines Links unterhalb des Titels ist optional. Wird ein Link angegeben, so muss dieser mit `https://` oder mit `http://` beginnen.

Innerhalb der Metadaten gibt es einen Tag `<msIdentifier>` mit einem verschachtelten Tag `idno`. Der eingetragene Wert im Attribut „source“ beinhaltet die Institution, die für das Quellenstück verantwortlich ist. Im folgenden Beispiel ist dies die Institution „StAZH“. 

```swift
     <msIdentifier>
      <idno source="https://suche.staatsarchiv.djiktzh.ch/detail.aspx?ID=4903814">StAZH A 61.5, Nr. 28</idno>
     </msIdentifier>
```

Anhand dieser Angabe wird in der TEI-Publisher Webapplikation die Liste der Filtermöglichkeiten automatisch generiert:

![][image-3]

### Erfassen und Anzeigen von Personen

Es sind drei Varianten vorgesehen, um Personen in den Quellenstücken zu kennzeichnen:

#### Variante 1: Ohne Identifier
```xml
<persName>Heinrich Bullinger</persName>
```

Dies ist die einfachste Variante, um eine Person auszuzeichnen. Im Gegensatz zum Rechtsquellenportal ist es nicht zwingend notwendig, dass jeder Person im Quellenstück eine eindeutige Referenz zugeordnet wird. Somit entfällt der Aufwand, bei jeder Person zu prüfen, ob diese bereits in anderen Quellenstücken erwähnt wurde und ob es sich bei identischen Namen tatsächlich auch um dieselbe Person handelt.

In der Personenübersicht werden Personen, die auf diese Art ausgezeichnet worden sind, als einzelne Einträge dargestellt. So ist es wahrscheinlich, dass in der Liste mehrmals der gleiche Name erscheint (da nicht ausgeschlossen werden kann, dass es sich bei mehreren Erwähnungen des gleichen Namens in einem Quellenstück oder mehreren Quellenstücken um die gleiche Person handelt).

Zusätzlich werden für diese Personen ohne Identifier in der Personenübersicht der Name des Quellenstücks sowie das Jahr des Quellenstücks angeben:

![][image-4]

Auf diese Weise können sich die Besucherinnen und Besucher der Webseite selbst einen Eindruck davon machen, ob es sich bei mehreren Namenseinträgen um die gleiche Person handelt.

Bei der Jahresangabe sollte beachtet werden, dass sich diese auf das Quellenstück bezieht und somit nicht das Geburtsjahr der erwähnten Person darstellt. Das angezeigte Jahr dient zur ungefähren zeitlichen Einordnung. Wo vorhanden, wird das Jahr angezeigt, in dem das Quellenstück verfasst wurde. Ist dieses Datum nicht in den Metadaten des Quellenstücks vorhanden, kann alternativ auch das Erstelldatum der Abschrift angezeigt werden. 

Innerhalb des Quellenstücks werden gekennzeichnete Personen farblich hervorgehoben:

![][image-5]

Wird kein eindeutiger Identifier angegeben, wird bei einem Klick auf den Personennamen im Quellenstück die Personensuche angezeigt und automatisch der erste Buchstabe der angeklickten Person ausgewählt:

![][image-6]

Auf diese Weise hat die Benutzerin oder der Benutzer die Möglichkeit, andere Vorkommen des gleichen Namens zu finden.


#### Variante 2: Mit eindeutigem Identifier

Alternativ können Personen mit einem eindeutigen Identifier gekennzeichnet werden. Auf diese Weise kann bei Personen, welche mehrfach in einem Quellenstück oder in mehreren Quellenstücken auftauchen, gekennzeichnet werden, dass es sich jeweils um die gleiche Person handelt.

```xml
<persName ref="per012634">Heinrich Bullinger</persName>
```

Es kann sein, dass die gleiche Person in verschiedenen Quellenstücken mit unterschiedlichen Schreibweisen erfasst wurde. In diesem Fall werden in der Webapplikation alle verwendeten Namen für die gleiche Person mit Komma getrennt dargestellt. Zudem wird ein Personensymbol angezeigt:

![][image-7]

Dank dem eindeutigen Identifier wird in der Detailansicht für die Person zudem eine Liste mit „Erwähnungen“ in verschiedenen Quellenstücken angezeigt: 

![][image-8]


Wird innerhalb eines Quellenstücks auf den Namen einer Person geklickt, so öffnet sich die Detailansicht für diese Person. Im Gegensatz zur Variante 1 gelangt man nicht zur Personensuche, da Personen mit einem eindeutigen Identifier automatisch gruppiert werden und es somit für die entsprechende Person ohnehin nur einen einzigen Eintrag in der Personensuche gäbe.

Personen mit Identifier erscheinen zudem in der Registeransicht eines einzelnen Quellenstücks:

![][image-9]




#### Variante 3: Mit einem GND-Identifier

Bekannte Personen können auch mit einem GND Identifier getaggt werden. Es handelt sich dabei um einen bestimmten Identifier, der auch von der Deutschen Nationalbibliothek verwendet wird. 

```xml
<persName ref="GND_118517384">Heinrich Bullinger</persName>
```

Hier ist zum Beispiel der Eintrag für Heinrich Bullinger mit der GND/NID „118517384“: [https://portal.dnb.de/opac.htm?method=simpleSearch&cqlMode=true&query=nid%3D118517384][3]

In den Quellenstücken wird jeweils vor die GND/NID das Prefix „GND\_“ gestellt.

Durch das Tagging mit einer GND/NID hat man alle Vorteile der Variante 2 (gruppierte Darstellung von mehreren Personen und Schreibweisen sowie Auflistung der „Erwähnungen“ in den Quellenstücken).

Zusätzlich wird bei dieser Variante in der Detailansicht für eine Person ein Link in die GND-Datenbank angezeigt:

![][image-10]

#### Weitere Personennamen erfassen, welche nicht in den Quellenstücken vorkommen

Es kann vorkommen, dass es weitere Schreibweisen für Personennamem gibt, ohne dass diese Schreibweise in einem Quellenstück erwähnt ist. In diesen Fall können zusätzliche Personennamen in die Datei `person/person-additions.xml` eingetragen werden. Hinweis: Ein Eintrag in diese Datei macht nur für Personen Sinn, die bereits unter einer anderen Schreibweise in einem oder mehreren Quellenstücken vorhanden sind und über einen Identifier verfügen.

Änderungen an dieser Datei werden nicht direkt auf der Webapplikation sichtbar. Zuerst muss dazu erneut die Übersicht mit allen Personen generiert werden (dort fliessen dann die Änderungen mitein - siehe Folgekapitel)

#### Übersicht mit allen Personen generieren

Siehe Kapitel unterhalb: „Vor der Veröffentlichung von neuen Versionen: Übersicht der Personen und Orte generieren“

### Erfassen und Anzeigen von Orten

Es sind drei Varianten vorgesehen, um Orte in den Quellenstücken zu kennzeichnen:

#### Variante 1: Ohne Identifier
```xml
<placeName>Zürich</placeName>
```

Dies ist die einfachste Variante, um einen Ort auszuzeichnen. Im Gegensatz zum Rechtsquellenportal ist es nicht zwingend notwendig, dass jedem Ort im Quellenstück eine eindeutige Referenz zugeordnet wird. Somit entfällt der Aufwand, bei jedem Ort zu prüfen, ob dieser bereits in anderen Quellenstücken erwähnt wurde und ob es sich bei identischen Namen tatsächlich auch um denselben Ort handelt.

In der Ortsübersicht werden Orte, welche auf diese Weise ausgezeichnet worden sind, als einzelne Einträge dargestellt. So ist es wahrscheinlich, dass in der Liste mehrmals der gleiche Name erscheint (da nicht ausgeschlossen werden kann, dass es sich bei mehreren Erwähnungen des gleichen Namens in einem Quellenstück oder mehreren Quellenstücken um den gleichen Ort handelt):

![][image-11]

Auf diese Weise können sich die Besucherinnen und Besucher der Webseite selbst einen Eindruck davon machen, ob es sich bei mehreren Einträgen um den gleichen Ort handelt.

Innerhalb des Quellenstücks werden gekennzeichnete Orte farblich hervorgehoben:

![][image-12]

Wird kein eindeutiger Identifier angegeben, wird bei einem Klick auf den Ortsnamen in der Weboberfläche die Ortssuche angezeigt und automatisch der erste Buchstabe des angeklickten Ortes ausgewählt:

![][image-13]

Auf diese Weise hat die Benutzerin oder der Benutzer die Möglichkeit, andere Vorkommen des gleichen Namens zu finden.



#### Variante 2: Mit eindeutigem Identifier

Alternativ können Orte mit einem eindeutigen Identifier gekennzeichnet werden. Auf diese Weise kann bei Orten, welche mehrfach in einem Quellenstück oder in mehreren Quellenstücken auftauchen, gekennzeichnet werden, dass es sich jeweils um den gleichen Ort handelt.

```xml
<placeName ref="loc000065">Zürich</placeName>
```

Es kann sein, dass der gleiche Ort in verschiedenen Quellenstücken mit unterschiedlichen Schreibweisen erfasst wurde. In diesem Fall werden in der Webapplikation alle verwendeten Namen für den gleichen Ort mit Komma getrennt dargestellt:

![][image-14]

Dank dem eindeutigen Identifier wird in der Detailansicht für den Ort zudem eine Liste mit „Erwähnungen“ in verschiedenen Quellenstücken angezeigt:

![][image-15]

Wird innerhalb eines Quellenstücks auf den Namen eines Ortes geklickt, so öffnet sich die Detailansicht für diesen Ort. Im Gegensatz zur Variante 1 gelangt man nicht zur Ortssuche, da Orte mit einem eindeutigen Identifier automatisch gruppiert werden und es somit für die entsprechenden Orte ohnehin nur einen einzigen Eintrag in der Ortssuche gäbe.

Orte mit Identifier erscheinen in der Registeransicht eines einzelnen Quellenstücks:

![][image-16]


#### Variante 3: Mit einem Koordinaten-Identifier

Orte können auch mit einem Koordinaten-Identifier getaggt werden. Dabei werden die beiden Koordinaten-Komponenten „Latitude“ und „Longitude“ im folgenden Format encodiert:

```xml
<placeName ref="LOC_47.37721420014591_8.527299029687203">Zürich<placeName>
```

Damit das Tool erkennt, dass es sich um eine Koordinate handelt, wird das Previx „LOC\_“ verwendet. Die beiden Koordinatenbestandteile sind mit einem Unterstrich (`_`) voneinander getrennt.

Durch das Tagging mit einer Koordinate hat man alle Vorteile der Variante 2 (gruppierte Darstellung von mehreren Orten und Schreibweisen sowie Auflistung der „Erwähnungen“ in den Quellenstücken).

Zusätzlich wird bei dieser Variante in der Detailansicht für den Ort eine Karte angezeigt:

![][image-17]

Ausserdem erscheint in der Suche für Orte mit einer Koordinate ein Kartensymbol:

![][image-18]


#### Übersicht mit allen Orten generieren

Siehe Kapitel unterhalb: „Vor der Veröffentlichung von neuen Versionen: Übersicht der Personen und Orte generieren“




### Erfassen und Anzeigen von Schlagworten

Schlagworte werden innerhalb der TEI-XML’s referenziert:

```xml
<!-- Auszug -->
<teiHeader>
	<!-- ... -->
	<profileDesc>
		<textClass default="false">
			<keywords scheme="http://www.ssrq-sds-fds.ch/taxonomie">
				<term ref="key000325">Fremde</term>
				<term ref="key000334">Gefängnis</term>
				<term ref="key000670">Konfession</term>
				<term ref="key005339">Konversion</term>
				<term ref="key005473">Nachgang</term>
				<term ref="key003408">Taufe</term>
			</keywords>
		</textClass>
	</profileDesc>
</teiHeader>
```

Die Definitionen werden zentral in der Datei `taxonomy/taxonomy.xml` abgelegt. Im Gegensatz zu `person/person.xml` und `place/place.xml` muss `taxonomy/taxonomy.xml` manuell gepflegt werden.

So sieht ein beispielhafter Eintrag im `taxonomy/taxonomy.xml` aus: 

```xml
<!-- auszug -->
<category xml:id="key000325">
	<desc xml:lang="deu">Fremder</desc>
	<gloss>Person, die nicht dem eigenen Rechtskreis angehört und bei verminderter Rechtsfähigkeit Beschränkungen im Alltag und Erwerbsleben erfährt
	</gloss>
</category>
```

Diese Definitionen sind dafür verantwortlich, auf der Webapplikation die Übersicht mit den Stichworten anzuzeigen:

![][image-19]

Ausserdem wird pro Quellenstück am rechten Bildschirmrand eine Liste mit Definitionen zum aktuellen Quellenstück angezeigt:

![][image-20] 

## Vor der Veröffentlichung von neuen Versionen: Übersicht der Personen und Orte generieren

### Zentrale XML Dateien für Personen, Orte und Schlagworte

Die Webapplikation zeigt neben den Quellenstücken auch ein Register mit Orten, Personen und Schlagwörtern an.

![][image-21]

Alle drei Register basieren jeweils auf einer .xml-Datei, welche die entsprechenden Registerdaten enthält: `person/person.xml`, `place/place.xml`, `taxonomy/taxanomy.xml`. 

Vor der Veröffentlichung einer neuen Version der Webapplikation (genauer gesagt vor der Veröffentlichung von neuen Quellenstücken) müssen diese Dateien aktualisiert werden. 

### Taxanomy.xml

Die Datei `taxanomy/taxanomy.xml` enthält Stichworte und Definitionen und muss manuell gepflegt werden. Details sind im Kapitel oberhalb (Hinweise für das Tagging der Quellenstücke) beschrieben.

### Person.xml

Die Datei `person/person.xml` enthält die benötigten Informationen für das Personenregister.

![][image-22]

Die Datei kann automatisch aus den Quellenstücken generiert werden. Manuelle Korrekturen an der Datei sind zwar möglich, sind jedoch nicht empfohlen, da die Gefahr besteht, dass manuell eingetragene Änderungen beim nächsten Mal wieder gelöscht werden, sobald die Datei erneut automatisch generiert wird.

So sieht ein beispielhafter, generierter Personeneintrag aus:

```xml
<person xml:id="GND_118517384">
	<persName type="full">Heinrich Bullinger, Bullingers, Bullinger
	</persName>
</person>
```

Bei Personen, die in den Quellenstücken keine explizite Referenz zugewiesen haben, wird automatisch ein Identifier generiert, der sich aus dem Quellenstück und der Stelle im Quellenstück zusammensetzt. Ausserdem wird automatisch die Quelle und das Datum der Quelle eingetragen. Diese Informationen werden ebenfalls im Register angezeigt (siehe Screenshot).

```xml
<person xml:id="QZH_016_10">
	<persName type="full">Heinrich Buochman</persName>
	<source>QZH_016</source>
	<dateOfTheSource>1692</dateOfTheSource>
</person>
```

Hinweise zum Taggen von Personen in den Quellenstücken sind weiter oben beschrieben.

Um die Datei `person/person.xml` zu generieren, wird eine lokale Installation der eXist-DB benötigt. Im Dashboard der eXist-DB kann eXide geöffnet werden:

![][image-23]

Auf der linken Bildschirmseite wird die Datei-Hierarchie angezeigt. Hier navigiert man zum Skript, welches dafür zuständig ist, die Liste der Personen zu generieren:

```xml
/db/apps/qzh-data/script/generate-list-of-people.xml
```

![][image-24]

Nach einem Klick auf „Eval“ wird die generierte XML-Datein mit den Personen am unteren Bildschirmrand ausgegeben:

![][image-25]

Dieser ausgegebene Text sollte kopiert, und anschliessend in der Datei `person/person.xml` eingefügt werden:

![][image-26]

Achtung: Nicht vergessen, die Änderungen wieder auf GitLab zu pushen.

### Place.xml

Die Datei `place/place.xml` enthält die benötigten Informationen für das Ortsregister.

![][image-27]

Die Datei kann automatisch aus den Quellenstücken generiert werden. Manuelle Korrekturen an der Datei sind zwar möglich, sind jedoch nicht empfohlen, da die Gefahr besteht, dass manuell eingetragene Änderungen beim nächsten Mal wieder gelöscht werden, sobald die Datei erneut automatisch generiert wird.

So sieht ein beispielhafter, generierter Ortseintrag aus:

```xml
<place xml:id="loc000065" n="Zürich">
	<placeName type="main">Zürich</placeName>
</place>
```

Bei Orten, die in den Quellenstücken keine explizite Referenz zugewiesen haben, wird automatisch ein Identifier generiert, der sich aus dem Quellenstück und der Stelle im Quellenstück zusammensetzt:

```xml
<place xml:id="QZH_016_33" n="Hirzel">
	<placeName type="main">Hirzel</placeName>
</place>
```

Bei Orten, die mit einem speziellen Koorindaten-Identifier gekennzeichnet sind, wird ausserdem die Koordinate in den Eintrag geschrieben:

```xml
<place xml:id="LOC_47.37721420014591_8.527299029687203" n="Zürich">
	<placeName type="main">Zürich</placeName>
	<location>
		<geo>47.37721420014591 8.527299029687203</geo>
	</location>
</place>
```

Hinweise zum Taggen von Orten in den Quellenstücken sind weiter oben beschrieben.

Um die Datei `place/place.xml` zu generieren, wird eine lokale Installation der eXist-DB benötigt. Im Dashboard der eXist-DB kann eXide geöffnet werden:

![][image-28]

Auf der linken Bildschirmseite wird die Datei-Hierarchie angezeigt. Hier navigiert man zum Skript, welches dafür zuständig ist, die Liste der Orten zu generieren:

```xml
/db/apps/qzh-data/script/generate-list-of-places.xml
```

![][image-29]

Nach einem Klick auf „Eval“ wird die generierte Liste mit den Orten am unteren Bildschirmrand ausgegeben:

![][image-30]

Dieser ausgegebene Text sollte kopiert, und anschliessend in der Datei `place/place.xml` eingefügt werden:

![][image-31]

Achtung: Nicht vergessen, die Änderungen wieder auf GitLab zu pushen.

## Anpassen der Bibliografie / des Literaturverzeichnisses

Der HTML-Code für das Literaturverzeichnis ist im Repository "code" mit dem Namen  `literaturverzeichnis.html` abgelegt. Die XML-Version des Literaturverzeichnisses wird nicht mehr benötigt.

[1]:	https://www.youtube.com/watch?v=dyY539HzN6Q
[2]:	https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte/-/blob/master/documentation/Arbeiten_mit_TEI_Publisher_GIT_Workflow/index.md
[3]:	https://portal.dnb.de/opac.htm?method=simpleSearch&cqlMode=true&query=nid%3D118517384

[image-1]:	documentation/bild1.png
[image-2]:	documentation/bild29.png
[image-3]:	documentation/bild30.png
[image-4]:	documentation/bild14.png
[image-5]:	documentation/bild18.png
[image-6]:	documentation/bild19.png
[image-7]:	documentation/bild15.png
[image-8]:	documentation/bild16.png
[image-9]:	documentation/bild27.png
[image-10]:	documentation/bild17.png
[image-11]:	documentation/bild20.png
[image-12]:	documentation/bild21.png
[image-13]:	documentation/bild22.png
[image-14]:	documentation/bild23.png
[image-15]:	documentation/bild24.png
[image-16]:	documentation/bild28.png
[image-17]:	documentation/bild25.png
[image-18]:	documentation/bild26.png
[image-19]:	documentation/bild3.png
[image-20]:	documentation/bild4.png
[image-21]:	documentation/bild2.png
[image-22]:	documentation/bild5.png
[image-23]:	documentation/bild6.png
[image-24]:	documentation/bild7.png
[image-25]:	documentation/bild8.png
[image-26]:	documentation/bild9.png
[image-27]:	documentation/bild10.png
[image-28]:	documentation/bild6.png
[image-29]:	documentation/bild11.png
[image-30]:	documentation/bild12.png
[image-31]:	documentation/bild13.png
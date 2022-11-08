# Quellen zur Zürcher Geschichte: Daten

## Repository
Dieses Repository beinhaltet die Quellenstücke für das folgende Repository: https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte

## Workflow zur Bearbeitung der Quellenstücke

Die Quellenstücke (TEI-XMLs) befinden sich im Verzeichnis `/quellenstuecke`. Quellenstücke, die in diesen Ordner abgelegt werden, werden durch die Webapplikation automatisch erfasst.

Mit einem GIT-Client können die Quellenstücke bearbeitet, gelöscht oder ergänzt werden. Eine Einführung in das Thema GIT befindet sich hier: [https://www.youtube.com/watch?v=dyY539HzN6Q][1] (Minute 0 bis Minute 39)

Minimale Anpassungen an den Quellenstücken können auch direkt auf der GitLab Webseite vorgenommen werden:

![][image-1]

Für grössere Änderungen empfiehlt sich die Verwendung eines GIT-Clients.  

Eine konkrete Anleitung zum Anlegen eines Accounts bei GitLab und zum Verbinden mit dem GitLab Client (SourceTree, GitHub Desktop) befindet sich unter der folgenden Anleitung: [https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte/-/blob/master/documentation/Arbeiten\_mit\_TEI\_Publisher\_GIT\_Workflow/index.md][2]. Für die Pflege der Quellenstücke müssen nur die Schritte 3, 4, 5, 11 und 12 beachtet werden. Die restlichen Schritte werden nur dann benötigt, wenn man auch Änderungen am Quellcode der Webapplikation selbst vornehmen will. Für Änderungen an den Quellenstücken wird nicht zwingend eine lokale Installation der ExistDB benötigt. Eine lokale Installation der ExistDB hat jedoch den Vorteil, dass die Änderungen an den Quellenstücken auf dem lokalen ExistDB-Server getestet werden können.

## Hinweise für das Tagging der Quellenstücke

### Erfassen und Anzeigen von Personen

Es sind drei Varianten vorgesehen, um Personen in den Quellenstücken zu kennzeichnen:

#### Variante 1: Ohne Identifier
```xml
<persName>Heinrich Bullinger</persName>
```

Dies ist die einfachste Variante, um eine Person auszuzeichnen. Im Gegensatz zum Rechtsquellenportal ist es nicht zwingend notwendig, dass jeder Person im Quellenstück eine eindeutige Referenz zugeordnet wird. Somit entfällt der Aufwand, bei jeder Person zu prüfen, ob diese bereits in anderen Quellenstücken erwähnt wurde und ob es sich bei identischen Namen tatsächlich auch um die selbe Person handelt.

In der Personenübersicht werden Personen, die auf diese Art ausgezeichnet worden sind, als einzelne Einträge dargestellt. So ist es wahrscheinlich, dass in der Liste mehrmals der gleiche Name erscheint (da nicht ausgeschlossen werden kann, dass es sich bei mehreren Erwähnungen des gleichen Namens in einem Quellenstück oder mehreren Quellenstücken um die gleiche Person handelt):

Zusätzlich werden bei diesen Personen in der Übersicht der Name des Quellenstücks sowie das Jahr des Quellenstücks angeben:

![][image-2]

Auf diese Weise können sich die Besucherinnen und Besucher der Webseite selbst einen Eindruck davon machen, ob es sich bei mehreren Namenseinträgen um die gleiche Person handelt.

Bei der Jahresangabe sollte beachtet werden, dass sich diese auf das Quellenstück bezieht und und nicht das Geburtsjahr der erwähnten Person darstellt. Das angezeigte Jahr dient somit zur ungefähren zeitlichen Einordnung. Wo vorhanden wird das Jahr angezeigt, in dem das Quellenstück verfasst wurde. Ist dieses Datum nicht in den Metadaten des Quellenstücks vorhanden kann alternativ auch das Erstelldatum der Abschrift angezeigt werden. 

Innerhalb der Quellenstücks werden gekennzeichnete Personen farblich hervorgehoben:

![][image-3]

Wird kein Eindeutiger Identifier angegeben, wird beim einem Klick auf den Personennamen auf der Weboberfläche die Personensuche angezeigt und automatisch der erste Buchstabe der angeklickten Person ausgewählt:

![][image-4]

Auf diese Weise hat die Benutzerin oder der Benutzer die Möglichkeit, andere Vorkommen des gleichen Namens zu finden.


#### Variante 2: Mit eindeutigem Identifier

Alternativ können Personen mit einem eindeutigen Identifier gekennzeichnet werden. Auf diese Weise kann bei Personen, welche mehrfach in einem Quellenstück oder in mehreren Quellenstücken auftauchen gekennzeichnet werden, dass es sich jeweils um die gleiche Person handelt.

```xml
<persName ref="per012634">Heinrich Bullinger</persName>
```

Es kann sein, dass die gleiche Person in verschiedenen Quellenstücken mit unterschiedlichen Schreibweisen erfasst wurde. In diesem Fall werden in der Webapplikation alle verwendeten Namen für die gleiche Person mit Komma getrennt dargestellt werden:

![][image-5]

Dank dem eindeutigen Identifier für die Person wird in der Detailansicht für die Person zudem eine Liste mit „Erwähnungen“ in verschiedenen Quellenstücken angezeigt. Ausserdem wird ein Personensymbol dargestellt:

![][image-6]

Wird innerhalb eines Quellenstücks auf den Namen einer Person geklickt, so öffnet sich die Detailansicht für diese Person. Im Gegensatz zur Variante 1 gelangt man nicht zur Personensuche, da Personen mit einem eindeutigen Identifier automatisch Gruppiert werden und es somit für die entsprechende Person ohnehin nur einen einzigen Eintrag in der Personensuche gäbe.

Personen mit Identifier erscheinen in der Registeransicht eines einzelnen Quellenstücks:

![][image-7]




#### Variante 3: Mit einem GND-Identifier

Bekannte Personen können auch mit einem GND Identifier getaggt werden. Es handelt sich dabei um bestimmte Identifier, die von der Deutschen Nationalbibliothek verwendet werden. 

```xml
<persName ref="GND_118517384">Heinrich Bullinger</persName>
```

Hier ist zum Beispiel der Eintrag für Heinrich Bullinger mit der GND/NID „118517384“: [https://portal.dnb.de/opac.htm?method=simpleSearch&cqlMode=true&query=nid%3D118517384][3]

Durch das Tagging mit einer GND/NID hat man alle Vorteile der Variante 2 (Gruppierte Darstellung von mehreren Personen und Schreibweise sowie Auflistung der „Erwähnungen“ in den Quellenstücken).

Zusätzlich wird bei dieser Variante in der Detailansicht für eine Person ein Link in die GND-Datenbank angezeigt:

![][image-8]


#### Übersicht mit allen Personen generieren

Siehe Kapitel unterhalb: „Vor der Veröffentlichung von neuen Versionen: Übersicht der Personen und Orte generieren“

### Erfassen und Anzeigen von Orten

Es sind drei Varianten vorgesehen, um Orte in den Quellenstücken zu kennzeichnen:

#### Variante 1: Ohne Identifier
```xml
<placeName>Zürich</placeName>
```

Dies ist die einfachste Variante, um einen Ort auszuzeichnen. Im Gegensatz zum Rechtsquellenportal ist es nicht zwingend notwendig, dass jedem Ort im Quellenstück eine eindeutige Referenz zugeordnet wird. Somit entfällt der Aufwand, bei jedem Ort zu prüfen, ob dieser bereits in anderen Quellenstücken erwähnt wurde und ob es sich bei identischen Namen tatsächlich auch um den selben Ort handelt.

In der Ortsübersicht werden Orte, die auf diese Art ausgezeichnet worden sind, als einzelne Einträge dargestellt. So ist es wahrscheinlich, dass in der Liste mehrmals der gleiche Name erscheint (da nicht ausgeschlossen werden kann, dass es sich bei mehreren Erwähnungen des gleichen Namens in einem Quellenstück oder mehreren Quellenstücken um den gleichen Ort handelt):

![][image-9]

Auf diese Weise können sich die Besucherinnen und Besucher der Webseite selbst einen Eindruck davon machen, ob es sich bei mehreren Einträgen um den gleichen Ort handelt.

Innerhalb der Quellenstücks werden gekennzeichnete Orte farblich hervorgehoben:

![][image-10]

Wird kein eindeutiger Identifier angegeben, wird beim einem Klick auf den Ortsnamen in der Weboberfläche die Ortssuche angezeigt und automatisch der erste Buchstabe des angeklickten Ortes ausgewählt:

![][image-11]

Auf diese Weise hat die Benutzerin oder der Benutzer die Möglichkeit, andere Vorkommen des gleichen Namens zu finden.



#### Variante 2: Mit eindeutigem Identifier

Alternativ können Orte mit einem eindeutigen Identifier gekennzeichnet werden. Auf diese Weise kann bei Orten, welche mehrfach in einem Quellenstück oder in mehreren Quellenstücken auftauchen gekennzeichnet werden, dass es sich jeweils um den gleichen Ort handelt.

```xml
<placeName ref="loc000065">Zürich</placeName>
```

Es kann sein, dass der gleiche Ort in verschiedenen Quellenstücken mit unterschiedlichen Schreibweisen erfasst wurde. In diesem Fall werden in der Webapplikation alle verwendeten Namen für den gleichen Ort mit Komma getrennt dargestellt werden:

![][image-12]

Dank dem eindeutigen Identifier für den Ort wird in der Detailansicht für den Ort zudem eine Liste mit „Erwähnungen“ in verschiedenen Quellenstücken angezeigt:

![][image-13]

Wird innerhalb eines Quellenstücks auf den Namen eines Ortes geklickt, so öffnet sich die Detailansicht für diesen Ort. Im Gegensatz zur Variante 1 gelangt man nicht zur Ortssuche, da Orte mit einem eindeutigen Identifier automatisch gruppiert werden und es somit für die entsprechenden Ort ohnehin nur einen einzigen Eintrag in der Ortssuche gäbe.

Orte mit Identifier erscheinen in der Registeransicht eines einzelnen Quellenstücks:

![][image-14]


#### Variante 3: Mit einem Koordinaten-Identifier

Orte können auch mit einem Koordinaten-Identifier getaggt werden. Dabei werden die beiden Koordinaten-Komponenten „Latitude“ und „Longitude“ im folgenden Format encodiert:

```xml
<placeName ref="LOC_47.37721420014591_8.527299029687203">Zürich<placeName>
```

Durch das Tagging mit einer Koordinate hat man alle Vorteile der Variante 2 (Gruppierte Darstellung von mehreren Orten und Schreibweisen sowie Auflistung der „Erwähnungen“ in den Quellenstücken).

Zusätzlich wird bei dieser Variante in der Detailansicht für einen Ort eine Karte angezeigt:

![][image-15]

Ausserdem erscheint in der Suche für entsprechende Orte ein Kartensymbol:

![][image-16]


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

So sieht ein Beispielhafter Eintrag im `taxonomy/taxonomy.xml` aus: 

```xml
<!-- auszug -->
<category xml:id="key000325">
	<desc xml:lang="deu">Fremder</desc>
	<gloss>Person, die nicht dem eigenen Rechtskreis angehört und bei verminderter Rechtsfähigkeit Beschränkungen im Alltag und Erwerbsleben erfährt
	</gloss>
</category>
```

Diese Definitionen sind dafür verantwortlich, auf der Webapplikation die Übersicht mit den Stichworten anzuzeigen:

![][image-17]

Ausserdem wird pro Quellenstück am rechten Bildschirmrand eine Liste mit Definitionen zum aktuellen Quellenstück angezeigt:

![][image-18] 

## Vor der Veröffentlichung von neuen Versionen: Übersicht der Personen und Orte generieren

### Zentrale XML Dateien für Personen, Orte und Schlagworte

Die Webapplikation zeigt neben den Quellenstücken auch ein Register mit Orten, Personen und Schlagwörtern an.

![][image-19]

Alle drei Register basieren auf eine .xml-Datei, welche die Entsprechenden Registerdaten enthält: `person/person.xml`, `place/place.xml`, `taxonomy/taxanomy.xml`. 

Vor der Veröffentlichung einer neuer Version der Webapplikation (bzw. vor der Veröffentlichung von neuen Quellenstücken) müssen diese Dateien aktualisiert werden. 

### Taxanomy.xml

Die Datei `taxanomy/taxanomy.xml` enthält Stichworte und Definitionen und muss manuell gepflegt werden. Details sind im Kapitel oberhalb (Hinweise für das Tagging der Quellenstücke) beschrieben.

### Person.xml

Die Datei `person/person.xml` enthält die benötigten Informationen für das Personenregister.

![][image-20]

Die Datei kann automatisch aus den Quellenstücken generiert werden. Manuelle Korrekturen an der Datei sind zwar möglich, sind jedoch nicht empfohlen, da die Gefahr besteht, dass manuell eingetragene Änderungen beim nächsten Mal wieder gelöscht werden, sobald die Datei wieder automatisch generiert wird.

So sieht ein Beispielhafter generierter Personeneintrag aus:

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

![][image-21]

Auf der linken Bildschirmseite wird die Datei-Hierarchie angezeigt. Hier navigiert man zum Skript, welches dafür zuständig ist, die Liste der Personen zu generieren:

```xml
/db/apps/qzh-data/script/generate-list-of-people.xml
```

![][image-22]

Nach einem Klick auf „Eval“ wird die generierte Liste mit den Personen am unteren Bildschirmrand ausgegeben:

![][image-23]

Dieser ausgegebene Text sollte kopiert, und anschliessend in der Datei `person/person.xml` eingefügt werden:

![][image-24]

Achtung: Nicht vergessen die Änderungen wider auf GitLab zu pushen.

### Place.xml

Die Datei `place/place.xml` enthält die benötigten Informationen für das Ortsregister.

![][image-25]

Die Datei kann automatisch aus den Quellenstücken generiert werden. Manuelle Korrekturen an der Datei sind zwar möglich, sind jedoch nicht empfohlen, da die Gefahr besteht, dass manuell eingetragene Änderungen beim nächsten Mal wieder gelöscht werden, sobald die Datei wieder automatisch generiert wird.

So sieht ein Beispielhafter generierter Ortseintrag aus:

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

Bei Orten, die mit einem speziellen Koorindaten-Identifier beschriftet sind, wird ausserdem die Koordinate in den Eintrag geschrieben:

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

![][image-26]

Auf der linken Bildschirmseite wird die Datei-Hierarchie angezeigt. Hier navigiert man zum Skript, welches dafür zuständig ist, die Liste der Personen zu generieren:

```xml
/db/apps/qzh-data/script/generate-list-of-places.xml
```

![][image-27]

Nach einem Klick auf „Eval“ wird die generierte Liste mit den Personen am unteren Bildschirmrand ausgegeben:

![][image-28]

Dieser ausgegebene Text sollte kopiert, und anschliessend in der Datei `place/place.xml` eingefügt werden:

![][image-29]

Achtung: Nicht vergessen die Änderungen wider auf GitLab zu pushen.

[1]:	https://www.youtube.com/watch?v=dyY539HzN6Q
[2]:	https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte/-/blob/master/documentation/Arbeiten_mit_TEI_Publisher_GIT_Workflow/index.md
[3]:	https://portal.dnb.de/opac.htm?method=simpleSearch&cqlMode=true&query=nid%3D118517384

[image-1]:	documentation/bild1.png
[image-2]:	documentation/bild14.png
[image-3]:	documentation/bild18.png
[image-4]:	documentation/bild19.png
[image-5]:	documentation/bild15.png
[image-6]:	documentation/bild16.png
[image-7]:	documentation/bild27.png
[image-8]:	documentation/bild17.png
[image-9]:	documentation/bild20.png
[image-10]:	documentation/bild21.png
[image-11]:	documentation/bild22.png
[image-12]:	documentation/bild23.png
[image-13]:	documentation/bild24.png
[image-14]:	documentation/bild28.png
[image-15]:	documentation/bild25.png
[image-16]:	documentation/bild26.png
[image-17]:	documentation/bild3.png
[image-18]:	documentation/bild4.png
[image-19]:	documentation/bild2.png
[image-20]:	documentation/bild5.png
[image-21]:	documentation/bild6.png
[image-22]:	documentation/bild7.png
[image-23]:	documentation/bild8.png
[image-24]:	documentation/bild9.png
[image-25]:	documentation/bild10.png
[image-26]:	documentation/bild6.png
[image-27]:	documentation/bild11.png
[image-28]:	documentation/bild12.png
[image-29]:	documentation/bild13.png
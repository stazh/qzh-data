# Quellen zur Zürcher Geschichte: Daten

## Repository
Dieses Repository beinhaltet die Quellenstücke für das folgende Repository: https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte

## Ablage der Quellenstücke

Quellenstücke (TEI-XMLs) können im Verzeichnis `/quellenstuecke` abgelegt werden und werden so von der Webapplikation automatisch erfasst.

## Personen, Organisationen, Orte

Das folgende Beispiel zeigt das Editieren eines Ortes. Das Editieren von Personen und Organisationen erfolgt nach dem gleichen Muster.

Eine Liste aller verfügbarer Orte befindet sich in der Datei `place/place.xml`. Dort sind die einzelnen Orte hinterlegt:

```xml
<place xml:id="loc010352" n="Aesch">
	<placeName type="main">Aesch</placeName>
	<placeName type="add">(CH-ZH) Dorf/village</placeName>
	<region>CH-ZH</region>
	<trait type="type">
		<label>Dorf/village</label>
	</trait>
	<location>
		<geo>47.33574928046599 8.439877630724677</geo>
	</location>
</place>
```

Eine weitere Datei (`qzh-places.txt`) enthält eine Liste mit allen Place-IDs und muss entsprechend bei Änderungen ebenfalls aktualisiert werden. Die Datei (und auch die Dateien für die Personen und die Organisationen) können mit dem folgenden Konsolenbefehlen automatisch erzeugt oder aktualisiert werden (siehe Datei `qzh-ids`):

```bash
egrep -hor '(key\d{6})' . | sort | uniq > qzh-keywords.txt;
egrep -hor '(lem\d{6})' . | sort | uniq > qzh-lem.txt;
egrep -hor '(per\d{6})' . | sort | uniq > qzh-persons.txt;
egrep -hor '(org\d{6})' . | sort | uniq > qzh-organisations.txt;
egrep -hor '(loc\d{6})' . | sort | uniq > qzh-places.txt;
```
 
Um alle Commands auf einmal auszuführen, können folgende Befehle auf der Konsole eingegeben werden (getestet nur auf dem Mac):

```bash
cd quellen-zur-zuercher-geschichte-daten #Pfad entsprechend anpassen
chmod +x qzh-ids #Skript ausführbar machen
./qzh-ids #Skript starten (dauert etwa 15 Sekunden)
```

Innerhalb der TEI-XML Dateien wird dann auf den ID des Ortes referenziert:

```json
<placeName ref="loc010352">Esch</placeName>
```

(Auf diese Weise können auch unterschiedliche Schreibweisen des gleichen Ortes gekennzeichnet werden)
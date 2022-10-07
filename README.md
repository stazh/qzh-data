# Quellen zur Zürcher Geschichte: Daten

## Repository
Dieses Repository beinhaltet die Quellenstücke für das folgende Repository: https://gitlab.com/quellen-zur-zuercher-geschichte/quellen-zur-zuercher-geschichte

## Ablage der Quellenstücke

Quellenstücke (TEI-XMLs) können im Verzeichnis `/quellenstuecke` abgelegt werden und werden so von der Webapplikation automatisch erfasst.

## Anzeigen Personen, Organisationen, Orte

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

## Anzeigen von Schlagworten


###  Über das taxonomy.xml-File
Schlagworte werden innerhalb der TEI-XML’s referenziert:

```xml
<keywords scheme="http://www.ssrq-sds-fds.ch/taxonomie">
	<term ref="key000325">Fremde</term>
	<term ref="key000334">Gefängnis</term>
	<term ref="key000670">Konfession</term>
	<term ref="key005339">Konversion</term>
</keywords>
```

In den Dateien `modules/qzh-*.xql` werden für die einzelnen Begriffe die Definitionen gemappt:

```XQuery
let $register := doc("/db/apps/qzh-data/taxonomy/taxonomy.xml")
let $entries:=
	for $p in root(.)//keywords//term[starts-with(@ref, "key")]        
	group by $k := $p/@ref
	return id($p[1]/@ref, $register)
return 
	for $p in $entries
		order by $p/desc ascending
		return $p,
```

Bei der Darstellung wird zudem noch ein Link auf die SSRQ-Seite gesetzt:

```XQuery
if ($target) then ( <a href="https://www.ssrq-sds-fds.ch/lemma-db-edit/views/view-keyword.xq?id={$id}" target="_blank">{$target/desc/string()}</a>
```

Die Definitionen werden aus dem Repository `qzh-data` gelesen: `taxonomy/taxonomy.xml`

```xml
<category xml:id="key000325">
	<desc xml:lang="deu">Fremder</desc>
	<gloss>Person, die nicht dem eigenen Rechtskreis angehört und bei verminderter Rechtsfähigkeit Beschränkungen im Alltag und Erwerbsleben erfährt
	</gloss>
</category>
```

###  Über die SSRQ-API

Im Code ist auch die Möglichkeit vorgesehen, die Definitionen der Schlagworte über die API abzufragen. Soweit ich gesehen habe, wird diese Funktionalität in der Webapplikation jedoch nicht (mehr?) aktiv genutzt.

Im `app.xql` gibt es dazu die folgende Funktion:

```XQuery
declare function app:list-keys($node as node(), $model as map(*)) {
    let $keywords := root($model?data)//tei:term[starts-with(@ref, 'key')]
    where exists($keywords)
    return map {
        "items":
            for $lemma in app:api-lookup-xml($app:KEYWORDS, app:api-keys($keywords/@ref), "id")//info
            order by $lemma/name
            return
                <li data-ref="{$lemma/@id}">
                    <paper-checkbox class="select-facet" title="i18n(highlight-facet)"></paper-checkbox>
                    <div>
                        <a href="https://www.ssrq-sds-fds.ch/lemma-db-edit/views/view-keyword.xq?id={$lemma/@id}"
                            target="_new">
                            {$lemma/name/string()}
                        </a>
                    </div>
                </li>
    }
};
```

Die aufgerufene API-Schnittstelle lautet: [https://www.ssrq-sds-fds.ch/lemma-db-edit/views/get-key-infos.xq]()


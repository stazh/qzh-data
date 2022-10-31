xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:remove-duplicates($items as item()*) 
as item()*
{
  for $i in $items
  let $id := $i//@xml:id
  let $identifier := $id || "-" || $i//text()
  group by $identifier
    return $i[1]
};

<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="persons" type="Person">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>Quellen zur Zürcher Geschichte: Personendaten</title>
            </titleStmt>
            <publicationStmt>
                <p>Publication Information</p>
            </publicationStmt>
            <sourceDesc>
                <p>Information about the source</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>
    <standOff>
        <listPerson>
    {

        let $all := 
            let $collection := collection("/db/apps/qzh-data/quellenstuecke/")
            for $quellenstueck in $collection
            for $p at $pos in $quellenstueck//tei:text//tei:persName
            let $personName := fn:normalize-space($p)
            let $id := if ($p//@ref) 
              then $p//@ref
              else $quellenstueck//seriesStmt/tei:idno || "_" || $pos

            order by $id
            return <person xml:id="{$id}">
                    <persName type="full">{$personName}</persName>
                </person>
                
        let $allWithoutDuplicates := local:remove-duplicates($all)
        let $allOrdered :=
          for $i in $allWithoutDuplicates
            order by $i//persName//text(), $i//@xml:id
            return $i
        
        return $allOrdered

    }

        </listPerson>
    </standOff>
</TEI>

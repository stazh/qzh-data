xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:remove-duplicates($items as item()*) 
as item()*
{
  for $i in $items
  let $id := $i//@xml:id
  let $placeName := $i//text()



  group by $id
    return <place xml:id="{$id}" n="{$placeName[1]}">
    {
        for $place in $i
        let $placeName := $place//text()
        group by $placeName
        return <placeName>{$place[1]//text()}</placeName>
    }
    
    </place>  
        
        
        
};

<TEI xmlns="http://www.tei-c.org/ns/1.0" xml:id="places" type="Ort">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>Quellen zur Zürcher Geschichte: Ortsdaten</title>
            </titleStmt>
            <publicationStmt>
                <p>Publication Information</p>
            </publicationStmt>
            <sourceDesc>
                <p>Information about the source</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>,
            <standOff>
        <listPlace>
    {

        let $all := 
            let $collection := collection("/db/apps/qzh-data/quellenstuecke/")
            for $quellenstueck in $collection
            for $p at $pos in $quellenstueck//tei:text//tei:placeName
            let $placeName := fn:normalize-space($p)
            let $id := if ($p//@ref) 
              then $p//@ref
              else $quellenstueck//seriesStmt/tei:idno || "_" || $pos

            order by $id
            return <place xml:id="{$id}">
                        <placeName type="main">{$placeName}</placeName>
                    </place>
                
        let $allWithoutDuplicates := local:remove-duplicates($all)
        let $allOrdered :=
          for $i in $allWithoutDuplicates
            order by $i//persName//text()
            return $i
        
        return $allOrdered

    }

        </listPlace>
    </standOff>
</TEI>

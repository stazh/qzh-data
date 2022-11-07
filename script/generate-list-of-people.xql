xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:extractDateFromSource($source as item())
as xs:string
{
    let $sourceTitle := $source//tei:seriesStmt/tei:idno/text()
    let $historyDateWhen := $source//tei:history//tei:origin//@when
    let $historyDateFrom := $source//tei:history//tei:origin//@from
    let $historyDateTo := $source//tei:history//tei:origin//@to
    let $filiationDateWhen := $source//tei:sourceDesc//tei:filiation//@when
    let $filiationDateFrom := $source//tei:sourceDesc//tei:filiation//@from
    let $filiationDateTo := $source//tei:sourceDesc//tei:filiation//@to

    let $firstDate := if (exists($filiationDateWhen)) 
        then string($filiationDateWhen)
        else 
            if (exists($filiationDateFrom)) 
            then string($filiationDateFrom)
            else 
                if (exists($historyDateWhen)) 
                then string($historyDateWhen)
                else
                    if (exists($historyDateFrom)) 
                    then string($historyDateFrom)
                    else ()

    let $secondDate:= if (exists($filiationDateFrom) and exists($filiationDateTo) and not(exists($filiationDateWhen))) 
        then string($filiationDateTo)
        else 
            if (exists($historyDateFrom) and exists($historyDateTo) and not(exists($historyDateWhen)))  
            then string($historyDateTo)
            else ()
            
    let $result := if (exists($firstDate)) 
        then 
            if (exists($secondDate) and (substring-before($firstDate, "-")) != (substring-before($secondDate, "-"))) 
            then substring-before($firstDate, "-") || "-" ||substring-before($secondDate, "-") (:Das erste und das zweite Datum existieren:)
            else substring-before($firstDate, "-") (:Nur das erste Datum existiert:)
        else () (:kein Datum existiert:)
        
    return $result
};

declare function local:remove-duplicates($items as item()*) 
as item()*
{
  for $i in $items
  

  let $personId := $i//@xml:id

  group by $personId
    return 
        <person xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$personId}">
            <persName type="full">{string-join(distinct-values($i/persName//text()), ", ")}</persName>
            
            {
                if (count(distinct-values($i/source/text())) = 1) 
                    then [<source>{$i/source/text()[1]}</source>, <dateOfTheSource>{$i/dateOfTheSource/text()[1]}</dateOfTheSource>]
                    else ()
            }

        </person>
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
            let $source := $quellenstueck//tei:seriesStmt/tei:idno/text()
            let $dateOfTheSource := local:extractDateFromSource($quellenstueck)

            let $id := if ($p//@ref) 
              then $p//@ref
              else $source || "_" || $pos

            order by $id
            return <person xml:id="{$id}">
                    <persName type="full">{$personName}</persName>
                    <source>{$source}</source>
                    <dateOfTheSource>{$dateOfTheSource}</dateOfTheSource>
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

xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:extractDateFromSource($source as item())
as xs:string
{
    (: the date of a source is extracted to be displayed on the webapplication :)
    (: a source can contain different kinds of dates :)
    (: the history date is the date when the original document was written :)
    (: The filiation date is the date when the 'copy' or 'transcript' of a document was created :)
    (: If both dates are available, only the filiation-date should be shown :)
    (: Sometimes the date is one single specific date ("when") and sometimes its a range ("from" and "to") :)
    let $historyDateWhen := $source//tei:history//tei:origin//@when
    let $historyDateFrom := $source//tei:history//tei:origin//@from
    let $historyDateTo := $source//tei:history//tei:origin//@to
    let $filiationDateWhen := $source//tei:sourceDesc//tei:filiation//@when
    let $filiationDateFrom := $source//tei:sourceDesc//tei:filiation//@from
    let $filiationDateTo := $source//tei:sourceDesc//tei:filiation//@to

    let $firstDate := 
        if (exists($filiationDateWhen)) (: a filiation date has the priority :)
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

    let $secondDate:=  (: check if a second date exists or not :)
        if (exists($filiationDateFrom) and exists($filiationDateTo) and not(exists($filiationDateWhen))) 
            then string($filiationDateTo)
            else 
                if (exists($historyDateFrom) and exists($historyDateTo) and not(exists($historyDateWhen)))  
                then string($historyDateTo)
                else ()
            
    let $result := 
        if (exists($firstDate)) 
            then 
                if (exists($secondDate) and (substring-before($firstDate, "-")) != (substring-before($secondDate, "-"))) (: reformat the date, we only need the year and not the full date. If we have a range of two dates and they have the same year, we only return one single date :)
                    then substring-before($firstDate, "-") || "-" ||substring-before($secondDate, "-") (: The first and the second date exist :)
                    else substring-before($firstDate, "-") (: Only the first date exists :)
            else () (: no date exists :)
        
    return $result
};

declare function local:remove-duplicates($items as item()*) 
as item()*
{
  for $i in $items
      let $personId := $i//@xml:id
      group by $personId (:group by the person id to remove duplicate entries :)
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
                        for $p at $pos in $quellenstueck//tei:text//tei:persName (: extract all people :)
                        let $personName := fn:normalize-space($p) (:some people contain leading or trailing spaces or line-breaks, remove them :)
                        let $source := $quellenstueck//tei:seriesStmt/tei:idno/text() (:the name of the "quellenstück" is shown in the list of people in the web application :)
                        let $dateOfTheSource := local:extractDateFromSource($quellenstueck) (:the date of the "quellenstück" is shown in the list of people in the web application :)
        
                        let $id := 
                            if ($p//@ref) (:if a person has en explicit id, use it. Otherwise generate an automatic identifier:)
                                then $p//@ref
                                else $source || "_" || $pos
        
                        order by $id
                        return 
                            <person xml:id="{$id}">
                                <persName type="full">{$personName}</persName>
                                <source>{$source}</source>
                                <dateOfTheSource>{$dateOfTheSource}</dateOfTheSource>
                            </person>
                        
                let $allWithoutDuplicates := local:remove-duplicates($all) (:People with the same identifier should only occur once in the list :)
                
                let $allOrdered := (:the list of people should be ordered alphabetically :)
                  for $i in $allWithoutDuplicates
                    order by $i//persName//text(), $i//@xml:id
                    return $i
                
                return $allOrdered
            }

        </listPerson>
    </standOff>
</TEI>

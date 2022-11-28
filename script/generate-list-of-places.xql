xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function local:finalize-entries($items as item()*) 
as item()*
{
    for $i in $items
        let $placeId := $i//@xml:id 
        let $optionalCoordinate := replace(substring-after($placeId, "LOC_"), "_", " ") (: extract the geocoordinate if there is any :)
        let $placeName := $i//text()
        group by $placeId (:group by the person id to remove duplicate entries :)
        return 
            <place xmlns="http://www.tei-c.org/ns/1.0" xml:id="{$placeId}" n="{string-join(distinct-values($placeName), ", ")}">
                {
                    let $placesTags := 
                        for $place in $i
                            let $placeName := $place//text()
                            group by $placeName
                            return <placeName type="main">{$place[1]//text()}</placeName>
                    
                    let $coordinateTag := if (fn:matches($optionalCoordinate[1], "^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?) \s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$")) (:check if the reference is a coordinate. Example format: 47.37721420014591 8.527299029687203:) 
                                            then <location><geo>{string-join($optionalCoordinate[1])}</geo></location>  
                                            else ()
                    
                    return [$placesTags, $coordinateTag]
                    
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
    </teiHeader>
    <standOff>
        <listPlace>
            
        {
            let $all := 
            let $collection := collection("/db/apps/qzh-data/quellenstuecke/")
            for $quellenstueck in $collection
            for $p at $pos in $quellenstueck//tei:text//tei:placeName (: get al places from all "quellenstücke" :)
            let $placeName := fn:normalize-space($p) (:some places contain leading or trailing spaces or line-breaks, remove them :)
            let $id :=
                if ($p//@ref) (:if a place has en explicit id, use it. Otherwise generate an automatic identifier:)
                    then $p//@ref
                    else 
                        $quellenstueck//seriesStmt/tei:idno || "_" || $pos
                        order by $id
                        return
                            <place xml:id="{$id}">
                                <placeName type="main">{$placeName}</placeName>
                            </place>
            let $allFinalized := local:finalize-entries($all) (:Removes duplicates - Places with the same identifier should only occur once in the list - and formats the geo-reference if available :)
            
            let $allOrdered := (:the list of places should be ordered alphabetically :)
                for $i in $allFinalized
                    order by $i//tei:placeName[1]//text()
                    return $i
            
            return $allOrdered
        }
        
        </listPlace>
    </standOff>
</TEI>

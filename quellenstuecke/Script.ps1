$output = "output.csv"
"Datei;Back" | Out-File $output -Encoding UTF8

Get-ChildItem -Filter *.xml | ForEach-Object {
    $xml = [xml](Get-Content $_.FullName)

    # Namespace-unabhängige Suche
    $backNode = $xml.SelectSingleNode("//*[local-name()='back']")

    if ($backNode -ne $null) {
        $backText = $backNode.InnerText.Trim()
    } else {
        $backText = ""
    }

    "$($_.Name);$backText" | Out-File $output -Append -Encoding UTF8
}

Write-Host "Fertig!"
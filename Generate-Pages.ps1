$templateContent = Get-Content -Raw index.html
$glbFiles = Get-ChildItem "*.glb"

foreach ($glb in $glbFiles) {
    $basename = $glb.BaseName
    if ($basename -eq "model") {
        continue
    }

    $newContent = $templateContent -replace 'model\.glb', "$basename.glb"
    $newContent = $newContent -replace 'data\.rdf', "$basename.rdf"
    $newContent = $newContent -replace 'model\.usdz', "$basename.usdz"
    
    $outPath = "$basename.html"
    Set-Content -Path $outPath -Value $newContent -Encoding UTF8
    Write-Host "Created $outPath"

    $rdfPath = "$basename.rdf"
    if (-not (Test-Path $rdfPath)) {
        Copy-Item -Path "data.rdf" -Destination $rdfPath
        Write-Host "Created template $rdfPath"
    }
}

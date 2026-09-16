$glbFiles = Get-ChildItem -Filter "*.glb"

foreach ($glb in $glbFiles) {
    if ($glb.Name -like "*_optimized*") {
        continue
    }
    $originalName = $glb.Name
    $tempName = "opt_" + $originalName
    Write-Host "Optimizing $originalName ..."
    npx -y gltf-pipeline -i $originalName -o $tempName -d
    if ($LASTEXITCODE -eq 0 -and (Test-Path $tempName)) {
        Remove-Item $originalName -Force
        Rename-Item $tempName $originalName
        Write-Host "Successfully optimized $originalName"
    } else {
        Write-Host "Failed to optimize $originalName"
    }
}

param([string]$Src="D:\vesselvault-attest")

$Dst = Join-Path $PSScriptRoot "attest"
New-Item -ItemType Directory -Force -Path $Dst | Out-Null

$patterns = @("manifest_*.ndjson","META_*.json","*.minisig")

Get-ChildItem -Path $Src -Recurse -File -Include $patterns |
    ForEach-Object { Copy-Item $_.FullName -Destination $Dst -Force }

cd $PSScriptRoot
git add .
$stamp = (Get-Date).ToString("yyyy-MM-ddTHH-mm-ssZ")
git commit -m "ledger update $stamp" 2>$null
git push origin main

Write-Host "[OK] Public ledger updated."

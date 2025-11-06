param(
  [string]$PhoneSrc  = "/sdcard/Download/attest",
  [string]$LocalSink = "D:\vesselvault-attest"
)

adb kill-server | Out-Null
adb start-server | Out-Null

$ok = (adb devices) -join "`n"
if ($ok -notmatch "device`r?$") { Write-Host "[!] No authorized TC56"; exit 1 }

mkdir $LocalSink -Force | Out-Null
adb pull "$PhoneSrc" "$LocalSink" | Out-Null

pwsh -File "$PSScriptRoot\push-ledger.ps1" -Src "$LocalSink"
Write-Host "[OK] End-to-end ledger update complete."

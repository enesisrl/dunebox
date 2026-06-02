#requires -Version 5.1
<#
.SYNOPSIS
  Zippa i pacchetti Dunebox (bin/ apps/) e li pubblica come asset di una GitHub Release.
.DESCRIPTION
  Legge il manifest del repo `dunebox` (sorgente di verita' del catalogo), zippa il
  CONTENUTO di ogni cartella `target` (convenzione: l'installer estrae in <root>/<target>)
  e crea/aggiorna la Release con tag dato, caricando gli asset.
  Prerequisito: `gh auth login` gia' eseguito.
.EXAMPLE
  .\publish-releases.ps1
.EXAMPLE
  .\publish-releases.ps1 -Only php-8.2,apache -SkipUpload
#>
[CmdletBinding()]
param(
  [string]   $Manifest = (Join-Path $PSScriptRoot "..\dunebox\crates\core\embed\manifest.json"),
  [string]   $Tag      = "packages-v1",
  [string]   $Repo     = "kabirferro/dunebox-packages",
  [string]   $OutDir   = (Join-Path $PSScriptRoot ".dist"),
  [string[]] $Only,
  [switch]   $SkipUpload
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

if (-not (Test-Path -LiteralPath $Manifest)) { throw "manifest non trovato: $Manifest" }
$mf = Get-Content -Raw -LiteralPath $Manifest | ConvertFrom-Json
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$components = $mf.components
if ($Only) { $components = $components | Where-Object { $Only -contains $_.name } }

# --- Zip ---
$assets = New-Object System.Collections.Generic.List[string]
foreach ($c in $components) {
  $srcDir = Join-Path $PSScriptRoot $c.target
  if (-not (Test-Path -LiteralPath $srcDir)) {
    Write-Warning "salto '$($c.name)': manca la cartella $($c.target)"
    continue
  }
  $zip = Join-Path $OutDir $c.archive
  if (Test-Path -LiteralPath $zip) { Remove-Item -LiteralPath $zip -Force }
  Write-Host "zip  $($c.name)  ->  $($c.archive)"
  # includeBaseDirectory:$false => lo zip contiene il CONTENUTO di target (no cartella)
  [System.IO.Compression.ZipFile]::CreateFromDirectory(
    $srcDir, $zip, [System.IO.Compression.CompressionLevel]::Optimal, $false)
  $assets.Add($zip)
}
Write-Host "Creati $($assets.Count) archive in $OutDir"

if ($SkipUpload) { Write-Host "Upload saltato (-SkipUpload)."; return }

# --- Verifica gh ---
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "gh non installato (winget install GitHub.cli)" }
gh auth status *> $null
if ($LASTEXITCODE -ne 0) { throw "gh non autenticato: esegui 'gh auth login'" }

# --- Release ---
# Esistenza: lo stderr "release not found" di gh non deve diventare errore terminante
# (ErrorActionPreference='Stop'), quindi si controlla solo $LASTEXITCODE.
$prev = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
gh release view $Tag --repo $Repo 1>$null 2>$null
$releaseExists = ($LASTEXITCODE -eq 0)
$ErrorActionPreference = $prev

if (-not $releaseExists) {
  Write-Host "creo la release '$Tag' su $Repo"
  gh release create $Tag --repo $Repo --title "Dunebox packages" --notes "Pacchetti Dunebox (asset = bin/apps customizzati)."
}
foreach ($a in $assets) {
  Write-Host "upload $(Split-Path $a -Leaf)"
  gh release upload $Tag $a --repo $Repo --clobber
}
Write-Host "Fatto: $($assets.Count) asset pubblicati sulla release '$Tag'."

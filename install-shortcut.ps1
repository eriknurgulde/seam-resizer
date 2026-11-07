# Creates "Seam Resizer" shortcuts (Desktop + Start menu, hotkey Ctrl+Alt+R)
# that open seam-resizer.html from this folder in its own full-screen window.
# It only creates shortcut files; nothing else on your PC is changed.

$ErrorActionPreference = 'Stop'
$html = Join-Path $PSScriptRoot 'seam-resizer.html'
if (-not (Test-Path $html)) {
    Write-Host "Could not find seam-resizer.html next to this script." -ForegroundColor Red
    Read-Host "Press Enter to close"
    exit 1
}
$url = 'file:///' + ($html -replace '\\', '/')

# Prefer Microsoft Edge (built into Windows) in "app mode"; fall back to Chrome, then the default browser.
$candidates = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$browser = $candidates | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1

$shell = New-Object -ComObject WScript.Shell
$targets = @(
    @{ Path = Join-Path ([Environment]::GetFolderPath('Desktop')) 'Seam Resizer.lnk'; Hotkey = 'CTRL+ALT+R' },
    @{ Path = Join-Path ([Environment]::GetFolderPath('Programs')) 'Seam Resizer.lnk'; Hotkey = '' }
)
foreach ($t in $targets) {
    $s = $shell.CreateShortcut($t.Path)
    if ($browser) {
        $s.TargetPath = $browser
        $s.Arguments = "--app=`"$url`" --start-maximized"
    } else {
        $s.TargetPath = $html
    }
    $s.WorkingDirectory = $PSScriptRoot
    $s.IconLocation = "$env:SystemRoot\System32\imageres.dll,67"
    $s.Description = 'Content-aware image resizer'
    $s.WindowStyle = 3
    if ($t.Hotkey) { $s.Hotkey = $t.Hotkey }
    $s.Save()
    Write-Host "Created: $($t.Path)"
}
Write-Host ""
Write-Host "Done! Open Seam Resizer from your Desktop, the Start menu, or press Ctrl+Alt+R." -ForegroundColor Green
Read-Host "Press Enter to close"

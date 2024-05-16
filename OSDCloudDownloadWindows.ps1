$json = Invoke-WebRequest 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json' | ConvertFrom-Json
$WinVersions = $json | ForEach-Object { $_.OSNameValues }

Clear-Host
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " Select a Windows version:"

$Menu = @{}
$WinVersions | ForEach-Object -Begin {$i = 1} { 
     Write-Host " $i.) $_" 
     $Menu.add("$i",$_)
     $i++
}

Write-Host " Q.) Back"

$Selection = Read-Host " Select an option and press Enter"

if ($Selection -eq 'Q') { Return } Else { $Menu.$Selection }

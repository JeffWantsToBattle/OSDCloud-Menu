$json = Invoke-WebRequest 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json' | ConvertFrom-Json
$WinVer = $json | ForEach-Object { $_.OSNameValues }
$winVer = $WinVer.Replace(" x64", "")
$WinLang = $json | ForEach-Object { $_.OSLanguageValues }

Clear-Host
Write-Host " ***************************"
Write-Host " *         OSDCloud        *"
Write-Host " ***************************"
Write-Host
Write-Host " Select a Windows version:"

$Menu = @{}
$WinVer | ForEach-Object -Begin {$i = 1} { 
     Write-Host " $i.) $_" 
     $Menu.add("$i",$_)
     $i++
}

Write-Host " Q.) Back"

$WinVerSelection = Read-Host " Select an option and press Enter"

if ($WinVerSelection -eq 'Q') { 
     Invoke-WebPSScript 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/OSDCloudStartURL.ps1'
} Else { 
     Update-OSDCloudUSB -OSName $Menu.$WinVerSelection -OSLanguage nl-nl -OSLicense Retail
}

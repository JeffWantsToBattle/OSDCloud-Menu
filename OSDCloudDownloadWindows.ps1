$json = Invoke-WebRequest 'https://raw.githubusercontent.com/JeffWantsToBattle/OSD/main/Update/Automate/Start-OSDCloudGUI.json' | ConvertFrom-Json
$WinVer = $json | ForEach-Object { $_.OSNameValues }
$WinLang = $json | ForEach-Object { $_.OSLanguageValues }
$Win

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
     Return 
} Else { 
     Write-Host $Menu.$WinVerSelection
}


#Update-OSDCloudUSB -OSName "Windows 11 23H2" -OSLanguage nl-nl -OSLicense Retail

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

$MenuVer = @{}
$WinVer | ForEach-Object -Begin {$i = 1} { 
     Write-Host " $i.) $_" 
     $MenuVer.add("$i",$_)
     $i++
}

Write-Host " Q.) Back"

$WinVerSelection = Read-Host " Select an option and press Enter"

$MenuLang = @{}
$WinLang | ForEach-Object -Begin {$i = 1} { 
     Write-Host " $i.) $_" 
     $MenuLang.add("$i",$_)
     $i++
}

Write-Host " Q.) Back"

$WinLangSelection = Read-Host " Select an option and press Enter"

if ($WinLangSelection -eq 'Q') { 
     Return 
} Else { 
     Write-Host $MenuVer.$WinVerSelection
     Write-Host $menuLang.$WinLangSelection
     
     Update-OSDCloudUSB -OSName $MenuVer.$WinVerSelection -OSLanguage nl-nl -OSLicense Retail
}
